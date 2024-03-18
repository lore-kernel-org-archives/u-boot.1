Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8EC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A215A87CC1;
	Mon, 18 Mar 2024 14:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="P0LNyYki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351ED87CFE; Mon, 18 Mar 2024 14:19:15 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE2287861
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Mon, 18 Mar 2024 14:19:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710767951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=D4kEL2S1IAHMtN7tK9yjgIifeXlOT6okFKrdSXkROBM=;
 b=P0LNyYkiiyvYuxyQ/nBqoSMAUb7gbv814/uytUWG07EcuW/5+PSo+OObXxfnVS9CbTsSdK
 kNZl6oY0pXmkvGm39BeVBWX/r6a/7SIt8sOjPi0Rfpza4+L+2hMnjiv87KwtAYz2xnKrqD
 Rqyo3fuby5sDl49E3/1wfqBBlg7TaJ2lO64DY+TQ9hQcQHRUWd7DTxBeoDLyHwe06D32z8
 aiyLkHksYUgqK1bBTpa1oK6zwZ9sSHv1bHpVDFp2Q5jLbtSuOrUniZEV0ouh1cqkq3Ma2V
 SqwkvUF/CikYbBQn3mqD84lnWqaoM98+nGayZznoZ/rJinS5mgx6ft5jkIr0nA==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: trini@konsulko.com, sjg@chromium.org, seanga2@gmail.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] cmd: nand: Add support to print the manufacturer, model
 and size
Message-ID: <20240318-wrongness-glorify-01d0c5223b94@thorsis.com>
Mail-Followup-To: Mihai Sain <mihai.sain@microchip.com>, trini@konsulko.com,
 sjg@chromium.org, seanga2@gmail.com, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240318122647.1578-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318122647.1578-1-mihai.sain@microchip.com>
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

Hello Mihai,

adding the raw nand maintainers to Cc, maybe cmd/nand.c should be
added to MAINTAINERS file section raw nand?  See my comments below.

Am Mon, Mar 18, 2024 at 02:26:47PM +0200 schrieb Mihai Sain:
> Add support to nand info for printing the manufacturer,model and size.
> 
> U-Boot> nand info
> 
> Device 0: nand0, sector size 256 KiB
>   Manufacturer  MACRONIX
>   Model         MX30LF4G28AD
>   Device size        512 MiB
>   Page size         4096 b
>   OOB size           256 b
>   Erase size      262144 b
>   ecc strength         8 bits
>   ecc step size      512 b
>   subpagesize       4096 b
>   options       0x00004200
>   bbt options   0x00028000

Tested here:

    Device 0: nand0, sector size 128 KiB
      Manufacturer  SPANSION 
      Model         S34ML02G1 
      Device size        256 MiB
      Page size         2048 b
      OOB size            64 b
      Erase size      131072 b
      ecc strength         8 bits
      ecc step size      512 b
      subpagesize       2048 b
      options       0x40004200
      bbt options   0x00028000

> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  cmd/nand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/cmd/nand.c b/cmd/nand.c
> index fe834c4ac5..f5cfaab37c 100644
> --- a/cmd/nand.c
> +++ b/cmd/nand.c
> @@ -418,6 +418,9 @@ static void nand_print_and_set_info(int idx)
>  		printf("%dx ", chip->numchips);
>  	printf("%s, sector size %u KiB\n",
>  	       mtd->name, mtd->erasesize >> 10);
> +	printf("  Manufacturer  %s \n", chip->onfi_params.manufacturer);
> +	printf("  Model         %s \n", chip->onfi_params.model);

This probably only works for ONFI flash and might fail otherwise.  See
this code in nand_base.c:

https://elixir.bootlin.com/u-boot/v2024.01/source/drivers/mtd/nand/raw/nand_base.c#L4455

The manufacturer could always be printed from struct nand_chip
->manufacturer.desc.name here.

Don't know if the third fallback for model ("type->name") is somehow
accessible after nand_detect() but I would at least test on
chip->onfi_version or chip->jedec_version here, and maybe just drop
the model line if none is set.

> +	printf("  Device size   %8d MiB\n", (int)(chip->chipsize >> 20));

Fine.

Greets
Alex

>  	printf("  Page size     %8d b\n", mtd->writesize);
>  	printf("  OOB size      %8d b\n", mtd->oobsize);
>  	printf("  Erase size    %8d b\n", mtd->erasesize);
> -- 
> 2.44.0
> 
