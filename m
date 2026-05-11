Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291C0CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4EC84663;
	Mon, 11 May 2026 22:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="jx6Kmkdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AA38394E; Mon, 11 May 2026 22:13:17 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB4083C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202605112013148c5e8c859200020711 for <u-boot@lists.denx.de>;
 Mon, 11 May 2026 22:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2OFZPv+cDZ1BwZUnlcYDDVcMQiHwSXS1cI3McIT8s60=;
 b=jx6KmkdntoHwrEqChSZJfT4PU08C+k3TiBMmxRTphUDbbi15zqA53TgHsOLlaRYPXeGs8w
 6inalp0J20YHYKadQHnFPHquaSc0T18XbITuLzioD7Rpl8drWDK/PbNjBx+5HRLZn8tfBHEN
 /a0l7sahvn5PRqgLEcqKbh6J/D86DFzooXyjJ7sc3FwSzFpvwXcRebrgLx2AYBYoE+joqypG
 g1bVg5QYeoSg5s34IHHBsBKA1ZgGNhyg8M9NPYrrmnPaaF7aFaP2ZpGl/o7bBcySfwjmoJf8
 DpvZ7Y7pTpRDGnvW+IaCsFfoOdDHdqGp04bSAInLbiSntJ4NXfhS2Cuw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Ji Luo <ji.luo@nxp.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/4] arm: mach-k3: Allow for calling get_reset_reason() twice
Date: Mon, 11 May 2026 22:12:30 +0200
Message-ID: <20260511201235.1066697-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Both existing implementations of get_reset_reason() for K3 cannot be called
twice because they clear the HW register carrying the reset reason
information. Make it possible to call get_reset_reason() multiple times by
saving the reset reason in struct arch_global_data.

Up to now this wasn't an issue, because the functions were called just once
to print the reset source to the console, but it's required to save the
reset reason into the device tree in the following patches.

Clearing the RST_SRC register is simplified at the same time so that the
overall nesting in the code doesn't grow. Writing 0 to the register is NOP
anyway.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 arch/arm/include/asm/global_data.h |  3 +++
 arch/arm/mach-k3/am62x/boot.c      | 12 +++++++++---
 arch/arm/mach-k3/am64x/boot.c      | 12 +++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b2ec450f900..c2b20a1dde6 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -105,6 +105,9 @@ struct arch_global_data {
 #ifdef CONFIG_ARCH_IMX8ULP
 	bool m33_handshake_done;
 #endif
+#ifdef CONFIG_ARCH_K3
+	u32 reset_src;			/* Cached reset source register */
+#endif
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index a3a6cda6bdb..bae53f1e459 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/am62_spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static u32 __get_backup_bootmedia(u32 devstat)
 {
 	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
@@ -104,11 +107,14 @@ u32 get_boot_device(void)
 
 const char *get_reset_reason(void)
 {
-	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+	u32 reset_reason = gd->arch.reset_src;
 
-	/* After reading reset source register, software must clear it */
-	if (reset_reason)
+	if (!reset_reason) {
+		reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+		/* After reading reset source register, software must clear it */
 		writel(reset_reason, CTRLMMR_MCU_RST_SRC);
+		gd->arch.reset_src = reset_reason;
+	}
 
 	if (reset_reason == 0 ||
 	   (reset_reason & (RST_SRC_SW_MAIN_POR_FROM_MAIN |
diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
index bf8e1a5cb44..a5a6fe2659c 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static u32 __get_backup_bootmedia(u32 main_devstat)
 {
 	u32 bkup_bootmode =
@@ -106,11 +109,14 @@ u32 get_boot_device(void)
 
 const char *get_reset_reason(void)
 {
-	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+	u32 reset_reason = gd->arch.reset_src;
 
-	/* After reading reset source register, software must clear it */
-	if (reset_reason)
+	if (!reset_reason) {
+		reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+		/* After reading reset source register, software must clear it */
 		writel(reset_reason, CTRLMMR_MCU_RST_SRC);
+		gd->arch.reset_src = reset_reason;
+	}
 
 	if (reset_reason == 0 ||
 	    (reset_reason & (RST_SRC_SW_MAIN_POR_FROM_MAIN |
-- 
2.52.0

