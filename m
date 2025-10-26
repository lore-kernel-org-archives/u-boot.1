Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0582CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38266838E3;
	Sun, 26 Oct 2025 16:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dwkAX1/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E81C832AD; Sun, 26 Oct 2025 16:46:01 +0100 (CET)
Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com
 [220.197.32.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA994838E7
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27374902e;
 Sun, 26 Oct 2025 23:45:54 +0800 (GMT+08:00)
Message-ID: <ac5d43d0-a382-4ba2-9c03-81e8d4bc70f7@rock-chips.com>
Date: Sun, 26 Oct 2025 23:45:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] rockchip: odroid-go2: Use env from same storage
 FIT was loaded from
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2132943903afkunmaadeceb04d3419
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTExOVhlCQkpIHhhLHxpPGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=dwkAX1/EZ3HmhBIuvWrp/puR2OXjnKgHYxt2XxUpyvJblMHAWLGg69l32MCqdgKS2NqQj5KDNcYtZ9Z5UqkWQh4SNHCRGSoZCULBXVW7rneDh71A3Lm84Hz1k2zUd/gAsXLbWPPiSn+h1TN4WelEZ7aYCJjcpPcQPIRJEzV9Vxc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9d1g9DBrlP/rto3ThE+8peFaoTQS+NrW8HGamvu8Bbk=;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> Change to dynamically select what storage media to use for the U-Boot
> environment depending on from what storage media the FIT images was
> loaded from, fall back to use env from nowhere.
>
>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>    Trying to boot from MMC1
>    ...
>    Loading Environment from MMC... Reading from MMC(0)...
>
> or
>
>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>    Trying to boot from SPI
>    ...
>    Loading Environment from SPIFlash...
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect r-b tag
> ---
>   board/hardkernel/odroid_go2/Kconfig |  1 +
>   board/hardkernel/odroid_go2/go2.c   | 34 +++++++++++++++++++++++++++++
>   configs/odroid-go2_defconfig        |  2 ++
>   3 files changed, 37 insertions(+)
>
> diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
> index dd6e366282e3..6487335972b8 100644
> --- a/board/hardkernel/odroid_go2/Kconfig
> +++ b/board/hardkernel/odroid_go2/Kconfig
> @@ -13,6 +13,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>   	def_bool y
>   	select ADC
>   	select BOARD_TYPES
> +	select ENV_IS_NOWHERE
>   	select SPL_ADC
>   
>   endif
> diff --git a/board/hardkernel/odroid_go2/go2.c b/board/hardkernel/odroid_go2/go2.c
> index 9d9f3cee36a5..ae32ea87af88 100644
> --- a/board/hardkernel/odroid_go2/go2.c
> +++ b/board/hardkernel/odroid_go2/go2.c
> @@ -7,7 +7,9 @@
>   #include <adc.h>
>   #include <asm/io.h>
>   #include <dm.h>
> +#include <dm/uclass-internal.h>
>   #include <env.h>
> +#include <env_internal.h>
>   #include <stdlib.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -129,3 +131,35 @@ int board_fit_config_name_match(const char *name)
>   
>   	return -EINVAL;
>   }
> +
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
> +	const char *boot_device;
> +	struct udevice *dev;
> +	ofnode node;
> +
> +	if (prio)
> +		return ENVL_UNKNOWN;
> +
> +	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
> +		return ENVL_NOWHERE;
> +	}
> +
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	node = ofnode_path(boot_device);
> +	if (!ofnode_valid(node))
> +		return ENVL_NOWHERE;
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, node, &dev))
> +		return ENVL_SPI_FLASH;
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_MMC, node, &dev))
> +		return ENVL_MMC;
> +
> +	return ENVL_NOWHERE;
> +}
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 05d9f9c09dee..185d0f1d7c5f 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -65,6 +65,8 @@ CONFIG_OF_LIVE=y
>   CONFIG_OF_LIST="rockchip/rk3326-odroid-go2 rockchip/rk3326-odroid-go2-v11 rockchip/rk3326-odroid-go3"
>   CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

