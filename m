Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B72606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HB3WqW+F;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EadSUDB1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C14740871;
	Wed, 28 Oct 2026 14:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ET3zcZSMlsJl; Wed, 28 Oct 2026 14:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21927408B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198897;
	b=c8azud23HooLFbj3vxjxsVQRMd/IFrbwyOKwS12FF14/O3mlegeUEaDVavggyk/67mj3
	 MARr9MHgF5Noo9COJqhsaC41mwEgzDT8seKbjT+FxL1R34ewMAj6WB2ZnOVg72q+71v3m
	 a2hh92UqKujm7nKuDW7w7HwetsEI3EDu3OZxrXiAcOsgUt/YvQicPW5WqBtw8bmupvMJS
	 SsaQ5qMNR4m9And/cESuuaBdwDZw6trjEw1NkKl7Y8K2bPPpZyC3zmvMSodF3icrWdYXa
	 xhPftDl32tQvrfEpBD6YtYSbYr6XlX9s1vohXiX5NDbGzM1inUWBMQPX+YfIvc6k6nA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qjsYnsciBbEEPdK19cQGPOCnc1YwQl78tcDeK7bJPgs=;
	b=Dbed5v4x76ifXMjpsySf1Dmjqan8dCqzZc2wUxgL/EkczsS5LD/lNsUMmm8279gX/Yyj
	 7wnUHAMZtem4aUAQMQOBEG5eKvlbAwIEb3N68fFem8suiqyfk8YtSCb5Ij3xlgroRlQDe
	 GNF7O1Oki6Zv+C0M1toDX4LwmSrw9B7oaiZCdhZrDwytiLVO5oigTZCEYa08xqzFkwY4i
	 hw3zINaxYlhHWXFu9lgaAFjcq9gS4uPqXSUZ9TxsD/wiMZ5mBwS+nPPlNdAoRa9oT8oVf
	 KZKTVD5ZT4etXwZc62MUuPb6ykCR9bVnEznhYxFUzoxhuR1i1YlhBTr+O7lz9fv7KDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EadSUDB1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198897;
	bh=qjsYnsciBbEEPdK19cQGPOCnc1YwQl78tcDeK7bJPgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HB3WqW+FYLGArA4NCFdc4YL2xty3rTlAD5gMz4P4WDNtZ+hVoytrE70QHDk0bNwmA
	 z9ibuXmBhKjYESesdO/3tRWUK1ga8liH/zlx0Hx2znNJ75qn7tI5L0rog5yEN15mcw
	 Skmu1vkqjG7Y+KYbCt+RcoMM4UPgbj2jQMryws9SN26dP5XGcM+z7q81eiL2NPQ1ln
	 6qHmsAyTSs8QHh+S2Xr7KX/CJjZx7W6TFv3CdFv5NVxb7QG17qi3rl5J5X9+Pb7xam
	 2QzJCtRU8aNUGNb3pacQefzbMN1z+P81XcV+Bb4odiaLmHaP997A+swGXajqenSqJ9
	 3gTDi+fGncg0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21927408B3;
	Wed, 28 Oct 2026 14:48:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D9734529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA44140557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSd_0XHTvvi8 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1E2A40550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197012;
 b=Q5Pb+pcWelVuZl4WoJi43w3bf52D9AMfC8tD6Lib3gZqic95SlDI4lL7F3F7h5Hmax/3
 LFhVOs7OudAtkcbCZMt4bWyOBojU8d38m7mKag8dP/L4pVVT84FkZ6azkTT+qXg3ZS8VN
 395b+uQH8SFHxhi+a89B/WvwgWsMpz7sfSJDQjblyjUe0ezAUXNijrXS9xN9DYKEFb8Gy
 sVZGxVDjslSBDYEKTFS3UjdhZv4lKQFHYOWKOdbrvZ6hEfMVXm227yhP0Vb1eKQk7kJ1O
 8dv/PVGwh99mmfS5Oe5dnSmfObmixEDk9gAZPPb02SKdVyQ6oJ/MtwLeO3RScxDUt7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qjsYnsciBbEEPdK19cQGPOCnc1YwQl78tcDeK7bJPgs=;
 b=InBfwi6zp03s9zjSeY0FvvBFYSpTeZleCpZCu14dCeG/WhFZEqc1rAAn31aFQgyNlnL9
 l7Txc59tNYV1KXZgO8YOcwUOGHagpg3UUZ1FS5TXPamTYFvKbb8sWtVQUqsV1scA0fSX7
 czr26So2mdeTj/hlx/si4gPmkJCHc/+/fEqiKRHnj3lg1ykHXxICxxmSESemSv1qgLNTJ
 BALoIUXTEya8z/JA6S682GFHcv59w8U+xow9C8RhMHepNHHeu9pRfv38ecCDXAFFTRIVq
 eJQtENLAESlAx8wnI4C1K7VkEUnw82L7n6rH5ZmYH89TLVFG7vJGcVFmSvJkBtb2w/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EadSUDB1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EadSUDB1
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1E2A40550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:51 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2af2ae1258so12005966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197010; x=1793801810;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qjsYnsciBbEEPdK19cQGPOCnc1YwQl78tcDeK7bJPgs=;
 b=EadSUDB1chJ2T1nZ1hX1PIfb8L/DbCwb/SDqggVdSIf5wHziODW70w1GVp6maLpLph
 1aVTziYJr5PO0BlaIcf7ohlZ43Aae1uJy4XR5kro4J88/FYUrSmX6ey4NYehKHRz5wc8
 grvWf4dArCN3Q0YnoJ7FwZgQNeznxzrW4UJjPC4uPJfuqkmdHd6gbI1mOQ7z3uxGnz3c
 W6Kd/bX8l6w3KWYUETBbd4GXZvoiASiX/Q585T+naSLawQY2eK7U8jmr8+pGMmoFmfqL
 ZtEx+gu+aBideGMdnxsmFyGs/ghpVoKscNVnzmwmeqI+WRy6dYqA2+FgntIXSWKsRpqO
 sRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197010; x=1793801810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qjsYnsciBbEEPdK19cQGPOCnc1YwQl78tcDeK7bJPgs=;
 b=W6Awst7v879aTGI6l1IV/ijchY0nBRvfdKu3Nv2MM4p67uA8T5GJeLYfu84ZGDRzt9
 qdHwwMxIlOoXM7rU57ju7Scc6bnej9Alj7/T/qor75ANESYxA4s3soh/LgGpBbmwvCKJ
 qA+slT/ybCd5YN9/8ztsmOoAdEBj1CJXirGYHZKAvN0MgOp/Ptpd4RZHZB9ioEF/LZ7h
 MrYosSP6U5/IdyZIaCotJymoYap3nz+J9oLl3EjvLCGm+piyiaGoRMgWBOU/BNpiLk50
 Mqpbj64jvq3bGrOhvW7+MGkkAO4VNDmh5HCJEG7hV9Iog07Yyxu6id12OiHsJP6T28pm
 ZArw==
