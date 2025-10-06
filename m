Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370ACCCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E6683D6E;
	Mon,  6 Oct 2025 17:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GbPNvA2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ED183D8B; Mon,  6 Oct 2025 17:09:40 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C728E83C98
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so45260075e9.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759763377; x=1760368177; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c60GofrJZMAC1wmGJeBtou2tJdigU4HHIzt+4DVlX6Y=;
 b=GbPNvA2v9bnqvxGHEgCzfisQ6dRWyVekBR5EvuTyR0mTolZhCiMFSnO1k5ecK6WUX8
 feT6Hl4Es/r4xUMmP+AnISwBS72jkWZXDTXhas008JBDK+/SkOj0MuTRdFkSjYV1jdl5
 hLUz5szWBOVJCVabQeSqH4Nul7mB0TO01Lwa+vUtLMe0tUieWKH3I2QJo3zr9bgIdmbh
 t1eaNcpxPfaHxiwJIcU4HT/5Tf4/ljR2sm/htgq7QS/u5Ws/zIoxePzSlwhPKDOM73oR
 eV5hoNSDC7YDP780hmnZSBwPHEWDmmhWSOo4PHtG7JvTkD87niKtrj60XcYZP69I6vCo
 Jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759763377; x=1760368177;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c60GofrJZMAC1wmGJeBtou2tJdigU4HHIzt+4DVlX6Y=;
 b=hmCryURorydBFZnMh62mcsefYVvFhqxWzSXB8luG8cmgcI8Oys3ptEkl/XTTGRfcpz
 dBraQSBo1RJebcAQB9fLQen+2xA4ECIrnmLiE0CuAXf6aYQZT0XBvhEXAXhOC/9pqpbw
 5mX4rkgbK3pRnQ8uEqpjLFMTea9KPXLVqy/U/GIENXyVacI5b++JALqZP0U3JYKyVrPk
 dpSQ7GHnbbz5r+Dg2urbVesCs2sYzXpU3t/Z12OaNQjyqtNrabAfqmfmf61gfbSNTqMj
 vl9x/kRAp9HJuf/rW5xTABP1t6hAgEeaL7vIZJ6mY9tLRvgpksjd8pnO85g/SwSoEtu8
 KzEw==
X-Gm-Message-State: AOJu0Yz9MarHpPrQXQoy6unjv+GL4hplNNqfJ+WeaY+CSeKCzHf6wmpP
 5U5QUUfOVAj/fIavfDZx323Ihd9cws5GnaEAcbsPRfLzHmra8MRHFbLnWdiIV24oXOs=
X-Gm-Gg: ASbGncud1gqzn9siOQtiUyj1IYjrovIZt4FwHLXTClQ1t6Qh7Sqy4k4rvYyC33Pyrrc
 Z+HW+ZLijbbnHDAmMLV4Kgcw0fTpZG1+oiAgtnDvkbFoF6kyg+ox8J4k9FhgoowN9P9GjtxCflm
 iPvK7+EIZTXabQrk3avS5DsL9qY0gqK9yDMprWV/w6d4gLE0FHBHVOmvWbaDW5g0VmA2roiLSnh
 Fm9KC8z5Qz0YZD9Lpcp+qhvUGxU9vgAT1uWtx1pBAbAPgw/jy32l0qIs0xiBh50Heuog3fQxN8g
 wG97FmO4LGJojd/LhuzxuaBSv49xpWU5kEQqLiL4CrRiOvi7k6YGgEqUjnyITZkPbxMdhT58cAY
 sdZay8OrLnjCVnBY9Y4kkSoFXsfwyT8OP74Sj5e2hib7zY9Vt/0YlPdUK0ctLBPMU3oasmbluqX
 xsPg==
X-Google-Smtp-Source: AGHT+IF5WPf0GEjj+xxC25bYRqvD5V+sl5HRWXONn2/lyvYOf+b9JYGu7ueFA+4K374FFWM2/MehlA==
X-Received: by 2002:a05:600c:5406:b0:46e:47cc:a17e with SMTP id
 5b1f17b1804b1-46e71101ae7mr74793985e9.1.1759763377150; 
 Mon, 06 Oct 2025 08:09:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8507sm260664455e9.3.2025.10.06.08.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:09:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 16:09:25 +0100
Subject: [PATCH RESEND] spi: spi-uclass: Use unwind goto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-spi_uclass-v1-1-6dec8be15fbe@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
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

In _spi_get_bus_and_cs the check for stacked parallel support needing
multiple chip select support does a direct return on error. Instead it
should set the error code in ret and then use the unwind goto.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/spi-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index d6049753740b0637880958feb48e4f523e9c2927..49b584c648d6ffb273f9d5c3f3b773799d26a1fe 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -449,7 +449,8 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 #if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 #endif
 	/*

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-spi_uclass-9a13292c05f2

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

