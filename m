Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E3CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F06848A1;
	Mon, 15 Jun 2026 14:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8XHRpy2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWw5Qu7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CA983FEE; Mon, 15 Jun 2026 14:19:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4BB284894
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoWmd3986659
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LR7hv/WiXYU
 WUudhnJ+n4qzusxoFdRGD3qsJUHMbx+8=; b=b8XHRpy2JNaNKGj7GclexH/yj32
 MOCqnEH3Dg5NzJj0gFRpIIoj8Sn6LqyD+Ei9z02QdV2mEp3ZXl8kwlypzbC7FCyj
 bm2ArkVcHz/fKeDXRKmroTrrfyBXMzM0JEwyYtC1iszGahwoP/Pdab1KbQUj6TXC
 xcY18HzqERflOX8tt4mE0N1Y9eXc7RWdS2fPaj5fi/L2FHMK60INmIrDtX1DPf+o
 SyWsUj7yo8MYUSOh+sLbVBj1UdOQzWWvGXToFBHz0PGHOD0/4sdCGS5SmG3kSSLd
 3k73qDZkpBEYgb1l/z8a9hLxiLRO6J9K8vgQhpsMAkkHwVyzWohMKjxpFlQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0gkmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84240b58211so2295331b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525956; x=1782130756; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LR7hv/WiXYUWUudhnJ+n4qzusxoFdRGD3qsJUHMbx+8=;
 b=aWw5Qu7wgHcYfYJGnxmw0iyaL4BYkWXULlBLPnf7xzajADmza05g5M8zVEzx1WSl8l
 6quX1Hbe6kgOogZFd/kYEPSjB9arkyBbQk7/5awYUl+6GCRJ2yyxaq7c+YIPP7HoyTWH
 Gcf/dv46dcZqZh2ybIQpS2ZisoTB3RuMoLJCcUQLpeWgVqJc5sQrTItwSExsfeH7T51f
 /RgmoTClw/9sdwzRLh2RHfXtSoS+rDCeuL9FCVNJ6iX3PMbuyhs+WZj4fSGfuypNNE7g
 hRnWowWbpy8zSg6FaibbJDFpeNZCanp9EUeXqtDu0iEYXCZEUgstcFwY/Fq7P3TNbTwp
 YabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525956; x=1782130756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LR7hv/WiXYUWUudhnJ+n4qzusxoFdRGD3qsJUHMbx+8=;
 b=Hv8wXzhNU1QQJd+IHxavertmmOfbvgDOFR+vjdz2Y0qejplZYF+ELHz4/dK1+rLA4c
 LBp3qWxdtlvzQef6NfSyIaXi8z/RE9GheF4geG+cboWLm0yXknEwze/XFgfAFNUn/TkT
 VKRTrF8iKhL8yMSUT6kB2aNf65yuNEH3cSeaRetaFk0TxlGvYCxKJ8MAnrttoIwlgQ9W
 Iw+PwThtX8x//KZk5VcF3ezyHnbQKaGQQr31wfEoVAEDlcbsopL3zKNnG15doAF2KTQu
 jCHQ7PmJQUAbMf8BOxEvAobeWeosFNf2s2NPEFHmveyYVZo0Zng0GBLQuRkLBhv+8Msb
 zIQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E85Gpka1XGdaeScCWMoTLJewt3Hf+71EsZZE6ZByfwSmPlpUaz4NBe+MeWpKcVzl4nEzZmPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzlT9iMiLuMjXHsE17Tn56GwB5jYbwCqWpohLpz3+iAfiuLgOsS
 rYTAOrivHe0oT6JdKPr0FXroMzb9twTTM+x6m7do70N5v138cnCSPGFsms8xzRW8B6P93q2QcuT
 oevW04WpNip9qA8gb3X+zFLPou8a1DEyb1Gkp2qLCi8+zfsnoCqjZ6Jkj
