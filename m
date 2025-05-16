Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AE1C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 20:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6C182B00;
	Fri, 16 May 2025 22:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxpWvM7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B4D82B26; Fri, 16 May 2025 22:12:03 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8814C82A8B
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 22:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54c0fa6d455so2866271e87.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747426320; x=1748031120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cubCGiiBY+T4oWEid8OwN03caIH/gILoL1BDFiDISJ0=;
 b=fxpWvM7HkArVxTBTZpwumt4uAxOIhDJnhG0vO8R3FUaJ4lCe40SI+wc13AWEU9uHSs
 N2opgWlQUWh1N5Laq9WRuHfnxLLAJw/xo36HB9bC4AZgjmmrgMv6/1u71EGf75V3obKG
 JCMA0WkesjyIOVejbfLcOBoQRaqat3cTPm/RamygxMMyc5gjCoGLoFNa52mr98tBhOlx
 hKu1bVQwkAQ1uLQB6zHUzQHNY+7uU6AaOj5LezRT4JLYgtEA5UQ1ErDUGINFo94C8nQL
 vqBHsnox9fP6/tF3hJWlTKSNTtEpN1REZ5iEtl7gzMRlaJA85qqOVcwv3vXu+R8TI2hp
 pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426320; x=1748031120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cubCGiiBY+T4oWEid8OwN03caIH/gILoL1BDFiDISJ0=;
 b=WouITFcEcxUswQ7McAgQYrFGzTSD6Eloh/h+zwgvAYhZrueq020bANDctvb7gFbhjf
 8HbWwu/5GRJnFNvkyhhxI0GOrdZTWEfajQoRfCWR0BbO3liW2mvd6D1GN/63EQcQoljC
 +axNs0SNOgLd5H4bA6Jp9fHKftZy5WqsRk9rheG/8oKtE8H/yZSzw5VIdX2S49DB76/3
 CeLOsUEhnF8jfhjH33nZa4LQjozMTqNCsbAEUAwAYshJ1/KRacmazEVJ2XOOJPF4lJWN
 bWk1aSpKCJva8i0owJI4laeZBgJsL5oeWu+wEcaAwuVh/qof5cNkinKtjHkedGwOPcdn
 cGDg==
X-Gm-Message-State: AOJu0YwF8ca7As1joo9dIm6p+CntprSheX9x3naPNWrk6FOLdcbLjJAx
 Am8K/h9dODV7KFSNFoqekCJjoN8iM6GtQvETfV7re99KRe8m++qRtaT+p6cGJ1j0
X-Gm-Gg: ASbGncs8d8kAjlRxONxz49xFyRuc4VWpo+qV1sw6rJOcX0eUQTH9MIaM8WUuKffvCg2
 eR2LB7xB/lrrrS826cKj8FlSk1IF+Myx9hxJrqy2DPjlW6hhSRABmGqWaBUtdzBRJFYKhWs3c4K
 +cmZR4Fv7GhAuyCIa+8vy+559mkI1yESpIZPbG9YCkRK57uw/lbAvPVhxmaIJFRiLWNeXWe8kEW
 m/2IMb6DApDMepXyEi8v0PyIvbOB14yQhw+yPdx9PMEkeYfFjI3TkUk8exNoY8f1YdcvDth4g0E
 bLTSS/1jvtIz9d5YpSARox1ZHyJPSEwM3mmpDVxr4B7QekmiWjmQ2oXXBdDV9iQcO8mq/fUcA1m
 dbenwmXiestK60EXVSg==
X-Google-Smtp-Source: AGHT+IGBZsjKPMS3thRv5JoSpwiUD7OAxS3F99PX41VA3xqlgFlFF0qNImc/SpxAznj8GduZDDSg/g==
X-Received: by 2002:a05:6512:461b:b0:54f:c56a:5947 with SMTP id
 2adb3069b0e04-550e719536bmr1421757e87.11.1747426320033; 
 Fri, 16 May 2025 13:12:00 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e702db8asm571873e87.205.2025.05.16.13.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:11:58 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com,
 AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH V2] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Date: Fri, 16 May 2025 23:11:38 +0300
Message-Id: <20250516201137.220130-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer detected a potential memory leak in _ehci_submit_int_msg()
when backbuffer returned from _ehci_poll_int_queue does not match
the original buffer. In this case, the allocated interrupt queue
was not destroyed before returning, leading to a memory leak.

Correction:
Ensure int_queue is properly destroyed when receiving wrong buffer
by adding error handling path. Fixes memory leak that occurred
when backbuffer validation failed.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 drivers/usb/host/ehci-hcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7d5519c65a9..75cd0ec71ed 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1556,7 +1556,8 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 	if (backbuffer != buffer) {
 		debug("got wrong buffer back (%p instead of %p)\n",
 		      backbuffer, buffer);
-		return -EINVAL;
+		result = -EINVAL;
+		goto err;
 	}
 
 	ret = _ehci_destroy_int_queue(dev, queue);
@@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 
 	/* everything worked out fine */
 	return result;
+
+err:
+	_ehci_destroy_int_queue(dev, queue);
+	return result;
 }
 
 static int _ehci_lock_async(struct ehci_ctrl *ctrl, int lock)
-- 
2.34.1

