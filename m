Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03DBE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE57286E43;
	Tue, 26 Sep 2023 16:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DSjSjBp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A7BF86E0D; Tue, 26 Sep 2023 16:15:57 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CCA86DC7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35130c8bc79so17579425ab.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737749; x=1696342549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjxxRrsyO9RXtZgkSofP3sq4lBbxmzzvhqNdKiznt5Y=;
 b=DSjSjBp+FfTPn0kgvc0bk/jqijW8jkurgAyc3H3UcKi9Tq8FMHaYmy36/JaHxOcFYh
 Gmr9EMWJlmS7HqWYnb1+2EW8t2rVcnFkkGuJLL9mXDys7mBWUmyadwFTE1UN8OxmF6ZR
 NEX0W6NtVqTgzPuvyIIIF8VrezNA7BK8+RaBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737749; x=1696342549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjxxRrsyO9RXtZgkSofP3sq4lBbxmzzvhqNdKiznt5Y=;
 b=lmSBK4qAxV+ujZLCVKWVkeVLRH0V8YWYv7pek4UH5k6U+rrS1RrnE8ABbjJ88icSte
 R1Sm3AOp4NbEi01lbU3S75vAQ4jZFCT2b+BbxorxRhVVMRaqvSwUSXCGVPwEgN7nKT6w
 Q+gAgvz+LdGpc2XuM4K9LHvoMv+Mc0TgYs1i/OO4uZRjoqpUgSYXYLvP8ZxN7e2N83g+
 wLuEGQbyMXN38g4Z3dojfJYgoWrNbIYupC2ki/8s2FbHA/NAqwy4eOt0VHw2E+B3u9xw
 aBDpAeIDn0Yk5Q1h2dQzwGatvG2yea4RVz+KhUA5n7SMJYTVCWLIB5EP/k7AkoeW0/4x
 i+QQ==
X-Gm-Message-State: AOJu0YzxbWmPWPJUxel+Lk0XoCAP/vxkY/BulUubr/NiH6e4mtfZQ4HV
 qHn2oEkcND7RK+SjKoBaQ2otxe+Y+ZMDN12K1d0=
X-Google-Smtp-Source: AGHT+IEVnvpkSP3nRM29Qnlv3H1uK4CkPnx4aFlSf5egL+WATwfGOfFyEQQD7xVaex/s0swCIFeEDQ==
X-Received: by 2002:a5d:8e19:0:b0:783:7275:9c47 with SMTP id
 e25-20020a5d8e19000000b0078372759c47mr9143043iod.7.1695737749256; 
 Tue, 26 Sep 2023 07:15:49 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 25/44] dm: core: Tidy up comments in the ofnode tests
Date: Tue, 26 Sep 2023 08:14:39 -0600
Message-ID: <20230926141514.2101787-26-sjg@chromium.org>
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

Add comments to the functions where the test name does not indicate what
is being tested. Rename functions in a few cases, so that a search for the
function will also file its test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/ofnode.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 6f21d66a95ef..3bf97761d1ee 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -91,6 +91,7 @@ void free_oftree(oftree tree)
 		free(tree.np);
 }
 
