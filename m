Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E36F506C3
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 12:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF3584067;
	Mon, 16 Mar 2026 13:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n0rxWnkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAA484068; Mon, 16 Mar 2026 13:39:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCC484065
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 13:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9795ca4e6dso321846166b.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 05:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773664777; cv=none;
 d=google.com; s=arc-20240605;
 b=Gx1r9B0C3XasnddchxywrdqHYddVswhSNYzgz2r8SS1oKerYWvatgkU/2MtwC2ZdiP
 FG8Pt+vMZTHtTsM31I4wTZ0DkGf2wEbd5lbFFmXrPuUBzbPKjxYcjGK/3BOQV4k0ziCh
 17KAN4bK1ovdWFciHwv70RWg8uwZuZOLnuzb0xYmHF/wp1bhKq1fbkCLe4BSBQL/ee4S
 y/QCWHsEdEBeIrSxbT+wCDoEHiLoc9eL8ZG+YS3E4vm7dxB7XS2pdRERf7dN1yfApoyf
 QhZ7quYDFqPo5lgU/0zlpspDPRhEiDugtm5+gqWyzJQBGv+3T0taY3TqUm66gWOC7/uu
 BbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d1fb09hoGJae7EEVLseR/Ky5hi9PJI8onlMaI2I5i9Y=;
 fh=r26+E2rMkeWHGcMqIOt8V4ha9b7bhNXBAIcGPdmepcw=;
 b=eoJcWyyzUTXwUly3hpfuUm8HvBMsGn/kIGZOdBkL7PTedDl015yJJbRpaicAtU48gh
 kkZfY5K7ADqHZTcYCmmN0j8QX+VGf1ecU+v4Y/K7tyhsVkiEedfIL/TZ7ms0UFYDO+oI
 NKDHMVqAIFl0gFQTO26a5biGAzcPj8Q9D3nrhmNYf2pSKCGljLW01e8mK7W2yosmNb6i
 3XmQyYPyX6zxIzTTuVw00pvX/wLVK6Ha12ti7pOmobxdPrOgoibyTsaF2dz/Uo3UZe5p
 xBjE/5ogWU7sa+/ScBikfTXLEDcEaQwLR1UNiTgrzdiAIchNtkq8RZBISrFeF9hNeDqs
 4dBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773664777; x=1774269577;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1fb09hoGJae7EEVLseR/Ky5hi9PJI8onlMaI2I5i9Y=;
 b=n0rxWnkCYlI/xXjjuF474/RlFPhWXF1xqBSUf798lbRv2Dx6Fuz2Cuwb8KEAMEYwB8
 wg2cSMFpWaoM0xNh+nlALojGjZGMJJ/vGHw+ZCjc97xhR3TL6zNvxfRqFWLnTwJGqI5E
 SETLVyLUMaW2PXN83w3hyXV42EPKGroaus3HDsfyX2Zr29UxwARKzmjIFIbp6bCIyoc4
 l8BFl+8NDIu0ZXbji+1c1IdHo6QB4X1J1ue0uQnrhwnVQIU3+XzT71aWp6wXwkeFRfL/
 vMTi/NoNacl9lyXMa7RacYo48/QGF9MywQ5ppMDINTvgwo23fpnDg2QXHtyBQ9KEU8YX
 vOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773664777; x=1774269577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1fb09hoGJae7EEVLseR/Ky5hi9PJI8onlMaI2I5i9Y=;
 b=Lk8FfGA3lfUeb+eXLTv2Lv/q6xV/SDEDysawDUhlQcGQje2Lxd0NDspSUoQfND5ITa
 v/rX6Z3a4Ag04TUhOCpTRgETlGvOh0MOuh5zufhuaV9yiHRs5yycUMQhaSdXpIuDQjpQ
 1Y+3jFLyaRr1+wNpuoAyWTY9/Q/6erox8BKeP3E2J5rbLot813X77mnfkbalg46vsyBD
 buwaskCyi8IAxL7wvCcfugGpyIOePtStU9dIxHDDCr6jOwqkDKlriH+Ml7m4DXQMONos
 GEmiKvohTtr4xw3BIZ4Vau4//3+LPxZGRae3iqagdwsOcKSIUxB/3AZPvtW3jMFnOpxI
 if1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi9FH42DeTYk1LZIsNDvoZVfoSre8qYf03zlhYIRyQ2aBz0eABCCiMFAxh1UG94YBRtJHmfv0=@lists.denx.de
