Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF5CE7A8E
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D105D86BB6;
	Sun, 24 Sep 2023 21:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kJoPU6gM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82BDC8698D; Sun, 24 Sep 2023 21:26:26 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B21F86B2C
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f8e4108c3so168746339f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583574; x=1696188374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6PWw/YdYnwfMdArY+cSF/qdhNc86DrkULdBAKHV1EM=;
 b=kJoPU6gMijiN/ARxzJxQiSD4ynU4WzN1hmwIGzScEF32E3KyxwaWHjYAD9LxI6U1bQ
 0YXEs15QkQLh75tMeUlQ0z/VJSe/UDXyrStoOJMIfKABoTfxYIaUXmGtj20OoZ/ALfZ+
 YoB6IhrX6jhVCImG4TPfJvPAuHGwPe10EkUm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583574; x=1696188374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6PWw/YdYnwfMdArY+cSF/qdhNc86DrkULdBAKHV1EM=;
 b=uHSPsUnJ2ffCfkX5cyEO5MBsQykq8XRtNftC8ubCQ9+vh7brswRGUbc9bm0lg4yvCf
 U8l9dqhPK8BR2gn7amaE3L8UQbf7uZvyhgOzlxRRKhX9DreZTTet9fIugKWewsiSlBPB
 82kFKXWR/7rTDwg2c8U1io0iko920FbXphn1dAwKJ4uEPoci3xkziWZ0THhTrCB08EIQ
 jPd22vOOhbMEB/gTdmtQE7lYGLqpjAu0ZdkExH/gYRRRUaIMUGupv06/m4WR686bBl0T
 +7y8TQ79LUk3LmWXE8rPuVbXZdXLoVABTwyKcH8jDKu1y1lfvXFUl9L2EFlYHzcTilVb
 gfVA==
X-Gm-Message-State: AOJu0Yx4Akg0HFjX9WGUhqFjQjrjY56yNhvZfsFl24AFGRfeNXkMzGJa
 xl0eVixOHMvEPcop2C0A4csVig8E1m0dUtxWi1c=
X-Google-Smtp-Source: AGHT+IGDKdu5MfJgSf5enFqQ1WDFBoRBMvW+JrNfOhyrMrcVi+K9uzv7j+3JQjhx0Z5DBIOwFvzxAg==
X-Received: by 2002:a5d:9314:0:b0:791:385c:f8b0 with SMTP id
 l20-20020a5d9314000000b00791385cf8b0mr4887759ion.3.1695583574679; 
 Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 29/38] dm: core: Support writing a 64-bit value
Date: Sun, 24 Sep 2023 13:25:14 -0600
Message-ID: <20230924192536.1812799-30-sjg@chromium.org>
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
index 363b9da27575..7421f22aae99 100644
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
index b366830ff915..c2d3337113c7 100644
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

