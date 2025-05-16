Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716EFC2D0CD
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 03:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948DE8294C;
	Fri, 16 May 2025 05:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="lDWXiZnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7216806D8; Fri, 16 May 2025 05:05:49 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EF38277D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 05:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A45DE260B6;
 Fri, 16 May 2025 05:05:47 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buSxf4lAvVbp; Fri, 16 May 2025 05:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747364747; bh=eF76KbDt0OCrmtKtV2JpxrjsOmg1fbELCbCkwmJ+exw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lDWXiZnvZhb+IFJLfzwZvyXnQ+PPgfAIB+dTP5MIXtS4IJpWXtL8b+gLZibOJaEVN
 CQ/7tjoruoT681/1p7u7iMh9igIfpVgEHGz+0Fw8edwortZJPvBQtaMO5eRL0dnu+q
 WWpzlT3J1/TXninu7SqiKIUlcJzoGChYpD7nY7bUQZ1ZokyqHxWTCDhcsO1fa47zs+
 z+bGqFHKIBQBBdGfA8B4s3vrdDEN0quyeEOgyK7bakYGr4Sloq3qScNRydU8tcWtck
 LmwxpTIH+nnUe3Xn16aMhTipmsytn4la3FBNyxEj1TtpYBKOQsauKm4CKMk0WDL61y
 O/XGyFLQVUu/A==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 1/4] riscv: cpu: th1520: Initialize IOPMPs in SPL
Date: Fri, 16 May 2025 03:05:22 +0000
Message-ID: <20250516030525.31361-2-ziyao@disroot.org>
In-Reply-To: <20250516030525.31361-1-ziyao@disroot.org>
References: <20250516030525.31361-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

TH1520 SoC ships several IOPMPs protecting various on-chip peripherals.
They must be configured before accessing the peripherals. Let's
initialize them in SPL harts_early_init().

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/spl.c                | 65 ++++++++++++++++++++++
 arch/riscv/include/asm/arch-th1520/iopmp.h | 42 ++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 arch/riscv/include/asm/arch-th1520/iopmp.h

diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
index aec398528d1..362fe895f86 100644
--- a/arch/riscv/cpu/th1520/spl.c
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
  */
+#include <asm/arch/iopmp.h>
+#include <asm/io.h>
 #include <dm.h>
 #include <linux/sizes.h>
 #include <log.h>
@@ -9,6 +11,16 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define TH1520_SUBSYS_CLK		(void __iomem *)(0xffff011000 + 0x220)
+#define  TH1520_SUBSYS_CLK_VO_EN	BIT(2)
+#define  TH1520_SUBSYS_CLK_VI_EN	BIT(1)
+#define  TH1520_SUBSYS_CLK_DSP_EN	BIT(0)
+#define TH1520_SUBSYS_RST		(void __iomem *)(0xffff015000 + 0x220)
+#define  TH1520_SUBSYS_RST_VP_N		BIT(3)
+#define  TH1520_SUBSYS_RST_VO_N		BIT(2)
+#define  TH1520_SUBSYS_RST_VI_N		BIT(1)
+#define  TH1520_SUBSYS_RST_DSP_N	BIT(0)
+
 int spl_dram_init(void)
 {
 	int ret;
@@ -29,3 +41,56 @@ int spl_dram_init(void)
 
 	return 0;
 }
