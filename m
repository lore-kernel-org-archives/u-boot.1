Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3685CE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3CD84090;
	Mon, 22 Dec 2025 21:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MlSbKP1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1E283B99; Mon, 22 Dec 2025 21:02:59 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB84D83D1A
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso25918775e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433772; x=1767038572;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g/vcKNVAVlJVAIJwRvVS7DYi8JqztLA9/C0qEE8uyCM=;
 b=MlSbKP1Am45mfGoK6R1nQRPGP9f2YwlZfnwiLivXy2XV7DXTQ1v3rPjgPh4MiH4El9
 Mi8pSVJmaDXXiJJzpDrDjiY/lh/fwfpmh9+h4yg4UTpYdhl2HlKywmTgVBD4j1o4YqE7
 XrVV7kq1BdS5BFb7lDQkbg39bA9XNNocXa3mpsY1w0xmxH1+Wc2NGqOhvgP7CKC5nL2Z
 7ra4+ujHz1arj/obmPebYt8wnxoQbBJTy99ymPGWmULyNrIsZhxe8ftbyYkMOXSTJ1e/
 x3WIn2qPKbR5g8zFKVEY2Gu5vjawX9uyv/SQMIC8ePIhfvTQUypPmKf6SmDhIx4MaWK7
 kJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433772; x=1767038572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g/vcKNVAVlJVAIJwRvVS7DYi8JqztLA9/C0qEE8uyCM=;
 b=eugLfMM+wpW5oN3CpMSNN1rRiARe4Ij2pyYh/19F78rAE43BH1ldoIHDKNfWniAHCV
 ozEgtRjEYDUMZGKWyEpEbYB+LXJHBgXnDRnuVKTzBIVhneYHrrWzkuuroUFBJFunfqPh
 6UvOULKFRpuTXZ/V15iOCf6TxZIuqVTC10ABsxp3gJmgh3YvZAe1lqlqbvSfXaivGofc
 AcK+rvmOpDsup3uAqNKxtvemzgsO/ZMspMglzI1P2uWSKGAZPE9qO/X8T00GNP+V8ovu
 h0ZlQXcLCOIpXzuQTJPWZdSfySLvMCWuCguVgBJoyjMSlPVNDIsV3lmtiZYeDwm9/TXA
 f25Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8CxOI4fSW/tefyD09nRUydIA7XDgAXu9v6y8BiAjHVBYiVnRTUPTsrK47KPt+t/25eY4YCt0=@lists.denx.de
X-Gm-Message-State: AOJu0YzfdIa84Ca7YfDsFLVF4qmClAb5vftkWrXR1luYRU7LYzKpnKg1
 n3vfgF4VUTaaahnRqCLGLEMTV6lVA4mZhWexhgnNw9QtSs4WnBNsezzO6dIpDph3Ma4=
X-Gm-Gg: AY/fxX5Zd9SuTAl772q3CJpWVFlJ79GKNRbx5NSXsyL0pp5dItKud4oYMSfwIblgzbo
 wmSjfRsPJ5R/85qXM6EAx+1BHikoXJ7qwBwXT9YrG9+TtNpMLlZbyyS/41ib8ECO1oL4lyFpFc0
 4UwD7ugmXuE7zXZtEi4+alLEpjmc4hT1i7CeC2F4lR/u0aplwYIWx0RADXWHVSkR6Uka06oOiPM
 6WgQvuRaGSKnM528BQIV3IKPZhM9q398PdmguQWNnUZqJLPCPskLNOS8AMal7a3LZiLpKTPTeS8
 L1+fakN2JsXvvkPZ7dQTDUk7abhe4n7OFmwW+nAR4ba1d2BO86RcghzWQ1ge8BvGyOYt7pqXCBm
 ybwmAcS2f6QA2eaGzJ1mZ2/UJ0NBu1p72p07kHWid8R069m2XxVrQ/dF5ZVvRXUqR3/TpW0TNHy
 cr7+bMITBL
X-Google-Smtp-Source: AGHT+IGm1X9qsEDM6tE/90iIrWBee8pKmvoR0DOsFipJ7VQGAClKy2kfmkVmFvqYa70AJraGvRYlLw==
X-Received: by 2002:a7b:c454:0:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-47be29adacbmr105565215e9.7.1766433772007; 
 Mon, 22 Dec 2025 12:02:52 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm267221175e9.7.2025.12.22.12.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:51 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:24 +0100
