Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09F3C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26E08857B;
	Fri, 21 Jun 2024 15:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aN07L96y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4342A8856B; Fri, 21 Jun 2024 15:14:35 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A51C88535
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-375fb45f465so6900845ab.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975671; x=1719580471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEunDF9aQ7k+SO7gKtPR54y2aN4VmiNW5O87tayPoB4=;
 b=aN07L96yelP/9+edXHG3lJCqkxt7fmIoCMS0HN/33RVtk1ygdrZJoJnS8qWqNpQgue
 hD85AoOGSgONAWeyf8qBpvuHQM4mn++mcXWc9lQlYEg9OG5fCikUXePPX4i4RcyEsAPp
 2klzga3hkfJMP1NN8QbCVxnrs1hrIeM8LpEDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975671; x=1719580471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEunDF9aQ7k+SO7gKtPR54y2aN4VmiNW5O87tayPoB4=;
 b=VEJn2VnNRa+8d8SK+9Xg2D2bYyX5tgxMt6iL1fNl711Ch2DdRiHUNcUVCqtLFv2Dvn
 Z1zGS99Wb3OGRZ3AqDVD1lwgqCzk6c/IzoP3p7qiIZAiekwWi7OpEECZNmv3y9/mofdx
 yI1uJDyivbRe4w+lBF+YmQTC4zhSkDuyOKfWs0uVhnM64oKYn6dkh6x4vktAnx2nAGJv
 u5NvYqOdgMuc6eTxTaQRhP4ZSJEC3M6mYd+bU4CU0LOc1oqFuouu7gJ9NStst+Hkw6NL
 vG4eodvd5Dt5QduNnoe/TUMA5L5etHNmOdCfT43d+4gOAwRfamyGv6M7xUTVZBgjePKj
 tXaw==
X-Gm-Message-State: AOJu0YzihnCVdMzn2RrXZ/Kg8ydJHPj0VyQJRG+WCMKeviPnTYgOT1eB
 hJyfWPRZBrZcf4sSDRyGaKGZwXjBpWDSIwYZNrVWjla4+y+q30F4ASJtpeja9FucWIWkT/kzOEw
 4kg==
X-Google-Smtp-Source: AGHT+IH4297f/TRE4NeVTA1Fq8nUZYpl78Xpse//MhtHLyI/xGtBja/qbHP1rgb1OZefdDuaWW8L7A==
X-Received: by 2002:a05:6602:1347:b0:7eb:8730:a305 with SMTP id
 ca18e2360f4ac-7f13edf0210mr984196039f.3.1718975670939; 
 Fri, 21 Jun 2024 06:14:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 6/6] CI: Run code-coverage test for Binman
Date: Fri, 21 Jun 2024 07:14:22 -0600
Message-Id: <20240621131423.2363294-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131423.2363294-1-sjg@chromium.org>
References: <20240621131423.2363294-1-sjg@chromium.org>
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

