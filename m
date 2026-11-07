Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F9606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kZCYgz6w;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cfdVmskW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D0BA8156E;
	Sat,  7 Nov 2026 12:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3nDXvywa9yT; Sat,  7 Nov 2026 12:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7529814AB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055810;
	b=AGkGs5EWvWgGY1gQYNvt4pFUtGxdudWX0Y6wR7YSDjqXpEtT4Sedd9ZaCdooXjeIW54T
	 D6URfBvc5Cisn+I2m+8Rm0fAnap89eSQdB10uJJZKVHlmJg/7K64jnEX2UuHD1l9CDCMz
	 pqfs0Sj4rEUls2zKR4vQ6djFXHc6EJPOKrMBIGSMKPZAAyXCqZ6lc1A+UIMY0aBkRi2Py
	 AMnaIi0Vq7ILOQABQBPDfNE3c0qCQMr6FLnmzLbt8XsOEYyIT/RGt2JJmvwOINdNIRqLw
	 vNVxKGv9ZIxY0brx7v76hiPPLQ12d4abmGIXqaDJKNIPwdqi5Hae0607QybV2ny6hDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Iu/Fmjy5z08BQcLf5yDWOcWZnYPhiDTLMhBHQLXRtec=;
	b=FdK4yTSNdlWuMDzUXD0LJASaC/Vrf3aIGa5fJ2VtADjnWO60GJIahn3W0vWqoc9Ohaov
	 qO+KHbAYARLn0zuXkPHBOaHR8c0z9/r1inYYIVf8KAHDKxEX0zBxEX9lf6KWU4+jGL/Ha
	 yHCtz0gE063jwD+aulXXWsZ+Pmmz92/0Y35DWjcTznvhgJ3yTQ2gRVeVcJMfNa0/AznFR
	 Om7EnGVDvQyFWjtpiIDRFwm0A+d2+KH941TZszI5ujn295CGgFiGkWgzL1L8RvnxNz8UQ
	 nu3w2bKB3KxBdfpPIdx+0pa1WZAOZheHU8BeUknJ2xjqdQ4WXf/JrzaXGwkxcNMRXog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055810;
	bh=Iu/Fmjy5z08BQcLf5yDWOcWZnYPhiDTLMhBHQLXRtec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZCYgz6whpMZqi5WgD++ecsdbcWDM3c+AYes34E+4H/X22aY5QwtnlYCOY4I1yhoe
	 Hg7jdlH1Y4fZbWdzEs4dhtPIlNg9HePmh8Bl8pcGmQxWkrV4IFpi9rCERvFwPNrdVB
	 RoZrFeTJPY5lN+IzJWOiT6nf1TRr7f4mub/VvUHtaqHVHd3KVUf5bgNsok2bBcuawf
	 Z8TVyLFGKV4dkFWHTqrPCjgWZegWwuylblcGqDfb2f2Q2Iv+QbLWoUyCj8zFByFYpO
	 dn4xyjy0xrN4pJ82PjOSvUG0zT1OOdr7Odzy4U6Z6I0jwXCvdZDdee8No7qmldqe9E
	 9oCZ501GO+OSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7529814AB;
	Sat,  7 Nov 2026 12:50:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BF9931F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61EBA40800
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xlg5-pbujj8G for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCACC407EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cfdVmskW
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCACC407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:17 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b5816be7d0so189459a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036195; x=1794640995;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iu/Fmjy5z08BQcLf5yDWOcWZnYPhiDTLMhBHQLXRtec=;
 b=cfdVmskWZHuQs4qm+7aw0bEaWbOV3md2/iBrxB5XtTbINPHSHN3ALZKzl4TqCZHcmQ
 79DN38hV809Ug0NsGNaoABTCHZ+207K7lVKtPNAg/JA9D4FW2KFSsBav3VUdKmTTjtMP
 kw5FtMlQUpL0wPW/WMPoOfsx+LTz4KZlcYbhiT5/0+u5zjuNfpqH13lVLSrG9TLZtr6O
 5eA8rZAOANo3nXW0psZI9ZL3Ih1QRU/pi25m2hHWOyAt8gKLwqDrHV3m0P0mcFULZkk1
 aMD5nBHXiPPad9ggGEdiWeKV9iSHguxFmNCe24uLsFHASkDJW6tBzh4Cs2icWBZV70JG
 ICUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036195; x=1794640995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iu/Fmjy5z08BQcLf5yDWOcWZnYPhiDTLMhBHQLXRtec=;
 b=vAaosgCWse/0C3E9VsYDpvdSSGiurFNjr6RC5HV08Tz9KU99BJChXMDRT0FkhIqqVm
 Tx9LozlVDwwrirYnseRYYLIed71dvIpK9/KfxENkGMIuyxvfLDiA5kHsX4utZvqsYynl
 8MnFFj2NYnqJDa9J64sUMzLRqcWQpMEgDvTEM0SznQdqqxtIO7rmCW+SLVTgPWRicEWs
 buIuKdtukX8uFNs+n+kmULP6rKo7FWtpafS4vI27Vv3ISDv8o3oj8S7+6SieCB3DYOGj
 yl8K0PHjpB1ADCrKvKlTqW3+IewmatLIVltrKR+SLFZj9oB5LCuEp3kzWcQeN86UoDjA
 aeOQ==
