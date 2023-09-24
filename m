Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF88CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD2D86B26;
	Sun, 24 Sep 2023 21:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MBLTT/Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B34B86C18; Sun, 24 Sep 2023 21:26:24 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B70086AF7
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34fe2814b0dso17833835ab.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583573; x=1696188373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGYki7cG1jZOTr2ufQB8q6pTGzF3tiScLGW+Tp2Hc1g=;
 b=MBLTT/Td0/rOJWuk/71+JceEO+CagDMwlYW++OAfFFrMS5gpv23SuTHSdzTBe39SQh
 iY8NTAciqir9MjKwXcv6GZVX6wJN0+wFYOwG0suPOoxsyXcdyjA3HFhf9B0tYrSHBjfi
 8/41h27vUHnGZyADXVPb2PXN01eyiGH/gRMk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583573; x=1696188373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGYki7cG1jZOTr2ufQB8q6pTGzF3tiScLGW+Tp2Hc1g=;
 b=L9Sq11/LAqg58srspKZm6JUyc6cdkqztESYkLAS7Kk2m4tnDXV67J+G4vSqH6zl8UF
 0ErMWFqhFm4GQHIyK7UkvsPIrdhOJ6vCrwEI6Di0Z65A1t49sbaayy0SBLyj1YqXwk/d
 QJaXl2EmCHlkG93dH9wyFbC2R4iGHgyAzxhaXmghYppI82wvKzOnxgswC9uVikIq4Fc0
 DYCUmSqJ639z6TD2JjDCqpMG6fJ8xdR3w64v/id8XmZX6hxzYW9FKmbayBGltjO67tr8
 xQZ0M+O5bIEIGyyaDmiaptMQJTihtpM6sQPyNGaj0pSigGQ472LDSHJTT8yhZ0FcsUmi
 u8Lg==
X-Gm-Message-State: AOJu0Yw8GOmPHk6z4CYwmB3T/RfuD9pcSVdDOu6NzZiveMteBC/e3Nxr
 875pihPT3RKnSCdiniOJHJP8PcyHtvTJvAZr520=
X-Google-Smtp-Source: AGHT+IFmkK3Gsm1SCiP2AKlsqsbEJYM7OsDFZYM5Zu4JkVtLJascsPjt/rjojIKLre0mCBdizhHs9w==
X-Received: by 2002:a05:6e02:2161:b0:350:f0bb:6a3b with SMTP id
 s1-20020a056e02216100b00350f0bb6a3bmr7255514ilv.17.1695583573180; 
 Sun, 24 Sep 2023 12:26:13 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 27/38] dm: core: Add a way to convert a devicetree to a dtb
Date: Sun, 24 Sep 2023 13:25:12 -0600
Message-ID: <20230924192536.1812799-28-sjg@chromium.org>
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
index fb8bc82a929a..f49edaba07fd 100644
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
index f0a7d2a2f9d7..b6420efb4605 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -17,6 +17,7 @@
 /* Enable checks to protect against invalid calls */
 #undef OF_CHECKS
 
+struct abuf;
 struct resource;
 
 #include <dm/ofnode_decl.h>
@@ -136,6 +137,18 @@ static inline ofnode noffset_to_ofnode(ofnode other_node, int of_offset)
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
index 845cded449ab..ceeb8e57791e 100644
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
 
@@ -1456,3 +1458,25 @@ static int dm_test_ofnode_delete(struct unit_test_state *uts)
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

