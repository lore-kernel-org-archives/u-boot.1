Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E05C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A90A44058E;
	Mon, 10 Aug 2026 09:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2cwxb-5S-PhQ; Mon, 10 Aug 2026 09:57:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A43024057B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786355846;
	bh=1WbSAbuMBZUtUHdgA2UucYXRBMSNYOCgA1HR3q1OePo=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Td4hEFjHr8P9YbJ1BRwMM5B8xQyIlV/Mx6q/zZb3/ESILARBC05rznSBDgeHF4LkO
	 NK6j4TSxUZcR5TXyMs1H0Xi6AX+r+bjT3soWsioWe4eakYeSv2NLCug4Myu1jGd4/c
	 zFJqDBjf6QmUNMLtu/FGaBjXLSIBBOL3XdvcITPjMLnnyg+EYmSnsaG5yNlf7FkGIw
	 757ZKGENhrmq/K1KYGb2Ry5TDCbClNc2l357VNfVWLrAMDDyl3SRIcQme4C4fsev53
	 +fizO0x4EpQGB7Zm3YmPfZtxJ6LXxTdJH7npJZxTblPP4KuZd8D4LhO9+EoXFD0cAV
	 bFdH2bzetJgdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A43024057B;
	Mon, 10 Aug 2026 09:57:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DB43259
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F5E9605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ptfmtLejS4X for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:57:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1DF25605DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DF25605DF
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DF25605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:57:22 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67A9TXEE2467986;
 Mon, 10 Aug 2026 04:56:58 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fxnfndnpf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 04:56:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT1aRIk2ON3/LO7jJxh7iabDR6Ssovm87hAeMaKyophq0J7E/w9VOUJcnjHzg26b/R93Da5errit1cnu39FTSslsxRRQkqmQEXCJBbuGj3gwG/X77zvcTDuqPk0ujuRe8QsH4xNt6ewFtGrH3hhritgxDuBq55ZHJyKptwddYli5JtzUAqlqnqGG6CwX6kxA42d9pdiSyQ7J8B5G2s7LmFcMoeF15DLh/nNaZ5VyUBViEoPahPlXHB02aMzLKQl9YqC2xE8j5W6TlcRMgvL48WCcCvleiwsjkZhagO5KDh7sQC5DQEUqNHxVQi3ghetxXw4a1q8aipA7UvRmpJ//eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WbSAbuMBZUtUHdgA2UucYXRBMSNYOCgA1HR3q1OePo=;
 b=S6CkKJTKaGBHrNO7QzFIDjsMds5HNBJ2v3tLdoYdHISRphk5ZjrS8Pk1xKmmA/xq8pJi9SldnLZFEyQv30ipyYZOyVXJh+w5cLat1tRId/B7G/OQfmqXXz44brgsZnjzwC0Xn9kZfJLarTI1U/E5oFtSIrtHYjxrtkgW5HM93NUAPL0kese0+RFdkH2bFQEt4rL1jRE0u8Ap+B/wgEhyC/NbRLFqDYdve3BxjrOzwRxD/rkezanS9UynvEC9e6zudZ/vdPHcM3fXHX21q7TAS0QTIZv5aB5DAlvuoxqbKcqSCt1R0ifII32fIPLtnB7QMOwh+3U7SWxcK8oj1m5uPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by MW4PR10MB6299.namprd10.prod.outlook.com (2603:10b6:303:1e2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:56:54 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::91) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 09:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 09:56:54 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 04:56:53 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 04:56:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 10 Aug 2026 04:56:53 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67A9uqq42927520;
 Mon, 10 Aug 2026 04:56:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Aug 2026 15:26:52 +0530
Message-ID: <DKL6AAZWIDW6.QM05DJXDFOTN@ti.com>
CC: <u-boot@lists.denx.de>, <marex@denx.de>, <mkorpershoek@kernel.org>,
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>,
 <michal.simek@amd.com>, <alchark@flipper.net>,
 <jerome.forissier@arm.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 00/75] usb: dwc3: sync code with Linux v6.16
From: Anshul Dalal <anshuld@ti.com>
To: Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <178602223375.3156999.13542339251028864355.b4-review@b4>
 <anmKNYbNQ73Kv3iX@monster>
