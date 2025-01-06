Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E3FE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3851E806EB;
	Mon,  6 Jan 2025 15:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R3MPzQNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86166806EB; Mon,  6 Jan 2025 15:34:15 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E78D8070B
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a8146a8ddaso53454255ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174051; x=1736778851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNFqWuiNYfdY0JGGdbUArR5tsuU8xYG0fIPIlCHoeXs=;
 b=R3MPzQNic3QYLUJ9uUs4g+0ULP2+u97JsWt/MCInHbnNiw+PksSJMIg+d44s/gSINc
 bwl6M9QE0so7QvnYjWQD3rsSTn4qQZKlYlgMqFsNsZJWTboJNjUXk6F8z3nBzG78msNw
 MsCRL2qXuE5+iRsBkyd25Xk9j1Uq57YRQQAlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174051; x=1736778851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNFqWuiNYfdY0JGGdbUArR5tsuU8xYG0fIPIlCHoeXs=;
 b=mkeOlPVnbvNAGMxpJY8rbmnglnDq+gWWC7WloqIKs0af/L6oPhMYCDh1dc/s32LB1E
 S6Y2z5vh8Z4jucdRaUQgRIF2vjfVginj72SX8MEVg1x8gY0HJRnCf3R9CFZ8OARZ1V/d
 zxUKBer6uuMeo8WnaFRYqVdpL8qmzc7hnV7OAb88hp632Rfc18CFOibd/nOsEbedO9vn
 WgbPXrZ5kYRXzm7leSIQ7o8p7SnC+QHG893+Oahp1uaCZ9aBLHhKUNa41vfoZzT70rRZ
 zDKA0CfD5pxMVxxeKAGEKOsq6mzSU4UGFP12PIAcPuGdj8EgE8Pccp4ip7ypOnMNq8q8
 4iFg==
X-Gm-Message-State: AOJu0Yxiev9I7MSutvGznSZ0atZFoVe0ZUlhxpco5wqeYuLX7trzsqZQ
 T0KhH93+sOZEUvtdqaZXmQTKcpeIJY0a3wV6bV8MNIPWRxUIBUmRPtNCHYm4sR8d9Qj/VcSTQ0s
 =
X-Gm-Gg: ASbGncthptwWcofVdZL+5doHQpowBhVJkSJvCRHh3CBM6tnLSEJ/c7xhoIELvS/AVdN
 xBieOiDt/lOLQ3/uhuiMDlOG2D6AAYmjh+rZ4PVDtbhyuPFmh//MlKiV6aCwUNiwbPfG2o0oTP8
 ERpJdrbJ1f5p7KUIY03ZLLPgQq9CJGNA5Pt4Dmu8aP6T9hrhSvowtw7nkpqkcc+hwPvxQrj0TdI
 ZYVeJRfHhLXefUtEM2Eb7wbl3j6hBVSyasuzENED3fhnJyFXfZ1uCZZKgl8/QCsmAzsuG8rsrO3
 V8YrxDf7Gt4/ZfW4pA==
X-Google-Smtp-Source: AGHT+IFKXg5ZigF1P459Jqo3k5F5nAPdQMQZi962NoeNJVtpCbBu8KEOSblOb6wTzeWO2sQjYI92mA==
X-Received: by 2002:a05:6e02:219c:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3c2d5915ea4mr507058065ab.20.1736174051517; 
 Mon, 06 Jan 2025 06:34:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:34:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 33/33] dm: core: Provide ofnode_find_subnode_unit()
Date: Mon,  6 Jan 2025 07:32:29 -0700
Message-Id: <20250106143229.3023771-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

The ofnode_find_subnode() function currently processes things two
different ways, so the treatment of unit addresses differs depending on
whether OF_LIVE is enabled or not.

Add a new version which uses the ofnode API and add a test to check that
unit addresses can be matched correctly. Leave the old function in place
for the !OF_LIVE case, to avoid a code-size increase, e.g. on
firefly-rk3288

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split prerequisite patches into their own series

 drivers/core/ofnode.c | 29 ++++++++++++++++++++++-------
 include/dm/ofnode.h   | 12 ++++++++++++
 test/dm/ofnode.c      | 19 +++++++++++++++++++
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 529bc132f7d..c9b03b0f925 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -599,14 +599,9 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
 	log_debug("%s: %s: ", __func__, subnode_name);
 
 	if (ofnode_is_np(node)) {
-		struct device_node *np = ofnode_to_np(node);
-
-		for (np = np->child; np; np = np->sibling) {
-			if (!strcmp(subnode_name, np->name))
-				break;
-		}
-		subnode = np_to_ofnode(np);
+		subnode = ofnode_find_subnode_unit(node, subnode_name);
 	} else {
+		/* special case to avoid code-size increase */
 		int ooffset = fdt_subnode_offset(ofnode_to_fdt(node),
 				ofnode_to_offset(node), subnode_name);
 		subnode = noffset_to_ofnode(node, ooffset);
@@ -617,6 +612,26 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
 	return subnode;
 }
 
+ofnode ofnode_find_subnode_unit(ofnode node, const char *subnode_name)
+{
+	ofnode subnode, found = ofnode_null();
+
+	assert(ofnode_valid(node));
+	log_debug("%s: ", subnode_name);
+
+	ofnode_for_each_subnode(subnode, node) {
+		if (ofnode_name_eq_unit(subnode, subnode_name)) {
+			found = subnode;
+			break;
+		}
+	}
+
+	log_debug("%s\n", ofnode_valid(found) ?
+		  ofnode_get_name(found) : "<none>");
+
+	return found;
+}
+
 int ofnode_read_u32_array(ofnode node, const char *propname,
 			  u32 *out_values, size_t sz)
 {
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 3bb7d3e05e1..74ee6fb4ee2 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -607,6 +607,18 @@ bool ofnode_read_bool(ofnode node, const char *propname);
  */
 ofnode ofnode_find_subnode(ofnode node, const char *subnode_name);
 
+/**
+ * ofnode_find_subnode_unit() - find a named subnode of a parent node
+ *
+ * @node:	valid reference to parent node
+ * @subnode_name: name of subnode to find, including any unit address. If the
+ *	unit address is omitted, any subnode which matches the name (excluding
+ *	any unit address) is returned
+ * Return: reference to subnode (which can be invalid if there is no such
+ * subnode)
+ */
+ofnode ofnode_find_subnode_unit(ofnode node, const char *subnode_name);
+
 #if CONFIG_IS_ENABLED(DM_INLINE_OFNODE)
 #include <asm/global_data.h>
 
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index ce996567c3c..521359c9bd7 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1201,6 +1201,25 @@ static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_find_subnode, UTF_SCAN_FDT);
 
+/* check ofnode_find_subnode() with unit addresses */
+static int dm_test_ofnode_find_subnode_unit(struct unit_test_state *uts)
+{
+	ofnode node, subnode;
+
+	node = ofnode_path("/some-bus");
+	ut_assert(ofnode_valid(node));
+	subnode = ofnode_find_subnode_unit(node, "c-test@5");
+	ut_assert(ofnode_valid(subnode));
+	ut_asserteq_str("c-test@5", ofnode_get_name(subnode));
+
+	subnode = ofnode_find_subnode_unit(node, "c-test");
+	ut_assert(ofnode_valid(subnode));
+	ut_asserteq_str("c-test@5", ofnode_get_name(subnode));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_find_subnode_unit, UTF_SCAN_FDT);
+
 /* test ofnode_find_subnode() on the 'other' tree */
 static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
 {
-- 
2.34.1

