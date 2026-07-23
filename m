Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE5C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F88C60711;
	Thu, 23 Jul 2026 07:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RMdnUm8OqWZ; Thu, 23 Jul 2026 07:07:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5886B606CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784790463;
	bh=z+fud+1Nlb0ZFOsQ5CS2JeRGWHTtgLL8XbBDB4k0oZY=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=o4cH/i+y0jJiSI8k5CVDX/AU+bbCJQS7S3RzE3Qq8xmkNkY2GcBh275vbMxXhh7mU
	 pSf6DP7w9yBlFzPKZ291ha9+yKuyXj3IBal1eiomFwDvXnU2QmtNxwCy0aLi2iYHRE
	 2u/BGEQYqidpUi5ch0+ncsXTZqtjpX8/6Q/Szjzwmt1TcQ2Br2ZRM5A0nr9VMUfA1K
	 waaUQ7w3B5kIfKFs9zh6++4tgb0RUv0qsPjCFAjOMpzexQF7yJhA2i39PYCa5FMvOU
	 aeUn1dPwxbhBmwr2lkNRAMXI0gdyXUspKYkXaA3O9gE1622M0WdwIjx+ac049PwHka
	 LHcxTsuYS8bTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5886B606CC;
	Thu, 23 Jul 2026 07:07:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8948639E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F72D60646
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5unt-xNJ00S for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 07:07:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D0E0606CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D0E0606CC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D0E0606CC
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:07:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6B0oS2676852
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:07:39 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgkvcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:07:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb6dd278512so360993a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790459; x=1785395259;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z+fud+1Nlb0ZFOsQ5CS2JeRGWHTtgLL8XbBDB4k0oZY=;
 b=h9vi9l2Uu0ZWqY61WmqdNE03i6idaXGTW6TYZiJkUE50IJ02Qc/3ICeZkLrWh/j2ci
 OQGNMm+76e4BGJ6fqVRqMkFDRI3X3CFn2ik+U5MIbeGnv/4SPDe7fvtNSAiPJXr1v+p7
 sTmpF7TFsYO+pucdKV9OpV7Ey173KG1nZeyuZ31fEvfZlUaPMlZ6/BbpWQarWhwDnFpZ
 WNqcwkfFmObZuvBwhSMczSKC53qEMXRVDbOmGuZt7gAEaWqRJeByFkkxnbZCYV6KnWM+
 pX1Aa0AR7k5DLYmKmbjEV7kskcV6/bA8/bvVlKdzseZgpA41wQbTJGe9X/zTeSLjq37P
 lZsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqttnJQwIxEUe3P9ZL2R5S7C9M5WENkceUQKtVZ5VQJHcvqi8RVMJT5d3JX+OZUIAdr7albx3I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyj1PzBx/Yq1QtsyfeDoEDVS0e7Xx4T5HqRKIutXSw3UrXZ8xkS
 fcPAJNOnqfN9YB8tSeTSlDMf4JUnW7uV6Dl7JZRZfNMmJLuxhkkJVW+ga+osJTDHfUelDiw4pIg
 J+p90AeNwkaCY6QFy917w0QLTzv0mOhjWqHEP0JhavnRSlUGDwaBFLCQhUA2WUd0XxG5DVKf2k1
 /EdWI=
X-Gm-Gg: AR+sD114WUJ60R/YRmubx3MBGQFJWgMegHrcZyVI7jBiemzQaw51RhwoY52Zg4JdC9n
 SP+XAs0PO+s4psGtIIFhcwuAAP9LAWALRlRYpjKlbnXkP1949SnC0E/fIBRTBQ3n1T1Z1kVn4Tx
 jmqPHbLreCRd/Clnx4/uFKVu7IH8FseWVGqfT5BhrccDntG/cpcIo4TaH0RFJmld+70n3Xjzhwi
 p6T3zivWGgSFXxxSFiQSsno6XoliTujx4qTfLurkluBexLSQG6P8qOPZmvCKpOt1qT7n0LlDBt5
 cIZecoAJnttyshXuIf/FUJCEBlylq98pspLz6sEk/ClzYKaKPY4PJXXweq33m2BGGiiaqHlpeka
 hszYJoA3QDmNPGDKuNURp9U9EPxYmeehqA8dQR8QF7BMzgcEdp04JrnekBlgM8s62w9k8+HZO9K
 F9Zo87QOM8wUpXH/s7u5E50mKrejIP
X-Received: by 2002:a05:6300:95:b0:3c4:147e:98f1 with SMTP id
 adf61e73a8af0-3c44b077613mr1991504637.31.1784790458689; 
 Thu, 23 Jul 2026 00:07:38 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3c4:147e:98f1 with SMTP id
 adf61e73a8af0-3c44b077613mr1991475637.31.1784790458229; 
 Thu, 23 Jul 2026 00:07:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1b6a45sm16251769eec.28.2026.07.23.00.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:07:37 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:37:28 +0530
Subject: [PATCH v2] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-lemans_emmc-v2-1-f6e679e58fe0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALC9YWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3ZzU3MS84vjU3NxkXWNL05TUJNM0k0QzcyWgjoKi1LTMCrBp0bG
 1tQDlxxqGXQAAAA==
