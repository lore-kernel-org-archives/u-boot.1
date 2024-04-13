Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D122C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6DE88253;
	Sat, 13 Apr 2024 20:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q3uEOsQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CA887CF1; Sat, 13 Apr 2024 20:15:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AE88825E
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032144; bh=BPP9wUYRKQNo8/SN+caaeEf3UojbANMAbEpsN+oFhfw=;
 b=q3uEOsQHGKCsjkmCraRWdoATdR+60BRMFH3HD13+Y/trxpP0L+xmhAdNMhfzjNUL8NLKAzTMi
 pN2WJ2Q288G0xcKnSRgUb1ViLF0M78RdmE6Vrm5VnxpMUf30ic6pBiUHOeNr5ES6NjzwGC3WDDE
 LhHsxa5Vt6IHhCWI0vwydVctIW2BGJRh/9n6qzsdGbGojjhPMlQ4g1zHeysTbSWzAmxrBkieQP8
 c7AjxJQ32tN2jkSo9O939Wbyb0eCVFZOXkj1Hz35seyNDmbevlNDKJJsfXc+cAnxH8F5uHmrgHe
 yHm1Hc10HI0rHEe9tAccu5NjmnW4fhr+BUCTcen3/F4g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 19/23] rockchip: rk356x-generic: Add support for SPI flash
Date: Sat, 13 Apr 2024 18:13:53 +0000
Message-ID: <20240413181425.1384357-20-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661acbcf6fbb975d49a65536
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

Add support for booting from SPI flash using the generic RK3566/RK3568
target.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split patch
---
 arch/arm/dts/rk3568-generic-u-boot.dtsi |  7 +++++++
 arch/arm/dts/rk3568-generic.dts         | 14 +++++++++++++-
 configs/generic-rk3568_defconfig        | 15 +++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3568-generic-u-boot.dtsi b/arch/arm/dts/rk3568-generic-u-boot.dtsi
index 6e8307e3bdf6..fd7f5367b759 100644
--- a/arch/arm/dts/rk3568-generic-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-generic-u-boot.dtsi
@@ -1,3 +1,10 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk356x-u-boot.dtsi"
+
+&sfc {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
index 3b9bf8052046..87c3aff26589 100644
--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3566/RK3568 with eMMC and SD-card enabled
+ * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card and SPI flash enabled
  */
 
 /dts-v1/;
@@ -43,6 +43,18 @@
 	status = "okay";
 };
 
+&sfc {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+	};
+};
+
 &uart2 {
 	status = "okay";
 };
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index e7d5e55bbfd8..9276eae63ee3 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -3,11 +3,15 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
 CONFIG_ROCKCHIP_RK3568=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
@@ -21,6 +25,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -43,10 +49,19 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=4
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

