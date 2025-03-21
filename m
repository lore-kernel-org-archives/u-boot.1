Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E419C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C9A8197D;
	Fri, 21 Mar 2025 08:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E0ii4VSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853878197D; Fri, 21 Mar 2025 08:16:49 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A55481E1C
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE27VbMvPyEQ7OxDpphQ8ClnpVg2XyPr7qNcJpdr9T5yo3WgU+JTKkD/V+HLSZ/8cOkFwewvx7RM7h+nI9MhaRd1Ajolj6Mx7ES9t4D1awLTD1lYQBgvk+M9WYloMt3ZaBU02exjOYECXpZrYJSoUnN3C183S2fC80amGZeoKJRuKbtesmTsu1R8Wsuvom6MfaqupmeG1SJFc7dqlxoo3XoWkQ1lZ0WKADeoSxydJBqVlDA06sxCUioR243KVRdzokiUlQ+sNr2tdDU14nbxU7lOalaK0DsR9iI5MjQeyyQ8vW2R6Mv+Pf+NotrwvYHYbylRcP8BRWfCeOoAwsNJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfJg1NzDfLIoXIRqUXlpGDfMzIRvPOVHe6JafD5yI+w=;
 b=KuQ8rvFLedYfETPoOOZqcRj9NCxcU+7e/7/AVpOWsW/KHsv8W9Lf6WthBa5CMoE2wTO8br0VV6ChQBncSTXamt953c2PZMVPYviRTlHDd1fsjSFwRSJU/w0HHKUulx4TObDwrIcHu57xGuvbVmZmLRhy/B9sDPbaL61HVJaAHKjeAL8feFLKnXCvMfJ+fLv6QCrA6dXPjGYurQ8sRVU6FABpRa+CAjWo8xE70AWr4i4uegnuRUSVisavxNt+NFMZkHKjeXHkfOMWyX7J0WfXp8OO/6LZYM5dcCjUMginPzrX8iz2PBhtohTas322HciMRLf2PwEGpxbImrHgPLp+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfJg1NzDfLIoXIRqUXlpGDfMzIRvPOVHe6JafD5yI+w=;
 b=E0ii4VSwyN79uHCimO1ZCVyyT3GES+onv4q0P5frFoFX8EER+zUHYHaWScvs0qGNtTwmmhdz0JdwXjZERoNmnCGe/0Gq4Dd7FYgMBPmA1NucOMpPOL51/MgY0KJN9UexEMw09YcsnaROlTHusHgJqvOdTiX4tS+CR7psnlt9VJyIe/HF9T4jEa870lYR7Pusp5BK2qq6ttfYcX9foCuqUKmYwFkBzqK0fYNJ6mk6GNSm6LE6qflXIxFO3/Y75CGZ3Gafof5cZFOhhDbC8tOTrdlaCpJb6aVqm0hNIDFuChp34bfsRiTP6wBeNVbh7cQ8EOkVBfHtTLIJHZA2QjkK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:26 +0800
