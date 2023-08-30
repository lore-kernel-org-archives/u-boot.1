Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23460C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73BD86554;
	Wed, 30 Aug 2023 20:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PrLozlKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33358652F; Wed, 30 Aug 2023 20:06:14 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5457E86561
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso1970939f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418756; x=1694023556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NETDjP0BWZm4B1VYWcEuqJ6fOSWcXb36lIpJCVo0x/A=;
 b=PrLozlKJK+EOdiNoeZl7m9K8mosp5bfKqSaUICYJVWhmfjhamFKEPZF9Wf8x5n5Hl6
 8FfyBI9TYboLJgU27nkKKqMI8EPu10DIC6d2xwuUay/Qr8XeXzNm9+xBHKS6aJXZXddQ
 nB7oeSKZRjVrU0VnPA+yJFOEcr/IR6GtMoJWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418756; x=1694023556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NETDjP0BWZm4B1VYWcEuqJ6fOSWcXb36lIpJCVo0x/A=;
 b=DKwxb9ceSJ4JQ1Ivm0QtCxc5ifPzOXjFAsEz7icZh+E1WsVbRjN5SK2EH0YdczeSrG
 YEw7RCcDO9rLORUnhb/l43VUvs+oAfQUxH0UvrgykA+CtrSyrpqbZ8/8ryjxPWmTdW3v
 97TSYJwQ8zBFrjm8uG3sJGqyH7yaVHRIqmAUAjSY7CLC00353X+rhk0QTdyp1Cb8y4JP
 s7T4R0ni68jKFD/XTjoCcxhnCy1x3ItIumXWEyXOw3P3RCbw1NwXg+kNcjHf26ONtm+7
 dBLoWCcjmZ+Vj1BSRdOL0NfolFbeKeGqbtCYqdZw+xik9LTZBalflQ6m4yBdg0NaHDsa
 kHZw==
X-Gm-Message-State: AOJu0Yx3npahHSovPwr8q0bTvBC+HYsjSdUryvfLSWLVCKvaeLQ5kl9i
 qg62o1fkWNhm+c/y+52TO/R+dOVfN1/yVICpQ0M=
X-Google-Smtp-Source: AGHT+IHU2KA9HHLfg30CwPFNipf1hbxiaErSuSFnAMMmZNWSQ9mVMKTrgpqX3eP8rbeOT/d+1NKx+Q==
X-Received: by 2002:a6b:7a03:0:b0:787:34d:f1ea with SMTP id
 h3-20020a6b7a03000000b00787034df1eamr3782460iom.8.1693418755963; 
 Wed, 30 Aug 2023 11:05:55 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 21/32] dm: core: Add a way to convert a devicetree to a dtb
Date: Wed, 30 Aug 2023 12:04:52 -0600
Message-ID: <20230830180524.315916-22-sjg@chromium.org>
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

Add a way to flatten a devicetree into binary form. For livetree this
involves generating the devicetree using fdt_property() and other calls.
For flattree it simply involves providing the buffer containing the tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c |  18 +++++++
 include/dm/ofnode.h   |  13 +++++
 include/of_live.h     |  10 ++++
 lib/of_live.c         | 122 ++++++++++++++++++++++++++++++++++++++++++
 test/dm/ofnode.c      |  24 +++++++++
 5 files changed, 187 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index fe143f99091..4dc7589c1d2 100644
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
index 8be617b2104..f3ef1bff6db 100644
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
index 81cb9bd13e2..67bd5f02c74 100644
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
index e4eee385547..812c488f606 100644
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
index cb7fc907c82..d2b393750ff 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

