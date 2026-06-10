Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692F4CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78CF84971;
	Wed, 10 Jun 2026 16:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tGzKjtnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7E0849CA; Wed, 10 Jun 2026 16:40:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DDF84971
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bec44dcddedso85040666b.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102428; x=1781707228; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EG0cxQpyquTn1wNwTcc0rSRT3Ko1KewKtNjzaEk4RD8=;
 b=tGzKjtnlHPcUBoCLqi+5G60tKSatNL2SpREMye0S8QbupGeJJlyJpOUnacO2QmoKoI
 c5XA2Wq59ROyUuPAOGID0e+vL8eoYrZP9V+tYFvYwTPn3RpnJmCONQlt8TBbAiTBhJ+8
 1snN5Nj6KuwtJSXgIoTGvPgcZMEsBWFH8YwyN77G7OnxLxuBjG0cxLE3WoynO5lf0hNW
 LGUgV6eP5UhJVpiSZIdVvDKjegqn6s/XbROijBec/aSyc8y/J3x3VzXZ5xJwm36uO/lS
 eoQIqz/Q0DGSQ8+8GnpAQ5j1tcHUXBi/AaraN8vYc2TiNlbyGxozUwJEqFD3LTD4Ikoi
 lO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102428; x=1781707228;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EG0cxQpyquTn1wNwTcc0rSRT3Ko1KewKtNjzaEk4RD8=;
 b=KHFK5vEfVfX60Z2tyTohXP4q969K1nH+PYT99l/9dtwNenrnDUeoPsZgu6arGiF6VF
 xuplH8x8V1G+DA3LJ99D0RzEQgoKg9D4uqX0nnD8H8t7/wzONgoexe2dPX4UNlxtMIIl
 +ZzfLGsNTdPiWTOV/uEq4DkSvkfHUOj56egOEgICfq6Dgk8ZMGty45bYfElrSWoaX1tO
 FjXMmfqK3rE/jrSjrxJOD+uTwYE4A37XTsKZjBjm3ox9PyXv4qSY2g6zGslqtvTYK0O4
 ccFH3Ae8jqQnkPCFAVP8F1SOHS37K5PY1m8r/Xu615SzJ/pw0dtJV/JONiHGslCc6/Q4
 dFqg==
X-Gm-Message-State: AOJu0YwFJqnyu2tkORQegnQUzjLySXUoFO3XuQAdT9Gp7P+iDAjG1OfK
 IB0HcTTIaahbEzAV9HiI7px6hrLO+Cy0gR6H6FKALauoix5vlZmLEpGhXoJYsw==
X-Gm-Gg: Acq92OFy88DrulULSGdOUDvOeSU2LvaXFpv23lCJI7TYfDvrGKPA9A8eRTjYLYEzifn
 HaP6OmguV7ekIJgKi9g5mpDp5RolshD4Ozv2Y5iwyIKrBFOj/ah2xxJWOfNEyL7bWj/RrVdyycm
 KPJAZS2EbUl+Gmtg3Se98zYUz5rA2JquSPNH+gQR+aALu3bVVZk5bMa6xq0/oeT9i0Pnf9CmIQ1
 JBScAqsGqgtRswNPWC4zAvI8ZNEX67zQN1TuzkqfDX+ybUWw5lmZtN6BickWlju5nkU6MmpZe9q
 rOW48+6DOLIh44oBzOTTn5YJD60/o3r1BG3tfLktTm0EUfG9VHVlS16NDQU7ENIxOWpEKhHXu1k
 1YWT7BmRJS7yFDrPS7t8oXDzTFDSignQlS+2kKAFPzrpLeyybk2V8FEWMKr+/bhuHRig/+Z45Wf
 PYY8gIHj9TqlOleDTZr29A3gcMMhVcrwnvgwzI0unKE3jeboBbFWG+Qz4NJyNzaMSmXBxL+oNZ
