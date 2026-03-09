Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDEBF41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E9283952;
	Mon,  9 Mar 2026 16:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nt3EAr/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2606483952; Mon,  9 Mar 2026 16:54:12 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F1183F20
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so9348195e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773071649; x=1773676449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uD0FEmQWQLok9PLRZG/6uMlQQ4eFPxLXvGHHkTAWk2s=;
 b=Nt3EAr/MysRYbKFr5hNJHsy6r09l0/Yun7YLEjtF6WlmxhS5v0TnVW6gnTG5g2yWVm
 TpEqXfuXaJ9bpIoT2ZykYWjF3NBkfA8o3sKX65GSP85jeVol3wyXQUIxPWzaadHnN/1Y
 MHh6qhDS7kon/Q6z++H1xs5kzFp95IzjvB9f2QgZRr6DbyFOqemkVop1jCWEanSsvy34
 Ugmz+n49yjjNrEcRnwzeCZ9vbsLuB7kyYtByDfyCi3W158uYazAnebVpHNYwPMH+eLb7
 EqNYQTn5pMhnqNWwMlnNcnx3GrTx1nGRTlgwvsbj8Fe7F0T5GpTr9NX+AaEC4rVRyo2k
 A8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071649; x=1773676449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uD0FEmQWQLok9PLRZG/6uMlQQ4eFPxLXvGHHkTAWk2s=;
 b=hH5Aid0oKvGHWK7uPjSTTtaEUDRFiweoeM0bnTEVBqzcqosCDxa4yoeVgEM0y3ivr2
 wDwLfmSh/zkmwvkS5TPEFuhuQlKdgg6zVXWGiLXhLoe/g9tdt9hxQUvLY+odU2Hnx9Dm
 9FuJfLKRPwVV3Bm6FcimmpGXz1FmTSut7RIRXQdfb8du6RamdGAcaDX6Bn9PItw0qNwB
 AlW+bBS6+n2xs0gPvj8hOx6k56qPyuFrDV6v9p5pYWBLI28AFTZKLuab9GHmGgNKvvzn
 6CQQXyoZV8JE63ap5acm2Gp90YPqaZbPmTC+k2Ylga+CUj7Fbe/4N2FmdeTn+46ubidH
 dnow==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3M5ue3VZm6E9ShoBIhaQUXbiiRwjZ5cF241tiNSDXpdJ8ucFtH9L3UEZFjI6zmu8x34l0ZvI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1r22wPSMinQsB76G0Z2DGS7yhSsp5C8+/qJFCU+6I+UKu5GzJ
 gxrxOlFwLH/lWVSlATHwzKpSxWkpObWoHvz5Nf9AvwxxGWvNISwhOnnB
X-Gm-Gg: ATEYQzwJC1FPHTJy+VpcNwq/btaU9F4fXxVF8T3ydKgO0WHV0uA1iSOWFud1/uqI70G
 rxjUHGq5DTMY2iB6K2H+hfGX/yR8vCPVOSKVr5W9LLOw1XBNlkjVknjWduIaKPH+AphDN/J0JVH
 /XMNpBs47mp6qXXyDZmeS0XowyrwhUSoQHgnVjMueabyN3SyokU7qZ8fkTksxFAWEU+hdKvkqg1
 E4E5ME89mPnMuE0xAZ41mlJk3Cf0it+rQSGKDKcB92Pmb7IIb3qe0ay2GW4hlj3nCON+AdAhpeb
 qi5Uq4+oEeAtfWVTtDWaLMK9GYCC2x6LGsg+ne9M+lKBvBv2EfJItBmp24s8w4ZqJXwxfrV0JPO
 xSqW4sdxnvtUdcD7EG2kGdlWhKiVRPms+3r/tOsv7LuDauJ853915+8Ij7GgySEstrcpQFv7+qk
 uSL1pWDRAI22VoFmsaE08pKXvDsbIRadfZq76o/WJLhhyyFpIG8PbZnKZynbeoNAycGZthOxxbw
 DXlT1KDomHQHNsWI/Nqg4nAoojuPIJqtbCWB9jEBamO
X-Received: by 2002:a05:600c:8b6d:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-485364e9569mr86922585e9.16.1773071648705; 
 Mon, 09 Mar 2026 08:54:08 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm84408215e9.8.2026.03.09.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:54:08 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] board: toradex: aquila-am69: refactor memory
 configuration
Date: Mon,  9 Mar 2026 16:53:07 +0100
Message-ID: <20260309155342.145432-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
References: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The memory controller configuration doesn't depend only on the memory
size, so refactor the code to use the memory configuration read from
the HW_CFG pin instead of the memory size.
Additionally, make use of one header file for all the memory
configurations.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.c      | 18 +++++++++++-------
 board/toradex/aquila-am69/aquila_ddrs.h      | 14 ++++++++++++++
 board/toradex/aquila-am69/aquila_ddrs_16GB.h | 11 -----------
 board/toradex/aquila-am69/aquila_ddrs_8GB.h  | 11 -----------
 4 files changed, 25 insertions(+), 29 deletions(-)
 create mode 100644 board/toradex/aquila-am69/aquila_ddrs.h
 delete mode 100644 board/toradex/aquila-am69/aquila_ddrs_16GB.h
 delete mode 100644 board/toradex/aquila-am69/aquila_ddrs_8GB.h

