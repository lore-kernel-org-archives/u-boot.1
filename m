Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E8FCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66013892F3;
	Wed, 23 Oct 2024 15:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YhrstFHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0809689371; Wed, 23 Oct 2024 15:29:55 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8DF89268
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so5240420f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690179; x=1730294979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
 b=YhrstFHstAGk3pK4Y0EbiOF9tj0XjEoBPXoECE2Jt3asDqZrMjtgNv3TC0Wh+xq0Nd
 LNUk7lWPu0Y+VUyhQ/v4eQ5KmVB3+OzMVvbztxO/Hd4DFBuoDjc3tbO+ZlLswdYrE5Yl
 Fv5da30BgIJhE42uUMPvmU9n87aVMq5C3AvSO4YmLE10vw/ajHGRR4IQ7wa0YgQfn0Aj
 EjA5kUkfdP03vjiAkppIqWYUR73wFtd+bhBMcTqEHFKf5pyKiQwzIn6YT0r8eRBy58xu
 k2a9mQJFxL9Br4220xRjNPDHDtXyNhforcKLUd34ZyVPg8GzxRxCunLvCE2exEAlYVo7
 Hh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690179; x=1730294979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jczdy1uYsb+aLC4nuD27CRmDy+gWKtf6hf+GXkt4V8A=;
 b=voDZKarDrRak8xMIJF1c7SvCNBGqFuOuHy8nLCWn7PhXoSPzHEQs+hL4pg9eUws9sT
 orlYcVglI8KKwhnCN6G/D6NY5v0ow/AMXzMUcDsH+TU9+wtDTKgv5h87FXyrgElz875j
 VvNdLfHHmXPWA17W1MVffBpgjzRxqmZXUgighnyq3OdoZirZcUfYVg/wcEJ0NMxHlZQy
 eazciK3ptWutOvn7Xglb8F1pgQmmyM9EXZFVUDy9SgKP5bqc7Uk5eAsbO9ZOAO7uvdrl
 i4Q1owIrKgI+up6UHPhrc/BzeZUAc4ApHSf9MKkb12njcW0pZfTxCg8f5X2mJUoudua4
 +AgA==
X-Gm-Message-State: AOJu0YynQ7W2NkJldSP40SQQ2ijtqTY/fk3meYtbZ9uHy+phO0FDLBlr
 d9ZuxSY5ViZxoRao/0XHiRptpOXEWr+lNcODdQ36TpvExFOsWRbUmeyeuogmRqK/IIfsx1s6fO3
 p
X-Google-Smtp-Source: AGHT+IFUqU/EvSrylcLUMy85TyHY6P+SYtEyI99ANylHUxztqJY+8JJeUGCIdnHZ3eWk6gwTjrEX3w==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id
 ffacd0b85a97d-37efcf1fc01mr1687911f8f.25.1729690179249; 
 Wed, 23 Oct 2024 06:29:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 37/37] CI: Enable qemu_sbsa
Date: Wed, 23 Oct 2024 15:20:20 +0200
Message-ID: <20241023132116.970117-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

