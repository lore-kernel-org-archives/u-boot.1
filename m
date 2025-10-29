Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA7FCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 08:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C87E800D7;
	Wed, 29 Oct 2025 09:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFEA800D7; Wed, 29 Oct 2025 09:20:12 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF11800B1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 09:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 59T8K2oD084622
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 16:20:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 16:20:02 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, Che-Wei Chuang <cnoize@andestech.com>
Subject: [PATCH 1/1] configs: Change default baud rate to 115200
Date: Wed, 29 Oct 2025 16:19:55 +0800
Message-ID: <20251029081955.3400620-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 59T8K2oD084622
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

From: Che-Wei Chuang <cnoize@andestech.com>

Updated DTS and configuration files to set the default baud rate from 38400 to 115200.

Signed-off-by: Che-Wei Chuang <cnoize@andestech.com>
---
 arch/riscv/dts/ae350_32.dts             | 4 ++--
 arch/riscv/dts/ae350_64.dts             | 4 ++--
 configs/ae350_rv32_defconfig            | 2 +-
 configs/ae350_rv32_falcon_defconfig     | 2 +-
 configs/ae350_rv32_falcon_xip_defconfig | 2 +-
 configs/ae350_rv32_spl_defconfig        | 2 +-
 configs/ae350_rv32_spl_xip_defconfig    | 2 +-
 configs/ae350_rv32_xip_defconfig        | 2 +-
 configs/ae350_rv64_defconfig            | 2 +-
 configs/ae350_rv64_falcon_defconfig     | 2 +-
 configs/ae350_rv64_falcon_xip_defconfig | 2 +-
 configs/ae350_rv64_spl_defconfig        | 2 +-
 configs/ae350_rv64_spl_xip_defconfig    | 2 +-
 configs/ae350_rv64_xip_defconfig        | 2 +-
 14 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/dts/ae350_32.dts b/arch/riscv/dts/ae350_32.dts
index 61af6d5465e..cf2d429c7c0 100644
--- a/arch/riscv/dts/ae350_32.dts
+++ b/arch/riscv/dts/ae350_32.dts
@@ -17,8 +17,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,38400n8 debug loglevel=7";
-		stdout-path = "uart0:38400n8";
+		bootargs = "console=ttyS0,115200n8 debug loglevel=7";
+		stdout-path = "uart0:115200n8";
 	};
 
 	cpus {
diff --git a/arch/riscv/dts/ae350_64.dts b/arch/riscv/dts/ae350_64.dts
index 8c7db29b4f2..1928221fa3c 100644
--- a/arch/riscv/dts/ae350_64.dts
+++ b/arch/riscv/dts/ae350_64.dts
@@ -17,8 +17,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,38400n8 debug loglevel=7";
-		stdout-path = "uart0:38400n8";
+		bootargs = "console=ttyS0,115200n8 debug loglevel=7";
+		stdout-path = "uart0:115200n8";
 	};
 
 	cpus {
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index e87782005f1..973ca298a05 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -45,7 +45,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index f1d88f8560f..b8049aa8abc 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index 2355bac5019..1895d52a180 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 6655cbd4a96..1e55bd48787 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index 44a6b6534b8..d66e3a32323 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 15f3b5c378b..3fc5b4a1a01 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -46,7 +46,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 78b9fc439ac..2da15974c37 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -45,7 +45,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index 81bebb1a1d4..fcaddef3150 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index 8e1b8e20052..ae31675cc9c 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 7950074642e..a85150dfc01 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index d5882af1de1..34321d627be 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 46ce063c484..e03fe94dff9 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -46,7 +46,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
-CONFIG_BAUDRATE=38400
+CONFIG_BAUDRATE=115200
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
-- 
2.34.1

