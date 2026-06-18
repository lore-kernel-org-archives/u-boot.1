Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED985CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D62849F0;
	Thu, 18 Jun 2026 13:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ris87BYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C042A84874; Thu, 18 Jun 2026 13:57:22 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF208005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so5335575e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783840; x=1782388640; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uu+jymohdfmPrDpZP1etLe8B1bLs3iWbpCEUooM5t5w=;
 b=Ris87BYB9Mr3LCdMXyKZA6YtzBpjSR4KuJWdPgZ5N5W2G/iCoXcUsdv/8O/BH9/Wsl
 bWYwkjaZ4mz+ER0FWhFF4oDmjBri52IlgambVv949PSqljZv0hMiNe1CbTg7pLl12+9w
 MTUOxfpxneEtDzwyftUJzF6vgW/NYpnc4+4UsdeswlmB8TBHRwpPy6QXVbPlFkHuC0mE
 yvm6TFxHDo8du1YhHslaJU37ww6nw4gnI6unGAaTuWRp97iy6MINZFbUbLuRJUOFJ1Ml
 pk2DlzSi7QELn6D+Ju1pqN/p+h6pkOuScfvlwrkSMYBL871zvbyuJlvd0qkfe3IScHNX
 hLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783840; x=1782388640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uu+jymohdfmPrDpZP1etLe8B1bLs3iWbpCEUooM5t5w=;
 b=ceuXpvdrCrezmT96zobhwGPbO1QsBGa9GXrUwwtv9wDtJnRoA0jrq25L2nTz5Ma/Pn
 f8oB+sz0BQ6CZyM+PaNmq+NwELsq9ku8dZq3IekSLjQG97tNMQ1lxw2bLjcLW5QZJC4L
 mRK/NUsqC1Y/gM2hIgx82UhC61oY0KwjTq9fg/pfz8aaJbf6/7EEFyQ9efJAZxaJzu5H
 ZEAOOWTbfZe46vbtWEScoMbITwR+g1/prTg/kRxkRivX2e4TIITksBEPLXnbsDBRV/sO
 v0mn+TX3VpxTFkAxSLGE6Aj96KDVZBkEAkWg/0gFFSxwCk3iVXs8ljMHeJYz0P4J3l4z
 gZ8Q==
X-Gm-Message-State: AOJu0YzVUPh7zkOmN1gbpf4UOJwZpr2HBLh46YN1U++RhT4MJBMNdq8a
 a6XXTQup1R4xLGBqiZokUYxyVRQcUt89xI+C8fEEhtA68+7zRp/+nlPspXQrhZjIza4=
X-Gm-Gg: AfdE7clNNxpzt0iJsGrWEERE/RZOgWyg9jY1mQqRR1N53Ds8i3a1Z3Meay5u0aPKghR
 cAqaHnUabMNE8bwWsc6XaSEm/SZ3TZMfbUUW5P707JxkXMjbsm7vqgVBs9nmsMtb/i0X/qkmrvG
 phsAy/90jCEEpearxxxZyRT6/UmxHTrvwwRE6TWCyWZlR2w54m2hSOcrQzYswSRDVpzZ72/tZKa
 POMyAiRlOCCpeGC3KZUmZ3wuMvvGNisJm4U2aupMsnkCZpg1N2JkLUoWPPgTffhUidQQOJBaHon
 qh6aUGJwF9YgjMopTlso95lLCk+5O+tvy3H52+T1m6ceHSLj5pVtF8RpSlbtRyZELo8DBbdl1JZ
 8hpQDW4ft3+EJ0L7vKVT5wgjKbL+kmEAkX9CvWMJCqoLRbJWcs+rXT3UTsiZgQVUlffIqF0VV93
 72QH5xO65+OgOLWq60Iy0Ls523oOfWP5Kx96H32GpJiYbraSXl27qEokY=
X-Received: by 2002:a05:600c:4715:b0:490:b446:fb8 with SMTP id
 5b1f17b1804b1-4923a97f870mr23667125e9.11.1781783839961; 
 Thu, 18 Jun 2026 04:57:19 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:57:00 +0200
Subject: [PATCH v3 12/15] mach-snapdragon: move memory parsing to its own file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-12-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
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
 bh=8l+iIyhFQaG4SE1XTa6CjdClvacBQcGrXebbtvA6mkQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6xT+qs+nAjP6d0oabYg8cB8RqXFIVsWXXjyJTE3f
 uM+QauojlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRUxMZ/leKOPHHLHy5ef+B
 dIZn+zIneh+3OJ98ROdkO0Pz6azTuoEM/5PWzrl4eFY7U9yDNe+btMyD3yy0PPjlc/bm9QFf5K6
 Ix0cBAA==
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
index 3cffe4bc2af0..10830caa8e5b 100644
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

