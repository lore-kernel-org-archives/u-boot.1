Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7CAC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7325688629;
	Sun, 23 Jun 2024 19:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHejtTHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6F18861D; Sun, 23 Jun 2024 19:56:32 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1FC885DF
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-376243a112cso13472735ab.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165389; x=1719770189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NePPf6Rqm1FkuXQRIwrNi0KwP1+VrAe1HF5+P7iE5Nk=;
 b=jHejtTHzz20xJuu6p6t34lPt3lvXnZaFZKQaYFQ1DIj9Nf13UO5p2qsJP+1njdpM9I
 MDA13/Cq3rPV8+p8k8POL+TTsy6KXpM/Sl7TtNN6hIwM2Wqz43qWTk0kDUdf9PNeorEC
 Zb1unIWZYz9u2pGxEscVXfzvJdaMF20KCZxMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165389; x=1719770189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NePPf6Rqm1FkuXQRIwrNi0KwP1+VrAe1HF5+P7iE5Nk=;
 b=OvBUkIifYZzGcEBNTjQPlLGZXU6wGuRD5tMCheU5ni+sKQFn242F+antTEea8E72lj
 slYVxwFUOJ9Sgt+5O1b0N19AwR+Fo9W1mJGT6bd7P14QT6MGQ70rEa0/EIzUeR0ZuNXQ
 ScuTflNS9DiZgRANYsvhQ4XQDN8xfD3MTxfV2BSNsTsTSDnfzndnt3bBUFT8iyurO3Eo
 CIOHtEzLkdghh8RU4ONhSMHUflkW0hNn+c9Gr08w/2MaSeGY/1Oe7htTKx9wIrNu3+Oo
 jJg9l353EuJ7wsaRF6igzOKjAcRT3xKqQhkMNzCMBrGWeZFDZWzmW4VLtZ9wsNMMiaV4
 5gMw==
X-Gm-Message-State: AOJu0YzaaOJIPdeFv0SGd6c8dM6yx+JCBBiftmJXSL09YmrO3eoOtICv
 9tf8+5DkkIuhs2T6L3NvVCFSL12m/+w2KAmFwFCuGTyr2svA4sF8APe/Upw/ozrnpDCU+rkdfqQ
 RLQ==
X-Google-Smtp-Source: AGHT+IEyXQ9Z+z61Os1YGQCijtHznj01LjYYDhWMq9xUOc8fBKBhXpQuKiIHsBqd1Wp6LSj0HvEjpA==
X-Received: by 2002:a05:6e02:1d92:b0:375:b567:a6af with SMTP id
 e9e14a558f8ab-3763df8e3e2mr39079195ab.12.1719165389249; 
 Sun, 23 Jun 2024 10:56:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 6/6] CI: Run code-coverage test for Binman
Date: Sun, 23 Jun 2024 11:56:22 -0600
Message-Id: <20240623175622.1468600-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

Binman includes a good set of tests covering all of its functionality.
This includes a code-coverage test.

However to date the code-coverage test has not been checked
automatically by CI, relying on people to run 'binman test -T'
themselves.

Plug the gap to avoid bugs creeping in future.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add to azure also (oops)

 .azure-pipelines.yml | 5 ++++-
 .gitlab-ci.yml       | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 27f69583c65..65d1d639e49 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -128,7 +128,10 @@ stages:
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board tools-only
           set -ex
-          ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test
+          export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath /opt/coreboot"
+          ./tools/binman/binman ${TOOLPATH} test
+          # Avoid "Permission denied: 'cov'" error by using a temporary file
+          COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
           ./tools/dtoc/dtoc -t
           ./tools/patman/patman test
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a833..eb01fa4868d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -201,7 +201,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w
         --board tools-only;
       set -e;
-      ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test;
+      export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath /opt/coreboot";
+      ./tools/binman/binman ${TOOLPATH} test;
+      ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
       ./tools/patman/patman test;
-- 
2.34.1

