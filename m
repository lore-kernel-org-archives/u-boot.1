Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B19C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDB8E60A7B;
	Fri,  7 Aug 2026 14:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3sQgxXww-GD; Fri,  7 Aug 2026 14:24:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E61260A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112640;
	bh=112sMoaWMKmpIs7ViusCF7JjpzTBUZXWVeN8ip3tO6Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dw38OG3lFypN0W84MKtwZhuXAeKfCKwk0W455YaonwymdJ+MU7mVGMb1sgcnu1Ubf
	 hdu65IahK/0vmZaBLXEZRFjT0QaYILGNRmit0Pz4OI8bFEfL1746Vqj1/gVjrLiu5H
	 fhpJsUU0b3KMV/W7TwzObvEA5TPWebRack5DCeRVQ/C5dEQmUR8UT7LnGL60bHHk+4
	 OP62tChzIovFqZV0ZPZYqL1OqvNQnxSbIXQOhPUOLLmmYZIwlKLDzUZmApp6KEQn/x
	 OrmrFlO+y/VbdXgKhHraXSKNwKVNl1IiJQmRPRzTH/hmO6SDew82MAcTlnfbMiGXaR
	 i91CjXZfaZlEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E61260A74;
	Fri,  7 Aug 2026 14:24:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA6102F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7B5C40A67
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBj3biPWU8h9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:23:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 83C7C40A5D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83C7C40A5D
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83C7C40A5D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:23:58 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CeXOC3176709; Fri, 7 Aug 2026 09:23:57 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fweqbrw9u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 09:23:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S22Eq1KfDuxgJea2Cb24TsnbUnhPOAbzi9Kv5Yh7U3Ra9K3rXBDsGxxsDtzamYkyVSYe4jkiZSZqmXjwbL5V6OZEAQ1ig6mT5Qg24hBRWdwq7kAkx3j04zLMdsEpC/1cteVLKkc+HJOg/KI6slGouI5hAuob/tcvmfg3WWFrV6aZ1qCaUgyNWLR6ZxR1Vyqp/04kWJ5Ah6pbKfcIYPDxjX1AiwLbEEEqcXWZnOygWQD6dGeML+alGvZYfPPy/YKqb6PAC19/cM3U7cAY4+r2uL2Y+e4Ie2/oC5AnlJK1YMMkBjX1YjspeJ9naoKHn3lK4RhfxDJznFaGbN8uUlTofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=112sMoaWMKmpIs7ViusCF7JjpzTBUZXWVeN8ip3tO6Q=;
 b=ctWUPG0OsHjP7nmFoFyrbzX6/gYbLB/1A+yZiZhndMclYWTLFFHDRaCBdt4KuEZPrZbfwA3EYyrU08HBqGHcUCz9e3gH6vhoLXKFI8baD4cHfV2GKE0LhzHcFtXGR+xqhJwI7pOHpuu0XbXhiL0dpB3P6jOLBG4+gD7Sg7dgoiFD062kXFnFIDw/7aFH/FAahRnYbj46IaByYh51Gkr+sDEyzeNrbKE29X5Cgs8mnHeomZxDELeFBlRRRLwu+St0w3aLx+NKcVXsgC7fxL0/IJ4Uey4hS/SWo4qmfPJwLchoWZm5KZMQ/ydZhG9mRsPuGaatl58SABCchHFj0ym5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:23:52 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::3b) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 14:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 14:23:51 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 09:23:51 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 09:23:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 7 Aug 2026 09:23:51 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 677ENpfo1208750;
 Fri, 7 Aug 2026 09:23:51 -0500
