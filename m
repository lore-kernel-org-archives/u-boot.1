Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32857C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 08:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D76FB606A6;
	Mon, 10 Aug 2026 08:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvLDRFeG3gNr; Mon, 10 Aug 2026 08:29:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D95C60641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786350544;
	bh=4akMp2R53uTi1jEtusvJ+fw+Og9Y0xBMxiS4D7xPIHI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0gD+VMZxRsV9kAllXpkXhongW0C1a163s/qyMXaVSiQRoZKWaTLA94jnb6OP46X7+
	 OHq7H0P9vL4HcCnGxtjR6HfUisbSrrlCHhAfHbsg1lcqduEIJqptI6S/QsgsimJojg
	 ZpAZ5/8nvO2vi6NN+NR3+ZDP/IwI/Klefd95+KNh17kx+jcMhwKWnLMfQujFIITPEE
	 4j8dcrzE92FS9LzyI2dSbbIz/Ov0qiL+v65Mdx2Qg4i0XA0SRpESgI1lt+U0mZLMMy
	 jtpU2JZA/CbIsw51Y9Dl6p/n4OcfhfaOuDNTTjJznOlta6N7Y5OLfvLHI1aTH3Ioqm
	 iFtlLQaf8ZPPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D95C60641;
	Mon, 10 Aug 2026 08:29:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA1BB282
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC8BC400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIe5pmHpgMhF for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 08:29:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B41FA400DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B41FA400DB
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B41FA400DB
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:29:02 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hJSb02GJbzKvxp;
 Mon, 10 Aug 2026 10:29:00 +0200 (CEST)
Message-ID: <cfca4027-3c8a-41d6-a8c5-602994df4822@mailbox.org>
Date: Mon, 10 Aug 2026 10:28:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: cfi: Replace env_get_f() with env_get_yesno()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yzz5ex7xa95rzmqdfijtfmd1n9aw9mhf
X-MBO-RS-ID: 4782d2d438352a37651
X-Rspamd-Queue-Id: 4hJSb02GJbzKvxp
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786350540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4akMp2R53uTi1jEtusvJ+fw+Og9Y0xBMxiS4D7xPIHI=;
 b=vsS+fZ5nnZEOtCpoLRXgb6KeG89F2Smtm3FGUeuE7wi568HVXqzPGXtxOX+oEOlv7Kh98n
 W6gd0IHTebKaC7UI/2PfWxMovwY3gv5NofjD3sBO2Sn400GG5T/paeunJEiNL4M6Hl+2ZB
 JlFZYmhCJ5Fm0mgvYizCJFUOTrtYnifJJQBoTKap7Fvr00jKR00rc69wu+yjVSC5kRhp9U
 O7rsemeKjklcyUGSaelij3N7r1a4tLGxvc4SGlKM6YM95lvhKw49flP3ijh6YEhsOCuTrC
 3JnQAlsoW5R3KBxpeXQCm8Dh0lFOWmYP4cP4mAQWAroL5HXkkooPQIb8oCme6g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786350538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4akMp2R53uTi1jEtusvJ+fw+Og9Y0xBMxiS4D7xPIHI=;
 b=tL0OWTxynYQyGqmKWAb87gArq8TpNThCiiIza336QSKK0THiTHin8l+l3D30tMTbIFRyyb
 T0wryTVrOzmYlx+B3QeLERxs4RD4DyHDpmD45js7nPy45w8V+M4nMajdeLcsQVKFHNPVQW
 /zZvGgT+UQSXrVV7oFuJdPhk/YvN5ClMTGRIlEZ3KCYzlpaFr1zi1OH5EQvqf+QQDw8a7N
 DArf+KD4XPhnGl8sy2OA1eIK+92s5wlYYujcYnm1uz7/i4lKEb9E3Xo8CNykM4XOY9h0wg
 PoXxhbnZWDXG/ckbaH2LYwS/k0YNmeZrMmlvG9VfvfaZGWOL/F9BC6CbUs+NgQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=vsS+fZ5n; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=tL0OWTxy
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tL0OWTxy;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/4/26 01:17, Marek Vasut wrote:
> Simplify the code, replace env_get_f() with env_get_yesno(). The
> env_get_yesno() internally calls env_get() which may fall back to
> env_get_f() if the environment access is not initialized yet.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

@Tom, could you please pull this directly. AFAIU, we did not create
the cfi-flash custodian repo in the new infrastructure. I don't see a
real need for it, as CFI flash is just very rarely used nowadays.

Thanks,
Stefan

> ---
>   drivers/mtd/cfi_flash.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
> index e50502824ac..cf52abf1554 100644
> --- a/drivers/mtd/cfi_flash.c
> +++ b/drivers/mtd/cfi_flash.c
> @@ -2407,13 +2407,6 @@ unsigned long flash_init(void)
>   	unsigned long size = 0;
>   	int i;
>   
> -#ifdef CONFIG_SYS_FLASH_PROTECTION
> -	/* read environment from EEPROM */
> -	char s[64];
> -
> -	env_get_f("unlock", s, sizeof(s));
> -#endif
> -
>   #ifdef CONFIG_CFI_FLASH /* for driver model */
>   	cfi_flash_init_dm();
>   #endif
> @@ -2438,7 +2431,7 @@ unsigned long flash_init(void)
>   #endif /* CONFIG_SYS_FLASH_QUIET_TEST */
>   		}
>   #ifdef CONFIG_SYS_FLASH_PROTECTION
> -		else if (strcmp(s, "yes") == 0) {
> +		else if (env_get_yesno("unlock")) {
>   			/*
>   			 * Only the U-Boot image and it's environment
>   			 * is protected, all other sectors are

