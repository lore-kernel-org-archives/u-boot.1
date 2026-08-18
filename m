Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC82C5DF84
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5614080FD7;
	Tue, 18 Aug 2026 13:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82c2m5aY1YtD; Tue, 18 Aug 2026 13:06:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6988E810AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058389;
	bh=ZAm+4+SFAMHW9s5fI1nK37Wn2E45zdBClLE4TJk7mig=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpUgUm190S4hIL3HBxPZQwATNjItjgtScVDyhLB4//DySiupT/FW4IxpGEPxo2wIB
	 p/8UvUgTU6O18bY2jyd9LGuTC9hXrXPZJkLoRVvbwWD4WGBESdBCizzpFEsEFD6qTL
	 aAZ1adILZJaQuIAD215GhV5SIyfbUD8+kFIMvF67/VHJuQdIEUyc+/qNzw6MHRbNGl
	 DKbdA/YK7rY3KntfoCk/amGsWN0TlyNIUmnDmZl/RumqMO3lUGvTZA1NcHRSiALqBL
	 LX89IV4CZV6WpI7GWMPG6xyKlvbstybN02WqfQZuet1h2HlSn95b0RitRHaFECCBMH
	 bTrAxQlpEnyBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6988E810AC;
	Tue, 18 Aug 2026 13:06:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE189237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A39E840750
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id belgH7u4tF8Z for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:54:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7CA3F4070A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CA3F4070A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=jail5SZi; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=v9ko6T4R
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CA3F4070A
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:54:23 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67IA63V33442579;
 Tue, 18 Aug 2026 06:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ZAm+4+SFAMHW9s5fI1nK37Wn2E45zdBClLE4TJk7m
 ig=; b=jail5SZiglMdO7YuBJ1N3OQO12PlgB8PscWv/uwwaLMDz/gvivrWl64E0
 Orz2Ojq8VouQ6Z6E9oBQJyiOPwcs6c4h8iH0qs5T8rHykoJmyAq8J+/Kw04cQ40h
 jQoLAF3PEFicEUrqjUcLXlOAHbpxbxNzQ3Se5jgfgWLfDXSmzbmmM5bxqUw9ZRG7
 L68NqDetNdMWyxCvYByLdQNGyYFhv4iGG/JAB0GmN04xopvJ9aKzCR+ygMM1lS0S
 XTcI55i6q52hwGf2PrTwrSp4jDlg9kK7cx9ZZtWpPOSpQ/sCOmS1Bn2Yyhefr4ld
 EDJAmp825mJLgaPROeL1ejxSgOeGQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g4fbvta23-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:54:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af0WfkyHP61yrbewhxn5Yw5Qby+tvxMorTFUdCCsgQAivdlTVhTnR/IPU451go+fkAsTEjT4XgkD1g68OsBRFgvsdCb8dJg67Mwc6toS73Hq7LztW0T0yJX0fDW2Y96FYypg678VTC6m3Wj9P0DVzQa6YRcuvt6urnUn5tG94D+kjk3MsFbzsq1R/A6gFlkOPHd7lw8ZwfcctVpMnj7jAEe9+6JTpejD682dD0depyqFWyBqsIOzN1Cig+nJarTcoOuRxfuCp5fe6yMadND9PYLYo5/S5Tc/EqcwXmLLdyBFDm5Ay8gjep4bfAfqxqY+cMuraHYFy50lP4tsAKP13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAm+4+SFAMHW9s5fI1nK37Wn2E45zdBClLE4TJk7mig=;
 b=kU+etIW2/Gr31qZiKHtQmPU32nZfPycjkxLJtLfPGQVygBdGXiQ+QK4KrRO4jiZKQssSuTE+7SuMSncuE21wsU1MOl07pBdlkbNVyfRtIoCrsdOMxf23XxqPj95o6NA3n4+/pRENYnXkpRQKPzeAboRdMewyGTB8c2OliaKKC0821Tx86LQblBXxcZ+3vpUmVwgtVEJScXkXR4P9f6HrDDkgeFtKQPLKzXUsPBYKN4QRkCxEkD5QvyfrvsniRclJ6jLNHT1JEc80xBxNjF3h/Vl5Y7hRupPprPWswD3oRFWbFNNet6b6PnByaoDIdJAlizKzAiCISnkBH5IfyRe/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAm+4+SFAMHW9s5fI1nK37Wn2E45zdBClLE4TJk7mig=;
 b=v9ko6T4RyMsZ8n3wJyXGEdrWtLnjaec1JIF34IUWZ0Vq90SJybFSxQybZvjiL2CPR5Q0IdhDz906SDMKs53TNg0i+e7Jz8giIu2TukQ9LhPShs+Vhh8gUx/Qk1aDwjkHnj6KtCZS9+5xwp4fSe4hquACyyM/YFqqTJR0zQLXC8Y=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 11:54:15 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::10) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 11:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 11:54:13 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:54:01 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:54:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 06:54:01 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IBrY3S1372974;
 Tue, 18 Aug 2026 06:54:00 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 3/3] doc: ti: document no-SPL boot mode for J784S4 EVM