X-Gm-Message-State: AFq9FYLnCDnFrji5W3bu6/ksXDR24h8/lGXWBdtNYPRNX/TOqxIj0yU0
 WRP8pAhLocX43eZoHxMXzLo9ooJ0MpkGkXcgwWvBzVfyCVQomyXVkJcb9zPbfisH2Duoi1lkw8k
 yfNHr
X-Gm-Gg: AYBFou33BBOnxkE06G9cU/olC3dV7ZxIxmcQSrKcfzcIgWMY8lWVJRZYxmO4zJ5kmKh
 B4ePBWfy13XNfAUYhcl+AM3/BiMr4OO5D353KvDM/aqojlsmqe5jjy4+FsSp7Ji2XvVNNEeyUhu
 IqTuv4i+KxDW/zJLclVvvObbibYrBx+h5ieV/XLY6rv03W6gbHsE3DfGuBSrDVLDbH4GPjGhTSg
 WF5RB9buXWYWJEBjgvM1ULjLlbP02wx8x4oWyMTIMGPtJmUp87LraZvy/H2EbkD9QxphMt9vu2M
 A93o5p5sZpbmz2yHgPidT3tLmka6Q/yvECmGoVqI1Xd6rm9mF1fKG8+grewhN4aOnNpuNnrNetR
 wHZjD53ezQVA/31w1cFjIbKOx2Z0a/YyYU20QLPVuHHSdoeQooWSsQkOXQkhWJq36h7ZGzgNCn0
 UmCzQdT+6/+vAHSyN4xJcK7v5Fr8CRseRpULss0H4nZhXmB8YZhSbXPLGetKkzzfEfY7SKqf7IO
 PoKZUIZbRPqTEBUEqcLRL5WxCCJRRXpy+hL8Tuy7IFDHexnaSmxGCb7tkjZeHgvBA5NOljSXRiO
 RVl4nzBUpYdQWCTsHkGf0MKjTtP3mky+6l6MQQwh0pc57AtWLQN/EmmyCY6eKYIhoE8QshblOGx
 3EIH2UVy+uw==
X-Received: by 2002:a17:906:c006:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c49bdf3daf6mr228354366b.4.1793197009522; 
 Wed, 28 Oct 2026 07:16:49 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:49 -0700 (PDT)
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
Subject: [PATCH v10 11/30] usb: dwc3: make gadget and ep0 build in U-Boot
Date: Wed, 28 Oct 2026 15:15:35 +0100
Message-ID: <20261028141554.3073545-12-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the DWC3 gadget and ep0 code to U-Boot after the resync.

Most of the diff is deletion. U-Boot has no threaded irq, no runtime pm,
no tracing and no scatterlist, so the code that needs them goes away:
dwc3_gadget_get_irq(), dwc3_nostream_work(), dwc3_prepare_trbs_sg(),
dwc3_gadget_suspend() and dwc3_gadget_resume(), the trace_ calls and the
usb_gadget_map_request() pairs. Remote wakeup goes too, nothing here asks
for it.

The event handling stays. There is no irq, so the glue driver polls
through dwc3_gadget_uboot_handle_interrupt(), which calls
dwc3_interrupt() directly. dwc3_check_event_buf() and dwc3_interrupt()
are left where the kernel has them and a forward declaration does the
job, so the diff stays readable.

Keep the SPDX license line on ep0.c, the resync import dropped it.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/ep0.c    | 109 +++---
 drivers/usb/dwc3/gadget.c | 715 +++++++-------------------------------
 drivers/usb/dwc3/gadget.h |   4 +-
 3 files changed, 181 insertions(+), 647 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..e81404e11405 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -8,22 +8,19 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bug.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/list.h>
-#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
 #include "core.h"
-#include "debug.h"
 #include "gadget.h"
 #include "io.h"
 
@@ -58,8 +55,6 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 	else
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
-
-	trace_dwc3_prepare_trb(dep, trb);
 }
 
 static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
@@ -112,7 +107,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 		direction = !!(dep->flags & DWC3_EP0_DIR_IN);
 
 		if (dwc->ep0state != EP0_DATA_PHASE) {
-			dev_WARN(dwc->dev, "Unexpected pending request\n");
+			dev_warn(dwc->dev, "Unexpected pending request\n");
 			return 0;
 		}
 
@@ -133,7 +128,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 
 		direction = !dwc->ep0_expect_in;
 		dwc->delayed_status = false;
-		usb_gadget_set_state(dwc->gadget, USB_STATE_CONFIGURED);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_CONFIGURED);
 
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
@@ -264,16 +259,8 @@ int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 {
-	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
-	unsigned long			flags;
-	int				ret;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep0_set_halt(ep, value);
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	return ret;
+	return __dwc3_gadget_ep0_set_halt(ep, value);
 }
 
 void dwc3_ep0_out_start(struct dwc3 *dwc)
@@ -282,8 +269,6 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 	int                             i;
 
-	complete(&dwc->ep0_in_setup);
-
 	dep = dwc->eps[0];
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
@@ -354,7 +339,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		/*
 		 * LTM will be set once we know how to set this in HW.
 		 */
-		usb_status |= dwc->gadget->is_selfpowered;
+		usb_status |= dwc->gadget.is_selfpowered;
 
 		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
 		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
@@ -364,7 +349,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 			if (reg & DWC3_DCTL_INITU2ENA)
 				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
 		} else {
-			usb_status |= dwc->gadget->wakeup_armed <<
+			usb_status |= dwc->gadget.wakeup_armed <<
 					USB_DEVICE_REMOTE_WAKEUP;
 		}
 
@@ -482,12 +467,12 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 
 	wValue = le16_to_cpu(ctrl->wValue);
 	wIndex = le16_to_cpu(ctrl->wIndex);
-	state = dwc->gadget->state;
+	state = dwc->gadget.state;
 
 	switch (wValue) {
 	case USB_DEVICE_REMOTE_WAKEUP:
 		if (dwc->wakeup_configured)
-			dwc->gadget->wakeup_armed = set;
+			dwc->gadget.wakeup_armed = set;
 		else
 			ret = -EINVAL;
 		break;
@@ -594,7 +579,7 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 
 static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u32 addr;
 	u32 reg;
 
@@ -615,9 +600,9 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
 	if (addr)
-		usb_gadget_set_state(dwc->gadget, USB_STATE_ADDRESS);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_ADDRESS);
 	else
