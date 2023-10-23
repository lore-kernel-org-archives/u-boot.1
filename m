Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E631C004C0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFF38790C;
	Mon, 23 Oct 2023 17:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J6pZBBTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C583D8792C; Mon, 23 Oct 2023 17:37:52 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8EB87929
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9a58f5f33dso3189297276.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698075469; x=1698680269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BltpwlQ6LQd8rolBS5fScNZbD8yPUJtgbXz5MQndyDw=;
 b=J6pZBBTapt2kVJxGsiJDs7iVNJsVLEdL9JrWdgQB6VBwzKXO9kdh4GH6R2jO3lSbbR
 VcODi86uFpz148eC8P9caRHq7UESC7WiIqrEAmjpc76AEsB+Zaq3up2X2HLa7102jlqA
 taWDkW7qaGyl69DN0o6XLUNIOWrGfmAvykSFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698075469; x=1698680269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BltpwlQ6LQd8rolBS5fScNZbD8yPUJtgbXz5MQndyDw=;
 b=Fix/u7GD1HNwuBBzdHH3/M00BqrtupJsXM3W4t+h+n/rx0EHKlxou9piRja+3fSbIX
 0GUo0gWy0uqNII99p7be2cjuV3QE1jkw59QnuBfhHkWu7Acc66RjL0H99dJr6zJyR9of
 k0gslsIxGoCHjg9K/6MF+bRkIdWTjwZtOpHBi9KFidOT0nwc8FYhsOMxbINTkhbmViqR
 wNlS2qIZP3FSg0gUb9Y8SUr/9Kq6E6ClMFV+VGkCWUA+Nqc3nSqfZIiEfwdapi764aIz
 xgU8hI/0rGkrcmpqpXuUjfJi54+RPp0/ZTfaMtShJJDwCDpt4rFp892+6592VGXhCWrW
 1bng==
X-Gm-Message-State: AOJu0Yygv9F4xjLupKaWEUwAhzHxLR2TQ9DUBp3p+xjbZo5yfwhbOI2F
 FsftWZbvr+s6kAMvRrFvRdPi/lKcGXF2DqCByGLrGw==
X-Google-Smtp-Source: AGHT+IGSe2k8xWkN42a5ZUsTkoalb0DUpuzEyN3Av4WOSXCH0tsYEXvj0WU4HCcW+GwzARqfDaDleA==
X-Received: by 2002:a81:6c08:0:b0:5a7:b942:c3fe with SMTP id
 h8-20020a816c08000000b005a7b942c3femr10161008ywc.16.1698075469195; 
 Mon, 23 Oct 2023 08:37:49 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 x188-20020a0deec5000000b005a815346d95sm3209750ywe.71.2023.10.23.08.37.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:37:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Re-enable maintainer check
Date: Mon, 23 Oct 2023 11:37:47 -0400
Message-Id: <20231023153747.1967540-1-trini@konsulko.com>
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

At this point we have all of the defconfigs maintained again, so
re-enable the check to prevent further regressions.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 6f91553e8613..eb9353fc3dcf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -91,7 +91,7 @@ stages:
       options: $(container_option)
     steps:
       - script: |
-          ./tools/buildman/buildman --maintainer-check || exit 0
+          ./tools/buildman/buildman --maintainer-check
 
   - job: tools_only
     displayName: 'Ensure host tools and env tools build'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6decdfdee334..1e11b5a6fea8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -177,7 +177,7 @@ docs:
 Check for configs without MAINTAINERS entry:
   extends: .testsuites
   script:
-    - ./tools/buildman/buildman --maintainer-check || exit 0
+    - ./tools/buildman/buildman --maintainer-check
 
 # Ensure host tools build
 Build tools-only and envtools:
-- 
2.34.1

