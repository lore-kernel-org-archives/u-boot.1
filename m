Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B0EC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7291340635;
	Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NY2W8QTmCR02; Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129656;
	bh=/5Ip2qvl5gP0QdyomgXWDVKRemqgr668y/d4iT/prEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJDP8EuHAb72qzijQqVFPA9BfBWcNrYmW8yRJ14PhX/wRbnm+0yx3ui3+TpT5An7d
	 MNFvBMAMJECkg7+dJ4wgqqoYz69FzpnHFYzRcnjNMYB5px44uMAK4aBmHduE2hlp0f
	 bBKq/foL/Ki1Jpo35h1vz3JXX6UgobTTImyRDL/Nv842nwagcrxy0IvIKm04BPwMSH
	 tnoyv9YKboCGvBpqn7POV0Lh7Di24kcK04NLAU6VQnXtG0dgwv7ktKLsHZYT0TfWVX
	 L3Fob2MY3ER8KIvehWLpYWDw+zMKVBiQnASHG7lcsS/gNb/fi/7LqZhbXRGPaGaxRP
	 A4G4a2hClM5wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC4B14063E;
	Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F652230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D2DC40042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaKvZ0Nd5PhA for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZkuFkry7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CDC640077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1265413D6;
 Wed, 19 Aug 2026 08:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778721F00A3A;
 Wed, 19 Aug 2026 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129651;
 bh=/5Ip2qvl5gP0QdyomgXWDVKRemqgr668y/d4iT/prEc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZkuFkry7roZEt8TeG7PZb68wyfO2qJA9ZCaBM9pqxU3eMWdwsrsZ+W35M58LJvFLr
 wEUy4+7bDgvccnIZQ3QGjEgHH5UbjFB7Q0t0MoLaFUVK1NfvDDTfDDgQg4EH++J9Yy
 eBzR33cKJDQEZX1rrR/ZgUBW1TIl3RQYZrSFH3gpTwOgoCdPAtLhwnb5QLbUTUG/ZH
 XeZ2tb8ZDRP9QIvYCcC6nY4liiLwUv33XMY83+cmpAJoEGX2qGjlUD/olO8Mf4jkzG
 BjbhBM0P6NkEllT7QQymAIqopKs6hHKm0EpMBsnAtaBZ2UOQnqgbIq+Ju/Pv5AWEbU
 7Nl1DjpWCts7w==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:06 +0200
Subject: [PATCH v4 01/12] pinctrl: Add compact Nomadik pin controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-1-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
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

