Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97CC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323B78171B;
	Mon, 31 Mar 2025 19:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObUZEgSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932D48171B; Mon, 31 Mar 2025 17:06:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6359D81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 17:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j4g8y7@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so51966615e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743433604; x=1744038404; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AXSjo1W52Xy88TwmECCy3b3lXYV8/OkwXK23I4eDv6s=;
 b=ObUZEgSsLcepwPyUjSxEDEcR0LY+ah5+YCADhTUuYEe8oWqQ7g/PuMBez5KhpEfSFY
 BfmkNQhAezEnrJhv6zt7TYzXujAnWeW7pHwxV6K4dHdPp/cZU4A8T91lobqNsAZUlkOk
 GMd0zaIG5VjaG0ta5ideEAJMjBHG09YLbNFFRAcrKQgguDa+z+HG12Bpdg3CgbFUnTcM
 rJBIczGsAvUo2koN0LGLiLRdOnQlP/Tu0G/9piv0p8ipp/vwYUbEjaNfNjj0N4lOaLA7
 NOZgWcsW1po8ZRL3HFOu05ouGPd9a0XD2FmokdcLqfAoOjZk/EvLUZTyPkzKKJ47iAg6
 LWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743433604; x=1744038404;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AXSjo1W52Xy88TwmECCy3b3lXYV8/OkwXK23I4eDv6s=;
 b=Sy0nfgKRFrhKstLfoOQSemo0Xjp/2O1ui1Wzxg1Zlk4FCjYejixPNxkfd0nlgp5Dmj
 BvrWgBJZlsYx0oyd5bx0vxryGTqizxtcuQSbzampGn7JNc3s9TqMptlvEUCxFNpRVewC
 4LqTUY+5PPQQQAmVXw/H9QdFmM3gVUkb6eZHRelqJSjBrBdjnBsFGGRaf+TKR6AZUFFk
 34y5XOopn2tDGKaH85tK8j+qQKjU/SYWe6Qru9OiHhy0LQhCx8r2JVA9Pnl869d2yHxs
 N3wuTL2wXMyTv3lGtFSR046H4V5cXdzQq2ZsqCkdu1PD42Z/0n7mTBVuSYYZIG9YrsDI
 weRQ==
X-Gm-Message-State: AOJu0Yx8cYdRebhocOeosdFhZoEzqAo9/R6KOGpmS7NMlOlCQZF/ITrH
 qGfAqpSz3YN/MvatZd8zT4Gl+jP7lPKeyWvUopNNagMa6yZ33Rqy
X-Gm-Gg: ASbGncucnZ9uMcViIDB8bWKjanvupLZsXm/PmohKy2lVFVDfh5E+Z4uWoKW9J8da5x7
 kSvnMb/fDb80Fvsb0IFMExm98YvwIFo9Riiwn+mwqTAEiaEp4/9WZ4svmg22Yop5lTI1Ef6Xavu
 Fu+GQ+6D16c0KYJYAj10knVbrzl1SA+yVjUXPYAPl1Lo2FJoLkpNlw+mNAiY/XSd5iAEVp982UI
 5UhQniaJ1uMjOPbzscdHewaKBYfd8Sb476MPhI6dYLkmopGp3KontBElV3ZZrYk1LJ9PqYLidUh
 PasekmXkHhZT/tg8kw9InRdPj1IqP03EPKydipvLrgTG7c5aht7GkoGzk9XFDgrvT01bz0l9UA=
 =
X-Google-Smtp-Source: AGHT+IGcXQrvy9+HJPFdtKKquleNdhn0qhQPtA4fIYxLqFlslFZsGIqQCufQTqrZDE3nXUaSRCWQlw==
X-Received: by 2002:a05:600c:45c8:b0:43c:f513:9585 with SMTP id
 5b1f17b1804b1-43db6247b2cmr81968875e9.13.1743433603288; 
 Mon, 31 Mar 2025 08:06:43 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f84sm124324085e9.25.2025.03.31.08.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:06:42 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 31 Mar 2025 17:06:32 +0200
