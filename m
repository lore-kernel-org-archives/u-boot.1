Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3EECD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 06:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330DC86C4D;
	Wed, 11 Oct 2023 08:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hgkTi26L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE9986B6D; Wed, 11 Oct 2023 08:25:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B5B86BDB
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 08:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B6PHkQ057280;
 Wed, 11 Oct 2023 01:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697005517;
 bh=9AuZ6/0gix8eIC6umK91Jz7JwIZ5ZHW7ypJKCZ++/RQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=hgkTi26LI5Ypp8thkJlFvAKN0yHUgPs+5fp6kL4RBoun74ltozcgD9QXUAM/nOsSj
 jy3SMls0hxhPND0ptLYtxW0gtF18Gvdo1CYSDCwqD13cZt2JTH6bEoZLZ7d3aVRIIY
 CK8UseizNGY/5uZK+h2Tx0TRoSsj54anM25a71RU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B6PHaC018967
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 11 Oct 2023 01:25:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 01:25:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 01:25:16 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B6P2l5005599;
 Wed, 11 Oct 2023 01:25:13 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 11 Oct 2023 11:55:00 +0530
Subject: [PATCH v4 3/8] binman: k3: Add k3-security.h and include it in
 k3-binman.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231011-binman-firewalling-v4-3-a08085d300e9@ti.com>
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
In-Reply-To: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697005502; l=3106;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=czR0WD4G/eRethcrUrXVWdCGjjqepaOKFWH/PkuK86Y=;
 b=hqgsPRF8hlpeMecGhWPT1+8Vr/I2A0OzjKfdAnoBHIy8dOcgmde+H6kbVdAKLD7Jp3FgtKThm
 +xfOyvwnLbmAp2Fw8ulkiCZfkLIfPtdbJcCm8bq8G8zEHUEk6W5p19O
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

