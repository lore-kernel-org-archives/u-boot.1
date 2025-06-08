Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21104C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 19:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6728144A;
	Sun,  8 Jun 2025 21:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="raavwSLf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KOF2fQa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBDC81E06; Sun,  8 Jun 2025 21:05:06 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BCB480FA8
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 21:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bFkyS1PLFz9tCT;
 Sun,  8 Jun 2025 21:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749409504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=j8g6fxVIXCGnOMDSqcYjBjxTOsNAQylxMPuZmPE7gSo=;
 b=raavwSLftK1J1iecPz6lISJvIcBbvFoPcrHIuvPUnfYWGbjFbymsXkXDfmn/2vETb8yGuw
 XOYpmLap22w5QafkzFztm/VBLiw5kKHAb4/n/aPnvmTnsLTF750MfWQLg5PlozpjmjPNkW
 5mn9a9jjr6Q4F6YpKPNcJu0XXkb1kL93fDcOezi0T2U+cwaEBCLG7xxYfxDSm20Bnfpwng
 JkXsuSZjUgalYod0x0sp0A7/RoTflAgKaUj6bSbVA9BALBmzjV/uZg95UlmxU6FsrGY5Za
 FnWvHkmsyLtcYHVBiFS7gZ33eh8E0+4mRyRkP7P9vslnQ5lDghK2N48VUsc5LA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749409502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=j8g6fxVIXCGnOMDSqcYjBjxTOsNAQylxMPuZmPE7gSo=;
 b=KOF2fQa24pnmYwu8Ns6LQyAK2hdq/VXvqgtOqsv9aiPty3XrmUlziorEPgQ5hzjjssQhyr
 0IV6feGZOLOUf79P466VrbLFrYZFwICo8nITPeeHHCPDC4Xgxhy4SZNzCJ/JD3n1sAHUDx
 rXSasz15EsSAEwXUnCEYtLLbbz0aMHnXfXpnOF91vBn5usJwk7LXlUY3tRjPpfRJv+IHlT
 kmkytimv17y8WAUTR47CwgaQK+nkidjhaLjBi5Ujr8CjS3rQTOHQWn5sfiHQpONkVVWG0K
 vRCJ82sGhgvVa5W3tNLMYJivsdGNJ9rpFu3htq0wYb5yeYbGGiAsx3wo0g430A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Drop most of bootph-* tags
Date: Sun,  8 Jun 2025 21:04:14 +0200
Message-ID: <20250608190436.1219647-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cfc3fzafpere6k3zk5pxg88ecwbwuycm
X-MBO-RS-ID: 9ec0405d768cf73418d
X-Rspamd-Queue-Id: 4bFkyS1PLFz9tCT
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

The bootph-* tags are now part of mainline Linux DTs as commits:
f1a1268572cc ("ARM: dts: renesas: rcar-gen2: Add boot phase tags")
399f14ff6625 ("arm64: dts: renesas: rcar: Add boot phase tags")
624b2a23d46a ("arm64: dts: renesas: rzg2: Add boot phase tags")
Drop local duplicates of the same tags, as well as duplicate
property assignments which are part of the core DTs themselves.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 .../dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi  |  8 ----
 arch/arm/dts/r8a774a1-u-boot.dtsi             |  8 ----
 .../dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi  |  8 ----
 arch/arm/dts/r8a774b1-u-boot.dtsi             |  8 ----
 arch/arm/dts/r8a774c0-u-boot.dtsi             |  2 -
 .../dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi  |  8 ----
 arch/arm/dts/r8a774e1-u-boot.dtsi             |  8 ----
 arch/arm/dts/r8a7790-lager-u-boot.dtsi        |  6 ---
 arch/arm/dts/r8a7790-stout-u-boot.dtsi        |  6 ---
 arch/arm/dts/r8a7790-u-boot.dtsi              | 20 ----------
 arch/arm/dts/r8a7791-koelsch-u-boot.dtsi      |  6 ---
 arch/arm/dts/r8a7791-porter-u-boot.dtsi       | 15 ++-----
 arch/arm/dts/r8a7791-u-boot.dtsi              | 20 ----------
 arch/arm/dts/r8a7792-blanche-u-boot.dtsi      | 16 --------
 arch/arm/dts/r8a7792-u-boot.dtsi              | 16 --------
 arch/arm/dts/r8a7793-gose-u-boot.dtsi         |  6 ---
 arch/arm/dts/r8a7793-u-boot.dtsi              | 20 ----------
 arch/arm/dts/r8a7794-alt-u-boot.dtsi          | 39 -------------------
 arch/arm/dts/r8a7794-silk-u-boot.dtsi         |  6 ---
 arch/arm/dts/r8a7794-u-boot.dtsi              | 20 ----------
 arch/arm/dts/r8a77951-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77960-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77965-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77970-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77980-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77990-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a77995-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a779a0-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a779f0-u-boot.dtsi             |  2 -
 arch/arm/dts/r8a779g0-u-boot.dtsi             | 18 ---------
 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi       | 12 ------
 arch/arm/dts/r8a779x-u-boot.dtsi              | 24 ------------
 32 files changed, 4 insertions(+), 314 deletions(-)
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7790-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7791-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7792-blanche-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7792-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7793-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a7794-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779x-u-boot.dtsi

