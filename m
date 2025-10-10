Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7877CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C6B8425A;
	Fri, 10 Oct 2025 16:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lNyD08pE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687C98442A; Fri, 10 Oct 2025 16:35:21 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97767842C3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so22418805e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760106917; x=1760711717; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=la9xlPxH7y5+l8TE7S2fmKV4XZPkGUIhS5cBjLq8bVE=;
 b=lNyD08pE/HeuMLLkXgZmPUYQVGvqakmFkGecd2CfmF+Mg38OIr31MYRq3ECFIUMK+Z
 MFJiylXE3IyuXXYWLhW5fUegZGuKKPdbADYaXD9evP6S3e1/Q7rXJjmfWxwLGZg/w+wJ
 vLilrOtMpERpRQ8GUIX8sAHasE0F9eCmODnXKcTWJkf5Wxeqsot7znODSuLs/6hpBBnG
 Xr+vMpphpu95RHAvkYlwxj1ZB6HUWwwE1oJGBgLlEx9sttVsgYLgKcoZEFylicaMKEyk
 Llf+391IlV1y/Q3Kvd4jpeR8md/12gIuf/EM1h8vs/hg4yVD12ixalZ4P6M8lxhQYxQ/
 JoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106917; x=1760711717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=la9xlPxH7y5+l8TE7S2fmKV4XZPkGUIhS5cBjLq8bVE=;
 b=TTpUt6DcZzGPwvfCPDAZZihVFTDNkHLv7mG8t7vTv+zkn49yAXMM7zibSBrga9X6Me
 bqHLHi200p6eltZpadXavDGvYC/L3BK1xUASQ/ZFYxVf2TXljY5q6yKzzS7aYdTuw5eI
 HUAZ5zw7FEPLjonl1PoEraTUoiYfzMD4LaUi18aHb8bJyfDTNS4MbTGyCZjwz5kgBXBQ
 hlzrOPiDoL1nsA2xsKsrxb8GMH2r2FuPS836J02rkkDy5jxAmEh7uiveCB/5RsP70H/3
 IazOyWHS1BacQNEeEeNMuQUPe8SjGEE7Lcz1VIVTSfHliy5iyN8H9EAgKcBMJsb0X49z
 e1jQ==
X-Gm-Message-State: AOJu0YxMBgJIX36CirnB26MuompUJOAr74eVyjDKmGOniD0w382Yml9F
 nAnpqfkgAFqpjkCoMv+iIZF2I9voLlaNB+gRwSs0iJ0EsGZnx7ihqYmWxdBXkatlkuE=
X-Gm-Gg: ASbGncs/6L1HhZFZMf+Vx1GRbPTqIdn16sxJPVt0DpaBKmLUVwpRQDt4t52fW59b70j
 gQAUxeM3ryhZrS+Li2/rYkIto4iLD9lrKttVt1qc0th04YLWAVBkJBHWgLaryxwigeFCiOidoI1
 0B0J8GbzbtLLwgvv87VqJOpBp4JMRmBzOeXIqsQOLCTYplZ/kTFBYmXs5F8mHYPzFLHMTjhy6rs
 MB0E2hcw2nuKYzNYxCLBVYTFcb88xkvMFBKF+U+h/XM6sCROYQWwUAlCjTOgDdGt/h1ZxtO41n4
 FqxB+j7/E892iQyZNgxq+tSQzJyHGxHRN7aPyEQxZ22o3TYVQpxqhc352dV1//4Qdk6XHTzeH7j
 /AkanrrhIW1zC0owbWjc1mYA2qEzWwTUOlvAoVWTn6l593rr5KGJ3AdW20xDPY4t8eMufFuUM6M
 Ze
X-Google-Smtp-Source: AGHT+IFKvDAORSpPzp3RSYdOOTwjfKIJwG0QrO7C2z920JxpKqHTR9TvgMutTXSHVehzHkpryTbaIA==
X-Received: by 2002:a05:600c:4510:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-46fa9a8f2e1mr78940515e9.7.1760106916611; 
 Fri, 10 Oct 2025 07:35:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm59878215e9.6.2025.10.10.07.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 10 Oct 2025 16:35:08 +0200
