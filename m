Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B8E69160
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B6D83E70;
	Mon, 22 Dec 2025 21:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uTN0sM3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D044783EC0; Mon, 22 Dec 2025 21:02:56 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54DB283B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so22981975e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433773; x=1767038573;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RHXPZe9dbcdOmSXhq8dWJDr6LjV41dKHJL0H+2mhSJA=;
 b=uTN0sM3qouKjyUi2HCUfVEwrr29/RR6InhhA0/dOjIo+MOrl+2b+Pq7Uy8QE2GbDdk
 ZVbHSqS6QgqVvyP1AABN6DHDduUK+420Jh0YAFFo3o/u7jf7GOdcd5AQ4dKy0QYtqp5J
 MRIV33Wx9EhcbbWkR2e6A1pgliV9KvLNFwGqCiUMypTWRorCal5RDtiflJNvlF1SUhqZ
 ZFuymDGwhcvK6VxVYo4M7OamX5DVBuUl52T+29fre5x5kmrvQx4LC9YJKPmBFc3fpgxb
 fSLKNeS0lyVOqFmVMR79f/ufo6eJ52YlFlvyYB+Y/hz7fqJZXg5SnxwV+ikRk5pezig2
 bg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433773; x=1767038573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RHXPZe9dbcdOmSXhq8dWJDr6LjV41dKHJL0H+2mhSJA=;
 b=kDLZQwNzybBeU5KV9wyTC5y166T31DPta82/Yhu6TyS5LJsorBgqkvf7aKsRkR8w6R
 WP3yJ8P7l+QYhbJnnOnSypxkwTtWLWkbVD3t+/KTLaVF3L5s6urZjSItR8pKSr6fNCZa
 bofBbUaAQe+YrJOKZfdjcQRGZzuTWITAEOGl8yMVDTHFM9mD+cBqsmj4424ofzfvNUgY
 CVR17ylJsg97tqB/BbtgLcjUL387E4mCPwX4V9Cw1baQAryVT402Y9WRgotHS5dQkokX
 enUbk1qbW+y+0olbvsYFCtNViy6yG6EDYIES7b/x6ivYeU85p6jiDdzHI9TemPJ/qus6
 e62Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGpBnspay1RhcWkBjEpZcwDG8djdUbCJtHbmotIKqzu8UYhVUGdJe4aAO3HqEEiVK2ZRf6Rzs=@lists.denx.de
X-Gm-Message-State: AOJu0YwqkhTHPeii6t1pT5mrIVoetBNzqBF9N/JPFAvt6PigP3nkG0NU
 sHQaqVT4Q77I0o9w6ARHJsMdRjRq1WpC2zmPliQxlvdjzIs67hViVkvTbgSwGlWZ9pQJWeRd6cU
 R/EpN
X-Gm-Gg: AY/fxX5TLlSY5cu+I+JB6dzf+MjdY05bjMWHz9fMBeqJLLB7j1gPavQ/FXNm4NzLLW4
 o8UCegMKGLKMBDKbfTVAP3Gx1vpwXXbYncoQBsmr2tyMS/iWhEo4siQavTBT1dKIrzJcxtC4T9Q
 6T0PPjoZydfpq04Qye/UkytqGa6LRx8w74S9mku0so3gEMtg/VEz1gINUA5NjuSWbop1cxJMA4d
 GcpLwXoh4QFhb0ukX4cQz4v3I0HnpeGnjxYAwI3TS02X5zCbAVqxmlAF0ODy2RtIYi9mx8wBpPu
 e8LWAE1zsxJNFO5LIt0O51ht9VfTNuLlYhKqGOTm6QjRtyJIc2wQ3cF/3H/wqCK2SB+5Qqcf4cv
 W//K8GGhY+d+p+LRtpmZOd+irzWH2sLsGRvJe8+J+v376RNNYLTj16F1csKmTNfexKSd8XO6NJT
 0LU3rD4Dqr
X-Google-Smtp-Source: AGHT+IGqs19IGX5yz7M27XmzM5r7Uug5DVuDJ8wWof5LQfw99XC/s1dHzo8X2NVd1dm2lk6xzOO48Q==
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47d1959d1d8mr127739235e9.32.1766433773123; 
 Mon, 22 Dec 2025 12:02:53 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm255164185e9.4.2025.12.22.12.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:52 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:25 +0100
