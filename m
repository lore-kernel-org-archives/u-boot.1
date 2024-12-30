Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5690E77194
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 09:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9CE80583;
	Mon, 30 Dec 2024 10:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t4rmhyQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C1680584; Mon, 30 Dec 2024 10:34:05 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E52C80570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 10:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BU9Xjwq122959;
 Mon, 30 Dec 2024 03:33:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1735551225;
 bh=gxj25WrYLUEoj9oHTtuWk++injXLBXZE3X8KZKTb5vU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=t4rmhyQz6k96G9lSyyKr1wY3WktvId+kQaK0yOrAXboOk5ynAp3t1c8Ypgqcd/PLo
 UJjyAbH2ZMcUKY2G4hpVTrroj7ne0G+0z7OBRG/Rso4/6++KGSHbtaZfnoTGbWe2iz
 o/hLyCzfDec8Eht2HZIhopei1aCR4ZtkB2vzIKRY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BU9XjmS000464
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Dec 2024 03:33:45 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Dec 2024 03:33:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Dec 2024 03:33:45 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BU9XeMq117079;
 Mon, 30 Dec 2024 03:33:40 -0600
Message-ID: <54dc7b9a-32f7-4a37-af51-69095d28956f@ti.com>
Date: Mon, 30 Dec 2024 15:03:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>,
 <j-humphreys@ti.com>, <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>,
 <stefan_b@posteo.net>, <quentin.schulz@cherry.de>,
 <Takahiro.Kuwano@infineon.com>, <p-mantena@ti.com>, <git@amd.com>
References: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Venkatesh,

On 12/30/2024 12:32 PM, Venkatesh Yadav Abbarapu wrote:
> Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> and update the length and bank calculation by spliting the memory of
> 16MB size banks only when the address width is 3byte.
> Fix the read issue for 4byte address width by passing the entire
> length to the read function.
>
> Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Update the nor read for parallel configuration and for other case
>    keep the code as is.
> - Fixed the commit description.
>   - Tested the changes with s25fl128s flash  Zynq> sf probe 0 0 0
>   SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB,  total 16 MiB  Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time  Zynq> sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time  Zynq> sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
>   SF: 16777216 bytes @ 0x0 Erased: OK
>
>   time: 32.464 seconds
>   device 0 whole chip
>   SF: 16777216 bytes @ 0x0 Written: OK
>
>   time: 15.515 seconds
>   device 0 whole chip
>   SF: 16777216 bytes @ 0x0 Read: OK
>
>   time: 1.557 seconds
>   Total of 16777216 byte(s) were the same
>
> Changes in v3:
> - Compile out the parallel code in spi_nor_erase() if the SPI_STACKED_PARALLEL
>    is enabled.
>
> Changes in v4:
> - Update the bank calculation only when SPL_FLASH_BAR is enabled.
>
> Changes in v5:
> - Update the parallel code in the spi_nor_read() only if the SPI_STACKED_PARALLEL
>    config is enabled.
>
> Changes in v6:
> - Remove the hardcoded address width for 4byte.
> - Move the length condition with rem_bank_len under SPI_FLASH_BAR flag.
> ---
>   drivers/mtd/spi/spi-nor-core.c | 75 ++++++++++++++++++++--------------
>   1 file changed, 44 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13bd..6f352c5c0e2 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1130,17 +1130,19 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   			goto erase_err;
>   		}
>   		offset = addr;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			offset /= 2;
> -
> -		if (nor->flags & SNOR_F_HAS_STACKED) {
> -			if (offset >= (mtd->size / 2))
> -				nor->spi->flags |= SPI_XFER_U_PAGE;
> -			else
> -				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				offset /= 2;
> +
> +			if (nor->flags & SNOR_F_HAS_STACKED) {
> +				if (offset >= (mtd->size / 2))
> +					nor->spi->flags |= SPI_XFER_U_PAGE;
> +				else
> +					nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +			}

I believe SNOR_F_HAS_PARALLEL and SNOR_F_HAS_STACKED flags are specific 
to your use case.

which should be set if flash is parallel and/or stacked, then why you 
want to protect with another

  if  (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL).

if you want to reset flags, you can do at start of function 
(nor->spi->flags &= ~SPI_XFER_U_PAGE)

IMO, only flags conditions should be enough.

>   		}
>   #ifdef CONFIG_SPI_FLASH_BAR
> -		ret = write_bar(nor, addr);
> +		ret = write_bar(nor, offset);
>   		if (ret < 0)
>   			goto erase_err;
>   #endif
> @@ -1152,7 +1154,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>   			ret = spi_nor_erase_chip(nor);
>   		} else {
> -			ret = spi_nor_erase_sector(nor, addr);
> +			ret = spi_nor_erase_sector(nor, offset);
>   		}
>   		if (ret < 0)
>   			goto erase_err;
> @@ -1576,11 +1578,12 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   			size_t *retlen, u_char *buf)
>   {
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> -	int ret;
>   	loff_t offset = from;
> -	u32 read_len = 0;
>   	u32 rem_bank_len = 0;
> +	u32 stack_shift = 0;
> +	size_t read_len;
>   	u8 bank;
> +	int ret;
>   	bool is_ofst_odd = false;
>   
>   	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
> @@ -1593,39 +1596,49 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	}
>   
>   	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> -
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> -
> +		read_len = len;
>   		offset = from;
>   
> -		if (nor->flags & SNOR_F_HAS_STACKED) {
> -			if (offset >= (mtd->size / 2)) {
> -				offset = offset - (mtd->size / 2);
> -				nor->spi->flags |= SPI_XFER_U_PAGE;
> -			} else {
> -				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {

What if SPI_FLASH_BAR not set and SPI_STACKED_PARALLEL is set


> +			bank = (u32)from / SZ_16M;
> +			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +				if (nor->flags & SNOR_F_HAS_PARALLEL)
> +					bank /= 2;
> +			}
> +			rem_bank_len = SZ_16M * (bank + 1);
> +			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +				if (nor->flags & SNOR_F_HAS_PARALLEL)
> +					rem_bank_len *= 2;
>   			}
> +			rem_bank_len -= from;
>   		}
>   
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			offset /= 2;
> +		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +			if (nor->flags & SNOR_F_HAS_STACKED) {
> +				stack_shift = 1;
> +				if (offset >= (mtd->size / 2)) {
> +					offset = offset - (mtd->size / 2);
> +					nor->spi->flags |= SPI_XFER_U_PAGE;
> +				} else {
> +					nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +				}
> +			}

Can you think to remove additional condition around 
SPI_STACKED_PARALLEL, if flag SNOR_F_HAS_STACKED  is sufficient.


> +		}
> +
> +		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				offset /= 2;
> +		}

Same here, please review additional if condition


>   
>   #ifdef CONFIG_SPI_FLASH_BAR
>   		ret = write_bar(nor, offset);
>   		if (ret < 0)
>   			return log_ret(ret);
> -#endif
> -
>   		if (len < rem_bank_len)
>   			read_len = len;
>   		else
>   			read_len = rem_bank_len;
> +#endif
>   
>   		if (read_len == 0)
>   			return -EIO;