X-Received: by 2002:a17:906:c150:b0:beb:70d3:9a60 with SMTP id
 a640c23a62f3a-bf3734ff8e5mr606667266b.6.1781102428312; 
 Wed, 10 Jun 2026 07:40:28 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf9e1be687fsm205564566b.7.2026.06.10.07.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:40:27 -0700 (PDT)
Message-ID: <091c6188-ccd1-427b-b3fd-28ce1841e0b5@gmail.com>
Date: Wed, 10 Jun 2026 16:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 14/18] Kconfig: usb: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "usb":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/Kconfig          | 16 ++++++-------
 drivers/usb/eth/Kconfig      | 16 ++++++-------
 drivers/usb/gadget/Kconfig   | 22 +++++++++---------
 drivers/usb/host/Kconfig     | 44 ++++++++++++++++++------------------
 drivers/usb/musb-new/Kconfig | 14 ++++++------
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 93c5ee69b253..05ac388ecf2b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -1,7 +1,7 @@
 menuconfig USB
 	bool "USB support"
 	select BLK
-	---help---
+	help
 	  Universal Serial Bus (USB) is a specification for a serial bus
 	  subsystem which offers higher speeds and more features than the
 	  traditional PC serial port.  The bus supplies power to peripherals
@@ -94,7 +94,7 @@ comment "USB peripherals"

 config USB_STORAGE
 	bool "USB Mass Storage support"
-	---help---
+	help
 	  Say Y here if you want to connect USB mass storage devices to your
 	  board's USB port.

@@ -103,7 +103,7 @@ config USB_KEYBOARD
 	depends on DM_USB
 	select DM_KEYBOARD
 	select SYS_STDIO_DEREGISTER
-	---help---
+	help
 	  Say Y here if you want to use a USB keyboard for U-Boot command line
 	  input.

@@ -111,7 +111,7 @@ config USB_ONBOARD_HUB
 	bool "Onboard USB hub support"
 	depends on DM_USB
 	select DEVRES
-	---help---
+	help
 	  Say Y here if you want to support discrete onboard USB hubs that
 	  don't require an additional control bus for initialization, but
 	  need some non-trivial form of initialization, such as enabling a
@@ -163,17 +163,17 @@ choice
 	prompt "USB keyboard polling"
 	default SYS_USB_EVENT_POLL_VIA_INT_QUEUE if ARCH_SUNXI
 	default SYS_USB_EVENT_POLL
-	---help---
+	help
 	  Enable a polling mechanism for USB keyboard.

 config SYS_USB_EVENT_POLL
-    bool "Interrupt polling"
+	bool "Interrupt polling"

 config SYS_USB_EVENT_POLL_VIA_INT_QUEUE
-    bool "Poll via interrupt queue"
+	bool "Poll via interrupt queue"

 config SYS_USB_EVENT_POLL_VIA_CONTROL_EP
-    bool "Poll via control EP"
+	bool "Poll via control EP"

 endchoice

diff --git a/drivers/usb/eth/Kconfig b/drivers/usb/eth/Kconfig
index 2f6bfa8e71b8..b9b77f467437 100644
--- a/drivers/usb/eth/Kconfig
+++ b/drivers/usb/eth/Kconfig
@@ -1,6 +1,6 @@
 menuconfig USB_HOST_ETHER
 	bool "USB to Ethernet Controller Drivers"
-	---help---
+	help
 	  Say Y here if you would like to enable support for USB Ethernet
 	  adapters.

@@ -9,14 +9,14 @@ if USB_HOST_ETHER
 config USB_ETHER_ASIX
 	bool "ASIX AX8817X (USB 2.0) support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support ASIX AX8817X based USB 2.0
 	  Ethernet Devices.

 config USB_ETHER_ASIX88179
 	bool "ASIX AX88179 (USB 3.0) support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support ASIX AX88179 based USB 3.0
 	  Ethernet Devices.

