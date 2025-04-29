Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396DC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23839829B2;
	Tue, 29 Apr 2025 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DHuIPo4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D17E82A2F; Tue, 29 Apr 2025 15:24:24 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B61F82A0D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so3614120a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933060; x=1746537860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/yo+Y7xc/gIZRxv9rjj2RbujZEqzAvpKVbZBtupV8U=;
 b=DHuIPo4WtPpTS7rQwujbyEfSfKgpktMe7bF8P1XWnUp5q6Okr01qk2wX8auF1h2OMD
 d3G+C1Gxw2XMK9o0m+GU4C+PwLA+Jlcjql7vISCmj7rX5AVlAJiV+/QQONE2uI4gNzZZ
 eIm8LPWjXRPrQXdFzNZ+IWV6Imlnof32JUxgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933060; x=1746537860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/yo+Y7xc/gIZRxv9rjj2RbujZEqzAvpKVbZBtupV8U=;
 b=pmI1zcGA8k1GMiC9GlC/3dfiR6s3b4Wu2WoasZnaLxm04voW2ORjPVjj+Onr+FMOVr
 lmwr9NqT8Ec06F5l/rp/VykgXW2E1U2jO/CJDFQKrdu6k7N2JURY/53pflWysBIyu7N3
 6Y/cKgwcjvBKf5iAHusbkplvxBhsn0opU7amt4BIAmm0JnnTY78rDZ5vDoU7bs/lSvNp
 1Is+uPaFLmUMWhUH9DXSxRnumBa0lTVhOo6wvEGDkZ1SlEs1qWCt9XTWsav9RbEuMqsr
 fO2TU8iGL4aR9uu3z5dKkGnKSUCNSjvcKwmKsaMXr17KuoR5RIzEFpJssUlLmEGB8PYm
 wQRA==
X-Gm-Message-State: AOJu0Yyuypc4Un6xyCSRQJ0gd1iii0MftBx6ydCzV21yKKn+DMlAX5eB
 efIvjajPXbgm/0n5nT7KkayAaiw2rSw7RxD9kQlK1cVgNXY2XKyBd4aHFrSQM9TC+y54Wdld0wI
 =
X-Gm-Gg: ASbGncuPLIlM7CQJXT59WGxEzbBLDoYLe+UBDPM6e1Aos7+83TdRbEUyv4mTZu/91oR
 RpMqW98kB8ZD5jzECGL/AAWWKsSo2rWpXQML4nwduYlydqOxX8BlmQsWPecPCfI9SIEDzcTtIXf
 807bcxsYEW78cu9GhBCKasGKoH6fIxLY9mFeu6TnIh7VgDetJkDJiMqo9wwKKyuak67q5e/nrHH
 MI+ubV54riVnSL4giKo2ePas2u9Rh/f+jyqWnhPUW0d3UV5fRuTTut4dkK5xJxEGLvU7eKmrS+e
 jyosAGAQIBIUKSop2ChfhAFkALuvHmgvQRlgP5Qix7Lc8hp2ugMS9pD/r0b/G+HSA2mueX1PTEC
 Ksg==
X-Google-Smtp-Source: AGHT+IHjmfGDPs/e1tkKFK7syb3+2hAqaOK2EnsXHmCp62FxunFk77H+iCssuGEmXAcMYhPN+V8yLw==
X-Received: by 2002:a05:6830:4424:b0:72b:7a29:d680 with SMTP id
 46e09a7af769-7308a5160a3mr1515800a34.10.1745933060237; 
 Tue, 29 Apr 2025 06:24:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/30] CI: Add a dependency file for patman
Date: Tue, 29 Apr 2025 07:22:12 -0600
Message-ID: <20250429132239.251756-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Now that patman has an unusual dependency, add a requirements.txt file
and use it in CI

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml          | 2 ++
 .gitlab-ci.yml                | 2 ++
 tools/patman/requirements.txt | 1 +
 3 files changed, 5 insertions(+)
 create mode 100644 tools/patman/requirements.txt

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 712c823e145..fd7560c98dc 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -135,6 +135,7 @@ stages:
           . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
+          pip install -r tools/patman/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
@@ -167,6 +168,7 @@ stages:
           export USER=azure
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
+          pip install -r tools/patman/requirements.txt
           pip install asteval pylint==2.12.2 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a7eef0a1d7..23637094553 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -222,6 +222,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt;
       pip install -r tools/buildman/requirements.txt;
+      pip install -r tools/patman/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
       export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
       export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
@@ -246,6 +247,7 @@ Run pylint:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
+    - pip install -r tools/patman/requirements.txt
     - pip install asteval pylint==2.12.2 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
new file mode 100644
index 00000000000..2bbb50d0dde
--- /dev/null
+++ b/tools/patman/requirements.txt
@@ -0,0 +1 @@
+aiohttp==3.9.1
-- 
2.43.0

