Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0C9C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 10:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98773870EB;
	Mon, 13 Nov 2023 11:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HUWbdDkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68877870DE; Mon, 13 Nov 2023 11:19:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D178709A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJF9e092118;
 Mon, 13 Nov 2023 04:19:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699870755;
 bh=9AuZ6/0gix8eIC6umK91Jz7JwIZ5ZHW7ypJKCZ++/RQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=HUWbdDkxbydD5UFCGz3hHDXe4MoqJD8ajQC7IWmGTTLhO0uqW0lv74yDPVVbZ/PIK
 HNKn9o4kyYlUyV7tRlcao9io7O6GNYoDD7GaR4UjGDws3eBxXtNViENuu9U40swoKG
 eiCs+jaHTA9gaM7NQfaAPQIhe6r162jKvKEndhNI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADAJFfp075557
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 04:19:15 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 04:19:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 04:19:15 -0600
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJ069051156;
 Mon, 13 Nov 2023 04:19:12 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 13 Nov 2023 15:49:02 +0530
Subject: [PATCH v5 3/8] binman: k3: Add k3-security.h and include it in
 k3-binman.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231113-binman-firewalling-v5-3-b3ba6f839606@ti.com>
References: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
In-Reply-To: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699870741; l=3106;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=czR0WD4G/eRethcrUrXVWdCGjjqepaOKFWH/PkuK86Y=;
 b=2S1VnK5d5r4oGDQzu4T7oUnzgN2CRBblQcsuXQb5LtohtclLCh1BliSIVT5x5nKw/cLYEN214
 Tyg2uttfkzCA1X1Ok1GuUvD1Bg1abVZiy/99k2aYutbV0t+o6cplVl/
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

For readability during configuring firewalls, adding k3-security.h file
and including it in k3-binman.dtsi to be accessible across K3 SoCs

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-binman.dtsi |  2 ++
 arch/arm/dts/k3-security.h  | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 2ea2dd18a12b..71ffa998a59f 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include "k3-security.h"
+
 / {
 	binman: binman {
 		multiple-images;
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
new file mode 100644
index 000000000000..33609caa8fb5
--- /dev/null
+++ b/arch/arm/dts/k3-security.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef DTS_ARM64_TI_K3_FIREWALL_H
+#define DTS_ARM64_TI_K3_FIREWALL_H
+
+#define FWPRIVID_ALL    0xc3
+#define FWPRIVID_ARMV8  1
+#define FWPRIVID_SHIFT  16
+
+#define FWCTRL_EN     0xA
+#define FWCTRL_LOCK   (1 << 4)
+#define FWCTRL_BG     (1 << 8)
+#define FWCTRL_CACHE  (1 << 9)
+
+#define FWPERM_SECURE_PRIV_WRITE      (1 << 0)
+#define FWPERM_SECURE_PRIV_READ       (1 << 1)
+#define FWPERM_SECURE_PRIV_CACHEABLE  (1 << 2)
+#define FWPERM_SECURE_PRIV_DEBUG      (1 << 3)
+
+#define FWPERM_SECURE_PRIV_RWCD       (FWPERM_SECURE_PRIV_READ | \
+									   FWPERM_SECURE_PRIV_WRITE | \
+									   FWPERM_SECURE_PRIV_CACHEABLE | \
+									   FWPERM_SECURE_PRIV_DEBUG)
+
+#define FWPERM_SECURE_USER_WRITE      (1 << 4)
+#define FWPERM_SECURE_USER_READ       (1 << 5)
+#define FWPERM_SECURE_USER_CACHEABLE  (1 << 6)
+#define FWPERM_SECURE_USER_DEBUG      (1 << 7)
+
+#define FWPERM_SECURE_USER_RWCD       (FWPERM_SECURE_USER_READ | \
+									   FWPERM_SECURE_USER_WRITE | \
+									   FWPERM_SECURE_USER_CACHEABLE | \
+									   FWPERM_SECURE_USER_DEBUG)
+
+#define FWPERM_NON_SECURE_PRIV_WRITE      (1 << 8)
+#define FWPERM_NON_SECURE_PRIV_READ       (1 << 9)
+#define FWPERM_NON_SECURE_PRIV_CACHEABLE  (1 << 10)
+#define FWPERM_NON_SECURE_PRIV_DEBUG      (1 << 11)
+
+#define FWPERM_NON_SECURE_PRIV_RWCD       (FWPERM_NON_SECURE_PRIV_READ | \
+										   FWPERM_NON_SECURE_PRIV_WRITE | \
+										   FWPERM_NON_SECURE_PRIV_CACHEABLE | \
+										   FWPERM_NON_SECURE_PRIV_DEBUG)
+
+#define FWPERM_NON_SECURE_USER_WRITE      (1 << 12)
+#define FWPERM_NON_SECURE_USER_READ       (1 << 13)
+#define FWPERM_NON_SECURE_USER_CACHEABLE  (1 << 14)
+#define FWPERM_NON_SECURE_USER_DEBUG      (1 << 15)
+
+#define FWPERM_NON_SECURE_USER_RWCD       (FWPERM_NON_SECURE_USER_READ | \
+										   FWPERM_NON_SECURE_USER_WRITE | \
+										   FWPERM_NON_SECURE_USER_CACHEABLE | \
+										   FWPERM_NON_SECURE_USER_DEBUG)
+
+#endif

-- 
2.41.0

