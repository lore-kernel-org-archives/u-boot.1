Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F1DC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E35280BAA;
	Tue,  4 Mar 2025 16:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kUGBlFOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377A88141A; Tue,  4 Mar 2025 16:32:11 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA58581273
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso14456755e9.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102299; x=1741707099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ce5dvI/5nuqLZMR/lkwnf7B1aBvTQhktpRS0pk/2NjQ=;
 b=kUGBlFOf8w6GCGVWixFZRq65AETKlQdmmoXsl4jFNq8TeFL8ToWBLhkM014ke2Mr6C
 bpcGIyzcIswn0A3KC1+pL3aRVUHq6ySNKv17eXxIJF3IQVT82KyR3kqlZUAA2FKf+S+A
 FjCQWi2vLI2LRL5lTG8pOVPeYmLcfjRj2fcOuQGQ/hr7KEfmUZ7MvKwdU+qlqXIBczF3
 SkyOxpC2YiOvnNYihBZdxBJJtO0HxfpcUINRjBWPzxSCRdHNsIepZG6udk7FrMQoKo1j
 wGSxepj/R13pP6iYHkZGsgwhd+L8oAFLf7R0SRub+UoooOL/QcIKhbk9D3cqLThtCt5F
 KbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102299; x=1741707099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ce5dvI/5nuqLZMR/lkwnf7B1aBvTQhktpRS0pk/2NjQ=;
 b=H6PKYTKj588LgtBnYWBKBb6hH8Qo7LgTQrSK9Q+cTKe/vvuPZuiNhXHqAX3WGuEORd
 0cy6M71kohc05QEPtD1+ZZk8vNbE9m6OjBJ5rTaJ8I7zxorCl0Ofs26nQ7E+lVKsj5kF
 pYBna9XSu4sBSIQBJWAGCwoxbceMHEhWl/efjR4mfBnxuyyyLriMfPj0/CxiwBbdW/HC
 WcoEQiaFg+qSCxEeiG+mZeRU8CbQMSBfLKBukZoGb5N+9c5RtaTJXOraYtHgdYPS28ld
 2QTF1wu9zApZ0n4LY36lCFfev6kzezoiyP+q6sqkjYyJrbTQ0aGwouhJhUwBKMj+IcW8
 3tfA==
X-Gm-Message-State: AOJu0YxIorEbovM3Gggr1JHILPr+wwBOoxslceIUCSqXeOR5YnoK2p6o
 UW5EIr2EuuzYUn/D4K6hf8VkNnPD8wlhayjxg7znBzuqq0mKm3rea54BDKtiE/g8ojhTchtLjko
 i
X-Gm-Gg: ASbGnctmaEg9DdN+SSujIS+dE5rqK9/k2reH6KM+UZaBvk8UD2zUKQxoMDn+7kZXdb5
 THP7+r27mtU3RwPdHve+8yiz8nbsggvgIk+NABAXIBBLQrJbq0XwGow131Cry7ycel3fEJIPcpX
 edKX4d9QdNUzAn2XaH2gCZGJqGwb3kBLMCqiNeFdqhkknToJhrDAJ8B1RbQ6DzGdBE+sPueB6fy
 icOSBNJqy8W4g3Iu9R/nL0XhqnX1Dadn/5qEtQYGeB5vBUhMRavOhuxkjV888KkY4O8cV8CDWiM
 hCyzoXMgyrpEHqFJ0VVMX7uaqe+ZDTiuz5FVx20iRevsKN+GWDyVmg==
X-Google-Smtp-Source: AGHT+IGbNTXJifmB1TJWIkeTcQTHt4+ByD8ZMt9Aw2v/3BdLNok75bIFW6uzDkH/TeiB4uXOzJzDtQ==
X-Received: by 2002:a5d:59a3:0:b0:391:cd7:82f9 with SMTP id
 ffacd0b85a97d-3910cd7835cmr6134495f8f.27.1741102298755; 
 Tue, 04 Mar 2025 07:31:38 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:38 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 10/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Tue,  4 Mar 2025 16:24:58 +0100
Message-ID: <20250304152510.2832340-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

