Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B5BEEEC39
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 06:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91438910E;
	Fri, 13 Sep 2024 08:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726210018;
	bh=1BWskt0CfUKta8hxx75i3s3FGuH0ciY4FohckDl6N/g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bAVGhwtteKgIQXmePWUwUzkZXCNxASmMMZpJto8oDH+OxV50nnmdbvvMx8VTXmxpg
	 OFHQT5YNziUfMNVduZaJLNyi6uixiu2NYKlRva4othOf90Qu6UDn8ICASnSS3ph0zy
	 A/qJPfU0+sOkTUIh47MPPxEnsS/SbqJdl3hkSKuR595fpIC97DweP682OxQDXRt5xA
	 DKKtV0z965w4Gg/N+h+NPsUh7P/2SWwVdKEa8DxHeabMz91vGnurh3MIoHvMWOqlef
	 lH4t4q24ghr5Fh/YOQizfRtnkw/iHfDoxzaWrUOZZ+GYGlkrrJPMWRCr5+7CgExf7m
	 VlVdx4D+BwawQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 97AF88900A;
 Fri, 13 Sep 2024 08:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726210018;
 bh=1BWskt0CfUKta8hxx75i3s3FGuH0ciY4FohckDl6N/g=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=xsBcByqdtjnMrCmhuRNnHasmhnaYoXzLltFaGBdMEA7MfZ4khsbXFR6ySKy8Ko3VD
 fl4UWBym5hQUY1btrLboZeeF781CMSl95ITqsds94ZCMWJISYvvjtW2HP6ppD5W3yB
 YNCxWrFuJ6sH+jxuFzTyNDsFNEb/H8bcAaDlebNHnydzRI+BVNR63GbccNaeSaDalP
 2JqudwbiHaLAz5e1ucA6L6DboJoXoNOklZXV05amMV1I94MTFIiZBpQKLCt5055AKi
 Wi4TpwWkQ06mMrVmOh5OouKV59FdAf9K2WYpIIhKRW1AgEc3M+yn8gYgN+RBN4/oqx
 3WeEAIHbNkPXg==
Message-ID: <163b0822-f60f-4e5b-9852-cbf44388e52a@denx.de>
Date: Fri, 13 Sep 2024 08:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix chip erase timeout issue
To: Ye Li <ye.li@nxp.com>, jagan@amarulasolutions.com, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com
References: <1726208966-126298-1-git-send-email-ye.li@nxp.com>
Content-Language: en-US
In-Reply-To: <1726208966-126298-1-git-send-email-ye.li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/13/24 8:29 AM, Ye Li wrote:
> Chip erase support was added to spi_nor_erase, but the timeout
> for polling SR ready is not updated and still for sector erase.
> So the timeout value is not enough for chip erase on some NOR flash.
> Follow kernel implementation 09b6a377687b ("mtd: spi-nor: scale up
> timeout for full-chip erase") to set new timeout for chip erase.
> 
> Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
> Changes in v2:
>   - use do_div for u64
>   - Keep the variables in reverse xmas-tree
>   - Add kernel commit info
>   
>   drivers/mtd/spi/spi-nor-core.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ce01d42cfe0f..83335b235605 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -45,6 +45,12 @@
>   
>   #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
>   
> +/*
> + * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
> + * for larger flash
> + */
> +#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES	(40UL * HZ)
> +
>   #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
>   
>   struct sfdp_parameter_header {
> @@ -990,7 +996,9 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>   static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   {
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> +	unsigned long timeout = 0;

Set this to = DEFAULT_READY_WAIT_JIFFIES; instead of = 0;

>   	bool addr_known = false;
> +	u64 sz = mtd->size;
>   	u32 addr, len, rem;
>   	int ret, err;
>   
> @@ -1028,6 +1036,14 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   		if (len == mtd->size &&
>   		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>   			ret = spi_nor_erase_chip(nor);
> +			/*
> +			 * Scale the timeout linearly with the size of the flash, with
> +			 * a minimum calibrated to an old 2MB flash. We could try to
> +			 * pull these from CFI/SFDP, but these values should be good
> +			 * enough for now.
> +			 */
> +			do_div(sz, SZ_2M);
> +			timeout = CHIP_ERASE_2MB_READY_WAIT_JIFFIES * max(1ULL, sz);
>   		} else {
>   			ret = spi_nor_erase_sector(nor, addr);
>   		}
> @@ -1037,7 +1053,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   		addr += ret;
>   		len -= ret;
>   
> -		ret = spi_nor_wait_till_ready(nor);

Finally, do a simple:

ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);

here, no need for if/else statement anymore.

> +		if (timeout)
> +			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
> +		else
> +			ret = spi_nor_wait_till_ready(nor);
>   		if (ret)
>   			goto erase_err;
>   	}

That should simplify the code I hope.
