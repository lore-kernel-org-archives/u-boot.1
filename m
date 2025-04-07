Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631DAC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC3282F5A;
	Mon,  7 Apr 2025 17:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hValTXlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D26C82F37; Mon,  7 Apr 2025 17:00:05 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CBD82CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac289147833so742322566b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744037999; x=1744642799; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r43KH5feIdAQxYK+hwQRgUBY9MsNl6GpL6M8qKrA8qg=;
 b=hValTXlk355To5r7dSWxB+w5QAOoE7lJUXlS2C3dEEZ+JSeL2z/8gY0Ip186nBT7P4
 tb1sIoG7sovT+1lCqZnJf6vFCR8sf+VheozF/vWbd92SnqdnAYT73DpDQx1l2F3PMUpX
 MaaoqDGIeDwKnVJ4rWRhlt/LxpYPzCEi3PhhlZCZIPWcB/SbZicKFpZIGUkoz3+hebaG
 Re7HS/Ln5PjfV6WZ7YakCs89b95aZaPEj1Paok2KVf0YZFQOFwMJLKtOqdj9J2Mu5Ukh
 2OtV/aM4QFPKb+wlq8UifrsQp7CDcgfIRQ+qvmAkjQyE+QMZYfTTLYZCDnGD0C+MKNQ4
 odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037999; x=1744642799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r43KH5feIdAQxYK+hwQRgUBY9MsNl6GpL6M8qKrA8qg=;
 b=D7S7gbesyQXHjMyeRL+2x7qNxxsgsDYb57IH1eqYGGu3+S6iTAWAfpC52EHohdmuFE
 sXHMnwXjJ/ngXCzRyu8nBADaKaLBzCyCX1+mTemKLwRna/Wd2sXUm7a5wQ9MhyIhY49Q
 vp8uiFfdhO+HLwQKu5wpzm3aBk6h6YQcOjx3DRle6OixuXQT3L5/6YBAMNrcttIIIfpc
 mla3PQNnImW2mjThll6s+G9D1njahz2m7iQtsIzju/XEcLOFOpZ3cCRtVPyxHCixS9ud
 xcFGMSq45ZvrAj13vhbei8LJRd0YoxvE9avQPnQyvb4sXsMv5wTo1Mh7e8u83yUmkfQP
 H5Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9KPJEeZnZxLNxDasJnfoTeoIGOzk+gAzQfrCm7fTY9V7fLJtfHchd7SNJGtro7/lQk6Zz+xo=@lists.denx.de
X-Gm-Message-State: AOJu0YxbxKF8h6FmcGmbl1lgVrpP/K2lKvKNgAoVL5nzkdnboAHwZMmO
 dDfgyeR9ys5p92JrtUYDsBu+Zltr5hcj/gJ/fkSAiy5Jp0TPrYaTVTGPOSRp4JY=
X-Gm-Gg: ASbGncskXrTge+l5PxNeEwauGnmTDHOun4fviJfHikIFz4EolDDEEa4CDmPZZtKDrZE
 t4dsAEN1i2a1oAwQ7jmIE4UiHQaPJrg5jS4Zgme+5WHzGBQma85TQamKFcRtx6uxQ12qylquH04
 ruOX8DCbyudXlVuwdGNBjvyFlmCVdg/vzWCXyyJhfy9BVtlILSSdpIo2Ftl7XoLWIUK2hfR94Um
 7Xt+v3Oo0wSjcuFxWtoVwzuvJNSlHIoseZgZnefIrrsiexzHib/ohx6PZ1DwBexJ7LDWmuo9axA
 sBr2DnJ0/TJGHafid+Fo5x+Vd/mOR+emNWifAH9D7++tFXRTFTY79ONb7A==
X-Google-Smtp-Source: AGHT+IE9xnCjuVEkx+5MLmIw7yhRYJjWdPBax4ybdPQPm0TqrkylM19WQuzDGVZFejc5zGleapooJw==
X-Received: by 2002:a17:907:7295:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-ac7d136deeemr1119326266b.0.1744037999118; 
 Mon, 07 Apr 2025 07:59:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea2224sm751585666b.74.2025.04.07.07.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:59:58 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 16:59:37 +0200
Subject: [PATCH 3/3] usb: gadget: introduce 'enabled' flag in struct usb_ep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-acm-fixes-v1-3-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
In-Reply-To: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

f_acm calls usb_ep_disable(f_acm->ep_notify) unconditionally in
acm_start_ctrl(), even if the USB endpoint was never enabled before. This
causes crashes for some UDC drivers (e.g. ci_udc), because they dereference
data structures that are assigned only after having called usb_ep_enable().

The f_acm driver in U-Boot is similar to the Linux driver, where this issue
does not occur because usb_ep_disable() and usb_ep_enable() internally
track the enabled state. In Linux this change was made in commit
b0bac2581c19 ("usb: gadget: introduce 'enabled' flag in struct usb_ep") by
Robert Baldyga.

Fix the crashes for f_acm by making the same change in U-Boot. This makes
the API less bug-prone and avoids introducing crashes when adapting new
gadget drivers from Linux.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 include/linux/usb/gadget.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c7927df15aa386f33eb3b3889adee854d42386a8..fe79bf64a0e1c037e69e694fe58cbe5343e18a70 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -179,6 +179,7 @@ struct usb_ep {
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
 	struct usb_ep_caps	caps;
+	bool			enabled;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
 	unsigned		max_streams:16;
@@ -230,7 +231,18 @@ static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
 static inline int usb_ep_enable(struct usb_ep *ep,
 				const struct usb_endpoint_descriptor *desc)
 {
-	return ep->ops->enable(ep, desc);
+	int ret;
+
+	if (ep->enabled)
+		return 0;
+
+	ret = ep->ops->enable(ep, desc);
+	if (ret)
+		return ret;
+
+	ep->enabled = true;
+
+	return 0;
 }
 
 /**
@@ -247,7 +259,18 @@ static inline int usb_ep_enable(struct usb_ep *ep,
  */
 static inline int usb_ep_disable(struct usb_ep *ep)
 {
-	return ep->ops->disable(ep);
+	int ret;
+
+	if (!ep->enabled)
+		return 0;
+
+	ret = ep->ops->disable(ep);
+	if (ret)
+		return ret;
+
+	ep->enabled = false;
+
+	return 0;
 }
 
 /**

-- 
2.47.2

