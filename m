Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034ABC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 04:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C40C6071D;
	Wed, 22 Jul 2026 04:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 994tudP7h-S6; Wed, 22 Jul 2026 04:35:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B63AC60646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784694901;
	bh=JdhHDCqyX2SsJlUYXZiBGvy6gxoYdKXcUk6KDrytb40=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Izhw6voYNzIXrgn1M9AY0vvuLxF5KPeTqtmKlQUCWHA22n/awjVaP0AFIuy8Pp4fR
	 ZMMhArncoFfPaOl6Lg9TdkaiMDd0f3Dojd7xBZU/TWWxp8vLai8l1DAK1/lRqqlGIH
	 a20S99VCoZ6Xaz4qmO+WMiPFw8cLrKn1e0vgY6dVkFtET8k2B84O/rSL/uklaEzw+v
	 Ra2rcVhuxYszE0rCC0R+JcACdclqJ6xPpdvxH9a0/Eu3Alv06OGnBH8bLjBtFc5AeH
	 1macS1QLw9ZmGT2RhHjHddJVWhUhmQVbMcPcMeXNi/hW/sK77fkomjGnQ8f9elL/AZ
	 GBK3ThiPLwzFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B63AC60646;
	Wed, 22 Jul 2026 04:35:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F19A4313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 04:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D72F680C45
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 04:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4IajMHJ9BN1 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 04:34:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCC5680C68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCC5680C68
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCC5680C68
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 04:34:58 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M1CM9x3527133
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 04:34:57 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6da7yd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 04:34:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso15254894a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 21:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784694896; x=1785299696;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JdhHDCqyX2SsJlUYXZiBGvy6gxoYdKXcUk6KDrytb40=;
 b=c7qv30Bvm2zMlQH5/ueE612YryPbHBXk4nTRQLFS5WY3WOnc2nlHYxpI++DTpaIo8V
 ayqm6SwYNCK9uvZx+04F0mg8yencxjNbz8fH3nRpEDVOss3jnl81Cs5vjMD7Z3YLIeLM
 iB+llNsJgdAkJxioQSwg+HDpq17kQJQ9Jpx0ooKl+K6clBiZyLz62FJjvgAHz2TjKehs
 oGuc5VJZeQ1PY3zxkZVYWWd8ndqlCOKtNeWeSkCzeBZganE4moJy7w3DzYCa2eeefq2x
 +Zttw25fxLyd4pysZHBzF5LNbks2H1orMV41KQFHT0VMSHXPEU4K+q/8F9IUGQbqU6Kw
 N8FQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqBfBYbG1DNn/PI5YK0p8qK/556Pdl3YdmShY8Smy51cPRerk3nwfPl+FgdHMWud9SvUU97O4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx5yXMteGkZDrBwLRfPPi0us5iD14Ap6c24MdU8ghgFLu0g3yg3
 m5LwjGIveXz9QW3Q23HW1a+geEyDmLHBQcgzbUzKo94CyrQPfAs6qCuMRcPBAhlt3sPJDpns74f
 52GtwOVS6IPfIrUXyoT2fw5N6lnj25jjtt74UtPG0RRDZ6q0w9LvPEEhbTxWRW5aSuOXbWKU=
X-Gm-Gg: AR+sD10dWo8P6Wz3ajK74HAwyJ+mFaOn9QqXdTqtVDemsHnZqFwCmMIRYttbOKCt1oZ
 GybfWQNnv1kTB08YZZCA/WRgbEhueQ9ygHNIr6ZY0ah02ds0MCA8dCu527ME+qZh6upi3411TPx
 hqo2E+HfueIyu2yfuX9ELVx1fxpT6QU82AiKXZYlF7ZTLfJPM+bbMI7YDrlch0X2JpQO8XBZk6y
 6PFxI8kC8b7FvL/gRliS4zxkyd/sacdK5NmefOBqR4Pu1DlcsRq/LCNi8RhkcTrCX0Mk6ASNznZ
 ilsT5RVALMdjeyFbO3ySWFJFAIELqacX4KIixeKGHatIxBRMlsqqgU7LYl1W4HG95CaeLJYk8a7
 Gq4FpzQCO3ku9z2SjSzBlMI6us3dUoe15vKfeDKcZet7+Nfjy+GW/ggdGGxLcsB7CHHnmpQaBwR
 Ze6qntGDSCHjufNXJkV0bFB9R1noVT
X-Received: by 2002:a17:90b:1c81:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38e4b56bd45mr22048263a91.34.1784694895806; 
 Tue, 21 Jul 2026 21:34:55 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38e4b56bd45mr22048239a91.34.1784694895265; 
 Tue, 21 Jul 2026 21:34:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm2681008c88.3.2026.07.21.21.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 21:34:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:04:50 +0530
Subject: [PATCH v2] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-lemans_emmc-v2-1-edc56ce7b768@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGlIYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcyND3ZzU3MS84vjU3Nxk3TSj5ORkA5NUC8sUAyWgjoKi1LTMCrBp0bG
 1tQBvgguNXQAAAA==
