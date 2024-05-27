Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C16DC25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B10A88167;
	Mon, 27 May 2024 19:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D35aOUbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC6887F6F; Mon, 27 May 2024 19:12:17 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9386C88167
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5295e488248so3843986e87.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716829933; x=1717434733; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c73lmDzoggzLalXI0aOUnTjbEGf7tlD5nh2ao3784ws=;
 b=D35aOUbCdR+rjfDCCtVvT+jUm4cr6h9BafigggVh5YcvCSq50iUhGAAJC35D8qRkQZ
 JkbYzdYellBoH5xLBt69CECMj4N7pMXfG04ovraiZ2ACWLZMugIqpFVdgnI6sg5dqOMU
 9lrCYgj1SuobiPxxglyvtkGEghVLw0efqFRksTZ9IMGDqmhe6fmHsv9nGoaf2GX/ix55
 biTP09TPPq1pgRQQ6lhjXAErzJYxCAdz/VChw4o/CiVwbIF1Flx94d+X/VYC6FWA0pCL
 9z0i4E/LBvmVt3IKhyF4SgEPTZmMWk5e8TtdDRhNLBx5h9AQ1IjSvf8dalvtxya1k+Ti
 2RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829934; x=1717434734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c73lmDzoggzLalXI0aOUnTjbEGf7tlD5nh2ao3784ws=;
 b=YSsoowQPS5uytvxTwXoG9kzIZFzow57PgyymPAxYy+2gm9kFHssPIYGn+DutE0uAtb
 EFNmQlkqk8PW/ZoSzWItvKTvnbBhtZ+5KmGQaAELIGS+QZ7uoxOc/A2/GsWnBzXWoMz4
 yrfQ91xUkcZVJTmb/6Co0NwA5equoX/f4W3h8D7qV12eC9Jwg0HDEUllDt6QZas8+Yl4
 P53Pk+ebgZegBl+2hnpAcGhLyEPT+EqPLan3ys3xPUvfRZ6ozrd58+YACjL1yAqb+BDO
 h4mAWKdhLDSTbf75MsKC2Y4hwfud4Fv56Q4WthjOCZbUkn67JyMNj8+ytcN3P3L5mALD
 yIkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ3uRsJiMLNfEl3VePXxAsUppjieGzPHfWHLz5Kf8fxS3DLdOjTI/dT0WxxVLH5J80yUazye+RoQLN7P9GrKeF5P98SA==
X-Gm-Message-State: AOJu0YwF38ALAW8hoBLb2E8k61TJrojiNb2//R7YSKvONe9hhA3RIuDF
 6QibaA0MVrju6nYj7lTvYmszxOzuXSDwbV4yQsRxVH/nWPfEgDOUydXN1FalADA6e7OQ8cP6O99
 yeXw+hQ==
X-Google-Smtp-Source: AGHT+IHIMoPusrAJlK8vPwprBExDUgxeOl+afe/s1c7LXJ7r8aWR0QMYCIVw4twazlPYXVMKmHUU7A==
X-Received: by 2002:a19:7502:0:b0:524:68f8:9566 with SMTP id
 2adb3069b0e04-52964bb2c9dmr5864218e87.30.1716829933590; 
 Mon, 27 May 2024 10:12:13 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda7cd3sm508009566b.216.2024.05.27.10.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:12:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:12:07 +0200
Subject: [PATCH v2 1/2] clk: add stub clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-clk-stub-v2-1-29013855e343@linaro.org>
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
In-Reply-To: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PwpFiXjAnydMjt8UR0PoPKsrt1R+GU+Vc9dPW5XIQyo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVL7r+Y13TZNXrpDyigTyZSZ57s9mCFbKxDnha
 C4zDOOo0FmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlS+6wAKCRAFgzErGV9k
 tuMeEACBkB3+ETph7+2npLZBCDuv5tGvsFp/VTur16pLwpatHi6nHd1KraFKwTCYoHG9EpbmuDx
 LPUUZrfz2UNgKN71F8Hp7L11cnZFiXkEcDw9XsMRITSe2dDE4dXFOntEyFPojv4iqwgMPPViYqV
 F9pgqvkCBGc/Y/E7rOvY55tu219FUXRZS/fBGELNt4+lN8ogblsxkypSlJH/OPhCIGdkxknoPqj
 XXOM5gzyI+yNQrugDNBbnTXSGuUbi9tBjvo6P7dkSKuHi9Xld4i3M9IxMQGkBiI2ZlQFaHUjIiC
 P8db2qr0QRwKbN+vmN87qofoiOfVdEl/FbohMVKLqiq3GwnwyIwsCOAUsUL+ikQxSQiZLfWJjV9
 giClgLmQsLrASpGFbFxXtmfo0yZmSZ5xE8mYY6z4Xn65eV7IdGjcgFTKYJU6NI0AFEBPjMjM5KR
 xHokBtBaTDJ12S+jDIjNtR8yah4MVjNACUzGGmG5itinrYqwY0PUS+epRzV0Pf0J9OmyU0qo/bn
 c0ELhoLOUZPVosJOiWMHKWJHffepqnE+h5Fac9a4lD1oyoCcEH2Uax//ONy40ybHDSsJ0d0J/V2
 Ei2tQOZcXU4Z/JK/Ahsdhbk8KVuUuQzt08+U2WTj41BcYYoZaI06MhJo3SUTXlx1T8jTDDNF+iV
 nBdIZxk4H9tdNfg==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/Kconfig    |  7 ++++++
 drivers/clk/Makefile   |  1 +
 drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

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
index 000000000000..3f9c758ef115
--- /dev/null
+++ b/drivers/clk/clk-stub.c
@@ -0,0 +1,63 @@
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
2.45.0

