Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B14C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D3A805D7;
	Wed,  5 Feb 2025 01:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UE5/zEOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A265F805FF; Wed,  5 Feb 2025 01:08:07 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FDE805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5fa2a2bdde9so1484662eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714074; x=1739318874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vebo8AhPu/boSR9pjmbK5WuLKDzcXcCvOq6MAyETF78=;
 b=UE5/zEOnK525wXm/TGIoAu1hsQGTRQXwo2kFmu3rHdzclDXEyrVuAtUjJ7w/d3EfCv
 auSPpY3cUK08OiYt6jImNxsD9q9gJxgoqF26bDlcdh1FOQxkCg1CMC8nSIF9fy1Fl129
 aWN7KzQCla/pkSdOzd4qUSiUm8Tnqm8gy2eG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714074; x=1739318874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vebo8AhPu/boSR9pjmbK5WuLKDzcXcCvOq6MAyETF78=;
 b=O/gf0dxSk6GPNuvtBAvTIkQhVjdwOsj61mfLHkg8iIv6FR9qrEV3MCkWo1/PvxRhxc
 sQnaTQ4fc4x7pVAWCabw9UU5NpZZpKSSF+KYB6XxBL8jsZAOv9aOETmZxPBfcpKo+dCl
 ags7Fw+wJk1DLdTw1zMfK7pzuwF3J9F4muS6wa5EH1dzYocodMVij3D6lw32psRFb+dE
 KfPdU+BHmfadpeXhkEy0IpnHer0CsrInEQk6NFc5acAOh8w46lAh2TBQVMJWnz0oZEQT
 EQN0V7OOUBSqPAnDsYT9q1UcPAmMdPQFBoVsXzR+vyOv5PnqT0fbn/MJX5/NfPqtravQ
 X0Uw==
X-Gm-Message-State: AOJu0YxlS9kyaRjzHP9TzmqdfflB9MQLp6IOC2AYE9A+ECMzN+dcqK+P
 i0yX8+EmpnbDKLqkSm+tF6sETxm9ZkmBUMrXAT6i76NgKp/KAtVUgoaLeH7+K379mrD8VXlrvN+
 Rbfw=
X-Gm-Gg: ASbGnct2L3BKO6mUho4f+SxZ8UWCR5XCaVQMmuRm8D7MTr7rUmbWc2ayO1nN8HoTfb8
 bZa8iHJnyzl560pvGK11u2RR9UkRzBcgCcJsRhybUW/CmX7eHKaOuC6jFk+qAWi+cbyC9j3tzI4
 kKAIcsQFO8jYBFezMeqHZQLBvrim6PYIMPwNVQjWO2IxccGh3piFxGJ/6SmoL2zw3Z7hl/Ot9Jm
 i9y8umUUOVlfNT9c+f8KEpiHlp42myKsXWhxOx7gcrBy8+IrKfKTwDolXZyAL4WnsmfR+HvRJsp
 U7nRI4e/3T257A3q6g==
X-Google-Smtp-Source: AGHT+IENdrjpzZer1LOGnbchGBSXIdgvx1C13RwYDrac+qbDpVoHi86bpTIbsx5yErgrYhYwaLrbwg==
X-Received: by 2002:a05:6820:4cc8:b0:5f3:4175:1d7f with SMTP id
 006d021491bc7-5fc47a5eab4mr562188eaf.8.1738714074111; 
 Tue, 04 Feb 2025 16:07:54 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/6] CI: Invoke pip once rather than multiple times
Date: Tue,  4 Feb 2025 17:12:07 -0600
Message-ID: <20250205000743.949790-5-trini@konsulko.com>
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