X-Change-ID: 20260721-lemans_emmc-f2ccc04e89d0
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784694892; l=2626;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=4xnCUE0TjIlIMuPCroacBLrXK/WRJlXVCTBf/lcODx4=;
 b=cKTGlb9UoaOZM1kH5aH2o2MwVw8U3rGYk4QKELjt9mXNazGGaOEQivKgBvvVQd+XEhmrEqmtL
 VSkTOTLbrZTDvcHfpfDmq9YLj4HNSGGSicCSm6dvs+L79oIxfdG3zSi
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDAzOCBTYWx0ZWRfX1DYkm4SVYS0F
 YQ8iBxLXapD2/9ux2TG83bEp2e2aCGHthst8xnOi6dovjjPe7LLNtwaL2u9meLEwvU+LHKBD9xh
 t4/yzgZxYtwh3S5OpwxgJq3EF1OGUH0=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a604870 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=526cBOim7ay0EJGWx88A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDAzOCBTYWx0ZWRfXzRS2YOnWIW6/
 /r4wzYf+RC2ewe9dndfAhw3D21CdvJQJU9sPQmnVdX80vVqxV4bunobu7KHwqgo+X3Jb9A1My/V
 dbUn3I0fpK2bImRVqiyy1NsrngyAffnyvrJGEGmwGDNKbcsYuYNM/Hc6klyXOreHUM7ak1Liypm
 iic+8cFmeTLkP6CrCoeEfv/8iUUctejvWDCiiuXG77yXZ1eG39gRMn5Xs+xSoEhyNJ+ORqdBvQQ
 zorhrlWH/GbdB0Ljxo7ZfymSFI6nzTtx+GShMACAE1Uad0vJ7Jj0Jt3DCjLm9uzwkoT1aIxHmmS
 crV6r3NUqsU/TXJNvt+ZJ36OFKD5uIQzGsK/VmUOHIy+rT2Lnfhzl6LvpAIn5pJXy8Qm2mHEUB5
 7O7ZBCjDpuwBvd58sT5d2EypzYFwOAYUYdL1u1H1qcvSt15d5/enIQ+Nilm1q72AzAGrVxl38Tc
 ZSBGRxmdF5SwafTWVKA==
X-Proofpoint-GUID: a482w83EUYyIvfJVbpz6S_MxRQe4POOj
X-Proofpoint-ORIG-GUID: a482w83EUYyIvfJVbpz6S_MxRQe4POOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_01,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220038
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JdhHDCqyX2SsJlUYXZiBGv
 y6gxoYdKXcUk6KDrytb40=; b=GmjjulJDbMUJqqeAxAZ/T4Wy3zLRuNtydFbGrQ
 dVrLh2YiQ6UtjG4uS+umdEl9a+ZKeh7Ng4P5d2CVLaRps7oxA1nSjTex9NsrGqFO
 rj4KEAoTJmydilDe7Xi8D9rDPlxD4BQKWHdgeVImsm5tlZxRLAOt5C58PSfRHCx2
 9s1E0BE/JNDLivvfuZcRpAbFSztZkzpoWjH3Ps+jKt002oUJ6iMNrNWUTP0ziZWt
 YQnmQrNwUSqoC3tY0Zqi5twkXJVnIfkCJIWR5P/OysfJtKLR4LPI1DMIKZQ4sQgX
 cEoWKJj6KbJ7TTULa47bMMsnLQyDn+REuTOLTmXhYxdW6DhQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784694896; x=1785299696;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JdhHDCqyX2SsJlUYXZiBGvy6gxoYdKXcUk6KDrytb40=;
 b=HxLn6Ont4mqfzgHQheWkeNUmm0AIVK8NfUHkRb7xMxHeHG9nwtiFezNBkyZNbiswA5
 hFTDNulCLkeleexwIE48sAg42YFfgbkjK8Y/w78YWDo8a8P73kCtEcxr6bz3UjcMjEEw
 TASBymzvfIv0+bmqdR5qOLq34TprnU6tVrN98xZvuq8VjhTPORBjO6Cs+/0g1/ehAJCh
 +1dtcBYR8cCnMwARNgxuk4nESAiVRMoM9Fj3x97yT8kLXeTX/8fOE7PU4pt/DrU0zVED
 i64kFM4/4AQRHP6g8ZlLq4Qd3NJK0Ld7m6zMKCzlvbFDkHpyhttc/EMWjF7TysuK/0HT
 r70A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GmjjulJD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HxLn6Ont
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

Add support for SDCC1 (eMMC) clock on SA8775P platform.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae48..a5e84ffba7c 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -74,6 +74,22 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	{ }
 };
 
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+
+/* SDCC1 APPS clock frequency table */
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
+	{ }
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -94,6 +110,7 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+
 	case GCC_UFS_PHY_AXI_CLK:
 		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
@@ -112,6 +129,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 	case GCC_UFS_PHY_PHY_AUX_CLK:
 		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return 19200000;
+
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -169,6 +192,10 @@ static const struct gate_clk sa8775p_clks[] = {
 
 	/* EDP reference clock (used by UFS PHY) */
 	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
+
+	/* SDCC1 clocks */
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),
 };
 
 static int sa8775p_enable(struct clk *clk)

---
base-commit: 042e45e026c77227319a426940577856ffe62e7b
change-id: 20260721-lemans_emmc-f2ccc04e89d0

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

