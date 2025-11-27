Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B2FCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 13:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A158437F;
	Thu, 27 Nov 2025 14:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="lfSBSIra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402DC843B9; Thu, 27 Nov 2025 14:44:29 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458E68437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 14:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Petr.Benes@ysoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ9TaDlH2PdX26g4ukx3AqC1Stahhi39QjPiJ5riFT1zGxenJ5TIWeSLPouAa9f1GN/cp/52GgEBSBQNwOMg4KKyB+xLUz8vyZCyuM2BCvGSJv2UU6MIVGccdEDCG0++B4+xzdYd4b6aHuYAwBLfelFIws0BbxitISURV6bZCOJYSH2vg93HmtXIQu0xCLjWWtaZuHDiO28liGPVCxjXdA+lZJdDC9M+DQl3SvfNuZV3m5gcczFZ2HmiWi1QC5Dvynt8SCS4GudHW7EMYoEIEppFoaLHVJXi7vgL8W2y+YajBd1xDJMYTAhmepFzjqm2+JDH3WLG9VKpylaBEhxi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+drawxgJXyx+skBS5193j57askQHR8ocGwQ32dfhnNo=;
 b=L+0WRv6xRbLKktyz8dsdm3+3d+3VnMOQJkX1sKRszPkSW+C6SlDgDpqTI8tZQJYQi0wPV4gEPmnmdn0Ap65CjtTdBthC6K313qYizoCJH6wBb1kdmLWkfSpxcoqfjY7kGbjVyarZd+47Oy6YK64gzsJzv4tcPMTpAapL15ntBwc0yPT+m/BHDAJN2T2ikNxuCmR2CJfpYQYnhJ5i//PvJRspiLqvG3xGcZKpS/RDXewh7UAYOSOXAFbEs4iconXZQ42YLzOUkWsxFcxNnfj77BA++y7H7JTQCAUFLsdc3gmQpE+Ro5qEkQ6Ur2EfXJp3h2oPFImb7VtP7c12BD3ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ysoft.com; dmarc=pass action=none header.from=ysoft.com;
 dkim=pass header.d=ysoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+drawxgJXyx+skBS5193j57askQHR8ocGwQ32dfhnNo=;
 b=lfSBSIradktUB0DEP5tjxQu1htoYwgA4sUbNX147FophWp36ReGuMU6u7DRj3v5sEI5dx/X5Bog10XMvJRz4yOQgbAUSpu9nJrl1XVvWcjy8Ao/3oSFoaSuOIrv33b61VkzA9rMGSUNFQmacJfM6EhbkNqDfbGzwfEdFW8fKrQqP3AyNR13FaWplmVpD+5oom/awfatbBUQBEIH8fpvRmbLJgqrXyr/1YIYUFp/0Xzgvl+t6RCzsOxrZQCv5/L/TsjohXRSfN1pCpWk2ah/oJ4PKKCGnFcP+N9golXCdSP2CVwQc6sQqRdBe+6GuMAaswoyhwk2xjXwY6Ldpqxs74w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ysoft.com;
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 13:44:22 +0000
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b]) by AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 13:44:22 +0000
Message-ID: <6cc1b997-2713-42be-9b0a-dc44db251b06@ysoft.com>
Date: Thu, 27 Nov 2025 14:44:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
 <87fr9zss1e.fsf@kernel.org>
