Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F02D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E52C83AED;
	Fri, 28 Nov 2025 17:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwN24xL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3E383B03; Fri, 28 Nov 2025 17:36:10 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF5F838FA
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8b31a665ba5so176175685a.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764347767; x=1764952567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkf8iSJWvvAhqtMQ94JgJ3+La+bbJr+Yvp2ook6aQxs=;
 b=TwN24xL+TU3cC6ZU+IMqGGypewvPEQ6ungA2jxvIoLnvX927bni+XrJ5YHCd7k8Pwe
 S5TPoiwKQE6uEJml8LOX6OzkJEg1K8oiVf4MvJPeRoDBADIXpi0T2HoAE93BJmPUdxfO
 f7hCEwuYXimy5XaTt6hxyz0v5DL1l8khy7ACvGLAdC/+7x9wqjfYSB+TEQdAXwZqusKR
 jGegDTJU8EaGKC15am7SVNjcO+neELglc/YcjQtSxzegTWHgrDkKXzzYRps6UVCsIr7X
 DpLaTdPh8pcDu/A85mLm4++HlKGlpeIgR8oKzD2/vKjXeZEQB1na9p0UQ75qVI82h769
 i6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347767; x=1764952567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkf8iSJWvvAhqtMQ94JgJ3+La+bbJr+Yvp2ook6aQxs=;
 b=R0JXu1LcGrUk0mksC16+P0wYppISftY8/Fa9fIU+fXoBHuZgeMO9qwYAqchpLWu6a6
 ttdoUWwyUxyzLG2lCFvlkmRIIV9KLtvH6zi5/WOiSNiXjbTuGXU7hJZKhiKGpwlAVks3
 Sy0LytdTiWVZcRhRM8BMtN/vXwidwCNBkYWn9b1CzOIy6nl7WeOXpFaLEzLcWjkeoxBw
 1VJWY6Ljzpy+oJJWYIyXeO5hdVAYuU8YFhjw7SifERbYgy7sIO5LKTutkcZZsrSkprut
 bGjvt7jXbwJeRUHCDP/sK84wzPi9bp7OZ/iMRpvLdGIQ7gXNpLMXL+C+JRxIe8wVTwFj
 3jLg==
X-Gm-Message-State: AOJu0Ywh4t1KgPHGUEL23WwUDLCl26vyc+USNIOwxI85IPMEtfX32Xj6
 JOTpMQ6W/d/RpsRvbr4oGzwDa9lrXBRF70yG6z3LZZ8tz4x/59vmVmmD0IpekXI+y1c=
X-Gm-Gg: ASbGnct/5eMlXSXMP2j1rKDC8bjHmtJvRYTxfU5Gwji3+K/F5wyeq/LWAjTm68f9/PF
 AGd3Dpnxe0x1JXHr7DS++4oI82JP8eIw1aPCyf/ICpEzkedzuceLcCrN43z/cpM5upd/IpTKevF
 NUoVSKQtnERcm+0WtzcjK45Ra2fwnRKZ/Sfj8aQhk4PXdxB3xM7u6Xv2FEOSCjyTrGOIS3RMsET
 peekzhihDkwy2580EwMpiQhpamAkivGDN/YbyS2zbDhbgERz4n6JyFi4L+ruJrrHyRJ+oeZslxj
 0HkrlBoeLsfKybxiYkqHK96bYrHTlqb9t06SwS8G+pLICi8f1k/UgTmg26WEoLrgRrpu/dL713f
 aZTn8ZHUMUWi4VeorUtu8GnVj4ayvVybvherkJPP/OjvgrgzQQGEmPt3spnvhm86XVz62M48bRa
 23khB4jvykZWDb/jEsMHa1lqq43lBD7iA=
X-Google-Smtp-Source: AGHT+IGFdjTEuDXZQzw6OjiUYH1OBZoLd9O4arsJoXehvjxqWBmZ3s3TFcyu3PQNZIjn37+XUmyIJg==
X-Received: by 2002:a05:620a:3188:b0:811:3f8a:24a6 with SMTP id
 af79cd13be357-8b4ebdae723mr2111362385a.53.1764347766595; 
 Fri, 28 Nov 2025 08:36:06 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm331227985a.25.2025.11.28.08.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:36:06 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 3/6] smbios: add support for dynamic generation of Type 16
 table
