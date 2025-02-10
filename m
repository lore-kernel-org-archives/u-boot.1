Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A7C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD5A80CF4;
	Mon, 10 Feb 2025 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bZTJPy6W";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="EjgefF8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1850E803CC; Mon, 10 Feb 2025 16:30:12 +0100 (CET)
Received: from a7-43.smtp-out.eu-west-1.amazonses.com
 (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3836807B1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b6ffb-700c49e2-7fde-485c-8352-ab95f58d0e8c-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201409;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=gf6PRq6P1rOgG+xcuxjwCrcsJC6rm4GuD2ZTKP3OyJU=;
 b=bZTJPy6WpJeHesvO9dIKGQoG542Xxc2WhDp1hBk+D4QT3PUh8SUXkmEGdnOwKi3M
 rGJobHhR8gb0j41GhInCUJZ17GMsE7aHJqvlAwwFDeDHUARqz0WneFIcEkkmEGhm2HK
 xZqSICkq5GlOoEZw2lpTdSg+sPRwfC0IfAQUpuBMurj52RyqFMkcYKGNgWatf5/j7Uw
 akMmgpyx/Vfhxat/gufZ9Rob713xMzLn8c2NgxamFYHPFdNmBxwlb+eQkeJpmUMuUSu
 /ewo8qL7GKS5RimhYzoPKwmKX1/5RT2cAy44v0T8sp4DDDs04flll1GvmAsj2lQswGy
 fZwuMrPfyw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201409;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=gf6PRq6P1rOgG+xcuxjwCrcsJC6rm4GuD2ZTKP3OyJU=;
 b=EjgefF8mXH9N8NcadfL5RBKzbvhMW4Tb7nfZL8Vr+if32kL7pvS87aWW/sDZPk8G
 SweOChR8rlL2LfizPWYqapkP23bWvsV6HoZdjY/2X/HyHNe1sX9+NLmVS+PFv+zB5k4
 jdfyGue/AXHbqImJ9JOfDfhCLeh5Dcafzpu1ytFI=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] configs/roc-pc-rk3399_defconfig: Enable SPL DFU for
 roc-pc-rk3399
Date: Mon, 10 Feb 2025 15:30:09 +0000
Message-ID: <01020194f07b6ffb-700c49e2-7fde-485c-8352-ab95f58d0e8c-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.43
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

Add needed configuration to enable SPL DFU.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 configs/roc-pc-rk3399_defconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 0ef86748778..a02deefbaf8 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SYS_MALLOC_F_LEN=0x500000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=30000000
@@ -13,6 +14,7 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ROC_PC_RK3399=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x300000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
@@ -21,10 +23,13 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_SPL_FIT_PRINT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x20000000
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_BINMAN_UBOOT_SYMBOLS is not set
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -32,15 +37,18 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_ROCKCHIP_IODOMAIN=y
@@ -70,6 +78,7 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
@@ -77,6 +86,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
@@ -85,6 +95,8 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_DFU=y
 CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
-- 
2.39.5

