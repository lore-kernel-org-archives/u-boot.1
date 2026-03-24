Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88994F532DD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 05:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1938366F;
	Tue, 24 Mar 2026 06:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ByulWWWO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhhXt+Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04CEE8352B; Tue, 24 Mar 2026 06:52:48 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D79805D7
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 06:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O4DVds943506
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Cd+czKgb4tiGrpdizKLZoJ
 a58fEippXcZ1AksYB9wZg=; b=ByulWWWOLblQ8cRg4DzdrF/4JjKeHEe9QIu290
 s9k/StM0CCKTe78RnLKlxnK6RXffkR9uVESEkbryZOnZA6RC2VSVSzxxV09EB9L0
 hzAkaynVVRLNdY70Mqkx5uCNwBOeyQeiHZ/4/T0IhgenZC2Y80GCJIr9DK7QMtsG
 YZxk4+kIHwFXrk9VACtSWbDcDk3j7wPoLUSLbvhACni69a56dka3uMN8jsfnxP8L
 2Fq4OHgn7gUbTC0mWkitioSxx0KTuNHHrK+dd6/BQmOHXDaMajW0Rg2/U5I4snA1
 UojpVxN5yzS4/o5IMu2lHTGY7NTuxL0tWF60aui85qs7+ecA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkudw4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829ba0e63e8so3001012b3a.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774331563; x=1774936363; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cd+czKgb4tiGrpdizKLZoJa58fEippXcZ1AksYB9wZg=;
 b=YhhXt+BpvHnVog6fSnXW9uwiOzyk+/AfCo9Zzi7pLfORfAlPLwwu1/svX/oPBKY13Y
 VznPEaopJ12vYRiKd4JEWVWnVrHjNpsXISGbfYvD7DlutE2QSICekizh+vlNcJ6q/WFD
 JpGBklq+kSpqbEBP1lmgGiKA3Ln0vSudR1uY0uZbHBVX3CyWTy64QIAKL+6b4ce1QBGJ
 vJqczGS+GaPDkyfWSl8aXKrnsZ02Olb4yX3iOMI8l2Ny2KHw4Yhjnkp3TyvETL7itfHp
 DLrTf1ZRR5Oc5QT1t+yUlnQLIXjDzRKLJ9Wl32SWf1YZvUPLZFfEPWZb63cVRatOYr2b
 9A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774331563; x=1774936363;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd+czKgb4tiGrpdizKLZoJa58fEippXcZ1AksYB9wZg=;
 b=HUV9uHu2gvdr5BKUpr47dn1aLlR1shOcznaOTo2klt+40rkbysopTAed8PBvV6sT4c
 TRFfUoMSnMOMRLLuREhFBoB/Toj8Joj5HIt5s4HbnmfhKkqehcOizlth9XyPSHPm5nba
 QtC9ngKiAkAVUJE2KE5HKCB33K8BV0PjfOBartMhB0UeRvib0EsiaNCHqmW4gMKPpOvo
 SwfQOMd3RChRuBy0tGs5uLWu6VmEneUcG2Ro9x1uYy/99QB8pYHf/asU16QStf3R/aQb
 VERB+Kf+kXG8r0VSw6J7cWrzBnaN1bO3az+zpKdv0m+MGsre31TtOm9Kf1AqKCFZHJt4
 sXLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj9q4YPao+0u6jwhfaq7WQDmGFQtQCUtHi3e//JIrfgFZwNB5a8GGtWF9udYaoM7qGzbPcDRI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzkqOP/fDipqtkuvDINBQjoJ1z5IT5XIaN+XAJVImyAbVLyTV5
 ogQW7ldlUjkRCTEtqoSCI9XBJctr9lqFwEgqvqSWhniXPbaCLSYrnXRovBFsnacuvl9u9iknMF0
 Se3DER9pBjbvKCbkNXCyCHOwh9CqEY6jxuizktdOTXr9NIFVNvBqE/uOu
