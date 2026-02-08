Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA99EF06EC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B583783C39;
	Sun,  8 Feb 2026 22:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adB2Jlpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB92D83642; Sun,  8 Feb 2026 22:26:50 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A4683C72
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-794719afcd4so37767407b3.1
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770586007; x=1771190807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ya93lKbsIxieelUQDrnwsSCtIM9ozIqJ3AD1Zsj5PpY=;
 b=adB2Jlpflz78qnPE2AA0sa/J2gNOAku6TlJJgDPv8iHoiXciaX9lbxoezWttfXGg0i
 S0btmM0gNgf00vdpfLiAdu+OSKBJbc3NWOIgSLvfIiNAE2W7R14lu1RFSB8yCTMN+FQS
 jxmqkOtifbGLuwjCmFxaR7031gnQapDNL27f+TosJWKLIFEOg8MtZ9D0q3ztBRyqQxpy
 51JFwyvDWxOYgaj4WzuLmY+4wrazilrUtyjy6D+yfeDGGc9hYn1nEAeogMlLzCnbsyVE
 T67MTs5Vdw8NQL8y+vlU0YeqpEZ8Y8Wu15hOzw38XV7QNtt98egMk2RuYIysSDBbpVO3
 9XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770586007; x=1771190807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ya93lKbsIxieelUQDrnwsSCtIM9ozIqJ3AD1Zsj5PpY=;
 b=v7Xz2/e16PlwhfBYvcZReqjUQx6e61UDFAE/KSnZI4k+Ga/XGG4Voiro76k1moCDv7
 1EAjScPnOkpFBSIw8YB2NAm1N7u4Jbhn5gXinaxVyrTM2HdA4u8+k5h1XhFPjsFnLqzR
 mICyY26CPepvS662fmB+8ynAOOJu+vMyyGkk+2wVcJ8a5uM1KwEb88omtYxK2dZqaK9f
 uWZV3cVVcl2jInNRi3mG9sA2HCeOFb0oG1WoGA6RzjDweDdcRhFwLdkqrJ10yPi9QVH9
 uMEgKI2100kLuqd0o8R1iARTdYI1PH1A18Rl/2HwADBC8k2NkpddS5YRMq9SPVLWnhlb
 eyaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVja4BNO7gSOeLCvCPNoUpw5NzKovJU0ezHFDI63/VRwJ3lbxx9tehFwHjMY7gAeIY0d+d8HqQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8UMwbB6XuEOz0y3134KvtCig1se4QeZZPBvV4SLFJx8sXEpi+
 9ZFmNbd+D5cc2E18C70wIY3JeNmmqMKXnH/NeuaUpY2Izxn3weYCTcJ9
X-Gm-Gg: AZuq6aJhNpGgt7eIIcrt/u0B+vnKyywL8GZxG4rVhSUiyTdPSClB3bC+IRV4Fbspmpy
 Gqw7oLxviB32hY8MPEYXKsGWvg1zj0+efGbh9KEtCkz4kVvLgi/zVN9jIOA7GuvdSbZ794tqJZq
 W6QNPDAn8lKE2U+D+5H447kHN9PpHAEL9y/l2eEDde7QKismOELVAFdhPWU/2/OhHMt7p2Aj3p5
 TOnj+/GRd2zbzDOz7HHPoHJdWNpaEIaxOjQsohwgW8Z5ckVodWth/rOoVI1w0m8Slr//SXSiTqC
 RTwEh63ulqlT+Dr/tX/utMaFrwGBMz4iyuHu2+ow1jo7LXr0TgDZ7HTMgcXeaHyE3PWhOghnMt5
 7fzavyoCcQeJamvhRnSGi+bAl/ArAIwpyExE+3KA1u9dvRipIN+wSA5y6eKyRFQYt5aYcDQB/Mm
 cHFDKYDISYtCRNPSc3XsNuNQkW
X-Received: by 2002:a05:690c:39c:b0:794:215:d575 with SMTP id
 00721157ae682-7952ab5a3c6mr88216257b3.56.1770586007498; 
 Sun, 08 Feb 2026 13:26:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:47 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 5/7] rockchip: spl-boot-order: Add SPI NAND support
Date: Sun,  8 Feb 2026 18:26:22 -0300
Message-Id: <20260208212624.3413494-6-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

Make spl-boot-order to accept boot from SPI NAND as well.

With this change, it is possible to specify spi_nand
as the boot medium like this:

u-boot,spl-boot-order = &spi_nand;

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

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