@@ -24,7 +24,7 @@ config USB_ETHER_LAN75XX
 	bool "Microchip LAN75XX support"
 	depends on USB_HOST_ETHER
 	depends on PHYLIB
-	---help---
+	help
 	  Say Y here if you would like to support Microchip LAN75XX Hi-Speed
 	  USB 2.0 to 10/100/1000 Gigabit Ethernet controller.
 	  Supports 10Base-T/ 100Base-TX/1000Base-T.
@@ -34,7 +34,7 @@ config USB_ETHER_LAN78XX
 	bool "Microchip LAN78XX support"
 	depends on USB_HOST_ETHER
 	depends on PHYLIB
-	---help---
+	help
 	  Say Y here if you would like to support Microchip LAN78XX USB 3.1
 	  Gen 1 to 10/100/1000 Gigabit Ethernet controller.
 	  Supports 10Base-T/ 100Base-TX/1000Base-T.
@@ -43,14 +43,14 @@ config USB_ETHER_LAN78XX
 config USB_ETHER_MCS7830
 	bool "MOSCHIP MCS7830 (7730/7830/7832) suppport"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support MOSCHIP MCS7830 based
 	  (7730/7830/7832) USB 2.0 Ethernet Devices.

 config USB_ETHER_RTL8152
 	bool "Realtek RTL8152B/RTL8153 support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support Realtek RTL8152B/RTL8153 base
 	  USB Ethernet Devices. This driver also supports compatible devices
 	  from Samsung, Lenovo, TP-LINK and Nvidia.
@@ -58,7 +58,7 @@ config USB_ETHER_RTL8152
 config USB_ETHER_SMSC95XX
 	bool "SMSC LAN95x support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support SMSC LAN95xx based USB 2.0
 	  Ethernet Devices.

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5390878254ac..e42d5a436964 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -19,10 +19,10 @@ menuconfig USB_GADGET
 	select DM_USB
 	imply CMD_BIND
 	help
-	   USB is a master/slave protocol, organized with one master
-	   host (such as a PC) controlling up to 127 peripheral devices.
-	   The USB hardware is asymmetric, which makes it easier to set up:
-	   you can't connect a "to-the-host" connector to a peripheral.
+	  USB is a master/slave protocol, organized with one master
+	  host (such as a PC) controlling up to 127 peripheral devices.
+	  The USB hardware is asymmetric, which makes it easier to set up:
+	  you can't connect a "to-the-host" connector to a peripheral.

 	   U-Boot can run in the host, or in the peripheral.  In both cases
 	   you need a low level bus controller driver, and some software
@@ -164,10 +164,10 @@ config USB_GADGET_VBUS_DRAW
 	range 2 500
 	default 2
 	help
-	   Some devices need to draw power from USB when they are
-	   configured, perhaps to operate circuitry or to recharge
-	   batteries.  This is in addition to any local power supply,
-	   such as an AC adapter or batteries.
+	  Some devices need to draw power from USB when they are
+	  configured, perhaps to operate circuitry or to recharge
+	  batteries.  This is in addition to any local power supply,
+	  such as an AC adapter or batteries.

 	   Enter the maximum power your device draws through USB, in
 	   milliAmperes.  The permitted range of values is 2 - 500 mA;
@@ -350,9 +350,9 @@ config SPL_DFU_RAM
 	bool "RAM device"
 	depends on SPL_DFU && SPL_RAM_SUPPORT
 	help
-	 select RAM/DDR memory device for loading binary images
-	 (u-boot/kernel) to the selected device partition using
-	 DFU and execute the u-boot/kernel from RAM.
+	  select RAM/DDR memory device for loading binary images
+	  (u-boot/kernel) to the selected device partition using
+	  DFU and execute the u-boot/kernel from RAM.

 endchoice

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d75883e28650..6bbed9cb513b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -24,7 +24,7 @@ config USB_XHCI_HCD
 	bool "xHCI HCD (USB 3.0) support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  The eXtensible Host Controller Interface (xHCI) is standard for USB 3.0
 	  "SuperSpeed" host controller hardware.

