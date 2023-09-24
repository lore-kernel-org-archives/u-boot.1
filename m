Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB91CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B638286C1E;
	Sun, 24 Sep 2023 21:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GiW2XYIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4150C86C03; Sun, 24 Sep 2023 21:26:22 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3153286B8F
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79f9acc857cso139629239f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583571; x=1696188371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wd0FoVDYBNdvfSUqFfDZHh3ywde1wLMVQ5FdGFbNYzQ=;
 b=GiW2XYIasgu/IgOEl1Dg54Vm1QqfIQeSmhJFcNTFtqQU3eFjtHNBOQ6WmhvyuxIFVZ
 YgrKBredZ+HquKm6sWe+MYGC8ZEeYfkSt1Nf2KYdIiekCgBDvSF8cG1MRd7coP7Imahp
 IkPsFz/xmGGZqvHcx6aEMkupSrPkW5BnMhRcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583571; x=1696188371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wd0FoVDYBNdvfSUqFfDZHh3ywde1wLMVQ5FdGFbNYzQ=;
 b=mXNTYC5mrk/7JIxhLpg6vv2Dnh9HwR4NH9UCWgW0GFHbyTKYhtWxfW0yBM67xSmfui
 HE+anwzrfUhGfuqa77iCPsWi3dBfGtUAmlNkvRP22iZFzezPXD86PEwzg830l3z9ePdX
 Oqeoqq733Gcm/CMTVG2GSMF9Vt5SjPaUmssSrlSaJQMN0xzsXoz4nIB8TQqB0HzINHuM
 aCc1ZClxZnIFmN9QK/Ej0/ASzNZvapPvQ199VAu1S0jeD5Dl8GiAjy270nkrVrrn7+IJ
 CZDlGqj96ARqBBkbxTmnjGvfV/UH1+U0fKpTnRtXuThMgFAhMrmHr7ym5QNWlPmSPuSH
 DmYQ==
X-Gm-Message-State: AOJu0YzgK2rxvT46Pk09tIiZGBeo2bihaIoi/SZ0UjqsomuVPFaY0XXf
 E1sAphnK77+MCKqIfGEFB8Jpa3nMwWkq6T4FFho=
X-Google-Smtp-Source: AGHT+IEf7jzAalIGyT9J0Mgav1OZ5hF/Uc8so8bfrNh/dVeU2m/7Vm/1I5vXQNDgk5cU+uqcb4c7tw==
X-Received: by 2002:a6b:3ed4:0:b0:79f:cf6a:cc55 with SMTP id
 l203-20020a6b3ed4000000b0079fcf6acc55mr324320ioa.20.1695583570799; 
 Sun, 24 Sep 2023 12:26:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 24/38] dm: core: Add a function to create an empty tree
Date: Sun, 24 Sep 2023 13:25:09 -0600
Message-ID: <20230924192536.1812799-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Provide a function to create a new, empty tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 56 +++++++++++++++++++++++++++++++++++++++----
 include/dm/ofnode.h   |  9 +++++++
 include/of_live.h     |  8 +++++++
 lib/of_live.c         | 19 +++++++++++++++
 test/dm/ofnode.c      | 16 +++++++++++++
 5 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index d978f8e392e6..e39cbd946dd9 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -47,6 +47,17 @@ static int oftree_find(const void *fdt)
 	return -1;
 }
 
