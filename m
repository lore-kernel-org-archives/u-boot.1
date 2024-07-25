Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53898C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E0F884F4;
	Thu, 25 Jul 2024 14:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DAqlHDDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7575488406; Thu, 25 Jul 2024 14:59:13 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16CA288363
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36844375001so499598f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912348; x=1722517148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TWzcWquaQI7xooWzlskMPHnuATZZ70zkpWtFzdSzOE=;
 b=DAqlHDDb2Hn6OQJosfPgsHpyaOx3r2/0gTUML6vxJ1G1ujSrHSl7ZB/OWro2vHAxj9
 6t6vKPNgaY/9jFpN9gN5T1hr9CNQASpURQtKfskqtF+Pt2YjgT1OIi8ubCZTmxRPNXdr
 C9BghdySEY0apYy86E3MFzD0OEajpeVb07NElkL8mCc9XQtg2VBz8ioNCqCM7oFVClYe
 OnzAtlC7TZvRdT7UIjkg/T15zOrWtFtFhuR6PZBBikPBztHQaSrR7keRL3cvX1J3XL8b
 YigfmZItg/0HE1jyzpI6oVrUsusSprNUX6wwQidolr7WG4jEVh1hBjIIfOI3ewFkuD1f
 99eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912348; x=1722517148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TWzcWquaQI7xooWzlskMPHnuATZZ70zkpWtFzdSzOE=;
 b=Hwdgig6baA9n8DP5i9oLGxz4Dk2uKrhMQipOUWA8jp5J7BWmtBjqJqKxY7BRpYz1KY
 ObhCl/WeFYaemd2Qu0cBYCQNKpELK5usefA5CPKLutkX0lNsHj80PzC0Vxh6V7TDmE7F
 yihIBWO5G6Mc2u5k8ktzSRqfrH7Bp8pUhErK8qGN8E1Av5eoOfNuRTOWszhk8VW7QON7
 P5YsckaPj/NP4zrwLBwB9Wsc0JwHdK32TQfwHYiF7ACNu0x47RvGERf1XqJCtf1emrKG
 judVdAeBcAoa3MrxIHsNPP4U30/pa76at48tRKhd5PTlggdS3ZvkBzlRg7o5fUMGC4at
 Rw+Q==
X-Gm-Message-State: AOJu0YzGKsuWjpdBz8FakVoBoVgLGCybXJOS9Ekek4hfuYAjO0+G0L7d
 0l7+E7+2c2gE0mdqEG3OfHZPwa529FxaG40H+fspipWHUQx+FTegL7iStbiZ+gSFOju+vlpg1Jj
 Lkq2Vsg==
X-Google-Smtp-Source: AGHT+IG/Z3R4hnBrrMS82AR+b40rUYaKo2BavbtE1m3K1CwRKSzZfJfusMdCAZmLOj0JHPVC68zwTA==
X-Received: by 2002:a5d:484a:0:b0:368:7adc:fbf9 with SMTP id
 ffacd0b85a97d-36b319e6962mr1769356f8f.21.1721912348435; 
 Thu, 25 Jul 2024 05:59:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 19/20] CI: add qemu_arm64_lwip to the test matrix
Date: Thu, 25 Jul 2024 14:57:40 +0200
Message-Id: <e908973103f8509d7954eb524f1e478b1af9e875.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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
 1 file changed, 7 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c43bb51066a..7f91f204676 100644
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
@@ -410,6 +414,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm64_lwip:
+          TEST_PY_BD: "qemu_arm64_lwip"
+          TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
-- 
2.40.1

