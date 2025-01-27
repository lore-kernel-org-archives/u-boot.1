Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FFAC0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 00:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8810E80F98;
	Mon, 27 Jan 2025 01:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEEf3eYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A240780F9E; Mon, 27 Jan 2025 01:39:07 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 395F2805DA
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 01:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e394395aso106099739f.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737938343; x=1738543143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IWkGIn/W59DUD7kJJs+qM9UsU+d7JRh5H+b1dJn0uTQ=;
 b=YEEf3eYfreAAyrDan8uMYY3HmOioI8dssTVeVma2uUrInOkdS17HlZP8wR0Txo8qWu
 DInbXoJ847MxewI/BcPrxp3n6YnpyYRBUF1uiG2VAzX5sqKUkUsRa3ur4GUgDlN0dE1h
 ZdwchxIxu7Zpokl4RuEXTQlf7iK1Frn5BNLdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737938343; x=1738543143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWkGIn/W59DUD7kJJs+qM9UsU+d7JRh5H+b1dJn0uTQ=;
 b=GxSFFB2jk3QZTM9OYpRog9juQ9jgK2XWxVPe9SQCmOT/4FeAudii7PsRrcH/yEiRe9
 idRGCVbvBoqg6bb1qiXZJHg9FUKVrtb+JQU3X9/0z+nAq/Xt5YWT9gXwg0aCh1HetN8f
 Urc0/8X1G69dzjtymrjNroe2hjWqTNfmtV8LzTh+8VdZGqy29ZAz5Y0KUsDlTMbCnENM
 A4KaouzQAZt8i43kAXJ3wL0MrUWYCkr178L8ZGOBy6ZkhfSGtvtJJwV1uKZjz2O+1wxF
 cjcm+H1X/uFSpCTEcW7IkuZigTOOTbcsC3PleYbQEycSVqyr9XiN9xnnEYkbntht0LpM
 VcEQ==
X-Gm-Message-State: AOJu0YxCriBbci+VIZUeLtuHkSwDx6yXAp1EzZfKDY+SlAHCD1MK5uXs
 /5aHvusEEoNusRsKWFRiuZZZ7uIgnGIHWrIY0jwzYT+JaSl9ByaEm/90F9H/6NiEYLcuSS1EvNo
 =
X-Gm-Gg: ASbGncspkI5ZkHLVgt0d0D/GqDyfmieKnav9OkVkGRavP7Yr5T4EX9ADydt2sOBVAKO
 06ZV+3TdoFC9Qt25ZCp44zv8thDmQnkF8JhQMLtEGXxKryvgcjBAdBP4ysz+W96unVL22nxNiMR
 ZtmA1fASCjlVT8pxL6KL2GYZyZ2x/JwIRz1F2m6Ymx2XOFrDwTG1T8kOlqqGtfQpYqLf5z8lMoD
 UDgxinwZi84xw95qCQ48kiJ/5j2FZS7xrtwQvXCe7rFdKf3jn7B2Rix1yOtK7sgLJ9HOK9t328H
 R+eYNo6H/kmVdpZVkKrDxmJ0KcBDlj1yjwRfoMpub/2mfibvHuy8
X-Google-Smtp-Source: AGHT+IFvph3MQrDehA/OEEn+x3yLOwYIVQbTwwMJUT0yZ9mlV/GPBEvruUm8x5v9vk/2XzL5xd3hCQ==
X-Received: by 2002:a05:6602:6d1a:b0:844:7896:a155 with SMTP id
 ca18e2360f4ac-851b64f4c4emr3065155039f.11.1737938342974; 
 Sun, 26 Jan 2025 16:39:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da47d4esm2284303173.64.2025.01.26.16.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 16:39:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] gitlab: Add an rpi5 to the sjg lab
Date: Sun, 26 Jan 2025 17:38:54 -0700
Message-ID: <20250127003857.593658-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

I have one of these 2GB boards with Ubuntu 24.10 loaded. Add an entry
for it so that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a25c037b7d3..339ae83d649 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -732,3 +732,8 @@ rock5b:
   variables:
     ROLE: rock5b
   <<: *lab_dfn
+
+rpi5:
+  variables:
+    ROLE: rpi5
+  <<: *lab_dfn
-- 
2.43.0

