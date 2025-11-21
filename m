Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25E1CFC28A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8588B839DD;
	Fri, 21 Nov 2025 16:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xPXScU5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146A7839D9; Fri, 21 Nov 2025 16:38:36 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DFC8394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso1431858f8f.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763739512; x=1764344312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYtZdVqz3hw7SyvOOITt9XlgL/uk+NHqoAER8XV++GE=;
 b=xPXScU5P+ovmJ3+TAYoP3htloaMRS3oiqTBZ7SI5Q3CeTQBl9t5BcrIIIgGeqDWTmw
 b4yvHq/C7Raor5axizg4022y2TIdR1CH0dG1YPRAiy2xg5pa+oJPmcckGNjGjAFiRyW8
 fY8Mfezx/dPEI6fHUf7wLRBm0kLjAJ+JLjdJ7wnfSiNJqOJDW3uGmbdofgw5d+Pkzupw
 WKp4PdOXp3v8LjgcFOWsvsNnjPhzJPoHEVj9L+8icmIK4sYXYEG5IkER6wNiE/BJMEQ2
 bnxOTg5/5sNCW4FQ9Spc4oMdYrJqu62Ob7/664iYrmhJPA/DzXYd9XvcnN9KcJrtbcO1
 cQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739512; x=1764344312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYtZdVqz3hw7SyvOOITt9XlgL/uk+NHqoAER8XV++GE=;
 b=N1Yn5rL8l2ApE37kfQ+PKGwX4U+cTP9ZiyBfZa4GYakp2LLsyBv2cwXS6M0fvFa1PA
 cZ9eBgACJsMOfDfuI7fAs9S7QSh5/EQaJ3Nr4QT2la7VD4D4RvYAjmSyo/xJhN1PvlI1
 wUM2EAt0MWFm3Rr2M/ITbFAC3q9/hX2YsJAssIeOGBplXrL+Wj/AprIOCelpOWZYXszc
 WQ11E6lTj7NDHtVFTCVpxMnJWvVLmnjzkRedmBFZEuiLh3LpuB1/AuldGeQWeBK3ZQNu
 dqaLpclSvqAQOvLp3oa1NwZj+VCPlqluTlrZQcEFOW7ap+T3dVj+1kXypIhAx9l/e6Xk
 Ek4A==
X-Gm-Message-State: AOJu0YyVvTWtBhrErenNoG+1T1fLmzuZCJTDcHB4eTjQ1mK8uMZkqYTf
 ovTMBRqGiClCSzkNNrYLh3sxVvT1cLKKJbw/IWq+W5wwjI8JZ3NuQUIMJGDZdi1BoJLJWY2Nv+l
 ThdRX
X-Gm-Gg: ASbGncuL2aJ9nS95IVwkZz+rrrpwmhKxVxSw1XDmEn0CELuOLzqIBWHK4uT+N8Lmw4X
 wEjDGRM/x5vCLtAEXqToFZk47tVSl97IBgg7ZnSuvG4TmnvmKk9c9N0pA4lp9phOXdjPIsAXtDn
 sne2BOjsKlM7KZtkGpFp350i4zpIxZn5Pb04mXaoV9XdJxJhMQ4d6FMi6Dpg/A4/+o8l7BNZntM
 kDXe2+oAXt8ESLFy5gmD+kvRiDqSpN5NnybvhWMR2j2ZQw9vPdA36mdZ16OWa9upc+cbZdWW1z/
 Rn9UviQLTmqo4iSMNdqVe7CXv2N7KSmXPRH/mlzQdUGGv4XMd+vEgjehvRoSaUxKyvJjfqKPAsA
 bYr3/fjHZcUq9jhjm2VY9KzhV+mI9TRORZ/QgDo2bHrpYcUUNa9P5vn5piOKjHpfrVaPx93fXA7
 vK+OGXiuld91ATexpjhh0=
X-Google-Smtp-Source: AGHT+IFHCkRUEeQGmydIdFJMLPJDJkrqujLAlYu6mgV39VKdvajqE31JVoSg9fvhv4JVAa/oiRwnDw==
X-Received: by 2002:a05:6000:24c5:b0:42b:2dd5:42be with SMTP id
 ffacd0b85a97d-42cc1ab76ffmr2529792f8f.8.1763739511929; 
 Fri, 21 Nov 2025 07:38:31 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2035:a57d:e702:e09e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm11487964f8f.43.2025.11.21.07.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:38:31 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 3/5] usb: gadget: re-import epautoconf.c from kernel
 v6.16-rc7