Content-Language: en-US
From: Petr Benes <petr.benes@ysoft.com>
In-Reply-To: <87fr9zss1e.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::35) To AM9PR04MB7538.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7538:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de4d460-4dc9-4675-8cf7-08de2dbb1256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXV4SUMwUlY1WkZKcysybDBNY1Qzdmh2aWE3dmpRWWs5TVorOUljNXVBdGZt?=
 =?utf-8?B?WG9kMFpHSUlYVFNJVUg3MjU2TWY0NjVrVG13YjV6UytmSUx1anp2SFZJdkpG?=
 =?utf-8?B?Y0F5K3dhVTZPUzRxUHBtZWErUndoUjdMeWlFWE5CKzc1ck9YK3p6bDNjRUNQ?=
 =?utf-8?B?bGZaV3dNRGNNTStpaGZQVEErYlVuZ3NLV2RnRitwaVIxOEkvZFN0ckJJNlRW?=
 =?utf-8?B?eXBSMXdXZ21xZG11aENLazMxK21BZGg5dUNOVlZtODdScXRsY2dJenZuYWFl?=
 =?utf-8?B?NncrMlpDRVhLdXlaekgvelc0UDN2enRsN01IZmdPYnFCNHBRelY1d3BVUnpY?=
 =?utf-8?B?clV0U0s0VkNISzc5Z0hJbjNtMS9sSzQwWXdxdWI0dXVxYVpqdzRZc2svMHBW?=
 =?utf-8?B?OU41K0xtSlBOQ1ovRkVMQTVKV3NJejcvMDBySUlDZkYxV05PK1lXTkoxTitB?=
 =?utf-8?B?THhGaWRGT04ybUxDSEdnSjAyVFFkUzVRMVIyVHhRTmF0YVNyWE13Q3o3M1BC?=
 =?utf-8?B?WUk1MHhtcDlnQytqVnd3RUoxS0ZsM2dvbDF4M1NScit4ZDR4aTZ4dTdveEZ6?=
 =?utf-8?B?ZlZKY2F0S0pFcTBVSmVrd2oyVFVvU0hjUmJFVWhHRHptSDhJU3liUE94OFNX?=
 =?utf-8?B?R0VtTG0vOGRZVHM5VVdUL1lXVEI5bmlIM1pSbXZtZklhQStTZ3NHeEFmY2dB?=
 =?utf-8?B?Q2xkWkc1R2pDVDZQZk10Mkc1VG5ITjZwbzRUd2xMV2hBL2o2MEUyNHNLaWQz?=
 =?utf-8?B?azBvNnlPdzVDaDZSbGpDMVBocW5Cb1FLNlN1cmNWR3RKVGxZaTZPbEFQVG5q?=
 =?utf-8?B?MnRFc3dITDZ5cmFuT3NzOUV6aFBjUjRZRHlZRGk0Smt0Ym8yZU8wNHBseEUx?=
 =?utf-8?B?QlhRM1NPRjBaeXlqa3NWY3pWRVppSzh5Z1phQXFWNmgwcFpGY3E1eW9uWFJX?=
 =?utf-8?B?cTNMaExrZFRkVy9VTTZHbEtwOEJUVDJMT0VESVY3S2lrMWNablBheXVLZ1hj?=
 =?utf-8?B?V29aQU9hSlpOYnBWd2NFMjdSNGJvUnYwbGNQN1I2b3lNbkw3THRCZnQ5ZXVJ?=
 =?utf-8?B?RU5VenBxanh5UTgwKzhoeWFGVUtYdHZtMGxZbXk4emdrREVscURJcmZWRnVa?=
 =?utf-8?B?ZVpudW9QcFNZWlVNd3FaaVpxTnQxWVh4MklMeDFDT1lSWUNNamdBTHRGTzA0?=
 =?utf-8?B?ZUdMZjREMVRmVUd2ZHprbDk4TmwwM1VidFpZWURFWXJabmd0ZTM3ZXdIOGNa?=
 =?utf-8?B?dG1ZWnJ3Tjh4MWUxb1BmK2xHQjB0andhUUxaU21kdUdGNmdoZUh6VFpPbG55?=
 =?utf-8?B?dEFHWWdrUkxsS01zWFJNZ2U4SnFiU0pzSTRGK1lxb1RBWGQ1ODQwNngrSTVo?=
 =?utf-8?B?MEh5NDRlYUdZcFJ6SE9RQVRMVEo4My9yOFZFTEk3TWpEOUFYRzdPQUpLL0tT?=
 =?utf-8?B?cFNKSE14Z0hDdUhGYjNoZGlzbnZGQy9JbFFhMGZTb1pZRVREVmhkMHZuaXZ0?=
 =?utf-8?B?SEIzWm5vZDE4RmoydTZJeVFEUDM5Ty9WblhwU0hjT1ZXcDRhQmEzRE9ybExE?=
 =?utf-8?B?M3pmZHBUKzlyMTJBUmpMRCtaSjJrbUhCUy9UZnRjbXVLNFZsMUg4OGRoNnBj?=
 =?utf-8?B?YXByTEdONzJpWjhHTEYySVVkZm9valZPbUFnLzZnWkxEb0tFRHRsMDFTaTBD?=
 =?utf-8?B?S3F1Q0NKY2dFbEZBYmNBcUNscU9XVFNpSzA5ZkJMVXdQcVVscnpzWWpkUEhq?=
 =?utf-8?B?NVpWTHJwMGNWNFJlNC8yMW4xTXJtN3g2Ullwa0NuNGxNWjhwYk1zaEtGZEk5?=
 =?utf-8?B?a2UxREJWcDVQS29hTGRYeHRtYTNxUjR5bFhZeTFBT0pQSDFEL1VoMG1WV1RJ?=
 =?utf-8?B?VUQrQlk0dVd6cUVhRjZEY2N2K3RUSEFRT3ZjRmUyMVVkTVZpbFdPa1VBVXll?=
 =?utf-8?Q?4neIt3SoMCHsCDZEl8LK80H1FxNxwaxw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7538.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2M2ZVdPZ3J6Ulk5UDNKUFdFYlkzTFN6MVk0WTNMMmpHN2tFL3ZYOUdMeEhr?=
 =?utf-8?B?MWpKTmZnQmttWkptODBlQ29PZ2R3NGpNMUwzOHlkUG1NNC9kenh2VGlSNTVZ?=
 =?utf-8?B?ZnhsM0U5UUNJMU5pYVFWeGIwUVQ3aG8vMDljUVBDZnVUM2JMQVU3Wm4zYmdy?=
 =?utf-8?B?YkMrVEJ5LzFhS1ZSTHlDb2Y1VjNodGhrRk1ZUFc1SXRoOFFhbnNwbnYramFm?=
 =?utf-8?B?NzkwYW5waVJxYnBYZnVleDFEeW05bnlQMzFMN2tZaWJuaGNyREtkWVdvaXdz?=
 =?utf-8?B?anlKbS9pYWVqZStDK04reEVMclhlWjRhMEkxTSt5TkJrRUhpVnFZWXZSZERw?=
 =?utf-8?B?RktQWE8za0ZHRHNPOWl4UEdSOUdodllhYXViaXpCMDh3SkF5Q1plbjA2TFh3?=
 =?utf-8?B?UXd6alhxK0diUVJIT1dUc3dZcDg2QVJRdlBYUlNMNWh3SFdsdVN1Qy9vUkRu?=
 =?utf-8?B?Zk9JU1RDTEhFSVhaNE5vQVVTK3pmKzJmWTJoUU0xb0Z1MXpPTTFJS1pwTURH?=
 =?utf-8?B?TmFPSXZCOVh0V013ZTBzU1JJTWs4OUgyZUFTQ1AySkRnbDEvNEtQY2ZZcHZv?=
 =?utf-8?B?ZCsxempvVEdyckdEcU1LRjNCb21XcE1iV29xaEhqYVVtUzlPNFJZL1ZCUU4z?=
 =?utf-8?B?cm9WUlY5RWRpY2YyanphZWlFN1pTOEdSN1dUOW4rOUczWHkrY0NRaU1qY1Jm?=
 =?utf-8?B?Z1VFVUQzVGdKTWNjYkVQMTlEVmthR21CZDF0OU9HdVNwSXlRY2VjaWV1TFh5?=
 =?utf-8?B?dUJaRldZUjI2bmJKOEVyNm0xei91VHJFSjJxaStkNXk3YjQ2SDk5RmY3ajdp?=
 =?utf-8?B?MWJiNnRSM1JJWkxsL3l6a1VUcGI1M0pKbGVaUFNSWlFLVjBOUTNTV1FjYmgy?=
 =?utf-8?B?bk9KYjhQdkdwdFpqbUJib2ZjRWlLNUw4d1VKTE1VMVdtelpIeVcvSW1XdnI3?=
 =?utf-8?B?bXV6Um9IWk94S3NuNlNxbmIwWTc4S2RCQlh6MUVuc1pLTnNLUkpZOGRNR2E1?=
 =?utf-8?B?MytEZTA0RXN6bWNQU1hYWWNXeXFzYS9Wa0REMmJKTVd2SExnZ3BGNlliOXYx?=
 =?utf-8?B?eUYyRWw3NllpVmR2ZzlIQk1TbGRGSExzaWtzL2pURHc4NDlzS2haTXVFczZq?=
 =?utf-8?B?OEhLajFsV3pvdWJwY2NMYUVDK3EwNm5CRlBEZUE4WUtrNkdvcDBURy9oY2RY?=
 =?utf-8?B?Ym8zdXl6MGxhRlNFMWF4bUZtRUE5Q3oxd2FTbWNTMzVmaUFTYmJSR21wd1Vv?=
 =?utf-8?B?dS9kdnhaWDdDL0hWRmRXSEdCRWdkK3NmdGh1L3JSbFBtK1RCdHdLZHpmVVVj?=
 =?utf-8?B?OURmUXVKSHVmR1BmSXRoWW1LL1UvbGRiVmEvY1pMcmFQTEMzY21YMU9LN2Iw?=
 =?utf-8?B?b1g5VitVTjNzazVvSHowZ1ZWeHVicXg5V1RvYVRIVWhsR3R0eVZTbmNpdFpM?=
 =?utf-8?B?c1NHUXY4Y2RCUDl6cEJIQTd3VjRxV1BnYWUrV0tubXVtWFIzcU4rdnpldlhQ?=
 =?utf-8?B?TUQzYk53VmpvQjNNVlBkS2FML3ZySzh4QmZaOEFxbkNsMGNaWVZqMHIzc3A1?=
 =?utf-8?B?cG1lc3hWM0tqc2N2K2lQdHpxSUpiOUNhS3p2K1V5S09NN1Fac1phZC9JZDNY?=
 =?utf-8?B?U3BOc2hrWDdKZnJSS0s1TFB3bFBRM0pXTHFxdW1MMk1BN2FBZ0hLcEYrYjZo?=
 =?utf-8?B?OWdsZXVyVFFlUVUrLzVoOWE4Tmp0c2ZlaDBXRUozdTdUZnF5SElVdDIzSnRw?=
 =?utf-8?B?ckVYYWZBV2xYNlRWWW5iUG5XMDVoeE4rVzJrT1BScXY5ZUhwRVVUMStvMCtS?=
 =?utf-8?B?MEpLMnMzK1JNRjI2U3JNRURsclYxeklkYjd1c2xYYjFDNkJiN1k3Y0pJNE9k?=
 =?utf-8?B?cmxkcmcyM3pLMitCNmZoZGtacGNPOWpUZVAycW8wV0MxcHZzTDJKUG14QVBa?=
 =?utf-8?B?TVQxVWJkTE1WTEJUU1YrOUQ2bTZRL0M0Z1hvTkZGNkZLWkVCY1Q2YTE5OC9B?=
 =?utf-8?B?QmZCUUtCVFJMVGRFendEWmRJSnI4YVR0WDR6WHF2bFQ1aVFXZVgxeWZxRjRW?=
 =?utf-8?B?QkVmWTFHVWZ3QXp6UVdjRWVuNmdhUWFMYVBTT05uYlB5b3JlVmtVcXNsOEZr?=
 =?utf-8?Q?jhAabOMwpGGM5wnCcj0vq4oTA?=
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de4d460-4dc9-4675-8cf7-08de2dbb1256
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:44:22.4736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXF8zC6PYpb72LvsOf5Bzay8p5ryeIcTO7bLpf6/FxNwL7kVaC6jDjGZYPIpFUxrgOjsyX5VsaKPH5t03cTU3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
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



