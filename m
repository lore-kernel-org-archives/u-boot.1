Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CBFC47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 06:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C02F87BDE;
	Wed, 24 Jan 2024 07:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4AB87BDF; Wed, 24 Jan 2024 07:22:00 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11305878A5
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40O6LjIc037474;
 Wed, 24 Jan 2024 14:21:45 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Jan 2024
 14:21:42 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <sr@denx.de>, Randolph
 <randolph@andestech.com>, CL Wang <cl634@andestech.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>
Subject: [PATCH V4 2/2] configs: andes: add watchdog support fot andes ae350
Date: Wed, 24 Jan 2024 14:21:33 +0800
Message-ID: <20240124062133.439469-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124062133.439469-1-randolph@andestech.com>
References: <20240124062133.439469-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40O6LjIc037474
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
index 3bfa3e9f8e..35ad62c845 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
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
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index aeb50206d2..41cd457bc3 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
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
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index f15ec301ce..954e2f2de7 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -59,3 +60,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index c40eb043c5..95863595d2 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -50,3 +51,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 7ae938aeb2..988214285a 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
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
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 68ac4325ab..e929320433 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
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
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 839ca335d4..3f92643b07 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -59,3 +60,6 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
 # CONFIG_BINMAN_FDT is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 5432b6d6d7..835f020990 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
@@ -50,3 +51,6 @@ CONFIG_BAUDRATE=38400
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
-- 
2.34.1

