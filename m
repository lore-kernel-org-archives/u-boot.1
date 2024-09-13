Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A242FC6161
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 16:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACCE88770;
	Fri, 13 Sep 2024 18:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726244508;
	bh=V9S2PHGzGsmg5eFTIhAoPiJH/+e+Tz3RgQBhcQevB74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xpQzLmAsaSBHZpd3IsdhbetPZh9/VXb5LNH5m/+2zfjEd0JuqDOSDvWBKA1Z50Oud
	 7Bq+feJpcvzGw3FmZ8EU35B8zuxcPH8BDnx/afMCCmgZFuBBvIHFxju1PCKUr/C5oc
	 zDfeKZlwH38VywLOs80mI4e2g7Ec9ME/zXScHZ2gbE3y43bv0UcCFTxxxe9/cR1dpQ
	 mcrN71+yYhlCWwlQOUx2bH1nOepMxKxELS4w64eN/i4ZQhlxyGKw8K3DYMrVprIHj8
	 mxIfXhwLFeU8Qy+M4QdTQ7t3jPEQvM8bHqYiaBTU8IPeAQGaROMRwFfNeJBsHJs4CP
	 OKoLrWA1UG2wQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 82AB9886E7;
 Fri, 13 Sep 2024 18:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726244507;
 bh=V9S2PHGzGsmg5eFTIhAoPiJH/+e+Tz3RgQBhcQevB74=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DjMkCpV9r9yvaknQPjMcjGd1gmGGztXphl4J3SDhzwkGL/FMnGhfsS1KqVIhfig6F
 1INrzmAndJtp54tOvZLz2eB7QiN8cQ0bFsMwA9f98QYK8cC22Pm8M7i8b+khahdrFI
 HlmYobadF4htzhM3B5XoWGgjclgd1XDmHSxt+GXP0Nu347q1T4iyIsq0SeScmgcuJs
 x3AYOyLyOUQY5qpsYpfMDtUuEK524f5zVszOnpF5PALxUmeRQdAaPLfg8u4TyAhhql
 uF31TsPbWSXEPfzB7bCXAg5wVaSpsam4iKQjuU7TmX0aHoRlRzjGNhsn46fThaEwiW
 wigtZJ5sfEHgQ==
Message-ID: <e64153d2-5a05-4f97-ba80-725d9b21dba6@denx.de>
Date: Fri, 13 Sep 2024 18:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: Fix chip erase timeout issue
To: Ye Li <ye.li@nxp.com>, jagan@amarulasolutions.com, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com
References: <1726239383-12808-1-git-send-email-ye.li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1726239383-12808-1-git-send-email-ye.li@nxp.com>
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

On 9/13/24 4:56 PM, Ye Li wrote:
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
> Changes in v3:
>   - Replace spi_nor_wait_till_ready
> 
> Changes in v2:
>   - use do_div for u64
>   - Keep the variables in reverse xmas-tree
>   - Add kernel commit info
> 
>   drivers/mtd/spi/spi-nor-core.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ce01d42cfe0f..1bddf7cf755f 100644
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
Why is DEFAULT_READY_WAIT_JIFFIES == CHIP_ERASE_2MB_READY_WAIT_JIFFIES ?
If that is correct, why do we need CHIP_ERASE_2MB_READY_WAIT_JIFFIES at 
all ? It think it is best to remove CHIP_ERASE_2MB_READY_WAIT_JIFFIES 
and always use DEFAULT_READY_WAIT_JIFFIES .

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
