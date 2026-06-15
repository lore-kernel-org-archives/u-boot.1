Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356F4CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E6F8488B;
	Mon, 15 Jun 2026 23:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFOVUpxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3073484894; Mon, 15 Jun 2026 23:07:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A782846B0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bebe5d8c661so32657166b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557635; x=1782162435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gJbtlFgCoK02POR4TDwgWQ978mjS03gvMUB1qhhWKAg=;
 b=BFOVUpxituzZjMt73XipdsbdFuRijYt41hn134pLXCVzQ4ZHs5iVSraG7gs6cmcd8N
 Faog1fyVh5+pccp/C7lCVoxFbmXldDpF3PsPFsBlDMR+iKQdi4onWDSlSLcD+EVh7Mqs
 5xst4xxqGDEURY5csgSui06N68207W5nhbuKTui5F2t60Ol6vJU2TO8nf11WBy/Z+DS9
 wHKeY7uhj/BJgzfCnr4/77bQyAyTl7jlLWUxZiHyREa9WyiRF5QoLKiTHBG2OjiY5yPK
 cREeCvN/K+X3BztYf8CAJx339l5z0kqdlIs6qKSZkfwoYTZmdn+dcVUzYJfedbKBuXkr
 X2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557635; x=1782162435;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJbtlFgCoK02POR4TDwgWQ978mjS03gvMUB1qhhWKAg=;
 b=QR1ArsaOhA3pwrxiZxn4dHq12t+6RnL8BvLmwj8eW9HtaMfGPLlcLk8UsnT+hJJ/EZ
 mowmbLi1TX4DFtx8lE8E4GW1nMkEj7QBuvPSBYbxd0kdsMWfJhECn0iPlkQWpwlGGUZk
 +sjwQ6CkewM8YIsK7pzO9vbRoVKYamVgqbM7Dn7WuPvt3pUc0pbsDZR/KpxmA49VcMp6
 PYRhT+FzTJym+vC5noSs2ZgJhqROwBTUEzCOgGveLSrnumiMXyjHLdNtcUhdNxfu0bxH
 dKXzU8b7caZRZJGvEdFs11hVWYBxZMjWu9Fmd7Bbf9DfLMHAG81CcG0hMXaDzVFwl9/O
 Gz/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3nqHLIchjMeOsSbWSQKlJWdqG0O6SuSuTy/mDUU0uvQfT8HmMqRh7zPw/E3B2Rk5cvbdYc/g=@lists.denx.de
X-Gm-Message-State: AOJu0YxaeHd5P9ZDy9C2Kvor0ljWb+tiTsDLHJVLhYYzMVv6rNgThOmq
 Dztjgj4x5z7dwlw/RnUHuHIJZ6CBUDoZzeid9M4yA679aMhF6bBY5qvA
X-Gm-Gg: Acq92OHTrJVYIk9sD/fgbI9zEOg2Ew1lZf309mbEx2FJvYV5oCMNFt2TnK27Cim+0xM
 24FmKc+vUcRHBQIc8FEER9yFrHx3/C0oFfS1IHkBDNI2IUahDXBqAB63lCYrkc9teHkuBx5TDt7
 ObxeiPYnNIqu/NjSeRKHgdMI3baJ5akttnRhbvJrsV5mcgfZX9i9F4dOHHdxKrutS8BWpq4eEz9
 A78xW/knkKS1q/ryKj2RDdklHLFSY/tPxlK+vCQB/ALSPDvfEnb6ROs66hOKvQ2V1O3eUky9OHN
 sgyY6Gj93HE4VnONXttYRFWpFrw+7OVabtP1b/Ys71H+unjxr16gY7Ta2/ng+bg39Y0CfKy4qbg
 iPNKKKdPGR9jhZTob3ZqdvRinY2lA+GgFoGidYogrAh6Ro3V25ngmtryqVR+omjdarK75Mt9WCD
 s6BOzIiH327N/H7740KWPlmDn/17KMWRG8kPrXxFSIQB/VmV8f05PPFc9bKWp5RQ==
X-Received: by 2002:a17:906:dc8b:b0:bdc:6e26:ab7 with SMTP id
 a640c23a62f3a-bfe24522007mr326097066b.0.1781557634519; 
 Mon, 15 Jun 2026 14:07:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6d934sm529002066b.40.2026.06.15.14.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:07:14 -0700 (PDT)
Message-ID: <654366f4-f10a-48fd-b14e-aff68d0acdd0@gmail.com>
Date: Mon, 15 Jun 2026 23:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 02/10] usb: Kconfig: add SPL_USB_DWC2
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

The config SPL_DM_USB gives the user the option to be more
selective in what phase the USB drivers should enabled.

Pass this concept to the dwc2_usb driver and make a SPL_USB_DWC2
config available in SPL to load U-Boot (full) from a USB disk.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Note:
There are no boards with SPL_DM_USB and USB_DWC2 enabled,
so no need for a default y.

grep -l SPL_DM_USB `grep -l USB_DWC2 ./configs/*`

Changed V5:
(Marek)
spelling U-Boot

Changed V4:
(Jonas)
reword
replaced deprecated help word
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
index d75883e28650..fcea2a22e955 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -417,6 +417,17 @@ config USB_DWC2
 	  operation is compliant to the controller Supplement. If you want to
 	  enable this controller in host mode, say Y.

+config SPL_USB_DWC2
+	bool "DesignWare USB2 Core support in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL
+	select SPL_USB_HOST
+	help
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
index 9cac53f07c7a..950cc8fa0698 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -57,4 +57,4 @@ obj-$(CONFIG_USB_XHCI_RCAR) += xhci-rcar.o
 obj-$(CONFIG_USB_XHCI_OCTEON) += dwc3-octeon-glue.o

 # designware
-obj-$(CONFIG_USB_DWC2) += dwc2.o
+obj-$(CONFIG_$(PHASE_)USB_DWC2) += dwc2.o
--
2.39.5

