Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF8CC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 13:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F4B8857D;
	Thu, 27 Jun 2024 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhWC3GJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7378988582; Thu, 27 Jun 2024 15:43:25 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E0E87A9C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so7176892a34.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719495802; x=1720100602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdup8B9WmAzWR3WLu8r19PGFn+jFbIWNYWSe/aUp7LU=;
 b=HhWC3GJc03EUBl2m+ZIcUytm2rY5iV04BVqywwzQOq02mlw6v3GtEL0/KWx4LzMsaF
 1vTVr8PPrY+wiDSw39jz4XAUr2rrqWe6icRHr3blw0KS+Mnsb6Dl/rXaBQZSNGX+Y4Lv
 fLAIO/zFcjf28qlXTG9RXT4WYKBV5ZrqBqdtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495802; x=1720100602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdup8B9WmAzWR3WLu8r19PGFn+jFbIWNYWSe/aUp7LU=;
 b=FPWhWXeHAFX263kHDAceZBCmmnBAfJV1r7bCea9eo7krdnWjIQD5jr1ySJ0bW9wEBn
 9PZrLkYTOhU5PFE8KXS6zNPsWvmnEX5QKHtOx1iDVJYXLTLq1Q4pm542vZVHjYFSsXm3
 EyPNxh7gyl3MMziOW/oOda2VG284p4yeZsoq2+0VMiDjHMl/Ap3oG+lZyhK0Q3Ow45p9
 BU4FqglGriddOA3fkxQg0BQbJiMJCIpqPFkw7oiDMcxRm68waqur09Nw3u9lVVbifS+S
 ucVYbNKCpzdGTiCEUnBzg8RXKjqH7gdScL0kbIrCeBHKJ8ph3/MO/mwAurJaqCFxMFSl
 FtnQ==
X-Gm-Message-State: AOJu0YwfichH+B02B0YHTtJ7VyHr0H+acXY3mW0HYPbjxqyJAsV0tNWe
 8X96jWhwvQucdY0H0CzQEIQTZUH4FxHuSNhFv016LqwaIr0Awrz5fObRDNoXtRpgABAJPKos43P
 7axvD+w==
X-Google-Smtp-Source: AGHT+IHx6n7kOtgoZ39/tPTxbNpOG+2bAmN2ZAhvEn/yPbRrxPaUXAJ5m/N6MrdAfxIiH+dMVMZ+YQ==
X-Received: by 2002:a05:6870:638c:b0:259:89a5:440d with SMTP id
 586e51a60fabf-25cfce010dcmr14412029fac.15.1719495801888; 
 Thu, 27 Jun 2024 06:43:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-197-45.totalplay.net. [187.190.197.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72bee195sm364980fac.32.2024.06.27.06.43.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Make pytest export JUnitXML
Date: Thu, 27 Jun 2024 07:43:20 -0600
Message-Id: <20240627134320.3518272-1-trini@konsulko.com>
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

Both GitLab and Azure (and other CI systems) have native support for
displaying JUnitXML test report results. The pytest framework that we
use can generate these reports. Change our CI tests so that they will
generate these reports and then have the respective CI platform pick
them up. We write to different locations because of where each CI is
(and isn't) able to easily pass things along.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 12 +++++++++++-
 .gitlab-ci.yml       |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c43bb51066a5..fff78785ee92 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -287,7 +287,7 @@ stages:
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
-          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR"
+          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
           # the below corresponds to .gitlab-ci.yml "after_script"
           rm -rf /tmp/uboot-test-hooks /tmp/venv
           EOF
@@ -371,6 +371,7 @@ stages:
           docker run "$@" --device /dev/fuse:/dev/fuse \
                          -v $PWD:$(work_dir) \
                          -v $(Pipeline.Workspace):$(Pipeline.Workspace) \
+                         -v $(System.DefaultWorkingDirectory):$(System.DefaultWorkingDirectory) \
                          -e WORK_DIR="${WORK_DIR}" \
                          -e TEST_PY_BD="${TEST_PY_BD}" \
                          -e TEST_PY_ID="${TEST_PY_ID}" \
@@ -378,6 +379,10 @@ stages:
                          -e OVERRIDE="${OVERRIDE}" \
                          -e BUILD_ENV="${BUILD_ENV}" $(ci_runner_image) \
                          $(Pipeline.Workspace)/testsh/test.sh
+      - task: PublishTestResults@2
+        inputs:
+          testResultsFormat: 'JUnit'
+          testResultsFiles: 'results.xml'
 
 - stage: test_py_qemu
   jobs:
@@ -495,6 +500,7 @@ stages:
           docker run "$@" --device /dev/fuse:/dev/fuse \
                          -v $PWD:$(work_dir) \
                          -v $(Pipeline.Workspace):$(Pipeline.Workspace) \
+                         -v $(System.DefaultWorkingDirectory):$(System.DefaultWorkingDirectory) \
                          -e WORK_DIR="${WORK_DIR}" \
                          -e TEST_PY_BD="${TEST_PY_BD}" \
                          -e TEST_PY_ID="${TEST_PY_ID}" \
@@ -503,6 +509,10 @@ stages:
                          -e BUILD_ENV="${BUILD_ENV}" $(ci_runner_image) \
                          $(Pipeline.Workspace)/testsh/test.sh
         retryCountOnTaskFailure: 2 # QEMU may be too slow, etc.
+      - task: PublishTestResults@2
+        inputs:
+          testResultsFormat: 'JUnit'
+          testResultsFiles: 'results.xml'
 
 - stage: world_build
   jobs:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a8332..a6c5040239ae 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -41,7 +41,7 @@ stages:
       fi
 
   after_script:
-    - cp -v /tmp/${TEST_PY_BD}/*.{html,css} .
+    - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
     - rm -rf /tmp/uboot-test-hooks /tmp/venv
   script:
     # If we've been asked to use clang only do one configuration.
@@ -83,11 +83,14 @@ stages:
       ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID}
         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
+        --junitxml=/tmp/${TEST_PY_BD}/results.xml
   artifacts:
     when: always
     paths:
       - "*.html"
       - "*.css"
+    reports:
+      junit: results.xml
     expire_in: 1 week
 
 .world_build:
-- 
2.34.1