-		usb_gadget_set_state(dwc->gadget, USB_STATE_DEFAULT);
+		usb_gadget_set_state(&dwc->gadget, USB_STATE_DEFAULT);
 
 	return 0;
 }
@@ -628,7 +613,7 @@ static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	if (dwc->async_callbacks) {
 		spin_unlock(&dwc->lock);
-		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		ret = dwc->gadget_driver->setup(&dwc->gadget, ctrl);
 		spin_lock(&dwc->lock);
 	}
 	return ret;
@@ -636,7 +621,7 @@ static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u32 cfg;
 	int ret;
 	u32 reg;
@@ -662,7 +647,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * to change the state on the next usb_ep_queue()
 			 */
 			if (ret == 0)
-				usb_gadget_set_state(dwc->gadget,
+				usb_gadget_set_state(&dwc->gadget,
 						USB_STATE_CONFIGURED);
 
 			/*
@@ -681,7 +666,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	case USB_STATE_CONFIGURED:
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		if (!cfg && !ret)
-			usb_gadget_set_state(dwc->gadget,
+			usb_gadget_set_state(&dwc->gadget,
 					USB_STATE_ADDRESS);
 		break;
 	default:
@@ -737,7 +722,7 @@ static void dwc3_ep0_set_sel_cmpl(struct usb_ep *ep, struct usb_request *req)
 static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
 	struct dwc3_ep	*dep;
-	enum usb_device_state state = dwc->gadget->state;
+	enum usb_device_state state = dwc->gadget.state;
 	u16		wLength;
 
 	if (state == USB_STATE_DEFAULT)
@@ -781,7 +766,7 @@ static int dwc3_ep0_set_isoch_delay(struct dwc3 *dwc, struct usb_ctrlrequest *ct
 	if (wIndex || wLength)
 		return -EINVAL;
 
-	dwc->gadget->isoch_delay = wValue;
+	dwc->gadget.isoch_delay = wValue;
 
 	return 0;
 }
@@ -830,8 +815,6 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
-	trace_dwc3_ctrl_req(ctrl);
-
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
 		dwc->three_stage_setup = false;
@@ -873,7 +856,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
 	trb = dwc->ep0_trb;
-	trace_dwc3_complete_trb(ep0, trb);
 
 	r = next_request(&ep0->pending_list);
 	if (!r)
@@ -898,7 +880,6 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	     ur->length && ur->zero) || dwc->ep0_bounced) {
 		trb++;
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-		trace_dwc3_complete_trb(ep0, trb);
 
 		if (r->direction)
 			dwc->eps[1]->trb_enqueue = 0;
@@ -925,8 +906,6 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	trb = dwc->ep0_trb;
 
-	trace_dwc3_complete_trb(dep, trb);
-
 	if (!list_empty(&dep->pending_list)) {
 		r = next_request(&dep->pending_list);
 
@@ -998,21 +977,21 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			&& (dep->number == 0)) {
 		u32	maxpacket;
 		u32	rem;
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
 		maxpacket = dep->endpoint.maxpacket;
-		rem = req->request.length % maxpacket;
+		rem = ureq->length % maxpacket;
 		dwc->ep0_bounced = true;
 
 		/* prepare normal TRB */
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-					 req->request.length,
-					 DWC3_TRBCTL_CONTROL_DATA,
-					 true);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, true);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
 
@@ -1024,17 +1003,17 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	} else if (IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
 		   req->request.length && req->request.zero) {
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
 		/* prepare normal TRB */
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-					 req->request.length,
-					 DWC3_TRBCTL_CONTROL_DATA,
-					 true);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, true);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
 
@@ -1047,14 +1026,16 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 false);
 		ret = dwc3_ep0_start_trans(dep);
 	} else {
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev,
-				&req->request, dep->number);
-		if (ret)
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
+
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
 			return;
 
-		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
-				false);
+		dwc3_ep0_prepare_one_trb(dep, ureq->dma, ureq->length,
+					 DWC3_TRBCTL_CONTROL_DATA, false);
 
 		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
 
@@ -1174,7 +1155,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 			 */
 			if (!list_empty(&dep->pending_list)) {
 				dwc->delayed_status = false;
-				usb_gadget_set_state(dwc->gadget,
+				usb_gadget_set_state(&dwc->gadget,
 						     USB_STATE_CONFIGURED);
 				dwc3_ep0_do_control_status(dwc, event);
 			}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 74968f93d4a3..b3a371df3749 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -8,14 +8,14 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <linux/kernel.h>
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
 
@@ -27,6 +27,8 @@
 #include "gadget.h"
 #include "io.h"
 
+#define usleep_range(a, b) udelay((b))
+
 #define DWC3_ALIGN_FRAME(d, n)	(((d)->frame_number + ((d)->interval * (n))) \
 					& ~((d)->interval - 1))
 
@@ -193,24 +195,21 @@ static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
 static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 		struct dwc3_request *req, int status)
 {
-	struct dwc3			*dwc = dep->dwc;
+	struct usb_request *ureq = &req->request;
+	enum dma_data_direction dir = req->direction ? DMA_TO_DEVICE :
+						       DMA_FROM_DEVICE;
 
 	list_del(&req->list);
 	req->remaining = 0;
 	req->num_trbs = 0;
 
-	if (req->request.status == -EINPROGRESS)
-		req->request.status = status;
+	if (ureq->status == -EINPROGRESS)
+		ureq->status = status;
 
 	if (req->trb)
-		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-				&req->request, req->direction);
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
 
 	req->trb = NULL;
