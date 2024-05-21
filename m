Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E44C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4F68874F;
	Tue, 21 May 2024 12:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bygX7Jk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3478874F; Tue, 21 May 2024 12:57:19 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662EA8875E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LAv6Ri011507;
 Tue, 21 May 2024 05:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716289026;
 bh=q3CEOC57Z8oUwXt58QLa9uxxBvev+38A2M6KMrGBpWY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bygX7Jk87abl8AcEogZHoWy7/TzEqcFQkZnVQFAxBm0gH85Gz3xy87aKd+AeOSmkR
 UIqCrtfxJuNVhfaphVKsVdLWKIgP3wuBiAG53rWS5cF7d1HhWLarJEI5Okc8HjZdSK
 B6W2BuZpBflP2o5yNAbObWrY2P+/+jaJrxMo0n/0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LAv63H013175
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 05:57:06 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 05:57:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 05:57:05 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LAurAg047424;
 Tue, 21 May 2024 05:57:00 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <trini@konsulko.com>
CC: <joe.hershberger@ni.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <emanuele.ghidoli@toradex.com>,
 <matthias.schiffer@ew.tq-group.com>, <a-bhatia1@ti.com>,
 <vitor.soares@toradex.com>, <danishanwar@ti.com>,
 <andriy.shevchenko@linux.intel.com>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <joao.goncalves@toradex.com>,
 <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 1/4] include: mach-k3: move k3 security functions to security.h
Date: Tue, 21 May 2024 16:26:45 +0530
Message-ID: <20240521105648.3780072-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521105648.3780072-1-u-kumar1@ti.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Manorit Chawdhry <m-chawdhry@ti.com>

ti_secure_image_post_process and ti_secure_image_check_binary is used
for the authentication purposes in the current boot flow. Authentication
of remoteproc firmware images require ti_secure_image_post_process to be
available outside mach-k3.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/common.h                |  4 ++--
 arch/arm/mach-k3/include/mach/security.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/security.h

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 53aa186b31..7bd72da1de 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -2,12 +2,13 @@
 /*
  * K3: Architecture common definitions
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
 #include <asm/armv7_mpu.h>
 #include <asm/hardware.h>
+#include <mach/security.h>
 
 #define K3_FIREWALL_BACKGROUND_BIT (8)
 
@@ -41,7 +42,6 @@ void spl_enable_cache(void);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
 enum k3_device_type get_device_type(void);
-void ti_secure_image_post_process(void **p_image, size_t *p_size);
 struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
diff --git a/arch/arm/mach-k3/include/mach/security.h b/arch/arm/mach-k3/include/mach/security.h
new file mode 100644
index 0000000000..8502b57bd8
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/security.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3: Security related definitions
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *	Manorit Chawdhry <m-chawdhry@ti.com>
+ */
+
+#include <linux/types.h>
+
+void ti_secure_image_post_process(void **p_image, size_t *p_size);
-- 
2.34.1

