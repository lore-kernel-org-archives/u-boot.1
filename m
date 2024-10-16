Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D81D1AD3A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247E588EE0;
	Wed, 16 Oct 2024 11:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NdwkYT5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAB888EE0; Wed, 16 Oct 2024 11:57:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA05F88EFA
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4311ae6426aso43645145e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729072632; x=1729677432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW9+uWzKDW7pJ5fTh0gM/qvqLk/B68shSksA84VS5Us=;
 b=NdwkYT5yJeTqjyi6g7EhdYDl5SJDfNzVOmJ04miy1H2sWkGb8M6n8jMMSeTZCEZPAy
 VaSjeoob9AK9N+CHN4S45bbw3dhu1NaqwQyu/Juqg+mJsuYdexpEVfG/l4jeKEorYC19
 PWjFtp7554KplDUtYLi9W8A4ks/VAT8V5F9+cUOytniAPH55weqBuRjnHZ+RRsxLfqEu
 qpS3x6IHp4j8Fwvb051G8ITuo3rmneZpfzySd+dvNS+kuXAoR4KmoPxqYHSd7sUTE6UN
 DrpS2D8x61fGiVuNYr6S2MptPXAMspYEeSFGk8AMlRaORtISc1fjO/mGX8ejGtwNOf10
 6l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729072632; x=1729677432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW9+uWzKDW7pJ5fTh0gM/qvqLk/B68shSksA84VS5Us=;
 b=Vv5tJEtsFgXBLk7gv+jKmPu56QIfymzzhsfMl8vS665J7yAeiC1VROpmI4FitCjAC3
 80lHucYJ3kZaARGXvA5qxv1f8jm4lDlYx/yvmjVKFjGXIM8LZ2Jri9Pd2XLG4JhI0nwI
 w6PPprtgA+HHgxZCH+UcZ3ys7x2hZTu9uNUfLQtXIGQl2IFbHO/mRELHZ27tDZbQujr2
 9vmKCHP8IcZZVGIbGluhdDMDtyqQYWAuTzH6xbVv5HJyQhHTYnlu8Edfy5QV4RwIrcOT
 hP+7pB9N5DmtfK4N/52z0wMzf2yoh6SJbA33ttMISl9FPdRGlNac3VD7YcmfE8HpATO4
 9KYA==
X-Gm-Message-State: AOJu0YyopfiP7NBUrgJVmtmgybjqFcydF2Cf9WK7eIA4ic3lDyVKf64U
 8592feysa19fPqMWEqqtvr5vBPPNDN2GzA3B6q88lxBhMeUowh5zJQ4TLH/LtBw4odlaP/GHTXw
 w/BQH7g==
X-Google-Smtp-Source: AGHT+IF/l+Y3r9Pnv3+hey2qsCouu/0RVLQBA4IOhlX62wnGGQE7JxgM5y6pC4+xQdnWh0KGVqSglg==
X-Received: by 2002:a05:600c:1d10:b0:42f:8515:e482 with SMTP id
 5b1f17b1804b1-4314a2b5a03mr25901305e9.9.1729072632020; 
 Wed, 16 Oct 2024 02:57:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1ebfsm45236335e9.34.2024.10.16.02.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:57:11 -0700 (PDT)
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
 Gabor Juhos <j4g8y7@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v13 02/21] sandbox: add dummy driver ETH_SANDBOX_LWIP
Date: Wed, 16 Oct 2024 11:56:24 +0200
Message-Id: <ddff2e4fb7956e6c078a93c3dfcdce87811e4b56.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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
index 403d7e1c679..88ef674cd73 100644
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

