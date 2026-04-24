Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A090BFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0913C843C3;
	Sat, 25 Apr 2026 18:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXZw1V4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7136F84178; Sat, 25 Apr 2026 18:45:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86733840ED
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso1612439466b.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777135524; x=1777740324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP4G6IqOYExXVIkki+jADYOXdeef0HX52dumiI4bYC8=;
 b=lXZw1V4ZrgJwk3RxQlzSoa1piWnvo5PoZHc6wAYtHQCHj0VVmK1nhju0ZZuSwiYS77
 yz5LK6/ftKM9zhQ9htXxPtLqMKQmkC1leWX2SGsBIy7OkAmi9DDhI6JhhhmQ+/jnFv2Z
 pD5D+3RnSRG+sK9w6N3tQBjJ91VaVxsUkYbE+FcoMcFEZXY6GJa5UXNIZd0WFccteePp
 cmfqdvja7iMlsLD9AbRNGs4e3no0YLQEfocHHFeEkMDQDcfPHJw5GUOFFYWvt1y0cZN2
 hDO696YwWmAa9B6dbY2zpGiCHucmFPhWEMrzFPUZov5D7qwTjLPirdYQ/bjCzrfoTb2g
 la+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135524; x=1777740324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nP4G6IqOYExXVIkki+jADYOXdeef0HX52dumiI4bYC8=;
 b=iLTJ0SO0f+vvNcAJEWed7ZwEjcvE1Vb/vTk+gZo1ZruZtnn9LH+IPhPYcUGxkDvzYy
 ymvy6XYhjkpiZhbRIDO8PXGHKI9MLfN/O+3LJtBIAwrbj32HcktcWJ/Kt/a/Zn5k+id3
 61tGLNzYZAFU5j5cQ6QnT0/SP0jlt+L1hwiZOSSv/jfBhRy/euWAYEeT/vuiX2pCcEHI
 QvsPkFSZUi3lwa3Nt2PfRzaRDUVMJpaQBCq1IJJ89PP2jM45GqEBt+BsT9cK6axUEGde
 4Ixn+TJTWcXVFxJ8VvQg6ylJqK+7BAbWmVxGxh3EaihSGvN4bFQlw5EazoWm20XI8YmX
 WZMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V3IY1jjcthm6Hm1O3GJdSqBQy0w0xYWFBL83AuvTtLB09ovxiiSSH9ZWTN5EHZXZG6fQ+z1A=@lists.denx.de
X-Gm-Message-State: AOJu0Yxoe0IWzlKPgIv8jhqN+cjtFl7woQLV69DWs21PWHbsLKUIaUdL
 kJuHBvMc4P08XoItodHYU6NjpCPGGe3hkbdZ1D17NY5CtWDV1CReG8Rz1z+cOw==
X-Gm-Gg: AeBDiev4HsKDIpIzYe4Dj8hpaa8IEQtmC54TtYiX/49vkUdkc8SzZZbEufpcZZ7dMnk
 Q1+Qh+hRshtXXul1CR7loAHL+DH3l90wV5+T7I9R/BZAPb88B1CnL4CL+Sm/O07IVGgpKLqRVX7
 WwVO23NOQCFpBT93RNzAlqAmhRGr8ba8Mb8zGP1SRxRjCB71YfozaN8M5PxSpQxRMguKmrxvQ+F
 7zeWIwDhX0AnT0n8rzikzZBDQwc2bzNyr/uirE/uMbigsLm0bC1zw5NoF3ecsMLVm7llXEPwx4k
 oaFuhsWxakb/XHD6npMjij6nlHdY4Z4bT5akYaGt59yMYtifnvmVXvsAywaCNOtYe/A+XdxL1tA
 bB3f+r6Y00rvpc/Sc6x/GWa3G3idLDdMWPobWSwPtHPf1Io+QNMwaUdmlOfAFNAQ1CdOwL8cVyO
 dtmVGg7lHeqjq2kqeQJhgEsnMBfb0s0DyiVFsJTpwa50DWR1+jY1s=
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr309520625e9.3.1777046645797; 
 Fri, 24 Apr 2026 09:04:05 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm678783845e9.8.2026.04.24.09.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:04:05 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v6 1/3] usb: gadget: rcar: Fix gadget registration lifecycle
 in remove
Date: Fri, 24 Apr 2026 18:03:14 +0200
Message-Id: <20260424160316.157380-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424160316.157380-1-micbis.openwrt@gmail.com>
References: <20260424160316.157380-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:44 +0200
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

The driver currently fails to unregister the USB gadget when the
device is removed or the driver is unbound. This leads to dangling
pointers in the UDC core and potential memory corruption.

Add a call to usb_del_gadget_udc() in the remove path to ensure
a clean teardown of the gadget interface.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 2ba022a3f2c..d40d6736a54 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -447,8 +447,11 @@ err_clk:
 static int usbhs_udc_otg_remove(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
+	struct usb_gadget *gadget;
 
 	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
+	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
+	usb_del_gadget_udc(gadget);
 	usbhs_mod_remove(&priv->usbhs_priv);
 	usbhs_fifo_remove(&priv->usbhs_priv);
 	usbhs_pipe_remove(&priv->usbhs_priv);
-- 
2.34.1

