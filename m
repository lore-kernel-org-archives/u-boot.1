Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A60FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4E8846DB;
	Mon,  4 May 2026 20:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WncWk60/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D63846DB; Mon,  4 May 2026 20:58:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8F78467B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44a14580111so2692554f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921077; x=1778525877; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=faL2Cmwvlv8+DCrXKmaVbA3F9/KDF7YhP41/63cS9kc=;
 b=WncWk60/JvDxFhr2TMpnITzU7wPS521GqFAEk2nNrpRP92M5DSkJghdaPTWFf8DbL1
 0KB8ZzjlhqDWDTVx35l1ccbsSklRj0jIDplJpGUvulZ88cLeaUFV2AeVsVfu7/c2hmlv
 GB/yO2Q4xaTlaJEZ1D8n3dzDXIuzdtxxS6tN1V2hVV4o5OLsRKPtr4epnvkdXVRy34ho
 MwLcwingqwZBtBrBiKXgXAkGrHX1jZ6P41oIo1YA0FxnhFTGhmH3wj+xyZPxXCJmLDSY
 Z2A1Y+3+H4+8gbwoe+W4HkID7OWC3lS1hQaNSTtZiaCQebKCG4IDh1sODg4gypFQE9Jl
 CrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921077; x=1778525877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=faL2Cmwvlv8+DCrXKmaVbA3F9/KDF7YhP41/63cS9kc=;
 b=h3lK081NkgIr/nBV8wU4evooOKEmpLuwxSMsK9DPnbX86NHSdkhWJyQ0VLPju7rgm4
 2PhQD3m57BQrJAFlq1qOeomRLdCrYeVKnoEHOudC5TZIep4NgXKryPH63synqDg/DU5o
 w4PjcPAcQ5qjY3R9Bc9EvFBX8xD/qbcCAR3kc1rOxH/g8VSPxMO1OIwcis7HGGmFi+DU
 tgMizwQ4H4gp9LXtrRMBY1yS0/T2+HH8ic5VgUpj36zay1BHapcVI+9ajtuoCiDCp/LC
 VHjmWcbRTD/2VLJ9maJqMFl+wly6S2ISQovnksi0KxvV9KN2ZkOWiN/8SfWxzbxu77JJ
 nEBQ==
X-Gm-Message-State: AOJu0YwlAjM5t+4U5fUHC03sB5SFrHiu9bUdts4v8cyORE43Yo3E929x
 uo5KQMVenfOuAyBlwuDHj96b5hmzC0JGDQ9RBum5Ep3wyYm83LV7wdh18prftzFTd8A=
X-Gm-Gg: AeBDievLxWv4mlOcGCfDtFtPSdPAe5GYG8/1V1l59BfWBb/0aJcKkTdh1mkhRjeLVHS
 /I8Ut+qeYpUWuPWbpHn2o/bpge6o3AHqyztHnzFvTgIuB0+ICF3nwMQNLBhPufGh8a2Za1t+tTY
 UYxu4rIG7IbKdu9dWxb0XcyR+IhY5rjaMKcC5oddDE3y/RHcPCpgqEhjM63C4P/VS6vStlXYkw4
 /jyzZ6KOR4jIHj9uOVEhRo2f3g/+vFiVTRwvT44gspBXkT7GubYuPxafs/qEK8SJmdfDZ72yQso
 XrjrEiB9bB+GA4vrqjE1/ws9JNUvQ67LZv/1eiz1RcqUwZdBYEizb9Nu4Fw4H7VWCelyHD5mzoQ
 SgFsobhLTt8vSqMeV0Cn19ohWTW5VHu150kp4rHlqwVLPEzGRmUzwRnD61L8Q/MBugK9zySujK4
 I10YMZTvFwAqVRe2uPsrpYkH6b7U8kxGf9LrttI3BIvvjBhnkmzFYvdLlQjTviifiEjPqq245XY
 bwAYdqjrn/UfbCBhw==
X-Received: by 2002:a05:6000:1acb:b0:43d:1bf6:30f7 with SMTP id
 ffacd0b85a97d-44bb4442d00mr19214995f8f.18.1777921076910; 
 Mon, 04 May 2026 11:57:56 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:56 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:40 +0200
