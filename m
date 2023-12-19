Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4688BC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C21877F8;
	Tue, 19 Dec 2023 17:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qOv5jNK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3D98788A; Tue, 19 Dec 2023 17:04:53 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12F8877D0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336695c4317so2321344f8f.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001875; x=1703606675; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mMs8K1PAsaHk8UN4dDmWQNLHyTgewbOJ1knpOJeS13A=;
 b=qOv5jNK4qhQsiXFGsMmGXDR0p1X7+BioZtuVYYOOM14FvGXtYhn8t4cj2EvRnlJzRT
 wi1t/acF4LXvp7Fkshv3tQWS+Ia826XYQ10lwTqLbphOmbTe2RN2cqUOmcmgsWsoHwqY
 NoR1IsiEJLmCey7m8RZOGP8SJcvT3JhFjwzLqwg4wupBqYE3ARWbX1sczqs5En68RL1N
 ZNJEqoc5mgkmxJYd2yb4W452kbY/ZG3HCzQnsqXJEwelQ5N1US0N9iRCVwWwJBn9OD5A
 09yqBdWEcTsxiK8HCEpPYLg7/PLkcWrGu1UFwBNs43ZHNS10A97q8mFxjLQCaH2Qe6nI
 LZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001875; x=1703606675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMs8K1PAsaHk8UN4dDmWQNLHyTgewbOJ1knpOJeS13A=;
 b=bbdDdN7ZACguT6IgIigGkaATt3aZ5rRwU0Sdg47dyUtQvLdeA8RL1G5JunfuO9ltwC
 JBUp08s/0tGq7iRt9ShZylSCi3nfuZ1/K/+lg+rESlcMlWVH1huOZ/m2yzAdUV+Gzekw
 AuDV0rusxpqrXHlRbGD5dYeMAkodzl0uokM/qF/znxRnerILN56XKYr1B+3fPC15wOmm
 RsJkn7Zi+tgVQ4UOUrpesMRNjR4HYrScs/gSnyUnEW2jTCd6d/TcQ4YsgcwV8ZZ6IRT8
 JUXosv116UqH2g4jmnjZ55oqT2bE1LjaqUFtFlNKaPOBWKpoIVSgv/zwvuOolORpATHo
 hCJA==
X-Gm-Message-State: AOJu0Yxry2H5q29DTsGqThFyqga9lLN5842meAea3vLjGSpUTRk5NOVi
 JFHM6Aj2txZ0AUcOZfKu3iNYuw==
X-Google-Smtp-Source: AGHT+IEs1ZylajN15Ad21gleAjOi/IXqgw99NcgHN+j7+Crv4HwsQdsGOGzBMsEZAQMkJBKfwrZ/nw==
X-Received: by 2002:a05:600c:4f14:b0:40c:6af0:cce0 with SMTP id
 l20-20020a05600c4f1400b0040c6af0cce0mr4338726wmq.142.1703001875306; 
 Tue, 19 Dec 2023 08:04:35 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:14 +0000
Subject: [PATCH v2 13/32] board: dragonboard410c: import board code from
 mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-13-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=7019;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jdeDHdjTPvM6nVE5QfsMuqNbJIn1qKiS34a0Y7rOvoM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UyTTarCV3xPmHoy2zinfuOMHVz737VP/zorf7XTz
 tXix76EdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJrDjMyLDj1w1+tasR1jUP
 f0Z6xVkkqHwMmy6T77Fx2VKmSaHy80MZGZpmCfxS+rVztbXsvMufmzivVKlP9PZWOLDRrzp6ywE
 DwzkA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Some of the db410c board support code was written to be generic and
placed in mach-snapdragon. However, as the db410c is the only board
using this, move the code out of mach-snapdragon. This makes is more
obvious what code is relevant for which targets and helps tidy things up
a little more.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile                  |  2 -
 arch/arm/mach-snapdragon/include/mach/dram.h       | 12 -----
 arch/arm/mach-snapdragon/misc.c                    | 55 ----------------------
 board/qualcomm/dragonboard410c/Makefile            |  3 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  4 +-
 .../qualcomm/dragonboard410c/misc.c                | 51 +++++++++++++++++++-
 .../mach => board/qualcomm/dragonboard410c}/misc.h |  1 +
 7 files changed, 54 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 3a3a297c1768..d02432df8b04 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -6,6 +6,4 @@ obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
