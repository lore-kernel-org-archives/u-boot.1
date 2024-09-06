Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E94CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDAEE88D52;
	Fri,  6 Sep 2024 14:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BCItFVbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631EA88D47; Fri,  6 Sep 2024 14:35:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E85188D01
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c94eb9822so15018845e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626121; x=1726230921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=BCItFVbo72sdRpXuMboLvWSs2PkOmMbpmEkfe/5Mo0vE5aTRb8Mf5ESV6NoQM6K1C8
 3hV8TuH/9PSx3wZCSenyKQNHEqDq0pXoqlDh/yHo+x8vyFxhl6X05GyJlKnXOFLwsv/r
 3/iEAqIz/nhfi0JezIBGZnqi9R5UcjKS4y2ffTTpc3TyaHYUy1Me6oyUJjJIw0gETaMi
 bUakJiyYUzZOU+9MOFCRGGh7DdKvC9u8t2/Meo3pDInnnvech8i28pHgbYqm6hkhh1VE
 BsSBgIJUk09MndT2Omv0gnciFLj84I8WqiwKn4REX+gnkGyCAXILEZsZXYnbIIaW2QGR
 m6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626121; x=1726230921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=cDOO5lKo7ZZuN75+xTa6iBzjSWqW2PPqu+lVDGdYzaigyKuScl/CzBMe4fALxT0jbj
 lYG6m8isYruVJcUwZAgc0qIoZ+NRKdW7QU2/Pw2uOtrOFZL78RMmRIWktaSo6l+Jk4lq
 oD2SNJmOkGvErkoQkZuxZ2RfJx30jy6rs+syMnJ95KtV7GkP/cg6WoJwOcityET1hZpn
 rtjTTSH3xYPJeqL1n6FtPbYgNDP6Ng6LqSintWyPRZGnPmeUANPOEjEKV/+DKrXQxgRZ
 OZC3KYnZZQvNNOXJ8ePaLJI9Yuiagx4zULgZjckBkWrn28J3NwRrA8O1ZcYyfmdGMVqu
 wG0w==
X-Gm-Message-State: AOJu0Yx3jvQlMNRtfAfdgO/SZZnKsMCGznEOZPIDFgNh0sYZJVFyTNme
 cStlgkJB58eW1Bd6XjET5SKfXLPUgNgAL6iFKrZQOvQ1oWY/vMXajuvwSAz6yOf/dDACIuRjXPO
 gk+OjoDCd
X-Google-Smtp-Source: AGHT+IF1Sj/3Ejd2oO5Ud1tou868wCghDwX+ZEeeLmWOwETVnLrXxcfO/dWtemqzYbWR7u8JaYE4ZQ==
X-Received: by 2002:a05:600c:c08:b0:42c:9e32:d26f with SMTP id
 5b1f17b1804b1-42c9f9879famr17905015e9.19.1725626121205; 
 Fri, 06 Sep 2024 05:35:21 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:20 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v10 19/25] CI: add qemu_arm64_lwip to the test matrix
Date: Fri,  6 Sep 2024 14:33:35 +0200
Message-Id: <d3ff544c92497ba9e4b129f2f7b6adc3669ad4f8.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