Date: Fri, 21 Nov 2025 16:37:52 +0100
Message-ID: <20251121153812.2076440-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251121153812.2076440-1-jerome.forissier@linaro.org>
References: <20251121153812.2076440-1-jerome.forissier@linaro.org>
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

Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
kernel. Fixes will come later.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 drivers/usb/gadget/epautoconf.c | 291 +++++++++++++++-----------------
 1 file changed, 132 insertions(+), 159 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 495460473e9a..30016b805bfd 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -3,170 +3,120 @@
  * epautoconf.c -- endpoint autoconfiguration for usb gadget drivers
  *
  * Copyright (C) 2004 David Brownell
- *
- * Ported to U-Boot by: Thomas Smits <ts.smits@gmail.com> and
- *                      Remy Bohmer <linux@bohmer.net>
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+
+#include <linux/ctype.h>
+#include <linux/string.h>
+
 #include <linux/usb/ch9.h>
-#include <linux/errno.h>
 #include <linux/usb/gadget.h>
-#include <asm/unaligned.h>
 
-#define isdigit(c)      ('0' <= (c) && (c) <= '9')
-
-/* we must assign addresses for configurable endpoints (like net2280) */
-static unsigned epnum;
-
-/* #define MANY_ENDPOINTS */
-#ifdef MANY_ENDPOINTS
-/* more than 15 configurable endpoints */
-static unsigned in_epnum;
-#endif
-
-/*
- * This should work with endpoints from controller drivers sharing the
- * same endpoint naming convention.  By example:
+/**
+ * usb_ep_autoconfig_ss() - choose an endpoint matching the ep
+ * descriptor and ep companion descriptor
+ * @gadget: The device to which the endpoint must belong.
+ * @desc: Endpoint descriptor, with endpoint direction and transfer mode
+ *    initialized.  For periodic transfers, the maximum packet
+ *    size must also be initialized.  This is modified on
+ *    success.
+ * @ep_comp: Endpoint companion descriptor, with the required
+ *    number of streams. Will be modified when the chosen EP
+ *    supports a different number of streams.
+ *
+ * This routine replaces the usb_ep_autoconfig when needed
+ * superspeed enhancments. If such enhancemnets are required,
+ * the FD should call usb_ep_autoconfig_ss directly and provide
+ * the additional ep_comp parameter.
+ *
+ * By choosing an endpoint to use with the specified descriptor,
+ * this routine simplifies writing gadget drivers that work with
+ * multiple USB device controllers.  The endpoint would be
+ * passed later to usb_ep_enable(), along with some descriptor.
+ *
+ * That second descriptor won't always be the same as the first one.
+ * For example, isochronous endpoints can be autoconfigured for high
+ * bandwidth, and then used in several lower bandwidth altsettings.
+ * Also, high and full speed descriptors will be different.
  *
- *	- ep1, ep2, ... address is fixed, not direction or type
- *	- ep1in, ep2out, ... address and direction are fixed, not type
- *	- ep1-bulk, ep2-bulk, ... address and type are fixed, not direction
- *	- ep1in-bulk, ep2out-iso, ... all three are fixed
- *	- ep-* ... no functionality restrictions
+ * Be sure to examine and test the results of autoconfiguration
+ * on your hardware.  This code may not make the best choices
+ * about how to use the USB controller, and it can't know all
+ * the restrictions that may apply. Some combinations of driver
+ * and hardware won't be able to autoconfigure.
  *
- * Type suffixes are "-bulk", "-iso", or "-int".  Numbers are decimal.
- * Less common restrictions are implied by gadget_is_*().
+ * On success, this returns an claimed usb_ep, and modifies the endpoint
+ * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
+ * is initialized as if the endpoint were used at full speed and
+ * the bmAttribute field in the ep companion descriptor is
+ * updated with the assigned number of streams if it is
+ * different from the original value. To prevent the endpoint
+ * from being returned by a later autoconfig call, claims it by
+ * assigning ep->claimed to true.
  *
- * NOTE:  each endpoint is unidirectional, as specified by its USB
- * descriptor; and isn't specific to a configuration or altsetting.
+ * On failure, this returns a null endpoint descriptor.
  */
