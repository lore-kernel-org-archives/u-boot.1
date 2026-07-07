Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2764DC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 20:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3430C84979;
	Tue,  7 Jul 2026 22:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cn0ImeDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354E18497A; Tue,  7 Jul 2026 22:57:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133BD848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 22:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso44679805e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783457869; x=1784062669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=av7Pfhh+bunkacy31WYDlHSEFapmsJhKVn3S/5rb00E=;
 b=cn0ImeDSgofr83Co+phHROCyLHjIuoP1/Ut9SWeKTwm2SeoF1U9dyoech0fX0Sh4sN
 sIDv34jDQB0KlJ4PWCjy0Wa0gS333BmZ1Nj6DXFy40pxysxviwT3LL82iRv7LXNHGO68
 dLIEy0CtAEE0VbhR6UdEJpUvx7umMb/ZfJe1WL2rrAIEln2HcdKu7zLOrX/rpStTSGSY
 iUkwvhUm9qXQl4Bj+LSJsZ1BrwFD1r+bSJ57AYNfL0p+jqcHGRmTefdHhOgafAiWk0sD
 aio/x/AwV+0MyxuqjY3xqOIvblDdIL+pLPElaGHauxx9V5nTMegiWIbOLrb6RHJfgsQv
 MU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457869; x=1784062669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=av7Pfhh+bunkacy31WYDlHSEFapmsJhKVn3S/5rb00E=;
 b=FDEBlb/VWzaXh8aDtHbLVAJYnpjVWPFQKujKwUPfkB9WGU66Kx+En/tQPfQSDbRexl
 CUd59/5mJjQWQPVNveEiWB2cqxcBnf+Gz/gyI/Ergoxje8sz9G7UyGlXFBWtcIZx5Wlc
 ZlyB+Nq5bSUyBp4vqx9ldCad7Dko3El/31XjMUOkmTZDW71StHkhcXhvZGR1As6hfbiN
 NO2fB/4LfMd9MFIymeQ410jU41wPpwglB2fgcd1whNYnCPqkq3J43PkeFzXnB1/+0huG
 3u0+q7I9MQwlxHiwVau0J2NOxJhbGCAusA9suwIuCoxK/tXyckNw+5/ZpPtyyB421tDB
 sqYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6ZLB0XkswGP5qVOnz2zn4KJLzGJEhygozoXs3Oyk70AUOWftQ7KiSOLyzfVEBDaNHe0PbjMA=@lists.denx.de
X-Gm-Message-State: AOJu0YzK0eGV+JA/YOniUjg7wDRzPWryEEgvEyogcSglUeKX0/Z/v6yE
 8XY8TE0SLsJy8hOmtN6hMsrFH8GQ+NsoFbcnL9Ss+TtRwTWBj1eV5yhFrnjolZ2DUkjdH1jIvp8
 D+Pmd35kk8iiV
X-Gm-Gg: AfdE7ck7bj45tNyUey22QdQh8KlHbdrd36T2lb1+hs/E5pwP0BY1ibB8WKhT0Nmh2la
 znPs2+gE4TyG5NNe/tmf+2tag/tVTf6ekFqp36ICy35AZ8uF1ooPlasmShZxCtcNHSvUEvgNnyp
 eZ3THUhx0/ds2IlvolqQEXZCcpeq5wRqgrLH3ei1/pLuOeA7Mwu7DgtwSPbBPCKqIHU3GVhD0SK
 +OBhObwzFzxnhJ67FUHgtlvoGKjCC1s6MSCiYjMlUfG64xWjhAM/m0AKD7sla77sEzZ2Ai+EUN7
 5mK31a/ZGV2m2tgAnjlpMKlJm7clmJ3XdcvHcLAOzcHEoS+rt3wfkH+uK6p/wwfZkW1Xndg6Yrx
 eh7Skq0uVvfeTHVN0DFPgCXSRZkTo6BV3tAlBohKAnME4nklheKNbnw2T3T0Ne3gNLGfc6CT912
 FB5B12XVaaa1WdFGVmeLc9SmE=
