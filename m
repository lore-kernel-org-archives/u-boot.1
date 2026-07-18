Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A110BC4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 08:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDDC80117;
	Sat, 18 Jul 2026 10:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="kAhMvFKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ECF480287; Sat, 18 Jul 2026 10:10:49 +0200 (CEST)
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EA580087
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 10:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1784362246; x=1784621446;
 bh=1jW1n1ul4gHBsq7U7fqJBOqZ7xk9sNR0mJgddesY3u4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kAhMvFKNfZwdTtjtXDcUhDxcLQNCSQPfROJeGNpxSifq9mtmUyssL+gXiBIa1IUHl
 GQZVInrN6uVUkJiTr11TebhPxFDsQxcy7VmyozRfPpPLi9GbfYeUM0PIFkOPr4enjJ
 NTLa80/f+K2QA19ORN/NYKrercESxpHABP1UwZxfH8wJYeCwDPmJXBA1WYuza4ADow
 Mc6WylKgo+5mgdVkZ5wi3cyjvVtT0oFArTMxDRorP3uy8nsmgJavFhuQoLGe7uuU7R
 mK9coIlkfD8VdCuxqq1MYuYp/8C181Iw0VYMTRHf2U+d76a0Rhhfh+rLexGCtI5ajH
 vv82Bebl2uMCw==
Date: Sat, 18 Jul 2026 08:10:38 +0000
To: u-boot@lists.denx.de
From: anoduck <anoduck@protonmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 anoduck <anoduck@protonmail.com>
Subject: [PATCH RFC PineTab-V DTS File] RFC: Pine64 Pinetab-V dts Device Tree
 File
Message-ID: <20260718-develop-v1-1-d4b5c0675f87@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: 245398de1232b67226d0bd79ac3d626c678c4476
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
Provide support for the Pine64 Pinetab-V Risc-V 64bit Tablet

Signed-off-by: anoduck <anoduck@protonmail.com>
---
 .../src/riscv/starfive/jh7110-pine64-pinetabv.dts  | 116 +++++++++++++++++=
++++
 1 file changed, 116 insertions(+)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts b/d=
ts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
new file mode 100644
index 00000000000..1115b0be4cc
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
+ * Through the Graces of: E Shattow <e@freeshell.de>
+ * REV-DATE: July 18, 2026
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+=09compatible =3D "pine64,pinetabv", "starfive,jh7110";
+=09model =3D "Pine64 PinetabV";
+
+=09soc {
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
+
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
+
+=09=09=09accelerometer@18 {
+=09=09=09=09compatible =3D "silan,sc7a20";
+=09=09=09=09reg =3D <0x18>;
+=09=09=09=09mount-matrix =3D "0", "0", "-1", "1", "0", "0", "0", "-1", "0"=
;
+=09=09=09};
+=09=09};
+=09sd_vcc: sd-vcc {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "sd_vcc";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09=09gpio =3D <0x19 0x23 0x00>;
+=09=09enable-active-low;
+=09=09regulator-boot-on;
+=09=09regulator-always-on;
+=09};
+
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
+
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
+};

---
base-commit: 605d72111224172381a2a94d734183222d5b8952
change-id: 20260718-develop-1e9fbc9b4fe0

Best regards,
--=20
anoduck <anoduck@protonmail.com>


