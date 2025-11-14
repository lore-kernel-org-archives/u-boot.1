Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82553CE8D5D
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAE68429E;
	Fri, 14 Nov 2025 18:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUjFHIvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89769842B6; Fri, 14 Nov 2025 18:07:09 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF368425F
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8b26be00d93so221766685a.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763140025; x=1763744825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaYr4uzitJK452C4nWOgFoUe+DOiZWjw6CAVr9OHBDc=;
 b=JUjFHIvMhCcGJ7mLwZ9ienoiZIr0Zdg+77Gccv70q1suFnuZPFWqCbUHPcNaNB2veN
 GcQ8n+i7lAHP3CTXeTOTAtqmWQTkr2ADlKTtIg/xvgr/sCohYtrFebKQK0/TTjTDg4og
 UDfTX4VEVM+WAvMDFAHmXTUl3YDH2hbWB1mTtiS3r58KKoB194NBKnyRitl1I6bprcv+
 AyjXHixxiWMTLBZ7+l3jPGbXMaaUL0ZjF4x2VDPHSo9mmrUU81UWRNhODCkamFWfVQDm
 VWeD6gr6YP7Cfs9mg53uESxpQ86bx6OLWuOG2jG7QjoEr0VxYnR7T6L5Af2e3NLkMTiw
 UJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763140025; x=1763744825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CaYr4uzitJK452C4nWOgFoUe+DOiZWjw6CAVr9OHBDc=;
 b=ssed2SuUZcrYh8I6DEhF5z/FUI7xLpr9x1WXTUYage0IVqNgIR0GmPAx56aeC/6I82
 id3zVeMPh1DzIQzdE9nm9icvKuZ6dEYgA/fSIwEAOlTiO4U8PndWe5RDabxaWccLd2Iq
 qHNReTWJUJ7mZ40ye2FsJ0vlIv72ry+yPHQfpYeg2byPkriq6Eij1NbtQH6DGGy08gpX
 GpheXz6F5vSZdUDGEAv+QLfPiZLOzCCRh4tGoG1Yb6Z7LpU2PSBzAqFGCS16bwLvED/9
 JqCAjZ4v8SjhRSUn/6VLwOwER7KgOW1iXhwrAKaAz1jW2l++VyQj8s/h0LsfNrQ2pFn5
 H07Q==
X-Gm-Message-State: AOJu0YwpDoLtOFsxjrXi8Af9VQtYRXh76DUSPPCwdj9DQb7kG9Xwxdpo
 A/SFwklA4F9DyHInMKDpQnYgGoYCBlqEC+a1hagUngYKH6nbRcIOsGRYArh1vVO65sg=
X-Gm-Gg: ASbGncuolS8slXL5WpXSYGShJg9n8/JjOrdJ/9Pnfgd1VV1dM54PruXo8DMKbROOdP4
 RWMIfdz+6yN//Appl/R4c0cXfMnxpGjQ8seSjBrH7bKRz8WeeZF4pKrkvFbI6jr765MqyVMbamm
 2ml6btP/uIPz1sOf+DVMmIcLyvK0PSYbYLiNf6Z1SyoCPoB7mgMjIMlovdnGEJdiJmo09SVWkoC
 B3PzAlRp56riDsIiz6ln7UTVaZqDkuSNmaolxSHQdWWclbw2A6nxjNuxOngNNO88eunUXWil0tL
 7ojRGPXMqQOsqftETLnUDTLDUI2FVztAbI5j4g4Vh3M4TaVZP6t8U//YjxEAu64WZeKyL4AlOwk
 qGvRK8PeVwEVY8ow5Fd63KRpzr9cBaukVy9kaM/UgpBolJUa8ka0Q+QOsJ2T23Wc7OMGQWNr+ZV
 ukQGy1dlnBHCyUzUZ8YSQfADxP8An9r6uyyVNOf1Vlxg==
X-Google-Smtp-Source: AGHT+IGOOBKS3VvKwKx8OfmY+o5MoPKJ3s4l6Uw9UabdnPSl+XON31wKkOmu5RHlt390VPRyXm3fRA==
X-Received: by 2002:a05:6214:765:b0:880:53e3:3a2 with SMTP id
 6a1803df08f44-8829258ef06mr51982016d6.11.1763140025086; 
 Fri, 14 Nov 2025 09:07:05 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede8593c6asm32234861cf.0.2025.11.14.09.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:07:04 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 5/5] smbios: add support for dynamic generation of Type 19
 table
Date: Fri, 14 Nov 2025 09:06:02 -0800
Message-Id: <20251114170615.17698-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114170615.17698-1-raymondmaoca@gmail.com>
References: <20251114170615.17698-1-raymondmaoca@gmail.com>
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

This commit implements SMBIOS Type 19 (Memory Array Mapped Address)
generation with a hybrid approach supporting both:

