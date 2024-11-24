Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02ECE668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9551A896BB;
	Sun, 24 Nov 2024 20:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PY8T1Y+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B091589987; Sun, 24 Nov 2024 20:18:02 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E108953A
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so578306166b.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475880; x=1733080680; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=43kMLVc8y31AVo6TYGPBMHQM94BUyokDNhg0TrxJyHM=;
 b=PY8T1Y+SmArsNBBJUXLe8yaclG8K7hGns1Up9hxzB9cyuWrpfxc0bo570q9hEOo8qG
 EYQnkijx2a47Vp/o7yz84FUyHyYq2RxL21ebY428Pu+Ze9/H7yqQ1Y46BYYv8MB7yMOz
 KYpDMDceHkcN8advpdPjNKc0fLOKaZ4b7/dx8wfWkCeR5BSjeWYq+txevsJxDuAqzdkE
 iLw8QiesyQqt5BmwylaiH1P6zImg5e4UQL4cVK2s9cwKOuiPuLRY3idIRZeFcI2nGO+4
 zEpTSdOMqWlnpxKx0OH7v8ZVv/jTwv5KcBHG42F8CWzLK3Y2GkApU7hUKqP85Q6kqwcq
 5y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475880; x=1733080680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43kMLVc8y31AVo6TYGPBMHQM94BUyokDNhg0TrxJyHM=;
 b=Nzp01ejL64VqQJQkz1dKsOlCpV3atR8sn+xL5Zri3n3WpScnzku40iK9XfbeztJ0xV
 HfB3XRxxh4GYZkNrYtHuPM4ameZYIU4gTzdQYcrehWTZC7pulDAJieukq1AwEJsFQvFF
 tif80yquXYEplIzaN/BYaZjNOprnI2SFuh8bIAguWKjw7hyS2NWiESu5ZSbAf2BbFVl0
 TWV26gBJyjO7Dw/0ABRNrG4NEcdgr+oyI7n6vAZWYQZ6DBuHgP1HQOJpwub4/InPEjbL
 7q/idzfzYdpN0ZZ02I6XSfkxcIPSD4noZ7jzZYMe26TY39PijOxweLjIX7kkIJA2zu3X
 FDVQ==
X-Gm-Message-State: AOJu0YweTE+8FjciUcZtKLtbYqsyTo/RQl9WTpeHdWhXBrRTX7dNOxFa
 3JRznjqSvs8z75GgqxUa+yCqlrGmgL3UjKJvH2a+utcVs+ntGcH9iHh5DJZVNwI=
X-Gm-Gg: ASbGncuCFF+w/0zV2dOf21DfV5SZ0+4jH83Rb1uG9IZPKkHIWaJk06qZIXxQZizcVS0
 UwO1FPkYHQGYivISjJfw1W0KSA1T1dCOgNFsm7rhOLTpmgVzsqYYLHFOLvqxuVmkI7y6g5onNlj
 u6Sazy3byV/qVbHY1dO50ZCBdeLaeyLkGCYORNBQmC8CCPja1TxV7a/kg08vvGmvLUk9iuGyhft
 MbaWkWE2QDINsa9dSMPDTt6CUs9tvP94UHpC3c84DLhy+Jwl5eWOOiV5AexuLflyYhf
X-Google-Smtp-Source: AGHT+IEDTqy7hkddDlsnuE50FRcGbZwhmvn87FXn6ely7ybuj45NZXfYlD8dAGrgL0muAoMeF5XBNA==
X-Received: by 2002:a17:906:d511:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa509d6c7cfmr787953866b.51.1732475879791; 
 Sun, 24 Nov 2024 11:17:59 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:59 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:54 +0100
Subject: [PATCH 12/15] mach-snapdragon: move memory parsing to its own file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-12-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7755;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xqCHJt/ssNiAHJDI8IlKzjUA34nKWu98djFxudHRclU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6ptHj/1p8ud948bYVBtlKRvF+F9j6+8FcZ8Duif6f
 JOxfr6uo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzkkBLD/zrZJSe2L9h4rFzI
 0mHth4Djd2N2FO/Qf3drVeBMpvNBHx4x/PfVuVXHsWuJ3KUl57lipptoR6Q87ooI04+JMRDmO83
 8zwgA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This code is getting a bit complicated, split it out to try and keep
things a bit better organised as we're going to be supporting populating
the memory layout from various other sources.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile    |   2 +-
 arch/arm/mach-snapdragon/board.c     |  94 ----------------------------
 arch/arm/mach-snapdragon/dram.c      | 116 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |   2 +
 4 files changed, 119 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fdd..e481e4f26e5c 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-y += board.o
