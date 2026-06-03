Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A164CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE2D8486D;
	Thu,  4 Jun 2026 01:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTvxkiNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CC783EF9; Thu,  4 Jun 2026 01:49:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571CD84874
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bec44dcddedso246866b.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530569; x=1781135369; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zebcQN0SwLgUceeGO1EWFRI7FmA0yhhvy7z358hUMVM=;
 b=OTvxkiNee+TwEBD9FBn1NIPsa11mKIV0fR/sBr25i3OFZaQkt63EjR9R31IoaIBxX6
 GIM4lJmjQu/sYaVXvjDqhkxwHTFprHbBgDDljb16npekMPEDXkrWMiMfmxbmCl1/e5Lb
 VAT7K/FnRK8zJGbCvWAO+p8f+NP1D8thbbt9xLQHiOumhpMQ+lrU8BaC4CKgg2wqJeer
 LWvo58ic73czvlk4+wsFKxmzGUrHu8Rj0XNAemBz2mhEUnngUM07NRpoFVRmihH4mejr
 iXILRk52qUysRiDfadL8sk2omA2FhWA/f02gJh8PA6stTCUas5IfODuy/1e809NUmpZm
 qvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530569; x=1781135369;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zebcQN0SwLgUceeGO1EWFRI7FmA0yhhvy7z358hUMVM=;
 b=StjNgQr5Ar5iYrvtCXLSJlTAZ54QoT3MfXz0gmRXGWvQrAhuPAjh+NP+MdZGb1YEMj
 0s3WYMepVGSf88A2CwuALksAwRbKwfK4pexE8LfrTXWl4CDt2or31AR0HhNfc21yjGPP
 XFet/1GU+BfO6PhyoJvDDZssSsyeq0wyafsVlnn41Gil9W4oN1WOJUR60oenYU8tfnol
 wv+fw7fzoTkSMLYa8mNCt5FOrIUJpUKl5L5eb3EWlOBg35AqzsBoajxvd0UmNZ/OgSVO
 gU68D3ms7szag/UihXxW95WWA//dddNElcjTFHFkUmoW84ZM539/7SXIqU1kTpcqwD0L
 wEww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fFe4uVLPnGlQKx81f70pwBOylD2oJYF7X0qPGOwaYhap//01hE1xjIYrPvuCHai1s/nS3ehQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwCKbzlEmgjgdLPBfL61RCCgzGz9o8hxk59xZhHxZFLjLIxERHz
 t14OD37iWyokpmytGd7+Au7vaA37icHWOP/TFoEutMZ9lRtB4oDRw+fP
X-Gm-Gg: Acq92OHwdVDFpx9wDZwJO2R4GxPRuJVYwdzhZGYMhCplX42H6YngzqI8knqEwoVBsR6
 vSIi4114SfL+2y5K4TBH+tAAbY0Nt+rqvS9r+Q5mpR7dwtnCLt7tENhbwmcHKJrB8p8QhSu7qjK
 gqUuxgR5rtqeLx51GAX0USfIAM2VdO08n6qW57+odQpAM+FDosoxj6LqdrhTinbEUa00ibAzcw+
 bnQdrpvd2TxJD5X/lJ5ElrE2tYGN8ACxhhnYljTCeY3kvSj8xU47ARaFjDECd3a5YVA7RIR2w//
 p7MPB6aH/4jC4JltKJUc/gR8QnTscHeKrHMolWI5YwL3W35tk2kKuoRes0FBKrfeXV9Oc6tnooL
 BwQGz8hQshSktrI1kuhHJKpZUppaDgAmXlNGWdBJreF+b7zXOU4RCn+wteM+xPHeuiAjf/Jsvj4
 VTjA/b/HE8nRoF0UEwvwV5mq/RCliHlBvBzm2bNkne9xkCjoz1YFvVii3P4lVYdUD/R+Lq+EHv
X-Received: by 2002:a17:907:1c9f:b0:bed:9664:4a28 with SMTP id
 a640c23a62f3a-bf2265b2526mr6251166b.8.1780530568270; 
 Wed, 03 Jun 2026 16:49:28 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05177150esm224499966b.5.2026.06.03.16.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:49:26 -0700 (PDT)
Message-ID: <146467ba-dba2-4a31-81b5-8cfdf24e6bb1@gmail.com>
Date: Thu, 4 Jun 2026 01:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 02/10] usb: Kconfig: add SPL_USB_DWC2
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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
config available in SPL to load U-boot (full) from a USB disk.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Note:
There are no boards with SPL_DM_USB and USB_DWC2 enabled,
so no need for a default y.

grep -l SPL_DM_USB `grep -l USB_DWC2 ./configs/*`

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

