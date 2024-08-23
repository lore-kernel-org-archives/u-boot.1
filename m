Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A86C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466F488C73;
	Fri, 23 Aug 2024 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W8FLEjyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264E288C73; Fri, 23 Aug 2024 15:50:18 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BEB88C65
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso15529705e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421015; x=1725025815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBTpKlNJ+CX952bVpUvNeHC0pIUflmSyNV267epLKSw=;
 b=W8FLEjyGgRGmjcbSFIQXW03LGaARUzBAk6Jc2Z8jVVUdEl0t7YEnsP+e9QsVcyL7d9
 pFpBc50zXnWCKHhiKBAkzZwgc6K1tTVUoOZm+/zKvIACPdxp5QC4yxOYdrS2L2/ThMAp
 TmORmOZJGZkveOleDSSG8rlVa2tpxICQX70a8P3mWbhCoBf2sQ6+bgZS+hCROhmuD20z
 5nIknk8o6mOagOM+bOLQ8fd6fk/l+RdANBX/FghbHoluvj7O4Aov0k+YPaVKHX8ac4t/
 v1IMIZC5KD0OfBltOG8E+kZDerA5tIE3PLdGlypiNJKqzu4a66+aHfmf0Z28mFT5yoF/
 R/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421015; x=1725025815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBTpKlNJ+CX952bVpUvNeHC0pIUflmSyNV267epLKSw=;
 b=S90XxgfgFjdxHDWjHWiISjHMdQ4/8aVT3oOCJO2KVBvMgwRvs9wDF+a56ssRbFgAt7
 zOf8TfJfXJL7VAPMCkeywua3iFZ4e4D4vEJr+IiRJ5PJOEVaekX2VmqRZrtLIMc4Wb6F
 N+kYir1kaLu/etV+XJ7Ss+9VjuTB8U9sKYF129M1X4w6HCUk6PaiwHZB5R6NeEIb4ihV
 NL51mlBPBZP+j3B3T1L4MGV41OGlMYg/3UhXITmfDK8vIaY5MC9tYKYk5OdQvgVKHr37
 g0ppO2crBsLG+V7jRj4/JA3YH9WoFy7rz1Ds5FUMbqWKhFkSptb2TwDIbII97TtX4LPs
 qAgQ==
X-Gm-Message-State: AOJu0Yyg/wGNyOmjd7yruRL56h3bzwZ7myhmkRvhnp4ELEGBtBz1kVu3
 Pof1daajckOg8gadkZyB1YlFD/Adgocik4JRrO+ajOCt7T3zsBeOhsNWULZ+vv/wVRHqtZofSxG
 QYftJcsC7
X-Google-Smtp-Source: AGHT+IETQB4Lm6OdG8PCqMIC/gRP7d9+7IIHcluyiWT6F4WYeSKVCiDGLU9FDgmifb9J9eCibCIrQQ==
X-Received: by 2002:a05:6000:4009:b0:371:8e95:9c84 with SMTP id
 ffacd0b85a97d-3731186340fmr1655520f8f.26.1724421014589; 
 Fri, 23 Aug 2024 06:50:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 34/37] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Date: Fri, 23 Aug 2024 15:48:38 +0200
Message-Id: <1cd8b6cde8ba55d6f78cc8ca4c4376bc5ce62294.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

The tools-only defconfig causes troubles on MacOSX due to the default
C compiler being Clang (LLVM) rather than GCC and more specifically
due to [1]. Therefore replace "$ CONFIG_FOO is not set" with the
equivalent "CONFIG_FOO=n" using the following command:

 $ sed -i -e 's/# \(CONFIG_[^ ]*\) is not set/\1=n/' \
       configs/tools-only_defconfig

This fixes the tools_only_macOS CI job on GitHub [2].

[1] https://github.com/llvm/llvm-project/issues/78778
[2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/tools-only_defconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index e00f2c48598..7511e30d709 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -4,26 +4,26 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
-# CONFIG_SANDBOX_SDL is not set
+CONFIG_SANDBOX_SDL=n
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
-# CONFIG_BOOTSTD_FULL is not set
-# CONFIG_BOOTMETH_CROS is not set
-# CONFIG_BOOTMETH_VBE is not set
+CONFIG_BOOTSTD_FULL=n
+CONFIG_BOOTMETH_CROS=n
+CONFIG_BOOTMETH_VBE=n
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
-# CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
-# CONFIG_CMD_BOOTI is not set
-# CONFIG_CMD_ELF is not set
-# CONFIG_CMD_EXTENSION is not set
-# CONFIG_CMD_DATE is not set
+CONFIG_CMD_BOOTD=n
+CONFIG_CMD_BOOTM=n
+CONFIG_CMD_BOOTI=n
+CONFIG_CMD_ELF=n
+CONFIG_CMD_EXTENSION=n
+CONFIG_CMD_DATE=n
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
-# CONFIG_ACPIGEN is not set
+CONFIG_ACPIGEN=n
 CONFIG_AXI=y
 CONFIG_AXI_SANDBOX=y
 CONFIG_SANDBOX_GPIO=y
@@ -32,9 +32,9 @@ CONFIG_DM_RTC=y
 CONFIG_SOUND=y
 CONFIG_SYSRESET=y
 CONFIG_TIMER=y
-# CONFIG_VIRTIO_MMIO is not set
-# CONFIG_VIRTIO_PCI is not set
-# CONFIG_VIRTIO_SANDBOX is not set
-# CONFIG_GENERATE_ACPI_TABLE is not set
-# CONFIG_EFI_LOADER is not set
+CONFIG_VIRTIO_MMIO=n
+CONFIG_VIRTIO_PCI=n
+CONFIG_VIRTIO_SANDBOX=n
+CONFIG_GENERATE_ACPI_TABLE=n
+CONFIG_EFI_LOADER=n
 CONFIG_TOOLS_MKEFICAPSULE=y
-- 
2.40.1

