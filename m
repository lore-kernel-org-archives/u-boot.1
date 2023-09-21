Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A342CD493D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211B386DED;
	Thu, 21 Sep 2023 03:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jP+9qNna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975BA86C40; Thu, 21 Sep 2023 03:58:16 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF1486D4B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fcc3ac97bso1494745ab.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261485; x=1695866285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boXsqkCP9FnbhdMNsxUeq5Zeo5jflcNURNw8XCw2LvA=;
 b=jP+9qNnaNfWhzcumgh4/uM32R2qpd5Xnn32jkIQlloCIRJFiWYxzVUv6/RjYnsRWan
 vjktiDuVqZ05TTmtUsaQm3tIe97nGHI6YNfESvAjiCpZW7oxCjXOglfQbDaIJ3MXbqnn
 EvEVbhO6Xj/qSro9F5eRq4oTMPhmnSBa791PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261485; x=1695866285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boXsqkCP9FnbhdMNsxUeq5Zeo5jflcNURNw8XCw2LvA=;
 b=T5oBT6sagch700/UmVqndxRYZsSE4TvRAusFQ4BqC7pBjYkmv/5mxMDEqoUmiJMXwH
 E7DNyVC9d1K6MWJMWdqTLhxIulN9hWJsLXtnp6w1oXkIHOPJy8OOCqKJxyJY6+06TFSK
 cuETQr3RKWWWwaGK8LcnhoTdmjrKnihAX6mrrCJqfqZoCQPquQhbySiePr6nTEkc91hr
 4ZTe8ApewJFG5Yn3SZFyUaU4TMYfOxMyz3rvBowohqzvEZyRfSFpFLlCDXnFBEtbOhIU
 U32aJXaRuZeGBYoswL1hWwW46Axu9JyJv6AgHKc0+AZ+2lp/vumwbCbEffgQabuYbOIF
 eR+w==
X-Gm-Message-State: AOJu0Yw//IDyNFFS/AoBE+yzusyxvmvFhbFELJ2iESLqy4/bpIeQ7f9P
 uBivuW6XV+wvfnQi/FizvG0onrFJiY2vkO6gCik=
X-Google-Smtp-Source: AGHT+IFFT6H9dpqRrn1c7uJKmrUh+SVirGb7mu9T8n+9SXJWdfBlhs9Qi/sj/us36zL0ZiW3ppPGWg==
X-Received: by 2002:a92:d411:0:b0:345:a6c5:1ce8 with SMTP id
 q17-20020a92d411000000b00345a6c51ce8mr3975705ilm.14.1695261485600; 
 Wed, 20 Sep 2023 18:58:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 21/32] dm: core: Add a way to convert a devicetree to a dtb
Date: Wed, 20 Sep 2023 19:57:10 -0600
Message-ID: <20230921015730.1511373-22-sjg@chromium.org>
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

Add a way to flatten a devicetree into binary form. For livetree this
involves generating the devicetree using fdt_property() and other calls.
For flattree it simply involves providing the buffer containing the tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c |  18 +++++++
 include/dm/ofnode.h   |  13 +++++
 include/of_live.h     |  10 ++++
 lib/of_live.c         | 122 ++++++++++++++++++++++++++++++++++++++++++
 test/dm/ofnode.c      |  24 +++++++++
 5 files changed, 187 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index fe143f990915..4dc7589c1d23 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -243,6 +243,24 @@ int oftree_new(oftree *treep)
 
 #endif /* OFNODE_MULTI_TREE */
 