Subject: [PATCH v3 1/7] Introduce the Generic System Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-topic-interconnect-next-v3-1-b384713283a8@linaro.org>
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
In-Reply-To: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=33934;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pFs64AU3kjUTxK5o0BrVa2zVDzBNiH9AhRz+wDDO88U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo6RmfJysj6YJiGR1toybP9zGAcDhGoZzysE9Thkgx
 a52XOHOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOkZnwAKCRB33NvayMhJ0SS6D/
 9bkc7xXfaWlsJ1xEKvi+8KFy4A4TCD16ENBKI64xyM8xs7WXe8aTanWaMvhnzLHO04qwVX0iprjfnE
 rWSppmoSunkcqBZz20QLWkCCBFQjFdks2u5l7efw/8VXv089JrgYyuvV0SOUzdjg6QcLx3jd816t5k
 Fe3JWmsWdOBIMMjS/WEJDqKhVv8lyRYnCjjWelRDLQLK3+W+P6NERmqiF84588RvWZ7SBoHod47++C
 S74w8M17QFbSWs1D4fP40Q3hV0O1zlfJ0/8fmottLMsIS2eKMm5hKR8pR3OQZlvMHoxN4VAWoUCDHz
 BInrf6YqoNVQo/qzRTP3oE9cPQ7gKryg6mk1GjKLVvSdAhxZqyo4KDTM9WqgrVZ5rv51NJnoTkpRuA
 UCpDE/gbvY3LKOAz0s8Tof5AWaNfEy7nRTVJ/2qtXVC6IQ7E52tYPwGZfVdWzWzmnWHXx6GnYWmCqk
 CDUBK49PP5fDsp+Z5Y4+5ebFRYMQz17Evx3MEWnretG78WFzOZRqoeH6c5zCOYGtSoiqeuUZf2V6yf
 NzIrD3bJgBz8/BFcxz7JvWx79NomPytgKGGFQ2fq6P6i/xtFvR0VPqrO5sGxhL1nPfFbd8g3FrLvVm
 EnQ9oK/rbgQI7ICQZGTls8k7LyAw/opUPOmGMLeyS+Veu1VZUWfxujk4WHAg==
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

Let's introduce the Generic System Interconnect subsystem based on
the counterpart Linux framework which is used to vote for bandwidth
across multiple SoC busses.

Documentation for the Linux Generic System Interconnect Subsystem can
be found at [1].

Each bus endpoints are materialised as "nodes" which are linked together,
and the DT will specify a pair of nodes to enable and set a bandwidth
on the route between those endpoints.

The hardware resources that provide those nodes and provides the way
to vote for the bandwidth are called "providers".

The Interconnect uclass code is heavily based on the Linux one, with
some small differences:
- nodes are allocated as udevices instead of Linux idr_alloc()
- tag management is minimal, only normal xlate is supported
- getting nodes states at probe is not implemented
- providers are probed on demand while the nodes links are traversed
- nodes are populated on bind
- id management is simplified, static IDs and dynamics IDs can be used
- identical consume API as Linux, only implementation differs

Fully tested with associated DM test suite.

[1] https://docs.kernel.org/driver-api/interconnect.html

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/api/index.rst                          |   1 +
 doc/api/interconnect.rst                   | 117 +++++++
 drivers/Kconfig                            |   2 +
 drivers/Makefile                           |   1 +
 drivers/interconnect/Kconfig               |  10 +
 drivers/interconnect/Makefile              |   6 +
 drivers/interconnect/interconnect-uclass.c | 543 +++++++++++++++++++++++++++++
 include/dm/uclass-id.h                     |   2 +
 include/interconnect-uclass.h              | 136 ++++++++
 include/interconnect.h                     | 155 ++++++++
 10 files changed, 973 insertions(+)

diff --git a/doc/api/index.rst b/doc/api/index.rst
index d97630e76716b7edddd06e39588cdb6f001265bc..40134e4f42ca537b33e3495993c8227fb5d0ebea 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -15,6 +15,7 @@ U-Boot API documentation
    fs
    getopt
    interrupt
+   interconnect
    i3c
    led
    linker_lists
