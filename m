Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A094C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7422B84DA9;
	Fri, 17 Jul 2026 00:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="nqqoeHRQ";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="h6PR3CuK";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="M0Hj0hLR";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Pvc4su8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDEFA84DBF; Fri, 17 Jul 2026 00:34:20 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4744384DA9
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GK9gJn3120698
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Wnx
 tmDkBqJfuVV4jwg+qFfeCM6PA3ZfBg/C1lSe+zJY=; b=nqqoeHRQruMoYLsPhM1
 0dzNNh+vZLwRfddr9p3PSOHvkgVN1yCt6gCAPohj5JpIsm9LQLJm/USp9bEShUuc
 /1tV/bDYa7YlCoow+9xXNc3SE95ULyz1saojeyIMW6jaHFhsEiAFLyGIDOnYLbl+
 ndvVMemoStu+75JVaiyM3VIas/rWK2ntuS4/nLM2p5SB3rjT222HfYFIgcpPOFea
 3i6AbXyvRSBSYUvdJXIJ7gEl9CjyBDlbWzfAE+C+rlH2OEQAvxEqpcDccv/nfVwf
 jOTbMbyHH4hQ8BVLHJseJwVGLaiqFa2pqDso8HwQ0Y/7o6utv5+MnG2msMSmdnDA
 0yg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ff38n33dx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViNaSkkuq65nT64j5376ADyYeio5R8jZ5FwAam6ZdaDoWm8MUfVctkqPAgIjSiPhXzGckzjY/bmGsfC1R25aW3seFRarJqpMdCyBukKzr9rxhN32RXKv7lFslq6/GNlpplFirnwCNuwpP13OKI3VQRI7RF5Xq/rF0FSphYVrxRSuYWFUcfx9eJI3LDbTtEahXW1a2kQDG/2TR9EqmB54PzD9ZyibIbqgi1RKPNii9w97uSsVoRz/8oX+Vm41iG8hb7gTPbOUyc0SXFp1jqVYaaYSIcRo27meEOjXTPhUvuZ2Xv5GtIEv7cWbCMQQew/iDbgNANc4bi2fDxB6kziP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnxtmDkBqJfuVV4jwg+qFfeCM6PA3ZfBg/C1lSe+zJY=;
 b=XXHTNZmgk2gL0QMjx2tqcrwRY7tgIRTTerzI7qmipNiJjXdHw2bviK+l9Opoh8S4Z8fWt6pPSoHI+8YtGRD+X7YnaS4XH/RuhYhKRyONvyfSNWCzuXdjd1RvIo/06F1LVv9u4CL/+jc1KXVw2uYW/M3Wi52d832nP1qTI9NWBxPCWFqLAdqIxdGlJK4YC/mMrhXxRDkjvNt+00lJfRJqUrNwYm2gb67N6t80xbYsgNRDiUaAYmRH5TVQWW4FSj7sAeLi6erKq357VTDNdpjbBWddI5iCw1kcEtovEuRQ3YWGR97G7c0Lknj+Q4hLxc82dG2VveE6rEbsLcMXw7J+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnxtmDkBqJfuVV4jwg+qFfeCM6PA3ZfBg/C1lSe+zJY=;
 b=h6PR3CuKeRSetj4fYl7RikEBxLHJEwEQ9sTSJbzFlflXYQCkZjxMAvJ7oN2Wfe6I1xp1omGl40nFKzQZue9fn6hxcAeXSUhnXY3AedpgZcpyxPgRZo6Kg0DZDT3vuX5Ur/jPQ8O5Oh120k2kc1izl3rImi/F34emFaMA//JvfhI=
