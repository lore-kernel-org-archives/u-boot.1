Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD46BD1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475B48904B;
	Wed, 16 Oct 2024 12:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XHE4DjeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09A389024; Wed, 16 Oct 2024 12:05:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394D088D1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43118c9a955so54055355e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073113; x=1729677913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlEGcCckJebs0pW6biLF/S5mvNiFVZJ9cWiuKYi7FxI=;
 b=XHE4DjeG1lv/H/QM0yQ5HLCHE/u3dR1YJP4/Bb+uiLUZ8P1qOgwjOGz4045s6zciJx
 cUT+TF+8x0Rg7mPZv8jKWoKdkLoW1U7jsCeU4dpIzyUEYNrIloIiQtWt6J04CjUHHKCL
 7YYtT7h90yPlO21KmdNCapPOKIokNnfd0j5JGYTjTcu9yNaYjlsDJGNUn+rd9EbzAITW
 tbXOoVwCqb+3JkxlrH3i0bg5nfLSwZQfbJG+ZohO1fxyW8FPtmVeHKDlPnvHlfOPGmz8
 2Hle+3o3gvKsX4VBTLtrN5GJs23IBfyxyAW5jWE6G8jjYY6Tr/Q/kErEm/j0m3VZdmB7
 FF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073113; x=1729677913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlEGcCckJebs0pW6biLF/S5mvNiFVZJ9cWiuKYi7FxI=;
 b=r8J7xi2maHqIFLdkTdJImiWbNIgGqmY3FUYN9AVYnfTA1udedc87++BtY8BoPLO8Nh
 RaThJa/ag0ZlUcCU84ZjlcVW6Xm0pIUlIxLXZhCIT4vhf6sg4BuS55NXMN6JXI33sNZf
 1SVCA2W0d5gjKZFzxvvISc4EnVCVBpm7N0jhEZ/XQ6NFpxI72Zt4q4XtY6ydefxM8pV5
 hbeUCi0dbTBP5/NStSGJ1Pdguid+gKKVhNi8zT4zF8TsPivl1buLip6C4019AVhlUJIU
 wH6ElvxQ8/EpO2ZmyroAMKDJ97AvQ6SCPqzaoeyKMrXGQi8iyPPFUQmSofZx/qXpMOC4
 4Liw==
X-Gm-Message-State: AOJu0YwlUCBAa/Jn27jD5JRp9ANes0Prg6Dfg/FaBlIt+hzXUoLK0JbB
 hnC3WWUfzINlEOg2QL8VQRBkM8DH+g0WheSalZgiZkyPei5/IZ4PEAVoHsLTaYiqLNbbTiRn9ZT
 hQ+vHTETK
X-Google-Smtp-Source: AGHT+IHQNNqeu8RR25giJvK8aeuchxtCZafD4JS/672qWdpLyo9whNOsc7ND+0p3y1WB1xOtA1EWqQ==
X-Received: by 2002:a05:600c:1f0e:b0:42f:8515:e47d with SMTP id
 5b1f17b1804b1-4311ded2340mr154723725e9.11.1729073113512; 
 Wed, 16 Oct 2024 03:05:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:13 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v13 20/21] CI: add qemu_arm64_lwip to the test matrix
Date: Wed, 16 Oct 2024 12:04:14 +0200
Message-Id: <9d0144a953860094bec5f1278b5dd9b1c85245b2.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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
index 11f1d5ad20a..813640df92c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -239,6 +239,10 @@ stages:
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
@@ -419,6 +423,9 @@ stages:
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
index d938c7f31d6..d89657e28b3 100644
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
@@ -348,6 +351,12 @@ qemu_arm64 test.py:
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

