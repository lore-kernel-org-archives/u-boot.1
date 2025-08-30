Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD05CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6135783914;
	Sat, 30 Aug 2025 17:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OHVjCyRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2AC683914; Sat, 30 Aug 2025 17:27:56 +0200 (CEST)
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com
 [220.197.31.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52750838E7
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98fa;
 Sat, 30 Aug 2025 23:27:50 +0800 (GMT+08:00)
Message-ID: <07f0b889-3666-4d18-9470-83027956f23f@rock-chips.com>
Date: Sat, 30 Aug 2025 23:27:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] power: rk8xx: allow to customize RK806 reset mode
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
 <20250813-rk8xx-rst-fun-v2-5-a2223e17cb2c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250813-rk8xx-rst-fun-v2-5-a2223e17cb2c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb978d8f03afkunm1110e510416435
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEhNVk5IT0lOTEhNTB5PTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OHVjCyRAzCNZE7sxk1mfQ9Ak+8EiAJBvKv86jkqWZAMY4s0magb34liTyY18/fAqLEFHTTq2huLzWNV7itGbLYz65o3juxY0AMcBAQbRbOGfgJhHpT3Q4w6HKKtwr/UeNHWAYWm3SrLA5WKu3qKzHpY0vqlgkw/AY8uPA46EuAg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=D0Q/o9QNpTsPd0lu4gwB7XSQvKU+V2yhsqSS5+Ws+yE=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/8/13 22:07, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The RK806 PMIC has a bitfield for configuring the restart/reset behavior
> (which I assume Rockchip calls "function") whenever the PMIC is reset
> either programmatically (c.f. DEV_RST in the datasheet) or via PWRCTRL
> or RESETB pins.
>
> For RK806, the following values are possible for RST_FUN:
>
> 0b00 means "Restart PMU"
> 0b01 means "Reset all the power off reset registers, forcing
> 	the state to switch to ACTIVE mode"
> 0b10 means "Reset all the power off reset registers, forcing
> 	the state to switch to ACTIVE mode, and simultaneously
> 	pull down the RESETB PIN for 5mS before releasing"
> 0b11 means the same as for 0b10 just above.
>
> This adds the appropriate logic in the driver to parse the new
> rockchip,reset-mode DT property to pass this information. It just
> happens that the values in the binding match the values to write in the
> bitfield so no mapping is necessary.
>
> For backward compatibility reasons, if the property is missing we set it
> to 0b10 (i.e. BIT(7)) like before this commit was merged instead of
> leaving it untouched like in the kernel driver.
>
> Note that this does nothing useful for U-Boot at the moment as the ways
> to reset the device (e.g. via `reset` command) doesn't interact with the
> RK8xx PMIC and simply does a CPU reset.
> Considering the upstream Linux kernel left this register untouched until
> (assumed) v6.17[1], this is useful for cases in which the U-Boot
> bootloader has this patch (and running with a DT with
> rockchip,reset-mode property set) and running an upstream kernel before
> (assumed) v6.17, or alternatively later without the property in the
> kernel DT.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=87b48d86b77686013f5c2a8866ed299312b671db
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/pmic/rk8xx.c | 21 ++++++++++++---------
>   include/power/rk8xx_pmic.h |  2 ++
>   2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 3bc696d4caaa68f87fd49810682616c34bafb23b..d11f7a7886e8074e7b7833c8a51ea24d77fede34 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -89,11 +89,6 @@ void rk8xx_off_for_plugin(struct udevice *dev)
>   	}
>   }
>   
> -static struct reg_data rk806_init_reg[] = {
> -	/* RST_FUN */
> -	{ RK806_REG_SYS_CFG3, BIT(7), GENMASK(7, 6)},
> -};
> -
>   static struct reg_data rk817_init_reg[] = {
>   /* enable the under-voltage protection,
>    * the under-voltage protection will shutdown the LDO3 and reset the PMIC
> @@ -306,12 +301,20 @@ static int rk8xx_probe(struct udevice *dev)
>   		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
>   		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>   		break;
> -	case RK806_ID:
> +	case RK806_ID: {
> +		u32 rst_fun = 2;
> +
>   		on_source = RK806_ON_SOURCE;
>   		off_source = RK806_OFF_SOURCE;
> -		init_data = rk806_init_reg;
> -		init_data_num = ARRAY_SIZE(rk806_init_reg);
> -		break;
> +
> +		ret = dev_read_u32(dev, "rockchip,reset-mode", &rst_fun);
> +		if (ret)
> +			debug("rockchip,reset-mode property missing, defaulting to %d\n",
> +			      rst_fun);
> +
> +		pmic_clrsetbits(dev, RK806_REG_SYS_CFG3, RK806_RST_FUN_MSK,
> +				FIELD_PREP(RK806_RST_FUN_MSK, rst_fun));
> +		break; }
>   	default:
>   		printf("Unknown PMIC: RK%x!!\n", show_variant);
>   		return -EINVAL;
> diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
> index 31221aa46b60cf995fd02f5894b3ee97a7475f8a..913b6ebe6d96e08bcfab509cff5db7da8358784a 100644
> --- a/include/power/rk8xx_pmic.h
> +++ b/include/power/rk8xx_pmic.h
> @@ -212,6 +212,8 @@ enum {
>   #define RK817_POWER_EN_SAVE0	0x99
>   #define RK817_POWER_EN_SAVE1	0xa4
>   
> +#define RK806_RST_FUN_MSK	GENMASK(7, 6)
> +
>   #define RK806_POWER_EN(x)			(0x00 + (x))
>   /* POWER_ENx register lower 4 bits are write-protected unless the associated top bit is set */
>   #define RK806_POWER_EN_CLRSETBITS(bit, val)	(((val) << (bit)) | (1 << ((bit) + 4)))
>
