Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BC3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AAF8782F;
	Thu, 14 Dec 2023 11:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DB787A46; Thu, 14 Dec 2023 11:12:54 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5267087811
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BEACkW9063651;
 Thu, 14 Dec 2023 18:12:46 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Dec 2023
 18:12:42 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>, CL Wang <cl634@andestech.com>, "Leo
 Yu-Chi Liang" <ycliang@andestech.com>
Subject: [PATCH V3 2/2] configs: andes: add watchdog support fot andes ae350
Date: Thu, 14 Dec 2023 18:12:30 +0800
Message-ID: <20231214101230.824550-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214101230.824550-1-randolph@andestech.com>
References: <20231214101230.824550-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BEACkW9063651
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

It adds the ATCWDT200 support for Andes AE350 platform.
It also enables wdt command support.

Signed-off-by: CL Wang <cl634@andestech.com>
Signed-off-by: Randolph <randolph@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 configs/ae350_rv32_defconfig         | 4 ++++
 configs/ae350_rv32_spl_defconfig     | 4 ++++
 configs/ae350_rv32_spl_xip_defconfig | 4 ++++
 configs/ae350_rv32_xip_defconfig     | 4 ++++
 configs/ae350_rv64_defconfig         | 4 ++++
 configs/ae350_rv64_spl_defconfig     | 4 ++++
 configs/ae350_rv64_spl_xip_defconfig | 4 ++++
 configs/ae350_rv64_xip_defconfig     | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 06cd972a0d..eb4dd90311 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -48,3 +49,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index f469d5bb2b..e09f878329 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -57,3 +58,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index 9672a19c23..850e67a0d9 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -58,3 +59,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index b90200a97e..fa0b52f686 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -49,3 +50,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index a4b9ad6162..e67c9cbf93 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -48,3 +49,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 834a0fbbdd..1a3c294b16 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -57,3 +58,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index b52b8d78d7..f8db0a1a85 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -58,3 +59,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index cc5e751c9b..51509e76c5 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -49,3 +50,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
-- 
2.34.1

