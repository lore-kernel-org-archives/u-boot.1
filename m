Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71499C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB0D82CAE;
	Fri,  2 May 2025 16:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ibZpyhln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E5682CC9; Fri,  2 May 2025 16:49:27 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A22D82CB5
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so218648139f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197363; x=1746802163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGurDDfv02MOI+s2IQxHOCZo7zBcgZNNQyZQrOeo5ZY=;
 b=ibZpyhlnhzfBTyN0iNJKbVvVhLv/7u1oj/qog5O6wXsbo8tcPraaHgKL0QfK7heScI
 mMyH3VOlHa/W9rzYn/WFL0tEhKvi0UYlw9Q+ZQ7GN70jiXuQifLGKXtx2LUrqN0U7sxz
 fhE5ZMtte/Cx+wOM44BdXdJ+RMXE9zVKytfWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197363; x=1746802163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGurDDfv02MOI+s2IQxHOCZo7zBcgZNNQyZQrOeo5ZY=;
 b=CiyOglIk4vkUc0Jz29tZZf4EjOJTrR3YDVqUKRuxwgvAmMCAuk70dEDJpC/u221MGx
 8d/14w8aPabe0r5DR/HaaIOX7LPJl421d86nSQxvGOvOwcnd5eVKfVzv8CdlZ4nIp84H
 9+GaBE4bHPneHfgDXOfrY5Ge7IOEdKi0kHMES0TylK3YKzrCqEPIXXrLqQbOKNhWOtQ7
 hhsB7I0dFPAnzLQmrfLjerc/YttAuJ962S3pcaMbGioKOeNc5Rrn18KsXXJLT4sKy4hI
 50iNvo2qaznbsMX5VqcwyOFbnGGAM0/MgAYs9iM+6JsEn3hMaslbxADz6k45ZDqd7yXZ
 sRWQ==
X-Gm-Message-State: AOJu0YzDDwpPRnVLETOkPJ1cCNF+k05+UDlSkwXb9oqXWM1x7tJcBxa4
 Fj/E9eEQWRMRUahc6Z4rzB6XJijjy2zt6/p07sXnvH5NSokI/HiTKs1qH0K/IQZcXsho00+5zxg
 =
X-Gm-Gg: ASbGncucupYBBANz7iHDJIeAtC5N00OqexWY08d055FASuzrugqAkizpI2HFL3K8K8j
 LkRVpDEGx8J5wTIWAJcOaZxDsIVyfvgNV8zV4E8LGX9nIBO/jDPWW6MjTKmstbygHSo8lQ7rs/g
 2XPj999D/3EeRLmOG/ds4c9nXouxZBhLT8oRViAaJQZ4EDqyTFR7gWOujZqje1ErOH0huKN9lLm
 55oRI4mgwkzQCQ/nmD4Gpr2+Zc+YZhzT32XQOBXTn0ac4KhKbKSQOpSP2EFAH8IllxYiLP2rfGw
 f3GpKiLPelqQ2JlEeHR4RHX37C+z/8R2JBchWnJ2MlRYPe24IUSInl+De/qIDM8iNFO5j51Sgju
 KFg==
X-Google-Smtp-Source: AGHT+IExVqROh2up57raPdZCda9hhHfqerWOBdB6WZPppbG6si896f525LlqQIvqUj6mJwJxZXwIYw==
X-Received: by 2002:a05:6602:3f08:b0:864:488e:a581 with SMTP id
 ca18e2360f4ac-866b2d7bd95mr440628639f.4.1746197363347; 
 Fri, 02 May 2025 07:49:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 60/60] expo: Drop the special theme code for bootflow_menu
Date: Fri,  2 May 2025 08:46:58 -0600
Message-ID: <20250502144718.313633-61-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

The expo now has all that is needed to apply a suitable theme, so drop
this unnecessary code. Any further tweaks can be added to the generic
expo code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 43 -------------------------------------------
 test/boot/bootflow.c |  6 +++---
 2 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 43f074f19f5..4a442e16850 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -215,43 +215,6 @@ int bootflow_menu_add_all(struct expo *exp)
 	return 0;
 }
 
-int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
-{
-	struct menu_priv *priv = exp->priv;
-	struct scene *scn;
-	u32 font_size;
-	int ret;
-
-	log_debug("Applying theme %s\n", ofnode_get_name(node));
-	scn = expo_lookup_scene_id(exp, MAIN);
-	if (!scn)
-		return log_msg_ret("scn", -ENOENT);
-
-	/* Avoid error-checking optional items */
-	if (!ofnode_read_u32(node, "font-size", &font_size)) {
-		int i;
-
-		log_debug("font size %d\n", font_size);
-		scene_txt_set_font(scn, OBJ_PROMPT1A, NULL, font_size);
-		scene_txt_set_font(scn, OBJ_POINTER, NULL, font_size);
-		for (i = 0; i < priv->num_bootflows; i++) {
-			ret = scene_txt_set_font(scn, ITEM_DESC + i, NULL,
-						 font_size);
-			if (ret)
-				return log_msg_ret("des", ret);
-			scene_txt_set_font(scn, ITEM_KEY + i, NULL, font_size);
-			scene_txt_set_font(scn, ITEM_LABEL + i, NULL,
-					   font_size);
-		}
-	}
-
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
-
-	return 0;
-}
-
 int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
@@ -263,12 +226,6 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 	if (ret)
 		return log_msg_ret("bmn", ret);
 
-	if (ofnode_valid(std->theme)) {
-		ret = bootflow_menu_apply_theme(exp, std->theme);
-		if (ret)
-			return log_msg_ret("thm", ret);
-	}
-
 	/* For now we only support a video console */
 	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
 	if (ret)
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 06fd2dbb20a..670e73c265b 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -884,7 +884,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	ut_assertok(bootflow_menu_add_all(exp));
 	node = ofnode_path("/bootstd/theme");
 	ut_assert(ofnode_valid(node));
-	ut_assertok(bootflow_menu_apply_theme(exp, node));
+	ut_assertok(expo_apply_theme(exp, node));
 
 	scn = expo_lookup_scene_id(exp, MAIN);
 	ut_assertnonnull(scn);
@@ -895,8 +895,8 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	 *
 	 * Check both menu items, since there are two bootflows
 	 */
-	ut_assertok(check_font(uts, scn, OBJ_PROMPT1A, font_size));
-	ut_assertok(check_font(uts, scn, OBJ_POINTER, font_size));
+	for (i = OBJ_PROMPT1A; i <= OBJ_AUTOBOOT; i++)
+		ut_assertok(check_font(uts, scn, i, font_size));
 	for (i = 0; i < 2; i++) {
 		ut_assertok(check_font(uts, scn, ITEM_DESC + i, font_size));
 		ut_assertok(check_font(uts, scn, ITEM_KEY + i, font_size));
-- 
2.43.0

