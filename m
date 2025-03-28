Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB08AC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D9B827A6;
	Fri, 28 Mar 2025 14:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kjo+AOiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1B581ED8; Fri, 28 Mar 2025 14:09:06 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7CD82836
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b44094782so64660839f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167342; x=1743772142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7q5Y/ZN3Q1/B1jcx4EgLmDo+850v98nIRc/TrBV5tI=;
 b=kjo+AOiKllCX1B4kw0VUYi25VSZrJYeqEnORTqONUgc0baPMj5RSONFEoGrbiMDAsG
 bG1SHy9J1sja4uFUFbVL0oP34yXiDnS07m9L9V9EHLsLtjaaJQLnNidEfTz49LgQcBIk
 nX3izOB6ppohhIjEuRcpaReEPZoQVqnneflrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167342; x=1743772142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7q5Y/ZN3Q1/B1jcx4EgLmDo+850v98nIRc/TrBV5tI=;
 b=lYP+NjQpl2e5B4PoLSvn4xqiubGAgrQf7SAk8eavkcturWVMJQyZLmb4MDgU1TjHyC
 GeEmTo6tDU6ys9rVt2p+F+KbXbIcTrQHGhatxScMXcj+WJXL7r9KLyHpgrOzG4GPB5pj
 a/bgrqF/UEWxoIE242s5DK92OL55c0cOFsKQims+1vbY0lKQ5eA8MfNJGhwmfnVY0t0s
 TwGyvwDGMyO/g9hez8PFNjp2xgXb35/s1mvtHXHkMj7arRI8geoaN16oSE72Bij+dWQy
 mTMbUDtEQ7nK4PQ9huNctBX2lmLlL4RNzMcOLTMagRva30zj+Fn50TGBiJlczgkpgLSy
 yoNw==
X-Gm-Message-State: AOJu0Yx2wxgP+/W+VMuT0PA2vcumT4pkpjpQhP8J7D2SPmKQ4cKfdkTJ
 6lIl2vyCHpx7BuutcKtxo7TWSpuWqGxSL5JKVg+hvai3Gzt4p7YBs9ClrZvSpQ7Sc24DuBREmKw
 =
X-Gm-Gg: ASbGncuI+pR5HZBqsbKy8hrYwzLFEUooHmXvZlrfyfOO35Be2qtzAfYKWpY9BpshNao
 borgsqwD/HJ/9LFcVTDViMKCroyRm+hf8q/XiMiqvkkXtSHDp0Zwv+9yvOLJcxn21We4M9mHtof
 cH+OIT8h0cyF0S1+noEdjZt/ZznYqGQIOQBzMLolnIreM4xk5kW4B2nqPLHL3NE69fG+Q5mkFor
 t0KlnSvGeUrgvYDGO63+6YGCscH2cZSd8JjJk4THXbyki7c7SgAB/3x7GJRZCWmb8MWHYrZVTFS
 DjKxC6aO7VmDObWGAywE7BRBI+2xSm3Bwuk4s1g7BaTz3zHzmfNWG+kVsJ5W8G1RtC6iR+C/+oo
 x42MJJw==
X-Google-Smtp-Source: AGHT+IHZmTtFv7pgNY7nhfCSvAXUhkMuRb00FmUcSPLvbzxc9tTdnFXjTrQy3pRjWNy/QFkWihfONg==
X-Received: by 2002:a05:6602:3788:b0:85d:b26e:e194 with SMTP id
 ca18e2360f4ac-85e8208744cmr949701439f.7.1743167341710; 
 Fri, 28 Mar 2025 06:09:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:09:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 55/56] expo: Set up menu fully in bootflow_menu_start()
Date: Fri, 28 Mar 2025 07:06:42 -0600
Message-ID: <20250328130713.2612648-56-sjg@chromium.org>
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

Apply the theme, calculate dimensions, highlight the menu and arrange
the scene correctly, so that everything is ready to go when the expo
is rendered.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 4fe5d985064..03ea24f4778 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -208,10 +208,6 @@ int bootflow_menu_add_all(struct expo *exp)
 		LOGR("bao", bootflow_menu_add(exp, bflow, i, &scn));
 	}
 
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
-
 	return 0;
 }
 
@@ -290,7 +286,9 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
+	struct scene *scn;
 	struct expo *exp;
+	uint scene_id;
 	int ret;
 
 	LOGR("bmn", bootflow_menu_setup(std, text_mode, &exp));
@@ -305,6 +303,18 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 
 	LOGR("bmd", expo_calc_dims(exp));
 
+	ret = expo_first_scene_id(exp);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+	scene_id = ret;
+	scn = expo_lookup_scene_id(exp, scene_id);
+
+	scene_set_highlight_id(scn, OBJ_MENU);
+
+	ret = scene_arrange(scn);
+	if (ret)
+		return log_msg_ret("arr", ret);
+
 	*expp = exp;
 
 	return 0;
-- 
2.43.0

