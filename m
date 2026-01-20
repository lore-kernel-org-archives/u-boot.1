Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E7ECA5FB8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 17:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B418389A;
	Tue, 20 Jan 2026 18:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kqsfhIvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7110839DF; Tue, 20 Jan 2026 18:36:41 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FF580B98
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 18:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si/E0RkI/DyFlXj8LgP//hGaVUwACr5KgkhD8BXBdDgfqBjkP13wtsAwFvoySDJSEgOetBYh6vImjcXaWs6Njfm5Sqhq1linlDkwKwE/qfQ7lJaodCMVl2l2kvR0lJRLTh2fti+6yDHh38DmZaJK2Onm2HQvi/6+G4VqZj7XYgGPYpkmnRS4Ga7K4IredPGcBQWPlmwNSUgKvdq8Cvs9cpyD2iMJxCFAnO2VQnMmvQS13WPOUWnePdcSHYg1EFq7zQYD5ZAfVaNQgHVj/ZaHxn53Pve2l6++6Az3wrQ3FsvIwGmzCUgC5I6maRT+0lrNmu/FUwtzy10PoYtK4PKnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGtjyMGG/It28aFmviLcUpqPHg+fk8GugNL+XLZl5Pc=;
 b=a5Jo7eDQlDUQazeEY/76ACgNXRoj+IGt2cjxkiDyKb2PNLZelA798OQ3zg5MWhRUJE1hWAPZvBFinfwZDJTwGasl0p2lO8q/x9XOeR9LUn4Wq0pT3EhZNDUabPO4gGdnFHjxP7RsOs+67hFomMMNklNVJM2MoYV/9RYmta8+i2/ZhLNJ1pLSvn2OuVgxgHbBh0xp2ecF5DR9SwrEJPCLT7ECS6NHM1iXY+BBeVhu1VeStkmPbhn8ZUivOZP6Jatyku0GLYoCDtCIyeTJymLe+Fy+FszjXAfBX4GPsQE6UbiA1VoeXr+milY7IVONn98j6B5/u3c7HonQeAmGMMmn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGtjyMGG/It28aFmviLcUpqPHg+fk8GugNL+XLZl5Pc=;
 b=kqsfhIvxvJ01ZggO8iI3ecLVozoJjWaYiityu1yDaaIcwgZaiVGgShxWlAYdr3lhXIbxj0PUJlGoEK4T4iOBHg4vRyzdw63SrjS3AKoEpDHo/srpIyJAP7pVA2bwsVOuvtTbxMiVArirliBwMazqeNMXlVqzO5Xz+zBKosCAZ+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 17:36:36 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:36:36 +0000
