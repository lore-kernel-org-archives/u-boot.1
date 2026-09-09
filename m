Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C70C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB89B60756;
	Wed,  9 Sep 2026 12:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id He7gVXER6dDz; Wed,  9 Sep 2026 12:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C7AA660769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957963;
	b=Fp71SYAKsZzjkqoB87RlDTC7ienQsVJ4CsbHIUyBIWrvUea5FTfwTQiEpZQYBTfD32AU
	 XgJV1pIhyGZ16Dvp//MgwKW1gWpCqgf/DGyvrtC250fgfmXWEhaZoa/DGt8RqPfHoZB+p
	 ToiKKMnFH/nhNuJblzdFd0NFjnPiDt/JuGZbpXSQYEHqFG933EfG6HcZnJ7xZiGizN++E
	 CPuW+0UZ6h43b9sVvJ/jT/kHfWoqAUwFmCvjZ/M829Dy8NQPcC1oLZalSgRcGQKfEYeMn
	 LZF0xD2ncB0wqMSMgquVQeOGeFYKYJIO4KCJZBP7KcRC5KGXn6OVxWJdojVj/A/waYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XX5BaFg74xAzs0LN2cVnu1X8mKV8F7yM7t8UwjzcFYs=;
	b=fQBmLMCNZFXGMtWesHHSdA4eohrBVjWxL5c0KU9HqeRU+5fuQ24k3VsT6eVTSiWXwRbn
	 yJMRmw7kjMILl8qEOORhrvj7I6xCLbXsP6BE2kHytWHEsVJuDgxrP30P1uUIRpxvDJqiO
	 zzW0Is556uqH4XKzKYsSyey9ywds5CFFPzMVcZNCbZ997V1r6fyufs0zwrU/DZZjuvwtQ
	 /38J596TUX7ahF+/+OcPODNudCGC16qjMOJsHs/GnvzsQsLy/js2HKbOsfGajKIFYt3AT
	 jChciLtpj9XzGZN2F+tkZwWIe0WwomuLOY6jR2oHnYN9HNSuJMOjc+2IEn/kY0mW29g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=imX3YWdQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957963;
	bh=XX5BaFg74xAzs0LN2cVnu1X8mKV8F7yM7t8UwjzcFYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9q9cAqL348LaGeMFWib0dZw53NVMwvdLi1EyQPAqI2kiCtTijK2MYbgFjsW9MWJP
	 JUnpUpuWdCx4wZAx+iuuT/8mGGsM5pKNP2deWdQ+sxKqW/8ExfeAKi8rXo5xa7RHpm
	 pYHYOz1TbB9YOlSBAEZY+ZxfVCN0shGYDdoikQCgjYNUmDn5vGqvL86samD9X8q+jE
	 KJkmI6ddrXpsUwfZghHSlTUqYl6itME72EfeqKSNInm/RBF6aQUXFozxELJqSllagl
	 8W/hk08iqgWEsDXkvzZrEFo2mb5LIaDici5G68/wxPNCbSWrEQq+O9TmnQ9MvU+Apm
	 xR/lffX6WLqKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7AA660769;
	Wed,  9 Sep 2026 12:46:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AA4D724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51065606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckcsMihFdzok for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2DA02605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943879;
 b=Nd26beO3muvrxrnDnCcLxD9oCtT0cA7EnRVWQ5+XHWgQU7nKvsfXTGGX8vuusPludoL1
 LNSt+7zQUIxIz7F/IAiCSokUokL9IdZgkH0w5Wnqs5YcyK0vJVNRnnU0d0PaBNADXhvu5
 CgzASv3kQsGGRlfuYkaD0Hx46iqo10nWgUkx0dq7+BUgyUk1VUsMhU4WIzJUnYDLJdKbh
 kuJrYT+i706cmdVt5rD+AlOisJCEnwVIXfViRM5UFfXpnVDAGzpIARCqJHMoemdJxNuXK
 eU4zFQQ6SJyBkIDGqL5PYNOVZ9PRSBXLNqkzKlkNjFesBz8N/tM9fO5+avw811QhR7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943879;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XX5BaFg74xAzs0LN2cVnu1X8mKV8F7yM7t8UwjzcFYs=;
 b=MTdKYt9ZUXIS9ffc3m5a6Z/b72qcLSnEK3i5vWn+a3AqNBdOk+L1U/zWY+/Rw1xrVfZ5
 MA7B2uGXx+brSBUiCcF+uRyqmSabTRvZEuW7MdGYilWG9QzlMdsmqAYvnuG/w4mAa5/Kq
 Nf5oCPbVPNNFxaeBB59dwMPPKiKxOUgExGZcZfZlSXM9hglCjJWPIcVueX7KCPJ6190R9
 YwPmFGacBn9yhQi1s2SPqbKv3QyyHNPds1EAY53v5rxK/5nW4UxDZrvcbrADKAOGENkYb
 myo5/zZ+K7DArWGWvVkEbtnnfPNEKblEZOSHKfPW2RVCAtD8JDi3myb4kPgU9d0Vq5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=imX3YWdQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=imX3YWdQ
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DA02605D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:17 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74796866b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943876; x=1789548676;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XX5BaFg74xAzs0LN2cVnu1X8mKV8F7yM7t8UwjzcFYs=;
 b=imX3YWdQfYCo220WWzPZHiKKi00DAylTV98u/d+PikaQQgnE6BoaiK9DvIhlQWfUzt
 O2VqbjCklnSjtaq6bQu7yth2nkLDjD+iXcmYplx8urSVdfUyopgI9lHTz7t6q/Hk4eAw
 TD6SkLbEZl6Thlw6Y9+kgZ+bXNz1Q4BEWC40+Mw0P9Yn7fZZMq6G9wCr3CD0VYy0Pr1+
 Gw5XTO/N+zXv+KPDEfqM9x+hybPqx2c3+jfCf4Nn7jbG934XYd4eeUTKLB1ASmNUM88o
 SaW4u4D66+2tVRYg6u0rxJeFslH2EKi5V9HjHZEbiuUP0UabQjrsXXXTegSd2zhFTZOB
 2ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943876; x=1789548676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XX5BaFg74xAzs0LN2cVnu1X8mKV8F7yM7t8UwjzcFYs=;
 b=koZIEe2yWseQgx2/EXU46LW8B5/FuVFGl30T0ljCYN8QAo+8HT836ugCAsGbAv0e9V
 RZXSetsVSvUbS4PVxlrXpBmONAzUsXNoGxkswC1VeyN3qwI+Y6U2hfmICzjgaDKa5kVv
 JW+Tbt7ouJi7C+3cKclpMtvbFo9YGkQ9Dl7yyimahxx4H52QRRHhEaFXIUCWW05B+fq7
 HvV8+bE8Ywe/XtPbjdQspFML1CnmaKah2hU3nsMOvzHHbpZgEi7UpCrCDZqU5nruoz10
 +MGrwKwXyjRrLEhrjYzxVQN8TGNxJBDo2S0zvfLgOYIllXAyo7E0QYj+h4F8MRpW7qnM
 0GCA==
