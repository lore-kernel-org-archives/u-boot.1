Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F85C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB598294C;
	Fri, 16 May 2025 10:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRbK/19H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A37A803DF; Fri, 16 May 2025 10:52:27 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CDE803DF
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a20257c815so1642723f8f.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747385541; x=1747990341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDyUJZ5J82JTpHRiFA+sW6bnbWCN0lHI9dF2+6mKu1w=;
 b=gRbK/19HUn4pFh/UqDkwQQElSwv9r6xkgPsQTkfio2zuovsCeF9c34QK78tPwv2AOG
 h4VVM6eANW0eLQt+uV/mXC4P5925E0y0I2pfQKOOSnMapygsdMFFZQSzY6ZJL7XPn0Zh
 C4d24Q8xkdWwrbEwtx6lFbZPdA55RxSPci19oLJ93XyR/BFskTUPIct0iuLA/kEtbvS8
 2bcN4KN2ZE1r6JMIswomEOaKlxUo7Q07r3eoFcrhmZiEWTr93C40RYSugfrBGqP1gfIR
 vSEb+zt34mHcIm4uH4xNrWE7VJcQdK96pDxTIhUpgstulkftt5RBTx3W+83FCjEOfFhj
 s6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747385541; x=1747990341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDyUJZ5J82JTpHRiFA+sW6bnbWCN0lHI9dF2+6mKu1w=;
 b=aleikxpTWdXZsTKc3/WVQXXRKaIvoJMWTXJP8ShgWr5MfbeSxJglf90wsBhQgATU1S
 yr9P0SK3XuOlbgeAPLvzn3Wk3uRZukOZQ39adnNUuo3Gew/LIKSwL83jV2qZUQ+to4X6
 oisHBXh+1qJalMmycprID1jJDm9hdZSmMLIN301UFDBj76gRl/kGwY2ojF3GfWUPc4x6
 wlZC+qP+Q9n1V/u2/K1IwxwBIEtk4RYFWklwQIcyIWl7DRjyqiVcZvoKq51UZXhQCcUI
 R/K7tVcnamVMj9VrmbbNU8Ws591qnln5wzLKo4WHho75I0j/PRw7cgHNfzhJ/ws9s7TR
 V7zw==
X-Gm-Message-State: AOJu0YyIZ2uAfabovkRvSLopwOoh43pr+WmWjitW5AIjlVraGQcaCN5c
 9HvgOPGKi6n0emySRSo16wPD7c7NH24UXYciYd50mjzU3doESFm3ZGpb3lPu386iiyA=
X-Gm-Gg: ASbGncsXoLEiUekbBjHzF3FJW82r3GEg/IZaoA4P6Tg/S0wVN/owt/deOqMo1IvVHlG
 Y6rKt11xBWSYrNEbO0khTJjX9eQSJgKzzbeWUHCSsrC47u0pcdfbIlZumxPKUk9hvI3B66wSmR3
 X4/f+gxnI+QIkKXUsP8ZTurQPIJa4n9QHl3vlg8Xwmm0uuCiW+lnaEG0KldV2wVKz7gBXDUZlyR
 fmFthMFL3By3sgmR8ODuxCDgoQogVmhkRD9nV3Ob5nr/UbWnNW5sagAyiFi7IVyDibXTsVjGbKZ
 wKzUJHoBN3wvgl4fef4IpCq3Hbnqf2PXlacM1yda23n74T1AES9v4ZoTmJjxQQ==
X-Google-Smtp-Source: AGHT+IH+5+mTdz+UfjFZrnOqi7Hij46wV1JmjgHcV4dm5kapKmwSVSezaVZJhimvKfVsb8n8tlYzLQ==
X-Received: by 2002:a05:6000:178c:b0:39c:30cd:352c with SMTP id
 ffacd0b85a97d-3a35fe5c5c4mr1419085f8f.8.1747385541302; 
 Fri, 16 May 2025 01:52:21 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef81csm96801125e9.34.2025.05.16.01.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:52:20 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v4 1/2] CI testing: add http server to CI tests
Date: Fri, 16 May 2025 04:52:55 -0400
Message-ID: <20250516085256.30386-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516085256.30386-1-adriano.cordova@canonical.com>
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

changes in v2:
  - Remove HTTP_SERVER argument for test.py

changes in v4:
  - Remove comment in .gitlab-ci.yml that was preventing
    parsing

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
index 7aadd5d8b73..88f7861656e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -106,10 +106,21 @@ stages:
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
+      python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}" > /dev/null 2>&1 &
+      HTTP_PID=$!
+      sleep 1
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

