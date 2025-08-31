Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF56ACA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5141483937;
	Sun, 31 Aug 2025 18:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lk7Pn3Vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7A9839AC; Sun, 31 Aug 2025 18:51:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2B883955
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659067; bh=wUWR6IBjG6oZWzGrqcuk/TVtJkUJvjoaLRHVw0GSzY8=;
 b=lk7Pn3VhbK9g0n0Fzy2s5weCFuAcJQeJweyyO6AHETFdMPEzmbmjRHWXVKqG/BYv2OQNPLJF+
 015vCyAeTzNbMqDmJ01DUFArwHYKmMau2FtHiMfJ1RWasYdf/KxYvCGJez9KGrQkLMnYbJXIU0n
 tvluD+Of5kiPMskQppY5+/ArK6Cl9LnHCfGra3fmTIlGrxqne0bijBkvWmpc2coqDhj8hU3FD/F
 U94rWukUF9npqGzRK/geFb8hJfIPAVxWZtiUKtmLIXnnnXuGdtIl2zV3cFaLez3vO/QAMhoT9/7
 4nYCGcuXproCPNCDgWozdBpIDe4cDfmu6X5KmT8YBiUA==
X-Forward-Email-ID: 68b47d777f68b507ca9c3ac4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 11/18] rockchip: odroid-go2: Add support for SPI flash boot
Date: Sun, 31 Aug 2025 16:49:28 +0000
Message-ID: <20250831165001.2749711-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

The ODROID GO2 devices come with onboard SPI flash, add support for
using the SPI flash.

The BootROM seem to expect the IDBlock at 64 KiB offset compared to the
typical 32 KiB offset from start of SPI flash used by other SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3326-u-boot.dtsi | 18 +++++++++++++++++-
 configs/odroid-go2_defconfig    | 11 +++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
index 196604a9987c..be1dd4f91c1b 100644
--- a/arch/arm/dts/rk3326-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-u-boot.dtsi
@@ -6,8 +6,12 @@
 #include "rockchip-u-boot.dtsi"
 
 / {
+	aliases {
+		spi2 = &sfc;
+	};
+
 	chosen {
-		u-boot,spl-boot-order = &sdmmc;
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc;
 	};
 
 	dmc {
@@ -22,6 +26,17 @@
 	};
 };
 
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x10000>;
+		};
+	};
+};
+#endif
+
 &cru {
 	bootph-all;
 };
@@ -102,6 +117,7 @@
 
 &sfc {
 	bootph-some-ram;
+	u-boot,spl-sfc-no-dma;
 };
 
 &sfc_bus2 {
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index a6d02baa520f..09ba6b7fcfaa 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -3,17 +3,23 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=108000000
+CONFIG_SF_DEFAULT_MODE=0x1000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_SF_DEFAULT_BUS=2
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
@@ -30,6 +36,8 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
@@ -70,6 +78,8 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -87,6 +97,7 @@ CONFIG_ROCKCHIP_SDRAM_COMMON=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
+CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
-- 
2.51.0

