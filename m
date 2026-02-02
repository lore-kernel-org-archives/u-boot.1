Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CE8D172B3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 01:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E5283BC9;
	Mon,  2 Feb 2026 02:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UMQWc+yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8003683CBD; Mon,  2 Feb 2026 02:43:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F62F83B5E
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 02:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqS6waayS0UQupieDaXM6Ep3/YcgxjqzmAUu/Q1uZxgvu46fqadIueVPJTwF8e56ERyEVkm/QcA1/k6o7nItFjomMOfnbfuHvLI7gNFMUhtIAf7JLM/SxBlUDukBZg/aQxLUE3kGithJld+Enw2hAi1vtRL/VWfLxbmlvF8vvIc0cKMxlmd8m1CQYovBFVxtPLRqDy3+f7Pu5H8FS/C3RNg1B8QH40XPCd0LRbqra8kdbqGFyYvmKCLUTlnXrzwB2F9C0nLlYMGkcv+jyxZ8l6lbonWBI+Pu2K727+pjs+WwsXWFewxoA0H0PsaE7pDGZA7G9tE1oweZ0GbVmADnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvjI7CB6GZn/c2MCTcmFaYsGJBPGZnY9onyJ5ilBED4=;
 b=OSAD2g3x0xWdg93oM6PzG8caJkbdRgpGbPzsTcEIDhVZ4lg38jiKf+BHz5m6X0s/GRcgRgbSBFDDbbaQMJbFWBYrE6TtEzP23S9TiRVJRaQ/KkguA7xpwfdpZHGGaQrstj/xUni9RKmMCaN0x3EkPwoSYP9UcaeBpiugp6VK5Tl/093+I8JuqWPAqawOfsC9WlpqexZVPRuSqz3EdmTcqWQDVgvfqlnlz9+BvgzqjHizIUETsov/JSlHnOn+NVw4pungY5KyzT1q4iEQy6Zk4t4O9srrOPo0a+lVLHWQVK7ijfeAPaI9DdkFUHIpaOI/+QOyKwZSMYfHrtndNYpkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvjI7CB6GZn/c2MCTcmFaYsGJBPGZnY9onyJ5ilBED4=;
 b=UMQWc+ycyHK+oHrm8uHAkKMknBRTKInKuoWdeke6IbjZX99GQw3W3gYlc3RApYEeONB8dfj0pC/Nh4EwOnsfcTOXT+o9EskJxMhnzNj2vLp12quLCpXkiuUF5h8BC+fRUZulju8qTnvb8mWOhE6fz2ETuTY8jRpR542tXNFOMARcOUW1NeNdPE3aIXR0mwDnzjGcyomC99OUSAX/i7GLOf6WuXC4oI5BLP33hx+1XKxGPRN/cASAETcZ8MW1btAkXcujpQqaOcFOqyNw4cjQS7b8luT7QMZ2pGNl9HBhWskxUrkMmNjRJVYNG5PFfJLThvnN1in03oXgGLdNUVRzvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 01:43:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 01:43:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Feb 2026 10:57:46 +0800
