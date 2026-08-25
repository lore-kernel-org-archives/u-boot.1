Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017FC5B572
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 164F880DD4;
	Tue, 25 Aug 2026 04:25:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jadLuBv9rwks; Tue, 25 Aug 2026 04:25:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631942;
	bh=VCGlT4Ffq7u8KwhBugQxzNG45QMWwfqH72Y/U+Cx2/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvSWdh5owmFB4HO7zQ2fKF5YhiRo9IsqFSE4vFnsNtWaJQlJiajG2h/hJ8yiz+ewB
	 e2aeI8+F6uxmnyciowsaTVv1JStISY/hnzxhV9CovXbYwgWBmkGwjmOloqSe0KNWjE
	 oEEYOg7C2y2PwdeWxHpBHgoRvJfTJZHqyfEQE4pU9LyghPoKvVWzsIICkQmK4gSdEZ
	 gUdhnQfBUmKe4O3MwpMIjF1UfzOrIl9tn24mEyV/YTFusFZKY++5NA7n7asUOt+r3J
	 cItvwaNxZNuu6fmqeawM5bSRudJ+EffWCzLOZ/+F8aoW31A7Hv9RZpvLwOO4g3PHda
	 961006Vb+oQWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E2780D9F;
	Tue, 25 Aug 2026 04:25:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24393279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15C2280D9F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NZV_R9T0Lzt for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NOAPhI1B
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9EDC80D43
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F12F431C1;
 Tue, 25 Aug 2026 04:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9691F00A3D;
 Tue, 25 Aug 2026 04:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631936;
 bh=VCGlT4Ffq7u8KwhBugQxzNG45QMWwfqH72Y/U+Cx2/s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NOAPhI1BxC+0U16RCo9OesNAXumA2vXhMrAkMzQELj+7yN9hcO7Tp0arKxMNr/EZs
 cVbsktS72rjYV4z3AQq7ywg+X69hGHLY13X/ENTgdj51nAR/7thmkcGIGxmOC0yav5
 uAMxGToC8+tFikV5NZLX2oQpNtUkmQ/McH5nRKqeuBbnxEk9dNV1MqBVSnGELoeBwA
 9ZtXlgyh9MhEjF3TnMASoeMAZPauU9dw/GpytCXc+MKfUHFvhl1H8OvmGS2DuFUWk9
 CAS2NFNAV1TIEX8e1ot5Nu/3vksrkEl29de9EUxX9tPchDr4Wo7J76hjKcM9vwtTZI
 3TtaMX4en55kg==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 25 Aug 2026 04:24:18 +0000
Subject: [PATCH 8/8] reset: spacemit: Add SpacemiT K3 reset driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-01-k3-clock-reset-support-v1-8-c430253e759c@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21627; i=dlan@kernel.org;
 h=from:subject:message-id; bh=7Y8hRrqk4kZLQSHI3dhpS9JCWU3veAfB32Gh3VZtlOs=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkcslnn+6QDc7PN3enVNKcO2ja1K/F8CasF5
 GBTpZr1R8mJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZHBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1eeQ//akJwwCjp9AnH19DufaC8jjwCvRxmeZmoGodQx54ON6OrsN0jedRYJ
 7vSr6M8t7QvU5Ueh5nutROB2nKE4xlgXiV+QIEIshsETH4qFeeCIsMkZ+UUGuwQ4/nt6tD9oCoz
 BFl0oQnDSCnO5K9nJ6TwE0PX3CE1opu9a4F3AR4hK3r0PEbXmypv01xhoQbFIDTh2Dju6KLQ6aV
 LjvXm/CPVrabhSh69yUgV1TMgdAGLxNndOWjiMKzEkZTwBzG+cbbZD4BM4MpmfBMwPUhjFBJGeZ
 ecIhGUN/N4qvg1KzpA6GrO5dlx7Gn704HsdjhnBu+e1bZzdvl2INA2LiT5RgB8TyH6PViQCRWyo
 xk+ygvfz1BLyKRNPZ5S0I1vrjRLiBsn6vWXH+D623h1rDkTw2D+TQsXuWARuCI/a5veKWp6Twfi
 JNPK4FxZ6bvUpQFGsB76gRK40MDlLOSJnh8IE3VbitBNIcfRZYsyJHHpa1Xi3zDij88VNnjN4sx
 GAEb/dmH6H22VoTzwWYjxNHY5j2cVnX5EKgKn1v68sbYZrtHJtwhpLQsVJln10Dtk0u8Lo3te6/
 a/H/Q7vReDSgsIrXBY4BGYSM1wO8zjYB8c3HlHkhwzlUS4As1wdDpbt94jkv/cS1QzssIX/GM1w
 XHtPtwhJuIImjf2n2gzPg/A9MgYVv8=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  938ce3b16582 ("reset: spacemit: Add SpacemiT K3 reset driver")

