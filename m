Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6FEC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 20:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070D58175D;
	Thu, 27 Feb 2025 21:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fPmQ/0xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D296816BD; Thu, 27 Feb 2025 21:51:11 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E4981671
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 21:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22185cddbffso45053825ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740689466; x=1741294266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MJPbITnEs7DAI3K1dWE+IHOxUz3z0c47H8vJ0x0Wfg=;
 b=fPmQ/0xjWkRAfCiXXKL5pE97m1/G1+OV30o11rpgT5pocrj+kvh/I2glaM8jRtj1Tg
 OzeTdcyYcAyKmeBP6NuGdrCvBGANZ1evs1Qs2KbUJSeIthfo2POXtZyLc5O4WRSd9zEH
 pB5izJtcVql7wTOs/Pcuat5i+Oqoop05/XobM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740689466; x=1741294266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MJPbITnEs7DAI3K1dWE+IHOxUz3z0c47H8vJ0x0Wfg=;
 b=R6gjTalH1sHGKFyuF5ogxNSFizNUA8fvzKA1C4X+9IHa+3IFK9QnheIEnyqErf4rVA
 j+uou4wFPkvD0XQHA0uR6ldCIKcW0nHHNsSxa9u7s0s5sDC+xw6NCNdNjtS3vyp8RFVD
 849SwXVYr1YYEEp106sdkrE7YIVqf/h/Ztaz+VE2q+OB4W69MUZ/LsEkBrCP+//ocd9D
 2TKtdg4Izv8D2AEO4afP7GTqzBYaCt3tvvCDXasExB1nYsRa2YiqAb8MxBCXablf9jnC
 kBvOT8yUEGRLGu0DHJz/AtOT1ulkdARXwqrAqESaUTBylXBUB2IvXeMqEZ/Qg/kaPMc3
 +dEA==
X-Gm-Message-State: AOJu0YzdidnjH6jWAJAcRe143GAtr9ROrFmRKPNiNgXxH9ZhpwJpbkY9
 NygJceSnsdOdNuR/DMPraU+pGJIXyziZOVAqumNuJ3YJCcq31MicDrnd4+pWSkz7hYXnrjegk0E
 E7PI=
X-Gm-Gg: ASbGncvCLoJ/upTNKD9EpZHKrLHWkR0nPjGEXOzMHJekB5Nf7SUkgPWIuUH0Oy4di8d
 oiqw1vfYr3C9Y4CSCuzPijJ9CEPmGUNAORBuU5dfEjr0o2qidQuGePxJJjrlw156SJ+sZBDygzG
 3y83Z8oXx3jth6uIBuXWhQ4ilJg4hhIoq8AzEgmRNdTKpbP5U+neRj3dAMqKSp8OWaKsbh+ta4W
 3zcMVau9PJMSbsZ1Nsxf3uokI/Tx6GZVEuqTKhx6OwKnInam+FymoxCr87tc4eqR6PzaLnWs+t7
 2kjpUhItZGEC/BNFXU4YTvOXXuA=
X-Google-Smtp-Source: AGHT+IFyge1m6krBeVSeqTeOv4s+P1DKRIILxLl4YLZcYJ/x/QH/lKkBRESPaVbRr2xd2NiK2rRVxA==
X-Received: by 2002:a05:6a00:2d0c:b0:726:a820:921d with SMTP id
 d2e1a72fcca58-734ac457c3bmr1238650b3a.10.1740689465434; 
 Thu, 27 Feb 2025 12:51:05 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a005fd15sm2153166b3a.168.2025.02.27.12.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 12:51:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 2/2] usb: gadget: Remove the legacy usbtty driver
Date: Thu, 27 Feb 2025 14:51:01 -0600
Message-ID: <20250227205101.4127604-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227205101.4127604-1-trini@konsulko.com>
References: <20250227205101.4127604-1-trini@konsulko.com>
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

The lone user of this driver has been removed for some time. Remove this
driver as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 common/stdio.c           |   3 -
 drivers/serial/Makefile  |   3 -
 drivers/serial/ns16550.c |   8 +-
 drivers/serial/usbtty.c  | 983 ---------------------------------------
 drivers/serial/usbtty.h  |  49 --
 include/serial.h         |  20 -
 include/stdio_dev.h      |   1 -
 lib/Makefile             |   4 -
 8 files changed, 2 insertions(+), 1069 deletions(-)
 delete mode 100644 drivers/serial/usbtty.c
 delete mode 100644 drivers/serial/usbtty.h

diff --git a/common/stdio.c b/common/stdio.c
index a61220ce4b9c..3eeb289dd8bf 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -357,9 +357,6 @@ int stdio_add_devices(void)
 
 	drv_system_init();
 	serial_stdio_init();
-#ifdef CONFIG_USB_TTY
-	drv_usbtty_init();
-#endif
 #ifdef CONFIG_USB_FUNCTION_ACM
 	drv_usbacm_init ();
 #endif
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index ebe692a99635..2ef8ba20cf52 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -63,7 +63,4 @@ obj-$(CONFIG_XEN_SERIAL) += serial_xen.o
 obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
 obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 
-ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_USB_TTY) += usbtty.o
-endif
 obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 0e267d097c53..0cccaaf4b902 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -294,13 +294,9 @@ void ns16550_putc(struct ns16550 *com_port, char c)
 #if !CONFIG_IS_ENABLED(NS16550_MIN_FUNCTIONS)
 char ns16550_getc(struct ns16550 *com_port)
 {
-	while ((serial_in(&com_port->lsr) & UART_LSR_DR) == 0) {
-#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_TTY)
-		extern void usbtty_poll(void);
-		usbtty_poll();
-#endif
+	while ((serial_in(&com_port->lsr) & UART_LSR_DR) == 0)
 		schedule();
-	}
+
 	return serial_in(&com_port->rbr);
 }
 
