Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE56C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9E28607B5;
	Mon, 17 Aug 2026 13:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eoADg7dxX1N; Mon, 17 Aug 2026 13:34:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96606607CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973669;
	bh=XuQP6owN8QAvxNbZonGx+tZhP8eQUpQvICe6b/Xd+GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/vVXHQOnHe2uijHPo14LDBvCBMDDQGP+Gf38t6TMAWHb6tTGcTWU86UQpzxVmu45
	 6U5E5uNA15lO0AEVpMdON6UIbUzl7L1z6cKW2bYa0ucDEB7HatCUY59hfU4PNXgSJf
	 8+4B7Z4U0nWXKj7dNUHz6WmwKy7sfxEtqbo4UQIAKCOaLIL1zE+NfwVRHNTEzIMfzS
	 EUJipW8AYxc4VIZiY4IJBLCJjvgESmJMZT7iqzQjyMOmiwpXr4gQFxHEv+BVPljcIW
	 sjsyGMRHfrerBTGDiEHgdPBLkDAkjm8H7bIvm28imOEd7zTSIf6dLqnDp27CXayEa5
	 1VYPmoNMcqrcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96606607CB;
	Mon, 17 Aug 2026 13:34:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DB172EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 038D240099
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcoxhOI0yT5y for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:31:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 19AE240090
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19AE240090
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JFDquys0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19AE240090
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1EB6601FB;
 Mon, 17 Aug 2026 09:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346AE1F000E9;
 Mon, 17 Aug 2026 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959115;
 bh=XuQP6owN8QAvxNbZonGx+tZhP8eQUpQvICe6b/Xd+GI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JFDquys0EBSqS7hRBlzB4d5FiMddL+YNw/tL49j5vNGVWK7VR09yqrfV+iHh1eJdy
 8K9FrGVJtay6KPoAQNfU6VnI7fhGCw88d8lJ8mjpAxHrlJM1FEQdDLgyEg+k/RdFWg
 omQBPbdNQ3aIBRljHNawFQqEJVHLF2ET6fUW+ufpk9Vs8/hR5wuxVwaucoZNlfp6jq
 Kon9lV7VvcjqjGQOEKlWwnmWKr6uqiX9dxhU05D1Cp9Jscu02BRXWqIyPYowoUfiCu
 DoaimA+B+LZ9lQDuLcz0Lr3aDmwNakeu/g5DtbGN8EMIkbz885BtJcT2R9UAzNT+JG
 J1R60pksTJP+A==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:50 +0200
Subject: [PATCH v2 1/8] pinctrl: Add compact Nomadik pin controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-1-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 drivers/pinctrl/pinctrl-nomadik.c | 235 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+)

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
index 000000000000..56ec7edcca48
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Linus Walleij <linusw@kernel.org> */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+
+#define NMK_GPIO_BANKS		9
+#define NMK_GPIO_PER_BANK	32
+
+#define NMK_INPUT_NOPULL	0
+#define NMK_INPUT_PULLUP	1
+#define NMK_INPUT_PULLDOWN	2
+#define NMK_OUTPUT_LOW		0
+#define NMK_OUTPUT_HIGH		1
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
+		if (val == NMK_INPUT_NOPULL) {
+			setbits_le32(&regs->pdis, mask);
+		} else {
+			clrbits_le32(&regs->pdis, mask);
+			if (val == NMK_INPUT_PULLUP)
+				writel(mask, &regs->dats);
+			else if (val == NMK_INPUT_PULLDOWN)
+				writel(mask, &regs->datc);
+			else
+				return -EINVAL;
+		}
+	}
+
+	if (!ofnode_read_u32(node, "ste,output", &val)) {
+		if (val == NMK_OUTPUT_HIGH)
+			writel(mask, &regs->dats);
+		else if (val == NMK_OUTPUT_LOW)
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

