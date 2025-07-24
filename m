Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A39CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BD0835C9;
	Thu, 24 Jul 2025 04:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zc7EfzYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B4F835D4; Thu, 24 Jul 2025 04:27:00 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7A2835C1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-55a4e55d3a9so523329e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 19:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753324017; x=1753928817; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLgFVIdzXyAmOgsK/uO7HfGBKJyNdNbiMligZJd6eic=;
 b=Zc7EfzYoHUmOE4uLsOA7/TNC2BZLx5FKFIuer/rg8m/uYxISCZncLbjCqqTCtFBpTD
 6KyDDP5qXFRgKIyIB0PY9SfKiAV5EtzKstwOty0vWFWTKlOTZgx6AHJ0jA2J76zDB3IL
 HEKeQe3OuffehhM3uUVUbXPDkbRSCGQkGKkvPU+V0P+q3GHKsGdDZDZ07YLztXGCQCVt
 wULjqu4929e44lkUQZgV3xm3qWQ2fNt8RYRf4zpRP/xUwgjAPlwHSRhq8wv+UNWK843q
 rV/iu3jUs3MBT+RyH8g2e77yXVBOfUmrvQ9ZrPYNWx2eExROv/FxsxXlg/Wl1UTk2Xq5
 rGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753324017; x=1753928817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLgFVIdzXyAmOgsK/uO7HfGBKJyNdNbiMligZJd6eic=;
 b=TsDFpuJIn/XOVRs0wSUJ8RPaAL3178+CXP9I11Whi9rZ13M9lMrz9awii/u9CBH5ik
 tch9l6w00cLNoACA68HIV1yX0VX8DJYTcPlLPvKgsxgCPTvuO7/ZEHh8rTgYgUUPQuVw
 QJuKnsP7aYquRimvsEBCruyDFX7sahJbQAhd+IfwLUrJsivQ+ksvIwhAXgZgqurW+X1+
 SmdTbiJ4enV9kovFd7wXSAQro1bf7Qpo9TGrr+XAqwCYAX8Xa992RDIQ8GQP5TTN7+QK
 l5D4CX0Cr3QhBiYCbuQha21uWyLly8SwUiSXlTthGoxqjJifWdj0GgSpz5YqKBAvwgEi
 ubWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWkYuZ5zNxor3HkcyLT0S6N/Rh5xG2DQTyAJmp+eY0VLb+FGr4q8l1AGF02jyPTZ7FZukoGx0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr/y6Z7zv82kN0E1HnEeCyGOUEmA7tGk+hwk23Q9MkEHqWif/p
 opmcog/3JfopQ4KTaDVU+hwW98ZfG1OKpNJX9rlGMMITt5un3+r5uhhqBHFifF97Ip1uTMlaRVn
 I/Netb2x2oOCLs3vsJ3OLzJ3Bx/Fd7rE=
X-Gm-Gg: ASbGncs0N8J/JjCE/HVtnOn5EGDKn86WhP/8wMIhDWqZzQyg7gJ+UmHDnRJbbFAgbbZ
 cTLxMFdgexH2wuaFcjkwtDHCayOPsR4o79wyabnqS9tj6rNOxxYks6gIMMnHZAzKJWEOAR3cihN
 pmuOIJjCxQR+Uc7t/lNmRiz8k/R4UWzT3JDX/gENbJEmDe7IKsRpve1UlAFFjlO/qjMlwMp1vTv
 8teqGWm7Ha4NUtkIeZB4u4YmCTmPhEbbwuyzdU=
X-Google-Smtp-Source: AGHT+IFdGpQ2ul+oJVW9nafcW7WSO2IN2dhV9CZPVKYYx1RA8/T2Cgj6HNkmcsHed8zluACYn/0VUzg6LmvLymUrsxk=
X-Received: by 2002:a05:6512:640d:b0:553:35f5:7aac with SMTP id
 2adb3069b0e04-55a513d68e9mr1613863e87.48.1753324017075; Wed, 23 Jul 2025
 19:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250722203736.1792103-1-festevam@gmail.com>
 <20250724032931.GD18395@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250724032931.GD18395@nxa18884-linux.ap.freescale.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Jul 2025 23:26:45 -0300
X-Gm-Features: Ac12FXwv2jMyhzbZ8x2t8El94F8QyQyD8ET1pMynpkSGPXixxprrg3kp5kXJ72g
Message-ID: <CAOMZO5A5y1EsLC-1osGTOy2ZxKHwXfRsMdRfVANdhTbfWQJxOg@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: Add initial board support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de
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

Hi Peng,

