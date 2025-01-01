Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D4EE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1166C80763;
	Wed,  1 Jan 2025 23:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hjfgdn6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B8580758; Wed,  1 Jan 2025 23:23:38 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD7A8071F
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2161eb94cceso103136735ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770213; x=1736375013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I9uuNBMQPdGc4SsIZxAI1r6JuheVEu2rp81t5mVpwg=;
 b=Hjfgdn6VG5UHGTJCPkJ6WDpjj0MVx2lR48nMLm8gmUfyOu/so9yXpyZP1wNkzFPRqN
 Wyy2ITnJJ3ExFHjZ9C6X0Zm2omJ8oCvSZdu6m2NinAtaHysd05Dt8fk8A6OqcioAv434
 qv/26zx/ovejbWSMDqQO3sz1u+e6+OCKzY70o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770213; x=1736375013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6I9uuNBMQPdGc4SsIZxAI1r6JuheVEu2rp81t5mVpwg=;
 b=nYy7Yh4ZLjXjaEhAKsRNLbFsBkOQimN02+R+t+jdLVVt/kxYUiJ5hRcGOmqL4TlBaI
 3+O0hJV9Ansrwz1CnnIHUx0xPjRaMVRmJmyY0qGFldDh+PvvCsQkGIPDpeVEDKZaTRLl
 prg5kwtLsx9GK16Iqs5JAgAo40+KagkY/m85+RrlMb2wHfACnHNbKYh0EANX7+7fakDN
 TrTJg53/VKS9kKSppmx45QA2ngpSMH4iVGjiB+0STp5tuKQMUJ/F7a1DjRG4P+W9ssu0
 4ovIFtFkTqwhrhV1J08kZxts9W/uYjmlsjTHD11ZzINVoXOtCh9RFpEV5dPDitsntgnO
 KcWg==
X-Gm-Message-State: AOJu0YwQdS927Z3Eu9oYDixUHyUJMfvE0Ifjsh73CGsjQd/MDtKv/tR/
 R/TVp+x1SkDEWLaq+udFG5KApuoz0sU8Z21lzMS1KqncqQnV1ZUpgMRdjwxO6X5koe5Xa5hmpKA
 =
X-Gm-Gg: ASbGnctCG4bAOjd8eJXg0lzrjKZvu4VqX+tRaxbH5v14rzxrH6a2AQxh/2Y+4EGuUO/
 wgOWozLC3qTm5WkTnYQi8vpRzlJAqE0xDZ989R+Yp9YNboFVuRgTIJYRNkAeM52rCqIOcl7DUIN
 WZiUfF9UVfqMbjBSQEETFSTRu5OyqF2bKvff+I1xN+a4826MRPYZend+kceyuRIeib3oTl8e0sr
 sVW18qYXX6G5deltzVxg0i7dFcLQaFA/3TM6Wk8OegRJR8G5K1YTi0=
X-Google-Smtp-Source: AGHT+IFqsek5X80HU0rHeQokRgSXeF3jVYv8hgXos7q0Dtuin/nSNv0MivRlOmZ7jnA7+c6J8dndEA==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-72abdd9603cmr75178653b3a.8.1735770213372; 
 Wed, 01 Jan 2025 14:23:33 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 66/67] upl: Add reserved memory for the ACPI and SMBIOS tables
Date: Thu,  2 Jan 2025 11:09:52 +1300
Message-ID: <20250101221003.1944600-67-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Mark these as reserved memory-regions so that the payload can find the
tables. Remove the upl-params properties which are no-longer in the
spec. Add a compatible string instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c | 40 +++++++++++++++++++++++++++++++++++++++-
 boot/upl_read.c   | 25 ++++++++++++++++++-------
 boot/upl_write.c  | 38 +++++++++++++++++++++++++++++++-------
 include/alist.h   |  2 +-
 include/upl.h     | 21 +++++++++++++++++++--
 lib/alist.c       |  2 +-
 test/boot/upl.c   | 13 +++++++++----
 7 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index e60f22f47e0..e07a07cc945 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <bloblist.h>
 #include <cpu.h>
 #include <dm.h>
 #include <serial.h>