-obj-y += misc.o
-obj-y += dram.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/arch/arm/mach-snapdragon/include/mach/dram.h b/arch/arm/mach-snapdragon/include/mach/dram.h
deleted file mode 100644
index 0a9eedda414c..000000000000
--- a/arch/arm/mach-snapdragon/include/mach/dram.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Snapdragon DRAM
- * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#ifndef DRAM_H
-#define DRAM_H
-
-int msm_fixup_memory(void *blob);
-
-#endif
diff --git a/arch/arm/mach-snapdragon/misc.c b/arch/arm/mach-snapdragon/misc.c
deleted file mode 100644
index 7d452f4529b7..000000000000
--- a/arch/arm/mach-snapdragon/misc.c
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Miscellaneous Snapdragon functionality
- *
- * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
- *
- */
-
-#include <common.h>
-#include <mmc.h>
-#include <asm/arch/misc.h>
-#include <asm/unaligned.h>
-
-/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
-#define UNSTUFF_BITS(resp, start, size) \
-	({ \
-		const int __size = size; \
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32); \
-		const int __shft = (start) & 31; \
-		u32 __res; \
-					\
-		__res = resp[__off] >> __shft; \
-		if (__size + __shft > 32) \
-			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
-		__res & __mask;	\
-	})
-
-u32 msm_board_serial(void)
-{
-	struct mmc *mmc_dev;
-
-	mmc_dev = find_mmc_device(0);
-	if (!mmc_dev)
-		return 0;
-
-	if (mmc_init(mmc_dev))
-		return 0;
-
-	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
-}
-
-void msm_generate_mac_addr(u8 *mac)
-{
-	/* use locally adminstrated pool */
-	mac[0] = 0x02;
-	mac[1] = 0x00;
-
-	/*
-	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
-	 * Use big endian order so it is consistent with the serial number
-	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
-	 */
-	put_unaligned_be32(msm_board_serial(), &mac[2]);
-}
diff --git a/board/qualcomm/dragonboard410c/Makefile b/board/qualcomm/dragonboard410c/Makefile
index 1b99c8b0efef..a3ae1a5f9136 100644
--- a/board/qualcomm/dragonboard410c/Makefile
+++ b/board/qualcomm/dragonboard410c/Makefile
@@ -2,4 +2,5 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-y	:= dragonboard410c.o
+obj-y += dragonboard410c.o
+obj-y += misc.o
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 1adac07569ae..eea603a4148d 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -18,10 +18,10 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
-#include <asm/arch/misc.h>
 #include <linux/delay.h>
 
+#include "misc.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #define USB_HUB_RESET_GPIO 2
diff --git a/arch/arm/mach-snapdragon/dram.c b/board/qualcomm/dragonboard410c/misc.c
similarity index 64%
rename from arch/arm/mach-snapdragon/dram.c
rename to board/qualcomm/dragonboard410c/misc.c
index 499dfdf0da6e..27d51ef78914 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/board/qualcomm/dragonboard410c/misc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Onboard memory detection for Snapdragon boards
+ * Miscellaneous Snapdragon functionality
  *
  * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
  *
@@ -9,10 +9,56 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <mmc.h>
 #include <part.h>
 #include <smem.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
+#include <asm/unaligned.h>
+
+#include "misc.h"
+
+/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
+#define UNSTUFF_BITS(resp, start, size) \
+	({ \
+		const int __size = size; \
+		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
+		const int __off = 3 - ((start) / 32); \
+		const int __shft = (start) & 31; \
+		u32 __res; \
+					\
+		__res = resp[__off] >> __shft; \
+		if (__size + __shft > 32) \
+			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
+		__res & __mask;	\
+	})
+
+u32 msm_board_serial(void)
+{
+	struct mmc *mmc_dev;
+
+	mmc_dev = find_mmc_device(0);
+	if (!mmc_dev)
+		return 0;
+
+	if (mmc_init(mmc_dev))
+		return 0;
+
+	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
+}
+
+void msm_generate_mac_addr(u8 *mac)
+{
+	/* use locally adminstrated pool */
+	mac[0] = 0x02;
+	mac[1] = 0x00;
+
+	/*
+	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
+	 * Use big endian order so it is consistent with the serial number
+	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
+	 */
+	put_unaligned_be32(msm_board_serial(), &mac[2]);
+}
 
 #define SMEM_USABLE_RAM_PARTITION_TABLE 402
 #define RAM_PART_NAME_LENGTH            16
@@ -97,3 +143,4 @@ int msm_fixup_memory(void *blob)
 
 	return 0;
 }
+
diff --git a/arch/arm/mach-snapdragon/include/mach/misc.h b/board/qualcomm/dragonboard410c/misc.h
similarity index 87%
rename from arch/arm/mach-snapdragon/include/mach/misc.h
rename to board/qualcomm/dragonboard410c/misc.h
index c60e3e472470..fe44caf51b18 100644
--- a/arch/arm/mach-snapdragon/include/mach/misc.h
+++ b/board/qualcomm/dragonboard410c/misc.h
@@ -9,5 +9,6 @@
 
 u32 msm_board_serial(void);
 void msm_generate_mac_addr(u8 *mac);
+int msm_fixup_memory(void *blob);
 
 #endif

-- 
2.42.1

