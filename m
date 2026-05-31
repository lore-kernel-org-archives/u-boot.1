Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08638CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916D484701;
	Sun, 31 May 2026 23:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbfZpbP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D892C84839; Sun, 31 May 2026 23:04:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0245840ED
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso335462a12.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261443; x=1780866243; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zZH7jO71NAIOZvyRH46VZE0ka12FFkpWUm7fl6FVTFw=;
 b=HbfZpbP2hW+IpUdrljRly8UyCT1Pv4YcAb2Vm0rHzJj2Y7a/8qBUmoEwmGHFk+97p1
 J7bTjtc9yAu+2//dKxcJ24LCvKWbVg/qO6fgVTJLBD0zZSdHqZANurjs+XMhK+akVMjn
 iUaQgv7h/HjVC5iVjzfLq5fs7uUUcquU1+1tkD5HzQ2ZLxWN1nRbYkyryIougFEA0pzN
 nHeuFoPlGhFq1py4Pi5WAMRDr99vSQyGYwv4CwWMBCADUz+sAgwSftNJFN9G/j9eZkrY
 UMhwCRWLnjNArU3MDk8IiDgf/3zy47my+V1Y6HM/2jVu5oVsSwpQ3MMQRhp/5LerMmHX
 xRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261443; x=1780866243;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZH7jO71NAIOZvyRH46VZE0ka12FFkpWUm7fl6FVTFw=;
 b=Gw21jvmx1fnUK6bXf/3SOVGOvx/fFM2ZHhwL2krMAWWDzfCFiV9HU5f+H3y0+jT/I/
 azPawAbQhy04m6TZwft2JjIBGFg/nnFKG3MkCMk1La5jt6H5rwS5SaVw1e1b3lX1plh1
 b9DZ621MaKxW6alzMRqEKL0pqNNDrJ8wAvTvkS32VB2jlkdh/6PeMDdw4LssxykIUTjy
 R8HZ1BPewelYf1VwFL2zixz7v76Hxa7Ktu2PWD03hWoE1omXSfhtzBUTggLtV5aCx4dT
 cZx38OyHxgeaGr+6wdiv5tDQMfb54vHUNw+tAKDic3E+gDMouS6W07XgHe9nyl6cHSls
 dNYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qKz6xi0X3KCBbifIwKnFgx5ON6nplFPGVsIZueBnDS8DP5xVt3V3D06W/fQZJ/9hIMjAg9kI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0X0lcw9ELRVWqKTDkbwl1766A2h8dKG4baWwNblQJFld3pPvw
 dXf1uxiSRiwoCCYPkgbf1SiTZiGULO2wZy6xo23yXZfgo1mUTd+r4SOI
X-Gm-Gg: Acq92OHmKSF+dNAtYutP4vjZz6X4ujvY94w5Z05PG87Xj+1oc5LyKuQHsSubOpU5E5t
 xzNkU/cIWkBKdIsObeY5Rx+4aJOCi5TdzCR6Y/xCvm+RbJZM/oiLf+fa7iN8WEvo3UT7Oh4Bkbf
 +2RYH9iWIigZazCC+kLkbQUAvTeJ5QBMRgMA6QODp5Cdd4hy7VzAuo8bOqJaFL96WEW7bvwwaTW
 HemewAb48JSPE4D9wz6MJ3Xj1qAJlSwVEa9No6QbmvrNn4k8fG0456GQn+7lwxXcY3h+zHQxDCY
 UQfb4rvPGgFGoOHJY9RrR1BKyCV9GrUwJCaDEV99Osc17Guyhy8xanmjLhrVPSw65k0n44ZDiXs
 1ZpXYtouOcAIPMcx7wue0t5035C5k1oGTFva8ScnANvwAei9u5UC7pHLp33jDkQpfguj+/Ut/KV
 Ug930rgT461o/dZMZCa9MgpUsgqBvLpWk5eLHAQSzj+f8giCjOtlXtBlC88ePDHRsHmlJQsi7u
X-Received: by 2002:a17:907:3e22:b0:bcd:1afc:2603 with SMTP id
 a640c23a62f3a-beab5231218mr191954566b.6.1780261443153; 
 Sun, 31 May 2026 14:04:03 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bed94f9f82asm17607166b.20.2026.05.31.14.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:04:01 -0700 (PDT)
Message-ID: <21cfdd2a-7811-4450-8b1d-d51145b3a0b0@gmail.com>
Date: Sun, 31 May 2026 23:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 09/12] usb: make dwc2_usb available in SPL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Make the dwc2_usb driver available in SPL to load U-boot (full)
from a USB disk.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/Makefile            |  3 ++-
 drivers/usb/common/Makefile |  2 +-
 drivers/usb/host/Kconfig    | 11 +++++++++++
 drivers/usb/host/Makefile   |  2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba332818..87f755d8a35b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -68,8 +68,9 @@ obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
-obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
+obj-$(CONFIG_SPL_USB_HOST) += usb/common/
 obj-$(CONFIG_SPL_USB_HOST) += usb/host/
+obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index db8f35c10c4f..5350cd668d03 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -4,7 +4,7 @@
 #

 obj-$(CONFIG_$(PHASE_)DM_USB) += common.o
-obj-$(CONFIG_USB_DWC2) += dwc2_core.o
+obj-$(CONFIG_$(PHASE_)USB_DWC2) += dwc2_core.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
 obj-$(CONFIG_USB_ISP1760) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d75883e28650..4fbca2886096 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -417,6 +417,17 @@ config USB_DWC2
 	  operation is compliant to the controller Supplement. If you want to
 	  enable this controller in host mode, say Y.

+config SPL_USB_DWC2
+	bool "DesignWare USB2 Core support in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL
+	select SPL_USB_HOST
+	---help---
+	  The DesignWare USB 2.0 controller is compliant with the
+	  USB-Implementers Forum (USB-IF) USB 2.0 specifications.
+	  Hi-Speed (480 Mbps), Full-Speed (12 Mbps), and Low-Speed (1.5 Mbps)
+	  operation is compliant to the controller Supplement. If you want to
+	  enable this controller in host mode, say Y.
+
 if USB_DWC2
 config USB_DWC2_BUFFER_SIZE
 	int "Data buffer size in kB"
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index ef4ce62a680c..ec99d0b3882a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -57,4 +57,4 @@ obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
 obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o

 # designware
-obj-$(CONFIG_USB_DWC2) += dwc2.o
+obj-$(CONFIG_$(PHASE_)USB_DWC2) += dwc2.o
--
2.39.5

