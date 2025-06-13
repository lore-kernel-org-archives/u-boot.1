Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CAC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 13:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2AF82CE7;
	Fri, 13 Jun 2025 15:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vqVnPUwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E8382C30; Fri, 13 Jun 2025 15:21:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1247682CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60780d74bbaso3618344a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820915; x=1750425715;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DDwC3Z34l+LgCH4mZLti2wJ7iLBe1+ge845DIiFp5pY=;
 b=vqVnPUweN8vKCGY3GoDVVmtpT1C9jqGssTexW+YJHoKsTFuGzPouCXK8KR3UhDjogw
 mwJoOV5cczqmDQ7CBvntbrc8zy4Hn7l97/3p1bXptwLbIiNO78FanVxUfj2XKbEJHwKo
 BUuIgxte/PT0W0r/O/MI+hNKqwOhG85XGrYQAGfxXYSMeD+fGEFZGZtgPScKbIME7OJ8
 w/n687MKtBbBs8lNCiAUERWD1Mt1z2io4i8Fqlzp7d5CVt2aIeMyOlrSLSk2EkvU4Fnq
 aQ9KNW679IODTPfLUvRwrDjA/6DY7Q9hswIj1W7NlLTyA4kcQq3pyaFYkn0dh0J3vuJ7
 mrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820915; x=1750425715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDwC3Z34l+LgCH4mZLti2wJ7iLBe1+ge845DIiFp5pY=;
 b=LK4Wd0oyvFFqpfR9ZR053EDP/VPmh4Kmq5hx96zwlzxwE+UYdC8kAfSYbJjArXK9HJ
 dnB5n14o5P27eYGPU1BYM3x7mXv1/8Nf9ST/FiUjt+pTdakV+1wRG5aQSwqLqcOG0/Dj
 32ojlQVjYlP9DUV2+tmHPSHfMTixy02bsHRGsH3BA/c4lI5e8FMmyGIsFJa6btqvGPK1
 yNHKaqxTkUE4oHujp+hCHig9cZDH2nGbfEeXD899Oei89kAjzlawgXd1Tz8/MlXYWrum
 C1/HlWJpOGa0focRX5yEiZMJ7cgJCO9qPtM2fDZBBPxBHnoHUa1gx65CDK83fpHIT/x3
 T0wQ==
X-Gm-Message-State: AOJu0YwctPDhioxArJkeohdtJzb7lewc5LDp2wnFF/qpH6shZLYoqZs2
 heoE1oh8k48rPGNrjrjCZdIscwuG32/ZrMomkWTiq+loOBMB1vRbBVArH5Ttw4eEDnuZtA0BFX4
 N/k1j
X-Gm-Gg: ASbGncsBuFcEF6AlF8Wa4+9MhNyegVseI+aGAgdtbForWNfOou00GmC5T8amruGxtfa
 EyjdHEy3wa5QIqOMR/UB6wUcAhXtsxHL6jWa/F33xF7MvkeHvD7SdUMZNXFUTQAxp4bdhbASFA9
 aDuY7631/VCKtw2ttDAKN+ZtGSqJrbldxHc5IP41MmI1App1UZa0pFLuLMP+A4xvTyJmZlB7lqM
 R3xAkQ0EKwKQj4xaQiZw3JJ25NBF1HuQnlaShT5/C/4+A1IFfiy90cMJ71KsBeci1ROxsY0GOgb
 G4X/+HNZRnRlruCwOrE4778bVpUagHhZRBZQUxJhFDphOK2pQway4vx6bPs=
X-Google-Smtp-Source: AGHT+IGhZ5crMncFxub7eBfKLbUgYKzjRMdooATMYXi42Eo8yS3G/5o8R/BqqWp3DYzztacEayfXKA==
X-Received: by 2002:a05:6402:13cd:b0:604:5eee:6984 with SMTP id
 4fb4d7f45d1cf-608c6e16957mr696322a12.7.1749820915408; 
 Fri, 13 Jun 2025 06:21:55 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b48f2f8fsm1206120a12.27.2025.06.13.06.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:55 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:21 +0200
Subject: [PATCH v2 01/22] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-1-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7551; i=msp@baylibre.com;
 h=from:subject:message-id; bh=pBu1cmSBYboI2FLaw/w/gA9ns0DGhlGpkPVruRm8lb0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1coOrwt6nmwp1u5vTS45l70t2Xg2zI/3z91+1uOnO
 5Re/NLuKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIl4PGD4H7ZqRe7Xsg/6yxRb
 z30IeLyqyH5O91YDCasULcOEWeVuKxgZDi/kUpH/Wq3Cs9vsrch0iQemJ6+Kfw/um8RYELhYaVE
 yNwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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
index edd43a1d78daa600969f468cf3fbdbd0bc6892a0..d50de75ff669938c0803c0622d040fc1e5d0cf4c 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -102,6 +102,8 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 6e3c66e5107a2674ba8781272df8cf5f05338986..357012b3e52b4a381fb8592c7afb624d01583776 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -160,6 +160,8 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index a422919fab131a099b1f7786f2a84ca0a413dd38..9a5eb6e47249e18f7f4e3ded62d936490f2fec6d 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -201,6 +201,8 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 0323001d6d3746801b2c379a849c7b2e0d5b977a..517065bd3a18a5d28270e9cf2f552afa8acb1ed6 100644
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
index 02c74731feab84bd0b14375c30538bb7963e8d51..390a6fd41f6a30c9e7837342deb000d308fd802d 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -49,6 +49,7 @@ enum k3_device_type get_device_type(void);
 struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
+void wkup_ctrl_remove_can_io_isolation_if_set(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 81b5f1fa45ea30456a43c6640aad01388ea6a3f2..d7c759420524faf48ea26c66607c6a899d1321b3 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -117,6 +117,35 @@ K3_SOC_ID(j722s, J722S)
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
2.49.0

