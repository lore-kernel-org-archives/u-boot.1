Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6672C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040DC8895D;
	Fri,  9 Aug 2024 14:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="cFPWM4h9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1F1889B8; Fri,  9 Aug 2024 14:25:15 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B33488600
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D892148778D; Fri,  9 Aug 2024 14:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1723206312; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=i9g2N7DRcNRLsYPPx5RLumUqwwFTpAaJb8pM2giKSeU=;
 b=cFPWM4h9r1cIsL/mvE3qvGAoUMadScLevzjSjUCwQY1aGDtKYkVfLDEgAMe+u/Rycwr+Mb
 eySUsHKxe52ObeXzH/JCJMSK/iyFiwPcZVnSo1WdVqeOq2G24Np0Qh6VL62iZhrkdq08Xc
 wy4HhFbGHJ69IWFcbF4SfcfHBxLgzt+miJc7dW4c72s+4L318rqJesDgGtu+D34JMopdJc
 fN1p2OG1ouCrSXg/e6heejcQDvLtFdKPkAbj5V9yOUL+ZXKsUlU2QFfXGaUAzNmw5Q4MVl
 Us65fya4xesI41CLgdJjteM7/fCa2xrzOBvB/C2oeziOoaWhru1k1m3bBMzc/g==
Date: Fri, 9 Aug 2024 14:25:04 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
Message-ID: <20240809-challenge-causation-20cf58794b33@thorsis.com>
Mail-Followup-To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
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

Hello Marcus,

Am Fri, Aug 09, 2024 at 02:15:43PM +0200 schrieb Marcus Folkesson:
> The condition 'ret' is always true as it is never set to other than
> -EIO.

Technically, you're right.

I quickly compared with the same driver in Linux.  That has some
additional lines for DMA transfers which probably got removed when
porting the driver.

Does the code before your patch throw compiler warnings?  If not, I
would keep it as is.  The compiler will probably optimize it away
anyway, and it would make future ports from Linux easier.

Greets
Alex

> 
> Remove 'ret' and the condition for copy.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index ee4ec6da58..00d7e177b9 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -568,12 +568,9 @@ static void atmel_nfc_copy_to_sram(struct nand_chip *chip, const u8 *buf,
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct atmel_nand *nand = to_atmel_nand(chip);
>  	struct atmel_hsmc_nand_controller *nc;
> -	int ret = -EIO;
>  
>  	nc = to_hsmc_nand_controller(nand->controller);
> -
> -	if (ret)
> -		memcpy_toio(nc->sram.virt, buf, mtd->writesize);
> +	memcpy_toio(nc->sram.virt, buf, mtd->writesize);
>  
>  	if (oob_required)
>  		memcpy_toio(nc->sram.virt + mtd->writesize, chip->oob_poi,
> @@ -586,12 +583,9 @@ static void atmel_nfc_copy_from_sram(struct nand_chip *chip, u8 *buf,
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct atmel_nand *nand = to_atmel_nand(chip);
>  	struct atmel_hsmc_nand_controller *nc;
> -	int ret = -EIO;
>  
>  	nc = to_hsmc_nand_controller(nand->controller);
> -
> -	if (ret)
> -		memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
> +	memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
>  
>  	if (oob_required)
>  		memcpy_fromio(chip->oob_poi, nc->sram.virt + mtd->writesize,
> -- 
> 2.45.1
> 
