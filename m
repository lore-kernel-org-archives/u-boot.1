Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D856C35FF1
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6FC8197F;
	Sun, 16 Mar 2025 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V+u6EVgr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DSl7aHU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5C581A02; Sun, 16 Mar 2025 14:54:51 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C490380ECC
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZG03F3ZkJz9snn;
 Sun, 16 Mar 2025 14:54:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQLNalROf8CyXe8yEM7RXzNs73/dn2l5pGoaG1hL9oI=;
 b=V+u6EVgr/20s1MzesqEMIp9SG37qJXs3WLJSNGUoUJKxDBgEDjBV7fdchyUIA5MB1Asvgj
 7kuaxXswOmHT/+4+KK/31n4kk/GiJK8FjvMf6QbqWN21s3X8+GXr0wYTJDdEb/pwttbgiC
 yJ9R1CBZGuK8vpJi7bEH0vc3jyP/uf7/IWNqa5SSPwEXaDElNIvJKj77I6jbsZA81V+Ajf
 gqm4MODNDgGktUy6JHAHJ3JQk+D2UtscX8jICCqpA+a1OnaOm8Z42MYcDBtXLMunScGu56
 rsvQre37K/0ii3uogFo1kGbNRrXDStBD7RAQAlXfqwv90PDE2Tj20YB9jE7hfw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQLNalROf8CyXe8yEM7RXzNs73/dn2l5pGoaG1hL9oI=;
 b=DSl7aHU14ZGrD6Js0TwXRRNoKKQjN/seMmbyGYs3V0DDfpsEahKwqaCjFgctPtRyQNPXbs
 ZITsH8s6CBGzcecILaf38OKyvY9flnEyYeWKP/av5U0+8f5mBEJRE/6jF3qRadR+Pm+SHb
 B4EHiNNF5uE53o57rz3hGeWO56+LClLZ5fF79mejdyIJMFu20GnklDkr8gyCiP7qenH3ZI
 2WSfe0t4U35ckIeZmfUCFlV2rBvOla16Byat6XEfQ84kUrFJxgWhy3Xue5POBLy1sZm7lq
 1VK+XPVkpeH1bewda0fyab9g3ESX2uHA3WTEQeF/wgOjLXlv6KAmOwPdz0uWQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/7] ram: renesas: dbsc5: Make struct
 renesas_dbsc5_board_config public
Date: Sun, 16 Mar 2025 14:51:44 +0100
Message-ID: <20250316135417.7909-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kbhshdtsezmedjeycazir4cry8z6eqia
X-MBO-RS-ID: 5a6e1e6f59a054ada21
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

Make struct renesas_dbsc5_board_config {} definition public via
include/dbsc5.h, so this structure can be defined in board files
and passed into the DBSC5 DRAM driver by overriding weak function
dbsc5_get_board_data() on board level.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 48 +--------------------------
 include/dbsc5.h                  | 56 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 47 deletions(-)
 create mode 100644 include/dbsc5.h

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index c5c57858aac..6f78afb0ab5 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4,6 +4,7 @@
  */
 
 #include <asm/io.h>
+#include <dbsc5.h>
 #include <dm.h>
 #include <errno.h>
 #include <hang.h>
@@ -12,13 +13,6 @@
 #include <linux/sizes.h>
 #include "dbsc5.h"
 
-/* The number of channels V4H has */
-#define DRAM_CH_CNT			4
-/* The number of slices V4H has */
-#define SLICE_CNT			2
-/* The number of chip select V4H has */
-#define CS_CNT				2
-
 /* Number of array elements in Data Slice */
 #define DDR_PHY_SLICE_REGSET_SIZE_V4H	0x100
 /* Number of array elements in Data Slice */
