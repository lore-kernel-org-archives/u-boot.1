Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F4AC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39E6877C5;
	Wed,  6 Dec 2023 13:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vXmMAdS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF0C878A2; Wed,  6 Dec 2023 13:38:58 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF6987775
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6CclhA025397;
 Wed, 6 Dec 2023 06:38:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866327;
 bh=E2zxblvTp38P53NpQsjzB+2OvdwDwPMJne15VJl1Dto=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=vXmMAdS3hgNOPJk+McdapvNaNZndl3zrKyUIqP/4mQPPYyQe5qeVs2M2UW0trmjuy
 So9qmMk4Q42HDuo8U6qvsQ8hjxz7+8aIENnyrlboo7wllkcwPuO44pn6qwBP7I3lV8
 2PQUq9IKUjWTCFa+tBeG7Ks6pM7PROxw+6YZQm2E=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6CclfI041675
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:38:47 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:38:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:38:47 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqi096939;
 Wed, 6 Dec 2023 06:38:40 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v6 07/17] drivers: dma: Add support for J784S4 SoC
Date: Wed, 6 Dec 2023 18:07:43 +0530
Message-ID: <20231206123753.1486031-8-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
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

Add support for DMA in J784S4 SoC.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/dma/ti/Makefile               |   1 +
 drivers/dma/ti/k3-psil-j784s4.c       | 166 ++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h         |   1 +
 drivers/dma/ti/k3-psil.c              |   2 +
 drivers/firmware/ti_sci_static_data.h |  34 ++++++
 drivers/ram/Kconfig                   |   2 +-
 6 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index f4e0271efb..9e0b13e8c0 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -9,3 +9,4 @@ k3-psil-data-$(CONFIG_SOC_K3_J721S2) += k3-psil-j721s2.o
 k3-psil-data-$(CONFIG_SOC_K3_AM642) += k3-psil-am64.o
 k3-psil-data-$(CONFIG_SOC_K3_AM625) += k3-psil-am62.o
 k3-psil-data-$(CONFIG_SOC_K3_AM62A7) += k3-psil-am62a.o
