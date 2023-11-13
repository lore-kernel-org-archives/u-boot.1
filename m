Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799B6C4167B
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF1387124;
	Mon, 13 Nov 2023 15:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F4qpXqq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5936E87116; Mon, 13 Nov 2023 15:52:05 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE4B8714F
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEpp43018990;
 Mon, 13 Nov 2023 08:51:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887111;
 bh=RdVxiwN4F8Q1ts2taoA/cxVCBB/3rWWVg8JjeXb946g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F4qpXqq3o3UfqyYFPSDIzY9erFkzlEA3ZBek8SXocwc/c+IEiOMPtze8emgTOMVGS
 hHhLwSRjGQcKl3FIzTtJymDUsdjRFZYNBM0fyk2MY35Sweoyzbi1cCvC6+MSVAZrgB
 QZAyKTYETIo9EV7oX1jcCqmy+ByLmqW0qUCiUdaI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEppLM099390
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:51:51 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:51:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:51:51 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEpppN073454;
 Mon, 13 Nov 2023 08:51:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/8] dma: ti: k3-udma: Introduce DMA support for the am62ax
Date: Mon, 13 Nov 2023 08:51:44 -0600
Message-ID: <20231113145149.1926732-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145149.1926732-1-nm@ti.com>
References: <20231113145149.1926732-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Vignesh Raghavendra <vigneshr@ti.com>

In preparation for enabling ethernet for the am62ax family of SoCs,
introduce the initial DMA channel settings for the am62ax

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[bb@ti.com: expanded on commit message]
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE: the patch has a minor checkpatch warning - but, this is inline
with rest of the implementations.

 drivers/dma/ti/Makefile        |   1 +
 drivers/dma/ti/k3-psil-am62a.c | 196 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   2 +
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/dma/ti/k3-psil-am62a.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 6807eb8e8b2d..f4e0271efbf3 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -8,3 +8,4 @@ k3-psil-data-$(CONFIG_SOC_K3_J721E) += k3-psil-j721e.o
 k3-psil-data-$(CONFIG_SOC_K3_J721S2) += k3-psil-j721s2.o
 k3-psil-data-$(CONFIG_SOC_K3_AM642) += k3-psil-am64.o
 k3-psil-data-$(CONFIG_SOC_K3_AM625) += k3-psil-am62.o
