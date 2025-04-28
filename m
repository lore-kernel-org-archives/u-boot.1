Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4E3C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B96B82A5C;
	Mon, 28 Apr 2025 21:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aInfxIxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EBDA8213D; Mon, 28 Apr 2025 21:24:54 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2283780EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so4860075a91.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868290; x=1746473090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDuNq/WSWsvSre4nphDo6pZ9Wej2ekuXzods2se/sPM=;
 b=aInfxIxyqIA72lzj//w+cYF9fV3MXrT1PBnqpTxePTYwVrtIc9H4JwfohhOH3FWxU/
 whkZz08BrwPDNm4qJY120EzvtDLZvAq2KoU0qW5iuOW7TBLG7xmuYBePu/6Tt39cBrg/
 CI53+L8BkjgmtAHxd20EOrR7NynhwCEPmJZ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868290; x=1746473090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDuNq/WSWsvSre4nphDo6pZ9Wej2ekuXzods2se/sPM=;
 b=Dg9BlYX1v21Bo5khu6ZaqgeV6tFAiTp3u7/esqNxLGjse0idwB/K83Rkprf9Lqe2pz
 guLO+cpLd6jU9hwS7aiocOSwXO5/xFIOoCYpfPqz9Gn9xUVCKzjywZKJPh+dxCyXkiqh
 rW3r7VJpFnQq9z65lPljcoV9WSo18x7pP6alNF+N0IdNnxYtgFKHVyQMVAi0ZKiMdRFj
 5fnu0qXXx/69E6oyC0vVYSBdDKZQ49s6Xiwq6ZvI/Ysmg9lSEgSN7p6Z9sbpeCuplgRU
 PRDcNoZWQHJyDCE4SFOt4O/UX6GU1xOZjnnsW04jXvI+Ah0EYbLpzjuxaE253dRDgepw
 WO5Q==
X-Gm-Message-State: AOJu0YxDyORFlffFMz7luRYb9zt4YcIdoAtls0IfXZuydi5am1sy3AFP
 vfkByxmIm1zOT6XSJGgcWwlkycbTzuLx7kiSzLJLls8vTJV2pdC4wwqxRr9U7FFe2CT2/40LGzs
 =
X-Gm-Gg: ASbGncuqLUybXgSPkjZcANijflMK51jL92hUN0owu05Peo1fv+NCpS1tCmSuJNBGSoK
 Dq9mg+cGfezOHToWgd70fcuZL01sCEhqAp9I9gAB37mhtS0exqO7w6LOcu9ySivffHyQ7NdnMrs
 TxbLPJSUMJpNK/pMRXHQTUpnKwM2GFEyFkFUHwLq3k53HTw6b4lpVDEFif0x7JPJoq8xtwT3Ejz
 hPlbnmN/7vDgqNEVtJKlLAnFfs/fl0GeheVbVbMBXg+FUa5LBJfk9wDje7KoegmJD0zZTkVWMl2
 MU4iyS4Iz1IQj2AORKXi6yqza8k/e0JfYDwpIbNviK4cIMyrRiTZA9TJ0A85ZSPJor9Xqkk+K2a
 C8Q==
X-Google-Smtp-Source: AGHT+IHrNPM1uBk6fh/hliyE+SMZ24nDbzwylYnTZi6SsUZOH8RcI1MLK80U+Cl3gzvIDmI+si0A9Q==
X-Received: by 2002:a17:90a:d450:b0:30a:214c:24c9 with SMTP id
 98e67ed59e1d1-30a23dc1b41mr18272a91.3.1745868290486; 
 Mon, 28 Apr 2025 12:24:50 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309f77370b2sm7605837a91.8.2025.04.28.12.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:49 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 13/17] coreboot: Add /firmware/coreboot node to DT
Date: Mon, 28 Apr 2025 12:24:20 -0700
Message-ID: <20250428192427.3877612-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Populate the firmware node with a coreboot node detailing where the
coreboot tables and CBMEM area are located.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 boot/image-fdt.c          |   4 ++
 include/cb_sysinfo.h      |   7 +++
 lib/coreboot/cb_sysinfo.c | 120 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8f718ad29f6b..2d37be0ff7da 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -8,6 +8,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <cb_sysinfo.h>
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
@@ -619,6 +620,9 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 #if IS_ENABLED(CONFIG_CMD_PSTORE)
 	/* Append PStore configuration */
 	fdt_fixup_pstore(blob);
+#endif
+#if CONFIG_IS_ENABLED(SYS_COREBOOT)
+	fdt_fixup_coreboot(blob);
 #endif
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
 		const char *skip_board_fixup;
diff --git a/include/cb_sysinfo.h b/include/cb_sysinfo.h
index b11d42be549c..b2128bb20a19 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -264,6 +264,13 @@ int coreboot_early_init(void);
  */
 const struct sysinfo_t *cb_get_sysinfo(void);
 
+/**
+ * fdt_fixup_coreboot() - Add the /firmware/coreboot node to the FDT
+ *
+ * Add the /firmware/coreboot node to the FDT if U-Boot is a coreboot payload.
+ */
+void fdt_fixup_coreboot(void *blob);
+
 /**
  * coreboot_dram_init_banksize() - Initilize RAM banksize from coreboot sysinfo
  * table
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 2e9b98d3ced5..0155b72ff37e 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -7,6 +7,7 @@
  */
 
 #include <cb_sysinfo.h>
