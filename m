Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D735EC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F3A86594;
	Wed, 30 Aug 2023 20:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFZajDkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71388652C; Wed, 30 Aug 2023 20:06:11 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C383986597
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-794cd987ea6so1807739f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418753; x=1694023553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB9TnKTolmV1HtDagrwlV2s8uxFwdQPChBf7xBDQo3w=;
 b=BFZajDkGl0bNwNXfILMW1LX/B1n4mgabmEF4KOkGWd7bBSV3EFXrfk+0ccOw9C974O
 NwBG4fmuqf81+6FSS0IkYRluPC2tO7uLjEEPCsf+P5mg9rqZXKMAaR7Pat05YjA03viI
 YNPfMjQOa6kE6GVqy4o7hj0XyMQYS5Rxd0Clg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418753; x=1694023553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XB9TnKTolmV1HtDagrwlV2s8uxFwdQPChBf7xBDQo3w=;
 b=cuKmd0gQ5DGIAQLWqKFrfD6SlfKjLA8XOxawz12Rm/52B9Nl8uEIZ+V26iaiRbnz/G
 VqiK5mOfQY8gJJKmYK4v3ZFN8uiJ0U3V3OuENYNZ8j+dmBM0kffd3AIoirfYj7xBe6Zm
 lD+KvLTg4pC8ks18i2+bmA2Rs3mcp9b+rdNmNafjlNay1s71MBFN83JJmfqacnEZEPQ5
 esmJmtSo0vfZ0R7jvHCf5O7pMAXsMuHQuTU8kxUIRlbf8v1yjdUrqOaGKNPTc/E+NTc1
 w17N1E+Xlaa6KgQzXQGJC71JPTagFSyZ3IEf8aliq+t2MhAUHLtqM5GI5rdqfSWnnPw0
 Fm8Q==
X-Gm-Message-State: AOJu0YyRxT5pX9aLdRlH/JYtNx5dbJhoBxfqhH5tFu8Y1tyuOaGh0UlW
 W8P9+8M59V/OnNclDGkvYhmzeBYKtcek5ljsdQc=
X-Google-Smtp-Source: AGHT+IHXWsfd96SgFsxlOzcv7CzYXHG2rX4c9RHpd2DGnCmKIIhGo6zbh88+kyT3Y/gAoU73Qc4/NQ==
X-Received: by 2002:a5e:9202:0:b0:791:1e87:b47e with SMTP id
 y2-20020a5e9202000000b007911e87b47emr3416436iop.15.1693418753396; 
 Wed, 30 Aug 2023 11:05:53 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 18/32] dm: core: Add a function to create an empty tree
Date: Wed, 30 Aug 2023 12:04:49 -0600
Message-ID: <20230830180524.315916-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 drivers/core/ofnode.c | 56 +++++++++++++++++++++++++++++++++++++++----
 include/dm/ofnode.h   |  9 +++++++
 include/of_live.h     |  8 +++++++
 lib/of_live.c         | 19 +++++++++++++++
 test/dm/ofnode.c      | 16 +++++++++++++
 5 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8227eac1e4f..7100fc63035 100644
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
index abdfa58036d..fa6a8318899 100644
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
index 05e86ac06b1..81cb9bd13e2 100644
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
index 25f7af61061..e4eee385547 100644
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
index 84ed7f92b23..63b651df84e 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