@@ -149,7 +149,7 @@ config USB_EHCI_HCD
 	select USB_HOST
 	select EHCI_DESC_BIG_ENDIAN if SYS_BIG_ENDIAN
 	select EHCI_MMIO_BIG_ENDIAN if SYS_BIG_ENDIAN
-	---help---
+	help
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
 	  If your USB host controller supports USB 2.0, you will likely want to
@@ -174,14 +174,14 @@ config USB_EHCI_ATMEL
 	bool  "Support for Atmel on-chip EHCI USB controller"
 	depends on ARCH_AT91
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Atmel chips.

 config USB_EHCI_EXYNOS
 	bool "Support for Samsung Exynos EHCI USB controller"
 	depends on ARCH_EXYNOS
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Samsung Exynos
 	  SoCs.

@@ -191,7 +191,7 @@ config USB_EHCI_MARVELL
 	default y
 	select USB_EHCI_IS_TDI if !ARM64
 	select USB_EHCI_IS_TDI if ALLEYCAT_5
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on MVEBU SoCs.

 config USB_EHCI_MX5
@@ -205,7 +205,7 @@ config USB_EHCI_MX6
 	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT
 	select EHCI_HCD_INIT_AFTER_RESET
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on i.MX6 SoCs.

 config USB_EHCI_MX7
@@ -215,7 +215,7 @@ config USB_EHCI_MX7
 	select PHY if IMX8M || IMX9
 	select NOP_PHY if IMX8M || IMX9
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

 config USB_EHCI_MXS
@@ -230,7 +230,7 @@ config USB_EHCI_MXS
 config USB_EHCI_NPCM
 	bool "Support for Nuvoton NPCM on-chip EHCI USB controller"
 	depends on ARCH_NPCM
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on
 	  Nuvoton NPCM chips.

@@ -240,7 +240,7 @@ config USB_EHCI_OMAP
 	select PHY
 	imply NOP_PHY
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on OMAP3 and later
 	  SoCs.

@@ -255,7 +255,7 @@ if USB_EHCI_MX6 || USB_EHCI_MX7

 config MXC_USB_OTG_HACTIVE
 	bool "USB Power pin high active"
-	---help---
+	help
 	  Set the USB Power pin polarity to be high active (PWR_POL)

 endif
@@ -265,7 +265,7 @@ config USB_EHCI_MSM
 	depends on DM_USB
 	select USB_ULPI
 	select MSM8916_USB_PHY
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Qualcomm
 	  Snapdragon SoCs.

@@ -280,7 +280,7 @@ config USB_EHCI_TEGRA
 	bool "Support for NVIDIA Tegra on-chip EHCI USB controller"
 	depends on ARCH_TEGRA
 	select USB_EHCI_IS_TDI
-	---help---
+	help
 	  Enable support for Tegra on-chip EHCI USB controller. If you enable
 	  ULPI and your PHY needs a different reference clock than the standard
 	  24 MHz then you have to define CFG_ULPI_REF_CLK to the appropriate
@@ -291,14 +291,14 @@ config USB_EHCI_ZYNQ
 	depends on ARCH_ZYNQ
 	default y
 	select USB_EHCI_IS_TDI
-	---help---
+	help
 	  Enable support for Zynq on-chip EHCI USB controller

 config USB_EHCI_GENERIC
 	bool "Support for generic EHCI USB controller"
 	depends on DM_USB
 	default ARCH_SUNXI
-	---help---
+	help
 	  Enables support for generic EHCI controller.

 config EHCI_HCD_INIT_AFTER_RESET
