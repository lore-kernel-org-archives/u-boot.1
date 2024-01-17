Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0659C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 20:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190B4878DA;
	Wed, 17 Jan 2024 21:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r2XseKWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB80B878DA; Wed, 17 Jan 2024 21:07:23 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB33879F3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 21:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7831be84f4eso775654985a.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705522039; x=1706126839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu7prdKdxG1t/PnNOdsKcWnM5QbA2d1U0SWJ6ElUwxc=;
 b=r2XseKWlFw66EJOZQrNnqemnQzyKfJQuQcEZy1WUxLjwjlWpALGPve74FiPqrLlYzi
 3Q5MFicsqrL16Hh7imMwI8qgGkjA4AXW4kDuXuEj4o4+Qh391Y3B0ayIcsly0fO+xjkB
 NNFOKnWcw/5/NO8f2ry8od2GVGlYhFUkde2f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705522039; x=1706126839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu7prdKdxG1t/PnNOdsKcWnM5QbA2d1U0SWJ6ElUwxc=;
 b=taOt8tWn+myoaEhuvjrGsUMjU1hcqRy/gfms5eQ0cD5YwbWGXqT3HdoOWJN2rxkrGw
 b3x9Y5XxzM5MhsNCXqd8ocrpUFlOEmytz5zrBDyUjPvg+xFFUG62/XJqwhZZy/0mF8W6
 fEQuc2kHL7in0vsx/aU2rk1ub4TOyvnsJJehKUb608OoimbfO7op/YKJIDkXRPkJjVMa
 MJ1cEw+VhJ09tia+CsKa7qupYzlKCdMMzeQLz8mCXkRhpEUjZs3IJ/f79VzxoQmUa/7U
 sjRXg/fxsDFctGkQONGMfOp6u/gSQQgt3lWvqxrasY0bQk3d10iWc+WiDoWhWozUsa46
 9MHQ==
X-Gm-Message-State: AOJu0YwKIGM2x/Ye3T8BiSjsBp3/ilmDHWXjI6t6KNkkcOUlD3pUZxL2
 HfUqYc44DPTz0lDYDCzam8+UHC+a634J+9y5eUGj/g6LxIM=
X-Google-Smtp-Source: AGHT+IFD6oSllbwiLGuVRWTtewh3+VS/Fp8i/aZPUrU6kZz0WYPzISay1XijEFUJsP/mAnoDglsKFg==
X-Received: by 2002:a05:620a:801:b0:783:7734:2a78 with SMTP id
 s1-20020a05620a080100b0078377342a78mr860021qks.34.1705522039705; 
 Wed, 17 Jan 2024 12:07:19 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 j22-20020a05620a147600b007832104bba9sm4778609qkl.23.2024.01.17.12.07.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 12:07:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py/requirements.txt: Update packaging requirement
Date: Wed, 17 Jan 2024 15:06:54 -0500
Message-Id: <20240117200654.1880463-1-trini@konsulko.com>
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

Update packaging to be version 23.2 to match our Sphinx requirements.
This will let us build a pip cache out of both of our requirements.txt
files.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 07348b61596f..c3cc9163fb86 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -8,7 +8,7 @@ fixtures==3.0.0
 importlib-metadata==0.23
 linecache2==1.0.0
 more-itertools==7.2.0
-packaging==21.3
+packaging==23.2
 pbr==5.4.3
 pluggy==0.13.0
 py==1.10.0
-- 
2.34.1

