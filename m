Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFE2C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 12:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659758309E;
	Mon, 21 Jul 2025 14:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tRRMQHeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C1D830EA; Mon, 21 Jul 2025 14:03:26 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D49C801DD
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56LC3F3c801089;
 Mon, 21 Jul 2025 07:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753099395;
 bh=L51mBM5I6jImLMeHRNWdUyfXtiJy95VGVVWXz3LpGEM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tRRMQHeHT+c3tg8ybPvCLB1eikrBXSetyIalDzmOJ+OwLxC+1xrVqnyS7OU+Goni6
 09jhNN/cD3MYRs+P7F6m92x9PxcwgwNdAPLmzJ02689eXL2QvXhxqgYQ0CKSCnQvcg
 p7OF1bh6c9n/X5YdMnf5HkncWwIecg5V7V4D5IUs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56LC3EMR1349038
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 21 Jul 2025 07:03:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 07:03:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 07:03:14 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56LC3DZG3786415;
 Mon, 21 Jul 2025 07:03:14 -0500
Date: Mon, 21 Jul 2025 17:33:12 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>, Jagan Teki <jagan@amarulasolutions.com>, Nobuhiro
 Iwamatsu <iwamatsu@nigauri.org>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tom Rini <trini@konsulko.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
Message-ID: <20250721120312.5kxfgbkpsn7336yf@prasanth-server>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 21:58, Marek Vasut wrote:
> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
> flash part is similar to W25Q512NWM .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index e7e97780d7c..0383175beb5 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

Hi Marek,

Is there a place where we can refer to the datasheet.
According to commit message, Its similar flash part W25Q512NWM seems
to have 4Byte address mode but capability is not seen in the code [0].
Is this some limitation that goes with this flash as well.

[0] https://elixir.bootlin.com/u-boot/v2025.07/source/drivers/mtd/spi/spi-nor-ids.c#L553

Thanks,
Prasanth

>  #endif
>  #ifdef CONFIG_SPI_FLASH_XMC
>  	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
> -- 
> 2.47.2
> 
> 
