Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 17:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AB786F26;
	Sun, 12 Nov 2023 18:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="V073Af1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A8F86F26; Sun, 12 Nov 2023 18:49:32 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9503886DB8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 18:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4dd=G2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699811361; bh=5qjfCD8IqC4bufuMWt4K6V/jpsvkPHCenP3Rq6AuMRQ=;
 b=V073Af1rQHZfI49KgYVFthZT0QuXdSSeYFZ6n2vGKihNhgpkq+IIhrDDQ1nqcE/oe+pm6b9S1
 gls/IIDA6wEI785Bb5+3Lznzkkh3ClyXNZity961qRDeJjHHWyuXiZuQrX2/p9olhQ3BngFPJW3
 zqMeduxycMygduMgGiTq9TfDhW8kKV9t9oqJKAtk51v6oZU6eNhEw+MsJD3QNlZUXk+Pd5+4VWU
 cJji0Meq+rkgGywLScJdiU+M1vIbykedvSIFocD5QDVRw2amwiKQ4EFu6mUFJpFZXBRsT4afqpW
 aTFKDMnRoiBmMaSpV2PKtue76Bqc1p8vPAAuNPIQjuFA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Bharat Gooty
 <bharat.gooty@broadcom.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, John Clark <inindev@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] rockchip: board: Remove dwc3 usb init and gadget
 handler functions
Date: Sun, 12 Nov 2023 17:48:58 +0000
Message-ID: <20231112174904.1581187-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112174904.1581187-1-jonas@kwiboo.se>
References: <20231112174904.1581187-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6551102133f2b3120541d6ad
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

Remove board_usb_init() and dm_usb_gadget_handle_interrupts() functions
related to dwc3, they use e.g. a hard-coded reg address for RK3399 and
are obsolete with use of DM_USB_GADGET.

Use of DM_USB_GADGET, USB_DWC3_GENERIC and USB_DWC3_GADGET have replaced
same feature provided by the removed functions on RK3399 boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Set DM_USB_GADGET for ARCH_ROCKCHIP when USB_DWC3_GADGET is enabled
  to ensure same functionality is provided
- Remove DM_USB_GADGET from a few more defconfig files

 arch/arm/Kconfig                         |  1 +
 arch/arm/mach-rockchip/board.c           | 30 +-----------------------
 configs/nanopc-t6-rk3588_defconfig       |  1 -
 configs/orangepi-5-plus-rk3588_defconfig |  1 -
 configs/orangepi-5-rk3588s_defconfig     |  1 -
 configs/rock5a-rk3588s_defconfig         |  1 -
 configs/rock5b-rk3588_defconfig          |  1 -
 7 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c9842..c39ae40335a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1974,6 +1974,7 @@ config ARCH_ROCKCHIP
 	select DM_SERIAL
 	select DM_SPI
 	select DM_SPI_FLASH
+	select DM_USB_GADGET if USB_DWC3_GADGET
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select OF_CONTROL
 	select SPI
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0e9..38a2a4b95ec0 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -208,10 +208,8 @@ void enable_caches(void)
 }
 #endif
 
-#if defined(CONFIG_USB_GADGET)
+#if defined(CONFIG_USB_GADGET) && defined(CONFIG_USB_GADGET_DWC2_OTG)
 #include <usb.h>
-
-#if defined(CONFIG_USB_GADGET_DWC2_OTG)
 #include <linux/usb/otg.h>
 #include <usb/dwc2_udc.h>
 
@@ -287,32 +285,6 @@ int board_usb_cleanup(int index, enum usb_init_type init)
 }
 #endif /* CONFIG_USB_GADGET_DWC2_OTG */
 
-#if defined(CONFIG_USB_DWC3_GADGET) && !defined(CONFIG_DM_USB_GADGET)
-#include <dwc3-uboot.h>
-
-static struct dwc3_device dwc3_device_data = {
-	.maximum_speed = USB_SPEED_HIGH,
-	.base = 0xfe800000,
-	.dr_mode = USB_DR_MODE_PERIPHERAL,
-	.index = 0,
-	.dis_u2_susphy_quirk = 1,
-	.hsphy_mode = USBPHY_INTERFACE_MODE_UTMIW,
-};
-
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	dwc3_uboot_handle_interrupt(dev);
-	return 0;
-}
-
-int board_usb_init(int index, enum usb_init_type init)
-{
-	return dwc3_uboot_init(&dwc3_device_data);
-}
-#endif /* CONFIG_USB_DWC3_GADGET */
-
-#endif /* CONFIG_USB_GADGET */
-
 #if IS_ENABLED(CONFIG_FASTBOOT)
 int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 070399ce2a86..62f307a3f361 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -91,7 +91,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 04736996217e..9ebb8c2244c5 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -94,7 +94,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index feb45a53853b..4b5803dce9be 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -91,7 +91,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index a6471a519514..efa7bcbdcda6 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -75,7 +75,6 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 0595325e8107..6135af04feef 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -99,7 +99,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
-- 
2.42.0

