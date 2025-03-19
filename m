Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E78C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B752481D5A;
	Wed, 19 Mar 2025 21:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VRZUViPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4D381D3B; Wed, 19 Mar 2025 21:21:05 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB4AC8193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2DB76100012;
 Wed, 19 Mar 2025 23:20:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2DB76100012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1742415659;
 bh=rTEv5jRKvBhPuHncn2gTz1h76Na5PC+0ObMbSI3BuB0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=VRZUViPfHU7YYEAdAOh+7lobNvL8wf8KhdGR6szYmG5PqImc0k09ERbMoXyPznuem
 0iLYKvC6myGYEB0E5tl9lx5VMNR1nJvEzytGjLrXd1fj0XtOYwRYIP9iFLUtzLz3Ne
 P6/VpQUiApq5jOCdEigrrN4D/4J+8WYCLIlV+4Rzkhp68VpwYx3msmSy8A0+KYuSz9
 1fZ3UllEpVP5U1X+q00o+UXjFb0CXEuiYgzeUQnht5ZDRhUtSDxkdjAkJxYh/WguVo
 fvCBWHPXLNudCbSpSpCFHl9WtbDBbXX5GFknZdNbHwFqlIxHJpPPcyVPfHP0+wlq5U
 IrJS+4+Hp8yiA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 19 Mar 2025 23:20:58 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <oxffffaa@gmail.com>,
 <avkrasnov@salutedevices.com>
Subject: [PATCH v1 03/11] usb: gadget: fastboot: make part of USB fastboot
 code shared
Date: Wed, 19 Mar 2025 23:20:37 +0300
Message-ID: <20250319202045.1407-4-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/19 19:47:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/19 19:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/03/19 17:18:00 #27803216
X-KSMG-AntiVirus-Status: Clean, skipped
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

This is preparation for fastboot-based flashing protocols (such as Amlogic
ADNL). When device enters ADNL mode, it becomes "fastboot" device from
USB point of view, so to avoid copy-paste of USB part of fastboot protocol,
reimplement it as shared code between fastboot and ADNL implementations.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 drivers/usb/gadget/Makefile            |   2 +-
 drivers/usb/gadget/f_fastboot.c        | 295 +----------------------
 drivers/usb/gadget/f_fastboot_common.c | 320 +++++++++++++++++++++++++
 drivers/usb/gadget/f_fastboot_common.h |  71 ++++++
 4 files changed, 403 insertions(+), 285 deletions(-)
 create mode 100644 drivers/usb/gadget/f_fastboot_common.c
 create mode 100644 drivers/usb/gadget/f_fastboot_common.h

diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 4bda224ff1a..6c16ad83f6e 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
 obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) += f_mass_storage.o
-obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += f_fastboot.o
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += f_fastboot.o f_fastboot_common.o
 obj-$(CONFIG_USB_FUNCTION_SDP) += f_sdp.o
 obj-$(CONFIG_USB_FUNCTION_ROCKUSB) += f_rockusb.o
 obj-$(CONFIG_USB_FUNCTION_ACM)	+= f_acm.o
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 3c76d42c5ef..9298658b569 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -23,29 +23,7 @@
 #include <linux/compiler.h>
 #include <g_dnl.h>
 #include <rabbith.h>
-
-#define FASTBOOT_INTERFACE_CLASS	0xff
-#define FASTBOOT_INTERFACE_SUB_CLASS	0x42
-#define FASTBOOT_INTERFACE_PROTOCOL	0x03
-
-#define RX_ENDPOINT_MAXIMUM_PACKET_SIZE_2_0  (0x0200)
-#define RX_ENDPOINT_MAXIMUM_PACKET_SIZE_1_1  (0x0040)
-#define TX_ENDPOINT_MAXIMUM_PACKET_SIZE      (0x0040)
-
-#define EP_BUFFER_SIZE			4096
-/*
- * EP_BUFFER_SIZE must always be an integral multiple of maxpacket size
- * (64 or 512 or 1024), else we break on certain controllers like DWC3
- * that expect bulk OUT requests to be divisible by maxpacket size.
- */
-
-struct f_fastboot {
-	struct usb_function usb_function;
-
-	/* IN/OUT EP's and corresponding requests */
-	struct usb_ep *in_ep, *out_ep;
-	struct usb_request *in_req, *out_req;
-};
+#include "f_fastboot_common.h"
 
 static char fb_ext_prop_name[] = "DeviceInterfaceGUID";
 static char fb_ext_prop_data[] = "{4866319A-F4D6-4374-93B9-DC2DEB361BA9}";