X-Gm-Message-State: AOJu0YwTJjE8W7LqvqBx5bKYx01ei+BUZCIeThrBSNX+yvoBQLqwFlDe
 iBYXWaOifNZzSGVMhjhcKhYn+W1+zCl4119LnLK4tK3gVhJTLr8tqzCDafNt+sFtO/yoz6UdgFs
 mJqaZ4HFkbptxWOZ8frUGSyEeJ0wzWO5ZQ9uwfdcRdg==
X-Gm-Gg: ATEYQzxu5+yFoUt1N7MFi4e91eTY3US7EegU06TpRJOpritT6dZAi829JPix8Aiqcub
 DPpe2ERKjYlF+jkXU52DXpPrVyQ0aJJnmFnWqvBPLRZoSe9YXpMx61yOouBrviaN+OrLamU+Xuq
 J9gtv++wfH2GSirjXp4M3vKsc/mwZIcE3t/zfOaAFGm3V+QIAWj4wh8uIfUlFl9/FmeD7kpT6ey
 oxALgIROGAI3QTYAd01do/KKyk6vK+eiBUGTY8KQmRkyfnwXS450cvF185qrPBH/2gD9CtLmNCA
 mf3D2Wtvsya3eihtMOSitQXNwUufCkWdEu/6jD+G9niQmE+7IQ7NiG0ARQXbjGhp1TRVp15hAXq
 V+Dbez2HqgPW2N9F1QJggXA6Miwi0O7dWTifo
X-Received: by 2002:a17:907:689d:b0:b97:6147:def1 with SMTP id
 a640c23a62f3a-b9765104ccdmr550874666b.33.1773664776871; Mon, 16 Mar 2026
 05:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-5-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-5-1dc862d58532@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 16 Mar 2026 13:39:28 +0100
X-Gm-Features: AaiRm53vs8YwEEa6aVwYBh4BxSxwRTLj12_e_VIAw5Yuik0OQdbv149PDVqsrjU
Message-ID: <CAEHHSvYmZ=0LKgF9XvLu59KdzRpZUhS9Fv=YAXbcZkexa1U2hA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm: dts: mediatek: Add MediaTek Genio 520/720 EVK
 DTS
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
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

Le mer. 11 mars 2026 =C3=A0 01:17, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>
> Add a basic .dts file for MediaTek Genio 520/720 EVKs. This will suffice
> until an upstream devicetree is available from Linux.
>
> These boards a virtually identical (other than some camera capabilities)

nit: These boards are [...]