X-Gm-Gg: Acq92OENJ0XPct5Ei+HfLUZJ7rKrsx9oFA2W38XSlDzUQzRQqwzUJRVGHw2bJQnDihJ
 YXUXAaMObr6EA8quqpnwd1mRtlO77rMyNzyWvMRuGg6XZw1ESxufl3ByYcQC2ZOrymxkR/aHO3f
 sfEIx/G5PdnbmhVX6IX72azLYwNFH4I1tZspVhL5aOq5mMeNYz6YM0l22Mgy4EOc/BcAM2lZJiD
 nAb5VpbyvdfRoCe1bJUAJfqygoOzjirI2wykjaPO/+IFn11W9kPl0NDWJoMM99pmLrmY5A/iavp
 2AiVL9vNxL2GITjODB+JFUjYtTO/tsLCyL8mRA1eZFOkPK7NjTuASUFr6WS3Vn39yl9N2GtC5+H
 MO64TC5ue4wHL01wCTujKZ8jJKlnuidL5GIZD6AzPURcIPGiSiKiUy57mRj3Jo01/L0lijTwGJj
 wU98mFOQK6yaZgXMfaWdmIEeayP3ItTFXuPpvABCyI
X-Received: by 2002:a05:6a00:390d:b0:842:6004:3fd5 with SMTP id
 d2e1a72fcca58-8434ce40758mr15107872b3a.25.1781525955898; 
 Mon, 15 Jun 2026 05:19:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:390d:b0:842:6004:3fd5 with SMTP id
 d2e1a72fcca58-8434ce40758mr15107833b3a.25.1781525955360; 
 Mon, 15 Jun 2026 05:19:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:15 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 3/8] clk: qcom: add GCC clock driver support for Shikra SoC
Date: Mon, 15 Jun 2026 17:48:23 +0530
Message-Id: <20260615121828.1798789-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX2QmMX0arAjz5
 8wV1/2C8BWj9+Co0jd+sSXooS5QiBGW1hEhgrjrnPP7+OJEdsNE3KexFZ77oruTRnhz0IV/7WPc
 OYyLhEZrexwGxj5mjUMkyB4eE68tAoc=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a2fedc4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=IYzDD4T7RDv2QviTypMA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8gdPtkAbPhKa
 ONPeZQSbQ/ZNEE31AQvNU9VGOJ3ABE0PGcf0zNqdxIMLlMxaO300x+GZQmFJIbhOtK5hEaloxdq
 uE+6oquuSgIW2Q2Rybi0LanDDOtdFn89f+5PuWeagD8/oAt4R6TF8qYp5XFU8W1/+JxIso+pSb8
 G76MBGiRSZtyQ0+db76RsnNUmnndKKfueChoaxJtQU8/i5LIts7d4lSb5mHbDXZHSD9Su81P5nu
 19VwvJXtZnWUYHJ/l6hs74m5f6q7izkG08V71BXdOWKEwsE7gz5W5pL8In308onhEm+SlqGvltQ
 3BcqqZ9kkD8UwF3pGKi4apKCVh6xaURrscRzea3vVlHdG86UHlYXzXbHiKNzgFyFBnxmbIXBOad
 FZD4sKNU/vPXbr7hAcXlp9SL0gP6fBZ28jAa9fl/IoVzU5rQ2/lerQ3ZKAW8tTEXakqI1x1ghtB
 sBYpHK6cBUeXOQZIycw==
X-Proofpoint-GUID: njiVY88l9VJfWXHl-jeDJWIPD0gKpSSs
X-Proofpoint-ORIG-GUID: njiVY88l9VJfWXHl-jeDJWIPD0gKpSSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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

Add initial support for the Global Clock Controller (GCC) on
Qualcomm Shikra SoC.

This introduces a new clock driver (clock-shikra.c) implementing
the required clocks for early boot and peripheral enablement.
Update Kconfig and Makefile to include the Shikra GCC clock
driver in the build.

The driver currently provides basic clock definitions required
for system initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-shikra.c | 319 ++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-shikra.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0a2ce55aaa2..f1c8be4d49f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -166,6 +166,14 @@ config CLK_QCOM_SC7280
 	  on the Snapdragon SC7280 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SHIKRA
+	bool "Qualcomm SHIKRA GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SHIKRA SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_X1E80100
 	bool "Qualcomm X1E80100 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b96d61b603e..b952cbf32e6 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
 obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
