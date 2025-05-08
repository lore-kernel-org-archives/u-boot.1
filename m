Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C0DC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69EC82A3B;
	Thu,  8 May 2025 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l25HMio6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C449482153; Thu,  8 May 2025 13:20:38 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B23828A2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484WSgP008582
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kzAjyjmPyGI
 s+JVOPJCQClSjv9O8jUlxxjJXc2Yxc+I=; b=l25HMio6r20xkKzCPBPLrlCaDBV
 tUVd8vxqzmIHObHCnRVOWCIxoyVgX5SxlrWgycprkn0uQjSg2A91jnLwxxMpddBJ
 Fo+PTkysxEgKAUmTlDLTn2f+I+wArH16OPJkRAVhixii5wZRkJDDHLJty+T8HQId
 mczFaRJgMeGlhFXxQMsAAC5671HmbZKJj8QsoqCyHNe1wx+NK8bRRxRkOPWOQPdu
 cKYMj5HNeHmsIfh1Rhi+ZI+lHdJp8CZbLneTAZWKXXu061BUCuD2/jfeQ4L69izK
 DIHjURz3ySVp4wyBEdI5lbvX4k2pv4DN3DsPI37g+mI2Skqc6rw1ctejJZg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp5940m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e50a45d73so9409055ad.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703233; x=1747308033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzAjyjmPyGIs+JVOPJCQClSjv9O8jUlxxjJXc2Yxc+I=;
 b=nNFKMyc0uuUn0Zxonqb83uYR5Tjg6pERVx7+2oyHazR2w82184Uekh+pNypu9FUJJW
 NfOjBb0o/t/CNr1OcyoLrG/0VfypuqZj6k6sTLOI5TolySrwDnBRWnkYEW38Exn+HG9u
 576DBSkXNV7VyxO/ZYXAo5VMqcynVdR4gTBCiCrIs4bapE+SD7Q8/3jMSavhBntuXpaT
 dCk1dkSLp8PrWj3Meo1XXECkTrvnixqhJWDpZ7MAwn+1k79I4U4BzKenMtqu1Zm290tu
 9J8xORmI0g7UXAzftHtSkCj72wOLPaserA/GwkJCAmSX3jGpd2l/ycc2zoQcvFTTr9py
 cWlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKTx3l0EEfbtoXzkBCpgiKJGdgwdM9L7lIrnsVUms0aQDk9eQQ+9VemaEE3mccih92BcfH8hw=@lists.denx.de
X-Gm-Message-State: AOJu0YwjKMhesSz7HRBXcAZQqmYTCyb3OO/f8N59o9mKjnSRq3yI+3rn
 8cWLSdxgHZU0UMkd58z3y0hTxcw5zOVTnmLrFZSQP055lZC/D4nOJ39l4dUQQgiutfwgzrWobKL
 ybouWGqCUVNz7nEl22j53IFQPPTs4RgWFYWoqWKWD/C0zsA5dC3Mo
X-Gm-Gg: ASbGncswKOUEnFP7HKmaMaBB8b5LM7PyVTQbDnfn9AAVyQEjxTljXntM8IWK1g7lnEo
 fgf6xd9q4O40MPswTNHKAINo/9B5yLTfCcI1aZ+UNjjkA6yHP2vYhhkP+5Y0ZhRHDoQWPcd/LoR
 +eXuy2PawXqfqCj/5HylVzHUBbtvmFGTdgLzkj/rLQqtEhfiLHS32ABm7hNemzy04wXdoZt3ykP
 v/lJWvcQN2decYAEVJVO7ouqNLniGAXUWnjSMCy7jpj1Hsy2/yHaW/N2ml4DPVdkuLf6oXX6iA/
 reUiVpEI9AViU8dUUbDTYY37gQPSZNsOR2YZ9OuQ+QmE3GYHumfuc63n0EL+22BxoEKSu4CywVA
 dvW8hXhP1m6p+7WRUlsHQ5ZDGJP8CJvH60zUShUqy
X-Received: by 2002:a17:903:40ca:b0:224:abb:92c with SMTP id
 d9443c01a7336-22e5ee001f4mr99533555ad.50.1746703233083; 
 Thu, 08 May 2025 04:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESDKVBjJ1fCM3bS7TbNEV6jSsgTnhHQ2AK7HsgFgA7A0xSRvgTxXkSHvaSqunSU2sY/DwW5w==
X-Received: by 2002:a17:903:40ca:b0:224:abb:92c with SMTP id
 d9443c01a7336-22e5ee001f4mr99533205ad.50.1746703232736; 
 Thu, 08 May 2025 04:20:32 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 6/6] configs: add qcs8300_defconfig
Date: Thu,  8 May 2025 16:49:52 +0530
Message-Id: <20250508111952.2304578-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Lu2Symdc c=1 sm=1 tr=0 ts=681c9382 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NkmhtpHSqRJ8R7dSB0oA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Gsu8h1VfBcHBgpK6bix7AQ9t_qmRrk63
X-Proofpoint-ORIG-GUID: Gsu8h1VfBcHBgpK6bix7AQ9t_qmRrk63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfXxwFf4PMhOb5D
 YeHncs0pzPRx4w8w4SPzdjla7bZ69SAeYvLRHtfKB7F+Z4k7JuWrMevV0m2UOSm854rjtp3qUXD
 5XfZlPO/Gp8v+RTYC5QgLv8hhoGCjsOVl2mmEjkqZx6zul/1c1+206V1IHepBrsFHJm11/cPhbf
 LoL44WWlSIi/xbuuDDp2Q1S63m3Aqa+xLn8kxjH91i6pbs3VRSNoqqE0xq/n18Wg5FsOAvpwrlF
 o0Ot1zvffSRom3n2r959pyKsGBGmKTUC/ZaLW0vFGKfjTWZSg9KN/nz8zXfZdhW/OvV8n5HBoVd
 bglVyw4FkAJbS8VybVCgO4LIMRClPalAr5rBfHjtH7SGzhlejoHySfGNiy2O1U4gQ//z5NNa8Kq
 LOFmSuyiwVuRXQObuMdd9AQeCMFFXX2KV0P4AFp2di5Mm1sN0iXCsJuZjM6MOkAvBIv3dU2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=838
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Introduce a defconfig for QCS8300 based boards.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcs8300_defconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 configs/qcs8300_defconfig

diff --git a/configs/qcs8300_defconfig b/configs/qcs8300_defconfig
new file mode 100644
index 00000000000..06afc45ec33
--- /dev/null
+++ b/configs/qcs8300_defconfig
@@ -0,0 +1,21 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x99C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xaf000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
-- 
2.34.1

