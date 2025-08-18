Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B1FCA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBFE802C1;
	Mon, 18 Aug 2025 10:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AXBhh7pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5A1803DF; Mon, 18 Aug 2025 10:41:54 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E7280077
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTCNb8kyToDPWEJPd+o7x2PtQVNUIpJ6QXtQvtER1DW8Ode4YJzA9+K9ATamDZiuOF4OG0K70WTES/lUwbOKaR0SpYqCI8dKyhyrr61dEZ76wHhTBaYAriCx2GrJmdm1xMDpimRYc8WT50fHUFGj/DlJzYhP0k7QpO60iUAGvfxpBp5uT+WacXP2bdSOT51dRiNi1/Cb9KD4t/mzhUlV7s9RuCzKdKEhVs72LTq1hQf6mj96D73STgYUuJFIMLDOFUCaFXxrHz7l4yEGBykM17HWPBJSKZ+0b8Ae1nkA5b1CrRRvNLCXW5wkqcFx+u3jM+INga/HJji/CeTEr2ynnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OJ5Q2adnT/TVkbkmceDdI2qi2Ba7kefkM9CBhpgdcY=;
 b=eJSBDYdeO0vBqQq+uXL2ZBLKakosgeq9iN1W+7oQ4XoJyyoO3EHUHRkdszU9+PgLraG87glUmsknF56vi6kLV3otY2F5byrq+6/kJv8LmFrzVsSLnLaS7SYjqd26yQx3UXm+zxbtVNdXUgeDDeYznY+b387EIROT0XE2awxG+3C3oNuoF1itSsdwWdh3mds0K26COdF4+LcHBRV0gIR98d9G9N0Rdsd89Cu/BGTvUbvEu+rFIr/OWpxFC4sVUpauqu2VSDJ2gM5MuH+FWZRCeh09SzzDxyXn2y/crT6CtofHMOBY7lteUJ19wvLNLyBqRFgiujdq1+9TIveuEcKEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OJ5Q2adnT/TVkbkmceDdI2qi2Ba7kefkM9CBhpgdcY=;
 b=AXBhh7pieSbVhdtJiehBhmYP7xa71xPBbI3Hpbh2iBacfODgheHs3UHZrp9JqHM20OWCA4aQxgfffdgHZMBDNvtTuYO/XoZgTw/Fb0ss9mX222lJQwPHHAus7JXqIi+R9K5r202LiNIc9yY6xhEgSPh1awZ2Buer6NcnKKXaSXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:41:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:41:48 +0000
