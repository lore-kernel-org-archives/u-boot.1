Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB32E7C6F6
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5818A83B9D;
	Sun,  1 Feb 2026 01:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z74r5nm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A28383BDD; Sun,  1 Feb 2026 01:45:22 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C3D83AAD
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6498401cfb4so3262794d50.2
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906719; x=1770511519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6IjPS3OTdGN7rY6I/0simcZKTaHUxVdeEaoebTw9zo=;
 b=Z74r5nm/RsEOK5iQBP9wRHdGxoGgTJ0FyrjHBWnq6cxgR6iHzAzIkvLq7uCBdqxfcW
 oq4wi0EnuOKnCUN5OB2cO9ZS4yry3C3tYTiVUf1sRCI4naainuyd01dII+z50vTb4l4m
 CijUMmP+/gFO4zIAxq1CHIw9vFH1lxxpkLzMRo1lYCADmT2Zik0BU5b1xv6/ipcT13Ik
 nygQZB9wOtBJcqTlqgayi6WU/TwRDctHXFcM9CnAshc8iTkEtQEgHVtMGXeppztMSXAb
 tosSvAimiExMWGi6xcQq++XzaTV512vpttJwzNheCGubd3EWDY5k7aKIDvf7GJcwKaxd
 OSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906719; x=1770511519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6IjPS3OTdGN7rY6I/0simcZKTaHUxVdeEaoebTw9zo=;
 b=JOCtyYYqWeRFDf5TANtU8UyRzJ3y02Uy7AkIRDYYrAMYrj376KV+X+9VrJP58lYdSb
 8CLUxahxXQ5Jhj1zRe/Z8kfIY95qGgVbubtmnfMz55hjYL1bSuYbkpBAXHLduSaP0PdH
 ZZcRYvC1/K+S5HQho4GEH4aKdRwJQxU15L1AnigJMj+J4OPXIPGCSmrxJO/owSXYOle/
 WnyEnAp1AHOQaY4eVNf/quLU3KPAzRzancWRPyyHrrynfUoHOm1Cx3C3mucS6g2yn4gV
 zDR3I4yV2GHEG3Zb0q/t2zjwJzAtniKM6xzlnOAEXLElAF6N0PsPEJabYlvgBvxz51qz
 S+ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCURIlSchS7BvWm/nWTYxJFrV0XZF8blFNe7dt0UNn8Nygba2QKOchRkGrXY9cBpD+R3WfQtqwc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZmjJ6pgwzyqic3jse0HFTi8krSZtF5KZKsM9xtraBIsI1kXl7
 gHipETMv0PRMXMrA52rOjQ3/FbR4urad0vIOGXvqnFYQJr1tRxQN0FKkN+BFBw==
X-Gm-Gg: AZuq6aK3wHbxyHx82rrGqzQdDiFEYuQNRCAy8wFs5IZ8Onp717YMcy3zC928Pa+8XHf
 Jty2uU8z/PvXxh2+wiKy9oGFTWZsvTqoW1hjOpvpm6kjeIohRWrxVUSI8azFZ3gkwaXI6icJIdv
 95FRruiUpVojveCexHGEEOpCiU1AWFoD6lBay8aLe6OpfnZvbdrnw6eAMjJHEGKFAMGxK9deWcN
 6rz4mtYSSGtrQRzJb9k2/81LsQgEcR7g0N6yQHk1zJZ1GPB/cSWwfU4vwRhkqhKjFHzGLlVaUTa
 AFhoRAXshppCgscylZ85diRRp2ECI2JT5IRKSFoug4PrGseZ3xZoRz5AFP0w5HEzRoMI116Fmgf
 VSYL0UkjvBZ6YpIyfgTCXbr4CBVUxdx6d4yy/U0c2LjDOwgvAnd1iFftJd1t9me8JKzinmd9xcF
 K9+NrullR7E+ojXA7rkpwwICY9A1n1m3/FhxI=
X-Received: by 2002:a05:690c:e3ed:b0:794:458:6d9b with SMTP id
 00721157ae682-7949df3a129mr145938567b3.29.1769906718951; 
 Sat, 31 Jan 2026 16:45:18 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:18 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 4/7] rockchip: spl-boot-order: Add SPI NAND support
Date: Sat, 31 Jan 2026 21:44:53 -0300
Message-Id: <20260201004456.763107-5-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

Make spl-boot-order to accept booting from SPI NAND as well.

With this change, it is possible to specify spi_nand as the boot medium
like this:

u-boot,spl-boot-order = &spi_nand;

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 6572dde29f65..e5897536934a 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <mmc.h>
@@ -75,6 +76,8 @@ static int spl_node_to_boot_device(int node)
 	 */
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
+	if (fdt_node_check_compatible(gd->fdt_blob, node, "spi-nand") == 0)
+		return BOOT_DEVICE_SPI;
 
 	return -1;
 }
@@ -221,8 +224,12 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 
 			ret = uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &dev);
 			if (ret) {
-				debug("%s: could not find udevice for %s\n", __func__, conf);
-				continue;
+				ret = uclass_find_device_by_of_offset(UCLASS_MTD, node, &dev);
+				if (ret || !device_is_compatible(dev, "spi-nand")) {
+					debug("%s: could not find udevice for %s\n",
+					      __func__, conf);
+					continue;
+				}
 			}
 
 			return ofnode_get_path(dev_ofnode(dev), buf, buflen);
-- 
2.34.1