+/* test ofnode_device_is_compatible() */
 static int dm_test_ofnode_compatible(struct unit_test_state *uts)
 {
 	ofnode root_node = ofnode_path("/");
@@ -134,6 +135,7 @@ static int dm_test_ofnode_get_by_phandle(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_get_by_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test oftree_get_by_phandle() with a the 'other' oftree */
 static int dm_test_ofnode_get_by_phandle_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -188,6 +190,7 @@ static int dm_test_ofnode_by_prop_value(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_by_prop_value, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_by_prop_value() with a the 'other' oftree */
 static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -200,6 +203,7 @@ static int dm_test_ofnode_by_prop_value_ot(struct unit_test_state *uts)
 DM_TEST(dm_test_ofnode_by_prop_value_ot,
 	UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
+/* test ofnode_read_fmap_entry() */
 static int dm_test_ofnode_fmap(struct unit_test_state *uts)
 {
 	struct fmap_entry entry;
@@ -215,6 +219,7 @@ static int dm_test_ofnode_fmap(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_fmap, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_read_prop() */
 static int dm_test_ofnode_read(struct unit_test_state *uts)
 {
 	const u32 *val;
@@ -241,6 +246,7 @@ static int dm_test_ofnode_read(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_read_prop() with the 'other' tree */
 static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -260,6 +266,7 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
+/* test ofnode_count_/parse_phandle_with_args() */
 static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 {
 	struct ofnode_phandle_args args;
@@ -335,6 +342,7 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_phandle, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_count_/parse_phandle_with_args() with 'other' tree */
 static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -363,6 +371,7 @@ static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_phandle_ot, UT_TESTF_OTHER_FDT);
 
+/* test ofnode_read_chosen_string/node/prop() */
 static int dm_test_ofnode_read_chosen(struct unit_test_state *uts)
 {
 	const char *str;
@@ -392,6 +401,7 @@ static int dm_test_ofnode_read_chosen(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read_chosen, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_get_aliases_node/prop() */
 static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
 {
 	const void *val;
@@ -435,6 +445,7 @@ static int dm_test_ofnode_get_child_count(struct unit_test_state *uts)
 DM_TEST(dm_test_ofnode_get_child_count,
 	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_get_child_count() with 'other' tree */
 static int dm_test_ofnode_get_child_count_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -469,6 +480,7 @@ static int dm_test_ofnode_is_enabled(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_is_enabled, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_is_enabled() with 'other' tree */
 static int dm_test_ofnode_is_enabled_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -482,6 +494,7 @@ static int dm_test_ofnode_is_enabled_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_is_enabled_ot, UT_TESTF_OTHER_FDT);
 
+/* test ofnode_get_addr/size() */
 static int dm_test_ofnode_get_reg(struct unit_test_state *uts)
 {
 	ofnode node;
@@ -518,6 +531,7 @@ static int dm_test_ofnode_get_reg(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_get_reg, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_get_addr() with 'other' tree */
 static int dm_test_ofnode_get_reg_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -552,6 +566,7 @@ static int dm_test_ofnode_get_path(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_get_path, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_get_path() with 'other' tree */
 static int dm_test_ofnode_get_path_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -571,6 +586,7 @@ static int dm_test_ofnode_get_path_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_get_path_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
+/* test ofnode_conf_read_bool/int/str() */
 static int dm_test_ofnode_conf(struct unit_test_state *uts)
 {
 	ut_assert(!ofnode_conf_read_bool("missing"));
@@ -623,6 +639,7 @@ static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_for_each_compatible_node, UT_TESTF_SCAN_FDT);
 
+/* test dm_test_ofnode_string_count/index/list() */
 static int dm_test_ofnode_string(struct unit_test_state *uts)
 {
 	const char **val;
@@ -670,6 +687,7 @@ static int dm_test_ofnode_string(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_string, UT_TESTF_SCAN_FDT);
 
+/* test error returns from ofnode_read_string_count/index/list() */
 static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 {
 	const char **val;
@@ -719,7 +737,7 @@ static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_string_err, UT_TESTF_LIVE_TREE);
 
-static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
+static int dm_test_ofnode_read_phy_mode(struct unit_test_state *uts)
 {
 	ofnode eth_node, phy_node;
 	phy_interface_t mode;
@@ -739,7 +757,7 @@ static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_phy, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_phy_mode, UT_TESTF_SCAN_FDT);
 
 /**
  * make_ofnode_fdt() - Create an FDT for testing with ofnode
@@ -773,11 +791,11 @@ static int make_ofnode_fdt(struct unit_test_state *uts, void *fdt, int size,
 	return 0;
 }
 
-static int dm_test_ofnode_root(struct unit_test_state *uts)
+/* Check that aliases work on the control FDT */
+static int dm_test_ofnode_aliases(struct unit_test_state *uts)
 {
 	ofnode node;
 
-	/* Check that aliases work on the control FDT */
 	node = ofnode_get_aliases_node("ethernet3");
 	ut_assert(ofnode_valid(node));
 	ut_asserteq_str("sbe5", ofnode_get_name(node));
@@ -786,8 +804,15 @@ static int dm_test_ofnode_root(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_root, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_aliases, UT_TESTF_SCAN_FDT);
 
+/**
+ * dm_test_ofnode_root_mult() - Check aliaes on control and 'other' tree
+ *
+ * Check that aliases work only with the control FDT, not with 'other' tree.
+ * This is not actually the desired behaviour. If aliases are implemented for
+ * any tree, then this test should be changed.
+ */
 static int dm_test_ofnode_root_mult(struct unit_test_state *uts)
 {
 	char fdt[256];
@@ -820,6 +845,7 @@ static int dm_test_ofnode_root_mult(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_root_mult, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_set_enabled(), ofnode_write_prop() on a livetree */
 static int dm_test_ofnode_livetree_writing(struct unit_test_state *uts)
 {
 	struct udevice *dev;
@@ -909,6 +935,7 @@ static int dm_test_ofnode_write_copy(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_write_copy, UT_TESTF_SCAN_FDT);
 
+/* test writing a property to the 'other' tree */
 static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -925,6 +952,7 @@ static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
+/* test ofnode_read_u32_index/default() */
 static int dm_test_ofnode_u32(struct unit_test_state *uts)
 {
 	ofnode node;
@@ -952,6 +980,7 @@ static int dm_test_ofnode_u32(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_read_u32_array() */
 static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 {
 	ofnode node;
@@ -978,7 +1007,7 @@ static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32_array, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
-static int dm_test_ofnode_u64(struct unit_test_state *uts)
+static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
 {
 	ofnode node;
 	u64 val;
@@ -999,7 +1028,7 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_u64, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_add_subnode(struct unit_test_state *uts)
 {
@@ -1110,6 +1139,7 @@ static int dm_test_ofnode_by_compatible(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_by_compatible, UT_TESTF_SCAN_FDT);
 
+/* check ofnode_by_compatible() on the 'other' tree */
 static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
 {
 	const char *compat = "sandbox-other2";
@@ -1144,6 +1174,7 @@ static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_find_subnode, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_find_subnode() on the 'other' tree */
 static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -1257,6 +1288,7 @@ static int dm_test_ofnode_copy_props(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_copy_props, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_copy_props() with the 'other' tree */
 static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
 {
 	ofnode src, dst;
-- 
2.42.0.515.g380fc7ccd1-goog