Date: Tue, 18 Aug 2026 17:23:22 +0530
Message-ID: <20260818115322.101705-4-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818115322.101705-1-g-praveen@ti.com>
References: <20260818115322.101705-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1ce03d-a548-4d0c-ee52-08defd1f6c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Omcg77EESzOH2qeujfD4G3tTG+tcvcFHfVZkA+w0J2X49bLCh9jG58VkPUWKZYZN/P7wd2leEX/nyJ5rTY1Oqlyj1x8uBI2CgURjQsvKdFTLhat/nDkWwezYQZ0cieQIJgrdK9DdRVeq4wC0VaEJY1Ak9stc0LZnQQoqL0n0Kmg7r7TRrezE5sf6sMM24eIkwNjhJ6WR97xg796cAeaEXWwMRHOKKwwFjFLy7rCZ1FG6WuL3xtiMMjq0PkjKeRxOuk0aDNLLtFgphdMcucQyj5yWdVUwLRDP05j9z4/mTZ+9L1P4aaQObUAlSFJ9yymZATYI99kjL+AP47xSi1oxaPVYQdGp9a7KvEj4spPGPVc5Qr8Hb5V3jDgYysuZqCPFIAt910feM5brekDTBTFcVyrtEtPLWiedXWVK0hOgGwJne0FNOrjYdx4VHbUGBjmINl46mm0zY11SmZAiK2roVgDF60hERjgHe96XOS8OduONnjLw8IZhsPGz2O1Zy3AcW8pshY2t8OoYxJXVCWNB/cPzN14rAxue39dzHLe0/AkaNfZybBJfJ4ODRXIsPpCDfQZrHHavIs35piLbwAPZoZpa9hUtXb/qoG+aVMzYhU9CZ2G/ZnrXSfKCfxMmKbEU44iQir3ozJchS8WryMcEwsJLiSvfyPaIeB50AP/gqIuNYI6PWgA/S0gld+g5xkHRCtsOMDvQuaM0RwkxUnvAA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N8tNstAUc2nwvqMrExPLvcWFb75Xjoov56yYdbjqm8OXwXPJq+yDlrzX1xvXLTEX1eoXjbTqNho6f5/b7tQ4yQZqOTqF3T3herT5NvHPCvXxgHiByd3qL2T7U1kjWA/bynew6u4cHHjidbutnIdhmcYMoNQRVJtzemOzRsZ9Q1iFuGMr8e+OVmZmDedH6U6ZUxMFrkVcPyzC1dPND77qV3tlSrbmR9TB9B9zp2GmDBa2KHZHaL+877PnycMZh2VySA3obM4aKfgTWDMOXTELWyDLUxfuPruNzbbQEZmX2A5ubYOMg6SN9unKNSLdP+4tlo6H/Ny4chRUUNvcJkmLl4PF8bok/FXhAIVc2Idxv+9aH93+UjD43JNnGwJqv9veBd4kJCwJpdWOKUudIiowReoK21+ddCPOXYDkdt6jdTrFsDUmxbj/YRe9NjcIcZJl
X-Exchange-RoutingPolicyChecked: Hxwlv3IQN3ZdxIBynR2JNlfLJl3uCfxjYti87vteFkANfZyBNvmHWnBQvL9HQvbz/4qxxcib3iBsksA656ex2+XDGiMSY0sKsse0d/bvQMYmLJzNBRepZTmXcUnpD1rvrZObmTt3VK8GimD/p5rAR0GwWZXlcasv6y06VG/8ilTkCTpCnQ2S9ELf7Nom6qqCU3G/li7t8fIwGSiBeDtdM2YZRfbD+g5ndlbOERtXnqWRWmZLjMuTX9ioKasrcVqwfm7n6Y90MYA4raiE9YLRvvEweHYM5q+rEQrIKC2TC1jL1lFSCyJlKaA+Hklgf36+XUMzuwUNb+O46pVmTmBkZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:54:13.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1ce03d-a548-4d0c-ee52-08defd1f6c8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX62IyLZPtNV86
 URQV3lRlX1MtispigjCkEjE7RgXfXeregfL3AfYwwik8zE+dHa6EfZMSUnBB7Jh4xHngo2b+cWE
 7PfzO4FKO0+bw/Bu9hw+ffsglOZKdHU=
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=6a8447ed cx=c_pps
 a=ojhc/3A0J58/V7uwnPnIuw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=tlSJXLxGV86A4UsorCoA:9
