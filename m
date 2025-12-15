Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0317D5B868
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 20:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1BE8036B;
	Mon, 15 Dec 2025 21:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hda7SF1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95A28003E; Mon, 15 Dec 2025 21:27:54 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D948003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 21:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-29f2676bb21so40321635ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765830471; x=1766435271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JTcM5ik4eG8VnVhDyd+EEkLibWKamBUOSBUt9FLwo4w=;
 b=Hda7SF1lCqPeGTnlUXOJGoAVbPVNNxMKmePelEEjpaAMGl+cCnDYDbvMIhlgEuVGq+
 qOumLa72yIPBZsaj95M3IyNKN3YhKVQv1XptjPdHFj9K/hmzrvgU+dTWFeRBKYdN2LI1
 4IvU9Gmib8SWucYud1CyU1gZjYH2mwVJTtv8KhfAyJjBHpRNQ9Gb7E2/aJ8xctco2+wA
 IBiedl4nKt+vrdJ6hDGb6Q9jOnb5gytLEZIcKDAd3aGgyu+lPYJ7cRM1QbIqxuBfjBdi
 G9L9Tnxall2JogVclP7uNzU8FI18XsFtwJa4Ji0CQXQc1M8MH0PSxhftb4fiBmf2YPzz
 wNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765830471; x=1766435271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JTcM5ik4eG8VnVhDyd+EEkLibWKamBUOSBUt9FLwo4w=;
 b=a6ylR8UEw172on6rqPW+yM0+mvP+jgnugcaXmJySEda5sVGdsAw+Yx453GpMkmbRgi
 /6FmxhdldnMV6v+z0QVdplayQXiiKw+XdeU7qDhZQydMMp1mm21kik78byxrJWqKm6iC
 nUGSU1Q+Sy7G3bMz0qBof3DzvW03ALYAyFaY4EMeFF9BlMre4T3k+o4LoRV/fQRzHY9P
 Tk1OFQ9m6mgsJHPxcmxa2WByxW23gaR0BGtASidgXt9FbDQrKO6/sUnWEXwpT+l2HHS7
 p1K+S/8M9F3BE7XATNgf5m8Tb/SFPCAWvfwQU8U7CWYUtYipAUa9fIqC2UfF+thsu+eQ
 jm4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3L4sR+ypIn9kFrgITyh4Kbh89AnIKabFFKgNi5YmKj9KBb41390dnqjJDhSpigq1cS3DZrbE=@lists.denx.de
X-Gm-Message-State: AOJu0YyprX8ZDkWuibhLnoZWOhvM+7oo0O0MPrMV9Jm2gZqSiP9VADLh
 6ajycq1sUL3+E/BVAu6UjZ6bYLmOQX57p0Q2K1N6pgnh2P0sE88jscRCBa6GaQ==
X-Gm-Gg: AY/fxX6k4XBsKCzK36djTNS6N2nm6v7MEHq+nMQsXGst8iXj7PBsvndZ5sBq2sMPIZN
 WHYagcQ3RPHrtVsCfomqiL//AZTdslK+AMitKeB7Xa3/aemb7Fm/oBBn18jRjiTw5h9tDttDEx6
 Q7dmZAoWjWig6cidK5817eY3Rd1B4j5ivqVksNDG0KLa4yFZ/fYN+Z1L2i5I/J/uZ5MvRBMIMUH
 1JD34v6lp7f1etzR66vZ2JuJDGLzWx1ns6jXpRxVVVM9MJPe4hErQSGwz+v2FzrbsHpt3tb1OGa
 41sWRvzi4xCdZWzUNlYUSZs22v6crcVppYQZKIzjHvFScafmWAeC1ZGBGDb1b6BMfW4y4dsg68Q
 OAeRMPShfcR1iRIF0AfQoan/i3qF3h80/lkfOafbvoVKIrCHloAGqW1zy5vd3KVX194pYIQ7R7X
 csnM9mIzey70PRnmVDhzVO1MKtffk7CcqnwV6nNQ==
X-Google-Smtp-Source: AGHT+IF3J9OXTRtIr+TuxYCf6yXgYvYbLb4BvAOjmlth7aw2lIZzIjsJ2sVbWbwQ7oblYW8blXtEGw==
X-Received: by 2002:a17:902:e54e:b0:295:54cd:d2dc with SMTP id
 d9443c01a7336-29f23e1ef24mr120231305ad.16.1765830470774; 
 Mon, 15 Dec 2025 12:27:50 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29efd74f5e1sm127427705ad.16.2025.12.15.12.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:27:50 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/3] sync sdram ecc support to mainstream
Date: Tue, 16 Dec 2025 04:27:11 +0800
Message-ID: <20251215202712.175-2-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20251215202712.175-1-briansune@gmail.com>
References: <20251215202712.175-1-briansune@gmail.com>
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

It is been a while that the DDR ECC is missing.
Pull from Altera trunk and sync to mainstream.
This sdram_soc32 introduce the ecc setup.
Modifications are done to support dts memory@0
while old memory will work properly on gd->bd
Real ECC supported board test is required.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 drivers/ddr/altera/sdram_soc32.c | 71 ++++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h | 11 +++++
 2 files changed, 82 insertions(+)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
new file mode 100644
index 00000000000..e82146e448e
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
+#include "sdram_soc32.h"
+#include <watchdog.h>
+#include <wait_bit.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
+
+#define PGTABLE_OFF	0x4000
+
+/* Initialize SDRAM ECC bits to avoid false DBE */
+void sdram_init_ecc_bits(unsigned long long sdram_size)
+{
+	u32 start;
+	phys_addr_t start_addr;
+	phys_size_t size, size_init;
+
+	start = get_timer(0);
+
+	start_addr = 0;
+	size = sdram_size;
+
+	printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
+
+	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
+	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
+	size -= PGTABLE_OFF + PGTABLE_SIZE;
+
+	dcache_enable();
+
+	while (size > 0) {
+		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+
+		debug("%s: %d\n", __func__, __LINE__);
+
+#ifdef CONFIG_HW_WATCHDOG
+		/*
+		 * In case the watchdog is enabled,
+		 * make sure to (re-)configure watchdog
+		 * so that the defined timeout is valid.
+		 */
+		hw_watchdog_init();
+#else
+		/*
+		 * If the HW watchdog is NOT enabled,
+		 * make sure it is not running, because
+		 * it is enabled in the preloader and
+		 * causing boot loop if is not handled.
+		 */
+		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+#endif
+	}
+
+	dcache_disable();
+
+	printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
+	       (u32)get_timer(start));
+}
+
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..7bd76eb560f
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ */
+
+#ifndef	_SDRAM_SOC32_H_
+#define	_SDRAM_SOC32_H_
+
+void sdram_init_ecc_bits(unsigned long long sdram_size);
+
+#endif /* _SDRAM_SOC32_H_ */
-- 
2.34.1

