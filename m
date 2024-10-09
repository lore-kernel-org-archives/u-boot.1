Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB79CEDD99
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF80489240;
	Wed,  9 Oct 2024 16:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MKwnONDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594828922E; Wed,  9 Oct 2024 16:03:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872908922E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d43a9bc03so305658f8f.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728482618; x=1729087418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwioewCs6QaiCUsMm4h2t49XeFssC0AFbOesP174Qbs=;
 b=MKwnONDjdOh2BY7jKHVU1b0SOKN39FOT51uvK+2lT4CXzFfTteQ+ywe4CwRZLuWs6k
 Eg5PE4WDqPfwOmO20U/AkVB5HE6Xn4lFEXnD49vePfoE0KGbDCO6ZuIfAt9z383cBFYO
 x9EmT9FzMpV4zNV/xjvHIBbSzAa0mwAVuk3g80Qx7evP7tOdsMsDYUJNAyVOC6gasLsV
 IgXeNt2iIoRI45JJDh0WHWn7MMfO/AQFwgCG3uq8CPlJaaABbuuArAne8dHya9sUU1hq
 ion3WzdRvTqWprZscTsaatTU5Pn49JKtNj63lnNAqxWoF/iEQYj5fIjQ0sht6vb6Vobn
 NsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482618; x=1729087418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwioewCs6QaiCUsMm4h2t49XeFssC0AFbOesP174Qbs=;
 b=HNmQrzDf6VfCMhl2/3aZnKYx0oBPInUpMLLluRUG21p+8pOZeJCo24tcfnh0IShubq
 PBxNKqGBE9VpLZTq/wCIwunKgrhCD4wgtUfwYj6qfTc3EYsmF/5PzcklndU/S+dA/+Zl
 wfFku8vTVonz8pwPoAB1/O3sYQ7XopO/2pMOs+KQN+uqkZiXBP19hS3WVBA71M+PE3eC
 Yo9pSSqusax48biUJxqtLTAzshniBJAufa/m9nFYSsbj8Rn6n7Z/amCIUU/0zeAuR42/
 vQ4rrO5MBZ0dp/gSlxIkYHwesTe4IBHvdXZK+vqScQN+ji7I+CutEslQvEt5bfm139j9
 bK9w==
X-Gm-Message-State: AOJu0YxKHMlnFb5J4e3a8VxZ7+JFFQ5pgjGdvSKltjahQVKEkTOnUIeS
 9JX38PIf7fdwkUuBF8dHOFgxdydI6STCJX3FG0wCbaKain8Tqsr4YPIp1FXfv4etzucb0RNfkG9
 xSIGYRQ==
X-Google-Smtp-Source: AGHT+IHlMpPDBgKltyEm2e35ktFZw61sMQLV3nBcNnNU0gLfT2soeBozl3aIRYkBOoBnr1cD9A9P+w==
X-Received: by 2002:a05:6000:1108:b0:36b:bb84:33e2 with SMTP id
 ffacd0b85a97d-37d3aa6cd03mr1464917f8f.37.1728482617590; 
 Wed, 09 Oct 2024 07:03:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f0b2sm10581728f8f.9.2024.10.09.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:03:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v12 01/21] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Date: Wed,  9 Oct 2024 16:02:51 +0200
Message-Id: <134bb1f30047163ecc96eba90f2833412f201332.1728482473.git.jerome.forissier@linaro.org>
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

