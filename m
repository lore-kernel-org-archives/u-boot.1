Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44727CEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AD989201;
	Wed,  9 Oct 2024 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vrgY7VN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A781D88FDC; Wed,  9 Oct 2024 16:50:44 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DFB89196
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cd3419937so4115451f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485441; x=1729090241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs+yhZLDcEnZCnwF3YpI3cLUrJdd91oYLeUL+cw9hM8=;
 b=vrgY7VN7vnk6W2mRHsD9+Xh/TtCraTQFOgqd56QxtoiCAldVfseu+965DlYLfuTFpx
 65tuEbUVml0ff2oFTaBEKUlgcwHMP5IUUGnE1dW1eqRfeZDl92if3ISSdszbBiX4rWdD
 Pq+hIooNE41FJQ22A1j1ecCOf0AGeIKy3SGpHP1ksEmYYB/vMWdq2ybqxcY0Y3aDcjSC
 tMjhK4xQ+2HIKolvFN9BDlA04AzDKc2LIASGF3CMTkBNucWgicq9dURAWgmliCc97RUd
 xJG7IYQjemnDycCUJ0G+sAPYVv05dTKM0Q3h2W8xYwlHHbbXYKqJzlwyYrzC5T7pBZ3M
 2iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485441; x=1729090241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vs+yhZLDcEnZCnwF3YpI3cLUrJdd91oYLeUL+cw9hM8=;
 b=gg+XrYFMpBlczS+cI+qcQnsbK2PKwb22z7MH8jObP1zCNPJX5EbPsNqgNgn7hquCt6
 1/bsXwsQmkgetGrs4hVr+S6kUJtgJ0bZKurPnnlv2Bf/2bZIcQU3uruZ17TBs6uLCTvH
 Ojarqy47nh/nt/DD6eTn4/HfUp+nxALbQHsaIUXaIMqoDxe13KZNYeFbS/6oP0DSz02R
 JFh3l0AyiIKuUN0ont/8sXZY2votWum7FaBIb1SbwMiUPBF4utiPIwoYBnUPfnoaFXc4
 7E3mMWQCtCRf4Fz8jFf/3wqkqf7p6gjFVvg8s80MlweBRSFuL78qLdr4ZfCma+1bxjiG
 1B3A==
X-Gm-Message-State: AOJu0YwYlupnuebN5dycl0zZVHAO92w3cdStSkeyYFMkRi50wm2Fg/hy
 A+e045EYdpnYix3dmS7QKefQaqvEG3oYl+cb3A5exDDBwyun4Xb5sREjs0Zsv38TbF+N7nowgBB
 VGnwZEUjm
X-Google-Smtp-Source: AGHT+IGHK5Ek+3k5+dqff2seIFkKUxCO2UhyH3qEiwIk1E34YYOjsuP7k9R+2FbZ7o/dlD4oSQLrgA==
X-Received: by 2002:a5d:4e51:0:b0:37c:d4a4:3c2 with SMTP id
 ffacd0b85a97d-37d3ab182b2mr1609555f8f.49.1728485441333; 
 Wed, 09 Oct 2024 07:50:41 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v12 20/21] CI: add qemu_arm64_lwip to the test matrix
Date: Wed,  9 Oct 2024 16:50:01 +0200
Message-Id: <bc31c78b4004566d1d7b4b3950dd0e4d696d539e.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

Build and run qemu_arm64_lwip_defconfig in CI. This tests the lightweight
IP (lwIP) implementation of the dhcp, tftpboot and ping commands.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 .azure-pipelines.yml | 7 +++++++
 .gitlab-ci.yml       | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb6127..59fddb96a48 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -238,6 +238,10 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
+          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
+          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
@@ -415,6 +419,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm64_lwip:
+          TEST_PY_BD: "qemu_arm64_lwip"
+          TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b85..700f3fe3a5f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,9 @@ stages:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+    # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
+    # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
+    - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
     - grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
@@ -344,6 +347,12 @@ qemu_arm64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm64_lwip test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64_lwip"
+    TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.40.1