> so share mostly the same devicetree.
>
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/dts/Makefile                 |   2 +
>  arch/arm/dts/mt8371-genio-520-evk.dts |  11 +++
>  arch/arm/dts/mt8371-genio-common.dtsi | 176 ++++++++++++++++++++++++++++=
++++++
>  arch/arm/dts/mt8391-genio-720-evk.dts |  11 +++
>  4 files changed, 200 insertions(+)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 264b13b6f5d..bd0f0fd7018 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1135,6 +1135,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D \
>         mt7988-rfb.dtb \
>         mt7988-sd-rfb.dtb \
>         mt8183-pumpkin.dtb \
> +       mt8371-genio-520-evk.dtb \
> +       mt8391-genio-720-evk.dtb \
>         mt8512-bm1-emmc.dtb \
>         mt8516-pumpkin.dtb \
>         mt8518-ap1-emmc.dtb
> diff --git a/arch/arm/dts/mt8371-genio-520-evk.dts b/arch/arm/dts/mt8371-=
genio-520-evk.dts
> new file mode 100644
> index 00000000000..1ed325eb587
> --- /dev/null
> +++ b/arch/arm/dts/mt8371-genio-520-evk.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/dts-v1/;
> +
> +#include "mt8189.dtsi"
> +#include "mt8371-genio-common.dtsi"
> +
> +/ {
> +       model =3D "MediaTek Genio-520 EVK";
> +       compatible =3D "mediatek,mt8371-evk", "mediatek,mt8371", "mediate=
k,mt8189";
> +};
> diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-=
genio-common.dtsi
> new file mode 100644
> index 00000000000..c6aa22b7d10
> --- /dev/null
> +++ b/arch/arm/dts/mt8371-genio-common.dtsi
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +
> +#include "mt8189.dtsi"
> +#include "mt8189-pinfunc.h"
> +#include "mt6359.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:921600n8";
> +       };
> +
> +       firmware {
> +               optee {
> +                       compatible =3D "linaro,optee-tz";
> +                       method =3D "smc";
> +               };
> +
> +               psci {
> +                       compatible =3D "arm,psci-1.0";
> +                       method =3D "smc";
> +               };
> +       };
> +
> +       memory@40000000 {
> +               /* 8GB */
> +               device_type =3D "memory";
> +               reg =3D <0 0x40000000 0x2 0x00000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +               /* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +               bl31_secmon_reserved: secmon@54600000 {
> +                       no-map;
> +                       reg =3D <0 0x54600000 0x0 0x200000>;
> +               };
> +
> +               /* 12 MiB reserved for OP-TEE (BL32)
> +                * +-----------------------+ 0x43e0_0000
> +                * |      SHMEM 2MiB       |
> +                * +-----------------------+ 0x43c0_0000
> +                * |        | TA_RAM  8MiB |
> +                * + TZDRAM +--------------+ 0x4340_0000
> +                * |        | TEE_RAM 2MiB |
> +                * +-----------------------+ 0x4320_0000
> +                */
> +               optee_reserved: optee@43200000 {
> +                       no-map;
> +                       reg =3D <0 0x43200000 0 0x00c00000>;
> +               };
> +
> +               dsi_reserved: dsi@60000000 {
> +                       reg =3D <0 0x60000000 0 0x02000000>;
> +                       no-map;
> +               };
> +       };
> +};
> +
> +&watchdog {
> +       status =3D "okay";
> +};
> +
> +&uart0 {
> +       pinctrl-0 =3D <&uart0_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +&mmc0 {
> +       bus-width =3D <8>;
> +       max-frequency =3D <200000000>;
> +       cap-mmc-highspeed;
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       hs400-ds-delay =3D <0x1481b>;
> +       cap-mmc-hw-reset;
> +       vmmc-supply =3D <&mt6359_vemc_1_ldo_reg>;
> +       vqmmc-supply =3D <&mt6359_vufs_ldo_reg>;
> +       non-removable;
> +       pinctrl-names =3D "default", "state_uhs";
> +       pinctrl-0 =3D <&mmc0_default_pins>;
> +       pinctrl-1 =3D <&mmc0_uhs_pins>;
> +       status =3D "okay";
> +};
> +
> +&mt6359_vufs_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&pio {
> +       mmc0_default_pins: mmc0-default-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> +                       drive-strength =3D <6>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> +                                <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> +                                <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> +                                <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> +                                <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> +                                <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> +                                <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> +                                <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> +                                <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> +                       input-enable;
> +                       drive-strength =3D <6>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-rst {
> +                       pinmux =3D <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> +                       drive-strength =3D <6>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_00>;
> +               };
> +       };
> +
> +       mmc0_uhs_pins: mmc0-uhs-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
> +                       drive-strength =3D <8>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
> +                                <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
> +                                <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
> +                                <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
> +                                <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
> +                                <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
> +                                <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
> +                                <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
> +                                <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
> +                       input-enable;
> +                       drive-strength =3D <8>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-ds {
> +                       pinmux =3D <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
> +                       drive-strength =3D <8>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-rst {
> +                       pinmux =3D <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_00>;
> +               };
> +       };
> +
> +       uart0_pins: uart0-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO31__FUNC_UTXD0>,
> +                                <PINMUX_GPIO32__FUNC_URXD0>;
> +                       bias-pull-up;
> +               };
> +       };
> +};
> +
> +&pmic {
> +       interrupts-extended =3D <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
> +};
> diff --git a/arch/arm/dts/mt8391-genio-720-evk.dts b/arch/arm/dts/mt8391-=
genio-720-evk.dts
> new file mode 100644
> index 00000000000..c8e57433ce6
> --- /dev/null
> +++ b/arch/arm/dts/mt8391-genio-720-evk.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/dts-v1/;
> +
> +#include "mt8189.dtsi"
> +#include "mt8371-genio-common.dtsi"
> +
> +/ {
> +       model =3D "MediaTek Genio-720 EVK";
> +       compatible =3D "mediatek,mt8391-evk", "mediatek,mt8391", "mediate=
k,mt8189";
> +};
>
> --
> 2.43.0
>
