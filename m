Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A3CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE0488D34;
	Fri,  6 Sep 2024 14:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KMWJm62D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A08C88D01; Fri,  6 Sep 2024 14:35:29 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50A088D4E
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bbd0a40faso17101305e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626125; x=1726230925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MktPFMTO7Kpc7/pKSJ53v9OJ+XoE2+jn+aez6r7cU7Q=;
 b=KMWJm62D4bC4FT+z2BZBPA8gMhZItt82TCibNPWJ2u+wPVL5IZy7fWBeJXQSiSCChh
 36u7LGUeLY4Q6bLvAI1FORjpV9QyDk6nVeMoCE51oXDQhor8Go6ymjb+MC0YMbY/8JsG
 boACg2p33i+vLlkxLh+HlFuCS4yflppw1koDiWQJeShXpvdB6F53xCj63/xC+eV7QOpI
 8a6XrCVPZE3ndiGMXlhN+zhBHLseqmRDeACWThY/JXB7R5yn3OOrncRQg43nuivnMqVr
 Cg4097r+DLCMFIuUcFvNPCYLVIyk8B36yaB4eX0sJkrFlfNEKSDpYc940vWsqTKGES95
 Tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626125; x=1726230925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MktPFMTO7Kpc7/pKSJ53v9OJ+XoE2+jn+aez6r7cU7Q=;
 b=DjXLteks5TSprEiz8oEb/h+x0n1frGptapjErS7GKoqXmHFUPfUUhphfxAltQpJ2ML
 i5hTzxQ4iVrbwSNAFCsk8218YR5PbtjLHP1QrwX9jAXHz5RwzGqLp1OjAWsX/STsd93h
 KlC7W8C2pjzJVjQr3/TdsfzZPDoePPqgoducfnadiAUQd9DSwVn2ifgbmUIIQHY01PgX
 TPaeDdJcvtb7V5FT1fUzSm5D5EpmnCFprQ7GXsFnPU9Mfe9svJ9l74YehJDoWJLsIWUY
 vE5/podDzTdSeFG46+Q2mS3z6H7vhfrSf82Vn+lH6tQiQ7q5HPzXhFMEOpqQzL5QqhBN
 Hd4g==
X-Gm-Message-State: AOJu0YwN4j8WRdFCeh9XemNXmPG2BGa16BzDeR9zYtRTXkLHw9NuRIwh
 ZXchafV8C2qiXjR9gE8/Le+eSgaU6DFTcSnz1bIRQtar5N+pUJFqwJoQkzLRNm+5B3DL4Px2d3P
 +m9EdnuGh
X-Google-Smtp-Source: AGHT+IGdW0qcxGbkXH1zK0HuNfVsjqvQ8YeBMCtaqZnT+KkKpGT/Ewz41REAXuL4JaeSTjSHoY0B3A==
X-Received: by 2002:a05:600c:3ba6:b0:428:e09d:3c with SMTP id
 5b1f17b1804b1-42c9f9e19demr15756455e9.33.1725626124693; 
 Fri, 06 Sep 2024 05:35:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 22/25] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
Date: Fri,  6 Sep 2024 14:33:38 +0200
Message-Id: <38745fe0314a9acb00394425f7ab37db7ac5fc2e.1725625913.git.jerome.forissier@linaro.org>
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

