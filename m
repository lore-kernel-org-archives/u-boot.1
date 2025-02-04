Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89552C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FE380711;
	Wed,  5 Feb 2025 01:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JinKaDsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C00880040; Wed,  5 Feb 2025 01:07:53 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1B980AE3
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5fc447b03f2so186973eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714071; x=1739318871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5zAwaLKsgAgUcZL0/j/qpY15Q9XtdBcI9KpG29gQmpM=;
 b=JinKaDsK63rWrA1aWAxadFB5iXJyLkhpQD/T92VDfXNIjGBCE+paJucYBAsENkndZ+
 1wcaKx14VvTIIyEirKEMt95/hcuQ+FgIp96Br0qYh17Y4duTUnBMGNqc4aUiWdsJj8qa
 S6FvGlNFwGSzmCx0UhQuzhhZ47QGPSn3h1wfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714071; x=1739318871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zAwaLKsgAgUcZL0/j/qpY15Q9XtdBcI9KpG29gQmpM=;
 b=qyxnaR5KxuEBVOpWmKBAbBpcB7KSJQwPJfmDrF2Osct083BIlZZ+VyHRobEj4+AzNo
 4kjCPka/4BVRzL0PeXNG40+5Np2mffiniozlZIwO3Asa/FjC66Tez+MOVzb6rqkBtRHf
 9hPKrK6NtcZdree9Ii4cxY/c1/l8od3GWIl0F8Atavyiu7FNN5+OliiZUXAbMkY3WlZ7
 mHgqUtZdaAiLni43XOcHf4lpbCOt5MQ8n9ZuBzdlLfjDO8ZIc7LsAf/tHMmiNYFOyLPN
 IEm7rxaV7tAoOpyREY+jeVoT3oqGSfIGPXtJ5r5uCzG4REEv+dLl/cTAAsyLnyi1Z8Nk
 n0dw==
X-Gm-Message-State: AOJu0YzoSDw2CHEmkCjtOhVZZyRf+fwUOcFvfzNFs7aoFDQa4oEOcfSG
 nxshETBiqnComI3tlgydf/wj0cnR/T30CuIZj1y9cdjkEvypEtanXYviaTJXHN1mBdvk2wGIAGn
 IZH0=
X-Gm-Gg: ASbGncsNUGbfqNcEohifPR4/OYKzGnovEzK1fdvJsoVRaXrD/4QQ07Dm8s/yIjqhIL8
 mc1/8ubmf4pVYLMBNDk24daAGy0nqBH/QruTagWXi40R1XtpHjXR3bcaDsHnq9xYJ99Uel5Iqbz
 KevRBTDriVIHSvpVL/joZBFRFRsSycDYWQ8GVSNXC9X/aP7Lhr9ufv3ONPUKTPbTQ8LevSQaixR
 jl4Hb58A8rayPHw5CT05FY5rmlOSD8i6pCBl6rfJ4GHr16vwk2oVH/8ZuNuBRRLHOmZbz/TpZ4H
 r4Udjw2xOeualWwe6Q==
X-Google-Smtp-Source: AGHT+IFp396b8+Ipvl65WuFX3Gq8VWBQ3yREzjW+H039j/wzerpbBGOsBV46pjLANTgh7uN8YyJd4g==
X-Received: by 2002:a4a:e90a:0:b0:5fa:671e:afb3 with SMTP id
 006d021491bc7-5fc479b40afmr705281eaf.1.1738714071062; 
 Tue, 04 Feb 2025 16:07:51 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/6] CI: Be consistent in creating and starting our virtualenv
Date: Tue,  4 Feb 2025 17:12:05 -0600
Message-ID: <20250205000743.949790-3-trini@konsulko.com>
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

Before we invoke pip we should always have first created and started our
virtualenv. This was done most of the time, but not always.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml |  8 ++++++--
 .gitlab-ci.yml       | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index db471e67107c..00a78be89441 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -162,6 +162,8 @@ stages:
       - script: |
           git config --global --add safe.directory $(work_dir)
           export USER=azure
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
           pip install asteval pylint==2.12.2 pyopenssl
@@ -264,6 +266,8 @@ stages:
           if [ -n "\${BUILD_ENV}" ]; then
               export \${BUILD_ENV};
           fi
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r tools/buildman/requirements.txt
           tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
           cp /opt/grub/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
@@ -288,8 +292,6 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
-          virtualenv -p /usr/bin/python3 /tmp/venv
-          . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt
           pip install pytest-azurepipelines
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
@@ -581,6 +583,8 @@ stages:
           # make environment variables available as tests are running inside a container
           export BUILDMAN="${BUILDMAN}"
           git config --global --add safe.directory ${WORK_DIR}
+          virtualenv -p /usr/bin/python3 /tmp/venv
+          . /tmp/venv/bin/activate
           pip install -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8f386a896a71..9f68c440245d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -55,6 +55,9 @@ stages:
         wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
         export BINMAN_INDIRS=/tmp;
       fi
+    # Prepare python environment
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+      . /tmp/venv/bin/activate;
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -90,8 +93,6 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
-    - virtualenv -p /usr/bin/python3 /tmp/venv
-    - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
@@ -120,6 +121,9 @@ build all platforms in a single job:
   tags:
     - ${HOST}
   script:
+    # Prepare python environment
+    - virtualenv -p /usr/bin/python3 /tmp/venv;
+      . /tmp/venv/bin/activate;
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       pip install -r tools/buildman/requirements.txt;
@@ -199,6 +203,8 @@ Run pylint:
   extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
+    - virtualenv -p /usr/bin/python3 /tmp/venv
+    - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
     - pip install asteval pylint==2.12.2 pyopenssl
-- 
2.43.0

