Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE4C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FA5807D7;
	Sun,  9 Feb 2025 03:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rs86tcZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE5980836; Sun,  9 Feb 2025 03:11:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0A180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739067092;
 bh=UzAYZ/xuJeyzuH+NyitP6WrQGHktLNJp/MTJK96aKTc=;
 b=rs86tcZofdQJGErqgV03gj0CLE30IwmasEfstAW9g5n7KCmF7d2i+MozvdNvooBMiMAoT6eQN
 KQZSBvziqy5k12tXXCOC2N8H+v/ulSzWPvVm7YI3yi+zbIw4fWPiYO2ySjtXO8tumUoZWmUR9Af
 C3Gj4sqg8pRyJCBak+Xh5+g35Jxt+BwoBsAgSNeC0jfXx/az0AG9BKzbzD/Yd7z/cFzpLa6rl8f
 vFBbfVKl9hnUcBokhE5+vMYTrvcpeGWGVY2gxU9uDwiN2tYMF9fs8vcYtWOkW5OrHQWh043KV5B
 4/CINjqf/utAptVN72hhkla9mrpW7v0IHMRlsw9e+XQA==
X-Forward-Email-ID: 67a80ed0ae24fcf613ed67ab
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b52ff2d2-3ab1-4c1f-9e1c-d8dc2a40025f@kwiboo.se>
Date: Sun, 9 Feb 2025 03:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/29] rockchip: Add a generic rk3399 board
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-26-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-26-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

On 2025-02-05 02:55, Simon Glass wrote:
> This build-target is used to build an image which can run on multiple
> rk3399 boards, using VBE to boot.

Since this target is intended to be used with VBE on LPDDR4 boards, can
you use a different target name, maybe rk3399-vbe-lpddr4 or similar?

> 
> To use it, the TPL binary for a particular board must be placed into the
> first part of the image. The rest of the image (i.e. VPL, SPL and
> U-Boot) are largely generic and can work on any supported board.

I like the concept of this and I also think this can be supported using
current "traditional" TPL+SPL and FIT separation with fit,compatible and
FIT_BEST_MATCH, I will run some tests using that :-)

Also think with some cleanup work we should even be able to build a
generic Rockchip AArch64 U-Boot proper FIT, for now there is parts that
is too SoC dependent.

> 
> With VBE, memory-init happens in SPL so that this code is updatable in
> the field. Due to size constraints, the type of memory on the board is
> defined at build-time. So it is not possible to use the same VBE image
> on boards with different SDRAM (DDR3 vs LPDDR4 for example). This may
> become possible with newer boards with more SRAM.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/dts/rk3399-generic-u-boot.dtsi |  32 ++++++
>  arch/arm/dts/rk3399-generic.dts         |  30 ++++++
>  board/rockchip/evb_rk3399/MAINTAINERS   |   5 +
>  configs/rk3399-generic_defconfig        | 133 ++++++++++++++++++++++++
>  4 files changed, 200 insertions(+)
>  create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3399-generic.dts
>  create mode 100644 configs/rk3399-generic_defconfig
> 
> diff --git a/arch/arm/dts/rk3399-generic-u-boot.dtsi b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> new file mode 100644
> index 00000000000..732727d9b03
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include "rk3399-u-boot.dtsi"
> +#include "rk3399-sdram-lpddr4-100.dtsi"

This is not generic and limits this to lpddr4 boards.

> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
> +	};
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +};
> +
> +&spi1 {
> +	spi_flash: flash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&vdd_center {
> +	regulator-min-microvolt = <950000>;
> +	regulator-max-microvolt = <950000>;
> +};
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
> diff --git a/arch/arm/dts/rk3399-generic.dts b/arch/arm/dts/rk3399-generic.dts
> new file mode 100644
> index 00000000000..f13bb7f6b4b
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-generic.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
> + */
> +
> +/dts-v1/;
> +#include "rk3399-rockpro64.dtsi"

This is far from generic, please see my minimal generic dts at [1]. You
can possible build something using that and a vbe-lpddr4-rk3399
defconfig or similar?

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250204072710.468610-3-jonas@kwiboo.se/

Regards,
Jonas

> +
> +/ {
> +	model = "RK3399 Generic";
> +	compatible = "pine64,rockpro64-v2.1", "pine64,rockpro64", "rockchip,rk3399";
> +};
> +
> +&i2c1 {
> +	es8316: codec@11 {
> +		compatible = "everest,es8316";
> +		reg = <0x11>;
> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint = <&i2s1_p0_0>;
> +			};
> +		};
> +	};
> +};

[snip]
