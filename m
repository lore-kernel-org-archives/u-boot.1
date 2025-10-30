Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71501CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 19:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDC983677;
	Thu, 30 Oct 2025 20:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AK/h27Qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF85836D1; Thu, 30 Oct 2025 20:08:26 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866D583642
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 20:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b6cf1a95274so1008611a12.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761851302; x=1762456102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7wzE0na+DDQIWjsMUovD8KdkUMPEo+jZ76/6sZDKEzs=;
 b=AK/h27QfjpQBVeaXMYlR+zI3cLZTptE4EnQYzXyvWuJA3y2+u9iLIEL74UW7RCZ2Kr
 Q9gs76a7/WY6Ow1+BWhuBVmEb9gG0HpyOM9VNvGcelTzWWiHroy7Yk0vTnafFzM4jZ4P
 KHU9yBSevuq7Lr8Tw/R1lGYt/G1lydLJbLNXjjNz+UmvIlgz8XaDm2CmnWBqhFNf0ov7
 Lo9ccdIKZ+K9j3AofmvRTTOZTqzpc7/nMnr7oigDvtLhZPKre/ClEC2WYKV/ZDM5ReIa
 k2aveJ2DEW1GEz6dinf0c5iPFqixyNhoNd6LjyYMEdGkWKgnnbBd+f1+MIGg8FmFKEMF
 qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761851302; x=1762456102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wzE0na+DDQIWjsMUovD8KdkUMPEo+jZ76/6sZDKEzs=;
 b=ZgcJ7pMVy6vn7Vmb+yT8RdQUvoL4g6rOpQbOk5w2YavGI/Mr2zTyny2dSjOeA0IzV4
 ZWglvolUSfNbsaxTByvBr0JGpmAxSvlcbHfvtPKQrGA+z3X8cf9oM3I8Ric7pW5lzbYi
 zIM1TKq+e7Q9Vv0PhDxOucAgRcsVEY988L7NbXxSwbbkn9KD6EnSg4MRoYJYd8egmSWr
 P6auUmq+QYinoASgYGwgNLwkqeeTyRoHuRpFZXi1lEMX9fywAMlQDUnJn8VuHVTUrEJP
 v2CFmBgKEdNKv93yycCzOiICECbB2mYoGlKf0kVQJEjCjL+wskTkiU4d1FsWw8AqnX/h
 q/tg==
X-Gm-Message-State: AOJu0YwOgCxq+crnQ5znATXejzviMt410Xm6wOUORgYHp42KhoL0PRgv
 6qHGhkVvT/o2hvUzehfy+jOk4xDxhuF0Xx/Ph1Q7N51FUI/AsKP7v+ud
X-Gm-Gg: ASbGnculykgyIE36xz8Abk54yHsokF1ln71mkjxZaCFPAH2GGTfFWycXi9ovwtC7Pqx
 4Tm/UyM6T1XLuropwNus/HnI5vBKvTsQ+AGM84N7v7piuarhbC1LZU6lRTGm/N9b+Y1j8JdBgMy
 z+I66wfKRkZe8qdcL2xdOOa1QpTTkErWI5YVeNBsl7Ofl5jPehHDJ+VcmCpkUyO0nFSbjyqtWQf
 2gV7mR8dLpL53JWACiiGL/kAx8QzlNVGdkYyiTYlPWABvmkYT5tYVq4D+hxBKyPv+NsBR5HMTH7
 BwjuM8gMKF1bxsb/7WFLfefrqGua0Q0EPkYOu8Bwt0Y7tvplYHPTH7Z58jXxbwW5BLS/NkO3cjJ
 5GGSNCUS80Us695XyfWrCCe+dO6fyOL6R7MBdxiqoNnnRZ12ibsoBhw==
X-Google-Smtp-Source: AGHT+IE0yHL8308kDN9a4g2N271YqGEGT3FZc+puuVosczkyGmpat24UgFvOjDCw7jkngaTqM1Ot2Q==
X-Received: by 2002:a17:902:d501:b0:294:f6b4:9a61 with SMTP id
 d9443c01a7336-2951a3711efmr11346005ad.12.1761851301212; 
 Thu, 30 Oct 2025 12:08:21 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2001:df0:a640:1::14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d0abe6sm194269975ad.34.2025.10.30.12.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 12:08:20 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tianling Shen <cnsztl@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
Date: Fri, 31 Oct 2025 03:07:10 +0800
Message-ID: <20251030190710.18848-1-cnsztl@gmail.com>
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
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
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
diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
new file mode 100644
index 000000000000..84a567919ebb
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
+		     SPINAND_HAS_QE_BIT,
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
-- 
2.51.1

