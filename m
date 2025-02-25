Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3097C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F77810E6;
	Tue, 25 Feb 2025 17:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PFuV/IRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAC7810E6; Tue, 25 Feb 2025 17:35:28 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA40810F1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43996e95114so38765405e9.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501323; x=1741106123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Utnn1RiTgA8y5KAA6XU2ZUyWE7GhPINWCZVBuQFSuLE=;
 b=PFuV/IRLkPmJFjMsiRwGj2Wy13Imtxgn7p5bFel0H56TSUF+CUPzPIUq1mtVTQ69Rq
 LERyLT9zIPh/ektjAXPmGiOUURt6oA9NogvziweE8CkiR2U4jluU2q4+1cUIAbPOiyrG
 4hix4ra1UE6xUQYsqiLM5BlzRvDi0URmLzxyKwDBuS01NtZSEvu6jxsOnUyXwnS5SnrW
 IYXGM0iIXVdMAQq2SUfq9e7dMBFsNhEhzKuAOfgY/Ymis43WrioQu72mxrvLAVkScf2s
 ht+1NyR4qs3QQzHRyAp5yR87OXQr2oIkCmw/N2pfEAr98uZZzIbIjNBr3zC4Xo5xv4hj
 LpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501323; x=1741106123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Utnn1RiTgA8y5KAA6XU2ZUyWE7GhPINWCZVBuQFSuLE=;
 b=RW1Fz5NhHig2tHv00BeiHTCtvPOkNLY9eeEg4FaiPdDGk+0TtJFMyqTNuDwAOuIhLG
 Alv48e5STX0babt0gpSx1ZNZ403uZqtUXvs4ztIFPLvMrg3aKz+ArR1gbDJKWGzPbFHv
 9LvzkDOlDzxkLLhfT0dw/hBbxNWBt3Q/Qn1f9cG3ZL80pLVDPNtpldZhIJEKxr+am+YN
 YenM6RF0+n/dgptZc4HXuBqpsleKl4IBe/XP8mykQoJDruUT2uK6m1s0oydCne63xFJJ
 DJ4VBHe0f7ZvHhNd69p+YmRV0s5ivC7KsoYJ0Suk1qhJXhGGXAZ6rgYxGF6xRnKdRg6/
 mGNA==
X-Gm-Message-State: AOJu0Yyq1IBU9lGj8BIaHg4/CP+PgyLQKuGag49h9j/iuGZ/ksB+19Zr
 zEgjB3/goSeTMNHMa+H0pHKpUWSO9Qhe7uE5Gvg4kFDnN4EkOkgCJT0Fmglpq3XvTqNtxeg84Jg
 TLD3b2w==
X-Gm-Gg: ASbGnctABmyknsX2G7h3lGDnutv9lHwo2V0ttPA7GzbuK6ysgDkCHAW+h7OKQoabRNA
 OD9XDnBO04OsA7lD4tu6lGTOT5HtAohWkmSemu313eqfwPxv+cz5cjPWF761e6wcvuvIINmMaMq
 Q99RAwYGR62+wAEFjWKsJ62aVu+OGVOd7N4x8YEcRfCK2DiTcUAf8L0O+2X+MPBOpUO/ZEsiSt4
 Ib8RpBtwjT+k6FWvQNWYFHafArUncykzgdueeiu+b9xFnTfJ3hQfA8mxVM44Abt+NthB+2vqVEN
 ka7KrvzrPvj7cgpWRsvtMqDWKZgLCH2o4D8=
X-Google-Smtp-Source: AGHT+IEb4TkNUG3xssDtRLWoohTYh/iqddKCKxMLicFpfN30FnJ+/mMaA69A/bvDMrGbNEK3pwo7wg==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id
 5b1f17b1804b1-439aebf3613mr182200815e9.30.1740501323014; 
 Tue, 25 Feb 2025 08:35:23 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:22 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2 11/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
Date: Tue, 25 Feb 2025 17:34:37 +0100
Message-ID: <251fb41d13189f475f606a6fdffc764997ee8d61.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

