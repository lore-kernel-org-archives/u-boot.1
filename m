Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5C0C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 23:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2362783013;
	Sat, 12 Jul 2025 01:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iNun0QRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC05180FA8; Sat, 12 Jul 2025 01:06:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1600B83010
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 01:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752275192; bh=y9GuTPrU95P652iSBfBDTltCKAZK9lkXKiiLBrBJPTM=;
 b=iNun0QRhCLSdJxG5f0VHcqbf/wg4/ww5UacFCgPYesIOnRShv+a1rfjJ3icOVh5h976tsYr9Z
 1GdpcxxR4gb0iTJCEL8VQXONW50QfoDeEAtJAK8eE177RpLYvPhR/e8olyyf8cX5v9W7GHhKzPX
 JK+jpn3VBzmPLecgn8VqdlmyiWf3A9T8jKguu/rONoseeIgiBDVuw69HJARWqPC1YWjteWa1GSb
 NxxAEXiBvpCFulFQUeOFlEQM04DVz7KxoNGayKAQvkl/NGmunpJGHPDpEyMnTKEZIzD17CeT6iL
 t+ejd8OnNKVJltE9wDBCzMbf/5PcOQvTDPW6H4mC5awg==
X-Forward-Email-ID: 687198f526dc7c4d255622f5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/4] rockchip: rk3576: Add SPI Flash boot support
Date: Fri, 11 Jul 2025 23:06:05 +0000
Message-ID: <20250711230613.217996-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711230613.217996-1-jonas@kwiboo.se>
References: <20250711230613.217996-1-jonas@kwiboo.se>
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

The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
differs slightly compared to prior SoCs:

- Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
- Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
- Booting from sfc1 M0 has not been tested (no board using this config).
- Booting from USB report a new bootsource id 0x81.

Add a RK3576 specific read_brom_bootsource_id() function to help decode
the new bootsource id values and the required boot_devices mapping of
sfc0 and sfc1 to help support booting from SPI flash on RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index fb5a107f47d9..c7ed09e03eec 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -6,6 +6,11 @@
 #include "rockchip-u-boot.dtsi"
 
 / {
+	aliases {
+		spi5 = &sfc0;
+		spi6 = &sfc1;
+	};
+
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
 	};
@@ -16,6 +21,17 @@
 	};
 };
 
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x8000>;
+		};
+	};
+};
+#endif
+
 &cru {
 	bootph-all;
 };
@@ -45,6 +61,16 @@
 	bootph-some-ram;
 };
 
+&fspi0_csn0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&fspi0_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &ioc_grf {
 	bootph-all;
 };
@@ -116,6 +142,16 @@
 	bootph-some-ram;
 };
 
+&sfc0 {
+	bootph-some-ram;
+	u-boot,spl-sfc-no-dma;
+};
+
+&sfc1 {
+	bootph-some-ram;
+	u-boot,spl-sfc-no-dma;
+};
+
 &sys_grf {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index 2b1318f9532f..78f0c4866d5d 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -33,8 +33,17 @@
 #define SGRF_DOMAIN_CON4	0x10
 #define SGRF_DOMAIN_CON5	0x14
 
+enum {
+	BROM_BOOTSOURCE_FSPI0 = 3,
+	BROM_BOOTSOURCE_FSPI1_M0 = 4,
+	BROM_BOOTSOURCE_FSPI1_M1 = 6,
+};
+
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
+	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
+	[BROM_BOOTSOURCE_FSPI1_M0] = "/soc/spi@2a300000/flash@0",
+	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
 };
 
@@ -82,6 +91,20 @@ void board_debug_uart_init(void)
 {
 }
 
+u32 read_brom_bootsource_id(void)
+{
+	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+
+	if (bootsource_id == 0x23)
+		return BROM_BOOTSOURCE_FSPI1_M1;
+	else if (bootsource_id == 0x81)
+		return BROM_BOOTSOURCE_USB;
+	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
+		log_debug("Unknown bootsource %x\n", bootsource_id);
+
+	return bootsource_id;
+}
+
 #define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
 #define HP_CTRL_REG			0x04
 #define TIMER_EN			BIT(0)
-- 
2.49.0

