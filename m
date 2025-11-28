Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96D8CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 782C68459A;
	Fri, 28 Nov 2025 15:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f143PYpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61A483BA1; Fri, 28 Nov 2025 04:36:40 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FDB83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 04:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMt59ACjWq2oRWqAmKEPNKB95vSv9whm1LY7xE9kcGArRZ4zLkM2ICteXsZgxxCI6PsrgY3Yh8s0BZImWtuixrEIgEqpdB7BoO+y2W3B1V2/z3oBPQfbSa5lsT5EvVrD/7pVB9KpnMXOEMj0Eu8WkKuVS5tX/58mIKuWA62vY/EphAdd5vmsFaR2zUQJNxhED3u317Bjk/4Stx1ujhYRlZa9eGl7nA6cid1FlO2HdlqbFxKcWSkhyqh4Gm+uDoF+R9YQxmslykotZFUDFv8oRPRjaGTmd+i1govYCK1+EXoDvdi3DyZY9LYRjFoG+z1h8Hgkq7sTmjDlEKGov5X3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7g/mOJbXKyZ1h/KNXnQRFgJCYsHC3eqx8IcCBL0i0Y=;
 b=t26nAK+HKdSGh/+dD47tB10XXpseJe4rjMIAOEi0IWzIa0+r52TbKUOrxpOfBxDtwnjx3Cm/OCGvhPg7DEPNDbM4w8L9PBbwHwAJgTxWY8oK7BszKQzzl9xpg2AV4aIwJDLnrGdzcIvuDCA9PsevJxu+HIMdO4J1ETjBWSSqGYgyQRW1KVfg4ZnQG64x+POB/JdndE8mYEsWgzfWjJt6SuT7mE8ekevIFHrRq3FcgSwwTyzJnLBlX9S4MzbBElBLb3NnP3ShzoNu2r5fC8YeWnKp7BA+7O8ew+p/umfRwHyJMzswEZM45mR2HJN9XdlFqI9fXCPC9ZWN3Ii5UQv6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7g/mOJbXKyZ1h/KNXnQRFgJCYsHC3eqx8IcCBL0i0Y=;
 b=f143PYpvkRHsFTZBX81Df7h/uLZuUFfLrl+ZqkmvpgJ9Q7eOasldqYDrOC9qVqgRspA/nAphcBggobEJtuDDuvjYQoYnNbl2i9onDWyj269F+9c/b5jVycQjoD6HWMRDdjuoMihSmFR9faavB4eligXpb/Y3yDDBMJAdvdVPKZpNCXuj1dp+TXADNGCJFkRvZLQo62RmTj3cWPuMe7jqp9o8PKS5/mMIZDKqcgkG7st6VjtH+Daz3TylQLBqTMxno21psl96/jJMYyF7KmM6tsttEGPkycuG45LyoGr0l/oH6guhLrh3Fg6sOqN7bckbSgC76oeqr4XntmGQdgB2Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB11474.eurprd04.prod.outlook.com (2603:10a6:10:5de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 03:36:37 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:36:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Francois Berder <fberder@outlook.fr>
Cc: Peng Fan <peng.fan@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] board: freescale: Fix error handling in ls1088a board
 setup
Date: Fri, 28 Nov 2025 12:49:34 +0800
Message-ID: <176430530393.3808119.11396643388302925745.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <BESP194MB28056C2655479914772DF6BFDAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28056C2655479914772DF6BFDAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB11474:EE_
X-MS-Office365-Filtering-Correlation-Id: fd77c1bc-85a7-4d57-475e-08de2e2f5523
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdJLzJZTGZBRlVXQ0VGYi9OSnJzOWh2L1NsY2F0SXdsT0t4dUM4cUJMcW9N?=
 =?utf-8?B?V0pmVmFaQkRSWFBCSTgxdmdOcFpwWDZUMjFjZDdEVStmWDBocjBBUDVTdGxJ?=
 =?utf-8?B?ejlOOHZqcVAzNUlhZkhjVnEyMU9sL2FsdnRtYjU5Yi9iZzFkd3pWZm1IcVVl?=
 =?utf-8?B?SG9WMUcrRFpielRjdEZYOGJWNzBhekJWaityTWExVy8xUXMvbWdDRHJsTmdK?=
 =?utf-8?B?N2pvL2svSGYrSGUyQUJVZEhrd2FoYWorYlVUMW1WbE9wSzJUeitGbGtlUE5n?=
 =?utf-8?B?SFhPWGZ2eFhsb2l4M2hvdUJ0VUNjY2NsaWJPQjJNc2RxTDlBZEM2NHZibkJw?=
 =?utf-8?B?T0ZWeFBGTWpsSUhWRDFGK2t0RWpwSWRPOEV3eis1cjQ0b0o1UEp3U29WSkNh?=
 =?utf-8?B?RTd6K0QvU2pLOTM1dGNDeXNOQTc5L3NYMU9XRStpeGVXbUlocjBNZmwvTlpv?=
 =?utf-8?B?cm1FVytrWjhybmJSaEhsRERSTEl6S1NGQWJOUVhoZThIVE9kY25LVkMzWXZQ?=
 =?utf-8?B?WkovanpmVTdLVFU3Y0NWRHBjemppUGlJZmxlRUNFSXR5QUVLdlZJUXJGRGJt?=
 =?utf-8?B?eGNLMzQxQ2xPdkF6Z1VDQkc3L2QvdWNPcVc3K1Vva2pXOEJoc0psSkE5VjZK?=
 =?utf-8?B?NEM0Vnp5Y3J6OFN6L1RuTXlsRk5SN0JFNTU1YlJqUW9ZTGlTSkVUdEJDQjFp?=
 =?utf-8?B?Z3Z2M1ZYOEZxR3lzdXVyMS9LQWlDbC83MU9DMkY3bWF6bEEyZmxETG05Nm9Z?=
 =?utf-8?B?RVlFTXJNMStQYXVkY0loOVVhZkJXRnRNSUtZeldyZ3djUXRPRkpnbksrdHMv?=
 =?utf-8?B?Zzd5dFI3RFkwK1VDTUFDeXpkWTJWOUp2bGRNTDBnbHNUcFp2Wlo5TUFhdG9B?=
 =?utf-8?B?cW5rT0RCNTJWOXZYSzhNcFdOSEx2VHpYdWh1Z1JEMGhnU044T3hVVGsyYnlQ?=
 =?utf-8?B?ekhNYmlvOE9zejkxSWpLVnh2Z0N5OVRIZENKaWpJRWhJbzFEN3VoZUpoS2dU?=
 =?utf-8?B?VWN0eDJ3czZTY3MwajdJQVVIT282cE9HSCt2MXBKTU1nSXpMZzE1cFFpSkZs?=
 =?utf-8?B?c2ZiQitmeldBWFNCVkRtYzlUYTBTcjJMajgxVmxET0wzMS9wNXpnV2VBSFho?=
 =?utf-8?B?NTBGWHUyV1NIczdjT3NTRFlhRXJCS1d1a1dsc1Y5Y3JuTjJNSi9HMlRma0Q1?=
 =?utf-8?B?STFNRzNXSjArdG9hTHRQQWRtM3VPYU51Z3plOE1rbGdyR3UyeUF5Ym9YeStB?=
 =?utf-8?B?dnVXbkdOT2EySUxtTlBORncxUURZWWtpSGpUZGxUVFA1aFhZVFhWV2Vsb044?=
 =?utf-8?B?a2Zyak42Q0Zob2tIUlVoUzdtMTFQNTQvbjF3am1jSWlta3V3SGsvekIyQk5H?=
 =?utf-8?B?eWczTkxTSUlzZ1pTNCt2bDBlSmFrUWJyOVhGbVpYcXMyUVFLMjNmVFN0S2lI?=
 =?utf-8?B?eUczbk9xQXI0UG1zcWt3eGJ6QnJjQ05DK2dSSEN1TGplSHMzTmtNU3lwZmhT?=
 =?utf-8?B?LzNTYUZ0MjRlRlBTRFJrZE5EYXRaNDN2TU1YOVIva082ejh1U2VHU1lJdTI4?=
 =?utf-8?B?c1VIeno5ajl6cjdDVXNOYThUdGZTenR2RnVTbnMvV0xseFl2ZnRBVXJ1NXlQ?=
 =?utf-8?B?U29ON09weHFRZm8wcE5LMFh6cWhjSHZaQncreHZjaGRYdTZxV0xPaUd1c0p6?=
 =?utf-8?B?aFd5eENidWFKSkJTU3JsSlZTNWxJLzhnMGtrRXBBTk1CM3FYcWhiL0c3OE0v?=
 =?utf-8?B?eUJVc2lWL09sS0VTZ2tkYkU3ZVh4ZFc3VjdFQXhKdE5GY1lUK0J3VkxZcUtS?=
 =?utf-8?B?dEZIM2YyUzMyRkZ6QzVwOENuaTd2VE9XektQTytGRm9aeHVZaGRlelJxYVd6?=
 =?utf-8?B?R1NHWk1UZUF6SWxSbnkyRWdjNXN2RUxld2svVVNtcEJEUXhLb3NVQllQR1E1?=
 =?utf-8?B?YXFBWmZwc204ZGJNRTM3VVUySUpPcnBsNFc5S2F3TGNHdUVrT0FwN295ekgw?=
 =?utf-8?B?a1YwVnIrZlg0dHRKMzlOOGcyZWJFVHZKbTlmQUx0N25WL050ZUV5K3FIOVdp?=
 =?utf-8?Q?QbsScI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUtla0RMc3BhN3Y0ZEVjY0pXN3BXOG9RYjVwWUx4T0xTS24razBPN1R4SHMw?=
 =?utf-8?B?Y1VxYk5DZ2NaWDFTV24wMks0Y1hqTDZvK1dnVWNEamNvS3V3ZGZzWi85Mmpy?=
 =?utf-8?B?K09HK2RzTWdiSzlzNmxtT3NLR3VWYk9IMEpnNk56U1VtQWRQRGhXYS9MVXJR?=
 =?utf-8?B?TjNpbGEvOVhOVnJCalYvNmVVTUJ5bkJSYVkxUTU1bDlVWXBHc3JzNFRCb1dZ?=
 =?utf-8?B?b1Zqdit0KytrdzR0VmVCZGF5YjR2N2t5TzNrQ2twZmIzN2JvRXZMRDVZL2ZY?=
 =?utf-8?B?UExCanJnS2NQUDFFU0gwWnBERFRXN1hnWFlsMlVkdlJRREFyUHBSVlBEb2Fw?=
 =?utf-8?B?US9LZjJOZjU0SUorM0JrMzl2SkxiS3ZlOUZ0cTJBMGNyVDI1MGozNFFIQnlD?=
 =?utf-8?B?SzE4Q2xONTMyUUpzYW5LMzhIc3dHVnI4SnpCNzFDSHhoS0NpakkyckdKSW1G?=
 =?utf-8?B?MW9EeXJhYlZlbGNLdmIwVjVhb1VhN3pUb0VCUGZ5QndGVk4rZ2R6bmNMRVdW?=
 =?utf-8?B?RTlFS2FnU2lSSVBQSUNUYkRrbWVhaGJOcVJvdmE4MklvUEZnRDlpYzJES29q?=
 =?utf-8?B?UHFUSVRLbTdVQmE4SXo0a0tycmFDYS9vQU1aV1pOUGI3bXJ4djhvMGRjR0pl?=
 =?utf-8?B?N0pQdmw4N1QzSlRSc3NybW81ZjFqWmdaNDVzVVQ3MDM4VGd4aHNuL2tpTlNH?=
 =?utf-8?B?NzQzRHg5R3ByMzFaam5NQ2FOd0xWUnp2aXQwSTJFYXU0ZDVITDJYcXNxSUU2?=
 =?utf-8?B?YlY5WG1mVHZJaHlXT2NLSUVVTE5IdVBhK1g1ZXdnZ0VwVUEydjhpdUYwWFN4?=
 =?utf-8?B?VUFKWWhHNi9WbVgwRmp1OGF0dWozVjR3dXhvQnE2anQzbjYzM3MrTU5PdWRx?=
 =?utf-8?B?TnFMSERGS0dFREV6ZUFzd01ha1I2ZFloUzR6eThydnJRYnh3MVJzd3BvN25p?=
 =?utf-8?B?aDN2REE5SksrdUtxeVpDd0VJK1Q0azB1cENGYjZXb0tCcXFlVllPMHNMOWZM?=
 =?utf-8?B?aFo0TWVHYnVnTkhobTgxMU4xWVBDQ1V0aUxPT3Bya1djUGtCRG0yazdQOEhv?=
 =?utf-8?B?dmJReFM5ZUdLMk1oRWdqbldHTzhKc3IvSk5kM0RtQk9pN0xtV2E1N3V0V3VM?=
 =?utf-8?B?VzhpdkVWZGtpQWN3VThPeWdqNE5ZUkJERzNYRUtkVk5mand4UHcwZ3dPK3B4?=
 =?utf-8?B?dVM3dzlnSnhJdEZNU3BoZHNyQzBINzZBT2NwUDlmOTdxOE1DRlAxdFhlNWpx?=
 =?utf-8?B?bFF3Qkc0YkdpbmJhUDh1dG92enIxalJzSUdleFNFUG4xcVBJdm1TUTJlMHkv?=
 =?utf-8?B?MWphTWdRRk5lTjhaNk5QejFkWThmZWdFVytBcE9qYzJqK3g0YVBmUnhIYitr?=
 =?utf-8?B?REU3K3VUQ05YL1pUT3AraDZlZUY5UVN1WGpkZkZUVTdvc09RcEhmd01UOFRr?=
 =?utf-8?B?T0dWMmNJbDNBVVF4a1ZXOXpWcjhtRkZLaUJnM0l5Q1JqK1JISmcxajYrUTU0?=
 =?utf-8?B?alVHNjFvNVo2N2JnR2hyVG15Vy9GU1EyMmZKcTh0TmZlYUlNNzZGSzVLam4r?=
 =?utf-8?B?SGhUS0l0cFVMZ3RnbW9BNnM1bU43ZkRPRjhZN3poNE5UNUZFQXhKazREYmt5?=
 =?utf-8?B?TVJFZWM4cWhYOEJWNDJKL2ZuQStPSm5PbXhYTGdPajVTS1pzSEREQmdiZ1Q3?=
 =?utf-8?B?OW1QSjFybUtvR3FnTHdaaE5CVDhxVGM5UElOYVlFVWdxOUlpeGgrUjNjMytm?=
 =?utf-8?B?QW13TWxTMVI4bElPeHc0VGZET3poYlFzSDZQMFptY2tXSW9oSXFUODFYek5s?=
 =?utf-8?B?NXRGeFVnRlFFTzVtUk94cENtUmJka0RjNlVxald1U1RzTlhHZTZuZVFYMUtJ?=
 =?utf-8?B?SFV4aEhNb0F2ZWdDY0lGNzBVTjBJdmxsSTRLNC9ub0YxWG1ZaUZWT1kvOEpW?=
 =?utf-8?B?cXk2WjVlZDlnYTFZc2w2OCtYVmxsWkZjNXRYNEp6c3J2WGlZaFBLWWhRdU9X?=
 =?utf-8?B?THowUVhyQ1pVSFgzcTlHQ1NkU0xNZVZwQmhNbGVhV0hUNFZhNExxY1lnN3BW?=
 =?utf-8?B?VUVoMXI5TENRYWpnQlZRb1dYN3IzZUw5b0lhSk96V216RXU0RUJMN0cxU3Br?=
 =?utf-8?Q?o+hDhIQfQZb6KKALBUPdla0pb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd77c1bc-85a7-4d57-475e-08de2e2f5523
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:36:37.0066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEHa38sxUt+/vDYFHvYVxf6bGNz4+kCXDg9gHTwc2IOzCChuZedGXY7I4Bb5RNUuI1bBtbAlsN6v8TiScjWLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11474
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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


On Sat, 22 Nov 2025 13:26:07 +0100, Francois Berder wrote:
>   - Add missing checks after calloc
>   - Fix memory leak when handling calloc failure
> 
> 

Applied to fsl-qoriq/next, thanks!

[1/1] board: freescale: Fix error handling in ls1088a board setup
      commit: b24d70e2a3fff89f0df44ed7712786e1deb20cdc

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