X-Received: by 2002:a05:600c:310f:b0:493:cc25:85cb with SMTP id
 5b1f17b1804b1-493df082ffamr73438345e9.8.1783457869292; 
 Tue, 07 Jul 2026 13:57:49 -0700 (PDT)
Received: from macbook ([95.236.170.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm36094303f8f.20.2026.07.07.13.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 13:57:48 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
To: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, dlechner@baylibre.com, jstephan@baylibre.com
Cc: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH] fit: prefer the default configuration on best-match ties
Date: Tue,  7 Jul 2026 22:54:11 +0200
Message-ID: <20260707205611.65287-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.55.0
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

With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
configuration matching the most specific U-Boot compatible string; on
equal matches the first listed configuration wins and the configurations
node 'default' property is never consulted.

A FIT whose configurations all share the same base devicetree compatible
(e.g. one manifest carrying a base tree plus overlay combinations for a
single board) therefore always boots the first configuration, silently
ignoring the default chosen by the manifest author.

Break score ties in favour of the default configuration. A strictly
better compatible match still wins over it, and FITs without a default
keep the current first-listed behaviour.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/Kconfig      |  2 ++
 boot/image-fit.c  | 20 ++++++++++++--
 include/image.h   |  4 +++
 test/boot/image.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c56176..c67dc0ba493 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -191,6 +191,8 @@ config FIT_BEST_MATCH
 	  U-Boot itself. A match is considered "best" if it matches the
 	  most specific compatibility entry of U-Boot's fdt's root node.
 	  The order of entries in the configuration's fdt is ignored.
+	  If several configurations match equally well, the one named by
+	  the configurations node 'default' property is preferred.
 
 config FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by U-Boot"
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 044a40e1910..ef90c5abd18 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1799,6 +1799,8 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 	int fdt_compat_len;
 	int best_match_offset = 0;
 	int best_match_pos = 0;
+	const char *default_name;
+	int default_noffset = -1;
 
 	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
 	images_noffset = fdt_path_offset(fit, FIT_IMAGES_PATH);
@@ -1813,6 +1815,15 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 		return -ENXIO;
 	}
 
+	/* the default configuration breaks ties between equal matches */
+	default_name = fdt_getprop(fit, confs_noffset, FIT_DEFAULT_PROP, NULL);
+	if (default_name) {
+		default_noffset = fdt_subnode_offset(fit, confs_noffset,
+						     default_name);
+		if (default_noffset < 0)
+			default_noffset = -1;
+	}
+
 	/*
 	 * Loop over the configurations in the FIT image.
 	 */
