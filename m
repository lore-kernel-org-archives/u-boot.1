Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3138E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F68B86E62;
	Tue, 26 Sep 2023 16:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmivZx/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F5886E27; Tue, 26 Sep 2023 16:15:57 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A0A86DEB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3512b425662so19461255ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737750; x=1696342550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iR7APYeEIzsaW470DUX4XyqhGQL1NEo2w4mdioWFeWU=;
 b=cmivZx/zEP4HwJHxcAMx7WBle2tHFmqpKxU04fkwvnNR2xULerNZELeO9mbHVWUBQF
 tZyu9lvqlo4oP8lFrWVOclnvl0GBSVcP8Mz6vODEgyOg5qxYViBamuXwNGp+9OX7y2Y+
 uKSR3gx8NsfmZbegL9KEVBZTeHsxwbKf6C/sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737750; x=1696342550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iR7APYeEIzsaW470DUX4XyqhGQL1NEo2w4mdioWFeWU=;
 b=w/Bjt6nESAu1pbsdyIEDsgNpjcJ41oiCLGC+qx08A0+BdyZ5cOvqq1GFXKB0rRofBj
 gFkImSKSupelESc/3t05yERmlMMC3GYwxgjV33dw0vIIcM3Uxr4xf3ro4QEXCxxURljZ
 pjvWFXAOe9KSQBZKZ3vCzjKAPxxglYTVlLsvixUOr3un8oSJApVh1a9qQJuPHpDuMTvE
 3Vf4Eht/pAAIO5bZj+VqyBYt+hoKr7hkRZh5LJQ1XhRyYvBL8ZUNKsUR4ON/l9Bfc3Qm
 7EZE2R59a+nb8CToXscy/nRAXaeJpV4VouZ+YFxFwu4o9MwJZwDlBybLpjVShUDPPmXn
 hbnw==
X-Gm-Message-State: AOJu0Yz+sEwNl5y3uztQg5oPLBOWQErszlBMgZdYqwApff3+uIxEu/Vk
 VdvMy//h2yL5FjZ4AJ93HJjSdPyCknT1MNnm0wM=
X-Google-Smtp-Source: AGHT+IGQn4/8DLk+o2ehs9Xmu+Y3nZVE04HimZ71BqIg7XfaiTbIcUSkaXDvUxWmY/o7v88FR8GWSA==
X-Received: by 2002:a05:6e02:ee1:b0:351:4ee8:c914 with SMTP id
 j1-20020a056e020ee100b003514ee8c914mr2797622ilk.14.1695737750263; 
 Tue, 26 Sep 2023 07:15:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 26/44] dm: core: Add a function to create an empty tree
Date: Tue, 26 Sep 2023 08:14:40 -0600
Message-ID: <20230926141514.2101787-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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
index 515396c62f49..d2bdb8b9af1c 100644
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
index 32917f661557..0b96ab34ede0 100644
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

