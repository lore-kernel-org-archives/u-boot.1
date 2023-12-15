Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A6C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 03:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F57587ADA;
	Fri, 15 Dec 2023 04:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="h8pRLZg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E325C87869; Fri, 15 Dec 2023 04:21:11 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2282287AE6
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1702610468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIKwh1OLD62RqtJFZ+xKCChuqtkscUC3Ugqcy8a9Tos=;
 b=h8pRLZg1O+t4DwHTom0N14KUS6eyB9XEFe8AsN41sKU2RwqCHZ0q7nXnk6KCtlyERa83zR
 53/hQvy685ewRtNQ4gYBPSzVf9Wn1QlHOqRCNhCd54mWEWqHSP2Rc1LnN1LPSl4arfcUSe
 IMXXgPHErSoDSD2fvijRAWAkOCrZT3RAfC0BNaJC0iPaC1nAvztAJ5MDq+sVm+0b1FJukX
 Jj7xvE8+M0BB+xMKMhjsE8CosX2Ve5Rph4uL1XbxI6bDiOMSRd+hwIk9as4cT9HcgHtspr
 ejxEoIqgqmSjSwd2cARbiaI4m8s6qR0V8twOZVqipO4cIK4ZM2WJilQ3LZFTxg==
Date: Fri, 15 Dec 2023 04:21:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 git@xilinx.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix flash part
In-Reply-To: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
References: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
Message-ID: <f3babb1378261fbf11fb057e9d860bac@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-14 17:36, Tejas Bhumkar wrote:
> Added support for Macronix OSPI flash parts MX25UM51345G
> and MX66UM2G45G, with initial testing conducted on the
> Tenzing-se1 board using STR mode for basic erase, write,
> and readback operations.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c 
> b/drivers/mtd/spi/spi-nor-ids.c
> index f86e7ff8e5..a08f105549 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -267,6 +267,8 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ
> | SPI_NOR_4B_OPCODES | SECT_4K) },
>  	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
> +	{ INFO("mx25um51345g",   0xc2813a, 0, 64 * 1024, 1024, SECT_4K |
> SPI_NOR_4B_OPCODES) },
> +	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K |
> SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K |
> SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K |
> SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K |
> SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },

The patch looks good to me, so:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Please see also [1].  I hope you'll be willing to test the patches when 
they're ready.

[1] 
https://lore.kernel.org/u-boot/0dc545aa9d32038dbe7bc481595198b0@manjaro.org/T/#u
