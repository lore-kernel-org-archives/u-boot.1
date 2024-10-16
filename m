Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE37D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EFD88E11;
	Wed, 16 Oct 2024 09:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h7qfkXno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B2F88E61; Wed, 16 Oct 2024 09:19:48 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7B388DDC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANu2bQqKxJIwehpab+fSsCxIWqI4g7NJngxHuZWk7kKtoQ/I5x7yI7JH1g1HU0GU/5V74bCOW60iNI5ivOn8vG92GnT1jtKp/wkZ8L5mQlaYa4Zaoop1j44RRbJSEJ9kluOOZ5K4kf2TcSIKlZiLOkjQg5VR3Ske1SEF005+FPtt8elqwnN2912LPO5SWJAdKEyKOaZomCu6GApDVFN7TrLgaL1qqw+/aUqOsY1ITOxmeIuihKxskKaVS2J3ck4gZIo6JHAxNkMgcJW6t+VzLs8kLg3AuTwCTta05o/Ilpb8O+WqR++fDW4uvlJM0S91yzLx/xjEBOHJd2EQGo9ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=BN77xdVD7bsi0sK209xdEZTGRamn4/Qp6IODwygRZ15i/0yyGMwgRHyAgueaTeYrBQprvTCrYClJpXw2qjkfWr9YMkznJf8xhS6rz63z0TsicqvxXaYHNSUoQy3JZ3MkMVVoRUNs/TkRmHR0NJwATGT8DHsAcMPWCr17U+BsxEz9+hdDMnZ2RQ1lQf9twehlvjWVcYGNtwLNNqKhHqokc/liEdK0CDIl7iNamoEDWtu6HAkPKu8mb6zhB1OPXsmZK1SvyZUVs5HIjII1VHmQo69aExUdXe2QS7cACjXMm9kETe3Ju7K/K/uNDOdzbsD3kfV5avzW4XVWm9vfDdeAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=h7qfkXnoNC7e0yyUXjtmHo67HZSKoexGDw2NcTUD1ItCIWhORmyOU/riIohoT5fQGyJVm7IKfWOaAhgUAvE6vr4DdD20Tr759RbrXKXOxXGYpwneeVbVrATJUaB3NtvJ8I/YtZKLDW69bF9Xu2USaDSGUHwfZX7aNSxvuU+OKGUuWJKUFTaL/lzWlVsQloclIL0jdf5KIWp3YnJ/be+3y6wq93duE6Ib+/d1tLddEBjMyogAR3CzDqduD2RqKL3GynMx5c3E53kNnsT1N1ttZ1PfazOsTXA+8I6KTudH0CKi9EBgjSj952UTFerBiZy1u9s0SL/vLxR9PuOpzaW/lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:44 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:05 +0800