-	trace_dwc3_gadget_giveback(req);
-
-	if (dep->number > 1)
-		pm_runtime_put(dwc->dev);
 }
 
 /**
@@ -226,8 +225,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
-	struct dwc3			*dwc = dep->dwc;
-
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
@@ -271,8 +268,6 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		status = -ETIMEDOUT;
 	}
 
-	trace_dwc3_gadget_generic_cmd(cmd, param, status);
-
 	return ret;
 }
 
@@ -324,7 +319,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget->speed <= USB_SPEED_HIGH ||
+	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
 	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
@@ -393,7 +388,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 				ret = 0;
 				break;
 			case DEPEVT_TRANSFER_NO_RESOURCE:
-				dev_WARN(dwc->dev, "No resource for %s\n",
+				dev_warn(dwc->dev, "No resource for %s\n",
 					 dep->name);
 				ret = -EINVAL;
 				break;
@@ -412,7 +407,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 				ret = -EAGAIN;
 				break;
 			default:
-				dev_WARN(dwc->dev, "UNKNOWN cmd status\n");
+				dev_warn(dwc->dev, "UNKNOWN cmd status\n");
 			}
 
 			break;
@@ -425,8 +420,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	}
 
 skip_status:
-	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
-
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
 		if (ret == 0)
 			dep->flags |= DWC3_EP_TRANSFER_STARTED;
@@ -464,7 +457,7 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 */
 	if (dep->direction &&
 	    !DWC3_VER_IS_PRIOR(DWC3, 260A) &&
-	    (dwc->gadget->speed >= USB_SPEED_SUPER))
+	    (dwc->gadget.speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
 	memset(&params, 0, sizeof(params));
@@ -482,14 +475,12 @@ static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
 
 static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 {
-	struct dwc3		*dwc = dep->dwc;
-
 	if (dep->trb_pool)
 		return 0;
 
-	dep->trb_pool = dma_alloc_coherent(dwc->sysdev,
-			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
-			&dep->trb_pool_dma, GFP_KERNEL);
+	dep->trb_pool = dma_alloc_coherent(sizeof(struct dwc3_trb) *
+					   DWC3_TRB_NUM,
+					   (unsigned long *)&dep->trb_pool_dma);
 	if (!dep->trb_pool) {
 		dev_err(dep->dwc->dev, "failed to allocate trb pool for %s\n",
 				dep->name);
@@ -501,10 +492,7 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 
 static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
-	struct dwc3		*dwc = dep->dwc;
-
-	dma_free_coherent(dwc->sysdev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
-			dep->trb_pool, dep->trb_pool_dma);
+	dma_free_coherent(dep->trb_pool);
 
 	dep->trb_pool = NULL;
 	dep->trb_pool_dma = 0;
@@ -589,7 +577,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget->speed >= USB_SPEED_SUPER) {
+	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst - 1);
@@ -644,7 +632,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
 
 		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
-		    dwc->gadget->speed == USB_SPEED_FULL)
+		    dwc->gadget.speed == USB_SPEED_FULL)
 			dep->interval = desc->bInterval;
 		else
 			dep->interval = 1 << (desc->bInterval - 1);
@@ -818,7 +806,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
-	switch (dwc->gadget->speed) {
+	switch (dwc->gadget.speed) {
 	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
@@ -1017,8 +1005,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	}
 
 out:
-	trace_dwc3_gadget_ep_enable(dep);
-
 	return 0;
 }
 
@@ -1068,8 +1054,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	u32			reg;
 	u32			mask;
 
-	trace_dwc3_gadget_ep_disable(dep);
-
 	/* make sure HW endpoint isn't stalled */
 	if (dep->flags & DWC3_EP_STALL)
 		__dwc3_gadget_ep_set_halt(dep, 0, false);
@@ -1137,9 +1121,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dev_WARN_ONCE(dwc->dev, dep->flags & DWC3_EP_ENABLED,
-					"%s is already enabled\n",
-					dep->name))
+	if (dep->flags & DWC3_EP_ENABLED)
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -1164,9 +1146,7 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dev_WARN_ONCE(dwc->dev, !(dep->flags & DWC3_EP_ENABLED),
-					"%s is already disabled\n",
-					dep->name))
+	if (!(dep->flags & DWC3_EP_ENABLED))
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -1191,8 +1171,6 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->dep	= dep;
 	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
 
-	trace_dwc3_alloc_request(req);
-
 	return &req->request;
 }
 
@@ -1201,7 +1179,6 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 
-	trace_dwc3_free_request(req);
 	kfree(req);
 }
 
@@ -1278,13 +1255,11 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	unsigned int		no_interrupt = req->request.no_interrupt;
 	unsigned int		is_last = req->request.is_last;
 	struct dwc3		*dwc = dep->dwc;
-	struct usb_gadget	*gadget = dwc->gadget;
+	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
 	if (use_bounce_buffer)
 		dma = dep->dwc->bounce_addr;
-	else if (req->request.num_sgs > 0)
-		dma = sg_dma_address(req->start_sg);
 	else
 		dma = req->request.dma;
 
@@ -1363,7 +1338,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		 * This is only possible with faulty memory because we
 		 * checked it already :)
 		 */
-		dev_WARN(dwc->dev, "Unknown endpoint type %d\n",
+		dev_warn(dwc->dev, "Unknown endpoint type %d\n",
 				usb_endpoint_type(dep->endpoint.desc));
 	}
 
@@ -1411,8 +1386,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	dwc3_ep_inc_enq(dep);
-
-	trace_dwc3_prepare_trb(dep, trb);
 }
 
 static bool dwc3_needs_extra_trb(struct dwc3_ep *dep, struct dwc3_request *req)
@@ -1468,106 +1441,6 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	return num_trbs;
 }
 
