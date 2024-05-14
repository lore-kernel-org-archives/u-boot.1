Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E604C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 05:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A68888229;
	Tue, 14 May 2024 07:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mgWTYJAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6090487AD2; Tue, 14 May 2024 07:46:11 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF74488229
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 07:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-481398a7381so627003137.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715665566; x=1716270366; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQFjkhYNxfuk00/QZz2YPpebSpMrxs+BAg6zWlBTMmk=;
 b=mgWTYJAlkFd/Nm5jngRub16Nx/WmXf2BZ1eSYp1ALuHAlrVYuPFceShof0bkGyE95J
 dzQbhsLxK2ClWKM5N5bIlVy2aFg8sVcEmom+OfIs1SQ4oWvuaJDLiaV/PfDLJlmvoXik
 iS5wihlAOAZx3ug9zTLBCWYwM7+vLr6BDgNWsLxNPJzHNiPzOy4akG0vCBg1j7ZU4SXD
 94r0ZZuDFGampD3vtkAMn0nyyAy0B49BIveNSjYPMBMrSJPiEgeYx+hHYu6ddVWb//iJ
 5AXFJN0LmJz1wvUdmwVV/8UDPC+wUedYhetp6FLjCt259VuwGJTWWZ7Lndd56Venvmkn
 9/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715665566; x=1716270366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQFjkhYNxfuk00/QZz2YPpebSpMrxs+BAg6zWlBTMmk=;
 b=qOesevnKu7TqBFS2VaUD5IWs2IXMQRJ3PchIQg46dvt+xdRZvIvA19daHRN84P5zuH
 BafDMf1zS3BZb3/wQ9/Ovuy+SJCRzDDfWDjdFbTr/4Xafc2WM/mgtjwgBgEFdPXgygli
 o6UQwGvmMGP8fgHygalpUbcxehgBBx/tmcJV5xd+Px1xtb91p5nU/9KMHCyqYSYSXSef
 CsMTnBZAhl3b1leXz4I5ST5ZlKAK0lhevx1SFDnlurLTrzvbs7a4ODIva6ZlXsAiTJqo
 cUg9DFJwVHZA2AbsnPcmQJiD9iAsGew6BXjiDubKK4Sh+MWo32CH0E3Q6yLa4LjpfhUP
 Tj8w==
X-Gm-Message-State: AOJu0YxyAPXEUbwC3mfvGM/FulUQO1UPBaVPA6ikblzOYL1QzMq8nN3K
 6yOClBSwsPy3SKMm1h671YzkwaOm/JFgEkITl244SnapAJIDyvgdoD7b6nsVYxwxNi7ON6yhE/W
 Q+1ZCnWfJEQNo+katpmqbgLF1oNWmdIDGGs1Axg==
X-Google-Smtp-Source: AGHT+IGDykVZUowC0afX893p02Quvch0g7lVkNHgSbHiGWwWsLVp9Bc0dSRl5LFar6O2TuXTM948JObkiCk44+TFmLo=
X-Received: by 2002:a05:6102:942:b0:47c:3368:b824 with SMTP id
 ada2fe7eead31-48077e7b654mr9141407137.22.1715665566454; Mon, 13 May 2024
 22:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-12-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-12-fac96938417e@flygoat.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 14 May 2024 11:15:55 +0530
Message-ID: <CAFA6WYPapa8PUqOQ-wJRkD4bOfX+2eBCk_5voamQB-XbAhhBcg@mail.gmail.com>
Subject: Re: [PATCH 12/13] MIPS: boston: Migrate to OF_UPSTREAM
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jiaxun,

On Mon, 13 May 2024 at 23:43, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> We can now boot with upstream devicetree.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/Kconfig                |   1 +
>  arch/mips/dts/Makefile           |   1 -
>  arch/mips/dts/boston-u-boot.dtsi |  10 ++
>  arch/mips/dts/img,boston.dts     | 222 ---------------------------------------
>  board/imgtec/boston/MAINTAINERS  |   1 +
>  configs/boston32r2_defconfig     |   2 +-
>  configs/boston32r2el_defconfig   |   2 +-
>  configs/boston32r6_defconfig     |   2 +-
>  configs/boston32r6el_defconfig   |   2 +-
>  configs/boston64r2_defconfig     |   2 +-
>  configs/boston64r2el_defconfig   |   2 +-
>  configs/boston64r6_defconfig     |   2 +-
>  configs/boston64r6el_defconfig   |   2 +-
>  13 files changed, 20 insertions(+), 231 deletions(-)
>

