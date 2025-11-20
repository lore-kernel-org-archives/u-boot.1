Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08E1CF64A2
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAAF8407B;
	Thu, 20 Nov 2025 09:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aOMP/h3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F33084062; Thu, 20 Nov 2025 09:13:08 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2F984057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so2883905e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626384; x=1764231184; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bMtyf+TkfUqWxq9yH6jOchm5ZvcDrNOdePOUcBnugkA=;
 b=aOMP/h3PiUfVrWoKswTYckvha8Op+gsaFi3OB4Ym+7AgZu/cdfCo5KNszvZgCNpZDc
 CmFZr0d71fiUSOAR5J80vR2QPSQMCdF+otBhIRR234Mt+BYwM95lxgEZ5LqD+hnbCA8a
 m4NAnwupvON8so8ObaxxF8+eCIufp2txZ43F08VzPrUpw94IvFKcXX9gB1zdXwiXdsYy
 /Q53/I+rR8uVHsTaXDY97RViUhuAJdIhndgHrCn9mAE6bsPW1NoxlcBE6ysrfJgOq4V7
 l9ECkbTFs0w8meOBE1NQrOFFcaAG4jmVRKS3F63xyyZ0e8MziLL4sJIYGFX5ubxbEwOz
 cLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626384; x=1764231184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bMtyf+TkfUqWxq9yH6jOchm5ZvcDrNOdePOUcBnugkA=;
 b=BC6W9wX+BtqFOCN2b8BzY18HB0o6U6rW4RnpQ3JrjwLltTHwGLa4lP5HJ/vPlqpsOw
 vMqcOFSnR2OdQsfoINoQQZpKTlXM48YafsfZAK7eHejmhzLcDMkdFQDGg8mjLLHK5uFV
 2q6ApWHYwShi3hDjq0QDmkbazYDCYV/KohBUmotF4huh4CPuYYwDCzrXRD1zofpjXssZ
 Ev8D4ikkw1hNwyvkAs22+Hh7jFM5WBDxqBwg1r/Y9A0XSsyn5RG5wHuRaEuYEES6KcGw
 93qYIwDL0LAcA+EwRXbVECAley99Fpr1dlM0BG9I8hnizMP0FlfVF6IL1iyw1PtXQr/E
 3idg==
X-Gm-Message-State: AOJu0Ywp83atDmSJ3q5MdBt2f3coXCJ/gCzBHpAVcG76aJUvn3ldatWD
 VTjs6yaDMMJdbCzW66a11CAaHpy/h6qpJ1GX8/h7y4y9H9IorpUAgaPXQadsWiskEIA=
X-Gm-Gg: ASbGncukzBctibDzq4IIA+j+8zfABINc3ZT7vLmZ6qpeV0heZo7ypFi75IxNUPeEwPo
 P9ugne8EqQq3wSKo4LTeNgpKmbxkiVaDEMOXcFyR+n+YvG/IE4C3EsdL35lW9FWLpxrWJ4qVK8F
 ENVmiUmq0gUvm8PViW0V3KtixCIHWhLUzxJrUPyVa1kqypArq8D7AI6UHrcur0T8LYyclsC5B2x
 IYIcKxghdP8Vst1WlawRoes2Ejl3+I3dE1YWWPTFhK8bcfGZWsSPRIZSccFn7M5XUBp1mJ3mxPC
 8o9cF4yX6KcwcpZ0ehsutQn1mGLmRN/2ZHkrstsPw476YzU5sIH7exAlhI/v/r0Rl3rNV68cCt1
 KfU9fZk2edA5L9mAm7sRywFxLye9WxEfaEtfVWpbLPVvYuxYv239ZqLFzicvljMd799Wt6Hhi+V
 bEjzLgy2e81wrb01LP/mo9QpJfCdg4lyCc0ihEstkRCA==
