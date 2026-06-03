Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA078CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BFB8489D;
	Wed,  3 Jun 2026 09:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="hNUgVwHH";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="itC7xHun";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="gmvoCA7B";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="VlPCeMC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E9484855; Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B49884857
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6534tYF11586207
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=XXk
 ULVrvZFMbOQxtuKxCLQkkj/DMO2kbO0WICR19yLo=; b=hNUgVwHHJr0gTIpsDB8
 zzAzGv6ImaK8HqlyLg8+SSOmSe92TYTcADrLxdwyZ5E7vl54Z1FV7cvgucxioazh
 dKLLYFa9v2JxH8JW8Y0scbtgM10ahnSwdmxec49UrISkWfsVtZCWV0R6s2LRT5QI
 JPanRjJMgB/P98iXOKV9uOu/2UDL8ca981vNEEi696FSzOWJLwYFPS3RNPCpQxrG
 WjTBRoZRcTDVwWOx0AqvmKqYS0KYMcoT3I2sEw1GY121o+zO359sYiEK7TzUUXh7
 21tI4wK8rUeRGr4TEM6TJe9nVkwM5jvKNdb4BOWCYbwB6dD/bOHyB7WSI3bMb8hY
 0aA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ejdp0gpyv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:07:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Teo19lnJLN3AspXakAv2pCicpRqCPuBaCgoWL+RU2+hAgWHNibEtxe9E57spJgPfTa6aeuGRFLkqf3RqO1uVduHGlTDw67U9/zevfbXWykn23O8/ZmYIpkpIAB0dWfzhywljdKJeadbXNofpEuRx2tc/kJyk33kAjD/5C3aNcaZ1EMFjyiuJNqVuxGC/CFCiLUpd4BSIDku4hypuNANKNXWqw9lryVGJcHsnt/wdOEcjV8HpvDoqiciK8jCaDecZzrcQM/8uHSZGF9paCjH0o2wCcgm7V6fpdQw8V9vjJCRTVdrb4TR9EdlKAOc28sCuA/Ey+OpFzBum66gvZtnAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXkULVrvZFMbOQxtuKxCLQkkj/DMO2kbO0WICR19yLo=;
 b=r4Zrcf447Xong8sszxOUUxGA/6bumoJLgfWVC7NYQAGOHCFmRRWxJIBiQcGtbGOCLiVNn6PUx4BIRQTp1IW6/LJTpZ9CumIePi7ZsGBpe32r+TzNoCoEKMW1MiDi3qD31BkHrDa9VOaQiv5x4kEO1ioWM6cmb49AJfKZh7r0NUzpBxn0Flbxte7bzmYYG8ikext1ACiMbuUaUqgnsmIrZTXyrXErHaI7L7EnlSYN6A08tWm+drL/Sy31rIT+VZ8YWJ4KI2WFOdUT7ETxCI4W0YAMjtlXw8x1gV1Kxpx/Q0qcaxTH4W5bHhZzW3knei7JBlba7DjjuInjMuh5ucrbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXkULVrvZFMbOQxtuKxCLQkkj/DMO2kbO0WICR19yLo=;
 b=itC7xHunXdU7wn/rcinY2iEC/+ZJKnZlHm6LimtDTeTY1jXrw95K9RvZt56GAXISgepcBM9KGIe9bUENNAkh6DCyLN845y9H+Ufsajk+SsGmVj/vzMlmWz0H0CCjmiZNlfwTE39BDDXXc0X3gM4a1nKWwOQ2omHkMhRtskSx8E4=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by IA2PR16MB6373.namprd16.prod.outlook.com (2603:10b6:208:4a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:07:56 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::24) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:54 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65342uOX913785
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=XXkULVrvZFMbOQxtuKxCLQkkj/DMO2kbO0WICR19yLo=; b=
 gmvoCA7B5Srydw92FV70C/Nc4Pfy0T568iSPhrU46cUeFvWOQNDAEZYCmYx66QLW
 oKvk3f+EKhA4bsp0o+zzzCFBKy2/Yxaln5+13C8InsN6Ps2Az9yuQaibehQ3T+pd
 p/slFJy0+zCv8ltEzH/5zQjqlqC0LCwZshiMy2hm9WaxtAP2UyNeYGx5Uki8TFVS
 1TaUvdKEIbgeSTDc/nn3SlQSW1YHDAht3dWw6Ws7ucO0pScgLTcvPM5pyBa2dBbm
 +T+LdGX+tUCYBZMNSrSfKUOkAFnuHZPopv4/Se122k45kg/r+cHzrddqUb7KZ1bC
 4PQGXEca0+FhQMrp9DIH/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=XXkULVr
 vZFMbOQxtuKxCLQkkj/DMO2kbO0WICR19yLo=; b=VlPCeMC2qrxQtBZ50c31sCH
 IcrFeIa3De7j0BcdknpG+u6O8AAUSzySDmM8pH6WQCwKKL9BQoD077G3Xe71I0XC
 LMWAuiW2xD2Ysnd3Oa2PsjkOCIK1jm12fXoxJdPb6tFgHC9qftmsm6ncttgb+6Pw
 6zcNlTtKI9/fZZ+wNZbx7ZCKGCfeabCQvcWbtr0QFUMasjFO2MPP41moRmYKs9gs
 LoHNxPY+PrZpB1oEPGWBr5kzHWikTK792v/kZzMhHT9dAY0xcOxqI70vNbunDAdo
 L/6FvxOVh4i6ype6Gz30FiZeJL0DdRfMFQTMbgkZDrHZ4Pc6I8IhW5x8A+qAXrA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eggrxvnmh-7
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:53 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id Ufhgw4fMZ8Hc9Ufhgw4EKK; Wed, 03 Jun 2026 07:07:53 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: Ufhgw4fMZ8Hc9Ufhgw4EKK
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 3/7] reset: Print reset type on diagnostic console
Date: Wed,  3 Jun 2026 00:07:39 -0700
Message-ID: <20260603070743.1268544-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|IA2PR16MB6373:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d8510fe-89d6-41a2-52a5-08dec13ed527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Wdnt+F43jtmSv0i+JjhhU55l8PMC2Dn6uNwzdtc3WE1gpMVcS2wA2Q/+WrES1+uNOyfHn1ZZ5rkQNXMe3A0e7Vgy4DpFLtiL/kuNOoVnStuFJRQCpnRCSSjekxpcn1meeEP765jIq9FTnREaiE4Wf7MivU8rajlQIscui+ouNGNrGtmpue39BVjLPCGp8biWxj6IjCfS6p/sucRAIgR0uNowYQ96sOAsQc/PendyPDatBUrRF5f4yZ6y3pqxXgJYZg87NcmsEyHIngGmr9xt1DTaO8oIqbUqOJuALFVGS71MF7kcERorF6BilSwd+QMpMbamHsge2W7yWgfTpNiM1ouDokeSPuIQoYJj1qmOAa4cdZF4qS1LFGw/yUtOr2Zp6rmlMZSBFASTqnJkU/xq6wJvSzEaoZCQGeY3rqfT0o5fFWiZ13jFx6YfxDAxbhDee4AMN/8i/+UxCtiwOuUR3sZZ+clZ3Xi9B/yxB9pnDcEBlRCqvhSPsFz0KU+Sx4KZ2tsBXzrCPMWgf74ahdyInZbWftMhgLrgMB11UmLp6QXGIiyYysOoXBweokeGS1FRJTUXyKPbn5UHh4eGNWtR5+4Ujjwcb5Le4H/Q8PcdPx8EDfhO1ymSecCdrB4SEX43PIj9SodDDbtndyTOBk1i4IS/Rex+eBDVJtndvencXZPKZD/NhDlaWNptEEguMTsiU5xblP/RGF59yA+WpTv73qvKbiR4S/VJr03ivzPbz3Q=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4h+dss4Ag6JU0ZZNtSGBhy+MMEiCqlxoW8u4kCyRd6FVDcUkgvQRMcXqN7drSytjOslRGhVSKrp4+EPSrvS9WweII6ZJnxHH4id6rA6srrelrlgN6ZSj4gKZhL+vuBiHq86CPAYyGZHMh7tq1iKqtIDKqatH9XoP+jgzTMmT66n68DF9s5K4nzMc0PMU/2Ckrg/Rm4UlBFBWxUjMn6Dwf3LyicjEOy7WaGEr+pf7QTCP6NRma2ekJ67sx/VWiDkvoN+whpq7yNbCkmgMj8V9W03A6DssBXZGSjcgbj2LnDzPyA6akLJgM8O4ZgTIEPWwBcP2KCR0WKnS0JpvKA28CuTQOWChCoMK4ZEgpWZaSkcuZ2NSZV1y7gbp0bYDpAz1qEXbpepl5aY1EygFtSnCo5ujX0yQ0dshWmkNV6w6f7B6J+MWVBPlkbOqzBqpo4LU
X-Exchange-RoutingPolicyChecked: cJoGopOjx1V6Uy2OYRRrDUQUm7rymFLy412+XJBarJa7q64+IJXrF1Sad5dLemxAPx/kbLFy0oQ/FKKoy+UYndbEKDEsTOh6sbzOGVq23sZ8m3Sn5z7/g42EsKxGtZnLU6ngp5KPs+R4I/HVqot9xusU2/tOyJmYnIhf/S4lZvFVu9AssHqoyxqsckHX4BQJhP0X/pRpLz3P1txEdG0O5MnM30JM+eVIt4+S9W8WFCbFApS8ZHOOLmjTkXaLIh9BOVPKYiN700fQo/Cl8Zw5MifVJUbqpFkKTgwTsvbUCc01CxIniUGXg4wYus6OTMBALDlg7D8daGVQhUqxW2SW6Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sYVYdF+3EmIdIfSq23E1sA61FfKC+bDab8YQ4r42e5dbbexK3Mw+PnLBnXSXX9ZEQI5yFr5EFMWK1qxPhNNt7sZLqYmqhvGSwnKSFcyDGbKCsV9yMAnbXecoKDtURABFrecUICuM3371cDtsgwAvDQHjhaUCO3NP6fK88ClRXgloBgwXHFLNajc1Gut0dNIw92l7xGse/JVjsLahs4Dlp79e7x49/RGGk9LkX6rQstCcKMAMtIBfH+3wLHBVOMWQJ3Ol/t390KqU0FcVuZS1BnhUi1tJ7KI54JM+X/Ocbz8ZxuyQAJJ9QAGh+95Og5NehbrIosheZ8F0IdvC/YOdB/6g2qImcVdJqi2sc8/dBJfzpuspYIPxpSxSCtovf/+T4VOlbXOzgkRqypjaGv0zV/DdBEiNhwrtwCEjNEZgUwSE8zDb1pxlHWALP9YRGa7z4RHE8nJWDfUrD8ruYs7RzXwLrsrKN+gW3ICAH4gt8gko/OWxPJf28/G46yj+Rsp7rlJfVCb04Vno481DTDcTJ8x4Ea34jonZaKvhld+wPI5+A7d9HkGB/5lFCn51Pr28Ba4+4y8rM3etzWA06+G+NR8bGiKPH05FUqmAQ2Fcam77PHG6hyn8tvFJ98Z6F1uv
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:54.0355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8510fe-89d6-41a2-52a5-08dec13ed527
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR16MB6373
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX6qYu6btYsn7x
 vEPYejD4Cz4/VTH1r82XzaBXu4VIEymggaRlbK/5qWvmeoTwdLcnaVSBVuJrzD4ovMRn0SOGkKE
 dEUJQTJaFwqh0KqqNGg5pq+ONDfbOiU9YkmUVrg4Df16noFl2B2k1Jb1T0g1OG4eaX9gLi58YVO
 NuHn0fDbd5AuCHtUVLXohSXV+uXC7B++HoVUkzkopAQdRkoqV5oZb2J3op6OegxPh/DZJ2yCPXT
 dkPuppD8SreGJ3qCu1BB02guuLlw1N+qszL+eYkPyImtISkSV9TYJSEHK+wk1J/sBP9FpUTvtbJ
 0Uwcn+RiQhp/yGHX6wxpNOSPUJyIyuwE0DCdzL5rK4NGjt+qTtz32H97KKBPCvwbsigR9U5sO87
 +Q21nl1wYybH685iZYBn3c8a0iW5mn2SaSDIYgwDJJO2sgMOKiYx3FDCAXWKyZ7DpkSYHMGi/My
 XP+avNpp1q+OZxSFJqA==
