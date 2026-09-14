Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF9C88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F9F680887;
	Mon, 14 Sep 2026 14:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvSrfJ6B3zae; Mon, 14 Sep 2026 14:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C75C480892
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395435;
	b=SyuJiI2UDsCo8NXZ6X+qG4sOV/WpUu7VonoWTJX9KP8/sAym7HG4fZl2HgX0/pIy3Guu
	 5sCS/bnK+OhvQ9ww8SoSEhDRCT3W2idAaZp3kyKn1SFETKcyxaLUjK2UbP6Q7Cg3US+NN
	 kRGOZzpdglvDVjrZtsH2qWjGoCLlJymk8R8hvHp00bJMBCYFPy5aq0xaV+PyLIOxAT8R9
	 O7Y2EOznwIzV28aTipqcGC+KS2Nw2ER7HUHC7wMocHrP6MJLRHjoCRfkeY2OZQNxpMjNc
	 oFGi+2nlPsl/Jp9+FcXgUFNu6Z2zTxWhg3JHXcYq/4Ws8ZSMQBJA9knlh5UwACdFhrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xOzS6FSnys1iWll6kP6z02W6CA3Tw/c44gqzVoC6Qhc=;
	b=oxHrrfK/Fs6AfgoD5xq/TXJdIXzT1BHRQeQhq2m6qur7u/ZPMDpS+c1P8gTCFZtOUg4r
	 QqeLlHrZhGwtsbvvnaV3hL6lxTkJROFd5EitxzYsoVEyIAY8LeBDLnoDzl3Z/Vg+tw7aV
	 FowE745FpAwAK3DCYTSsvAizoQ8dlqQywQiiv+L0Lbwr5dPw+u14+eVba84zCQ7r8rlyg
	 GUijv05voXu6gYOBKu35fSYgfsD3kjlrXISUWmEdh8tsnI5YDd6gWun12X8wEn0bWx2vX
	 CYEMrtBP1oQE99stX0+ewUvX4gkRE+wmobc5ejbJTDj3LOiCyAGgvRMSibrd3RHm+Gg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395435;
	bh=xOzS6FSnys1iWll6kP6z02W6CA3Tw/c44gqzVoC6Qhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOaL7SEHTXu8MLBpU1BQ1ZPe9zRFMt1TOPHIkU+1T/fA7lNPnB3U2ndhy90S5MR5H
	 RX/aUcEvwNfAOkewDFhOX4ELceR4qTEVeX4l7uPDIASAPtd03YNKIwHNW65kNfCnms
	 CmI7r+RW+ItPRsHrltc+pu3QrHmf/rikAQ2dWa+IYZv2R7TKSrSoOhXEeeW1dw54LT
	 c6oBJlnkkVF37TOSl3eVLF5FKHix5v+AIOxp0FlBGxrsuaxWk3rixFBOOUrO1FKaN6
	 O1cO7Yf2kl2y70nS9JgBqpRBYgDDHbkDAQH+UtNdLO5ntv8D0ECoeBgT3521kCodN/
	 j9d/qOpveK88Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C75C480892;
	Mon, 14 Sep 2026 14:17:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8765D224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DB2F6067E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3lzZcnxJF-L for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 49B6760664
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371804;
 b=scflVb0cFcEfDtdgornSLUfj7S1j1Hb/ONNszL6G+RVza5O/x+1rP4ZBRn1uR3fndU91
 1IhnwGy1PKwRVcW6E4Ua/IU2Rpo3SadtrXiRe/KTPjr3QgXxtWnFhRo2j6kRTfCny8FWp
 FJ3Ry6rke4o14KrStwEEI9OeVSfwjqzHcAz/N+9ESxduCVvH2RlBiJHtC4n9bOGMx3hmT
 vViSx56GhZE+xSpUfe//3HoLNYkmO+bvS+ddRQjHCEbcSToegQS+7YvKjIbocRUJV9vb/
 vTDEu9UVzJa6Tjq4fgZrVD6s5x/QZeuXobPtDr/+d0B3hJPbe7gZfsrRZ/GVJFS4CGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371804;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xOzS6FSnys1iWll6kP6z02W6CA3Tw/c44gqzVoC6Qhc=;
 b=aVjsrAPNzXA8kEQeYajKiM9fpegb85df9TEaOumhNkWyweBAAvSZaMPwNPzvdexrd/rp
 QifBl7d+QL4bZez9Jkxsc612zKd5hQAEu/X1hpxgAbFaOsB0yFGC5e2txh9JH6lmildr7
 +Ld6FCbI7eYQlyriwXzKAXJAlzEkNR/EcpM7LJdEb4s8PekMeQD4Y6Xgxy02ytdacXQhu
 ET60SNCBtUVY2tHfjogP2y7guPeJqdRUNohp+cp1KJAt0hryyASYvx2TBSdSbmrHkBGbs
 TFx9Y7vKsOUBYLO1/qKs/cf4JduhXRLkAEjw1eC50VbtXQS0IZwXrACzhXE4LRQD2Xw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bubF6xO6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bubF6xO6
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49B6760664
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:23 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso36171305e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371802; x=1789976602;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOzS6FSnys1iWll6kP6z02W6CA3Tw/c44gqzVoC6Qhc=;
 b=bubF6xO6xe0EtfpV8TQBvdMxs1UJWaV9khSwNLVWOc+lVDcsEwvne5C+OapNtJmhUN
 OO82IYROy2K0iPcl1Oq/w0XNTKqQQYAQSvYX8Hf26UoQlu+8sJoWhCzqOEshxO2v8+a+
 8+XFbX22lQoJdj1ausGwLU56CKa8qtz2pGWaFTVyHRYUBm0KOKZJP/9wvvrMCSSWUXoH
 y0N8HqUdmd/lDdg4T9ZAR4R63Ir+mFJ5Lo8r9zMOT87WQ5nFrNWal7LpBmRWjK/IzV2B
 7imcR2ysmHkT350dv3IlzsircWsht4qgAWKISWAGF/eUSo5u/4wiPhnmkAWFX3GEJbYV
 wx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371802; x=1789976602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOzS6FSnys1iWll6kP6z02W6CA3Tw/c44gqzVoC6Qhc=;
 b=I4KWU4Y5eY1GcfauNSh1G8iyaTRc/Rypqj467Kj86j9CERTvD5S4A0oUGokOnnzhGK
 8Ig2mz/cUvBiazjtQtALAREhrPUsyZxdl0zZN6nQXaqG3p3EIH/YUBKlzhkDgzp67RmV
 Le01aEOJnaOvtO/iI431wMWoqLjUdVoiypssvVnOF6mAHdZ0cnDsQ2Q3FG3Kq1o7TW3m
 RubSG3RSkapX0RnbDToHka5txttooaEEce1Io/gqomdPKAd4D44VeaZQEcEUIoYfYOlK
 TbGSK1jok7j+t+QsIwYn5FNvBfyOUOJzl2qRqwSM8jXs/3UsiJ1XJt+3zb2pNQR0FUSb
 bajA==
