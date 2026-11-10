Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8975606A336
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l4et47mM;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=AXrf3kYO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F8234088F;
	Tue, 10 Nov 2026 17:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5EhkGI_o3WU; Tue, 10 Nov 2026 17:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9637440874
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794331801;
	b=CE0ugK9c/96B6h9HehL3a5SMS5jJB6rjrIP7pgMCQJBKpGx9CtZFUeQqLg1fLA05Eb+9
	 ffiuxNHWzAB4Bng4Wz/Gs9IUOxZcu5CUFr6kA2livFHBi4Wr/KHvQdyas43WQvV+Hpo8U
	 zj5xXo9YfEcOpE9lTbbUhR5x51qlm9LfW9sooJwYWIN9GCziEG+1jFi5axWIzo15kBbMa
	 sGiWFVwrmAwYwRd+Iz0KL9V7o8KEbbryWVeGC/DfwVUk5xvu/PV+hrlItVFat8+8bghAB
	 nLKfqX9Blcha7KxgUH+ewT5V/OK2fwYmz0SftFsTsgc7Qgvy7ESXef8uLrjfBQp7TBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794331801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WFuR/8gn8XbxQX4a1czZOhGq0bZARp0pgmN7LzKKtmQ=;
	b=Ch0x2lV+i9I/bTLBOYzf1zs0XXuL/3fNuZCpqZN6IVjKKGHbfrYRWNB9wmORihPOAdPy
	 tARj96YGNN/kTT5NEzBWNeCzeS7jJGyLcfmc3PPwlLufeeUQIcJk2bdeyWnaHzKFZMo2d
	 BcDnXWdZHTm6InDWpVozNEWWesULkQh2pbjWO2giWGBFn7GGKtad0IaINiflFZEXOAUP/
	 MEnAUB73y3cElxS031kmOoe3U+9Bhk2tEB7SgfkRkupOqhXuZR2eAiP1sQLhQnMD7UxEV
	 eFKk7FN5GPBXMCtdnhM2htENbDFHPoixgks9yIovn9AqFuZJcH/i7JcoNfNKVL3YxTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794331801;
	bh=WFuR/8gn8XbxQX4a1czZOhGq0bZARp0pgmN7LzKKtmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l4et47mMpEP27BLxfq6WAhQ+Mmy8UKPd8Uw4NAso6WQTXbVFIdylrdoRWTGe79ZcF
	 Y41NkHeU6KQDDHMg/mR7+w201uTDxU9Ua6DeGqyE+6HOhYy66a9JESmtTv2NVjjjtD
	 lSZ9FUcfH8V2thcb3jnzuPEZh/QolYOHbWZO7Kb01CEhZ2Psn/ZR7geS1zrtKf/CFl
	 QvsMNzsDlyJdsfravVDaGNFPl1Q7edl3LeP/lHm++lyX6LpB7J00W41z6/Dqu/HxDc
	 TL74tM57b4caRC6Kw8VBIgXHARXccIeik28lEGIFZk4flvcYmEe0S3Eiv5D6dU1HWG
	 tWtPBa8si4zVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9637440874;
	Tue, 10 Nov 2026 17:30:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5621388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E206D810F0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVs7B3vFE426 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 17:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E7AD810DD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7b12=ja=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=AXrf3kYO
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E7AD810DD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794331796;
 bh=WFuR/8gn8XbxQX4a1czZOhGq0bZARp0pgmN7LzKKtmQ=;
 b=AXrf3kYOS0logP9gyYDwEjD3mDHfaQIbgz4BDnlnAwYOhlGkZuj/vUeMwgC809lptBk2cF3hX
 ae3/PUZNpAkAl4P/dYDXvBa9ROP0MDOYBpUQ6JtpCO3Xcy6hI5TGUvQ6v2qePc7N+3ogc6ft9jI
 FHfcbNnwus0lU1skIPvfBMG/GpHQO5nY1ArzCZNygB1xwQjaywuEvTZ7JDTuVRjZyZglnRkpCCr
 twkSPItV6Yik/yD0ZQNBlH7ZnJomjqJ0p0836kFVE+HqmCVckhG0sGd0nnBOov3ElAeCiV/X/vp
 sGBsh+UgZE2cuHVtl/oi+GE233RuP3sXvbGzSFATxjxA==
X-Forward-Email-ID: 6af3548b1cae2d46f43fb4ed
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <672d8b9e-079e-4705-bbb3-e26a3983195f@kwiboo.se>
Date: Tue, 10 Nov 2026 18:29:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk356x: Set twice the SD/SDIO card clock
To: "iav@iav.lv" <iav@iav.lv>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261110-rk3568-sdmmc-clk-v1-1-482eeb42f571@iav.lv>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261110-rk3568-sdmmc-clk-v1-1-482eeb42f571@iav.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 11/10/2026 5:30 AM, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> The dw_mmc controllers divide their input clock by 2, but
> rk3568_sdmmc_set_clk() selects a parent equal to the requested card
> clock, so the card runs at half of it: 25 MHz instead of 50 MHz in high
> speed mode. The RK3399 and RK3328 clock drivers already set twice the
> rate for their dw_mmc controllers.

