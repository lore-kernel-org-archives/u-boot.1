Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E82C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2EA82BF3;
	Thu, 15 May 2025 16:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="G0erhNfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9AD82AFC; Thu, 15 May 2025 16:56:49 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6EA82BF3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w10s1DuufFw7oxr3dyLmbGzjgwmNUFFMwdMEpZY0wBq9Xri3bgx61F2PWkL8THpjNvNiszKQ/jlBSajRBfmrSi9ym0f3N3vMILNDG0/YHhjllntUND47dAOrhOTvuy8IsLXD7Tb5LHW/DiEOIIG/te1zfbVVYx2mrT0yATe1wova6Jv+jdzOlsNN5QkHJPTM6LAYQpJuUKFq9BvKWlBfn6qy5QNQfyn65IG90HoC+gdHA+waxQj0x33g3o5yFrHr9ePATVuSBFveKuKW0WZlVskT3P6lmEzjcliwzuRmTtWrOt/X3Pa0qpvfuRNWaoxOM0yamq+PB8Pe+OIkq0tbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60pDMQ9v8CUqKM5ZmcIM+z+nRnkFkyEjZBNiLuUMU60=;
 b=p27tO3G0cBtaur8YJaVWK7GhHTstztQtDi63Lx3x5WOuEzpOD/lb6ugLYXVL1ZSk6Dji1TtNjkg3+yFUAVUTHDieyHSYlOpjOel14D8ss+P2FALNDgS9rcw2xa7ZlXg5bcPk+SPasYEfUtEf4fkAl+Tb0FCEHLOoaJn537DunLAX3ql7ufhdGlHHVMZ5SQD4N2v7lDCVhs0lthDZAW/EuIqJ49Ec4BngETh3kpQWG8VdpRCXoz0B9bh4S3Gtq7E5EMdx2WrrTaRN0NFLOSX0qnriNQJ7UYzx0JBxRFOZ6D/3C/wFVasFObrQAbqe5kIdPRx4yz9LluwwjLZvnHmWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60pDMQ9v8CUqKM5ZmcIM+z+nRnkFkyEjZBNiLuUMU60=;
 b=G0erhNfD5rKy2fmY03MJU9njECYguRsTEUX17tHwdt5pDXzIlFrAD0yiiM3LxjMrEn2y87utA8eAZUo7/3ai5/Vk/kw8bxFB07B52gMAMMqiTCTF+V9sL9djhcSK3Hdhadm4C4BBFaNpJdwbwzxraVW4lD3m6WGw1iRZvFIGrOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 14:56:40 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:56:40 +0000
Message-ID: <ccfbcdc4-6661-4724-89a3-32e8c4f35676@cherry.de>
Date: Thu, 15 May 2025 16:56:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fit: allow to specify RSAPSS padding salt length
 magic value
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Loic Poulain <loic.poulain@linaro.org>,
 SESA644425 <giojahermann@gmail.com>, u-boot@lists.denx.de
