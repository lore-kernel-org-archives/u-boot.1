Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EA606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BFMLoe7y;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLgBB2CE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0078F40ABA;
	Fri, 23 Oct 2026 22:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEicCOETUQ3b; Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D72D40A8E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793919;
	b=eft6ItxSNhN1kM5LHJI9HHVepbxXXz+mEsZD5TY8tmwrk0AGkLoC8lTI1l+HpVev8tb6
	 j4DJ4BXq6B2ufGbOt1/Oru7Piz+v8eCsqaJrKm7OKNWESSY9ACJmOEh8/kVEqiMgSfT9h
	 L1AHi/vlf59szX0437sdYxiAhMWit5BkrTdIEAYFLKJ9z4X7OvlemaCrojS9Gkl1QtBGe
	 O+3x2lcpZY4zhWdj+qExAHMLZBFIF2Hngn25YU274n76qaLOnWo6WGA/Mqs9rmR5XKJni
	 VEYgauh+jqRdyf/Wg5tVrAeFt9QGR/Fg8s2Jj3DVMgU2wVo/RZF9J+hAzlDhMVusvqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/G2eOQt0JndgBYZpsaJJivjckApfAF2aO2zVtHEvCT4=;
	b=RAeHnEGtEu9SNeyvE9yPFbjB+nKMVuCYy7Gbdlc/liGdtdEwZWHg0pWK2x1fXJ6Yxq+6
	 6/eWHJcbrUBah7yyK/TO77Xjpm4K/PrsvTiQJQJlTCqwuG7NBqzgBX/nM/d0BxmfBuY5G
	 c3wPzbkbwmNJ81vH0WFJc02wzIeJXe9/LRH5IzNctP8/9a0GOd6doy4LpYEBU8vOhJ5mw
	 gaHaLK7Qo6Vyd0H8Fv67+3hD1q7RCa+6f1Dg98pmw0Pn1p8TNdr5GBulJ1oijzdn8ECIT
	 zU9JRGMGBzeXnwyI1zIWMxOOyaEwFwcqbmujtRrIF8xhFm8PDZgAJhRudrLX02iwNnw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLgBB2CE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793919;
	bh=/G2eOQt0JndgBYZpsaJJivjckApfAF2aO2zVtHEvCT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFMLoe7y/6NWbdjLLLL6AZCZK5gEIPtKsdPPFaFsaqJqDSAppzPlwMM+A09xfXhxl
	 dT1CK4dnOk6tx5n1C4F1Ikb267SFDfn9o10E8xIIXhccQprMjpqV3xf20cnEAo1nvw
	 eNcu3lb5NACd7qsrwP2SJdWb6yllHXAMNPoQrHnX3iawLyU9lEyma3MVFjBSSIc63D
	 L9+qrIkwUfZ6uJFZxhvJyV0wCXnnzn4pQ9JNFtC2ncB8P8yIkZJ/7a6sLu7Xn6ktgu
	 s9iLme4fG2I0BzLdO0LfX9Mp2O/jKXwaaBr3zquS0EF099wBE1jAgsvapfra0kJsHz
	 a+VNycMf7ENbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D72D40A8E;
	Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C8E8D3C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEB3A40A8E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ4KQLKDhYDl for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3C2240A6C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793916;
 b=FrCDhlLOkENsz1oK7cZ+bEOJRhLH6qjB+BnYSCP4ZEzSAL19uxG0hscs7LNfSMWIk5yv
 YIRuzERGKSYWrSuKSb3Hsy2lpeVq6YhePO8bhE5xFO+f0rpaCAq3XsYjuW4H1nr3VWsIn
 GSL6D3+7QPIMdsUMNJZR/UoczbI3trxnvia01yfyb2wnIhqEKKKGAN/FFqFrF/TLW5Ndt
 yKFODKut7ghhIL4kgqKvNy6cHFHjfWNoTRAKDTlsfVRVLnSmdBVBiBbE3y+Y6jSCS5Z89
 k9I4T+Z/+gCrws4pxYApOKTky59FsNHGZvOBlmWzHS1KEoV36+zm4nVzlBeayxqOqVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793916;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=/G2eOQt0JndgBYZpsaJJivjckApfAF2aO2zVtHEvCT4=;
 b=Li4hNqOHZUzagRFZL5ZxicTsQvrkIPW3/Hswbmlph7Q/jygsXkgq0p3ZjVq8JeM4dNRu
 ygS6zFwzM3dTqKl4gWUoGoXS+5c5OslGGeI3EJZME0Q9P/uvqP0LiUpGuM2iowZ53EtfB
 pP290MTD6+hTS8JFNmwvC+tBz+4hGl6C2Q+G7hDwtJ2c4BlvbMCYCL5NitU9tvEPywZy4
 +v39cGMjNS8sfOCtCVRDLDp0O2ilGVv7GvnvgT5Zg5iDnEelCOJZuKgsl3O0+iDagE1uF
 hML6Jb1xwZb3RNBnJtG7NyS3JSqCULRLJz7oD2OPd99dv1dkh2F86d8qtVa+X4k2ROQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HLgBB2CE; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HLgBB2CE
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3C2240A6C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 208CF601F6;
 Fri, 23 Oct 2026 22:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398441F01825;
 Fri, 23 Oct 2026 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793914;
 bh=/G2eOQt0JndgBYZpsaJJivjckApfAF2aO2zVtHEvCT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HLgBB2CEgLsq7WB0ap1WtMhVnyYAu6DewSIis+rJjxJoqYfsopmQ2rY/8B/lj+Eoe
 Ek3dAEICBxzgrZY6kouQb/a4hpRVequzq7aPVVxDvAtt1P4vXTFc+Fij1jetIYRXXL
 GTsGgbHTNdjdHnENezvY6nJUBq8ldk1fP54YCYQAez6jpBGw8KJVD/RjBhuuOnTWqv
 /KgNtgI+8suWhLVEZI/PQ6w/f+uzZM1T2OqXtbJG97Je/bfiwqufIWZgeDbPyKqYHk
 qpvlPO84n9w0in8FItHH3Q7KIKPD9eHWJo4hm8FFtflPgxsmW8IYjmgudNwNF2bGhj
 gU4Rg2YAo2MNw==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:28 +0200
Subject: [PATCH v8 1/8] pinctrl: Add compact Nomadik pin controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-1-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the minimal pin control support needed to consume default states from
the upstream DB8500 device trees. Resolve the nine Nomadik GPIO banks
through nomadik-gpio-chips and apply the mux, direction, value, pull and
low-EMI settings directly to their registers.

Only the DB8500 binding and default-state configuration needed by
U-Boot are supported. There is no GPIO ownership or sleep-state
handling.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                       |   1 +
 arch/arm/Kconfig                  |   2 +
 drivers/pinctrl/Kconfig           |   7 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-nomadik.c | 230 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab30..dbf523e21107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -774,6 +774,7 @@ S:	Maintained
 F:	arch/arm/dts/ste-*
 F:	arch/arm/mach-u8500/
 F:	drivers/gpio/nmk_gpio.c
+F:	drivers/pinctrl/pinctrl-nomadik.c
 F:	drivers/phy/phy-ab8500-usb.c
 F:	drivers/power/pmic/ab8500.c
 F:	drivers/timer/nomadik-mtu-timer.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031b..8997a82f4f04 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1309,6 +1309,8 @@ config ARCH_U8500
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
2.56.0

