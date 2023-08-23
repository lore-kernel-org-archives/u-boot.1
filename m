Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6092EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C8D80842;
	Wed, 23 Aug 2023 16:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="X02457o6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF61807D4; Wed, 23 Aug 2023 16:22:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7786D8649A
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso8692173e87.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692800551; x=1693405351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1PQJvwcezBX9NNdK6J01j+9PpOBK0MsiBdmg1LmQK+A=;
 b=X02457o6byHtIrEyZgcTWWWlTNRn/OKvblyneMOgq7uGODbt/iZU5KGdNnkQtOupN5
 av0SqG+IGZ9Vvpi6PatGKMFhKO6ocFIsOznznkIIGFrvsXVhOCC+N3WTy79H3mc4Hmv3
 NQu0mj0slDfBA4CPp3lWSZvo9B5Df8x5/Ixk317FaNXR77uzEoH6kqamp5cil2M6s9LP
 FFLYzA7dnoagHn1qfVaY3t7cEJcdNrpnqEkk+mB0dlh/F2nKVO/z6+NodF32bOhOsAgx
 FzSyBnsNtZjOIqeB5zw1y9FtV9cGs2E+Fb52X+Hvj6mcLNTJPeP+PFOmYwKthN3GFmyW
 KtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692800551; x=1693405351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1PQJvwcezBX9NNdK6J01j+9PpOBK0MsiBdmg1LmQK+A=;
 b=I9CGCdOqkxixel7+jYim1Ng8nWumeFOFvqAJJjjFzkR2G5HdZmMNHliD58mxCckhoG
 W81U1LbgpP9IrxNwBFjeN2nZRa1gHUJi0EWeDlnLEVqKinkAgSNvWyW4D7pkaOy74WjX
 F0ljeTd4LDJgma/oTWfrJY0PvhhTf5ehs+1m/GUP+Q3ZcXSyACMVGNxAonw7uzdzyt/Z
 bVNZNwAaheE5OFqdE5+RV2YKL/kVMz2IG9DFzVMJY7IR9spUSg7xTh0Sz2Zg7uSof+e1
 /GM9DeXhOCTW2VBIcvTewHSjN+h7IEGF/Z0DHf+EHLcAWv8uHB0kHtXUpscJ6RxFMAoC
 Qkrw==
X-Gm-Message-State: AOJu0YzBjtPTjqnv6ydSAH1NwTkhT6EVIsXzEih1nvKtB7S5YrBC/AD/
 DL8+3h6irxQb70UJfg5pJ0G1jadq06YDqO5GLDI=
X-Google-Smtp-Source: AGHT+IFFBkaoSXjUiunSuxEvc34mvXnPYwcE2zIOTwCfjpm9iNM4W3zy1GPxlQXl6u4Safn1zNY7Jg==
X-Received: by 2002:a05:6512:1584:b0:4fb:94c6:fd63 with SMTP id
 bp4-20020a056512158400b004fb94c6fd63mr11617811lfb.17.1692800551153; 
 Wed, 23 Aug 2023 07:22:31 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 n23-20020a195517000000b005008cd9396bsm759983lfe.25.2023.08.23.07.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:22:30 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to SPL_USB_HOST
Date: Wed, 23 Aug 2023 17:22:19 +0300
Message-ID: <20230823142227.69923-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

In the usb/dwc3-layerscape driver the first option should be renamed
to the latter as well. Do it.

Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 drivers/usb/dwc3/dwc3-layerscape.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 79cf71f7a85..77801c10084 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -134,7 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
 };
 #endif
 
-#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
+#if defined(CONFIG_SPL_USB_HOST) || \
 	!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
 static int dwc3_layerscape_host_probe(struct udevice *dev)
 {
@@ -194,7 +194,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
 		driver = "dwc3-layerscape-peripheral";
 		break;
 #endif
-#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
 	case USB_DR_MODE_HOST:
 		dev_dbg(dev, "Using host mode\n");
 		driver = "dwc3-layerscape-host";
-- 
2.41.0

