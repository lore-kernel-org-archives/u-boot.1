Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CA4C43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0689F84A04;
	Tue,  7 Jul 2026 13:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="my6KPVyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7423384994; Tue,  7 Jul 2026 13:36:35 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28D184A4C
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44cedfaab6bso1323458fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424190; x=1784028990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3gw8f8HpBt5CKvs/JE/AMgSsHev348bKkN9e/lFY04=;
 b=my6KPVyZ/+usJ5CaRA4TwO7uz4ybMn3bo7OtP/wtfdPKMY4v1bTWEQmr9Q6OPqKSiV
 PZoIXImkpcOfw3uAncssTjTR176Z4CytUWSjskkdHmqzLD47Tsl1TQVU7r11M1nnFOB4
 d9eSItqjlarj93tqT+dHKV+DRyUwtUgq9owyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424190; x=1784028990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3gw8f8HpBt5CKvs/JE/AMgSsHev348bKkN9e/lFY04=;
 b=GfWQpDFd4CZZEABbl+TxeZir4TPhqoM5qhIcABNmeIYg6kw/n67C3OmZThrczd1+4z
 sc0eEWS///bLW+UzaRC9BNz3e6FI4L9vJpZI6iDM2DETSJebYullh90nHlqq4VPme8Ii
 9g6Ovk0NkmTUxyDWxT2FRQg9su9ADWoQOXXAY5Cal5B7tjaMFlFEw6CxRp/mxxSorwOo
 ZpVqZc/3kIhQk4fL+X60kvCbCRxY4O63u3ZftgUuA1TaUqO+pAW5miRUcfubgr7lZq4e
 dhDCnp9p2hj6Tc8w6DblpVfCfwMtoTC5jukgioAJDpb+Z4HdKcK72jbDLlopVZN1AHgu
 9YZw==
X-Gm-Message-State: AOJu0Yx6eI/8ZtLr5hf/KM2nhFhsIMYOaTEUqX4O12u96/zMTex2UgSD
 pNnZw2NJX9rFgf04WfK86bxG3kKFPNTcxJGwMFGSfAs/DJX6qFS+J2+SImXahsbiR82VklT70t1
 Ugu84Bg==
X-Gm-Gg: AfdE7cmmFMMDAVvDtoh5h3LnZCmumUCpw4Hpyn5S8af3qw+cR6pEzKwLVqSbHYQWicR
 GxLP5LhFXympZUGPdti/VN2hbssbbPG/sQn8TuRqD4PNKwA0I8wzHbj4SK6+znpBVIiHtuNQ8eo
 HnxaRDyPuA+rxglrwWsplxo9zq88cPHY2aIpm4YVVv0he06sKqNIlm2Egblk2ZQVwNTRn6YW1GL
 cGLezyk4ZYZEWEI8c77xzCdjUiZVfqO8ygogyLPVfjyBssLs5Er38xB42fYbUV3lXt4pc3/uqBC
 e1N67gsBRioCeCKTQeM7JP7AwQoqnEZU3l76i8/N5cJiqbgfTwxp9IWrp50ey4BJ1f30PUZAQuz
 2tKG1tyVYmRnNej3gydxhlOD3pneI6Ls2mR/bjBrq43eVIYU2NpbPsdXNVRu+IrCJfXfBeopnKG
 eSZRlNJ1E=
X-Received: by 2002:a05:6871:b0a:b0:447:9dcd:ad3 with SMTP id
 586e51a60fabf-451062d1c80mr2864682fac.18.1783424190584; 
 Tue, 07 Jul 2026 04:36:30 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] test: Add qconfig tests to the test runner
Date: Tue,  7 Jul 2026 05:35:14 -0600
Message-ID: <20260707113538.3382145-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

The qconfig tool has unit tests (qconfig.py -t) but they are not run
by the test runner. Add them alongside the other tool tests so they
run as part of 'make tcheck' and in the GitLab and Azure CI testsuites
jobs, updating the job titles to mention qconfig.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 test/run             | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 5bda11a0309..c44c28ee76e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -146,7 +146,7 @@ stages:
           make tools-only_config envtools -j$(nproc)
 
   - job: utils
-    displayName: 'Run binman, buildman, dtoc and Kconfig testsuites'
+    displayName: 'Run binman, buildman, dtoc, Kconfig and qconfig testsuites'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -176,6 +176,7 @@ stages:
           # Avoid "Permission denied: 'cov'" error by using a temporary file
           COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
+          ./tools/qconfig.py -t
           ./tools/dtoc/dtoc -t
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
 
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c2716af1904..eb4636e22cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -206,7 +206,7 @@ Build allyesconfig, tools-only and envtools:
       make mrproper;
       make tools-only_config envtools -j$(nproc)
 
-Run binman, buildman, dtoc and Kconfig testsuites:
+Run binman, buildman, dtoc, Kconfig and qconfig testsuites:
   extends: .testsuites
   tags:
     - ${DEFAULT_AMD64_TAG}
@@ -233,6 +233,7 @@ Run binman, buildman, dtoc and Kconfig testsuites:
       ./tools/binman/binman ${TOOLPATH} test;
       ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
+      ./tools/qconfig.py -t;
       ./tools/dtoc/dtoc -t;
       make testconfig
 
diff --git a/test/run b/test/run
index 7c0263713c6..da9b5ba7012 100755
--- a/test/run
+++ b/test/run
@@ -83,6 +83,7 @@ run_test "binman" ./tools/binman/binman --toolpath ${TOOLS_DIR} test
 run_test "u_boot_pylib" ./tools/u_boot_pylib/u_boot_pylib
 
 run_test "buildman" ./tools/buildman/buildman -t ${skip}
+run_test "qconfig" ./tools/qconfig.py -t
 run_test "fdt" ./tools/dtoc/test_fdt -t
 run_test "dtoc" ./tools/dtoc/dtoc -t
 
-- 
2.43.0

