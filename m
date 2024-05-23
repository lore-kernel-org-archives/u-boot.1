Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D095C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2DF885D7;
	Thu, 23 May 2024 18:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PcdI78II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD3387D70; Thu, 23 May 2024 18:43:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9600F87E50
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NGhOic048088;
 Thu, 23 May 2024 11:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716482604;
 bh=KX7BPjUkzjy4OIoqTHB9y+mCDRBDzWvbO6ebgj7ghrg=;
 h=From:Date:Subject:To:CC;
 b=PcdI78II8z1rJwz3kzIJOTKBxqvvlFpanhXTdAHlOO7PLaQbhlYcNHwxqlPOGZ4vI
 ZsdmQnxi8yE46+71Y4jkdLyCDUVDjQz9WfkXFC5/A8RMvYud3+fJpP5iyVR9FbSWVE
 wNaoMHW1i2b1oSqZuPARzz6+OwvyXfUTP2n0X2I4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NGhORG123848
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 11:43:24 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 11:43:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 11:43:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NGhN1B072558;
 Thu, 23 May 2024 11:43:23 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 23 May 2024 11:43:20 -0500
Subject: [PATCH] arm: mach-k3: am62p: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
X-B4-Tracking: v=1; b=H4sIACdyT2YC/x2MQQqAIBAAvxJ7bkFFC/pKdBBdaw+ZaEQg/j3pO
 AMzFQplpgLLUCHTw4Wv2EGOA7jDxp2QfWdQQmlhlEB7Tiph8DcGfnF2RpK00nmjoTcpU9f/b91
 a+wDq7E6dXwAAAA==
To: Tom Rini <trini@konsulko.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
X-Mailer: b4 0.12.1
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

The address we load TFA and OPTEE is configurable by the
CONFIG_K3_{ATF,OPTEE)_LOAD_ADDR, but the DT node reservations remain
static which can cause some confusion about where exactly these firmware
are exactly. Fix this by updating the reserved-memory{} nodes when the
loaded address does not match the address in DT.

Reported-by: Andrew Davis <afd@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Hello everyone,

This is a little fixup to avoid any confusion once we're in the kernel. 
Because TF-A can be configured in U-Boot to be anywhere we want, we need 
up update the reserved-memory{} node with this change.

Thanks for reviewing
~Bryan
---
 arch/arm/mach-k3/Makefile       |  1 +
 arch/arm/mach-k3/am62p5_fdt.c   | 16 ++++++++++++++++
 arch/arm/mach-k3/am62px/Kconfig |  1 +
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 1bd523329a4f8..4e9d0925f13f5 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_fdt.o
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4_fdt.o
+obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_fdt.o
 endif
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
diff --git a/arch/arm/mach-k3/am62p5_fdt.c b/arch/arm/mach-k3/am62p5_fdt.c
new file mode 100644
index 0000000000000..d67f012a5dcc4
--- /dev/null
+++ b/arch/arm/mach-k3/am62p5_fdt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/hardware.h>
+#include "common_fdt.h"
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
+	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
index 38a9e6811b119..76ae86b66222f 100644
--- a/arch/arm/mach-k3/am62px/Kconfig
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -13,6 +13,7 @@ config TARGET_AM62P5_A53_EVM
 	bool "TI K3 based AM62P5 EVM running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 
 config TARGET_AM62P5_R5_EVM
 	bool "TI K3 based AM62P5 EVM running on R5"

---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240520-am62p-fdt-fix-7c51e1a1cd54

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