X-Gm-Message-State: APuU4Z/bLACqh79mrF3PwWr1yD+JMQvg2vh1cJwngeOSLsHeQJLt77Eg
 wNBcFs/DwRL6HJR03sxccu3GAarvwPOBS4ZWagOYSWwx5HWuwIVOW/RjEyoDDEmw7MIC8tFAJKw
 TcJ1D
X-Gm-Gg: AYBFou1THcAWwy21sTzlKGADmo2x0jzi5RrZaUXjgjK+Kx8ShUClr/aEra38rlqC+rg
 kbAVSww8+1Bzh80/J67OEU276uwStOpySFlUXfreVWxP61IhIK8VLV/p9xG21rk59OzJ5pjlY1/
 JrN5AjUUpZb2DiygwVWFB9p8rD1bazNt3puV/vYi78joBW/Tki9Q59rhysgIjaMXqHXn6KzGPMH
 +hSOg/tJuAoWMEwFi/+dZ+tUgsVvEV2iCUTJaOxZsBc74z3ZM9gdsCZOZvwkD0u6brl9qpHFM+g
 cSfjAZc7q1mejTj5aLFGhT8gYDdlMZPG5zPYWbmXA6nOjPc6vzJfS5E29mJZKlufFe8ImwW04dR
 1HFJl9MztdChmpbMuJHybTuRU8tw654G/0uvqA9FU/+t+6lXci9GBcPYOVwNjNsCakt6fbEiSex
 39H/Z1p6fUkJYRPlgPjNmKjkQFv4Y+j1XcKRV+nIq9la8MyOdy/hRafFwXjAbFfMsME5UO2yyFQ
 /AfEFx2fkgEfJ0SVFE75j5lOkDJsXxpHOhFR9MHoe1EVHgOn02sQ2tSzdvMCdAjcwChHyq/xJz+
 U6ZFL5rmnimWnQZ4XQSCGD51N3O/M2ukZPDRdSKaGpEQ2szTLGgAVURoHczl5ArCAkQQbBivQT4
 5cyWGoOQrbQ==
X-Received: by 2002:aa7:c1d3:0:b0:6b1:b5b8:b695 with SMTP id
 4fb4d7f45d1cf-6b597476470mr3669870a12.0.1794036195432; 
 Fri, 06 Nov 2026 23:23:15 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:15 -0800 (PST)
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
Subject: [PATCH v11 10/30] usb: dwc3: core: adapt to the U-Boot APIs
Date: Sat,  7 Nov 2026 08:22:04 +0100
Message-ID: <20261107072224.3492260-11-anders.roxell@linaro.org>
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

Make the resynced core build with the U-Boot APIs. Most of it is
renames, like struct udevice and generic_phy_*().

The old U-Boot functions need a few changes.

dwc3_init() and dwc3_uboot_init() count the ports, like
dwc3_core_probe() in Linux. U-Boot does not fill in xhci_resources, so
dwc3_get_num_ports() reads the xHCI registers right below dwc->regs
instead.

They also call dwc3_core_is_valid() and set gsbuscfg0_reqinfo to
unspecified, as dwc3_core_probe() does. Without that the IP and
revision stay 0, so every version check is false, and
dwc3_config_soc_bus() clears the GSBUSCFG0 REQINFO bits.

dwc3_init() inits the locks. dwc3_uboot_init() uses do_fifo_resize, the
new name for needs_fifo_resize. dwc3_remove() no longer frees dwc->mem,
since it is always NULL there.

dwc3_uboot_init() has no udevice, so dwc3_set_incr_burst_type() returns
early there instead of reading the DT through a NULL pointer. The old
code did not set the INCR burst on that path either.

Linux leaves evt and evt->cache to devm. Without DEVRES,
devm_kzalloc() is plain kzalloc() and nothing frees them, so
dwc3_free_one_event_buffer() frees both with devm_kfree().

