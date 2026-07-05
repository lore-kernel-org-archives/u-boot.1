Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB8C44500
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6E3849F6;
	Sun,  5 Jul 2026 21:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g6cq/H9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B60B849F0; Sun,  5 Jul 2026 21:33:43 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED5A849F3
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a1888969ddso1302502eaf.3
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280019; x=1783884819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAJblGNBPdoLQaOLZ9kSgX3HyuOCC8/cVp3+l0D5xPU=;
 b=g6cq/H9HckqDW1i77FiUhWCh7Qf9Z6uMBaeIff9El6ld+OZdM0rdw7Ok/M5LSHyRAy
 bHN/Ok862HrJIMXJPay13xiakTonXDYn4O0uS40KSgYyroAYX7RpQxEwAUMSVzaEpS4l
 gKRVdyTM98brkSXsm3schFcfLkPx+qaSUA8vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280019; x=1783884819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xAJblGNBPdoLQaOLZ9kSgX3HyuOCC8/cVp3+l0D5xPU=;
 b=pnLYcHnl9d8+EQQ7GDB5xI3+5C1+AynyFFRhGW/KVki4P2jkgcJIjc8R7IWz3lmawz
 F/u9XUCMWhrB7PDJd6EI7j4IUX4HPrhKavLHsz6fmbcagaaslQBII5jgYVWxrog6j9wi
 rJmSLxI10GroXAvy1keClRCs963p7Jni2KluxWVMKS3HMJ783sX+8hHbGWsV9JdxmRX0
 y6jVGsJ58p/nQYn9pf3yPFm97k8pr01caNDO0OYKA30qyasd1K3thYoI5KfTVD6q4D5F
 +hiB6TAj6f5DtfQpp1+fUIcn47XjVhZmmhNbeHTQMiu2ta7T5Q1K0kk+rIYctBwa9Wii
 VlMA==
X-Gm-Message-State: AOJu0YzFbnk1IUOAYX2nfMX62wlmmWGZ5p9cxSmLSlWesoOwN5MNm6VD
 9qRtwWvJ1Xh+7r0vSV0QKwEkyXaxNeoQ7CChr6pkaBVDAX0KA6EK+SITIxwk/RG+mjl8j7UdNNW
 tafzE1g==
X-Gm-Gg: AfdE7cnv40n5dfdvuyYx9QY43/zuGbtM3WAC6Do2uPRoDmCmWhHvGU6kOgBjJPOsEdT
 i6taY1oKEMnHtC9k++/Z4ieAEaCSfI3P9Wbc9MwMhAU0PneC8FkD8fQoozn8IjrXwD0wjkm7lVp
 OkdKyPNDoVo/7uvKzhkkbs9P0Bq+fD3AvgZwlwrmuEoqwEkOaNznxFxpHGzDmZZmr4U4H2zMzjW
 4/MUuISitd2mOVLTf/Q+EnrDyqt6QVWwZmoiOocc0520MFKqlF5iERAkM8YqDwspyBlG4e7UBN2
 7G/ZxoQqtDdf9R+uvyCnKSBUh0OoODClrLC80ZK+HVDfyqV2iWHHIuzelDpnGorgODk4CYXKJ53
 wxdlssjwtcEE5cJ/+M1IjKK95QWHnTR7lrfmYq8OV6Eab4mh8s56p0Wz+0hHPemtrnYXM
X-Received: by 2002:a05:6820:221f:b0:6a1:68dc:4a82 with SMTP id
 006d021491bc7-6a32f545aebmr3820945eaf.40.1783280019461; 
 Sun, 05 Jul 2026 12:33:39 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] CI: Stop building and testing patman
Date: Sun,  5 Jul 2026 13:32:19 -0600
Message-ID: <20260705193251.2190705-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

patman is now just a stub, so drop its requirements file and its
'patman test' run from the Azure and GitLab pipelines.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .azure-pipelines.yml | 5 +----
 .gitlab-ci.yml       | 7 +++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d650f0acbc7..5bda11a0309 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -146,7 +146,7 @@ stages:
           make tools-only_config envtools -j$(nproc)
 
   - job: utils
-    displayName: 'Run binman, buildman, dtoc, Kconfig and patman testsuites'
+    displayName: 'Run binman, buildman, dtoc and Kconfig testsuites'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -163,7 +163,6 @@ stages:
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
-            -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt \
             -r scripts/dtc/pylibfdt/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
@@ -178,7 +177,6 @@ stages:
           COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
           ./tools/dtoc/dtoc -t
-          ./tools/patman/patman test
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
 
   - job: pylint
@@ -197,7 +195,6 @@ stages:
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
-            -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt \
             -r scripts/dtc/pylibfdt/requirements.txt \
             asteval pylint==3.3.4 pyopenssl
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6d9b78f5060..c2716af1904 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -206,7 +206,7 @@ Build allyesconfig, tools-only and envtools:
       make mrproper;
       make tools-only_config envtools -j$(nproc)
 
-Run binman, buildman, dtoc, Kconfig and patman testsuites:
+Run binman, buildman, dtoc and Kconfig testsuites:
   extends: .testsuites
   tags:
     - ${DEFAULT_AMD64_TAG}
@@ -218,7 +218,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
-        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/buildman/requirements.txt
         -r tools/u_boot_pylib/requirements.txt
         -r scripts/dtc/pylibfdt/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
@@ -234,7 +234,6 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
-      ./tools/patman/patman test;
       make testconfig
 
 # Check for any pylint regressions
@@ -245,7 +244,7 @@ Run pylint:
     - python3 -m venv /tmp/venv
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
-        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/buildman/requirements.txt
         -r tools/u_boot_pylib/requirements.txt
         -r scripts/dtc/pylibfdt/requirements.txt asteval pylint==3.3.4 pyopenssl
     - export PATH=${PATH}:~/.local/bin
-- 
2.43.0