-static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
-		struct dwc3_request *req)
-{
-	struct scatterlist *sg = req->start_sg;
-	struct scatterlist *s;
-	int		i;
-	unsigned int length = req->request.length;
-	unsigned int remaining = req->num_pending_sgs;
-	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
-	unsigned int num_trbs = req->num_trbs;
-	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
-
-	/*
-	 * If we resume preparing the request, then get the remaining length of
-	 * the request and resume where we left off.
-	 */
-	for_each_sg(req->request.sg, s, num_queued_sgs, i)
-		length -= sg_dma_len(s);
-
-	for_each_sg(sg, s, remaining, i) {
-		unsigned int num_trbs_left = dwc3_calc_trbs_left(dep);
-		unsigned int trb_length;
-		bool must_interrupt = false;
-		bool last_sg = false;
-
-		trb_length = min_t(unsigned int, length, sg_dma_len(s));
-
-		length -= trb_length;
-
-		/*
-		 * IOMMU driver is coalescing the list of sgs which shares a
-		 * page boundary into one and giving it to USB driver. With
-		 * this the number of sgs mapped is not equal to the number of
-		 * sgs passed. So mark the chain bit to false if it isthe last
-		 * mapped sg.
-		 */
-		if ((i == remaining - 1) || !length)
-			last_sg = true;
-
-		if (!num_trbs_left)
-			break;
-
-		if (last_sg) {
-			if (!dwc3_prepare_last_sg(dep, req, trb_length, i))
-				break;
-		} else {
-			/*
-			 * Look ahead to check if we have enough TRBs for the
-			 * next SG entry. If not, set interrupt on this TRB to
-			 * resume preparing the next SG entry when more TRBs are
-			 * free.
-			 */
-			if (num_trbs_left == 1 || (needs_extra_trb &&
-					num_trbs_left <= 2 &&
-					sg_dma_len(sg_next(s)) >= length)) {
-				struct dwc3_request *r;
-
-				/* Check if previous requests already set IOC */
-				list_for_each_entry(r, &dep->started_list, list) {
-					if (r != req && !r->request.no_interrupt)
-						break;
-
-					if (r == req)
-						must_interrupt = true;
-				}
-			}
-
-			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
-					must_interrupt);
-		}
-
-		/*
-		 * There can be a situation where all sgs in sglist are not
-		 * queued because of insufficient trb number. To handle this
-		 * case, update start_sg to next sg to be queued, so that
-		 * we have free trbs we can continue queuing from where we
-		 * previously stopped
-		 */
-		if (!last_sg)
-			req->start_sg = sg_next(s);
-
-		req->num_pending_sgs--;
-
-		/*
-		 * The number of pending SG entries may not correspond to the
-		 * number of mapped SG entries. If all the data are queued, then
-		 * don't include unused SG entries.
-		 */
-		if (length == 0) {
-			req->num_pending_sgs = 0;
-			break;
-		}
-
-		if (must_interrupt)
-			break;
-	}
-
-	return req->num_trbs - num_trbs;
-}
-
 static int dwc3_prepare_trbs_linear(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
@@ -1602,12 +1475,6 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 	 * break things.
 	 */
 	list_for_each_entry(req, &dep->started_list, list) {
-		if (req->num_pending_sgs > 0) {
-			ret = dwc3_prepare_trbs_sg(dep, req);
-			if (!ret || req->num_pending_sgs)
-				return ret;
-		}
-
 		if (!dwc3_calc_trbs_left(dep))
 			return ret;
 
@@ -1623,22 +1490,15 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
 		struct dwc3	*dwc = dep->dwc;
+		struct usb_request *ureq = &req->request;
+		enum dma_data_direction dir = dep->direction ? DMA_TO_DEVICE
+							     : DMA_FROM_DEVICE;
 
-		ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
-						    dep->direction);
-		if (ret)
-			return ret;
+		ureq->dma = dma_map_single(ureq->buf, ureq->length, dir);
+		if (!ureq->dma)
+			return -ENOMEM;
 
-		req->start_sg		= req->request.sg;
-		req->num_pending_sgs	= req->request.num_mapped_sgs;
-
-		if (req->num_pending_sgs > 0) {
-			ret = dwc3_prepare_trbs_sg(dep, req);
-			if (req->num_pending_sgs)
-				return ret;
-		} else {
-			ret = dwc3_prepare_trbs_linear(dep, req);
-		}
+		ret = dwc3_prepare_trbs_linear(dep, req);
 
 		if (!ret || !dwc3_calc_trbs_left(dep))
 			return ret;
@@ -1917,12 +1777,12 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	if (!dwc->dis_start_transfer_quirk &&
 	    (DWC3_VER_IS_PRIOR(DWC31, 170A) ||
 	     DWC3_VER_TYPE_IS_WITHIN(DWC31, 170A, EA01, EA06))) {
-		if (dwc->gadget->speed <= USB_SPEED_HIGH && dep->direction)
+		if (dwc->gadget.speed <= USB_SPEED_HIGH && dep->direction)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
 
 	if (desc->bInterval <= 14 &&
-	    dwc->gadget->speed >= USB_SPEED_HIGH) {
+	    dwc->gadget.speed >= USB_SPEED_HIGH) {
 		u32 frame = __dwc3_gadget_get_frame(dwc);
 		bool rollover = frame <
 				(dep->frame_number & DWC3_FRNUMBER_MASK);
@@ -1986,13 +1846,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				dep->name, &req->request))
 		return -EINVAL;
 
-	pm_runtime_get(dwc->dev);
-
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 
-	trace_dwc3_ep_queue(req);
-
 	list_add_tail(&req->list, &dep->pending_list);
 	req->status = DWC3_REQUEST_STATUS_QUEUED;
 
@@ -2038,17 +1894,8 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
 
-	unsigned long			flags;
-
-	int				ret;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_queue(dep, req);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
+	return __dwc3_gadget_ep_queue(dep, req);
 }
 
 static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
@@ -2124,8 +1971,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long			flags;
 	int				ret = 0;
 
-	trace_dwc3_ep_dequeue(req);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	list_for_each_entry(r, &dep->cancelled_list, list) {
@@ -2270,34 +2115,21 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
-
-	unsigned long			flags;
-
-	int				ret;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	return ret;
+	return __dwc3_gadget_ep_set_halt(dep, value, false);
 }
 
 static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
-	struct dwc3			*dwc = dep->dwc;
-	unsigned long			flags;
 	int				ret;
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	dep->flags |= DWC3_EP_WEDGE;
 
 	if (dep->number == 0 || dep->number == 1)
 		ret = __dwc3_gadget_ep0_set_halt(ep, 1);
 	else
 		ret = __dwc3_gadget_ep_set_halt(dep, 1, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
 }
