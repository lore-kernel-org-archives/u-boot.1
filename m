Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA4C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 03:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E13CC605C7;
	Thu, 23 Jul 2026 03:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waM9VyUGcTtD; Thu, 23 Jul 2026 03:12:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7DF16078F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784776372;
	bh=yN8xJOpEykD/kmbJPsSmAurkTpsDLRglMXsxAkJYsic=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=A7l6HLAPSh74YMsAEJBBMXLZceg+D9+lMBp086Ttvvcw1y1Z72CK5Jok1Yi3v4ms5
	 /YKMkGJxuGGPGi4YIq6geGlzppJk4Q65iiM+eHfb6saf2k23SV7Eh7lSTZcDaU8zuX
	 vs2Y0TgdpnOBT+jmuY3IxCZYiVwRD75iGnq9GPeA52eHxOHMlU0q6EIxEo83y3SPiD
	 HJnMWn/3OyL9V7UlenqHZBvUzVtQySN/qfU2aPFKVSydQZ3A006TxuOW0ngW7KzP8K
	 F8xgwrTEdR7L/xJV34q9HkKPV8C/mrZErL+1OwCprCbxEvIUphlqBuK6ULWkG+nCgk
	 zFQM+8So2kTlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7DF16078F;
	Thu, 23 Jul 2026 03:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2CA942A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C853980F76
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XidFwr_OGP7L for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 03:12:49 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dmukhin@ford.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5067180F75
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5067180F75
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5067180F75
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:12:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D248498B; Thu, 23 Jul 2026 05:12:38 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CFB8494B
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 05:12:35 +0200 (CEST)
Received: from pps.filterd (m0384718.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0XuHV3598295
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:12:33 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fk8fr8p0w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:12:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRLuG711+AonDMJheeUpv1+ML4nxJRBD7JMQ+bTVm1tgEZ8qZ0hUuyVuRuXVwGJHs9AqV/2U9FMr6/y7MJ93QFeJUvUh2/56b6yBpDpwIJxFk1FcMY0qjLc9N2wC+CKQ1eIlHp+Cgazyx6enxkiZW8tKIbTZHuklcDiGoOCYD2PTjBbTc6onwlua6w42Q3KCRQ9vJyfDQmMJC/i00ZODIyjRnuf/KSdKHiHxvKvd3UGFo2cwmAVyRmjkmAVf/6bL8bsVCy8bZpf5f0V28nmPReRgdKQJIeljA2dAUmwfGagXTd/7s4ZW8lBhwP2rnr4xOABqkQXIhI+kPcK3v5t0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN8xJOpEykD/kmbJPsSmAurkTpsDLRglMXsxAkJYsic=;
 b=hoHby2Nby6NIw8/nvwvqYp9KWKO1Q3BxaCcrYOwGYg5ZAZ5IEaXFw0Cl5x4QLQ4vFK97yIgZAiI87fGKnqhoti4OQa4K3SQnktb/PkzI37ymY2nxTTZUIOxCRWB01sipcuYRf0RqtQiZLQPkyn9rvz0Gx3nmNOg24eiEtXn+D3di8uQgC2Ql9Evf3ZUSiUzBEnVp3qGErNmbob5N/e3BoQKHlCPJt6x+oMj+WomHSjGlJ4/bgnx9ANAxVwP2QQxGbk189rFTzI2CFnjgelV82+80kMNGPcA53oE/yKkVPxMyyHXUCETBr6YhUO77pFqamEdRUjuBdSD9XByKn4rCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by PH0PR16MB4311.namprd16.prod.outlook.com (2603:10b6:510:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:12:27 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::41) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 03:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 03:12:25 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0XJfM2822617
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 23:12:24 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fgrhbn0d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 23:12:24 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id mjrBw9636JrM7mjrCwKDpx; Thu, 23 Jul 2026 03:12:23 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: mjrBw9636JrM7mjrCwKDpx
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Wed, 22 Jul 2026 20:12:21 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, seanga2@gmail.com,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v3 0/7] few fixes for NVMe and block devices
Message-ID: <amGGlR4457jNC8bv@kraken>
References: <20260716223401.378989-1-dmukhin@ford.com>
 <c4cfbd8e-e596-471a-bcce-40147be5ab20@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cfbd8e-e596-471a-bcce-40147be5ab20@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230030
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH0PR16MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 78aaf8df-57df-4bd6-44ea-08dee868386f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|3023799007|4143699003|10067099003|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gUIPhcOfiFJDCh53RAhHLt6anW/dsKwjdORwAzrM2vd1bQovm7ZgnVkMo2h17jpTvpXFrq6sPRfovOPfUjIk+1eg6btpCG6GsFyenxC9Oi1eVFCJTKiewH6Uz4BzhpeoVvbHWjVlo+qg16DnQ8MU5CtIssjBYUuI+7Hj03AnFOX26dP452ZsVXdpIxBqOgFk1sovAUn6RLYkOxLSjUSc3sg8NJr1s0Wfjn0CAUSlK6nqWZ6+zpU3+GtMpc0uG7ywKUye6iOYEhPDIlSZm2tq2+k9MhCtvBTC+ZWDuOh//Q8eKAz5B7LlGaPudKVU6MHeanDB+GNRZdxun8DXfnUySzqZss6qLsEY1MRsZDIBh4jGcUz50pYqG71IdupVndzjUVeGfyGe7XGOJmrw108LOxqGmbYTTegZhX5SrKyPfvURWY2DA4y4TZ7XXoDfk/t0V6F7SxCE6YAlyxtMm255P1TYDDJhIqdrc2skK2bOXryAtTKM7NjO9qxR+175uemMOpFffjT89yI9kDVXN32vloYYqspbNIL7PWUcXjlguXBZsXO7Cg65Ff0czIonpuoXms+JwoREMKsm1hIDSiBBEw20xxWwHFbuR0tfUPacCyddyq0OZce/K7apI2w0e+ItA1gpdtYYrbKbygtAYF1RqnwuoXqGRJGCIYmpJkgtIL9uUsvtg/JEqD9AWszz0Z+3nvYIKTgfDSbcZAqMGH+gYA==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(3023799007)(4143699003)(10067099003)(56012099006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lSrx8HlE7GMrGYhM13s4jHqEo/XMR9LXO6ib2BA7TgjE5nAmTIneEJ5W4LGSQtSxd0BGIYKoeY0S9N78cazUSMkmemIOBPOzqkQJzRdB9Uq/Fn6A1ck/r8EvAsYdy8Ue7YMeUPOLLfHehlBA7Lsyt3tJEwoUYv5GOeIeOH4/jPiRSawLvDFIyPpMvkV1Gw2Xl6bU/031b199Z85N19neX8OKBQI4R/3oc9Y2O1MNuifaY5kR5xzH7guLxyg+R8JzDvytSCAcau4K7UteG32pC3MM8VV8NbDGVZdn2towex731Uwd3hpdsB1s90//+M+CSDiZwPsrC5z4hLllGzTCm949S/jBYgwRKxfPACq3PvvHa663+iws+vLPiore2BiYZIPtDxP0vhe2dDzQ2hHENPFfqs0EtxX4pT5702DcXpHBEM8vCsr3uI7/3cHNCkWs
X-Exchange-RoutingPolicyChecked: AypFLE9EvzOn/THTQIPXbekqSC6XfUdBqfzz59zSkOD8QNS5dgDJvP6f2nOC+qyZkBgGhnDf58WMoWoxnmwQcl93W4/CZ9YGyMfVZfqLS4Yr3OJBGFSpNxZ9JMNG5Xdj5I5qNqZVFES8xbrDrtgVFAyc1PTZzFwuodu7jZDs/Jp+z12l+fs9c1P0avIjGvnj7TlQVwTSCKTPH9QrInKy8BS1REzr8uv43C8A/yGwHMpCW8qUddlM+A3P3mVQJJKtdUIxVEdVRRNrInI775XrtXU9dqVBXJWCXeKXlKriGUPico10Puv1Km6Pz67esRRWDoWwQYB9X0uIRRZghA3Swg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lxo7FImS8/bLl1+6zamuwohOlOzOOQ1Z8tMu8nCtVEskjD0UP3ETl9KABQEZM4SpORLyGvyYRSraiuKpcV49MumHtRK85Lw1rbBiPwNygHVgp4oD5SZ5bVS/HUsiOv1b2uXYihyxSXnY0/XuUqW1h0fptIfgEPcpeKpg/xQvlCBC81/dd74fwu1M5fG/Ypeny1d8WDMTxGWyHBMGXhhN0qeB1ujoDjIK25pvhjcmIJPHjXg6gBYNGq4eHciSLYyHLJm/YXnJ4GdEsPkRfGYpBqpUyBhTEWEK8pocmslLlVJduEmIyPf4O3RB8g/dXyCkFmra6IbLeF1liKFLIzliTrsK5vDRnQ4ZaL2Uluj3otV9iBhD5/aXi24x1Mxtjh6Z9pBwAAOq2Lwt2jB497NsGQO6IUY3h3oRhVeJNin31qCeIfadhlRggZHSYl+6emBIiNwpMNfjhhTCXHOcONVTK7jO8zJwRVBzUYSw0MC1Y0Chhk95x5W+sTgp65oeH9oBiSv3J1suULH1VY0uyCzlCrB0/S58/A/M6jOUCtVtQVKyN3Ap0NhgMhq72GcRKlfBGRrpWEIC2F9FykOPZmIQ6XYdA00rZTfknCEMSw5DkItWdkWRKg5lXLCaRQfaKwcnDR9EYRStgKenprXcJWL+NA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:12:25.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aaf8df-57df-4bd6-44ea-08dee868386f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4311
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAyOSBTYWx0ZWRfX6SC2ezAW4HC3
 ALFL4JaKODiH8H7ZC52r2zhPt3cBUYvrAbHeYvDLpa9va3yau274njZisvA5ax6mWo5muHalZQJ
 ujiANYLOCH3hTDp/oinmPJiHIsNzm9oc1jthhvEnG5wfTwLXm0uJ
