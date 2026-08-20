Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC7C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 05:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F78B80C27;
	Thu, 20 Aug 2026 05:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6l1gYYpeT0m; Thu, 20 Aug 2026 05:08:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787202520;
	bh=Hiv1Lkm3ytZ2SKDcRsA3SBGdEoHqFNt66U3h+JC9Ph8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZebJ32DqHFWDDAX7n2fz4PubsDiuCMvkAyEvRhwhfbA6ZAQjUJm08AaiRdPjZUZSl
	 stWQHOG56ggR8OI3vEVWBOJQ/Z3yCEJcuk88auOOqLOlmH6+9NIbMIy7noAGEaQgbE
	 k8jrTawbWzwvPILS0KFeC3LBIPrq/yKANUD3YoKILVCX+KjVsnK4gVb2D+u2SnCiJd
	 nUIFVOGRZVo/N+ZgK8AJeaZYFH5OA/yVVxI2aOaKvgZpPN4zJAmLvMxV8ZUwz+c523
	 UoQ/KsqXhdU/DhRzWZxHHmZovWFcQ4hraku7tiwKuOtsmU0q2dn7Q+5AQ4dtw4zCuI
	 1FCeIAsYmkHSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7887680C1C;
	Thu, 20 Aug 2026 05:08:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C33D39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DFBB60671
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-qC0_OsQOd9 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 05:08:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jUR8eZwj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jSMdZuPD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C78260675
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7RXa2491795
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hiv1Lkm3ytZ2SKDcRsA3SBGdEoHqFNt66U3h+JC9Ph8=; b=jUR8eZwjKbIua3Ka
 f2qRXAGqc+QPQwhdDuEHh343Oi9J1XozSd2qUv/4fzbeBcz8aSW1mapqfkItnS9M
 ijt7TROLOdtspkUlLaOEjPwGrkA+BSRnkAI4sn5ndTFZU3Q7lKuDg6EwZ2G1i7r8
 wrAu26DBT+xYTvceZqeRSE00S2MjG37nvEd3nN4zVr5rZw6Fvtl8ImCMpY0lM3GU
 swndT0GjERjUAKwY/JQxWVzb0hLzBsXz1DaF67cmFxvlY/aVScjBDAUmBUN9jL2A
 YEAEwOEGPsoCPDualIOThntJvhrZWMaHLFIv0OK5Jm5yt6f1OMYuU5GSwa99HAwN
 oeRJlg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83udxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so37224955ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787202516; x=1787807316;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hiv1Lkm3ytZ2SKDcRsA3SBGdEoHqFNt66U3h+JC9Ph8=;
 b=jSMdZuPDcsyWweyfBk90l4Xk6MUAWM7ctU372FePM7RkkGa1aRi78Ni920R4Bpnt2h
 mzDHe2cc4FNzfRn8mxufCget+WpoBM2XEcCc8iH5XmohfH1XBPymAc0KCxB2oe/Pu8kr
 Jj+Fz+bZc2vXQGJ7c1rFfZdzL8Cd0fNaIYoo4DHUH7KgAIRriSsteSJ8fwtYBYnrx6sY
 stvyREdYrQ/YPBKNOXJ6Bgz/gLvS1CvzoWQUkAM0ax7bKwGvix0x5SubcV4zcSOwQACk
 50CIjSf4oxIyss8fyidFhQo5rbCU94aGX7TFEt311sBhBa6EZxfhrD4rWvc6XDhZrFuH
 WUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787202516; x=1787807316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hiv1Lkm3ytZ2SKDcRsA3SBGdEoHqFNt66U3h+JC9Ph8=;
 b=AKbBdW1nO1Cm/GPGKAq0kEHMjGTV+6XpYPaluPmidJEAfvuVLaiS6jCJiL3OJn/VT3
 OBLHxVdWz5xdSX6ajJ6FVvK+Zmlee2WvozZVgEt1qmYMlQwYlYlw5qQuEduOj94D4FTI
 8vea1x4MqATuoJ702/Z3Lv17abiWo9C5nQPYgucMjquX3B0iyV8rZyGYeiXOv/fqn31O
 /bl7pyqwWKYBfbaJqtLUEgExi9mayuBsD3mKsQQ+2bkvtiHMIRnFJwVrDJLhtcGK7ToR
 j+OmY7aN5NnxY647c/loWPmPHWkFJjn5J3E7OUHBuUGprOmNjDj0Zz16rM9XPJy7iN6w
 xGrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPgDcSIk7uVu90Th9YsT7Z5pRdMnkqYcjPP7xgrHRJLWeDOkezATrQmYxsENO186k0D8/KGGc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l2bLfFm7AJhZtRPcJ3DGTAZoEMbeTPHQvFe6FEMnZjUDSojV1m
 V4qBY8RtqcYNMUQ8nWTZ/3qn9iWSz2HKOL4d8wKMn6icLHyyWeLntJj917nRqazRHvkF7IMaf9I
 MGVbv4nCgPpAa9wVQ1g3iefjkTzrkoK39szzCDJifp9MRoaIrDK1MAKzCeMofKJoHwOGWluM=