@@ -66,113 +44,7 @@ static struct usb_os_desc_table fb_os_desc_table = {
 	.os_desc = &fb_os_desc,
 };
 
-static inline struct f_fastboot *func_to_fastboot(struct usb_function *f)
-{
-	return container_of(f, struct f_fastboot, usb_function);
-}
-
-static struct f_fastboot *fastboot_func;
-
-static struct usb_endpoint_descriptor fs_ep_in = {
-	.bLength            = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType    = USB_DT_ENDPOINT,
-	.bEndpointAddress   = USB_DIR_IN,
-	.bmAttributes       = USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize     = cpu_to_le16(64),
-};
-
-static struct usb_endpoint_descriptor fs_ep_out = {
-	.bLength		= USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType	= USB_DT_ENDPOINT,
-	.bEndpointAddress	= USB_DIR_OUT,
-	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize		= cpu_to_le16(64),
-};
-
-static struct usb_endpoint_descriptor hs_ep_in = {
-	.bLength		= USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType	= USB_DT_ENDPOINT,
-	.bEndpointAddress	= USB_DIR_IN,
-	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize		= cpu_to_le16(512),
-};
-
-static struct usb_endpoint_descriptor hs_ep_out = {
-	.bLength		= USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType	= USB_DT_ENDPOINT,
-	.bEndpointAddress	= USB_DIR_OUT,
-	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize		= cpu_to_le16(512),
-};
-
-static struct usb_interface_descriptor interface_desc = {
-	.bLength		= USB_DT_INTERFACE_SIZE,
-	.bDescriptorType	= USB_DT_INTERFACE,
-	.bInterfaceNumber	= 0x00,
-	.bAlternateSetting	= 0x00,
-	.bNumEndpoints		= 0x02,
-	.bInterfaceClass	= FASTBOOT_INTERFACE_CLASS,
-	.bInterfaceSubClass	= FASTBOOT_INTERFACE_SUB_CLASS,
-	.bInterfaceProtocol	= FASTBOOT_INTERFACE_PROTOCOL,
-};
-
-static struct usb_descriptor_header *fb_fs_function[] = {
-	(struct usb_descriptor_header *)&interface_desc,
-	(struct usb_descriptor_header *)&fs_ep_in,
-	(struct usb_descriptor_header *)&fs_ep_out,
-	NULL,
-};
-
-static struct usb_descriptor_header *fb_hs_function[] = {
-	(struct usb_descriptor_header *)&interface_desc,
-	(struct usb_descriptor_header *)&hs_ep_in,
-	(struct usb_descriptor_header *)&hs_ep_out,
-	NULL,
-};
-
-/* Super speed */
-static struct usb_endpoint_descriptor ss_ep_in = {
-	.bLength		= USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType	= USB_DT_ENDPOINT,
-	.bEndpointAddress	= USB_DIR_IN,
-	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize		= cpu_to_le16(1024),
-};
-
-static struct usb_endpoint_descriptor ss_ep_out = {
-	.bLength		= USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType	= USB_DT_ENDPOINT,
-	.bEndpointAddress	= USB_DIR_OUT,
-	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
-	.wMaxPacketSize		= cpu_to_le16(1024),
-};
-
-static struct usb_ss_ep_comp_descriptor fb_ss_bulk_comp_desc = {
-	.bLength =		sizeof(fb_ss_bulk_comp_desc),
-	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
-};
-
-static struct usb_descriptor_header *fb_ss_function[] = {
-	(struct usb_descriptor_header *)&interface_desc,
-	(struct usb_descriptor_header *)&ss_ep_in,
-	(struct usb_descriptor_header *)&fb_ss_bulk_comp_desc,
-	(struct usb_descriptor_header *)&ss_ep_out,
-	(struct usb_descriptor_header *)&fb_ss_bulk_comp_desc,
-	NULL,
-};
-
-static struct usb_endpoint_descriptor *
-fb_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
-	    struct usb_endpoint_descriptor *hs,
-	    struct usb_endpoint_descriptor *ss)
-{
-	if (gadget_is_superspeed(g) && g->speed >= USB_SPEED_SUPER)
-		return ss;
-
-	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
-		return hs;
-	return fs;
-}
+static struct fastboot_funcs *fastboot_func;
 
 /*
  * static strings, in UTF-8
@@ -196,179 +68,34 @@ static struct usb_gadget_strings *fastboot_strings[] = {
 
 static void rx_handler_command(struct usb_ep *ep, struct usb_request *req);
 
-static void fastboot_complete(struct usb_ep *ep, struct usb_request *req)
-{
-	int status = req->status;
-	if (!status)
-		return;
-	printf("status: %d ep '%s' trans: %d\n", status, ep->name, req->actual);
-}
-
 static int fastboot_bind(struct usb_configuration *c, struct usb_function *f)
 {
-	int id;
-	struct usb_gadget *gadget = c->cdev->gadget;
-	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const char *s;
-
-	/* DYNAMIC interface numbers assignments */
-	id = usb_interface_id(c, f);
-	if (id < 0)
-		return id;
-	interface_desc.bInterfaceNumber = id;
-
-	/* Enable OS and Extended Properties Feature Descriptor */
-	c->cdev->use_os_string = 1;
-	f->os_desc_table = &fb_os_desc_table;
-	f->os_desc_n = 1;
-	f->os_desc_table->if_id = id;
-	INIT_LIST_HEAD(&fb_os_desc.ext_prop);
-	fb_ext_prop.name_len = strlen(fb_ext_prop.name) * 2 + 2;
-	fb_os_desc.ext_prop_len = 10 + fb_ext_prop.name_len;
-	fb_os_desc.ext_prop_count = 1;
-	fb_ext_prop.data_len = strlen(fb_ext_prop.data) * 2 + 2;
-	fb_os_desc.ext_prop_len += fb_ext_prop.data_len + 4;
-	list_add_tail(&fb_ext_prop.entry, &fb_os_desc.ext_prop);
-
-	id = usb_string_id(c->cdev);
-	if (id < 0)
-		return id;
-	fastboot_string_defs[0].id = id;
-	interface_desc.iInterface = id;
-
-	f_fb->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
-	if (!f_fb->in_ep)
-		return -ENODEV;
-	f_fb->in_ep->driver_data = c->cdev;
-
-	f_fb->out_ep = usb_ep_autoconfig(gadget, &fs_ep_out);
-	if (!f_fb->out_ep)
-		return -ENODEV;
-	f_fb->out_ep->driver_data = c->cdev;
-
-	f->descriptors = fb_fs_function;
-
-	if (gadget_is_dualspeed(gadget)) {
-		/* Assume endpoint addresses are the same for both speeds */
-		hs_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
-		hs_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
-		/* copy HS descriptors */
-		f->hs_descriptors = fb_hs_function;
-	}
-
-	if (gadget_is_superspeed(gadget)) {
-		ss_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
-		ss_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
-		f->ss_descriptors = fb_ss_function;
-	}
-
-	s = env_get("serial#");
-	if (s)
-		g_dnl_set_serialnumber((char *)s);
-
-	return 0;
+	return fastboot_common_bind(c, f, &fb_os_desc_table, &fb_os_desc,
+				    (struct usb_string **)&fastboot_string_defs,
+				    &fb_ext_prop);
 }
 
 static void fastboot_unbind(struct usb_configuration *c, struct usb_function *f)
 {
-	f->os_desc_table = NULL;
-	list_del(&fb_os_desc.ext_prop);
+	fastboot_common_unbind(c, f, &fb_os_desc);
 	memset(fastboot_func, 0, sizeof(*fastboot_func));
 }
 
 static void fastboot_disable(struct usb_function *f)
 {
-	struct f_fastboot *f_fb = func_to_fastboot(f);
-
-	usb_ep_disable(f_fb->out_ep);
-	usb_ep_disable(f_fb->in_ep);
-
-	if (f_fb->out_req) {
-		free(f_fb->out_req->buf);
-		usb_ep_free_request(f_fb->out_ep, f_fb->out_req);
-		f_fb->out_req = NULL;
-	}
-	if (f_fb->in_req) {
-		free(f_fb->in_req->buf);
-		usb_ep_free_request(f_fb->in_ep, f_fb->in_req);
-		f_fb->in_req = NULL;
-	}
-}
-
-static struct usb_request *fastboot_start_ep(struct usb_ep *ep)
-{
-	struct usb_request *req;
-
-	req = usb_ep_alloc_request(ep, 0);
-	if (!req)
-		return NULL;
-
-	req->length = EP_BUFFER_SIZE;
-	req->buf = memalign(CONFIG_SYS_CACHELINE_SIZE, EP_BUFFER_SIZE);
-	if (!req->buf) {
-		usb_ep_free_request(ep, req);
-		return NULL;
-	}
-
-	memset(req->buf, 0, req->length);
-	return req;
+	fastboot_common_disable(f);
 }
 
 static int fastboot_set_alt(struct usb_function *f,
 			    unsigned interface, unsigned alt)
 {
-	int ret;
-	struct usb_composite_dev *cdev = f->config->cdev;
-	struct usb_gadget *gadget = cdev->gadget;
-	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const struct usb_endpoint_descriptor *d;
-
-	debug("%s: func: %s intf: %d alt: %d\n",
-	      __func__, f->name, interface, alt);
-
-	d = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
-	ret = usb_ep_enable(f_fb->out_ep, d);
-	if (ret) {
-		puts("failed to enable out ep\n");
-		return ret;
-	}
-
-	f_fb->out_req = fastboot_start_ep(f_fb->out_ep);
-	if (!f_fb->out_req) {
-		puts("failed to alloc out req\n");
-		ret = -EINVAL;
-		goto err;
-	}
-	f_fb->out_req->complete = rx_handler_command;
-
-	d = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
-	ret = usb_ep_enable(f_fb->in_ep, d);
-	if (ret) {
-		puts("failed to enable in ep\n");
-		goto err;
-	}
-
-	f_fb->in_req = fastboot_start_ep(f_fb->in_ep);
-	if (!f_fb->in_req) {
-		puts("failed alloc req in\n");
-		ret = -EINVAL;
-		goto err;
-	}
-	f_fb->in_req->complete = fastboot_complete;
-
-	ret = usb_ep_queue(f_fb->out_ep, f_fb->out_req, 0);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	fastboot_disable(f);
-	return ret;
+	return fastboot_common_set_alt(f, interface, alt,
+				       rx_handler_command);
 }
 
 static int fastboot_add(struct usb_configuration *c)
 {
-	struct f_fastboot *f_fb = fastboot_func;
+	struct fastboot_funcs *f_fb = fastboot_func;
 	int status;
 
 	debug("%s: cdev: 0x%p\n", __func__, c->cdev);
@@ -515,7 +242,7 @@ static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req
 	/* If response is final OKAY/FAIL response disconnect this handler and unset cmd */
 	if (!strncmp("OKAY", response, 4) || !strncmp("FAIL", response, 4)) {
 		multiresponse_cmd = -1;
-		fastboot_func->in_req->complete = fastboot_complete;
+		fastboot_func->in_req->complete = fastboot_common_complete;
 	}
 }
 
