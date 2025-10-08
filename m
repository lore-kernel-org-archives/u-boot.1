Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC6CCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CABC840B0;
	Wed,  8 Oct 2025 17:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHQ4Z5aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8670E83FBF; Wed,  8 Oct 2025 17:31:40 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459DD83E8E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso54534f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937497; x=1760542297; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QgObp8LWmh2CyKjE76HFwFD+3QaM8uUtGqPcKvutQ0s=;
 b=mHQ4Z5aSwazmh/mCXwoKYCxF9B3Igc5FhHh6G7ozmZvaqrkNuLpgX9VNVKTznKnaw5
 ijH/KUafCbgfLjuo4yvuCf0pal/f8ttaZKoypOEoVhBVkOccvfRVX4EJJdKDcf5UN0o8
 X2XX7JBDUxhSW7vLDv3aW6LMadRp0QC7OD1n619RrQEMfPih0evVeWj1pECRUGxuhPjX
 HEMbgRIeJTb7UgF4+nk2oGD4xKFQ0a4gAZDa5bqmQbkbt896Gp+8TVov7YThvIqlW8ar
 7sE68I0vkyLu8R03TcamCe+2LWWRdTR8MZeYRZvM+Csr69mKQHY/i0Jw9+KK88s/QP4y
 lKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937497; x=1760542297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgObp8LWmh2CyKjE76HFwFD+3QaM8uUtGqPcKvutQ0s=;
 b=c7GnLl90dqz8bHKI6e2IugiUwHeMj0IHsAk9S7xzIfasUp4i82wttirRDw7233DlHx
 lTcdm86802dfJ506gCAdQh7B84hofFXlN27C56R67yQCR4ZuPU4CMhA+IEYMoyQyN/Cc
 qlXJ/5ULl45BbjKuqiFzN8kv9hcm777r/bljE+8exEufUBf9VnGB2pNG+08EjdpwRNLb
 sD6a4lASgM1BNpQhOYVuyZY3tIN97hVSUxnlJWJMQJ/vcKkIIJOHmoUAb3FPjvuS5X6h
 zD9E8pIhUS+jMkubd/NidPiE9zokRaSUGYkcOj4MO8zvM+60khoY2pMnwbBDiqku27Xi
 VPNQ==
X-Gm-Message-State: AOJu0YyQovxDSri8lyVyYvcycAQko/pANtqWXB8OdPG9AIsPdMZAvPZV
 ZEm1NU70C1DFJhaDRbitleI91cZrBVXa9JIHxpuokIjKpi2gvjY/AgjThy3Y8ri1tWg=
X-Gm-Gg: ASbGncu5InjvPwaxvKNQ1kp5YzAiQxyJzEr51YbNdLE4uP40vQ9FME8M1UrYD6iwIoG
 El7wIdOMWzr4WCIK4mylRNdrQQ4dR4KOlaPonkwFxS4elkCiFirfMGcq+O1VosxQCGyMA5lcqsF
 7mec5a8bPQudnFN6ss/K4OYBAUiSNhKOt8sMT+2x9pr3RiF8fhS6qDUqArzScIkfLds/xbRQjdl
 6o++6BwvSrp7al8vxUnUdxVKgj+4d1VBLZN27JqsAAXi1zDOW4eq3VFaXKZXT11hfzsKCdZ8Twk
 1DqYbUT06raYMPK15GvYa1zFIzE6Y9NztH2Py2dSxjSetaCOgc6fgURxmNHbDHneZCyRdkdWjUA
 ce5N+Jw4KREpP5pEkf2IJI99An7OwwD39sALbzClLL1nzatmUg+9hq1IQsiV/BSAdnAP/iJc=
X-Google-Smtp-Source: AGHT+IEZYi+3khka8ZcJYAI0Zb4kmGqvQwydUShtuW1oWgrfH6f7JLt51h0KYk9cdWiZEgga7ekN9Q==
X-Received: by 2002:a5d:584b:0:b0:3ee:1461:1654 with SMTP id
 ffacd0b85a97d-4266e8d92e8mr2778534f8f.50.1759937496568; 
 Wed, 08 Oct 2025 08:31:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 17:31:29 +0200
