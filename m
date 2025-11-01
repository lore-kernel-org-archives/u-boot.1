Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CBCCCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 05:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182CA83A47;
	Sat,  1 Nov 2025 06:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bscBtpjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B46D83A5A; Sat,  1 Nov 2025 06:19:52 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A924D83A2B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 06:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7a4c202a30aso3218770b3a.2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761974388; x=1762579188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vPeN2BzbcUaobsEsFVAK33Yrze6N+cteUiYjrBi2ZPs=;
 b=bscBtpjB7f5/d5LkX2IKeFDEXgqBSylO3nCQY1/XmNnMhsCyCP6uUpknbLZw2TzGD3
 CkeVDy8RQsdm7GhVwWGJ20h0v7+T9tEOJ2PHX85COiIcc0+PnPPuTB3om9QmynM6VfAk
 yGXmBR/3bwAQqCU+VohlouvOFGtVBuyinDjz7Oi5t6HKRiDwWRxB2uSBswFSjTbsmFKY
 RUzG7pT6dImxFFZzoa04mN+oHf6bYhRQhVxGi7+NoZF0ue22qB40vrYwDGtpPdcGyxcY
 wjzhmdVZG8YBsSauRjvbWGk4OJ7ky2CcmPT/K0uYPDj8prXOdPZVl+7sWJX3UPDA1uMI
 G69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761974388; x=1762579188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vPeN2BzbcUaobsEsFVAK33Yrze6N+cteUiYjrBi2ZPs=;
 b=nBgt20V6IwimkeVDN8RRsjyO27Rrc3WhMi1RFL3+rUYS77nBCIMqrXRpOGLnACQ01j
 rg6d0RlMr0EwJQk4hcIp+yaMfkc/LBHdiLtlpTbP7nGajEEv8DzZEJnBm9+lAX2ZyLXV
 30O/yTmF5Nezei8Xrqq5cz9lpgJnVmH0byO6wAWFhrJDcgqXqm9GjzwY5qTZE3sxBTw7
 36NM7U3Yn8qOyfppKsxwkik8efF6MqudEUum31vh93VJFvUkmh6wKQbB7VTkdxUKka75
 jCvdgDHcKa4sMr0R1EEyil8acnoVwiFWQXthvXiwQ/K/a5TBg2Kjxt8QH+R8MOv8AVxv
 SK2A==
X-Gm-Message-State: AOJu0Yz+eliDnO2KR8RP5IIoe8Hn74oGBvWVRjUgaq5mYSirpnGMzhDw
 Y/Fv7culM46g0bafrhH69+SStpHyoWBZx5sX+ufbKRBGsCOIcmS3pXdH
X-Gm-Gg: ASbGncv+N6lPHNmmaOOlIv+Ik2MJl+c1MlsAetXXcwxttC9oZguGVJmmw41/HvwXU8x
 oSGKwu3bl5jIO+sfuB15oWX2s7VB5H7qar2n4ibBYF1bG00KZjUb31VLgYMvUlCkHtfKIlLDtSk
 fKMqhGIlcaA1Lz6Lfbg1XbHyxxWhaavpWIbHQxuH8AWQSQ0IQo+iCJ0H402mZlSM6WX7x2zJ1v8
 oy/zLODcWFmkXa0YOPtGHsr2G5hpdP6OfG3IASqhzk4eHis3EqjEmki1OPvwCQpRdN1ffBk6loz
 cRb403oRY3AD5IUnfcyfVMDbr9KXQD7py/huGjuX2p1z50zBWLJ92Kq0sl1JXiutLd4WYm8tCR8
 mVAj7POTk1YLB2qmtP+qf/2LIaSc/+iEY4QUAQx9qTOolVc0gpE7jDIv/08Z1jAgP
X-Google-Smtp-Source: AGHT+IElqATLi0kk3bMSrXFu8hBHT6hAI+TIMC7FnEduWY8ajvteHifqDgET0Km7PtaFQ7lhGBupNw==
X-Received: by 2002:a05:6300:2189:b0:33e:6885:2bc5 with SMTP id
 adf61e73a8af0-348cc5de202mr6966060637.52.1761974387441; 
 Fri, 31 Oct 2025 22:19:47 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2001:df0:a640:1::12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db676c83sm3924089b3a.50.2025.10.31.22.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 22:19:47 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tianling Shen <cnsztl@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] mtd: spinand: add support for FudanMicro FM25S01A
Date: Sat,  1 Nov 2025 13:19:42 +0800
Message-ID: <20251101051942.695907-1-cnsztl@gmail.com>
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