Keep two U-Boot fixes the resync dropped. dwc3_core_soft_reset() waits
100ms at the end, from commit 6de333b5caf0 ("drivers: usb: dwc3: Add
delay after core soft reset"), for SC7280/QCM6490. The resynced
gadget.c also calls it on soft connect, so a pullup now waits too.
dwc3_core_exit_mode() sets RUN_STOP and waits 100ms, from commit
bbe3d4a6c14e ("usb: dwc3: switch to peripheral mode when exiting"), so
the PHY on K2 can suspend before the clock goes off.

phy_set_mode_ext() is a static stub. The old core.c did not set the PHY
mode either.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 173 ++++++++++++++++++++++++----------------
 drivers/usb/dwc3/core.h |  27 ++-----
 2 files changed, 113 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0684a461e7f9..bb86b573c056 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,41 +8,38 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <linux/clk.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/list.h>
+#include <clk.h>
+#include <cpu_func.h>
+#include <malloc.h>
+#include <dwc3-uboot.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/acpi.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/devinfo.h>
-#include <linux/reset.h>
-#include <linux/bitfield.h>
-
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <reset.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb/of.h>
-#include <linux/usb/otg.h>
+#include <linux/bitfield.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+
+#include <version.h>
 
 #include "core.h"
 #include "gadget.h"
 #include "glue.h"
 #include "io.h"
 
-#include "debug.h"
 #include "../host/xhci-ext-caps.h"
 
+#define msleep(a) udelay(a * 1000)
+
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
 static LIST_HEAD(dwc3_list);
@@ -166,6 +163,8 @@ done:
 	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
 		msleep(50);
 
+	msleep(100);
+
 	return 0;
 }
 
@@ -274,7 +273,9 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(evt->buf);
+	devm_kfree((struct udevice *)dwc->dev, evt->cache);
+	devm_kfree((struct udevice *)dwc->dev, evt);
 }
 
 /**
@@ -290,18 +291,19 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 {
 	struct dwc3_event_buffer	*evt;
 
-	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
+	evt = devm_kzalloc((struct udevice *)dwc->dev, sizeof(*evt), GFP_KERNEL);
 	if (!evt)
 		return ERR_PTR(-ENOMEM);
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->cache	= devm_kzalloc(dwc->dev, length, GFP_KERNEL);
+	evt->cache	= devm_kzalloc((struct udevice *)dwc->dev, length,
+				       GFP_KERNEL);
 	if (!evt->cache)
 		return ERR_PTR(-ENOMEM);
 
-	evt->buf	= dma_alloc_coherent(dwc->sysdev, length,
-			&evt->dma, GFP_KERNEL);
+	evt->buf	= dma_alloc_coherent(length,
+					     (unsigned long *)&evt->dma);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
@@ -617,13 +619,13 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 	usb_phy_init(dwc->usb3_phy);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_init(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_init(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_exit_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_init(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_init(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_exit_usb3_phy;
 	}
@@ -651,11 +653,11 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 
 err_exit_usb3_phy:
 	while (--j >= 0)
-		phy_exit(dwc->usb3_generic_phy[j]);
+		generic_phy_exit(dwc->usb3_generic_phy[j]);
 
 err_exit_usb2_phy:
 	while (--i >= 0)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -668,10 +670,10 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_exit(dwc->usb3_generic_phy[i]);
+		generic_phy_exit(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -687,13 +689,13 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		ret = generic_phy_power_on(dwc->usb2_generic_phy[i]);
 		if (ret < 0)
 			goto err_power_off_usb2_phy;
 	}
 
 	for (j = 0; j < dwc->num_usb3_ports; j++) {
-		ret = phy_power_on(dwc->usb3_generic_phy[j]);
+		ret = generic_phy_power_on(dwc->usb3_generic_phy[j]);
 		if (ret < 0)
 			goto err_power_off_usb3_phy;
 	}
@@ -702,11 +704,11 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
 err_power_off_usb3_phy:
 	while (--j >= 0)
-		phy_power_off(dwc->usb3_generic_phy[j]);
+		generic_phy_power_off(dwc->usb3_generic_phy[j]);
 
 err_power_off_usb2_phy:
 	while (--i >= 0)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -719,10 +721,10 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_power_off(dwc->usb3_generic_phy[i]);
+		generic_phy_power_off(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -848,7 +850,7 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 /* set global incr burst type configuration registers */
 static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	/* incrx_mode : for INCR burst type. */
 	bool incrx_mode;
 	/* incrx_size : for size of INCRX burst. */
@@ -859,6 +861,9 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	int ret;
 	int i;
 
+	if (!dev)
+		return;
+
 	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
 
 	/*
@@ -1089,9 +1094,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
+	 * out which U-Boot version a bug was found.
 	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+	dwc3_writel(dwc->regs, DWC3_GUID, U_BOOT_VERSION_NUM);
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
@@ -1109,13 +1114,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->ulpi_ready = true;
 	}
 
-	if (!dwc->phys_ready) {
-		ret = dwc3_core_get_phy(dwc);
-		if (ret)
-			goto err_exit_ulpi;
-		dwc->phys_ready = true;
-	}
-
 	ret = dwc3_phy_init(dwc);
 	if (ret)
 		goto err_exit_ulpi;
@@ -1280,9 +1278,17 @@ err_exit_ulpi:
 	return ret;
 }
 
+static int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
+{
+	/* TODO */
+	return -ENOSYS;
+}
+#define phy_set_mode(phy, mode) \
+	phy_set_mode_ext(phy, mode, 0)
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	int ret;
 	int i;
 
