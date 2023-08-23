Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586FDC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDF0855CE;
	Wed, 23 Aug 2023 20:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="EUvDvioq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9008847D3; Wed, 23 Aug 2023 20:22:03 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D138609B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ffae5bdc9aso7015445e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692814921; x=1693419721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a0FXJvkq+3jL5EX4/J2EIR99c3X9P7ggiQsCPQOU9Pw=;
 b=EUvDvioqoOqTb2K1z1iKU76RR846Qx5qIb0SpH6V2nPEXZ8fxCkkWz1SqwXlz6VG0w
 2qX5kzsocXGpbw8c0GPvAjq7h2vcr9D3iMhnP4Ba6+cQZyZMEnS8tVojIbB5lGz++kHU
 KoDDQe639tf7F72LbCZ+WZgDxDqZe7zogrHtduW18mWx/CrdTqAr2SBm9d7fhQ6BDyGC
 BX3Zrnmg36ll/j6FuWYxp4DJhNnY/rus9S5Xj69CNegjaYB876t4WIklQpD+wzv6H5Ij
 XwZ3rxMul4RMA9F9ikqapNYxvmuvPkeqco4CfQPEhCnZXv/TdXaPPJDLpeyIlRqihxA/
 VnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692814921; x=1693419721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0FXJvkq+3jL5EX4/J2EIR99c3X9P7ggiQsCPQOU9Pw=;
 b=G+jt04KlE2LT2dxWhp6exyZS4P2ss2pA1YsWeyIu5QVI1yR/dZH6fKNCWMiXuteVMQ
 qFD23cqyJ5zotEcIjhUCGkGcWia1OSxrdoxz7EOVZ+BUvx5YxqmIOwsYfpHMfDXy12tu
 oIhkrlFqOsBC6WB2KQWM9CDnAnA7rdmwZLtwq0WmhNWxSm4ebhYLqvFLdGdz90BbVvV3
 VGuV9za1MiqYyMNSZYhNXqiByVdU2JoTH4gjLwYuBrHWDVyboP1DtcnfoUyUDHybLvhB
 HHYsOmifQ14gdSuSL6el7Le2K+D0tfQ62EP1ku4Qg2ESeQPpmvTyvQSLyX9f8nwmF9qk
 IBAQ==
X-Gm-Message-State: AOJu0YwpCa4Fy6lHiy0BPu4utMEH9Mr3TVrCUOfcwSrL5SNm7bJs8DOX
 QY1KXsbgPwR5v1A/2fz3SJxiQMnlC5CFugeEcZE=
X-Google-Smtp-Source: AGHT+IFVY4dL3d2pfmTRIiO2RHv0VP8GcGEvFlX7RsjC7F+wSSMKTxIvLQbhTAhxZRXtH+H4/zACkg==
X-Received: by 2002:ac2:5f81:0:b0:500:9214:b309 with SMTP id
 r1-20020ac25f81000000b005009214b309mr3073120lfe.56.1692814920900; 
 Wed, 23 Aug 2023 11:22:00 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 x2-20020ac259c2000000b004fe432108absm1789155lfn.182.2023.08.23.11.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:22:00 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Date: Wed, 23 Aug 2023 21:21:48 +0300
Message-ID: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
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

Changes in v2:
- [asked by Tom Rini] shrink the code using CONFIG_IS_ENABLED()

 drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 79cf71f7a85..58baa017ad1 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -134,8 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
 };
 #endif
 
-#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
-	!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
+#if CONFIG_IS_ENABLED(USB_HOST)
 static int dwc3_layerscape_host_probe(struct udevice *dev)
 {
 	struct xhci_hcor *hcor;
@@ -194,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
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

