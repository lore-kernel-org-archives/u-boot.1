Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E2EC4451B
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 22:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2764C84AC0;
	Mon, 20 Jul 2026 00:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="m8q/wsAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813B484AD3; Mon, 20 Jul 2026 00:02:44 +0200 (CEST)
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C60C84A9E
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1784498561; x=1784757761;
 bh=du/eoW9yFWdLLYMd4KZ0jyQfPDEo9jxkB9CYaD51+mg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=m8q/wsAfbj3XO0fCCTkSKJkQKBFyt+CJALuxcABBJagnlhW9oekfv/0VlfHJqEbVh
 Zd4dacY0Gak6eCyb2vfSXu89RA3mphckO58rj81Tfb0EUaXIhBWJSi/el1amylI/BL
 tfczKE0rjnnNv0/Ii95ARMTORAJvkfcynT1lx/z3VQpNHLgdO2lp24OpVslM4tfQnb
 +7Dh8ge4tQyMOaMef8f6DWkY8ZWO3FZEWv9ydWzlhKt24bHOhctLQ0uoSNRnOLWUmT
 BCWbrEHoGRK/SBOcGBxo2KwrFrQjV/0L5aeEeJp+NmbpY/E+3Od/jvdWJF3GM2Cw+1
 V67j3l4jWUKsQ==
Date: Sun, 19 Jul 2026 22:02:29 +0000
To: u-boot@lists.denx.de
From: anoduck <anoduck@protonmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 anoduck <anoduck@protonmail.com>
Subject: [PATCH RFC PineTab-V DTS File v2 1/2] RFC: Pine64 Pinetab-V dts
 Device Tree File
Message-ID: <20260719-develop-v2-1-91fdc4cd60a2@protonmail.com>
In-Reply-To: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
References: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: 9b756e8bf7bfda3b658d25e3d51311516f20f338
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Added compilable PineTab-V device-tree dts file derived from pine64 communi=
ty distributed dts and additional parameters
Community provided definitions:
    - Audio Codec
    - Accelerometer

Additional parameters include:
    - Definitions for sd-card and on board EMMC devices
    - Definitins for power supply to sd-card

Signed-off-by: The Anoduck <anoduck@protonmail.com>
---
 .../src/riscv/starfive/jh7110-pine64-pinetabv.dts  | 174 ++++++++++-------=
----
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts b/d=
ts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
index 07241c75fc2..dd04d9be5a0 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
+++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
@@ -8,44 +8,44 @@
 #include "jh7110-common.dtsi"
