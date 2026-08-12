Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A343C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 15:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F027C60A8A;
	Wed, 12 Aug 2026 15:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWJevPrgZktT; Wed, 12 Aug 2026 15:06:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BCF560A73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786547215;
	bh=Rq/tRlbWxenUMZgcJtczNIhv441r1P/ASVfzAccZzdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RBmmsmajuVxuUzricIG5w5HL0u5GOIXmVUallLsz3S+J0M/TT18x4pIKX73GO5866
	 fkCHXL8q0L8Pxb0gQ4LMUUcQkv5oPhLGq5nWBFwdwJE888avTZZaeE5xq+VZ5ZdlxR
	 L/6QhBiLZ0nMhNC+BYyrFsA58Ax6SidlqFP4yJTyhYUtbXptzb0Z6d6YLHTKeOA1y4
	 kLZAhxTiaAW/35WG44Eee0Snlxt/nEVzGJLB9/q9iLDrFbBXMew/eHYdi4EgPnsVQp
	 JPlFg5qN9T3YY/k0yPbRvm5dPGfOwaWO7Wkomy6PXVAv0Kj+Lu/CAgvp51zjVoL80Y
	 UsF08NoKeV0GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BCF560A73;
	Wed, 12 Aug 2026 15:06:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA1E263
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CCC18129D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSZSVpG46kYd for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 15:06:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6DEF68129C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DEF68129C
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DEF68129C
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:06:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fNuclIspnRDEnGGTh3HpMs5bp3iEZ4O2+DfkIvlbK11TWVTGSyQF6ir8HIJia/FXwPATUM9cDAQv+3N1uUAfk2/jZy22jML0Y7NjcFXuIgb7DFM2hjo1hOus5kINfnl2cSnFzUzwHosZaB4IHv1kB3wfQmruDFkIA0Z3oZyBtLjKp/a/SBjOHxn9q5E6moi5pmrt3ua7RDopC10RfxZXND6EfeHLuMGxYRjwQwbOYXrAeLj8cxZ8OHhuylRsnMlT4m94GOhB+1eZ4n9NBUlzlbQQmYGIAYvL6SOmIhQ7sZ7Br577eRGDxdbyozdXnmBqCjRTrh7K8iLrwFvTSeTIuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq/tRlbWxenUMZgcJtczNIhv441r1P/ASVfzAccZzdM=;
 b=kCQFJseg6GvjZyaDophdyW/dc3JejMpU8aNnpgjlp7ZBJD7WuHfVEoPETqycjXuWUcyZj7J8DC/wK684A4wNXHgsZ9zAjJuUNbLD31BWioc+IY3+1CHal5DLu8SnwkPZxxGu1fyj/uH/BWRadJ8jIi1BAv0bn8UqH2YZyCNxSCntsPuLcjTw5HpWrobBjj6y/QS0Zucv8t1HyNfTfTsu/HWsnWHZuhX0jMvyWmu+k9o1Hl9BQc3Svta27q+WFjrvGaXxm3Fbex82omB3uI2iQB7sVzjqcVyHFfK2FNX8T39gpIfvzmoNXT9lRkrW4EfAutgRwt2M99wuypqxR2KjGw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:06:45 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::25) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 15:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Wed, 12 Aug 2026 15:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbxStmXQdl/ICZmSa58FuYtYDuBkjRYWWqHSFG+R1letV4HB+c+DQfjQj+LyEOGzUNgpcemL32Rhge1V0+TIoGVxV/RnJcUae/km67z7IC+eH3S1uWo4PIM6+OjKOXn5PShWuAvZscELZk+cmpZVTIcAF6iHnW8TSy1stnI3xXINX80auLkZ+4X/YwiqWesEr4ioCs8Tof0MuSWJfsHb+T3aaiQzuu/Z1X2oZ52wAblApZWVgBIz3cRzx+Wjc9Te1D/JIk1aR9GOK0xfypJBK6fzvbaTUOTew9HoXluCbz+8GwklQoJnrq5JF4t5Hom9PX0hI65t1JnBR1xtSH7glA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq/tRlbWxenUMZgcJtczNIhv441r1P/ASVfzAccZzdM=;
 b=nm3bmwTeMk0u860irzGNChvvu7qPU1XoStabEfflAXwhzU3KwOeMRyI04y0j54V7it4LAXc3u3whXncsO8NWQ3+or8Iwsfir1QTDJ+FI93VY52gnKuVZx9Ib1fq379vRkE4MFOkVcdGzjq6GrJBxq4OCJDVY4fSiLvhFd2fyQMyP+YhNRiPtfOwOmTVHN8abvAaMepL8IfIXRj0WCP+8p9oC+snJU98xpS58BzH2SOF7lJQEX1IY2wB767gYd/YYazZQOkP8+vymRUzUckHgJ4xQU9sc3EzR66cH3dw+GAuiobt7bBlLIFccMqKk1BC3cqeTwNxzej2g918jioheAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9545.eurprd08.prod.outlook.com
 (2603:10a6:20b:60e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 15:06:05 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 15:06:04 +0000
Message-ID: <ce8b5c8e-d62e-4e28-bab8-dab2d26a70aa@arm.com>
Date: Wed, 12 Aug 2026 17:06:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: dm: nfs: add a regression test for an oversized
 NFS read length
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
 <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9545:EE_|DB5PEPF00014B89:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 576e6213-fbd1-4a11-89ae-08def88352f8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info-Original: TzRBireYfRck2V39LeyswDi6kbAbq/Afa6r3cwvzOmT/bQQgzpPbCVf/bib2eHd/qlwjIMAeWRZhqajILT89ALLKZx3udNQyv/8OdMZ0HDE8GyKaUpsd8lvUqIMmFbyBqsnwSckvhOV1/klMmrSrPh+vwxJ6ffJYcsiJLGHen6EA98VHgHx8QXfEC5K7iLM1XMyE2o/QXgqoX1ZhWnyfD3cHMNj0TZoqmdHK1tJW4gbcAydscOvpw84o9MHJ1YwbuFAbHy392cu9XvLruXFbL0eALzCdsgyQxG8MaLFAk8pie9EB8pZzEHNpKGZn2lp4e5oqDok6u0yEjLpAksU89fPN4KnKZMPz9SkGlljvmYfCeXq6PJMUwoWIAHxykvFRCBR9eO7tRpsN/ivDIBGY8c6cNXYmkpXLiYJLMRhh0/iKpZ+czJEIU6EVvn6Ta60oJ2gezRGiX4bA+yOVz9o8wS3jxO05oDwrHypudE6iM7vQ95fs0VW+jyHudoC/Hw6x2CXql2jn33/1gYaO9SsvsNvXrTwiZ8GHlNMb0WdntT8oi5VgMb/cCayiC2puGD/XxF9Av3p6IgQMh9g8DCCLBq0MVRz8R2vpHUtrII70SnQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ijNnPMZlM8Tp0VOVBU4LlX8A5jAg3qwITA7ofN/vo0neq7Xv9HTEXzfyLxMPq9AY5Lg0Tp0IXcEfHDwCKOqhVGzrtK+1sTkPlwRwmTP8ZtaDx+K2h2EsTFD+YB1nXUdJ1bjTh/huKyaAJu5DL17X4lT8B5nKwxzGWORCJ/qkVTzDANKxHa1twpYX80J7EZ4lZ2NPQLbJX9mNhnQrknCYwZy7N0TCh5EMurHp/asopiwuyf5fYB4A8jU4ktqzgLBW3aTCpSzp/96YYryzzCB3e3Zrl6bWRURoSRwXcHsYJK68C3E7XYVa41nFsektJoBI4RUePRiqm6Ytr/aeZHNW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9545
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 55ba4310-b2ca-4533-54fa-08def8833b07
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|23010399003|35042699022|376014|1800799024|82310400026|13003099007|10067099003|11063799006|4143699003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zsHjO1HOrPTYmvIMCTMHSGzKxsWEwV0oP7/3eUqBvm76jITIdk7PIPcFKGxXe7iwNYgfCeTskFNw+jspTTxikjfWoPHyr8ZCwv96PtEosMbJw8ePedvOV5tLjdEE2VVWnN0e8Ac/osOdRJslJi8Rt60X1ym64TW7ZrccHvRLjnGcZzTozx9T4Zb8oVrQxFmtvGsTDLEPDDW6D9ihrMwdsvDYf0WwjYdlRFcW33+xknJuRN6uePXLWXHanKqggPeDtk/wR0QdDDaegkulUmyVka9pYNtxHmCZy5Pk5Rg4L7O8cb8XUQOEsjTqFdeSE3ZtyiVVAeWpEzkMXXi5aIN5HL9TuDbDxxedfDC3FCB/t0ybLotIorSC+QL4Xm3QJimP8NjGKXY6YbEt0pzc6AEmp0p59DiIB8DKuqFeDGhe0rHHUfxT0227uf36yNSasDkVCerSu/t+EdHik+rWRAY/Ll9HPaiEGMnQCXGW8VEbl308evFSpB0Q9wziO+9HB8T2cCIuFyEb1CANNNonc0nNT62e6Vh+tpNOhI7S8Tg/UkU8bgeJJmVTRPZDPznrH2Sx3o35f7KTkoi9IfvGfRhp6qeGM8G9Cwt9ToZ1yyzefQIO0+5PozYIv0rptJn6sJnW+t817Rf2G05imJW/Q3TCnA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(23010399003)(35042699022)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZrJySfnv9RkX2okpPd49wkqll3mX8rBGCXzK6R4Si2Cot6SyXRmQjYfZEPIGYZpXV2HeUthvaSjpY5U2Ki/SRvtpKNsOK3VsI+DWXYIWo2AGaCHkeG97GnlTWHzJibNyFbrtPFOxrhNDy8Z8CAnyzPcgacQ4rUXiOFbvbN0nI9pbs6nN9g/t9wzjrnkDWJZ4AaaNLKdpLWm5R0ewgtvPCcfb4t2LqZyR4sO9VKvjgLIhINaUCfMJRrdRj+m2ajGR1tvKm9IxXSWYw/LnVALP6rAt6sgpJa9ONK4cVyWruy5MBJ01nL5ZMAUxX1ympUHGJPrTGfC2yEbCjulZ7+F6+DgIAfE90NLByomUiji99sRkZYiyNyGBr8kOrFI2+AWnsrVUqsvrLm4JtJxe3zVIz1Ss8nfr6Q4tJFF0KRovwMpQDXN1bDZTtzxP2ZcO7sd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:06:44.8598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576e6213-fbd1-4a11-89ae-08def88352f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq/tRlbWxenUMZgcJtczNIhv441r1P/ASVfzAccZzdM=;
 b=A50bJ5YTLZTUcCQDo5Go5QwBkDrrDk2XH/VyD+n+v0jWNagJCa3gz95M6xSN9Ckee0rg++s1XrEQZzRLWj/d2gOIwm9E6spnKTQCgk4r080WS3IzVX1R8TtlPrtrsQWpnFFQoYV/vnaS3+HcnNuwyiQItbV3gLFe/bkWV0sgDGc=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq/tRlbWxenUMZgcJtczNIhv441r1P/ASVfzAccZzdM=;
 b=A50bJ5YTLZTUcCQDo5Go5QwBkDrrDk2XH/VyD+n+v0jWNagJCa3gz95M6xSN9Ckee0rg++s1XrEQZzRLWj/d2gOIwm9E6spnKTQCgk4r080WS3IzVX1R8TtlPrtrsQWpnFFQoYV/vnaS3+HcnNuwyiQItbV3gLFe/bkWV0sgDGc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=A50bJ5YT; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=A50bJ5YT
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

Hi Shahriyar,

On 11/08/2026 20:15, Shahriyar Jalayeri wrote:
> Add a DM test that feeds nfs_pkt_recv() a crafted NFSv3 READ reply whose
> 32-bit count has the top bit set, with a read outstanding, and checks
> that nothing is stored. An out-of-range length reaches store_block() and
> drives a ~2 GB memcpy() out of the reply buffer, which CONFIG_ASAN
> reports as a stack-buffer-overflow.
> 
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  test/dm/Makefile |  1 +
>  test/dm/nfs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index fb3e6a7008f..cc51fd33079 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
>  obj-y += fdtdec.o
>  obj-$(CONFIG_MTD_RAW_NAND) += nand.o
>  obj-$(CONFIG_IP_DEFRAG) += net_defrag.o
> +obj-$(CONFIG_CMD_NFS) += nfs.o
>  obj-$(CONFIG_UT_DM) += nop.o
>  obj-y += ofnode.o
>  obj-y += ofread.o
> diff --git a/test/dm/nfs.c b/test/dm/nfs.c
> new file mode 100644
> index 00000000000..abfa75f1941
> --- /dev/null
> +++ b/test/dm/nfs.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regression test for the NFS read-length check.
> + *
> + * A crafted NFSv3 READ reply whose 32-bit count has the top bit set is fed to
> + * the real nfs_pkt_recv() with a read outstanding. The signed length reaches
> + * store_block() as a ~2 GB memcpy() out of the reply buffer, flagged under
> + * AddressSanitizer; the fix rejects it and stores nothing.
> + */
> +
> +#include <net.h>
> +#include <string.h>
> +#include <test/ut.h>
> +#include <dm/test.h>
> +#include "../../net/nfs-common.h"
> +
> +static int dm_test_nfs_read_oob(struct unit_test_state *uts)
> +{
> +	int saved_state = nfs_state;
> +	unsigned long saved_id = rpc_id;
> +	int saved_offset = nfs_offset;
> +	enum nfs_version saved_version = choosen_nfs_version;
> +	u32 saved_size = net_boot_file_size;
> +	struct rpc_t reply;
> +
> +	/* Pretend a READ request is outstanding (NFSv3). */
> +	choosen_nfs_version = NFS_V3;
> +	nfs_state = STATE_READ_REQ;
> +	nfs_offset = 0;
> +	rpc_id = 0x11223344;
> +	net_boot_file_size = 0;
> +
> +	/* Accepted reply, matching xid, READ status OK, no attributes, then a
> +	 * count with the top bit set.
> +	 */
> +	memset(&reply, 0, sizeof(reply));
> +	reply.u.reply.id = htonl((u32)rpc_id);
> +	reply.u.reply.data[0] = 0;			/* nfsstat3: OK */
> +	reply.u.reply.data[1] = 0;			/* attributes_follow: no */
> +	reply.u.reply.data[2] = htonl(0x80000000);	/* count */
> +
> +	nfs_pkt_recv((uchar *)&reply.u.reply, sizeof(reply.u.reply));
> +
> +	/* Rejected: nothing stored. */
> +	ut_asserteq(0, net_boot_file_size);
> +
> +	nfs_state = saved_state;
> +	rpc_id = saved_id;
> +	nfs_offset = saved_offset;
> +	choosen_nfs_version = saved_version;
> +	net_boot_file_size = saved_size;
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_nfs_read_oob, 0);
> 

With the series applied to for-main I got a CI error, see:
https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/68484

Thanks,
-- 
Jerome
