Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA4C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A66883AB4;
	Thu,  7 Aug 2025 13:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A0684506; Thu,  7 Aug 2025 13:40:53 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CC983A92
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577Bejbm078286
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:40:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:40:45 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 5/6] configs: andes: add Voyager board defconfig
Date: Thu, 7 Aug 2025 19:40:40 +0800
Message-ID: <20250807114040.368578-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577Bejbm078286
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

Add default configuration file for Voyager board.

Signed-off-by: Randolph Sheng-Kai Lin <randolph@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 configs/voyager_spl_defconfig | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 configs/voyager_spl_defconfig

diff --git a/configs/voyager_spl_defconfig b/configs/voyager_spl_defconfig
new file mode 100644
index 00000000000..2e8c822e115
--- /dev/null
+++ b/configs/voyager_spl_defconfig
@@ -0,0 +1,66 @@
+CONFIG_RISCV=y
+CONFIG_TEXT_BASE=0x401800000
+CONFIG_SYS_MALLOC_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x410000000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="qilai-voyager"
+CONFIG_SPL_BSS_START_ADDR=0x400400000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x400100000
+CONFIG_SPL=y
+CONFIG_TARGET_ANDES_VOYAGER=y
+CONFIG_NR_CPUS=4
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_AVAILABLE_HARTS is not set
+CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x410000000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE_F=0x2000
+CONFIG_SYS_PBSIZE=1050
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_SPL_CYCLIC is not set
+CONFIG_BOARD_EARLY_INIT_R=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_CACHE=y
+CONFIG_SYS_PROMPT="RISC-V # "
+CONFIG_CMD_IMLS=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_WDT=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_BOOTP_PREFER_SERVERIP=y
+CONFIG_CMD_CACHE=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_BOOTP_SEND_HOSTNAME=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_MMC=y
+CONFIG_FTSDC010=y
+CONFIG_FTSDC010_SDIO=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_FLASH_CFI_DRIVER=y
+CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_CFI_FLASH_STATUS_POLL=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_FTMAC100=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_ATCSPI200_SPI=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ATCWDT200=y
+# CONFIG_BINMAN_FDT is not set
-- 
2.34.1

