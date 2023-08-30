Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8F2C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E35F866EC;
	Wed, 30 Aug 2023 20:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IpcLgH3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8956E865DE; Wed, 30 Aug 2023 20:06:05 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7712986582
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so97075ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418751; x=1694023551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSNSZK8Ouzdl00uGCrll+840pwDcIDjlzYLqHmzcHXw=;
 b=IpcLgH3yqZd9KWdN45BsIKbSGXLg6f7FEBWwVHtIbsYLlYlPBy5IDMT2T+uEhbEJuo
 X43/UY1Xga5szqCjsih9w0kbkISFENg4C8mjScSkCUaYbXX7N+FmiOd+DdE1TA4lrpY/
 638nIGWqvDeFzIXZdwbOBPbE8LKWyJBFeYgLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418751; x=1694023551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSNSZK8Ouzdl00uGCrll+840pwDcIDjlzYLqHmzcHXw=;
 b=b3IpdmSUymOM2Xb8ZIIwWEv/bxwuLuibqjayfCVMPTs45SI0+5yeVMkNm8L5hhU/5h
 X6S6WxNh4gliR1mE1hvwCYeC49AYPbTyvYFiulhsNG5C3bJmWUNbyH60Xamwrfuih6jb
 6B4VkC3hUoRPtYybuYP3kpF9sODKmcyXtsoO5q0hU6kuPXRJk1o082GrZttdx3b/Mwkb
 C1y6Da6T6bypER4tq4DXehzr7sD2/yli+Mi5ZU5A5NYlaxMtPbp98LJnFSMhWuihjdeH
 v4rdgBCi47Mrsf5jcd/WurULhG18oWp4mBh5SyX2hk+Fj4YSVNtvvqqaeuTWVSa7KCgi
 9c7A==
X-Gm-Message-State: AOJu0YzKeCO42v4GFhZOj+tiStQReiuW+BQDmvM0WYzFSI5fIplWPrN/
 zmqhHv0QOEUH1w45QX0hJFU+ae9R8G39o7vBxnw=
X-Google-Smtp-Source: AGHT+IF8ELwTocKysK9tRKZ1VbI6rCONUTQ+bQAz/VgSsIDr8TJyU6zjSLTzSxO7JArsfi9rFUWo0Q==
X-Received: by 2002:a05:6602:2494:b0:786:f352:e3d4 with SMTP id
 g20-20020a056602249400b00786f352e3d4mr3276155ioe.7.1693418751760; 
 Wed, 30 Aug 2023 11:05:51 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 16/32] dm: core: Ensure we run flattree tests on ofnode
Date: Wed, 30 Aug 2023 12:04:47 -0600
Message-ID: <20230830180524.315916-17-sjg@chromium.org>
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

We need the UT_TESTF_SCAN_FDT flag set for these tests to run with flat
tree. In some cases it is missing, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/dm/ofnode.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 49fa5d27e6e..a29c9aae870 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -114,7 +114,7 @@ static int dm_test_ofnode_compatible_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_compatible_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_compatible_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_get_by_phandle(struct unit_test_state *uts)
 {
@@ -146,7 +146,8 @@ static int dm_test_ofnode_get_by_phandle_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_by_phandle_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_by_phandle_ot,
+	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int check_prop_values(struct unit_test_state *uts, ofnode start,
 			     const char *propname, const char *propval,
@@ -196,7 +197,8 @@ static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_prop_value_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_by_prop_value_ot,
+	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_fmap(struct unit_test_state *uts)
 {
@@ -237,7 +239,7 @@ static int dm_test_ofnode_read(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 {
@@ -256,7 +258,7 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_read_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_read_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 {
@@ -452,7 +454,8 @@ static int dm_test_ofnode_get_child_count_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_child_count_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_child_count_ot,
+	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_is_enabled(struct unit_test_state *uts)
 {
@@ -526,7 +529,7 @@ static int dm_test_ofnode_get_reg_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_reg_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_reg_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_get_path(struct unit_test_state *uts)
 {
@@ -566,7 +569,7 @@ static int dm_test_ofnode_get_path_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_path_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_get_path_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_conf(struct unit_test_state *uts)
 {
@@ -581,7 +584,7 @@ static int dm_test_ofnode_conf(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_conf, 0);
+DM_TEST(dm_test_ofnode_conf, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
 {
@@ -646,7 +649,7 @@ static int dm_test_ofnode_string(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_string, 0);
+DM_TEST(dm_test_ofnode_string, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 {
@@ -717,7 +720,7 @@ static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_phy, 0);
+DM_TEST(dm_test_ofnode_get_phy, UT_TESTF_SCAN_FDT);
 
 /**
  * make_ofnode_fdt() - Create an FDT for testing with ofnode
@@ -901,7 +904,7 @@ static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_u32(struct unit_test_state *uts)
 {
@@ -1103,7 +1106,7 @@ static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_compatible_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_by_compatible_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 {
@@ -1272,7 +1275,7 @@ static int dm_test_livetree_align(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_align, UT_TESTF_LIVE_TREE);
+DM_TEST(dm_test_livetree_align, UT_TESTF_SCAN_FDT | UT_TESTF_LIVE_TREE);
 
 /* check that it is possible to load an arbitrary livetree */
 static int dm_test_livetree_ensure(struct unit_test_state *uts)
@@ -1291,4 +1294,4 @@ static int dm_test_livetree_ensure(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_ensure, 0);
+DM_TEST(dm_test_livetree_ensure, UT_TESTF_SCAN_FDT);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

