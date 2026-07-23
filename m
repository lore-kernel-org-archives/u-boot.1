Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E6C4453E
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 06:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B87D60756;
	Thu, 23 Jul 2026 06:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11lj2ChmpFl3; Thu, 23 Jul 2026 06:40:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FC6160704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784788809;
	bh=VN1yLHpIc75snmG1gGwySbc1v/trvy5NevxtMbzy9/o=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MiTZNemtLKYbjPlkyJwZnLUIu5OxchL1G+NwQKEbsWHSbyRWUzT2jL588gBUTNnhl
	 uDPBt7GBl86Hhd8f+SOaSCpEq6KLa48LtAPwuR/YOzbW8LlNTcyzbEryQFHvKFrv7S
	 pC1VWrGQdISyg70XDdgg8OBrk9HKxPyS0H/wnTZwMhP2jC56wCDCA+QjSxQnzDi6oW
	 /8AAHCl5BBrTYMHjkzujR2TF/xRyFDuuFWio2xHsd9kYuwxBY+hiCz7SUlmY/H0Vhj
	 tiXSFBMdAdb4UW24RazuzhhFoacQqRykwwyIaLur3YQDA6JMAUzBGxoqxR2LOWXa+Y
	 t9qJopOUSy15Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FC6160704;
	Thu, 23 Jul 2026 06:40:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56CF9490
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C26980E26
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IEykF6Q-Di_8 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 06:40:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2975280E25
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2975280E25
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2975280E25
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6Aa2J3016499
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:06 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2vyak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so688823a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 23:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784788805; x=1785393605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VN1yLHpIc75snmG1gGwySbc1v/trvy5NevxtMbzy9/o=;
 b=o+cX3jqbfh8l0YqdcSSnSxqIL1UwEREBOIm36+rYhacDQj5FeSbujUGpswRvcJPYyz
 sy/gz0WGk34exyOvC6KXlsBoYQeIp8Ue26gMHV7fe/owoSIj3Hzmdeg6wAkX7FS5aXbG
 JQYoYbrLAlDohGsWtZ/bkbHkKSmx4td2hh/D/aCJpAGJW3QfOd+KMuk9TgS57lyUIth8
 iY2rDf1qJqELaPWeaJ7XDq4ZBdiu4flJ85quaUtrYw+NOp0QgqdAAC1Me7euWGynfmMY
 THs7MFtWgH5LWVv54K6j55BRqz8YNIYEIH3UaKo8A9nsMSDKAKCPS4Y3W1QxrYvnHhJx
 cAhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1BUdN72ZbWu5ToeqEAM5At2dgz4Fh6V6HrFDEHwRt0No1yNwwB351WIo6/B56/nMXeDvodec=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzaXyNbGrc+Oz1g2iQNysKa50QcRZlat02lwgroVMorC3oYmBVk
 tEO+JxR7Lij7b+nDrepuQy/Oripz71evokNc8QGTTyp46zd2rpuGBkPQ2RZA8voiY1sTe4qpyFI
 0Xu3vHnB40IVzw8TmKpptBbT/NaPIpBPVKFartnLt0n/lx05Not9ZGvGN+PBWDZX0uqqnMEI=
X-Gm-Gg: AR+sD12GSUTiOXUBSKsVNq5Y/cEjZo6QSJfHnqgmBqBt3H+fnhOCM8lr6k/o2c3RUIl
 PJ6eEnCtKDdPoqMlHDJHjL0qaKr3sMDUmyr9Ajh+lGcorpD5tCrXwtb2Mm1+V4w39aopzn1H/cF
 zxlstcz42DD4ZBWivjR0gRy1brn1do0+NoBlq63r3SqHuffVOQGehYysXGE66G/WVvRfRgwxMR9
 ANBciw+cdjE1/r98XCK9Q9yOS0SE1/bIfy4O7sD0Elwg+f9CjlBuJdBl1mIe/OnYwyAi2cfaUHd
 HT6TJyfHYUGckSYcAjJ8lFvRhQd5eZ/clWbq9I6FSTlSEr/2X8Q6iw2z+5Q0CyIivGPV89gDkR6
 DObcXjsYQxDLvYNXe9Akl3i+IoYIwsoWBFySrzuGyZICUjbOw0mnccrJvai66mFEnP57DhgnpCf
 AlWSM82U3WbEBfralh35cjymEwTkfX
X-Received: by 2002:a05:6a21:3394:b0:3c4:1916:9d46 with SMTP id
 adf61e73a8af0-3c44b0218cbmr2328311637.27.1784788804830; 
 Wed, 22 Jul 2026 23:40:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:3394:b0:3c4:1916:9d46 with SMTP id
 adf61e73a8af0-3c44b0218cbmr2328287637.27.1784788804428; 
 Wed, 22 Jul 2026 23:40:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm17496758eec.9.2026.07.22.23.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 23:40:04 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:09:48 +0530
