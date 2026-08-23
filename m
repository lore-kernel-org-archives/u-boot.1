Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820FFC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D09E60625;
	Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glDlC-aMQcnX; Sun, 23 Aug 2026 20:39:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517577;
	bh=/5Ip2qvl5gP0QdyomgXWDVKRemqgr668y/d4iT/prEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSgRLzBH9yQvWvOM1AqbwU9FHQR2tFwFP6qmPefb2rXt92Eka5BAvwEt9UtkLVPsp
	 1aebh69jFc0+U0zamBsKyyXmatwzT40xIQQgTluNQGaqMDUkg5qUC8zueNa0UuSA4z
	 +u3ywSWTpZlwEIdJvpMPgc1AL6+BHF/28YHujxt1xmfoUhLjrIDDVJE2rJcxTy/l7b
	 RsxQD9SlbpIP4MEnj0yY9X5nZLnbhHAUTzlDIJhoiAbd0uFMUs/6twKhrbFrWn2Beq
	 Jb6KMwbifMPkixvapQJZ+KwvNK6B7mg7JkYaSOjFdI+Yhfv4HKxQKoW/ecZRxmvF7q
	 hU3Tv8n4ntOww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCBF0605FF;
	Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 525D52FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38ED48082C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OW76UDZSLS0G for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UYzYntMJ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75C178082F
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02F404064C;
 Sun, 23 Aug 2026 20:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2CF1F000E9;
 Sun, 23 Aug 2026 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517570;
 bh=/5Ip2qvl5gP0QdyomgXWDVKRemqgr668y/d4iT/prEc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UYzYntMJHb8vSu1l70cmTXMyVO1plYrNZwomsBX/Adlcqn6kr/B2iLjbzkcmA2K3w
 BJxYDHBcRvt+YprAjbD5h7cIhdQuH8a/c2+VgoZsuc45f4aJU7r0rESi57a9nzNBZo
 5nisaRj8g4m74DpQbz1aXS0mBOaVQtHYuTcGU5XST1Z/VS+VXfAbmCRvTGlmxzerm/
 DhY1XOiwoQEm34WWfY/gJmI55UTR8E9WciRBDBj7JVFh5kvZPUiX4DSuztSeP+8YMu
 6WoUyuxpkcpzZh4i5rJXeAHztzlr96VOHeW3oe5yzAVb3t+7qcPzj1bigV+URi/+rE
 OxJD5Z2EhpEYw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:20 +0200
Subject: [PATCH v5 01/13] pinctrl: Add compact Nomadik pin controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-1-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Add the minimal pin control support needed to consume default states from
the upstream DB8500 device trees. Resolve the nine Nomadik GPIO banks
through nomadik-gpio-chips and apply the mux, direction, value, pull and
low-EMI settings directly to their registers.

Only the DB8500 binding and default-state configuration needed by
U-Boot are supported. There is no GPIO ownership or sleep-state
handling.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                       |   1 +
 arch/arm/Kconfig                  |   2 +
 drivers/pinctrl/Kconfig           |   7 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-nomadik.c | 230 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5a..a5d6b5be29dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -787,6 +787,7 @@ S:	Maintained
 F:	arch/arm/dts/ste-*
 F:	arch/arm/mach-u8500/
 F:	drivers/gpio/nmk_gpio.c
+F:	drivers/pinctrl/pinctrl-nomadik.c
 F:	drivers/phy/phy-ab8500-usb.c
 F:	drivers/power/pmic/ab8500.c
 F:	drivers/timer/nomadik-mtu-timer.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b474a346bf2..5b02ff18bd0e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,6 +1278,8 @@ config ARCH_U8500
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER
+	imply PINCTRL
+	imply PINCTRL_NOMADIK
 	imply PHY
 	imply PL01X_SERIAL
 	imply PMIC_AB8500
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index fd30aaeeaa89..04785a927fec 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -75,6 +75,13 @@ config PINCONF_RECURSIVE
 	  configuration; you can save memory footprint when this feature is
 	  no needed.
 
+config PINCTRL_NOMADIK
+	bool "Nomadik pin control driver"
+	depends on PINCTRL_FULL
+	help
+	  Enable pin multiplexing and configuration support for the Nomadik
+	  GPIO blocks in the ST-Ericsson DB8500.
+
 config SPL_PINCTRL
 	bool "Support pin controllers in SPL"
 	depends on SPL && SPL_DM
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 91149796bb5f..23219626e392 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
 obj-$(CONFIG_PINCTRL_MESON)		+= meson/
 obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
 obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
+obj-$(CONFIG_PINCTRL_NOMADIK)		+= pinctrl-nomadik.o
 obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
