Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A327CEDD99
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132DB89233;
	Wed,  9 Oct 2024 16:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KBpuUWXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EEA8923D; Wed,  9 Oct 2024 16:03:44 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD69D8922E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so27047f8f.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728482621; x=1729087421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsvDa2UFAwg5RxlQg5tgb1hlxzko3UPk9gKM3nWPpnE=;
 b=KBpuUWXFhlLopF8s2jQTHORQkeJqB7wSg6qrCav42tqophqG8GNXptzq1pxPSkdYKy
 NLyVTQQPjOvyDXQyScs68EjzXr8ebI7Qwlb8+kg2Ujnrs4ysWFfHXDR/KuoJL7tXln2w
 QHtbcLWrVmXELOgLZR9PpBoBtxTVV2hPBxb8dUavuNFmIxwIuKJDBdWUOd/jU75PKSHd
 qJ1kFcGyVydjOxNyE9yrQfGn8IG3Vl5bG0Hg6w0owL6vjt9mYLwBurzuogc2oR/WDa2z
 eoQiOckm4mIwthisHNpHUZTqdvYQBcwprdGITJM4G6Z0dazzhF1EKqpRm2nTyJ2KwHwd
 QPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482621; x=1729087421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsvDa2UFAwg5RxlQg5tgb1hlxzko3UPk9gKM3nWPpnE=;
 b=tihw7xLPcSqX2KKmA5+jP1zBc9AHPplbWhBI7PXjL7QrnUwohzR/XCAlDr0bvtQcLv
 jCEoue3zpk0wj3RAjo8VP1fEmZpdh3QN+pGQxSn+7HTyfA9q+dUop2UcacbCXVOmDzz8
 Cez6UXm430AFDPLaI4idOTyvlikDqmSlYWSp9yhLueHmFPSkbzVfkmMC5epLGFrCaISg
 3pDiRKNiLhg3wTrP7o8sIe9KpGg7qrPjj1uZsLSyZppd/VW4ye/alWUi5W5hUOtwFWGK
 P7utdoIL8kvQwNED1/pPXa5Bo/E5mBb0qBT7ZTB5bLAxF+bKF2+N8pgxFp+gAn/LXQIq
 fXnw==
X-Gm-Message-State: AOJu0YzZw2nPf5OszUJLvPeadOSHjLkXR0mkBNBQbjX5VPoZLe9z2ZSB
 IPtwKPUc8mkCIvQQFKEbPoPqkqa6EdIiB0QIphPEFS8ksWfp5eSn3E6NludDooQ9h6O6zEvzD8X
 mgWlB/Q==
X-Google-Smtp-Source: AGHT+IFAp7LaTYZ8GWS7hy17PkjDsKz+vHA61oJBURVo9+RC4khJJDUTvkLa95/hQ6QcbOctyZ05Zg==
X-Received: by 2002:a05:6000:1803:b0:367:9881:7d66 with SMTP id
 ffacd0b85a97d-37d3aa6befdmr1688933f8f.41.1728482620295; 
 Wed, 09 Oct 2024 07:03:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f0b2sm10581728f8f.9.2024.10.09.07.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:03:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Yang Xiwen <forbidden405@outlook.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Robert Marko <robert.marko@sartura.hr>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Marek Vasut <marex@denx.de>, Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v12 02/21] sandbox: add dummy driver ETH_SANDBOX_LWIP
Date: Wed,  9 Oct 2024 16:02:52 +0200
Message-Id: <fca7514c15bfa3654c0be7bb6c9ba63770389dc0.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Introduce ETH_SANDBOX_LWIP which enables a mock driver similar to
ETH_SANDOX but without the dependencies on the legacy network stack
(NET) so that it may be enabled when the lwIP stack (NET_LWIP) is
introduced. The driver does nothing at this stage but its presence
will allow dm_test_iommu_noiommu [1] to pass.

[1] ./u-boot -T -c "ut dm dm_test_iommu_noiommu"

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/net/Kconfig        | 11 +++++
 drivers/net/Makefile       |  1 +
 drivers/net/sandbox-lwip.c | 85 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/net/sandbox-lwip.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e7d0ddfe25a..2f39ec05ac7 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -350,6 +350,17 @@ config ETH_SANDBOX
 
 	  This driver is particularly useful in the test/dm/eth.c tests
 
+config ETH_SANDBOX_LWIP
+	depends on SANDBOX
+	depends on NET_LWIP
+	default y
+	bool "Sandbox: Mocked Ethernet driver (for NET_LWIP)"
+	help
+	  This driver is meant as a replacement for ETH_SANDBOX when
+	  the network stack is NET_LWIP rather than NET. It currently
+	  does nothing, i.e. it drops the sent packets and never receives
+	  data.
+
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
 	default y
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4946a63f80f..f5ab1f5dedf 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ETH_DESIGNWARE_SOCFPGA) += dwmac_socfpga.o
 obj-$(CONFIG_ETH_SANDBOX) += sandbox.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw-bus.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw.o
+obj-$(CONFIG_ETH_SANDBOX_LWIP) += sandbox-lwip.o
 obj-$(CONFIG_FEC_MXC) += fec_mxc.o
 obj-$(CONFIG_FMAN_ENET) += fm/
 obj-$(CONFIG_FMAN_ENET) += fsl_mdio.o
diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
new file mode 100644
index 00000000000..3721033c310
--- /dev/null
+++ b/drivers/net/sandbox-lwip.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015 National Instruments
+ *
+ * (C) Copyright 2015
+ * Joe Hershberger <joe.hershberger@ni.com>
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <net.h>
+#include <asm/eth.h>
+#include <asm/global_data.h>
+#include <asm/test.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int sb_lwip_eth_start(struct udevice *dev)
+{
+	debug("eth_sandbox_lwip: Start\n");
+
+	return 0;
+}
+
+static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
+{
+	debug("eth_sandbox_lwip: Send packet %d\n", length);
+
+	return -ENOTSUPP;
+}
+
+static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	return -EAGAIN;
+}
+
+static int sb_lwip_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	return 0;
+}
+
+static void sb_lwip_eth_stop(struct udevice *dev)
+{
+}
+
+static int sb_lwip_eth_write_hwaddr(struct udevice *dev)
+{
+	return 0;
+}
+
+static const struct eth_ops sb_eth_ops = {
+	.start			= sb_lwip_eth_start,
+	.send			= sb_lwip_eth_send,
+	.recv			= sb_lwip_eth_recv,
+	.free_pkt		= sb_lwip_eth_free_pkt,
+	.stop			= sb_lwip_eth_stop,
+	.write_hwaddr		= sb_lwip_eth_write_hwaddr,
+};
+
+static int sb_lwip_eth_remove(struct udevice *dev)
+{
+	return 0;
+}
+
+static int sb_lwip_eth_of_to_plat(struct udevice *dev)
+{
+	return 0;
+}
+
+static const struct udevice_id sb_eth_ids[] = {
+	{ .compatible = "sandbox,eth" },
+	{ }
+};
+
+U_BOOT_DRIVER(eth_sandbox) = {
+	.name	= "eth_lwip_sandbox",
+	.id	= UCLASS_ETH,
+	.of_match = sb_eth_ids,
+	.of_to_plat = sb_lwip_eth_of_to_plat,
+	.remove	= sb_lwip_eth_remove,
+	.ops	= &sb_eth_ops,
+	.priv_auto	= 0,
+	.plat_auto	= sizeof(struct eth_pdata),
+};
-- 
2.40.1