X-Change-ID: 20260723-lemans_emmc-395deb5f4a67
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784790454; l=2895;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JNFz7MwJxMM7OW3JACSDJaU5cLp0L6lz08x05ZZn5EM=;
 b=AR5XPAOq9HNStNDbTglTiMeGne5aceVcTLyqtDz/s8SrQD4DZfKeS8Q8mLr9qh5PNg6F7xwXI
 VrkKCl7SHpODG7cFFw/51iOn2Cqe9hd+kl5JZgYw3SdX9E6qUm5uOU6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a61bdbb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=526cBOim7ay0EJGWx88A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 0pddR8IF20MiJfOsX4OILU8YfCj54_t8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MCBTYWx0ZWRfX+cn4M9dBbjO/
 CYef2SwG4Uf+HgisCUgGEqCoEmzJ2qBV6E+Jq4hzucmknJjgU/6KqRpDirUKP+RT9m6iOUIQUIk
 vsP5akjSyla29E/uHb1PX4UBXJdXv/4=
X-Proofpoint-ORIG-GUID: 0pddR8IF20MiJfOsX4OILU8YfCj54_t8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MCBTYWx0ZWRfX0LJ54NFf/FJ/
 Q+oFG+lIi+jbPPWbU5wj3FsKtxsLG6VM+5iosZTzihD+T6ZuwTroK7qOGUEWDnSELQcE8ck65AP
 HNapJbyune4lVUelEtA78/hEhtKyS8o8I2HPIVJV8KU4w/EFmgd/0NCNc9fA2iBxWGZe0WypP6/
 f+5KnFYyox+ko6Csfe9OQnzz1YLIXrfFmrn4xtM2HXg8L5Dmxr2vd1grKGdlQj81WVMx8mhXO/1
 zhAUd5fEW/EgMCL1P3cEptuFg6KriNjy+DkGfKWALg0xHENJbo0docR9J15MWkvPD+bZMop+cha
 SVkLJ+XaN1bXZP5iZY4RMfFfTc30/hNzCf0O8CRX6ABoLC8kK7dpLskoChAiUemiAwqRX6Of/lR
 8h4jagO8GSvnykBUEulD/hGf28Sujhu2CVsYTeFqFC9xkiT+aaaJ/2tla/MVoatQjJzwL9E8HTR
 0rP3SeUQ9IQhHTN9P9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z+fud+1Nlb0ZFOsQ5CS2Je
 RGWHTtgLL8XbBDB4k0oZY=; b=CMT+iOe4fglT1oC23D+HXAcGnTb/vW/PrNsSHX
 +bqVMbyrLoQg4G5YGfdtGaPBR3AS1Guwl9ua5DT+DnV8EnFnCERPxP2BnxoUOQVb
 NiAdatFXCUM7uneaDX5MNFD4LLClfLkFjHZ9130kKjpZvxdXW6CKulwGPUXWmFsS
 LZX8Y7RXE5DDsAYtHJbyelWQdPavPR2qE1Q0q4m4v0oLUw3lrXxZPcW2N/4A1+V7
 6eUh5TlyD1P38vWOWuy++vGIU2ttUM3tTgaH1l6gZ1RBzZEDVT+9he1qZNvXHrgn
 5Nik7gJEVirvOFiBTg6qi72rKFy4CRXPRWYpeTU9oDT4Vzww==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784790459; x=1785395259;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z+fud+1Nlb0ZFOsQ5CS2JeRGWHTtgLL8XbBDB4k0oZY=;
 b=WGxC33XyewIwNSezQQ2izx3t+OfUyPcJ4rC1Vg2PGjPL1aLndIgh46Nc4m0LzpeaJw
 9obMNS3DwYGPq62mgqQ0cjLKKjz1kqkKT/3JRhrmciaaPXdaBSPZ2U5yldPq2hvRckxY
 D/CdRQX/5o+T92sicnkPiSMoNA6pFiu0JNgdrhiP6Q8BiwK/tjcvAdrtpIPAux5MmOUj
 xynsMPTRUXvPckX2KUS7zhxFTwk4wIxMSpWsyMuGIgwJD/QuCa5eLOhcRB8fW7QBLwaf
 Bus9CQVjKK6Lf6QEJ4D5OFM5lyuTblKBqDvStsk5MQs+ErQEPRHGODkdGZLVGaEOOwf3
 +xPg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CMT+iOe4; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WGxC33Xy
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

This patch depends on this series:
https://patchwork.ozlabs.org/project/uboot/patch/20260723-clk_gate-v1-1-9549cad4d097@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Use GATE_CLK_POLLED instead of GATE_CLK
---
 drivers/clk/qcom/clock-sa8775p.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index c36b480b300..586b4e1be32 100644
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
 	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
+
+	/* SDCC1 clocks */
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
 };
 
 static int sa8775p_enable(struct clk *clk)

---
base-commit: 2b66f9cf0492b23ac27ca4523151e2bddbab3c4f
change-id: 20260723-lemans_emmc-395deb5f4a67

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

