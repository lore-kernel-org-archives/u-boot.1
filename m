Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B02C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE72B82A39;
	Fri,  6 Jun 2025 11:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZMU/E8j6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863E282AAF; Fri,  6 Jun 2025 11:20:52 +0200 (CEST)
Received: from mail-m3299.qiye.163.com (mail-m3299.qiye.163.com
 [220.197.32.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104F5803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c35c159;
 Fri, 6 Jun 2025 17:20:42 +0800 (GMT+08:00)
Message-ID: <0d3f61c6-c235-40d8-9195-9e35d3b092bb@rock-chips.com>
Date: Fri, 6 Jun 2025 17:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250523165406.40915-1-justin@tidylabs.net>
 <20250523165406.40915-4-justin@tidylabs.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250523165406.40915-4-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB0YVhhCT0IfQx0eQ05LGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448ae50203afkunm00abd6821ec0d7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06PAw5CDE5ExlOHks8SA0S
 MTQaCyxVSlVKTE9CSUtKTU9OTkxCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhCTE03Bg++
DKIM-Signature: a=rsa-sha256;
 b=ZMU/E8j6sKpE7Pb6WAjsT9AKG2/9NsDaJQYDdLV5y9yJ4vt9PpcOl7Kyc5/U1UgfT5grwzyZ/n0XCzRtNt5aoD46oebibXK88SYFADns6U+qnadgkkhDf9Vb519xMU3rYkvPTJTC85l6SPbCKrzpohAo5UHu85meKbAfWpkj5oQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=h59ygaVOALaqykRYdOMkSCgGiA7zUyxUd8fuW+KMQsw=;
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


On 2025/5/24 00:53, Justin Klaassen wrote:
> Allows use of the regulator functions of the RK8XX PMIC in SPL, which is
> necessary to support the functionality of the Rockchip IO-domain driver
> on relevant platforms.
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig
>
>   drivers/power/regulator/Kconfig | 9 +++++++++
>   drivers/power/regulator/rk8xx.c | 8 ++------
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 7ed435f0202..65b99e89656 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -264,6 +264,15 @@ config REGULATOR_RK8XX
>   	by the PMIC device. This driver is controlled by a device tree node
>   	which includes voltage limits.
>   
> +config SPL_REGULATOR_RK8XX
> +	bool "Enable driver for RK8XX regulators in SPL"
> +	depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
> +	help
> +	  Enable support for the regulator functions of the RK8XX PMIC in SPL. The
> +	  driver implements get/set api for the various BUCKS and LDOs supported
> +	  by the PMIC device. This driver is controlled by a device tree node
> +	  which includes voltage limits.
> +
>   config DM_REGULATOR_S2MPS11
>   	bool "Enable driver for S2MPS11 regulator"
>   	depends on DM_REGULATOR && PMIC_S2MPS11
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 368675ebb9f..88453bb7bdb 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -16,10 +16,6 @@
>   #include <power/pmic.h>
>   #include <power/regulator.h>
>   
> -#ifndef CONFIG_XPL_BUILD
> -#define ENABLE_DRIVER
> -#endif
> -
>   /* Not used or exisit register and configure */
>   #define NA			0xff
>   
> @@ -202,7 +198,7 @@ static const struct rk8xx_reg_info rk818_buck[] = {
>   	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>   };
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static const struct rk8xx_reg_info rk806_nldo[] = {
>   	/* nldo 1 */
>   	{  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> @@ -454,7 +450,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   	return ret;
>   }
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvolt)
>   {
>   	const struct rk8xx_reg_info *info = get_buck_reg(pmic, buck, uvolt);
