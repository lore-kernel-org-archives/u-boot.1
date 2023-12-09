Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7075C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092908744F;
	Sat,  9 Dec 2023 19:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="fEm+tRCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2815787622; Sat,  9 Dec 2023 19:12:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3512987215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so5649555e9.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702145526; x=1702750326;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gfXDkSSg6z23BktGOsJ8JiN0VQyzzNEGG9TyNtaW96w=;
 b=fEm+tRCcSTqufgTu0jH/yQm/mU7+V4A5bnhavY5NkoS2OR7Dld3TOmd0wpGUNddDhA
 95/4JUjo37IbryhxGgsgujkDbkXGGfQEa4Pq/Kxdhauu79YqKvHEotLBTc+FmMjEem+r
 rbajUGt6AEQtNuNVRjEZ8WQC/tPtCOJD60698/WC35GECjwb6V1YzOfB3U6soLZrJsER
 G9efiTle9Udmjtd6kXzRNhTh0lIlpFsIQBeh78Trft05OFLSrw2gP3SN07cnatRb6Ty4
 HqWOzr2OrIE01MtF1xZ+xs2S2O+usB267aF0pCXNouqqzHapy9p0eGJfp1KuCZllvoRV
 JsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702145526; x=1702750326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfXDkSSg6z23BktGOsJ8JiN0VQyzzNEGG9TyNtaW96w=;
 b=h7h+fiRn1IKPle+SDPC0ocSf+oQTaiCmjn3LmqO+zaRc+eNfjvOM0ZKgCCE/wIBhQN
 MHXTsnb9ntYdEvaPc7j1oKcPkwIW6yt/9TJ1mTj2l3dL7h0tMyO4quXSC1mUHV3hM66o
 +0h17L8k0JR3Q0oajLVpfurRQEeHBjCJ+3HrEjtw+bkhaKdiwO74qBSlnbv2aKIiI1zv
 y1HhgJdPl+DLFe9kMev+LVmzI/PvlMZXKQ8COv3u6Rwh2Febvzh+vfIz0ePEPLidiLQ6
 IAZHik4qf2uHkE1OF/2fjbNDduB1AIw3cip1oD3B8uknRGxnfh4lry6LiGRlI7RWiNWM
 /OwA==
X-Gm-Message-State: AOJu0YyMXB2SjpjUD+Iso8i5zsx9Lxy2BCTEEJg1Oxaa8xxfbT/wQFJ8
 ST6uU+Ld6x1P4NVEjqv1onc9rA==
X-Google-Smtp-Source: AGHT+IGpFjkvzDEV5RePZRMaevtGePnwhfNjKPU5/aJCMS1Vr7P1zUkryM4OFP63JNVa520U2CvAqw==
X-Received: by 2002:a7b:cbd4:0:b0:40c:1f04:e5b with SMTP id
 n20-20020a7bcbd4000000b0040c1f040e5bmr917868wmi.143.1702145525786; 
 Sat, 09 Dec 2023 10:12:05 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 w13-20020adfee4d000000b00333339e5f42sm4826824wro.32.2023.12.09.10.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:12:05 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Shantur Rathore <i@shantur.com>,
 Hector Martin <marcan@marcan.st>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v3] common: usb-hub: Reset hub port before scanning
Date: Sat,  9 Dec 2023 18:10:56 +0000
Message-Id: <20231209181057.331815-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Shantur Rathore <i@shantur.com>

---

Changes in v3:
- Split up patches as seperate series

Changes in v2:
- As requested, added fix for regulator-always-on in RockPro64

 common/usb_hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 70279f301d..3fb7e14d10 100644
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