Subject: [PATCH v8 12/19] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-12-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d92debe0-8236-4456-de0c-08dd6848556e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aExwbjhIM20wRjRLRU1kMGlxVWszcmtHS0xubGZwVWEzdEhJYmpQRXVUaUZq?=
 =?utf-8?B?ZzhNQjQwbUcwcDNpR0pDTVpOdkhkWlJEK2Q0ZmVjbldtV1A5UGY4SW9td1c2?=
 =?utf-8?B?ZnVJTENZRm5IL1JnVlJweXhaMi9EQmFXL1NUb3ByTmllS3hxYUdleXlCR0pY?=
 =?utf-8?B?by9jcWdaWTBRbGN2a3YwVVFZbjNZb1BReEg4NFRPQzBwMWwwb1V3cHduTjVq?=
 =?utf-8?B?VTFpMHNhUlVVUUlva0xMNDVVZnk4aWFsZHV2UHpabzhTQVVaM3EyMnlxWFdP?=
 =?utf-8?B?Yzc3aU9Kd291Z2g0MHNyK1BiS2R4RnBLeE84K21SNUo3NlQxWXpMTGo1aE9m?=
 =?utf-8?B?ZnpudTV3ZWVZVnNKS2JnZUlid2hVUG12VVVqakphS3ZiUk0yY1FwMjRlTkJQ?=
 =?utf-8?B?QzhnNTV5b2RpVXBJRmFvRUpkOU9oSXJyR0UvQ3dPNlE4a3VKVm9UVkZUL2kr?=
 =?utf-8?B?UmN6NG0va2kvdCtlK1lkd2cycFFXTFpqOE5abkhoQThCcGg4Q1JRWlBrQngy?=
 =?utf-8?B?NlMrQlZQcjdhRDBiemhpLzA1WWdOZGM3Ly9vMkJ1UEhocUxsY0Z6bS9qcXdQ?=
 =?utf-8?B?RWNuQmVVd1p0b3BEVm5sb0U4UVYzL3RmaVRONitIUzFkQnluc1JhK2VyUWRG?=
 =?utf-8?B?U05tem1FOENlcDQzcUxqckZNc3c4cHhmVnBrUnZHYlRwb1BiL2wvWTZ5S1Zk?=
 =?utf-8?B?NlhtSkY2UmRxZnRyd2k1Q2c5RTRwT2svckhHYXNvZXJTRS8rR3UzNGl1cXJ2?=
 =?utf-8?B?b3Z5MHZKZnN6cWVGVkROYllmMlJldUQ2UWc4SndTc1lmcVV0amtuZlN3MjIx?=
 =?utf-8?B?ci9DODdBR2pabkJzQjZtYS9hajYyZGtUVVBIdUtBSkRRbXJVVEVCc25TQk04?=
 =?utf-8?B?cU1GOXNMaWQ2VzBQOUVWOHBkdkZQK1FyekdMZldOZERIWTB2dWFRNHFab1B3?=
 =?utf-8?B?VEszNUFrdmZIYVYrZzdiOXpSZ0Y1ZEtQckM4ZFNKQUJJTTBaejVvRXRHVGo0?=
 =?utf-8?B?OE40NmR4VWVYWXFRNzE1TDd3WEduRjJEZnUzaGVEWTd2YzMxSEpUTUhvaFg5?=
 =?utf-8?B?bythUnRwbVVzQjlZcUE5RWIwOGZnQ2VDR2h3YU5xRWttRm1VR0JqdkFNNUgw?=
 =?utf-8?B?ZllFNVphdEV2Qnpyc3ZBR3lRQVZhNjJBNGo0ZzEyaVZHWjJOOTByYnprajVu?=
 =?utf-8?B?UTRNVUFXNVh4NGF0RWVEaW5wT0J4Q2doRU5UL0drbHkvMHRzdGMvMlY4V0Uz?=
 =?utf-8?B?aEJBaDdzSXZlT1A0a2YycnJQbWZvS3V2eTBYVzJrdTFReGZYM2FqZ0c5OVE1?=
 =?utf-8?B?NnRNVzFEUzlGbFFuY0RBNnpQYUM2dVMzU09tV0NXaEFsOUdiVUlEb3cwaUJp?=
 =?utf-8?B?YUc0d1hNRXdORjZ1Yk9lN1lQaTk4dWNtQUF3bjU4bXU5Vm5SVUE1WGw0Mng4?=
 =?utf-8?B?RFgwTzhnbk41cVlTRyswclhHTm1JN1o2Y0s2UStCSytLemt2Y0syNVJUVTFG?=
 =?utf-8?B?ZHNaaThtSmtETXd5L0hhUExzWWpMWWtwdXZUMlErMVdGcVVGTnlybzNnN1RK?=
 =?utf-8?B?bS95eUJPWUkrMmVya080MW42UTYwcm1LS3BuZEh6blpPQW1VYzMrWmtqOXhl?=
 =?utf-8?B?V3pmV0xiQ1A3RGdqTkdKaG13RFp2K0Y1SWZmOGJrbEJnZXVuTTg1akZ2bzgv?=
 =?utf-8?B?TlVYMCtLQVVpaGRIU0Q1cTEvNE4zUE5yR0h0V21vZFpyL1ZSNXE5VkhrbDVG?=
 =?utf-8?B?b0ZYaXV6U3VraEI1bVNXYmpZUEpVR1pNcFF0MzVvUmpFYnhJdW44RXBUM1F3?=
 =?utf-8?B?ZXQvNlR1SkFwOS9adFdjU1RIY2czdDdqVWcrdHZweVRBcHp0YjJERlovbGt3?=
 =?utf-8?B?WGdZb2RvV2ZtY0lpQS9aOVhjeXNqbEZGdzVXV3pLaG9UOEhJckIrZFVLVmZt?=
 =?utf-8?B?Zm5IRllQNHZpVWx1blIvZklrdmRwdTJ3WnRXbHMyWXpHek1ta2xPS2Z3T2N1?=
 =?utf-8?B?Vks2RnVvSzR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRMUlFNK29NS0pXSVVVdDRLMnBHZWc3ZDJzbjNaSmVpTTY3SDFmV1o5RVRX?=
 =?utf-8?B?OGZtVWI2SVIvamtJV1hQSzJUNjJMbXc3RUxLdzJLK3BRVU9lTkttODJiWWh1?=
 =?utf-8?B?aUczZSt0WWM0amtBeUlIZXhtc3draXBITFhyYmhqbjhpcU1aRUE5MGx6ZFE1?=
 =?utf-8?B?Um9Rem5jZkUxTmJGOHhwQXVqaWpCbFpoNmcxQjFaMjVaQVdFZmtIWnJ0ZjZS?=
 =?utf-8?B?MUhHK2NwSWFpMDFCTUM5OHNkeGhkTUZINkdiVXkrVXZZL2owdi8wcXdYWkt0?=
 =?utf-8?B?RjJ0M2I2SDg2dmwrYkdCMWpsRUpXakdiMXRFTWtJd3FndENhbTRDTWdGRzhk?=
 =?utf-8?B?SzNEM2Y0ZG5NMjNwOURNYk1GUDBFcTZnMWdaY0did25XajRneXhzMlZxeEhO?=
 =?utf-8?B?S1lmNVhPSlQranhLcnhpWGRLbDNVTmFwK1h1N21FUEpPM05qUWF4Mll0MGJu?=
 =?utf-8?B?T0NFekNkOHpaalNRR3FTZVo5WG9zdUEwZnpUbkRDeXBiQkNoR1R4YUlScEdB?=
 =?utf-8?B?Ti9rNWhrSDM5K2ZLVTdwS3FKTTd1TVBrTFA2RnJGVjN5aVVSUTJTcE5CS1FR?=
 =?utf-8?B?SUt6cmhtNGdsRXA4cGlKQmw1WnFJMnhKTFZpcVVzQzJlRTlQSjQzdWY2UDk5?=
 =?utf-8?B?UEZBRFkrTHNIL3UwczlSR1dpNVdsSlFzUXVBaWNvKzU0Mk4zallQTFFHOWwr?=
 =?utf-8?B?bHltbEloNW5mbnhidFBMZTZwSENCc0JZbXZUYmhKdW9YODNtblFHT0FqWkdn?=
 =?utf-8?B?Q2F0ZzNoajZsWlNFS3RMdFJJbE5acVYzSXcrY3hQdFN6MkxlWG9Id3ZSbEJh?=
 =?utf-8?B?SG9YWTFSYjVVZ2tZRlJscy8zVGpWSmFqMjJ5aFpyazhxVW4rTm5lWHFCMTJH?=
 =?utf-8?B?b0syMVBrRGtsV2NuTWcwMXVTTmUwT3grSWU3MzdSSFBQbHpDUTY0VmZaYzBk?=
 =?utf-8?B?SFFCSnUzaTNLbzZYd3RFYXlPWFF0RzM5Sm1TL2RRWHI3ei93dUo5OGJ4WUdI?=
 =?utf-8?B?NkNBb00zRWF2RURGb3FsdUNmSUVta29Vdys0WENoejBZSzdVVVQ5NWp0MklT?=
 =?utf-8?B?Qk93V3R2NUFwbFVaN0VBRXh2RlFkNG1HWndkY2NzWWZDbTh2d2JMeGJGNHE4?=
 =?utf-8?B?ZzMzR1VqYlV5eURldmI4WTVWYlI1QllKZWs1QzkxdFFRVVlRUkgxb1ljc3dl?=
 =?utf-8?B?TitFOEFNcEkvWDNueERFczRFMnF3UTFHZjN2c2pNQVU2bGJsZFc5eE9CckJu?=
 =?utf-8?B?Y095RXZnQ2dhN2tMZ2lSbWNRRzZ0WW40a3BFdnRrVUhxYUhVVThBRGV4UW9y?=
 =?utf-8?B?QkpveDJQWVF0UHl2N3BRZVpqMmRNZjl6WktvZHJGR0hvMDBEaXdxY1JKZ3Fy?=
 =?utf-8?B?MGdNRnhoNGVtbVRPcitrcmdvL2U2UDVhVVkyaWpkQmV3SWNTRVpzcUJBTE00?=
 =?utf-8?B?Z2tXTTFXdHh6bTdlWkV1eWo1cWg3eGxLRlZYc24rajNSeE1KUUJJc0w1anBU?=
 =?utf-8?B?NjhydVgrWG1ySWVKTStKOEF4d2x6YkVnSmdBVVBvYlRKRURBb0Jram4zYld4?=
 =?utf-8?B?Z09xUkU5Unc5aWNNTTJOWk53bWhCa3p0b2JFNHFmY3hCamF2cE1WVklheWc3?=
 =?utf-8?B?T0xnVWNkcVFPMEdpY1hsN1hGSXdDT2JpR0hDbWxpTlloMWRXYWNnUjdVekpr?=
 =?utf-8?B?U2pwdUpSNzI0WHVYSFR5R2RTNXBmUmpBZE1RM3pBQWtuem5yT3NhTGV1TW5B?=
 =?utf-8?B?N2JqMmh4aTdJQTlQcHk2aFBibDN4QXBtS1FTaXV1MldwOFI1N2RhOHFsYWs5?=
 =?utf-8?B?Wit3QmF2VzJuSzRzRzYrN0JjY1czbFhsQVFiRHRXMytvdHE0RHdTQnhoUlkv?=
 =?utf-8?B?Q1ZYYWhzUDlVQ3k5ZDhhcTZldGluNDZWeGJRL0grVUFyU1FaWjdKT1NWWmla?=
 =?utf-8?B?aXJxWW95WFRreklzR3BCNWRUNmFab2llV2JaQXBReWFLSUFqZjlTOTBJdmow?=
 =?utf-8?B?RG5KV3Y5TC9xWlJNQk9tN0FGQ0dncFpwRDYra1IzWnpDQTA4empGZjBWYXgx?=
 =?utf-8?B?dG5QdG9jYW9EbVdoVVNHemg0b2RNcWRCTzFMZWlNazVZUlJLUDI2OFYyOUc2?=
 =?utf-8?Q?6C5vFKo3W2GGl3I2Jmi9TxxPH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92debe0-8236-4456-de0c-08dd6848556e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:43.7662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBWy/ke6bpFhhOOqFPnLFU/n23cAOpPmeR4P6xqcsUjS/HE9zbEpoLSYFIReyExWHj5sNJLZnY5q+WphgPoQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955e..ef364ca1a2f 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,14 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SCMI_TRANSPORT_SMT_INTR
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a..53cc97c6b47 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.43.0