+k3-psil-data-$(CONFIG_SOC_K3_J784S4) += k3-psil-j784s4.o
diff --git a/drivers/dma/ti/k3-psil-j784s4.c b/drivers/dma/ti/k3-psil-j784s4.c
new file mode 100644
index 0000000000..7f06a1f307
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-j784s4.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com
+ */
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+		},					\
+	}
+
+#define PSIL_PDMA_XY_PKT(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pkt_mode = 1,			\
+		},					\
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
+#define PSIL_ETHERNET(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+			.pkt_mode = 1,			\
+			.needs_epib = 1,		\
+			.psd_size = 16,			\
+		},					\
+	}
+
+#define PSIL_SA2UL(x, tx)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+			.pkt_mode = 1,			\
+			.needs_epib = 1,		\
+			.psd_size = 64,			\
+			.notdpkt = tx,			\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep j784s4_src_ep_map[] = {
+	/* PDMA_MCASP - McASP0-4 */
+	PSIL_PDMA_MCASP(0x4400),
+	PSIL_PDMA_MCASP(0x4401),
+	PSIL_PDMA_MCASP(0x4402),
+	PSIL_PDMA_MCASP(0x4403),
+	PSIL_PDMA_MCASP(0x4404),
+	/* PDMA_SPI_G0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0x4600),
+	PSIL_PDMA_XY_PKT(0x4601),
+	PSIL_PDMA_XY_PKT(0x4602),
+	PSIL_PDMA_XY_PKT(0x4603),
+	PSIL_PDMA_XY_PKT(0x4604),
+	PSIL_PDMA_XY_PKT(0x4605),
+	PSIL_PDMA_XY_PKT(0x4606),
+	PSIL_PDMA_XY_PKT(0x4607),
+	PSIL_PDMA_XY_PKT(0x4608),
+	PSIL_PDMA_XY_PKT(0x4609),
+	PSIL_PDMA_XY_PKT(0x460a),
+	PSIL_PDMA_XY_PKT(0x460b),
+	PSIL_PDMA_XY_PKT(0x460c),
+	PSIL_PDMA_XY_PKT(0x460d),
+	PSIL_PDMA_XY_PKT(0x460e),
+	PSIL_PDMA_XY_PKT(0x460f),
+	/* PDMA_SPI_G1 - SPI4-7 */
+	PSIL_PDMA_XY_PKT(0x4610),
+	PSIL_PDMA_XY_PKT(0x4611),
+	PSIL_PDMA_XY_PKT(0x4612),
+	PSIL_PDMA_XY_PKT(0x4613),
+	PSIL_PDMA_XY_PKT(0x4614),
+	PSIL_PDMA_XY_PKT(0x4615),
+	PSIL_PDMA_XY_PKT(0x4616),
+	PSIL_PDMA_XY_PKT(0x4617),
+	PSIL_PDMA_XY_PKT(0x4618),
+	PSIL_PDMA_XY_PKT(0x4619),
+	PSIL_PDMA_XY_PKT(0x461a),
+	PSIL_PDMA_XY_PKT(0x461b),
+	PSIL_PDMA_XY_PKT(0x461c),
+	PSIL_PDMA_XY_PKT(0x461d),
+	PSIL_PDMA_XY_PKT(0x461e),
+	PSIL_PDMA_XY_PKT(0x461f),
+	/* PDMA_USART_G0 - UART0-1 */
+	PSIL_PDMA_XY_PKT(0x4700),
+	PSIL_PDMA_XY_PKT(0x4701),
+	/* PDMA_USART_G1 - UART2-3 */
+	PSIL_PDMA_XY_PKT(0x4702),
+	PSIL_PDMA_XY_PKT(0x4703),
+	/* PDMA_USART_G2 - UART4-9 */
+	PSIL_PDMA_XY_PKT(0x4704),
+	PSIL_PDMA_XY_PKT(0x4705),
+	PSIL_PDMA_XY_PKT(0x4706),
+	PSIL_PDMA_XY_PKT(0x4707),
+	PSIL_PDMA_XY_PKT(0x4708),
+	PSIL_PDMA_XY_PKT(0x4709),
+	/* CPSW0 */
+	PSIL_ETHERNET(0x7000),
+	/* MCU_PDMA0 (MCU_PDMA_MISC_G0) - SPI0 */
+	PSIL_PDMA_XY_PKT(0x7100),
+	PSIL_PDMA_XY_PKT(0x7101),
+	PSIL_PDMA_XY_PKT(0x7102),
+	PSIL_PDMA_XY_PKT(0x7103),
+	/* MCU_PDMA1 (MCU_PDMA_MISC_G1) - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0x7200),
+	PSIL_PDMA_XY_PKT(0x7201),
+	PSIL_PDMA_XY_PKT(0x7202),
+	PSIL_PDMA_XY_PKT(0x7203),
+	PSIL_PDMA_XY_PKT(0x7204),
+	PSIL_PDMA_XY_PKT(0x7205),
+	PSIL_PDMA_XY_PKT(0x7206),
+	PSIL_PDMA_XY_PKT(0x7207),
+	/* MCU_PDMA2 (MCU_PDMA_MISC_G2) - UART0 */
+	PSIL_PDMA_XY_PKT(0x7300),
+	/* MCU_PDMA_ADC - ADC0-1 */
+	PSIL_PDMA_XY_TR(0x7400),
+	PSIL_PDMA_XY_TR(0x7401),
+	PSIL_PDMA_XY_TR(0x7402),
+	PSIL_PDMA_XY_TR(0x7403),
+	/* SA2UL */
+	PSIL_SA2UL(0x7500, 0),
+	PSIL_SA2UL(0x7501, 0),
+	PSIL_SA2UL(0x7502, 0),
+	PSIL_SA2UL(0x7503, 0),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep j784s4_dst_ep_map[] = {
+	/* CPSW0 */
+	PSIL_ETHERNET(0xf000),
+	PSIL_ETHERNET(0xf001),
+	PSIL_ETHERNET(0xf002),
+	PSIL_ETHERNET(0xf003),
+	PSIL_ETHERNET(0xf004),
+	PSIL_ETHERNET(0xf005),
+	PSIL_ETHERNET(0xf006),
+	PSIL_ETHERNET(0xf007),
+	/* SA2UL */
+	PSIL_SA2UL(0xf500, 1),
+	PSIL_SA2UL(0xf501, 1),
+};
+
+struct psil_ep_map j784s4_ep_map = {
+	.name = "j784s4",
+	.src = j784s4_src_ep_map,
+	.src_count = ARRAY_SIZE(j784s4_src_ep_map),
+	.dst = j784s4_dst_ep_map,
+	.dst_count = ARRAY_SIZE(j784s4_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index 83f873b84c..02ea1e9ed3 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -43,5 +43,6 @@ extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
+extern struct psil_ep_map j784s4_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index d4d4fede8f..d21ef193e8 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -28,6 +28,8 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 			soc_ep_map = &am62_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_AM62A7))
 			soc_ep_map = &am62a_ep_map;
+		else if (IS_ENABLED(CONFIG_SOC_K3_J784S4))
+			soc_ep_map = &j784s4_ep_map;
 	}
 
 	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 567ce8911a..789f0c6b2d 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -97,6 +97,40 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 };
 #endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
 
+#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
+static struct ti_sci_resource_static_data rm_static_data[] = {
+	/* Free rings */
+	{
+		.dev_id = 328,
+		.subtype = 1,
+		.range_start = 208,
+		.range_num = 32,
+	},
+	/* TX channels */
+	{
+		.dev_id = 329,
+		.subtype = 13,
+		.range_start = 40,
+		.range_num = 3,
+	},
+	/* RX channels */
+	{
+		.dev_id = 329,
+		.subtype = 10,
+		.range_start = 40,
+		.range_num = 3,
+	},
+	/* RX Free flows */
+	{
+		.dev_id = 329,
+		.subtype = 0,
+		.range_start = 84,
+		.range_num = 8,
+	},
+	{ },
+};
+#endif /* CONFIG_SOC_K3_J784S4 */
+
 #else
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	{ },
diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 5b07e92030..8e9e53cbb0 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -62,7 +62,7 @@ choice
 	depends on K3_DDRSS
 	prompt "K3 DDRSS Arch Support"
 
-	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2
+	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
 	default K3_AM62A_DDRSS if SOC_K3_AM62A7
-- 
2.34.1

