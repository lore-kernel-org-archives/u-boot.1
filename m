Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337CACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E96784659;
	Fri, 29 May 2026 05:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="BMHUmNSj";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="gjPDslbW";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="mD4MCyBW";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="d9AN+3Sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFF98469D; Fri, 29 May 2026 05:36:17 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DBA8341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1CJdE376227
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=3qmJym1iAn6O77ZqEQIwY9AKmsd
 OJb9J9PicYmbfKcw=; b=BMHUmNSjkomYqzvRqpYIIijB+JPKDB0wSHJ9wjDpLjM
 9P5CR7teDTFrZa9tDlIRHz5F+VFo6cw+X4aXeYNvHpnMZBxe+JGQVqiQGlmpiirL
 pwIEGDSS5PArdHgVyXzdqLn8NSY4WFxb2sgerCugy3vNKMAaWHJ1L5VkI6Pdf01/
 MHJqzsMHnkzmzxJS9Xb6YJmN+HfsO36R1Yn8656F9ZD4g1W9YUWazxR0o2HWhqao
 7D2eWAKS7sWDiu5yRumhMCnkDFhJR9Ls/VIIOrZingMZtQjSS6aQbdJ9rBE/sxnX
 If60DJRPFr5Oe9r6J6Ky+N7sn07p1o5JUktGjmP1X3A==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef0x88kty-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:36:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB9S5e6UCDhphqJd7YjU9KN4YxqzrVf3xU75ivhC9gt74woVwnCT1sUSvLFCGgiaseh4jwda4pILXZGnkuEJmXMtjtpQ8qzOqBC6TRaqBGiPxLrYI/mrAHovUEKair9kLEAASv59xN9IT6vS1fibcgx/q3Xhen9xIr6lln3XIixoD8rDWGLRfpcUSmT8s3f3NSfvBJ2b2RWvgbce1dPN44Zsl1cQ3rl53jOxzK3ETy22aZGxQnPzPY6BzU6srfT5n3CQOuiVlnVrZrrrpNsS6oLvre61HllTJuZILD11wDIJRrK8I81d/MjTuWP0eH+nG57oivO14J/u3ZvJqTt1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qmJym1iAn6O77ZqEQIwY9AKmsdOJb9J9PicYmbfKcw=;
 b=hIAw3s1Oj6XZRab7QTVCxgLNFM2JBwk9JtwMiTQUh+DZtR5YLN2h6wq6LIY+pqXpLR8qKvzHkVeCmfRos/9oHiDWhKks/eWPej3CHMA57J/oELOSOtKP7IfJKzx/uC0vQKiwaxgbSPOEy4LX7NA6Kpo3oFrNbULutbbaON81AlQzBMOpDUhuZyKi6lvGmJ3U53JHhvFbQGLtBr/q0kPyKh2YPGYDx4t66sVYl/kxmwcqiKEWb7Cevz2FxFxgzu+5lJEtitAz5V/nLkHIKOOG7hOpMJbkkq3nLgzKYTKir0L7q6UJ5Yjdw9lF3qIxN71+DFTOtC0Mns3jXmDnW4op0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qmJym1iAn6O77ZqEQIwY9AKmsdOJb9J9PicYmbfKcw=;
 b=gjPDslbWFYpFN5OhJ7NIXXnx4oZz4QLEbS7SQOID98K4rDEVpHP59dcfUSx03MC+DDCijmO5q+i789LAj46qh76vCmNfzNbzJmxLe/h4z2x3i3JPYKdJsFdfEeloRRte8/xxtm95u1P6ADWH0QT4ERlU5ofY0ouqNaEAjvK7C0w=
