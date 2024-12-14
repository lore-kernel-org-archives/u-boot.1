Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED444E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 22:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EDC68006F;
	Sat, 14 Dec 2024 23:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s3lHDSkj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AAjr84wZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADF88007A; Sat, 14 Dec 2024 23:47:43 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1C78006C
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y9hDX5cC2z9sls;
 Sat, 14 Dec 2024 23:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+a9U61kHtVSUjifIRUm1D4fpbfN0FDUn6KKk4CnPBs=;
 b=s3lHDSkjOVNIz0ip4GqHpjTWrQOKGob0orv4NrVdC8Sg9dfSebI146mmr3SxisMmSqxiI/
 thGJmc17uUPKygR/1VMchQpqZb1z9L/EJ2JTeLse2DSJQbCaRKnZjOwJvrwZhjx5is8JVV
 0G/YtXixJCOM2KycRq54vGp5XF2ac41pfpZNYGqKbtz4wKbnkFFImOMg3ZNuhWn7b/LfLz
 pmO7wATz35xHN3k1ZiXR3nF6FgHgveT5BLAOhLiv1CPIwKgdIbFQTiHZ/fGsOJD73vxg+V
 F2W8PBZRj6+1MMBPxWxbNDetXLCollj7HGDYaOpgB0ghiar7NXZJ7iNZMmrSRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734216458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M+a9U61kHtVSUjifIRUm1D4fpbfN0FDUn6KKk4CnPBs=;
 b=AAjr84wZa+y/GzQ4ib65cya57jOZxD3ZHbCmyKfUhUh+opFUR33s9KmfgZSFdRrwo15Jt0
 PRnRHZbb4jZ+jj/fYBDyojSnTbA826nTInNOwvveZ9AFtaMqNDyRTox9oGkbwazK64+6IZ
 ctYTdD/pRYpOv76OK+R2UCbYYuO2u0tgjKyhwMmpFHJklff1Sxdw+wEHzQ5rVomZHZ0xhR
 B3dhl4rJlmXuyy3jXHmXJq7PPOtB1FeBN5Fd+qiQsizYRS3h0rNwFyacT8BEI7t5tD2WtS
 KS+R0Tt8TFXau0Vql9NyfKAXYZtBSzHOyr0aioOWuVgJP1S2+pVQXS9Bz06s4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: Deduplicate extalr_clk bootph-all
Date: Sat, 14 Dec 2024 23:46:58 +0100
Message-ID: <20241214224726.304025-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mudajn5ro8udxkjdyumuwnd7xz76i1r6
X-MBO-RS-ID: 65eb59c2572006f2aaa
X-Rspamd-Queue-Id: 4Y9hDX5cC2z9sls
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
index 4cbec591479..54eb331ec39 100644
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
index 15a91474324..c712837500e 100644
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
index 54107d1ae35..4a6ded386f8 100644
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
index d252c2e8e6c..160e1c983cb 100644
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
index 9f7bf499bc0..afb226403a0 100644
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
index f60eba531e4..4fc196e97b5 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -5,13 +5,9 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779x-u-boot.dtsi"
+#include "r8a779x-rcar64-u-boot.dtsi"
 
 &rpc {
 	bank-width = <2>;
 	num-cs = <1>;
 };
-
-&extalr_clk {
-	bootph-all;
-};
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

