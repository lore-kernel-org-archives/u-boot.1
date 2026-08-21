Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789CEC5DF93
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E6CA61088;
	Fri, 21 Aug 2026 13:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqCMpWYCCf6k; Fri, 21 Aug 2026 13:18:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318109;
	bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fM1bjgCsQVBE3xhkhp1vi15WSb9rPIVpi66RjMhnJNwvXcqD2fSko6ieh26lc8xOc
	 Dm6NdM2Ro0kwCP2BuLVSh7PifWx2geNV74oMeezALaJ88evao+Ammc1up9Fse4Te9j
	 r64iA9RCKplmYz894dK9p8LieFK3I9dkti9jAcf8xj8YBKOqPVL3qdEUV4W3bwG4jy
	 NePltw+IiY+eiIVWHNlfXBoO3+oft0NWtlOZazXrOUTcgbms/m65UXj3rnQroPyE83
	 GJDIlrtBSwzdu2AidTTAOCUwBXzNThaNe9MHjNnf5ru7ns9l8D6rlDtu+R9iHLYJJb
	 Ee4TXUVzecy6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0669960F0B;
	Fri, 21 Aug 2026 13:15:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 461BA2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3838640071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-swGarudyio for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ClfXVypC
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9116E4006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso133246a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302338; x=1787907138;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
 b=ClfXVypCKc+k4yWqcQQft45TOLJZr1robfBjU6/EPJPBHSH95bF0ad5p+k5ttoH9qP
 D2VwGzyJJuJfFwTLAGYbTVFi0cYaTQWvX5AvrpjwAXxkZg9pUCpHP99TzHfVP6el0SXK
 EaveZ45o7D/zvpl0eZ1CEZi5O4KxorauFgapPwv3YirsKSTR7QwK7JTV3xMgrPaVCWPP
 4sFBvser6pKc/358yZpOlo2YNKT6G+NMSOSPyVum4g42GlvOyNdmZEG5QINdBRfjjQiO
 AsigOH3aUA9HczkFJCUt9s+tuPSz22UcBz8JBT2nCqKXjSXkQzL8v19btWqBKPizQ1gP
 rCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302338; x=1787907138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N08ZBrgMsyjx3ftDO7O7GR689tqBX00t5T5ExBAfNHw=;
 b=rsGdnkXgPAQW+Refj1UdjywKF3ZYAhcDMyGsOSNnrYd9HRxNpjI0lQ8Zka9rZEyH7E
 gUUy7Af9E9Ab8YuU/zxT0vGvf2jMYZ1PYuqVFGFhgTQOgoXrIPBYluUHQMWah4/KHDUq
 MY6Ru9/SMVlU92g0f/pWc4clws9PAldhbTEUcyRZwAYSQQrDtJc82ep1aIB4YAzXtVs5
 wkFeb+cHCVt4cLoySWNZ3q93ty7/xi/H/MRYsFT3hr4EJ4aeZ50q2p4PzKJZ9Fj6GsHC
 RUvg84sMrigBNt+ovB853QHZ/R11XEDZTdRK9HAkmhgcjpjKLGVVtZ+k/4fhABIPkHnV
 nyzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7ooT/SidfKWt3Z6lg6MdA8VMBELgJwWzGkgNnBYSTkBwJp1LT9DN6B436gAom3YFur39n6y8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k6xe/mS8T869B4xorCnrH6GGVLP6j97AiI7sYNT3wuNXdnYvDu
 30liosGcBgHthNSut0DFCbMxRerfVOUa/BkyF1uV0D8aJuwYkjOS6sC0VJDmxMzgu5A=
X-Gm-Gg: AR+sD10w1SWSEUVr5TmwuDELwPvZWWKelFM22VnJa4mSU+k8OtSus7Bwk30Ue9ZYhO2
 cgf15dbaAB2uYSISuo2liPoVDtRGgg/HMjmdqkrG6BWCrP63RuKTOv6Oq6cDBg+Sn0Z9sd/8Xye
 wn+6H9RkoGX3NcoyrlBLmYmZWkXUHKU1m8tl3i2iGIqHd83IjsdxRdYstIaehCI/W55iGxhkdjK
 soEErexSq/hXwLWxkCvOEIDZLEgO/9ChEedkED9w8G6bBRmAZrB2oEV0y9a9sxqlsmMluG33Qsf
 6HxDjvCg0MTCgqbT2BbelvsBR8NgVQDsVjuujJAstwBaGBvg+o+Wu47S0V+jNmhBgyCQ863fCX2
 skUuezINQRQwwQ6qwOH31cL3mLRakKPO4hNpb47Oh+K24J15lmx9ZCINRxdh4T2OvqrrbVg7cuj
 ar1TKkYp+COXgyfPBoWIRn43oEHanUNYJZnj3z/DQ5QpZ8wBZd8VapHqAeC29CBEqkzXoNEvTrl
 jcBrhIP/sh3o/mn4ypC98Ob
X-Received: by 2002:a05:6402:d0e:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a42eeb84dcmr2855407a12.0.1787302338333; 
 Fri, 21 Aug 2026 01:52:18 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c315dsm5319073a12.9.2026.08.21.01.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 62/87] usb: gadget: re-import epautoconf.c from kernel v6.16
Date: Fri, 21 Aug 2026 10:47:38 +0200
Message-ID: <20260821084829.2070426-63-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jerome Forissier <jerome.forissier@linaro.org>

Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
kernel. Fixes will come later.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/epautoconf.c | 292 +++++++++++++++-----------------
 1 file changed, 133 insertions(+), 159 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 495460473e9a..4fbea9137240 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -1,172 +1,123 @@
 // SPDX-License-Identifier: GPL-2.0+
+/* Imported from Linux v6.16 */
 /*
  * epautoconf.c -- endpoint autoconfiguration for usb gadget drivers
  *
  * Copyright (C) 2004 David Brownell
- *
- * Ported to U-Boot by: Thomas Smits <ts.smits@gmail.com> and
- *                      Remy Bohmer <linux@bohmer.net>
  */
 
-#include <linux/usb/ch9.h>
-#include <linux/errno.h>
-#include <linux/usb/gadget.h>
-#include <asm/unaligned.h>
-
-#define isdigit(c)      ('0' <= (c) && (c) <= '9')
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
 
-/* we must assign addresses for configurable endpoints (like net2280) */
-static unsigned epnum;
+#include <linux/ctype.h>
+#include <linux/string.h>
 
-/* #define MANY_ENDPOINTS */
-#ifdef MANY_ENDPOINTS
-/* more than 15 configurable endpoints */
-static unsigned in_epnum;
-#endif
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
 
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
-
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
+	struct usb_ep	*ep;
 
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
@@ -187,11 +138,12 @@ static int ep_matches(
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
@@ -200,23 +152,45 @@ struct usb_ep *usb_ep_autoconfig(
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
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
-	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep_matches(gadget, ep, desc))
-			return ep;
+	type = usb_endpoint_type(desc);
+
+	/* report (variable) full speed bulk maxpacket */
+	if (type == USB_ENDPOINT_XFER_BULK) {
+		int size = ep->maxpacket_limit;
+
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
@@ -224,18 +198,18 @@ struct usb_ep *usb_ep_autoconfig(
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
2.53.0