diff --git a/drivers/serial/usbtty.c b/drivers/serial/usbtty.c
deleted file mode 100644
index b7d77fbb6a9c..000000000000
--- a/drivers/serial/usbtty.c
+++ /dev/null
@@ -1,983 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003
- * Gerry Hamel, geh@ti.com, Texas Instruments
- *
- * (C) Copyright 2006
- * Bryan O'Donoghue, bodonoghue@codehermit.ie
- */
-
-#include <config.h>
-#include <circbuf.h>
-#include <env.h>
-#include <serial.h>
-#include <stdio_dev.h>
-#include <asm/unaligned.h>
-#include "usbtty.h"
-#include "usb_cdc_acm.h"
-#include "usbdescriptors.h"
-
-#ifdef DEBUG
-#define TTYDBG(fmt,args...)\
-	serial_printf("[%s] %s %d: "fmt, __FILE__,__FUNCTION__,__LINE__,##args)
-#else
-#define TTYDBG(fmt,args...) do{}while(0)
-#endif
-
-#if 1
-#define TTYERR(fmt,args...)\
-	serial_printf("ERROR![%s] %s %d: "fmt, __FILE__,__FUNCTION__,\
-	__LINE__,##args)
-#else
-#define TTYERR(fmt,args...) do{}while(0)
-#endif
-
-/*
- * Defines
- */
-#define NUM_CONFIGS    1
-#define MAX_INTERFACES 2
-#define NUM_ENDPOINTS  3
-#define ACM_TX_ENDPOINT 3
-#define ACM_RX_ENDPOINT 2
-#define GSERIAL_TX_ENDPOINT 2
-#define GSERIAL_RX_ENDPOINT 1
-#define NUM_ACM_INTERFACES 2
-#define NUM_GSERIAL_INTERFACES 1
-#define CFG_USBD_DATA_INTERFACE_STR "Bulk Data Interface"
-#define CFG_USBD_CTRL_INTERFACE_STR "Control Interface"
-
-/*
- * Buffers to hold input and output data
- */
-#define USBTTY_BUFFER_SIZE 2048
-static circbuf_t usbtty_input;
-static circbuf_t usbtty_output;
-
-/*
- * Instance variables
- */
-static struct stdio_dev usbttydev;
-static struct usb_device_instance device_instance[1];
-static struct usb_bus_instance bus_instance[1];
-static struct usb_configuration_instance config_instance[NUM_CONFIGS];
-static struct usb_interface_instance interface_instance[MAX_INTERFACES];
-static struct usb_alternate_instance alternate_instance[MAX_INTERFACES];
-/* one extra for control endpoint */
-static struct usb_endpoint_instance endpoint_instance[NUM_ENDPOINTS+1];
-
-/*
- * Global flag
- */
-int usbtty_configured_flag = 0;
-
-/*
- * Serial number
- */
-static char serial_number[16];
-
-/*
- * Descriptors, Strings, Local variables.
- */
-
-/* defined and used by gadget/ep0.c */
-extern struct usb_string_descriptor **usb_strings;
-
-/* Indicies, References */
-static unsigned short rx_endpoint = 0;
-static unsigned short tx_endpoint = 0;
-static unsigned short interface_count = 0;
-static struct usb_string_descriptor *usbtty_string_table[STR_COUNT];
-
-/* USB Descriptor Strings */
-static u8 wstrLang[4] = {4,USB_DT_STRING,0x9,0x4};
-static u8 wstrManufacturer[2 + 2*(sizeof(CONFIG_USBD_MANUFACTURER)-1)];
-static u8 wstrProduct[2 + 2*(sizeof(CONFIG_USBD_PRODUCT_NAME)-1)];
-static u8 wstrSerial[2 + 2*(sizeof(serial_number) - 1)];
-static u8 wstrConfiguration[2 + 2*(sizeof(CFG_USBD_CONFIGURATION_STR)-1)];
-static u8 wstrDataInterface[2 + 2*(sizeof(CFG_USBD_DATA_INTERFACE_STR)-1)];
-static u8 wstrCtrlInterface[2 + 2*(sizeof(CFG_USBD_DATA_INTERFACE_STR)-1)];
-
-/* Standard USB Data Structures */
-static struct usb_interface_descriptor interface_descriptors[MAX_INTERFACES];
-static struct usb_endpoint_descriptor *ep_descriptor_ptrs[NUM_ENDPOINTS];
-static struct usb_configuration_descriptor	*configuration_descriptor = 0;
-static struct usb_device_descriptor device_descriptor = {
-	.bLength = sizeof(struct usb_device_descriptor),
-	.bDescriptorType =	USB_DT_DEVICE,
-	.bcdUSB =		cpu_to_le16(USB_BCD_VERSION),
-	.bDeviceSubClass =	0x00,
-	.bDeviceProtocol =	0x00,
-	.bMaxPacketSize0 =	EP0_MAX_PACKET_SIZE,
-	.idVendor =		cpu_to_le16(CONFIG_USBD_VENDORID),
-	.bcdDevice =		cpu_to_le16(USBTTY_BCD_DEVICE),
-	.iManufacturer =	STR_MANUFACTURER,
-	.iProduct =		STR_PRODUCT,
-	.iSerialNumber =	STR_SERIAL,
-	.bNumConfigurations =	NUM_CONFIGS
-};
-
-/*
- * Static CDC ACM specific descriptors
- */
-
-struct acm_config_desc {
-	struct usb_configuration_descriptor configuration_desc;
-
-	/* Master Interface */
-	struct usb_interface_descriptor interface_desc;
-
-	struct usb_class_header_function_descriptor usb_class_header;
-	struct usb_class_call_management_descriptor usb_class_call_mgt;
-	struct usb_class_abstract_control_descriptor usb_class_acm;
-	struct usb_class_union_function_descriptor usb_class_union;
-	struct usb_endpoint_descriptor notification_endpoint;
-
-	/* Slave Interface */
-	struct usb_interface_descriptor data_class_interface;
-	struct usb_endpoint_descriptor data_endpoints[NUM_ENDPOINTS-1];
-} __attribute__((packed));
-
-static struct acm_config_desc acm_configuration_descriptors[NUM_CONFIGS] = {
-	{
-		.configuration_desc ={
-			.bLength =
-				sizeof(struct usb_configuration_descriptor),
-			.bDescriptorType = USB_DT_CONFIG,
-			.wTotalLength =
-				cpu_to_le16(sizeof(struct acm_config_desc)),
-			.bNumInterfaces = NUM_ACM_INTERFACES,
-			.bConfigurationValue = 1,
-			.iConfiguration = STR_CONFIG,
-			.bmAttributes =
-				BMATTRIBUTE_SELF_POWERED|BMATTRIBUTE_RESERVED,
-			.bMaxPower = USBTTY_MAXPOWER
-		},
-		/* Interface 1 */
-		.interface_desc = {
-			.bLength  = sizeof(struct usb_interface_descriptor),
-			.bDescriptorType = USB_DT_INTERFACE,
-			.bInterfaceNumber = 0,
-			.bAlternateSetting = 0,
-			.bNumEndpoints = 0x01,
-			.bInterfaceClass =
-				COMMUNICATIONS_INTERFACE_CLASS_CONTROL,
-			.bInterfaceSubClass = COMMUNICATIONS_ACM_SUBCLASS,
-			.bInterfaceProtocol = COMMUNICATIONS_V25TER_PROTOCOL,
-			.iInterface = STR_CTRL_INTERFACE,
-		},
-		.usb_class_header = {
-			.bFunctionLength	=
-				sizeof(struct usb_class_header_function_descriptor),
-			.bDescriptorType	= CS_INTERFACE,
-			.bDescriptorSubtype	= USB_ST_HEADER,
-			.bcdCDC	= cpu_to_le16(110),
-		},
-		.usb_class_call_mgt = {
-			.bFunctionLength	=
-				sizeof(struct usb_class_call_management_descriptor),
-			.bDescriptorType	= CS_INTERFACE,
-			.bDescriptorSubtype	= USB_ST_CMF,
-			.bmCapabilities		= 0x00,
-			.bDataInterface		= 0x01,
-		},
-		.usb_class_acm = {
-			.bFunctionLength	=
-				sizeof(struct usb_class_abstract_control_descriptor),
-			.bDescriptorType	= CS_INTERFACE,
-			.bDescriptorSubtype	= USB_ST_ACMF,
-			.bmCapabilities		= 0x00,
-		},
-		.usb_class_union = {
-			.bFunctionLength	=
-				sizeof(struct usb_class_union_function_descriptor),
-			.bDescriptorType	= CS_INTERFACE,
-			.bDescriptorSubtype	= USB_ST_UF,
-			.bMasterInterface	= 0x00,
-			.bSlaveInterface0	= 0x01,
-		},
-		.notification_endpoint = {
-			.bLength =
-				sizeof(struct usb_endpoint_descriptor),
-			.bDescriptorType	= USB_DT_ENDPOINT,
-			.bEndpointAddress	= UDC_INT_ENDPOINT | USB_DIR_IN,
-			.bmAttributes		= USB_ENDPOINT_XFER_INT,
-			.wMaxPacketSize
-				= cpu_to_le16(CFG_USBD_SERIAL_INT_PKTSIZE),
-			.bInterval		= 0xFF,
-		},
-
-		/* Interface 2 */
-		.data_class_interface = {
-			.bLength		=
-				sizeof(struct usb_interface_descriptor),
-			.bDescriptorType	= USB_DT_INTERFACE,
-			.bInterfaceNumber	= 0x01,
-			.bAlternateSetting	= 0x00,
-			.bNumEndpoints		= 0x02,
-			.bInterfaceClass	=
-				COMMUNICATIONS_INTERFACE_CLASS_DATA,
-			.bInterfaceSubClass	= DATA_INTERFACE_SUBCLASS_NONE,
-			.bInterfaceProtocol	= DATA_INTERFACE_PROTOCOL_NONE,
-			.iInterface		= STR_DATA_INTERFACE,
-		},
-		.data_endpoints = {
-			{
-				.bLength		=
-					sizeof(struct usb_endpoint_descriptor),
-				.bDescriptorType	= USB_DT_ENDPOINT,
-				.bEndpointAddress	= UDC_OUT_ENDPOINT | USB_DIR_OUT,
-				.bmAttributes		=
-					USB_ENDPOINT_XFER_BULK,
-				.wMaxPacketSize		=
-					cpu_to_le16(CFG_USBD_SERIAL_BULK_PKTSIZE),
-				.bInterval		= 0xFF,
-			},
-			{
-				.bLength		=
-					sizeof(struct usb_endpoint_descriptor),
-				.bDescriptorType	= USB_DT_ENDPOINT,
-				.bEndpointAddress	= UDC_IN_ENDPOINT | USB_DIR_IN,
-				.bmAttributes		=
-					USB_ENDPOINT_XFER_BULK,
-				.wMaxPacketSize		=
-					cpu_to_le16(CFG_USBD_SERIAL_BULK_PKTSIZE),
-				.bInterval		= 0xFF,
-			},
-		},
-	},
-};
-
-static struct rs232_emu rs232_desc={
-		.dter		=	115200,
-		.stop_bits	=	0x00,
-		.parity		=	0x00,
-		.data_bits	=	0x08
-};
-
-/*
- * Static Generic Serial specific data
- */
-
-struct gserial_config_desc {
-
-	struct usb_configuration_descriptor configuration_desc;
-	struct usb_interface_descriptor	interface_desc[NUM_GSERIAL_INTERFACES];
-	struct usb_endpoint_descriptor data_endpoints[NUM_ENDPOINTS];
-
-} __attribute__((packed));
-
-static struct gserial_config_desc
-gserial_configuration_descriptors[NUM_CONFIGS] ={
-	{
-		.configuration_desc ={
-			.bLength = sizeof(struct usb_configuration_descriptor),
-			.bDescriptorType = USB_DT_CONFIG,
-			.wTotalLength =
-				cpu_to_le16(sizeof(struct gserial_config_desc)),
-			.bNumInterfaces = NUM_GSERIAL_INTERFACES,
-			.bConfigurationValue = 1,
-			.iConfiguration = STR_CONFIG,
-			.bmAttributes =
-				BMATTRIBUTE_SELF_POWERED|BMATTRIBUTE_RESERVED,
-			.bMaxPower = USBTTY_MAXPOWER
-		},
-		.interface_desc = {
-			{
-				.bLength  =
-					sizeof(struct usb_interface_descriptor),
-				.bDescriptorType = USB_DT_INTERFACE,
-				.bInterfaceNumber = 0,
-				.bAlternateSetting = 0,
-				.bNumEndpoints = NUM_ENDPOINTS,
-				.bInterfaceClass =
-					COMMUNICATIONS_INTERFACE_CLASS_VENDOR,
-				.bInterfaceSubClass =
-					COMMUNICATIONS_NO_SUBCLASS,
-				.bInterfaceProtocol =
-					COMMUNICATIONS_NO_PROTOCOL,
-				.iInterface = STR_DATA_INTERFACE
-			},
-		},
-		.data_endpoints  = {
-			{
-				.bLength =
-					sizeof(struct usb_endpoint_descriptor),
-				.bDescriptorType =	USB_DT_ENDPOINT,
-				.bEndpointAddress =	UDC_OUT_ENDPOINT | USB_DIR_OUT,
-				.bmAttributes =		USB_ENDPOINT_XFER_BULK,
-				.wMaxPacketSize =
-					cpu_to_le16(CFG_USBD_SERIAL_OUT_PKTSIZE),
-				.bInterval=		0xFF,
-			},
-			{
-				.bLength =
-					sizeof(struct usb_endpoint_descriptor),
-				.bDescriptorType =	USB_DT_ENDPOINT,
-				.bEndpointAddress =	UDC_IN_ENDPOINT | USB_DIR_IN,
-				.bmAttributes =		USB_ENDPOINT_XFER_BULK,
-				.wMaxPacketSize =
-					cpu_to_le16(CFG_USBD_SERIAL_IN_PKTSIZE),
-				.bInterval =		0xFF,
-			},
-			{
-				.bLength =
-					sizeof(struct usb_endpoint_descriptor),
-				.bDescriptorType =	USB_DT_ENDPOINT,
-				.bEndpointAddress =	UDC_INT_ENDPOINT | USB_DIR_IN,
-				.bmAttributes =		USB_ENDPOINT_XFER_INT,
-				.wMaxPacketSize =
-					cpu_to_le16(CFG_USBD_SERIAL_INT_PKTSIZE),
-				.bInterval =		0xFF,
-			},
-		},
-	},
-};
-
-/*
- * Static Function Prototypes
- */
-
-static void usbtty_init_strings (void);
-static void usbtty_init_instances (void);
-static void usbtty_init_endpoints (void);
-static void usbtty_init_terminal_type(short type);
-static void usbtty_event_handler (struct usb_device_instance *device,
-				usb_device_event_t event, int data);
-static int usbtty_cdc_setup(struct usb_device_request *request,
-				struct urb *urb);
-static int usbtty_configured (void);
-static int write_buffer (circbuf_t * buf);
-static int fill_buffer (circbuf_t * buf);
-
-void usbtty_poll (void);
-
-/* utility function for converting char* to wide string used by USB */
-static void str2wide (char *str, u16 * wide)
-{
-	int i;
-	for (i = 0; i < strlen (str) && str[i]; i++){
-		#if defined(__LITTLE_ENDIAN)
-			wide[i] = (u16) str[i];
-		#elif defined(__BIG_ENDIAN)
-			wide[i] = ((u16)(str[i])<<8);
-		#else
-			#error "__LITTLE_ENDIAN or __BIG_ENDIAN undefined"
-		#endif
-	}
-}
-
-/*
- * Test whether a character is in the RX buffer
- */
-
-int usbtty_tstc(struct stdio_dev *dev)
-{
-	struct usb_endpoint_instance *endpoint =
-		&endpoint_instance[rx_endpoint];
-
-	/* If no input data exists, allow more RX to be accepted */
-	if(usbtty_input.size <= 0){
-		udc_unset_nak(endpoint->endpoint_address&0x03);
-	}
-
-	usbtty_poll ();
-	return (usbtty_input.size > 0);
-}
-
-/*
- * Read a single byte from the usb client port. Returns 1 on success, 0
- * otherwise. When the function is succesfull, the character read is
- * written into its argument c.
- */
-
-int usbtty_getc(struct stdio_dev *dev)
-{
-	char c;
-	struct usb_endpoint_instance *endpoint =
-		&endpoint_instance[rx_endpoint];
-
-	while (usbtty_input.size <= 0) {
-		udc_unset_nak(endpoint->endpoint_address&0x03);
-		usbtty_poll ();
-	}
-
-	buf_pop (&usbtty_input, &c, 1);
-	udc_set_nak(endpoint->endpoint_address&0x03);
-
-	return c;
-}
-
-/*
- * Output a single byte to the usb client port.
- */
-void usbtty_putc(struct stdio_dev *dev, const char c)
-{
-	if (!usbtty_configured ())
-		return;
-
-	/* If \n, also do \r */
-	if (c == '\n')
-		buf_push (&usbtty_output, "\r", 1);
-
-	buf_push(&usbtty_output, &c, 1);
-
-	/* Poll at end to handle new data... */
-	if ((usbtty_output.size + 2) >= usbtty_output.totalsize) {
-		usbtty_poll ();
-	}
-}
-
-/* usbtty_puts() helper function for finding the next '\n' in a string */
-static int next_nl_pos (const char *s)
-{
-	int i;
-
-	for (i = 0; s[i] != '\0'; i++) {
-		if (s[i] == '\n')
-			return i;
-	}
-	return i;
-}
-
-/*
- * Output a string to the usb client port - implementing flow control
- */
-
-static void __usbtty_puts (const char *str, int len)
-{
-	int maxlen = usbtty_output.totalsize;
-	int space, n;
-
-	/* break str into chunks < buffer size, if needed */
-	while (len > 0) {
-		usbtty_poll ();
-
-		space = maxlen - usbtty_output.size;
-		/* Empty buffer here, if needed, to ensure space... */
-		if (space) {
-			write_buffer (&usbtty_output);
-
-			n = min(space, min(len, maxlen));
-			buf_push (&usbtty_output, str, n);
-
-			str += n;
-			len -= n;
-		}
-	}
-}
-
-void usbtty_puts(struct stdio_dev *dev, const char *str)
-{
-	int n;
-	int len;
-
-	if (!usbtty_configured ())
-		return;
-
-	len = strlen (str);
-	/* add '\r' for each '\n' */
-	while (len > 0) {
-		n = next_nl_pos (str);
-
-		if (str[n] == '\n') {
-			__usbtty_puts(str, n);
-			__usbtty_puts("\r\n", 2);
-			str += (n + 1);
-			len -= (n + 1);
-		} else {
-			/* No \n found.	 All done. */
-			__usbtty_puts (str, n);
-			break;
-		}
-	}
-
-	/* Poll at end to handle new data... */
-	usbtty_poll ();
-}
-
-/*
- * Initialize the usb client port.
- *
- */
-int drv_usbtty_init (void)
-{
-	int rc;
-	char * sn;
-	char * tt;
-	int snlen;
-
-	/* Get serial number */
-	sn = env_get("serial#");
-	if (!sn)
-		sn = "000000000000";
-	snlen = strlen(sn);
-	if (snlen > sizeof(serial_number) - 1) {
-		printf ("Warning: serial number %s is too long (%d > %lu)\n",
-			sn, snlen, (ulong)(sizeof(serial_number) - 1));
-		snlen = sizeof(serial_number) - 1;
-	}
-	memcpy (serial_number, sn, snlen);
-	serial_number[snlen] = '\0';
-
-	/* Decide on which type of UDC device to be.
-	 */
-	tt = env_get("usbtty");
-	if (!tt)
-		tt = "generic";
-	usbtty_init_terminal_type(strcmp(tt,"cdc_acm"));
-
-	/* prepare buffers... */
-	buf_init (&usbtty_input, USBTTY_BUFFER_SIZE);
-	buf_init (&usbtty_output, USBTTY_BUFFER_SIZE);
-
-	/* Now, set up USB controller and infrastructure */
-	udc_init ();		/* Basic USB initialization */
-
-	usbtty_init_strings ();
-	usbtty_init_instances ();
-
-	usbtty_init_endpoints ();
-
-	udc_startup_events (device_instance);/* Enable dev, init udc pointers */
-	udc_connect ();		/* Enable pullup for host detection */
-
-	/* Device initialization */
-	memset (&usbttydev, 0, sizeof (usbttydev));
-
-	strcpy (usbttydev.name, "usbtty");
-	usbttydev.ext = 0;	/* No extensions */
-	usbttydev.flags = DEV_FLAGS_INPUT | DEV_FLAGS_OUTPUT;
-	usbttydev.tstc = usbtty_tstc;	/* 'tstc' function */
-	usbttydev.getc = usbtty_getc;	/* 'getc' function */
-	usbttydev.putc = usbtty_putc;	/* 'putc' function */
-	usbttydev.puts = usbtty_puts;	/* 'puts' function */
-
-	rc = stdio_register (&usbttydev);
-
-	return (rc == 0) ? 1 : rc;
-}
-
-static void usbtty_init_strings (void)
-{
-	struct usb_string_descriptor *string;
-
-	usbtty_string_table[STR_LANG] =
-		(struct usb_string_descriptor*)wstrLang;
-
-	string = (struct usb_string_descriptor *) wstrManufacturer;
-	string->bLength = sizeof(wstrManufacturer);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (CONFIG_USBD_MANUFACTURER, string->wData);
-	usbtty_string_table[STR_MANUFACTURER]=string;
-
-	string = (struct usb_string_descriptor *) wstrProduct;
-	string->bLength = sizeof(wstrProduct);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (CONFIG_USBD_PRODUCT_NAME, string->wData);
-	usbtty_string_table[STR_PRODUCT]=string;
-
-	string = (struct usb_string_descriptor *) wstrSerial;
-	string->bLength = sizeof(serial_number);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (serial_number, string->wData);
-	usbtty_string_table[STR_SERIAL]=string;
-
-	string = (struct usb_string_descriptor *) wstrConfiguration;
-	string->bLength = sizeof(wstrConfiguration);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (CFG_USBD_CONFIGURATION_STR, string->wData);
-	usbtty_string_table[STR_CONFIG]=string;
-
-	string = (struct usb_string_descriptor *) wstrDataInterface;
-	string->bLength = sizeof(wstrDataInterface);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (CFG_USBD_DATA_INTERFACE_STR, string->wData);
-	usbtty_string_table[STR_DATA_INTERFACE]=string;
-
-	string = (struct usb_string_descriptor *) wstrCtrlInterface;
-	string->bLength = sizeof(wstrCtrlInterface);
-	string->bDescriptorType = USB_DT_STRING;
-	str2wide (CFG_USBD_CTRL_INTERFACE_STR, string->wData);
-	usbtty_string_table[STR_CTRL_INTERFACE]=string;
-
-	/* Now, initialize the string table for ep0 handling */
-	usb_strings = usbtty_string_table;
-}
-
-#define init_wMaxPacketSize(x)	le16_to_cpu(get_unaligned(\
-			&ep_descriptor_ptrs[(x) - 1]->wMaxPacketSize));
-
-static void usbtty_init_instances (void)
-{
-	int i;
-
-	/* initialize device instance */
-	memset (device_instance, 0, sizeof (struct usb_device_instance));
-	device_instance->device_state = STATE_INIT;
-	device_instance->device_descriptor = &device_descriptor;
-	device_instance->event = usbtty_event_handler;
-	device_instance->cdc_recv_setup = usbtty_cdc_setup;
-	device_instance->bus = bus_instance;
-	device_instance->configurations = NUM_CONFIGS;
-	device_instance->configuration_instance_array = config_instance;
-
-	/* initialize bus instance */
-	memset (bus_instance, 0, sizeof (struct usb_bus_instance));
-	bus_instance->device = device_instance;
-	bus_instance->endpoint_array = endpoint_instance;
-	bus_instance->max_endpoints = 1;
-	bus_instance->maxpacketsize = 64;
-	bus_instance->serial_number_str = serial_number;
-
-	/* configuration instance */
-	memset (config_instance, 0,
-		sizeof (struct usb_configuration_instance));
-	config_instance->interfaces = interface_count;
-	config_instance->configuration_descriptor = configuration_descriptor;
-	config_instance->interface_instance_array = interface_instance;
-
-	/* interface instance */
-	memset (interface_instance, 0,
-		sizeof (struct usb_interface_instance));
-	interface_instance->alternates = 1;
-	interface_instance->alternates_instance_array = alternate_instance;
-
-	/* alternates instance */
-	memset (alternate_instance, 0,
-		sizeof (struct usb_alternate_instance));
-	alternate_instance->interface_descriptor = interface_descriptors;
-	alternate_instance->endpoints = NUM_ENDPOINTS;
-	alternate_instance->endpoints_descriptor_array = ep_descriptor_ptrs;
-
-	/* endpoint instances */
-	memset (&endpoint_instance[0], 0,
-		sizeof (struct usb_endpoint_instance));
-	endpoint_instance[0].endpoint_address = 0;
-	endpoint_instance[0].rcv_packetSize = EP0_MAX_PACKET_SIZE;
-	endpoint_instance[0].rcv_attributes = USB_ENDPOINT_XFER_CONTROL;
-	endpoint_instance[0].tx_packetSize = EP0_MAX_PACKET_SIZE;
-	endpoint_instance[0].tx_attributes = USB_ENDPOINT_XFER_CONTROL;
-	udc_setup_ep (device_instance, 0, &endpoint_instance[0]);
-
-	for (i = 1; i <= NUM_ENDPOINTS; i++) {
-		memset (&endpoint_instance[i], 0,
-			sizeof (struct usb_endpoint_instance));
-
-		endpoint_instance[i].endpoint_address =
-			ep_descriptor_ptrs[i - 1]->bEndpointAddress;
-
-		endpoint_instance[i].rcv_attributes =
-			ep_descriptor_ptrs[i - 1]->bmAttributes;
-
-		endpoint_instance[i].rcv_packetSize = init_wMaxPacketSize(i);
-
-		endpoint_instance[i].tx_attributes =
-			ep_descriptor_ptrs[i - 1]->bmAttributes;
-
-		endpoint_instance[i].tx_packetSize = init_wMaxPacketSize(i);
-
-		endpoint_instance[i].tx_attributes =
-			ep_descriptor_ptrs[i - 1]->bmAttributes;
-
-		urb_link_init (&endpoint_instance[i].rcv);
-		urb_link_init (&endpoint_instance[i].rdy);
-		urb_link_init (&endpoint_instance[i].tx);
-		urb_link_init (&endpoint_instance[i].done);
-
-		if (endpoint_instance[i].endpoint_address & USB_DIR_IN)
-			endpoint_instance[i].tx_urb =
-				usbd_alloc_urb (device_instance,
-						&endpoint_instance[i]);
-		else
-			endpoint_instance[i].rcv_urb =
-				usbd_alloc_urb (device_instance,
-						&endpoint_instance[i]);
-	}
-}
-
-static void usbtty_init_endpoints (void)
-{
-	int i;
-
-	bus_instance->max_endpoints = NUM_ENDPOINTS + 1;
-	for (i = 1; i <= NUM_ENDPOINTS; i++) {
-		udc_setup_ep (device_instance, i, &endpoint_instance[i]);
-	}
-}
-
-/* usbtty_init_terminal_type
- *
- * Do some late binding for our device type.
- */
-static void usbtty_init_terminal_type(short type)
-{
-	switch(type){
-		/* CDC ACM */
-		case 0:
-			/* Assign endpoint descriptors */
-			ep_descriptor_ptrs[0] =
-				&acm_configuration_descriptors[0].notification_endpoint;
-			ep_descriptor_ptrs[1] =
-				&acm_configuration_descriptors[0].data_endpoints[0];
-			ep_descriptor_ptrs[2] =
-				&acm_configuration_descriptors[0].data_endpoints[1];
-
-			/* Enumerate Device Descriptor */
-			device_descriptor.bDeviceClass =
-				COMMUNICATIONS_DEVICE_CLASS;
-			device_descriptor.idProduct =
-				cpu_to_le16(CONFIG_USBD_PRODUCTID_CDCACM);
-
-			/* Assign endpoint indices */
-			tx_endpoint = ACM_TX_ENDPOINT;
-			rx_endpoint = ACM_RX_ENDPOINT;
-
-			/* Configuration Descriptor */
-			configuration_descriptor =
-				(struct usb_configuration_descriptor*)
-				&acm_configuration_descriptors;
-
-			/* Interface count */
-			interface_count = NUM_ACM_INTERFACES;
-		break;
-
-		/* BULK IN/OUT & Default */
-		case 1:
-		default:
-			/* Assign endpoint descriptors */
-			ep_descriptor_ptrs[0] =
-				&gserial_configuration_descriptors[0].data_endpoints[0];
-			ep_descriptor_ptrs[1] =
-				&gserial_configuration_descriptors[0].data_endpoints[1];
-			ep_descriptor_ptrs[2] =
-				&gserial_configuration_descriptors[0].data_endpoints[2];
-
-			/* Enumerate Device Descriptor */
-			device_descriptor.bDeviceClass = 0xFF;
-			device_descriptor.idProduct =
-				cpu_to_le16(CONFIG_USBD_PRODUCTID_GSERIAL);
-			/* Assign endpoint indices */
-			tx_endpoint = GSERIAL_TX_ENDPOINT;
-			rx_endpoint = GSERIAL_RX_ENDPOINT;
-
-			/* Configuration Descriptor */
-			configuration_descriptor =
-				(struct usb_configuration_descriptor*)
-				&gserial_configuration_descriptors;
-
-			/* Interface count */
-			interface_count = NUM_GSERIAL_INTERFACES;
-		break;
-	}
-}
-
-/******************************************************************************/
-
-static struct urb *next_urb (struct usb_device_instance *device,
-			     struct usb_endpoint_instance *endpoint)
-{
-	struct urb *current_urb = NULL;
-	int space;
-
-	/* If there's a queue, then we should add to the last urb */
-	if (!endpoint->tx_queue) {
-		current_urb = endpoint->tx_urb;
-	} else {
-		/* Last urb from tx chain */
-		current_urb =
-			p2surround (struct urb, link, endpoint->tx.prev);
-	}
-
-	/* Make sure this one has enough room */
-	space = current_urb->buffer_length - current_urb->actual_length;
-	if (space > 0) {
-		return current_urb;
-	} else {		/* No space here */
-		/* First look at done list */
-		current_urb = first_urb_detached (&endpoint->done);
-		if (!current_urb) {
-			current_urb = usbd_alloc_urb (device, endpoint);
-		}
-
-		urb_append (&endpoint->tx, current_urb);
-		endpoint->tx_queue++;
-	}
-	return current_urb;
-}
-
-static int write_buffer (circbuf_t * buf)
-{
-	if (!usbtty_configured ()) {
-		return 0;
-	}
-
-	struct usb_endpoint_instance *endpoint =
-			&endpoint_instance[tx_endpoint];
-	struct urb *current_urb = NULL;
-
-	/* TX data still exists - send it now
-	 */
-	if(endpoint->sent < endpoint->tx_urb->actual_length){
-		if(udc_endpoint_write (endpoint)){
-			/* Write pre-empted by RX */
-			return -1;
-		}
-	}
-
-	if (buf->size) {
-		char *dest;
-
-		int space_avail;
-		int popnum, popped;
-		int total = 0;
-
-		/* Break buffer into urb sized pieces,
-		 * and link each to the endpoint
-		 */
-		while (buf->size > 0) {
-
-			current_urb = next_urb (device_instance, endpoint);
-
-			dest = (char*)current_urb->buffer +
-				current_urb->actual_length;
-
-			space_avail =
-				current_urb->buffer_length -
-				current_urb->actual_length;
-			popnum = min(space_avail, (int)buf->size);
-			if (popnum == 0)
-				break;
-
-			popped = buf_pop (buf, dest, popnum);
-			if (popped == 0)
-				break;
-			current_urb->actual_length += popped;
-			total += popped;
-
-			/* If endpoint->last == 0, then transfers have
-			 * not started on this endpoint
-			 */
-			if (endpoint->last == 0) {
-				if(udc_endpoint_write (endpoint)){
-					/* Write pre-empted by RX */
-					return -1;
-				}
-			}
-
-		}/* end while */
-		return total;
-	}
-
-	return 0;
-}
-
-static int fill_buffer (circbuf_t * buf)
-{
-	struct usb_endpoint_instance *endpoint =
-		&endpoint_instance[rx_endpoint];
-
-	if (endpoint->rcv_urb && endpoint->rcv_urb->actual_length) {
-		unsigned int nb = 0;
-		char *src = (char *) endpoint->rcv_urb->buffer;
-		unsigned int rx_avail = buf->totalsize - buf->size;
-
-		if(rx_avail >= endpoint->rcv_urb->actual_length){
-
-			nb = endpoint->rcv_urb->actual_length;
-			buf_push (buf, src, nb);
-			endpoint->rcv_urb->actual_length = 0;
-
-		}
-		return nb;
-	}
-	return 0;
-}
-
-static int usbtty_configured (void)
-{
-	return usbtty_configured_flag;
-}
-
-/******************************************************************************/
-
-static void usbtty_event_handler (struct usb_device_instance *device,
-				  usb_device_event_t event, int data)
-{
-	switch (event) {
-	case DEVICE_RESET:
-	case DEVICE_BUS_INACTIVE:
-		usbtty_configured_flag = 0;
-		break;
-	case DEVICE_CONFIGURED:
-		usbtty_configured_flag = 1;
-		break;
-
-	case DEVICE_ADDRESS_ASSIGNED:
-		usbtty_init_endpoints ();
-
-	default:
-		break;
-	}
-}
-
-/******************************************************************************/
-
-int usbtty_cdc_setup(struct usb_device_request *request, struct urb *urb)
-{
-	switch (request->bRequest){
-
-		case ACM_SET_CONTROL_LINE_STATE:	/* Implies DTE ready */
-			break;
-		case ACM_SEND_ENCAPSULATED_COMMAND :	/* Required */
-			break;
-		case ACM_SET_LINE_ENCODING :		/* DTE stop/parity bits
-							 * per character */
-			break;
-		case ACM_GET_ENCAPSULATED_RESPONSE :	/* request response */
-			break;
-		case ACM_GET_LINE_ENCODING :		/* request DTE rate,
-							 * stop/parity bits */
-			memcpy (urb->buffer , &rs232_desc, sizeof(rs232_desc));
-			urb->actual_length = sizeof(rs232_desc);
-
-			break;
-		default:
-			return 1;
-	}
-	return 0;
-}
-
-/******************************************************************************/
-
-/*
- * Since interrupt handling has not yet been implemented, we use this function
- * to handle polling.  This is called by the tstc,getc,putc,puts routines to
- * update the USB state.
- */
-void usbtty_poll (void)
-{
-	/* New interrupts? */
-	udc_irq();
-
-	/* Write any output data to host buffer
-	 * (do this before checking interrupts to avoid missing one)
-	 */
-	if (usbtty_configured ()) {
-		write_buffer (&usbtty_output);
-	}
-
-	/* New interrupts? */
-	udc_irq();
-
-	/* Check for new data from host..
-	 * (do this after checking interrupts to get latest data)
-	 */
-	if (usbtty_configured ()) {
-		fill_buffer (&usbtty_input);
-	}
-
-	/* New interrupts? */
-	udc_irq();
-
-}
diff --git a/drivers/serial/usbtty.h b/drivers/serial/usbtty.h
deleted file mode 100644
index b176a7961b8f..000000000000
--- a/drivers/serial/usbtty.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2003
- * Gerry Hamel, geh@ti.com, Texas Instruments
- *
- * (C) Copyright 2006
- * Bryan O'Donoghue, bodonoghue@codehermit.ie, CodeHermit
- */
-
-#ifndef __USB_TTY_H__
-#define __USB_TTY_H__
-
-#include <usbdevice.h>
-#if defined(CONFIG_PPC)
-#include <usb/mpc8xx_udc.h>
-#elif defined(CONFIG_CI_UDC)
-#include <usb/ci_udc.h>
-#endif
-
-#include <usb/udc.h>
-#include <version.h>
-
-#ifndef CFG_USBD_CONFIGURATION_STR
-#define CFG_USBD_CONFIGURATION_STR	"TTY via USB"
-#endif
-
-#define CFG_USBD_SERIAL_OUT_ENDPOINT UDC_OUT_ENDPOINT
-#define CFG_USBD_SERIAL_OUT_PKTSIZE	UDC_OUT_PACKET_SIZE
-#define CFG_USBD_SERIAL_IN_ENDPOINT	UDC_IN_ENDPOINT
-#define CFG_USBD_SERIAL_IN_PKTSIZE	UDC_IN_PACKET_SIZE
-#define CFG_USBD_SERIAL_INT_ENDPOINT UDC_INT_ENDPOINT
-#define CFG_USBD_SERIAL_INT_PKTSIZE	UDC_INT_PACKET_SIZE
-#define CFG_USBD_SERIAL_BULK_PKTSIZE	UDC_BULK_PACKET_SIZE
-
-#define USBTTY_DEVICE_CLASS	COMMUNICATIONS_DEVICE_CLASS
-
-#define USBTTY_BCD_DEVICE	0x00
-#define USBTTY_MAXPOWER		0x00
-
-#define STR_LANG		0x00
-#define STR_MANUFACTURER	0x01
-#define STR_PRODUCT		0x02
-#define STR_SERIAL		0x03
-#define STR_CONFIG		0x04
-#define STR_DATA_INTERFACE	0x05
-#define STR_CTRL_INTERFACE	0x06
-#define STR_COUNT		0x07
-
-#endif
diff --git a/include/serial.h b/include/serial.h
index e5f6d984d28b..0a707ca730d6 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -48,26 +48,6 @@ extern int serial_assign(const char *name);
 extern void serial_reinit_all(void);
 int serial_initialize(void);
 
