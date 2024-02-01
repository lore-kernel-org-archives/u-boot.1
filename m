Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C572C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C7887D04;
	Thu,  1 Feb 2024 04:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RBMe3Jn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A19C87C88; Thu,  1 Feb 2024 04:06:55 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2050887CC4
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136cZO082267;
 Wed, 31 Jan 2024 21:06:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756798;
 bh=CyJJ4GPzUWNwS9wYZc48Agdqnh3LJF1aOISdqThPhac=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RBMe3Jn5DKHbZJrGqfEVL1+OB3Bo63IBbZ4fGexjOaCY7xlFt6tapWgAqfkxXSxgE
 dP/WmEtJbRpAlzdSFCPdfz/2aJnsR233Qx7j2yOJVCjCVZTt5re7USgZ9+jNYCO6Sw
 cUPL1sLEQoXlfigRKgOPYpvy5QfLT1zIqutk054U=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bQd008946
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:38 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bhX098204;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav
 Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Bryan
 Brattlof <bb@ti.com>
Subject: [PATCH v2 09/13] dma: ti: k3-udma: Add DMA PSIL mappings for AM62P
 and J722S
Date: Wed, 31 Jan 2024 21:06:45 -0600
Message-ID: <20240201030634.1120963-26-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10857; i=bb@ti.com;
 h=from:subject; bh=ZZR2jMXGyHMy24M6Hhc3O12eRTeRChyb9kuxD7NfhhQ=;
 b=owNCWmg5MUFZJlNZ7P97/AAAbf////7v770+31/x5tX/H9s/vxxvx/bsqurz9Tx+619Oue+wA
 RtqB2oADIAGgaNDRkaAaAxGgAaaPSaADQGQ0yDQABoNPQmQGjRoyNNPUaPUZhRBpoGmjQDTRoNA
 yaDRo0ZANMgBgCB6EyZMgAYh6IDIaHkgaAMgNAyAZPUHJp6gNAaDE0BkYgNGg0ZNNAaBiaaBkGE
 0ZMBAwCZGmmTQZABoANGQaNBoAALBb+MS3QEsFYhp0gMjaqhYc+fJZtnNhgWZvL+gHlyNrcixiI
 XD8AcFjW+33qXLjmUzIAJG3cyLt1XhAgfTso5RBrBKHVz9k9hvASGXkdNUZpakBmpvtD9n7OecW
 uev6nOYWDXNFalqa9QzGRZuyxG8vCm2jKnJeFcxdqIIt+50vWKVvDDKn+kn7icaQH2kQdMUJnTs
 GEqoHfaweJOyTcIPURDcWLHB48BldsxGmiEN7FFj55SNxbpGZk/3QKdbuMEzcHrjvMXYDNAgtjr
 h4UW0YNsxFbs5ESVMGUKpsgfugq4chABoRigSP0GoB4VySJukv2u9jiQ8X0XRCwMRL9KIQfApph
 BVl2QDVm6PgLBPkSUJ7o6xGHFvCAHbyWYJnttxVCtOjRahWHF6U54UYkKLejb44Bv44EV/zjXg5
 sIj3Of4u5IpwoSHZ/vf4A==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Add PSIL data for the AM62P and the J722S SoC family. The PSIL mapping
for the J722S is the same except for the extra instances of the CSI-RX.
So let's reuse the same file for both the AM62P and J722S.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
[bb@ti.com: rebased to U-Boot v2024.01]
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/dma/ti/Makefile        |   2 +
 drivers/dma/ti/k3-psil-am62p.c | 325 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   4 +
 4 files changed, 332 insertions(+)
 create mode 100644 drivers/dma/ti/k3-psil-am62p.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index f4e0271efbf32..17223b20432da 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -9,3 +9,5 @@ k3-psil-data-$(CONFIG_SOC_K3_J721S2) += k3-psil-j721s2.o
 k3-psil-data-$(CONFIG_SOC_K3_AM642) += k3-psil-am64.o
 k3-psil-data-$(CONFIG_SOC_K3_AM625) += k3-psil-am62.o
 k3-psil-data-$(CONFIG_SOC_K3_AM62A7) += k3-psil-am62a.o