Subject: [PATCH 12/17] scmi: add the macro SCMI_MSG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-12-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: e56c2485-9124-48b4-2690-08dcedb2e8b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VpdTBYVVZMSVRucXFDMmVPbmRwNGsyM29wUHNCYjRLZmtua2tDNUtRL3pW?=
 =?utf-8?B?Q0dsVTVRWmJvVjJqdDNoTStVcm43Y3lSZEVRUm03bVl5WFdzMkY0L0cvY2No?=
 =?utf-8?B?SzdvS1hjemF2c2JWTzhkbmZrV2lVN01VaVIzbEpIYlJRdXY5cG1LZUJhbkk2?=
 =?utf-8?B?YTFWSXY5c1dqZ00rQlBVNU0xWDllMk14R3J6OFRuQkRWRW0rakxYNlNLODVN?=
 =?utf-8?B?ZTB2Z25FcGp3YmNHTGsra0JsSGdJU0ZSNmZJNWJuM2RldWE2OGtGc0tTWlM5?=
 =?utf-8?B?MXJkdmplNUNsMElPWSsvbXNqOE9pTGdjN1ZwRVFqK25CTXlHQ01ZbWtWdEhE?=
 =?utf-8?B?T0M2amRnZm11bUdIZ2tNN0xEUzNMNkJPQWFXSk9CaEpkSnVXNWRJNGM5M0Nv?=
 =?utf-8?B?NmJ5UEc2ZE5DSEtNejNVRTRFVEg2d1ZycDVtN3hPbmUzRjlqU2J1V0gwbmZS?=
 =?utf-8?B?NWZFOThaNnJCRGdvdDBoeFVFUVROTzdLdVhnVVVVZUNnNEs0K0dKMG8xcThV?=
 =?utf-8?B?SkNPVmNPcmlYSmhwRkl4RnlXNDJWMDJydnNYT2NqMGFsSERMdTN5OTVueHNX?=
 =?utf-8?B?aHhVZzBaazhFN1BaaGhIK0lyL1cxL3BaeDFiWTRrNC8vMlc2dzl1NzdWNERH?=
 =?utf-8?B?V1V6cEdIV1RNMFpGcGRHKzJVQnNjZFAwWnBUaGRZUDVIZUZFcUhUSmxXWGVQ?=
 =?utf-8?B?ME91bFBTY1lZZ0djU1dwdzBhQ2dPdDJqM2g2RnZGdkJXZGlnZEppRi83Nkxh?=
 =?utf-8?B?dUF0ZnBKNG5DUlF0b1FGVTNRc0dkU2h5MTAxdm9zZEFsSHIwa0xpWFRqM2tH?=
 =?utf-8?B?QkhvRHRVSElXK1g4VnZKTHFJdnBPbTl0b0xvSVlVR3pnQjBta0VsVENsMlVN?=
 =?utf-8?B?Z0J2cVpBSXhHMjJ4MUM2RVFtRENVcDNzN0RiaG8vWVJTdkFHQkRxSHBrZEFT?=
 =?utf-8?B?WjJBZTBIbjh1aS9GQzJwdEpoM3MwRDBLOWloRzBKYUlsd0lWY0NpZjF4WDF3?=
 =?utf-8?B?Rjk0MGNoazBvbUk3WHYxN3dTcklWZWlHRFM5S2dQeURkWDdPL1J4WU93cEg0?=
 =?utf-8?B?R0FQaDh1Vk9SVzk4ZGNGTGdaaklJbXdvdi84TlQzM1ZEdXZ4Qi9Mc0xTb01i?=
 =?utf-8?B?OWUrRWR0VFNNazhkRXQxbzRRQ2RoZ1dpQVhVNUhUcE1TbmNyUDFoQ0k1SDBw?=
 =?utf-8?B?eURqeDBtMEJlYXpNTDBNKzIrMVI1VVpQb3hJRW9yd0k2Sm5PYjBhSXJMYTdR?=
 =?utf-8?B?OWNsemRBWm5yZ1ZOdDdudHNxMmR5cUNMZzgxNVZ2Mm1FdzlrUy9mOUtZTkRi?=
 =?utf-8?B?MmtnV0RmRVRMZDBPdmhibks3RkNNK1hvSU5CejlPajNLaUhUSE5NVFRXTjFs?=
 =?utf-8?B?SWg0TVlPYkhrZkJKNDB1OStrMEp2OGdiS0toRHVSZU5mZGlVbVVHSThoWUV0?=
 =?utf-8?B?OW9PWDZta3grWFB3Y1oxeGxZWFIrR1RjSTZORzJ1R2hEV2JnRjUwdkNnQVVB?=
 =?utf-8?B?amVQWGJNTW4yVmtZdTFoa3V4WUErL0MzWGx4eTdUcjFscXhsMldwanBMZm5F?=
 =?utf-8?B?eXlyd3Z0czlNbVp4ZHZxUzU5MUhhNVdxSjYreGJQQnRmZ1RwUTRyNjgyQlMz?=
 =?utf-8?B?TzRRbXFQYktJSnN0MkJXeWZFdG1HUE13Ny9GdXBwcW90QUw2Y3IxanZZSXlC?=
 =?utf-8?B?enJMM0FuYnBYV216bHVreEYxdThYcDhHSVNsNitUdHVjaGNSL0pWb2plS0VE?=
 =?utf-8?B?QUpMdXdjMlRUT0VWYnI0VWVVY2lXbWZZOUhTRk5EY05BMU5TYi96clZ0R1U5?=
 =?utf-8?B?K2Z3dFNoaW1WUjRDOWJSQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2t5RWNta0pnTThCejBzN3NyR3UyQzJ0VnBaM0ZRanM5NHhmY0xjUlRZVnlp?=
 =?utf-8?B?cFNLc3ZEUGhBSjVJdlhXVS9nNUJDR1JLWGF3YWpLYkNudlNLSEozMEFkM0FB?=
 =?utf-8?B?a3lSaDJNV25ZZEtudXo4UTAxYmFEV2xXZ1NabnlwYjU3emN2enBIUmNZbkZP?=
 =?utf-8?B?R2ozb1FBVFcyMU1HUCszZWIweGtCWTl6bWF0RGxHTDNwaXZ0R25tUHNMUjNO?=
 =?utf-8?B?OGNWOGlMVjA2czllRnM5T2lkYkJ2bTR5NVhVeWF5M0ZQQkg3L2d5MDNMRjZN?=
 =?utf-8?B?V0h1N2REYUo2M0V3R3BZZXQrUkl3N0ZvYm1mRlJmeGp4RDNIWjN5cjRjUEZP?=
 =?utf-8?B?cGJoeGNJVUxPbFJxVmN5UG1qbldtRDgxeW41Z0M5c3VtUGU1UDBmS0lLOXZz?=
 =?utf-8?B?bGdGYnZxY2YyeHV6NktINXpiQkxVbmZzZERBdVdaTkdJZjFtRDhQZW9FMkNR?=
 =?utf-8?B?dHZQc29HWUhyWGdlUjhOOEh3ekd6ZHhSbXZjSjJSTjlGaWhNbDQ1cGxNblZz?=
 =?utf-8?B?eWtHd2MxSTQyQ1VZZGR6b3RRMGhvTDlRT0ladXljZVhnMHl2U1VBbW83MjFG?=
 =?utf-8?B?emhsbE5xUXV4SEQvdDZZaXMzaWJlNCtLb3ZLY1paV0pjaytxdXVqSUFabUxC?=
 =?utf-8?B?blVyWG9ZT1JQb0cvRkpyUEpESU1uVjY2WVhKbVFFdTJ4dnhSNlpWbW9MVVZO?=
 =?utf-8?B?RVQzd1pFRHVia2FsVHpxZ1BoNTlFcXY2UmNJMjhPUGhkRytzYS9qMzRtQzRK?=
 =?utf-8?B?Q2F5aE01a1B2d0ZUWDB0S3RMWFlZZnFtbVd4K2JZZnhnMmZGbXFZVUl0YXBC?=
 =?utf-8?B?KzR6YVFJUGVEZlRHT0RaOENqZnBpNjB2VVRMYytpSWloWGdZWk5FdVh4aWx5?=
 =?utf-8?B?MWFFeWNRQzI2RHBESjVJWDhycTFtdkV1aEpLSnQxVVJvcUZzTGNna0h6L0lh?=
 =?utf-8?B?YzdMdlU1bi9PUlFiU3FJRWRKbXNheGhMS3lneWhLNzVObGJwdk1hMXA4M1Y5?=
 =?utf-8?B?ZkVXQ0FMZXM3cUI4YTdIMnhsK0ZEVG1jbEpRSlZxeVVmc0R2NmxrcXNhSTAx?=
 =?utf-8?B?YXRLOWlUSXJiWlNydmg3Qk0wRFJyUUloVmtZMzNRUTJKRTZVS0VwYnQwejhx?=
 =?utf-8?B?MjU3WnJPMjZjbno4MjRnKzhoYytRUkVmbGdvclhpYVYxMkN1T2EveFUyS1BY?=
 =?utf-8?B?ZkwvYVVBYmhseG45NDFFM3NRVGFCRjgwWmFzZXZlZ3dkeFZKNWNhTUlMUi9B?=
 =?utf-8?B?MG9XZ3I0d3BVTmdrMW5PVUp5dU52MVBpeE5TNWhxOWc5VTQ1bVVvSkJ6TnJX?=
 =?utf-8?B?czQrSVlDRW5jYTZNRitWYkI4cmN6L2VjWlpVc2pjcUhGZmNRS0szaUpDNGR4?=
 =?utf-8?B?Y2pEMjVlVU54WWhhUWU2UGhGZHBmQzlRMjhJQno4UlRsTU94a0VLN0VaYW1o?=
 =?utf-8?B?L00xb2VhTlU2a0NMdnpGeWNBRGk5dXlSTkdTVkw3Wll1Zkh4NEhiR3IzQ3hP?=
 =?utf-8?B?U3ZzZkFqTlIvK2hLNTlySmFUaVNWSDNDdHB0Yys0WWlSZGYxRUwyNjlQY3Jl?=
 =?utf-8?B?aGp3eVdTYUE0R0F1TXk2a21UN0NYcnBDaW1EZ25YcXhWSFVObzY0SW1udkJ3?=
 =?utf-8?B?L2FNbGF1QUNoK3VKcnUrWW5sZFNkQWRyTWVhWHJzT3QwUDk1UmJOMzNmSnpK?=
 =?utf-8?B?YURoNHJhUmhOU3VBSlpRZnMrS2puSGNRRm5CWXVzQ1BQWGhEZ0ZMR2NhdkZh?=
 =?utf-8?B?ZDZoS1o3QVlHQUIybVByWjFkWTUvYjlBQmlrRHdLelRPaFhLU1FTSWRkaWJa?=
 =?utf-8?B?aFA5bUs5UjJwbHZOalFrY2NKTkF3bE02dWVWTXU0c0RkV2p4eGFZVER0Vjk5?=
 =?utf-8?B?aDhkSDVKWk9kcGRtKzc5eFJ4bTBaU2JNUUR4Tm40QTV1V3NyRWFtb3dBeCsv?=
 =?utf-8?B?SmkvWXR5bnViVlRiTmN0c0JiUEd2OXRPTitJazFPd2hybHozaG9sQUdrbjRX?=
 =?utf-8?B?R1pod1lUYTZZYXRLMXg4OFg4TnQ5eWdidUM5WVhNd1gxREZhd0pKNjhxL3FO?=
 =?utf-8?B?ZzlhYXZUdEsyVWhWN3pDY1A3N21ndkZDb3F2THh4OUl5NHRNa3hnQUxqZ1E0?=
 =?utf-8?Q?HnLKUssJnvieKr7yvzbKC3cq3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56c2485-9124-48b4-2690-08dcedb2e8b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:44.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQSE1MS172+yDIT6fLFbm8fdIK2J8DTsvP5VwrdMdFD/0dXGLWh5ySW/oqWKCXPe3WAsyj3TSyhGbp7AfcbnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

This patch adds the macro SCMI_MSG for protocols that do not need
_in_array.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_agent.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index 755986d6c424ccc881ac0943a88735cbcfacb001..5508a126a6dc504afa6d896c78c760b1af0d3deb 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -54,6 +54,17 @@ struct scmi_msg {
 		.out_msg_sz = sizeof(_out_array),	\
 	}
 
+/* Helper macro to match a message on output array references */
+#define SCMI_MSG(_protocol, _message, _out_array)	\
+	(struct scmi_msg){				\
+		.protocol_id = (_protocol),		\
+		.message_id = (_message),		\
+		.in_msg = (uint8_t *)NULL,		\
+		.in_msg_sz = 0,				\
+		.out_msg = (uint8_t *)&(_out_array),	\
+		.out_msg_sz = sizeof(_out_array),	\
+	}
+
 /**
  * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agent DT node
  *

-- 
2.34.1

