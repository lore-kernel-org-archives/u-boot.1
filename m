Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB34C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 15:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E3882998;
	Fri,  9 May 2025 17:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nK07iWY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A583682998; Fri,  9 May 2025 17:43:09 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7850D8283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-87843c435f3so578321241.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746805386; x=1747410186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kyvf6xwaNLz3m1y6y+DMqpIRfyzJb48AB9/BOCqx2sw=;
 b=nK07iWY5MjBgu+6ZEvFdLCTtGDYeABYNGnrZjGGBZNvmNAbnOxLDjnmUhWElj9UvGF
 FJXGoaOPe08FqZjCUnMZiQrMbDMsQGQPYRMgUHQlgU5LAp+f5pFWRo0HIX9rTFA+Ref6
 ullYVdRw0Q6m4WkjA07ojF3G2tC83RXS0WGZrereug/552sDLduzyVRgmiF1ZB8nhM2X
 K+7FopXjpFIZ23qSDXJj+9PHtvKitYqun0Ity6VDhZ/HQANm0dwzsitKp0F1UpCPER8x
 QN52RkZmbEEjiA0aUZBzT6WF2/19Py3UnVmcO0PFNs+16iSkoJD6bGKc8H7I9f1LwzPc
 zdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805386; x=1747410186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kyvf6xwaNLz3m1y6y+DMqpIRfyzJb48AB9/BOCqx2sw=;
 b=LVcqcHBPK1Oi8wTfv6sEzHd1Ngb0z015IVbLS3puLHOEXgQZ3Qdf5mwTTs4BmrYKur
 iVTQUluVPmRow0YqxnrfeE0CWfys/Hs3RueXSTSuScfKjhQ4NGdh1eTHZNL3+xzj5ATM
 9cXdHemh5oK07KMDC9+PlVKhlx52oMi2Bf3APXPcIiDtaCeMEy19N63GZaY0eyjSrTz6
 yoyM9JJuMYf8HopODg5HubKqgqr/uovn4FrvAvkLBn0b3bhi+2HAhrrPelA1A4RPwMRT
 Z5mBu6mzBB5hRm/W/+qyARyDjsLPMJ0D+Euv+RNSS/z3DPNCRRrOkhgeYtZz8RsoJio4
 0sMw==
X-Gm-Message-State: AOJu0YyExy8NGjpoCoVm45cvmwIkrjEAdCUGWGK4MyYl6NAAsrTnwLQ+
 p/TjEmPJV1nk9fymJGluDfWIPL5fSpecaKMWAAOBTxOVecxM8qegEjajzMru
X-Gm-Gg: ASbGnctSTTgQZvfAkc9eWYlRTaj5+T6GkEytGfvTyEVZ2ihaa980qAyhZuQvaqUDTtZ
 rUTJaRG3+yhg00niO9bX6dm1BZ+DL0jI50MB4YhlhJqbQRanHZRvL7xyWMLI49IbVPaaUAP4TcF
 3S5cT43WK0yqJMorpxa4pjLNpfRBIHZAqoxnizifFRDIFbf61m2P5LeLnjIOJ8I98q3t5F1BvwY
 9oMtw1FFgVPGXUR7bmSrSOoUVtDegkCfuzyADXsUK1lMSsWfcInkcJbC5Kt0MzXVY07VKrIJpBf
 S4MBfWlvJuwuF0NUaFA27DCwqTBCY5C+gyNs1tzn4bY/CzqEWgAb
X-Google-Smtp-Source: AGHT+IGYw3Kboi3XH46h60q1d/RUhjweAu6TmSz2qKVFbzqDFRrheiBFyspvFd13DYGsU7RgoI1qGQ==
X-Received: by 2002:a67:e704:0:b0:4de:b205:dd55 with SMTP id
 ada2fe7eead31-4deed3d2fb7mr3187081137.18.1746805386263; 
 Fri, 09 May 2025 08:43:06 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:9366:b0c8:336a:d2c7])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4deb203c1d4sm1303285137.28.2025.05.09.08.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:43:05 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/3] CI testing: add http server to CI tests
Date: Fri,  9 May 2025 11:43:50 -0400
Message-ID: <20250509154352.3483523-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509154352.3483523-1-adriano.cordova@canonical.com>
References: <20250509154352.3483523-1-adriano.cordova@canonical.com>
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
 .azure-pipelines.yml | 14 +++++++++++++-
 .gitlab-ci.yml       | 14 +++++++++++++-
 test/py/conftest.py  |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 5e1938b0526..ba31727aec1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -316,9 +316,21 @@ stages:
           fi
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
+          python3 -m http.server 80 --directory "\${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
+          HTTP_PID=\$!
+          sleep 1  # Give the server a moment to start
+          if ps -p \${HTTP_PID} > /dev/null; then
+            export HTTP_PID
+            export HTTP_SERVER="--httpserver localhost:80"
+          else
+            unset HTTP_PID
+          fi
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
-          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
+          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_EXTRA} \${HTTP_SERVER} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
           # the below corresponds to .gitlab-ci.yml "after_script"
+          if [[ -n "\${HTTP_PID}" ]]; then
+            kill \${HTTP_PID};
+          fi
           rm -rf /tmp/uboot-test-hooks /tmp/venv
           EOF
       - task: CopyFiles@2
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f11331514b..aeb54262883 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -106,10 +106,22 @@ stages:
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
-      ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_EXTRA}
+      python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
+      HTTP_PID=$!
+      sleep 1  # Give the server a moment to start
+      if ps -p ${HTTP_PID} > /dev/null; then
+        export HTTP_PID
+        export HTTP_SERVER="--httpserver localhost:80"
+      else
+        unset HTTP_PID
+      fi
+      ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_PY_EXTRA} ${HTTP_SERVER}
         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
         --junitxml=/tmp/${TEST_PY_BD}/results.xml
+      if [[ -n "${HTTP_PID}" ]]; then
+        kill ${HTTP_PID};
+      fi
   artifacts:
     when: always
     paths:
diff --git a/test/py/conftest.py b/test/py/conftest.py
index 5aea85647af..fbf67acecc3 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -89,6 +89,8 @@ def pytest_addoption(parser):
     parser.addoption('--gdbserver', default=None,
         help='Run sandbox under gdbserver. The argument is the channel '+
         'over which gdbserver should communicate, e.g. localhost:1234')
+    parser.addoption('--httpserver', default=None,
+        help='Address of http server, e.g. localhost:80')
     parser.addoption('--role', help='U-Boot board role (for Labgrid-sjg)')
     parser.addoption('--use-running-system', default=False, action='store_true',
         help="Assume that U-Boot is ready and don't wait for a prompt")
@@ -267,6 +269,8 @@ def pytest_configure(config):
         persistent_data_dir = build_dir + '/persistent-data'
     mkdir_p(persistent_data_dir)
 
+    httpserver = config.getoption('httpserver')
+
     gdbserver = config.getoption('gdbserver')
     if gdbserver and not board_type.startswith('sandbox'):
         raise Exception('--gdbserver only supported with sandbox targets')
@@ -330,6 +334,7 @@ def pytest_configure(config):
     ubconfig.board_type_extra = board_type_extra
     ubconfig.board_identity = board_identity
     ubconfig.gdbserver = gdbserver
+    ubconfig.httpserver = httpserver
     ubconfig.use_running_system = config.getoption('use_running_system')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
     ubconfig.connection_ok = True
-- 
2.48.1

