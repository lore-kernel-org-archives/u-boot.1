Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A19C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404C48213E;
	Wed, 19 Mar 2025 15:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hbaN6RVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33FA3828D0; Wed, 19 Mar 2025 15:57:07 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F0F82917
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso49890205e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396224; x=1743001024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ6Q1FnhfJ52oFyLbde3WIOD8dilqcdjA1ZJzz9JWHE=;
 b=hbaN6RVUYgD8+2rLh+6bOiJSg4Q/RXedP5cus06uf/BziP7NMcK0rzWsVY19TyaYNB
 M6WJ+1OI0ZbQBRpGGCZFOBa72mWEQZbPAPp8RXm6Mv4YW5jC/M3T39C9DDAFblmIV5b8
 gyCEfVPbXCeiLU2MJF2AxboLfza5q1yZzyc7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396224; x=1743001024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZ6Q1FnhfJ52oFyLbde3WIOD8dilqcdjA1ZJzz9JWHE=;
 b=q1euBX9z2sjG+tpMV1NcDEiPaE93Y7eA7dmaaohS2lcVET5zQY4Gq6eUh2T4JFZEve
 VpMnSLuOuz8bpkJaMMVAbTeONq+4k0iVOdgYQkCHnBNaN0HHy68pwg21sCCkGR3h2DYy
 e/Ho5tTfTuMnOAS2elKFaDwTbts0gLRB+XcVDbRwwGjNlzmdUrirTBNfH9aE6vUsNG65
 bOsFwACbwSZDTb8j40CudSOV/vbpN+Fh6VmjkkR0Yp+WnHgaPjtsO6NkvoX2aCC+NMou
 CoOWPil6muok0J1426s7SUpFdjyaAuvni4AXXTowvccJJUCPNxS30Ns1vp4oC32R2qJs
 Rxng==
X-Gm-Message-State: AOJu0YysBc1+4s9UdezRAP/UszoCl6zYZNfW+QjU3vQnkg0CLGKZ+6S8
 jLT+F1ue03v4cdMai/f0HRiblQT9gFqrrakj6njkeEK7nyEPo4v/r460TX7cKVVgNwfejoX0h/U
 =
X-Gm-Gg: ASbGnct7qz81hglWTn+HpQ6vK41ditCx1DaymZwhuEIr+K13gLfdxiaCKeajRCFSp+f
 S/fPSGp23/52KSwF8YBTc3VfTaEkANoivW/8g6sKPTo7eEuoaArfKOkxIPyf1nTmqLMyC6NVhGj
 GqGgucSfTkmvicfypqLmtb6TVNX2kFp5PbYFyWtU9Am/dR4EoE88Sbd0ImvHFe1zlKjACsiTW4V
 YsEdFPP2NhL+IQwVxZI9YUKDPFvorAc0t3eIG0CLLKT6D8D7ZcyYc2sJrhErn2cHxUxBITRVr0S
 DA0jAykwR26VUPCPLdpDCB4uPHELu1Yhrg83Xe6TuA==
X-Google-Smtp-Source: AGHT+IH9089d5MAkW5xflNTRGCGPY9vdgbtdLZ5M4dU+bfnvsnPafBza3USesInxELT/1t4eJ+dnNQ==
X-Received: by 2002:a05:600c:1e1b:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43d43869194mr32433895e9.29.1742396223802; 
 Wed, 19 Mar 2025 07:57:03 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:57:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 52/52] expo: Drop the special theme code for bootflow_menu
Date: Wed, 19 Mar 2025 15:54:57 +0100
Message-ID: <20250319145512.2391122-53-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

 boot/bootflow_menu.c | 43 -------------------------------------------
 test/boot/bootflow.c |  2 +-
 2 files changed, 1 insertion(+), 44 deletions(-)

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
index c477c1c1e09..d3efea2cd78 100644
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
-- 
2.43.0

