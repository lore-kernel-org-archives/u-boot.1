Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B51C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DD387825;
	Fri, 10 Nov 2023 16:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="kDKkijGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5727877FC; Fri, 10 Nov 2023 15:13:22 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E254687800
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 15:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so15382205e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 06:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699625600; x=1700230400;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDiisOmzTLhNJHkABVEaRtdhWh/ew2FNvQQ0tsdmZDU=;
 b=kDKkijGvwNscyDnLT/N1JR2RT/f8fjwwjT2iY/9wOKafVMGcsBITQxF1c8bBwgPpv3
 lwBPdSyQ2C8Hg47vCVglW2DLDM8vMvdpWvmZ7MJ7m8VEs21vpeOA+Z7t5khr/ETcGOvO
 dop0wwaMp71hz0GmuxR1ovmfmISq4yykrJMuCfTeu8fP4R9iYbY9QT4dZ+WRx3+DRfYm
 XcWPJAPAQpwMfnC6HyHPquq4mW3T364CmaqSr6zJyzlTRg2Txs+yhRoyymdRu2jw1ic4
 qVWOMLjMLm35jN69Co63V+6/j+BLLSocV2lLOwjesgshDAk4Tckg+0tFbqQIY2THS6Ci
 GM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699625600; x=1700230400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDiisOmzTLhNJHkABVEaRtdhWh/ew2FNvQQ0tsdmZDU=;
 b=eSfDimVw7nbpwCDEQKu1ag7faW6WO2/8B6ig6d/Egb1fHS1iMYghTHVFqBJbLjms0t
 O70kKs82A9xrPk8YwQMeydS1KqYD357v1HDR1w9BC2PIN3nINFsrPwoUKRQrd8EGomxh
 Kb2cMphsOcxwwgIJpOn9Uo32LEVjXa3maNR8cJRp7GicwsahRTAtZheel+FBrOLInbDS
 Se++j8b4UgWTvPi4yClmdOeXnwUCkI5Kaut+NvTXPz9a+smobrwy0hUF1CxvfsLFYNmd
 JUeFLcj05hi4lFv//8qsDIrG8ixwb/N0a1SJaF45Who0/fTzJQFvh6y3wDZAAtWuLiJ2
 KPrw==
X-Gm-Message-State: AOJu0Yw2D6eoGy8BSQBLG7M1tFT++nHgIDp++WyRJ9wIgIQj6vlz2+ZV
 7SyaSD9Tcb7tYXfrX7kiOIOzdPCIMQdWFUoNnw70Lw==
X-Google-Smtp-Source: AGHT+IHX6Fj1LkW13i7yXVTmHtq8M93eTQPKAvehXD1BOuZLAHeWePvSnZAhveNJv8BEiteEEVvcQA==
X-Received: by 2002:a05:600c:35d2:b0:408:80bb:ae80 with SMTP id
 r18-20020a05600c35d200b0040880bbae80mr6957861wmq.7.1699625599661; 
 Fri, 10 Nov 2023 06:13:19 -0800 (PST)
Received: from shantur-virtual-machine.localdomain
 (host-212-159-138-247.static.as13285.net. [212.159.138.247])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a056000024800b003197869bcd7sm2013308wrz.13.2023.11.10.06.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 06:13:19 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH] common: usb-hub: Reset hub port before scanning
Date: Fri, 10 Nov 2023 14:13:11 +0000
Message-Id: <20231110141311.512334-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:05:59 +0100
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

