Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F965C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84182829E7;
	Mon,  5 May 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="epvY5+6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2C88283E; Mon,  5 May 2025 17:44:05 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F0482958
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso6695123a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459842; x=1747064642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cdc9OYfdBNX5boOldjLEaXKmv3EbQSsxxryjVdd548=;
 b=epvY5+6BzdQMYilkcDLYXFqtkVIv4u98oqgVv5v5rRaLBtt4xWXvjplu9/BzS7b3HE
 YwqQ1pwuhJI+aoVHqxkQrntfaAqv8CYh+DzLDZc1RicRRDHDIJ3R2kGFW6GvDgYtHvPS
 d456deFQ2XXkaUsJrZsNRh+Bv8tBfIHcAOzhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459842; x=1747064642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Cdc9OYfdBNX5boOldjLEaXKmv3EbQSsxxryjVdd548=;
 b=WJrsNaQCdjmQ79M6SFjsF14HDkufbB69DanjUGn7Mv0XGJkezFuEYUe/aCaUGJl7hM
 ynt1O0DOnC4GXuVenNXHAhyTY/nPh4ADwRxOvNccMEbeZOIkNLgV1RGTwEPhtAZJ5jCz
 PGyIq3SRCRGw4NtjzxONiWYjcyl1bVCAEcqcQjCcatrrNvm9IFQxdI1NyfYoRdnyx+/L
 Bqa2QtB/oEeyNOem+dhUMH0zAEqoP6AMZxY0RWyssOvDtU74o1KXV6TtF4g+qR3x9Phn
 F0viCAp4HMxm0RvVW16rkaT9EQyTyWfFt6ymD27ryWxN7kTyglzDgTrAwk/iY8f/ZHPY
 8mHg==
X-Gm-Message-State: AOJu0YzX6LBIWZazB3Hn0r6mYg9iUx0kSLZ+j+hw9wV84v5Ew1Eag8GU
 rP7Jm2AOC+3YmvwNJvwj1tAWGt5mtsslEJDJqCKq7fkc5s4f34V9wDwRd/vu2p4ONuWZqeeZn7S
 S77/TrNc=
X-Gm-Gg: ASbGncu6xKLfhV79+yUUgF4qWc32Sy2sCf4zju7KdqztncrXIdLVYllhPFLRfxO9zj9
 FaBnBJ1qzyi5LwWDnE5OtTR/vvpD2jLAYTM4XdF6FnVNB+NYeWmWjjlY2AhpNtCYHpR4wVGmewG
 9/pBcV4pb35r7zKtNIMZhz6POIVvtpvqa0HpcFVKneliT23Cy/dHVSZVrcOLMZot3NbooOZrbxt
 pTG2E42cSqYy86sIXSVrsLHARHkfIjvVIF/5lrdEe3KPJVvVAX8zcjGjWNl7gEcF06K/bY6FG4i
 v20mfWLS/Plq0DCYsQ5ogSD04kRHgpaxx58q
X-Google-Smtp-Source: AGHT+IHEW7R/r7HLb/aSUO54DmDFBm58X4SIJdXYtSIUDXkf/1h8n2/oHf32OvdG1iWT0azZpjoGpA==
X-Received: by 2002:a50:c905:0:b0:5fa:82c9:7a5c with SMTP id
 4fb4d7f45d1cf-5faa8025c2bmr6856452a12.30.1746459841865; 
 Mon, 05 May 2025 08:44:01 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/19] expo: Add extra checks for rendering
Date: Mon,  5 May 2025 17:42:45 +0200
Message-ID: <20250505154308.2911248-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Check the framebuffer immediately after the first render, to make sure
it doesn't change when the scene is arranged a second time.

Check that the logic around menu-item highlight is correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/expo.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index 824ef023c1c..135e177cbbd 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -671,17 +671,35 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* reset back to normal */
 	scene_obj_set_bbox(scn, OBJ_MENU, 50, 400, 50 + 160, 400 + 160);
 
+	/* make sure the preview for the first item is not shown */
+	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_assert(obj->flags & SCENEOF_HIDE);
+
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
+	ut_asserteq(18786, video_compress_fb(uts, dev, false));
 
 	ut_asserteq(0, scn->highlight_id);
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
+	ut_assertok(expo_render(exp));
+	ut_asserteq(20433, video_compress_fb(uts, dev, false));
+
+	ut_assertok(scene_arrange(scn));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(20433, video_compress_fb(uts, dev, false));
 
 	scene_set_highlight_id(scn, OBJ_MENU);
+	ut_asserteq(OBJ_MENU, scn->highlight_id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, ITEM1));
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(OBJ_MENU, scn->highlight_id);
+
+	/* make sure the preview for the first item is now shown */
+	ut_assert(!(obj->flags & SCENEOF_HIDE));
+
 	ut_assertok(expo_render(exp));
 	ut_asserteq(20433, video_compress_fb(uts, dev, false));
 
-- 
2.43.0

