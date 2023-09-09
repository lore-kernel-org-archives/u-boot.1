Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27A8EEB58C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A2A86A43;
	Sat,  9 Sep 2023 15:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REyTbc00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E054486A45; Sat,  9 Sep 2023 15:52:41 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB7C86A2B
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so25953995e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694267559; x=1694872359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=2I437yjYLgWpfUIMcH5sAECEUOjMrRY2Nzau3Z2I6HE=;
 b=REyTbc009x+hTfYG4bc10u+Cn5P4z4D+nuiojpOVnLe7294TVfCgpE9Enps4/YizND
 QEZVQHtMAL4uXJiUM9Znp27v1muRk0GdtGYQHFZ9ZXp5O8DThT/VynuFtCBES9SQGr4n
 wPc5oRUb0LaKcmk3d0kEY2HhenrBex1dunt9QwCZhrSZCmLZW1GDBfe1fdIVWnUMWD+K
 Nz+nxe3DTEnyNBfW0WM9QtdMPnJzKYVyan1YV3ZuvMltnvEuSlHRR89v86KTbXCqJmn+
 gq8EVtnswwacUWq9MJk1sG7KjoTZojnBgSrfHPO9x7X7VAppDUM6TxBEXwqdpeqGijQh
 +YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694267559; x=1694872359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I437yjYLgWpfUIMcH5sAECEUOjMrRY2Nzau3Z2I6HE=;
 b=bfQyUGOmXgjgZg+yDVRfHEPpT0g+oupKN0AbODo4o0Ou71nyNemZdP55/ePd3mE6nm
 M1cE5dTJHctrSIy8WSQaGGm1kk/GTR+1YWk3ApwdGLj4Ev8qJp8VOX2M0IAo9JANMCXB
 ZEsH/sz9SbrM3qKpdF4DaD6X+JVe3n9RtahMxCbrwxS67Y+paYuGW73VtCe1XViuU5iC
 bgDo+j05tgo45IyMs1bcMD/ulO3GYcToRJDE2SaGVprsGtgq9TDyopJEQ0/nTchQUJoz
 /NluRUj9wOHJcteOcbroHWFwsvutbZ+30j8Ao+naG9vvi9xnLG5TJCQ6uEuFZP2DmfsF
 3vLw==
X-Gm-Message-State: AOJu0YzKFdj/y//DoC5MjVvQ4cjFQaCRnqB87/Gjx4mM6Iht907cGjVL
 W6N//hC4FVSsQG7q1jCEFgOWKLQDDqI=
X-Google-Smtp-Source: AGHT+IHWKP0hRAn5+ZYbfgTZJXTMiqsQrUdogAwLKqhtkFWm6y4QXgNz79pEUflYip2Oli11oFPp8g==
X-Received: by 2002:adf:e4c7:0:b0:317:de66:259b with SMTP id
 v7-20020adfe4c7000000b00317de66259bmr6541133wrm.15.1694267558490; 
 Sat, 09 Sep 2023 06:52:38 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.159.106])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b0031c52e81490sm4871523wrt.72.2023.09.09.06.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:52:38 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH] binman: doc: fix reference tag placement for Logging section
Date: Sat,  9 Sep 2023 15:52:35 +0200
Message-Id: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
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

Move BinmanLogging reference tag after section "Signing FIT container
with private key in an image" and just before section "Logging".

Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

---
Note that at the end of section "Replacing files in an image" and just
before section "Signing FIT container with private key in an image"
there is a line which seems a typo or an incomplete sentence:

 Repacking an image involves

---
 tools/binman/binman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index aeea33fddb..8945b19446 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1482,7 +1482,6 @@ when it was created.
 
  Repacking an image involves
 
-.. _`BinmanLogging`:
 
 Signing FIT container with private key in an image
 --------------------------------------------------
@@ -1501,6 +1500,7 @@ If you want to sign and replace FIT container in place::
 which will sign FIT container with private key and replace it immediately
 inside your image.
 
+.. _`BinmanLogging`:
 
 Logging
 -------
-- 
2.34.1