Date: Fri, 7 Aug 2026 09:23:51 -0500
From: Bryan Brattlof <bb@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v4 06/11] board: ti: am62lx: add initial board files
Message-ID: <20260807142351.s27pj6ypv3pepdsn@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-6-01746157643d@ti.com>
 <CAFLszTh9foQEBVa3BfNHpZ9-2Fr4BGNGCH+oYyLz4yCGr6SkhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFLszTh9foQEBVa3BfNHpZ9-2Fr4BGNGCH+oYyLz4yCGr6SkhA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: c276fb52-fc14-45bc-73fd-08def48f8123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: DIyVh6Rim9PnyDqjdq2Vsjit6BxkDnRbFt+HsvaWuj3xn4b9svwE9Ts/2yJ30PrSac2fyrCHfPa4/+hiccMezmT5WDyIY0JzTGRSreBmy3ZEaY6TBtKRSYSFdqT5kuvYHbzAXHisKLdVTUFjltqnlpprepSJT0VELy61I+ThhseaYu6vTShPUCLE80AYZdHXmxhi6NuLeGkGAOcLfcogIeWrNDYvHILuSCymtoNHw0i+wJreR/lACJzEsUxn4yMSsrXqvgrjfaOsJ/at87YO9G4B+GlhWm3B9oDmQGQQVdhjUwUuu/aYQEfpmb1Jk2yHEJhfpufGu6evi/YrBwLsjUxogjRIBehsUl8tDWEnaa1mt0EP6ECWDS9UeiYqyRPRrta47lcqSWSlqAg+pB5dRK6VeOTQhiPPvZiuedF0kJpAUmkE6wO4LyrE3lY5aZEcatDhAdN4qGr48ToLuKJsXadfyZbBeBPRI1rl15W+ab/H612g0WCDvI8Gtam/pnU0Tl8DtVPa/7goNyYSUeTJz/h+34onmlJNbjYC45p3uFkHff7gtk5hIe41XdTyZQQmlE68BIQ5QzY2u381zzYKgD0QRio1NEIpGr6IEIWKEnGl5P1IeNNE4dSTUqwFk9zOWpQ5SNEAE2uhMqKZgH4uoA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZfA/TtKDWa5HYzokvMc1GJilTvNdXu9yeSpi3ZGmk9bXjhf08TH6eXSCpTAePabgkQLarTAwJfpdFHMVzBjY50KynTUo3y0aG5/n6CQ81ZVoJfjHEHl6g5Nc6RxS/t7gUcMcDEVAw7ZJkVaEPtDoUmHsnRGNaWVG/RcgUp1SFLOJYM87Rbr1oQrQNTfmNPT2FaGiAyBPCpK9U0+CxZ5S0UxZ7ueC3KxroUavl1FUbJgOd37pfFup4+cY5Jm6DwVdtu7K72SrlM3+bKgQxN0e5aQOJVm/qgdr7FdAayukzvp1R3bHdLVxKnW7RZtT68PlgD+cuNXVFCy8yF9BmTnujXYcNZaKDSRBeHOXF+nyUkOyT93DPcYJovXVIeqB5QmzwZqzUdJxcAZgzbkoCo2I6EXdpKtMOtGco87TsMyCWo55fMyHWIIIW6w3QbtufYu
