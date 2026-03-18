Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4637FCD0DC
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 08:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5777584090;
	Wed, 18 Mar 2026 09:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MmR5102h";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MmR5102h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B55840B0; Wed, 18 Mar 2026 09:37:34 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15028407F
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=X54TuKO3US5RY71bRFRHmo7bpJCf/vKWBH0Bn8VEu4tWI3Y/M5ueWlVNbaVOzbl/a8QI4sxJKapWOGijkilfAgfyuNnr5hy667BNUNBAd5ZeV0L2ChFaZBx3IVerN7wQGgQ2iZb+cASrA/Lod5ID4dtwPzSDtbbI7AwO1HvSPaEUFhzkYCAlhPp0SNOiFPbLidgAKFbbDbT9NF1M072AnXnoaxzFBEaztltSf/WZBthBshK5rRjKD8oDZmlIFQiTZi0eKMjQJ+vNoQcnHRFYZaSUAFeXt8OnJ3+75ynvLj2OHVEqmENEqCcXitquqlGkwxHkfb5AfYbTh+T6rtgbGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPAiCFb1YOIHeXqrsZBPzQY3A84LUNo2wfO54gPITWU=;
 b=V0sXn6SJ3x9xevrVr8f+h5IxwJLi0xUzywjJ27ST+hqXKtzZ/8V1m6fsulXdza2iEL8XH51i6mnVlzxamt+CmI+8HUBaHaVEDBFfAs7Bs2gIobWrXlg09Ww8AxuRM0UQDAvgEyEPhl/hRTIj14MYH9pA1KiodR7wQz6QUe+tCBqUKTXxDtpiKbBWdOfFS0zgvX1lhtAVL4see1J19xMGDpwWwhGj06R7YzCLFOG8MD0A8Mzh9s8qWAhuLJuEff/XB1jgy1XDVAsf8slgsHsNc1ZIyKJmTKLB2xz2IqNpeg8ElqUgjOBmp2sPpEfkorA5iM/zCRjT75eo9ebD2iYyjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=altera.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPAiCFb1YOIHeXqrsZBPzQY3A84LUNo2wfO54gPITWU=;
 b=MmR5102hVoIU8Xk5sg30j9kEFQsrrjTQMD6i+/feoKbQoK1eK8XysCjw0VEVWt1/oc7wGyjxwV+SBPvmlYh61fkSvjQpGZKSyVt0KT8n3e5FbEDBGgPIYI1IuruScs9bNIgSnrMSN488uAGkgb/umv/AZHuUj5VPfOBvD7L11FU=