X-Gm-Message-State: AFuF++m/qXH7f2tKX9mXjpjRZSA6ct8iJr4ztZZnlcsPHlj/htJ5DhEL
 4iw9aDKdRf887+Sc7RymNnGAQcQ9q3wTkhKuPgT2dsgzYVOpKATEwp475Bwtevli/xyH+zQieD6
 d60vX
X-Gm-Gg: AYBFou3u7Vje26EXPAoqibSHT6gyOQtjPoxV5yFTB7t+RHA8HpPu6pwO+riqGzvKWs9
 WYCPlR06U6NwEkEXhJoIKJBLCN9aQ7OQi6vkz7aP0YNOX6eIhlFOqyhidINAm/398b+f1t7tc7z
 uTb0hb4tSb43gHk+Ck6NHrUzBbq3RUyRMKLA7mQYVoQ7WPj2ZggIo/cZeM9il0KaA8H4Cv5AznU
 0DLmYXCBpsHhD8GUwjpUqHjCcfgp9emnPNGSxLSH3C6Or3crE0NE3PPPpFq49umO/RELCtsVcuz
 LZnDBIVIycWcgI4PIX85cEZybGymNcI1JoIYOYbrXsV4YiDZXGDUTA7dXb+ucOMnJgt8QCJBKTZ
 3r/Yu/ezA9o61S+MtQ4kSk8Bi0+AldH5Ks65S94kmK7EwGWW/gpY2kvH/vkyhqs0jWYai5aTlnn
 vXUvXGCb0ceIxIo0BN9Vx/NfLIgzLs007GYYhFPfqvFDJuD7M7p0nCh4+XGNghiyTJ/FClm5X9E
 dhnh5l1e+6fVR8p5IvQ4nroeY06IVYv
X-Received: by 2002:a17:907:9719:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c26250b9d2amr1132815766b.4.1788943875302; 
 Wed, 09 Sep 2026 01:51:15 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:14 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 05/25] usb: dwc3: make the core driver build in u-boot
Date: Wed,  9 Sep 2026 10:49:55 +0200
Message-ID: <20260909085015.2480097-6-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

Adapt the DWC3 core files to u-boot: core, io, Makefile and the omap and
ti phy glue.

core.c is a big diff because the kernel file is trimmed to what u-boot
builds. The main changes: rename struct device to udevice, use
generic_phy_init() instead of phy_init(), and drop the host-only and DRD
paths u-boot does not use.

u-boot gets the dwc3 clocks in the glue driver through the DM clock
framework, not in the core. So dwc3_clk_enable() is dropped. We kept
dwc3_clk_disable() in dwc3_core_exit(), but the core never gets these
clocks, so it does nothing. It can go in a follow-up.

Keep the u-boot Makefile instead of the kernel one. The kernel Makefile
lists glue drivers and core files that we do not import, like dwc3-qcom,
dwc3-pci, host.c, drd.c and ulpi.c. The source files are not there and
the CONFIG symbols do not exist in our Kconfig, so those lines are dead
text. Only keep the entries we can build.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile     |   17 +-
 drivers/usb/dwc3/core.c       | 1761 ++++++++-------------------------
 drivers/usb/dwc3/core.h       |   39 +-
 drivers/usb/dwc3/dwc3-omap.c  |    2 -
 drivers/usb/dwc3/io.h         |   36 +-
 drivers/usb/dwc3/ti_usb_phy.c |    2 -
 6 files changed, 434 insertions(+), 1423 deletions(-)

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index a619cd374fb4..63c7c6063002 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -3,16 +3,21 @@
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
+dwc3-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
-obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
+##
+# Platform-specific glue layers go here
+#
+# NOTICE: Make sure your glue layer doesn't depend on anything
+# which is arch-specific and that it compiles on all situations.
+##
 
 obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
-obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)	+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
-obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
-obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
-obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..857d5b92b7b0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,104 +8,40 @@
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
 
