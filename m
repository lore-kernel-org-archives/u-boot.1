Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB130C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706CB80FB1;
	Tue, 25 Feb 2025 21:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fAgx/qFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C569810DC; Tue, 25 Feb 2025 21:07:09 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675CF807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so19331635ab.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514025; x=1741118825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BT9XcVfrVAloT9cNUE3vLot+cyNMjRqZbj/Bf6BSMa4=;
 b=fAgx/qFaPv2wF5WoYuSSCR431drkFn/FEUrKrKY90beYtddva17UWCrOwARCnlCDFA
 b6+tbujSj8lMOEYCRSIWMKgsE1pGIKK9ANqCcYZvecGkzup57B8zt+C7iR/7LQ1nTh2w
 UxwSwPBV42bPBSeIkHl/7tvVQ+rvKkBqKZKP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514025; x=1741118825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BT9XcVfrVAloT9cNUE3vLot+cyNMjRqZbj/Bf6BSMa4=;
 b=oUTvcYWHiohK8ejv7yRuZUBUKW9VFZVoITtdltx9/FMbuN2Ifqff0wzxu9LxN3v9IW
 wwokRdoLauKy8YP27y8hciraPn0m3ez0HENI7P4W3Lt6clke3a+YOPktjiFoyrjqcKCV
 dQpGLQq3DehNRB/9FPSAy2Gnq99pxL3cwBHNdouwB41wiSMZIpGPho7SKiE69gVI4pDe
 p1IZ5fOICg56Ycuxy/HMv2/M39HIEn8jwjiWGHwsxFcCrhJuongDjf4iwlHrid9mOIAc
 lH7tyZjkosupmCnGVI6ijFdOZm4Mn41zPql30Z3B5GGXO4exQrjB9jDOMS/TDIFIbL9H
 1lHg==
X-Gm-Message-State: AOJu0YymgytEe6GnKY3nBAgIQhvcPUQERyR/rWSk1U3mseBlxvBxIUT4
 OnEMiWO6/6t1Lv9peuH6sa2wsnN6RKQWJ7I30ko4q/IQlgHU6+eves6X/7/wt0vN5S7IMqWXBB4
 =
X-Gm-Gg: ASbGncsR18FXNwqSVNxYRp7w03MGMi9S6JHi94I2yYFPm3ToZVGVYOkfYSM/MvQBotg
 AukZRsMMHFaGghkm8NfpMVKBFFaaB2Eb5hIB7qWA9fk1AA7EyCUjeiwohJFt8zmLez1pFOUE7gK
 aHXikrz/s7ytmc90/qWAzrJW0siSVm9+JPnLzNXNXgOTv3i/pJe+VkiW1aAK4CvldJpR2b7/CRT
 M7dhazxi2RZYtxBRJ2/ZYxa7WqYnLKPDvUZ4X4FTv5405nXlrJ27BroZEnD4tG1S1HcXp0ttV2Z
 JNyt8by+n5hcD2Wn/TF8F5uPZPNm05h6tDsZlVHO185zjZCJcJy8kj+Xovy84iQ=
X-Google-Smtp-Source: AGHT+IGszOc1a/8BF9uPzcwZ/gF/NSiLj99SscoiIfXsnd8Hut63hCL1H8twpC3fxF44MIp8bDWw1g==
X-Received: by 2002:a05:6e02:2148:b0:3d1:99bd:5503 with SMTP id
 e9e14a558f8ab-3d3d1f9882emr7043245ab.14.1740514025564; 
 Tue, 25 Feb 2025 12:07:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:07:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 7/7] CI: Run code-coverage test for Binman
Date: Tue, 25 Feb 2025 13:06:32 -0700
Message-ID: <20250225200635.3781149-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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

 .azure-pipelines.yml | 5 ++++-
 .gitlab-ci.yml       | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 2bc2ca55b9a..712c823e145 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -140,7 +140,10 @@ stages:
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
index 8c49d5b0a79..c6461f33982 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -229,7 +229,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
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

