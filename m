Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C5C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49E687D6D;
	Fri,  2 Feb 2024 01:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WFChn8QY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0511787D6D; Fri,  2 Feb 2024 01:25:00 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E3E87D69
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4120Ophr013020;
 Thu, 1 Feb 2024 18:24:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706833491;
 bh=coj68Ff3e78r33LK+vxJZSnJ4FTqW3jCZz0bwmclHKc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WFChn8QYrFDvlS9giK3rg998cUeindYRj/dBzbRUxcZqJAEwC9NkZX6P8M4Uu75tN
 /EPX3WLsJow5USkVBiQ63Ciz2ymvux/iPtP2H/DoxivfpwBLg6XjbwVtlyz07ocWRi
 Y2ooyTezkrEJCrFgJHIZ5AYOs/72ji6LVcNJ2GH0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4120OpMk003219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 18:24:51 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 18:24:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 18:24:51 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4120OnBl107441;
 Thu, 1 Feb 2024 18:24:50 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 6/6] arm: mach-k3: Move ARM64 specific code into new arm64
 directory
Date: Thu, 1 Feb 2024 18:24:48 -0600
Message-ID: <20240202002448.1116407-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
References: <20240202002448.1116407-1-afd@ti.com>
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

Like we did with R5, move ARM64 code into a specific directory to make
it clear what code is only meant to run on each core type.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Makefile                | 3 +--
 arch/arm/mach-k3/arm64/Makefile          | 6 ++++++
 arch/arm/mach-k3/{ => arm64}/arm64-mmu.c | 0
 arch/arm/mach-k3/{ => arm64}/cache.S     | 0
 4 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-k3/arm64/Makefile
 rename arch/arm/mach-k3/{ => arm64}/arm64-mmu.c (100%)
 rename arch/arm/mach-k3/{ => arm64}/cache.S (100%)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 42161376469..55c36161b63 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -3,9 +3,8 @@
 # Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
+obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
-obj-$(CONFIG_ARM64) += arm64-mmu.o
-obj-$(CONFIG_ARM64) += cache.o
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
 ifeq ($(CONFIG_OF_LIBFDT)$(CONFIG_OF_SYSTEM_SETUP),yy)
 obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
diff --git a/arch/arm/mach-k3/arm64/Makefile b/arch/arm/mach-k3/arm64/Makefile
new file mode 100644
index 00000000000..f3d322e17f8
--- /dev/null
+++ b/arch/arm/mach-k3/arm64/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+
+obj-y += arm64-mmu.o
+obj-y += cache.o
diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
similarity index 100%
rename from arch/arm/mach-k3/arm64-mmu.c
rename to arch/arm/mach-k3/arm64/arm64-mmu.c
diff --git a/arch/arm/mach-k3/cache.S b/arch/arm/mach-k3/arm64/cache.S
similarity index 100%
rename from arch/arm/mach-k3/cache.S
rename to arch/arm/mach-k3/arm64/cache.S
-- 
2.39.2

