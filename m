Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156C2C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3261A832F9;
	Fri, 18 Apr 2025 16:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCjzgXQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C617832E9; Fri, 18 Apr 2025 16:11:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063E28328F
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso14523885e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985507; x=1745590307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWgPI+Dmjm/1eQXuimg0E37dXNaqzlxa249pBV7ma1s=;
 b=CCjzgXQrG9Vin2VTm4hmmihD5/BOBj8FtCo/AnBPFlPtpnYYo2CPQ1ixviJrp0w3oW
 YJJSjxjGhQRZnnzKUUADSdvmz8hbSkDiBZgaVQkelRk4lystAYbF4VHiJHJod7nPIDr9
 pVYMNGk0dD7LMWpv/R1HcUk9CuSL4Cw7q+HwvgWRfJrt1FILV9mYj6+go+Rf481WRXAQ
 wQ7DnOYUE4AFxQX+rht/TSPF9EHEgqLbUuqFYY6egYrSzmnIt1j/pLIKZ6+5qaV66ONz
 KxWvl9U5M0pC+bX0PjnfoU9Z9oACL82Zl6hrTlLbFm03M67aY8gsWblJoIWav1SVOtac
 MaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985507; x=1745590307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWgPI+Dmjm/1eQXuimg0E37dXNaqzlxa249pBV7ma1s=;
 b=gDvnBmfeQuElSUTytVN639YwAcxhJE8h6yE2FKxcS4UFZPxBQVAjjiP/iYmxQxw5+R
 aZp/SjY72tObP49Ie75cC+WRmtBVLclxrksfSvax3InjJ4MNHoyu2mnG1tzt/0K2S8YH
 codMRy2CijJytYQMINh0KgCI9nRFQF7ydXzde3X6zcDQ+4LBIFmVxQ2vwIB0cgP+L7xq
 snPVOPPStvaup66k0NmjBWvrgA8PHgTJmjVKbcRLJn14V3MmNts2AyUcO7kPYD1sUXmw
 QHlxQj7lzcpISIcmkioUmi2wRHmzaRjihPsN3yyqxSltTxvB8n7J/2ch7V9eWGlF8tII
 UZjA==
X-Gm-Message-State: AOJu0Yx0gtBwpQB1BiT0itNsbmK3fGz3OAS4/f1vIHqxNvRnI8AmnrFf
 J7mZlqnb0RXz1hPTP1D++mtQfit45A52i0T3OTghT+UORkOaApSb2VZTfLqL8p5nZz6fZCWr9Wz
 kzuQaOw==
X-Gm-Gg: ASbGncutTCo2KL+GIi31m2JoB7WhlSIw7c3l3QxpAIWr6y1KIvvqaGSXYXeiOaH8keu
 C2pfUR4pFvSYzjM99HCzcxcypvOZ+Ip1rWxOCgNDmwCmmit9vpehrOqH2WGJ61xQ0SLe1H09kpy
 aGxo+wEzDEC4yEc9AvYG/RAV4ff30qXBKcYJ/b2kN4oq0hvhUNtdtmHIPe1C9XdbKF6+3RhCMVE
 bd8VIR0x92qnLhPSCxzipyuoo7Wc12oslkx+Isd2a3KvcCsK34dcVeXgo/mfxXhhGvcswOH8rvB
 zLOCgDYFqThC1FkcuUECYjFi8fnwpPoOFNt6C94xBFfPd94U+Q==
X-Google-Smtp-Source: AGHT+IFMPmCV2lAhCmW0m3B4rQynZj86N7it7G75Gt5OsRZOKETyGU7JOMFfvBTt9MpTMSrS5VBG7w==
X-Received: by 2002:a05:600c:1ca0:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-4406abf9935mr18507875e9.21.1744985507305; 
 Fri, 18 Apr 2025 07:11:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v6 17/17] configs: qemu: enable UTHREAD and CMD_SPAWN in
 various defconfigs
Date: Fri, 18 Apr 2025 16:09:45 +0200
Message-ID: <20250418141114.2056981-18-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Enable UTHREAD and CMD_SPAWN on supported QEMU platforms for testing
purposes.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 configs/imx93_11x11_evk_defconfig    | 2 ++
 configs/qemu-riscv32_defconfig       | 3 +++
 configs/qemu-riscv32_smode_defconfig | 3 +++
 configs/qemu-riscv64_defconfig       | 3 +++
 configs/qemu-riscv64_smode_defconfig | 3 +++
 configs/qemu_arm64_defconfig         | 3 +++
 configs/qemu_arm_defconfig           | 2 ++
 configs/sandbox64_defconfig          | 2 ++
 configs/sandbox_defconfig            | 2 ++
 9 files changed, 23 insertions(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 59c4da7fa2b..d03895ed6ea 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -129,3 +129,5 @@ CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
+CONFIG_UTHREAD=y
+CONFIG_CMD_SPAWN=y
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 1cd80f5769e..b9f28873c15 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -16,7 +16,10 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SPAWN=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UTHREAD=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 6f871c83644..cd89571e40c 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -17,7 +17,10 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SPAWN=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UTHREAD=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index cdd511b0e72..c67fb9a3352 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -16,7 +16,10 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SPAWN=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UTHREAD=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 2f62f17bc8c..d28e9fbeceb 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -19,7 +19,10 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SPAWN=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_UTHREAD=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 6c9d2505a69..b1371d4258f 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -37,6 +37,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_SPAWN=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
@@ -75,3 +76,5 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TPM_PCR_ALLOCATE=y
 CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
+CONFIG_UTHREAD=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index 2d642f86ba6..97d2f2f2e49 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -35,6 +35,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_SPAWN=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
@@ -67,4 +68,5 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_TPM=y
+CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 42c40077823..23df4c3b635 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -99,6 +99,7 @@ CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_SPAWN=y
 CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_OF_CONTROL=y
@@ -275,6 +276,7 @@ CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
+CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 87f21fdbd12..c4b1b8114d6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -143,6 +143,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_STACKPROTECTOR_TEST=y
+CONFIG_CMD_SPAWN=y
 CONFIG_MAC_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
@@ -364,6 +365,7 @@ CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
+CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
-- 
2.43.0