@@ -2422,7 +2254,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dwc->gadget->wakeup_armed) {
+	if (!dwc->gadget.wakeup_armed) {
 		dev_err(dwc->dev, "not armed for remote wakeup\n");
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
@@ -2436,63 +2268,10 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc);
 
-static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
-{
-	struct  dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-	int			ret;
-	int			link_state;
-
-	if (!dwc->wakeup_configured) {
-		dev_err(dwc->dev, "remote wakeup not configured\n");
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	/*
-	 * If the link is in U3, signal for remote wakeup and wait for the
-	 * link to transition to U0 before sending device notification.
-	 */
-	link_state = dwc3_gadget_get_link_state(dwc);
-	if (link_state == DWC3_LINK_STATE_U3) {
-		dwc->wakeup_pending_funcs |= BIT(intf_id);
-		ret = __dwc3_gadget_wakeup(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return ret;
-	}
-
-	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
-					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
-					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
-	if (ret)
-		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return ret;
-}
-
-static int dwc3_gadget_set_remote_wakeup(struct usb_gadget *g, int set)
-{
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->wakeup_configured = !!set;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-}
-
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
 	g->is_selfpowered = !!is_selfpowered;
-	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
@@ -2611,9 +2390,6 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 	u32			timeout = 2000;
 	u32			saved_config = 0;
 
-	if (pm_runtime_suspended(dwc->dev))
-		return 0;
-
 	/*
 	 * When operating in USB 2.0 speeds (HS/FS), ensure that
 	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
@@ -2721,18 +2497,8 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * stall the transfer, and move back to the SETUP phase, so that any
 	 * pending endxfers can be executed.
 	 */
-	if (dwc->ep0state != EP0_SETUP_PHASE) {
-		reinit_completion(&dwc->ep0_in_setup);
-
-		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
-				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0) {
-			dev_warn(dwc->dev, "wait for SETUP phase timed out\n");
-			spin_lock_irqsave(&dwc->lock, flags);
-			dwc3_ep0_reset_state(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
-		}
-	}
+	if (dwc->ep0state != EP0_SETUP_PHASE)
+		dwc3_ep0_reset_state(dwc);
 
 	/*
 	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
@@ -2753,7 +2519,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
 
 	return ret;
 }
@@ -2786,44 +2552,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	dwc->softconnect = is_on;
 
-	/*
-	 * Avoid issuing a runtime resume if the device is already in the
-	 * suspended state during gadget disconnect.  DWC3 gadget was already
-	 * halted/stopped during runtime suspend.
-	 */
-	if (!is_on) {
-		pm_runtime_barrier(dwc->dev);
-		if (pm_runtime_suspended(dwc->dev))
-			return 0;
-	}
-
-	/*
-	 * Check the return value for successful resume, or error.  For a
-	 * successful resume, the DWC3 runtime PM resume routine will handle
-	 * the run stop sequence, so avoid duplicate operations here.
-	 */
-	ret = pm_runtime_get_sync(dwc->dev);
-	if (!ret || ret < 0) {
-		pm_runtime_put(dwc->dev);
-		if (ret < 0)
-			pm_runtime_set_suspended(dwc->dev);
-		return ret;
-	}
-
-	if (dwc->pullups_connected == is_on) {
-		pm_runtime_put(dwc->dev);
-		return 0;
-	}
-
-	synchronize_irq(dwc->irq_gadget);
-
 	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	else
 		ret = dwc3_gadget_soft_connect(dwc);
 
-	pm_runtime_put(dwc->dev);
-
 	return ret;
 }
 
@@ -2857,7 +2590,7 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
 }
 
 static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
-static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
+static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt);
 
 /**
  * dwc3_gadget_setup_nump - calculate and initialize NUMP field of %DWC3_DCFG
@@ -3000,26 +2733,8 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-	int			ret;
-	int			irq;
 
-	irq = dwc->irq_gadget;
-	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
-			IRQF_SHARED, "dwc3", dwc->ev_buf);
-	if (ret) {
-		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
-				irq, ret);
-		return ret;
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= driver;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	if (dwc->sys_wakeup)
-		device_wakeup_enable(dwc->sysdev);
-
 	return 0;
 }
 
@@ -3033,17 +2748,9 @@ static void __dwc3_gadget_stop(struct dwc3 *dwc)
 static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-
-	if (dwc->sys_wakeup)
-		device_wakeup_disable(dwc->sysdev);
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
 	dwc->max_cfg_eps = 0;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	free_irq(dwc->irq_gadget, dwc->ev_buf);
 
 	return 0;
 }
@@ -3113,19 +2820,11 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	union power_supply_propval	val = {0};
-	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	if (!dwc->usb_psy)
-		return -EOPNOTSUPP;
-
-	val.intval = 1000 * mA;
-	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -3186,8 +2885,6 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
-	.func_wakeup		= dwc3_gadget_func_wakeup,
-	.set_remote_wakeup	= dwc3_gadget_set_remote_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
@@ -3210,7 +2907,7 @@ static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.maxburst = 1;
 	dep->endpoint.ops = &dwc3_gadget_ep0_ops;
 	if (!dep->direction)
-		dwc->gadget->ep0 = &dep->endpoint;
+		dwc->gadget.ep0 = &dep->endpoint;
 
 	dep->endpoint.caps.type_control = true;
 
@@ -3258,7 +2955,7 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget->ep_list);
+			&dwc->gadget.ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -3305,7 +3002,7 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	dep->endpoint.max_streams = 16;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-			&dwc->gadget->ep_list);
+			&dwc->gadget.ep_list);
 	dep->endpoint.caps.type_iso = true;
 	dep->endpoint.caps.type_bulk = true;
 	dep->endpoint.caps.type_int = true;
@@ -3313,50 +3010,6 @@ static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 	return dwc3_alloc_trb_pool(dep);
 }
 
-#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
-static void dwc3_nostream_work(struct work_struct *work)
-{
-	struct dwc3_ep	*dep = nostream_work_to_dep(work);
-	struct dwc3	*dwc = dep->dwc;
-	unsigned long   flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dep->flags & DWC3_EP_STREAM_PRIMED)
-		goto out;
-
-	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
-	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
-	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
-		goto out;
-	/*
-	 * If the host rejects a stream due to no active stream, by the
-	 * USB and xHCI spec, the endpoint will be put back to idle
-	 * state. When the host is ready (buffer added/updated), it will
-	 * prime the endpoint to inform the usb device controller. This
-	 * triggers the device controller to issue ERDY to restart the
-	 * stream. However, some hosts don't follow this and keep the
-	 * endpoint in the idle state. No prime will come despite host
-	 * streams are updated, and the device controller will not be
-	 * triggered to generate ERDY to move the next stream data. To
-	 * workaround this and maintain compatibility with various
-	 * hosts, force to reinitiate the stream until the host is ready
-	 * instead of waiting for the host to prime the endpoint.
-	 */
-	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
-		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
-
-		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
-	} else {
-		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-out:
-	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-}
-
 static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
@@ -3402,7 +3055,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
-	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3439,7 +3091,7 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 	u8				num;
 	int				ret;
 
-	INIT_LIST_HEAD(&dwc->gadget->ep_list);
+	INIT_LIST_HEAD(&dwc->gadget.ep_list);
 
 	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
 						 reserved_eps, ARRAY_SIZE(reserved_eps));
@@ -3503,7 +3155,6 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 
 	dwc3_ep_inc_deq(dep);
 
-	trace_dwc3_complete_trb(dep, trb);
 	req->num_trbs--;
 
 	/*
@@ -3844,7 +3495,6 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	if (event->status == DEPEVT_STREAMEVT_FOUND) {
-		cancel_delayed_work(&dep->nostream_work);
 		dep->flags |= DWC3_EP_STREAM_PRIMED;
 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		return;
@@ -3853,15 +3503,11 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
 	switch (event->parameters) {
 	case DEPEVT_STREAM_PRIME:
-		cancel_delayed_work(&dep->nostream_work);
 		dep->flags |= DWC3_EP_STREAM_PRIMED;
 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		break;
 	case DEPEVT_STREAM_NOSTREAM:
 		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
-		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
-			queue_delayed_work(system_wq, &dep->nostream_work,
-					   msecs_to_jiffies(100));
 		break;
 	}
 }
@@ -3921,7 +3567,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(dwc->gadget);
+		dwc->gadget_driver->disconnect(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3930,7 +3576,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->suspend(dwc->gadget);
+		dwc->gadget_driver->suspend(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3939,7 +3585,7 @@ static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(dwc->gadget);
+		dwc->gadget_driver->resume(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -3949,9 +3595,9 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget.speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
-		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
+		usb_gadget_udc_reset(&dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
 	}
 }
@@ -4062,20 +3708,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	dwc3_disconnect_gadget(dwc);
 
-	dwc->gadget->speed = USB_SPEED_UNKNOWN;
+	dwc->gadget.speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
-	dwc->gadget->wakeup_armed = false;
+	dwc->gadget.wakeup_armed = false;
 	dwc3_gadget_enable_linksts_evts(dwc, false);
-	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
+	usb_gadget_set_state(&dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
-
-	/*
-	 * Request PM idle to address condition where usage count is
-	 * already decremented to zero, but waiting for the disconnect
-	 * interrupt to set dwc->connected to FALSE.
-	 */
-	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -4146,7 +3785,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
-	dwc->gadget->wakeup_armed = false;
+	dwc->gadget.wakeup_armed = false;
 	dwc3_gadget_enable_linksts_evts(dwc, false);
 	dwc3_clear_stall_all_ep(dwc);
 