-#define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
-
-/**
- * dwc3_get_dr_mode - Validates and sets dr_mode
- * @dwc: pointer to our context structure
- */
-static int dwc3_get_dr_mode(struct dwc3 *dwc)
-{
-	enum usb_dr_mode mode;
-	struct device *dev = dwc->dev;
-	unsigned int hw_mode;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
-
-	mode = dwc->dr_mode;
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
-	switch (hw_mode) {
-	case DWC3_GHWPARAMS0_MODE_GADGET:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
-			dev_err(dev,
-				"Controller does not support host mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_PERIPHERAL;
-		break;
-	case DWC3_GHWPARAMS0_MODE_HOST:
-		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
-			dev_err(dev,
-				"Controller does not support device mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_HOST;
-		break;
-	default:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
-			mode = USB_DR_MODE_HOST;
-		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-			mode = USB_DR_MODE_PERIPHERAL;
-
-		/*
-		 * DWC_usb31 and DWC_usb3 v3.30a and higher do not support OTG
-		 * mode. If the controller supports DRD but the dr_mode is not
-		 * specified or set to OTG, then set the mode to peripheral.
-		 */
-		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
-		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
-		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
-		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
-			mode = USB_DR_MODE_PERIPHERAL;
-	}
-
-	if (mode != dwc->dr_mode) {
-		dev_warn(dev,
-			 "Configuration mismatch. dr_mode forced to %s\n",
-			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
+#define msleep(a) udelay(a * 1000)
 
-		dwc->dr_mode = mode;
-	}
+#define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
-	return 0;
-}
+static LIST_HEAD(dwc3_list);
 
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
@@ -158,146 +94,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 	dwc->current_dr_role = mode;
 }
 
-static void __dwc3_set_mode(struct work_struct *work)
-{
-	struct dwc3 *dwc = work_to_dwc(work);
-	unsigned long flags;
-	int ret;
-	u32 reg;
-	u32 desired_dr_role;
-	int i;
-
-	mutex_lock(&dwc->mutex);
-	spin_lock_irqsave(&dwc->lock, flags);
-	desired_dr_role = dwc->desired_dr_role;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	pm_runtime_get_sync(dwc->dev);
-
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
-		dwc3_otg_update(dwc, 0);
-
-	if (!desired_dr_role)
-		goto out;
-
-	if (desired_dr_role == dwc->current_dr_role)
-		goto out;
-
-	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
-		goto out;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		dwc3_host_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_exit(dwc);
-		dwc3_event_buffers_cleanup(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_exit(dwc);
-		spin_lock_irqsave(&dwc->lock, flags);
-		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dwc3_otg_update(dwc, 1);
-		break;
-	default:
-		break;
-	}
-
-	/*
-	 * When current_dr_role is not set, there's no role switching.
-	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
-	 */
-	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
-			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg |= DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-		/*
-		 * Wait for internal clocks to synchronized. DWC_usb31 and
-		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
-		 * keep it consistent across different IPs, let's wait up to
-		 * 100ms before clearing GCTL.CORESOFTRESET.
-		 */
-		msleep(100);
-
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg &= ~DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	dwc3_set_prtcap(dwc, desired_dr_role, false);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	switch (desired_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-
-			for (i = 0; i < dwc->num_usb2_ports; i++)
-				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
-			for (i = 0; i < dwc->num_usb3_ports; i++)
-				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
-
-			if (dwc->dis_split_quirk) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-				reg |= DWC3_GUCTL3_SPLITDISABLE;
-				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
-			}
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
-
-		ret = dwc3_gadget_init(dwc);
-		if (ret)
-			dev_err(dwc->dev, "failed to initialize peripheral\n");
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_init(dwc);
-		dwc3_otg_update(dwc, 0);
-		break;
-	default:
-		break;
-	}
-
-out:
-	pm_runtime_mark_last_busy(dwc->dev);
-	pm_runtime_put_autosuspend(dwc->dev);
-	mutex_unlock(&dwc->mutex);
-}
-
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
-{
-	unsigned long flags;
-
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
-		return;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->desired_dr_role = mode;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	queue_work(system_freezable_wq, &dwc->drd_work);
-}
-
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -474,7 +270,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
+	dma_free_coherent(evt->buf);
 }
 
 /**
@@ -490,18 +286,19 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
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
 
@@ -817,13 +614,13 @@ static int dwc3_phy_init(struct dwc3 *dwc)
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
@@ -851,11 +648,11 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 
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
@@ -868,10 +665,10 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_exit(dwc->usb3_generic_phy[i]);
+		generic_phy_exit(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_exit(dwc->usb2_generic_phy[i]);
+		generic_phy_exit(dwc->usb2_generic_phy[i]);
 
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -887,13 +684,13 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
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
@@ -902,11 +699,11 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
 
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
@@ -919,52 +716,15 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 	int i;
 
 	for (i = 0; i < dwc->num_usb3_ports; i++)
-		phy_power_off(dwc->usb3_generic_phy[i]);
+		generic_phy_power_off(dwc->usb3_generic_phy[i]);
 
 	for (i = 0; i < dwc->num_usb2_ports; i++)
-		phy_power_off(dwc->usb2_generic_phy[i]);
+		generic_phy_power_off(dwc->usb2_generic_phy[i]);
 
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 }
 
-static int dwc3_clk_enable(struct dwc3 *dwc)
-{
-	int ret;
-
-	ret = clk_prepare_enable(dwc->bus_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(dwc->ref_clk);
-	if (ret)
-		goto disable_bus_clk;
-
-	ret = clk_prepare_enable(dwc->susp_clk);
-	if (ret)
-		goto disable_ref_clk;
-
-	ret = clk_prepare_enable(dwc->utmi_clk);
-	if (ret)
-		goto disable_susp_clk;
-
-	ret = clk_prepare_enable(dwc->pipe_clk);
-	if (ret)
-		goto disable_utmi_clk;
-
-	return 0;
-
-disable_utmi_clk:
-	clk_disable_unprepare(dwc->utmi_clk);
-disable_susp_clk:
-	clk_disable_unprepare(dwc->susp_clk);
-disable_ref_clk:
-	clk_disable_unprepare(dwc->ref_clk);
-disable_bus_clk:
-	clk_disable_unprepare(dwc->bus_clk);
-	return ret;
-}
-
 static void dwc3_clk_disable(struct dwc3 *dwc)
 {
 	clk_disable_unprepare(dwc->pipe_clk);
@@ -983,26 +743,6 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	reset_control_assert(dwc->reset);
 }
 
-static bool dwc3_core_is_valid(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
-	dwc->ip = DWC3_GSNPS_ID(reg);
-
-	/* This should read as U3 followed by revision number */
-	if (DWC3_IP_IS(DWC3)) {
-		dwc->revision = reg;
-	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
-		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
-		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
-	} else {
-		return false;
-	}
-
-	return true;
-}
-
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
 	unsigned int power_opt;
@@ -1090,13 +830,12 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /* set global incr burst type configuration registers */
 static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	/* incrx_mode : for INCR burst type. */
 	bool incrx_mode;
 	/* incrx_size : for size of INCRX burst. */