X-Google-Smtp-Source: AGHT+IGeDwF3VFQANYY2kdD8G03XfOQTA/aDVp9jnOq7oKed4r/LwCF5A9Ciyog6E9O8B29Ve77zSg==
X-Received: by 2002:a05:600c:19d3:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-477b8a8f296mr21985645e9.17.1763626384125; 
 Thu, 20 Nov 2025 00:13:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:13:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Nov 2025 09:12:53 +0100
Subject: [PATCH v5 2/7] interconnect: add DM test suite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-interconnect-next-v5-2-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=25435;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DEOhFB/kjZpKWJ7WhLX0DT8E10o00BR5ipnh05u8W34=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2IYxIGIvruXNWvak0TCJmMLcQtn8xQG0sOoJt0
 M/NowyCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NiAAKCRB33NvayMhJ0UfTEA
 DB65xJntPuug44XdbXUd223QsUP9jj0aacThwGdKgxU2djgao26c8trOlEZ1PId5Kc01THg2LJFzJU
 I7NJ3vlJsm24bhFQBgXq64Nm4vqXFOiVAPqbW6+Ql4h3uoXLzat9i67aWPiqn7F7v4xXzV+7ZkxY/7
 xOBSoL3Bwde0fVBiPC6TJLeJTWhHrIAqJ4Eb463jPKrv5TfbEphrGF0kqi0lVZhBT1KoUjfmBgG5qP
 rEr2/OzUbmtMhdOjnp9djpv72OPZB9GuNUc3VuKNPyFyc/5+68lFj8TYXHgq+KKqz+FEwej8GK+6cG
 e2PPz6v6IeC9IZ3YksT6gsPMTSB9yMSZwIx3RRKlmD4CcoZYDJCjlhtYEuEWXhzqmFBADMGT+zNr7h
 QExajFFXbeBnTzfA2tr/c3X5DstLmHYnR9rKwo8IhKZCZQ/CqZfXtDI1mv9aPNPL0kZLQQZ2CcW4FU
 WwPI3MMlkFDn5wPk8k08kjaxOmwn/ruqDS2dGvXWo6dm8bsfbEVsdXAy5NPy//dHO3aQWtprC44X5g
 Yo6rSAJiovmJjW6keL9tNyPtfwnErHfa6wc3WKQDrxlOcZJwdASpsI9w3RSuw0qE15/3qrHuVzCPz0
 XcZ1374edAP7Zuf5+7F9mLZwLA3oa8+7MEfdHD/Q2KlDyt6XfjoViHos6TDA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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

Add a test suite exercising the whole lifetime and callbacks
of interconnect with a fake 5 providers with a split node graph.

The test suite checks the calculus are right and goes to the correct
nodes, and the lifetime of the node is correct.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/sandbox/dts/test.dts                        |  36 +++
 arch/sandbox/include/asm/interconnect.h          |  19 ++
 configs/sandbox64_defconfig                      |   2 +
 configs/sandbox_defconfig                        |   2 +
 drivers/interconnect/Kconfig                     |  10 +
 drivers/interconnect/Makefile                    |   1 +
 drivers/interconnect/sandbox-interconnect-test.c |  89 +++++++
 drivers/interconnect/sandbox-interconnect.c      | 303 +++++++++++++++++++++++
 test/dm/Makefile                                 |   1 +
 test/dm/interconnect.c                           | 195 +++++++++++++++
 10 files changed, 658 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 13d8e498b03..0b3fc505e53 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -864,6 +864,42 @@
 		};
 	};
 
