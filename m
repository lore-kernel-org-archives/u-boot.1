Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9DFC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BDC884CA;
	Wed, 17 Jul 2024 09:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aU7M+H3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1407884CA; Wed, 17 Jul 2024 09:02:57 +0200 (CEST)
Received: from mail-m12775.qiye.163.com (mail-m12775.qiye.163.com
 [115.236.127.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010EF884C6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aU7M+H3Riz+72yu2Ue3j7dt46JoSsX6KOPhaaDTL9IniesFsyxTy4XlFF5iI4dwx+cUyy9rNxPEZ6KuGeIwA73C7i6IC/G9ZsanoxxhITXM8SIdq4xxc6RaTBdMJahtND/5V4X6c2pH7tecKgbiHV2rCZQar9kqklLQBGmd34XU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=atnXB6DZw9MzVKljTs47W3/9lO3Rw90lUJ56Cd+zI6w=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 038AE9005C3;
 Wed, 17 Jul 2024 15:02:45 +0800 (CST)
Message-ID: <7edbf0ee-63dc-43e9-824b-6c698137fa4a@rock-chips.com>
Date: Wed, 17 Jul 2024 15:02:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] board: rock5b-rk3588: add USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass
 <sjg@chromium.org>, Soeren Moch <smoch@web.de>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-4-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240604163546.60225-4-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwdS1ZIGkgeHR5PTkkYHUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bf802b8a03a9kunm038ae9005c3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6ITo6CTI#DBIuPyMpNE4c
 TjgaCj9VSlVKTElKSkJCTE1NQ0hPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQ01DNwY+
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

Hi Sebastian,

On 2024/6/5 00:33, Sebastian Reichel wrote:
> Enable support for the fusb302 USB Type-C controller.
>
> This will do early USB PD (power deliver) negotiation, which must happen
> within 5 seconds after the USB-C connector has plugged in according to
> the specification. It takes almost 5 seconds to go through the bootchain
> on Rock 5B and jump to the operating system. When the Linux initializes
> the fusb302 usually 20-30 seconds have gone since the device has been
> plugged, which is far too late. The USB PD power source reacts with a
> hard reset, which disables VBUS for some time. This is not a problem for
> a battery driven device, but Rock 5B will loose its power-supply and
> reset. By initializing PD in U-Boot, this can be avoided.
>
> The DT node can be sourced from the Linux kernel DT in the future,
> but to get things going it makes sense to add it in the U-Boot
> specific file for now. Because of the reset issue it is important
> to get support in U-Boot first.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   | 28 +++++++++++++++++++++++
>   board/radxa/rock5b-rk3588/Makefile        |  6 +++++
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 22 ++++++++++++++++++
>   configs/rock5b-rk3588_defconfig           |  4 ++++

Please split the dts and defconfig changes to a separate patch.

Thanks,
- Kever
>   4 files changed, 60 insertions(+)
>   create mode 100644 board/radxa/rock5b-rk3588/Makefile
>   create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 8e318e624a85..e93795359ece 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2023 Collabora Ltd.
>    */
>   
> +#include <dt-bindings/usb/pd.h>
>   #include "rk3588-u-boot.dtsi"
>   
>   &fspim2_pins {
> @@ -65,3 +66,30 @@
>   	dr_mode = "host";
>   	status = "okay";
>   };
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4m1_xfer>;
> +	status = "okay";
> +
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "sink";
> +			try-power-role = "sink";
> +			op-sink-microwatt = <1000000>;
> +			sink-pdos =
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> +				<PDO_VAR(5000, 20000, 5000)>;
> +		};
> +	};
> +};
> diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
> new file mode 100644
> index 000000000000..95d813596da4
> --- /dev/null
> +++ b/board/radxa/rock5b-rk3588/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +# Copyright (c) 2022 Collabora Ltd.
> +#
> +
> +obj-y += rock5b-rk3588.o
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> new file mode 100644
> index 000000000000..75856ccb1288
> --- /dev/null
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023-2024 Collabora Ltd.
> + */
> +
> +#include <usb/tcpm.h>
> +
> +#ifdef CONFIG_MISC_INIT_R
> +int misc_init_r(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = tcpm_get("usb-typec@22", &dev);
> +	if (ret) {
> +		printf("Failed to probe Type-C controller\n");
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +#endif
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index fc118cea7bae..e368b0439d1d 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -102,3 +102,7 @@ CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
> +CONFIG_TYPEC_TCPM=y
> +CONFIG_TYPEC_FUSB302=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_CMD_TCPM=y
