Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA5606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SN2YuZjm;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fIFxcBuR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80934814BF;
	Sat,  7 Nov 2026 12:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0GUIXNHv1lG; Sat,  7 Nov 2026 12:50:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE56681352
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055805;
	b=hWqXCmxZVi4JQC+RjSsf6MT2ln610lpF6W0ocPgFgpeXs/1tbOBr7VOK9l77bcRdSFhC
	 axFByvNXy6oQw2iwXEK3AhVJwhPwpeo7/iIwi33SZPH9/TRYN2vh9gpxwcb3CQdty/rmu
	 OEQrd0R/8vs1qCB1c2VqgptAcM5oIiv2iEoGM2+EGQh4ufnhErtsKrj7UbYte1DEtlfD0
	 E40pxwbB+sHtbtaWveTLgVp4uNreckcA2eSTFiQnSnCp3lVi/I5CX26SYSUlnD3oJlDqp
	 +DLgvsSOhQASoKNUAhhxKF1YKZ/2pVw+9kPFyVVK0GHC4eLQxHf8o2kMmc6JkaXmsuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PfR/ZOuMUGMNrTFeYycBwTXsUQGAF5aqStKMwAT2Rs0=;
	b=NDH0MHqPv2Few9JjMRA5fxtEAdWFj6pdTQd2je9vl2/jRUEt2Mz59/nKFYJMKiAZp3T8
	 Ye/3aXk3jvb9qHdCchPfAFZMwynyOPWM6xowtZmSrznGxv5ebbfat6bPtblZmlZh7vMV2
	 EGCuDpPa5lHLo8INq9hpRUpVSn76lttezPCRgTCgdaq02fVztStdyFdoKyipZdpz9rMa1
	 7JkeBhr3meDNv0hfKcSrwWOao97GXfXOE2yxsECyZeWf5IVV0iThynFprBpH4ouP4oqeN
	 AoetJsFndYLT5KGs6/4wpmlC9MMsHrcjxMzG+Bx8MRMJiBm6U4NPt0qjoJuAPlNSjQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055805;
	bh=PfR/ZOuMUGMNrTFeYycBwTXsUQGAF5aqStKMwAT2Rs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SN2YuZjmFhUNZZJsAYQz3Dje+stDovSRnjM8xyDwMZPWNidrAVePyqNmTM8f71+LK
	 kltBXv22Y8blhd0nyHvmZm9W1xBEdXSUkiSy8T8kxa34z2dHWiytwkygwqyo2HrVIO
	 M7NGAJNSG+jU8WJvhtC+K/eeM6U2QvaZDpsJHWbbByK2emUzQ+uVzVGno5XqSHh/bY
	 W05LMKzy/fKiu8IKYAJFIFOdJMc+GItwdk9nTpBTvzQ84dRHKCujRW1dmlk4F8Kzlr
	 4ehoEpu2urWuLANtFElJNFIsMqCVjU/z5dCL+8P8yF5Q2f4NtIpWtpEfT27KV2KgZ7
	 TETGXD8XfwPIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE56681352;
	Sat,  7 Nov 2026 12:50:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0B1532A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85B6A407AA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NemMYpZMWSH1 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C9C940762
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=fIFxcBuR
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C9C940762
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:39 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so12081966b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036157; x=1794640957;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PfR/ZOuMUGMNrTFeYycBwTXsUQGAF5aqStKMwAT2Rs0=;
 b=fIFxcBuRx7kpoRdu9cW5RB9+sKpcx9FTr5KSaWfUtrFECHCqWzaJIma4hGAWNycz+i
 qoJHbtXw70DirOgqM13cBFK7Nv1BwWx9xQvGT79sm8Mz/7/fYjaC7/C4rMhrZXU2Ze7D
 CrlrNKEtms1AOpbOWe66OuFYVIYqPmtJV/K4ev1oUo7YOoE89Fo+0XREH8nUZZSYSr8p
 Nj99two1qUnBGKwCjMQtXBp+qzoz7U4mAFYM/hDnr7OTRVJeyhygC0p/OUulYITEbNg/
 WtgJZCr1l09axFNgzGGNgHW/1+mc0eRSsQG3RXGhNkDQy6qAJMhfYXV4I69eH9RCPsYG
 CeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036157; x=1794640957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PfR/ZOuMUGMNrTFeYycBwTXsUQGAF5aqStKMwAT2Rs0=;
 b=UHDepM2bcWlYSYBRY0CN58xElkruQ1xmZyIIqWensGzrwQekroC6zLk1sNQFMEW0yq
 q4MzALT09a/4kjJozsQXmG5dW945ewAlRwoF5QewHJHOSvrDFbNolWRkwsdNPB0wHHqi
 rnoeaUmx3OIW12j5wdAwuTwZMP725996tigpxSZgUZMZJhditlYWMKbVCFf+l9DVs05O
 vaeXkTneompP1+oBdyr0cxGO8/HNrsNf9ET90k8Y2jevmHpWan77sQ1ZqAOex9Fap+8n
 M+eOwYS6AQe/DKqFcs9WQmN60FmR/69mupYmz2D7/zL3wVEuUZTNZeTkFb7wxFMb22pn
 hAoA==
