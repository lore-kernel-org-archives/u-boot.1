Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035DFCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6980886DDD;
	Thu, 21 Sep 2023 03:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwBaUY4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAED86D2E; Thu, 21 Sep 2023 03:58:12 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5902986D9E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7a8aec82539so184740241.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261482; x=1695866282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udcndc2ClxzkpJQ+cxmm+DYaZGMIcmwxziS2IB5Kabg=;
 b=jwBaUY4XlXjIE8S+VeIeh4oWe72g6ulWS/9GVD759aixEzpDSoZGNqnuokr7OvK2aA
 Um9H+niwQ8jbz89PuRT/GWCy7vER/91Z64Nz74SI/xDRy/p5agghqDk5ZFOgV76OpK2T
 iYhPs42tnurzsn9DpSExQ+VBms2Ja7ATpikOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261482; x=1695866282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udcndc2ClxzkpJQ+cxmm+DYaZGMIcmwxziS2IB5Kabg=;
 b=eydDlP9bPsaKKB/s99hBBrzIew4KSO+sdIPPKfjEDM2MhrASyFDvhIiSDshk4c451Q
 3fciysQukiRCgTAsuzLkdF65VbJIFaqNKnmhoAzr55W/d1Cg2VTvF3tR2fwzmWXcK1rC
 FQKalnaaCFUabNCB1zw3bljBfG7mOpJeu8JZg+6cI7VjawBOkKZnsgSWiN5qUOjtkubt
 Tx7pAIrzMz1iHb5qTUqPhc+g4gier56KkMy5giLJOc499iwAafACLXOJ4yVn93H0VMKU
 dgyuAvjOSyWIc8915Vhze1LiONZnvaISP6+6U+CV4oY+zGtxUHKoT1HoSo6X5HW3KVjI
 EThg==
X-Gm-Message-State: AOJu0Yx+YzHOorytrkmcdT0mbJ2Nn50mSQbHxcdXGy2mTXcRXz5imQ/b
 OWwcL66xuYa2lgVfUf674fm6a/Qqzcf9N7JsxG0=
X-Google-Smtp-Source: AGHT+IFd+tIf+p5mNjuiY2FAKOJZkt/K1lxjcFoPFE+YxlNcwCOq9pQAgAz4QBmOwwxxeqQMw7DUfw==
X-Received: by 2002:a67:fd09:0:b0:452:6f2f:97a4 with SMTP id
 f9-20020a67fd09000000b004526f2f97a4mr4513089vsr.21.1695261482037; 
 Wed, 20 Sep 2023 18:58:02 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 18/32] dm: core: Add a function to create an empty tree
Date: Wed, 20 Sep 2023 19:57:07 -0600
Message-ID: <20230921015730.1511373-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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
index 8227eac1e4fe..7100fc630352 100644
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
index abdfa58036d5..fa6a83188995 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -126,6 +126,15 @@ static inline ofnode noffset_to_ofnode(ofnode other_node, int of_offset)
 
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
index 84ed7f92b235..63b651df84eb 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1327,3 +1327,19 @@ static int dm_test_livetree_ensure(struct unit_test_state *uts)
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

