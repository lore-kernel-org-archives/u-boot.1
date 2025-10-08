Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6099BCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09F183E42;
	Wed,  8 Oct 2025 17:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KhQCiADQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECFF84090; Wed,  8 Oct 2025 17:31:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A573F83C91
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so65922595e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937496; x=1760542296; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Es6rhmaLnoL7IvmBYqHDzCZL6B96J4cBVpbn5R0gI0g=;
 b=KhQCiADQQI1Rlxzj7AZJEB/aKNeIkzt2lSaJqNPCFs0Y8bAWP1LwcZRvsHpKKTvP4C
 ZfubxgMPs6V4bJc943ddiESS/oVMkyMn0XNiiq8l/VFy9gW1IR5vjANjqT73s2HCimAR
 FxndCTKmedQsrSfRur2A1K3XTb1rsOOrgONov0YMzKwBKs7adEcVhAbnXa9B/h8fLm4/
 4HE3jm+ShEmPxtavC8Lf2DeB/v+VD4d4wtn9GEUyaEvsmXVPeR3oz4USQoHyiVP5XC8c
 9q69VGN7FAO9+Z2lkknsAXUW9xwgW5P0EYOLnIo72BywFptGRa3jouKzO7uX1rrYdA4z
 DFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937496; x=1760542296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Es6rhmaLnoL7IvmBYqHDzCZL6B96J4cBVpbn5R0gI0g=;
 b=NdvJaM7Q4lE2sgtBVu9G3m8cOE+jPv9VuiTR71fZ3zEQXMSgAoVZgCyapa1KXB7zdw
 c/izJ48KPjOcknSq2NP1Sc7VHR6HdWo4CD0HGMM7/TtkLuihiqcgH/EVZkZkzd4YsChP
 K96XIVhyIt78G2eLo/lb7sznGv8+caDsdCYFGQkhnmJkuCewqfN3CdsXewGjNnSKHs8G
 4yJ3ulXBtxvHJhidhRAKHWSsgjKeUsQ6DhBZACV6g55rV0yV0fFKbiSMgu/idsiVoCUj
 n3xonSRLqU9ke60QRxE3e5juD/jjzp675K6cY4PfwYUIFe6kYTpr0WBKstc1ZqTl7cku
 r7cw==
X-Gm-Message-State: AOJu0YxzoT2oCzvjDC/ppY/B8goHaHp3A6598+g2d3h88b+k5jCv3OaX
 STYd5DyCywC9hJmVUlbfzq6+orun+QLL1YBaXrYY2GyiZfwrpVpODOm4hmivETuZY5s=
X-Gm-Gg: ASbGncugEUvnl9qW4s0SjPdBFR1tipA5AjeFX2ahTo1/mHy3In3kF+h+ckRInE7JHK7
 9TtPPYvfCU8+vG1pZA5Lsu6i35NEorRx1kCXOwnci2+c1vEZzKM6pjzy4xKb6YW/4t/1LseAtBe
 cvyJUrdOADVlZIX9cgrKtKK1i16lNkbSlA71gSPTlkGt3xjjE7OKsAcWaj+uYhZZkV/H7/pLcnw
 hNO61jaFSAOAPj+Ofk7ThIKJe+Nix3CbW15sDC3Uf85xG7NLFM+7Sx92piXoXBwBqMwppsO+GGh
 qRWa/T5ggxpcufwL77TNHbQc+ZvNW1Nzgfkm7WEq6suig0/zZnNOA6jIeyxkhu+bONHdoOjEL5l
 HnpZFq3Y6eKgGU32/fXj48c/gDVsv1eVYnOV3I5/HG+K71Gk3j2s3AJtdkjJu/NSEPluPQbU=
X-Google-Smtp-Source: AGHT+IFjw3CJYg8gf64e1CWwemnWt+mtt5ldG+KwOAp2JMuSkvxC6YV6axmjHkBCDF2QW+jJw4CdOw==
X-Received: by 2002:a5d:64e8:0:b0:425:855c:5879 with SMTP id
 ffacd0b85a97d-4266e7d63f2mr2692655f8f.15.1759937495863; 
 Wed, 08 Oct 2025 08:31:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 17:31:28 +0200
