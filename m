Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B669C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23878654C;
	Wed, 30 Aug 2023 20:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Thb8EBeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E208652C; Wed, 30 Aug 2023 20:06:11 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AD48652E
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34ccedcc584so3049355ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418752; x=1694023552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEcf8TtzSh+AXpNfczl31JjeZV6zEbpxlP3LwZnpSZU=;
 b=Thb8EBeh14OoqEFNe1tmPOQowOR642r1rO2ReI9i/wkEiEhav8sCVykdrnEXf9qFkB
 mOnmetpAoHp7moNieePOff+HX1rsXfEJUfE7IJjvpQdMwR89JUFcbeJcbkLUyr0Wc4h9
 gnUJMQIy7Fzhorr2qcim8FikuPJDZkkmIUzig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418752; x=1694023552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEcf8TtzSh+AXpNfczl31JjeZV6zEbpxlP3LwZnpSZU=;
 b=R+Ii+LnjChHTl6SsuJMmruKLYj/FdbQ/Bj9Zd0wVoq7DovdY2vqe77uYPeGWzSbPjN
 GT0iBWWgJyr+eOo9t+CHWEXoG3xsdBC9Mrvc9uaEm9gAzupPVPv3usx8DagMH67NAcOZ
 KmujHaCVx878Smwc2ipBDjsPpJTYuBLOEdjURPij3WerKMPqbBw0FxtfKKT9U2gGdnwz
 jxIQ+uLTo3mhChR6gW2DHyKqFENac3Np5FCO3WTzb6kEc1Hd/uPXxrQUn61DEoXmV1mE
 Sex5or8+Ae1XtNImyyMO2p/aiKurYlfUIHheQke//xY+KS8UbRE7y2eA56WCL/SIbJWg
 JtQQ==
X-Gm-Message-State: AOJu0Ywzt4hD48mIRL3Aji5r122eWYbRxckC8zw2Gyctp6qkE/VBqEON
 0OcNndDdETAr1JjvJs6gWP9wIQXKKX0jEE5oJUc=
X-Google-Smtp-Source: AGHT+IHqOUatawyqSVPh8sucIpG3/ao5f2sv/ztj2R69OAAkAeb9p2T3jQtLGamfvob1WGbg0iavyQ==
X-Received: by 2002:a05:6e02:1e09:b0:34c:b4b5:765 with SMTP id
 g9-20020a056e021e0900b0034cb4b50765mr355003ila.5.1693418752540; 
 Wed, 30 Aug 2023 11:05:52 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 17/32] dm: core: Tidy up comments in the ofnode tests
Date: Wed, 30 Aug 2023 12:04:48 -0600
Message-ID: <20230830180524.315916-18-sjg@chromium.org>
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

Add comments to the functions where the test name does not indicate what
is being tested. Rename functions in a few cases, so that a search for the
function will also file its test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/dm/ofnode.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index a29c9aae870..84ed7f92b23 100644
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
@@ -604,6 +620,7 @@ static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_for_each_compatible_node, UT_TESTF_SCAN_FDT);
 
+/* test dm_test_ofnode_string_count/index/list() */
 static int dm_test_ofnode_string(struct unit_test_state *uts)
 {
 	const char **val;
@@ -651,6 +668,7 @@ static int dm_test_ofnode_string(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_string, UT_TESTF_SCAN_FDT);
 
+/* test error returns from ofnode_read_string_count/index/list() */
 static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 {
 	const char **val;
@@ -700,7 +718,7 @@ static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_string_err, UT_TESTF_LIVE_TREE);
 
-static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
+static int dm_test_ofnode_read_phy_mode(struct unit_test_state *uts)
 {
 	ofnode eth_node, phy_node;
 	phy_interface_t mode;
@@ -720,7 +738,7 @@ static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_phy, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_phy_mode, UT_TESTF_SCAN_FDT);
 
 /**
  * make_ofnode_fdt() - Create an FDT for testing with ofnode
@@ -754,11 +772,11 @@ static int make_ofnode_fdt(struct unit_test_state *uts, void *fdt, int size,
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
@@ -767,8 +785,15 @@ static int dm_test_ofnode_root(struct unit_test_state *uts)
 
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
@@ -801,6 +826,7 @@ static int dm_test_ofnode_root_mult(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_root_mult, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_set_enabled(), ofnode_write_prop() on a livetree */
 static int dm_test_ofnode_livetree_writing(struct unit_test_state *uts)
 {
 	struct udevice *dev;
@@ -890,6 +916,7 @@ static int dm_test_ofnode_write_copy(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_write_copy, UT_TESTF_SCAN_FDT);
 
+/* test writing a property to the 'other' tree */
 static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -906,6 +933,7 @@ static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
+/* test ofnode_read_u32_index/default() */
 static int dm_test_ofnode_u32(struct unit_test_state *uts)
 {
 	ofnode node;
@@ -933,6 +961,7 @@ static int dm_test_ofnode_u32(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
+/* test ofnode_read_u32_array() */
 static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 {
 	ofnode node;
@@ -959,7 +988,7 @@ static int dm_test_ofnode_u32_array(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_u32_array, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
-static int dm_test_ofnode_u64(struct unit_test_state *uts)
+static int dm_test_ofnode_read_u64(struct unit_test_state *uts)
 {
 	ofnode node;
 	u64 val;
@@ -980,7 +1009,7 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
+DM_TEST(dm_test_ofnode_read_u64, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_add_subnode(struct unit_test_state *uts)
 {
@@ -1091,6 +1120,7 @@ static int dm_test_ofnode_by_compatible(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_by_compatible, UT_TESTF_SCAN_FDT);
 
+/* check ofnode_by_compatible() on the 'other' tree */
 static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
 {
 	const char *compat = "sandbox-other2";
@@ -1125,6 +1155,7 @@ static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_find_subnode, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_find_subnode() on the 'other' tree */
 static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
@@ -1238,6 +1269,7 @@ static int dm_test_ofnode_copy_props(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_copy_props, UT_TESTF_SCAN_FDT);
 
+/* test ofnode_copy_props() with the 'other' tree */
 static int dm_test_ofnode_copy_props_ot(struct unit_test_state *uts)
 {
 	ofnode src, dst;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

