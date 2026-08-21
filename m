Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35649C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E95D340E07;
	Fri, 21 Aug 2026 13:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhAE-kPn2zUU; Fri, 21 Aug 2026 13:15:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318130;
	bh=g1NFr09CpfwA//83DpfPx2aiH1F222UVXJIOLh8a0dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIkUOBcdL/XaBK+cnFWZiTb0r1nK2JdovanNcyi6iimbOWcaRhZUFwPoT7YkyT6ka
	 FGep6AtqLqH6KrY1qXIc27BlBQsrJWO5hvc3Jj64ahzjWrVeXOTBTLE3RGDgpmLV+n
	 yV1bxhyvwb7Te/STEQc8ofyWCPjjptL2WbzpI6os6l6xOHs6RlXczrvIjUbGlm5chS
	 sY7dwHnanYgQXjvmzv1/Bq7LK7L9j38a/srJG/cmX0gO2aKTLJWcnqPp6F3eIrHTc9
	 sOUo7rkdfT/3eCMS6qa6y8kLr2Z5sceP1ccCpIcso7QLvkQxQZ9nts4pv+v6XUprA0
	 RThmsX0BpZdPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A323D40DAB;
	Fri, 21 Aug 2026 13:15:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 988C5279
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F348407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tg039Ljwyrg2 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=E60WX/G1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED58C40931
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7802984A30; Fri, 21 Aug 2026 10:52:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93350842FC
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="E60WX/G1"; 
 dkim-atps=neutral
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a18d89e4d9so168466a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302346; x=1787907146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1NFr09CpfwA//83DpfPx2aiH1F222UVXJIOLh8a0dc=;
 b=E60WX/G1s0x1EtJC0vbMBveQHZ1XqoLKwfCrJK8XZD6bBakHLZnHjLtOPZ/+/72MYs
 suP6wNqoAUYJm/odeDgouUJvhmeQW00QPn9fTJBF1blpSngvVoGmpeJuI9cLlh+DEW4U
 Bv4tWCD9nZp94hwERbqnDhsth4+3o/k7TFVwFQoJkAHtAN8v/acLvncCAPOfsc9XulSp
 wzKqOm6U5PRqJHHWTJbDqFSoszHNf2Zc7AClTfFYYiNNh/WWYX7SqKzHgTnjkoG61ae0
 mYYF/iG5cYAuHHTl9JFECYWyG5wN4Il4dEshpBfgZa4x6y4Tu2lbK5S4gi7GFRH6dcRF
 VjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302346; x=1787907146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1NFr09CpfwA//83DpfPx2aiH1F222UVXJIOLh8a0dc=;
 b=P2Le2JW7O4ycPRctZdQW9L2gqDrtIPCOhy4nJHlC8GJgWCl0MtmkRfmdwN6TcJvO9R
 IaYtZnf4I/heZ+xPSP/i9iO+k8GQp/lYHTvUSUK07epgLaldpVPUumA/opxSIRi5fhIn
 8eouVjcA8oiUnXXhEFT9kuDqw1a12a59nccJExz8gy5pD6Zl143O/kyctNkkIcf5QFQN
 UU4o28XZ+ZnDPdNBXT2VLxNF4yI6tvh+ajflSAv+aNyhXhzHHscB5IcUigswkV+QjBOM
 Mtu942NYfD1uYvIH8vsgwQnO8okNcvgIwe8d6LTfbJFLxijmuEgSJHz9OprCgQyotRv7
 aJ+Q==
X-Gm-Message-State: AFuF++kVbIkWqLsJ6DXwwhMpi8BXXxe0clhbVTTWIxVOiBwi9U0adzY8
 nZYeOiz2N9qfgVsWr8UksyhPBLQ9w6MK4jbcPgyUue4WjVrvQSro/FYqQQ7QYtqYh32oD/hkHn7
 NsDGD
X-Gm-Gg: AR+sD10LLO3tSClaqwXCmTFQZcRCzHFLvIL+yuMi2rmOzp+5Lw4tX+UuwPTZES8ov6S
 Uo7LIPlY9B0zVZsaklW4sgFfa9q4TAPz6BmV38mDKFgj4bx6FsulnpI/qzJeIOjyhtOp/yv/ljZ
 2qhZr1x9Tt+SjUwhKi4IUmUohlJV8hmXM5n89F95RzSg8cD7GftxHzQbeJLnLcP9CDRR7+Eq1CH
 Xn8w4jFb84BmDtS6u3S6/BsRRtwIGZ3fYojxLN4Kw8bXuye3NeCEFXi7jzue8o2ovViqwJlN/u+
 wNRpytkFKzGs8iSK9/gGEJhaZ0Rwe6YUOBjo6wtvWKctey4/A/j6+nxMY5lphtFHIqxy1b+8OWS
 /SNYSOoTgttTXkSjL1f8VNoBGJM1AurO1q3l1BEQlPMJ728pD9mpBMNYa7/F7MwUHI3Cuebd0wd
 pxF8Z7tzPjVmkSE2wiFLPhItfGQJulK0csNtmMtZNaBu2tZ6dgw65ZzYFEZ23OH1njSkWnJ5EWd
 4Sh0H2IYTwqfcHlcAnk3ak4