diff --git a/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi b/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
deleted file mode 100644
index dd5a208cc1b..00000000000
--- a/arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2M board
- *
- * Copyright (C) 2021-2024 Renesas Electronics Corporation
- */
-
-#include "r8a774a1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774a1-u-boot.dtsi b/arch/arm/dts/r8a774a1-u-boot.dtsi
deleted file mode 100644
index bd91a963cd6..00000000000
--- a/arch/arm/dts/r8a774a1-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on RZ/G2 R8A774A1 SoC
- *
- * Copyright (C) 2021 Renesas Electronics Corporation
- */
-
-#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi b/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
deleted file mode 100644
index b378cabb22c..00000000000
--- a/arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2N board
- *
- * Copyright (C) 2021-2024 Renesas Electronics Corp.
- */
-
-#include "r8a774b1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774b1-u-boot.dtsi b/arch/arm/dts/r8a774b1-u-boot.dtsi
deleted file mode 100644
index 38a82f065c0..00000000000
--- a/arch/arm/dts/r8a774b1-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on RZ/G2 R8A774B1 SoC
- *
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-
-#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774c0-u-boot.dtsi b/arch/arm/dts/r8a774c0-u-boot.dtsi
index 4572c22f6c1..17b863d23c9 100644
--- a/arch/arm/dts/r8a774c0-u-boot.dtsi
+++ b/arch/arm/dts/r8a774c0-u-boot.dtsi
@@ -6,8 +6,6 @@
  *
  */
 
