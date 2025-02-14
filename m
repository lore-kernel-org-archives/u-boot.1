Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CC8C021A4
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C13180F42;
	Fri, 14 Feb 2025 15:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fRgT0aK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7FF80F56; Fri, 14 Feb 2025 15:01:10 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979DA80C83
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso20028945e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541668; x=1740146468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Utnn1RiTgA8y5KAA6XU2ZUyWE7GhPINWCZVBuQFSuLE=;
 b=fRgT0aK3kP4sXPAFXHTRTSiwzBB9ACpd5Seh/n75f06PWC55FcRjdpw/3FsYsD6lqG
 oEg/b3Vh96y20siOHMZulBh0opX5MPHVuHgkuA8Eu1S6gzk5x+muwV1nRWMKS3+rirdw
 5LgocY0jg1yC8mGnziktDwb5xOytzz5dt4jO5WbSF7Im2LGNBEHnmyQatuT2XS2RpjB/
 QVmSctifaLC/jQ2OQX3wg4Rmc7UsrmFrJMr8dpnF7/ExY+PCJIhpVrlnFGGmDaqPnYC/
 /mdw2ZLzf67MsvsCfWzURNU4bDRR3pXB3/K7Hcu3ZkGLcMHCt/UTS//YFvnsTu1FxT3y
 7RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541668; x=1740146468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Utnn1RiTgA8y5KAA6XU2ZUyWE7GhPINWCZVBuQFSuLE=;
 b=w7ilrN6PJe5DEVUez6UnBgt0NeK67csZy/4aBdVcQX4A2TWNaTlJoMptt8w4M4bXMt
 q6SCekxZ2EuK0DEZ9cgWZ2nCWPbhiQOcYv4hzKQrv+PjCMlDCtgqak6pSADZothzau+9
 bVWZ9AKf5CBI27pfO8G8fvexTYY46DEfmwV7sKffdO9C8o0r0rD2H3eF7q9yLM333BsT
 ekdoTdrJO1abfyklB0xjldrdiwXAaHZCXJ/ZVdRwMJCSG0AR8kgOWKCnPD6G9OipLBFL
 STRj0XQTgKyW92SfEJty9kDwfhOxRWRpx1cUneAO4QOCuLd8/kRHQnc0IW6VDfp/tVXv
 +2wA==
X-Gm-Message-State: AOJu0Yzaz4qiFjWBcaW218220FWC9AnbMptbYHs27geZ4Nz9JBVNqvrY
 SeykQOlw4d/k2LQKprMGxkAWH6lP4hTBRuUPC0cEZTKObvD539kvu4D9RLojXIXPc+K3VDzmUL+
 dmDCCSw==
X-Gm-Gg: ASbGncs9UCoWCUzI/q2dc5ydMqdVO3OlcNeld+4m8RiaZz53wRHf/WRtBQZr0zPH+XL
 xvg9EoGcDEjsr5rwPBjMRubJK8T/9RBe4ivi5HAeht/KNU7s2HeUgeHPOfkN8Vr8pGxKiO0V2bM
 ezYQ7uciQwDA/DyIXA/sa0HJy7brO8+G+a9qcNQPU1TLuHRp1mq5ZLnzbdeNTj4AJHaGn8m3Mf1
 8wVDoLaSJz8sDnbJDr1xZZki1P6yMPA8mapFJ9OU5nCB4Y7NMTHeIVNXvFy8o2OUo+dKatp0i/1
 Op5lKQJXaUK85rL/2H6Oxbz+
X-Google-Smtp-Source: AGHT+IGw1MgOcaCxdSIcLIi9VGo5qF84LxoVkFCipeH9u7XHthKQ5n4ZptN49ZbzhtaY8ve+l7u9sg==
X-Received: by 2002:a5d:6f19:0:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38f24d10851mr8582269f8f.15.1739541666046; 
 Fri, 14 Feb 2025 06:01:06 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:01:05 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 08/10] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Fri, 14 Feb 2025 15:00:23 +0100
Message-ID: <20250214140031.484344-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

To prepare for the introduction of coroutines in the USB initialization
sequence, move code out of usb_init() into a new helper function:
usb_init_bus(). No functional change.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/usb/host/usb-uclass.c | 88 +++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index bfec303e7af..cc803241461 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -287,9 +287,55 @@ static int usb_probe_companion(struct udevice *bus)
 	return 0;
 }
 
+static int controllers_initialized;
+
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
+		controllers_initialized++;
+		return;
+	}
+
+	if (ret) {		/* Other error. */
+		printf("probe failed, error %d\n", ret);
+		return;
+	}
+
+	ret = usb_probe_companion(bus);
+	if (ret)
+		return;
+
+	controllers_initialized++;
+	usb_started = true;
+}
+
 int usb_init(void)
 {
-	int controllers_initialized = 0;
 	struct usb_uclass_priv *uc_priv;
 	struct usb_bus_priv *priv;
 	struct udevice *bus;
@@ -305,45 +351,7 @@ int usb_init(void)
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
 
 	/*
-- 
2.43.0

