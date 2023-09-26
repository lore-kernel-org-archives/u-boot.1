Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673CFE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F09B86E1E;
	Tue, 26 Sep 2023 16:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGB5cfOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E9F86E37; Tue, 26 Sep 2023 16:15:54 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92EE86DCB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34961362f67so27305885ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737746; x=1696342546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQYUNliO3IlDXEEyP8PPMybyzMmXKYMmUxJablEHqV8=;
 b=ZGB5cfOMpNrNw+4/C7FLPvF6nTkb1SfztROGIdnvbTD/B6w5VYVUBLm9l12jaxUXR3
 pJkgKlSp1qOO4V/JyqJzChd6OqoD+2lZP/QutK5k+WUJeFcOsnWghRdAOvKRrlH5M6Gz
 Yy1HWM/Hf3lLxZlOeZn3tvLdf4AYgzzl0F9tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737746; x=1696342546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQYUNliO3IlDXEEyP8PPMybyzMmXKYMmUxJablEHqV8=;
 b=w2Omqni2P7//k38UmGVW2zyEdk2YbYy2iN503sL9VBoF61VsubVEDN9wOWLUFLea7W
 +lUO7ZDgXJu2o2XWEp9yw7OIxQNMR8hn1il6U9RXPTRVg0S1u1FhSqd7U9AMAbSA1NAl
 acnwMCVSaUHD6VQDXnX14SX0qyl0XDS+/2udF4gZxYM+BtN7GG0uKo4rbrY4yxSpTgLZ
 2hUypgQa+Ci4Qr9ffoXEnKX///TELZw1PnLxEXxREF+4J4AyUmGmPq2IUj44VgtSaT3J
 p6CrNBvKIv4Yt39Q0zdn2omh6ZMyRHHEBcaaYcq8rmz9vOIgrNDfCiyjyrNgBFCFKx0C
 6mBQ==
X-Gm-Message-State: AOJu0Yxvw8DFxOJL5oi7PfIgd71xD3nbYmPKgLQ3ZKpan0+v5RPkpCO8
 zUe0otkTSgfL7gLQWOAfZlHBeBxmyofeEscgkl4=
X-Google-Smtp-Source: AGHT+IFHvUibMDu/7i6oKnNBmadR0Gc5/CSnq6ZabO6Eyk9pZxPe6YJ5gMeMrNU3tZBUwzUYCcD+fQ==
X-Received: by 2002:a05:6e02:1b8b:b0:351:47fe:8212 with SMTP id
 h11-20020a056e021b8b00b0035147fe8212mr2325910ili.15.1695737746392; 
 Tue, 26 Sep 2023 07:15:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 23/44] dm: core: Reverse the argument order in
 ofnode_copy_props()
Date: Tue, 26 Sep 2023 08:14:37 -0600
Message-ID: <20230926141514.2101787-24-sjg@chromium.org>
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

Follow the order used by memcpy() as it may be less confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/vbe_request.c    | 2 +-
 boot/vbe_simple_os.c  | 2 +-
 drivers/core/ofnode.c | 2 +-
 include/dm/ofnode.h   | 6 +++---
 test/dm/ofnode.c      | 9 ++++-----
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 2f218d4bf97c..917251afa1ca 100644
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
index 3285e438a568..84626cdeaf24 100644
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
index 2cafa7bca5b3..515396c62f49 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1731,7 +1731,7 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 	return ret;	/* 0 or -EEXIST */
 }
 
-int ofnode_copy_props(ofnode src, ofnode dst)
+int ofnode_copy_props(ofnode dst, ofnode src)
 {
 	struct ofprop prop;
 
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 06c969c61fe8..32917f661557 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1598,7 +1598,7 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
 /**
  * ofnode_copy_props() - copy all properties from one node to another
  *
- * Makes a copy of all properties from the source note in the destination node.
+ * Makes a copy of all properties from the source node to the destination node.
  * Existing properties in the destination node remain unchanged, except that
  * any with the same name are overwritten, including changing the size of the
  * property.
@@ -1606,9 +1606,9 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
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
index d71faac0ee43..dee71ee5e545 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1209,12 +1209,11 @@ static int dm_test_ofnode_too_many(struct unit_test_state *uts)
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
@@ -1246,7 +1245,7 @@ static int dm_test_ofnode_copy_props(struct unit_test_state *uts)
 	src = ofnode_path("/b-test");
 	dst = ofnode_path("/some-bus");
 
-	ut_assertok(check_copy_props(uts, src, dst));
+	ut_assertok(check_copy_props(uts, dst, src));
 
 	/* check a property that is in the destination already */
 	ut_asserteq_str("mux0", ofnode_read_string(dst, "mux-control-names"));
@@ -1262,7 +1261,7 @@ static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
 
 	src = ofnode_path("/b-test");
 	dst = oftree_path(otree, "/node/subnode2");
-	ut_assertok(check_copy_props(uts, src, dst));
+	ut_assertok(check_copy_props(uts, dst, src));
 
 	return 0;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

