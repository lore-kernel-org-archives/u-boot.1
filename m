Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1DF43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33073842BF;
	Fri, 17 Apr 2026 14:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqseDa/k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtZ7vEYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A908484297; Fri, 17 Apr 2026 14:11:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D674383B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H80TP81872515
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2Jhec41VKiB
 Oloo9Ug+07KCijgFK9t3MsDM1aLwHyjU=; b=GqseDa/kI5fdO0HA6LorgXPPKJj
 vjFjKb2U/KLaqnj5jolOMWXCrBGI11tzz/ivPH9K+lajJN5YqxzZaK92RI+UL9o8
 PXR3ZiU5fuZgQpKKLGFxCsgBi+NMrKMuL+ZkZxb1cDkCw+IM7oPW17AUiQDbd5CD
 Sji8aBEY3/oFMnnsF8pBmPOaDhmlwfd59o0M4MOnvs4XWuXM62v0TUPoCYtdjqjQ
 jQDLkvSp6JUz0ra74tYDllCmucH+DrtMpGV5mnRdAMAZ9fyNJMe/SVmP90HaeQ2X
 n5zG+6dHyuUR+gUlQ/JXlioSpJ2rdUOQ45vAO4+O5bMZgwR7/61PFPCODKw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2knby04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8230d6d54a5so1253114b3a.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427873; x=1777032673; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Jhec41VKiBOloo9Ug+07KCijgFK9t3MsDM1aLwHyjU=;
 b=UtZ7vEYH2adJOn1X6v85ROg9csSbaQ9HowW8cp3euUGWjVx37MGbTI0IttXbtlPUOU
 ij2Ul/Q3HL9ndzfUsbg5MM43iXgSmtZcCDFB9vdR5PLkq5JoQCSyhlm+VwN5GaY7KE76
 j7uhpykEpI23GsvCTzJu3J4hUPS5F5GIkHczaAGwCuE6VA3kRdpKVgnpXnCm1uw2kE5G
 czAIJHtXPcNx+YHoGOwrkS+SSpeu1dVl18jw0o/x15LgPzAvMtjfTaQ7Dp2sYRO5zRf2
 nw9NhjovJD5R6QSXUThwLEVolxyiuaobgK6pe9JeDCIQnoG71WLrQYMjAZag0SxxEDR3
 qNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427873; x=1777032673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2Jhec41VKiBOloo9Ug+07KCijgFK9t3MsDM1aLwHyjU=;
 b=E/2pYrImnEu/SGjEXKQJC1+yrX3ceYRRoDGaelZ9qN/5s/QOTom76uCEvYtVYu2CiL
 nn+ivQXMbZeYRy2dkiv9TxFg3GnzDEqU5QPV9RhtadyAuppoBZb7rBpcaAtJZ9XUfsF+
 xU6+g2BcOrRIglovHD08+7kKTe6xvHNw1QOJuHKUPFuyWNpmOd6HGwqulsV81760TRQB
 n/k61Bip/WzVG9u7q1sMIp97jF75ecSyN1LT+kKZgkZh4K6IO535y9k/zA3j6ki36eNZ
 BQL60JL0ZQPGnSX62BZ82YbPgDGlsKSSDiKU78GiiYtQs6ov8DMuw51AHSG3mDCM5zqG
 647g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nOYeXcbpOFvh6mdeext1Lx6GeaIRyLlWVliSXdh6bwvonlyoRWp/qXvygWYWhu4wFvlVQXnY=@lists.denx.de
X-Gm-Message-State: AOJu0YwFit53eQnexoL/B3Hrm6sYEmL4vdRJAOVXZoN+qJtLfIfoo9oS
 5BZCHBhAfufn1Jn1Ga82PT1DX2Wm6Un3NxHSHHMOmUQD+U1qgg86g0yuPnj7mEeSlF4vmIceNyR
 4MyZSlRHP/lEwpk5BNBYZXloIHxrAP5G+D/pcROEJPwVir4UNyfVu/47O
