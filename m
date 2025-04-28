Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789FC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447888214B;
	Mon, 28 Apr 2025 12:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gps5b5fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C63D8214B; Mon, 28 Apr 2025 12:39:31 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD388216C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuGnwRhy6mXKopKikItdneOL0s41tiqlhwpVnwbB/23SVTyWbz+WdDKB+AL4Wdp/rY7qJwlHXpzhaDit3udwNlvIx3BKM8Itqufs7T5a8CtSGtMOYB1mmDL90THC+kQWLwty0HnJjVSf8LyuA6lsONxxiAhWgYLTDO7RQpVP1MkpWt+bjVoxSdznbBNU0RCTLP7i+0hhXdHAThxHtlicspvz2VbkGRC+8Nduo2VmfrUNyPTsmcusJXgHbkBYVOKEn9TA2C32smrhQ8kz89ZEB6k+7eo4Gtbn7tkru1OvfLgbHDNJdut3PfVQg5NvCmiBxIdfGJSZ2/bsQ/b0+/cPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkqenDqBFb7qxd1GNtejehb691o/o+YUW9V9gDr092Y=;
 b=SDI8g7+0cDoiXs7AWCCIdYfxy0FYE2vQ7f5UYotvB8R++6FRsPjIminea+vFeU4f3GZUw7IBIAV5XuoEqHU22k+MWIguwO/l04f4o2rQxz4yB89wg/D/9uJTAams22evx9VMS+x8DxtxKsRgS6gQopNV+h4lDNj/8kyN59HI+kOMKvr+PRpOIqnWALZ5OsM8THyumTE697RGxUHFx0uqQIah3QGK7zGfQOSZg4sYuG/ELjTRSTF3CTWA84oqt/qGtygwtzPHMlABbAb6JgnETGHuXvGIwhLEal6PmAGZvKnAa1XT5rCtHwWRG7YGqBnyS7dNzOKaXi/xpH2jPgsGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkqenDqBFb7qxd1GNtejehb691o/o+YUW9V9gDr092Y=;
 b=Gps5b5fsdJdSLXQVrmmJogHhzLPx6mv+bJi2rn0dMSWCSoXhiFGNWnfvhwKEJVshccRimQ+DrZFuI5d1LhJmnElzZZa4Kd8jGq5PN3Lj7INdF2Wzb09sSY31DWiKJqwnq5H5ARVo7ZYlGnBqlvWQjNjLpockjcolOFBWCjTcg5rPbCWyQEQo3GeCFI3kwpDve3ZMEP+2B029cZGxV17zmYbrmPc2PhimcnC1+2yCMMfFWNQFzGGgeHYalDbYaNyq9YYUPK+5UWM3rQ/NXRT0IHr/8uNFvokvliv86twsex/5bDBcddmTEjmvEqlOaWN7vNT8o3vPmei1jWlcq1ovfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:38 +0800
