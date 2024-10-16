Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F9D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21B088DE6;
	Wed, 16 Oct 2024 08:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DZYkD+Bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2546E88F6B; Wed, 16 Oct 2024 08:13:49 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21BC88EEA
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso3986654e87.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059226; x=1729664026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
 b=DZYkD+Bbm6JP98xUgon9bwrAbCI5z+o0cxl5pWewgWRl3rHw8981lhsXbvk8+iJugF
 KahiKymBwPcg1E+cnUAxEIaWpbCUkB+U1I80HJqQSvmcMv0MoQicdumy+536gxTt9Knc
 UqDHXD0n5swBhccqFxnEvDob63RtZATb8ca8YyyHbF6k/oR95K0RE4XW0sIvmuPAqSaI
 W0DpOoJNY3zhiPDfu+DEvF+VXyPb5Ccf6pmSvIWM2PD+alsGrHQgAgS9IvJQGYIbJ/0v
 4VFXr6/NQvj+ygjmiz+NNOc1PQUPPIIm2IwgqNU4Sja3jB9+QP677o0WACGyNkJTCYfK
 QekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059226; x=1729664026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
 b=c5BBGdm9W+vDqcUMNBdW8zUk+gr2gBpdoeI87sEUL6nEV7uDenpyTH8xUoHJXGlJDo
 dpVKlM/W1iih6dS0z1XAmvoZDB8cfrwCgZFnviDkSncuEQN1fLnEcB0KWuh7ia2XOxdc
 lfdGISK00h+cvS+tnpp3S46KqSuRPRM++VaMpuUgbPh1B6+artbKgqG1I1/ToVcfhuIL
 Lo3G153JdfnblMO6WOJXSh4v/IIJYt1HOXMp5nyQiviEzhPQJ4O479eiCB0aoiE1C74r
 qsYqrrUWqBOeuJuwuHVHVMLsjJMUiGoYF7moTY7Zes+ETT/8tgFeU6PJ7e7uoYGZjhVj
 g9wQ==
X-Gm-Message-State: AOJu0Yx198ROCqxaaWVAxQry1i5TY+kAoku55pXHOEn/gtQtlha4xdbI
 x8/6IYoADj6hZfCKn/L+KxMvL8+vGHdXHjvjYZlylVr1yEzQsp1aQ7xPZDQ1hSQuTHvt6+aWjcU
 t
X-Google-Smtp-Source: AGHT+IG5g5UDW5Yoyp//orz1P16SZTujxiLgwSoYbPC0qZH5PygE4wzKt9VFBXJTS3UOQcJOev/6gw==
X-Received: by 2002:a05:6512:1383:b0:536:581c:9d9f with SMTP id
 2adb3069b0e04-53a03f2d5b5mr1679641e87.24.1729059226053; 
 Tue, 15 Oct 2024 23:13:46 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:45 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 37/37] CI: Enable qemu_sbsa
Date: Wed, 16 Oct 2024 08:04:23 +0200
Message-ID: <20241016060523.888804-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests on it.
TEST: Run on Azure pipelines and confirmed that tests succeed.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changelog v6:
- Add gitlab CI support
---
 .azure-pipelines.yml |  8 ++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb612..2881851ecf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -250,6 +250,11 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
+          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+              export BINMAN_INDIRS=/tmp
+          fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
@@ -415,6 +420,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_sbsa_ref:
+          TEST_PY_BD: "qemu-arm-sbsa"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b8..3f02a492d5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,6 +39,11 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
+    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+        wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+        wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+        export BINMAN_INDIRS=/tmp
+      fi
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -344,6 +349,12 @@ qemu_arm64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm_sbsa test.py:
+  variables:
+    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.46.2