1. Explicit definition via Device Tree 'smbios' node:
   Child node under '/smbios/smbios/memory-array-mapped-address' will be
   used to populate as individual Type 19 structure directly.
   - Properties follow SMBIOS field names with lowercase letters and
     hyphen-separated words (e.g., 'starting-address', 'ending-address',
     'partition-width', etc.).
   - This method supports precise platform-defined overrides and system
     descriptions.

2. Fallback to automatic DT-based discovery:
   If child node under '/smbios/smbios/memory-array-mapped-address' does
   not exist, the implementation will:
   - Scan all top-level 'memory@' nodes to populate Type 19 structure with
     inferred size and location data.
   - Scan nodes named or marked as 'memory-controller' and parse
     associated 'dimm@' subnodes (if present) to extract DIMM sizes and
     map them accordingly.

This dual-mode support enables flexible firmware SMBIOS reporting while
aligning with spec-compliant naming and runtime-detected memory topology.

Type 19 support is under GENERATE_SMBIOS_TABLE_VERBOSE to avoid
increasing rom size for those platforms which only require basic SMBIOS
support.

Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
---
Changes in v4:
- Initial patch.

 arch/arm/dts/smbios_generic.dtsi |   3 +
 cmd/smbios.c                     |  14 +++
 include/smbios.h                 |  11 +++
 include/smbios_def.h             |   5 ++
 lib/smbios.c                     | 150 +++++++++++++++++++++++++++++++
 5 files changed, 183 insertions(+)

diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
index fd2df8d02e0..fe16037fc20 100644
--- a/arch/arm/dts/smbios_generic.dtsi
+++ b/arch/arm/dts/smbios_generic.dtsi
@@ -86,6 +86,9 @@
 
 			memory-device {
 			};
+
+			memory-array-mapped-address {
+			};
 		};
 	};
 };
diff --git a/cmd/smbios.c b/cmd/smbios.c
index 39c9c44a28e..671c14e05b5 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -680,6 +680,17 @@ static void smbios_print_type17(struct smbios_type17 *table)
 	printf("\tRCD Revision Number: 0x%04x\n", table->rcd_rev_num);
 }
 
