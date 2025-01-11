Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB480E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63DE807BC;
	Sat, 11 Jan 2025 01:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GEoRN+Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4D2807B4; Sat, 11 Jan 2025 01:02:03 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E531780690
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a8180205f3so11457805ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553719; x=1737158519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWXQ6gVFCh8WJXgqexWukHBrjeOAkjpN7GHOKlkuA7o=;
 b=GEoRN+SbZwJStmvlF1v8cGFrM0XIwB4qSOg1iEzFxwWS59kokzdk0lVZ1jkllkUHwW
 fYIQdir9w56M//IRnXoYv+eMjmGwvZxqIzGqIpo4iTcX5TaWMCidbxcEPQ89PYL1ReZN
 jOGydNSUAVQY91dsxuwOysrW3UUgvZIhOht9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553719; x=1737158519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWXQ6gVFCh8WJXgqexWukHBrjeOAkjpN7GHOKlkuA7o=;
 b=A+V1Wp48KU6eqnUQ1KE8L7sYPIMkXddJKNx3S9X3NO7rpnX9VgLicadxMEKlPCSpa5
 lONOqQ22Nop+/oE/HWAIeQIPH1FBVZkP3Px4qOiXG8+s/LgnpgTzx2eqT4h5wlFuDw5U
 oQMT+s/B+AyewndPWxZui28dRKz28OtgU3ZokQG5oAEVjH/leJofym3ysDZ5vXubGhwA
 1fTCjxF8VAzApAvaM9Xtrfm3ck525Sl3L1LaEZacbRxgfiJButW4deIZF+u/S2dYLGlj
 sS31WXHDYUhU870Y2dKPHT7mOZYjU92YOhT/t2ozp7XCsQ9VgA6vZiu2GKo3fhUhc7it
 BARQ==
X-Gm-Message-State: AOJu0YxYPTzzIGHn6/2nDTFW5StIQ+wYPJoVQ8PuCcM+6ZbVEiar3zdX
 o8kuKNWQRLiEdBe7OXT1AqR8+5E5yJ0Tx135wydXF2woNWVXeBloh5J0u7WX3OV1iPknS9j1tzk
 =
X-Gm-Gg: ASbGncs477l4ADjSXt+ITpUKBDJGKCh02wbBkyWuweGAVYGITqSc0+MZV35BX+wTHak
 Ou85/EnQGjxMmQU5J0S/lI/QBhqr+iyiACLG6lcoaeL0jcpNAeUf13l7lsvHWl29PP+LOTYRtmo
 u+6jH4938+9axmzSc1lh5wtvslt+QMpaxqZTq4Wr/sRNTD8JBsqb75VJFCt6M8z35QVno2AHR3q
 kV9YFKEkebs5xgg0MDk/1RBNM7X4Waw1giAc2vBHa4iVhI5cNx7/qpaRhZUlWsxz8XSMInglVQp
 x2KwXS50sJonlzpeJw==
X-Google-Smtp-Source: AGHT+IERisX9/w7W1aGfZsmLean0wU0mkBpsdl3AyC+5yHdawrZuvtjiB623/Xro6IO7SQwXfInuNQ==
X-Received: by 2002:a05:6e02:1605:b0:3ce:3395:f7b1 with SMTP id
 e9e14a558f8ab-3ce475fbc60mr61325125ab.9.1736553718639; 
 Fri, 10 Jan 2025 16:01:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 30/30] dm: core: Provide ofnode_find_subnode_unit()
Date: Fri, 10 Jan 2025 17:00:29 -0700
Message-Id: <20250111000029.245022-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Changes in v3:
- Be careful not to resend the bloblist license and get_size patches

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