X-Proofpoint-ORIG-GUID: ak0qqiavuJcmNbO7VhiVyJByBk9kxZHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAyOSBTYWx0ZWRfX+aNjGNpfVqGK
 AZ7ynb0Ia5guZ8moZ5dQ6au9gnDg6pp9HJEcGLkzZWO38pdPUehgB1MX2OwaPiEGlZ5qW/3UCgL
 nu94cihH/E0NMmOj5LrMKyC0cA510saL1TOQNBlXwSoN02H7ItEaNg+n7uRaqW//R1nteRBB4Ye
 A99dpQdkTldeew4nAk4rXFCnCDNM17g1hPCWPZ9+S09MKXg6dijt4zP/u6f8fnK2ld4QWE1rYBP
 l4oiOBaa8SOq0RJXRdcrVIjkDTtKaK2gwIXZnUpn+YG8v4vpINCfgv/C1+6onYLjAnf45dLNNIg
 ZOEU3rPsluCvdQeg64NZA5+OW0iIpSfMkHwRyU8/x7SrSeNFyxP89/MVoOLOw+fbu5QmppcCwYY
 U11jQD8V3AMbdXjgtUPuMxc8c7V5cLSriPZopOb2GdaVQYoi3maJLKMEyTUd7mk4befD6PpdXh/
 TyQug9VkdLJDDHrXShw==
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a6186a1 cx=c_pps
 a=A3soYu1h9hn2xD7k0nk5XA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=ARvDHhclS48edyKYUbLB:22
 a=VwQbUJbxAAAA:8 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=6MK0urfzVrqB7U5YXDoA:9 a=CjuIK1q_8ugA:10 a=DqJYxgmhk6moR-_7_KoZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ak0qqiavuJcmNbO7VhiVyJByBk9kxZHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230029
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=yN8xJOpEykD/kmbJPsSmAurkTps
 DLRglMXsxAkJYsic=; b=f5sffUJfErGrt04HO5Sur6oFt31cFdk/4rhxXl/5J8e
 ZCoEtmYa5jQZNhATZBYJUndnf0BbS9iH2yxanasTgON1uAtDJaANzsvCiMDQlcPf
 4c14IMGFprYH82EfUigFr7euYT91J8XVNbyu+5Epoy+Sg+251AtjNPjcsP/+XFFx
 r8QNSQKTq1DR8fhDrKuZWxqbVzcUjnod/GtRmxoTFqmDRrDfUjj29pXmoce9fZ0E
 GDKdGar/Ln1CTdb81jiU+Yi9ieYuqmrrWSlrHmcvyrzVQJAA1SNvt024vEtPnwfu
 l7HU3krFFvdfj1ksGIub6HBql408UMieEYhirxPXH1w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN8xJOpEykD/kmbJPsSmAurkTpsDLRglMXsxAkJYsic=;
 b=FGBK1stCKm6/xlAqDZuvWy4y7q0d/d60PF6ZGvCWGhauVctcyr1IklihQC8clZkivmaO1DgggEY1sUayoi2h8sYTBG7hSn5D3RAzKG8RmZ2DNLjDV408EZltXGKwdOc3r6CAlZmFkIfAjT9/VL3IrbIIAFMZTNqOWW6NHQZSHO4=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=yN8xJOpEykD/kmbJPsSmAurkTpsDLRglMXsxAkJYsic=; b=J4HJPH4vBAn7
 8bVGr1P1BGfKib/xGiL/eJN34eZ3UUQeW++f3z+dGujNy7kS8JHFe7jNtEDPadHL
 e1YtEJ3c/rcyuCS0akObxtjrczR7+xJILJMlcwNB9X+JUxgwf+Rwomooq5sswn/b
 CmPEQ/DK67g5gQTVKyYGzYAa8eSQNm5ei8ZTYGKJFCM7GV7+Wyh7fBOxZyg4YvGM
 xUiAj+Jjnkv4Nal8azwZO0jop+5U7gPJVYi/dg6rcIgYxUBBrcOlF2vgc6R0kYw/
 yBH9FjXN1x4vaqHOOICeLTDP4ykWNurbpJ+22rav2dCJV2gqrzt8ZvQOUu/TsQD+
 QwdfcmuwGA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=yN8xJOpEykD/kmbJPsSm
 AurkTpsDLRglMXsxAkJYsic=; b=Dp9L9jrF4JNZl4q/87DibOmxfUsB89lpPUrY
 pG2iYFue2yzUcfXELbIqCaFe+EjDJ0zD5cAyzizEGUo40cM3wP732bC00iEtx8WX
 pEqhBB0GuNtrDXbMLrGbGSsxw6+TPFUk89CkXeQeIVj6g8VQoWEe/vJMM39evn8V
 581tD+zjK8XZuBTx5pV12fwMkRuz0t/+AVbG3kl6oPLFTQ2x9bprF/uIjlWhn3Fc
 EG3lZQBbsEJHcg+6HX50X5PQQNipEu3hmG8AHqCMghO01GcyotifWfUSLW0HpVZ4
 5rYJp/G/Z3m630R6812ATWAFTqxXsfg6GHPUcFJzy7ugx2Pv3A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=f5sffUJf; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=FGBK1stC; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=J4HJPH4v; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=Dp9L9jrF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dmukhin@ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ford.com header.i=@ford.com header.b="f5sffUJf"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.b="FGBK1stC"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com
 header.b="J4HJPH4v"; 
 dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com
 header.b="Dp9L9jrF"; 
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

