Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C12C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F5C887E6;
	Fri,  9 Aug 2024 11:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="a4LMO5XO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8408895D; Fri,  9 Aug 2024 11:24:31 +0200 (CEST)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08996887B4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=a4LMO5XOBLE1yTzzv//BXf6w7O+3cd9VpidA2coRxo429qeCh8J7j5GuqYWiqRjeu3amXduXmFRckM5OetFfb1EgIeS+Ffwuw7SIA13XItHxIkpfVjyEzpZqID2jgtrkhfLmHOX9spQfXIyE5HNqr1JPPjrcWadEDKB6hhIOdQQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bYk1TA15ifQ3oqbW8YWcmHH6QiaW3kdl54inNYkddXg=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7D019900588;
 Fri,  9 Aug 2024 17:24:19 +0800 (CST)
Message-ID: <f7445e4f-3d33-4597-9a87-63ca722966c4@rock-chips.com>
Date: Fri, 9 Aug 2024 17:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] rockchip: rk3588-rock-5b: Add USB-C controller to
 u-boot.dtsi
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-6-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802180027.139193-6-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU9PVk9ITB8aQx5PHhpLTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9136740b1703a9kunm7d019900588
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MlE6PDo*IjI2Aw45L1YZNjwD
 IxoaCS9VSlVKTElISkJOT01LQkpKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhCSUg3Bg++
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


On 2024/8/3 01:59, Sebastian Reichel wrote:
> Add USB-C controller (fusb302), which will be used by U-Boot to
> initialize USB-PD. This is needed, because USB-PD communication
> must happen within 5 seconds after the USB-C connector got plugged.
> On my Rock 5B it often takes 5 seconds to jump to the Linux binary,
> so it must happen before Linux is initialized.
>
> This adds the DT node to the U-Boot specific file, since the Linux
> kernel DT currently does not describe it to avoid a system reset.
> The plan is to add it to the Linux DT with status = 'fail' and then
> let U-Boot mark it as status = 'okay' if it properly dealt with
> early USB-PD initialization. Until the Kernel DT has the node, let's
> add it in U-Boot to get things going.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 28 +++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
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