=20
 / {
-    compatible =3D "pine64,pinetabv", "starfive,jh7110";
+=09compatible =3D "pine64,pinetabv", "starfive,jh7110";
 =09model =3D "Pine64 PinetabV";
=20
 =09soc {
-    =09i2c@10030000 {
-    =09=09compatible =3D "snps,designware-i2c";
-    =09=09reg =3D <0x00 0x10030000 0x00 0x10000>;
-    =09=09clocks =3D <0x03 0x8a>;
-    =09=09clock-names =3D "ref";
-    =09=09resets =3D <0x03 0x4c>;
-    =09=09interrupts =3D <0x23>;
-    =09=09#address-cells =3D <0x01>;
-    =09=09#size-cells =3D <0x00>;
-    =09=09status =3D "okay";
-    =09=09clock-frequency =3D <0x186a0>;
-    =09=09i2c-sda-hold-time-ns =3D <0x12c>;
-    =09=09i2c-sda-falling-time-ns =3D <0x1fe>;
-    =09=09i2c-scl-falling-time-ns =3D <0x1fe>;
-    =09=09pinctrl-names =3D "default";
-    =09=09pinctrl-0 =3D <0x17>;
+=09=09i2c@10030000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x10030000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8a>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x4c>;
+=09=09=09interrupts =3D <0x23>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "okay";
+=09=09=09clock-frequency =3D <0x186a0>;
+=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
+=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x17>;
=20
-    =09=09audio-codec@11 {
-    =09=09=09compatible =3D "everest,es8316";
-    =09=09=09reg =3D <0x11>;
-    =09=09=09clocks =3D <0x18>;
-    =09=09=09clock-names =3D "mclk";
-    =09=09=09#sound-dai-cells =3D <0x00>;
-    =09=09=09papower-gpio =3D <0x19 0x32 0x00>;
-    =09=09=09hp-det-gpio =3D <0x19 0x24 0x00>;
-    =09=09=09phandle =3D <0x64>;
-    =09=09};
+=09=09=09audio-codec@11 {
+=09=09=09=09compatible =3D "everest,es8316";
+=09=09=09=09reg =3D <0x11>;
+=09=09=09=09clocks =3D <0x18>;
+=09=09=09=09clock-names =3D "mclk";
+=09=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09=09papower-gpio =3D <0x19 0x32 0x00>;
+=09=09=09=09hp-det-gpio =3D <0x19 0x24 0x00>;
+=09=09=09=09phandle =3D <0x64>;
+=09=09=09};
=20
-    =09=09accelerometer@18 {
-    =09=09=09compatible =3D "silan,sc7a20";
-    =09=09=09reg =3D <0x18>;
-    =09=09=09mount-matrix =3D "0", "0", "-1", "1", "0", "0", "0", "-1", "0=
";
-    =09=09};
-    =09};
+=09=09=09accelerometer@18 {
+=09=09=09=09compatible =3D "silan,sc7a20";
+=09=09=09=09reg =3D <0x18>;
+=09=09=09=09mount-matrix =3D "0", "0", "-1", "1", "0", "0", "0", "-1", "0"=
;
+=09=09=09};
+=09=09};
 =09sd_vcc: sd-vcc {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "sd_vcc";
@@ -57,59 +57,59 @@
 =09=09regulator-always-on;
 =09};
=20
-    =09mmc@16010000 {
-    =09=09compatible =3D "starfive,jh7110-mmc";
-    =09=09reg =3D <0x00 0x16010000 0x00 0x10000>;
-    =09=09clocks =3D <0x03 0x5b 0x03 0x5d>;
-    =09=09clock-names =3D "biu", "ciu";
-    =09=09resets =3D <0x03 0x40>;
-    =09=09reset-names =3D "reset";
-    =09=09interrupts =3D <0x4a>;
-    =09=09fifo-depth =3D <0x20>;
-    =09=09fifo-watermark-aligned;
-    =09=09data-addr =3D <0x00>;
-    =09=09starfive,sysreg =3D <0x1f 0x14 0x1a 0x7c000000>;
-    =09=09status =3D "okay";
-    =09=09max-frequency =3D <0x5f5e100>;
-    =09=09assigned-clocks =3D <0x03 0x5d>;
-    =09=09vmmc-supply =3D <&sd_vcc>;
-    =09=09assigned-clock-rates =3D <0x2faf080>;
-    =09=09bus-width =3D <0x08>;
-    =09=09cap-mmc-highspeed;
-    =09=09mmc-ddr-1_8v;
-    =09=09mmc-hs200-1_8v;
-    =09=09non-removable;
-    =09=09cap-mmc-hw-reset;
-    =09=09post-power-on-delay-ms =3D <0xc8>;
-    =09=09pinctrl-names =3D "default";
-    =09=09pinctrl-0 =3D <0x3c>;
-    =09=09vqmmc-supply =3D <&sd_vcc>;
-    =09};
+=09=09mmc@16010000 {
+=09=09=09compatible =3D "starfive,jh7110-mmc";
+=09=09=09reg =3D <0x00 0x16010000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x5b 0x03 0x5d>;
+=09=09=09clock-names =3D "biu", "ciu";
+=09=09=09resets =3D <0x03 0x40>;
+=09=09=09reset-names =3D "reset";
+=09=09=09interrupts =3D <0x4a>;
+=09=09=09fifo-depth =3D <0x20>;
+=09=09=09fifo-watermark-aligned;
+=09=09=09data-addr =3D <0x00>;
+=09=09=09starfive,sysreg =3D <0x1f 0x14 0x1a 0x7c000000>;
+=09=09=09status =3D "okay";
+=09=09=09max-frequency =3D <0x5f5e100>;
+=09=09=09assigned-clocks =3D <0x03 0x5d>;
+=09=09=09vmmc-supply =3D <&sd_vcc>;
+=09=09=09assigned-clock-rates =3D <0x2faf080>;
+=09=09=09bus-width =3D <0x08>;
+=09=09=09cap-mmc-highspeed;
+=09=09=09mmc-ddr-1_8v;
+=09=09=09mmc-hs200-1_8v;
+=09=09=09non-removable;
+=09=09=09cap-mmc-hw-reset;
+=09=09=09post-power-on-delay-ms =3D <0xc8>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x3c>;
+=09=09=09vqmmc-supply =3D <&sd_vcc>;
+=09=09};
=20
-    =09mmc@16020000 {
-    =09=09compatible =3D "starfive,jh7110-mmc";
-    =09=09reg =3D <0x00 0x16020000 0x00 0x10000>;
-    =09=09clocks =3D <0x03 0x5c 0x03 0x5e>;
-    =09=09clock-names =3D "biu", "ciu";
-    =09=09resets =3D <0x03 0x41>;
-    =09=09reset-names =3D "reset";
-    =09=09interrupts =3D <0x4b>;
-    =09=09fifo-depth =3D <0x20>;
-    =09=09fifo-watermark-aligned;
-    =09=09data-addr =3D <0x00>;
-    =09=09starfive,sysreg =3D <0x1f 0x9c 0x01 0x3e>;
-    =09=09status =3D "okay";
-    =09=09max-frequency =3D <0x5f5e100>;
-    =09=09assigned-clocks =3D <0x03 0x5e>;
-    =09=09assigned-clock-rates =3D <0x2faf080>;
-    =09=09bus-width =3D <0x04>;
-    =09=09no-sdio;
-    =09=09no-mmc;
-    =09=09cd-gpios =3D <0x19 0x29 0x01>;
-    =09=09cap-sd-highspeed;
-    =09=09post-power-on-delay-ms =3D <0xc8>;
-    =09=09pinctrl-names =3D "default";
-    =09=09pinctrl-0 =3D <0x3e>;
-    =09};
-    };
+=09=09mmc@16020000 {
+=09=09=09compatible =3D "starfive,jh7110-mmc";
+=09=09=09reg =3D <0x00 0x16020000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x5c 0x03 0x5e>;
+=09=09=09clock-names =3D "biu", "ciu";
+=09=09=09resets =3D <0x03 0x41>;
+=09=09=09reset-names =3D "reset";
+=09=09=09interrupts =3D <0x4b>;
+=09=09=09fifo-depth =3D <0x20>;
+=09=09=09fifo-watermark-aligned;
+=09=09=09data-addr =3D <0x00>;
+=09=09=09starfive,sysreg =3D <0x1f 0x9c 0x01 0x3e>;
+=09=09=09status =3D "okay";
+=09=09=09max-frequency =3D <0x5f5e100>;
+=09=09=09assigned-clocks =3D <0x03 0x5e>;
+=09=09=09assigned-clock-rates =3D <0x2faf080>;
+=09=09=09bus-width =3D <0x04>;
+=09=09=09no-sdio;
+=09=09=09no-mmc;
+=09=09=09cd-gpios =3D <0x19 0x29 0x01>;
+=09=09=09cap-sd-highspeed;
+=09=09=09post-power-on-delay-ms =3D <0xc8>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x3e>;
+=09=09};
+=09};
 };

--=20
2.53.0