In-Reply-To: <anmKNYbNQ73Kv3iX@monster>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MW4PR10MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d17e00-e2f5-4db2-b369-08def6c5b54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|6133799003|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tmZBZcu8Kh0HEqyJ6uskMJPGQqII92O7Kdw8+o6p6fAT4SrC8vqm6dR+A/atxL8lbTqD7REzsJlxGj4hERYs5Tz1BLEmO6NLoXk5Ajq02gQc5iMHyTqHKxHjZgs9HJO1BH2ldCo/+PNXrpb3BSIpdjhtlOJE+IFwbB3ZapabhEaKnDY5sRxVSeGZ2dJxJtfwK0ONXRFNWY8ko2TzwFXpaggcMwPn+8BHJOCJUJVzKVk/Wespe+qGUdHnsLuQwmrn1rTm3d8mdyFjSIaMrCQCt5PZmeUCslwTw3zCVxmQqmAox1Dyn4HvqlKNarqqVF4Zr3TeO87tf9m4oUr5U2FDs2My1b3RuoN5q1ZziK5dcWTni3Tnc1szUjAQyczkXgE39SQWMrDat4Mt+NVCrU6YGq3TakaVix55m9Gzhsnr7HjtDhOfCgdwN6k+6jpX8cCPe2QHVFnz6+pSIpJGMiJ7Y6svQLi1sEqBagbgnZyhu2DMeHrUHWHwkqURoyDjtJQBCAWiT51gxb+PL+Rc6STxd/YhiJWkr0hYdUXvW67NPjAPFGtmoYrwUS6gvXCXJO36e1M/9IhYRPpsJgFuS/ChfDfBJ2iBNlb6U66rr2EvdLQ+WfAGqGUMrMSTIIvLzr+jXtY+xL3883LO+76IbNdWm9Yr3maQRJsCnPtbVgI95FuUiRuVjuuorLr4AKGLIwj+ymgeSZ4Y6YcnZEgl6amrvg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b38C6VVJmwzS/7dWhSCW04yzo+WPk9UkGAfAVy7x8hN5r2GlfgXUuaIydF7Pf3mWjLs7EZvvOMG7fVwvs8KzFTJfx8vttH68c4/rHz27WiJI0FZ44PXvWpP1AzkUkfLMxg5r+bYTAapOWdRMNk6HCOrFKCSLgEn1fmuYQpuZZ90eJozx+oLW0Jgz/UwVQyoGIj7rgbZXKVKv+BQz9exzsY13VsQ8ZQwDOBjAGr+2ePXdzgwuJ8YeA1f6bOQ730LleN1TeZGMNW4MB5FTDnAo4odsFB7AudX/83iFJvAmPCecCTIn2q2Sd03f5+Bumfi4RxvwzlR6izADprIYmcMNpVMnT7m5ku/4DZVYA90XMk3f783TSF7wz3v7S5PiwYjFjDMeq1ZiAqPA+N/TF1U/oh0CpsyxMbQwbl0upVlbEfyfbdvrDoqIpcLkUJsPFPkQ
X-Exchange-RoutingPolicyChecked: OOhP3cC30kzorLZUJcXoLkPaHomFBnWZoqdCsPvfRLWbkGF3n8ejo+dy2x21ZhH0ZFKJS0WXSYesdT3G6fd0lTWe8BB0tJTUq9LIWulPq9JkN7GaiaGtq0i0T2a8Z/YHjgXKqzfsp7I5KM6sbX6RzQ51+WUuDJQsZTc1GBqhNEUPyU9+UAlQpc3DAsdeUMJzGgZNsOjEAO9NVRokmAnGQ09t2v1G0+DOIdxYVrKi6VX6N2SIWGb8VztRcbFaD5zJL2I0ji2sPNGt6PAhQ1+t/qwpz1EimragY4PshMJMa2gnTdTWa1sofgWF+IGbEGad+d6+CZCtnC4R1yC4M9R+oQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:56:54.3078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d17e00-e2f5-4db2-b369-08def6c5b54f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6299
X-Proofpoint-GUID: aI_-BuN9cpJQpmTyiLaSqy7TbEYM1TsC
X-Authority-Analysis: v=2.4 cv=QeRWeMbv c=1 sm=1 tr=0 ts=6a79a06a cx=c_pps
 a=scPzG5pGSpQ412Sx4Fqw/g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=KKAkSRfTAAAA:8
 a=Fb664rkN7BrKK-oR4yYA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aI_-BuN9cpJQpmTyiLaSqy7TbEYM1TsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA4NiBTYWx0ZWRfX5c97DeAdZ7T+
 2JNyhBfI84j/hULqjVZtg7I026/AoTe3yBjKn1STHZKCMQ9or3G8HVfLOPLfi/5jenych9PCPJG
 1XbTezk17HZE9abTssIrDvRTyqYU/gwLDq1CB1fg8x5c1+r7qE//cxJKcTtkH/1oDE643wNX5c6
 k4cmDfWwUHJdDjniDxJ3op4wnwxk9PYLhl3cI2u7VFaM+lD+z1cIPpQK9rbAuOWyf3l1dz03rrg
 hU1CpPDCnL9Fy/3pebfVMkdq+GQLoeRDbmVwvhLFM8Qi+ca1GuHr0EyyJ8qwiM05FyI4AMV7rYz
 vB4vsWendGMoHzWvCibAT8lHpV4BWr4lw/eT315RilKYiC7VJRTCUIgeS/xJfD4K9nK9ZbkgJDC
 GAhJwMUhfy5I+akA68v5Kabj+8x6I0in/+DvEgLQva3VFGIMzsRVv02Ih6SfH/c1HqHed1UTjRD
 SykxN9LCrPYXwXGba7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA4NiBTYWx0ZWRfX3FIDWOvpG6ty
 oV83bICdy3pQGKopZDZ5jotrFO3nFMP3Lbw3LI0JqAFJNMsp6Mk2scQEUps/LnhFCXjcxSHp9PN
 LbM8vJNQxifGl3PhRj6Hv5umUFKr28I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100086
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=1WbSAbuMBZUtUHdgA2UucYXRBMSNYOCgA1HR3q1Oe
 Po=; b=RxNN7RaQ3KlKAjA2GbEkeFlg4HiMBaUXXVS7Y5n/D7OA93/nhTl2wHCII
 jKTPMyWXMrk391xHuvGz/yaSqIaeifNiT5hkFrzhVI8aYo/CBA2Iw/MonuthLlxk
 B68NP+iaCDcxdb0GA7d6e7jejUUBaRLq/SC86R6g7E6z/3s2PIGVxzAlSS/yNkLl
 oUU++wejyOpBz/Ll0Qbpmx+gLSECVrb01Fyq2DeO6libQZFUZl/h4vOT+uNZBU7c
 DhJrlFtUSf1vgq/mqhUKWG4mHjkvmnrF0R5ctEcCKZ38MaOaf1oZv7bh6mWfJejV
 A02mPMekD7chpm28JFd0ku4+TUMZg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WbSAbuMBZUtUHdgA2UucYXRBMSNYOCgA1HR3q1OePo=;
 b=RavS6ESTnEEPSUkF2AlBi0z+ffgt6EAWYbXME9HQRDunmfJ6dIMz1rqu28uTwKbS7KB1nEsSSnDY9iUmcWiosR6KdUhphzc5pGvuceiKC9YqXgs7X3NuINrd5dQMuIr2VkRs67FXfwg0EJa8peTY4A48AitbJMZr/9ciAqlZViE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RxNN7RaQ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RavS6EST
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