@@ -310,7 +310,7 @@ config USB_EHCI_FSL
 	select EHCI_HCD_INIT_AFTER_RESET
 	select SYS_FSL_USB_INTERNAL_UTMI_PHY if MPC85xx && \
 		!(ARCH_B4860 || ARCH_B4420 || ARCH_P4080 || ARCH_P1020 || ARCH_P2020)
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on FSL chips.

 config SYS_FSL_USB_INTERNAL_UTMI_PHY
@@ -340,7 +340,7 @@ config USB_OHCI_HCD
 	depends on DM && OF_CONTROL
 	select USB_HOST
 	select USB_OHCI_NEW
-	---help---
+	help
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
 	  UHCI specification.  If your USB host controller follows the OHCI spec,
@@ -361,7 +361,7 @@ config USB_OHCI_PCI
 config USB_OHCI_GENERIC
 	bool "Support for generic OHCI USB controller"
 	default ARCH_SUNXI
-	---help---
+	help
 	  Enables support for generic OHCI controller.

 config USB_OHCI_DA8XX
@@ -374,7 +374,7 @@ config USB_OHCI_DA8XX
 config USB_OHCI_NPCM
 	bool "Support for Nuvoton NPCM on-chip OHCI USB controller"
 	depends on ARCH_NPCM
-	---help---
+	help
 	  Enables support for the on-chip OHCI controller on
 	  Nuvoton NPCM chips.

@@ -391,7 +391,7 @@ config SYS_OHCI_SWAP_REG_ACCESS
 config USB_UHCI_HCD
 	bool "UHCI HCD (most Intel and VIA) support"
 	select USB_HOST
-	---help---
+	help
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
 	  host controller). If your USB host controller conforms to this
@@ -410,7 +410,7 @@ config USB_DWC2
 	bool "DesignWare USB2 Core support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  The DesignWare USB 2.0 controller is compliant with the
 	  USB-Implementers Forum (USB-IF) USB 2.0 specifications.
 	  Hi-Speed (480 Mbps), Full-Speed (12 Mbps), and Low-Speed (1.5 Mbps)
@@ -421,7 +421,7 @@ if USB_DWC2
 config USB_DWC2_BUFFER_SIZE
 	int "Data buffer size in kB"
 	default 64
-	---help---
+	help
 	  By default 64 kB buffer is used but if amount of RAM avaialble on
 	  the target is not enough to accommodate allocation of buffer of
 	  that size it is possible to shrink it. Smaller sizes should be fine
@@ -433,7 +433,7 @@ config USB_R8A66597_HCD
 	bool "Renesas R8A66597 USB Core support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  This enables support for the on-chip Renesas R8A66597 USB 2.0
 	  controller, present in various RZ and SH SoCs.

diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index f8daaddc657e..6fb37c787dec 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -23,11 +23,11 @@ config USB_MUSB_GADGET

 if USB_MUSB_HOST || USB_MUSB_GADGET
 config USB_MUSB_SC5XX
-        bool "Analog Devices MUSB support"
-        depends on (SC57X || SC58X)
+	bool "Analog Devices MUSB support"
+	depends on (SC57X || SC58X)
 	help
-	 Say y here to enable support for the USB controller on
-	 ADI SC57X/SC58X processors.
+	  Say y here to enable support for the USB controller on
+	  ADI SC57X/SC58X processors.

 config USB_MUSB_DA8XX
 	bool "Enable DA8xx MUSB Controller"
@@ -81,9 +81,9 @@ config USB_MUSB_SUNXI
 	depends on PHY_SUN4I_USB
 	select USB_MUSB_PIO_ONLY
 	default y
-	---help---
-	Say y here to enable support for the sunxi OTG / DRC USB controller
-	used on almost all sunxi boards.
+	help
+	  Say y here to enable support for the sunxi OTG / DRC USB controller
+	  used on almost all sunxi boards.

 config USB_MUSB_UX500
 	bool "Enable ST-Ericsson Ux500 USB controller"
--
2.39.5