On Mon, Jul 20, 2026 at 11:33:02AM +0200, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 7/17/26 00:33, dmukhin@ford.com wrote:
> > The series adds few fixes for NVMe subsystem and block device management.
> > 
> > Patch 1 adds FUA support for NVMe devices (original effort in [1]).
> > Patch 2 adds plumbing for blk_flush()/blk_dflush().
> > Patch 3 introduces NVMe flush command.
> > Patch 4 enables `flush` subcommand to all the block-uclass front-end
> >          commands (ide, nvme, pvblock, sata, scsi, usb, virtio) in one go.
> > Patch 5 makes nvme_shutdown() symbol public to enable use of it from
> >          board_quiesce_devices()
> > Patch 6 tiny fixup for QEMU command for manual NVMe tests.
> > Patch 7 updates tests for flushing block devices.
> 
> Thanks for updating, but now you enable FUA, why do you still add the
> flush infrastructure ?
> 
> With FUA enabled, calling flush command would be a no-op.

I forgot to plumb enabling FUA behind the Kconfig knob, since not
every bootflow needs to persist data on NVMe...

re: flush: My understanding that flush() infra in general _could_ be useful.
That's why I kept it in the series.
But I agree, w/ NVMe FUA enabled, flush is redundant.

> 
> Neil
> 
> > 
> > [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
> > [2] Link to v2: https://lore.kernel.org/u-boot/20260529034441.2075305-1-dmukhin@ford.com/
> > [3] Link to CI: https://github.com/u-boot/u-boot/pull/995
> > 
> > Denis Mukhin (7):
> >    drivers: nvme: Enable Force Unit Access (FUA)
> >    drivers: block: Introduce blk_flush()/blk_dflush()
> >    drivers: nvme: Implement flush command
> >    cmd: Add flush support for all blk devices
> >    drivers: nvme: Export nvme_shutdown()
> >    docs: nvme: Update QEMU command for testing
> >    tests: add blk_dflush() coverage
> > 
> >   arch/sandbox/cpu/os.c             |  5 ++++
> >   cmd/blk_common.c                  | 17 +++++++++++++
> >   cmd/blkmap.c                      |  2 ++
> >   cmd/ide.c                         |  1 +
> >   cmd/nvme.c                        |  1 +
> >   cmd/pvblock.c                     |  1 +
> >   cmd/sata.c                        |  1 +
> >   cmd/scsi.c                        |  1 +
> >   cmd/usb.c                         |  1 +
> >   cmd/virtio.c                      |  1 +
> >   disk/disk-uclass.c                |  6 +++++
> >   doc/develop/driver-model/nvme.rst |  2 +-
> >   drivers/block/blk-uclass.c        | 15 +++++++++++
> >   drivers/block/sandbox.c           |  9 +++++++
> >   drivers/nvme/nvme.c               | 42 +++++++++++++++++++++++++++++++
> >   drivers/nvme/nvme.h               | 12 ++++-----
> >   drivers/nvme/nvme_apple.c         |  1 +
> >   include/blk.h                     | 26 +++++++++++++++++++
> >   include/nvme.h                    | 11 ++++++++
> >   include/os.h                      |  8 ++++++
> >   include/part.h                    |  8 ++++++
> >   test/dm/host.c                    |  2 ++
> >   test/dm/mmc.c                     |  2 ++
> >   23 files changed, 167 insertions(+), 8 deletions(-)
> > 
> 