Subject: [PATCH v8 04/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-4-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11775; i=msp@baylibre.com;
 h=from:subject:message-id; bh=d1zdUs9OSougRzOX5s5C+tdgdJfeL5FyL+hT2FBVj64=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxWvXZ6trnr/w+fh262/ed9ynn16/pySipLzwRseK5
 bYN7a/Od5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBENs1nZNghWSa97Za2JN/N
 Q+wuHGfD5+3+9VrZ7dor2eccWxvdC1UYGXZ/ZV+QK/Po0yYp1U+Vmj+91nYqRXnax+zunXTlyLV
 ViQwA
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

In IO+DDR the DDR is kept in self-refresh while the SoC cores are
powered off completely. During boot the normal initialization routine of
DDR is slightly different to exit self-refresh and keep the DDR contents.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/Makefile       |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 181 ++++++++++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  20 ++++
 drivers/ram/k3-ddrss/k3-ddrss.c     |  26 +++++-
 4 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
index 823d1887178174021778296e6626cadfd11170de..8a2ece1c27eeae51593467259337483a852f5f85 100644
--- a/drivers/ram/k3-ddrss/Makefile
+++ b/drivers/ram/k3-ddrss/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
+obj-$(CONFIG_K3_DDRSS) += k3-ddrss-lpm.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4_obj_if.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4.o
 ccflags-$(CONFIG_K3_DDRSS) += -Idrivers/ram/k3-ddrss/
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
new file mode 100644
index 0000000000000000000000000000000000000000..20181d0a876dbb723920efb78ed980948eec117f
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <asm/io.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <wait_bit.h>
+
+#include "k3-ddrss-lpm.h"
+
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL				0x430080d0
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1				0x4301830c
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT			0x43018318
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
+#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
+#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
+#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
+#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
+#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
+#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
+#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
+#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
+#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
+#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
+#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
+#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
+#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
+#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
+#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
+#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
+
+#define AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS	5000
+#define K3_DDRSS_LPM_TIMEOUT_MS				5000
+
+static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
+{
+	u32 val = readl(addr + offset);
+
+	val &= ~mask;
+	val |= set;
+	writel(val, addr + offset);
+}
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg)
+{
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_169,
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PHY_1820,
+				 0,
+				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_106,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
+	writel(0, ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_150,
+				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_6,
+				 0,
+				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_21,
+				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
+				 0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_20,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
+}
+
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg)
+{
+	int ret;
+	unsigned long timeout_start;
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_160,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
+	ret = wait_for_bit_32(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
+			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
+			      true, 5000, false);
+	if (ret)
+		panic("Failed waiting for low power command %d\n", ret);
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_353,
+				 0,
+				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
+
+	timeout_start = get_timer(0);
+	while (1) {
+		if (get_timer(timeout_start) > K3_DDRSS_LPM_TIMEOUT_MS)
+			panic("Failed waiting for low power state\n");
+
+		if ((readl(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
+		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
+		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
+			break;
+	}
+}
+
+void am62xx_ddrss_deassert_retention(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 0);
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+			      AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			      true, AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS, false);
+	if (ret)
+		panic("Failed waiting for latching of retention %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+}
+
+static bool am62xx_wkup_conf_canuart_wakeup_active(void)
+{
+	u32 active;
+
+	active = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool am62xx_wkup_conf_canuart_magic_word_set(void)
+{
+	u32 magic_word;
+
+	magic_word = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
+
+	return magic_word == AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool am62xx_wkup_conf_boot_is_resume(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		am62xx_wkup_conf_canuart_wakeup_active() &&
+		am62xx_wkup_conf_canuart_magic_word_set();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
new file mode 100644
index 0000000000000000000000000000000000000000..742d224327e45b926508cf6b1fb14f4f7323cd76
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#ifndef _K3_DDRSS_LPM_H_
+#define _K3_DDRSS_LPM_H_
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
+void am62xx_ddrss_deassert_retention(void);
+bool am62xx_wkup_conf_boot_is_resume(void);
+
+#endif  /* _K3_DDRSS_LPM_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5144470b931384534e78fbfcea5e66b7083c9f07..27823e91d5efbd7e6629f60921aebc6c834f6989 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -20,6 +20,7 @@
 #include <wait_bit.h>
 #include <power/regulator.h>
 
+#include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
@@ -119,6 +120,8 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool (*is_lpm_resume)(void);
+	void (*ddrss_deassert_retention)(void);
 };
 
 enum ecc_enable {
@@ -866,6 +869,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
 	u64 end, bank0, bank1, bank0_size;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
@@ -873,6 +877,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 	__maybe_unused u32 inst;
 	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -880,6 +885,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	is_lpm_resume = ddrss_data->is_lpm_resume && ddrss_data->is_lpm_resume();
+	if (is_lpm_resume)
+		dev_info(dev, "Detected IO+DDR resume\n");
+
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
 	if (ret)
@@ -895,12 +904,21 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
+
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
 
+	if (is_lpm_resume && ddrss_data->ddrss_deassert_retention)
+		ddrss_data->ddrss_deassert_retention();
+
 	k3_lpddr4_start(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_lpm_resume(ddrss->ddrss_ctl_cfg);
+
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
@@ -1020,12 +1038,18 @@ static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data am62xx_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = am62xx_wkup_conf_boot_is_resume,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+};
+
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
 static const struct udevice_id k3_ddrss_ids[] = {
-	{.compatible = "ti,am62a-ddrss", .data = (ulong)&k3_data, },
+	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },

-- 
2.51.0

