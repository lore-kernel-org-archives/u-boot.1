Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DAAFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565D784378;
	Mon, 27 Apr 2026 15:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="R/hf+ONU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D51842CE; Mon, 27 Apr 2026 15:59:09 +0200 (CEST)
Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de
 [46.38.245.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D48842F2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1777298341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRVozhtsbMthbOmNYWaEBCVex49/y7yVLPGwUTGPU+s=;
 b=R/hf+ONUyVM8hbgRBTGMs9CyD9SUQ7/2GJMOw0sx+hofOvMTpHilfaR+W7DnHf9G/GBahv
 h6f6fUfL+Irr6V4k4GPF+8AzABn7mo2Q7DfWtGehmcIHfoQdgvcdHtKmvkoNBuC/6lQrKd
 VPLmDdTTDIvRpujhp9SpULE6N3VfXJM=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 70136f58
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 27 Apr 2026 13:59:01 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 8/9] m68k: mcf5441x: create stub to use imx drivers
Date: Mon, 27 Apr 2026 15:58:53 +0200
Message-ID: <20260427135854.18496-8-angelo@kernel-space.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427135854.18496-1-angelo@kernel-space.org>
References: <20260427135854.18496-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some NXP imx hardware ip module as the esdhc controller are exactly the
same in some new ColdFire cpus. For the specific case, mcf5441x needs to
use the existing fsl_esdhc_imx.c driver for the esdhc device.

Create a stub to be able to use NXP "imx" serie drivers as the
fsl_esdhc_imx in the ColdFire architecture.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/Kconfig                           |  1 +
 arch/m68k/include/asm/arch-mcf5445x/clock.h | 19 +++++++++++++++++
 arch/m68k/lib/Makefile                      |  1 +
 arch/m68k/lib/clock.c                       | 23 +++++++++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 arch/m68k/include/asm/arch-mcf5445x/clock.h
 create mode 100644 arch/m68k/lib/clock.c

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ce8f577e3a..00e89bd0a62 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -62,6 +62,7 @@ config MCF5441x
 	select DM
         select DM_SERIAL
 	select ARCH_COLDFIRE
+	select CREATE_ARCH_SYMLINK
 	bool
 
 config M680x0
diff --git a/arch/m68k/include/asm/arch-mcf5445x/clock.h b/arch/m68k/include/asm/arch-mcf5445x/clock.h
new file mode 100644
index 00000000000..10ceecafcea
--- /dev/null
+++ b/arch/m68k/include/asm/arch-mcf5445x/clock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ColdFire clock support
+ *
+ * Copyright 2026 Kernelspace.
+ * Angelo Dureghello <angelo@kernel-space.org>
+ */
+
+#ifndef __CLOCK_H
+#define __CLOCK_H
+
+/* Stub to use fsl/nxp drivers. */
+enum mxc_clock {
+	MXC_ESDHC_CLK,
+};
+
+int mxc_get_clock(enum mxc_clock clk);
+
+#endif /* __CLOCK_H */
diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
index cf93715637a..9ad67c4272c 100644
--- a/arch/m68k/lib/Makefile
+++ b/arch/m68k/lib/Makefile
@@ -9,3 +9,4 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += lshrdi3.o muldi3.o ashldi3.o ashrdi3.o
 
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_ARCH_COLDFIRE) += cache.o interrupts.o time.o traps.o bdinfo.o fec.o
+obj-$(CONFIG_MCF5441x) += clock.o
diff --git a/arch/m68k/lib/clock.c b/arch/m68k/lib/clock.c
new file mode 100644
index 00000000000..5d9aeed96c3
--- /dev/null
+++ b/arch/m68k/lib/clock.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Kernelspace
+ * Angelo Dureghello <angelo@kernel-space.org>
+ */
+
+#include <config.h>
+#include <asm/arch/clock.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+/*
+ * Stub to use existing nxp/fsl drivers.
+ */
+int mxc_get_clock(enum mxc_clock clk)
+{
+	if (clk == MXC_ESDHC_CLK)
+		return gd->arch.sdhc_clk;
+
+	printf("Unsupported MXC CLK: %d\n", clk);
+
+	return 0;
+}
-- 
2.54.0

