Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28911C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E0D84979;
	Sun,  5 Jul 2026 21:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UdQ6BXQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BFB3849F0; Sun,  5 Jul 2026 21:33:41 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC9A8497A
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a31b9a492aso1243224eaf.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280016; x=1783884816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUSWDBGa0eThd9a7I5yxYCbNg6vvh6v/24bkyH7gVMY=;
 b=UdQ6BXQPLPlJ+HnqW0AxWAtgKwF6JblCw4KFt8ZnaimhWCr9oW9W2xc5nDdA4wrvgx
 xPQNeJdzlYafpJGhGNyuG14UYslB9wQD/wyM1EX9nsFt1TkQAoIge4wrQFQ9zC+JhZCn
 tDvfqJOFk0yNao+xtp9PQeTxFPxBooEFFPbhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280016; x=1783884816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CUSWDBGa0eThd9a7I5yxYCbNg6vvh6v/24bkyH7gVMY=;
 b=DHhLRqc4St81OXYcIIsQttSu0jGTuRb4ZzzyfHkr1Bl4h3RDxjtz2lTKlGZu4+Yl+W
 02O6/q214eaTt5USKNl0Ppfin44ChA64vp8fqMBc5FDndvxgoX5rJAPvxioreFgCmoi6
 9bNBe5TKEOs0wCDZYYURQ5eaPUxHSjocmwDnW6aLpkOvBiP+cuDUF2yj32N1ULGfOjW/
 zYyBmm8HZzDpND/EW2itJCmT4B0htvSLL4J6BiB+YEUZewcYRsV1ekcBkFurmHEGzS9O
 bDGfQQN4C9Nvhxqk46n2VPl46qBVWITQx1YM0u2q3bzMfTcFvr7efLr44n0e9U/Bp6jy
 De7g==
X-Gm-Message-State: AOJu0Yw7ylP6zMkpqyQC46MjLCYtGnMTKQmIlHN+Vs00vAMghH0ERQ6i
 uS4KxU8VMxTQs2mpS7rhPAvuhkMI1CIJVucYxtLRgRPqI5L1Kb/GCPxy0ckYbM+3mLl6bMlXsoX
 rAw1uGQ==
X-Gm-Gg: AfdE7ckKdUoq+05LusH84GIISd0ks7CsllmEC5ezXEHT5i3eISQa9hfhNw7iqUyhr7s
 S5UQm/+ZqgnMcraS6BSh8q6AV3HqUz3C+a+sFYXFDksX1R9Rfs5kSjB+Es/Hi5TJuA+eIU2n/5T
 B3j9yQ7AEWkUHcRUS+L/BZgcJtKm4KYQnbQUSs4fuXzEmHrp0lxU8Zb8KxqRPAjp4Nuymahy0v+
 Y6ep73D11fhiEVIl2oIDxV3wTONj0lsqxEg5xC0V4T56dq9HM+vZNM72LNEm60Z7wwgeMGVeIPG
 0zbJE91I2nxql6vO6NEgZ+ESKwluDljzHzULqX0vJ3vhkWn2+oTca/RhEwE3FNTZbOoeJ+j0bJU
 UPIhiQM9gaV2JtR2x9/qhkX1DNo33h/s9eQwvsQ0152OtIYkSWCpcw088YHZW4INXknlCFbE/KT
 ulSG9RmDw=
X-Received: by 2002:a05:6820:2088:b0:6a1:1fde:c853 with SMTP id
 006d021491bc7-6a32f444453mr4311120eaf.4.1783280016028; 
 Sun, 05 Jul 2026 12:33:36 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] CI: Install pylibfdt's requirements in the tool jobs
Date: Sun,  5 Jul 2026 13:32:18 -0600
Message-ID: <20260705193251.2190705-8-sjg@chromium.org>
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

The GitLab and Azure tool-test and pylint jobs build the pylibfdt
bindings, which need setuptools. That currently comes only from patman's
requirements.txt, which a later patch drops. Install
scripts/dtc/pylibfdt/requirements.txt in those jobs, the proper source
for that dependency, so setuptools survives patman's removal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- New patch, split from 'CI: Stop building and testing patman', to add
  scripts/dtc/pylibfdt/requirements.txt for setuptools

 .azure-pipelines.yml | 4 +++-
 .gitlab-ci.yml       | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4417ef4e5a5..d650f0acbc7 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -164,7 +164,8 @@ stages:
             -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
             -r tools/patman/requirements.txt \
-            -r tools/u_boot_pylib/requirements.txt
+            -r tools/u_boot_pylib/requirements.txt \
+            -r scripts/dtc/pylibfdt/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
@@ -198,6 +199,7 @@ stages:
             -r tools/buildman/requirements.txt \
             -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt \
+            -r scripts/dtc/pylibfdt/requirements.txt \
             asteval pylint==3.3.4 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..6d9b78f5060 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -219,7 +219,8 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
-        -r tools/u_boot_pylib/requirements.txt;
+        -r tools/u_boot_pylib/requirements.txt
+        -r scripts/dtc/pylibfdt/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
       export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
       export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
@@ -245,7 +246,8 @@ Run pylint:
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
-        -r tools/u_boot_pylib/requirements.txt asteval pylint==3.3.4 pyopenssl
+        -r tools/u_boot_pylib/requirements.txt
+        -r scripts/dtc/pylibfdt/requirements.txt asteval pylint==3.3.4 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
     - echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
-- 
2.43.0