Message-ID: <3ed4d268-8911-4b4d-b2be-764de71c54c3@amd.com>
Date: Mon, 18 Aug 2025 10:41:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: axi_emac: Fix timeout test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9dd0e2-d009-477b-ec58-08ddde3311e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDIyMHBkeHIvRnQzaFlzS2VER1Y3bGhTZWJDOEJ4QVhUTzlrNEJpSU9qSC9j?=
 =?utf-8?B?L3NZTG9VVm1CdkxEa05VWXBPaHZvMVVxR2dMK2IrSHFTWFZ2Sy9WR0NCSkdR?=
 =?utf-8?B?UGRjUlJpK2JINzV1ZEdyL29oZ05odXNsTkxUYTl3U2kzbWl1NjZ3QVNPTE9E?=
 =?utf-8?B?alRHL3l4cmRuZ3d6WU1XOFJFT2N0UncwSTBNLzRsRjFHY3crbUxHMG91SHpQ?=
 =?utf-8?B?NlVXclhoRFFORmF2SG5BQXhKTjRIRUVBM3Q0dWdoenlvWVJaY25YTHcySHhV?=
 =?utf-8?B?MGVHOFkyUllicCt3d2VhQ1FuODlCeGcvaVVpMHZ6MWZSNXJZNHFTcnZ6YytQ?=
 =?utf-8?B?eHhWY1UrK1Uvc0E0WjZmL0paOVBFRTlrODhhdE1MUVMxeFpOMW9Ba0lxSU9i?=
 =?utf-8?B?SWlFYjhabGVKenBPdXA2ZVpRcWNjcVdIUGg1S1d5Y2ZVMUZtY0IyM0F4Vi9P?=
 =?utf-8?B?VkVLUTNIRmx6ME5KZ3NIMDluWjRPRVFHTGQ4aGFNU0V1RnlwZTErd2k0ZXBV?=
 =?utf-8?B?cGwrUnV0a1poaTlRRXRiVTFsK3oxYTFmR0RUb2VaNG00ZUJpYTRnZld6dVdz?=
 =?utf-8?B?RzdRNHduNDdCK3FFSjJ0d2RBVDRHRUh1QkRzRUlGMmFMT2JmQjVFc05LMDNv?=
 =?utf-8?B?blBnVkl4MzNYTDRIQStzWVRhTHlxNzFxWEJNYkhYTERYbHE2Qkk0QkRUOHYy?=
 =?utf-8?B?Z29oZ1A5T2RQOGR0cG9zM3BsSU1seTNEWVVDUFRxS3lkS2NrYTcvM0dkZHVJ?=
 =?utf-8?B?TFdVYmhmakIvNURhQzlXWVgvemw4Q1AxY0dQZXZ2S1FNMnhLSUJSVXdvSG41?=
 =?utf-8?B?azRLLzVPT3VoMy9paUlYN3VwelRVdnZRR1FjQUU5bUVLZzNUYzdVeDNMV1Zh?=
 =?utf-8?B?RXJyWmpOamgrNFZXTXp3dUtJUzRQSGk4MzAxZjB6QldBZUVLcVc5aFhzNkNC?=
 =?utf-8?B?dnJwSnJhb0xnTkp3YkR6RUQ5RlBVUDlOa1BVbEN3Q1ZrSGI5aFpPY2haRFN5?=
 =?utf-8?B?S0RSVTdvYTBOU0hJNmJmMXpSbnZNNTg4SDJqNHh6UEh5cmdQY3h1a2loeGpD?=
 =?utf-8?B?NVhrMHpnM2E4bXNoeVZTYzlScXRpR1EzbkhWSGxpNlRESk94ZlB0eHJXMSt4?=
 =?utf-8?B?emxKUmg0UTdaNnRsenp3cDNjVGRXNDBvOThHUFJRZkVGOXRPWmlrSjBQYUhB?=
 =?utf-8?B?czA4WXYxV3NETUpoMFpjVWo3c2lwRGUyMEcxS3h6MU9NazQ4TDAwZFBSVjB4?=
 =?utf-8?B?TUxUeGFCREhYY3lvNGRnL3lIUDBqdFhFY2x4b05USjVwdDZ2R05JMThZZGIw?=
 =?utf-8?B?QURYKzVIWjhlVDZiazFVaTlpYVo2OHV2REtJOWNiS3BycG1lWW1CTFZldUFO?=
 =?utf-8?B?UUVpU2JuVUxxbzhHTHBqRXdNNmFSM3E0Nm93eVBTRmVtUHd0bkEzV3plSHYz?=
 =?utf-8?B?OVcrNFR0ZVlIZ3RvNUthUCtLTkVmZ010aWpiNmpnRnFxclZUSjM0WUZLMnhx?=
 =?utf-8?B?ZjJCKzZKek1HZ2FJNDVIdW44QU03MUFNVzB0SE5QTWRQand5cXg0NTMrQ2Qw?=
 =?utf-8?B?TTNteGN3cnhRc3lVbll2aC9kd0pZczJNS09MUGVvNWJ2RS80Z21mdHpFaHVS?=
 =?utf-8?B?RForYnhmak9hbHlzTlMydEFlU1REeXozUFAxUXRnRndoUndHRzlTVStBbUFU?=
 =?utf-8?B?VmlqRndVc1h5VHhEelpic2FJTUFYVWFBWlJWRjNXeFppZHViWjZZa3gyUUEr?=
 =?utf-8?B?OFhYZmFCS2I0cGZid2NFSEdGTUlaVmViUnFCRklxVHpOdjBLdWtlMVZ4ZmtY?=
 =?utf-8?B?THh1UjMwQnlsa1hkL3pSSzdLOUMrcXhNelB0c1hxcDB2TC9wbXZGSGE3N2NF?=
 =?utf-8?B?RlI2ODhPRGFkSklYNmttY3MvN0ptNXpHYjRlNFNGQjlJdEIxRXNYYW5jVkth?=
 =?utf-8?Q?ihUXHM3CQ/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVsb0lkRXUrWWd2ZnBqN3RFV3pncFcrUWNnclNmSDhqaDZLcXREUzhkdFI0?=
 =?utf-8?B?K3owVmhjUlE4WHNvMUhIUUZSeWh0bU50VFU1b3JTYWtPaVgyWlNzWDFOL0g4?=
 =?utf-8?B?dlN4WVJzUE5ZbS85SUtnb1BsZDk5UU9zQ1BEa3cwZ0dGZmsyL2IrbXZzUGJ3?=
 =?utf-8?B?bEF3TlZPbE9rR3NmL2g2WVVCN2QwSWhIWDVML016SGxGdmxydHMybkZYdFJt?=
 =?utf-8?B?ajYybmFNK05SSUtRVjB2aUQ4amVFYjRtRkd2elk4WUpkSUF3RXNXM3BLeGxr?=
 =?utf-8?B?WTlsanowZ0NVeUIrcFRqWWZIN21GYVNWaG8xSzFUM2pzYUFHay92aTE4Q3Fv?=
 =?utf-8?B?cW5NZW8vNHU4dkN2OWlVSVQ2cWRnRDRoQ0h6UWhISkpFRVJ4ZVdLZERPcU9Q?=
 =?utf-8?B?M1EyOEwwa3pmdjhRZmdFS2dEbGhSRS9zdjMxaTBmcFNXSFZCdXdLQlVlM2ZB?=
 =?utf-8?B?TEYyMGNPK3NqWnBBUCt1RTNJK2hBUmlDRCsrRHVpdWxQZU94Wm5laTZpN3FI?=
 =?utf-8?B?U3BJZFd3RExzQjhHQzNRaGVub0pGSWpPZjZaVG5ibmNXRnIzZWpMaXppRnA5?=
 =?utf-8?B?OGhuZ2IwWkNjamR0L2E4eUkvclVQeTlNckxDSXBodjF6TG90eHhCeWVFNUhy?=
 =?utf-8?B?eUV6YzR2clhXdmx2QUtEcHBrU1MwNnZnelM4NzdKMzd3UHd5Mk5VS2FMeVM4?=
 =?utf-8?B?T2RpZjhHdDUrWWd3SmczMUlSdlFWT0FEcFg0MnkxSXEwSWl0eWhSRzdNNkxi?=
 =?utf-8?B?NlNJNjV5ZGdMVjZYL1lxNVp0Y0UyZFVMWHVNbVU5QmhzOWdURkVYekorWEkw?=
 =?utf-8?B?QTBSVTNvWkpERlhpdXRYY1N4Q2RSb3J4SXp4eml1WVhjalZ1YnJvNnF2Yysr?=
 =?utf-8?B?dzdXb0pNOWVLWmduUFpEYmh4Vy82RG84bFcxZ0p3VlZqb3puMnZNcGpkMGFh?=
 =?utf-8?B?cWg0Ym1zc2d5eDIxTERjbk94WXhoS293aWVKME5FQy93eE5Kcm5Sckh1dkov?=
 =?utf-8?B?R3QxS1NNdUtwY0oyRXlqdFFkeXhHa1UrbnVSdURNTlBGVTV4aVlxN0xOa3d4?=
 =?utf-8?B?S2l1RU0yTlBKK2dFTjJGc3paR2lWcHE5ajczdGN5M0R6L0xDc1NjVG9VRzJM?=
 =?utf-8?B?Mzg2V0ZBalREUDZXVDI0VG9hV0Q5VjM1QklnVjZLYXNLcktaKytveE5rZzNu?=
 =?utf-8?B?VXdyVmtWOTgyS1VEMnJSeEp2ZUdSSzFXdTRRWWg2QXBpZTVPRDZRVm51dDA4?=
 =?utf-8?B?RUJuVFdRRUZrcTViejQyUlJSTks3Z3FNdzlJT0tTK1ViVlZWdlliZkNuWVZ6?=
 =?utf-8?B?S0pmZ0ZLVnBYSFFwSERHSksyeVJ3ZGtRQ1hNQkFOd3Nod1BRU2I2WHBoOExo?=
 =?utf-8?B?WkdnaUlHbGNqaTJEMGI1Z3Ewdzd3dEtqWCtLQUNmR2dQMU9aT2V1ZnNRWE1G?=
 =?utf-8?B?c1UzQ1prT0lvcnk0cFlpZGJaL0c4b3NCMWd1cjh0eGhkY3Y2eWtFM3RIVVJu?=
 =?utf-8?B?Qk1DSmErenhOQTlMV2lBd0FtSXg1TmptZWxzZWhsWWlQWTVtc0pwbHBCTW5O?=
 =?utf-8?B?N1lmZ3BSQVQ0bnN2ZDl0Y2pEMTVkTGdQYzR1RzArcytreFZTZXJnNk14eEZx?=
 =?utf-8?B?SiszQnlTakp0UjQxZE4zd2R5NUE5Y3h1a0pZY1krS2x1U1g0ZFUyMmlINFNY?=
 =?utf-8?B?T250eFlYb2dYN3A3ZXJLakI1dzlNME1aU1F0SXlNcWdKdUZuR0hXUXpqbG8x?=
 =?utf-8?B?SFhNV2ZIODJINjFocllaMXA5cENVUkprS0h2R2EvVXR3MEVFN0pWbklMNmFT?=
 =?utf-8?B?Z3RTVWNvWTI2S093UmNld2t1dU5ORk00OEZBSFQ3S3hTRGZDZ2xDa3lYV1RJ?=
 =?utf-8?B?czA5ZWJKc212NUNzV2h5b053cSt4cUVmVmF6R0pmenZuNCtZQkRsMm9PVDBR?=
 =?utf-8?B?cnZsTWdWSm1pL3BZZVRmdXpVMkt4RXZPaVMxbTVMMVBqK2p3WCtObmRhSlR0?=
 =?utf-8?B?QnZUUjJmSnlFQmFXUG1hV1pnWHZORUNtRkNPNmtNazJEczVON2k0SHFoTkJq?=
 =?utf-8?B?ZjJHMnpwSitrZVVSUEplbGl4QzJmMWZSTFVLOUlBM3FjS1J1RWRJRVVhYzVO?=
 =?utf-8?Q?fm07ZsxMZt4CsIV7CxxuhfmaQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9dd0e2-d009-477b-ec58-08ddde3311e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:41:48.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0i+nXRJbn3W9/pzEBhgm2zM+mpnnP84+WBCJnkUwBIJKGDLFj7IHs3NT0pe9U5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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



