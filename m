Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E8CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DD986C16;
	Sun, 24 Sep 2023 21:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KejvL/PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB53986C02; Sun, 24 Sep 2023 21:26:21 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FEE86B03
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79fa4ff8220so121474439f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583570; x=1696188370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjxxRrsyO9RXtZgkSofP3sq4lBbxmzzvhqNdKiznt5Y=;
 b=KejvL/PJQ4si9ENXllZO7Z4OChNTQzEHY3tlgvLJFz8/Xpp4aQkG+LsKx9X7H6Ddpk
 anRnZ729RQMjbI1BH59Vf4//wN+7il2gVn03zkmLErEn0fadrE4SkSr6249nfKg/PYOG
 HMDqd3SQss0+5P6sIL+AkX4xAwXAuMTCWvanw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583570; x=1696188370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjxxRrsyO9RXtZgkSofP3sq4lBbxmzzvhqNdKiznt5Y=;
 b=VMa2tEzTleF8d+RIN6Pj1lRUF0RYp/RxLfaF1L4xJe9OCJ5ExS30G5d1pT5B5lRnPe
 i0yJsG5Heky8iUmc4Y6jx6V4UtGleEwodz69sgKSbAK6c+KQfVp5ou/yKfOyOAfGqufx
 92dRJRpYg9PDcd4ghl43q7K3QPVa6GvBR6sN7cPSYOBJJ0T3Oh3Pm11IZanLfk74FPv1
 mMWdarwq6vsQ4NFtrFcx8W0tNQ+sw2f9oA1FnWbp9GO2ZcalO+2ZHOAavPbJZ1l8Y4z/
 ypchIp4aGw0134Hn4Sno9oRJ3jKZxyshNn1LHqfm/Ni7ei8wYaLapff744XBrfjKWa6L
 AFIg==
X-Gm-Message-State: AOJu0YxOz/Rb3GJp5C2+y1QGvJUTJSZIvM2GGVfgflkSlBW2+qZARg5/
 glxJnTnfzqUBfZ5neTV6oMA4+mSXYR/8n/aPfco=
X-Google-Smtp-Source: AGHT+IH1N15ZXgUOXq8YbDPG2K3s/Hi5qjimo/gkI0McAvOxUVzv/jCPSePlSKlnrYyCiFhHlzp/Ug==
X-Received: by 2002:a6b:6614:0:b0:780:d031:bc42 with SMTP id
 a20-20020a6b6614000000b00780d031bc42mr6974941ioc.16.1695583570020; 
 Sun, 24 Sep 2023 12:26:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 23/38] dm: core: Tidy up comments in the ofnode tests
Date: Sun, 24 Sep 2023 13:25:08 -0600
Message-ID: <20230924192536.1812799-24-sjg@chromium.org>
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