We can invoke pip once to install the various requirements.txt files
that we need rather than invoking the tool multiple times.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 36 ++++++++++++++++++------------------
 .gitlab-ci.yml       | 27 ++++++++++-----------------
 2 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3e464375b260..9fc9c4e74fd0 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -133,11 +133,11 @@ stages:
           export USER=azure
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
-          pip install -r test/py/requirements.txt
-          pip install -r tools/binman/requirements.txt
-          pip install -r tools/buildman/requirements.txt
-          pip install -r tools/patman/requirements.txt
-          pip install -r tools/u_boot_pylib/requirements.txt
+          pip install -r test/py/requirements.txt \
+            -r tools/binman/requirements.txt \
+            -r tools/buildman/requirements.txt \
+            -r tools/patman/requirements.txt \
+            -r tools/u_boot_pylib/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
@@ -167,12 +167,12 @@ stages:
           export USER=azure
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
-          pip install -r test/py/requirements.txt
-          pip install -r tools/binman/requirements.txt
-          pip install -r tools/buildman/requirements.txt
-          pip install -r tools/patman/requirements.txt
-          pip install -r tools/u_boot_pylib/requirements.txt
-          pip install asteval pylint==2.12.2 pyopenssl
+          pip install -r test/py/requirements.txt \
+            -r tools/binman/requirements.txt \
+            -r tools/buildman/requirements.txt \
+            -r tools/patman/requirements.txt \
+            -r tools/u_boot_pylib/requirements.txt \
+            asteval pylint==2.12.2 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
           echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
@@ -274,11 +274,11 @@ stages:
           fi
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
-          pip install -r tools/binman/requirements.txt
-          pip install -r tools/buildman/requirements.txt
-          pip install -r test/py/requirements.txt
-          pip install -r tools/u_boot_pylib/requirements.txt
-          pip install pytest-azurepipelines
+          pip install -r tools/binman/requirements.txt \
+            -r tools/buildman/requirements.txt \
+            -r test/py/requirements.txt \
+            -r tools/u_boot_pylib/requirements.txt \
+            pytest-azurepipelines
           tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
           cp /opt/grub/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
           cp /opt/grub/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
@@ -593,8 +593,8 @@ stages:
           git config --global --add safe.directory ${WORK_DIR}
           virtualenv -p /usr/bin/python3 /tmp/venv
           . /tmp/venv/bin/activate
-          pip install -r tools/binman/requirements.txt
-          pip install -r tools/buildman/requirements.txt
+          pip install -r tools/binman/requirements.txt \
+            -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0308d6d70dfe..dfb8dffc71ec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -58,10 +58,8 @@ stages:
     # Prepare python environment
     - virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
-      pip install -r test/py/requirements.txt;
-      pip install -r tools/binman/requirements.txt;
-      pip install -r tools/buildman/requirements.txt;
-      pip install -r tools/u_boot_pylib/requirements.txt;
+      pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
+        -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -127,8 +125,8 @@ build all platforms in a single job:
     # Prepare python environment
     - virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
-      pip install -r tools/binman/requirements.txt;
-      pip install -r tools/buildman/requirements.txt
+      pip install -r tools/binman/requirements.txt
+        -r tools/buildman/requirements.txt
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
@@ -187,11 +185,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       export USER=gitlab;
       virtualenv -p /usr/bin/python3 /tmp/venv;
       . /tmp/venv/bin/activate;
-      pip install -r test/py/requirements.txt;
-      pip install -r tools/binman/requirements.txt;
-      pip install -r tools/buildman/requirements.txt;
-      pip install -r tools/patman/requirements.txt;
-      pip install -r tools/u_boot_pylib/requirements.txt;
+      pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
+        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/u_boot_pylib/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
       export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
       export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
@@ -212,12 +208,9 @@ Run pylint:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
-    - pip install -r test/py/requirements.txt
-    - pip install -r tools/binman/requirements.txt
-    - pip install -r tools/buildman/requirements.txt
-    - pip install -r tools/patman/requirements.txt
-    - pip install -r tools/u_boot_pylib/requirements.txt
-    - pip install asteval pylint==2.12.2 pyopenssl
+    - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
+        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/u_boot_pylib/requirements.txt asteval pylint==2.12.2 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
     - echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
-- 
2.43.0

