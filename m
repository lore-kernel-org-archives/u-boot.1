Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C08AC47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FD887940;
	Tue,  2 Jan 2024 16:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7I9jDDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9B3878F1; Tue,  2 Jan 2024 16:47:10 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C32087913
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5953a6a00ddso1448217eaf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210425; x=1704815225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i87RhnjO8GZSHdEP0gaGe/4YhkfPRWoWKMbSvztmvCg=;
 b=h7I9jDDGM5j6GL2t3APpJCTerfUguSAvhUeS0omKnwwZ2g/qGxYZgU3zZDwyL1yxp1
 T0eDwlP3cldSk95vddx4UHLVDSbNoH6dLm14H7SCp7P0zu2les3AVAyLwteZHuYtIgOe
 IDHP+USdGt5Kgc39Wol5huFPWaNv725FMuYaUZjKwbj/yCRA1irHCKPPtGDtydh8ZV8D
 rEB4zN+YmKKoNgawOvH9mxPu+IAp+eJk6K3p461aSYZDoRkLpMKOLJ0TSUHMnTGwNFwY
 0khOAHqo/pyTX4RMVl2Yyaj4wMih+OqgokIUvci7VYciYf/+SHQQ45JA1508Rulq7dNr
 Cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210425; x=1704815225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i87RhnjO8GZSHdEP0gaGe/4YhkfPRWoWKMbSvztmvCg=;
 b=u8p19X+G8fQFp/yWLireQoWlvgkhwpGOKsg/ywvyxgQzr0MX48JZoL1Kk5P3xm9GH+
 N/eurPjiQO6ysu6oPuQgEUXLfRRNGBD1sXTf2ET27hW00X4oCT7YX7K0wPeg0ziY7U8+
 5b5OSEKBZXCKNUSVCdjV/e9BPedGubprJ+IBHxfbiqPl8x2Bug5ogGa7wtOYHxdq5e5z
 iwe+5CpktcnxicuJl9CHvAFl5+VWnBz0kiv+TDXGCrllvwWGLwgbFAk2yNIdaYuPShz0
 OPgiBrjAtQAbQnJlf0vKDHxDgCE3y8IoOb4vaoS2pmx6FKMzRiJRnZtuIZxKTSdP+4nz
 ug0g==
X-Gm-Message-State: AOJu0YzRVVmhdWbiuRPBzhgGQ1Gfh+bTlYjUyJMeUHn/8/MzvdwfifrK
 aIcWCfKXN7a20T0EQVI1imJTEqqo4o2ECA==
X-Google-Smtp-Source: AGHT+IHr3XTHoX3FgU5hlrkw7eG2z8sf95KNQp+NifjPj1Pg9FUp7SV3mO5zYbWfP7LDTTUuyNzdGw==
X-Received: by 2002:a4a:5590:0:b0:591:c8d7:aa80 with SMTP id
 e138-20020a4a5590000000b00591c8d7aa80mr10146880oob.14.1704210425723; 
 Tue, 02 Jan 2024 07:47:05 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:05 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 5/7] rockchip: board: Add board_rng_seed() for all Rockchip
 devices
Date: Tue,  2 Jan 2024 09:46:52 -0600
Message-Id: <20240102154654.191055-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Allow all rockchip devices to use the hardware RNG to seed Linux
RNG.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/board.c             | 32 ++++++++++++++++++++++
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 29 --------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0..77145524ea 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -348,3 +348,35 @@ __weak int misc_init_r(void)
 	return ret;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_BOARD_RNG_SEED) && IS_ENABLED(CONFIG_RNG_ROCKCHIP)
+#include <rng.h>
+
+/* Use hardware rng to seed Linux random. */
+__weak int board_rng_seed(struct abuf *buf)
+{
+	struct udevice *dev;
+	size_t len = 0x8;
+	u64 *data;
+
+	data = malloc(len);
+	if (!data) {
+		printf("Out of memory\n");
+		return -ENOMEM;
+	}
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		printf("No RNG device\n");
+		return -ENODEV;
+	}
+
+	if (dm_rng_read(dev, data, len)) {
+		printf("Reading RNG failed\n");
+		return -EIO;
+	}
+
+	abuf_init_set(buf, data, len);
+
+	return 0;
+}
+#endif
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 45854709f5..7bef5a53f0 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -17,7 +17,6 @@
 #include <mmc.h>
 #include <panel.h>
 #include <pwm.h>
-#include <rng.h>
 #include <stdlib.h>
 #include <video_bridge.h>
 
@@ -137,34 +136,6 @@ void spl_board_init(void)
 	       (GPIO0_BASE + GPIO_SWPORT_DR_H));
 }
 
-/* Use hardware rng to seed Linux random. */
-int board_rng_seed(struct abuf *buf)
-{
-	struct udevice *dev;
-	size_t len = 0x8;
-	u64 *data;
-
-	data = malloc(len);
-	if (!data) {
-		printf("Out of memory\n");
-		return -ENOMEM;
-	}
-
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return -ENODEV;
-	}
-
-	if (dm_rng_read(dev, data, len)) {
-		printf("Reading RNG failed\n");
-		return -EIO;
-	}
-
-	abuf_init_set(buf, data, len);
-
-	return 0;
-}
-
 /*
  * Buzz the buzzer so the user knows something is going on. Make it
  * optional in case PWM is disabled.
-- 
2.34.1

