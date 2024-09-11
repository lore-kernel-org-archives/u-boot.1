Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA94FEE01EE
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A218927B;
	Wed, 11 Sep 2024 13:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726052763;
	bh=4YMtn5JhdCBLrCEmyl2ITOfhp/UfToDtJ/fTSWJyS+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=giHQWngdXt2KcajS8t3uk5MaQxa1z72gUlOPSYbVWSvmz44eOCwUCkKHW6YGDoXg0
	 82Ep9cMqpjS0Kg8Rz7DG32Q0lfsks486iJqIdyATKUs7CPrmA3K7ngrgPuzSEsKcoo
	 AXHZJuEXZRWgE3yGAoWWEEF8M9a0gbMv0wmCHyrgQE3ajeZ9eVuEqUh/L/0HSQP842
	 qD9uWarCnY4nVBf3p8zw/3WtSesS0YmFUii839gGN7vHa+aZHlK77935hC9na9IduM
	 dKT2NjUCBUZgAiuuGrx1hlkoLuWcn0cExFMJjMss7T9fmQ4/B5yIEdVjQrUcJ1Wk2F
	 dwOsTCVyypgQw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4854589228;
 Wed, 11 Sep 2024 13:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726052762;
 bh=4YMtn5JhdCBLrCEmyl2ITOfhp/UfToDtJ/fTSWJyS+M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lvDN2tzcMsG/0aF/xYDDJvt8eu+cbp3QuHL+E4k0hIvb8Yd/Zx3ABU6SvEN+hz5m6
 4W0oi+fgd3qN83gwTEtUSDslCMsouPjPuKfI1fhUFjoY7oDlWGwMTQlqEZu9zHI8zp
 7H50rnnIqWgQ9xZNhf/qAS6vl6ZzVpVjrJP2i72DWrGDsm4aoMaTNkI6LBjD+Xmhgk
 /WA0ps2BrRK0if0PV+XHc+GMU5T1jcNZOsG1Lal4430mK10EBBVcr5/MnBprEGe0Qc
 Bh7BWeH8GFlUyfqWRgo0pZke9CcMlYGviGLIhwBvWpubKsZvC5HhG8LH/p2/eQWHbv
 Gg2nZrF/hZkRQ==
Message-ID: <6c353eaa-1609-4a72-a557-0b81ee337c5f@denx.de>
Date: Wed, 11 Sep 2024 13:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix chip erase timeout issue
To: Ye Li <ye.li@nxp.com>, jagan@amarulasolutions.com, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com
References: <1726051530-56280-1-git-send-email-ye.li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1726051530-56280-1-git-send-email-ye.li@nxp.com>
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

On 9/11/24 12:45 PM, Ye Li wrote:
> Chip erase support was added to spi_nor_erase, but the timeout
> for polling SR ready is not updated and still for sector erase.
> So the timeout value is not enough for chip erase on some NOR flash.
> Follow kernel implementation to set new timeout for chip erase.

Is there a matching Linux kernel commit you could point to, from which 
this was ported over ?

> Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/mtd/spi/spi-nor-core.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index aea611fef523..338e5856337e 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -44,6 +44,12 @@
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
> @@ -991,6 +997,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   	bool addr_known = false;
>   	u32 addr, len, rem;
>   	int ret, err;
> +	unsigned long timeout = 0;

Keep the variables in reverse xmas-tree please.

>   	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
>   		(long long)instr->len);
> @@ -1026,6 +1033,15 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>   		if (len == mtd->size &&
>   		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
>   			ret = spi_nor_erase_chip(nor);
> +			/*
> +			 * Scale the timeout linearly with the size of the flash, with
> +			 * a minimum calibrated to an old 2MB flash. We could try to
> +			 * pull these from CFI/SFDP, but these values should be good
> +			 * enough for now.
> +			 */
> +			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
> +				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
> +				      (unsigned long)(mtd->size / SZ_2M));
Is the type cast needed ?

Thanks
