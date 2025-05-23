Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B2AC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E156E835C1;
	Sat, 24 May 2025 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ILemNurr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B1083416; Sat, 24 May 2025 00:59:16 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98A38338C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30e8a968b15so378156a91.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041152; x=1748645952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDuNq/WSWsvSre4nphDo6pZ9Wej2ekuXzods2se/sPM=;
 b=ILemNurrdfEQcifeKDtMRKvKWVHtTXX7T+oAVyBt7Ihu9skCJj3ueWgLWwjYmZei7e
 qkrZRJGVdpMhdRK/JUFXd3kV2lXntgW5PdJn6VyteAKrTB/AblIcbrXsoF9gxtsqImc9
 pjuI3WCigGO3O5FPgNJ6hoGjQ2ZswZC/QaS80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041152; x=1748645952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDuNq/WSWsvSre4nphDo6pZ9Wej2ekuXzods2se/sPM=;
 b=pLNOAHJLuD8aVYHOZl0g2Ff1nINhfqu7gsMd44aYV9chvxXrf3u0E9G6kyfb2Xelho
 5MqyO+QLvXgsl2BxGCw6+b++H+Xqwzrh/DPb4PylDydY+VpdK61ViQ1vuTlFxDk9Kl4D
 h4maX58FKCkr836/FmFTU5GYbPKApvnPHC50pWQkddQrvg2jPqm1xcrE95xc5Ac3Hjc+
 3ezC7zySHLNZCJt0eNOrt9MWIU6wvDHiqKtKFn4h2L6gQEc8ip5TzN0k/+e3w2jad23/
 O1HOp37/00kWEjWbFdtzKph7IgQ/1hm9J4nrsrYSo0QJe/n9zgJgF942l76K43JDUCGp
 P83w==
X-Gm-Message-State: AOJu0YxZckMXaz7a42Zt3oPgjBKXYpy2IMOGrkPQE8HAVy9iXpnck7kf
 Ee33xO8kEJ+Ut7Q902CnuUsghWXDsdLhUMFVoHY5bGE59y0y8vi9ytVX9gtfKu/ZLzoRMrdi82Y
 /Aw4=
X-Gm-Gg: ASbGncvFXmkeJuC1aqw9egq134XgMtArQR8kMR8sEantBU16F5+V3M5C+VBSH1/oHZl
 o2cVm1WVQdEx4Oz+aZpxNqKaW63VZfkOTnrZQpDI8MDRBrG8Y+suZ21FBCUnx3UzWp74GbQa9hV
 9Sn9MgM2MITldJyOolT5Oe37GnqPiCEzyA5rHYQvKMQThzla8UdnGeLnV5KfvGme0CclaZyJpGT
 b/j91tt4sp9bDFgq+dA/8hc3dJmnb4AhXKZqPKLPR4szXtRQHYnwcKuBZGMn7I5l7G3cUL2hPHh
 H1YWIK9INWI5/Rt++XC/q9jfh+CpW6yAUdt5ZJYf+lTF5CU12t0K+J6zDE8O4msPLX3dKm/yIVL
 LN+wI+3AdFa3zGmw=
X-Google-Smtp-Source: AGHT+IEaRZKEzJpRmSJEwAmAlm3gVWr7TyIJaNR+hqwY6y+zYiNQtIGIQaYIKJTI6Uvw6Y+7VK1rgA==
X-Received: by 2002:a17:90b:52c6:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-3110f11380cmr1336162a91.7.1748041152119; 
 Fri, 23 May 2025 15:59:12 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf8db5csm13273538a12.34.2025.05.23.15.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:11 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 16/28] coreboot: Add /firmware/coreboot node to DT
Date: Fri, 23 May 2025 15:58:31 -0700
Message-ID: <20250523225845.2311989-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