Subject: [PATCH] net: usb: r8152: add device id of Linksys USB3GIGV1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-usb3gigv1-v1-1-04374174fab9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHev6mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY2ND3dLiJOP0zPQyQ11TAzPDNDMDy8SkZAMloPqCotS0zAqwWdGxtbU
 AJKCDAlsAAAA=
X-Change-ID: 20250331-usb3gigv1-5061f609abc0
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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

The Linksys USB3GIGV1 device is a USB 3.0 Wired Gigabit Adapter
supporting 10/100/1000 Mbits/sec transfer rates. It is based on
RTL8153 and it works correctly with the r8152 driver:

  uDPU>> usb start
  starting USB...
  Bus usb@58000: Register 2000104 NbrPorts 2
  Starting the controller
  USB XHCI 1.00
  scanning bus usb@58000 for devices... 2 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found
  uDPU>> usb info 1
  config for device 1
  2: Vendor specific,  USB Revision 2.10
   - Linksys Linksys USB3GIGV1 000001000000
   - Class: (from Interface) Vendor specific
   - PacketSize: 64  Configurations: 2
   - Vendor: 0x13b1  Product 0x0041 Version 48.0
     Configuration: 1
     - Interfaces: 1 Bus Powered Remote Wakeup 180mA
       Interface: 0
       - Alternate Setting 0, Endpoints: 3
       - Class Vendor specific
       - Endpoint 1 In Bulk MaxPacket 512
       - Endpoint 2 Out Bulk MaxPacket 512
       - Endpoint 3 In Interrupt MaxPacket 2 Interval 8ms

  uDPU>> dm tree usb@58000
   Class     Seq    Probed  Driver                Name
  -----------------------------------------------------------
   usb           0  [ + ]   xhci_mvebu            usb@58000
   usb_hub       0  [ + ]   usb_hub               `-- usb_hub
   ethernet      2  [ + ]   r8152_eth                 `-- r8152_eth
   bootdev       3  [   ]   eth_bootdev                   `-- r8152_eth.bootdev
  uDPU>> setenv ethact r8152_eth
  uDPU>> setenv serverip 192.168.1.253
  uDPU>> setenv ipaddr 192.168.1.1
  uDPU>> ping 192.168.1.253
  Using r8152_eth device
  host 192.168.1.253 is alive
  uDPU>> tftpboot 0x10000000 random.bin
  Using r8152_eth device
  TFTP from server 192.168.1.253; our IP address is 192.168.1.1
  Filename 'random.bin'.
  Load address: 0x10000000
  Loading: #################################################################
  	 #################################################################
  	 #################################################################
  	 #################################################################
  	 #################################################################
  	 #################################################################
  	 #################################################################
  	 #################################################################
  	 ####################################################
  	 6.3 MiB/s
  done
  Bytes transferred = 8388608 (800000 hex)
  uDPU>>

Add the USB id of the device to the driver to allow using it
from U-Boot.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Note: checkpatch.pl shows the following warnings:

WARNING: Possible repeated word: 'Linksys'
   - Linksys Linksys USB3GIGV1 000001000000

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
   bootdev       3  [   ]   eth_bootdev                   `-- r8152_eth.bootdev

total: 0 errors, 2 warnings, 0 checks, 9 lines checked

Since both warnings are related to actual lines from an U-Boot console log,
I have ignored those.
---
 drivers/usb/eth/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index e3f20e08c33cac4f8520dc670d22a1be6f3f10e7..d8f41dd1eb51cbf09c7da124ca8350e431c2b7fb 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -1599,6 +1599,9 @@ static const struct usb_device_id r8152_eth_id_table[] = {
 	/* Samsung */
 	{ USB_DEVICE(0x04e8, 0xa101) },
 
+	/* Linksys */
+	{ USB_DEVICE(0x13b1, 0x0041) },  /* USB3GIGV1 */
+
 	/* Lenovo */
 	{ USB_DEVICE(0x17ef, 0x304f) },
 	{ USB_DEVICE(0x17ef, 0x3052) },

---
base-commit: 3d8be1f5ec30180748259a251efe4f63c8b4b329
change-id: 20250331-usb3gigv1-5061f609abc0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

