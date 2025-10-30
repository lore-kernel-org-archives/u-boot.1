Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF205CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B6E83948;
	Thu, 30 Oct 2025 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HmTPuy/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F704808AF; Thu, 30 Oct 2025 11:01:32 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62893832AD
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso4394585e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818490; x=1762423290;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJUKJE80/7HD6ysNrtBNqdLIKq9xF+aWkc8p26kDsBw=;
 b=HmTPuy/TmBuKV2QHhEpo92C13PQUtveQj/2/m0ioercN9VGweoJXTJXv6SPVbPeWvi
 wcAGfffWHR1YODA49n1C8pU9rscOym4n1eJldS5iYtXxXJxElAwmnCdUbPhHGWwD9wXF
 iNrGsDFUd03/5vxwZlkMLL/eCPnNdFkqoKxHbgmUKj7QekVg8bCO+DC8l90oUqgcZFR2
 6fwU4ZOsrtrRnBkaDBrJAS7jqTLA4Onx8h2Kduw+jFOR6g/AkVuerG3Ex+u4fUNOiRjZ
 m4vIBNpbEKIWjfpjfGp4q9Sp+nyouaVuZWg231Oel0XEsl0hyuedZ7WwDqNJYuYpAln/
 OlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818490; x=1762423290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJUKJE80/7HD6ysNrtBNqdLIKq9xF+aWkc8p26kDsBw=;
 b=ZyQz3aH8PpNVrHxqJ5+OyodI3wKMCuvTGzTna2Mc66yzhqSSF+okAF54fNiZB3ghBW
 Y0qDqwxw5UNsWErSi8drJfQQDPY9++h4zv8KY/pWDdYvbxwRnrPb1nn28RXvZR+o7xN6
 eZqebXkh0gcPUqc+wna3Trbb1nxUuGIdZHZYF178H1b9JLh+f8UEgBqQtE8G0zfv2sos
 9MrIXO1Dkvyap5VYH/mcCBh0tu+8sgylZm03DGfOUd/naPaJJ7BZqD+Fm5i6M8i5EMS1
 CR//VcmcgTmz8+p3ePTHcnsu9zlB0FA8d/3eG2dVVTz0HwoBpGBIwqaZ2T/1KLDqJhPn
 +hew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7BA988/a1xin850BPEO+6ZNG6nU0YNxaVLH+YaBPMSiETi/cif498r55DYAfx2r3KpT2217A=@lists.denx.de
X-Gm-Message-State: AOJu0YyvhI2FtVrl4IJzoY5pFZ3wb2dXN3PbpPM8Pf10ymLa7Uc45FxR
 2Fi+67xQb2T90/9w+GFRN7fveaj90l0SD4aNCBIxx0sRQ+ZhQXgWtgjiHiuFyXMHibM=
X-Gm-Gg: ASbGncuSHQdmTS4fkeXVMYpikF47Xzlbg0VYnwD4RLoc7f2INxyyTxdDU+ahAbNtAuc
 GabU5pKgiFl6MMUw+OqU3jb7o7L4CgjTTWmbzmhgPwWcf8EWvtOaAwtJcXBBLDPnzM8uU5/JvLS
 M9z5ar0Q59YdTcBpCvsD8xYflnBmKoODz7OLx/pDzHFCzMFst+skZ2fW5D5ePlwVliaOEoTy3zQ
 cElAjJQr/0YxnmNEhpWCLio/sMbQmcVUid3z92KC68kAshgTUFMZueC3qKSaIr4ZorzuS73Jqqe
 5Ohh7zeGQUZjL0XtfZ8CcnBy9SglFv7hjU7w9FdhlupLA/JBRFEi2PvCTYVr1SkWNxrY5wV2laZ
 9FDH8wlFRsxfkPKVObYeS/IGD4rVQoHoDUCCEjP7bpA==
X-Google-Smtp-Source: AGHT+IHut8/+sLZnMkLrNfw/44QxUdUJ/7bGoZGwDAp0kzqWigMEMPyTg/dD+LYyq1Mw3fyLV7Aclg==
X-Received: by 2002:a5d:5849:0:b0:3e5:5822:ec9d with SMTP id
 ffacd0b85a97d-429aefb9b8cmr5236484f8f.41.1761818487612; 
 Thu, 30 Oct 2025 03:01:27 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952db839sm32826482f8f.34.2025.10.30.03.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:27 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:19 +0100
Subject: [PATCH v4 01/13] arm: mach-k3: Remove CANUART IO isolation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-1-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7626; i=msp@baylibre.com;
 h=from:subject:message-id; bh=yIPvuSPVbyC42A/U8z6UCyIbuZGJcqht2JXplL14iF0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc6at6061Jyx5bGbnuINP6omeqa+nWICJirrfisIL/
 y9fErrUUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPRWsrwV6iSZfm7tYcM99/t
 WdGYXt6X4/Hipts/EReZnOvTmJ+u2s/wT/u7FJ834+mWbTfqIyZclEwzLMkU7Dq2Yvls7ssFjQ4
 mHAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

