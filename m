Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8A5E6B242
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1D48928C;
	Fri,  1 Nov 2024 11:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+H6Zb2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B31E88A4C; Fri,  1 Nov 2024 11:35:35 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A4B88DEA
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so16551671fa.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730457331; x=1731062131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=steRWnFS145lzSZLeApa0ZMBwOfoCBnPIfz8Y/zaj4g=;
 b=I+H6Zb2WS9GKEKRO9EfBmXn1RzOrXv8fy1PIMMYtUXr/K3xigibnLG/201thGr6Dy7
 GTOybMqDcwIPoXaVifI1VTvcJpIZBfBB3dq3DaUbiXL1HknOrtXRj87QOH9wsjz3Z/Hn
 iDZRcyWOT6IulxgLpN8ZyLnLhPirbLsb7WinbQY5srVVS0TwSpB/IGumt8rQ4auYErYs
 orRiKZHPz9Cf1YVzl6uy84cdAMhXRRkZiuRlhSUnsCBa+QjbH+7pdL43C+XxJuVo/I4N
 hsxOSgG1IX2r+az4Ey9qq4HvlsXoLmzejqtwIMLI/6nuUmpNUw0jH6dIb9fVWDBfBpdx
 DgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730457331; x=1731062131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=steRWnFS145lzSZLeApa0ZMBwOfoCBnPIfz8Y/zaj4g=;
 b=YEQ/cvIloLXG/VR49Jk+wrbFV3CTJHEsUMX/RgFS5VLoFLtb5r01dBiAN38Eo0lbhd
 41x5DeRmlsP41LGjaJC7k92mW1KiAwxJBx/2+JTc+Wqo0B8I4wJYXsla/pvIu0TUqBmK
 O6h1s8NnxFHbtY9piIRnzdRwzr/uWmYNPkh1NPdR3IPi9voV+W8OIc34ypha5EZyUpxm
 uPDkNPzsWzNgLbegK8JiSnmkK6USNGp8NEkgxdRJ06G6ERqidYF2eC34wthiOGT06/c8
 baZuZQIb2jpSN/X97OC3hSbP3CPJx1eYUuq/NLN5xSH+ydg6ou3rLjhzBwq4mNGXCikG
 OvGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZTDu7WbwrpGJwDORq5RMlAeHKZ3jX/SXTeRYqY6ngeuZcEGc95rr9+a/R8dUvLLTxB3V5vo8=@lists.denx.de
X-Gm-Message-State: AOJu0Yww0WDSNdlNYOkQcf5w5hQZx5/s4gFu9ivDeKWZl5RsXYLjK8o3
 6pzd3FDcoTPcbxF+s9FPfblwCWjIGV3hjeBBl7OXLaHkvpgo7qC+
X-Google-Smtp-Source: AGHT+IHmUIV0743/Nec8A/rgCO3Uu1OGMSDtELuHl+0omxkfHm0ZTmOjKQXzvhRYBf0UvE1SSs8z7g==
X-Received: by 2002:a05:651c:154a:b0:2fb:7e65:cb27 with SMTP id
 38308e7fff4ca-2fcbdf68bf5mr127193651fa.6.1730457331228; 
 Fri, 01 Nov 2024 03:35:31 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-63-138.dsl.sura.ru. [95.152.63.138])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef5d7400sm5163051fa.45.2024.11.01.03.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 03:35:30 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Wang Jie <dave.wang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/3] usb: tcpm: fusb302: add missing newline character to
 debug output
Date: Fri,  1 Nov 2024 13:34:50 +0300
Message-ID: <20241101103501.21432-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101103501.21432-1-bigunclemax@gmail.com>
References: <20241101103501.21432-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Add newline character in dev_dbg end.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/usb/tcpm/fusb302.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
index fe93ff3d339..ee283782792 100644
--- a/drivers/usb/tcpm/fusb302.c
+++ b/drivers/usb/tcpm/fusb302.c
@@ -940,7 +940,7 @@ static int fusb302_get_src_cc_status(struct udevice *dev,
 		return ret;
 
 	fusb302_i2c_read(dev, FUSB_REG_SWITCHES0, &status0);
-	dev_dbg(dev, "get_src_cc_status switches: 0x%0x", status0);
+	dev_dbg(dev, "get_src_cc_status switches: 0x%0x\n", status0);
 
 	/* Step 2: Set compararator volt to differentiate between Open and Rd */
 	ret = fusb302_i2c_write(dev, FUSB_REG_MEASURE, rd_mda);
@@ -952,7 +952,7 @@ static int fusb302_get_src_cc_status(struct udevice *dev,
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "get_src_cc_status rd_mda status0: 0x%0x", status0);
+	dev_dbg(dev, "get_src_cc_status rd_mda status0: 0x%0x\n", status0);
 	if (status0 & FUSB_REG_STATUS0_COMP) {
 		*cc = TYPEC_CC_OPEN;
 		return 0;
@@ -968,7 +968,7 @@ static int fusb302_get_src_cc_status(struct udevice *dev,
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "get_src_cc_status ra_mda status0: 0x%0x", status0);
+	dev_dbg(dev, "get_src_cc_status ra_mda status0: 0x%0x\n", status0);
 	if (status0 & FUSB_REG_STATUS0_COMP)
 		*cc = TYPEC_CC_RD;
 	else
-- 
2.45.2