References: <20250411-rsapss-saltlen-v1-1-f2913c4b3415@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250411-rsapss-saltlen-v1-1-f2913c4b3415@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB8PR04MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c19596-4955-4754-bb60-08dd93c0b333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVNOUi9hWGNxSFVYY1dGbEI5Mkk0Q2NrS1gyNjhwY0ljYmRnUEorT1V3ZlJV?=
 =?utf-8?B?bkdmdVlsUnZmQWVNRVpleWlDNy82dkJOQkZCWGhWMEF4dkREbkRWMW9yVU1p?=
 =?utf-8?B?bDBwSHVEWHMrb2taZ2RNZjROSjIzNXJ4YkM4ZUR3ZVdkZ3JnREN2Um1YbEND?=
 =?utf-8?B?R2paWVNOMU9hNHlPblhldDZMYllPcHFoQlR5T0hTWVJHbmNXZHF5Mms2WUR4?=
 =?utf-8?B?OVAzZXNkWTVtdXE1VlhNTHI3YVp6K3dFSEVUWERrMy96bE0wWDhVd28wMnA5?=
 =?utf-8?B?Vjdqcjl6aGtwSE1XS295NTZTYW12MWM3bnQ3ZzEzUG9LQmFXb2EyQlhpZ0ti?=
 =?utf-8?B?Z3hYNUsrZU0wbnVhVEQvcXJFdDhyZElFQnJqY1FKRXBOZ2hpUStYUHF3UzBu?=
 =?utf-8?B?SnNzTTUyd054TWh3N1ZQRFRNYTZUbDlSWkF1OHk0cE5lOEsrOW02QXRzTlVE?=
 =?utf-8?B?MFdxQ1UvNU1LWWxyUldjaFp3U3hZbnNOVzJ2ZWgwdFQycFNseEhSNEJESEln?=
 =?utf-8?B?ZjFvaVRTS0NkM08yWHhmWjdkQ0xmUmkyNnVRRFltS3Q2QjArbUJhQ3U3bDRY?=
 =?utf-8?B?TlBJSGtOSVVIdXVuVGtpbnhZcWdLSThoL2Yzd0ZuMGd5VTVHeDR3K2pma2Vh?=
 =?utf-8?B?ZzhhVXdGL09PRXR4eFBWMjkyYnN2OTAzNml0aEp1OU90OXpzYlVjT25PMG4z?=
 =?utf-8?B?cXErRkNHdTNzQnQrSkdUTTg5SVlOSk9XVGtHUllPRUN2blRqZ3cwTVA1ZkZH?=
 =?utf-8?B?TmFrL0ZoSldDaXdtV3c5TXY5Z0ZlTEhWSlNIcUdEcXFUdkhNZlhzWjViWi90?=
 =?utf-8?B?SE8zdTRlWm5FY0hadUVLTFZaamZzK3R4SWpJMWc2c1NhVEthdXBUM2RVemlq?=
 =?utf-8?B?VTREZ3NlS2pSSEpMME94VHNzeTFyM0lkTXpwdGtPcHhyZXA2dW52dlcrTksy?=
 =?utf-8?B?aVpZQnlNTGt5TEUzZERyRzZ1TjM1TDc4WURjc3ZDL2xBZUtscU15Nm9CdWRm?=
 =?utf-8?B?Z2k4SWo3b3FXS0hXbVBvNWFyQkVDb3hERTNJU3VRNHNNakNKR2ovUVhDVXRX?=
 =?utf-8?B?Z3pHcWNtOXZCRHZrZy9sYUFGczJrbzVKZFh6S3l3dDRTNTNKNFJHMndZY2hB?=
 =?utf-8?B?Z3JNQ0taSUUwVXFPZUlWRStBSlVkNXNNa1BHWHlSOWJlSkFQVytDaW1lQUk4?=
 =?utf-8?B?VkN4TjBQZkNldmg1bXoxWFJsenY4cXZlMllWZnNBQTVrTCtTSC9rQm5zZ3NF?=
 =?utf-8?B?MlhTRmg0enQrT1NnaDJoa2cvd1pqTHZDMjVBYm9pdUF5VXBXODNWbExPTHBQ?=
 =?utf-8?B?L2p4eDdOUE5KRy81aUJNaW5IOEU1VXNoSHFlT0hram9ENjJVWncrM21ZUWV2?=
 =?utf-8?B?QVVMeEREZDVBYkEvQWp6NlBqalhSZERrdWtsQnVFTXJSTmR4Q0gyV0c3VlNB?=
 =?utf-8?B?VisxTE9BNm9tQnM4a0RITEY1MjcxL0ZzVi96aysrTk1qZWQ0NlhzRkFNaHdo?=
 =?utf-8?B?NVZ4UHBvS0NLQjRFRlhJU1Bha3Y2Y0xuVS94cG1oaURlMW8rSmVhNjkxRWpy?=
 =?utf-8?B?MGtLa3RRNWtoblIvcXV3Y1B2bFFpRzRWZDk2MlJ1WHhkU2hCYy9PWHk0REZK?=
 =?utf-8?B?VHFaQm5pR0Q5empFcURyUGpYRXJneDM2RlRWYVVUdE52OWhSU3JmbHlqR3Rn?=
 =?utf-8?B?NXYyb3VCdWkzaktPWlF2dWhicTlVNnlLNVVsTW1JT2ZQKzRlV0VVN3ZzV0sy?=
 =?utf-8?B?ekNJSFBtTW1oMktCeFF5WWp3emRBYnFxcTAxWWpKUHUvNzUyNDQ3WWlnR0xB?=
 =?utf-8?Q?QYyT8ooHx2lwCNvbIiosZAskUw+ED0nUmfHWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdHRUljYUxFZXJqYUpSa0VndTBYbmhWVXQ1MUI2YWRSWEI3TEFKMEh2ZUFs?=
 =?utf-8?B?TnFCUDYxSTVqSTNWbWFuMGJxaGpEYzhKMzk2dURjdWZ0WUFDcDFGcjBSTlRp?=
 =?utf-8?B?ZFVuWGVURHlOV2ZWNTAzZUNqUHRub1dHM1g2dFpXN0p1NlVNUGd5UXIzYUJB?=
 =?utf-8?B?cjB3VUEzODNwVVYxZXNmN24rNVBEdzBBM0lJVncxQW9MbzFVMkdVY2prM01z?=
 =?utf-8?B?MEZ3eUVDUHlsQ1BZU2NVYm52S1ROK1ZFNENzSXZsOUNWNE5tVlRLcGxkTTdR?=
 =?utf-8?B?UDVLQzI0VVRSWUtselBkZjJOLzIyVU1ET1kzZUV5dE1ad0ZtQ01seC9VYjJr?=
 =?utf-8?B?OXlXKzMvQTNhWllHQWk5MzlGZGlOQ1J5T2ZrNGNwRFVNOHh0aVFERUk2ajU3?=
 =?utf-8?B?UitVQ2I3djNSQ050RmRwYVdoK2wrOXpHVXpJekYxMHRTN1hMZHMxUnRNUVB3?=
 =?utf-8?B?QW9qelNQeld3NzY4MGZuZWRnZ3pjNTFMaWFOSk9uR0tOVXVaTTBVSU5MWXNZ?=
 =?utf-8?B?MVRIeGVEdFZBeVFEMDJVS3JsOGVZOHBzT0NxYTFXQVB5MFo2cmlrK2NhSVZS?=
 =?utf-8?B?Vkd6ZkREUUJzQlZnL1ZPYnJOaW1EMzVSbE9KZ2N3UDhEdVhmeWppMFNBV3Ra?=
 =?utf-8?B?Rm91VFBxcWNlS2w0Qys5MU81VXU2cmU1MTBCVjBnVURmZkNqdmZ1b3FxRWxU?=
 =?utf-8?B?OEhtUlJVMnBmNHJaU2cxL1hvZGI0cVJsTUJFK3VWRjVTTzkzNnNTNnhmYUY4?=
 =?utf-8?B?WGNxbnBEandXcGhLaGlINlMzeEllTmFEczJIQXdCbDJzRW03LzhMRTV6YnFm?=
 =?utf-8?B?eERDNjNrUHA1b21LdnpOdGpKM3RJc1hNL1hTYTQ2ZlpxMnU1MC9tK01lSnVO?=
 =?utf-8?B?ZGkwZHNxQ1lId3pHV3R3dXNrczY1alJ0eml0MWVGU2FiTFB0S0tkYXlRU0Q5?=
 =?utf-8?B?bU01djF1NE1YY1k5TFlpMEpWMHlkN0xRSVlBbXRrdzhkenZRL2w4S2RFVWJI?=
 =?utf-8?B?TG9rV3cyQTBGWm51MjRHbTdKcDUwYnhGMGdsbi93K09JS2pLVmlmKzlualVi?=
 =?utf-8?B?b1ovcDRVRFZiZ1F2ZG04RFFFQU9EeU04bkNUZ0psMmFrRGRVRzA0YUNES3Z3?=
 =?utf-8?B?SFU4R0VNa0sydjhnL3l0TTBaNjhtRjRNd3hpb1FsTUJnODRTY0lZVmVaTXR5?=
 =?utf-8?B?N1dINTUwTkFTMzMyWFlSbGJINjFJdnRZbEpZK2NudXNFZlBFUHB0YmJTMFdC?=
 =?utf-8?B?MlVsZlR1d3FtUmxqUEwydk5lUi9ZY1NEQ2R4OUNzd2FSVStkY0xZdXJJSGRa?=
 =?utf-8?B?M2ZYcFhQenFsL2JzM1VBNEhnREpKOWR6YzhFM2c0UUwyS0pja081bEFaRitF?=
 =?utf-8?B?QWlJbm5GVHFETTA1dDRoNC84eG9uQlJ1QzBzNklUSUgxdEQzL0tHYkdPQXJz?=
 =?utf-8?B?WEdLOWtoUjZQUWdVY3NBeFY0OVM4RThIcG1RRitQMGNsZnhMbGpySWhjU2s5?=
 =?utf-8?B?dmxXUFNXazFMSWZyc051VkRVR2xWR0NwbGJSeTM1cTFkZUg0V0lEVm9MY0ow?=
 =?utf-8?B?YnlnZG5Lakd5R0ZsZTJFWmhINXc4Q1FzRG5NT1VQcEQ5cHJhSnR0bjZITGVo?=
 =?utf-8?B?SjdHT3dSdlZlRFJIeEwyMVJPMGNVR0hJSG0wWjRZSU40a0ZqZTJ1MHh5UVlR?=
 =?utf-8?B?enI5Q1ZNUUFMUDQ0dmpReUQ3REIrZ2VPMndUenFNMi9veGZ4OEVaWE1seEph?=
 =?utf-8?B?WGk0Vjh1RG1Na0NLQUJybGp4V21HRjBaNGwrRnBKS2FBbEZ1M1lwa1EwNVJQ?=
 =?utf-8?B?cnVYM0dGVUhIM2lyRzhGWVR1Q3l2dzgvaU9lTkhlb0N0QjRnU0pFVjI5YWsy?=
 =?utf-8?B?VUJ2dldLMTdyNzZsUUF2THQycFhsNDd2aElReGx5OGJKQTRVNHZBSXdJanJs?=
 =?utf-8?B?dVVtRHUyWmtsbE5ucytwWXh1RHdZbms1SkJwUGcxaGpISUNHTEFYOHVHT1g2?=
 =?utf-8?B?MHNVdFRSa2VKa0FqNmNOckNGTnc1RnNTQzJWYzFscDJjMDRrV1VhVXg1TGtO?=
 =?utf-8?B?V0VHV1ltU29WQUhOY2JtK2d1cUMvcFFCSThjVGNRWXUzcHhvU1Jland4dmRK?=
 =?utf-8?B?eFB6R1FLaGFvVEdINk01aS83a2p0NWFDMTJ5Y0lFRURwNS9OSk95TFUxQ09k?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c19596-4955-4754-bb60-08dd93c0b333
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:56:40.7787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/SXt1/TdeSqa6wTnjKlhHijvkR7YUcvx0xfe3mk8Siox0afrceWiDW+Ofinv5TvrF97M3YD52ojZekWGM1PmVKiC+NXkV/CNMgF6ogmIx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7162
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