Subject: [PATCH v2 3/4] arm: dts: imx95: Add cm7 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-imx95-rproc-v2-3-b85fc7db23fc@nxp.com>
References: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
In-Reply-To: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fc9a63-c605-4825-7360-08de61fc6852
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1F4YW9VWUVnemdCRnpwamdoTnV6SUZvUDllMTU3RnNGR1dBN1dQSlhFa3U5?=
 =?utf-8?B?aEdialdLWGgyaWVNZUFLQk14NGZwZXlFTkJVemJoYThpZko0UGcySWZrZDBJ?=
 =?utf-8?B?RHQ0dFhBamRBR0FvRXVGRm15akZZOVVmTHZycTV0WnZFRG14NE5LTzBlWSt3?=
 =?utf-8?B?djFSSTZ1c3NtTWtlMlZZeUhuRjJaMWhYa1o2MGFLVS9Hc3RhaXpKeVNqMzJV?=
 =?utf-8?B?dFUyMXFXeUpFSGU3VlB4UU8rWEQ5MUtvVmkxck0zeEtuZ0hEMVdPR0EwWExY?=
 =?utf-8?B?NUI4c29hT3lYempwajBMRE53enNrNXhKTnNjS0k0eXVoNHhOSWJIQW5CVk9D?=
 =?utf-8?B?ekJEdWdNczM3MHVXTVhWZHMvdkZKTkxwUGZNWWgydWFra3lra3FQTFp4cWZK?=
 =?utf-8?B?OUwrcFh2U2dSYWFJb3VzLy9lNGprdzREMU4zd0w5US9XTTlFalhMZU9lRE40?=
 =?utf-8?B?eFE3TFVNVlFSSWZTK2ozNUQySUxhWHlETWh2WGVDWERPczZBMFRvMGlHdjhJ?=
 =?utf-8?B?TFVsWVlZeG9HTFc2enZWK2NjZk9sZ3ZHdFJZRWE0ZGErTG40YlI2Wlo1K2tJ?=
 =?utf-8?B?TUFya2ZOZGNGRzh4RWo3YzdLNnlhcDR1RUdjNnRnQ1FXV2Njbnhpa0tZZ3Y0?=
 =?utf-8?B?Q1B2OVBtendFZW5RdlNKN3Nib0dsYTlhYzNjeHJZU3A4ZS9YWlg4cE5kYThX?=
 =?utf-8?B?UWhxUktzSXlxS1huUFlzOHVnbUJXUGlCd2EvSGVOWGJYYkxKbTdlbFE4Qy9P?=
 =?utf-8?B?cmVIM2hiWVA5M1E0bzI3a2JxMmZZR25XYmgzQnpUYmpDanpHZVdPS0E4dmFU?=
 =?utf-8?B?anIvTE0ydHJYT3Q2RE52eHdqZ0VRT3RuZG0rNFk0RzltdDhwRlhROE9HVnFC?=
 =?utf-8?B?aXJidkc5VmFEMzRaVnNoT1pDN1V4eThVWDZUZWNZdDdma1ZrcTJ1TUpJZ0Nw?=
 =?utf-8?B?SkN2ZEtCVU1YZDBHblplVUVBNzdBblUwQkEzVkJaTjN2a0ZWWG9KZTVjY0M5?=
 =?utf-8?B?TGMzOTRTTCtvaU04SzhYaWpZTXplUXkyL1VIZUQ3ZWI4YXlBaTRMWmJsd1dl?=
 =?utf-8?B?MmVwZE92QVloVkc0UkpML0w2VEFrUEhhMnhQZ3Q4ZnI3WFNydGhDSzRjTnhI?=
 =?utf-8?B?a2dsNXlCbUtscm5aQmE1Vk9Qd3ljellySktBNHdRUTBodFRRY0tiSmRZbklq?=
 =?utf-8?B?UUN1Q2NvOWJVQURxV0FKZGRhdCtObEkzVEl3d0k2QUkxelNyaXVtNEU0am9M?=
 =?utf-8?B?ZVBtaTFlR1p5S1JlMS9EWFJ5b3Q2aU1iWFJXR2k2aEdQbkY3M25sYlFFTjhG?=
 =?utf-8?B?aCs2KzZoU0pmZ2dKQnAxMW5rNll1UUVtUU54ZjUrQ1Z0ZUJrS2RZSUtoMGZ5?=
 =?utf-8?B?S0RobjVxc0VIK0IySnlHaGlybXlOcGRzVU9WVXYzajVUdXh2TyswZmswN0Mr?=
 =?utf-8?B?THNQaUN1MzdUL3NVQVFXSDBQSEtmVld1RWxrSytENk5NemcxTFZlM1U5bytY?=
 =?utf-8?B?WUhiZ0NWZVV2SXc2ZFpRTFRxZmh5RzdJN3dlZ1JhSWF1ZTcxemFlcnRZWjFQ?=
 =?utf-8?B?SzZydjJMZlZtVTR3ODlBay9kZVY2T2NLRmRDdFBNR2s0aXdCb3g4blFSa1J0?=
 =?utf-8?B?dThRUmtJNSttR1pmbUlZRUdOK0pJdlN4aWNPVGlUYVV3R1BObkVYVXJzeFlv?=
 =?utf-8?B?b2N6K0pUSm1yNGtXZ3pmT2JLajdiSUluSllqQU16M3BaRWp0UnZCQjA0TGw1?=
 =?utf-8?B?NmdSOHVqM2p1SjRjbENSMktzQUhHZUVyY0poU0dhWkI2Q0laOHYrQ3FPZmxW?=
 =?utf-8?B?V3h2RjhrdEF3elRab01vQkk3TzBoSkZVUTc2TTlHVk9VZXdpRmlHK3VIQ0Zl?=
 =?utf-8?B?VGRDakdvVHBiUzJFejFqYXFDMm83TVF3Ukk0THlBUE9hSE4yeEJOeGdUVmQr?=
 =?utf-8?B?R2hKN0gvOUJNaDhMMjJuZVVEbDRmVkJ1Qjg2TUNIWHFjekhPNEJjd1dKeE9p?=
 =?utf-8?B?b1Z2YnBObjRrY2hPTFVBeWNldy9LZmVnNm9IU3E0WXNjaGxxazlDNmczeGM2?=
 =?utf-8?B?ZklPNkIzNjdPQ3hmY1J5cGl3UTdESnhvSGp3UzZLU0pJZk04UHJvVVF3aVBH?=
 =?utf-8?B?OC9QeTQ1V01sUkxlSlhxOTRyeHJWNmtzNmk1L3lzZEdoOG9Hd0x3Q0VJbzhE?=
 =?utf-8?Q?Hj807HYLj4c0u9+RZw47L+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlSa1FBOUhHdGR6dnl4ZCtyblZXVWdqTVFUSEVSQjA0VDNLMHZNUkJqQnJP?=
 =?utf-8?B?dmNWTkM2OFJqREpuZS9yT3RScTJicnJTb2U5elJyd1VHRmExVmJLMFh4NGNK?=
 =?utf-8?B?TlpLREVkK0d6SWYzZGdQQTB0ZlVGUDZ1Rmo2UC95OWZhR08xR0xVZlh4TGRh?=
 =?utf-8?B?ODRIdUwrUWo2TFRGdXByMXNyckhmMmgxbmFPcnNMcTI2ODdtQU5yTUtxZGU1?=
 =?utf-8?B?NUVDdHdmdmtjODZLN1JuSzRkTFZHTi9aVG1ycUp0MVRBSGw4b25VOUc0ZW9Q?=
 =?utf-8?B?RE5RZ2tXUXdlbjViNEdkMmFaNmM1K1lyZUVEK0xYd084NklGaXNvRngyZEZ4?=
 =?utf-8?B?ZmFuTmI0MTRsbjdzWWdRbVFCWGxOSUp4QzhiaENUUXExVy9ISFNRTUZyenZz?=
 =?utf-8?B?ZzNkcXpvWU01dExuOWFlNGhIWmUralpJZEpwYzQxbkdYQ2FQWHBDR1JYMnln?=
 =?utf-8?B?RVFjbzZhbkhVa04wVWpydGtXQzlWVFFCTHlEWmJFREpMaDdIOE9Yb21EdXFN?=
 =?utf-8?B?c0wrWTY5elF0aFVrWTVET3ZEbWljVFVTNWNSKzljTzJoWUYrWURtQnE1bXFp?=
 =?utf-8?B?QXMyVHFDcmtUNEE3d0JjYkJoZW55MTI4cTZPMXRzeFRVY2hzTFBJcjVnaXpl?=
 =?utf-8?B?c1RJWlcwMnZwSzZtM3NudHJreU13V2owMXR2V1dXYUVob3pxMDNVZ0h4K3px?=
 =?utf-8?B?cmNtKzVQKzk0ZzNjWXVXYTBBTDBHY0FJUEdFb0tyL01OM2FtUUZnWG1ZTlNu?=
 =?utf-8?B?TVBrWnpkWERuZ3pqbXBXUENoa3lKOElIbE5SU25ueWU4ckR0MzcxVnFOOFJ0?=
 =?utf-8?B?VW9iRU5tN0RpSm5MMzk2NEJVSnBqNlpwMlRYRkRrQllFZDhnRHdlaW1INnlS?=
 =?utf-8?B?NVIvUlNLUDNKVVBXeU52Q3p6ZElRT3ZZSDhDOWRtMVlTbDA2U3k2Y1JLaUxn?=
 =?utf-8?B?clQvVHc0Q3Z5WE0ySURYamZUZVBjVXViODU2K2RDZWZ0a2x4SG9oOWZUL2ta?=
 =?utf-8?B?V2Zoc0lyaUY5T1FubmV6MXZ4N3VXb0RtVUNYUitDSnJjUWlSWlNGRjFNZzR3?=
 =?utf-8?B?d1ZEOUZLQXpEcXJXMk0ya25LNnN2bEE4UEhSeHlwS0VobzF2YVp1R3F5Ync0?=
 =?utf-8?B?b3Q4QVBuZjA4TjRDQ0FOYldEVU1GRVVEemNpbkxiRDJJanVhUDN0dENBOGpI?=
 =?utf-8?B?MFpwc0hDc0ZReXc4Ti8raG12dE04R0ZyU3grMEtXTDdLYThvRFl2K3NZdnNK?=
 =?utf-8?B?UEJFWEdqdlgzVHZSYTA5ekdUOXlWYzdkVHVESkZSY2YvdnhpSWpZbTJwQ21r?=
 =?utf-8?B?dndtMDNNL1ljZlg2eVZDNkZEbVhHWDQyc3hDRTRXUWV4WmtJTGdxZTNVUEhL?=
 =?utf-8?B?SFI3d2tVMEUzN3kyWnFPTHR2em1ZdzlBNVZNcWtMdm1VMk5rSHBsRzRGRXNn?=
 =?utf-8?B?Qnd0dkRDS3VBamtRWnB2WHZ0Qm52QlhvcVVPQmZob2xXTWdhZ2psb1p2LzZ0?=
 =?utf-8?B?RktrL3BTS3BKY2IwU09CTG1aY0w4MENsNThVcjA4c1JRdW8vVGYvdUtRYXBt?=
 =?utf-8?B?SU1kZVRzS1p4ZklvM0lldzNoTHNnWWVWdUpYdy9nSFd4NEVaWHZ6YTY1NzRj?=
 =?utf-8?B?ekFuazRGU1R1cGZ3T2pHTVdrMTU2ZTJyWFdUL0dKNy94N0h0cDd6UVoxYkV4?=
 =?utf-8?B?UzdGVWlTOHhONXNZWm1VdUhLeE1pMU8rTFoyZzVIaFFxQjJHMnh1RlhTclpn?=
 =?utf-8?B?RnFWK0JmeVE3V2huK3o4WUdiVDk2MGI2eTZNVHlXaUN2d2dETk1mdWZRUmtQ?=
 =?utf-8?B?WWNKeTJ3aWw3amJ3Vzd2ODkvOVJYclRwajVmdThvTmxNNEg4cnhoU1BXbGJy?=
 =?utf-8?B?TnNIKzVveGRtNmw2cXhYc0h4SkhZNUhGaFlIWjBQVWltem90cnpGZWhOYm9B?=
 =?utf-8?B?Z2xCZnM0SlE1SHp5WTJxOEUwamlhMzduM2ZxTlJ6VjBvUldZODIzZnBOUU8x?=
 =?utf-8?B?UENjUnFBbjRmcjAwRklPTzEzVFNidGQ5M3VXN0t4djEzWGd3RDRJL29qbGxT?=
 =?utf-8?B?Ny9kMXJ4bHd1b1dkb3lRN09SVnlGNlJJRGlQTHJYenNBY1VCRnhWRCtyTitW?=
 =?utf-8?B?T1dGN2l5dTN3Vk9zZkFUZFZ6c0V2d1NlQUUvclkyekNwQzhsdkdGV0p0TUh2?=
 =?utf-8?B?d2FaRzVvc0hzcWUwazhZVVJWSm1sQTVSTmUyRDdzZjBqcTJrenZqUElWTytW?=
 =?utf-8?B?K0tLN2pSNGoyYmZ4aktrOE9Md3JDNTRrb1ZhbVk5dFBmazM5VFl5ZmlIR0Vh?=
 =?utf-8?B?WHdVdlAwQUVHdlVwaHVSSzJ4ajNkd2dqYnZGQnRMSm42V21XNGxwUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fc9a63-c605-4825-7360-08de61fc6852
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 01:43:04.7829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTK3pWgVVIJa+D3TDCdm9Ag9iFrRjU8MtyvtfKThJm1A0wbpEMpJinm3swvAFy0fP73dVI2xuzULcBB6DrNGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 CM7 node for remoteproc usage. The dt-bindings for CM7 was
accepted, by the node has not been upstreamed to Linux device tree.

Put the node here to let the driver probe. After Linux upstream repo
has this node landed, the node in imx95-u-boot.dtsi could be removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 591cb317508..6dec159752b 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -96,6 +96,10 @@
 			};
 		};
 	};
+
+	imx95-cm7 {
+		compatible = "fsl,imx95-cm7";
+	};
 };
 
 &A55_0 {

-- 
2.51.0

