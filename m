Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1148DE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A168066C;
	Wed,  1 Jan 2025 23:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TOs3aUba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B215C80391; Wed,  1 Jan 2025 23:17:09 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419CF8066C
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163bd70069so47542835ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769825; x=1736374625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eOJYzMC8vj2ThRU2wXtkkP1FS5FpSTk35GcwARygE8=;
 b=TOs3aUbafN5+cBr4vnZW0uYDr6gznP26sIpplThUoaiyOfh/qn82FjCCPd3c3rVVde
 s0g9r16x1XRVh7TTC8yZ8G8yU8TCC9Qj5mdFbOiSoXwtr9wRX9GYHGlaEYdaEY/LnVOv
 78b7ajozmQ4fC9OoCN2n0LbSdvoX5bSi2T7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769825; x=1736374625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3eOJYzMC8vj2ThRU2wXtkkP1FS5FpSTk35GcwARygE8=;
 b=p5uWetNpI6gDdzPYKkD64KuvrtKtns0wN8OUDg7c2oN7Abnqfzi258D1ubLe2Mqo77
 1oSL2kXmG3IbZUrKjAWevfFiq7mCTthpZCuKZ4MeTQisgR51EleGfXdTKgtC/o+Skq0u
 YnQcB975dHIHoexEWqyfx5X6FdSJLzjwQn1tY3SD5Nz/mNACpmv+6d83S03qckW7+u/x
 a0k9pbQdco7/FEvSpTof9YJaqLqudBNXd3MUSS//TapHGo58rbwQfWanSyO+jJlq8cVY
 LyrbTuiiqgGSY7KBwV1qxGhkNyoUvLu4E4Uv/8bH3hlBogkC+OIPdPdL+3xfVhYPqVEX
 rk6Q==
X-Gm-Message-State: AOJu0YzUNr19fG/W+XIXeKoOyJlHQXuuSh5OYqn/3Y6KxaK+ZWt/J3R2
 fk7CWsnGtBiOhV+1PzejXPjgs+8QLmaVaxsxt6FjL6PI1hE/GsftvS57xB13XE75Po7NtJE3UOY
 =
X-Gm-Gg: ASbGnctPvBikp7VEjmrqdNmkBJ4HLW77Zo8Ge/hRYwtceOjg9i6PDitnzqVg3h3/sRu
 2RZrygKC0Eq0n94ZLrOJoXnyOoa7ZWtZHjIx54LudiblY7NiGPCQHmWfs9NJKHOYyPOVkicnuXX
 34wQc+iAc5ROXz4JJU7lMeZm/Cwr5oBerKbf3oYSHS2wbFW0l8pxLufQHhkSH1eaLbgPGY7uAzP
 hT/fBwMfW7xONbiRinDg2C6/ykKlcXCnqPGiRJKA7Hhsrfj7U2P1s4=
X-Google-Smtp-Source: AGHT+IF8czz4tGxJmMlutjdjG887Df0p9zpb1qPdW5mQ0CqtMbyM55m9cfP5Q/b+oAGu/lIXgNLqSA==
X-Received: by 2002:a05:6a20:a108:b0:1e1:bdae:e04d with SMTP id
 adf61e73a8af0-1e5e0811790mr64425748637.36.1735769825177; 
 Wed, 01 Jan 2025 14:17:05 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:17:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 40/67] upl: Add a function to write a UPL handoff to an abuf
Date: Thu,  2 Jan 2025 11:09:26 +1300
Message-ID: <20250101221003.1944600-41-sjg@chromium.org>
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

Create a convenience function which can write a UPL handoff into an abuf
and return it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 boot/upl_write.c     | 28 ++++++++++++++++++++++++++
 common/spl/spl_upl.c | 26 ++++--------------------
 include/upl.h        | 23 +++++++++++++++++++++
 4 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index 01301049341..b0246f72597 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <cpu.h>
 #include <dm.h>
 #include <serial.h>
 #include <string.h>
@@ -130,6 +131,53 @@ int upl_add_graphics(struct upl_graphics *gra, ulong *basep, ulong *sizep)
 	return 0;
 }
 