+k3-psil-data-$(CONFIG_SOC_K3_AM62P5) += k3-psil-am62p.o
+k3-psil-data-$(CONFIG_SOC_K3_J722S) += k3-psil-am62p.o
diff --git a/drivers/dma/ti/k3-psil-am62p.c b/drivers/dma/ti/k3-psil-am62p.c
new file mode 100644
index 0000000000000..8739bf41b5b7c
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62p.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com
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
+static struct psil_ep am62p_src_ep_map[] = {
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
+	/* CSIRX 1-3 (only for J722S) */
+	PSIL_CSI2RX(0x5100),
+	PSIL_CSI2RX(0x5101),
+	PSIL_CSI2RX(0x5102),
+	PSIL_CSI2RX(0x5103),
+	PSIL_CSI2RX(0x5104),
+	PSIL_CSI2RX(0x5105),
+	PSIL_CSI2RX(0x5106),
+	PSIL_CSI2RX(0x5107),
+	PSIL_CSI2RX(0x5108),
+	PSIL_CSI2RX(0x5109),
+	PSIL_CSI2RX(0x510a),
+	PSIL_CSI2RX(0x510b),
+	PSIL_CSI2RX(0x510c),
+	PSIL_CSI2RX(0x510d),
+	PSIL_CSI2RX(0x510e),
+	PSIL_CSI2RX(0x510f),
+	PSIL_CSI2RX(0x5110),
+	PSIL_CSI2RX(0x5111),
+	PSIL_CSI2RX(0x5112),
+	PSIL_CSI2RX(0x5113),
+	PSIL_CSI2RX(0x5114),
+	PSIL_CSI2RX(0x5115),
+	PSIL_CSI2RX(0x5116),
+	PSIL_CSI2RX(0x5117),
+	PSIL_CSI2RX(0x5118),
+	PSIL_CSI2RX(0x5119),
+	PSIL_CSI2RX(0x511a),
+	PSIL_CSI2RX(0x511b),
+	PSIL_CSI2RX(0x511c),
+	PSIL_CSI2RX(0x511d),
+	PSIL_CSI2RX(0x511e),
+	PSIL_CSI2RX(0x511f),
+	PSIL_CSI2RX(0x5200),
+	PSIL_CSI2RX(0x5201),
+	PSIL_CSI2RX(0x5202),
+	PSIL_CSI2RX(0x5203),
+	PSIL_CSI2RX(0x5204),
+	PSIL_CSI2RX(0x5205),
+	PSIL_CSI2RX(0x5206),
+	PSIL_CSI2RX(0x5207),
+	PSIL_CSI2RX(0x5208),
+	PSIL_CSI2RX(0x5209),
+	PSIL_CSI2RX(0x520a),
+	PSIL_CSI2RX(0x520b),
+	PSIL_CSI2RX(0x520c),
+	PSIL_CSI2RX(0x520d),
+	PSIL_CSI2RX(0x520e),
+	PSIL_CSI2RX(0x520f),
+	PSIL_CSI2RX(0x5210),
+	PSIL_CSI2RX(0x5211),
+	PSIL_CSI2RX(0x5212),
+	PSIL_CSI2RX(0x5213),
+	PSIL_CSI2RX(0x5214),
+	PSIL_CSI2RX(0x5215),
+	PSIL_CSI2RX(0x5216),
+	PSIL_CSI2RX(0x5217),
+	PSIL_CSI2RX(0x5218),
+	PSIL_CSI2RX(0x5219),
+	PSIL_CSI2RX(0x521a),
+	PSIL_CSI2RX(0x521b),
+	PSIL_CSI2RX(0x521c),
+	PSIL_CSI2RX(0x521d),
+	PSIL_CSI2RX(0x521e),
+	PSIL_CSI2RX(0x521f),
+	PSIL_CSI2RX(0x5300),
+	PSIL_CSI2RX(0x5301),
+	PSIL_CSI2RX(0x5302),
+	PSIL_CSI2RX(0x5303),
+	PSIL_CSI2RX(0x5304),
+	PSIL_CSI2RX(0x5305),
+	PSIL_CSI2RX(0x5306),
+	PSIL_CSI2RX(0x5307),
+	PSIL_CSI2RX(0x5308),
+	PSIL_CSI2RX(0x5309),
+	PSIL_CSI2RX(0x530a),
+	PSIL_CSI2RX(0x530b),
+	PSIL_CSI2RX(0x530c),
+	PSIL_CSI2RX(0x530d),
+	PSIL_CSI2RX(0x530e),
+	PSIL_CSI2RX(0x530f),
+	PSIL_CSI2RX(0x5310),
+	PSIL_CSI2RX(0x5311),
+	PSIL_CSI2RX(0x5312),
+	PSIL_CSI2RX(0x5313),
+	PSIL_CSI2RX(0x5314),
+	PSIL_CSI2RX(0x5315),
+	PSIL_CSI2RX(0x5316),
+	PSIL_CSI2RX(0x5317),
+	PSIL_CSI2RX(0x5318),
+	PSIL_CSI2RX(0x5319),
+	PSIL_CSI2RX(0x531a),
+	PSIL_CSI2RX(0x531b),
+	PSIL_CSI2RX(0x531c),
+	PSIL_CSI2RX(0x531d),
+	PSIL_CSI2RX(0x531e),
+	PSIL_CSI2RX(0x531f),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62p_dst_ep_map[] = {
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
+struct psil_ep_map am62p_ep_map = {
+	.name = "am62p",
+	.src = am62p_src_ep_map,
+	.src_count = ARRAY_SIZE(am62p_src_ep_map),
+	.dst = am62p_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62p_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index 83f873b84ceb1..c357aba59d7bf 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -43,5 +43,6 @@ extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
+extern struct psil_ep_map am62p_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index d4d4fede8fa1f..ccbf196882d72 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -28,6 +28,10 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 			soc_ep_map = &am62_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_AM62A7))
 			soc_ep_map = &am62a_ep_map;
+		else if (IS_ENABLED(CONFIG_SOC_K3_AM62P5))
+			soc_ep_map = &am62p_ep_map;
+		else if (IS_ENABLED(CONFIG_SOC_K3_J722S))
+			soc_ep_map = &am62p_ep_map;
 	}
 
 	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
-- 
2.43.0

