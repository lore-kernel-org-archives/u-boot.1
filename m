Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58035D75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2689939;
	Sun, 24 Nov 2024 20:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oeMmkizN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988D889812; Sun, 24 Nov 2024 20:18:03 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D5E899A0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso208172866b.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475881; x=1733080681; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hmFseKUkt7mwAk/sUu4EJEETAWTt5Zgjg+i431V9GSQ=;
 b=oeMmkizNuv5MxNfgQA7xm5sgvXOnZy8SL5Cq2A5eiph6KYQRphU4vzsl47teEHy3iv
 dzqtl09AnTuP/90OXtS7IDojFa6OhpKYFES1hrelrAZusqn9iGXO3rexdrlNQBLgWb4y
 bmk6YJ9ojrJFo+dRYfDSqfvLDD1wVVbnHTBLueDKUBguPrdGCMADytyEseYXSNwqFqv+
 C1B4XGoEwdZ9O23ytR+OLbASel2rtrdNjD3WF3EIWgtgksR1GrpqWQjqV1dGkLf/cmMi
 YpB8AQS+ooVMlgr/Valsx2M3KnriMCEDkDxQsU47Gi+BhOQbvTJT7GvnGcHas5daOzsT
 5zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475881; x=1733080681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmFseKUkt7mwAk/sUu4EJEETAWTt5Zgjg+i431V9GSQ=;
 b=vYZe2X+n2BUVaa5UGH8mZ8tNyFZTJIlqBHM+k1nflSyhxagEiwz6J8wbX82/rP63WX
 DNAkRk7OIkAKYLqZHWpVDH98WIe+loFP32+Razo2eMjKovufDXsqk2F5KpT8qj0FTz4h
 O6fTVe7Z5PYrLfCude5yYnKzvvimxG/sgoEP+zDsmjuQj1mgGr/QS0efn0+Xo0DAaOXZ
 WfPOQCbZwGS/QcY99TowK/i8w2JrpCZYg4JFoIpmZ57BoYUGTbmn53RZi39v3rVdc7J/
 PGAIeFE4YpXFRjSnMj1QcZqeTOriz/SxEnc9/K+xIVu7IjhSOSbFlSO6SSKD3b8cO8ur
 LMJA==
X-Gm-Message-State: AOJu0Yz8Sfoc0lbkxNjyk0aFITdmBsqysRzLslLKHQvqAsov9vFCWPh+
 FwZOcEnsv1qET3EuWvR/mKoda9NX91ljVl31V2a9b6hKux/cCGYdIxt+rffgj1k=
X-Gm-Gg: ASbGncvZTxh6cTHk8sVkUuVMk/V1TDfM2Xp3YiTG9QDwuUfMiCnYgmAH/thb24OKl+Q
 ZQpmNifa+VszoXZyiEz/GXQlmg+tQC4PXxaHQ5M85xwtRB3lzqsGmDFmTvSN1rQeBv8FLzL/tnQ
 vXITjyjr/ZRsR6KEZYH9IhcvruEGEMp+c+pGs6vhxVCQK6um9PWACMiODwHtqnprsPOPS526UF5
 MdRuUwAwIr6qffeMaOSi/aeXe6C+Mdyej5Hh6cVd/2M/5bFmRYA+7O0FACEoJ4Sw1z6
X-Google-Smtp-Source: AGHT+IHG7IZ8CEsI96dEB5Skv57k7rlqRJT/Oh5XMDlao8naOLynoFGsOK8ez8w6sUQ7CtxlB91nwA==
X-Received: by 2002:a17:906:9d2:b0:aa5:b2b:f236 with SMTP id
 a640c23a62f3a-aa50b2bf7ffmr774292266b.28.1732475880741; 
 Sun, 24 Nov 2024 11:18:00 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:18:00 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:55 +0100
Subject: [PATCH 13/15] mach-snapdragon: support parsing memory map from
 SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-13-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6934;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nzCEFARaIj7wTx36KBeY5Je7ny5WpUDpLbORIGhEk70=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6pt/rR/b1iqqd83dwC7/TVFdOtQhcVnXwniDR3nbi
 3gkZ77sKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABO5JMXwV1yo6ueWq23swW1V
 cf4XjvZsW9Xr5TY1KWr2icfduf93mTL8j3JfoLD4vXddsdPnDTNEJzrq/m49++NNunlj6DmRYhm
 1bAA=
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

It is possible to derive the memory map for a Qualcomm platform from the
SMEM shared memory region. The memory map is populated by the preloader.

Introduce support for parsing this data and using it to populate
U-Boot's memory map. Since we aren't yet sure if this will work for
every platform, it is not yet used in all cases, if U-Boot is booted
with an internal FDT which has the memory map defined, this will
be used instead.

If the FDT comes from ABL, or we're using an internal FDT with no memory
map defined, then U-Boot will try to use SMEM. This should remove the
need to define the memory map statically in a U-Boot overlay DT for most
boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     |   2 +-
 arch/arm/mach-snapdragon/dram.c      | 106 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +-
 3 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 8d171957b852..269d39e4f6e1 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -85,9 +85,9 @@ void *board_fdt_blob_setup(int *err)
 	/*
 	 * Parse the /memory node while we're here,
 	 * this makes it easy to do other things early.
 	 */
-	qcom_parse_memory();
+	qcom_parse_memory(internal_valid);
 
 	return (void *)gd->fdt_blob;
 }
 
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index c4c60039cb4c..ef226e000858 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -9,14 +9,47 @@
 #include <asm-generic/unaligned.h>
 #include <dm.h>
 #include <log.h>
 #include <sort.h>
