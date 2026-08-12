Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737F6C5CFC1
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 184E2608F2;
	Wed, 12 Aug 2026 01:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yu8PvHucs9GI; Wed, 12 Aug 2026 01:12:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65717608CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497153;
	bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ArC8b7UJKMRiGYnOf+K9Zm1aylBjpaR6Y5WxyeQCLTUWRXvmwSVp+iAu04Y5xHQYt
	 Mmp6bGyv1pAoPHXjDDfQrD+JWh4I71AGChFuvRk1YHEd1+apQ4O2Wd3sxwnVS5+jyl
	 Z2DCGCBPCWyUB2yWijuyrFGMXxyK/XvCkilLblZO5mpXWyNsABNjCuv81Z+7lHEaFi
	 lKWrXcBW9I3mS7pCTAmDeNufu4lSm/WIxuPAE3hWhZ0SfatQzqAU2B8UlWPWdcfX9s
	 KYajOfhLLpQKFX2FqO2iApM1zOmPWfpEs5fxyBQGKslzRID0WbvguLFpXgwuaOw+jM
	 TxKMSaRBbgZmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65717608CC;
	Wed, 12 Aug 2026 01:12:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AF2A3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E509740816
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXUj-94YSX91 for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5F04040806
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F04040806
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F04040806
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNGn5b2107524
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:29 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049djtcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so1062331a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497149; x=1787101949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
 b=o39Ni2lTTxPpvtfvVfJMD6xxkfhGO/3vU6V9CIP5/Jr/69QyTmeJFRlEVUTNNWTKZy
 uNKqWe9GHsxWDnN+MTDWS1cY86JcLkBZPgkQUP3YI2zqPdfALGXNOsxpiOB5X8wwqfpn
 351fe8hYMxPXbR5U986eu0hBI0lEw7VhVSQ/Wx1tS/Qy7QNoTdsPuyOi9gdwy1cKr30d
 Qdvcwdd9GR5PSUIeRN0l1mdhMfoli0748IXDYnRQbxJzKhe84mT76T/GQj2rKiGEBuai
 t/TOV3J64rlHM/3oJF4sr74xmnt96MevPAA4K31XzR0hHg2b6Ohpkxa5ko+/T2HOiqnP
 b3Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFPKLEuuvZ4WyXbri7NFk7PU93Sz07uomJP0QxWbPVKUMqUtIhe2x8DPG1pgrJXTzaVuOtXHs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyt+x00rc/jBQKVI9EJWWnoj3uBe2F1QDU+/yWjfcFohKPVjUcc
 qlaFonMQgG0ahXd0Dl6MpCWOohw3sZaRanfdMPQumQtI8L1+dQ1agNfuSCUB8DiwdhKtS2+jkxy
 dNJuRhVKGV+eTQG+cRiWnuJXRdspkYpfUUvwUXpqglWrU1T1Pb+frOAUg4TzMJ5EFZKP2f4c=
X-Gm-Gg: AR+sD11BP9oXvBF7XEToNAbVzccdZv4hYl2Ih2AQc/Bxm1CW7OFE72sRr4AfVdD+vTk
 9aW6EBc3oy+tPuEl233cZ+46J7hfzWq9hcm7/RSZcKYgO7CCpONWJrspfT2KEhT2++6I4XE+428
 vRn2yRBcgUvBFAC1OxkIA11CJhg8s+oenISdPQtGbvxwMcNYa41W+z+StYvGdQrErnbwzIvnull
 JfFERtwJCIufqRinFEsVPTFrEzy5jPXo+k9cTVo18O5sStXboFs4e7FWXgdHebhMNn7VLrhfi1P
 tDGPj9Oh4pH5mdjgUiStRgz6gowShtK+G7bFUSyffrjf6jAmcw0owJ0/IhlrXPyyecN+ltunJUy
 mMVfK9IYBzXnBJKkoOrWz01tikI3J96CbjwNojWjZ0pTYUH++oEj5tnJHsWBBHA2bS7nowHvtiM
 G2QyrUzR8AT8gcjub+WfhxYCxGchCC
