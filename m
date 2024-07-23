Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF8BC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F060A8884D;
	Tue, 23 Jul 2024 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="upgIxGo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F208887E; Tue, 23 Jul 2024 20:14:47 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E78088800
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70446231242so2920142a34.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758482; x=1722363282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHPYsvDXjO8Wqgk24Z47cj1cvnKaTkkeSwxtugiopmk=;
 b=upgIxGo1KYppKUUlncuJ8OPHa+Q3NrLIOBB6hEBoYfGDKwMS9+IkW3qCgGgh32zEvy
 8DFFQ6s9WqMpjCJSZTZ9vP84LImJGqP39R294f9u8gm0oQu90Pyki0Rc+3x6GgLEBCY8
 qOZuwJfdHFv5HE4Vp1dC+qxrwDMDPJ7Si14PpjEz5A/z2yzrh5PDCMnX1QPA4zVH7Vz1
 uC2YrcCk8fiCQ5VXZlVFmHJN/K6yDXPvZOoqtjZ8M4fPoRs/axaLgsbH2AgR1pfHa9Bf
 8NOz1cD8i8UPRAD0Gdp3Q48qJp3VNjm40n4IsuxW32mNMx86W6RZxK5HMll8OlkVjcrE
 Qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758482; x=1722363282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHPYsvDXjO8Wqgk24Z47cj1cvnKaTkkeSwxtugiopmk=;
 b=sCS9z1Z4FJFqfCnYNwXu0snqU4C8JJAlpjfFaeEH8p2DUOILLZ+rHDGmdr6y97kOv7
 BSJTlEonrpIF/RP8ZERyYUcMPH16Y/c8PBYkqA1JNSGs9MHSoUrFkja2Nfgk0BnUBiAt
 RE7syImP+AjeCsOgXXI9gLoUUluJNv6Bui6QKdH8kiCT0hnGSGcDFv+0UClqGQk/qah4
 +AeGIOmhXo+JBmY8jDqB8K1feeOzxJCGyHwXRp9ItBKsHnU7U6nyZt2UU+ufXE7mYT5j
 DO3fmk8+09Yc3nVw28yAbYusip4cmJqqAEOwxF2P/nyBb4Y4X8gq0Tnk9raviK72radu
 AXKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTAcyuG/1QErcbm/Y62BTpuu5PaLbm+ryhMg+4xbJoqWQQUlgeP5+TZ5FMK0wrw8ZvJX/ijXLO8gWBhdieV6d4LqhhDg==
X-Gm-Message-State: AOJu0YxCLsDcyCn8LB6PvKulBjqYvXtvRY/9zJ2dLY7D7H5jzhwwT7v+
 YseKUYBRyLnzwh6BSPG1rcC1Ne+cQstzcSmdEcx4NgH2ly493/wR/04mwESeBRaDK23WdZUWRPM
 m
X-Google-Smtp-Source: AGHT+IHZLjDWRD1gjxLQkyC+2b1P4v5mWFeXbELtfCX8d1SSckWxLEh+jO3XnKipP6NhUOyu4Eme3Q==
X-Received: by 2002:a05:6830:6a8b:b0:703:68c2:3cb6 with SMTP id
 46e09a7af769-709181dfe83mr4639016a34.32.1721758481949; 
 Tue, 23 Jul 2024 11:14:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6174fc9sm2103134a34.56.2024.07.23.11.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 2/5] board: samsung: e850-96: Load LDFW firmware on board
 init
Date: Tue, 23 Jul 2024 13:14:36 -0500
Message-Id: <20240723181439.7089-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
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

LDFW is a Loadable Firmware which provides additional security
capabilities in EL3 monitor. For example, True Random Number Generator
(TRNG) block registers can't be accessed from EL1 (where U-Boot and
Linux kernel are running), but it's possible to access TRNG capabilities
via corresponding SMC calls, which in turn are handled by LDFW. To do
so, LDFW firmware has to be loaded first. It's stored on a raw eMMC
partition, so it has to be read into NWD (Normal World) RAM buffer, and
then loaded to SWD (Secure World) memory using the special SMC call to
EL3 monitor program. EL3_MON will load LDFW to SWD memory, more
specifically to the area starting at 0xbf700000 (with size of 7.5 MiB).
That memory area is reserved in device tree, so there shouldn't be any
collisions. After that LDFW becomes functional.

Implement LDFW firmware loading on board init. While at it, fix the
copyright date in header comments, as this board support was actually
added in 2024, not in 2020: it was probably a copy-paste mistake.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 board/samsung/e850-96/Makefile  |   4 +-
 board/samsung/e850-96/e850-96.c |   6 +-
 board/samsung/e850-96/fw.c      | 131 ++++++++++++++++++++++++++++++++
 board/samsung/e850-96/fw.h      |  12 +++
 4 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 board/samsung/e850-96/fw.c
 create mode 100644 board/samsung/e850-96/fw.h

diff --git a/board/samsung/e850-96/Makefile b/board/samsung/e850-96/Makefile
index 301c22337119..71d46ea3d2b4 100644
--- a/board/samsung/e850-96/Makefile
+++ b/board/samsung/e850-96/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2020, Linaro Limited
+# Copyright (C) 2024, Linaro Limited
 # Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-y	:= e850-96.o