new file mode 100644
index 000000000000..12d032226608
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Linus Walleij <linusw@kernel.org> */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <dt-bindings/pinctrl/nomadik.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+
+#define NMK_GPIO_BANKS		9
+#define NMK_GPIO_PER_BANK	32
+
+struct nmk_gpio_regs {
+	u32 dat;
+	u32 dats;
+	u32 datc;
+	u32 pdis;
+	u32 dir;
+	u32 dirs;
+	u32 dirc;
+	u32 slpm;
+	u32 afsla;
+	u32 afslb;
+	u32 lowemi;
+};
+
+struct nmk_pinctrl_priv {
+	struct nmk_gpio_regs *bank[NMK_GPIO_BANKS];
+};
+
+enum nmk_alt {
+	NMK_ALT_GPIO,
+	NMK_ALT_A,
+	NMK_ALT_B,
+	NMK_ALT_C,
+};
+
+static int nmk_pinctrl_parse_pin(const char *name, unsigned int *pin)
+{
+	char *end;
+
+	if (strncmp(name, "GPIO", 4))
+		return -EINVAL;
+
+	*pin = dectoul(name + 4, &end);
+	if (end == name + 4 || *end != '_' ||
+	    *pin >= NMK_GPIO_BANKS * NMK_GPIO_PER_BANK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct nmk_gpio_regs *
+nmk_pinctrl_bank(struct udevice *dev, unsigned int pin)
+{
+	struct nmk_pinctrl_priv *priv = dev_get_priv(dev);
+
+	return priv->bank[pin / NMK_GPIO_PER_BANK];
+}
+
+static void nmk_pinctrl_set_mux(struct udevice *dev, unsigned int pin,
+				unsigned int alt)
+{
+	struct nmk_gpio_regs *regs = nmk_pinctrl_bank(dev, pin);
+	u32 mask = BIT(pin % NMK_GPIO_PER_BANK);
+	u32 val;
+
+	val = readl(&regs->afsla);
+	if (alt & NMK_ALT_A)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel(val, &regs->afsla);
+
+	val = readl(&regs->afslb);
+	if (alt & NMK_ALT_B)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel(val, &regs->afslb);
+}
+
+static int nmk_pinctrl_set_config(struct udevice *dev, ofnode node,
+				  unsigned int pin)
+{
+	struct nmk_gpio_regs *regs = nmk_pinctrl_bank(dev, pin);
+	u32 mask = BIT(pin % NMK_GPIO_PER_BANK);
+	u32 val;
+
+	if (!ofnode_read_u32(node, "ste,input", &val)) {
+		writel(mask, &regs->dirc);
+		if (val == INPUT_NOPULL) {
+			setbits_le32(&regs->pdis, mask);
+		} else {
+			clrbits_le32(&regs->pdis, mask);
+			if (val == INPUT_PULLUP)
+				writel(mask, &regs->dats);
+			else if (val == INPUT_PULLDOWN)
+				writel(mask, &regs->datc);
+			else
+				return -EINVAL;
+		}
+	}
+
+	if (!ofnode_read_u32(node, "ste,output", &val)) {
+		if (val == OUTPUT_HIGH)
+			writel(mask, &regs->dats);
+		else if (val == OUTPUT_LOW)
+			writel(mask, &regs->datc);
+		else
+			return -EINVAL;
+		writel(mask, &regs->dirs);
+	}
+
+	if (!ofnode_read_u32(node, "ste,lowemi", &val)) {
+		if (val)
+			setbits_le32(&regs->lowemi, mask);
+		else
+			clrbits_le32(&regs->lowemi, mask);
+	}
+
+	return 0;
+}
+
+static int nmk_pinctrl_get_alt(ofnode node, unsigned int *alt)
+{
+	const char *group;
+
+	if (ofnode_read_string_index(node, "groups", 0, &group))
+		return -EINVAL;
+
+	if (strstr(group, "_a_"))
+		*alt = NMK_ALT_A;
+	else if (strstr(group, "_b_"))
+		*alt = NMK_ALT_B;
+	else if (strstr(group, "_c_"))
+		*alt = NMK_ALT_C;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int nmk_pinctrl_set_state(struct udevice *dev, struct udevice *config)
+{
+	unsigned int alt = NMK_ALT_GPIO;
+	ofnode node;
+	int count;
+	int ret;
+	int i;
+
+	dev_for_each_subnode(node, config) {
+		if (ofnode_read_string(node, "function")) {
+			ret = nmk_pinctrl_get_alt(node, &alt);
+			if (ret)
+				return ret;
+		}
+	}
+
+	dev_for_each_subnode(node, config) {
+		ofnode cfg;
+
+		count = ofnode_read_string_count(node, "pins");
+		if (count < 0)
+			continue;
+
+		cfg = ofnode_parse_phandle(node, "ste,config", 0);
+		if (!ofnode_valid(cfg))
+			cfg = node;
+
+		for (i = 0; i < count; i++) {
+			const char *name;
+			unsigned int pin;
+
+			ret = ofnode_read_string_index(node, "pins", i, &name);
+			if (ret)
+				return ret;
+			ret = nmk_pinctrl_parse_pin(name, &pin);
+			if (ret)
+				return ret;
+			ret = nmk_pinctrl_set_config(dev, cfg, pin);
+			if (ret)
+				return ret;
+			nmk_pinctrl_set_mux(dev, pin, alt);
+		}
+	}
+
+	return 0;
+}
+
+static int nmk_pinctrl_probe(struct udevice *dev)
+{
+	struct nmk_pinctrl_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	fdt_addr_t addr;
+	int ret;
+	int i;
+
+	for (i = 0; i < NMK_GPIO_BANKS; i++) {
+		ret = dev_read_phandle_with_args(dev, "nomadik-gpio-chips",
+						 NULL, 0, i, &args);
+		if (ret)
+			return ret;
+
+		addr = ofnode_get_addr(args.node);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+		priv->bank[i] = (struct nmk_gpio_regs *)addr;
+	}
+
+	return 0;
+}
+
+static const struct pinctrl_ops nmk_pinctrl_ops = {
+	.set_state = nmk_pinctrl_set_state,
+};
+
+static const struct udevice_id nmk_pinctrl_ids[] = {
+	{ .compatible = "stericsson,db8500-pinctrl" },
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_nomadik) = {
+	.name = "pinctrl_nomadik",
+	.id = UCLASS_PINCTRL,
+	.of_match = nmk_pinctrl_ids,
+	.probe = nmk_pinctrl_probe,
+	.priv_auto = sizeof(struct nmk_pinctrl_priv),
+	.ops = &nmk_pinctrl_ops,
+};

-- 
2.55.0

