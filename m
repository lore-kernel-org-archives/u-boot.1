Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD2C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A98D8281E;
	Fri, 28 Mar 2025 14:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JBgRAgnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E4E82849; Fri, 28 Mar 2025 14:09:07 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4BE8272A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d445a722b9so9256885ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167343; x=1743772143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2TaNZlIZIi0NmRyPxDEBstmr8zCiV10e6t3B3xXrSM=;
 b=JBgRAgnP0+g6DpmDzW14HIarRilVv0rE+2v5nqq0tBkE/7+qbnuYIkcEEQKhEl+mXw
 wzlj9JDS4XIPZgm/kRBfISvTUe2LEnh3pt/sb99LM2CGmzWmtSiszO3ehA5QmsT5ho+m
 ujL+Qga0K9qksPaKGD9utWuJGmFD0YZRot45o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167343; x=1743772143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2TaNZlIZIi0NmRyPxDEBstmr8zCiV10e6t3B3xXrSM=;
 b=kY3WHzzxCh8vlQys6l+aDs07bBLxdYjYhh6Vo9JesqrglKkPv2abERK+quRCl6a2wK
 MFCEiCn5B1mhcwoiw9+q23DaGhd6cjb+29/g22kyBqk+ovQlJ410UYXmsU6ghVpLBoPz
 52uLHZgD7ZTSo5hmieoN8itGo/icOZdNjRkYA+sn7qyhk8PTBhT8R9IquQdt9/E7CQ/H
 K2kLSIozEU5ip4eJ4DJ7r27kJAz/4heievSiPjSWiJhNESZe7BjNX2jFdLEc5+rpAFzd
 Q8Gb2K5uffLoDUTZGk7aXxl2C9dM1a6g4uDxzDvckYTezrb7qkikA/ej9q7ZHMZc7iRE
 BJnA==
X-Gm-Message-State: AOJu0YxyuiSltFDMT12dMfDUmZJYiIj4WwqJIV+PaWH/wG0KwgA7ms0n
 liMP7MHbmXxylllPV6t1ozKMud4MyDq7l4o4cl1MXWToZLfX1Vv3IFHbxBQCb7Cxj+4b6KHGB50
 =
X-Gm-Gg: ASbGnctmE2SZVx8KjPQHMXD6rUZHIbr0zu7MooHHcYtsoDuHeAkAWFr76+7J288nhbh
 T5wLqtQ6CzWpuyEShYdRAF//IKBAu06uX2+fJlL9LSH0kZqsF+wq7EdzD9msy9f9FhsoWmVCk5P
 L68/e3CLUfoKv7g5bWRyO1ezDm5BKo8gIFuVafEsxGvdd/gEop8lYL8APuDEH48VG9VpEQpc0CH
 MyOeGHGbQs4wUMccKmj8i/g/i79e7eusf5rtPjdjmNoMoNrx8yBU1jaq0R3T9g9m/TEhVk291A6
 ++Ov9bi5cp9fHRrTTIhKESx1H1zu+61eOYyaTB3G2Xt15Yhe1nDJGd/Wa5fouOA0g7o6E/0wXsY
 LJoFE7A==
X-Google-Smtp-Source: AGHT+IF/eje3yEymSahOOEi5U1F6344xxAAFZRgWazIIKtFzYkVLCmAplORmgQZpegX8QRNkYfi9ig==
X-Received: by 2002:a05:6e02:240e:b0:3d4:6dd2:3989 with SMTP id
 e9e14a558f8ab-3d5cce33db4mr86483305ab.20.1743167343275; 
 Fri, 28 Mar 2025 06:09:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:09:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 56/56] expo: Drop the special theme code for bootflow_menu
Date: Fri, 28 Mar 2025 07:06:43 -0600
Message-ID: <20250328130713.2612648-57-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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
index 03ea24f4778..6cd378f8d39 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -211,43 +211,6 @@ int bootflow_menu_add_all(struct expo *exp)
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
@@ -257,12 +220,6 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 
 	LOGR("bmn", bootflow_menu_new(&exp));
 
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

