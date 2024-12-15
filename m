Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F907E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67418005B;
	Mon, 16 Dec 2024 00:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734306859;
	bh=s880YLKTnraIExc57JDg6MG8CQo28bldYdjKlkKrzKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SXaL5oX+PFKFAHXWPud2y6U6bZcm8RxPihNZCaOub8xMbMaG8KPnudFdd5/LVYvU2
	 E3c9FYp8XHMjvhCLJJ8vlIWLBp5sNkyNL04ZBVfHUxVMbmDnhNAC5Nq0h2QIKr9ZoK
	 hPy4AeLw/Qif7W21pS4n1rtt9sUVWp0pI4kMM5/1hg5GHal/Pcau7tXkdyC3nlEdRg
	 vEbbSGsLu8w7+2Gtc23W2Di/m4iHUTOUw1YqzFmmu92aZLKZQBe8AI+pcAm1V9NETf
	 cA+p3beE+9XGNQmy8dPTIV3lxhz0w5LiTROKIUDu2w4ACLTJs+UE1toopk+MbQPVLB
	 dYVKWDxGo4lZg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AEF80092; Mon, 16 Dec 2024 00:54:18 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3321080050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QByZTX3p"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 456FF1049AF78; Mon, 16 Dec 2024 00:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734306854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s880YLKTnraIExc57JDg6MG8CQo28bldYdjKlkKrzKM=;
 b=QByZTX3p9C3sPUD0gdvcxmF/ujlga9DbN16tdxMHRrx8XyZthHIAKL5rMt+7Dl/AN0ihhN
 zylRCqwNQwgQdKJBjMJPiVA0f+5t2y6QU+t3EJQcxD40Dxq/p/VAQexjJXQ3ojOWi8MNnz
 f6z2me1auEfS/A3VExRXZ1EdX0s6gbt1HCY+TrSB2ha9VMvWJWQ7UjGC6E5uYNUdoh7I0S
 zwE+qGYGqCCelz4MavJOvmpzkxQYcpAOZpB7uljAknfdKW71UWvdyOaSAqlF8xgI5OSntl
 YzP4DtQfbuDv+Hg2zB1GHILQpSWb3fw4/DYC6yIiPv1nMcVtWiILcbHeLZ59eQ==
Message-ID: <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
Date: Mon, 16 Dec 2024 00:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/11/24 1:06 PM, Venkatesh Yadav Abbarapu wrote:
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
>    keep the code as is.
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
>   drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++------------
>   1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..8d7087b5c9 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1140,7 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   				nor->spi->flags &= ~SPI_XFER_U_PAGE;
>   		}
>   #ifdef CONFIG_SPI_FLASH_BAR
> -		ret = write_bar(nor, addr);
> +		ret = write_bar(nor, offset);

This change is really inobvious, the code above likely needs to be 
compiled out if the SPI_STACKED_PARALLEL stuff is disabled ?

"
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8d7087b5c95..691962ef271 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1130,6 +1130,7 @@ static int spi_nor_erase(struct mtd_info *mtd, 
struct erase_info *instr)
                         goto erase_err;
                 }
                 offset = addr;
+               if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
                         if (nor->flags & SNOR_F_HAS_PARALLEL)
                                 offset /= 2;

@@ -1139,6 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd, 
struct erase_info *instr)
                                 else
                                         nor->spi->flags &= 
~SPI_XFER_U_PAGE;
                         }
+               }
  #ifdef CONFIG_SPI_FLASH_BAR
                 ret = write_bar(nor, offset);
                 if (ret < 0)
"

>   		if (ret < 0)
>   			goto erase_err;
>   #endif
> @@ -1152,7 +1152,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>   			ret = spi_nor_erase_chip(nor);
>   		} else {
> -			ret = spi_nor_erase_sector(nor, addr);
> +			ret = spi_nor_erase_sector(nor, offset);
>   		}
>   		if (ret < 0)
>   			goto erase_err;
> @@ -1578,8 +1578,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>   	int ret;
>   	loff_t offset = from;
> -	u32 read_len = 0;
>   	u32 rem_bank_len = 0;
> +	u32 stack_shift = 0;
>   	u8 bank;
>   	bool is_ofst_odd = false;
>   
> @@ -1593,18 +1593,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
> +		size_t read_len = len;
>   		offset = from;
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
>   		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
>   			if (offset >= (mtd->size / 2)) {
>   				offset = offset - (mtd->size / 2);
>   				nor->spi->flags |= SPI_XFER_U_PAGE;
> @@ -1613,20 +1618,31 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   			}
>   		}
>   
> +		if (nor->addr_width == 4)
> +			rem_bank_len = (mtd->size >> stack_shift) - offset;
> +
>   		if (nor->flags & SNOR_F_HAS_PARALLEL)
>   			offset /= 2;
> +	}
>   
>   #ifdef CONFIG_SPI_FLASH_BAR
> +		u32 remain_len;
> +
>   		ret = write_bar(nor, offset);
>   		if (ret < 0)
>   			return log_ret(ret);
> -#endif
> -
> -		if (len < rem_bank_len)
> +		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
> +		if (len < remain_len)
>   			read_len = len;
>   		else
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

If I look at this change with 'git show -w' , the change looks like this:

"
  #ifdef CONFIG_SPI_FLASH_BAR
+               u32 remain_len;
+
                 ret = write_bar(nor, offset);
                 if (ret < 0)
                         return log_ret(ret);
+               remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
+               if (len < remain_len)
+                       read_len = len;
+               else
+                       read_len = remain_len;
  #endif
-
+               if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
                         if (len < rem_bank_len)
                                 read_len = len;
                         else
                                 read_len = rem_bank_len;
-
+               }
                 if (read_len == 0)
                         return -EIO;
"

Why is there this part of code twice now, ifdeffed out differently in 
each case ?

"
                         if (len < rem_bank_len)
                                 read_len = len;
                         else
                                 read_len = rem_bank_len;
"
