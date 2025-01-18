Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1A2C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8464780748;
	Sat, 18 Jan 2025 08:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hw+nmfPJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pXcxY0vV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7089980758; Sat, 18 Jan 2025 08:16:39 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9C980761
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZnw40p1dz9sbl;
 Sat, 18 Jan 2025 08:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FAsQQZmOwSAJ+788LXWP6p6kISKKQWabvrDQnGR0nUQ=;
 b=Hw+nmfPJZkcvyjInVXah+olILQzm07+EnHvwYBAFTP6YuSjuQSAnnCrYceUQR77jDLICfR
 2XhWelI8HMDFQzKbeP6pswIROp4mZzvqOcSOIH2eSHM3VSTrR7dGR2LR0W3MPxZzg9Ssv/
 MmO8ODztlrZX7wXrX05T5y+RSFwgkVwadD7wrfRn1sAiSQfACTtU7jO3ZdA92ue4mIuhZ/
 Y2tD6qusef1Z9lqj7sxGM26OWtJLGjwGojRs/ilITpF5KT85igs1zyU8/n0ULC2a9SRirL
 ZyaW0Hqzzd1qmmEF6smcF3HVfxcym/ezhe5BNvRuMA968ICy83mx2+23FjthMw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FAsQQZmOwSAJ+788LXWP6p6kISKKQWabvrDQnGR0nUQ=;
 b=pXcxY0vVNClTthqNrO5z9WEzN6cxsz+quVj0ZeJSR6MMTGiu+luLr4ntSqyBdZpfRQwnaP
 z9tTHOoaZDcjF6Ryl9V8JW1aqsdI/wuaQKlygmdnaqpRvguTZ/oGOjMgOQH9p9gislxInZ
 R/Teo0dKPuegpfZL/Qt5ljD2Nnsrm4FxorF8zJ8q21nB50mG0Xw6vvoCG7c2RsP/7sHtcY
 EN7TskIYQ6zddX2v/cYwS7IROnrzZ++caWX2YDS5/KBjOwAq4IbTLtVWkXqvz7aKJiVLqx
 tfFiecEL2tMVdiVKE6EGKDXc1iEZ5T+GLpPwR5wljtsTWLpDaK5Bi/IniOj9QQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] arm64: dts: renesas: Deduplicate extalr_clk bootph-all
Date: Sat, 18 Jan 2025 08:15:52 +0100
Message-ID: <20250118071617.183795-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8e4c23af7f21fd597a6
X-MBO-RS-META: 1eksn8j1nshjrixope31hr9wbzyueg4g
X-Rspamd-Queue-Id: 4YZnw40p1dz9sbl
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

Note that R-Car Gen3 R8A77990 E3 and R8A77995 D3 and RZ R8A774C0
do not require extalr_clk early, therefore these SoCs still include
plain r8a779x-u-boot.dtsi in their U-Boot DT extras .

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
V3: Fix up R8A774C0
---
 arch/arm/dts/r8a774a1-u-boot.dtsi       |  6 +-----
 arch/arm/dts/r8a774b1-u-boot.dtsi       |  6 +-----
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
 12 files changed, 23 insertions(+), 55 deletions(-)
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

