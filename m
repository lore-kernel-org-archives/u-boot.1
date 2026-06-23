Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDCBCDB47C
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 22:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E8684A0B;
	Wed, 24 Jun 2026 00:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="SAdv3QGv";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="gqriAPOG";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="QxX4htIk";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Xs7z6tIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B283784A0E; Wed, 24 Jun 2026 00:06:45 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B80084A06
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0G8I3072618
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 22:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Uv6
 oiY4qYTY9ALfunVt81rBdIy+/jtf1OCLY2WUmhs0=; b=SAdv3QGvEM7Q/4Tbqcl
 6Hp5U0KiINqy75m5L8EkGZxscNTJFATSgXzSNDQLpHjcQyWsdIx4E4kpKfQlCjlO
 fO8ScQo4BTPbkbi38rURO86FTcFdMvxJgVqOdG6bJ1+5Z/mD0f3hetfFyPBfXfJv
 UNveV614iIeQG2UZVGxJLr8LNVsLfiiiawALT1wQu0ZGR3N+MWWgV8ayaJjw7Ups
 33EheeQL35dHRdiBag/1GXq3eddTHF9r+bDhGOZOx7fEJtbENKI25syfD6QldiAj
 oWUXBqVgn1Hr5NHnzAgHPZaIXYQ/4KxmCfIYyN1zfleHtFP0ngVpkgPU3U9ZudSM
 YXw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4eyv3f4qeq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 22:06:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws4Lc7J5jeIJFk+9i4NB5KTlnKDDne9OgqJXC+IKdZRIZ9lVqIzWhzIW+AEkVF7C0s7oAt+x1SAd5XFI2PPVPCuEPzXKekuy60zvNSK+SrvMW7TMpaAviPHseEv92YNe2exiGb3XCAz+cc+YkFk/yDCPjNGN6yu+yzazVrXCzrGGLjHA8kv95li9dM2D1ItvBQHS1SYcRLJuBoCkOVHHUlVDaxCwpsJzH918RQky0d5CISPBjOwLprxhyiGFkIuUtGWGV3eTnKuCrCXcfwaxmD2OEdCfbp7VNmHaGBl+Fm4aG/UKtdle0pQgaKApAMk08ZeEBJ4+4P1dWvNc0lDZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv6oiY4qYTY9ALfunVt81rBdIy+/jtf1OCLY2WUmhs0=;
 b=pywK5pm326FNiBcZFeQ+hS9p9hXbOor/HYbatWKwXskD5r3LzeGNLH83Wi5Lo9YthgR/1AVelb3yBpgAra6ag7BKH36Y0JIhMi4MOZ1m5HkCelYylGxecasptwICIWMzA7kBE+Wo9qaLf6wyPB6CJIq2hPLTARTR8FRnwEvtqtZsWKorlI3zvEZViYlyryPnHY2Mkokubvop/IAdLbvhryF5gqID4nM36Z4OLaRd6GdcMMWhe5c0d8GhhIJBWZzAjmAQTiecSk3dcD1Rxof85x788Du1+HIA9JMp+oy9BnM7XBH6k01+PigbD+8uRR3rpKYRmITsUND68NG4QaDSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv6oiY4qYTY9ALfunVt81rBdIy+/jtf1OCLY2WUmhs0=;
 b=gqriAPOGQlFEGjfJiNPsoyFHMgMtqOISufosIIsgIF6nSUyDL4OldWo1mt1AaUTIXPbCCLn+Q4EQ9qbfi7vYca+8lTlGCtXUDAbNiP5M+ljXIZ0DWpezZlz+qZgEQ8AFuU25cy5JQEEo8J8Vwu8YXH6orKmk+kDiOfymVnAuRAk=
Received: from MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::24)
 by LV0PR16MB6962.namprd16.prod.outlook.com (2603:10b6:408:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 22:06:38 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::80) by MN0P222CA0015.outlook.office365.com
 (2603:10b6:208:531::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 22:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 22:06:37 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK12qY1708376
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=Uv6oiY4qYTY9ALfunVt81rBdIy+/jtf1OCLY2WUmhs0=; b=
 QxX4htIkT3su19wjeYMrRKMNghKhmX2W9rPI8u0NG5FGwXL9tdN6vl2awsz8EQVN
 wccJXSZDXSiHF9Z1TJ7pQSSuBR9kw5ynI+X3c2aSi376PB5aiaXgaIepOYj1FF+m
 szadkFF+hiobrx9t1XewqopMNhj4BsutQCN1JbvU6K5i/E/6Nee2tMmLE+PKEccr
 nIiJOlyDGTpTxxVafAUNCXAI/R8FG/x0iRq6Cc1fsfHpYchWwqa5wr05a0weXJff
 RumWKoAmMmdGxN+1GC6oJa+7ce47KMQZGAPvs6VkRkDPyOXAwjeswGBSx503Shwo
 Xd+xiaDCYULK5thdV7zpzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=Uv6oiY4
 qYTY9ALfunVt81rBdIy+/jtf1OCLY2WUmhs0=; b=Xs7z6tIi9oXxdNxy74Fwx0Z
 Hbi7B3XViBeygoQlfnZzB8g6lN6DX7FwFKBMwk1UKO0Z7mRbrUZ0pir/JCgnNP+W
 CMWoQrHqAwEy+0Pe67L2Q6pwyHPZU2Kbq26RefGJ29jtMMHOCqVzpveXqJfQOmqq
 teiyWoe/VLaNjK02JITBEN/Ey1SsaAvhpKY4x8nHLjQlQ8/qhl6i7FnmQAUDBG9E
 0BOWb20MKjMeLhtmL0g2lFE/1MtfXaBUkmy6k10OugMclFzvEwgXgZMovg4nAVFZ
 uo3tO0CBrlCjOLcR8OJHMLoRy/QChnpGjzu81bVOSAI9ASvqrrC/MBwxH7FpGaA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9a4uq4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:36 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id c9GMwnLdEAurIc9GNwp7tf; Tue, 23 Jun 2026 22:06:36 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: c9GMwnLdEAurIc9GNwp7tf
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v5 1/2] bootdev: scan boot devices at each priority level
Date: Tue, 23 Jun 2026 15:06:29 -0700
Message-ID: <20260623220630.2828767-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623220630.2828767-1-dmukhin@ford.com>
References: <20260623220630.2828767-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230181
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|LV0PR16MB6962:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8687fb5d-528c-4ec3-8781-08ded173b2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mVgO+Fwt/kdAuRQQDZleSpG9JeqGEk8gR2fdTaEmn94b8tGx5GQzX5LOwOvXEDTYxe7Dd9VEuwPsqeRZ4oeJpY7ct/Y2DbhCutZfop2eg3mAmaOmuCOadSDUqEUdGx6x7smTKoSBk58EaDG5NIk+EvrKnyDBMnDG6A7k0cT2zGrxdYvDa9FF1mcAuJd0HyacSSSPr4W+7QsnukVndm8jzZCtR9gu/UhrFYOe7qEJLFJzIoGinp5apAamUwA/jOrPbTTbrcmcCU/3k7Z+Fbgd/me9NSWHmXcBOpKtyODXRyyqX4ng2PuAXEKyO+m51BCKFy5ygEuv17XTvgrzRfMhQkCLWEExwUuwoSqavCQkWcAzXuD3dtN5O1lw+TtuTpowYe0Dl99jhE9NhfNG9TSRFjTrUHXEMl3zA8mfC7NtZIicXS0DeqwHYgRFeWTa0l770rcBIe0VHAR97PY8cBHTD3LHxAR7NvzYe4EaVYXplg0GNpJsv/GWph2vn+lRLizA+iBJXDUFdsgo6q0SezZMpGuEi0kLWt2l5Eom3vGbw02kKrHm+qvRoZZfgjjlcK/qdtj3cj7zYJSPl0la+v+nGFbDpB+l0yEWBPJdzmmrv/FVaFQ9C2flyWqo/gzgeKvJQKkagFIqcX5RLIrAd0c5CweeJXQi9fVNmjj3HHzZ82fzdZsTlZGXC845ayjDnEaE63fofHqrfIxlx+ipTXdBbQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nuiv9KL7RMZqnIanJlEFQWSFdabvacyued527Q7Uazn6huEqo9WFo5W+EUWDgHalIuW2OVfPUyad3YlIV1s3VzsDCLCsr5WIs4NX/Qqm4y9ZEoPznYLHqB6yQbezHx8PwI7jB5IK/dL2CCo1vGLhs0flaPkvM5GSqdWXHoqY6h34uFVtIySVGvPfzoNvTYd7HkV3h/ICnzs3DIuIeWq1psIv6s5THeA2am2G8A7QeuHxraU/eGKHCORH/A/zizJcysqU+1F4YJc95Z9l0HkydoCBC3T+IrC8/w7IbajDvW7q2+8RMoD/4LFvPFYQqZDT7g1s248/jSYsKZQQwLLh3ygpCY1sGeN/8JD/uVWeWvqSDuyaSij+H15PDmv/lJMX23OEjfmQqzW11W8Oc7+flbuQGykeVyDeKfibKifHEbfhSqIbdwn7m2Lo9tOUPAcu
X-Exchange-RoutingPolicyChecked: S4Zel8jU9h0qHsF/S3ZX+ydNR8WIQAc9m/YzUQpuJhdBDAL3yVEZoA6/SEYtW1n6LHhCru7vfKYMGpds27mPdcCbF4JF6/6SQW97wB+7XDhQS1WlLeGbUiK4ct1ifmlA3X92atsttOChDxK9olSLOKt29diK35O1i/BEt95KhEuWN6bnVBDkRqmDs1IT/rYxC6vBhtJaW2PZkpAae70Lan0rYCVQj69jTS0zURy5hlxM4A5f/DEH1/qhVUxw0Af1wOTLS2331j3e4Ih9IYB0TwSJQF3IVkEI/KZtK/v+0pgIF8tRwf6oXJFR3G1UKnh0ubNMrdt9Y8vjP+dhZVvu2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: syeRdU9KjcCrhOu3gaDns1bB4XPfJK6mA7eFNQteK9jvTli1d22heCy2ZqeL+O0f4rNh8oj7UzpAigq1gjI+u8tT9se1F9VGz4OOR2gIr51sbtQxK5DfjSMMLQIJ6dJZTIYLeCtYZm2xxedGxX8jRFf5BmlKWQQb92NXDcobyg+Yej4d1BA4ddxrN93O+892Cz7AHSJTJcRNsXMBSKzR1aRXJQsENo+aPKbgtoe67yudiT35wJsZGoOg2mPq0SAPIrV6fqzJratgrkPwtlGHoHsG89mB+lMzBAT5MaZRxH8KzMS1AqvJ3Jhwr0n6cjwmv6XhWbOttgXMrbDfHb9qISgAmBmysRdGu5ZC+4imNcTx8ttuYyo5p4QS8nscWbLjSQw8MIFclbyimwiS2JrPqyFFzlJpxpTQ0iEa3cw4Fia5z3ruDMaU35du2ZBwHBvz1ghwkCYRp7LltxtJhdES2b5tR4KZoFDOn0yZffLUNxdLWRYAVAOjWxxccLdZhorXtLkuB8KTB/fa6H1C34cVFcFyJDY62JO5CydZ0Vec5SU6JTKhiJeWXPYVs2VG0YC87yZdk7MwOGnhit2OHiFEFaMSvh2trKoVxLLlE+ULJboe+L0MTyC+7YsNNL7d/YhdKg6XppYOki2kRbX/rfF9qA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:06:37.9396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687fb5d-528c-4ec3-8781-08ded173b2b0
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR16MB6962
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfXzD4YgiyL4ynA
 URaiv0gIazgi9QLt/WFR4bhO+zWHDEERXcnhVsq3h+o5yn06iI0qPLXLsVjpw3XTro6Ffu5Jo7T
 1FCSLOTbbpwZoARweFTLViTDV9Uiu5IKg0RYxVXickdLWPhc82q1mg/YHjmkAkSmzCb26e84f2+
 pSzRSkP+sZiIEEc44w+TvLo2nQJbRGLd1VYidJg8zTDsvhj4MOAirEQBc38pcLNaTAA0Wyzdk2Q
 pvpkSdrDC8UUwFvj+Uo+Z0fLT+9x6PLzXV9wOKit2g0ftQySulNorflzj/8EAglvOO9GDGvbl5S
 SHrPxriDcEb8LgKqKHD6Fow7dgN3uhlBQDkv8eCbxvS1puuL+nLBoPJcAFfwik6E/OMwiu6vicy
 S4iTszLq+0VFijw9eY7gH6BRABc4+A7F99X6pljh5aLcbhgMr9bVVHQpORqgPV6taQtINdNXMVN
 GsdEkj07WUIJfW+dFhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX2BvAPKKFdExx
 1sqG2e1XrXd2hVNKFPghVAOkNzdoNAhZ83x94P0M44uY1/6Q1opsPd1QVPP12FTw+n9QtBx6Uy9
 dIZcNibEsprbGO6NxzSnqpFOycp81ysX+Y9cTAq6PCABr5G4+Xrj
X-Authority-Analysis: v=2.4 cv=QbxWeMbv c=1 sm=1 tr=0 ts=6a3b0370 cx=c_pps
 a=qiA9p8iyC6UfobZpVQ7+mQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=WioVj99LH3wGi_Uw6w4A:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-ORIG-GUID: XS61HlenH6xQ-Nrmdh8qSMAJT9kWMnkp
X-Proofpoint-GUID: XS61HlenH6xQ-Nrmdh8qSMAJT9kWMnkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230182
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

Currently, default 'bootflow scan -lb' will stop booting the board if
any of higher-priority bootdevs fail to be hunted even if there are
bootdevs of lower priority.

For example, if the board has both NVMe (priority 4) and USB MSD devices
(priority 5), and if NVMe bootdev hunt fails (in the event of a bad NVMe
firmware update), USB (which may be a recovery bootdev) is never hunted
automatically, leaving the board at the U-Boot prompt (user intervention
is needed, e.g. something like 'bootflow scan usb' to hunt USB).

Fix bootdev_next_prio() to scan bootdevs at the lower priority level by
not exiting the scan loop early.

Keep the existing logging verbosity unchanged and rely on the failing
subsystem to provide a suitable diagnostic message.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v4:
- n/a

Changes since v3:
- n/a

Changes since v2:
- added Simon's R-b

Changes since v1:
- corrected the commit message
---
 boot/bootdev-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3f8dc2c3c4e6..73c3f050c225 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -664,8 +664,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 							BOOTFLOWIF_SHOW);
 				log_debug("- bootdev_hunt_prio() ret %d\n",
 					  ret);
-				if (ret)
-					return log_msg_ret("hun", ret);
 			}
 		} else {
 			ret = device_probe(dev);
-- 
2.54.0