Message-ID: <80e83cf4-f559-4505-b12c-7696c11e18cf@cherry.de>
Date: Tue, 20 Jan 2026 18:36:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binman: elf: Check for ELF_TOOLS availability in
 is_valid
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Andrew Soknacki <asoknacki@gmail.com>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
 <20260120154750.420179-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120154750.420179-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 2110e754-3be5-427b-1819-08de584a75de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3gyUDZKOGFoL1FRc0w0Uy8rYkJ1MFR3OW5MamJDYnZDR2h5R3piSHI4Y25D?=
 =?utf-8?B?WDN3VnlmdkM3Q2VWN3AwRTZkYVlZTXVnVGxvL2NYaXVZVE1YQ2Rwc3p6TEZI?=
 =?utf-8?B?TGpvVVBibExhSFNpeDJTelZBbDNHY2s3TjlpdEdkYnVpeVFSVmQzMWpFTS9l?=
 =?utf-8?B?Nk9UckhDRFBxNnl6Kzdja3VITnkyUHpQODJqdTY2SVpTZXA0c2JtQUQyVFAv?=
 =?utf-8?B?NE1EZjVBLzFXTGp3VUo1Q25ZZnlUZ1Z3akNYZHp4SkdvNEFLWFhjOUZFaEho?=
 =?utf-8?B?ZU9ZaFlzYXhTL21Zb0R4RUdGVFNneDRkZmRNM3ZORHI1a2p0K21SM2dVbGlK?=
 =?utf-8?B?RGNnVEk2MjBRK1N3MW9HVTdnc09xSG50SkFMOWNwSlRWeW9PUXpTak1IM3BV?=
 =?utf-8?B?em5NWVhYMTR3R1ViVVU0ZStSNE8rU2xLdzcxRDlJaTZOUDVPS3FDZXhtM2NN?=
 =?utf-8?B?bXA5Nkcrbi9sbkdnRmRIS1NOektVZnQxd1ZmQS9tVGZZb3c0Tm1wK3V5NkRD?=
 =?utf-8?B?d2FqWVE1SndSTHQ2UUFJVGFMMXQrN0NHWWl5Y0EySXNkRldjc3VEVjJVOHdG?=
 =?utf-8?B?MXpoRmpTSm1PTU1wa0tjRzM1bGtYMDk4OTR3NWZqcGNmYjM0UjVWclREOWxj?=
 =?utf-8?B?YVhPdGFMU05Ja1lJNmZTVEVNSkplOVZ5NVFGM3RwRDNZNW85STdEbWoveXRZ?=
 =?utf-8?B?MGQ2MVRhM1lvNjZUZkVZeW9OaUY2Vkl3NmgxM3JKaDlnMjd4aWFLR1dQU0M4?=
 =?utf-8?B?blY3S2JOYWVyYThEWitWckVXa2ROcHlDcmhWbFppaWZOczNHeHlTRkFmbnNK?=
 =?utf-8?B?VFBSVEJGSHp4eFZMMHBlN1ExOHowTEZLMDJUeW1qR2NNSXdqc2w1UWRCd0xm?=
 =?utf-8?B?TmRKSlozUzRka0VZZDVjSC9GWFR3NW5TVDQvUFhOMVV5Uzh3MHlLSXN6V2ly?=
 =?utf-8?B?dzFSdmFRa2R1SW1nNDVDM05mQ3dxMlZmRTJxS3FLa21pNFZkV1JRNVV3SEIz?=
 =?utf-8?B?citVdW9FKzNPSm1zQUdEaEtYcm1KbWtjVW1lMU1iaG1CTndDS3Brd0ZnejVi?=
 =?utf-8?B?UWZVZHVFeG5ycUhiWkhobCtKdDRDY05Fb3huTWs1ckZTMnY0MmcvOVVXS0NP?=
 =?utf-8?B?dUd1SjJUOTdjaXVJbnlxemZFSm5BUTVadE9BNDliM05XQWt2b2tpalJtYjhT?=
 =?utf-8?B?K2orVGVjMGE1bXhkMFFPQ2JBU3BTeVFEMXVxYlBKRGZ0UHdhTVQ2dGJKV25l?=
 =?utf-8?B?RFdRcHB1K2M2RDBwVDRJVmp0ekZmNGhxbVFhTW1WRE0rdVZQam0yRVUrbUxT?=
 =?utf-8?B?bm1kaHFuL1VJVG8vaVFCOHhhSGVpUU9iMWtYd0FIb0E3QTJmN0h5azJGa3ha?=
 =?utf-8?B?clRkY2VYYlpjcTR6QnJha0xoWVdrU05tVXE4SXNWWnFaN1JWWDhYVnlmM05Q?=
 =?utf-8?B?ZTFwelpaK1pwamVIbTIvZTYvZW5yWkpKWm5QZE51YWJZaE1BdXp4bW40YlVv?=
 =?utf-8?B?dStjMkU4OGhWc2hkeVFMQXJDTmgxVUJ0YUdWeFF4UUtmOVdVWjR0cnRVdzJh?=
 =?utf-8?B?OU9xV3hzVkRKWkUxS2FYVmpwb0JHN0paUDdFMkZCcTBxN011dHFLQWtZNzRx?=
 =?utf-8?B?TG55NWhkSndpdFJiVWFITm1SNnd6NEh3eS9aeldCTS9KNWs2VlY1eUNMTVdP?=
 =?utf-8?B?SWhkRDA1MHo1bXZMUHl4QUFjQ2FZSkJVaEJWZTMybVE3R1J4anJKWEQxckJr?=
 =?utf-8?B?OGZVVnNLZlJRNlN0eDBhZUtvSi82OGgxWHZGMUl2UWUyTVZINno1NW5VMk9W?=
 =?utf-8?B?cnBhQnlLclBBUEtOMkJXdDRsQ1hxclNXS1h3S2c1VSt5QlBtY3pEbjNCVXk3?=
 =?utf-8?B?RnEyQ080bjBJQzlnVzg5VUQ2eTlCTURFNlR1M0hMMGdmaFBDRzJVZzN5bC9V?=
 =?utf-8?B?QnhhUVArRlhIVVBOUnFXeVVlY1JIL0JoZnk4cCtlSkZld0JCN3RaS1c3TkhX?=
 =?utf-8?B?aUxSNXFFTndCdjBnM3dPL1dxTUNOSzhxazM2SGVJR21IdDNnMlk5R29wMStr?=
 =?utf-8?B?MGVYS2FHd0dNSThaNk5TM2NFTXV4M1BVT3pEV1pweXpIa0xwNzJtV2FzUXJa?=
 =?utf-8?Q?IWLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2xPdFoyN09YTzVUdDQzbHppcitadWtGRVF3SWtlUCtFeHZZZk1zbmI4YXBE?=
 =?utf-8?B?aG8reXFlaE5RbmRFdVUzaGNLeTQrOEl5S3Qza044MkZqdHZGblBUdXdMa2o2?=
 =?utf-8?B?SDA0SmtKcVp0MTNTSHVtZWxmQWd4WThQcHJUbnNnd0NuTFZDbXBrcTBlaE8x?=
 =?utf-8?B?TVlPakkydVU5S0ZqKzZYTXFBQXhKSzd2SDYxbHdIMVBOUW1hMFp3aUtINFdh?=
 =?utf-8?B?N2crc1gxWFN5SEYrU3J1OUQ3K3o4ZU94c0VtRUxxZG9RaHdhNUhGQVdyVFN2?=
 =?utf-8?B?L3pKQmt6bXZUSmQxNWVmd1dCNEdIclA5clplZjNXZE1RdGppV1NmczlYMHVE?=
 =?utf-8?B?d0luaGY1OWpZQmN0QUJ2WjA3SGl3NmFOUWtIL1BzYVExYWlmcTdGSTlXYzZv?=
 =?utf-8?B?aTcwNUI3cEJDcDE0M1RCOE1IS2xlaWR0Z1Y1YTlCTFBiS1VnNkhjWXg0Y3dY?=
 =?utf-8?B?cHgvUmMvZGVGV1hERnlHeDJGVlNjVG9ZanJ1U3k1MVM2bkxEMXJyMFJmNjAz?=
 =?utf-8?B?SC9vOXk2YlBYWkM5RXlWdU1jTU9GQVdtLzRDejVtbzRmdXdEWEZ6ZmZYZnVs?=
 =?utf-8?B?cGFxOU1pM1BuWjBBWG0zQWxYQUlXamp3cnVBMzMrWEZaUnkzeEsyMXFranNa?=
 =?utf-8?B?eVo2SEtzY2pVczdaaU5ycDZGaG5QM3cwWUVVV0xNcjdlQm5CM3kxdmU0YjVQ?=
 =?utf-8?B?bGdoaHJYTVEwdTVPeXRUNVNYZGE5SWlhTFBiRitKcjB6dGI2TjJPY2svM2JL?=
 =?utf-8?B?Q3N0bTl1WmtVajNHRS9qNEpoMGJGQ05wWUxFYU9sT3VGVW05Yyt6RDNyV3N6?=
 =?utf-8?B?c0Z3QWhnVHFmbGdpN05mb1B1b1NFa2tlaXJSSVRyOVhmcklhOE43MkU4aGxX?=
 =?utf-8?B?WjJkbkVIaUI1aUZscmRmUlltYUJYOFF2NFBuZ1FHSkRmUVA2QTZIVmhWU2Y4?=
 =?utf-8?B?YlNiMFFRcWE2STZlMk11NDNUVWdOaFdaUGNWYUZkaWdyRG8wV2c2WHZqYXd2?=
 =?utf-8?B?cHVrTmpRUUljNSt5NlZISjhHaWZjejA1QTQ5WmprRDY1Wk4wUThta1NsQ3ZZ?=
 =?utf-8?B?WW1XWjEzU3JzMSs2eUJpbGluME9qRlVDWnNRYlR4bzQzM1JITzAyVmZaTW1I?=
 =?utf-8?B?RW1jNXRCWkN6dTAwYUhNbHllY0hKU21raThOMVlNK0dyTEJFdmtycTNORHFo?=
 =?utf-8?B?U1hTVm90TDBkV3hIMWlJMjlQaFVUdHNxNWtHOWxvUjFrNUdab2N2dzlrYkJ0?=
 =?utf-8?B?SkYyL1FwYjllMFZaeUxzNU1CSzdwNnRScjNiSjhMMmlCbnJZWkdrQmtDQjRD?=
 =?utf-8?B?N1pOcVlXdURJTkZnVXBOVG43bE01T2YxQ0RmemlKYitYU3JaWklya3NYQit1?=
 =?utf-8?B?UnJtN24waWpXV21ieFdEY29ja2MvTFYreDR4TzhPSUM0R3YvVmNzd2F4MnFV?=
 =?utf-8?B?aHhpcEI3elVoWDczaXkzNmErUlhZZm95c0V6azF1THB5RkVTM2MwN2dReHRM?=
 =?utf-8?B?d1l2VlExVi9wRklSSE96ZTRLbUFvRWpLUXUwbkkvYnZ6d1lBMXhaVTIva2FP?=
 =?utf-8?B?d3EwcE5iTVBlRGdIOWlpWHFDbktBYmVGYmh2ekY0Kzl2TS9rM3piRFZzVFZK?=
 =?utf-8?B?ajVpUDIvT2tpQmtZK3lTeVFJTndyak5ZcGtRMjhycTBiWU1rQnAyUm9TU1dN?=
 =?utf-8?B?WmdWVzZZUVZkOWxIUk9BZHdBeGNMYjNVYS9mVjJGUytnMm9JSCtjVjdacHc4?=
 =?utf-8?B?Tmlhamd3WEtDL2VmSWplc1ZDR0g4U1R4NW41ejlSTmVRTk9ncVpSVXNVNTBn?=
 =?utf-8?B?V1kwSCt6N3Q2VXh1MlJidzkxVC9YVTVPZ1VPM1ltNmRSZkoxanBNL21BZTBa?=
 =?utf-8?B?SUZXU29xbTduWVlFVHNQakx3eXUxWkNGaDdqVENNU0dPaG9RUjk0QnZlV1dJ?=
 =?utf-8?B?dE9DMkVuYlgrUUNWWHFqRVU4SXo2RTJTdjNROTBrbm9KY2tZNmxPWDBMaitL?=
 =?utf-8?B?cDFDdHcrUTlUV0FCc21VQmNMWkh3TmtFVlZmZytRQXI4ZTBJRXErT1Q3SzVY?=
 =?utf-8?B?QkdzdU03OE0xQmpzU2xxQzI4SCtvNE5RMGlPc2VJM2tNM0JaN3dGc285czNP?=
 =?utf-8?B?MHViL2ZoNXJxVzF2Q3o3N1BWelVjeDNXMzg2dVR1SktGRTl6TXNhSDRiSGZw?=
 =?utf-8?B?RFhPakNGbE9rL1hUU1JmMlBsS1VVUGhvVU5BQ3dpQitHMnRlZEdPbEpmQVRp?=
 =?utf-8?B?R054UWp3R1VLbGQ3SCs1dWtWakNTZUVibVBCOXBheWVsdjZmdmZtUWZLek50?=
 =?utf-8?B?K0MyNEozdUJ5NlEyLzhabHpSS0FVT1RWRjNmSXJESHkvSEN0K2hmWFM2aGFT?=
 =?utf-8?Q?6RJ1JQwT0ANCrz7wE2T3UaQqGtojYlnLNbKIT?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2110e754-3be5-427b-1819-08de584a75de
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:36:36.2814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjReS5JLRkvwSyidxnKvZZMbxG5RgxW5PxoUg2m9vV5MQFQvF5WQCtr1/EvFDAMoDYuTTtlOdttZoqnKtPtCyR8d9PepTBwPw1jd6SCFUQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
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

