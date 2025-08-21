Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B807CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B1580B9B;
	Thu, 21 Aug 2025 08:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MgngKxgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F70282AFC; Thu, 21 Aug 2025 08:26:24 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F70B80422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B17hjaElXDViQwUA7L1qAPVSN9vABP2L0acvmqq8toeB3hEpeeWCvIHDFr2jDZy+wWwZ0yGvWjKjNpt/g+ikTfJXEgS31Yv6EEBJO108pvPwTlH/pmrqXMEeDh3yQ0l6YU/5C8DVX+PENNmEDuNI6e4x4lnFkp75eJuUq2DnSljJ6DKMKqpXXRgqJv7bPh7PJdaYdmRYkDC9EAQOCEi1pEPhdOcybAtjnZ6878CzUZ5ccUMU330D1dfjwYy1sDPky70L0mfGo892NeFCpF1oR3Gts5dVF3J7jYbrCEiTqbCpu8qSQKlIFe9k3zRYAsRD0KlDiFpp1pUWEvUkm3WW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUDI7V73TFhGZnaOxthom2FxKvSBxoyCWGzwi6BV3DM=;
 b=l42vmXjHse22y+TJWkrEPudHgsj9D36+Id199a3VFTNQ1yZUyUf5CmiUvD8VDBH8Ac7kM657M/7JwpQHT8ksHg9DRFfnkNhl8yzb3tcPgLS2lJ0e61lGy8AbFi7FISiJ1lkeoS8LQPctxR0dIV3hZ2fAvXfqmT1M9a7KDn3FI/PivT0ttzIsrq6imMi1V4L6tAM84DeA4DHyzZWJSfXQkBEOB94s5Pc9pm1yePsyeohBZN0HOFfqHy0R4eqPFlNxw1+1HRhQAUidPg8s9sf1VfeuNXdjqPqOYVVNbpijMC/DgSDQrHJbsyK5/zoihUNT1U2uHIUG/XzKzHPouPUtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUDI7V73TFhGZnaOxthom2FxKvSBxoyCWGzwi6BV3DM=;
 b=MgngKxgUvFfoj+gT79SE9yeqvmpiYJENMDgJY4p/BDVaaqmKhXMtSDUG6a2PHaXDkG9TuQMqXyYkg8YKl9wOvdlhAIu7BiodQub0+qLxPnGHdsyvCFIjRDZN4ZF0a52+sKHElWCJ6L5KyiK65UTtDMiuwi7BFsyY7UbuWcU/ZcHcD/pa3p9RVR+b0v6ZvjD9ezHkbP8JU4CzWAZGC96M9MCbbxSaKxztaeh8oFMuYqihRUX5EU04v5/IttyCDLROttAZs+X83ZdPk8w1OpYGrbq4dEDnAPUjE6ztE9ciVCSssKLSwZ+pjeAtNta6k44+bk4jkZy476oxmgfzNe9RAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MW5PR03MB6984.namprd03.prod.outlook.com (2603:10b6:303:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:26:18 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:26:18 +0000
Message-ID: <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
Date: Thu, 21 Aug 2025 11:56:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::10) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MW5PR03MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1c04f-e579-431e-1ca4-08dde07ba2f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVV2QXIwWEVrTVVneGRKZ2tCZ3RVT3FUY2FBcXRwNjV1enowbE0wcEZZQk5m?=
 =?utf-8?B?MzZEalB4RHhmZGcvNXR6MkhLMCtVcS81a09mZFczcTFPV01CcUZUOUpkYk9Y?=
 =?utf-8?B?T0xZZG9CdHFqUDZxa3JoUE1qek50UTZnRWlubGpHLzMwZzArQXBOSFZaZEpJ?=
 =?utf-8?B?Tkh5bDhhMkVmdG9lbDB3b2VHWUgvVHlMRmUyRlZidVc3OWJqV0ZtY1lIZUty?=
 =?utf-8?B?TGR6UWlTUTgyZHZCTEE5WGFDZ3ZEZlY2WTRpdVAvOWc1Q2hBNWtUekRNV3BF?=
 =?utf-8?B?MUJVcnIzbzhPVmlsU1BDcElIUG5ROXo4c05KdVlPbmFobEZmUkNnVWxSNWFG?=
 =?utf-8?B?amlydDFla2V0cllGV0ZqMm90bVJHZHY0NDQ2S05vQ3hyUFRzOHAreWRJZHVF?=
 =?utf-8?B?MnJQR3l5UUR0anR1UTRSbXhCTWVHVityeTFzMU5INEUxa2FJNnNDdEFVcG9X?=
 =?utf-8?B?UXJhQ0JVZDNzZytkZ21iV2I4NENGWUNkamc4UVJnMW1oWW0yeEVmTU9nbll2?=
 =?utf-8?B?Rm13Q0N2eUNZUmQ3b0NpaUZ4VWpzL08vUHNELzRwVHVZUmNGaUhYSnlwV0RN?=
 =?utf-8?B?VWxjcUtveGF3ZHI3T2dVQ0Z2Nis4cXBFbG9uYlZINlF5R29sQ2pFbVNKaVQ1?=
 =?utf-8?B?NEVaVUloQ0wvYk9MQkpYWVhybFloVE5jZXFCbjlsMGovNUZNRkdCbXNwaFNJ?=
 =?utf-8?B?MzBEbGhCaXNDd3VuRVRYMXZYblZHNkE1N3lhUXM4cno3a1VzZ1dNMDI2SW5Y?=
 =?utf-8?B?aktQaHJtRFZnZ2dRTUVZN2E4eDBXOHB3VGN6Y1E4eGprK1NpNGptYk9mYlo2?=
 =?utf-8?B?cm5iRUg0THZiWFl6YkFYc3llSFdqRTBEOGY5Z09IQ0Z1ZWZUc2lQQmFKVnMr?=
 =?utf-8?B?d1IvTThFN3Q4WG1NdmF6anFEQkhMOFdUNzVrbkNDUU4wcnY5K0liN1JRNDFL?=
 =?utf-8?B?WDVCMzM0WWJXMytPb1RYbHZ2M0Z4SFpSUzBGK0orMzE2SWxRN3F1KzdGT3VO?=
 =?utf-8?B?bm00QW1FMTJmR2R2YVY2S3VTcnZpMkROZ3ZPaXlhWXk5Y3FHU21rdHBsZjNz?=
 =?utf-8?B?M0k1OXRwRG84eFVJYlFrY200RkJaZGdDUUprakF3RnVWaWpBOGR0bG5xQkk3?=
 =?utf-8?B?Um5GWW56K0U1WVUrSjZzVHBoVG0yRlJaT3dOODhLekp1T1gxQ0JrYWhSSk1E?=
 =?utf-8?B?VmM2alVZbnpFT2JTaklLMU5NUzhXSmpQY2NUYVFNdFRoaHUwQ1FjUFNwaWM2?=
 =?utf-8?B?ckovMTFmN3VYUytKU1NtYWhZSFJvV04zVWxRSlozVThOeEo0ekwvS1FMeis1?=
 =?utf-8?B?aGxVSnlpcCt2ZUliV09UMmYvYytaZ2gwSWJmWE9aSEtmejN3bGFNWjVnam9T?=
 =?utf-8?B?TG1BbGplUHg1aElmNkxndEVtV0tqakswcmltVWRZRVZxUFlaVHQ2aHlIVHJt?=
 =?utf-8?B?ZFJMMEd1MDZPWXhnc21UWFN1R3NDbmxKdlc4cGhTR0YrVFRYSmFQN1JiYVhu?=
 =?utf-8?B?RERGT2p4RVovN0hDYUJoWDNxZm5mZUdpZjQ2citzZzBOU3VSZCtUbWZtTW5l?=
 =?utf-8?B?MGUxYUJwOXU0RlJ4Q0EybDZwS3VLOTR3anJlZFVXRVU1R0FvL2xIZVA1ZXJY?=
 =?utf-8?B?cnYxbHNwUHUyUFFpdUFCNDNvdjRsZ3hPTGlMTTRqMlpHR2FCanVnWTZuOGdP?=
 =?utf-8?B?ZGV6L1ZLbzFHaVhNQTIvakZPU0Q1cTBoZWl3eXQvWlRsM3BnT2xTNXg2aHpk?=
 =?utf-8?B?NTV4d1NVN3J4aGFXMWRwa050dHMzUUZUd3paZy9lb0c4cGZaWkVpc0kyaW1o?=
 =?utf-8?B?U2toQVcrMmtIQnpWMkNoZ3NaOXBEUDFsZmpBZ0I5aE5XUERWMkw2Zkc1VXdE?=
 =?utf-8?B?UGh3U0ZVK3JYbG8xNWl3NCtGd0oxRWJtVkpwdnkvSnMyMlpubGtUVlRFUHdG?=
 =?utf-8?Q?tHXNS/4rSKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzMxck9uUkxYdEZBWjRxSXBaRmszZVdNNFMrM1hMc0ZEa2dtZU92YUdSUmkw?=
 =?utf-8?B?NWdQMzZULzJHcFJpUWNVWm15aDh2c0hweTVvRlkxQ1lpZTNOQmEvSUhUQmxD?=
 =?utf-8?B?WFNUaTJsZkdFVkRNVEhTY0tPZGg2RElJc0srVXgrc0xiekVXY1VUR0hJZ29K?=
 =?utf-8?B?MlNldjEvNFpySENXUHRmWmk1V2VPalptc2tiR2VFMzJRRG1MUlg5S202a2NW?=
 =?utf-8?B?eHhPcHJzb0xJeko3QmhUeVVBUG8rVjErUnhrTGwzUnBndVphTGxVT0RFdm01?=
 =?utf-8?B?YW5BbUhlbU5uWG5rYTh4cXFEV1kzV09NUjhVaWp6VHpKT2UrT1Ixdlp5a3I5?=
 =?utf-8?B?d0lEd0VrY0EvbG80TklvQ3NiMEsyV0RzSHFuanc5OHlRWHk2Qkg5QVdsT2N2?=
 =?utf-8?B?SDcyeW8xN1lBTk1temJlSEdURnJlVGtpK0ttNHIxWnYyKzkyZHVPYjNCU2sz?=
 =?utf-8?B?RGx1Q3lUUGF0UGNVaWpOcTdFRFFTZ3Q1ZHVJNXRKeGVHWWFBMDNtbk1lR3I5?=
 =?utf-8?B?ZmR1Q1ZldUNKSXpWUGRaSkI5UWMxNTdQQ2dmZHRka3ZvWFRtTE5McVF1Q0NZ?=
 =?utf-8?B?dFRxdm11c0hKYVFUMXhuK0RSc1pMc0NsNUtNWDVuQjFaL0lmWkxib1BGVVBX?=
 =?utf-8?B?ekF0U0sxNU1MaCtJbVRacGxzVXBDY2lHc3lBVW5ZL3BnVll3QzZlMXZibHBO?=
 =?utf-8?B?RGZEMENZeWo2OTNvMUsvR0xoOXhjZklwUXEvNnV3Tm90aEhjWnc2NmV5TWRI?=
 =?utf-8?B?MWhZLzhyeGtuWjdkRHBwRXJ0eEI1anlVMjlYTDhWRzFqVG1UQThLQktmWGZG?=
 =?utf-8?B?OTBvbkdYQzBKR3ZoZFpqVy9zNVlOYnJ4Z0JJSmZFcTFDZ1RWdzhLUXlGdGp4?=
 =?utf-8?B?Q09kMk5OWk5qOXdqaC9LaEtLTzFFcmFPdWx3elZvK2s5Tnp3Kys0NytDVlFn?=
 =?utf-8?B?MFVlM0Y5VUQ1QlhuWlF1NzJYR2FXL0Uzb3V3d29WMGJjcXgrd2VGRzdlejNn?=
 =?utf-8?B?ZU9VTEg4RXozTXREUm1NK25tdzFMNUU2eFJnSVFZMm02TDc1YkN2cG40N01r?=
 =?utf-8?B?bnFCTXBQR1ZIcjNJMk9iT1BYWk1aWlRkQ2k1ME9uU3QyMzl6djVOVXlMVDRt?=
 =?utf-8?B?ZjhWdmE3ckQ2Q1NaNU9MWVdESzErb3hhQ0xkZzdSLzZGQnlQdnFaajN6Uzc1?=
 =?utf-8?B?VE05RHVDWGVCN2ZUdzN5WGJ3VnlvWisvQWJZakUvOVRvM2FRVmRCT3NXbTF4?=
 =?utf-8?B?QU40Q3A4Y2U0VHhBTzZXL0JOTm1vbE1CRm55SXBQRmhFcDBTM09sLy9kUHF5?=
 =?utf-8?B?dGlGcjJJcmI2WlFHQ2tNTzgxWlgzSVlDRmpubVpaL2Y5SXlzYUZYNFMzazNG?=
 =?utf-8?B?SXo3T1dJVkFMRHRUVTFTSldvSUdFTUt3SDdGU3MwRXZzd3F5cDErd21CSGRN?=
 =?utf-8?B?WU9lbjA3djBwSHhVQWw1NGdBYzVpUW8yOWkreWd3ZlZxdGdVQ1dhbjNDSEYr?=
 =?utf-8?B?NGlWUFpDSnhlNXNvUTM0VmEwbUs4V2R6TXhlc3dnc05CNy9VeEJPMWw4UExn?=
 =?utf-8?B?Y2xpcHF4eHM0MUdPdDNvOVVic0lyU0tFYjBtajBZb1lIbHhUNFBGelVUSldy?=
 =?utf-8?B?dWdoUHYxdVZMZWZjWkl6ZWxmdFpReWN5a25GMG4rSkhXaHpKeG5RbXVTemFo?=
 =?utf-8?B?cGpERk5sMXBjcEdvOTJpOFlNL2dDZ2N1SFNZbmg5MThMcHRvUlFTcXdhRXlS?=
 =?utf-8?B?VHEvdVpZZXJpZHBKVEdkOFc3ck16b0k0TUVHTEhxMVdIOEU2MC81T2QwYnVx?=
 =?utf-8?B?enNEdjYzeVFyVVZPYmk3ZDQ0Z254eDVDdjZZdzBodzE0NWhWMWpPUGoxbnJm?=
 =?utf-8?B?WEgwZ2tGNDVrUHBacTBFR3pkMHZLNlhPRGlxM2p1Y29RUSs1b0JaK0tpeUVD?=
 =?utf-8?B?S2czdlVnZ1VhazZqK1h4U1NKQUh2Nmh4TnBRL1ZnQ3FjYVA3VXlLcGF1VXZX?=
 =?utf-8?B?WU85cFk0SGpqc2o2TFI4WnR5UlNMMjhBVXFPczlzMkFranhnbnlhWEt4Wmor?=
 =?utf-8?B?RWI4TkFRNnpMR2p1em5zaHRlcVJON1NwZ3V0WXZLRnkxaWdmNkg4elJqNkJw?=
 =?utf-8?B?SXpSTkxpTmRtbHpRZFlLYkl1a2dUbHZObkh4aUYrUlFvRHVUbkwwWVc4UU00?=
 =?utf-8?Q?gIhyzeBIE7pS5mYmiBpSvQU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1c04f-e579-431e-1ca4-08dde07ba2f8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:26:18.0088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNIQ9nDryMpQqh7XHu1VbjTXT+2UTkhjrEqy/z4cN/ZDLRg4OzdZByZeeG2fY0FCF9xlb1d2b/EBW5FcJPnvwfVidFq3mLW9IZ6FOSYs36m0O5jHYptolcNnde1hS1gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6984
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


