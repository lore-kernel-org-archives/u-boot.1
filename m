Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87629FD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9458400F;
	Wed, 25 Feb 2026 15:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GmpBq+1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9D84021; Wed, 25 Feb 2026 15:59:58 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B836383FDC
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJFz9wYcz54kLGvBmqV4mcUCAfh3MneO1wM0LLs0AmUI+QA3S2PobqpO0Gm49u3Y7L59lqRpuIXHoj5C5AGMQBjM5cNvWhib2ioh742m9oRw26qtVrW2P5k9J0sy+AssNBvfKqd/0ti7I97/o/HNwqRQooRflUph40AK3wlQG8lGpKw7k6aMG8ZcherKRTJx4BSXSBjgxLO+4YQ/GR4eKaWjQmWu1tu/HxmON0Rwl+kSa5uM/KzypcaaRkq8FCk0yD55ZY91C6RtePIH/TwY7Pms1xcJAEFPgfnXTlGXntnnOASMGhchMP3Wloei0Mzpi5WkzYYsyW+67DEI5mHBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pftPJoqBOUBJQZsQIvX88tX/vgoRQDkre+uXObFOC/0=;
 b=r1WRWdyYS6k+Xgeq2u/WwEhakCSV758jPrccO0B3lDP/MeaQeS3hxCbpBI7cHHZPLEqCeSd4y3wXGU8Yzs6CBUK3ooVhUhcPbzUPZdAfX9bMN4gzWQTEWqzMzKzu2BdcKvewBGdGDV1j9LKrNXSWLvURhm0MZqHFAIFeDJ6Y/fM7/pU3MlLBd/+/WrHoGuJrNTyujfpncD4NlKAXnhZpozbLDq0NuQkdxlcgyunqod/WjKX0nP+lt+gLHfJ2CmZmd9qXZiN4uscsJMtVBGvdEcX1J2fGFQWj29cjr/YLFkoOdWmtVfIImuy3gmp0ELF9sMrDXcDKLGKRYYslGWpXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pftPJoqBOUBJQZsQIvX88tX/vgoRQDkre+uXObFOC/0=;
 b=GmpBq+1IUoBNx2S/BZTVzEFaihbcGSZkLZHyakLmdvLs1JsxRiS4jsSQgqhvUVCpppL6ccoOwFUWYJu+UroDUGca1W0pdXE4Un5ZA8KU+CDYSmjkt2fRnHT6cr+ug2tdrT1h0QExrKo372Y2hguakBygI/2TZEQnvZWlqwbOXYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 14:59:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:59:13 +0000
