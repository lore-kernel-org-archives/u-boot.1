Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77765C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41EAD606B4;
	Mon,  3 Aug 2026 15:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jc9c0xp4iE5e; Mon,  3 Aug 2026 15:59:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 403A86061F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772771;
	bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QE2LU2tPyJvJyt2CEvlo+CtpwBqs/HMQnXrWckl4Dq6pUyMoJjLwgudbCJPUvHVFb
	 sgFaCzxnbFRCgdiy1D1AzLB1RX9oys1XI3EqphmpGG07xOLznL8Q4ZqeDNFPiRA4km
	 p3pfAB70V0f1kmf8TlCdDEl/W0QhfS/7CU7AwbxTaoRMMLZAsBaJD5QHZN5pGPtPnI
	 dQcDVYiX3Z826qPoDelV3CYeKoMQC4pxvuJMfWl4Y+QqFQ+zt3jvtX2g7MGSr7N5eu
	 Tks8wvp9NXZICt3TeaqLY+gejOxdJWW2IbUz+DtK6S1btnBgUg6c8X9ggamZvm078X
	 KntglbU+mT4JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 403A86061F;
	Mon,  3 Aug 2026 15:59:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B09022AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1C374058A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RJUvr80RvDl for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A10940571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A10940571
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A10940571
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673ECAFc921068
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:27 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrtadku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5973077a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772766; x=1786377566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
 b=AheEZSe0kgAM8kwoB6YzkQ9SC3KxfJuHqYyz3oYRmHT/l2pZ4K96pqa5CfoDA83VSB
 1bQJGu1+3T2te6E+4ud1khjmnR1/5izL+CN5mc/cQBGm68mlZODLtaQ9D9WzmDiBiSzS
 Gukyzgq3ZkiTbr2QGKJ/Q1npFAH/YOi3BjPQT1YLST51vI66I5TsrMmou0z4T/sCaH6U
 UEIsroxygiMU0Bo9RxYNtH32sTcqzicpcoB0MOWnKC1gR0rpBrKM+RkQnDcnEOqxi9xv
 qldH/yKid34jkPiOoZ8bolXQZk3lEXJecuy/DZqK0iPzQjiSYr+lSfV3eidO/Vp6/MWb
 KHLw==
X-Gm-Message-State: AOJu0YwO38Os+uCHGnPL8rYD46tzfwk3bu+XsXIcCeEfFjscNax+Yj4s
 O+l3npkXw68ogj5fDgntBP4/2zxTMeppKkBTwAh9lWQODT7enPbCTRiRpQuIpwUF31NI4NJJx84
 7zqMOJKqDJHMPphgYYKFX8M7ODc6wojmQSxPZbNU6ReVlXFTDhmUXz/iqHrlknCfBJ2pk0w/Fel
 Cjkok=
X-Gm-Gg: AR+sD134w8ZMk6hw2oMnh1St60IRdaAbM5N9ozXDYHXME5Z5tZlOBk4/izB3jzw6VEQ
 7mnLB8+c+prTjrkuH4sqvmaePFOyEjg6N7PvWRBlXWfCSg+78+SRvMm9A2fzwyX1iV2OMsdqQKI
 TXZv0TUxpWFF4Yw4mFuhjw4ACXyXWdI4ahNg3UkjmLPypSD47T5K+Fp3j+27IW44K1Gfu0afqUX
 nT5P9ujTbrhen/2Z7Euxj0MG54Mhyx1GjdLJH6+uG3mUpc8A2Z+VTDEBjYPaewFT2L6AI3P3vSf
 1sM/v00vokjBswVJ1VA9wLxIun0SxiQkv4sfXJrFTB5k8ucZy+9lKZaaeKdV+brKgIOcDwDiJmu
 ruTuAJyAaFlrYN8W4/C4EleLucEAre8anEgE5DULdlMEJmn390cmjQPlEu0DeNMMVTJ1nep+qgT
 0tMZGpbhsrB/NymbTDqNAxydn4QP+i
X-Received: by 2002:a05:6a21:3947:b0:3bf:a681:a262 with SMTP id
 adf61e73a8af0-3c92a83843bmr11821538637.38.1785772766239; 
 Mon, 03 Aug 2026 08:59:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:3947:b0:3bf:a681:a262 with SMTP id
 adf61e73a8af0-3c92a83843bmr11821497637.38.1785772765815; 
 Mon, 03 Aug 2026 08:59:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:25 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:51 +0530
