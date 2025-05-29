Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1185C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761D2830AB;
	Thu, 29 May 2025 17:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYLsCF0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9250C830C0; Thu, 29 May 2025 17:50:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0993830A0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC22Oe025645
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E30g5ccuAAq
 88mlvHnvwUf1Br1G4RJ5OXV39dKyjgoc=; b=XYLsCF0ktbPqblF7tHLYkJT9oBa
 4fJXAF3Zpa1C/TNoiNTxr9UYcaZYJkpp/tRM3GqcNugTRDBcxdS2KTg/IbxLHwpI
 CuSYqKz5ZYX9An/aYfj+OC7uW5cGKM3UtmmqGbWwAPSl4Z+s0LplyvIMNaEVlsFY
 h5B5EyYE4NlXYBvcwYHGDsiJs+a2SL/SCNFE8OTA5NhqtNLoOUbxsl19HMyCPcx+
 5RTiJO1wXo9txOQjmTIcy2+EpNiA6qAKCliZIvJdvS6SiutQnYK7BoUOFqaqVAYg
 /PnQ5XUvMOS0pcEdYPU3XX25kTkG4O2zvQ2ZU9ua6p9CPR2EHUJ8ymF6vAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mvfw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23507382e64so8179795ad.2
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533800; x=1749138600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E30g5ccuAAq88mlvHnvwUf1Br1G4RJ5OXV39dKyjgoc=;
 b=jvY8Wq06ckzkdqbqpZTiTajAHREYvUdi3ElrOjB2wbMtjrUx+bi//CoR/qZqu+d6sa
 1xLTegJrYhm7Th1n/YEXIUsU3422MH8qqAFPQdhElv8dGamgeQ7jnVKQEbucgNJdDdUV
 FA+pnxDBI4O5T8NLB7zvhgLG89ij6mFLc5Wi7/RZfV+OnarTkT695zc173W21nT9QnTE
 Ueqms9Eytt53U680PYYUpsqiljN1Xsk92rcC9M+CLCPvi05IkM4mGXk78ppY0E2Gv/J6
 thQR+Yn8TVhqK/uK/6C2nHlzFpnGEG5E6GXPACQ2tfE9/0bKECme9vSeBL36XgjVZu4d
 hhLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVor//v+pOUjWDmm1gEuoFnJ8+s0ri2vkDiRte0qWxz4Kk00P1OYI0uHGIQ9zscUF907itHQlg=@lists.denx.de
X-Gm-Message-State: AOJu0YwHe8YAKWLS0/qmGvtPVMjFE1pQNRD0RY0yDkFn5CveWsPqmlFT
 d4r18zgPuM7cM5SfXNFnw3/Ha/KNxABp8T3dkk+SpowSJXcbJLen6LtgaYbviJuToLMDDFIA3VG
 RftzL9V3TvBhOJRI5MCfiUiRKD/xpMh9QpDjjfdhRbcEwH6Ukc4Kqn8oV
X-Gm-Gg: ASbGnctgFzCCanHw7ncXpGuype4v1tHOE8jKijgBcxSbekoE7ywLybITKnanCTiFHMU
 2yil6fjfZuwv8M+yr8hfIbujgRN4BCxBQ/W/X7VlLnNyCOxynxtzlEWOYPrzQboBPcLyqK0llZi
 OrYnqy9tADMpyZAgxCwkFzA+U0HyZAodqt2WTP5c+FU6fXwdRL7cN4HtqlfR1rxVP/YeueccLf1
 11o6mgB02u2LITT2v8wwXwhODTLtGVeNbh3PXaBNeVlXQoqhx7Zt8wkoApmka4PAhfeD36qiBBj
 Y2ol+OanSkK/gOUkBw5om89oLl0d5CgBxZQIwwKUD4b070ghJfARXKSKF8EjOnfjXT5u6WHXr92
 A0zHL8ex+yFZU1nHlXWqf/SzMGQo=
X-Received: by 2002:a17:902:fc46:b0:235:225d:3098 with SMTP id
 d9443c01a7336-23529a09ce7mr1134745ad.46.1748533799647; 
 Thu, 29 May 2025 08:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoU+f3p4Fo6+YlOrtwoxggzY5pmj5eKjzWYUxjMpi0tnqtCTsdvRq1TCSEJICQSUd626AOyQ==
X-Received: by 2002:a17:902:fc46:b0:235:225d:3098 with SMTP id
 d9443c01a7336-23529a09ce7mr1134425ad.46.1748533799279; 
 Thu, 29 May 2025 08:49:59 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
Date: Thu, 29 May 2025 21:19:29 +0530
Message-Id: <20250529154931.1879976-5-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AWFVyLUoDlmWqnlwRZS1ORIyVO7B1Pxp
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=68388228 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=CM20g2q486A-A9hoUMIA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AWFVyLUoDlmWqnlwRZS1ORIyVO7B1Pxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfXxvvm+6/nC5lu
 EnRSJFmz3LRuSRr8Xv+ec5NuLVXDVgB/XLT3oZCQiT646/GHZSgfw+4ya+xPzs+0sW2J15tDw5m
 7zx0gmpGjl6uk51i16ItjPGO7yE1fyuu91L9c3NfYHvl8kau2rLJAezgDJeeWNIuYXDdAZS+LIO
 +pzkCqNRPwoCLKz7hGA4ZbiehHc3PokUOKiwfctQefB8Um3PuHkahPnbhkgiad2qfziqr0xlO3Q
 N2ZJixaaZ7DutN+qA9DXMFB+KSFn4zivUo6Q1RTSn+cguc9w7TE91pTJ/kq2joaZbGRQkP++9zs
 wIOkDIV/S51rEevDdTVU70y//vLd05UOQtO27jxkDktqc545lk6QmWa1cyGl7vFurU7Paye0n6Y
 ZuL8kfbVwDyJ/uXxdnfTIFx0esE7NYAJGuhDEt0RD6jPdMRNF6caFuSTTKKOZktAKYc2lHSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Enable QMP phy for QCS8300, referenced from Linux.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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

