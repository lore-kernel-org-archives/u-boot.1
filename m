Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17B2C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847F983C65;
	Thu, 10 Apr 2025 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMKDgvDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA7083C67; Thu, 10 Apr 2025 14:44:00 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6B483C62
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so2529085ab.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289036; x=1744893836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKBkNM/xg6kA9kWgQcmyyZTl9uC4ulqFRdVRBaLEa3A=;
 b=aMKDgvDmeKBD27RnmelfYXo4AYuQV3NAyC7em3DxxA6UP+ZAzErSwU+GnYWbFWkrsu
 Jk71k6WSUwlLq+N9Tr43KY1Hvl0321mjKgzVqsXLf/rGIIS+qjBnare2GPGa2DjP1WM7
 jhDsHMAs5tYQRF4ahMF1cyfckXEgDpq5XlE44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289036; x=1744893836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKBkNM/xg6kA9kWgQcmyyZTl9uC4ulqFRdVRBaLEa3A=;
 b=UyV2XTAyvgweWhSwR89GEtRdlusXndvg9H79dZ29LWVJoyK2ohYThReo0T4wqxSxBC
 iuG9p5AFaOulRSje/TtGkERL7HaAhX0kfHRezNePJglmO2lvcIjmOlABOiiIpj7Mj3LZ
 OUKGrZTKqTbOXZdTlb+4J1yZVXWAd6gZW3c8mnyym9BvTtoJZ2EieGjuI9VvJE7Kt02b
 InM278gfFtmv5untEXOcUabE0oec3MFKimA2ebRYlCftI4SsJUmcJfuPHjtSL/eUW4NL
 Y16JZvyrBMoRkNKTxphI6NQVPf3R0l5eHY1a0daJG25hZP0jxIqtz3VN/GEXnSjM4b4z
 ZpJQ==
X-Gm-Message-State: AOJu0Yy74XZuY15yVNoOjrpxPtKub2lvi8R3xaapf0SSlxT2P0DROIBt
 l2ZlsPON9bLZ0MWtoG4EYHCa6f2iWhSaUo2P0bCVX6Vv6yuT1PEJgD9ebL4xZBALh/1TQC5zwpk
 =
X-Gm-Gg: ASbGncvmYSksqxN+y3Ka0e4dFVRtxChTMBdPislYWSFOnUUi1oZMeE+qgSc+xM1SNeb
 94F8V8URXtLMCqcTbioSX3sRMSE0kL6s7iPUyAtL1ieTUzCb0I6svpmZrpA55izD4ksHp7Qffec
 spR+zDJLuidBl/2Mqh87DcOFfvqLY2yk54Wk5U3OktIb6nKw09nu5XAFNLHXnPrZMJ3i6a3pshF
 Na5DsVfq5HJm0VJqsliGhsoh0Svgoyk8opxBG3TWdsLjt8Y2BZJjpXapG2Vk8kMsTRqnXW8usQT
 BZX10QzjvR/R2CURLDbL4JISR+T61oFEFMCljzLidAJRrt9ZPYXw4i4ChK0B14xRR9nhRzoczp6
 lFLaoR8ehi8Km
X-Google-Smtp-Source: AGHT+IHNTRPLazLl/YGAW7qUTDdWeXtCa/l80iHFv0+MOObbr70V+G3rXFaZpt0ZpOKdMb3qxDTNqw==
X-Received: by 2002:a05:6e02:3b82:b0:3d5:d743:8089 with SMTP id
 e9e14a558f8ab-3d7e46f8001mr31035675ab.7.1744289035726; 
 Thu, 10 Apr 2025 05:43:55 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 8/8] CI: Run code-coverage test for Binman
Date: Thu, 10 Apr 2025 06:43:05 -0600
Message-ID: <20250410124333.843527-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Rebase to -master

 .azure-pipelines.yml | 5 ++++-
 .gitlab-ci.yml       | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 7a33d403a77..4496506289b 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -144,7 +144,10 @@ stages:
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
index 42ec28a9ad8..94ca2c0f4a2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -196,7 +196,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
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
2.43.0

