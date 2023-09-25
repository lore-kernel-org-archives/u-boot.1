Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A0CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 09:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7BA86BBC;
	Mon, 25 Sep 2023 11:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="KpFti4qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A09886BB4; Mon, 25 Sep 2023 11:52:45 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A559286BE7
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bf2427b947so2984550a34.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695635560; x=1696240360;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dv8q3jVwIIP5vfwkQs7r5rT7S1n9E7GG383KbXZSDbI=;
 b=KpFti4qm+emL3vXiyLgTAylSiiegwsezsfUZCDviLYK14fK1vx7yfw8oQxJlGgLq2o
 SHXuxnc18hL0wKIuQmQllFUuMZOCCGiJhPEM5+dQlY3yma+SzGYAOjrqgd8AU210h4mO
 NrliRfzZqPv8PcO51DhQzunH3bUckie81qPjRvuiXtAwC41WJNn8gHDIa9ytCTWEhVUV
 HpuHZEYaKPFYab6CDRjLQBEkLEZKghUUtuLObH7abl3JJ0t+Gv8F5cNRGgv71H10RbwD
 TP4C2aSz23llQlcfmNPMYx2/QjuPPiDDMV8y+IWgjO1qznzU05zjtx5ymt977HUFKlWg
 TFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695635560; x=1696240360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dv8q3jVwIIP5vfwkQs7r5rT7S1n9E7GG383KbXZSDbI=;
 b=ZEptWf+Bt6WTF6m21exHag0j+LXBBwJpopQiA6sn8PTLALkWNMcCrJsrXXEfrzIJZQ
 ONu+TcDWpD7kOsKadEOodYCdiWNzFEE6kOkJ+Go3MwZHHhSEdBvPHuUPoMMOHvfoTwQo
 SyW/k1+84kkePZMikXri+sQqhluaGPH0+vnyZblEBBw9/fRfn+EytEVPJplsuesfFBqz
 po6oF9gmvgciD/oKUjgN0qUNJy1luGQCF7VMHkqz2D9xlWlv9Wj81fxfTQlsZ9n8yUlE
 0ylchCMx8VUbSQyZUn+kCj9luJTeu3lMSEBdYKlbeRVb8Sk/BDrE67UWF5gVMa1qsNYb
 hiXg==
X-Gm-Message-State: AOJu0Yyl+TXLHM0klvqfOc1iT4EHeLv4gTqbbpPmzcr7B/4ICPZqFSmf
 6bm/tXAoxrvdP6njY/ce5tgGX1R90/HEHLTBu8PfB0c20U0=
X-Google-Smtp-Source: AGHT+IFro+bN2prM+MjlLzJUyaD4Fvld7NIg+XqMuvUGyrDHsgVDIdxQzEt8L1Zv3xQV/VC3e+78DIU1HQcchiD2/zU=
X-Received: by 2002:a9d:6d85:0:b0:6bd:a47:7bb6 with SMTP id
 x5-20020a9d6d85000000b006bd0a477bb6mr5857620otp.14.1695635560038; Mon, 25 Sep
 2023 02:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
In-Reply-To: <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Mon, 25 Sep 2023 11:52:28 +0200
Message-ID: <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio,

I used the following diff with "make mx28evk_defconfig", but unfortunately
still get absolutely nothing on the DUART when running "mxsloader u-boot.sb=
".
In fact, mxsloader returns immediately on trying to load my own u-boot.sb,
whereas it hangs when running the vendor u-boot.sb, I assume because the
CALL never returns. Additionally, there is no need to reset the board
between attempting a custom u-boot and the vendor u-boot, indicating that
the ROM-based SDP protocol handler is still running. This suggests that
there is something wrong with the format of the u-boot.sb file which the
ROM-based SDP protocol handler is rejecting, I would think?

I did confirm that the correct DTB file is being used, as the dts/dt.dtb
file is identical to arch/arm/dts/imx28-wink-hub-v1.dtb.
$ diff dts/dt.dtb arch/arm/dts/imx28-wink-hub-v1.dtb
$ grep -i wink .config
CONFIG_DEFAULT_DEVICE_TREE=3D"imx28-wink-hub-v1"
CONFIG_OF_LIST=3D"imx28-wink-hub-v1"

diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
b/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
index a94803ee93..f4d6cac878 100644
--- a/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
+++ b/arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c
@@ -29,7 +29,7 @@ __weak uint32_t mxs_dram_vals[] =3D {
  0x00000000, 0x00000100, 0x00000000, 0x00000000,
  0x00000000, 0x00000000, 0x00000000, 0x00000000,
  0x00000000, 0x00000000, 0x00010101, 0x01010101,
- 0x000f0f01, 0x0f02020a, 0x00000000, 0x00010101,
+ 0x000f0f01, 0x0f02020a, 0x00000000, 0x00000101,
  0x00000100, 0x00000100, 0x00000000, 0x00000002,
  0x01010000, 0x07080403, 0x06005003, 0x0a0000c8,
  0x02009c40, 0x0002030c, 0x0036a609, 0x031a0612,
diff --git a/arch/arm/dts/imx28-wink-hub-v1.dts
b/arch/arm/dts/imx28-wink-hub-v1.dts
new file mode 100644
index 0000000000..b0bddebce8
--- /dev/null
+++ b/arch/arm/dts/imx28-wink-hub-v1.dts
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2023 Fabio Estevam <festevam@gmail.com>
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28.dtsi"
+/ {
+ model =3D "i.MX28 Wink Hub v1";
+ compatible =3D "wink,imx28-wink-hub-v1", "fsl,imx28";
+
+ memory@40000000 {
+ device_type =3D "memory";
+ reg =3D <0x40000000 0>; /* will be filled in by U-Boot */
+ };
+
+ reg_wifi: regulator-wifi {
+ compatible =3D "regulator-fixed";
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&wifi_enable>;
+ regulator-name =3D "wifi";
+ regulator-min-microvolt =3D <3300000>;
+ regulator-max-microvolt =3D <3300000>;
+ gpio =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
+ enable-active-high;
+ };
+
+ pwmleds {
+ compatible =3D "pwm-leds";
+
+ led-red {
+ label =3D "red";
+ max-brightness =3D <255>;
+ pwms =3D <&pwm 0 500000>;
+ };
+
+ led-green {
+ label =3D "green";
+ max-brightness =3D <255>;
+ pwms =3D <&pwm 1 500000>;
+ };
+
+ led-blue {
+ label =3D "blue";
+ max-brightness =3D <255>;
+ pwms =3D <&pwm 3 500000>;
+ };
+ };
+};
+
+&auart0 {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&auart0_pins_a>;
+ uart-has-rtscts;
+ status =3D "okay";
+};
+
+&auart1 {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&auart1_2pins_a>;
+ status =3D "okay";
+};
+
+&auart2 {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&auart2_2pins_a>;
+ status =3D "okay";
+};
+
+&auart3 {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&auart3_2pins_a>;
+ status =3D "okay";
+};
+
+&auart4 {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&auart4_pins_a>;
+ uart-has-rtscts;
+ status =3D "okay";
+};
+
+&duart {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&duart_pins_c>;
+ status =3D "okay";
+};
+
+&gpmi {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&gpmi_pins_a &gpmi_pins_extra>;
+ status =3D "okay";
+
+ partition@0 {
+ label =3D "gpmi-nfc-0-boot";
+ reg =3D <0x0000000 0x300000>;
+ read-only;
+        };
+
+ partition@300000 {
+ label =3D "updater-kernel";
+ reg =3D <0x0300000 0x400000>;
+ };
+
+ partition@700000 {
+ label =3D "updater-rootfs";
+ reg =3D <0x0700000 0x1c00000>;
+        };
+
+ partition@2300000 {
+ label =3D "database";
+ reg =3D <0x2300000 0x0800000>;
+ };
+
+ partition@2b00000 {
+ label =3D "app-kernel";
+ reg =3D <0x2b00000 0x0800000>;
+        };
+
+ partition@3300000 {
+ label =3D "gpmi-nfc-general-use";
+ reg =3D <0x3300000 0x4d00000>;
+        };
+};
+
+&pwm {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&pwm0_pins_a &pwm1_pins_a &pwm3_pins_a>;
+ status =3D "okay";
+};
+
+&ssp0 {
+ compatible =3D "fsl,imx28-mmc";
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&mmc0_4bit_pins_a &mmc0_sck_cfg>;
+ vmmc-supply =3D <&reg_wifi>;
+ bus-width =3D <4>;
+ status =3D "okay";
+};
+
+&ssp3 {
+ compatible =3D "fsl,imx28-spi";
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&spi3_pins_b>;
+ status =3D "okay";
+
+ spidev@0 {
+ /* Generic compatible to make spidev happy */
+ compatible =3D "rohm,dh2228fv";
+ reg =3D <0>;
+ spi-max-frequency =3D <24000000>;
+ };
+};
+
+&usb0 {
+ dr_mode =3D "peripheral";
+ status =3D "okay";
+};
+
+&usbphy0  {
+ status =3D "okay";
+};
+
+&pinctrl {
+ pinctrl-names =3D "default";
+ pinctrl-0 =3D <&hog_pins_a>;
+
+ hog_pins_a: hog@0 {
+ reg =3D <0>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_LCD_D07__GPIO_1_7 /*  Z-Wave reset connection high output */
+ MX28_PAD_LCD_D08__GPIO_1_8 /* Lutron Clear-Connect button  */
+ MX28_PAD_LCD_D09__GPIO_1_9 /*  Zigbee reset */
+ MX28_PAD_LCD_D10__GPIO_1_10 /* Lutron reset */
+ MX28_PAD_LCD_D12__GPIO_1_12 /* Input Zigbee interrupt */
+ MX28_PAD_LCD_D14__GPIO_1_14 /*  BT  power down */
+ MX28_PAD_LCD_D15__GPIO_1_15 /* Kidde Reset */
+ MX28_PAD_LCD_D16__GPIO_1_16 /* Kidde Data */
+ MX28_PAD_LCD_D19__GPIO_1_19 /* Kidde RF Clock */
+ MX28_PAD_LCD_D20__GPIO_1_20 /* Kidde GPIO */
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+
+ gpmi_pins_extra: gpmi-pins-extra@0 {
+ reg =3D <0>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_GPMI_CE1N__GPMI_CE1N
+ MX28_PAD_GPMI_RDY1__GPMI_READY1
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+
+ wifi_enable: wifi-enable@1 {
+ reg =3D <1>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_LCD_D13__GPIO_1_13
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+};
diff --git a/arch/arm/dts/imx28.dtsi b/arch/arm/dts/imx28.dtsi
index 130b4145af..b4e2c8ec05 100644
--- a/arch/arm/dts/imx28.dtsi
+++ b/arch/arm/dts/imx28.dtsi
@@ -239,6 +239,17 @@
  fsl,pull-up =3D <MXS_PULL_DISABLE>;
  };

+ duart_pins_c: duart@2 {
+ reg =3D <2>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_I2C0_SCL__DUART_RX
+ MX28_PAD_I2C0_SDA__DUART_TX
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_8mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+
  duart_4pins_a: duart-4pins@0 {
  reg =3D <0>;
  fsl,pinmux-ids =3D <
@@ -404,6 +415,20 @@
  fsl,pull-up =3D <MXS_PULL_DISABLE>;
  };

+ auart4_pins_a: auart4-4pins@0 {
+ reg =3D <0>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_SAIF0_BITCLK__AUART4_RX
+ MX28_PAD_SAIF0_SDATA0__AUART4_TX
+ MX28_PAD_SAIF0_MCLK__AUART4_CTS
+ MX28_PAD_SAIF0_LRCLK__AUART4_RTS
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+
+
  auart4_2pins_a: auart4@0 {
  reg =3D <0>;
  fsl,pinmux-ids =3D <
@@ -719,6 +744,16 @@
  fsl,pull-up =3D <MXS_PULL_DISABLE>;
  };

+ pwm1_pins_a: pwm1@0 {
+ reg =3D <0>;
+ fsl,pinmux-ids =3D <
+ MX28_PAD_PWM1__PWM_1
+ >;
+ fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+ fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+ fsl,pull-up =3D <MXS_PULL_DISABLE>;
+ };
+
  pwm2_pins_a: pwm2@0 {
  reg =3D <0>;
  fsl,pinmux-ids =3D <
diff --git a/board/freescale/mx28evk/iomux.c
b/board/freescale/mx28evk/iomux.c
index cc0c858854..1e9ba07f8f 100644
--- a/board/freescale/mx28evk/iomux.c
+++ b/board/freescale/mx28evk/iomux.c
@@ -22,8 +22,8 @@

 const iomux_cfg_t iomux_setup[] =3D {
  /* DUART */
- MX28_PAD_PWM0__DUART_RX,
- MX28_PAD_PWM1__DUART_TX,
+ MX28_PAD_I2C0_SCL__DUART_RX,
+ MX28_PAD_I2C0_SDA__DUART_TX,

  /* MMC0 */
  MX28_PAD_SSP0_DATA0__SSP0_D0 | MUX_CONFIG_SSP0,

On Mon, 25 Sept 2023 at 01:38, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Rogan,
>
> On Sun, Sep 24, 2023 at 5:16=E2=80=AFPM Rogan Dawes <rogan@dawes.za.net> =
wrote:
> >
> > Hi folks,
> >
> > I eventually decided that I did need to figure out the DRAM timings for
> the Micron chip on my board, but I found an easier way than actually
> "understanding what I'm doing"! :-)
> >
> > I pulled the vendor U-Boot image off the flash, skipped the appropriate
> number of bytes until I was actually dealing with a u-boot.sb formatted
> image (looking for the STMP signature I found in the compiled mainline
> u-boot), then used the Rockbox project's sbtoelf tool to convert the SB
> back to two ELF files, the SPL.elf and the u-boot.elf. From there I loade=
d
> the SPL.elf into ghidra, then went looking for byte sequences found in
> arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c to see if I could locate them i=
n
> the vendor blob. I did, right at the end of the binary, then converted
> bytes into uint32 sequences so that I could compare with the mxs_dram_val=
s
> for CONFIG_MX28.
> >
> > Did the compare and found a single bit that is different between the tw=
o
> sequences of initialisation values. Literally a 1 to a 0, and that is all=
.
> So I built mainline with that change, and an updated iomux_setup because
> the Wink Hub v1 uses MX28_PAD_I2C0_SCL__DUART_RX and
> MX28_PAD_I2C0_SDA__DUART_TX for its console pins. i was hoping to see it
> boot via mxsldr, but unfortunately, I got nothing.
>
> Ideally, you should create a new imx28-wink_defconfig.
>
> For a quick test, besides changing iomux_setup, please make sure that
> arch/arm/dts/imx28-evk.dts also has the duart pins changed.
>
> > How can I get the SPL to emit something on the console to confirm it is
> running? i.e. before the DRAM initialisation?
>
> SPL runs from the internal RAM, and should print something to the
> console prior to the DRAM init.
>
