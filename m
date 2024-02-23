Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6C5C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C709887E0C;
	Fri, 23 Feb 2024 21:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B/naBxYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EB387BAE; Fri, 23 Feb 2024 21:24:01 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7515487BC9
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 21:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NKNNcR123809;
 Fri, 23 Feb 2024 14:23:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708719803;
 bh=c3645eorOQZmiP2iXzDJvPrz1zFANgaYvuqObI7e+Yg=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=B/naBxYHVQCuoqZONXIkIePSgzX9+nVL7ieOuJZnLK6WnqDuEPotGvtN+W99ZaMzz
 /dPsmoVE8CwGq8lezbXZ8mUlAyCx9ZT0rNRRHzYlTZIVA5eae1zxh3cqTDADPZzmYE
 WVZx5R0IYrXWdnOGR2ITdLrxU5HBR/5P6Q6P+Apg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NKNNUL037755
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 14:23:23 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 14:23:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 14:23:23 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NKLsQg104070; 
 Fri, 23 Feb 2024 14:23:12 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, Bryan
 Brattlof <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Bhavya Kapoor <b-kapoor@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jayesh Choudhary <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v10 07/15] drivers: dma: Add support for J784S4 SoC
Date: Sat, 24 Feb 2024 01:51:45 +0530
Message-ID: <20240223202153.3756094-8-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223202153.3756094-1-a-nandan@ti.com>
References: <20240223202153.3756094-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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
Reviewed-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/dma/ti/Makefile               |   1 +
 drivers/dma/ti/k3-psil-j784s4.c       | 166 ++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h         |   1 +
 drivers/dma/ti/k3-psil.c              |   2 +
 drivers/firmware/ti_sci_static_data.h |  34 ++++++
 5 files changed, 204 insertions(+)
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index f4e0271efbf..9e0b13e8c02 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -9,3 +9,4 @@ k3-psil-data-$(CONFIG_SOC_K3_J721S2) += k3-psil-j721s2.o
 k3-psil-data-$(CONFIG_SOC_K3_AM642) += k3-psil-am64.o
 k3-psil-data-$(CONFIG_SOC_K3_AM625) += k3-psil-am62.o
 k3-psil-data-$(CONFIG_SOC_K3_AM62A7) += k3-psil-am62a.o
+k3-psil-data-$(CONFIG_SOC_K3_J784S4) += k3-psil-j784s4.o
diff --git a/drivers/dma/ti/k3-psil-j784s4.c b/drivers/dma/ti/k3-psil-j784s4.c
new file mode 100644
index 00000000000..7f06a1f307c
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
index 83f873b84ce..02ea1e9ed31 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -43,5 +43,6 @@ extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
+extern struct psil_ep_map j784s4_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index d4d4fede8fa..d21ef193e80 100644
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
index 567ce8911a7..789f0c6b2d9 100644
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
-- 
2.34.1