+int oftree_to_fdt(oftree tree, struct abuf *buf)
+{
+	int ret;
+
+	if (of_live_active()) {
+		ret = of_live_flatten(ofnode_to_np(oftree_root(tree)), buf);
+		if (ret)
+			return log_msg_ret("flt", ret);
+	} else {
+		void *fdt = oftree_lookup_fdt(tree);
+
+		abuf_init(buf);
+		abuf_set(buf, fdt, fdt_totalsize(fdt));
+	}
+
+	return 0;
+}
+
 /**
  * ofnode_from_tree_offset() - get an ofnode from a tree offset (flat tree)
  *
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 8be617b21043..f3ef1bff6db6 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -17,6 +17,7 @@
 /* Enable checks to protect against invalid calls */
 #undef OF_CHECKS
 
+struct abuf;
 struct resource;
 
 #include <dm/ofnode_decl.h>
@@ -135,6 +136,18 @@ static inline ofnode noffset_to_ofnode(ofnode other_node, int of_offset)
  */
 int oftree_new(oftree *treep);
 
+/**
+ * oftree_to_fdt() - Convert an oftree to a flat FDT
+ *
+ * @tree: tree to flatten (if livetree) or copy (if not)
+ * @buf: Returns inited buffer containing the newly created flat tree. Note
+ * that for flat tree the buffer is not allocated. In either case the caller
+ * must call abut_uninit() to free any memory used by @buf
+ * Return: 0 on success, -ENOMEM if out of memory, other -ve value for any other
+ * error
+ */
+int oftree_to_fdt(oftree tree, struct abuf *buf);
+
 /**
  * ofnode_to_np() - convert an ofnode to a live DT node pointer
  *
diff --git a/include/of_live.h b/include/of_live.h
index 81cb9bd13e2c..67bd5f02c744 100644
--- a/include/of_live.h
+++ b/include/of_live.h
@@ -9,6 +9,7 @@
 #ifndef _OF_LIVE_H
 #define _OF_LIVE_H
 
+struct abuf;
 struct device_node;
 
 /**
@@ -54,4 +55,13 @@ void of_live_free(struct device_node *root);
  */
 int of_live_create_empty(struct device_node **rootp);
 
+/**
+ * of_live_flatten() - Create an FDT from a hierarchical tree
+ *
+ * @root: Root node of tree to convert
+ * @buf: Buffer to return the tree (inited by this function)
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int of_live_flatten(const struct device_node *root, struct abuf *buf);
+
 #endif
diff --git a/lib/of_live.c b/lib/of_live.c
index e4eee3855476..812c488f6067 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -8,13 +8,21 @@
  * Copyright (c) 2017 Google, Inc
  */
 
+#define LOG_CATEGORY	LOGC_DT
+
 #include <common.h>
+#include <abuf.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <of_live.h>
 #include <malloc.h>
 #include <dm/of_access.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
+
+enum {
+	BUF_STEP	= SZ_64K,
+};
 
 static void *unflatten_dt_alloc(void **mem, unsigned long size,
 				unsigned long align)
@@ -355,3 +363,117 @@ int of_live_create_empty(struct device_node **rootp)
 
 	return 0;
 }
