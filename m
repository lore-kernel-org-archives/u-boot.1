Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1025C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC6D87BC3;
	Wed,  7 Feb 2024 11:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="nHCVqDpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F566879F2; Wed,  7 Feb 2024 11:24:39 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9157F87C9A
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3394b892691so243629f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707301476; x=1707906276;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qB3UVRje0pvHok6Yl1XNRFfmX7JHLLcOEjdFn+Y/2sg=;
 b=nHCVqDplP9JjU7TWiQwktEw8SRUC23XdQScyLSSF9KciEm/VXpueuh1NVvhMUKIC3+
 u2zjWtvdDqaTdQIH/L5NH8d2Gp1sPZdpwj3XA49p86W0PsUfbXNI/2tUMvTuP7dSGBhY
 SM5gPpaZewyqO9lNJCDevehKjh1I3F+CnrjTH7hWeZWiUGgx8wiJiuoLEL7S3uvqV5sh
 qdpdWMd5YIzXDHIZ4gRvC2wBiJ5iSrbN5RtIHwWpWldMF7XddsKIVghNMgKvrbboiQGm
 LcHbb3sZWWgd8J/2YJ9u874yeAQi/pSi/HblL7VxzJbkkKaHB0or5cfDwYvLn3X4XmKm
 osCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707301476; x=1707906276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qB3UVRje0pvHok6Yl1XNRFfmX7JHLLcOEjdFn+Y/2sg=;
 b=o0OqllFy8yMYFw/cm+jZrHspjtKr01ubBDRqKwYIAOR3IXhxEgkMCHI/1/7dCoTFM6
 fdyqUkojiu+EdvUke4UMRrxM/qqMA0dhaDk63bde8C/ICXHNiT+9RVzNDcBceWN9sH63
 xAJVyhFoVW3zfiO/SMIFXXwzfHnBUZKTWK4Xnkuf9YSmkERaQbJTCZ/AO0Gjc6SCzNIh
 kbZH9kpflI1ZfEj6knHqEVrgk+i+Fbb241bvEIQstJ5RrmrxYq66WSG9oDvCi74niIby
 fpywksZw+Wdq92gQLxhSmD3wqL7GWidpW6PzjUP5BJD5ZH4tptL2FnEeZa2zYkh/cPZM
 AX5g==
X-Gm-Message-State: AOJu0YyN6C0euLwJzQoWa3lMqPGkr7LRKk+Eacko3xplbxha5WWuy5bw
 4Lmg92UuxoWnnR8iHjMO1VVYdM9Sflze1y9l+C+rZstmhSRu3GziaT6Q2i7Ys6N2P0Um51K7YKA
 D
X-Google-Smtp-Source: AGHT+IEaURd3lCzbXli4pZdAswIwHfwGRLcMhG3tJui1wLRWP3/eBMI4fw8NVQidBJSTlVNzQ54MxQ==
X-Received: by 2002:a5d:4112:0:b0:33b:1a58:c70d with SMTP id
 l18-20020a5d4112000000b0033b1a58c70dmr3130176wrp.26.1707301476539; 
 Wed, 07 Feb 2024 02:24:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUe+ls+dq+DohsxtlzPl/BbqkZQYOpvND0x2UNR0psMVE/r6Aho/JnridYnAuSW4cZypjCt6wATRhFK1Nas3CPRmBjROIRsubJMqGeLRyx/EYGtkB0v85FMAwEjuQRqTdeWkT9L9QjrLb2k/baw2jUBcIfnSR5U6oKS8LBQMuy9ulN0p5+nnEAMQPuoJeOamK3SB62vLccf8w==
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 l1-20020a5d5601000000b0033b406bc689sm1137790wrv.75.2024.02.07.02.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 02:24:36 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, dsimic@manjaro.org,
 Shantur Rathore <i@shantur.com>, Hector Martin <marcan@marcan.st>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
Date: Wed,  7 Feb 2024 10:23:27 +0000
Message-Id: <20240207102327.35125-1-i@shantur.com>
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

USB 3.0 spec requires hub to reset device while
enumeration. Some USB 2.0 hubs / devices don't
handle this well and after implementation of
reset some USB 2.0 disks weren't detected on
Allwinner based boards.

Resetting only when hub is USB 3.0 fixes it.

Tested-by: Andre Przywara <andre.przywara@arm.com>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 common/usb_hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 3fb7e14d10..2e054eb935 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
 
 	debug("enabling power on all ports\n");
 	for (i = 0; i < dev->maxchild; i++) {
-		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
-		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+		if (usb_hub_is_superspeed(dev)) {
+			usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
+			debug("Reset : port %d returns %lX\n", i + 1, dev->status);
+		}
 		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
 		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
 	}
-- 
2.40.1

