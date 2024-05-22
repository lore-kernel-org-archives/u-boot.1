Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC15C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A8188851;
	Wed, 22 May 2024 18:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qj9hm7DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8EA8887F; Wed, 22 May 2024 18:04:47 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB02488867
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5a5cb0e6b7so1046036566b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393885; x=1716998685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiy2ez3zD9iw9dlSXQfKnclcB/WPfnje6lwBQ+wIQbg=;
 b=Qj9hm7DVzRVIgS3WWJUjgsGNZjfn63cV4+w56ZdrcQ9j95WQovE3GrfIoTJdRIH7G5
 2cn+Zqw1WuOb3u0dOKfPrZWylR3HbDfDb7CuBWDYdoC27aipS37R4dYfittxZSAv3E9i
 Y+KqFDiDQJBfn5DcI6LtGb8GbvkEgusEfNpBa7My+Io6N/HudTzpQs1UL2B2hCpca+X3
 FiAJcAkigUGDLWm6xkIK/lxfKC5bkpC7tZF+NfDmXLBDgFRrVtpcmLHM5qwrNkc0Xt/u
 RewASj7V/ydAxczY3q0nZCH5I/xE/A24X4FymVoZ1sXSqRiSmA2qhWL7XIvuyvW7kA6+
 Nodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393885; x=1716998685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiy2ez3zD9iw9dlSXQfKnclcB/WPfnje6lwBQ+wIQbg=;
 b=s1aIXkDKmgBc93UYqIPwPm7oxst0d3UM/ZFqgaIvRG84wyI2Jv+B0Lj8QsBk9MhTl7
 UWf1zfuNPMDupmDpGnNw6yS8JgAnep/NTTVSKC05oRwOvR+61BoVK/Pz/Yjl9iZ13Ira
 1WHOLiCKyvk9gzMbLjMBXKnRTf3Egt/tyQlEw9MAyLGERv+djwDTIAYEE15kj+oLo63f
 eJoDgwPROh1Cu4mGDRgbFxyDmaDLiLlP21z20NJKwEW7i+3uSHIW0tTNHdn4VDtOmQ7Y
 2B7BO2ADhmPuZmbD6hyGz0WeZ8Wtf2vAcrqXtDijNKCajhZbtOzYL4Ag7KBmgxDnVcqU
 1Wdw==
X-Gm-Message-State: AOJu0YwjMAe9ZQWBBBNN9dBfmDe9vQCMIQZoa49dR80NeeweD9josVH6
 r3/aNiqzaGMX0vXAaoaOlzEzDIjq/vEntG2UovpOIYsJO9WmFSTE+mi33XcZAtuT9+QNXZVFsWg
 4mr7uHwY9
X-Google-Smtp-Source: AGHT+IF0jKjM+Z7cmNfcp6JrbagxI4np5TXqtGqYp9fVYFsnD5Qw60yTUkzd5dc3rOMUrfNMwctm8A==
X-Received: by 2002:a17:906:5a91:b0:a5a:51dc:d14 with SMTP id
 a640c23a62f3a-a622806b6f6mr163878166b.14.1716393884700; 
 Wed, 22 May 2024 09:04:44 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
Date: Wed, 22 May 2024 18:00:12 +0200
Message-Id: <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Add qemu_arm64_lwip_defconfig which was created from
qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 0000000000..c8dadbce37
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_QEMU=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
+CONFIG_DEBUG_UART_BASE=0x9000000
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_SYS_LOAD_ADDR=0x40200000
+CONFIG_ENV_ADDR=0x4000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_CMD_SMBIOS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_NET_LWIP=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_CFI_FLASH=y
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=256
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
+CONFIG_E1000=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_MMIO=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+CONFIG_SEMIHOSTING=y
+CONFIG_TPM=y
-- 
2.40.1