@@ -4174,7 +3813,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	if (DWC3_IP_IS(DWC32))
 		lanes = DWC3_DSTS_CONNLANES(reg) + 1;
 
-	dwc->gadget->ssp_rate = USB_SSP_GEN_UNKNOWN;
+	dwc->gadget.ssp_rate = USB_SSP_GEN_UNKNOWN;
 
 	/*
 	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
@@ -4188,13 +3827,13 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	switch (speed) {
 	case DWC3_DSTS_SUPERSPEED_PLUS:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget->ep0->maxpacket = 512;
-		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
 
 		if (lanes > 1)
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x2;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_2x2;
 		else
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x1;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_2x1;
 		break;
 	case DWC3_DSTS_SUPERSPEED:
 		/*
@@ -4214,27 +3853,27 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 			dwc3_gadget_reset_interrupt(dwc);
 
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
-		dwc->gadget->ep0->maxpacket = 512;
-		dwc->gadget->speed = USB_SPEED_SUPER;
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER;
 
 		if (lanes > 1) {
-			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
-			dwc->gadget->ssp_rate = USB_SSP_GEN_1x2;
+			dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+			dwc->gadget.ssp_rate = USB_SSP_GEN_1x2;
 		}
 		break;
 	case DWC3_DSTS_HIGHSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget->ep0->maxpacket = 64;
-		dwc->gadget->speed = USB_SPEED_HIGH;
+		dwc->gadget.ep0->maxpacket = 64;
+		dwc->gadget.speed = USB_SPEED_HIGH;
 		break;
 	case DWC3_DSTS_FULLSPEED:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
-		dwc->gadget->ep0->maxpacket = 64;
-		dwc->gadget->speed = USB_SPEED_FULL;
+		dwc->gadget.ep0->maxpacket = 64;
+		dwc->gadget.speed = USB_SPEED_FULL;
 		break;
 	}
 
-	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
+	dwc->eps[1]->endpoint.maxpacket = dwc->gadget.ep0->maxpacket;
 
 	/* Enable USB2 LPM Capability */
 
@@ -4313,7 +3952,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 
 	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->resume(dwc->gadget);