Subject: [PATCH v11 15/21] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-15-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: ca207d8f-04ad-49be-51e7-08dd8640f3a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjMzQXRCcVpVTlZjNkJkcWs0TVd4S2d4WTFRakpiRzNaQVJBNXRhd280V1hw?=
 =?utf-8?B?RVQyRStpQS9YbTAzby9yYjhrbUozTUcxWlEwZ0dVWVJjWWI0SlJjTVlIWDk3?=
 =?utf-8?B?U3J5OHBOb0hrQkVpdy9qTDFCbWJZZWczVTZXQ3VNbWxaUnJSWHdFaE13ZnZh?=
 =?utf-8?B?UGt6Z0lPcmZGNHNRVVBHZTYzZjVJZGpaZzM5enFKa0tIM2lUNTJFbXRtVjNa?=
 =?utf-8?B?c2orb2ZvSGFSRkt5UmV1MmJrdDM1bGNaQXVUb1B3U004aklQS1pmYVZzYkNU?=
 =?utf-8?B?SmRXMHNwaDZWTFkrS3pVdmpaOVAzT0NCdy9EUmo5V0RjRHlack1NVGxJakFn?=
 =?utf-8?B?cjZ5T01oUUo0OUVzM0ZGbTBDSXZlcHZNK1lzc2d1eENCWlVtSFlOL2VYNS9k?=
 =?utf-8?B?Q0FtOTk2ZGpoN1d6bzJ5N2YrYkVDSW9XbWtWRXgwRE5pb2NCV3Z6dm1JaTNR?=
 =?utf-8?B?MVF4UDJMV0NjZGMrdENVUnhMenJSNXR3RFRaMkFMdlVpOWpjcThNOVl3NW9I?=
 =?utf-8?B?NkJrNko4dEE5TmUwQWdPNXlmdm1aYW1wQ1BKSnZqV2M2LzNaNmhSVFBnL3M1?=
 =?utf-8?B?WjhidEVVaXhSamhQdjJmcElBN0Q5SnZmY0J5LzNmUk1jbVpZS2tzTW4vWVVi?=
 =?utf-8?B?NjltQjJmSGRvTk40QnljR1ZRZFlydmtoM2hoMkx3ZGYwb0g4SGZYYzkxR1Mx?=
 =?utf-8?B?bkRpR0RoQWh3clpqc1FicU1jRVlUSTdYeVBRQW5GQ2dPclhCeVlXZVZscmJJ?=
 =?utf-8?B?QWR4WjVTdUpsV2NINll4L0xZd1RKQXV1UTJWNTBBWWtxeEFnQUlZMVQwRmR4?=
 =?utf-8?B?OE93T3dZYnNIajV3RVZzZFhubUViYUliaGNnM1ZqN3FYWXJmUFdlUXYyNk1N?=
 =?utf-8?B?cG5oRHZ1dUdmMmZRaDRvaXJsVWZDZW9vT041ZkM5Y3U3U1hQRUNqUmxqL0t3?=
 =?utf-8?B?UXU0ZWFBelg3QjhMRkh1SmZBcFM1cFMzR2ZTY3dpOGpZd1p1MG9LeURMZXZN?=
 =?utf-8?B?Q2RBT09JWGxTdGd6TVFKSlVqVXNObGdHY0IrN0lYeWxpRGczNHZDOEdQalRo?=
 =?utf-8?B?YTdnY3JCT3dlNk44ZnZjUTFsQjVsRmJxbkhpME1zbWNXSE5OS2x5ck5ZRy9O?=
 =?utf-8?B?dEpSRlkxcUljcDMyNmdxUmt0UVltb3hWS1lVTnZOZTk0NXlrekFSKzlYaDZS?=
 =?utf-8?B?a0NtQjliSGx2RndYSWtNTFh4WWF2WmZYNTl3OFRYZWx0aWpkOFBHNUcyVFBp?=
 =?utf-8?B?SldCdFBoS1RnQjdDVE5YOERoUE9WTUxsQzltNkJxRUxOc2Zyd2lnQXl4Z0hn?=
 =?utf-8?B?UkdyVlpWUFV5RUlBVGxGS3VxVXNaMTJ2bzhuSTB5dGpJRit2ZGxESjRRR09o?=
 =?utf-8?B?QW1KQ0dFNWpETWpZVjJzcHFkeTVIYXZNc0g1VXFxdTYxWlNMZVN5dVlqMnlo?=
 =?utf-8?B?cDlBTEk0eTkxY09YUkFUME91RTVNWWtmK2JpZjhhcEJjSGdqcUoxYWF6eGFG?=
 =?utf-8?B?S2hCYUFUeWlJdkdVOVJWWHVjcXB1ZTRrcWg5OXRqS3JKUndEenRVQUdaSUtR?=
 =?utf-8?B?Z2g2ZGY2TnU4ZXMxQ3JlbXVzcGRLZklWYzZkdnVWSDc0WlFidWNYVk0zdXpS?=
 =?utf-8?B?SkRnSWdCUzNFOWVmU0ovQWNrYnNlUzZuQk4vSUVJWTZpMjFERU1NdlhYcDBq?=
 =?utf-8?B?bk5TUTlqcnhBV0Jnb0lkTzNPMTY0L3k1TU5aS3NGQjgrd0o2aVA5ckhERWI1?=
 =?utf-8?B?cEpTUHNTaWFmRGRHdHQrWVkzRWxrUFQyU0c3Tm1tNHNWRHVxanlqdlVDQmN2?=
 =?utf-8?B?Uk11M1RkZU55Y2pua2ZLKzREZGVOR3YwMkNQTHp3UEdyRkZVOWpkSjhaOUo1?=
 =?utf-8?B?bFB3eVA0a1FwYjVJVDlucE1GR0ZDWFhNM3l2MVR4eHR4Ykxld3RnNmhhbXBG?=
 =?utf-8?B?L1BXT2hRc3Q2YmNINy8zRjJxZmNxYXg5ZVVXZGxML3RGWWF4RjhYVjlocnJC?=
 =?utf-8?B?d2ZQYm1DZThRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky8ySFJQK2ZQQTBvd0wydE84MHhUcTk1SWdDc29aQWNMdGVBdktkYklTTjM4?=
 =?utf-8?B?U0ZEcGk5RHJUN0F6QkxuZE5qVGZQamNuTUN6bkh2cTQ5K21wQmtyZXFlemp6?=
 =?utf-8?B?WnUzTXl4WDJDSUcrNy9raGhoV0F3aFVMcy8rU0Rsak1YcFJWS21wRlNSOVlq?=
 =?utf-8?B?alo3Z2hlOEFZOEN4MGF2NmlHT0gwMzNpSm01WXozc1dxNGlOV1hSY0NzcWlU?=
 =?utf-8?B?S0JTT1k1WkxsVmRvVlUwd2FBT01qUlAzUlJpSm5reTFTUGJwOUNqaVczVnZR?=
 =?utf-8?B?NGNobWZGSGk2N2N4ejF3blNlZjByMzFGWGNoWlNCZkZLNGlFNWVBMVJNOW1u?=
 =?utf-8?B?aUdnSGNVTFFHVDMvTTZ5LzJoc2xTRDhnNGNiKy9xWnVwVzJUSERKa0t2Y09J?=
 =?utf-8?B?dzJnbHl2QUpYYzNLMlkxWXJuQ0dldWN6Y3VtNzZvV2NXemdtRDcvdE9mR0VC?=
 =?utf-8?B?anVZdXBLWnpPTllsTVJsbEZ2VXBOaXppYkJVUjBNMS85VDJlWm5idVJYemsz?=
 =?utf-8?B?MGVDaHNLK1lmTUZ3U3NuYVcxL3N5cFM4UFJlZ3MveTdRVzZBNE4rSXFLU0ZV?=
 =?utf-8?B?THVaK1gwZTNZdXhhaWFlWHNZWmRXV2VBSFZ4dzlkV0pMN1QyQ29JeG42d3F2?=
 =?utf-8?B?WVpYdHhNaWNoTEgrNVhHVEdsRVVFNU5YZ0g2Y0xNUzdNbk5Iai9ORUdUSHh1?=
 =?utf-8?B?RXp0V1hFSGxuNlpBSUY1NFI3WlM2ODJPcHlrTGZyZUFNU2hxTWVRUFJqUTY0?=
 =?utf-8?B?dHgwOGE5Zk5tNXh0TjAxT3N3Q3R2bzBoY3BjQmdVVHI1MVhoTmRtSmRta2V1?=
 =?utf-8?B?YTBDNmQ0R0l6N2wvNUFvcy92MXREZkgrSFJMVVA1Uzk0ZXo3K3pSMFBIdVRo?=
 =?utf-8?B?bnRmd0tWNFU0SEx0K2NEQUJjcUNRNTV2SU83eVhqZUw1SzE5T0FkQVlSZFRt?=
 =?utf-8?B?K3RWeThrb1RaUGt3andVbmxLR3ZRbFZaMTY1d1BhVHJyQTN4SzBUMitldzRt?=
 =?utf-8?B?Ujc4ODlBZWlWSGN5QThDTXVJUkE4Ujg4SkZ4QjBFM0RIbU1DT0ZwQlF6ZTVn?=
 =?utf-8?B?aWduZFVaaTNjeUgwWFVEK3BXQUJ1K2YrUDJsVWdIWUF6QXk1NkJuYTRCbS9z?=
 =?utf-8?B?UzlzZ09XcWxBdTRYM3g0cmFseGQxbmNmdnpMYlVkdk5PQUg0VEpCbHNoakVM?=
 =?utf-8?B?L2lnakF5NmloeWwwUElKNkRMV0pXOHhZeHBKVnljNDhDZzE5TDFNbGUrd2ZN?=
 =?utf-8?B?NWJvVHpGUkJra1Fzd0ZuZ1Y1V21yR3hTTlA1d0wwSElaT2MrTnlMZ3pkSU04?=
 =?utf-8?B?ZU83d3diQ3hheEtwTnBuNEVONG41dlh1T3haSlZLK1E3Mm4yVWpnRHdkY2xw?=
 =?utf-8?B?amtpSlNxWVZXblkrc2o0S2loVGdtZDFnemdKU0szaFo4YU96d25MLzNldlQr?=
 =?utf-8?B?VlpZTy9iN2E3ZGdEbWZMcUt6SE0wanI3UEc3VXlBcVNDdW9QSVNlWDBIbGhl?=
 =?utf-8?B?d3ZHWEhjNk9JaVZnZmlobzBNcVNOd3RpZjJTZFJjUTQxTkp6TVc0UkRWT2NB?=
 =?utf-8?B?VzNiWkNSemdmdHpmMEN4dUZHY1l3dGZpaTVzdVZ3bEt3a3F1bjdRVUlyL2o3?=
 =?utf-8?B?Z1M1NGNxWHZkSC9qYkNBdjFzMUtHck9OUWM2RVA1cll1ZC9xQkU2TlN4b0xJ?=
 =?utf-8?B?OU5PeThzOURPR3ZYQUdGTUg1bHErd1FqNXdFSmZrck53MllaenNOQmZnbVB4?=
 =?utf-8?B?MitXcm5vdnFVYjhDem9iSUFzaHQzS3ZkM1JKSzlqUUwzTGZ1TWZOZXV6dmp4?=
 =?utf-8?B?aDhQWW1sdEZHOHBHOUdNektab0pZQmRGdE1BWW5IZXliUERuTk1JbmorbFF5?=
 =?utf-8?B?TURQa2RRWTV5akJBTkIrTkt2VWpJREE1Y1pPMlhYdFMrR1lmbHc1RTJjWjBM?=
 =?utf-8?B?cU9lVjBwd1hTL1kyK0dHYXd0bnVRMy9PVUhVVFJ2VDdGRFRlcXhvampKb052?=
 =?utf-8?B?WkwzQmkwLzgxc01LZHE4UGlDb1JuQ0ZFTVNrSGsvbmVUYTBIVGUwWGM3Sitn?=
 =?utf-8?B?R0FYOGwvbmwvYlNXT1BOdzJIeGhXM2psNTQrb0ZuZXJUdTNCVWg3VXdlL2py?=
 =?utf-8?Q?VFE6Pl0T6PfOJe63mA6aKMJSC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca207d8f-04ad-49be-51e7-08dd8640f3a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:28.1428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGHsgWYqCpNryLCMkQnBl4W9cuUKO3reyaSWauGdgq8DYy48ihLxEiFH34jIFedjupCV3awd0zV6IATqP7FzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3..e4014226582 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX91 || IMX93
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.43.0

