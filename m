Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74641C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8951988A82;
	Wed, 17 Jul 2024 16:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="PxFhefU6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqz7KXuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6B988A8A; Wed, 17 Jul 2024 16:30:08 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBBE88A66
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute9.internal (compute9.nyi.internal [10.202.2.228])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 339C21140141;
 Wed, 17 Jul 2024 10:30:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute9.internal (MEProxy); Wed, 17 Jul 2024 10:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226605;
 x=1721313005; bh=sbGJkgx7dPD8rDAljaF6a5HtbfUtqqwBNm1eOSVT+74=; b=
 PxFhefU6z0hl6okeCVNs2j8yxgGkdNhbyoLNoPUA8sGNyZELgiCVGHvozKyNluPu
 aeWUn21PmMyY1eN7a3b8mFoTxYT5JwsoKNbXWTNCgXqYmNh9Y900E3ml1ZRE7DDc
 1D5WtrMrHdlrYRLmRRdbn7yLH2Cp2ktD9aTzrK4j31Z5dBzVyzOxACZ9NFsPZ3dV
 nHmjz4/1V9SQhMDf+Pke0uor3nOkfrYhlHBNeL3ckao+zW3qwUQqsbz7Krslcjp7
 deRKo7f07cFAgQeChWJYc/Wp+LLRneZzBfqPfSHzvrAo4nY8H8c8PzZsRwZ1JHSg
 nEEDzjZooi10dB/RXPGbeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226605; x=
 1721313005; bh=sbGJkgx7dPD8rDAljaF6a5HtbfUtqqwBNm1eOSVT+74=; b=l
 qz7KXuO2/ydbILNzYu5eW6hzzTbj1fmg4XT/SNjJsEu/WeQvcM6s3OzoFntd3ps2
 otTxABR6YUphNGujkCGfSzt5Y1h0iTDIW8ZRhjzAs3NkIHvtvrlHGFQ2rxAC/c/j
 ryg4AN9qxAODvjMmIaY1hsYP6LBkGfb+IjrxbXgtlUZBwQX2zXytLHq3sSx+hglZ
 wmCXwumS1cJhg7cwg5ifR09O6bcF2ZhoueLVxHY/fFL1ULDhEeIjjnhyYsDFqcFZ
 ZR8qj+JtvrYHmlokV7EIpV0zOGUXZ/ZAXRvkqAdqMdXwKcOqvVPmgGcI+DtNepX4
 YVPDH4R1PIG9D0vQUeL8g==
X-ME-Sender: <xms:a9WXZiAXq5qAWH7b9l8zSs3Ko5tV5yHpST53wdFjLbiGXU6hKRzp2Q>
 <xme:a9WXZsi0FeuRI5AhAkcaNdB-9v3ANL9xR2YmEGKV6l2Dic3lrPa_1-RdL--HyxBh2
 o0EgPaAbZtfszoLJlo>
X-ME-Received: <xmr:a9WXZlkBaqipmPFhdfsLdQ3gpp3Uii6yb7DRkP_gC08nCF4lFmp0_BWSrS39PL6PltWN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:a9WXZgz1R6M99pZ7WrFy5HLWHyHv5EPHWh5jDmbCHLzAHSkl0cCGbA>
 <xmx:a9WXZnTiH7cW0Ubtb07E0V-P2PVpgyGelVH4HP7fuzNtz9TerXIvwg>
 <xmx:a9WXZrY_3nk0yV1RZnGUBOd8zD5pBaidRMi4Wu-NGOVtxnL6xC0NkA>
 <xmx:a9WXZgQ2RJND848b-3_dk09eaHGJ-vY_0vH2mEsqZy-V-6cLfnBzAg>
 <xmx:bdWXZgQB9rhF32i1QV9vXg_n-Sc0b3l5lgRjVqOhl6umpPeNu0PdmsgD>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:59 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:19 +0800
Subject: [PATCH 08/18] CI: Ensure pip install is always performed in venv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-8-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5745;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uWV3L8YDkotBE1WM2MARUDr9AGNdZlROvllmb3MW+ZE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV12KV7FnSto3m7WvTtOeqLvpWb+/kmnu0dBM+1dz1
 a6EJx7rKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgJs8ieF/Rs4N9x8Ozawt+VaF
 1SET7F7NKRE++8Y+/cWXydc/L9q7nZHhJ2txvzync6pkxj2D3E3Cb66VWFz2eX03z0kn8O76mzn
 sAA==
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
index 4119ca7ff849..e2346ace3097 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -161,6 +161,8 @@ stages:
       - script: |
           git config --global --add safe.directory $(work_dir)
           export USER=azure
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
           pip install asteval pylint==3.2.3 pyopenssl
@@ -194,7 +196,10 @@ stages:
       image: $(ci_runner_image)
       options: $(container_option)
     steps:
-      - script: make pip
+      - script: |
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
+          make pip
 
   - job: count_built_machines
     displayName: 'Ensure we build all possible machines'
@@ -256,7 +261,11 @@ stages:
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
@@ -280,10 +289,6 @@ stages:
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
@@ -556,7 +561,6 @@ stages:
           # make environment variables available as tests are running inside a container
           export BUILDMAN="${BUILDMAN}"
           git config --global --add safe.directory ${WORK_DIR}
-          pip install -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bdaf5db1da67..b38342117434 100644
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
@@ -103,7 +104,6 @@ build all 32bit ARM platforms:
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -117,7 +117,6 @@ build all 64bit ARM platforms:
     - . /tmp/venv/bin/activate
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
       ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
@@ -215,6 +214,8 @@ Run pylint:
   extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - . /tmp/venv/bin/activate;
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
     - pip install asteval pylint==3.2.3 pyopenssl
@@ -243,6 +244,8 @@ Check for pre-schema tags:
 Check packing of Python tools:
   extends: .testsuites
   script:
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - . /tmp/venv/bin/activate;
     - make pip
 
 # Test sandbox with test.py

-- 
2.45.2

