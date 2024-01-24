Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFF7C47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 03:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA9287BDF;
	Wed, 24 Jan 2024 04:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="PKTdFzJN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhsmh/or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4827087BC1; Wed, 24 Jan 2024 04:26:54 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45CC870B5
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 08C2D3200A16;
 Tue, 23 Jan 2024 22:26:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 23 Jan 2024 22:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706066807; x=
 1706153207; bh=KBDop9lP8XN7y8XYvfziVVWhmqTFGEayaQBkwfR9bAw=; b=P
 KTdFzJNRc3A/ED+2RWpf17AbntWqFdVl8LDBu+icVY+15m+eTWuMvkdOWzDWI8Ux
 7uB+64JI+lxyY5djEucGVgrnxOTtvFwxG8y6SH5jvSOuT8cUJMWtk9ddDTwT5L8j
 j+VJih5GYBBswyA/lRANJ0L41b4Y0BAW/1aTCd6yY+78GeOpkIIiwZivMtfAKXB4
 t0lYc1tG6y30m6O5LRb8PFQ1qe+bDwH+zdWaBVDV+mYQR1ggDEFMWLUDHwTsFBlF
 +YvEq+yoQWJlZ7WQB5IUIaR3IUmYFl3hqVXLyDq9eChDcjSc5p7PhqUYCEkYfC8i
 OdZGx7Bi5zxZ/DkxD0KIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706066807; x=
 1706153207; bh=KBDop9lP8XN7y8XYvfziVVWhmqTFGEayaQBkwfR9bAw=; b=v
 hsmh/orb/IKnsD2aiU4P97vDm3Rj+Bw22mJK73xvBFxrEwlMflfVVuCi3tDsDDsw
 s6M4yMXCcHvqg2esmo0lx9sSc8kVgFb2l+y4HhJpKSI1ZcKCu2Kt3Gsy9EdDHFqn
 w47zE+59N0wk+hQM6ykni3yxPmppUtVYw3YWISBVm/dnT8EbQsm3+81uqmrJ2+TQ
 A44OUhgc0DlCP1CHPYRp9XAhwcE9CYmQn5x0Ax02JDjEFYA6Smak+D7NVOrHh9Sw
 SaLr0D0xymNuGPvuNmeTFOAE9mwgwYFFIc7625Lcb7tGZfYzdcSOQG3fWMN8ecqS
 87QUErYkrFTk7Kid2xhZA==
X-ME-Sender: <xms:d4OwZSWiLyesvG7w7VbYBGYpa3gj0aegvqaj4ciBoLB2iSYRM1RVNA>
 <xme:d4OwZeljB1NS7-yCoo8l56trr46YxONidAET_4qcREeIodPf_z16U41piMlgBg40q
 BuEWSZChA>
X-ME-Received: <xmr:d4OwZWY4FR4Yi7ybF70I3qnKs6poWy5Q8ap1HrjR0ZevANIVQy1hYjV1CTgBDFsvPXRAzYjvO0M62S1sEEvG6U6MVth611edKAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:d4OwZZUToJYvIVyiQtXwA3MDuKaCjfSsXfvToHDTTCRYK8gwwNhQkA>
 <xmx:d4OwZcn4X3PVYclWuwVo3RumLyy2o9DE1N-8DHdBAMHa0OsPqy1wjg>
 <xmx:d4OwZecflIFsdRMquAaBOitRb3xe00RDt_lmMYceyuBqLAwyLnKjjw>
 <xmx:d4OwZX-resc-xe-6zxeFEPS-r0TKpdXucGwNXUCqol9xCnMul6j6hw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:26:42 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Wed, 24 Jan 2024 14:26:39 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Chris Morgan <macromorgan@hotmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/6] board: rockchip: Add Sonoff iHost board
Date: Wed, 24 Jan 2024 14:26:00 +1100
Message-Id: <20240124032602.126059-5-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124032602.126059-1-tim@feathertop.org>
References: <20240124032602.126059-1-tim@feathertop.org>
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

Changes in v2:
- Remove board config not required with standard boot

 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi | 13 +++++
 arch/arm/mach-rockchip/rv1126/Kconfig        |  8 +++
 board/itead/sonoff-ihost/Kconfig             | 16 ++++++
 board/itead/sonoff-ihost/MAINTAINERS         |  6 ++
 configs/sonoff-ihost-rv1126_defconfig        | 60 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 include/configs/sonoff-ihost.h               | 10 ++++
 7 files changed, 114 insertions(+)
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
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9fe69fc942..e23ca4231c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -129,6 +129,7 @@ List of mainline supported Rockchip boards:
 
 * rv1126
      - Edgeble Neural Compute Module 2 SoM - Neu2/Neu2k (neu2-io-r1126)
+     - Itead Sonoff iHost (sonoff-ihost-rv1126)
 
 Building
 --------
diff --git a/include/configs/sonoff-ihost.h b/include/configs/sonoff-ihost.h
new file mode 100644
index 0000000000..affc24ddcd
--- /dev/null
+++ b/include/configs/sonoff-ihost.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __SONOFF_IHOST_H
+#define __SONOFF_IHOST_H
+
+#define ROCKCHIP_DEVICE_SETTINGS
+
+#include <configs/rv1126_common.h>
+
+#endif /*  __SONOFF_IHOST_H */
-- 
2.40.1

