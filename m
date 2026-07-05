Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50514C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 13:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84C98490A;
	Sun,  5 Jul 2026 15:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TL87gnAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6729484942; Sun,  5 Jul 2026 15:07:42 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9708846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 15:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ca70925c25so25446805ad.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783256858; x=1783861658;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WxyWaTtemX3Tr2w4JycOOHGI3BlxkU0pxeZFlkvJWNU=;
 b=TL87gnAA3QEDm5Jhh3iLkvR01Uxoe8vWzsKZh2x5zSG/qhaFAXKN5ZmhTuwnkcIXTH
 FJWXqBzdsKmrYv4SOmk64lAhmIESOsAurVxn+cKNuSPdykn99HJuUM5z2HmgbndIYGZb
 QRnAjfEGmHOTJRi7jwPfPUGfr2sFIH1KD+ssyyoXFY+JmgnoCsLZmdGESLNHfPx+fYw1
 EcfSvpaRjnn0DhV+hKPNXgdTWB/LOHc21quwl+BEQW0fGuVzXPutJmvIsNhUX5iaVbrb
 v0x9Ug6ZSRKEu9OuK04fh8hal5ZZaHtar0wgdkFHXV6KqUaRm8DRD1k7HGiWt2n3djeD
 /9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783256858; x=1783861658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxyWaTtemX3Tr2w4JycOOHGI3BlxkU0pxeZFlkvJWNU=;
 b=hHBr6Yo2i0Ttd8JRO2wa+pL+yUU/+l3Gmy7B0zUMq0Fv2sq1xaBBPJJXdQ/2oyK9FE
 36ORzIxhaK8ZqIf2UHJuPTM0l67pkz/QxXCxkBq2lwWo5ZfKQVO4YGkdEtGWrzdZ7gUB
 BWY5bzKSpYNu+Yehfbtuxwe0ePvfx3DO0hs6bxTcuoXD1INRpYJo5EutYnVUYkdpTMRI
 LLXWhMhLL7lW1P0gm1ogjnsHuJlt5mb3Qip4I7nYbb/peycDcucRWtD0SyD50stJeK24
 29P+p35vlc2i92NSq4UX0alfnG5FOKvGaaCZDtmWvJuXY26sBohFaJ2lRb6yjC7yP0AC
 oMig==
X-Gm-Message-State: AOJu0Yw2br4Ybze3dw/so8DV0CzrSQ/ynLbxgA4AkVGFoSBGlzHF+d28
 GkUfbW80WmX22d5Bg291zXza+8W8l9WPCjkhEYXTt9e5KIxjdHd46CM/xpqSVHyd+sY=
X-Gm-Gg: AfdE7cm1eYWvu/DiFahf0Eumu8wo9xXCCAl5CdJ2A4EDPuSq8f5OgBO96dJfuEHwx4m
 sU3ybN6MJvkFCadi6u4h42gMptdJXPnxpXAYfFO9o8YJoH+PgGKCOW99Q4kTfvMWV8xnQlHZMCK
 kTxSl+qajvK+FOsJu8vLV3vWnhrkcQhTcqtaBaS8MXuFpGu3WVklISn0r/3fCF1an/GOr+W5tx9
 kPrSdyKvH+0iBsSU7LFaLhGAkYqqX69UlGucTuuhUpHfG5bXpT1UrnaOba6WrFFJqzRQaCXp12j
 3XBN1COAQwjevp5APKBon96ZfvH1iXJmjRl8WYHRSXxXD4xY+ln/XZsOdX2XPiR43LfLZ9nu7fb
 kT87PJn9b5dtSsysM1Qo8dCqKFr2tq+zT6WX+JbG+Jy6lQsZgqaPJyCp6QA3TfDvcHkMoPm+A3/
 72arMOWDmR1o/lhZvDAJqCfdDj7MNHIN9A9Tis9rKkV4bH1EHjmRVVJxbxrpk4BpphdUmSN+4GV
 oP5+8RbWFH6cI5uVlcDzJxr6OGF0JoH7WWAf84NpzMaUkmg5cZW
X-Received: by 2002:a17:903:1b25:b0:2c9:c54a:7915 with SMTP id
 d9443c01a7336-2cbb75020a0mr57299815ad.14.1783256858372; 
 Sun, 05 Jul 2026 06:07:38 -0700 (PDT)
