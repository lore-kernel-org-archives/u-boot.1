Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F320FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9D783FED;
	Tue, 17 Mar 2026 02:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gUAu9PXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884C683FE9; Tue, 17 Mar 2026 02:24:20 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FDE83BC8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-67bad873c3eso3265469eaf.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710657; x=1774315457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AyHN1ay5D+oR91hE9ar+/ONUTd/JIiA3gqsLvXt/cvI=;
 b=gUAu9PXBWvBjsGKLrd9AOwwt2ae4JFEzvkyVh+lSh39N07zwjbrY7/C91PGs4tm+/g
 Y4fA2UJ947KfNGddQEqLeUUmLLrekrZrrQ0d2Hhel2gM5rktejUTY8FcPpJ+HVUcPKg+
 lbofLFs4T+Nr9l80cXtEy+sh/dx92DTzMwSbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710657; x=1774315457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyHN1ay5D+oR91hE9ar+/ONUTd/JIiA3gqsLvXt/cvI=;
 b=USwf2a7H9Q7/Ut3dGPxGOCVUXBp7cfuDfS3hHQctLtS0FlsOq2Af+CVGH7pJ2m1iG8
 DLO13JZTkWDbaFGRIq1/qCZiAGHieSQwvSHIs8TPMtfQ35xq153HMbiyUfu7J/Ofj1f1
 z9FC8JRrZ0zg+bnuzKWzyYKTh8lmhkc7pa2sCWEz9xZk9MwczeldqcEs6A/ht9n9hoSy
 3+7HXV6z33KOOiRdPUFRRuxCsAnG+CzTLh7M1cUOhjHSeWnbLozrZLaeSGwh023CoHLZ
 Z+5JTaWf3EeMHM9auQMLWfq0lXfWIcvuGUJeTg3mQf6i015U7Uz+EJ7sqYfdIEeqIkKp
 YceA==
X-Gm-Message-State: AOJu0YyrZSlZ/e4Eyn4bsPLUPsXkdbYnJOOn2pUu/Zm403C18otk5EWP
 h6FX0Mxcl8CQPxa/gklTj3SSOlk58MumNk/KnY5YSUkW28addUSHGIfrfuBnKAla86nQFQv7SlP
 At0v3
X-Gm-Gg: ATEYQzzuEjH+nzMy+zbknXlSWl6iA7Y3RfQwWoBJoWBxDOTiTst/BADIQ1x9afvD7Nw
 ruGvuZUQocA8b2vw0NY6bHNfuPOXlH/v4U5yi/7FGt5YTCskF2+JdE4GlOqZiKQEPNAtA0MtpDc
 0svVyzQoeTeisbQaczBkRIb4SQ4fit8MnTlZlmO4BB3ZqE+Wo4gqdR0CbccY8yQlVeXydx6+DrD
 byWrC8z3iWP6WsO2FotndBKoI74SZ6IzGYvOmqVMX/jkRj2aND2geVIcfr1k7lC1ECBWkGzB8zd
 NkVZvHM00f4zkLSonVeQpiQeplpgVgUVyZNiLQlwEi5ZtnxVnE2+oA0JTR48D9sgaNpSuaTrSS4
 l+g5pTsEqVKWpOSb7xlRmNdWo16M1eMAVD63jRDEX1WfvToddZZKruLqKaSIj7GUZn/Wn/6l34O
 iRe3jnoEz96vQx7fK8RqdiQJZKZn7JQBQkXgygoSyxpXUh5jVzdwZ7FqC0nN2HBh0rYg2pmYC9j
 MmkamsgdY0mqX8vMwmHqWOb0OORXzPf7K62vaZZ0P4x1wmA+N4=
X-Received: by 2002:a05:6820:179b:b0:679:e9b0:9e2f with SMTP id
 006d021491bc7-67bda9b1f5amr10043969eaf.25.1773710656541; 
 Mon, 16 Mar 2026 18:24:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9118c87sm11065009eaf.5.2026.03.16.18.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] scmi: Rework SCMI_FIRMWARE implementation
