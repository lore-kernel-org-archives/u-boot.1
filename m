Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A291C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BBF87B4D;
	Mon, 22 Jan 2024 13:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="Rm//7TK6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ejf927oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8101D87B41; Mon, 22 Jan 2024 13:46:50 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1B487B78
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id E33B75C0100;
 Mon, 22 Jan 2024 07:46:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 22 Jan 2024 07:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1705927605; x=
 1706014005; bh=G8fbouIyzvbKS4F2jS4+OrqbiIsOdeKJ1BGz0pN/kUA=; b=R
 m//7TK65npXKWWIWK8zEOqzEt7rNmWi+WqNXZKxKem6x7nqpvJJfPKsVHsP50IJg
 sypifIBqBbcJ8K1yglruWZ32e8gkXhimniMSNCNM7IBeS7q0yHll5LRWQOkutj3F
 NFzf3m5UpTB6SyofT0yZpua87ZvmRJ59FrJJXZLP6rICfsVFQxb8C+2ITdYbtue0
 kbdAULS0oXchlpCdE6fgjiMIQ6Cu7SiqppNfUScOFFenEx3v/IdTL6hCQgBZn6B0
 SMvxJGkMx4PaZQb0MZ0zJ3JZ7JeJCVQteV/PjFgHQRC4HKiUuVVHOUDGlR9hyCGp
 yI1r7YaiCE1tohj4E/OTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705927605; x=
 1706014005; bh=G8fbouIyzvbKS4F2jS4+OrqbiIsOdeKJ1BGz0pN/kUA=; b=E
 jf927oeaqaZJiVKnuHKU6CPxC3AGTWNS8/u1v6sW7xCr0K8vCa2H67jhsLlpm6W7
 q3jC4p7uV4zdzAT5BbaThXlFRw1YLZGD10oKtqoUSQeT6ukbGVaE0ibpP/+9oiXO
 TKhbChZURHR5s31TEhNjT8uWzjp3m6lj4PaGY59QWqiKSkKAZ2W4JXGwjf9ggSPQ
 iEEWmWD9KNQ6LS6NI1IkhLneQTSvqxR1leJEeqbf9FG5aa+zdois6XkaUBO9TAjO
 3iAmdJ1hXYt7bnIFYDR+3Rdn/L5zA4/7EGsizue9CkacBcJmrK6niOHV9kAx1STl
 9s3aekbhEoZWqTdAU4RVw==
X-ME-Sender: <xms:tWOuZeZnnx69h63SenDuQtu89PxiQRr9s-neJOD3txkP2s-1xatKBQ>
 <xme:tWOuZRb9NcUHFTbR69sPw9kR4YaUbd1waDLDyGes7TPcB9Pr7PMW0VdYOFIKbBbqv
 K5NgNFVCw>
X-ME-Received: <xmr:tWOuZY_eBtUJV6w2NVAx-huC9KXk-Y15Vy_J5Eylb-wbJ94JVQ4HLv2u8M_cnDAzVX_2bwg9mKIpODcuUsctpkU-b3F5brSRO0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:tWOuZQqpmFJERUDX4ICQSf2WpVCX0fPFhOLcMtmwH9-cZYsMUJ6SZw>
 <xmx:tWOuZZq5WhA_f2d2cA-Uuy0t1sN7W_fyh6C4G_1pPqSXZTbPtx5ydA>
 <xmx:tWOuZeT-P6DJzyVNeF3rBEmlUH0UHxDREDRsYl_FdiueYyfBXzxhlQ>
 <xmx:tWOuZSDsV_wQqe1dtpjlWxCpM1qk00m1R4OhJYVVA8vLPlc4ydng4A>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:46:41 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Mon, 22 Jan 2024 23:46:38 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] board: rockchip: Add Sonoff iHost board
Date: Mon, 22 Jan 2024 23:46:01 +1100
Message-Id: <20240122124603.3341988-4-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124603.3341988-1-tim@feathertop.org>
References: <20240122124603.3341988-1-tim@feathertop.org>
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

Sonoff iHost is gateway device designed to provide a Smart Home Hub,
it is based on Rockchip RV1126. There is also a version with 2GB RAM
based off the RV1109 dual core SoC however this works with the same
config as the RV1126 for uboot purposes.

