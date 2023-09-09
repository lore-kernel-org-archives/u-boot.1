Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E542AEEB585
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 10:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF08864E6;
	Sat,  9 Sep 2023 12:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FDO0zdAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99D886552; Sat,  9 Sep 2023 12:32:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513B0864A0
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 12:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso6047665e9.3
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694255552; x=1694860352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=2FBTnsx9JL9RkLPt8nV1yOJkrJVvf+9QtrTIVroOUkY=;
 b=FDO0zdAez6cDFRSLSBpYQXrcRksRiURGUZ+1+1v8cDhmR1R3ry1gXSJPxoqyImxgNK
 7OeiwMRvKdPF2NuEMOYY8lA+epa3AZLudF38yS5cRl7c5lRTeXuCVXp99m7e/ELiQgYu
 XRcctxrBJZ/5G02AYxqBwGCxQsfF0GYst7U2KnTbtEq7WNXIjMoU8yDX6efU61GDMqSK
 wbkyyEmRJ/sCerstu3A/4VIREUlunlH2zX5E7xHDe0VmRntF+XXKXDwqNxeNwX+g6u79
 SelIPtxhss/M8CfDX+50QD0avZprHMQlLLqIhNCi8ez5XFXEyTOfKnkbEwDLHlJUp4XH
 cjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694255552; x=1694860352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FBTnsx9JL9RkLPt8nV1yOJkrJVvf+9QtrTIVroOUkY=;
 b=RW6FOkdKfzoblr3+no+JKazs54GW3wWbLBLKODLcbFy4JGl4hnE6Bhy8xhwoHCiVq7
 EauqP4eimR5HzJyMqko/u3uIEvp4bji0ONUqVoeze6w8Be5m7yUrqUWYwJI9SaEJOdEg
 4CElO4ozV8GUMJp+N0ueWK84Hfw3+R1T+6hy1nXKo7ZX9DD787DGZ2Z0lZgUHhox0qOw
 9nu/0bx8TAbEPfaRViJfz/ncRRG1xIzyzxfs3yCxYhp+XAxmu9Rp86O2RB31PC3p7BqH
 ZpQIXk7SztPHKdlZTnaIHrW7h1SX52v4uWdYkdDYiAPX8R0UQrHNcfRlYbFrkaILD6F6
 1aRA==
X-Gm-Message-State: AOJu0YwgsIPJh+gtTHkM1eJ7Cz1GAmeD+JoqxHPva/knG6sEK52zBpHe
 mn4U5KCn4Dg7kXizVbi0SZTlC0UHoiU=
X-Google-Smtp-Source: AGHT+IHzpF+qB7/EugFlNdG0Gif9OF2SJi6+HWXDmdYmsF8QSPxeKWjl4fsJuvjjaoPW6Rwv+Ls0CQ==
X-Received: by 2002:a05:600c:2295:b0:401:aa8f:7562 with SMTP id
 21-20020a05600c229500b00401aa8f7562mr4119903wmf.11.1694255551538; 
 Sat, 09 Sep 2023 03:32:31 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.159.106])
 by smtp.gmail.com with ESMTPSA id
 ay7-20020a05600c1e0700b0040303a9965asm1168564wmb.40.2023.09.09.03.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 03:32:31 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH] expo: Fix documentation reference
Date: Sat,  9 Sep 2023 12:32:28 +0200
Message-Id: <20230909103228.17366-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix typo: doc/develop/expo.rst instead of doc/developer/expo.rst

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 boot/expo_build.c | 6 +++---
 include/expo.h    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 22f62eb54b..702bf49890 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -209,7 +209,7 @@ static void list_strings(struct build_info *info)
 /**
  * menu_build() - Build a menu and add it to a scene
  *
- * See doc/developer/expo.rst for a description of the format
+ * See doc/develop/expo.rst for a description of the format
  *
  * @info: Build information
  * @node: Node containing the menu description
@@ -282,7 +282,7 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn)
 /**
  * menu_build() - Build an expo object and add it to a scene
  *
- * See doc/developer/expo.rst for a description of the format
+ * See doc/develop/expo.rst for a description of the format
  *
  * @info: Build information
  * @node: Node containing the object description
@@ -318,7 +318,7 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 /**
  * scene_build() - Build a scene and all its objects
  *
- * See doc/developer/expo.rst for a description of the format
+ * See doc/develop/expo.rst for a description of the format
  *
  * @info: Build information
  * @node: Node containing the scene description
diff --git a/include/expo.h b/include/expo.h
index 0b1d944a16..e8f7d7d6ff 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -667,7 +667,7 @@ int expo_apply_theme(struct expo *exp, ofnode node);
  *
  * Build a complete expo from a description in the provided devicetree.
  *
- * See doc/developer/expo.rst for a description of the format
+ * See doc/develop/expo.rst for a description of the format
  *
  * @root: Root node for expo description
  * @expp: Returns the new expo
-- 
2.34.1