Hi all,

Gentle ping, anything to say/suggest?

Cheers,
Quentin

On 4/11/25 6:32 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Before commit 1b99c15d73c1 ("lib: rsa: Set conventional salt length
> RSA-PSS parameter"), the salt length for PSS padding was openSSL's
> default. Prior to openSSL 3.1, this was the maximum allowed value ("max"
> when passed from CLI or RSA_PSS_SALTLEN_MAX (-3) if from library).[1]
> Starting from 3.1, the default is now "maximized up to the digest
> length" ("auto-digestmax" from CLI or RSA_PSS_SALTLEN_AUTO_DIGEST_MAX
> (-4) from library).[2]
> 
> After commit 1b99c15d73c1 ("lib: rsa: Set conventional salt length
> RSA-PSS parameter"), the salt length has been forced to the digest
> length, but manually instead of using "digest" from CLI or
> RSA_PSS_SALTLEN_DIGEST from lib.
> 
> Before commit 81eff51047e2 ("lib: rsa: Update function
> padding_pss_verify (any-salt)"), verifying a signature with PSS padding
> could only be done when the padding was using the max value for the salt
> length. While that is now history and the code should now detect the
> appropriate length when verifying, this lack of support in older
> versions bring some issue. Indeed, U-Boot is typically split in two
> binaries (at least on Rockchip platforms), one for U-Boot FIT (with
> U-Boot proper, TF-A, TEE, etc..) which can be signed and one for the
> stage(s) before U-Boot proper, who's in charge of verifying the FIT
> signature. It would be possible to update only U-Boot FIT and not the
> other prior stages binary in which case the device would be bricked if
> it has a pre-81eff51047e2 prior stages with a U-Boot FIT signed from
> post-1b99c15d73c1 or from pre-1b99c15d73c1 with openSSL >= 3.1.
> 
> This introduces a "padding-saltlen" string property to the signature
> node of a FIT node which expects the CLI name of the openSSL option for
> setting the RSAPSS padding salt length, it can be:
> - "max"
> - "digest"
> - "auto" ("max" alias, but U-Boot internals pass "auto" to openSSL)
> - "auto-digestmax" (only available on openSSL >= 3.1)
> 
> If it is missing, "digest" is assumed, to match current behavior.
> 
> Note that while openSSL allows to pass the length as number, the string
> magic values are represented as negative numbers. FDT only allowing
> u32/u64 for numbers, we cannot represent those negative numbers in the
> same property as the magic string values. Hence the choice to go with a
> string property.
> 
> [1] https://docs.openssl.org/3.0/man3/EVP_PKEY_CTX_ctrl/#rsa-parameters
> [2] https://docs.openssl.org/3.4/man3/EVP_PKEY_CTX_ctrl/#rsa-parameters
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> How to test:
> - generate keys and certs at the root of U-Boot's source directory:
>    - openssl genpkey -algorithm RSA -out dev.key \
> 	  -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_keygen_pubexp:65537
>    - openssl req -batch -new -x509 -key dev.key -out dev.crt
> - apply the following diff for generating signed U-Boot FIT + adding the
>    pubkey to U-Boot SPL + making signature verification required:
> 
>   diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>   index c8c928c7e50..e5fd8c73602 100644
>   --- a/arch/arm/dts/rockchip-u-boot.dtsi
>   +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>   @@ -29,7 +29,14 @@
>    			u-boot-tpl {
>    			};
>    #endif
>   -			u-boot-spl {
>   +			section {
>   +				u-boot-spl-nodtb {
>   +				};
>   +				u-boot-spl-pubkey-dtb {
>   +					algo = "sha256,rsa2048";
>   +					required = "conf";
>   +					key-name-hint = "dev";
>   +				};
>    			};
>    		};
>    
>   @@ -45,6 +52,7 @@
>    			filename = "u-boot.itb";
>    			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>    			fit,align = <512>;
>   +			fit,sign;
>    			offset = <CONFIG_SPL_PAD_TO>;
>    			images {
>    				u-boot {
>   @@ -162,6 +170,13 @@
>    					fit,firmware = "op-tee", "u-boot";
>    #endif
>    					fit,loadables;
>   +
>   +					signature {
>   +						algo = "sha256,rsa2048";
>   +						key-name-hint = "dev";
>   +						padding = "pss";
>   +						sign-images = "fdt", "loadables", "firmware";
>   +					};
>    				};
>    			};
>    		};
> 
> You need RSA and RSAPSS support in SPL for this to work (it'll compile
> just fine but always fail to verify).
> 
> It'll successfully boot.
> 
> Now revert commit 81eff51047e2 ("lib: rsa: Update function
> padding_pss_verify (any-salt)") and regenerate the images.
> 
> U-Boot SPL will fail to verify U-Boot FIT signature and refuse to boot.
> 
> Now, add `padding-saltlen = "max";` to the signature node and regenerate
> the images, U-Boot SPL will now be able to verify U-Boot FIT signature.
> 
> Note that I have no security background and I essentially just made sure
> it compiles and boots (or refuses to boot).
> 
> This is marked as RFC because we would need to add the property to
> https://fitspec.osfw.foundation/#configuration-signature-nodes
> and
> https://fitspec.osfw.foundation/#image-signature-nodes
> I assume. Don't want to suggest something to the FIT spec if it's anyway
> going to be denied in U-Boot :)
> 
> Note that I actually need a patch like this (for now I just hardcoded
> the salt length to use MAX instead of digest length) for one of our
> products. I don't mind keeping it downstream but I felt like this was a
> semi-reasonable approach to making this configurable.
> 
> What do you think?
> ---
>   include/image.h    |  1 +
>   lib/rsa/rsa-sign.c | 34 +++++++++++++++++++++++++++-------
>   tools/image-host.c |  3 +++
>   3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/include/image.h b/include/image.h
> index c1db8383459c9d7ce1ecc318ccccb4627a7066e5..785852a92f838b7b89bede1c6e6c9a346a9efd1d 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1511,6 +1511,7 @@ struct image_sign_info {
>   	int required_keynode;		/* Node offset of key to use: -1=any */
>   	const char *require_keys;	/* Value for 'required' property */
>   	const char *engine_id;		/* Engine to use for signing */
> +	const char *saltlen_name;	/* OpenSSL RSA PSS salt length magic value */
>   	/*
>   	 * Note: the following two fields are always valid even w/o
>   	 * RSA_VERIFY_WITH_PKEY in order to make sure this structure is
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index fa9e143b4ca8cbc50297acdfbb4ccb39cb160f84..10b25094a2fada08eb37c38a5d618b6e07972139 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -384,7 +384,7 @@ static void rsa_engine_remove(ENGINE *e)
>   static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
>   			     struct checksum_algo *checksum_algo,
>   		const struct image_region region[], int region_count,
> -		uint8_t **sigp, uint *sig_size)
> +		uint8_t **sigp, uint *sig_size, const char *saltlen_name)
>   {
>   	EVP_PKEY_CTX *ckey;
>   	EVP_MD_CTX *context;
> @@ -423,17 +423,37 @@ static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
>   
>   	if (CONFIG_IS_ENABLED(FIT_RSASSA_PSS) && padding_algo &&
>   	    !strcmp(padding_algo->name, "pss")) {
> +		int saltlen;
> +
>   		if (EVP_PKEY_CTX_set_rsa_padding(ckey,
>   						 RSA_PKCS1_PSS_PADDING) <= 0) {
>   			ret = rsa_err("Signer padding setup failed");
>   			goto err_sign;
>   		}
>   
> -		/* Per RFC 3447 (and convention) the Typical salt length is the
> -		 * length of the output of the digest algorithm.
> -		 */
> -		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ckey,
> -						     checksum_algo->checksum_len) <= 0) {
> +		if (saltlen_name && !strcmp(saltlen_name, "max")) {
> +			saltlen = RSA_PSS_SALTLEN_MAX;
> +		} else if (saltlen_name && !strcmp(saltlen_name, "auto")) {
> +			saltlen = RSA_PSS_SALTLEN_AUTO;
> +#if OPENSSL_VERSION_NUMBER >= 0x31000000L
> +		} else if (saltlen_name && !strcmp(saltlen_name, "auto-digestmax")) {
> +			saltlen = RSA_PSS_SALTLEN_AUTO_DIGEST_MAX;
> +#endif
> +		} else if (saltlen_name && !strcmp(saltlen_name, "digest")) {
> +			saltlen = RSA_PSS_SALTLEN_DIGEST;
> +		} else if (saltlen_name) {
> +			fprintf(stderr, "Invalid salt length '%s'\n", saltlen_name);
> +			rsa_err("Invalid salt length");
> +			goto err_sign;
> +		} else {
> +			/* Per RFC 3447 (and convention) the Typical salt length is the
> +			 * length of the output of the digest algorithm.
> +			 */
> +			debug("padding saltlen missing, assuming \"digest\"\n");
> +			saltlen = RSA_PSS_SALTLEN_DIGEST;
> +		}
> +
> +		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ckey, saltlen) <= 0) {
>   			ret = rsa_err("Signer salt length setup failed");
>   			goto err_sign;
>   		}
> @@ -491,7 +511,7 @@ int rsa_sign(struct image_sign_info *info,
>   	if (ret)
>   		goto err_priv;
>   	ret = rsa_sign_with_key(pkey, info->padding, info->checksum, region,
> -				region_count, sigp, sig_len);
> +				region_count, sigp, sig_len, info->saltlen_name);
>   	if (ret)
>   		goto err_sign;
>   
> diff --git a/tools/image-host.c b/tools/image-host.c
> index a9b8690276386aa21983612c6a306b7897a0af26..63055f2044ac5c320c52dc87e59b275d4bc79e4a 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -175,6 +175,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
>   {
>   	const char *node_name;
>   	const char *padding_name;
> +	const char *saltlen_name;
>   
>   	node_name = fit_get_name(fit, noffset, NULL);
>   	if (!algo_name) {
> @@ -187,6 +188,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
>   	}
>   
>   	padding_name = fdt_getprop(fit, noffset, "padding", NULL);
> +	saltlen_name = fdt_getprop(fit, noffset, "padding-saltlen", NULL);
>   
>   	memset(info, '\0', sizeof(*info));
>   	info->keydir = keydir;
> @@ -198,6 +200,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
>   	info->checksum = image_get_checksum_algo(algo_name);
>   	info->crypto = image_get_crypto_algo(algo_name);
>   	info->padding = image_get_padding_algo(padding_name);
> +	info->saltlen_name = saltlen_name;
>   	info->require_keys = require_keys;
>   	info->engine_id = engine_id;
>   	if (!info->checksum || !info->crypto) {
> 
> ---
> base-commit: cb7555e93075114fe4af0adb806877ac4d4ef80d
> change-id: 20250411-rsapss-saltlen-b8d7a676565a
> 
> Best regards,

