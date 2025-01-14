Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03100E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 22:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7FD8060C;
	Tue, 14 Jan 2025 23:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="JhF0rbD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A9D8069A; Tue, 14 Jan 2025 23:34:24 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A4880214
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 23:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e573136107bso7590781276.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1736894059; x=1737498859; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vTnVzTwYubXvv9hmyGQrEKgGLH6ofYcQTifjL4w5yQ=;
 b=JhF0rbD7TeQ7v8ckEyeKRLwWEWmdurErvYzdIB4v3gXVBu5ONthEcBhiqVWVjTITUR
 ABaFyC2fwtof7QaahJXSKBtdGxTMRfhcDifcr4oH4i/7Rrs/6/AaVOfsydhK23qfmYiY
 W5EJgUErbMwHB/V9lE0hyUdfZNxkyQoRxml5CUKM0pC4JGwzUj5ejgELZUxzRsEA+2k+
 JDOoyKJhcWjgp7ptaDUWO/r4Gl4k3/TlmOWb5LpgReV4VvRtFtHOyx7JNR7gdTPhYNlm
 WsP4BNnra36UGXQGrpZ8P/OgTu3SI/C3vuVnYWbChndt6hgfgRm18RhHNLlmutXb3nt6
 g6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736894059; x=1737498859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vTnVzTwYubXvv9hmyGQrEKgGLH6ofYcQTifjL4w5yQ=;
 b=PkLxCXBVR5evia9JrusN4TTLNqpKFrmnPuIB2+c4SxHM8G8Vg21nryhF7I2GaLoEwc
 dn9hVzM1igvKxMrMb8WC/Pa7kzwo5jN/t6hzPcMfeMAb/r01kLkQaUxoGg6vUIGkHG4P
 RHFG4xMmb/tkO7WjOpwj77wj/daw307GUXt9CLI3KCj7GYeqxmVOaGppJ/0c3uobQgGZ
 VmS/GJcEkwf/WkvHeEyl2EoDL5a/2vW9HHCgJjoHDfetQM9vVVLmufP3VKcbGiWtnzPk
 jsumEvFA2XbNB/dOgmFvbBBLRDhVD58P5rzM4lmT+Jcbp8gQ695Bo5vqh3HUC7IY3/I/
 emAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7IHEfGiIMvNzhPnSAh4iWqw7+OODw6UHzN6Mv5jhMaqivSB3Y7ecbES4opmlWDPxO5djONYE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3XvSKOzNIgXHGwplsMqvStD65pWyAE7A1tnA6oNBpnlaaxswa
 vj2Xx+1Nt0C2vylStqJ6RauFpy4KhBhw8m2gB7t1Nuwi2xI0SQ9E/aYTJx5H3tKTpGB1DIGV4ZN
 80W+H89uIXitWalsowJILo8lV+JHWT8a9gZSIsA==
X-Gm-Gg: ASbGncsQdL+XascC6ow7NgyRCQj9lINobuSG3N3o7ftzNaG+82hHnmgFbWNsV1ESKtB
 7qDsLtSW0GbgdRfwJXylz6y7lUwtiqp6itTZSkQ==
X-Google-Smtp-Source: AGHT+IHK4ns4A/znW09EtooZFa5J4TZDu8RL+jBXhpzMsqJcp5HN82AsiEA+uikrORHByhHWff50ssOru+9EW2C0uB4=
X-Received: by 2002:a05:6902:15c2:b0:e57:38e8:e484 with SMTP id
 3f1490d57ef6-e5738e8e963mr11490354276.25.1736894059043; Tue, 14 Jan 2025
 14:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 14 Jan 2025 14:34:08 -0800
X-Gm-Features: AbW1kvYjnlmbtL6c6nw-MhDmwrb9DP6uOse99CUuGZMgLqPObtKwuu764TF_abE
Message-ID: <CAJ+vNU1xAhYdnoTRLuM6fWa1mQgkLrVj03BsSObtd7NDq9oogw@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, 
 marex@denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 2, 2025 at 10:47=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> w=