Date: Fri, 28 Nov 2025 08:35:20 -0800
Message-Id: <20251128163535.2301653-4-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128163535.2301653-1-raymondmaoca@gmail.com>
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
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

This commit implements SMBIOS Type 16 (Physical Memory Array)
generation with a hybrid approach supporting both:

1. Explicit definition via Device Tree 'smbios' node:
   Child node under '/smbios/smbios/memory-array' will be used to
   populate as individual Type 16 structure directly.
   - Properties follow SMBIOS field names with lowercase letters and
     hyphen-separated words (e.g., 'memory-error-correction',
     'maximum-capacity', 'extended-maximum-capacity', etc.).
   - This method supports precise platform-defined overrides and system
     descriptions.

2. Fallback to automatic DT-based discovery:
   If child node under '/smbios/smbios/memory-array' does not exist,
   the implementation will:
   - Scan all top-level 'memory@' nodes to populate Type 16 structure with
     inferred size and location data.
   - Scan nodes named or marked as 'memory-controller' and parse
     associated 'dimm@' subnodes (if present) to extract DIMM sizes and
     map them accordingly.

This dual-mode support enables flexible firmware SMBIOS reporting while
aligning with spec-compliant naming and runtime-detected memory topology.

Type 16 support is under GENERATE_SMBIOS_TABLE_VERBOSE to avoid
increasing rom size for those platforms which only require basic SMBIOS
support.

Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
---
Changes in v4:
- Initial patch.
Changes in v5:
- None.

 arch/arm/dts/smbios_generic.dtsi |   3 +
 cmd/smbios.c                     |  46 +++++
 drivers/sysinfo/smbios.c         |   5 +
 include/smbios.h                 |  18 ++
 include/smbios_def.h             |  29 ++++
 include/sysinfo.h                |   4 +
 lib/smbios.c                     | 282 +++++++++++++++++++++++++++++++
 7 files changed, 387 insertions(+)

diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
index 4463dade217..1a9adfaa409 100644
--- a/arch/arm/dts/smbios_generic.dtsi
+++ b/arch/arm/dts/smbios_generic.dtsi
@@ -80,6 +80,9 @@
 
 			system-slot {
 			};
+
+			memory-array {
+			};
 		};
 	};
 };
diff --git a/cmd/smbios.c b/cmd/smbios.c
index f9b62e66229..3f7dd21f92e 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -168,6 +168,32 @@ static const struct str_lookup_table slot_length_strings[] = {
 	{ SMBIOS_SYSSLOT_LENG_3_5INDRV,	"3.5 inch drive form factor" },
 };
 
+static const struct str_lookup_table ma_location_strings[] = {
+	{ SMBIOS_MA_LOCATION_OTHER,		"Other" },
+	{ SMBIOS_MA_LOCATION_UNKNOWN,		"Unknown" },
+	{ SMBIOS_MA_LOCATION_MOTHERBOARD,	"System board or motherboard" },
+};
+
+static const struct str_lookup_table ma_use_strings[] = {
+	{ SMBIOS_MA_USE_OTHER,		"Other" },
+	{ SMBIOS_MA_USE_UNKNOWN,	"Unknown" },
+	{ SMBIOS_MA_USE_SYSTEM,		"System memory" },
+	{ SMBIOS_MA_USE_VIDEO,		"Video memory" },
+	{ SMBIOS_MA_USE_FLASH,		"Flash memory" },
+	{ SMBIOS_MA_USE_NVRAM,		"Non-volatile RAM" },
+	{ SMBIOS_MA_USE_CACHE,		"Cache memory" },
+};
+
+static const struct str_lookup_table ma_err_corr_strings[] = {
+	{ SMBIOS_MA_ERRCORR_OTHER,	"Other" },
+	{ SMBIOS_MA_ERRCORR_UNKNOWN,	"Unknown" },
+	{ SMBIOS_MA_ERRCORR_NONE,	"None" },
+	{ SMBIOS_MA_ERRCORR_PARITY,	"Parity" },
+	{ SMBIOS_MA_ERRCORR_SBITECC,	"Single-bit ECC" },
+	{ SMBIOS_MA_ERRCORR_MBITECC,	"Multi-bit ECC" },
+	{ SMBIOS_MA_ERRCORR_CRC,	"CRC" },
+};
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -514,6 +540,23 @@ static void smbios_print_type9(struct smbios_type9 *table)
 	printf("\tSlot Height: 0x%04x\n", *addr);
 }
 