Received: from [127.0.1.1] ([120.204.57.249]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad71458f6sm34272305ad.32.2026.07.05.06.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 06:07:37 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 21:06:29 +0800
Subject: [PATCH 3/3] dts: spacemit: add PCIe nodes and enable in defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-pci-v1-3-beca83440a27@riscstar.com>
References: <20260705-pci-v1-0-beca83440a27@riscstar.com>
In-Reply-To: <20260705-pci-v1-0-beca83440a27@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alice Guo <alice.guo@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Ye Li <ye.li@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add PCIe controller, PHY and root port device tree nodes for
K1 SoC on Banana Pi F3 and MusePi Pro boards. Enable the
PCIe driver and NVMe support in spacemit_k1_defconfig.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 151 +++++++++++++++++++++++++++++
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 153 ++++++++++++++++++++++++++++++
 configs/spacemit_k1_defconfig             |   8 ++
 3 files changed, 312 insertions(+)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 582bd61d27c..d9370c58650 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
+#include <dt-bindings/phy/phy.h>
 #include "binman.dtsi"
 
 / {
@@ -98,6 +99,123 @@
 
 / {
 	soc {
+		pcie-bus {
+			pcie0: pcie@ca000000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca000000 0x0 0x00001000>,
+				      <0x0 0xca300000 0x0 0x0001ff24>,
+				      <0x0 0x8f000000 0x0 0x00002000>,
+				      <0x0 0xc0b20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0x8f002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0x80000000 0x0 0x80000000 0x0 0x0f000000>;
+				interrupts = <141>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+					 <&syscon_apmu CLK_PCIE0_MASTER>,
+					 <&syscon_apmu CLK_PCIE0_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE0_DBI>,
+					 <&syscon_apmu RESET_PCIE0_MASTER>,
+					 <&syscon_apmu RESET_PCIE0_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03cc>;
+				phys = <&combo_phy PHY_TYPE_PCIE>;
+				phy-names = "pcie-phy";
+				status = "disabled";
+
+				pcie0_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+
+			pcie1: pcie@ca400000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca400000 0x0 0x00001000>,
+				      <0x0 0xca700000 0x0 0x0001ff24>,
+				      <0x0 0x9f000000 0x0 0x00002000>,
+				      <0x0 0xc0c20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0x9f002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0x90000000 0x0 0x90000000 0x0 0x0f000000>;
+				interrupts = <142>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE1_DBI>,
+					 <&syscon_apmu CLK_PCIE1_MASTER>,
+					 <&syscon_apmu CLK_PCIE1_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE1_DBI>,
+					 <&syscon_apmu RESET_PCIE1_MASTER>,
+					 <&syscon_apmu RESET_PCIE1_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03d4>;
+				phys = <&pcie1_phy>;
+				phy-names = "pcie-phy";
+
+				pcie1_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+
+			pcie2: pcie@ca800000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca800000 0x0 0x00001000>,
+				      <0x0 0xcab00000 0x0 0x0001ff24>,
+				      <0x0 0xb7000000 0x0 0x00002000>,
+				      <0x0 0xc0d20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <2>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0xb7002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x17000000>;
+				interrupts = <143>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE2_DBI>,
+					 <&syscon_apmu CLK_PCIE2_MASTER>,
+					 <&syscon_apmu CLK_PCIE2_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE2_DBI>,
+					 <&syscon_apmu RESET_PCIE2_MASTER>,
+					 <&syscon_apmu RESET_PCIE2_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03dc>;
+				phys = <&pcie2_phy>;
+				phy-names = "pcie-phy";
+
+				pcie2_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+		};
+
 		storage-bus {
 			sdhci0: mmc@d4280000 {
 				bootph-pre-ram;
@@ -172,6 +290,39 @@
 	vmmc-supply = <&buck4_3v3>;
 };
 
+&combo_phy {
+	status = "okay";
+};
+
+&pcie1_phy {
+	/*
+	 * pinctrl must stay disabled on PHY nodes: the default pcie1_3_cfg
+	 * removes the pull-up on CLKREQ# (open-drain), leaving it floating
+	 * when the endpoint does not actively drive it low.  Without a valid
+	 * CLKREQ# the controller will not complete link training.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_3_cfg>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	/*
+	 * pinctrl must stay disabled on PHY nodes (see pcie1_phy above).
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_4_cfg>;
+	status = "okay";
+};
+
+&pcie1_port {
+	phys = <&pcie1_phy>;
+};
+
+&pcie2_port {
+	phys = <&pcie2_phy>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index ac67db13d7b..20fe71cdc40 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include <dt-bindings/phy/phy.h>
 #include "binman.dtsi"
 
 / {
@@ -253,6 +254,125 @@
 
 / {
 	soc {
+		pcie-bus {
+			pcie0: pcie@ca000000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca000000 0x0 0x00001000>,
+				      <0x0 0xca300000 0x0 0x0001ff24>,
+				      <0x0 0x8f000000 0x0 0x00002000>,
+				      <0x0 0xc0b20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0x8f002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0x80000000 0x0 0x80000000 0x0 0x0f000000>;
+				interrupts = <141>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+					 <&syscon_apmu CLK_PCIE0_MASTER>,
+					 <&syscon_apmu CLK_PCIE0_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE0_DBI>,
+					 <&syscon_apmu RESET_PCIE0_MASTER>,
+					 <&syscon_apmu RESET_PCIE0_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03cc>;
+				phys = <&combo_phy PHY_TYPE_PCIE>;
+				phy-names = "pcie-phy";
+				status = "disabled";
+
+				pcie0_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+
+			pcie1: pcie@ca400000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca400000 0x0 0x00001000>,
+				      <0x0 0xca700000 0x0 0x0001ff24>,
+				      <0x0 0x9f000000 0x0 0x00002000>,
+				      <0x0 0xc0c20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0x9f002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0x90000000 0x0 0x90000000 0x0 0x0f000000>;
+				interrupts = <142>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE1_DBI>,
+					 <&syscon_apmu CLK_PCIE1_MASTER>,
+					 <&syscon_apmu CLK_PCIE1_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE1_DBI>,
+					 <&syscon_apmu RESET_PCIE1_MASTER>,
+					 <&syscon_apmu RESET_PCIE1_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03d4>;
+				phys = <&pcie1_phy>;
+				phy-names = "pcie-phy";
+				status = "okay";
+
+				pcie1_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+
+			pcie2: pcie@ca800000 {
+				device_type = "pci";
+				compatible = "spacemit,k1-pcie";
+				reg = <0x0 0xca800000 0x0 0x00001000>,
+				      <0x0 0xcab00000 0x0 0x0001ff24>,
+				      <0x0 0xb7000000 0x0 0x00002000>,
+				      <0x0 0xc0d20000 0x0 0x00001000>;
+				reg-names = "dbi", "atu", "config", "link";
+				linux,pci-domain = <2>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0 0xb7002000 0x0 0x00100000>,
+					 <0x02000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x17000000>;
+				interrupts = <143>;
+				interrupt-names = "msi";
+				clocks = <&syscon_apmu CLK_PCIE2_DBI>,
+					 <&syscon_apmu CLK_PCIE2_MASTER>,
+					 <&syscon_apmu CLK_PCIE2_SLAVE>;
+				clock-names = "dbi", "mstr", "slv";
+				resets = <&syscon_apmu RESET_PCIE2_DBI>,
+					 <&syscon_apmu RESET_PCIE2_MASTER>,
+					 <&syscon_apmu RESET_PCIE2_SLAVE>;
+				reset-names = "dbi", "mstr", "slv";
+				spacemit,apmu = <&syscon_apmu 0x03dc>;
+				phys = <&pcie2_phy>;
+				phy-names = "pcie-phy";
+				status = "okay";
+
+				pcie2_port: pcie@0 {
+					device_type = "pci";
+					compatible = "pciclass,0604";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
+		};
+
 		storage-bus {
 			sdhci0: mmc@d4280000 {
 				bootph-pre-ram;
@@ -327,6 +447,39 @@
 	vmmc-supply = <&buck4_3v3>;
 };
 
+&combo_phy {
+	status = "okay";
+};
+
+&pcie1_phy {
+	/*
+	 * pinctrl must stay disabled on PHY nodes: the default pcie1_3_cfg
+	 * removes the pull-up on CLKREQ# (open-drain), leaving it floating
+	 * when the endpoint does not actively drive it low.  Without a valid
+	 * CLKREQ# the controller will not complete link training.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_3_cfg>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	/*
+	 * pinctrl must stay disabled on PHY nodes (see pcie1_phy above).
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_4_cfg>;
+	status = "okay";
+};
+
+&pcie1_port {
+	phys = <&pcie1_phy>;
+};
+
+&pcie2_port {
+	phys = <&pcie2_phy>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 1c92c4082a7..08f207c09bc 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -108,6 +108,14 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_EFI_PARTITION=y
+CONFIG_PCI=y
+CONFIG_CMD_PCI=y
+CONFIG_NVME=y
+CONFIG_NVME_PCI=y
+CONFIG_CMD_NVME=y
+CONFIG_PCIE_DW_SPACEMIT=y
+CONFIG_PHY=y
+CONFIG_PHY_SPACEMIT_K1_PCIE=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y

-- 
2.51.0

