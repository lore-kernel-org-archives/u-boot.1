Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264ECF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5850488F62;
	Thu,  3 Oct 2024 17:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aPzhxr7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB5888F62; Thu,  3 Oct 2024 17:47:39 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2536588EE8
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so1289225f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970456; x=1728575256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MktPFMTO7Kpc7/pKSJ53v9OJ+XoE2+jn+aez6r7cU7Q=;
 b=aPzhxr7EztjkaH1Vxiz9+88mhsAM25fiBYgGiKCbYNF6UZY5+/sv6Kjru14uiHrfCU
 vPciiIQ9XtIOUfTBMdhDGHcWu0z8ZboubY5Vppruo5q+WX3gA13zR9COMSI/PLNGeQe2
 1meTDtBJTzcuOpYUa8slC7H1AJnrmyhqYBeHBwKR4BfaZ+kQoE0ftCyXWZsh3jx39IPn
 lDFu4bjIl4RxpRWelRpsE3QFCEKhohfURvPFzGTHTTqE2iXeJ8X3pGOiZ3ij5F44Eq60
 48ov0D+tMVo21bmlb5j+ZZk+BUBu50Prxu4wGVA0NLRJtJZPTlXTI0ToANBkvs6OqeDm
 P87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970456; x=1728575256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MktPFMTO7Kpc7/pKSJ53v9OJ+XoE2+jn+aez6r7cU7Q=;
 b=MNGL0w1KR3zfOITEKoXST2BgRN66tUQ5QpfZuhWcviwr8MYXFYTu5F8gyUWynsZL6a
 j0XKHNDrrZ4vbptNgD97ncqbpdEcv7eQH2rKzSjLUB0THoermCb+4xiLEPdPPmfvDfUS
 vMi3fWMjlqbh7uEeyBki/C1OTwFfkWiH2SAf0bwWXi/3O3AKxVFyPGgKFC+qsH2xwvro
 YnlAdw9UdUcIUxXBsdZGulQaSPJmh5Zst0Gt996ELeE8xazWhha7cyNFqBoxQtWI8vLr
 +Iq43nt39OnGYVvwE6cq9gtt82ICUHk96jLdBqxiUbJLEBEl14qgr9Pxd2i/jyBNKECn
 sc8w==
X-Gm-Message-State: AOJu0YxQpJs6jhNBaL+Yu+OvZk2wNlT+wTM/p1e61UOy2PLsyHmrHMvj
 65btEAsle61nNZW/RAtiUz4X3NxOSw2PQiJgF5aWYL1A6gEQ9oYY0TGSZUU2790JblA93fBBa+D
 AzQvBlqf9
X-Google-Smtp-Source: AGHT+IF6PX9TDS4gZGan/ktwvf0dvgY0BurTF/Nyl+t6DidM7qRXFsRoT3vQ3XjKqGeIBWVKHjUreQ==
X-Received: by 2002:a5d:688e:0:b0:374:c6b6:c656 with SMTP id
 ffacd0b85a97d-37d04a32a79mr2203310f8f.21.1727970456286; 
 Thu, 03 Oct 2024 08:47:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v11 27/29] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Date: Thu,  3 Oct 2024 17:46:31 +0200
Message-Id: <fe12e1f45985088649336fb032f4b724724a1f89.1727968902.git.jerome.forissier@linaro.org>
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

