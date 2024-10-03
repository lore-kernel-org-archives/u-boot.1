Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E5DCF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E632B88E31;
	Thu,  3 Oct 2024 17:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yUVasMrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC28888EAB; Thu,  3 Oct 2024 17:23:45 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F00B88E7A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cea34cb57so792643f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969022; x=1728573822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWG739LNLScuPnPoHoy8J4VInoN+jJ0v7ivgGIJsYr0=;
 b=yUVasMrQhymjrhewABv0WkgaShZueB+KfKq9vcUCDlPt7ZpySIDi/jhArolfEAMUuy
 UL/D61rnTSJ1VBqfLy78mBGSRoAhfDTxjIKDqxVve2NLDb3crQwUy7jUlAunmOP1JI3j
 K5GPmigIW7LNhkmANFDmPosHxTynYGXc9C4z9oTv3uytLMA2YGJRJIPQG73xo+V7jcr2
 LINzjQB/k4duKSTmcILmm1MQFOw53dlH9gDjCXajNFe87SBpVTtSIm90Z+IC2u0OMk4A
 HQ6tBRd8CB3XSubZNekCf275WAOK2LWgkMfaaQcFjfwfAwpccKewuHVPxusbKxNSioHT
 +baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969022; x=1728573822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWG739LNLScuPnPoHoy8J4VInoN+jJ0v7ivgGIJsYr0=;
 b=gmB0tnS6Gu4TO4IqEuHj4r47UfU94CFmA1gYdF/IRV5DZUBWzXqf8YVU4ycaQiXZoP
 pnOKpVGXHxuad1sK0LBM4BumBf38X8f+EoDBoZUrwlGf++Zxkuy3FxyV3Bjtt8lW+1bF
 SJgeSgrWa/oV2MFCfI76ngSsHEYBGMKvrdCgjAolD+RBPazpjrKYifNHiDeyQvRb40f3
 LEyZtj0nzrPDbRxmfXtW7zFfHY7OctMSVGZi5LsnpxU+kVVWpkxz7LLQ5qGit37oNB6d
 5J4T38bXGccZsuXX86V4Z4npe17lBJ7AX4O9Y1wyhSu7O+KpF3Tf37ygoao27u5tbNqf
 Hfug==
X-Gm-Message-State: AOJu0YyprysB2SkbKaJBlPkXKLc28X48CP1PXDg3Fd6BsnHao/8cyANa
 9bB8OwKs+ZWEzoOYUqE2qOXc0gVa3717X9ozkqx9blmkFFhkATQj1mEA5pcjcYN4o0J7cycxCfH
 JIztJ4A==
X-Google-Smtp-Source: AGHT+IFKDvftB9FpFFhvVopBKCf+JB+sf5U4GlNYd0Y1PX8C226z5wpgOLGO82sk6er5DSTuE+opPw==
X-Received: by 2002:a5d:4fca:0:b0:37c:cbd0:8d94 with SMTP id
 ffacd0b85a97d-37cfba20777mr3953005f8f.57.1727969022358; 
 Thu, 03 Oct 2024 08:23:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:42 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 Kever Yang <kever.yang@rock-chips.com>, Philip Oberfichtner <pro@denx.de>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v11 04/29] sandbox: add dummy driver ETH_SANDBOX_LWIP
Date: Thu,  3 Oct 2024 17:22:50 +0200
Message-Id: <1cc1dda87239c68cfa30430f08911b78cf4c69fd.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

