Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58560D68BE2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C0B83C54;
	Thu, 18 Dec 2025 07:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HBS/dSTC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Acs5jc4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB6E83C8C; Thu, 18 Dec 2025 07:16:17 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5815D83B55
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YiO53717103
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FUlB4ggavQv
 7d+/MWOxCmq31vHT/VJEabCgfxQ3qG90=; b=HBS/dSTCexzKBg58TvMB3fGwLXm
 vk4fwE1jLCnl3F0rr9s3DCT0fx86eRc1CLSfWfakMhgu9/VxQaRSRavWVMddAQW8
 uMmeqd6mloIxHx2TVxMI3bnqV4uYWqY1TTld1C5HUr7izSknqMhShghnRXjmBGz8
 nmHSut144xAhZlGpMdbcodY3cPOjBwIw5X5qetMfZfcErHPBqA9w5Odo+Lx+3EOV
 GHmnG0A2VX6xJIGSLCMmNIm0cxiOu6L2G5ZA3FdgSq2cNYVXmjn37H0ZMqKIpj+a
 gDhdJ3viLd+sFnVZ86DMD/grqA5Aghax4s6WU3RpO/6giDFuGLyIaKjS5Ow==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79yb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b993eb2701bso353573a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038573; x=1766643373; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUlB4ggavQv7d+/MWOxCmq31vHT/VJEabCgfxQ3qG90=;
 b=Acs5jc4zk+OpM+v3eTSMXWjwX89NO2/vtEgMfpDpJ6+TYlh8brtAQ/kjluPtNUekGz
 Sa0xeBE/FmF6QbTwQmGDQPXPJQeC1PnldbZwgVtpM+ODUzXnyHj7p0asEmFh9HtmkAaH
 rjufgT+hE+YqzRerrt/wNgf2yxa6ZE5sQq8DoPWmzJnTabtY7bhPew8N9fkwaUPDfswf
 MeEdvxulaXhJvv3CMBuVYWedCJOBnnWkBpIDLudrFE6+2xAzf1kO4+0VbL1afy09Zz/W
 Yt3JrIsPitwVtcaNvNiUu9GKJjYaElZ8N1ReZMt3m/JaWWfaKUxo70kSvodcW3MzFdBr
 TVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038573; x=1766643373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUlB4ggavQv7d+/MWOxCmq31vHT/VJEabCgfxQ3qG90=;
 b=jGFFMJVTkmMwQzONZ3cVBVEeppHr+f4ThAx6L1qtrrlkPJVrZYup2PdW7DiH/sfrBN
 oK7vvPMuzLy0R4OEAXsNzxy43g3v9a7SAIbkchiAu+lUyTp0oUd0VQXt1q0CR5jtyWe/
 WebnVOD8iA15j6o+VJmgMGMrm14DvcyfcDEqXP1GOhlYXXjgTYj7jW1lX59GVl4Cc1uK
 Gkf95Ge8ZSExa8AsE0Uy0DaHYmB6pC2RAX7ZL+tNLBhZj0gnObHwkEcSYnFFnSjN916g
 yu1UQ/hb2Pk348QXHRIx4fM4IwnS1KGIexB6X0pb3CZDTIj8dUQTtDWZr1C5+5oD4AMQ
 r4bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHO4guTIvU3/Xkz8yuR7csfYNlwl4VycBebyKONXJKVoBQjZN/14nSFaGp/EzFbKDfj9b2USw=@lists.denx.de
X-Gm-Message-State: AOJu0YxfzXI6pdxBgqBthuiKSVk4ldX0MZxoyqPLDVsVc5aVr2nQ2FR3
 TOLMhMpsbtOgG87hJv2gMARhfUauRF3FUm5nTTOrs/Z2hhxwdu8rO471HTnht5JkNzRGPuRVN7O
 g6SWAPeNm76bGvxipHf6v553c53wMcTmoI5PuF2ou+5hx48NE82vPNJOW
X-Gm-Gg: AY/fxX48yk39pSXZAf58UFFkBzHPt1eu93Vx2njyXoxTa5Us6J4Hl/ufIv5p6kXhSbY
 7o8qwH6wS/xeyWNQ8pZRd9AsOntSNYHYpnum0jGRkKfn67kgqCdRlVY+Vwmla27952jujmGcThz
 vDAduhFw8ZZa++/zw1wsjseYbgJf347oTOBRmqTANvFaYH1+A6OhIVQcJOaW3Pg4fFZbtteUKdN
 m0WFDg/G2z3BYaU65WB14oOXYkEsqq2otR3hMll+FXrBRGNH50VD7ZPxF0vwYjm1wbtcY/d4NV4
 /8ymn8JmMDege2D8+wgaUhzrcKQrPCAkAj74or/ndXhoG6PRR8LM/hyu06tqoRXbHTfUnwxmICc
 FDWtAFI7rribxIQfWk1o8KERMDmGgocnhRtdyXAosqlFczJdeOMn7A8RJjuK9AVDMm9yhQrsLz6
 WZjAuy2yHtq7Pk9DSGs0oIQbahLjkUR/ehwruZYFo=
