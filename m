Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BBC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A13C876F7;
	Wed,  6 Dec 2023 10:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xkVfAGlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EFF86590; Wed,  6 Dec 2023 10:51:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14C787682
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pguq031464;
 Wed, 6 Dec 2023 03:51:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701856302;
 bh=Hqkm5Xa7aFomAIsexe1XRyID7l47Y1w9IRtxt3G/vck=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=xkVfAGlTBaK75+/3H70hRVO3uArddEKWPVVbGP7Qu6s5Cydf6OjEguBexWVFMFGaF
 6YvaJNRZ+sVEUPIAkSAhlCRD/IwmHNNRimkXu1Ir5Vxj1ypDv9/dmP7GRz1bnCsP8M
 kLtjchuOaXh/qQPAprhs8r1HJBgXIEyU7lh03LL4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B69pgKm111597
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 03:51:42 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 03:51:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 03:51:41 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pQBZ039003;
 Wed, 6 Dec 2023 03:51:38 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 6 Dec 2023 15:21:25 +0530
Subject: [PATCH v6 3/8] binman: k3: Add k3-security.h and include it in
 k3-binman.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231206-binman-firewalling-v6-3-e7fce13a6dc1@ti.com>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
In-Reply-To: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701856286; l=3106;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=tevLs81SE/l8rDhXoaVLTh6y/iLCc/983RbSO+oA0AE=;
 b=Tph//xvtjaas2eMJyuRwrGoI9KOaPJGBq6kn4L/q1VqAzsMFPzcI0yiRfmZ9jfrn7bfoDZN7p
 8qsKsCzDDvjBIeKMnXAJtY38wlQDnPLHvQbungEQu3tzaKd+MEnIYKr
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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
index c7513e1a5dd7..b160192d18bf 100644
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