@@ -1290,8 +1296,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
@@ -1302,8 +1306,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
 		for (i = 0; i < dwc->num_usb2_ports; i++)
 			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
 		for (i = 0; i < dwc->num_usb3_ports; i++)
@@ -1354,6 +1356,10 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
+
+	/* K2 needs the PHY suspended before the USB clock is turned off */
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_RUN_STOP);
+	msleep(100);
 }
 
 #define DWC3_ALIGN_MASK		(16 - 1)
@@ -1373,14 +1379,7 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	u32 offset;
 	u32 val;
 
-	/*
-	 * Remap xHCI address space to access XHCI ext cap regs since it is
-	 * needed to get information on number of ports present.
-	 */
-	base = ioremap(dwc->xhci_resources[0].start,
-		       resource_size(&dwc->xhci_resources[0]));
-	if (!base)
-		return -ENOMEM;
+	base = dwc->regs - DWC3_GLOBALS_REGS_START;
 
 	offset = 0;
 	do {
@@ -1406,8 +1405,6 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
 		dwc->num_usb2_ports, dwc->num_usb3_ports);
 
-	iounmap(base);
-
 	if (dwc->num_usb2_ports > DWC3_USB2_MAX_PORTS ||
 	    dwc->num_usb3_ports > DWC3_USB3_MAX_PORTS)
 		return -EINVAL;
@@ -1415,6 +1412,24 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_count_ports(struct dwc3 *dwc)
+{
+	unsigned int hw_mode;
+
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
+		return dwc3_get_num_ports(dwc);
+
+	dwc->num_usb2_ports = 1;
+	dwc->num_usb3_ports = 1;
+
+	return 0;
+}
+
 #if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
 int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
 {
@@ -1548,8 +1563,22 @@ int dwc3_init(struct dwc3 *dwc)
 	int ret;
 	u32 reg;
 
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		return -ENODEV;
+	}
+
 	dwc3_cache_hwparams(dwc);
 
+	ret = dwc3_count_ports(dwc);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
+
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
@@ -1618,7 +1647,6 @@ void dwc3_remove(struct dwc3 *dwc)
 	dwc3_free_event_buffers(dwc);
 	dwc3_core_stop(dwc);
 	dwc3_core_exit(dwc);
-	kfree(dwc->mem);
 }
 #endif
 
@@ -1676,7 +1704,7 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	if (dwc3_dev->hird_threshold)
 		hird_threshold = dwc3_dev->hird_threshold;
 
-	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->do_fifo_resize = dwc3_dev->tx_fifo_resize;
 	dwc->dr_mode = dwc3_dev->dr_mode;
 
 	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
@@ -1712,8 +1740,19 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 
 	dwc->index = dwc3_dev->index;
 
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		return -ENODEV;
+	}
+
 	dwc3_cache_hwparams(dwc);
 
+	ret = dwc3_count_ports(dwc);
+	if (ret)
+		return ret;
+
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c4d7bae2e5f..a9473e9d34b9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -11,27 +11,13 @@
 #ifndef __DRIVERS_USB_DWC3_CORE_H
 #define __DRIVERS_USB_DWC3_CORE_H
 
-#include <linux/device.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
 #include <linux/ioport.h>
-#include <linux/list.h>
 #include <linux/bitops.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
-#include <linux/debugfs.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/role.h>
-#include <linux/ulpi/interface.h>
-
-#include <linux/phy/phy.h>
-
-#include <linux/power_supply.h>
+#include <linux/usb/phy.h>
 
 /*
  * DWC3 Multiport controllers support up to 15 High-Speed PHYs
@@ -745,7 +731,6 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -1178,7 +1163,6 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
 	struct dwc3_request	ep0_usb_req;
-	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
@@ -1186,8 +1170,11 @@ struct dwc3 {
 	/* mode switching lock */
 	struct mutex		mutex;
 
+#if defined(__UBOOT__) && CONFIG_IS_ENABLED(DM_USB)
+	struct udevice		*dev;
+#else
 	struct device		*dev;
-	struct device		*sysdev;
+#endif
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
@@ -1195,7 +1182,7 @@ struct dwc3 {
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	*gadget;
+	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
 	struct clk		*bus_clk;
@@ -1204,7 +1191,7 @@ struct dwc3 {
 	struct clk		*utmi_clk;
 	struct clk		*pipe_clk;
 
-	struct reset_control	*reset;
+	struct reset_ctl	*reset;
 
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
-- 
2.53.0

