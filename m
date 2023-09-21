Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F1BE7D0A1
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 23:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349EB86400;
	Fri, 22 Sep 2023 01:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YEu7tiN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325E486482; Fri, 22 Sep 2023 01:32:57 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0667B86400
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 01:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d81afd5273eso1877100276.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695339172; x=1695943972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s9IFf8JL0qToTR4vZ6DOEyA3pL6r/lGAPnsJy3i9kbA=;
 b=YEu7tiN+Qj5KJHco5fl2NJkAdJNTTVeOKKeb+DaiZhewaO2hjAyDhBvwDTgNHMjBsU
 /cAkaYWV+5APnKzL95tc6BhBc4YOuaQRSPJMzLCo448iMqbBSSTh6QdcF+NnCuueEmMN
 vzlFYYG0V+jbxX0LoSERHvkqLcE7nnPaFWwn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695339172; x=1695943972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9IFf8JL0qToTR4vZ6DOEyA3pL6r/lGAPnsJy3i9kbA=;
 b=DHoy9S9rardGLYNsIiHQAWwR9L/YszDDqvuFWiPbEGw0F0/CQIXlYbjaEmSn9yQQjB
 fuTrIgVk3qoYmggYBu17fLzv1FOf7nanhQV7gTLjtYm5aOKygKnQmY5SRhibAyfyWQuv
 JfxXcxKsxSjUBrA9/qvVl9+DLR1M5yRRXL7yjnB4Wzibfui++toFPNH9Bz1+NAwZXfNl
 wPST9RZZIikXTnTHd1fbMVtecnswVJWr2F5EpQ4U7f+eJwbBzsjx9JaTJMn7GsGK5dWC
 1SCutHCxDm/nucdTRu05CCfCIZnS6219n7NUGK6bjJiAaHSxGjxialftrfUT5HmqF/Pk
 +0/A==
X-Gm-Message-State: AOJu0YxF4OxjLXv9te8Oub+hkA749zMF/DoDRMLKr5ev2QAKT7UWAuQF
 UJyn12abvkn7tcmgcVv+uI1VWXtP4sGEgcxeCgdc2A==
X-Google-Smtp-Source: AGHT+IFMXGno/ZDOBe59fIQsb0OgsOz6aNMgOyPPfqyaW26tuKH661tMg93MSBymziIvKmI4iaNm6A==
X-Received: by 2002:a25:d87:0:b0:d7f:2cb6:7d8b with SMTP id
 129-20020a250d87000000b00d7f2cb67d8bmr6747068ybn.63.1695339172424; 
 Thu, 21 Sep 2023 16:32:52 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a25808b000000b00d8168e226e6sm566793ybk.47.2023.09.21.16.32.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 16:32:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] exynos: Cleanup exynos_init
Date: Thu, 21 Sep 2023 19:32:48 -0400
Message-Id: <20230921233248.159047-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921233248.159047-1-trini@konsulko.com>
References: <20230921233248.159047-1-trini@konsulko.com>
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

- None of the callers perform error checking and based on the non-empty
  versions of this function, there's no checking to be done, so make
  this a void.
- Add a default weak version of the function.
- Remove the empty versions of exynos_init now that we have a weak
  version.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-exynos/include/mach/board.h |  2 +-
 board/samsung/axy17lte/Makefile           |  3 ---
 board/samsung/axy17lte/axy17lte.c         | 11 -----------
 board/samsung/common/board.c              |  8 +++++++-
 board/samsung/common/exynos5-dt.c         |  5 -----
 board/samsung/espresso7420/Makefile       |  6 ------
 board/samsung/espresso7420/espresso7420.c | 13 -------------
 board/samsung/odroid/odroid.c             |  4 +---
 board/samsung/origen/origen.c             |  5 -----
 board/samsung/trats/trats.c               | 14 +++++---------
 board/samsung/trats2/trats2.c             |  4 +---
 board/samsung/universal_c210/universal.c  |  4 +---
 12 files changed, 16 insertions(+), 63 deletions(-)
 delete mode 100644 board/samsung/axy17lte/Makefile
 delete mode 100644 board/samsung/axy17lte/axy17lte.c
 delete mode 100644 board/samsung/espresso7420/Makefile
 delete mode 100644 board/samsung/espresso7420/espresso7420.c

diff --git a/arch/arm/mach-exynos/include/mach/board.h b/arch/arm/mach-exynos/include/mach/board.h
index 44ebdb829b20..a167f967933f 100644
--- a/arch/arm/mach-exynos/include/mach/board.h
+++ b/arch/arm/mach-exynos/include/mach/board.h
@@ -11,7 +11,7 @@
  * Exynos baord specific changes for
  * board_init
  */
-int exynos_init(void);
+void exynos_init(void);
 
 /*
  * Exynos board specific changes for
diff --git a/board/samsung/axy17lte/Makefile b/board/samsung/axy17lte/Makefile
deleted file mode 100644
index 4e11f289dcee..000000000000
--- a/board/samsung/axy17lte/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-obj-y	+= axy17lte.o
diff --git a/board/samsung/axy17lte/axy17lte.c b/board/samsung/axy17lte/axy17lte.c
deleted file mode 100644
index c38297a05bab..000000000000
--- a/board/samsung/axy17lte/axy17lte.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Samsung A5Y17 and A3Y17 LTE boards based on Exynos 7880 and Exynos 7870 SoCs
- */
-
-#include <common.h>
-
-int exynos_init(void)
-{
-	return 0;
-}
diff --git a/board/samsung/common/board.c b/board/samsung/common/board.c
index 663d7ca991bc..5a71982775d0 100644
--- a/board/samsung/common/board.c
+++ b/board/samsung/common/board.c
@@ -43,6 +43,10 @@ __weak int exynos_early_init_f(void)
 	return 0;
 }
 
