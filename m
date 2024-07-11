Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D32C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 08:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E8588785;
	Thu, 11 Jul 2024 10:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720685405;
	bh=1zhrftpVXm+YRRYKsy18UQQHrP+TcJGvnrxMHiW3wmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=erSilkt/NOCBYn5dmKLqO3Iplw16Gmgtaey/9ZXkAEAX1TB93GoDl4SytzL+3jbXn
	 d1hTOcV/rYfpVKk/DRHPsvuB3tTdH+9O/GqN4Df8VrZHBybM4K246n9ff7BTACNQ6q
	 dqE4vbiKy2YYlr9EVs7IGh0mF93vh+DwP5o1eSCSrcsMB6U6FfW+OByVoWmCDaLfoA
	 OAJa8gY9xSUSXUseJyX1/sN3J1+yh6NfBGba0e9xrLbyJX9Z/G2WY0dFzzwqudBOA3
	 wjz/IJLdoCop/D6JowBlobGCILnHmSWKSVUceCKIULdkgCXZCg7Dg9LNq+KlQCGJgU
	 ZW2Es3rSfUJow==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA87F887C0; Thu, 11 Jul 2024 10:10:04 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8F88876D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 10:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WKS7r66N7z9t0c;
 Thu, 11 Jul 2024 10:10:00 +0200 (CEST)
Message-ID: <21449f91-45f1-4e07-b57e-c4c89706687f@denx.de>
Date: Thu, 11 Jul 2024 10:10:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] board: rpi: remove leftover CONFIG_HW_WATCHDOG block
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
 <20240710211730.2635847-2-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240710211730.2635847-2-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WKS7r66N7z9t0c
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

On 7/10/24 23:17, Rasmus Villemoes wrote:
> This was added in commit 45a6d231b2f (bcm2835_wdt: support for the
> BCM2835/2836 watchdog), which did do 'select HW_WATCHDOG'. That
> incarnation of the watchdog driver later got removed in
> c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x watchdog
> driver and its references), but this block was left behind.
> 
> Another rpi watchdog driver has since been added, but that does not
> select HW_WATCHDOG, so this remains dead and unused. Remove it.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/raspberrypi/rpi/rpi.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index d996eb0cf69..9a83cf2d6a7 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -493,10 +493,6 @@ static void get_board_revision(void)
>   
>   int board_init(void)
>   {
> -#ifdef CONFIG_HW_WATCHDOG
> -	hw_watchdog_init();
> -#endif
> -
>   	get_board_revision();
>   
>   	gd->bd->bi_boot_params = 0x100;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
