Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FAC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A4D80FE1;
	Fri, 28 Feb 2025 09:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c1+w+/rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCBF280FE2; Fri, 28 Feb 2025 09:47:24 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B52807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390eb7c1024so587697f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740732442; x=1741337242;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TKGcVYGrpwcucxgs2QPc2UvKSARSQOFFXdbBpus625A=;
 b=c1+w+/rb6fj4re+rvqG6kDKv79+XsI0ylY6qPgnOebPnUoqmxSDz8ZFDbZPE04EXs1
 CQpYMgJNMEJ37aDf4loHGQFRPqb/UuJHPer9J9mIWaqLIRCgTq3T25ibNBS/mWN1aHZP
 6WsFbSKAoJp84YEr+T6FK6ULcnsykGy6bJAhzrJqwwCt0Esqcyu9XDILGvoTKlHY+zTd
 0ND1P2rVtYwLHbkuEEW08yevT/T+UZuBERVUg2HUcSgxRkXc4CmDpEN3JhGhDc2kM87G
 8nDq/hyDBKY1cTofaMmFL+2jATwJP9zLD9n3W6XU4GAjHsdkT1i5Lv8ieT43e5z+OBPl
 j0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740732442; x=1741337242;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TKGcVYGrpwcucxgs2QPc2UvKSARSQOFFXdbBpus625A=;
 b=iAOS1wfCCXx0lxDmUaZ/HS0IHNC3I7mCDJQhzbWwrbxHbCzAhfEVvTbAWba8oJRCoU
 IZsSQmaKahuEKDRvTT+hz2spesYrVrclAuxKWN32UcP93lVRulhdkufjPC/jSGrjP86p
 QIJppFTk4ax257CWxm1G5Rn4GTp46UzACaKqfUmHO2O8tuEoqn/f95WdXcXPjFnZXDOp
 QzgYpgU8/5q7K2S8QsbcaSvBcyLPs/L5zleXfXFvNQpnxFOdauxpTgacQx2bW1VrBOYL
 S2JYrF10ykfWeguBjuBBmu7ox17rjvQBdmd8dvqvh9jlifOdG7ub/WRxrZirAUj/OU7z
 nnNA==
X-Gm-Message-State: AOJu0YytN/bjZggvsGSBJAk4J/vSkRPrAE3lH4rNbhj+CNA6C/DJO7V2
 bn0YpVaQSSZsdPPdW2I2X9TsVqmvSnXN7vEhfZohCsXmJ0wyUOW78l2z2+AWxuISK/Y2BXk3691
 d
X-Gm-Gg: ASbGncuBoB1U3K9pfXu2ggq0LZMT5iOanA9+o/lQ7K0HQcymChfges9fOHAelAfu3kG
 5rmpKawc0JsIl7SuH1DZAS0i7KWYhRxr3PmrJM420War2V0Ke1F3Rhbv63tkOJReqPf/VIMuiG0
 8uXsPJgYqJHNR4xzNPKBS4+UCwYEOcCtU9fxzVTTfWxIGyQXbMg10IjmxL9lo75uoUPMF60fhNK
 yJOkhU/MIMNZu1jiETeg/QTJAGUys+XqVIYwDvJbt0GBgzrr+NqhR/60LS91yzTeBqpAq/l2EK/
 5jzs029lPHLIPrmokcXIq7cCtTlj2YngtWhPT68/hg==
X-Google-Smtp-Source: AGHT+IHbATPrLbVapKMHZnHFzKQ9FSgS9nbejxNGAUCXxpU7I0hs/trVGTZE7yh5ydetnLfLExgFpg==
X-Received: by 2002:a05:6000:2d07:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-390eca4a038mr1609439f8f.46.1740732441666; 
 Fri, 28 Feb 2025 00:47:21 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a78sm4455341f8f.23.2025.02.28.00.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 00:47:21 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 28 Feb 2025 09:47:18 +0100
Subject: [PATCH v2] usb: dwc3: am62: Use UCLASS_NOP for glue driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwc3-am62-gadget-nop-v2-1-e5d43f19bf5a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABV4wWcC/4WNTQ6CMBBGr0Jm7RhaBNGV9zAs+jOFSYSSlqCE9
 O5WLuDyveR73w6RAlOEe7FDoJUj+ymDPBVgBjX1hGwzgyxlXUrZoH2bCtXYSOyV7WnByc940VV
 lrjfb2pogT+dAjj9H9tllHjguPmzHyyp+9k9wFShQK+faVotaq/Kh1fZiHehs/AhdSukLMhX6/
 LsAAAA=
X-Change-ID: 20250226-dwc3-am62-gadget-nop-4b33c79d8d5e
To: Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
structure. Glue drivers, which implement dwc3_glue_ops, usually just
define the .glue_configure() function.

dwc3-am62 is such glue driver which does not need to be a SIMPLE_BUS
since it does not interact with any child device.

Use UCLASS_NOP instead as done in the dwc3-generic-wrapper.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
This is a small cleanup intended for next.

This has been tested on AM62X SK EVM using:
=> fastboot usb 0

$ fastboot devices
????????????     Android Fastboot
---
Changes in v2:
- Updated commit message (Siddharth)
- Added Siddharth's R-b
- Link to v1: https://lore.kernel.org/r/20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com
---
 drivers/usb/dwc3/dwc3-am62.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 99519602eb2c66299445163fafcdb3e065c89eda..66164d0a80c0264bfc400426782324f8a57b8bd8 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -116,7 +116,7 @@ static const struct udevice_id dwc3_am62_match[] = {
 
 U_BOOT_DRIVER(dwc3_am62_wrapper) = {
 	.name	= "dwc3-am62",
-	.id	= UCLASS_SIMPLE_BUS,
+	.id	= UCLASS_NOP,
 	.of_match = dwc3_am62_match,
 	.bind = dwc3_glue_bind,
 	.probe = dwc3_glue_probe,

---
base-commit: 8dd7186ca7821446c6f46b6cccefab502912f2e0
change-id: 20250226-dwc3-am62-gadget-nop-4b33c79d8d5e

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

