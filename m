Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2987ACCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C05C83759;
	Fri,  3 Oct 2025 10:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pu9zB48s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8C1836AC; Fri,  3 Oct 2025 10:56:31 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEDF836B4
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1153483f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481788; x=1760086588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2KROcE0sVw9Hd0l7jXVfIoGiBKCkRMimL0qFflzhwqc=;
 b=pu9zB48sCxwWAr7c1w4uj4DVqS17mUALQ9Pi0F7dJuMJbvfj1y0G65khBQBNxk97WH
 6oU8VFP/uslk7SEve4xgbC6SKTOrZzU+BCzjcZ+bG1Bl35Gcksp6E8Zvpj/rRJNQZIk/
 M6JqwI/BGctBRr4LjaMVZ5uB8189FXHD8Lu430bhGdfU2aNuwo/psVhw0aMrYKr4mXjE
 rdq4hSAsqrulmLnk+HeZU2Z69HRYxjGKW2tbIFF6JNMJZvJyN9FlctSZ2/oNtDcsZr2U
 3DkIjHqvKtbJkULVPIMyGh/J7qR2qEXTu81QmZiyVuGl3kvAmp/Qf4Yjv0pgAf7jviPX
 XLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481788; x=1760086588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KROcE0sVw9Hd0l7jXVfIoGiBKCkRMimL0qFflzhwqc=;
 b=AN4GpCYKAHthl5NTqHEEIhRfPeFWaCGqa7larBxunGtgjCbd0kMZbQeYUULNY0jpMG
 99Fy/k/lE3zuLe5o1moMV8k8XvCHhk+X8D0Ql9SEBdTn0aaNgxYFybOYSEo09N+XoFVK
 YVD1DKjIO5CYV1JL3g2ZrOzhO4XQsCpewbE7m+8TDeV8OnFNITHhFDkhduaOwIH2Gf9L
 DI5mL9acfflo9G5wGghubyKVHnSrwRgdIp37+39V1TygTTnfU9wgS1gwgZEhSxi2k9Gh
 j85bjYm0VKXvtaaVO4OQo4GuLFWfRAek/DguCf/2OTV3lCiHI+SRstgsfX7xg/3ADTGR
 rAEw==
X-Gm-Message-State: AOJu0YyiK3QNfA17YKRuNE/0PfnYAgdtzdD0lqtDPBGjl62IzWlBTXCJ
 n1Me5l6xnl2pB5ipwH0iIh24HhQ8NI+2c3hJ7GMPZ0C7yIWmiEKs1R9QATL+A+LyePY=
X-Gm-Gg: ASbGncvapi4AJuSuQS6pyam59zdQWx+y2JKmsSJ3IQUVqszan7FZS1KVbOBIProkhaL
 WvgjEO4NccFn85G8EDhhtmBcNwP6Tpzu+W/lM0yxuifFzSu2n1GD37HQWURomiYDl9ylrqA4kUV
 Jq5ii7/nWQiFtIbs66o3WHBru8y4kmlwwZ0jod0/9R3mptPH3iTR6av4rlH2QBRzgkFVV2dNmX7
 yjcAdvHXJzNDWCQ0xkjRuBDx7p+A5L6zI2j37zdLr0XNHLvjQnPyqGGyIKLGEB4vDHslfS5RkxB
 wyapDelHeJ+ofPEsL+b+NnmwT0q1/hg2GS4vol8y5G3Uk4239jgoSJppbtQorF5RyLMEt5ze7Ca
 1k6wy867rXucOUQCCp66GCDtiIuEgmpwbKQZLsQkoZ3mr64mKFIW0kE6E/iYg/74LLCLYzCaBTW
 0GVEQ2lQ==
X-Google-Smtp-Source: AGHT+IGGbazzUh7EQhW7sC+BB7q9WOXWyjfKtuRDGrS15TTPEni4ID3Ma1PGOd9mLziHXhLFos655w==
X-Received: by 2002:a05:6000:25c3:b0:3ec:db18:1695 with SMTP id
 ffacd0b85a97d-425671bf2e5mr1463102f8f.45.1759481787850; 
 Fri, 03 Oct 2025 01:56:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm6951709f8f.41.2025.10.03.01.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 01:56:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Oct 2025 10:56:21 +0200
