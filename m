Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C02CD29DD5
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 06:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDC7836A3;
	Tue, 13 Jan 2026 07:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzqwG4nh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vy9VH3eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5F4836C8; Tue, 13 Jan 2026 07:59:08 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44F583678
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60CN4wHi3299726
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GJ3NSxD6kDV4wa5tJVsNL/YzzrW1/uw2+5Y
 +MS1GEsI=; b=JzqwG4nhOr1rIkVVXPsHEto8r8ZsROGv1KBEBEPkc/pEegh3xLQ
 MGJYzeMpDQMfeGHuhHeIwUGWq+FrdnTO7tYL6RE+O0TlFCS3r5zAoRy3W1AcIRCR
 UCmHW77YJqJLy4alyLfskuUeG7iWdMvbxYtJ7BJYR6HpLLq4SNfZi0YKRaPqyuUL
 HrqSKAZ35buiZNXHkGa6ehyWm8SH7jnTlDsDwWsbfN0WiytYnxAgbQ5emEUgDKQl
 s+bnYgins7aIyhPsJDNKeXF3lSwfHQQlfiUUYGcNbDQs0xlpldGJjlyh+hCZPmjC
 mujqfCecRZSo4Qn7ej8rKzowM4TQUOk+jzA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jm9qnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:59:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso81886125ad.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768287543; x=1768892343; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ3NSxD6kDV4wa5tJVsNL/YzzrW1/uw2+5Y+MS1GEsI=;
 b=Vy9VH3eFUEJhI7Spq/6ByHjS28S0pgk/uYFvSkxdsczCx+s9aY4GkKn/yk5lm/uL7Y
 Wj7zEogfti68RE6a00hj3BcYlzw4k3STTqI30lSytWLtBVlHz/DuSgwAyuZPEIW4lng0
 rKjVXIBDMFKI0C/PWixUuPwnu5wWXS0naDrdZAnBMrY7NFQhfq3d9yWm8f227ywjBEtg
 /eSfJon3RgVIZEDc7Uo2w4hfKvUO1JRY9gV4I7KeVhZWW2tUihaAWkWudQPJ1tONuVqy
 ibyrLIunNaZ3OHMw1fVm8DPeWTLQmcOmqkRGgrsfLSiMEZ09Zk02Q8RFkcE/6E+1FviH
 +4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768287543; x=1768892343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJ3NSxD6kDV4wa5tJVsNL/YzzrW1/uw2+5Y+MS1GEsI=;
 b=qflvC1yCvwYufN7yJo31eMFKlLEL/oa2TmiqUEiCmu0v/ZJAa+isiw7lO1+YgeyRSP
 iN7fqBim2JKNpaRuXrNk4cRD+9/lAcuG1YWtmzi1HObs6BDXRLj9Wwe50Pt/t7tQK1LQ
 NJpxF7WvUx2GLmOA3wIxzc2AwQXKTeWL8GaD/G8BvoKnlQvxLf8DrGg/H3LJ6J3DSPGy
 LmhVSg3cC73G6LZdxoH+TzvmkyAOTftxX2FIddW4QVaiuBcojXDMWMXOU87EYPe6Ut2C
 pahQQYmb6A6XdsdprlhQaLe7MjzF0mIH0UhwRacW305ckBqE1C1xLo53vYn/yP79XXUi
 HwDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKtXkSglx6JDyJdoo6rqyUCX25X3f8dHDlMm/iemF7AtA+9ODdAp0stwES4YNcOkvUGXav2iE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/+Qyeok0ESpBQDq9VlxS/iJur5EiSjnR8wAfcxp1xVVoa7UN8
 qtammc9DOUa8A4jFYwCLEQqHnQwqkExt8pjI3Xxm9EEvDzyVdwZt7ByLBt8BuZ/tSmlkLbHPR7B
 hzbvhGvtaMVgggFK1U1gdqnCjk7VmiYvYeTlY5X2DbZS2Dt4dIjsBk0b/
X-Gm-Gg: AY/fxX4Hu5gczNwSxGYDZFdaSFhzwRH4O2OPkt0Feyd3ZxuzIae9JqFYdVPdmxhVcQY
 3IOSy/pMC+L1RzJQ1PjG/0/ydk5KNLwwGCvL4HqtVkoISX80ROJq5fy6sGNAdbYcAmA8IXRyEHd
 SVbsGsKYbQjTnYI/BK4w1GIqomRDAFG1PiDwiz3WcgpJZAXXHqor+BS6PwL5pVNYpbNrMzPHQid
 jK9Auieo30j/p13I0WqN2QuEb4LQd0STzZLuSAmV4Kd621KQbnaHXtveKVa6A//FgSE90NCy08L
 dvxmehUwM7WmYa7MZpe/Zmd7P5FpUfG3a9RVXLqp9XNokMmmVW1IapWiy1TUesPm1vZ4IXGOoOM
 klALsj3eOMa35/hYDYOZF2ObiKBoIDy/TXfwyVsWJpDsjzjj3Qh+/077Pq7vP2nucbt2cRliEd6
 YohVp1NzrFs2x1Mg011is4Bt5+T66BtEaliDbudw==
