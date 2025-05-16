Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859CC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 17:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A85780107;
	Fri, 16 May 2025 19:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="guVirO1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529678059D; Fri, 16 May 2025 19:50:30 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCBB8006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 19:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54b10956398so2770396e87.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747417827; x=1748022627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zc2G1dEjS+bRPAeWnJ6/US9IuB3gsWxNDyIUDW9ssUQ=;
 b=guVirO1Jef4L+JCLdH9IqUkcWNmSJURo5FAhGcLpm71rwF60HCkXfS2N2cNd/2SdvZ
 6qOBAA87IeCg7KVkZ2D5a7EYeOEhQMnvLJU7p/9gqzO9IysAffc9z2yM/5BWBfL9IaiF
 P9qaU9Zd6nECl2c0w1KNf9+j+8Nr5KU+xk8SgH/pOT7QFsbNpksegDniCJqvzNYYyR5U
 dkI7kQ21IxWRZEzlRsq6WBlrZd+jpKdFqquowWrsYBkg+aIhH2j7gfcAEHfYxYzw9f85
 +M3rAwdl74gW3fA14nJ/dcJIXcgAGiXzt/39/ztqAgd0pUVyS4vwOVn7ojPP1FjIva5s
 eeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747417827; x=1748022627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zc2G1dEjS+bRPAeWnJ6/US9IuB3gsWxNDyIUDW9ssUQ=;
 b=ndMZIoOJLFxsXeR+lyG4oZ9eYIGDJOlFPp//bhasqyAfkuBvptmtdsB2b7r8SACcto
 CJ3+0BsNIV1af4d/dGyJpyghSAGZmLcvbZE92mdM2wqA2PwgjSocGsDMe7s9eRlGlBzc
 +B/XbDQE/9FsILtAxS0Vg3sfIYZXo7VOzqXuFicX61Plc9ginD5CnR0EENtwIdBjvyhu
 mYzcAbo2v1+8KRgF+rHKIb9ol88+tPl6zMNuld6fivEqueMgCcNdhsNuq1lMAVQ3dTbw
 a7yfFF5xJILbxgze46waC0rngAMT9LgIu66PTL1VZVe7q/rL6I5POJBRDaW7jdNnnu2v
 +JfQ==
X-Gm-Message-State: AOJu0YxWf36wez8rDitV61jmnsZiSt1ajFAMsaCPSQzT9UnE9Qv0dOeV
 uUMtnzNUj3tYDZyNTn0aAmzgt16AG32bt5aqb98sWYjp+3RFrcTd4RiJHmeCmSrn
X-Gm-Gg: ASbGncul6w4y6Yccj1XIxo2z6iV/2nNK2HAy4MdXVyzANRwFkOjNSNrEx7KmjhYvzW5
 8HHZ9Gf+HjejB6riofcDqhctggcwbUBVwl+ejUV6yhe6ZHB5QpjuQ6N7IpF0o9GiJocKmEE9ARz
 2t96keKvcGSQCMPrIecDPHs3COSW4zcUPe6BQY1qITmQXuNLqdZOcmiXiwRj/M/JVl6Adm8nSQe
 xKaPUSXLP596K3/kBfPQOb84E9liGebrfd8+0Ve/3yL/LD0ENYVTF/EwAJdBhhLkv/UnbwvPwju
 z3ARk5c6L6k2uH6rGsG50La7b5wq66FwQCc0z43AtI8Yo6meLJ4thP5Y/Neqk7fKwLKKSnpTTNB
 zKJzJiKmvJGRUbISoCQ==
X-Google-Smtp-Source: AGHT+IF+Dh1fUR71Y5UGG88w6e6aenDRmJIIWTBHoIRcDCQI6w5JeGyMXbb4S6iZIGD/ePcKQBhwOQ==
X-Received: by 2002:a05:6512:6703:b0:550:ecb4:94e with SMTP id
 2adb3069b0e04-550ecb409b5mr695152e87.9.1747417827084; 
 Fri, 16 May 2025 10:50:27 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e70180d6sm525157e87.138.2025.05.16.10.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 10:50:26 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Date: Fri, 16 May 2025 20:50:07 +0300
Message-Id: <20250516175006.122811-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Ensure int_queue is properly destroyed when receiving wrong buffer
by adding error handling path. Fixes memory leak that occurred
when backbuffer validation failed.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 drivers/usb/host/ehci-hcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7d5519c65a9..765d8b327ee 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 		debug("got wrong buffer back (%p instead of %p)\n",
 		      backbuffer, buffer);
 		return -EINVAL;
+		goto err;
 	}
 
 	ret = _ehci_destroy_int_queue(dev, queue);
@@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 
 	/* everything worked out fine */
 	return result;
+	
+err:
+    _ehci_destroy_int_queue(dev, queue);  // Освобождаем очередь перед выходом
+    return result;
 }
 
 static int _ehci_lock_async(struct ehci_ctrl *ctrl, int lock)
-- 
2.30.2

