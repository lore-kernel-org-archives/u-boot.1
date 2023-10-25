Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B087C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 16:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DB287B0F;
	Wed, 25 Oct 2023 18:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="hcC/ZfOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE71387B05; Wed, 25 Oct 2023 18:24:02 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B586187B05
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 18:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9be3b66f254so839956766b.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1698251039; x=1698855839;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFxA140wpFYS3WZqlX2Do4Vi1jfAeJQtZZswt0E57m8=;
 b=hcC/ZfOiZlRvwvzOPhzvVGFzFJ6rlHZNgMqZNuG6nduuPEn53aQ1s13WRhFkDB9MuU
 lJFYeg9hkCCUgV8X2Fwfmyozef80V33t1BwMqmfQTtNx/CPnow56fVvAknvgcbBWTfcN
 wszTcHEfzwedRtfhyDFxzWGmBA3zMC5923+/d4yDsmZXrkqJ36R8WWLlyryYc4+2LjF9
 SNx1OwZLHAUWWp44n3cD7NZZivNeqCMnn5hGeZUGRcRQzEAkVzyKOGDquGaMcn7vqpFX
 QEWx67GlP7WH9Kjri+tfI0Nmxg0U6mItPw87NoQDI/dJ86/tKzO0V/hqOMO1CXj84kx6
 IcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698251039; x=1698855839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFxA140wpFYS3WZqlX2Do4Vi1jfAeJQtZZswt0E57m8=;
 b=JAgqlBEyNxGQMgEU6dXyXDfzopllINhZ9DD14Iz7OnHbUkzYd2SxDgm5XSkBbLSqr9
 wfDHff6v+/iHJyljXGVcV9jlptoFftvrkSypItkp73lyBjI17TlTo7/uQohOYN0gdata
 FlmBnGbmwcSsRBpRS+Oh+5GP/knMRC8qHM5/Roj/hGc74N87TIHfdC8jCDE2hWFosemU
 pg0xM6gXElQxaUxOzW7eEisGhhCVVHx428+gJwmm6SPuLgiekoBu0keCGOODudRwdo2m
 cQKa5/h4M9m9NgufRK/q0Ul2GZ1Jc9/SNJhjbdqk7PTl/DJ44lSrlwORrA+IPsqLN0bM
 RxMg==
X-Gm-Message-State: AOJu0YzzWfWpOveyVxkd9T1+b39J6G8x2N32imeljUoiZ9lCwh8pex3a
 AxWvsfnf6mk+aRjb1ZSxKRGU8l35RiDaYPin/Agl8g==
X-Google-Smtp-Source: AGHT+IFsORPYXlQtsmUQthPlIdyIxJvWWxbF8sG7e49EgVtMS4aAhZqegXfT/pMQHq3Hw11gqxn65dFtZOIPliGumgQ=
X-Received: by 2002:a17:907:72c9:b0:9ba:33ef:fe4c with SMTP id
 du9-20020a17090772c900b009ba33effe4cmr12844955ejc.64.1698251039038; Wed, 25
 Oct 2023 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231019120623.1476421-1-festevam@gmail.com>