Thanks for your efforts although I have a further suggestion below but FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 748b5175b2eb..733a8de4fb83 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -146,6 +146,7 @@ config TARGET_BOSTON
>         select SUPPORTS_CPU_MIPS64_R2
>         select SUPPORTS_CPU_MIPS64_R6
>         select SUPPORTS_LITTLE_ENDIAN
> +       imply OF_UPSTREAM
>         imply BOOTSTD_FULL
>         imply CLK
>         imply CLK_BOSTON
> diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
> index 14fbce597b9e..5478dcd8d025 100644
> --- a/arch/mips/dts/Makefile
> +++ b/arch/mips/dts/Makefile
> @@ -3,7 +3,6 @@
>  dtb-$(CONFIG_TARGET_AP121) += ap121.dtb
>  dtb-$(CONFIG_TARGET_AP143) += ap143.dtb
>  dtb-$(CONFIG_TARGET_AP152) += ap152.dtb
> -dtb-$(CONFIG_TARGET_BOSTON) += img,boston.dtb
>  dtb-$(CONFIG_TARGET_MALTA) += mti,malta.dtb
>  dtb-$(CONFIG_TARGET_PIC32MZDASK) += pic32mzda_sk.dtb
>  dtb-$(CONFIG_TARGET_XILFPGA) += nexys4ddr.dtb
> diff --git a/arch/mips/dts/boston-u-boot.dtsi b/arch/mips/dts/boston-u-boot.dtsi
> new file mode 100644
> index 000000000000..1b0c0a289613
> --- /dev/null
> +++ b/arch/mips/dts/boston-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&plat_regs {
> +       compatible = "img,boston-platform-regs", "syscon", "simple-mfd";
> +       bootph-all;
> +};
> +
> +&clk_boston {
> +       bootph-all;
> +};

You can try to push these overrides to upstream DTS as well, so you
won't have to maintain them in U-Boot.

-Sumit