Subject: [PATCH v6 6/8] arch: arm: dts: remove Lemans EVK override DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-6-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=1380;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7uNHodD3zCjNMDFWQCvIZeqNbmqWpPLlBx1nho0cur0=;
 b=3efsm+DzDWWgBVqrRfPqvjg+6KzOrJJKv3JFmHPI1hby7RSrEcf8gY90QpTxC0BzR8/hQmmH1
 +be2bHkKL1IAcNTEPl+zqdPrp9JShLs4sSJGc+2UKE693U/fwooyMaf
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX0k2xGWUVQO6w
 P+9N8B59oDvWBGfj6Pkg5/Ybnx2owhF9XOFmMLdkdDedRCrwyxhCiQY5k5brb43e5bAr8fmrjvt
 HQmqmJovi1M3UWsO1L5L+j/NY+OSBDZpvsmvbjDQsfOta852yr3oTgmDNZ/n1UyhMJC4E2pqa54
 htu33V02SDJ4ol/hDs/A09QTLVCbu830lwj0RfwAd9Fq/UgFW8ZkaeMrJs80WFiTUqNyLER8Vku
 gAyO0lJtJxCVLHABkXtIvh04vbQdNcCNtN2VgPNOA2b4Ypjo1xs0fbCSDhYKxm5P2qQguKmOveD
 DGwRQ+8UhqTIckUfxkeiJzQLYgx51Q2iHXGy2amszeDHSgNTZhm2wUXFLhXDerJw+P5dxbTE1RD
 iColGMAHuYHn39lnfZ8p46Cwi6vKbZZG6JNbem+yCVg4YidXeFcdwohETmKlL6wA/RwaWwV3RWz
 0GhGImy7x4I4g4SajZw==
X-Proofpoint-GUID: OaJCgCDiZQcF3G9Re3NW9eP-F_9-sHJ1
X-Proofpoint-ORIG-GUID: OaJCgCDiZQcF3G9Re3NW9eP-F_9-sHJ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX4H+BE7kZnN9f
 WkqSeAU0QDWIwJ4xfGPrbRUw7M61DNjWlHGBFXkrub2/KnWtvJS0upkoBo5vDf4bBOpQ5BNrZlV
 p1ZYsSJs2WxjC7BnZdisE1VrnAw7grg=
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=6a70badf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=; b=MXKLZ+GvQF0gvXqQ
 FWTFmjXF4bwBDOJ4eqmc6onSae9AzG6AWtK+gUJu5IQ/E7pE2b1wR2d5vRTpJnFu
 tWYfWPnyJC/PgnA1ZOMc6/AGjpi3wNlgTBeJx+xGNJ9oUBLidkBvn6Uy8g3KvyiX
 CG0v8Y8Yz+UFgPQ/PksadnG8NBB5ilRVQx4Ss6HDjtbJ9ecpYaWoO3l08sJzVpUL
 NFLorKX0QCouajc6G6u9gN1NLMKyHwlh9+ulfebSadPeif5Jc8ogJkADF3zP6qo7
 xmZLKugCCoY6YGBCv25ws3f5o+fBMrC0bbpF+1+8CB0PXFtPbVSoTKjFLHYXBF4p
 /YqzOQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772766; x=1786377566;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
 b=JQsTCAGKPDZm3PjHHYrbjtb+I2mIPwBpKyZaFwUpZ+41kpB2cEq/CxzUwZipVc0fVC
 ZYU3dU0XTtZzqGquVP+QOh9bKxS5A8JEzDbo5ExcX4NuqGPsIjbBHlkYgiCwdCKk0X2q
 sWfuNMgB3U1iK1jRV4DC+Jw30cErvBrrCbLh5vAfIkXDaGq0nAWveQP2VW49cbniZvB/
 czlAaHRZp+UQSk9MQDEZZbWCCgvNZJNKGnHIhJS/D5AzhBVp8+ntp7hMX4KaM1uojbVT
 nkHYSaZpO5GGPvLsoPkbH8VjOcvZuEUAEnoUcl8Da3SxVNlnZQHt1ba96xDr5zco7Iu5
 ILuw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXKLZ+Gv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JQsTCAGK
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