+static void smbios_print_type19(struct smbios_type19 *table)
+{
+	printf("Memory Array Mapped Address:\n");
+	printf("\tStarting Address: 0x%08x\n", table->start_addr);
+	printf("\tEnding Address: 0x%08x\n", table->end_addr);
+	printf("\tMemory Array Handle: 0x%04x\n", table->mem_array_hdl);
+	printf("\tPartition Width: 0x%04x\n", table->partition_wid);
+	printf("\tExtended Starting Address: 0x%016llx\n", table->ext_start_addr);
+	printf("\tExtended Ending Address: 0x%016llx\n", table->ext_end_addr);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -768,6 +779,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		case SMBIOS_MEMORY_DEVICE:
 			smbios_print_type17((struct smbios_type17 *)pos);
 			break;
+		case SMBIOS_MEMORY_ARRAY_MAPPED_ADDRESS:
+			smbios_print_type19((struct smbios_type19 *)pos);
+			break;
 		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
diff --git a/include/smbios.h b/include/smbios.h
index 45131416253..a0e47d51852 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -372,6 +372,17 @@ struct __packed smbios_type17 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+struct __packed smbios_type19 {
+	struct smbios_header hdr;
+	u32 start_addr;
+	u32 end_addr;
+	u16 mem_array_hdl;
+	u8 partition_wid;
+	u64 ext_start_addr;
+	u64 ext_end_addr;
+	char eos[SMBIOS_STRUCT_EOS_BYTES];
+};
+
 struct __packed smbios_type32 {
 	u8 type;
 	u8 length;
diff --git a/include/smbios_def.h b/include/smbios_def.h
index ce913f2f32a..ae50e1a808e 100644
--- a/include/smbios_def.h
+++ b/include/smbios_def.h
@@ -436,4 +436,9 @@
 #define SMBIOS_MD_ERRINFO_NONE		0xFFFE
 #define SMBIOS_MD_ERRINFO_NOERR		0xFFFF
 
+/* Memory Array Mapped Address */
+
+/* Partition Width */
+#define SMBIOS_MAMA_PW_DEF	1 /* not partitioned */
+
 #endif /* _SMBIOS_DEF_H_ */
diff --git a/lib/smbios.c b/lib/smbios.c
index 8a3fa42cef5..fcecf9516c0 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -1808,6 +1808,155 @@ static int smbios_write_type17(ulong *current, int *handle,
 				     smbios_write_type17_from_memctrl_node);
 }
 
+static void smbios_pop_type19_general_si(struct smbios_ctx *ctx,
+					 struct smbios_type19 *t)
+{
+	t->partition_wid =
+		smbios_get_val_si(ctx, "partition-width ",
+				  SYSID_NONE, SMBIOS_MAMA_PW_DEF);
+}
+
+static void smbios_pop_type19_addr_si(struct smbios_ctx *ctx,
+				      struct smbios_type19 *t)
+{
+	t->start_addr = smbios_get_val_si(ctx, "starting-address", SYSID_NONE,
+					  0);
+	t->end_addr = smbios_get_val_si(ctx, "ending-address", SYSID_NONE, 0);
+	t->ext_start_addr = smbios_get_u64_si(ctx, "extended-starting-address",
+					      SYSID_NONE, 0);
+	t->ext_end_addr = smbios_get_u64_si(ctx, "extended-ending-address",
+					    SYSID_NONE, 0);
+}
+
+static void
+smbios_pop_type19_addr_from_memory_node(ofnode node, struct smbios_type19 *t)
+{
+	const fdt32_t *reg;
+	int len;
+	u64 sz;
+	u64 addr;
+
+	/* Read property 'reg' from the node */
+	reg = ofnode_read_prop(node, "reg", &len);
+	if (!reg || len < sizeof(fdt32_t) * 4 || len % sizeof(fdt32_t))
+		return;
+
+	/* Combine hi/lo for size and address (typically 64-bit) */
+	sz = ((u64)fdt32_to_cpu(reg[2]) << 32) | fdt32_to_cpu(reg[3]);
+	addr = ((u64)fdt32_to_cpu(reg[0]) << 32) | fdt32_to_cpu(reg[1]);
+
+	t->ext_start_addr = cpu_to_le64(addr);
+	t->ext_end_addr = cpu_to_le64(addr + sz - 1);
+
+	/* If address range fits in 32-bit, populate legacy fields */
+	if ((addr + sz - 1) <= 0xFFFFFFFFULL) {
+		t->start_addr = cpu_to_le32((u32)addr);
+		t->end_addr   = cpu_to_le32((u32)(addr + sz - 1));
+	} else {
+		t->start_addr = cpu_to_le32(0xFFFFFFFF);
+		t->end_addr   = cpu_to_le32(0xFFFFFFFF);
+	}
+}
+
+static int
+smbios_write_type19_from_memctrl_node(ulong *current, int handle,
+				      struct smbios_ctx *ctx, int idx,
+				      u64 base, u64 sz)
+{
+	struct smbios_type19 *t;
+	int len;
+	u8 *eos_addr;
+	void *hdl;
+	size_t hdl_size;
+
+	len = sizeof(*t);
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_MEMORY_ARRAY_MAPPED_ADDRESS, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	/* Read the memory array handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+			      &hdl_size) &&
+	    hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+		t->mem_array_hdl = *((u16 *)hdl + idx);
+
+	t->ext_start_addr = cpu_to_le64(base);
+	t->ext_end_addr = cpu_to_le64(base + sz - 1);
+
+	if ((base + sz - 1) <= 0xFFFFFFFFULL) {
+		t->start_addr = cpu_to_le32((u32)base);
+		t->end_addr   = cpu_to_le32((u32)(base + sz - 1));
+	} else {
+		t->start_addr = cpu_to_le32(0xFFFFFFFF);
+		t->end_addr   = cpu_to_le32(0xFFFFFFFF);
+	}
+
+	/* Write other general fields */
+	smbios_pop_type19_general_si(ctx, t);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type19_mem(ulong *current, int handle,
+				   struct smbios_ctx *ctx, int idx,
+				   int type)
+{
+	struct smbios_type19 *t;
+	int len;
+	u8 *eos_addr;
+	void *hdl;
+	size_t hdl_size;
+
+	len = sizeof(*t);
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_MEMORY_ARRAY_MAPPED_ADDRESS, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	if (type == SMBIOS_MEM_CUSTOM) {
+		smbios_pop_type19_addr_si(ctx, t);
+		t->mem_array_hdl = smbios_get_val_si(ctx, "memory-array-handle",
+						     SYSID_NONE, 0);
+	} else if (type == SMBIOS_MEM_FDT_MEM_NODE) {
+		smbios_pop_type19_addr_from_memory_node(ctx->node, t);
+		/* Read the memory array handles */
+		if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+				      &hdl_size) &&
+		    hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+			t->mem_array_hdl = *((u16 *)hdl + idx);
+	}
+
+	/* Write other general fields */
+	smbios_pop_type19_general_si(ctx, t);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type19(ulong *current, int *handle,
+			       struct smbios_ctx *ctx)
+{
+	return smbios_write_type1719(current, handle, ctx,
+				     smbios_write_type19_mem,
+				     smbios_write_type19_from_memctrl_node);
+}
+
 #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
 
 static int smbios_write_type32(ulong *current, int *handle,
@@ -1858,6 +2007,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type9, "system-slot"},
 	{ smbios_write_type16, "memory-array"},
 	{ smbios_write_type17, "memory-device"},
+	{ smbios_write_type19, "memory-array-mapped-address"},
 #endif
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