> diff --git a/arch/mips/dts/img,boston.dts b/arch/mips/dts/img,boston.dts
> deleted file mode 100644
> index c1a73963037d..000000000000
> --- a/arch/mips/dts/img,boston.dts
> +++ /dev/null
> @@ -1,222 +0,0 @@
> -/dts-v1/;
> -
> -#include <dt-bindings/clock/boston-clock.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/mips-gic.h>
> -
> -/ {
> -       #address-cells = <1>;
> -       #size-cells = <1>;
> -       compatible = "img,boston";
> -
> -       chosen {
> -               stdout-path = &uart0;
> -       };
> -
> -       cpus {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               cpu@0 {
> -                       device_type = "cpu";
> -                       compatible = "img,mips";
> -                       reg = <0>;
> -                       clocks = <&clk_boston BOSTON_CLK_CPU>;
> -               };
> -       };
> -
> -       memory@0 {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       gic: interrupt-controller {
> -               compatible = "mti,gic";
> -
> -               interrupt-controller;
> -               #interrupt-cells = <3>;
> -
> -               timer {
> -                       compatible = "mti,gic-timer";
> -                       interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> -                       clocks = <&clk_boston BOSTON_CLK_CPU>;
> -               };
> -       };
> -
> -       pci0: pci@10000000 {
> -               status = "disabled";
> -               compatible = "xlnx,axi-pcie-host-1.00.a";
> -               device_type = "pci";
> -               reg = <0x10000000 0x2000000>;
> -
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -               #interrupt-cells = <1>;
> -
> -               interrupt-parent = <&gic>;
> -               interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               ranges = <0x02000000 0 0x40000000
> -                         0x40000000 0 0x40000000>;
> -
> -               interrupt-map-mask = <0 0 0 7>;
> -               interrupt-map = <0 0 0 1 &pci0_intc 0>,
> -                               <0 0 0 2 &pci0_intc 1>,
> -                               <0 0 0 3 &pci0_intc 2>,
> -                               <0 0 0 4 &pci0_intc 3>;
> -
> -               pci0_intc: interrupt-controller {
> -                       interrupt-controller;
> -                       #address-cells = <0>;
> -                       #interrupt-cells = <1>;
> -               };
> -       };
> -
> -       pci1: pci@12000000 {
> -               status = "disabled";
> -               compatible = "xlnx,axi-pcie-host-1.00.a";
> -               device_type = "pci";
> -               reg = <0x12000000 0x2000000>;
> -
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -               #interrupt-cells = <1>;
> -
> -               interrupt-parent = <&gic>;
> -               interrupts = <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               ranges = <0x02000000 0 0x20000000
> -                         0x20000000 0 0x20000000>;
> -
> -               interrupt-map-mask = <0 0 0 7>;
> -               interrupt-map = <0 0 0 1 &pci1_intc 0>,
> -                               <0 0 0 2 &pci1_intc 1>,
> -                               <0 0 0 3 &pci1_intc 2>,
> -                               <0 0 0 4 &pci1_intc 3>;
> -
> -               pci1_intc: interrupt-controller {
> -                       interrupt-controller;
> -                       #address-cells = <0>;
> -                       #interrupt-cells = <1>;
> -               };
> -       };
> -
> -       pci2: pci@14000000 {
> -               compatible = "xlnx,axi-pcie-host-1.00.a";
> -               device_type = "pci";
> -               reg = <0x14000000 0x2000000>;
> -
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -               #interrupt-cells = <1>;
> -
> -               interrupt-parent = <&gic>;
> -               interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               ranges = <0x02000000 0 0x16000000
> -                         0x16000000 0 0x100000>;
> -
> -               interrupt-map-mask = <0 0 0 7>;
> -               interrupt-map = <0 0 0 1 &pci2_intc 0>,
> -                               <0 0 0 2 &pci2_intc 1>,
> -                               <0 0 0 3 &pci2_intc 2>,
> -                               <0 0 0 4 &pci2_intc 3>;
> -
> -               pci2_intc: interrupt-controller {
> -                       interrupt-controller;
> -                       #address-cells = <0>;
> -                       #interrupt-cells = <1>;
> -               };
> -
> -               pci2_root@0,0,0 {
> -                       compatible = "pci10ee,7021";
> -                       reg = <0x00000000 0 0 0 0>;
> -
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -                       #interrupt-cells = <1>;
> -
> -                       eg20t_bridge@1,0,0 {
> -                               compatible = "pci8086,8800";
> -                               reg = <0x00010000 0 0 0 0>;
> -
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -
> -                               eg20t_mac@2,0,1 {
> -                                       compatible = "pci8086,8802";
> -                                       reg = <0x00020100 0 0 0 0>;
> -                                       phy-reset-gpios = <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
> -                               };
> -
> -                               eg20t_gpio: eg20t_gpio@2,0,2 {
> -                                       compatible = "pci8086,8803";
> -                                       reg = <0x00020200 0 0 0 0>;
> -
> -                                       gpio-controller;
> -                                       #gpio-cells = <2>;
> -                               };
> -
> -                               eg20t_i2c@2,12,2 {
> -                                       compatible = "pci8086,8817";
> -                                       reg = <0x00026200 0 0 0 0>;
> -
> -                                       #address-cells = <1>;
> -                                       #size-cells = <0>;
> -
> -                                       rtc@0x68 {
> -                                               compatible = "st,m41t81s";
> -                                               reg = <0x68>;
> -                                       };
> -                               };
> -                       };
> -               };
> -       };
> -
> -       plat_regs: system-controller@17ffd000 {
> -               compatible = "img,boston-platform-regs", "syscon";
> -               reg = <0x17ffd000 0x1000>;
> -               bootph-all;
> -       };
> -
> -       clk_boston: clock {
> -               compatible = "img,boston-clock";
> -               #clock-cells = <1>;
> -               regmap = <&plat_regs>;
> -               bootph-all;
> -       };
> -
> -       reboot: syscon-reboot {
> -               compatible = "syscon-reboot";
> -               regmap = <&plat_regs>;
> -               offset = <0x10>;
> -               mask = <0x10>;
> -       };
> -
> -       uart0: uart@17ffe000 {
> -               compatible = "ns16550a";
> -               reg = <0x17ffe000 0x1000>;
> -               reg-shift = <2>;
> -               reg-io-width = <4>;
> -
> -               interrupt-parent = <&gic>;
> -               interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               clocks = <&clk_boston BOSTON_CLK_SYS>;
> -
> -               bootph-all;
> -       };
> -
> -       lcd: lcd@17fff000 {
> -               compatible = "img,boston-lcd";
> -               reg = <0x17fff000 0x8>;
> -       };
> -
> -       flash@18000000 {
> -               compatible = "cfi-flash";
> -               reg = <0x18000000 0x8000000>;
> -               bank-width = <2>;
> -       };
> -};
> diff --git a/board/imgtec/boston/MAINTAINERS b/board/imgtec/boston/MAINTAINERS
> index 07f6156ffcbe..12e1652858bb 100644
> --- a/board/imgtec/boston/MAINTAINERS
> +++ b/board/imgtec/boston/MAINTAINERS
> @@ -1,6 +1,7 @@
>  BOSTON BOARD
>  M:     Paul Burton <paul.burton@mips.com>
>  S:     Maintained
> +F:  arch/mips/dts/boston-u-boot.dtsi
>  F:     board/imgtec/boston/
>  F:     include/configs/boston.h
>  F:     configs/boston32r2_defconfig
> diff --git a/configs/boston32r2_defconfig b/configs/boston32r2_defconfig
> index 6f0024a6663d..cb5898c3cafa 100644
> --- a/configs/boston32r2_defconfig
> +++ b/configs/boston32r2_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0x88000000
>  CONFIG_ENV_ADDR=0xBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r2el_defconfig b/configs/boston32r2el_defconfig
> index 71926429b051..4c603b69df7b 100644
> --- a/configs/boston32r2el_defconfig
> +++ b/configs/boston32r2el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0x88000000
>  CONFIG_ENV_ADDR=0xBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r6_defconfig b/configs/boston32r6_defconfig
> index 4335d04b39eb..17f7c4364a03 100644
> --- a/configs/boston32r6_defconfig
> +++ b/configs/boston32r6_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0x88000000
>  CONFIG_ENV_ADDR=0xBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston32r6el_defconfig b/configs/boston32r6el_defconfig
> index b859a4f198ba..e662d167fe3d 100644
> --- a/configs/boston32r6el_defconfig
> +++ b/configs/boston32r6el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0x88000000
>  CONFIG_ENV_ADDR=0xBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r2_defconfig b/configs/boston64r2_defconfig
> index 70354f117169..bf5a3ead3646 100644
> --- a/configs/boston64r2_defconfig
> +++ b/configs/boston64r2_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>  CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r2el_defconfig b/configs/boston64r2el_defconfig
> index eafb8c67ba7a..de22344b5bb6 100644
> --- a/configs/boston64r2el_defconfig
> +++ b/configs/boston64r2el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>  CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r6_defconfig b/configs/boston64r6_defconfig
> index a6c89278512a..bb339cfd5dbe 100644
> --- a/configs/boston64r6_defconfig
> +++ b/configs/boston64r6_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>  CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>  CONFIG_TARGET_BOSTON=y
> diff --git a/configs/boston64r6el_defconfig b/configs/boston64r6el_defconfig
> index 6cc227600df1..260f6dfb3583 100644
> --- a/configs/boston64r6el_defconfig
> +++ b/configs/boston64r6el_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
>  CONFIG_SYS_MALLOC_F_LEN=0x400
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_SECT_SIZE=0x20000
> -CONFIG_DEFAULT_DEVICE_TREE="img,boston"
> +CONFIG_DEFAULT_DEVICE_TREE="img/boston"
>  CONFIG_SYS_LOAD_ADDR=0xffffffff88000000
>  CONFIG_ENV_ADDR=0xFFFFFFFFBFFE0000
>  CONFIG_TARGET_BOSTON=y
>
> --
> 2.34.1
>
