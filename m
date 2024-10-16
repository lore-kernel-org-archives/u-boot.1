Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74921D1AD3A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2D088F69;
	Wed, 16 Oct 2024 11:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VS21M6wA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA6288D1B; Wed, 16 Oct 2024 11:57:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FA388E02
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43055b43604so61474195e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729072630; x=1729677430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwioewCs6QaiCUsMm4h2t49XeFssC0AFbOesP174Qbs=;
 b=VS21M6wA8BDma1EimXix3N8eLp/DaQ/WvZIuTfl9EF+iGX+dGiJ0jtSEoEZHgVDAdJ
 z0sKPbZU0JC6jAJavCli0s2ZaKAI6566kh1JoVVWnctBQjV65jZl7A+QLhJqEUSszAOq
 xq4vMqiR5JImlssPY3Ey7l9g5hdHh/Y09htgNDJEULR/0byMhDQNofzXf47wUBdewK5r
 eIOAGnGBnLrWymWYFBUai1f25cteCSIkWdhmSGA+F7a2op1wO17b9guEK4vdtoCFbFSJ
 2bt2FwEcX0SqRD5xw959zhv+U1g8Y01UpD8KWtkxQ3A/5cqERmYaoQuIkI2N8ch8FQbk
 g0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072630; x=1729677430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwioewCs6QaiCUsMm4h2t49XeFssC0AFbOesP174Qbs=;
 b=OjedXXiZF3cjEq8mPiCOSSWlfQPy/JE4gzP8T9l8SofO6lV+LUvwcFsuB4NTDRU83Z
 Wf9L6ESE4ljGD9y325bbrAbIU8U9TSFDtOv8+nqEWKJqHRCY8MApaHBaKbIJiCsFF4aR
 vRRleyTeAhIQ4OtCyoUQ78MgPBOSMXMg+83ztXvO6mGg0gsFBJQ169xXRRpEc+oQm3gQ
 7flHpZTrs+ohYmUj+2MJybYhme7sWP1E2WOc4ShMnCjy92DQF3DAwOuw1VE6BwitPvqF
 CIcFg5LJJF9AgUzvcIj3ySFTq0VUEGVnBN1Jcst8M5Hg8fsnw2moaxzSJYAAGVyaZ+S0
 F1mg==
X-Gm-Message-State: AOJu0YzgEM7nFMBwR39d4KOkyvfu/FpAHZ79tJ0/O/9i4wxiXW7ogWJK
 8w3tudOeUTJN4hkTsgfOZ4HOEyU1movylPoebplELVYEvEDRGRhE0n8VVfL0Rzg9Lr2BFtaueh6
 zKPy2eA==
X-Google-Smtp-Source: AGHT+IH7Rps1COrUb1YSBk3BrcWn001mzwa8b36HITq549FPJDT9AMgfCPF3a6imcfw3vB0uhTQOsA==
X-Received: by 2002:a05:600c:19c6:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4314a295480mr30659055e9.1.1729072630288; 
 Wed, 16 Oct 2024 02:57:10 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1ebfsm45236335e9.34.2024.10.16.02.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:57:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v13 01/21] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Date: Wed, 16 Oct 2024 11:56:23 +0200
Message-Id: <c7dbb09f5cbd621af1b59c07a75e78b6406c0b2b.1729070678.git.jerome.forissier@linaro.org>
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

The tools-only defconfig causes troubles on MacOSX due to the default
C compiler being Clang (LLVM) rather than GCC and more specifically
due to [1]. Therefore replace "# CONFIG_FOO is not set" with the
equivalent "CONFIG_FOO=n" using the following command:

 $ sed -i -e 's/# \(CONFIG_[^ ]*\) is not set/\1=n/' \
       configs/tools-only_defconfig

This fixes the tools_only_macOS CI job on GitHub [2].

[1] https://github.com/llvm/llvm-project/issues/78778
[2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 configs/tools-only_defconfig | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 5a08563bec1..29554be7a65 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -4,27 +4,27 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
-# CONFIG_SANDBOX_SDL is not set
-# CONFIG_EFI_LOADER is not set
+CONFIG_SANDBOX_SDL=n
+CONFIG_EFI_LOADER=n
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
-# CONFIG_NET is not set
-# CONFIG_ACPIGEN is not set
+CONFIG_NET=n
+CONFIG_ACPIGEN=n
 CONFIG_AXI=y
 CONFIG_AXI_SANDBOX=y
 CONFIG_SANDBOX_GPIO=y
@@ -33,8 +33,22 @@ CONFIG_DM_RTC=y
 CONFIG_SOUND=y
 CONFIG_SYSRESET=y
 CONFIG_TIMER=y
+<<<<<<< HEAD
 # CONFIG_VIRTIO_MMIO is not set
 # CONFIG_VIRTIO_PCI is not set
 # CONFIG_VIRTIO_SANDBOX is not set
 # CONFIG_GENERATE_ACPI_TABLE is not set
+||||||| parent of 7b58f8ee778 (configs: use syntax CONFIG_FOO=n in tools-only_defconfig)
+# CONFIG_VIRTIO_MMIO is not set
+# CONFIG_VIRTIO_PCI is not set
+# CONFIG_VIRTIO_SANDBOX is not set
+# CONFIG_GENERATE_ACPI_TABLE is not set
+# CONFIG_EFI_LOADER is not set
+=======
+CONFIG_VIRTIO_MMIO=n
+CONFIG_VIRTIO_PCI=n
+CONFIG_VIRTIO_SANDBOX=n
+CONFIG_GENERATE_ACPI_TABLE=n
+CONFIG_EFI_LOADER=n
+>>>>>>> 7b58f8ee778 (configs: use syntax CONFIG_FOO=n in tools-only_defconfig)
 CONFIG_TOOLS_MKEFICAPSULE=y
-- 
2.40.1

