Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5B5C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAC5807E0;
	Wed,  5 Feb 2025 01:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AKg/6HH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79641807E0; Wed,  5 Feb 2025 01:08:05 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77068805FF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7231e2ac9e4so1803461a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714074; x=1739318874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saL/jJYDPqN5nmXxpMBed1tUv0EP9jBdSqS3fEhWOc4=;
 b=AKg/6HH0dss1Teq47Z4zzf+XLPtECBY0wEpMs7X2BwOGaOMztQDQOJf5OiArbx8e7v
 7MCDxRgHp+Jsd/zphzXqNMWVyjzHeFEedApLHApHacGZhGjYMHTCwIQh5MwSidshueLX
 q5vfPKkCXRX+FJDPgMhpUcBjF59kfUJUhyQZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714074; x=1739318874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saL/jJYDPqN5nmXxpMBed1tUv0EP9jBdSqS3fEhWOc4=;
 b=HZxqq0YZvsmJKHVq8u2a2fjTIceHX5fveLhqjCeTYYPlAh1PfUGYXPaBEe0i1X7g5z
 uceogwMDFzyDflScar4f/xY/4ciesPPDdR8tdsoMg6EFKrSqyEEBvA5T9xVHtyKZLXtL
 +a1eIwhmgL2erpmRk0S3H/gN2MFDFGGgpXMSTqDeclJVeXFEI8ptcQDhLRkigVg4GPt1
 Vrf5pvyGjT8OYvIywYdttcPJyAcjdqf1TBkP4r1fscOexVaQtPhSaLfvw3jdtUQk+BkI
 acgn/2dfR70+R27B3Zm+sZv0CvNGvADY7W/9T86EmjFZsk3Z0pvCRnwRnZrTzC1EqDaE
 Q0Sw==
X-Gm-Message-State: AOJu0Yw4kaM+JL2DHs50momKeKhAX8LGVeaQIBdze23u/B/0711UsmtP
 TQoA4gtcxM7QedXkLL365WlCcAwFPDqL3mPWpawi/W0f5lz52ogePBPr7HBCGXmvoRwFFu5CMzZ
 buf0=
X-Gm-Gg: ASbGncu5ugrr+hK3XEgSqNKd/k2Vu+W4J0Vza8T0zI73o/vr5AHTGxN0rznb6NXlHaZ
 6c7YwQtfBSb0UdlpG2FsIhSz6KyE/60wN0nUz3aJDK6XZ0f/cavjGPUnIzJZvImfqrRn486BzKS
 ZSKkzgqUYT+soVNT3ANU6FDJztOTF6DYbVswpQVL+UVZNxwtp4EFJHoeBO/GzYIZRue1aCpI2qu
 WcZUatSzV7r+IGsfprgPzJDv9Fnj+ok4XLQT/Jgk2kvukOpv7aNBuUOofc+1zPSDR1jKhdjfTzg
 ghkTfZJkZ+YRmq/Pbg==
X-Google-Smtp-Source: AGHT+IFK4LHIplQz0+0roUmantzChDaytCX/A+DgqGQlVDiOhDvqE+Va3AM3cnelSSFgg1nW/1QQHA==
X-Received: by 2002:a05:6830:6213:b0:71d:f068:1ff3 with SMTP id
 46e09a7af769-726a41749b7mr847992a34.8.1738714072591; 
 Tue, 04 Feb 2025 16:07:52 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/6] CI: Consistently install our requirements.txt files
Date: Tue,  4 Feb 2025 17:12:06 -0600
Message-ID: <20250205000743.949790-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000743.949790-1-trini@konsulko.com>
References: <20250205000743.949790-1-trini@konsulko.com>
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

We should install all of our requirements.txt files after starting the
virtualenv rather than ad-hoc throughout each test.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 13 +++++++++++--
 .gitlab-ci.yml       | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 00a78be89441..3e464375b260 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -134,7 +134,10 @@ stages:
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
+          pip install -r tools/binman/requirements.txt
           pip install -r tools/buildman/requirements.txt
+          pip install -r tools/patman/requirements.txt
+          pip install -r tools/u_boot_pylib/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
@@ -165,7 +168,10 @@ stages:
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
+          pip install -r tools/binman/requirements.txt
           pip install -r tools/buildman/requirements.txt
+          pip install -r tools/patman/requirements.txt
+          pip install -r tools/u_boot_pylib/requirements.txt
           pip install asteval pylint==2.12.2 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
@@ -268,7 +274,11 @@ stages:
           fi
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
+          pip install -r tools/binman/requirements.txt
           pip install -r tools/buildman/requirements.txt
+          pip install -r test/py/requirements.txt
+          pip install -r tools/u_boot_pylib/requirements.txt
+          pip install pytest-azurepipelines
           tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
           cp /opt/grub/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
           cp /opt/grub/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
@@ -292,8 +302,6 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
-          pip install -r test/py/requirements.txt
-          pip install pytest-azurepipelines
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
@@ -585,6 +593,7 @@ stages:
           git config --global --add safe.directory ${WORK_DIR}
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
+          pip install -r tools/binman/requirements.txt
           pip install -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9f68c440245d..0308d6d70dfe 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -58,6 +58,10 @@ stages:
     # Prepare python environment
     - virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
+      pip install -r test/py/requirements.txt;
+      pip install -r tools/binman/requirements.txt;
+      pip install -r tools/buildman/requirements.txt;
+      pip install -r tools/u_boot_pylib/requirements.txt;
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -93,7 +97,6 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
-    - pip install -r test/py/requirements.txt
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
@@ -124,9 +127,10 @@ build all platforms in a single job:
     # Prepare python environment
     - virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
+      pip install -r tools/binman/requirements.txt;
+      pip install -r tools/buildman/requirements.txt
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -184,7 +188,10 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt;
+      pip install -r tools/binman/requirements.txt;
       pip install -r tools/buildman/requirements.txt;
+      pip install -r tools/patman/requirements.txt;
+      pip install -r tools/u_boot_pylib/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
       export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
       export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
@@ -206,7 +213,10 @@ Run pylint:
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt
+    - pip install -r tools/binman/requirements.txt
     - pip install -r tools/buildman/requirements.txt
+    - pip install -r tools/patman/requirements.txt
+    - pip install -r tools/u_boot_pylib/requirements.txt
     - pip install asteval pylint==2.12.2 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
-- 
2.43.0

