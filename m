Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E0E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D02086E76;
	Tue, 26 Sep 2023 16:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bKnXN+3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B92686DB5; Tue, 26 Sep 2023 16:15:59 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8894E86E30
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fa2dbd793so251248039f.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737752; x=1696342552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kAqH0xKcGM2ReeiQm9afhK21g2R8SFBAoXjWF8ht8s=;
 b=bKnXN+3hxOrZB5tVWb5qcRk41Pg21IVHrdxiw5nwhsFTM+Nfie891KHTIsEL8m661p
 LClxrodd3xLIKPGpPJr+eFSy3c4E31qCu4bcX+6q48YLQp+cMFQLMC8PEHTO1y14aGVJ
 AIAE6zsxIj1SNTnFyNpUHwQjx/Db1TKL9FLtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737752; x=1696342552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kAqH0xKcGM2ReeiQm9afhK21g2R8SFBAoXjWF8ht8s=;
 b=kMjbJowUhZiQttSW8pqTq97bPETuSiLQAxEwe06SuedpcnSpkisoRJDxGmZi6s2/Lo
 orpitkSKxfVMuizxuHOauvgufvaxabXfk0sMvIxDlgYunpW1UfdmR6/lf4/+4wXniEKU
 Ptc2FhY2bSL0gLLjmu/rgVw+bJ9gYsDQJuq/4BmQrI8jOuKlmr3t+sdyh3wKD0F3Xa/y
 zVuOH/t+7OHSbeZFbWwNvUpC+cbO+QFOZ64ROUAc32PPNkbBjFpoXBHHL8hfJ6KAIZpF
 C7XkgROW+z4TueHrVGXHBpkqftWBrjNx4h5yyUWyJQbAJdHpQH9assyWGu1nzyZR04VG
 IfoA==
X-Gm-Message-State: AOJu0Yz/8u5nOKfWkNtwY+KQ3WjqhNjgM/ACG+kZs/RAasaBN8bxKlt6
 yC+8PYe7N6OnsUOFp74PAPyPb4slekj0fT4ZcJw=
X-Google-Smtp-Source: AGHT+IFrIRMRKBOZ/ogyXKic5DJSgnRKnvB24ixDDvD26/FSvAWSYfEoYBkZp2ZF6xd92tNC1XD3vw==
X-Received: by 2002:a6b:e20e:0:b0:783:4e11:76d7 with SMTP id
 z14-20020a6be20e000000b007834e1176d7mr9299850ioc.21.1695737752092; 
 Tue, 26 Sep 2023 07:15:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 28/44] dm: core: Add a way to delete a node
Date: Tue, 26 Sep 2023 08:14:42 -0600
Message-ID: <20230926141514.2101787-29-sjg@chromium.org>
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
index 1bb4d8eab709..c8db743f5298 100644
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
+	if (!*next)
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
index 403ee06ad94b..a5efedf6af32 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1779,6 +1779,29 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
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
index 7eb04accd62c..f1ee02cd837f 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1635,4 +1635,17 @@ int ofnode_copy_props(ofnode dst, ofnode src);
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
index 5459a9afbb99..845cded449ab 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1425,3 +1425,34 @@ static int dm_test_ofnode_copy_node_ot(struct unit_test_state *uts)
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