On 8/6/25 13:10, Andrew Goodbody wrote:
> The timeout test in axi_dma_init is not correct due to the
> post-decrement used on the timeout variable which will mean timeout is
> not 0 if the timeout occurs. Make the timeout variable an int instead of
> a u32 and then test for timeout being -1.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/net/xilinx_axi_emac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index c8038ddef1b..c46678c1f3b 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
>   /* Reset DMA engine */
>   static void axi_dma_init(struct axidma_priv *priv)
>   {
> -	u32 timeout = 500;
> +	int timeout = 500;
>   
>   	/* Reset the engine so the hardware starts from a known state */
>   	writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
> @@ -574,7 +574,7 @@ static void axi_dma_init(struct axidma_priv *priv)
>   			break;
>   		}
>   	}
> -	if (!timeout)
> +	if (timeout == -1)
>   		printf("%s: Timeout\n", __func__);
>   }
>   
> 
> ---
> base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
> change-id: 20250806-net_xilinx_axi-9ca9a791d611
> 
> Best regards,


What about to do it like this?
diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index c8038ddef1b8..22e119370c84 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
  /* Reset DMA engine */
  static void axi_dma_init(struct axidma_priv *priv)
  {
-       u32 timeout = 500;
+       int timeout = 500;

         /* Reset the engine so the hardware starts from a known state */
         writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
@@ -571,11 +571,11 @@ static void axi_dma_init(struct axidma_priv *priv)
                 if (!((readl(&priv->dmatx->control) |
                                 readl(&priv->dmarx->control))
                                                 & XAXIDMA_CR_RESET_MASK)) {
-                       break;
+                       return;
                 }
         }
-       if (!timeout)
-               printf("%s: Timeout\n", __func__);
+
+       printf("%s: Timeout\n", __func__);
  }

  static int axiemac_start(struct udevice *dev)

M