On 11/27/25 11:12 AM, Mattijs Korpershoek wrote:
> Hi Michal,
>
> Thank you for the patch.
>
> On Tue, Nov 25, 2025 at 09:58, Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft=
.com> wrote:
>
>> From: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>>
>> There are two places where ci_ep->desc could be accessed despite it is
>> not valid at that moment. Either the endpoint has not been enabled yet
>> or it has been disabled meanwhile (The ethernet gadged behaves this way
>> at least.). That results in dereferencing a null pointer.
>
> I wonder if this is not a generic problem (that ep->desc) is reused.
>
> Looking at usb_ep_enable() in include/linux/usb/gadget.h:
>
> """
> static inline int usb_ep_enable(struct usb_ep *ep,
>                                  const struct usb_endpoint_descriptor *de=
sc)
> {
>          int ret;
>
>          if (ep->enabled)
>                  return 0;
>
>          ret =3D ep->ops->enable(ep, desc);
>          if (ret)
>                  return ret;
> """
>
> Can you please explain why the generic code is not enough to handle
> this?

Can't speak for for generic gadget stuff without preparation. In this
case it is solely ci_udc who does the mess.

It works with its own

struct ci_ep {
        struct usb_ep ep;
        struct list_head queue;
        bool req_primed;
        const struct usb_endpoint_descriptor *desc;
};

