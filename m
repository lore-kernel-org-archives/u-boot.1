Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32EBC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984D48770F;
	Mon, 15 Jan 2024 15:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GlzPWCaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE0E87753; Mon, 15 Jan 2024 15:07:24 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085FB86C39
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FBDdEO005244; Mon, 15 Jan 2024 15:07:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=35I5YtF5e4wxcD4daEHrcdNSmPnKGHYb6eZ1tor/F48=; b=Gl
 zPWCaTIzu/k/NmgCgya0GhWVuIGC8Vd/YaD65RtT3dI1mx47Xd99ThCC4YSxatUk
 PTZdVae4vckEaM1QLhwQzT4xBq08FkERyjRgAxMjz3hnwGn9B+NA+mJ2fyDl0AOc
 dPEomk2s2rXq+BHed1upkZIO/IQUXM/hWs1QkLKjj6l9CoyQkM+PMmdzjBQ0/FJq
 WoLZW+Kl7XigHhOGoTXZ1AN4uqhsquQVaKTryt5WUW2nrQknu8t5a+9Wi6BYX5KD
 jXpivJBv6NfpBVqQ7/iemLCha94m5PWZAZZ4HERL4yB/+Vcpl8g6eaUeXxsbKj1R
 +MRaKJbN0BNf3Ew1i4yA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfy90wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:07:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DAAE10002A;
 Mon, 15 Jan 2024 15:07:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 01D0C298667;
 Mon, 15 Jan 2024 15:07:20 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:07:19 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 06/14] stm32mp: add soc.c file
Date: Mon, 15 Jan 2024 15:05:49 +0100
Message-ID: <20240115150451.v2.6.I175b5b047ccdb4198f1ae11bac19411617623518@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

Add a new file soc.c for common functions between stm32mp1 and stm32mp2
family and move print_cpuinfo() in this new file.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 arch/arm/mach-stm32mp/Makefile       |  1 +
 arch/arm/mach-stm32mp/soc.c          | 17 +++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 11 -----------
 arch/arm/mach-stm32mp/stm32mp2/cpu.c | 11 -----------
 4 files changed, 18 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/soc.c

diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
index 00dc25bb275c..fdcbbf91dfd5 100644
--- a/arch/arm/mach-stm32mp/Makefile
+++ b/arch/arm/mach-stm32mp/Makefile
@@ -6,6 +6,7 @@
 obj-y += dram_init.o
 obj-y += syscon.o
 obj-y += bsec.o
+obj-y += soc.o
 
 obj-$(CONFIG_STM32MP15x) += stm32mp1/
 obj-$(CONFIG_STM32MP13x) += stm32mp1/
diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
new file mode 100644
index 000000000000..8d5fa474ccaf
--- /dev/null
+++ b/arch/arm/mach-stm32mp/soc.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
+ */
+
+#include <asm/arch/sys_proto.h>
+
+/* used when CONFIG_DISPLAY_CPUINFO is activated */
+int print_cpuinfo(void)
+{
+	char name[SOC_NAME_SIZE];
+
+	get_soc_name(name);
+	printf("CPU: %s\n", name);
+
+	return 0;
+}
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 55574fd4bebf..00fea7929b2f 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -158,17 +158,6 @@ void enable_caches(void)
 	dcache_enable();
 }
 
-/* used when CONFIG_DISPLAY_CPUINFO is activated */
-int print_cpuinfo(void)
-{
-	char name[SOC_NAME_SIZE];
-
-	get_soc_name(name);
-	printf("CPU: %s\n", name);
-
-	return 0;
-}
-
 static void setup_boot_mode(void)
 {
 	const u32 serial_addr[] = {
diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
index f43d1aaf72cc..c0f6519e8d7c 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
@@ -67,17 +67,6 @@ void enable_caches(void)
 	dcache_enable();
 }
 
-/* used when CONFIG_DISPLAY_CPUINFO is activated */
-int print_cpuinfo(void)
-{
-	char name[SOC_NAME_SIZE];
-
-	get_soc_name(name);
-	printf("CPU: %s\n", name);
-
-	return 0;
-}
-
 int arch_misc_init(void)
 {
 	return 0;
-- 
2.25.1

