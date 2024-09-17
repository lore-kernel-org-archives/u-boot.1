Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F295C36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD45488D7E;
	Tue, 17 Sep 2024 14:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VkjgtmW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659D088969; Tue, 17 Sep 2024 14:24:32 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4EA88D7E
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374c8cef906so4310155f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726575869; x=1727180669; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gsQ/2H1cy9taZaNtFmHfNGG0B7Z4CEGTURzo9o7PWLQ=;
 b=VkjgtmW/yt9GttjJY04QTMtflYoS0cGJB0vY0UHy3qKvm2fUzod6d7TtFdYi5DH64A
 1bYg0Ub45EZJaRBpbVZ41lr/68E6lLQ5OIyTxAp8ihVI3kOHbqiU2kpPityxjm0Hrhw8
 V0/pIsF3x4PQCULAlFQyXQ2gEh+qVbxEV4g6o6DY1zKypFPA93DGgrqm0BTU6+qSCTuL
 iWBXeVeDOvNrLmWcT4lh1kSVzFhxB3UJ8yjR33VbUWxSvY2VU6MJd4xSxf88S4yTzEHN
 LcsfpIcRQQQvhHccNqPLhvyB6ykIbqN04MGo6qK132acAIsVzNhrep+f2flIJvem8reW
 GUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575869; x=1727180669;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsQ/2H1cy9taZaNtFmHfNGG0B7Z4CEGTURzo9o7PWLQ=;
 b=SoYhEAIhR+0mVU6F7U4qmcM6ZL1OFGUFFebvFhfUJvbiMiWgzReAD2/afU1TVDyin7
 XcIFUHPBMJ5wnEI6s2YfgaXPYUB87D4r82RklXhYeUhSlhdM41pXg6kGPT3SCT6wKvzA
 ydxTUrjZ2/eOoWqT+7owDDSWDeLwCdIxA+H5pHQheiAdJTGYlc9QxHY/f6+QlQ+LhjMG
 Sy2baxEo3a7laPnp8NTCt4ScqlL8ekz5kdzfBowelFH1cM22oKY27p0PmHdR7NV4CVVi
 +fvXJ0SFvYqD28HmItIKLJOEs5vLg2CBmE4WQSFrM3fVHRDjigsMNgetVv9ZSgRajTuq
 1i8w==
X-Gm-Message-State: AOJu0YymFIO7ereYCQjqA9hTk8nLp5q16kwq2YJQ+Dm3+tVlGYbLLJCn
 rPe3MrespxgrcCAdrekE6gljr/rtNA+zWHIi2/yAeK1d9RR4X6vXWN7BhJBCodY=
X-Google-Smtp-Source: AGHT+IFfNCR7ZLG6qws6nSfa17HSi/WdqrMBwtF7p2rh/z5NDThC7iQRu6u6lIdMIOwhu8QQ1TkfaA==
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id
 ffacd0b85a97d-378c2d119f7mr12367915f8f.30.1726575868495; 
 Tue, 17 Sep 2024 05:24:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f97d6sm9387689f8f.52.2024.09.17.05.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:24:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Sep 2024 14:24:26 +0200
Subject: [PATCH] dfu: sf: rely on DT for spi speed and mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPl06WYC/x3MQQqAIBBA0avErBtQqayuEi1Mx5pNhloE0d2Tl
 m/x/wOJIlOCsXog0sWJw14g6wrsZvaVkF0xKKEaMUiN5xJCxhwOtuj8icmjy9gb6hS1Vjs9QGm
 PSJ7v/zvN7/sBQ3inWGcAAAA=
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JJ58Kos7wIaKpW7pq3GF0rzhXAnIj/OfdqdqbFuy9f8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XT709SgQxLgC+ieRkw8LB6+/fLl4WHD+G6m1KG4
 CyyeW6yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul0+wAKCRB33NvayMhJ0bCZEA
 CkgQMZmT8S8nR4hEgotEjA9qoHheMamUvBbL21lqA4rwgFTtr8wVJf41KRWCi2rjU3KKDBf01PlV6M
 RMJX/Zw2enBUcLGnRBS4uSKIzzmwZW1NNmQdJCPxwToAzBU92nuW2g3tGLnNG7kc+Pk+yVl4TolyyV
 A0yWRkmE3wswV/TMtGCY4neJmPfRYFR5MQ447dBpmXGWDXRhDwy4F4HTaEeDll8DpS2vdMsk2UgW+M
 GsJgfuyiQ3wrzKvZJAXTSJr1upbYpTBzmuQThS8ntibWM4Cjp7Gc3NiGIMBRE+7xfzsIBj9AhDZFOk
 TTs/NpPlbrinySu4IWS4dCS3orLijjZTXQpGSrBgO78ddcPbbvaIwjOKA/YI3ACTkqeKw22NsINYOc
 4RyZPY4sRN/fISU3k+xgliEPVhrt3dirFq5/Z+2ihL6/Gc/3uVDSjS5ZpO8qd775fR6ctpQRJU8Amy
 qPxBQjgttoRcuzJravrpd0kAtA/3s16hS76dTZJCrDvZDRzrSLqzRPeIrzvEgQdmOkt1+1GnB0S7el
 WtC0BtcOlKbwvI4uRBTC2iWS39FwnjGc6XA/oNvml+B2jnSce4KqqNJvzd7gRTBnYt0UXkXGPovvaH
 zQi3g5afs2oTJ4W1wtYnK3CBktp5PApRHsAhW5ZaOa9HYpr/Ssr6bwLcnrYw==
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
 drivers/dfu/dfu_sf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
index 7c1c0f9e2dc..b5d875be5ea 100644
--- a/drivers/dfu/dfu_sf.c
+++ b/drivers/dfu/dfu_sf.c
@@ -123,6 +123,9 @@ static struct spi_flash *parse_dev(char *devstr)
 	unsigned int mode = CONFIG_SF_DEFAULT_MODE;
 	char *s, *endp;
 	struct spi_flash *dev;
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+	bool use_dt = true;
+#endif
 
 	s = strsep(&devstr, ":");
 	if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
@@ -143,6 +146,9 @@ static struct spi_flash *parse_dev(char *devstr)
 			printf("Invalid SPI speed %s\n", s);
 			return NULL;
 		}
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+		use_dt = false;
+#endif
 	}
 
 	s = strsep(&devstr, ":");
@@ -152,9 +158,25 @@ static struct spi_flash *parse_dev(char *devstr)
 			printf("Invalid SPI mode %s\n", s);
 			return NULL;
 		}
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+		use_dt = false;
+#endif
 	}
 
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+	if (use_dt) {
+		struct udevice *new;
+
+		if (!spi_flash_probe_bus_cs(bus, cs, &new))
+			dev = dev_get_uclass_priv(new);
+		else
+			dev = NULL;
+	} else {
+		dev = spi_flash_probe(bus, cs, speed, mode);
+	}
+#else
 	dev = spi_flash_probe(bus, cs, speed, mode);
+#endif
 	if (!dev) {
 		printf("Failed to create SPI flash at %u:%u:%u:%u\n",
 		       bus, cs, speed, mode);

---
base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

