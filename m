Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BC7C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690BB8081A;
	Wed, 30 Apr 2025 15:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uy6KxM1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA0781E72; Wed, 30 Apr 2025 15:58:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE50807B1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UDwEuv4141793
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 08:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746021494;
 bh=22tt7uspQQzJsrWzVNT9AK91ual5bv0oh1talbSaxok=;
 h=From:To:CC:Subject:Date;
 b=uy6KxM1J5q+BaDc8fAXKj88SUOPmLUIJ1LuWVoxMzcLa9SyPO5rfgaSwBlmFUK9F+
 dwhw4DZq2cBwQaraDMDD4BmUY+6YzOLSjFZ4Z+kvIaEpSp94rIC2gwQx/679f1pkB0
 8l655lxwc+DhEWQHoe8EvBAspH15vQG67/+y98K4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UDwEGi100772
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 08:58:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 08:58:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 08:58:14 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UDwDq6011863;
 Wed, 30 Apr 2025 08:58:13 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] arm: add call to cleanup_before_linux for go command
Date: Wed, 30 Apr 2025 19:27:50 +0530
Message-ID: <20250430135751.2626849-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

As discussed here[1], the go command causes undefined behavior when used
for running custom OSes since the icache might hold outdated data. OSes
usually also expect the MMU to be disabled upon execution.

Therefore this patch adds a call to cleanup_before_linux before we jump
to the loaded program/os which disables both the caches and the MMU.
This makes the go command's behavior consistent with riscv platforms.

NOTE: This might cause regressions with users expecting a configured MMU
but I'm unsure if it's a supported use case for the go command anyway.

[1]: https://lore.kernel.org/u-boot/D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/lib/Makefile |  1 +
 arch/arm/lib/boot.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/lib/boot.c

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 74cd5051552..e4cb50a7f71 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -24,6 +24,7 @@ endif
 ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_ARM64
 obj-y	+= relocate_64.o
+obj-y	+= boot.o
 else
 obj-y	+= relocate.o
 endif
diff --git a/arch/arm/lib/boot.c b/arch/arm/lib/boot.c
new file mode 100644
index 00000000000..eafdb0f9e5a
--- /dev/null
+++ b/arch/arm/lib/boot.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Anshul Dalal, <anshuld@ti.com>
+ */
+
+#include <command.h>
+#include <asm/u-boot-arm.h>
+
+unsigned long do_go_exec(ulong (*entry)(int, char *const[]), int argc,
+			 char *const argv[])
+{
+	cleanup_before_linux();
+
+	return entry(argc, argv);
+}
-- 
2.49.0

