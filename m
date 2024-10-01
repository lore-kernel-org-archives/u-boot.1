Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD7CEACDF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 16:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAA689240;
	Tue,  1 Oct 2024 18:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCgQ9X6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AC08924A; Tue,  1 Oct 2024 18:06:20 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639AD8923F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53993c115cfso2964710e87.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727798777; x=1728403577; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zPT7IEaifr7cc3qzcBWzLfjVOjkO3GNKvWCF8gXypWc=;
 b=PCgQ9X6yzcXsmQuS3i9xm3Dr3HJ+7SW7z179EBtvKgkt2bDx90CyUxZwajb8f9MMK8
 NghIpBOVc1MyUF5RiqgartHP2VdCeitONo94Rgm6TWYcTB1T06AP374BmhatRGdWyuOS
 duzTo3alpF9l0tBJe95Mh6T7pkVMpoJpXQqoLFKCXrYe+Qd2JQ9rYexOFv3tJC2fzcbq
 KC49ZkpzcPyz+uzW1mL39QaJJH4/Mx4lqXGvzP75aTmrwWVVlNf9PS+EVWp5MASv9NUM
 eAiuorsVGAAtrKLDbrB6ZuESmmw0Bn3XTKeAuNZUIzEyQEEMlTHCdACN0vWdJGiA2aeh
 kLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798777; x=1728403577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPT7IEaifr7cc3qzcBWzLfjVOjkO3GNKvWCF8gXypWc=;
 b=NlD7cvqbsQSzr6/gkSq8okyJwaUrmoIWLFXy+mQvfDs0rDZOOU1rzNysYAh74OBol6
 ju7BrJukoEPLNFAqVkph/ZaUUCZPLgvYtPTPBkVgJHFHEjTB4aefmX0iQngoVd5xzMIX
 DtM9Brt6Urqf8VadXwfmJk3kwWXQ3xL88jDHbHlJJqyAOCl83/OvWd7eBce1XXjIIX/9
 md+NbK1YUjIjU2y6fOfcHmCuSZf8YrPZHnC4mFImEo4NPW3E5txaMDtW/YqWr1cNfq0C
 q5rJYQwjDfHqh1ntWVqys35iPmga7WYSGbC045pIMmmth5cjLrlYE2N9KSrpmbMuyjEn
 WgiQ==
X-Gm-Message-State: AOJu0YwhUn1x3rdFj2Zt7h+QRLlu9rdxqSUsd+IpYqxXK83G+pnWu1oH
 J81TQs53rFwFQ9tFJQrne/T/4+qmMrLo1bC7mlXaT7Wbi6Wb7++p/92rVu0y1zg=
X-Google-Smtp-Source: AGHT+IE2u6/rvrKD7Qmuf6pUWE9OXfv5nNV8UDlHP8zjKh/Iv98U07uapejlpr1eEoDdmy7xQdSp6Q==
X-Received: by 2002:a05:6512:3f12:b0:539:94cf:e32f with SMTP id
 2adb3069b0e04-53994cfe516mr4944588e87.43.1727798776577; 
 Tue, 01 Oct 2024 09:06:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574282esm12031460f8f.104.2024.10.01.09.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:06:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Oct 2024 18:06:11 +0200
Subject: [PATCH v2 1/2] spi: add DM_SPI_FLASH compatibility inline
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-uboot-topic-dfu-sf-dt-v2-1-67f7acfa3ff5@linaro.org>
References: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
In-Reply-To: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Eukxa3DiDu2LYKdr009Y7wkbd2+ubH4fPU5lobm+NEc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/B329/EPYY/ieTdTH9HhUwRxkUl8OxWRjdyOVEwN
 4gkp+fyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvwd9gAKCRB33NvayMhJ0fMeEA
 CJkTrjbNIfwpX8faPiwiGtGaXYQ8vzGJ9WG89LIvoO7FvoI2lKOqDANGk1m4KuoLOjy0tYml6b8D/I
 MVIvf+IxzqDwgLNEz8fqfQyGvWWtdiSvx2AFxQIgmO0i2U/Acd6hXCkAUeaSg/b03/nAys0OOSmB19
 9PwS2ZDVJrfWNaxsTvsM0TSqzWk66fcLArBUmBPULvcqZi9MY74mL5pPhJhyQB6YHEMnA9ZPa/MImT
 tdftOSS4+in1kdQvFpU5wB1Y4glDj7wJMV9LMzX87bzTdC9/vXVT4SX+OXN4eNxsqnbG9WFn2Y30jz
 z5ytjamMSeba5N5EqOauilaer2qu93IERfbIqREr0Jcjy7cZC+TgTJyynOMSzGeYgDjcTrDjnsJpX6
 0/Vj5mezjzfHdTNR9jx8D+EOr0x7tH8DZ3ZdwGBT4ei6ukk5x60HrtXvU9WRFlPJ3oZa2run/Op1xp
 g8mY5lWUtWttyCBYHGWkqVHQAU2gXMXYmijgjxtWkalcA+WRFbg4SS9UXneq3PzbH0S2cAo7PZSMpl
 37e3bM7ZBGRDK7sb1NM5zqD31liLhJIZNQSUIbiBw4izvzXASvrNNfAyw5SNesrllXn9yBzXnlFr9r
 QvCNpkUmosfHd/Pk6h73LDxsaQYT6CIsf0MwvgGlu9/dU9BWEMAwgpI6VoBA==
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

To smoothly handle the transition from the legacy SPI FLASH
API to the the driver model API, add the DM functions
as dummy inline functions.

Today, client code uses #if/#else conditionals, but it's better
to use if(IS_ENABLED()) to make sure all code builds fine
and avoid configuration hell, leaving the compiler remove
the dead code.

An example is cmd/sf, which could make use of those dummy
functions to drop the conditional compilation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/spi_flash.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/spi_flash.h b/include/spi_flash.h
index 10d19fd4b11..2e703e85250 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -139,6 +139,40 @@ int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
 void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
 
 #else
+/* Compatibility functions for when DM_SPI_FLASH is disabled */
+static inline int spi_flash_probe_bus_cs(unsigned int busnum, unsigned int cs,
+					 struct udevice **devp)
+{
+	return -ENODEV;
+}
+
+static inline int spi_flash_read_dm(struct udevice *dev, u32 offset, size_t len,
+				    void *buf)
+{
+	return -ENODEV;
+}
+
+static inline int spi_flash_write_dm(struct udevice *dev, u32 offset, size_t len,
+				     const void *buf)
+{
+	return -ENODEV;
+}
+
+static inline int spi_flash_erase_dm(struct udevice *dev, u32 offset, size_t len)
+{
+	return -ENODEV;
+}
+
+static inline int spl_flash_get_sw_write_prot(struct udevice *dev)
+{
+	return -ENODEV;
+}
+
+static inline int spi_flash_std_probe(struct udevice *dev)
+{
+	return -ENODEV;
+}
+
 struct spi_flash *spi_flash_probe(unsigned int bus, unsigned int cs,
 		unsigned int max_hz, unsigned int spi_mode);
 

-- 
2.34.1