diff --git a/doc/api/interconnect.rst b/doc/api/interconnect.rst
new file mode 100644
index 0000000000000000000000000000000000000000..c5182a3eb985bf97475b223a09be03511d6a5c86
--- /dev/null
+++ b/doc/api/interconnect.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Generic System Interconnect Subsystem
+=====================================
+
+Introduction
+------------
+
+This framework is designed to provide a standard kernel interface to control
+the settings of the interconnects on an SoC. These settings can be throughput,
+latency and priority between multiple interconnected devices or functional
+blocks. This can be controlled dynamically in order to save power or provide
+maximum performance.
+
+The interconnect bus is hardware with configurable parameters, which can be
+set on a data path according to the requests received from various drivers.
+An example of interconnect buses are the interconnects between various
+components or functional blocks in chipsets. There can be multiple interconnects
+on an SoC that can be multi-tiered.
+
+Below is a simplified diagram of a real-world SoC interconnect bus topology.
+
+::
+
+ +----------------+    +----------------+
+ | HW Accelerator |--->|      M NoC     |<---------------+
+ +----------------+    +----------------+                |
+                         |      |                    +------------+
+  +-----+  +-------------+      V       +------+     |            |
+  | DDR |  |                +--------+  | PCIe |     |            |
+  +-----+  |                | Slaves |  +------+     |            |
+    ^ ^    |                +--------+     |         |   C NoC    |
+    | |    V                               V         |            |
+ +------------------+   +------------------------+   |            |   +-----+
+ |                  |-->|                        |-->|            |-->| CPU |
+ |                  |-->|                        |<--|            |   +-----+
+ |     Mem NoC      |   |         S NoC          |   +------------+
+ |                  |<--|                        |---------+    |
+ |                  |<--|                        |<------+ |    |   +--------+
+ +------------------+   +------------------------+       | |    +-->| Slaves |
+   ^  ^    ^    ^          ^                             | |        +--------+
+   |  |    |    |          |                             | V
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+ | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+ +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
+           |
+       +-------+
+       | Modem |
+       +-------+
+
+Terminology
+-----------
+
+Interconnect provider is the software definition of the interconnect hardware.
+The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
+and Mem NoC.
+
+Interconnect node is the software definition of the interconnect hardware
+port. Each interconnect provider consists of multiple interconnect nodes,
+which are connected to other SoC components including other interconnect
+providers. The point on the diagram where the CPUs connect to the memory is
+called an interconnect node, which belongs to the Mem NoC interconnect provider.
+
+Interconnect endpoints are the first or the last element of the path. Every
+endpoint is a node, but not every node is an endpoint.
+
+Interconnect path is everything between two endpoints including all the nodes
+that have to be traversed to reach from a source to destination node. It may
+include multiple master-slave pairs across several interconnect providers.
+
+Interconnect consumers are the entities which make use of the data paths exposed
+by the providers. The consumers send requests to providers requesting various
+throughput, latency and priority. Usually the consumers are device drivers, that
+send request based on their needs. An example for a consumer is a video decoder
+that supports various formats and image sizes.
+
+U-Boot Implementation
+---------------------
+
+The implementation is derived from the Linux 6.17 Interconnect implementation,
+adapted to use the U-Boot Driver Model. Under Linux the nodes are allocated
+via `idr_alloc()`, while under U-Boot they are created as `icc_node` devices
+which are children of the provider device. This provides the same lifetime
+by using a robust and ready to use mechanism, simplifying the implementation.
+
+Under Linux, the nodes link is done by always allocating a new `icc_node` when
+creating a link, and when the link with the associated ID is registered
+it is associated to the new provider. Under U-Boot only the nodes from a provider
+are created at bind time, and when the node graph is traversed to calculate
+a path the link ID is looked dynamically amongst the node devices. This
+may take longer at the gain of time when registering nodes a bind time.
+
+Since U-Boot Driver Model does on-demand device probe, the nodes and provider
+devices are also probed when a path is determined and removed when the path
+is deleted.
+
+A test suite is present in `test/dm/interconnect.c` using a test driver
+`sandbox-interconnect` to exercise those U-Boot specific aspects while making
+sure the graph traversal and calculation are accurate.
+
+Interconnect consumers API
+--------------------------
+
+Interconnect consumers are the clients which use the interconnect APIs to
+get paths between endpoints and set their bandwidth/latency/QoS requirements
+for these interconnect paths.
+
+.. kernel-doc:: include/interconnect.h
+
+Interconnect uclass providers API
+---------------------------------
+
+Interconnect provider is an entity that implements methods to initialize and
+configure interconnect bus hardware. The interconnect provider drivers should
+be registered a interconnect uclass drivers.
+
+.. kernel-doc:: include/interconnect-uclass.h
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
index 0000000000000000000000000000000000000000..e8e566ab1722cae983edae8db7610c868f3367bb
--- /dev/null
+++ b/drivers/interconnect/interconnect-uclass.c
@@ -0,0 +1,543 @@
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
+static struct icc_node *of_icc_get_from_provider(struct udevice *dev,
+						 const struct ofnode_phandle_args *args);
+static struct icc_path *icc_path_find(struct udevice *dev,
+				      struct icc_node *src, struct icc_node *dst);
+static struct icc_node *icc_node_find(const ulong id);
+
+/* Public API */
+
+struct icc_path *of_icc_get(struct udevice *dev, const char *name)
+{
+	int index = 0;
+
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	if (!ofnode_has_property(dev_ofnode(dev), "interconnects"))
+		return NULL;
+
+	if (name) {
+		index = dev_read_stringlist_search(dev, "interconnect-names", name);
+		if (index < 0) {
+			debug("fdt_stringlist_search() failed: %d\n", index);
+			return ERR_PTR(index);
+		}
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
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	debug("(dev=%p,idx=%d)\n", dev, index);
+
+	if (!ofnode_has_property(dev_ofnode(dev), "interconnects"))
+		return NULL;
+
+	ret = dev_read_phandle_with_args(dev, "interconnects",
+					 "#interconnect-cells", 0, index * 2,
+					 &src_args);
+	if (ret) {
+		dev_err(dev, "dev_read_phandle_with_args src failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = dev_read_phandle_with_args(dev, "interconnects",
+					 "#interconnect-cells", 0, index * 2 + 1,
+					 &dst_args);
+	if (ret) {
+		dev_err(dev, "dev_read_phandle_with_args dst failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	src_node = of_icc_get_from_provider(dev, &src_args);
+	if (IS_ERR(src_node)) {
+		dev_err(dev, "error finding src node\n");
+		return ERR_CAST(src_node);
+	}
+
+	dst_node = of_icc_get_from_provider(dev, &dst_args);
+	if (IS_ERR(dst_node)) {
+		dev_err(dev, "error finding dst node\n");
+		return ERR_CAST(dst_node);
+	}
+
+	path = icc_path_find(dev, src_node, dst_node);
+	if (IS_ERR(path))
+		dev_err(dev, "invalid path=%ld\n", PTR_ERR(path));
+
+	debug("(path=%p)\n", path);
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
+	debug("(path=%p)\n", path);
+
+	if (!path || IS_ERR(path))
+		return 0;
+
+	ret = icc_set_bw(path, 0, 0);
+	if (ret) {
+		dev_err(path->dev, "failed to set bandwidth (%d)\n", ret);
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
+	debug("(path=%p)\n", path);
+	return __icc_enable(path, true);
+}
+
+int icc_disable(struct icc_path *path)
+{
+	debug("(path=%p)\n", path);
+	return __icc_enable(path, false);
+}
+
+static int apply_constraints(struct icc_path *path)
+{
+	struct icc_node *next, *prev = NULL;
+	const struct interconnect_ops *ops;
+	struct icc_provider *provider;
+	struct udevice *p;
+	int ret = -EINVAL;
+	int i;
+
+	debug("(path=%p)\n", path);
+
+	for (i = 0; i < path->num_nodes; i++) {
+		next = path->reqs[i].node;
+		p = next->dev->parent;
+		provider = dev_get_uclass_plat(p);
+
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev || (p != prev->dev->parent && !provider->inter_set)) {
+			prev = next;
+			continue;
+		}
+
+		debug("(path=%p,req=%d,node=%s,provider=%s)\n",
+		      path, i, next->dev->name, p->name);
+
+		ops = device_get_ops(p);
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
+/*
+ * We want the path to honor all bandwidth requests, so the average and peak
+ * bandwidth requirements from each consumer are aggregated at each node.
+ * The aggregation is platform specific, so each platform can customize it by
+ * implementing its own aggregate() function.
+ */
+
+static int aggregate_requests(struct icc_node *node)
+{
+	const struct interconnect_ops *ops = device_get_ops(node->dev->parent);
+	struct icc_req *r;
+	u32 avg_bw, peak_bw;
+
+	debug("(dev=%s)\n", node->dev->name);
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
+		debug("(dev=%s,req=%s,avg=%d,peak=%d)\n",
+		      node->dev->name, r->node->dev->name,
+		      avg_bw, peak_bw);
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
+	debug("(path=%p,avg=%d,peak=%d)\n", path, avg_bw, peak_bw);
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
+		dev_err(path->dev, "error applying constraints (%d)\n", ret);
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
+static struct icc_path *icc_path_init(struct udevice *dev, struct icc_node *dst,
+				      ssize_t num_nodes)
+{
+	struct icc_node *node = dst;
+	struct icc_path *path;
+	struct udevice *node_dev;
+	int i, ret;
+
+	debug("(dev=%s,node=%s)\n", dev->name, node->dev->name);
+
+	path = malloc(sizeof(struct icc_path) + sizeof(struct icc_req) * num_nodes);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	path->dev = dev;
+	path->num_nodes = num_nodes;
+
+	for (i = num_nodes - 1; i >= 0; i--) {
+		debug("(req[%d]=%s)\n", i, node->dev->name);
+		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
+		path->reqs[i].node = node;
+		path->reqs[i].enabled = true;
+
+		/* Probe this node since used in an active path */
+		ret = uclass_get_device_tail(node->dev, 0, &node_dev);
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
+static struct icc_path *icc_path_find(struct udevice *dev, struct icc_node *src,
+				      struct icc_node *dst)
+{
+	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node *n, *node = NULL;
+	struct list_head traverse_list;
+	struct list_head edge_list;
+	struct list_head visited_list;
+	size_t i, depth = 1;
+	bool found = false;
+
+	debug("(dev=%s,src=%s,dest=%p\n",
+	      dev->name, src->dev->name, dst->dev->name);
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
+				tmp = icc_node_find(node->links[i]);
+				if (!tmp) {
+					dev_err(dev, "missing link to node id %lx\n",
+						node->links[i]);
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
+		path = icc_path_init(dev, dst, depth);
+
+	return path;
+}
+
+static struct icc_node *of_icc_get_from_provider(struct udevice *dev,
+						 const struct ofnode_phandle_args *args)
+{
+	const struct interconnect_ops *ops;
+	struct udevice *icc_dev;
+	int ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_INTERCONNECT, args->node,
+					  &icc_dev);
+	if (ret) {
+		dev_err(dev, "uclass_get_device_by_ofnode failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+	ops = device_get_ops(icc_dev);
+
+	return ops->of_xlate(icc_dev, args);
+}
+
+static struct icc_node *icc_node_find(const ulong id)
+{
+	struct udevice *dev;
+
+	for (uclass_find_first_device(UCLASS_ICC_NODE, &dev);
+	     dev;
+	     uclass_find_next_device(&dev)) {
+		if (dev_get_driver_data(dev) == id)
+			return dev_get_uclass_plat(dev);
+	}
+
+	return NULL;
+}
+
+static bool icc_node_busy(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("(dev=%s,users=%d)\n", dev->name, node->users);
+
+	return !!node->users;
+}
+
+struct icc_node *icc_node_create(struct udevice *dev,
+				 ulong id, const char *name)
+{
+	struct udevice *node;
+	struct driver *drv;
+	int ret;
+
+	drv = lists_driver_lookup_name("icc_node");
+	if (!drv)
+		return ERR_PTR(-ENOENT);
+
+	ret = device_bind_with_driver_data(dev, drv, strdup(name),
+					   id, ofnode_null(), &node);
+	if (ret)
+		return ERR_PTR(ret);
+
+	device_set_name_alloced(node);
+
+	return dev_get_uclass_plat(node);
+}
+
+int icc_link_create(struct icc_node *node, const ulong dst_id)
+{
+	ulong *new;
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
+static int icc_node_bind(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("(dev=%s)\n", dev->name);
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
+	debug("(dev=%s,parent=%p,id=%lx)\n",
+	      dev->name, dev->parent->name, dev_get_driver_data(dev));
+
+	node->avg_bw = 0;
+	node->peak_bw = 0;
+
+	return 0;
+}
+
+static int icc_node_remove(struct udevice *dev)
+{
+	debug("(dev=%s,parent=%s,id=%lx)\n",
+	      dev->name, dev->parent->name, dev_get_driver_data(dev));
+
+	if (icc_node_busy(dev))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int icc_node_unbind(struct udevice *dev)
+{
+	struct icc_node *node = dev_get_uclass_plat(dev);
+
+	debug("(dev=%s,id=%lx)\n",
+	      dev->name, dev_get_driver_data(dev));
+
+	kfree(node->links);
+
+	return 0;
+}
+
+UCLASS_DRIVER(interconnect) = {
+	.id		= UCLASS_INTERCONNECT,
+	.name		= "interconnect",
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
index 0000000000000000000000000000000000000000..d942ddec41b2a42a84cb69783dbed998a332371d
--- /dev/null
+++ b/include/interconnect-uclass.h
@@ -0,0 +1,136 @@
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
+
+/**
+ * struct icc_req - constraints that are attached to each node
+ *
+ * @req_node:	entry in list of requests for the particular @node
+ * @node:	the interconnect node to which this constraint applies
+ * @enabled:	indicates whether the path with this request is enabled
+ * @tag:	path tag (optional)
+ * @avg_bw:	an integer describing the average bandwidth in kBps
+ * @peak_bw:	an integer describing the peak bandwidth in kBps
+ */
+struct icc_req {
+	struct hlist_node	req_node;
+	struct icc_node		*node;
+	bool			enabled;
+	u32			tag;
+	u32			avg_bw;
+	u32			peak_bw;
+};
+
+/**
+ * struct icc_path - An interconnect path
+ *
+ * @dev:	Device who requested the path
+ * @num_nodes:	number of nodes (hops) in the path
+ * @reqs:	array of the requests applicable to this path of nodes
+ */
+struct icc_path {
+	struct udevice		*dev;
+	size_t			num_nodes;
+	struct icc_req		reqs[];
+};
+
+/**
+ * struct icc_provider - interconnect provider (controller) entity that might
+ * provide multiple interconnect controls
+ *
+ * @inter_set:		whether inter-provider pairs will be configured with @set
+ * @xlate_num_nodes:	provider-specific nodes counts for mapping nodes from phandle arguments
+ * @xlate_nodes:	provider-specific array for mapping nodes from phandle arguments
+ */
+struct icc_provider {
+	bool			inter_set;
+	unsigned int		xlate_num_nodes;
+	struct icc_node		**xlate_nodes;
+};
+
+/**
+ * struct icc_node - entity that is part of the interconnect topology
+ *
+ * @dev:		points to the interconnect provider of this node
+ * @links:		a list of targets pointing to where we can go next when traversing
+ * @num_links:		number of links to other interconnect nodes
+ * @users:		count of active users
+ * @node_list:		the list entry in the parent provider's "nodes" list
+ * @search_list:	list used when walking the nodes graph
+ * @reverse:		pointer to previous node when walking the nodes graph
+ * @is_traversed:	flag that is used when walking the nodes graph
+ * @req_list:		a list of QoS constraint requests associated with this node
+ * @avg_bw:		aggregated value of average bandwidth requests from all consumers
+ * @peak_bw:		aggregated value of peak bandwidth requests from all consumers
+ * @data:		pointer to private data
+ */
+struct icc_node {
+	struct udevice		*dev;
+	ulong			*links;
+	size_t			num_links;
+	int			users;
+
+	struct list_head	node_list;
+	struct list_head	search_list;
+	struct icc_node		*reverse;
+	u8			is_traversed:1;
+	struct hlist_head	req_list;
+	u32			avg_bw;
+	u32			peak_bw;
+	void			*data;
+};
+
+/**
+ * struct interconnect_ops - Interconnect uclass operations
+ *
+ * @of_xlate:		provider-specific callback for mapping nodes from phandle arguments
+ * @set:		pointer to device specific set operation function
+ * @pre_aggregate:	pointer to device specific function that is called
+ *			before the aggregation begins (optional)
+ * @aggregate:		pointer to device specific aggregate operation function
+ */
+struct interconnect_ops {
+	struct icc_node *(*of_xlate)(struct udevice *dev,
+				     const struct ofnode_phandle_args *args);
+	int (*set)(struct icc_node *src, struct icc_node *dst);
+	void (*pre_aggregate)(struct icc_node *node);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+};
+
+/**
+ * icc_node_create() - create a node
+ *
+ * @dev:	Provider device
+ * @id:		node id, can be a numeric ID or pointer casted to ulong
+ * @name:	node name
+ *
+ * Return: icc_node pointer on success, or ERR_PTR() on error
+ */
+struct icc_node *icc_node_create(struct udevice *dev,
+				 ulong id, const char *name);
+
+/**
+ * icc_link_create() - create a link between two nodes
+ * @node: source node id
+ * @dst_id: destination node id
+ *
+ * Create a link between two nodes. The nodes might belong to different
+ * interconnect providers and the @dst_id node might not exist, the link
+ * will be done at runtime in `icc_path_find()`.
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_link_create(struct icc_node *node, const ulong dst_id);
+
+#endif
diff --git a/include/interconnect.h b/include/interconnect.h
new file mode 100644
index 0000000000000000000000000000000000000000..11ed30d79d6243d6ca12780e0b5b9377ef936223
--- /dev/null
+++ b/include/interconnect.h
@@ -0,0 +1,155 @@
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
+/**
+ * of_icc_get - Get an Interconnect path from a DT node based on name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * @dev:	The client device.
+ * @name:	Name of the interconnect endpoint pair.
+ * Return:	icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
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
+/**
+ * of_icc_get - Get an Interconnect path from a DT node based on index
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * @dev:	The client device.
+ * @idx:	Index of the interconnect endpoint pair.
+ * Return:	icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
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
+/**
+ * icc_put - release the reference to the Interconnect path.
+ *
+ * Use this function to release the constraints on a path when the path is
+ * no longer needed. The constraints will be re-aggregated.
+ *
+ * @path:	An interconnect path
+ * Return: 0 if OK, or a negative error code.
+ */
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_put(struct icc_path *path);
+#else
+static inline int icc_put(struct icc_path *path)
+{
+	return 0;
+}
+#endif
+
+/**
+ * icc_enable - Enable an Interconnect path.
+ *
+ * This will enable all the endpoints in the path, using the
+ * bandwidth set by the `icc_set_bw()` call. Otherwise a zero
+ * bandwidth will be set. Usually used after a call to `icc_disable()`.
+ *
+ * @path:	An interconnect path
+ * Return: 0 if OK, or a negative error code. -ENOSYS if not implemented.
+ */
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_enable(struct icc_path *path);
+#else
+static inline int icc_enable(struct icc_path *path)
+{
+	return -ENOSYS;
+}
+#endif
+
+/**
+ * icc_disable - Disable an Interconnect path.
+ *
+ * This will disable all the endpoints in the path, effectively setting
+ * a zero bandwidth. Calling `icc_enable()` will restore the bandwidth set
+ * by calling `icc_set_bw()`.
+ *
+ * @path:	An interconnect path
+ * Return: 0 if OK, or a negative error code. -ENOSYS if not implemented.
+ */
+#if CONFIG_IS_ENABLED(INTERCONNECT)
+int icc_disable(struct icc_path *path);
+#else
+static inline int icc_disable(struct icc_path *path)
+{
+	return -ENOSYS;
+}
+#endif
+
+/**
+ * icc_set_bw - set bandwidth constraints on an interconnect path.
+ *
+ * This function is used by an interconnect consumer to express its own needs
+ * in terms of bandwidth for a previously requested path between two endpoints.
+ * The requests are aggregated and each node is updated accordingly. The entire
+ * path is locked by a mutex to ensure that the set() is completed.
+ * The @path can be NULL when the "interconnects" DT properties is missing,
+ * which will mean that no constraints will be set.
+ *
+ * @path:	An interconnect path
+ * @avg_bw:	Average bandwidth request in kBps
+ * @peak_bw:	Peak bandwidth in request kBps
+ * Return: 0 if OK, or a negative error code. -ENOSYS if not implemented.
+ */
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

