Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F787D6911F
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5DB89D8D;
	Thu, 28 Nov 2024 17:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAfKLJN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BC789D9F; Thu, 28 Nov 2024 17:00:22 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1948589D88
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-296bff3f5e8so574289fac.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732809617; x=1733414417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hye3nUpnDy19r/33/kRsSKOqPHWFlsTr+v87dLcBajo=;
 b=hAfKLJN5tiyn/g5arKIothbsIcgl6DWoQBV1SywNUto5w6/A6CJCaCu3eiLIiqd2Cx
 uTxWM3YrSteTfBwk8XAFksC7Hq0ASep2aEgY5Zfmqc3iVu0zqwA0gifFJPvkGp+0CQqw
 q/7Ts5AJBrsUJ+/aTWftnMB8furBIaumsLdiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732809617; x=1733414417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hye3nUpnDy19r/33/kRsSKOqPHWFlsTr+v87dLcBajo=;
 b=vH6cmpA1bNcO3b/2zn7FrgOVXhBdgTKtkM6f6C4+YWti3jdYoAWOwH+CXENth+Pm92
 2dfkQplGA5gYTdYeRkg96Z9db70iI/x9tdCdtERgodM2RHXRBAJ8GwSocEbG/vFUv50U
 HdQFKBMgh43cRPsB8i+EKyuHYVbyruMW5zKzNlOJl6toUe8mn5VbNeKclgWJn2d5/s0/
 9B6sC6m2AmVQRBIKgZS8IzDMgT3T6xMjj1l9wbPKgDRkrDFV2N1Jnb3utelItDFwPIBG
 Ok1Dt2FZhO/zdnLQ9Ou137/3TL/sHCdrhstpi1R/NVIlqqvgxCO6QpkUH/v1psUv7bQC
 OWgw==
X-Gm-Message-State: AOJu0Yy6sPV/8ZcNRukZcix42Znq6jEX+eLPzwu1j2IfiZn6ipnYiJub
 yD3jz53pFGxAH0T4rE/bh/XtxBjxf0MfW91B+M3xr1gE5XK7OBcwPu/GNp6raHtuQcZuJRf2PpU
 =
X-Gm-Gg: ASbGncurzOC0EmaBCg478YMPW7TZykoCGybOegMsprVM9ywbANlTo0VcTkLyCkaVFhb
 jUERw/eBwFKSBVPXEn/SbBl7YnrgziJqt+8H+meq7GhngoSN3etOsO8pvVhwOv7i7XTEB4sh/oz
 pk2OK7IGqpggACzogsobNkw2DM2I38vZv1Lq5VYcWuDrdxgPQvzJ1pJ+1vWhjpAxi60rMPK1YcX
 bF6dkqZ4ghbyjS2Wnu1KsepUbvwGJVb7St1MoiVo/ODYw==
X-Google-Smtp-Source: AGHT+IE9CqfDmTfo6XxKYS+N3wjHZjQ14oUtaUGGuqM2w8elkGlqtBc+m9Z6DQWHIih1cfg0FYP+/g==
X-Received: by 2002:a05:6871:108:b0:288:62c8:fd4b with SMTP id
 586e51a60fabf-29dc42f857bmr6274169fac.28.1732809617144; 
 Thu, 28 Nov 2024 08:00:17 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d72543866sm362028a34.18.2024.11.28.08.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 08:00:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] CI: Add gitlab tags to builds which can use all CPUs
Date: Thu, 28 Nov 2024 09:00:10 -0700
Message-Id: <20241128160011.780550-1-sjg@chromium.org>
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

Most gitlab runners are mostly idle at present and could happily run
several jobs at once.

There are a few exceptions, such as the world builds.

Add a 'single' tag for the exceptions so that they are dealt with
separately, with no concurrency. This is not quite perfect, since it
means that a 'single' job can be combined with a number of normal jobs,
but in practice this doesn't seem to matter.

To use this, for each existing machine, add a new, separate runner, with
the tag 'single'. Set 'limit = 1' in its config.toml file and set
'concurrent = 10' (for example) in the global section. The machine will
then pick up one 'single' job and up to 9 other jobs at once.

In my testing this reduces the time to complete a CI pipeline.

My choice of which jobs to mark as single is mostly down to how much CPU
they need. For the 'docs' job, it runs for a short time, so doesn't seem
worth marking it as a 'single' job.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72..03bbf764a44 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -110,6 +110,8 @@ stages:
 
 build all 32bit ARM platforms:
   extends: .world_build
+  tags:
+    - single
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -122,6 +124,8 @@ build all 32bit ARM platforms:
 
 build all 64bit ARM platforms:
   extends: .world_build
+  tags:
+    - single
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
@@ -136,6 +140,8 @@ build all 64bit ARM platforms:
 
 build all PowerPC platforms:
   extends: .world_build
+  tags:
+    - single
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -147,6 +153,8 @@ build all PowerPC platforms:
 
 build all other platforms:
   extends: .world_build
+  tags:
+    - single
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -192,6 +200,8 @@ Check for configs without MAINTAINERS entry:
 # Ensure host tools build
 Build tools-only and envtools:
   extends: .testsuites
+  tags:
+    - single
   script:
     - make tools-only_config tools-only -j$(nproc);
       make mrproper;
@@ -224,6 +234,8 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
 # Check for any pylint regressions
 Run pylint:
   extends: .testsuites
+  tags:
+    - single
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
-- 
2.34.1

