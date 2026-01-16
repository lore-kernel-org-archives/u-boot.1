Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3921DD47CD6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFBE8389A;
	Fri, 16 Jan 2026 11:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eCUYgd/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3228397D; Fri, 16 Jan 2026 11:56:23 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE5D8388D
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=KUs7HrJPseFjMdtM1D93v54L9Zta4ccXAHTRxiMLdNo=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560980;
 b=Grd11YQviV+Ci8ctDZ/Xetm4TOE6v5GyCq5I76Psg3/qtlqbFhyv8kSTISHY0zMMOk/hjDZl
 5ONsYbUrwDNVQCUJQCLObEZ5Z9WQpMrjQPHpXPwFT12FrTM/HwKFkPe3bDQICH+mw2usAApU9mE
 +o93D+5CEgbiT4M4uF/cWDxlJea8w/BmQbQKKjrsUkMbimciSip+I4N+tDsTi9FodsNNw4Iw71v
 L5o5vdsi5HzA84FvDZIK7XVtiLeLIQUYfhBPDryzisNAkbxJtezsAcjYh+4I5caYyl8TdirJOsT
 KKNWcfy6s+Q5iYNVSqCesu9HnGGLrvXbYzEKvBKHOnjFA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560980;
 b=S22v+qk7zXAFTqfXloYTDN+udd5sIO/cNMxM5vDFnmp40k9ceOApTrqLjjf4oGSq6ECUMIz+
 k/Y69iIk417ZskHoON9vXdsN48Y8VR3Fa/I/bckeM7HKh51vTk2mJrSn/l8H8dYIG9H5j8EM4kM
 xp/z9P72fjQ+HT55Dk7xhJ53X81lyxJ/+Gs2hAgyIOA6oJeLeSNa8dfi+h8swojBT0A9ZDzZIeR
 tSykEW06m3hFhIZmipozEG/boPro0xEZLJhUTeokhCBrqAss5xYQvZcQGmTKOObr7nJp2bxs7iS
 S4omAkcmJ1fIYp6WlQKivwnLhDETx/Kuohc+rNyAbt3Xw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Fri, 16 Jan 2026 11:56:20 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 7E616220D9A; Fri, 16 Jan 2026 11:56:04 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Gerber <Paul.Gerber@tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/5] board: tqma6: improve config settings for TQMa6x/MBa6x
Date: Fri, 16 Jan 2026 11:53:35 +0100
Message-ID: <20260116105351.2934665-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dsxbm72tjz1kNh4Q
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: a6e1c88b42aff0c246a2b482bd2f667c
X-cloud-security: scantime:1.899
DKIM-Signature: a=rsa-sha256;
 bh=KUs7HrJPseFjMdtM1D93v54L9Zta4ccXAHTRxiMLdNo=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560979; v=1;
 b=eCUYgd/A6gookt+Gv0wD5/jx3eIuMMNdfWHa/c+vznOWLIlt6S+eoJBPXYGdX+RGD//1Ci99
 0zxHNNLDPTIrd1a3qb0jVJbIiYeZo7RKdsQIGEryAihLwFYsFODIe8FAiOaNl9sOp9eWCadZ8xZ
 pDKie+1m8ffimM+pFnqNKuoNR1htF89+eu/eC+9EF3l2xx5eQ9FNzEf9ZYd+/6v8NS3jhLC6MCL
 QuPDBS1V1Wvt8AuLSTytcRwck6aXN1k3zDUGN4cIO9iv8MiybM857lb1KjTzO/uAnvih9bpVcQo
 d0C5eYoZhMgOo3xcEKnqlnaYCU/qUuZvRfh5hSTecW+lQ==
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

From: Paul Gerber <Paul.Gerber@tq-group.com>

- imply DM_I2C / DM_SPI / DM_MMC / DM_GPIO: boot relevant

- add BUTTON support
- add gpio LED support
- enable CMD_TEMPERATURE to get query temperature in console
- remove Variants that are Kconfig default
- USB ethernet port is not in use by default, remove ethprime

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig             | 4 ++++
 configs/tqma6dl_mba6_mmc_defconfig | 7 +++++--
 configs/tqma6dl_mba6_spi_defconfig | 7 +++++--
 configs/tqma6q_mba6_mmc_defconfig  | 7 +++++--
 configs/tqma6q_mba6_spi_defconfig  | 7 +++++--
 configs/tqma6s_mba6_mmc_defconfig  | 7 +++++--
 configs/tqma6s_mba6_spi_defconfig  | 7 +++++--
 7 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 599b3a72f70..5bdaceae204 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -79,6 +79,10 @@ config MBA6
 	select PHY_MICREL_KSZ90X1
 	select MXC_UART
 	imply OF_UPSTREAM
+	imply DM_I2C
+	imply DM_MMC
+	imply DM_SPI
+	imply DM_GPIO
 	help
 	  Select the MBa6 starterkit. This features a GigE Phy, USB, SD-Card
 	  etc.
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index e2fd022cc38..ece085c3628 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -40,12 +41,14 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index f98775f1ae3..c044cb080b0 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -29,6 +29,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -43,12 +44,14 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index de5a732463f..d5ef9be3a04 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -39,12 +40,14 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 291c1f2fa33..09565189c0a 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -29,6 +29,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -43,12 +44,14 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 8e6935a3c48..9e7e7a0ecf0 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -39,12 +40,14 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 7c499077d0d..61c59fa416c 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -29,6 +29,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -43,12 +44,14 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_FSL_USDHC=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.43.0