X-Received: by 2002:a05:6402:2815:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a42f1a97b9mr2727624a12.2.1787302345666; 
 Fri, 21 Aug 2026 01:52:25 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3fec280e9sm5707301a12.0.2026.08.21.01.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:25 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 67/87] usb: gadget: udc: make udc-core build in u-boot
Date: Fri, 21 Aug 2026 10:47:43 +0200
Message-ID: <20260821084829.2070426-68-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

Adapt the re-imported udc-core.c to u-boot and build it for every gadget
config. The resynced gadget.h makes usb_ep_enable() and friends real
functions and they live here now.

udc-core only sees controllers that called usb_add_gadget_udc(). Driver
model drivers do that from probe, the others have no probe at all. Add a
weak usb_gadget_udc_bringup() hook so they can bring themselves up when a
gadget driver asks for a UDC. Report what the hook returns, otherwise a
controller that fails to come up only says "No UDC available".

In the kernel udc_start(), udc_stop() and get_frame() are mandatory. In
u-boot they are not, so check them before calling. Without the check a
driver that does not have them takes the board down instead of failing.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/udc/Makefile   |   1 +
 drivers/usb/gadget/udc/udc-core.c | 929 +++++-------------------------
 include/linux/usb/gadget.h        |   3 +
 3 files changed, 153 insertions(+), 780 deletions(-)

diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 56b9b123fa16..f80ae6e5add5 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
 obj-$(CONFIG_$(PHASE_)DM_USB_GADGET)	+= udc-core.o
+obj-$(CONFIG_$(PHASE_)USB_GADGET)	+= udc-core.o
 obj-y += udc-uclass.o
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 2af62c579cb3..a01a7e6dc21f 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -7,27 +7,17 @@
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
-#define pr_fmt(fmt)	"UDC core: " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/idr.h>
-#include <linux/err.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/compat.h>
+#include <malloc.h>
+#include <asm/cache.h>
+#include <linux/bug.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched/task_stack.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb.h>
-
-#include "trace.h"
-
-static DEFINE_IDA(gadget_id_numbers);
-
-static const struct bus_type gadget_bus_type;
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -41,7 +31,6 @@ static const struct bus_type gadget_bus_type;
  * @allow_connect: Indicates whether UDC is allowed to be pulled up.
  * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
  * unbound.
- * @vbus_work: work routine to handle VBUS status change notifications.
  * @connect_lock: protects udc->started, gadget->connect,
  * gadget->allow_connect and gadget->deactivate. The routines
  * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
@@ -59,15 +48,13 @@ struct usb_udc {
 	bool				vbus;
 	bool				started;
 	bool				allow_connect;
-	struct work_struct		vbus_work;
 	struct mutex			connect_lock;
 };
 
-static const struct class udc_class;
 static LIST_HEAD(udc_list);
 
 /* Protects udc_list, udc->driver, driver->is_bound, and related calls */
-static DEFINE_MUTEX(udc_lock);
+DEFINE_MUTEX(udc_lock);
 
 /* ------------------------------------------------------------------------- */
 
@@ -84,8 +71,6 @@ void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 {
 	ep->maxpacket_limit = maxpacket_limit;
 	ep->maxpacket = maxpacket_limit;
-
-	trace_usb_ep_set_maxpacket_limit(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
 
@@ -120,9 +105,10 @@ int usb_ep_enable(struct usb_ep *ep)
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
 	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+#ifndef CONFIG_SPL_BUILD
 		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
 			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
-
+#endif
 		ret = -EINVAL;
 		goto out;
 	}
@@ -134,8 +120,6 @@ int usb_ep_enable(struct usb_ep *ep)
 	ep->enabled = true;
 
 out:
-	trace_usb_ep_enable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_enable);
@@ -168,8 +152,6 @@ int usb_ep_disable(struct usb_ep *ep)
 	ep->enabled = false;
 
 out:
-	trace_usb_ep_disable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_disable);
@@ -191,13 +173,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
 struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 						       gfp_t gfp_flags)
 {
-	struct usb_request *req = NULL;
-
-	req = ep->ops->alloc_request(ep, gfp_flags);
-
-	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
-
-	return req;
+	return  ep->ops->alloc_request(ep, gfp_flags);
 }
 EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 
@@ -213,7 +189,6 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	trace_usb_ep_free_request(ep, req, 0);
 	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