In-Reply-To: <20231019120623.1476421-1-festevam@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 25 Oct 2023 09:23:45 -0700
Message-ID: <CAJ+vNU0G0=hAqgREJbvvfdqQ79vEc5wY+rd64Je1yrkyzOwpUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: dts: imx8mm: Sync with linux-next 20231019
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, aford173@gmail.com, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 19, 2023 at 5:06=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Sync imx8mm.dtsi with linux-next 20231019.
>
> The motivation for doing this sync was a bug when doing "ums 0 mmc 1"
> on imx8mm-evk. It worked well for the first time, but after doing
> a CTRL+C and launching the ums again, the command did not work.
>
> Adam Ford suggested to sync imx8mm.dtsi with the Linux dts, as there was
> a recent USB power domain reorganization there.
>
> After syncing the imx8mm.dtsi with Linux, the ums command works without
> problem after a CTRL+C.
>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Rebased against latest U-Boot and synced with linux-next 20231019.
>
>  arch/arm/dts/imx8mm.dtsi | 153 +++++++++++++++++++++++++++++++++------
>  1 file changed, 129 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/dts/imx8mm.dtsi b/arch/arm/dts/imx8mm.dtsi
> index afb90f59c83c..738024baaa57 100644
> --- a/arch/arm/dts/imx8mm.dtsi
> +++ b/arch/arm/dts/imx8mm.dtsi
> @@ -139,6 +139,7 @@
>                 A53_L2: l2-cache0 {
>                         compatible =3D "cache";
>                         cache-level =3D <2>;
> +                       cache-unified;
>                         cache-size =3D <0x80000>;
>                         cache-line-size =3D <64>;
>                         cache-sets =3D <512>;
> @@ -276,6 +277,7 @@
>                 assigned-clocks =3D <&clk IMX8MM_CLK_USB_PHY_REF>;
>                 assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL1_100M>;
>                 clock-names =3D "main_clk";
> +               power-domains =3D <&pgc_otg1>;
>         };
>
>         usbphynop2: usbphynop2 {
> @@ -285,6 +287,7 @@
>                 assigned-clocks =3D <&clk IMX8MM_CLK_USB_PHY_REF>;
>                 assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL1_100M>;
>                 clock-names =3D "main_clk";
> +               power-domains =3D <&pgc_otg2>;
>         };
>
>         soc: soc@0 {
> @@ -396,6 +399,7 @@
>                                                       "pll8k", "pll11k", =
"clkext3";
>                                         dmas =3D <&sdma2 24 25 0x80000000=
>;
>                                         dma-names =3D "rx";
> +                                       #sound-dai-cells =3D <0>;
>                                         status =3D "disabled";
>                                 };
>
> @@ -493,6 +497,8 @@
>                                 compatible =3D "fsl,imx8mm-tmu";
>                                 reg =3D <0x30260000 0x10000>;
>                                 clocks =3D <&clk IMX8MM_CLK_TMU_ROOT>;
> +                               nvmem-cells =3D <&tmu_calib>;
> +                               nvmem-cell-names =3D "calib";
>                                 #thermal-sensor-cells =3D <0>;
>                         };
>
> @@ -547,8 +553,8 @@
>                                 reg =3D <0x30330000 0x10000>;
>                         };
>
> -                       gpr: iomuxc-gpr@30340000 {
> -                               compatible =3D "fsl,imx8mm-iomuxc-gpr", "=
fsl,imx6q-iomuxc-gpr", "syscon";
> +                       gpr: syscon@30340000 {
> +                               compatible =3D "fsl,imx8mm-iomuxc-gpr", "=
syscon";
>                                 reg =3D <0x30340000 0x10000>;
>                         };
>
> @@ -560,22 +566,40 @@
>                                 #address-cells =3D <1>;
>                                 #size-cells =3D <1>;
>
> -                               imx8mm_uid: unique-id@410 {
> +                               /*
> +                                * The register address below maps to the=
 MX8M
> +                                * Fusemap Description Table entries this=
 way.
> +                                * Assuming
> +                                *   reg =3D <ADDR SIZE>;
> +                                * then
> +                                *   Fuse Address =3D (ADDR * 4) + 0x400
> +                                * Note that if SIZE is greater than 4, t=
hen
> +                                * each subsequent fuse is located at off=
set
> +                                * +0x10 in Fusemap Description Table (e.=
g.
> +                                * reg =3D <0x4 0x8> describes fuses 0x41=
0 and
> +                                * 0x420).
> +                                */
> +                               imx8mm_uid: unique-id@4 { /* 0x410-0x420 =
*/
>                                         reg =3D <0x4 0x8>;
>                                 };
>
> -                               cpu_speed_grade: speed-grade@10 {
> +                               cpu_speed_grade: speed-grade@10 { /* 0x44=
0 */
>                                         reg =3D <0x10 4>;
>                                 };
>
> -                               fec_mac_address: mac-address@90 {
> +                               tmu_calib: calib@3c { /* 0x4f0 */
> +                                       reg =3D <0x3c 4>;
> +                               };
> +
> +                               fec_mac_address: mac-address@90 { /* 0x64=
0 */
>                                         reg =3D <0x90 6>;
>                                 };
>                         };
>
> -                       anatop: anatop@30360000 {
> -                               compatible =3D "fsl,imx8mm-anatop", "sysc=
on";
> +                       anatop: clock-controller@30360000 {
> +                               compatible =3D "fsl,imx8mm-anatop";
>                                 reg =3D <0x30360000 0x10000>;
> +                               #clock-cells =3D <1>;
>                         };
>
>                         snvs: snvs@30370000 {
> @@ -674,13 +698,11 @@
>                                         pgc_otg1: power-domain@2 {
>                                                 #power-domain-cells =3D <=
0>;
>                                                 reg =3D <IMX8MM_POWER_DOM=
AIN_OTG1>;
> -                                               power-domains =3D <&pgc_h=
siomix>;
>                                         };
>
>                                         pgc_otg2: power-domain@3 {
>                                                 #power-domain-cells =3D <=
0>;
>                                                 reg =3D <IMX8MM_POWER_DOM=
AIN_OTG2>;
> -                                               power-domains =3D <&pgc_h=
siomix>;
>                                         };
>
>                                         pgc_gpumix: power-domain@4 {
> @@ -1098,6 +1120,61 @@
>                         #size-cells =3D <1>;
>                         ranges =3D <0x32c00000 0x32c00000 0x400000>;
>
> +                       lcdif: lcdif@32e00000 {
> +                               compatible =3D "fsl,imx8mm-lcdif", "fsl,i=
mx6sx-lcdif";
> +                               reg =3D <0x32e00000 0x10000>;
> +                               clocks =3D <&clk IMX8MM_CLK_LCDIF_PIXEL>,
> +                                        <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
> +                               clock-names =3D "pix", "axi", "disp_axi";
> +                               assigned-clocks =3D <&clk IMX8MM_CLK_LCDI=
F_PIXEL>,
> +                                                 <&clk IMX8MM_CLK_DISP_A=
XI>,
> +                                                 <&clk IMX8MM_CLK_DISP_A=
PB>;
> +                               assigned-clock-parents =3D <&clk IMX8MM_V=
IDEO_PLL1_OUT>,
> +                                                        <&clk IMX8MM_SYS=
_PLL2_1000M>,
> +                                                        <&clk IMX8MM_SYS=
_PLL1_800M>;
> +                               assigned-clock-rates =3D <594000000>, <50=
0000000>, <200000000>;
> +                               interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_=
HIGH>;
> +                               power-domains =3D <&disp_blk_ctrl IMX8MM_=
DISPBLK_PD_LCDIF>;
> +                               status =3D "disabled";
> +
> +                               port {
> +                                       lcdif_to_dsim: endpoint {
> +                                               remote-endpoint =3D <&dsi=
m_from_lcdif>;
> +                                       };
> +                               };
> +                       };
> +
> +                       mipi_dsi: dsi@32e10000 {
> +                               compatible =3D "fsl,imx8mm-mipi-dsim";
> +                               reg =3D <0x32e10000 0x400>;
> +                               clocks =3D <&clk IMX8MM_CLK_DSI_CORE>,
> +                                        <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +                               clock-names =3D "bus_clk", "sclk_mipi";
> +                               assigned-clocks =3D <&clk IMX8MM_CLK_DSI_=
CORE>,
> +                                                 <&clk IMX8MM_CLK_DSI_PH=
Y_REF>;
> +                               assigned-clock-parents =3D <&clk IMX8MM_S=
YS_PLL1_266M>,
> +                                                        <&clk IMX8MM_CLK=
_24M>;
> +                               assigned-clock-rates =3D <266000000>, <24=
000000>;
> +                               samsung,pll-clock-frequency =3D <24000000=
>;
> +                               interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL=
_HIGH>;
> +                               power-domains =3D <&disp_blk_ctrl IMX8MM_=
DISPBLK_PD_MIPI_DSI>;
> +                               status =3D "disabled";
> +
> +                               ports {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +
> +                                       port@0 {
> +                                               reg =3D <0>;
> +
> +                                               dsim_from_lcdif: endpoint=
 {
> +                                                       remote-endpoint =
=3D <&lcdif_to_dsim>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +
>                         csi: csi@32e20000 {
>                                 compatible =3D "fsl,imx8mm-csi", "fsl,imx=
7-csi";
>                                 reg =3D <0x32e20000 0x1000>;
> @@ -1145,10 +1222,9 @@
>                                 compatible =3D "fsl,imx8mm-mipi-csi2";
>                                 reg =3D <0x32e30000 0x1000>;
>                                 interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL=
_HIGH>;
> -                               assigned-clocks =3D <&clk IMX8MM_CLK_CSI1=
_CORE>,
> -                                                 <&clk IMX8MM_CLK_CSI1_P=
HY_REF>;
> -                               assigned-clock-parents =3D <&clk IMX8MM_S=
YS_PLL2_1000M>,
> -                                                         <&clk IMX8MM_SY=
S_PLL2_1000M>;
> +                               assigned-clocks =3D <&clk IMX8MM_CLK_CSI1=
_CORE>;
> +                               assigned-clock-parents =3D <&clk IMX8MM_S=
YS_PLL2_1000M>;
> +
>                                 clock-frequency =3D <333000000>;
>                                 clocks =3D <&clk IMX8MM_CLK_DISP_APB_ROOT=
>,
>                                          <&clk IMX8MM_CLK_CSI1_ROOT>,
> @@ -1177,7 +1253,7 @@
>                         };
>
>                         usbotg1: usb@32e40000 {
> -                               compatible =3D "fsl,imx8mm-usb", "fsl,imx=
7d-usb";
> +                               compatible =3D "fsl,imx8mm-usb", "fsl,imx=
7d-usb", "fsl,imx27-usb";
>                                 reg =3D <0x32e40000 0x200>;
>                                 interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 clocks =3D <&clk IMX8MM_CLK_USB1_CTRL_ROO=
T>;
> @@ -1186,18 +1262,19 @@
>                                 assigned-clock-parents =3D <&clk IMX8MM_S=
YS_PLL2_500M>;
>                                 phys =3D <&usbphynop1>;
>                                 fsl,usbmisc =3D <&usbmisc1 0>;
> -                               power-domains =3D <&pgc_otg1>;
> +                               power-domains =3D <&pgc_hsiomix>;
>                                 status =3D "disabled";
>                         };
>
>                         usbmisc1: usbmisc@32e40200 {
> -                               compatible =3D "fsl,imx8mm-usbmisc", "fsl=
,imx7d-usbmisc";
> +                               compatible =3D "fsl,imx8mm-usbmisc", "fsl=
,imx7d-usbmisc",
> +                                            "fsl,imx6q-usbmisc";
>                                 #index-cells =3D <1>;
>                                 reg =3D <0x32e40200 0x200>;
>                         };
>
>                         usbotg2: usb@32e50000 {
> -                               compatible =3D "fsl,imx8mm-usb", "fsl,imx=
7d-usb";
> +                               compatible =3D "fsl,imx8mm-usb", "fsl,imx=
7d-usb", "fsl,imx27-usb";
>                                 reg =3D <0x32e50000 0x200>;
>                                 interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 clocks =3D <&clk IMX8MM_CLK_USB1_CTRL_ROO=
T>;
> @@ -1206,12 +1283,13 @@
>                                 assigned-clock-parents =3D <&clk IMX8MM_S=
YS_PLL2_500M>;
>                                 phys =3D <&usbphynop2>;
>                                 fsl,usbmisc =3D <&usbmisc2 0>;
> -                               power-domains =3D <&pgc_otg2>;
> +                               power-domains =3D <&pgc_hsiomix>;
>                                 status =3D "disabled";
>                         };
>
>                         usbmisc2: usbmisc@32e50200 {
> -                               compatible =3D "fsl,imx8mm-usbmisc", "fsl=
,imx7d-usbmisc";
> +                               compatible =3D "fsl,imx8mm-usbmisc", "fsl=
,imx7d-usbmisc",
> +                                            "fsl,imx6q-usbmisc";
>                                 #index-cells =3D <1>;
>                                 reg =3D <0x32e50200 0x200>;
>                         };
> @@ -1238,16 +1316,15 @@
>                                      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names =3D "gpmi0", "gpmi1", "gpmi2", "g=
pmi3";
>                         #dma-cells =3D <1>;
>                         dma-channels =3D <4>;
>                         clocks =3D <&clk IMX8MM_CLK_NAND_USDHC_BUS_RAWNAN=
D_CLK>;
>                 };
>
> -               gpmi: nand-controller@33002000{
> +               gpmi: nand-controller@33002000 {
>                         compatible =3D "fsl,imx8mm-gpmi-nand", "fsl,imx7d=
-gpmi-nand";
>                         #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> +                       #size-cells =3D <0>;
>                         reg =3D <0x33002000 0x2000>, <0x33004000 0x4000>;
>                         reg-names =3D "gpmi-nand", "bch";
>                         interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1268,8 +1345,8 @@
>                         #size-cells =3D <2>;
>                         device_type =3D "pci";
>                         bus-range =3D <0x00 0xff>;
> -                       ranges =3D  <0x81000000 0 0x00000000 0x1ff80000 0=
 0x00010000 /* downstream I/O 64KB */
> -                                  0x82000000 0 0x18000000 0x18000000 0 0=
x07f00000>; /* non-prefetchable memory */
> +                       ranges =3D <0x81000000 0 0x00000000 0x1ff80000 0 =
0x00010000>, /* downstream I/O 64KB */
> +                                <0x82000000 0 0x18000000 0x18000000 0 0x=
07f00000>; /* non-prefetchable memory */
>                         num-lanes =3D <1>;
>                         num-viewport =3D <4>;
>                         interrupts =3D <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1282,12 +1359,40 @@
>                                         <0 0 0 4 &gic GIC_SPI 122 IRQ_TYP=
E_LEVEL_HIGH>;
>                         fsl,max-link-speed =3D <2>;
>                         linux,pci-domain =3D <0>;
> +                       clocks =3D <&clk IMX8MM_CLK_PCIE1_ROOT>,
> +                                <&clk IMX8MM_CLK_PCIE1_PHY>,
> +                                <&clk IMX8MM_CLK_PCIE1_AUX>;
> +                       clock-names =3D "pcie", "pcie_bus", "pcie_aux";
> +                       power-domains =3D <&pgc_pcie>;
> +                       resets =3D <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
> +                                <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOF=
F>;
> +                       reset-names =3D "apps", "turnoff";
> +                       phys =3D <&pcie_phy>;
> +                       phy-names =3D "pcie-phy";
> +                       status =3D "disabled";
> +               };
> +
> +               pcie0_ep: pcie-ep@33800000 {
> +                       compatible =3D "fsl,imx8mm-pcie-ep";
> +                       reg =3D <0x33800000 0x400000>,
> +                             <0x18000000 0x8000000>;
> +                       reg-names =3D "dbi", "addr_space";
> +                       num-lanes =3D <1>;
> +                       interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names =3D "dma";
> +                       fsl,max-link-speed =3D <2>;
> +                       clocks =3D <&clk IMX8MM_CLK_PCIE1_ROOT>,
> +                                <&clk IMX8MM_CLK_PCIE1_PHY>,
> +                                <&clk IMX8MM_CLK_PCIE1_AUX>;
> +                       clock-names =3D "pcie", "pcie_bus", "pcie_aux";
>                         power-domains =3D <&pgc_pcie>;
>                         resets =3D <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
>                                  <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOF=
F>;
>                         reset-names =3D "apps", "turnoff";
>                         phys =3D <&pcie_phy>;
>                         phy-names =3D "pcie-phy";
> +                       num-ib-windows =3D <4>;
> +                       num-ob-windows =3D <4>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.34.1
>

For the series:

Acked-by: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim
