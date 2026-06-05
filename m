Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3976CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C396E8490B;
	Fri,  5 Jun 2026 05:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="bHLJrRzV";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="PVToLc35";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="GWz6mdTf";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ruDwVOKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB708491C; Fri,  5 Jun 2026 05:39:26 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B59884931
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Jq2vF981774
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=kyp
 umod912eYzR6o7ZiC6ZwcmLebLOdZugR8T/qgTg8=; b=bHLJrRzVnEHgMD8ug+I
 48f7XciANuMQxKvWctBo/W7dElBx2yNiwuhbumRPjCbveoXPUXy8T902WNdrs809
 uJqu5AY8T8Z/NmcWAJUj07ToEqozA2sLuY7KjDc0GuG1HHZwhugkNCHiY9rDvUtb
 xy4wPRn/cEBz/KJxYqh4M8y8Lw1Po1gapuzmnGXhypuCq5ebzSMrtDvhH16YF/kN
 8i8sSy9N35UW9aJv6GZ7qhxnKVeDo15xry6+5kdTAE3SzLX0PvUyFXeXGjR1kkLO
 VJfvUp1ESRML5M9ji+g08DIhVOp9PlLbttBD5KEAJWxU0bzxqymCg4tHgc0WmqgY
 yBQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekfw6jgrv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+xmAJnJHvbVMikY3Gp5NW39+Y5d/KY2IVRDE+wDPHGf96/wxjdczW2B5FMb4mqIOZVKgg4zOa6FscYIkicmcJyWUCPUrE27V+hTzT8klhFtN2+G8VcrGSOVJshjJWiBaYTD6Vv3DxbDFrPOacSfUN2QYWDF9zr3uL9QD4/mKqEuDRhGVRMqtexr1Ws57OeMvmJ2Q/LfCWZ7sfqbF74+1I6CJpMprcu9kCXyhWlUXW0CK+TReRkAXRDMaeIzCpZJZtA9b8605i8NlhpDcWRJu0AP3IfcqTSgP7pa3umFU8Sq30aA2nsGUCfTFGq9+IH+asqRavOH48zYqxSEGQ+7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kypumod912eYzR6o7ZiC6ZwcmLebLOdZugR8T/qgTg8=;
 b=YwbV9DH5CXBpDHwlG4EyvODwyUlKpts6xW+AG2UcxuRpQeSAT5XaOIXQS4G01EDGu3m8Qd3rGy7acz1Jsbnnny23SdGZw0OfC2P7sEvdYpE9Ie3+VMSUNGLNGT6C1goTao1C6NWtHaKctIW+gRUt4n+cpe5a3IpcNpk2kHa86Y4oEQavUm1bruiotkCSocX6BU3Ve2rfTCSHaugyTIblwdkcHdmx/IjLZygDuu1O2d9k5EzRalChZGD/c26tjXl4UUY91ZHn1yjVV6rVaXC+7nlnn6DMLdsq133BbRNLvtXygM6SsL2De9Pji28nkHI0piTWpfDWUvO1B99reNYW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kypumod912eYzR6o7ZiC6ZwcmLebLOdZugR8T/qgTg8=;
 b=PVToLc35UVVc03y8aUTgACw46VPMsE5CzUACPmSF7WVzmi5IcXIYWWJeCjHFCqkHDClpQU4PwiQG8UL/klKyc1kDeF4Nu2is3QFElLEOt0hz78glYnuO75BK29O0oTCw0gR9C2RrgfUXvzIlisVEtlu6H4YAE2EFs7EoNNw72kI=
Received: from SA1P222CA0068.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::27)
 by DS0PR16MB5327.namprd16.prod.outlook.com (2603:10b6:8:161::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:39:16 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::32) by SA1P222CA0068.outlook.office365.com
 (2603:10b6:806:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:15 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6551cBZX098767
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=kypumod912eYzR6o7ZiC6ZwcmLebLOdZugR8T/qgTg8=; b=
 GWz6mdTfgV17e5Aj1cKMpsWITuout/VZfKlrEZI6/H9pYnFN/1G8z2+R6U06We0J
 AfkB2AHNbAmRFidcBWicsFAPIGvEPDjRXORIrtoIb0WK72LjSfwFHdm7ltoeVzDT
 JIof/cnJMzMzBufCTC+ehC1RJVxrkJodLZa7Nd/Nnk9YLroJwckinlXy6D0BfWoD
 km5BgR2h9rMpgnysbcfpfPBtQeYlmilf02x1tNkKM+bxuQN5MdnwZ267CK6RKGYj
 r3fJFJoiID1kS41TOpkbPapSkwjZ0GdL/zqtqGHZZJ4uIZs92FFOhFZxFSRjWMcu
 MusNhwpM1peEOGkq213mNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=kypumod
 912eYzR6o7ZiC6ZwcmLebLOdZugR8T/qgTg8=; b=ruDwVOKAzYpaH1Eo8VlEX0y
 PYvmWCgDBf77WOTMJhW4GvqzTHZuXb8taolbBAdQb9/zTnYs64YEdWycQQ3ZNw4L
 CMDj0UHijuTRyYmw99QdR0f0scsB5pA0W9QEaYhbZSr1soLolI5fknZP1j885bvr
 CmyP50k12xfyNFtC26KB98RPf+CqEgefY7cbW8otZuRNV+k137g2ACNGS5HjrV09
 26xBiWRFhqIfSkQa/WIc1cM7Q5PX4ZB9QxD0951KVqu7ski8UiotNLDsQtU5wEY7
 A2O3xizE+Vt/4hvgDUYznH9lrwi5RhnKXXmEoG3mFvs0UXt7z1olIjpgtnwH7Ag=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egeh8hcgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:14 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLOqwCK4HEF2CVLOrwqVWW; Fri, 05 Jun 2026 03:39:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOqwCK4HEF2CVLOrwqVWW
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 1/8] cros: add common helpers for GPT flags
Date: Thu,  4 Jun 2026 20:39:00 -0700
Message-ID: <20260605033907.1909319-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR16MB5327:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cbec3ca1-b737-421d-6da0-08dec2b40414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PmGYIXrea83KCVALFhOOPoEU4HDnF06KLJ+XiR6GzkdQ0rGYYnB2jTdOM99fBw6nKMwZm1rMx0disy+1Z9f8trjrbHk+6GtZ7T5xxQOGHUTEr1Pvnv4n9n1iBPb3MFZswSym7/DJWwtxaqK2gFtk66g/IuotgmXcCyM6xRW89b8M9FMM2jPpUYXpNxB8vBAK/zuHaArciNCAhvFgvgPlbKlmAbgLsVnOuNfdDFywbsENDLhrHdnVZEd9jopbw8r4jixFxK/mzdg06cPpF8IQb1B6dZout3EIjxqJCRLuhZdCI13TIBZBTnstY+M5DOkZHF9EFDBVCv+Qp+m5RfBDK07mgnj7fRQcNiNVipCKU6Ouaf1ETig9YuINUVCnp9EEC0SxNbdaxN8UuraIue/c9zN0wnPjC6HDt2OHR7UF1BIX9wLOVpAq3sFNrXythEsvqvBKUeRTHnyBFSLtaxwg5Jouee5tqLilGvXcFmxnELYYBnGCtwCn286KM7GCIrVGTXHDhGtdZXHI9siwS2FKmDEjB4/ObUmSiSIBgA+Gzsy3RT2nIebSdfPD2iCEjkkhuuWhue2Xso+6JOKxSWNiWXqt01JbLGXE1/GLRcXHAc1jWlMCVBzmJC17ezkPFuRsy07pdNBxna8p7yBOt7LC9w8iHkE0hBWllEf1Q462AMrhR2H7AJC5VIA8GBk84SXmhNV6r5Gzhje/f8Zb7LwSyrgg5lCTaTPldluGrZPVhmY=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +IxbkQRklofmjYoNWD4mrn2DYttMMja18xxCV2iq7bHSxgCPOkb7V6wTdWl7WiQ1LN11XMtsm1j9Qkex4Gv6jxXsRRKPnYG1VnbnfFQ9Ew7VZOewJtNBTI06TCmzf1YUhzmjJ+BjsOGGggSsU69KHJNefa1ruXPyB6qAwDamSdP+W+TNJXdYJPylTKhL0EzJd3dArWNsk6eIACdsjtkw9qvFa+CLFZwv8/jSVnvVhpPtX4uLvH2ipKYZgDChJ9VaL7PUKrcTf/pemmdiuHl+V5mFwbdp+S4hUXMcppSWdUSR4BfhWuZzwiCawrLYclbjl/NkuvcTwmdNLPUKGl5bgOVdoawjhjGUUktMulpPWLjrGfg+SEE5il0G71qCU0ZQoIzYfxpmYjaJWVOBcsxlfjrAF1AGFWsohSfHGvE+me01hlZ9ba80nhz/ZBO5GY0J
X-Exchange-RoutingPolicyChecked: rVn90ReBqMA3d/RKx2ctPUMOqTEKepMBj2I42WeEicnxNVXFVWf9q51Eo3vfrgfsiMsWwfGe4p+scsSOZm2mg9ENMvRLHEbhv9VdpqUon7jNLUGhaqiwkeF4v96t1DTmX7Cp49O4JpJhn3lFVrxeb3hAYDKBmN6afMmGLafl535TDXHFAHf/xfqwF9gHdBLcSgzkeSTwSvkNlhZxaCzFtRa1f7j4WsPOGNSqKOIL/C7EcOqiGBkUTarkr5zpCMK9b3TSTWhiCsI5Q3vlAJApn9N26Zc/FPBNtplMP2CsZZcW3lg5Jm6NBX+gNN0ZxSl+vQ5pJqCkggQf7dOCTkk3aw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CZoqfx5+DKQNDhvY7FeAvoksGIu5lsx4x+bz4IkjbyVbv5AS2DYre55ysFXau2uJUTi92We+X0CdK/ZPgv+8BvpcGd4UDFs6nUsrq/OKg/YklMUuHTiGJaQUTca2392lc0x9nR1yXt4W62gdKzpJ4SGd92dVF1UdrxnfTPXKoY2MVSCrxVMA8HSy0Fg5zPeOevZpPUTugRK+iYfJ153tKkwvWQH4Xfso/lR3Ip+/Xx9NPOhaN7WTcSPCmFOVuBCHMQmr/ddhelLjJNuroRXedjmf5kuvUOFG3i0K422AgJrW5Dk6pRs7gmqjvo3yJ9G3mQFTow0Zh4C5PH/iwuUiRqHLtWzNOwNEwrn2XKmd1DPH7HGAcBBSakd9QUcl32RHsu108t7IeY0sywGAWEPGF+xTjR2ewxktf35zotWTN6nfVsbw4EeGO9+VDt129A4wT5vMhzcdnNVKOZHQc/sAE7dehHYTRJQnU+2lLH5EKwEygC+mN7whTbYnOBkVJePa8g0Ck1qxTJySc5yaApgW7ul06dGrljtniq+fmCKIljgbsbTeEj7lsw8IzatMMMGNjmBwKYog9r4EGPNdA0vpwA4g3Cz/qPH/sNH5yxjnhG3wm93Lvd8vVfLZy9+KSIp2
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:15.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbec3ca1-b737-421d-6da0-08dec2b40414
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5327
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX0gF4e1stg2th
 wPxW3HjH9cShouVStPpdNF5JMS7KHa9B66oHIPWkR/ZdO7E+3nJBbq9GVmJ4ptnEcb15P1+0FXb
 871YE+XJ5q0tdJPk1+lSLFHBT3Sts5CNjq76k5j+Y8rpHmFCvLK2Il5mdVFfgFuF4YII5uFvUq3
 WKXt4rFfaDoWyP745uk95/dNlFWY1iAukExT4Ja7/oRyR744n4K9JfqgByuXMjUtxnB2dhEbuDI
 ksS9ceVQhUtNYPo8ROELb4RaVYhGfOHe26K8AT5bXrCy+y4ziiUcmd+rP6V4cYfvVPKCHVeoHZw
 mzbcV9xyeifXoLxHnmUa56JQOntBrz1YTXsEIAzg8xoBK5v+WDneZoM9f1ncrLbibT3Rxq2YAo4
 XR6qbzO8deo15B5r655fh9Z2Cn5um/wGNyiLei/Qmdjo834gox9NyVSDajDDrw18iaQPFKx4Ipe
 XI4GHkK1+8z7CdqGBsA==