+__weak void exynos_init(void)
+{
+}
+
 __weak int exynos_power_init(void)
 {
 	return 0;
@@ -113,7 +117,9 @@ int board_init(void)
 	gd->ram_size -= size;
 	gd->bd->bi_dram[CONFIG_NR_DRAM_BANKS - 1].size -= size;
 #endif
-	return exynos_init();
+	exynos_init();
+
+	return 0;
 }
 
 int dram_init(void)
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index 726b7f0667a6..72e0cecb040f 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -37,11 +37,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int exynos_init(void)
-{
-	return 0;
-}
-
 static int exynos_set_regulator(const char *name, uint uv)
 {
 	struct udevice *dev;
diff --git a/board/samsung/espresso7420/Makefile b/board/samsung/espresso7420/Makefile
deleted file mode 100644
index bb882eaa254e..000000000000
--- a/board/samsung/espresso7420/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2016 Samsung Electronics
-# Thomas Abraham <thomas.ab@samsung.com>
-
-obj-y	+= espresso7420.o
diff --git a/board/samsung/espresso7420/espresso7420.c b/board/samsung/espresso7420/espresso7420.c
deleted file mode 100644
index 9f6fa897477a..000000000000
--- a/board/samsung/espresso7420/espresso7420.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Espresso7420 board file
- * Copyright (C) 2016 Samsung Electronics
- * Thomas Abraham <thomas.ab@samsung.com>
- */
-
-#include <common.h>
-
-int exynos_init(void)
-{
-	return 0;
-}
diff --git a/board/samsung/odroid/odroid.c b/board/samsung/odroid/odroid.c
index 39a60e4ad295..2c5bafae7f00 100644
--- a/board/samsung/odroid/odroid.c
+++ b/board/samsung/odroid/odroid.c
@@ -422,11 +422,9 @@ int exynos_early_init_f(void)
 	return 0;
 }
 
-int exynos_init(void)
+void exynos_init(void)
 {
 	board_gpio_init();
-
-	return 0;
 }
 
 int exynos_power_init(void)
diff --git a/board/samsung/origen/origen.c b/board/samsung/origen/origen.c
index 7a91f448969b..ddf6a2b72fa5 100644
--- a/board/samsung/origen/origen.c
+++ b/board/samsung/origen/origen.c
@@ -12,11 +12,6 @@
 #include <asm/arch/pinmux.h>
 #include <usb.h>
 
-int exynos_init(void)
-{
-	return 0;
-}
-
 int board_usb_init(int index, enum usb_init_type init)
 {
 	return 0;
diff --git a/board/samsung/trats/trats.c b/board/samsung/trats/trats.c
index 1608d60dd8db..6a3e5b29b989 100644
--- a/board/samsung/trats/trats.c
+++ b/board/samsung/trats/trats.c
@@ -40,17 +40,8 @@ u32 get_board_rev(void)
 }
 #endif
 
-static void check_hw_revision(void);
 struct dwc2_plat_otg_data s5pc210_otg_data;
 
-int exynos_init(void)
-{
-	check_hw_revision();
-	printf("HW Revision:\t0x%x\n", board_rev);
-
-	return 0;
-}
-
 #if !CONFIG_IS_ENABLED(DM_I2C) /* TODO(maintainer): Convert to driver model */
 static void trats_low_power_mode(void)
 {
@@ -215,6 +206,11 @@ static void check_hw_revision(void)
 	board_rev |= hwrev;
 }
 
+void exynos_init(void)
+{
+	check_hw_revision();
+	printf("HW Revision:\t0x%x\n", board_rev);
+}
 
 #ifdef CONFIG_USB_GADGET
 static int s5pc210_phy_control(int on)
diff --git a/board/samsung/trats2/trats2.c b/board/samsung/trats2/trats2.c
index 93c9714d33f0..81ccc124c809 100644
--- a/board/samsung/trats2/trats2.c
+++ b/board/samsung/trats2/trats2.c
@@ -107,7 +107,7 @@ int exynos_early_init_f(void)
 	return 0;
 }
 
-int exynos_init(void)
+void exynos_init(void)
 {
 	struct exynos4_power *pwr =
 		(struct exynos4_power *)samsung_get_base_power();
@@ -124,8 +124,6 @@ int exynos_init(void)
 	 */
 	writel(0, &pwr->inform4);
 	writel(0, &pwr->inform5);
-
-	return 0;
 }
 
 int exynos_power_init(void)
diff --git a/board/samsung/universal_c210/universal.c b/board/samsung/universal_c210/universal.c
index 37c9d7f452f1..2d61dff89c2c 100644
--- a/board/samsung/universal_c210/universal.c
+++ b/board/samsung/universal_c210/universal.c
@@ -265,7 +265,7 @@ static int init_pmic_lcd(void)
 	return 0;
 }
 
-int exynos_init(void)
+void exynos_init(void)
 {
 	gd->bd->bi_arch_number = MACH_TYPE_UNIVERSAL_C210;
 
@@ -293,6 +293,4 @@ int exynos_init(void)
 
 	check_hw_revision();
 	printf("HW Revision:\t0x%x\n", board_rev);
-
-	return 0;
 }
-- 
2.34.1