@@ -1375,46 +1369,6 @@ static const u32 PI_DARRAY3_1_CSx_Fx[CS_CNT][3] = {
 
 #define CLK_DIV(a, diva, b, divb)	(((a) * (divb)) / ((b) * (diva)))
 
-struct renesas_dbsc5_board_config {
-	/* Channels in use */
-	u8 bdcfg_phyvalid;
-	/* Read vref (SoC) training range */
-	u32 bdcfg_vref_r;
-	/* Write vref (MR14, MR15) training range */
-	u16 bdcfg_vref_w;
-	/* CA vref (MR12) training range */
-	u16 bdcfg_vref_ca;
-	/* RFM required check */
-	bool bdcfg_rfm_chk;
-
-	/* Board parameter about channels */
-	struct {
-		/*
-		 * 0x00:  4Gb dual channel die /  2Gb single channel die
-		 * 0x01:  6Gb dual channel die /  3Gb single channel die
-		 * 0x02:  8Gb dual channel die /  4Gb single channel die
-		 * 0x03: 12Gb dual channel die /  6Gb single channel die
-		 * 0x04: 16Gb dual channel die /  8Gb single channel die
-		 * 0x05: 24Gb dual channel die / 12Gb single channel die
-		 * 0x06: 32Gb dual channel die / 16Gb single channel die
-		 * 0x07: 24Gb single channel die
-		 * 0x08: 32Gb single channel die
-		 * 0xFF: NO_MEMORY
-		 */
-		u8 bdcfg_ddr_density[CS_CNT];
-		/* SoC caX([6][5][4][3][2][1][0]) -> MEM caY: */
-		u32 bdcfg_ca_swap;
-		/* SoC dqsX([1][0]) -> MEM dqsY: */
-		u8 bdcfg_dqs_swap;
-		/* SoC dq([7][6][5][4][3][2][1][0]) -> MEM dqY/dm:  (8 means DM) */
-		u32 bdcfg_dq_swap[SLICE_CNT];
-		/* SoC dm -> MEM dqY/dm:  (8 means DM) */
-		u8 bdcfg_dm_swap[SLICE_CNT];
-		/* SoC ckeX([1][0]) -> MEM csY */
-		u8 bdcfg_cs_swap;
-	} ch[4];
-};
-
 struct renesas_dbsc5_dram_priv {
 	void __iomem	*regs;
 	void __iomem	*cpg_regs;
diff --git a/include/dbsc5.h b/include/dbsc5.h
new file mode 100644
index 00000000000..cec937d89e7
--- /dev/null
+++ b/include/dbsc5.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024-2025 Renesas Electronics Corp.
+ */
+
+#ifndef __INCLUDE_DBSC5_H__
+#define __INCLUDE_DBSC5_H__
+
+/* The number of channels V4H has */
+#define DRAM_CH_CNT			4
+/* The number of slices V4H has */
+#define SLICE_CNT			2
+/* The number of chip select V4H has */
+#define CS_CNT				2
+
+struct renesas_dbsc5_board_config {
+	/* Channels in use */
+	u8 bdcfg_phyvalid;
+	/* Read vref (SoC) training range */
+	u32 bdcfg_vref_r;
+	/* Write vref (MR14, MR15) training range */
+	u16 bdcfg_vref_w;
+	/* CA vref (MR12) training range */
+	u16 bdcfg_vref_ca;
+	/* RFM required check */
+	bool bdcfg_rfm_chk;
+
+	/* Board parameter about channels */
+	struct {
+		/*
+		 * 0x00:  4Gb dual channel die /  2Gb single channel die
+		 * 0x01:  6Gb dual channel die /  3Gb single channel die
+		 * 0x02:  8Gb dual channel die /  4Gb single channel die
+		 * 0x03: 12Gb dual channel die /  6Gb single channel die
+		 * 0x04: 16Gb dual channel die /  8Gb single channel die
+		 * 0x05: 24Gb dual channel die / 12Gb single channel die
+		 * 0x06: 32Gb dual channel die / 16Gb single channel die
+		 * 0x07: 24Gb single channel die
+		 * 0x08: 32Gb single channel die
+		 * 0xFF: NO_MEMORY
+		 */
+		u8 bdcfg_ddr_density[CS_CNT];
+		/* SoC caX([6][5][4][3][2][1][0]) -> MEM caY: */
+		u32 bdcfg_ca_swap;
+		/* SoC dqsX([1][0]) -> MEM dqsY: */
+		u8 bdcfg_dqs_swap;
+		/* SoC dq([7][6][5][4][3][2][1][0]) -> MEM dqY/dm:  (8 means DM) */
+		u32 bdcfg_dq_swap[SLICE_CNT];
+		/* SoC dm -> MEM dqY/dm:  (8 means DM) */
+		u8 bdcfg_dm_swap[SLICE_CNT];
+		/* SoC ckeX([1][0]) -> MEM csY */
+		u8 bdcfg_cs_swap;
+	} ch[4];
+};
+
+#endif	/* __INCLUDE_DBSC5_H__ */
-- 
2.47.2

