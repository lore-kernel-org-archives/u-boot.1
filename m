Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F32C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13582869AB;
	Tue, 15 Aug 2023 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEJj+a7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9DF869AE; Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9F0869A6
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79095499a16so181231039f.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052880; x=1692657680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpWYNKpcbxUDlE6vwbuowlMpWfjHE81Ana1RDmEw8TI=;
 b=BEJj+a7PMmfaH9XTvYsrS2iu2GpTdjaLs2wLwUSRCjHK/RFKnQVjVlTHEam8Gsq8RW
 9y+ayYdpDCLEgZc7LuDI+6Kd08pVcCB7VfmljJ6tx7o5Y1C5y03HSHR4Ssgiq99O3h2V
 u5stt4xJ7hBoYxBvYW5yRUC4Fku421cOroUrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052880; x=1692657680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpWYNKpcbxUDlE6vwbuowlMpWfjHE81Ana1RDmEw8TI=;
 b=TcrQbL05CMKKMMfLQ9CuXEpohf5uqjTfnCIYuenef3A+rITyJG42lt8qfkDiwrg/KJ
 wWCuK1xGnMqvLtAdw59QgZpQPMrfgB1xeTfoV4Xfz+UUFmafnwyEqWrBlB8iSM6jArju
 ESnIsyo9QZnZOaynbx7KS7kxJBNsEsfO/nuVVhbmTuEiHcfzxrlSEfmGgmwxdRTyJYzU
 PBN9G46RL56ewR2nLF4brHxWqh6c3vysdb7HY69YhE2uH43dFa72U8h3Edo00EWsboCS
 oWl7TrviQA0rELgmsrB4itYZM0i2iDH0t+aMrgLhaNTwbS9HOlcd0r8Vpfgvaku0QKU7
 SmAw==
X-Gm-Message-State: AOJu0YzfcSCgjVs6NuoQ9IHz5QWVshXi5XYEftcPQgvcDtxn/onzZE++
 GQYvJDZnXuSMIm6WUcun0EQxtTkHh2Uj7QRPB3E=
X-Google-Smtp-Source: AGHT+IFjD+vk5kvf5CaOcmsrvKCY8pHQ0UWKhC+Y4J9wI8tVw5sP+EH+PvX/7tAWkn0mbmvzs8UtsQ==
X-Received: by 2002:a92:c249:0:b0:347:7399:e9c1 with SMTP id
 k9-20020a92c249000000b003477399e9c1mr16883256ilo.14.1692052880647; 
 Mon, 14 Aug 2023 15:41:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/19] expo: Move cedit test into its own file and tidy
Date: Mon, 14 Aug 2023 16:40:26 -0600
Message-ID: <20230814224047.535491-7-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Move this test out so it can have its own file. Rename the test to use
a cedit_ prefix.

This allows us to drop the check for CONFIG_CMD_CEDIT in the test.

Also we don't need driver model objects for this test, so drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/Makefile |  1 +
 test/boot/cedit.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 test/boot/expo.c   | 43 -------------------------------------
 3 files changed, 54 insertions(+), 43 deletions(-)
 create mode 100644 test/boot/cedit.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 22ed61c8fa02..52947580ae60 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
 obj-$(CONFIG_FIT) += image.o
 
 obj-$(CONFIG_EXPO) += expo.o
+obj-$(CONFIG_CEDIT) += cedit.o
 
 ifdef CONFIG_OF_LIVE
 obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
new file mode 100644
index 000000000000..f3411f734fa2
--- /dev/null
+++ b/test/boot/cedit.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
+#include <cedit.h>
+#include <expo.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+#include <test/cedit-test.h>
+#include "../../boot/scene_internal.h"
+
+/* Check the cedit command */
+static int cedit_base(struct unit_test_state *uts)
+{
+	extern struct expo *cur_exp;
+	struct scene_obj_menu *menu;
+	struct scene_obj_txt *txt;
+	struct expo *exp;
+	struct scene *scn;
+
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	console_record_reset_enable();
+
+	/*
+	 * ^N  Move down to second menu
+	 * ^M  Open menu
+	 * ^N  Move down to second item
+	 * ^M  Select item
+	 * \e  Quit
+	 */
+	console_in_puts("\x0e\x0d\x0e\x0d\e");
+	ut_assertok(run_command("cedit run", 0));
+
+	exp = cur_exp;
+	scn = expo_lookup_scene_id(exp, exp->scene_id);
+	ut_assertnonnull(scn);
+
+	menu = scene_obj_find(scn, scn->highlight_id, SCENEOBJT_NONE);
+	ut_assertnonnull(menu);
+
+	txt = scene_obj_find(scn, menu->title_id, SCENEOBJT_NONE);
+	ut_assertnonnull(txt);
+	ut_asserteq_str("AC Power", expo_get_str(exp, txt->str_id));
+
+	ut_asserteq(ID_AC_ON, menu->cur_item_id);
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_base, 0);
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 458e332440c3..90027409c817 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -714,46 +714,3 @@ static int expo_test_build(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_test_build, UT_TESTF_DM);
-
-/* Check the cedit command */
-static int expo_cedit(struct unit_test_state *uts)
-{
-	extern struct expo *cur_exp;
-	struct scene_obj_menu *menu;
-	struct scene_obj_txt *txt;
-	struct expo *exp;
-	struct scene *scn;
-
-	if (!IS_ENABLED(CONFIG_CMD_CEDIT))
-		return -EAGAIN;
-
-	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
-
-	console_record_reset_enable();
-
-	/*
-	 * ^N  Move down to second menu
-	 * ^M  Open menu
-	 * ^N  Move down to second item
-	 * ^M  Select item
-	 * \e  Quit
-	 */
-	console_in_puts("\x0e\x0d\x0e\x0d\e");
-	ut_assertok(run_command("cedit run", 0));
-
-	exp = cur_exp;
-	scn = expo_lookup_scene_id(exp, exp->scene_id);
-	ut_assertnonnull(scn);
-
-	menu = scene_obj_find(scn, scn->highlight_id, SCENEOBJT_NONE);
-	ut_assertnonnull(menu);
-
-	txt = scene_obj_find(scn, menu->title_id, SCENEOBJT_NONE);
-	ut_assertnonnull(txt);
-	ut_asserteq_str("AC Power", expo_get_str(exp, txt->str_id));
-
-	ut_asserteq(ID_AC_ON, menu->cur_item_id);
-
-	return 0;
-}
-BOOTSTD_TEST(expo_cedit, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
-- 
2.41.0.694.ge786442a9b-goog