Features:
- Rockchip RV1126
- 4GB DDR4
- 8GB eMMC
- microSD slot
- RMII Ethernet PHY
- 1x USB 2.0 Host
- 1x USB 2.0 OTG
- Realtek RTL8723DS WiFi/BT
- EFR32MG21 Silabs Zigbee radio
- Speaker/Microphone

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi | 13 +++++
 arch/arm/mach-rockchip/rv1126/Kconfig        |  8 +++
 board/itead/sonoff-ihost/Kconfig             | 16 ++++++
 board/itead/sonoff-ihost/MAINTAINERS         |  6 ++
 configs/sonoff-ihost-rv1126_defconfig        | 60 ++++++++++++++++++++
 include/configs/sonoff-ihost.h               | 18 ++++++
 6 files changed, 121 insertions(+)
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
 create mode 100644 board/itead/sonoff-ihost/Kconfig
 create mode 100644 board/itead/sonoff-ihost/MAINTAINERS
 create mode 100644 configs/sonoff-ihost-rv1126_defconfig
 create mode 100644 include/configs/sonoff-ihost.h

diff --git a/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi b/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
new file mode 100644
index 0000000000..a625660d58
--- /dev/null
+++ b/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rv1126-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
+	};
+};
+
+&sdio {
+	status = "disabled";
+};
diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index a6e2b5903c..55b1112120 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -14,6 +14,13 @@ config TARGET_RV1126_NEU2
 	  IO board and Neu2 needs to mount on top of this IO board in order to
 	  create complete Edgeble Neural Compute Module 2(Neu2) IO platform.
 
+config TARGET_RV1126_SONOFF_IHOST
+	bool "Sonoff iHost smart home hub"
+	help
+	  Sonoff iHost is a smart home gateway based on Rockchip RV1126 SoC.
+	  It features Wifi, Bluetooth and Zigbee radios that are used by many
+	  smart home devices.
+
 config SOC_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
@@ -58,5 +65,6 @@ config TEXT_BASE
 	default 0x600000
 
 source board/edgeble/neural-compute-module-2/Kconfig
+source board/itead/sonoff-ihost/Kconfig
 
 endif
diff --git a/board/itead/sonoff-ihost/Kconfig b/board/itead/sonoff-ihost/Kconfig
new file mode 100644
index 0000000000..30d9a6b3e6
--- /dev/null
+++ b/board/itead/sonoff-ihost/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_RV1126_SONOFF_IHOST
+
+config SYS_BOARD
+	default "sonoff-ihost"
+
+config SYS_VENDOR
+	default "itead"
+
+config SYS_CONFIG_NAME
+	default "sonoff-ihost"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select RAM_ROCKCHIP_DDR4
+
+endif
diff --git a/board/itead/sonoff-ihost/MAINTAINERS b/board/itead/sonoff-ihost/MAINTAINERS
new file mode 100644
index 0000000000..eff9274bea
--- /dev/null
+++ b/board/itead/sonoff-ihost/MAINTAINERS
@@ -0,0 +1,6 @@
+RV1126-SONOFF-IHOST
+M:	Tim Lunn <tim@feathertop.org>
+S:	Maintained
+F:	board/itead/sonoff-ihost
+F:	include/configs/sonoff-ihost.h
+F:	configs/sonoff-ihost-rv1126_defconfig
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
new file mode 100644
index 0000000000..fe99bd92f9
--- /dev/null
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -0,0 +1,60 @@
+CONFIG_ARM=y
+CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="rv1126-sonoff-ihost"
+CONFIG_SYS_MONITOR_LEN=614400
+CONFIG_ROCKCHIP_RV1126=y
+CONFIG_TARGET_RV1126_SONOFF_IHOST=y
+CONFIG_DEBUG_UART_BASE=0xff570000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xe00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SPL_FIT=y
+CONFIG_SPL_LOAD_FIT=y
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_DEFAULT_FDT_FILE="rv1126-sonoff-ihost.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_NO_BSS_LIMIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_GPT=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_ISO_PARTITION is not set
+CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_PWM_ROCKCHIP=y
+# CONFIG_RAM_ROCKCHIP_DEBUG is not set
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSRESET=y
+# CONFIG_TPL_SYSRESET is not set
+CONFIG_DM_THERMAL=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_LZO=y
+CONFIG_ERRNO_STR=y
diff --git a/include/configs/sonoff-ihost.h b/include/configs/sonoff-ihost.h
new file mode 100644
index 0000000000..8ed5d78687
--- /dev/null
+++ b/include/configs/sonoff-ihost.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __SONOFF_IHOST_H
+#define __SONOFF_IHOST_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial\0" \
+		"stderr=serial\0"
+
+#include <configs/rv1126_common.h>
+
+#undef BOOT_TARGET_DEVICES
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0) \
+	func(MMC, mmc, 1)
+
+#endif /*  __SONOFF_IHOST_H */
-- 
2.40.1