X-Gm-Gg: ATEYQzzYZ7mHPkvTUpO1Ee+0VSu0S3f+/53otHC8VArlsJqlSkhzA26ubXT6wtO2PqA
 CVc7mDdCVXaf3FGSFs+hbsaavDT1cNOI7uNpcFy92cFh5owamU/cQQLUqrvQe0+rHhyyCS+sbMM
 6QLW4fJc4PaaWjMlIxi452ThfcuFaAiq6OPZoFyzSyfuheZo55vXwxchPDwzozEYoT+4uV2vJkS
 guIHezsEg3DBqcF66cMq73T94vampsHy9zVu3KaErhK9nfaAN27CXEJgk9E7vLY7QhOcOSEaqcn
 NCf4w75WOCqWp9mFaZzOuLsGDiub4haPJT036QCpMnoX/PaCVPmAUMSToxcJckjcXJQi+JjZByJ
 GNN9HYZos1yQjVEqZzAc2w5sK9IIgDlYNjaq6ZTzvec8/3Lf9ztE9Uj6ynUwOFC4cPdz0S4ZM0+
 sL7X+syU08L6kI1+YrTXfywOwl9Iaf3eZRs9b4D23KLz0CO/h4bQ==
X-Received: by 2002:a05:6a00:1da2:b0:82a:64b1:bb6e with SMTP id
 d2e1a72fcca58-82a8c30283fmr10889703b3a.35.1774331562908; 
 Mon, 23 Mar 2026 22:52:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da2:b0:82a:64b1:bb6e with SMTP id
 d2e1a72fcca58-82a8c30283fmr10889673b3a.35.1774331562389; 
 Mon, 23 Mar 2026 22:52:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm12874783b3a.17.2026.03.23.22.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 22:52:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable eMMC and SD card support for QCS615
Date: Tue, 24 Mar 2026 11:22:33 +0530
Message-Id: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKEmwmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3dTc3OT44hRdCyPLlJQUSwNzUwNjJaDqgqLUtMwKsEnRsbW1AJ9
 OEypZAAAA
X-Change-ID: 20260324-emmc_sd-829ddd907503
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774331557; l=946;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hAlkpWq+oo53uLjmGH7HTfPPDHCRXh9AA9wA3lCz+cs=;
 b=e+rKL5OU6OLjiOqIQvGqn6TV4utKpt1DhVGENdSYU5ASONwYB4uPYEF4qhUeauTqBe0a7aVgf
 fj5KRS0ljHOD1pJaUMxdhDEX4B5SZz0GdlYBw4X7pqOpYTxxFKU9sm2
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0NiBTYWx0ZWRfXxcHg/lcBDe35
 1dVtBz+xnSM8sSM1K3g0jxIw0E1KowFpvunvz1bpEcVUxHOA2pdpvWZCN+hM1xQi6cGb5WYy4mZ
 ZKBsVEUgA2Y9yGvhrabXVrPhi/ZVPnip5BUEfGgAWVi26CPqAEqB/oB3mxdZUPgUQAByd6CdDXp
 WmV7Dn8EO4rcw8D+4fiQ0gFDjRXn3SJscaDzTSWSicMkUPjjhVXLn6QzEnrz5Y7u0+u1NVKoSLk
 NObIeSZNqYOfDdKT2nQBdF/FPeOnnvGdsl5JWwtgaIfTcGMTe3kfJ+DMktQfApke4cKSF968+95
 j9eodhZSRjnTwZKUdbNzrfC0VpaCO3DO1w3Tyda5gtzM5KWzhCcz4DhmfkxZI3uKbTmNy3/3E6r
 3Iy89cFvSXIoyIOhFlm52g/jXwmg3aQyR31OCorotf5vrsf1RepKwZT/GiatVrNdecEcve8Y/6M
 K6Y9Ly5rmJPRwNkKm+g==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c226ac cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=X5k_lUzB0La9wDsTO34A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 31aaWhmbAk_zm99lAwkzBEMcI5ZigUuk
X-Proofpoint-ORIG-GUID: 31aaWhmbAk_zm99lAwkzBEMcI5ZigUuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240046
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

This series enables eMMC and SD card support on the QCS615 platform
and includes general improvements for MMC device handling and FAT
filesystem operations.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (3):
      clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
      drivers: mmc: uclass: Set removable flag based on device tree property
      fs: fat: Limit transfer size to prevent SDHCI controller timeout

 drivers/clk/qcom/clock-qcom.h   |  2 ++
 drivers/clk/qcom/clock-qcs615.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/mmc-uclass.c        |  5 +++++
 fs/fat/fat.c                    | 29 ++++++++++++++++++--------
 4 files changed, 72 insertions(+), 10 deletions(-)
---
base-commit: 5a08f1a98c85f35addfc7e6efb5cb06070bb6499
change-id: 20260324-emmc_sd-829ddd907503

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