Subject: [PATCH v2 1/7] Introduce the Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20935;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=n9y1nWb8+TLWvtMv1Aq3z+PtO1rySyonyxMtOwcorl0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPTHrO4FtsIAM1QFPHrdU8Rp34CE7ie0zbneMbG
 6Yc9hmeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD0wAKCRB33NvayMhJ0YCID/
 48NV1fSq8LVldJgF0KOK89GOE6zD1XZHGNpe4C5Z7IUPd+0tbc6HgR80xtiKuQD58acZPfbz2PmZI0
 zZlxPo4Rdym1Z4QOzj6KCPN8+dMYx+lxnYafrcDslE1cPa1VLXw4Jy4hBmdMTRfPlgHg+uRdDF6Hsi
 3+OjfyNmPurLwL1QS+sa3AtxbFeRhi9nbsntWlgXYJPFzi0woI9tC08+awWXHGQouSmElhhRnHEwbA
 3z0/Upl1JoAtEKrsB/QJAOvqhlnQ1nQVDcsXqIrgxxm1tJymREFxCW23XG9i/QQVadmVJ1wRh+ouBs
 vBJ8J8O/nAX5eZoHtlzFrX9cUgjg3+MNw2P3Bq6IUqOa/DUt2mCpn13gE5sg306UJW1vUufmdYr5pg
 15Cm5mzLalBOVN8Kbh7OhW4f8YMJDh2NIW4Qrtg1/cF8CSUYmrPuNRknMPvGHLDDZYVZLDt6NGUJYr
 gUTdZX3pRn47J2iUiY4LzZEi+DfzwegIFgI7vngAnQYV2WP3srPM6JfdVGrOjGfQETYzhslJYU0nEf
 L9hvL1CRgoVTAIsL27ODLysUy8CMUCgI4iZ2YIUBrcxLbPwxv7/CZs/uw6CyRqGaNdq3clE6gT3nPF
 nD3WxeAPI+AgIK4EOSgehlst4CdjJg6G0jJDxXwv5bFclU82gxFVNfMT516A==
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

Each bus endpoints are materialised as "nodes" which are linked together,
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
- nodes are populated on bind

Fully tested with associated DM test suite.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/Kconfig                            |   2 +
 drivers/Makefile                           |   1 +
 drivers/interconnect/Kconfig               |  10 +
 drivers/interconnect/Makefile              |   6 +
 drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
 include/dm/uclass-id.h                     |   2 +
 include/interconnect-uclass.h              |  74 ++++
 include/interconnect.h                     |  81 +++++
 8 files changed, 724 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 9e744c27d7ddf786e4c001be3d94ed7323fd5fe3..ab9e689d4d60952d6e495d7919828a700eb25e50 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -60,6 +60,8 @@ source "drivers/i3c/Kconfig"
 
 source "drivers/input/Kconfig"
 
