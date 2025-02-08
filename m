Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997BFC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 13:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F293080821;
	Sat,  8 Feb 2025 14:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c9XlhfxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD41E80834; Sat,  8 Feb 2025 14:34:36 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B5580820
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 14:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so91602139f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739021672; x=1739626472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kylWswZH5U781F4LbGAbWI0CAnrQrtQiWOYCqlgytYs=;
 b=c9XlhfxL5qOXQ+7NPcXFf1AO+7o98RJ7qX2zC4Pgrq9cvsDxhfAbmTa/jWMgOD14o/
 vsre4eikagXy4Z/fYQtrYjjTnA9FjKvQEu5vkJ/oiuH+PxkUd1n4oAcKCLDzY8JOp2vj
 Epit8ESZFcfnaxtETyBOqz6j647jUSFUSHFeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739021672; x=1739626472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kylWswZH5U781F4LbGAbWI0CAnrQrtQiWOYCqlgytYs=;
 b=A8gNx8A6jtGhZlw0TRsKCJttmo1yVeqguPaO9sJOXnJbaX96u5g9OSWd4cny87Umx4
 xbu17TI0qo3Al4FX+lZqDh+QbMVeK/XjX2LhNRmrN9QFrkmXCtWxXDCysrN0lH/jm+kg
 QnJNRtu43IoynM/4Ym7ti8QQ+YrQVQRdecKscpneOxBoRXtmmqAfA+855UXqh3DVT9dX
 3HkTYLLWT1v5zacvYCRSfpsorApfdi/fVQHguSzAEXSZHEnqLlqpYmRTRl1XgNVB5eD+
 ToMr0kdyq4p+jgGcOTlZwCK5i+Ms6pHN8pw27tAerS7Gl8GzcS0akyxPHY2uoIfUIV7j
 Xx7g==
X-Gm-Message-State: AOJu0YzPcVLfDP3tYZ3LJeDuj5qTqUAzd40FIzaIKxwMkold3AJNNJkE
 A82DA7yklvxB9Hq9WRxGWyRDVHS6bGgt+mMcW8bWLgLUJFJmwjAQi6I9VLiZB3cL0+2H5IqzSDk
 =
X-Gm-Gg: ASbGncvX6umn1ryEnSc8OxL+Fu9fjnAxjFPm57Qy3VhFSWXv3QHpGDghpEWmHXxsYl7
 0aZFqBTQS6phugLOrDU/purzVV4Nb4K2kXmXIdbFL+wkHB3v95WbpRkJM4MRLdHuOoTpUlwYAcJ
 eY9mc3p8HeUFifhbde1d3PdriSFdPXYDYY/iYUyc27Uc5T+IH8n1QR569rpOudr5JivNo3FArGd
 h2RVdAv1Rzzo2HXjaLad5HW/DC1NQVIfZoF2/+p/q/Byp+2a601pqbh6EX5InE6QB+Rsno/ayE4
 vLyvexf0y1E83niEtRlUKzF4hcjXknqX5a6wrUosaS5K4xi6mrZx
X-Google-Smtp-Source: AGHT+IH1BfyyagfAdftSMHU9040FfuvBPSJSU3uqhC6Cq3uPE5rD9uyty3nQjX8GfJZjfqYVz/LCTA==
X-Received: by 2002:a05:6602:6cc8:b0:835:4b2a:e52b with SMTP id
 ca18e2360f4ac-854fd8f00b5mr547211639f.10.1739021671852; 
 Sat, 08 Feb 2025 05:34:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f6654e17sm116045039f.4.2025.02.08.05.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 05:34:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] CI: Use different git-directory for each runner
Date: Sat,  8 Feb 2025 06:34:24 -0700
Message-ID: <20250208133426.309526-1-sjg@chromium.org>
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

It seems that the new approach doesn't go far enough, since when there
are multiple independent runners on a machine, they end up sharing the
same git directory.

Add $CI_RUNNER_ID as well, so they are kept separate.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index edce2b8a680..8c49d5b0a79 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   MIRROR_DOCKER: docker.io
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
-  GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_CONCURRENT_ID/u-boot
+  GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_RUNNER_ID/$CI_CONCURRENT_ID/u-boot
 
 default:
   tags:
-- 
2.43.0

