Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA9CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6F08466E;
	Mon, 11 May 2026 22:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="LcB39MmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F1483FEC; Mon, 11 May 2026 22:13:20 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8848C84653
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026051120131549bd1ff49b000207be for <u-boot@lists.denx.de>;
 Mon, 11 May 2026 22:13:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0fRolhRQsPQoh2Aks726fHDdkPdXdLdOrfPiitHZUlw=;
 b=LcB39MmSxkb72k01ir5osJtheKlst+fpyt2EHFULq/Q49044fB42JDNJNTOdcGcob8EMBJ
 JYIjqCdfCNwzalPKYWBG2hXw2bkoqGOJ04zqSCD762oXh67B9drQMq5R+m7zNwqjKtVChHpc
 VQgobW5VXsv6BJJ2F+rV2B9c7L2Ytr9TOuYlJRarQ0pDeQgtqqJb8oHbDJnfsR5Z15KZlb/6
 ztlIYW9ZA6EAgKHXfB2fURj55RkkHXkZcikd2z4t0KsnyOhWSSyW26E1H4njK4rEBVcJGcvk
 D8v9Hs4pzPp99HbHi8KK8H8rWwzqqmuInJSzB99hIDI5XAOam5zGpjqw==;
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
Subject: [PATCH 3/4] common: Make TI K3 get_reset_reason() a weak global
Date: Mon, 11 May 2026 22:12:32 +0200
Message-ID: <20260511201235.1066697-4-alexander.sverdlin@siemens.com>
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

Make TI K3 get_reset_reason() a model for other SoCs/platforms by providing
a weak global function. It will be used to populate /chosen/reset-reason
property in the FDT.

No change in behaviour expected.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 arch/arm/mach-k3/am62x/boot.c            |  1 +
 arch/arm/mach-k3/am64x/boot.c            |  1 +
 arch/arm/mach-k3/common.c                |  5 -----
 arch/arm/mach-k3/include/mach/hardware.h |  1 -
 common/board_info.c                      |  5 +++++
 include/init.h                           | 11 +++++++++++
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index bae53f1e459..8c46532113a 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
index a5a6fe2659c..e9677d63471 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b0a75988714..87ed134fcb9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -212,11 +212,6 @@ static const char *get_device_type_name(void)
 	}
 }
 
-__weak const char *get_reset_reason(void)
-{
-	return NULL;
-}
-
 int print_cpuinfo(void)
 {
 	struct udevice *soc;
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 81b5f1fa45e..fc7bee4d00b 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -125,5 +125,4 @@ struct rom_extended_boot_data {
 };
 
 u32 get_boot_device(void);
-const char *get_reset_reason(void);
 #endif /* _ASM_ARCH_HARDWARE_H_ */
diff --git a/common/board_info.c b/common/board_info.c
index dc26e1a33dd..e76d4cbbc2f 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -14,6 +14,11 @@ int __weak checkboard(void)
 	return 0;
 }
 
+__weak const char *get_reset_reason(void)
+{
+	return NULL;
+}
+
 static const struct to_show {
 	const char *name;
 	enum sysinfo_id id;
diff --git a/include/init.h b/include/init.h
index c31ebd83b85..3ee35130268 100644
--- a/include/init.h
+++ b/include/init.h
@@ -238,6 +238,17 @@ int init_cache_f_r(void);
  */
 int print_cpuinfo(void);
 #endif
+
+/**
+ * get_reset_reason() - return a string describing the reset cause
+ *
+ * Platforms can override this weak function to provide the actual
+ * reset reason.
+ *
+ * Return: reason string, or NULL if unknown/unsupported
+ */
+const char *get_reset_reason(void);
+
 int timer_init(void);
 
 #if defined(CONFIG_DTB_RESELECT)
-- 
2.52.0

