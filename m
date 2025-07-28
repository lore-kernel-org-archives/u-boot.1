Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4881FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 09:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFF782E34;
	Mon, 28 Jul 2025 11:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="laLPiMNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6782882E52; Mon, 28 Jul 2025 11:59:08 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B302482C87
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6889E22F3F;
 Mon, 28 Jul 2025 11:59:05 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnr1pLXeMNLa; Mon, 28 Jul 2025 11:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1753696744; bh=N6NbgPAEbLPm31lD2EOnPG7IeTbDhcvCBI6rlQ1sBiU=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=laLPiMNvLeAAUKax/tSo/zElMOu2pbbzlyl3QnBLbIF8lgRtnYQ++UA/GbushTf7c
 O8WhgBPXXerq8CgpSCGtAN3IQ8coVJgPah2I2xzYl+GKkJpwKWv4nEGvzV6x6bKDW/
 jMlC4fKYUhwDX9qdqiJNKPDxMRR0qgeoprr+Pmfk5sLGdUql4CfoM3ZUeYtfDsGh3c
 HroVW4NckGofDcqhgqISUmiTXTdkIcMGxSg12jPfOAJo+a9rOTjHIBl4bPtiGXkqVr
 v9U3oOSU+qhslBPk9hvy4T66ZXmD7pA0g+VtJTIVkib586ld9cmwic5R64JdghE5H9
 GnfhBBUpv1V6Q==
Date: Mon, 28 Jul 2025 09:58:51 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Niu Zhihong" <zhihong@nzhnb.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] board: spacemit: Add SpacemiT MUSE Pi Pro
Message-ID: <aIdJ26GKVeoIN2Zm@pie>
References: <20250728082547.454505-1-zhihong@nzhnb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728082547.454505-1-zhihong@nzhnb.com>
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

On Mon, Jul 28, 2025 at 04:25:47PM +0800, Niu Zhihong wrote:
> MUSE Pi Pro uses spacemit K1,
> a new generation of octa-core 64-bit RISC-V processor,
> which includes octa-core X60.
> 
> Features tested on a MUSE Pi Pro 16GB:
> - SD-card boot
> - eMMC boot

I don't think either SD or eMMC is supported in mainline U-Boot for
SpacemiT K1. Does this mean "boot from SD/eMMC" is working? If so maybe
it's better to make the words more clear.

> Signed-off-by: Niu Zhihong <zhihong@nzhnb.com>
> ---
>  arch/riscv/Kconfig                     |  4 ++
>  arch/riscv/dts/Makefile                |  1 +
>  arch/riscv/dts/k1-muse-pi-pro.dts      | 27 ++++++++
>  board/spacemit/muse-pi-pro/Kconfig     | 37 +++++++++++
>  board/spacemit/muse-pi-pro/MAINTAINERS |  6 ++
>  board/spacemit/muse-pi-pro/Makefile    |  3 +
>  board/spacemit/muse-pi-pro/board.c     |  8 +++
>  configs/muse-pi-pro_defconfig          |  6 ++
>  doc/board/spacemit/index.rst           |  1 +
>  doc/board/spacemit/muse-pi-pro.rst     | 85 ++++++++++++++++++++++++++
>  include/configs/muse-pi-pro.h          | 11 ++++
>  11 files changed, 189 insertions(+)
>  create mode 100644 arch/riscv/dts/k1-muse-pi-pro.dts
>  create mode 100644 board/spacemit/muse-pi-pro/Kconfig
>  create mode 100644 board/spacemit/muse-pi-pro/MAINTAINERS
>  create mode 100644 board/spacemit/muse-pi-pro/Makefile
>  create mode 100644 board/spacemit/muse-pi-pro/board.c
>  create mode 100644 configs/muse-pi-pro_defconfig
>  create mode 100644 doc/board/spacemit/muse-pi-pro.rst
>  create mode 100644 include/configs/muse-pi-pro.h

...

> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 2b10c2d6c01..f959f174f21 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -2,6 +2,7 @@
>  
>  dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
>  dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
> +dtb-$(CONFIG_TARGET_MUSE_PI_PRO) += k1-muse-pi-pro.dtb
>  dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
>  dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
>  dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
> diff --git a/arch/riscv/dts/k1-muse-pi-pro.dts b/arch/riscv/dts/k1-muse-pi-pro.dts
> new file mode 100644
> index 00000000000..5e32d696b63
> --- /dev/null
> +++ b/arch/riscv/dts/k1-muse-pi-pro.dts
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright The U-Boot Contributors
> + */
> +
> +#include "k1.dtsi"
> +#include "binman.dtsi"
> +#include "k1-pinctrl.dtsi"
> +
> +/ {
> +	model = "MUSE Pi Pro";
> +	compatible = "muse-pi-pro", "spacemit,k1";

Compatible strings usually come in form of "<manufacturer>,<model>", as
states in devicetree specification,

> The recommended format is "manufacturer,model", where manufacturer is
> a string describing the name of the manufacturer (such as a stock
> ticker symbol), and model specifies the model number

Do you have any information about the board's manufacturer?

> diff --git a/board/spacemit/muse-pi-pro/board.c b/board/spacemit/muse-pi-pro/board.c
> new file mode 100644
> index 00000000000..599e20117e3
> --- /dev/null
> +++ b/board/spacemit/muse-pi-pro/board.c
> @@ -0,0 +1,8 @@
> +/*
> + * Copyright The U-Boot Contributors
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}

Empty board_init() function could just be omitted, as long as you set
CONFIG_BOARD_INIT to n. Please refer to this patch[1] for more
information.

...

> diff --git a/doc/board/spacemit/muse-pi-pro.rst b/doc/board/spacemit/muse-pi-pro.rst
> new file mode 100644
> index 00000000000..4aa2eab5917
> --- /dev/null
> +++ b/doc/board/spacemit/muse-pi-pro.rst
> @@ -0,0 +1,85 @@

...

> +   U-Boot 2025.07-00902-gf2f451d9d6d3-dirty (Jul 28 2025 - 14:38:51 +0800)
> +
> +   DRAM:  16 GiB
> +   Core:  21 devices, 9 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@d4017000
> +   Out:   serial@d4017000
> +   Err:   serial@d4017000
> +   Net:   No ethernet found.
> +   => cpu list
> +   0: cpu@0      spacemit,x60
> +   1: cpu@1      spacemit,x60
> +   2: cpu@2      spacemit,x60
> +   3: cpu@3      spacemit,x60
> +   4: cpu@4      spacemit,x60
> +   5: cpu@5      spacemit,x60
> +   6: cpu@6      spacemit,x60
> +   7: cpu@7      spacemit,x60
> +   => 
> \ No newline at end of file

Please restore the EOL :)

Regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20250717024426.26953-1-semen.protsenko@linaro.org/
