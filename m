Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D4AD3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F45283CE3;
	Wed, 10 Dec 2025 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ogXm7yOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78936836C8; Wed, 10 Dec 2025 15:10:55 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6B283869
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b728a43e410so982885766b.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375853; x=1765980653;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=923djpRvqHUo4e9IazfdbMj2XEPWPe9M5XMOA3yukrI=;
 b=ogXm7yOuo81FjwNQb/g+XZjL2Q+JzkC9nvH8DxINb5V3qHGuCITfzHOL8gOTQydGSD
 c+t1J7k4gNkFXRsytUPnZahsuGmwEj/i8yq6lfR4FLWdpwkpeEdUbezG4ALuhA2DMyvj
 /umYHhfXB21YBZJGY7XtJerr7wGy7W78GWf30qyoNKDAnvPVIVluRRgepDY1f80mjn8l
 PcfTkPlBX7STEYxx6eyVPndTDzrJoa/Jd5Zn64JFqfqq2zZgbAjrYZ0xOsQT5zUDlhSk
 7CImrIP0qQR2txBMAMjYnrC4J7zZ0EEak5H6NUJn18PeP0Mf4TXhdLziMVH2cx3xlq9S
 q3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375853; x=1765980653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=923djpRvqHUo4e9IazfdbMj2XEPWPe9M5XMOA3yukrI=;
 b=W7/pBlbh2OKZ24LxuwdWSafqEI38gWGCAI3+oTqUDyyI49aNasigYB9Jx8YYbSbdt8
 lIUjVlol/c2/gb5Ssx2zI1t972FraGG4xMcI0dtQHzolmtGs+zYVUm2aU8FAG98sehqJ
 P83SJY7hfCO5jb25CyKkrJFb8vBRDplMipPPkDAau/dmK7UZpDowehHHx7Ekv1ganRBH
 2lHKk2k4liPtQNMndfVkWHHjJALy7Jno/Fy+ek7Jj5FT2+bwvz3n33OcQiexKZyUVYOv
 HAt08EoOqbVsLi4jnJrRrKTkEM90h6f99pFq3+D6q2lCBGETsaipIfxJMlWFKVRlheMe
 ix/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVeOuSwQwW5FPz69nOcCdEz0D9NwFOMwVblGrmLneZ3RUqxP5hGwdj7mj9uBii0QZCP+WZv2o=@lists.denx.de
X-Gm-Message-State: AOJu0YxgkB64k3m0Nnk+c7lWvNs1mko3WNjP6xMLx/TpdY4E1MAgaGF8
 uGKkYjkvzjARbLfggqQ0mU/pTON10WVkFXefLYjl3FRUAO3oyeUiITwaKwa1CODGlKIWaMmcX1z
 g+5SR
X-Gm-Gg: ASbGncvSbuZzhY0+zanEYGySkvHNgCye1SRcleW4AYeLn2GTQCeMY/k2aJvTp8jvV71
 dCdWj1IPBRjFqy4Hx0aFzktaASL9DOaY9UaH0uAHj6oG+L5FbZmo/BkPik5zey56hOS2FkQJrCv
 NxMPA26giCmlahtohZuymRyMbT5hm/G256cDCyBHAUWin17ik9reWnkFklugGvlU+N+gG0s9JjP
 bxpC9ypK3eFBjBgs7qRMPyzYG3KWp/54b5XmGRykWpl/abYZ9XgNc9FmN0gUAA7/KaAu9NrJoQz
 5CUdEI3alo3fWtSXXGtUew16gdgK/63UpbyhRpytXYZ1lo9GP5Q3owxAhZkeoNMVp26DM9//3RO
 bkYwd1lJ4Qfp7f6Cp1E7s1iatsTK7MZf5k78jL41ZtZa225Mz7OQe+hD/ukg5459pMYMT6eu8q3
 YYpBzla8kd
X-Google-Smtp-Source: AGHT+IHhoaGmWY0nWjlhr630gc2dZagkRsCGm65y4JXiAeroYF6Qt7c/w4WvDK9/TsgJohcfnbkTqw==
X-Received: by 2002:a17:907:9605:b0:b76:791d:1c5c with SMTP id
 a640c23a62f3a-b7ce82b7186mr235646266b.9.1765375852623; 
 Wed, 10 Dec 2025 06:10:52 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7a01a33379sm1540203566b.62.2025.12.10.06.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:52 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:08:57 +0100
Subject: [PATCH v7 03/13] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-3-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8157; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zM5trevTw18uuDZf/gQ2b5uPitFoLxW1mIJKPU/gfgQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLeuEdpo9FmuZy7r80f/OLFdump4VJNOv/T+m9nrWj9
 +jFCzLJHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRDeoM/8OVzVa6SPRIL21R
 0lkjceVv5cJGHuarAiFXD39W/6XWuIWRYf79S0xbVadeCPr68K7D2Z/7Unperapdvk39O//z/56
 zAtkB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  4 +++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  4 +++
 arch/arm/mach-k3/am62x/am625_init.c      |  4 +++
 arch/arm/mach-k3/common.c                | 59 ++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h | 26 ++++++++++++++
 6 files changed, 98 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 7de234611639d119db5c7a718738a02cedf8028c..24fdfdd7f1d9146f0cb6dde333d2bb54df96700d 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -101,6 +101,10 @@ void board_init_f(ulong dummy)
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
index 4c215d5cebed5930bce70bdc975fe31c437ce82b..976bbbeb8747f9ddddd78b3f8d7f3787c5bfd576 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -160,6 +160,10 @@ void board_init_f(ulong dummy)
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
index 02b7414e21cd56faab795fe7b39eefcc67cb044a..318159147b08f682082e9c5cb69a3c124659730f 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -201,6 +201,10 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	ret = wkup_ctrl_remove_can_io_isolation_if_set();
+	if (ret)
+		panic("Failed to remove can IO isolation when set %d\n", ret);
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index a80cf87ce65a44c386539ade17c0f435e09de841..81e180c8706445c270cfecb0500015eee7547f98 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -33,6 +33,9 @@
 #include <asm/armv8/mmu.h>
 #include <mach/k3-common-fdt.h>
 #include <mach/k3-ddr.h>
+#include <wait_bit.h>
+
+#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -115,6 +118,55 @@ void mmr_unlock(uintptr_t base, u32 partition)
 	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
 }
 
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
@@ -134,6 +186,13 @@ bool wkup_ctrl_is_lpm_exit(void)
 		wkup_ctrl_canuart_magic_word_set();
 }
 
+int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
+{
+	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
+		return wkup_ctrl_remove_can_io_isolation();
+	return 0;
+}
+
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
 {
 	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 55fe1f06d8b04a0bc27a88bb63a1fdc0b1eb383f..a68924a2123961642b63401f3600ac825fb62da5 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -52,6 +52,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_ctrl_remove_can_io_isolation_if_set(void);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 6f425d03be5d9cbc03a0daac5e9b10fadd176335..8b5698ba8e99e32d9b41e8e476ed433481726b8a 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -117,6 +117,32 @@ K3_SOC_ID(j722s, J722S)
 #define CTRLMMR_LOCK_KICK1			0x100c
 #define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
 
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
 

-- 
2.51.0

