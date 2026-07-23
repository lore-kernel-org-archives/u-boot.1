Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD692C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 06:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 156016071A;
	Thu, 23 Jul 2026 06:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdKWmwA_QeL3; Thu, 23 Jul 2026 06:40:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5156360758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784788802;
	bh=GoA/8VJ+ZRRPBrg4zu6M4QiDekSTLcJTXxFzrIeKQ1g=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=G+H5sMpnzPBxY+CaOqBVnkNOrRusmh1wRr8OgtRJsCiXgDbXejwxcAXXFgpZuanLN
	 Bd8L8EQ3zsAY/lXAlfHGnV8jXlNXSZqCbogsIlQMZ4DMkfO9Lq2p9xoBkUCEOahlHM
	 mrcgJfPAJy/CsyPtSuNP8crzjz1eueMJSQ6vaA7ZmDPQ2NVfl8TxTfGXNy9sAl0i9l
	 tu1yqmwE4/BdtVBYZRRWoMkq7RqgjbaAUSFf3A0fZbmg/Ut9ygMpAHHWXo8GXcQbhL
	 FvD4Dzvto5GNYRHTGCOlfSoQ9lAHWpzj93az5EDuuPtQpYI6QVjgrhtb7fhvLq/+wi
	 9qS8fbLVbXhZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5156360758;
	Thu, 23 Jul 2026 06:40:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 927F03B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9067A407B7
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPzjnbmC8d1x for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 06:39:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 75DC3407B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75DC3407B4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75DC3407B4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6Aaqg3016553
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:58 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2vy9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb835525b10so523182a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 23:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784788797; x=1785393597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GoA/8VJ+ZRRPBrg4zu6M4QiDekSTLcJTXxFzrIeKQ1g=;
 b=Q0iBjMOfkH+/PrLRB/UCFKYTnLLIR0Lw6yEaFmR8/rx6u2WMQwjxIC/qYi9zicqIXw
 Jlhfa1mX1ELa/4LOmEASHqbqsZ5zOsXPeCHtItWiBewWtLfRi3TUMCEKZ5s7aGX9o2mp
 aC6zKRVtvT8QLg1T0uLAO5MdB6FLyCRADJHzAMOW/tIBKnUmiplZPr5/+rSEkCD9ZtCv
 VUyk1bD9maOJUkSg6wcdU6ZISyW7tlaaSHsvzOUyHYEJwhf78dupBVzBRip9BNm4uC4Z
 kY3aH+BRip1HONKNIEapj4Qb+K46JrQujJcWk04nJ4roNHY9AwY1tyhXYSH/QDkoI5Rd
 AkqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAG5kLA0tNYiITeXq7Vj6JwCchbSAT1m6yt6b09KMnhhe/RCJLrNyUWiEv6JxAAOHNTVvoXL8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwSXjk2mNRGEhJ4f+CChRyz+J5EwdzhH8OYJhdpT0cmxGD17oI4
 ygr6qwhBODY/uvjMYx210MklmIaBlCWvTJNZLs8Q1i5p3ODriSyJBOtjADjsRsA0IdSi/Mv1CEm
 C39jxKs57X/e38Lx3EUzKDxFLZCVh0l28COuNIYik1FFsEgJBM9vu4OME9IxdamdzkVjjxG4=
X-Gm-Gg: AR+sD11aooSWHkbytFo+PTbVy6n+OgKobYexKremmqMKBHZ7X2p2VNYMo9qJuUqUog7
 OUoPVLPexW8At1PnX60wIgwWAudtl2MxwvXJZyAh3q/34FjpglFGtMCGF8o2l79istq0wGSCwDW
 Bp2MxYDc3O7LFPceEybD2zFqxsPbcydVaV4G8F7fYzcHlXIA/JEso564d/Q1RJHA2+VGkHU0qS4
 NQO/O7C+FkFlwxZZyst8hO+MyvvP1eKmnB6558Nd010Wb3O84Izi8V91+kJg/9uZjRyfqOVamHg
 YYgH7WIMOls/R6Qe7OlBegj/2SgEzCJzB1cQ60bccbGo/D8pXAcxFnkj122R+A6eGr9nFUIXL/l
 SLq8FmkeoPw1DmAMixfNRzcXfD4rUfpeID4xPyBmOmrdffjBG+76iC5Bjs7reFDwaQ6BFTdytIH
 gnrX9Q80y9UwBO+f/Zj5+jUOZz/PUH
X-Received: by 2002:a05:6a21:138f:b0:3c4:46ca:3347 with SMTP id
 adf61e73a8af0-3c44afaaaafmr1859299637.2.1784788797142; 
 Wed, 22 Jul 2026 23:39:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:138f:b0:3c4:46ca:3347 with SMTP id
 adf61e73a8af0-3c44afaaaafmr1859284637.2.1784788796712; 
 Wed, 22 Jul 2026 23:39:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm17496758eec.9.2026.07.22.23.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 23:39:56 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:09:46 +0530
