Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB51CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07AE86DE3;
	Thu, 21 Sep 2023 03:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lv/eu29m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E6786DE1; Thu, 21 Sep 2023 03:58:16 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32CB86D9B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-45274236ef6so233241137.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261484; x=1695866284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+mkWixaqSGrGgkcVg17W8eJUFOblb13xP6PoJJtIm4=;
 b=Lv/eu29mlyhQfPUBWOB5kDL4aQE/tovcdS0vqjun3g0EqclZMMon4cpYaF9xTmu92P
 XrUTZKvJFGXg+x+Zqe+HwkzI75ZaEUj6TlcXB0UwYcALwJlyg9Orof+YVdUwcR7OFyJ8
 eGjIqRZ/P/l9i8K31IOA9T6AO/U7ggyTtrP3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261484; x=1695866284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+mkWixaqSGrGgkcVg17W8eJUFOblb13xP6PoJJtIm4=;
 b=Z6Sgp0RqoZlrFfGKMY0zyZDSYfF7wG+f81zKjkQVlt69+TZjtr70cUa7uJrYsPMmLe
 LcGGPqZnXFsfI/YdmBsfcRT/rKT9HEHhf/x/kRCp35v+l3yTpHmt2ZbmLAM4vwFUgsNy
 4qIzHaA8Y8TCRlrwaAEs/1oFBTF2Q2CD27CYIGWCodEN31JYJRRqJqQeHjGF1J7N76/m
 lMkT8c+pjiCHx67b2+PNPgrjBb/JvW5E4TgjzANJ4u102I0eeXA/DR8AXLuvuBPyQIWN
 lOLlW56upS/Wylz16vSJoYNEQn5oPdOmbwNhN0KIlGo7FXEBZXGcCm9ioT1+acHOPS2e
 6ZmA==
X-Gm-Message-State: AOJu0YwMPfxNgL6I/w/B54dKeu+R8z4+rFqlQ/K3cgzCNaoCHJ2dQIkX
 nGdgS33hw+tD+gqPm+laX4+SGxL8FtG9kzzwNkc=
X-Google-Smtp-Source: AGHT+IGtaI9oQJCyE1mG1ml1YO+gk4XNFnMqlyCPe74+ZmpjbCvGsXrZpdaIP63APUe2gBrTqUsZ5A==
X-Received: by 2002:a05:6102:10f:b0:452:4f83:f49f with SMTP id
 z15-20020a056102010f00b004524f83f49fmr4238520vsq.28.1695261484404; 
 Wed, 20 Sep 2023 18:58:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 20/32] dm: core: Add a way to delete a node
Date: Wed, 20 Sep 2023 19:57:09 -0600
Message-ID: <20230921015730.1511373-21-sjg@chromium.org>
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

Add a function to delete a node in an existing tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/of_access.c | 65 ++++++++++++++++++++++++++++++++++++++++
 drivers/core/ofnode.c    | 23 ++++++++++++++
 include/dm/of_access.h   | 18 +++++++++++
 include/dm/ofnode.h      | 13 ++++++++
 test/dm/ofnode.c         | 31 +++++++++++++++++++
 5 files changed, 150 insertions(+)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 1bb4d8eab709..0df5c867c8b3 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -1040,3 +1040,68 @@ int of_add_subnode(struct device_node *parent, const char *name, int len,
 
 	return 0;
 }
+
+int __of_remove_property(struct device_node *np, struct property *prop)
+{
+	struct property **next;
+
+	for (next = &np->properties; *next; next = &(*next)->next) {
+		if (*next == prop)
+			break;
+	}
+	if (*next == NULL)
+		return -ENODEV;
+
+	/* found the node */
+	*next = prop->next;
+
+	return 0;
+}
+
+int of_remove_property(struct device_node *np, struct property *prop)
+{
+	int rc;
+
+	mutex_lock(&of_mutex);
+
+	rc = __of_remove_property(np, prop);
+
+	mutex_unlock(&of_mutex);
+
+	return rc;
+}
+
+int of_remove_node(struct device_node *to_remove)
+{
+	struct device_node *parent = to_remove->parent;
+	struct device_node *np, *prev;
+
+	if (!parent)
+		return -EPERM;
+	prev = NULL;
+	__for_each_child_of_node(parent, np) {
+		if (np == to_remove)
+			break;
+		prev = np;
+	}
+	if (!np)
+		return -EFAULT;
+
+	/* if there is a previous node, link it to this one's sibling */
+	if (prev)
+		prev->sibling = np->sibling;
+	else
+		parent->child = np->sibling;
+
+	/*
+	 * don't free it, since if this is an unflattened tree, all the memory
+	 * was alloced in one block; this pointer will be somewhere in the
+	 * middle of that
+	 *
+	 * TODO(sjg@chromium.org): Consider marking nodes as 'allocated'?
+	 *
+	 * free(np);
+	 */
+
+	return 0;
+}
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index ba8385af7b46..fe143f990915 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1720,6 +1720,29 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 	return ret;	/* 0 or -EEXIST */
 }
 