+	icc0: interconnect-0 {
+		compatible = "sandbox,interconnect0";
+		#interconnect-cells = <1>;
+	};
+
+	icc1: interconnect-1 {
+		compatible = "sandbox,interconnect1";
+		#interconnect-cells = <1>;
+	};
+
+	icc2: interconnect-2 {
+		compatible = "sandbox,interconnect2";
+		#interconnect-cells = <1>;
+	};
+
+	icc3: interconnect-3 {
+		compatible = "sandbox,interconnect3";
+		#interconnect-cells = <1>;
+	};
+
+	icc4: interconnect-4 {
+		compatible = "sandbox,interconnect4";
+		#interconnect-cells = <1>;
+	};
+
+	interconnect-test-0 {
+		compatible = "sandbox,interconnect-test";
+		interconnects = <&icc0 0 &icc3 0>;
+	};
+
+	interconnect-test-1 {
+		compatible = "sandbox,interconnect-test";
+		interconnects = <&icc1 0 &icc4 0>;
+		interconnect-names = "icc-path";
+	};
+
 	i2c@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/sandbox/include/asm/interconnect.h b/arch/sandbox/include/asm/interconnect.h
new file mode 100644
index 00000000000..17065bf6a11
--- /dev/null
+++ b/arch/sandbox/include/asm/interconnect.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#ifndef __SANDBOX_INTERCONNECT_H
+#define __SANDBOX_INTERCONNECT_H
+
+struct udevice;
+
+int sandbox_interconnect_get_bw(struct udevice *dev, u64 *avg, u64 *peak);
+int sandbox_interconnect_test_get(struct udevice *dev, char *name);
+int sandbox_interconnect_test_get_index(struct udevice *dev, int index);
+int sandbox_interconnect_test_enable(struct udevice *dev);
+int sandbox_interconnect_test_disable(struct udevice *dev);
+int sandbox_interconnect_test_set_bw(struct udevice *dev, u32 avg_bw, u32 peak_bw);
+int sandbox_interconnect_test_put(struct udevice *dev);
+
+#endif
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 169d0a2adef..1603e86d184 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -202,6 +202,8 @@ CONFIG_PINCTRL_SANDBOX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SANDBOX_POWER_DOMAIN=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_SANDBOX=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_ACT8846=y
 CONFIG_DM_PMIC_PFUZE100=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f4c2cc5d155..57d5b1f15ca 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -281,6 +281,8 @@ CONFIG_PINCTRL_SANDBOX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SANDBOX_POWER_DOMAIN=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_SANDBOX=y
 CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_ACT8846=y
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 38d39651ab5..e9f4cc662ae 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -7,4 +7,14 @@ config INTERCONNECT
 	  Enable support for the interconnect driver class. Many SoCs allow
 	  bandwidth to be tuned on busses within the SoC.
 