+		dwc->gadget_driver->resume(&dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
 
@@ -4402,7 +4041,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 	switch (next) {
 	case DWC3_LINK_STATE_U0:
-		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
+		if (dwc->gadget.wakeup_armed || dwc->wakeup_pending_funcs) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
 			dwc->suspended = false;
@@ -4469,7 +4108,6 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4485,15 +4123,13 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 	case DWC3_DEVICE_EVENT_OVERFLOW:
 		break;
 	default:
-		dev_WARN(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
+		dev_warn(dwc->dev, "UNKNOWN IRQ %d\n", event->type);
 	}
 }
 
 static void dwc3_process_event_entry(struct dwc3 *dwc,
 		const union dwc3_event *event)
 {
-	trace_dwc3_event(event->raw, dwc);
-
 	if (!event->type.is_devspec)
 		dwc3_endpoint_interrupt(dwc, &event->depevt);
 	else if (event->type.type == DWC3_EVENT_TYPE_DEV)
@@ -4558,43 +4194,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 {
 	struct dwc3_event_buffer *evt = _evt;
-	struct dwc3 *dwc = evt->dwc;
-	unsigned long flags;
-	irqreturn_t ret = IRQ_NONE;
-
-	local_bh_disable();
-	spin_lock_irqsave(&dwc->lock, flags);
-	ret = dwc3_process_event_buf(evt);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	local_bh_enable();
 
-	return ret;
+	return dwc3_process_event_buf(evt);
 }
 
-static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
+static irqreturn_t dwc3_check_event_buf(struct dwc3 *dwc)
 {
-	struct dwc3 *dwc = evt->dwc;
+	struct dwc3_event_buffer *evt;
 	u32 amount;
 	u32 count;
 
-	if (pm_runtime_suspended(dwc->dev)) {
-		dwc->pending_events = true;
-		/*
-		 * Trigger runtime resume. The get() function will be balanced
-		 * after processing the pending events in dwc3_process_pending
-		 * events().
-		 */
-		pm_runtime_get(dwc->dev);
-		disable_irq_nosync(dwc->irq_gadget);
-		return IRQ_HANDLED;
-	}
+	evt = dwc->ev_buf;
 
-	/*
-	 * With PCIe legacy interrupt, test shows that top-half irq handler can
-	 * be called again after HW interrupt deassertion. Check if bottom-half
-	 * irq event handler completes before caching new event to prevent
-	 * losing events.
-	 */
 	if (evt->flags & DWC3_EVENT_PENDING)
 		return IRQ_HANDLED;
 
@@ -4604,7 +4215,7 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		return IRQ_NONE;
 
 	if (count > evt->length) {
-		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
 			count, evt->length);
 		return IRQ_NONE;
 	}
@@ -4616,6 +4227,8 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
+
 	amount = min(count, evt->length - evt->lpos);
 	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
 
@@ -4627,43 +4240,25 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	return IRQ_WAKE_THREAD;
 }
 
-static irqreturn_t dwc3_interrupt(int irq, void *_evt)
+static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 {
-	struct dwc3_event_buffer	*evt = _evt;
-
-	return dwc3_check_event_buf(evt);
-}
-
-static int dwc3_gadget_get_irq(struct dwc3 *dwc)
-{
-	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
-	int irq;
-
-	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
-	if (irq > 0)
-		goto out;
-
-	if (irq == -EPROBE_DEFER)
-		goto out;
+	struct dwc3 *dwc = _dwc;
+	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t status;
 
-	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
-	if (irq > 0)
-		goto out;
+	spin_lock(&dwc->lock);
 
-	if (irq == -EPROBE_DEFER)
-		goto out;
+	status = dwc3_check_event_buf(dwc);
+	if (status == IRQ_WAKE_THREAD)
+		ret = status;
 
-	irq = platform_get_irq(dwc3_pdev, 0);
+	spin_unlock(&dwc->lock);
 
-out:
-	return irq;
+	return ret;
 }
 
 static void dwc_gadget_release(struct device *dev)
 {
-	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
-
-	kfree(gadget);
 }
 
 /**
@@ -4675,20 +4270,10 @@ static void dwc_gadget_release(struct device *dev)
 int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int ret;
-	int irq;
 	struct device *dev;
 
-	irq = dwc3_gadget_get_irq(dwc);
-	if (irq < 0) {
-		ret = irq;
-		goto err0;
-	}
-
-	dwc->irq_gadget = irq;
-
-	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
-					  sizeof(*dwc->ep0_trb) * 2,
-					  &dwc->ep0_trb_addr, GFP_KERNEL);
+	dwc->ep0_trb = dma_alloc_coherent(sizeof(*dwc->ep0_trb) * 2,
+					  (long *)&dwc->ep0_trb_addr);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
@@ -4701,31 +4286,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err1;
 	}
 
-	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
-			&dwc->bounce_addr, GFP_KERNEL);
+	dwc->bounce = dma_alloc_coherent(DWC3_BOUNCE_SIZE,
+					 (unsigned long *)&dwc->bounce_addr);
 	if (!dwc->bounce) {
 		ret = -ENOMEM;
 		goto err2;
 	}
 
-	init_completion(&dwc->ep0_in_setup);
-	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
-	if (!dwc->gadget) {
-		ret = -ENOMEM;
-		goto err3;
-	}
-
-
-	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
-	dev				= &dwc->gadget->dev;
-	dev->platform_data		= dwc;
-	dwc->gadget->ops		= &dwc3_gadget_ops;
-	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
-	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
-	dwc->gadget->sg_supported	= true;
-	dwc->gadget->name		= "dwc3-gadget";
-	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
-	dwc->gadget->wakeup_capable	= true;
+	usb_initialize_gadget((struct device *)dwc->dev, &dwc->gadget,
+			      dwc_gadget_release);
+	dev				= &dwc->gadget.dev;
+	dwc->gadget.ops		= &dwc3_gadget_ops;
+	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget.ssp_rate		= USB_SSP_GEN_UNKNOWN;
+	dwc->gadget.name		= "dwc3-gadget";
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -4748,8 +4322,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		dev_info(dwc->dev, "changing max_speed on rev %08x\n",
 				dwc->revision);
 
-	dwc->gadget->max_speed		= dwc->maximum_speed;
-	dwc->gadget->max_ssp_rate	= dwc->max_ssp_rate;
+	dwc->gadget.max_speed		= dwc->maximum_speed;
+	dwc->gadget.max_ssp_rate	= dwc->max_ssp_rate;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
@@ -4760,38 +4334,30 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (ret)
 		goto err4;
 
-	ret = usb_add_gadget(dwc->gadget);
+	ret = usb_add_gadget(&dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to add gadget\n");
 		goto err5;
 	}
 
 	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
-		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
+		dwc3_gadget_set_ssp_rate(&dwc->gadget, dwc->max_ssp_rate);
 	else
-		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
-
-	/* No system wakeup if no gadget driver bound */
-	if (dwc->sys_wakeup)
-		device_wakeup_disable(dwc->sysdev);
+		dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
 
 	return 0;
 
 err5:
 	dwc3_gadget_free_endpoints(dwc);
 err4:
-	usb_put_gadget(dwc->gadget);
-	dwc->gadget = NULL;
-err3:
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			dwc->bounce_addr);
+	usb_put_gadget(&dwc->gadget);
+	dma_free_coherent(dwc->bounce);
 
 err2:
 	kfree(dwc->setup_buf);
 
 err1:
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			dwc->ep0_trb, dwc->ep0_trb_addr);
+	dma_free_coherent(dwc->ep0_trb);
 
 err0:
 	return ret;
@@ -4801,48 +4367,33 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	if (!dwc->gadget)
-		return;
-
 	dwc3_enable_susphy(dwc, false);
-	usb_del_gadget(dwc->gadget);
+	usb_del_gadget_udc(&dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-	usb_put_gadget(dwc->gadget);
-	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
-			  dwc->bounce_addr);
+	usb_put_gadget(&dwc->gadget);
+	dma_free_coherent(dwc->bounce);
 	kfree(dwc->setup_buf);
-	dma_free_coherent(dwc->sysdev, sizeof(*dwc->ep0_trb) * 2,
-			  dwc->ep0_trb, dwc->ep0_trb_addr);
+	dma_free_coherent(dwc->ep0_trb);
 }
 
-int dwc3_gadget_suspend(struct dwc3 *dwc)
+/**
+ * dwc3_gadget_uboot_handle_interrupt - handle dwc3 gadget interrupt
+ * @dwc: struct dwce *
+ *
+ * Handles ep0 and gadget interrupt
+ *
+ * Should be called from dwc3 core.
+ */
+void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc)
 {
-	unsigned long flags;
-	int ret;
+	int ret = dwc3_interrupt(0, dwc);
 
-	ret = dwc3_gadget_soft_disconnect(dwc);
-	/*
-	 * Attempt to reset the controller's state. Likely no
-	 * communication can be established until the host
-	 * performs a port reset.
-	 */
-	if (ret && dwc->softconnect) {
-		dwc3_gadget_soft_connect(dwc);
-		return -EAGAIN;
-	}
+	if (ret == IRQ_WAKE_THREAD) {
+		struct dwc3_event_buffer *evt = dwc->ev_buf;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_thread_interrupt(0, evt);
 
-	return 0;
-}
-
-int dwc3_gadget_resume(struct dwc3 *dwc)
-{
-	if (!dwc->gadget_driver || !dwc->softconnect)
-		return 0;
-
-	return dwc3_gadget_soft_connect(dwc);
+		/* Clean + Invalidate the buffer after touching it */
+		dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
+	}
 }
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index d73e735e4081..095c27ffe9ce 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -17,7 +17,8 @@
 
 struct dwc3;
 #define to_dwc3_ep(ep)		(container_of(ep, struct dwc3_ep, endpoint))
-#define gadget_to_dwc(g)	(dev_get_platdata(&g->dev))
+#define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
+
 
 /* DEPCFG parameter 1 */
 #define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
@@ -120,6 +121,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
 void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
+void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
-- 
2.53.0

