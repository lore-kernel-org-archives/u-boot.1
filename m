Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05DDEA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D92E84142;
	Thu,  9 Apr 2026 15:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="Lc9UnyOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B8083936; Wed,  8 Apr 2026 21:25:10 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0486984142
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Epxg92285608; Wed, 8 Apr 2026 19:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=nM
 DILvt0ap3A/KFQE4aYICtSG4LXPBStE3zXmjv573s=; b=Lc9UnyOd1xCaNiotJN
 Gxrgkss2/SzitoDdmD40s4m0mXcTmU/kIPfH8MI18iK53zCupTnOOawhflnp7xO1
 s+DZXATs7KxhloEtf4sYFNbGXKgV4uHKQd8US0ZxLyDwQpr7Ihpb02T0yhNZnXTr
 ZkQEzhvspLzIqIPDYgteSCPi9Ibbbjtv/v4pMGoLmRkKbNVSySUS4sWpVa+LpBkY
 bMOhuiFxwplNAixUzF07FAXyxtMkxLg309f5B/1jAwY1bH5NvMk2Ik24QW/Nt1kt
 ZkQSMZnNWOIoUvUY3PnexeixNW2aMc5gtBP9PS66PR0DlWzHcyYJPSkYUzXDfbGO
 SryQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dds5cb879-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:25 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5467680173A;
 Wed,  8 Apr 2026 19:24:25 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2BE5C8104BF;
 Wed,  8 Apr 2026 19:24:24 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:19 +0000
Subject: [PATCH 7/9] board: hpe: Add GSC board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-7-2be1fb7cbbfc@hpe.com>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jorge Cisneros <jorge.cisneros@hpe.com>
X-Mailer: b4 0.15.1
X-Proofpoint-ORIG-GUID: RuVtBhODG7VE1fZIfz9BZPXRAvXqHHz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX4e5yzxLH7VO9
 hU0Eevy4gC2HzLtBXy6lTlWmuSrZJQ1FWxmw2jDclGuD6ec6JVF/GQuDQmTx7+XmchdbBDMsmB1
 raRm5OmR+ifjUWYfUj6Im+qvvkXnIvLTazSxLzy2GcbukTr3979tWEWUeROUeoPIhNowdMButmo
 1aSAuSaBfj+Fu1HsMQ7PUrTZ92CSOkTUDUGm6DnDUgXO+q9VuIh2enHDYr+DOsSvD0Xi42RKKIg
 fWfvTvsO5yIQhXAMnGjU/ryE8VOBVpCQyZ367x+7W6WddWCSXsaClKbiWboMhPeVEhAmcEIen9r
 6br1p7yAIXbVRAJZ3lagAtKKMzj/PN9UiRsxR4KzIjRbn21HCt1fy+2xhyo9n9VaW9SnClDzLbY
 xcY1HzpFtLrbahoemv/5W11ALdWcOTl318njlQAVpEapePXusbHhgIuYUz28uHASEOPzxGILgew
 kEIGG1OsLbwBxuqBRzw==
X-Proofpoint-GUID: RuVtBhODG7VE1fZIfz9BZPXRAvXqHHz3
X-Authority-Analysis: v=2.4 cv=S9HpBosP c=1 sm=1 tr=0 ts=69d6ab69 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8
 a=a6TSiJCG5VpFgIC85-cA:9 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080181
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

Add board support for the HPE GSC (Gen Server Controller), the BMC
SoC used in HPE Gen12 ProLiant and Synergy servers.

Board files include:
- gsc_board.c: Board init, DRAM sizing from Denali memory controller,
  MAC address provisioning from memory-mapped EEPROM, and FDT fixups
  for network configuration based on CPLD xregisters
- common-phy.c: Shared Ethernet/DisplayPort PHY initialization with
  configurable transmitter amplitude and de-emphasis
- server_id.c: Custom command to read server identification from CPLD
- gsc.env: Default SPI flash boot environment
- gsc.h: Board configuration header with GICv3 and spin-table addresses

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 board/hpe/gsc/Makefile                       |   3 +
 board/hpe/gsc/common-phy-wrapper-addresses.h |  86 +++++
 board/hpe/gsc/common-phy.c                   | 296 +++++++++++++++
 board/hpe/gsc/common-phy.h                   |   8 +
 board/hpe/gsc/gsc.env                        |   9 +
 board/hpe/gsc/gsc_board.c                    | 538 +++++++++++++++++++++++++++
 board/hpe/gsc/server_id.c                    |  51 +++
 include/configs/gsc.h                        |  25 ++
 8 files changed, 1016 insertions(+)