@@ -1337,9 +1076,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
+	 * out which U-Boot version a bug was found.
 	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+	dwc3_writel(dwc->regs, DWC3_GUID, U_BOOT_VERSION_NUM);
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
@@ -1357,13 +1096,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
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
@@ -1528,78 +1260,17 @@ err_exit_ulpi:
 	return ret;
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc)
+int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	struct device		*dev = dwc->dev;
-	struct device_node	*node = dev->of_node;
-	char phy_name[9];
-	int ret;
-	u8 i;
-
-	if (node) {
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
-	} else {
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-	}
-
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb2_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-	}
-
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb3_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-	}
-
-	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		if (dwc->num_usb2_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
-
-		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb2_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb2_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	for (i = 0; i < dwc->num_usb3_ports; i++) {
-		if (dwc->num_usb3_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
-
-		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb3_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb3_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	return 0;
+	/* TODO */
+	return -ENOSYS;
 }
+#define phy_set_mode(phy, mode) \
+	phy_set_mode_ext(phy, mode, 0)
 
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
-	struct device *dev = dwc->dev;
+	struct udevice *dev = dwc->dev;
 	int ret;
 	int i;
 
@@ -1607,8 +1278,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
@@ -1619,8 +1288,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
 		for (i = 0; i < dwc->num_usb2_ports; i++)
 			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
 		for (i = 0; i < dwc->num_usb3_ports; i++)
@@ -1644,6 +1311,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_core_stop(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
+}
+
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -1665,46 +1340,109 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
-static void dwc3_get_software_properties(struct dwc3 *dwc)
+#define DWC3_ALIGN_MASK		(16 - 1)
+
+
+/* check whether the core supports IMOD */
+bool dwc3_has_imod(struct dwc3 *dwc)
 {
-	struct device *tmpdev;
-	u16 gsbuscfg0_reqinfo;
-	int ret;
+	return DWC3_VER_IS_WITHIN(DWC3, 300A, ANY) ||
+		DWC3_VER_IS_WITHIN(DWC31, 120A, ANY) ||
+		DWC3_IP_IS(DWC32);
+}
 
-	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+static int dwc3_get_num_ports(struct dwc3 *dwc)
+{
+	void __iomem *base;
+	u8 major_revision;
+	u32 offset;
+	u32 val;
 
 	/*
-	 * Iterate over all parent nodes for finding swnode properties
-	 * and non-DT (non-ABI) properties.
+	 * Remap xHCI address space to access XHCI ext cap regs since it is
+	 * needed to get information on number of ports present.
 	 */
-	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
-		ret = device_property_read_u16(tmpdev,
-					       "snps,gsbuscfg0-reqinfo",
-					       &gsbuscfg0_reqinfo);
-		if (!ret)
-			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
-	}
+	base = ioremap(dwc->xhci_resources[0].start,
+		       resource_size(&dwc->xhci_resources[0]));
+	if (!base)
+		return -ENOMEM;
+
+	offset = 0;
+	do {
+		offset = xhci_find_next_ext_cap(base, offset,
+						XHCI_EXT_CAPS_PROTOCOL);
+		if (!offset)
+			break;
+
+		val = readl(base + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(val);
+
+		val = readl(base + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
+		} else {
+			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
+				 major_revision);
+		}
+	} while (1);
+
+	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
+		dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+	iounmap(base);
+
+	if (dwc->num_usb2_ports > DWC3_USB2_MAX_PORTS ||
+	    dwc->num_usb3_ports > DWC3_USB3_MAX_PORTS)
+		return -EINVAL;
+
+	return 0;
 }
 
-static void dwc3_get_properties(struct dwc3 *dwc)
+#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
+int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
 {
-	struct device		*dev = dwc->dev;
-	u8			lpm_nyet_threshold;
-	u8			tx_de_emphasis;
-	u8			hird_threshold;
-	u8			rx_thr_num_pkt = 0;
-	u8			rx_max_burst = 0;
-	u8			tx_thr_num_pkt = 0;
-	u8			tx_max_burst = 0;
-	u8			rx_thr_num_pkt_prd = 0;
-	u8			rx_max_burst_prd = 0;
-	u8			tx_thr_num_pkt_prd = 0;
-	u8			tx_max_burst_prd = 0;
-	u8			tx_fifo_resize_max_num;
-	u16			num_hc_interrupters;
+	int ret;
+
+	ret = generic_phy_get_bulk(dev, phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_init_bulk(phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_power_on_bulk(phys);
+	if (ret)
+		generic_phy_exit_bulk(phys);
+
+	return ret;
+}
+
+int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
+{
+	int ret;
+
+	ret = generic_phy_power_off_bulk(phys);
+	ret |= generic_phy_exit_bulk(phys);
+	return ret;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DM_USB)
+void dwc3_of_parse(struct dwc3 *dwc)
+{
+	const u8 *tmp;
+	struct udevice *dev = dwc->dev;
+	u8 lpm_nyet_threshold;
+	u8 tx_de_emphasis;
+	u8 hird_threshold;
+	u32 val;
+	int i;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xf;
+	lpm_nyet_threshold = 0xff;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;
@@ -1715,538 +1453,89 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	 */
 	hird_threshold = 12;
 
-	/*
-	 * default to a TXFIFO size large enough to fit 6 max packets.  This
-	 * allows for systems with larger bus latencies to have some headroom
-	 * for endpoints that have a large bMaxBurst value.
-	 */
-	tx_fifo_resize_max_num = 6;
-
-	/* default to a single XHCI interrupter */
-	num_hc_interrupters = 1;
-
-	dwc->maximum_speed = usb_get_maximum_speed(dev);
-	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
-	dwc->dr_mode = usb_get_dr_mode(dev);
-	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
-
-	dwc->sysdev_is_parent = device_property_read_bool(dev,
-				"linux,sysdev_is_parent");
-	if (dwc->sysdev_is_parent)
-		dwc->sysdev = dwc->dev->parent;
-	else
-		dwc->sysdev = dwc->dev;
-
-	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
+	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
 
-	dwc->has_lpm_erratum = device_property_read_bool(dev,
+	dwc->has_lpm_erratum = dev_read_bool(dev,
 				"snps,has-lpm-erratum");
-	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
-				&lpm_nyet_threshold);
-	dwc->is_utmi_l1_suspend = device_property_read_bool(dev,
+	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
+	if (tmp)
+		lpm_nyet_threshold = *tmp;
+
+	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
 				"snps,is-utmi-l1-suspend");
-	device_property_read_u8(dev, "snps,hird-threshold",
-				&hird_threshold);
-	dwc->dis_start_transfer_quirk = device_property_read_bool(dev,
-				"snps,dis-start-transfer-quirk");
-	dwc->usb3_lpm_capable = device_property_read_bool(dev,
-				"snps,usb3_lpm_capable");
-	dwc->usb2_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-lpm-disable");
-	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-gadget-lpm-disable");
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
-				&rx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,rx-max-burst",
-				&rx_max_burst);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
-				&tx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,tx-max-burst",
-				&tx_max_burst);
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
-				&rx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,rx-max-burst-prd",
-				&rx_max_burst_prd);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt-prd",
-				&tx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,tx-max-burst-prd",
-				&tx_max_burst_prd);
-	device_property_read_u16(dev, "num-hc-interrupters",
-				 &num_hc_interrupters);
-	/* DWC3 core allowed to have a max of 8 interrupters */
-	if (num_hc_interrupters > 8)
-		num_hc_interrupters = 8;
-
-	dwc->do_fifo_resize = device_property_read_bool(dev,
-							"tx-fifo-resize");
-	if (dwc->do_fifo_resize)
-		device_property_read_u8(dev, "tx-fifo-max-num",
-					&tx_fifo_resize_max_num);
-
-	dwc->disable_scramble_quirk = device_property_read_bool(dev,
+	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
+	if (tmp)
+		hird_threshold = *tmp;
+
+	dwc->disable_scramble_quirk = dev_read_bool(dev,
 				"snps,disable_scramble_quirk");
-	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
+	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
 				"snps,u2exit_lfps_quirk");
-	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
+	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
 				"snps,u2ss_inp3_quirk");
-	dwc->req_p1p2p3_quirk = device_property_read_bool(dev,
+	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
 				"snps,req_p1p2p3_quirk");
-	dwc->del_p1p2p3_quirk = device_property_read_bool(dev,
+	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
 				"snps,del_p1p2p3_quirk");
-	dwc->del_phy_power_chg_quirk = device_property_read_bool(dev,
+	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
 				"snps,del_phy_power_chg_quirk");
-	dwc->lfps_filter_quirk = device_property_read_bool(dev,
+	dwc->lfps_filter_quirk = dev_read_bool(dev,
 				"snps,lfps_filter_quirk");
-	dwc->rx_detect_poll_quirk = device_property_read_bool(dev,
+	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
 				"snps,rx_detect_poll_quirk");
-	dwc->dis_u3_susphy_quirk = device_property_read_bool(dev,
+	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
 				"snps,dis_u3_susphy_quirk");
-	dwc->dis_u2_susphy_quirk = device_property_read_bool(dev,
+	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
 				"snps,dis_u2_susphy_quirk");
-	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
-				"snps,dis_enblslpm_quirk");
-	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u1-entry-quirk");
-	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-entry-quirk");
-	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
-				"snps,dis_rxdet_inp3_quirk");
-	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-freeclk-exists-quirk");
-	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
+	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
 				"snps,dis-del-phy-power-chg-quirk");
