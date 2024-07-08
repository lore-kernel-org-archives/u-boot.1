Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499FDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB6388730;
	Mon,  8 Jul 2024 17:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="thVAIy8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7998188783; Mon,  8 Jul 2024 17:18:18 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1CB8871D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c661e75ff6so1407965eaf.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720451895; x=1721056695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sr1dyw2geM1aCJpEWSmBDorbmRZ/SGRmiykvzQ/bM+E=;
 b=thVAIy8chixL0Dulw3BMBiWB2mm2kls3Ma++8Bx1mzJNNvKyGLp2Tkls6tzW2CQqS9
 Qqoi1hd2HNAmLIcvmLmvC/jfXio+KuzMOE3Kj6a2Icoix4f0fRP1HkaiZAn+boT+wCk6
 KEq1ula7aZfBwOqUzMfabP9fQfXJuJIpB/sis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720451895; x=1721056695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sr1dyw2geM1aCJpEWSmBDorbmRZ/SGRmiykvzQ/bM+E=;
 b=ZVwMkNxaRuEMEbADR+L7wFQIEXMIMIHtX1GcjMNz/tcLJXvdLOq6W8Ewnv1ebV/r8O
 oidWfItrZGFXrjdbGXMaaPj82UK7RI4CCME4xSKqJlDOO8lTkeq59rjM9l3oV8vaL8KN
 GsEPPIUUIlJM4CSZ2CmKuFoV9I7KhnoHcLg/XfdVmdBTRaLGhpHgjGzOaGFmpljCJq9f
 +mHHntyZn6nskSWl6ioPSyJiNCBPxTLEWaYnOe2naXNVr2lJwD0Bn48r9YmhhPHQHKxy
 1QXtC6pbRp5CPYMvT+anKLYRFbOBOIFqEwBhwAUsZUootmXv4CjcR5FT674ZAIPU+YgI
 crqA==
X-Gm-Message-State: AOJu0Yz29e1CCXSZuoo762Gi1DoR/JWs1KNxuZg42jOSjEkn7m7HicDR
 NhMclw83l1oF/W5oUE1b3Hrymy+Yw99gGmWPEieEmBpm3FCJIg9I24wE8/ONR4CW10+r8Py6zVK
 UGnY=
X-Google-Smtp-Source: AGHT+IEEPm26iSShquA/RCgXnnUi7rKN97b0mI5S4tp3xqifEpEhvS8vwWWlRO1ba8zymXfX1zdL9Q==
X-Received: by 2002:a4a:ad49:0:b0:5bd:c2b0:f599 with SMTP id
 006d021491bc7-5c6470b4f29mr13164299eaf.9.1720451895077; 
 Mon, 08 Jul 2024 08:18:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c68cde67basm8190eaf.34.2024.07.08.08.18.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:18:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc/sphinx/requirements.txt: Bump certifi and urllib3
Date: Mon,  8 Jul 2024 09:18:13 -0600
Message-Id: <20240708151813.2137042-1-trini@konsulko.com>
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

As reported by GitHub dependabot, both of these packages should be
bumped to their latest versions to address security issues (neither of
which has a CVE assigned).

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/sphinx/requirements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 306b05a995e6..40dde599916e 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,6 +1,6 @@
 alabaster==0.7.16
 Babel==2.15.0
-certifi==2024.6.2
+certifi==2024.7.4
 charset-normalizer==3.3.2
 docutils==0.20.1
 idna==3.7
@@ -22,4 +22,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==1.0.7
 sphinxcontrib-serializinghtml==1.1.10
-urllib3==2.2.1
+urllib3==2.2.2
-- 
2.34.1

