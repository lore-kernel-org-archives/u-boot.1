Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99727C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92AC882C87;
	Sat, 31 May 2025 05:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ma70J5tM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE14A82C65; Sat, 31 May 2025 05:20:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2297082C7C
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V0JhEX018981
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AlNiGC2nnCE
 awdpeJfgo2wrMLx2l7l+5iH741a5LRaE=; b=Ma70J5tMUtSxZ+UNR47ETOUucJE
 3kg+Ct9VmnBoYE7vWTxpfOg3qQTwYUl9qQTit4L+s3b76Gjdpq3OOyKQ4hp7BjX2
 WVTm3k2Camir6/54tkJIP3obL1GFVZDHgmYr+NZ8omVp5Uej+ZbKsTtIywXsH3we
 SXYhLOiVXPfuKmNnPwXS8Knumb+E5cG0cPPFmQZYe7bzH/CMneCsgpVNjgDift/I
 H2O8GzsjyGSqa3tui5c6rpFHKf4YV7F6cIA7Pjw6wtKyimYlpF9GCDru32klm2DW
 IPiWEsiKf67+ck6OvpRbx3E9DHvJCTx9GNfYh6H3iMBkjdQ58kQ21KaIS9A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yq4q870s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso2876773b3a.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661634; x=1749266434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlNiGC2nnCEawdpeJfgo2wrMLx2l7l+5iH741a5LRaE=;
 b=gJMBhcOREWnBiJ14lBiX/A6AwNLzpv+A6rNRI5xUNmGnVYPNFRKc7vV6yqsMy9Vy2n
 sbA/18BR8LU6dCeXGQ5jDWK5k9Ben8B/fBNt8/9dtt6RRaBufuT7dpZGt9Weab3okHnl
 sJ8fO747VU9Xa4rlgXJqAhrVUMu6rJMrlggu1qv7hVnqPxhvXE6skVAG5JTOd4/6i0X6
 Z3ggJMMMPdCtNUyRedyh4kMx1pl1hj1PJ0/+vmD+aDVg1bAjFCCSXei0x3UapA3yz4Wf
 e2n+HUftiQwU0Zi/CO1wnpi07qcKvunO6I3HmsQG2DPUZxyI2IUbXQxMDC/DiQ3zFchS
 0aRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb1z9lpBuO0kptTFwqmqqpv7R6nfzWkqWdYNjRpM5anz2ETpdFhRZ74QRUq/7XOB7jS3UOoRs=@lists.denx.de
X-Gm-Message-State: AOJu0YxcqjeCMR+f77drv7g4acCxh0MsqGyrSSlZneiucyrbnmGLUgSY
 QDSFmg1R5lgI2PrZHx+U8o3VhsEB49gD8Sva5aYNUlMgARuEYM1oxDTbgRZ7ZkvU0yqF0KEC5pH
 xhsc9QjL3eUevYIYb0LZsEyNLPgoTqI56mFSLgbv0v19wnmBt3sj6nbEJ
X-Gm-Gg: ASbGncvPD64UDUCBwJNvEXyA0FJsZJVGys6BrrlYcldij7u3VY31pBv6q70BvBVoSJq
 /xHqhvCA7llRHgo9iV3Bs6bj5OUKzf4pVujK0Ra5nvDc0uJ6UOa8vbyUJZUuSmITe6COT37sgmH
 peETWDlEDFjb8RpM0cpjElsyFxREZFzS1+97wZoY4trkSvPJ1KtX94Iuv7F3/L8OrX/wLOOB87i
 TRWiaEJSnlezsxeeGjYu5WrT8IBhB2n9j5AKMU1BZgGtLHd2ja/JMkGLD/Sqb/xgMG+A6sN79ME
 1CDsUtUF6gYHYjDtW+YJRd1e/4zP8Gu90ZuIm9+VNeuKJWw6l1ZBRC16jT01F2oi5B2gzZ+MT/S
 5VBAA667Ko8Ju/XWueti+UVPPxEXZjca6v6uBASDO
X-Received: by 2002:a05:6a20:f3a7:b0:21a:cf0a:51bb with SMTP id
 adf61e73a8af0-21acf0a5a2emr8623183637.11.1748661634544; 
 Fri, 30 May 2025 20:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrDiGKnZuI08p60P6iIwfbGoiDL6evg0p/QPVgPC40Ghejrz+v3E/4xcl1kKNL/HPmIIcOg==
X-Received: by 2002:a05:6a20:f3a7:b0:21a:cf0a:51bb with SMTP id
 adf61e73a8af0-21acf0a5a2emr8623162637.11.1748661634155; 
 Fri, 30 May 2025 20:20:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
Date: Sat, 31 May 2025 08:50:06 +0530
Message-Id: <20250531032008.3083716-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M1mmVJsj1fZDqtfQTW7NNPkGL3mlrYux
X-Proofpoint-ORIG-GUID: M1mmVJsj1fZDqtfQTW7NNPkGL3mlrYux
X-Authority-Analysis: v=2.4 cv=Hq12G1TS c=1 sm=1 tr=0 ts=683a7583 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yh0L4r4-Cwy3W4RJ5MIA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfXzdypjFe4UzPL
 fmvyfWehMrTnnYVgeEuWE+gtSMRfnHEZ69O09hlNZ2bZbn4x1WzUnOFe5wKg6jRIh5V3nWnJhbD
 FQfsvmWZTG0eusASM9JNMPnreaLAcXfzUqQqpExXQLpVqDac0ysgITBSL4i8zGV6CU7K8U9F5Vu
 tS3AW7xBhvUiDCjHzP3ElG3bUau3akubBUUTw0/NfvGzCOrmsXQjeyJCjDFlBtAL1MQoP4GEOCk
 r5e3/B+wSLnMlc9Bwvg4p9HMLtAzeMJ9l2wGUlJ46txVkbjafzi1QvSFVOJ8wkR4yXovAlR/0uC
 +pZ1tX88JwW+AnFCtw3wdjVXnezZ/emvwN+EaNIpEB8MEtpgCuX6T3MUCADPr+zMDFTsfTUIBQh
 ZSJMcpmlvvZZ+z79BsvICn04qTQH6lNfoHUwQEeyUnk/Qm3/sctjFClJxJ57IDB7OOAwiDxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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

Enable QMP phy for QCS8300, referenced from Linux.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

v3:
- No changes to this patch in v3

v2:
- No changes to this patch in v2
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 449b9767778..18cc665647f 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1469,6 +1469,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
+	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
 	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
-- 
2.34.1