+#include <fdt_support.h>
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
@@ -511,3 +512,122 @@ const struct sysinfo_t *cb_get_sysinfo(void)
 
 	return NULL;
 }
+
+#if CONFIG_IS_ENABLED(OF_LIBFDT)
+void fdt_fixup_coreboot(void *blob)
+{
+	char node[32];
+	int  nodeoffset;	/* node offset from libfdt */
+	u32 addr_cells_root;
+	u32 size_cells_root;
+	u32 addr_cells;
+	u32 size_cells;
+	u64 header_addr;
+	u64 header_size;
+	u64 cbmem_addr;
+	u64 cbmem_size;
+	int i;
+	const struct memrange *cbmem_range = NULL;
+
+	if (!gd->arch.coreboot_table)
+		return;
+
+	for (i = 0; i < lib_sysinfo.n_memranges; i++) {
+		const struct memrange *memrange = &lib_sysinfo.memrange[i];
+
+		if (memrange->type == CB_MEM_TABLE) {
+			cbmem_range = memrange;
+			break;
+		}
+	}
+
+	if (!cbmem_range) {
+		log_err("Missing cbmem table\n");
+		return;
+	}
+
+	nodeoffset = fdt_path_offset(blob, "/");
+	if (nodeoffset < 0) {
+		/* Not found or something else bad happened. */
+		log_err("fdt_path_offset() returned %s\n", fdt_strerror(nodeoffset));
+		return;
+	}
+	addr_cells_root = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#address-cells", 2);
+	size_cells_root = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#size-cells", 2);
+
+	nodeoffset = fdt_find_or_add_subnode(blob, nodeoffset, "firmware");
+	if (nodeoffset < 0) {
+		log_err("Add 'firmware' node failed: %s\n", fdt_strerror(nodeoffset));
+		return;
+	}
+
+	addr_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0,
+						  "#address-cells", addr_cells_root);
+	size_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0,
+						  "#size-cells", size_cells_root);
+	fdt_setprop_u32(blob, nodeoffset, "#address-cells", addr_cells);
+	fdt_setprop_u32(blob, nodeoffset, "#size-cells", size_cells);
+
+	fdt_setprop_empty(blob, nodeoffset, "ranges");
+
+	header_addr = (u64)lib_sysinfo.header;
+	header_size = lib_sysinfo.header->header_bytes + lib_sysinfo.header->table_bytes;
+
+	sprintf(node, "coreboot@%llx", header_addr);
+	nodeoffset = fdt_add_subnode(blob, nodeoffset, node);
+	if (nodeoffset < 0) {
+		log_err("Add '%s' node failed: %s\n", node, fdt_strerror(nodeoffset));
+		return;
+	}
+
+	fdt_setprop_string(blob, nodeoffset, "compatible", "coreboot");
+
+	if (addr_cells == 1) {
+		fdt_setprop_u32(blob, nodeoffset, "reg", header_addr);
+	} else if (addr_cells == 2) {
+		fdt_setprop_u64(blob, nodeoffset, "reg", header_addr);
+	} else {
+		log_err("Unsupported #address-cells: %u\n", addr_cells);
+		goto clean_coreboot;
+	}
+
+	if (size_cells == 1) {
+		fdt_appendprop_u32(blob, nodeoffset, "reg", header_size);
+	} else if (size_cells == 2) {
+		fdt_appendprop_u64(blob, nodeoffset, "reg", header_size);
+	} else {
+		log_err("Unsupported #size-cells: %u\n", addr_cells);
+		goto clean_coreboot;
+	}
+
+	cbmem_addr = cbmem_range->base;
+	cbmem_size = cbmem_range->size;
+
+	if (addr_cells == 1) {
+		fdt_appendprop_u32(blob, nodeoffset, "reg", cbmem_addr);
+	} else if (addr_cells == 2) {
+		fdt_appendprop_u64(blob, nodeoffset, "reg", cbmem_addr);
+	} else {
+		log_err("Unsupported #address-cells: %u\n", addr_cells);
+		goto clean_coreboot;
+	}
+
+	if (size_cells == 1) {
+		fdt_appendprop_u32(blob, nodeoffset, "reg", cbmem_size);
+	} else if (size_cells == 2) {
+		fdt_appendprop_u64(blob, nodeoffset, "reg", cbmem_size);
+	} else {
+		log_err("Unsupported #size-cells: %u\n", addr_cells);
+		goto clean_coreboot;
+	}
+
+	fdt_setprop_u32(blob, nodeoffset, "board-id", lib_sysinfo.board_id);
+	fdt_setprop_u32(blob, nodeoffset, "sku-id", lib_sysinfo.sku_id);
+	fdt_setprop_u32(blob, nodeoffset, "ram-code", lib_sysinfo.ram_code);
+	if (lib_sysinfo.fw_config != ~0ULL)
+		fdt_setprop_u64(blob, nodeoffset, "fw-config", lib_sysinfo.fw_config);
+
+clean_coreboot:
+	fdt_del_node_and_alias(blob, node);
+}
+#endif
-- 
Sent by a computer, using git, on the internet

