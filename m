Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4EDCA5539
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 16:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D0C869DA;
	Wed, 13 Sep 2023 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ID8g5o1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAA4869E1; Wed, 13 Sep 2023 18:16:40 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDB3869D1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 18:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401d67434daso76433135e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694621797; x=1695226597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=UmCEcMPwpZe9VQX0hOI6JLdTw2JlVxbKQX5C1n+gNyg=;
 b=ID8g5o1CIxAUji1f8twT7kqiJmOEQNyim8QFGnrv288q7a7mHtT3PX+h16KVcQC+Yn
 ee9ckexG3biN9llk2/XAQwxfccGVTERNfbmdG1N0wzC5VwNenGELtkVsDeQE99oL1Vck
 6HC22Ip/KUnv4+2Je9ZxD+IIHZZZsbj/rd5X6Wl4uZhSCBSPblfmN0k4njmWGLMeIbEX
 sHmNBv95KKp/Q4reEUhaG38Cs/sP75WHBAsIUZjAo2dOTNdeolbqs8tEmGo6roILdiMM
 Yp1ogFyQbQK4gqrOdav6ntjMEaCHiF2U+W8h7DH/cFZgm5DTK/bCs6SBehjhDTpcqCAf
 MmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694621797; x=1695226597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmCEcMPwpZe9VQX0hOI6JLdTw2JlVxbKQX5C1n+gNyg=;
 b=g0b1R2KS49xTMej654yt9+jGfj1yVA3gym1Lp5V2PyLN78T+QMSSBJsEKinnsyYI0v
 HvRqW2dWkiLe1qQVdNk7SH4w20e2pfwXWp7bWYY2iktkgX71a/StSIxKtTL3wbfT/dqO
 1rXSybBXK/g8wOGXO8X+cFzH8t4T060ptZRzK5bjilnV1tkEJbScXQWaslBxeV6uNwQx
 4r7Rx72RDMmWYJcqIw6GqG8aHmMFau50/kbzMM68PSKyyAIVHL3xRFbiEO+J06bfkUpx
 SnHwcYYE8mQwQAmEO/KRFknKovtLl29pBHWnD5ngq1f/bU5fKtVqLX6yR3ZaPzo3Y/v6
 7KxA==
X-Gm-Message-State: AOJu0YzghbHtm1G3/8+gBxdxEIJgRpwxaTI63w6DzLbBlkTZdT8MIC58
 2SX0lHtNiHAIyk+sB7PsY5erlWq05s4=
X-Google-Smtp-Source: AGHT+IGobcsSIA0qN/Q0wd7LqL5beRTdZnEEx2u5P9i/sWSxiOS2C7VkvTvMYOTFNP9X1pJtd1aO9A==
X-Received: by 2002:a1c:f717:0:b0:401:d1a3:d7f7 with SMTP id
 v23-20020a1cf717000000b00401d1a3d7f7mr2748458wmh.30.1694621796765; 
 Wed, 13 Sep 2023 09:16:36 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.210.190])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a1c7504000000b00401d8810c8bsm2439222wmc.15.2023.09.13.09.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 09:16:36 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2] binman: doc: fix reference tag placement for Logging
 section
Date: Wed, 13 Sep 2023 18:16:33 +0200
Message-Id: <20230913161633.999542-1-massimo.pegorer+oss@gmail.com>
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
Remove meaningless line with incomplete sentence.

Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes in v2:
- Removed incomplete sentence (confirmed by Simon)

 tools/binman/binman.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index aeea33fddb..020988d955 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1480,9 +1480,6 @@ as set in stone, so Binman will ensure it doesn't change. Without this feature,
 repacking an entry might cause it to disobey the original constraints provided
 when it was created.
 
- Repacking an image involves
-
-.. _`BinmanLogging`:
 
 Signing FIT container with private key in an image
 --------------------------------------------------
@@ -1501,6 +1498,7 @@ If you want to sign and replace FIT container in place::
 which will sign FIT container with private key and replace it immediately
 inside your image.
 
+.. _`BinmanLogging`:
 
 Logging
 -------
-- 
2.34.1

