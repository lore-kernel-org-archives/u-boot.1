Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3EC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A74084A49;
	Sat, 11 Jul 2026 18:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KJFiKhnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C76D84A3E; Sat, 11 Jul 2026 18:08:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0CA84A3C
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786116; bh=vFu6o3C0Ai//xFNSTG1u7wvJca+ucE5PKhqXuOhXo4c=;
 b=KJFiKhnpMtsrtrCBO5yh9ygL4ppka0UJc4fKEB2SpvaVeR0zO8/e8UB65XFTYYJrplaWeo4+0
 4fRhFC8aeUjhpYTm0KbW1QbjBMb5BtPN2C+kVw5a5ViRA7Fh1nFE0O57HpBSinei0pOf9dg6VFG
 6ywrEGjRBBLKsCgF3KQHuWgEKqY2GWsFkP91cmeS9vD8sWYs92O2oDs1KYancLDslDaOfAJCBn5
 psY2SpeR2RZPPb2wnpcLyisjNp5oO2wwdIjufPPYIaXCd/PRCrt909OT2VE4bsz1//dA5sszw8c
 +G5bIIDilsbnIqOKyswCMVYTdCVPUSmIa56lIb763qug==
X-Forward-Email-ID: 6a526a831b09fea89cb12520
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/8] usb: eth: Add CDC ECM support
Date: Sat, 11 Jul 2026 16:08:03 +0000
Message-ID: <20260711160808.2022242-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711160808.2022242-1-jonas@kwiboo.se>
References: <20260711160808.2022242-1-jonas@kwiboo.se>
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

Add support for CDC ECM (Communications Device Class, Ethernet Control
Model) devices.

References:
- [USBECM12] USB Subclass Specification for Ethernet Control Model 1.2.
- [USBCDC12] USB Class Definitions for Communications Devices 1.2.
- [USB20] USB Specification 2.0.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 doc/README.usb               |   1 +
 drivers/usb/eth/Kconfig      |   9 ++
 drivers/usb/eth/Makefile     |   1 +
 drivers/usb/eth/cdc_common.c | 153 +++++++++++++++++++
 drivers/usb/eth/cdc_common.h |  26 ++++
 drivers/usb/eth/cdc_ecm.c    | 284 +++++++++++++++++++++++++++++++++++
 6 files changed, 474 insertions(+)
 create mode 100644 drivers/usb/eth/cdc_common.c
 create mode 100644 drivers/usb/eth/cdc_common.h
 create mode 100644 drivers/usb/eth/cdc_ecm.c

diff --git a/doc/README.usb b/doc/README.usb
index 650a6daae0a5..65bafe7030f7 100644
--- a/doc/README.usb
+++ b/doc/README.usb
@@ -133,6 +133,7 @@ and one or more of the following for individual adapter hardware:
 
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_CDC_ECM=y
 CONFIG_USB_ETHER_LAN75XX=y
 CONFIG_USB_ETHER_LAN78XX=y
 CONFIG_USB_ETHER_MCS7830=y
diff --git a/drivers/usb/eth/Kconfig b/drivers/usb/eth/Kconfig
index b9b77f467437..0b1aae69ccac 100644
--- a/drivers/usb/eth/Kconfig
+++ b/drivers/usb/eth/Kconfig
@@ -20,6 +20,15 @@ config USB_ETHER_ASIX88179
 	  Say Y here if you would like to support ASIX AX88179 based USB 3.0
 	  Ethernet Devices.
 
+config USB_ETHER_CDC_ECM
+	bool "CDC ECM support"
+	depends on USB_HOST_ETHER
+	help
+	  Say Y here if you would like to support CDC ECM (Communications Device
+	  Class, Ethernet Control Model) devices. The USB Communications Class
+	  Subclass Specifications for Ethernet Control Model Devices is
+	  available from <http://www.usb.org/>.
+
 config USB_ETHER_LAN75XX
 	bool "Microchip LAN75XX support"
 	depends on USB_HOST_ETHER
diff --git a/drivers/usb/eth/Makefile b/drivers/usb/eth/Makefile
index 2e5d0782e888..3ddace19578a 100644
--- a/drivers/usb/eth/Makefile
+++ b/drivers/usb/eth/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_USB_HOST_ETHER) += usb_ether.o
 obj-$(CONFIG_USB_ETHER_ASIX) += asix.o
 obj-$(CONFIG_USB_ETHER_ASIX88179) += asix88179.o