X-Exchange-RoutingPolicyChecked: sLrqryVNCzcH42tQMuMTWfFAfGTwzTVFbayuPFUP19C6p+5istGAs8usau+7Wk5X/RB/R150B1Q0WbXx/owSf5ptioZbMmx1c01g1GLBCmdWHxbdvwh5NgowpnDVMFiPfOJy8imvhwpH+QKfck/Mib8uJ3SX4L7/rVUZKV0VMMEc/3TZsxdjtMWrX/Qa2VXxD6/OP2vDntwFuerL6epRSr8qkCWSpFELCcp6/Bh99LV9guA6b/p1HDoO/ASqdyXZezPCarykFAxyRkhjcr1ez8J8gBR/+jzA70qUsTS9KVfNGkpA5iJp+fE5/Yc+05ZNSQcu9ycmsKywSRcIGKuK5g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:23:51.5959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c276fb52-fc14-45bc-73fd-08def48f8123
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX/gU18T2SlV3A
 GVHody10Cabrj7+O3AjsgKv4SBWlKsjFmz4lZgIVDOY+Z43vJstUvu6JgPEvBmU2TDhRyKVXHuB
 G8VcG38RhCZBVCzx+O6YzrzRGGSrX5w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX7C3EO9ZczQ2w
 TZGHTDezBeZl/5tOUQIj8XoOvzEOb5NI2div6aCSQoP5Si41Up6C4diEGe85FVratgLdo+Fnwah
 0kCi5yvwb0ZGvB36Efvaj93DD2Jl58xeWPUVQnEK7OVG2dqsmHeOiQDoL7roXn5PXfCxIU9NJn2
 nMY78C6BQrVTGhAfaAgYC5m11Udl15CcihL3zPeXE8L/RWd5j53W9nzpVm1X6KA1sQn2pv6o7s5
 YjyRlFm+aIpEcOo/E1LypCtWnqnu3rAXYu3c8PurafieTMuNRcCg0kchZUs6t3kXjzqbn9HFCTE
 4VikjtZpKtWT5NDs5yvBKJdZ/Q7ZdR5oWzDYOnl9EjInUl8jhxipHg5pSF8dG5SWPPVj8pc7gLQ
 qzy6m6w4rt+MHP/wd4L0o1YhUjICOsNK16euUBnTWoOzylS3x3HCntV0qqC6oEnQg7QDHpWRJyH
 BU8n27MkWCc+zc/fJDA==
X-Authority-Analysis: v=2.4 cv=bMYm5v+Z c=1 sm=1 tr=0 ts=6a75ea7c cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=j5KMXuuWxY1_rSJLq_YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oxrY8iiCIveT0s4IzqWBigHvuHXfzK1a
X-Proofpoint-ORIG-GUID: oxrY8iiCIveT0s4IzqWBigHvuHXfzK1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=112sMoaWMKmpIs7
 ViusCF7JjpzTBUZXWVeN8ip3tO6Q=; b=caAbYwrQqisjKrx1ApofQAX1Txu0LwX
 vZqd8aaM0PyRmqEVVVyf5weWb/XBajMSUPbi37eKeSqJg64c3HDA2FxUP8iwro+5
 g09ugjQ0xM9rG3HAy6+dm5Ed7Cw4DMkbYRZfPxTLf/N1wxf/NWbJ2TKCaVyBIxgl
 9b/er0oLr7keKKcf8zAZeFJobfWJmr6+u8p///AShJwcqXdl+eeZPwNVMnG7oPI/
 MlWscVzWnsMoDPDuvE91f7rBebkqfFdxPZpQczpq7jiB0aBlxP2zT9t1GMQloGBS
 gr6u3lERKAHmBLsgle5n0FWtsOfyEWFOr1ETXSYPSzXZcGm0De/BL6w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=112sMoaWMKmpIs7ViusCF7JjpzTBUZXWVeN8ip3tO6Q=;
 b=bf8xWAB/SMug+oC4FB0IKN1yUceF1JGa2cRU1cO0vg4I81EP3/kn1C4l5O8Pbkv8RwoqKGUtq3idQ49ukN9x+rmjhsgBdjZB2H/JCFFaICJ4Kb68bD/QEEAPD+aaq4vdApJigDH5CcIE5SnBqkv93C/p1Wxkh45fPnR5IOuWP68=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=caAbYwrQ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=bf8xWAB/
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On August  6, 2026 thus sayeth Simon Glass:
> Hi Bryan,
> 
> On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > board: ti: am62lx: add initial board files
> >
> > Add the initial board files to support the AM62L3-SK reference boards
> > for basic boot via SD and MMC
> 
> The other patches in this series (defconfig target AM62L3_EVM,
> MAINTAINERS entry 'AM62Lx BOARD', docs am62lx_evm.rst, yaml files
> describing AM62L-EVM) all refer to the EVM, not an SK. Please fix the
> commit message so the board name matches - and also add a full stop
> and drop the mention of 'SD and MMC' (or spell out 'SD and eMMC' if
> that is what you mean).