@@ -301,8 +276,6 @@ int usb_ep_queue(struct usb_ep *ep,
 	ret = ep->ops->queue(ep, req, gfp_flags);
 
 out:
-	trace_usb_ep_queue(ep, req, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_queue);
@@ -326,12 +299,7 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
  */
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 {
-	int ret;
-
-	ret = ep->ops->dequeue(ep, req);
-	trace_usb_ep_dequeue(ep, req, ret);
-
-	return ret;
+	return ep->ops->dequeue(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_dequeue);
 
@@ -360,12 +328,7 @@ EXPORT_SYMBOL_GPL(usb_ep_dequeue);
  */
 int usb_ep_set_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 1);
-	trace_usb_ep_set_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 1);
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_halt);
 
@@ -386,12 +349,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_halt);
  */
 int usb_ep_clear_halt(struct usb_ep *ep)
 {
-	int ret;
-
-	ret = ep->ops->set_halt(ep, 0);
-	trace_usb_ep_clear_halt(ep, ret);
-
-	return ret;
+	return ep->ops->set_halt(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_clear_halt);
 
@@ -416,8 +374,6 @@ int usb_ep_set_wedge(struct usb_ep *ep)
 	else
 		ret = ep->ops->set_halt(ep, 1);
 
-	trace_usb_ep_set_wedge(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
@@ -448,8 +404,6 @@ int usb_ep_fifo_status(struct usb_ep *ep)
 	else
 		ret = -EOPNOTSUPP;
 
-	trace_usb_ep_fifo_status(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
@@ -469,8 +423,6 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
 {
 	if (ep->ops->fifo_flush)
 		ep->ops->fifo_flush(ep);
-
-	trace_usb_ep_fifo_flush(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
@@ -485,13 +437,11 @@ EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
  */
 int usb_gadget_frame_number(struct usb_gadget *gadget)
 {
-	int ret;
-
-	ret = gadget->ops->get_frame(gadget);
 
-	trace_usb_gadget_frame_number(gadget, ret);
+	if (!gadget->ops->get_frame)
+		return -EOPNOTSUPP;
 
-	return ret;
+	return gadget->ops->get_frame(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
 
@@ -520,39 +470,10 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
 	ret = gadget->ops->wakeup(gadget);
 
 out:
-	trace_usb_gadget_wakeup(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
 
-/**
- * usb_gadget_set_remote_wakeup - configures the device remote wakeup feature.
- * @gadget:the device being configured for remote wakeup
- * @set:value to be configured.
- *
- * set to one to enable remote wakeup feature and zero to disable it.
- *
- * returns zero on success, else negative errno.
- */
-int usb_gadget_set_remote_wakeup(struct usb_gadget *gadget, int set)
-{
-	int ret = 0;
-
-	if (!gadget->ops->set_remote_wakeup) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->set_remote_wakeup(gadget, set);
-
-out:
-	trace_usb_gadget_set_remote_wakeup(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_set_remote_wakeup);
-
 /**
  * usb_gadget_set_selfpowered - sets the device selfpowered feature.
  * @gadget:the device being declared as self-powered
@@ -574,8 +495,6 @@ int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 1);
 
 out:
-	trace_usb_gadget_set_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
@@ -602,43 +521,10 @@ int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 0);
 
 out:
-	trace_usb_gadget_clear_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
 
-/**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- * Context: can sleep
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	if (!gadget->ops->vbus_session) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_session(gadget, 1);
-
-out:
-	trace_usb_gadget_vbus_connect(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
-
 /**
  * usb_gadget_vbus_draw - constrain controller's VBUS power usage
  * @gadget:The device whose VBUS usage is being described
@@ -653,21 +539,10 @@ EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
  */
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-	int ret = 0;
-
-	if (!gadget->ops->vbus_draw) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_draw(gadget, mA);
-	if (!ret)
-		gadget->mA = mA;
+	if (!gadget->ops->vbus_draw)
+		return -EOPNOTSUPP;
 
-out:
-	trace_usb_gadget_vbus_draw(gadget, ret);
-
-	return ret;
+	return gadget->ops->vbus_draw(gadget, mA);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
 
@@ -694,8 +569,6 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 	ret = gadget->ops->vbus_session(gadget, 0);
 
 out:
-	trace_usb_gadget_vbus_disconnect(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
@@ -726,8 +599,6 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		gadget->connected = 1;
 
 out:
-	trace_usb_gadget_connect(gadget, ret);
-
 	return ret;
 }
 
@@ -785,8 +656,6 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 out:
-	trace_usb_gadget_disconnect(gadget, ret);
-
 	return ret;
 }
 
@@ -815,170 +684,31 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
-/**
- * usb_gadget_deactivate - deactivate function which is not ready to work
- * @gadget: the peripheral being deactivated
- *
- * This routine may be used during the gadget driver bind() call to prevent
- * the peripheral from ever being visible to the USB host, unless later
- * usb_gadget_activate() is called.  For example, user mode components may
- * need to be activated before the system can talk to hosts.
- *
- * This routine may sleep; it must not be called in interrupt context
- * (such as from within a gadget driver's disconnect() callback).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_deactivate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (gadget->deactivated)
-		goto unlock;
-
-	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
-		if (ret)
-			goto unlock;
-
-		/*
-		 * If gadget was being connected before deactivation, we want
-		 * to reconnect it in usb_gadget_activate().
-		 */
-		gadget->connected = true;
-	}
-	gadget->deactivated = true;
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_deactivate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
-
-/**
- * usb_gadget_activate - activate function which is not ready to work
- * @gadget: the peripheral being activated
- *
- * This routine activates gadget which was previously deactivated with
- * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
- *
- * This routine may sleep; it must not be called in interrupt context.
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_activate(struct usb_gadget *gadget)
-{
-	int ret = 0;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	if (!gadget->deactivated)
-		goto unlock;
-
-	gadget->deactivated = false;
-
-	/*
-	 * If gadget has been connected before deactivation, or became connected
-	 * while it was being deactivated, we call usb_gadget_connect().
-	 */
-	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
-	trace_usb_gadget_activate(gadget, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_activate);
-
 /* ------------------------------------------------------------------------- */
 
-#ifdef	CONFIG_HAS_DMA
-
-int usb_gadget_map_request_by_dev(struct device *dev,
+int usb_gadget_map_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
 	if (req->length == 0)
 		return 0;
 
-	if (req->sg_was_mapped) {
-		req->num_mapped_sgs = req->num_sgs;
-		return 0;
-	}
-
-	if (req->num_sgs) {
-		int     mapped;
-
-		mapped = dma_map_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		if (mapped == 0) {
-			dev_err(dev, "failed to map SGs\n");
-			return -EFAULT;
-		}
-
-		req->num_mapped_sgs = mapped;
-	} else {
-		if (is_vmalloc_addr(req->buf)) {
-			dev_err(dev, "buffer is not dma capable\n");
-			return -EFAULT;
-		} else if (object_is_on_stack(req->buf)) {
-			dev_err(dev, "buffer is on stack\n");
-			return -EFAULT;
-		}
-
-		req->dma = dma_map_single(dev, req->buf, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		if (dma_mapping_error(dev, req->dma)) {
-			dev_err(dev, "failed to map buffer\n");
-			return -EFAULT;
-		}
-
-		req->dma_mapped = 1;
-	}
-
+	req->dma = dma_map_single(req->buf, req->length,
+				  is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_map_request_by_dev);
-
-int usb_gadget_map_request(struct usb_gadget *gadget,
-		struct usb_request *req, int is_in)
-{
-	return usb_gadget_map_request_by_dev(gadget->dev.parent, req, is_in);
-}
 EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 
-void usb_gadget_unmap_request_by_dev(struct device *dev,
+void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0 || req->sg_was_mapped)
+	if (req->length == 0)
 		return;
 
-	if (req->num_mapped_sgs) {
-		dma_unmap_sg(dev, req->sg, req->num_sgs,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-		req->num_mapped_sgs = 0;
-	} else if (req->dma_mapped) {
-		dma_unmap_single(dev, req->dma, req->length,
-				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		req->dma_mapped = 0;
-	}
-}
-EXPORT_SYMBOL_GPL(usb_gadget_unmap_request_by_dev);
-
-void usb_gadget_unmap_request(struct usb_gadget *gadget,
-		struct usb_request *req, int is_in)
-{
-	usb_gadget_unmap_request_by_dev(gadget->dev.parent, req, is_in);
+	dma_unmap_single(req->dma, req->length,
+			 is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
-#endif	/* CONFIG_HAS_DMA */
-
 /* ------------------------------------------------------------------------- */
 
 /**
@@ -992,11 +722,6 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
 {
-	if (likely(req->status == 0))
-		usb_led_activity(USB_LED_EVENT_GADGET);
-
-	trace_usb_gadget_giveback_request(ep, req, 0);
-
 	req->complete(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
@@ -1112,71 +837,13 @@ EXPORT_SYMBOL_GPL(usb_gadget_check_config);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_gadget_state_work(struct work_struct *work)
-{
-	struct usb_gadget *gadget = work_to_gadget(work);
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc)
-		sysfs_notify(&udc->dev.kobj, NULL, "state");
-}
-
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
 	gadget->state = state;
-	schedule_work(&gadget->work);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
-/* ------------------------------------------------------------------------- */
-
-/* Acquire connect_lock before calling this function. */
-static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
-{
-	if (udc->vbus)
-		return usb_gadget_connect_locked(udc->gadget);
-	else
-		return usb_gadget_disconnect_locked(udc->gadget);
-}
-
-static void vbus_event_work(struct work_struct *work)
-{
-	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
-
-	mutex_lock(&udc->connect_lock);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-}
-
-/**
- * usb_udc_vbus_handler - updates the udc core vbus status, and try to
- * connect or disconnect gadget
- * @gadget: The gadget which vbus change occurs
- * @status: The vbus status
- *
- * The udc driver calls it when it wants to connect or disconnect gadget
- * according to vbus status.
- *
- * This function can be invoked from interrupt context by irq handlers of
- * the gadget drivers, however, usb_udc_connect_control() has to run in
- * non-atomic context due to the following:
- * a. Some of the gadget driver implementations expect the ->pullup
- * callback to be invoked in non-atomic context.
- * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
- * Hence offload invocation of usb_udc_connect_control() to workqueue.
- */
-void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
-{
-	struct usb_udc *udc = gadget->udc;
-
-	if (udc) {
-		udc->vbus = status;
-		schedule_work(&udc->vbus_work);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
-
 /**
  * usb_gadget_udc_reset - notifies the udc core that bus reset occurs
  * @gadget: The gadget which bus reset occurs
@@ -1219,6 +886,9 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 		return -EBUSY;
 	}
 
+	if (!udc->gadget->ops->udc_start)
+		return -EOPNOTSUPP;
+
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 	if (!ret)
 		udc->started = true;
@@ -1247,7 +917,8 @@ static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
 		return;
 	}
 
-	udc->gadget->ops->udc_stop(udc->gadget);
+	if (udc->gadget->ops->udc_stop)
+		udc->gadget->ops->udc_stop(udc->gadget);
 	udc->started = false;
 }
 
@@ -1278,6 +949,37 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 		gadget->ops->udc_set_speed(gadget, s);
 }
 
+static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
+{
+	int ret;
+
+	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
+			driver->function);
+
+	udc->driver = driver;
+
+	usb_gadget_udc_set_speed(udc, driver->speed);
+
+	ret = driver->bind(udc->gadget);
+	if (ret)
+		goto err1;
+	ret = usb_gadget_udc_start_locked(udc);
+	if (ret) {
+		driver->unbind(udc->gadget);
+		goto err1;
+	}
+	udc->allow_connect = true;
+	usb_gadget_connect(udc->gadget);
+
+	return 0;
+err1:
+	if (ret != -EISNAM)
+		dev_err(&udc->dev, "failed to start %s: %d\n",
+			udc->driver->function, ret);
+	udc->driver = NULL;
+	return ret;
+}
+
 /**
  * usb_gadget_enable_async_callbacks - tell usb device controller to enable asynchronous callbacks
  * @udc: The UDC which should enable async callbacks
@@ -1337,17 +1039,9 @@ static void usb_udc_release(struct device *dev)
 	struct usb_udc *udc;
 
 	udc = container_of(dev, struct usb_udc, dev);
-	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
 	kfree(udc);
 }
 
-static const struct attribute_group *usb_udc_attr_groups[];
-
-static void usb_udc_nop_release(struct device *dev)
-{
-	dev_vdbg(dev, "%s\n", __func__);
-}
-
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1358,16 +1052,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
-
-	if (release)
-		gadget->dev.release = release;
-	else
-		gadget->dev.release = usb_udc_nop_release;
-
-	device_initialize(&gadget->dev);
-	gadget->dev.bus = &gadget_bus_type;
+	gadget->dev.release = release;
 }
 EXPORT_SYMBOL_GPL(usb_initialize_gadget);
 
@@ -1387,15 +1073,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (!udc)
 		goto error;
 
-	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
-	udc->dev.class = &udc_class;
-	udc->dev.groups = usb_udc_attr_groups;
+	udc->dev.class = NULL;
 	udc->dev.parent = gadget->dev.parent;
-	ret = dev_set_name(&udc->dev, "%s",
-			kobject_name(&gadget->dev.parent->kobj));
-	if (ret)
-		goto err_put_udc;
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
@@ -1406,50 +1086,11 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
-	INIT_WORK(&udc->vbus_work, vbus_event_work);
-
-	ret = device_add(&udc->dev);
-	if (ret)
-		goto err_unlist_udc;
 
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
-	udc->vbus = true;
-
-	ret = ida_alloc(&gadget_id_numbers, GFP_KERNEL);
-	if (ret < 0)
-		goto err_del_udc;
-	gadget->id_number = ret;
-	dev_set_name(&gadget->dev, "gadget.%d", ret);
-
-	ret = device_add(&gadget->dev);
-	if (ret)
-		goto err_free_id;
-
-	ret = sysfs_create_link(&udc->dev.kobj,
-				&gadget->dev.kobj, "gadget");
-	if (ret)
-		goto err_del_gadget;
 
 	return 0;
 
- err_del_gadget:
-	device_del(&gadget->dev);
-
- err_free_id:
-	ida_free(&gadget_id_numbers, gadget->id_number);
-
- err_del_udc:
-	flush_work(&gadget->work);
-	device_del(&udc->dev);
-
- err_unlist_udc:
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
-
- err_put_udc:
-	put_device(&udc->dev);
-
  error:
 	return ret;
 }
@@ -1468,13 +1109,8 @@ EXPORT_SYMBOL_GPL(usb_add_gadget);
 int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	int	ret;
-
 	usb_initialize_gadget(parent, gadget, release);
-	ret = usb_add_gadget(gadget);
-	if (ret)
-		usb_put_gadget(gadget);
-	return ret;
+	return usb_add_gadget(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
 
@@ -1499,7 +1135,7 @@ char *usb_get_gadget_udc_name(void)
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		if (!udc->driver) {
-			name = kstrdup(udc->gadget->name, GFP_KERNEL);
+			name = strdup(udc->gadget->name);
 			break;
 		}
 	}
@@ -1522,409 +1158,142 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
-/**
- * usb_del_gadget - deletes a gadget and unregisters its udc
- * @gadget: the gadget to be deleted.
- *
- * This will unbind @gadget, if it is bound.
- * It will not do a final usb_put_gadget().
- */
-void usb_del_gadget(struct usb_gadget *gadget)
+static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
-	struct usb_udc *udc = gadget->udc;
-
-	if (!udc)
-		return;
+	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
+			udc->driver->function);
 
-	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
-
-	mutex_lock(&udc_lock);
-	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
+	udc->allow_connect = false;
+	usb_gadget_disconnect(udc->gadget);
+	udc->driver->disconnect(udc->gadget);
+	udc->driver->unbind(udc->gadget);
+	usb_gadget_udc_stop_locked(udc);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
-	sysfs_remove_link(&udc->dev.kobj, "gadget");
-	device_del(&gadget->dev);
-	flush_work(&gadget->work);
-	ida_free(&gadget_id_numbers, gadget->id_number);
-	cancel_work_sync(&udc->vbus_work);
-	device_unregister(&udc->dev);
+	udc->driver = NULL;
 }
-EXPORT_SYMBOL_GPL(usb_del_gadget);
 
 /**
- * usb_del_gadget_udc - unregisters a gadget
- * @gadget: the gadget to be unregistered.
+ * usb_del_gadget_udc - deletes @udc from udc_list
+ * @gadget: the gadget to be removed.
  *
- * Calls usb_del_gadget() and does a final usb_put_gadget().
+ * This, will call usb_gadget_unregister_driver() if
+ * the @udc is still busy.
  */
 void usb_del_gadget_udc(struct usb_gadget *gadget)
 {
-	usb_del_gadget(gadget);
-	usb_put_gadget(gadget);
-}
-EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
-
-/* ------------------------------------------------------------------------- */
-
-static int gadget_match_driver(struct device *dev, const struct device_driver *drv)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	const struct usb_gadget_driver *driver = container_of(drv,
-			struct usb_gadget_driver, driver);
-
-	/* If the driver specifies a udc_name, it must match the UDC's name */
-	if (driver->udc_name &&
-			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
-		return 0;
-
-	/* If the driver is already bound to a gadget, it doesn't match */
-	if (driver->is_bound)
-		return 0;
-
-	/* Otherwise any gadget driver matches any UDC */
-	return 1;
-}
-
-static int gadget_bind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = container_of(dev->driver,
-			struct usb_gadget_driver, driver);
-	int ret = 0;
+	struct usb_udc		*udc = NULL;
 
 	mutex_lock(&udc_lock);
-	if (driver->is_bound) {
-		mutex_unlock(&udc_lock);
-		return -ENXIO;		/* Driver binds to only one gadget */
-	}
-	driver->is_bound = true;
-	udc->driver = driver;
-	mutex_unlock(&udc_lock);
-
-	dev_dbg(&udc->dev, "binding gadget driver [%s]\n", driver->function);
-
-	usb_gadget_udc_set_speed(udc, driver->max_speed);
-
-	ret = driver->bind(udc->gadget, driver);
-	if (ret)
-		goto err_bind;
-
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
-		goto err_start;
-	}
-	usb_gadget_enable_async_callbacks(udc);
-	udc->allow_connect = true;
-	ret = usb_udc_connect_control_locked(udc);
-	if (ret)
-		goto err_connect_control;
-
-	mutex_unlock(&udc->connect_lock);
-
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-	return 0;
-
- err_connect_control:
-	udc->allow_connect = false;
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
-
- err_start:
-	driver->unbind(udc->gadget);
-
- err_bind:
-	if (ret != -EISNAM)
-		dev_err(&udc->dev, "failed to start %s: %d\n",
-			driver->function, ret);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
 
-	mutex_lock(&udc_lock);
-	udc->driver = NULL;
-	driver->is_bound = false;
+	dev_err(gadget->dev.parent, "gadget not registered.\n");
 	mutex_unlock(&udc_lock);
 
-	return ret;
-}
-
-static void gadget_unbind_driver(struct device *dev)
-{
-	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
-	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = udc->driver;
-
-	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
-
-	udc->allow_connect = false;
-	cancel_work_sync(&udc->vbus_work);
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
-	usb_gadget_disable_async_callbacks(udc);
-	if (gadget->irq)
-		synchronize_irq(gadget->irq);
-	mutex_unlock(&udc->connect_lock);
-
-	udc->driver->unbind(gadget);
+	return;
 
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+found:
+	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
 
-	mutex_lock(&udc_lock);
-	driver->is_bound = false;
-	udc->driver = NULL;
+	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
+	if (udc->driver)
+		usb_gadget_remove_driver(udc);
 }
+EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
-int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
-		struct module *owner, const char *mod_name)
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
-	int ret;
+	struct usb_udc		*udc = NULL;
+	int			ret = -ENODEV;
 
-	if (!driver || !driver->bind || !driver->setup)
+	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	driver->driver.bus = &gadget_bus_type;
-	driver->driver.owner = owner;
-	driver->driver.mod_name = mod_name;
-	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
-	ret = driver_register(&driver->driver);
-	if (ret) {
-		pr_warn("%s: driver registration failed: %d\n",
-				driver->function, ret);
-		return ret;
-	}
-
 	mutex_lock(&udc_lock);
-	if (!driver->is_bound) {
-		if (driver->match_existing_only) {
-			pr_warn("%s: couldn't find an available UDC or it's busy\n",
-					driver->function);
-			ret = -EBUSY;
-		} else {
-			pr_info("%s: couldn't find an available UDC\n",
-					driver->function);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->driver == driver) {
+			usb_gadget_remove_driver(udc);
+			usb_gadget_set_state(udc->gadget,
+					USB_STATE_NOTATTACHED);
 			ret = 0;
+			break;
 		}
-	}
-	mutex_unlock(&udc_lock);
 
-	if (ret)
-		driver_unregister(&driver->driver);
+	mutex_unlock(&udc_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_register_driver_owner);
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (!driver || !driver->unbind)
-		return -EINVAL;
-
-	driver_unregister(&driver->driver);
-	return 0;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_unregister_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static ssize_t srp_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
+/*
+ * u-boot: a controller that is not a driver model device has no probe of its
+ * own, so it never calls usb_add_gadget_udc(). Such drivers implement this
+ * hook and bring themselves up the first time a gadget driver asks for a UDC.
+ */
+__weak int usb_gadget_udc_bringup(void)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-
-	if (sysfs_streq(buf, "1"))
-		usb_gadget_wakeup(udc->gadget);
-
-	return n;
+	return 0;
 }
-static DEVICE_ATTR_WO(srp);
 
-static ssize_t soft_connect_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	ssize_t			ret;
+	struct usb_udc		*udc = NULL;
+	unsigned int		udc_count = 0;
+	int			ret;
 
-	device_lock(&udc->gadget->dev);
-	if (!udc->driver) {
-		dev_err(dev, "soft-connect without a gadget driver\n");
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
 
-	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
-	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
-	} else {
-		dev_err(dev, "unsupported command '%s'\n", buf);
-		ret = -EINVAL;
-		goto out;
+	if (list_empty(&udc_list)) {
+		ret = usb_gadget_udc_bringup();
+		if (ret) {
+#ifndef CONFIG_SPL_BUILD
+			printf("UDC bringup failed: %d\n", ret);
+#endif
+			return ret;
+		}
 	}
 
-	ret = n;
-out:
-	device_unlock(&udc->gadget->dev);
-	return ret;
-}
-static DEVICE_ATTR_WO(soft_connect);
-
-static ssize_t state_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget	*gadget = udc->gadget;
-
-	return sprintf(buf, "%s\n", usb_state_string(gadget->state));
-}
-static DEVICE_ATTR_RO(state);
-
-static ssize_t function_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget_driver *drv;
-	int			rc = 0;
-
 	mutex_lock(&udc_lock);
-	drv = udc->driver;
-	if (drv && drv->function)
-		rc = scnprintf(buf, PAGE_SIZE, "%s\n", drv->function);
-	mutex_unlock(&udc_lock);
-	return rc;
-}
-static DEVICE_ATTR_RO(function);
-
-#define USB_UDC_SPEED_ATTR(name, param)					\
-ssize_t name##_show(struct device *dev,					\
-		struct device_attribute *attr, char *buf)		\
-{									\
-	struct usb_udc *udc = container_of(dev, struct usb_udc, dev);	\
-	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
-			usb_speed_string(udc->gadget->param));		\
-}									\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_SPEED_ATTR(current_speed, speed);
-static USB_UDC_SPEED_ATTR(maximum_speed, max_speed);
-
-#define USB_UDC_ATTR(name)					\
-ssize_t name##_show(struct device *dev,				\
-		struct device_attribute *attr, char *buf)	\
-{								\
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev); \
-	struct usb_gadget	*gadget = udc->gadget;		\
-								\
-	return scnprintf(buf, PAGE_SIZE, "%d\n", gadget->name);	\
-}								\
-static DEVICE_ATTR_RO(name)
-
-static USB_UDC_ATTR(is_otg);
-static USB_UDC_ATTR(is_a_peripheral);
-static USB_UDC_ATTR(b_hnp_enable);
-static USB_UDC_ATTR(a_hnp_support);
-static USB_UDC_ATTR(a_alt_hnp_support);
-static USB_UDC_ATTR(is_selfpowered);
-
-static struct attribute *usb_udc_attrs[] = {
-	&dev_attr_srp.attr,
-	&dev_attr_soft_connect.attr,
-	&dev_attr_state.attr,
-	&dev_attr_function.attr,
-	&dev_attr_current_speed.attr,
-	&dev_attr_maximum_speed.attr,
-
-	&dev_attr_is_otg.attr,
-	&dev_attr_is_a_peripheral.attr,
-	&dev_attr_b_hnp_enable.attr,
-	&dev_attr_a_hnp_support.attr,
-	&dev_attr_a_alt_hnp_support.attr,
-	&dev_attr_is_selfpowered.attr,
-	NULL,
-};
-
-static const struct attribute_group usb_udc_attr_group = {
-	.attrs = usb_udc_attrs,
-};
-
-static const struct attribute_group *usb_udc_attr_groups[] = {
-	&usb_udc_attr_group,
-	NULL,
-};
-
-static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
-{
-	const struct usb_udc	*udc = container_of(dev, struct usb_udc, dev);
-	int			ret;
+	list_for_each_entry(udc, &udc_list, list) {
+		udc_count++;
 
-	ret = add_uevent_var(env, "USB_UDC_NAME=%s", udc->gadget->name);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_NAME\n");
-		return ret;
+		/* For now we take the first one */
+		if (!udc->driver)
+			goto found;
 	}
 
-	mutex_lock(&udc_lock);
-	if (udc->driver)
-		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
-				udc->driver->function);
+#ifndef CONFIG_SPL_BUILD
+	if (!udc_count)
+		printf("No UDC available in the system\n");
+	else
+		/* When this happens, users should 'unbind <class> <index>'
+		 * using the output of 'dm tree' and looking at the line right
+		 * after the USB peripheral/device controller.
+		 */
+		printf("All UDCs in use (%d available), use the unbind command\n",
+		       udc_count);
+#endif
 	mutex_unlock(&udc_lock);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct class udc_class = {
-	.name		= "udc",
-	.dev_uevent	= usb_udc_uevent,
-};
-
-static const struct bus_type gadget_bus_type = {
-	.name = "gadget",
-	.probe = gadget_bind_driver,
-	.remove = gadget_unbind_driver,
-	.match = gadget_match_driver,
-};
-
-static int __init usb_udc_init(void)
-{
-	int rc;
-
-	rc = class_register(&udc_class);
-	if (rc)
-		return rc;
-
-	rc = bus_register(&gadget_bus_type);
-	if (rc)
-		class_unregister(&udc_class);
-	return rc;
+	return -ENODEV;
+found:
+	ret = udc_bind_to_driver(udc, driver);
+	mutex_unlock(&udc_lock);
+	return ret;
 }
-subsys_initcall(usb_udc_init);
+EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
-static void __exit usb_udc_exit(void)
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
-	bus_unregister(&gadget_bus_type);
-	class_unregister(&udc_class);
+	return usb_gadget_probe_driver(driver);
 }
-module_exit(usb_udc_exit);
+EXPORT_SYMBOL_GPL(usb_gadget_register_driver);
 
 MODULE_DESCRIPTION("UDC Framework");
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7137f0faf3c6..866f6049bb5f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -554,6 +554,9 @@ struct usb_gadget_driver {
  */
 int usb_gadget_register_driver(struct usb_gadget_driver *driver);
 
+/* u-boot: bring up a non driver model UDC on demand, see udc-core.c */
+int usb_gadget_udc_bringup(void);
+
 /**
  * usb_gadget_unregister_driver - unregister a gadget driver
  * @driver:the driver being unregistered
-- 
2.53.0

