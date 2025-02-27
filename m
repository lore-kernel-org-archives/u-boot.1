Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5C5C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 20:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8A081658;
	Thu, 27 Feb 2025 21:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="berTy4ha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01A181429; Thu, 27 Feb 2025 21:51:09 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1B081668
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 21:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2211acda7f6so33321915ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740689464; x=1741294264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EMRaPifRPRF16I+gO+EKRc38gVaxlfbN/IEfV+YSnfs=;
 b=berTy4haMDFt94UYQpm5pB/oMfVeRvvPEj0CrDJ6/4OyoP+twrDfkIXmJRZtoE+vRT
 mCDSGluMgb1flYG4urwqpu55PCB28U60aBHpWXgMAe1VWpWjOK25Opw9OnWV76Yi1z5s
 cwzFWuZeRXsmePz2delXLiWtvPT0JmA070wPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740689464; x=1741294264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMRaPifRPRF16I+gO+EKRc38gVaxlfbN/IEfV+YSnfs=;
 b=Vl/wBO/kmqnf//XQc0gzpkwwvASHaJElMpQzEFQxwkOKXN7i8Z+gFqpkKdfDUK2AU5
 giavK6unUdKdL5LBnsYKpN5+pNlYg3x9O+ud81JClm8lWsa4wcHsJfa+x+XGkrmnVkeA
 zxpU4eMi3P57Gy7oNOcklbxhcJR5IaGf7iHinBVjrUTNLQxazPon74llTk82bv1wJHaa
 vrY+Rr44TwzZxP2o5jLat+jEBkKGQhl4RJMya5Ynpg/91iifCnLybu8EFTsGSlYLN0KM
 CrrFUVrjwtw8Vi8q3TGbUSYvT7mYRezYLORIEH2S0FMRdcmJ94/d2CtIHAPnUpVAjr8J
 shnA==
X-Gm-Message-State: AOJu0Yzm7yrTVxA+GbyEcRgZ05werlX8IwiaJAi9PZ/hIoYuED8yVLzD
 CAI1M6LCWFlqAP0MEksVqWs1g91hR6REndekNfxalhLs+MfbPHzuwTJevKCmFal5bGbJURBFrxm
 2ytU=
X-Gm-Gg: ASbGncsg5+AAK7WCsbDIwjr2PRfagKGZ26Z4f1IaunetVjpBvxmKkENmgbaO3V6Om4N
 sk9zjeTI6hCrPLMS9TMBmXrEfHSRDdmAG0bX84L6v4bFi8ZG+8n5yk960JtVHu+QuEGAeCCB09G
 UXyMfUjWzYwlhJht4mzimVoyKudjAXil3T0Dmh1SysiRdexJAsUxdQybxroE+iKWrs5Aje8DcbC
 F64SjwZ86X2DP1lMRiPnAD3812mNYftxZ6yNrUi/6OjhBd8TSisW2PYIQVRt2UePzaDm2kO00Qr
 JyXJZwT9VVfsf7ewkaYw+ZJBx1A=
X-Google-Smtp-Source: AGHT+IGs/4Jp1SAyrGiH1GwPjUPLRLCYf+beRp7KBU9FTcy2IT8YHo3Eal6/1esHHiPxxBnKNbP03A==
X-Received: by 2002:a17:903:2302:b0:223:26da:4b74 with SMTP id
 d9443c01a7336-22368f7b566mr11212245ad.14.1740689463969; 
 Thu, 27 Feb 2025 12:51:03 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a005fd15sm2153166b3a.168.2025.02.27.12.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 12:51:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 1/2] usb: gadget: Remove final remnants of CONFIG_USB_DEVICE
Date: Thu, 27 Feb 2025 14:51:00 -0600
Message-ID: <20250227205101.4127604-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The lone user of the legacy USB device framework have been removed for
some time. Remove the final parts of the code that were missed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 Makefile                      |   1 -
 arch/arm/lib/bootm.c          |   4 -
 arch/riscv/lib/bootm.c        |   4 -
 drivers/usb/gadget/Makefile   |   4 -
 drivers/usb/gadget/core.c     | 621 ----------------------------------
 drivers/usb/gadget/ep0.c      | 619 ---------------------------------
 lib/efi_loader/efi_boottime.c |   2 -
 7 files changed, 1255 deletions(-)
 delete mode 100644 drivers/usb/gadget/core.c
 delete mode 100644 drivers/usb/gadget/ep0.c

diff --git a/Makefile b/Makefile
index 5f90cea11d70..24db7fa38e3d 100644
--- a/Makefile
+++ b/Makefile
@@ -878,7 +878,6 @@ libs-y += drivers/usb/dwc3/
 libs-y += drivers/usb/common/
 libs-y += drivers/usb/emul/
 libs-y += drivers/usb/eth/
-libs-$(CONFIG_USB_DEVICE) += drivers/usb/gadget/
 libs-$(CONFIG_USB_GADGET) += drivers/usb/gadget/
 libs-$(CONFIG_USB_GADGET) += drivers/usb/gadget/udc/
 libs-y += drivers/usb/host/
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400e..7eb764e1f4eb 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -61,10 +61,6 @@ static void announce_and_cleanup(int fake)
 	bootstage_report();
 #endif
 
