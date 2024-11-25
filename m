Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36810D3B7F1
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B596388D56;
	Mon, 25 Nov 2024 09:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gbbxWj8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC4D88E35; Mon, 25 Nov 2024 09:49:36 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AE288815
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AP8nKcr115545;
 Mon, 25 Nov 2024 02:49:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732524560;
 bh=9N1BgnP2NEyPGJKMEgSxPS+P0UHGZbd1u9tTsf+H4ms=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gbbxWj8gRTe2TBQksxB0xrB2YPnh0E2oBugbjRkdQZmkA9YPfb1TPNTrZDb5dDja1
 p8GMXiO6hcYwbwddb7EN3iGWYaNKhuqvJc8fUEofy4t/h43W05vmq4cx3XEl2xzXGT
 xdTckgp8FG+QcVG2YZlEdrye3dLVjSPAdN3WCGec=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP8nK4m014859
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 02:49:20 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 02:49:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 02:49:20 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP8nJV6008611;
 Mon, 25 Nov 2024 02:49:20 -0600
Date: Mon, 25 Nov 2024 14:19:19 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
CC: <u-boot@lists.denx.de>, <j-humphreys@ti.com>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>,
 <stefan_b@posteo.net>, <quentin.schulz@cherry.de>,
 <tudor.ambarus@linaro.org>, <Takahiro.Kuwano@infineon.com>,
 <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Message-ID: <20241125084919.e3mr4nwmoecqj3y7@prasanth-server>
References: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
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

On 14:56, Venkatesh Yadav Abbarapu wrote:
Hi Venkatesh, 
> Enable mt35xu512aba_fixups for all mt35 series flashes to work
> in DTR mode, and return after nor->fixups is updated, otherwise
> it will get overwritten with macronix_octal_fixups.
> This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
> is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> 
> Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced
> to instruct the OSPI controller driver to switch to DDR mode.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
>  include/spi.h                  | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..8d201433d5 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4073,6 +4073,7 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> +	nor->spi->flags |= SPI_XFER_SET_DDR;
>  	buf = SPINOR_MT_OCT_DTR;
>  	op = (struct spi_mem_op)
>  		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> @@ -4404,8 +4405,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>  #endif
>  
>  #ifdef CONFIG_SPI_FLASH_MT35XU
> -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> +	    !strcmp(nor->info->name, "mt35xu01g") ||
> +	    !strcmp(nor->info->name, "mt35xu02g")) {
>  		nor->fixups = &mt35xu512aba_fixups;
> +		return;
> +	}
>  #endif
>  
>  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> diff --git a/include/spi.h b/include/spi.h
> index 6944773b59..d7fef36662 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -164,6 +164,7 @@ struct spi_slave {
>  #define SPI_XFER_U_PAGE		BIT(4)
>  #define SPI_XFER_STACKED	BIT(5)
>  #define SPI_XFER_LOWER		BIT(6)
> +#define SPI_XFER_SET_DDR	BIT(7)

Are we using this anywhere in the Controller driver ? What is the
significance of this flag, when we can send the DDR info through
the ops.

>  
>  	/*
>  	 * Flag indicating that the spi-controller has multi chip select
> -- 
> 2.25.1
> 
> 
