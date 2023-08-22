Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F3CEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 01:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBAB86EE9;
	Tue, 22 Aug 2023 03:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bH+rX0fH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hU5lod3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16DE871BA; Tue, 22 Aug 2023 03:47:35 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8768A86997
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 03:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RVC041b3Pz9t5k;
 Tue, 22 Aug 2023 03:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692668852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iV29yf8tFkxd+nygN8991e6R3B8V9LndcVshumr06Cc=;
 b=bH+rX0fHb+U6sw/JqwfdtYzBD3kDYeb7L2XHAjIU4z7xETaQPqb6NfGCuCxWMgkg/6dBzF
 a8yhgrXs98ZQ1oN/af/CrObDVxe3PzX0wUxm6tRpgT5My4dLuOCMimUXbw/fbDksoG4mpz
 TSzT9FFhed2kDMgO0mGQA1OEYOvsC+mk7iFEZ38pkd9VP1+TNGqfeoTIj+E/hFXmDn7LJ6
 9H4XRk1Cfd228XcSAG0V7lrmcSs7rIm2DI3XLD1dnbLlfNGEBq1Vj/yKkHOXTR5p+mWg6Z
 7xJrdOLTrLwAGCZViCNjp+XXIm2Oha61fPbzoB/VaJF3XkV5tALogH11YDhtjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692668849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iV29yf8tFkxd+nygN8991e6R3B8V9LndcVshumr06Cc=;
 b=hU5lod3a2vz7bx4riEHtv0NltFMhWW6rZJGw1QvLVki8h6AMpWO5OG599DDSydpPQEQ+io
 iwhbcgfSFIWNXib1GOuutsZRvJMd0NnfpTxGDLLbMvEaHZsZTksl5bC74XTZmQDCh8xbAf
 4x8dRc9T6/0WSF5/BZIoBjd2hnctXIsZ0JvOqttAk5qLEeez05G2aIJ+LiI6TAIWrYUKVs
 xSrCxDloXKRmW47LFN/iYI+FUeAEFv5lOZGflj4+eaeVPMJRUBJAoP/VhaPy5zMZ/lVaOg
 Li+rJH2rFagD6fk9qHBJ+U6SiGkVL5fuU2sywwjhXvndQNPd4YO8hWZLDBWEdQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] ufs: ufs-renesas: Add support for Renesas R-Car UFS controller
Date: Tue, 22 Aug 2023 03:47:13 +0200
Message-Id: <20230822014713.138131-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0112760d4a83f4dc3d6
X-MBO-RS-META: mqaubmiaxxat3cfoui6xjat7ytrsfzk4
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

Add support for Renesas R-Car UFS controller which needs vendor-specific
initialization.

