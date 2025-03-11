Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18328C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E57B81D67;
	Tue, 11 Mar 2025 14:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ytd1iAn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84BC801BE; Tue, 11 Mar 2025 11:33:22 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EF181870
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso7470966a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689168; x=1742293968;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2LhCGeiaiCEkRAR6QXYnQs8xI2ksOosHeonaAzrvW8k=;
 b=Ytd1iAn7ZoaVG4hHsnIMHfDdhBOYRKnOQ3CBIA9/GaMEvDWkSZmstR1GZMAiy9p91G
 K7W7vkV8B0dMXku46Auqlkya8LVmuKxpAMbm2Fmpvcv0JIrYfQ6q5ikqOlDnOAllsuZk
 xrfv7wqH0SKdZMWC/FcpSyIxosVqtFxWrt34UE8+fi4/fO+BuUZt3phoySc7smFoG6ZT
 EYyVWyxTrotvKbWO4c1DHUpAD/CRN/XXRr4N76EeOsTa95oaYxgCsumj6o2Oar6pQZxU
 gdl9OFXslH0lkDkQTdt9BlKBgSu/op/X5mYwAx0LHGHvr/kdIdWykQLxJSsxGuAhSuok
 ZYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689168; x=1742293968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LhCGeiaiCEkRAR6QXYnQs8xI2ksOosHeonaAzrvW8k=;
 b=bXWTa1WIzTb++Uh9eH9n5CSPDToHIthYn0egW3XlWN7xM0zzN2q/R/fBFBpLwEGOYm
 rA+6DksGOGk44BOQEcmi9/yM0AakasVpk+kor7nuZVSzlfYl3AURG/bLII4rH4ZYW/Qz
 SUGphsWXDu9zaDxfQxNtFpDaOrOeDU2hifRl+xO+MUbm8uzUKpx1qSjViYQA4Y43oOAT
 zvdgKtfH2jrSCSVTy4uGusmm5BifNsZ8vaBzr4DSU8BnM5mEcvL8omTraqh2Muxtl84M
 nob1kn9eG2VyZZL8f1olgj6gKl7bLHEnNO0JS99slPW7Pqff6vPFOOLIbHw+vwlweN3c
 017A==
X-Gm-Message-State: AOJu0Yxpbh/I2VtMEvEC+ibTIMg43t7V/xqpbIgcMOEgyvJKP6XYwiKn
 otFxLGUdzstgEfcuqA1z3mdLgydahoqrLxSZWjwfciMCcGUzhuj6Y9++kdynbayYmQ6PGlu4qgu
 0
X-Gm-Gg: ASbGncvaQJqKjonvdokaYA2NRFT+4kbfVciUKvrWpJGXXOxgBqiyjwZjIJXKz7iwc+S
 oW/o5eeWp9GAQJJ0dYn2VOUTiXFEjAR1SsOcP2Masig9o5pz2OoLZRuGBcGPpe/yy68NM3cfjH+
 0JK2mdEHoj5fYCA31gGSbaOiR83NR6rqA3ZCW+4LTi5dL4097lm2kYU8Vi5uTH3jf89HuuGM5Mp
 3wcAnYyfEDf7912l4lzVJ3+5VzrQYd2DWF3RBKXc3k1teRtK4VLQlGMnATs5aroBstI3fk0s3lZ
 0DN06cDv1mKnMzg7azqverFM/jvhzv024H+0uLCA
X-Google-Smtp-Source: AGHT+IFqu0O+I+rKvEgCMWeCW0x3QHVu3KAzdyIrmhlFLlUXmXrdVXPRO4cs5shDWOE5OvY/PEX8Nw==
X-Received: by 2002:a17:907:7f04:b0:abf:7776:7e0c with SMTP id
 a640c23a62f3a-ac2b9e21db9mr375192466b.33.1741689167562; 
 Tue, 11 Mar 2025 03:32:47 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac283e4d50csm493243066b.175.2025.03.11.03.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:47 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:40 +0100
Subject: [PATCH 01/19] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-1-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7549; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4GVyyhU2Oa6sRlZipfrd3iXQ21kl20wqG351LiVojlI=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCLzzMX2syrZY++nEmN+5Tm+sWO8Jekz+m9f6+e3/K
 d/aI+b+7ShlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmcvgnI8P+luXCWlYCK/pv
 HF8y9UjVRkP1rN6fCssD/c8waV5YtDqY4RcTh8ju6hib8CkMM5dfTTyjfHmmuITni9IIPbNDRx6
 nZnMCAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  2 ++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  2 ++
 arch/arm/mach-k3/am62x/am625_init.c      |  2 ++
 arch/arm/mach-k3/common.c                | 56 ++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h | 29 +++++++++++++++++
 6 files changed, 92 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 78153c97a58aff99dba8a76d915802be37d58745..7697e365c6ea1b9a4819fe813a63d4ee8fc9de8f 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -90,6 +90,8 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 7a24cf39c7b87ed9e2c7debbfc6889c29af2f1ef..a61dcaeb00f799a1f9c42f48d63c42815c4dcae3 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -148,6 +148,8 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 595fc391ac5aac4b5591cead15f21abf044165cf..87ec23e7869a43fe947a7fa646a950da6cff5d13 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -194,6 +194,8 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fa8cd93d664858560227f82d474d0a4d559338a8..ef40d623058072e89e9b3e53fc0f7ea6b78f96e3 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -30,6 +30,9 @@
 #include <soc.h>
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
+#include <wait_bit.h>
+
+#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
 
 #include <asm/arch/k3-qos.h>
 
@@ -78,6 +81,59 @@ void mmr_unlock(uintptr_t base, u32 partition)
 	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
 }
 
+static void wkup_ctrl_remove_can_io_isolation(void)
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
+		return;
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
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_DEEPSLEEP_CTRL);
+	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
+}
+
+void wkup_ctrl_remove_can_io_isolation_if_set(void)
+{
+	if (readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
+	    WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE)
+		wkup_ctrl_remove_can_io_isolation();
+}
+
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
 {
 	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 7bd72da1de8123161fac8891b5b7053d3294a107..0359fea5675bdaf8cdde7989eebac1a695a065ba 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -45,6 +45,7 @@ enum k3_device_type get_device_type(void);
 struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
+void wkup_ctrl_remove_can_io_isolation_if_set(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index b191d53a0f580aacd9283f06f057b47858864fe5..bd7407a4b9498207d94a35d8f73b852c7528a086 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -107,6 +107,35 @@ K3_SOC_ID(j722s, J722S)
 #define CTRLMMR_LOCK_KICK1			0x100c
 #define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
 
+/*
+ * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
+ */
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x18300
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x2aaaaaaa
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT		1
+#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN		BIT(0)
+
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
+#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
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
 #define K3_ROM_BOOT_HEADER_MAGIC	"EXTBOOT"
 
 struct rom_extended_boot_data {

-- 
2.47.2

