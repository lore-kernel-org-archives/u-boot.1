Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB2BC3ABDD
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8AD82A36;
	Wed, 14 May 2025 18:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG+VoM5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E1E82A65; Wed, 14 May 2025 18:17:48 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A35A82A25
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a0adcc3e54so4335758f8f.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747239465; x=1747844265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd89xpVdA0yB3fZMYxEaHPI4U5QQZaZ33DIZG9zUy/4=;
 b=LG+VoM5N/aJntCms5jU1RjTAI2E7UijKwZfUEtzNt/2SkYqcl6CNNg5+3diz70juzC
 TGmLJmXLaMFnTb8Xc2u2aD1Pw/UIpa5RcU3WZEEeW3gEBV5lJ8Pm+pzsiUhMYptzK4rB
 o+GWxZohmCMn9D/U85OIpAuQ3NzEuBPNkigfTWEdQ6ZSCuowVZKyzi3/15ObKQRALszK
 txeIiTE/RI96Lwkjg9xpDz5kEAbz19/5ijfPT84qDIKGNbcYTS+Jm2D6Br66WZjkyRNb
 UutQiuKAL3Rt86Z4gxwoyB1Z77n24uIYV2Z09sDTB5xAfVPEm8Rem3afzhNDb+kGY7jI
 FHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239465; x=1747844265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd89xpVdA0yB3fZMYxEaHPI4U5QQZaZ33DIZG9zUy/4=;
 b=lf7+L4b6wbEGl/bydVqGli3hhTitIKeZHYFUw/EoAkJkWrD8yX+5GRTB1Ch8eAVktW
 JBc6I5aBvU/CIXeyX6VqU6tSrOciMyE2pl5KBxEW9M1po3uwJ+LYAYDZnF5CHVgSdtdq
 1zoLKM3bXk+77wr83gEStgaz3rPHrrP/q/IFsWmILHOhaUjtpVicEN5UalWNRu+XxP7b
 BX1bCLxWxdQ5b3Hz1Z0X+A4mBwUtjz9L0s9ubfnVEXJq5JIpVtOm0hx+R+0SxnNYwRKC
 HrBWH8PoUK2s3sZRTgxIDqcObneuC73Oq79QCHjAJxO1nELdyNpGTOHAuKf1Iaa+4so3
 pkZg==
X-Gm-Message-State: AOJu0YyOmTlbtnVq1ZCnLqPIcH1iPhDDBjPgO0R+6T8GhV80wfi+4V/s
 MNfGgu33QIPsTaQ8qDHnJmAQj20US6/+XFDOQmnXVdVvtJ45HLMBgMec2DuZwuI=
X-Gm-Gg: ASbGnctix51N8jJQkoEhiMy4cjIqxswc2itVx+mC5Md7OrvipfFUZAO0Nr2rbdjBow0
 tx9acMLuGfklcC4uvkfJfr/fx647YN4cuLb1X7H7j3z+qhkUweG1G4adx35MeCgXP4SDQM6uFwQ
 dLMhJyqL291ST53vi4WJ8kSgPmUyaeEKSnXw//XFZmASjAsrBHptVTpn671vrqMK5ULnNKI69AT
 eWx1a87vfpS65DjEg877xYPB/1BZZBhp91QYKXW3UefTy7N/mJ5/jk+o9HXGZwTvoNFLnss0R9T
 kZjuVErUPCvvHpnbjwInrOgAvurKcqq1X+84xnZkLTX6s2t5Wm4kFR3/ha4+
X-Google-Smtp-Source: AGHT+IEHfTNqVVNPYLEvjCfB7jRDeheuOM8lqmAkk/3wAHr9RqJamxqk0WJHTHUyFtzqxWN8Zin1/A==
X-Received: by 2002:a05:6000:4212:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-3a349952f14mr3356881f8f.55.1747239464720; 
 Wed, 14 May 2025 09:17:44 -0700 (PDT)
Received: from adriano.. ([213.157.19.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f752f527sm10835555e9.19.2025.05.14.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:17:44 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 1/2] CI testing: add http server to CI tests
Date: Wed, 14 May 2025 12:18:40 -0400
Message-ID: <20250514161841.3591411-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250514161841.3591411-1-adriano.cordova@canonical.com>
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
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

Add an http server to CI tests so that HTTP booting and
loading can be tested.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

changes in v2:
  - Remove HTTP_SERVER argument for test.py

 .azure-pipelines.yml | 11 +++++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 9c136513bb9..334cf27cfb5 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -316,9 +316,20 @@ stages:
           fi
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
+          python3 -m http.server 80 --directory "\${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
+          HTTP_PID=\$!
+          sleep 1  # Give the server a moment to start
+          if ps -p \${HTTP_PID} > /dev/null; then
+            export HTTP_PID
+          else
+            unset HTTP_PID
+          fi
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
           ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
           # the below corresponds to .gitlab-ci.yml "after_script"
+          if [[ -n "\${HTTP_PID}" ]]; then
+            kill \${HTTP_PID};
+          fi
           rm -rf /tmp/uboot-test-hooks /tmp/venv
           EOF
       - task: CopyFiles@2
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7aadd5d8b73..f320de0c29c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -106,10 +106,21 @@ stages:
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
+      python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
+      HTTP_PID=$!
+      sleep 1  # Give the server a moment to start
+      if ps -p ${HTTP_PID} > /dev/null; then
+        export HTTP_PID
+      else
+        unset HTTP_PID
+      fi
       ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_EXTRA}
         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
         --junitxml=/tmp/${TEST_PY_BD}/results.xml
+      if [[ -n "${HTTP_PID}" ]]; then
+        kill ${HTTP_PID};
+      fi
   artifacts:
     when: always
     paths:
-- 
2.48.1

