Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0EECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0DB88D92;
	Mon,  9 Sep 2024 12:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hbxWnKrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63DC88D9E; Mon,  9 Sep 2024 12:30:39 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0280C88D90
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso5150936a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725877836; x=1726482636; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Tg0yGhCeynPoopXMy/zO+g/9tX24fuKz6fxt4JmCcE=;
 b=hbxWnKrBZ9M2hYJpZJmmizpvYEqdno3pkob4akME2EwFU8WHk7xAib18LMy5FM1wEG
 DSk6EEJWrgxH4oiu9ZnDq66HSM5Yj2plwvwtT/nIHZlPgpd5cH0KZcM2ltmUAD2t6vA1
 IWl0/xFFNBLWd1fHU8UAEBbkMAAe+AzVkOGkujh+aimlAW37Wl51hl5kkv8xirpkDTNZ
 1GoBi+9tmlvPueanyVyaoWh3a4/EDMggwCQZnJX9p+2QgICXQvI7WJ8UBpFlVlzkbrYW
 sGcr/y8Hj7UIJr6tKc7bhPG5hL4BYHKU6UNk156sIvtO8YzBHRbf1pdz83fCwd+pgdPI
 LZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725877836; x=1726482636;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Tg0yGhCeynPoopXMy/zO+g/9tX24fuKz6fxt4JmCcE=;
 b=mWnJyznYYnxFEyRGQF0ugIUfOylAzv4AsV9lj73VDteqY7eNXvOTiD4bmr+N4nst5s
 Tbm3buJaTXEMXPrVuopuJzdkR4XdoM9NgqT7Wpc7BsFA296rCnquhBZ91Rh4JHxVLUJk
 vYWDeHNpAf9szg2/0if7AvlBYgjFtUIIRuqwY9cqIEH8DOiaRDC1nIcNp2PBD7Y/T3Dp
 kO4F56MRKKfGn8IGYAtof9htIxrNhIoxYTWRQxwkNGBe+E3GS8rzC8/qEMIVsSIr+4AP
 7+P4MeRY2uVXhPy35Fm5qe08V7dPZC9CTxsWoxqIKCK1gfukTRTQ4bjfUWw9pXg73j1v
 O5fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrDOu7X5yNiWBAb98kAsAEkxgryLlue8uXK/Q+zXDwxy+eYN/g3aVNREyHudZECuNoQbAgPM0=@lists.denx.de
X-Gm-Message-State: AOJu0YyEom8jMDLaL1GSMSPJMAfg4aHqDi6/91/1kqmHkhq4TNpUZgv3
 I2aD3p0kVCi0+cxkHYraFCoHw9zxbSxR6oi7xbz1/22n7odVXUZeLDZlfK9ag2M=
X-Google-Smtp-Source: AGHT+IHK2Vw2oagKFoOwGTQSAObJEW0iwhmi0hrB69c1dQvcF1+/EOQ/bOH+u0BXXeT4ztWbVaXgsw==
X-Received: by 2002:a05:6402:210f:b0:5be:eaf1:807d with SMTP id
 4fb4d7f45d1cf-5c3dc7c6ac3mr7644330a12.29.1725877836260; 
 Mon, 09 Sep 2024 03:30:36 -0700 (PDT)
Received: from lion.localdomain ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46733sm2822287a12.27.2024.09.09.03.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 03:30:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 09 Sep 2024 12:30:32 +0200
Subject: [PATCH v3 1/2] clk: add stub clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-b4-clk-stub-v3-1-ef09307534d5@linaro.org>
References: <20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org>
In-Reply-To: <20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZIk8UXySrEHliSvXd9uuEZL7QA5mJlIxGrtnmtGB8mA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhrR75zxsNx4JUIo98EZI8tcvU8M/ejM3pem3mMTs4A6Wm
 iJlwPmmo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykfB/D/xCdbX/krrQE1iUG
 6j99+9fzrb6rcXM7a7dwwcQvLeZbPzEyLPoj3LuZp3s79/5DM7byCXxa9CfBql655YekYvKpTew
 rMwE=
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
index 9acbc47fe8ed..965bc4959403 100644
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
index 847b9b291100..b2cea41419b7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -10,8 +10,9 @@ obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_COMPOSITE_CCF) += clk-composite.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_GPIO) += clk-gpio.o
+obj-$(CONFIG_CLK_STUB) += clk-stub.o
 
 obj-y += adi/
 obj-y += analogbits/
 obj-y += imx/
diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
new file mode 100644
index 000000000000..ea817031fa6c
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
2.46.0

