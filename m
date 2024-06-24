Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8E7C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 09:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DC487FFB;
	Mon, 24 Jun 2024 11:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="R1FjBuPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4976387FFB; Mon, 24 Jun 2024 11:15:08 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526F1801BA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DE8EA14835CC; Mon, 24 Jun 2024 11:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1719220504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=4G52iIyOvuB3NMQrMFve1s34aRyuySDoK/eLdGw14Jc=;
 b=R1FjBuPSBlVtq12MISS85CiT8AU0EQOxZad+xOZx9m9+YJkjcqQEgwu8KOqUbYK39y0RiY
 rrxlKS864rhReTQ+zRoiXcxApjgS84bbFuvnkSU6rN3qna/R0rszK4R6YlfONJGfWa2U2E
 if/msrG31/PcYIH07HGNoYM9CsOFTpHrId1kdaHyt23lRB6BV+L32wyk+M+HDbcPTuKChk
 6yCB8Rq6OCJuviWEvLafSgFjot8+hIxJnBW1Td9s0fmvYXVx4ve/dlNbsDLl5Fehb+ZOGr
 cbaY9GD9Hi2dmbvJaauuFhxy6XUClVQxbnau6CxGWhi8M6LL3kFnCWp+30aJnw==
Date: Mon, 24 Jun 2024 11:14:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
Message-ID: <20240624-preacher-sharpness-b33541d3302d@thorsis.com>
Mail-Followup-To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 kernel@sberdevices.ru, oxffffaa@gmail.com
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602200836.3949773-2-avkrasnov@salutedevices.com>
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

Hello Arseniy,

Am Sun, Jun 02, 2024 at 11:08:34PM +0300 schrieb Arseniy Krasnov:
> Based on Linux kernel:
> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")
> 
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  include/linux/mtd/rawnand.h      | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c40a0f23d7..ed605b4af5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>  	if (ret == 16)
>  		chip->options |= NAND_BUSWIDTH_16;
>  
> +	if (ofnode_read_bool(node, "nand-is-boot-medium"))
> +		chip->options |= NAND_IS_BOOT_MEDIUM;
> +
>  	if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae641..4eb880d8fb 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -218,6 +218,12 @@ enum nand_ecc_algo {
>  /* Device needs 3rd row address cycle */
>  #define NAND_ROW_ADDR_3		0x00004000
>  
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this information
> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
> + */
> +#define NAND_IS_BOOT_MEDIUM	0x00400000
> +
>  /* Options valid for Samsung large page devices */
>  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG

The entries in that file are ordered numerically.  Comparing with the
same file in Linux this should go before NAND_KEEP_TIMINGS, not
anywhere in between.  Makes later diffs and ports from Linux easier.

Greets
Alex

>  
> -- 
> 2.35.0
> 
