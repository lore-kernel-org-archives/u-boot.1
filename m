Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A10F8E4A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9959D842C7;
	Fri, 17 Apr 2026 04:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB38842CD; Fri, 17 Apr 2026 04:41:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AAC0842C7
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2edcr033481;
 Fri, 17 Apr 2026 10:40:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:40:39 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 8/8] configs: ae350: Enable ATCSPI200 data merge mode
Date: Fri, 17 Apr 2026 10:40:34 +0800
Message-ID: <20260417024034.4046667-4-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417024034.4046667-1-ycliang@andestech.com>
References: <20260417024034.4046667-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2edcr033481
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

Enable CONFIG_ATCSPI200_SPI_DATA_MERGE for all AE350 board variants
to improve SPI throughput by using 4-byte FIFO access for aligned
transfers.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 configs/ae350_rv32_defconfig            | 1 +
 configs/ae350_rv32_falcon_defconfig     | 1 +
 configs/ae350_rv32_falcon_xip_defconfig | 1 +
 configs/ae350_rv32_spl_defconfig        | 1 +
 configs/ae350_rv32_spl_xip_defconfig    | 1 +
 configs/ae350_rv32_xip_defconfig        | 1 +
 configs/ae350_rv64_defconfig            | 1 +
 configs/ae350_rv64_falcon_defconfig     | 1 +
 configs/ae350_rv64_falcon_xip_defconfig | 1 +
 configs/ae350_rv64_spl_defconfig        | 1 +
 configs/ae350_rv64_spl_xip_defconfig    | 1 +
 configs/ae350_rv64_xip_defconfig        | 1 +
 12 files changed, 12 insertions(+)

diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index d8716d2b8f2..e58e9b1bde3 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -48,6 +48,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index 659be8287ba..7f2e4270cce 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -56,4 +56,5 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index 93b80ef789d..a6ad9a90873 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -58,4 +58,5 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 4b0f52ff42b..9f56d0c4e7c 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -56,6 +56,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index f076f36c73c..375d6f6cc5c 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -57,6 +57,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 4eb59d31bcc..c3fbdb59bc1 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -49,6 +49,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index ca3acabdbf0..b24c64db6d8 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -48,6 +48,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index c7c44671419..e1b95a34777 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -56,4 +56,5 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index ae9c7cfd933..044b3c84c52 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -58,4 +58,5 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index af000ca58ce..0fa0b1cb0d5 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -56,6 +56,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 8c6e2773723..03862ce4ba2 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -57,6 +57,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 617940c830f..01e53998c87 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -49,6 +49,7 @@ CONFIG_FTMAC100=y
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
+CONFIG_ATCSPI200_SPI_DATA_MERGE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ATCWDT200=y
-- 
2.34.1