+k3-psil-data-$(CONFIG_SOC_K3_AM62A7) += k3-psil-am62a.o
diff --git a/drivers/dma/ti/k3-psil-am62a.c b/drivers/dma/ti/k3-psil-am62a.c
new file mode 100644
index 000000000000..ca9d71f91422
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62a.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = -1,		\
+			.default_flow_id = -1,			\
+		},						\
+	}
+
+#define PSIL_PDMA_XY_PKT(x)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = -1,		\
+			.default_flow_id = -1,			\
+			.pkt_mode = 1,				\
+		},						\
+	}
+
+#define PSIL_ETHERNET(x, ch, flow_base, flow_cnt)		\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 16,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = flow_base,		\
+		},						\
+	}
+
+#define PSIL_SAUL(x, ch, flow_base, flow_cnt, default_flow, tx)	\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 64,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = default_flow,	\
+			.notdpkt = tx,				\
+		},						\
+	}
+
+#define PSIL_PDMA_MCASP(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pdma_acc32 = 1,		\
+			.pdma_burst = 1,		\
+		},					\
+	}
+
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am62a_src_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0x7504, 20, 35, 8, 35, 0),
+	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
+	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
+	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
+	/* PDMA_MAIN0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0x4302),
+	PSIL_PDMA_XY_PKT(0x4303),
+	PSIL_PDMA_XY_PKT(0x4304),
+	PSIL_PDMA_XY_PKT(0x4305),
+	PSIL_PDMA_XY_PKT(0x4306),
+	PSIL_PDMA_XY_PKT(0x4307),
+	PSIL_PDMA_XY_PKT(0x4308),
+	PSIL_PDMA_XY_PKT(0x4309),
+	PSIL_PDMA_XY_PKT(0x430a),
+	PSIL_PDMA_XY_PKT(0x430b),
+	PSIL_PDMA_XY_PKT(0x430c),
+	PSIL_PDMA_XY_PKT(0x430d),
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0x4400),
+	PSIL_PDMA_XY_PKT(0x4401),
+	PSIL_PDMA_XY_PKT(0x4402),
+	PSIL_PDMA_XY_PKT(0x4403),
+	PSIL_PDMA_XY_PKT(0x4404),
+	PSIL_PDMA_XY_PKT(0x4405),
+	PSIL_PDMA_XY_PKT(0x4406),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0x4500),
+	PSIL_PDMA_MCASP(0x4501),
+	PSIL_PDMA_MCASP(0x4502),
+	/* CPSW3G */
+	PSIL_ETHERNET(0x4600, 19, 19, 16),
+	/* CSI2RX */
+	PSIL_CSI2RX(0x5000),
+	PSIL_CSI2RX(0x5001),
+	PSIL_CSI2RX(0x5002),
+	PSIL_CSI2RX(0x5003),
+	PSIL_CSI2RX(0x5004),
+	PSIL_CSI2RX(0x5005),
+	PSIL_CSI2RX(0x5006),
+	PSIL_CSI2RX(0x5007),
+	PSIL_CSI2RX(0x5008),
+	PSIL_CSI2RX(0x5009),
+	PSIL_CSI2RX(0x500a),
+	PSIL_CSI2RX(0x500b),
+	PSIL_CSI2RX(0x500c),
+	PSIL_CSI2RX(0x500d),
+	PSIL_CSI2RX(0x500e),
+	PSIL_CSI2RX(0x500f),
+	PSIL_CSI2RX(0x5010),
+	PSIL_CSI2RX(0x5011),
+	PSIL_CSI2RX(0x5012),
+	PSIL_CSI2RX(0x5013),
+	PSIL_CSI2RX(0x5014),
+	PSIL_CSI2RX(0x5015),
+	PSIL_CSI2RX(0x5016),
+	PSIL_CSI2RX(0x5017),
+	PSIL_CSI2RX(0x5018),
+	PSIL_CSI2RX(0x5019),
+	PSIL_CSI2RX(0x501a),
+	PSIL_CSI2RX(0x501b),
+	PSIL_CSI2RX(0x501c),
+	PSIL_CSI2RX(0x501d),
+	PSIL_CSI2RX(0x501e),
+	PSIL_CSI2RX(0x501f),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62a_dst_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
+	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
+	/* PDMA_MAIN0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0xc302),
+	PSIL_PDMA_XY_PKT(0xc303),
+	PSIL_PDMA_XY_PKT(0xc304),
+	PSIL_PDMA_XY_PKT(0xc305),
+	PSIL_PDMA_XY_PKT(0xc306),
+	PSIL_PDMA_XY_PKT(0xc307),
+	PSIL_PDMA_XY_PKT(0xc308),
+	PSIL_PDMA_XY_PKT(0xc309),
+	PSIL_PDMA_XY_PKT(0xc30a),
+	PSIL_PDMA_XY_PKT(0xc30b),
+	PSIL_PDMA_XY_PKT(0xc30c),
+	PSIL_PDMA_XY_PKT(0xc30d),
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0xc400),
+	PSIL_PDMA_XY_PKT(0xc401),
+	PSIL_PDMA_XY_PKT(0xc402),
+	PSIL_PDMA_XY_PKT(0xc403),
+	PSIL_PDMA_XY_PKT(0xc404),
+	PSIL_PDMA_XY_PKT(0xc405),
+	PSIL_PDMA_XY_PKT(0xc406),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0xc500),
+	PSIL_PDMA_MCASP(0xc501),
+	PSIL_PDMA_MCASP(0xc502),
+	/* CPSW3G */
+	PSIL_ETHERNET(0xc600, 19, 19, 8),
+	PSIL_ETHERNET(0xc601, 20, 27, 8),
+	PSIL_ETHERNET(0xc602, 21, 35, 8),
+	PSIL_ETHERNET(0xc603, 22, 43, 8),
+	PSIL_ETHERNET(0xc604, 23, 51, 8),
+	PSIL_ETHERNET(0xc605, 24, 59, 8),
+	PSIL_ETHERNET(0xc606, 25, 67, 8),
+	PSIL_ETHERNET(0xc607, 26, 75, 8),
+};
+
+struct psil_ep_map am62a_ep_map = {
+	.name = "am62a",
+	.src = am62a_src_ep_map,
+	.src_count = ARRAY_SIZE(am62a_src_ep_map),
+	.dst = am62a_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62a_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index 563bc57e2060..83f873b84ceb 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -42,5 +42,6 @@ extern struct psil_ep_map j721e_ep_map;
 extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map am62_ep_map;
+extern struct psil_ep_map am62a_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 963321aa1e34..d4d4fede8fa1 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -26,6 +26,8 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 			soc_ep_map = &am64_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_AM625))
 			soc_ep_map = &am62_ep_map;
+		else if (IS_ENABLED(CONFIG_SOC_K3_AM62A7))
+			soc_ep_map = &am62a_ep_map;
 	}
 
 	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
-- 
2.40.0

