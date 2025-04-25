Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B1BC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AEE820EB;
	Fri, 25 Apr 2025 12:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="OnuqYTSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92918820F6; Fri, 25 Apr 2025 12:56:44 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6AC820E1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso399772166b.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745578600; x=1746183400;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oiIN99+hjW59qFNpB5QrKrRlUzsHhtl6UdhhmaBKLAg=;
 b=OnuqYTSyzkJ7uOdDFAzf9c//R266iNHOlXFFH8QEorAPCsfv5vIVfUv7kC4xQygIW0
 ecS/7s/10bfDBjll1xU5O8koDQUf0AvD0MSxqyorV/UvMc7VY4WKTwHaMMJ1k4kdq2Ji
 gLRTA1OA0rBYhUmZAKHRnSmFjHV+TJtRifb+1sjTrAfxixCcyh3oxawaH6crd3q7u6e3
 3W/3dgllw740rlseiQZ5h4iIpQ6htt7J6CU8EkOI0hVbn5jnPPDQNmwUnG6+TMGjmDuC
 vQU637bEykb5Krx1f8UsdYEqhKGghMOUaR1KuxuXrtGhWYi+E6emKJG1n2VETjPa0yyu
 9cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578600; x=1746183400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oiIN99+hjW59qFNpB5QrKrRlUzsHhtl6UdhhmaBKLAg=;
 b=fFNvM6m2QVm0I0Zqirxhl0vWl4hJwTQMn107sjLrhaOKU9h+6MeTtwTrk/+017iwT+
 2NmjwJBBj5HfBLfQsYELXHoOKBWcKG8cQCWXzoqJiEtHudm31AfkDOOn+hXaqnc+iagm
 KC0F4aJXe43A5f08F8fUx9ETq9Q3svaAxBt1nPOZA0FjxayjMPs0G5Rnfxbj00DaGYqJ
 SepgMFmyc7GhLLA5B0/ksc3aTJ+qIM+JuK1KtFbNhWjJW+ZMZqimD8F1tPDJDXr+5xTz
 mxESlsrWWV9tPERuNMY428HseXzeBCYxvUFL8LN339JKBFf19hfxuyLyWEfPnMVtwwU1
 Hh6Q==
X-Gm-Message-State: AOJu0YxCywdedjBnDxVtRzlWcM6nvZUQ6QWIGeUYuHhWlJB31uDmX1h6
 RxTmKLBnNb8Bw4kuCee1mkFTwKiKDm2Of559eX/utKDbKEJgQwhKPy4gNU1SsCso3kpq/q4uoXP
 N
X-Gm-Gg: ASbGncvlSpsxeGuWBBdrThiukzmH+eomb8TJG8BEwoBu9o1VUoGU9gH/AQwptS/RyoA
 wIWfBjqVvrNTByA93xyD6mhmkN4ic7++v1cAU+T5+nJvAhBvRQsdi5R5z+maD2nFruYOJiFo6N0
 dodWxR4Yk5cH7CLkMJ3k+xXWvabIoQlgT4G9IOG/8HdN908aDva4brxk0uy/OMba6JYFAzmcwFz
 8KHjqN+WbT1Ai96G6sEqfMEdA/L5CA2FK1kWLQeso36WZfIhcaj8CYOqlNuG+b8MLpC2Pb5V7ck
 TuVKXni5la5N1pcfF1JbCO4x3QDvC+ga0e+W2MWO4SlibQaRqXKeede+dA==
X-Google-Smtp-Source: AGHT+IGnuwbtLriX4CriTB4QSGxWUDvX8nHsfrYkKKEcxAY8+BeiEaAGppb7AqQ42MQnHb+lWajH6Q==
X-Received: by 2002:a17:907:3da1:b0:acb:107e:95af with SMTP id
 a640c23a62f3a-ace713ab6f4mr174863966b.39.1745578600278; 
 Fri, 25 Apr 2025 03:56:40 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8978sm116839566b.98.2025.04.25.03.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 03:56:39 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Apr 2025 12:56:35 +0200
Subject: [PATCH 4/4] usb: onboard-hub: Add support for Cypress HX3 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-usb_onboard_hub_cypress_hx3-v1-4-3cc5a06087cf@thaumatec.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
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
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index b8fa38a4111d..8d2e40475b25 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -255,6 +255,13 @@ static const struct onboard_hub_data usb5744_data = {
 	.supply_names = { "vdd-supply" },
 };
 
+static const struct onboard_hub_data usbhx3_data = {
+	.power_on_delay_us = 0,
+	.reset_us = 10000,
+	.num_supplies = 2,
+	.supply_names = { "vdd-supply", "vdd2-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -265,7 +272,14 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
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

