Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDFCC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1837819AA;
	Tue, 18 Mar 2025 11:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vFN+EihI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198D281D1F; Tue, 18 Mar 2025 11:47:35 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7321E8122F
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso21748355e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294852; x=1742899652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOwEPxvaoWHr66xPkiSDm/VL7CWIUInUohTOmW+osfU=;
 b=vFN+EihIE1hjAryWK8QhNaBsUwX8vRj1nx568xOYLGRa7h+s3twDimyzMlAoLAmJQr
 QIa5GguBlN1P8i/sE0i4kUhD0/qHf2hcN2e7Z7wkcGBO0WLPYerJRk4cz1KD322S+WTA
 rbqdj3igsyyUZWGe9JakDHV6gp+3YyzOzPFTGRBghGCKbEIWJjWNjPLQH3EWmKxPpPPJ
 mSk9ruHlyb8uvl29TIyYsKFCTtE60uDId/N3AeXDcN/KND4ShpANvU3EV45RGouZQrNe
 UHhFYXVcgx+sbqSuVKUQQPk2lWj4aSP5AXabKaHxHvVN0K00bz3QTHWYFeI4bseGtWD0
 4AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294852; x=1742899652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOwEPxvaoWHr66xPkiSDm/VL7CWIUInUohTOmW+osfU=;
 b=jb39+cJfPehwfw2eQfTjTKGfTR+DPUlj+9ZTMHWFGTWO82Bl2ojJxEipi8Ujhhzlm9
 fmSHSqgKEom+mzur0bhrKd5zobaA065MidMLfLeP3zD939xdr6B6WPH0MwQy3iPA6fng
 KR2FweBpiOPHImQ8p6omUbUZYE+HXBwPLHl7zWVaT10ALhoJvID3HwI3sm+/ansts9ap
 KESwJxms1XKDsM7SMxm+1DMwiraRf4PmzD1Oz6BO4cS9/LF7xTIHbO8fnYyZ4Z0j9MGN
 UFDz4tufV1jOGwz8MzGdo0Hy3wYPiRNFzBbEzwfX0fSOuvABhRtWdoRLnTGHg69ggUvU
 j/ng==
X-Gm-Message-State: AOJu0YyJQkZBrIhmzdMrwwhAShkWCjqNu706VCBdDysTq0m8++oCOyXb
 20NFJnQJwaSx7e0tmBVAl8ygCN/KwxoU+QjzjJBvFsBnS4/6tjUc5tPNjTmnzJxWFft2uhoe4Rd
 UdBs=
X-Gm-Gg: ASbGncsR5hKjrXVnQq++/6Jk4VPdjLg1fRFUz9VJQDNhWV+D1Aoj6BmwwlKHmixxApf
 l7vom2IernKLjkg9Bw+GffKmosraXkk4sW+8z30+Ta/lb9g/pNGfORqhHkKuLC2VqUMgqUt9gns
 iLrXK/rjP9dZRPD21v7UAw8zfHrj2IiZg2C8t9El2rPBi7wceccrNgqJ1eQ8VLRrZNVCWPWmw9E
 kMyLIq6JDKD84yqp1/GV6cj4mm58f5jI053oDLKsPjEzogHmcVW0Gtg/Cs1ESqEJC93jebhMkOQ
 6fVxbucxh7dUBKg+Uo/j/YUdpts55h6kNIvCECEqp99vJ/iJElbIxw==
X-Google-Smtp-Source: AGHT+IHL2joVbhneR8J/LRwPVAYuWiqt2LQaF2DyBnkboN7NcK5alH11iJqzOCX80w6Ttk2LpzbDQQ==
X-Received: by 2002:a05:600c:4295:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43d3e14fa65mr8428375e9.13.1742294851611; 
 Tue, 18 Mar 2025 03:47:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 10/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Tue, 18 Mar 2025 11:46:46 +0100
Message-ID: <20250318104659.1114340-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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
usb_init_bus(). No functional change.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