Add support for the SpacemiT K3 SoC reset controller. The K3 reset
driver reuses the common reset controller code and provides K3-specific
reset data for devices managed by the following units:

- MPMU (Main Power Management Unit)
- APBC (APB clock unit)
- APMU (Application Subsystem Power Management Unit)
- DCIU (DMA Control and Interface Unit)

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/Kconfig               |   1 +
 drivers/clk/spacemit/clk-k3.c              |  25 +++
 drivers/reset/spacemit/Kconfig             |   7 +
 drivers/reset/spacemit/Makefile            |   1 +
 drivers/reset/spacemit/reset-spacemit-k3.c | 244 +++++++++++++++++++++++++++++
 include/soc/spacemit/k3-reset.h            |  21 +++
 6 files changed, 299 insertions(+)

diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
index c305f433871..a782426fe0f 100644
--- a/drivers/clk/spacemit/Kconfig
+++ b/drivers/clk/spacemit/Kconfig
@@ -24,6 +24,7 @@ config CLK_SPACEMIT_K1
 config CLK_SPACEMIT_K3
 	bool "SpacemiT K3 clock support"
 	select CLK_CCF
+	select RESET_SPACEMIT_K3
 	help
 	  This enables support clock driver for Spacemit K3 SoC.
 	  It's based on Common Clock Framework.
diff --git a/drivers/clk/spacemit/clk-k3.c b/drivers/clk/spacemit/clk-k3.c
index c4ac0b18442..519f2122c74 100644
--- a/drivers/clk/spacemit/clk-k3.c
+++ b/drivers/clk/spacemit/clk-k3.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <regmap.h>
 #include <linux/clk-provider.h>
+#include <soc/spacemit/k3-reset.h>
 #include <soc/spacemit/k3-syscon.h>
 
 #include "clk_common.h"
