Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10007EC8758
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 20:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC14B86823;
	Thu,  7 Sep 2023 22:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpk4VcHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7918886998; Thu,  7 Sep 2023 22:50:51 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83BE867F6
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 22:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401d67434daso15084445e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694119848; x=1694724648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2IgLkecb9Dep1GbLdnmaV9pUQGxUQbRnpsHtR8SAzTo=;
 b=kpk4VcHhhnzkwO9TTnWsciOIUME2iZTU3GQxnZe5+EoYtlPnB1nqEkDnkwrE7O3HQv
 AhV47RgXcZNwrKmd3tCeZJJIAjkzFEDDoihFkdQloWZh30L1RGC9U0rSIYYLXTSy3jwU
 3WErrtPtlheEwfzykKXpf7WwuS8LTJQZ/OZnMK7gF1mOc080Vbujfsco9qrbXYJzl7Xm
 NRrit+W+5k9j28ZJZSnvFeGUbWx5eniLC3H8o2gqdOaX5Q1Poq9htB3TFbED5bNX/Ocw
 3lTxqrhYs3HNIrP64dKk6VKE+FTD8JIPJwfXgBnRkX8H9Kirh6poYZnS7DWKuk6TGdm5
 4xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694119848; x=1694724648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2IgLkecb9Dep1GbLdnmaV9pUQGxUQbRnpsHtR8SAzTo=;
 b=icCj6Q7dPQk9lbxUd+dxNHxVRwgj6azwVQQKIwIukIvI6nu9fjhRGZjeh56rWevWEl
 7Y8/8l6tuVeT1XchGkI0C+FDcTQrTjWVnDYrJMRTZnjJZOEgggE8LlgDYSfepmGBdgI0
 TDdDKltkcZs8LE6Go1lb638LK7QL2LeMCqVqbtxw30Xw/cuj79yQKDnmqDUy5ISrBcEP
 I0ZTtATIQ0Z3rAJJIaqOIvEVPI0cojyVGjZzluT9ibzwKqWPna3+aYdRk/tXJ5IIULEm
 Pya4pkeP6u82ROE6heramGB1gRnOf6MCloPHqMUU0MmdPLvI0Dvc2c9+8b8Gmb+RnnU3
 Gwbw==
X-Gm-Message-State: AOJu0YzxD49WB3buxvCFTLa2gz/WkvemhZnZiJqqsiHS5xcJoKn8TXSA
 MAT7wII40ST/702OPcy0n179vm3foEW9+y+m
X-Google-Smtp-Source: AGHT+IEf4z46d8X9ZHlM5qzlmYsqjAKCOTHyXyE2Lv7IkxcqfPiklD63zeYXuUCbX6N/KodFCxvl7g==
X-Received: by 2002:a05:600c:2108:b0:401:b76d:3b8b with SMTP id
 u8-20020a05600c210800b00401b76d3b8bmr602433wml.16.1694119847630; 
 Thu, 07 Sep 2023 13:50:47 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o8-20020a1c7508000000b003fed7fa6c00sm3521350wmc.7.2023.09.07.13.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 13:50:47 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, miquel.raynal@bootlin.com,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1] doc: Update path to source_file_format.rst
Date: Thu,  7 Sep 2023 22:50:45 +0200
Message-ID: <20230907205045.15406-1-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Previously, the file extension was .txt, and it referenced the uImage.FIT
directory, which no longer exists. This commit updates the path accordingly.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 doc/usage/fit/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index c933703d1d..8b38cd534d 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -22,7 +22,7 @@ for its latest version. mkimage (together with dtc) takes as input
 an image source file, which describes the contents of the image and defines
 its various properties used during booting. By convention, image source file
 has the ".its" extension, also, the details of its format are given in
-doc/uImage.FIT/source_file_format.txt. The actual data that is to be included in
+doc/usage/fit/source_file_format.rst. The actual data that is to be included in
 the uImage (kernel, ramdisk, etc.) is specified in the image source file in the
 form of paths to appropriate data files. The outcome of the image creation
 process is a binary file (by convention with the ".itb" extension) that
-- 
2.41.0

