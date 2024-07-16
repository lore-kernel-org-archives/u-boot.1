Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2631C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4891988935;
	Tue, 16 Jul 2024 05:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g/5hBbkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59188886D; Tue, 16 Jul 2024 05:17:16 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DB38892F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so4474808a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721099832; x=1721704632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWt1VgQK2aqa7+23+4WPHd+vOMDdakoomxydNyKYMME=;
 b=g/5hBbkbkbdDBRgl71sCEQPzzCV0RdQqrT/584so32+WvsMwFdZPyOMG/X9xmW+zzA
 Msh/1xIOV6Ax5DNlBkp6mSANlKxRWYsaOpsjJ7W9GfV16BlAHtNJiwoZf9w7FqDq3RFu
 dMqm0Z+sH8g0+uDg08wTpz5MoeVKuCXr2Yq6G9y0jHIRYNrdEP0Iy0BJNOsSeYmilfWc
 1HUfXg8Iw4hoXpAPvqK/b2tUvaBkJBsJ2WHC1qY2Q31TCynuKR1L1MVRhyRdBBYaoZhD
 58ZB7zebQiphop+Gh/6s9lbUP+iRO6BrZw5z8M4xy7FPwYV/ireQT3p5z6oIPn1cNzBg
 xMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721099832; x=1721704632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWt1VgQK2aqa7+23+4WPHd+vOMDdakoomxydNyKYMME=;
 b=v5iNI+9tOLv3LK+dD4fzZqjW3eXhFqLMnodo/MacTVKTqfXo2bLPRKUcRgDtMB2TQY
 gBJMetc6zp09HT9wJQmXALxNEBo6cYPObSJ7su59bKVPH5HkHEfUdTzVmEQUpEcHcUEJ
 00jC+9qGz5wkILFYYII2JAQxfwvIONzqVD506bP7SPuk8kvQN7PeWaIyraikFpjuocl3
 aybzroq6CEyNtaUT1gIVf69LG1G/ArC7Rd3cdH+IzPT5eSMPOmWy4UefXb3Etcl6EyGv
 iEkDoc2fuNWL8eP6Kubj1zB66r0014Xe2eZku0kv8sgi8AkR7FAjRPzbSnGO/tWiatMD
 fvgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMme4ygz9YiiB/UB1GE/NcHbYpeKgIK9uqpFfsO/k7QuRolztyHNwf7VY7Qq5R71JLtuHp721Y6lgUg7kYuJX3Jde4HA==
X-Gm-Message-State: AOJu0YwA7ItC0lLV7qv3jNhrX1aO9ae1NLCQiixgDnmXLpppyCFHaJit
 3puLtXxQbV0t0ayv0mh4bK1UAXEHJ32EfZC8r8TCohUrZJXZ/0nqaUiO8ivVWEo=
X-Google-Smtp-Source: AGHT+IFRF+yA57hn8Lp/0xhAaoJEZHNJd5tSKA01snCqf3Wtutit2KtZ/Xex8PgxEcKh+I2tLjJ3+g==
X-Received: by 2002:a05:6830:6702:b0:6f9:8000:53e5 with SMTP id
 46e09a7af769-708d99de485mr1301879a34.23.1721099831980; 
 Mon, 15 Jul 2024 20:17:11 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d301f5sm1211320a34.78.2024.07.15.20.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 20:17:11 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 2/5] board: samsung: e850-96: Load LDFW firmware on board
 init
Date: Mon, 15 Jul 2024 22:17:06 -0500
Message-Id: <20240716031709.24943-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716031709.24943-1-semen.protsenko@linaro.org>
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
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

