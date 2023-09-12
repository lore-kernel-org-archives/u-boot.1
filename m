Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D9ACA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00D186CEF;
	Tue, 12 Sep 2023 13:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FqH1QGpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C48786CD1; Tue, 12 Sep 2023 13:00:32 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBE286CD1
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 13:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ad749473baso171370566b.1
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694516429; x=1695121229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I+EomSmKUNdLO9eQDKCmEkAOQWbY5zaxdIwDt1vlpZw=;
 b=FqH1QGpWKncjrQC8hLC1WKvOOo2XnUdfoaq7TxLMgweL3qdlJzFgd+4Zltocnldp0j
 OPJ6inVhIpMLd59OeR1Nw6d6UfWKFOmmJkea7NKnICxTUiqAleLoZsmy4dEb9WFseRT5
 g6JlyFInS6+Gk+uWKtjtRBukuKiYJ1Tz7/IhZXPHvF8MwHIUw5mvpDaukeEM8nClgPsb
 Ttm1/M8ZzVQfvKm8RGuEDO/ryiA5IIB8+djIOyhReapgXR5Mxs7XH6GnPZbdQgGzYNJV
 xpEINKBNycLAXs0gl/9UGmDqle1cW2PB7gADfxAvwAtPl9pB/hv5WusV8CHQz3Le+IHm
 nGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694516429; x=1695121229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+EomSmKUNdLO9eQDKCmEkAOQWbY5zaxdIwDt1vlpZw=;
 b=tHXX5Fc1iKD2lsuwPVehbrDqngPl8VXwt9i2xgj7sGasW5VoN1QOnE9YdQQkwbckE1
 aFrz6Jw5uZIi6+FFLUl2fKVmXEnzKawvAz+ROjEr1rGleQqLw7JzJCXc0dzwVMGClybD
 RJYv74eiHx/9BD+zTlquBF/dfTRoGsOLhMlIiXtzeiozHfaCiMkjKslGqJjCflAoHRbn
 RkAJWR87hnGYiTOf/u7jpIBnAokjbe9YQvoeSE23V9pgfbLV8v63mh+ch0D9bNW6WeAb
 atYWIeyVCNFlOnOEaC1LZ3TtagVPHe5lHwD7opZbQ+3DBKVAgYcnFToB2nV3aXt83Rx5
 6UAQ==
X-Gm-Message-State: AOJu0YzaZE0eQql60mJh5ba1EBqP4NHhFnS77PUR46GiirIppaXglZMF
 APbbcUa7eKZfkb2A3BT5Fr5f2CB3I7vVSw==
X-Google-Smtp-Source: AGHT+IE4Pvb3D3mg2dybMMHCwpJYtLjoXKcltl5eLqwMz4XbNOQQ9l0q9MBS1Y1SkNscgt4BmuWq2g==
X-Received: by 2002:a17:907:62a6:b0:9a2:232f:6f79 with SMTP id
 nd38-20020a17090762a600b009a2232f6f79mr11815203ejc.25.1694516428446; 
 Tue, 12 Sep 2023 04:00:28 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 sa30-20020a1709076d1e00b009ad75d318ffsm1573852ejc.17.2023.09.12.04.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 04:00:27 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1] CI: allow jobs to be run in merge requests
Date: Tue, 12 Sep 2023 13:00:22 +0200
Message-Id: <20230912110022.28420-1-andrejs.cainikovs@toradex.com>
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

Out-of-tree users could run an out-of-tree CI with limited coverage,
however it is convenient to be able to run the upstream CI from time
to time. To enable that we would need to change job rules to be able
to run on any GitLab event. Excerpt from GitLab documentation:

> Jobs with no rules default to except: merge_requests

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 .gitlab-ci.yml | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1df13261c2d..a080bd32c64 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,6 +21,8 @@ stages:
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
   retry: 2 # QEMU may be too slow, etc.
+  rules:
+    - when: always
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
@@ -93,8 +95,13 @@ stages:
       - "*.css"
     expire_in: 1 week
 
-build all 32bit ARM platforms:
+.world_build:
   stage: world build
+  rules:
+    - when: always
+
+build all 32bit ARM platforms:
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -106,7 +113,7 @@ build all 32bit ARM platforms:
       fi;
 
 build all 64bit ARM platforms:
-  stage: world build
+  extends: .world_build
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
@@ -120,7 +127,7 @@ build all 64bit ARM platforms:
       fi;
 
 build all PowerPC platforms:
-  stage: world build
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -131,7 +138,7 @@ build all PowerPC platforms:
       fi;
 
 build all other platforms:
-  stage: world build
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -141,8 +148,13 @@ build all other platforms:
         exit $ret;
       fi;
 
-check for new CONFIG symbols outside Kconfig:
+.testsuites:
   stage: testsuites
+  rules:
+    - when: always
+
+check for new CONFIG symbols outside Kconfig:
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     # If grep succeeds and finds a match the test fails as we should
@@ -154,13 +166,13 @@ check for new CONFIG symbols outside Kconfig:
 # QA jobs for code analytics
 # static code analysis with cppcheck (we can add --enable=all later)
 cppcheck:
-  stage: testsuites
+  extends: .testsuites
   script:
     - cppcheck -j$(nproc) --force --quiet --inline-suppr .
 
 # search for TODO within source tree
 grep TODO/FIXME/HACK:
-  stage: testsuites
+  extends: .testsuites
   script:
     - grep -r TODO .
     - grep -r FIXME .
@@ -169,7 +181,7 @@ grep TODO/FIXME/HACK:
 
 # build documentation
 docs:
-  stage: testsuites
+  extends: .testsuites
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
@@ -179,30 +191,30 @@ docs:
 
 # some statistics about the code base
 sloccount:
-  stage: testsuites
+  extends: .testsuites
   script:
     - sloccount .
 
 # ensure all configs have MAINTAINERS entries
 Check for configs without MAINTAINERS entry:
-  stage: testsuites
+  extends: .testsuites
   script:
     - ./tools/buildman/buildman --maintainer-check || exit 0
 
 # Ensure host tools build
 Build tools-only:
-  stage: testsuites
+  extends: .testsuites
   script:
     - make tools-only_config tools-only -j$(nproc)
 
 # Ensure env tools build
 Build envtools:
-  stage: testsuites
+  extends: .testsuites
   script:
     - make tools-only_config envtools -j$(nproc)
 
 Run binman, buildman, dtoc, Kconfig and patman testsuites:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global user.name "GitLab CI Runner";
       git config --global user.email trini@konsulko.com;
@@ -226,7 +238,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       make testconfig
 
 Run tests for Nokia RX-51 (aka N900):
-  stage: testsuites
+  extends: .testsuites
   script:
     - mkdir nokia_rx51_tmp;
       ln -s /opt/nokia/u-boot-gen-combined nokia_rx51_tmp/;
@@ -240,7 +252,7 @@ Run tests for Nokia RX-51 (aka N900):
 
 # Check for any pylint regressions
 Run pylint:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
@@ -260,7 +272,7 @@ Run pylint:
 
 # Check for pre-schema driver model tags
 Check for pre-schema tags:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}";
     # If grep succeeds and finds a match the test fails as we should
@@ -269,7 +281,7 @@ Check for pre-schema tags:
 
 # Check we can package the Python tools
 Check packing of Python tools:
-  stage: testsuites
+  extends: .testsuites
   script:
     - make pip
 
-- 
2.34.1

