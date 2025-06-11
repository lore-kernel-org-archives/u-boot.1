Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46824C61DB2
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 00:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E55182B18;
	Wed, 11 Jun 2025 02:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a1YACaGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9005182B7C; Wed, 11 Jun 2025 02:26:19 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331B88070C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 02:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+smelamud.redhat.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E100360008;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DFDBC4CEF3;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749601575;
 bh=iDkvNgFR5EP7/i7ziMcQGmDtSCDH5YkbZIXKT9Ph90Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=a1YACaGXed0Oed+CIjbeE7ZWkKSQECgKfrElTdAzYR3ypaSm10D1+JwGOKlOFLCco
 NC4vMMoHItZqqr8Y3MGfgKwH/TYBxULnx1QpDUElRus73L8dMPQVwm8Ic7sfqzh4El
 WlXebKip/ACooYN7LwCX9XLPTswfYmDgWOc/xEzUmupWd7pUQdC40FhlJOKbMB4H9P
 9jfNoG6VRR3Q05Gs0oaReT4d0Pda0H60Ekp6gRknJqW2YrWAZ43DbfMwp8/me/gnaw
 6BbmPxIPgZICU9gXDaMkrrh6DcRBNK7dQnxHgbGfnWgkH+mafeIwsKwvvIHgkogj3N
 zCe3u3AgZlthA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 76A41C677C4;
 Wed, 11 Jun 2025 00:26:15 +0000 (UTC)
From: Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org>
Date: Wed, 11 Jun 2025 03:25:52 +0300
Subject: [PATCH v4 2/2] renesas: Renesas R-Car Gen4 watchdog driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-us-renesas-watchdog-v4-2-24f1da3e0dc9@redhat.com>
References: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
In-Reply-To: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749601573; l=7068;
 i=smelamud@redhat.com; s=20250530; h=from:subject:message-id;
 bh=RITBOQ0yGN/iJx6tAuNukDY52A3Ydy/Jr7I0l/vjZT0=;
 b=kWe8EjNjKG7LqyQy9rgbGnJ9qaqJ/HvxxxhFCAx+d6uT/Zjuh38u1VITdyPo0CllhjX1dH00m
 C2nMNR5MQ+1Bqr/Yx7Of+LFM38L2XgG7lQm40ZH5p4bYnfBTXdbr85s
X-Developer-Key: i=smelamud@redhat.com; a=ed25519;
 pk=B1DFtpdxDPQudtnqMHSFRRSJziu3zB49J6oZUBo0qI8=
X-Endpoint-Received: by B4 Relay for smelamud@redhat.com/20250530 with
 auth_id=418
X-Original-From: Shmuel Leib Melamud <smelamud@redhat.com>
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
Reply-To: smelamud@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Shmuel Leib Melamud <smelamud@redhat.com>

Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
8184.0s are supported (CKS1 register is not involved). The watchdog
uses the clock of type CLK_TYPE_GEN4_MDSEL.

The timeout is set in
dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.

This driver is based on upstream linux commit:
e70140ba0d2b("Get rid of 'remove_new' relic from platform driver struct")

Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/watchdog/Kconfig       |   8 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/renesas_wdt.c | 189 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bb67f5035231df9f6ce01adb08d074855393143..a0f2948335f9c3b74b7823f039e578ff4030e97c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -335,6 +335,14 @@ config WDT_K3_RTI_FW_FILE
 
 endif
 
+config WDT_RENESAS
+	bool "Renesas watchdog timer support"
+	depends on WDT && R8A779F0
+	select CLK
+	select CLK_RENESAS
+	help
+	  Enables Renesas SoC R8A779F0 watchdog timer support.
+
 config WDT_SANDBOX
 	bool "Enable Watchdog Timer support for Sandbox"
 	depends on SANDBOX && WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e6bd4c587af6133c405dde6dbada8050debc781c..c4467d6e126d0c3e119bf8014b302e5b1432f541 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_WDT_MTK) += mtk_wdt.o
 obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
 obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
 obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
+obj-$(CONFIG_WDT_RENESAS) += renesas_wdt.o
 obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
 obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