diff --git a/board/hpe/gsc/Makefile b/board/hpe/gsc/Makefile
new file mode 100644
index 00000000000..bc14c9d3bbf
--- /dev/null
+++ b/board/hpe/gsc/Makefile
@@ -0,0 +1,3 @@
+obj-y += gsc_board.o
+obj-y += common-phy.o
+obj-y += server_id.o
diff --git a/board/hpe/gsc/common-phy-wrapper-addresses.h b/board/hpe/gsc/common-phy-wrapper-addresses.h
new file mode 100644
index 00000000000..50bacd756f2
--- /dev/null
+++ b/board/hpe/gsc/common-phy-wrapper-addresses.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2022-2025 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#ifndef _COMMON_PHY_WRAPPER_ADDRESSES_H
+#define _COMMON_PHY_WRAPPER_ADDRESSES_H
+
+#define kWRAP_CDB_ENABLE		0x8018
+#define kWRAP_CDB_BUSSEL		0x801c
+#define kWRAP_CDB_ACC_OK		0x8020
+#define kWRAP_CDB_REG_INIT_END		0x8024
+
+#define kWRAP_PHY_REFCLK_ACTIVE		0x803c
+#define kWRAP_PHY_CONFIG_RSTN		0x8040
+#define kWRAP_PHY_CMN_READY		0x8044
+#define kWRAP_PHY_LANE_EN_BITS		0x8048
+#define kWRAP_PHY_LANE_RSTN_BITS	0x804c
+
+#define kWRAP_PHY_PLL0_ENABLE		0x8050
+#define kWRAP_PHY_PLL0_STATUS		0x8054
+
+#define kWRAP_PHY_PLL1_ENABLE		0x8058
+#define kWRAP_PHY_PLL1_STATUS		0x805c
+
+#define kWRAP_PHY_DP_LANE_MODE		0x8060
+#define kWRAP_PHY_DP_LANESET_READY	0x8064
+#define kWRAP_LANE_ELEC_IDLE_BITS	0x8070
+#define kWRAP_DP_DUAL_MODE_ENABLE	0x8074
+#define kWRAP_PHY_DP_LINK_RATE		0x8078
+#define kWRAP_DISABLE_AUTO_RXLINK	0x807c
+
+#define kWRAP_TX_DEEMPH_LANE0		0x8080
+#define kWRAP_TX_DEEMPH_LANE1		0x8084
+#define kWRAP_TX_DEEMPH_LANE2		0x8088
+#define kWRAP_TX_DEEMPH_LANE3		0x808c
+
+#define kWRAP_TX_VMARGIN_LANE0		0x8090
+#define kWRAP_TX_VMARGIN_LANE1		0x8094
+#define kWRAP_TX_VMARGIN_LANE2		0x8098
+#define kWRAP_TX_VMARGIN_LANE3		0x809c
+
+#define kWRAP_XCVR_PLLCLK0_ENABLE	0x80a0
+#define kWRAP_XCVR_PLLCLK1_ENABLE	0x80a4
+#define kWRAP_XCVR_PLLCLK2_ENABLE	0x80a8
+#define kWRAP_XCVR_PLLCLK3_ENABLE	0x80ac
+
+#define kWRAP_XCVR_PLLCLK0_EN_ACK	0x80b0
+#define kWRAP_XCVR_PLLCLK1_EN_ACK	0x80b4
+#define kWRAP_XCVR_PLLCLK2_EN_ACK	0x80b8
+#define kWRAP_XCVR_PLLCLK3_EN_ACK	0x80bc
+
+#define kWRAP_XCVR_RATE_CHNG0_REQ	0x80c0
+#define kWRAP_XCVR_RATE_CHNG1_REQ	0x80c4
+#define kWRAP_XCVR_RATE_CHNG2_REQ	0x80c8
+#define kWRAP_XCVR_RATE_CHNG3_REQ	0x80cc
+
+#define kWRAP_XCVR_RATE_CHNG0_ACK	0x80d0
+#define kWRAP_XCVR_RATE_CHNG1_ACK	0x80d4
+#define kWRAP_XCVR_RATE_CHNG2_ACK	0x80d8
+#define kWRAP_XCVR_RATE_CHNG3_ACK	0x80dc
+
+#define kWRAP_XCVR_MODE_LANE0		0x80e0
+#define kWRAP_XCVR_MODE_LANE1		0x80e4
+#define kWRAP_XCVR_MODE_LANE2		0x80e8
+#define kWRAP_XCVR_MODE_LANE3		0x80ec
+
+#define kWRAP_PHY_RX_DATA_ENABLE	0x80f0
+#define kWRAP_PHY_TX_DATA_ENABLE	0x80f4
+
+#define kWRAP_PHY_XCVR0_SCANIN0	0x8100
+#define kWRAP_PHY_XCVR0_SCANIN1	0x8104
+#define kWRAP_PHY_XCVR1_SCANIN0	0x8108
+#define kWRAP_PHY_XCVR1_SCANIN1	0x810c
+#define kWRAP_PHY_XCVR2_SCANIN0	0x8110
+#define kWRAP_PHY_XCVR2_SCANIN1	0x8114
+#define kWRAP_PHY_XCVR3_SCANIN0	0x8118
+#define kWRAP_PHY_XCVR3_SCANIN1	0x811c
+#define kWRAP_PHY_XCVR0_SCANOUT0	0x8120
+#define kWRAP_PHY_XCVR0_SCANOUT1	0x8124
+#define kWRAP_PHY_XCVR1_SCANOUT0	0x8128
+#define kWRAP_PHY_XCVR1_SCANOUT1	0x812c
+#define kWRAP_PHY_XCVR2_SCANOUT0	0x8130
+#define kWRAP_PHY_XCVR2_SCANOUT1	0x8134
+#define kWRAP_PHY_XCVR3_SCANOUT0	0x8138
+#define kWRAP_PHY_XCVR3_SCANOUT1	0x813c
+
+#endif /* _COMMON_PHY_WRAPPER_ADDRESSES_H */
diff --git a/board/hpe/gsc/common-phy.c b/board/hpe/gsc/common-phy.c
new file mode 100644
index 00000000000..c39653727e9
--- /dev/null
+++ b/board/hpe/gsc/common-phy.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2022-2025 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <dm.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+
+#include "common-phy-wrapper-addresses.h"
+
+#define DP_TX_BASE			0xc0020000
+#define PHY_PIP_CONFIG_REG_INDEX_ADDR	0x0FC0
+#define PHY_PIP_CONFIG_REG_DATA_ADDR	0x0FC4
+
+/*
+ * Xreg 0x39 Layout - Transmitter Amplitude
+ *
+ * Bits | Desc
+ *  7   | Secondary Transmitter Disable
+ * 6:4  | Secondary Transmitter Amplitude
+ *  3   | Primary Transmitter Disable
+ * 2:0  | Primary Transmitter Amplitude
+ */
+#define V_AMPLT_400		0x4
+#define V_AMPLT_600		0x5
+#define V_AMPLT_800		0x6
+#define V_AMPLT_945		0x7
+
+/* Xreg 0x38 De-emphasis Levels */
+#define DE_EMPH_0		0x0
+#define DE_EMPH_1		0x1
+#define DE_EMPH_2		0x2
+#define DE_EMPH_3		0x3
+
+/* Xreg Mask and Shift */
+#define V_AMPLT_MASK			0x7
+#define DE_EMPH_MASK			0x3
+#define DISABLE_MASK			0x8
+#define SECONDARY_SHIFT_V_AMPLT		0x4
+#define SECONDARY_SHIFT_DE_EMPH		0x2
+
+static void common_phy_register_write(unsigned int reg, unsigned int data)
+{
+	writel(reg, DP_TX_BASE + PHY_PIP_CONFIG_REG_INDEX_ADDR);
+	writel(data, DP_TX_BASE + PHY_PIP_CONFIG_REG_DATA_ADDR);
+}
+
+static void common_phy_register_read(unsigned int reg, unsigned int *data)
+{
+	writel(reg, DP_TX_BASE + PHY_PIP_CONFIG_REG_INDEX_ADDR);
+	*data = readl(DP_TX_BASE + PHY_PIP_CONFIG_REG_DATA_ADDR);
+}
+
+static int poll_register(unsigned int reg, int value)
+{
+	unsigned int data = 0;
+	int retry_cnt = 20;
+
+	while (retry_cnt > 0) {
+		common_phy_register_read(reg, &data);
+		if (data == value)
+			return 0;
+		mdelay(1);
+		retry_cnt--;
+	}
+
+	pr_err("CommonPhy: polling failed: reg=0x%x expected=0x%x got=0x%x\n",
+	       reg, value, data);
+	return -1;
+}
+
+static void common_phy_get_deemph_and_vamplitude(unsigned int amplt,
+						  unsigned int emph,
+						  unsigned int *reg_amplt,
+						  unsigned int *reg_emph)
+{
+	/* Default: 400 mV, de-emphasis level 0 */
+	*reg_amplt = 0x00040404;
+	*reg_emph = 0x00000000;
+
+	if (emph > DE_EMPH_3) {
+		pr_err("CommonPhy: invalid config: amplitude 0x%x, de-emph 0x%x\n",
+		       amplt, emph);
+		return;
+	}
+
+	if (amplt == V_AMPLT_400) {
+		if (emph == DE_EMPH_0) {
+			*reg_amplt = 0x00040404;
+			*reg_emph = 0x00000000;
+		} else if (emph == DE_EMPH_1) {
+			*reg_amplt = 0x00030303;
+			*reg_emph = 0x00030404;
+		} else if (emph == DE_EMPH_2) {
+			*reg_amplt = 0x00010101;
+			*reg_emph = 0x00050606;
+		} else if (emph == DE_EMPH_3) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00060606;
+		}
+	} else if (amplt == V_AMPLT_600) {
+		if (emph == DE_EMPH_0) {
+			*reg_amplt = 0x00030303;
+			*reg_emph = 0x00000000;
+		} else if (emph == DE_EMPH_1) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00030404;
+		} else if (emph == DE_EMPH_2) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00050606;
+		} else if (emph == DE_EMPH_3) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00060606;
+		}
+	} else if (amplt == V_AMPLT_800) {
+		if (emph == DE_EMPH_0) {
+			*reg_amplt = 0x00040404;
+			*reg_emph = 0x00010101;
+		} else if (emph == DE_EMPH_1) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00030404;
+		} else if (emph == DE_EMPH_2) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00050606;
+		} else if (emph == DE_EMPH_3) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00060606;
+		}
+	} else if (amplt == V_AMPLT_945) {
+		if (emph == DE_EMPH_0) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00000000;
+		} else if (emph == DE_EMPH_1) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00030404;
+		} else if (emph == DE_EMPH_2) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00050606;
+		} else if (emph == DE_EMPH_3) {
+			*reg_amplt = 0x00000000;
+			*reg_emph = 0x00060606;
+		}
+	} else {
+		pr_err("CommonPhy: invalid config: amplitude 0x%x, de-emph 0x%x\n",
+		       amplt, emph);
+	}
+}
+
+/*
+ * Power On Initialization of Common PHY.
+ * Configures the shared PHY for Ethernet and Display Port operation.
+ */
+int common_phy_poweron_init(void)
+{
+	unsigned int xreg_amplt, xreg_emph, emph, amplt;
+	unsigned int rstn_bits = 0x0F;
+
+	/* 1. Clear registers to default un-initialized state */
+	common_phy_register_write(kWRAP_PHY_RX_DATA_ENABLE, 0x00);
+	common_phy_register_write(kWRAP_PHY_TX_DATA_ENABLE, 0x00);
+	common_phy_register_write(kWRAP_PHY_LANE_RSTN_BITS, 0x00);
+	common_phy_register_write(kWRAP_PHY_LANE_EN_BITS, 0x00);
+	common_phy_register_write(kWRAP_PHY_CONFIG_RSTN, 0x00);
+	common_phy_register_write(kWRAP_LANE_ELEC_IDLE_BITS, 0x0F);
+	common_phy_register_write(kWRAP_PHY_PLL0_ENABLE, 0x00);
+	common_phy_register_write(kWRAP_PHY_PLL1_ENABLE, 0x00);
+	common_phy_register_write(kWRAP_CDB_BUSSEL, 0x00);
+	common_phy_register_write(kWRAP_CDB_REG_INIT_END, 0x00);
+	common_phy_register_write(kWRAP_PHY_DP_LANE_MODE, 0x00);
+	common_phy_register_write(kWRAP_DISABLE_AUTO_RXLINK, 0x01);
+	common_phy_register_write(kWRAP_XCVR_MODE_LANE0, 0x00);
+	common_phy_register_write(kWRAP_XCVR_MODE_LANE1, 0x00);
+	common_phy_register_write(kWRAP_XCVR_MODE_LANE2, 0x00);
+	common_phy_register_write(kWRAP_XCVR_MODE_LANE3, 0x00);
+
+	/* 2. Release PHY lanes out of reset */
+	common_phy_register_write(kWRAP_PHY_CONFIG_RSTN, 0x01);
+
+	/* 3. Poll for internal initialization completion */
+	if (poll_register(kWRAP_CDB_ACC_OK, 0x01) != 0) {
+		pr_err("CommonPhy: kWRAP_CDB_ACC_OK polling failed\n");
+		return -1;
+	}
+
+	/* 4. Additional PHY register modifications */
+	common_phy_register_write(kWRAP_CDB_BUSSEL, 0x01);
+	common_phy_register_write(kWRAP_CDB_ENABLE, 0x01);
+
+	/* Set DP lanes for Dual Mode */
+	common_phy_register_write(0x4021, 0x00);
+	common_phy_register_write(0x4221, 0x00);
+
+	/* RX Lane Fixes B0 */
+	common_phy_register_write(0x4026, 0x124A);
+	common_phy_register_write(0x4226, 0x124A);
+	common_phy_register_write(0x4226, 0x124A);
+	common_phy_register_write(0x4626, 0x124A);
+
+	common_phy_register_write(kWRAP_CDB_BUSSEL, 0x00);
+	common_phy_register_write(kWRAP_CDB_ENABLE, 0x00);
+
+	/* 5. Set PHY initialization complete */
+	common_phy_register_write(kWRAP_CDB_REG_INIT_END, 0x01);
+
+	/* 6. Enable PLL 0 and PLL 1 */
+	common_phy_register_write(kWRAP_PHY_PLL0_ENABLE, 0x01);
+	common_phy_register_write(kWRAP_PHY_PLL1_ENABLE, 0x01);
+
+	/* 7. Program vswing/pre-emphasis for DP lanes 0 and 1 */
+	common_phy_register_write(kWRAP_TX_VMARGIN_LANE0, 0x00040404);
+	common_phy_register_write(kWRAP_TX_VMARGIN_LANE1, 0x00040404);
+	common_phy_register_write(kWRAP_TX_DEEMPH_LANE0, 0x00000000);
+	common_phy_register_write(kWRAP_TX_DEEMPH_LANE1, 0x00000000);
+
+	/* 8. Program vswing/pre-emphasis for Ethernet lanes 2 and 3 */
+	xreg_amplt = readb(0xd1000039);
+	xreg_emph = readb(0xd1000038);
+
+	debug("CommonPhy: amplitude=0x%x de-emph=0x%x\n",
+	      xreg_amplt, xreg_emph);
+
+	/* Primary transmitter */
+	if ((xreg_amplt & DISABLE_MASK) == 0) {
+		debug("CommonPhy: configuring primary transmitter\n");
+		common_phy_get_deemph_and_vamplitude(
+			xreg_amplt & V_AMPLT_MASK,
+			xreg_emph & DE_EMPH_MASK,
+			&amplt, &emph);
+		common_phy_register_write(kWRAP_TX_VMARGIN_LANE2, amplt);
+		common_phy_register_write(kWRAP_TX_DEEMPH_LANE2, emph);
+	} else {
+		debug("CommonPhy: primary transmitter disabled\n");
+		rstn_bits &= 0x0B;
+	}
+
+	/* Secondary transmitter */
+	if (((xreg_amplt >> SECONDARY_SHIFT_V_AMPLT) & DISABLE_MASK) == 0) {
+		debug("CommonPhy: configuring secondary transmitter\n");
+		common_phy_get_deemph_and_vamplitude(
+			(xreg_amplt >> SECONDARY_SHIFT_V_AMPLT) & V_AMPLT_MASK,
+			(xreg_emph >> SECONDARY_SHIFT_DE_EMPH) & DE_EMPH_MASK,
+			&amplt, &emph);
+		common_phy_register_write(kWRAP_TX_VMARGIN_LANE3, amplt);
+		common_phy_register_write(kWRAP_TX_DEEMPH_LANE3, emph);
+	} else {
+		debug("CommonPhy: secondary transmitter disabled\n");
+		rstn_bits &= 0x07;
+	}
+
+	/* 9. Take lanes out of Electrical Idle */
+	common_phy_register_write(kWRAP_LANE_ELEC_IDLE_BITS, 0x0);
+
+	/* 10. Enable PLL Clocks */
+	common_phy_register_write(kWRAP_XCVR_PLLCLK0_ENABLE, 0x01);
+	common_phy_register_write(kWRAP_XCVR_PLLCLK2_ENABLE, 0x01);
+	common_phy_register_write(kWRAP_XCVR_PLLCLK3_ENABLE, 0x01);
+
+	/* 11. Release lane resets */
+	common_phy_register_write(kWRAP_PHY_LANE_RSTN_BITS, rstn_bits);
+
+	/* 12. Enable Lanes (DisplayPort only) */
+	common_phy_register_write(kWRAP_PHY_LANE_EN_BITS, 0x0F);
+
+	/* 13. Poll for Common Ready */
+	if (poll_register(kWRAP_PHY_CMN_READY, 0x01) != 0) {
+		pr_err("CommonPhy: kWRAP_PHY_CMN_READY polling failed\n");
+		return -1;
+	}
+
+	/* 14. Poll for PLL status */
+	if (poll_register(kWRAP_XCVR_PLLCLK0_EN_ACK, 0x01) != 0) {
+		pr_err("CommonPhy: PLLCLK0_EN_ACK polling failed\n");
+		return -1;
+	}
+	if (poll_register(kWRAP_XCVR_PLLCLK1_EN_ACK, 0x01) != 0) {
+		pr_err("CommonPhy: PLLCLK1_EN_ACK polling failed\n");
+		return -1;
+	}
+	if (poll_register(kWRAP_XCVR_PLLCLK2_EN_ACK, 0x01) != 0) {
+		pr_err("CommonPhy: PLLCLK2_EN_ACK polling failed\n");
+		return -1;
+	}
+
+	/* 15. Poll for Lanes ready */
+	if (poll_register(kWRAP_PHY_DP_LANESET_READY, 0x0F) != 0) {
+		pr_err("CommonPhy: DP_LANESET_READY polling failed\n");
+		return -1;
+	}
+
+	/* 16. Enable TX data flow */
+	common_phy_register_write(kWRAP_PHY_TX_DATA_ENABLE, 0x01);
+
+	/* 17. Set DP Link Rate to 1.62 Gbps */
+	common_phy_register_write(kWRAP_PHY_DP_LINK_RATE, 0x6);
+
+	return 0;
+}
diff --git a/board/hpe/gsc/common-phy.h b/board/hpe/gsc/common-phy.h
new file mode 100644
index 00000000000..bb41ea21ffa
--- /dev/null
+++ b/board/hpe/gsc/common-phy.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _COMMON_PHY_H
+#define _COMMON_PHY_H
+
+int common_phy_poweron_init(void);
+
+#endif /* _COMMON_PHY_H */
diff --git a/board/hpe/gsc/gsc.env b/board/hpe/gsc/gsc.env
new file mode 100644
index 00000000000..9723c30ba40
--- /dev/null
+++ b/board/hpe/gsc/gsc.env
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+loadfit=sf probe;sf read 0x2000000 0x1a0000 0xa00000;
+recover_cmd=bootm 0xfc1a0000;
+spiboot=run loadfit; saveenv; bootm 0x2000000;
+run recover_cmd;
+while itest 0 < 1; do
+	echo KERNEL BOOT FAILURE!;
+done;
diff --git a/board/hpe/gsc/gsc_board.c b/board/hpe/gsc/gsc_board.c
new file mode 100644
index 00000000000..bc86fd07485
--- /dev/null
+++ b/board/hpe/gsc/gsc_board.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2019-2025 Hewlett-Packard Enterprise Development Company, L.P.
+
+#include <dm.h>
+#include <env.h>
+#include <ram.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <dm/uclass.h>
+#include <console.h>
+#include <asm/armv8/mmu.h>
+#include <fdt_support.h>
+#include <phy.h>
+#include <net.h>
+#include <i2c_eeprom.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define ARCH_TIMER_CNTCR_REG	0xc0034000
+#define ARCH_TIMER_CNTFID0	0xc0034020
+#define ARCH_TIMER_FREQUENCY	50000000
+#define ARCH_TIMER_CNTCR_ENABLE	BIT(0)
+#define ARCH_TIMER_CNTCR_HDBG	BIT(1)
+
+#define DEFAULT_RESERVED_MEMORY_SIZE	(0x300000u)
+#define DEFAULT_VIDEO_RAM_SIZE		(0x1000000u)
+#define DENALI_ROW_DIFF			(0xCEFE219C)
+#define DENALI_ECC_ENABLE_DISABLE	(0xCEFE2134)
+#define DENALI_NON_ECC_REGION_ENABLED	(0xCEFE2170)
+#define DENALI_REG_NONECC_REGION_ONE	(0xCEFE2168)
+#define DENALI_REG_NONECC_REGION_TWO	(0xCEFE216C)
+#define VMEMOFF_ADDRESS			(0xc000001c)
+#define VIDEOMEM_ARRAY_SIZE		(7u)
+#define V_EEPROM_RO_START		(128)
+#define V_EEPROM_RO_MAC0		(V_EEPROM_RO_START + 4)
+#define V_EEPROM_RO_MAC1		(V_EEPROM_RO_START + 10)
+#define V_EEPROM_RO_SN			(1)
+#define V_EEPROM_RO_PN			(109)
+#define V_EEPROM_RO_PCA_SN		(144)
+#define V_EEPROM_RO_PCA_PN		(160)
+#define SSTRAP				0xc0000af0
+#define MEMID_BYTE_4			0xd1e10004
+#define MEMCGF_ADDRESS			0xc0000024
+
+#define GSC_MACB0		"/ahb/ethernet@c0004000/"
+#define GSC_MACB2		"/ahb/ethernet@c0006000/"
+#define GSC_MACB0_ETHERNET_PHY	"/ahb/ethernet@c0004000/ethernet-phy@0/"
+#define GSC_MACB2_ETHERNET_PHY	"/ahb/ethernet@c0006000/ethernet-phy@0/"
+#define GSC_I3C_HUB_PORT_0	"/ahb/i3c@c0003300/hub@0,0/target-port@0/"
+#define GSC_I3C_HUB_PORT_1	"/ahb/i3c@c0003300/hub@0,0/target-port@1/"
+#define GSC_I3C_HUB_PORT_2	"/ahb/i3c@c0003300/hub@0,0/target-port@2/"
+#define GSC_I3C_HUB_PORT_3	"/ahb/i3c@c0003300/hub@0,0/target-port@3/"
+
+/* Xregister Network Configuration Definitions v0x25 */
+#define GSC_PRIMARY_SECONDARY_CFG	0xd1000038
+#define GSC_SECONDARY_MAC_SHIFT		4
+#define GSC_SECONDARY_MAC_MASK		0x30
+#define GSC_PRIMARY_MAC_SHIFT		6
+#define GSC_PRIMARY_MAC_MASK		0xc0
+#define FAILOVER_SOFTSTRAP_MASK		0x6000
+#define GSC_PRIMARY_SECONDARY_PHY_TYPE	0xd100003b
+#define GSC_SECONDARY_TYPE_SHIFT	1
+#define GSC_SECONDARY_TYPE_MASK		0x0E
+#define GSC_PRIMARY_TYPE_SHIFT		4
+#define GSC_PRIMARY_TYPE_MASK		0x30
+#define GSC_PRIMARY_SPEED_DUPLEX	0xd100003c
+#define GSC_SECONDARY_SPEED_DUPLEX	0xd100003d
+#define GSC_DUPLEX_AUTO_MASK		0x08
+#define GSC_DUPLEX_FULL_MASK		0x04
+#define GSC_SPEED_AUTO_MASK		0x80
+#define GSC_SPEED_1000_MASK		0x40
+
+#include "common-phy.h"
+
+static int get_eeprom_val(uint offset, u8 *v_ptr, size_t len)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_I2C_EEPROM, &dev);
+	if (ret) {
+		debug("%s Uclass_first_device_err %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = i2c_eeprom_read(dev, offset, v_ptr, len);
+	if (ret) {
+		debug("%s Read eeprom failure %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __ft_add_fixed_link(void *blob, int nodeoff)
+{
+	int rc;
+
+	nodeoff = fdt_add_subnode(blob, nodeoff, "fixed-link");
+	if (nodeoff < 0) {
+		pr_err("Failed to add fixed-link subnode %d\n", nodeoff);
+		return nodeoff;
+	}
+
+	rc = fdt_setprop_u32(blob, nodeoff, "speed", 1000);
+	if (rc < 0) {
+		pr_err("Failed to set speed property: %d\n", rc);
+		return rc;
+	}
+
+	rc = fdt_setprop(blob, nodeoff, "full-duplex", NULL, 0);
+	if (rc < 0) {
+		pr_err("Failed to set full-duplex property: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int set_vpd_val(void *blob, uint offset, u8 *val, size_t len,
+		       char *name)
+{
+	int ret, i;
+	size_t str_len;
+	int actual_len = 0;
+
+	ret = get_eeprom_val(offset, val, len);
+	if (ret) {
+		pr_err("Failed to read %s from veeprom: %d\n", name, ret);
+		return ret;
+	}
+
+	for (i = 0; i < len - 1; i++) {
+		if (val[i] == '\0' || val[i] < 0x20 || val[i] > 0x7E) {
+			actual_len = i;
+			break;
+		}
+	}
+
+	if (actual_len == 0 && i == len - 1)
+		actual_len = len - 1;
+
+	val[actual_len] = '\0';
+	str_len = actual_len + 1;
+
+	ret = fdt_setprop(blob, fdt_path_offset(blob, "/"), name, val, str_len);
+	if (ret < 0) {
+		pr_err("Failed to set %s in DTB: %s\n", name,
+		       fdt_strerror(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ft_board_setup_vpd(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_GSC_PATCH_KERNEL_DTS_VPD)) {
+		u8 val[16];
+
+		set_vpd_val(blob, V_EEPROM_RO_SN, val, 16, "sn");
+		set_vpd_val(blob, V_EEPROM_RO_PN, val, 16, "pn");
+		set_vpd_val(blob, V_EEPROM_RO_PCA_SN, val, 16, "serial-number");
+		set_vpd_val(blob, V_EEPROM_RO_PCA_PN, val, 16, "model");
+	}
+
+	return 0;
+}
+
+static int ft_board_config_i3c_hub(void *blob, struct bd_info *bd)
+{
+	static const char * const port_paths[] = {
+		GSC_I3C_HUB_PORT_0,
+		GSC_I3C_HUB_PORT_1,
+		GSC_I3C_HUB_PORT_2,
+		GSC_I3C_HUB_PORT_3,
+	};
+	u8 cpu;
+	int nodeoff, rc, i;
+
+	if (!IS_ENABLED(CONFIG_GSC_I3C_HUB_DT))
+		return 0;
+
+	cpu = readb(MEMID_BYTE_4);
+	if (cpu == 0) {
+		pr_err("Error: CPU Presence = 0\n");
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(port_paths); i++) {
+		if (cpu & BIT(i))
+			continue;
+
+		nodeoff = fdt_path_offset(blob, port_paths[i]);
+		if (nodeoff < 0) {
+			pr_err("Failed to find I3C hub port %d\n", i);
+			continue;
+		}
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0)
+			pr_err("Failed to delete I3C hub port %d: %d\n", i, rc);
+	}
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int rc, nodeoff;
+	unsigned int tmp;
+	u8 val;
+	u8 mac2_is_primary = 0;
+
+	rc = ft_board_config_i3c_hub(blob, bd);
+	if (rc)
+		pr_err("I3C Hub DT Adjustment failed: %d\n", rc);
+
+	tmp = readl(SSTRAP);
+
+	if (tmp & FAILOVER_SOFTSTRAP_MASK) {
+		val = (readb(GSC_PRIMARY_SECONDARY_CFG) & GSC_PRIMARY_MAC_MASK)
+				>> GSC_PRIMARY_MAC_SHIFT;
+		if (val == 0x00) {
+			val = (readb(GSC_PRIMARY_SECONDARY_PHY_TYPE) &
+					GSC_PRIMARY_TYPE_MASK)
+					>> GSC_PRIMARY_TYPE_SHIFT;
+			if (val == 0x01) {
+				nodeoff = fdt_path_offset(blob, GSC_MACB0);
+				if (nodeoff < 0) {
+					pr_err("Failed to find macb0 node\n");
+					return 0;
+				}
+
+				rc = fdt_delprop(blob, nodeoff, "phy-handle");
+				if (rc < 0) {
+					pr_err("Failed to delete phy-handle\n");
+					return 0;
+				}
+
+				nodeoff = fdt_path_offset(blob, GSC_MACB0_ETHERNET_PHY);
+				if (nodeoff < 0) {
+					pr_err("Failed to find macb0 phy node\n");
+					return 0;
+				}
+
+				rc = fdt_del_node(blob, nodeoff);
+				if (rc < 0) {
+					pr_err("Failed to delete phy node\n");
+					return 0;
+				}
+			}
+
+			val = readb(GSC_PRIMARY_SPEED_DUPLEX);
+			if (val == (GSC_DUPLEX_FULL_MASK | GSC_SPEED_1000_MASK)) {
+				nodeoff = fdt_path_offset(blob, GSC_MACB0);
+				if (nodeoff < 0) {
+					pr_err("Failed to find macb0 node\n");
+					return 0;
+				}
+
+				rc = __ft_add_fixed_link(blob, nodeoff);
+				if (rc < 0) {
+					pr_err("Failed to add macb0 fixed-link\n");
+					return 0;
+				}
+			}
+
+			rc = fdt_find_and_setprop(blob, GSC_MACB0, "status",
+						  "okay", 6, 1);
+			if (rc < 0)
+				pr_err("Failed to set okay (%s)\n", GSC_MACB0);
+
+		} else if (val == 0x02) {
+			mac2_is_primary = 1;
+			rc = fdt_find_and_setprop(blob, GSC_MACB2, "status",
+						  "okay", 6, 1);
+			if (rc < 0)
+				pr_err("Failed to set okay (%s)\n", GSC_MACB2);
+		}
+
+		val = (readb(GSC_PRIMARY_SECONDARY_CFG) & GSC_SECONDARY_MAC_MASK)
+				>> GSC_SECONDARY_MAC_SHIFT;
+		if (val == 0x00) {
+			if (mac2_is_primary) {
+				rc = fdt_find_and_setprop(blob, GSC_MACB0,
+							  "status",
+							  "disabled", 10, 1);
+				if (rc < 0)
+					pr_err("Failed to disable (%s)\n",
+					       GSC_MACB0);
+			} else {
+				val = (readb(GSC_PRIMARY_SECONDARY_PHY_TYPE) &
+					GSC_SECONDARY_TYPE_MASK)
+					>> GSC_SECONDARY_TYPE_SHIFT;
+				if (val == 0x00) {
+					rc = fdt_find_and_setprop(blob,
+								  GSC_MACB2,
+								  "status",
+								  "disabled",
+								  10, 1);
+					if (rc < 0)
+						pr_err("Failed to disable (%s)\n",
+						       GSC_MACB2);
+				}
+			}
+		}
+	} else {
+		/* Failover mode: configure 1000base-x */
+		nodeoff = fdt_path_offset(blob, GSC_MACB0);
+		if (nodeoff < 0) {
+			pr_err("Failed to find macb0 node\n");
+			return 0;
+		}
+
+		rc = fdt_delprop(blob, nodeoff, "phy-handle");
+		if (rc < 0) {
+			pr_err("Failed to delete phy-handle\n");
+			return 0;
+		}
+
+		nodeoff = fdt_path_offset(blob, GSC_MACB0_ETHERNET_PHY);
+		if (nodeoff < 0) {
+			pr_err("Failed to find macb0 phy node\n");
+			return 0;
+		}
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			pr_err("Failed to delete phy node\n");
+			return 0;
+		}
+
+		rc = fdt_find_and_setprop(blob, GSC_MACB0, "phy-mode",
+					  "1000base-x", 12, 0);
+		if (rc < 0) {
+			pr_err("Failed to set phy-mode\n");
+			return 0;
+		}
+
+		nodeoff = fdt_path_offset(blob, GSC_MACB0);
+		if (nodeoff < 0) {
+			pr_err("Failed to find macb0 node\n");
+			return 0;
+		}
+
+		rc = __ft_add_fixed_link(blob, nodeoff);
+		if (rc < 0) {
+			pr_err("Failed to add macb0 fixed-link\n");
+			return 0;
+		}
+
+		rc = fdt_find_and_setprop(blob, GSC_MACB0, "status",
+					  "okay", 6, 1);
+		if (rc < 0)
+			pr_err("Failed to set okay (%s)\n", GSC_MACB0);
+
+		rc = fdt_find_and_setprop(blob, GSC_MACB2, "status",
+					  "disabled", 10, 1);
+		if (rc < 0)
+			pr_err("Failed to disable (%s)\n", GSC_MACB2);
+	}
+
+	ft_board_setup_vpd(blob, bd);
+
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	/* Apply runtime FDT changes to U-Boot's own device tree */
+	ft_board_setup((void *)gd->fdt_blob, gd->bd);
+
+	return 0;
+}
+
+static struct mm_region gsc_mem_map[] = {
+	{
+		.virt = 0x00000000,
+		.phys = 0x00000000,
+		.size = 0x00000000,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		.virt = 0x40000000,
+		.phys = 0x40000000,
+		.size = 0x00000000,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		.virt = 0xa0008000,
+		.phys = 0xa0008000,
+		.size = 0x10000,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		.virt = 0xc0000000,
+		.phys = 0xc0000000,
+		.size = 0x1f000000,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN |
+			 PTE_BLOCK_UXN
+	}, {
+		.virt = 0xfc000000,
+		.phys = 0xfc000000,
+		.size = 0x04000000,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = gsc_mem_map;
+
+static void calculate_available_dram_size(void)
+{
+	phys_size_t total_ddr_size = 0x40000000u;
+	phys_size_t non_ecc_region_1_size = 0u;
+	phys_size_t non_ecc_region_2_size = 0u;
+	u8 index = 0u;
+	phys_size_t video_mem_size_a[VIDEOMEM_ARRAY_SIZE] = {
+		0x0, 0x400000, 0x800000, 0x1000000,
+		0x2000000, 0x4000000, 0x8000000
+	};
+
+	total_ddr_size = 1u << (17u - ((readl(DENALI_ROW_DIFF) >> 24u) & 0x7));
+	total_ddr_size = (total_ddr_size / 8u) * (128u * 1024u);
+
+	if (((readl(DENALI_ECC_ENABLE_DISABLE) >> 16u) & 0x3) > 0u) {
+		total_ddr_size = (total_ddr_size / 8u) * 7u;
+
+		if ((readl(DENALI_NON_ECC_REGION_ENABLED) & 0x1) > 0u) {
+			non_ecc_region_1_size =
+				((readl(DENALI_REG_NONECC_REGION_ONE) >> 16u) & 0xfff) -
+				(readl(DENALI_REG_NONECC_REGION_ONE) & 0xfff);
+			non_ecc_region_1_size <<= 20u;
+			total_ddr_size -= non_ecc_region_1_size;
+		}
+
+		if ((readl(DENALI_NON_ECC_REGION_ENABLED) & 0x2) > 0u) {
+			non_ecc_region_2_size =
+				((readl(DENALI_REG_NONECC_REGION_TWO) >> 16u) & 0xfff) -
+				(readl(DENALI_REG_NONECC_REGION_TWO) & 0xfff);
+			non_ecc_region_2_size <<= 20u;
+			total_ddr_size -= non_ecc_region_2_size;
+		}
+	} else {
+		index = readl(VMEMOFF_ADDRESS) & 0x7;
+		if (index < VIDEOMEM_ARRAY_SIZE)
+			total_ddr_size -= video_mem_size_a[index];
+		else
+			total_ddr_size -= DEFAULT_VIDEO_RAM_SIZE;
+		total_ddr_size -= DEFAULT_RESERVED_MEMORY_SIZE;
+	}
+
+	gd->ram_size = total_ddr_size;
+	gsc_mem_map[0].size = total_ddr_size;
+	if ((17u - ((readl(DENALI_ROW_DIFF) >> 24u) & 0x7)) == 16u)
+		gsc_mem_map[1].size = total_ddr_size;
+}
+
+int dram_init(void)
+{
+	calculate_available_dram_size();
+	return 0;
+}
+
+static int get_eeprom_mac(uint offset, u8 *v_mac)
+{
+	return get_eeprom_val(offset, v_mac, 6);
+}
+
+static int set_mac_addr(const char *name, uint offset)
+{
+	int ret;
+	u8 v_mac[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+
+	ret = get_eeprom_mac(offset, v_mac);
+	if (ret || !is_valid_ethaddr(v_mac)) {
+		pr_err("Warning: MAC %s - %pM ", name, v_mac);
+		if (IS_ENABLED(CONFIG_NET_RANDOM_ETHADDR)) {
+			net_random_ethaddr(v_mac);
+			pr_err("invalid, using random MAC - %pM\n", v_mac);
+		} else {
+			pr_err("is not valid\n");
+			return -1;
+		}
+	}
+
+	env_set(".flags", name);
+	env_set(name, NULL);
+	eth_env_set_enetaddr(name, v_mac);
+	debug("%s MAC Address %pM\n", name, v_mac);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int misc_init_r(void)
+{
+	set_mac_addr("ethaddr", V_EEPROM_RO_MAC0);
+	set_mac_addr("eth1addr", V_EEPROM_RO_MAC1);
+	return 0;
+}
+
+static void arch_timer_start_reg_set(void)
+{
+	writel(ARCH_TIMER_FREQUENCY, ARCH_TIMER_CNTFID0);
+	writel(ARCH_TIMER_CNTCR_ENABLE | ARCH_TIMER_CNTCR_HDBG,
+	       ARCH_TIMER_CNTCR_REG);
+}
+
+int arch_early_init_r(void)
+{
+	if (IS_ENABLED(CONFIG_ARMV8_SPIN_TABLE)) {
+		writel(gd->relocaddr, SECONDARY_RELEASE_ADDR);
+		dsb();
+		asm volatile("sev");
+	}
+
+	arch_timer_start_reg_set();
+
+	if (common_phy_poweron_init() == 0)
+		debug("CommonPhy poweron init succeeded\n");
+	else
+		pr_err("CommonPhy poweron init failed\n");
+
+	return 0;
+}
diff --git a/board/hpe/gsc/server_id.c b/board/hpe/gsc/server_id.c
new file mode 100644
index 00000000000..acfcc889f87
--- /dev/null
+++ b/board/hpe/gsc/server_id.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * GSC server_id command
+ *
+ * (C) Copyright 2019-2025 Hewlett Packard Enterprise Development LP.
+ * Author: Jorge Cisneros <jorge.cisneros@hpe.com>
+ */
+
+#include <env.h>
+#include <asm/io.h>
+#include <command.h>
+
+#define REGISTER_BASE_ADDRESS	0xD1000000
+#define SERVER_ID_OFFSET	0x0
+#define SERVER_ID_MASK		0xFFFF00
+
+static unsigned int get_server_id(void)
+{
+	unsigned int server_id;
+
+	server_id = readl(REGISTER_BASE_ADDRESS + SERVER_ID_OFFSET);
+	server_id &= SERVER_ID_MASK;
+	server_id >>= 8;
+	return server_id;
+}
+
+static int do_server_id(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	unsigned int server_id = get_server_id();
+	char env_value[16];
+
+	if (argc == 2) {
+		if (strcmp(argv[1], "show") == 0)
+			printf("Server ID: 0x%04X\n", server_id);
+		else
+			printf("Usage: %s <show>\n", cmdtp->name);
+	} else {
+		snprintf(env_value, sizeof(env_value), "0x%04x", server_id);
+		env_set("server_id", env_value);
+	}
+
+	return 0;
+}
+
+U_BOOT_CMD(
+	server_id, 2, 0, do_server_id,
+	"Get the server ID from the GSC registers",
+	"<show> - Show the server id instead of setting the environment variable\n"
+	"         otherwise set an environment variable \"server_id\" with the value\n"
+);
diff --git a/include/configs/gsc.h b/include/configs/gsc.h
new file mode 100644
index 00000000000..6a199f52674
--- /dev/null
+++ b/include/configs/gsc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * GSC board configuration
+ *
+ * (C) Copyright 2019-2025 Hewlett Packard Enterprise Development LP.
+ */
+
+#ifndef _GSC_H_
+#define _GSC_H_
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_SDRAM_BASE		0x0
+#define CFG_SYS_INIT_RAM_ADDR		0x0
+#define CFG_SYS_INIT_RAM_SIZE		0x100000
+#define CFG_SYS_INIT_SP_OFFSET \
+	(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
+#define CFG_SYS_INIT_SP_ADDR \
+	(CFG_SYS_INIT_RAM_ADDR + CFG_SYS_INIT_SP_OFFSET)
+
+#define GICD_BASE			0xce000000
+#define GICR_BASE			0xce060000
+#define SECONDARY_RELEASE_ADDR		0xa0008048
+
+#endif

-- 
2.43.0

