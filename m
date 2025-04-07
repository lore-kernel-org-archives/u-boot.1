Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994BBC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B4882F85;
	Mon,  7 Apr 2025 19:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKblk+q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9150C82FE9; Mon,  7 Apr 2025 19:56:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50682F85
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dxek017537
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 17:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oTsTznZbmVj
 zPt63Wgjh/BHGxNAyxKVaOouwdmlhVH8=; b=bKblk+q3qiwBFs7t/CfM+JjzYmS
 6OaxQw6SbS1/nPDwDQqfVRr5Feq2gHj0Jm9XccF+k2r+z0QGdGDA1VeoJTLoCf3j
 kDT2BcUHjCOinaA6k5CyyznZ9v3AlLcpWvdAWS5pGKv8HchSzDtSvOJfDHznlSEz
 JChyWrWgcWh/8UOgsJF8dqjPghPyXm7aIuie35gqAWZdQOkmVOXDp1IOXO76hZDP
 /h5I4b8hgV/ExksWYmB+cn+yl34aTRsV2x+YS6ZKkZ6Rz9zlYfj+C4/J2vkBlei0
 TGDxC0Fplvu8EDEnOVLVmUCGbGsUpKO5MPYrClMaAAWBiCBJatLjB/G0ihA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3d1ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:56:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5e2a31f75so1481955085a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744048591; x=1744653391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTsTznZbmVjzPt63Wgjh/BHGxNAyxKVaOouwdmlhVH8=;
 b=juj5+3svAowz23t7e63oBDoQIQuDJpoiY4OAf0ibWZF/Nb22mzz1IqPPaCLPTUuQyH
 dihDUtxrkx9hVbv0OGMR/fOzAtv1JNmOq4rBWG3LoO6oO0SowsVX5/FYm583pVUUgbdY
 0BKaj0u0seJpwL37eZcS8JgJkjvxKxaBKduA90soFh6WlvzyZl2cT8G1qqdAw5nAX3h5
 La5pxFeFnzACrdQLk3NDlto8WaPEb7lyq55r3YjWbD8Rdgq6IJ1YRcNjQiJrusQzvYpx
 fYHlBKDpccHLDBrJxuOhb2wCQZkaKhR7AoTxid4bV3ho9ANOECrWBi+RTVno8cmsUA+1
 wv5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIKXjFKouv7shE8yZj5JQFpGYZaq8p+hUMgyOVsIeW3AQd9bJ/3j9qIx/3B2TL82G6JxdFuYQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyV3eKtuvWZXO2PEXzYsSonHhkYh8XzdV5Rob6ZARKQyQpcWd3a
 NI7bDZj9FP1AHmIB3W3D5ck7eoe70UY/c/ELLUay6unkduxC48N/eAE+CDv7pEMsQf2rVWvFOBe
 OfGBwHKh/34+79/XKXqt8RvZG9kLpY2MpN6+//yCveHk7WvDW88Tg
X-Gm-Gg: ASbGncvoPH9zHyNVetwBigKPohWqL1GW8BkeJBFBR0qdazAXkyML7gN7pZiftPeo4MF
 Xuk3dMILu4eF+DXPfhqXMXdmvQHnZaX/Vo6bBRO2fRe3nQqieHYbFDYKhLdYIjyxJ8DGnMO1ceV
 dXWlfUdI/GlKVhcU3YaJOUUR2/2N7zeYVjGsV7ESL/vq6djUoEP/AphcUUF7nanQ1iko9YMWit2
 174GaOFbqJWWymiiBg6nmVc0DVZ2YUnU/CmCFfnm95AeWiR0CyFspCDYH362JVBd38Rz+X9N8sQ
 eDRy/lGiA5k/sgUnSKw+zUtN8v7R7t0vFehtOBhESQgJkjvZvS05v4MbjGmItpDkBiE=
X-Received: by 2002:a05:620a:1a10:b0:7c5:57cd:f1cb with SMTP id
 af79cd13be357-7c774dd6ed6mr1804224985a.37.1744048591293; 
 Mon, 07 Apr 2025 10:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2O0mtZP8ev274eexyMFEVqdg/0GWP0y/P92gyfJgcVt8i8GWuEJOhVKYlDeUUD3rPMGqGg==
X-Received: by 2002:a05:620a:1a10:b0:7c5:57cd:f1cb with SMTP id
 af79cd13be357-7c774dd6ed6mr1804222785a.37.1744048591054; 
 Mon, 07 Apr 2025 10:56:31 -0700 (PDT)
Received: from trex.. (65.red-79-144-193.dynamicip.rima-tde.net.
 [79.144.193.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm139346005e9.3.2025.04.07.10.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:56:30 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 5/5] configs: dragonboard820: updates
Date: Mon,  7 Apr 2025 19:56:17 +0200
Message-Id: <20250407175617.3494506-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R-17fB_4PY5dZ5Osm61vxD-6gE-0gpUD
X-Proofpoint-ORIG-GUID: R-17fB_4PY5dZ5Osm61vxD-6gE-0gpUD
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f411d0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=K4l/FCcx7sfGu+4G7WjjoA==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XlkOo350nRwr8vCprBUA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070125
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

Configure GPIO and CLK_STUBS
CLK_STUBS is required for MMC initialization

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/dragonboard820c_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index e29bea7deb2..2a5b7212f74 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -45,4 +45,6 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GPIO=y
 CONFIG_SPMI_MSM=y
+CONFIG_CLK_STUB=y
-- 
2.34.1