@@ -1990,6 +1991,26 @@ U_BOOT_DRIVER(k3_pll_clk) = {
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
+static int k3_mpmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_MPMU);
+}
+
+static int k3_apbc_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_APBC);
+}
+
+static int k3_apmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_APMU);
+}
+
+static int k3_dciu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_DCIU);
+}
+
 static const struct udevice_id k3_mpmu_clk_match[] = {
 	{ .compatible = "spacemit,k3-syscon-mpmu",
 	  .data = (ulong)&k3_ccu_mpmu_data },
@@ -2002,6 +2023,7 @@ U_BOOT_DRIVER(k3_mpmu_clk) = {
 	.name		= "k3_mpmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_mpmu_clk_match,
+	.bind		= k3_mpmu_clk_bind,
 	.probe		= k3_mpmu_clk_probe,
 	.ops		= &k3_mpmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -2019,6 +2041,7 @@ U_BOOT_DRIVER(k3_apbc_clk) = {
 	.name		= "k3_apbc_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_apbc_clk_match,
+	.bind		= k3_apbc_clk_bind,
 	.probe		= k3_apbc_clk_probe,
 	.ops		= &k3_apbc_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -2036,6 +2059,7 @@ U_BOOT_DRIVER(k3_apmu_clk) = {
 	.name		= "k3_apmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_apmu_clk_match,
+	.bind		= k3_apmu_clk_bind,
 	.probe		= k3_apmu_clk_probe,
 	.ops		= &k3_apmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -2053,6 +2077,7 @@ U_BOOT_DRIVER(k3_dciu_clk) = {
 	.name		= "k3_dciu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_dciu_clk_match,
+	.bind		= k3_dciu_clk_bind,
 	.probe		= k3_dciu_clk_probe,
 	.ops		= &k3_dciu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
diff --git a/drivers/reset/spacemit/Kconfig b/drivers/reset/spacemit/Kconfig
index 20e4cc6e4d8..66ab5f85333 100644
--- a/drivers/reset/spacemit/Kconfig
+++ b/drivers/reset/spacemit/Kconfig
@@ -13,3 +13,10 @@ config RESET_SPACEMIT_K1
 	help
 	  Reset controller for SpacemiT K1 (MPMU/APBC/APMU/APBC2).
 	  Bound from the K1 CCU/syscon devices.
+
+config RESET_SPACEMIT_K3
+	bool "SpacemiT K3 reset support"
+	select RESET_SPACEMIT_COMMON
+	help
+	  Reset controller for SpacemiT K3 (MPMU/APBC/APMU/DCIU).
+	  Bound from the K3 CCU/syscon devices.
diff --git a/drivers/reset/spacemit/Makefile b/drivers/reset/spacemit/Makefile
index 56f9fd1ab20..f89d068e1ca 100644
--- a/drivers/reset/spacemit/Makefile
+++ b/drivers/reset/spacemit/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_RESET_SPACEMIT_COMMON)	+= reset-spacemit-common.o
 obj-$(CONFIG_RESET_SPACEMIT_K1)		+= reset-spacemit-k1.o
+obj-$(CONFIG_RESET_SPACEMIT_K3)		+= reset-spacemit-k3.o
diff --git a/drivers/reset/spacemit/reset-spacemit-k3.c b/drivers/reset/spacemit/reset-spacemit-k3.c
new file mode 100644
index 00000000000..63e4bf66d1d
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-k3.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT K3 reset driver (syscon-bound).
+ *
+ * Port of Linux drivers/reset/spacemit/reset-spacemit-k3.c
+ *
+ * Copyright (C) 2025 SpacemiT Technology Co. Ltd
+ */
+
+#include <dm.h>
+#include <dt-bindings/reset/spacemit,k3-resets.h>
+#include <linux/bitops.h>
+#include <soc/spacemit/k3-reset.h>
+#include <soc/spacemit/k3-syscon.h>
+
+#include "reset-spacemit-common.h"
+
+static const struct spacemit_reset_data k3_mpmu_resets[] = {
+	[RESET_MPMU_WDT]	= RESET_DATA(MPMU_WDTPCR,	BIT(2), 0),
+	[RESET_MPMU_RIPC]	= RESET_DATA(MPMU_RIPCCR,	BIT(2), 0),
+};
+
+static const struct spacemit_reset_data k3_apbc_resets[] = {
+	[RESET_APBC_UART0]	= RESET_DATA(APBC_UART0_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART2]	= RESET_DATA(APBC_UART2_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART3]	= RESET_DATA(APBC_UART3_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART4]	= RESET_DATA(APBC_UART4_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART5]	= RESET_DATA(APBC_UART5_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART6]	= RESET_DATA(APBC_UART6_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART7]	= RESET_DATA(APBC_UART7_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART8]	= RESET_DATA(APBC_UART8_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART9]	= RESET_DATA(APBC_UART9_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART10]	= RESET_DATA(APBC_UART10_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_GPIO]	= RESET_DATA(APBC_GPIO_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM0]	= RESET_DATA(APBC_PWM0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM1]	= RESET_DATA(APBC_PWM1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM2]	= RESET_DATA(APBC_PWM2_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM3]	= RESET_DATA(APBC_PWM3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM4]	= RESET_DATA(APBC_PWM4_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM5]	= RESET_DATA(APBC_PWM5_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM6]	= RESET_DATA(APBC_PWM6_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM7]	= RESET_DATA(APBC_PWM7_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM8]	= RESET_DATA(APBC_PWM8_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM9]	= RESET_DATA(APBC_PWM9_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM10]	= RESET_DATA(APBC_PWM10_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM11]	= RESET_DATA(APBC_PWM11_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM12]	= RESET_DATA(APBC_PWM12_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM13]	= RESET_DATA(APBC_PWM13_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM14]	= RESET_DATA(APBC_PWM14_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM15]	= RESET_DATA(APBC_PWM15_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM16]	= RESET_DATA(APBC_PWM16_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM17]	= RESET_DATA(APBC_PWM17_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM18]	= RESET_DATA(APBC_PWM18_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM19]	= RESET_DATA(APBC_PWM19_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_SPI0]	= RESET_DATA(APBC_SSP0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_SPI1]	= RESET_DATA(APBC_SSP1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_SPI3]	= RESET_DATA(APBC_SSP3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_RTC]	= RESET_DATA(APBC_RTC_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_TWSI0]	= RESET_DATA(APBC_TWSI0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI1]	= RESET_DATA(APBC_TWSI1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI2]	= RESET_DATA(APBC_TWSI2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI4]	= RESET_DATA(APBC_TWSI4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI5]	= RESET_DATA(APBC_TWSI5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI6]	= RESET_DATA(APBC_TWSI6_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI8]	= RESET_DATA(APBC_TWSI8_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS0]	= RESET_DATA(APBC_TIMERS0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS1]	= RESET_DATA(APBC_TIMERS1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS2]	= RESET_DATA(APBC_TIMERS2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS3]	= RESET_DATA(APBC_TIMERS3_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS4]	= RESET_DATA(APBC_TIMERS4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS5]	= RESET_DATA(APBC_TIMERS5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS6]	= RESET_DATA(APBC_TIMERS6_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS7]	= RESET_DATA(APBC_TIMERS7_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_AIB]	= RESET_DATA(APBC_AIB_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_ONEWIRE]	= RESET_DATA(APBC_ONEWIRE_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S0]	= RESET_DATA(APBC_SSPA0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S1]	= RESET_DATA(APBC_SSPA1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S2]	= RESET_DATA(APBC_SSPA2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S3]	= RESET_DATA(APBC_SSPA3_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S4]	= RESET_DATA(APBC_SSPA4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S5]	= RESET_DATA(APBC_SSPA5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_DRO]	= RESET_DATA(APBC_DRO_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_IR0]	= RESET_DATA(APBC_IR0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_IR1]	= RESET_DATA(APBC_IR1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_TSEN]	= RESET_DATA(APBC_TSEN_CLK_RST,		BIT(2), 0),
+	[RESET_IPC_AP2AUD]	= RESET_DATA(APBC_IPC_AP2AUD_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_CAN0]	= RESET_DATA(APBC_CAN0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN1]	= RESET_DATA(APBC_CAN1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN2]	= RESET_DATA(APBC_CAN2_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN3]	= RESET_DATA(APBC_CAN3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN4]	= RESET_DATA(APBC_CAN4_CLK_RST,		BIT(2), 0),
+};
+
+static const struct spacemit_reset_data k3_apmu_resets[] = {
+	[RESET_APMU_CSI]                = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(1)),
+	[RESET_APMU_CCIC2PHY]           = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(2)),
+	[RESET_APMU_CCIC3PHY]           = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(29)),
+	[RESET_APMU_ISP_CIBUS]          = RESET_DATA(APMU_ISP_CLK_RES_CTRL,       0,       BIT(16)),
+	[RESET_APMU_DSI_ESC]            = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(3)),
+	[RESET_APMU_LCD]                = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(4)),
+	[RESET_APMU_V2D]                = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(27)),
+	[RESET_APMU_LCD_MCLK]           = RESET_DATA(APMU_LCD_CLK_RES_CTRL2,      0,       BIT(9)),
+	[RESET_APMU_LCD_DSCCLK]         = RESET_DATA(APMU_LCD_CLK_RES_CTRL2,      0,       BIT(15)),
+	[RESET_APMU_SC2_HCLK]           = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_CCIC_4X]            = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_CCIC1_PHY]          = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(2)),
+	[RESET_APMU_SDH_AXI]            = RESET_DATA(APMU_SDH0_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_SDH0]               = RESET_DATA(APMU_SDH0_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_SDH1]               = RESET_DATA(APMU_SDH1_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_SDH2]               = RESET_DATA(APMU_SDH2_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_USB2_AHB]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_USB2_VCC]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(2)),
+	[RESET_APMU_USB2_PHY]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(3)),
+	[RESET_APMU_USB3_A_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(5)),
+	[RESET_APMU_USB3_A_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(6)),
+	[RESET_APMU_USB3_A_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(7)),
+	[RESET_APMU_USB3_B_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(9)),
+	[RESET_APMU_USB3_B_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(10)),
+	[RESET_APMU_USB3_B_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(11)),
+	[RESET_APMU_USB3_C_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(13)),
+	[RESET_APMU_USB3_C_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(14)),
+	[RESET_APMU_USB3_C_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(15)),
+	[RESET_APMU_USB3_D_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(17)),
+	[RESET_APMU_USB3_D_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(18)),
+	[RESET_APMU_USB3_D_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(19)),
+	[RESET_APMU_QSPI]               = RESET_DATA(APMU_QSPI_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_QSPI_BUS]           = RESET_DATA(APMU_QSPI_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_DMA]                = RESET_DATA(APMU_DMA_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_AES_WTM]            = RESET_DATA(APMU_AES_CLK_RES_CTRL,       0,       BIT(4)),
+	[RESET_APMU_MCB_DCLK]           = RESET_DATA(APMU_MCB_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_MCB_ACLK]           = RESET_DATA(APMU_MCB_CLK_RES_CTRL,       0,       BIT(1)),
+	[RESET_APMU_VPU]                = RESET_DATA(APMU_VPU_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_DTC]                = RESET_DATA(APMU_DTC_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_GPU]                = RESET_DATA(APMU_GPU_CLK_RES_CTRL,       0,       BIT(1)),
+	[RESET_APMU_MC]                 = RESET_DATA(APMU_PMUA_MC_CTRL,           0,       BIT(0)),
+	[RESET_APMU_CPU0_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(0),  0),
+	[RESET_APMU_CPU0_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(1),  0),
+	[RESET_APMU_CPU1_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(3),  0),
+	[RESET_APMU_CPU1_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(4),  0),
+	[RESET_APMU_CPU2_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(6),  0),
+	[RESET_APMU_CPU2_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(7),  0),
+	[RESET_APMU_CPU3_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(9),  0),
+	[RESET_APMU_CPU3_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(10), 0),
+	[RESET_APMU_C0_MPSUB_SW]        = RESET_DATA(APMU_PMU_CC2_AP,             BIT(12), 0),
+	[RESET_APMU_CPU4_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(16), 0),
+	[RESET_APMU_CPU4_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(17), 0),
+	[RESET_APMU_CPU5_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(19), 0),
+	[RESET_APMU_CPU5_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(20), 0),
+	[RESET_APMU_CPU6_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(22), 0),
+	[RESET_APMU_CPU6_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(23), 0),
+	[RESET_APMU_CPU7_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(25), 0),
+	[RESET_APMU_CPU7_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(26), 0),
+	[RESET_APMU_C1_MPSUB_SW]        = RESET_DATA(APMU_PMU_CC2_AP,             BIT(28), 0),
+	[RESET_APMU_MPSUB_DBG]          = RESET_DATA(APMU_PMU_CC2_AP,             BIT(29), 0),
+	[RESET_APMU_UCIE_IP]            = RESET_DATA(APMU_UCIE_CTRL,              BIT(1),  0),
+	[RESET_APMU_UCIE_HOT]           = RESET_DATA(APMU_UCIE_CTRL,              BIT(2),  0),
+	[RESET_APMU_UCIE_MON]           = RESET_DATA(APMU_UCIE_CTRL,              BIT(3),  0),
+	[RESET_APMU_RCPU_AUDIO_SYS]     = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_RCPU_MCU_CORE]      = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(2)),
+	[RESET_APMU_RCPU_AUDIO_APMU]    = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(3)),
+	[RESET_APMU_DSI4LN2_ESCCLK]     = RESET_DATA(APMU_LCD_CLK_RES_CTRL3,      0,       BIT(3)),
+	[RESET_APMU_DSI4LN2_LCD_SW]     = RESET_DATA(APMU_LCD_CLK_RES_CTRL3,      0,       BIT(4)),
+	[RESET_APMU_DSI4LN2_LCD_MCLK]   = RESET_DATA(APMU_LCD_CLK_RES_CTRL4,      0,       BIT(9)),
+	[RESET_APMU_DSI4LN2_LCD_DSCCLK] = RESET_DATA(APMU_LCD_CLK_RES_CTRL4,      0,       BIT(15)),
+	[RESET_APMU_DSI4LN2_DPU_ACLK]   = RESET_DATA(APMU_LCD_CLK_RES_CTRL5,      0,       BIT(0)),
+	[RESET_APMU_DPU_ACLK]           = RESET_DATA(APMU_LCD_CLK_RES_CTRL5,      0,       BIT(15)),
+	[RESET_APMU_UFS_ACLK]           = RESET_DATA(APMU_UFS_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_EDP0]               = RESET_DATA(APMU_LCD_EDP_CTRL,           0,       BIT(0)),
+	[RESET_APMU_EDP1]               = RESET_DATA(APMU_LCD_EDP_CTRL,           0,       BIT(16)),
+	[RESET_APMU_PCIE_A_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(3)),
+	[RESET_APMU_PCIE_A_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(4)),
+	[RESET_APMU_PCIE_A_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(5)),
+	[RESET_APMU_PCIE_B_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(3)),
+	[RESET_APMU_PCIE_B_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(4)),
+	[RESET_APMU_PCIE_B_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(5)),
+	[RESET_APMU_PCIE_C_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(3)),
+	[RESET_APMU_PCIE_C_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(4)),
+	[RESET_APMU_PCIE_C_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(5)),
+	[RESET_APMU_PCIE_D_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(3)),
+	[RESET_APMU_PCIE_D_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(4)),
+	[RESET_APMU_PCIE_D_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(5)),
+	[RESET_APMU_PCIE_E_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(3)),
+	[RESET_APMU_PCIE_E_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(4)),
+	[RESET_APMU_PCIE_E_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(5)),
+	[RESET_APMU_EMAC0]              = RESET_DATA(APMU_EMAC0_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_EMAC1]              = RESET_DATA(APMU_EMAC1_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_EMAC2]              = RESET_DATA(APMU_EMAC2_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_ESPI_MCLK]          = RESET_DATA(APMU_ESPI_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_ESPI_SCLK]          = RESET_DATA(APMU_ESPI_CLK_RES_CTRL,      0,       BIT(2)),
+};
+
+static const struct spacemit_reset_data k3_dciu_resets[] = {
+	[RESET_DCIU_HDMA]	= RESET_DATA(DCIU_DMASYS_RSTN,		0, BIT(0)),
+	[RESET_DCIU_DMA350]	= RESET_DATA(DCIU_DMASYS_SDMA_RSTN,	0, BIT(0)),
+	[RESET_DCIU_DMA350_0]	= RESET_DATA(DCIU_DMASYS_S0_RSTN,	0, BIT(0)),
+	[RESET_DCIU_DMA350_1]	= RESET_DATA(DCIU_DMASYS_S1_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA0]	= RESET_DATA(DCIU_DMASYS_A0_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA1]	= RESET_DATA(DCIU_DMASYS_A1_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA2]	= RESET_DATA(DCIU_DMASYS_A2_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA3]	= RESET_DATA(DCIU_DMASYS_A3_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA4]	= RESET_DATA(DCIU_DMASYS_A4_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA5]	= RESET_DATA(DCIU_DMASYS_A5_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA6]	= RESET_DATA(DCIU_DMASYS_A6_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA7]	= RESET_DATA(DCIU_DMASYS_A7_RSTN,	0, BIT(0)),
+};
+
+U_BOOT_DRIVER(spacemit_k3_reset) = {
+	.name		= "spacemit_k3_reset",
+	.id		= UCLASS_RESET,
+	.ops		= &spacemit_reset_ops,
+	.probe		= spacemit_reset_probe,
+	.priv_auto	= sizeof(struct spacemit_reset_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_k3_reset_bind(struct udevice *parent,
+			   enum spacemit_k3_reset_syscon syscon)
+{
+	const struct spacemit_reset_data *table;
+	size_t table_size;
+
+	switch (syscon) {
+	case SPACEMIT_K3_RESET_MPMU:
+		table = k3_mpmu_resets;
+		table_size = ARRAY_SIZE(k3_mpmu_resets);
+		break;
+	case SPACEMIT_K3_RESET_APBC:
+		table = k3_apbc_resets;
+		table_size = ARRAY_SIZE(k3_apbc_resets);
+		break;
+	case SPACEMIT_K3_RESET_APMU:
+		table = k3_apmu_resets;
+		table_size = ARRAY_SIZE(k3_apmu_resets);
+		break;
+	case SPACEMIT_K3_RESET_DCIU:
+		table = k3_dciu_resets;
+		table_size = ARRAY_SIZE(k3_dciu_resets);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spacemit_reset_bind(parent, "spacemit_k3_reset", table, table_size);
+}
diff --git a/include/soc/spacemit/k3-reset.h b/include/soc/spacemit/k3-reset.h
new file mode 100644
index 00000000000..e2ae12e2edc
--- /dev/null
+++ b/include/soc/spacemit/k3-reset.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SpacemiT K3 reset driver — header interface.
+ */
+
+#ifndef _SOC_SPACEMIT_K3_RESET_H
+#define _SOC_SPACEMIT_K3_RESET_H
+
+struct udevice;
+
+enum spacemit_k3_reset_syscon {
+	SPACEMIT_K3_RESET_MPMU,
+	SPACEMIT_K3_RESET_APBC,
+	SPACEMIT_K3_RESET_APMU,
+	SPACEMIT_K3_RESET_DCIU,
+};
+
+int spacemit_k3_reset_bind(struct udevice *parent,
+			   enum spacemit_k3_reset_syscon syscon);
+
+#endif /* _SOC_SPACEMIT_K3_RESET_H */

-- 
2.55.0