Ported from Linux kernel as of commit
c2ab666072bc ("scsi: ufs: Explicitly include correct DT includes")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/ufs/Kconfig       |   9 +
 drivers/ufs/Makefile      |   1 +
 drivers/ufs/ufs-renesas.c | 413 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 drivers/ufs/ufs-renesas.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 69ea18edf8d..0e0cc58e3d6 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -21,4 +21,13 @@ config TI_J721E_UFS
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config UFS_RENESAS
+	bool "Renesas specific hooks to UFS controller platform driver"
+	depends on UFS
+	select BOUNCE_BUFFER
+	help
+	  This selects the Renesas specific additions to UFSHCD platform driver.
+	  UFS host on Renesas needs some vendor specific configuration before
+	  accessing the hardware.
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 62ed0166084..4f3344fd4e4 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
+obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
new file mode 100644
index 00000000000..f6086050cde
--- /dev/null
+++ b/drivers/ufs/ufs-renesas.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Renesas UFS host controller driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <clk.h>
+#include <common.h>
+#include <dm.h>
+#include <ufs.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+
+#include "ufs.h"
+
+struct ufs_renesas_priv {
+	struct clk_bulk clks;
+	bool initialized;	/* The hardware needs initialization once */
+};
+
+enum {
+	SET_PHY_INDEX_LO = 0,
+	SET_PHY_INDEX_HI,
+	TIMER_INDEX,
+	MAX_INDEX
+};
+
+enum ufs_renesas_init_param_mode {
+	MODE_RESTORE,
+	MODE_SET,
+	MODE_SAVE,
+	MODE_POLL,
+	MODE_WAIT,
+	MODE_WRITE,
+};
+
+#define PARAM_RESTORE(_reg, _index) \
+		{ .mode = MODE_RESTORE, .reg = _reg, .index = _index }
+#define PARAM_SET(_index, _set) \
+		{ .mode = MODE_SET, .index = _index, .u.set = _set }
+#define PARAM_SAVE(_reg, _mask, _index) \
+		{ .mode = MODE_SAVE, .reg = _reg, .mask = (u32)(_mask), \
+		  .index = _index }
+#define PARAM_POLL(_reg, _expected, _mask) \
+		{ .mode = MODE_POLL, .reg = _reg, .u.expected = _expected, \
+		  .mask = (u32)(_mask) }
+#define PARAM_WAIT(_delay_us) \
+		{ .mode = MODE_WAIT, .u.delay_us = _delay_us }
+
+#define PARAM_WRITE(_reg, _val) \
+		{ .mode = MODE_WRITE, .reg = _reg, .u.val = _val }
+
+#define PARAM_WRITE_D0_D4(_d0, _d4) \
+		PARAM_WRITE(0xd0, _d0),	PARAM_WRITE(0xd4, _d4)
+
+#define PARAM_WRITE_800_80C_POLL(_addr, _data_800)		\
+		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
+		PARAM_WRITE_D0_D4(0x00000800, ((_data_800) << 16) | BIT(8) | (_addr)), \
+		PARAM_WRITE(0xd0, 0x0000080c),			\
+		PARAM_POLL(0xd4, BIT(8), BIT(8))
+
+#define PARAM_RESTORE_800_80C_POLL(_index)			\
+		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
+		PARAM_WRITE(0xd0, 0x00000800),			\
+		PARAM_RESTORE(0xd4, (_index)),			\
+		PARAM_WRITE(0xd0, 0x0000080c),			\
+		PARAM_POLL(0xd4, BIT(8), BIT(8))
+
+#define PARAM_WRITE_804_80C_POLL(_addr, _data_804)		\
+		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
+		PARAM_WRITE_D0_D4(0x00000804, ((_data_804) << 16) | BIT(8) | (_addr)), \
+		PARAM_WRITE(0xd0, 0x0000080c),			\
+		PARAM_POLL(0xd4, BIT(8), BIT(8))
+
+#define PARAM_WRITE_828_82C_POLL(_data_828)			\
+		PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),	\
+		PARAM_WRITE_D0_D4(0x00000828, _data_828),	\
+		PARAM_WRITE(0xd0, 0x0000082c),			\
+		PARAM_POLL(0xd4, _data_828, _data_828)
+
+#define PARAM_WRITE_PHY(_addr16, _data16)			\
+		PARAM_WRITE(0xf0, 1),				\
+		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x18, (_data16) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x19, ((_data16) >> 8) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
+		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
+		PARAM_WRITE(0xf0, 0)
+
+#define PARAM_SET_PHY(_addr16, _data16)				\
+		PARAM_WRITE(0xf0, 1),				\
+		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
+		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
+		PARAM_WRITE_804_80C_POLL(0x1a, 0),		\
+		PARAM_WRITE(0xd0, 0x00000808),			\
+		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_LO),	\
+		PARAM_WRITE_804_80C_POLL(0x1b, 0),		\
+		PARAM_WRITE(0xd0, 0x00000808),			\
+		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_HI),	\
+		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
+		PARAM_WRITE(0xf0, 0),				\
+		PARAM_WRITE(0xf0, 1),				\
+		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
+		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
+		PARAM_SET(SET_PHY_INDEX_LO, (((_data16) & 0xff) << 16) | BIT(8) | 0x18), \
+		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_LO),	\
+		PARAM_SET(SET_PHY_INDEX_HI, ((((_data16) >> 8) & 0xff) << 16) | BIT(8) | 0x19), \
+		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_HI),	\
+		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
+		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
+		PARAM_WRITE(0xf0, 0)
+
+#define PARAM_INDIRECT_WRITE(_gpio, _addr, _data_800)		\
+		PARAM_WRITE(0xf0, _gpio),			\
+		PARAM_WRITE_800_80C_POLL((_addr), _data_800),	\
+		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
+		PARAM_WRITE(0xf0, 0)
+
+#define PARAM_INDIRECT_POLL(_gpio, _addr, _expected, _mask)	\
+		PARAM_WRITE(0xf0, _gpio),			\
+		PARAM_WRITE_800_80C_POLL((_addr), 0),		\
+		PARAM_WRITE(0xd0, 0x00000808),			\
+		PARAM_POLL(0xd4, (_expected), (_mask)),		\
+		PARAM_WRITE(0xf0, 0)
+
+struct ufs_renesas_init_param {
+	enum ufs_renesas_init_param_mode mode;
+	u32 reg;
+	union {
+		u32 expected;
+		u32 delay_us;
+		u32 set;
+		u32 val;
+	} u;
+	u32 mask;
+	u32 index;
+};
+
+/* This setting is for SERIES B */
+static const struct ufs_renesas_init_param ufs_param[] = {
+	PARAM_WRITE(0xc0, 0x49425308),
+	PARAM_WRITE_D0_D4(0x00000104, 0x00000002),
+	PARAM_WAIT(1),
+	PARAM_WRITE_D0_D4(0x00000828, 0x00000200),
+	PARAM_WAIT(1),
+	PARAM_WRITE_D0_D4(0x00000828, 0x00000000),
+	PARAM_WRITE_D0_D4(0x00000104, 0x00000001),
+	PARAM_WRITE_D0_D4(0x00000940, 0x00000001),
+	PARAM_WAIT(1),
+	PARAM_WRITE_D0_D4(0x00000940, 0x00000000),
+
+	PARAM_WRITE(0xc0, 0x49425308),
+	PARAM_WRITE(0xc0, 0x41584901),
+
+	PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),
+	PARAM_WRITE_D0_D4(0x00000804, 0x00000000),
+	PARAM_WRITE(0xd0, 0x0000080c),
+	PARAM_POLL(0xd4, BIT(8), BIT(8)),
+
+	PARAM_WRITE(REG_CONTROLLER_ENABLE, 0x00000001),
+
+	PARAM_WRITE(0xd0, 0x00000804),
+	PARAM_POLL(0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0)),
+
+	PARAM_WRITE(0xd0, 0x00000d00),
+	PARAM_SAVE(0xd4, 0x0000ffff, TIMER_INDEX),
+	PARAM_WRITE(0xd4, 0x00000000),
+	PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),
+	PARAM_WRITE_D0_D4(0x00000828, 0x08000000),
+	PARAM_WRITE(0xd0, 0x0000082c),
+	PARAM_POLL(0xd4, BIT(27), BIT(27)),
+	PARAM_WRITE(0xd0, 0x00000d2c),
+	PARAM_POLL(0xd4, BIT(0), BIT(0)),
+
+	/* phy setup */
+	PARAM_INDIRECT_WRITE(1, 0x01, 0x001f),
+	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
+	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0014),
+	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0003),
+	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
+	PARAM_INDIRECT_WRITE(7, 0x5f, 0x0003),
+	PARAM_INDIRECT_WRITE(7, 0x60, 0x0003),
+	PARAM_INDIRECT_WRITE(7, 0x5b, 0x00a6),
+	PARAM_INDIRECT_WRITE(7, 0x5c, 0x0003),
+
+	PARAM_INDIRECT_POLL(7, 0x3c, 0, BIT(7)),
+	PARAM_INDIRECT_POLL(7, 0x4c, 0, BIT(4)),
+
+	PARAM_INDIRECT_WRITE(1, 0x32, 0x0080),
+	PARAM_INDIRECT_WRITE(1, 0x1f, 0x0001),
+	PARAM_INDIRECT_WRITE(0, 0x2c, 0x0001),
+	PARAM_INDIRECT_WRITE(0, 0x32, 0x0087),
+
+	PARAM_INDIRECT_WRITE(1, 0x4d, 0x0061),
+	PARAM_INDIRECT_WRITE(4, 0x9b, 0x0009),
+	PARAM_INDIRECT_WRITE(4, 0xa6, 0x0005),
+	PARAM_INDIRECT_WRITE(4, 0xa5, 0x0058),
+	PARAM_INDIRECT_WRITE(1, 0x39, 0x0027),
+	PARAM_INDIRECT_WRITE(1, 0x47, 0x004c),
+
+	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0002),
+	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
+
+	PARAM_WRITE_PHY(0x0028, 0x0061),
+	PARAM_WRITE_PHY(0x4014, 0x0061),
+	PARAM_SET_PHY(0x401c, BIT(2)),
+	PARAM_WRITE_PHY(0x4000, 0x0000),
+	PARAM_WRITE_PHY(0x4001, 0x0000),
+
+	PARAM_WRITE_PHY(0x10ae, 0x0001),
+	PARAM_WRITE_PHY(0x10ad, 0x0000),
+	PARAM_WRITE_PHY(0x10af, 0x0001),
+	PARAM_WRITE_PHY(0x10b6, 0x0001),
+	PARAM_WRITE_PHY(0x10ae, 0x0000),
+
+	PARAM_WRITE_PHY(0x10ae, 0x0001),
+	PARAM_WRITE_PHY(0x10ad, 0x0000),
+	PARAM_WRITE_PHY(0x10af, 0x0002),
+	PARAM_WRITE_PHY(0x10b6, 0x0001),
+	PARAM_WRITE_PHY(0x10ae, 0x0000),
+
+	PARAM_WRITE_PHY(0x10ae, 0x0001),
+	PARAM_WRITE_PHY(0x10ad, 0x0080),
+	PARAM_WRITE_PHY(0x10af, 0x0000),
+	PARAM_WRITE_PHY(0x10b6, 0x0001),
+	PARAM_WRITE_PHY(0x10ae, 0x0000),
+
+	PARAM_WRITE_PHY(0x10ae, 0x0001),
+	PARAM_WRITE_PHY(0x10ad, 0x0080),
+	PARAM_WRITE_PHY(0x10af, 0x001a),
+	PARAM_WRITE_PHY(0x10b6, 0x0001),
+	PARAM_WRITE_PHY(0x10ae, 0x0000),
+
+	PARAM_INDIRECT_WRITE(7, 0x70, 0x0016),
+	PARAM_INDIRECT_WRITE(7, 0x71, 0x0016),
+	PARAM_INDIRECT_WRITE(7, 0x72, 0x0014),
+	PARAM_INDIRECT_WRITE(7, 0x73, 0x0014),
+	PARAM_INDIRECT_WRITE(7, 0x74, 0x0000),
+	PARAM_INDIRECT_WRITE(7, 0x75, 0x0000),
+	PARAM_INDIRECT_WRITE(7, 0x76, 0x0010),
+	PARAM_INDIRECT_WRITE(7, 0x77, 0x0010),
+	PARAM_INDIRECT_WRITE(7, 0x78, 0x00ff),
+	PARAM_INDIRECT_WRITE(7, 0x79, 0x0000),
+
+	PARAM_INDIRECT_WRITE(7, 0x19, 0x0007),
+
+	PARAM_INDIRECT_WRITE(7, 0x1a, 0x0007),
+
+	PARAM_INDIRECT_WRITE(7, 0x24, 0x000c),
+
+	PARAM_INDIRECT_WRITE(7, 0x25, 0x000c),
+
+	PARAM_INDIRECT_WRITE(7, 0x62, 0x0000),
+	PARAM_INDIRECT_WRITE(7, 0x63, 0x0000),
+	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
+	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
+	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0004),
+	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
+	PARAM_INDIRECT_POLL(7, 0x55, 0, BIT(6)),
+	PARAM_INDIRECT_POLL(7, 0x41, 0, BIT(7)),
+	/* end of phy setup */
+
+	PARAM_WRITE(0xf0, 0),
+	PARAM_WRITE(0xd0, 0x00000d00),
+	PARAM_RESTORE(0xd4, TIMER_INDEX),
+};
+
+static void ufs_renesas_reg_control(struct ufs_hba *hba,
+				    const struct ufs_renesas_init_param *p)
+{
+	static u32 save[MAX_INDEX];
+	int ret;
+	u32 val;
+
+	WARN_ON(p->index >= MAX_INDEX);
+
+	switch (p->mode) {
+	case MODE_RESTORE:
+		ufshcd_writel(hba, save[p->index], p->reg);
+		break;
+	case MODE_SET:
+		save[p->index] |= p->u.set;
+		break;
+	case MODE_SAVE:
+		save[p->index] = ufshcd_readl(hba, p->reg) & p->mask;
+		break;
+	case MODE_POLL:
+		ret = readl_poll_timeout(hba->mmio_base + p->reg, val,
+					 (val & p->mask) == p->u.expected,
+					 10000);
+		if (ret)
+			dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
+				__func__, ret, val, p->mask, p->u.expected);
+		break;
+	case MODE_WAIT:
+		if (p->u.delay_us > 1000)
+			mdelay(DIV_ROUND_UP(p->u.delay_us, 1000));
+		else
+			udelay(p->u.delay_us);
+		break;
+	case MODE_WRITE:
+		ufshcd_writel(hba, p->u.val, p->reg);
+		break;
+	default:
+		break;
+	}
+}
+
+static void ufs_renesas_pre_init(struct ufs_hba *hba)
+{
+	const struct ufs_renesas_init_param *p = ufs_param;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ufs_param); i++)
+		ufs_renesas_reg_control(hba, &p[i]);
+}
+
+static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
+					 enum ufs_notify_change_status status)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
+
+	if (priv->initialized)
+		return 0;
+
+	if (status == PRE_CHANGE)
+		ufs_renesas_pre_init(hba);
+
+	priv->initialized = true;
+
+	return 0;
+}
+
+static int ufs_renesas_init(struct ufs_hba *hba)
+{
+	hba->quirks |= UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS | UFSHCD_QUIRK_HIBERN_FASTAUTO;
+
+	return 0;
+}
+
+static struct ufs_hba_ops ufs_renesas_vops = {
+	.init		= ufs_renesas_init,
+	.hce_enable_notify = ufs_renesas_hce_enable_notify,
+};
+
+static int ufs_renesas_pltfm_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+static int ufs_renesas_pltfm_probe(struct udevice *dev)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(dev);
+	int err;
+
+	err = clk_get_bulk(dev, &priv->clks);
+	if (err < 0)
+		return err;
+
+	err = clk_enable_bulk(&priv->clks);
+	if (err)
+		goto err_clk_enable;
+
+	err = ufshcd_probe(dev, &ufs_renesas_vops);
+	if (err) {
+		dev_err(dev, "ufshcd_probe() failed %d\n", err);
+		goto err_ufshcd_probe;
+	}
+
+	return 0;
+
+err_ufshcd_probe:
+	clk_disable_bulk(&priv->clks);
+err_clk_enable:
+	clk_release_bulk(&priv->clks);
+	return err;
+}
+
+static int ufs_renesas_pltfm_remove(struct udevice *dev)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(dev);
+
+	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
+
+	return 0;
+}
+
+static const struct udevice_id ufs_renesas_pltfm_ids[] = {
+	{ .compatible = "renesas,r8a779f0-ufs" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(ufs_renesas) = {
+	.name		= "ufs-renesas",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_renesas_pltfm_ids,
+	.bind		= ufs_renesas_pltfm_bind,
+	.probe		= ufs_renesas_pltfm_probe,
+	.remove		= ufs_renesas_pltfm_remove,
+	.priv_auto	= sizeof(struct ufs_renesas_priv),
+};
-- 
2.40.1

