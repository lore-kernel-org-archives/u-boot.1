Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBD3C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE8687E7A;
	Fri,  9 Feb 2024 13:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="gGUZwjFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEE0187E50; Fri,  9 Feb 2024 11:30:42 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF8F87E5D
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rYO9U-0002jT-A5; Fri, 09 Feb 2024 05:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=PXe94eNgSb3+bn9S7HE9tZijkGz/vqv+ZLlPBqyHGvE=; b=gGUZwjFfAYuN9SNYfuVQ
 fHbqj7FON72waKZSqqLTnS1TZcNtdfURmfW+nhfC/LOsMgcHTPU7E9tavi0uFzwebgqoqw/1hi7yN
 BO5qCKY9tC3sBtBLdOS7UDyAS5HwzLFDM2H50/pTPzpqHXP5ZqE9BB8fw7Y1GFBCCqbILwUJv2/jM
 8KNEyLm+ixWVPfCmJLbGIftQIEjHC9ggtLit0fdFb7fyfTkKDmNzy9H63fikApmnEUeckntv4hViV
 zEvHmICQoSyczcZu5PsEwyvrIQprfNvW8fZ/jBFs2WbgjTXjTkYPPxCC52uFj+jsXS8gV0E7gGChf
 4U1LAFy/5hdKuQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 1/3] imx93: Use a header for imx9_probe_mu declaration
Date: Fri,  9 Feb 2024 11:30:07 +0100
Message-ID: <20240209103009.5463-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209103009.5463-1-othacehe@gnu.org>
References: <20240209103009.5463-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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

Put imx9_probe_mu declaration in a new mu.h header file.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/include/asm/arch-imx9/mu.h | 13 +++++++++++++
 board/freescale/imx93_evk/spl.c     |  2 +-
 board/phytec/phycore_imx93/spl.c    |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-imx9/mu.h

diff --git a/arch/arm/include/asm/arch-imx9/mu.h b/arch/arm/include/asm/arch-imx9/mu.h
new file mode 100644
index 00000000000..b8604992914
--- /dev/null
+++ b/arch/arm/include/asm/arch-imx9/mu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+
+#ifndef __ARCH_IMX9_MU_H
+#define __ARCH_IMX9_MU_H
+
+#include <event.h>
+
+int imx9_probe_mu(void *ctx, struct event *event);
+
+#endif
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index be9c24fc0d9..a98ed69db88 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/imx93_pins.h>
+#include <asm/arch/mu.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
@@ -91,7 +92,6 @@ int power_init_board(void)
 }
 #endif
 
-extern int imx9_probe_mu(void *ctx, struct event *event);
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index da4b9e53594..dabc5316f33 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -7,6 +7,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
+#include <asm/arch/mu.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/trdc.h>
 #include <asm/mach-imx/boot_mode.h>
@@ -99,7 +100,6 @@ int power_init_board(void)
 	return 0;
 }
 
-extern int imx9_probe_mu(void *ctx, struct event *event);
 void board_init_f(ulong dummy)
 {
 	int ret;
-- 
2.41.0

