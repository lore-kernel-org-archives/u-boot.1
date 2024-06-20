Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC5CC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C440F88532;
	Thu, 20 Jun 2024 09:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBOC0w4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E38B88126; Thu, 20 Jun 2024 09:43:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCD9883D1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4217d451f69so5818655e9.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869390; x=1719474190; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
 b=kBOC0w4G8ep84wUDlFHdHRTPeoGpQVOjSpBNPwpVmBoDblAZHqZ6RNQCj8ADJExONy
 vubt6zkK1BJhHs952cSAdyFB2a9VdGNoEYiTWAsnD38GLhqnhPVoXkvsWP66Hpt4Qg6G
 CN16JsBtiJbOQlYOsncivR20bLQdiwGEi6iWsdxCAQLFUx6TVaRnfRDkUYbca/8UIxFg
 QVADnZxH+3ewT34Exjgt859AbDoOgxa4EcjEiwt5MDJAMR7g8C8Kh5O/TiJGGS9tHhze
 Jx6Ekua7p7sMWwaxR120cNq177a+tRCX96gnpfbhH5DZlMZ/kN4lXrIFXZ8XIJb2p0VB
 7peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869390; x=1719474190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
 b=cFP8In0SEjDYPRMVPP1WmdxsdS2lZAtmFdAQ6+74ZzUjtPL8qGsaHnBtegrGP4G5q4
 UpwJ8jCL7rfbWSAPD5TWqt+jaJY688USkwx9tvEV1JjrP8zghZAcJY+qcIZiCPVIe6o5
 ympodleo7KJPvAk4M89zptpfp0J2TTtJKL1e6j4pHMio+KxAMpmGXITFODnlj5/KnQFQ
 TyBOQZ7xHBX2flkto5Yf440a7fvFZcc/uXUFNpi8itN18mi1HSqqIBzqKKT9PPxjVUgZ
 9Umh1fIy9zinuI+PNm2qVQ1ab9N1Ua7CddLT8VbVi4hmoYJUBtu4fofx+KepLR3KXvfx
 nnAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbdXk2o3yxbhf4fIY2CaFGlRLyNmtFUr3u49+uV3S3jeZRzBJ1Z/PcswvDgMzShfx/0bTq/7sD3tG0C90Nuyil63naA==
X-Gm-Message-State: AOJu0YxMI2+vp4orhOPh+yw3LP+IL/opD5zRvvyUj7XV7YfE/13cyG7q
 u2hPDvqPZZrckM4UrA3SNmpGDqUxl0JeavQ0lU/qzMeL1auAGaG1syBFWpFD3ZQ=
X-Google-Smtp-Source: AGHT+IGzZoAqqGFJTuwd0O/AxQkB49TEPAANneHTP1/UMMepq8ogDnwIM8JHB9A9gUd59vAXzEz+rg==
X-Received: by 2002:a05:600c:3587:b0:422:6e65:a4cb with SMTP id
 5b1f17b1804b1-4247507865fmr35879575e9.3.1718869389791; 
 Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:53 +0200
Subject: [PATCH v2 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make
 dwc3_meson_gxl_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DpgZRKTgku+ys6NjVBIfERJR/6XmLyfT3EDY9DcHj8U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92G07oKuFEboJj68Jjm0C/wtJ1Ag9vmYVeZWVab
 ZikgUkGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhgAKCRB33NvayMhJ0SKWD/
 40OV74sIDmCJCVZaSeVpyn3Fu+Qe9yUZHcb6dHbv+gJQpzuFmrrvd4hBtkGLDxvdGxm3MkzL/LyhDL
 tIB/V8sM3/WR9G1coYQuUJia4Mer/VVnmBt2G9Op00idR70wWU9iq03EiciG/yvoAdOCvqhBFO/526
 6u3YnEnIucZtNdbWjW78MXitoTvG0/MceN3diw6ZkZHd2Iceim4ze5vusYth9lWSJ7yT7UUW5sbUyj
 KASISbBsXO4K/v65L1K7TqflEFi6tkx9DnTBrjk7JUD0crKJIkiCluvkqYX0BwFI/94GMaE54Y8EWe
 ZPWBuTM5F9yB5h57v5hGPqU7dXjT7sGTSrrgEJj2Qh1eca1tB5nov6fwgW55mXuBiQCKpvGAxUpQIx
 f6y1paesd5J8+xTn72HugjcX2wqij187mcohwt7xmqtgtRO2r0anxYK1ewZ50CoWPMYgqDJzob1gxp
 mPYiScxjpZ1TGH6Wu1yHhUvrdVF73bN4Dm9aUzG6np6KF7SE0Sloh16hn77CmRQGy2fW3L5pdF08vm
 2dC5UKLtqPOWN1oe9zSM7q6rxAacGsQ9zWpGonggHc/PmbBZcLbDy1LAn6yXeX/V9cPqyKAS/zoH7r
 hr3u5vhw/VEEaS8P3dkONXoFIFTI0EyGZvcvKcWB++07OrscE46NP2W23Cew==
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

Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
static since only used in the dwc3-meson-gxl.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h | 14 --------------
 drivers/usb/dwc3/dwc3-meson-gxl.c        |  3 +--
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
deleted file mode 100644
index 966d401730..0000000000
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 BayLibre SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-#ifndef _ARCH_MESON_USB_GX_H_
-#define _ARCH_MESON_USB_GX_H_
-
-#include <generic-phy.h>
-#include <linux/usb/otg.h>
-
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 290ac03a37..5fb9b477ad 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -26,7 +26,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
-#include <asm/arch/usb-gx.h>
 
 /* USB Glue Control Registers */
 
@@ -193,7 +192,7 @@ static int dwc3_meson_gxl_usb_init(struct dwc3_meson_gxl *priv)
 	return 0;
 }
 
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_gxl *priv = dev_get_plat(dev);
 

-- 
2.34.1

