Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104AACCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 14:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368578383E;
	Sun, 12 Oct 2025 16:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4vCSncsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4B58383F; Sun, 12 Oct 2025 16:22:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A705837F2
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3EuZ5xsT260KjbUXTbiDVg3LTDx77ZRY9qvGodMP0GTbABg5UazpIPRueVj4hHq1pY4rdkVzYenpjjqiV56q2dy7M9TRhmokIuSRr+y5yJ2sS5Aff/pwnr71MUO2ovzvIzQZs70GEiNR/ydQU9FpGWamvcbIWgF/VhGie9hlQYuTfv60+RODFLFwS0SwU3QmU4o9J2XLtNPlGPd3aJnVF3Ztt0pOym5NO8GqFYvBtqQRKpJ2q1V0swxr34H1zyxxNi3xB8dbjP/bnYaducc57KcBMnhdKlP4oU2uCv+qQBV9CnBZUWmnoTbEu+qslNxUfonw9YgzQxyllSyrZIkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqPYQR8s23XC0mv7PkKpVpQPRQ8AtdIkSvtVHbcCt6M=;
 b=rKeZWnj6Drjk+/1X2lnWu6Bi2ZHyZYSJ6khUdGDlSr0hzbpikDuckHRlW/lSscNWK3xzFauCTF4pno9bYDi8koYoMO2pgZuceO/iHr4xCIX4Hwt7o4QMNmDjS6TMNINY0Gm/cY4+3ACD+uSiPNxhJVvhfIPI/wzx9PJIUc5ires5cgCj6Zjx/3j/e63mqPa/L33W3/8ilLtWIVUfDF75Lhtdm2+6ek76hnaFBq2ABZV0HAag4dVPx7HWy+IO99cM313RVnPyJ9ZL8POwEnBjv2tIG68qTTo/xILfcnrew8eBKDj3Rmvw6W6PulAQ45Xm63TVi0o7WYJG7w/S6aPJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqPYQR8s23XC0mv7PkKpVpQPRQ8AtdIkSvtVHbcCt6M=;
 b=4vCSncshX6pqTvXnaK0cMBchijDDyvpY7kbdLF9qx3B7fZThrdZ2BJDJGNBpcbAf6WaqKzRXTZnqwgJuuofKpRD2glaNzylE33MrNHVbG9phM/gM3gPde/wW0al4d7uM9sSiNoj/07fod1U3maEzArTfYf+j7eoguwl793nHXf+BHCTVpsINKJKrT3Aw/2CWmTq5gkTb6WlSzlgCcpUyPM1BKv6ya/c5xSDblJBVi/mWTfMJigl+d1NcTWougdNYOfuYYiCVVpMMLVxDd/7LpiUkQESg1ugBhE3Xm8qMkkEqjm0DkiZxii8lpU7V5PpYA6474UpXvaT/3hTxJsX3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB7845.eurprd08.prod.outlook.com (2603:10a6:150:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 14:22:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 14:22:18 +0000
Message-ID: <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
Date: Sun, 12 Oct 2025 17:22:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251011180636.GM298503@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251011180636.GM298503@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR2P264CA0130.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ab96cd-d852-4204-9d3a-08de099abfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlDS0NicFlMeFJjNlpOWksrU1EwRS9PRG0rWTJ5YU1naGNIdWRpb2NpOHEz?=
 =?utf-8?B?ZUFDRXRYRGQrbnh2MFVqWUpKbUxCTEJUVWg1RFVZREJaUkg2NUNTQkxkWWZB?=
 =?utf-8?B?dko0ME40K1hSVHAzSTJMMW1zVnJEcjlXaUhlUHJYblpScDlST2t6eUtpc21G?=
 =?utf-8?B?R29PRTNWLzB5Z2tRK2t2KzE1bktoVFFxSkdRQmgyeFdCUUJJM2ZHZG1aL2Z1?=
 =?utf-8?B?OFQ2cFFUNUMrRGRlQ3BDSW9NNUF2VW56dy82eEU4djZ0ZzhMK1VHRzg3dHFt?=
 =?utf-8?B?Z3ZMM3FUejNIZ2w2VmJIQXNFMXNxNzVXUVduZTZONW1XY2NtejhIQzZYWHJF?=
 =?utf-8?B?WmYwZjYvTmNiaTBzSDFQWHFRc0xEYlBRVjZ3YkZnS3JYR1hINTdqdWMxZVpa?=
 =?utf-8?B?cmkwWWgzY3JZdWVvd0pwMlVMWE1ac0hiU05GVUc2bitWb0VSanNMQ2FuQjh0?=
 =?utf-8?B?T04vQ2w2Z01Hd0p3UldYMWhXbWxBNzZPMWRkNnBNeVQ0VldlcHZkMzdrRkxl?=
 =?utf-8?B?RFlFNGg2dzFvSzNvVWMvSnl1NFQwSDVCYWpGdUJkakVoN25vT1Z0V1BqWWZi?=
 =?utf-8?B?bmUwcEEzZytRdTVBcnRIM0tjSkgxMWR5L0dKNjBQSllWVTdqQTFwWFpBZnBL?=
 =?utf-8?B?NG90OTJyMlNRck9mbVZhRCs5V2cvd1FLWVNQbXp6akZOZTJ5anRWb2F0TDFh?=
 =?utf-8?B?ZjhSQVNmb3BLeVR3dGdQbStlanBRa2syYy95SDcxSVBsc3Y5cUs5R2NTTFBh?=
 =?utf-8?B?UThvN3J6RE51cjNkNjNOSWI1MWgrbEN0ZzNUNm0yVDlUSU05enp5NVEyL2F1?=
 =?utf-8?B?TlpCMWx0RWtBZ095TnZ4V25nRVBUSEo5ZlFrOUpveUszSzlGeGxWVVFSNmJr?=
 =?utf-8?B?UWRuWkl2bDllNEpVbXVLYTdBMG5QY1FRbnlvRGVlZXZPd2hwVTZqUFVQdElD?=
 =?utf-8?B?VVlDME0zOXg1QS8wdUlzMGJsYmR3dE9wNGlxZC9ocmVReDV0RHVTSFFGUE5G?=
 =?utf-8?B?a0dCVG9vWFlWUHFDS0dNOGNvUHc0aGhWYkVFbUxrR2g5T05BbmY4S21mMkgw?=
 =?utf-8?B?VHJOV3FhTEdQNUY5UEo1ZFV0akNTSGRPRTZJSTg4NFluVHVlRFQ1OFhOeWZE?=
 =?utf-8?B?L2FET3U3Sm9CQzhqOFMzdnVjOEwzVEZ2WWVUNUJVU3RNUXhMWnR6dE8rQmR5?=
 =?utf-8?B?ckNYN1FMREdrK245YkRZdGpjYlpLSHE4WWdSN3NMRHhycE5YbGZBS3kyajJ6?=
 =?utf-8?B?dFQrdjJEUlFscEhIcUZ6azl2OXJ4ejU0MmxlYzlranZ4TUN4cktZR2p3Q0Fz?=
 =?utf-8?B?OFBDL3MwRFJ6ZzhUME5aLzdkMFR6SmwrMEY0QlVBa2RLeEV4ajlWdWJ6bStN?=
 =?utf-8?B?TnVtWXVWcENYRnYvcGRHUklYNlJUcjBTZUdyejBETlZjUWMxTWZKNkdvT3dl?=
 =?utf-8?B?enNsU3hEeWo4c1ZlVnNodjlYZnFISFZQV0VNb0pmVmFxVkkwRFM5UHVTdE5y?=
 =?utf-8?B?MDZTTzFvMHNwY0JQNU54MUNRM0pFaFd2MGphUjRlb2VEQWxKbWk2eTlPVEdY?=
 =?utf-8?B?SFFHdW9YOHVWMm1PcThoRXAwbUZMQ3VPbzJYODBFVGJtVG4yTGI3KzdNY2My?=
 =?utf-8?B?cy9GVTRUdlNSMktBelNtL1VVZkM4MnhQcjBEdW84V0xZNExQMmhvYWZxRHYr?=
 =?utf-8?B?RHArUm93M0FBSDZJZWpiTFE3TnowRjVnb0JZbVNzWVQrTEdQc3llVFkvTHc3?=
 =?utf-8?B?RU16RUxaOGg1b0lQZ0t5eFQ0bjcwMzRzd1lDUVBHeTZ1MlkrMDl6QVZkTmlU?=
 =?utf-8?B?dE9VclNaaXlMakJuaEdDWXZqbE84N2NRU2VMUitaYWpiaHR1Nm1rRktoVlA5?=
 =?utf-8?B?TDlHSS9TZVZSclMwMWdPZGRIK2U5UkVDUkhqdGFUTXJMRWlKd2s3b25BL25P?=
 =?utf-8?Q?nuCH5e670uVq6xe9eLPh8nnC8DSwvcYa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBmWVFUbkpxVk1nTzZmVTFvQlZPQ2dOZ3liaVMvajZxRHRaUWx2WVFqblF0?=
 =?utf-8?B?S0pTZFhFN2tLbmRRMlpSQ1MzOWRwT3l0SkJLdUI3b3MzU2owekJQNm5TZ0I5?=
 =?utf-8?B?WWdxYkdmUVhPZkR3dk1FbDk2Q3Z1Y2xTQ0MyRDU0ZVZmcFVGeUFJRXFiNHJD?=
 =?utf-8?B?cXl2cFFCQ0FOeVQ0WU5lQXNGdUlKZW53dEpmdjVsM1RLNkQ5UU1xeVNqUFA4?=
 =?utf-8?B?OU1Od1hzRUIvZXM4c1NiRDNHNjVCTDZmc1RsVUtwR3BJdFZlNElWVld2SnBX?=
 =?utf-8?B?NVE0a0FoRjIrNVJsajUrbmEvdWZxcGdvbVNQYjhDQng5YU9hS04zMU5lSy9D?=
 =?utf-8?B?bXh4STdVYnhCK2pHTDc3cmdlMDVuZjJNS3NkdU8raTlPUXdNeXRMamdkTjlu?=
 =?utf-8?B?VGE1THp5cUxINnYvS3N0RUQ0WkVhOG9iZzZwSUliS2g2OFVVejBGMllCTWtZ?=
 =?utf-8?B?Mjcwejk2aEd5QTZtc0VhTEpyaUhQa1lESWpUczlMSmJaTXVldnlPeHBSTmlW?=
 =?utf-8?B?QmJLeGVtcWhxL3BmaFBwZnJKYm9UR0NWRGc3SitEeXpKZHAwMlk0ZklYamZ0?=
 =?utf-8?B?RituUktwQzZXRkYrSWtDbHpvUjhaRXZwRWxCQ2tvQ0FBbmttcjN4dU0rQnFU?=
 =?utf-8?B?REdhckFqVURNS0d3LzUwSjRHRzFua1J4dFRBM2VONkRySmlaUmd1SmxBRklk?=
 =?utf-8?B?bmdyakFlTCs4Qm5nNUdIZ1gzdXZCOXFsMytGMGYxUm1LUDRReC9LU0tlUzY0?=
 =?utf-8?B?V1RVS3NuTDlURXJNRW5KUTV1R1BwUVhVblY3TFI3dFpxQU9EaVoyQ2N6b0Js?=
 =?utf-8?B?aGMrcm15MVkvRVdWMzg0YnB1U1R3cW0xb0xXUDVTSHRIN0YyYmc2SjJVeFNR?=
 =?utf-8?B?UkVXZW4raHJISXVSY3lHZk5xRGpDeUdsWTlaWk9sbHdiekZRM0ZWMFQrQzBE?=
 =?utf-8?B?V203dGNDVWxuNjlIbEZkYXUwV0h3dmY5c3NWdWhWQnZ3UmxVMVRQcHFzeTNG?=
 =?utf-8?B?UjgyaHBwSEE0SlhyNGVQU3lTSU4yRHN0VXlaWFBRcTNqb1U1N3V4bDVwb1lO?=
 =?utf-8?B?cnhQTUVwMTB0WFV2SUllTWpOZnhnWW80U2lQTS9YU3AyVlZzc2tVVmZmazVB?=
 =?utf-8?B?RHVQTytaY0NpQkovcmN6YmpicWZOY1pUTEVWRHkxUVkvTVZFYXBoVmRTUFdl?=
 =?utf-8?B?djZ2NXJDSzhNWXh2OGZHWTc3VFNVQWdZaXZpUk9jUDNldXV6Rmg1K0g1N2ZC?=
 =?utf-8?B?MWV0YzFaaDdYRU5tZkU5MXFGbzhzdjRsOFJOSndyb1ZEN3c1TXdnTUlEeFpt?=
 =?utf-8?B?cUhHZmxKamRTVGNOSFowaDM4RlZZYzN0b0VhN1BYUC9NemRONTZYSlVtbnJu?=
 =?utf-8?B?SVhMbGM3Vys2SHVJSHExcUNJbldlMERFcUVLM2xXRVlZYnl4SllkcmxCOHNp?=
 =?utf-8?B?dG5CZjdCM3hwemNrQzhtTkpweUwxQ1gyUkM3TFlpN0FDQ1kwU1A2dmJvb1RC?=
 =?utf-8?B?RWJNeGFkMEFBanlCUjBrekVvNlJURnh1REh2cUpnWTZISFJMYzY3QXVseVRh?=
 =?utf-8?B?a2RkU0lOdGNxME1TY0dkOUE1U1JDaXkxcFlGYWFkSUhpUnhqS29aZGJMSzJx?=
 =?utf-8?B?dE5GdDFMNzdkb3ByZnJQSGlVMzhzSU1IQ3dQdXVKd3dWd2RUN21XUk9Id1BP?=
 =?utf-8?B?THp0T0pFYzlBZ1E3UDdLM09QRTVha0Rlb0FkbHNzRXM1ZnozT1JrMW9YRUkz?=
 =?utf-8?B?akZkYXpoaWtBa1c1K0pQbHlPRG1WMHdGUVBWNzA5L2drbEpMbUszUEZ3L2x0?=
 =?utf-8?B?bHVVS08vKyt0OWp6cTY5NVExYjYrZEZnTm1zd0FESWR4VDQwdkhrVjJNWHdq?=
 =?utf-8?B?eVBUbFREc2EyMGR2RGw4RVlPZmRkQWE4a0ZPL3ZOSDZHWmdBeDFBU0tDSFE0?=
 =?utf-8?B?Z2d0K0JqemRiUXMyYk5CNGNJb3o2K1VuQUpuSjRQSUs0VDBZRERuYTl6V2lH?=
 =?utf-8?B?SlVIejZzSWQrcXRsUno5Q3NaZmh1NmtZaUhmdHBHSXovSk01VWd2RkYxM3B4?=
 =?utf-8?B?TlQzeVRMZHVPdzM4WmFyR29zRlV6MkQzNTBJcHZGVElzNHdJSWZhSUc5d2FV?=
 =?utf-8?B?RWJPMm5jcUx3L1A2WHkwcDRKZzBkVWpid0NNTmVUeEdtWjVVV3p5eGxsblkv?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ab96cd-d852-4204-9d3a-08de099abfa7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 14:22:18.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXJ5BmA2ICEFoSkfGoKGk1dW1KehvRQH1TQAzVHDKPO26HvRui5A0RGwlnhRg6OazepSUH+8Fgslt/ni3yUNB+PbZmntmEd22oC+cfJGulg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7845
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


On 11.10.2025 21:06, Tom Rini wrote:
> I think unfortunately the report email for when I merged in -next was
> lost somewhere / wasn't sent. I may be able to get the details out the
> dashboard.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Fri, Oct 10, 2025 at 7:08 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 1
>    - *Defects Shown:* Showing 1 of 1 defect(s)
>
> Defect Details
>
> ** CID 537478:       Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> /drivers/spi/spi-mem.c: 528           in spi_mem_calc_op_duration()
>
>
> _____________________________________________________________________________________________
> *** CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> /drivers/spi/spi-mem.c: 528             in spi_mem_calc_op_duration()
> 522     	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) /
> (op->addr.dtr ? 2 : 1);
> 523
> 524     	/* Dummy bytes are optional for some SPI flash memory operations */
> 525     	if (op->dummy.nbytes)
> 526     		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
> (op->dummy.dtr ? 2 : 1);
> 527
>>>>     CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>>     Potentially overflowing expression "op->data.nbytes * 8U" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "u64" (64 bits, unsigned).
> 528     	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) /
> (op->data.dtr ? 2 : 1);


op->data.nbytes  comes from file drivers/mtd/nand/spi/core.c, function
spinand_select_op_variant().
According to the code the max value of op->data.nbytes is

        nanddev_per_page_oobsize(nand) + nanddev_page_size(nand)

thus it's slightly more than 4Kb (I never seen flashes with page size
large than 4Kb). According to this estimation the overflow will never
happen.

If it make sense, I can try to do something with it

Regards,
Mikhail Kshevetskiy

> 529
> 530     	return ncycles;
> 531     }
> 532     EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
> 533
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