+int ofnode_delete(ofnode *nodep)
+{
+	ofnode node = *nodep;
+	int ret;
+
+	assert(ofnode_valid(node));
+	if (ofnode_is_np(node)) {
+		ret = of_remove_node(ofnode_to_np(node));
+	} else {
+		void *fdt = ofnode_to_fdt(node);
+		int offset = ofnode_to_offset(node);
+
+		ret = fdt_del_node(fdt, offset);
+		if (ret)
+			ret = -EFAULT;
+	}
+	if (ret)
+		return ret;
+	*nodep = ofnode_null();
+
+	return 0;
+}
+
 int ofnode_copy_props(ofnode dst, ofnode src)
 {
 	struct ofprop prop;
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index 9361d0a87bfb..de740d44674c 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -597,4 +597,22 @@ int of_write_prop(struct device_node *np, const char *propname, int len,
 int of_add_subnode(struct device_node *node, const char *name, int len,
 		   struct device_node **subnodep);
 
+/**
+ * of_remove_property() - Remove a property from a node
+ *
+ * @np: Node to remove from
+ * @prop: Pointer to property to remove
+ * Return 0 if OK, -ENODEV if the property could not be found in the node
+ */
+int of_remove_property(struct device_node *np, struct property *prop);
+
+/**
+ * of_remove_node() - Remove a node from the tree
+ *
+ * @to_remove: Node to remove
+ * Return: 0 if OK, -EPERM if it is the root node (wWhich cannot be removed),
+ * -ENOENT if the tree is broken (to_remove is not a child of its parent)
+ */
+int of_remove_node(struct device_node *to_remove);
+
 #endif
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 80708a3644c4..8be617b21043 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1582,4 +1582,17 @@ int ofnode_copy_props(ofnode dst, ofnode src);
 int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
 		     ofnode *nodep);
 
+/**
+ * ofnode_delete() - Delete a node
+ *
+ * Delete a node from the tree
+ *
+ * @nodep: Pointer to node to delete (set to ofnode_null() on success)
+ * Return: 0 if OK, -ENOENT if the node does not exist, -EPERM if it is the root
+ * node (wWhich cannot be removed), -EFAULT if the tree is broken (to_remove is
+ * not a child of its parent),
+ *
+ */
+int ofnode_delete(ofnode *nodep);
+
 #endif
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index fe7916c27222..cb7fc907c824 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1406,3 +1406,34 @@ static int dm_test_ofnode_copy_node_ot(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_copy_node_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
+
+static int dm_test_ofnode_delete(struct unit_test_state *uts)
+{
+	ofnode node;
+
+	/*
+	 * At present the livetree is not restored after changes made in tests.
+	 * See test_pre_run() for how this is done with the other FDT and
+	 * dm_test_pre_run() where it sets up the root-tree pointer. So use
+	 * nodes which don't matter to other tests.
+	 *
+	 * We could fix this by detecting livetree changes and regenerating it
+	 * before the next test if needed.
+	 */
+	node = ofnode_path("/leds/iracibble");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_delete(&node));
+	ut_assert(!ofnode_valid(node));
+	ut_assert(!ofnode_valid(ofnode_path("/leds/iracibble")));
+
+	node = ofnode_path("/leds/default_on");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_delete(&node));
+	ut_assert(!ofnode_valid(node));
+	ut_assert(!ofnode_valid(ofnode_path("/leds/default_on")));
+
+	ut_asserteq(2, ofnode_get_child_count(ofnode_path("/leds")));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_delete, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