Subject: [PATCH v8 03/13] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-3-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8005; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WXpibU02OKl35fGToP5dN4PdsTa40ZQ//mmV1od0StI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxSta1A/NchTRKb3zqGS5d+BEPuOM4+cfRB5OUvj3e
 8qHFSJHO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiNz8w/DM8y8AR3zVL71qo
 APN1IWZFcd2lDW1TJK6+F/rJNlHW5SAjw8s/qRUnwr002leW7VlzzGSW3qqA+tdLmR6/NPv75J0
 mIx8A
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

After leaving the Partial-IO mode or other deep sleep states, the IO
isolation needs to be removed. This routine is shared by at least am62,
am62a and am62p.

The original function for testing was developed by
Akashdeep Kaur <a-kaur@ti.com>

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c |  5 +++
 arch/arm/mach-k3/am62px/am62p5_init.c |  5 +++
 arch/arm/mach-k3/am62x/am625_init.c   |  5 +++
 arch/arm/mach-k3/am62xx-lpm-common.c  | 85 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h  |  1 +
 5 files changed, 101 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 7de234611639d119db5c7a718738a02cedf8028c..c1c7d669a45f53b7528c80d44bf9b914fed1cc10 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 #define CTRLMMR_MCU_RST_CTRL             0x04518170
 #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
@@ -101,6 +102,10 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 4c215d5cebed5930bce70bdc975fe31c437ce82b..a74fe3d23d7c4b66ac95aa5a01c2a32a586e9ced 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -15,6 +15,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 /* TISCI DEV ID for A53 Clock */
 #define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
@@ -160,6 +161,10 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 02b7414e21cd56faab795fe7b39eefcc67cb044a..d2deecb16670739cee20e2e525688ba61a434872 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -16,6 +16,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../am62xx-lpm-common.h"
 
 #define RTC_BASE_ADDRESS		0x2b1f0000
 #define REG_K3RTC_S_CNT_LSW		(RTC_BASE_ADDRESS + 0x18)
@@ -201,6 +202,10 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index 424d7457c596290ef48acd7f7aec3fd192dd3000..54d86b0474df691e8568a9c38530c56cc1eb3a0a 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,15 +9,93 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <wait_bit.h>
 
 #include "am62xx-lpm-common.h"
 
+/*
+ * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
+ */
+#define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0		BIT(6)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0			BIT(8)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0			BIT(16)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0			BIT(24)
+#define WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK ( \
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0 |	\
+		WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0)
+
+#define WKUP_CTRL_MMR_PMCTRL_IO_GLB				0x1809c
+#define WKUP_CTRL_MMR_DEEPSLEEP_CTRL				0x18160
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x18300
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x2aaaaaaa
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT		1
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN		BIT(0)
+
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
 
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
+
+static int wkup_ctrl_remove_can_io_isolation(void)
+{
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE +
+					      WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+	int ret;
+	u32 reg = 0;
+
+	/* Program magic word */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW << WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Set enable bit. */
+	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Clear enable bit. */
+	reg &= ~WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* wait for CAN_ONLY_IO signal to be 0 */
+	ret = wait_for_bit_32(wait_reg,
+			      WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false,
+			      CLKSTOP_TRANSITION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		return ret;
+
+	/* Reset magic word */
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
+
+	/* Remove WKUP IO isolation */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+
+	/* clear global IO isolation */
+	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0;
+	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
+
+	/* Release all IOs from deepsleep mode and clear IO daisy chain control */
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_DEEPSLEEP_CTRL);
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
+
+	return 0;
+}
+
 static bool wkup_ctrl_canuart_wakeup_active(void)
 {
 	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
@@ -36,3 +114,10 @@ bool wkup_ctrl_is_lpm_exit(void)
 		wkup_ctrl_canuart_wakeup_active() &&
 		wkup_ctrl_canuart_magic_word_set();
 }
+
+int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
+{
+	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
+		return wkup_ctrl_remove_can_io_isolation();
+	return 0;
+}
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 36dcd20a9b802bb0eae8dfa56836e7da70107e62..2d110bcca0fc74ecd5424ae288d43519d0c05908 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -12,5 +12,6 @@
 #include <asm/io.h>
 
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_ctrl_remove_can_io_isolation_if_set(void);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.51.0