diff --git a/board/toradex/aquila-am69/aquila-am69.c b/board/toradex/aquila-am69/aquila-am69.c
index e0975d5bc6fe..c3df14fc7c96 100644
--- a/board/toradex/aquila-am69/aquila-am69.c
+++ b/board/toradex/aquila-am69/aquila-am69.c
@@ -17,8 +17,7 @@
 #include <spl.h>
 
 #include "../common/tdx-common.h"
-#include "aquila_ddrs_16GB.h"
-#include "aquila_ddrs_8GB.h"
+#include "aquila_ddrs.h"
 #include "ddrs_patch.h"
 
 #define CTRL_MMR_CFG0_MCU_ADC1_CTRL	0x40F040B4
@@ -27,14 +26,19 @@
 #define HW_CFG_MEM_SZ_16GB		0x01
 #define HW_CFG_MEM_SZ_8GB		0x02
 
-#define HW_CFG_MEM_SZ_MASK		0x03
+#define HW_CFG_MEM_CFG_MASK		0x03
 
 DECLARE_GLOBAL_DATA_PTR;
 static u8 hw_cfg;
 
+static u8 aquila_am69_memory_cfg(void)
+{
+	return hw_cfg & HW_CFG_MEM_CFG_MASK;
+}
+
 static u64 aquila_am69_memory_size(void)
 {
-	switch (hw_cfg & HW_CFG_MEM_SZ_MASK) {
+	switch (aquila_am69_memory_cfg()) {
 	case HW_CFG_MEM_SZ_32GB:
 		return SZ_32G;
 	case HW_CFG_MEM_SZ_16GB:
@@ -79,12 +83,12 @@ static void update_ddr_timings(void)
 	int ret = 0;
 	void *fdt = (void *)gd->fdt_blob;
 
-	switch (aquila_am69_memory_size()) {
-	case SZ_8G:
+	switch (aquila_am69_memory_cfg()) {
+	case HW_CFG_MEM_SZ_8GB:
 		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_8GB,
 						      MULTI_DDR_CFG_INTRLV_SIZE_8GB);
 		break;
-	case SZ_16G:
+	case HW_CFG_MEM_SZ_16GB:
 		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_16GB,
 						      MULTI_DDR_CFG_INTRLV_SIZE_16GB);
 		break;
diff --git a/board/toradex/aquila-am69/aquila_ddrs.h b/board/toradex/aquila-am69/aquila_ddrs.h
new file mode 100644
index 000000000000..3f6cecf5405f
--- /dev/null
+++ b/board/toradex/aquila-am69/aquila_ddrs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) Toradex - https://www.toradex.com/
+ */
+#ifndef __AQUILA_DDRS_H
+#define __AQUILA_DDRS_H
+
+#define MULTI_DDR_CFG_INTRLV_SIZE_8GB 9
+#define MULTI_DDR_CFG_INTRLV_SIZE_16GB 11
+
+extern struct ddrss_patch *aquila_am69_ddrss_patch_8GB[4];
+extern struct ddrss_patch *aquila_am69_ddrss_patch_16GB[4];
+
+#endif // __AQUILA_DDRS_H
diff --git a/board/toradex/aquila-am69/aquila_ddrs_16GB.h b/board/toradex/aquila-am69/aquila_ddrs_16GB.h
deleted file mode 100644
index 0740c0ef25cd..000000000000
--- a/board/toradex/aquila-am69/aquila_ddrs_16GB.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2025 Toradex - https://www.toradex.com/
- */
-#ifndef __AQUILA_DDRS_16GB_H
-#define __AQUILA_DDRS_16GB_H
-
-#define MULTI_DDR_CFG_INTRLV_SIZE_16GB 11
-extern struct ddrss_patch *aquila_am69_ddrss_patch_16GB[4];
-
-#endif // __AQUILA_DDRS_16GB_H
diff --git a/board/toradex/aquila-am69/aquila_ddrs_8GB.h b/board/toradex/aquila-am69/aquila_ddrs_8GB.h
deleted file mode 100644
index c82f236d55f5..000000000000
--- a/board/toradex/aquila-am69/aquila_ddrs_8GB.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2025 Toradex - https://www.toradex.com/
- */
-#ifndef __AQUILA_DDRS_8GB_H
-#define __AQUILA_DDRS_8GB_H
-
-#define MULTI_DDR_CFG_INTRLV_SIZE_8GB 9
-extern struct ddrss_patch *aquila_am69_ddrss_patch_8GB[4];
-
-#endif // __AQUILA_DDRS_8GB_H
-- 
2.43.0