X-Received: by 2002:a05:6a20:9392:b0:3c3:89ce:b5bc with SMTP id
 adf61e73a8af0-3cc3f5f315bmr1170522637.15.1786497148569; 
 Tue, 11 Aug 2026 18:12:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:9392:b0:3c3:89ce:b5bc with SMTP id
 adf61e73a8af0-3cc3f5f315bmr1170447637.15.1786497147919; 
 Tue, 11 Aug 2026 18:12:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:27 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:42:00 +0530
Subject: [PATCH v2 2/7] clk: qcom: qcs8300: Extend GCC clock driver to full
 gate/RCG coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-2-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=27701;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=J3TFENiXjuJdDdZ5R19hpWH5pSHYHvlTouG8piGhuHA=;
 b=zeoy1TJNq8IhNZQICnQQ6+z9sKZtnmQBD6QocFG+lDfJxSDtyrcPKbzdzxWFRIu2H6T5+6jDC
 Nwkfw7R08FUC/LAWr8RsvPHhJ4KtrrYPj9pZllVIlJnrx0TU/9gAAbc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX4rdhV7JbeGJE
 KMe0WLMuLP3WU9gOmIjJy+VhwYV2W6tyB2xS7E2VTNrLFnkZIAbYQtq1SS7GxSQq/aIBTCMnoM1
 /iWK7qb6s2VgmOJ4nyL4YfUj9PANPMs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXzoST1A8olU6k
 DxZvQRk1GdpD5lAKxnPxvo3nWrd/bRf4zTFoSWPLvXwFjCDIxBG7y3CaZ+nVpfx65sE9dpJJZY6
 2qcLhF0UnV0W2QS0pCCFm4Wer69eKiPx1woStzXSSsENegVn4BILrnK9E9TuC6O1pnnzFmwHi1a
 PQ3HkIDDd99wsJI/JScghB0/OWA7cBbbvrGs3sEBZ4uceFYLwyt/cNzLjbEetuARRELnu23Wgbm
 v+Moufbq+wf9S50xQJ/gGpr2S8mBmUHAEEeQ8Y8ZcIOXhVgjYh8ZfGgpfi4IMfsOpCbN50HAmWw
 dt/IvBDNg9oD9/JzhdRYO8Ywq52QJEoy48zN+1Ww0zjmzeYGjvCDvv0jSBOiekJCDox5fYPB0Fq
 s7H5/M1ixnJrVx8pfIgto3Rw7JJWQpmK5QHRQmK71W/H5VqobUOCfnCweKIOApLaSCvzmUwq6oc
 BXJ9sHsLK7iOuLgkuwg==
X-Proofpoint-GUID: SHgUqR2zROOsN0j4Qf3H01Ylaw2C10DF
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7bc87d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8KRvGpLnRcE-MBQpGOYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: SHgUqR2zROOsN0j4Qf3H01Ylaw2C10DF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=; b=So8/fNqb7jGZq28b
 SFOy7FG4MqycNO1xmCNqZojKrivPNGpE+OmTZdiP2Qjgcc+CBCcPrqAj2jMb5PNK
 p0I46MCLQ8lr/NisEBdrxHcBL6uSr24Q6OauQNF6W6kYCkS9UGJtI5MxqJr7PBTx
 6j/DnGRiGQulcL3wsS7kqujC6SiERqAUUP89pIF6dBRoVMahscR3ROnWvaU/XCxx
 +1Voiicte/+noyDUDhluQx/6X6y312OCfFWtGNqHZv0k4gieXQ6d6vNOGoX7H5y0
 qK4zGMk6Lrk5s/v22sFjKNzRf2586toKNZy6YxkJPup+UV61oJehxVYee3LvT5nS
 bjNtAA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497149; x=1787101949;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1oCxzkgkSVW/CHknoBQ8PbBaUPOgRdmq1eIjmWOxPo=;
 b=b+iayjgkRe0J/98ZZYxDGZ58EhYPWl4w6IEGVy/xdx+HHNB7/rAc63b5M51nWPE/LQ
 WRruflhIgWraKjnsbHv4JXPmsMHtuIhuRvESHRHOwrYTEqDtbS7fGBlEhpbMyKGimY5I
 KQV//ge9JihK53luieKDXKi1BLX56hPogn7YxcQZ5nV+lbfW2otef741T5hoX7jD5M1J
 W+MXlZz5Ujn0aH3RU5rFlIJqED+cmZWgQyMFDFencoQH9V5HkppPvCs40yJHsUEme9gD
 28PsYNAItavLy7Un9FN8N2RWSEX/lVJLLLcIS694l4Bxo+XeseQrETs+3wuLgFz8IF8I
 lS/A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=So8/fNqb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=b+iayjgk
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

