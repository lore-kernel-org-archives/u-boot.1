Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894CCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00AB83826;
	Fri,  3 Oct 2025 21:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZtt4xsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2E283835; Fri,  3 Oct 2025 21:19:43 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246298381D
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-938bf212b72so91153339f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519179; x=1760123979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jN/LF4zN+OFWN6tu+gBHPe2xxFkCoTxNJ/8kRz5TQ3A=;
 b=sZtt4xsaJE/DOZQbaDtGLCjvHiuiZkHyM0iaT9CXtFd9pBRcAzqNgBwzlRm13x5SGo
 T4lls1Dgd8mHBbdw0yNZmUW34Ocw1p1iT6gy7HwaHd+B2URDp7/MQ3X5cHP6t8m8xOGg
 d9s1ixP0iMj6Mh+CjygpyWxCQra9W5sMPGxwMer8hkNzmHhnbwvvh3DQ3IdOe23tuCoL
 TvR6l8IKYXcDmFEw54LngPF+pWxb1ChdiUfvNuaU0kkL5JKVdhXFRTJNJf/1jWGH3KzM
 IS3pdCX8jXiDyvtEpEKX9qDTYMhaQ/7UrMfiNvwec4OkMfs31y+O2MXRZXOLESoweVhP
 JN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519179; x=1760123979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jN/LF4zN+OFWN6tu+gBHPe2xxFkCoTxNJ/8kRz5TQ3A=;
 b=l1olfXDYAHk+im2iAkrNEFYh0SijtFu+8ONeVUCnOzMNo/sz8a2YMdvl+WOa+3vmd9
 lyiBTQWiNH/WfGy62IF9fokc4eoza0bnM/HYirYgE1pdW4EuXCP0/Id/jwDkCnLy+X8Q
 06bOEGdakmIL6b9buqkXEwFeT5NRWrXaSLZlerHEFAwGn0HZcDo8rpn5K+UHF8K2A3/t
 oP31AiRJyFRbjGwGar4AwrefWm+K5pp59ieZIG9mbidf2XKPWFROSsfI63FZkFhBX8QP
 4hPwYPTFsQgBAI7SstkYuVPBaaxba37RIcjFy62zAzaguj/f6yOxqqxMoH/Xy8fQyOSV
 NONQ==
X-Gm-Message-State: AOJu0YwCw7MjWPEzk1E3yeX2N1S2iqZq8Lsp9Q2+/+I9vlK2+PA3TTG+
 6e16S+HPkTJeWVMcqiPIVmpCz9RPV3Q5NjyT7eaZ9CjoBldGGJ+2Bq8GoJ1eF2cvl37hF0ZiDAc
 tNbBD
X-Gm-Gg: ASbGncsao1avy9g5Vp4a8YuSaZ1jYShxz81DkJmOLHB4IRlFbIawGv8S+vWowBE8M0z
 FMWv8b1CbJgc3HgbjvVqkGEpiwIA65gtg+Ct6eo6tDak7FO6V4OpQuSlgd9HYF5kRxTqX5XAH4s
 DhXW1qqFEE03SZb4yO5WYwYIedxEr5BNsq6lo5FAdhMTf4jsFPb5e/wsTZnul/7/vzRBP+dvWrq
 4pZrDsf+tFqlEK4MofWLfK5KJClRQbnro1Tgz6RbVfdyluQ3j9ejmnEaYnoH28EHZHosiRV9KSD
 6PWXK97xVAmwYea/dSv4tYFysLLOqhcj8IVZCcvq2uudUZMB/NcDLWVDs0au1MM3w52dq3PB8Mc
 FUwefspWCW3D/+nlmF3HMBDhXxsUXUkkSOztHObtnvxH8T3IZIsa7bfylHMU6jKDOP35cBbl7Wz
 4Fki3YYdNwK9JGfbRdK6U=
X-Google-Smtp-Source: AGHT+IEa/5e/WQhQJi0wKkvqjIb4MjoXaH8ADA+hL6lGW1d9shoFH+aj8gJJtaehJ9q4ii58zD3dVw==
X-Received: by 2002:a05:6602:1590:b0:92e:772:9323 with SMTP id
 ca18e2360f4ac-93b96b46dccmr561930939f.16.1759519179315; 
 Fri, 03 Oct 2025 12:19:39 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a8912bfd9sm213794139f.25.2025.10.03.12.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:19:38 -0700 (PDT)
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
Subject: [PATCH u-boot-test-hooks 1/4] travis-ci: Group the QEMU args
Date: Fri,  3 Oct 2025 12:19:10 -0700
Message-Id: <20251003191918.767698-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Make grouping of QEMU args to break the long line and modernize it
with '-m' and '-semihosting-config'.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 bin/travis-ci/conf.qemu_arm64_na | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bin/travis-ci/conf.qemu_arm64_na b/bin/travis-ci/conf.qemu_arm64_na
index e195b5e..bd55ea8 100644
--- a/bin/travis-ci/conf.qemu_arm64_na
+++ b/bin/travis-ci/conf.qemu_arm64_na
@@ -24,7 +24,10 @@ console_impl=qemu
 qemu_machine="virt"
 qemu_helper_script="swtpm"
 qemu_binary="qemu-system-aarch64"
-qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_net_args="-netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
+qemu_host_args="-semihosting-config enable=on,target=native"
+qemu_tpm_args="-chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args}"
 qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
 reset_impl=none
 flash_impl=none
-- 
2.25.1

