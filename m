Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C60CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064198403E;
	Fri, 10 Oct 2025 23:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="cJEs2geD";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="cJEs2geD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFC084042; Fri, 10 Oct 2025 23:05:55 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E893983FAD
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Qy5TSq2D6Sbn7ultIm67L65Z3mA42cRLRMtbBPozvEE3erPgI978BTAZzA33bcTrKepkcCGTA9Q6nEsQqPeK9WqAeqpgcG+BYJiirlVOzuiNXk3D7hjhj9dwgBP1IFuHVJo8xLhRV4wc4zcljmM0DrHdOiwlMqemi7Tn5VzEzRpi3nFJwhafevg5suVQUdJpdC2RjIAET3taOywLzGEz0Nz02DuBnyZHeLwwZGN+tTDGhkblGRkNPaaUwsMzuBwl8EGJCgwUe0zV2bVBMhsEmbm/1yY8pPGLG2RQnOz84eSgBd2rn7RLBk2G40YlSHzVFJjFcfrZ1IbTlpNEgLi0lw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2i5+fKdlj3MIOVM11O5TOFOB1+LmLik3nxEjjql3X8=;
 b=rP1xVaJUk2LXVudSoeNnRC9O2Jj7LTFLpdNnHBeSOySLZdh0pnJNZ6zWfbOZ0VwBTQWe5+pU3L36v4VnQwGirB7wz+1B0wBxxjdSWUYWHwyqp+ZEKxAe04TZ03/urBUWMC+fe1esg4UAuLxJBXK9aB3nxd8BtTyiGoGAgGggRUR/QAH/p8+wWJWbziILB4LlauxntPUO/aVYjwL5nqf2lZSWyfMexvL2wHp0lB/3WPV+mjrYJtipmtZmrq9EckHvAuCcY3l9vVzgjQPVDzgMROgbJDlTKb8Knkb8odsoXxbLJmN8kPVTrVLJTE7p+v+KOmOvuuwnlALa0G+vr9zp3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2i5+fKdlj3MIOVM11O5TOFOB1+LmLik3nxEjjql3X8=;
 b=cJEs2geDe8Ru1klq9krtjMDPkBbmikrZsg72FQxdqKrVl10HM25Nckzhx5E8qxI/ONuhjS/0Fp7GCzPvUZsAME3wn3yKj8euaLY27A/BfVMb/x8wrgLdqdX4Ec+2L4FpolxsHkQpTAmeS5GnC/fTbDWJTsI6h7U+YmhN27eh7FBCxi/c8VTsqa7Y/wyGXlCxkqnirHjmHgqF02Yq72cFXpOr353h64bO6eQJY+tAwyerzoT5euv7QtZ9CfwaJeKEjn8AcnOhbToCeMCFpEdXv8kMcfh2ckBTVYeXWd7fQ1pjTaR/4J0uNDngKV8m/68DP26xPVX0fyWetsJfDr77qQ==
