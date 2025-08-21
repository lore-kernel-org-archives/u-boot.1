Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7866ECA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 10:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D4D81D6A;
	Thu, 21 Aug 2025 12:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hEbpSYeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A04580EE5; Thu, 21 Aug 2025 12:26:42 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2305980422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 12:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv3r+zkKVWR3wMOb40YR1cYCgUHgBZK1uFAJCvLH7tbFC6zZAxFFME5oe8nCkI6aZSK6Z2IJ7fj1UTDu1AG/Sm5e+L+2vPHpper9kFR6nTbILxqA023i4qkz6jD5Fya0OhL4EbR+kzWsLtyXGQuRyMpKmNk2uyxZLZGPSTmNXNW5tj0eZw08H6WpEpgsBFM89p7/aT1/IK5gOedhG1NMXI+vNm4gPh5ock7Cgf/TuTKGKGiAyUBRKTZ6ISli+yNeFQ6vS4BL5vyvjbye42sQ9Utoqp5tSRzc6M13Atqd6qlYVlXDtJzWDLeE/aP1vlErk2sC8kWJ4hadBJJj+g8GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohsLqDDjUcoymESLWefHxN14rEhVYjXV8eEu2Jybw9g=;
 b=ycK3dQ/92tzvvZhSoIJC1YUiIYU7XWiPTOcNozeerxGfnbFA3zD6uIQEOmldKcKXk7qs+sZWnwSqdBkuL2ckIk/i3If8d3aehVjh4iebw3qhU/yyQSpWkFK4CZ9ifRCZcTEQjjyQWGA1MNDmrpe5OxakjcurEZ1zbl7hU4L5RICIDEeaJ26+7c+1iW6f4YQOrFhBzkGWpZktf4GnRDd+kqVqKeuh/1NI50ecg9kdYrC7Bk3YoUugbI7y8YMCiHlXjB/kxmAONw3XveccJg+Xhz17oVJs0+KY81nnv/M8ZMnqV0PMJqZ0WML24g1VT9hNKmov77HDXy/CVasQNbcGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohsLqDDjUcoymESLWefHxN14rEhVYjXV8eEu2Jybw9g=;
 b=hEbpSYeGQY8wZCwxIBtYubiU1K6NKoix6tGFPf32Mnpyzw8I3t6awLQ7987pvr3PBhu2IMQ46E0pyFvetdHzC2PODqbtOpxJokiyc3rGM0bR9CBo3/M5Ks0HlYLge7wszJDKqvNBpaENCjhjItIr/R4U5fvqrYkJTbF/f8f/Q6XKJ1dDWhfjdfe220ATn0W0K0lTPwVJSzmnV7V1EBR2sUVwT4rk6YIN1RNou/x9XDvzyDK40lMRv9cOPRc9iF8N8txgnlvjwjIDTYYyZckkZi3j2YworFfBWo2cIV9PP4vr19jfbORSwaEVz6tls8DHYete+nGy8wMB4LIBE6hmXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH7PR03MB7931.namprd03.prod.outlook.com (2603:10b6:610:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 10:26:36 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 10:26:36 +0000
Message-ID: <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
Date: Thu, 21 Aug 2025 15:56:29 +0530
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
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::17) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH7PR03MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 826affd5-a969-4576-0ebd-08dde09d34c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXRJMFl1OXJOajNya2xISlVhc3NKZ3VxL0s5Y0lmWXdqNUlpaDhRYmRURUNC?=
 =?utf-8?B?bUJFbGNZVkQ0eWdHS044c0tJSjdYd3BLMGZaQkZkRGRNd2UzckFaSW5BRnlZ?=
 =?utf-8?B?OStBekpxRWxZVlJZd1c0M0F3YWR3YS9veGV6QzdPeEY0OW9IUFQwMHcxVXRW?=
 =?utf-8?B?R1BCejRmemRBV0xSN3d3cEE1L2t3K2RvNTJQMHRScSttb3gvd2QvcDVENkg1?=
 =?utf-8?B?bWtzWDJDck9TcjV0NFZZalBpWVJ2RG9lTGVReHJVb2VjcTJjdmk0MGQrWk9Y?=
 =?utf-8?B?YkcwT3dpcHJ0b3FHdXhmOHYveld3cDFlSFZnRFQ5VGZTZGVBSy9RM2FubXZi?=
 =?utf-8?B?SlM1SFlzWUJKcFdaZEJyYUhUTDNvenlIUlZ4TG1pbXV3UUlJWlRjSUdkRVh3?=
 =?utf-8?B?VFZ3T2tyeTE3WHpoK0VOdXorbnB5NnRrOHBzWWsrcFNKczFmUWlmRUVYNXgv?=
 =?utf-8?B?ckJkVHplRGpGT1U5YXR1cjI2bWtKK0J2WGpZdHZURW5RdlJDQ1NLNWJvNVpR?=
 =?utf-8?B?UjI2UmpOS2JheHlMb3pGcDVQb1lMMHpESWtlUnYxdUJTOCtjT0tRUXN3NTJr?=
 =?utf-8?B?WXB2aVVSVEQwK0Q0cWh2ZXRxR05rQnBhbkcxcHo4cFZUMnhXWTJWUnQ2enZB?=
 =?utf-8?B?Wk9PTVBOVFlHU3hnUVpXaDREcWFQaktxM1Vma1ExRnk5N1hiT1pWaXNwSmRh?=
 =?utf-8?B?Y2I4N3Z2R2I5dE8wMFpiZTF6aWZCZmpZTG96RXJ1THVnNm8wTWttTzFMSHJi?=
 =?utf-8?B?eGpnMHR0eGpYSWRmZGpTbldtQmJPWENhMGI2K2hhTzNENDk4NWdOOVVjM1Iv?=
 =?utf-8?B?S2kwemRwMGI2cFN4ZHBscmhaTldJT2lXc01nREVtR3hoaWtrZFlHTC9JSnBk?=
 =?utf-8?B?a2tvdVJYQURVRkdVb25HOXhGZVZtUTY2RER4VWRkNXcvOFpHeU1oVVlLUWI5?=
 =?utf-8?B?VXhzdGpTcXVBaWVCUmV6dHo0YytuMlNLWEFiR2Rva2JqNlBwbzNZODdFMzRN?=
 =?utf-8?B?YzRyZkczSEZFSmQzVmVHZ1lFbVJIOVkzMEpuOWROK2ZEcm5acEcwQzNibXZI?=
 =?utf-8?B?WitmajBONCs5eHRDWUxhakFnMElDR2UzQVk2WjFiTXJlamxpajVpYmdGb0xO?=
 =?utf-8?B?a2F4NmlWSUcydTBXZ3pGbGJlSUpUdXA0c3ArZDF2dW80M3czdlZBa2VURWRF?=
 =?utf-8?B?Tm1GRm5YK2g1ZTF6YjV0Qnp1K29scDFvUnlyTCtoOVJRUWQ0UWxITkFjZW9E?=
 =?utf-8?B?YUoxMXRyc29ybmxlbTI0ZVNmN29tbUorcjBRdHNCV3hsVFh1dTF2UEowaDJC?=
 =?utf-8?B?RG94VEt6REIxczhSNXh6THRVNVZpYzRxWFFDUGFMdFBzTTFvV2kzbGVSaFFB?=
 =?utf-8?B?YU1mRzhtclFHREMvQ2Y1UktSTlczUFlMcTdMeDB5dXdqY29XUDRsTXpFL0Yz?=
 =?utf-8?B?MUFoa01McXY5aHNRQU9jZk9HcURQSVYydEdmb2tERUJyWi9YUmRqRHhBSGJS?=
 =?utf-8?B?Zld0TStkR2wzRVNSeEtveXFkSmRwMTQ0Y2djOHdIN1V4NFlNdk9lOEJ0bmZK?=
 =?utf-8?B?aE9BR2x2cmNDMllYTGlicjVDS25MVEo2aEF0MjZhRU1VbGw1RmJwQlJJbzlR?=
 =?utf-8?B?N215MlEydUMzN0JZdTQvbFZEMDhuOS8relYyVkxrQ2RBdlJpMWxQQXN5M1Zo?=
 =?utf-8?B?N0NIOWJqdnk3N3NVeVFGUGxCQkxaaHhNdnV2NjNRNmEySkJXYnkxbWhFaWoz?=
 =?utf-8?B?Y1R1R01OMEhxbWNVc0RWNlozMmRjcFM2MFlKT1lQZk9JTnF4cXRRbEYrR05H?=
 =?utf-8?B?ZFV4MENyMTBSdEx0WWRyV2J4b1dieCtzcnZYL3J2OTN6eVg1Q1U3VUl4TEYz?=
 =?utf-8?B?VG9kbVl4d3pBSC9rcExIZXIzcnFGbW1XVGE2QU9mVGJib3hsTFBzSlo2N2Z6?=
 =?utf-8?Q?eq/Olc3bqec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRZNHpwL3V4MWZtTG1ocXM1VmZtbENJSHRIN1VKd1NuQm5pQzQ4NUtNTE1w?=
 =?utf-8?B?K2Y5cDdGdWFMZTJONkdNMFNCOVBVWEJoWmVGa3VMS1ZCMzR0YU1ucnVqL0VQ?=
 =?utf-8?B?S1RVN2pWQ29FWU8vZUNLd0xuWlI5SHVEcVlUZ1ovRVZKRDF2V2JVSUphQ0RH?=
 =?utf-8?B?T3JTamJGcE5raThWK2xCdnJJcE1RVE1pTHpUdEw5bGFtQlhWVmxYYWV6T3M5?=
 =?utf-8?B?TEdVY0plQldBNWxTM0w0OWNvQ2MxN1lEb0wxNG8yVmZWLzJDZ2l3R01mQk1W?=
 =?utf-8?B?OTl6YnUvZkRBcktObHVTWlp4aHh6ZUhmTmtWOC9uWGU5V2pyZTcvVElvRUFs?=
 =?utf-8?B?L3l2cE1VUjY2QTZVN0I3a3dZRmFobUU1R0x5dWJrQnBocVlvMmp2RzYxY3Vl?=
 =?utf-8?B?dHNzVUw4M0puaWZxQ3JhKzB5WWNxNWswNkk5UTVPYnZNRTVhdy9BZkQwaWlS?=
 =?utf-8?B?WVV6dkk1bzFWNUwwZXhaSUpkcVJSQjZJRW5mWHU4TkJ3RzREUlEzaWk3TnFY?=
 =?utf-8?B?bHdLNmx3cXdHMW1USHBRQTcyQWFyYndvRVlHdTc5ZjFQR1lDWWZxTEgwNDdE?=
 =?utf-8?B?SjBuaml1OWsveFdzeGVPVFI2OUkvQjBkcWFkSnlJYU5pd050L1FGQ1dFZ0I4?=
 =?utf-8?B?TUZ4N0EvTjBhTmhYSnlseTZtY2QyUG9SU2c3MitWaUZyeWQyemJzWXdFNnp2?=
 =?utf-8?B?MjE3MUFCTjlMb2VRUnREYlZ3VHd1T0hPdU94Sy9VeVVmQXNZelZ0N3RBeHpE?=
 =?utf-8?B?TTgzQUZMVzZiVm1QaVNxT25nWVJqbFpOSTY3a3FjeFpPSTVFVmdxaXJneXFF?=
 =?utf-8?B?OHN0UFZ0cGtUVW96MUt2czNQcWZ3RkFOMGtzbzN6L1R5UUhuQmpMTC9tYnFK?=
 =?utf-8?B?WWp6dzRpY0NZL0FzMW1uQnBWVFlHYjNxU0lXVUM0ZFVCdmQ4QXh5SzR2b1Bt?=
 =?utf-8?B?UWtlSUNCSitrVUtid2U4ZXc5RzhZOWpYTzgzeHpTOWZNMjBIQkRhT3pPTjlh?=
 =?utf-8?B?V1RWRnkrUUFad0VzbThoS3NDbEdCSEkvbXkrVncxL3F6eGYyK2pqZjd3WExS?=
 =?utf-8?B?Tnc2Mld0cmF2T0VldUt2ZURQWmJab0xDTU5ubitjczhqOC9qbWxjc294MW1B?=
 =?utf-8?B?NG5hNHlLNzhYUDJPMnRUL0hBNHo5N1AvaERWanNueisvNkZQa2VQMlhUYS95?=
 =?utf-8?B?aHdiWmovWGRCU0FKSVhlNWpvREVTM25mTDZyTUJFRkpGWjgreDVSaWFwRHU4?=
 =?utf-8?B?cnczS2R6TmFodlQ4OGV0SVFZU3l0SHAwLzUzYlI0NzBqVHBEa3BQUG1LbE42?=
 =?utf-8?B?bDhJSHV2MW9XS2VqVG5OZkFzb3VNYjJ5MlFDb2tramhuR2JZS1EvZ2l3aGxC?=
 =?utf-8?B?UTBHWGtsckg4d1NTWGpPaFRtV3lEWmNUTGQrbTgvVjVUV0FHNHlzVUxETGFx?=
 =?utf-8?B?Ykc2eXoyanVvZTRRbXF2SDArQXF4akdnYnh6Q3FOQ3pOSnJxaTVyN2hSR1RX?=
 =?utf-8?B?Q3JPMGY5OC8xQ3AzdytYSnQ2T0N1WWxHb0gvc2psZ2JLcFkrZng0TWVoNUtI?=
 =?utf-8?B?MDF4OXVOb05VSGxWbFlmMVl4Q0xjeXM2bXBaZGF5ekJpN3FRZFVpd0RsK1hx?=
 =?utf-8?B?V0x5WFJWcHRJRkI0cm1kdkU3d0ZkLys4cUVaY09jQmRVcFU4SG93azFhN2tU?=
 =?utf-8?B?RkN0N3JHTFNWNEVBMzdkdE5qdjgrYWk4WmFpR0hnQmJKc3IrcnlJdE1nN1Rw?=
 =?utf-8?B?MzRLdE5LQUVPZW1MYTQvZXMvNThnWk05Yk9BOHlUVnRqNFZuQ1VvQndaY2Qy?=
 =?utf-8?B?ZHVJSnA3MytZM09xdEY5Nm5MTlZROWFTVTBXcWZ0WnlEa0krQ3JVSTBOTExZ?=
 =?utf-8?B?UkZBWEt1OHhYa0M5N1hBQkEyNndVS2JLTVB1YXBwMnBiRXpCM3NWZ1hubTlm?=
 =?utf-8?B?YzkvcU9FSFBPNDNLUWhMb3plWHFGeEFZazdFM0hLbmkwZGFPL3RlUWl2OGEy?=
 =?utf-8?B?a3NPa09tRTFyOVNHZTVZcm5SZEtFWmdpQ20ycnNzTitoM0RHdDhITkJSWDV6?=
 =?utf-8?B?R3VPSVF6TGdZK2xyWktITWtmNGVPN0VKYW02V0xoT1ROcnZEVjBHWkNVa3ZQ?=
 =?utf-8?B?WDFLUzRIT0NDN3VjaVROQmhUWlVWSG1WbmtPQkdVUFRZWlpHNGZrRGRzcGtk?=
 =?utf-8?Q?15Rx2GeM41UhQ5lKcDVqaxM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826affd5-a969-4576-0ebd-08dde09d34c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:26:35.9965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ3UQC5Ej25Y4KOAHG8Qc1a1nND1EnjKKgJIUIweCz1U2xPAfGKhwrTZHRIoHBtXDYh0wQd95ATHA6Jrq/Md82byAnlREsnAhl725VyjHSyZBD098iIGZy+oZ7QrBm8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7931
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

