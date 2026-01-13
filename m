Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F4D29DC9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9C28389A;
	Tue, 13 Jan 2026 05:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="itYgTOpP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiulPHer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6913F838A5; Tue, 13 Jan 2026 05:22:24 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C61683700
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60CN56og3059081
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 04:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wGje72vT+39kkiHzbtBE+YBEGymXVBtggcH
 JWiqLyZk=; b=itYgTOpP+M7oZKolbXC85ljeUQSLfkToWhABjoGXmnZNHXD+HPF
 zpz+9Ay9hUYtyJOKsVPtiTALjOrDmldMsd7i2igpE2gyfEQFSjo7rdEpVfssOmMY
 eIQUuGhY9Iq62I1JhMvizsuBn43szSTjULvSIGGLEXM8ZgJrVJQl9IgjxMp0t5DP
 NYCZQBSwE3At39m0Aq+sF5JMmYXOwHTa4bZ/CpRG4yfuDYM4/sl+Gwx7+sMUl1D6
 ZeG7B5L/i7kPBMncLISBEDCkd/FLrpKP5M5n6EhkmggjpUuasefMcE/dFNf77AnE
 kg7/zQ3l/MWM0/UwGwB4pztrMpUHEkwyFdw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmxwv30r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 04:22:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c5539b9adbcso5780922a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768278139; x=1768882939; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wGje72vT+39kkiHzbtBE+YBEGymXVBtggcHJWiqLyZk=;
 b=TiulPHerMCdlCjjy9FHMoso4lumQ57woc7M4vyk5YK4dqZK3Ms5aM250iYmHeidOiH
 8iiy57Of3oF6EM3K7iZJrylj/uTUkM1/YNilaLMDhsdC3FURxtSM+StwSJ0cadBotDoQ
 3SilAoVkZC1ExPBaIhE+fTmJDuktqht54lCQSwlKsDK2GWyaV90znMliAXKmYqU7V26X
 pYzhBoD/EaRAL080byyzDr9Z5kno7cGB7cnRXz+ANCPtmjGlqVJPeOyb0VENIyzv6uN/
 TnaglCjTVhwW3e38G6GhITEmaD54w6dyTGQfHgAl5czohKooJ79AN/oZkEvVVhhkBJS/
 8e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768278139; x=1768882939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGje72vT+39kkiHzbtBE+YBEGymXVBtggcHJWiqLyZk=;
 b=uTfJuqsxYYqbuvUAAIbo3gAtByCjDToVmStbCTUTWOel6hEOa1c7tXlY+6EI1b/oZ/
 w+90brh1uOJ4aLuG1/2Q4ZssyGHqVM2P6nh7lVszfyIVPrJWMaUPFrp2IShSHaCDVgqI
 6KLfDLR/07YaG41MGy9RU1DubFdj4XKbhRjC4NIf0ANUDdcE4q1MFKRvCv8dlwvO4Pk8
 eZyO+yCebpLuQde/a36xyNegJrGq5qe9OFrlDTZcK3PcNg1W4kYYRvRsosA719y5UCli
 boWZzRMkndxnDZWIluhXtytW1qHnNScFVzsfilL5nZZAsB9cvs43gmJYb3o5sfI/n5jV
 n7Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe4i8KUPrTJSyivxfRbz2Zry/M+bEEKNfRWAy+O5WMZWC+oPX41ICKmeqLhat/eqqgZ/LpTcs=@lists.denx.de
X-Gm-Message-State: AOJu0YyS6+sA+LD/cyh+Ql5Ikq3+LfliENEG7Le7mcrQ00/1jP9PqbMi
 r7xhtfVsaFqtc80jQWI6Kd8Lk1chwO0MfT6RFW8ms0v+xuk+VYXxJP2kPyF1Lq4SsI2KWl9ZRNL
 bbIhPBbTezjV0snc3UDNq8tJj+7OKFACSrdWEePFM2pvxX4FjOKPI9uuO
X-Gm-Gg: AY/fxX50wtmZ9yS0W0oK4O76dUybHAhbkDTn9RK8+DSXTf8ILY/4w12e1VIB8AumdQ2
 X9+/8p1rMlL/UCkAniTfDnEijTmiDlxMALFbhR9VWBnMYxM5U+z/5MJ7PVbYwGdyJB9MYO3sB7p
 kgYqgUEuvOlNveKJ3HC8eT+Yoc9QxmRm6iNkb/rqY3haC24PhKBXFeui8v27N7qrCoLvyOg70Kf
 EZuN+kZvDA0RYp31Pc4YGsVpeXUW+69gza5o9P3RVawpftTYV72O4dCe0k0rDmm8cbPnYhhaZs+
 oGNVsj84FZcVJ1qAPbmYzs0AteSCeANRNK74TdfgtMlmt1D57zR8KtlYkMUGlmskhm/m862WNl6
 KGxGAr/36KsJF/9faGq4IMsjiMkMz7/Dn/m7ijxgDJGX/BR1TI7fhEMn9JhDIt0U1Ta5DqiRWhD
 ee92nTAVaZbelP1d24yK6LhKQ0+jvzHzLMiJeSsg==