Subject: [PATCH v2 12/15] mach-snapdragon: move memory parsing to its own file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-12-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8797;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=YIN+bHbzOX9lJLwEHpRXPS0731W9F0iavR/DHfwaVe4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+S71p5knfDsTWp5vHXI7N9KSk2vnghmt7hL3Pr2L
 +l0iNimjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRstsMf3ibXsc2VM78VXPP
 +D0P09n98zMyq6QYbzBLfRTt/neJ9RHD/xTl06EMJ7N7j11wWqTy5fTHHQ/zK+UP3Yq4lpaUlzB
 vyRQA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile    |   2 +-
 arch/arm/mach-snapdragon/board.c     | 115 -------------------------------
 arch/arm/mach-snapdragon/dram.c      | 127 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |   2 +
 4 files changed, 130 insertions(+), 116 deletions(-)

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
index e12d3d00caa4..a2d97ad77910 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -42,123 +42,8 @@ enum qcom_boot_source qcom_boot_source __section(".data") = 0;
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
-/**
- * The generic memory parsing code in U-Boot lacks a few things that we
- * need on Qualcomm:
- *
- * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
- * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
- *    of that first memory block.
- *
- * This results in all memory beyond U-Boot being unusable in Linux when booting
- * with EFI.
- *
- * Since the ranges in the memory node may be out of order, the only way for us
- * to correctly determine the relocation address for U-Boot is to parse all
- * memory regions and find the highest valid address.
- *
- * We can't use fdtdec_setup_memory_banksize() since it stores the result in
- * gd->bd, which is not yet allocated.
- *
- * @fdt: FDT blob to parse /memory node from
- *
- * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
- */
-static int qcom_parse_memory(const void *fdt)
-{
-	int offset;
-	const fdt64_t *memory;
-	int memsize;
-	phys_addr_t ram_end = 0;
-	int i, j, banks;
-
-	offset = fdt_path_offset(fdt, "/memory");
-	if (offset < 0)
-		return -ENODATA;
-
-	memory = fdt_getprop(fdt, offset, "reg", &memsize);
-	if (!memory)
-		return -ENODATA;
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
-		if (!prevbl_ddr_banks[j].size) {
-			j--;
-			continue;
-		}
-		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
-	}
-
-	if (!banks || !prevbl_ddr_banks[0].size)
-		return -ENODATA;
-
-	/* Sort our RAM banks -_- */
-	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
-
-	gd->ram_base = prevbl_ddr_banks[0].start;
-	gd->ram_size = ram_end - gd->ram_base;
-
-	return 0;
-}
-
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
new file mode 100644
index 000000000000..ad73b685a935
--- /dev/null
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -0,0 +1,127 @@
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
+/**
+ * The generic memory parsing code in U-Boot lacks a few things that we
+ * need on Qualcomm:
+ *
+ * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
+ * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
+ *    of that first memory block.
+ *
+ * This results in all memory beyond U-Boot being unusable in Linux when booting
+ * with EFI.
+ *
+ * Since the ranges in the memory node may be out of order, the only way for us
+ * to correctly determine the relocation address for U-Boot is to parse all
+ * memory regions and find the highest valid address.
+ *
+ * We can't use fdtdec_setup_memory_banksize() since it stores the result in
+ * gd->bd, which is not yet allocated.
+ *
+ * @fdt: FDT blob to parse /memory node from
+ *
+ * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
+ */
+int qcom_parse_memory(const void *fdt)
+{
+	int offset;
+	const fdt64_t *memory;
+	int memsize;
+	phys_addr_t ram_end = 0;
+	int i, j, banks;
+
+	offset = fdt_path_offset(fdt, "/memory");
+	if (offset < 0)
+		return -ENODATA;
+
+	memory = fdt_getprop(fdt, offset, "reg", &memsize);
+	if (!memory)
+		return -ENODATA;
+
+	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
+
+	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
+		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
+
+	if (banks > CONFIG_NR_DRAM_BANKS)
+		log_err("Provided more memory banks than we can handle\n");
+
+	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
+		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
+		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
+		if (!prevbl_ddr_banks[j].size) {
+			j--;
+			continue;
+		}
+		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+	}
+
+	if (!banks || !prevbl_ddr_banks[0].size)
+		return -ENODATA;
+
+	/* Sort our RAM banks -_- */
+	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
+
+	gd->ram_base = prevbl_ddr_banks[0].start;
+	gd->ram_size = ram_end - gd->ram_base;
+
+	return 0;
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bbb..ce409314a98b 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -22,5 +22,7 @@ void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
+int qcom_parse_memory(const void *fdt);
+
 #endif /* __QCOM_PRIV_H__ */

-- 
2.53.0

