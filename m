Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E8CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F16848BA;
	Fri, 12 Jun 2026 22:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q0jolh8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62560848B0; Fri, 12 Jun 2026 22:19:18 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489698063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-5176465a4a4so17451461cf.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295555; x=1781900355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rmha3S6E+7hvzSl2/HWE+vhMutvcKlZkIQ3V/y+YlrE=;
 b=q0jolh8xljMs9+PDj2xsuTv2P5nBxpQzxw/+eJzP6jXYT6XeQ8OWEJmCMUJVavVKK5
 nfGXoZDeaWp+Em23yvKHGjMaeMNvgJcg7fTmCwfU42fCiLsq7u2UfZEQgxbQWVeUFLko
 13sdJkXmItEqH2KP2wHPmCz6ogfbPtg65hWZMyngdTzM+JC38syCiV3MC9Kx/JklsE3l
 3/0FQrXcRJQOT+MEYylWUQ9MHMumgqzMzNPcvwG0LgFLOmCeWmdKUgF54WnwCI1L5B+H
 FGmRBElpdVccNJeoY9+u8BPvX6ZfDdIyNCFVUOuWUhUgJ+N7D9660rob8iyqTXkD1tTX
 HskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295555; x=1781900355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rmha3S6E+7hvzSl2/HWE+vhMutvcKlZkIQ3V/y+YlrE=;
 b=YVS/KerpHy4vZ0MruFDOUiZ6qevTn0fESGtF5IrJul0pcOuHzneHYcwA9X8wlPxouP
 iImROdB3YeeAcRFAR563gnX4qt25+9W9TkFvtXMDF86LLE801gBzJtBeIGNHcGM60LXR
 B5QpHbtO+2A94vc1AdSI0eHINaISCZu5YHHpKxw3HAxdqUVQwwItJV0t2J3CKCbBQrtV
 k473a3xRNPWgW0KeB684wr/bt2Ae6vT94JOa2Y97Q5vbAf2sPgvkPrcBr+I3sNHYUzKN
 nCHe8qt/U5R2LGBTk/JAIWXxWGfv9v3n/RfuAvNjE1f1wM2tFeBMLCqeR6TyjjoAtuLd
 +9JA==
X-Gm-Message-State: AOJu0YyHWfHzO33mSNLjiNRayE8uaXqph+R0vFh9Wf3Gqz9FVuSmZDk1
 qnicH0EXUDfGhh/njF933bKquCOcax7mJ+LK3+M8xAru77Gedo1ZaVvhWnmEtiGl
X-Gm-Gg: Acq92OG2i5bsF6bjbP9tP9WdufCN5TRjz3WALB1ivhJf9gTvwXagcIp4LO5l1ZTwORp
 f9V+g9YHynZ8JgBEAKIgW+BVJd4SiNUIs6W872UQ397cZTbovjW7bCQZs5kfM02Q1x3Mcg/zgLe
 Ouu+7iEgwmcArlQBwd/3G1daRstOcHhmrlc98xKPxFB4cbX+HlSqQLTVgN0JEZ6Cjn9kTowRmqY
 U+Nur4fZYZkI0ohfxLp3ISr3eZ8302XKxB8wgoNlAEO5vkxfUnjWWaFvPJiLx5+p+9j6bibxA02
 2WlmiyjO8SBAV/3z/fqYGqAOTrY2OnULYVURWRSHDF3gupM7qvMKO+zczF3xBi6XR4EQNcprECp
 qZ6vWFGttI4UmG9HIVmqL0C31PyBkhuV8ZYCi6FcD51XplZWUQKEiSeHOzC3Zx5HFvbDfJ47wkz
 eIu/bnmtXaV1wdGvQrTutMOQDufeaZzIT4FwSsiWlNqdfmROuuRVgweMoN6UdNq/xsUVqBUE/Mq
 GRlA1wglGbhs9Yk+x8=
X-Received: by 2002:a05:622a:647:b0:516:ddfa:23a4 with SMTP id
 d75a77b69052e-5195354db49mr19848001cf.41.1781295554983; 
 Fri, 12 Jun 2026 13:19:14 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:14 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 1/8] spacemit: k1: select boot device via config registers
Date: Fri, 12 Jun 2026 16:18:54 -0400
Message-Id: <20260612201901.73657-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612201901.73657-1-raymondmaoca@gmail.com>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/spl.c | 77 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0db362130e4..d5e87d79fa2 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -21,6 +21,17 @@
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
 
+/* boot mode configs */
+#define BOOT_DEV_FLAG_REG	0xd4282d10
+#define BOOT_PIN_SEL_REG	0xd4282c20
+
+#define BOOT_STRAP_MODE_OFFSET	9
+#define BOOT_STRAP_MODE_MASK	3
+#define BOOT_STRAP_MODE_EMMC	0
+#define BOOT_STRAP_MODE_SPI	1
+#define BOOT_STRAP_MODE_NAND	2
+#define BOOT_STRAP_MODE_SD	3
+
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -45,6 +56,17 @@ typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
 			       puts_func_t puts);
 
+enum board_boot_mode {
+	BOOT_MODE_NONE = 0,
+	BOOT_MODE_USB = 0x55a,
+	BOOT_MODE_EMMC,
+	BOOT_MODE_NAND,
+	BOOT_MODE_SPI,
+	BOOT_MODE_SD,
+	BOOT_MODE_SHELL = 0x55f,
+	BOOT_MODE_BOOTSTRAP,
+};
+
 struct ddr_cfg {
 	u32     data_rate;
 	u32     cs_num;
@@ -379,7 +401,60 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	u32 mode, sel, ret = 0;
+
+	mode = readl(boot_dev);
+	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
+		sel = readl(boot_strap);
+		sel >>= BOOT_STRAP_MODE_OFFSET;
+		sel &= BOOT_STRAP_MODE_MASK;
+		switch (sel) {
+		case BOOT_STRAP_MODE_EMMC:
+			mode = BOOT_MODE_EMMC;
+			break;
+		case BOOT_STRAP_MODE_NAND:
+			mode = BOOT_MODE_NAND;
+			break;
+		case BOOT_STRAP_MODE_SPI:
+			mode = BOOT_MODE_SPI;
+			break;
+		case BOOT_STRAP_MODE_SD:
+		default:
+			mode = BOOT_MODE_SD;
+			break;
+		}
+	}
+	/* TODO:
+	 *   The current upstream DTS file only contains the eMMC node. When
+	 *   the SD node is added via an overlay, the eMMC device ends up as
+	 *   MMC1 in SPL.
+	 *   However, the SD device should be the first device (MMC1).
+	 *   This sequence needs to be corrected once the SD node is merged
+	 *   into the upstream U-Boot DTS file.
+	 */
+	switch (mode) {
+	case BOOT_MODE_EMMC:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_MODE_NAND:
+		ret = BOOT_DEVICE_NAND;
+		break;
+	case BOOT_MODE_SPI:
+		ret = BOOT_DEVICE_SPI;
+		break;
+	case BOOT_MODE_USB:
+		ret = BOOT_DEVICE_USB;
+		break;
+	case BOOT_MODE_SD:
+		ret = BOOT_DEVICE_MMC2;
+		break;
+	default:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	}
+	return ret;
 }
 
 void spl_board_init(void)
-- 
2.25.1