Extend the QCS8300 GCC driver with the remaining RCGs (USB2/USB3,
UFS PHY, SDCC1, QUPv3 wrap0/wrap1/wrap3 SE clocks, GP1-5, PDM2,
EMAC0, PCIe0/1) and their gate clocks.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs8300.c | 545 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 525 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf788..cd47b384f1f 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -14,12 +14,210 @@
 #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
 #include "clock-qcom.h"
 
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define USB20_MASTER_CLK_CMD_RCGR		0x1c028
+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0x1c040
+
+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
+
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+#define SDCC1_ICE_CORE_CLK_CMD_RCGR		0x2002c
+
+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR		0x23154
+#define QUPV3_WRAP0_S1_CLK_CMD_RCGR		0x23288
+#define QUPV3_WRAP0_S2_CLK_CMD_RCGR		0x233bc
+#define QUPV3_WRAP0_S3_CLK_CMD_RCGR		0x234f0
+#define QUPV3_WRAP0_S4_CLK_CMD_RCGR		0x23624
+#define QUPV3_WRAP0_S5_CLK_CMD_RCGR		0x23758
+#define QUPV3_WRAP0_S6_CLK_CMD_RCGR		0x2388c
+#define QUPV3_WRAP0_S7_CLK_CMD_RCGR		0x239c0
+#define QUPV3_WRAP1_S0_CLK_CMD_RCGR		0x24154
+#define QUPV3_WRAP1_S1_CLK_CMD_RCGR		0x24288
+#define QUPV3_WRAP1_S2_CLK_CMD_RCGR		0x243bc
+#define QUPV3_WRAP1_S3_CLK_CMD_RCGR		0x244f0
+#define QUPV3_WRAP1_S4_CLK_CMD_RCGR		0x24624
+#define QUPV3_WRAP1_S5_CLK_CMD_RCGR		0x24758
+#define QUPV3_WRAP1_S6_CLK_CMD_RCGR		0x2488c
+#define QUPV3_WRAP1_S7_CLK_CMD_RCGR		0x249c0
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4158
+
+#define GP1_CLK_CMD_RCGR			0x70004
+#define GP2_CLK_CMD_RCGR			0x71004
+#define GP3_CLK_CMD_RCGR			0x62004
+#define GP4_CLK_CMD_RCGR			0x1e004
+#define GP5_CLK_CMD_RCGR			0x1f004
+
+#define PDM2_CLK_CMD_RCGR			0x3f010
+
+#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
+#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
+#define EMAC0_RGMII_CLK_CMD_RCGR		0xb6048
+
+#define PCIE_0_AUX_CLK_CMD_RCGR			0xa9078
+#define PCIE_0_PHY_RCHNG_CLK_CMD_RCGR		0xa9054
+#define PCIE_1_AUX_CLK_CMD_RCGR			0x77078
+#define PCIE_1_PHY_RCHNG_CLK_CMD_RCGR		0x77054
+
+#define CFG_CLK_SRC_GPLL4_UFS_ICE_CORE		(3 << 8)
+#define CFG_CLK_SRC_GPLL7_EMAC0			(2 << 8)
+
+static struct pll_vote_clk gpll4_vote_clk = {
+	.status = 0x4000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(4),
+};
+
+static struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(7),
+};
+
+static struct pll_vote_clk gpll9_vote_clk = {
+	.status = 0x9000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x4b028,
+	.vote_bit = BIT(9),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s2_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_gp_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_emac0_rgmii_clk_src[] = {
+	F(5000000, CFG_CLK_SRC_GPLL0_EVEN, 10, 1, 6),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
+	F(250000000, CFG_CLK_SRC_GPLL7_EMAC0, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
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
+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(201600000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 4, 0, 0),
+	F(403200000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
 
 static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n",
@@ -31,28 +229,315 @@ static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
 	case GCC_USB30_PRIM_MASTER_CLK:
-		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
+		return freq->freq;
+	case GCC_USB20_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return rate;
+	case GCC_UFS_PHY_AXI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_ICE_CORE_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_UFS_PHY_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll9_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC1_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_ice_core_clk_src, rate);
+		clk_rcg_set_rate(priv->base, SDCC1_ICE_CORE_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S1_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S2_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S3_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S4_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S5_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S6_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S6_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP1_S7_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S7_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_GP1_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP1_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP3_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP3_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP4_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP4_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_GP5_CLK:
+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
+		clk_rcg_set_rate(priv->base, GP5_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PDM2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pdm2_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PDM2_CLK_CMD_RCGR, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_EMAC0_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_EMAC0_PTP_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_EMAC0_RGMII_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_emac0_rgmii_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, EMAC0_RGMII_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_0_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_0_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_0_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_0_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PCIE_1_AUX_CLK:
+		clk_rcg_set_rate(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
+	case GCC_PCIE_1_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, PCIE_1_PHY_RCHNG_CLK_CMD_RCGR,
+				 freq->pre_div, freq->src);
+		return freq->freq;
 	default:
 		return 0;
 	}
 }
 
 static const struct gate_clk qcs8300_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0)),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0)),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
