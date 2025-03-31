Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340BFC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EF28206E;
	Mon, 31 Mar 2025 14:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K/wHSKNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8420D81FE6; Mon, 31 Mar 2025 14:31:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F27282012
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3351035f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424310; x=1744029110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1BmGfnz9Zf8enWa6MBJvo/gF3i4MJ+4iKJWgpAGdFA=;
 b=K/wHSKNBCjokhiNlz2uGuNFKgk8Kh17AVAw6cwznm3YQokFK9TjXeQJNuPsELiOMqI
 NA+Venlpd2TLxhdt5JMsI7FTC3fEu6O3Kq86NQ+XNDvs220qDAmE+08aXKMckX6HmA7c
 1SJ0Dx+cUhsv+wrWXXoJ+b5xKrM+bboZPUPUU5kuV6q3R1RGLf7KrNdGVe0qpEhqDWqq
 Ru7esbgLsuivpmp89GBW5QhIDDr66xgE89wnj9ZcZ1HE30twy4SpxWKafWYQfwTSmbaf
 T2uPpj1OQZ7JyTv1LZtNHp+OEMDVMFgQ9x/Vcdo9fY2//dzYmnbqP5GFw7FRIwWoQLir
 W/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424310; x=1744029110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1BmGfnz9Zf8enWa6MBJvo/gF3i4MJ+4iKJWgpAGdFA=;
 b=XqA3zzgvAucC1gcbwSxnn+3MYJ6517E3MiXVuB6C6YFLRVQF5jnnVI9GmRTf+i4USm
 Ahw73DBlpOFsr9UUIF6wNXThh++Kcj/2jIFBFTbHLCec1zhP420nbFxT7pomskqLdHhd
 FUQjN46yRKGuRMWm0LzNdgO2su8sB1LagB3vOb+4OHPsp7+YKLlzdBCAOjvByI9agUYx
 FxCBr8O4pzqMicaX5pvFjKPSA0dsTtvM2xydGriLqPbGYJGdAk9LH4O4zMdrmMWrBWpP
 ZGcK8bPeWXOP1TqRfFIMCCGMyl1VtxHM9v8aYkUHZFH9GjbqLUV5HichB4myu+Ml8Jnh
 GDxw==
X-Gm-Message-State: AOJu0YwcVKVMdoxugRWuO8ujTNZ+VZdpgwkk7xSdOxsDZP/Bt3D5A9lJ
 zlAex7+tSkuGNoWIN9BBgg89aV4fjiy7sF2/tkyVSfduMmZqScb3pu6EUrgjWtbKFpXLPZR+JuH
 tyhiLTg==
X-Gm-Gg: ASbGncvDR4TJGcZAAgExBq11CFI9wxLz0iFp/gS1p1nxVBMg7/mC0SXLkmiPgvAYFt7
 yFloRhh+UWXdXQwV0e+zZVr6qoOR2PA0drzlAftkqTXEl2j+K5UmIbZ+z7MO07E4Q0qzn2YnTOB
 OBlJ213WTOy8OkfpOe/CWLIYB2ogy4PwWvA2BjeFTGSzgP+/Nd3T/d1EkRcf1i3BSCFNKJSizbs
 Jy0E+PiH/YOzG4jKx6HScX34QIMWNYQ14nU0I5zQs4DDPZBVhJTjbRCeMORrHafCVbqpAVm3nWY
 +Qb/FzDPVlszYDtPkeZVTW3FSye6k0N3r4pmAh/vUXsy6gHuo+kU
X-Google-Smtp-Source: AGHT+IGE924reZcxY0Ez2Atcu11l73XSScKVNDOMxVaMsTAOoRnuOegbsy1LsDSICIlpXKo/zkncbQ==
X-Received: by 2002:a05:6000:1a85:b0:39c:1f04:d151 with SMTP id
 ffacd0b85a97d-39c1f04d17emr1476163f8f.26.1743424309694; 
 Mon, 31 Mar 2025 05:31:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v5 12/16] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Mon, 31 Mar 2025 14:31:06 +0200
Message-ID: <20250331123120.2025062-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

To prepare for the introduction of threads in the USB initialization
sequence, move code out of usb_init() into a new helper function:
usb_init_bus() and count the number of USB controllers initialized
successfully by using the DM device_active() function.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/usb/host/usb-uclass.c | 83 +++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index bfec303e7af..fa1af8f555a 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -287,6 +287,45 @@ static int usb_probe_companion(struct udevice *bus)
 	return 0;
 }
 
+static void usb_init_bus(struct udevice *bus)
+{
+	int ret;
+
+	/* init low_level USB */
+	printf("Bus %s: ", bus->name);
+
+	/*
+	 * For Sandbox, we need scan the device tree each time when we
+	 * start the USB stack, in order to re-create the emulated USB
+	 * devices and bind drivers for them before we actually do the
+	 * driver probe.
+	 *
+	 * For USB onboard HUB, we need to do some non-trivial init
+	 * like enabling a power regulator, before enumeration.
+	 */
+	if (IS_ENABLED(CONFIG_SANDBOX) ||
+	    IS_ENABLED(CONFIG_USB_ONBOARD_HUB)) {
+		ret = dm_scan_fdt_dev(bus);
+		if (ret) {
+			printf("USB device scan from fdt failed (%d)", ret);
+			return;
+		}
+	}
+
+	ret = device_probe(bus);
+	if (ret == -ENODEV) {	/* No such device. */
+		puts("Port not available.\n");
+		return;
+	}
+
+	if (ret) {		/* Other error. */
+		printf("probe failed, error %d\n", ret);
+		return;
+	}
+
+	usb_probe_companion(bus);
+}
+
 int usb_init(void)
 {
 	int controllers_initialized = 0;
@@ -305,47 +344,11 @@ int usb_init(void)
 	uc_priv = uclass_get_priv(uc);
 
 	uclass_foreach_dev(bus, uc) {
-		/* init low_level USB */
-		printf("Bus %s: ", bus->name);
-
-		/*
-		 * For Sandbox, we need scan the device tree each time when we
-		 * start the USB stack, in order to re-create the emulated USB
-		 * devices and bind drivers for them before we actually do the
-		 * driver probe.
-		 *
-		 * For USB onboard HUB, we need to do some non-trivial init
-		 * like enabling a power regulator, before enumeration.
-		 */
-		if (IS_ENABLED(CONFIG_SANDBOX) ||
-		    IS_ENABLED(CONFIG_USB_ONBOARD_HUB)) {
-			ret = dm_scan_fdt_dev(bus);
-			if (ret) {
-				printf("USB device scan from fdt failed (%d)", ret);
-				continue;
-			}
-		}
-
-		ret = device_probe(bus);
-		if (ret == -ENODEV) {	/* No such device. */
-			puts("Port not available.\n");
-			controllers_initialized++;
-			continue;
-		}
-
-		if (ret) {		/* Other error. */
-			printf("probe failed, error %d\n", ret);
-			continue;
-		}
-
-		ret = usb_probe_companion(bus);
-		if (ret)
-			continue;
-
-		controllers_initialized++;
-		usb_started = true;
+		usb_init_bus(bus);
 	}
 
+	usb_started = true;
+
 	/*
 	 * lowlevel init done, now scan the bus for devices i.e. search HUBs
 	 * and configure them, first scan primary controllers.
@@ -354,6 +357,8 @@ int usb_init(void)
 		if (!device_active(bus))
 			continue;
 
+		controllers_initialized++;
+
 		priv = dev_get_uclass_priv(bus);
 		if (!priv->companion)
 			usb_scan_bus(bus, true);
-- 
2.43.0

