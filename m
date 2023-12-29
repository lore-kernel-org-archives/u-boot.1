Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F94BC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAF387AF9;
	Fri, 29 Dec 2023 11:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rAwecdNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8467487B18; Fri, 29 Dec 2023 11:46:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CE987AF9
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkmQx075614;
 Fri, 29 Dec 2023 04:46:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846808;
 bh=W/SQ9V/2vOZpQuMzkoSOcDXFkHiLwVZWyKq0C0aKxqY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=rAwecdNZ/iUZYhEjRr8QGXxlCOdQX9r/Y7iFKSola5N1qWna8zliMWhxSSvozPAnc
 oEddeeuRDXSOhvpfVBzxNQzRKYmjZMBJzggW73+pSIWzTTDSIaVZblzld0flqG6p1k
 tI5FBOOmXiJWRbB5jgHxK4yDhpzc9WvgAQqxR2yM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkmcc028176
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:48 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:48 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7i072641;
 Fri, 29 Dec 2023 04:46:45 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:28 +0530
Subject: [PATCH v7 4/9] arm: dts: k3-binman: Add k3-security.h and include
 it in k3-binman.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-4-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=4860;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Ym/j2DFuzYjCRYeP+h9A+tdo8ytiFKRIocu4pfeKBSE=;
 b=TcNOqrh2Q648UZ8fNvMLPJh5yZOCDVL/QLSUSudEhBljiXgZJEwf3ydx57a+Yc3Wa//rppfl4
 t1gEYuiEKEbBHdQjYk2Qa7thBRRJWnm9cSVifHHhdnhPzmaKaZ0MjcZ
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
 arch/arm/dts/k3-binman.dtsi | 49 ++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/k3-security.h  | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index cd9926a01696..758c8bf6ea16 100644
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
@@ -437,6 +439,53 @@
 			};
 		};
 	};
+	firewall_bg_1: template-5 {
+		control = <(FWCTRL_EN | FWCTRL_LOCK |
+					FWCTRL_BG | FWCTRL_CACHE)>;
+		permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
+		start_address = <0x0 0x0>;
+		end_address = <0xff 0xffffffff>;
+	};
+	firewall_bg_3: template-6 {
+		insert-template = <&firewall_bg_1>;
+		permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>,
+					  <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>,
+					  <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
+	};
+	firewall_armv8_atf_fg: template-7 {
+		control = <(FWCTRL_EN | FWCTRL_LOCK |
+					FWCTRL_CACHE)>;
+		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD)>;
+		start_address = <0x0 0x70000000>;
+		end_address = <0x0 0x7001ffff>;
+	};
+	firewall_armv8_optee_fg: template-8 {
+		control = <(FWCTRL_EN | FWCTRL_LOCK |
+					FWCTRL_CACHE)>;
+		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD)>;
+		start_address = <0x0 0x9e800000>;
+		end_address = <0x0 0x9fffffff>;
+	};
 
 };
 
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
2.43.0