X-Gm-Gg: AeBDievpXYB2HAEqHB0v2p3+ztxdIXmqDMuYnE9a0Vkqf3hrdvU3/N7SJJAqARqROnU
 IGir78tCI/py0ZwAMvkuomnDzDYxuxUTyKSR3vewkD31woQbtEwE3Rjw0l2OZdDp/O2adAS9kcn
 1OGNBNqM1XylQZnk94SmqlGpRlmVi//smksxHS+/vIoS+YzUWQoaZcSCEPO9Kbch/EsTqe8k+nd
 6mcPmHVAuviT4FNoUeiviZS85g32+ftQzYcGjESqsw3wSQc/ONFXitd9Lk8FzUDA2U3EJBs7fXs
 3hkEToSTadm4oOMJ3qMy1tO2CBeu/T7e5MRp1fJ0LEjs//qA/X6wcZ92bMRp01uFkGTZOQDWy/i
 jK9DPGHUbQij5TCsVEP1oaADH2OO7q9gMHUjg3QEit4OdIETQkMJm+tQO6YXvIUg9NN/szdPIS6
 tsz2LCZnGjTl37WliOA7wd9Sahws3ZdS3DGmWz8gtdRifFnfr90z0=
X-Received: by 2002:a05:6a00:4511:b0:82f:7762:3eb2 with SMTP id
 d2e1a72fcca58-82f8b507fdamr2260942b3a.17.1776427873056; 
 Fri, 17 Apr 2026 05:11:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4511:b0:82f:7762:3eb2 with SMTP id
 d2e1a72fcca58-82f8b507fdamr2260896b3a.17.1776427872437; 
 Fri, 17 Apr 2026 05:11:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:11:11 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 4/7] image: add IH_TYPE_FATFS image type
Date: Fri, 17 Apr 2026 17:39:48 +0530
Message-Id: <20260417120951.3454249-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t8Wae-6a52rz0KGBv7XXObzH9R25dQUZ
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e22362 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4aOyRjiFMazzkRK7XREA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: t8Wae-6a52rz0KGBv7XXObzH9R25dQUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfXzXJ7riTdtHor
 aDXhdvkvlZ5YzO2NFNYTV2y3fWj8Mg9y36KR4Gxbc1eER0G6kOI9zRDUBs0wUeOcXpcMUSCItgG
 BpCgfFvWXfCJNgqC7YsWy7+N8LD5xYwuQIw5WPC0/YwYAEv2sCW12BnG3ZQOD7L7Jf4Zt9RIV+U
 U3DAm8Pm4UU08UpRwq6tM/DkntuZT3ITg891luBbj6QGArGhUtoXzpRq2nj1VrpOhtqnvqWzH5r
 g9btkcvR/qf0hX1LnSAM4J/MIj/S9aGsKEjdxVPH6ijQfvS6eeI0ZQbirEs+XgOdeQtr4NhY0FK
 zVHlLdeg460CalX8i5zPjvks2HYJ9Qins3vMlP9xMYPS93119O7EVpTGMvdiumRP3m2KlcUzraI
 1ltQBecLS385P31ta84Xc02AqsgBYIioF5/O3pgfSjNO17E0g+xPzL2fSLalZoFVNrfH/XdOmqn
 dwL6GYkvzy3ftqNh6tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170122
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

Add a new image type IH_TYPE_FATFS to represent a raw FAT
filesystem partition image. Register the type in the image
type lookup table with short name "fatfs" and description
"FAT Filesystem Image".

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492..4a17da645cf 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -136,6 +136,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_FILESYSTEM, "filesystem", "Filesystem Image",	},
 	{	IH_TYPE_FIRMWARE,   "firmware",	  "Firmware",		},
 	{	IH_TYPE_FLATDT,     "flat_dt",    "Flat Device Tree",	},
+	{	IH_TYPE_FATFS,      "fatfs",      "FAT Filesystem Image",	},
 	{	IH_TYPE_GPIMAGE,    "gpimage",    "TI Keystone SPL Image",},
 	{	IH_TYPE_KERNEL,	    "kernel",	  "Kernel Image",	},
 	{	IH_TYPE_KERNEL_NOLOAD, "kernel_noload",  "Kernel Image (no loading done)", },
diff --git a/include/image.h b/include/image.h
index 34efac6056d..68469685c4c 100644
--- a/include/image.h
+++ b/include/image.h
@@ -235,6 +235,7 @@ enum image_type_t {
 	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
 	IH_TYPE_STM32IMAGE_V2,		/* STMicroelectronics STM32 Image V2.0 */
 	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
+	IH_TYPE_FATFS,			/* FAT Filesystem Image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.34.1