@@ -1863,10 +1874,15 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 		cur_fdt_compat = fdt_compat;
 		/*
 		 * Look for a match for each U-Boot compatibility string in
-		 * turn in the compat string property.
+		 * turn in the compat string property. A configuration only
+		 * replaces the current best match on a strictly better
+		 * position, or on an equal position if it is the default
+		 * configuration.
 		 */
 		for (i = 0; len > 0 &&
-		     (!best_match_offset || best_match_pos > i); i++) {
+		     (!best_match_offset || best_match_pos > i ||
+		      (best_match_pos == i && noffset == default_noffset));
+		     i++) {
 			int cur_len = strlen(cur_fdt_compat) + 1;
 
 			if (!fdt_node_check_compatible(fdt, compat_noffset,
diff --git a/include/image.h b/include/image.h
index 9c8a746d576..01a814ed76e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1526,6 +1526,10 @@ int fit_check_format(const void *fit, ulong size);
  * compatible list, "foo,bar", matches a compatible string in the root of fdt1.
  * "bim,bam" in fdt2 matches the second string which isn't as good as fdt1.
  *
+ * If several configurations match at the same position, the one named by the
+ * 'default' property of the configurations node is preferred, then the first
+ * one listed.
+ *
  * As an optimization, the compatible property from the FDT's root node can be
  * copied into the configuration node in the FIT image. This is required to
  * match configurations with compressed FDTs.
diff --git a/test/boot/image.c b/test/boot/image.c
index 4df7b17ce88..2c6d9dcbc22 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -8,8 +8,76 @@
 
 #include <image.h>
 #include <test/ut.h>
+#include <linux/libfdt.h>
 #include "bootstd_common.h"
 
+/* Test that the default configuration breaks best-match ties */
+static int test_fit_conf_find_compat(struct unit_test_state *uts)
+{
+	char fdt[256], fit[1024];
+	int confs, images, node;
+	int ret;
+
+	/* control devicetree with a two-entry compatible list */
+	ut_assertok(fdt_create_empty_tree(fdt, sizeof(fdt)));
+	ut_assertok(fdt_appendprop_string(fdt, 0, "compatible",
+					  "test,board-a"));
+	ut_assertok(fdt_appendprop_string(fdt, 0, "compatible",
+					  "test,fallback"));
+
+	/* FIT with two configurations matching the same compatible */
+	ut_assertok(fdt_create_empty_tree(fit, sizeof(fit)));
+	images = fdt_add_subnode(fit, 0, "images");
+	ut_assert(images >= 0);
+	confs = fdt_add_subnode(fit, 0, "configurations");
+	ut_assert(confs >= 0);
+	ut_assertok(fdt_setprop_string(fit, confs, FIT_DEFAULT_PROP, "conf-2"));
+	/*
+	 * fdt_add_subnode() inserts before existing subnodes: create conf-2
+	 * first so that conf-1 ends up listed first, like an .its compiled
+	 * with the configurations in that order
+	 */
+	node = fdt_add_subnode(fit, confs, "conf-2");
+	ut_assert(node >= 0);
+	ut_assertok(fdt_setprop_string(fit, node, "compatible",
+				       "test,board-a"));
+	node = fdt_add_subnode(fit, confs, "conf-1");
+	ut_assert(node >= 0);
+	ut_assertok(fdt_setprop_string(fit, node, "compatible",
+				       "test,board-a"));
+	confs = fdt_path_offset(fit, "/configurations");
+	node = fdt_first_subnode(fit, confs);
+	ut_asserteq_str("conf-1", fdt_get_name(fit, node, NULL));
+
+	/* on a tie, the default configuration wins */
+	ret = fit_conf_find_compat(fit, fdt);
+	ut_assert(ret > 0);
+	ut_asserteq_str("conf-2", fdt_get_name(fit, ret, NULL));
+
+	/* without a default, the first listed configuration wins */
+	confs = fdt_path_offset(fit, "/configurations");
+	ut_assertok(fdt_delprop(fit, confs, FIT_DEFAULT_PROP));
+	confs = fdt_path_offset(fit, "/configurations");
+	ut_assertnull((void *)fdt_getprop(fit, confs, FIT_DEFAULT_PROP, NULL));
+	ret = fit_conf_find_compat(fit, fdt);
+	ut_assert(ret > 0);
+	ut_asserteq_str("conf-1", fdt_get_name(fit, ret, NULL));
+
+	/* a strictly better match still beats the default */
+	confs = fdt_path_offset(fit, "/configurations");
+	ut_assertok(fdt_setprop_string(fit, confs, FIT_DEFAULT_PROP, "conf-2"));
+	confs = fdt_path_offset(fit, "/configurations");
+	node = fdt_subnode_offset(fit, confs, "conf-2");
+	ut_assertok(fdt_setprop_string(fit, node, "compatible",
+				       "test,fallback"));
+	ret = fit_conf_find_compat(fit, fdt);
+	ut_assert(ret > 0);
+	ut_asserteq_str("conf-1", fdt_get_name(fit, ret, NULL));
+
+	return 0;
+}
+BOOTSTD_TEST(test_fit_conf_find_compat, 0);
+
 /* Test of image phase */
 static int test_image_phase(struct unit_test_state *uts)
 {
-- 
2.55.0