This 2x clock rate should not be handled in the clock drivers, it should
similar to Linux be handled in the rockchip dw_mmc driver. The Linux driver
seem to use RK3288_CLKGEN_DIV (2) to request the 2x rate, something like:

	cclkin = ios->clock * RK3288_CLKGEN_DIV;

	ret = clk_set_rate(host->ciu_clk, cclkin);

Please instead fix the U-Boot rockchip dw_mmc driver to do something similar
and move current 2x handling from rk3399 and rk3328 clock drivers.

We should expect the clock drivers to report correct rate for a clock and
not use it to workaround quirks in device drivers.

Regards,
Jonas

> 
> Select the fastest parent that does not exceed twice the requested
> rate, or the slowest one, and report half of the parent rate.
> 
> On ODROID-M1 with a SanDisk 128 GB card in high speed mode, reading
> 512 MiB with mmc read takes 22 s instead of 44 s.
> 
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on ODROID-M1 with this change on v2026.07: CLKSEL_CON(30) selects
> the 100 MHz parent for a 50 MHz card clock. The CRC32 of a 512 MiB block
> read with mmc read is the same at 25 and 50 MHz, and the CRC32 of another
> block is the same as computed in Linux. With the SPL erased from SPI, SPL
> and U-Boot load from the SD card, also after two resets with sysrq-b.
> ---
>  drivers/clk/rockchip/clk_rk3568.c | 43 +++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 181917cf92a..06d7d4741c6 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -1426,19 +1426,20 @@ static ulong rk3568_sdmmc_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
>  		return -ENOENT;
>  	}
>  
> +	/* The card clock is half of the parent: dw_mmc divides it by 2 */
>  	switch (sel) {
>  	case CLK_SDMMC_SEL_24M:
> -		return OSC_HZ;
> +		return OSC_HZ / 2;
>  	case CLK_SDMMC_SEL_400M:
> -		return 400 * MHz;
> +		return 400 * MHz / 2;
>  	case CLK_SDMMC_SEL_300M:
> -		return 300 * MHz;
> +		return 300 * MHz / 2;
>  	case CLK_SDMMC_SEL_100M:
> -		return 100 * MHz;
> +		return 100 * MHz / 2;
>  	case CLK_SDMMC_SEL_50M:
> -		return 50 * MHz;
> +		return 50 * MHz / 2;
>  	case CLK_SDMMC_SEL_750K:
> -		return 750 * KHz;
> +		return 750 * KHz / 2;
>  	default:
>  		return -ENOENT;
>  	}
> @@ -1448,34 +1449,22 @@ static ulong rk3568_sdmmc_set_clk(struct rk3568_clk_priv *priv,
>  				  ulong clk_id, ulong rate)
>  {
>  	struct rk3568_cru *cru = priv->cru;
> +	ulong parent = rate * 2;
>  	int src_clk;
>  
> -	switch (rate) {
> -	case OSC_HZ:
> -	case 26 * MHz:
> -	case 25 * MHz:
> -		src_clk = CLK_SDMMC_SEL_24M;
> -		break;
> -	case 400 * MHz:
> +	/* Fastest parent not above twice the card clock, or the slowest one */
> +	if (parent >= 400 * MHz)
>  		src_clk = CLK_SDMMC_SEL_400M;
> -		break;
> -	case 300 * MHz:
> +	else if (parent >= 300 * MHz)
>  		src_clk = CLK_SDMMC_SEL_300M;
> -		break;
> -	case 100 * MHz:
> +	else if (parent >= 100 * MHz)
>  		src_clk = CLK_SDMMC_SEL_100M;
> -		break;
> -	case 52 * MHz:
> -	case 50 * MHz:
> +	else if (parent >= 50 * MHz)
>  		src_clk = CLK_SDMMC_SEL_50M;
> -		break;
> -	case 750 * KHz:
> -	case 400 * KHz:
> +	else if (parent >= OSC_HZ)
> +		src_clk = CLK_SDMMC_SEL_24M;
> +	else
>  		src_clk = CLK_SDMMC_SEL_750K;
> -		break;
> -	default:
> -		return -ENOENT;
> -	}
>  
>  	switch (clk_id) {
>  	case HCLK_SDMMC0:
> 
> ---
> base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
> change-id: 20261110-rk3568-sdmmc-clk-95bccae72277
> 
> Best regards,

