Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E31C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D1487D3C;
	Mon, 11 Mar 2024 15:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="VG9S7eIY";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="hBAKmq71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1481187D3C; Mon, 11 Mar 2024 15:37:51 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E7787D0A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710167861; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=T99pv6N3qhhCiucY6sSbMAmwQEn1wL/3MJfe7EbGsfyL9hacJ89ZhdURmBlUWxvt1I
 KYNQh5CU/fn0yoJ4kPxtiqYejuYrfey0ATcpI/b9+foWj8+t0JdPjmNDOWDllJu56QEt
 dsaCZOhyInL92OtBCgJRnm12UBdObMKq/XGpMIRxmtQRF688D8XkOFOCXVrySMwm4L0t
 /6mYqtIpMd1lI1P82CMwm9+qxNzT+Tv1ZLMzHcv3rWJN772YjRPAe7RgXKt1JtH1aFhC
 9AtWgfA4+1mEfWqx4zVn8qLAidTDv7Zo4cobgOn5PaXkCYC0FuOCUbxCGGx/mpYgaeEg
 rHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710167861;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=GTdB+RoSniuTKtGzfDiVZvhaxaSVJi+7uIJisULWIXo=;
 b=etGshYR+dgZCHq3uec/WCokAeHZewKofxkNDj34BhZx1yLVQbLHE0nHTOrwBlpzT+O
 zf84Huxb1IRXa9knqbSeKAlp3/PgCcmi7ZjOv/UgrgOO+/aIFOWTgDB/9KUF/MGSai1j
 UeSnOKckTqt9K+YizY6JXt4pbnPRkEsRxM/W46ZNiu703blTW763s5gUGj2xHMhHOSVz
 7fLVQKaLnESvagxtyqHZxZAIirkB5/XcTuGxWkl6O5W3tNn+MZBGXE6wV/neZNz+xDLb
 XYXevGl+D1pJbcnn+L7RQJXFfZ88Nf6vQ5+7Nbfu9I+EexvytwSdR8J4t/AMnqXt2hnO
 Dmyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710167861;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=GTdB+RoSniuTKtGzfDiVZvhaxaSVJi+7uIJisULWIXo=;
 b=VG9S7eIYPSTVsNM0CtWYJl7TRbY7ZkJsNsXm2JQmKeb/Z+Bv8LXIsO5jtDeZgS/izg
 ue5XNBgms7WOURyy32EwW+G2r0CaS0XqdfnjJ2LqI6ZSMDAS7NeAKDiP8Kuxa7pPMmwP
 RJshW98CNGtixK4vLTrnmJeFH/8JF1kobMIGhV/waRqst98IvJQXj4apDv2LbnY2BEyg
 tbiCTE1Z5KdCQT0rgXA6CAHTA6MUGt8YFDWQn0lf7O/rsDFcBdElFuVCdxVzmbeDl0X3
 Pf2lGRdDDoxWgs/itOuiKm10MBCit5j/hSyTUWjRETpzUhQCXbf7vHcTF/1/Wng+xL3y
 OCpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710167861;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=GTdB+RoSniuTKtGzfDiVZvhaxaSVJi+7uIJisULWIXo=;
 b=hBAKmq71H8ne428q9MUFpJfBgozxagS1jyTeiBBeYHqi7mpTcmdzLt3/mTxzcXDzv2
 /8HOuDt7y3LkUING/kCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8pqN1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.2.0 DYNA|AUTH)
 with ESMTPSA id ufb40802BEbec6X
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 11 Mar 2024 15:37:40 +0100 (CET)
Date: Mon, 11 Mar 2024 15:37:39 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v2 5/5] board: add support for Schneider HMIBSC board
Message-ID: <Ze8XM9cvZt7fSYg5@gerhold.net>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-6-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311111027.44577-6-sumit.garg@linaro.org>
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

On Mon, Mar 11, 2024 at 04:40:26PM +0530, Sumit Garg wrote:
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 2GiB RAM
> - 64GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> 
> Features enabled in U-Boot:
> - RAUC updates
> - Environment protection
> - USB based ethernet adaptors
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I'm entirely sure which requirements or conventions we are following for
adding device trees directly to U-Boot instead of Linux. My understanding
is that the goal is to get U-Boot DTs as close as possible to the
upstream Linux DTs, so I effectively looked at this as if it were
submitted to linux-arm-msm. I think most of my comments should be
trivial to fix anyway without much effort. :-)

With the comments fixed it would be likely also easy to get it in
upstream in Linux, so I wonder if it's worth first adding it here in
U-Boot (I know you discussed this on v1 already a bit).

