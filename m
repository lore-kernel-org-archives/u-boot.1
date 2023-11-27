Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98904C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A886877AB;
	Mon, 27 Nov 2023 14:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ij92W9+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8652B877A9; Mon, 27 Nov 2023 14:01:51 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFB9877A2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507975d34e8so5777394e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090108; x=1701694908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1UsdTzKLZwJT2Y40jvQY7AJYbTwiczkKGIs51eMQgE=;
 b=Ij92W9+30xQRu1ugHEZRblxtSuYOjM/4LqmYQ24FepI+7ILHF/D0tK4ylwY0PLi/AG
 ftgzKGmabKhMkJvmv9oAQ4va0ENQBP9z2do27Xfimr7AqOMSXcXd5jn0VJd1wYOTJkaQ
 QaNN0I4pBzw0v6BQcWEJcEpaPKoSGwzOfKbKhFfo7cS07ezmo0z2ZGOELMCatC1BbWCC
 fulTL6i3BvRNL31vqcG3nmCRWyoYMph9wJR//NI+I1V1Q7pY5d6wsE6+boS5SlQA7ceQ
 qS17mMpewjnlpY10r7f3VLtkNOLwdC8bxWZGjmRS6f6NGB9UhykH6rbrmQFtOzqh9/GO
 dP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090108; x=1701694908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1UsdTzKLZwJT2Y40jvQY7AJYbTwiczkKGIs51eMQgE=;
 b=j9h5fZc0bcPQm4oPwa4M5n8yL4E+3r8I7yCF8z2QvkLK2IYbZ7He3Zm7dUI4g2w4Hr
 MhKV2v7Gdw9uFBp+JlgSTOVNC96gi4NHChzxYsutL24BC3Z3fEGu/4DaoQvfVXWSWkgP
 TeJZ0OnTCg+qIxRWLaiTIDuNV4mSFzJspMuAxlO1TGQZnNYcJlACvGmjqRb/raf7TtvP
 PM5NDrc4PJAng20mc3JZmvfI349KR0LhraqhK5mW2g4uCGFrg3AUYtpZ3PzlhbLcb7qx
 jh0truE6bdLstDT14U/VsaIwwHLwJaHfUD4oW76RXV5qLrohRz9swSllMlxsn8DCE33q
 HdIA==
X-Gm-Message-State: AOJu0Yy4wVC0cZ9Q8LRX+hXujxmJpKaRVZifu9Xp7rFfId2qJGd+qSPF
 79I6JWIT6NM7wMaf1BSCB6ZyXMq84bFBJzMob2yajw==
X-Google-Smtp-Source: AGHT+IEmzaTJekvQlRlYkPyug9s1t0nBwLjvtW/h3smYdCxM6z/s6OG5fpNoYQvqhyFbrveCdy69Dg==
X-Received: by 2002:ac2:5a1c:0:b0:50b:aa1f:595d with SMTP id
 q28-20020ac25a1c000000b0050baa1f595dmr4434221lfn.30.1701090108549; 
 Mon, 27 Nov 2023 05:01:48 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:48 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 43/43] .gitlab-ci.yml: change ownership of the git files
Date: Mon, 27 Nov 2023 18:57:26 +0600
Message-Id: <20231127125726.3735-44-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Inside docker image owner of U-Boot files
is different, so user doesn't have permissions to update
submodules. Make the ower of git the same as current user.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 .gitlab-ci.yml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fee165198a..cb4f00e978 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -104,7 +104,8 @@ build all 32bit ARM platforms:
   extends: .world_build
   script:
     - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      git clone `pwd` /tmp/u-boot.git;
+      cd /tmp/u-boot.git;
       pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
@@ -118,7 +119,8 @@ build all 64bit ARM platforms:
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
     - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      git clone `pwd` /tmp/u-boot.git;
+      cd /tmp/u-boot.git;
       pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
@@ -130,7 +132,8 @@ build all PowerPC platforms:
   extends: .world_build
   script:
     - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      git clone `pwd` /tmp/u-boot.git;
+      cd /tmp/u-boot.git;
       ./tools/buildman/buildman -o /tmp -P -E -W powerpc || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -141,7 +144,8 @@ build all other platforms:
   extends: .world_build
   script:
     - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      git clone `pwd` /tmp/u-boot.git;
+      cd /tmp/u-boot.git;
       ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -192,7 +196,8 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
   script:
     - git config --global user.name "GitLab CI Runner";
       git config --global user.email trini@konsulko.com;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
+      git clone `pwd` /tmp/u-boot.git;
+      cd /tmp/u-boot.git;
       export USER=gitlab;
       virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
-- 
2.30.2