Which are held in (struct ci_drv).ep[] and the problematic code is
ci_udc specific.

>
>>
>> Moreover, the patch gets rid of possible outstanding requests if the
>> endpoint's state changes to disabled.
>>
>> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
>> ---
>>   drivers/usb/gadget/ci_udc.c | 43 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>> index 4bff75da759d..b3bbbb6ad32c 100644
>> --- a/drivers/usb/gadget/ci_udc.c
>> +++ b/drivers/usb/gadget/ci_udc.c
>> @@ -308,6 +308,27 @@ static void ci_ep_free_request(struct usb_ep *ep, s=
truct usb_request *req)
>>        free(ci_req);
>>   }
>>
>> +static void request_complete(struct usb_ep *ep, struct ci_req *req, int=
 status)
>> +{
>> +     if (req->req.status =3D=3D -EINPROGRESS)
>> +             req->req.status =3D status;
>> +
>> +     DBG("%s: req %p complete: status %d, actual %u\n",
>> +         ep->name, req, req->req.status, req->req.actual);
>> +
>> +     req->req.complete(ep, &req->req);
>> +}
>> +
>> +static void request_complete_list(struct usb_ep *ep, struct list_head *=
list, int status)
>> +{
>> +     struct ci_req *req, *tmp_req;
>> +
>> +     list_for_each_entry_safe(req, tmp_req, list, queue) {
>> +             list_del_init(&req->queue);
>> +             request_complete(ep, req, status);
>> +     }
>> +}
>> +
>>   static void ep_enable(int num, int in, int maxpacket)
>>   {
>>        struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> @@ -335,6 +356,12 @@ static int ci_ep_enable(struct usb_ep *ep,
>>        int num, in;
>>        num =3D desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>>        in =3D (desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>> +
>> +     if (ci_ep->desc) {
>> +             DBG("%s: endpoint num %d in %d already enabled\n", __func_=
_, num, in);
>> +             return 0;
>> +     }
>> +
>>        ci_ep->desc =3D desc;
>>        ep->desc =3D desc;
>>
>> @@ -385,16 +412,27 @@ static int ep_disable(int num, int in)
>>   static int ci_ep_disable(struct usb_ep *ep)
>>   {
>>        struct ci_ep *ci_ep =3D container_of(ep, struct ci_ep, ep);
>> +     LIST_HEAD(req_list);
>>        int num, in, err;
>>
>> +     if (!ci_ep->desc) {
>> +             DBG("%s: attempt to disable a not enabled yet endpoint\n",=
 __func__);
>> +             goto nodesc;
>> +     }
>> +
>>        num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>>        in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>>
>> +     list_splice_init(&ci_ep->queue, &req_list);
>> +     request_complete_list(ep, &req_list, -ESHUTDOWN);
>> +
>>        err =3D ep_disable(num, in);
>>        if (err)
>>                return err;
>>
>>        ci_ep->desc =3D NULL;
>> +
>> +nodesc:
>>        ep->desc =3D NULL;
>>        ci_ep->req_primed =3D false;
>>        return 0;
>> @@ -606,6 +644,11 @@ static int ci_ep_queue(struct usb_ep *ep,
>>        int in, ret;
>>        int __maybe_unused num;
>>
>> +     if (!ci_ep->desc) {
>> +             DBG("%s: ci_ep->desc =3D=3D NULL, nothing to do!\n", __fun=
c__);
>> +             return -EINVAL;
>> +     }
>> +
>>        num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>>        in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>>
>> --
>> 2.43.0


________________________________

CONFIDENTIALITY NOTICE
This message is for the named person's use only. It may contain confidentia=
l, proprietary or legally privileged information.
If you receive this message in error, please immediately delete it and all =
copies of it from your system, destroy any hard copies of it and notify us =
by email to info@ysoft.com with a copy of this message. You must not, direc=
tly or indirectly, use, disclose, distribute, print or copy any part of thi=
s message if you are not the intended recipient. Y Soft and any of its subs=
idiaries each reserves the right to monitor all e-mail communications throu=
gh its networks.
Y Soft is neither liable for the proper, complete transmission of the infor=
mation contained in this communication nor any delay in its receipt. This e=
mail was scanned for the presence of computer viruses. In the unfortunate e=
vent of infection Y Soft does not accept liability.
Any views expressed in this message are those of the individual sender, exc=
ept where the message states otherwise and the sender is authorised to stat=
e them.