Received: from DS7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::13) by
 IA2PR16MB6348.namprd16.prod.outlook.com (2603:10b6:208:4ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:34:12 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:259:cafe::16) by DS7P220CA0080.outlook.office365.com
 (2603:10b6:8:259::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 22:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:12 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwJR6114152
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=WnxtmDkBqJfuVV4jwg+qFfeCM6PA3ZfBg/C1lSe+zJY=; b=
 M0Hj0hLR2ikOJ58f7CaB+ZeDuJBhUjhYHPbmfft3JHDQ3wEcwmtvfwM97Jzp0vlI
 jOoZyg6N64nM++S/LzTdHXP+zwh/0tVAsMcKl/3rV8WrmATSPsmfoSi5LyJ9t4aM
 k8CB/FMgvCEGtzhkdgxa4FjjCG+p5AhXPlcRCa6Mm/oWnrGmA1vMg9K5rUeZV2rU
 l1Gu+2yytAqXduSulOsZdMl7utt6QRcKifkK/zioIQk5IW8xZ2tWD05Fm1qAfvZA
 RMa4Xm8z1GnBp5kj6VIJUncPQYT1iCp9Muu9uFMhI3XhI95YkxBApSw/tgHzMr2G
 3tWexRRdxZHvAgldDLIU/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=WnxtmDk
 BqJfuVV4jwg+qFfeCM6PA3ZfBg/C1lSe+zJY=; b=Pvc4su8QhRyVdoR3p3pXApH
 SiEmACTXSnGaiYBoLthWx/x2xyT0AT/yJBhQ0JRJaJ9hDWdWE9KsJ8uh1Y4dY/Cb
 BULYZhjFHl3eS4nZ9uZz4uFOpnhsv7kuIvp6JGHoOrHPA9A81D+J5riyt4iQ2RzK
 8KM9u1LzXLmFbNhmiLGWnws2yly62nH/lSGxtm8QQR3b9fXlJ7T627v8sZktRvGS
 FM3X9V8jMHqBJGthUst7gRZF+0A0FuxmtIxbnVur+qvWvX5AbXBwJNot4rr5Y9nR
 O9+YQThajUvSUMseJom4B3y03NEhWRXZHwpC1RuH+OT2w51AHUjXLdZUHMHU8xw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fc4f7xcvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:11 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id kUefwVVXrERZKkUegwDGth; Thu, 16 Jul 2026 22:34:11 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUefwVVXrERZKkUegwDGth
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 2/7] drivers: block: Introduce blk_flush()/blk_dflush()
Date: Thu, 16 Jul 2026 15:33:56 -0700
Message-ID: <20260716223401.378989-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|IA2PR16MB6348:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dda32b4d-fd9a-4a31-50b6-08dee38a5c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9KUvc18EXK/EpkhfLDx0HNu+jpGlBmncZcwLNffN03zsUM6z1IFkFgAL611au+V5lks6Lj7YwNcrtGCMqDsP6rVu7W72HK4aBfmndBdpU9k6h2VmvEKejksNQ/Be877ncmoU0OuTvlippky/C7RIfsKkp/IB87swamVA1r0ugaOFHCqN8JFZ/MD5ASy44MlNNiocsgGwJZhaaLpriMLIC0K8aFT7cK+2ADxNGwVkghOMQsv1mz9p7j6cYYuo5s/6Adj52C3v+XqcGFu5I9/TzObAbjaxvJhi4Q+aK4TAYLk27sXjMGUdFMJ/5hNa2aA/R8/A+hZDaZwMv6R/YjPbwZmXc2hr/F5yKxAaJ2X49X62/n5iSTkCFZSJyOOEXv5RifYJbVHbC3YWlTjiTljYmV/xSUteAvJQGw9sD5na00J8ATWJ+nSsSkd79gJgW/aqJ9Fl+1Si2iIPbLWxIk66+hlfIhPx7UrhWSMvjpwH+4XPsTTUrM8W/LWbRa+iYs9YIYAT3QUW6RODouxxYlds7b4KMDLnhT8feYNgsP0wFhWRokpjObzwgCz3dWQAtIiF6mFKDco15moySttXltz3pAqTQ+iZ/EKSYv873Yt6VYjnawNThNzXCn0/92V7I1M7fkyL31BE6ChTdZyao9uVDfDgQ1W64MTi3osqy9mrHFfghjQwWkYq3Wds7NdKLWyvTlgta0P2mGBI7Mvetu89Lw==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H479ElyvaCBHavyDEVhgNDIwzqH7411mrm88pZoV91XOlNfPBY97dI08YsGjJtksPplYEAN18y+8lBvg4rGRrZNu+o/y3MLuPDUs9Un6+opdnBk5ezAwTC5WwiKAt3LUTyTZtN50BDNBVPbzdBuEt4Tab+qhAS5/6SBjtNXxxOrJysUCyRpHJf61QsSa/658M429crIWXk2hSXR7wtITDTbXF1NCwd5W9sr26mq4XiDBrLhbDLdK1REPFaJjCvHCbVIA0NQvwh0fVeTEnL9ycT689xIJ92ZDe46seNvc6C8FAiFyqBm6iCkWqDIJ9lccpkZBOpiWw3pccT+BCbGXk3OvK8VnDpw/1c7J1ZaX+IapjWSg053VofnNKBgNWuw7IAYpJ4ey4OzapnS9eRG8cPfU3JipVQ2jkgP/Al3b77MGSbuhk/dSNKHzN1VA2PtM
X-Exchange-RoutingPolicyChecked: PqJEu4nWaRI03613+jXjQ9C0VIOLzaouUmpxAdrBWBr4x3wSrGk29zH1LI3rjQ/FLdFaeGqDgjLSi3YQxt5kdQahw2wJV3RME6QCp3OORrZbHKcvlyFKXX8S16D6KntPwX9rby2Hzlne4x108Kxuru7ywgP06nYUZWrv7YnpjBpGgMEtaM21hZx+AAWoKlhY0jKUgg3wDBMwz2J45JFRa6L0wJZ0VVLoqktpIF3Tn/N+OEmfoBhAjZIryEeIQHtDxPpZe1DZhKl+NrSbWvNMAKne1BoMXE3XTfmHUy3GDR09yuJeXlHVPueSsu/1XSu/ow9MVhAI02YfAqrKCkipdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozoV8euJH1Jshd3A9sO7qe1pFdvbl58ppdOJnav3AwYw5HREvMV93VQs0OdmmSMXG8eTP1Vub18VdJ9vwQ2NVItY2T8ob8dzbZFvmCBe3D0ewnY4703s65D+pK9FlsQ1tuwpIpcAq1ueecc5isWr00VXBqloVnq4w1bO4FKLWBugSq1zDDabYkf5PNbbrxsQ/YNCIM/jrHUxO7sTfH+l3ZUeVczsn/aZsXd0PAvbTbwQOSf8MwP0TIlwBsttE+VKRIZgkPwSDXaXE1Nqx7u26gxD7sVtTAbendqdZ4PYuM1OvfIK4mNyJ1ZO7kNjUN79aP1B7k0Y2E1B7Y3S4F0VFhip6mZlF2Tqk6f9d3km7dyWM/8yaXTTdNTRR2YEUFnG+jHWSew146RuW3B9FYjAEv8+ltUWdODpsv7DvWIdJ/zbIwwJWiGplYBtvvEFqu2up8LsGfZfFYlcEOgSmH03Q0SqKCsxvhrqf9AHfJ3DB1ZOmBNBi2z8kXJCMl6WOiFCBiPKoEaXA7P+Weui5MjRJlelA8bMKeSnnspFIkYDJNjcd8IfPiIxa/9PxZ8q9R78L0KC4dLZu5OSm78q+uNDpZKUO2MAydi0ckWAzmN4VllNBFD2Xsk+FDZL5LUqRRAWRHA7/eIoEh5smw9GpXst4A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:12.3474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda32b4d-fd9a-4a31-50b6-08dee38a5c38
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR16MB6348
X-Authority-Analysis: v=2.4 cv=ZNLnX37b c=1 sm=1 tr=0 ts=6a595c68 cx=c_pps
 a=OUzJ7+VCHgWt90O9wSvn8w==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=o-ERKjJyXOpNOOe7qjcA:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXy+/rdfU4oVvO
 L6BPc5HmznSJSZ0QzM9KxIvZFIi1VwFJ0foRyYRTE87z0pmS2B8KqIueAWEaHo7MsL6trxtjo1S
 7k9RAYWO0p197uk28nQxIdXakCYW6NACgANi4KMupdi4uqRg08ESDJHz0+d1Nk7MPeImk/GVSwd
 1Ek5zFKIGUZe/QcQLhrXHuUmaBo9Mktbcjsso20P0Pc95b6sqmlpbtBBCu3L5joD1AJo2ho2bHF
 jBp3Qwz5+F+HE9DoMDK6pdzAK4qgrKC2A8wupI4bcH93C1JRc5lKwZ8Tg9UuXHqkMK5TuQEGMTo
 QNN+w5DKL4SNVBA/FUwhoSZzWmSb0/29sidF+2Ab+6azvUCZLCMGwskImYvGG5H5QWdrFRlresh
 /Y6ImL9TV3GDA1FliMICv66e7Vxfa1yivLprQhPeh8FWRGcxXm8qvEUW0C4Vuci4QikfOj7CCvW
 TUiALnhkOlaHqoTcpPQ==
