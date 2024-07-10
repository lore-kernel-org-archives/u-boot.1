Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B76C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F296886F0;
	Wed, 10 Jul 2024 09:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="fzkwXCgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46177886F1; Wed, 10 Jul 2024 09:29:02 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7BE874AC
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6E27214838EB; Wed, 10 Jul 2024 09:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720596539; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=jv43ScVnN/VDpbJZ1WyIvqqfAtlN3Eg+fVmmkxlziXs=;
 b=fzkwXCgSHR4osPq2nt5XHnX31sO87jqAD6HjzP1oShdlamyzLhEtdSenHcasZuDC+M4iaL
 bwDUg6RKfWY+OFOuxWEJxRH+MlT7c97iqxj8LDahYjekhQ4qbbFij1Wtsj/AA3tKzf3Ov+
 Mzh1gPjK1x8/o2k6RAbTnYQYA2kaK8zjlXSBOFRjRZlwBtv4UXrmTuXygEAj9+KMiO4wi8
 Cxi0/SMpqVZ21RYiBAVQMnTPF1fclJvq4JARta+VXjuQ+fIXqOOYTLuU/hoj5R+nBQIivB
 DcLZxFK5JUPKHbEXP4FGOmVQHgzIRMSSih6hiUHnK1/m6G4rny9x2T72V6aBAw==
Date: Wed, 10 Jul 2024 09:28:52 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Zixun Li <zli@ogga.fr>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 open list <u-boot@lists.denx.de>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Message-ID: <20240710-talcum-repent-307fd836d683@thorsis.com>
Mail-Followup-To: Zixun Li <zli@ogga.fr>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 open list <u-boot@lists.denx.de>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Tue, Jul 09, 2024 at 10:28:12PM +0000 schrieb Zixun Li:
> When ECC parameters are not specified in DT, first try ONFI ECC parameters
> before fallback to maximum strength. To be inline with kernel driver behavior.
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index 9873d11254..d29a9c6f10 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1064,11 +1064,15 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
>  		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
>  	else if (chip->ecc.strength)
>  		req.ecc.strength = chip->ecc.strength;
> +	else if(chip->ecc_strength_ds)
> +		req.ecc.strength = chip->ecc_strength_ds;
>  	else
>  		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
>  
>  	if (chip->ecc.size)
>  		req.ecc.sectorsize = chip->ecc.size;
> +	else if(chip->ecc_step_ds)
> +		req.ecc.sectorsize = chip->ecc_step_ds;

Despite the missing space between 'if' and the opening bracket
(checkpatch should have told you?) this looks very much like what got
into linux with v4.11 but was changed/reworked multiple times
afterwards.  I wonder why this was not ported to U-Boot when
introducing this driver?  In 6a8dfd57220d ("nand: atmel: Add DM based
NAND driver") it was claimed the driver was ported from
linux-5.4-at91, so this feature was probably dropped intentionally?
Does anyone know why?

(Cc-ing the original driver author/porter.)

Greets
Alex

>  	else
>  		req.ecc.sectorsize = ATMEL_PMECC_SECTOR_SIZE_AUTO;
>  
> -- 
> 2.45.1
> 
