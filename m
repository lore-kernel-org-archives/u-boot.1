Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181A2D13C3C
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C716483DB6;
	Mon, 26 Jan 2026 16:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YOElX8d5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmwRYcTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561ED83DDD; Mon, 26 Jan 2026 16:59:55 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F4983CEA
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QEr05T170916
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=88ZRcFWEjU7
 GAijgqs6gguWeFMOjZ8mDyjSpg1LVvnQ=; b=YOElX8d5Ej9e5Jgk3BdCsbf/789
 VgdalNak8cz16Rwt+WS1VuUCiYyD7QsqOo4ntS8ncEXtWEY2uusCaU52oefgOkbF
 bdk7LSujKwvRIL9xYOKqoeRSkH0PXWrQ2xudbab5i/qYYsU7G0Pt2eTUdubNZtdx
 XRkOH4Fw9h0xYKu0NcGbdQ8orl0q/oavjHZXhtt6mCc9QS87ASefecJS9JVSTxVx
 GaB/1/fZ7/AXkVFpzQwic6ejw/3mW3ZYkvDkAt1g53ThV8861O4dP+qdCXHJig/O
 ZRHy+7c/ae/jGMzzHpSMAgRjksYVqz9+eYcdzhOXQUKCrCITtB5JsnIKAQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxadpr661-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a351686c17so40406985ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769443191; x=1770047991; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=88ZRcFWEjU7GAijgqs6gguWeFMOjZ8mDyjSpg1LVvnQ=;
 b=CmwRYcTK2BdOEQoJnYpMmLOvbRFKNhMG279fcckijITK8INatUL3u2On0EiriNqJXy
 A598TnkrHAJs+C2iexTRdJHWeb6JT5zdBU29Ls8e8lVra17PZWrgBFWz8ftw3mn4G8HW
 GnIIdwFg0tclO1iQlnXkcmdhvlOCjSs2dXBNLa69Nh4v6TSdh3UXk1F/qbHGdOUX7puq
 fGDI9oMssMajxyncZbNVlU+HNUpMRq51uTx8ttw6pTN7LIubNFNmavvzXLxIhY9zScGn
 czAfrFNV8pQFuFOr8WxH+usOi6KOio9kwHjcdiFvEjl7CRj+O8RDOtQMtPLJ9DTwx0Pl
 ISjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443191; x=1770047991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=88ZRcFWEjU7GAijgqs6gguWeFMOjZ8mDyjSpg1LVvnQ=;
 b=f8rlq6dw32TS+WJVD9htBRpPpHTBT1+iqJ0Wrg3fcN7idOxZ3Ie6Civ5a83xdEVx5+
 4LWpsNyIa1WuRxxI7zwEhTaDZSAwGyC2JDc9qNpN+F2CvLFRSPhT7c5qEBxCNLS5Oel+
 kSlUatddAjGysad3kNo4QMhcNcXRobdSi7whDqZmO5u0ARCDWARz+CXIdN8XBimGqbfl
 eFH6127iBBNN851iiAXfsmOPA/8HCn9589CqNs+bhcldVBPKIIqDQovC/1mpxpRaq9BZ
 LK2oPTX9zkK/d80k1uMQqamXeTzb5/M7TB2Jui2HYdQL3qbgYQ4uBnmn3dMzwBf1QFh4
 Ye+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP4gldEU3WzCuIUac2UGbQnN1/TIsnjp+n5kaDwkq4bk0vpSxhseXES18V1gCQtzfyCFxVBxY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/Iimt7XhRJAQGdAD0TDTGQ8NW7VB0aKqNWkRMKNXPltNvcbbd
 T/USsnEIrnaRwsiinGha6kYVjqLnKNvfN/aDPuwYxesZ1CfLfhTzloScphKSv8eEcn99AD4XmyN
 D4Nq4mfr4kxgqmHL9kxruu2Y6/jBpXiPpei23mHl0h8TW4Tj30VbKnRs2
