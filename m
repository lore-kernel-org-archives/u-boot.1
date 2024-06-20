Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA965C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D05887873;
	Thu, 20 Jun 2024 09:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L7PLzVRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C4387F3F; Thu, 20 Jun 2024 09:43:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52595809A8
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42108856c33so10329285e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869391; x=1719474191; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
 b=L7PLzVRcB7DMKpQpTZu38+28d/bstcqZ8CfuxaEYGXRe98s8hP53bmMJletO5Z6sxL
 KVGUH11E4b10zleQAISlhxWswp2QrDVCZ1Qn6Fl94MC3V4UAxq3e3IX6QoRGCCP+J5m7
 N5ebAt9QB7yMgFijecBYLEGHDj4popqAXg8iu75fNf4Ha8NikLUo6K1YSc+/DQ84wBV3
 3UUSQGXIL8Cm8ZryLK7DNc8jO+7dQTKzuB5B6NEQTYzIp7qJZeqJn5P089z5z48uYQm0
 AywYrRtWvl2oJptubQR+nLqjLaJ+G1JxAr1/DxZluc6T6MQ6l4hOFCxVIEomTH0lVgmg
 zg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869391; x=1719474191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
 b=GIaIWEJGU5Ato+FyaFy/xierRcxyuZF1rkwbMcu8wePLLREwZ3zCF7r+Vz9ItwZT9G
 y+Cflj7//btOjvOa9n3bYP8/MPDPKm3IDBPULMdUq+VbKxbc8kucv4nHCrT2VBy8JpFC
 NsHXOq/JFyO9qsf9PoHMIt+TL1ABTrTROTH4eKvjV9TECHTIhw+/nGxS5T+cnD5b1NMp
 YGJ+3lkiL9q9E6ahtepbMc3XTnKJnXWGanR1ryqjs8hsDwo227Ljqyqtd54jjYRGoB56
 mGorZ10n2zop4ZH+Y+TFxRItalnOwyKDRwkGK+rG1zy4gMnNivBhhSHRi2T9vewwt1Mh
 HQ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgXkP1oDk+86ufDVYfCSvOmOs7p9Yyes2Hnz0qjoonMT4Ks7QWgZn4KjfClqKb2IJfyMSBSHpBlJFs6k5EdNENXwfyVg==
X-Gm-Message-State: AOJu0YxqxG8Lcfk4DzFwhyMyzXmEvFWoGtOZuVMyB+XNkW2r5zUoYAtd
 H7pY28DmwUeFnQ7R5ljopQ4DdTHtafQGpwI3/TtlScphBNoFu58KIzjvhMf7zT0=
X-Google-Smtp-Source: AGHT+IEGmXXCLRE0wIeqVva/PbicdFdi0ND5xfg35chbg/wgKI7N8ynPFgYgL7TPSbKqEyzWkiIOtw==
X-Received: by 2002:a05:600c:3b28:b0:424:74e1:bc8a with SMTP id
 5b1f17b1804b1-42474e1bd31mr44712415e9.4.1718869390492; 
 Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:54 +0200
Subject: [PATCH v2 5/5] usb: dwc3: meson-g12a: drop usb.h and make
 dwc3_meson_g12a_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PPsS7D8TEBBrAwE0wIAH2nzaqsk2E8ByOhmeHE8CZe0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92HfNlRi7QBrHfVN9m40l8RHlSxj7RxPLBLHp+k
 nYMdQTOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhwAKCRB33NvayMhJ0dmXD/
 0VL4Y54gWzklgeBI4nP32u4eiXofOvQbtxpwI0eo0xQyh4bP4kr5wQi1hACNqGGyz/pwHAXEs50xoy
 kt62JnEQP9taPwJq5VIxsUqc+wMspggjlUNcIpFayuPXxOn2vrxCVtq/+rj4Xng3tN28B+siOxHUmE
 82vf3+9CPXmIWMURcyCa0uwsYmPAcPAMr15y248FF0aFmE9b5bYNVmyT8ufMAEFh9l0mINN4p7Sdot
 XE+uZVjNWcKd3D7DPABAq2v2WQ78AlGq+1/qFzG0Mo8Zvfe1MnImQHvHbQ/OYBQpATRggcVktjbZZT
 dB+qeXq/mJuymPXYk+lCa5R6yBC598I17JfUNbgla1ngvN3XqHs7gzIVnAtC+a1iZAo59psHOApenb
 zWbKOOMkoLLTfrh8sbOP0vfcjnEsoKAJQAZV0jjV3MTkXJg8IAio571Pi5q8EljfpYaaHBwT6riZXW
 A646hu2KTGltgwDDbKWw4i/5htS03/CjhZJ99mzRWu6MRj00nhW3AfK1p+pYn/Ly+8ZOzOD2TKjEHb
 eIrMbGZKsV0gmeRDj6IWf+r0V5C1v/Z5b4Df+4bnaxh61X5tT6H3fqSOkgJrIFbIyxKyOWYhFdq2OB
 yEONSFEmGSUqgsU48bCiJrqNwUQQSAto8Rm4o6fpcCWY765TrJ+CPhNnZQbw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Drop this useless usb.h and now make dwc3_meson_g12a_force_mode
static since only used in the dwc3-meson-g12a.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb.h | 12 ------------
 drivers/usb/dwc3/dwc3-meson-g12a.c    |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb.h b/arch/arm/include/asm/arch-meson/usb.h
deleted file mode 100644
index b794b5ce77..0000000000
--- a/arch/arm/include/asm/arch-meson/usb.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2019 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef __MESON_USB_H__
-#define __MESON_USB_H__
-
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif /* __MESON_USB_H__ */
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 21e4f637bb..41d15996e5 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -270,7 +270,7 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
 	return 0;
 }
 
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
 

-- 
2.34.1

