Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F424C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6408E849A3;
	Mon, 29 Jun 2026 14:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ik8ZeNkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1536284844; Mon, 29 Jun 2026 10:48:09 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D4484B39
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39b1026e171so5261521fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722885; x=1783327685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vu4JwUWgsw/xppVEefXAKGOLbZuj/z2hWN+iGJwNx38=;
 b=ik8ZeNkOqpxeg1sc+Bt86yhLtf/eYnKAcgJMwtpU6eoEotQyKgFKeqbXnFMmQSRWqu
 Hqz0KeFRhjlVxXtJL2y7Hbksh4jWT91AnR+UADBniQh37igy+MK5DVueSsnUb+D2u8aG
 8srNrrckRjUqoF5lHKOPEBQcWpxgKZtdLG1TT3fDRru1qC3VQ8YzEgGuPqNQqjDbGv51
 BHN+gozZOTUrPhSDTBHQbb8qGkvzvda3q/p9MSpTSkGxWVsXcHlkiqqGHujXVP9D8RtW
 YelGRYhu1Hem7wz28F1f76kBFBSF436r3f8GABYXVZ9mkeR51V+NrFNm93Yd4o6V9kVR
 +x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722885; x=1783327685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vu4JwUWgsw/xppVEefXAKGOLbZuj/z2hWN+iGJwNx38=;
 b=PKiLYMRAAsANY+ZraG8WHBd254QA1Ei4fhtoEmIymmfwp2ExptZmvPT3O2wr41im5M
 EGIEJoIIk8d0bGF4tarP1GhkRQ8ir9+z/zAHx3/Bj7VkEre5W7jO5CWjWp4D61YVy8Vo
 mO7SpGqXXZPjzfHGTdEoTs2IIoN0u4/uqC4hiudZckpVb/xiIDbJEv82ETEZ2v6kcDpp
 nxyEkLCNqEwWB9jWHNPW49uiBvU6ndcHokeiIINnAdDYcug6muNxDTi3SdZWU3wK+mqO
 iDc4CPO2NfsDLU7Ia8uNaVdXf7mpNxabYnexZDl0MDK6crQ+ee/593xYk3KfNueeKD0c
 Worg==
X-Gm-Message-State: AOJu0Yw8xzp0chFa/WQPJVfompTYDw180em9/wWhsXGioKXXEJJ5+hG8
 Kct6SfryTQbmXiI8KGGUR0zl2sACMgwlUnM1TMe+LA1M9XmW/SPyqSLISPntwqdBNsY8RC84dsd
 7taiUqI0=
X-Gm-Gg: AfdE7clSkvQZjl9P7zFzeIYga93Z9h5XxAT8irE41e3QJaW0d2SxpFZ1uxdnFABp7kX
 IUiMzbUGPr0Qe/kY5YvC1QCiAeaR62y2ql/K+JD4dKC1gmfb1Bo66uO4t3pojS4XmtFz3wPKWWm
 Y6M/jz6E12pS6JV0PLs8iI/SDFCKthBJKhK2UYDPL/7wB2HsiTd/+Apmb0binZcEubngXD6wPWy
 r9L2x2UDTs860mdivL5UikMdB+FPjOaYSF5DrWzt4uwa7YXK9GDVHZdTszOn+noJtMe1n/L4V8Z
 9kLebdUpKkiuejgMdOLChqrTPsaFTd6Ym3xyLUCpWFO5c6nK8uYwfQMVWYn3cB99vmzDFDzuHH/
 xt207sFtU2PD6+Z8qKPLn0x3hKO2iHgCHd95Vts7/LBHQfVkiskFnnGpObyuJo6akcsqi5541lZ
 QiY52qLuA3cWBZeCUHJeiM7OaYKSA3Ok2H5e96BskJvd/CISl00CtMOVJonzvFQvvdY3IOqfP61
 3eM2I5+c464Z+yzrJBO
X-Received: by 2002:a2e:a58d:0:b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-39acb55274fmr38155241fa.2.1782722885207; 
 Mon, 29 Jun 2026 01:48:05 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:48:03 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 62/64] usb: gadget: re-import epautoconf.c from kernel v6.16
Date: Mon, 29 Jun 2026 10:44:38 +0200
Message-ID: <20260629084507.3254232-63-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
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

From: Jerome Forissier <jerome.forissier@linaro.org>

Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
kernel. Fixes will come later.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
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
2.43.0

