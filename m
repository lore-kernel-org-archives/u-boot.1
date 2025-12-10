Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A9FD3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678E883CF5;
	Wed, 10 Dec 2025 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ARgf4R+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B5D83AEF; Wed, 10 Dec 2025 15:10:56 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69FD80077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso10964124a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375854; x=1765980654;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UOm4QBXrTqwfUDmgnKRShhjfVNA/3admPYZj5jM5wVM=;
 b=ARgf4R+m7iE/Qzr1rN6MOy/7ZvtjstuEEpXBJalobKk0wc7b51pPk3b9ysNVIYScpV
 7T1OcZEw4cFM3KHqM1ecGeL5c7+ORzU342eZsk9adSPQvcyPoERSs3XlaG0NPyjsPsEr
 QuczP9oxshi7qaRQ8XQwsb8+xo+2io2M+k4KwLuBDYCItF1liADxij+cpoktKIRIBLUy
 3zPm5k6Atnez7Wune1XYnymZ9jA4LZ2Si6HqER0v7h/EBcGUFcr+F7WkXMQbWE98Bly0
 wdOsjnNVNAvnqmrHUQ+kESHjPBsUF6aUAJXYaBkYH1+74fG8vIGCbXovlUUnd+MkkK5g
 tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375854; x=1765980654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UOm4QBXrTqwfUDmgnKRShhjfVNA/3admPYZj5jM5wVM=;
 b=irdQ8ral3SCEnGNYWwP0qpwPMiX5aNR2WbgMCBX/wdYH9IEFEcCsu/Ee+p0kXtkgF7
 Wx0X7LYmGJVnQZcS69HlqaXk7pjIFvZjpTiykcKHJL/KcwCj1Qd0+uNXSCPeXT50W4+z
 GhUwlrJ6CQkD+NTYx7rwzgJGyrMVrtIwzlnESUucKOrYm0LyzGagVJ/XgeJJppHrTwEm
 MCS64c304fkIyqB0fun8L3JUSzVuJLwR7cCY5YwCjhrVrc4rXOBivBC3bDub+yDQ1Hm+
 GXlMrTUA83zhZ7RZw9BL/fimC0BMwhGxF/ns9ug+k8kTr5HMuX3Xa+wJkTwoFNxRH4/k
 nscQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWANIDJnSEYKMxwpegAD1NG2HXQK7tDKCwFAszjAnV8CsrosTsdvRkop/A8f1fDeTwafpTURVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyXNePqnurNaGoqnTSNvg0/ofwGdQxkm3EH3FfDun91+F55p7D1
 gkbGifFtER4kXh9/oRz2ktAU9Nkd32ET0iCDkY/wFd45Wxk+x30gQ9pW67lqijXRE1iu5hP0de+
 gQbn4
X-Gm-Gg: AY/fxX6bDx5rjWQInd4AM7I9DVnr67xL4SzZ7oUmNeJKcjsSn0YmbNN2ULJ6IsjXwki
 m9Nh3UDvtvveNhn47YzvgS0cMWxxc//A566RyP2utZ6fiIEzJIXVxaAQiUQ7YhYZIKgJP8JDcDL
 FXDFMDL7wHsb0IY6/H0+EBnOVF2uZ5xcNgUzozoyHKxjDnzWC2nsm/+Vy2aEd32eN9c7Nv6fweh
 JeDMrwqZOkMM/Ijef5yZA7Sj9x3QIUBWvFxsSKBUYiWHYZtE5FZdOsmnrAnQ+rX8ziCmVH53b7/
 4J+1KSD5NkctTo5uNML7GgRG8wwrOxCzJ/1RJmclnsxxc/s7eoL1c3mJKoxM5S0NpKYER5YxuMF
 /Kocojzl3EntBclP23QdfKmbaXTyRbyil/zAo0gGVICwqP2DhwLU4X0vkoh72T0a2WwxTNaO0fH
 RCmoQ9znfW
X-Google-Smtp-Source: AGHT+IGRsj4sT96Vp4lVxmyy50Pjjn7U0ilkVKDRV6k+XsFGTV6Wqk/3xkPnwcbKPsPJQh51NK+SyQ==
X-Received: by 2002:a05:6402:210e:b0:640:b06f:87ca with SMTP id
 4fb4d7f45d1cf-6496cb62ea9mr2584120a12.6.1765375854097; 
 Wed, 10 Dec 2025 06:10:54 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b412deccsm16725278a12.32.2025.12.10.06.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:08:58 +0100
Subject: [PATCH v7 04/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-4-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9829; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5ArO/ENgRhQ6x7PBICF9ioxU7UrLTPYlHDHY7Jg2B98=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLeinmLaXuMvM4Za9kauc3P2lTL1g3o03h6oMKs1/+v
 2ZvrXHoKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInsMWH4791+fdHMhS8kNt4I
 ubplbsKH86oF04K2+O5c8OjgfNGyoJeMDPde3TT/vfHQs7vcH1OMb34PyNlQXCd1OSzpcbXep/P
 vORkB
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

In IO+DDR the DDR is kept in self-refresh while the SoC cores are
powered off completely. During boot the normal initialization routine of
DDR is slightly different to exit self-refresh and keep the DDR contents.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/Makefile       |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 175 ++++++++++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |   9 ++
 drivers/ram/k3-ddrss/k3-ddrss.c     |  16 ++++
 4 files changed, 201 insertions(+)

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
index 0000000000000000000000000000000000000000..2556632df8806623118c72cca55cfbf370211ae0
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL			0x430080d0
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x4301830c
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+#define K3_DDRSS_LPM_TIMEOUT_MS 5000
+#define K3_DDRSS_RETENTION_TIMEOUT_MS 5000
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
+void k3_ddrss_deassert_retention(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 0);
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			      true, K3_DDRSS_RETENTION_TIMEOUT_MS, false);
+	if (ret)
+		panic("Failed waiting for latching of retention %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+}
+
+static bool k3_ddrss_wkup_conf_canuart_wakeup_active(void)
+{
+	u32 active;
+
+	active = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool k3_ddrss_wkup_conf_canuart_magic_word_set(void)
+{
+	u32 magic_word;
+
+	magic_word = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
+
+	return magic_word == K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool k3_ddrss_wkup_conf_boot_is_resume(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		k3_ddrss_wkup_conf_canuart_wakeup_active() &&
+		k3_ddrss_wkup_conf_canuart_magic_word_set();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
new file mode 100644
index 0000000000000000000000000000000000000000..cb2c270b7b2e1fd57aa1cd8d696f15db5d9f04d4
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
+void k3_ddrss_deassert_retention(void);
+bool k3_ddrss_wkup_conf_boot_is_resume(void);
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5144470b931384534e78fbfcea5e66b7083c9f07..cedec616e23fa54d50bc3ad80413158518f0b0dd 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -20,6 +20,7 @@
 #include <wait_bit.h>
 #include <power/regulator.h>
 
+#include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
@@ -873,6 +874,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 	__maybe_unused u32 inst;
 	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -880,6 +882,11 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	is_lpm_resume = k3_ddrss_wkup_conf_boot_is_resume();
+
+	if (is_lpm_resume)
+		dev_info(dev, "Detected IO+DDR resume\n");
+
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
 	if (ret)
@@ -895,12 +902,21 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
+
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
 
+	if (is_lpm_resume)
+		k3_ddrss_deassert_retention();
+
 	k3_lpddr4_start(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_lpm_resume(ddrss->ddrss_ctl_cfg);
+
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",

-- 
2.51.0