X-Gm-Gg: AR+sD11NgTj6wvSNn5uyK1oPmkn8E1rIn/eO7OvD6llBMKhvXp38sTRJamker/d14Gd
 tiAYfcp0roO45NukR4zg67qmQ1/NvXlQ9LoSM/BOwGdTl+une7AoH0RBBu+K2Mz9hYCJktEI3zo
 3v0/OwEOw5DxnPelUsxMW+tvsyJe0AbI+W4iYicXcGjHH0hjhpsvNc/gYI6flIu1ZeYUCgiebYP
 x6F6F5bCbWDabIkUIMlStOwSAqmzIuMf3trevEyUBSro39xDoiu3QUTHSOukua97iF0kvVn1GAv
 8BbbY5BEVKEa0mO7cSlPMp6P6WBU0ZdlV0j3kVFZ7CJIhq6pJbbibm62X30lOTXe0fSviFIHyuW
 HOg53wimqXh6oqUFOzfCxYmjPA3ssjSxqOe9cvo6URwDAoomYeCROVoMQZ7iBT3EInv0Xb74lHf
 tzhCNQSASnhcL4xm2IUZzmd3Oo6HVt
X-Received: by 2002:a17:902:ef43:b0:2d5:e9d5:8ae with SMTP id
 d9443c01a7336-2d5fd62ae4fmr194107855ad.5.1787202515909; 
 Wed, 19 Aug 2026 22:08:35 -0700 (PDT)
X-Received: by 2002:a17:902:ef43:b0:2d5:e9d5:8ae with SMTP id
 d9443c01a7336-2d5fd62ae4fmr194106955ad.5.1787202515448; 
 Wed, 19 Aug 2026 22:08:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm12012395eec.28.2026.08.19.22.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:08:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:38:23 +0530
Subject: [PATCH v2 2/3] clk: qcom: sc7280: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-clk_gate-v2-2-8cd0059c162b@oss.qualcomm.com>
References: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
In-Reply-To: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787202504; l=5142;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=l9wcQtX7j3T8L5c3Wn9WNSV+JJ8xCVrakBa9MAzYiKQ=;
 b=OmF2cSuN3NLA3yJsbdXM1kwZ+nm6mO9F71bLHpVlntcT4wu62x+sbMMoJN7QdBLish8et+pI8
 GPoAqErbT8WBe9keidV+MlWlDlSsfuFGEoKKz+59ryv1EiARVqncIgG
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX5+51Aw+ZCNAB
 +5tN5JdVq99MWaffRttO3msZSVQPAs17KooAkvH5iu8+0MosTMvzK3cTGMqHAmkjC8G+XMPlphj
 2v8AcMcW6qpqHb73jnYD0Wmtw/o4LW4=