Subject: [PATCH 1/3] clk: qcom: sa8775p: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com>
References: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
In-Reply-To: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784788788; l=3459;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=qCkHuabB80rwtMjpumORMlKwVa0kUNR0gH2YKfVyLSM=;
 b=8jncOIsLAxsN+/NLnAA0ywFdN4WaInr1dlvMdhGzWbK+maFfKbKUbrOJygzOSBNAec2hnD7AR
 foEsAMnDx9oAiqge3orizQ89bZ4wH3oOrxOc7+1DHRba8WzLmb03shG
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfX83Aw2kEs0Utn
 e3a3PZ5bQrp86mVRGk8Z1txRSWaEQxNj5NhrtE/Xitk0KuSJEg9LUSq2iYkLrzag2cMGXW1/ANe
 2AhpIQun1qGOztV5/4dTp9vhV2tYK5oaHfPNbKiLT5ao9m7MearC3WgQAbg/iYxWb7McA5JqS2p
 +AyzUky9P7vC7mTGSEaJj0BHIBYFAojBsXdGJHZSwbMXl/cpgeV4R7N21h6SW67HuFN1BxEq8Hp
 iFAsuBPHLAYCSadvXb3HudzKz6ycOlIeutCrXZ3L0NckXXVnOX8pvvh+W7ZLNhk4ksRLHlpJ8GI
 amxptjV+toWcDZBfJMkhz9WCISzISPAH9v8nhGZDHY/2bvKv79uvW/AI1najSQ8Kx46+98Z0JrD
 qWtYBllOB1z05SGh6lYY+ITafKExljP7HTmq1REWUlmGyla97Kcqfj458NpOzLMbFYvBADzLP7f
 HIuvaf0mSprnBIsRcWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfX6j4+OrJj2dnG
 3Q7F9Z5suzQ3jZRUBGjTOTgJt4Wqy71pH0RhRuDnjFyhYb4GSHeTSaXSxyL3zrBdWwI9gltZJdb
 68q8mtezo16OlqJmf+wpIMmVuhXXPpk=
X-Proofpoint-GUID: ES1C0_uuk5wIuO7mvs8sx8vOiG6P43vj
X-Proofpoint-ORIG-GUID: ES1C0_uuk5wIuO7mvs8sx8vOiG6P43vj
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a61b73e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tttIFNwfO6LVqVDfAMoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230065
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GoA/8VJ+ZRRPBrg4zu6M4QiDekSTLcJTXxFzrIeKQ1g=; b=IXUm6W/2PVee8dEa
 rikJZzr8k4PGLiqat8HwmVoRXs+T95JoFNEaZqDTfmNCwc5/sm6pLRshEPnANPMX
 XEQAuii3TaJ9yCf4G7rrorYV0+Kk8ZCTkVCAyV1lQ46Zv1FU0fTCDH1ZuLFwt3j5
 aUO3hjAzZg6toWlol39rEv7+IBa9EnnjHWeMCk28bXQOyZfXgQzoRM5Jbd9VSvCB
 8XHwzOYH9vKlyDkIZgAwKW4JLOcPMF/+B9p0j/cu7AcQ/9z0DjI6+zBv2y/rfNvL
 ePBBnEobNRcZKyO62BKbfyWnBOklB6NBYYOBPLtfxAm1/7vuuYRubminpVdbIv+4
 dAMR1w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784788797; x=1785393597;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GoA/8VJ+ZRRPBrg4zu6M4QiDekSTLcJTXxFzrIeKQ1g=;
 b=DPsPfXR6bAfLeRehYoUa+3NbCXd/fLDBPMvPT6o5DG3FLqURCuvyGfXCQUoA73MBAX
 HFMhXY/qfErShpdT3p/i4a5RGArYxv8YkpPV/WGQIfiEgbhIw/kpUBuUExdDRvZ+h5IX
 KqoXBPtGr58mQ6SF84UgkMco8tkpSiujVJVyDvbIsitXT3kOcARQ1QVKDeQh2XsUk4IJ
 mBWZV52KiUwTq86XuT7sfDI7APRXFGQMMYL5W8yUKqoYVU5VWYaQnE0n2gf4QqGtQALO
 Rx2ThgEnHlE3VOsQSzgD42MiddjRyf8MtQVi4X1WG/cd5h5rCff0SEG75bqDjm8nYTxf
 M2eg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IXUm6W/2; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DPsPfXR6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Convert the USB3 and UFS PHY reference clocks in the sa8775p gate
clock table from GATE_CLK() to GATE_CLK_POLLED(), so their enable
status is polled against the per-clock CBCR register instead of
assuming the enable write completed immediately.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae48..c36b480b300 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -118,14 +118,14 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk sa8775p_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, 1),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0), 0x1b064),
 
 	/* QUP Wrapper 0 clocks */
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
@@ -157,18 +157,18 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
 
 	/* UFS PHY clocks */
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
-	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, 1),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, 1),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, 1),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, 1),
-	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, 1),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
+	GATE_CLK_POLLED(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0), 0x83024),
+	GATE_CLK_POLLED(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0), 0x83028),
+	GATE_CLK_POLLED(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0), 0x830c0),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
 
 	/* EDP reference clock (used by UFS PHY) */
-	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
+	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
 };
 
 static int sa8775p_enable(struct clk *clk)

-- 
2.34.1