-#ifdef CONFIG_USB_DEVICE
-	udc_disconnect();
-#endif
-
 	board_quiesce_devices();
 
 	printf("\nStarting kernel ...%s\n\n", fake ?
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 76c610bcee03..9544907ab1eb 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -46,10 +46,6 @@ static void announce_and_cleanup(int fake)
 	bootstage_report();
 #endif
 
-#ifdef CONFIG_USB_DEVICE
-	udc_disconnect();
-#endif
-
 	board_quiesce_devices();
 
 	/*
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 4bda224ff1ac..db5f8895a33a 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -35,7 +35,3 @@ endif
 endif
 
 obj-$(CONFIG_CI_UDC) += ci_udc.o
-
-# Devices not related to the new gadget layer depend on CONFIG_USB_DEVICE
-# This is really only N900 and USBTTY now.
-obj-$(CONFIG_USB_DEVICE) += core.o ep0.o
diff --git a/drivers/usb/gadget/core.c b/drivers/usb/gadget/core.c
deleted file mode 100644
index bcb1ad3082c0..000000000000
--- a/drivers/usb/gadget/core.c
+++ /dev/null
@@ -1,621 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003
- * Gerry Hamel, geh@ti.com, Texas Instruments
- *
- * Based on
- * linux/drivers/usbd/usbd.c.c - USB Device Core Layer
- *
- * Copyright (c) 2000, 2001, 2002 Lineo
- * Copyright (c) 2001 Hewlett Packard
- *
- * By:
- *	Stuart Lynne <sl@lineo.com>,
- *	Tom Rushworth <tbr@lineo.com>,
- *	Bruce Balden <balden@lineo.com>
- */
-
-#include <log.h>
-#include <malloc.h>
-#include <serial.h>
-#include <usbdevice.h>
-
-#define MAX_INTERFACES 2
-
-int maxstrings = 20;
-
-/* Global variables ************************************************************************** */
-
-struct usb_string_descriptor **usb_strings;
-
-int usb_devices;
-
-extern struct usb_function_driver ep0_driver;
-
-int registered_functions;
-int registered_devices;
-
-__maybe_unused static char *usbd_device_events[] = {
-	"DEVICE_UNKNOWN",
-	"DEVICE_INIT",
-	"DEVICE_CREATE",
-	"DEVICE_HUB_CONFIGURED",
-	"DEVICE_RESET",
-	"DEVICE_ADDRESS_ASSIGNED",
-	"DEVICE_CONFIGURED",
-	"DEVICE_SET_INTERFACE",
-	"DEVICE_SET_FEATURE",
-	"DEVICE_CLEAR_FEATURE",
-	"DEVICE_DE_CONFIGURED",
-	"DEVICE_BUS_INACTIVE",
-	"DEVICE_BUS_ACTIVITY",
-	"DEVICE_POWER_INTERRUPTION",
-	"DEVICE_HUB_RESET",
-	"DEVICE_DESTROY",
-	"DEVICE_FUNCTION_PRIVATE",
-};
-
-__maybe_unused static char *usbd_device_status[] = {
-	"USBD_OPENING",
-	"USBD_OK",
-	"USBD_SUSPENDED",
-	"USBD_CLOSING",
-};
-
-#define USBD_DEVICE_STATUS(x) (((unsigned int)x <= USBD_CLOSING) ? usbd_device_status[x] : "UNKNOWN")
-
-/* Descriptor support functions ************************************************************** */
-
-/**
- * usbd_get_string - find and return a string descriptor
- * @index: string index to return
- *
- * Find an indexed string and return a pointer to a it.
- */
-struct usb_string_descriptor *usbd_get_string (__u8 index)
-{
-	if (index >= maxstrings) {
-		return NULL;
-	}
-	return usb_strings[index];
-}
-
-/* Access to device descriptor functions ***************************************************** */
-
-/* *
- * usbd_device_configuration_instance - find a configuration instance for this device
- * @device:
- * @configuration: index to configuration, 0 - N-1
- *
- * Get specifed device configuration. Index should be bConfigurationValue-1.
- */
-static struct usb_configuration_instance *usbd_device_configuration_instance (struct usb_device_instance *device,
-		unsigned int port, unsigned int configuration)
-{
-	if (configuration >= device->configurations)
-		return NULL;
-
-	return device->configuration_instance_array + configuration;
-}
-
-/* *
- * usbd_device_interface_instance
- * @device:
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- *
- * Return the specified interface descriptor for the specified device.
- */
-struct usb_interface_instance *usbd_device_interface_instance (struct usb_device_instance *device, int port, int configuration, int interface)
-{
-	struct usb_configuration_instance *configuration_instance;
-
-	if ((configuration_instance = usbd_device_configuration_instance (device, port, configuration)) == NULL) {
-		return NULL;
-	}
-	if (interface >= configuration_instance->interfaces) {
-		return NULL;
-	}
-	return configuration_instance->interface_instance_array + interface;
-}
-
-/* *
- * usbd_device_alternate_descriptor_list
- * @device:
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- * @alternate: alternate setting
- *
- * Return the specified alternate descriptor for the specified device.
- */
-struct usb_alternate_instance *usbd_device_alternate_instance (struct usb_device_instance *device, int port, int configuration, int interface, int alternate)
-{
-	struct usb_interface_instance *interface_instance;
-
-	if ((interface_instance = usbd_device_interface_instance (device, port, configuration, interface)) == NULL) {
-		return NULL;
-	}
-
-	if (alternate >= interface_instance->alternates) {
-		return NULL;
-	}
-
-	return interface_instance->alternates_instance_array + alternate;
-}
-
-/* *
- * usbd_device_device_descriptor
- * @device: which device
- * @configuration: index to configuration, 0 - N-1
- * @port: which port
- *
- * Return the specified configuration descriptor for the specified device.
- */
-struct usb_device_descriptor *usbd_device_device_descriptor (struct usb_device_instance *device, int port)
-{
-	return (device->device_descriptor);
-}
-
-/**
- * usbd_device_configuration_descriptor
- * @device: which device
- * @port: which port
- * @configuration: index to configuration, 0 - N-1
- *
- * Return the specified configuration descriptor for the specified device.
- */
-struct usb_configuration_descriptor *usbd_device_configuration_descriptor (struct
-									   usb_device_instance
-									   *device, int port, int configuration)
-{
-	struct usb_configuration_instance *configuration_instance;
-	if (!(configuration_instance = usbd_device_configuration_instance (device, port, configuration))) {
-		return NULL;
-	}
-	return (configuration_instance->configuration_descriptor);
-}
-
-/**
- * usbd_device_interface_descriptor
- * @device: which device
- * @port: which port
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- * @alternate: alternate setting
- *
- * Return the specified interface descriptor for the specified device.
- */
-struct usb_interface_descriptor *usbd_device_interface_descriptor (struct usb_device_instance
-								   *device, int port, int configuration, int interface, int alternate)
-{
-	struct usb_interface_instance *interface_instance;
-	if (!(interface_instance = usbd_device_interface_instance (device, port, configuration, interface))) {
-		return NULL;
-	}
-	if ((alternate < 0) || (alternate >= interface_instance->alternates)) {
-		return NULL;
-	}
-	return (interface_instance->alternates_instance_array[alternate].interface_descriptor);
-}
-
-/**
- * usbd_device_endpoint_descriptor_index
- * @device: which device
- * @port: which port
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- * @alternate: index setting
- * @index: which index
- *
- * Return the specified endpoint descriptor for the specified device.
- */
-struct usb_endpoint_descriptor *usbd_device_endpoint_descriptor_index (struct usb_device_instance
-								       *device, int port, int configuration, int interface, int alternate, int index)
-{
-	struct usb_alternate_instance *alternate_instance;
-
-	if (!(alternate_instance = usbd_device_alternate_instance (device, port, configuration, interface, alternate))) {
-		return NULL;
-	}
-	if (index >= alternate_instance->endpoints) {
-		return NULL;
-	}
-	return *(alternate_instance->endpoints_descriptor_array + index);
-}
-
-/**
- * usbd_device_endpoint_transfersize
- * @device: which device
- * @port: which port
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- * @index: which index
- *
- * Return the specified endpoint transfer size;
- */
-int usbd_device_endpoint_transfersize (struct usb_device_instance *device, int port, int configuration, int interface, int alternate, int index)
-{
-	struct usb_alternate_instance *alternate_instance;
-
-	if (!(alternate_instance = usbd_device_alternate_instance (device, port, configuration, interface, alternate))) {
-		return 0;
-	}
-	if (index >= alternate_instance->endpoints) {
-		return 0;
-	}
-	return *(alternate_instance->endpoint_transfersize_array + index);
-}
-
-/**
- * usbd_device_endpoint_descriptor
- * @device: which device
- * @port: which port
- * @configuration: index to configuration, 0 - N-1
- * @interface: index to interface
- * @alternate: alternate setting
- * @endpoint: which endpoint
- *
- * Return the specified endpoint descriptor for the specified device.
- */
-struct usb_endpoint_descriptor *usbd_device_endpoint_descriptor (struct usb_device_instance *device, int port, int configuration, int interface, int alternate, int endpoint)
-{
-	struct usb_endpoint_descriptor *endpoint_descriptor;
-	int i;
-
-	for (i = 0; !(endpoint_descriptor = usbd_device_endpoint_descriptor_index (device, port, configuration, interface, alternate, i)); i++) {
-		if (endpoint_descriptor->bEndpointAddress == endpoint) {
-			return endpoint_descriptor;
-		}
-	}
-	return NULL;
-}
-
-/**
- * usbd_endpoint_halted
- * @device: point to struct usb_device_instance
- * @endpoint: endpoint to check
- *
- * Return non-zero if endpoint is halted.
- */
-int usbd_endpoint_halted (struct usb_device_instance *device, int endpoint)
-{
-	return (device->status == USB_STATUS_HALT);
-}
-
-/**
- * usbd_rcv_complete - complete a receive
- * @endpoint:
- * @len:
- * @urb_bad:
- *
- * Called from rcv interrupt to complete.
- */
-void usbd_rcv_complete(struct usb_endpoint_instance *endpoint, int len, int urb_bad)
-{
-	if (endpoint) {
-		struct urb *rcv_urb;
-
-		/*usbdbg("len: %d urb: %p\n", len, endpoint->rcv_urb); */
-
-		/* if we had an urb then update actual_length, dispatch if neccessary */
-		if ((rcv_urb = endpoint->rcv_urb)) {
-
-			/*usbdbg("actual: %d buffer: %d\n", */
-			/*rcv_urb->actual_length, rcv_urb->buffer_length); */
-
-			/* check the urb is ok, are we adding data less than the packetsize */
-			if (!urb_bad && (len <= endpoint->rcv_packetSize)) {
-			  /*usbdbg("updating actual_length by %d\n",len); */
-
-				/* increment the received data size */
-				rcv_urb->actual_length += len;
-
-			} else {
-				usberr(" RECV_ERROR actual: %d buffer: %d urb_bad: %d\n",
-				       rcv_urb->actual_length, rcv_urb->buffer_length, urb_bad);
-
-				rcv_urb->actual_length = 0;
-				rcv_urb->status = RECV_ERROR;
-			}
-		} else {
-			usberr("no rcv_urb!");
-		}
-	} else {
-		usberr("no endpoint!");
-	}
-
-}
-
-/**
- * usbd_tx_complete - complete a transmit
- * @endpoint:
- * @resetart:
- *
- * Called from tx interrupt to complete.
- */
-void usbd_tx_complete (struct usb_endpoint_instance *endpoint)
-{
-	if (endpoint) {
-		struct urb *tx_urb;
-
-		/* if we have a tx_urb advance or reset, finish if complete */
-		if ((tx_urb = endpoint->tx_urb)) {
-			int sent = endpoint->last;
-			endpoint->sent += sent;
-			endpoint->last -= sent;
-
-			if( (endpoint->tx_urb->actual_length - endpoint->sent) <= 0 ) {
-				tx_urb->actual_length = 0;
-				endpoint->sent = 0;
-				endpoint->last = 0;
-
-				/* Remove from active, save for re-use */
-				urb_detach(tx_urb);
-				urb_append(&endpoint->done, tx_urb);
-				/*usbdbg("done->next %p, tx_urb %p, done %p", */
-				/*	 endpoint->done.next, tx_urb, &endpoint->done); */
-
-				endpoint->tx_urb = first_urb_detached(&endpoint->tx);
-				if( endpoint->tx_urb ) {
-					endpoint->tx_queue--;
-					usbdbg("got urb from tx list");
-				}
-				if( !endpoint->tx_urb ) {
-					/*usbdbg("taking urb from done list"); */
-					endpoint->tx_urb = first_urb_detached(&endpoint->done);
-				}
-				if( !endpoint->tx_urb ) {
-					usbdbg("allocating new urb for tx_urb");
-					endpoint->tx_urb = usbd_alloc_urb(tx_urb->device, endpoint);
-				}
-			}
-		}
-	}
-}
-
-/* URB linked list functions ***************************************************** */
-
-/*
- * Initialize an urb_link to be a single element list.
- * If the urb_link is being used as a distinguished list head
- * the list is empty when the head is the only link in the list.
- */
-void urb_link_init (urb_link * ul)
-{
-	if (ul) {
-		ul->prev = ul->next = ul;
-	}
-}
-
-/*
- * Detach an urb_link from a list, and set it
- * up as a single element list, so no dangling
- * pointers can be followed, and so it can be
- * joined to another list if so desired.
- */
-void urb_detach (struct urb *urb)
-{
-	if (urb) {
-		urb_link *ul = &urb->link;
-		ul->next->prev = ul->prev;
-		ul->prev->next = ul->next;
-		urb_link_init (ul);
-	}
-}
-
-/*
- * Return the first urb_link in a list with a distinguished
- * head "hd", or NULL if the list is empty.  This will also
- * work as a predicate, returning NULL if empty, and non-NULL
- * otherwise.
- */
-urb_link *first_urb_link (urb_link * hd)
-{
-	urb_link *nx;
-	if (NULL != hd && NULL != (nx = hd->next) && nx != hd) {
-		/* There is at least one element in the list */
-		/* (besides the distinguished head). */
-		return (nx);
-	}
-	/* The list is empty */
-	return (NULL);
-}
-
-/*
- * Return the first urb in a list with a distinguished
- * head "hd", or NULL if the list is empty.
- */
-struct urb *first_urb (urb_link * hd)
-{
-	urb_link *nx;
-	if (NULL == (nx = first_urb_link (hd))) {
-		/* The list is empty */
-		return (NULL);
-	}
-	return (p2surround (struct urb, link, nx));
-}
-
-/*
- * Detach and return the first urb in a list with a distinguished
- * head "hd", or NULL if the list is empty.
- *
- */
-struct urb *first_urb_detached (urb_link * hd)
-{
-	struct urb *urb;
-	if ((urb = first_urb (hd))) {
-		urb_detach (urb);
-	}
-	return urb;
-}
-
-/*
- * Append an urb_link (or a whole list of
- * urb_links) to the tail of another list
- * of urb_links.
- */
-void urb_append (urb_link * hd, struct urb *urb)
-{
-	if (hd && urb) {
-		urb_link *new = &urb->link;
-
-		/* This allows the new urb to be a list of urbs, */
-		/* with new pointing at the first, but the link */
-		/* must be initialized. */
-		/* Order is important here... */
-		urb_link *pul = hd->prev;
-		new->prev->next = hd;
-		hd->prev = new->prev;
-		new->prev = pul;
-		pul->next = new;
-	}
-}
-
-/* URB create/destroy functions ***************************************************** */
-
-/**
- * usbd_alloc_urb - allocate an URB appropriate for specified endpoint
- * @device: device instance
- * @endpoint: endpoint
- *
- * Allocate an urb structure. The usb device urb structure is used to
- * contain all data associated with a transfer, including a setup packet for
- * control transfers.
- *
- * NOTE: endpoint_address MUST contain a direction flag.
- */
-struct urb *usbd_alloc_urb (struct usb_device_instance *device,
-			    struct usb_endpoint_instance *endpoint)
-{
-	struct urb *urb;
-
-	if (!(urb = (struct urb *) malloc (sizeof (struct urb)))) {
-		usberr (" F A T A L:  malloc(%zu) FAILED!!!!",
-			sizeof (struct urb));
-		return NULL;
-	}
-
-	/* Fill in known fields */
-	memset (urb, 0, sizeof (struct urb));
-	urb->endpoint = endpoint;
-	urb->device = device;
-	urb->buffer = (u8 *) urb->buffer_data;
-	urb->buffer_length = sizeof (urb->buffer_data);
-
-	urb_link_init (&urb->link);
-
-	return urb;
-}
-
-/**
- * usbd_dealloc_urb - deallocate an URB and associated buffer
- * @urb: pointer to an urb structure
- *
- * Deallocate an urb structure and associated data.
- */
-void usbd_dealloc_urb (struct urb *urb)
-{
-	if (urb) {
-		free (urb);
-	}
-}
-
-/* Event signaling functions ***************************************************** */
-
-/**
- * usbd_device_event - called to respond to various usb events
- * @device: pointer to struct device
- * @event: event to respond to
- *
- * Used by a Bus driver to indicate an event.
- */
-void usbd_device_event_irq (struct usb_device_instance *device, usb_device_event_t event, int data)
-{
-	usb_device_state_t state;
-
-	if (!device || !device->bus) {
-		usberr("(%p,%d) NULL device or device->bus", device, event);
-		return;
-	}
-
-	state = device->device_state;
-
-	usbinfo("%s", usbd_device_events[event]);
-
-	switch (event) {
-	case DEVICE_UNKNOWN:
-		break;
-	case DEVICE_INIT:
-		device->device_state = STATE_INIT;
-		break;
-
-	case DEVICE_CREATE:
-		device->device_state = STATE_ATTACHED;
-		break;
-
-	case DEVICE_HUB_CONFIGURED:
-		device->device_state = STATE_POWERED;
-		break;
-
-	case DEVICE_RESET:
-		device->device_state = STATE_DEFAULT;
-		device->address = 0;
-		break;
-
-	case DEVICE_ADDRESS_ASSIGNED:
-		device->device_state = STATE_ADDRESSED;
-		break;
-
-	case DEVICE_CONFIGURED:
-		device->device_state = STATE_CONFIGURED;
-		break;
-
-	case DEVICE_DE_CONFIGURED:
-		device->device_state = STATE_ADDRESSED;
-		break;
-
-	case DEVICE_BUS_INACTIVE:
-		if (device->status != USBD_CLOSING) {
-			device->status = USBD_SUSPENDED;
-		}
-		break;
-	case DEVICE_BUS_ACTIVITY:
-		if (device->status != USBD_CLOSING) {
-			device->status = USBD_OK;
-		}
-		break;
-
-	case DEVICE_SET_INTERFACE:
-		break;
-	case DEVICE_SET_FEATURE:
-		break;
-	case DEVICE_CLEAR_FEATURE:
-		break;
-
-	case DEVICE_POWER_INTERRUPTION:
-		device->device_state = STATE_POWERED;
-		break;
-	case DEVICE_HUB_RESET:
-		device->device_state = STATE_ATTACHED;
-		break;
-	case DEVICE_DESTROY:
-		device->device_state = STATE_UNKNOWN;
-		break;
-
-	case DEVICE_FUNCTION_PRIVATE:
-		break;
-
-	default:
-		usbdbg("event %d - not handled",event);
-		break;
-	}
-	debug("%s event: %d oldstate: %d newstate: %d status: %d address: %d",
-		device->name, event, state,
-		device->device_state, device->status, device->address);
-
-	/* tell the bus interface driver */
-	if( device->event ) {
-		/* usbdbg("calling device->event"); */
-		device->event(device, event, data);
-	}
-}
diff --git a/drivers/usb/gadget/ep0.c b/drivers/usb/gadget/ep0.c
deleted file mode 100644
index 8c7fc17c2eaa..000000000000
--- a/drivers/usb/gadget/ep0.c
+++ /dev/null
@@ -1,619 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003
- * Gerry Hamel, geh@ti.com, Texas Instruments
- *
- * (C) Copyright 2006
- * Bryan O'Donoghue, deckard@CodeHermit.ie
- *
- * Based on
- * linux/drivers/usbd/ep0.c
- *
- * Copyright (c) 2000, 2001, 2002 Lineo
- * Copyright (c) 2001 Hewlett Packard
- *
- * By:
- *	Stuart Lynne <sl@lineo.com>,
- *	Tom Rushworth <tbr@lineo.com>,
- *	Bruce Balden <balden@lineo.com>
- */
-
-/*
- * This is the builtin ep0 control function. It implements all required functionality
- * for responding to control requests (SETUP packets).
- *
- * XXX
- *
- * Currently we do not pass any SETUP packets (or other) to the configured
- * function driver. This may need to change.
- *
- * XXX
- *
- * As alluded to above, a simple callback cdc_recv_setup has been implemented
- * in the usb_device data structure to facilicate passing
- * Common Device Class packets to a function driver.
- *
- * XXX
- */
-
-#include <serial.h>
-#include <usbdevice.h>
-
-#if 0
-#define dbg_ep0(lvl,fmt,args...) serial_printf("[%s] %s:%d: "fmt"\n",__FILE__,__FUNCTION__,__LINE__,##args)
-#else
-#define dbg_ep0(lvl,fmt,args...)
-#endif
-
-__maybe_unused static char *usbd_device_descriptors[] = {
-	"UNKNOWN",		/* 0 */
-	"DEVICE",		/* 1 */
-	"CONFIG",		/* 2 */
-	"STRING",		/* 3 */
-	"INTERFACE",		/* 4 */
-	"ENDPOINT",		/* 5 */
-	"DEVICE QUALIFIER",	/* 6 */
-	"OTHER SPEED",		/* 7 */
-	"INTERFACE POWER",	/* 8 */
-};
-
-#define USBD_DEVICE_DESCRIPTORS(x) (((unsigned int)x <= USB_DESCRIPTOR_TYPE_INTERFACE_POWER) ? \
-		usbd_device_descriptors[x] : "UNKNOWN")
-
-__maybe_unused static char *usbd_device_states[] = {
-	"STATE_INIT",
-	"STATE_CREATED",
-	"STATE_ATTACHED",
-	"STATE_POWERED",
-	"STATE_DEFAULT",
-	"STATE_ADDRESSED",
-	"STATE_CONFIGURED",
-	"STATE_UNKNOWN",
-};
-
-#define USBD_DEVICE_STATE(x) (((unsigned int)x <= STATE_UNKNOWN) ? usbd_device_states[x] : "UNKNOWN")
-
-__maybe_unused static char *usbd_device_requests[] = {
-	"GET STATUS",		/* 0 */
-	"CLEAR FEATURE",	/* 1 */
-	"RESERVED",		/* 2 */
-	"SET FEATURE",		/* 3 */
-	"RESERVED",		/* 4 */
-	"SET ADDRESS",		/* 5 */
-	"GET DESCRIPTOR",	/* 6 */
-	"SET DESCRIPTOR",	/* 7 */
-	"GET CONFIGURATION",	/* 8 */
-	"SET CONFIGURATION",	/* 9 */
-	"GET INTERFACE",	/* 10 */
-	"SET INTERFACE",	/* 11 */
-	"SYNC FRAME",		/* 12 */
-};
-
-#define USBD_DEVICE_REQUESTS(x) (((unsigned int)x <= USB_REQ_SYNCH_FRAME) ? usbd_device_requests[x] : "UNKNOWN")
-
-/* EP0 Configuration Set ********************************************************************* */
-
-/**
- * ep0_get_status - fill in URB data with appropriate status
- * @device:
- * @urb:
- * @index:
- * @requesttype:
- *
- */
-static int ep0_get_status (struct usb_device_instance *device,
-			   struct urb *urb, int index, int requesttype)
-{
-	char *cp;
-
-	urb->actual_length = 2;
-	cp = (char*)urb->buffer;
-	cp[0] = cp[1] = 0;
-
-	switch (requesttype) {
-	case USB_REQ_RECIPIENT_DEVICE:
-		cp[0] = USB_STATUS_SELFPOWERED;
-		break;
-	case USB_REQ_RECIPIENT_INTERFACE:
-		break;
-	case USB_REQ_RECIPIENT_ENDPOINT:
-		cp[0] = usbd_endpoint_halted (device, index);
-		break;
-	case USB_REQ_RECIPIENT_OTHER:
-		urb->actual_length = 0;
-	default:
-		break;
-	}
-	dbg_ep0 (2, "%02x %02x", cp[0], cp[1]);
-	return 0;
-}
-
-/**
- * ep0_get_one
- * @device:
- * @urb:
- * @result:
- *
- * Set a single byte value in the urb send buffer. Return non-zero to signal
- * a request error.
- */
-static int ep0_get_one (struct usb_device_instance *device, struct urb *urb,
-			__u8 result)
-{
-	urb->actual_length = 1;	/* XXX 2? */
-	((char *) urb->buffer)[0] = result;
-	return 0;
-}
-
-/**
- * copy_config
- * @urb: pointer to urb
- * @data: pointer to configuration data
- * @length: length of data
- *
- * Copy configuration data to urb transfer buffer if there is room for it.
- */
-void copy_config (struct urb *urb, void *data, int max_length,
-			 int max_buf)
-{
-	int available;
-	int length;
-
-	/*dbg_ep0(3, "-> actual: %d buf: %d max_buf: %d max_length: %d data: %p", */
-	/*        urb->actual_length, urb->buffer_length, max_buf, max_length, data); */
-
-	if (!data) {
-		dbg_ep0 (1, "data is NULL");
-		return;
-	}
-	length = max_length;
-
-	if (length > max_length) {
-		dbg_ep0 (1, "length: %d >= max_length: %d", length,
-			 max_length);
-		return;
-	}
-	/*dbg_ep0(1, "   actual: %d buf: %d max_buf: %d max_length: %d length: %d", */
-	/*        urb->actual_length, urb->buffer_length, max_buf, max_length, length); */
-
-	if ((available =
-	     /*urb->buffer_length */ max_buf - urb->actual_length) <= 0) {
-		return;
-	}
-	/*dbg_ep0(1, "actual: %d buf: %d max_buf: %d length: %d available: %d", */
-	/*        urb->actual_length, urb->buffer_length, max_buf, length, available); */
-
-	if (length > available) {
-		length = available;
-	}
-	/*dbg_ep0(1, "actual: %d buf: %d max_buf: %d length: %d available: %d", */
-	/*        urb->actual_length, urb->buffer_length, max_buf, length, available); */
-
-	memcpy (urb->buffer + urb->actual_length, data, length);
-	urb->actual_length += length;
-
-	dbg_ep0 (3,
-		 "copy_config: <- actual: %d buf: %d max_buf: %d max_length: %d available: %d",
-		 urb->actual_length, urb->buffer_length, max_buf, max_length,
-		 available);
-}
-
-/**
- * ep0_get_descriptor
- * @device:
- * @urb:
- * @max:
- * @descriptor_type:
- * @index:
- *
- * Called by ep0_rx_process for a get descriptor device command. Determine what
- * descriptor is being requested, copy to send buffer. Return zero if ok to send,
- * return non-zero to signal a request error.
- */
-static int ep0_get_descriptor (struct usb_device_instance *device,
-			       struct urb *urb, int max, int descriptor_type,
-			       int index)
-{
-	int port = 0;		/* XXX compound device */
-
-	/*dbg_ep0(3, "max: %x type: %x index: %x", max, descriptor_type, index); */
-
-	if (!urb || !urb->buffer || !urb->buffer_length
-	    || (urb->buffer_length < 255)) {
-		dbg_ep0 (2, "invalid urb %p", urb);
-		return -1L;
-	}
-
-	/* setup tx urb */
-	urb->actual_length = 0;
-
-	dbg_ep0 (2, "%s", USBD_DEVICE_DESCRIPTORS (descriptor_type));
-
-	switch (descriptor_type) {
-	case USB_DESCRIPTOR_TYPE_DEVICE:
-		{
-			struct usb_device_descriptor *device_descriptor;
-			if (!
-			    (device_descriptor =
-			     usbd_device_device_descriptor (device, port))) {
-				return -1;
-			}
-			/* copy descriptor for this device */
-			copy_config (urb, device_descriptor,
-				     sizeof (struct usb_device_descriptor),
-				     max);
-
-			/* correct the correct control endpoint 0 max packet size into the descriptor */
-			device_descriptor =
-				(struct usb_device_descriptor *) urb->buffer;
-
-		}
-		dbg_ep0(3, "copied device configuration, actual_length: 0x%x", urb->actual_length);
-		break;
-
-	case USB_DESCRIPTOR_TYPE_CONFIGURATION:
-		{
-			struct usb_configuration_descriptor
-				*configuration_descriptor;
-			struct usb_device_descriptor *device_descriptor;
-			if (!
-			    (device_descriptor =
-			     usbd_device_device_descriptor (device, port))) {
-				return -1;
-			}
-			/*dbg_ep0(2, "%d %d", index, device_descriptor->bNumConfigurations); */
-			if (index >= device_descriptor->bNumConfigurations) {
-				dbg_ep0 (0, "index too large: %d >= %d", index,
-					 device_descriptor->
-					 bNumConfigurations);
-				return -1;
-			}
-
-			if (!
-			    (configuration_descriptor =
-			     usbd_device_configuration_descriptor (device,
-								   port,
-								   index))) {
-				dbg_ep0 (0,
-					 "usbd_device_configuration_descriptor failed: %d",
-					 index);
-				return -1;
-			}
-			dbg_ep0(0, "attempt to copy %d bytes to urb\n",cpu_to_le16(configuration_descriptor->wTotalLength));
-			copy_config (urb, configuration_descriptor,
-
-					cpu_to_le16(configuration_descriptor->wTotalLength),
-				     max);
-		}
-
-		break;
-
-	case USB_DESCRIPTOR_TYPE_STRING:
-		{
-			struct usb_string_descriptor *string_descriptor;
-			if (!(string_descriptor = usbd_get_string (index))) {
-				dbg_ep0(0, "Invalid string index %d\n", index);
-				return -1;
-			}
-			dbg_ep0(3, "string_descriptor: %p length %d", string_descriptor, string_descriptor->bLength);
-			copy_config (urb, string_descriptor, string_descriptor->bLength, max);
-		}
-		break;
-	case USB_DESCRIPTOR_TYPE_INTERFACE:
-		dbg_ep0(2, "USB_DESCRIPTOR_TYPE_INTERFACE - error not implemented\n");
-		return -1;
-	case USB_DESCRIPTOR_TYPE_ENDPOINT:
-		dbg_ep0(2, "USB_DESCRIPTOR_TYPE_ENDPOINT - error not implemented\n");
-		return -1;
-	case USB_DESCRIPTOR_TYPE_HID:
-		{
-			dbg_ep0(2, "USB_DESCRIPTOR_TYPE_HID - error not implemented\n");
-			return -1;	/* unsupported at this time */
-#if 0
-			int bNumInterface =
-				le16_to_cpu (urb->device_request.wIndex);
-			int bAlternateSetting = 0;
-			int class = 0;
-			struct usb_class_descriptor *class_descriptor;
-
-			if (!(class_descriptor =
-			      usbd_device_class_descriptor_index (device,
-								  port, 0,
-								  bNumInterface,
-								  bAlternateSetting,
-								  class))
-			    || class_descriptor->descriptor.hid.bDescriptorType != USB_DT_HID) {
-				dbg_ep0 (3, "[%d] interface is not HID",
-					 bNumInterface);
-				return -1;
-			}
-			/* copy descriptor for this class */
-			copy_config (urb, class_descriptor,
-				     class_descriptor->descriptor.hid.bLength,
-				     max);
-#endif
-		}
-		break;
-	case USB_DESCRIPTOR_TYPE_REPORT:
-		{
-			dbg_ep0(2, "USB_DESCRIPTOR_TYPE_REPORT - error not implemented\n");
-			return -1;	/* unsupported at this time */
-#if 0
-			int bNumInterface =
-				le16_to_cpu (urb->device_request.wIndex);
-			int bAlternateSetting = 0;
-			int class = 0;
-			struct usb_class_report_descriptor *report_descriptor;
-
-			if (!(report_descriptor =
-			      usbd_device_class_report_descriptor_index
-			      (device, port, 0, bNumInterface,
-			       bAlternateSetting, class))
-			    || report_descriptor->bDescriptorType !=
-			    USB_DT_REPORT) {
-				dbg_ep0 (3, "[%d] descriptor is not REPORT",
-					 bNumInterface);
-				return -1;
-			}
-			/* copy report descriptor for this class */
-			/*copy_config(urb, &report_descriptor->bData[0], report_descriptor->wLength, max); */
-			if (max - urb->actual_length > 0) {
-				int length =
-					min(report_descriptor->wLength,
-					     max - urb->actual_length);
-				memcpy (urb->buffer + urb->actual_length,
-					&report_descriptor->bData[0], length);
-				urb->actual_length += length;
-			}
-#endif
-		}
-		break;
-	case USB_DESCRIPTOR_TYPE_DEVICE_QUALIFIER:
-		return -1;
-
-	default:
-		return -1;
-	}
-
-	dbg_ep0 (1, "urb: buffer: %p buffer_length: %2d actual_length: %2d tx_packetSize: %2d",
-		 urb->buffer, urb->buffer_length, urb->actual_length,
-		 device->bus->endpoint_array[0].tx_packetSize);
-/*
-    if ((urb->actual_length < max) && !(urb->actual_length % device->bus->endpoint_array[0].tx_packetSize)) {
-	dbg_ep0(0, "adding null byte");
-	urb->buffer[urb->actual_length++] = 0;
-	dbg_ep0(0, "urb: buffer_length: %2d actual_length: %2d packet size: %2d",
-		urb->buffer_length, urb->actual_length device->bus->endpoint_array[0].tx_packetSize);
-    }
-*/
-	return 0;
-
-}
-
-/**
- * ep0_recv_setup - called to indicate URB has been received
- * @urb: pointer to struct urb
- *
- * Check if this is a setup packet, process the device request, put results
- * back into the urb and return zero or non-zero to indicate success (DATA)
- * or failure (STALL).
- *
- */
-int ep0_recv_setup (struct urb *urb)
-{
-	/*struct usb_device_request *request = urb->buffer; */
-	/*struct usb_device_instance *device = urb->device; */
-
-	struct usb_device_request *request;
-	struct usb_device_instance *device;
-	int address;
-
-	dbg_ep0 (0, "entering ep0_recv_setup()");
-	if (!urb || !urb->device) {
-		dbg_ep0 (3, "invalid URB %p", urb);
-		return -1;
-	}
-
-	request = &urb->device_request;
-	device = urb->device;
-
-	dbg_ep0 (3, "urb: %p device: %p", urb, urb->device);
-
-	/*dbg_ep0(2, "-       -       -       -       -       -       -       -       -       -"); */
-
-	dbg_ep0 (2,
-		 "bmRequestType:%02x bRequest:%02x wValue:%04x wIndex:%04x wLength:%04x %s",
-		 request->bmRequestType, request->bRequest,
-		 le16_to_cpu (request->wValue), le16_to_cpu (request->wIndex),
-		 le16_to_cpu (request->wLength),
-		 USBD_DEVICE_REQUESTS (request->bRequest));
-
-	/* handle USB Standard Request (c.f. USB Spec table 9-2) */
-	if ((request->bmRequestType & USB_REQ_TYPE_MASK) != 0) {
-		if(device->device_state <= STATE_CONFIGURED){
-			/*	Attempt to handle a CDC specific request if we are
-			 *	in the configured state.
-			 */
-			return device->cdc_recv_setup(request,urb);
-		}
-		dbg_ep0 (1, "non standard request: %x",
-			 request->bmRequestType & USB_REQ_TYPE_MASK);
-		return -1;	/* Stall here */
-	}
-
-	switch (device->device_state) {
-	case STATE_CREATED:
-	case STATE_ATTACHED:
-	case STATE_POWERED:
-		/* It actually is important to allow requests in these states,
-		 * Windows will request descriptors before assigning an
-		 * address to the client.
-		 */
-
-		/*dbg_ep0 (1, "request %s not allowed in this state: %s", */
-		/*                USBD_DEVICE_REQUESTS(request->bRequest), */
-		/*                usbd_device_states[device->device_state]); */
-		/*return -1; */
-		break;
-
-	case STATE_INIT:
-	case STATE_DEFAULT:
-		switch (request->bRequest) {
-		case USB_REQ_GET_STATUS:
-		case USB_REQ_GET_INTERFACE:
-		case USB_REQ_SYNCH_FRAME:	/* XXX should never see this (?) */
-		case USB_REQ_CLEAR_FEATURE:
-		case USB_REQ_SET_FEATURE:
-		case USB_REQ_SET_DESCRIPTOR:
-			/* case USB_REQ_SET_CONFIGURATION: */
-		case USB_REQ_SET_INTERFACE:
-			dbg_ep0 (1,
-				 "request %s not allowed in DEFAULT state: %s",
-				 USBD_DEVICE_REQUESTS (request->bRequest),
-				 usbd_device_states[device->device_state]);
-			return -1;
-
-		case USB_REQ_SET_CONFIGURATION:
-		case USB_REQ_SET_ADDRESS:
-		case USB_REQ_GET_DESCRIPTOR:
-		case USB_REQ_GET_CONFIGURATION:
-			break;
-		}
-	case STATE_ADDRESSED:
-	case STATE_CONFIGURED:
-		break;
-	case STATE_UNKNOWN:
-		dbg_ep0 (1, "request %s not allowed in UNKNOWN state: %s",
-			 USBD_DEVICE_REQUESTS (request->bRequest),
-			 usbd_device_states[device->device_state]);
-		return -1;
-	}
-
-	/* handle all requests that return data (direction bit set on bm RequestType) */
-	if ((request->bmRequestType & USB_REQ_DIRECTION_MASK)) {
-
-		dbg_ep0 (3, "Device-to-Host");
-
-		switch (request->bRequest) {
-
-		case USB_REQ_GET_STATUS:
-			return ep0_get_status (device, urb, request->wIndex,
-					       request->bmRequestType &
-					       USB_REQ_RECIPIENT_MASK);
-
-		case USB_REQ_GET_DESCRIPTOR:
-			return ep0_get_descriptor (device, urb,
-						   le16_to_cpu (request->wLength),
-						   le16_to_cpu (request->wValue) >> 8,
-						   le16_to_cpu (request->wValue) & 0xff);
-
-		case USB_REQ_GET_CONFIGURATION:
-			dbg_ep0(2, "get config %d\n", device->configuration);
-			return ep0_get_one (device, urb,
-					    device->configuration);
-
-		case USB_REQ_GET_INTERFACE:
-			return ep0_get_one (device, urb, device->alternate);
-
-		case USB_REQ_SYNCH_FRAME:	/* XXX should never see this (?) */
-			return -1;
-
-		case USB_REQ_CLEAR_FEATURE:
-		case USB_REQ_SET_FEATURE:
-		case USB_REQ_SET_ADDRESS:
-		case USB_REQ_SET_DESCRIPTOR:
-		case USB_REQ_SET_CONFIGURATION:
-		case USB_REQ_SET_INTERFACE:
-			return -1;
-		}
-	}
-	/* handle the requests that do not return data */
-	else {
-
-		/*dbg_ep0(3, "Host-to-Device"); */
-		switch (request->bRequest) {
-
-		case USB_REQ_CLEAR_FEATURE:
-		case USB_REQ_SET_FEATURE:
-			dbg_ep0 (0, "Host-to-Device");
-			switch (request->
-				bmRequestType & USB_REQ_RECIPIENT_MASK) {
-			case USB_REQ_RECIPIENT_DEVICE:
-				/* XXX DEVICE_REMOTE_WAKEUP or TEST_MODE would be added here */
-				/* XXX fall through for now as we do not support either */
-			case USB_REQ_RECIPIENT_INTERFACE:
-			case USB_REQ_RECIPIENT_OTHER:
-				dbg_ep0 (0, "request %s not",
-					 USBD_DEVICE_REQUESTS (request->bRequest));
-			default:
-				return -1;
-
-			case USB_REQ_RECIPIENT_ENDPOINT:
-				dbg_ep0 (0, "ENDPOINT: %x", le16_to_cpu (request->wValue));
-				if (le16_to_cpu (request->wValue) == USB_ENDPOINT_HALT) {
-					/*return usbd_device_feature (device, le16_to_cpu (request->wIndex), */
-					/*                    request->bRequest == USB_REQ_SET_FEATURE); */
-					/* NEED TO IMPLEMENT THIS!!! */
-					return -1;
-				} else {
-					dbg_ep0 (1, "request %s bad wValue: %04x",
-						 USBD_DEVICE_REQUESTS
-						 (request->bRequest),
-						 le16_to_cpu (request->wValue));
-					return -1;
-				}
-			}
-
-		case USB_REQ_SET_ADDRESS:
-			/* check if this is a re-address, reset first if it is (this shouldn't be possible) */
-			if (device->device_state != STATE_DEFAULT) {
-				dbg_ep0 (1, "set_address: %02x state: %s",
-					 le16_to_cpu (request->wValue),
-					 usbd_device_states[device->device_state]);
-				return -1;
-			}
-			address = le16_to_cpu (request->wValue);
-			if ((address & 0x7f) != address) {
-				dbg_ep0 (1, "invalid address %04x %04x",
-					 address, address & 0x7f);
-				return -1;
-			}
-			device->address = address;
-
-			/*dbg_ep0(2, "address: %d %d %d", */
-			/*        request->wValue, le16_to_cpu(request->wValue), device->address); */
-
-			return 0;
-
-		case USB_REQ_SET_DESCRIPTOR:	/* XXX should we support this? */
-			dbg_ep0 (0, "set descriptor: NOT SUPPORTED");
-			return -1;
-
-		case USB_REQ_SET_CONFIGURATION:
-			/* c.f. 9.4.7 - the top half of wValue is reserved */
-			device->configuration = le16_to_cpu(request->wValue) & 0xff;
-
-			/* reset interface and alternate settings */
-			device->interface = device->alternate = 0;
-
-			/*dbg_ep0(2, "set configuration: %d", device->configuration); */
-			/*dbg_ep0(2, "DEVICE_CONFIGURED.. event?\n"); */
-			return 0;
-
-		case USB_REQ_SET_INTERFACE:
-			device->interface = le16_to_cpu (request->wIndex);
-			device->alternate = le16_to_cpu (request->wValue);
-			/*dbg_ep0(2, "set interface: %d alternate: %d", device->interface, device->alternate); */
-			dbg_ep0(2, "DEVICE_SET_INTERFACE.. event?\n");
-			return 0;
-
-		case USB_REQ_GET_STATUS:
-		case USB_REQ_GET_DESCRIPTOR:
-		case USB_REQ_GET_CONFIGURATION:
-		case USB_REQ_GET_INTERFACE:
-		case USB_REQ_SYNCH_FRAME:	/* XXX should never see this (?) */
-			return -1;
-		}
-	}
-	return -1;
-}
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 5164cb15986c..b0f8831531e2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2233,8 +2233,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 
 	if (!efi_st_keep_devices) {
 		bootm_disable_interrupts();
-		if (IS_ENABLED(CONFIG_USB_DEVICE))
-			udc_disconnect();
 		board_quiesce_devices();
 		dm_remove_devices_active();
 	}
-- 
2.43.0