X-Gm-Message-State: AFuF++kqPfrJVtYW7wzSV+McNgJ5Pb0fTJEoos/RjbdAe8bJklBACT8r
 lEAJKavSIKfQ/RrucXWZ+Qh6WEVeM+ob5zQs5b7yOGbMFafW4lT7ByqR
X-Gm-Gg: AYBFou2smVqrpyMRQJ8srzdTysF3e8ITRVKJcK1RDuGLrsVlRCftn5x6TYMm5exlsRa
 8W0F00jGoDAIeveMEmvaRjhYSyQR38MRnHjz3NSHAcXrLlMqaFei36bAjJ9pqugTu9FUGGl6JpI
 fVOVd9WHD5re59i/AIyNM3perg7v9nt52ZC4PplL7oAb4VVcZHCmmh2WsnyEApzcK4nqvLD/Az5
 +4iJ99MDZs59uww1g4OGHSDO5iRjtnk9mlYQ+kGtTXvOftwaA//i1DuOmiy3552NTTB/RT3fRMp
 6gnXL1qkIZNjXkapjyKx5KuL4h3cS+JLPHdiIPtiOY8qFJbeNt46uoq5Ky2h1c8/1xfpDNN66GE
 av0AL5SusPjnWCSL5UGsva1pssMkHAJcgxFQxWiCCpgf0qF3owH7TG+wJsN90odBcGaLLPunL2J
 DSrlMA5F9qZNpeL8kGwJ1J9ApMrFkrpIt4lxWlnaMs8wG+hn3Gg+g/FrMiv/DR/fl+
