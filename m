Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86586C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158DE866DA;
	Wed, 30 Aug 2023 20:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MClvcV4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6D686612; Wed, 30 Aug 2023 20:06:02 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B9086574
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso1840039f.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418751; x=1694023551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EJO2ZqLFk1AXK0ge2MocDfhcU2IwylJ2UFFh6q8aJg=;
 b=MClvcV4LhO90w9bEMqAYMjvQw454rryLE3WZk5zpGUw39Qe3caowHFxqoniJJ/3ocn
 EKEPqPtIuZgMWwTNKywkSmz59zL05ehAhbbi/xXspoKhSGK8be56VPkspmsLdPVl6Bjl
 1qZ+9/8ipjGcECxFxUNiUWKhDlHfi7iOb8HzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418751; x=1694023551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EJO2ZqLFk1AXK0ge2MocDfhcU2IwylJ2UFFh6q8aJg=;
 b=NQYldyAl5Zx45cgKV7FRi30HztcA2A9TYrNhEyj8q35QjPiD7jtzLDL8hPNbph44Ul
 jJ5dstlhB92RRfiALMUMcREkHCgEMCb0OraOZYrOG5fIQ+lCV8L13YWXb4Lk53Y2ZWPa
 X2GlTMXcJtUCe6nzYgpTIjo/eHdKaGtU8Swt3RiUA0/nTLMQb64Kb1Ftxrw2KTSKtVms
 1PHR/qz7GMnwdUl3hbQCmUt9H3CNi2iQKsDxztJTO5yyzM7xfVF7asGnflF1j5A3Z8ow
 kupt2yF/XQV1e2IFSB6xwVsF2AtYjMuyjjQ72P7C7w9VtKRN6z3mzG4OTRUMa5ie4/J2
 pfgw==
X-Gm-Message-State: AOJu0YzaxZFh1nL7oqnnxgi3L38MBiEi7qBK09E4pywIdqrFsPe8W9ep
 5h3QslOgrJvkPloRkQrIWQ8QUVSNC4Bb3pzfbRc=
X-Google-Smtp-Source: AGHT+IFM5NLeN29xAtmFzqJAz/bxXKr2kGUwRU2UkL8OgAVlO+2bqcaenps717dleeIW7P1WZThWdw==
X-Received: by 2002:a6b:e71a:0:b0:786:cc36:360c with SMTP id
 b26-20020a6be71a000000b00786cc36360cmr3357617ioh.8.1693418750895; 
 Wed, 30 Aug 2023 11:05:50 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 15/32] dm: core: Reverse the argument order in
 ofnode_copy_props()
Date: Wed, 30 Aug 2023 12:04:46 -0600
Message-ID: <20230830180524.315916-16-sjg@chromium.org>
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

Follow the order used by memcpy() as it may be less confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_request.c    | 2 +-
 boot/vbe_simple_os.c  | 2 +-
 drivers/core/ofnode.c | 2 +-
 include/dm/ofnode.h   | 6 +++---
 test/dm/ofnode.c      | 9 ++++-----
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 312edfa2bdb..4ee29717ef6 100644
--- a/boot/vbe_request.c
+++ b/boot/vbe_request.c
@@ -187,7 +187,7 @@ static int bootmeth_vbe_ft_fixup(void *ctx, struct event *event)
 		ret = ofnode_add_subnode(dest_parent, name, &dest);
 		if (ret && ret != -EEXIST)
 			return log_msg_ret("add", ret);
-		ret = ofnode_copy_props(node, dest);
+		ret = ofnode_copy_props(dest, node);
 		if (ret)
 			return log_msg_ret("cp", ret);
 
diff --git a/boot/vbe_simple_os.c b/boot/vbe_simple_os.c
index 8c641ec07e2..02d8352ca8f 100644
--- a/boot/vbe_simple_os.c
+++ b/boot/vbe_simple_os.c
@@ -94,7 +94,7 @@ static int bootmeth_vbe_simple_ft_fixup(void *ctx, struct event *event)
 
 		/* Copy over the vbe properties for fwupd */
 		log_debug("Fixing up: %s\n", dev->name);
-		ret = ofnode_copy_props(dev_ofnode(dev), subnode);
+		ret = ofnode_copy_props(subnode, dev_ofnode(dev));
 		if (ret)
 			return log_msg_ret("cp", ret);
 
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8311282abf6..8227eac1e4f 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1672,7 +1672,7 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 	return ret;	/* 0 or -EEXIST */
 }
 
-int ofnode_copy_props(ofnode src, ofnode dst)
+int ofnode_copy_props(ofnode dst, ofnode src)
 {
 	struct ofprop prop;
 
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0a85db31f36..abdfa58036d 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1545,7 +1545,7 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
 /**
  * ofnode_copy_props() - copy all properties from one node to another
  *
- * Makes a copy of all properties from the source note in the destination node.
+ * Makes a copy of all properties from the source node to the destination node.
  * Existing properties in the destination node remain unchanged, except that
  * any with the same name are overwritten, including changing the size of the
  * property.
@@ -1553,9 +1553,9 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
  * For livetree, properties are copied / allocated, so the source tree does not
  * need to be present afterwards.
  *
+ * @dst: Destination node to write properties to
  * @src: Source node to read properties from
- * @dst: Destination node to write properties too
  */
-int ofnode_copy_props(ofnode src, ofnode dst);
+int ofnode_copy_props(ofnode dst, ofnode src);
 
 #endif
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index b74f5c2ebcf..49fa5d27e6e 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1190,12 +1190,11 @@ static int dm_test_ofnode_too_many(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_too_many, UT_TESTF_SCAN_FDT);
 
-static int check_copy_props(struct unit_test_state *uts, ofnode src,
-			    ofnode dst)
+static int check_copy_props(struct unit_test_state *uts, ofnode dst, ofnode src)
 {
 	u32 reg[2], val;
 
-	ut_assertok(ofnode_copy_props(src, dst));
+	ut_assertok(ofnode_copy_props(dst, src));
 
 	ut_assertok(ofnode_read_u32(dst, "ping-expect", &val));
 	ut_asserteq(3, val);
@@ -1227,7 +1226,7 @@ static int dm_test_ofnode_copy_props(struct unit_test_state *uts)
 	src = ofnode_path("/b-test");
 	dst = ofnode_path("/some-bus");
 
-	ut_assertok(check_copy_props(uts, src, dst));
+	ut_assertok(check_copy_props(uts, dst, src));
 
 	/* check a property that is in the destination already */
 	ut_asserteq_str("mux0", ofnode_read_string(dst, "mux-control-names"));
@@ -1243,7 +1242,7 @@ static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
 
 	src = ofnode_path("/b-test");
 	dst = oftree_path(otree, "/node/subnode2");
-	ut_assertok(check_copy_props(uts, src, dst));
+	ut_assertok(check_copy_props(uts, dst, src));
 
 	return 0;
 }
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