Sure.

> 
> >
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >
> > board/ti/am62lx/Kconfig        |  19 +++
> >  board/ti/am62lx/MAINTAINERS    |   8 +
> >  board/ti/am62lx/Makefile       |   7 +
> >  board/ti/am62lx/am62lx.env     |   8 +
> >  board/ti/am62lx/board-cfg.yaml |  32 ++++
> >  board/ti/am62lx/evm.c          |  19 +++
> >  board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 473 insertions(+)
> 
> > diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
> > new file mode 100644
> > index 00000000000..cafafb8ede8
> > --- /dev/null
> > +++ b/board/ti/am62lx/evm.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Board specific initialization for AM62Lx platforms
> > + *
> > + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> > + *
> > + */
> > +
> > +#include <asm/arch/hardware.h>
> > +#include <asm/io.h>
> > +#include <dm/uclass.h>
> > +#include <env.h>
> > +#include <fdt_support.h>
> > +#include <spl.h>
> > +
> > +int board_init(void)
> > +{
> > +     return 0;
> > +}
> 
> None of these includes are used by an empty board_init(). Please drop
> them and only add each one when the code that needs it lands. Also,
> none of the other K3 boards (am62x, am62px, am62ax, am64x, j721e, ...)
> provide a board_init() stub at all, so I suspect the whole function
> can go away - leaving evm.c effectively empty. If that is the case,
> you might as well not add evm.c and the Makefile entry until there is
> something real to put in it.
>

Sure.

> > diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
> > new file mode 100644
> > index 00000000000..0dd86db400e
> > --- /dev/null
> > +++ b/board/ti/am62lx/am62lx.env
> > @@ -0,0 +1,8 @@
> > +kernel_addr_r=0x82000000
> > +fdt_addr_r=0x88000000
> > +fdtoverlay_addr_r=0x89000000
> > +ramdisk_addr_r=0x88080000
> > +pxefile_addr_r=0x80100000
> > +
> > +dfu_alt_info_ram=
> > +     u-boot.img ram 0x83000000 0x400000
> 
> Just to check - the other am62* boards pull in env/ti/ti_common.env,
> env/ti/mmc.env, env/ti/k3_dfu.env and set
> console/boot_targets/mmcdev/etc. but it looks like this board is
> relying on standard boot defaults? That's fine if so.

Much of what is in the environment for older K3 SoCs will not work or 
would need to be overridden for AM62L based boards. Relying on standard 
boot defaults and letting downstream forks modify the environment 
however they wish seems appropriate here.

> 
> > diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
> > new file mode 100644
> > index 00000000000..abb3174d4bc
> > --- /dev/null
> > +++ b/board/ti/am62lx/board-cfg.yaml
> > @@ -0,0 +1,32 @@
> > +  bm_writer_cfg:
> > +    subhdr:
> > +      magic: 0x7D8A
> > +      size: 5
> > +    allowed_host: 10
> > +
> > +  reserved: [0, 0, 0, 0, 0, 0, 0]
> 
> A one-line comment pointing at where bm_writer_cfg and the reserved
> block are documented in the TRM (or the tifs firmware header) would
> help here. Same for the magic values in sec-cfg.yaml

I don't know the specific version this was introduced but these 
structures are all documented in the TISCI specification along with 
everything else K3 uses.

      https://software-dl.ti.com/tisci/esd/latest/3_boardcfg/BOARDCFG.html
      https://software-dl.ti.com/tisci/esd/latest/3_boardcfg/BOARDCFG_SEC.html

Are you suggesting I add these notes to the syntax.yaml or do you want 
them in these auto generated files?

~Bryan
