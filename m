Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02ECD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F6284936;
	Fri,  5 Jun 2026 05:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="kl7bqCJk";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="BamEhKb0";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="E4W5Amqj";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Wu+6XGqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FD1849DA; Fri,  5 Jun 2026 05:39:25 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADBB8491C
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654L0s171818179
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=4Hu/quKI8lrihV0gyZnEV1sR+
 ub/l75rr0LMb/dnCKo=; b=kl7bqCJk2KSIQjd6ThQLy8X3YSUuu2KabBANTcxCZ
 qCmqEjC9MILBPR/uACjp/dNtIwtMYuFokSl33HJuW7r2R7Z+CROf0zyQmXM60tTk
 MOc/cw8Mgvn9cHl1Ti9tPUmDRsX5wkW+WgAce1eiUICdtU0qOxRQoiCIpl/VnHuf
 zEvbb3BzH7ss3EU5WUADhqkc3CdhDXrnWlQMUvlmroDK2QPHPpk0loFWhcmTb9GJ
 DX0qdHiaXEx68o4LjzF/sVOyK1eCyWbAMxATS3HXeymtKZbKaydwXOAz8l7pyz5u
 LFIL8ULqZsv/GqjsANNAY+Z3aYHhpHAGon0WO1TPN1hYA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekgwf1wu1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We2LGvY2g62shcIO+6onlXZOPAD5lUDJVXrmfzV/1QYGuX/6TbEXnnEzeacqSOZ3wt2DdzYrWkr+FyVIvhXe4hTZx3enPWWmDV+xYAY03H8cyjUky0ehbBcHSkZ5DsM+L0gDgbm6mmmBnWneVYbzQUH4SuEs8xiOwO/8G1QmFUhDTmOgG5R+NFFDkHd+3I3zaXBKpcI+CK7TlBspzUEfraSL3ad+ZkqOgN8FtTjJAD8HLt5ptCQNcrNDa+UeKjqElxhm69IwU80UcIksuVAEBy5LZ7VgcXary6wNMXrnp8YO0w0Z4G4RKQTJEdFI0ybF3omhaS/Pm8MK/QKJYWvz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hu/quKI8lrihV0gyZnEV1sR+ub/l75rr0LMb/dnCKo=;
 b=IyuJJixLLKxCOCs4dpC7Ntm5XE0O8VQVsh/FA0KRRgfndGONwM0WM7x7QnxpWm7ri63HYomzzFdUauOYU6iSsnZCwYzgb+LZMR5ArlAMOB+yhSCo7W9+3o3bPb5QhXLIPgBYVt3nJ9U4WY0iyJyFXya4ob5HS9QGCR98YZ7ICIDgd341RWRmBcP3NHDR0JwtUoDBndpM1Ee3LPFuTyDYUq6PAHX4CcDXNe63Gc8wT9vHsVZJRanexXmxIMT3U1+wd8ym5B6zlvKfYn4adWUdTkjkZSd4FXu4g9gauOn9urIWp5G0FJBYBccaXMf0W4VPBwtGu0ET8OSFPREkhAn1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hu/quKI8lrihV0gyZnEV1sR+ub/l75rr0LMb/dnCKo=;
 b=BamEhKb03xSXKcwlUZY6FkfIvGShyVc/huxIp2hANQag0zHU57aLcQB9TqZvxO/Zhm5ibOrDKGU0nmft6TnoqYGqBYjyB0NhjAZo/G1JOUYvd7nQwcGWe9d8rA4+LNbap8H+3D4G52oeZdGGnCWJ65jkJQWbIeFTGgEcGgERNtU=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by BN7PPF55AC780A1.namprd16.prod.outlook.com
 (2603:10b6:40f:fc02::70f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 5 Jun 2026
 03:39:16 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::9f) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:14 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6550PVZb1072902
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=4Hu/quK
 I8lrihV0gyZnEV1sR+ub/l75rr0LMb/dnCKo=; b=E4W5AmqjN6/D7Drj+zhV/en
 rHp4fUDs8PtLBXXiZqUI55Emq+DopsOS4szYyXpHKv/L5CCj+S6OFnHQDhVTW5hp
 y7Lr0bl1EnqLhKBsa2w8sjVl3hJgilGFXEmSxSzYg/SLK7su1vdlnyCGFYKjcVk5
 32+vZWrpxc1XVWgXTNoB7ff5kddGhhMtG/+fy+3JFWP8MCv7HDVmtS9z+ECQm+YS
 KautyyfPmmPeHc4YgZpF0ymb4ObDh90v4FGeu7UDnORxuSAhLEEuD+jfvp5f6fdx
 CZ1D/6CQQx2zekASYmRPuwQoUJSIYj9815FPw+qfbtiBys6Ny9RdUZeMUnycM0A=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=4Hu/quKI8lrihV0gyZnEV1sR+ub/l75
 rr0LMb/dnCKo=; b=Wu+6XGqp3lGkxGJfY4dnjW2IxHkuETgGsQwybGIYb7/FF49
 QZZ9VXXR1dgGu2Uagf9A8RaaVbtWdniyLZmYg3L0DBVki1iHWh+vMYCunGJpO7iY
 YG8X/3//U1Zu6f3e7TUeWFoavhw44iifrm6uonijIJHNXXMihiXVvOZYZhEjLBCP
 4j4/HyECr1vNFn+wQBX/eaPigHk8SMiP8P0KI9zj0fp31B3lFf4R4LcpoXJaKTDk
 c6tkzdVOieEReKwIzWNqw7GY1b9bPx1Rf+QqvYdsiuSwE9byUGqb1lBN99W4u9EK
 x7P/JzAILTNwzbxx9Q1ZFwsQRYh1jv+h00HIiQg==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd91tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:12 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLOowPaCkbrKTVLOowcgph; Fri, 05 Jun 2026 03:39:11 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOowPaCkbrKTVLOowcgph
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 0/8] bootcount: introduce GPT-backed bootcount device
Date: Thu,  4 Jun 2026 20:38:59 -0700
Message-ID: <20260605033907.1909319-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050030
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BN7PPF55AC780A1:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa1a77df-47c9-48de-cbb7-08dec2b403d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: lSiqg/6pU3lhVtUNPeb3tt6SJMNS/hgqx45Jk8/DTv4M6c5zYqotmiuA7ZCxSBsgB7YeScj61QAtXBWe2dCvN+UZeHrHopCeU7Iz6Xvwh1gKBdxxvxYq0kp3gerxRYyHeZQ6D/eJfJ6948HwTamtPmd3MQaTe82SY44iJ/x4UsopwLwzS0P3fpHSciTA6+byC0iOHFZpSSJTKLchl3V8V9VZvlw38T9z6bprBOk0Kjda3Np6z1X68BlY3r3LWHkMD45u5cVZKuoEXLb5QrPf88WJN3DGUYdFm+Dndt5A8lI4jUubbfVoejHK7phqEioLNYvU/pskMcXBFg9u7VPpUPvfyMuIsXv1ynfpeGqy0xLIIjE1eDB2SlNTgXQ0zsPIhz2mIU9WB2StZ5Q5PFmsyLfB1hoYaTRVnlvgLOngZJ9EO8vLvGwnSFy/tgibk91wuodKWtw+JXJtCDofni39J4TSYbdZ8ffQSLCKCVbLLDE3NIRWLU4PQdJkrfz1BWKtnLLIa6ySeVi2C9CQE/lm/PvLyOC/UzFy1W5KGDv5teygOnYp6+4uM16iYVATX+YRWNSYj8vtHx1cGZjkxzqyXKezfoqdvVl7kEjwJzON7o9fMM2b6KN+B8o/XwjgGipMOIB8XDBtkIDZ4KU9fPHpjYCYudRVzjYWy6SlrDvTaOqqZ07pP5I+HjlXaUKTW6pbbd28Z319KDcUgftYZIjZcUc6JtfMlwMdQ0rmBKzyJCM=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q/8ra3Rou1mqLum1JMy7VHOn3sINJy9x3VNLnVbnO8f2mNqhZdziU3jFr3k9raHzozUdefPSbXaExUSEfXY1b/j3TQgOki1RVdb+lrhLC8U9UMie47IcDzh1bNeXlw39oyazWHEwm0jdsrDYWu+89vwVMzhIVs3wpYySpisynjgyjqCcj0PxGEvEBP8gddcMiJ4Rtcf0rjskTYyjEb90qarpJDSuQ6e/3Mw+Nmt32GHCITV8pqJJ7i4MBVuRYOKrM0CioD/6GRkXzQzv786Hr492VA9omVALAP+rRvEMVIfYQ4EyccRpsqo0ZhEskGx13fpyAjKr7H1KnidFlSTh/sOy/n/K1Zouj0ppZsuBQjF102vOIQh51O1gZ7iPSt/cU4Zk1y1NbLOBpKs0xX48Qc5UiTYMLEOfANSixQnN1YPkwSQIHB9K9zCOXmgmVyrv
X-Exchange-RoutingPolicyChecked: QiDfkUtyDLZVq98LbEt7fWDAN9wXkgP3G2O72pD2/WrxhE5Y32XSMpxXp5cQdkcGlRnWSwScGLxgFmYei+I0tJTfqYm+Bp/jqJDS+q53PAT+A+SV/BstlcWVW6XnPu1TyUf5CKIFj+8anrAzOM1pnuZg33g9LbqP5okzsGazxcsIXbcLn+rgY4pejkZaniWMqcn5k6n3XPvKVMgtxGAIjvCvK/hW4nPSGhtckFJiHo+w8oEJ6o1KGPIlgbAHQZlolq89RWtI4HHD3GgsDL6QUeMj6EmIW28rx2FYgzP8/V5LtqrcWaC1NwYQ7ofi341N5+IF1Sz6yvgPqumto2xa8A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /QprHvgRwr72slaKa8LSx6lbGkheLqZIp8ieS0z050reeKCKcbYkSEvPhCrDijY/NA8wZkHa5U9unaqqNel7ZIMhcouBRp9r1xeptHcf13XildmkAPKgloON4vyCyN+Vc+DlZxNGzmyLmH5bZhL58dBoOTjW4Pf61lHyjIaSU4UyRRF1twG/khRaaPGbkygLQmrbr2KB8oo9IJQk6jToNqJLr1q6CEj3V+E0zl2T36XDKN6ZAZL1BrVfL4fhBjzE6A7gDm0nWJfEwRWuidUawDHuacrwM/Kv4o2W69dTI/8OueEJ8iIUKQ1uH7BXEpos3JdobQPg5Ne4d1TIN7P2ev4n8j++/PII636SZ1MAsuAAoxfWFJSTmVVpJ64eOvRGpojtduH7E9RJfmT5mnXsDzihSDhIjV7GvAuJLo+FqEzSLZBE22gwwwdnsD0XJkylxSuZJCpB68ux5Sa138FThbCq1DgWb2bU+t5DzKfdUWbTe03sdb/fGVQWBOWdNfDJA9eaSDDWa/eNTDf3uTV2LeTQc6xQOV8XPBDZuMHEQnAfNnT1s6SQmxNy90HCwp2cDfX4x0H5ZdMwFiXUxURZlJcC4amqTA/cAFzxnNuPMwsOeNPt735ND619yrrhLA/a
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:14.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1a77df-47c9-48de-cbb7-08dec2b403d4
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF55AC780A1
X-Authority-Analysis: v=2.4 cv=YJWvDxGx c=1 sm=1 tr=0 ts=6a2244e7 cx=c_pps
 a=zf46e5KlnE+iQYqYCeD52w==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=Oh2cFVv5AAAA:8
 a=Tcl9TGdci6oj02QMRNgA:9 a=P0bj-C3X3jJDpopQwM1U:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: rCkzwb9TvYDb0cYWuQPoeJad7rvNb-rQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfXw76B3D/qi/1F
 I0JrAkIIYv7q6/5lVpnR4xrrdUlPHQR7XyJRAmNG/cLz3CjnovI2jRautKqYQuZks0BXqtDr1mF
 ZU5YXkIGrR1QZo9uoCG2p0wxjdVZ+y2JevXU7keVx05f5CRD3cW/tpyJ/ncBOdEnc9GSVGfD7EB
 wUWCVJ25Bgz2ZYDIY/I3tCP+Ab9Wgb8jIXdO7QdLBDnqk8EUUL24dwtKjyQHkePaggPjbg42qZL
 mI8e412MCzI3pkHAQAZcXfZfCdBG+/JY8PY+uz5FwURTOVSEVF9Bi0sdBng9YtjBNA1LZcy14bh
 f9KEf1vNJ0QwGDxN7JWlyKPsoIM+a4Z+Vwnv3/Xey1G4m44p24saelT4MXlPqchGMWhF1Wj6D71
 ccU1+uOYJBvprGkRCYxkOTKbvMRG8mEEk3z3EVrtMcOxkccgm024dYAInFFMGJ/ZfDbdf0Iminp
 HFKc99mv58NfLY+0HfQ==
X-Proofpoint-GUID: rCkzwb9TvYDb0cYWuQPoeJad7rvNb-rQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050031
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

This series adds new GPT-backed bootcount device with
ChromiumOS-inspired counters/flags logic [1].

Patch 1 is ChromiumOS-style 16-bit flags manipulation routines

Patch 2-5 introduce extension to existing 'gpt' command allowing
          the user to update top 16 bits of selected GPT PTE flags
          manually.

Patch 6 introduces the new bootcount device with compatible
        "u-boot,bootcount-gpt"

Patch 7 allow U-Boot running as a coreboot payload, to use new
        bootcount-gpt device.

Patch 8 excludes bootcount-gpt from being used in autoboot code path
        to allow custom bootflow logic.

[1] https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt

Denis Mukhin (8):
  cros: add common helpers for GPT flags
  disk: efi: introduce {read,write}_disk_flags
  test: disk: coverage for {read,write}_disk_flags
  cmd: gpt: enable extension to manipulate GPT PTE attributes
  configs: sandbox: enable GPT flags extension
  bootcount: gpt: introduce GPT-backed bootcount device
  bootcount: gpt: ensure coreboot payload enables DM_BOOTCOUNT
  bootcount: gate bootcount_{inc,error}() behind
    !CONFIG_DM_BOOTCOUNT_GPT

 cmd/Kconfig                       |   8 ++
 cmd/gpt.c                         |  97 ++++++++++++++++++++
 configs/sandbox_defconfig         |   1 +
 disk/part_efi.c                   | 141 +++++++++++++++++++++++++++-
 drivers/bootcount/Kconfig         |  10 +-
 drivers/bootcount/Makefile        |   1 +
 drivers/bootcount/bootcount-gpt.c | 140 ++++++++++++++++++++++++++++
 include/bootcount.h               |   3 +-
 include/cros_flags.h              |  74 +++++++++++++++
 include/part.h                    |  24 +++++
 test/dm/Makefile                  |   2 +-
 test/dm/gpt-flags.c               | 148 ++++++++++++++++++++++++++++++
 12 files changed, 641 insertions(+), 8 deletions(-)
 create mode 100644 drivers/bootcount/bootcount-gpt.c
 create mode 100644 include/cros_flags.h
 create mode 100644 test/dm/gpt-flags.c

-- 
2.54.0