X-Proofpoint-GUID: QeyKwAe22-zg9Bg9XY4g4CPDXo8VdUBQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX7InY/ld6o2FW
 /FArPL/W2SKKd1bXoG8MNR4BkJWqA6cLzpZTkyhs+ub6PlW1bHKpAKx4GUrq/baJVnatGJKcC6R
 bCY9PQWDfxWX9VJU4RhkefuIzuf4k+DZ1ATtss5vnVvSgzfQzBrOkBUbRgxmY/Ge50cIzQfWarD
 Ax2XweBYCMKFxutML1kPF0bBH2VugvY2uRQUcW0qMSlnc5daTd3uWNvKetOSOP7CB6e9QZ5nJDT
 /gWmKkt8aCIgmXcYRIlpbBKqskRFwykGHjaOXFCc/NwtpxotfWTmaI2bDc5O0MWMxFl17+F+Fnx
 w+aYqO85/kFfYz1Z3/H9jGaRC0eeQGPhMyf2GhXZdHSVCmAHZetKAcepd/DGBGRkLPCHrNYezbA
 iAEJ6u6NQ0LoRPYHt+hC4x4v90V/oyMHRmRKHvkFVSt8ztCPmZpiQWOwdU8avf4IdSkUUcdm1/X
 zmeCDXQDgSOg4wafD1A==
X-Proofpoint-ORIG-GUID: QeyKwAe22-zg9Bg9XY4g4CPDXo8VdUBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

This patch adds user documentation for the no-SPL boot mode on J784S4
EVM, where R5 SPL directly loads U-Boot proper, bypassing the A Core
SPL stage.

The documentation covers the boot flow, build steps, and usage
instructions for this boot mode using tinospl.bin.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab90..bba0c13985e 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,149 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+No-SPL Boot Mode
+----------------
+
+No-SPL Boot Mode on J784S4 platforms is a boot approach that bypasses
+the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
+boot times compared to normal boot while maintaining U-Boot's flexibility for
+kernel loading and system configuration.
+
+**Key differences from Normal Boot:**
+
+* Skips A72 SPL execution
+* U-Boot binary included in tinospl.bin alongside TFA, OP-TEE, and DM
+* U-Boot loads at CONFIG_TEXT_BASE=0x80080000 (A72 SPL's earlier load location)
+
+Boot Flow
+^^^^^^^^^
+
+**Normal boot flow:**
+
+.. code-block::
+
+             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
+             |-------------+----------------------------+------------+---------|
+    R5 Core  |    SPL      |                            |            |         |
+    ---------|       \     |                            |            |         |
+    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
+
+**With no-SPL boot mode:**
+
+.. code-block::
+
+             | tiboot3.bin |        tinospl.bin          |  Image  |
+             |-------------+-----------------------------+---------|
+    R5 Core  |    SPL      |                             |         |
+    ---------|       \     |                             |         |
+    A72 Core |        ------> TFA -> OP-TEE -> DM -> U-Boot --> Kernel |
+
+Build Process
+^^^^^^^^^^^^^
+
+Enabling no-SPL boot mode requires re-building U-Boot as follows:
+
+0. Setup environment variables:
+"""""""""""""""""""""""""""""""
+
+Refer to the build procedure above for setting up the environment variables.
+
+1. U-Boot:
+""""""""""
+
+* **1.1 R5:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for K3 platforms
+ export UBOOT_NOSPL_CFG_FRAGMENTR="k3_r5_nospl.config"
+ export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_NOSPL_CFG_FRAGMENTR}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* **1.2 A72:**
+
+.. prompt:: bash $
+
+ # use the no-SPL config fragment for A72
+ export UBOOT_NOSPL_CFG_FRAGMENTA="k3_a72_nospl.config"
+ export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_NOSPL_CFG_FRAGMENTA}"
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+.. note::
+
+    The ``tinospl.bin`` file is automatically generated by binman during
+    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
+    the U-Boot binary with its device tree.
+
+Usage
+^^^^^
+
+No-SPL Boot Mode uses a specialized binary called ``tinospl.bin`` which
+contains all necessary components to boot directly to U-Boot without loading
+the A72 SPL.
+
+**tinospl.bin structure:**
+
+The tinospl.bin is a FIT image containing:
+
+* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
+* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
+* **DM (Device Manager)** - loaded at 0x89000000
+* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
+* **DTB (Device Tree Blob)** - U-Boot device tree
+
+The R5 SPL requires both ``tiboot3.bin`` and ``tinospl.bin`` to be present
+in the boot partition (first partition) of the MMC device. By default, the SD
+card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
+defaults to 1:2, specifying the second partition of the SD card.
+
+To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
+following diff:
+
+.. code-block:: diff
+
+    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
+    index 82b9f0741bb..73d59ac425c 100644
+    --- a/board/ti/j784s4/j784s4.env
+    +++ b/board/ti/j784s4/j784s4.env
+    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+     boot_targets=mmc1 mmc0 usb pxe dhcp
+     boot=mmc
+    -mmcdev=1
+    -bootpart=1:2
+    +mmcdev=0
+    +bootpart=0:2
+     bootdir=/boot
+     rd_spec=-
+
+**List of files required on SD/eMMC for No-SPL Boot Mode:**
+
+.. list-table::
+   :widths: 10 15 10 25
+   :header-rows: 1
+
+   * - File
+     - Copy path on SD/eMMC
+     - Partition
+     - Description
+
+   * - ``tiboot3.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - R5 SPL binary
+
+   * - ``tinospl.bin``
+     - Boot partition (raw)
+     - 1st partition (FAT32)
+     - Combined binary with TFA, OP-TEE, DM, and U-Boot
+
 Debugging U-Boot
 ----------------
 
-- 
2.34.1