X-Received: by 2002:a05:6a20:548d:b0:34e:cc0a:40b2 with SMTP id
 adf61e73a8af0-369adfb4e79mr19976215637.30.1766038572700; 
 Wed, 17 Dec 2025 22:16:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRAkACv8qlzcqCARPxEOj6QTDQD1cRXrmSQOEJyTy0NoHogxE/72Q0B4SptyWR3tlInsDwmw==
X-Received: by 2002:a05:6a20:548d:b0:34e:cc0a:40b2 with SMTP id
 adf61e73a8af0-369adfb4e79mr19976190637.30.1766038572214; 
 Wed, 17 Dec 2025 22:16:12 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:11 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 1/6] clk/qcom: Add USB related clocks for IPQ9574
Date: Thu, 18 Dec 2025 11:45:52 +0530
Message-Id: <20251218061557.1999367-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bJ0FVfpgbDPbjHbI1mklkXi9192_mWcz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX0K7t5G7V18EI
 DordHmTWtp8jp7IxCcGil/wMYkeZmgf1aHEpvMQy+W0GO60etzCUSFScOw1vfDC33ym347STuTm
 g/1yUKNrFqEjr/dxmQMGh0LoPvtb/gOXiwuN59fgHNhEAv/9dcRZEjoRdtjIHqp3Cz68CWt3LWp
 s6cfYZ7ljWlEXDEI077YVV8nkOlgb8CcWNLl+p5NaqUpu36XQvN6LqbhLBQ+YQtDS+zplIGka0C
 +X4PBwqaDY5Y4dBE5+jhnoDzYN7rqC3H4satKGawDMeGJfC7xxqFrXWytHImJSz2JuR+odLFW/9
 hi3793dWgkvqhWNTALyY7ksJ7OvdYRk9QLkY5Ok/j1jxcgkZD2DWc5OIN4Vbr81GsaelmHSQE+Z
 cB8WddlIwuweKxXEepMk0hv67AEVQw==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69439c2d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fbqHkSEcfmD6VvpdCmIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: bJ0FVfpgbDPbjHbI1mklkXi9192_mWcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180049
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

Add the USB controller and phy related clocks.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-ipq9574.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
index b0af4036059..1f5146b29a1 100644
--- a/drivers/clk/qcom/clock-ipq9574.c
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -25,6 +25,9 @@
 #define GCC_SDCC1_AHB_CBCR			0x33034
 #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
 #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
+#define GCC_USB0_MASTER_CMD_RCGR		0x2c004
+#define GCC_USB0_MOCK_UTMI_CMD_RCGR		0x2c02c
+#define GCC_USB0_AUX_CMD_RCGR			0x2C018
 
 static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 {
@@ -39,6 +42,17 @@ static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
 				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
 		return rate;
+	case GCC_USB0_MASTER_CLK:
+		clk_rcg_set_rate(priv->base, GCC_USB0_MASTER_CMD_RCGR,
+				 4, CFG_CLK_SRC_GPLL0);
+		return rate;
+	case GCC_USB0_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_MOCK_UTMI_CMD_RCGR,
+				     0, 0, 0, CFG_CLK_SRC_CXO, 8);
+		return rate;
+	case GCC_USB0_AUX_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_AUX_CMD_RCGR, 0, 0, 0,
+				     CFG_CLK_SRC_CXO, 8);
 	default:
 		return -EINVAL;
 	}
@@ -50,6 +64,14 @@ static const struct gate_clk ipq9574_clks[] = {
 	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
 	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
 	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
+	GATE_CLK(GCC_SNOC_USB_CLK,		0x2e058, 0x00000001),
+	GATE_CLK(GCC_USB0_MASTER_CLK,		0x2c044, 0x00000001),
+	GATE_CLK(GCC_ANOC_USB_AXI_CLK,		0x2e084, 0x00000001),
+	GATE_CLK(GCC_USB0_SLEEP_CLK,		0x2c058, 0x00000001),
+	GATE_CLK(GCC_USB0_MOCK_UTMI_CLK,	0x2c04c, 0x00000001),
+	GATE_CLK(GCC_USB0_PHY_CFG_AHB_CLK,	0x2c05c, 0x00000001),
+	GATE_CLK(GCC_USB0_AUX_CLK,		0x2c048, 0x00000001),
+	GATE_CLK(GCC_USB0_PIPE_CLK,		0x2c054, 0x00000001),
 };
 
 static int ipq9574_enable(struct clk *clk)
@@ -67,6 +89,10 @@ static int ipq9574_enable(struct clk *clk)
 }
 
 static const struct qcom_reset_map ipq9574_gcc_resets[] = {
+	[GCC_USB_BCR] = { 0x2c000 },
+	[GCC_QUSB2_0_PHY_BCR] = { 0x2c068 },
+	[GCC_USB0_PHY_BCR] = {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR] = {0x2c070, 0},
 	[GCC_SDCC_BCR] = { 0x33000 },
 };
 
@@ -75,6 +101,8 @@ static struct msm_clk_data ipq9574_gcc_data = {
 	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
 	.enable = ipq9574_enable,
 	.set_rate = ipq9574_set_rate,
+	.clks = ipq9574_clks,
+	.num_clks = ARRAY_SIZE(ipq9574_clks),
 };
 
 static const struct udevice_id gcc_ipq9574_of_match[] = {
-- 
2.34.1

