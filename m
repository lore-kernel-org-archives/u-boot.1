Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE58109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D147283DA6;
	Wed, 25 Mar 2026 20:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Wkhw+qYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26EA83DA7; Wed, 25 Mar 2026 20:31:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D3083A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e7f4=B2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1774467090;
 bh=E6M1ZUYUdT/ko/elH6apWiIa6YqqVJ40EKdZsn3jGQQ=;
 b=Wkhw+qYZCTv72t3d7mcuTiO4jTn9NWnJkRVAzM9r3vHlJhTCqlnskm93B6a/dmxw4EQhCw1T7
 1LAEVe9I4Vv1Mm3UfJF016ENGBv1o+FuYG024tNiaxIcxarWV2AkPE66aotKr7G1W+G9M8rJGAX
 nB2Rf18z0XmZLULQiBETCnN1e6irLG1dUABSMJXr0qGQxIMf/A6G14Xud8NtW3WPSsChenj5H8u
 5MUNlSsWAYrTW3kuqhzkx1PCNTAbNNFS2r/XdhficeUEiqYe4Sol5C+kB/WyV2lqm31LX36nkfI
 L4iI16iPWscdh2VlWbgNi1NriPRfJIecyDESIw4Ec32g==
X-Forward-Email-ID: 69c43810a686125d1eb84997
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.55
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
Date: Wed, 25 Mar 2026 20:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20260325190025.3428560-1-trini@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260325190025.3428560-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 3/25/2026 8:00 PM, Tom Rini wrote:
> Today, no platforms call board_early_init_f, and rockchip provides a
> weak default function. Change this to not providing a weak function and
> only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
> This will allow any potential future needs to be taken care of, and make
> future consolidation easier.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> ---
>  arch/arm/mach-rockchip/spl.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079a..8026cc0abb8d 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  	return MMCSD_MODE_RAW;
>  }
>  
> -__weak int board_early_init_f(void)
> -{
> -	return 0;
> -}
> -
>  __weak int arch_cpu_init(void)
>  {
>  	return 0;
> @@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
>  {
>  	int ret;
>  
> -	board_early_init_f();
> +	if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))

This patch seem to introduce a change in behavior for chromebook bob and
kevin, they do not seem to enable BOARD_EARLY_INIT_F, yet they have a
board_early_init_f() in board/google/gru/gru.c no longer being called
after this change.

I do not have a chromebook_bob/kevin so I cannot help verify if this
change break anything, hopefully Simon can help test/verify.

Regards,
Jonas

> +		board_early_init_f();
>  
>  	ret = spl_early_init();
>  	if (ret) {

