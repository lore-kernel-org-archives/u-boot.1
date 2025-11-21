Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94DDCFC28B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1DB839B7;
	Fri, 21 Nov 2025 16:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h23BKRMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE452839B7; Fri, 21 Nov 2025 16:38:38 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B5783966
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso1985738f8f.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763739514; x=1764344314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/cVV2oSIym5wwEG6IaWDV7AP5wWj/NsUEulwZfRdEU=;
 b=h23BKRMcBeEes2ZysrUiPgnvreJjZBJzBFP5pStD4ZrRZWS1qaazSB/9U/rTGNtRCO
 aBdtrL3DfzI6fwHPwXRdh1ebQI3V1DDOu8pHj/bdtttVrwTmy9BVlkGx3QiST4qLsif8
 IEjG8lc9Bj9m449GuUn4MkxTvikoNxwbwgx0VSj8LfdjbOiLduX0rwYPWqG/AznIRFqB
 rUm3df5zSUKr6+OPSTeaOqrdefXXcf0q+HZOv07g5LkJ2UXHYubDhtNI3JbMRv7yKzsi
 6yQinVKmWBIy9Xy7rs9q9cnJ9X3eb0Pf9QYgpeO+oZk4h7kr4icEicIwrSKByAZ88RU/
 AhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739514; x=1764344314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l/cVV2oSIym5wwEG6IaWDV7AP5wWj/NsUEulwZfRdEU=;
 b=avK+UDgqRIB4EtfqnVKGmTGJ/bLSNWlO5RMZp409AavWMaqnunvICOSHkJ5pp7Sr3L
 WR/mTTCzLb5ecPV4iO4idAUk4LAo2iyMLIhoBbaMQI+ZV6W4mzOhnpvoOzN3AZczpSEP
 O7YXLLT/bQMdQzLxseksRFpOy7H+YvYb0dDTh/Qch/jpMLzZZqxAefwCcwKZh2L9VSwq
 jhPYYQIODcQ2zYecEF/nH0SLiQ7KDSA51/AqR1KwYNP3D8S38aHqd2sSRiSLaCaRb8zo
 q014ILG3SgNRSLmthOTOeNHoSCGmRJqapieRqa7WzWHW+jkm8OuN+IFj3ikCZ0o2r0+4
 kwtg==
X-Gm-Message-State: AOJu0Yxz0dpSj+RPGrAOEzI5fRxuJwc5FqOvMZQKRHs4JZimksLPscig
 xhxsucHStpvF/vC5cg/3aWSwhLHrQIqpXAsWNCMUWHJvKQGln/VfcvNrzU+Cf7+w8Od7QyxMx4E
 Oh8fj
X-Gm-Gg: ASbGnctp20xME1QqNOOjpohSLp7MzjVUC0LWWE3ZKiyIJ9H0SL1neWXUXpPNr4RNRrU
 y7ty39/mJCao6dMFTMKynrLn/f1wucCtSNG39aDWuPZ6Mqvj6bwIVdU+cXRfvVt62f8EB076F/m
 1psAyUV/KCjsmGwFk6uqLIVcXetLx3CCma4RJdxcpAN7Ii4aUufyDJWaXSNNv3i/QtH8rFZ3eAQ
 xneGLlzp+Iz7qoHC2e5BwZ9sqElAw2SKguyEbDcCGsScLKs4lUQGHVXOetKADZKkHiYgyvVma80
 P3vIk7bnwD8GcY643KYlwPgQ2PUtjRQWeFHH73MpURVx3ehT+n9MrvNcZZzXb4p3xv0a0lA29si
 qYEmRNZQnAmD6UFopvY5j88nPARogukMj/alUCo74DgFkEHS5TxjhbDzU3QFIYsruk1g2J3+2ZJ
 bcxpwwdfAj1e9gYl7ybwlhs3uLldYpmQ==
X-Google-Smtp-Source: AGHT+IEL4KmvUDyafb+arIzsV/CCIA1RBW5W5drn9AZScFW2z1iqXv7l6gNhThylW2wTWbBhEIEB+A==
X-Received: by 2002:a05:6000:230c:b0:428:52c7:feae with SMTP id
 ffacd0b85a97d-42cc1d0cd4emr2758931f8f.32.1763739512914; 
 Fri, 21 Nov 2025 07:38:32 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2035:a57d:e702:e09e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm11487964f8f.43.2025.11.21.07.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:38:32 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 4/5] usb: udc: re-import udc-core.c from kernel v6.16-rc7
Date: Fri, 21 Nov 2025 16:37:53 +0100
Message-ID: <20251121153812.2076440-5-jerome.forissier@linaro.org>
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

Delete drivers/usb/gadget/udc/udc-core.c which was imported from kernel
v3.19-rc1 and replace it with drivers/usb/gadget/udc/core.c from kernel
v6.16-rc7. Keep the name udc-core.c for now.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 drivers/usb/gadget/udc/udc-core.c | 1867 ++++++++++++++++++++++++++---
 1 file changed, 1704 insertions(+), 163 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 6bb419ae2abc..d709e24c1fd4 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -1,35 +1,51 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
- * udc-core.c - Core UDC Framework
- *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+/*
+ * udc.c - Core UDC Framework
  *
+ * Copyright (C) 2010 Texas Instruments
  * Author: Felipe Balbi <balbi@ti.com>
- *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/gadget/udc-core.c) and ported
- * to uboot.
- *
- * commit 02e8c96627 : usb: gadget: udc: core: prepend udc_attach_driver with
- *		       usb_
  */
 
-#include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/compat.h>
-#include <malloc.h>
-#include <asm/cache.h>
+#define pr_fmt(fmt)	"UDC core: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/idr.h>
+#include <linux/err.h>
 #include <linux/dma-mapping.h>
