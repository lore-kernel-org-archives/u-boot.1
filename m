Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A446E69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5BA83F59;
	Mon, 22 Dec 2025 21:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x59D5pUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EB683DEB; Mon, 22 Dec 2025 21:02:59 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E5A83E88
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so24217965e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433771; x=1767038571;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OYJi5iCiSPWDgx99F+hdyTPUcskkDxqwPj7i96E3Nk8=;
 b=x59D5pUEhE5EKaUU2SiQMqkdr/Afl8Y639hNk4c9lhaFPHR0LlSPejeAlp8c49XLo3
 sHXsF/C4Gpij/0uE9zYyXT5JGOiM0sRaXVYNz9YhSz3Dy0zKKeUiJMCfKdlkcDexAgHR
 lJBsQ4cgRSEOMitelLI8Ic0tRXDaW5b9mkRXKOgeF7XsOf/JDFKTr2Rz+cKY4pT+/vVR
 CKrgmMNw0yMfZCkndjGxIonvZFn0P0ThcMF0P/lZu/lmDSQEv49XMVMI3JWqk1eqhIPp
 dw78LX/Rszr0teAJE/jF3InN3b5N0ZICZeO7OBr4SR9etU8BW5fabjimQdKfW0yshDPP
 Uvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433771; x=1767038571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OYJi5iCiSPWDgx99F+hdyTPUcskkDxqwPj7i96E3Nk8=;
 b=hvVmGqVWmVZM7DMD5BV7Lt4sZRKJM2lVKHxH3ONNcaEABLZpASor0D1jvjD4oEr9pO
 G0OONlveuG7VgwMjdMCcQ57sT8DwE9BDeoo0apbkSsWPugAN3CnIVgju7dvGbNICKUjM
 lAi6Z6PdfiIf8n0XpzDm91xuKI9iBmxttyYmV82Vwcq/mcUJXsgekkEscpQxvfNLRci0
 6U7wm1ps0mV7UWbisfC6PpIYpL99PED63nMCqUvbCkmFvS+RGti1NUepE9tzZ5/LSivf
 Kv3SHNGr170F11Tsk5dY4JlAO9NEGYelJau82O20TrPYyWvfbDOu2lYXfrp1YYkDhAIb
 ALfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlzoIM6aZInGi0bnP7xEDPqi1pGlkgogb5qoucRTJEpEDdZ8z9soem258oKwzpNQveDWCEn2U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvz2ZrxGWs2cuF8eu0hXNiEQxIcZ4sM4R11cncPJZZVNmOEKq1
 ggMjj3eac5OA/k09CwnAUbDNv7TDCAnzFYULaE8RU+BtGuFvO03GODfDUzCffuyNDL4=
X-Gm-Gg: AY/fxX7AQUiQ2EtyE4n45uWUkEVbnrecPHsWiV2zsRVTNCC7t6Vv53ds48VKOFTYp1R
 V+EHrg1x67mU0i9x+/B3A7OhdhTML9XBODhlY22KE04M8PvJtmrVJk7OAYSbj8l8DBOfuSf8Fkb
 NBrydKDpHMI7APPch5QU5fgoro2T0HZafqRVbcMnRy67cvZNjpxGUlVt/47r3Rw+SCjqXeOcM6p
 G4nPHVqJvMqfCJVozP+lc2mF5jRP7wyrvc0S0vjdB9VL0fAhf6Socd9GUCM/g4sUXKAsEVbNfHi
 oDq8TQeN+MYHZiIowGBz5Se3x2YzBYCEr/vrCfAd/3vEYAE8g1aVYcqbmiAxIhCbYm66jzry/1s
 g8ydgOm8Wmef+pDPx4/WhDa8ETuSBr+JrM0GefYVUq32Ek0EYfSy41l330Gb0tWodEjjsLbmS+6
 FnO42qTbqy
X-Google-Smtp-Source: AGHT+IH0IzNie2gW8wazPn5haXocHuGzrgirBc97i/d+3qcXCesTz6Z8SNFONWAAxpzJUWtOjiNRUA==
X-Received: by 2002:a05:600c:4fce:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47d194c5bffmr105515155e9.0.1766433770851; 
 Mon, 22 Dec 2025 12:02:50 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm207327065e9.12.2025.12.22.12.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:50 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:23 +0100
Subject: [PATCH v8 02/13] arm: mach-k3: am62xx-lpm-common: Add CANUART
 wakeup check helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-2-e70fed16b166@baylibre.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xQBfpU5NCsOT9ILVMV/tNop9AeF41I/o+lQzR9HgXnc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxQt/b30xN2DmlB8nc7cYxq98Iv9wvtXFG6c5Xzc8k
 Nz1y+JwTEcpC4MYF4OsmCJLZ2Jo2n/5nceSFy3bDDOHlQlkCAMXpwBMZNZiRoZP2lyzkzq8bl1Z
 7rgs763jrJ/FYvrvOvvnsBvOlYzbc6WekeGOahMfyxKzwIqXN2Yv/n2hbVu4a3XHd96F9z7cYpn
 18wYjAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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

Add dedicated helper functions to check CANUART wake registers and magic
word. This helps determining if we are in a wakeup or if CAN IO
isolation has to be removed.

Also add a helper to detect a low power mode exit/resume.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/Makefile            |  3 +++
 arch/arm/mach-k3/am62xx-lpm-common.c | 38 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h | 16 +++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67cd8c62af8e0cb4c60020bed2b5624..7a020a8318bae924e6d976fa625b817b37456d84 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
 obj-y += common.o security.o k3-ddr.o
+obj-$(CONFIG_SOC_K3_AM625) += am62xx-lpm-common.o
+obj-$(CONFIG_SOC_K3_AM62A7) += am62xx-lpm-common.o
+obj-$(CONFIG_SOC_K3_AM62P5) += am62xx-lpm-common.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
new file mode 100644
index 0000000000000000000000000000000000000000..424d7457c596290ef48acd7f7aec3fd192dd3000
--- /dev/null
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am62xx common LPM functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <config.h>
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+
+#include "am62xx-lpm-common.h"
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+static bool wkup_ctrl_canuart_wakeup_active(void)
+{
+	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
+		WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool wkup_ctrl_canuart_magic_word_set(void)
+{
+	return readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT) ==
+		WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool wkup_ctrl_is_lpm_exit(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		wkup_ctrl_canuart_wakeup_active() &&
+		wkup_ctrl_canuart_magic_word_set();
+}
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
new file mode 100644
index 0000000000000000000000000000000000000000..36dcd20a9b802bb0eae8dfa56836e7da70107e62
--- /dev/null
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * am62xx common LPM functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#ifndef _AM62XX_LPM_COMMON_H_
+#define _AM62XX_LPM_COMMON_H_
+
+#include <asm/io.h>
+
+bool wkup_ctrl_is_lpm_exit(void);
+
+#endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.51.0

