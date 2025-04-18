Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6CAC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964A68333D;
	Fri, 18 Apr 2025 16:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aXc9psZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E0883208; Fri, 18 Apr 2025 16:11:46 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD5783253
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso15489775e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985502; x=1745590302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=On1IMPWoplq7DV/CKkFuhHU7kI0Fa68u+tVWTz1RtrI=;
 b=aXc9psZwWPzGcl/ykxIckXL1ntKWMFcy5HW/XeTg0iiM2055d2S5f81Uv5EMs+IX9g
 EPRzcpseXHVXiS9ZVzsXpDvnBH+vH8wPSGmTKI7eDwP/gJ5DhmcNtxVsWXI7+lAlIFp9
 qfxuvR7+xJSUsz95L/lJ98rHF9if7WTTXlfCOHW4SvbDNPdo4xWN44kV9MknG6H6kRLx
 16S7ApsH1a69B7xQ3+NMgrfD+y3mUyFmKcdBL01p6+HLkPJL0in28WrXrpppwEmLkDgA
 vHHkKKpQWcX68euiO7UtqUe7sNkskXj2UUwxCW4uPbtS0uxKzjxbhPFDgZBBIlNWFpjM
 KonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985502; x=1745590302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=On1IMPWoplq7DV/CKkFuhHU7kI0Fa68u+tVWTz1RtrI=;
 b=eZm8MJAb6nUQGPj0WUT+6D26coqe9ogwnQQyStAWeRRaOLmQu9oZ/oZFWC5hEpu8Ww
 E7jOjZyB0NZopLjIEEulYCUCtI9kHLINKMZ8jo01Cn86UUjr3XvPIVVmBuhhCOyxTcoM
 JREcM5V+aSnydZT12Kc7F1U+TfUrNV5TE//OAAB/z4V5/HFIZBd76Cw92Fk0B7rclpYB
 4udPKha8juZu1XJDp7s+0M10eTe/AUyL+uTCXKwVUIdjHtLCx9x0N0wa34AQFzw6w0Qh
 8Wk4Vfrtz084wjP5o1qToxX0a2TAvxxETbmhHJdU1W0F11dtaJ3sc1FBgdQIchKgNjYC
 ludQ==
X-Gm-Message-State: AOJu0YzxKs3+sI16vkL3QVuSg8idlDfLaUefmGYWQRCR0pA8vyUBy1JO
 czOPuFZ0EppY0aydSPvw5hh1635IjYNklZwr217LotRmQZ/aszki3p8i/2IVk1/Eeait/Tfenv+
 fvIh9Jg==
X-Gm-Gg: ASbGncsEKFpjtr2/HVjNcPu8tYaki76O17rk5IAC6ics9yb8TqJG41RJB5TVQAFuIO6
 la0KjXOfBV0Y4tWQcMxtMB+GVRJ0uEOw5pPzYEbWSC6huXRZoggC55dIw8Dwf/fICdtMASKqLJh
 h9xqNEf2No1nm5Qy1Ob1/GDFw6EEu9B1HevtNZD14fj3aFoGuHzWwy0a9yqzn8AioON3IkY1n7D
 4yHOeJOVdjYq1yP/0wffN307zyhRhNA6bQ95OVIQdSK5Z2b62QVOXTdVhoayQvhKH18x0yd6HGM
 qnlUgxM5AUlmHR7pNt2H+GSC4A5dHZ+w3KV71J1SWyz1BHG+3g==
X-Google-Smtp-Source: AGHT+IHg5G6Q7FVWVN/REZjfRZ8dPb+rnh6hqNtyEMD9qRZhMxSWryqrBmLoFZN4sWROboLTFHa3Zg==
X-Received: by 2002:a05:600c:34c1:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-4406ac227fbmr21989565e9.32.1744985502215; 
 Fri, 18 Apr 2025 07:11:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 12/17] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Fri, 18 Apr 2025 16:09:40 +0200
Message-ID: <20250418141114.2056981-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

(no changes since v1)

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