+int upl_create(struct upl *upl)
+{
+	ulong base, size;
+	int ret;
+
+	/* hard-code this for now to keep Tianocore happy */
+	upl->addr_cells = 2;
+	upl->size_cells = 1;
+
+	upl->bootmode = 0;
+	log_debug("conf_offset %d\n", upl->conf_offset);
+	if (IS_ENABLED(CONFIG_X86))
+		upl->addr_width =  cpu_phys_address_size();
+
+	/* no reserved memory */
+
+	ret = upl_add_serial(&upl->serial);
+	if (ret && ret != -ENOENT)
+		return log_msg_ret("ser", ret);
+	ret = upl_add_graphics(&upl->graphics, &base, &size);
+	if (ret && ret != -ENOENT)
+		return log_msg_ret("gra", ret);
+
+	return 0;
+}
+
+int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf)
+{
+	int ret;
+
+	ret = upl_create(upl);
+	if (ret)
+		return log_msg_ret("uwr", ret);
+
+	log_debug("writing to root node %d\n", ofnode_to_offset(root));
+	ret = upl_write_handoff(upl, root, true);
+	if (ret)
+		return log_msg_ret("wr", ret);
+
+	ret = oftree_to_fdt(oftree_default(), buf);
+	if (ret)
+		return log_msg_ret("fdt", ret);
+	log_debug("FDT size %zx\n", abuf_size(buf));
+
+	return 0;
+}
+
 void upl_init(struct upl *upl)
 {
 	memset(upl, '\0', sizeof(struct upl));
diff --git a/boot/upl_write.c b/boot/upl_write.c
index 60548937090..c53fa5396e8 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -625,3 +625,31 @@ int upl_create_handoff_tree(const struct upl *upl, oftree *treep)
 
 	return 0;
 }
+
+int upl_create_handoff(struct upl *upl, ulong addr, struct abuf *buf)
+{
+	oftree tree;
+	int ret;
+
+	ret = upl_create(upl);
+	if (ret) {
+		log_debug("Failed to create handoff (err=%dE)\n", ret);
+		return log_msg_ret("cho", ret);
+	}
+	log_debug("2a images %d\n", upl->image.count);
+
+	ret = oftree_new(&tree);
+	if (ret)
+		return log_msg_ret("new", ret);
+
+	ret = upl_write_handoff(upl, oftree_root(tree), true);
+	if (ret)
+		return log_msg_ret("wr", ret);
+
+	ret = oftree_to_fdt(tree, buf);
+	if (ret)
+		return log_msg_ret("fdt", ret);
+	oftree_dispose(tree);
+
+	return 0;
+}
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index a78ae75e56c..2bc0e265661 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -15,8 +15,6 @@
 #include <spl.h>
 #include <upl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 struct upl s_upl;
 
 void upl_set_fit_addr(ulong fit)
@@ -53,38 +51,22 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
 
 int spl_write_upl_handoff(void)
 {
-	struct upl *upl = &s_upl;
-	ulong addr, size;
+	struct upl s_upl, *upl = &s_upl;
 	struct abuf buf;
-	ofnode root;
 	void *ptr;
 	int ret;
 
 	log_debug("UPL: Writing handoff - image_count=%d\n", upl->image.count);
-	upl->addr_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
-	upl->size_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
-	upl->bootmode = UPLBM_DEFAULT;
-	ret = upl_add_serial(&upl->serial);
-	if (ret)
-		return log_msg_ret("ser", ret);
-	ret = upl_add_graphics(&upl->graphics, &addr, &size);
-	if (ret && ret != -ENOENT)
-		return log_msg_ret("gra", ret);
-
-	root = ofnode_root();
-	ret = upl_write_handoff(upl, root, true);
-	if (ret)
-		return log_msg_ret("wr", ret);
 
-	ret = oftree_to_fdt(oftree_default(), &buf);
+	ret = upl_write_to_buf(upl, ofnode_root(), &buf);
 	if (ret)
-		return log_msg_ret("fdt", ret);
-	log_debug("FDT size %zx\n", abuf_size(&buf));
+		return log_msg_ret("wuh", ret);
 
 	ptr = bloblist_add(BLOBLISTT_CONTROL_FDT, abuf_size(&buf), 0);
 	if (!ptr)
 		return log_msg_ret("blo", -ENOENT);
 	memcpy(ptr, abuf_data(&buf), abuf_size(&buf));
+	abuf_uninit(&buf);
 
 	return 0;
 }
diff --git a/include/upl.h b/include/upl.h
index edd333f648a..ce357d16ebe 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -394,6 +394,29 @@ int upl_add_serial(struct upl_serial *ser);
  */
 int upl_add_graphics(struct upl_graphics *gra, ulong *basep, ulong *sizep);
 
+/**
+ * upl_create() - Create a basic UPL handoff structure
+ *
+ * Sets up common fields which don't depend on having a FIT available
+ *
+ * @upl: UPL structure to create
+ * Return: 0 if OK, -ve on error
+ */
+int upl_create(struct upl *upl);
+
+#ifndef USE_HOSTCC
+/**
+ * upl_write_to_buf() - Write a UPL struct to a tree then flatten it into a buf
+ *
+ * @upl: UPL struct to fill up
+ * @root: Root node to write UPL information to (this is updated before the
+ *	finally buffer is written)
+ * @buf: Buffer to contain the final flattened tree
+ * Return: 0 if OK, -ve on error
+ */
+int upl_write_to_buf(struct upl *upl, ofnode root, struct abuf *buf);
+#endif
+
 /** upl_init() - Set up a UPL struct */
 void upl_init(struct upl *upl);
 
-- 
2.43.0

