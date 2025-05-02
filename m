Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6794C3ABA9
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 02:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0114A812BC;
	Fri,  2 May 2025 04:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hXe70IvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0F98212F; Fri,  2 May 2025 04:50:48 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C000F82075
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 04:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d93f4fe5baso5362755ab.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 19:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746154243; x=1746759043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0vSLvv06KMoH+vCyzF0zetmh73dYF6XHgbnEK07J/c=;
 b=hXe70IvEvExi8dyNPQpJuOhEn+41vqlxYS4+ulGDKCs0u8IPJ22G3bmaubW5OoUR5V
 j4XRsX1AqV9kyq5sWS5Qjsi5B0MYsu0uiifmNhtQrC2EtdibySq+wP6UkD7Ls5UUctPz
 H9yI9eN2+QRAvpgd7NgsBxxBEkm3L3SyJZfDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746154243; x=1746759043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0vSLvv06KMoH+vCyzF0zetmh73dYF6XHgbnEK07J/c=;
 b=B7ekm0rVRF6PcEwq3l1h52JK/ckGAD4u/DlEoHxQWLYDNUKjScSYbTl0jB1l8rCpQk
 Q90S1fGlbV6imMPXDZc/pi4uQmyCVKL9Vygq8/sDatgKy4sjJGbJNTJFV4FJs6sFHtvw
 9oUMBpfiVXmgdHGOVChVJ8f8t0rB0gq3qZL+82nyyDQo2NEZaDwB7c5HDQ2JLYmT6OAn
 Jis6vbhW1jRjy4EEAHGQ02H1JU159vT+hBvnaqiRgnL5ag4RxKzGkbiHFD7DVwv5MzZa
 9T+PxIUbMY0Im8t2kbAosEJk02d6Wa1Vm+VjHAqmvY4HoKdq4iy/x0P0vvTHSqaaYysH
 798w==
X-Gm-Message-State: AOJu0Yxi61XghWAaZFonExsi0Ee9VOJ/9YXIFBuZ4MQyRWB8vXMXlt+p
 6cYtkLunRWk6wPZELIb3MYhm1+icdcnMdyiJn/jmmu8TBPrLJgrVQO3zOgItP3FjMOvGxIDqycc
 =
X-Gm-Gg: ASbGncvJRX2tfPFFlxncnuPSSOMhIHwjZ43hkhS7ySpOpcpTo00lLVlQTlbf7or3mex
 x4ZX7DTPo+7p806uDR0YBzOiFyzNQq8smxrpsYzGlYqGyXS6EQ7xO7XJ8XVfUWIuUybFiKsVmdM
 0UcC5nsjPSN+kIMk5w6+oLU8fBJdk6tt4yDQAjTv5I0JvrNXMqHuS4lGkaKhLY+VjmecbgpRDhZ
 OYiPI8lVxQD0RzFwyB1h4MjD6hYgOZUzSvH3U0Kj1PrYDi3hd8WDtZeNuzv1iSXvtVTyXjeaEuN
 xfOwsiayK9g9vzR2ZHY6aMrT2zZzBkrnec5W3St9obAM7YO7lVOb/8jvU9PH6DoGOvEWJJ1RbpL
 6Ng==
X-Google-Smtp-Source: AGHT+IG4wRcL8YWZQsGUpKSOW0AwQd4Lt56wf88wN58aQ1AQNs9oPhCMSkWR2utLlr6jTfrNXxWOdg==
X-Received: by 2002:a05:6e02:2787:b0:3d5:8937:f419 with SMTP id
 e9e14a558f8ab-3d97c1ad91cmr13494085ab.13.1746154243017; 
 Thu, 01 May 2025 19:50:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a918039sm166627173.55.2025.05.01.19.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 19:50:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] CI: Update to use the hooks in the U-Boot repo
Date: Thu,  1 May 2025 20:50:19 -0600
Message-ID: <20250502025026.4140184-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502025026.4140184-1-sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
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

Now that the hooks are present, make use of them directly rather than
cloning the separate repo.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml | 15 +++++++--------
 .gitlab-ci.yml       | 16 +++++++---------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index a00ee67f297..bf50727ea55 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -251,13 +251,12 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
-          ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
-          ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
-          ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
+          ln -s conf.qemu_arm64_na test/hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          ln -s u_boot_boardenv_qemu_arm64_na.py test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
+          ln -s travis-ci test/hooks/bin/\`hostname\`
+          ln -s travis-ci test/hooks/py/\`hostname\`
           if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
@@ -307,12 +306,12 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
-          export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
-          export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
+          export PATH=/opt/qemu/bin:test/hooks/bin:\${PATH}
+          export PYTHONPATH=test/hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
           ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
           # the below corresponds to .gitlab-ci.yml "after_script"
-          rm -rf /tmp/uboot-test-hooks /tmp/venv
+          rm -rf /tmp/venv
           EOF
       - task: CopyFiles@2
         displayName: 'Copy test.sh for later usage'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9f69895efd8..ba9ca5fb9e0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -30,15 +30,13 @@ stages:
   rules:
     - when: always
   before_script:
-    # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
-    - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
     # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
     # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
-    - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
-    - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
-    - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
+    - ln -s conf.qemu_arm64_na test/hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    - ln -s u_boot_boardenv_qemu_arm64_na.py test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
+    - ln -s travis-ci test/hooks/bin/`hostname`
+    - ln -s travis-ci test/hooks/py/`hostname`
     - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
@@ -60,7 +58,7 @@ stages:
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
-    - rm -rf /tmp/uboot-test-hooks /tmp/venv
+    - rm -rf /tmp/venv
   script:
     # If we've been asked to use clang only do one configuration.
     - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
@@ -93,8 +91,8 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
-    - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
-      export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
+    - export PATH=/opt/qemu/bin:test/hooks/bin:${PATH};
+      export PYTHONPATH=test/hooks/py/travis-ci;
       ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_EXTRA}
         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
-- 
2.43.0

