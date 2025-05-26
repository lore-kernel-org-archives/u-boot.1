Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA6C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCE282F75;
	Mon, 26 May 2025 16:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="2y1ew1Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D741E82EA2; Mon, 26 May 2025 16:24:52 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABE282F5D
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5fff52493e0so2760443a12.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269490; x=1748874290;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=INOLQvXHasPDi++M72+sSJj5/hOlXOAqjMjjG7n7pn0=;
 b=2y1ew1Cxl12OSTheiim/2y/1qFwCxPkBeH9A/IkNoFpUqgx/Ec9Cqmk9UrV1dO49I2
 sRP7KytbfC+vH8Dyo91HJwXH38V33nYRDp4UQt8XZXx2H4w7mIkLVWFkW+QSehvKlNad
 8ykComslhEDDuRHBKarvS3w5jtWPjlyAMPQ88v9cHcljWqvbbNtOen67V50ICmxXlsox
 4oFq+mTWC++ECz1STzE/2HQeYGYHRTDMR1jDuWf1kftefB5dN3DVf37ch0K8fAb7Q6QQ
 rL2tyiggV/VdPxVNEkq4bQ+6zL/fxoomug7L5QjtE2iHdr/zagB9Qnl69kSlSB3X3mHb
 69qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269490; x=1748874290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INOLQvXHasPDi++M72+sSJj5/hOlXOAqjMjjG7n7pn0=;
 b=jhBKoSprcpKp0C20OQXPGki3NuJlXObysfx7QCRXO3wWEn1T4N9D8La6Te+KZ6BP8R
 QzrVrgv6VYZEoRP5rLCnb++uPk/BPJj8u5ZOVxdLlSix6Ir31hTLUG3hSjeVaYTWmK3Q
 bq8R1zjgaAPni0b6haWe+kchd2ugwJFeemNOmZndZ3OWZWe8B0dTAPlO9dpF9wN9Bge9
 204BPl8vBAJGhm3I/8ZlT17y1ixWkOYtbbHuz2j1lVzwavNwvAatZnL6hN7FjI1w8tJv
 W3SEpRhh8KTkMwNm7kIc2ogVSbIKkyUEsUdIc+y2nYEAw8ujPf3T2jSEFqgorL2oyWwX
 ZGjQ==
X-Gm-Message-State: AOJu0YxFn7n6CSuUhozmhvu6JH1kHirNauFqzyX6On97TvIbCx28hOeN
 FrFsPrlPDK6RH9SAZasdSNnDF/kw4FBMXg7pw+ftC9dzNAzWvkOl5Z5IMJXhhFzHb2cJTT4x37I
 soybdRWf1kA==
X-Gm-Gg: ASbGnct4iaUhmY1j8oN6kUtAb0zkcQ7OVDfXsh4fbjTD9yZZQ56CTao51dsO+Vpk7w5
 zFv+nB5wcT8Z+wHet9y1rJFE1DC+dnoSM57sSxjmh+c9w5dwjBblxZV+KpEwto6ECtLS2A8pDOe
 cKl2yiWAIGzM3+6Tz7oh4nelX1aA8QrEZ86e4OGmSOPL+3Or8GHQQSQS2bK2PLRpq0fdxdDDnmZ
 oup8qc67gyQEONkn/ghiKoGKL1H+ee7QIWNHqVUM5AAqG3XbsIEus4fPsVlBT4Dpmm5CIhBvRQ8
 fWH3FESN7HKMOUsKZvM3HKlZ01B/uMPpu1qSj7w+kBaDTF9U3TnxE6VtlzighJpU
X-Google-Smtp-Source: AGHT+IFQc3as3fpXgAt++i6xjOIqPnOlOD/+/wqopjKiFvJH0vDU6oI0/NPqHZoW6QbiS2nOkJmmmg==
X-Received: by 2002:a17:907:3f1c:b0:ad8:8529:4fa5 with SMTP id
 a640c23a62f3a-ad885295437mr112762966b.46.1748269489742; 
 Mon, 26 May 2025 07:24:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:49 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Mon, 26 May 2025 16:24:24 +0200
Subject: [PATCH v2 5/5] usb: onboard-hub: Add support for Cypress HX3
 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-5-f382415da84f@thaumatec.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

The HX3 is a family of USB3.0 hub controllers that comes in
different variants: CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.
To support this hub, controlling of reset pin and two
power supplies is required.
The reset time is set to 10ms, based on the datasheet [1].
Power-on delay time is not required, so it is set to 0.
The compatible strings added to of_match table are
compliant with usb/cypress,hx3.yaml bindings.

[1] https://www.infineon.com/dgdl/Infineon-HX3_USB_3_0_Hub_Consumer_Industrial-DataSheet-v22_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ecb53f644b8
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 2d2114ea6d17..244d7cfb1294 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -269,6 +269,12 @@ static const struct onboard_hub_data usb5744_data = {
 	.supply_names = { "vdd-supply" },
 };
 
+static const struct onboard_hub_data usbhx3_data = {
+	.reset_us = 10000,
+	.num_supplies = 2,
+	.supply_names = { "vdd-supply", "vdd2-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -279,7 +285,14 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
-	}
+	}, {
+		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
+		.data = (ulong)&usbhx3_data,
+	}, {
+		.compatible = "usb4b4,6506",	/* Cypress HX3 USB 2.0 */
+		.data = (ulong)&usbhx3_data,
+	},
+	{ /* sentinel */ }
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {

-- 
2.43.0

