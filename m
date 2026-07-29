Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82188C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 447B460ADF;
	Wed, 29 Jul 2026 08:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iMAmIxL8d4Mt; Wed, 29 Jul 2026 08:21:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CF13607E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785313284;
	bh=R37Xs5tW6S3wq9KaAW5SEfc3IN805Cw12O8PURcW8ZM=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ixSE6LHM0ADElRbY4wovlUyd64+WffD6D3Iugjzoryt7yaISIN91qIj/z92drndnp
	 YvqwjpIyKde7sakRgc+ftkrj2HWjx9U4MqX1sAA6Vh9XhGrQ2P3uXtgHvbmtz5El1t
	 f0nIf5F+/yeReJ0H5zvmJa2qZ98fLUGrRKnjErDPNnNtO0/PB5ZsOacMABGcfe9qQo
	 RFbSAqSAXe/lEXX/EFulqOu9PpKHAMxhv41botAog0j/DO6ayJASQHfkkpVIMGspdT
	 8KJninCWiTAqkJfEKSAzRh6Q1DQvIlZPjG7V2SJ2KqqtOuBpxs4xjFG3q1PMmJp/mU
	 2zuAYdTydTBFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CF13607E5;
	Wed, 29 Jul 2026 08:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F91194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57A9E409AC
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQTGQ6CNqNZS for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:21:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dmukhin@ford.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7FAC4408AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FAC4408AC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FAC4408AC
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:21:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3CA8494B; Wed, 29 Jul 2026 10:21:14 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13CB8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:21:10 +0200 (CEST)
Received: from pps.filterd (m0367129.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7pbhA649692
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:21:09 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4fq9j91sb6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:21:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA6xNdrJZCVWgZrtQ7cuaHHBKmkifFN7IGxrq+cNNypBGiItfTHXP3dkIlcEKe8uK9+C0XbiumTQ5KbiGkTJJCrIf0uZHfLfVGLU2bbG9m47qDrGfL3SQB/wf42Gx1WLtJEfq7n9122144iVhi+ZP9L48k/gZa7H81JXft2DJpA1DCFMsaZC3mQKqPFwb0WEdz5Pu2Qt71d3CtPie76NMPj0/d/SMVl72FsdhGgwEbZ6nhg9GzUM1Eto1uyZ9AvXyqLQzOXFJqMdd6Lg75N6c0ninro0PnY3c6XiW5RjQNcgYBpeVjR02Tb4dSbQDbVfvvL/fsiQDGhELsD2bs8Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R37Xs5tW6S3wq9KaAW5SEfc3IN805Cw12O8PURcW8ZM=;
 b=s94qC4pS5gz2bOG/6OBYCV2v3GOs7mXEyaNICAxub2ZAVrOPr7cqFIVrE5jygRmn96r/dy/YRtV0cDiP426Trkc4oLgQyiXtzRkhHQAG91bHu71DPYOIZv99EL9foU7r5QFDmg4Qtgr55icc/SzBPvvBeVLa6bYfrVz7vUHFgWL8InE4Usm0DwZUyJu+FdQsShzTBgzaZkNsJ/0spsAkQEtPrvfcQ/jrKuMPLaBQ/Hm0NH1O92t6vYco2ESmo1Pd9tXHCyJUsbwDAvD9U3LV7Xl7BsDA7E/jpVaAiGUZOfGNoaoHUQTeDDxyVcF256o/ay3ryAJmWYpHf6/zD8P/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
Received: from DS7P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::14) by
 PH7PR16MB4747.namprd16.prod.outlook.com (2603:10b6:510:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:21:05 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::26) by DS7P221CA0031.outlook.office365.com
 (2603:10b6:8:25e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:21:04 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7dSCX3597040
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 04:21:04 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fnbk4mc89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 04:21:04 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id ozXBwHPTXAJcNozXCwkBKP; Wed, 29 Jul 2026 08:21:03 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ozXBwHPTXAJcNozXCwkBKP
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Wed, 29 Jul 2026 01:21:01 -0700
To: Tom Rini <trini@konsulko.com>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
Message-ID: <amm37Zq5IIefdjXP@kraken>
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
 <20260616214450.GA1740849@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616214450.GA1740849@bill-the-cat>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290067
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR16MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5b86ab-ad1b-4c25-f56a-08deed4a5574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|56012099006|11063799006|4143699003|13003099007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: i9bXSfKXhBJAo63xDtYen5Qdpql8Feq19U4ucs/TA7a9Tb2tFEwUr/VYfrvwTNrExHyFEbxv1hdc8yzLlYs3Rn2B7FqPsomLtf7UYPNCBKQee2qH/06nJCneYoNzMRloAoIc3K81dhPFJUWTlgB6G3kqaXpHjnhgWVoTV5+DuaP7sM51WeCwt2NsjJHEIumPwBNPtctDEjFCdTD6u/Wq3cjJChTzACQ4me54e1MPJOqbEVZ53mL/0+0mX9Tpz8qTNT7VAxmjY4Am+TSJsIcNZhMUoSgoNUTB6Vkj496Smr7Rz1zee2b6r6BzU9o8PmvipfrmjcsTrfM6ZceGamCgphy+abj1oBXIRlHmVuDsdInFnpm9Xqatuay01M7oYMDF8g4LMPR1xLmxo+PS1EswWhrCzGr6s6hwVUcWYVjEyIEm4ElWvYikUVLiKDnPiK8XMmVHfRmB7qxlj4yrj6myhZp3M5pkMTlrj+iTCYIY2pUZMr9QDozKgI7xJZxVfPb4WsjFWcqlD5MjQTsmJX6EYzrmtHm1gqtAeLPGTphEq34hjdxo2ZTB6cLIEJXM4xCxnUQJ/+6MozB0NFPs4fLmjw+QIGkJ92HxVZyZVtcgCtrEtPshDQFRwNNaDq06E7zncziPhGPy+xGtpP9I3+n5JA==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(56012099006)(11063799006)(4143699003)(13003099007)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8dLq85khjzU33Wod7JwDfWQ9+NMWEQaizygcptMt6OcjhnbXODXVbU5+QwT902N+wZCnLnM1TcYeBFo3+n6fcjY3WNNzmXkdZ6mdnkQpMqxIHelDEcZ0O7IghvS7E/cj3yjhjZCQzYsmsTeI1F2/l9GR8rMMcfeTJvvdOvWFYSJj/SW1VrPvOyj+Cc3AmJkfLA1Vkf+HHVmFKvkcOLGiNJA3MPWvOwJfnkYH0eXBmEMeCAE0/uM4T/dSq/MjcRMvyOmaHlVQdkp75X9NOl5nqoGpPymhJR7dT+F4KMLiFWcAx8YajgIvxKAXr4nqUpX8Xk6JBY0nnfMBIq2EGpGPQ72UlqxyowmGP7Vm128lKd8TP9FL9ROmHVxTsOu5dJBvdr5cMCsdy8VeOLL+2kpgoXht2tp28GITmt7SBHoZr71h/2kPwfUMoSZ1BmOTszq1
X-Exchange-RoutingPolicyChecked: iSBADKtgNjzcx9S7deWTjDrU41Y/5uknwmGMOxZR4aluHMNXMHQc8rP9nJyeJ6FEDXPEee+o00fIaI0vXNnKWsP7YND/AvetZmpVHvKYUXiiPncKTxatOBnUGR7TIzUYpbGzyhBKIkhODEa/jTMRjOmYWZU6svPQmvm3mGSqlsD8BMRnyXLw2t/5+LybR1Uc1G5X0K49mcO7HpTOqwGIBVQ9VFJjkPyAlFU5aIVL9obB+Wwes/jZ2ltWWrKVdb59Aya4hSi9MowAGGXPhr+CtspYVxnQQOM+UnDAQJYzxPPMSJIJT8b2P3jilBbkQZcCpefkbMhub1xrjagP5Q6P9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6KFts/268CiJNPrhecuK0qwq6WDht1Em4wmOUIjPkQ+NKy2+CxNtRQyvai06wYo+lxq/1OkUo12bVfjaWyfMHhJZF0vk23HIoNonVqk9hlI07eRyLr/8gYG36Fw6DtZ8ehLYrNQD5rdmgj1KHO/hffDAjbY+ibCKsKlXpN7XJL8rjUk2OgWcrlt2jVtXhHOSTesKniHgIL9MRTlVGulKws02FEo/RG/zCVJHh/fRZWRw8Z1PnNIl9MeYvTK+a3HMoic5fUtVNdMDedicYvFwZtxYTx5xTeXEo702H8KVdosyrB+zd37OjMeAu0Renj82OplKtUXhNn1fz7QYt8jQjARqrc6Mh/YgVQdAU2jCY3Tp37aB4U+fxCEdTYyvpvFSgi0RNYQQZ1qEI8u9i7Hsqmm/EdDtl2CTjcCrQBjADMtnzLJebKIzoXWprXIhJVk0vDRmUYHruwNspRZhcr8NLoC/3TBRZXP8mW3D0cbn1N/TOM8QJXl84p2WkYSnoVJwwErClIVLpH7Cw7QesZgsCEmyXNhGapjRFXk0S2WPSQrpwsoG7U7W4XmhCHl1hMBooXlAMpShNRR97fOunRZf+/uW7/eImra7vT1VmnQ9vghU2jK9i8S1CbRvPNNiAB2eZOredKZ3FUng/ZXuTNBYGw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:21:04.8807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5b86ab-ad1b-4c25-f56a-08deed4a5574
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4747
X-Proofpoint-ORIG-GUID: cEotYsGxDx5QK7xqhKYOSRzN5Zoif9xV
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a69b7f5 cx=c_pps
 a=JoWddxUZA+6WKbGFiApbuw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=X3KReqg2EL6A36SYCKpz:22
 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8 a=cbNQJ9GKAAAA:8 a=dZwClMI2fhEQOhGrlWkA:9
 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-GUID: cEotYsGxDx5QK7xqhKYOSRzN5Zoif9xV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX9VqleM7l/iAE
 R+EXfMTJobjkbLd6o5e+oeLPetxoYx34z7HlL14ygbxyBkG8py9nXU3RG3i9ov59CPAAgCjz3TJ
 eK7Nau98IVj76blWMIYYiHHWdXgTJ8By5+bzJ2m0qnl1T37jbujTHiQ4EmFqUdQmpJICHIGjel1
 AyPDRYN0lZR+ru+iHSHuw/KMguvLIOTlsOHXNvIBJLBzipz5S2XKc/dzGuKmu4pJl17km2GqvNL
 Gcy1HOce1biT6YGusPDAOGtuGrBlzDTxGNctT9qlOzJ2dO6O7LXZKLhzSvE/2Z+etAQHQmREuI5
 QNvNuz4ySjhYrdkWyEusXECOIaHRh9fWoowTaNP2ew+ko0wl5ks+kkJOYYfTmIpPkmJ5YtU3tK5
 mEsUks4Idtaw9u8RHtwsN6iZ+eyQpcLtmQ9R0pPclSve7sXu7PBx8NhwYtp0kiCGd3DYIp1wKgt
 j4e0aJZqyK53MRNERzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2NyBTYWx0ZWRfX7fmVy+FY/mnE
 UA86MglV5GFNowXRXmgPqJmad5A7mexwF3naAgVadsdXM2RdM9Pm+zE3ubowDY1FaLk2fyS/534
 tzOge8uXHz8xbuh13fL9uu+hX5Z8J3B9G8v2HdrNZTB6xoN+DLqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290067
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=R37Xs5tW6S3wq9KaAW5SEfc3IN8
 05Cw12O8PURcW8ZM=; b=Kszuc+mBm7dKSSB0/UBmbPBntvbrtDffmJRV7twuJA1
 abZ0rgCEw98kDK+rBF/p2aeOtyG4cNMYGNc85ld3318uUtaGjNppt5TvbZbkWKuo
 6lBtYeQDPy0Vd360Mu1YUNpBgpXojWi5YBd+Uf+wgMCNe0GJ5T2AvxVIG8ABDlYP
 LGUnJdNtON1VGGwtgxHYSlv5DQbPvOHvo9jGnBKboq74EY7Hf7KMo1CRezMTgV+2
 N3d/CUMqCtAsozdNWfvwaxPxgPlJ0FyfAhEpUnf+9hD2nNMWtnLcVbRfnIYYWAdS
 29E7ewSwZBl2ddyzL1H3c2Lv5enbL62zPMTNGq67RsA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R37Xs5tW6S3wq9KaAW5SEfc3IN805Cw12O8PURcW8ZM=;
 b=Ff58s6iAN01mEXjB7qacQRl6U+eQajEm2rByJBClfsT3OkSD1BriV8FpnjcQlt/n6hRrFFwHkwQDG39oMi9tHxmNrMSLwf4+pj0d+/rzDge+wE8/eubuE8/QLbVRVdPuK3qKOpgtqezjsbSNnvynEYhTSTGuTOM4NX36RLcdn2s=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=R37Xs5tW6S3wq9KaAW5SEfc3IN805Cw12O8PURcW8ZM=; b=Qz2isG8amNvp
 C1WBrBICF1lxAaUlcMqvFphfVxm48fjy7FwVYWrHlCTQL+gPc8UMmbSGZ7EYWzgv
 eFwnizw+4y2VpJVqwP5T1N9Mu0zcvpchY7m6Etmr7PuU8M0ffs2/mzkKoVQ6oezD
 sM8BDSeCXCAY+QnyX2nzVtvpdmK+mg4aiWBZrFkRJxK4RFipGRugOP9aIFcANpsG
 p6GeZ3iZ3eHqo//eZmGuKeWRQD+yI3F/9HPIVt36Quc5mcS/tuYA8xhNm0VWQW/s
 ezho2btUwL8/MhoTLwGRcl9+V/1IPqxC1fkvul8bKAwPQUvPbRRVldfu+qg8IfN0
 Oj0EeXjy7A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=R37Xs5tW6S3wq9KaAW5S
 Efc3IN805Cw12O8PURcW8ZM=; b=ZzUHH2aC+XXn7gvlK7OvKLGh8YWQLTFMOmh4
 uBIktH0c4u/piEBKCP8+a8IGUirZm9h5M/A8utJS/1kZysI1aeWRVdTvJXyZCiP4
 2WAIJC/rLeXDVBQ6eB9rJvBBnr8W09+hAwhKFa1aavJAg5pkR2lkrIREFLpNqwAa
 Ca/fk//eS7jjAeyl6XNEV9iiFO7jtFrYzywKjXLSxgJxpQybsOIt4AjV3ou2MS8T
 zErjNOg8gORjGUGiBxJx4AsO29aJBPC5XBfTewT77aRAKjnXmk+tYdzce/44ONLR
 AIg8sEOPsIIAiXoswuAm1ZkiVPO0TlDRQVWM/BgRfq661PG4lA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=Kszuc+mB; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=Ff58s6iA; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=Qz2isG8a; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=ZzUHH2aC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dmukhin@ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ford.com header.i=@ford.com header.b="Kszuc+mB"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.b="Ff58s6iA"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com
 header.b="Qz2isG8a"; 
 dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com
 header.b="ZzUHH2aC"; 
 dkim-atps=neutral
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jun 16, 2026 at 03:44:50PM -0600, Tom Rini wrote:
> On Wed, Jun 03, 2026 at 12:07:38AM -0700, dmukhin@ford.com wrote:
> 
> > Some prototype boards default to a non-cold reset type, e.g. warm reset.
> > 
> > Add 'reset -c' so users can explicitly request a cold reset when needed.
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v3:
> > - preserved existing behavior for 'reset -edl' handling
> > - corrected commit message formatting
> 
> This, and the subsequent test add growth in SPL on platforms that aren't
> using it, and then one of them is now too large to link. Looking harder
> at the code, we need to start out with some sort of re-factoring to move
> do_reset / do_poweroff out of drivers/sysreset/sysreset-uclass.c and in
> to something under cmd/ (and not conflict with the non-DM implementation
> of those functions).

I am (slowly) working on the v5 going this direction:
   https://github.com/dmkhn/u-boot/commits/u/x86-reset-v5/

> https://docs.u-boot-project.org/en/latest/develop/ci_testing.html is a
> pointer on running CI which I forget if I'd given you for something else
> or not yet, but would also show the current series failing on the
> rockchip world build job.
> 
> -- 
> Tom