Date: Mon, 16 Mar 2026 19:24:14 -0600
Message-ID: <20260317012414.4162304-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", how we have SCMI_FIRMWARE today is
incomplete, and in one case, used incorrectly. First, SCMI_FIRMWARE has
a build-time dependency on OF_CONTROL being enabled, so add that.
Second, RESET_SCMI depends on SCMI_FIRMWARE being enabled, it should not
select that symbol. In turn, a number of platforms need to now enable
SCMI_FIRMWARE explicitly and not rely on RESET_SCMI to enable it for
them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/amd_versal2_virt_defconfig  | 1 +
 configs/r8a78000_ironhide_defconfig | 1 +
 configs/sandbox_defconfig           | 1 +
 configs/stm32mp13_defconfig         | 1 +
 configs/stm32mp15-odyssey_defconfig | 1 +
 configs/stm32mp15_defconfig         | 1 +
 configs/stm32mp15_trusted_defconfig | 1 +
 configs/stm32mp21_defconfig         | 1 +
 configs/stm32mp23_defconfig         | 1 +
 configs/stm32mp25_defconfig         | 1 +
 drivers/firmware/scmi/Kconfig       | 1 +
 drivers/reset/Kconfig               | 2 +-
 12 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 94dce5c191c4..8cc210946539 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -80,6 +80,7 @@ CONFIG_CLK_SCMI=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
 CONFIG_DM_I2C=y
diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 180704e75af8..64e2c278a7e0 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -29,6 +29,7 @@ CONFIG_FIRMWARE=y
 CONFIG_NR_DRAM_BANKS=16
 CONFIG_POWER_DOMAIN=y
 CONFIG_RCAR_MFIS_MBOX=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_RESET_SCMI=y
 CONFIG_SCMI_AGENT_MAILBOX=y
 CONFIG_SCMI_FIRMWARE=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 36bf37827e91..b681b91c3f99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -209,6 +209,7 @@ CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_STRATIX_II=y
 CONFIG_FPGA_STRATIX_V=y
diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 6bd139441122..620a6da2efe3 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -70,6 +70,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/stm32mp15-odyssey_defconfig b/configs/stm32mp15-odyssey_defconfig
index 868ba1915f71..5d1c01c99fb3 100644
--- a/configs/stm32mp15-odyssey_defconfig
+++ b/configs/stm32mp15-odyssey_defconfig
@@ -86,6 +86,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
 CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
 CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_STM32=y
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index af2efc7bceb0..c26602b63b6f 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -88,6 +88,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
 CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
 CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_STM32=y
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 226d83357843..d7501612a797 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -89,6 +89,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
 CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
 CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_STM32=y
diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
index 8ad31292579c..6a74a435f8d5 100644
--- a/configs/stm32mp21_defconfig
+++ b/configs/stm32mp21_defconfig
@@ -51,6 +51,7 @@ CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
index 49f47becba64..ed6fdd9662ef 100644
--- a/configs/stm32mp23_defconfig
+++ b/configs/stm32mp23_defconfig
@@ -51,6 +51,7 @@ CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 99b22a68fda6..42335aafeaf3 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -58,6 +58,7 @@ CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
+CONFIG_SCMI_FIRMWARE=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 33e089c460ba..cd912ebe4096 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -3,6 +3,7 @@ config SCMI_FIRMWARE
 	select FIRMWARE
 	select OF_TRANSLATE
 	depends on SANDBOX || DM_MAILBOX || ARM_SMCCC || OPTEE
+	depends on OF_CONTROL
 	help
 	  System Control and Management Interface (SCMI) is a communication
 	  protocol that defines standard interfaces for power, performance
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2fd91d6299cc..66911199c8ba 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -208,7 +208,7 @@ config RESET_RASPBERRYPI
 
 config RESET_SCMI
 	bool "Enable SCMI reset domain driver"
-	select SCMI_FIRMWARE
+	depends on SCMI_FIRMWARE
 	help
 	  Enable this option if you want to support reset controller
 	  devices exposed by a SCMI agent based on SCMI reset domain
-- 
2.43.0

