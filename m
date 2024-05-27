Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24E2C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 18:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671DF88113;
	Mon, 27 May 2024 20:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G1kKcV1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156AE88020; Mon, 27 May 2024 20:35:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B343087DAB
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 20:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=921e=M7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1716834891;
 bh=GX/BCbsenaRBIEqaF/dbtLQhSIYz+69Dy3qGO+GTwIw=;
 b=G1kKcV1cA0NIEcnBLhGiwFAWAC+ZP84CHblL6fQJXxFkzfS/pSVKqzZoMpKbgbAJZpBOjG74N
 ZFiqh0aP3TBNZdSePHp3n4jx3GR1ZdePyCt5U/g7rRv1/szKu3UzJdN4jIvtUw1fTqNeYc4ER2X
 ELukdtYqi8WFva7K83H4refVdOvG7fCHgNdgFr0/oYQfnQGwwa4tmj3cK8C2TwQFhTceQBZIBx3
 u2JeL5wgzxwkk3IsZJYTxOCcwXdUR6tHsXEpxgldF5bZdQmw/glzvR1WGviEaLthWJ6o+VqlPiz
 oPTNNpfH/3lMTg66ZFjYI0PlHA412W7XMkbyigMLejKw==
Message-ID: <a4429a8a-eb07-486c-91d1-00731a908a5f@kwiboo.se>
Date: Mon, 27 May 2024 20:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Christopher Obbard
 <chris.obbard@collabora.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@edgeble.ai>, John Clark
 <inindev@gmail.com>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Massimo Pegorer
 <massimo.pegorer+oss@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Michal Simek <michal.simek@amd.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tianling Shen <cnsztl@gmail.com>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
 <20240527170214.283988-8-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240527170214.283988-8-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6654d24a6b7f69199002a5b6
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

Hi Jianfeng,

On 2024-05-27 19:02, Jianfeng Liu wrote:
> ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer) by
> ArmSoM.
> 
> There are two variants depending on the DRAM size : 8G and 16G.
> 
> Specification:
> 
>     Rockchip Rk3588 SoC
>     4x ARM Cortex-A76, 4x ARM Cortex-A55
>     8/16GB memory LPDDR4x
>     Mali G610MC4 GPU
>     2x MIPI CSI 2 multiple lanes connector
>     64GB/128GB on board eMMC
>     uSD slot
>     1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
>     1x HDMI 2.1 output
>     2x 2.5 Gbps Ethernet port
>     40-pin IO header including UART, SPI and I2C
>     USB PD over USB Type-C
>     Size: 92mm x 62mm
> 
> Kernel commit:
> 81c828a67c78 (arm64: dts: rockchip: Add ArmSom Sige7 board)
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
> Changes in v3:
> - Use update-dts-subtree.sh to pick upstream dts
> 
> Changes in v2:
> - Fix alphabetical order of MAINTAINERS
> - Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
> - Remove spi flash related config
> - Move kernel dts to dts/upstream/src/arm64/rockchip/
> 
>  MAINTAINERS                                  |  1 +
>  arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi | 28 ++++++
>  arch/arm/mach-rockchip/rk3588/Kconfig        | 26 ++++++
>  board/armsom/sige7-rk3588/Kconfig            | 12 +++
>  board/armsom/sige7-rk3588/MAINTAINERS        |  7 ++
>  configs/sige7-rk3588_defconfig               | 93 ++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst              |  1 +
>  include/configs/sige7-rk3588.h               | 15 ++++
>  8 files changed, 183 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>  create mode 100644 board/armsom/sige7-rk3588/Kconfig
>  create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
>  create mode 100644 configs/sige7-rk3588_defconfig
>  create mode 100644 include/configs/sige7-rk3588.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c861b529df..fffcf898bf1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -534,6 +534,7 @@ F:	arch/arm/include/asm/arch-rockchip/
>  F:	arch/arm/mach-rockchip/
>  F:	board/amarula/vyasa-rk3288/
>  F:	board/anbernic/rgxx3_rk3566/
> +F:	board/armsom/sige7-rk3588/
>  F:	board/chipspark/popmetal_rk3288
>  F:	board/engicam/px30_core/
>  F:	board/firefly/
> diff --git a/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> new file mode 100644
> index 00000000000..2c984d01471
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 ArmSoM Technology Co., Ltd.
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};

The sdhci node should not be needed, mmc-hs200-1_8v is already defined
in the upstream DT and cap-mmc-highspeed modes only work if HS200 can
first be initialized.

> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
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

These usb related nodes is already defined in main DT, please remove.

Regards,
Jonas

[snip]