+	GATE_CLK_POLLED(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, BIT(28), 0x8e200),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
+	GATE_CLK_POLLED(GCC_AGGRE_USB2_PRIM_AXI_CLK, 0x1c05c, BIT(0), 0x1c05c),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
+	GATE_CLK_POLLED(GCC_AHB2PHY0_CLK, 0x76004, BIT(0), 0x76004),
+	GATE_CLK_POLLED(GCC_AHB2PHY2_CLK, 0x76008, BIT(0), 0x76008),
+	GATE_CLK_POLLED(GCC_AHB2PHY3_CLK, 0x7600c, BIT(0), 0x7600c),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x4b000, BIT(10), 0x44004),
+	GATE_CLK(GCC_CAMERA_HF_AXI_CLK, 0x32010, BIT(0)),
+	GATE_CLK(GCC_CAMERA_SF_AXI_CLK, 0x32018, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMERA_THROTTLE_XO_CLK, 0x32024, BIT(0), 0x32024),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x1c060, BIT(0), 0x1c060),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
+	GATE_CLK_POLLED(GCC_DDRSS_GPU_AXI_CLK, 0x7d164, BIT(0), 0x7d164),
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x33010, BIT(0), 0x33010),
+	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xb6044, BIT(0), 0xb6044),
+	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x70000, BIT(0), 0x70000),
+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x71000, BIT(0), 0x71000),
+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x62000, BIT(0), 0x62000),
+	GATE_CLK_POLLED(GCC_GP4_CLK, 0x1e000, BIT(0), 0x1e000),
+	GATE_CLK_POLLED(GCC_GP5_CLK, 0x1f000, BIT(0), 0x1f000),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x4b000, BIT(15)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x4b000, BIT(16)),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CENTER_PIPELINE_CLK, 0x7d160, BIT(0), 0x7d160),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x7d010, BIT(0), 0x7d010),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x7d01c, BIT(0)),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_AHB_CLK, 0x7d008, BIT(0), 0x7d008),
+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_CLK, 0x7d014, BIT(0), 0x7d014),
+	GATE_CLK_POLLED(GCC_PCIE_0_AUX_CLK, 0x4b010, BIT(16), 0xa9038),
+	GATE_CLK_POLLED(GCC_PCIE_0_CFG_AHB_CLK, 0x4b010, BIT(12), 0xa902c),
+	GATE_CLK_POLLED(GCC_PCIE_0_MSTR_AXI_CLK, 0x4b010, BIT(11), 0xa9024),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_AUX_CLK, 0x4b010, BIT(13), 0xa9030),
+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_RCHNG_CLK, 0x4b010, BIT(15), 0xa9050),
+	GATE_CLK(GCC_PCIE_0_PIPE_CLK, 0x4b010, BIT(14)),
+	GATE_CLK(GCC_PCIE_0_PIPEDIV2_CLK, 0x4b018, BIT(22)),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_AXI_CLK, 0x4b010, BIT(10), 0xa901c),
+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_Q2A_AXI_CLK, 0x4b018, BIT(12), 0xa9018),
+	GATE_CLK_POLLED(GCC_PCIE_1_AUX_CLK, 0x4b000, BIT(31), 0x77038),
+	GATE_CLK_POLLED(GCC_PCIE_1_CFG_AHB_CLK, 0x4b008, BIT(2), 0x7702c),
+	GATE_CLK_POLLED(GCC_PCIE_1_MSTR_AXI_CLK, 0x4b008, BIT(1), 0x77024),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_AUX_CLK, 0x4b008, BIT(3), 0x77030),
+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_RCHNG_CLK, 0x4b000, BIT(22), 0x77050),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x4b008, BIT(4)),
+	GATE_CLK(GCC_PCIE_1_PIPEDIV2_CLK, 0x4b018, BIT(16)),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_AXI_CLK, 0x4b008, BIT(0), 0x7701c),
+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x4b008, BIT(5), 0x77018),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x9746c, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CFG_CLK, 0x4b020, BIT(15), 0xb2034),
+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x3f00c, BIT(0), 0x3f00c),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x3f004, BIT(0), 0x3f004),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x3f008, BIT(0), 0x3f008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x32008, BIT(0), 0x32008),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x3200c, BIT(0), 0x3200c),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x33008, BIT(0), 0x33008),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_ROT_AHB_CLK, 0x3300c, BIT(0), 0x3300c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x34008, BIT(0), 0x34008),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x3400c, BIT(0), 0x3400c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCPU_AHB_CLK, 0x34010, BIT(0), 0x34010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9), 0x23018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8), 0x2300c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10), 0x2314c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11), 0x23280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12), 0x233b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13), 0x234e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14), 0x2361c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15), 0x23750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16), 0x23884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17), 0x239b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18), 0x24018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19), 0x2400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22), 0x2414c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23), 0x24280),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24), 0x243b4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25), 0x244e8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26), 0x2461c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27), 0x24750),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27), 0x24884),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28), 0x249b8),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24), 0xc4018),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23), 0xc400c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26), 0xc4284),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25), 0xc4150),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6), 0x23004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7), 0x23008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20), 0x24004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21), 0x24008),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27), 0xc4004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20), 0xc4008),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x20044, BIT(0), 0x20044),
+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x97034, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0x1c018, BIT(0), 0x1c018),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0x1c024, BIT(0), 0x1c024),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0x1c020, BIT(0), 0x1c020),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
+	GATE_CLK(GCC_USB_CLKREF_EN, 0x97468, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x34014, BIT(0), 0x34014),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI1_CLK, 0x3401c, BIT(0), 0x3401c),
 };
 
 static int qcs8300_enable(struct clk *clk)
@@ -74,11 +559,27 @@ static int qcs8300_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP0_S0_CLK ... GCC_QUPV3_WRAP0_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP1_S0_CLK ... GCC_QUPV3_WRAP1_S7_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_2X_CLK);
+		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_M_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_S_AHB_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_2X_CLK);
+		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map qcs8300_gcc_resets[] = {
@@ -112,8 +613,12 @@ static const struct qcom_reset_map qcs8300_gcc_resets[] = {
 };
 
 static const struct qcom_power_map qcs8300_gdscs[] = {
+	[GCC_EMAC0_GDSC] = { 0xb6004 },
+	[GCC_PCIE_0_GDSC] = { 0xa9004 },
+	[GCC_PCIE_1_GDSC] = { 0x77004 },
 	[GCC_UFS_PHY_GDSC] = { 0x83004 },
-	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
+	[GCC_USB20_PRIM_GDSC] = { 0x1c004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1b004 },
 };
 
 static struct msm_clk_data qcs8300_gcc_data = {

-- 
2.34.1