+if INTERCONNECT
+
+config INTERCONNECT_SANDBOX
+	bool "Enable interconnect sandbox driver"
+	depends on SANDBOX
+	help
+	  Enable support for the interconnect sandbox drivers.
+
+endif
+
 endmenu
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 1f276e98051..04b18589b7f 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect-uclass.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_SANDBOX) += sandbox-interconnect.o sandbox-interconnect-test.o
diff --git a/drivers/interconnect/sandbox-interconnect-test.c b/drivers/interconnect/sandbox-interconnect-test.c
new file mode 100644
index 00000000000..ff5f327f6da
--- /dev/null
+++ b/drivers/interconnect/sandbox-interconnect-test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <interconnect.h>
+#include <asm/io.h>
+#include <linux/err.h>
+
+struct sandbox_interconnect_test {
+	struct icc_path *path;
+};
+
+int sandbox_interconnect_test_get(struct udevice *dev, char *name)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+
+	priv->path = of_icc_get(dev, name);
+	if (IS_ERR(priv->path))
+		return PTR_ERR(priv->path);
+
+	if (!priv->path)
+		return -ENOSYS;
+
+	return 0;
+}
+
+int sandbox_interconnect_test_get_index(struct udevice *dev, int index)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+
+	priv->path = of_icc_get_by_index(dev, index);
+	if (IS_ERR(priv->path))
+		return PTR_ERR(priv->path);
+
+	if (!priv->path)
+		return -ENOSYS;
+
+	return 0;
+}
+
+int sandbox_interconnect_test_enable(struct udevice *dev)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+
+	return icc_enable(priv->path);
+}
+
+int sandbox_interconnect_test_disable(struct udevice *dev)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+
+	return icc_disable(priv->path);
+}
+
+int sandbox_interconnect_test_set_bw(struct udevice *dev, u32 avg_bw, u32 peak_bw)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+
+	return icc_set_bw(priv->path, avg_bw, peak_bw);
+}
+
+int sandbox_interconnect_test_put(struct udevice *dev)
+{
+	struct sandbox_interconnect_test *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = icc_put(priv->path);
+	if (ret)
+		return ret;
+
+	priv->path = NULL;
+
+	return 0;
+}
+
+static const struct udevice_id sandbox_interconnect_test_ids[] = {
+	{ .compatible = "sandbox,interconnect-test" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_interconnect_test) = {
+	.name = "sandbox_interconnect_test",
+	.id = UCLASS_MISC,
+	.of_match = sandbox_interconnect_test_ids,
+	.priv_auto = sizeof(struct sandbox_interconnect_test),
+};
diff --git a/drivers/interconnect/sandbox-interconnect.c b/drivers/interconnect/sandbox-interconnect.c
new file mode 100644
index 00000000000..0fc0e3e0d49
--- /dev/null
+++ b/drivers/interconnect/sandbox-interconnect.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <interconnect-uclass.h>
+#include <asm/io.h>
+#include <interconnect.h>
+#include <linux/err.h>
+
+#define MAX_LINKS	2
+
+struct sandbox_interconnect_node {
+	const char *name;
+	unsigned int num_links;
+	struct sandbox_interconnect_node *links[MAX_LINKS];
+	u64 avg_bw;
+	u64 peak_bw;
+};
+
+struct sandbox_interconnect_data {
+	struct sandbox_interconnect_node **nodes;
+	const unsigned int num_nodes;
+};
+
+struct sandbox_interconnect_provider {
+	struct udevice *dev;
+	struct sandbox_interconnect_data *data;
+	u64 avg;
+	u64 peak;
+};
+
+/*
+ * Node graph:
+ *                   ______________________________
+ *  [ NODE0 ]--\    /                              \   /-->[ NODE3 ]
+ *              |-->| NODE2_SLAVE --> NODE2_MASTER |--|
+ *  [ NODE1 ]--/    \______________________________/   \-->[ NODE4 ]
+ *
+ */
+
+static struct sandbox_interconnect_node node2_slave;
+static struct sandbox_interconnect_node node2_master;
+static struct sandbox_interconnect_node node3;
+static struct sandbox_interconnect_node node4;
+
+static struct sandbox_interconnect_node node0 = {
+	.name = "node0",
+	.num_links = 1,
+	.links = { &node2_slave },
+};
+
+static struct sandbox_interconnect_node node1 = {
+	.name = "node1",
+	.num_links = 1,
+	.links = { &node2_slave },
+};
+
+static struct sandbox_interconnect_node node2_slave = {
+	.name = "node2_slave",
+	.num_links = 1,
+	.links = { &node2_master },
+};
+
+static struct sandbox_interconnect_node node2_master = {
+	.name = "node2_master",
+	.num_links = 2,
+	.links = { &node3, &node4 },
+};
+
+static struct sandbox_interconnect_node node3 = {
+	.name = "node3",
+};
+
+static struct sandbox_interconnect_node node4 = {
+	.name = "node4",
+};
+
+/* xlate mapping */
+static struct sandbox_interconnect_node *interconnect0_nodes[] = {
+	[0] = &node0,
+};
+
+static struct sandbox_interconnect_node *interconnect1_nodes[] = {
+	[0] = &node1,
+};
+
+static struct sandbox_interconnect_node *interconnect2_nodes[] = {
+	[0] = &node2_slave,
+	[1] = &node2_master,
+};
+
+static struct sandbox_interconnect_node *interconnect3_nodes[] = {
+	[0] = &node3,
+};
+
+static struct sandbox_interconnect_node *interconnect4_nodes[] = {
+	[0] = &node4,
+};
+
+static struct sandbox_interconnect_data interconnect0_data = {
+	.nodes = interconnect0_nodes,
+	.num_nodes = ARRAY_SIZE(interconnect0_nodes),
+};
+
+static struct sandbox_interconnect_data interconnect1_data = {
+	.nodes = interconnect1_nodes,
+	.num_nodes = ARRAY_SIZE(interconnect1_nodes),
+};
+
+static struct sandbox_interconnect_data interconnect2_data = {
+	.nodes = interconnect2_nodes,
+	.num_nodes = ARRAY_SIZE(interconnect2_nodes),
+};
+
+static struct sandbox_interconnect_data interconnect3_data = {
+	.nodes = interconnect3_nodes,
+	.num_nodes = ARRAY_SIZE(interconnect3_nodes),
+};
+
+static struct sandbox_interconnect_data interconnect4_data = {
+	.nodes = interconnect4_nodes,
+	.num_nodes = ARRAY_SIZE(interconnect4_nodes),
+};
+
+int sandbox_interconnect_get_bw(struct udevice *dev, u64 *avg, u64 *peak)
+{
+	struct sandbox_interconnect_provider *priv = dev_get_plat(dev);
+
+	*avg = priv->avg;
+	*peak = priv->peak;
+
+	return 0;
+}
+
+static int sandbox_interconnect_links_aggregate(struct udevice *dev)
+{
+	struct sandbox_interconnect_provider *priv = dev_get_plat(dev);
+	u64 avg = 0, peak = 0;
+	int i;
+
+	debug("(provider=%s)\n", dev->name);
+
+	for (i = 0; i < priv->data->num_nodes; i++) {
+		struct sandbox_interconnect_node *sandbox_node = priv->data->nodes[i];
+
+		if (!sandbox_node)
+			continue;
+
+		avg += sandbox_node->avg_bw;
+		peak = max_t(u32, sandbox_node->peak_bw, peak);
+	}
+
+	priv->avg = avg / priv->data->num_nodes;
+	priv->peak = peak;
+
+	debug("(provider=%s,avg=%llu peak=%llu)\n",
+	      dev->name, priv->avg, priv->peak);
+
+	return 0;
+}
+
+static int sandbox_interconnect_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_node *node;
+
+	debug("(src=%s,dst=%s)\n", src->dev->name, dst->dev->name);
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	return sandbox_interconnect_links_aggregate(node->dev->parent);
+}
+
+static int sandbox_interconnect_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+					  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct sandbox_interconnect_node *sandbox_node = node->data;
+
+	debug("(node=%s,tag=%d,avg=%u,peak=%u)\n",
+	      node->dev->name, tag, avg_bw, peak_bw);
+
+	sandbox_node->avg_bw += avg_bw;
+	sandbox_node->peak_bw = max_t(u32, sandbox_node->peak_bw, peak_bw);
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	debug("(node=%s,new avg=%llu,new peak=%llu)\n",
+	      node->dev->name, sandbox_node->avg_bw, sandbox_node->peak_bw);
+
+	return 0;
+}
+
+static void sandbox_interconnect_pre_aggregate(struct icc_node *node)
+{
+	struct sandbox_interconnect_node *sandbox_node = node->data;
+
+	debug("(node=%s)\n", node->dev->name);
+
+	sandbox_node->avg_bw = 0;
+	sandbox_node->peak_bw = 0;
+}
+
+static struct icc_node *sandbox_interconnect_xlate(struct udevice *dev,
+						   const struct ofnode_phandle_args *spec)
+{
+	struct icc_provider *plat = dev_get_uclass_plat(dev);
+	unsigned int idx = spec->args[0];
+
+	debug("(dev=%s)\n", dev->name);
+
+	if (idx >= plat->xlate_num_nodes) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return plat->xlate_nodes[idx];
+}
+
+static int sandbox_interconnect_bind(struct udevice *dev)
+{
+	struct sandbox_interconnect_provider *priv = dev_get_plat(dev);
+	struct icc_provider *plat = dev_get_uclass_plat(dev);
+	size_t i;
+
+	debug("(dev=%s)\n", dev->name);
+
+	priv->data = (struct sandbox_interconnect_data *)dev_get_driver_data(dev);
+	if (!priv->data)
+		return -EINVAL;
+
+	plat->xlate_num_nodes = priv->data->num_nodes;
+	plat->xlate_nodes = calloc(sizeof(struct icc_node *), priv->data->num_nodes);
+	if (!plat->xlate_nodes)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	for (i = 0; i < priv->data->num_nodes; i++) {
+		struct sandbox_interconnect_node *sandbox_node;
+		struct icc_node *node;
+		int j;
+
+		sandbox_node = priv->data->nodes[i];
+		if (!sandbox_node)
+			continue;
+
+		node = icc_node_create(dev, (ulong)sandbox_node,
+				       sandbox_node->name);
+		if (IS_ERR(node))
+			return PTR_ERR(node);
+
+		node->data = sandbox_node;
+
+		for (j = 0; j < sandbox_node->num_links; ++j)
+			icc_link_create(node, (ulong)sandbox_node->links[j]);
+
+		plat->xlate_nodes[i] = node;
+	}
+
+	return 0;
+}
+
+static int sandbox_interconnect_unbind(struct udevice *dev)
+{
+	struct icc_provider *plat = dev_get_uclass_plat(dev);
+
+	free(plat->xlate_nodes);
+
+	return 0;
+}
+
+static const struct udevice_id sandbox_interconnect_ids[] = {
+	{ .compatible = "sandbox,interconnect0", .data = (ulong)&interconnect0_data, },
+	{ .compatible = "sandbox,interconnect1", .data = (ulong)&interconnect1_data, },
+	{ .compatible = "sandbox,interconnect2", .data = (ulong)&interconnect2_data, },
+	{ .compatible = "sandbox,interconnect3", .data = (ulong)&interconnect3_data, },
+	{ .compatible = "sandbox,interconnect4", .data = (ulong)&interconnect4_data, },
+	{ }
+};
+
+static struct interconnect_ops sandbox_interconnect_ops = {
+	.of_xlate = sandbox_interconnect_xlate,
+	.set = sandbox_interconnect_set,
+	.pre_aggregate = sandbox_interconnect_pre_aggregate,
+	.aggregate = sandbox_interconnect_aggregate,
+};
+
+U_BOOT_DRIVER(sandbox_interconnect) = {
+	.name = "sandbox_interconnect",
+	.id = UCLASS_INTERCONNECT,
+	.of_match = sandbox_interconnect_ids,
+	.bind = sandbox_interconnect_bind,
+	.unbind = sandbox_interconnect_unbind,
+	.plat_auto = sizeof(struct sandbox_interconnect_provider),
+	.ops = &sandbox_interconnect_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index a261b3fb4b7..771b703b737 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_DM_FPGA) += fpga.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock.o
+obj-$(CONFIG_INTERCONNECT) += interconnect.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_I3C) += i3c.o
 obj-$(CONFIG_SOUND) += i2s.o