On Wed, Jul 23, 2025 at 11:19=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wr=
ote:
>
> Hi Fabio,
>
> Thanks for working on i.MX93 FRDM upstream.
>
> On Tue, Jul 22, 2025 at 05:37:36PM -0300, Fabio Estevam wrote:
> >Add the initial board support for the NXP i.MX93 FRDM board:
> >
> >https://www.nxp.com/design/design-center/development-boards-and-designs/=
frdm-i-mx-93-development-board:FRDM-IMX93
> >
> >Based on the NXP U-Boot code.
> >
> >There were attempts to upstream the board devicetree, but it has not bee=
n
> >accepted upstream yet:
> >
> >https://lore.kernel.org/linux-arm-kernel/20250526-fpg-nxp-imx93-frdm-v2-=
2-e5ad0efaec33@pengutronix.de/
> >
> >Once it reaches upstream, we can switch to OF_UPSTREAM.
> >
> >Signed-off-by: Fabio Estevam <festevam@gmail.com>
> >---
> > arch/arm/dts/Makefile                         |    1 +
> > arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi     |  212 ++
> > arch/arm/dts/imx93-11x11-frdm.dts             |  603 +++++
> > arch/arm/include/asm/arch-imx9/ddr.h          |    1 +
> > arch/arm/mach-imx/imx9/Kconfig                |    9 +
> > board/freescale/imx93_frdm/Kconfig            |   12 +
> > board/freescale/imx93_frdm/MAINTAINERS        |    6 +
> > board/freescale/imx93_frdm/Makefile           |   11 +
> > board/freescale/imx93_frdm/imx93_frdm.c       |   59 +
> > board/freescale/imx93_frdm/imx93_frdm.env     |   31 +
> > board/freescale/imx93_frdm/lpddr4_timing.h    |   13 +
> > .../freescale/imx93_frdm/lpddr4x_1gb_timing.c | 1996 +++++++++++++++++
> > .../freescale/imx93_frdm/lpddr4x_2gb_timing.c | 1995 ++++++++++++++++
> > board/freescale/imx93_frdm/spl.c              |  207 ++
> > configs/imx93_frdm_defconfig                  |  124 +
> > doc/board/nxp/imx93_frdm.rst                  |   75 +
> > doc/board/nxp/index.rst                       |    1 +
> > include/configs/imx93_frdm.h                  |   32 +
> > 18 files changed, 5388 insertions(+)
> > create mode 100644 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> > create mode 100644 arch/arm/dts/imx93-11x11-frdm.dts
> > create mode 100644 board/freescale/imx93_frdm/Kconfig
> > create mode 100644 board/freescale/imx93_frdm/MAINTAINERS
> > create mode 100644 board/freescale/imx93_frdm/Makefile
> > create mode 100644 board/freescale/imx93_frdm/imx93_frdm.c
> > create mode 100644 board/freescale/imx93_frdm/imx93_frdm.env
> > create mode 100644 board/freescale/imx93_frdm/lpddr4_timing.h
> > create mode 100644 board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
> > create mode 100644 board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
> > create mode 100644 board/freescale/imx93_frdm/spl.c
> > create mode 100644 configs/imx93_frdm_defconfig
> > create mode 100644 doc/board/nxp/imx93_frdm.rst
> > create mode 100644 include/configs/imx93_frdm.h
> >
> >diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> >index 17795f8f746d..09e3edc4f8b1 100644
> >--- a/arch/arm/dts/Makefile
> >+++ b/arch/arm/dts/Makefile
> >@@ -918,6 +918,7 @@ dtb-$(CONFIG_ARCH_IMX8M) +=3D \
> >       imx8mq-librem5-r4.dtb
> >
> > dtb-$(CONFIG_ARCH_IMX9) +=3D \
> >+      imx93-11x11-frdm.dtb \
> >       imx93-var-som-symphony.dtb
> >
> > dtb-$(CONFIG_ARCH_IMXRT) +=3D imxrt1020-evk.dtb \
> >diff --git a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi b/arch/arm/dts/im=
x93-11x11-frdm-u-boot.dtsi
> >new file mode 100644
> >index 000000000000..558a43470e81
> >--- /dev/null
> >+++ b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> >@@ -0,0 +1,212 @@
> >+// SPDX-License-Identifier: GPL-2.0+
> >+/*
> >+ * Copyright 2024 NXP
>
> 2025.
>
> >+ */
> >+
> >+#include "imx93-u-boot.dtsi"
> >+
> >+/ {
> >+      wdt-reboot {
> >+              compatible =3D "wdt-reboot";
> >+              wdt =3D <&wdog3>;
> >+              bootph-pre-ram;
> >+              bootph-some-ram;
> >+      };
> >+
> >+      aliases {
> >+              usbgadget0 =3D &usbg1;
> >+              usbgadget1 =3D &usbg2;
> >+      };
> >+
> >+      usbg1: usbg1 {
> >+              compatible =3D "fsl,imx27-usb-gadget";
> >+              dr_mode =3D "peripheral";
> >+              chipidea,usb =3D <&usbotg1>;
> >+              status =3D "okay";
> >+      };
> >+
> >+      usbg2: usbg2 {
> >+              compatible =3D "fsl,imx27-usb-gadget";
> >+              dr_mode =3D "peripheral";
> >+              chipidea,usb =3D <&usbotg2>;
> >+              status =3D "okay";
> >+      };
>
> This fsl,imx27-usb-gadget is only in NXP downstream, needs drop here.

Yes,  I have removed it in v2.

> >--- /dev/null
> >+++ b/board/freescale/imx93_frdm/lpddr4_timing.h
> >@@ -0,0 +1,13 @@
> >+/* SPDX-License-Identifier: GPL-2.0+ */
> >+/*
> >+ * Copyright 2022 Marek Vasut <marex@denx.de>
>
> Wrong Copyright.

The NXP code declares the externs inside the C file, which is not a
good practice.

I used the approach done by Marek on another board, so I kept his Copyright=
.

> Align macros.
>
> Seems some use blank space, some use tab

This is also fixed in v2.

I will address your 2025 Copyright changes and submit a v3.

Thanks
