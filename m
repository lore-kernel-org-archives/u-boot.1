Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5ED68BE2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B26883C91;
	Thu, 18 Dec 2025 07:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jr9fzWoG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmNVPhl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6053283B55; Thu, 18 Dec 2025 07:16:21 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0D183C91
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YYhJ680548
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U2YWv8OFU54
 LvuTK0ssI/s6hJMKJB/n1/FZrMtpaFxE=; b=Jr9fzWoG3BMdHNcTpc/R0Y23ksw
 Sw3CQo3IOr5SQsAqFgn5p78yDSSgpruKETDcu9nKUszgHufGhY1S2OWqPTHFJ7B3
 K29wIDDHLPmUKDW1mtZEhb5B5nhx9wv71cJ2JLg38+oiIaVxOVHHJGuXfRzY4zrC
 4fY0gIhtYbii7rm7lS8RD2UoYqaElrNMLlSTZU9mPARar+SHScNXK/WUlII3gBDI
 5G9coh4II9YVC+KiFnCblNz2tgYgUsDy0/mp7WphCP5NV6311wZfc4laqF3306F4
 I9VPrvFRT3UEaHPMAOGYRCSRyib+dK6XO/3g/8MZ/mh+kMuIE9KzRbCxKpw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhh2ph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c1d27c65670so343744a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038577; x=1766643377; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2YWv8OFU54LvuTK0ssI/s6hJMKJB/n1/FZrMtpaFxE=;
 b=PmNVPhl18y3skCJ60/m7DuTMknLC3nD83YX1ItEIKrywtGUWvS/Ba0XAR0H54s3JTo
 HHAgsnvdeZO8S5TL2V8yGyruPFvOwkWL49a7ItR9HURUZClQGu6OvDXse0VFGRZ8npw7
 thYxvmxNf6SqdZlbGKQ/G8E8LurmXb05vRYYG92nbNIeGowccDql1tezNogdvHQQYTfI
 qxd0AMcKzX3UsfCqc4FKojf+CuJbJtSfUjyeBR66z9yhjWDspYWcTyRw5LmidCuCI7p1
 +7Gi8x9m2ou3cvm5LX82CnyBYOj268lArm7ZnCtkvZvrn8H/vCQXg+o/nTbiHIjr1xT3
 UauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038577; x=1766643377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2YWv8OFU54LvuTK0ssI/s6hJMKJB/n1/FZrMtpaFxE=;
 b=w5YczpEQYYJ2V2I7IfeJDS6Kll0X0p1xPuA0d0Yoz5E4F+G0mDZGICtwhIP7PFCXMi
 5DcOepmFsbsIaaaUXExvV+CC5+JUU6tCotAb79GNkfBGhK2yTvFQN0dBpPLMlxfdaHsP
 ONG/8FYsqk0vekPlPw/7WYvZTKc35rEaZtIOVKnl8fXyJpuTZulSOG5zO8feMCWhePZc
 8PISv5BYWQ7v853mRTMVUPZvedGQePEoSwseJ1HnKpK90EtId+0u/yWP4gSzHZlPfPXI
 +zfrlK077cTo9kX4BwOJazS9wgSIZSCymE2ngQSci4aGKkvg5KWzoD1DEi+UEHFjruIE
 PRwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPghsJQE2Mk344Wk6WtZRgiIVtvcpvCyd/o4n5/IK4sSLmtktSBcM1RCObkqePbFmnCqAe0J0=@lists.denx.de
X-Gm-Message-State: AOJu0YyjgKMNe4WTSgqWpqCMlTEO3fahmPHdeCMkrJgCiRINB6GnS/+5
 g6PkSwrCCzJb7wRPjOH1jBJ8X1kc9dn6ouCtp/HsTbxAXSsO9tRLRtl1CMGrNIRJKwOhgIZEcQg
 lFj1NQ1Sw7wB40He9AiLGHyPVXMJrX8+CjRla8vQjZ0eGZinvc3NhttIx
X-Gm-Gg: AY/fxX69eS+fX6hnlOjnA6MZLo1XX5Wm1V09n5dMMb+C67lNNUMKm94m1E9hfS1yTAH
 Ztl75EoR1DjqQmO9Xdwcl96Yh5MJM87VTK1/1QQwEjWRz0NHMwccqHV8SwMj4SKTXACUoJftNvx
 gzKNnQMyBG1AKcW3Rbokx0JR/fwK+L7p6N75HpxhVDFtg8aO78O8gGascj006YG9CfEnWeO9HAg
 taRgaQT6GtNbKgcWPSL7BFFvUhwueDdPi9eb1JfCAnTKlutEp7+1AHOYBL2ZaIdA5bYhNWjzLEU
 gx3I1FU1U9b8kOseDY3J7NOvHrsdVHNP0iC1jLhNgVNqZv+kaTvC34NDoGMGqLIO1Q1HlJTD7ZI
 E8hN56g4Hs/AMd/UGUSiIfv1nPIkxo0t+R7h7zdsw8J8WtK20HmsHMLjUHqksJVOA2G3FkrJRGJ
 Oi7h1r4HXOgAhC1LcMDkjO2PRxtEX6EhRNfM+e0UE=