X-Proofpoint-GUID: v6xCZT5-D2SKlZL2hp55jnaZPrchj-RT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX2e4aehhDE73e
 /NJbquchA+YgqR5aD6KR/UkzBFY/TC7hmKuVQTFzcTi78GXFGsG5qyZaA6H0DdIAjEJsZIZOpti
 W9VaYGsC+zB87lKgUbbxD5DGBfPtVd9R7CCkCGnTnXxUsS9e6ArMX0GrtHCstCKGDR6YzTp17HW
 vqbObyDqoWd3MSSfB04yodU/+G2RlYcD1AIC3bmwqdN0Fwl/EDDVNKgAIHxcbjwKqGUvQFwPaQa
 Bomh7UX9HeAYHgMquIFhok41zRqEDf2OXWO/vdYwp8vDCmcM53tzRJmGISBQ+uZKUPLeiTRq6l8
 tUJ4KbbbsqljinVQICCRWGv2DQWPZqBKzQRkC9ayotz57ScrE9cWq+I8ZqJL2FdSs4yAvlfExAx
 6WWUf+T0YtuYafHleTXB30tfQWkSBs6/oPcarEe9hNePQ52uQhjRAV24YjRAK6GEiS40IGdpv0R
 XbvBzX0B/NQ6Qr6lVWg==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a868bd4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IV4vSTdVbDuvA_XEI-0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: v6xCZT5-D2SKlZL2hp55jnaZPrchj-RT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200035
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Convert the USB3, UFS, and SDCC gate clocks in the sc7280 gate clock
table from GATE_CLK() to GATE_CLK_POLLED(), so their enable status is
polled against the per-clock CBCR register instead of assuming the
enable write completed immediately.

Leave the PHY-sourced clocks unpolled: the USB3 pipe clock and the UFS
TX/RX symbol clocks are driven by the QMP PHY, not GCC, so their CBCR
only clears CLK_OFF once the PHY is up. Polling them at GCC enable time
would time out.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- keep the USB3 pipe and UFS TX/RX symbol clocks as unpolled GATE_CLK;
  their CBCR only clears CLK_OFF after the QMP PHY starts
---
 drivers/clk/qcom/clock-sc7280.c | 56 +++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 91e3fcc27cb..70b80db6cac 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -160,22 +160,23 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk sc7280_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, 1),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, 1),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
-	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
-	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
-	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
-	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, 1),
-	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, 1),
-	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, 1),
-	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, 1),
-	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x8c004, 1),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0), 0xf07c),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0), 0xf010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, BIT(0), 0xf080),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, BIT(0), 0xf018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, BIT(0), 0xf01c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, BIT(0), 0xf054),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, BIT(0), 0xf058),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, BIT(0)),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, BIT(0), 0x9e07c),
+	GATE_CLK_POLLED(GCC_USB30_SEC_MASTER_CLK, 0x9e010, BIT(0), 0x9e010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, BIT(0), 0x9e080),
+	GATE_CLK_POLLED(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, BIT(0), 0x9e018),
+	GATE_CLK_POLLED(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, BIT(0), 0x9e01c),
+	GATE_CLK_POLLED(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, BIT(0), 0x9e054),
+	GATE_CLK_POLLED(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, BIT(0), 0x9e058),
+	GATE_CLK_POLLED(GCC_PCIE_CLKREF_EN, 0x8c004, BIT(0), 0x8c004),
+
 	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
 	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
 	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
@@ -196,20 +197,21 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, BIT(16)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
 	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, BIT(23)),
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
+
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0), 0x77010),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0), 0x770cc),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0), 0x77018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0), 0x77064),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0), 0x7705c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0), 0x7709c),
 	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, BIT(0)),
-	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
-	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
-	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
-	GATE_CLK(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0)),
-	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0), 0x8c000),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0), 0x14008),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0), 0x14004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0), 0x75004),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0), 0x75008),
 };
 
 static int sc7280_enable(struct clk *clk)

-- 
2.34.1

