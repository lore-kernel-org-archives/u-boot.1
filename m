Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AC4CEACDF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 16:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD3489247;
	Tue,  1 Oct 2024 18:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rm6JjIn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9347A8923F; Tue,  1 Oct 2024 18:06:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1286089246
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso40343205e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727798777; x=1728403577; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y2N7QVIQOxTKQ1LJHZqwIMoE5JXGIrIr6uvDym5gOtQ=;
 b=rm6JjIn3q8A+fgZocxQDTcE6xu6WSk+guadjtgWvs1lUibMTE3sl49sGeP+DJj+TpH
 ry32JMg7mIXosq3eWVzd+Xeajnj2GlIU6uQaY0uKVC2OvX/zcrCBQ82fgF/mSPMjSYdZ
 UMFSSitw9dFNYnqWs3y90OQSZj9drgy2kRfx0YtKAOA59crQuC/d0NHi2ssIjEWVTg3N
 /9Vg7nyR+eMFv/HxVn3PAYujptagva3jQ0kJRVVzyPSQvIhp+Ni2JGrBUyElClxJYnls
 czXjg6r7R54C4ZFzQ+yV+5Lh2bMP0jrx2IEg7jpkQPLrWzYFZi6HnVpuwek0fU8jk894
 GQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798777; x=1728403577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2N7QVIQOxTKQ1LJHZqwIMoE5JXGIrIr6uvDym5gOtQ=;
 b=ADTKTjGRPhnNneaYf02E3w3GONfKN2WBVIB5+EbCLERmjgnburmHDPlnqBZ4p5bpvG
 1u6gV3MzLfZO+f6i5Pg8hgyj5dkMG4ovIKMT4ohudAaleZ47mJeW/wy64Y8no6R6UV72
 JD5qnY4DE7R7M+AA4MF1MbES53kmey3BjueL4xjwVpxrHtqI9TQv7BktsqHMaSSTnlJE
 10ZlcvVxH5/TixO7mLXsrUOI/otLifKOIfKq7BU23tEbYM3RpC9XJ2xkuxJmf688EZ8o
 Os8ExBC9WlE6Vr19kFKm2BSXfv+Q/5/VQMSkvXjXLB/iqTu3brcjlJ3UAomJRDoLKQpo
 R3Bg==
X-Gm-Message-State: AOJu0YxFNMFhx9yFTdnJ1bjhq9dzUOdl6rSTca78YowQsXXPXMGBn2RK
 MesfjWVj/u0yaIbGBmZMACjQqHm1VJ3wqwaHWeUvbYamKWIcZdWVjZnpG/SmjfQtDv1T/Yx0n11
 5Xzs=
X-Google-Smtp-Source: AGHT+IEMmnDv4BUZGbU7og4g+/ABg9+GTnMHstlG0uMYodoFtLq+IFomXI78vHYJmj5ByezCGlR/uQ==
X-Received: by 2002:a5d:47ad:0:b0:374:c692:42e2 with SMTP id
 ffacd0b85a97d-37cf28a4902mr3077907f8f.9.1727798777355; 
 Tue, 01 Oct 2024 09:06:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574282esm12031460f8f.104.2024.10.01.09.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:06:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Oct 2024 18:06:12 +0200
Subject: [PATCH v2 2/2] dfu: sf: rely on DT for spi speed and mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-uboot-topic-dfu-sf-dt-v2-2-67f7acfa3ff5@linaro.org>
References: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
In-Reply-To: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+eSzwLgnncjjcshwxwRtGSp+PsCoVao/vE2s3X76g0M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/B32jXzvTu5UCvAcD6uavigc2qarJ8+X8YrSNbg2
 UWAkFpGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvwd9gAKCRB33NvayMhJ0XfHD/
 9pUVpJTzsom5T+KVQKJfRxIrEJxwwg0WfQ75h4oQ3hcWQyHceOo6JbHXN9hp8msRbATBLT+nJiLR2l
 q56Mb8qK29xpaBKhweC3aG+dLlu5l4HCk2YKGdqXTcieSEv9QwomPwbXrLMg2WgRB8almi1OSVXYRQ
 NVeoJiiVmXRefH5Arxn5GLsTdEURppqWF8cfyXaGF2uCCmYHCZrHdmhSXa97LCkKQItGz07pFt/NUb
 +aeRjBTg/hbtQuANI9mlqVAksPxmVXYHD4R88FbQYKNcgHvqEtzz0eztpx1zdoStU3rA2ZKUgC+UwU
 88Nlk19a206LU+Q4dZdFuR5WpTKgHctJnay37R//30VEoWhvGGzbB0fUxaO5H1b5WBTOQD5BHMhdOp
 Oy2p+81tEOu32MeiB1Z5JEkvYSbAjkukBdxa8QVH4RXVolCSEZJ6Z8/NjeGm54NE5KjYLm40mdBS6O
 Zk4EcQbHzrsamHUg8JvaJcmILmVyrg+VCNmKp32T6jVDWPrjROYiOj7OCs+0Il19RNasYoqqw5PhK3
 AbpOacu6P3Ql8pB2OifxMoCXGpTRCvsySlaAuCSUj330g+e/Z5bBUxSjelHaF/Rkq/Nbkw73CdygiY
 N9h2ktdNUnxsewII703gkiYuCOYEwcSdFNPdyvQpmtlBKiGTusPNCmScPeVA==
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

Align with cmd_sf, and try to rely on DT for spi speed and mode,
and still fallback on spi_flash_probe() if it fails.

With the current scheme, spi_flash_probe() will be called
with CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
with are set to 0 by default on DT platforms using DM_SPI_FLASH.

Like cmd_sf, keep the option to specify the speed and mode
from the dfu_alt_mode string, but rely on DT properties
if not specified.

Using CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
makes the SPIFC controller on Amlogic Meson G12B & SM1
hardware fail and is unable to recover until a system reboot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/dfu/dfu_sf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
index 7c1c0f9e2dc..8f7296adec6 100644
--- a/drivers/dfu/dfu_sf.c
+++ b/drivers/dfu/dfu_sf.c
@@ -123,6 +123,7 @@ static struct spi_flash *parse_dev(char *devstr)
 	unsigned int mode = CONFIG_SF_DEFAULT_MODE;
 	char *s, *endp;
 	struct spi_flash *dev;
+	bool use_dt = true;
 
 	s = strsep(&devstr, ":");
 	if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
@@ -143,6 +144,8 @@ static struct spi_flash *parse_dev(char *devstr)
 			printf("Invalid SPI speed %s\n", s);
 			return NULL;
 		}
+		if (IS_ENABLED(CONFIG_DM_SPI_FLASH))
+			use_dt = false;
 	}
 
 	s = strsep(&devstr, ":");
@@ -152,9 +155,20 @@ static struct spi_flash *parse_dev(char *devstr)
 			printf("Invalid SPI mode %s\n", s);
 			return NULL;
 		}
+		if (IS_ENABLED(CONFIG_DM_SPI_FLASH))
+			use_dt = false;
 	}
 
-	dev = spi_flash_probe(bus, cs, speed, mode);
+	if (IS_ENABLED(CONFIG_DM_SPI_FLASH) && use_dt) {
+		struct udevice *new;
+
+		if (!spi_flash_probe_bus_cs(bus, cs, &new))
+			dev = dev_get_uclass_priv(new);
+		else
+			dev = NULL;
+	} else {
+		dev = spi_flash_probe(bus, cs, speed, mode);
+	}
 	if (!dev) {
 		printf("Failed to create SPI flash at %u:%u:%u:%u\n",
 		       bus, cs, speed, mode);

-- 
2.34.1

