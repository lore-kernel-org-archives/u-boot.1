Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA38C3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 07:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCBC82998;
	Wed, 14 May 2025 09:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAbgMG+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211DD829E7; Wed, 14 May 2025 09:44:21 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB1181DD6
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso42678005e9.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747208658; x=1747813458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up0cNtdJ+pLQHSwISkr9fZx+t4w57JWUVcSj0n+EWLg=;
 b=FAbgMG+QGYerZlQ2K/TdbP+6NP7dzeQJA2gr7FYebQ3a61/scmDzFO8wgk//wCIa4T
 OzTl/aYMaeOsecUIc86za+zG5dGffrY4kBUNo7Qg3iG6fK0x8dvZIe7NEnQTWH8+/5mO
 o6cd3EL9k2gaLJCQIE1/N20T8PlRTYnAAZbGM0CAHPYr1R7DoZOD6VOq4NIjrEXuVdiZ
 Rdf6e8AGoIlTJWyKZdYFK3i4xjx1oK/gmVHqioTglkjXFpdqMxvPBcCE0sV5uP1RKZWg
 iCDb5kRAkhNT3jvig+zDF4qrdHnzypwbwc+GRX2NEbTAoPiYlON4to9sPHT+eeJ+8oQS
 rBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208658; x=1747813458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up0cNtdJ+pLQHSwISkr9fZx+t4w57JWUVcSj0n+EWLg=;
 b=pPapRSqYKoiMcGCXyTUOYnT+JjFVtnRpSXuJMwdF/obA8T1rygMav9sFs5BwxM0uL9
 PNCxhO8mxkrmBvuxpLmkuRkldPCJFW3BtJPZjP0q9P0NRrUv9OlUie9WD9Dqk0KBNhT3
 fqhGBKFEHvPAV3pxWqBt1QmWb1GnkB6PhKLCFyLyK/4IxG2Y68nTr7pCujxxe3bqEHD5
 4skAfcLc9zNoY3X+C6pFilLC6ENSz93VnMt7nkKBmh2w5oHbT7sOo28OJGH9oIQgRPZp
 G2r1NSsdXs7SJu2LyetO6xcaySvgaD2pkP7Nq1CojJZ9QK+kXxxb3sM3fdMqYKVFJZcn
 1D0w==
X-Gm-Message-State: AOJu0Yz7q5OxdAQmvJOgK7ImMRrmoGbSFlNFF7N2rXLxAPUiI1a5wJut
 u8pYri3aaN5TWv7JzdVwxndXiJCBpB/ULwH9xDYTw5CfBjoHk5axprl2w7AMMWk=
X-Gm-Gg: ASbGncsORx3NiOA1jtUXzjXwBIDonMlhfyMqKDtaMKl0cZZlC9rvleH7y4fABL5UgRn
 9GQO2OZMmOqReyDUWGY4/QkYZPA9PVpbIxZMQ63gIHoAInvGUMhApojciUfYvO3rggPCRHzNW/9
 KHHhtWXRm76OLhbTJGTPRWD15jD2cNpZiw2fSi91lJHpaeY74+uGvkhXJHTohXJE7RqmS982Z2E
 5qy2fhbfYRafsTIHOqZ11S08Z6LC0IvyeVMng8efn8bpSS7KrXH8hMUCDVuTmwOsxgcbJhnOeEr
 5dbhXDNF5xU246kAqxLwZvgEeXGI/34PrAnkjegYyx8kRdCK3mTJHY+AsQlaFg==
X-Google-Smtp-Source: AGHT+IFlvlpGG1g0GNIe1LjJRdO8AJ9H/FMSJEybIwMASOMBGaT2uLsbcIm3jpr/q3w84NDyawnTcA==
X-Received: by 2002:a05:600d:1b:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-442f285460amr19033865e9.17.1747208658355; 
 Wed, 14 May 2025 00:44:18 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db30sm18085895e9.11.2025.05.14.00.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 00:44:18 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/3] CI testing: add http server to CI tests
Date: Wed, 14 May 2025 03:45:11 -0400
Message-ID: <20250514074513.3562063-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250514074513.3562063-1-adriano.cordova@canonical.com>
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
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

v2:
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

