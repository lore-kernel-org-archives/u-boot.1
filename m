Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46675E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 20:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC43F801BE;
	Thu, 12 Dec 2024 21:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rHZRxq45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95ABB801CF; Thu, 12 Dec 2024 21:14:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A958010E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 21:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BCKELCr096806;
 Thu, 12 Dec 2024 14:14:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734034461;
 bh=DjUVIL+RPna1QChSYwz7kpD3yv50G4F0SOvoPwDK6i4=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=rHZRxq45e34uJ9+JyLhjXRPIVDUnv9t2hKDaUiGwqFYgUK/wJIWhaWQYV78y3lp6K
 Zj+NFKZ9oUzofzDcLx3+MzGdb3uTr1ci5BWDijCH1HmvLbWg0pXFbLJ5FvSmVLKGLz
 UUrafbNPx54F5ye5Pmofd9dTjKJZ3R6IgFHmAQtc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCKELsL052494
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Dec 2024 14:14:21 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 14:14:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 14:14:21 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCKELcs083847;
 Thu, 12 Dec 2024 14:14:21 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
In-Reply-To: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
Date: Thu, 12 Dec 2024 14:14:20 -0600
Message-ID: <86zfl04q1v.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com> writes:

> Update the spi_nor_read() function only for parallel configuration
> when config SPI_STACKED_PARALLEL is enabled and keep the default
> code as is. For parallel configurations fix the read issue for
> 4byte address width by passing the entire length to the read
> function, split the memory of 16MB size banks only when the
> address width is 3byte. Also update the size when the
> configuration is stacked.
>
> Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Update the nor read for parallel configuration and for other case
>   keep the code as is.
> - Fixed the commit description.
> - Tested the changes with s25fl128s flash
> Zynq> sf probe 0 0 0
> SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB, total 16 MiB
> Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
> SF: 16777216 bytes @ 0x0 Erased: OK
>
> time: 32.464 seconds
> device 0 whole chip
> SF: 16777216 bytes @ 0x0 Written: OK
>
> time: 15.515 seconds
> device 0 whole chip
> SF: 16777216 bytes @ 0x0 Read: OK
>
> time: 1.557 seconds
> Total of 16777216 byte(s) were the same
> ---
>  drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..8d7087b5c9 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1140,7 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  				nor->spi->flags &= ~SPI_XFER_U_PAGE;
>  		}
>  #ifdef CONFIG_SPI_FLASH_BAR
> -		ret = write_bar(nor, addr);
> +		ret = write_bar(nor, offset);
>  		if (ret < 0)
>  			goto erase_err;
>  #endif
> @@ -1152,7 +1152,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>  			ret = spi_nor_erase_chip(nor);
>  		} else {
> -			ret = spi_nor_erase_sector(nor, addr);
> +			ret = spi_nor_erase_sector(nor, offset);
>  		}
>  		if (ret < 0)
>  			goto erase_err;
> @@ -1578,8 +1578,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>  	int ret;
>  	loff_t offset = from;
> -	u32 read_len = 0;
>  	u32 rem_bank_len = 0;
> +	u32 stack_shift = 0;
>  	u8 bank;
>  	bool is_ofst_odd = false;
>  
> @@ -1593,18 +1593,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  	}
>  
>  	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> -
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> -
> +		size_t read_len = len;
>  		offset = from;
>  
> +	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +		if (nor->addr_width == 3) {
> +			bank = (u32)from / SZ_16M;
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				bank /= 2;
> +
> +			rem_bank_len = SZ_16M * (bank + 1);
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				rem_bank_len *= 2;
> +			rem_bank_len -= from;
> +		}
> +
>  		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
>  			if (offset >= (mtd->size / 2)) {
>  				offset = offset - (mtd->size / 2);
>  				nor->spi->flags |= SPI_XFER_U_PAGE;
> @@ -1613,20 +1618,31 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  			}
>  		}
>  
> +		if (nor->addr_width == 4)
> +			rem_bank_len = (mtd->size >> stack_shift) - offset;
> +
>  		if (nor->flags & SNOR_F_HAS_PARALLEL)
>  			offset /= 2;
> +	}
>  
>  #ifdef CONFIG_SPI_FLASH_BAR
> +		u32 remain_len;
> +
>  		ret = write_bar(nor, offset);
>  		if (ret < 0)
>  			return log_ret(ret);
> -#endif
> -
> -		if (len < rem_bank_len)
> +		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
> +		if (len < remain_len)
>  			read_len = len;
>  		else
> -			read_len = rem_bank_len;
> -
> +			read_len = remain_len;
> +#endif
> +		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +			if (len < rem_bank_len)
> +				read_len = len;
> +			else
> +				read_len = rem_bank_len;
> +		}
>  		if (read_len == 0)
>  			return -EIO;
>  
> -- 
> 2.34.1

Tested-by: Jonathan Humphreys <j-humphreys@ti.com>