Received: from PA7P264CA0540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::17)
 by GV2PR08MB9423.eurprd08.prod.outlook.com (2603:10a6:150:df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 08:37:22 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:3db:cafe::8) by PA7P264CA0540.outlook.office365.com
 (2603:10a6:102:3db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 08:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.0 via
 Frontend Transport; Wed, 18 Mar 2026 08:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAE21hpmltuqEixAYEA+8SUIZYE6BDsUm8l3SsVgP0FAZMuXDcPOZ4blmtGnNjVw4D8e5S7U7rkkJFndN0JdHw3bqwUfx+8JBoEdgPmLkuh8Pnrtq71d6sEZo7AEo9Dy4ZI/23oIqNPQB+9QImILhmNzGeth+j3j1AEfeqQoctjB6s2q7Ri1q7VFzvN8/ldvP+jplSZgpef6GRtlM8HNe4l8s0gDd+vjgHDpWUnJh0mG6Vs8wkDyrwzM22zjxfssF1CrMWc+xfK3J2CdQnDYLytj8vrJ+SGMMr5XTXG/Jp1qD5mVKP2PQUzi+o1BsuFGvwM0F1HqjeRs/j7D/yGRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPAiCFb1YOIHeXqrsZBPzQY3A84LUNo2wfO54gPITWU=;
 b=IqpBYlPoj5cw6kD4ejUwQGJotQJTeKjdgH6DBsRO54Svr2XXgS5f6GKVHtSRN7aZak8GFVrKzT3h6qjHESue+IAn7+eWcIHlruOxcaJ+DqvsU6m3TrhIIykdWD14hhMflpGRWMY4Ds2UDLlhcJzvtXFfYMREBQli5qj2fECgixmxf1Ju7m4OsHLx+CKbf6aILtCXLewUwK3LeNjBK+D+awMbVaTXobEk7SRnGQhBt/3vFRmx7gZNu1SPnoMkrogdyMgewdQ6snrQt0IqgT1JQXLa2Iov2y4Wx4wuyP+AY27JtZqILrFRu+oVNeUrp3IgYxb5QR+JOBahZi0I6SD2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPAiCFb1YOIHeXqrsZBPzQY3A84LUNo2wfO54gPITWU=;
 b=MmR5102hVoIU8Xk5sg30j9kEFQsrrjTQMD6i+/feoKbQoK1eK8XysCjw0VEVWt1/oc7wGyjxwV+SBPvmlYh61fkSvjQpGZKSyVt0KT8n3e5FbEDBGgPIYI1IuruScs9bNIgSnrMSN488uAGkgb/umv/AZHuUj5VPfOBvD7L11FU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB11832.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 08:36:19 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9700.025; Wed, 18 Mar 2026
 08:36:19 +0000
Message-ID: <233189cd-ade1-4383-879c-537564547914@arm.com>
Date: Wed, 18 Mar 2026 09:36:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net: dwc_eth_xgmac: Move DMA reset and pad
 calibration after PHY init
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nikunj Kela <nikunj.kela@sima.ai>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, nd@arm.com
References: <20260312112247.30570-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260312112247.30570-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB11832:EE_|AM4PEPF00025F95:EE_|GV2PR08MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e7cc36-2538-4657-5ea0-08de84c992e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 4xh/mKWwstvDkVKAYDAATHePuy6jZrJZOa4zBvEULGAJsTbTIJz3NEi2j+Pa2rVttKN0DE9tdv22+ri4uR3B18JKjAEAH7GZyI5GGDUuh3KmtmaSl7tejOHOy42GNto0Puj790fcRBTUiDX+QlnCBj3eISpEhFTyw09BWDhzBhUtXDnK0AoEzXafuunrKN4GNcUNU72o9Bt0RJbgeJcx8Q33jBeo5BPTXYVFPWgLza5ZAjl9nVQMMv11Pwm0Ppn9JTGePY8qRCKlk/yBF+Kh6HtCXzuehtXNGLqucR637w/kd8GuPk2jmh2LnlKB/wlZy3JlB836tRPvgP8TTE9Ol2L3X2cWVomP9dedDvYc6OKWQThZhpPc6SQ6D2emguifaOLaVA61WDGMMs0Isvt9S0uDUD6s42QSBbNbUPAH5lD0ZSZKiELBDu7xkVINaIVrAa08RCvt6JWjMIkV+UZMphM/39A0uUtFxkO4fKJFt7qO1o1Duudaq1s3wZhyHPNwLVkDWo4oaXKfwna85BA3UPUVthJXkfjilz361rzt0OSrBEbThHF0SyJfbEkHfQdQ0mGtPwxNJQ88oMNKIef9O2+PqYZrt8l8bTnwpcDXOnbVQHUlfge8LSkbhVKDrR32s77CInA6JDdnrrxtHFhWH7HbRZbt6U3SIKdRgE50SvZTS1870sxQuLQP6mpfDY/+fjUKGCGYpPvQjKTRldO1GKcmStB9NmGaZRVhXAl1jzc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: WACC7MMWkpj9vi6Fc35ZV7Gk3w1Nf7iUVSMQ2BxMW2+Lp9BFMH17HIE+rblBbsgRPsTCvWI+tMIp83q/sx6jlnYbaYHv3b5vPlAokIHjC8CggKCBDk6Ga856q7+zEZlQ6lxZW1+DFDo+2L1e+lSTJk0qpvMe3RY0CzJ/7jAMeX5KW9bZFpUR9Ue6n5poyZXhp34jsPy2rIHTyUyajjAH55OzrgK8wqWSlQ6tuoNYGisSBB+iuPCYh5xdWmCIsOq3BHzRS9CsNiaucqej/JzeHfOhju2aCCWi1cWrf6obiY/D50DiNT4DUX5emDNaJnjtbdIgLj1xh2dZYHwiCx0rjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11832
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b382449e-46e6-46f6-0669-08de84c96d63
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|82310400026|376014|1800799024|7416014|14060799003|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: 4i9ef3oR7paQTxWHQkoOHGPQpEANbq4VErObcbV9e7YWMZnKpxm27DWy9Lh4ex3Ws+o34RqK48E8SxctqB2s0ZvJrLLaiAoIvRRcZntAQiBv9DR5tmv+RVbEuqz4nBa0CQG8yJ5xI3GaRMsw0CJ3KQNvwla9RzzcGpo2QIs78rLNSK92kWIQbJoGSG/yYx/ejxRmrctPn4jsdZNillynyKNlRdwDMvoRgj2Z23lfUcMZfMotiZ5Odajzbe9ead+QUBEr9sm+1XHPYK4xBQyEQrvu58uTu3/GO+8HDE1cgXXWZ/XWTc0L44ZJXkRC8d/jBzMcCimcge0P3rHIr5hWRwW+UKBHMH3Ro6ETT1FJs7PVoYPVbdITq10X76n0fB6bpqspd89IHU23tgUTpVk5cRLyv4c8O3mTJJaLaQv7M9Rj/7NNoOEExFjoAbSLxqUbqbkiVBi9N6d4lDjEfLseZSd7lIWoh9fntdKItYN2U8yHWtJWPGppzA8+xfMppIwPs3UcsR8LNF6FHvWY0XcCDvTnW/Pso9q1KKqaZ/mewwaSNmwDWwkIzI+ouPWH6QC5qIkbZJs/bDbDTzQ9djoxjG05C7hLW+lJPM0UTYlBTEftolSYWeygxf7aVYNHOWOLl4bNl+UCgmm1UMHDa4QbWcOCkbGMsshqSAngldNptCOzb8yAfwjIJZzFmibWagcUvwXVygqP036h79KLm6VjuXfyrjaasF3jT5n3LgixkVOrNJfkJ8YNpiWvUKaEXazjHws4nAr+suuNRyDBZD17nQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(82310400026)(376014)(1800799024)(7416014)(14060799003)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FfsGW9IafSvHr65OTXBp4xaujDZnYAAbh8yRyH0BP/lm5dpY+v2hCBtVjUrmgD+h8TqCTEUOPxIaaTSj2/pHiOXVh7hi+M5XDo/4qMffPCczP6VUza9a+Uxd8ZT4hmVjFGPWltqjLPg/RbKXW3UWg0lgmp+ic5a/4UBpsbkLj2PEtmDKBp9Hiuhr8dtrYhNztT6jW1tEopz4Sv7wB80Fw8TKezdTJA4HcbHlNgUQ5pMMPaFspAjIesaP+sYCUWHObHHq4Ugu/vei+75GczEAQkbAsECeZcOkLR62n2oWAAutEOQCnv/IJvoBntXPP5voZO+g8KStKWZXr/8sRVfX1qzuthEHqZGpxr5Cvist+C5g+/z65ni8GmQvpxCnGU+TJ1TsdvvOtH+gDB0vSFbn3b/+w9kEkZgDe8N9CsPdGsxnoCJ7vB+QuLQscAWQ10p5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:37:21.9662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e7cc36-2538-4657-5ea0-08de84c992e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9423
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

On 12/03/2026 12:22, Boon Khai Ng wrote:
> - Move DMA software reset and pad calibration in xgmac_start() to occur
>   after the PHY is initialized and connected.
> - This ensures the PHY is ready before performing these operations,
>   which is necessary for proper recovery after reboot.
> 
> This change fixes issues where the PHY did not recover from power-down
> state after a Linux reboot, for the board using Micrel KSZ90x1 PHY.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/net/dwc_eth_xgmac.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
> index 458b87af7a2..2ab5ec5f0d9 100644
> --- a/drivers/net/dwc_eth_xgmac.c
> +++ b/drivers/net/dwc_eth_xgmac.c
> @@ -497,20 +497,6 @@ static int xgmac_start(struct udevice *dev)
>  
>  	xgmac->reg_access_ok = true;
>  
> -	ret = wait_for_bit_le32(&xgmac->dma_regs->mode,
> -				XGMAC_DMA_MODE_SWR, false,
> -				xgmac->config->swr_wait, false);
> -	if (ret) {
> -		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev->name, ret);
> -		goto err_stop_resets;
> -	}
> -
> -	ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
> -	if (ret < 0) {
> -		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev->name, ret);
> -		goto err_stop_resets;
> -	}
> -
>  	/*
>  	 * if PHY was already connected and configured,
>  	 * don't need to reconnect/reconfigure again
> @@ -559,6 +545,20 @@ static int xgmac_start(struct udevice *dev)
>  		goto err_shutdown_phy;
>  	}
>  
> +	ret = wait_for_bit_le32(&xgmac->dma_regs->mode,
> +				XGMAC_DMA_MODE_SWR, false,
> +				xgmac->config->swr_wait, false);
> +	if (ret) {
> +		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev->name, ret);
> +		goto err_stop_resets;
> +	}
> +
> +	ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
> +	if (ret < 0) {
> +		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev->name, ret);
> +		goto err_stop_resets;
> +	}
> +
>  	/* Configure MTL */
>  
>  	/* Enable Store and Forward mode for TX */

Queued for net-next, thanks!

-- 
Jerome
