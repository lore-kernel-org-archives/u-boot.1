Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E851C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B66887E4;
	Tue, 11 Jun 2024 23:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="UD5A9zab";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocZjo2Ck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FB48839F; Tue, 11 Jun 2024 23:04:51 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF383887F0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id E26051C0017A;
 Tue, 11 Jun 2024 17:04:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139886;
 x=1718226286; bh=zD2t0L8nDZgUMr54YtVnoS/8AcpYNQM85ZfscD9QwMU=; b=
 UD5A9zabvo3mCdgG9NZV0OziMMvI/DuunRT2lf+X/ot+eqT7Wp87BfHUPaTDwhFw
 edFF6Y7iyntkwY7enzgNDqj1Jol85bOQzXPV775g8Zx30b0vIHhQUT2bQ6+Xdmv1
 7KrBNXxq496ibadbMGT+YUmdFHOkUazWhtN9wXagAk+DUHZXmaufl2d0bngC0DD+
 IhVhwRWrKT5E8OTdsZU/w8MZrU18+XOK70LxjC0PoVWjqcBu7oW5KcGvPMbrA29U
 QULHB59xXdGR3mjpOILPpJoQANLbyieMvcG+AVKZXjLPbw5bY1+lZU8d58maOrI/
 0nqJO4fYsJx06iV16T9wkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139886; x=
 1718226286; bh=zD2t0L8nDZgUMr54YtVnoS/8AcpYNQM85ZfscD9QwMU=; b=o
 cZjo2Ck/T5k1k0XA/Tym/cBYkQ9gS2E3mN8qZ1k5cB+eC/CJglKIB7DIpI+sdCwP
 VECbT+8Oa8eOj2huDUU2yi3Y5YY+i5/xq8CKt9HqrVW1JFPswRMjwJdBtPVhwTd3
 /yn1hiGrBQhdBOA85b8aH+9cZth+G0iGYTG0tQFYcCsvRpLyJtZnyqKptmn8l1N8
 JWQrpz33SZ2bnvtR5hs7bGzY61fjuQcQa8C/INk5+SrA0eWrT9S6urcd/9FJgyM0
 yEMWWEyVzJzmKQ+0NByMGfCn0Mczb2eJT/JvmguqBsv0NpF7QEAClb22VFZqc+jp
 AKXh1VuhmCBB0PIK8Qk5A==
X-ME-Sender: <xms:7rtoZkQC0XaEl8zCzFQe8dQ2UhB6P2kprH03jR6Yf9PvOQcpTqlxug>
 <xme:7rtoZhwrrbUzn0cxLDQ1jUPvGhBk6k5NJDYuCJtGr9DKtT0qmUnEJS-dKhbSyoafe
 HUovaFWW9FPgZdP5pM>
X-ME-Received: <xmr:7rtoZh3bpuylIFODSqX51D_tpCjiwmRlTV9l9sBL0BJhRR9naGOmSwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:7rtoZoDFhhUSoP1B3ZplsxXt_ODYEx8Go1YT83xTI0VnCgYIyZLPOg>
 <xmx:7rtoZtjbFo6YlWaM2KOpuNoGxN-D-Yc4pJ4xNVZC78oT2InCLSRQsw>
 <xmx:7rtoZkpHRoWPT8p8-eZwhJHsPgH-7Pfi3QSsWe8u58fxMVB9EW8S9w>
 <xmx:7rtoZghozjloTZZex5-bsfpReySTDYKq7kFoh2ptQ7J1aly3WkmoYA>
 <xmx:7rtoZuXE5sQEe_b2LzrGT5rQ-TBoZ5tsBUKytS2F5475ou8RzirmfM7j>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:45 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:12 +0100
Subject: [PATCH 13/20] CI: Ensure pip install is always performed in venv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-13-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5760;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Z7C1oOqfxaURV+iVQ1g+yR1KQr9XOr45megnKEND8As=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WdZNJiaRJXvXJlddL1O7/25L9eT3wdUPSi+sVSI1
 /xnRPXZjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIeRojw+ZPMmv8ecO+3bqx
 82XR2pqmzpeKa2VC44TdsmWiZ25Mm8bwP+9F2fvOI6sFk38tdt3GsNehdPftRSWuz32eR6SsVRX
 R5wIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Since Ubuntu focal it's nolonger permitted to perform global
pip install.

Ensure that pip install is always performed in venv.
For buildman alone, all dependencies are already in docker
so there is no need to perform pip install.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .azure-pipelines.yml | 16 ++++++++++------
 .gitlab-ci.yml       | 13 ++++++++-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 37b569b13ab0..2506814725e1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -150,6 +150,8 @@ stages:
       - script: |
           git config --global --add safe.directory $(work_dir)
           export USER=azure
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
           pip install asteval pylint==3.2.3 pyopenssl
@@ -183,7 +185,10 @@ stages:
       image: $(ci_runner_image)
       options: $(container_option)
     steps:
-      - script: make pip
+      - script: |
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
+          make pip
 
   - job: create_test_py_wrapper_script
     displayName: 'Create and stage a wrapper for test.py runs'
@@ -217,7 +222,11 @@ stages:
           if [ -n "\${BUILD_ENV}" ]; then
               export \${BUILD_ENV};
           fi
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r tools/buildman/requirements.txt
+          pip install -r test/py/requirements.txt
+          pip install pytest-azurepipelines
           tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
           cp ~/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
           cp ~/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
@@ -241,10 +250,6 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
-          virtualenv -p /usr/bin/python3 /tmp/venv
-          . /tmp/venv/bin/activate
-          pip install -r test/py/requirements.txt
-          pip install pytest-azurepipelines
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
@@ -504,7 +509,6 @@ stages:
           # make environment variables available as tests are running inside a container
           export BUILDMAN="${BUILDMAN}"
           git config --global --add safe.directory ${WORK_DIR}
-          pip install -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 18c4c430c63d..4c17abea468a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -50,6 +50,10 @@ stages:
     - if [ -n "${BUILD_ENV}" ]; then
         export ${BUILD_ENV};
       fi
+    - virtualenv -p /usr/bin/python3 /tmp/venv
+    - . /tmp/venv/bin/activate
+    - pip install -r tools/buildman/requirements.txt
+    - pip install -r test/py/requirements.txt
     - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
         --board ${TEST_PY_BD} ${OVERRIDE}
     - cp ~/grub_x86.efi $UBOOT_TRAVIS_BUILD_DIR/
@@ -74,9 +78,6 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
-    - virtualenv -p /usr/bin/python3 /tmp/venv
-    - . /tmp/venv/bin/activate
-    - pip install -r test/py/requirements.txt
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
@@ -100,7 +101,6 @@ build all 32bit ARM platforms:
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -114,7 +114,6 @@ build all 64bit ARM platforms:
     - . /tmp/venv/bin/activate
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -212,6 +211,8 @@ Run pylint:
   extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - . /tmp/venv/bin/activate;
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
     - pip install asteval pylint==3.2.3 pyopenssl
@@ -240,6 +241,8 @@ Check for pre-schema tags:
 Check packing of Python tools:
   extends: .testsuites
   script:
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - . /tmp/venv/bin/activate;
     - make pip
 
 # Test sandbox with test.py

-- 
2.43.0

