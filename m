Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863EBC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 00:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E7A868AE;
	Fri,  8 Dec 2023 01:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="wTWdeuvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B2986487; Fri,  8 Dec 2023 01:11:00 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744D9868AE
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 01:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332fd78fa9dso1413540f8f.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 16:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701994258; x=1702599058;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whImn4YlP0FsaD5jR6FnMVhdL4PKTUsibpB0pi4i72g=;
 b=wTWdeuvtFFLuLXPOJ+VlX6fmojWv/XYKxIS28Rq3+QoPssqC3GxfBxhaEhAkncSDnX
 Qrzppf1SsNTQwKy3S+K+1lGA2fepF1c7aWC5I2HtwWEtiuEcol6y+ha4YWxithFraKdv
 GF9PVPN+ltACTkGy/CG+uYaiKj20FVemHePllqcZ0PHL/mKLqcyWbBnNKsohpNf02qMU
 6FAaIa/Ury9W5itI9HD8T+WrXPz5hPKER7Sk+tmq5gk83gyPh1R3cMbrAngDeGp0zZzk
 u6SoUcygrJHXfs9Ft96aLUquBT6OuLvRqAJDO7vmu7A3lKkoXNbaDerCsoECR1uR/KFx
 KZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701994258; x=1702599058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whImn4YlP0FsaD5jR6FnMVhdL4PKTUsibpB0pi4i72g=;
 b=q4GO0MB/47Fxl+4lQKE6V4qUF8Wqyq6a7gTF7jOgrh7zNFPYAY54S4mkefRmzr1ics
 2usgXlm1bEwfM/Yy+GdBXCDeX3T6RfPLq/X3ZbjYylw7QZ6CvPEU5IgLcOYDx/Cr6OgW
 Q0USqgBmm+F6F0DaXkV83tWrrxS77pu4o71HkQPSNcwKXQhl2qKWaSH7b6LzJ/VzIWap
 oo+Jjt8tjP6y1GbDNBvNK8XqinKwUoY1GUZ0P1NiCEm7PYo0ROKNN7BVShcCe5M4SUgn
 OzYuB0oWD/lRH7dyMYAJTGREuVpMPk/VduoMBSpgny+FHuQbJufnpL4Y1DYkYGx6vn/n
 zDsA==
X-Gm-Message-State: AOJu0YyS8rFWTUfuz0Nb37zL8X5Qfx62khwMrXD7niRP4soltgOBJexe
 0TZNh6zmCJ6GKMevmCxdy9u+FQ==
X-Google-Smtp-Source: AGHT+IGXhLdCbdSHE14jzWQCYR5sz4dPZXjMo+BZBncw5UQ5rhrL75JEb4iY8QRgEkyLQ00HNJ/Xkg==
X-Received: by 2002:a05:600c:a4c:b0:40c:c00:68a3 with SMTP id
 c12-20020a05600c0a4c00b0040c0c0068a3mr1014801wmq.262.1701994257830; 
 Thu, 07 Dec 2023 16:10:57 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b0040b30be6244sm1074464wmq.24.2023.12.07.16.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 16:10:57 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Shantur Rathore <i@shantur.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] common: usb-hub: Reset hub port before scanning
Date: Fri,  8 Dec 2023 00:09:46 +0000
Message-Id: <20231208000947.248849-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208000947.248849-1-i@shantur.com>
References: <20231208000947.248849-1-i@shantur.com>
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

(no changes since v1)

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

