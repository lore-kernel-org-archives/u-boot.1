Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5BC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72D980BA9;
	Mon, 10 Feb 2025 17:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X4Rj2N5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F92880548; Mon, 10 Feb 2025 17:27:33 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD9080A55
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dc6d9b292so1827324f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204851; x=1739809651; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yOKm3WjOKoy+hx+tTAcG9B7csRkhuQtZDiAqQ1LozRM=;
 b=X4Rj2N5tjjFKYmWHkbz7n4+ezp/BZoGIRH5x79NHvnM+FYKnAhd8XwQ+PAby6evaie
 VvdBnXP+urM+DEXKHSYl8tnAEBuPypFWPlH3CM3m1521008DlxNUesrOYaJWLhZRhioB
 V5nrRSgP/OXUFz3u0cqnJAkQbDdH/MQg4EznDJoHG97k4HdPbS7EMHRtn9q5bVDiXs83
 gJkGfK4U9zZ5zwa1N4fmDaryxt4oBqUQT/o0oEMjHN/v4ZDCjcS1ULVhz5xAsgOXpdHn
 HASjEq0RTV+ZykHVXv/3q3Cl7QEoNdyazWmEMR9Tc6JHvjaeyq3uUrDrXvETZIY3bClN
 C1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204851; x=1739809651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOKm3WjOKoy+hx+tTAcG9B7csRkhuQtZDiAqQ1LozRM=;
 b=NABkQuW51R4Yq2gFlhCg3txleF4PcfPMqfwRoCr5FDdDVl0BTHVt9lgujt+HD3otQf
 Mqvld7mMBKuAhkuMbu2FEtjh8AX2g5TAQFYFMBSQdbY4F+kl9Gfvzbejdwxv90C/dQ3n
 iYt2ZsDgf2mp+35j+IiSeQJksi2AfwyVh4dw7vy2ryJ2lcFgSoL0YKcsnudgBQ37c0y4
 GVseBEo/kR0WD2DA5NFuEn5+SW5LXbX2MSGwIYlOVx38/oebetCwIv21OqHTMqvZ1VOg
 nyZ7qvejWEojNc3Y1y9chuvG7ZLr8DkTBzVG/INeL0WwQjW2D+kXvkihAZcnN9fU9B+Q
 3BGA==
X-Gm-Message-State: AOJu0YwIbqu/sWjECu8Tks4tOeYt0C9L8lu5iLRHPaQnHLUI+0GgeWuS
 14yafchm7Gd3H3BYXZKo7l3geEEPyQ18kMU9j1bMAQfXow+DgAflS8EWcmtX/o0=
X-Gm-Gg: ASbGncvjc4i0NMaiBoy5Cqn2fj4mhz59a0QJRybnp/jcKhpbDFaj1dve78kzvqjcJMf
 NTDVKdSkUdImyAENyIvjdWq/H77EFDaIV6vbT0DXs+dW0JFIfeHAQWE30+YeuMe+AT1SQdXA5sz
 t+95PY13uunmZTNOSa59R6wopm2SpP/tyqAtG8sA1bLGNmf/IHEu8KVrkw8YTunsxW+jarSyAXJ
 mgFBfx8HVXNe7XUW6jtnRtIXUcQbG0sQ1vR7aivOSn7kfxYzhonHWszC6VSxZvP7Hl4yAPJ948Z
 2Ml26IBzyg/MD+ComxNDtir1nlRgavw=
X-Google-Smtp-Source: AGHT+IESAQyI7RTxu1QGrXH/3rrjJerE9CouWHxvJUK9/dUU3aH2N9xh1gVeEMC5TSb9xZ15mEuw0w==
X-Received: by 2002:a05:6000:2ae:b0:38d:d4c7:d2d2 with SMTP id
 ffacd0b85a97d-38de4194326mr286825f8f.25.1739204850852; 
 Mon, 10 Feb 2025 08:27:30 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd6080926sm6648295f8f.83.2025.02.10.08.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:27:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 10 Feb 2025 16:27:25 +0000
Subject: [PATCH v4 1/3] clk: add stub clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-b4-clk-stub-v4-1-f1e7d845f57e@linaro.org>
References: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
In-Reply-To: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7QRmkNL6m86WDqZCYRbutbity6NHl7M2UqWOPzXq05w=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVGh8mfT0wLzVr7uVtsVdNQkJeeEdXFBZIf4oqYVpTd
 eVutlVMRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjItCcMf8UPCqan2bWrpiYv
 vSKUcTDzSMO9Npeo+IJuvYVXziQofWL4ZxUavmbjstwdN/i7VOQT60Ou29u/fLlX8CQfa/6kBzu
 cJgEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a stub clock driver which can be used to bind clock controllers
which aren't required for the platform to boot, but which are needed for
U-Boot drivers to work.

In addition, add a NOP parent driver to allow for binding the parent
nodes of the clock.

Initially this driver supports a Qualcomm platform where the MMC driver
tries to fetch the RPM clock controller, which is not actually required
for the device to work.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/Kconfig    |  7 ++++++
 drivers/clk/Makefile   |  1 +
 drivers/clk/clk-stub.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d9d518d70387120f6261ac4a6ae7038992c5f888..18bd640a68b60a9ba8a87fcd1d5489140653c344 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -95,8 +95,15 @@ config SPL_CLK_GPIO
 	help
 	  Enable this option to add GPIO-controlled clock gate driver
 	  in U-Boot SPL.
 
+config CLK_STUB
+	bool "Stub clock driver"
+	depends on CLK
+	help
+	  Enable this to provide a stub clock driver for non-essential clock
+	  controllers.
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS
 	default y
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7f84f22d4b1d100a1116db4c71b067e30283d162..fe0e49f6112e19e86db29c2b039d67ded774eae9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -10,8 +10,9 @@ obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
 obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
+obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 obj-y += adi/
 obj-y += analogbits/
 obj-y += imx/
diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
new file mode 100644
index 0000000000000000000000000000000000000000..ea817031fa6c0cc1ea21000273b5651be5d05e65
--- /dev/null
+++ b/drivers/clk/clk-stub.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stub clk driver for non-essential clocks.
+ *
+ * This driver should be used for clock controllers
+ * which are described as dependencies in DT but aren't
+ * actually necessary for hardware functionality.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+
+/* NOP parent nodes to stub clocks */
+static const struct udevice_id nop_parent_ids[] = {
+	{ .compatible = "qcom,rpm-proc" },
+	{ .compatible = "qcom,glink-rpm" },
+	{ .compatible = "qcom,rpm-sm6115" },
+	{ }
+};
+
+U_BOOT_DRIVER(nop_parent) = {
+	.name = "nop_parent",
+	.id = UCLASS_NOP,
+	.of_match = nop_parent_ids,
+	.bind = dm_scan_fdt_dev,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+static ulong stub_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong stub_clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+static int stub_clk_nop(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops stub_clk_ops = {
+	.set_rate = stub_clk_set_rate,
+	.get_rate = stub_clk_get_rate,
+	.enable = stub_clk_nop,
+	.disable = stub_clk_nop,
+};
+
+static const struct udevice_id stub_clk_ids[] = {
+	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sm8250-rpmh-clk" },
+	{ .compatible = "qcom,sm8550-rpmh-clk" },
+	{ .compatible = "qcom,sm8650-rpmh-clk" },
+	{ }
+};
+
+U_BOOT_DRIVER(clk_stub) = {
+	.name = "clk_stub",
+	.id = UCLASS_CLK,
+	.ops = &stub_clk_ops,
+	.of_match = stub_clk_ids,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+

-- 
2.48.1

