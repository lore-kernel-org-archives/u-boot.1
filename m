Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE6BCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A49986DA3;
	Thu, 21 Sep 2023 03:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jd6jBSDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C758615A; Thu, 21 Sep 2023 03:58:20 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0BA86C3E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-452527dded1so242860137.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261488; x=1695866288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wv3ykVIZE/QtHXnzcOO9VmR4yUqIAZmtqoPu6ubEKFE=;
 b=jd6jBSDR73wSlH4SVyhPVheM1yhUBHSvcg9fCTD+OeOx7ZxMesiNGSIbbtPW8OyEHc
 C51Z1HiOWSltHmQj2zUGDDgV7n6APDIn/K/3mNfZrptOsOH5B6j6n0DDluXgnFiTltvE
 MvILWZJ7kshgp4yNr5ul35wg6ar1vdabDweIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261488; x=1695866288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wv3ykVIZE/QtHXnzcOO9VmR4yUqIAZmtqoPu6ubEKFE=;
 b=gpkYvKL1UUTN80m5YOh/48satraKU803ykbEmkuEUeFLr3B1RRW4WuaNtLT5ocdkr8
 a85X1m/UF4evGGWcMT6XI9uRhvk18cQsVjkghBnPjRYB17/7XyPTOXGxaXMsChha9UPp
 DvSJSSNQYkm7S/zj2pdPGTG2N4SAPXz6cuSPfbGB0TCiDIZxL+Xc4cisrrEsKuPZjZqt
 q5VixS2Jp7wq8U4BbLifiWsIv0ngKpSrIzVxq53nJDwZB9eYx7YKNPEFZbnBRKH/KDUH
 fiPuPZKJSbKy4NPtAACnvt/R5vyfQQug8iducLv+kLwuQfE21Fn4KNdfyYmhq9arzvV5
 DEaA==
X-Gm-Message-State: AOJu0YzKlo941Dg4ViypHBCFhC9paGzcvxYee16A49SM/lMvrxdAd1FW
 DIyb4bfD2EFaMfG9G2j3JP8+IJeTEJJqNGLPNfs=
X-Google-Smtp-Source: AGHT+IGLznH3oauj/QySapz07VotVz6/ulGqxnz8EVuv1Irtr0ZGNJIgEJGHggeGpRZcJpwMCivxDQ==
X-Received: by 2002:a67:e8da:0:b0:452:58cc:d29e with SMTP id
 y26-20020a67e8da000000b0045258ccd29emr4946950vsn.11.1695261488012; 
 Wed, 20 Sep 2023 18:58:08 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 23/32] dm: core: Support writing a 64-bit value
Date: Wed, 20 Sep 2023 19:57:12 -0600
Message-ID: <20230921015730.1511373-24-sjg@chromium.org>
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

Add support for writing a single 64-bit value into a property.

Repurpose the existing tests to handle this case too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 17 ++++++++++++++++-
 include/dm/ofnode.h   | 10 ++++++++++
 test/dm/ofnode.c      | 15 +++++++++++++--
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 0229695dba1f..2ef4114cb6f8 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1621,7 +1621,22 @@ int ofnode_write_u32(ofnode node, const char *propname, u32 value)
 		return -ENOMEM;
 	*val = cpu_to_fdt32(value);
 
-	return ofnode_write_prop(node, propname, val, sizeof(value), false);
+	return ofnode_write_prop(node, propname, val, sizeof(value), true);
+}
+
+int ofnode_write_u64(ofnode node, const char *propname, u64 value)
+{
+	fdt64_t *val;
+
+	assert(ofnode_valid(node));
+
+	log_debug("%s = %llx", propname, (unsigned long long)value);
+	val = malloc(sizeof(*val));
+	if (!val)
+		return -ENOMEM;
+	*val = cpu_to_fdt64(value);
+
+	return ofnode_write_prop(node, propname, val, sizeof(value), true);
 }
 
 int ofnode_write_bool(ofnode node, const char *propname, bool value)
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 58c6849534ea..726d8f82ddf2 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1460,6 +1460,16 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value);
  */
 int ofnode_write_u32(ofnode node, const char *propname, u32 value);
 
+/**
+ * ofnode_write_u64() - Set an integer property of an ofnode
+ *
+ * @node:	The node for whose string property should be set
+ * @propname:	The name of the string property to set
+ * @value:	The new value of the 64-bit integer property
+ * Return: 0 if successful, -ve on error
+ */
+int ofnode_write_u64(ofnode node, const char *propname, u64 value);
+
 /**
  * ofnode_write_bool() - Set a boolean property of an ofnode
  *
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index af844a50308e..5e63efdfa891 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -990,7 +990,8 @@ static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32_array, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
-static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
+/* test ofnode_read_u64() and ofnode_write_u64() */
+static int dm_test_ofnode_u64(struct unit_test_state *uts)
 {
 	ofnode node;
 	u64 val;
@@ -999,6 +1000,10 @@ static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assertok(ofnode_read_u64(node, "int64-value", &val));
 	ut_asserteq_64(0x1111222233334444, val);
+	ut_assertok(ofnode_write_u64(node, "new-int64-value", 0x9876543210));
+	ut_assertok(ofnode_read_u64(node, "new-int64-value", &val));
+	ut_asserteq_64(0x9876543210, val);
+
 	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
 
 	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
@@ -1009,9 +1014,15 @@ static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
 		    ofnode_read_u64_index(node, "int64-array", 2, &val));
 	ut_asserteq(-EINVAL, ofnode_read_u64_index(node, "missing", 0, &val));
 
+	ut_assertok(ofnode_write_u64(node, "int64-array", 0x9876543210));
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
+	ut_asserteq_64(0x9876543210, val);
+	ut_asserteq(-EOVERFLOW,
+		    ofnode_read_u64_index(node, "int64-array", 1, &val));
+
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_u64, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_add_subnode(struct unit_test_state *uts)
 {
-- 
2.42.0.515.g380fc7ccd1-goog