@@ -138,7 +139,8 @@ int upl_create(struct upl *upl)
 {
 	struct upl_mem mem;
 	ulong base, size;
-	int ret;
+	int ret, bsize;
+	void *ptr;
 
 	/* hard-code this for now to keep Tianocore happy */
 	upl->addr_cells = 2;
@@ -158,12 +160,28 @@ int upl_create(struct upl *upl)
 	if (!alist_add(&upl->mem, mem))
 		return log_msg_ret("arg", -ENOMEM);
 
+	ptr = bloblist_get_blob(BLOBLISTT_SMBIOS_TABLES, &bsize);
+	if (ptr) {
+		upl->smbios.base = map_to_sysmem(ptr);
+		upl->smbios.size = bsize;
+	}
+	ptr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &bsize);
+	if (ptr) {
+		upl->acpi.base = map_to_sysmem(ptr);
+		upl->acpi.size = bsize;
+	}
+
 	ret = upl_add_serial(&upl->serial);
 	if (ret && ret != -ENOENT)
 		return log_msg_ret("ser", ret);
 	ret = upl_add_graphics(&upl->graphics, &base, &size);
 	if (ret && ret != -ENOENT)
 		return log_msg_ret("gra", ret);
+	if (!ret) {
+		ret = upl_add_memres(upl, UPLN_MEMORY, base, size, true);
+		if (ret)
+			return log_msg_ret("grr", ret);
+	}
 
 	return 0;
 }
@@ -201,6 +219,26 @@ int upl_add_region(struct alist *lst, u64 base, ulong size)
 	return 0;
 }
 
