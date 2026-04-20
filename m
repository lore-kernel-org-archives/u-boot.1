Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09CDEA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B87F83BC8;
	Mon, 20 Apr 2026 03:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h+E35Bt5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wRAFI28P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589A683FF5; Mon, 20 Apr 2026 03:22:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF7D80433
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fzSQD2dT0z9v5R;
 Mon, 20 Apr 2026 03:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4Jz1tVAPCgeJwUPzRYuLpt2wfO5hyZefTLfGBRJj+8=;
 b=h+E35Bt5e4Kcuw2UJGb9ala+DLCjU7k/ueuQ0UYmc707zE6Zo+l5VWur2Bv6ljDdLwKJF/
 OBuZOg5P5m6EJ2EP0IgLDqli438rYq+He6yJL20KleQsf8vjrF1N69J2oDm/ihT/jmVy/4
 xlP7jU0CVFSGwFXhrAG7xo3jwWpdBu4LsRU05zA1lQXXY/VlN3OxXm/A0UhKwHi2FMpI4q
 sKvIo/9znb6duOWOIgZngDQza+ih4izBDyd0PXxVk+DX0QB2enJ40CBrIxbS4gDEkXPHP7
 6AfCjDGa9m12QXN6R+XcIV79elcyqSZvO8Ygwxqgs5wKh1b3huDoYDafBGGxgQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wRAFI28P;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4Jz1tVAPCgeJwUPzRYuLpt2wfO5hyZefTLfGBRJj+8=;
 b=wRAFI28POvUcVFImJjof2t0NZVwbT2aWitgk3Iuonx5QDsiIw/0Yxq75pF+x8Zw1FEh8S5
 mqQJO+0oMvRDWDqPXwPH/aY312SL4ipwLNNVgUsj/8L4lAXZIuXWW2ghDB74q9CHiwXen8
 yHGq262AjkmXldee2c58FrLfeNPukpWOEV1HVoIsv60xSwe/9n4N5q81SJ4wLOoUTHbUkM
 KBshDSdJXP054PwF4bYSaQA0i/Mms/NdbsgdpLli134XV9N26vTnNnq7exN59i8Ldq9a2j
 m00Avu+sWav85jd/fX3yRWN7+g6x4zo28Y8r91vf8PIoiS17TxIcuXlGFWliag==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: dts: renesas: Clean up RPC DT nodes
Date: Mon, 20 Apr 2026 03:21:10 +0200
Message-ID: <20260420012202.400389-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b86a9c3ad669da4a69a
X-MBO-RS-META: 3nh9174pshtb7juagwtn3irffqugqnhk
X-Rspamd-Queue-Id: 4fzSQD2dT0z9v5R
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

Remove duplicate properties which are present both in arch/arm/dts/
and upstream dts/upstream/src/arm64/renesas/ in favor of those in
upstream DTs. Since those are duplicates, this causes no functional
change. Remove unused num-cs and bank-width DT properties.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi    |  1 -
 arch/arm/dts/r8a774c0-ek874-u-boot.dtsi       |  1 -
 arch/arm/dts/r8a774c0-u-boot.dtsi             | 12 -----------
 arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi  |  5 -----
 arch/arm/dts/r8a77951-u-boot.dtsi             | 12 -----------
 arch/arm/dts/r8a77951-ulcb-u-boot.dtsi        |  5 -----
 arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi  |  5 -----
 arch/arm/dts/r8a77960-u-boot.dtsi             | 12 -----------
 arch/arm/dts/r8a77960-ulcb-u-boot.dtsi        |  5 -----
 arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi  |  5 -----
 arch/arm/dts/r8a77965-u-boot.dtsi             | 12 -----------
 arch/arm/dts/r8a77965-ulcb-u-boot.dtsi        |  5 -----
 arch/arm/dts/r8a77970-eagle-u-boot.dtsi       |  3 ---
 arch/arm/dts/r8a77970-u-boot.dtsi             | 18 -----------------
 arch/arm/dts/r8a77970-v3msk-u-boot.dtsi       |  3 ---
 arch/arm/dts/r8a77980-condor-u-boot.dtsi      |  4 ----
 arch/arm/dts/r8a77980-u-boot.dtsi             | 18 -----------------
 arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi       |  4 ----
 arch/arm/dts/r8a77990-ebisu-u-boot.dtsi       |  7 -------
 arch/arm/dts/r8a77990-u-boot.dtsi             | 18 -----------------
 arch/arm/dts/r8a77995-draak-u-boot.dtsi       |  7 -------
 arch/arm/dts/r8a77995-u-boot.dtsi             | 18 -----------------
 arch/arm/dts/r8a779a0-falcon-u-boot.dtsi      |  4 ----
 arch/arm/dts/r8a779a0-u-boot.dtsi             | 19 ------------------
 arch/arm/dts/r8a779g0-u-boot.dtsi             |  5 -----
 .../dts/r8a779h0-gray-hawk-single-u-boot.dtsi | 20 -------------------
 arch/arm/dts/r8a779h0-u-boot.dtsi             | 11 ----------
 arch/arm/dts/rz-g2-beacon-u-boot.dtsi         |  1 -
 28 files changed, 240 deletions(-)
 delete mode 100644 arch/arm/dts/r8a77970-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77980-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77990-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a77995-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779a0-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi

diff --git a/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi b/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
index 34fba29e859..9a30425bdad 100644
--- a/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
+++ b/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
@@ -49,7 +49,6 @@
 		compatible = "renesas,r7s72100-rpc-if";
 		reg = <0x3fefa000 0x100>, <0x18000000 0x08000000>;
 		bank-width = <2>;
-		num-cs = <1>;
 		status = "okay";
 		spi-max-frequency = <50000000>;
 		#address-cells = <1>;
diff --git a/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi b/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
index dcdddd9aed6..9a77e242af2 100644
--- a/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
+++ b/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
@@ -14,7 +14,6 @@
 };
 
 &rpc {
-	num-cs = <1>;
 	status = "okay";
 	spi-max-frequency = <50000000>;
 	#address-cells = <1>;
diff --git a/arch/arm/dts/r8a774c0-u-boot.dtsi b/arch/arm/dts/r8a774c0-u-boot.dtsi
index 17b863d23c9..d7b98783196 100644
--- a/arch/arm/dts/r8a774c0-u-boot.dtsi
+++ b/arch/arm/dts/r8a774c0-u-boot.dtsi
@@ -6,18 +6,6 @@
  *
  */
 
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a774c0-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
-
 /delete-node/ &can0;
 /delete-node/ &can1;
 /delete-node/ &canfd;
diff --git a/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
index d88e839a890..a162173b493 100644
--- a/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
@@ -23,11 +23,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index 13760f3d5d4..e8a7fa27a76 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -5,18 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a7795-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
-
 /delete-node/ &ak4613;
 /delete-node/ &audma0;
 /delete-node/ &audma1;
diff --git a/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
index 8269d967af9..81bf715d300 100644
--- a/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
@@ -32,11 +32,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
index 0a1602cdd23..3c90e2a87ad 100644
--- a/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
@@ -23,11 +23,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index 9cc0d52f634..b437792a172 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -5,18 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a7796-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
-
 /delete-node/ &ak4613;
 /delete-node/ &audma0;
 /delete-node/ &audma1;
diff --git a/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
index d2a0406be17..2cc222d756a 100644
--- a/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
@@ -32,11 +32,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
index 518466aca35..3ad407f022e 100644
--- a/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
@@ -23,11 +23,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index 3cf32d84ca0..57382e34912 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -5,18 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a77965-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
-
 /delete-node/ &ak4613;
 /delete-node/ &audma0;
 /delete-node/ &audma1;
diff --git a/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
index 3905bf4e4f7..ce715f61976 100644
--- a/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
@@ -32,11 +32,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77970-eagle-u-boot.dtsi b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
index c7971b9e9ce..b18ec9a695d 100644
--- a/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77970-u-boot.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -34,9 +33,7 @@
 };
 
 &rpc {
-	num-cs = <1>;
 	status = "okay";
-	spi-max-frequency = <50000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 
diff --git a/arch/arm/dts/r8a77970-u-boot.dtsi b/arch/arm/dts/r8a77970-u-boot.dtsi
deleted file mode 100644
index d00ef2f3105..00000000000
--- a/arch/arm/dts/r8a77970-u-boot.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A77970 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a77970-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
index c7b2e07793d..e5352a663f4 100644
--- a/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Cogent Embedded, Inc.
  */
 
-#include "r8a77970-u-boot.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -45,9 +44,7 @@
 };
 
 &rpc {
-	num-cs = <1>;
 	status = "okay";
-	spi-max-frequency = <50000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 
diff --git a/arch/arm/dts/r8a77980-condor-u-boot.dtsi b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
index 382bfe8cacd..34acdb1717c 100644
--- a/arch/arm/dts/r8a77980-condor-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77980-u-boot.dtsi"
-
 / {
 	aliases {
 		spi0 = &rpc;
@@ -28,9 +26,7 @@
 };
 
 &rpc {
-	num-cs = <1>;
 	status = "okay";
-	spi-max-frequency = <50000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 
diff --git a/arch/arm/dts/r8a77980-u-boot.dtsi b/arch/arm/dts/r8a77980-u-boot.dtsi
deleted file mode 100644
index df862978cba..00000000000
--- a/arch/arm/dts/r8a77980-u-boot.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A77980 SoC
- *
- * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
- */
-
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a77980-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi b/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
index 2901d0e7b57..2a4bd2e5fdf 100644
--- a/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2019 Cogent Embedded, Inc.
  */
 
-#include "r8a77980-u-boot.dtsi"
-
 / {
 	aliases {
 		spi0 = &rpc;
@@ -14,9 +12,7 @@
 };
 
 &rpc {
-	num-cs = <1>;
 	status = "okay";
-	spi-max-frequency = <50000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 
diff --git a/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
index a52c5de4ddf..91b9a20a042 100644
--- a/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
+++ b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77990-u-boot.dtsi"
-
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
@@ -33,11 +31,6 @@
 	};
 };
 
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
-
 &sdhi0 {
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
diff --git a/arch/arm/dts/r8a77990-u-boot.dtsi b/arch/arm/dts/r8a77990-u-boot.dtsi
deleted file mode 100644
index d9dcce00e90..00000000000
--- a/arch/arm/dts/r8a77990-u-boot.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A77990 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a77990-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/r8a77995-draak-u-boot.dtsi b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
index 19d19542efd..d0dd06f08bf 100644
--- a/arch/arm/dts/r8a77995-draak-u-boot.dtsi
+++ b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77995-u-boot.dtsi"
-
 / {
 	sysinfo {
 		compatible = "renesas,rcar-sysinfo";
@@ -22,8 +20,3 @@
 		bootph-all;
 	};
 };
-
-&rpc {
-	reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0x04000000>;
-	status = "disabled";
-};
diff --git a/arch/arm/dts/r8a77995-u-boot.dtsi b/arch/arm/dts/r8a77995-u-boot.dtsi
deleted file mode 100644
index 85fccbabfb3..00000000000
--- a/arch/arm/dts/r8a77995-u-boot.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A77995 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x100>, <0 0x08000000 0 0>;
-			clocks = <&cpg CPG_MOD 917>;
-			bank-width = <2>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi b/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
index 3b8a017cb41..c1d92d2d9bb 100644
--- a/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
+++ b/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a779a0-u-boot.dtsi"
-
 / {
 	aliases {
 		spi0 = &rpc;
@@ -16,8 +14,6 @@
 &rpc {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	num-cs = <1>;
-	spi-max-frequency = <50000000>;
 	status = "okay";
 
 	flash@0 {
diff --git a/arch/arm/dts/r8a779a0-u-boot.dtsi b/arch/arm/dts/r8a779a0-u-boot.dtsi
deleted file mode 100644
index a4e75a67dc3..00000000000
--- a/arch/arm/dts/r8a779a0-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A779A0 SoC
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-
-/ {
-	soc {
-		rpc: spi@ee200000 {
-			compatible = "renesas,r8a779a0-rpc-if", "renesas,rcar-gen3-rpc-if";
-			reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x04000000>;
-			clocks = <&cpg CPG_MOD 629>;
-			bank-width = <2>;
-			num-cs = <1>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index bd6a3d0713f..5a2d1fe66ce 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -93,11 +93,6 @@
 	bootph-all;
 };
 
-&rpc {
-	bank-width = <2>;
-	num-cs = <1>;
-};
-
 &soc {
 	apmu@e6170000 {	/* Remoteproc */
 		compatible = "renesas,r8a779g0-cr52";
diff --git a/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
index c04d2ae2be4..f9c419b11d7 100644
--- a/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
+++ b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
@@ -5,36 +5,16 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
-#include "r8a779h0-u-boot.dtsi"
-
 / {
 	aliases {
 		spi0 = &rpc;
 	};
 };
 
-&pfc {
-	qspi0_pins: qspi0 {
-		groups = "qspi0_ctrl", "qspi0_data4";
-		function = "qspi0";
-	};
-};
-
 &rpc {
-	pinctrl-0 = <&qspi0_pins>;
-	pinctrl-names = "default";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <40000000>;
 	status = "disabled";
 
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "s25fs512s", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
diff --git a/arch/arm/dts/r8a779h0-u-boot.dtsi b/arch/arm/dts/r8a779h0-u-boot.dtsi
deleted file mode 100644
index 40e070be9a8..00000000000
--- a/arch/arm/dts/r8a779h0-u-boot.dtsi
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A779H0 SoC
- *
- * Copyright (C) 2025 Renesas Electronics Corp.
- */
-
-&rpc {
-	bank-width = <2>;
-	num-cs = <1>;
-};
diff --git a/arch/arm/dts/rz-g2-beacon-u-boot.dtsi b/arch/arm/dts/rz-g2-beacon-u-boot.dtsi
index 84416fceaff..97c4d4d292a 100644
--- a/arch/arm/dts/rz-g2-beacon-u-boot.dtsi
+++ b/arch/arm/dts/rz-g2-beacon-u-boot.dtsi
@@ -47,7 +47,6 @@
 &rpc {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
-	num-cs = <1>;
 	spi-max-frequency = <40000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.53.0

