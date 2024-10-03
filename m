Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD4CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FB888EF8;
	Thu,  3 Oct 2024 17:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wC9oPP7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E9888F65; Thu,  3 Oct 2024 17:47:35 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4BA88E7A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cd8a5aac9so709273f8f.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970452; x=1728575252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=wC9oPP7W654EgF92w53jOfNWTbxfssbU4FGH5nA2hdwbzq+f3NIJNHhtvJa3iHbUqW
 k90Z5WShD2RzWvpdhawe4yfhIT2KnLpXPbz0hQZ+lziO11elDiJQwxSdXFGBf/v+Kwlz
 bES8R8Ohb1OVjSl7SLDmfG5vG8Og9aL6ldBU8OkdTxraf70YleA2S1nAuHR5eTgJS3Kq
 zPlMEZtvHwCEJj5UOzupjkVrf0oKLLIPwVEHjRecviTdkzWTumYhTnxcrNHbDPhwCZ4r
 j0dVdUEoS163QTD/dA8mfgkPXSfW3lJ96tI1Wv++DCE+RMW7VkdnFLWfwxYJkZFA5pg4
 AB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970452; x=1728575252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=ONZD3LMyf6kQkJle7c752mwfmG6t8WrIveAAW+WHI0NLon9o2Bg9SA0m8t1aOKM21D
 sYNss7rpwCTmfmVaJKXKtUNogtdiDv9kcLGLQC+JgKYjtbnW4grlHjgvwb1hwla75n0C
 rh1j7fx9KyZLlKcvrezCfOKIuiTdFtGznf6A/OmENRigs2YR/X031mORwP4xvCQqD1pc
 kLQ38DkwTQPoZf9F52vP2Cs3g1WI688s30UyA0DrudpvyPhl3Ih9k00NbhZCB0e7O6C5
 0Xe1NiUr9VAh6Tr4ZaC0BNn+7/PhikrcEsI3BKpmNUQTqGJpmZGHTtqpR6QgW0Ty0Mev
 yd/w==
X-Gm-Message-State: AOJu0Yyyi9+J6tfpL/vEht074RwdxxSERX4MhpFTzbxZgh/TIZ/wlKLK
 t9wplMKncz0U8v7medHx1DWWupQ1tDDNW7WVEInyFsuWpgjRQFFL8eOTn2g0QrnnOIKNK+qqz+4
 fqAja3sBn
X-Google-Smtp-Source: AGHT+IEoFUeewcJsM8zD7qhRG+f7oAOEdR+zcsmCFmjJE4gwLaOTLMsBi778x+Lxa7lueuGLiI2+6A==
X-Received: by 2002:adf:a152:0:b0:37c:d179:2f77 with SMTP id
 ffacd0b85a97d-37cfb8a48fdmr4977874f8f.12.1727970452319; 
 Thu, 03 Oct 2024 08:47:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v11 25/29] CI: add qemu_arm64_lwip to the test matrix
Date: Thu,  3 Oct 2024 17:46:29 +0200
Message-Id: <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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
-- 
2.40.1