+obj-y	:= e850-96.o fw.o
diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index a00d81b5d4c3..c5cef6f19d22 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020, Linaro Limited
- * Sam Protsenko <semen.protsenko@linaro.org>
+ * Copyright (c) 2024, Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
  */
 
 #include <init.h>
+#include "fw.h"
 
 int dram_init(void)
 {
@@ -18,5 +19,6 @@ int dram_init_banksize(void)
 
 int board_init(void)
 {
+	load_ldfw();
 	return 0;
 }
diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
new file mode 100644
index 000000000000..82a0b224c670
--- /dev/null
+++ b/board/samsung/e850-96/fw.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Firmware loading code.
+ */
+
+#include <part.h>
+#include <linux/arm-smccc.h>
+#include "fw.h"
+
+#define EMMC_IFACE		"mmc"
+#define EMMC_DEV_NUM		0
+
+/* LDFW constants */
+#define LDFW_PART_NAME		"ldfw"
+#define LDFW_NWD_ADDR		0x88000000
+#define LDFW_MAGIC		0x10adab1e
+#define SMC_CMD_LOAD_LDFW	-0x500
+#define SDM_HW_RESET_STATUS	0x1230
+#define SDM_SW_RESET_STATUS	0x1231
+#define SB_ERROR_PREFIX		0xfdaa0000
+
+struct ldfw_header {
+	u32 magic;
+	u32 size;
+	u32 init_entry;
+	u32 entry_point;
+	u32 suspend_entry;
+	u32 resume_entry;
+	u32 start_smc_id;
+	u32 version;
+	u32 set_runtime_entry;
+	u32 reserved[3];
+	char fw_name[16];
+};
+
+static int read_fw(const char *part_name, void *buf)
+{
+	struct blk_desc *blk_desc;
+	struct disk_partition part;
+	unsigned long cnt;
+	int part_num;
+
+	blk_desc = blk_get_dev(EMMC_IFACE, EMMC_DEV_NUM);
+	if (!blk_desc) {
+		debug("%s: Can't get eMMC device\n", __func__);
+		return -ENODEV;
+	}
+
+	part_num = part_get_info_by_name(blk_desc, part_name, &part);
+	if (part_num < 0) {
+		debug("%s: Can't get LDWF partition\n", __func__);
+		return -ENOENT;
+	}
+
+	cnt = blk_dread(blk_desc, part.start, part.size, buf);
+	if (cnt != part.size) {
+		debug("%s: Can't read LDFW partition\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int load_ldfw(void)
+{
+	const phys_addr_t addr = (phys_addr_t)LDFW_NWD_ADDR;
+	struct ldfw_header *hdr;
+	struct arm_smccc_res res;
+	void *buf = (void *)addr;
+	u64 size = 0;
+	int err, i;
+
+	/* Load LDFW from the block device partition into RAM buffer */
+	err = read_fw(LDFW_PART_NAME, buf);
+	if (err)
+		return err;
+
+	/* Validate LDFW by magic number in its header */
+	hdr = buf;
+	if (hdr->magic != LDFW_MAGIC) {
+		debug("%s: Wrong LDFW magic; is LDFW flashed?\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Calculate actual total size of all LDFW blobs */
+	for (i = 0; hdr->magic == LDFW_MAGIC; ++i) {
+#ifdef DEBUG
+		char name[17] = { 0 };
+
+		strncpy(name, hdr->fw_name, 16);
+		debug("%s: ldfw #%d: version = 0x%x, name = %s\n", __func__, i,
+		      hdr->version, name);
+#endif
+
+		size += (u64)hdr->size;
+		hdr = (struct ldfw_header *)((u64)hdr + (u64)hdr->size);
+	}
+	debug("%s: The whole size of all LDFWs: 0x%llx\n", __func__, size);
+
+	/* Load LDFW firmware to SWD (Secure World) memory via EL3 monitor */
+	arm_smccc_smc(SMC_CMD_LOAD_LDFW, addr, size, 0, 0, 0, 0, 0, &res);
+	err = (int)res.a0;
+	if (err == -1 || err == SDM_HW_RESET_STATUS) {
+		debug("%s: Can't load LDFW in dump_gpr state\n", __func__);
+		return -EIO;
+	} else if (err == SDM_SW_RESET_STATUS) {
+		debug("%s: Can't load LDFW in kernel panic (SW RESET) state\n",
+		      __func__);
+		return -EIO;
+	} else if (err < 0 && (err & 0xffff0000) == SB_ERROR_PREFIX) {
+		debug("%s: LDFW signature is corrupted! ret=0x%x\n", __func__,
+		      (u32)err);
+		return -EIO;
+	} else if (err == 0) {
+		debug("%s: No LDFW is inited\n", __func__);
+		return -EIO;
+	}
+
+#ifdef DEBUG
+	u32 tried = res.a0 & 0xffff;
+	u32 failed = (res.a0 >> 16) & 0xffff;
+
+	debug("%s: %d/%d LDFWs have been loaded successfully\n", __func__,
+	      tried - failed, tried);
+#endif
+
+	return 0;
+}
diff --git a/board/samsung/e850-96/fw.h b/board/samsung/e850-96/fw.h
new file mode 100644
index 000000000000..472664e4ed21
--- /dev/null
+++ b/board/samsung/e850-96/fw.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#ifndef __E850_96_FW_H
+#define __E850_96_FW_H
+
+int load_ldfw(void);
+
+#endif /* __E850_96_FW_H */
-- 
2.39.2