Message-ID: <a7fbfdfc-d3bb-4c84-9cf7-67d6d83f6f8b@cherry.de>
Date: Wed, 25 Feb 2026 15:59:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: Ignore phandle property when diffing base and
 U-Boot augmented DTs
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
References: <20260224-device-tree-debug-no-phandle-v1-1-10bd3f3a3498@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260224-device-tree-debug-no-phandle-v1-1-10bd3f3a3498@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5a3698-4385-43ae-7bf9-08de747e7065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: Oi1EaQqAzpx9BYBBL/b0MyhVLFTq8/6FTVtrCWvwinE2oHJd6aXcU9nRVZjpLBkrrMEe8sL1bBxbdw9v2hexc3iMyoqr7mPagIMGKlju74tO1X8YNFK5hU9+F40UjlI0wSxFR4rLLFOuqwc7lhW/r8OKXAiANwz8OLhGGx34qDMCGYUJK52hlvfAkmlYz7RPojIMz8jWUD+2ATc3BIUoBJI5Wwi4H07DspYssUzz+tT6Lpme5Ch2bJxp61JRBbS0QwuzYf/iQbsKBOmCmslq+IdmxPAgDYXc+3SNM0WPBsQFp4GDTDcs7Th102wHRYGjtSlOoCOD0G/HDwPIKQngmtyzC3CvBAaswrPLQbeZO4aXfPANR3hJWh7j+Eu7Xz0Kz8DsJOjbAuHQ31m82Ui0PM3il7koMUO35Qz7SFJpknp3UX0wbdxUdI2lFwXRM7EdX0VI/pqXqjqYuAEcRFbuu40krlgGYSA+L5CeAXgEWqivh954z1at2IsEFop+TZLbA8k00M6sC287ACYWP3Hgu5u40xg00NM22NGbo8Y3+MXMNKRsDTIysuTTqheBKBtFcVE/0+7w1dCGRJjIwbdYwR1wGUY3AK6MWUxm2XBmw4iL/19YL/ne/SNDphW8sKaqA9g7j5q9s284UFDvJWmJOUJbadMnLZQI6amG2ZeU7CXcL7b5agGxEn8DU2BdjkI+QYFzO6+5chVTJWtkY7JH3gTQfOa+i6j/Or481WXlYKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpEWm5KaUlVUy9XWE5VYStVcXVhQ21qTzBkVTBtTEVVMVJUeEM0ekxGSWFJ?=
 =?utf-8?B?Y25vSzRVWnlPQnNUR3ByQzM4NkVWUjM4WjIwbkUvSDJWNmZpYjZJenJSajhs?=
 =?utf-8?B?NVFCazVhUW1VdnJ1MVV1K0xlckpnT0pmZkxxQkFqcGVxT2V3OUx2S0NIMTI0?=
 =?utf-8?B?SlBkcEtvY212VjlYU0wzcUNTbFFYUEV2NS9RMVpxN2gyUVJjdVRhNXVxMjM1?=
 =?utf-8?B?SXNUbXlMbGRZSjBqQ1V0QkVHcU9HeUpmUzBSMjZxMjFNTHhHeVpmWFNhNlR1?=
 =?utf-8?B?ZGRhQjZsOG1CSm1FTm83S2VUM3c5Z3JGYnBOVys2SVc1MCsyZWUwWTZaeVh2?=
 =?utf-8?B?NlVwL09GUGgweHRldHVaSm9xbWZRQzM1TmVZUzVBanJFeDF4NWN4amxPZ2d4?=
 =?utf-8?B?UnFPZXFMcUVVZ3ZlN3Bqd2hvVUZVU3lpRTQ5SGttZUZsemx6WlQ2N095ekRu?=
 =?utf-8?B?TFV5Rm5LTGk1S1JNcGl3Ty9hUlRlcVRpY3VyS2djTDYyd01jak1NU1pieEls?=
 =?utf-8?B?V0JvVkZCekl4cDRJaFZLTEZJUXc2aTI3bnRVN1pWUFpNOTRlQmJZeUdiaTNq?=
 =?utf-8?B?aGhRYk1yR2JBZFI4UTlwbFl4R2F6NC9ubFl5ak9sMjdlalpYQTRDaXBBTDhv?=
 =?utf-8?B?VGV6ZGZtSTZWQStBY3hNb3JGTU94YUQ0MUJVQzRuaVJpNThJM05ZNFBKZGtR?=
 =?utf-8?B?RHIrNjNpcHVVSFpPelJxZDgvMjBFYm1sSU9KUlpGQkJ4UVUvT2ZZajlIVUI1?=
 =?utf-8?B?YWdJdU51UFhoY0tteUFrRm1uVG41bC9YY3RoUmNhTVNuR0UyZG43eUhjemZL?=
 =?utf-8?B?eXFHem1DMUk1UWxxRmZoU0xzN0szOEw4Qy9tTFJyS21nTUI0MmM3ZkV1My9l?=
 =?utf-8?B?alVvV3lkSDh2NkJGcmsyQStFdWo0ZmM3QWFxMm5uamUzUTdlWFpmMlRteTh0?=
 =?utf-8?B?SHhZVkRhSGpFUjg0c3JKTTRKelNlZ0tSMG5jM1o4U0tybUtWODQ1ZDJ6Q0Fq?=
 =?utf-8?B?d2dQUmFLdjcxc2hUbFlEL251ZlhZVXZTWXJpR05VSUJ6LzhFa0VncTR6RVJ1?=
 =?utf-8?B?THhTTGM3ZFVvYmZhMGl6QVhWRGVxQXFYdGVRaFpLSEtHQUVXUCs4RVdGM25Z?=
 =?utf-8?B?QnRSRXlEZTkvdHpoVGxQNjFHRWFMZUUzSzd3cVR0cmM4Yi9iRVZ5bFd4SFBK?=
 =?utf-8?B?MlJqUUN4ZTh6dlZXWlVXLzBnWlRJbHlLenlTVTVnTkE1dFVlWVlDNHBXSEFL?=
 =?utf-8?B?akpsOTVMSklCNnZpVHBrNitaY2NKenVGOHE3TXJla2EzNWZXRjVRY3J3N2pm?=
 =?utf-8?B?Z1BBSm5LeUowbzM0MXlXSk9najMxTTVTVGhmSTU3VU9qV2oxeEozQXhKK1JS?=
 =?utf-8?B?K2M0MzE4RDJSN2t4OWsxc3VWZmNGc2QwTDZCVWRwS05uVnVuZ0lHZFhXWWd0?=
 =?utf-8?B?RisvUmxBRFRFbjJlR1p0dHV4UC9qcTNBeVMvQjV2SEdaallTL0lncUNGNlNT?=
 =?utf-8?B?M1hVRWtBVFhoajVieC9OWEVTY3BnZ09pUkJmRGtUeTdVZWt4ZDJhc1IybktN?=
 =?utf-8?B?SlpORzJaeU9ZSU94Yk9uRVhndWxLc0J3S1NTWk1uVzk4ejh0Um1YeEEzT2Rq?=
 =?utf-8?B?ZGxvOHFQa1FsaWJjZjFzQjJ0KzI1Vjh4RlUxY3A2TjNUWlJBc3BZZnJ2VURF?=
 =?utf-8?B?QVpOWVFialF0OE5CcHVqczhXcDFIK0Y5ZVdiKzFxbk5EMjV3VEhzdGFMOVox?=
 =?utf-8?B?clAybXJkcW1FYWpMSFZTYkxzM28vdFpmcXYrbFYzWDhSS0Q3OVJwY2NtaU16?=
 =?utf-8?B?eTJoRmR1WWEvTHpEWjMxeERXSEtwTFM2Q1dJZm1FOWZZV29oZUdVbUV4MjlL?=
 =?utf-8?B?Ymo4V3lGbmMyZ2RXeTlUalRtZEh6elFybE1tYWZnelp1MEVobmt3MERXWjN0?=
 =?utf-8?B?ZzRVLy8rVUlENk0wR1NBUVlwOThoRGFWVjdaNUh6ZGhORE4xRlBqc3hicXFa?=
 =?utf-8?B?NzlTT0Yxbk8rdG5KZTk5NlNsUjgrL2p2WHBxRjVpVEN3TTBibFA0WDVJYUFF?=
 =?utf-8?B?dkFwNkk1MC9obWV6TFM1dllWemJidzlxTitmWktkQVhjTnV1aHhEKy8ybW9B?=
 =?utf-8?B?VzNvcjFjQ0pIWW9qcE5jNDdjQ2xTaE1ZUVdZTVBycGpvTmhyT0x1dnBTekxv?=
 =?utf-8?B?R08ybktQTXhRSzdoamlHcTU1UGVGU1pnUWEvczlxTTJkdDRMK0NpMEdJdUxQ?=
 =?utf-8?B?bUkxZnRIOVFZK0lwcVgwY1cxOHdyVmM4a056MlBpZXVWR3ViYWI5M2xPdEdI?=
 =?utf-8?B?dHZ3UGZJcExMSitzQUpueW5BWXQ2ZHp4S2xXTXNsSmxVcTdSRWZvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a3698-4385-43ae-7bf9-08de747e7065
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:59:13.5191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf1rki4/UmM6h/eiiaHXAVsx0Oh3I2gAYb25qYgYy1+Z6RZPZVp8sGK+yEPKATOd2SBT7VyEQ1qbsAsMkjNrM+gL8M3BLjODC24doeA/YfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117
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

Please drop this patch.

Marek had sent a patch 10 days ago on the ML already, see 
https://lore.kernel.org/u-boot/20260215140535.691319-1-marek.vasut+renesas@mailbox.org/

Cheers,
Quentin
