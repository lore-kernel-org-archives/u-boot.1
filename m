Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8323C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5C4866BB;
	Fri, 25 Aug 2023 12:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="LsYLmHVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 232AA865D1; Fri, 25 Aug 2023 12:43:08 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD91867CA
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff09632194so1148323e87.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692960184; x=1693564984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=38HyQipAt8GcNLZqXLpLjUxXkp99nVosgY1kfpTiY7E=;
 b=LsYLmHVZ0LA2hxqPRjBcngr/uzlfTCx9CA/Gs0P+6g9ttVcrrqqnjbyHj7MsS2RwpY
 VhAJMbZU90gbSymGsINEJtD3wq2vQ+qmhMxs9jN6AG+4FLfQLITnHRNyvE43E7qdsD7g
 trxj1kreKWlZnNluDHPS8BqsttZBBVMUh63NNIPr6QToiZxe93WQ1m3Ka9IVE42RPqua
 xZ9tUhkFiOWY2/BiRfLD/ktgJEvvAIXoebWuqC7wOvdE9V7I2hN5Nn44eKRz5cWkQzUI
 FmT43XPFUrE/h8l32SQHyTrNJ7OTt70pLIPWvVt0Usu9N+50Upba+qOC1iJp+w4qIWcQ
 BHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960184; x=1693564984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38HyQipAt8GcNLZqXLpLjUxXkp99nVosgY1kfpTiY7E=;
 b=BNl4pzbAfb0CWCYFA19nbqtIQfxHLHmXvqndn3XgHVXxywaPdyGPgEc7sCDwdEA2V6
 rmBwLh6d44rIu2m0+Io985cEoAiXcLsXnDDnWrsddwsusUJFRKe7UNWbD4HxmjMti9f7
 OOA3ePLULghCuFls3w3qjxCSCjcAF48lCeUlqydIb32feNUEsKS5ZwYgX44dhpLJNVAS
 6EAs57CPFNm8r0mq/eqEnmHe1e4KhX8LAHyRkEOL+XJPUANgxs3wvP7iMQ8dw6Dom+Co
 llxtGXCUufqZQKDuWKWG3nlO1vReeDYj0mrbS2GCjZFuplfn4NtvF8bF8wplmdcfRPpO
 9CMg==
X-Gm-Message-State: AOJu0YwL7+kExWzp0wfGCVtdN1EpYiT7GSyCogQzvl1Hzh9Ydc66RwHX
 FX1TTXA7uiTpXqYvEbTTDwWyOG4za3krPajKhR0=
X-Google-Smtp-Source: AGHT+IFhcK1lCOLXlfjGHbi6b2LDXdaMo6WiijYH8/S+ZrL7MxigDCYZNz/yjFe5ACMznHSdRa/gpw==
X-Received: by 2002:a05:6512:b20:b0:4fe:1681:9377 with SMTP id
 w32-20020a0565120b2000b004fe16819377mr12355595lfu.44.1692960184432; 
 Fri, 25 Aug 2023 03:43:04 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 e17-20020ac25471000000b004ff71ecaebcsm238359lfn.268.2023.08.25.03.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:43:03 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Date: Fri, 25 Aug 2023 13:42:39 +0300
Message-ID: <20230825104251.28311-1-oleksandr.suvorov@foundries.io>
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

Fix original logic in dwc3_layerscape_bind() - do not enable

Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

(no changes since v1)

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

