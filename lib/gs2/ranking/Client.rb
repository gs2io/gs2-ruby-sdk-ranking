require 'gs2/core/AbstractClient.rb'

module Gs2 module Ranking
  
  # GS2-Ranking クライアント
  #
  # @author Game Server Services, Inc.
  class Client < Gs2::Core::AbstractClient
  
    @@ENDPOINT = 'ranking'
  
    # コンストラクタ
    # 
    # @param region [String] リージョン名
    # @param gs2_client_id [String] GSIクライアントID
    # @param gs2_client_secret [String] GSIクライアントシークレット
    def initialize(region, gs2_client_id, gs2_client_secret)
      super(region, gs2_client_id, gs2_client_secret)
    end
    
    # デバッグ用。通常利用する必要はありません。
    def self.ENDPOINT(v = nil)
      if v
        @@ENDPOINT = v
      else
        return @@ENDPOINT
      end
    end

    # ランキングテーブルリストを取得
    # 
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * rankingTableId => ランキングテーブルID
    #       * ownerId => オーナーID
    #       * name => ランキングテーブル名
    #       * description => 説明文
    #       * createAt => 作成日時
    #       * updateAt => 更新日時
    #   * nextPageToken => 次ページトークン
    def describe_ranking_table(pageToken = nil, limit = nil)
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Ranking', 
            'DescribeRankingTable', 
            @@ENDPOINT, 
            '/ranking',
            query);
    end
    
    # ランキングテーブルを作成<br>
    # <br>
    # GS2-Ranking を利用するには、まずランキングテーブルを作成する必要があります。<br>
    # 1つのランキングテーブルには複数のゲームモードのランキングを格納することができます。<br>
    # 
    # @param request [Array]
    #   * name => ランキングテーブル名
    #   * description => 説明文
    # @return [Array]
    #   * item
    #     * rankingTableId => ランキングテーブルID
    #     * ownerId => オーナーID
    #     * name => ランキングテーブル名
    #     * description => 説明文
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def create_ranking_table(request)
      if not request; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('description'); body['description'] = request['description']; end
      query = {}
      return post(
            'Gs2Ranking', 
            'CreateRankingTable', 
            @@ENDPOINT, 
            '/ranking',
            body,
            query);
    end
  
    # ランキングテーブルを取得
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    # @return [Array]
    #   * item
    #     * rankingTableId => ランキングテーブルID
    #     * ownerId => オーナーID
    #     * name => ランキングテーブル名
    #     * description => 説明文
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def get_ranking_table(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Ranking',
          'GetRankingTable',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'],
          query);
    end
  
    # ランキングテーブルを更新
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * description => 説明文
    # @return [Array] 
    #   * item
    #     * rankingTableId => ランキングテーブルID
    #     * ownerId => オーナーID
    #     * name => ランキングテーブル名
    #     * description => 説明文
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def update_ranking_table(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('description'); body['description'] = request['description']; end
      query = {}
      return put(
          'Gs2Ranking',
          'UpdateRankingTable',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'],
          body,
          query);
    end
    
    # ランキングテーブルを削除
    # 
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    def delete_ranking_table(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Ranking', 
            'DeleteRankingTable', 
            @@ENDPOINT, 
            '/ranking/' + request['rankingTableName'],
            query);
    end
  
    # ゲームモードリストを取得
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * gameModeId => ゲームモードID
    #       * rankingTableId => ランキングテーブルID
    #       * gameMode => ゲームモード名
    #       * ownerId => オーナーID
    #       * asc => ソート方向
    #       * calcInterval => 集計間隔(分)
    #       * lastCalcAt => 最終集計日時
    #       * createAt => 作成日時
    #       * updateAt => 更新日時
    #   * nextPageToken => 次ページトークン
    def describe_game_mode(request, pageToken = nil, limit = nil)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
          'Gs2Ranking',
          'DescribeGameMode',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode',
          query);
    end
    
    # ゲームモードを作成<br>
    # <br>
    # ゲームモードを作成すると、ゲームモードの設定としてランキングが昇順なのか、降順なのかを設定できます。<br>
    # レースゲームのようなタイムの値が小さいほど上位のランキングの場合は昇順を、<br>
    # アクションゲームなどで、スコアの値が大きいほど上位のランキングの場合は降順を選択します。<br>
    # <br>
    # 他に、集計間隔を15分以上、24時間以下で分単位で設定できます。<br>
    # ランキングを更新したい間隔に合わせて設定することになります。<br>
    # 集計処理毎に費用が発生するため、高頻度であればあるほど利用料金は高くなります。<br>
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    #   * asc => ソート方向
    #   * calcInterval => 集計間隔(分)
    # @return [Array]
    #   * item
    #     * gameModeId => ゲームモードID
    #     * rankingTableId => ランキングテーブルID
    #     * gameMode => ゲームモード名
    #     * ownerId => オーナーID
    #     * asc => ソート方向
    #     * calcInterval => 集計間隔(分)
    #     * lastCalcAt => 最終集計日時
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def create_game_mode(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('gameMode'); body['gameMode'] = request['gameMode']; end
      if request.has_key?('asc'); body['asc'] = request['asc']; end
      if request.has_key?('calcInterval'); body['calcInterval'] = request['calcInterval']; end
      query = {}
      return post(
          'Gs2Ranking',
          'CreateGameMode',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode',
          body,
          query);
    end
    
    # ゲームモードを取得
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    # @return [Array]
    #   * item
    #     * gameModeId => ゲームモードID
    #     * rankingTableId => ランキングテーブルID
    #     * gameMode => ゲームモード名
    #     * ownerId => オーナーID
    #     * asc => ソート方向
    #     * calcInterval => 集計間隔(分)
    #     * lastCalcAt => 最終集計日時
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def get_game_mode(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Ranking',
          'GetGameMode',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'],
          query);
    end
    
    # ゲームモードを更新
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    #   * calcInterval => 集計間隔(分)
    # @return [Array] 
    #   * item
    #     * gameModeId => ゲームモードID
    #     * rankingTableId => ランキングテーブルID
    #     * gameMode => ゲームモード名
    #     * ownerId => オーナーID
    #     * asc => ソート方向
    #     * calcInterval => 集計間隔(分)
    #     * lastCalcAt => 最終集計日時
    #     * createAt => 作成日時
    #     * updateAt => 更新日時
    def update_game_mode(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('calcInterval'); body['calcInterval'] = request['calcInterval']; end
      query = {}
      return put(
          'Gs2Ranking',
          'UpdateGameMode',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'],
          body,
          query);
    end
    
    # ゲームモードを削除
    # 
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    def delete_game_mode(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      query = {}
      return delete(
          'Gs2Ranking',
          'DeleteGameMode',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'],
          query);
    end
    
    # ランキングを取得<br>
    # <br>
    # ランキングを取得します。<br>
    # ランキングにはユーザID、スコア、メタデータといった基本情報のほかに、インデックスと順位が付加されています。<br>
    # インデックスは先頭を1とした位置情報で、順位は同一スコアのユーザを同一順位として計算された値です。<br>
    # ランキングの性質上、同一スコアでも別順位として扱いたい場合は順位の代わりにインデックスを利用することで実現できます。<br>
    # <br>
    # ランキングデータはランダムアクセスができますので、{#get_my_rank} で自分の順位を取得して、<br>
    # その前後のランキンデータを取得する。というような処理も実現できます。<br>
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    # @param offset [Integer] 取得開始オフセット
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * index => インデックス
    #       * rank => 順位
    #       * userId => ユーザID
    #       * score => スコア
    #       * meta => メタ情報
    #       * updateAt => 更新日時
    #   * nextPageToken => 次ページトークン
    def get_ranking(request, offset = nil, limit = nil)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      query = {}
      if offset; query['offset'] = offset; end
      if limit; query['limit'] = limit; end
      return get(
          'Gs2Ranking',
          'GetRanking',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'] + '/ranking',
          query);
    end
    
    # スコアを登録<br>
    # <br>
    # スコアの登録は一時的にバッファリングされ、定期的にランキングデータとして書き込まれます。<br>
    # そのため、スコア登録直後にランキング集計が開始された場合は、集計結果に含まれない可能性があります。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    #   * score => スコア
    #   * meta => メタ情報
    #   * accessToken => アクセストークン
    # @return [Array] 
    #   * item
    #     * rankingTableId => ランキングテーブルID
    #     * gameMode => ゲームモード名
    #     * userId => ユーザID
    #     * score => スコア
    #     * meta => メタ情報
    #     * updateAt => 更新日時
    def put_score(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('score'); body['score'] = request['score']; end
      if request.has_key?('meta'); body['meta'] = request['meta']; end
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      query = {}
      return post(
          'Gs2Ranking',
          'PutScore',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'] + '/ranking',
          body,
          query,
          header);
    end
  
    # 自分の順位を取得<br>
    # <br>
    # 自分の順位を取得できます、応答される値は集計時点での正確な値となります。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    #   * accessToken => アクセストークン
    # @return [Array] 
    #   * index => インデックス
    #   * rank => 順位
    def get_my_rank(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      query = {}
      return get(
          'Gs2Ranking',
          'GetMyRank',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'] + '/ranking/rank',
          query,
          header);
    end
  
    # スコアを指定しておおよその順位を取得<br>
    # <br>
    # 指定したスコアを取ったと仮定して何位ぐらいになれるのか、といった指標を計算する際に利用します。<br>
    # 原則1000位単位でおおよその順位を応答します。<br>
    # <br>
    # 上位プレイヤーに対しては1000位単位の解像度では情報が不足している場合があると思いますので、<br>
    # 応答が上位プレイヤーだった場合は、更に {#get_ranking} で上位のスコアを取得して<br>
    # さらに詳細な順位に絞り込んで情報提供する。というのもユーザ体験をよく出来ると思います。<br>
    #
    # @param request [Array]
    #   * rankingTableName => ランキングテーブル名
    #   * gameMode => ゲームモード名
    #   * score => スコア
    # @return [Array] 
    #   * min => おおよその順位の最小値
    #   * max => おおよその順位の最大値
    def get_estimate_rank(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('rankingTableName'); raise ArgumentError.new(); end
      if not request['rankingTableName']; raise ArgumentError.new(); end
      if not request.has_key?('gameMode'); raise ArgumentError.new(); end
      if not request['gameMode']; raise ArgumentError.new(); end
      query = {}
      if request.has_key?('score'); query['score'] = request['score']; end
      return get(
          'Gs2Ranking',
          'GetEstimateRank',
          @@ENDPOINT,
          '/ranking/' + request['rankingTableName'] + '/mode/' + request['gameMode'] + '/ranking/estimate',
          query);
    end
  end
end end