Subject: [PATCH v2 2/7] interconnect: add DM test suite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-interconnect-next-v2-2-c46e94dd328e@linaro.org>
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24226;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=41iPORjhEUNGvwoHIPMU8HGQvBa8z4kQ0NcCbbftlFs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPTF7SjtSlPp34OFW6d+trRqZBBgW4rzIn7i41d
 p219NN6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD0wAKCRB33NvayMhJ0URlEA
 CWgT5TocwvxI4EJuxcIjvcT5OIIwrSCytvI798NrmzUV5QLyPt9L15pEasjOyx2OlpmUOY97rl3w71
 Rb+VGptevd4C1UYCbIEhD/dPe+Z2Nhda+7y+KhaVorlxyKWoRvSaxV27U9dwexl4hxPQzaGXk4vY6J
 iplmlCQt1CRYAY1pClPJA/Cxjr+URfytbAH/1k3BnSo41yzt/KgGh7yCVrzO61k82HgvCAulPilrjD
 Ya7qfepHv9LRdr93lu45mRQzmvBpYyUV2v25jBtYNIONGfPIvSyfSOdWpmHyuuue300AXW3zvoP4QH
 u2s3K3k088lz9fYUAhTsONxaAhE9v1A/CxEnebKrWvrbxUV8OSMkiA6UkF8EiOgKebJHeZ5YWs4P2p
 LFOkybeybQQT6TKhLOHdKFUfsIagw6w9fDhdEFSn3cHsv/gGtZ6X+nF6O5kxwZLE/bS6fOKoPB8E/Q
 Nhy7KYzsaF4heFQQ/UFvokLpPOO8GCL10WWZA3sTNRqElbZvS7V0Mec7UNVWIe4+5a9qhnFwSSpC9W
 xZ3QH29tEzAyGtZm/ihlL9ddQGS/IefPWWYcooVu22Uial0WFwzvmQ1hTYLPwjiwVtDsTjChR6eGcV
 fsul7tyWPmz0ipkDiMCBgMMT6CiKLYUjGtZLx8UGdRiLncVDnL2LyI7NiNSg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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
 drivers/interconnect/sandbox-interconnect-test.c |  89 ++++++
 drivers/interconnect/sandbox-interconnect.c      | 338 +++++++++++++++++++++++
 test/dm/Makefile                                 |   1 +
 test/dm/interconnect.c                           | 148 ++++++++++
 10 files changed, 646 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index c9a05cd625613e2f8b2cae771403ce36e5d06f42..1c34f4a8fdc6e25fa66debd11ff4d0119d9373c8 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -862,6 +862,42 @@
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
index 0000000000000000000000000000000000000000..17065bf6a11d7b0e62c937df593535a4664b7c14
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
index 4ff82426a365fdf5c18a2c1292626c58fe172c40..0ea4166b1b2a4ca1cfa21150f6c41a1c158d9945 100644
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
index 39ef596b8e330aed3c52b494534ebbdc3d3378dd..dbe51691d0a30d6c9b60f9f1a3db1c4c83dc5e6e 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -283,6 +283,8 @@ CONFIG_PINCTRL_SANDBOX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SANDBOX_POWER_DOMAIN=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_SANDBOX=y
 CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_ACT8846=y
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 38d39651ab56d441070d3e19a4af60e44fc926d4..e9f4cc662aec40f5d0053186cfeaa96b22fd6b3c 100644
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
index 1f276e980510e015e56465a48751b07e54d84f1a..04b18589b7ff7eef9f8b5fcf47c36bd82a48e802 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect-uclass.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_SANDBOX) += sandbox-interconnect.o sandbox-interconnect-test.o
diff --git a/drivers/interconnect/sandbox-interconnect-test.c b/drivers/interconnect/sandbox-interconnect-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..ff5f327f6daf36f31a62b14bc9da58c64d244187
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
index 0000000000000000000000000000000000000000..37ea0263bed2cc0aeb47a9393906655bdaa505a1
--- /dev/null
+++ b/drivers/interconnect/sandbox-interconnect.c
@@ -0,0 +1,338 @@
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
+	unsigned int id;
+	unsigned int num_links;
+	unsigned int links[MAX_LINKS];
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
+enum {
+	NODE0,
+	NODE1,
+	NODE2_SLAVE,
+	NODE2_MASTER,
+	NODE3,
+	NODE4,
+};
+
+static struct sandbox_interconnect_node node0 = {
+	.name = "node0",
+	.id = NODE0,
+	.num_links = 1,
+	.links = { NODE2_SLAVE },
+};
+
+static struct sandbox_interconnect_node node1 = {
+	.name = "node1",
+	.id = NODE1,
+	.num_links = 1,
+	.links = { NODE2_SLAVE },
+};
+
+static struct sandbox_interconnect_node node2_slave = {
+	.name = "node2_slave",
+	.id = NODE2_SLAVE,
+	.num_links = 1,
+	.links = { NODE2_MASTER },
+};
+
+static struct sandbox_interconnect_node node2_master = {
+	.name = "node2_master",
+	.id = NODE2_MASTER,
+	.num_links = 2,
+	.links = { NODE3, NODE4 },
+};
+
+static struct sandbox_interconnect_node node3 = {
+	.name = "node3",
+	.id = NODE3,
+};
+
+static struct sandbox_interconnect_node node4 = {
+	.name = "node4",
+	.id = NODE4,
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
+	printf("%s:%s\n", __func__, dev->name);
+
+	*avg = priv->avg;
+	*peak = priv->peak;
+
+	return 0;
+}
+
+static int sandbox_interconnect_links_aggregate(struct icc_provider *provider)
+{
+	struct udevice *dev = provider->dev;
+	struct sandbox_interconnect_provider *priv = dev_get_plat(dev);
+	u64 avg = 0, peak = 0;
+	int i;
+
+	debug("%s(provider=%s)\n", __func__, provider->dev->name);
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
+	debug("%s(provider=%s) avg=%llu peak=%llu\n", __func__,
+	      provider->dev->name, priv->avg, priv->peak);
+
+	return 0;
+}
+
+static int sandbox_interconnect_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_node *node;
+
+	debug("%s(src=%s,dst=%s)\n", __func__, src->dev->name, dst->dev->name);
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	return sandbox_interconnect_links_aggregate(node->provider);
+}
+
+static int sandbox_interconnect_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+					  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct sandbox_interconnect_node *sandbox_node = node->data;
+
+	debug("%s(node=%s,tag=%d,avg=%u,peak=%u)\n", __func__,
+	      node->dev->name, tag, avg_bw, peak_bw);
+
+	sandbox_node->avg_bw += avg_bw;
+	sandbox_node->peak_bw = max_t(u32, sandbox_node->peak_bw, peak_bw);
+
+	if (node->init_avg || node->init_peak) {
+		sandbox_node->avg_bw = max_t(u64, sandbox_node->avg_bw, node->init_avg);
+		sandbox_node->peak_bw = max_t(u64, sandbox_node->peak_bw, node->init_peak);
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	debug("%s(node=%s,new avg=%llu,new peak=%llu)\n", __func__,
+	      node->dev->name, sandbox_node->avg_bw, sandbox_node->peak_bw);
+
+	return 0;
+}
+
+static void sandbox_interconnect_pre_aggregate(struct icc_node *node)
+{
+	struct sandbox_interconnect_node *sandbox_node = node->data;
+
+	debug("%s(node=%s)\n", __func__, node->dev->name);
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
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	if (idx >= plat->xlate_num_nodes) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return plat->xlate_nodes[idx];
+}
+
+static int sandbox_interconnect_unbind(struct udevice *dev)
+{
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	return 0;
+}
+
+static int sandbox_interconnect_remove(struct udevice *dev)
+{
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	return 0;
+}
+
+static int sandbox_interconnect_probe(struct udevice *dev)
+{
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	return 0;
+}
+
+static int sandbox_interconnect_bind(struct udevice *dev)
+{
+	struct sandbox_interconnect_provider *priv = dev_get_plat(dev);
+	struct icc_provider *plat = dev_get_uclass_plat(dev);
+	size_t i;
+
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	priv->data = (struct sandbox_interconnect_data *)dev_get_driver_data(dev);
+	if (!priv->data)
+		return -EINVAL;
+
+	plat->dev = dev;
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
+		node = icc_node_create(plat, sandbox_node->id,
+				       sandbox_node->name);
+		if (IS_ERR(node))
+			return PTR_ERR(node);
+
+		node->data = sandbox_node;
+		icc_node_add(node, plat);
+
+		for (j = 0; j < sandbox_node->num_links; ++j)
+			icc_link_create(node, sandbox_node->links[j]);
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
+struct interconnect_ops sandbox_interconnect_ops = {
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
+	.remove = sandbox_interconnect_remove,
+	.probe = sandbox_interconnect_probe,
+	.plat_auto = sizeof(struct sandbox_interconnect_provider),
+	.ops = &sandbox_interconnect_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 9ffe0faee75e82be7b91579181fdc22406bfd7c3..0ddf47885239e737f04b931f6d2da4b92ec09f33 100644
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
index 0000000000000000000000000000000000000000..f536fc0e7ebe1338354265d2ae8ff20723e38597
--- /dev/null
+++ b/test/dm/interconnect.c
@@ -0,0 +1,148 @@
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
+	ut_assertok(sandbox_interconnect_test_enable(dev_test_0));
+	ut_assertok(sandbox_interconnect_test_enable(dev_test_1));
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
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_0, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_1, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_2, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_3, DM_REMOVE_NORMAL));
+	ut_asserteq(-EBUSY, device_remove(dev_interconnect_4, DM_REMOVE_NORMAL));
+
+	ut_assertok(sandbox_interconnect_test_put(dev_test_0));
+	ut_assertok(sandbox_interconnect_test_put(dev_test_1));
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

