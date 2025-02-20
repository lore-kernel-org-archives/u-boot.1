Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67914C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E55880FE1;
	Thu, 20 Feb 2025 22:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6+zFeD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5866806FE; Thu, 20 Feb 2025 21:59:22 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF0A8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so2292886a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085158; x=1740689958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgLFe7t1W91O43t4HnenUuXUHLpSnhQT3kznYjy5gog=;
 b=C6+zFeD7m2suBHGmKnf9Lxq9Se9CgwDJlap21tkTUFooxh33H6BC6cd0IyoFEL4ZLP
 ukqd7doK+uQq7e/MqAXOtdYDikw/HU4toKf5DWmkvbt4YAe98ZvC2fT9u9oEBqAqeOEB
 0ysUgjyEt4PCXAKMyOFdHLyFvS/vJMQcsGM84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085158; x=1740689958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgLFe7t1W91O43t4HnenUuXUHLpSnhQT3kznYjy5gog=;
 b=UDJoU+NjGPC7fy5Qjy+EACRrXei4runVbI6FFECGA9qvu2wsQ+Qj/t7j+tmrNRCbkA
 APvWjuCaXZWvRSQpkk3guiacKYHcgtlL0UnXIBuPIHcbmKGdPYaa1NtRZ8sdxLFqLmGX
 ApwBw89JvQTIBrbU2MeS9iSZEwtQ5cmb7fXrhXFOjG1cdLiKEWGu5UXqcQMKWHyrEk6c
 mIJDu1IoMYMZXCOKIERMr7nYe6+PgEl+VjXxfcz+HzD+yBVKRjdf2bwD1NzqQF3sqtO0
 Ks3cyhhLs1XCgnZ/ssLNMbQ/21qXkhTc3sqVQPFSd6fzPG5p1IqaVNiu96JzWfnOK1P+
 yWaQ==
X-Gm-Message-State: AOJu0Yzq1snzoOX0bl5u9WPBiH9C3kDvoyz3NaL8GCWBAFVEkSr6nnAa
 bqH+3KHLHasePqVptM74m2Yi2gb/5SHnLkVC4G2d8CvtI2gt811RoTVvg0CeUBsfbQxfc5q92Mg
 =
X-Gm-Gg: ASbGncvfQOujttkk25R9YNbDsbad92aXHHb039KG/R39mWG7yZ2J976XLIFeh45fjZq
 bX6619BBfHUdFoZFcy3YoJlCGEXc+ZAqnMJuyq6Mt+iZ3YAivufH1T4PlsUnkKRsCMrU1eVHQBr
 NDeICESPvvWcppso2FhuJSvdedYhMx2GYYaAkHXS5/3QLx2I/VD8fL43P7VmcbTZeGCXNmjaO7F
 ibNyVjynBFrAJvWLfmwi/DXNX1QsZfTTGxfoXvEayzv0f59IX3Qq49eDCNWJaptoTh1ZG5/XKUO
 t1Q+GgX2H4uZNK8m2QLCPUaPTNXQONfeaHAOywsZaj7ehffwM7JoeKc=
X-Google-Smtp-Source: AGHT+IESclbc+0me1eASmWfPQJQQjWQ0D1tbsQsVMPWnVDz1219eV5qMQkF3+yMoehZYG2JBy+FjwQ==
X-Received: by 2002:a17:90b:4c50:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2fce86adfe3mr305325a91.8.1740085156670; 
 Thu, 20 Feb 2025 12:59:16 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fbf98d3d16sm16316700a91.13.2025.02.20.12.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:16 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 10/12] coreboot: Add /firmware/coreboot node to DT
Date: Thu, 20 Feb 2025 12:58:52 -0800
Message-ID: <20250220205900.3127680-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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
 include/cb_sysinfo.h      |   2 +
 lib/coreboot/cb_sysinfo.c | 120 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

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
index 6561f99fe26d..e50b4dfe12c1 100644
--- a/include/cb_sysinfo.h
+++ b/include/cb_sysinfo.h
@@ -250,6 +250,8 @@ int get_coreboot_info(struct sysinfo_t *info);
  */
 const struct sysinfo_t *cb_get_sysinfo(void);
 
+void fdt_fixup_coreboot(void *blob);
+
 int dram_init_banksize_from_coreboot(void);
 int dram_init_from_coreboot(void);
 phys_addr_t board_get_usable_ram_top_from_coreboot(phys_size_t total_size);
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index c0c6a96debec..d2b228307c3b 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -7,6 +7,7 @@
  */
 
 #include <cb_sysinfo.h>
+#include <fdt_support.h>
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
@@ -494,3 +495,122 @@ const struct sysinfo_t *cb_get_sysinfo(void)
 
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