diff --git a/test/dm/interconnect.c b/test/dm/interconnect.c
new file mode 100644
index 00000000000..e8c2eccd7b1
--- /dev/null
+++ b/test/dm/interconnect.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <dm/test.h>
+#include <asm/interconnect.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int dm_test_interconnect(struct unit_test_state *uts)
+{
+	struct udevice *dev_interconnect_0,
+		       *dev_interconnect_1,
+		       *dev_interconnect_2,
+		       *dev_interconnect_3,
+		       *dev_interconnect_4;
+	struct udevice *dev_test_0, *dev_test_1, *dev;
+	u64 avg = 0, peak = 0;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "interconnect-test-0",
+					      &dev_test_0));
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "interconnect-test-1",
+					      &dev_test_1));
+
+	ut_assertok(sandbox_interconnect_test_get_index(dev_test_0, 0));
+	ut_assertok(sandbox_interconnect_test_get(dev_test_1, "icc-path"));
+
+	ut_assertok(uclass_find_device_by_name(UCLASS_INTERCONNECT,
+					       "interconnect-0",
+					      &dev_interconnect_0));
+	ut_assertok(uclass_find_device_by_name(UCLASS_INTERCONNECT,
+					       "interconnect-1",
+					      &dev_interconnect_1));
+	ut_assertok(uclass_find_device_by_name(UCLASS_INTERCONNECT,
+					       "interconnect-2",
+					      &dev_interconnect_2));
+	ut_assertok(uclass_find_device_by_name(UCLASS_INTERCONNECT,
+					       "interconnect-3",
+					      &dev_interconnect_3));
+	ut_assertok(uclass_find_device_by_name(UCLASS_INTERCONNECT,
+					       "interconnect-4",
+					      &dev_interconnect_4));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_set_bw(dev_test_0, 10000, 100000));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 10000); ut_asserteq(peak, 100000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_set_bw(dev_test_1, 20000, 200000));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 30000); ut_asserteq(peak, 200000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_disable(dev_test_0));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 20000); ut_asserteq(peak, 200000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_disable(dev_test_1));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_enable(dev_test_0));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 10000); ut_asserteq(peak, 100000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_enable(dev_test_1));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 30000); ut_asserteq(peak, 200000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_0, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_1, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_2, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_3, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_4, DM_REMOVE_NORMAL));
+
+	ut_assertok(sandbox_interconnect_test_put(dev_test_0));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 20000); ut_asserteq(peak, 200000);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_assertok(sandbox_interconnect_test_put(dev_test_1));
+
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_0, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_1, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_2, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_3, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+	ut_assertok(sandbox_interconnect_get_bw(dev_interconnect_4, &avg, &peak));
+	ut_asserteq(avg, 0); ut_asserteq(peak, 0);
+
+	ut_asserteq(-ENOENT, sandbox_interconnect_test_get_index(dev_test_0, 1));
+	ut_asserteq(-ENOENT, sandbox_interconnect_test_get_index(dev_test_1, 1));
+	ut_asserteq(-ENODATA, sandbox_interconnect_test_get(dev_test_1, "pwet"));
+
+	ut_assertok(device_remove(dev_interconnect_0, DM_REMOVE_NORMAL));
+	ut_assertok(device_remove(dev_interconnect_1, DM_REMOVE_NORMAL));
+	ut_assertok(device_remove(dev_interconnect_2, DM_REMOVE_NORMAL));
+	ut_assertok(device_remove(dev_interconnect_3, DM_REMOVE_NORMAL));
+	ut_assertok(device_remove(dev_interconnect_4, DM_REMOVE_NORMAL));
+
+	ut_assertok(device_unbind(dev_interconnect_0));
+	ut_assertok(device_unbind(dev_interconnect_1));
+	ut_assertok(device_unbind(dev_interconnect_2));
+	ut_assertok(device_unbind(dev_interconnect_3));
+	ut_assertok(device_unbind(dev_interconnect_4));
+
+	uclass_find_first_device(UCLASS_INTERCONNECT, &dev);
+	ut_assert(!dev);
+
+	uclass_find_first_device(UCLASS_ICC_NODE, &dev);
+	ut_assert(!dev);
+
+	return 0;
+}
+
+DM_TEST(dm_test_interconnect, UTF_SCAN_FDT);

-- 
2.34.1