+static void smbios_print_type16(struct smbios_type16 *table)
+{
+	printf("Physical Memory Array:\n");
+	smbios_print_lookup_str(ma_location_strings, table->location,
+				ARRAY_SIZE(ma_location_strings), "Location");
+	smbios_print_lookup_str(ma_use_strings, table->use,
+				ARRAY_SIZE(ma_use_strings), "Use");
+	smbios_print_lookup_str(ma_err_corr_strings, table->mem_err_corr,
+				ARRAY_SIZE(ma_err_corr_strings),
+				"Memory Error Correction");
+	printf("\tMaximum Capacity: 0x%08x\n", table->max_cap);
+	printf("\tMemory Error Information Handle: 0x%04x\n",
+	       table->mem_err_info_hdl);
+	printf("\tNumber of Memory Devices: 0x%04x\n", table->num_of_mem_dev);
+	printf("\tExtended Maximum Capacity: 0x%016llx\n", table->ext_max_cap);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -596,6 +639,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		case SMBIOS_SYSTEM_SLOTS:
 			smbios_print_type9((struct smbios_type9 *)pos);
 			break;
+		case SMBIOS_PHYS_MEMORY_ARRAY:
+			smbios_print_type16((struct smbios_type16 *)pos);
+			break;
 		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
diff --git a/drivers/sysinfo/smbios.c b/drivers/sysinfo/smbios.c
index 99104274f72..ff5873c940e 100644
--- a/drivers/sysinfo/smbios.c
+++ b/drivers/sysinfo/smbios.c
@@ -24,6 +24,7 @@ struct sysinfo_plat_priv {
 	struct smbios_type7 t7[SYSINFO_CACHE_LVL_MAX];
 	u16 cache_handles[SYSINFO_CACHE_LVL_MAX];
 	u8 cache_level;
+	u16 marray_handles[SYSINFO_MEM_HANDLE_MAX];
 };
 
 static void smbios_cache_info_dump(struct smbios_type7 *cache_info)
@@ -165,6 +166,10 @@ static int sysinfo_plat_get_data(struct udevice *dev, int id, void **buf,
 		*buf = &priv->cache_handles[0];
 		*size = sizeof(priv->cache_handles);
 		break;
+	case SYSID_SM_MEMARRAY_HANDLE:
+		*buf = &priv->marray_handles[0];
+		*size = sizeof(priv->marray_handles);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/smbios.h b/include/smbios.h
index d885285ea41..16438c059c7 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -309,6 +309,24 @@ struct __packed smbios_type9 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+enum {
+	SMBIOS_MEM_NONE = 0,
+	SMBIOS_MEM_CUSTOM = 1,
+	SMBIOS_MEM_FDT_MEM_NODE = 2,
+	SMBIOS_MEM_FDT_MEMCON_NODE = 3
+};
+
+struct __packed smbios_type16 {
+	struct smbios_header hdr;
+	u8 location;
+	u8 use;
+	u8 mem_err_corr;
+	u32 max_cap;
+	u16 mem_err_info_hdl;
+	u16 num_of_mem_dev;
+	u64 ext_max_cap;
+	char eos[SMBIOS_STRUCT_EOS_BYTES];
+};
 struct __packed smbios_type32 {
 	u8 type;
 	u8 length;
diff --git a/include/smbios_def.h b/include/smbios_def.h
index ef9cb02ed25..c6850a5d6f5 100644
--- a/include/smbios_def.h
+++ b/include/smbios_def.h
@@ -280,4 +280,33 @@
 /* Slot segment group number */
 #define SMBIOS_SYSSLOT_SGGNUM_UND	0
 
+/* Physical Memory Array */
+
+/* Location */
+#define SMBIOS_MA_LOCATION_OTHER	1
+#define SMBIOS_MA_LOCATION_UNKNOWN	2
+#define SMBIOS_MA_LOCATION_MOTHERBOARD	3
+
+/* Use */
+#define SMBIOS_MA_USE_OTHER		1
+#define SMBIOS_MA_USE_UNKNOWN		2
+#define SMBIOS_MA_USE_SYSTEM		3
+#define SMBIOS_MA_USE_VIDEO		4
+#define SMBIOS_MA_USE_FLASH		5
+#define SMBIOS_MA_USE_NVRAM		6
+#define SMBIOS_MA_USE_CACHE		7
+
+/* Error Correction Type */
+#define SMBIOS_MA_ERRCORR_OTHER		1
+#define SMBIOS_MA_ERRCORR_UNKNOWN	2
+#define SMBIOS_MA_ERRCORR_NONE		3
+#define SMBIOS_MA_ERRCORR_PARITY	4
+#define SMBIOS_MA_ERRCORR_SBITECC	5
+#define SMBIOS_MA_ERRCORR_MBITECC	6
+#define SMBIOS_MA_ERRCORR_CRC		7
+
+/* Error Information Handle */
+#define SMBIOS_MA_ERRINFO_NONE		0xFFFE
+#define SMBIOS_MA_ERRINFO_NOERR		0xFFFF
+
 #endif /* _SMBIOS_DEF_H_ */
diff --git a/include/sysinfo.h b/include/sysinfo.h
index e87cf969fcd..54eb64a204a 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -12,6 +12,7 @@
 struct udevice;
 
 #define SYSINFO_CACHE_LVL_MAX 3
+#define SYSINFO_MEM_HANDLE_MAX 8
 
 /*
  * This uclass encapsulates hardware methods to gather information about a
@@ -149,6 +150,9 @@ enum sysinfo_id {
 	SYSID_SM_CACHE_INFO_END =
 		SYSID_SM_CACHE_INST_SIZE2 + SYSINFO_CACHE_LVL_MAX - 1,
 
+	/* Memory Array (Type 16) */
+	SYSID_SM_MEMARRAY_HANDLE,
+
 	/* For show_board_info() */
 	SYSID_BOARD_MODEL,
 	SYSID_BOARD_MANUFACTURER,
diff --git a/lib/smbios.c b/lib/smbios.c
index caeb309294d..27c9c975cf2 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -290,6 +290,49 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
 	return val_def;
 }
 
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+static u64 smbios_get_u64_si(struct smbios_ctx * __maybe_unused ctx,
+			     const char * __maybe_unused prop,
+			     int __maybe_unused sysinfo_id, u64 val_def)
+{
+	size_t len;
+	void *data;
+	const fdt32_t *prop_val;
+	int prop_len;
+	u64 val = 0;
+
+	if (!ctx->dev)
+		return val_def;
+
+	if (!sysinfo_get_data(ctx->dev, sysinfo_id, &data, &len))
+		return *((u64 *)data);
+
+	if (!IS_ENABLED(CONFIG_OF_CONTROL) || !prop || !ofnode_valid(ctx->node))
+		return val_def;
+
+	prop_val = ofnode_read_prop(ctx->node, prop, &prop_len);
+	if (!prop_val || prop_len < sizeof(fdt32_t) ||
+	    prop_len % sizeof(fdt32_t)) {
+		/*
+		 * If the node or property is not valid fallback and try the root
+		 */
+		prop_val = ofnode_read_prop(ofnode_root(), prop, &prop_len);
+		if (!prop_val || prop_len < sizeof(fdt32_t) ||
+		    prop_len % sizeof(fdt32_t))
+			return val_def;
+	}
+
+	/* 64-bit: <hi lo> or 32-bit */
+	if (prop_len >= sizeof(fdt32_t) * 2) {
+		val = ((u64)fdt32_to_cpu(prop_val[0]) << 32) |
+		     fdt32_to_cpu(prop_val[1]);
+	} else {
+		val = fdt32_to_cpu(prop_val[0]);
+	}
+	return val;
+}
+#endif
+
 /**
  * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
  *
@@ -1151,6 +1194,244 @@ static int smbios_write_type9(ulong *current, int *handle,
 	return len;
 }
 
+static u64 smbios_pop_size_from_memory_node(ofnode node)
+{
+	const fdt32_t *reg;
+	int len;
+	u64 size_bytes;
+
+	/* Read property 'reg' from the node */
+	reg = ofnode_read_prop(node, "reg", &len);
+	if (!reg || len < sizeof(fdt32_t) * 4 || len % sizeof(fdt32_t))
+		return 0;
+
+	/* Combine hi/lo for size (typically 64-bit) */
+	size_bytes = ((u64)fdt32_to_cpu(reg[2]) << 32) | fdt32_to_cpu(reg[3]);
+
+	return size_bytes;
+}
+
+static int
+smbios_write_type16_sum_memory_nodes(ulong *current, int handle,
+				     struct smbios_ctx *ctx, u16 cnt, u64 size)
+{
+	struct smbios_type16 *t;
+	int len = sizeof(*t);
+	u8 *eos_addr;
+	void *hdl;
+	size_t hdl_size;
+
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_PHYS_MEMORY_ARRAY, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	/* default attributes */
+	t->location = SMBIOS_MA_LOCATION_MOTHERBOARD;
+	t->use = SMBIOS_MA_USE_SYSTEM;
+	t->mem_err_corr = SMBIOS_MA_ERRCORR_UNKNOWN;
+	t->mem_err_info_hdl = SMBIOS_MA_ERRINFO_NONE;
+	t->num_of_mem_dev = cnt;
+
+	/* Use extended field */
+	t->max_cap = cpu_to_le32(0x80000000);
+	t->ext_max_cap = cpu_to_le64(size >> 10); /* In KB */
+
+	/* Save the memory array handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+			      &hdl_size) &&
+	    hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+		*((u16 *)hdl) = handle;
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static void
+smbios_pop_type16_from_memcontroller_node(ofnode node, struct smbios_type16 *t)
+{
+	ofnode child;
+	int count = 0;
+	u64 total = 0;
+
+	/* default attributes */
+	t->location = SMBIOS_MA_LOCATION_MOTHERBOARD;
+	t->use = SMBIOS_MA_USE_SYSTEM;
+	t->mem_err_info_hdl = SMBIOS_MA_ERRINFO_NONE;
+
+	/* Check custom property 'ecc-enabled' */
+	if (ofnode_read_bool(node, "ecc-enabled"))
+		t->mem_err_corr = SMBIOS_MA_ERRCORR_SBITECC;
+	else
+		t->mem_err_corr = SMBIOS_MA_ERRCORR_UNKNOWN;
+
+	/* Read subnodes with 'size' property */
+	for (child = ofnode_first_subnode(node); ofnode_valid(child);
+	     child = ofnode_next_subnode(child)) {
+		u64 sz = 0;
+		const fdt32_t *size;
+		int len;
+
+		size = ofnode_read_prop(child, "size", &len);
+		if (!size || len < sizeof(fdt32_t) || len % sizeof(fdt32_t))
+			continue;
+
+		/* 64-bit size: <hi lo> or 32-bit size */
+		if (len >= sizeof(fdt32_t) * 2)
+			sz = ((u64)fdt32_to_cpu(size[0]) << 32) |
+			     fdt32_to_cpu(size[1]);
+		else
+			sz = fdt32_to_cpu(size[0]);
+
+		count++;
+		total += sz;
+	}
+
+	/*
+	 * Number of memory devices associated with this array
+	 * (i.e., how many Type17 entries link to this Type16 array)
+	 */
+	t->num_of_mem_dev = count;
+
+	/* Use extended field */
+	t->max_cap = cpu_to_le32(0x80000000);
+	t->ext_max_cap = cpu_to_le64(total >> 10); /* In KB */
+}
+
+static void smbios_pop_type16_si(struct smbios_ctx *ctx,
+				 struct smbios_type16 *t)
+{
+	t->location = smbios_get_val_si(ctx, "location", SYSID_NONE,
+					SMBIOS_MA_LOCATION_UNKNOWN);
+	t->use = smbios_get_val_si(ctx, "use", SYSID_NONE,
+				   SMBIOS_MA_USE_UNKNOWN);
+	t->mem_err_corr = smbios_get_val_si(ctx, "memory-error-correction", SYSID_NONE,
+					    SMBIOS_MA_ERRCORR_UNKNOWN);
+	t->max_cap = smbios_get_val_si(ctx, "maximum-capacity", SYSID_NONE, 0);
+	t->mem_err_info_hdl = smbios_get_val_si(ctx, "memory-error-information-handle",
+						SYSID_NONE, SMBIOS_MA_ERRINFO_NONE);
+	t->num_of_mem_dev = smbios_get_val_si(ctx, "number-of-memory-devices", SYSID_NONE, 1);
+	t->ext_max_cap = smbios_get_u64_si(ctx, "extended-maximum-capacity", SYSID_NONE, 0);
+}
+
+static int smbios_write_type16_1array(ulong *current, int handle,
+				      struct smbios_ctx *ctx, int idx,
+				      int type)
+{
+	struct smbios_type16 *t;
+	int len = sizeof(*t);
+	u8 *eos_addr;
+	void *hdl;
+	size_t hdl_size;
+
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_PHYS_MEMORY_ARRAY, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	if (type == SMBIOS_MEM_CUSTOM)
+		smbios_pop_type16_si(ctx, t);
+	else if (type == SMBIOS_MEM_FDT_MEMCON_NODE)
+		smbios_pop_type16_from_memcontroller_node(ctx->node, t);
+
+	/* Save the memory array handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+			      &hdl_size) &&
+	    hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+		*((u16 *)hdl + idx) = handle;
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type16(ulong *current, int *handle,
+			       struct smbios_ctx *ctx)
+{
+	int len;
+	struct smbios_ctx ctx_bak;
+	ofnode child;
+	int idx;
+	u64 total = 0;
+	int count = 0;
+	int hdl_base = *handle;
+
+	if (!IS_ENABLED(CONFIG_OF_CONTROL))
+		return 0;	/* Error, return 0-length */
+
+	/* Step 1: Scan any subnode exists under 'memory-array' */
+	len = smbios_scan_subnodes(current, ctx, handle,
+				   smbios_write_type16_1array,
+				   SMBIOS_MEM_CUSTOM);
+	if (len)
+		return len;
+
+	/* Step 2: Scan 'memory' node from the entire FDT */
+	for (child = ofnode_first_subnode(ofnode_root());
+	     ofnode_valid(child); child = ofnode_next_subnode(child)) {
+		const char *str;
+
+		/* Look up for 'device_type = "memory"' */
+		str = ofnode_read_string(child, "device_type");
+		if (str && !strcmp(str, "memory")) {
+			count++;
+			total += smbios_pop_size_from_memory_node(child);
+		}
+	}
+	/*
+	 * Generate one type16 instance for all 'memory' nodes,
+	 * use idx=0 implicitly
+	 */
+	if (count)
+		len += smbios_write_type16_sum_memory_nodes(current, *handle,
+							    ctx, count, total);
+
+	/* Step 3: Scan 'memory-controller' node from the entire FDT */
+	/* idx starts from 1 */
+	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
+	for (idx = 1, child = ofnode_first_subnode(ofnode_root());
+	     ofnode_valid(child); child = ofnode_next_subnode(child)) {
+		const char *compat;
+		const char *name;
+
+		/*
+		 * Look up for node with name or property 'compatible'
+		 * containing 'memory-controller'.
+		 */
+		name = ofnode_get_name(child);
+		compat = ofnode_read_string(child, "compatible");
+		if ((!compat || !strstr(compat, "memory-controller")) &&
+		    (!name || !strstr(name, "memory-controller")))
+			continue;
+
+		*handle = hdl_base + idx;
+		ctx->node = child;
+		/*
+		 * Generate one type16 instance for each 'memory-controller'
+		 * node, sum the 'size' of all subnodes.
+		 */
+		len += smbios_write_type16_1array(current, *handle, ctx, idx,
+						  SMBIOS_MEM_FDT_MEMCON_NODE);
+		idx++;
+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
+	}
+
+	return len;
+}
+
 #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
 
 static int smbios_write_type32(ulong *current, int *handle,
@@ -1199,6 +1480,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type4, "processor"},
 #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
 	{ smbios_write_type9, "system-slot"},
+	{ smbios_write_type16, "memory-array"},
 #endif
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