X-Received: by 2002:a17:902:e749:b0:297:d6c2:d06 with SMTP id
 d9443c01a7336-2a3ee435e58mr184416205ad.20.1768287543030; 
 Mon, 12 Jan 2026 22:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1oy8BFQgFFaUYZgDMsc0Wbgl8jPD13n5VneUhaynA4RuQO+B/TAO16+zaav5AvRaILM0PMA==
X-Received: by 2002:a17:902:e749:b0:297:d6c2:d06 with SMTP id
 d9443c01a7336-2a3ee435e58mr184416005ad.20.1768287542503; 
 Mon, 12 Jan 2026 22:59:02 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc7856sm194405755ad.68.2026.01.12.22.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 22:59:02 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com,
 swathi.tamilselvan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] clk: qcom: sa8775p: Fix USB clock configuration and add
 resets
Date: Tue, 13 Jan 2026 12:28:55 +0530
Message-Id: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8moZrzVc-x2ZXbD27YgmEYY4jeVe-34F
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=6965ed38 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=h-QCx9MZMZLj7WMmVpQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 8moZrzVc-x2ZXbD27YgmEYY4jeVe-34F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NiBTYWx0ZWRfX/c06OGOIhD/M
 NUlUaLtpzg78IRIbfzXArZG4mYFTPhlAC3n0J73R5ot46MXmtSzoEKi7rsqBzINqf/pgZZHjOxw
 Z6StfsenSdjT/PSsuhCdQmQD5kwBOgjYWUeqZYvmN/2MmKf2/viOr4Fs+wWLVmehzxNhrANENzD
 IbcrP9JgI1Z8/0gwWCWoC40VP6Ws/a9znaoXddXOP7Ez/5Ux9RWHOBndfplUz4qrk+KysBJHcnj
 OrOPb0l1O/LKVetM0Nhn6fJrvAZKfiCZPcicSi41BVQA5cM1UyRQmkt1mFPbRQYZEKCuJtEGZyD
 69bdTXdDPzABv7xPKHEz7pvxO4JU/9XrmknWHA481abOkzQxAVtdTr/3j3Dk9KDptDhMluPCBdI
 paOrvERgv+0/iv6NbANkvnDBqWH/l4G5OTamOV1KjHw+Y4HE/M17tc1VfbM2+foIW0/W4AQGY2K
 LKUH0G7foanUBV4fuMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130056
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

Correct USB30 primary clock RCG configuration and add missing
USB3_PRIM_PHY_AUX_CMD_RCGR RCG configuration.
Above taken from Linux commit 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")

Add missing USB3_PRIM_PHY_PIPE_CLK gate clock definition.
Extend reset map with USB-related BCR entries and video BCR
for comprehensive reset control support.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 5a6fbd417ff..25c8cd4af9a 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -15,8 +15,9 @@
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
 #include "clock-qcom.h"
 
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
 
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
@@ -59,8 +60,8 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 	case GCC_USB30_PRIM_MASTER_CLK:
 		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+			5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
 	default:
 		return 0;
@@ -75,6 +76,7 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, 1),
 
 	/* QUP Wrapper 0 clocks */
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
@@ -157,6 +159,24 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
 	[GCC_TSCSS_BCR] = { 0x21000 },
 	[GCC_UFS_CARD_BCR] = { 0x81000 },
 	[GCC_UFS_PHY_BCR] = { 0x83000 },
+	[GCC_USB20_PRIM_BCR] = {0x1c000},
+	[GCC_USB2_PHY_PRIM_BCR] = {0x5c028},
+	[GCC_USB2_PHY_SEC_BCR] = {0x5c02c},
+	[GCC_USB30_PRIM_BCR] = {0x1b000},
+	[GCC_USB30_SEC_BCR] = {0x2f000},
+	[GCC_USB3_DP_PHY_PRIM_BCR] = {0x5c008},
+	[GCC_USB3_DP_PHY_SEC_BCR] = {0x5c014},
+	[GCC_USB3_PHY_PRIM_BCR] = {0x5c000},
+	[GCC_USB3_PHY_SEC_BCR] = {0x5c00c},
+	[GCC_USB3_PHY_TERT_BCR] = {0x5c030},
+	[GCC_USB3_UNIPHY_MP0_BCR] = {0x5c018},
+	[GCC_USB3_UNIPHY_MP1_BCR] = {0x5c01c},
+	[GCC_USB3PHY_PHY_PRIM_BCR] = {0x5c004},
+	[GCC_USB3PHY_PHY_SEC_BCR] = {0x5c010},
+	[GCC_USB3UNIPHY_PHY_MP0_BCR] = {0x5c020},
+	[GCC_USB3UNIPHY_PHY_MP1_BCR] = {0x5c024},
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = {0x76000},
+	[GCC_VIDEO_BCR] = {0x34000}
 };
 
 static const struct qcom_power_map sa8775p_gdscs[] = {
-- 
2.34.1