On Mon Aug 10, 2026 at 1:52 PM IST, Anders Roxell wrote:
> On 2026-08-06 18:47, Anshul Dalal wrote:
>> On Thu, 16 Jul 2026 15:41:30 +0200, Anders Roxell <anders.roxell@linaro.=
org> wrote:
>> > [...]
>> > This is compile-tested only.
>> >=20
>> > The series needs the dwc2 endpoint fixes from Mattijs [3]. They are
>> > already on the list and should go in first.
>> >=20
>> > The branch is also available at [4].
>>=20
>> Hi Andres,
>
> Hi Anshul,
>
> Thanks for testing on real hardware.
>
>>=20
>> I was unable to get DFU boot to work on TI devices with this patch serie=
s. I
>> tested on AM62p EVM where I don't see any error logs on the console but =
the
>> DFU device never shows up on the host side (verified with dfu-util and l=
susb).
>>=20
>> I'm not that familiar with dwc3 but the issue seems to be that dwc3_inte=
rrupt
>> doesn't report any interrupts.
>
>
> The event path is broken in three places. The main one: in the kernel
> dwc3_check_event_buf() copies the event ring into evt->cache and
> dwc3_process_event_buf() reads from evt->cache. We took the reader but no=
t
> the copy, so it walks a buffer nothing fills. Before the resync we read
> evt->buf directly, so it worked. I think this is what you are hitting, bu=
t
> you have the board.
>
> We also never write the count back to GEVNTCOUNT, and dwc3_thread_interru=
pt()
> gets the controller where it wants the event buffer.
>
> Fix below, it follows the kernel dwc3_invalidate_cache() is ours, it was =
in
> io.h before the resync and got lost.
>
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -48,4 +48,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, in=
t length)
>  	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>  }
>
> +static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
> +{
> +	uintptr_t start_addr =3D (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
> +	uintptr_t end_addr =3D ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
> +
> +	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_a=
ddr);
> +}
> +
>  #endif /* __DRIVERS_USB_DWC3_IO_H */
>
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4201,23 +4201,46 @@ static irqreturn_t dwc3_check_event_buf(struct dw=
c3 *dwc)
>  {
>  	struct dwc3_event_buffer *evt;
> +	u32 amount;
>  	u32 count;
> -	u32 reg;
>
>  	evt =3D dwc->ev_buf;
>
> +	if (evt->flags & DWC3_EVENT_PENDING)
> +		return IRQ_HANDLED;
> +
>  	count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>  	count &=3D DWC3_GEVNTCOUNT_MASK;
>  	if (!count)
>  		return IRQ_NONE;
>
> +	if (count > evt->length) {
> +		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
> +			count, evt->length);
> +		return IRQ_NONE;
> +	}
> +
>  	evt->count =3D count;
>  	evt->flags |=3D DWC3_EVENT_PENDING;
>
>  	/* Mask interrupt */
> -	reg =3D dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
> -	reg |=3D DWC3_GEVNTSIZ_INTMASK;
> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
> +	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
> +		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
> +
> +	/* The controller filled the buffer over DMA, drop our stale lines */
> +	dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
> +
> +	amount =3D min(count, evt->length - evt->lpos);
> +	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
> +
> +	if (amount < count)
> +		memcpy(evt->cache, evt->buf, count - amount);
> +
> +	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>
>  	return IRQ_WAKE_THREAD;
>  }
>
> And in dwc3_gadget_uboot_handle_interrupt(), same file:
>
> -		struct dwc3_event_buffer *evt;
> -		dwc3_thread_interrupt(0, dwc);
> +		struct dwc3_event_buffer *evt =3D dwc->ev_buf;
> +		dwc3_thread_interrupt(0, evt);