-	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
+	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
-	dwc->resume_hs_terminations = device_property_read_bool(dev,
-				"snps,resume-hs-terminations");
-	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
-				"snps,ulpi-ext-vbus-drv");
-	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-ss-quirk");
-	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-hs-quirk");
-	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
-				"snps,gfladj-refclk-lpm-sel-quirk");
-
-	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
+	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
+				"snps,dis_enblslpm_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
-	device_property_read_u8(dev, "snps,tx_de_emphasis",
-				&tx_de_emphasis);
-	device_property_read_string(dev, "snps,hsphy_interface",
-				    &dwc->hsphy_interface);
-	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
-				 &dwc->fladj);
-	device_property_read_u32(dev, "snps,ref-clock-period-ns",
-				 &dwc->ref_clk_per);
-
-	dwc->dis_metastability_quirk = device_property_read_bool(dev,
-				"snps,dis_metastability_quirk");
-
-	dwc->dis_split_quirk = device_property_read_bool(dev,
-				"snps,dis-split-quirk");
+	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
+	if (tmp)
+		tx_de_emphasis = *tmp;
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
-	dwc->hird_threshold = hird_threshold;
-
-	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
-	dwc->rx_max_burst = rx_max_burst;
-
-	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
-	dwc->tx_max_burst = tx_max_burst;
-
-	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
-	dwc->rx_max_burst_prd = rx_max_burst_prd;
-
-	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
-	dwc->tx_max_burst_prd = tx_max_burst_prd;
-
-	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
-
-	dwc->num_hc_interrupters = num_hc_interrupters;
-}
-
-/* check whether the core supports IMOD */
-bool dwc3_has_imod(struct dwc3 *dwc)
-{
-	return DWC3_VER_IS_WITHIN(DWC3, 300A, ANY) ||
-		DWC3_VER_IS_WITHIN(DWC31, 120A, ANY) ||
-		DWC3_IP_IS(DWC32);
-}
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
 
-static void dwc3_check_params(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	unsigned int hwparam_gen =
-		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
+	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
 
 	/*
-	 * Enable IMOD for all supporting controllers.
-	 *
-	 * Particularly, DWC_usb3 v3.00a must enable this feature for
-	 * the following reason:
-	 *
-	 * Workaround for STAR 9000961433 which affects only version
-	 * 3.00a of the DWC_usb3 core. This prevents the controller
-	 * interrupt from being masked while handling events. IMOD
-	 * allows us to work around this issue. Enable it for the
-	 * affected version.
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
 	 */
-	if (dwc3_has_imod((dwc)))
-		dwc->imod_interval = 1;
-
-	/* Check the maximum_speed parameter */
-	switch (dwc->maximum_speed) {
-	case USB_SPEED_FULL:
-	case USB_SPEED_HIGH:
-		break;
-	case USB_SPEED_SUPER:
-		if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS)
-			dev_warn(dev, "UDC doesn't support Gen 1\n");
-		break;
-	case USB_SPEED_SUPER_PLUS:
-		if ((DWC3_IP_IS(DWC32) &&
-		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
-		    (!DWC3_IP_IS(DWC32) &&
-		     hwparam_gen != DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
-			dev_warn(dev, "UDC doesn't support SSP\n");
-		break;
-	default:
-		dev_err(dev, "invalid maximum_speed parameter %d\n",
-			dwc->maximum_speed);
-		fallthrough;
-	case USB_SPEED_UNKNOWN:
-		switch (hwparam_gen) {
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-			if (DWC3_IP_IS(DWC32))
-				dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			else
-				dwc->maximum_speed = USB_SPEED_SUPER;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_DIS:
-			dwc->maximum_speed = USB_SPEED_HIGH;
-			break;
-		default:
-			dwc->maximum_speed = USB_SPEED_SUPER;
+	dwc->incrx_mode = INCRX_BURST_MODE;
+	dwc->incrx_size = 0;
+	for (i = 0; i < 8; i++) {
+		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
+				       i, &val))
 			break;
-		}
-		break;
-	}
 
-	/*
-	 * Currently the controller does not have visibility into the HW
-	 * parameter to determine the maximum number of lanes the HW supports.
-	 * If the number of lanes is not specified in the device property, then
-	 * set the default to support dual-lane for DWC_usb32 and single-lane
-	 * for DWC_usb31 for super-speed-plus.
-	 */
-	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
-		switch (dwc->max_ssp_rate) {
-		case USB_SSP_GEN_2x1:
-			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
-				dev_warn(dev, "UDC only supports Gen 1\n");
-			break;
-		case USB_SSP_GEN_1x2:
-		case USB_SSP_GEN_2x2:
-			if (DWC3_IP_IS(DWC31))
-				dev_warn(dev, "UDC only supports single lane\n");
-			break;
-		case USB_SSP_GEN_UNKNOWN:
-		default:
-			switch (hwparam_gen) {
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
-				else
-					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
-				break;
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
-				break;
-			}
-			break;
-		}
+		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		dwc->incrx_size = max(dwc->incrx_size, val);
 	}
 }
 
