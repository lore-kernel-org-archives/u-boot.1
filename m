Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10EFCCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3E3832AD;
	Tue, 30 Sep 2025 18:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/ERa0v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA648349B; Tue, 30 Sep 2025 18:06:49 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90041802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-414f48bd5a7so4019009f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759248406; x=1759853206; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OiuSbI7g211UEO5GChSRVz7qI6UicdNTI645ZLK248s=;
 b=a/ERa0v7+zN/Hbay9h00lOPCvu2hvLxgbaVa927QQr97OVGf3+Ooi+93ABeSs9RhCG
 VcUxEsS/2VZJ3+v4HcokkjiK80ZOK7vKdNc84ZIejTCL/8h5iF2iWTUYcELuiC3mHDb5
 poQSGSIldPrKHMJ6Li7kSvMAB2G9uBnz+jIlnZE5H4/ZP0n6km9zVJcqfNjoYsyV+DcM
 Gmuwg2eqgLPij/btLrD2rLfVT/unf6hSDciiG6PbLiaE5dU/MX0x2osh82K1GnAb0Xog
 H+bbHPi5k0nXIOqhi2sptHcuooJaG1ZN9b1Q6MW3kzZAB9zWdTUQl80y79DztniV4adA
 8j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759248406; x=1759853206;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiuSbI7g211UEO5GChSRVz7qI6UicdNTI645ZLK248s=;
 b=XRAw8PHjYkDmFGDGdPoo7S9WnTEGAdgOmjnlvT/RYrFFBYMFjH1curOAwZn0EreNJF
 RtCnQrYC88mbGzfWq5xAvDidk7kw/K+Uo9mHL/BfglJojI/mTXSXaRa1CTEudZzp9ck/
 qA8StQN5Nqbm9TD34HMci7auQr0/S//ywYFDwlb4q69ZRKN4Carfgwdtp0Bh4uIr32o9
 Fe3CZJm9ARYBW9p9cXAJRsD5zz1wzrXF1NymeupdBnuDpLQYV2Uv+AKOfzeaaoP7A6Yg
 pOPeX2xLMR3oEcRWOHrrR7AkVvTl/fvlCzSfODEEtvO2P8r+RKM1eQxGQ75x+qjwcPF9
 1TjA==
X-Gm-Message-State: AOJu0YxaKGortCscBJO6LJcCRwg5fGCjgfSB+qVBzlqh6bB6aoUSc6Ui
 JX0GXp233O+78Jk5V1BeZ0iqHeB7i/HKzG4z7ALVNdkxHg8agvTwFt1yArqCacu50Sw=
X-Gm-Gg: ASbGncsOT6Gbuhxo/GZIZ8/AIYdkgPncpO4TonkNz+XiVKuCQ1hZSXIzfyxHUx236RP
 D7RXXuVDktTsvQGtyGyc1mHnv+TBhI1WgYbjafmiwGbHee8C4gVZFQSjSPRoym14T7LSQiHCUCX
 6TlLOn24ijNPN53/jyOyjQpdYKh2rH+IABiPePXkZBm3LNQW3/Ylf5LZQ94prJW5sIzgxqWysXz
 Wm+uFaWXSegkfTImv9t9UnCPkMY5QYgaHIyNC8Rkamz4OX+HSYavyr4WXDXa6cpSkYGMwLgKn0C
 +H9xhY8S7sGM9dRuPwgxA+iPul5qbo3eGY+lv0TJ19Cf+MXxuUTGA21CoYItDasU2LeJ4vSJNjd
 G49LJq9R9/7m/mZa0zZekOGoEo0oGoUhSwnUWpti91ljiKwZbKqnK9mT0KxHCjnnWgnfE+wEV6y
 zKj00lzCLKcq9jPUVD9gI=
X-Google-Smtp-Source: AGHT+IFjNNr7IHCEhtiUj9erjVkeSohZxkGPLmyXDtuywRTctb6fSruckZjfBEsLKukhy+/nqtAnwQ==
X-Received: by 2002:a05:6000:420a:b0:3f0:9bf0:a369 with SMTP id
 ffacd0b85a97d-425577f34e9mr278637f8f.14.1759248405910; 
 Tue, 30 Sep 2025 09:06:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb017sm23228178f8f.3.2025.09.30.09.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:06:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 17:06:44 +0100
Subject: [PATCH] usb: ulpi: Incorrect operator used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-usb_ulpi-v1-1-26c929ca2ed1@linaro.org>
X-B4-Tracking: v=1; b=H4sIABMA3GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3dLipPjSnIJM3UQLs8Q0w0QTE0vTVCWg8oKi1LTMCrBR0bG1tQC
 YG0/SWgAAAA==
X-Change-ID: 20250930-usb_ulpi-a86af1a4495e
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
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

Combining two bits into a mask to be used so that the same write code
can be used to set or reset bits in a register clearly needs to use the
binary 'or' operator, not the binary 'and'. Fix it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/ulpi/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/ulpi/ulpi.c b/drivers/usb/ulpi/ulpi.c
index 128adcbde134bc5a3b3705c3ddd932b540b54cd4..0e0f0e4983d33583aa6d3212ccffc9db9ab3bc29 100644
--- a/drivers/usb/ulpi/ulpi.c
+++ b/drivers/usb/ulpi/ulpi.c
@@ -127,7 +127,7 @@ int ulpi_set_vbus_indicator(struct ulpi_viewport *ulpi_vp, int external,
 	if (val == ULPI_ERROR)
 		return val;
 
-	val = val & ~(ULPI_IFACE_PASSTHRU & ULPI_IFACE_EXTVBUS_COMPLEMENT);
+	val = val & ~(ULPI_IFACE_PASSTHRU | ULPI_IFACE_EXTVBUS_COMPLEMENT);
 	val |= flags;
 	val = ulpi_write(ulpi_vp, &ulpi->iface_ctrl, val);
 	if (val)

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250930-usb_ulpi-a86af1a4495e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

