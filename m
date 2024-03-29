Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D79C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81B8882C8;
	Fri, 29 Mar 2024 20:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IEXpft7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDE58828C; Fri, 29 Mar 2024 20:04:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF138827E
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711739034; bh=K0hg02thEHSRp3VCbDxhvd1fZgdrWjyxrHO1hCT2diY=;
 b=IEXpft7fp1y50n8M7udT24fjGqshm9HNV/Gi5tNupcb2MIqlmhJ90Sa41+dDAKyXVbiVuH/2z
 U4LRJTL0i135Fahw+ENEcKayWcnQfLU0BKrGLOKuyBkZTVZNvoIi+G6VFR7ABL+5GXcWX8mK6x4
 QKYU1gkKRay/NhoTQ978oN4drqPZlfrpNIMEuJ+TkZwJxjor6rQwBZCaDvAtRtL4k/jA//s+dep
 e6M93cmg4wis7tXxhsQTrB8u4lvtx/CkD+rdtb5nPprhfAn3YM4/HD4yqm9aOVC1nerOy5iZ6ms
 6riNNlJ2sUU35Z1s7ThOV9fPLQ2CkjlwCEVrHLtPRcjQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 19/19] rockchip: rk3588-generic: Add support for USB OTG
Date: Fri, 29 Mar 2024 19:02:00 +0000
Message-ID: <20240329190224.3613471-20-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240329190224.3613471-1-jonas@kwiboo.se>
References: <20240329190224.3613471-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66071099c77850cc7d0ca1c8
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

Extend the Generic RK3588S/RK3588 target to also include support for USB
OTG, RockUSB and UMS.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-generic-u-boot.dtsi | 22 ++++++++++++++++++++++
 arch/arm/dts/rk3588-generic.dts         |  3 ++-
 configs/generic-rk3588_defconfig        | 17 +++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
index 853ed58cfe58..225dfa0b682a 100644
--- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
@@ -1,3 +1,25 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk3588s-u-boot.dtsi"
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usbdp_phy0_u3 {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index baafe7463f1b..6fc5892d4219 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3588S/RK3588 with eMMC and SD-card enabled
+ * Minimal generic DT for RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
  */
 
 /dts-v1/;
@@ -31,6 +31,7 @@
 };
 
 &sdmmc {
+	broken-cd;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	disable-wp;
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index b50f4f8b8008..c465b4af66a8 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -15,6 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
@@ -27,27 +28,43 @@ CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+# CONFIG_ADC is not set
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

