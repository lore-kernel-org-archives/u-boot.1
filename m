Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946CCD98DC
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 20:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D218405B;
	Thu, 13 Nov 2025 21:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L1pWZDtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185A58405C; Thu, 13 Nov 2025 21:57:39 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E3A8405A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 21:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6da5e3353so966976a34.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763067455; x=1763672255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xK937PIPZMMTCECmLHD3h6mNckb8mKAiwJWz66685eQ=;
 b=L1pWZDtuhMi73GmHWtCuPgWGJIel/rAFTm/IVPbvVVTjUDIhZmUqAWxiwhHigfgqKh
 51Hng89GmnrbTRQPbkOX9L15jeRaufWQp9z0rsYCN70LQIzuYlB9OLqJRtpO+oFNO0XA
 R98HQ9bS3nHl7cjEdehciD+KyoS3ei+sPf54k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763067455; x=1763672255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xK937PIPZMMTCECmLHD3h6mNckb8mKAiwJWz66685eQ=;
 b=CAsOPQXnqVD21nkkY09pWJhiSZgQR4aE6tJ5u70PTtu6EQzS1Imnu70ELN8Af82HUj
 6tEuPmMJvgnVy6w7D0akd2JR5shC0d20aooqKCnDV5p97KdCW9YGAb/GqJbsKM0oaWml
 sKtZFRJK12kK7nfxHniOX960oxxg2jvDTbGw0zw+vnQMCM2aAqBtyV1P3VOksiL5RFrq
 LdMcWOLHxZ9MkgugXVyCa/wJ648UocfG947EtVq+mZEE8tJuFOYEtjGoNekh5EE9clLU
 fjSfWvV76mnwdC5i/UeHAZhsYHg6QeRFX2Ck9i8PLC6g/n7ov+hoLBJfkV1/A4I7YOST
 eezA==
X-Gm-Message-State: AOJu0YzRrASSx894/BTtRlq7UTZjqaSN/cauHdcJ8PMWA8fFIfR7Qh2F
 3bggD0K+qRYItpwITJ9hg2FUe/faRPqiawAD3FijayW5/x2tAWz60YnWnMuLJMpwNB0wVwYzPvU
 dBp4+ap00zA==
X-Gm-Gg: ASbGncs4QBXGBHx0dypQ9Q2+/CNt7wzURZ81pxLYOJ6usXLKIGih8125drsDIC35Exm
 POPynR0yglcxnKwNM/t63HN9LIZKrztPGIGFiSvF/wnAc1+Akd6cD1FaTey9KpVRwjDx97ATV7c
 9ua1dncGLSZ999c5r8DjalmXFpPz6StPG5q4HIOquPXWAtM7gzT38KBdbsSuwSF+OdqFJBts5vF
 OkOfkAMSmGZyHH4S49xyG+qM+K8bHvNI/+Rdxu7B+qT9mgI83vU41hT+ebTQzv/TKxMmp82b2yH
 11f4Vr5EKGbXbLPu6SG0sq6q3u1zbiYsJUA6AN75E5S4QEfEnuUp2w6Pb1l4t/nJzvgNySaOwYI
 ayN3kYEcFEKBLxrMPzj5U6NHoiYjYu8BbRRagZve4t4SPgNETNCNFnKhhk0/cazY+OoJzzqdL3g
 K0Qz9xdovkGZUzCtNYjqVyhmT9eY7DaFJGIlvyuX+4pg==
X-Google-Smtp-Source: AGHT+IHDjKy4KkuYb+ZwltwT6lMHY0cKVQb9I8Q1uEFGzd/neH0IbbwSDF7kfm41CvGv1HjccN3gWw==
X-Received: by 2002:a9d:6152:0:b0:79c:f9ff:43e with SMTP id
 46e09a7af769-7c74459e298mr587843a34.28.1763067455555; 
 Thu, 13 Nov 2025 12:57:35 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a29d716sm1799640a34.13.2025.11.13.12.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 12:57:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] Dockerfile: Include python3-tk for FATtools
Date: Thu, 13 Nov 2025 14:57:33 -0600
Message-ID: <20251113205733.1818836-1-trini@konsulko.com>
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

In some cases our tests for exFAT don't run because we fail to be able
to create the underlying image. This is in turn because while creation
of the image succeeds, it seems that some way of how we invoke FATtools
wants to import tkinter, that fails and so the test stops there. Having
tkinter available (and then presumably a fallback to non-GUI because
it's not available) leads to the tests running as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2384219c06a..f62513b86b2c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -127,6 +127,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-pyelftools \
 	python3-sphinx \
 	python3-tomli \
+	python3-tk \
 	python3-venv \
 	rpm2cpio \
 	sbsigntool \
-- 
2.43.0