X-Received: by 2002:a05:600c:8716:b0:49e:732e:6b79 with SMTP id
 5b1f17b1804b1-49e7a67dce4mr12677175e9.32.1789371801561; 
 Mon, 14 Sep 2026 00:43:21 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:21 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/7] usb: ci_udc: add driver model support
Date: Mon, 14 Sep 2026 09:42:43 +0200
Message-ID: <20260914074314.12522-2-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914074314.12522-1-eichest@gmail.com>
References: <20260914074314.12522-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Register the ChipIdea gadget as a UCLASS_USB_GADGET_GENERIC driver so it
can be used on boards with DM_USB_GADGET enabled, which CI_UDC no longer
excludes. The driver enables the clocks and the PHY of its device tree
node and registers the gadget with usb_add_gadget_udc().

It has no of_match of its own. The controller node is shared with the
EHCI host driver, which owns it and binds this driver by name, so CI_UDC
depends on that driver once DM_USB_GADGET is enabled.

Boards without DM_USB_GADGET keep the existing behaviour.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/gadget/Kconfig  |   8 +-
 drivers/usb/gadget/ci_udc.c | 152 +++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index e42d5a43696..67826ee5150 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -153,12 +153,18 @@ config USB_GADGET_OS_DESCRIPTORS
 
 config CI_UDC
 	bool "ChipIdea device controller"
-	depends on !DM_USB_GADGET
+	depends on !DM_USB_GADGET || USB_EHCI_MX6 || USB_EHCI_MX7
 	select USB_GADGET_DUALSPEED
 	help
 	  Say Y here to enable device controller functionality of the
 	  ChipIdea driver.
 
+	  With DM_USB_GADGET enabled this driver has no device tree match of
+	  its own. The EHCI host driver owns the controller node and binds
+	  this driver by name for the ports whose dr_mode is "peripheral" or
+	  "otg", which is why it is required. Without DM_USB_GADGET the
+	  controller is picked up through the EHCI host driver as before.
+
 config USB_GADGET_VBUS_DRAW
 	int "Maximum VBUS Power usage (2-500 mA)"
 	range 2 500
diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 53796887dac..f63cb17b58f 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -7,14 +7,18 @@
  * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
  */
 
+#include <clk.h>
 #include <command.h>
 #include <config.h>
 #include <cpu_func.h>
+#include <dm.h>
+#include <generic-phy.h>
 #include <net.h>
 #include <malloc.h>
 #include <wait_bit.h>
 #include <asm/byteorder.h>
 #include <asm/cache.h>
+#include <dm/device_compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <asm/io.h>
@@ -23,6 +27,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <usb/ci_udc.h>
+#include <usb/ehci-ci.h>
 #include "../host/ehci.h"
 #include "ci_udc.h"
 
@@ -93,9 +98,18 @@ static int ci_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
 static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_start(struct usb_gadget *gadget,
+			struct usb_gadget_driver *driver);
+static int ci_udc_stop(struct usb_gadget *gadget);
+#endif
 
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+	.udc_start = ci_udc_start,
+	.udc_stop = ci_udc_stop,
+#endif
 };
 
 static const struct usb_ep_ops ci_ep_ops = {
@@ -994,7 +1008,7 @@ void udc_irq(void)
 	}
 }
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+static int ci_udc_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
 	u32 value;