> ---
>  arch/arm/dts/apq8016-hmibsc.dts    | 496 +++++++++++++++++++++++++++++
>  board/schneider/hmibsc/MAINTAINERS |   6 +
>  configs/hmibsc_defconfig           |  87 +++++
>  doc/board/index.rst                |   1 +
>  doc/board/schneider/hmibsc.rst     |  45 +++
>  doc/board/schneider/index.rst      |   9 +
>  include/configs/hmibsc.h           |  57 ++++
>  7 files changed, 701 insertions(+)
>  create mode 100644 arch/arm/dts/apq8016-hmibsc.dts
>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>  create mode 100644 configs/hmibsc_defconfig
>  create mode 100644 doc/board/schneider/hmibsc.rst
>  create mode 100644 doc/board/schneider/index.rst
>  create mode 100644 include/configs/hmibsc.h
> 
> diff --git a/arch/arm/dts/apq8016-hmibsc.dts b/arch/arm/dts/apq8016-hmibsc.dts
> new file mode 100644
> index 00000000000..490ab5fd2fa
> --- /dev/null
> +++ b/arch/arm/dts/apq8016-hmibsc.dts
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8916-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Schneider Electric HMIBSC Board";
> +	compatible = "qcom,apq8016-hmibsc", "qcom,apq8016";

A Schneider Electric specific compatible would be likely more accurate,
since I assume this board wasn't designed by Qualcomm?

I would personally also prefer to use the "apq8016-<vendor>-<board>.dts"
naming convention that we typically use for smartphones/tablets
upstream, although you can also keep it as-is since e.g. apq8039-t2.dts
is also named without vendor.

> +
> +	aliases {
> +		serial0 = &blsp_uart1;
> +		serial1 = &blsp_uart2;
> +		usid0 = &pm8916_0;
> +		i2c1 = &blsp_i2c6;
> +		i2c3 = &blsp_i2c4;
> +		i2c4 = &blsp_i2c3;
> +		spi0 = &blsp_spi5;

You might want to add mmcX aliases here to ensure consistent naming of
eMMC and SD card (this used to be in msm8916.dtsi but not anymore).

> [...]
> +&blsp_i2c6 {
> +	status = "okay";
> +	label = "I2C1";
> +
> +	rtc1: s35390a@30 {

rtc@

> +		compatible = "sii,s35390a";
> +		reg = <0x30>;
> +	};
> +
> +	eeprom1: 24c256@50 {

eeprom@

> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&blsp_i2c3 {

i2c3 should come before i2c6 (sorted alphabetically)

> +	status = "okay";
> +	label = "I2C4";
> +
> +	eeprom: 24c32@50 {

eeprom@

> +		compatible = "onsemi,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> [...]
> +
> +&pm8916_0 {
> +	pon@800 {
> +		pwrkey {
> +			status = "okay";
> +			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;

This line would really benefit from a comment that explains what exactly
it does and why this is done. :)

It looks like you are redefining the pwrkey with the resin interrupt.
I guess your goal is to have KEY_POWER assigned to the resin pin?
In that case, I think it would be cleaner to describe this using:

&pm8916_resin {
	status = "okay";
	linux,code = <KEY_POWER>;
};

and leave the pwrkey node alone (or perhaps disable it if it causes
trouble).

Aside from the confusion, I think overriding only the interrupt of the
pwrkey will also misbehave in unexpected ways since e.g. the Linux
pm8941-pwrkey driver will still write the configured debounce time and
pull up to the pwrkey registers, and not to the resin ones.

> +		};
> +	};
> +};
> +
> [...]
> +
> +&tlmm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio_rs232_high &gpio_rs232_low>;
> +
> +	sdc2_cd_default: sdc2-cd-default-state {
> +		pins = "gpio38";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	adv7533_int_active: adv533-int-active-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_int_suspend: adv7533-int-suspend-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_active: adv7533-switch-active-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	adv7533_switch_suspend: adv7533-switch-suspend-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_key_volp_n_default: msm-key-volp-n-default-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_rs232_high: gpio_rs232_high {

Pretty sure DT schema checks would complain about this node name (need
-state suffix, no underscores).

> +		bootph-all;
> +		pins = "gpio99";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	gpio_rs232_low: gpio_rs232_low {

Same here.

Also, since I'm looking at this a bit more closely now, are there maybe
more clear label/node names you could use here, or a comment you could
add what exactly these pins do? I guess this enables something about
RS232 but it's not clear what exactly.

> +		bootph-all;
> +		pins = "gpio100";
> +		function = "gpio";
> +
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
> +
> [...]
> diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
> new file mode 100644
> index 00000000000..02b9615114b
> --- /dev/null
> +++ b/configs/hmibsc_defconfig
> @@ -0,0 +1,87 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="hmibsc"
> +CONFIG_COUNTER_FREQUENCY=19000000

I see you just copied this from the existing defconfigs but
CONFIG_COUNTER_FREQUENCY should be unneeded, since TZ is the one
responsible (and only one capable) of configuring this. And it also
looks wrong to me, because the timer frequency on these Qualcomm boards
is 19.2 MHz and not 19.0 MHz. :'D

I guess I'll prepare a patch to fix it for the existing boards.

Thanks,
Stephan