new file mode 100644
index 0000000000000000000000000000000000000000..046e11915b923a661a9ee1d0a586826a1d5068f8
--- /dev/null
+++ b/drivers/watchdog/renesas_wdt.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2025 Red Hat, Inc., Shmuel Leib Melamud <smelamud@redhat.com>
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <wdt.h>
+
+#define usleep_range(a, b) udelay((a))
+
+struct rwdt {
+	u32 cnt;
+	u32 csra;
+	u32 csrb;
+};
+
+#define RWTCSRA_WOVF	BIT(4)
+#define RWTCSRA_WRFLG	BIT(5)
+#define RWTCSRA_TME		BIT(7)
+
+#define CSR_MASK	0xA5A5A500
+#define CNT_MASK	0x5A5A0000
+
+#define MAX_CNT_VALUE   65536
+/*
+ * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
+ * divider (12 bits). d is only a factor to fully utilize the WDT counter and
+ * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
+ */
+#define MUL_BY_CLKS_PER_SEC(p, d) \
+	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
+
+/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
+#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
+
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
+
+struct rwdt_priv {
+	struct rwdt __iomem *wdt;
+	unsigned long clk_rate;
+	u8 cks;
+	struct clk clk;
+};
+
+static void rwdt_wait_cycles(struct rwdt_priv *priv, unsigned int cycles)
+{
+	unsigned int delay;
+
+	delay = DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
+
+	usleep_range(delay, 2 * delay);
+}
+
+static int rwdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct rwdt_priv *priv = dev_get_priv(dev);
+	u64 max_timeout;
+	u8 val;
+
+	max_timeout = DIV_BY_CLKS_PER_SEC(priv, MAX_CNT_VALUE);
+	timeout = min(max_timeout, timeout / 1000);
+
+	/* Stop the timer before we modify any register */
+	val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
+	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
+	/* Delay 2 cycles before setting watchdog counter */
+	rwdt_wait_cycles(priv, 2);
+
+	while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	writel_relaxed((MAX_CNT_VALUE - MUL_BY_CLKS_PER_SEC(priv, timeout))
+		       | CNT_MASK, &priv->wdt->cnt);
+
+	writel_relaxed(priv->cks | RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
+
+	return 0;
+}
+
+static int rwdt_stop(struct udevice *dev)
+{
+	struct rwdt_priv *priv = dev_get_priv(dev);
+
+	writel_relaxed(priv->cks | CSR_MASK, &priv->wdt->csra);
+
+	return 0;
+}
+
+static int rwdt_reset(struct udevice *dev)
+{
+	struct rwdt_priv *priv = dev_get_priv(dev);
+	u8 val;
+
+	/* Stop the timer before we modify any register */
+	val = readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
+	writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
+	/* Delay 2 cycles before setting watchdog counter */
+	rwdt_wait_cycles(priv, 2);
+
+	writel_relaxed(0xffff | CNT_MASK, &priv->wdt->cnt);
+	/* smallest divider to reboot soon */
+	writel_relaxed(0 | CSR_MASK, &priv->wdt->csra);
+
+	readb_poll_timeout(&priv->wdt->csra, val, !(val & RWTCSRA_WRFLG), 100);
+
+	writel_relaxed(RWTCSRA_TME | CSR_MASK, &priv->wdt->csra);
+
+	/* wait 2 cycles, so watchdog will trigger */
+	rwdt_wait_cycles(priv, 2);
+
+	return 0;
+}
+
+static int rwdt_probe(struct udevice *dev)
+{
+	struct rwdt_priv *priv = dev_get_priv(dev);
+	unsigned long clks_per_sec;
+	int ret, i;
+
+	priv->wdt = dev_remap_addr(dev);
+	if (!priv->wdt)
+		return -EINVAL;
+
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret)
+		return ret;
+
+	priv->clk_rate = clk_get_rate(&priv->clk);
+	if (!priv->clk_rate) {
+		ret = -ENOENT;
+		goto err_clk_disable;
+	}
+
+	/*
+	 * Find the largest possible divider that allows clock rate
+	 * (clks_per_sec) to stay within 16 bits. In this case, we can still
+	 * measure the smallest timeout (1s) and make the largest allowed
+	 * timeout as large as possible.
+	 */
+	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
+		clks_per_sec = priv->clk_rate / clk_divs[i];
+		if (clks_per_sec && clks_per_sec < 65536) {
+			priv->cks = i;
+			break;
+		}
+	}
+
+	/* can't find a suitable clock divider */
+	if (i < 0) {
+		ret = -ERANGE;
+		goto err_clk_disable;
+	}
+
+	return 0;
+
+err_clk_disable:
+	clk_disable(&priv->clk);
+
+	return ret;
+}
+
+static const struct wdt_ops rwdt_ops = {
+	.start = rwdt_start,
+	.reset = rwdt_reset,
+	.stop = rwdt_stop,
+};
+
+static const struct udevice_id rwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen2-wdt" },
+	{ .compatible = "renesas,rcar-gen3-wdt" },
+	{ .compatible = "renesas,rcar-gen4-wdt" },
+	{}
+};
+
+U_BOOT_DRIVER(wdt_renesas) = {
+	.name = "wdt_renesas",
+	.id = UCLASS_WDT,
+	.of_match = rwdt_ids,
+	.ops = &rwdt_ops,
+	.probe	= rwdt_probe,
+	.priv_auto = sizeof(struct rwdt_priv),
+};

-- 
2.49.0


