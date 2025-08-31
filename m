Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77041CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8192E83931;
	Sun, 31 Aug 2025 13:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="n7zmnqwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CB98393D; Sun, 31 Aug 2025 13:21:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431B783930
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639276; bh=nfahkjrw0Dw2pn+Xu9vgq+IHM/cRtJ16apOY3gfEBMs=;
 b=n7zmnqwXLXRq3OD3v5LspTInwQaCv78Hx2ooANhZ9NHXEUoCwEJ4U+Ul8Ux9tywbKbipVJ4o+
 fp5WrgMqjIA/M4Poz0Id+WS0T5abNmVYRgEEaZTz28EAp7m0mye1YpJ0a9WRtIEtoGjwFkW6n/W
 eU8KriQDcYGy6pMRimK1asaruKIfdHPwmo2EjvQGm1wPsFYaJLyvlikf6M4ignP1Nb7h2umb/85
 sZYeRgn9+tHsylBD2/cfVB+37AIsZTB/TklPh5CAzZ9gZQUDRaBo2gRFXJ/1k512t0QuvZklBlc
 PnzB6RJ8muavSRUz+mN5KLsyV6splaVIcSIbrAbfK2Jw==
X-Forward-Email-ID: 68b4302a32f03f9a5e908675
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 04/10] rockchip: rk3576: Add SPI Flash boot support
Date: Sun, 31 Aug 2025 11:20:25 +0000
Message-ID: <20250831112046.2642363-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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
Changes in v3:
- Add fspi1m1 pinctrl bootph- props to SoC u-boot.dtsi
- Drop the incomplete support for FSPI1_M0
- Add a short code comment about the re-mapping of bootsource id

v2: No change
---
 arch/arm/dts/rk3576-u-boot.dtsi        | 46 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/rk3576.c | 25 ++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index fb5a107f47d9..dc3771b556a3 100644
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
@@ -45,6 +61,26 @@
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
+&fspi1m1_csn0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&fspi1m1_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &ioc_grf {
 	bootph-all;
 };
@@ -116,6 +152,16 @@
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
index a6c2fbdc4840..a1e8a7572fa4 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -36,8 +36,15 @@
 #define USB_GRF_BASE		0x2601E000
 #define USB3OTG0_CON1		0x0030
 
+enum {
+	BROM_BOOTSOURCE_FSPI0 = 3,
+	BROM_BOOTSOURCE_FSPI1_M1 = 6,
+};
+
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
+	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
+	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
 };
 
@@ -85,6 +92,24 @@ void board_debug_uart_init(void)
 {
 }
 
+u32 read_brom_bootsource_id(void)
+{
+	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+
+	/* Re-map the raw value read from reg to a redefined or existing
+	 * BROM_BOOTSOURCE enum value to avoid having to create a larger
+	 * boot_devices table.
+	 */
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
2.51.0