+#include <soc/qcom/smem.h>
+
+#define SMEM_USABLE_RAM_PARTITION_TABLE 402
+#define RAM_PART_NAME_LENGTH            16
+#define RAM_NUM_PART_ENTRIES            32
+#define CATEGORY_SDRAM 0x0E
+#define TYPE_SYSMEM 0x01
 
 static struct {
 	phys_addr_t start;
 	phys_size_t size;
 } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
 
+struct smem_ram_ptable_hdr {
+	u32 magic[2];
+	u32 version;
+	u32 reserved;
+	u32 len;
+} __packed;
+
+struct smem_ram_ptn {
+	char name[RAM_PART_NAME_LENGTH];
+	u64 start;
+	u64 size;
+	u32 attr;
+	u32 category;
+	u32 domain;
+	u32 type;
+	u32 num_partitions;
+	u32 reserved[3];
+	u32 reserved2[2]; /* The struct grew by 8 bytes at some point */
+} __packed;
+
+struct smem_ram_ptable {
+	struct smem_ram_ptable_hdr hdr;
+	u32 reserved;     /* Added for 8 bytes alignment of header */
+	struct smem_ram_ptn parts[RAM_NUM_PART_ENTRIES];
+} __packed;
+
 int dram_init(void)
 {
 	/*
 	 * gd->ram_base / ram_size have been setup already
@@ -47,8 +80,12 @@ static void qcom_configure_bi_dram(void)
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
 		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+		debug("Bank[%d]: start = %#011llx, size = %#011llx\n",
+		      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
+		if (!prevbl_ddr_banks[i].size)
+			break;
 	}
 }
 
 int dram_init_banksize(void)
@@ -57,8 +94,48 @@ int dram_init_banksize(void)
 
 	return 0;
 }
 
+/* Parse memory map from SMEM, return the number of entries */
+static int qcom_parse_memory_smem(phys_addr_t *ram_end)
+{
+	size_t size;
+	int i, j = 0, ret;
+	struct smem_ram_ptable *ram_ptable;
+	struct smem_ram_ptn *p;
+
+	ret = qcom_smem_init();
+	if (ret) {
+		debug("Failed to initialize SMEM: %d.\n", ret);
+		return ret;
+	}
+
+	ram_ptable = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
+	if (!ram_ptable) {
+		debug("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	/* Check validy of RAM */
+	for (i = 0; i < RAM_NUM_PART_ENTRIES && j < CONFIG_NR_DRAM_BANKS; i++) {
+		p = &ram_ptable->parts[i];
+		if (p->category != CATEGORY_SDRAM || p->type != TYPE_SYSMEM)
+			continue;
+		if (!p->size && !p->start)
+			break;
+
+		prevbl_ddr_banks[j].start = p->start;
+		prevbl_ddr_banks[j].size = p->size;
+		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+		j++;
+	}
+
+	if (j == CONFIG_NR_DRAM_BANKS)
+		log_err("SMEM: More than CONFIG_NR_DRAM_BANKS (%u) entries!", CONFIG_NR_DRAM_BANKS);
+
+	return j;
+}
+
 static void qcom_parse_memory_dt(const fdt64_t *memory, int banks, phys_addr_t *ram_end)
 {
 	int i, j;
 
@@ -76,10 +153,23 @@ static void qcom_parse_memory_dt(const fdt64_t *memory, int banks, phys_addr_t *
 		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
 	}
 }
 
-/* Parse the memory layout from the FDT. */
-void qcom_parse_memory(void)
+/*
+ * Parse the memory layout from FDT or SMEM:
+ *
+ * If using an internal FDT (where the memory map must have
+ * been written by hand) then we prefer using the layout from
+ * there. This allows overriding SMEM.
+ *
+ * If using an external FDT (coming from ABL), we prefer SMEM
+ * since it is likely to be more accurate / simple, especially
+ * on newer platforms.
+ *
+ * If SMEM parsing fails, we always try to fall back to FDT.
+ *
+ */
+void qcom_parse_memory(bool fdt_is_internal)
 {
 	ofnode node;
 	const fdt64_t *memory;
 	int memsize;
@@ -103,10 +193,18 @@ void qcom_parse_memory(void)
 		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
 
 	qcom_parse_memory_dt(memory, banks, &ram_end);
 
-	debug("%d banks, ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
-	      banks, gd->ram_base, gd->ram_size, ram_end);
+	/*
+	 * If using an internal FDT but the memory node is empty
+	 * then fall back to SMEM.
+	 */
+	if (!prevbl_ddr_banks[0].size && fdt_is_internal) {
+		banks = qcom_parse_memory_smem(&ram_end);
+		if (banks < 0)
+			panic("Couldn't find a valid memory map!\n");
+	}
+
 	/* Sort our RAM banks -_- */
 	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
 
 	gd->ram_base = prevbl_ddr_banks[0].start;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b7f3bf798d3c..690557463642 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -2,8 +2,10 @@
 
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+#include <stdbool.h>
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}
@@ -22,7 +24,7 @@ static inline void qcom_of_fixup_nodes(void)
 	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
 }
 #endif /* OF_LIVE */
 
-void qcom_parse_memory(void);
+void qcom_parse_memory(bool fdt_is_internal);
 
 #endif /* __QCOM_PRIV_H__ */

-- 
2.47.0