X-Authority-Analysis: v=2.4 cv=XaO5Co55 c=1 sm=1 tr=0 ts=6a1fd2cf cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=cbNQJ9GKAAAA:8
 a=kC24NThZGE_8hhUEIyMA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: 7joAG8qX_N5mFSDaj3ozcl9EcW7H9ci6
X-Proofpoint-GUID: 7joAG8qX_N5mFSDaj3ozcl9EcW7H9ci6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066
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

Add a diagnostic console trace indicating the reset type.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- moved get_reset_type_str() next to do_reset()
---
 drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 1ba698b37285..2b7717857ce6 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
 	return SYSRESET_COLD;
 }
 
+static const char *get_reset_type_str(enum sysreset_t reset_type)
+{
+	switch (reset_type) {
+	case SYSRESET_WARM:
+		return "warm";
+	case SYSRESET_COLD:
+		return "cold";
+	case SYSRESET_POWER:
+		return "power";
+	case SYSRESET_POWER_OFF:
+		return "power off";
+	default:
+		return "unknown";
+	}
+}
+
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	enum sysreset_t reset_type = sysreset_get_default_type();
@@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
-	printf("resetting ...\n");
+	printf("resetting (%s)...\n", get_reset_type_str(reset_type));
 	mdelay(100);
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-- 
2.54.0