+
+static void __iomem *th1520_iopmp_regs[] = {
+	TH1520_IOPMP_EMMC,
+	TH1520_IOPMP_SDIO0,
+	TH1520_IOPMP_SDIO1,
+	TH1520_IOPMP_USB0,
+	TH1520_IOPMP_AO,
+	TH1520_IOPMP_AUD,
+	TH1520_IOPMP_CHIP_DBG,
+	TH1520_IOPMP_EIP120I,
+	TH1520_IOPMP_EIP120II,
+	TH1520_IOPMP_EIP120III,
+	TH1520_IOPMP_ISP0,
+	TH1520_IOPMP_ISP1,
+	TH1520_IOPMP_DW200,
+	TH1520_IOPMP_VIPRE,
+	TH1520_IOPMP_VENC,
+	TH1520_IOPMP_VDEC,
+	TH1520_IOPMP_G2D,
+	TH1520_IOPMP_FCE,
+	TH1520_IOPMP_NPU,
+	TH1520_IOPMP_DPU0,
+	TH1520_IOPMP_DPU1,
+	TH1520_IOPMP_GPU,
+	TH1520_IOPMP_GMAC1,
+	TH1520_IOPMP_GMAC2,
+	TH1520_IOPMP_DMAC,
+	TH1520_IOPMP_TEE_DMAC,
+	TH1520_IOPMP_DSP0,
+	TH1520_IOPMP_DSP1,
+};
+
+void harts_early_init(void)
+{
+	int i;
+
+	/*
+	 * Set IOPMPs to the default attribute, allowing the application
+	 * processor to access various peripherals. Subsystem clocks should be
+	 * enabled and resets should be deasserted ahead of time, or the HART
+	 * will hang when configuring corresponding IOPMP entries.
+	 */
+	setbits_le32(TH1520_SUBSYS_CLK, TH1520_SUBSYS_CLK_VO_EN |
+					TH1520_SUBSYS_CLK_VI_EN |
+					TH1520_SUBSYS_CLK_DSP_EN);
+	setbits_le32(TH1520_SUBSYS_RST, TH1520_SUBSYS_RST_VP_N |
+					TH1520_SUBSYS_RST_VO_N |
+					TH1520_SUBSYS_RST_VI_N |
+					TH1520_SUBSYS_RST_DSP_N);
+
+	for (i = 0; i < ARRAY_SIZE(th1520_iopmp_regs); i++)
+		writel(TH1520_IOPMP_DEFAULT_ATTR, th1520_iopmp_regs[i]);
+}
diff --git a/arch/riscv/include/asm/arch-th1520/iopmp.h b/arch/riscv/include/asm/arch-th1520/iopmp.h
new file mode 100644
index 00000000000..3dc766b5bff
--- /dev/null
+++ b/arch/riscv/include/asm/arch-th1520/iopmp.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+#ifndef _ASM_ARCH_TH1520_IOPMP_H_
+#define _ASM_ARCH_TH1520_IOPMP_H_
+
+#define TH1520_IOPMP_EMMC		(void *)0xfffc0280c0
+#define TH1520_IOPMP_SDIO0		(void *)0xfffc0290c0
+#define TH1520_IOPMP_SDIO1		(void *)0xfffc02a0c0
+#define TH1520_IOPMP_USB0		(void *)0xfffc02e0c0
+#define TH1520_IOPMP_AO			(void *)0xffffc210c0
+#define TH1520_IOPMP_AUD		(void *)0xffffc220c0
+#define TH1520_IOPMP_CHIP_DBG		(void *)0xffffc370c0
+#define TH1520_IOPMP_EIP120I		(void *)0xffff2200c0
+#define TH1520_IOPMP_EIP120II		(void *)0xffff2300c0
+#define TH1520_IOPMP_EIP120III		(void *)0xffff2400c0
+#define TH1520_IOPMP_ISP0		(void *)0xfff40800c0
+#define TH1520_IOPMP_ISP1		(void *)0xfff40810c0
+#define TH1520_IOPMP_DW200		(void *)0xfff40820c0
+#define TH1520_IOPMP_VIPRE		(void *)0xfff40830c0
+#define TH1520_IOPMP_VENC		(void *)0xfffcc600c0
+#define TH1520_IOPMP_VDEC		(void *)0xfffcc610c0
+#define TH1520_IOPMP_G2D		(void *)0xfffcc620c0
+#define TH1520_IOPMP_FCE		(void *)0xfffcc630c0
+#define TH1520_IOPMP_NPU		(void *)0xffff01c0c0
+#define TH1520_IOPMP_DPU0		(void *)0xffff5200c0
+#define TH1520_IOPMP_DPU1		(void *)0xffff5210c0
+#define TH1520_IOPMP_GPU		(void *)0xffff5220c0
+#define TH1520_IOPMP_GMAC1		(void *)0xfffc0010c0
+#define TH1520_IOPMP_GMAC2		(void *)0xfffc0020c0
+#define TH1520_IOPMP_DMAC		(void *)0xffffc200c0
+#define TH1520_IOPMP_TEE_DMAC		(void *)0xffff2500c0
+#define TH1520_IOPMP_DSP0		(void *)0xffff0580c0
+#define TH1520_IOPMP_DSP1		(void *)0xffff0590c0
+#define TH1520_IOPMP_AUDIO		(void *)0xffffc220c0
+#define TH1520_IOPMP_AUDIO0		(void *)0xffcb02e0c0
+#define TH1520_IOPMP_AUDIO1		(void *)0xffcb02f0c0
+
+#define TH1520_IOPMP_DEFAULT_ATTR	0xffffffff
+
+#endif // _ASM_ARCH_TH1520_IOPMP_H_
-- 
2.49.0

