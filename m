Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47E4C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 05:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BED6606FF;
	Thu, 20 Aug 2026 05:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywt2DOCyKf9Z; Thu, 20 Aug 2026 05:08:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787202523;
	bh=cRsbjh8MuezQdL+ATwpeb0x8aI2EibIHO7EyK66dOac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/c7WJbL6mDbvBRVZE4k8YIoSoRtfRrazvUOG3qJcVKluQzyrD2I3du7gO/cDcmSb
	 7zZXi4scas/HfcYKVsihZIEAb6B856TG1v8RsbRCymZs94VQryjNPfvFJd6APSsM1y
	 Pl+ca5lT9jF2jw8tPDaX5v9yVsorWiQun807tFJiaO8EqIfqLre3pF+Q9b5Y4q3QzS
	 7nxAAl9Xl3642K2B0ZHvjN73LUHItc1zfpTI27HI4SlsCu5E8gvr8pJjv8HzVvy+eU
	 BuuLkkZdduKnEMwLKSo7ylJAXTjOB+i8SM8ULJJw7zUlIeBIrMuTQhBD2WPO8gE4PN
	 VTzd2Pq1IPuEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7F9260675;
	Thu, 20 Aug 2026 05:08:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5026939E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36C1F4024F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIKTxmfonzDI for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 05:08:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Q3NSWkzH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CV0VmMZK
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34A4440064
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL8Tar1988667
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cRsbjh8MuezQdL+ATwpeb0x8aI2EibIHO7EyK66dOac=; b=Q3NSWkzH8HfBkBLn
 pfCLGabSxT4vCQ109uS4gD8USD3ZeqdlNurIZf6MrJ5NrCcMSrBdDbrbPJGGHGvr
 OQLNTR88qX13jvz10GbkxZmSYL8ADULQmfvo8HAbl9vDmAJF+oVXxPA1dW7RaK8b
 wYqjNTs4y2ajd4NImRotUECg0UFDTpM+HeLeAG+ctw4GGlBYd5jSEH3Yi4g3zKiO
 AVH2VAhwr9XJFFnP1qby8SwVtA4f9W9VT4hdv6sBE98LhxXv7vKAmeGcC7s+/OMJ
 Q1YfzjGOvdEz5ofJ8z7uwrE8yNfHkaGmpEVN6Mr1YkfzUggxavOIZ+u4sCIMZea5
 SWuRAQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esj363h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso3386077a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787202520; x=1787807320;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cRsbjh8MuezQdL+ATwpeb0x8aI2EibIHO7EyK66dOac=;
 b=CV0VmMZKNox6Ac9LSScWKrs5+dRPvWQbI+ah0fRe5noXEyL5646xUahNgxCjFO88lF
 UgPRDVb5zObfVf30NrBgcqgP1qeIzbl9vykJDCdXqvQGoJ5H0xYYSHhXxg0GauJ4Klse
 G39j37HfMPxX8RdUfLpKzpli1UWpXk2m/HtU3o7PTl5jfg7E5Ya3Gl5uAfjvMNEn86lN
 p+SptCV2H5Bfef6pfXfP1I7DCs749Hz6QGKmG06lvJDtXNH6GRx8wGGdcPAZ7smH+oTx
 nel4y8IdwVhp1gdPulsqEctdlZLuysJAQVumoaWsUVffiPP8CAuH0P6URRtk3b4IsqG0
 H8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787202520; x=1787807320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cRsbjh8MuezQdL+ATwpeb0x8aI2EibIHO7EyK66dOac=;
 b=mb7j+oN0IOSGA8NxJhGVeNHG76niBzhWIj4qV6pLW2Q9qGZF+PfHm23sA596DbnUYY
 QQDJQj9F3lFeeqdIhHdaJpwmH8hlTiX0HJCcRhVYPP7nZ2I95S2LPtelq3RBpnApIULi
 VQNZ1U7EetiKJDRWyuMZfYoIS5+npKs9F1PunP+OcOWsj9RTjJwh5jIu1fMH4kI7BSVP
 3ru87SuM2BDF3oPVj1uvSitpUxx+CZuviZxF5ZGuIlECkAVruoGniNsZzR5fSuGNp5cY
 MbCpDgGI3V5WpgP4hLE2/Ks93fB3gYqPz+fUdGXiamW9JI7NaRY1onjrLvjaJtyUkaNo
 byuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RplTQY+0MlCQX3C6bjSkA/UaRvUZ9wCjbbIFfttoiNK5bwNwGJtlV0rgGZD6pWZdmCq5ioh19g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lw+1MXzwMn/6feoTpjz0opPe2eJOppjcD4uxHudikjTxThhIcK
 AfmHStaK5QiaWePy8LJxXw+Tv1L4VCYd9s6XHc323+HME78vGUw7sxTg5Ncjht9RHjxhGiZiMvq
 HwcM3ca+TOKLLSmSiBTfQt9iAjWuSRLl1HO+/za4zi9bEQ49rpRrGKtzUqRb4dgTtqgaUBZw=
