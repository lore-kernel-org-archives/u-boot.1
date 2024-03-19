Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C2C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 02:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B877C88060;
	Tue, 19 Mar 2024 03:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710816359;
	bh=jX5Gml8B/B9uX+VTigVLGUFiHvD4YhApFr1wC5DSrww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRKgdSRxKBoi6CSZZzWu5qb5cd0P5JwApzufDXVc2logLUzBwbxhe1PdCU1+cob0q
	 k6DW/UjGeqtlM+9/U55hOv41G5NEuJBtEIMnsgJT3I+zdzXb95chkU88OudCKi4sE+
	 HaJ71XC2M26q35caQ2Or3B0dvgr1xPLJmS1WNJAj66nCM6T5Il8M0e6dUwgRC7aEYQ
	 7YrZrLi/c8ioAeT5SdnbISDs7+xul40uUQu02bHzNzkiLte2IDcFQ+JmrN/GEKcRC/
	 NpnRF13fxFRYMdOTjwjy4GovaPc4zN4d8iEmsOSWEfAD49eA0xB3oabvim+iqPvOzO
	 PIoBBIDKBR5KA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DBBC288053;
 Tue, 19 Mar 2024 03:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710816358;
 bh=jX5Gml8B/B9uX+VTigVLGUFiHvD4YhApFr1wC5DSrww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k//jprEG/ubX8wf8FjinSxgdKJyZvvGVyHkr9bG4J6pQHWW4Lb1RzUqnmAby5NN+K
 t/mNbYVsAWQH2pSY4fd/nl/aqaumkExR3R5scFpaPy3F1mgfUpKit7ehRxM6N92Yj4
 UftR7aX6kjJmsAGPBtewO+64PqF0DUyPOkC00JToDfJzwQ9Pl7Tx5e6nrXLr0vDn3J
 dBIvbVi9CDYLdrz/WX52Jkw3SHbdkWP+fepKMbyXfgCjcu0Hcic2Ane9XdLb7YxmQd
 g28WB1rw08m6+kv5nrhRhpPW94z+7O7nahBkG8ScgLvyJriMWsX8O1ZYVik4Y56dCE
 zG5gz0L9FnhGw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: stm32: Make PWR regulator driver available on
 STM32MP13xx
Date: Tue, 19 Mar 2024 03:45:08 +0100
Message-ID: <20240319024534.103299-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319024534.103299-1-marex@denx.de>
References: <20240319024534.103299-1-marex@denx.de>
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

This patch makes STM32 PWR regulators available on stm32mp13xx.
This requires TFA to clear RCC_SECCFGR, is disabled by default
on stm32mp13xx and can only be enabled on board config level.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/Kconfig     | 17 +++++++++++++++++
 arch/arm/mach-stm32mp/Kconfig.15x | 16 ----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index b9af03d57e3..d5934a92771 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -155,4 +155,21 @@ source "arch/arm/mach-stm32mp/Kconfig.13x"
 source "arch/arm/mach-stm32mp/Kconfig.15x"
 source "arch/arm/mach-stm32mp/Kconfig.25x"
 source "arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig"
+
+config STM32MP15_PWR
+	bool "Enable driver for STM32MP15x PWR"
+	depends on DM_REGULATOR && DM_PMIC && (STM32MP13X || STM32MP15X)
+	default y if STM32MP15X
+	help
+		This config enables implementation of driver-model pmic and
+		regulator uclass features for access to STM32MP15x PWR.
+
+config SPL_STM32MP15_PWR
+	bool "Enable driver for STM32MP15x PWR in SPL"
+	depends on SPL && SPL_DM_REGULATOR && SPL_DM_PMIC && (STM32MP13X || STM32MP15X)
+	default y if STM32MP15X
+	help
+		This config enables implementation of driver-model pmic and
+		regulator uclass features for access to STM32MP15x PWR in SPL.
+
 endif
diff --git a/arch/arm/mach-stm32mp/Kconfig.15x b/arch/arm/mach-stm32mp/Kconfig.15x
index 71c14eb4955..d99aa9fd694 100644
--- a/arch/arm/mach-stm32mp/Kconfig.15x
+++ b/arch/arm/mach-stm32mp/Kconfig.15x
@@ -77,22 +77,6 @@ config TARGET_ICORE_STM32MP1
 
 endchoice
 
-config STM32MP15_PWR
-	bool "Enable driver for STM32MP15x PWR"
-	depends on DM_REGULATOR && DM_PMIC
-	default y
-	help
-		This config enables implementation of driver-model pmic and
-		regulator uclass features for access to STM32MP15x PWR.
-
-config SPL_STM32MP15_PWR
-	bool "Enable driver for STM32MP15x PWR in SPL"
-	depends on SPL && SPL_DM_REGULATOR && SPL_DM_PMIC
-	default y
-	help
-		This config enables implementation of driver-model pmic and
-		regulator uclass features for access to STM32MP15x PWR in SPL.
-
 config TEXT_BASE
 	default 0xC0100000
 
-- 
2.43.0