-static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
-	struct extcon_dev *edev = NULL;
-	const char *name;
-
-	if (device_property_present(dev, "extcon"))
-		return extcon_get_edev_by_phandle(dev, 0);
-
-	/*
-	 * Device tree platforms should get extcon via phandle.
-	 * On ACPI platforms, we get the name from a device property.
-	 * This device property is for kernel internal use only and
-	 * is expected to be set by the glue code.
-	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
-		return extcon_get_extcon_dev(name);
-
-	/*
-	 * Check explicitly if "usb-role-switch" is used since
-	 * extcon_find_edev_by_node() can not be used to check the absence of
-	 * an extcon device. In the absence of an device it will always return
-	 * EPROBE_DEFER.
-	 */
-	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
-	    device_property_read_bool(dev, "usb-role-switch"))
-		return NULL;
-
-	/*
-	 * Try to get an extcon device from the USB PHY controller's "port"
-	 * node. Check if it has the "port" node first, to avoid printing the
-	 * error message from underlying code, as it's a valid case: extcon
-	 * device (and "port" node) may be missing in case of "usb-role-switch"
-	 * or OTG mode.
-	 */
-	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
-
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-		if (np_conn)
-			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
-	}
-	of_node_put(np_phy);
-
-	return edev;
-}
-
-static int dwc3_get_clocks(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	if (!dev->of_node)
-		return 0;
-
-	/*
-	 * Clocks are optional, but new DT platforms should support all clocks
-	 * as required by the DT-binding.
-	 * Some devices have different clock names in legacy device trees,
-	 * check for them to retain backwards compatibility.
-	 */
-	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-	if (IS_ERR(dwc->bus_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-				"could not get bus clock\n");
-	}
-
-	if (dwc->bus_clk == NULL) {
-		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-		if (IS_ERR(dwc->bus_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					"could not get bus clock\n");
-		}
-	}
-
-	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-	if (IS_ERR(dwc->ref_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-				"could not get ref clock\n");
-	}
-
-	if (dwc->ref_clk == NULL) {
-		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-		if (IS_ERR(dwc->ref_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					"could not get ref clock\n");
-		}
-	}
-
-	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-	if (IS_ERR(dwc->susp_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-				"could not get suspend clock\n");
-	}
-
-	if (dwc->susp_clk == NULL) {
-		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-		if (IS_ERR(dwc->susp_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					"could not get suspend clock\n");
-		}
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
-	if (IS_ERR(dwc->utmi_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
-				"could not get utmi clock\n");
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
-	if (IS_ERR(dwc->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
-				"could not get pipe clock\n");
-	}
-
-	return 0;
-}
-
-static int dwc3_get_num_ports(struct dwc3 *dwc)
-{
-	void __iomem *base;
-	u8 major_revision;
-	u32 offset;
-	u32 val;
-
-	/*
-	 * Remap xHCI address space to access XHCI ext cap regs since it is
-	 * needed to get information on number of ports present.
-	 */
-	base = ioremap(dwc->xhci_resources[0].start,
-		       resource_size(&dwc->xhci_resources[0]));
-	if (!base)
-		return -ENOMEM;
-
-	offset = 0;
-	do {
-		offset = xhci_find_next_ext_cap(base, offset,
-						XHCI_EXT_CAPS_PROTOCOL);
-		if (!offset)
-			break;
-
-		val = readl(base + offset);
-		major_revision = XHCI_EXT_PORT_MAJOR(val);
-
-		val = readl(base + offset + 0x08);
-		if (major_revision == 0x03) {
-			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
-		} else if (major_revision <= 0x02) {
-			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
-		} else {
-			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
-				 major_revision);
-		}
-	} while (1);
-
-	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
-		dwc->num_usb2_ports, dwc->num_usb3_ports);
-
-	iounmap(base);
-
-	if (dwc->num_usb2_ports > DWC3_USB2_MAX_PORTS ||
-	    dwc->num_usb3_ports > DWC3_USB3_MAX_PORTS)
-		return -EINVAL;
-
-	return 0;
-}
-
-static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
+int dwc3_init(struct dwc3 *dwc)
 {
-	struct power_supply *usb_psy;
-	const char *usb_psy_name;
+	unsigned int hw_mode;
 	int ret;
+	u32 reg;
 
-	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
-	if (ret < 0)
-		return NULL;
-
-	usb_psy = power_supply_get_by_name(usb_psy_name);
-	if (!usb_psy)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	return usb_psy;
-}
-
-int dwc3_core_probe(const struct dwc3_probe_data *data)
-{
-	struct dwc3		*dwc = data->dwc;
-	struct device		*dev = dwc->dev;
-	struct resource		dwc_res;
-	unsigned int		hw_mode;
-	void __iomem		*regs;
-	struct resource		*res = data->res;
-	int			ret;
-
-	dwc->xhci_resources[0].start = res->start;
-	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
-					DWC3_XHCI_REGS_END;
-	dwc->xhci_resources[0].flags = res->flags;
-	dwc->xhci_resources[0].name = res->name;
-
-	/*
-	 * Request memory region but exclude xHCI regs,
-	 * since it will be requested by the xhci-plat driver.
-	 */
-	dwc_res = *res;
-	dwc_res.start += DWC3_GLOBALS_REGS_START;
-
-	if (dev->of_node) {
-		struct device_node *parent = of_get_parent(dev->of_node);
-
-		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
-			dwc_res.start -= DWC3_GLOBALS_REGS_START;
-			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
-		}
-
-		of_node_put(parent);
-	}
-
-	regs = devm_ioremap_resource(dev, &dwc_res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-
-	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(&dwc_res);
-
-	dwc3_get_properties(dwc);
-
-	dwc3_get_software_properties(dwc);
-
-	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
-	if (IS_ERR(dwc->usb_psy))
-		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
-
-	if (!data->ignore_clocks_and_resets) {
-		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-		if (IS_ERR(dwc->reset)) {
-			ret = PTR_ERR(dwc->reset);
-			goto err_put_psy;
-		}
-
-		ret = dwc3_get_clocks(dwc);
-		if (ret)
-			goto err_put_psy;
-	}
-
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		goto err_put_psy;
-
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto err_assert_reset;
-
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err_disable_clks;
-	}
-
-	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
-	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-		if (ret)
-			goto err_disable_clks;
-	}
-
 	/*
 	 * Currently only DWC3 controllers that are host-only capable
 	 * can have more than one port.
@@ -2255,7 +1544,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
 		ret = dwc3_get_num_ports(dwc);
 		if (ret)
-			goto err_disable_clks;
+			return ret;
 	} else {
 		dwc->num_usb2_ports = 1;
 		dwc->num_usb3_ports = 1;
@@ -2264,551 +1553,275 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
-	pm_runtime_get_noresume(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
-	pm_runtime_enable(dev);
-
-	pm_runtime_forbid(dev);
-
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		ret = -ENOMEM;
-		goto err_allow_rpm;
-	}
-
-	dwc->edev = dwc3_get_extcon(dwc);
-	if (IS_ERR(dwc->edev)) {
-		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
-		goto err_free_event_buffers;
+		return -ENOMEM;
 	}
 
-	ret = dwc3_get_dr_mode(dwc);
-	if (ret)
-		goto err_free_event_buffers;
-
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to initialize core\n");
-		goto err_free_event_buffers;
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto core_fail;
 	}
 
-	dwc3_check_params(dwc);
-	dwc3_debugfs_init(dwc);
-
-	ret = dwc3_core_init_mode(dwc);
-	if (ret)
-		goto err_exit_debugfs;
-
-	pm_runtime_put(dev);
-
-	dma_set_max_seg_size(dev, UINT_MAX);
-
-	return 0;
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto event_fail;
+	}
 
-err_exit_debugfs:
-	dwc3_debugfs_exit(dwc);
-	dwc3_event_buffers_cleanup(dwc);
-	dwc3_phy_power_off(dwc);
-	dwc3_phy_exit(dwc);
-	dwc3_ulpi_exit(dwc);
-err_free_event_buffers:
-	dwc3_free_event_buffers(dwc);
-err_allow_rpm:
-	pm_runtime_allow(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
-err_disable_clks:
-	dwc3_clk_disable(dwc);
-err_assert_reset:
-	reset_control_assert(dwc->reset);
-err_put_psy:
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
+	if (dwc->revision >= DWC3_REVISION_250A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dwc3_core_probe);
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (dwc->revision >= DWC3_REVISION_290A)
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
 
-static int dwc3_probe(struct platform_device *pdev)
-{
-	struct dwc3_probe_data probe_data = {};
-	struct resource *res;
-	struct dwc3 *dwc;
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing memory resource\n");
-		return -ENODEV;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return -ENOMEM;
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 
-	dwc->dev = &pdev->dev;
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
 
-	probe_data.dwc = dwc;
-	probe_data.res = res;
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
 
-	return dwc3_core_probe(&probe_data);
-}
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto mode_fail;
 
-void dwc3_core_remove(struct dwc3 *dwc)
-{
-	pm_runtime_get_sync(dwc->dev);
+	return 0;
 
-	dwc3_core_exit_mode(dwc);
-	dwc3_debugfs_exit(dwc);
+mode_fail:
+	dwc3_event_buffers_cleanup(dwc);
 
+event_fail:
 	dwc3_core_exit(dwc);
-	dwc3_ulpi_exit(dwc);
-
-	pm_runtime_allow(dwc->dev);
-	pm_runtime_disable(dwc->dev);
-	pm_runtime_dont_use_autosuspend(dwc->dev);
-	pm_runtime_put_noidle(dwc->dev);
-	/*
-	 * HACK: Clear the driver data, which is currently accessed by parent
-	 * glue drivers, before allowing the parent to suspend.
-	 */
-	dev_set_drvdata(dwc->dev, NULL);
-	pm_runtime_set_suspended(dwc->dev);
 