X-Received: by 2002:a05:6a20:72a2:b0:34f:66ca:60aa with SMTP id
 adf61e73a8af0-375526a80acmr1899519637.6.1766038576636; 
 Wed, 17 Dec 2025 22:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG63k1soPYvPH9NU+4hYfodShrXpnWcQ8x8HZNCaMuwataV5BNmm/LhQ+HPpW6bvlT9gXGrWA==
X-Received: by 2002:a05:6a20:72a2:b0:34f:66ca:60aa with SMTP id
 adf61e73a8af0-375526a80acmr1899495637.6.1766038576132; 
 Wed, 17 Dec 2025 22:16:16 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:15 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 2/6] phy: Add IPQ9574 support to Qualcomm QUSB2 phy
Date: Thu, 18 Dec 2025 11:45:53 +0530
Message-Id: <20251218061557.1999367-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1nnkcE1MjmhqLHOfxUk_GFtbTifJL8ue
X-Proofpoint-ORIG-GUID: 1nnkcE1MjmhqLHOfxUk_GFtbTifJL8ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX2cypUZqCbMCr
 2XSQXeqvb39fl7t7DSSU51Fz8G+XpBoHIHECSA9x+LUfwtBvRZBIBHpwIXq25HmfceA9cywW0yJ
 r+TLhhR246SmFy+x/0kaV7IOFYu+vHonvC2W18mjcWbICX+EHsDnJfQEp4+n7V05MnmHmqMwcTG
 cjZQmpHzomikUzaAWGXE+jsyayQRiKJp6cjB81Jq+c8pEoGy/WpAYWNgLWI68vzz90Thdrqpdbj
 zkdmsmrssZCFYNjEZ4U2eGJJWKmsKrQxUcgjJ2eee4vQQme77S1WDDRUWt28vLdkuPBsaxrdppD
 tyHfk4JX0EEWntT9u5BSsL/TuIhwUAoZwAtrXAriLR75IlQDVaqek9FH6QxIOBeOsyRR5A5Hbdp
 xUQNIDCkagrufamQ4fy0JHwYCsCrfg==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=69439c31 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DMCfjGVwcRlt5hAF4XwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180049
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

Imported from Linux driver.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index d98f6108e69..df82f2a99da 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -152,6 +152,22 @@ enum qusb2phy_reg_layout {
 		.offset = o, .val = v, .in_layout = 1, \
 	}
 
+static const struct qusb2_phy_init_tbl ipq6018_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL, 0x14),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xF8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xB3),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xC0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x00),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TEST, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9F),
+};
+
 static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
@@ -168,6 +184,19 @@ static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
+static const unsigned int ipq6018_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS]		= 0x38,
+	[QUSB2PHY_PORT_TUNE1]		= 0x80,
+	[QUSB2PHY_PORT_TUNE2]		= 0x84,
+	[QUSB2PHY_PORT_TUNE3]		= 0x88,
+	[QUSB2PHY_PORT_TUNE4]		= 0x8C,
+	[QUSB2PHY_PORT_TUNE5]		= 0x90,
+	[QUSB2PHY_PORT_TEST1]		= 0x98,
+	[QUSB2PHY_PORT_TEST2]		= 0x9C,
+	[QUSB2PHY_PORT_POWERDOWN]	= 0xB4,
+	[QUSB2PHY_INTR_CTRL]		= 0xBC,
+};
+
 static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PLL_STATUS] = 0x38,	  [QUSB2PHY_PORT_TUNE1] = 0x80,
 	[QUSB2PHY_PORT_TUNE2] = 0x84,	  [QUSB2PHY_PORT_TUNE3] = 0x88,
@@ -224,6 +253,17 @@ static const unsigned int qusb2_v2_regs_layout[] = {
 	[QUSB2PHY_INTR_CTRL] = 0x230,
 };
 
+static const struct qusb2_phy_cfg ipq6018_phy_cfg = {
+	.tbl            = ipq6018_init_tbl,
+	.tbl_num        = ARRAY_SIZE(ipq6018_init_tbl),
+	.regs           = ipq6018_regs_layout,
+
+	.disable_ctrl   = POWER_DOWN,
+	.mask_core_ready = PLL_LOCKED,
+	/* autoresume not used */
+	.autoresume_en   = BIT(0),
+};
+
 static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 	.tbl = sm6115_init_tbl,
 	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
@@ -455,6 +495,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
+	{ .compatible = "qcom,ipq9574-qusb2-phy",
+	  .data = (ulong)&ipq6018_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
-- 
2.34.1