Hi Marek

On 21-Aug-25 1:49 AM, Marek Vasut wrote:
> 
> On 8/20/25 1:35 PM, Ravulapalli, Naresh Kumar wrote:
>> Hi Marek
>>
>> On 20-Aug-25 4:56 PM, Marek Vasut wrote:
>>>
>>> On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
>>>> Hi Marek
>>>>
>>>> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>>>>>
>>>>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>>>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>>>>> loading. This would enable FPGA configuration bitstream loading
>>>>>> from QSPI RAW partition to program FPGA.
>>>>>>
>>>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>>>> Signed-off-by: Naresh Kumar Ravulapalli
>>>>>> <nareshkumar.ravulapalli@altera.com>
>>>>>
>>>>> Why not load from UBI on SPI NOR ?
>>>>
>>>> It is to avoid the storage overhead for metadata and management
>>>> for devices with flash constraints.
>>>
>>> What about data integrity , iirc UBI gives you built-in checksums.
>>>
>>
>> Agree, UBI supports bad block management and other advantages. But
>> the objective here is to support RAW partition for flash constraint
>> devices.
> How is integrity of the data in flash handled in this case ?

RAW partition support and required data integrity handling is user
specific. In our case, we are storing CRC32 checksum in flash and 
computing the checksum on raw data during run time and cross-checking 
the values.