Subject: [PATCH RFC 1/6] Introduce Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-topic-interconnect-next-v1-1-955eef068b6e@linaro.org>
References: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
In-Reply-To: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21452;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=E9ISMolPqbm40JETsxriJI/Fk2RPeF5PGqSMN+QxGaM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo34+3wXfl2pDU7MKWotPxSgwV4BdeqKk7nC4TUpMM
 oRvyDNGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaN+PtwAKCRB33NvayMhJ0fW1D/
 9gwHw2CK1GsP54A334bWbRZQ5R2O9kyHwIoGE0OTUad3hsqACyjYFsY+0QU6V0Wqur20pI+z8qCW1d
 mmqkniQpb7nBCUh0jAVJjSW73iqgNjQIoNckGKQM3d42OoFDpUQwWGGHTJ4txRwHtWt1Xms3r9MQ4j
 u1ZaDL5hrQMgb30lJgpNBefe5i7Lt/pT1XNmVNojNficMG9q/RM2HTFt86vvq3GmBXqam8/fuAy37B
 V5D3EzIkFx5ERLeDTOdMHX6HAPqrm20iKfjlTH/0VU4YnErwTRY06aiQsu4i40nlbm5+9fJSSH+u6M
 0IMMXs8M6iNI5uzh7PDHWxm2jeiwX2SWgwysi0BnFzY9Xo/NVB1r0C5K4CSjElWSzqz4FfBcvn8pmX
 zTo5pCd9z4BUBxdtW3LegVDnVIIkG5fHDKwsOov9riYwuX1dJSSHGmZxFKCa9xZWoi/uuQpAxm7n9Z
 BXiFsSDihepxO/Lh6EQuiassujK8AwZubOjoRBV3I2LX/3fyTAon1PcyASu7QdAGRdsviVAcJE8VOd
 VJtJ8/o/IzhjeV1gLffASxUJfdLW8LeVZ+LwweDSejCcZhkIVvSnHCsqCSN2D624eS+DxqRngifq6O
 EL8Qnp436FgTlGKwYECe487a1aqvuosCrm7VATpp7stSvALKRZd8iqYOX1Gg==
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

Let's introduce the Interconnect subsystem based on the Linux framework
which is used to vote for bandwidth across multiple SoC busses.

Each bus endpoints are materialized as "nodes" which are linked together,
and the DT will specify a pair of nodes to enable and set a bandwidth
on the route between those endpoints.

The hardware resources that provide those nodes and provides the way
to vote for the bandwidth are called "providers".

The Interconnect uclass code is heavily based on the Linux one, with
some small differences:
- nodes are allocated as udevices instead of Linux idr_alloc()
- tag management is minimal, only normal xlate is supported
- dynamic IDs is not implemented
- getting nodes states at probe is not implemented
- providers are probed on demand while the nodes links are traversed

DM Testsuite is missing, will be added soon.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/Kconfig                            |   2 +
 drivers/Makefile                           |   1 +
 drivers/interconnect/Kconfig               |  10 +
 drivers/interconnect/Makefile              |   6 +
 drivers/interconnect/interconnect-uclass.c | 554 +++++++++++++++++++++++++++++
 include/dm/uclass-id.h                     |   2 +
 include/interconnect-uclass.h              |  77 ++++
 include/interconnect.h                     |  80 +++++
 8 files changed, 732 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0b0c610e6294ab7d05d36058727e1eef765145f2..b7f987e595581698cca3f4a14b6bede0bb7af266 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -60,6 +60,8 @@ source "drivers/i3c/Kconfig"
 
 source "drivers/input/Kconfig"
 
+source "drivers/interconnect/Kconfig"
+
 source "drivers/iommu/Kconfig"
 
 source "drivers/led/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 7560008a842203ba142041446c20268a1113f674..1d27c9abd54edf35a0bd045c8fa553aa653b7d6a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
 obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
+obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
 obj-y += mtd/
diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..38d39651ab56d441070d3e19a4af60e44fc926d4
--- /dev/null
+++ b/drivers/interconnect/Kconfig
@@ -0,0 +1,10 @@
+menu "Interconnect Support"
+
+config INTERCONNECT
+	bool "Enable interconnect support using Driver Model"
+	depends on DM && OF_CONTROL
+	help
+	  Enable support for the interconnect driver class. Many SoCs allow
+	  bandwidth to be tuned on busses within the SoC.
+
+endmenu
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..1f276e980510e015e56465a48751b07e54d84f1a
--- /dev/null
+++ b/drivers/interconnect/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Linaro Limited
+#
+
+obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect-uclass.o
diff --git a/drivers/interconnect/interconnect-uclass.c b/drivers/interconnect/interconnect-uclass.c
new file mode 100644
index 0000000000000000000000000000000000000000..4f2420b02b21af0decec0fe24bc40c1a984fe55e
--- /dev/null
+++ b/drivers/interconnect/interconnect-uclass.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Linaro Limited
+ * Based on the Linux Driver:
+ * Copyright (c) 2017-2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#define LOG_CATEGORY UCLASS_INTERCONNECT
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <linux/err.h>
+#include <interconnect.h>
+#include <interconnect-uclass.h>
+#include <dm/lists.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
+
+static struct icc_node *of_icc_get_from_provider(const struct ofnode_phandle_args *args);
+static struct icc_path *icc_path_find(struct icc_node *src, struct icc_node *dst, int *unlinked);
+static struct udevice *icc_provider_find(const int id);
+
+/* Public API */
+
+struct icc_path *of_icc_get(struct udevice *dev, const char *name)
+{
+	int index;
+
+	index = dev_read_stringlist_search(dev, "interconnect-names", name);
+	if (index < 0) {
+		debug("fdt_stringlist_search() failed: %d\n", index);
+		return ERR_PTR(index);
+	}
+
+	return of_icc_get_by_index(dev, index);
+}
+
+struct icc_path *of_icc_get_by_index(struct udevice *dev, int index)
+{
+	struct ofnode_phandle_args src_args, dst_args;
+	struct icc_node *src_node, *dst_node;
+	struct icc_path *path;
+	int unlinked_id = -1;
+	int ret;
+
+	debug("%s(dev=%p, idx=%d)\n", __func__, dev, index);
+
+	ret = dev_read_phandle_with_args(dev, "interconnects",
+					 "#interconnect-cells", 0, index * 2,
+					 &src_args);
+	if (ret) {
+		debug("%s: dev_read_phandle_with_args src failed: %d\n",
+		      __func__, ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = dev_read_phandle_with_args(dev, "interconnects",
+					 "#interconnect-cells", 0, index * 2 + 1,
+					 &dst_args);
+	if (ret) {
+		debug("%s: dev_read_phandle_with_args dst failed: %d\n",
+		      __func__, ret);
+		return ERR_PTR(ret);
+	}
+
+	src_node = of_icc_get_from_provider(&src_args);
+	if (IS_ERR(src_node)) {
+		dev_err(dev, "error finding src node\n");
+		return ERR_CAST(src_node);
+	}
+
+	dst_node = of_icc_get_from_provider(&dst_args);
+	if (IS_ERR(dst_node)) {
+		dev_err(dev, "error finding dst node\n");
+		return ERR_CAST(dst_node);
+	}
+
+	path = icc_path_find(src_node, dst_node, &unlinked_id);
+	while (IS_ERR(path) && PTR_ERR(path) == -EPROBE_DEFER) {
+		struct udevice *provider_dev;
+
+		if (unlinked_id == -1)
+			break;
+
+		debug("%s: looking for provider with id '%d'\n", __func__,
+		      unlinked_id);
+
+		provider_dev = icc_provider_find(unlinked_id);
+		if (!provider_dev)
+			break;
+
+		debug("%s: provider '%s' has id '%d'\n", __func__,
+		      provider_dev->name, unlinked_id);
+
+		ret = uclass_get_device_tail(provider_dev, 0, &provider_dev);
+		if (ret)
+			return ERR_PTR(ret);
+
+		unlinked_id = -1;
+		path = icc_path_find(src_node, dst_node, &unlinked_id);
+	}
+
+	if (IS_ERR(path))
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+
+	return path;
+}
+
+void icc_put(struct icc_path *path)
+{
+	struct icc_node *node;
+	size_t i;
+	int ret;
+
+	if (!path || IS_ERR(path))
+		return;
+
+	ret = icc_set_bw(path, 0, 0);
+	if (ret)
+		pr_err("%s: error (%d)\n", __func__, ret);
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+		hlist_del(&path->reqs[i].req_node);
+		if (node->provider->users)
+			node->provider->users--;
+	}
+
+	kfree(path);
+}
+
+static int __icc_enable(struct icc_path *path, bool enable)
+{
+	int i;
+
+	if (!path)
+		return 0;
+
+	if (IS_ERR(path) || !path->num_nodes)
+		return -EINVAL;
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].enabled = enable;
+
+	return icc_set_bw(path, path->reqs[0].avg_bw,
+			  path->reqs[0].peak_bw);
+}
+
+int icc_enable(struct icc_path *path)
+{
+	return __icc_enable(path, true);
+}
+
+int icc_disable(struct icc_path *path)
+{
+	return __icc_enable(path, false);
+}
+
+static int apply_constraints(struct icc_path *path)
+{
+	struct icc_node *next, *prev = NULL;
+	const struct interconnect_ops *ops;
+	struct icc_provider *p;
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		next = path->reqs[i].node;
+		p = next->provider;
+
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev || (p != prev->provider && !p->inter_set)) {
+			prev = next;
+			continue;
+		}
+
+		ops = device_get_ops(p->dev);
+
+		/* set the constraints */
+		ret = ops->set(prev, next);
+		if (ret)
+			goto out;
+
+		prev = next;
+	}
+out:
+	return ret;
+}
+
+static int aggregate_requests(struct icc_node *node)
+{
+	const struct interconnect_ops *ops = device_get_ops(node->provider->dev);
+	struct icc_req *r;
+	u32 avg_bw, peak_bw;
+
+	node->avg_bw = 0;
+	node->peak_bw = 0;
+
+	if (ops->pre_aggregate)
+		ops->pre_aggregate(node);
+
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		if (r->enabled) {
+			avg_bw = r->avg_bw;
+			peak_bw = r->peak_bw;
+		} else {
+			avg_bw = 0;
+			peak_bw = 0;
+		}
+		ops->aggregate(node, r->tag, avg_bw, peak_bw,
+			     &node->avg_bw, &node->peak_bw);
+	}
+
+	return 0;
+}
+
+int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	struct icc_node *node;
+	u32 old_avg, old_peak;
+	size_t i;
+	int ret;
+
+	if (!path)
+		return 0;
+
+	if (IS_ERR(path) || !path->num_nodes)
+		return -EINVAL;
+
+	old_avg = path->reqs[0].avg_bw;
+	old_peak = path->reqs[0].peak_bw;
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		/* update the consumer request for this path */
+		path->reqs[i].avg_bw = avg_bw;
+		path->reqs[i].peak_bw = peak_bw;
+
+		/* aggregate requests for this node */
+		aggregate_requests(node);
+	}
+
+	ret = apply_constraints(path);
+	if (ret) {
+		debug("interconnect: error applying constraints (%d)\n", ret);
+
+		for (i = 0; i < path->num_nodes; i++) {
+			node = path->reqs[i].node;
+			path->reqs[i].avg_bw = old_avg;
+			path->reqs[i].peak_bw = old_peak;
+			aggregate_requests(node);
+		}
+		apply_constraints(path);
+	}
+
+	return ret;
+}
+
+/* Provider API */
+
+static struct icc_path *icc_path_init(struct icc_node *dst, ssize_t num_nodes)
+{
+	struct icc_node *node = dst;
+	struct icc_path *path;
+	int i;
+
+	path = calloc(sizeof(struct icc_req), num_nodes);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->num_nodes = num_nodes;
+
+	for (i = num_nodes - 1; i >= 0; i--) {
+		node->provider->users++;
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+		debug("%s: req %s\n", __func__, node->dev->name);
+		path->reqs[i].node = node;
+		path->reqs[i].enabled = true;
+		/* reference to previous node was saved during path traversal */
+		node = node->reverse;
+	}
+
+	return path;
+}
+
+static struct icc_path *icc_path_find(struct icc_node *src, struct icc_node *dst,
+				      int *unlinked_id)
+{
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node *n, *node = NULL;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head visited_list;
+	size_t i, depth = 1;
+	bool found = false;
+
+	INIT_LIST_HEAD(&traverse_list);
+	INIT_LIST_HEAD(&edge_list);
+	INIT_LIST_HEAD(&visited_list);
+
+	list_add(&src->search_list, &traverse_list);
+	src->reverse = NULL;
+
+	do {
+		list_for_each_entry_safe(node, n, &traverse_list, search_list) {
+			if (node == dst) {
+				found = true;
+				list_splice_init(&edge_list, &visited_list);
+				list_splice_init(&traverse_list, &visited_list);
+				break;
+			}
+			for (i = 0; i < node->num_links; i++) {
+				struct icc_node *tmp = node->links[i];
+
+				if (!tmp) {
+					path = ERR_PTR(-ENOENT);
+					goto out;
+				}
+				if (tmp->is_unlinked) {
+					*unlinked_id = tmp->id;
+					break;
+				}
+
+				if (tmp->is_traversed)
+					continue;
+
+				tmp->is_traversed = true;
+				tmp->reverse = node;
+				list_add_tail(&tmp->search_list, &edge_list);
+			}
+		}
+
+		if (found)
+			break;
+
+		list_splice_init(&traverse_list, &visited_list);
+		list_splice_init(&edge_list, &traverse_list);
+
+		/* count the hops including the source */
+		depth++;
+
+	} while (!list_empty(&traverse_list));
+
+out:
+
+	/* reset the traversed state */
+	list_for_each_entry_reverse(n, &visited_list, search_list)
+		n->is_traversed = false;
+
+	if (found)
+		path = icc_path_init(dst, depth);
+
+	return path;
+}
+
+static struct icc_node *of_icc_get_from_provider(const struct ofnode_phandle_args *args)
+{
+	const struct interconnect_ops *ops;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_INTERCONNECT, args->node,
+					  &dev);
+	if (ret) {
+		debug("%s: uclass_get_device_by_ofnode failed: %d\n",
+		      __func__, ret);
+		return ERR_PTR(ret);
+	}
+	ops = device_get_ops(dev);
+
+	return ops->of_xlate(dev, args);
+}
+
+static struct icc_node *node_find(const int id)
+{
+	struct udevice *dev;
+
+	for (uclass_find_first_device(UCLASS_ICC_NODE, &dev);
+	     dev;
+	     uclass_find_next_device(&dev)) {
+		struct icc_node *node = dev_get_uclass_plat(dev);
+
+		if (node->id == id)
+			return node;
+	}
+
+	return NULL;
+}
+
+static struct udevice *icc_provider_find(const int id)
+{
+	const struct interconnect_ops *ops;
+	struct udevice *dev;
+
+	for (uclass_find_first_device(UCLASS_INTERCONNECT, &dev);
+	     dev;
+	     uclass_find_next_device(&dev)) {
+		ops = device_get_ops(dev);
+
+		if (ops->has_node_id(dev, id))
+			return dev;
+	}
+
+	return NULL;
+}
+
+struct icc_node *icc_node_create(const struct icc_provider *provider,
+				 int id, const char *node_name)
+{
+	struct icc_node *node;
+	struct udevice *dev;
+	char name[64];
+	int ret;
+
+	snprintf(name, 64, "%s@%d", node_name, id);
+
+	node = node_find(id);
+	if (node) {
+		debug("%s: reparent from %s to %s\n", __func__,
+		      node->dev->parent->name, provider->dev->name);
+
+		ret = device_reparent(node->dev, provider->dev);
+		if (ret)
+			return ERR_PTR(ret);
+
+		debug("%s: rename from %s to %s\n", __func__,
+		      node->dev->name, name);
+
+		device_set_name(node->dev, name);
+
+		if (node->is_unlinked)
+			node->is_unlinked = 0;
+
+		return node;
+	}
+
+	ret = device_bind_driver(provider->dev, "icc_node", strdup(name), &dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	device_set_name_alloced(dev);
+
+	ret = uclass_get_device_tail(dev, 0, &dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	node = dev_get_uclass_plat(dev);
+	node->id = id;
+	node->dev = dev;
+
+	return node;
+}
+
+int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	struct icc_node *dst;
+	struct icc_node **new;
+
+	if (!node->provider)
+		return -EINVAL;
+
+	dst = node_find(dst_id);
+	if (!dst) {
+		dst = icc_node_create(node->provider, dst_id, "unlinked");
+
+		if (!dst)
+			return PTR_ERR(dst);
+
+		dst->is_unlinked = 1;
+	}
+
+	new = realloc(node->links,
+		      (node->num_links + 1) * sizeof(*node->links));
+	if (!new)
+		return -ENOMEM;
+
+	node->links = new;
+	node->links[node->num_links++] = dst;
+
+	return 0;
+}
+
+void icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	node->provider = provider;
+	list_add_tail(&node->node_list, &provider->nodes);
+
+	/* TODO: get the initial bandwidth values and sync them with hardware */
+	node->init_avg = INT_MAX;
+	node->init_peak = INT_MAX;
+	node->avg_bw = node->init_avg;
+	node->peak_bw = node->init_peak;
+
+	/* TOFIX should we set the BW on probe like on Linux ? */
+}
+
+static int interconnect_pre_probe(struct udevice *dev)
+{
+	struct icc_provider *provider = dev_get_uclass_plat(dev);
+
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->dev = dev;
+
+	return 0;
+}
+
+static int interconnect_pre_remove(struct udevice *dev)
+{
+	struct icc_provider *provider = dev_get_uclass_plat(dev);
+	struct icc_node *n, *tmp;
+
+	list_for_each_entry_safe_reverse(n, tmp, &provider->nodes, node_list) {
+		list_del(&n->node_list);
+		device_remove(n->dev, DM_REMOVE_NORMAL);
+		device_unbind(n->dev);
+	}
+
+	list_del(&provider->provider_list);
+
+	return 0;
+}
+
+static int icc_node_pre_remove(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	kfree(node->links);
+
+	return 0;
+}
+
+UCLASS_DRIVER(interconnect) = {
+	.id		= UCLASS_INTERCONNECT,
+	.name		= "interconnect",
+	.pre_probe	= interconnect_pre_probe,
+	.pre_remove	= interconnect_pre_remove,
+	.per_device_plat_auto = sizeof(struct icc_provider),
+};
+
+U_BOOT_DRIVER(icc_node) = {
+	.name		= "icc_node",
+	.id		= UCLASS_ICC_NODE,
+};
+
+UCLASS_DRIVER(icc_node) = {
+	.id		= UCLASS_ICC_NODE,
+	.name		= "icc_node",
+	.pre_remove	= icc_node_pre_remove,
+	.per_device_plat_auto = sizeof(struct icc_node),
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 6be59093160f3990b8a2cdacd9593ed3c7624920..34d7d81568f6fb6b59f974d2ae8eb282cc6ff64a 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -82,6 +82,8 @@ enum uclass_id {
 	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
+	UCLASS_INTERCONNECT,	/* Interconnect */
+	UCLASS_ICC_NODE,	/* Interconnect Node */
 	UCLASS_IRQ,		/* Interrupt controller */
 	UCLASS_KEYBOARD,	/* Keyboard input device */
 	UCLASS_LED,		/* Light-emitting diode (LED) */
diff --git a/include/interconnect-uclass.h b/include/interconnect-uclass.h
new file mode 100644
index 0000000000000000000000000000000000000000..5f4b1891a7d0ad288955ddcd61d33d21e6345da1
--- /dev/null
+++ b/include/interconnect-uclass.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#ifndef _INTERCONNECT_UCLASS_H
+#define _INTERCONNECT_UCLASS_H
+
+#include <interconnect.h>
+
+#define icc_units_to_bps(bw)  ((bw) * 1000ULL)
+
+struct udevice;
+struct icc_node;
+
+struct icc_req {
+	struct hlist_node req_node;
+	struct icc_node *node;
+	struct device *dev;
+	bool enabled;
+	u32 tag;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+struct icc_path {
+	size_t num_nodes;
+	struct icc_req reqs[];
+};
+
+struct icc_provider {
+	struct udevice		*dev;
+	struct list_head	provider_list;
+	struct list_head	nodes;
+	int			users;
+	bool			inter_set;
+	unsigned int		xlate_num_nodes;
+	struct icc_node	**xlate_nodes;
+};
+
+struct icc_node {
+	struct udevice		*dev;
+	int			id;
+	struct icc_node		**links;
+	size_t			num_links;
+	u8			is_unlinked:1;
+
+	struct icc_provider	*provider;
+	struct list_head	node_list;
+	struct list_head	search_list;
+	struct icc_node		*reverse;
+	u8			is_traversed:1;
+	struct hlist_head	req_list;
+	u32			avg_bw;
+	u32			peak_bw;
+	u32			init_avg;
+	u32			init_peak;
+	void			*data;
+};
+
+struct interconnect_ops {
+	struct icc_node *(*of_xlate)(struct udevice *dev,
+				     const struct ofnode_phandle_args *args);
+	bool (*has_node_id)(struct udevice *dev, int id);
+	int (*set)(struct icc_node *src, struct icc_node *dst);
+	void (*pre_aggregate)(struct icc_node *node);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+};
+
+struct icc_node *icc_node_create(const struct icc_provider *provider,
+				 int id, const char *node_name);
+int icc_link_create(struct icc_node *node, const int dst_id);
+void icc_node_add(struct icc_node *node, struct icc_provider *provider);
+void icc_node_del(struct icc_node *node);
+
+#endif
diff --git a/include/interconnect.h b/include/interconnect.h
new file mode 100644
index 0000000000000000000000000000000000000000..05f3d4f8999b3b378d54727124aec82d0bca7d2d
--- /dev/null
+++ b/include/interconnect.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#ifndef _INTERCONNECT_H
+#define _INTERCONNECT_H
+
+#include <linux/errno.h>
+
+struct udevice;
+
+/* macros for converting to icc units */
+#define Bps_to_icc(x)	((x) / 1000)
+#define kBps_to_icc(x)	(x)
+#define MBps_to_icc(x)	((x) * 1000)
+#define GBps_to_icc(x)	((x) * 1000 * 1000)
+#define bps_to_icc(x)	(1)
+#define kbps_to_icc(x)	((x) / 8 + ((x) % 8 ? 1 : 0))
+#define Mbps_to_icc(x)	((x) * 1000 / 8)
+#define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
+
+struct icc_path;
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+struct icc_path *of_icc_get(struct udevice *dev, const char *name);
+#else
+static inline
+struct icc_path *of_icc_get(struct udevice *dev, const char *name)
+{
+	return NULL;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+struct icc_path *of_icc_get_by_index(struct udevice *dev, int idx);
+#else
+static inline
+struct icc_path *of_icc_get_by_index(struct udevice *dev, int idx)
+{
+	return NULL;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+void icc_put(struct icc_path *path);
+#else
+static inline void icc_put(struct icc_path *path)
+{
+}
+#endif
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_enable(struct icc_path *path);
+#else
+static inline int icc_enable(struct icc_path *path)
+{
+	return -ENOSYS;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_disable(struct icc_path *path);
+#else
+static inline int icc_disable(struct icc_path *path)
+{
+	return -ENOSYS;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+#else
+static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif

-- 
2.34.1

