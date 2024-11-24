Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE33E6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AD489595;
	Sun, 24 Nov 2024 21:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtGBQJqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16357895A4; Sun, 24 Nov 2024 21:27:41 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A189589595
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d01db666ceso3308873a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480058; x=1733084858; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/PbdUuyyMB+2vDC/D4lmQfpGBwk36cNcf834S6sHQ8=;
 b=MtGBQJqmV2T95HWexxCFE4KSEKOE0yyVFZ/7tSuYtYFrszNgGjgf52z0XE7IKut6dK
 Vg46buLqM7ld51nwVzdECOEXlB3JGZZVwPIPduxfvCb5nTQhbkQ89Fj32hrzzhL9AdCW
 8EuAuhtiUonsLPL918t9x68eEIPVELVljj4wxlnvlMFaq1fa0RTxEOFPDltAjrQyAL45
 AR8YexYmpclcHDx4dVv7uHMXc3em1v/lAptA6CDOGyyRsw006YZjlbeWqAA7an+wtL5Y
 A/xLHd5RoKDKbxvvp7vwUmtf5UxS1h3q0GGHF1eBnPlEKSENLyA4a1xNzsd1g+jd+p9+
 Btcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480058; x=1733084858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/PbdUuyyMB+2vDC/D4lmQfpGBwk36cNcf834S6sHQ8=;
 b=YhGQrMrqflDnZnu7Dnrw20YHYhIVvoAU9wtmqRCCBvExuj8hJzfTEpADwyAYL1W4eT
 CzMPaXj0RpQxFh4MZjevkHF0DujoFx0fGk1t/W5UwkAQF1Qbomp+vDJirjMAoJEp6jLm
 Ql35z8BIMx09n1GbMaRdAssAEIi3s/CceK+3AlKob2lflS+R/hnIWWAQqR/m7A+XT3B2
 yMXeT+3vPTWF7ljYBJVyz+kvmmTJYrG762QAZ7S4iKP2N00RIxxVFoqPp5oZuL0ta5Co
 EcwVQtFHvXZO0E/naVfrwxhdn4EhkMctqc8NHZ9GN4quWjxvOdL8hD1y0eFh4viMq6JR
 YpNw==
X-Gm-Message-State: AOJu0YwVkYYEAjC7/JTA2urRq5cZmWhU8LC7+KT8tIxxpidrv9VK2W3c
 3pyOazvuZZ6AUPxVOqtjWTSwjv5JfS2oWNPbkf2dBhgQXtnsuX/cqYB1d1eEG6s=
X-Gm-Gg: ASbGncuYYSpwvQTY3MsdK27PrdijsPzpqQPuPaK5G0O+T/1Tz0BFcM9L4LFAhVBkpRP
 RJH1yl0BLHwuC4FXFJXsE62Ium656H6Sa4LKC2BDw3skXfvTLvDhvd0V4XZVHGJaS/h8xaXvU4h
 6NZbLwYW+lAh6UI6s2ANf7B7n5VwdFlIPttNAH+6+oM1LK06c0Qi0YZX7iQ/5cHiUZ00Zyg2biH
 08bQr624lLxkbaRYo7Wgu+R6ZJwCTbTHFWE9jRedBnB+6GBbRsoLasLW71bBz3CrrZp
X-Google-Smtp-Source: AGHT+IGJcXo45hVuaWroI74sT3nYK3tLD/yomPrBDtAihDIjPOcIZPR9KK1guJlSklis8k/HKzDtdA==
X-Received: by 2002:a17:906:309a:b0:aa5:39d0:845a with SMTP id
 a640c23a62f3a-aa539d0b069mr445279566b.15.1732480058060; 
 Sun, 24 Nov 2024 12:27:38 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:37 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:00 +0100
Subject: [PATCH RFC 04/14] efi: stub: add helpers to populate memory map
 and framebuffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-4-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7609;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=DFfkuzxS+aC+qf3YS3hKZDlY6hipiZn6l+MnJwx2yuo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqPqzYyuMZsYzf5f5H2Y0+hbt/clywrmsisLTu5ZO
 d23VeZ/RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIayuG/9462op3kiNaSv4G
 HviR+ES7+vvHs/lmrFqLgplmyHKtOMHwV3rWZ+nvjHFXhd3WOQdoyb/2vHSs1UpbftbEpphrHnN
 WMwMA
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