-static int ep_matches(
+struct usb_ep *usb_ep_autoconfig_ss(
 	struct usb_gadget		*gadget,
-	struct usb_ep			*ep,
-	struct usb_endpoint_descriptor	*desc
+	struct usb_endpoint_descriptor	*desc,
+	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	u8		type;
-	const char	*tmp;
-	u16		max;
+	struct usb_ep	*ep;
 
-	/* endpoint already claimed? */
-	if (NULL != ep->driver_data)
-		return 0;
-
-	/* only support ep0 for portable CONTROL traffic */
-	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
-	if (USB_ENDPOINT_XFER_CONTROL == type)
-		return 0;
-
-	/* some other naming convention */
-	if ('e' != ep->name[0])
-		return 0;
-
-	/* type-restriction:  "-iso", "-bulk", or "-int".
-	 * direction-restriction:  "in", "out".
-	 */
-	if ('-' != ep->name[2]) {
-		tmp = strrchr(ep->name, '-');
-		if (tmp) {
-			switch (type) {
-			case USB_ENDPOINT_XFER_INT:
-				/* bulk endpoints handle interrupt transfers,
-				 * except the toggle-quirky iso-synch kind
-				 */
-				if ('s' == tmp[2])	/* == "-iso" */
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				if ('b' != tmp[1])	/* != "-bulk" */
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				if ('s' != tmp[2])	/* != "-iso" */
-					return 0;
-			}
-		} else {
-			tmp = ep->name + strlen(ep->name);
-		}
-
-		/* direction-restriction:  "..in-..", "out-.." */
-		tmp--;
-		if (!isdigit(*tmp)) {
-			if (desc->bEndpointAddress & USB_DIR_IN) {
-				if ('n' != *tmp)
-					return 0;
-			} else {
-				if ('t' != *tmp)
-					return 0;
-			}
-		}
+	if (gadget->ops->match_ep) {
+		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
+		if (ep)
+			goto found_ep;
 	}
 
-	/* endpoint maxpacket size is an input parameter, except for bulk
-	 * where it's an output parameter representing the full speed limit.
-	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
-	 */
-	max = 0x7ff & le16_to_cpu(get_unaligned(&desc->wMaxPacketSize));
-	switch (type) {
-	case USB_ENDPOINT_XFER_INT:
-		/* INT:  limit 64 bytes full speed, 1024 high speed */
-		if (!gadget->is_dualspeed && max > 64)
-			return 0;
-		/* FALLTHROUGH */
-
-	case USB_ENDPOINT_XFER_ISOC:
-		/* ISO:  limit 1023 bytes full speed, 1024 high speed */
-		if (ep->maxpacket < max)
-			return 0;
-		if (!gadget->is_dualspeed && max > 1023)
-			return 0;
-
-		/* BOTH:  "high bandwidth" works only at high speed */
-		if ((get_unaligned(&desc->wMaxPacketSize) &
-					__constant_cpu_to_le16(3<<11))) {
-			if (!gadget->is_dualspeed)
-				return 0;
-			/* configure your hardware with enough buffering!! */
-		}
-		break;
+	/* Second, look at endpoints until an unclaimed one looks usable */
+	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
+			goto found_ep;
 	}
 
-	/* MATCH!! */
+	/* Fail */
+	return NULL;
+found_ep:
+
+	/*
+	 * If the protocol driver hasn't yet decided on wMaxPacketSize
+	 * and wants to know the maximum possible, provide the info.
+	 */
+	if (desc->wMaxPacketSize == 0)
+		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
 
 	/* report address */
+	desc->bEndpointAddress &= USB_DIR_IN;
 	if (isdigit(ep->name[2])) {
-		u8	num = dectoul(&ep->name[2], NULL);
+		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
 		desc->bEndpointAddress |= num;
-#ifdef	MANY_ENDPOINTS
 	} else if (desc->bEndpointAddress & USB_DIR_IN) {
-		if (++in_epnum > 15)
-			return 0;
-		desc->bEndpointAddress = USB_DIR_IN | in_epnum;
-#endif
+		if (++gadget->in_epnum > 15)
+			return NULL;
+		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
 	} else {
-		if (++epnum > 15)
-			return 0;
-		desc->bEndpointAddress |= epnum;
+		if (++gadget->out_epnum > 15)
+			return NULL;
+		desc->bEndpointAddress |= gadget->out_epnum;
 	}
 
-	/* report (variable) full speed bulk maxpacket */
-	if (USB_ENDPOINT_XFER_BULK == type) {
-		int size = ep->maxpacket;
-
-		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
-		put_unaligned(cpu_to_le16(size), &desc->wMaxPacketSize);
-	}
-
-	if (gadget->ops->ep_conf)
-		return gadget->ops->ep_conf(gadget, ep, desc);
-
-	return 1;
+	ep->address = desc->bEndpointAddress;
+	ep->desc = NULL;
+	ep->comp_desc = NULL;
+	ep->claimed = true;
+	return ep;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
 
 /**
- * usb_ep_autoconfig - choose an endpoint matching the descriptor
+ * usb_ep_autoconfig() - choose an endpoint matching the
+ * descriptor
  * @gadget: The device to which the endpoint must belong.
  * @desc: Endpoint descriptor, with endpoint direction and transfer mode
  *	initialized.  For periodic transfers, the maximum packet
@@ -187,11 +137,12 @@ static int ep_matches(
  * USB controller, and it can't know all the restrictions that may apply.
  * Some combinations of driver and hardware won't be able to autoconfigure.
  *
- * On success, this returns an un-claimed usb_ep, and modifies the endpoint
+ * On success, this returns an claimed usb_ep, and modifies the endpoint
  * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
- * is initialized as if the endpoint were used at full speed.  To prevent
- * the endpoint from being returned by a later autoconfig call, claim it
- * by assigning ep->driver_data to some non-null value.
+ * is initialized as if the endpoint were used at full speed. Because of
+ * that the users must consider adjusting the autoconfigured descriptor.
+ * To prevent the endpoint from being returned by a later autoconfig call,
+ * claims it by assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -200,23 +151,45 @@ struct usb_ep *usb_ep_autoconfig(
 	struct usb_endpoint_descriptor	*desc
 )
 {
-	struct usb_ep *ep;
+	struct usb_ep	*ep;
+	u8		type;
 
-	if (gadget->ops->match_ep) {
-		ep = gadget->ops->match_ep(gadget, desc, NULL);
-		if (ep && ep_matches(gadget, ep, desc))
-			return ep;
-	}
+	ep = usb_ep_autoconfig_ss(gadget, desc, NULL);
+	if (!ep)
+		return NULL;
+
+	type = usb_endpoint_type(desc);
+
+	/* report (variable) full speed bulk maxpacket */
+	if (type == USB_ENDPOINT_XFER_BULK) {
+		int size = ep->maxpacket_limit;
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep_matches(gadget, ep, desc))
-			return ep;
+		/* min() doesn't work on bitfields with gcc-3.5 */
+		if (size > 64)
+			size = 64;
+		desc->wMaxPacketSize = cpu_to_le16(size);
 	}
 
-	/* Fail */
-	return NULL;
+	return ep;
+}
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
+
+/**
+ * usb_ep_autoconfig_release - releases endpoint and set it to initial state
+ * @ep: endpoint which should be released
+ *
+ * This function can be used during function bind for endpoints obtained
+ * from usb_ep_autoconfig(). It unclaims endpoint claimed by
+ * usb_ep_autoconfig() to make it available for other functions. Endpoint
+ * which was released is no longer valid and shouldn't be used in
+ * context of function which released it.
+ */
+void usb_ep_autoconfig_release(struct usb_ep *ep)
+{
+	ep->claimed = false;
+	ep->driver_data = NULL;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_release);
 
 /**
  * usb_ep_autoconfig_reset - reset endpoint autoconfig state
@@ -224,18 +197,18 @@ struct usb_ep *usb_ep_autoconfig(
  *
  * Use this for devices where one configuration may need to assign
  * endpoint resources very differently from the next one.  It clears
- * state such as ep->driver_data and the record of assigned endpoints
+ * state such as ep->claimed and the record of assigned endpoints
  * used by usb_ep_autoconfig().
  */
-void usb_ep_autoconfig_reset(struct usb_gadget *gadget)
+void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 {
 	struct usb_ep	*ep;
 
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
+	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
+		ep->claimed = false;
 		ep->driver_data = NULL;
 	}
-#ifdef	MANY_ENDPOINTS
-	in_epnum = 0;
-#endif
-	epnum = 0;
+	gadget->in_epnum = 0;
+	gadget->out_epnum = 0;
 }
+EXPORT_SYMBOL_GPL(usb_ep_autoconfig_reset);
-- 
2.48.1

