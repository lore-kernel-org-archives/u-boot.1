Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C66FD0C606
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA12E8906D;
	Fri, 25 Oct 2024 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XepechRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D7B89082; Fri, 25 Oct 2024 14:40:43 +0200 (CEST)
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com
 [220.197.32.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DDD89068
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec474b2;
 Fri, 25 Oct 2024 20:40:32 +0800 (GMT+08:00)
Message-ID: <b1ceeadf-7f35-4128-88a1-ffdcef2b031b@rock-chips.com>
Date: Fri, 25 Oct 2024 20:40:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: rockchip: add NanoPC-T6 LTS
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgaGVYZGEoeHR9PGB5OSB1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3b1598409d6kunmec474b2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Pgw5NDIsCxcrATo8LzEx
 DUMKCzxVSlVKTElCQ01LS0hPS0tOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0xPNwY+
DKIM-Signature: a=rsa-sha256;
 b=XepechRdqerzVpXJpdVm7e1VSAIhUWQ0VID9fEhEbaRdcPQhMSHo6JL0IHZAOeUHlC1EmZDwgs9MZWhTiuXH/imCVHuylMuW6LYme06SrjXzaKXhX6Ii9wtHhSwxuxzC62bUqFMQaPgM7vH0CYweRFcSvznSjR0oduD6zBLDEIc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=DXfQ1itzV1V1erCo308UvowGg7qDcG4Ptcjst8l70ho=;
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
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> In the LTS (2310) version the miniPCIe slot got removed and USB 2.0
> setup has changed. There are two external accessible ports and two ports
> on the internal header.
>
> There is an on-board USB hub which provides:
> - one external connector (bottom one)
> - two internal ports on pin header
> - one port for m.2 E connector
>
> The top USB 2.0 connector comes directly from the SoC.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-4-edff247e8c02@linaro.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: db1dcbe5f752d423421f77d54d246398b196f670 ]
>
> (cherry picked from commit f4a834fbc8cdb40fddd63d083e8d1c6189ba62dc)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../arm64/rockchip/rk3588-nanopc-t6-lts.dts   | 60 +++++++++++++++++++
>   1 file changed, 60 insertions(+)
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
> new file mode 100644
> index 000000000000..2d92bbb4027d
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2023 Thomas McKahan
> + * Copyright (c) 2024 Linaro Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "rk3588-nanopc-t6.dtsi"
> +
> +/ {
> +	model = "FriendlyElec NanoPC-T6 LTS";
> +	compatible = "friendlyarm,nanopc-t6-lts", "rockchip,rk3588";
> +
> +	/* provide power for on-board USB 2.0 hub */
> +	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb20_host_pwren>;
> +		pinctrl-names = "default";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "vcc5v0_usb20_host";
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&pinctrl {
> +	usb {
> +		usb20_host_pwren: usb20-host-pwren {
> +			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	phy-supply = <&vcc5v0_usb20_host>;
> +};
> +
> +&usbdp_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
