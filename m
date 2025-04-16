Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1CAC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BAA82CBC;
	Wed, 16 Apr 2025 09:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jwchnnaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545DE82CE7; Wed, 16 Apr 2025 09:31:22 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87E982CCF
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VHG82703773
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744788677;
 bh=VzwZx3CYPaywtsbWx3w4g6dq2jGlqd8NjsvBYL4sJi0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jwchnnaZ3S5jBHE1saRSoZcXaXA2u/Vs5LTdBMFS3DHvlPncpC63fAWRTEk75sa+F
 XV+h/eH7olWIKbQfdpPoZPaBhQEwjaKstGLr5yeiGlI3P4usUfuzSx1ifUWnHiakEa
 inPKw2YBP9Mdl2fp/GNs8xM4IwT6iXyWCQ29NKT8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VH05120771
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:31:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:31:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:31:17 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7VGSg057947;
 Wed, 16 Apr 2025 02:31:16 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: [PATCH v1 2/4] mach-k3: add a jump stub to support older ATF builds
Date: Wed, 16 Apr 2025 13:00:55 +0530
Message-ID: <20250416073058.1441001-3-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416073058.1441001-1-anshuld@ti.com>
References: <20250416073058.1441001-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The older ATF had it's PRELOADED_BL33_BASE set to 0x80080000, changing
SPL_TEXT_BASE to the newer address of 0x822000000 is incompatible with
older ATF builds.

Therefore, this patch adds a jump stub to move execution back to
SPL_TEXT_BASE with the stub being loaded at the older ATF address of
0x80080000.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/Makefile    |  7 +++++++
 arch/arm/mach-k3/jump_stub.S | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm/mach-k3/jump_stub.S

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67..573956a8a2c 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -17,3 +17,10 @@ obj-$(CONFIG_SOC_K3_J7200) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
+
+ifdef CONFIG_ARM64
+obj-y += jump_stub.o
+$(src)/jump_stub.o: $(src)/jump_stub.s
+	$(AS) $(src)/jump_stub.s -o $(src)/jump_stub.o
+	$(OBJCOPY) -O binary --only-section .text $(src)/jump_stub.o jump_stub.bin
+endif
diff --git a/arch/arm/mach-k3/jump_stub.S b/arch/arm/mach-k3/jump_stub.S
new file mode 100644
index 00000000000..694d4ee47a6
--- /dev/null
+++ b/arch/arm/mach-k3/jump_stub.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *	Anshul Dalal <anshuld@ti.com>
+ */
+
+/*
+	This jump stub is to be loaded at the older PRELOADED_BL33_BASE to forward
+	execution to SPL_TEXT_BASE when using older ATF builds.
+ */
+
+.text
+
+jump_stub:
+	mov x15, CONFIG_SPL_TEXT_BASE
+	br x15
-- 
2.49.0

