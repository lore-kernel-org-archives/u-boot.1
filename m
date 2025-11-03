Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73095CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08628331F;
	Mon,  3 Nov 2025 16:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cOjj7YyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F20836D1; Mon,  3 Nov 2025 16:59:28 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DD680050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b8c0c0cdd61so4475601a12.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762185564; x=1762790364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=POwPiUwDEE+2XVlePsOqwohl91GPrBNeSATZtYf+n5M=;
 b=cOjj7YyKmyNWUfVOkZLSMiyS2EdY2WAOtWCi7SfodqVSKFnvRBK9SJ7jW9QLHWqR8D
 NrCKVi2mnc31WTkimFSugLX9FmI66nl40gjHeSvJuzFJa0eZXuD5xsZ8y0h+aDoA2S+S
 wofh9aCaIzmVkM0zgfKd7yVD0Oz/lRdo3itbu29qJprpfUTrTvqvUIlnegJ5CrHZtPIK
 tJe3szaU6ELAe1+vl2qdbWWGa4ei5eU3VdiYOEoO8Ye3to+O8YwLFF8PtbjFWhDWhmGT
 tHH0zGp/9sh/3+HZx2e/blnQI9AzOT7AUgDpWdDH27CHr25uU3pprLoObhMLnIG4dA6v
 K/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762185564; x=1762790364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=POwPiUwDEE+2XVlePsOqwohl91GPrBNeSATZtYf+n5M=;
 b=kqsJQoKMr06svYy2AgiJhTEP7GKS9DNJ0fQEybZxJTdtM25Fd/Yi+ONADTX44xLp20
 WG33W5wHRmOPB1DOBYHttaILAIW6lu46m44OVUCgxX0DFCfs4cVdJXyVEj/8UagABtRX
 a84vvJvp91Uryl0wlpp4nv4njTgH0V29xy4kNYk+qwOwe94t3AgtB5W5FC47zTpjbGmQ
 KLCcBKv9gDebHRpD0QUGm7DI1KEsMlA0z+TZsina2+FWaihrXHs+eUkDxc2p7Lr6f4dr
 hFS7z59s8zyk/tWVf6sPOxlHiKWByqwl2YVwXS9Vhb0ZZsJVF+6vGjCQpzgDgkG3/tSL
 V1Mw==
X-Gm-Message-State: AOJu0YyRDTDCoF/aVJozfI2HMykdVSF60fwTYFOYCBY9444F34o3a4l2
 CYdU8VKpsE3UWc/oXuap7mUfknuJCWctHnq1SxvaqrOZCA687N5OccZC
X-Gm-Gg: ASbGncuZ/XXQ/J81Uu/4E3ww1bddcvz8xolkTUJjEVgHlFs4QTJM5k55enA4L4qcgbz
 bz/9HTGTn8fL1ntYlrUSegOda6E5blzMhYXUlkVMxuAQIN8XrdqOpaYdieAC0fBLGKCwG0p59TL
 r242qGeU1ekaiZkllDWBNQzzs7JpGLnmr8KeiJ/DkzFOQw/92F8+nAjyPbS4C8Gbm0hZvC7ftLy
 nkIv2hsDpvsqV0fZjv7+2DHs+skYyeomjNdIJX3HQV6cN4sjc0zT24fj6VYrySKXMsmX7hw091P
 yInToYuoSPJx21fBVfQutTD6rpEitM+FbbWA6B5W07WXIeus3NQFjnfRW8XuDJYJBqOKRDuVzNU
 awBRD0psszHyyIJqpVInsmcmsEGav9+rIrB7vII/IOxNMnFmEjd4UC1QxdraSTMa4
X-Google-Smtp-Source: AGHT+IF3JOoEkuV8fM290UBR3vrFIwEEpUrMHb4dYy5ZWKOxBSnQGisKIuzkH6SfKsF+lpHQf2m+xQ==
X-Received: by 2002:a17:903:2341:b0:295:557e:7465 with SMTP id
 d9443c01a7336-295557e798emr119642095ad.11.1762185563240; 
 Mon, 03 Nov 2025 07:59:23 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2001:df0:a640:1::15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340b4296178sm5884875a91.0.2025.11.03.07.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:59:22 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tianling Shen <cnsztl@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] mtd: spinand: add support for FudanMicro FM25S01A
Date: Mon,  3 Nov 2025 23:59:17 +0800
Message-ID: <20251103155917.2659427-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.1
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

Add support for FudanMicro FM25S01A SPI NAND.

This driver is ported from linux v6.18 and tested on a MT7981 board.

Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

Changes in v3:
- Remove unsupported QE bit
- Collect R-b tag

Changes in v2:
- add fmsh manufacturer to core files

---
 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/core.c   |  1 +
 drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 4 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/fmsh.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 152aa1a3783c..a7a0b2cb4b9e 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o otp.o
-spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0c4350595469..14af42646122 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1227,6 +1227,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&alliancememory_spinand_manufacturer,
 	&ato_spinand_manufacturer,
 	&esmt_c8_spinand_manufacturer,
+	&fmsh_spinand_manufacturer,
 	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
new file mode 100644
index 000000000000..80837b7dd424
--- /dev/null
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
+ *
+ * Author: Dingqiang Lin <jon.lin@rock-chips.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_FMSH		0xA1
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
+	.ecc = fm25s01a_ooblayout_ecc,
+	.rfree = fm25s01a_ooblayout_free,
+};
+
+static const struct spinand_info fmsh_spinand_table[] = {
+	SPINAND_INFO("FM25S01A",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer fmsh_spinand_manufacturer = {
+	.id = SPINAND_MFR_FMSH,
+	.name = "Fudan Micro",
+	.chips = fmsh_spinand_table,
+	.nchips = ARRAY_SIZE(fmsh_spinand_table),
+	.ops = &fmsh_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index cf9b9656d054..e9561c0a3956 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -361,6 +361,7 @@ struct spinand_manufacturer {
 extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
 extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
-- 
2.51.1

