Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC769E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 19:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AEF980317;
	Wed,  1 Jan 2025 20:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aTWzK3Kw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O15Mn/DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1E88031D; Wed,  1 Jan 2025 20:22:48 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ACC800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 20:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YNfqp16wGz9tsy;
 Wed,  1 Jan 2025 20:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sfrVngu5RFiwE1QLmbX1gk2PvGBBrmY+/plqDK/AgKg=;
 b=aTWzK3Kw1cHj2TlESYf9YVHAMYn66FuJ+6LinN0RVCdIL6dJjwKwn8WEUa38+NglEqNtYK
 3CM4fNfoWmbjtP4pdsWvArNA0MDPGxgGAR+5GU6hS7/9UTH6nHzfMcY91oEpOCvnJUIRVN
 uqFsjqmht0O9TvgvPV/gLw9gmHidiYQAUKfo6IPWy9iNQs9R0f79RL03E86ScQXRB4rMrW
 WPcz31ndAsLHWNcTMEgVP84wQBQzkqEm357rifV0y/ILTxYtPfFSGhFTR1V9ZLrTK8FDwb
 k5sr1WL++M6y2T7/A031VmiSXN0EUPFLUJevhOecw1XCMMo5w41zZPvs2CdKRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sfrVngu5RFiwE1QLmbX1gk2PvGBBrmY+/plqDK/AgKg=;
 b=O15Mn/DOElW52Evzq9WVgAAXUfvk7bCgseYpTZOrU/M+jklz9iInzaK93+hy4Bz0FpC6Vn
 qbTqUGs/wIna7grZxVXgH3wELOM8CP4JnLTeGuaUnAaL4eVBPn03w4yR8ghu9H5J5yQpRi
 iw3v7ecJqm9BLVmpl7ot6X0a0QRLAYe1pSdQ8T2d7QRJLQXjBfFz6FRF3GU2l2Rf6Aq/Ka
 0Ml6zijD6rjDaveCqHQl7XdEeZszi6uOskyP8E45GJHvA/qLfvAZEr9BLZa3Xj8dHc3EEr
 V9Hfp8/CEM8rqXvrIbDcFIxNJGCd8qKpUiuid2ZLgVfqnVEogkdI+tx7S0vRyA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: dts: renesas: Deduplicate extalr_clk bootph-all
Date: Wed,  1 Jan 2025 20:22:09 +0100
Message-ID: <20250101192222.26189-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d81b54d2c25fc920cd0
X-MBO-RS-META: t4ojhuyuoga535yzsctstmqfeq9po39r
X-Rspamd-Queue-Id: 4YNfqp16wGz9tsy
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

Most R-Car Gen3 and Gen4 systems require extalr_clk very early
in the boot process. Currently the extalr_clk { bootph-all } DT
property to indicate this clock should be available early is set
in each SoC U-Boot DT extras file. Deduplicate this assignment to
new common r8a779x-rcar64-u-boot.dtsi file.

Note that R-Car Gen3 R8A77990 E3 and R8A77995 D3 do not require
extalr_clk early, therefore these SoCs still include plain
r8a779x-u-boot.dtsi in their U-Boot DT extras .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Rebase on u-boot/next
---
 arch/arm/dts/r8a774a1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a774b1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a774c0-u-boot.dtsi       |  2 +-
 arch/arm/dts/r8a774e1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77951-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77960-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77965-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77970-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a77980-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779a0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779f0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779g0-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi | 12 ++++++++++++
 13 files changed, 24 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/dts/r8a779x-rcar64-u-boot.dtsi

diff --git a/arch/arm/dts/r8a774a1-u-boot.dtsi b/arch/arm/dts/r8a774a1-u-boot.dtsi
index 3530eeb2718..bd91a963cd6 100644
--- a/arch/arm/dts/r8a774a1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774a1-u-boot.dtsi
@@ -5,8 +5,4 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774b1-u-boot.dtsi b/arch/arm/dts/r8a774b1-u-boot.dtsi
index 07aeabc46b4..38a82f065c0 100644
--- a/arch/arm/dts/r8a774b1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774b1-u-boot.dtsi
@@ -5,8 +5,4 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a774c0-u-boot.dtsi b/arch/arm/dts/r8a774c0-u-boot.dtsi
index 4572c22f6c1..91d14536e48 100644
--- a/arch/arm/dts/r8a774c0-u-boot.dtsi
+++ b/arch/arm/dts/r8a774c0-u-boot.dtsi
@@ -6,7 +6,7 @@
  *
  */
 
-#include "r8a779x-u-boot.dtsi"
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a774e1-u-boot.dtsi b/arch/arm/dts/r8a774e1-u-boot.dtsi
index 2202731ccb3..f314b2b0cf8 100644
--- a/arch/arm/dts/r8a774e1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774e1-u-boot.dtsi
@@ -5,8 +5,4 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a77951-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
index c16c5116592..768d633ded0 100644
--- a/arch/arm/dts/r8a77951-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -5,11 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a77960-u-boot.dtsi b/arch/arm/dts/r8a77960-u-boot.dtsi
index 2245be2aa76..db062f8e8c7 100644
--- a/arch/arm/dts/r8a77960-u-boot.dtsi
+++ b/arch/arm/dts/r8a77960-u-boot.dtsi
@@ -5,11 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a77965-u-boot.dtsi b/arch/arm/dts/r8a77965-u-boot.dtsi
index f39acc237d3..d67e94e318b 100644
--- a/arch/arm/dts/r8a77965-u-boot.dtsi
+++ b/arch/arm/dts/r8a77965-u-boot.dtsi
@@ -5,11 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a77970-u-boot.dtsi b/arch/arm/dts/r8a77970-u-boot.dtsi
index 7900c641ba1..8dfa56c2f13 100644
--- a/arch/arm/dts/r8a77970-u-boot.dtsi
+++ b/arch/arm/dts/r8a77970-u-boot.dtsi
@@ -5,11 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a77980-u-boot.dtsi b/arch/arm/dts/r8a77980-u-boot.dtsi
index aa7e058c585..088839907c2 100644
--- a/arch/arm/dts/r8a77980-u-boot.dtsi
+++ b/arch/arm/dts/r8a77980-u-boot.dtsi
@@ -5,11 +5,7 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a779x-u-boot.dtsi"
-
-&extalr_clk {
-	bootph-all;
-};
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/dts/r8a779a0-u-boot.dtsi b/arch/arm/dts/r8a779a0-u-boot.dtsi
index 2b6d6ef05dc..f506a666518 100644
--- a/arch/arm/dts/r8a779a0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779a0-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
@@ -19,7 +19,3 @@
 		};
 	};
 };
-
-&extalr_clk {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a779f0-u-boot.dtsi b/arch/arm/dts/r8a779f0-u-boot.dtsi
index 0f98c09fc52..08d32fef2b9 100644
--- a/arch/arm/dts/r8a779f0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779f0-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	soc {
@@ -22,7 +22,3 @@
 		};
 	};
 };
-
-&extalr_clk {
-	bootph-all;
-};
diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index 2e731b628b3..10051c9dbfe 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 / {
 	binman: binman {
@@ -139,10 +139,6 @@
 	bootph-all;
 };
 
-&extalr_clk {
-	bootph-all;
-};
-
 &hscif0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi b/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
new file mode 100644
index 00000000000..b59cc7deca7
--- /dev/null
+++ b/arch/arm/dts/r8a779x-rcar64-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot on R-Car 64bit SoC
+ *
+ * Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include "r8a779x-u-boot.dtsi"
+
+&extalr_clk {
+	bootph-all;
+};
-- 
2.45.2

