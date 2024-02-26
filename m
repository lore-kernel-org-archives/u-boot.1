Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC99C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDC787F6F;
	Mon, 26 Feb 2024 22:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DHtZwnkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D795C87F5C; Mon, 26 Feb 2024 22:19:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93FA187F52
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUha059005;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=o0dluad7Nnpiz6rAsljo1QLJEiG1FU+yrdkiixWt1hI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=DHtZwnkLeL3R7Kin6QxXwGX8QZ54mTc5AzVtt/Gf8n/NYG63AIZ/N0WlMu8dBl8Dz
 4ilXGZ4L/b74azg+9m24aVk9IfrCQDflWv4yeoujOOfbOljWXt3paUNbGihSE3ugCN
 pOO7WsCGGJFTnER1SeA7J85ryJyWLcyc9rmgrQp0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUiQ030246
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:30 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUbR034720;
 Mon, 26 Feb 2024 15:19:30 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:15 -0600
Subject: [PATCH v3 09/13] dma: ti: k3-udma: Add DMA PSIL mappings for AM62P
 and J722S
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-9-04cbb42eaa6f@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10815; i=bb@ti.com;
 h=from:subject:message-id; bh=sgjm3whglhxTlhtqWWKN81VKD4y6U8q26hrpktxdpiY=;
 b=owNCWmg5MUFZJlNZw3KuUQAAb3////957/0/Ll6+m26t9/tf/eo+/v8cP99RRtm/+v5P7newA
 RmaiHqNANDR6gAGgNADTQZDQbUDQxAYgGRkaAAAA9QGgZAaDJpoxDCaD1NM2qHIAwgNGTQaAANG
 TRkZMgBoGgNAANGmRhGymjTTQBpo0aBppoDQDQPU0yPQnqGUNqMjEZNBk0BoNNDT1Bo0yNNMhka
 BkDTTamENNABoAxA0GQDQaADTQYQ0DQAINSGMbgVglaCPfDRZDnNTpH6Oy0uMLXrU8PCqicUB8F
 jHy7gXrgCyf8rtiQz/clRDQif6hz1vk/HQqL2TO69KZjXlLiJsslUPXIchdG5Mz39F/zZxvwPbZ
 95eUxu1tDOCvTB6JdohNsHceX4FCN9wLlP9ostZ1KlrKQAHLAmkIuD4ivqV+FRBxqw+/XikQjAF
 ucbJGYQGgPGBcLFS4iFdKdatWSV/5w7r2121cxB3hUl4d8oAgE/sRXsNosdu1VFLAMXdJ9sNgsW
 AntpKENkpDVvQMk4ucdmLAL2DE1lWr9MGh3RoQWPd37NaIfP6aCJXTPKAMB9Mrzw9IhPY6MdON0
 MHQf0M6UfnyUyP0XnmeiNiXLKuCD12SdqON0fNU6WnAgEKthdkKdovoa5B1OG4DmbLjiuQDTPuq
 AD9C1QHV2+hT+oP8XckU4UJDDcq5RA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
 drivers/dma/ti/k3-psil-am62p.c | 325 +++++++++++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   4 +
 4 files changed, 332 insertions(+)

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
2.43.2

