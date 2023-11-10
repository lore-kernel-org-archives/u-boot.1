Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35157C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B4C87815;
	Fri, 10 Nov 2023 16:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="QlBM4dOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17101877FC; Fri, 10 Nov 2023 15:10:14 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2DC87800
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 15:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so2686310e87.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699625399; x=1700230199;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDiisOmzTLhNJHkABVEaRtdhWh/ew2FNvQQ0tsdmZDU=;
 b=QlBM4dOxv1Ul+ZuO16ncNHuLZhL5edjjeVyNHpRykrbSVJBX1pBGc3Zq91GM1rH1Rc
 liW5A3XKv5OnXZy/F+XVcJ8D0PZipb2lQRV9ZQkg+nq1HMRQEx2TeigGSa/YtCWUmo/5
 trKYJM34oaJ1YC/8TnhHiWXDFjvXw1hZ4PjqJ1yTBu0nSB0ErhwBGcmcLkeOFJx6vjwG
 aBnmxoSMOuo4ZD3JfH347ce9JvfGdHdHrFEoHlEpBadqWhXixMxfK75aT7m+W83AvrIq
 gaDfydLD8QHeXR8F1kllduYhY3+22mLJepHVI34v5wq3/iEh1Tkl9qR41uY5IVqhhKvT
 K9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699625399; x=1700230199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDiisOmzTLhNJHkABVEaRtdhWh/ew2FNvQQ0tsdmZDU=;
 b=ZH6LU8Eya2LCu3tTFS9m+nEVVdQyi2nGZ9cVSSTs/6frrpY8kFDnCsJti0VTYgYCSm
 4VnSO4ql5GU8tshl1LyIuu8WEOI4RmqhIJhcrmpxfKci1BkE/jCtkgpcE+Gt/78pMhEW
 ZCvYRJ9Oqlemt/A0OiFiLUVx708UIV3jKpFm0cKEKLKPiiS9SiTyox5nje0G5DLutkMv
 R3NPTWzdookzOcSeM++hPDjgSm14iTEeHE3VthhPOgp9XAEtZh74GNDW8vmI6FBxuXxG
 cx9wbev3VXGe3J+fcQU50PXWTaakVlTlBC0KjJXFKIVnCQ8dvr1eK0RjWKvruZc/m6R7
 kMhg==
X-Gm-Message-State: AOJu0YwFitabNsny3iHkvZOSBrJnOC4y2WrSfl8U0hpF7LVEeqWSxqMI
 sh4fYkfNqvghu6uFgPzzKZ7kvQksvpwPpO5wlRrcvA==
X-Google-Smtp-Source: AGHT+IFqjTIl/xHs+tApxPlesMNltlG3EBBL3kWHNAoe6+aJVX61CaMyfD5812naAvh2ch4Y/jrghQ==
X-Received: by 2002:a05:6512:502:b0:509:3835:73bc with SMTP id
 o2-20020a056512050200b00509383573bcmr4488715lfb.55.1699625398430; 
 Fri, 10 Nov 2023 06:09:58 -0800 (PST)
Received: from shantur-virtual-machine.localdomain
 (host-212-159-138-247.static.as13285.net. [212.159.138.247])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c451200b004076f522058sm5369692wmo.0.2023.11.10.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 06:09:58 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH] common: usb-hub: Reset hub port before scanning
Date: Fri, 10 Nov 2023 14:09:32 +0000
Message-Id: <20231110140932.512067-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:05:58 +0100
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

Currently when a hub is turned on, all the ports are powered on.
This works well for hubs which have individual power control.

For the hubs without individual power control this has no effect.
Mostly in these scenarios the hub port is powered before the USB
controller is enabled, this can lead to some devices in unexpected
state.

With this patch, we explicitly reset the port while powering up hub
This resets the port for hubs without port power control and has
no effect on hubs with port power control as the port is still off.

Before this patch AMicro AM8180 based NVME to USB adapter won't be
detected as a USB3.0 Mass Storage device but with this it works as
expected.

Tested working after this patch:
1. AMicro AM8180 based NVME to USB Adapter
2. Kingston DataTraveler 3.0
3. GenesysLogic USB3.0 Hub

The drives were tested while connected directly and via the hub.
---
 common/usb_hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 85c0822d8b..06fe436add 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
 
 	debug("enabling power on all ports\n");
 	for (i = 0; i < dev->maxchild; i++) {
+		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
+		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
 		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
-		debug("port %d returns %lX\n", i + 1, dev->status);
+		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
 	}
 
 #ifdef CONFIG_SANDBOX
-- 
2.40.1

