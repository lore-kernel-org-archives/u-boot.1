Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E34BEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E22E864C1;
	Wed, 23 Aug 2023 15:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="U2BjJsMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C094B86421; Wed, 23 Aug 2023 15:59:29 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B7B86416
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001Zv6-AZ; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1YLUQmeIe1kNpdD3A2ESp8qJzfNC5c2xH4iUJDU3W8=;
 b=U2BjJsMzcSzd2Pud9dgTDmh9Y/NqgXCCPnCUjTd9SQhC7wd43xaiQ2RroYW0plut+yrnm4
 sjR4+5uq3hILAeTOMeyWRdMTs7qERW8lo1iKaXADFh4l/USmB5xMDI4NKykP3bS0Ba3AuI
 9UrLgvIo8QxBBhVfhQoBKWBAFI3+gxwt354rfoueGQ5h6YIMVLo7SD5VsRYnI0GBM85nP4
 56x1FJfhW1m/+QLuWOnA6IvP25ddgQTtn/mo1ER6RnuKurlggeYTqpTNlCG4WyT2HfDOgc
 NfQuVohdhGpwsLyqjxmwJkXDeeihk30JZvtVnvBszvVSYTDDQSyZYO+hWUPb7w==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/5] configs: at91: sam9x60: Switch to new reset driver
Date: Wed, 23 Aug 2023 15:58:53 +0200
Message-Id: <20230823135856.376351-3-ada@thorsis.com>
In-Reply-To: <20230823135856.376351-1-ada@thorsis.com>
References: <20230823135856.376351-1-ada@thorsis.com>
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

Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
assert/deassert operations") the compatible "microchip,sam9x60-rstc" for
the sam9x60 reset controller in sam9x60.dtsi is not handled by
CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.  This
resulted in the following error message, when trying to reset from
U-Boot shell:

    U-Boot> reset
    resetting ...
    System reset not supported on this platform
    ### ERROR ### Please RESET the board ###

Fixed by enabling the new driver in the relevant defconfigs.  Tested on
sam9x60-curiosity board.  Defconfigs for sam9x60ek adapted in the same
way, but without testing.  These should be all sam9x60 boards affected
in U-Boot here.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
      - re-enabled SYSRESET and SYSRESET_AT91

 configs/sam9x60_curiosity_mmc1_defconfig | 2 ++
 configs/sam9x60_curiosity_mmc_defconfig  | 2 ++
 configs/sam9x60ek_mmc_defconfig          | 2 ++
 configs/sam9x60ek_nandflash_defconfig    | 2 ++
 configs/sam9x60ek_qspiflash_defconfig    | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/configs/sam9x60_curiosity_mmc1_defconfig b/configs/sam9x60_curiosity_mmc1_defconfig
index 21b2cc2edd..bb5e7d8ed0 100644
--- a/configs/sam9x60_curiosity_mmc1_defconfig
+++ b/configs/sam9x60_curiosity_mmc1_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=200000000
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -79,6 +80,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
index 269f015989..a0f819c002 100644
--- a/configs/sam9x60_curiosity_mmc_defconfig
+++ b/configs/sam9x60_curiosity_mmc_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=200000000
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -79,6 +80,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sam9x60ek_mmc_defconfig b/configs/sam9x60ek_mmc_defconfig
index 2a1399748c..c70c41c278 100644
--- a/configs/sam9x60ek_mmc_defconfig
+++ b/configs/sam9x60ek_mmc_defconfig
@@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=200000000
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -87,6 +88,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
index c6c4686658..569b4e747c 100644
--- a/configs/sam9x60ek_nandflash_defconfig
+++ b/configs/sam9x60ek_nandflash_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=200000000
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -89,6 +90,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sam9x60ek_qspiflash_defconfig b/configs/sam9x60ek_qspiflash_defconfig
index ef2e2db8b8..135cd787f9 100644
--- a/configs/sam9x60ek_qspiflash_defconfig
+++ b/configs/sam9x60ek_qspiflash_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xfffff200
 CONFIG_DEBUG_UART_CLOCK=200000000
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -88,6 +89,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
-- 
2.30.2

