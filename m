Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474ACC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3837882F54;
	Mon, 26 May 2025 16:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="mSlRl1rX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20CB82EA2; Mon, 26 May 2025 16:24:50 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779B082EA9
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60462000956so2124811a12.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269488; x=1748874288;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YZrcSkXFFHpDK5h4NcqfdYFN0yKokP0/srWZAHMfWKA=;
 b=mSlRl1rX/eR+DJjgEOg37TDziy3r/V0Ia1kbV5HAxhIXQVS9tuxwGd+9mM73CTShoE
 d1+suEBnyrwoLHaY7cbNRtTo0ZRdYj1t+GlquxLseF7kBtdlUblOsKwZkTFI0G/CV0mU
 VWIVQdwKrqFr6qNtS4xlYwtHKw5kNY7U4Osy4nYfW/rKvFkn9hEGqXHd39HlS8riF4Kk
 cZ8kCOAhYS1v84P2PoxWMTRHf8en3o8/dJcY9QSflQtT+2ji6DvtIgtXveFeGCj+vmrU
 yutnOJ3fhg+rHI0I2IuE8JWNQsZPyzGbiJFtGw8Fi7fXO/mLuAvEVRstUER6RHQjyj7K
 ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269488; x=1748874288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZrcSkXFFHpDK5h4NcqfdYFN0yKokP0/srWZAHMfWKA=;
 b=O+7OxiTqboZAvacO/slp8hFnpZuef5XZ4DzIrnksKWzNC4/LcocrTWxRs/XXX97n/M
 cXHZwHrgTgyPHKo9mmXLF9k8oJp7t+RV265Ek4WGtkUDbmZis4vwydRjn9RQnq1V84wi
 +LNZvuGudGUIXxv3HY0zOTJ6hbTpZs96LldLu/QFFfon1Ibuu/W5x204tZ9yHrKDOC90
 sP0e4BKdRraNCRRXLY3OzUj+HYGagy7e8KtCXzlIp8Bk65XZHETE4j7l423q6qC6cakm
 G/QVZiXfSxDlZUmcNcj3UoPNfaKiVEVtDzglaOEnCV8Ik6EwSSjmVIKFjqNkjdqXE/0o
 EnKQ==
X-Gm-Message-State: AOJu0YzHiihR1UuDm6W+2jV4X76rae9K8h/3GOTNJt+SRPWpPb/4nhrt
 vSdvYHwec6ZFR+cZgBbxaJ82w233pmssgjsRkQab4kUepgTrGzFJd2Z19yR53P24tcBiUdYRBCD
 p0o2SiMw=
X-Gm-Gg: ASbGncujnlMjW87AfY8Dmri/s2XS0+hY72o2Vryg475mdx39SlikSIbLXzdobLLPr0f
 GhO/zi2GZ8SZmykm2zyW4P5xMiT8vbpWBI55fZOWiNqvfkd+a8r6bowPBTWhXjNMqCy7nurEl/r
 Jcctfr9SmU6yZaRyzzTh2Yo+HT89/FXV+NPExo9pU8MVn9qTcqV3BGfRjVK0o48CoYgEx2eF2pB
 cMCba8GPIGValBK73pgsvKBMnX8CcTsfCKMqMaAeCv1j2UCwCYbdT1cVijUA9KlmC/bDWEY+7Mt
 GQ5kMgHU6VPZqy76hLWusK3BRLUOL+NK9HKmPmFYsMnmOUBmpqvINPNge4Pbwy+w
X-Google-Smtp-Source: AGHT+IGQtW0lqhAi/CM2Ze6jSr72fmfqTzoPoiN8EvoGxpkdDTy2DWbM2vcmCRec7rBCiMolTBzwPQ==
X-Received: by 2002:a17:907:da7:b0:ad5:2c48:2835 with SMTP id
 a640c23a62f3a-ad85b1830b1mr813944166b.18.1748269487774; 
 Mon, 26 May 2025 07:24:47 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:47 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Mon, 26 May 2025 16:24:22 +0200
Subject: [PATCH v2 3/5] usb: onboard-hub: Set the reset gpio pin before freeing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-3-f382415da84f@thaumatec.com>
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

In the usb_onboard_hub_remove, the reset gpio, if available, is
freed. The pin state however, remains unchanged, as set in the
usb_onboard_hub_reset. The hub is then left enabled.

During second onboard hub probing, the hub is initially enabled
(reset pin in state "0"), and then it is being reset by the reset
function (transition to "1" and then to "0"). Because of this,
the hub first disconnects from root hub, and then it connects again.

When the devices are being discovered in the usb_scan_port in the
usb_hub driver, initially there is the USB_PORT_STAT_CONNECTION bit
not set in portstatus, but USB_PORT_STAT_C_CONNECTION set in
portchange data (which is because disconnect event occurred first).
In this condition, the driver does not wait for devices to appear.
This can cause the hub (and all child devices) to be not enumerated
when rescanning on "usb reset" command.

To fix this, set the reset gpio to active in usb_onboard_hub_remove,
to put the hub into reset state.
However, in case the hub reset pin is by default held in high
state by HW before U-Boot takes over, in which case the USB hub is
active, then during the first probe it gets reset and we might get
into the same issue of the hub being not enumerated.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 286f90b22c24..dcaa24d30ece 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,6 +211,13 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
+		if (ret)
+			dev_err(dev, "can't set gpio %s: %d\n", hub->reset_gpio->dev->name,
+				ret);
+	}
+
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);

-- 
2.43.0