-#include <dm.h>
-#include <dm/device-internal.h>
+#include <linux/sched/task_stack.h>
+#include <linux/workqueue.h>
+
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb.h>
+
+#include "trace.h"
+
+static DEFINE_IDA(gadget_id_numbers);
+
+static const struct bus_type gadget_bus_type;
 
 /**
  * struct usb_udc - describes one usb device controller
- * @driver - the gadget driver pointer. For use by the class code
- * @dev - the child device to the actual controller
- * @gadget - the gadget. For use by the class code
- * @list - for use by the udc class driver
+ * @driver: the gadget driver pointer. For use by the class code
+ * @dev: the child device to the actual controller
+ * @gadget: the gadget. For use by the class code
+ * @list: for use by the udc class driver
+ * @vbus: for udcs who care about vbus status, this value is real vbus status;
+ * for udcs who do not care about vbus status, this value is always true
+ * @started: the UDC's started state. True if the UDC had started.
+ * @allow_connect: Indicates whether UDC is allowed to be pulled up.
+ * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
+ * unbound.
+ * @vbus_work: work routine to handle VBUS status change notifications.
+ * @connect_lock: protects udc->started, gadget->connect,
+ * gadget->allow_connect and gadget->deactivate. The routines
+ * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
+ * usb_udc_connect_control_locked(), usb_gadget_udc_start_locked() and
+ * usb_gadget_udc_stop_locked() are called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -39,43 +55,935 @@ struct usb_udc {
 	struct usb_gadget		*gadget;
 	struct device			dev;
 	struct list_head		list;
+	bool				vbus;
+	bool				started;
+	bool				allow_connect;
+	struct work_struct		vbus_work;
+	struct mutex			connect_lock;
 };
 
-static struct class *udc_class;
+static const struct class udc_class;
 static LIST_HEAD(udc_list);
-DEFINE_MUTEX(udc_lock);
+
+/* Protects udc_list, udc->driver, driver->is_bound, and related calls */
+static DEFINE_MUTEX(udc_lock);
+
+/* ------------------------------------------------------------------------- */
+
+/**
+ * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
+ * @ep:the endpoint being configured
+ * @maxpacket_limit:value of maximum packet size limit
+ *
+ * This function should be used only in UDC drivers to initialize endpoint
+ * (usually in probe function).
+ */
+void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
+					      unsigned maxpacket_limit)
+{
+	ep->maxpacket_limit = maxpacket_limit;
+	ep->maxpacket = maxpacket_limit;
+
+	trace_usb_ep_set_maxpacket_limit(ep, 0);
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
+
+/**
+ * usb_ep_enable - configure endpoint, making it usable
+ * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
+ *	drivers discover endpoints through the ep_list of a usb_gadget.
+ *
+ * When configurations are set, or when interface settings change, the driver
+ * will enable or disable the relevant endpoints.  while it is enabled, an
+ * endpoint may be used for i/o until the driver receives a disconnect() from
+ * the host or until the endpoint is disabled.
+ *
+ * the ep0 implementation (which calls this routine) must ensure that the
+ * hardware capabilities of each endpoint match the descriptor provided
+ * for it.  for example, an endpoint named "ep2in-bulk" would be usable
+ * for interrupt transfers as well as bulk, but it likely couldn't be used
+ * for iso transfers or for endpoint 14.  some endpoints are fully
+ * configurable, with more generic names like "ep-a".  (remember that for
+ * USB, "in" means "towards the USB host".)
+ *
+ * This routine may be called in an atomic (interrupt) context.
+ *
+ * returns zero, or a negative error code.
+ */
+int usb_ep_enable(struct usb_ep *ep)
+{
+	int ret = 0;
+
+	if (ep->enabled)
+		goto out;
+
+	/* UDC drivers can't handle endpoints with maxpacket size 0 */
+	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
+			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
+
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ep->ops->enable(ep, ep->desc);
+	if (ret)
+		goto out;
+
+	ep->enabled = true;
+
+out:
+	trace_usb_ep_enable(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_enable);
+
+/**
+ * usb_ep_disable - endpoint is no longer usable
+ * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep0".
+ *
+ * no other task may be using this endpoint when this is called.
+ * any pending and uncompleted requests will complete with status
+ * indicating disconnect (-ESHUTDOWN) before this call returns.
+ * gadget drivers must call usb_ep_enable() again before queueing
+ * requests to the endpoint.
+ *
+ * This routine may be called in an atomic (interrupt) context.
+ *
+ * returns zero, or a negative error code.
+ */
+int usb_ep_disable(struct usb_ep *ep)
+{
+	int ret = 0;
+
+	if (!ep->enabled)
+		goto out;
+
+	ret = ep->ops->disable(ep);
+	if (ret)
+		goto out;
+
+	ep->enabled = false;
+
+out:
+	trace_usb_ep_disable(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_disable);
+
+/**
+ * usb_ep_alloc_request - allocate a request object to use with this endpoint
+ * @ep:the endpoint to be used with with the request
+ * @gfp_flags:GFP_* flags to use
+ *
+ * Request objects must be allocated with this call, since they normally
+ * need controller-specific setup and may even need endpoint-specific
+ * resources such as allocation of DMA descriptors.
+ * Requests may be submitted with usb_ep_queue(), and receive a single
+ * completion callback.  Free requests with usb_ep_free_request(), when
+ * they are no longer needed.
+ *
+ * Returns the request, or null if one could not be allocated.
+ */
+struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
+						       gfp_t gfp_flags)
+{
+	struct usb_request *req = NULL;
+
+	req = ep->ops->alloc_request(ep, gfp_flags);
+
+	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
+
+	return req;
+}
+EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
+
+/**
+ * usb_ep_free_request - frees a request object
+ * @ep:the endpoint associated with the request
+ * @req:the request being freed
+ *
+ * Reverses the effect of usb_ep_alloc_request().
+ * Caller guarantees the request is not queued, and that it will
+ * no longer be requeued (or otherwise used).
+ */
+void usb_ep_free_request(struct usb_ep *ep,
+				       struct usb_request *req)
+{
+	trace_usb_ep_free_request(ep, req, 0);
+	ep->ops->free_request(ep, req);
+}
+EXPORT_SYMBOL_GPL(usb_ep_free_request);
+
+/**
+ * usb_ep_queue - queues (submits) an I/O request to an endpoint.
+ * @ep:the endpoint associated with the request
+ * @req:the request being submitted
+ * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
+ *	pre-allocate all necessary memory with the request.
+ *
+ * This tells the device controller to perform the specified request through
+ * that endpoint (reading or writing a buffer).  When the request completes,
+ * including being canceled by usb_ep_dequeue(), the request's completion
+ * routine is called to return the request to the driver.  Any endpoint
+ * (except control endpoints like ep0) may have more than one transfer
+ * request queued; they complete in FIFO order.  Once a gadget driver
+ * submits a request, that request may not be examined or modified until it
+ * is given back to that driver through the completion callback.
+ *
+ * Each request is turned into one or more packets.  The controller driver
+ * never merges adjacent requests into the same packet.  OUT transfers
+ * will sometimes use data that's already buffered in the hardware.
+ * Drivers can rely on the fact that the first byte of the request's buffer
+ * always corresponds to the first byte of some USB packet, for both
+ * IN and OUT transfers.
+ *
+ * Bulk endpoints can queue any amount of data; the transfer is packetized
+ * automatically.  The last packet will be short if the request doesn't fill it
+ * out completely.  Zero length packets (ZLPs) should be avoided in portable
+ * protocols since not all usb hardware can successfully handle zero length
+ * packets.  (ZLPs may be explicitly written, and may be implicitly written if
+ * the request 'zero' flag is set.)  Bulk endpoints may also be used
+ * for interrupt transfers; but the reverse is not true, and some endpoints
+ * won't support every interrupt transfer.  (Such as 768 byte packets.)
+ *
+ * Interrupt-only endpoints are less functional than bulk endpoints, for
+ * example by not supporting queueing or not handling buffers that are
+ * larger than the endpoint's maxpacket size.  They may also treat data
+ * toggle differently.
+ *
+ * Control endpoints ... after getting a setup() callback, the driver queues
+ * one response (even if it would be zero length).  That enables the
+ * status ack, after transferring data as specified in the response.  Setup
+ * functions may return negative error codes to generate protocol stalls.
+ * (Note that some USB device controllers disallow protocol stall responses
+ * in some cases.)  When control responses are deferred (the response is
+ * written after the setup callback returns), then usb_ep_set_halt() may be
+ * used on ep0 to trigger protocol stalls.  Depending on the controller,
+ * it may not be possible to trigger a status-stage protocol stall when the
+ * data stage is over, that is, from within the response's completion
+ * routine.
+ *
+ * For periodic endpoints, like interrupt or isochronous ones, the usb host
+ * arranges to poll once per interval, and the gadget driver usually will
+ * have queued some data to transfer at that time.
+ *
+ * Note that @req's ->complete() callback must never be called from
+ * within usb_ep_queue() as that can create deadlock situations.
+ *
+ * This routine may be called in interrupt context.
+ *
+ * Returns zero, or a negative error code.  Endpoints that are not enabled
+ * report errors; errors will also be
+ * reported when the usb peripheral is disconnected.
+ *
+ * If and only if @req is successfully queued (the return value is zero),
+ * @req->complete() will be called exactly once, when the Gadget core and
+ * UDC are finished with the request.  When the completion function is called,
+ * control of the request is returned to the device driver which submitted it.
+ * The completion handler may then immediately free or reuse @req.
+ */
+int usb_ep_queue(struct usb_ep *ep,
+			       struct usb_request *req, gfp_t gfp_flags)
+{
+	int ret = 0;
+
+	if (!ep->enabled && ep->address) {
+		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
+				 ep->address, ep->name);
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	ret = ep->ops->queue(ep, req, gfp_flags);
+
+out:
+	trace_usb_ep_queue(ep, req, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_queue);
+
+/**
+ * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an endpoint
+ * @ep:the endpoint associated with the request
+ * @req:the request being canceled
+ *
+ * If the request is still active on the endpoint, it is dequeued and
+ * eventually its completion routine is called (with status -ECONNRESET);
+ * else a negative error code is returned.  This routine is asynchronous,
+ * that is, it may return before the completion routine runs.
+ *
+ * Note that some hardware can't clear out write fifos (to unlink the request
+ * at the head of the queue) except as part of disconnecting from usb. Such
+ * restrictions prevent drivers from supporting configuration changes,
+ * even to configuration zero (a "chapter 9" requirement).
+ *
+ * This routine may be called in interrupt context.
+ */
+int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
+{
+	int ret;
+
+	ret = ep->ops->dequeue(ep, req);
+	trace_usb_ep_dequeue(ep, req, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_dequeue);
+
+/**
+ * usb_ep_set_halt - sets the endpoint halt feature.
+ * @ep: the non-isochronous endpoint being stalled
+ *
+ * Use this to stall an endpoint, perhaps as an error report.
+ * Except for control endpoints,
+ * the endpoint stays halted (will not stream any data) until the host
+ * clears this feature; drivers may need to empty the endpoint's request
+ * queue first, to make sure no inappropriate transfers happen.
+ *
+ * Note that while an endpoint CLEAR_FEATURE will be invisible to the
+ * gadget driver, a SET_INTERFACE will not be.  To reset endpoints for the
+ * current altsetting, see usb_ep_clear_halt().  When switching altsettings,
+ * it's simplest to use usb_ep_enable() or usb_ep_disable() for the endpoints.
+ *
+ * This routine may be called in interrupt context.
+ *
+ * Returns zero, or a negative error code.  On success, this call sets
+ * underlying hardware state that blocks data transfers.
+ * Attempts to halt IN endpoints will fail (returning -EAGAIN) if any
+ * transfer requests are still queued, or if the controller hardware
+ * (usually a FIFO) still holds bytes that the host hasn't collected.
+ */
+int usb_ep_set_halt(struct usb_ep *ep)
+{
+	int ret;
+
+	ret = ep->ops->set_halt(ep, 1);
+	trace_usb_ep_set_halt(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_halt);
+
+/**
+ * usb_ep_clear_halt - clears endpoint halt, and resets toggle
+ * @ep:the bulk or interrupt endpoint being reset
+ *
+ * Use this when responding to the standard usb "set interface" request,
+ * for endpoints that aren't reconfigured, after clearing any other state
+ * in the endpoint's i/o queue.
+ *
+ * This routine may be called in interrupt context.
+ *
+ * Returns zero, or a negative error code.  On success, this call clears
+ * the underlying hardware state reflecting endpoint halt and data toggle.
+ * Note that some hardware can't support this request (like pxa2xx_udc),
+ * and accordingly can't correctly implement interface altsettings.
+ */
+int usb_ep_clear_halt(struct usb_ep *ep)
+{
+	int ret;
+
+	ret = ep->ops->set_halt(ep, 0);
+	trace_usb_ep_clear_halt(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_clear_halt);
+
+/**
+ * usb_ep_set_wedge - sets the halt feature and ignores clear requests
+ * @ep: the endpoint being wedged
+ *
+ * Use this to stall an endpoint and ignore CLEAR_FEATURE(HALT_ENDPOINT)
+ * requests. If the gadget driver clears the halt status, it will
+ * automatically unwedge the endpoint.
+ *
+ * This routine may be called in interrupt context.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_ep_set_wedge(struct usb_ep *ep)
+{
+	int ret;
+
+	if (ep->ops->set_wedge)
+		ret = ep->ops->set_wedge(ep);
+	else
+		ret = ep->ops->set_halt(ep, 1);
+
+	trace_usb_ep_set_wedge(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
+
+/**
+ * usb_ep_fifo_status - returns number of bytes in fifo, or error
+ * @ep: the endpoint whose fifo status is being checked.
+ *
+ * FIFO endpoints may have "unclaimed data" in them in certain cases,
+ * such as after aborted transfers.  Hosts may not have collected all
+ * the IN data written by the gadget driver (and reported by a request
+ * completion).  The gadget driver may not have collected all the data
+ * written OUT to it by the host.  Drivers that need precise handling for
+ * fault reporting or recovery may need to use this call.
+ *
+ * This routine may be called in interrupt context.
+ *
+ * This returns the number of such bytes in the fifo, or a negative
+ * errno if the endpoint doesn't use a FIFO or doesn't support such
+ * precise handling.
+ */
+int usb_ep_fifo_status(struct usb_ep *ep)
+{
+	int ret;
+
+	if (ep->ops->fifo_status)
+		ret = ep->ops->fifo_status(ep);
+	else
+		ret = -EOPNOTSUPP;
+
+	trace_usb_ep_fifo_status(ep, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
+
+/**
+ * usb_ep_fifo_flush - flushes contents of a fifo
+ * @ep: the endpoint whose fifo is being flushed.
+ *
+ * This call may be used to flush the "unclaimed data" that may exist in
+ * an endpoint fifo after abnormal transaction terminations.  The call
+ * must never be used except when endpoint is not being used for any
+ * protocol translation.
+ *
+ * This routine may be called in interrupt context.
+ */
+void usb_ep_fifo_flush(struct usb_ep *ep)
+{
+	if (ep->ops->fifo_flush)
+		ep->ops->fifo_flush(ep);
+
+	trace_usb_ep_fifo_flush(ep, 0);
+}
+EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
 /* ------------------------------------------------------------------------- */
 
+/**
+ * usb_gadget_frame_number - returns the current frame number
+ * @gadget: controller that reports the frame number
+ *
+ * Returns the usb frame number, normally eleven bits from a SOF packet,
+ * or negative errno if this device doesn't support this capability.
+ */
+int usb_gadget_frame_number(struct usb_gadget *gadget)
+{
+	int ret;
+
+	ret = gadget->ops->get_frame(gadget);
+
+	trace_usb_gadget_frame_number(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
+
+/**
+ * usb_gadget_wakeup - tries to wake up the host connected to this gadget
+ * @gadget: controller used to wake up the host
+ *
+ * Returns zero on success, else negative error code if the hardware
+ * doesn't support such attempts, or its support has not been enabled
+ * by the usb host.  Drivers must return device descriptors that report
+ * their ability to support this, or hosts won't enable it.
+ *
+ * This may also try to use SRP to wake the host and start enumeration,
+ * even if OTG isn't otherwise in use.  OTG devices may also start
+ * remote wakeup even when hosts don't explicitly enable it.
+ */
+int usb_gadget_wakeup(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	if (!gadget->ops->wakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->wakeup(gadget);
+
+out:
+	trace_usb_gadget_wakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
+
+/**
+ * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
+ * @gadget:the device being configured for remote wakeup
+ * @set:value to be configured.
+ *
+ * set to one to enable remote wakeup feature and zero to disable it.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_remote_wakeup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_remote_wakeup(gadget, set);
+
+out:
+	trace_usb_gadget_set_remote_wakeup(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
+
+/**
+ * usb_gadget_set_selfpowered - sets the device selfpowered feature.
+ * @gadget:the device being declared as self-powered
+ *
+ * this affects the device status reported by the hardware driver
+ * to reflect that it now has a local power supply.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_selfpowered) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_selfpowered(gadget, 1);
+
+out:
+	trace_usb_gadget_set_selfpowered(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
+
+/**
+ * usb_gadget_clear_selfpowered - clear the device selfpowered feature.
+ * @gadget:the device being declared as bus-powered
+ *
+ * this affects the device status reported by the hardware driver.
+ * some hardware may not support bus-powered operation, in which
+ * case this feature's value can never change.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	if (!gadget->ops->set_selfpowered) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->set_selfpowered(gadget, 0);
+
+out:
+	trace_usb_gadget_clear_selfpowered(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
+
+/**
+ * usb_gadget_vbus_connect - Notify controller that VBUS is powered
+ * @gadget:The device which now has VBUS power.
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session starting.  Common responses include
+ * resuming the controller, activating the D+ (or D-) pullup to let the
+ * host detect that a USB device is attached, and starting to draw power
+ * (8mA or possibly more, especially after SET_CONFIGURATION).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_connect(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	if (!gadget->ops->vbus_session) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->vbus_session(gadget, 1);
+
+out:
+	trace_usb_gadget_vbus_connect(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
+
+/**
+ * usb_gadget_vbus_draw - constrain controller's VBUS power usage
+ * @gadget:The device whose VBUS usage is being described
+ * @mA:How much current to draw, in milliAmperes.  This should be twice
+ *	the value listed in the configuration descriptor bMaxPower field.
+ *
+ * This call is used by gadget drivers during SET_CONFIGURATION calls,
+ * reporting how much power the device may consume.  For example, this
+ * could affect how quickly batteries are recharged.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
+{
+	int ret = 0;
+
+	if (!gadget->ops->vbus_draw) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->vbus_draw(gadget, mA);
+	if (!ret)
+		gadget->mA = mA;
+
+out:
+	trace_usb_gadget_vbus_draw(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
+
+/**
+ * usb_gadget_vbus_disconnect - notify controller about VBUS session end
+ * @gadget:the device whose VBUS supply is being described
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session ending.  Common responses include
+ * reversing everything done in usb_gadget_vbus_connect().
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	if (!gadget->ops->vbus_session) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = gadget->ops->vbus_session(gadget, 0);
+
+out:
+	trace_usb_gadget_vbus_disconnect(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
+
+static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
+{
+	int ret = 0;
+
+	if (!gadget->ops->pullup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
+		/*
+		 * If the gadget isn't usable (because it is deactivated,
+		 * unbound, or not yet started), we only save the new state.
+		 * The gadget will be connected automatically when it is
+		 * activated/bound/started.
+		 */
+		gadget->connected = true;
+		goto out;
+	}
+
+	ret = gadget->ops->pullup(gadget, 1);
+	if (!ret)
+		gadget->connected = 1;
+
+out:
+	trace_usb_gadget_connect(gadget, ret);
+
+	return ret;
+}
+
+/**
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
+ *
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_connect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
+
+static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
+{
+	int ret = 0;
+
+	if (!gadget->ops->pullup) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!gadget->connected)
+		goto out;
+
+	if (gadget->deactivated || !gadget->udc->started) {
+		/*
+		 * If gadget is deactivated we only save new state.
+		 * Gadget will stay disconnected after activation.
+		 */
+		gadget->connected = false;
+		goto out;
+	}
+
+	ret = gadget->ops->pullup(gadget, 0);
+	if (!ret)
+		gadget->connected = 0;
+
+	mutex_lock(&udc_lock);
+	if (gadget->udc->driver)
+		gadget->udc->driver->disconnect(gadget);
+	mutex_unlock(&udc_lock);
+
+out:
+	trace_usb_gadget_disconnect(gadget, ret);
+
+	return ret;
+}
+
+/**
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
+ *
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_disconnect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
+
+/**
+ * usb_gadget_deactivate - deactivate function which is not ready to work
+ * @gadget: the peripheral being deactivated
+ *
+ * This routine may be used during the gadget driver bind() call to prevent
+ * the peripheral from ever being visible to the USB host, unless later
+ * usb_gadget_activate() is called.  For example, user mode components may
+ * need to be activated before the system can talk to hosts.
+ *
+ * This routine may sleep; it must not be called in interrupt context
+ * (such as from within a gadget driver's disconnect() callback).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_deactivate(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	if (gadget->deactivated)
+		goto unlock;
+
+	if (gadget->connected) {
+		ret = usb_gadget_disconnect_locked(gadget);
+		if (ret)
+			goto unlock;
+
+		/*
+		 * If gadget was being connected before deactivation, we want
+		 * to reconnect it in usb_gadget_activate().
+		 */
+		gadget->connected = true;
+	}
+	gadget->deactivated = true;
+
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
+	trace_usb_gadget_deactivate(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
+
+/**
+ * usb_gadget_activate - activate function which is not ready to work
+ * @gadget: the peripheral being activated
+ *
+ * This routine activates gadget which was previously deactivated with
+ * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
+ *
+ * This routine may sleep; it must not be called in interrupt context.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_activate(struct usb_gadget *gadget)
+{
+	int ret = 0;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	if (!gadget->deactivated)
+		goto unlock;
+
+	gadget->deactivated = false;
+
+	/*
+	 * If gadget has been connected before deactivation, or became connected
+	 * while it was being deactivated, we call usb_gadget_connect().
+	 */
+	if (gadget->connected)
+		ret = usb_gadget_connect_locked(gadget);
+
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
+	trace_usb_gadget_activate(gadget, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_activate);
+
+/* ------------------------------------------------------------------------- */
+
+#ifdef	CONFIG_HAS_DMA
+
+int usb_gadget_map_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in)
+{
+	if (req->length == 0)
+		return 0;
+
+	if (req->sg_was_mapped) {
+		req->num_mapped_sgs = req->num_sgs;
+		return 0;
+	}
+
+	if (req->num_sgs) {
+		int     mapped;
+
+		mapped = dma_map_sg(dev, req->sg, req->num_sgs,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		if (mapped == 0) {
+			dev_err(dev, "failed to map SGs\n");
+			return -EFAULT;
+		}
+
+		req->num_mapped_sgs = mapped;
+	} else {
+		if (is_vmalloc_addr(req->buf)) {
+			dev_err(dev, "buffer is not dma capable\n");
+			return -EFAULT;
+		} else if (object_is_on_stack(req->buf)) {
+			dev_err(dev, "buffer is on stack\n");
+			return -EFAULT;
+		}
+
+		req->dma = dma_map_single(dev, req->buf, req->length,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+		if (dma_mapping_error(dev, req->dma)) {
+			dev_err(dev, "failed to map buffer\n");
+			return -EFAULT;
+		}
+
+		req->dma_mapped = 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_map_request_by_dev);
+
 int usb_gadget_map_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
-		return 0;
-
-	req->dma = dma_map_single(req->buf, req->length,
-				  is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-	return 0;
+	return usb_gadget_map_request_by_dev(gadget->dev.parent, req, is_in);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 
+void usb_gadget_unmap_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in)
+{
+	if (req->length == 0 || req->sg_was_mapped)
+		return;
+
+	if (req->num_mapped_sgs) {
+		dma_unmap_sg(dev, req->sg, req->num_sgs,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+		req->num_mapped_sgs = 0;
+	} else if (req->dma_mapped) {
+		dma_unmap_single(dev, req->dma, req->length,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		req->dma_mapped = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(usb_gadget_unmap_request_by_dev);
+
 void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
-		return;
-
-	dma_unmap_single(req->dma, req->length,
-			 is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	usb_gadget_unmap_request_by_dev(gadget->dev.parent, req, is_in);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
+#endif	/* CONFIG_HAS_DMA */
+
 /* ------------------------------------------------------------------------- */
 
 /**
  * usb_gadget_giveback_request - give the request back to the gadget layer
- * Context: in_interrupt()
+ * @ep: the endpoint to be used with with the request
+ * @req: the request being given back
  *
  * This is called by device controller drivers in order to return the
  * completed request back to the gadget layer.
@@ -83,21 +991,191 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
 {
+	if (likely(req->status == 0))
+		usb_led_activity(USB_LED_EVENT_GADGET);
+
+	trace_usb_gadget_giveback_request(ep, req, 0);
+
 	req->complete(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
 /* ------------------------------------------------------------------------- */
 
+/**
+ * gadget_find_ep_by_name - returns ep whose name is the same as sting passed
+ *	in second parameter or NULL if searched endpoint not found
+ * @g: controller to check for quirk
+ * @name: name of searched endpoint
+ */
+struct usb_ep *gadget_find_ep_by_name(struct usb_gadget *g, const char *name)
+{
+	struct usb_ep *ep;
+
+	gadget_for_each_ep(ep, g) {
+		if (!strcmp(ep->name, name))
+			return ep;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gadget_find_ep_by_name);
+
+/* ------------------------------------------------------------------------- */
+
+int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	u8		type;
+	u16		max;
+	int		num_req_streams = 0;
+
+	/* endpoint already claimed? */
+	if (ep->claimed)
+		return 0;
+
+	type = usb_endpoint_type(desc);
+	max = usb_endpoint_maxp(desc);
+
+	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
+		return 0;
+	if (usb_endpoint_dir_out(desc) && !ep->caps.dir_out)
+		return 0;
+
+	if (max > ep->maxpacket_limit)
+		return 0;
+
+	/* "high bandwidth" works only at high speed */
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp_mult(desc) > 1)
+		return 0;
+
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* only support ep0 for portable CONTROL traffic */
+		return 0;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return 0;
+		/* ISO:  limit 1023 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 1023)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return 0;
+		if (ep_comp && gadget_is_superspeed(gadget)) {
+			/* Get the number of required streams from the
+			 * EP companion descriptor and see if the EP
+			 * matches it
+			 */
+			num_req_streams = ep_comp->bmAttributes & 0x1f;
+			if (num_req_streams > ep->max_streams)
+				return 0;
+		}
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		/* Bulk endpoints handle interrupt transfers,
+		 * except the toggle-quirky iso-synch kind
+		 */
+		if (!ep->caps.type_int && !ep->caps.type_bulk)
+			return 0;
+		/* INT:  limit 64 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 64)
+			return 0;
+		break;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
+
+/**
+ * usb_gadget_check_config - checks if the UDC can support the binded
+ *	configuration
+ * @gadget: controller to check the USB configuration
+ *
+ * Ensure that a UDC is able to support the requested resources by a
+ * configuration, and that there are no resource limitations, such as
+ * internal memory allocated to all requested endpoints.
+ *
+ * Returns zero on success, else a negative errno.
+ */
+int usb_gadget_check_config(struct usb_gadget *gadget)
+{
+	if (gadget->ops->check_config)
+		return gadget->ops->check_config(gadget);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_check_config);
+
+/* ------------------------------------------------------------------------- */
+
+static void usb_gadget_state_work(struct work_struct *work)
+{
+	struct usb_gadget *gadget = work_to_gadget(work);
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc)
+		sysfs_notify(&udc->dev.kobj, NULL, "state");
+}
+
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
 	gadget->state = state;
+	schedule_work(&gadget->work);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
+/* Acquire connect_lock before calling this function. */
+static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+{
+	if (udc->vbus)
+		return usb_gadget_connect_locked(udc->gadget);
+	else
+		return usb_gadget_disconnect_locked(udc->gadget);
+}
+
+static void vbus_event_work(struct work_struct *work)
+{
+	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
+
+	mutex_lock(&udc->connect_lock);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
+}
+
+/**
+ * usb_udc_vbus_handler - updates the udc core vbus status, and try to
+ * connect or disconnect gadget
+ * @gadget: The gadget which vbus change occurs
+ * @status: The vbus status
+ *
+ * The udc driver calls it when it wants to connect or disconnect gadget
+ * according to vbus status.
+ *
+ * This function can be invoked from interrupt context by irq handlers of
+ * the gadget drivers, however, usb_udc_connect_control() has to run in
+ * non-atomic context due to the following:
+ * a. Some of the gadget driver implementations expect the ->pullup
+ * callback to be invoked in non-atomic context.
+ * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
+ * Hence offload invocation of usb_udc_connect_control() to workqueue.
+ */
+void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
+{
+	struct usb_udc *udc = gadget->udc;
+
+	if (udc) {
+		udc->vbus = status;
+		schedule_work(&udc->vbus_work);
+	}
+}
+EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
+
 /**
  * usb_gadget_udc_reset - notifies the udc core that bus reset occurs
  * @gadget: The gadget which bus reset occurs
@@ -116,7 +1194,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start - tells usb device controller to start up
+ * usb_gadget_udc_start_locked - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -127,16 +1205,29 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
+ *
+ * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start(struct usb_udc *udc)
+static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
-	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
+	int ret;
+
+	if (udc->started) {
+		dev_err(&udc->dev, "UDC had already started\n");
+		return -EBUSY;
+	}
+
+	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
+	if (!ret)
+		udc->started = true;
+
+	return ret;
 }
 
 /**
- * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
- * @gadget: The device we want to stop activity
- * @driver: The driver to unbind from @gadget
+ * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
+ * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
  * gadget driver's unbind() method.
@@ -144,10 +1235,93 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
+ *
+ * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop(struct usb_udc *udc)
+static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
+	if (!udc->started) {
+		dev_err(&udc->dev, "UDC had already stopped\n");
+		return;
+	}
+
 	udc->gadget->ops->udc_stop(udc->gadget);
+	udc->started = false;
+}
+
+/**
+ * usb_gadget_udc_set_speed - tells usb device controller speed supported by
+ *    current driver
+ * @udc: The device we want to set maximum speed
+ * @speed: The maximum speed to allowed to run
+ *
+ * This call is issued by the UDC Class driver before calling
+ * usb_gadget_udc_start() in order to make sure that we don't try to
+ * connect on speeds the gadget driver doesn't support.
+ */
+static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
+					    enum usb_device_speed speed)
+{
+	struct usb_gadget *gadget = udc->gadget;
+	enum usb_device_speed s;
+
+	if (speed == USB_SPEED_UNKNOWN)
+		s = gadget->max_speed;
+	else
+		s = min(speed, gadget->max_speed);
+
+	if (s == USB_SPEED_SUPER_PLUS && gadget->ops->udc_set_ssp_rate)
+		gadget->ops->udc_set_ssp_rate(gadget, gadget->max_ssp_rate);
+	else if (gadget->ops->udc_set_speed)
+		gadget->ops->udc_set_speed(gadget, s);
+}
+
+/**
+ * usb_gadget_enable_async_callbacks - tell usb device controller to enable asynchronous callbacks
+ * @udc: The UDC which should enable async callbacks
+ *
+ * This routine is used when binding gadget drivers.  It undoes the effect
+ * of usb_gadget_disable_async_callbacks(); the UDC driver should enable IRQs
+ * (if necessary) and resume issuing callbacks.
+ *
+ * This routine will always be called in process context.
+ */
+static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc)
+{
+	struct usb_gadget *gadget = udc->gadget;
+
+	if (gadget->ops->udc_async_callbacks)
+		gadget->ops->udc_async_callbacks(gadget, true);
+}
+
+/**
+ * usb_gadget_disable_async_callbacks - tell usb device controller to disable asynchronous callbacks
+ * @udc: The UDC which should disable async callbacks
+ *
+ * This routine is used when unbinding gadget drivers.  It prevents a race:
+ * The UDC driver doesn't know when the gadget driver's ->unbind callback
+ * runs, so unless it is told to disable asynchronous callbacks, it might
+ * issue a callback (such as ->disconnect) after the unbind has completed.
+ *
+ * After this function runs, the UDC driver must suppress all ->suspend,
+ * ->resume, ->disconnect, ->reset, and ->setup callbacks to the gadget driver
+ * until async callbacks are again enabled.  A simple-minded but effective
+ * way to accomplish this is to tell the UDC hardware not to generate any
+ * more IRQs.
+ *
+ * Request completion callbacks must still be issued.  However, it's okay
+ * to defer them until the request is cancelled, since the pull-up will be
+ * turned off during the time period when async callbacks are disabled.
+ *
+ * This routine will always be called in process context.
+ */
+static inline void usb_gadget_disable_async_callbacks(struct usb_udc *udc)
+{
+	struct usb_gadget *gadget = udc->gadget;
+
+	if (gadget->ops->udc_async_callbacks)
+		gadget->ops->udc_async_callbacks(gadget, false);
 }
 
 /**
@@ -162,51 +1336,177 @@ static void usb_udc_release(struct device *dev)
 	struct usb_udc *udc;
 
 	udc = container_of(dev, struct usb_udc, dev);
+	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
 	kfree(udc);
 }
 
+static const struct attribute_group *usb_udc_attr_groups[];
+
+static void usb_udc_nop_release(struct device *dev)
+{
+	dev_vdbg(dev, "%s\n", __func__);
+}
+
 /**
- * usb_add_gadget_udc_release - adds a new gadget to the udc class driver list
+ * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
  * device.
- * @gadget: the gadget to be added to the list.
+ * @gadget: the gadget to be initialized.
  * @release: a gadget release function.
+ */
+void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
+		void (*release)(struct device *dev))
+{
+	INIT_WORK(&gadget->work, usb_gadget_state_work);
+	gadget->dev.parent = parent;
+
+	if (release)
+		gadget->dev.release = release;
+	else
+		gadget->dev.release = usb_udc_nop_release;
+
+	device_initialize(&gadget->dev);
+	gadget->dev.bus = &gadget_bus_type;
+}
+EXPORT_SYMBOL_GPL(usb_initialize_gadget);
+
+/**
+ * usb_add_gadget - adds a new gadget to the udc class driver list
+ * @gadget: the gadget to be added to the list.
  *
  * Returns zero on success, negative errno otherwise.
+ * Does not do a final usb_put_gadget() if an error occurs.
  */
-int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
-		void (*release)(struct device *dev))
+int usb_add_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc		*udc;
 	int			ret = -ENOMEM;
 
 	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
 	if (!udc)
-		goto err1;
-
-	dev_set_name(&gadget->dev, "gadget");
-	gadget->dev.parent = parent;
+		goto error;
 
+	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
-	udc->dev.class = udc_class;
-	udc->dev.parent = parent;
+	udc->dev.class = &udc_class;
+	udc->dev.groups = usb_udc_attr_groups;
+	udc->dev.parent = gadget->dev.parent;
+	ret = dev_set_name(&udc->dev, "%s",
+			kobject_name(&gadget->dev.parent->kobj));
+	if (ret)
+		goto err_put_udc;
 
 	udc->gadget = gadget;
+	gadget->udc = udc;
+	mutex_init(&udc->connect_lock);
+
+	udc->started = false;
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
+	mutex_unlock(&udc_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
+
+	ret = device_add(&udc->dev);
+	if (ret)
+		goto err_unlist_udc;
 
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
+	udc->vbus = true;
 
-	mutex_unlock(&udc_lock);
+	ret = ida_alloc(&gadget_id_numbers, GFP_KERNEL);
+	if (ret < 0)
+		goto err_del_udc;
+	gadget->id_number = ret;
+	dev_set_name(&gadget->dev, "gadget.%d", ret);
+
+	ret = device_add(&gadget->dev);
+	if (ret)
+		goto err_free_id;
+
+	ret = sysfs_create_link(&udc->dev.kobj,
+				&gadget->dev.kobj, "gadget");
+	if (ret)
+		goto err_del_gadget;
 
 	return 0;
 
-err1:
+ err_del_gadget:
+	device_del(&gadget->dev);
+
+ err_free_id:
+	ida_free(&gadget_id_numbers, gadget->id_number);
+
+ err_del_udc:
+	flush_work(&gadget->work);
+	device_del(&udc->dev);
+
+ err_unlist_udc:
+	mutex_lock(&udc_lock);
+	list_del(&udc->list);
+	mutex_unlock(&udc_lock);
+
+ err_put_udc:
+	put_device(&udc->dev);
+
+ error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_add_gadget);
+
+/**
+ * usb_add_gadget_udc_release - adds a new gadget to the udc class driver list
+ * @parent: the parent device to this udc. Usually the controller driver's
+ * device.
+ * @gadget: the gadget to be added to the list.
+ * @release: a gadget release function.
+ *
+ * Returns zero on success, negative errno otherwise.
+ * Calls the gadget release function in the latter case.
+ */
+int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
+		void (*release)(struct device *dev))
+{
+	int	ret;
+
+	usb_initialize_gadget(parent, gadget, release);
+	ret = usb_add_gadget(gadget);
+	if (ret)
+		usb_put_gadget(gadget);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
 
+/**
+ * usb_get_gadget_udc_name - get the name of the first UDC controller
+ * This functions returns the name of the first UDC controller in the system.
+ * Please note that this interface is usefull only for legacy drivers which
+ * assume that there is only one UDC controller in the system and they need to
+ * get its name before initialization. There is no guarantee that the UDC
+ * of the returned name will be still available, when gadget driver registers
+ * itself.
+ *
+ * Returns pointer to string with UDC controller name on success, NULL
+ * otherwise. Caller should kfree() returned string.
+ */
+char *usb_get_gadget_udc_name(void)
+{
+	struct usb_udc *udc;
+	char *name = NULL;
+
+	/* For now we take the first available UDC */
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list) {
+		if (!udc->driver) {
+			name = kstrdup(udc->gadget->name, GFP_KERNEL);
+			break;
+		}
+	}
+	mutex_unlock(&udc_lock);
+	return name;
+}
+EXPORT_SYMBOL_GPL(usb_get_gadget_udc_name);
+
 /**
  * usb_add_gadget_udc - adds a new gadget to the udc class driver list
  * @parent: the parent device to this udc. Usually the controller
@@ -221,169 +1521,410 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
-static void usb_gadget_remove_driver(struct usb_udc *udc)
-{
-	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
-			udc->driver->function);
-
-	usb_gadget_disconnect(udc->gadget);
-	udc->driver->disconnect(udc->gadget);
-	udc->driver->unbind(udc->gadget);
-	usb_gadget_udc_stop(udc);
-
-	udc->driver = NULL;
-}
-
 /**
- * usb_del_gadget_udc - deletes @udc from udc_list
- * @gadget: the gadget to be removed.
+ * usb_del_gadget - deletes a gadget and unregisters its udc
+ * @gadget: the gadget to be deleted.
  *
- * This, will call usb_gadget_unregister_driver() if
- * the @udc is still busy.
+ * This will unbind @gadget, if it is bound.
+ * It will not do a final usb_put_gadget().
  */
-void usb_del_gadget_udc(struct usb_gadget *gadget)
+void usb_del_gadget(struct usb_gadget *gadget)
 {
-	struct usb_udc		*udc = NULL;
+	struct usb_udc *udc = gadget->udc;
 
-	mutex_lock(&udc_lock);
-	list_for_each_entry(udc, &udc_list, list)
-		if (udc->gadget == gadget)
-			goto found;
+	if (!udc)
+		return;
 
-	dev_err(gadget->dev.parent, "gadget not registered.\n");
-	mutex_unlock(&udc_lock);
-
-	return;
-
-found:
 	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
 
+	mutex_lock(&udc_lock);
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
 
-	if (udc->driver)
-		usb_gadget_remove_driver(udc);
+	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
+	sysfs_remove_link(&udc->dev.kobj, "gadget");
+	device_del(&gadget->dev);
+	flush_work(&gadget->work);
+	ida_free(&gadget_id_numbers, gadget->id_number);
+	cancel_work_sync(&udc->vbus_work);
+	device_unregister(&udc->dev);
+}
+EXPORT_SYMBOL_GPL(usb_del_gadget);
+
+/**
+ * usb_del_gadget_udc - unregisters a gadget
+ * @gadget: the gadget to be unregistered.
+ *
+ * Calls usb_del_gadget() and does a final usb_put_gadget().
+ */
+void usb_del_gadget_udc(struct usb_gadget *gadget)
+{
+	usb_del_gadget(gadget);
+	usb_put_gadget(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
-/**
- * usb_gadget_udc_set_speed - tells usb device controller speed supported by
- *    current driver
- * @udc: The device we want to set maximum speed
- * @speed: The maximum speed to allowed to run
- *
- * This call is issued by the UDC Class driver before calling
- * usb_gadget_udc_start() in order to make sure that we don't try to
- * connect on speeds the gadget driver doesn't support.
- */
-static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
-					    enum usb_device_speed speed)
+static int gadget_match_driver(struct device *dev, const struct device_driver *drv)
 {
-	if (udc->gadget->ops->udc_set_speed) {
-		enum usb_device_speed s;
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	const struct usb_gadget_driver *driver = container_of(drv,
+			struct usb_gadget_driver, driver);
 
-		s = min(speed, udc->gadget->max_speed);
-		udc->gadget->ops->udc_set_speed(udc->gadget, s);
-	}
+	/* If the driver specifies a udc_name, it must match the UDC's name */
+	if (driver->udc_name &&
+			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
+		return 0;
+
+	/* If the driver is already bound to a gadget, it doesn't match */
+	if (driver->is_bound)
+		return 0;
+
+	/* Otherwise any gadget driver matches any UDC */
+	return 1;
 }
 
-static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
+static int gadget_bind_driver(struct device *dev)
 {
-	int ret;
-
-	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
-			driver->function);
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	struct usb_gadget_driver *driver = container_of(dev->driver,
+			struct usb_gadget_driver, driver);
+	int ret = 0;
 
+	mutex_lock(&udc_lock);
+	if (driver->is_bound) {
+		mutex_unlock(&udc_lock);
+		return -ENXIO;		/* Driver binds to only one gadget */
+	}
+	driver->is_bound = true;
 	udc->driver = driver;
+	mutex_unlock(&udc_lock);
 
-	usb_gadget_udc_set_speed(udc, driver->speed);
+	dev_dbg(&udc->dev, "binding gadget driver [%s]\n", driver->function);
 
-	ret = driver->bind(udc->gadget);
+	usb_gadget_udc_set_speed(udc, driver->max_speed);
+
+	ret = driver->bind(udc->gadget, driver);
 	if (ret)
-		goto err1;
-	ret = usb_gadget_udc_start(udc);
+		goto err_bind;
+
+	mutex_lock(&udc->connect_lock);
+	ret = usb_gadget_udc_start_locked(udc);
 	if (ret) {
-		driver->unbind(udc->gadget);
-		goto err1;
+		mutex_unlock(&udc->connect_lock);
+		goto err_start;
 	}
-	usb_gadget_connect(udc->gadget);
+	usb_gadget_enable_async_callbacks(udc);
+	udc->allow_connect = true;
+	ret = usb_udc_connect_control_locked(udc);
+	if (ret)
+		goto err_connect_control;
 
+	mutex_unlock(&udc->connect_lock);
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
-err1:
+
+ err_connect_control:
+	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
+
+ err_start:
+	driver->unbind(udc->gadget);
+
+ err_bind:
 	if (ret != -EISNAM)
 		dev_err(&udc->dev, "failed to start %s: %d\n",
-			udc->driver->function, ret);
+			driver->function, ret);
+
+	mutex_lock(&udc_lock);
 	udc->driver = NULL;
+	driver->is_bound = false;
+	mutex_unlock(&udc_lock);
+
 	return ret;
 }
 
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+static void gadget_unbind_driver(struct device *dev)
 {
-	struct usb_udc		*udc = NULL;
-	unsigned int		udc_count = 0;
-	int			ret;
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	struct usb_gadget_driver *driver = udc->driver;
+
+	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
+
+	udc->allow_connect = false;
+	cancel_work_sync(&udc->vbus_work);
+	mutex_lock(&udc->connect_lock);
+	usb_gadget_disconnect_locked(gadget);
+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);
+	mutex_unlock(&udc->connect_lock);
+
+	udc->driver->unbind(gadget);
+
+	mutex_lock(&udc->connect_lock);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
+
+	mutex_lock(&udc_lock);
+	driver->is_bound = false;
+	udc->driver = NULL;
+	mutex_unlock(&udc_lock);
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
+}
+
+/* ------------------------------------------------------------------------- */
+
+int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
+		struct module *owner, const char *mod_name)
+{
+	int ret;
 
 	if (!driver || !driver->bind || !driver->setup)
 		return -EINVAL;
 
+	driver->driver.bus = &gadget_bus_type;
+	driver->driver.owner = owner;
+	driver->driver.mod_name = mod_name;
+	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+	ret = driver_register(&driver->driver);
+	if (ret) {
+		pr_warn("%s: driver registration failed: %d\n",
+				driver->function, ret);
+		return ret;
+	}
+
 	mutex_lock(&udc_lock);
-	list_for_each_entry(udc, &udc_list, list) {
-		udc_count++;
-
-		/* For now we take the first one */
-		if (!udc->driver)
-			goto found;
+	if (!driver->is_bound) {
+		if (driver->match_existing_only) {
+			pr_warn("%s: couldn't find an available UDC or it's busy\n",
+					driver->function);
+			ret = -EBUSY;
+		} else {
+			pr_info("%s: couldn't find an available UDC\n",
+					driver->function);
+			ret = 0;
+		}
 	}
+	mutex_unlock(&udc_lock);
 
-	if (!udc_count)
-		printf("No UDC available in the system\n");
-	else
-		/* When this happens, users should 'unbind <class> <index>'
-		 * using the output of 'dm tree' and looking at the line right
-		 * after the USB peripheral/device controller.
-		 */
-		printf("All UDCs in use (%d available), use the unbind command\n",
-		       udc_count);
-	mutex_unlock(&udc_lock);
-	return -ENODEV;
-found:
-	ret = udc_bind_to_driver(udc, driver);
-	mutex_unlock(&udc_lock);
+	if (ret)
+		driver_unregister(&driver->driver);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	return usb_gadget_probe_driver(driver);
-}
-EXPORT_SYMBOL_GPL(usb_gadget_register_driver);
+EXPORT_SYMBOL_GPL(usb_gadget_register_driver_owner);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = NULL;
-	int			ret = -ENODEV;
-
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	mutex_lock(&udc_lock);
-	list_for_each_entry(udc, &udc_list, list)
-		if (udc->driver == driver) {
-			usb_gadget_remove_driver(udc);
-			usb_gadget_set_state(udc->gadget,
-					USB_STATE_NOTATTACHED);
-			ret = 0;
-			break;
-		}
-
-	mutex_unlock(&udc_lock);
-	return ret;
+	driver_unregister(&driver->driver);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unregister_driver);
 
+/* ------------------------------------------------------------------------- */
+
+static ssize_t srp_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t n)
+{
+	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
+
+	if (sysfs_streq(buf, "1"))
+		usb_gadget_wakeup(udc->gadget);
+
+	return n;
+}
+static DEVICE_ATTR_WO(srp);
+
+static ssize_t soft_connect_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t n)
+{
+	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
+	ssize_t			ret;
+
+	device_lock(&udc->gadget->dev);
+	if (!udc->driver) {
+		dev_err(dev, "soft-connect without a gadget driver\n");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (sysfs_streq(buf, "connect")) {
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_udc_start_locked(udc);
+		usb_gadget_connect_locked(udc->gadget);
+		mutex_unlock(&udc->connect_lock);
+	} else if (sysfs_streq(buf, "disconnect")) {
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_udc_stop_locked(udc);
+		mutex_unlock(&udc->connect_lock);
+	} else {
+		dev_err(dev, "unsupported command '%s'\n", buf);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = n;
+out:
+	device_unlock(&udc->gadget->dev);
+	return ret;
+}
+static DEVICE_ATTR_WO(soft_connect);
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
+	struct usb_gadget	*gadget = udc->gadget;
+
+	return sprintf(buf, "%s\n", usb_state_string(gadget->state));
+}
+static DEVICE_ATTR_RO(state);
+
+static ssize_t function_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
+	struct usb_gadget_driver *drv;
+	int			rc = 0;
+
+	mutex_lock(&udc_lock);
+	drv = udc->driver;
+	if (drv && drv->function)
+		rc = scnprintf(buf, PAGE_SIZE, "%s\n", drv->function);
+	mutex_unlock(&udc_lock);
+	return rc;
+}
+static DEVICE_ATTR_RO(function);
+
+#define USB_UDC_SPEED_ATTR(name, param)					\
+ssize_t name##_show(struct device *dev,					\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct usb_udc *udc = container_of(dev, struct usb_udc, dev);	\
+	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
+			usb_speed_string(udc->gadget->param));		\
+}									\
+static DEVICE_ATTR_RO(name)
+
+static USB_UDC_SPEED_ATTR(current_speed, speed);
+static USB_UDC_SPEED_ATTR(maximum_speed, max_speed);
+
+#define USB_UDC_ATTR(name)					\
+ssize_t name##_show(struct device *dev,				\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev); \
+	struct usb_gadget	*gadget = udc->gadget;		\
+								\
+	return scnprintf(buf, PAGE_SIZE, "%d\n", gadget->name);	\
+}								\
+static DEVICE_ATTR_RO(name)
+
+static USB_UDC_ATTR(is_otg);
+static USB_UDC_ATTR(is_a_peripheral);
+static USB_UDC_ATTR(b_hnp_enable);
+static USB_UDC_ATTR(a_hnp_support);
+static USB_UDC_ATTR(a_alt_hnp_support);
+static USB_UDC_ATTR(is_selfpowered);
+
+static struct attribute *usb_udc_attrs[] = {
+	&dev_attr_srp.attr,
+	&dev_attr_soft_connect.attr,
+	&dev_attr_state.attr,
+	&dev_attr_function.attr,
+	&dev_attr_current_speed.attr,
+	&dev_attr_maximum_speed.attr,
+
+	&dev_attr_is_otg.attr,
+	&dev_attr_is_a_peripheral.attr,
+	&dev_attr_b_hnp_enable.attr,
+	&dev_attr_a_hnp_support.attr,
+	&dev_attr_a_alt_hnp_support.attr,
+	&dev_attr_is_selfpowered.attr,
+	NULL,
+};
+
+static const struct attribute_group usb_udc_attr_group = {
+	.attrs = usb_udc_attrs,
+};
+
+static const struct attribute_group *usb_udc_attr_groups[] = {
+	&usb_udc_attr_group,
+	NULL,
+};
+
+static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct usb_udc	*udc = container_of(dev, struct usb_udc, dev);
+	int			ret;
+
+	ret = add_uevent_var(env, "USB_UDC_NAME=%s", udc->gadget->name);
+	if (ret) {
+		dev_err(dev, "failed to add uevent USB_UDC_NAME\n");
+		return ret;
+	}
+
+	mutex_lock(&udc_lock);
+	if (udc->driver)
+		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
+				udc->driver->function);
+	mutex_unlock(&udc_lock);
+	if (ret) {
+		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct class udc_class = {
+	.name		= "udc",
+	.dev_uevent	= usb_udc_uevent,
+};
+
+static const struct bus_type gadget_bus_type = {
+	.name = "gadget",
+	.probe = gadget_bind_driver,
+	.remove = gadget_unbind_driver,
+	.match = gadget_match_driver,
+};
+
+static int __init usb_udc_init(void)
+{
+	int rc;
+
+	rc = class_register(&udc_class);
+	if (rc)
+		return rc;
+
+	rc = bus_register(&gadget_bus_type);
+	if (rc)
+		class_unregister(&udc_class);
+	return rc;
+}
+subsys_initcall(usb_udc_init);
+
+static void __exit usb_udc_exit(void)
+{
+	bus_unregister(&gadget_bus_type);
+	class_unregister(&udc_class);
+}
+module_exit(usb_udc_exit);
+
 MODULE_DESCRIPTION("UDC Framework");
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.48.1

