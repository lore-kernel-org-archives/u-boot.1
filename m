Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC75EC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E41E83839;
	Tue, 22 Jul 2025 11:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="CXRBQ4U2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D800783346; Tue, 22 Jul 2025 11:56:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC99833C6
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-adfb562266cso867290466b.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178162; x=1753782962;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5SZ4zjzvIkPoijlTiIQPxtXbJwyWdCPxC95IgclF5Q=;
 b=CXRBQ4U25iobLHVps3t1nI6LV0oCdV4mLShT0bH006J6XdUp8n+M41bcTNb9C7ZU9f
 Z+MTdreiUeY+49NOvumxvmRhmlqsRV4+VRzhbVuK+fyrvoizI3tt/vawMUvHYE5yoIoN
 pYj104A2CKoJBYv1Mk/ittmeazRvd2tZB+b9yqsMemlB6ybtvPZ4Wj4nGiUaUOp5i6OG
 hJv789+32ZDxrnVoRV6G+WxfSXxS+6BNuDhIiiQrP7dC65D8QRDHzYrvJYz8/ftMedfX
 XoKzu2U81uVsUjKkuzGzE2XLupzPeFTFStFemK37+HzBlGyzceiVh4p15vD1H5Sro1bB
 df/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178162; x=1753782962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5SZ4zjzvIkPoijlTiIQPxtXbJwyWdCPxC95IgclF5Q=;
 b=jcu2cd6iOKY7H91nnBJuZObBDo9kHSZNlC5cnRHQxr6o0WTjNvxmBFdv3v09FDNhIr
 V9fq0l6zkyhSA0vFS0OFeJVprwPLwKzN1LXGzCPUwhQu1TRDSaiv8h91BbtWkl5r4Qlw
 0wOtX3u3eVlanTabxWpi9WyJAFjwRuMkmNLxblQ9/A0O9/n3xHEeLp88tOpTlS1XkCAT
 TMcHhwW6LdShHVT0u0AifIKMidJYrplR9klQLu9/pxLIn9KJPTwDVlO1MsyjG9Cr4BOb
 UPIMwthhFTLiGm/0dsquhMiNYopyF3pY7XWQzbMUEbva8JtEtOVHnbK4iWlbbGI0ygJX
 PapQ==
X-Gm-Message-State: AOJu0YzAqVOIZqPb+zJ6T7fIXioUkNqnFLaq7/g7IDEH6fqkP4kmxYZK
 rn0yJUNKtXD4Gw7+kTtmmtkLtDhsAlcU4x2pQoezZz4eRehgaXMXaqvakM1zmMTnIlE=
X-Gm-Gg: ASbGnctxgcStvrnvHWGoz+PYjYYu+3JeKjzDqnl/T7GlX0ywEEaTVci12wlXnRQ+QQ8
 p2LoMFyJIEAU4gmLOTHSTGqJtwMZd9wg0gKdbmBLuJ3qCGKiM1sus0PGjUI2ou+Vl49OJcDnAD9
 QUk89RzpCs2E7RjqIkL8t5F14NohRfOM23cCib/fxr+O6zjr9/ImxOkbeNE+JEgEbkHIZh64xJe
 VcRs6Qq3G9y//9Lw9FvD9Yk1frQB/TvWDz0tSZDPj3Vu9u+WkrsmnvcRInkJIxXrP5gkDFdC3Oy
 GYhc8dakB6/aSkEkhfs1KvUSU+CcXSdlaN2u14mfV8lNc/1q9OX35zXKYsGW+Nu5HpMJMOA0Jp5
 TVloPE0esnMvUyb3pYrrMQGg1KqBz1poslQ==
X-Google-Smtp-Source: AGHT+IEL29o4k7Y6Znsu05I2cJM6QrfxAP/THI50mgFK5NLrycqI0gOfy/iolCERjzkmEkpkJDuNnQ==
X-Received: by 2002:a17:907:9625:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-ae9c99442d2mr2366225866b.4.1753178162094; 
 Tue, 22 Jul 2025 02:56:02 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:56:01 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 22 Jul 2025 11:55:37 +0200
Subject: [PATCH v4 5/5] usb: onboard-hub: Add support for Cypress HX3
 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-5-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
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
index dbe4c3cf9b83..805b2ccbc009 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -272,6 +272,12 @@ static const struct onboard_hub_data usb5744_data = {
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
@@ -282,7 +288,14 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
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