+obj-y += board.o dram.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 75a880f093ca..8d171957b852 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -40,102 +40,8 @@ DECLARE_GLOBAL_DATA_PTR;
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
-static struct {
-	phys_addr_t start;
-	phys_size_t size;
-} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
-
-int dram_init(void)
-{
-	/*
-	 * gd->ram_base / ram_size have been setup already
-	 * in qcom_parse_memory().
-	 */
-	return 0;
-}
-
-static int ddr_bank_cmp(const void *v1, const void *v2)
-{
-	const struct {
-		phys_addr_t start;
-		phys_size_t size;
-	} *res1 = v1, *res2 = v2;
-
-	if (!res1->size)
-		return 1;
-	if (!res2->size)
-		return -1;
-
-	return (res1->start >> 24) - (res2->start >> 24);
-}
-
-/* This has to be done post-relocation since gd->bd isn't preserved */
-static void qcom_configure_bi_dram(void)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
-		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
-	}
-}
-
-int dram_init_banksize(void)
-{
-	qcom_configure_bi_dram();
-
-	return 0;
-}
-
-static void qcom_parse_memory(void)
-{
-	ofnode node;
-	const fdt64_t *memory;
-	int memsize;
-	phys_addr_t ram_end = 0;
-	int i, j, banks;
-
-	node = ofnode_path("/memory");
-	if (!ofnode_valid(node)) {
-		log_err("No memory node found in device tree!\n");
-		return;
-	}
-	memory = ofnode_read_prop(node, "reg", &memsize);
-	if (!memory) {
-		log_err("No memory configuration was provided by the previous bootloader!\n");
-		return;
-	}
-
-	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
-
-	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
-		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
-
-	if (banks > CONFIG_NR_DRAM_BANKS)
-		log_err("Provided more memory banks than we can handle\n");
-
-	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
-		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
-		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
-		/* SM8650 boards sometimes have empty regions! */
-		if (!prevbl_ddr_banks[j].size) {
-			j--;
-			continue;
-		}
-		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
-	}
-
-	/* Sort our RAM banks -_- */
-	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
-
-	gd->ram_base = prevbl_ddr_banks[0].start;
-	gd->ram_size = ram_end - gd->ram_base;
-	debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
-	      gd->ram_base, gd->ram_size, ram_end);
-}
-
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
new file mode 100644
index 000000000000..c4c60039cb4c
--- /dev/null
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Memory layout parsing for Qualcomm.
+ */
+
+#define LOG_CATEGORY LOGC_BOARD
+#define pr_fmt(fmt) "QCOM-DRAM: " fmt
+
+#include <asm-generic/unaligned.h>
+#include <dm.h>
+#include <log.h>
+#include <sort.h>
+
+static struct {
+	phys_addr_t start;
+	phys_size_t size;
+} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
+
+int dram_init(void)
+{
+	/*
+	 * gd->ram_base / ram_size have been setup already
+	 * in qcom_parse_memory().
+	 */
+	return 0;
+}
+
+static int ddr_bank_cmp(const void *v1, const void *v2)
+{
+	const struct {
+		phys_addr_t start;
+		phys_size_t size;
+	} *res1 = v1, *res2 = v2;
+
+	if (!res1->size)
+		return 1;
+	if (!res2->size)
+		return -1;
+
+	return (res1->start >> 24) - (res2->start >> 24);
+}
+
+/* This has to be done post-relocation since gd->bd isn't preserved */
+static void qcom_configure_bi_dram(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
+		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+	}
+}
+
+int dram_init_banksize(void)
+{
+	qcom_configure_bi_dram();
+
+	return 0;
+}
+
+static void qcom_parse_memory_dt(const fdt64_t *memory, int banks, phys_addr_t *ram_end)
+{
+	int i, j;
+
+	if (banks > CONFIG_NR_DRAM_BANKS)
+		log_err("Provided more memory banks than we can handle\n");
+
+	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
+		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
+		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
+		/* SM8650 boards sometimes have empty regions! */
+		if (!prevbl_ddr_banks[j].size) {
+			j--;
+			continue;
+		}
+		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+	}
+}
+
+/* Parse the memory layout from the FDT. */
+void qcom_parse_memory(void)
+{
+	ofnode node;
+	const fdt64_t *memory;
+	int memsize;
+	phys_addr_t ram_end = 0;
+	int banks;
+
+	node = ofnode_path("/memory");
+	if (!ofnode_valid(node)) {
+		log_err("No memory node found in device tree!\n");
+		return;
+	}
+	memory = ofnode_read_prop(node, "reg", &memsize);
+	if (!memory) {
+		log_err("No memory configuration was provided by the previous bootloader!\n");
+		return;
+	}
+
+	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
+
+	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
+		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
+
+	qcom_parse_memory_dt(memory, banks, &ram_end);
+
+	debug("%d banks, ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
+	      banks, gd->ram_base, gd->ram_size, ram_end);
+	/* Sort our RAM banks -_- */
+	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
+
+	gd->ram_base = prevbl_ddr_banks[0].start;
+	gd->ram_size = ram_end - gd->ram_base;
+	debug("%d banks, ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
+	      banks, gd->ram_base, gd->ram_size, ram_end);
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 74d39197b89f..b7f3bf798d3c 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -22,5 +22,7 @@ static inline void qcom_of_fixup_nodes(void)
 	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
 }
 #endif /* OF_LIVE */
 
+void qcom_parse_memory(void);
+
 #endif /* __QCOM_PRIV_H__ */

-- 
2.47.0