+static int check_tree_count(void)
+{
+	if (oftree_count == CONFIG_OFNODE_MULTI_TREE_MAX) {
+		log_warning("Too many registered device trees (max %d)\n",
+			    CONFIG_OFNODE_MULTI_TREE_MAX);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
 static oftree oftree_ensure(void *fdt)
 {
 	oftree tree;
@@ -69,11 +80,8 @@ static oftree oftree_ensure(void *fdt)
 	if (gd->flags & GD_FLG_RELOC) {
 		i = oftree_find(fdt);
 		if (i == -1) {
-			if (oftree_count == CONFIG_OFNODE_MULTI_TREE_MAX) {
-				log_warning("Too many registered device trees (max %d)\n",
-					    CONFIG_OFNODE_MULTI_TREE_MAX);
+			if (check_tree_count())
 				return oftree_null();
-			}
 
 			/* register the new tree */
 			i = oftree_count++;
@@ -92,6 +100,41 @@ static oftree oftree_ensure(void *fdt)
 	return tree;
 }
 
+int oftree_new(oftree *treep)
+{
+	oftree tree = oftree_null();
+	int ret;
+
+	if (of_live_active()) {
+		struct device_node *root;
+
+		ret = of_live_create_empty(&root);
+		if (ret)
+			return log_msg_ret("liv", ret);
+		tree = oftree_from_np(root);
+	} else {
+		const int size = 1024;
+		void *fdt;
+
+		ret = check_tree_count();
+		if (ret)
+			return log_msg_ret("fla", ret);
+
+		/* register the new tree with a small size */
+		fdt = malloc(size);
+		if (!fdt)
+			return log_msg_ret("fla", -ENOMEM);
+		ret = fdt_create_empty_tree(fdt, size);
+		if (ret)
+			return log_msg_ret("fla", -EINVAL);
+		oftree_list[oftree_count++] = fdt;
+		tree.fdt = fdt;
+	}
+	*treep = tree;
+
+	return 0;
+}
+
 void oftree_dispose(oftree tree)
 {
 	if (of_live_active())
@@ -193,6 +236,11 @@ static inline int oftree_find(const void *fdt)
 	return 0;
 }
 
+int oftree_new(oftree *treep)
+{
+	return -ENOSYS;
+}
+
 #endif /* OFNODE_MULTI_TREE */
 
 /**
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 8418dd459df8..b6010f7f9c9a 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -127,6 +127,15 @@ static inline ofnode noffset_to_ofnode(ofnode other_node, int of_offset)
 
 #endif /* OFNODE_MULTI_TREE */
 
+/**
+ * oftree_new() - Create a new, empty tree
+ *
+ * @treep: Returns a pointer to the tree, on success
+ * Returns: 0 on success, -ENOMEM if out of memory, -E2BIG if !OF_LIVE and
+ * there are too many (flattrees) already
+ */
+int oftree_new(oftree *treep);
+
 /**
  * ofnode_to_np() - convert an ofnode to a live DT node pointer
  *
diff --git a/include/of_live.h b/include/of_live.h
index 05e86ac06b1a..81cb9bd13e2c 100644
--- a/include/of_live.h
+++ b/include/of_live.h
@@ -46,4 +46,12 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes);
  */
 void of_live_free(struct device_node *root);
 
+/**
+ * of_live_create_empty() - Create a new, empty tree
+ *
+ * @rootp: Returns the root node of the created tree
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int of_live_create_empty(struct device_node **rootp);
+
 #endif
diff --git a/lib/of_live.c b/lib/of_live.c
index 25f7af61061e..e4eee3855476 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -336,3 +336,22 @@ void of_live_free(struct device_node *root)
 	/* the tree is stored as a contiguous block of memory */
 	free(root);
 }
+
+int of_live_create_empty(struct device_node **rootp)
+{
+	struct device_node *root;
+
+	root = calloc(1, sizeof(struct device_node));
+	if (!root)
+		return -ENOMEM;
+	root->name = strdup("");
+	if (!root->name) {
+		free(root);
+		return -ENOMEM;
+	}
+	root->type = "<NULL>";
+	root->full_name = "";
+	*rootp = root;
+
+	return 0;
+}
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 3bf97761d1ee..594116e3c045 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1346,3 +1346,19 @@ static int dm_test_livetree_ensure(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_livetree_ensure, UT_TESTF_SCAN_FDT);
+
+static int dm_test_oftree_new(struct unit_test_state *uts)
+{
+	ofnode node, subnode, check;
+	oftree tree;
+
+	ut_assertok(oftree_new(&tree));
+	node = oftree_root(tree);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_add_subnode(node, "edmund", &subnode));
+	check = ofnode_find_subnode(node, "edmund");
+	ut_asserteq(check.of_offset, subnode.of_offset);
+
+	return 0;
+}
+DM_TEST(dm_test_oftree_new, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

