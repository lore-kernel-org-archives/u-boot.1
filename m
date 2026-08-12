Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155D5C5CFEB
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 10:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D241811B6;
	Wed, 12 Aug 2026 10:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xq4rgNprkAY8; Wed, 12 Aug 2026 10:40:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C028B81103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786531211;
	bh=7leUNM83h7okTgkG9QD4P8nGtP1clI4xCKJsslLbIIc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=orjzebJQqz4rn6qTrWwtqCW+Tj3yThG2imEvS4Sbx63qnorBvoujAGHMLsypM9Ljz
	 Pvh5h2vv48thE9tVlVWySUaPZ95fmnPGMaNnLjpxexp1p1v16DxBRkNTkVqZWoBXmT
	 eqe/y2/VPbIES+e3zQ8qsb7CYd5q8/yXZVF4g4dIuyg0iY+8+W+5dIgrZkeS10Kz2a
	 mejnSJUD+YJ6wqkrmIe8SdUrdPLeSHFUG9K582+89z3ND0hnaCSz5YxikGRQK267Ex
	 buTO4KpbVE31oKML0ex7EhS7Wi1WGDW7BuD/JFtJirbTc8LVlxROvdiiNVEaeOKaVm
	 ayPidku+J+uRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C028B81103;
	Wed, 12 Aug 2026 10:40:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46FEF1AF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D2C981103
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgxl9Nxvt1rg for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 10:40:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::bc0f; helo=smtp-bc0f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 516C681024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 516C681024
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 516C681024
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:40:08 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKlPL5YCkz3JK;
 Wed, 12 Aug 2026 12:40:06 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKlPK5tr3zmJ5; Wed, 12 Aug 2026 12:40:05 +0200 (CEST)
Message-ID: <a27ec69a-30a0-45bf-8eac-77344670053b@0leil.net>
Date: Wed, 12 Aug 2026 12:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-5-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260803190946.2259514-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786531206;
 bh=7leUNM83h7okTgkG9QD4P8nGtP1clI4xCKJsslLbIIc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eYUgNlD03MMMxPOin/lD8nQ710ELjLBIWxfXSmXkEvhTJaKOAXpiViCGsct0LSd5g
 cDKqUQXlZ6UszgW5FDIhGUN4YUj7xTd8/ikiX+M2hmW5ltPcQG+dt0EJapri+fQ7Tc
 3jd1e+2xgBu0EA7VE8bCdVRHdBNEafIz6DNmeZaOGhNZUQmLytj5NwgnRRI8N4j6kz
 k05z440DglqIRUAptS2y5woxDIEfD4OcCfEXVEhoQljIWj0sDxrSY1DrZiOm/9hjcy
 HeZ9k5EDK0rUJucgllLTJJmpGza2jWIbD0i9THaA4ogDHdy1VFMDVQRGnLnh9VjQYU
 VNAgp/6e9M8Jw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=eYUgNlD0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 9:09 PM, Jonas Karlman wrote:
> The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
> force use of 32 KHz or 400 KHz rates when any requested rate is
> divisible with 32 KHz or 400 KHz.
> 
> Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
> limitation of the CLK_SARADC clock in RK3506.
> 

Same typo as previous patch, it's MHz and not GHz. Same remark as 
previous patch, the divider applies to any of the parent clock so the 
1.5-24MHz is kinda misleading.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
> index 457082eea87b..e156bf19a6b4 100644
> --- a/drivers/clk/rockchip/clk_rk3506.c
> +++ b/drivers/clk/rockchip/clk_rk3506.c
> @@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
>   {
>   	u32 con, div, sel;
> -	ulong prate;
>   
>   	con = readl(RK3506_CLKSEL_CON(54));
>   	sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
>   	div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
>   
>   	if (sel == CLK_SARADC_SEL_24M)
> -		prate = OSC_HZ;
> +		return DIV_TO_RATE(OSC_HZ, div);
>   	else if (sel == CLK_SARADC_SEL_400K)
> -		prate = 400000;
> +		return 400000;
>   	else if (sel == CLK_SARADC_SEL_32K)
> -		prate = 32000;
> +		return 32000;
>   	else
>   		return -EINVAL;
> -
> -	return DIV_TO_RATE(prate, div);

I'm not sure this is correct. The divider applies to any parent clock 
and this applies the divider only to the 24MHz parent clock.

>   }
>   
>   static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
> @@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>   {
>   	u32 div, sel;
>   
> -	if (32000 % rate == 0) {
> +	if (rate <= 32768) {
>   		sel = CLK_SARADC_SEL_32K;
>   		div = 1;
> -	} else if (400000 % rate == 0) {
> +	} else if (rate == 400000) {
>   		sel = CLK_SARADC_SEL_400K;
>   		div = 1;

This is also not correct.

I think what you want instead is to modify div to not be always 1 but 
rather 32000 / rate and 4000000 / rate.

Cheers,
Quentin
