Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C6ECA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 09:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50508889DA;
	Wed,  4 Sep 2024 11:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPsD2xgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F2F889DA; Wed,  4 Sep 2024 11:38:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A568876E
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 11:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bb6d3e260so53114005e9.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725442708; x=1726047508;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EJg2fvYfGnL473+ickHBnA7Jj7mqlC0QVh7VngZSn9Y=;
 b=PPsD2xgN8fYxUiqLLmKGU0CpGtJZeKmgWrBDEsDuiR/RJOIKlmsmzzPTOegFbtadrz
 QkG90ew5duz7G7wVczhgkilt4S0AHjeA1a/yEtIq9egC/FYI5G7k6SiNf/MhvJOoaASh
 +3y18bhSCnQtYY8vrmT+KY2Sku7LfIenXZlXsW7ZOVAI9/LrqpcVU98EA87/TzSxwWMk
 slWBczDsbS+H9QEFbU1+eKli6Jrn6Puq3X9YMzfZ/dMaCEWwhiZ2i6i0L3oOLflDVZzW
 iSvcMhDAxVNi+QmGE0evHlhjrczn7I3FDQJ8fuKMqEy0q2eOnbeg7jzdct/JBwJBQrw7
 jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725442708; x=1726047508;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJg2fvYfGnL473+ickHBnA7Jj7mqlC0QVh7VngZSn9Y=;
 b=Yj4FYlsV2AehVnKBA34JEVC6V7H4FGCQWZv3/yer9GD5jXj3NUSrs2MSbpXJl66D/X
 BDtERfW+mdzK7BGEte3IQRi7Cox78am1wefpyAJIxS6gmzne+fxTtUx1d3hibFuh39oJ
 6QlVfICtOYJhDaKwp3u9Z7gBUPYxCJz8Pd09/vRhtViO+TZj9Hvta0dB2PZ6hrv3BKc2
 L1EQwy6imgBbZ28z6hd6s6DNDflsK+dHWMJE844ZUCHeJlfBposisYqSUyuJvaMDC7H8
 +ncmkJyhBLEYaoc9eJyPb3vqW5QMoHzoCkLhpumlvI7Q+0aeR+q7lawPnJaVeY+gmb9L
 1zuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK/tevHMzR3kxvKlmTFV2t5t4O7pra2GM+B0188agqqS/+9n4nLzG9MkjfqctpXT+x+PhXjG4=@lists.denx.de
X-Gm-Message-State: AOJu0YwsuqVc2vx5fPXli7xxPsi94dAIJCHlkJfUR10drBbllPYp1ybo
 OC12lyiYdea45WhE9+m1frF+IWejNLzJeANgdGxvPs89d/XKuCy69Ec5pyr1O4M=
X-Google-Smtp-Source: AGHT+IHre0PEVfDyMg9q3X+laVyy61qruYhIIljb3M79sS7pAOx/YadKxOQMxYhwwyos5sX1n/jwAw==
X-Received: by 2002:a05:600c:3b1b:b0:42a:a6d2:328b with SMTP id
 5b1f17b1804b1-42bdc64e691mr89606435e9.30.1725442706998; 
 Wed, 04 Sep 2024 02:38:26 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb01d300csm210261055e9.15.2024.09.04.02.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 02:38:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 04 Sep 2024 11:38:16 +0200
Subject: [PATCH] bootstd: android: Add U-Boot version to cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIcq2GYC/x2MMQqEMBQFryK/NhBjtlivIhYxvqwf1MiPiBC8u
 1m7mWImU4IwEnVVJsHJieNWpKkr8rPbflA8FSejjdVfbdUY47HimF9Yopsg6oT8O2WcGdtP8LA
 +UDnsgsDXe++H+34AZr+yRm0AAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.2-dev-b7dec
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

When booting into Android fastbootd (a subset of recovery), the default
UI shows the bootloader version in the screen [1].
This is done via the ro.bootloader property which should come from the
bootloader.

Provide the U-Boot version via a kernel commandline argument so that
fastbootd can show it properly on the screen.

[1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/bootmeth_android.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 6e8d3e615db0..2fb82a5073de 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <part.h>
+#include <version.h>
 #include "bootmeth_android.h"
 
 #define BCB_FIELD_COMMAND_SZ 32
@@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
 	return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
 }
 
+static int configure_bootloader_version(struct bootflow *bflow)
+{
+	return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
+					PLAIN_VERSION, false);
+}
+
 static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
@@ -267,6 +274,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	/* Ignoring return code: setting serial number is not mandatory for booting */
 	configure_serialno(bflow);
 
+	configure_bootloader_version(bflow);
+
 	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
 		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
 					       "1", false);

---
base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

