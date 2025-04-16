Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81610C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DB582F28;
	Wed, 16 Apr 2025 15:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xMKZqeK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4969382EAA; Wed, 16 Apr 2025 15:58:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A9981E18
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso35229855e9.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744811883; x=1745416683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Jm9Vvv0p89LHXDSLVmTdRhLme8yXeEfPvqMflJatKo=;
 b=xMKZqeK369/mxw09QKDy+MRpH9kOiIWfDTRhUsPTomgUs94i9nJKBFSZx0Y4coU0sI
 yGl9TFAdKIQX4rkuSIVRxcd3Os0zPVfALoUq8cc/twdLk+XO9kzXNgJVw4wOraW2kTzj
 m4zcs1T1X0bBsBqT4B9HR3xfy7/GGZ7pqJPj/otvb3Z3pFHCwUQa1LbHGgqGhTwnfkc4
 juGEe/TXtuTqwKn9tUY+W/FyfAftqWCrC0BMpy55wJP1GhqqdNcOvCNIPjeF2VEuHAie
 dc19m1TxKxk45AEjSYY5yrfJ0n5Oh4PAQGxW0PCKcxOX/qs6c1yyjp5tkq3/ffbDlSCY
 AOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811883; x=1745416683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Jm9Vvv0p89LHXDSLVmTdRhLme8yXeEfPvqMflJatKo=;
 b=CWbuKREGM7m+BA4mmZrxDndoO1FrwhgUskcDRe/YnsC0kNhYHXn7nrmkziV0C2Cli0
 uYNGPO6JhReZ1V+CT9VOPl77XqYnpZBM8xwXWUhkbAhpmw7jPE4zQWTwRngpK7dPN2Br
 z6kHoI5uSpDAsIj/St44kgquHGbcW0+h/dH6dXUg5wjwa00OhTDLRwi9fJm7offXI0uC
 o2xPbzM36NUfV7IV4IxLgQZ64cHszj52icvHYXdix0rpwVbsEEDPDiFfAXYgREuK875U
 cbd//o8rWlMkIrrGLl3Py6CNpZw3KcHzNyvVsDreNz2PXjYrE3vp38yCnb2p0wNGIkw7
 nn7Q==
X-Gm-Message-State: AOJu0YzQRwbV2NZ/B+/w9YPatrJLtmjyzvwRQ5CmMna6QuTn58TbJD9h
 hD3Lmx2hflVBvQF9gQ9OIJ5SAXzShExJRQSkjg0b5avfN5pqvMZRc8eNF83rk2uijbIa15+ib3G
 GGyE=
X-Gm-Gg: ASbGncsZrjGpPffDL/2qNU3CTfVK5+n2zcmWmLhlmF79pKGdpI+DupWBIAwq5BdPahB
 I3sEx5OH7Amc7FzofVQ6s+Skp1KoK1MaUQP89xcPIfzPbd43bIlAN8GrvMvYmkTNQVKBgf1qpMy
 JSVxxcT0SFnB2JM0RPV9OAh/nHENlraKntKgqo5tcjeHlkyC1+8eNldZWGb9lp+AyjM0dpAmfyW
 UxME2YsT/nVC4PGSMtYFkUMwZoX1r05BK4HLvDkdb4mSMft3xqOuZmogi7HbC4pOpkQKMOWCmn3
 IBF90A7DA0HAld8iNnRM94d0aSgn5D/Yjg+f199ny1BYkgyiNrgkU0M46ig=
X-Google-Smtp-Source: AGHT+IHfXNAADGP1atapnqsFKmGt6Pb1neBTZ5iwDT9MHNI5P+2XDUP7OsFCNfHPcSGbQp+Iipv80g==
X-Received: by 2002:a05:600c:1c04:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-4405d6aae72mr15668765e9.25.1744811882705; 
 Wed, 16 Apr 2025 06:58:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7ba5:2291:675f:52e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5437c7sm22013765e9.39.2025.04.16.06.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:58:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v1 2/2] configs: enable CONFIG_UNIT_TEST for all qemu* generic
 targets
Date: Wed, 16 Apr 2025 15:57:31 +0200
Message-ID: <20250416135744.1995084-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135744.1995084-1-jerome.forissier@linaro.org>
References: <20250416135744.1995084-1-jerome.forissier@linaro.org>
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

The qemu* "generic" targets (i.e. not those emulating a particular
board) are typically used for testing as many features as possible,
especially in CI so it makes sense to have UNIT_TEST enabled for
all of the defconfigs for these targets.

Not enabling UNIT_TEST in qemu-x86_defconfig due to:

    LD      u-boot
  ld.bfd: section .rel.dyn VMA wraps around address space
  ld.bfd: section .start16 LMA [fffff800,fffff86f] overlaps section .rel.dyn LMA [ffffb77c,0002ac93]
  make: *** [Makefile:1824: u-boot] Error 1

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 configs/qemu-arm-sbsa_defconfig      | 1 +
 configs/qemu-ppce500_defconfig       | 1 +
 configs/qemu-riscv32_defconfig       | 1 +
 configs/qemu-riscv32_smode_defconfig | 1 +
 configs/qemu-riscv32_spl_defconfig   | 1 +
 configs/qemu-riscv64_defconfig       | 1 +
 configs/qemu-riscv64_smode_defconfig | 1 +
 configs/qemu-riscv64_spl_defconfig   | 1 +
 configs/qemu-x86_64_defconfig        | 1 +
 configs/qemu_arm64_defconfig         | 1 +
 10 files changed, 10 insertions(+)

diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm-sbsa_defconfig
index 8c5d3eb4be8..3819670defe 100644
--- a/configs/qemu-arm-sbsa_defconfig
+++ b/configs/qemu-arm-sbsa_defconfig
@@ -9,3 +9,4 @@ CONFIG_EFI_PARTITION=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_EFI_MEDIA=y
 CONFIG_FS_FAT=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-ppce500_defconfig b/configs/qemu-ppce500_defconfig
index 9f20b3fcd73..a444899db33 100644
--- a/configs/qemu-ppce500_defconfig
+++ b/configs/qemu-ppce500_defconfig
@@ -66,3 +66,4 @@ CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 1cd80f5769e..6f8f9827611 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -20,3 +20,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 6f871c83644..1d57b68086a 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -21,3 +21,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index 9906f8b2dad..8d5f9d9f5cc 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -26,3 +26,4 @@ CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
 # CONFIG_BINMAN_FDT is not set
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index cdd511b0e72..e00050db4e1 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -20,3 +20,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 2f62f17bc8c..a424f978294 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -23,3 +23,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 27e092bd208..18b7e049d86 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -25,3 +25,4 @@ CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
 # CONFIG_BINMAN_FDT is not set
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 58b1fbf132d..47075dc265a 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -93,3 +93,4 @@ CONFIG_SPL_VIDEO=y
 CONFIG_GENERATE_ACPI_TABLE=y
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 6c9d2505a69..cd9a4f2ae26 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_UNIT_TEST=y
-- 
2.43.0