Hi Tom,

On 1/20/26 4:47 PM, Tom Rini wrote:
> From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> 
> Check if elftools package is available before running DecodeElf().
> 
> This clarifies the error message and adds the required test for
> coverage.
> 
> Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> Signed-off-by: Andrew Soknacki <asoknacki@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> [trini: Add the test provided by Andrew on IRC, to fix coverage]
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v3:
> - Add the test, provided by Andrew, to address the coverage failure in
>    CI
> ---
>   tools/binman/elf.py      |  2 ++
>   tools/binman/elf_test.py | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> index 6ac960e04196..899c84ad36d6 100644
> --- a/tools/binman/elf.py
> +++ b/tools/binman/elf.py
> @@ -570,6 +570,8 @@ def is_valid(data):
>       Returns:
>           bool: True if a valid Elf file, False if not
>       """
> +    if not ELF_TOOLS:
> +        raise ValueError("Python: No module named 'elftools'")
>       try:
>           DecodeElf(data, 0)
>           return True
> diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
> index 5b1733928986..3ad0bf4c4b09 100644
> --- a/tools/binman/elf_test.py
> +++ b/tools/binman/elf_test.py
> @@ -373,6 +373,18 @@ class TestElf(unittest.TestCase):
>           self.assertEqual(True, elf.is_valid(data))
>           self.assertEqual(False, elf.is_valid(data[4:]))
>   
> +    def test_is_valid_fail(self):
> +        """Test calling is_valid() without elftools"""
> +        old_val = elf.ELF_TOOLS
> +        try:
> +            elf.ELF_TOOLS = False
> +            with self.assertRaises(ValueError) as e:
> +                elf.is_valid(b'')
> +            self.assertIn("Python: No module named 'elftools'",
> +                      str(e.exception))
> +        finally:
> +            elf.ELF_TOOLS = old_val
> +

I'm not sure this is a good idea. The issue is that you're modifying the 
variable from a python module. The check may be run by other tests at 
the same time in different threads and I think the tests will 
unnecessarily be skipped or fail?

I think we may want something like:

@unittest.mock.patch('binman.elf.ELF_TOOLS', False)
def test_is_valid_fail(self):
?

Cheers,
Quentin