+source "drivers/interconnect/Kconfig"
+
 source "drivers/iommu/Kconfig"
 
 source "drivers/led/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 79eabec965f0019cdcf463bd53e02db32bd9bc41..3a3da83771cb5a78232475f3f3d2be9f367b1c2a 100644
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
index 0000000000000000000000000000000000000000..b5d1baffce61b3c439db4899d412089c42898435
--- /dev/null
+++ b/drivers/interconnect/interconnect-uclass.c
@@ -0,0 +1,548 @@
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
+static struct icc_path *icc_path_find(struct icc_node *src, struct icc_node *dst);
+static struct icc_node *node_find(const int id);
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
+	path = icc_path_find(src_node, dst_node);
+	if (IS_ERR(path))
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+
+	debug("%s(path=%p)\n", __func__, path);
+
+	return path;
+}
+
+int icc_put(struct icc_path *path)
+{
+	struct icc_node *node;
+	size_t i;
+	int ret;
+
+	debug("%s(path=%p)\n", __func__, path);
+
+	if (!path || IS_ERR(path))
+		return 0;
+
+	ret = icc_set_bw(path, 0, 0);
+	if (ret) {
+		pr_err("%s: error (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < path->num_nodes; i++) {
+		node = path->reqs[i].node;
+
+		if (node->users)
+			node->users--;
+		if (!node->users)
+			device_remove(node->dev, DM_REMOVE_NORMAL);
+
+		hlist_del(&path->reqs[i].req_node);
+	}
+
+	kfree(path);
+
+	return 0;
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
+	debug("%s(path=%p)\n", __func__, path);
+	return __icc_enable(path, true);
+}
+
+int icc_disable(struct icc_path *path)
+{
+	debug("%s(path=%p)\n", __func__, path);
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
+	debug("%s(path=%p)\n", __func__, path);
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
+		if (ops->set) {
+			ret = ops->set(prev, next);
+			if (ret)
+				goto out;
+		}
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
+	debug("%s(dev=%s)\n", __func__, node->dev->name);
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
+		if (ops->aggregate)
+			ops->aggregate(node, r->tag, avg_bw, peak_bw,
+				       &node->avg_bw, &node->peak_bw);
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
+	debug("%s(path=%p)\n", __func__, path);
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
+	struct udevice *dev;
+	int i, ret;
+
+	debug("%s(dev=%s)\n", __func__, node->dev->name);
+
+	path = calloc(sizeof(struct icc_req), num_nodes);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->num_nodes = num_nodes;
+
+	for (i = num_nodes - 1; i >= 0; i--) {
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+		debug("%s: req %s\n", __func__, node->dev->name);
+		path->reqs[i].node = node;
+		path->reqs[i].enabled = true;
+
+		/* Probe this node since used in an active path */
+		ret = uclass_get_device_tail(node->dev, 0, &dev);
+		if (ret)
+			return ERR_PTR(ret);
+
+		node->users++;
+
+		/* reference to previous node was saved during path traversal */
+		node = node->reverse;
+	}
+
+	return path;
+}
+
+static struct icc_path *icc_path_find(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node *n, *node = NULL;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head visited_list;
+	size_t i, depth = 1;
+	bool found = false;
+
+	debug("%s(src=%s,dest=%p\n", __func__, src->dev->name, dst->dev->name);
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
+				struct icc_node *tmp;
+
+				tmp = node_find(node->links[i]);
+				if (!tmp) {
+					pr_err("%s: missing link to node id %d\n",
+					       __func__, node->links[i]);
+					path = ERR_PTR(-ENOENT);
+					goto out;
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
+	ret = device_bind_driver(provider->dev, "icc_node", strdup(name), &dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	device_set_name_alloced(dev);
+
+	node = dev_get_uclass_plat(dev);
+	node->id = id;
+
+	return node;
+}
+
+int icc_link_create(struct icc_node *node, const int dst_id)
+{
+	int *new;
+
+	if (!node->provider)
+		return -EINVAL;
+
+	new = realloc(node->links,
+		      (node->num_links + 1) * sizeof(*node->links));
+	if (!new)
+		return -ENOMEM;
+
+	node->links = new;
+	node->links[node->num_links++] = dst_id;
+
+	return 0;
+}
+
+void icc_node_add(struct icc_node *node, struct icc_provider *provider)
+{
+	node->provider = provider;
+}
+
+static int interconnect_pre_remove(struct udevice *dev)
+{
+	struct udevice *pos;
+	int ret;
+
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	device_foreach_child(pos, dev) {
+		debug("%s(pos=%s)\n", __func__, pos->name);
+		ret = device_remove(pos, DM_REMOVE_NORMAL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int interconnect_pre_unbind(struct udevice *dev)
+{
+	struct udevice *pos, *n;
+	int ret;
+
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	device_foreach_child_safe(pos, n, dev) {
+		debug("%s(pos=%s)\n", __func__, pos->name);
+		ret = device_unbind(pos);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int icc_node_bind(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	node->dev = dev;
+
+	return 0;
+}
+
+static int icc_node_probe(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("%s(dev=%s,parent=%p)\n", __func__, dev->name, dev->parent->name);
+
+	node->avg_bw = 0;
+	node->peak_bw = 0;
+
+	return 0;
+}
+
+static int icc_node_remove(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("%s(dev=%s,users=%d,parent=%p)\n", __func__,
+	      dev->name, node->users, dev->parent->name);
+
+	if (node->users)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int icc_node_unbind(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("%s(dev=%s)\n", __func__, dev->name);
+
+	kfree(node->links);
+
+	return 0;
+}
+
+UCLASS_DRIVER(interconnect) = {
+	.id		= UCLASS_INTERCONNECT,
+	.name		= "interconnect",
+	.pre_remove	= interconnect_pre_remove,
+	.pre_unbind	= interconnect_pre_unbind,
+	.per_device_plat_auto = sizeof(struct icc_provider),
+};
+
+U_BOOT_DRIVER(icc_node) = {
+	.name		= "icc_node",
+	.id		= UCLASS_ICC_NODE,
+	.bind		= icc_node_bind,
+	.probe		= icc_node_probe,
+	.remove		= icc_node_remove,
+	.unbind		= icc_node_unbind,
+};
+
+UCLASS_DRIVER(icc_node) = {
+	.id		= UCLASS_ICC_NODE,
+	.name		= "icc_node",
+	.per_device_plat_auto = sizeof(struct icc_node),
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 0bd4e64544afd0681c991b1077df1874e08ec32a..d4df46f09229ac309e066903d4ded5e760a73763 100644
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
index 0000000000000000000000000000000000000000..5b738fcdf128f760f4abf3d73d4628c884042253
--- /dev/null
+++ b/include/interconnect-uclass.h
@@ -0,0 +1,74 @@
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
+	bool			inter_set;
+	unsigned int		xlate_num_nodes;
+	struct icc_node		**xlate_nodes;
+};
+
+struct icc_node {
+	struct udevice		*dev;
+	int			id;
+	int			*links;
+	size_t			num_links;
+	u8			is_unlinked:1;
+	int			users;
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
index 0000000000000000000000000000000000000000..ae13227fe1116893a8159f106876b9d2bd553ca2
--- /dev/null
+++ b/include/interconnect.h
@@ -0,0 +1,81 @@
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
+int icc_put(struct icc_path *path);
+#else
+static inline int icc_put(struct icc_path *path)
+{
+	return 0;
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