+core_fail:
 	dwc3_free_event_buffers(dwc);
 
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
+	return ret;
 }
-EXPORT_SYMBOL_GPL(dwc3_core_remove);
 
-static void dwc3_remove(struct platform_device *pdev)
+void dwc3_remove(struct dwc3 *dwc)
 {
-	dwc3_core_remove(platform_get_drvdata(pdev));
+	dwc3_core_exit_mode(dwc);
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
+	dwc3_core_stop(dwc);
+	dwc3_core_exit(dwc);
 }
+#endif
 
-#ifdef CONFIG_PM
-static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+/**
+ * dwc3_uboot_init - dwc3 core uboot initialization code
+ * @dwc3_dev: struct dwc3_device containing initialization data
+ *
+ * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
+ * kernel driver). Pointer to dwc3_device should be passed containing
+ * base address and other initialization data. Returns '0' on success and
+ * a negative value on failure.
+ *
+ * Generally called from board_usb_init() implemented in board file.
+ */
+int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 {
-	int ret;
-
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		return ret;
-
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto assert_reset;
-
-	ret = dwc3_core_init(dwc);
-	if (ret)
-		goto disable_clks;
-
-	return 0;
-
-disable_clks:
-	dwc3_clk_disable(dwc);
-assert_reset:
-	reset_control_assert(dwc->reset);
-
-	return ret;
-}
+	struct dwc3		*dwc;
+	struct device		*dev = NULL;
+	u8			lpm_nyet_threshold;
+	u8			tx_de_emphasis;
+	u8			hird_threshold;
 
-static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	u32 reg;
-	int i;
-	int ret;
+	int			ret;
 
-	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
-		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
-				    DWC3_GUSB2PHYCFG_SUSPHY) ||
-				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
-				    DWC3_GUSB3PIPECTL_SUSPHY);
-		/*
-		 * TI AM62 platform requires SUSPHY to be
-		 * enabled for system suspend to work.
-		 */
-		if (!dwc->susphy_state)
-			dwc3_enable_susphy(dwc, true);
-	}
+	void			*mem;
 
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (pm_runtime_suspended(dwc->dev))
-			break;
-		ret = dwc3_gadget_suspend(dwc);
-		if (ret)
-			return ret;
-		synchronize_irq(dwc->irq_gadget);
-		dwc3_core_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			dwc3_core_exit(dwc);
-			break;
-		}
+	mem = devm_kzalloc((struct udevice *)dev,
+			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
 
-		/* Let controller to suspend HSPHY before PHY driver suspends */
-		if (dwc->dis_u2_susphy_quirk ||
-		    dwc->dis_enblslpm_quirk) {
-			for (i = 0; i < dwc->num_usb2_ports; i++) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-					DWC3_GUSB2PHYCFG_SUSPHY;
-				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-			}
+	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem = mem;
 
-			/* Give some time for USB2 PHY to suspend */
-			usleep_range(5000, 6000);
-		}
-
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* do nothing during runtime_suspend */
-		if (PMSG_IS_AUTO(msg))
-			break;
+	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
+					DWC3_GLOBALS_REGS_START);
 
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			ret = dwc3_gadget_suspend(dwc);
-			if (ret)
-				return ret;
-			synchronize_irq(dwc->irq_gadget);
-		}
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
 
-		dwc3_otg_exit(dwc);
-		dwc3_core_exit(dwc);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
 
-	return 0;
-}
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
 
-static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	int		ret;
-	u32		reg;
-	int		i;
+	dwc->maximum_speed = dwc3_dev->maximum_speed;
+	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
+	if (dwc3_dev->lpm_nyet_threshold)
+		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
+	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
+	if (dwc3_dev->hird_threshold)
+		hird_threshold = dwc3_dev->hird_threshold;
+
+	dwc->do_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->dr_mode = dwc3_dev->dr_mode;
+
+	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
+	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
+	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
+	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
+	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
+	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
+	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
+	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
+	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
+	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
+	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
+	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
+	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
+	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
+
+	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
+	if (dwc3_dev->tx_de_emphasis)
+		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
+
+	/* default to superspeed if no maximum_speed passed */
+	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
+		dwc->maximum_speed = USB_SPEED_SUPER;
 
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
-		dwc3_gadget_resume(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			ret = dwc3_core_init_for_resume(dwc);
-			if (ret)
-				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
-			break;
-		}
-		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		for (i = 0; i < dwc->num_usb2_ports; i++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-			if (dwc->dis_u2_susphy_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
 
-			if (dwc->dis_enblslpm_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
 
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-		}
+	dwc->index = dwc3_dev->index;
 
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* nothing to do on runtime_resume */
-		if (PMSG_IS_AUTO(msg))
-			break;
+	dwc3_cache_hwparams(dwc);
 
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
+	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+		dwc->dr_mode = USB_DR_MODE_HOST;
+	else if (!IS_ENABLED(CONFIG_USB_HOST))
+		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
 
-		dwc3_otg_init(dwc);
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
-			dwc3_otg_host_init(dwc);
-		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_resume(dwc);
-		}
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
 
-		break;
-	default:
-		/* do nothing */
-		break;
+	ret = dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto err0;
 	}
 
-	if (!PMSG_IS_AUTO(msg)) {
-		/* restore SUSPHY state to that before system suspend. */
-		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err1;
 	}
 
-	return 0;
-}
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto err2;
 
-static int dwc3_runtime_checks(struct dwc3 *dwc)
-{
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->connected)
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
+	list_add_tail(&dwc->list, &dwc3_list);
 
 	return 0;
-}
 
