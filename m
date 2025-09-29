Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D29CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECE08319C;
	Mon, 29 Sep 2025 18:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmUM3CQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923E38329F; Mon, 29 Sep 2025 18:40:48 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6369682A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so854638466b.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759164046; x=1759768846; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tmu0o3FrvduV3rd66M91Fet2RrzenpC8r8iZWfvrjvA=;
 b=pmUM3CQkpsrN1/PhLiwn5lFQR7Y6pR4bhXzywlXgkTWBurxrz3z5YR5j1oewTCBOcp
 IS68AVNYYqu4yk+O1Tc8LuPK0ZdQjMSbY+h/FYuK4X05+lQ5Snpq9G8HFJCK13Quq9EN
 Nd4Cw9I+FhKovMy+z3bfzawVJEAb6pc1cYZfSd/ulDv/q+uRTxh5WgY0L8UEvRThigrQ
 mNXXhK8EDXuqJGmkTx16dOlRMwlqZ38Lo7IZcybki5y35a6uO0eh2QpAfmsE843jWipA
 YW+tRTdPGhws9pIbLKgdBbnq7uSXbzMOSxfdzemWEcKTRzFyjFwshZ9DX0j2K1x4NTHa
 UR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164046; x=1759768846;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmu0o3FrvduV3rd66M91Fet2RrzenpC8r8iZWfvrjvA=;
 b=sfeQNni6F8ztba8nLxPD/2T8TuSNj93D5JvkBP+bsj9MyMEcwCKZXy3qqeceShPfrj
 dq+AMqCBr1qfH3XdGjAdT0BtmvW8O/oXvJAboXerwMvUDgkZIX9fVxEES0t8O/ktH9+x
 VhaztK7xFBFMZHfxmv4Wf20IvjapZGcZ7FCzWNFLoTvtsmGAqxsJPHnlWNxkNZaITbgF
 ItggQ0i2nqmFKLqnhGdVouEiM5QyRgiOTeKWByypWVv4KNCLd3MaEamedPoTQwde5M4W
 wenXLBFZ5GbvYMwxaK/RtMN2+j8eR/TWjPL/fHyJF0Hppg2fBH3yATdA6P2NYdhrPdNu
 txKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCxNRrPpfu/3MFtwSXNPh1/Rk2xZgtsI2bZJw3NTkldCyC9V1/IkguPFw+Wszv0L8ZcOjUNaI=@lists.denx.de
X-Gm-Message-State: AOJu0YzborhGKg33iLVPSs5TEtoGYoi94ptZXVuS+AXRujiSbPFGCwlt
 qaDH+t6DJoNOHbGBYFpW67c0WFh8w0erCJKxhekjYNqmjZN/7WoRNxxQY4BtvlLrnIw=
X-Gm-Gg: ASbGnctmLXB9mX7ytozI9CinbhEQjswfCkJ4VRZ5T4wb4+Dqq9tmbgaGH5sHAhLfJKk
 uTUA1UTEIaIOmLx30+zRio8HZxquHbLVvAnXt3iCRYBrnVjpKXbHJVYgtqs1NdUleU+AnuITrGn
 FPndM8lLEvWBwhcwBlWQWLYiKdRzd0tsfAoXh+w94SpBufQ7RbCitmfyuFUP3FzCAiuU2dFEe+h
 hd2jZrr6mWfzFTdwLY3lthVFzVK/vQK8I4yoNJm670ltVWUUPDl8dC0xsiDoT9C6s2oIK8qVMPQ
 4gUBawsfj6+6Pdwdf4u/X5bZZLA4zwbKZhWLCaSQ3nOeEDWMiP00p1PBoqx5z86/yDAEedOWb5S
 KCbAgsqQgoyTpRwwoOcxODgZcD/FduxjowNTHgYeBNS2ab8yAjw==
X-Google-Smtp-Source: AGHT+IGAs35QpAb6G1epy+J0Ew1IYlmHXhevBrI1/sh/TfpywOGazx64rrlUem3DrXTHGj7digCR4w==
X-Received: by 2002:a17:907:da8:b0:b3c:f0a4:b324 with SMTP id
 a640c23a62f3a-b3cf0a4bebamr687671166b.21.1759164045757; 
 Mon, 29 Sep 2025 09:40:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3b4271dea9sm479529566b.88.2025.09.29.09.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:40:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 29 Sep 2025 17:40:43 +0100
Subject: [PATCH] usb: dwc2: Add missing null check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIq22mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNL3dLipPiU8mQjXUsjkxSDFCOzlDQzIyWg8oKi1LTMCrBR0bG1tQC
 kLXs/WgAAAA==
X-Change-ID: 20250929-usb_dwc2-924d0d26df62
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Add in the missing null check for dev->driver that is present at other
points in the function before it is dereferenced.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index fca052b4556a7d2ae4fe516e39820611d7082e2f..5a7f50ebaa5579f67ea5dc9491d0d1f4d4b81ea1 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -526,7 +526,7 @@ static int dwc2_udc_irq(int irq, void *_dev)
 		if (gotgint & GOTGINT_SES_END_DET) {
 			debug_cond(DEBUG_ISR, "\t\tSession End Detected\n");
 			/* Let gadget detect disconnected state */
-			if (dev->driver->disconnect) {
+			if (dev->driver && dev->driver->disconnect) {
 				spin_unlock_irqrestore(&dev->lock, flags);
 				dev->driver->disconnect(&dev->gadget);
 				spin_lock_irqsave(&dev->lock, flags);

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250929-usb_dwc2-924d0d26df62

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

