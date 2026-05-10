Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2AECD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C298C84A4C;
	Sun, 10 May 2026 02:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FRRHL6ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D66184A4C; Sun, 10 May 2026 02:07:14 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A0984A44
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36536771300so2997847a91.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371630; x=1778976430;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jpq+V70oNJBjn0wubi45oIgbd8PiaWHTjSy5VW++2rk=;
 b=FRRHL6ffdmAoH5wAc2E6yf8prW2VCq5mIeYRp8PaV+jnlmTeqplLHzDKQwWJzO6Cnf
 5rARVd5z+jrpi4JIRJccSwB7fcMsBzQwTTCkdZ/6aI15O1BKmXl26N8MrNlWFrjiwkvL
 I0g3uuzfyk6dmCydJG4GXsglBbvKOrYCPlBgeP/qUo75VViI0ZN20PqRhx+4alR2rBNE
 bKOUCYxVqDIJuIJ7xKu0VDtJyrvMII75whcdFXgHgsKbRJC7CT/ks1l3kxbRDnghZpT/
 EQ44fdgeH6+5HupfSF9ddIVZ1d4BIdqGPaOJT7lIam55DNKUSa8+GrZ8cSXTJ5TvR2vp
 tOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371630; x=1778976430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jpq+V70oNJBjn0wubi45oIgbd8PiaWHTjSy5VW++2rk=;
 b=qTTPx6Kj7dWUNLaaLLvQHgP9Wv49nZpKKkbZda0/82i2H22JJPt7MTyajqf0s1gWl0
 uR01nljha1OhxY6sHShjfpmfgpavGV1ktqleVwfNcsihx8vgVf6Ne2XAVl7whVZTbRAZ
 lRV7kOqYvCP6giIco1qpbcAhwaDIdj71zwVjmQMQR8DXdtDeVGMi6fUoMlOBKqat3hDh
 GkpqHiq9MkslDLOKIXTXs6daOPwlpRqgJrjBS/3KLP8uwTgt9swPo88peZhyGRTVY6NS
 rR7cOgPjwf3qulkqVRnw+p1BIZG3pOFkG2Rk1oR8HleUW5fB0ujvc0hT3x0m5DdKcYjb
 76Hg==
X-Gm-Message-State: AOJu0YwQzaZoj+A3mHSfF5jnbcvV2RCY16xq9erjX/EECBEJ9TziX7CF
 hDwP2smfoCn61hyzy9M4lKP8U8Kk7EHg6KcA+GIYizPc2OZptWL6vLw08udWrYzxcHw=
X-Gm-Gg: Acq92OFqUawubaybt8icsdfPaPCsD3Jw96UGkIGpWPaQX+mBXllGGJlIIw8aTV4mdQ1
 XpS9y5CIopaW0VoLNYTlxjf+TrAybsiIRMJAGwQqbN9PoIwhs4u7G6QVDhqBbX+x2GS22GyZl1j
 sOJ0SrZY2EHjRqlExGAJaX2+Jk2ClUVWHc48iHG7g4R21BO9yE3i2MhyNP9xIZ6K3aXbZeFiwHE
 qJJ5RQWZjQVhSJpaGjFZEPrCwFH1099CsV0QgLXtiEyGf5viYVA/9lvgbuomgJrL9gBc6UBqPSE
 ySpG4ERouC0tBvt42CVWgwYigvtqc3nB5Xd7nkfcdpWy/2e34lWQfnUnz6s3H2X0kDbRHj7IaMe
 Yqj4yen2vW02ZtSTKKVbvGbGgP3p3ZKrqvvBTUXMyUrJJcyQpXzTncYtyisoTcLb+nSFTpI0VLY
 mMfp/NXhCwET+9KnnUNgM8QT0SeCyraSaISvVT0N3nzO8=
X-Received: by 2002:a17:903:1109:b0:2bc:ac76:c1d0 with SMTP id
 d9443c01a7336-2bcac76c390mr2699205ad.17.1778371630060; 
 Sat, 09 May 2026 17:07:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:09 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:24 -0400
Subject: [PATCH 2/8] reset: spacemit: k1: introduce syscon-bound reset driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-2-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

The existing K1 reset driver (drivers/reset/reset-spacemit-k1.c) binds
via DT of_match against a top-level reset-controller node, but kernel
mainline DT for K1 has no such node: the mpmu, apbc, apmu and apbc2
syscons each spawn their own reset device as an auxiliary of the
clock controller. The legacy driver therefore cannot consume it.