Thanks for the pointers Anders but I encounter a similar failure even
with the diff you suggested. I enabled some logging for the SPL by
defining the DEBUG macro in the following files (dfu.c spl.c spl_ram.c
dwc3-am62.c composite.c g_dnl.c).

Failure logs:

	U-Boot SPL 2026.07-00860-g5a9b7a715be2 (Aug 10 2026 - 15:06:27 +0530)
	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
	SPL initial stack usage: 17104 bytes
	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
	>>SPL: board_init_r()
	spl_init
	Trying to boot from DFU
	g_dnl_register: g_dnl_driver.name =3D usb_dnl_dfu
	g_dnl_bind: gadget: 0x81c44a98 cdev: 0x81c66bc0
	usb_add_config: adding config #1 'usb_dnload'/81c67cc0
	g_dnl_do_config: configuration: 0x81c67cc0 composite dev: 0x81c66bc0
	adding 'dfu'/81c67d34 to config 'usb_dnload'/81c67cc0
	cfg 1/81c67cc0 speeds: high full
	usb_add_config: interface 0 =3D dfu/81c67d34
	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
	usb_dnl_dfu: ready

<CTRL-C> from user

	unbind function 'dfu'/81c67d34
	g_dnl_unbind: calling usb_gadget_disconnect for controller 'dwc3-gadget'
	Legacy image
	u_boot_pos =3D ffffffff
	Raw boot image support not enabled, proceeding to other boot methods
	Error: -22
	SPL: Unsupported Boot Device!
	SPL: failed to boot from all boot devices
	### ERROR ### Please RESET the board ###

Succes logs (same debug symbols ontop of main branch):

	U-Boot SPL 2026.10-rc1-00209-g0bdd5e5daf95 (Aug 10 2026 - 14:58:28 +0530)
	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
	SPL initial stack usage: 17104 bytes
	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
	>>SPL: board_init_r()
	spl_init
	Trying to boot from DFU
	g_dnl_register: g_dnl_driver.name =3D usb_dnl_dfu
	g_dnl_bind: gadget: 0x81c44aa4 cdev: 0x81c4af40
	usb_add_config: adding config #1 'usb_dnload'/81c4c040
	g_dnl_do_config: configuration: 0x81c4c040 composite dev: 0x81c4af40
	adding 'dfu'/81c4c0b4 to config 'usb_dnload'/81c4c040
	cfg 1/81c4c040 speeds: high full
	usb_add_config: interface 0 =3D dfu/81c4c0b4
	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
	usb_dnl_dfu: ready
	composite_suspend: suspend
	set_config: high speed config #1: usb_dnload
	non-core control reqa1.03 v0000 i0000 l6
	non-core control req21.01 v0000 i0000 l4096
...(repeated)
	#non-core control reqa1.03 v0000 i0000 l6
	non-core control reqa1.03 v0000 i0000 l6
	DOWNLOAD ... OK
	Ctrl+C to exit ...

I'm not that familiar with the DW3 driver, let me know if you need me to
test with any further changes.

>
> evt was used there without being set as well.
>
> All of this is in v6 that I plan to send out. I have no AM62p and it is
> only compile tested, so please try it on your board so we know if it
> solves your issue before I send out v6.

I was able to reproduce the issue on beagleplay since it uses the same
DWC3. You can try it locally if you have that board with you by
resetting to DFU mode from U-Boot prompt:

=3D> mw.w 43000030 53; res

Regards,
Anshul