X-Gm-Message-State: APuU4Z/thWN3kEMqcf4T5MHuzPzycvgmw9QGqPfbC0zx1Lr/J5jMes+R
 70K57F64tEm3Z51XMFBUpW1FnxsyY9nkFzlUEv+v7wImxfNvHvw5xRiAL9G0J+/gBuZ3MSI8OOa
 hoC9U
X-Gm-Gg: AYBFou00qwOfaV8+8Qxlv7a2C0oDyq7m4yXj/MOVySY/oOtZsvM9rcllxUYvR/iJqI8
 cAUEPHE/8kGVwqpxsR8/ErnOtwxCZqmknBpzNspQHf9J/+ooF4LWnvOz0s3iDMyqfCHzV1oiSuN
 WlqxTb6TTT72+ivL2sD22+buo8n7kPIomHvSGqAyNI7s4nN+w/w9KrQ9VYclAXCtFBgt5m+tJsh
 PXCCp2ErNBfwSP2Ji2eCg1h7g4EDHZq27BZukuYp2NQT3Yg4EaNoY8qb7pQmVkZWLn3BqyWZTgt
 7vgnQ/QdjzL3mF8H5E8WqlfwNfKhAZK8z3DEutaEDOHA+v6adp+EmacDKQvVFxibvirQjNv/sNu
 +JzRc6aUT2yVYyDEwPJ+ssctpzO8huoZkHA3hIrUi1YBE723dzZDUL+dggaKAJtIoiTVKIX1EV/
 sRqZS2TFoHkWB8NXIY/O+nw5aSfYGgzZYFfOVsqyqMryoD3+3C3+47wy5cc83102aDoCOHy5jBe
 v4amK5gck9Mept4irFPMSf+B8SRkFzfGKJ1LlAwxB+ulTr+avpWz5CVQ9CfwZlaYfxbbydP7ET6
 pMrdzjr+Lcj0Ac1gLNKzwtDeXXTXejG8bX/SW9/PMBEPKy2Bsx9u57mrxtOLrFuaTZKzpWF1cil
 FdJPRsh3vWQ==
X-Received: by 2002:a17:906:c1d4:b0:c4d:2b77:681e with SMTP id
 a640c23a62f3a-c4d34c90417mr359061966b.3.1794036157337; 
 Fri, 06 Nov 2026 23:22:37 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:36 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 06/30] usb: gadget: udc: make udc-core build in U-Boot
Date: Sat,  7 Nov 2026 08:22:00 +0100
Message-ID: <20261107072224.3492260-7-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the re-imported udc-core.c to U-Boot and build it for every gadget
config. The resynced gadget.h makes usb_ep_enable() and friends real
functions and they live here now.

udc-core only sees controllers that called usb_add_gadget_udc(). Driver
model drivers do that from probe. The others have no probe at all. Add a
weak usb_gadget_udc_bringup() hook so they can bring themselves up each
time a gadget driver asks for a UDC. Report what the hook returns,
otherwise a controller that fails to come up only says "No UDC
available".

In the kernel udc_start(), udc_stop() and get_frame() are mandatory. In
U-Boot they are not, so check them before calling. Without the check a
driver that does not have them takes the board down instead of failing.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Enable async callbacks after udc_start and disable them on unbind, the
same way Linux does. The resynced dwc3 ep0 code only passes control
requests to the gadget driver when dwc->async_callbacks is set, so
without it GET_DESCRIPTOR stalls and no dwc3 board enumerates.