-#include "r8a779x-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi b/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
deleted file mode 100644
index 560bea46ad7..00000000000
--- a/arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Hihope RZ/G2H board
- *
- * Copyright (C) 2020-2024 Renesas Electronics Corp.
- */
-
-#include "r8a774e1-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774e1-u-boot.dtsi b/arch/arm/dts/r8a774e1-u-boot.dtsi
deleted file mode 100644
index f314b2b0cf8..00000000000
--- a/arch/arm/dts/r8a774e1-u-boot.dtsi
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on RZ/G2 R8A774E1 SoC
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-
-#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a7790-lager-u-boot.dtsi b/arch/arm/dts/r8a7790-lager-u-boot.dtsi
index ed1891706ce..2b18e2e6af4 100644
--- a/arch/arm/dts/r8a7790-lager-u-boot.dtsi
+++ b/arch/arm/dts/r8a7790-lager-u-boot.dtsi
@@ -5,12 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7790-u-boot.dtsi"
-
-&scif0 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/r8a7790-stout-u-boot.dtsi b/arch/arm/dts/r8a7790-stout-u-boot.dtsi
index 3b393045e36..788432bc590 100644
--- a/arch/arm/dts/r8a7790-stout-u-boot.dtsi
+++ b/arch/arm/dts/r8a7790-stout-u-boot.dtsi
@@ -5,12 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7790-u-boot.dtsi"
-
-&scifa0 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/r8a7790-u-boot.dtsi b/arch/arm/dts/r8a7790-u-boot.dtsi
deleted file mode 100644
index 2a7d76bd7b1..00000000000
--- a/arch/arm/dts/r8a7790-u-boot.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A7790 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&usb_extal_clk {
-	bootph-all;
-};
-
-&pfc {
-	bootph-all;
-};
-
-&rst {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi b/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
index 541c4191d69..ed258d55e58 100644
--- a/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
+++ b/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
@@ -5,12 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7791-u-boot.dtsi"
-
-&scif0 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/r8a7791-porter-u-boot.dtsi b/arch/arm/dts/r8a7791-porter-u-boot.dtsi
index cbf2c5265d8..cb80842f326 100644
--- a/arch/arm/dts/r8a7791-porter-u-boot.dtsi
+++ b/arch/arm/dts/r8a7791-porter-u-boot.dtsi
@@ -5,20 +5,13 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7791-u-boot.dtsi"
-
-&scif0 {
-	bootph-all;
-};
-
-&i2c6 {
-	status = "okay";
-	clock-frequency = <400000>;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
 };
+
+&i2c6 {
+	clock-frequency = <400000>;
+};
diff --git a/arch/arm/dts/r8a7791-u-boot.dtsi b/arch/arm/dts/r8a7791-u-boot.dtsi
deleted file mode 100644
index bb0e2fd106c..00000000000
--- a/arch/arm/dts/r8a7791-u-boot.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A7791 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&usb_extal_clk {
-	bootph-all;
-};
-
-&pfc {
-	bootph-all;
-};
-
-&rst {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a7792-blanche-u-boot.dtsi b/arch/arm/dts/r8a7792-blanche-u-boot.dtsi
deleted file mode 100644
index 8c36a3e5850..00000000000
--- a/arch/arm/dts/r8a7792-blanche-u-boot.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot for the Blanche board
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a7792-u-boot.dtsi"
-
-&iic3 {
-	status = "okay";
-};
-
-&scif0 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a7792-u-boot.dtsi b/arch/arm/dts/r8a7792-u-boot.dtsi
deleted file mode 100644
index ebbdcb7efd5..00000000000
--- a/arch/arm/dts/r8a7792-u-boot.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A7792 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&pfc {
-	bootph-all;
-};
-
-&rst {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a7793-gose-u-boot.dtsi b/arch/arm/dts/r8a7793-gose-u-boot.dtsi
index 41c4361c6e1..fd99e0ffe76 100644
--- a/arch/arm/dts/r8a7793-gose-u-boot.dtsi
+++ b/arch/arm/dts/r8a7793-gose-u-boot.dtsi
@@ -5,12 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7793-u-boot.dtsi"
-
-&scif0 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/r8a7793-u-boot.dtsi b/arch/arm/dts/r8a7793-u-boot.dtsi
deleted file mode 100644
index 08f2248e1f3..00000000000
--- a/arch/arm/dts/r8a7793-u-boot.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A7793 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&usb_extal_clk {
-	bootph-all;
-};
-
-&pfc {
-	bootph-all;
-};
-
-&rst {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a7794-alt-u-boot.dtsi b/arch/arm/dts/r8a7794-alt-u-boot.dtsi
index e156b4c93c7..fea7138a1c1 100644
--- a/arch/arm/dts/r8a7794-alt-u-boot.dtsi
+++ b/arch/arm/dts/r8a7794-alt-u-boot.dtsi
@@ -5,48 +5,9 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7794-u-boot.dtsi"
-
-&i2c7 {
-	status = "okay";
-	clock-frequency = <100000>;
-};
-
-&pci0 {
-	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-};
-
-&pci1 {
-	status = "okay";
-	pinctrl-0 = <&usb1_pins>;
-	pinctrl-names = "default";
-};
-
-&pfc {
-	usb0_pins: usb0 {
-		groups = "usb0";
-		function = "usb0";
-	};
-
-	usb1_pins: usb1 {
-		groups = "usb1";
-		function = "usb1";
-	};
-};
-
-&scif2 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
 };
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/dts/r8a7794-silk-u-boot.dtsi b/arch/arm/dts/r8a7794-silk-u-boot.dtsi
index e448ea7e146..f87d04b0ae0 100644
--- a/arch/arm/dts/r8a7794-silk-u-boot.dtsi
+++ b/arch/arm/dts/r8a7794-silk-u-boot.dtsi
@@ -5,12 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7794-u-boot.dtsi"
-
-&scif2 {
-	bootph-all;
-};
-
 &qspi {
 	flash@0 {
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/r8a7794-u-boot.dtsi b/arch/arm/dts/r8a7794-u-boot.dtsi
deleted file mode 100644
index 303afaeb4ce..00000000000
--- a/arch/arm/dts/r8a7794-u-boot.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car R8A7794 SoC
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&usb_extal_clk {
-	bootph-all;
-};
-
-&pfc {
-	bootph-all;
-};
-
-&rst {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index 768d633ded0..13760f3d5d4 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index db062f8e8c7..9cc0d52f634 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index d67e94e318b..3cf32d84ca0 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77970-u-boot.dtsi b/arch/arm/dts/r8a77970-u-boot.dtsi
index 8dfa56c2f13..d00ef2f3105 100644
--- a/arch/arm/dts/r8a77970-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77980-u-boot.dtsi b/arch/arm/dts/r8a77980-u-boot.dtsi
index 088839907c2..df862978cba 100644
--- a/arch/arm/dts/r8a77980-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77990-u-boot.dtsi b/arch/arm/dts/r8a77990-u-boot.dtsi
index b701f68db81..d9dcce00e90 100644
--- a/arch/arm/dts/r8a77990-u-boot.dtsi
+++ b/arch/arm/dts/r8a77990-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a77995-u-boot.dtsi b/arch/arm/dts/r8a77995-u-boot.dtsi
index f4bafb6d088..85fccbabfb3 100644
--- a/arch/arm/dts/r8a77995-u-boot.dtsi
+++ b/arch/arm/dts/r8a77995-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a779a0-u-boot.dtsi b/arch/arm/dts/r8a779a0-u-boot.dtsi
index f506a666518..a4e75a67dc3 100644
--- a/arch/arm/dts/r8a779a0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779a0-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a779f0-u-boot.dtsi b/arch/arm/dts/r8a779f0-u-boot.dtsi
index 08d32fef2b9..a7ff4eb708a 100644
--- a/arch/arm/dts/r8a779f0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779f0-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	soc {
 		rpc: spi@ee200000 {
diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index cc9d99b0f34..5aa61314834 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -5,8 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-rcar64-u-boot.dtsi"
-
 / {
 	binman: binman {
 		multiple-images;
@@ -135,14 +133,6 @@
 	};
 };
 
-&cpg {
-	bootph-all;
-};
-
-&hscif0 {
-	bootph-all;
-};
-
 &hscif0_pins {
 	bootph-all;
 };
@@ -151,19 +141,11 @@
 	bootph-all;
 };
 
-&pfc {
-	bootph-all;
-};
-
 &rpc {
 	bank-width = <2>;
 	num-cs = <1>;
 };
 
-&rst {
-	bootph-all;
-};
-
 &soc {
 	apmu@e6170000 {	/* Remoteproc */
 		compatible = "renesas,r8a779g0-cr52";
diff --git a/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi b/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
deleted file mode 100644
index b59cc7deca7..00000000000
--- a/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car 64bit SoC
- *
- * Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
- */
-
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a779x-u-boot.dtsi b/arch/arm/dts/r8a779x-u-boot.dtsi
deleted file mode 100644
index d1441f1f9df..00000000000
--- a/arch/arm/dts/r8a779x-u-boot.dtsi
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source extras for U-Boot on R-Car Gen3
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- */
-
-/ {
-	soc {
-		bootph-all;
-	};
-};
-
-&cpg {
-	bootph-all;
-};
-
-&extal_clk {
-	bootph-all;
-};
-
-&prr {
-	bootph-all;
-};
-- 
2.47.2

