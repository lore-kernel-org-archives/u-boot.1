Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E86C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC1E86592;
	Wed, 30 Aug 2023 20:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eliEk8it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 538588655A; Wed, 30 Aug 2023 20:06:17 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7C8865A0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7926de0478eso29124239f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418757; x=1694023557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsIbF0WQvgpg1aE2QfWyIB2KJjoiil25w64511KBO3w=;
 b=eliEk8it2+7zhUUvNbcp4/9rMa9RZxH7v2pX9MKTbW8P2IKWjMCDW9gzSwSBg4T66H
 BxoS7oaRcHFbibiA5K09qAxBX5JV6Yws8Hqh4cE0ADpFMtYwWKEEcPTXjBbVXVBHmYS0
 BPqxOznnFgE1MLLLLoXk7Gi65dwi2hpUoNFDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418757; x=1694023557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsIbF0WQvgpg1aE2QfWyIB2KJjoiil25w64511KBO3w=;
 b=ZjltG/2agTP5I9GguW/MLIM3AI8qS4WFrlxB4bTF+hZcq7ecvNPi157LuvaUpNJgJ7
 w5SJZr/M8N3cJGiXCUfogjHj0BR4tXauLN3KYHnln+plJVNFuGFloPUb+3+6OM06/Hk2
 t6OoI1dTC2C5kvH6/DmKsnpweWA3ch7BGqemcUz/06xUbTBUUjc54Uc6vHQEpdxIk2Eg
 QRa7YXPU5Qa7Sj4DdrJS4rnSwo1Mmjc67dZIoYR7mzIS/ycPW08yQcRSrJMP2W4lX15h
 B/5KyYLnngWFqsqaOGne0SoObV8TJJL8MW4wBHOTS7K7TPV+ZGJVfXyC8j/dj8ZH0Awn
 eOrg==
X-Gm-Message-State: AOJu0YyvRzO7gJ5CvtlINwa7FAi0D2fn8xX2LIgLWNhUsX+HI0flGwo9
 lUCW4z8z5hn0zlpTZCxiUhOh5Bc5K7Ort4ZaHG4=
X-Google-Smtp-Source: AGHT+IEb6s0VPp1XlT+iISdoYjd88R+ZDgH6rjX8BYx0xQgE22cBPBYFg//hwF5KZRPAFmLB+yhoYA==
X-Received: by 2002:a05:6e02:17c9:b0:349:345b:6595 with SMTP id
 z9-20020a056e0217c900b00349345b6595mr292895ilu.11.1693418757773; 
 Wed, 30 Aug 2023 11:05:57 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 23/32] dm: core: Support writing a 64-bit value
Date: Wed, 30 Aug 2023 12:04:54 -0600
Message-ID: <20230830180524.315916-24-sjg@chromium.org>
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

Add support for writing a single 64-bit value into a property.

Repurpose the existing tests to handle this case too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 17 ++++++++++++++++-
 include/dm/ofnode.h   | 10 ++++++++++
 test/dm/ofnode.c      | 15 +++++++++++++--
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 0229695dba1..2ef4114cb6f 100644
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
index 58c6849534e..726d8f82ddf 100644
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
index af844a50308..5e63efdfa89 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