diff --git a/drivers/usb/gadget/f_fastboot_common.c b/drivers/usb/gadget/f_fastboot_common.c
new file mode 100644
index 00000000000..9e509503d2d
--- /dev/null
+++ b/drivers/usb/gadget/f_fastboot_common.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2008 - 2009
+ * Windriver, <www.windriver.com>
+ * Tom Rix <Tom.Rix@windriver.com>
+ *
+ * Copyright 2011 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ *
+ * Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ *
+ * Copyright (c) 2025 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <env.h>
+#include "f_fastboot_common.h"
+
+static struct usb_endpoint_descriptor fs_ep_in = {
+	.bLength            = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType    = USB_DT_ENDPOINT,
+	.bEndpointAddress   = USB_DIR_IN,
+	.bmAttributes       = USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize     = cpu_to_le16(64),
+};
+
+static struct usb_endpoint_descriptor fs_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(64),
+};
+
+static struct usb_interface_descriptor interface_desc = {
+	.bLength		= USB_DT_INTERFACE_SIZE,
+	.bDescriptorType	= USB_DT_INTERFACE,
+	.bInterfaceNumber	= 0x00,
+	.bAlternateSetting	= 0x00,
+	.bNumEndpoints		= 0x02,
+	.bInterfaceClass	= FASTBOOT_INTERFACE_CLASS,
+	.bInterfaceSubClass	= FASTBOOT_INTERFACE_SUB_CLASS,
+	.bInterfaceProtocol	= FASTBOOT_INTERFACE_PROTOCOL,
+};
+
+static struct usb_descriptor_header *fb_fs_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&fs_ep_in,
+	(struct usb_descriptor_header *)&fs_ep_out,
+	NULL,
+};
+
+static struct usb_endpoint_descriptor hs_ep_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(512),
+};
+
+static struct usb_endpoint_descriptor hs_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(512),
+};
+
+static struct usb_descriptor_header *fb_hs_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&hs_ep_in,
+	(struct usb_descriptor_header *)&hs_ep_out,
+	NULL,
+};
+
+/* Super speed */
+static struct usb_endpoint_descriptor ss_ep_in = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_IN,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(1024),
+};
+
+static struct usb_endpoint_descriptor ss_ep_out = {
+	.bLength		= USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType	= USB_DT_ENDPOINT,
+	.bEndpointAddress	= USB_DIR_OUT,
+	.bmAttributes		= USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize		= cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fb_ss_bulk_comp_desc = {
+	.bLength =		sizeof(fb_ss_bulk_comp_desc),
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+};
+
+static struct usb_descriptor_header *fb_ss_function[] = {
+	(struct usb_descriptor_header *)&interface_desc,
+	(struct usb_descriptor_header *)&ss_ep_in,
+	(struct usb_descriptor_header *)&fb_ss_bulk_comp_desc,
+	(struct usb_descriptor_header *)&ss_ep_out,
+	(struct usb_descriptor_header *)&fb_ss_bulk_comp_desc,
+	NULL,
+};
+
+static struct usb_endpoint_descriptor *fastboot_common_ep_desc(struct usb_gadget *g,
+							       struct usb_endpoint_descriptor *fs,
+							       struct usb_endpoint_descriptor *hs,
+							       struct usb_endpoint_descriptor *ss)
+{
+	if (gadget_is_superspeed(g) && g->speed >= USB_SPEED_SUPER)
+		return ss;
+
+	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
+		return hs;
+	return fs;
+}
+
+void fastboot_common_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	int status = req->status;
+
+	if (!status)
+		return;
+
+	printf("status: %d ep '%s' trans: %d\n", status, ep->name, req->actual);
+}
+
+int fastboot_common_bind(struct usb_configuration *c, struct usb_function *f,
+			 struct usb_os_desc_table *fb_os_desc_table,
+			 struct usb_os_desc *fb_os_desc,
+			 struct usb_string **fastboot_string_defs,
+			 struct usb_os_desc_ext_prop *fb_ext_prop)
+{
+	int id;
+	struct usb_gadget *gadget = c->cdev->gadget;
+	struct fastboot_funcs *f_fb = func_to_fastboot_funcs(f);
+	const char *s;
+
+	/* DYNAMIC interface numbers assignments */
+	id = usb_interface_id(c, f);
+	if (id < 0)
+		return id;
+
+	interface_desc.bInterfaceNumber = id;
+
+	/* Enable OS and Extended Properties Feature Descriptor */
+	c->cdev->use_os_string = 1;
+	f->os_desc_table = fb_os_desc_table;
+	f->os_desc_n = 1;
+	f->os_desc_table->if_id = id;
+	INIT_LIST_HEAD(&fb_os_desc->ext_prop);
+	fb_ext_prop->name_len = strlen(fb_ext_prop->name) * 2 + 2;
+	fb_os_desc->ext_prop_len = 10 + fb_ext_prop->name_len;
+	fb_os_desc->ext_prop_count = 1;
+	fb_ext_prop->data_len = strlen(fb_ext_prop->data) * 2 + 2;
+	fb_os_desc->ext_prop_len += fb_ext_prop->data_len + 4;
+	list_add_tail(&fb_ext_prop->entry, &fb_os_desc->ext_prop);
+
+	id = usb_string_id(c->cdev);
+	if (id < 0)
+		return id;
+
+	fastboot_string_defs[0]->id = id;
+	interface_desc.iInterface = id;
+
+	f_fb->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
+	if (!f_fb->in_ep)
+		return -ENODEV;
+
+	f_fb->in_ep->driver_data = c->cdev;
+
+	f_fb->out_ep = usb_ep_autoconfig(gadget, &fs_ep_out);
+	if (!f_fb->out_ep)
+		return -ENODEV;
+
+	f_fb->out_ep->driver_data = c->cdev;
+
+	f->descriptors = fb_fs_function;
+
+	if (gadget_is_dualspeed(gadget)) {
+		/* Assume endpoint addresses are the same for both speeds */
+		hs_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
+		hs_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
+		/* copy HS descriptors */
+		f->hs_descriptors = fb_hs_function;
+	}
+
+	if (gadget_is_superspeed(gadget)) {
+		ss_ep_in.bEndpointAddress = fs_ep_in.bEndpointAddress;
+		ss_ep_out.bEndpointAddress = fs_ep_out.bEndpointAddress;
+		f->ss_descriptors = fb_ss_function;
+	}
+
+	s = env_get("serial#");
+	if (s)
+		g_dnl_set_serialnumber((char *)s);
+
+	return 0;
+}
+
+void fastboot_common_unbind(struct usb_configuration *c,
+			    struct usb_function *f,
+			    struct usb_os_desc *fb_os_desc)
+{
+	f->os_desc_table = NULL;
+	list_del(&fb_os_desc->ext_prop);
+}
+
+static void __fastboot_common_disable(struct usb_function *f, bool disable_out, bool disable_in)
+{
+	struct fastboot_funcs *f_fb = func_to_fastboot_funcs(f);
+
+	if (disable_out)
+		usb_ep_disable(f_fb->out_ep);
+
+	if (disable_in)
+		usb_ep_disable(f_fb->in_ep);
+
+	if (f_fb->out_req) {
+		free(f_fb->out_req->buf);
+		usb_ep_free_request(f_fb->out_ep, f_fb->out_req);
+		f_fb->out_req = NULL;
+	}
+	if (f_fb->in_req) {
+		free(f_fb->in_req->buf);
+		usb_ep_free_request(f_fb->in_ep, f_fb->in_req);
+		f_fb->in_req = NULL;
+	}
+}
+
+void fastboot_common_disable(struct usb_function *f)
+{
+	return __fastboot_common_disable(f, true, true);
+}
+
+static struct usb_request *fastboot_common_start_ep(struct usb_ep *ep)
+{
+	struct usb_request *req;
+
+	req = usb_ep_alloc_request(ep, 0);
+	if (!req)
+		return NULL;
+
+	req->length = EP_BUFFER_SIZE;
+	req->buf = memalign(CONFIG_SYS_CACHELINE_SIZE, EP_BUFFER_SIZE);
+	if (!req->buf) {
+		usb_ep_free_request(ep, req);
+		return NULL;
+	}
+
+	memset(req->buf, 0, req->length);
+	return req;
+}
+
+int fastboot_common_set_alt(struct usb_function *f,
+			    unsigned int interface, unsigned int alt,
+			    void (*rx_handler)(struct usb_ep *ep, struct usb_request *req))
+{
+	int ret;
+	struct usb_composite_dev *cdev = f->config->cdev;
+	struct usb_gadget *gadget = cdev->gadget;
+	struct fastboot_funcs *f_adnl = func_to_fastboot_funcs(f);
+	const struct usb_endpoint_descriptor *d;
+	bool disable_out = false;
+	bool disable_in = false;
+
+	debug("%s: func: %s intf: %u alt: %u\n",
+	      __func__, f->name, interface, alt);
+
+	d = fastboot_common_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
+	ret = usb_ep_enable(f_adnl->out_ep, d);
+	if (ret) {
+		puts("failed to enable out ep\n");
+		return ret;
+	}
+
+	disable_out = true;
+
+	f_adnl->out_req = fastboot_common_start_ep(f_adnl->out_ep);
+	if (!f_adnl->out_req) {
+		puts("failed to alloc out req\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	f_adnl->out_req->complete = rx_handler;
+
+	d = fastboot_common_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(f_adnl->in_ep, d);
+	if (ret) {
+		puts("failed to enable in ep\n");
+		goto err;
+	}
+
+	disable_in = true;
+
+	f_adnl->in_req = fastboot_common_start_ep(f_adnl->in_ep);
+	if (!f_adnl->in_req) {
+		puts("failed alloc req in\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	f_adnl->in_req->complete = fastboot_common_complete;
+
+	ret = usb_ep_queue(f_adnl->out_ep, f_adnl->out_req, 0);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	__fastboot_common_disable(f, disable_out, disable_in);
+	return ret;
+}
+
+struct fastboot_funcs *func_to_fastboot_funcs(struct usb_function *f)
+{
+	return container_of(f, struct fastboot_funcs, usb_function);
+}
diff --git a/drivers/usb/gadget/f_fastboot_common.h b/drivers/usb/gadget/f_fastboot_common.h
new file mode 100644
index 00000000000..dba7d7003ba
--- /dev/null
+++ b/drivers/usb/gadget/f_fastboot_common.h
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2008 - 2009
+ * Windriver, <www.windriver.com>
+ * Tom Rix <Tom.Rix@windriver.com>
+ *
+ * Copyright 2011 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ *
+ * Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ *
+ * Copyright (c) 2025 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#ifndef __F_FASTBOOT_COMMON_H_
+#define __F_FASTBOOT_COMMON_H_
+#include <g_dnl.h>
+
+/*
+ * EP_BUFFER_SIZE must always be an integral multiple of maxpacket size
+ * (64 or 512 or 1024), else we break on certain controllers like DWC3
+ * that expect bulk OUT requests to be divisible by maxpacket size.
+ */
+#define EP_BUFFER_SIZE			4096
+
+#define FASTBOOT_INTERFACE_CLASS	0xff
+#define FASTBOOT_INTERFACE_SUB_CLASS	0x42
+#define FASTBOOT_INTERFACE_PROTOCOL	0x03
+
+struct fastboot_funcs {
+	struct usb_function usb_function;
+
+	/* IN/OUT EP's and corresponding requests */
+	struct usb_ep *in_ep, *out_ep;
+	struct usb_request *in_req, *out_req;
+};
+
+void fastboot_common_complete(struct usb_ep *ep, struct usb_request *req);
+
+/*
+ * Initializes USB function 'f' with provided resources and binds it to the
+ * USB configuration 'c'.
+ */
+int fastboot_common_bind(struct usb_configuration *c, struct usb_function *f,
+			 struct usb_os_desc_table *fb_os_desc_table,
+			 struct usb_os_desc *fb_os_desc,
+			 struct usb_string **fastboot_string_defs,
+			 struct usb_os_desc_ext_prop *fb_ext_prop);
+
+/* Reverse for 'fastboot_bind_common()'. */
+void fastboot_common_unbind(struct usb_configuration *c,
+			    struct usb_function *f,
+			    struct usb_os_desc *fb_os_desc);
+
+/*
+ * Setups endpoints, allocates memory and sets callbacks for both IN and
+ * OUT requests.
+ */
+int fastboot_common_set_alt(struct usb_function *f,
+			    unsigned int interface, unsigned int alt,
+			    void (*rx_handler)(struct usb_ep *ep,
+					       struct usb_request *req));
+
+/* Disables provided USB function 'f'. */
+void fastboot_common_disable(struct usb_function *f);
+
+/* Returns parent struct of 'f'. */
+struct fastboot_funcs *func_to_fastboot_funcs(struct usb_function *f);
+
+#endif /* __F_FASTBOOT_COMMON_H_ */
-- 
2.30.1

