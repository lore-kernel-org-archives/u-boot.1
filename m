Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54A4C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 19:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B3088168;
	Sun, 14 Jul 2024 21:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e9JSmO8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A30883AC; Sun, 14 Jul 2024 21:50:16 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2218780A
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 21:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso438243666b.2
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720986614; x=1721591414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rvSHxBLY3I0soeeO+CMW9EjW4B8Tehw4jM+stn+a8wg=;
 b=e9JSmO8QRlCzStbAa5RMkvhqB9zqB6lc41AshK7xXaV4iONqMSVUxx/Lg2Pj+tW1vm
 O0ha5NQu27veJpryzYSBtx5tmZrCK/wCd5FjBhbIQmmihk0yWlh3Zd4iSQen3Wq3bCRu
 OB2+XJ2V1KhDlkxnwcaVIcB4cxa1OwyBfs0u3y6OT+zr5isAvi88HMkvQeXDig85uiRG
 IZ65w7M25rjoZhfrHtqpwKfark3LtwTxMuo+S6l8o+haRzbn8mBFMGznDtQmTywraPMY
 D+VW/ii1YNYpFQaeeuEhVv4SxrkFiYXfd7nU5hShor3OmKpDBOOWSiTTkot/jMT2gHfz
 EMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720986614; x=1721591414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvSHxBLY3I0soeeO+CMW9EjW4B8Tehw4jM+stn+a8wg=;
 b=WvahMMmZNC4KGS58jtMAbe2kr7hgOqIU1oViGiE032cfE42vMcjueCEIDs/o5ZAAjS
 ul39jP3ZxQepqrIG9tyjY6NorNe1AECQLeIQyDcDApjrfMECmPKiSEc/KRQmDWkOoEgv
 xjDNpi32aLk3qgZr0v5e1kzqIJftj6lGogjEzWqvPzPOaxvrICpMQMYaNVvUIFMsbGHi
 EwYtugw9hTC0nUXdvv3LUeZ6tTLEwS4aXaGYMJgpJZoAz1B2q+a3BgfMqIwS3T2Ez63G
 ooWINAevTnYOBQA7Y3i5/N3OVxqtsCxvQpcGpGmblHw5eSs05hmCTnLISaLkjL5iDQmz
 1/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Z2oirYeI7EBNgE7cGCLo+IYzjh9EWrSlZPGGE7KItoqEGaFVlUUQsY5pMwbVO35rszjiDLqFF491tzKaJz25lXE9zg==
X-Gm-Message-State: AOJu0Yyu89OEbEAbxm913HAou/bA/qkKmoZDiL2GmSgd5eFhWp6oJeYi
 B39zo+LwcM8JhXjdaP5X+ObF3OOx1MHeeFoRKdI8vNtD/eE5xUv8pqjx/1sW9sk=
X-Google-Smtp-Source: AGHT+IFVZ/uIvZTIZkhri7u3ZIJ+XPaEDls0PzljZzBCtzBnFG9ehe+fiT47/q70gdVBu6VK8VItrw==
X-Received: by 2002:a17:906:27d6:b0:a72:74d5:8a9a with SMTP id
 a640c23a62f3a-a780b89cc52mr1185358666b.65.1720986614420; 
 Sun, 14 Jul 2024 12:50:14 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc820e92sm152948566b.205.2024.07.14.12.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 12:50:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] dm: button: support remapping phone keys
Date: Sun, 14 Jul 2024 21:49:19 +0200
Message-ID: <20240714194948.1271135-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We don't have audio support in U-Boot, but we do have boot menus. Add an
option to re-map the volume and power buttons to up/down/enter so that
in situations where these are the only available buttons (such as on
mobile phones) it's still possible to navigate menus built in U-Boot or
an external EFI app like GRUB or systemd-boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: u-boot-qcom@groups.io
---
 drivers/button/Kconfig         | 11 +++++++++++
 drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 3918b05ae03e..6cae16fcc8bf 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -8,8 +8,19 @@ config BUTTON
 	  U-Boot provides a uclass API to implement this feature. Button drivers
 	  can provide access to board-specific buttons. Use of the device tree
 	  for configuration is encouraged.
 
+config BUTTON_REMAP_PHONE_KEYS
+	bool "Remap phone keys for navigation"
+	depends on BUTTON
+	help
+	  Enable remapping of phone keys to navigation keys. This is useful for
+	  devices with phone keys that are not used in U-Boot. The phone keys
+	  are remapped to the following navigation keys:
+	  - Volume up: Up
+	  - Volume down: Down
+	  - Power: Enter
+
 config BUTTON_ADC
 	bool "Button adc"
 	depends on BUTTON
 	depends on ADC
diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
index cda243389df3..729983d58701 100644
--- a/drivers/button/button-uclass.c
+++ b/drivers/button/button-uclass.c
@@ -9,8 +9,9 @@
 
 #include <button.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 int button_get_by_label(const char *label, struct udevice **devp)
 {
 	struct udevice *dev;
@@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct udevice *dev)
 
 	return ops->get_state(dev);
 }
 
+static int button_remap_phone_keys(int code)
+{
+	switch (code) {
+	case KEY_VOLUMEUP:
+		return KEY_UP;
+	case KEY_VOLUMEDOWN:
+		return KEY_DOWN;
+	case KEY_POWER:
+		return KEY_ENTER;
+	default:
+		return code;
+	}
+}
+
 int button_get_code(struct udevice *dev)
 {
 	struct button_ops *ops = button_get_ops(dev);
+	int code;
 
 	if (!ops->get_code)
 		return -ENOSYS;
 
-	return ops->get_code(dev);
+	code = ops->get_code(dev);
+	if (CONFIG_IS_ENABLED(BUTTON_REMAP_PHONE_KEYS))
+		return button_remap_phone_keys(code);
+	else
+		return code;
 }
 
 UCLASS_DRIVER(button) = {
 	.id		= UCLASS_BUTTON,
-- 
2.45.2

