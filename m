Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4628EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769C384AA5;
	Tue,  7 Jul 2026 17:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gw9h9feT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691BA84AD7; Tue,  7 Jul 2026 17:32:42 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51297849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4896ae35be9so1428914b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438359; x=1784043159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ktWClV7yz7pWlnmRXoPAAfaQeLwr4B2/0bxHS71FDnc=;
 b=Gw9h9feTc0UbovX5+BIxgvlKyeB6HGsZ9Ti/SQwhUwbLg+u3TnQ3yjJEc04FN3ZKun
 wkpWSMEhknuYtKMpiAuEB1TA4mzmcpPmH4/m/q+rWPwX8oarx922am1l5KEeNkHZI50J
 Wly2xQpZ/D1xjwN7J1WYBnl/UAqdJfyhV6XTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438359; x=1784043159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ktWClV7yz7pWlnmRXoPAAfaQeLwr4B2/0bxHS71FDnc=;
 b=RnA1KBJxq6nkA+S3JBd9YRb5yJg+HZ6vELxzjD9dZPQUWeZyyDn4PQySDCKxdVfa81
 Qp6J+bqsderQIpfY99HCqm7PAY9KrKbfNZfwKe/K1SdpbzTeoTqO+GLKxHH5JI8eXJ/I
 mkZkJ+54C58/0EM7nR5eNFRW3+stTUBVn22xH67lbT4ns3YbSc7WYyJPVM+KCgZ0WFnw
 Yz/XRsanjjEPeuxURsiTH3jgD71zksymXbfoANdcN3oopL4kStDY0OSqUXa6/sWE9SWN
 s7r2axKK/t9jK/b7m3x+qj+rAh+PXagy7vf1VAfdYqSZKIiRvbglBLFMC9wFOxnkk8hH
 q4qA==
X-Gm-Message-State: AOJu0Yz3hhyx4Fxbjkz+byWlDjfriZQLFlJSFY64BVAd9nVYPmaIvU2L
 g1YLS/LMEZ5yj0E3/ktGscdHanYJW2lBYiHkozaXG9oLNCbHiwZgYghC2y6SaewnGifZPjiTP77
 E9FeICw==
X-Gm-Gg: AfdE7clNBzmbunw+Zcs/svowPUPmG4z8zzG/gE3n+ZMQ/qKbY8RCqTGbwh7VYiRd2Oi
 DfXZx2F+4EK72nyt+qEsJcLLU5iQ8DXrydSyBdVKljCn/AdP0d3zC/cMeOOWAXDlCqvZLnFKT+V
 ykCFaJptRiCRXekxSiCVg1ALzvg7h44w+rE3Ac9RJd6T1NXpCWuMHqWGL11vsPHJ3aU12deMDNS
 wBL92QPcrw5dQ2B2bso1OsQuRX4RUXzlDjSnMG6bkzz2vs3hVKcmx2EkuKaPoY3Zpzl7CvX5zR+
 DfSkgiEo5wwfuvSx/rYTJWw3863XGkDwLJYfk/fYeF0gwAAanb7FH7mefGH/yTpqm98fu2M7pob
 qHro1lSyEQzlehPzVmTTbafHd22pYfAuAM6xzt7lEr9UtabbYGembdJiZ5G0h/vGwUQDpe6P6/S
 4OgLYFWz8=
X-Received: by 2002:a05:6808:5247:b0:494:9c17:c336 with SMTP id
 5614622812f47-49fde6ee713mr3822448b6e.34.1783438358950; 
 Tue, 07 Jul 2026 08:32:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@flipper.net>,
 Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 05/15] rockchip: spl-boot-order: Add SPI NAND support
Date: Tue,  7 Jul 2026 09:31:03 -0600
Message-ID: <20260707153135.2048115-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

From: Fabio Estevam <festevam@nabladev.com>

Make spl-boot-order accept booting from SPI NAND as well.

With this change, it is possible to specify spi_nand as the boot medium
like this:

u-boot,spl-boot-order = &spi_nand;

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Guard the spi-nand checks with SPI_NAND_LOAD so that boards without
  SPI NAND support do not grow in size

 arch/arm/mach-rockchip/spl-boot-order.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index d2dd5e10935..3942dfe6f5c 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <mmc.h>
@@ -75,6 +76,9 @@ static int spl_node_to_boot_device(int node)
 	 */
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
+	if (CONFIG_IS_ENABLED(SPI_NAND_LOAD) &&
+	    !fdt_node_check_compatible(gd->fdt_blob, node, "spi-nand"))
+		return BOOT_DEVICE_SPI;
 
 	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
 		return BOOT_DEVICE_UFS;
@@ -223,8 +227,14 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 			}
 
 			ret = uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &dev);
+			if (ret && CONFIG_IS_ENABLED(SPI_NAND_LOAD)) {
+				ret = uclass_find_device_by_of_offset(UCLASS_MTD, node, &dev);
+				if (!ret && !device_is_compatible(dev, "spi-nand"))
+					ret = -ENODEV;
+			}
 			if (ret) {
-				debug("%s: could not find udevice for %s\n", __func__, conf);
+				debug("%s: could not find udevice for %s\n",
+				      __func__, conf);
 				continue;
 			}
 
-- 
2.43.0