X-Received: by 2002:a05:6a20:7f8a:b0:319:fc6f:8adf with SMTP id
 adf61e73a8af0-3898f8d5d15mr20302374637.12.1768278139392; 
 Mon, 12 Jan 2026 20:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmO4MULqIIKUqbTqLHMlvsSMnbTOtP4rFr62n9G94o8AUZGUJPrFQ6xDZfapA2VklJZOwnwg==
X-Received: by 2002:a05:6a20:7f8a:b0:319:fc6f:8adf with SMTP id
 adf61e73a8af0-3898f8d5d15mr20302351637.12.1768278138897; 
 Mon, 12 Jan 2026 20:22:18 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm18429694a12.10.2026.01.12.20.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 20:22:18 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 swathi.tamilselvan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] clk: qcom: sa8775p: Add QUP serial engine clock support
Date: Tue, 13 Jan 2026 09:52:13 +0530
Message-Id: <20260113042213.3107106-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tHl3PLe5W8LP5sHYGFv-TP1PsRgtnm9n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAzMyBTYWx0ZWRfX0mv7Z/IMhwen
 KRRZE/hWW0X9tkILdutoRxO0uk24J+w6RS78LZsqs+BtaeCBI66QhBEINHLncjfcB/n1enbxDAu
 UuYXjoJT4eiuGZM71vt+9x7GSaEcKBzdv/4DOdVlxwn7sEbAnEnIPGlZeq/TrYqwv34sKPcc57b
 tennDPY8RfWHefcmPMViV86yWFzrW8vbd3MpVS1a3aTU1FMVqi90aifeuDzBcutoPz8s8kH8/RR
 yayew5Icnauz0YJMu2o9agfHT5wtJcadFHCeyl/ZGZQTVcTFdj5uEEK5QFgfgcSWi8QBxnvuGiI
 nJPNVsvqMZEX5qq/WI6QdfZEcuI/hltI4kz3vXCyipGF9NpWYd5O2WdIb+nUPsTeT/COsEfV+fL
 +VrM9gMuwaj51gCEcvxReksRM19OYMwebjlPQbq7z6JMMZ5yCPEtUEai+AX8gqUoC+LBwBB3Zuv
 e71VJjLQ/IwPLOOxs9g==
X-Proofpoint-ORIG-GUID: tHl3PLe5W8LP5sHYGFv-TP1PsRgtnm9n
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6965c87c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FmkCMdcgscziCBo2PkkA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130033
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

From: Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>

Add clock gate definitions and entries for QUP (Qualcomm Universal
Peripheral) serial engine clocks across all four wrappers on SA8775P.
This enables proper clock management for I2C, SPI, and UART
peripherals connected to the QUP blocks.

This resolves the "unknown clock ID 133" error for UART10 and
provides complete QUP clock infrastructure for the platform.

Signed-off-by: Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 527cecf5c82..5a6fbd417ff 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -18,6 +18,31 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
 
+#define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
+#define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
+#define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
+#define GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT BIT(13)
+#define GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT BIT(14)
+#define GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT BIT(15)
+
+#define GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT BIT(22)
+#define GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT BIT(23)
+#define GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT BIT(24)
+#define GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT BIT(25)
+#define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
+#define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
+#define GCC_QUPV3_WRAP1_S6_CLK_ENA_BIT BIT(27)
+
+#define GCC_QUPV3_WRAP2_S0_CLK_ENA_BIT BIT(4)
+#define GCC_QUPV3_WRAP2_S1_CLK_ENA_BIT BIT(5)
+#define GCC_QUPV3_WRAP2_S2_CLK_ENA_BIT BIT(6)
+#define GCC_QUPV3_WRAP2_S3_CLK_ENA_BIT BIT(7)
+#define GCC_QUPV3_WRAP2_S4_CLK_ENA_BIT BIT(8)
+#define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
+#define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
+
+#define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -50,6 +75,35 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
+
+	/* QUP Wrapper 0 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT),
+
+	/* QUP Wrapper 1 clocks (includes uart10) */
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT),  /* uart10 */
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, GCC_QUPV3_WRAP1_S6_CLK_ENA_BIT),
+
+	/* QUP Wrapper 2 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK, 0x4b010, GCC_QUPV3_WRAP2_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK, 0x4b010, GCC_QUPV3_WRAP2_S1_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK, 0x4b010, GCC_QUPV3_WRAP2_S2_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK, 0x4b010, GCC_QUPV3_WRAP2_S3_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK, 0x4b010, GCC_QUPV3_WRAP2_S4_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK, 0x4b010, GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
+
+	/* QUP Wrapper 3 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
 };
 
 static int sa8775p_enable(struct clk *clk)
-- 
2.34.1