X-Gm-Gg: AZuq6aK4HxJ9lhUpPCyPiJbqCBHZsmj7oHL6LVtvUHwRHp1u7w7naGYXVkEw8eYOAz5
 +7oemJ5z3TBW0tq828UZnfcnxX4bW3DZ6Pm9y0a65XXMRxiRJZHSU4P7Hq9bcqxWaw5485tKIa1
 DHh+HE4kuRSDlwmeq6TKWzQW6OJixOf9AYG9iepIOHSroJH5G1ALYLYd/hMltaBdQENKGpTB+Ll
 OMWbTchb1QM8rEMQ00UtPjj8no4ATfHqyMBDAS/cfZeYyBDSYDc0u4Wsm9NL4Z8gfuvtmg7EW0f
 dvXc1wuY9s7Mn/GgAvqbfEH6BW1XOtLFFZIESZi99w2QFh9IQLp7VP+cGUKWU8mu/ZT7dTwRg04
 QtiFjtzUI5emYP/WPCwTRckQj7VL6zE0jJisGcl3xAEWIy4Vxf6xO7E/wk8d5I9NkLCiOeBgJn/
 intNr+kuHCMbA/u5zA3wUGjZ/X/lKJqwNijMGquw==
X-Received: by 2002:a17:902:f64b:b0:299:e215:f62d with SMTP id
 d9443c01a7336-2a845226363mr50243785ad.5.1769443190649; 
 Mon, 26 Jan 2026 07:59:50 -0800 (PST)
X-Received: by 2002:a17:902:f64b:b0:299:e215:f62d with SMTP id
 d9443c01a7336-2a845226363mr50243565ad.5.1769443190149; 
 Mon, 26 Jan 2026 07:59:50 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm93245505ad.90.2026.01.26.07.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:59:49 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/3] clk: qcom: Add QCS615 SDCC clock support and RPMH-CLK
 compatibility
Date: Mon, 26 Jan 2026 21:29:36 +0530
Message-Id: <20260126155938.2717540-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -x2I3NfpXnll6aoLLqJq6_uLUZk4yKnu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX9Hjy90s8v8B2
 EXu8IiWYKLhWUwCxu5tb/8ztcuySR3jEl62jiOXEAJ/rYiZKOpWg8XKPAkuCBCpK3dfI9DKEcmq
 fbkQUD1tMr8Id57b6KFn5GJ0yz8nbNTDM1946yJr0sniQmfPXxhs7VsgD+ZhmshvIeHW2XVatUu
 sbHj9CmOVao7fgG4+g6ek06i5KAnHuB1YY8L1no2X2OTWJhHN+ZhqQYnm1SW2AIOgQVPVLpHcmu
 qpYtvSf6Tz4L9rYqZjUk5XwHrKPYJxCqrgeXkHk0bmTgiy2NLzlGlcenMIdumQVydAblqsfJfuM
 d9ZVv9UAK8DQGGuxfgMWF12TFmMrlNdA+sim/ruk8O3GsEPuZBf0gsEUEJ2S1Iq7S+K2pZc0SYX
 j6iVHJ57VJy4aulcdRGYt1feyIUlPMe9YVJrP9pEkUnRnP+PbmOS37S8J5LSwG97CSNNRt8UBXt
 2mzNWWZygru/RCjnSbA==
X-Authority-Analysis: v=2.4 cv=GvdPO01C c=1 sm=1 tr=0 ts=69778f77 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NtDLkoeqyif-_yi8tQ8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: -x2I3NfpXnll6aoLLqJq6_uLUZk4yKnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260136
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

Add SDCC (SD Card Controller) clock support for QCS615 platform to
enable eMMC functionality. This includes adding SDCC1 and SDCC2 clock
gates, implementing SDCC1 apps clock rate configuration
and adding QCS615 RPMH clock compatibility to the stub
driver to handle device tree clock controller references.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c          |  2 +-
 drivers/clk/qcom/clock-qcom.h   |  1 +
 drivers/clk/qcom/clock-qcs615.c | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 117266ac778..1bc749e47b3 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
@@ -69,4 +70,3 @@ U_BOOT_DRIVER(clk_stub) = {
 	.of_match = stub_clk_ids,
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
-
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d8536..bc7e0453cba 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -14,6 +14,7 @@
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
+#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..483642531ef 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -18,6 +18,7 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
+#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
 
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
@@ -52,6 +53,10 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				 1, CFG_CLK_SRC_GPLL6_OUT_MAIN);
+		return rate;
 	default:
 		return 0;
 	}
@@ -66,6 +71,11 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
-- 
2.34.1

