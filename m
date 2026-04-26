Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C13FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEE484150;
	Sun, 26 Apr 2026 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihf8P6bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58312840CB; Sun, 26 Apr 2026 09:43:47 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E93084011
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 09:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so6245941f8f.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189423; x=1777794223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2roxDZl4x3DaE6Y1nKV9fUYkd+nv91U+TbjqNoBe6E=;
 b=ihf8P6bkAifftZJF0WMuhYzAwLHENnPWLSx51M7KELCIRbjWAFgQdf5cBCYtfQ25Nh
 1cJ0x5DtFTeNDiJG8UK5Hh7Wcf7pPQgrTmnn2x2W4NsqEydyisRtI3KqNGAq2PC2ZG9F
 bPQ3RwLAb8K74Y6aCvFi5/zfERryqG4GKFCI6jA0iBKngFrgVMT8QGS7/sr54ghSNL+1
 MNXOiBeLQGr2w23u/2c9YrgOn5wQ8J0rTOIwd4/XmkeuX77LxeeHTwMOzYoOpYWUH8V4
 ciq6xH5VgnVZ+YYhNiUKHZMVvVNlZZCnIP439BtUPzXFJKG7cTKvatF98/FPRWi6+7i8
 0cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189423; x=1777794223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2roxDZl4x3DaE6Y1nKV9fUYkd+nv91U+TbjqNoBe6E=;
 b=bog9QZV/nAbOf5D8nY8IzRGomgX/uXUsUZEHgjLT924de5WsyLSoa9Nl9eJBmBch5G
 sy4j0aBcaTrjfFKlI4+jzWfc4VrjUh46xTZEpKSxXLeIlxD8q8QnCbFgSeJbfI0IG+IU
 vUzlmhmIvH4HJ/KDto05oPFRFkDkn54xOmkTy8nINfDKSKOeD5dsV+TBv5JZqIgG98vN
 Dw4H/yXHsomPLvrrrhu/kH3XQJ5k4Gq6tXzJTXeVFVNFpRE9HPB1UvZiXdvatY8WT4G/
 2XqIQTp4SiAEZ4Or0xvYbCM3Zt9J38fftounZHKvVoo9b9FDtmBFCDTEjyP4bn1Ryu6S
 i+iA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+byXiZskauJ2OSwrugFC3b3huA1gX+/zAm7qkmjVbqJX2QT6awAwCgnV2NwVUqtsh+zg9tzlo=@lists.denx.de
X-Gm-Message-State: AOJu0YzT6xdxevcEVoTt4dl05CcC9TsTmCDPvk7wKoPDXapXfDkSMaX4
 dGNpJV1lJAWp1Mk/Kbek5uc5S9nwE4H/SejjPJwKvkssRtBIcmVg3B92
X-Gm-Gg: AeBDiesmQU6V1M2bEIT6kozEUbQJ+mTPh00DrnBZdN/s1W/B7mmguvu6sMQ/4ItLSQg
 1/KdDZeDgAhRo27dOQqsoeXRqQLgGj+UT7KyVXY7C7BTePlTdX/I2rDjsWQmj87sxE2663ch7N8
 MPr/NbyEAXMMqa38qBf3142oPlMURJlnv+lc2rBM6nbcGpxW3w6eE8Zj98GBSj30YJQB1xZxuYu
 bf2eBSwMJRTI3jvPzFYONap7ZcyQhOpNtjBTZ9XJGFlj+90Lyjz8gIb6FHC9uqXM7HEFeBMPTXF
 z/yi264bCSRaTqQtPBjdeEjSCbF42w0j8YfNPbUBSp4c1d7B5LjtNoFxmIBVhGap347tO4O1vjv
 YQ5J1goibJcFphqPsjPdukL81tCbHPhZ9wVXQxhY8Tl4NkPIBs6JKuBfPw9k05cm6KSr8KcnEn8
 Iz/mJiVN87dCYxQBPGAd48z/PzU5YXRd+eks43GRmS071maIJIdn8=
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-43fe3dc5386mr60606603f8f.12.1777189423324; 
 Sun, 26 Apr 2026 00:43:43 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm76748031f8f.7.2026.04.26.00.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:43:42 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v7 1/3] usb: gadget: rcar: Fix gadget registration lifecycle
 in remove
Date: Sun, 26 Apr 2026 09:43:17 +0200
Message-Id: <20260426074319.5819-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426074319.5819-1-micbis.openwrt@gmail.com>
References: <20260426074319.5819-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
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