Drop the <linux/module.h> and <linux/device.h> includes from the
re-imported epautoconf.c. U-Boot has no linux/module.h, so no gadget
config builds without this.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/epautoconf.c   |   2 -
 drivers/usb/gadget/udc/Makefile   |   1 +
 drivers/usb/gadget/udc/udc-core.c | 931 +++++-------------------------
 include/linux/usb/gadget.h        |   3 +
 4 files changed, 153 insertions(+), 784 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4fbea9137240..5128d147c168 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -7,9 +7,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/device.h>
 
 #include <linux/ctype.h>
 #include <linux/string.h>
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
index 2af62c579cb3..a22e38a51875 100644
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
 
@@ -120,9 +105,9 @@ int usb_ep_enable(struct usb_ep *ep)
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
 	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
-		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
-			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
-
+		if (!IS_ENABLED(CONFIG_XPL_BUILD))
+			WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address,
+				  ep->name, (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -134,8 +119,6 @@ int usb_ep_enable(struct usb_ep *ep)
 	ep->enabled = true;
 
 out:
-	trace_usb_ep_enable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_enable);
@@ -168,8 +151,6 @@ int usb_ep_disable(struct usb_ep *ep)
 	ep->enabled = false;
 
 out:
-	trace_usb_ep_disable(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_disable);
@@ -191,13 +172,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
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
 
@@ -213,7 +188,6 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	trace_usb_ep_free_request(ep, req, 0);
 	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
@@ -301,8 +275,6 @@ int usb_ep_queue(struct usb_ep *ep,
 	ret = ep->ops->queue(ep, req, gfp_flags);
 
 out:
-	trace_usb_ep_queue(ep, req, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_queue);
@@ -326,12 +298,7 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
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
 
@@ -360,12 +327,7 @@ EXPORT_SYMBOL_GPL(usb_ep_dequeue);
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
 
@@ -386,12 +348,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_halt);
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
 
@@ -416,8 +373,6 @@ int usb_ep_set_wedge(struct usb_ep *ep)
 	else
 		ret = ep->ops->set_halt(ep, 1);
 
