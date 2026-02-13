Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226A1EF99E0
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 22:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EB783E23;
	Fri, 13 Feb 2026 23:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXb1R9BE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E0A83015; Fri, 13 Feb 2026 23:53:40 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4503983E23
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 23:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-896ff127650so24636346d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771023217; x=1771628017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TDRoz+nsCAkBTzCOa77CBcfqqmeI0pv10FV/2t9IrI=;
 b=WXb1R9BEFwu3EMVhxIi4mvcTex3i3tfMDMmoVHJd3RVgE3Z81sltfol77DdqA7UXPz
 RzA9VQoS5xKlLVLH/YrXz5/JYI+v9bT5cypf04AZswYZqGTcppU8Ql0811gvNXrV9ATX
 A9SwPSzf43iXlZfY3F4hWWEML0msjs2+g0C+cet0VGD+O+QY2hMNwOdhJNgm7B4o56sP
 s9uxTK94UqIMj1HNjFpkmgNV6DSktW5sWNSNeFqQ+19+E5aHhsVX12fj9ed9zsNzXlIg
 s8x9xV9vQW6d5TDxhVClamQysJ+0ibngOlpYPPQ5ObboNTGIHeNJo0DxHs6e0EbI6TKY
 gJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023217; x=1771628017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6TDRoz+nsCAkBTzCOa77CBcfqqmeI0pv10FV/2t9IrI=;
 b=MOr/rtlQcRXm1WytDFj2coO/00ltO+mcuXo59V6n34UYbR7HUsFNKuiC8ffoo4TSJF
 jt4fEKkHdirez15nf07uOa+mWoykdes3Hfi9Iivs/GeCPbb6405PiIp+ZGKXhDAUHQw5
 nJyatZ2fH3de5U9Awq5/D+WnvEOLGMkxAjk+mo/C6kfsZW2RX73QXQ+HVmshwEImqyB8
 gBTZc8rPKSPQHVaY31eOIpxcoeuMLkYhE3CRQ0G11T0J2P/FfAY3Bs9isZXsdfiCKNPJ
 TkXnsfftt0M+qpw0RgNt1gz4ezkPryW12WRMKebc8zen4mCMLBXQEH2sFJJbvGMVcsrr
 Ltrg==
X-Gm-Message-State: AOJu0YxIZnzX1KYwEEVCVHIaYwsUNhgC86BUEdRgvzY588XhV/BlIfsj
 qHdzLpNInVcVRhugyuQ0UtIzlppMbO3wk19U+3WHih5m9OuX1dB2Q5tK/+/0qg==
X-Gm-Gg: AZuq6aJ+IR4Sedj/lAjsj5PyXUTPgZAPd244FGLi+rQOn2EnyLFDlOTVUvt/SDL/Zsv
 BcBKIQwRGC7c2ZsGjpuBnDoRc6XdV5WLXx1aOGhoZ6OQzWppUYgpZvDXOBgJ66UFcjpc78jgvYT
 /94sRni6OLLxE3EFydSHSMgtNPlddf5JjqFz7jzrk7UzX4eP+Ax0lB26osK+3qmBrIFlHcexbmR
 d7AAAjhbOx6MmUhJF/5hQSi20X5aXRUdv5Xp9wcHczZBCDwhrp2ZYnpG2RQ958XOSrlbUXQoOR3
 4zU+OLAOi5r3Grel/smDvpxCdv+iwVjBn3EDnoIcPD6djGZg/rbtnLq7GrMX5qUsu0+LnQmB0lw
 PMa4eYk9nhsAeL4k3lZTWCCjLONvHhPtV5w2ckObHvwGgFYFAoScP5ipFrtYP4JyoMa40wFVVeF
 lLr6piIRwsgUphFOzG/mdE5wP7tE10Vq9OCGVmyFLE88wN3Ljnt2pRs51xSszh7FigjQZMxtaoJ
 FaIfKNMZIY=
X-Received: by 2002:a05:6214:ac2:b0:897:2b23:3a7d with SMTP id
 6a1803df08f44-897402c7332mr20074676d6.2.1771023216957; 
 Fri, 13 Feb 2026 14:53:36 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847ed9c4sm72845731cf.8.2026.02.13.14.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 14:53:36 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 5/6] smbios: add support for dynamic generation of Type 19
 table
Date: Fri, 13 Feb 2026 17:52:50 -0500
Message-Id: <20260213225254.2544596-6-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213225254.2544596-1-raymondmaoca@gmail.com>
References: <20260213225254.2544596-1-raymondmaoca@gmail.com>
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
Changes in v5:
- None.
Changes in v6:
- None.

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
index 2deafea9aa1..e4b5ff314d9 100644
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
index 7c6ad63b1c7..d5f18c8bd69 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -1807,6 +1807,155 @@ static int smbios_write_type17(ulong *current, int *handle,
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
@@ -1857,6 +2006,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type9, "system-slot"},
 	{ smbios_write_type16, "memory-array"},
 	{ smbios_write_type17, "memory-device"},
+	{ smbios_write_type19, "memory-array-mapped-address"},
 #endif
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