X-Proofpoint-GUID: dAvFuqCUFaNnhxZs70Hi8CzMh_F7b2bG
X-Proofpoint-ORIG-GUID: dAvFuqCUFaNnhxZs70Hi8CzMh_F7b2bG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX6rmar6XAA5+P
 hj9MeaiU95pbPV8SR78Z6qm9Q47sYf1WZ6kGtNay/kOdItxznPU71GTzJN+8QsUCbY2dmllmmii
 jr1HRgpsOEsoKkDM3M1QrBvWXZHo07IZiPHh5BDtA0KnAFsSKaZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

Add generic flush operations for committing dirty data to the storage
device.

This provides a common block-layer interface for flushing pending
writes, allowing callers to ensure that data buffered by the block
device or its backing implementation is written out to the underlying
storage.

Note, flushing a partition device via disk_blk_flush() flushes the entire
underlying device, so callers don't expect partition-scoped semantics.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- addressed feedback:
  https://lore.kernel.org/u-boot/CAFLszTgz6ia9qgkSq=2=JT+csdo=9O8KpjJeYi1=CS2n_yua4w@mail.gmail.com/

Changes since v1:
- new patch
---
 disk/disk-uclass.c         |  6 ++++++
 drivers/block/blk-uclass.c | 15 +++++++++++++++
 include/blk.h              | 26 ++++++++++++++++++++++++++
 include/part.h             |  8 ++++++++
 4 files changed, 55 insertions(+)

diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
index ee3cc4407d76..1a87f7dffa7c 100644
--- a/disk/disk-uclass.c
+++ b/disk/disk-uclass.c
@@ -122,6 +122,11 @@ unsigned long disk_blk_erase(struct udevice *dev, lbaint_t start,
 			 blkcnt);
 }
 
+unsigned long disk_blk_flush(struct udevice *dev)
+{
+	return blk_flush(dev_get_parent(dev));
+}
+
 UCLASS_DRIVER(partition) = {
 	.id		= UCLASS_PARTITION,
 	.per_device_plat_auto	= sizeof(struct disk_part),
@@ -132,6 +137,7 @@ static const struct blk_ops blk_part_ops = {
 	.read	= disk_blk_read,
 	.write	= disk_blk_write,
 	.erase	= disk_blk_erase,
+	.flush	= disk_blk_flush,
 };
 
 U_BOOT_DRIVER(blk_partition) = {
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 73c24fd91763..16fd02ffb16a 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -514,6 +514,16 @@ long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt)
 	return ops->erase(dev, start, blkcnt);
 }
 
+long blk_flush(struct udevice *dev)
+{
+	const struct blk_ops *ops = blk_get_ops(dev);
+
+	if (ops->flush)
+		return ops->flush(dev);
+
+	return -ENOSYS;
+}
+
 ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
 		void *buffer)
 {
@@ -531,6 +541,11 @@ ulong blk_derase(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt)
 	return blk_erase(desc->bdev, start, blkcnt);
 }
 
+ulong blk_dflush(struct blk_desc *desc)
+{
+	return blk_flush(desc->bdev);
+}
+
 int blk_find_from_parent(struct udevice *parent, struct udevice **devp)
 {
 	struct udevice *dev;
diff --git a/include/blk.h b/include/blk.h
index 8d1b70cabd31..1004d17c5b16 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -99,6 +99,7 @@ struct blk_desc {
 	unsigned long	(*block_erase)(struct blk_desc *block_dev,
 				       lbaint_t start,
 				       lbaint_t blkcnt);
+	unsigned long	(*block_flush)(struct blk_desc *block_dev);
 	void		*priv;		/* driver private struct pointer */
 #endif
 };
@@ -239,6 +240,14 @@ struct blk_ops {
 	unsigned long (*erase)(struct udevice *dev, lbaint_t start,
 			       lbaint_t blkcnt);
 
+	/**
+	 * flush() - commit all dirty data to storage
+	 *
+	 * @dev:	Device to flush
+	 * @return 0 if OK, -ve on error
+	 */
+	unsigned long (*flush)(struct udevice *dev);
+
 	/**
 	 * select_hwpart() - select a particular hardware partition
 	 *
@@ -291,6 +300,7 @@ unsigned long blk_dwrite(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt, const void *buffer);
 unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt);
+unsigned long blk_dflush(struct blk_desc *block_dev);
 
 #endif /* BLK */
 
@@ -331,6 +341,14 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  */
 long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 
+/**
+ * blk_flush() - Commit data to a block device
+ *
+ * @dev: Device to flush
+ * @return 0 if operation succeeded, or -ve on error.
+ */
+long blk_flush(struct udevice *dev);
+
 /**
  * blk_find_device() - Find a block device
  *
@@ -559,6 +577,14 @@ static inline ulong blk_derase(struct blk_desc *block_dev, lbaint_t start,
 	return block_dev->block_erase(block_dev, start, blkcnt);
 }
 
+static inline ulong blk_dflush(struct blk_desc *block_dev)
+{
+	if (block_dev->block_flush)
+		return block_dev->block_flush(block_dev);
+
+	return -ENOSYS;
+}
+
 /**
  * struct blk_driver - Driver for block interface types
  *
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa4..1f3db7b076fa 100644
--- a/include/part.h
+++ b/include/part.h
@@ -454,6 +454,14 @@ ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  */
 ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 
+/**
+ * disk_blk_flush() - commit data to a disk
+ *
+ * @dev:	Device to flush
+ * Return:	0 success, or -ve error number (see the IS_ERR_VALUE()) macro
+ */
+ulong disk_blk_flush(struct udevice *dev);
+
 /*
  * We don't support printing partition information in SPL and only support
  * getting partition information in a few cases.
-- 
2.54.0

