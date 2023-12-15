Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FD2C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DADE87C10;
	Fri, 15 Dec 2023 17:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ixypsilon.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ixypsilon.net header.i=@ixypsilon.net header.b="HiWl5Mx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4CE87BE1; Fri, 15 Dec 2023 15:00:24 +0100 (CET)
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3908D87BDA
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ixypsilon.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.nagy@ixypsilon.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cHgViL9urankaoCbzQ4g9W2hBZNg/6l4UexROkaWHiM=; t=1702648822; x=1703858422; 
 b=HiWl5Mx21geLQdHSf0WT38Hkh+3KOw9tx6CxqIuIajUvQ2FuUSRc4s34RYeGvybkAuNOo6kQGSI
 fPYGkoWI/+nEWmWqJhIowj+ZFoc00GWzdb3dExJcxalRigb+iTJWC8XOMEF579/GB8XphqKOlQMUI
 IozVGG7SX6fmCfg+uh/ltXhTCHRHWceDf0MKlV5NeFin/lkWERVBa/+jOG3tPEtXIrrPLIL97Bo3V
 Ah8iN2O8GjxT0waSoX4Pba/2SEt9tZLCXtir2CIAx20ADsJSC0xnCCBMo0BX8kUK3wq1BVTyYkF8y
 RiF20fmNRWET0l14sIBCOAUmRV6DPQb+VhaQ==;
Received: from [192.168.0.1] (helo=librem14.Hitronhub.home)
 by uvw.ixypsilon.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <stefan.nagy@ixypsilon.net>) id 1rE8ji-0007Dl-2M;
 Fri, 15 Dec 2023 15:00:20 +0100
From: Stefan Nagy <stefan.nagy@ixypsilon.net>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] rock-pi-4: Enable SPI flash
Date: Fri, 15 Dec 2023 15:00:15 +0100
Message-Id: <20231215140015.13671-1-stefan.nagy@ixypsilon.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Mailman-Approved-At: Fri, 15 Dec 2023 17:21:13 +0100
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

The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip
(XTX Technology Limited XT25F32).

Sync the devicetrees from Linux to enable spi1 and add a device
node for the NOR flash chip. In the board's defconfig files enable
the Rockchip SPI driver, add XTX SPI flash support and set the
SPI flash default bus identifier.

This patch has been tested on ROCK Pi 4A.

Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
---
 arch/arm/dts/rk3399-rock-pi-4a.dts  | 10 ++++++++++
 arch/arm/dts/rk3399-rock-pi-4c.dts  | 10 ++++++++++
 configs/rock-pi-4-rk3399_defconfig  |  3 +++
 configs/rock-pi-4c-rk3399_defconfig |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts b/arch/arm/dts/rk3399-rock-pi-4a.dts
index 931334aa..d5df8939 100644
--- a/arch/arm/dts/rk3399-rock-pi-4a.dts
+++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
@@ -12,3 +12,13 @@
 	model = "Radxa ROCK Pi 4A";
 	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
 };
+
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts b/arch/arm/dts/rk3399-rock-pi-4c.dts
index d32efab7..de2ebe4c 100644
--- a/arch/arm/dts/rk3399-rock-pi-4c.dts
+++ b/arch/arm/dts/rk3399-rock-pi-4c.dts
@@ -43,6 +43,16 @@
 	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
 };
 
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 84e0dcf0..c45a8c04 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -61,6 +61,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
@@ -74,6 +76,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 5c9fb147..1ca19b4e 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -58,6 +58,8 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
@@ -71,6 +73,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.30.2

