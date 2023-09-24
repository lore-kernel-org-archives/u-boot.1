Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E35ACE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DD986C08;
	Sun, 24 Sep 2023 21:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PLGKitUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7911786B54; Sun, 24 Sep 2023 21:26:20 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901BC86B69
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso194166539f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583569; x=1696188369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgnIlPDiutsmvXoC11Qq4sxix8x9VUnJsFOt6sQVqK4=;
 b=PLGKitUuke+UbWU721uc3p4UWdayulhD2dZj14vziLZfkmAC82nqk3Y0Aoyo4ccvpk
 ckdxJBeIQnxVo8QeMSF0hR09FpyAHTl2uF1oyhLRMlRYCFGA4SUSbCKFaXXed1UXtRXq
 n887ytm7717KngFaM3VyvALzxATbbKS0DI/4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583569; x=1696188369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgnIlPDiutsmvXoC11Qq4sxix8x9VUnJsFOt6sQVqK4=;
 b=lXfoeYyjllVgjB0dmV1qcvglBAcO63JsA37YiGPBvZkafQTThgrmMnwZtLpHu0/OMk
 HwddLQQ8nEHpJ/fEub8uW91X1eTNrUc+gMiefeJNh/JFt9AM2jjFiJX9tRR47jQeFQkT
 +BJ8tYuZ3lkG+r3qV0lI8MCXgiVfvSoPgjWKFzXu1gai9r8M5FG3lIsWGLGQPzNMRhVK
 wquhyy/On3umiT2AukAGpom9Y8JKi6aJm5jKGiGPX8hdLb2vU6JS331y9RwiuLQmjp0k
 lm6dV9twcXRBFm+oOuWtxZWL5UOy8kb03C/jsZ8TtVT+XMleqHhQaRKabfDXBhWmK9Wq
 C/1A==
X-Gm-Message-State: AOJu0YyAQrcos6xylKfhMDxhtGwvb3l84c27Sz85zAwV5klAB1nV+/Pa
 vjxSlpctuXxY1BnGxGj8RhFoYxUkIusBZjGqOpI=
X-Google-Smtp-Source: AGHT+IHloTP9VJvXTC+da0mLOieO5OJSTuNOlctl2MuKXFxaC3ON7uMRqZhQF/cH9i6lmjYhhY0veQ==
X-Received: by 2002:a5e:9243:0:b0:79a:b53c:d758 with SMTP id
 z3-20020a5e9243000000b0079ab53cd758mr5663200iop.1.1695583569216; 
 Sun, 24 Sep 2023 12:26:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 22/38] dm: core: Ensure we run flattree tests on ofnode
Date: Sun, 24 Sep 2023 13:25:07 -0600
Message-ID: <20230924192536.1812799-23-sjg@chromium.org>
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

We need the UT_TESTF_SCAN_FDT flag set for these tests to run with flat
tree. In some cases it is missing, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/ofnode.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index dee71ee5e545..6f21d66a95ef 100644
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
 
 static int dm_test_ofnode_options(struct unit_test_state *uts)
 {
@@ -665,7 +668,7 @@ static int dm_test_ofnode_string(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_string, 0);
+DM_TEST(dm_test_ofnode_string, UT_TESTF_SCAN_FDT);
 
 static int dm_test_ofnode_string_err(struct unit_test_state *uts)
 {
@@ -736,7 +739,7 @@ static int dm_test_ofnode_get_phy(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_get_phy, 0);
+DM_TEST(dm_test_ofnode_get_phy, UT_TESTF_SCAN_FDT);
 
 /**
  * make_ofnode_fdt() - Create an FDT for testing with ofnode
@@ -920,7 +923,7 @@ static int dm_test_ofnode_write_copy_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_write_copy_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_u32(struct unit_test_state *uts)
 {
@@ -1122,7 +1125,7 @@ static int dm_test_ofnode_by_compatible_ot(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_ofnode_by_compatible_ot, UT_TESTF_OTHER_FDT);
+DM_TEST(dm_test_ofnode_by_compatible_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
 
 static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 {
@@ -1291,7 +1294,7 @@ static int dm_test_livetree_align(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_align, UT_TESTF_LIVE_TREE);
+DM_TEST(dm_test_livetree_align, UT_TESTF_SCAN_FDT | UT_TESTF_LIVE_TREE);
 
 /* check that it is possible to load an arbitrary livetree */
 static int dm_test_livetree_ensure(struct unit_test_state *uts)
@@ -1310,4 +1313,4 @@ static int dm_test_livetree_ensure(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_livetree_ensure, 0);
+DM_TEST(dm_test_livetree_ensure, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

