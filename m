Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D5BCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0A5845CE;
	Fri, 10 Oct 2025 16:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gi7hLOiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7318445C; Fri, 10 Oct 2025 16:46:02 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEA984258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-84827ef386aso156239485a.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107558; x=1760712358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pi2vOrjgXZ/Uz052v47BlCEoEEjA0glAZ1NehYGNBIY=;
 b=gi7hLOiYU/q3BNXJ0y8XeBKmDgpJOArimGXnjm9qgQuhAtghqqepqMA6iA48I+k/Z+
 HXKPkA9/RUNtJ2aq49o+suRIi9ENDztW3Qr5tEM6WPkbY3WWjyhgXYqtwKZWxo52km2m
 JGwAMGSn1gbR+O8RBujSp6AaYPLe1q0JwsRra48WrZ3BbfmoMuXQQc9dEzxewMAvuULP
 OagmghiX2O3XFWNbORlGVRLnJdDy1GzLTIEQh8Nt4RvQhJWw1ZV8aXZKz7MZdjoe89FA
 OhXT9gfxGDK9M9vPGbXqpBrBLnA275/h3kuKRdUVZmF0WYZdZx6Um513226eDkRM5sV0
 Tc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107558; x=1760712358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pi2vOrjgXZ/Uz052v47BlCEoEEjA0glAZ1NehYGNBIY=;
 b=u98MAkBzX7H9o/DuPgyHZ2O86AAh2lgI1yYx5c/f57C6heGS4cRRGYZ6vtG3IV6myp
 So3demRSe64V1PrffAJWwE7gtj2PzDOiohcla+XdzqVlN7YyZSAt7Ck86ItDH7VPI6zt
 zra5Lt6NKY41gkq5cuk9Q0yzwmWMleHjiYm/7zf+oVMkGGR0CodwG+l3jDthsgVmpu28
 7jO075aS9hi+NvLVk0ojtTeQjt1IsHrStBtkyD6tzuCq89tm+qIxNNOZs0POHPxxeICr
 qMkew535oGbA8hm5rek55Fb3jbG54a0UhdLKS6+Cokfxhl+nEVjUFtSdy1+eyfM+LXDD
 qk1w==
X-Gm-Message-State: AOJu0YwhlP5Eh5aHFhpZYnYp10+NX8Q/OFZZn3EFdSffvw2a9U4jxRG5
 US3VyZBx3qaDtPJ8Y7RK7EAJfOlx6hpLAOAFP3s2sVxNqRJ11lxfq+lbU/6Tq9AGxxkwbhNDJiD
 9LPXb
X-Gm-Gg: ASbGnctk45ytmj8mKy8muOC5P0tMzxY2l1hKtaEuqKdSaO+cUyvrNegSn0jPYxNjabj
 daHA1f0aLv+WDr2iZ8cU/oUowkkQL4kXUt9XUv0ReNjEJTYtPbf76uvvE5sb730p4n5jhWkF0f5
 tSW5YItLIE4wY2SEOTBkf2zoQzqEV8gh1/CcM0tlOjz8/fU6J8ZbC+nInRsnMArXZnBIWNGsEGR
 968HiP1KNTA0gy9IPaoOJIojM564hyzQFPgsB+32z8mDOpT4M2TsQ4GBnMw/8JfzX7ZAeRRl5a4
 jVP7jgKHabx/1ovINbRk3jpZNAV+16gBQJr3RdRBHWkXKTMB49IC9/SrdxB/zvcc3277K4m3fPU
 6qBKUGexVHLeDaWRyIfCWK7kG3qD6a9MPK0c2BoiBDR/bsv5UG+22yUNfAV3sBUVnRhwYRMn+3l
 a3QRE=
X-Google-Smtp-Source: AGHT+IGuFFyEcSYxbb1hPx2t3dUkeGIt0al0DKAzFK3OOyzT7kH6KcG9+y7UNq575tJB22ZUdzYloA==
X-Received: by 2002:ad4:5cab:0:b0:87a:c4f:a0c1 with SMTP id
 6a1803df08f44-87b2ef7ab13mr165873606d6.67.1760107558385; 
 Fri, 10 Oct 2025 07:45:58 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:45:57 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 4/6] ci: check existence of bl1 and fip in the test script
Date: Fri, 10 Oct 2025 07:45:08 -0700
Message-Id: <20251010144517.3573014-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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