X-Gm-Gg: AR+sD113uCwEfyeQijdMMW0J6Mq0Q6LZ0M66z3XbXEREVomnzmu3zXUssydruommKqK
 u0/c8RMy3qdAEE28xHGk8BtEjtlYdhmX6OMtXpmnlhSZXCye4hZba5nub9V9G4ST3J5X3hU0/xR
 cTnqhpp2nZboLbgH6vIcNDMlQhGErEMdLzXcqU8lYqMq9mmnSTFPSXVCzT2C2KWXNg9n6nwt/j3
 Do6LQlBmmVtkQH0v/B+WJySHlZYKaWdeFYDDhkY/trNjm9v9HoGKL7ggN+RYNQWjRpmHAkdALSD
 LNzj1VFTNFKHrVbLafrKp5KFfI/fSzX8HnRxiMMYNAtDeMtUYTSilREf1CEVD3kI3nbuelGnvZn
 RL/RU5/fDZC7A374fz6HYz0WZDVJ4k4+KbXifXvufibYTFksgZa3zXGTQX8qUDCRT5E7pz9b8Ex
 5sAI46Tq/dKF87XQhb7yVwrMgICtyh
X-Received: by 2002:a17:90a:da90:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-39580a91ae0mr19809747a91.1.1787202519605; 
 Wed, 19 Aug 2026 22:08:39 -0700 (PDT)
X-Received: by 2002:a17:90a:da90:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-39580a91ae0mr19809668a91.1.1787202519164; 
 Wed, 19 Aug 2026 22:08:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm12012395eec.28.2026.08.19.22.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:08:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:38:24 +0530
Subject: [PATCH v2 3/3] clk: qcom: qcs615: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-clk_gate-v2-3-8cd0059c162b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787202504; l=4251;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=vkr318JCVhvNpiEcr9PlgGdDFnrjzb701+eSyt6NEuw=;
 b=HxSdFRQMyvOuUBK85O1r7l5uOIpUfU3CwrsB+JwCyy4KZ12clKErx+SGyorqxht0WOPrVgeFA
 UJ2tKVMAmKED58SY1bApSs5eFlT3qT4sY2WiiMBtK3PHSBjIdMe0HWT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 5y_BpOJ1_9wwqW0lwqbvomckQFNxvMFr
X-Authority-Analysis: v=2.4 cv=EaL4hvmC c=1 sm=1 tr=0 ts=6a868bd8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Tq1YDk_HF2moFU2WsVEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX6JXNAi02vsb+
 3/cqYDhD63H5yZi0wrRmaEFItOP3iVHrc/e8Z0v9mUdFL8enywvVtFBuzdHUOUkuH8t18nlC1IP
 tf7lNIK1w8+LQmkYE8vx6ORmb8IX20iGftMx3ar4EBeAAorfQSZQ48tjaK3IMi479VhtDzixRB9
 jlyXUwjg8y02e9X3WwQi41G+pXRov9pvVfgK8FCr0FJKQ791Ay8JsDMVQfHEJaX7OtG3HwJmCaR
 8tMl15JwvoPK0I7/Y9CIeR5qqoABH7Bw/tUDafsVWIDYukbFOGmcbC2LeiL/zCrNlqtgyOpFNg+
 9auPG9Cr4q0yAJtmR8hfsVdCyz5H3iOeQb03QkCBQb9WFP9xFe7MQHECcUWQigXO54BI8L28PqG
 ZpbM0U8y+GYAHI+76p4L53hbMbfr+9T9jaFZ7GwAkjooUj8iDtbCY6Pofn5HO8xJl1W1dbolTh9
 6hk6ZWxpJyUZh9iaWTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX8WY/Vbi3zsfZ
 79xCKkiWQjxcGNjVWGb72RmdTUydhaf54VZ581fgxp2E+La9zBJ47YQLO+2jA7BjjfS7uXvC2LK
 2aOoZvHV0mb0/WBxKbYz7NCLIF9BWk8=
X-Proofpoint-ORIG-GUID: 5y_BpOJ1_9wwqW0lwqbvomckQFNxvMFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200035
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

Convert the USB3, display, and UFS gate clocks in the qcs615 gate
clock table from GATE_CLK() to GATE_CLK_POLLED(), so their enable
status is polled against the per-clock CBCR register instead of
assuming the enable write completed immediately.

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
 drivers/clk/qcom/clock-qcs615.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 7b3fe49de9c..4c7686d4c8b 100644
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
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, BIT(0), 0xf078),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0), 0xf010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0), 0xf07c),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, BIT(0), 0xf014),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, BIT(0), 0xf018),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0), 0xf050),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0), 0xf054),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0)),
-	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
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
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0), 0x77010),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770c0, BIT(0), 0x770c0),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x77014, BIT(0), 0x77014),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x77040, BIT(0), 0x77040),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x77044, BIT(0), 0x77044),
 	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0)),
-	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0), 0x77078),
+	GATE_CLK_POLLED(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0), 0x8c000),
 };
 
 static int qcs615_enable(struct clk *clk)

-- 
2.34.1