Introduce two new helpers dram_init_banksize_from_efi() and
of_populate_from_efi(). These populate the DRAM bank info and simplefb
framebuffer OF node respectively using the EFI table populated by the
EFI stub.

dram_init_banksize_from_efi() is directly moved from the x86 payload
code to make it available for other boards.

Populating the simplefb node allows for an easy way to bring up video
without the full heft of VIDEO_EFI which is not particularly well-suited
to ARM.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/x86/cpu/efi/payload.c |  31 +------------
 include/efi_stub.h         |  22 ++++++++++
 lib/efi/efi_info.c         | 107 +++++++++++++++++++++++++++++++++++++++++++++
 lib/of_live.c              |   9 ++++
 4 files changed, 139 insertions(+), 30 deletions(-)

diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 68cda25aca63..b71917615d13 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -100,38 +100,9 @@ int dram_init(void)
 }
 
 int dram_init_banksize(void)
 {
-	struct efi_mem_desc *desc, *end;
-	struct efi_entry_memmap *map;
-	int ret, size;
-	int num_banks;
-
-	ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
-	if (ret) {
-		/* We should have stopped in dram_init(), something is wrong */
-		debug("%s: Missing memory map\n", __func__);
-		return -ENXIO;
-	}
-	end = (struct efi_mem_desc *)((ulong)map + size);
-	desc = map->desc;
-	for (num_banks = 0;
-	     desc < end && num_banks < CONFIG_NR_DRAM_BANKS;
-	     desc = efi_get_next_mem_desc(desc, map->desc_size)) {
-		/*
-		 * We only use conventional memory and ignore
-		 * anything less than 1MB.
-		 */
-		if (desc->type != EFI_CONVENTIONAL_MEMORY ||
-		    (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
-			continue;
-		gd->bd->bi_dram[num_banks].start = desc->physical_start;
-		gd->bd->bi_dram[num_banks].size = desc->num_pages <<
-			EFI_PAGE_SHIFT;
-		num_banks++;
-	}
-
-	return 0;
+	return dram_init_banksize_from_efi();
 }
 
 int arch_cpu_init(void)
 {
diff --git a/include/efi_stub.h b/include/efi_stub.h
index 4780badd3ac4..ff3befd4830b 100644
--- a/include/efi_stub.h
+++ b/include/efi_stub.h
@@ -34,5 +34,27 @@ enum efi_entry_t {
  * of the requested type, -EPROTONOSUPPORT if the table has the wrong version
  */
 int efi_info_get(enum efi_entry_t type, void **datap, int *sizep);
 
+struct device_node;
+
+/**
+ * of_populate_from_efi() - Populate the live tree from EFI tables
+ *
+ * @root: Root node of tree to populate
+ *
+ * This function populates the live tree with information from EFI tables
+ * it is only applicable when running U-Boot as an EFI payload with
+ * CONFIG_EFI_STUB enabled.
+ */
+int of_populate_from_efi(struct device_node *root);
+
+/**
+ * dram_init_banksize_from_efi() - Initialize the memory banks from EFI tables
+ *
+ * This function initializes the memory banks from the EFI memory map table we
+ * stashed from the EFI stub. It is only applicable when running U-Boot as an
+ * EFI payload with CONFIG_EFI_STUB enabled.
+ */
+int dram_init_banksize_from_efi(void);
+
 #endif /* _EFI_STUB_H */
diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 32ba7e499c57..3fa594b34b42 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -9,8 +9,13 @@
 #include <efi_stub.h>
 #include <errno.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
+#include <efi_api.h>
+#include <dm/of.h>
+#include <dm/ofnode.h>
+#include <dm/of_access.h>
+#include <log.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 int efi_info_get(enum efi_entry_t type, void **datap, int *sizep)
@@ -46,4 +51,106 @@ err:
 	unmap_sysmem(info);
 
 	return -ENOSYS;
 }
+
+#ifdef CONFIG_OF_LIVE
+static int of_populate_framebuffer(struct device_node *root)
+{
+	struct device_node *chosen, *fb;
+	struct efi_entry_gopmode *mode;
+	ofnode node;
+	int ret, size;
+	u64 reg[2];
+	char fb_node_name[50] = { 0 };
+
+	ret = efi_info_get(EFIET_GOP_MODE, (void **)&mode, &size);
+	if (ret) {
+		printf("EFI graphics output entry not found\n");
+		return ret;
+	}
+
+	fb = of_find_node_opts_by_path(root, "/chosen/framebuffer", NULL);
+	/* framebuffer already defined */
+	if (fb)
+		return 0;
+
+	chosen = of_find_node_opts_by_path(root, "/chosen", NULL);
+	if (!chosen) {
+		ret = of_add_subnode(root, "chosen", -1, &chosen);
+		if (ret) {
+			debug("Failed to add chosen node\n");
+			return ret;
+		}
+	}
+	node = np_to_ofnode(chosen);
+	ofnode_write_u32(node, "#address-cells", 2);
+	ofnode_write_u32(node, "#size-cells", 2);
+	/*
+	 * In order for of_translate_one() to correctly detect an empty ranges property, the value
+	 * pointer has to be non-null even though the length is 0.
+	 */
+	of_write_prop(chosen, "ranges", 0, (void *)FDT_ADDR_T_NONE);
+
+	snprintf(fb_node_name, sizeof(fb_node_name), "framebuffer@%llx", mode->fb_base);
+	ret = of_add_subnode(chosen, fb_node_name, -1, &fb);
+	if (ret) {
+		debug("Failed to add framebuffer node\n");
+		return ret;
+	}
+	node = np_to_ofnode(fb);
+	ofnode_write_string(node, "compatible", "simple-framebuffer");
+	reg[0] = cpu_to_fdt64(mode->fb_base);
+	reg[1] = cpu_to_fdt64(mode->fb_size);
+	ofnode_write_prop(node, "reg", reg, sizeof(reg), true);
+	ofnode_write_u32(node, "width", mode->info->width);
+	ofnode_write_u32(node, "height", mode->info->height);
+	ofnode_write_u32(node, "stride", mode->info->pixels_per_scanline * 4);
+	ofnode_write_string(node, "format", "a8r8g8b8");
+
+	return 0;
+}
+#endif
+
+int of_populate_from_efi(struct device_node *root)
+{
+	int ret = 0;
+
+	if (CONFIG_IS_ENABLED(VIDEO_SIMPLE) && CONFIG_IS_ENABLED(OF_LIVE))
+		ret = of_populate_framebuffer(root);
+
+	return ret;
+}
+
+int dram_init_banksize_from_efi(void)
+{
+	struct efi_mem_desc *desc, *end;
+	struct efi_entry_memmap *map;
+	int ret, size;
+	int num_banks;
+
+	ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
+	if (ret) {
+		/* We should have stopped in dram_init(), something is wrong */
+		debug("%s: Missing memory map\n", __func__);
+		return -ENXIO;
+	}
+	end = (struct efi_mem_desc *)((ulong)map + size);
+	desc = map->desc;
+	for (num_banks = 0;
+	     desc < end && num_banks < CONFIG_NR_DRAM_BANKS;
+	     desc = efi_get_next_mem_desc(desc, map->desc_size)) {
+		/*
+		 * We only use conventional memory and ignore
+		 * anything less than 1MB.
+		 */
+		if (desc->type != EFI_CONVENTIONAL_MEMORY ||
+		    (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
+			continue;
+		gd->bd->bi_dram[num_banks].start = desc->physical_start;
+		gd->bd->bi_dram[num_banks].size = desc->num_pages <<
+			EFI_PAGE_SHIFT;
+		num_banks++;
+	}
+
+	return 0;
+}
diff --git a/lib/of_live.c b/lib/of_live.c
index 90b9459ede31..572ae09d377b 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -10,8 +10,9 @@
 
 #define LOG_CATEGORY	LOGC_DT
 
 #include <abuf.h>
+#include <efi_stub.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <of_live.h>
 #include <malloc.h>
@@ -334,8 +335,16 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
 		return ret;
 	}
 	debug("%s: stop\n", __func__);
 
+	/*
+	 * When booting with EFI_STUB we can automatically generate a framebuffer
+	 * node based on the EFI data.
+	 */
+	ret = of_populate_from_efi(*rootp);
+	if (ret)
+		debug("Failed to populate live tree nodes from EFI: err=%d\n", ret);
+
 	return ret;
 }
 
 void of_live_free(struct device_node *root)

-- 
2.47.0

