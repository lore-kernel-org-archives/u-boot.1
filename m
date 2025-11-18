Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34709CEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA0183D1A;
	Tue, 18 Nov 2025 09:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ao9ZBCqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE42A83C16; Tue, 18 Nov 2025 09:28:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462C983C16
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so2700165e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454502; x=1764059302; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+DByFXeNUiXRCp2jFXxtvO8b4kyuyiB65R6FwPYqPyE=;
 b=Ao9ZBCqCv43vfmHihXPAsciCQe8qcTAIriUWW1qJrJwCdHbA8HThIxb7wMGXw9qzwA
 XN6+BQaaCTrzbXkIMA2gUuWDpa0L5YKbnWx58VGmSpS5w5EW7bqyb7Uxgl+2zjOy3YA5
 YZ77W8GPPDxQVhVAkCS3UrOFOh0i7+sdeBVfx/dwqm174eoTR/SXQmCAQX9wGVpW55hR
 L40mDSEFPO/WUitaMgEyrkvycgavC4aCOxbFMqZjPS+t8VocRBkYtnocuWNLb/dM/af7
 qI5TY3c3w4mXASATCPZaVjNBMGuhW7BIG2Hn6GZGYGPlIMIGQF/ZXSOmiw/TwRiUyDOm
 doFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454502; x=1764059302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+DByFXeNUiXRCp2jFXxtvO8b4kyuyiB65R6FwPYqPyE=;
 b=CHnZtyo0wqEH9pAC+uClZF8E9teM4evIkJ+196ZaIItP+LAOMEW0ul08OG8AEWpQL6
 bEeKdSsFnuD5UjTv1N2FSEVSV/HPc5AjiK3nxG08nNkRLgE7ipF9gqdAj6RsxSyD9wmz
 nuPP03VXC4zbVB2dQBATKL9O5l+QtJG6c0ju8EY3RZzYXY2IeUn/0DKBLIyZTLvcAuve
 hy9pwSZ9K21V5bv8XHN5xmcvBqHehKyPgYZZzOITOGWlazxOWNJEf5mm0LsB6imJhZgW
 WfgyN9iLUH7R1El47yWAzQ9RofTxWyb9vRwwxHxH6t50aDPkac9fLXPb0r9xmvvPClg5
 2Vng==
X-Gm-Message-State: AOJu0YwcTDVVQ1L9ZR4MbHcyI0Cc2tNeHvdLR13TXrbJs5stDIosrK5W
 h4Pp6a70YtAmfH5UfduMSEOIo1z27YFv9sDPbSPOOujIcikGjXFGuxA4QSkOpdyVCCg=
X-Gm-Gg: ASbGncvxvmdxEKi8Vwv2NPm9SVbIgye+GyY3YXkKMEI5XoJgu5vJ95Top5itwzzn+2S
 ts7s3sncstkVW6OfwR+PITjDf8YlwmAKUZm3efQFwMgQ+VQkEHMcsQAMUmNL6+efuM5V3ky5+Ki
 SC62LODwyNVVACcDCiNiBu1KGhVZDzvX3uCIYBonTJRme8t5u7KXxqL6hZKQXvOJ7KCDcYHId9t
 Z2S4tYsthdD83GhU/z/c8rNNKxlX38auWGM6tYOIBmOUwgaT7Tqsuk6WC1326cX13eOtDbC+FEv
 TPmlx02nKnWJx/JGZJnbS80XvzGp9U77WI4CtIlF9wYKpEBDPFKXWKQK+eM9PgeIitGR/CAuY+C
 0ekaKbQR3lM83vHV24H+ijHP4ya/lcNSFTOD2P5qrdmdRqRdIdqKrS585PPeb3VNMAdJ33tOnz5
 dcltwvVa8Uot5gdCRfzxUwc/nK7ShQVHTpVRZhexigjw==
X-Google-Smtp-Source: AGHT+IHQkKBVSDHnUd+UhjpwaQ+9t/nOZvp4h1B40EfPyH+EsvcmF4AE+Axfoc0XvxdW8YSR+InQNg==
X-Received: by 2002:a05:600c:1605:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-477941b784emr81913775e9.18.1763454501489; 
 Tue, 18 Nov 2025 00:28:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm72698875e9.14.2025.11.18.00.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 00:28:21 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Nov 2025 09:28:12 +0100
Subject: [PATCH v4 2/7] interconnect: add DM test suite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-interconnect-next-v4-2-9c00d6b19add@linaro.org>
References: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
In-Reply-To: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=25216;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2tnDaL9Oqkcv+8ljfYja5jpALxFVcuKtpLiSfLW3l84=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHC4eB3ABth7iZRalDfP4XOvHRv5pOlUwyqdx5rZ+
 M9XnruWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaRwuHgAKCRB33NvayMhJ0WMMD/
 9k0XKOdQmkGhFgarhd1MJuivfo3KH9YeL0JvHZHnGRQgELht1IFickWhwX6CbdnYYBdHTLlTO2uRaa
 rfhwFyv8Nj6OyyRrzB6jQQB5aBhbDcvRnHpP7xhdYOEbFErqZoHLoGb37TV1MkOutyQYxNXtmLTMQr
 46MWTpT8amM3XZS685CGybCsXSFrallDVypC4o/+kaSB4ESp/DpVXB0ftM9Rj7yrj1Mm3rdJyGauJt
 ZMPky/X3l5XKdLZmnGtXPu6pIhKmFtx+neQUpe7cI8U9t9fbEYcSq3qHUWF1X6JcbKfTsE8802w8jm
 xqtJWqPgkxIWy8NdkmfZJ3F67b0xEtHbIEL47GC1ZUpOnn+4oFYXeZlZpotXHsihLUANf/pki87vJ4
 i00kwSfcS2xVHdy4YyJK3NYwuNIAVsF2LiLmSNHfoXGJ/K8CkE6T3L1XlI9P4Hhf5n922sQK0Ns/T6
 jw6oDkEYTzE8JRo7M7hgfX6rlLcbnjfcCISAv2toKWLkmk4IfBWjLhTAH4vC+qK+zKK7Vn3RReCz73
 tvoJmIPJudmG/4SE1KOEiLfMX7BLxGTTpv6w2ifWUSf+s80k1czcB/WIqvG+QjMSE/Uv+Sh2oRthh7
 TI351eGUQw1xPVZkxdoAz/u7uwq510+cOZoj2rNQR3B3Ds5gIu4SzCvcYKNg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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
 drivers/interconnect/sandbox-interconnect.c      | 293 +++++++++++++++++++++++
 test/dm/Makefile                                 |   1 +
 test/dm/interconnect.c                           | 195 +++++++++++++++
 10 files changed, 648 insertions(+)

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
index 00000000000..42f207f8c74
--- /dev/null
+++ b/drivers/interconnect/sandbox-interconnect.c
@@ -0,0 +1,293 @@
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