+int upl_add_memres(struct upl *upl, const char *name, u64 base, ulong size,
+		   bool no_map)
+{
+	struct upl_memres memres;
+	int ret;
+
+	log_debug("base = %llx size = %lx\n", base, size);
+	memset(&memres, '\0', sizeof(memres));
+	alist_init_struct(&memres.region, struct memregion);
+	memres.name = name;
+	memres.no_map = no_map;
+	ret = upl_add_region(&memres.region, base, size);
+	if (ret)
+		return log_msg_ret("uav", ret);
+	if (!alist_add(&upl->memres, memres))
+		return log_msg_ret("uaM", -ENOMEM);
+
+	return 0;
+}
+
 void upl_init(struct upl *upl)
 {
 	memset(upl, '\0', sizeof(struct upl));
diff --git a/boot/upl_read.c b/boot/upl_read.c
index 4f07204546e..05db559efdb 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -248,12 +248,6 @@ static int decode_upl_params(struct upl *upl, ofnode options)
 		return log_msg_ret("par", -EINVAL);
 	log_debug("decoding '%s'\n", ofnode_get_name(node));
 
-	ret = read_addr(upl, node, UPLP_SMBIOS, &upl->smbios);
-	if (ret)
-		return log_msg_ret("smb", ret);
-	ret = read_addr(upl, node, UPLP_ACPI, &upl->acpi);
-	if (ret)
-		return log_msg_ret("acp", ret);
 	ret = ofnode_read_bitmask(node, UPLP_BOOTMODE, bootmode_names,
 				  UPLBM_COUNT, &upl->bootmode);
 	if (ret)
@@ -416,7 +410,7 @@ static int decode_upl_memres(struct upl *upl, ofnode root)
 
 	ofnode_for_each_subnode(node, root) {
 		struct upl_memres memres;
-		const char *buf;
+		const char *buf, *compat;
 		int size, len;
 
 		log_debug("decoding '%s'\n", ofnode_get_name(node));
@@ -434,6 +428,23 @@ static int decode_upl_memres(struct upl *upl, ofnode root)
 			return log_msg_ret("buf", len);
 		memres.no_map = ofnode_read_bool(node, UPLP_NO_MAP);
 
+		compat = ofnode_read_string(node, UPLP_COMPATIBLE);
+		if (compat && memres.region.count == 1) {
+			const struct memregion *rgn;
+
+			rgn = alist_get(&memres.region, 0, struct memregion);
+			if (!strcmp(compat, UPLP_SMBIOS))
+				upl->smbios = *rgn;
+			else if (!strcmp(compat, UPLP_ACPI))
+				upl->acpi = *rgn;
+			else
+				log_warning("Ignoring compat '%s'\n", compat);
+
+			/* don't add this node to the memres list */
+			alist_uninit(&memres.region);
+			continue;
+		}
+
 		if (!alist_add(&upl->memres, memres))
 			return log_msg_ret("mre", -ENOMEM);
 	}
diff --git a/boot/upl_write.c b/boot/upl_write.c
index ce9f733b450..5db5d02e6e8 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -228,10 +228,6 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 		return log_msg_ret("img", ret);
 
 	ret = ofnode_write_string(node, "compatible", UPLP_UPL_PARAMS_COMPAT);
-	if (!ret)
-		ret = write_addr(upl, node, UPLP_SMBIOS, upl->smbios);
-	if (!ret)
-		ret = write_addr(upl, node, UPLP_ACPI, upl->acpi);
 	if (!ret && upl->bootmode)
 		ret = ofnode_write_bitmask(node, UPLP_BOOTMODE, bootmode_names,
 					   UPLBM_COUNT, upl->bootmode);
@@ -350,6 +346,8 @@ static int write_mem_node(const struct upl *upl, ofnode parent,
 		return log_msg_ret("wmn", ret);
 
 	len = encode_reg(upl, buf, sizeof(buf), mem->count, mem);
+	if (len < 0)
+		return log_msg_ret("uer", ret);
 	ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
 	if (ret)
 		return log_msg_ret("wm1", ret);
@@ -437,7 +435,8 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 			  bool skip_existing)
 {
 	const struct upl_memres *memres;
-	ofnode mem_node;
+	struct alist region;
+	ofnode mem_node, node;
 	int ret;
 
 	if (!upl->memres.count)
@@ -453,8 +452,6 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 		return log_msg_ret("im2", ret);
 
 	alist_for_each(memres, &upl->memres) {
-		ofnode node;
-
 		ret = write_mem_node(upl, mem_node, &memres->region,
 				     memres->name, &node);
 		if (ret)
@@ -467,6 +464,33 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 			return log_msg_ret("lst", ret);
 	}
 
+	if (upl->smbios.base) {
+		alist_init_struct(&region, struct memregion);
+		if (!alist_add(&region, upl->smbios))
+			return log_msg_ret("ups", ret);
+		ret = write_mem_node(upl, mem_node, &region, UPLN_MEMORY,
+				     &node);
+		alist_uninit(&region);
+		if (ret)
+			return log_msg_ret("mrs", ret);
+		ret = ofnode_write_string(node, UPLP_COMPATIBLE, UPLP_SMBIOS);
+		if (ret)
+			return log_msg_ret("mrS", ret);
+	}
+	if (upl->acpi.base) {
+		alist_init_struct(&region, struct memregion);
+		if (!alist_add(&region, upl->acpi))
+			return log_msg_ret("upa", ret);
+		ret = write_mem_node(upl, mem_node, &region, UPLN_MEMORY,
+				     &node);
+		alist_uninit(&region);
+		if (ret)
+			return log_msg_ret("mra", ret);
+		ret = ofnode_write_string(node, UPLP_COMPATIBLE, UPLP_ACPI);
+		if (ret)
+			return log_msg_ret("mrA", ret);
+	}
+
 	return 0;
 }
 
diff --git a/include/alist.h b/include/alist.h
index b00d9ea97d6..8aac5cd46ec 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -184,7 +184,7 @@ void *alist_add_placeholder(struct alist *lst);
  * @obj: Pointer to object to copy in
  * Returns: pointer to where the object was copied, or NULL if out of memory
  */
-void *alist_add_ptr(struct alist *lst, void *obj);
+void *alist_add_ptr(struct alist *lst, const void *obj);
 
 /**
  * alist_expand_by() - Expand a list by the given amount
diff --git a/include/upl.h b/include/upl.h
index f210a39df0c..eb7ef463b9e 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -288,6 +288,8 @@ struct upl_pci {
  *
  * @addr_cells: Number of address cells used in the handoff
  * @size_cells: Number of size cells used in the handoff
+ * @smbios: SMBIOS region, base is 0 if none
+ * @acpi: ACPI region, base is 0 if none
  * @bootmode: Boot-mode mask (enum upl_boot_mode)
  * @fit: Address and size of FIT image that was loaded
  * @conf_offset: Offset in FIT of the configuration that was selected
@@ -301,8 +303,8 @@ struct upl {
 	int addr_cells;
 	int size_cells;
 
-	ulong smbios;
-	ulong acpi;
+	struct memregion smbios;
+	struct memregion acpi;
 	enum upl_boot_mode bootmode;
 	struct memregion fit;
 	uint conf_offset;
@@ -475,6 +477,21 @@ int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf);
  * Return: 0 if OK, -ve on error
  */
 int upl_add_region(struct alist *lst, u64 base, ulong size);
+
+/**
+ * upl_add_memres() - Add a new reserved-memory region
+ *
+ * Adds a new entry to the end of the memres list
+ *
+ * @upl: UPL to add to
+ * @name: Node name to use for new region)
+ * @base: Base address of new region
+ * @size: Size of new region
+ * @no_map: true if the no-map property should be enabled
+ * Return: 0 if OK, -ve on error
+ */
+int upl_add_memres(struct upl *upl, const char *name, u64 base, ulong size,
+		   bool no_map);
 #endif
 
 /**
diff --git a/lib/alist.c b/lib/alist.c
index 4ce651f5c45..05399c78a92 100644
--- a/lib/alist.c
+++ b/lib/alist.c
@@ -167,7 +167,7 @@ void *alist_add_placeholder(struct alist *lst)
 	return alist_ensure_ptr(lst, lst->count);
 }
 
-void *alist_add_ptr(struct alist *lst, void *obj)
+void *alist_add_ptr(struct alist *lst, const void *obj)
 {
 	void *ptr;
 
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 91b7baa75e2..ae7abed72f1 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -26,6 +26,7 @@ static int add_region(struct unit_test_state *uts, struct alist *lst,
 {
 	struct memregion region;
 
+	memset(&region, '\0', sizeof(region));
 	region.base = base;
 	region.size = size;
 	ut_assertnonnull(alist_add(lst, region));
@@ -44,8 +45,10 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 
 	upl->addr_cells = 1;
 	upl->size_cells = 1;
-	upl->smbios = 0x123;
-	upl->acpi = 0x456;
+	upl->smbios.base = 0x123;
+	upl->smbios.size = 0x321;
+	upl->acpi.base = 0x456;
+	upl->acpi.size = 0x654;
 	upl->bootmode = BIT(UPLBM_DEFAULT) | BIT(UPLBM_S3);
 	upl->fit.base = 0x789;
 	upl->fit.size = 0xabc;
@@ -294,8 +297,10 @@ static int compare_upl(struct unit_test_state *uts, struct upl *base,
 	ut_asserteq(base->addr_cells, cmp->addr_cells);
 	ut_asserteq(base->size_cells, cmp->size_cells);
 
-	ut_asserteq(base->smbios, cmp->smbios);
-	ut_asserteq(base->acpi, cmp->acpi);
+	ut_asserteq(base->smbios.base, cmp->smbios.base);
+	ut_asserteq(base->smbios.size, cmp->smbios.size);
+	ut_asserteq(base->acpi.base, cmp->acpi.base);
+	ut_asserteq(base->acpi.size, cmp->acpi.size);
 	ut_asserteq(base->bootmode, cmp->bootmode);
 	ut_asserteq(base->fit.base, cmp->fit.base);
 	ut_asserteq(base->fit.size, cmp->fit.size);
-- 
2.43.0