-int dwc3_runtime_suspend(struct dwc3 *dwc)
-{
-	int		ret;
+err2:
+	dwc3_event_buffers_cleanup(dwc);
 
-	if (dwc3_runtime_checks(dwc))
-		return -EBUSY;
+err1:
+	dwc3_core_exit(dwc);
 
-	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
-	if (ret)
-		return ret;
+err0:
+	dwc3_free_event_buffers(dwc);
 
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
 
-int dwc3_runtime_resume(struct dwc3 *dwc)
+/**
+ * dwc3_uboot_exit - dwc3 core uboot cleanup code
+ * @index: index of this controller
+ *
+ * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
+ * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
+ * should be passed and should match with the index passed in
+ * dwc3_device during init.
+ *
+ * Generally called from board file.
+ */
+void dwc3_uboot_exit(int index)
 {
-	struct device *dev = dwc->dev;
-	int		ret;
-
-	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
-	if (ret)
-		return ret;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->pending_events) {
-			pm_runtime_put(dev);
-			dwc->pending_events = false;
-			enable_irq(dwc->irq_gadget);
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
-
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
+	struct dwc3 *dwc;
 
-int dwc3_runtime_idle(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->index != index)
+			continue;
 
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc3_runtime_checks(dwc))
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
+		dwc3_core_exit_mode(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		dwc3_free_event_buffers(dwc);
+		dwc3_core_exit(dwc);
+		list_del(&dwc->list);
+		kfree(dwc->mem);
 		break;
 	}
-
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_autosuspend(dev);
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
 
-static int dwc3_plat_runtime_suspend(struct device *dev)
-{
-	return dwc3_runtime_suspend(dev_get_drvdata(dev));
-}
 
-static int dwc3_plat_runtime_resume(struct device *dev)
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
 {
-	return dwc3_runtime_resume(dev_get_drvdata(dev));
+	return 1;
 }
 
-static int dwc3_plat_runtime_idle(struct device *dev)
-{
-	return dwc3_runtime_idle(dev_get_drvdata(dev));
-}
-#endif /* CONFIG_PM */
-
-#ifdef CONFIG_PM_SLEEP
-int dwc3_pm_suspend(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret;
-
-	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
-	if (ret)
-		return ret;
-
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
-
-int dwc3_pm_resume(struct dwc3 *dwc)
+/**
+ * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
+ * @dev: device of this controller
+ *
+ * Invokes dwc3 gadget interrupts.
+ *
+ * Generally called from board file.
+ */
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	struct device *dev = dwc->dev;
-	int		ret = 0;
-
-	pinctrl_pm_select_default_state(dev);
-
-	pm_runtime_disable(dev);
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
-
-	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
-		pm_runtime_set_suspended(dev);
+	struct dwc3 *dwc = NULL;
 
-out:
-	pm_runtime_enable(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_resume);
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
 
-void dwc3_pm_complete(struct dwc3 *dwc)
-{
-	u32		reg;
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->dev != dev)
+			continue;
 
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
-			dwc->dis_split_quirk) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-		reg |= DWC3_GUCTL3_SPLITDISABLE;
-		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+		dwc3_gadget_uboot_handle_interrupt(dwc);
+		break;
 	}
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_complete);
-
-int dwc3_pm_prepare(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	/*
-	 * Indicate to the PM core that it may safely leave the device in
-	 * runtime suspend if runtime-suspended already in device mode.
-	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
-	    pm_runtime_suspended(dev) &&
-	    !dev_pinctrl(dev))
-		return 1;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
-
-static int dwc3_plat_suspend(struct device *dev)
-{
-	return dwc3_pm_suspend(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_resume(struct device *dev)
-{
-	return dwc3_pm_resume(dev_get_drvdata(dev));
-}
-
-static void dwc3_plat_complete(struct device *dev)
-{
-	dwc3_pm_complete(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_prepare(struct device *dev)
-{
-	return dwc3_pm_prepare(dev_get_drvdata(dev));
-}
-#else
-#define dwc3_plat_complete NULL
-#define dwc3_plat_prepare NULL
-#endif /* CONFIG_PM_SLEEP */
-
-static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
-	.complete = dwc3_plat_complete,
-	.prepare = dwc3_plat_prepare,
-	/*
-	 * Runtime suspend halts the controller on disconnection. It relies on
-	 * platforms with custom connection notification to start the controller
-	 * again.
-	 */
-	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
-			   dwc3_plat_runtime_idle)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id of_dwc3_match[] = {
-	{
-		.compatible = "snps,dwc3"
-	},
-	{
-		.compatible = "synopsys,dwc3"
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_dwc3_match);
-#endif
-
-#ifdef CONFIG_ACPI
-
-#define ACPI_ID_INTEL_BSW	"808622B7"
-
-static const struct acpi_device_id dwc3_acpi_match[] = {
-	{ ACPI_ID_INTEL_BSW, 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 #endif
 
-static struct platform_driver dwc3_driver = {
-	.probe		= dwc3_probe,
-	.remove		= dwc3_remove,
-	.driver		= {
-		.name	= "dwc3",
-		.of_match_table	= of_match_ptr(of_dwc3_match),
-		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
-		.pm	= &dwc3_dev_pm_ops,
-	},
-};
-
-module_platform_driver(dwc3_driver);
-
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4..1b9fca02b4cf 100644
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
@@ -418,6 +404,7 @@
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
+#define DWC3_GUCTL_HSTINAUTORETRY		BIT(14)
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
@@ -744,7 +731,6 @@ struct dwc3_event_buffer {
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
-	struct delayed_work	nostream_work;
 	struct list_head	cancelled_list;
 	struct list_head	pending_list;
 	struct list_head	started_list;
@@ -1177,7 +1163,6 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		bounce_addr;
 	struct dwc3_request	ep0_usb_req;
-	struct completion	ep0_in_setup;
 
 	/* device lock */
 	spinlock_t		lock;
@@ -1185,8 +1170,11 @@ struct dwc3 {
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
@@ -1194,7 +1182,7 @@ struct dwc3 {
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
-	struct usb_gadget	*gadget;
+	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
 	struct clk		*bus_clk;
@@ -1231,9 +1219,9 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
-	struct power_supply	*usb_psy;
-
 	u32			fladj;
+	u8			incrx_mode;
+	u32			incrx_size;
 	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1315,6 +1303,8 @@ struct dwc3 {
 
 	u8			num_eps;
 
+	void			*mem;
+
 	struct dwc3_hwparams	hwparams;
 	struct debugfs_regset32	*regset;
 
@@ -1400,6 +1390,9 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+
+	int			index;
+	struct list_head	list;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1565,8 +1558,10 @@ struct dwc3_gadget_ep_cmd_params {
 
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
+void dwc3_of_parse(struct dwc3 *dwc);
+int dwc3_init(struct dwc3 *dwc);
+void dwc3_remove(struct dwc3 *dwc);
 
 #define DWC3_IP_IS(_ip)							\
 	(dwc->ip == _ip##_IP)
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4b219c35eb35..9de8ecff3adc 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -25,8 +25,6 @@
 #include <linux/usb/otg.h>
 #include <linux/compat.h>
 
-#include "linux-compat.h"
-
 /*
  * All these registers belong to OMAP's Wrapper around the
  * DesignWare USB3 Core.
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1e96ea339d48..23bf1f1b43a5 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -11,10 +11,10 @@
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <linux/io.h>
-#include "trace.h"
-#include "debug.h"
-#include "core.h"
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#define CACHELINE_SIZE CONFIG_SYS_CACHELINE_SIZE
 
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
@@ -27,13 +27,6 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 */
 	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
-
 	return value;
 }
 
@@ -45,13 +38,22 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * However, the offsets are given starting from xHCI address space.
 	 */
 	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
+}
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
+static inline void dwc3_flush_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+}
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index f0ecdea958ae..f1ddc0086945 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -27,8 +27,6 @@
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
 
-#include "linux-compat.h"
-
 #define PLL_STATUS		0x00000004
 #define PLL_GO			0x00000008
 #define PLL_CONFIGURATION1	0x0000000C
-- 
2.53.0

