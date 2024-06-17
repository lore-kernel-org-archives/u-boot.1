Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DFC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 06:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D3A88261;
	Mon, 17 Jun 2024 08:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fcxKuuXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F162E8825E; Mon, 17 Jun 2024 08:28:29 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8439286F6E
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45H6SNZX018458;
 Mon, 17 Jun 2024 01:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718605703;
 bh=Bjh/XvVvJO7Dt+eB5qZREhz+Ro/miJSAJw91oDd2sbM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fcxKuuXw3QVqwlTeD+UHCL5eh7c7AUXuvfSUtdnD/GnwFwACGJ5Yk6ZIvpOSSMuy1
 lzc6VmVSk4h1DDHd/zB6FpLvP9pxSb/3/ousermZBmL9SYJAjE832Q2mfntiOZ6VO3
 LIEMmAmfPw1lNCTLLo8SArxZu5eI1M5QcXbtEqJ8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45H6SN1j021649
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 01:28:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 01:28:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 01:28:23 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45H6SMjs089952;
 Mon, 17 Jun 2024 01:28:23 -0500
Date: Mon, 17 Jun 2024 11:58:22 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Prasad Kummari <prasad.kummari@amd.com>
CC: <u-boot@lists.denx.de>, <michal.simek@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
Message-ID: <20240617062822.474khxwuq4yxs5ra@dhruva>
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617041841.1336632-1-prasad.kummari@amd.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On Jun 17, 2024 at 09:48:42 +0530, Prasad Kummari wrote:
> Add support for ISSI 128MB flash IS25LP01GG. This part

Can we have the datasheet link for this part?
I am assuming it's this?
https://www.issi.com/WW/pdf/25LP-WP01GG.pdf

Better to add it to the commit message.

> supports 4byte opcodes. It also supports dual and quad
> read.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 4e83b8c94c..8cad764237 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -242,6 +242,8 @@ const struct flash_info spi_nor_ids[] = {
>  			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
>  			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
> +	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },

Otherwise looks good to me,
Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva
