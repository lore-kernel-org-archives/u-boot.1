Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17321C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA1982B7E;
	Fri,  2 May 2025 16:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EQJZppfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E447982ACB; Fri,  2 May 2025 16:48:56 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB0282BA1
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8644aa73dfcso76006439f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197333; x=1746802133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UOv7L9z/OY34hPAI8wy6+nWp6XOSH/h71KY+GEDMPQ=;
 b=EQJZppfEuhi1NLw0fTYH6MIhNPj4ChtXykCNtRa5VMmsaONK4d6KpOg/riGPD22q+B
 20J6uuOsWS/oAue4hcwtpCj51aqDmcg18BYI89ZwJR21PSljn3R9tfjJYGxTeK1a+0SQ
 Vlj6IGAbqPMsfXQFtpmpQWFTFb9lr7sv8hAHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197333; x=1746802133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UOv7L9z/OY34hPAI8wy6+nWp6XOSH/h71KY+GEDMPQ=;
 b=S/H2TGK8Fgc8dVlARSNq8BgtLtg0F01se2pHCl7PnfIByWWX8T2TOsCIry6kgezwaY
 0b6YQtkFugWB2xn+lwLZ/gtQPm/87AaTqzFwHbd0/kFQ78CjTAkiAyqGrfT8LHKEaURq
 9gytRlrMUlG4+QUyiePOQuNHkiYfbvTzi+qgAokvg9+UTQ8xTqCkrT/XiNi4ekd7r2RN
 TiAVKDLWfE1KswKQdqZS19c7i9xpBAWJnLBeDjVYExl5+GfunxVVFGDrasgeZkynRHhY
 XvdsriaY9t4ozsTi4y2KXF2G9vRxC4Sr6HKB7dpWCxFHLd83NUE4F97BWruvQxs8Nv5R
 WpJw==
X-Gm-Message-State: AOJu0Yyk3CLHTlrbKYtdWU1CHlSlKwdLytez2641GdExFJ9/43bCi3hb
 1c5bDfLDgaqfpAPn8KM53qLJ6VMegAXngVjzdqhD9ojqXCUu7Wtf9LT/IEvcy2D87O64vM27uGM
 =
X-Gm-Gg: ASbGncuLaAid7oJmRI1gDzFZsiBJ7v8RRVdZPY/uMG59UxUshZpBlW4S7NSSSemRsON
 6qB52DA1V9pjHDNyXtj43s8VzeuK/VSQRJNYu0rMgJQZpOX2E5Vjl6UnEouRE8Nll5+Jislj8tj
 WkNDfX2yWj+/EUK5safhcwIod0/3gSaQOKz8lMYHCCbN9WdlKd1R+8qhXTqkoVazQ624/AR3/BN
 3am1r5we9beF4vDaiHgvJ94OyCjc+4J1RRMFFht7+7Jlf86n9a+WOFIN77LWNsm2E3ov27n0hiM
 mvYvybRVZFPH6VxNxO//msP7o60Ohdc7Qsdg02HxFNPJp6wADsamu8GzNpML9OcAyP3UMN2jzgS
 ftA==
X-Google-Smtp-Source: AGHT+IGZsIsBAAg5NlObj/YJ4sHKJPU13FGaUJBCqXCv9HIfn4rAPHY7XvS2yronY+RNDPJvTzrgjA==
X-Received: by 2002:a05:6602:401b:b0:85b:3677:fa8b with SMTP id
 ca18e2360f4ac-866b424e060mr394176239f.13.1746197332915; 
 Fri, 02 May 2025 07:48:52 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 45/60] expo: Support white-on-black in the theme
Date: Fri,  2 May 2025 08:46:43 -0600
Message-ID: <20250502144718.313633-46-sjg@chromium.org>
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

Allow this setting to be controlled from the theme.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/expo.c b/boot/expo.c
index 4404fcb67e9..7dbcac78c22 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -277,6 +277,7 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 {
 	struct scene *scn;
 	struct expo_theme *theme = &exp->theme;
+	bool white_on_black;
 	int ret;
 
 	log_debug("Applying theme %s\n", ofnode_get_name(node));
@@ -287,6 +288,9 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
 	ofnode_read_u32(node, "menu-title-margin-x",
 			&theme->menu_title_margin_x);
+	white_on_black = ofnode_read_bool(node, "white-on-black");
+	if (exp->display)
+		video_set_white_on_black(exp->display, white_on_black);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
 		ret = scene_apply_theme(scn, theme);
-- 
2.43.0