X-Authority-Analysis: v=2.4 cv=A41c+aWG c=1 sm=1 tr=0 ts=6a2244e7 cx=c_pps
 a=WaebrhBVOVZn7IYqRlctMQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=Oh2cFVv5AAAA:8
 a=cbNQJ9GKAAAA:8 a=ke1aqN7NfM7SMU7aCSwA:9 a=3whSkbs7g9Me0DR5EJEX:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-GUID: 83gZkfXCZ2KCJqWnWSUGzljSM5nx-kAv
X-Proofpoint-ORIG-GUID: 83gZkfXCZ2KCJqWnWSUGzljSM5nx-kAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606050031
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

From: Denis Mukhin <dmukhin@ford.com> 

Add common helper to decode/encode ChromuimOS-style GPT attributes
similarly to [1].

[1] https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt
Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 include/cros_flags.h | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 include/cros_flags.h

diff --git a/include/cros_flags.h b/include/cros_flags.h
new file mode 100644
index 000000000000..e9355fa5e908
--- /dev/null
+++ b/include/cros_flags.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Bit definitions and masks for GPT attributes for Chromium OS.
+ *
+ *  63-61  -- (reserved)
+ *     60  -- read-only
+ *  59-58  -- (reserved)
+ *     57  -- error counter
+ *     56  -- success
+ *  55-52  -- tries
+ *  51-48  -- priority
+ *   47-3  -- UEFI: reserved for future use
+ *      2  -- UEFI: Legacy BIOS bootable
+ *      1  -- UEFI: partition is not mapped
+ *      0  -- UEFI: partition is required
+ *
+ * Reference:
+ *   https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt
+ */
+
+#ifndef _CROS_FLAGS_H
+#define _CROS_FLAGS_H
+
+#define CROS_FLAG_PRIORITY_MASK      0x000fU
+#define CROS_FLAG_TRIES_MASK         0x00f0U
+#define CROS_FLAG_SUCCESSFUL_MASK    0x0100U
+
+#define CROS_FLAG_PRIORITY_SHIFT     0U
+#define CROS_FLAG_TRIES_SHIFT        4U
+#define CROS_FLAG_SUCCESSFUL_SHIFT   8U
+
+static inline unsigned int
+cros_flags_get_priority(unsigned int flags)
+{
+	return (flags & CROS_FLAG_PRIORITY_MASK) >> CROS_FLAG_PRIORITY_SHIFT;
+}
+
+static inline unsigned int
+cros_flags_set_priority(unsigned int flags, unsigned int priority)
+{
+	flags &= ~CROS_FLAG_PRIORITY_MASK;
+	flags |= (priority & 0xf) << CROS_FLAG_PRIORITY_SHIFT;
+	return flags;
+}
+
+static inline unsigned int
+cros_flags_get_tries(unsigned int flags)
+{
+	return (flags & CROS_FLAG_TRIES_MASK) >> CROS_FLAG_TRIES_SHIFT;
+}
+
+static inline unsigned int
+cros_flags_set_tries(unsigned int flags, unsigned int tries)
+{
+	flags &= ~CROS_FLAG_TRIES_MASK;
+	flags |= (tries & 0xf) << CROS_FLAG_TRIES_SHIFT;
+	return flags;
+}
+
+static inline bool
+cros_flags_get_successful(unsigned int flags)
+{
+	return (flags & CROS_FLAG_SUCCESSFUL_MASK) >> CROS_FLAG_SUCCESSFUL_SHIFT;
+}
+
+static inline unsigned int
+cros_flags_set_successful(unsigned int flags, bool ok)
+{
+	flags &= ~CROS_FLAG_SUCCESSFUL_MASK;
+	flags |= ok << CROS_FLAG_SUCCESSFUL_SHIFT;
+	return flags;
+}
+
+#endif /* _CROS_FLAGS_H */
-- 
2.54.0