Received: from AS4P192CA0054.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::14)
 by DU4PR03MB10694.eurprd03.prod.outlook.com (2603:10a6:10:590::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:05:50 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::31) by AS4P192CA0054.outlook.office365.com
 (2603:10a6:20b:658::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 21:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 21:05:50 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 5BB182008162A; Fri, 10 Oct 2025 21:05:50 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (unknown
 [40.107.162.77])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 12A61200800BD; 
 Fri, 10 Oct 2025 21:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTIj25XbckuBINhpxE7aTXw29SHLrMnT0zF+UoGt8LfGeeC2xcOEDdqJ98woQMEKCWe2647HjhQa9cdYDqd/Kly5EaaIHncpQj29KkQngIMoRk0nf5CqgK+bXjcab2/KZKoEE4QyP6XDPQNtvz/7LWRTWYdXVeXDZuhZv3bsXicsPolcRNe/tB64pGE93W1koWQF8zTffRHvWOX0BDr2wZNz+KC8cSapw8R2+eIBTiNpgGgyLqigiIUKFYISAwZGlvgtZ4PeioSb/xUCgKxzbMP7XlJM+y0tRf31/9PhO2QqPu8c8KogrlneUPm9yNUZeJYBXqoLcJtKRoC2sC/rLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2i5+fKdlj3MIOVM11O5TOFOB1+LmLik3nxEjjql3X8=;
 b=eZ/8SNdmY8Tgyeff6ADI9wejYczarsqNIeP/aUWgbOn8zLKQKWlfw6+3cSbeTapwgD/L7dw3PsPL1fykxrCWiOPR27LyM0IFpEa1xIAyVLU37r4ykN3HF7WK/Zo6Krg5Ea8TpqQs/NB7GnY+AIZV/qpMpffMmU6vq0QCoiG1azxiBDDK8Y2ox2bnQpVTlNCytkmipl99gJV90k+0BN1Ox/G7KitqrASXcIVkLvL2ZIWRQL6/ThIWmrdFR6xJ78pnAbVxn/7vmI9qF528BgItlT014TR/hG4tg+5W6GgztLnLjHG/DCzkU9ZMleNYsYhGqPip4cAtbFJDEv/ZgXJ75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2i5+fKdlj3MIOVM11O5TOFOB1+LmLik3nxEjjql3X8=;
 b=cJEs2geDe8Ru1klq9krtjMDPkBbmikrZsg72FQxdqKrVl10HM25Nckzhx5E8qxI/ONuhjS/0Fp7GCzPvUZsAME3wn3yKj8euaLY27A/BfVMb/x8wrgLdqdX4Ec+2L4FpolxsHkQpTAmeS5GnC/fTbDWJTsI6h7U+YmhN27eh7FBCxi/c8VTsqa7Y/wyGXlCxkqnirHjmHgqF02Yq72cFXpOr353h64bO6eQJY+tAwyerzoT5euv7QtZ9CfwaJeKEjn8AcnOhbToCeMCFpEdXv8kMcfh2ckBTVYeXWd7fQ1pjTaR/4J0uNDngKV8m/68DP26xPVX0fyWetsJfDr77qQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU0PR03MB9867.eurprd03.prod.outlook.com (2603:10a6:10:400::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:05:46 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:05:46 +0000
Message-ID: <f19ae06f-1e63-4e1f-844f-d568fdd224d4@seco.com>
Date: Fri, 10 Oct 2025 17:05:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
 <20251010203134.GA1187059@bill-the-cat>
 <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
Content-Language: en-US
In-Reply-To: <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:208:239::10) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DU0PR03MB9867:EE_|AMS0EPF0000019B:EE_|DU4PR03MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d771814-d7f9-4c0d-9de0-08de0840cab7
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?YXRZZVpjeFN4dFh4enpVeEtsWFNtdmJyZ1lrd1prZGhrR3dVNVRCM216Wm5j?=
 =?utf-8?B?dHpPVW1TSXl1VURIcjJwb01zQlU4OGl6N045R3ZwR2Vqc0pneHpwOFY1TEFT?=
 =?utf-8?B?R21JcWFsN2IrNkx4VEU0aVdVb2lvcllCUE1kOEZpZUpmTm4wZGkyUGowMXRO?=
 =?utf-8?B?UzRPTHhhemdLb2tTc2thOTVuaFdISEd4NFFUQjI1SXRXVTFCZ0p5WURIeG41?=
 =?utf-8?B?WGVzWXBwdXoyQWVoRXZhS2pKc3JzZWRKVkU5K0FJQVBoT095Ymp3UmIvQytW?=
 =?utf-8?B?TjV2SjZwQVJVNW45enRiSE1zZ1pRbVFWQ2pLU3NxOXpVcXRzV1R0WTlrd1gr?=
 =?utf-8?B?Nit5NmJNazVZVFZuVEZBM2VEY1VPQXltWWc3UlBKcEJPTTZFWFRwcWVTSEht?=
 =?utf-8?B?Q3hYZlBGS3M3bEN1Ui8zU01lb2JKcWcxYUhpeU01N3JmTHhvT2s1MnhTbEdH?=
 =?utf-8?B?c0lyODBsd3lmY2ZQT0dKdUdQeEZhTWR5b3ByamJOZVlTQVlpYVFlM3dYVEU5?=
 =?utf-8?B?MERsdzRZNURVNWprYmF4TDJzUlZkTEp4cExNUmJiUEJldjRJZHBUMGVCZzRy?=
 =?utf-8?B?SlI1YmI0SHlWc2xxUHhpSWxubG9WVzJPSUVlWVRwQnNBM1VxS3dpZm1jSWFK?=
 =?utf-8?B?SHhjV29GbnZrR1duUmRkM294NExyOVY2dzBxTUxuTW5LOU5BbkFOVU10WUFx?=
 =?utf-8?B?K2owRWxPK2tSQ3MvTnZ3SWVWNlZMVzJHTHk4ZnRQN1dVZ0lhUG5nRmVYSmo4?=
 =?utf-8?B?SEh5OURiM2dGdUY2YVNTeXRtRmZLYzJ6QktPMFhQdmFua3F1TGpoNDFXL05W?=
 =?utf-8?B?aHpCY1NJVkw5RVlYUGs1cG9tSXdBSjBWZTM5ZjJocHRyaUZLVUJ6bE5BdklE?=
 =?utf-8?B?N1B4N1Y2RWpyN1pRM2pWZjRYR25YL0V0NlRjWWhYaW91OGdWQWlHci85UE1y?=
 =?utf-8?B?RHYxLzlPMmozVy9xeFNZRExKa2M2anFIVkFmUFNDNjZXREx5RkNtZmJMSlZl?=
 =?utf-8?B?aG1tU0dRTGhRdnUvZ0dEdjZaY0RHZk9peldHRDIwclBtSXFlZU1ROWpkM2Rw?=
 =?utf-8?B?TTUzQkNRUFQ4amJFSjdOb2xNbFN1VTdxRjA4Mmhvd052OGFUM01kNUV2dHh1?=
 =?utf-8?B?ZDFtNEgrTGs2TnpUZGJGSmI5dmRDdGk3YnNjRml4dmpJZkttS1VyRC9nSFV3?=
 =?utf-8?B?c3oxSjY5Z0U2dFk3YkZGVmx4bGZQNVhsSitpOThqVUFtbVBHRXZqS1JBT2xW?=
 =?utf-8?B?N0xFUk0rR212dlVzb1c0VmdWU25vSElROFIvR0hHbGo5WWM5MFZKMmtxR1JD?=
 =?utf-8?B?Sy9PZlBpZDFkQUdITTNjMzdYNmtqUFVRV2twN3phN0dBK3NpMk80d2hzaTJ0?=
 =?utf-8?B?SFlLbCs3WDBKYm1XVWxLU1N6ZnMxSndocTVKOUN1aU9sOUFoMmdlSkdBWEN3?=
 =?utf-8?B?d1d4amV5ZHcwYmx1SUM5Y3M5T21pUmV4ZzB1bGdOZlUybWtmcVp2UXE2N01D?=
 =?utf-8?B?eGJFMnNvbVpsMzdPckdLOFlWN3ZIUTUyb1IyNUVGTVpiVjBDMFZiTEtXbmhT?=
 =?utf-8?B?QXVSNERHTmVmcnU3clpsNFVBVGFWRUorZHhpM1p6em45Q05XVGcxNkd0cFpV?=
 =?utf-8?B?ZUd5NUJFU1BRSVJWRERoYURsTTE4N3dhQjZlRzk5d0MrQWhDSFpmaE5JdWJw?=
 =?utf-8?B?TVlSZE9LQkkwVXVWNzk4YlA2ZXFPcDVWMWxyK2ZNb2dEYkIwZUd3d01XRm9w?=
 =?utf-8?B?VTN0amJ5V05mSWczWjdXYVVpN1RlNFdEOGo1Ulg5bitpUmwycjlsNEVZZ3RG?=
 =?utf-8?B?bUJXMmdDZUMvTnJkK0x3Z3luRXZwNytrNmI3bTBjRW1XNW9DZWllV2hDT0RJ?=
 =?utf-8?B?aE1zUUlHdjZxWnNCdWRpbXc3WldETU50N0FWdExzQzUrT2JzTHJOV3Qwc2VD?=
 =?utf-8?B?TE1sc2NpaUFrNzNBVi95WW13YzFhWVV6MGk4dVBWbGlnc0IySzBDMmZJUGZo?=
 =?utf-8?B?VWs3M1JDOTZBPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9867
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01b034c1-4c5e-4a04-fd7c-08de0840c820
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|35042699022|82310400026|376014|14060799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzdvdGp2dGJDWTkyZmcydU9CWTVQRUxxM0F1em14SmxaNVFaK2EyVlpWU1RB?=
 =?utf-8?B?M25TU3owTWNKYkVVaTVmbmVSNWZVR25OV1lxWXo3cmVYYTBVK3AzYlF3bG1F?=
 =?utf-8?B?eWtYUEkyUFpQSXh6YVhXZ01vTDNHT2lJdUJVdVZvZW8zZTRXVEZrVXVPNExh?=
 =?utf-8?B?VHd5U0JLUndwb1VxQzhaOWZVbHcwb3FaK3h1TG1Dd0dMa2V2TWU2R0NSN3A5?=
 =?utf-8?B?OFVxQnJlRldON2tVeGs0WlNyWncyTEttMU42a2NaUldzdmZwQTlTR1hVZVJF?=
 =?utf-8?B?RlFwUVJxa216cytCcDlwQmFUYzlSYUg4ckV2ZzdqNm9HbFcrQS8wYnpPTnlZ?=
 =?utf-8?B?MEdpeTBNOHpnaklFWXNPaDA1bnNEb2VyVVBsMVZZdXU0Z0h2eUFtb2FETlor?=
 =?utf-8?B?cWs3dnIvcWp5Qkp6M3IwUjU2NGZUTWIxbVozMkFFbFJwRFJjMUdtWE9kWkZ3?=
 =?utf-8?B?Unl4Mmc3Q1ZudHRBaytuOEg3aFZQVTNXcWtEZkJhY3VhMTJ3TytnYU15d0pY?=
 =?utf-8?B?NTZpSDZOcmFtTkFqUldMNTdteGVaTkVGeFJCcnVBZCtna25tMkZETzJIQWRK?=
 =?utf-8?B?WVRyeVpUcFAvcFFwT2RBZUxuL0JraFU0SXRyK1RHc1daR3pFMW9wbFFyZlBJ?=
 =?utf-8?B?N0VaUXoxcjFSRVp2aGxab1BsWmc3c29ucEVjU2U4NnRFMEVCdVBoZ0RndHA3?=
 =?utf-8?B?UTlYMDNrN2N3amd5ZVNQVTJhVnNCb2xaeUdyWVZ6ZzZRRGRhMWhPNEVNcGlT?=
 =?utf-8?B?bXZuajdpdThzQUltOHZxd3B1eldZbk9UbzcxSi9NcDJDMTRrRGZNbUNLZmxH?=
 =?utf-8?B?enpLdXZKRktmZloya2dscGpNRUtFM0NUOTJQRVBhblhlN05hN1p6bkZ3ZmhB?=
 =?utf-8?B?VlNIQ2piVGlVcHNoblB0SkRtN3JXVGtMdUpNNkk3RmR6Q0lKeThWaUFLb0Zl?=
 =?utf-8?B?Tm1hNnVCMkFsWmRoUzJyRUJZNVBiMHBKZEJXMjMvWEFBaVFrOXN2cG9zelZx?=
 =?utf-8?B?bVNGdkdNWHVVN3BEcjBMdUtEN1J6SHYvZkw3M29MYllscFkzLzRRd1ZaK21T?=
 =?utf-8?B?OVRWckE5SEwwS1dzNm1JajZwdXVWUDUxWFZGZk9iYzAzdUYxUlhOVG1YRm5l?=
 =?utf-8?B?WmNqWjUwZzUwdXlMUDFKTHZQQno0K202UHptSCt0blVYM1FuVzVLamlhNmNx?=
 =?utf-8?B?M0xxcXYva040elJFeVJKL0twRjAxeUh2ckxIemhEZDI3VndVK0haZHRFZXN2?=
 =?utf-8?B?bStHbEh4b3dvZVhMSlFiT0w0NHFIZkVvNHpkcEkwUVlQRCtqWGRkcVBpVita?=
 =?utf-8?B?TjNPRmI1LytObCtMWi8vM05uclBVQ2JzYlZYTmd3amRnb2orUTVidzQxWDdm?=
 =?utf-8?B?YjNMQkxrclVwc0NNV2FjWHFLMzFQaWd2aU9XMTBZaldqcDBIaisyTjBVR2tm?=
 =?utf-8?B?MG9jRGlmcjNOOVZrQnhzcXBSamZ5Y2JMQTlSVDh4M2ZYbDhxWCtCR1VNREdl?=
 =?utf-8?B?cHF1SVU4Szh0REIrWFkzYStHamhZR2xKSWtYNk5VY3RNRXNTbTZ3QjJ1YmN4?=
 =?utf-8?B?bVl5V0tIUDFaZXZtTThibDNJMlpZUU1LdWUrSzBVcE5Qc2kwVU93RmJ6NDVt?=
 =?utf-8?B?aTN5R3p2S0VGRDErcHgxSlVZU0UzeW1OVkE0SFo1QlFrbzN1UlRHRG5IS0pv?=
 =?utf-8?B?clM1ekZyWWEyeG5lblA3LzJCbzJNNURkYnZ4SGtGb1JPMGRSMkZ5c25RK2Mv?=
 =?utf-8?B?V3NMbGtQR0xqNWUrMUlYd0hOZ1BycDlXK1FPSHE3YjZUZ05xRnRybTByQnRs?=
 =?utf-8?B?Q3ZUQTdWYXhVOGpxL21obHRSMktaVmIwNTAzZnF3enBtcUNzUnYxcmFyUUlP?=
 =?utf-8?B?OXVXclk4b2hIbW8wZEVtaE9KYVpLb2MvU3lycWhaUXgzbFRPVXhhbVZxdlFO?=
 =?utf-8?B?SHFKbjl3ODFjUnRjbHBFQWNuRDBtdlRicFlHSUd0cFprZnRRYVF3Zkd6d2F3?=
 =?utf-8?B?SE1Kb0dvQzNTblpHaU94NTNlU2x1TXMxZlJ0YnQ5SDNkWnZaUjRYY3JhWjZo?=
 =?utf-8?B?SzdRaHI1ajA5dmlQQjd6T0JHbTB1UnBTMXJ4NTJFQkowR05wb3F5RWdJMVFE?=
 =?utf-8?Q?fGmo=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(376014)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:05:50.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d771814-d7f9-4c0d-9de0-08de0840cab7
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10694
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

On 10/10/25 16:55, Sean Anderson wrote:
> On 10/10/25 16:31, Tom Rini wrote:
>> On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:
>> 
>>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>>> not allow for file sizes > 2^31. Fixing this required changing the
>>> signatures of the functions smh_flen and smh_read to allow file
>>> sizes up to 2^32 - 2 and also being able to return errors that could be
>>> tested for.
>>> 
>>> This issue was found by Smatch.
> 
> IMO this makes the API more awkward for no benefit, as no one actually
> needs to read 2-4 GiB files (but no larger) with this interface. Aside
> from this being unimaginably slow on real hardware and inferior to
> virtio on emulated hardware, there are still other problems. Like, how
> are you even going to address the RAM on a 32-bit system? U-Boot
> (AFAIK) only does a linear mapping and most highmem systems will not
> even have more than 1-2 GiB of memory without mapping over devices.
> 
> I think a much cleaner solution is to just limit lengths to 2 GiB where
> appropriate.
> 
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>> Changes in v3:
>>> - V2 missed fixing up one use of smh_flen, fix it
>>> - Link to v2: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv2%2d1%2dc1783e4188d8%40linaro.org&umid=65083f76-83f6-4254-a979-8e43c1e3a788&rct=1760129739&auth=d807158c60b7d2502abde8a2fc01f40662980862-31b6b7517dcc163c67b790b33a34a4f0a3f321b7
>>> 
>>> Changes in v2:
>>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>>> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro.org&umid=65083f76-83f6-4254-a979-8e43c1e3a788&rct=1760129739&auth=d807158c60b7d2502abde8a2fc01f40662980862-38e52356997cde7f2ae1d272bd8f35d6bface016
>>> ---
>>>  common/spl/spl_semihosting.c        | 13 +++++++------
>>>  drivers/serial/serial_semihosting.c |  6 ++++--
>>>  fs/semihostingfs.c                  | 23 +++++++++++++----------
>>>  include/semihosting.h               | 13 +++++++------
>>>  lib/semihosting.c                   | 25 +++++++++++++++++++------
>>>  5 files changed, 50 insertions(+), 30 deletions(-)
>>> 
>>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>>> --- a/common/spl/spl_semihosting.c
>>> +++ b/common/spl/spl_semihosting.c
>>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>>  			  ulong size, void *buf)
>>>  {
>>>  	long fd = *(long *)load->priv;
>>> -	ulong ret;
>>> +	long ret;
>>> +	size_t bytes_read;
>>>  
>>>  	if (smh_seek(fd, file_offset))
>>>  		return 0;
>>>  
>>> -	ret = smh_read(fd, buf, size);
>>> -	return ret < 0 ? 0 : ret;
>>> +	ret = smh_read(fd, buf, size, &bytes_read);
>>> +	return ret < 0 ? 0 : bytes_read;
>>>  }
>>>  
>>>  static int spl_smh_load_image(struct spl_image_info *spl_image,
>>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>  {
>>>  	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>>  	int ret;
>>> -	long fd, len;
>>> +	long fd;
>>> +	size_t len;
>>>  	struct spl_load_info load;
>>>  
>>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>  		return fd;
>>>  	}
>>>  
>>> -	ret = smh_flen(fd);
>>> +	ret = smh_flen(fd, &len);
>>>  	if (ret < 0) {
>>>  		log_debug("could not get length of image: %d\n", ret);
>>>  		goto out;
>>>  	}
>>> -	len = ret;
>>>  
>>>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>>>  	ret = spl_load(spl_image, bootdev, &load, len, 0);
>>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>>> --- a/drivers/serial/serial_semihosting.c
>>> +++ b/drivers/serial/serial_semihosting.c
>>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>>  {
>>>  	char ch = 0;
>>>  	struct smh_serial_priv *priv = dev_get_priv(dev);
>>> +	size_t bytes_read;
>>>  
>>>  	if (priv->infd < 0)
>>>  		return smh_getc();
>>>  
>>> -	smh_read(priv->infd, &ch, sizeof(ch));
>>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>>  	return ch;
>>>  }
>>>  
>>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>>  static int smh_serial_getc(void)
>>>  {
>>>  	char ch = 0;
>>> +	size_t bytes_read;
>>>  
>>>  	if (infd < 0)
>>>  		return smh_getc();
>>>  
>>> -	smh_read(infd, &ch, sizeof(ch));
>>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>>  	return ch;
>>>  }
>>>  
>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>>> --- a/fs/semihostingfs.c
>>> +++ b/fs/semihostingfs.c
>>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>  			  loff_t maxsize, loff_t *actread)
>>>  {
>>> -	long fd, size, ret;
>>> +	long fd, ret;
>>> +	size_t size;
>>>  
>>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>  	if (fd < 0)
>>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>  		return ret;
>>>  	}
>>>  	if (!maxsize) {
>>> -		size = smh_flen(fd);
>>> +		ret = smh_flen(fd, &size);
>>>  		if (ret < 0) {
>>>  			smh_close(fd);
>>> -			return size;
>>> +			return ret;
>>>  		}
>>>  
>>>  		maxsize = size;
>>>  	}
>>>  
>>> -	size = smh_read(fd, buffer, maxsize);
>>> +	ret = smh_read(fd, buffer, maxsize, &size);
>>>  	smh_close(fd);
>>> -	if (size < 0)
>>> -		return size;
>>> +	if (ret < 0)
>>> +		return ret;
>>>  
>>>  	*actread = size;
>>>  	return 0;
>>> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>>  
>>>  int smh_fs_size(const char *filename, loff_t *result)
>>>  {
>>> -	long fd, size;
>>> +	long fd;
>>> +	size_t size;
>>> +	int ret;
>>>  
>>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>  	if (fd < 0)
>>>  		return fd;
>>>  
>>> -	size = smh_flen(fd);
>>> +	ret = smh_flen(fd, &size);
>>>  	smh_close(fd);
>>>  
>>> -	if (size < 0)
>>> -		return size;
>>> +	if (ret < 0)
>>> +		return ret;
>>>  
>>>  	*result = size;
>>>  	return 0;
>>> diff --git a/include/semihosting.h b/include/semihosting.h
>>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>>> --- a/include/semihosting.h
>>> +++ b/include/semihosting.h
>>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>>   * @fd: A file descriptor returned from smh_open()
>>>   * @memp: Pointer to a buffer of memory of at least @len bytes
>>>   * @len: The number of bytes to read
>>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>>> + *  with 0 indicating %EOF
>>>   *
>>> - * Return:
>>> - * * The number of bytes read on success, with 0 indicating %EOF
>>> - * * A negative error on failure
>>> + * Return: 0 on success or negative error on failure
>>>   */
>>> -long smh_read(long fd, void *memp, size_t len);
>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>>  
>>>  /**
>>>   * smh_write() - Write data to a file
>>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>>  /**
>>>   * smh_flen() - Get the length of a file
>>>   * @fd: A file descriptor returned from smh_open()
>>> + * @size: Pointer which will be updated with length of file on success
>>>   *
>>> - * Return: The length of the file, in bytes, or a negative error on failure
>>> + * Return: 0 on success or negative error on failure
>>>   */
>>> -long smh_flen(long fd);
>>> +int smh_flen(long fd, size_t *size);
>>>  
>>>  /**
>>>   * smh_seek() - Seek to a position in a file
>>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>>> --- a/lib/semihosting.c
>>> +++ b/lib/semihosting.c
>>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>>  	size_t len;
>>>  };
>>>  
>>> -long smh_read(long fd, void *memp, size_t len)
>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
> 
> But really we just need to make this return size_t.
> 
>>>  {
>>> -	long ret;
>>> +	size_t ret;
>>>  	struct smh_rdwr_s read;
>>>  
>>>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>>  	read.len = len;
>>>  
>>>  	ret = smh_trap(SYSREAD, &read);
> 
> This is a separate fix. Please break it out into another patch.

And actually, this is wrong since QEMU and OpenOCD both return -1 on error
and set errno. So you need a fourth branch when ret == -1. So maybe we
should just check for len > LONG_MAX on function entry and return
-EOVERFLOW right away.

>>> -	if (ret < 0)
>>> +	if (!ret) {
>>> +		/* Success */
>>> +		*read_len = len;
>>> +		return 0;
>>> +	} else if (ret == len) {
>>> +		/* EOF */
>>> +		*read_len = 0;
>>> +		return 0;
>>> +	} else {
>>> +		/* Partial success */
>>> +		*read_len = len - ret;
>>>  		return smh_errno();

smh_errno() tends to only be set on failure. So if you call it on
a short read you may get a spurious error.

>>> -	return len - ret;
>>> +	}
>>> +
>>>  }
>>>  
>>>  long smh_write(long fd, const void *memp, size_t len, ulong *written)
>>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>>  	return 0;
>>>  }
>>>  
>>> -long smh_flen(long fd)
>>> +int smh_flen(long fd, size_t *size)
>>>  {
>>>  	long ret;
>>>  
>>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>>  	ret = smh_trap(SYSFLEN, &fd);
>>>  	if (ret == -1)
> 
> Just change this to
> 
> 	if (ret < 0)
> 		return ret == -1 ? smh_errno() : -EOVERFLOW;
> 
> And now all the existing code works.
> 
>>>  		return smh_errno();
>>> -	return ret;
>>> +
>>> +	*size = (size_t)ret;
>>> +	return 0;
> 
>>>  }
>>>  
>>>  long smh_seek(long fd, long pos)
>>> 
>> 
>> There was (as good thing!) much review and feedback on v1 and v2. Is
>> everyone happy now with v3? Thanks!
>> 
> 
> Sorry for the delay, I'm not working on U-Boot at $WORK at all right now
> so I don't have much time for review.
> 
> --Sean