rote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>

Hi Alice,

Could you add in the commit log what is and/or what is not supported?

From what I see:

the following is supported:
- gpio
- pci
- i2c
- mmc

the following are not yet supported by this series:
- ethernet
- usb

Best Regards,

Tim

> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 ++++++++++
>  arch/arm/dts/imx95-u-boot.dtsi                | 173 ++++++++++++++++++++=
+++++
>  arch/arm/mach-imx/imx9/Kconfig                |   6 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
>  arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  54 ++++++++
>  board/freescale/imx95_evk/spl.c               |  96 ++++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 177 ++++++++++++++++++++=
++++++
>  doc/board/nxp/imx95_evk.rst                   | 116 +++++++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  30 +++++
>  16 files changed, 866 insertions(+)
>
> diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx9=
5-19x19-evk-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..36169b56ef3075a5c243f7fb1=
afd6399b0df77ad
> --- /dev/null
> +++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "imx95-u-boot.dtsi"
> +
> +&gpio1 {
> +       reg =3D <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
> +};
> +
> +&lpuart1 {
> +       clocks =3D <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LP=
UART1>;
> +       clock-names =3D "ipg", "per";
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_uart1 {
> +       bootph-pre-ram;
> +};
> +
> +&usdhc1 {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1 {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_100mhz {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc1_200mhz {
> +       bootph-pre-ram;
> +};
> +
> +&usdhc2 {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2 {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_100mhz {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_200mhz {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_usdhc2_gpio {
> +       bootph-pre-ram;
> +};
> +
> +&reg_usdhc2_vmmc {
> +       bootph-pre-ram;
> +};
> +
> +&pinctrl_reg_usdhc2_vmmc {
> +       bootph-pre-ram;
> +};
> +
> +&wdog3 {
> +       status =3D "disabled";
> +};
> diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.d=
tsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..bf6b31210e0d70674d6ce7c78=
7ff7157a1cf65ed
> --- /dev/null
> +++ b/arch/arm/dts/imx95-u-boot.dtsi
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/ {
> +    binman {
> +        multiple-images;
> +
> +        m33-oei-ddrfw {
> +            pad-byte =3D <0x00>;
> +            align-size =3D <0x8>;
> +            filename =3D "m33-oei-ddrfw.bin";
> +
> +            oei-m33-ddr {
> +                align-size =3D <0x4>;
> +                filename =3D "oei-m33-ddr.bin";
> +                type =3D "blob-ext";
> +            };
> +
> +            imx-lpddr {
> +                type =3D "nxp-header-ddrfw";
> +
> +                imx-lpddr-imem {
> +                    filename =3D "lpddr5_imem_v202311.bin";
> +                    type =3D "blob-ext";
> +                };
> +
> +                imx-lpddr-dmem {
> +                    filename =3D "lpddr5_dmem_v202311.bin";
> +                    type =3D "blob-ext";
> +                };
> +            };
> +
> +            imx-lpddr-qb {
> +                type =3D "nxp-header-ddrfw";
> +
> +                imx-lpddr-imem-qb {
> +                    filename =3D "lpddr5_imem_qb_v202311.bin";
> +                    type =3D "blob-ext";
> +                };
> +
> +                imx-lpddr-dmem-qb {
> +                    filename =3D "lpddr5_dmem_qb_v202311.bin";
> +                    type =3D "blob-ext";
> +                };
> +            };
> +        };
> +
> +               imx-boot {
> +                       filename =3D "flash.bin";
> +                       pad-byte =3D <0x00>;
> +
> +            spl {
> +                align =3D <0x400>;
> +                align-size =3D <0x400>;
> +                type =3D "mkimage";
> +                args =3D "-n spl/u-boot-spl.cfgout -T imx8image";
> +            };
> +
> +            u-boot {
> +                type =3D "mkimage";
> +                args =3D "-n u-boot-container.cfgout -T imx8image";
> +            };
> +               };
> +       };
> +};
> +
> +&{/soc} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&aips1 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&aips2 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&aips3 {
> +       bootph-pre-ram;
> +};
> +
> +&gpio2 {
> +       reg =3D <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
> +       bootph-pre-ram;
> +};
> +
> +&gpio3 {
> +       reg =3D <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
> +       bootph-pre-ram;
> +};
> +
> +&gpio4 {
> +       reg =3D <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
> +       bootph-pre-ram;
> +};
> +
> +&gpio5 {
> +       reg =3D <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
> +       bootph-pre-ram;
> +};
> +
> +&osc_24m {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&clk_ext1 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&mu2 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&sram0 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&scmi_buf0 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&scmi_buf1 {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@11} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@13} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@14} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&{/firmware/scmi/protocol@19} {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
> +&elemu3 {
> +       compatible =3D "fsl,imx93-mu-s4";
> +       status =3D "okay";
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kcon=
fig
> index 596e753f2897c11d7ca3bcc9211af786d005bfd9..1ba277baeb353de301a1e67a7=
adf70f281752ded 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -66,6 +66,11 @@ config TARGET_PHYCORE_IMX93
>         select OF_BOARD_FIXUP
>         select OF_BOARD_SETUP
>
> +config TARGET_IMX95_19X19_EVK
> +       bool "imx95_19x19_evk"
> +       select IMX95
> +       imply OF_UPSTREAM
> +
>  endchoice
>
>  source "board/freescale/imx91_evk/Kconfig"
> @@ -73,6 +78,7 @@ source "board/freescale/imx93_evk/Kconfig"
>  source "board/freescale/imx93_qsb/Kconfig"
>  source "board/phytec/phycore_imx93/Kconfig"
>  source "board/variscite/imx93_var_som/Kconfig"
> +source "board/freescale/imx95_evk/Kconfig"
>
>  endif
>
> diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-im=
x/imx9/scmi/container.cfg
> new file mode 100644
> index 0000000000000000000000000000000000000000..29f346e59c4afd0c2689667ab=
e36f4b776b29ba8
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +BOOT_FROM SD
> +SOC_TYPE IMX9
> +CONTAINER
> +IMAGE A55 bl31.bin 0x8a200000
> +IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
> \ No newline at end of file
> diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx=
/imx9/scmi/imximage.cfg
> new file mode 100644
> index 0000000000000000000000000000000000000000..c90432f5efa78dccb2c67e237=
b88a96174446b96
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +BOOT_FROM SD
> +SOC_TYPE IMX9
> +APPEND mx95a0-ahab-container.img
> +CONTAINER
> +IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
> +HOLD 0x10000
> +IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
> +IMAGE M33 m33_image.bin 0x1ffc0000
> +IMAGE A55 spl/u-boot-spl.bin 0x20480000
> +DUMMY_V2X 0x8b000000
> \ No newline at end of file
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/s=
cmi/soc.c
> index 8a7df24afecc1d6d77b7162be639b56af95fd975..38ade99964b64512ba93423ef=
caa0cfb58094b00 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -43,6 +43,7 @@
>  #endif
>  #include <spl.h>
>  #include <mmc.h>
> +#include <asm/arch/mu.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_ev=
k/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..f9a67353e5db6d3ec94784cf0=
91e45d8817d541c
> --- /dev/null
> +++ b/board/freescale/imx95_evk/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_IMX95_19X19_EVK
> +
> +config SYS_BOARD
> +       default "imx95_evk"
> +
> +config SYS_VENDOR
> +       default "freescale"
> +
> +config SYS_CONFIG_NAME
> +       default "imx95_evk"
> +
> +endif
> diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx9=
5_evk/MAINTAINERS
> new file mode 100644
> index 0000000000000000000000000000000000000000..5caf763e0cc390c46fc54ee62=
7bc966b2b110958
> --- /dev/null
> +++ b/board/freescale/imx95_evk/MAINTAINERS
> @@ -0,0 +1,6 @@
> +i.MX95 EVK BOARD
> +M:     Alice Guo <alice.guo@nxp.com>
> +S:     Maintained
> +F:     board/freescale/imx95_evk/
> +F:     include/configs/imx95_evk.h
> +F:     configs/imx95_19x19_evk_defconfig
> diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_e=
vk/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..a278d58ee0085176948b81270=
3d120aaad3a3116
> --- /dev/null
> +++ b/board/freescale/imx95_evk/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Copyright 2024 NXP
> +#
> +# SPDX-License-Identifier:      GPL-2.0+
> +#
> +
> +obj-y +=3D imx95_evk.o
> +
> +ifdef CONFIG_SPL_BUILD
> +obj-y +=3D spl.o
> +endif
> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freesc=
ale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d2b5dfcf07d251c77440bae4=
4d62bff6253dfc7
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,90 @@
> +sec_boot=3Dno
> +initrd_addr=3D0x93800000
> +emmc_dev=3D0
> +sd_dev=3D1
> +scriptaddr=3D0x93500000
> +kernel_addr_r=3DCONFIG_SYS_LOAD_ADDR
> +image=3DImage
> +splashimage=3D0xA0000000
> +console=3DttyLP0,115200 earlycon
> +fdt_addr_r=3D0x93000000
> +fdt_addr=3D0x93000000
> +cntr_addr=3D0xA8000000
> +cntr_file=3Dos_cntr_signed.bin
> +boot_fit=3Dno
> +fdtfile=3DCONFIG_DEFAULT_FDT_FILE
> +bootm_size=3D0x10000000
> +mmcautodetect=3Dyes
> +mmcargs=3Dsetenv bootargs console=3D${console} root=3D${mmcroot}
> +loadbootscript=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
> +bootscript=3Decho Running bootscript from mmc ...; source
> +loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=3Dfatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=3Dauth_cntr ${cntr_addr}
> +boot_os=3Dbooti ${loadaddr} - ${fdt_addr_r};
> +mmcboot=3Decho Booting from mmc ...;
> +               run mmcargs;
> +               if test ${sec_boot} =3D yes; then
> +                       if run auth_os; then
> +                               run boot_os;
> +                       else
> +                               echo ERR: failed to authenticate;
> +                       fi;
> +               else
> +                       if test ${boot_fit} =3D yes || test ${boot_fit} =
=3D try; then
> +                               bootm ${loadaddr};
> +                       else
> +                               if run loadfdt; then
> +                                       run boot_os;
> +                               else
> +                                       echo WARN: Cannot load the DT;
> +                               fi;
> +                       fi;
> +               fi;
> +netargs=3Dsetenv bootargs console=3D${console} root=3D/dev/nfs
> +               ip=3Ddhcp nfsroot=3D${serverip}:${nfsroot},v3,tcp
> +netboot=3Decho Booting from net ...;
> +               run netargs;
> +               if test ${ip_dyn} =3D yes; then
> +                       setenv get_cmd dhcp;
> +               else
> +                       setenv get_cmd tftp;
> +               fi;
> +               if test ${sec_boot} =3D yes; then
> +                       ${get_cmd} ${cntr_addr} ${cntr_file};
> +                       if run auth_os; then
> +                               run boot_os;
> +                       else
> +                               echo ERR: failed to authenticate;
> +                       fi;
> +               else
> +                       ${get_cmd} ${loadaddr} ${image};
> +                       if test ${boot_fit} =3D yes || test ${boot_fit} =
=3D try; then
> +                               bootm ${loadaddr};
> +                       else
> +                               if ${get_cmd} ${fdt_addr_r} ${fdtfile}; t=
hen
> +                                       run boot_os;
> +                               else
> +                                       echo WARN: Cannot load the DT;
> +                               fi;
> +                       fi;
> +               fi;
> +bsp_bootcmd=3Decho Running BSP bootcmd ...;
> +                       mmc dev ${mmcdev}; if mmc rescan; then
> +                       if run loadbootscript; then
> +                               run bootscript;
> +                       else
> +                               if test ${sec_boot} =3D yes; then
> +                                       if run loadcntr; then
> +                                               run mmcboot;
> +                                       else run netboot;
> +                                       fi;
> +                               else
> +                                       if run loadimage; then
> +                                               run mmcboot;
> +                                       else run netboot;
> +                                       fi;
> +                               fi;
> +                       fi;
> +               fi;
> \ No newline at end of file
> diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx9=
5_evk/imx95_evk.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c75a8f2450288a34cfc01150d=
3c42b07f2215491
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_evk.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <fdt_support.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/gpio.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_early_init_f(void)
> +{
> +       /* UART1: A55, UART2: M33, UART3: M7 */
> +       init_uart_clk(0);
> +
> +       return 0;
> +}
> +
> +int board_init(void)
> +{
> +       return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +#ifdef CONFIG_ENV_IS_IN_MMC
> +       board_late_mmc_env_init();
> +#endif
> +
> +       return 0;
> +}
> +
> +int board_phys_sdram_size(phys_size_t *size)
> +{
> +       *size =3D PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
> +
> +       return 0;
> +}
> diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/=
spl.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..54f56c8049876fde335485a5c=
3bd54dff6e4f730
> --- /dev/null
> +++ b/board/freescale/imx95_evk/spl.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <command.h>
> +#include <cpu_func.h>
> +#include <clk.h>
> +#include <hang.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/syscounter.h>
> +#include <asm/mach-imx/ele_api.h>
> +#include <asm/sections.h>
> +#include <dm/uclass.h>
> +#include <dm/device.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/device-internal.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/ccm_regs.h>
> +#ifdef CONFIG_SCMI_FIRMWARE
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> +#endif
> +#include <asm/arch/mu.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int spl_board_boot_device(enum boot_device boot_dev_spl)
> +{
> +       switch (boot_dev_spl) {
> +       case SD1_BOOT:
> +       case MMC1_BOOT:
> +               return BOOT_DEVICE_MMC1;
> +       case SD2_BOOT:
> +       case MMC2_BOOT:
> +               return BOOT_DEVICE_MMC2;
> +       case USB_BOOT:
> +               return BOOT_DEVICE_BOARD;
> +       default:
> +               return BOOT_DEVICE_NONE;
> +       }
> +}
> +
> +void spl_board_init(void)
> +{
> +       puts("Normal Boot\n");
> +}
> +
> +void board_init_f(ulong dummy)
> +{
> +       int ret;
> +
> +       /* Clear the BSS. */
> +       memset(__bss_start, 0, __bss_end - __bss_start);
> +
> +#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
> +       if (IS_ENABLED(CONFIG_SPL_BUILD))
> +               spl_save_restore_data();
> +#endif
> +
> +       timer_init();
> +
> +       /* Need dm_init() to run before any SCMI calls can be made. */
> +       spl_early_init();
> +
> +       /* Need enable SCMI drivers and ELE driver before enabling consol=
e */
> +       ret =3D imx9_probe_mu();
> +       if (ret)
> +               hang(); /* if MU not probed, nothing can output, just han=
g here */
> +
> +       arch_cpu_init();
> +
> +       board_early_init_f();
> +
> +       preloader_console_init();
> +
> +       debug("SOC: 0x%x\n", gd->arch.soc_rev);
> +       debug("LC: 0x%x\n", gd->arch.lifecycle);
> +
> +       /* Will set ARM freq to max rate */
> +       clock_init_late();
> +
> +       board_init_r(NULL, 0);
> +}
> diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_=
defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d6b194528e7f3124e6626b28=
be0d6344758f6e5
> --- /dev/null
> +++ b/configs/imx95_19x19_evk_defconfig
> @@ -0,0 +1,177 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_IMX9=3Dy
> +CONFIG_TEXT_BASE=3D0x90200000
> +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x10000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> +CONFIG_NR_DRAM_BANKS=3D3
> +CONFIG_ENV_SIZE=3D0x4000
> +CONFIG_ENV_OFFSET=3D0x700000
> +CONFIG_ENV_SECT_SIZE=3D0x10000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/imx95-19x19-evk"
> +CONFIG_SPL_TEXT_BASE=3D0x20480000
> +CONFIG_TARGET_IMX95_19X19_EVK=3Dy
> +CONFIG_SYS_PROMPT=3D"u-boot=3D> "
> +CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_DRIVERS_MISC=3Dy
> +CONFIG_SPL_STACK=3D0x204d6000
> +CONFIG_SPL=3Dy
> +CONFIG_SPL_LOAD_IMX_CONTAINER=3Dy
> +CONFIG_IMX_CONFIG=3D"arch/arm/mach-imx/imx9/scmi/imximage.cfg"
> +CONFIG_IMX_CONTAINER_CFG=3D"arch/arm/mach-imx/imx9/scmi/container.cfg"
> +CONFIG_SYS_LOAD_ADDR=3D0x90400000
> +CONFIG_SYS_MEMTEST_START=3D0x90000000
> +CONFIG_SYS_MEMTEST_END=3D0xA0000000
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_SYS_MONITOR_LEN=3D524288
> +CONFIG_DEFAULT_FDT_FILE=3D"imx95-19x19-evk.dtb"
> +CONFIG_ARCH_MISC_INIT=3Dy
> +CONFIG_BOARD_EARLY_INIT_F=3Dy
> +CONFIG_BOARD_LATE_INIT=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x20000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0x204d6000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +CONFIG_SPL_BOARD_INIT=3Dy
> +CONFIG_SPL_MMC=3Dy
> +CONFIG_SPL_GPIO=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x93200000
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x80000
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1040
> +CONFIG_SPL_POWER=3Dy
> +CONFIG_SDP_LOADADDR=3D0x90400000
> +CONFIG_SPL_WATCHDOG=3Dy
> +CONFIG_SYS_MAXARGS=3D64
> +CONFIG_SYS_CBSIZE=3D2048
> +CONFIG_SYS_PBSIZE=3D2074
> +CONFIG_CMD_ERASEENV=3Dy
> +CONFIG_CMD_NVEDIT_EFI=3Dy
> +CONFIG_CMD_CRC32=3Dy
> +CONFIG_CRC32_VERIFY=3Dy
> +CONFIG_CMD_MEMTEST=3Dy
> +CONFIG_CMD_CLK=3Dy
> +CONFIG_CMD_DFU=3Dy
> +CONFIG_CMD_FUSE=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_GPT=3Dy
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_PART=3Dy
> +CONFIG_CMD_POWEROFF=3Dy
> +CONFIG_CMD_DHCP=3Dy
> +CONFIG_CMD_MII=3Dy
> +CONFIG_CMD_PING=3Dy
> +CONFIG_CMD_SNTP=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_CMD_EFIDEBUG=3Dy
> +CONFIG_CMD_RTC=3Dy
> +CONFIG_CMD_TIME=3Dy
> +CONFIG_CMD_GETTIME=3Dy
> +CONFIG_CMD_TIMER=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_CMD_HASH=3Dy
> +CONFIG_CMD_EXT2=3Dy
> +CONFIG_CMD_EXT4=3Dy
> +CONFIG_CMD_EXT4_WRITE=3Dy
> +CONFIG_CMD_FAT=3Dy
> +CONFIG_CMD_FS_GENERIC=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_ENV_IS_NOWHERE=3Dy
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SYS_MMC_ENV_DEV=3D1
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> +CONFIG_USE_ETHPRIME=3Dy
> +CONFIG_ETHPRIME=3D"eth0"
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SPL_DM=3Dy
> +CONFIG_REGMAP=3Dy
> +CONFIG_SYSCON=3Dy
> +CONFIG_DFU_MMC=3Dy
> +CONFIG_DFU_RAM=3Dy
> +CONFIG_IMX_RGPIO2P=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_SPI_FLASH=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_NXP_FSPI=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_SPI_FLASH_STMICRO=3Dy
> +CONFIG_SPI_FLASH_MT35XU=3Dy
> +CONFIG_SF_DEFAULT_BUS=3D0
> +CONFIG_SF_DEFAULT_SPEED=3D40000000
> +CONFIG_DM_PCA953X=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_IMX_LPI2C=3Dy
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_MMC_IO_VOLTAGE=3Dy
> +CONFIG_MMC_UHS_SUPPORT=3Dy
> +CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> +CONFIG_MMC_HS400_SUPPORT=3Dy
> +CONFIG_FSL_USDHC=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_MII=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_SPL_PINCTRL=3Dy
> +CONFIG_SPL_DM_REGULATOR=3Dy
> +CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_RTC=3Dy
> +CONFIG_DM_SERIAL=3Dy
> +CONFIG_FSL_LPUART=3Dy
> +CONFIG_ULP_WATCHDOG=3Dy
> +CONFIG_LZO=3Dy
> +CONFIG_BZIP2=3Dy
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_OF_SYSTEM_SETUP=3Dy
> +CONFIG_ADP5585_GPIO=3Dy
> +CONFIG_SPL_I2C=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +# SCMI options
> +CONFIG_DM_MAILBOX=3Dy
> +CONFIG_SCMI_FIRMWARE=3Dy
> +CONFIG_SCMI_AGENT_SMCCC=3Dn
> +CONFIG_CLK_SCMI=3Dy
> +CONFIG_CLK=3Dy
> +CONFIG_SPL_CLK_SCMI=3Dy
> +CONFIG_SPL_CLK=3Dy
> +CONFIG_PINCTRL_IMX_SCMI=3Dy
> +CONFIG_SCMI_POWER_DOMAIN=3Dy
> +CONFIG_SPL_DM_MAILBOX=3Dy
> +CONFIG_SPL_FIRMWARE=3Dy
> +#CONFIG_SPL_POWER_DOMAIN=3Dy
> +CONFIG_SPL_IMX_MU_MBOX=3Dy
> +CONFIG_IMX_MU_MBOX=3Dy
> +#CONFIG_REMOTEPROC_SCMI_LMM=3Dy
> +#CONFIG_CMD_REMOTEPROC=3Dy
> +# CONFIG_RESET_SCMI=3Dy
> +# CONFIG_DM_REGULATOR_SCMI=3Dy
> +CONFIG_SPL_OF_TRANSLATE=3Dy
> +CONFIG_PCI=3Dy
> +CONFIG_PCIE_ECAM_GENERIC=3Dy
> +CONFIG_PCI_SCAN_SHOW=3Dy
> +CONFIG_CMD_PCI=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_PHYLIB=3Dy
> +CONFIG_PHYLIB_10G=3Dy
> +CONFIG_PHY_AQUANTIA=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_FSL_ENETC=3Dy
> +CONFIG_SYS_RX_ETH_BUFFER=3D8
> +CONFIG_IMX8_ROMAPI=3Dn
> +CONFIG_CLK_CCF=3Dy
> +CONFIG_SPL_CLK_CCF=3Dy
> +CONFIG_SPL_RECOVER_DATA_SECTION=3Dy
> +CONFIG_ENV_SOURCE_FILE=3D"imx95_19x19_evk"
> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..132c45ed485148366533ee314=
85a4d5a41556eb0
> --- /dev/null
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -0,0 +1,116 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx95_evk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the NXP i.MX95 19x19 EVK board
> +
> +Quick Start
> +-----------
> +
> +- Get ahab-container.img
> +- Get DDR PHY Firmware Images
> +- Get and Build OEI Images
> +- Get and Build System Manager Image
> +- Get and Build the ARM Trusted Firmware
> +- Build the Bootloader Image
> +- Boot
> +
> +Get ahab-container.img
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3=
.0-17945fc.bin
> +   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
> +   $ ./firmware-ele-imx-1.3.0-17945fc.bin
> +   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctr=
ee)
> +
> +Get DDR PHY Firmware Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4=
c33ab.bin
> +   $ chmod +x firmware-imx-8.26-d4c33ab.bin
> +   $ ./firmware-imx-8.26-d4c33ab.bin
> +   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.b=
in $(srctree)
> +
> +Get and Build OEI Images
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get OEI from: https://github.com/nxp-imx/imx-oei
> +branch: master
> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=3D$PWD
> +   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
> +   $ cd imx-oei
> +   $ make board=3Dmx95lp5 oei=3Dddr DEBUG=3D1
> +   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
> +
> +   $ make board=3Dmx95lp5 oei=3Dtcm DEBUG=3D1
> +   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
> +
> +Get and Build System Manager Image
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get System Manager from: https://github.com/nxp-imx/imx-sm
> +branch: master
> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=3D$PWD
> +   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
> +   $ cd imx-sm
> +   $ make config=3Dmx95evk all
> +   $ cp build/mx95evk/m33_image.bin $(srctree)
> +
> +Get and Build the ARM Trusted Firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://github.com/nxp-imx/imx-atf/
> +branch: lf_v2.10
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ unset LDFLAGS
> +   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
> +   $ cd imx-atf
> +   $ make PLAT=3Dimx95 bl31
> +   $ cp build/imx95/release/bl31.bin $(srctree)
> +
> +Build the Bootloader Image
> +------------
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ make imx95_19x19_evk_defconfig
> +   $ make
> +
> +Copy imx-boot-imx95.bin to the MicroSD card:
> +
> +.. code-block:: bash
> +
> +   $ sudo dd if=3Dflash.bin of=3D/dev/sd[x] bs=3D1k seek=3D32 conv=3Dfsy=
nc
> +
> +Boot
> +----
> +
> +Set i.MX95 boot device to MicroSD card
> diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
> index 8ca4b5619863f616dbedc7eb0ff8a286a3fbbf48..e7ec725cc04e9755ba3dac375=
61c26ebc3f1c716 100644
> --- a/doc/board/nxp/index.rst
> +++ b/doc/board/nxp/index.rst
> @@ -15,6 +15,7 @@ NXP Semiconductors
>     imx91_11x11_evk
>     imx93_9x9_qsb
>     imx93_11x11_evk
> +   imx95_evk
>     imxrt1020-evk
>     imxrt1050-evk
>     imxrt1170-evk
> diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..00909a043a71751684ebd8dc4=
13b05d5aee8dd69
> --- /dev/null
> +++ b/include/configs/imx95_evk.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __IMX95_EVK_H
> +#define __IMX95_EVK_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE     \
> +       (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
> +
> +#define CFG_SYS_INIT_RAM_ADDR        0x90000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x90000000
> +#define PHYS_SDRAM                      0x90000000
> +/* Totally 16GB */
> +#define PHYS_SDRAM_SIZE                        0x70000000 /* 2GB  - 256M=
B DDR */
> +#define PHYS_SDRAM_2_SIZE              0x380000000 /* 14GB */
> +
> +#define CFG_SYS_FSL_USDHC_NUM  2
> +
> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
> +
> +#endif
>
> --
> 2.34.1
>