new file mode 100644
index 00000000000..b0cfb477dea
--- /dev/null
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm shikra
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+
+#include "clock-qcom.h"
+
+/* USB 3.0 Primary */
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1a01c
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1a060
+
+/* USB 2.0 */
+#define USB20_MASTER_CLK_CMD_RCGR		0xb003c
+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0xb0020
+
+/* QUPV3 */
+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR		0x1f148
+#define QUPV3_WRAP0_S1_CLK_CMD_RCGR		0x1f278
+#define QUPV3_WRAP0_S2_CLK_CMD_RCGR		0x1f3a8
+#define QUPV3_WRAP0_S3_CLK_CMD_RCGR		0x1f4d8
+#define QUPV3_WRAP0_S4_CLK_CMD_RCGR		0x1f608
+#define QUPV3_WRAP0_S5_CLK_CMD_RCGR		0x1f738
+#define QUPV3_WRAP0_S6_CLK_CMD_RCGR		0x1f868
+#define QUPV3_WRAP0_S7_CLK_CMD_RCGR		0x1f998
+#define QUPV3_WRAP0_S8_CLK_CMD_RCGR		0x1fac8
+#define QUPV3_WRAP0_S9_CLK_CMD_RCGR		0x1fbf8
+
+/* SDCC1 */
+#define SDCC1_APPS_CLK_CMD_RCGR			0x38028
+#define SDCC1_ICE_CORE_CLK_CMD_RCGR		0x38010
+
+/* SDCC2 */
+#define SDCC2_APPS_CLK_CMD_RCGR			0x1e00c
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0_AUX2, 2, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 0, 0),
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static ulong shikra_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_USB3_PRIM_PHY_COM_AUX_CLK:
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_USB20_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S8_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S8_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S9_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S9_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC1_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_ice_core_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_ICE_CORE_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	default:
+		return rate;
+	}
+}
+
+static const struct gate_clk shikra_clks[] = {
+	GATE_CLK(GCC_AHB2PHY_CSI_CLK, 0x1d004, BIT(0)),
+	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x111c4, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a07c, BIT(0)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x79004, BIT(22)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x79004, BIT(23)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x79004, BIT(24)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x79004, BIT(25)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x79004, BIT(26)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x79004, BIT(27)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x79004, BIT(28)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x79004, BIT(29)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S8_CLK, 0x79004, BIT(30)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S9_CLK, 0x79004, BIT(31)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0)),
+	GATE_CLK(GCC_SYS_NOC_USB2_PRIM_AXI_CLK, 0x10a14, BIT(0)),
+	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a078, BIT(0)),
+	GATE_CLK(GCC_UFS_CLKREF_EN, 0x8c000, BIT(0)),
+	GATE_CLK(GCC_USB20_MASTER_CLK, 0xb0010, BIT(0)),
+	GATE_CLK(GCC_USB20_MOCK_UTMI_CLK, 0xb001c, BIT(0)),
+	GATE_CLK(GCC_USB20_SLEEP_CLK, 0xb0018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_EN, 0x9f000, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
+};
+
+static int shikra_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks <= clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_SYS_NOC_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	case GCC_SYS_NOC_USB2_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB20_MASTER_CLK);
+		fallthrough;
+	case GCC_USB20_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB20_MOCK_UTMI_CLK);
+		qcom_gate_clk_en(priv, GCC_USB20_SLEEP_CLK);
+		break;
+	}
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map shikra_gcc_resets[] = {
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_USB20_BCR] = { 0xb0000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+};
+
+static const struct qcom_power_map shikra_gdscs[] = {
+	[GCC_USB20_GDSC] = { 0xb0004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+};
+
+static struct msm_clk_data shikra_gcc_data = {
+	.resets = shikra_gcc_resets,
+	.num_resets = ARRAY_SIZE(shikra_gcc_resets),
+	.clks = shikra_clks,
+	.num_clks = ARRAY_SIZE(shikra_clks),
+
+	.power_domains = shikra_gdscs,
+	.num_power_domains = ARRAY_SIZE(shikra_gdscs),
+
+	.enable = shikra_enable,
+	.set_rate = shikra_set_rate,
+};
+
+static const struct udevice_id gcc_shikra_of_match[] = {
+	{
+		.compatible = "qcom,shikra-gcc",
+		.data = (ulong)&shikra_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_shikra) = {
+	.name		= "gcc_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_shikra_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