Subject: [PATCH 3/3] clk: qcom: qcs615: use GATE_CLK_POLLED for CBCR-backed
 gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-clk_gate-v1-3-9549cad4d097@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784788788; l=4093;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=IXMJP9ufagsSUCIzhFKWt3UG1+fE5rhNkj1oA74MwKU=;
 b=Ui1G98rrux71oMm+tedof2BpTvwNxsoawM+ICYU1Qmtl/nFQ1CMUWMaC0OP6bhKiR+VWbXqC/
 vk9TOQ+VhtsBovTUVdQgKkB+rQJ8trhvGzXR9yXZO2uhFqYPdUTiZCa
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfXzgv6yVIlzpjz
 Y5+8UQyIURHEjgvTHiucu9h7EAJGQ9IYoxD45f074p1kXXfbDJMNqv500ZFftn3NvojQilQ1N2K
 /dvA8Etx3GBHJp6THCak1qwq+9/qUQHQ/+2oUpn3A8wTg9KgB5fa44mTXmdDiUltzV0FvzuQd/Y
 FfjiPDFS8EfQ1C5WDkPbx1ouQ6I2YQKy4JYAHNwSRi//ul2zlXkG7tFmFlRwAJ3EMG5LlJ6SLKV
 WLp8nyvnQI+4HMmlO9z3dnmNapeVlzSW9d+/c3ago1BlvNTlO4L5aIImGGokky6z1nqLFTUmkPu
 ZKtnoVcpRx48+D63L8/m6MzN4btP+EuTXHV3dW9uufHzYA91Jy/mFe8w+cMoqOXbCS3/gDS25XD
 ty6gub+fwWbMhiEpo5DcVlRw8sDLIIQl3K+YUBP4NEwm7x7JaPN0DJmaB89vqp2C1ZxFiMrBY9k
 WsfZrsbgiXmoSpljexA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfX2EgaimDoGXZC
 heOSROCvtW8RrsbZehrucx4KWJE7QxnD9WT6gzwzuJVd2gJ5+iUATv+PS50teCrMTSD2LaoeJNj
 PpjdZuQdzqQnCPBMhbKNwKvvC6WN7eM=
X-Proofpoint-GUID: 2_OLM89MrjHTX5ywKdl8_YWVhvX36DMj
X-Proofpoint-ORIG-GUID: 2_OLM89MrjHTX5ywKdl8_YWVhvX36DMj
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a61b745 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Tq1YDk_HF2moFU2WsVEA:9 a=QEXdDO2ut3YA:10
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
 VN1yLHpIc75snmG1gGwySbc1v/trvy5NevxtMbzy9/o=; b=Iklskrf1uOiDRKt2
 tCBx3HGOPzi/4EDeicio5+vAtus83LOyLVMcdYO5MNjAcUdq9F+cLD4NfGq9PDFD
 TGuqshA10qNHiECDtWVfZUbssdW0DAohUnvbcrifZkryG5gSHUWQ5/las4U3prxy
 tdcCllMBReV5QF209pu0KlRFVsu3593Ody1r8g5ydOGDzsk14rCPx0DS4TRUK4NP
 /a2ZoQPZBCwI7ZC2eBBQFjGxOqKQ4GfwwMBLvAYEY62vLJHYlRHPXJ0klWwHY3lV
 8UYM6FHc8Xvs3cyGVeaDNMJvWO6sqn8K7lwshQiglhYdS+lxinmVDTkigaHdStfy
 H28wtA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784788805; x=1785393605;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VN1yLHpIc75snmG1gGwySbc1v/trvy5NevxtMbzy9/o=;
 b=jKX7YW2fBf7uPAN0TMNpRjxuLAis3ERI07htEGP+7+NFVxoEoqlWnlKsveG/rNZptF
 hrgUrIc1pSImOpIQ5EUOVgkGX0BrdJKdkrg/1k5kEbYQnSvs6KotcWFl50CF5KKpoo/9
 GFd4UsLPnO6EsE9oQfuPpqQX5Pks9PuP7uFJ/nsT+YXuwoA3tvRTBrRV0Pv6VjYi3Pwx
 KVisB3zzPbpEVnkCp3FTu2tyFjVEmj2ETIxSMV9S37fJuaoVSTgGjtgqzgcnVLyY1emz
 auZYn3N/UT8wK9CB7pNTaoJV9c2f5TaUqnoXcggF4jFsfmz6dvLltc1NWFT4oT6g1+AU
 kg2g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iklskrf1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jKX7YW2f
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

Convert the USB3, display, and UFS PHY gate clocks in the qcs615 gate
clock table from GATE_CLK() to GATE_CLK_POLLED(), so their enable
status is polled against the per-clock CBCR register instead of
assuming the enable write completed immediately.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs615.c | 44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 7b3fe49de9c..4b2f6272625 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -109,16 +109,17 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk qcs615_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0)),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0)),
-	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, BIT(0), 0xf078),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0), 0xf010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0), 0xf07c),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, BIT(0), 0xf014),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, BIT(0), 0xf018),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0), 0xf050),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0), 0xf054),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0), 0xf058),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0), 0x8c014),
+	GATE_CLK_POLLED(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0), 0x6a004),
+
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
@@ -131,18 +132,19 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x5200c, GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
-	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
-	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0)),
+
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0), 0xb038),
+	GATE_CLK_POLLED(GCC_DISP_AHB_CLK, 0xb032, BIT(0), 0xb032),
 	/* UFS clocks */
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770c0, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77014, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x77040, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77044, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0)),
-	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0), 0x77010),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770c0, BIT(0), 0x770c0),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x77014, BIT(0), 0x77014),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x77040, BIT(0), 0x77040),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x77044, BIT(0), 0x77044),
+	GATE_CLK_POLLED(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, BIT(0), 0x77018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0), 0x7701c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0), 0x77078),
+	GATE_CLK_POLLED(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0), 0x8c000),
 };
 
 static int qcs615_enable(struct clk *clk)

-- 
2.34.1

