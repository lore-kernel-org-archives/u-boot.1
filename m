Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEF1CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB3E68918A;
	Thu, 19 Sep 2024 15:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6vEcHj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BFB89141; Thu, 19 Sep 2024 15:59:16 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CD48918A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so1010854e87.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754353; x=1727359153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h8gveJr1jpioliXNQU/0UQqz60zXbSk5+IQRUkStSTU=;
 b=V6vEcHj6wsOYWXWP7j/HZWqmDPp3ad/811m8ti8RgZyzz5VMBgoWq5BfZBblmpCAZk
 TaJNQ5wBxoQ2ZKya2ujz2XtTjWakyGH2ck4adqqKCiZ8S+AflWj73WppGKSnDMKD6C7Z
 53XuaN7paLj6GY0yZYXnLVS2cy9vnjntAx+wVik745A7giu9dg8x8WJIgObY+eKRlz79
 qixKHSJDmCvLIp2DRGWcAfuIBUTv1EY36Po7izovEB2MYipFid+RwZu3v5gZKO5Dk1Ru
 9qvHFpk9KDbfXuhxnlJvvUzBrOyEczrLIe0IeTlWvL7UeBC0Gk1VMKU7aS5t8h/qLuIV
 S2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754353; x=1727359153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8gveJr1jpioliXNQU/0UQqz60zXbSk5+IQRUkStSTU=;
 b=r6sqYYYga5yv5MRs6oee554ZIk4DSOVBdDiiu9GSPZrRnuMdANMYmUSrr+tW1ycRvf
 AyBNBuIIzaeLlRNYVFrbqqG7xqfH54JIdm/kd1UgWiFElqM06ODMwQo0jjTqqxpa3UJr
 dTuymiatfUiblagUSPWtJpRI0CB8zaR20y+4tncsChDsdRY2RdHG5CTQ7Kf4O+6NBFyI
 HrbV41OJ1kG7ZBqOSMM8G15K50u896qdRImHJF1Abn1+8qr0l8LSX3G+7VIUEHXF453B
 WkwEy7ffIsn5zmgl0Q4tNiBikLqiz8+5lkOQ6zYzS95pm8d7wO5G46cMvZVwmDRMoXGn
 yFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTNB7248kX1T88aUBYAqbn3CEMt60uqddzvHCekAdm0RNoa5cnC0xI5H1Ui4vY+oDOr7MhODM=@lists.denx.de
X-Gm-Message-State: AOJu0YwKDY+Ek889eJ7UnHzz1F9yIRasd1PyxeY03tg2uro6yrnre3/k
 QBIbsz2fW8uiD2eMPyIpUYN1Lqh6HQOosMQaCjgu1WiBjexePSit
X-Google-Smtp-Source: AGHT+IGgyyYFS1NzOvsyQHdbIvAEws6efcoa6oyprwup5J+7OtnWWNGrmJOUGxnZMjwCEWbzqX8aeA==
X-Received: by 2002:a05:6512:104c:b0:535:6942:29ea with SMTP id
 2adb3069b0e04-5367feb95c8mr12776300e87.11.1726754352997; 
 Thu, 19 Sep 2024 06:59:12 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53687096581sm1864108e87.168.2024.09.19.06.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:59:12 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1] eth: asix88179: drop ADVERTISE_LPACK and ADVERTISE_NPAGE
 advertise flags
Date: Thu, 19 Sep 2024 16:58:45 +0300
Message-ID: <20240919135851.153120-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Some USB-ETH adapters based on the AX88179 (ex. D-link DUB-2312)
has link issue if ADVERTISE_NPAGE flag is set.

Also Linux drivers for ASIX chips doesn't use these flags.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/usb/eth/asix88179.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 4bd3b9d10d..1f469a1a7d 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -345,8 +345,8 @@ static int asix_basic_reset(struct ueth_data *dev,
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
 
 	u16 adv = 0;
-	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_LPACK |
-	      ADVERTISE_NPAGE | ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP;
+	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_PAUSE_ASYM |
+	      ADVERTISE_PAUSE_CAP;
 	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_ADVERTISE, 2, &adv);
 
 	adv = ADVERTISE_1000FULL;
-- 
2.45.2