On 21-Aug-25 2:31 PM, Marek Vasut wrote:
> 
> On 8/21/25 8:26 AM, Ravulapalli, Naresh Kumar wrote:
>>
>> Hi Marek
>>
>> On 21-Aug-25 1:49 AM, Marek Vasut wrote:
>>>
>>> On 8/20/25 1:35 PM, Ravulapalli, Naresh Kumar wrote:
>>>> Hi Marek
>>>>
>>>> On 20-Aug-25 4:56 PM, Marek Vasut wrote:
>>>>>
>>>>> On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
>>>>>> Hi Marek
>>>>>>
>>>>>> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>>>>>>>
>>>>>>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>>>>>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>>>>>>> loading. This would enable FPGA configuration bitstream loading
>>>>>>>> from QSPI RAW partition to program FPGA.
>>>>>>>>
>>>>>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>>>>>> Signed-off-by: Naresh Kumar Ravulapalli
>>>>>>>> <nareshkumar.ravulapalli@altera.com>
>>>>>>>
>>>>>>> Why not load from UBI on SPI NOR ?
>>>>>>
>>>>>> It is to avoid the storage overhead for metadata and management
>>>>>> for devices with flash constraints.
>>>>>
>>>>> What about data integrity , iirc UBI gives you built-in checksums.
>>>>>
>>>>
>>>> Agree, UBI supports bad block management and other advantages. But
>>>> the objective here is to support RAW partition for flash constraint
>>>> devices.
>>> How is integrity of the data in flash handled in this case ?
>>
>> RAW partition support and required data integrity handling is user
>> specific. In our case, we are storing CRC32 checksum in flash and
>> computing the checksum on raw data during run time and cross-checking
>> the values.
> 
> How big is the file ? crc32 is weak . Why not use e.g. fitImage for this ?
> 
> If this raw loading should be available to users, it should come with a
> BIG WARNING about data integrity.

User can use CRC32 and if they require SHA256/512, they can use that as 
well or any other algorithm as desired.

RAW partition support is helpful for flash constraint devices especially 
in a use case where we need to store data as RAW during run-time and if 
data integrity is required, user has the flexibility to choose 
respective algorithms like CRC/SHA etc. The whole objective of this 
patch is to provide that flexibility to the user.

I don't think we need the BIG WARNING, as RAW data by definition will 
not have any built-in integrity features and users should exercise 
caution if data integrity is required. It is mentioned in the enum 
definition that choosing "DATA_RAW" flag will store data as RAW.

Kind Regards
Naresh


