Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8250C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AD3812C3;
	Wed, 26 Feb 2025 23:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGyn1njZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC8181113; Wed, 26 Feb 2025 23:16:31 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F54080F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22328dca22fso3507125ad.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608188; x=1741212988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caZD4+6Fu97IvkxXS9osWMOG4jO3IF0dquqJ54ZioCg=;
 b=AGyn1njZRcik74XYtLG4fDo3f9UDJKM1ZNcPZZu0XtWPvb37pKZifAR8AeQKIeMAUE
 z/vJqOomNGiqyYjyBxhReDFWgieSFhc+YePmEgppKofAAyN+OTJcghHEfMpKYnD7QsS/
 Nf6QUFWwY7Qb9T2M8La7eml87OhkOrJkwRYcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608188; x=1741212988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caZD4+6Fu97IvkxXS9osWMOG4jO3IF0dquqJ54ZioCg=;
 b=tORhNBW1l13US4nnLHjeYcl8lrz0P8upVZXz5mG4a3LRwv6YX4P10amnVP3AF4EVin
 XRqZSMcDp768CH0WBe6loxRh0brSGCQ7IDufB624Rr21bfgc69LtQ1uLmLVpV6GYFHeo
 dm51A2Lym3yIYzBY4xdjzA7fF7RtOcX8gTcJvwMKqUDdOZc3Fat70ImVgpO6mGApbxLf
 mu4oVz1Oo6Y9+VXrDA9iQ4rXxaZjkHGH8sPIqSyI2+HWPjChx3y5Pdt3RoxNgEKPFPZp
 HnGbXxUU+UeM640wv5Gj/hkTas8iph5WLSJUc5If0A5wbdigQOUNz5Vg+C2nOZQKG7HG
 tGNA==
X-Gm-Message-State: AOJu0Yx32ey3f/XLlAfnLqzd0kz6oaemvb/ZcN45Vvdf/KzhsVYlLP2A
 /Hrvd3tmZzfBZlYGeAu4lL5T/rBQObD+zWziu0NRfVc5G7vDXewpbe5hHl6XQxX9d5FR03N2z3U
 =
X-Gm-Gg: ASbGncuSBZ83jInq3dgi/MqNKpgoXbMe7RByxn3Hg0QevPeGGVTQWrj4cDJKuaZVvRK
 7Y/R5T5yJfK8VBign34ApwPyQZXyihXnJFnIDLBAzS2OKp6kfAYP7BHXByeEOW0nR8Mwmqw2mff
 9im0Fs66L9ic3kirziTnJLfUOZ6y6Su8ektMD5RIwq7dUM4vfb6hMA5W4qt0uAwMh/DSg3hxvrK
 Yl//jYbmaP3P7bXdWGGrzFa+2HyvxOCX/lh29yI/mO9ZAq3h5fTP4AxRRpQbjWNOB5BO8uCKwsV
 52/fRG+8MEGQEyTaYsw+uzOty/IBduFBaleNF1ZymkWLoh8bnZPWSqPKKc8503Ut4Q==
X-Google-Smtp-Source: AGHT+IF/wTbys2xR6mk8OTmc/nGdXTIAk/XWBtwoklC7UIqZDV/FmUMaoGyFlpPWCH4p2ebRqInzSA==
X-Received: by 2002:a17:903:2342:b0:21f:89e5:2704 with SMTP id
 d9443c01a7336-22307e67531mr129295655ad.34.1740608187695; 
 Wed, 26 Feb 2025 14:16:27 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-223501d5153sm1359215ad.22.2025.02.26.14.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:25 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 11/15] coreboot: Add /firmware/coreboot node to DT
Date: Wed, 26 Feb 2025 14:15:57 -0800
Message-ID: <20250226221607.1283592-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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
index 9d1598b1a93c..d23d5438c0fa 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -8,6 +8,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <cb_sysinfo.h>
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
@@ -618,6 +619,9 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
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
index 604a276ea72b..ad08a01a81d5 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -257,6 +257,13 @@ int get_coreboot_info(struct sysinfo_t *info);
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
index 67497d4d65b4..7226b658c0d3 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -7,6 +7,7 @@
  */
 
 #include <cb_sysinfo.h>
+#include <fdt_support.h>
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
@@ -500,3 +501,122 @@ const struct sysinfo_t *cb_get_sysinfo(void)
 
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

