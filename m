Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA24D25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72E983F9D;
	Tue, 27 Jan 2026 08:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RVRRuq+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE9383FB0; Tue, 27 Jan 2026 08:56:45 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D3183F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEvG6lupRQ8KgaKFyfPUaM1PwcOet6OZU9ghBQ1/ULaedvydOSRwLNcJXNEO4z7kH9brmbwxG9g2IUpXFJybANlVVFg73EWYGGM6MFWRuElwmXD0wPR2ywuTqnTOkuMaSlEDFJ5rm1Bfd8+DlBCNYPIXsWkJNSI18sa4M/Wo+tG523b42UOeRcfD5nYDcrxfEHEWv676pahgxkhbyd1eDEt9QDBFGZk7R8UcLkyGurMOiWA9YbRYUFtF+uVXJsDUayzDbhSUiplw4mF3nSNgYSUX8Z9BaIyTb8zs0LXC1FD2zSUVuMlaONrw1dQgjzUINLuUwtRlb8DRbvZ/DuyC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMOqw+dvUXqBLRmonNyEEESoQJHqfqkFpeIEHZN4X80=;
 b=rWI0dD43wDSUTq1XNdSNUqPF76FGZe8ZDJnrMdvMY7fRlKgAjzKnxBe1t5k9riU9U10O1wlUTtB2VGXPKaG6107PhRMKTX+eT90XTiK+HeF28xbFBok93vaB514DI/LtAwkiiCTLExLl7zsCdjOejPBVLRJjFIw+5b9sJRSH8r+OCnaVmhGr6bp8xMjFcYpLSQ2SXuJryMj9BU0oBSpiBWn3adKKH1AobCHi2e7ec+8YsAmBYLmzlBp22CDuwf1GzrWj4yeTul2p8M0DJ9xGSx+pMNx9M+zHE7SYo/e4uZKUgBYLar4gMd/vUaDpolRZGHSe5rpxD/1AyT3BIOCPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMOqw+dvUXqBLRmonNyEEESoQJHqfqkFpeIEHZN4X80=;
 b=RVRRuq+Pw9F18S8qAlLw60bEcd76yDlh4sDXZjsbhsqRKqlvBTfUKl++Qg/00uf5nZREBm1Wn+XLhAVDD+2FBB8EaDHW/jdL9J9weOAIv8LzdLk470Q+AbqU8tPTvoHSDmDpAHepbwduB/t35/2PbdDv5tkPlPC6mpCjG9SO78JyoDeyDyXj1ZvUWJ7R7zzK4CLW2N/A+fr3gRp7j+SWVUYhjfWfHYhtZ4qsXHK0TmtjpM+b6oay2EOn1ND79crq81gRUxgV7YNgEmIxPw5J9Rok4YbGVPJMhtqR/WZEU5Iw3FlFAoxykzyobsuF9oF2XWahygk8I7gIoDmJyABw4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB7303.namprd03.prod.outlook.com (2603:10b6:806:2f4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 27 Jan
 2026 07:56:36 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 07:56:36 +0000
Message-ID: <1bb9e9f2-4eab-46a4-b8f3-54a745589910@altera.com>
Date: Tue, 27 Jan 2026 15:56:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:d10:33::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f605c67-cecc-46eb-aa6d-08de5d799864
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2ZySmRoam9FOE8xU1dRTUV2YnJValM2Uysrdm5YY0k3UXoxRkViREZyUnVJ?=
 =?utf-8?B?R3JnRXBjYzJGNDdSTFM1WDQ4RS9sM09CaDNabTB6MTRvUVpucHBZYTRJR01U?=
 =?utf-8?B?MUFxdGx0alFXVkI2UTNVRStENW50Zkdqdm1VY3VMNXZ1Q21MZjlhQXFBS01s?=
 =?utf-8?B?Uml2S3hkckJSamlBKzNiL3R6dWQyZWRsVDkzZUNlQ1BKSkI3aElQUmZIdFp4?=
 =?utf-8?B?MVY1QnJuZ1I2NE5jQjJFTENNcWVaR2xaTVBhbm1oclh2UmdRY1hxK21meEdq?=
 =?utf-8?B?N1M5UC9pNkExQytBa1FaeHVJVHEwRkdVaUlpWmF4RHN1S2lKYllvenV2YzFK?=
 =?utf-8?B?R0VFMWY5VWdLcjVJbElkRGZtWWU3UUg0TG42WnVrb0ovUG5iOFdJTzNOU1FP?=
 =?utf-8?B?Y2hRendrOUR2amEzUWh6MHFSMVN1T1dZWmRHbHBJQy9DMm1XWkhHOURYVWRq?=
 =?utf-8?B?TTlhNDNJZitOOE1qeGRXSU1GczFwY29DZXRSMzA0ZTRMSEE2cmVUMkhyTUpB?=
 =?utf-8?B?MlR6TUpDSnFsSTVxVWIxTHRHeWlQZlIvOEU2QU1HQ0N2VGxEc2NjQ2xPcmVs?=
 =?utf-8?B?Q29vOXRQaGpRMDdxZm9SQ0d2WllIUUFzTVl6TFdxWmxnWTBUMjArOUpEUTVI?=
 =?utf-8?B?Q1Nla1MwYWFTZDRqSk5kTVVlZmYyOXVZby9GTEFZQ2RTbWY1ck1MZitlcThh?=
 =?utf-8?B?U2pibVhrU0VoOEFpNFArWXA4Wk9hYTQzeG5TYm1IeDZGL3VvODRRRVUzb2FJ?=
 =?utf-8?B?clkzZHZHYjVNUWM2LzY0bTliV0o2dldzUUZsZWRXSk1vV2JnZ3lPa3dDU2s4?=
 =?utf-8?B?VlI2WldCRTh5UFlWd0p5M2JhdVNUN0U3ekU2bkhaaU50djV5eWcrUWRRV0g0?=
 =?utf-8?B?NmJ4SG1KMmowQTBvN0JRUkFRemlDMitoTXI5UzRSTFhKRmdTVXB4MExiSER2?=
 =?utf-8?B?RHFqQi9Ga1pEc1B4dnFNVk4vczdRRHdMRm0vZXdYbzk3clhaWDEwbEhXZTl6?=
 =?utf-8?B?cldzVXV1R3gxN3VNNHZjOHJDRkE0dWNBMitpQ2ZLM0tyMWk3U1ZTVXRZV05v?=
 =?utf-8?B?S3U2VlR1UFkxeWZuMUFXbmwzS0NJTkNUdGtONEliK3h4djgzZjIrYXdSdFZC?=
 =?utf-8?B?M0VpYW9hUkIzS2ljeUJXZG02RFZid2VlRU8zQlZUdXQwWHFkY0xrY2JlbVc5?=
 =?utf-8?B?TXlSa0JjU1AwZVFiVEZHWUdJMkhIblNKc2hQbDYza3VudU5uOXNmci9BNXRZ?=
 =?utf-8?B?OCs4VkQySkprR2RUTnBySm14WkNTKzVDc3hhRE8wb3FpMWVyV1hHZ09ZQmgx?=
 =?utf-8?B?ZndRcU8wTDdHd1lrRHliT0VkcCtXYnZDdGYvUlRQSGI4WUVZdEw4SSsxTThH?=
 =?utf-8?B?bXE2ZEpGWjdlOHZrTUJ3bUlBaGk2RjFVQnZRTUFuWllvTDdheS9lSzNGMGZu?=
 =?utf-8?B?VkdBWnE5ZE94MXZXdUZXN1pnbTk4UDZNeEhhek53R2FwTWFzN1c0U0trRFV4?=
 =?utf-8?B?d2ZRbEV5NUNwQWhrUlZTU1IxNmRMWHppWUQ5TTNWVHlqMlg5bFVNSTdLMlo5?=
 =?utf-8?B?N3Jkc3VVaXZyZ2Zya3owb3ZKRWJMMGFFRUdoYjdES2lFTWFUeTNnT3hRSHNz?=
 =?utf-8?B?dStkNFdwYzB0dTQ3NklVcEV5dStKNzBwVzJYbW9oZHdtQmNzRVo2dDEzV1Yx?=
 =?utf-8?B?UmZnRXIzMGE4SlY2cnVnaXdTRVBjNENPV2hBYjQyZnhyMFBQd0RFRWhrT0t1?=
 =?utf-8?B?UGwyUnk1MkR6Y3IzbHBNa3ZETzZrZkpMak9KNXd1eTFNVmJLTENBWG83ME1y?=
 =?utf-8?B?QnRpM0k0eWJPS2dwMSsrSFdkaWR4YmI4ZUdmRGRnb2FVRHgyRzdBOTRYUnIy?=
 =?utf-8?B?ZzZMWkNIdkpmUzJvZ1FZcjVERWQxdTdFRjlYZ3pvenZyWHIyK1MwcnpQV1hT?=
 =?utf-8?B?UGwyUFlSNHRGQzBuYXVBbWhGYUlWVUZKTmt3Zjk0UURxY3MwUHZkRlVjeHdX?=
 =?utf-8?B?UFR3V1MrRURYT2YwOFkxWTJLZmNHQUY4RlFEdVE0YXRjRlBZakdqOHlCQktY?=
 =?utf-8?Q?BDfrO4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdwalZTYVJHNjRIU1BiSlYyNHRtTlRGc3RNeTdXcEUvUlJmRGwzazdWcXlt?=
 =?utf-8?B?b0prVnBybnVKK0RjTEllVEVoUGgxek54ckV6cjQ0VElia0hGcVBJdVNHKzdF?=
 =?utf-8?B?aWtudEJvOWJFbk9XNnJrZWhnV1JPRHRNTDIwZE5TcjFONmN5WnRxZ05udzht?=
 =?utf-8?B?ZXV3UW9YS3NFNkp1RUY4QXNEaCtMN3hZOFpCdURoWklFYVZKanNxeHBSVWVn?=
 =?utf-8?B?L3g5RUZidG40b2swMVBHZ0ZRdFpPVFhZU0RqTE5BejV5R3h1TzlmMm4zalhN?=
 =?utf-8?B?U1h0QTNUU2dNQzE5MGRKWVI1dGYxWlV3MGp1VTk0TUdTTEZiYTdTQkpFaUdv?=
 =?utf-8?B?R0J6WnJIWFAzWnJQV29kMVlXcGQ1aDk4Q25oRFk4K2pJM3FJc2dHajBiL3Vo?=
 =?utf-8?B?WWxkOEhqQkNTKzB6VTI0N0ZXNUx5TE5GZXk4aUhqZWE2RFNuQkR0RFY1RTUr?=
 =?utf-8?B?TVFkMzlaY1l6bStRelI1RlJmWjZNTjZJbWIyUDd4d21ZbXdlZVFrMWRUQWI1?=
 =?utf-8?B?eWtNbUZ0L2FxZGg5QXZIclY3eGZwM0pPMkFiMW03d01jWnd1MkpHR1NpanV6?=
 =?utf-8?B?MW5VbjlKMjloR3B4OW8xNlhWcy9OR3RTRis3NzVpUVJQekpsaG1kcktnMDlK?=
 =?utf-8?B?eTJJQktQOEcwKzRZVFNhU3VwZUszY3dKMTBoQWtXNHhkUDBFL2V3THRQRFI0?=
 =?utf-8?B?TVJ1QW5CWE9zei90MURCa1ZyQlcrM1U2ek1pWERGMGZTM1h3c3IyTkxYblV0?=
 =?utf-8?B?aXBkaXh6K0JqQ3VaVDRJMFVVQkV2R1JtSld1ZFNpeEl0eStZSmVweWRQU0NX?=
 =?utf-8?B?TmYxNWM1RllzWWEzeFRDQ2pBa05oSmh3eWZqRzVrTXdhdENVdkdrSzM2bWdY?=
 =?utf-8?B?bXhKZHlSemJLVDVqSlM1aEhOZ0hBQmR5OEJkSUdwcjRrQ2lHWVN1QWFldTFh?=
 =?utf-8?B?ZjQrRHl0VituelFRZ2VsNEFzcTZuT3lFZmNFMDVvUUZDblJCbEdGSEREaVV0?=
 =?utf-8?B?aWJmbDYwT1RMZjFvL04wNHNFaExBZ29sM293VkFVRHpGaHR4dGpmMU02MG05?=
 =?utf-8?B?VW5NaUZvZ1RwWWg4RkhPdFZPZUhuWnd4TnBOS0xkd3JvZHdzbkExVjUrVVd2?=
 =?utf-8?B?V1ZRYngzTURTWGpRQUpiU1FqMEMzR2VWeThQa1FqSjN1NjV5MzVXL0FNdEFC?=
 =?utf-8?B?MC93bHVqb01LRDVMN2tEK1Q1V0hSU0tGczB6MFBaZGlWdVpSVnBmUUdqdngz?=
 =?utf-8?B?b2VXQm9PVE4rc05uY0U4T0Y1ODVCMUc0cXhTSmJzZnZNVmdsV2cxWHdOcWFS?=
 =?utf-8?B?OFBoZVA5NU1FMVpRcm1JQk4zNnptbHJQblAvaVY0TWhzT1JMdDNienVaVGw2?=
 =?utf-8?B?WlBWYW0za0gyNXhRbkh6elhwMXMvaEZvTm5qQXpoTUZOd1ZIOEJTWWE1MUhJ?=
 =?utf-8?B?S0R4b0t3Z01DYzd2Y3haVWxWbkVuQkVIVkpFY2hnWVZqNVpRUEErSFRTM05i?=
 =?utf-8?B?aElVcWJ6bWhSdW5rMStpWjRkQk56WklxY0JudXU1S3ZRMnFGak44ZU80MERF?=
 =?utf-8?B?R0JIdVlZWHAzQm40REFnQVNsV1cxcEROdld2TXp5emd5R3BZWXdkbXllUkFp?=
 =?utf-8?B?UDkzVE5GR25MbmlLdmw4Y1JXdG5sMHcxYzVSNnh6NWJHY1h3VTUrMkVNZzBt?=
 =?utf-8?B?M3Z4eFRCMFFkWU5wSjFyZWxwSmsxR0Z6elZ4Q2RQT3VPMFZNcUljRmdrZHRF?=
 =?utf-8?B?YVF0SmtyaWhteGlyaDBaNGtyeW9JcnpFTnNjTzZPUWVGM011UHN1RmZBUWdo?=
 =?utf-8?B?aUMvUlg5dUQvZy92Slh6SUtRVTNJTnlhV3orYmROZERGNHNBbHJtaFQwTXdp?=
 =?utf-8?B?ekIyWVhqdmd4WFhHUkMvejl3MXhFUGw4QXJYcFZJY3BsamJ2OVFyaENkUHJZ?=
 =?utf-8?B?NWtpSUsrZU5ySkh3a2ZkL0h6OStuZEVuTUdxRkZJSm8rOVc0Q2lkSlVPSjkz?=
 =?utf-8?B?b2JZUXllUStSZ3Z6ZnVoMGlHY1FBYmhmYXBHV0ZwVzFyTkdRV0prOXU3dnlv?=
 =?utf-8?B?STdYSjRQenVoK1hOM0U4U0JIRm9rL2tJRkMxK1RSMmtDeDJ4UjlDVmRraFly?=
 =?utf-8?B?b2JFWFFkSTViVDBxYVVGdEk4em0vWkJxbmdFUXc4RFd4L3FVWm1LL1Z3TXZY?=
 =?utf-8?B?ZGdIa0R5WnExamZDbUYremlBOURtdllvbEg3UzR0Wk9kbDYrNHNCSUJhVStz?=
 =?utf-8?B?R3kwZE5UcUN3a1Bad1ZFSmdHNDVSOTE0NjlaS1MvQjRaU1hQOWFzMkpsS3NP?=
 =?utf-8?B?ZENrMUtpVmNFWkpqZnVrTnRpQUJQYjRoSUk0UzRmYnNudG9XdWdoaDczRkNz?=
 =?utf-8?Q?agmrtZGnrDwD2amk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f605c67-cecc-46eb-aa6d-08de5d799864
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:56:36.6068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFlUAhkCRhqqHz6qjB851LpkF8G9S8OqwGLA//atriNJLiwmAsZnl3p8HR2WRKvzICfl9rmMO9ngFXkfWYa1tdHcMxInXrYF/FiGd5BNK1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7303
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


On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
> case.
>
> This scrubbing implementation turns the caches on temporarily,
> then overwrites the whole RAM with zeroes, flushes the caches and turns
> them off again. This provides satisfactory performance.
>
> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
> Preparation for Gen5 uses the same memory initialization function as
> Arria10.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
>   drivers/ddr/altera/Makefile        |  4 +-
>   drivers/ddr/altera/sdram_arria10.c | 25 +++-------
>   drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
>   drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h   | 11 +++++
>   6 files changed, 115 insertions(+), 21 deletions(-)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index df79cfe0f7f..5c78a4c1fea 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -27,6 +27,8 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +static struct bd_info bdata __attribute__ ((section(".data")));
> +
>   u32 spl_boot_device(void)
>   {
>   	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
> @@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
>   	/* enable console uart printing */
>   	preloader_console_init();
>   
> +	gd->bd = &bdata;
> +
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret) {
>   		debug("DRAM init failed: %d\n", ret);
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> index 7ed43965be5..b9e3302d714 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -7,8 +7,8 @@
>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>   
>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
> +obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>   obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>   obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>   obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
> index d3305a6c82d..0e3a1d42f34 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -21,9 +21,14 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
> +#include <linux/sizes.h>
> +
> +#include "sdram_soc32.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +#define PGTABLE_OFF	0x4000
> +
>   static void sdram_mmr_init(void);
>   static u64 sdram_size_calc(void);
>   
> @@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>   		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>   }
>   
> -/* Initialize SDRAM ECC bits to avoid false DBE */
> -static void sdram_init_ecc_bits(u32 size)
> -{
> -	icache_enable();
> -
> -	memset(0, 0, 0x8000);
> -	gd->arch.tlb_addr = 0x4000;
> -	gd->arch.tlb_size = PGTABLE_SIZE;
> -
> -	dcache_enable();
> -
> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -	memset((void *)0x8000, 0, size - 0x8000);
> -	flush_dcache_all();
> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> -	dcache_disable();
> -}
> -
>   /* Function to startup the SDRAM*/
>   static int sdram_startup(void)
>   {
> @@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
>   		puts("FW: Error Configuring Firewall\n");
>   
>   	if (sdram_is_ecc_enabled())
> -		sdram_init_ecc_bits(gd->ram_size);
> +		sdram_init_ecc_bits();
>   
>   	return 0;
>   }
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 3c79bb11802..7a0a043557b 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright Altera Corporation (C) 2014-2015
>    */
> +#include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> @@ -17,8 +18,12 @@
>   #include <asm/bitops.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
> +#include <linux/sizes.h>
>   
>   #include "sequencer.h"
> +#include "sdram_soc32.h"
> +
> +#define PGTABLE_OFF	0x4000
>   
>   #ifdef CONFIG_XPL_BUILD
>   
> @@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>   	return temp;
>   }
>   
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +	return !!(readl(&sdr_ctrl->ctrl_cfg) &
> +		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
> +}
> +
>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>   {
>   	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
> @@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> +	if (sdram_is_ecc_enabled(sdr_ctrl)) {
> +		/* Must set USEECCASDATA to 0 if ECC is enabled */
> +		clrbits_le32(&sdr_ctrl->static_cfg,
> +			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
> +		sdram_init_ecc_bits();
> +	}
> +
>   	/* Sanity check ensure correct SDRAM size specified */
>   	if (get_ram_size(0, sdram_size) != sdram_size) {
>   		puts("SDRAM size check failed!\n");
> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
> new file mode 100644
> index 00000000000..b8b42ef8e03
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include "sdram_soc32.h"
> +#include <string.h>
> +#include <linux/sizes.h>
> +#include <cpu_func.h>
> +#include <watchdog.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#if !defined(CONFIG_HW_WATCHDOG)
> +#include <asm/arch/reset_manager.h>
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define PGTABLE_OFF	0x4000
> +
> +/* Initialize SDRAM ECC bits to avoid false DBE */
> +void sdram_init_ecc_bits(void)
> +{
> +	u32 start;
> +	phys_addr_t start_addr;
> +	phys_size_t size, size_init;
> +
> +	start = get_timer(0);
> +
> +	start_addr = gd->bd->bi_dram[0].start;
> +	size = gd->bd->bi_dram[0].size;
> +
> +	printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
> +
> +	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
> +	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
> +	size -= PGTABLE_OFF + PGTABLE_SIZE;
> +
> +	dcache_enable();
> +
> +	while (size > 0) {
> +		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
> +		memset((void *)start_addr, 0, size_init);
> +		size -= size_init;
> +		start_addr += size_init;
> +
> +#ifdef CONFIG_HW_WATCHDOG
> +		/*
> +		 * In case the watchdog is enabled, make sure to
> +		 * (re-)configure watchdog so that the defined timeout is
> +		 * valid.
> +		 */
> +		debug("%s: %d\n", __func__, __LINE__);
> +		hw_watchdog_init();
> +#else
> +		/*
> +		 * If the HW watchdog is NOT enabled, make sure it is not
> +		 * running, because it is enabled in the preloader and
> +		 * causing boot loop if is not handled.
> +		 */
> +		debug("%s: %d\n", __func__, __LINE__);
> +		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +		socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +#endif
> +	}
> +
> +	dcache_disable();
> +
> +	printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
> +	       (u32)get_timer(start));
> +}
> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
> new file mode 100644
> index 00000000000..85a951a5a74
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#ifndef	_SDRAM_SOC32_H_
> +#define	_SDRAM_SOC32_H_
> +
> +void sdram_init_ecc_bits(void);
> +
> +#endif /* _SDRAM_SOC32_H_ */


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

