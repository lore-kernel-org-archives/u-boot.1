Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A544C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD91F82AA7;
	Sat,  7 Jun 2025 00:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1522582AA7; Sat,  7 Jun 2025 00:46:17 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362D4826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8EC08B4C3524;
 Sat,  7 Jun 2025 00:46:13 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 1/7] configs: use lowercase hex prefix style
Date: Fri,  6 Jun 2025 15:44:56 -0700
Message-ID: <20250606224558.1117422-2-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
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

Use consistent lowercase hex prefix style in configs/*

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/am62x_evm_r5_ethboot_defconfig | 2 +-
 configs/starfive_visionfive2_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
index 0d823743907..96b2c28825f 100644
--- a/configs/am62x_evm_r5_ethboot_defconfig
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -9,7 +9,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
-CONFIG_SPL_BSS_MAX_SIZE=0X3100
+CONFIG_SPL_BSS_MAX_SIZE=0x3100
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e145ced8db8..fd5bd6efa06 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -98,7 +98,7 @@ CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0X50
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_DW=y
-- 
2.49.0

