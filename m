Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDDAC79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AACE83E48;
	Mon,  5 Jan 2026 17:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n2fTAnPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C0F83E16; Mon,  5 Jan 2026 17:41:26 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DF483A9F
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso25699f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631277; x=1768236077;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OYJi5iCiSPWDgx99F+hdyTPUcskkDxqwPj7i96E3Nk8=;
 b=n2fTAnPToOu2b2D6kedNvg6TNdjJ/mPThT0ku0POKm2/+lY2kf2zLLlHZ+IK/cdTkp
 +7U/tIPES+dquZv/I/KH0KS4UWr6f/ITaTGxdPLY2C8v0YQlj2e26Il7Ay+efmT8YdzL
 HeP06UHR6I7zcyy9+SrSxrxq7lBYnQTvylBJtg7uLPE/OaWDRTmx+OL5ZKoDOX6R5sv4
 nO3BEvXjV6s+McCiOY7XQhIzt3x8lpgxWuHD4S5pj4MDii343VyoGvI1G7b1L6kLA7wK
 kB1+6j1V0gYQnJLcNqh37KCWfwsbyq/9GxNmzInzWDkLLM4zZ33lei9SsdlKs+tgQEP6
 7tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631277; x=1768236077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OYJi5iCiSPWDgx99F+hdyTPUcskkDxqwPj7i96E3Nk8=;
 b=HryYcR+vQdJGB9pEqb2PH79yEXtu/grFDoJaudTtSAhkyKWU2NMdFrM9VHfvz9H6yO
 WwFwP5dDpOfJC6ApQF2qM56MGBowPMOB24/BtGlQ+T0f1dhCdwcA5ff+zfZ6dgcfCjJO
 OPh3mEOvzBlM7b4P7J5a67MMJ4F5KVPteToKgbJVGXrBbvQDF+WLrGMJtJ45xKcEx7aI
 TDpQVPrZ8/oBeQ+rox2rzGvQGK0EgPdC0ZT34G9MZM6DDMyOKBCOIFqQYmAkqx9bS8XM
 Gukl6+laArGQGWjPAwLc6KYnlqanv7hEcVzZo4s/qvFxdQyzcwgTWi2j0Caps/bgQkjg
 XTRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFr9z8RmeVYH6pHop92hyDx75ZS8LHoCH9uiH77H4eWxwIGkdPe+mz8H+VYAUWrwvF+MpbBco=@lists.denx.de
X-Gm-Message-State: AOJu0YzJb4dpqruKe4VLAl7/O1zFx51LB5u9uSDfoWP5uDALfNWbSQ6P
 GAicAiiG+JD2RlXXKk+Wpmr7KdLB3bwx/9OZIq04PCasB6ntUifv490DCqKpFN89D5Q=
X-Gm-Gg: AY/fxX6XKkc/PpwUsGEfN7sUDg6pSJotYpZOiZm/x2/dXdZvG4LlvlCxbPBCQTICDIt
 v65lcURI2G3ase9iQsKnIdCRQ/lhu6wc3VZQ8pLhNqR3LRcu2NHrWtBDZXLo20727g92ONpbDh/
 /QFq6zLTiBhE4H5aQbe6krar/D1unTzO83gy93ztB7OJl1SEhgiwAalvjIWUWyx9IF7yg3hbnws
 SaLNthsvp0BOPpApb/MKXfH/jfkht1++q21Zez3HTAhAybf8qRi4pwTKBBR72xVKRGq3xYyNi3M
 NvO+QK2fypkmQNCWjrTl+h3Dqq96DuuH1W5BieO/llQ8/1AD6ZK7vpaTiLSIxgOfig+G1wioBhI
 OynahSncogwfmyUgQDUYg8JSCFrIbfpfCr9BINQ041ZKkqmtgLpRUzycsYYYcWBUA5TJN9+xQQk
 rzDktT4AIC
X-Google-Smtp-Source: AGHT+IF6Da6Ijd4MRdtolZgo5+R6ouNybz0w4Q/EbtCWDLADIOyCJMNAvQkmlWVtwBBT1JvP4zD92A==
X-Received: by 2002:a05:6000:184f:b0:42b:3246:1681 with SMTP id
 ffacd0b85a97d-432bc9d33cfmr531993f8f.18.1767631277440; 
 Mon, 05 Jan 2026 08:41:17 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca2fabcsm451013f8f.16.2026.01.05.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:16 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:47 +0100
Subject: [PATCH v9 02/13] arm: mach-k3: am62xx-lpm-common: Add CANUART
 wakeup check helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-2-7e33f2c77dbf@baylibre.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszolzn/5pyZEHvIbdGnE+VnT8z4oq69pEZ6VdqKFSuWa
 57O/3LpckcpC4MYF4OsmCJLZ2Jo2n/5nceSFy3bDDOHlQlkCAMXpwBMxHEPwz91744ez5PyOY1c
 b8Wulr6epzLnWs2vO3dz1ae3G0/2FDvI8D+puuihwfkJz5a+fj134maeZ8f7pR8kbqjZq+V84WN
 L1zcWAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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