@@ -1139,6 +1153,12 @@ static int ci_udc_probe(void)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return ci_udc_gadget_handle_interrupts(dev);
+}
+
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -1192,6 +1212,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	return 0;
 }
+#endif /* !DM_USB_GADGET */
 
 bool dfu_usb_get_reset(void)
 {
@@ -1199,3 +1220,132 @@ bool dfu_usb_get_reset(void)
 
 	return !!(readl(&udc->usbsts) & STS_URI);
 }
+
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+struct ci_udc_priv {
+	/* Only hccr and hcor are used, the gadget does not drive EHCI. */
+	struct ehci_ctrl	ctrl;
+	struct clk_bulk		clks;
+	struct phy		phy;
+};
+
+static int ci_udc_start(struct usb_gadget *gadget,
+			struct usb_gadget_driver *driver)
+{
+	if (!driver || !driver->bind || !driver->setup || !driver->disconnect)
+		return -EINVAL;
+
+	controller.driver = driver;
+
+	return 0;
+}
+
+static int ci_udc_stop(struct usb_gadget *gadget)
+{
+	controller.driver = NULL;
+
+	return 0;
+}
+
+static int ci_udc_clk_init(struct udevice *dev, struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_get_bulk(dev, clks);
+	if (ret == -ENOSYS || ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(clks);
+	if (ret) {
+		clk_release_bulk(clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ci_udc_dm_probe(struct udevice *dev)
+{
+	struct ci_udc_priv *priv = dev_get_priv(dev);
+	struct usb_ehci *ehci;
+	int ret;
+
+	ehci = dev_read_addr_ptr(dev);
+	if (!ehci)
+		return -EINVAL;
+
+	ret = ci_udc_clk_init(dev, &priv->clks);
+	if (ret)
+		return ret;
+
+	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_DEVICE, 0);
+	if (ret)
+		goto err_clk;
+
+	/* Same register layout the EHCI host driver derives its regs from. */
+	priv->ctrl.hccr = (struct ehci_hccr *)&ehci->caplength;
+	priv->ctrl.hcor = (struct ehci_hcor *)((uintptr_t)priv->ctrl.hccr +
+			  HC_LENGTH(ehci_readl(&priv->ctrl.hccr->cr_capbase)));
+	controller.ctrl = &priv->ctrl;
+
+	ret = ci_udc_probe();
+	if (ret) {
+		dev_err(dev, "udc probe failed, returned %d\n", ret);
+		goto err_phy;
+	}
+
+	ret = usb_add_gadget_udc((struct device *)dev, &controller.gadget);
+	if (ret)
+		goto err_udc;
+
+	return 0;
+
+err_udc:
+	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
+	free(controller.items_mem);
+	free(controller.epts);
+err_phy:
+	generic_shutdown_phy(&priv->phy);
+err_clk:
+	clk_release_bulk(&priv->clks);
+	return ret;
+}
+
+static int ci_udc_dm_remove(struct udevice *dev)
+{
+	struct ci_udc_priv *priv = dev_get_priv(dev);
+
+	usb_del_gadget_udc(&controller.gadget);
+
+	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
+	free(controller.items_mem);
+	free(controller.epts);
+	controller.ctrl = NULL;
+
+	generic_shutdown_phy(&priv->phy);
+	clk_release_bulk(&priv->clks);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops ci_udc_gadget_ops = {
+	.handle_interrupts	= ci_udc_gadget_handle_interrupts,
+};
+
+/*
+ * No of_match: the ChipIdea controller shares its device tree node with the
+ * EHCI host driver, which owns the node and binds this driver by name for
+ * the ports that are usable in device mode.
+ */
+U_BOOT_DRIVER(ci_udc) = {
+	.name		= "ci_udc",
+	.id		= UCLASS_USB_GADGET_GENERIC,
+	.ops		= &ci_udc_gadget_ops,
+	.probe		= ci_udc_dm_probe,
+	.remove		= ci_udc_dm_remove,
+	.priv_auto	= sizeof(struct ci_udc_priv),
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+};
+#endif /* DM_USB_GADGET */
-- 
2.55.0