+obj-$(CONFIG_USB_ETHER_CDC_ECM) += cdc_common.o cdc_ecm.o
 obj-$(CONFIG_USB_ETHER_MCS7830) += mcs7830.o
 obj-$(CONFIG_USB_ETHER_SMSC95XX) += smsc95xx.o
 obj-$(CONFIG_USB_ETHER_LAN75XX) += lan7x.o lan75xx.o
diff --git a/drivers/usb/eth/cdc_common.c b/drivers/usb/eth/cdc_common.c
new file mode 100644
index 000000000000..2342a56310f4
--- /dev/null
+++ b/drivers/usb/eth/cdc_common.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#define LOG_CATEGORY UCLASS_ETH
+
+#include <console.h>
+#include <env.h>
+#include <hexdump.h>
+#include <memalign.h>
+#include <time.h>
+#include <usb.h>
+#include <linux/delay.h>
+#include <linux/if_ether.h>
+#include <linux/usb/cdc.h>
+#include "cdc_common.h"
+
+int cdc_bulk_xfer(struct usb_device *udev, u32 pipe, void *data, int length,
+		  int *actual_length, int timeout)
+{
+	int ret;
+
+	*actual_length = 0;
+	ret = usb_bulk_msg(udev, pipe, data, length, actual_length, timeout);
+
+	log_debug("Xfer: length = %u, actual = %u, ret = %d, status = %lx\n",
+		  length, *actual_length, ret, udev->status);
+
+	if (ret && udev->status & USB_ST_STALLED)
+		usb_clear_halt(udev, pipe);
+
+	return ret;
+}
+
+int cdc_get_mac_address(struct usb_device *udev, int index, u8 *data)
+{
+	u8 tmpbuf[13];
+	int ret;
+
+	/* The string descriptor holds the 48bit Ethernet MAC address */
+	ret = usb_string(udev, index, tmpbuf, sizeof(tmpbuf));
+	if (ret == 12 && !hex2bin(data, tmpbuf, ETH_ALEN))
+		return 0;
+
+	memset(data, 0, ETH_ALEN);
+	return -EINVAL;
+}
+
+int cdc_set_ethernet_packet_filter(struct usb_device *udev, u16 index, u16 value)
+{
+	int ret;
+
+	/* 6.2.4 SetEthernetPacketFilter [USBECM12] */
+	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			      USB_CDC_SET_ETHERNET_PACKET_FILTER,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			      value, index, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	log_debug("SetEthernetPacketFilter(%x): ret=%d, status=%lx\n",
+		  value, ret, udev->status);
+
+	return ret;
+}
+
+int cdc_set_interface(struct usb_device *udev, u16 index, u16 value)
+{
+	int ret;
+
+	/* 9.4.10 Set Interface [USB20] */
+	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			      USB_REQ_SET_INTERFACE, USB_RECIP_INTERFACE,
+			      value, index, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	log_debug("SetInterface(%u, %u): ret=%d, status=%lx\n",
+		  index, value, ret, udev->status);
+
+	return ret;
+}
+
+int cdc_wait_on_connection(struct usb_device *udev, u32 pipe, int interval)
+{
+	struct usb_cdc_notification *notification;
+	ulong start, timeout;
+	int maxpacket, ret;
+	ALLOC_CACHE_ALIGN_BUFFER(u8, tmpbuf, 64);
+
+	if (!pipe)
+		return 0;
+
+	maxpacket = usb_maxpacket(udev, pipe);
+	if (maxpacket < sizeof(struct usb_cdc_notification) || maxpacket > 64)
+		return -EINVAL;
+
+	timeout = env_get_ulong("phy_aneg_timeout", 10,
+				config_opt_enabled(CONFIG_PHYLIB,
+						   CONFIG_PHY_ANEG_TIMEOUT, 4000));
+	start = get_timer(0);
+	do {
+		if (ctrlc())
+			return -EINTR;
+
+		ret = usb_int_msg(udev, pipe, tmpbuf, maxpacket, interval, false);
+		if (ret < 0)
+			return ret;
+
+		notification = (struct usb_cdc_notification *)tmpbuf;
+		if (!notification->bmRequestType) {
+			log_warning("Invalid notification: [%x,%x,%x,%u,%u]\n",
+				    notification->bmRequestType,
+				    notification->bNotificationType,
+				    le16_to_cpu(notification->wValue),
+				    le16_to_cpu(notification->wIndex),
+				    le16_to_cpu(notification->wLength));
+			return -EINVAL;
+		}
+
+		switch (notification->bNotificationType) {
+		/* 6.3.1 NetworkConnection [USBCDC12] */
+		case USB_CDC_NOTIFY_NETWORK_CONNECTION:
+			if (le16_to_cpu(notification->wValue) == 1) {
+				log_debug("Network connection established\n");
+				return 0;
+			}
+			mdelay(50);
+			break;
+		}
+	} while (get_timer(start) < timeout);
+
+	return -ETIMEDOUT;
+}
+
+struct usb_config_descriptor *
+cdc_get_config_descriptor(struct usb_device *udev, int cfgno)
+{
+	struct usb_config_descriptor *config;
+	int length, ret;
+
+	length = usb_get_configuration_len(udev, cfgno);
+	if (length <= 0)
+		return NULL;
+
+	config = malloc_cache_aligned(length);
+	if (!config)
+		return NULL;
+
+	/* 9.4.3 Get Descriptor [USB20] */
+	ret = usb_get_configuration_no(udev, cfgno, (u8 *)config, length);
+	if (ret < 0 ||
+	    config->bDescriptorType != USB_DT_CONFIG ||
+	    config->bLength != USB_DT_CONFIG_SIZE) {
+		free(config);
+		return NULL;
+	}
+
+	return config;
+}
diff --git a/drivers/usb/eth/cdc_common.h b/drivers/usb/eth/cdc_common.h
new file mode 100644
index 000000000000..200860f63ffd
--- /dev/null
+++ b/drivers/usb/eth/cdc_common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright Contributors to the U-Boot project. */
+
+#ifndef _USB_ETH_CDC_COMMON_H
+#define _USB_ETH_CDC_COMMON_H
+
+#define USB_BULK_RECV_TIMEOUT		500
+#define USB_BULK_SEND_TIMEOUT		5000
+#define USB_CTRL_GET_TIMEOUT		5000
+#define USB_CTRL_SET_TIMEOUT		5000
+
+int cdc_bulk_xfer(struct usb_device *udev, u32 pipe, void *data, int length,
+		  int *actual_length, int timeout);
+
+int cdc_get_mac_address(struct usb_device *udev, int index, u8 *data);
+
+int cdc_set_ethernet_packet_filter(struct usb_device *udev, u16 index, u16 value);
+
+int cdc_set_interface(struct usb_device *udev, u16 index, u16 value);
+
+int cdc_wait_on_connection(struct usb_device *udev, u32 pipe, int interval);
+
+struct usb_config_descriptor *cdc_get_config_descriptor(struct usb_device *udev,
+							int cfgno);
+
+#endif
diff --git a/drivers/usb/eth/cdc_ecm.c b/drivers/usb/eth/cdc_ecm.c
new file mode 100644
index 000000000000..115152e4964a
--- /dev/null
+++ b/drivers/usb/eth/cdc_ecm.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#define LOG_CATEGORY UCLASS_ETH
+
+#include <dm.h>
+#include <memalign.h>
+#include <net-common.h>
+#include <usb.h>
+#include <linux/usb/cdc.h>
+#include "cdc_common.h"
+
+#define RX_BUFFER_SIZE			SZ_2K
+
+struct cdc_ecm_priv {
+	struct usb_cdc_ether_desc ether_desc;
+	bool normal_operation;
+	u16 control;
+	u16 data;
+	u16 data_default;
+	u16 data_normal;
+	u32 intpipe;
+	int intinterval;
+	u32 bulkinpipe;
+	u32 bulkoutpipe;
+	u8 *rx_buffer;
+};
+
+static void cdc_ecm_stop(struct udevice *dev)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+
+	/* 6.2.4 SetEthernetPacketFilter [USBECM12] */
+	cdc_set_ethernet_packet_filter(udev, priv->control, 0);
+}
+
+static int cdc_ecm_start(struct udevice *dev)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* 6.2.4 SetEthernetPacketFilter [USBECM12] */
+	cdc_set_ethernet_packet_filter(udev, priv->control,
+				       USB_CDC_PACKET_TYPE_DIRECTED |
+				       USB_CDC_PACKET_TYPE_BROADCAST |
+				       USB_CDC_PACKET_TYPE_MULTICAST);
+
+	if (!priv->normal_operation) {
+		/* Set non-default state to enable normal operation */
+		ret = cdc_set_interface(udev, priv->data, priv->data_normal);
+		if (ret < 0)
+			return ret;
+
+		priv->normal_operation = true;
+	}
+
+	ret = cdc_wait_on_connection(udev, priv->intpipe, priv->intinterval);
+	if (ret < 0)
+		cdc_ecm_stop(dev);
+
+	return ret;
+}
+
+static int cdc_ecm_send(struct udevice *dev, void *packet, int length)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	int actual_length;
+
+	if (length < ETH_HLEN || length > priv->ether_desc.wMaxSegmentSize)
+		return -EINVAL;
+
+	return cdc_bulk_xfer(udev, priv->bulkoutpipe, packet, length,
+			     &actual_length, USB_BULK_SEND_TIMEOUT);
+}
+
+static int cdc_ecm_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	int actual_length, ret;
+
+	if (flags & ETH_RECV_CHECK_DEVICE) {
+		ret = cdc_bulk_xfer(udev, priv->bulkinpipe,
+				    priv->rx_buffer, RX_BUFFER_SIZE,
+				    &actual_length, USB_BULK_RECV_TIMEOUT);
+		if (!ret && actual_length >= ETH_HLEN) {
+			*packetp = priv->rx_buffer;
+			return actual_length;
+		}
+	}
+
+	*packetp = NULL;
+	return -EAGAIN;
+}
+
+static int cdc_ecm_read_rom_hwaddr(struct udevice *dev)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+
+	return cdc_get_mac_address(udev, priv->ether_desc.iMACAddress,
+				   pdata->enetaddr);
+}
+
+static int cdc_ecm_parse_config_descriptor(struct udevice *dev,
+					   struct usb_config_descriptor *config)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	struct usb_interface_descriptor *iface_desc;
+	struct usb_endpoint_descriptor *ep_desc;
+	struct usb_descriptor_header *head;
+	bool comm_if_found = false;
+	bool data_if_found = false;
+	u8 *buffer = (u8 *)config;
+	int ep, index;
+
+	priv->control = U16_MAX;
+	priv->data = U16_MAX;
+	priv->data_default = U16_MAX;
+	priv->data_normal = U16_MAX;
+	priv->intpipe = 0;
+	priv->intinterval = 0;
+	priv->bulkinpipe = 0;
+	priv->bulkoutpipe = 0;
+	memset(&priv->ether_desc, 0, sizeof(priv->ether_desc));
+
+	index = config->bLength;
+	head = (struct usb_descriptor_header *)&buffer[index];
+	while (index + 1 < config->wTotalLength && head->bLength) {
+		if (index + head->bLength > config->wTotalLength)
+			return -EINVAL;
+		switch (head->bDescriptorType) {
+		/* 9.6.5 Interface [USB20] */
+		case USB_DT_INTERFACE:
+			if (head->bLength != USB_DT_INTERFACE_SIZE)
+				return -EINVAL;
+			iface_desc = (struct usb_interface_descriptor *)head;
+			comm_if_found = (iface_desc->bInterfaceClass == USB_CLASS_COMM &&
+					 iface_desc->bInterfaceSubClass == USB_CDC_SUBCLASS_ETHERNET &&
+					 iface_desc->bInterfaceProtocol == USB_CDC_PROTO_NONE);
+			data_if_found = (iface_desc->bInterfaceClass == USB_CLASS_CDC_DATA &&
+					 iface_desc->bInterfaceSubClass == 0 &&
+					 iface_desc->bInterfaceProtocol == USB_CDC_PROTO_NONE);
+			if (comm_if_found) {
+				priv->control = iface_desc->bInterfaceNumber;
+			} else if (data_if_found && iface_desc->bNumEndpoints == 2) {
+				priv->data = iface_desc->bInterfaceNumber;
+				priv->data_normal = iface_desc->bAlternateSetting;
+			} else if (data_if_found && iface_desc->bNumEndpoints == 0) {
+				priv->data_default = iface_desc->bAlternateSetting;
+			}
+			break;
+		/* 9.6.6 Endpoint [USB20] */
+		case USB_DT_ENDPOINT:
+			if (head->bLength != USB_DT_ENDPOINT_SIZE &&
+			    head->bLength != USB_DT_ENDPOINT_AUDIO_SIZE)
+				return -EINVAL;
+			ep_desc = (struct usb_endpoint_descriptor *)head;
+			if (comm_if_found && usb_endpoint_is_int_in(ep_desc)) {
+				ep = usb_endpoint_num(ep_desc);
+				priv->intpipe = usb_rcvintpipe(udev, ep);
+				priv->intinterval = ep_desc->bInterval;
+			} else if (data_if_found && usb_endpoint_is_bulk_in(ep_desc)) {
+				ep = usb_endpoint_num(ep_desc);
+				priv->bulkinpipe = usb_rcvbulkpipe(udev, ep);
+			} else if (data_if_found && usb_endpoint_is_bulk_out(ep_desc)) {
+				ep = usb_endpoint_num(ep_desc);
+				priv->bulkoutpipe = usb_sndbulkpipe(udev, ep);
+			}
+			break;
+		/* 5.2.3 Functional Descriptors [USBCDC12] */
+		case USB_DT_CS_INTERFACE:
+			if (head->bLength < 4)
+				return -EINVAL;
+			if (!comm_if_found)
+				break;
+			switch (buffer[index + 2]) { /* bDescriptorSubType */
+			/* 5.4 Ethernet Networking Functional Descriptor [USBECM12] */
+			case USB_CDC_ETHERNET_TYPE:
+				memcpy(&priv->ether_desc, head, sizeof(priv->ether_desc));
+				le32_to_cpus(&priv->ether_desc.bmEthernetStatistics);
+				le16_to_cpus(&priv->ether_desc.wMaxSegmentSize);
+				le16_to_cpus(&priv->ether_desc.wNumberMCFilters);
+				break;
+			}
+			break;
+		}
+		index += head->bLength;
+		head = (struct usb_descriptor_header *)&buffer[index];
+	}
+
+	if (priv->control == U16_MAX || priv->data == U16_MAX ||
+	    priv->data_default == U16_MAX || priv->data_normal == U16_MAX ||
+	    !priv->bulkinpipe || !priv->bulkoutpipe)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int cdc_ecm_probe(struct udevice *dev)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+	bool configuration_found = false;
+	int cfgno, ret;
+
+	/* Find the CDC ECM configuration */
+	for (cfgno = 0; cfgno < udev->descriptor.bNumConfigurations; cfgno++) {
+		struct usb_config_descriptor *config;
+
+		/* 9.4.3 Get Descriptor [USB20] */
+		config = cdc_get_config_descriptor(udev, cfgno);
+		if (!config)
+			return -ENODEV;
+
+		ret = cdc_ecm_parse_config_descriptor(dev, config);
+		if (!ret) {
+			configuration_found = true;
+			free(config);
+			break;
+		}
+
+		free(config);
+	}
+	if (!configuration_found)
+		return -ENODEV;
+
+	/* 9.4.7 Set Configuration [USB20] */
+	ret = usb_select_configuration_no(udev, cfgno);
+	if (ret < 0)
+		return -ENODEV;
+
+	priv->rx_buffer = malloc_cache_aligned(RX_BUFFER_SIZE);
+	if (!priv->rx_buffer)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int cdc_ecm_remove(struct udevice *dev)
+{
+	struct usb_device *udev = dev_get_parent_priv(dev);
+	struct cdc_ecm_priv *priv = dev_get_priv(dev);
+
+	if (priv->normal_operation) {
+		/* Set default state to disable normal operation */
+		cdc_set_interface(udev, priv->data, priv->data_default);
+	}
+
+	free(priv->rx_buffer);
+
+	return 0;
+}
+
+static const struct eth_ops cdc_ecm_eth_ops = {
+	.start = cdc_ecm_start,
+	.send = cdc_ecm_send,
+	.recv = cdc_ecm_recv,
+	.stop = cdc_ecm_stop,
+	.read_rom_hwaddr = cdc_ecm_read_rom_hwaddr,
+};
+
+U_BOOT_DRIVER(usb_cdc_2_ecm) = {
+	.name = "cdc_ecm",
+	.id = UCLASS_ETH,
+	.probe = cdc_ecm_probe,
+	.remove = cdc_ecm_remove,
+	.ops = &cdc_ecm_eth_ops,
+	.priv_auto = sizeof(struct cdc_ecm_priv),
+	.plat_auto = sizeof(struct eth_pdata),
+};
+
+static const struct usb_device_id cdc_ecm_id_table[] = {
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
+			     USB_CDC_PROTO_NONE), },
+	{ /* sentinel */ }
+};
+
+U_BOOT_USB_DEVICE(usb_cdc_2_ecm, cdc_ecm_id_table);
-- 
2.54.0

