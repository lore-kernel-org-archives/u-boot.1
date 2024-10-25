Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018EBD0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956048902E;
	Fri, 25 Oct 2024 14:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Qk+vxdXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFFE8902E; Fri, 25 Oct 2024 14:37:27 +0200 (CEST)
Received: from mail-m118114.qiye.163.com (mail-m118114.qiye.163.com
 [115.236.118.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EAA89021
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec473c4;
 Fri, 25 Oct 2024 20:37:06 +0800 (GMT+08:00)
Message-ID: <2a74faea-a558-4a14-af0e-573573903efa@rock-chips.com>
Date: Fri, 25 Oct 2024 20:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6
 LTS
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhKSFZKSB4YSUoZGk8ZQ0lWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3ae353209d6kunmec473c4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6Nxw4STIvCxdCElYSAjUB
 NAowFB1VSlVKTElCQ05CQ0lDSkNMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0NNNwY+
DKIM-Signature: a=rsa-sha256;
 b=Qk+vxdXB8DRpUlYcIk2815hlE1YriO6IOzAQsyNt1lrBLLKluruKeVDm1ho8eKuLRNq+Bqa5AsZGDs4shoOdf5YmNqayhKF2M1/3Yw3HWAmpDVlEjEjHVE7OChXgl9pLYeGLUO19PXkAY2kZ1j5PN87m+1At/HqLc4jNJkCUtMg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oMlckuBBnd/waLexg5m1H8S3dgGTcTArW/9ffoawk8A=;
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


On 2024/10/18 04:00, Jonas Karlman wrote:
> Update defconfig to enable features included in pending upstream DT and
> implement board_fit_config_name_match() to load correct DT for LTS and
> non-LTS version of the NanoPC-T6.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  5 ++
>   board/friendlyelec/nanopc-t6-rk3588/Makefile  |  3 +
>   .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       | 59 +++++++++++++++++++
>   configs/nanopc-t6-rk3588_defconfig            | 12 ++++
>   4 files changed, 79 insertions(+)
>   create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
>   create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
>
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> index 3261b2c42b4b..8465dcd4c9cd 100644
> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> @@ -11,6 +11,11 @@
>   	bootph-some-ram;
>   };
>   
> +&saradc {
> +	bootph-pre-ram;
> +	vdd-microvolts = <1800000>;
> +};
> +
>   &sfc {
>   	flash@0 {
>   		bootph-pre-ram;
> diff --git a/board/friendlyelec/nanopc-t6-rk3588/Makefile b/board/friendlyelec/nanopc-t6-rk3588/Makefile
> new file mode 100644
> index 000000000000..2858e0d7c26f
> --- /dev/null
> +++ b/board/friendlyelec/nanopc-t6-rk3588/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += nanopc-t6-rk3588.o
> diff --git a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
> new file mode 100644
> index 000000000000..05cf55e4291d
> --- /dev/null
> +++ b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <adc.h>
> +#include <env.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +
> +#define HW_ID_CHANNEL	5
> +
> +struct board_model {
> +	unsigned int low;
> +	unsigned int high;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{  348,  528, "rockchip/rk3588-nanopc-t6.dtb" },
> +	{ 1957, 2137, "rockchip/rk3588-nanopc-t6-lts.dtb" },
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val;
> +	int i, ret;
> +
> +	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
> +	if (ret)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
> +		unsigned int min = board_models[i].low;
> +		unsigned int max = board_models[i].high;
> +
> +		if (min <= val && val <= max)
> +			return &board_models[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model)
> +		env_set("fdtfile", model->fdtfile);
> +
> +	return 0;
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model && !strcmp(name, model->fdtfile))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
> index d62c8168a8d6..772b7df15557 100644
> --- a/configs/nanopc-t6-rk3588_defconfig
> +++ b/configs/nanopc-t6-rk3588_defconfig
> @@ -32,6 +32,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> +CONFIG_CMD_ADC=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -43,13 +44,20 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> +CONFIG_OF_LIST="rockchip/rk3588-nanopc-t6 rockchip/rk3588-nanopc-t6-lts"
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_ADC=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
> @@ -69,12 +77,16 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
> +CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
