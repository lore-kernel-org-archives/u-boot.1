Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B5CC83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B09835FD;
	Thu, 10 Jul 2025 00:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HNgTUvYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8C6835AE; Thu, 10 Jul 2025 00:29:32 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE15835CB
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40b71debe9aso147636b6e.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100169; x=1752704969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS680+E4O7xGEmJpkc3trw6EYfUt0F7KTqazU831HyU=;
 b=HNgTUvYFDjyFMKSsb5sgV77MuQCS+ea+E9gas9F9aQl5F2ABFXkxJwF6kI7KTNCJgD
 4abaPLixfntrysQrvY5n6HT30fVQrvB3Hv6GIXLtS3khPlMzeqn0oggJf5vPy+BA1/Sl
 u9QM66EeZvZWTH7MtTWuSu6W1kBaiUyRXq3a/OIYpHP/KHq3eGS762y4wUQI2n88lvmc
 wciNnpJaDbZxQFKUhBvL7CZ0b+/1b5FNAyPua9B+X/C2jUX/AYc0m9fa+rOoth9CrNcR
 LbKSOVCDl0uDjH+zW+3HDGxlryG2vwyyjfDN1dHXHWUd31arMe66WcWuO+88AMysgR13
 ILIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100169; x=1752704969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VS680+E4O7xGEmJpkc3trw6EYfUt0F7KTqazU831HyU=;
 b=FD8BHy37Hr9kQQbij8qjGw6vNyvCmYdA9O+rLdygmQ3me4Km1uz1TsR0uXpt5vPvHm
 juwRpH/8+BPSWlhWF0IcJ7DkGQ5iOn9NIx+sqDrJ3ZWA4kvErtBCO+dp92J2QRk8ODeu
 Sj1nqatUMqjI8nVTeAOwEewQ193WG/YS7aRLg6O8bERVzw+RNdXoSAlBPA59h9mSApB4
 ZLY2vmPgfTicHgivtEqNF58DgYCP7a7rgudVbWxSzLLWmRzVso5k3BRD6valQEWNCN/E
 QWqOktOPOY/YikykLZrW3XkdLZ+7+kXW7KRakRcvSPar+UKVi1kXf0D6guZv/8544TsQ
 kYpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NdBvY04NXppkg0HQJnudi7S94NxheSb+xkoFb3muja5i+WCa2RgPmfvPuSowz3+XhHok14U=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz2oUkD4wgHnZjAmVayEO3SitVy+uBqexJEZwSE1oePHCco4kF
 qmyWCarKtBXy7LnzvjyanAsOv8VgLqF4DFm1YP0SKm0qYJhRz8X//hM2AVVUx9EJMag=
X-Gm-Gg: ASbGnctrEKnQn8v4OJscu3Lja+K4w3opr+nqotquYVHwBI9uwn98G5Zv0j+JEiERQ9K
 bNprMHCa+uo8HakZtUJy9J5aUuis1mhx9N5fmjcZaHS9XG0YuADDjA41nG728/LBM2ztmkDYNje
 uyY0hv3eMiWBl+BvaK8ttmSSTEKHyxO2AOkU0O+XVMmsxmVIg/FrvsixX4VIeQL96K7GN9C9DnY
 oCNE2WJpxuv6MjwET7DxHsFsBnpbuLWZF5hATsq6aGR5bcwMhpl6xFBI5d4EikFJGB/xwKRrBh8
 1q6Tc1GXZ5bDnbegROHDGVL/RVK0fCmRLdwLHcNujgpet64Eq+0VHvxDFBuA6l3J1A37XVGw
X-Google-Smtp-Source: AGHT+IFDW5zHs9paSo2k+RXtbJo3QTCecMIFSvL9LNemYNWioimeTrzy6cfqWI+a6bUN5i/k/hzveA==
X-Received: by 2002:a05:6808:1202:b0:408:fbed:c3ab with SMTP id
 5614622812f47-412bd492821mr2665582b6e.38.1752100168776; 
 Wed, 09 Jul 2025 15:29:28 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-41419baa665sm3073b6e.21.2025.07.09.15.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:28 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 2/9] usb: dwc3-generic: Add Exynos850 support
Date: Wed,  9 Jul 2025 17:29:19 -0500
Message-Id: <20250709222926.24671-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

The only thing needed from DWC3 glue layer for Exynos850 is to enable
USB clocks. The generic glue layer driver already does that. Add
Exynos850 dwc3 compatible string to enable support for this chip.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 21452ad15693..3cda2b74b7e3 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -704,6 +704,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
+	{ .compatible = "samsung,exynos850-dwusb3" },
 	{ }
 };
 
-- 
2.39.5

