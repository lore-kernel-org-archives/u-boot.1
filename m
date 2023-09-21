Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E94CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D025686DF2;
	Thu, 21 Sep 2023 03:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlqIzUpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C961D86BFB; Thu, 21 Sep 2023 03:58:18 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B20A86D6E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so11607639f.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261479; x=1695866279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6QZuQgplt3iU4tAg/IkdXpx55MqjaPvuCvnlaaaC58=;
 b=HlqIzUpnp44jQpG9d/FHZAbKyPxYYh/phNXFyTpbSCr0P03BwdY4dApbDIKa0HIyqJ
 FoS8UaJkfV9zXL+poBfTHGmwGXS3O1IGSpuzDIdnGUO2FF/HkgMhjAnWQP4cy584VHQV
 mYJmxRPygIfYDTXBolmBPPW/Pw5QzFtztkviE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261479; x=1695866279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6QZuQgplt3iU4tAg/IkdXpx55MqjaPvuCvnlaaaC58=;
 b=eiCtzNqdsIhhlDXbbU5UijofRBP8JTZTBlpWoUXTJaPOnofolyxtgJ1FIZdqIk7ik3
 rk5c/kL126BHysJ0as76Nb5N1qcVpXxXCU/kNhjGKCjx6jKzpcG7Pnih5ZK6PKoORHUn
 DXXlMO8DepR01xhKTd4wMjdoXEOgVleotdRq+UbrWaro7ZtqwwKa+ze11BvKIMuRywKt
 SqeMOltmyFTnyWX46eMMB5Nrq49K0ciYOOR34jDuHhT4/i44WOhe3ox4ulqcGGkEscJP
 SjaDWcQvB5c5l7cmRKrsnX95KVCqF1eeUarfauULF3qLyZ72yoZigHta3R1hSk2H+CoV
 a2jA==
X-Gm-Message-State: AOJu0YyFDrOg6vJ0/I3nTNcRmXyGYuZljPZZdS/0agflPafYWBmEraMt
 +ej6IMgtK2uKsExDFOdP9ipe1WFPBdLRiKzSTuw=
X-Google-Smtp-Source: AGHT+IEqlvnu/Ny1Fos9KNLShTnK8LG+jjvn91GpsjNRLnxNKz0QOcqTZlOZoqMJaHzO/jAtmgOtvQ==
X-Received: by 2002:a6b:dc1a:0:b0:791:8f62:31ef with SMTP id
 s26-20020a6bdc1a000000b007918f6231efmr3802688ioc.5.1695261478903; 
 Wed, 20 Sep 2023 18:57:58 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 15/32] dm: core: Reverse the argument order in
 ofnode_copy_props()
Date: Wed, 20 Sep 2023 19:57:04 -0600
Message-ID: <20230921015730.1511373-16-sjg@chromium.org>
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
index 8311282abf69..8227eac1e4fe 100644
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
index 0a85db31f360..abdfa58036d5 100644
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
index b74f5c2ebcff..49fa5d27e6ec 100644
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
2.42.0.515.g380fc7ccd1-goog