Add a new reset driver at drivers/reset/spacemit/reset-spacemit-k1.c
bound by name from each per-syscon clock driver via
device_bind_driver_to_node(), without DT of_match, mirroring the
kernel's auxiliary-device pattern.

To keep the series bisectable, this driver coexists link-cleanly with
the legacy spacemit,k1-reset driver during the transition. A
follow-up patch that switches the K1 build to
dts/upstream/src/riscv/spacemit/ will drop the legacy driver.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/reset/Makefile                     |   1 +
 drivers/reset/spacemit/Makefile            |   5 +
 drivers/reset/spacemit/reset-spacemit-k1.c | 289 +++++++++++++++++++++++++++++
 include/soc/spacemit/k1-reset.h            |  23 +++
 4 files changed, 318 insertions(+)

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 088545c6473..10e1460ee34 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SPACEMIT_K1) += reset-spacemit-k1.o
+obj-$(CONFIG_RESET_SPACEMIT_K1) += spacemit/
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/spacemit/Makefile b/drivers/reset/spacemit/Makefile
new file mode 100644
index 00000000000..16722c68954
--- /dev/null
+++ b/drivers/reset/spacemit/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# SpacemiT reset drivers
+
+obj-y += reset-spacemit-k1.o
diff --git a/drivers/reset/spacemit/reset-spacemit-k1.c b/drivers/reset/spacemit/reset-spacemit-k1.c
new file mode 100644
index 00000000000..129e1cc96f1
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-k1.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT K1 reset driver (syscon-bound).
+ *
+ * Copyright (C) 2022 Spacemit Inc.
+ * Copyright (C) 2025 Huan Zhou <pericycle.cc@gmail.com>
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include <linux/bitops.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+#include <soc/spacemit/k1-reset.h>
+#include <soc/spacemit/k1-syscon.h>
+
+/* ===================================================================
+ * Per-syscon reset signal tables.
+ *
+ * Indexed by the kernel-side per-syscon-local IDs from
+ * <dt-bindings/clock/spacemit,k1-syscon.h>. Each entry is
+ * (offset, assert_mask, deassert_mask): bits in assert_mask are set
+ * when the reset line is asserted; bits in deassert_mask are set when
+ * deasserted; the union (assert_mask | deassert_mask) is the set of
+ * bits the controller will overwrite on each transition.
+ *
+ * Layout mirrors the kernel-side K1 reset driver.
+ * ===================================================================
+ */
+
+struct spacemit_k1_reset_data {
+	u32 offset;
+	u32 assert_mask;
+	u32 deassert_mask;
+};
+
+#define RESET_DATA(o, a, d) {					\
+	.offset = (o), .assert_mask = (a), .deassert_mask = (d)	\
+}
+
+static const struct spacemit_k1_reset_data k1_mpmu_resets[] = {
+	[RESET_WDT]	= RESET_DATA(MPMU_WDTPCR,		BIT(2), 0),
+};
+
+static const struct spacemit_k1_reset_data k1_apbc_resets[] = {
+	[RESET_UART0]	= RESET_DATA(APBC_UART1_CLK_RST,	BIT(2), 0),
+	[RESET_UART2]	= RESET_DATA(APBC_UART2_CLK_RST,	BIT(2), 0),
+	[RESET_UART3]	= RESET_DATA(APBC_UART3_CLK_RST,	BIT(2), 0),
+	[RESET_UART4]	= RESET_DATA(APBC_UART4_CLK_RST,	BIT(2), 0),
+	[RESET_UART5]	= RESET_DATA(APBC_UART5_CLK_RST,	BIT(2), 0),
+	[RESET_UART6]	= RESET_DATA(APBC_UART6_CLK_RST,	BIT(2), 0),
+	[RESET_UART7]	= RESET_DATA(APBC_UART7_CLK_RST,	BIT(2), 0),
+	[RESET_UART8]	= RESET_DATA(APBC_UART8_CLK_RST,	BIT(2), 0),
+	[RESET_UART9]	= RESET_DATA(APBC_UART9_CLK_RST,	BIT(2), 0),
+	[RESET_GPIO]	= RESET_DATA(APBC_GPIO_CLK_RST,		BIT(2), 0),
+	[RESET_PWM0]	= RESET_DATA(APBC_PWM0_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM1]	= RESET_DATA(APBC_PWM1_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM2]	= RESET_DATA(APBC_PWM2_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM3]	= RESET_DATA(APBC_PWM3_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM4]	= RESET_DATA(APBC_PWM4_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM5]	= RESET_DATA(APBC_PWM5_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM6]	= RESET_DATA(APBC_PWM6_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM7]	= RESET_DATA(APBC_PWM7_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM8]	= RESET_DATA(APBC_PWM8_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM9]	= RESET_DATA(APBC_PWM9_CLK_RST,		BIT(2), BIT(0)),
+	[RESET_PWM10]	= RESET_DATA(APBC_PWM10_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM11]	= RESET_DATA(APBC_PWM11_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM12]	= RESET_DATA(APBC_PWM12_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM13]	= RESET_DATA(APBC_PWM13_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM14]	= RESET_DATA(APBC_PWM14_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM15]	= RESET_DATA(APBC_PWM15_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM16]	= RESET_DATA(APBC_PWM16_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM17]	= RESET_DATA(APBC_PWM17_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM18]	= RESET_DATA(APBC_PWM18_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_PWM19]	= RESET_DATA(APBC_PWM19_CLK_RST,	BIT(2), BIT(0)),
+	[RESET_SSP3]	= RESET_DATA(APBC_SSP3_CLK_RST,		BIT(2), 0),
+	[RESET_RTC]	= RESET_DATA(APBC_RTC_CLK_RST,		BIT(2), 0),
+	[RESET_TWSI0]	= RESET_DATA(APBC_TWSI0_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI1]	= RESET_DATA(APBC_TWSI1_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI2]	= RESET_DATA(APBC_TWSI2_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI4]	= RESET_DATA(APBC_TWSI4_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI5]	= RESET_DATA(APBC_TWSI5_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI6]	= RESET_DATA(APBC_TWSI6_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI7]	= RESET_DATA(APBC_TWSI7_CLK_RST,	BIT(2), 0),
+	[RESET_TWSI8]	= RESET_DATA(APBC_TWSI8_CLK_RST,	BIT(2), 0),
+	[RESET_TIMERS1]	= RESET_DATA(APBC_TIMERS1_CLK_RST,	BIT(2), 0),
+	[RESET_TIMERS2]	= RESET_DATA(APBC_TIMERS2_CLK_RST,	BIT(2), 0),
+	[RESET_AIB]	= RESET_DATA(APBC_AIB_CLK_RST,		BIT(2), 0),
+	[RESET_ONEWIRE]	= RESET_DATA(APBC_ONEWIRE_CLK_RST,	BIT(2), 0),
+	[RESET_SSPA0]	= RESET_DATA(APBC_SSPA0_CLK_RST,	BIT(2), 0),
+	[RESET_SSPA1]	= RESET_DATA(APBC_SSPA1_CLK_RST,	BIT(2), 0),
+	[RESET_DRO]	= RESET_DATA(APBC_DRO_CLK_RST,		BIT(2), 0),
+	[RESET_IR]	= RESET_DATA(APBC_IR_CLK_RST,		BIT(2), 0),
+	[RESET_TSEN]	= RESET_DATA(APBC_TSEN_CLK_RST,		BIT(2), 0),
+	[RESET_IPC_AP2AUD] = RESET_DATA(APBC_IPC_AP2AUD_CLK_RST, BIT(2), 0),
+	[RESET_CAN0]	= RESET_DATA(APBC_CAN0_CLK_RST,		BIT(2), 0),
+};
+
+static const struct spacemit_k1_reset_data k1_apmu_resets[] = {
+	[RESET_CCIC_4X]		= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_CCIC1_PHY]	= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(2)),
+	[RESET_SDH_AXI]		= RESET_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_SDH0]		= RESET_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_SDH1]		= RESET_DATA(APMU_SDH1_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_SDH2]		= RESET_DATA(APMU_SDH2_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_USBP1_AXI]	= RESET_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(4)),
+	[RESET_USB_AXI]		= RESET_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_USB30_AHB]	= RESET_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(9)),
+	[RESET_USB30_VCC]	= RESET_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(10)),
+	[RESET_USB30_PHY]	= RESET_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(11)),
+	[RESET_QSPI]		= RESET_DATA(APMU_QSPI_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_QSPI_BUS]	= RESET_DATA(APMU_QSPI_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_DMA]		= RESET_DATA(APMU_DMA_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_AES]		= RESET_DATA(APMU_AES_CLK_RES_CTRL,	0, BIT(4)),
+	[RESET_VPU]		= RESET_DATA(APMU_VPU_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_GPU]		= RESET_DATA(APMU_GPU_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_EMMC]		= RESET_DATA(APMU_PMUA_EM_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_EMMC_X]		= RESET_DATA(APMU_PMUA_EM_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_AUDIO_SYS]	= RESET_DATA(APMU_AUDIO_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_AUDIO_MCU]	= RESET_DATA(APMU_AUDIO_CLK_RES_CTRL,	0, BIT(2)),
+	[RESET_AUDIO_APMU]	= RESET_DATA(APMU_AUDIO_CLK_RES_CTRL,	0, BIT(3)),
+	[RESET_HDMI]		= RESET_DATA(APMU_HDMI_CLK_RES_CTRL,	0, BIT(9)),
+	[RESET_PCIE0_DBI]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_0,	0, BIT(3)),
+	[RESET_PCIE0_SLAVE]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_0,	0, BIT(4)),
+	[RESET_PCIE0_MASTER]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_0,	0, BIT(5)),
+	[RESET_PCIE0_GLOBAL]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_0,	BIT(8), 0),
+	[RESET_PCIE1_DBI]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_1,	0, BIT(3)),
+	[RESET_PCIE1_SLAVE]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_1,	0, BIT(4)),
+	[RESET_PCIE1_MASTER]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_1,	0, BIT(5)),
+	[RESET_PCIE1_GLOBAL]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_1,	BIT(8), 0),
+	[RESET_PCIE2_DBI]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_2,	0, BIT(3)),
+	[RESET_PCIE2_SLAVE]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_2,	0, BIT(4)),
+	[RESET_PCIE2_MASTER]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_2,	0, BIT(5)),
+	[RESET_PCIE2_GLOBAL]	= RESET_DATA(APMU_PCIE_CLK_RES_CTRL_2,	BIT(8), 0),
+	[RESET_EMAC0]		= RESET_DATA(APMU_EMAC0_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_EMAC1]		= RESET_DATA(APMU_EMAC1_CLK_RES_CTRL,	0, BIT(1)),
+	[RESET_JPG]		= RESET_DATA(APMU_JPG_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_CCIC2PHY]	= RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0, BIT(2)),
+	[RESET_CCIC3PHY]	= RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0, BIT(29)),
+	[RESET_CSI]		= RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0, BIT(1)),
+	[RESET_ISP]		= RESET_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(0)),
+	[RESET_ISP_CPP]		= RESET_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(27)),
+	[RESET_ISP_BUS]		= RESET_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(3)),
+	[RESET_ISP_CI]		= RESET_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(16)),
+	[RESET_DPU_MCLK]	= RESET_DATA(APMU_LCD_CLK_RES_CTRL2,	0, BIT(9)),
+	[RESET_DPU_ESC]		= RESET_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(3)),
+	[RESET_DPU_HCLK]	= RESET_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(4)),
+	[RESET_DPU_SPIBUS]	= RESET_DATA(APMU_LCD_SPI_CLK_RES_CTRL,	0, BIT(4)),
+	[RESET_DPU_SPI_HBUS]	= RESET_DATA(APMU_LCD_SPI_CLK_RES_CTRL,	0, BIT(2)),
+	[RESET_V2D]		= RESET_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(27)),
+	[RESET_MIPI]		= RESET_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(15)),
+	[RESET_MC]		= RESET_DATA(APMU_PMUA_MC_CTRL,		0, BIT(0)),
+};
+
+static const struct spacemit_k1_reset_data k1_apbc2_resets[] = {
+	[RESET_APBC2_UART1]	= RESET_DATA(APBC2_UART1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC2_SSP2]	= RESET_DATA(APBC2_SSP2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC2_TWSI3]	= RESET_DATA(APBC2_TWSI3_CLK_RST,	BIT(2), 0),
+	[RESET_APBC2_RTC]	= RESET_DATA(APBC2_RTC_CLK_RST,		BIT(2), 0),
+	[RESET_APBC2_TIMERS0]	= RESET_DATA(APBC2_TIMERS0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC2_KPC]	= RESET_DATA(APBC2_KPC_CLK_RST,		BIT(2), 0),
+	[RESET_APBC2_GPIO]	= RESET_DATA(APBC2_GPIO_CLK_RST,	BIT(2), 0),
+};
+
+/* ===================================================================
+ * Driver
+ * ===================================================================
+ */
+
+struct spacemit_k1_reset_priv {
+	void __iomem *base;
+	const struct spacemit_k1_reset_data *table;
+	size_t table_size;
+};
+
+static int spacemit_k1_reset_xfer(struct reset_ctl *rst, bool assert)
+{
+	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct spacemit_k1_reset_data *e;
+	u32 v;
+
+	if (rst->id >= priv->table_size)
+		return -EINVAL;
+
+	e = &priv->table[rst->id];
+	if (e->assert_mask == 0 && e->deassert_mask == 0)
+		return -EINVAL;	/* not owned by this syscon */
+
+	v = readl(priv->base + e->offset);
+	v &= ~(e->assert_mask | e->deassert_mask);
+	v |= assert ? e->assert_mask : e->deassert_mask;
+	writel(v, priv->base + e->offset);
+
+	return 0;
+}
+
+static int spacemit_k1_reset_assert(struct reset_ctl *rst)
+{
+	return spacemit_k1_reset_xfer(rst, true);
+}
+
+static int spacemit_k1_reset_deassert(struct reset_ctl *rst)
+{
+	return spacemit_k1_reset_xfer(rst, false);
+}
+
+static int spacemit_k1_reset_request(struct reset_ctl *rst)
+{
+	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
+
+	return rst->id < priv->table_size ? 0 : -EINVAL;
+}
+
+static const struct reset_ops spacemit_k1_reset_ops = {
+	.request	= spacemit_k1_reset_request,
+	.rst_assert	= spacemit_k1_reset_assert,
+	.rst_deassert	= spacemit_k1_reset_deassert,
+};
+
+static int spacemit_k1_reset_probe(struct udevice *dev)
+{
+	struct spacemit_k1_reset_priv *priv = dev_get_priv(dev);
+
+	priv->base = (void __iomem *)dev_remap_addr(dev);
+	if (!priv->base)
+		return -ENODEV;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(spacemit_k1_reset) = {
+	.name		= "spacemit_k1_reset",
+	.id		= UCLASS_RESET,
+	.ops		= &spacemit_k1_reset_ops,
+	.probe		= spacemit_k1_reset_probe,
+	.priv_auto	= sizeof(struct spacemit_k1_reset_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_k1_reset_bind(struct udevice *parent,
+			   enum spacemit_k1_reset_syscon syscon)
+{
+	struct spacemit_k1_reset_priv *priv;
+	struct udevice *rst_dev;
+	const struct spacemit_k1_reset_data *table;
+	size_t table_size;
+	int ret;
+
+	switch (syscon) {
+	case SPACEMIT_K1_RESET_MPMU:
+		table = k1_mpmu_resets;
+		table_size = ARRAY_SIZE(k1_mpmu_resets);
+		break;
+	case SPACEMIT_K1_RESET_APMU:
+		table = k1_apmu_resets;
+		table_size = ARRAY_SIZE(k1_apmu_resets);
+		break;
+	case SPACEMIT_K1_RESET_APBC:
+		table = k1_apbc_resets;
+		table_size = ARRAY_SIZE(k1_apbc_resets);
+		break;
+	case SPACEMIT_K1_RESET_APBC2:
+		table = k1_apbc2_resets;
+		table_size = ARRAY_SIZE(k1_apbc2_resets);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = device_bind_driver_to_node(parent, "spacemit_k1_reset", "reset",
+					 dev_ofnode(parent), &rst_dev);
+	if (ret)
+		return ret;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv) {
+		device_unbind(rst_dev);
+		return -ENOMEM;
+	}
+	priv->table = table;
+	priv->table_size = table_size;
+	dev_set_priv(rst_dev, priv);
+
+	return 0;
+}
diff --git a/include/soc/spacemit/k1-reset.h b/include/soc/spacemit/k1-reset.h
new file mode 100644
index 00000000000..1dbfd6b1cb0
--- /dev/null
+++ b/include/soc/spacemit/k1-reset.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SpacemiT K1 reset driver — header interface.
+ *
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#ifndef _SOC_SPACEMIT_K1_RESET_H
+#define _SOC_SPACEMIT_K1_RESET_H
+
+struct udevice;
+
+enum spacemit_k1_reset_syscon {
+	SPACEMIT_K1_RESET_MPMU,
+	SPACEMIT_K1_RESET_APMU,
+	SPACEMIT_K1_RESET_APBC,
+	SPACEMIT_K1_RESET_APBC2,
+};
+
+int spacemit_k1_reset_bind(struct udevice *parent,
+			   enum spacemit_k1_reset_syscon syscon);
+
+#endif /* _SOC_SPACEMIT_K1_RESET_H */

-- 
2.43.0

