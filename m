Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBC606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NKp0Aet+;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ZZePw9z+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8063F407C9;
	Fri, 13 Nov 2026 14:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxnCI0aCrdA3; Fri, 13 Nov 2026 14:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EC7B405CD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794581106;
	b=I8p6lczB/vqFac6wvh0CZtLj69ujRympVE1J2FZbJgij3p7Y4yGjlyRvGQOwfQ5y7tYg
	 SeCkDrdCa3+55DLhsvI9OPrdTp08vzYUdpphcg7TuUdpJBqJGzaQEo8wzDXZaICVwukd7
	 eWfj9NlEYo9d6hmddzYTo8ZnAd0oCmad+qOVQpxibb7saRN43miZSyXr5raoLN/m4meNj
	 3kkO6fYbdWrudAX/nRp3NcsAfJXZmHT7tg2BQClGuY+QGIp73Vq0/JvWIm7lSgzJYJvwN
	 uIQGFR8AJ6nICgpYNM0hvrgXpekZU0wkHcUM4p56QKPop3A7x1/qcrc01ms5sp2Q0Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794581106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A3VOdEqA9rmzjX0iN7Ef5D+tykCkvNmMOEgVsN3xzKs=;
	b=lXMmKVkJeNwysvBc2MzyQYlZKZPfBKnIe3sQOc8jxfIKKw35BWkTAWq1wd2vXM0pDMoH
	 GxeugxQ3+ANm/46z+jNKM3cVTdyDhna/BVwdc0MAPvsAHiNHl/acAdTy79VLkJnP3rzqZ
	 H2fA7224kLkW45tJaS4Eho41ra7p6YOW8nrL0FwV9ra6x+RGZDOdSet03rBxkJsfdzeAx
	 RLMG/U8shN1GtsUMZ4lp5/j2mhfAyuyvejueBnqteggESmf5rmCMUE8zuGzoW6MJqoS/M
	 u5bb/7yccQXqT+YIjcnGRynDfIEEAMwatZqJ+BEtGSCYmYaO6lG1gFtuwfy1oDaKpqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794581106;
	bh=A3VOdEqA9rmzjX0iN7Ef5D+tykCkvNmMOEgVsN3xzKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKp0Aet+zQDyoZGjhoajyU/l9QWsswfbOYQ7/gkvsZAl9d+veL8D4oXNSGwKC9+k9
	 mlSv56u/81KvH9HV8SLkOO/rcYpUaZ9KxhQI5m1pHFnqZIFXDAoDlyDm4r4l/cKVtd
	 OKWBQgWDzjQB4UP37uQt2E5++eTzQl5/1I/3AQGRNwzxoSpMDcGMLh+GVtKwMSBxOu
	 b658HmohIoB72HiewSOiCCNuitAGNLB0gkTsxeudK6fFp4YRswL6fHAWGt4ceQzZ+B
	 zGUinWBGbAZByStaGMMaI/obWLlauXdCNaZxS9bDrWMO+USaA6hThFTYgW8r/OKtL5
	 LzOJGRik33/wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EC7B405CD;
	Fri, 13 Nov 2026 14:45:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 131AC178F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED7758167A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LRHef4nAHAqI for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 14:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9EBF281674
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=83.166.143.170
X-Greylist: delayed 465 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 14:45:04 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ZZePw9z+
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.170;
 helo=smtp-8faa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EBF281674
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:45:03 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR0G36cnQz1xw;
 Fri, 13 Nov 2026 15:37:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794580635;
 bh=A3VOdEqA9rmzjX0iN7Ef5D+tykCkvNmMOEgVsN3xzKs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZZePw9z+N2REVwMoJEyGKB5MlkkR8Ju4lo6/+HOAr68MqlauZt4V/gfPti4u7fotc
 cYhOzMp4OkKLU5tGE9v65E+Q8S8KO/LLmhnR1+LB0J5HlBNXsc6PKXCOxIsv9lB/Q2
 C9ERXSNqVe1p/SS8rA9UYUUwqngaMFR1Qwgsx4cjoDv4Z5jIczF3y07irRVaHIHjph
 17Pntxjz/6FnQ9UcORZatEf8fHLTW+r9sNAa32EnRcmE9m7scOUux6dt6Ezist87s7
 jSXYu2P28/+k7soPGMF+hhzkDfphD3Yejwux0z+X+6Jccr0GkXGTUscWe9DfSFSiNZ
 GOD/PCR0Xqmtg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR0G20kn7zcqw; Fri, 13 Nov 2026 15:37:13 +0100 (CET)
Message-ID: <1441887c-92d4-45b4-8286-c3a65b58c14e@0leil.net>
Date: Fri, 13 Nov 2026 15:37:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] clk: rockchip: rk3568: Remove unnecessary
 clk_set_defaults() call
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261027224742.2527550-1-jonas@kwiboo.se>
 <20261027224742.2527550-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261027224742.2527550-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/27/26 11:47 PM, Jonas Karlman wrote:
> Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
> node of the clock it sets up"), first included in v2020.01-rc2, added
> a clock-uclass post_probe() hook that applies clock controllers own
> assigned clocks.
> 
> Remove the redundant clk_set_defaults() call from the RK3568 clock
> driver probe() ops. Also remove the unused sync_kernel field that only
> recorded whether assigned clocks had been applied.
> 
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 1 -
>   drivers/clk/rockchip/clk_rk3568.c               | 9 ---------
>   2 files changed, 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> index d72f241d0150..8af2c5be1ba4 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> @@ -53,7 +53,6 @@ struct rk3568_clk_priv {
>   	ulong armclk_hz;
>   	ulong armclk_enter_hz;
>   	ulong armclk_init_hz;
> -	bool sync_kernel;
>   	bool set_armclk_rate;
>   };
>   
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index c3973215c37e..fd7e69ee338a 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2873,7 +2873,6 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
>   {
>   	int ret;
>   
> -	priv->sync_kernel = false;
>   	if (!priv->armclk_enter_hz) {
>   		priv->armclk_enter_hz =
>   			rockchip_pll_get_rate(&rk3568_pll_clks[APLL],
> @@ -2912,17 +2911,9 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
>   static int rk3568_clk_probe(struct udevice *dev)
>   {
>   	struct rk3568_clk_priv *priv = dev_get_priv(dev);
> -	int ret;
>   
>   	rk3568_clk_init(priv);
>   


There was some issues in the git context here due to missing 
https://lore.kernel.org/u-boot/20261011222930.1085075-36-jonas@kwiboo.se/ 
when applying. I fixed the issue when applying but just wanted to let 
you know.

Cheers,
Quentin
