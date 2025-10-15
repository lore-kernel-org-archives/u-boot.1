Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD37BCCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728A9833F6;
	Wed, 15 Oct 2025 16:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YVi7efi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDDC800D7; Wed, 15 Oct 2025 16:19:38 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6F98362A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8738c6fdbe8so16996626d6.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537974; x=1761142774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCkL0lc+us3NSDSTLvaeN6k9bJC6cb24IbGg/eTLizs=;
 b=YVi7efi+ehcPi9iOSQngSi/lzNl1sj5UrtmUorbKSJRJIfBWfLF7kYsPufebrYGgZt
 /F4cgULDOgEEwCdE0nGFsB85VIEKMNk/O6XZCOg5ARKM60q72DGVVyQBBjJgAHTAObRh
 FHlFifldpHfii1qiccfdytwliAJhYV9YYSCaCz930rROwkJ5f1c8l4tlFseNg+Go3/xz
 p3AD/8RzwPiHW/F6ZCavDMSOadxT5aPdwQaQuYffpchhplJZ8J7NIokDZv6f7J4q22/s
 fe2zUe6wUecL/wVtVvSVSYzLQymkEBb5lBI2Daik7iX7jv5M6LZ7uYGX2VtvfhojLSSu
 +e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537974; x=1761142774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCkL0lc+us3NSDSTLvaeN6k9bJC6cb24IbGg/eTLizs=;
 b=oAR+pqpHvHnePg/9aROcOCO9oOAAt7BJv4ydbx3PuHxQhaSXCahzE1dy/SVdpBYF00
 VIBfNCzrrFu5bcpEzT/s1sKJUwc0jAx/zFcXv/7r4GNO/2E2BzipR3alm8kwKWzcR/8S
 Hsh5qG9AWHwtX2ezh5nFg9HrUT8RnYxXXSDpxGWLt31uiqTJwirKfLyNd8Wnb0tUnf5j
 1l7/ElF7C6CSOj1ULzAHPml6rLI9mPEZZm6HBoD2ey+bVQuNhu97FO59Ta8zKIo81PNf
 IeCGkU+/vZpiIYlNZY9aQzmC8Hgah4ZeF2Amfcc5TAWwfrCl9ucT1pS98vtP0yuV8IHB
 y2eQ==
X-Gm-Message-State: AOJu0YyPni716WufwwVENDS8SIsaoPcQjlJShVwphaYCsI92xlOy4/Zy
 M0mnOrSU7lJMHCd1TbB+LlmjtplEYOgXudg6Jswe8E6MUwyKHW5PuBGMsPZ8juEpGK9Snnqodib
 9lfbT
X-Gm-Gg: ASbGncsayu368eDsLcmYPLOHAAI8OwXFxcE/xsmYk7/Ph3QLW4/H7bXl8b6K/kG44+Q
 DCgUWJYeRipS6+Ew2TomPi2c6pxSj+k7xOGJIlWXRXs2W3g3Bl8eIA0UY8y9HWtnjP12gg3LDx3
 J2YSj9p9DiRF2S8WlAE1mT5AEcdWySSLxPm7rUEaBTAOBv8pf9sitWvLwWq56y7m8Y+n2dU1Rvf
 LxyHSc1xcn8J/iqOa4eTHgK0R1u2V4SqJ59w8J3x2VC1e5ndaHrB3zRcF/QJVxAVFTckmrGd8wa
 Yo/XEP7gN1ptUDFlGB+KMAvqv/1xl3bXw69Is1rwBlADUt+Z7RL3BTN3BkCNeV06+V6AsuVRLoV
 OBxOeFzfvOBdkorgjXAdmgZ/WgqM4lgolaAUnMcCKSBkOqZAPQ2ZBYfNd9NYyPlt8BEaFTsTL2Z
 zrnRM=
X-Google-Smtp-Source: AGHT+IGc/dSyTW81zJcweO5/FyAcP+KMZ4ouneJUtGBoUz2bxzRlleVnCjL5HRJMOdA7ZHgSgHENmw==
X-Received: by 2002:a05:6214:1bcd:b0:878:c0e4:9b42 with SMTP id
 6a1803df08f44-87c0c1e97e3mr4915856d6.0.1760537974294; 
 Wed, 15 Oct 2025 07:19:34 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:33 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 4/6] ci: check existence of bl1 and fip in the test script
Date: Wed, 15 Oct 2025 07:18:48 -0700
Message-Id: <20251015141856.4168612-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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

Check the existence of bl1 and fip from:
1. /opt/tf-a/${board_type}_${board_ident}, if not exist, then;
2. /opt/tf-a/${board_type}

This change allows to test with TF-A with specified board ID only.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Initial patch.
Changes in v3:
- None.
Changes in V4:
- None.

 .azure-pipelines.yml | 14 ++++++++++++--
 .gitlab-ci.yml       | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 8209d2b329c..1382e4f6475 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -308,8 +308,18 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
           # If we have TF-A binaries, we need to use them.
-          if [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
-            cp /opt/tf-a/"\${TEST_PY_BD}"/fip.bin /opt/tf-a/"\${TEST_PY_BD}"/bl1.bin /tmp;
+          tfa_dir=""
+          rm -f /tmp/fip.bin
+          rm -f /tmp/bl1.bin
+          if [[ -d /opt/tf-a/"\${TEST_PY_BD}\${TEST_PY_ID//--id /_}" ]]; then
+            tfa_dir="/opt/tf-a/\${TEST_PY_BD}\${TEST_PY_ID//--id /_}";
+          elif [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
+            tfa_dir="/opt/tf-a/\${TEST_PY_BD}";
+          fi
+          if [[ -n "\$tfa_dir" ]]; then
+            cp "\$tfa_dir"/fip.bin "\$tfa_dir"/bl1.bin /tmp/;
+          fi
+          if [ -f /tmp/fip.bin ] && [ -f /tmp/bl1.bin ]; then
             export fip=/tmp/fip.bin;
             export bl1=/tmp/bl1.bin;
             export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:\${PATH};
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 85401d3e09b..224485a2e64 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -97,8 +97,18 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
     # If we have TF-A binaries, we need to use them.
-    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
-        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
+    - tfa_dir=""
+    - rm -f /tmp/fip.bin
+    - rm -f /tmp/bl1.bin
+    - if [[ -d /opt/tf-a/"${TEST_PY_BD}${TEST_PY_ID//--id /_}" ]]; then
+        tfa_dir="/opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_}";
+      elif [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
+        tfa_dir="/opt/tf-a/${TEST_PY_BD}";
+      fi
+    - if [[ -n "$tfa_dir" ]]; then
+        cp "$tfa_dir"/fip.bin "$tfa_dir"/bl1.bin /tmp/;
+      fi
+    - if [ -f /tmp/fip.bin ] && [ -f /tmp/bl1.bin ]; then
         export fip=/tmp/fip.bin;
         export bl1=/tmp/bl1.bin;
         export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
-- 
2.25.1