+
+static int check_space(int ret, struct abuf *buf)
+{
+	if (ret == -FDT_ERR_NOSPACE) {
+		if (!abuf_realloc_inc(buf, BUF_STEP))
+			return log_msg_ret("spc", -ENOMEM);
+		ret = fdt_resize(abuf_data(buf), abuf_data(buf),
+				 abuf_size(buf));
+		if (ret)
+			return log_msg_ret("res", -EFAULT);
+
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/**
+ * flatten_node() - Write out the node and its properties into a flat tree
+ */
+static int flatten_node(struct abuf *buf, const struct device_node *node)
+{
+	const struct device_node *np;
+	const struct property *pp;
+	int ret;
+
+	ret = fdt_begin_node(abuf_data(buf), node->name);
+	ret = check_space(ret, buf);
+	if (ret == -EAGAIN) {
+		ret = fdt_begin_node(abuf_data(buf), node->name);
+		if (ret) {
+			log_debug("Internal error a %d\n", ret);
+			return -EFAULT;
+		}
+	}
+	if (ret)
+		return log_msg_ret("beg", ret);
+
+	/* First write out the properties */
+	for (pp = node->properties; !ret && pp; pp = pp->next) {
+		ret = fdt_property(abuf_data(buf), pp->name, pp->value,
+				   pp->length);
+		ret = check_space(ret, buf);
+		if (ret == -EAGAIN) {
+			ret = fdt_property(abuf_data(buf), pp->name, pp->value,
+					   pp->length);
+		}
+	}
+
+	/* Next write out the subnodes */
+	for (np = node->child; np; np = np->sibling) {
+		ret = flatten_node(buf, np);
+		if (ret)
+			return log_msg_ret("sub", ret);
+	}
+
+	ret = fdt_end_node(abuf_data(buf));
+	ret = check_space(ret, buf);
+	if (ret == -EAGAIN) {
+		ret = fdt_end_node(abuf_data(buf));
+		if (ret) {
+			log_debug("Internal error b %d\n", ret);
+			return -EFAULT;
+		}
+	}
+	if (ret)
+		return log_msg_ret("end", ret);
+
+	return 0;
+}
+
+int of_live_flatten(const struct device_node *root, struct abuf *buf)
+{
+	int ret;
+
+	abuf_init(buf);
+	if (!abuf_realloc(buf, BUF_STEP))
+		return log_msg_ret("ini", -ENOMEM);
+
+	ret = fdt_create(abuf_data(buf), abuf_size(buf));
+	if (!ret)
+		ret = fdt_finish_reservemap(abuf_data(buf));
+	if (ret) {
+		log_debug("Failed to start FDT (err=%d)\n", ret);
+		return log_msg_ret("sta", -EINVAL);
+	}
+
+	ret = flatten_node(buf, root);
+	if (ret)
+		return log_msg_ret("flt", ret);
+
+	ret = fdt_finish(abuf_data(buf));
+	ret = check_space(ret, buf);
+	if (ret == -EAGAIN) {
+		ret = fdt_finish(abuf_data(buf));
+		if (ret) {
+			log_debug("Internal error c %d\n", ret);
+			return -EFAULT;
+		}
+	}
+	if (ret)
+		return log_msg_ret("fin", ret);
+
+	ret = fdt_pack(abuf_data(buf));
+	if (ret) {
+		log_debug("Failed to pack (err=%d)\n", ret);
+		return log_msg_ret("pac", -EFAULT);
+	}
+
+	if (!abuf_realloc(buf, fdt_totalsize(abuf_data(buf))))
+		return log_msg_ret("abu", -EFAULT);
+
+	return 0;
+}
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index cb7fc907c824..d2b393750ffc 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -17,6 +17,7 @@
  */
 
 #include <common.h>
+#include <abuf.h>
 #include <dm.h>
 #include <log.h>
 #include <of_live.h>
@@ -26,6 +27,7 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <linux/sizes.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -1437,3 +1439,25 @@ static int dm_test_ofnode_delete(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_ofnode_delete, UT_TESTF_SCAN_FDT);
+
+static int dm_test_oftree_to_fdt(struct unit_test_state *uts)
+{
+	oftree tree, check;
+	struct abuf buf, buf2;
+
+	tree = oftree_default();
+	ut_assertok(oftree_to_fdt(tree, &buf));
+	ut_assert(abuf_size(&buf) > SZ_16K);
+
+	/* convert it back to a tree and see if it looks OK */
+	check = oftree_from_fdt(abuf_data(&buf));
+	ut_assert(oftree_valid(check));
+
+	ut_assertok(oftree_to_fdt(check, &buf2));
+	ut_assert(abuf_size(&buf2) > SZ_16K);
+	ut_asserteq(abuf_size(&buf), abuf_size(&buf2));
+	ut_asserteq_mem(abuf_data(&buf), abuf_data(&buf2), abuf_size(&buf));
+
+	return 0;
+}
+DM_TEST(dm_test_oftree_to_fdt, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

