Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93B0CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280F383AAD;
	Mon, 10 Nov 2025 21:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IqMY3UML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8481783A98; Mon, 10 Nov 2025 21:11:42 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6378C83AA1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso528830266b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805500; x=1763410300;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SDisJLmcA7K4baTvHZIaHLscN2TVSUxPwLAViDIcFbQ=;
 b=IqMY3UMLLaN+c4wQZfxEH0XacVbphPD182zK1pJ/2k9kc0FQKksUMcIyzELKluVegG
 Pd+bfOaFD3eKs0IZufWxnfOA1Txw97Ksf+ZQQ0ILf2ZAklrBa5L1wlbVDNMqYx3twHvZ
 GWmZeCaw6sBXPXCw25XGICEzmMFyXxXmT5FKbr3sEHuQfkTkFfRVvKVrhtMMxL6s4uNQ
 RTecXXvoupssltIMqXBHBZY+aP3vCGwPDzpmBWAklWS6HBvZWBeP74AgwcXLEzAbTrSU
 8bJTnHOoxzbFNrTygjTLb1QJA4S0iiJq9O0Lr1WdGFB0Dhl7bht08lsIugRruiVY9P3O
 Mpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805500; x=1763410300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SDisJLmcA7K4baTvHZIaHLscN2TVSUxPwLAViDIcFbQ=;
 b=dRkonqI5JSLmgb95y6TTY+hJQcQvqBPvXIrzgpI66l3UIO1A+B3scsR3b+hqmIMN7t
 Bvt7W1mxU9oVBaYzwwc8YllCbzxx7vwdXD/fFmPEM1Sy1hUGF86+rW0opEmkoPXOQHsd
 LQmBsjA6sjuuiRMW/pV4R0qI65W9MdtGSMiEr+FeHvnbNfMeEOL1OEJXuqy/XbdB/y2d
 ghRzrLZAZEFcBLCnrLC2zXbvaMD+dFI1w0Vac7rNmuf/qlWwlZ4ClcGg6O9P8GoKXHzu
 tJqMBuqz7Dsrp6nsheynV++1zRrt39MI3RUCspJVvBZFvQXwEiqskaLC4Xbp4Ibu7l/i
 lCuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU07cPVpkfapsv59j4KftYkOVACpUZ/L417Bg2zYyZIOtkVtBeDqNDc/WesD7BBnfw/mb8bHHc=@lists.denx.de
X-Gm-Message-State: AOJu0YwTmr8PvXTzLfAfCOcflCs7VRsBXdjelXPKWJjIhXZ5vY6/xH20
 13vHb8D13pkZ3nqSwmHF3hWZnNM0uBfZahmT1w0hLGiks+HV2Wf1FpLWAvPQAyQluKg=
X-Gm-Gg: ASbGncvIcjmWNOe2e4yd3uZdVbcknY/zIRZ2kxNiCiMfgiabWln7KTww27S/1oht15Q
 YglBaCiLibqlgSiWfw2xjJ/SIJwRg/xDTLAVTBV89H2O6DrWKAws86jrMi+rp3DXNRVP8chTQ81
 OmZzpOFz/NVxRcbUkXa1wSc1UQQ5i9ZgeMXb1zcsScGMRxUKsh8MtUIKywQ0XeMsR+adTRHpZk/
 Rn3Na+Hza1fX/q6ZHeD7ElbFXoCru65vj/EFHmwmwlP8h1q1I8ec52+YNkavrqw2K3+C3hu0sLm
 Sd5mIgCgllKpFQ/YzEuuOGkDqsTdbxLI9pfXqJnO9hQQeQuwlPC+JdAnrkIC+HLCGhDoSnMfegL
 bocHga6op0Nv1BAiNcVhQqv1NQZHQGC20hUnRH4Z84QQTUnIS6IS8lii06imoXRun1wTE0yyfJP
 jEwrWtWA==
X-Google-Smtp-Source: AGHT+IHVhH6pv7/YKGZGjajwrX9eDArrVzdu48w/zfPI49m5OjTl5ybnibXpf+xU8PTileSzifFwRA==
X-Received: by 2002:a17:907:7e85:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b72e0547d84mr982052366b.61.1762805499710; 
 Mon, 10 Nov 2025 12:11:39 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf407a22sm1168699166b.29.2025.11.10.12.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:39 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:25 +0100
Subject: [PATCH v5 01/13] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-1-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7668; i=msp@baylibre.com;
 h=from:subject:message-id; bh=B4XFtAqKGQ/Mry4W/vnrhcuAzRarALEZTryNZiOttvo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwhtx1Nb1e/u/hSUF1Xa/I3ISUZxmqFKZ46rLESPBc+m
 1RyWH/oKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIl49zD8U6jcXXNygeS5v5fC
 041eeaoyxCeGHJvX5hB8dllXkyLfY0aGF7/nSj66cDfpt+d5tybvfaLax0wuvugRijCzPu4jcaG
 GDQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c    |  2 ++
 arch/arm/mach-k3/am62px/am62p5_init.c    |  2 ++
 arch/arm/mach-k3/am62x/am625_init.c      |  2 ++
 arch/arm/mach-k3/common.c                | 56 ++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h | 29 +++++++++++++++++
 6 files changed, 92 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 48d578e7d6f180f06b42003313bf643c725eae7e..60645272c816023798cc5d6fa46a2c569143343b 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -101,6 +101,8 @@ void board_init_f(ulong dummy)
 	/* Init DM early */
 	spl_early_init();
 
+	wkup_ctrl_remove_can_io_isolation_if_set();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index aebd5200b0db9959805d04408b34d283e21b6e2c..1c47debca61598ecacae03d83b4001a72dda164a 100644
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
index 14f93ac998f7d11997b753550c0ea38926e35e64..6eae8929ef7722ff46f67c82d2e17eff618eaff2 100644
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
index 7c06764af8256b7fd27f8e7f208a597b1b91652b..b4a605503d27b29d0fb962fbe4c94650a1f6c54f 100644
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
@@ -115,6 +118,59 @@ void mmr_unlock(uintptr_t base, u32 partition)
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
index 52d3faaab5c94578cf4f7e288cbf840500d490a1..49417679e2ec7210d5c95540f476a5d8ee548617 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -51,6 +51,7 @@ struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
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
2.51.0

