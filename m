Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C2C25B7D
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 10:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB50882A2;
	Mon, 27 May 2024 12:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pxq+UdGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D57881EC; Mon, 27 May 2024 12:47:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663F988176
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 12:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matthias.bgg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1DB49614EA;
 Mon, 27 May 2024 10:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E8C2BBFC;
 Mon, 27 May 2024 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716806865;
 bh=pZiBeYwTq/I72iAmYuVEtH4962fAZDJeqWawOF3lkEQ=;
 h=From:To:Cc:Subject:Date:From;
 b=pxq+UdGb8DtS9F8i3Zn+UK7a5HKgY7HU6t1RPkW/QXfObfwQ2B+wcylFKSfWLWoEP
 8H7bLOlI2nNarE6m3FM+R7quAU2ak89ryL5l9LW9fgEem1s5x7X7AamwAoU+t2OlTx
 +y0eZpvn80Tvrm8F5GCoB4H8GzA8VJ1Aeh1h7PFt+hec2mlSuyaAGfwIVPPQkzk9/v
 p8knbtDYTl39vEgyitX7jEAzM9eaDUs7Cb0Bbh/wYfM1o7O9xJQlfmu0t1adwTOnhs
 iauJaYTOwvzXlZXaHtZ0WKeDS0vxD+tK20QK42bpyw4SutfpLtyoEsotYjLsJkGMhl
 +KZnnMlhOIR8A==
From: matthias.bgg@kernel.org
To: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 minda.chen@starfivetech.com, heinrich.schuchardt@canonical.com
Cc: jh80.chung@samsung.com, xingyu.wu@starfivetech.com, u-boot@lists.denx.de,
 mason.huo@starfivetech.com, duwe@suse.de, hal.feng@starfivetech.com,
 yanhong.wang@starfivetech.com, Matthias Brugger <mbrugger@suse.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Nam Cao <namcao@linutronix.de>
Subject: [PATCH] riscv: dts: jh7110: Update qspi node with upstream
Date: Mon, 27 May 2024 12:47:10 +0200
Message-ID: <20240527104730.20244-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Matthias Brugger <mbrugger@suse.com>

Upstream node uses a specific SoC compatible to make the kernel driver
work. Copy over the upstream node to fullfill that need.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

 .../jh7110-starfive-visionfive-2-u-boot.dtsi  |  2 +-
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 29 ++++++++++++++++---
 arch/riscv/dts/jh7110.dtsi                    | 19 +++++++-----
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
index 3012466b305..a69d8fcb391 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
@@ -40,7 +40,7 @@
 &qspi {
 	bootph-pre-ram;
 
-	nor-flash@0 {
+	nor_flash@0 {
 		bootph-pre-ram;
 	};
 };
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
index e11babc1cde..375449b73a8 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -305,17 +305,38 @@
 };
 
 &qspi {
-	spi-max-frequency = <250000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
-	nor-flash@0 {
+	nor_flash: nor_flash@0 {
 		compatible = "jedec,spi-nor";
-		reg=<0>;
-		spi-max-frequency = <100000000>;
+		reg = <0>;
+		cdns,read-delay = <5>;
+		spi-max-frequency = <12000000>;
 		cdns,tshsl-ns = <1>;
 		cdns,tsd2d-ns = <1>;
 		cdns,tchsh-ns = <1>;
 		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0x80000>;
+			};
+			uboot-env@f0000 {
+				reg = <0xf0000 0x10000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0x400000>;
+			};
+			reserved-data@600000 {
+				reg = <0x600000 0xa00000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 2cdc683d49b..2b331e58497 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -480,19 +480,22 @@
 		};
 
 		qspi: spi@13010000 {
-			compatible = "cdns,qspi-nor";
-			reg = <0x0 0x13010000 0x0 0x10000
-				0x0 0x21000000 0x0 0x400000>;
-			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>;
-			clock-names = "clk_ref";
+			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
+			reg = <0x0 0x13010000 0x0 0x10000>,
+			      <0x0 0x21000000 0x0 0x400000>;
+			interrupts = <25>;
+			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
+				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
+				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
+			clock-names = "ref", "ahb", "apb";
 			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
 				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
 				 <&syscrg JH7110_SYSRST_QSPI_REF>;
-			reset-names = "rst_apb", "rst_ahb", "rst_ref";
+			reset-names = "qspi", "qspi-ocp", "rstc_ref";
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			cdns,trigger-address = <0x0>;
+			status = "disabled";
 		};
 
 		syscrg: clock-controller@13020000 {
-- 
2.44.0