-/* For usbtty */
-#ifdef CONFIG_USB_TTY
-
-struct stdio_dev;
-
-int usbtty_getc(struct stdio_dev *dev);
-void usbtty_putc(struct stdio_dev *dev, const char c);
-void usbtty_puts(struct stdio_dev *dev, const char *str);
-int usbtty_tstc(struct stdio_dev *dev);
-
-#else
-
-/* stubs */
-#define usbtty_getc(dev) 0
-#define usbtty_putc(dev, a)
-#define usbtty_puts(dev, a)
-#define usbtty_tstc(dev) 0
-
-#endif /* CONFIG_USB_TTY */
-
 struct udevice;
 
 enum serial_par {
diff --git a/include/stdio_dev.h b/include/stdio_dev.h
index 4e3c4708f807..f7f9c10199ee 100644
--- a/include/stdio_dev.h
+++ b/include/stdio_dev.h
@@ -101,7 +101,6 @@ struct stdio_dev *stdio_clone(struct stdio_dev *dev);
 int drv_lcd_init(void);
 int drv_video_init(void);
 int drv_keyboard_init(void);
-int drv_usbtty_init(void);
 int drv_usbacm_init(void);
 int drv_nc_init(void);
 int drv_jtag_console_init(void);
diff --git a/lib/Makefile b/lib/Makefile
index a7bc2f3134a7..a30ce1595d5d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,11 +28,7 @@ obj-y += charset.o
 endif
 endif
 
-ifdef CONFIG_USB_TTY
-obj-y += circbuf.o
-else
 obj-$(CONFIG_CIRCBUF) += circbuf.o
-endif
 
 obj-y += crc8.o
 obj-$(CONFIG_ERRNO_STR) += errno_str.o
-- 
2.43.0

