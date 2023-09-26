Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D04EE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6645C86E88;
	Tue, 26 Sep 2023 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HirAh4z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE5E86DEB; Tue, 26 Sep 2023 16:16:03 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB9986E0D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fe99a5f29so16739f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737755; x=1696342555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QG189pK7lvRFUtV+X0/qF259uXyW2BWDpmw4OxLGqE=;
 b=HirAh4z/8cT+SrSFXxDWN2DZeufS0RHS3ofpIg4glaoDOwU5OKo+LbO2TjrREFH7HN
 rZi11xuQNmzq9WCjxZcUMwts/+XEQI0RBR0XOm/my0uGWC018UdlTq0pR1AoYsSDDtrn
 lcvat4W4RVVGo7pTv3NkUNAisOAl/vRY+d844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737755; x=1696342555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QG189pK7lvRFUtV+X0/qF259uXyW2BWDpmw4OxLGqE=;
 b=vHDe00IcYQTBRkYd8q8yG1/Q89sKPbVZqkhrhJgTaO3YomXTDw0TpM3K75xV0NFTc0
 Tp+z7c0yWrjLy5FyflW0c0xcT6egXzT65jsTH3qBdwVokpQCGrxAyQfPnHfYUtZwMtkM
 9p26S2j2Yz8hbbjtVV3h73C6be+XvyIhIH3r7yXUaloRPxdxa6MY9BEnFjPOUjqFAK6V
 zLSrprbai9vduoG/2Lk0eL9kYcLvyfER7y7rCybDADD7W8ufvUvgxxhh4VwwWkIbJxwe
 QbSQq6ayW4Iceq8g3OmkPOm2NgM/1C4ZgntOFiFNcZf8ktjlLTOkBqfhipaxrvN7XIuJ
 aVZw==
X-Gm-Message-State: AOJu0YzP6eVyfNY1ZhRyoI4z0GbRvEo/2sXnlNuqrQLbmtbEKWZHKSM5
 butU5mNWt+U7hxtuNmj0ftMnvDiq2MQJES+erOI=
X-Google-Smtp-Source: AGHT+IEtqYQSlrVJmjV4ZRfD+q5HrFd0EH7Xk4496ErENtJRhEXZtDrwNbGANaBWG/TgT+FcUCO/MQ==
X-Received: by 2002:a6b:f418:0:b0:786:f4a0:d37e with SMTP id
 i24-20020a6bf418000000b00786f4a0d37emr9404143iog.4.1695737755069; 
 Tue, 26 Sep 2023 07:15:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 31/44] dm: core: Support writing a 64-bit value
Date: Tue, 26 Sep 2023 08:14:45 -0600
Message-ID: <20230926141514.2101787-32-sjg@chromium.org>
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
index 4dcb3dd1c037..18d2eb0f1186 100644
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
index ebea29d32afc..ef1437cc5562 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1461,6 +1461,16 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value);
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
index 9477f791d649..e078a9755a83 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1009,7 +1009,8 @@ static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32_array, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
-static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
+/* test ofnode_read_u64() and ofnode_write_u64() */
+static int dm_test_ofnode_u64(struct unit_test_state *uts)
 {
 	ofnode node;
 	u64 val;
@@ -1018,6 +1019,10 @@ static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assertok(ofnode_read_u64(node, "int64-value", &val));
 	ut_asserteq_64(0x1111222233334444, val);
+	ut_assertok(ofnode_write_u64(node, "new-int64-value", 0x9876543210));
+	ut_assertok(ofnode_read_u64(node, "new-int64-value", &val));
+	ut_asserteq_64(0x9876543210, val);
+
 	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
 
 	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
@@ -1028,9 +1033,15 @@ static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
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