-	trace_usb_ep_set_wedge(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
@@ -448,8 +403,6 @@ int usb_ep_fifo_status(struct usb_ep *ep)
 	else
 		ret = -EOPNOTSUPP;
 
-	trace_usb_ep_fifo_status(ep, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
@@ -469,8 +422,6 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
 {
 	if (ep->ops->fifo_flush)
 		ep->ops->fifo_flush(ep);
-
-	trace_usb_ep_fifo_flush(ep, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
 
@@ -485,13 +436,11 @@ EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
  */
 int usb_gadget_frame_number(struct usb_gadget *gadget)
 {
-	int ret;
 
-	ret = gadget->ops->get_frame(gadget);
+	if (!gadget->ops->get_frame)
+		return -EOPNOTSUPP;
 
-	trace_usb_gadget_frame_number(gadget, ret);
-
-	return ret;
+	return gadget->ops->get_frame(gadget);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
 
@@ -520,39 +469,10 @@ int usb_gadget_wakeup(struct usb_gadget *gadget)
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
@@ -574,8 +494,6 @@ int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
 	ret = gadget->ops->set_selfpowered(gadget, 1);
 
 out:
-	trace_usb_gadget_set_selfpowered(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
@@ -602,43 +520,10 @@ int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
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
@@ -653,21 +538,10 @@ EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
  */
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-	int ret = 0;
+	if (!gadget->ops->vbus_draw)
+		return -EOPNOTSUPP;
 
-	if (!gadget->ops->vbus_draw) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ret = gadget->ops->vbus_draw(gadget, mA);
-	if (!ret)
-		gadget->mA = mA;
-
-out:
-	trace_usb_gadget_vbus_draw(gadget, ret);
-
-	return ret;
+	return gadget->ops->vbus_draw(gadget, mA);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
 
@@ -694,8 +568,6 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 	ret = gadget->ops->vbus_session(gadget, 0);
 
 out:
-	trace_usb_gadget_vbus_disconnect(gadget, ret);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
@@ -726,8 +598,6 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		gadget->connected = 1;
 
 out:
-	trace_usb_gadget_connect(gadget, ret);
-
 	return ret;
 }
 
@@ -785,8 +655,6 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 out:
-	trace_usb_gadget_disconnect(gadget, ret);
-
 	return ret;
 }
 
@@ -815,170 +683,31 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
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
@@ -992,11 +721,6 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
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
@@ -1112,71 +836,13 @@ EXPORT_SYMBOL_GPL(usb_gadget_check_config);
 
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
@@ -1219,6 +885,9 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 		return -EBUSY;
 	}
 
+	if (!udc->gadget->ops->udc_start)
+		return -EOPNOTSUPP;
+
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 	if (!ret)
 		udc->started = true;
@@ -1247,7 +916,8 @@ static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
 		return;
 	}
 
-	udc->gadget->ops->udc_stop(udc->gadget);
+	if (udc->gadget->ops->udc_stop)
+		udc->gadget->ops->udc_stop(udc->gadget);
 	udc->started = false;
 }
 
@@ -1325,6 +995,38 @@ static inline void usb_gadget_disable_async_callbacks(struct usb_udc *udc)
 		gadget->ops->udc_async_callbacks(gadget, false);
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
+	usb_gadget_enable_async_callbacks(udc);
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
  * usb_udc_release - release the usb_udc struct
  * @dev: the dev member within usb_udc
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
@@ -1522,409 +1158,140 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
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
+	usb_gadget_disable_async_callbacks(udc);
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
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
 
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
-
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
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-
-	if (sysfs_streq(buf, "1"))
-		usb_gadget_wakeup(udc->gadget);
-
-	return n;
-}
-static DEVICE_ATTR_WO(srp);
-
-static ssize_t soft_connect_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t n)
-{
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	ssize_t			ret;
-
-	device_lock(&udc->gadget->dev);
-	if (!udc->driver) {
-		dev_err(dev, "soft-connect without a gadget driver\n");
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
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
-	}
-
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
+/*
+ * u-boot: a controller that is not a driver model device has no probe of its
+ * own, so it never calls usb_add_gadget_udc(). Such drivers implement this
+ * hook and bring themselves up each time a gadget driver asks for a UDC.
+ */
+__weak int usb_gadget_udc_bringup(void)
 {
-	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
-	struct usb_gadget_driver *drv;
-	int			rc = 0;
-
-	mutex_lock(&udc_lock);
-	drv = udc->driver;
-	if (drv && drv->function)
-		rc = scnprintf(buf, PAGE_SIZE, "%s\n", drv->function);
-	mutex_unlock(&udc_lock);
-	return rc;
+	return 0;
 }
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
 
-static const struct attribute_group *usb_udc_attr_groups[] = {
-	&usb_udc_attr_group,
-	NULL,
-};
-
-static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
-	const struct usb_udc	*udc = container_of(dev, struct usb_udc, dev);
+	struct usb_udc		*udc = NULL;
+	unsigned int		udc_count = 0;
 	int			ret;
 
-	ret = add_uevent_var(env, "USB_UDC_NAME=%s", udc->gadget->name);
-	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_NAME\n");
-		return ret;
-	}
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
 
-	mutex_lock(&udc_lock);
-	if (udc->driver)
-		ret = add_uevent_var(env, "USB_UDC_DRIVER=%s",
-				udc->driver->function);
-	mutex_unlock(&udc_lock);
+	ret = usb_gadget_udc_bringup();
 	if (ret) {
-		dev_err(dev, "failed to add uevent USB_UDC_DRIVER\n");
+		if (!IS_ENABLED(CONFIG_XPL_BUILD))
+			printf("UDC bringup failed: %d\n", ret);
 		return ret;
 	}
 
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
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list) {
+		udc_count++;
 
-	rc = class_register(&udc_class);
-	if (rc)
-		return rc;
+		/* For now we take the first one */
+		if (!udc->driver)
+			goto found;
+	}
 
-	rc = bus_register(&gadget_bus_type);
-	if (rc)
-		class_unregister(&udc_class);
-	return rc;
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		if (!udc_count)
+			printf("No UDC available in the system\n");
+		else
+			/* When this happens, users should 'unbind <class> <index>'
+			 * using the output of 'dm tree' and looking at the line right
+			 * after the USB peripheral/device controller.
+			 */
+			printf("All UDCs in use (%d available), use the unbind command\n",
+			       udc_count);
+	}
+	mutex_unlock(&udc_lock);
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