Received: from BN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:e4::8)
 by SA1PR16MB6337.namprd16.prod.outlook.com (2603:10b6:806:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 03:36:09 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::58) by BN0PR02CA0003.outlook.office365.com
 (2603:10b6:408:e4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:36:08 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T0Oeuv3751409
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=3qmJym1iAn6O77ZqEQIwY9AKmsdOJb9J9PicYmbfKcw=; b=mD4MCyBWCMb3
 MzTiOLdT+KUYGwsnYqi5AK9TM4FifxLlXFPjLY2dlB9NrhszIdpTMbN5vJ91VFE5
 bs7tW0k7RdUzohowSqvNz0KPpVR6xWAyoWxwVj/1FRNgwPjEz+eWWICqXYi4WVPD
 5tznloVlFEr7Z6K4ogWOZGUWDZGB0wogbWzxYog4CAe9R3nOfriTzikRgutM0Sny
 ySkkLp5T/0enOzgIGuk7+kBQxSqBkiarlXzV1U2oahwzTPCjXnPczqXAFfipBAU2
 SHCmZTvhNyLfm6AS+SOFB6yfsPwk0J3s3PKhV95VQaibilApSVZJDjsk/13wbo+d
 Gf+Z4LVXSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=3qmJym1iAn6O77ZqEQIw
 Y9AKmsdOJb9J9PicYmbfKcw=; b=d9AN+3SmocC3rNHW2daOJDKkt0vf5DOePsjI
 YFzgHHnGAiBjhRY0jv3HcPEsFVCf2LB94h1yH6tHetolShIuywj28KWN4LHodidH
 8kmXHP/zxRMek5n5TJ32cSChUOqkO0/pLHnUGYm7DYekF0YUNWH3Qp6sign6J9SE
 tlBdmKbm07QxoMqdlpoRg5dqVwPJmDKiMe0qRy92hjZdtFpQnUGfht/OALpY7MWb
 0yu/v6KqnGF7KeIKlN0ARupWoDFhQzT+dSTAzgRV+iayr524YDJ1qg0nKeblLSgl
 Pk0sDs9OzGqssD9o6WIXyOkERSjqMHvJvLyD6mk43dBZW+SZfQ==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81tpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:36:07 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id So0zwgnqDEF2CSo10wGMo8; Fri, 29 May 2026 03:36:07 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So0zwgnqDEF2CSo10wGMo8
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 28 May 2026 20:36:05 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com
Subject: Re: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
Message-ID: <ahkJpZXnVVz5n26b@kraken>
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-3-dmukhin@ford.com>
 <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290032
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA1PR16MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 61599981-5f56-4686-0d04-08debd336c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099006|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 3YVlYsfxonDXtiM8CELhZdeuXwNAp5Od0n7+iPpO1NG/bpK/A5OcsflPyOELAYvWRhopCcBoyme8l/JpkPT+dbiWSFk49398rEME9yOI5fe8fNlJt5oi6fPzGiT97U5LwRkB8on0aObO9mNqmAa9aEIv0UdpRRymbyQTJgc50KmjnAxEsisn3L7O21z4wPhCx0bhAD2Msc4Dxa/xUUz19OrBX/JBxduC93owBzTKH3FbDzGHhsMh6q8KLbGd/SX7I/ebpWMmK44f5xpS8UZhqmN6/06eugGgMOhXFkpNjaXn+UzK1vnes8g+AGgrfsEJYLtjt+UEFt4MEC9y62EvQXPPuUJlpr4AjBsSktnHNr99XEgOjU0Xa5xhgBlJw2RO3YWf1GxF6u+RbmPW9y17wF6iF4HyGZMoV3hr3Jy4Dzck4qDROTAN0s/8f8wIK5SOzPKdyjUjyQKPdoTDgakmMA3FU26gi1+0TafUbq4KIKGb31uierqt6U9R4gcqzqfuCQPodt+Ze+hNW7OrzFI8f5F8nzvJgt5QksGu3kaknvyV8qIMM3317UaOiNnIAm677RIjKTUk+Z5u0z4DuoGobkli1zLq9tmgvEtaU7BAWH8xHIwTDET0+xX4m4gaN32Rngu/m62vIriamtHscMZqY5VFVGaGtb4kGy6o5iahYzLJIFvOHjy2cQFSMC2CHDKE
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AoKKq2rz4zkoYJufuq5QrUTRrpC3n2CXrN0m/izGGWl6+RiNOpG9/S1/TXVj/Pq/2WxJSJcQBxtaEyow3beJeAF4JRuFilUswQxRw0Hrj+F6ShMlLJANObGUeL9XlvJ4n++enkyMAWDp5RxpZSomzWVDRrTIp8sXBhsYb7VPvu2uMTsqCDTY6Leltz1EVuSc/843mIWdFzgdb0FOtlzKETcrJXkae8Y+VqhyrSFu+rSll+uqyxxDZrq9HfR2QFlTO3tM/8ujdn1ZFugGfHXl7IyaNqUpA1cRnUb3qQUWs9pJw+swj8nv+QwIPOKQqrr7e8/QUXGdJjcMFBybVebkOoCpOpFqSSNoMVS1PSWN/Mb5R+kgIPBVmG4dTeRxu4UNO6feAHSV4LWp8pz+fkuE4AigV4TM2ikI2JAtbTTZYo3+yTDGdEpJgQPh830S6HOu
X-Exchange-RoutingPolicyChecked: Yy4Axovnr/A1abVz5FlJol2cgDyIFlIgjbhzwbnVXkvpO7luqs/qi90PXdIX0QlUPhph9duBPi/6UkPLx1vTcRSACFF23viF5ARCawZeK1+GiO5c4mvf+2DUhF59s4y4R0UaiApdyA8ReWWx83H4wNVDEZVAXUQBeq6P+w5th2ksYeXqlu3qu1mwzTAw1CGB38fcu3sFX1k3l0FzIhgANQjYXS+tRlcomvr0nlNaFDERjehTzdpms2+VPF10gAUIs9UvvFqHqejy1TlevoZcd9d4GwK/7JkoXjDJ6DVx91vV73gyfmlSR5JcIGJsp2pw6CvLZpSRnl8Cq2oLLVz7Ew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LvDbqo7edTdic58dWTwM+Ygw9GaMadnGaIw6cCbzN0ijaeT+JlWlPmhtxJoI3UrDZsaV+ciPRyZDH5HB0MKjoyZA6XnJIcl/o7bqA8GNUR7sT1ZfyXvC+7kaXYKFn/tXbVOSYR7coMnOALqRqjiW7xE92unUoseT6sENhSpjSB4ZMmmNaxDFiLW+XAscnrU/H3e0Y3B/7qEXk39LsNjlkxCuMZas61CmgYF7lRwUvggxmTQbVJLXFq5AFUoI6bssv6XvQ0gIPr8PX4pRtcLLGn6aV+ak75R3dS27kQryvcSjeSHM9xmbQxmK5waOHYyf+ADdQoj5DRp3HEdcSvr1VORJIVyMRrozydy0bOs6On/X8uH3CFtM1T9RTIQM2hYI/r4Bv19NQQwWNKaxONk+Ze2T89ueZTSlJAZRo7IKzEd4CaB+pRMfGJbmLEIR7UyS/LMSdbIpZvec1s9yx07NPGQLAVPP85BGgAILMQK8P+R5mxCqd9mWu34CC4pgQtBhQp0z1lDpzkWQ7YM7m2hPOB3yXgyqefo6gU4DMpSkFnreOipCO6kWTB+BjP4PX5cqG1PFHC7B5xOOFu+HEQ4mcWJUu8vxV4ic7Wgn6lNqIFlezghrwKgWuGnJ4YThXoF4Y194KWl4TiWN5oGr2Pwiaw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:36:08.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61599981-5f56-4686-0d04-08debd336c60
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6337
X-Authority-Analysis: v=2.4 cv=coSrVV4i c=1 sm=1 tr=0 ts=6a1909ac cx=c_pps
 a=6APEVz27trGWNYyenu7PEA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=tGjWiSUo4SWkN6rYfr8A:9
 a=CjuIK1q_8ugA:10 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: nMNR4FQ67pyAfUWGJGWsKmcAxBn31Otq
X-Proofpoint-ORIG-GUID: nMNR4FQ67pyAfUWGJGWsKmcAxBn31Otq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMiBTYWx0ZWRfX1moizYcnyJ+P
 EBllyP1IgpEkEfGbPQkvIYFFKjHzoiP4N18NMNRl1DBQnvpG9FxTOSD70chCYs1RcPdsHk/Hqc7
 B5HBo0V6wQ49ZK1yYfCeqn5rwBe5SOzuqo9Bux6fP0RcXneZv09RNhNkKQ/deLDhyg1Wyyr9rul
 d4edIuXiSuQGAVvCbmrTHEN+N1wmO6fgOfooaEEMnYAwOmGE1h1hEmjUwrd9Vu4XpBtU9XJJh46
 RwQgA56toIAzF+TJYHCNadkeDszJZyVciMn4a+uHmay+oAc3p8wOpvHJNVXaBUzU9Eyct5lFysZ
 SBSztj44xMwiga+DYlBQKM57ZOlBwhoccRpFWpI0TSRYsuDORwZDWYQWwqKrjeOeiUhQJZ41+/v
 Luc6er9xZtN/aqQHxC1693i/eQy0vgqOM6/hoyvt1s0JAt9JbrgyEpcKbAV7n6zRwVkh6kTwYha
 07Wg2DG35Lsau1pmdag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290032
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

On Thu, May 28, 2026 at 11:28:33AM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 5/28/26 03:20, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Add flush command implementation along with a high-level
> > disk_blk_flush() API to be called at certain checkpoints
> > during the boot (e.g. updating custom bootflow flags stored
> > on NVMe).
> 
> First general comment, please split the patch by adding the
> flush infrastructure first and then the nvme support.

Will do, thanks.

> 
> The for NVMe, can it support write-through like SCSI FUA (Force Unit
> Access) which bypasses the cache on writes, with slower writes
> but safer and simpler than calling a flush before OS boot.

Yes, I've seen there was FUA patch [1], which was then reverted [2].

For our purposes, flush seems to be enough: the use case is
updating NVMe-backed boot counter from a custom bootflow.

[1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
[2] https://lore.kernel.org/u-boot/CAGi-RUL96GK5nfHx73UQQd_4sFByt3gNwqhFpHps+h58S20JwQ@mail.gmail.com/

[..]
> >   /**
> >    * blk_find_device() - Find a block device
> >    *
> > @@ -559,6 +577,16 @@ static inline ulong blk_derase(struct blk_desc *block_dev, lbaint_t start,
> >   	return block_dev->block_erase(block_dev, start, blkcnt);
> >   }
> > +static inline ulong blk_dflush(struct blk_desc *block_dev)
> > +{
> > +	blkcache_invalidate(block_dev->uclass_id, block_dev->devnum);
> 
> Call blkcache_invalidate only if flush cmd is supported

Ack.

> 
> > +
> > +	if (block_dev->block_flush)
> > +		return block_dev->block_flush(block_dev);
> > +
> > +	return 0;
> 
> Why do you return success here and not from blk_flush() when flush is not supported?

Will update.


Thanks,
Denis
