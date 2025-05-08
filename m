Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F1CC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944DB82AE1;
	Thu,  8 May 2025 23:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="HaY+RnuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532BE829E4; Thu,  8 May 2025 23:24:42 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6AE82AEF
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739479; x=1746998679;
 bh=lhUMxk1sNliFMlOF1/0nNj+ePKINIfIGmGY7wq1QDRs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=HaY+RnuF/Qx7zYYyUb8mEmA6jZONtgW08JY/vbkXsZwdS+5+YBG33q/jB+mZfaK7D
 /w7YbX5qw7pWshBnfEGw07fjy6/ydcJ28iTEDc5GQ69j7rCMr9b4dYkP3e9So1chf8
 tk8rSbR7EK4sndvszEuLVfE9s6RJRXo/XmD8gmza4z5+M/j2Ex1dk/Iq2dlOQk96He
 hnVae0vDE0sh1zPOBbosMqU9ZHiEh3ZLCcRO/Hf6XkcESE7rEm36Hr9YYA6/3Atjq4
 1yOWBAjNEcLo1BgpmCyiJA2v40MBPcgMpHlwXDk+WeUsxG8oaDrZ+dB75LZnc5jh/6
 FCBkDMATVLItA==
Date: Thu, 08 May 2025 21:24:35 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 09/10] dts: upstream: arm: st: add STM32H747 discovery board
Message-ID: <20250508212058.640483-10-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 28e1597afcda8ccdf214d3730cddf50e7e61ed48
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

Add initial device tree for the STM32H747 discovery board.
Copied from the STM32H743 discovery board and modified for
the STM32H747 discovery board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 dts/upstream/src/arm/st/stm32h747i-disco.dts | 115 +++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts

diff --git a/dts/upstream/src/arm/st/stm32h747i-disco.dts b/dts/upstream/sr=
c/arm/st/stm32h747i-disco.dts
new file mode 100644
index 00000000000..2a4398bf897
--- /dev/null
+++ b/dts/upstream/src/arm/st/stm32h747i-disco.dts
@@ -0,0 +1,115 @@
+/*
+ * Copied from the STM32H743 discovery board and modified for
+ * the STM32H747 discovery board.
+ *
+ * Original author and license:
+ * Copyright 2017 - Patrice Chotard <patrice.chotard@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "stm32h743.dtsi"
+#include "stm32h7-pinctrl.dtsi"
+
+/ {
+=09model =3D "STMicroelectronics STM32H747i-Discovery board";
+=09compatible =3D "st,stm32h747i-disco", "st,stm32h747";
+
+=09chosen {
+=09=09bootargs =3D "root=3D/dev/ram";
+=09=09stdout-path =3D "serial0:115200n8";
+=09};
+
+=09memory@d0000000 {
+=09=09device_type =3D "memory";
+=09=09reg =3D <0xd0000000 0x2000000>;
+=09};
+
+=09aliases {
+=09=09serial0 =3D &usart1;
+=09};
+
+=09v3v3: regulator-v3v3 {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "v3v3";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09=09regulator-always-on;
+=09};
+};
+
+&clk_hse {
+=09clock-frequency =3D <25000000>;
+};
+
+&mac {
+=09status =3D "disabled";
+=09pinctrl-0 =3D <&ethernet_rmii>;
+=09pinctrl-names =3D "default";
+=09phy-mode =3D "rmii";
+=09phy-handle =3D <&phy0>;
+
+=09mdio0 {
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09compatible =3D "snps,dwmac-mdio";
+=09=09phy0: ethernet-phy@0 {
+=09=09=09reg =3D <0>;
+=09=09};
+=09};
+};
+
+&sdmmc1 {
+=09pinctrl-names =3D "default", "opendrain", "sleep";
+=09pinctrl-0 =3D <&sdmmc1_b4_pins_a>;
+=09pinctrl-1 =3D <&sdmmc1_b4_od_pins_a>;
+=09pinctrl-2 =3D <&sdmmc1_b4_sleep_pins_a>;
+=09broken-cd;
+=09st,neg-edge;
+=09bus-width =3D <4>;
+=09vmmc-supply =3D <&v3v3>;
+=09status =3D "okay";
+};
+
+&usart1 {
+=09pinctrl-0 =3D <&usart1_pins>;
+=09pinctrl-names =3D "default";
+=09status =3D "okay";
+};
--=20
2.39.5


