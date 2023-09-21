Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000B9CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651B886D7B;
	Thu, 21 Sep 2023 03:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eAJoM9Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C7C86DC1; Thu, 21 Sep 2023 03:58:08 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56FF186D69
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4526f0bdf72so237852137.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261480; x=1695866280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovTfh6ERTsrOYQaBI8e8Lj6TjUXB7ByPOJaNS0CwdHw=;
 b=eAJoM9Cc8xUjcHKYnAvh7a15dsVb20vO5+/gi87lTfY47UFSJsWVZ2WlpM+0gCFvBe
 ZH7DdeAMTUJEk7aTgoBjGsz0eZyd/59WoEIr6f6MkrgwRbPMWRTNDI/aoXTSfeExOmA1
 MoofZJJ3l1d3oP3RVwn+0+lKGLfN/93naCOn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261480; x=1695866280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovTfh6ERTsrOYQaBI8e8Lj6TjUXB7ByPOJaNS0CwdHw=;
 b=wWgcUbFEX29jpRzpvGWbuLPNR5bRi4yhzRM0lKx4niqQuIxgb/8wLmhm2UKHFHzH07
 Pb/ncOE0Rh9VqQ9HHs7j5f+GeDR4LRDdO4bLX0n3Ysiif8hUwzY6Cv7/bka9RdEA0tic
 tu5Put29kITSEofk0ycBVlclW1PlBxi4cTzdYJoHRPmeRXHQ2+n5Gwfj23yqK64dR4Qo
 Nx0AxYiNy4ytR+XCqLDo6DJ2qi+xmaVMfPTqPEW+wZxuo1o13FXqszQfe0vZymn/S/qL
 sdye+JOwm2wMmwaXXko7cxcULzN8J2e8KssHNf5Uen5Sqk5OzTRcp6+wP4SHqPIozEMg
 fZ2w==
X-Gm-Message-State: AOJu0YxJ21rXVnngbadHM1AVxcZvshZuIh6WMLqdhleRZ7Z4pqpQfLfy
 PeiUxprDb09S58R+041hDqvbwcT/vcZGUYjgwVw=
X-Google-Smtp-Source: AGHT+IHGDI6DT15weVbQawqZ7tarx8s83vQKiZLZwfEtaUTCfsTY68mMSDpxiov2eaFWpv8OG1V/Ww==
X-Received: by 2002:a67:fc43:0:b0:450:c5e4:4869 with SMTP id
 p3-20020a67fc43000000b00450c5e44869mr4541996vsq.25.1695261480104; 
 Wed, 20 Sep 2023 18:58:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 16/32] dm: core: Ensure we run flattree tests on ofnode
Date: Wed, 20 Sep 2023 19:57:05 -0600
Message-ID: <20230921015730.1511373-17-sjg@chromium.org>
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

We need the UT_TESTF_SCAN_FDT flag set for these tests to run with flat
tree. In some cases it is missing, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/ofnode.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 49fa5d27e6ec..a29c9aae870b 100644
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
2.42.0.515.g380fc7ccd1-goog

