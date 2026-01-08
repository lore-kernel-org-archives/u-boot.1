Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAF3D185CC
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 11:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81B083B8A;
	Thu,  8 Jan 2026 12:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="swkAEG6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E445E84109; Thu,  8 Jan 2026 12:12:44 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90C783B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crIcdep9epNij2gdQa4dTMNoAe1s8c/EHDEvZucrf39Bf0rEHfnrN4XUi7xjAnHAC0p8FAP/KeE+V9toVzGoTmesrg1ZFkl+F5Q8YO1DlrWQLt0hHiKl+wzCLKxa5vEn4TzOuJT5fYJkaKx7AZP8uwNbHQovBRUJCP77KXz6PNr1PyBvwWNduTxZF4S2IeCDZHrXX6bVea+kEYkINEq7JqGm82Ci/rGwzlBLCvyi61NT6ZJEl2nfAzGLbINxzJmwQt2d91ldU4u8VPCdUTYdQ//qcQZgntKIpngbICAYnIAmHejUcNgmIcieqrGFPoHowrfMVqqVUsrvQ74fr3JPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quEVJ6Xaq2UATmFPeqfzb04ht7ufallmi8fwQpzVW8c=;
 b=jNOHKWIeJ0FwEDSN2mXdV93N59WUs3m13f5XAEitDWJTmtlOc2mUQoTVJzx/70juKRqsy7Boo68DKiS9iruxjFkN2l8E0fR0klflKQXIzkx9793PmToVR0bvjx4+Fdgc5Us+UcU9gUxz1q7S56YcNCcgCbnCbsFj94uSD2lYl4bp74UO4kr6EFPoJeqkWwNIhD6eMsQ4o3tSE8NdY+phH5n9aKAKic7TnEIWiRG6EqOEreIA5dd3pBmDWLdcVdIMeGa9khFrFCb3VQd6xCSOQfhsJSqorxcZEul0drlgnhYTJCTR9aiPzmMDA64gIuRxGVjo3FaNOdoRixLJfgCvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quEVJ6Xaq2UATmFPeqfzb04ht7ufallmi8fwQpzVW8c=;
 b=swkAEG6yZzNUz1wDdbWm8kOB01O1JN4Jn5YG8kNMvjIsk3nxEFrKcwFYtg4hqFdPt+yVOmtb4H9D3VuCGYagaRNtTvJbHXWoHHasnkPp6ccWfBWsAGwT4Rzxrsn3YD6mF9exgyfgLMBA5AnMwf2GnLOY+snUgwQahAd2gI3/kzxxBJ7jQzLpvswOiks8TvUr0d4NzEgJth6vtVlBlNjPTIm5igpeg3fGaQm9tnt3WtohCRPz0lCme/MUuvdRm07dSzqpY1QJemEg/t5xcifQvowIS8CoW1+qXi7zrU3TmjrrH5lq0FS9xlLZc+9d//lSlMTNJZw1D6+K/UbzI3z/sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by MN2PR03MB5295.namprd03.prod.outlook.com (2603:10b6:208:1e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 11:12:39 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:12:39 +0000
Message-ID: <c0809c43-5efa-4150-ad29-497b3b0c8fcc@altera.com>
Date: Thu, 8 Jan 2026 16:42:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares
 <ivitro@gmail.com>, u-boot@lists.denx.de, vitor.soares@toradex.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
 <CAOMZO5DSf=ViRb-3Z8RWKFiN+P37sk2Wds0Evd9_Gt0nbekc3A@mail.gmail.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <CAOMZO5DSf=ViRb-3Z8RWKFiN+P37sk2Wds0Evd9_Gt0nbekc3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::15) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|MN2PR03MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3a8b21-2068-44b9-f953-08de4ea6d3ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFRFakx2R2hyNXgwNmM4a0k0dTRZMkE5bmVqUE1IdVFFUmxpUDNiTC9mSFlL?=
 =?utf-8?B?amRhdzFsdDE4MEZCMXk4enNacDE1UTg1WE8vdFplOEtWYW5HUlZPOFB1ZGZE?=
 =?utf-8?B?N3I0TGMzM1dEUU1KNERaNldtWG11VEEwRkowZVRyd1pXZXFpSU1QWUN2L2pR?=
 =?utf-8?B?ZGtkVU9JKzhIMjYyUXNCK2ZMNFhsZmNLT0JkblJqVjkreVA0Q1l5ZkY3N1hN?=
 =?utf-8?B?dEcwNzhjREdNTDRMa2pzc3pqRnp0R0MrWkdWNTBqai9YekxnUjVqMnR4dnpO?=
 =?utf-8?B?ajB4TmZGclRPdjZPVzZvK0xFVmhjOTNhRHB2RG1vU1I2M2U2YllTWEhxa2dY?=
 =?utf-8?B?U1RyRmFLa3EzV1UybFpCaWkyVUtmUTc3WHZlblhHa1hRWFZmS1prYytlUGZq?=
 =?utf-8?B?NTMxWEdrd3V1SlZ1bkFJVklvaTVkazFHcERSZnlZR28yZHk3TW5scTlRWVZk?=
 =?utf-8?B?Y1RLZUpIQ2pLN0p2UGhCbEpNZDVuWmdxeEZrQ3RSOWFEdmZoL3FxcGIyNkQx?=
 =?utf-8?B?Yk9Bd2tWWE1rdVVseWl2UFpkMXZha1d4ai94QkVnTGFkRW5ET3djcGZYa0pB?=
 =?utf-8?B?QU1GaGVmeWhFSFA4VG9Gd1F5bFh3cVZYczhTdnJiOHJyNHJRYm9zblZjc3Zs?=
 =?utf-8?B?LzBUTjV6d1lQVWRsaU9vTktYZHNNbWFQM2V1cysvajlKMzJabkxPT3VjSUdx?=
 =?utf-8?B?UjZiTU1QZkQ5ZXdjZWo0SlVaTTE4Vi8rSHplVmpkNDhpemZ5VmFzUVJ2cHFX?=
 =?utf-8?B?d1F1V20xNjdIMUM2K2tBUFlCZ205U0dwRVRXUUlncE5yR0w3SXlEWXVzeUl3?=
 =?utf-8?B?Ykw4WnB5cVp4anlLcTRmR3BUQmpJbjdER1djbHNIWnp4dEZIQ1U2bllqaGpv?=
 =?utf-8?B?dzFybkEzTWhUNjN0RGVPbU4yanBaREVUL2RPdHRMaGZSOVZrUnp5VzU1MGZ4?=
 =?utf-8?B?MUt3VGlpUWkwMHdSS2V4RTA1MDRzdnp0T3hJSDFDOUZTMWI5YnJtRmtaa3Fw?=
 =?utf-8?B?SzFpMDNuRHNpdnJDNXB2ZG16QmF6L3BNcU1Nc3d3ZXpkclQwSlNWU1FjMmFk?=
 =?utf-8?B?aTRaN2RjRnY4Y01oOU9nRCt3bHgyWnFrRFdtaEhGS1RLdTlyanFSTS80andw?=
 =?utf-8?B?T0JxNklvVVpmU0dKdmZtTFlMdkt5emdROTlDZ3I2MllHVmh6OFdaUnlyM2VV?=
 =?utf-8?B?dndQbFp2V2lkOGF2TFhVaTI0a1VCSnNlUTlBV0lqWlp3TW1SdlZ2d0Jxa3Vo?=
 =?utf-8?B?b0dERlgrMk5EVXJuOFRTZDA1UDRrZFRvZWFGU1pCSUhZVDMyem5WanpJR3Vs?=
 =?utf-8?B?bFJsZ0pGNStWN2RCbkF6ZXlHaERySVpNbUN1N2xQSEJqWXBvQ2QycEN4c1Aw?=
 =?utf-8?B?dWQzK3lPUjRrUUs1WFR3dUE2WUJncW40OTRlTytTc0hpVG1TbVVNMmZSd0Jt?=
 =?utf-8?B?cVVLRy9seTZpZUZsd3J1U3VYZ1RwZThBbXF0THppSldwaTRxMmQ4eTg5RCtO?=
 =?utf-8?B?akZHVWxsUDQvaS9yUjI5aUZIRStrRFNsVUhseUlxZm1qU2dYcDRidDk4Tjkv?=
 =?utf-8?B?Q1hkblJzdWRUL0V2QzVyOUwzUGxUbnRrd2hoWlpyVmxxRjZvSXhYVEZWbmNv?=
 =?utf-8?B?SldiZnZ2OXNnRnZkNk9zWEhxbTNGU2wyazYxSzNOZUNBeDRHa3VHS1gybUV5?=
 =?utf-8?B?dHZ6T0lQdkhRWnlxWjhDSHZNSXlGUjBpYW1QRmtHb3VodVZjR2tNdjJGUzFa?=
 =?utf-8?B?MUxSM1c2cFBFUDFOMGFTRUZmVEJJdkpCWG5CTjk2eCtpTW1HNEhoMjhPZjRD?=
 =?utf-8?B?NC9vNnRGVFNHVUloZWNvVldlb2dwSFV1aExKNFBZcXF2OGVJcFlBTlZKTVFk?=
 =?utf-8?B?cEtCbHhSQXZjQTEzR0F6OGxncmRpeFErTlJjNmNDNWdWa2VYMGdkWVlVQVNE?=
 =?utf-8?Q?B0uD/uoOUg97eq/aDFJN/HIt8UkzWDZH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2tybkIrWjhCU2F3QXhRR3FvRnhWMGVlTlphemh2c0NmQVpIckU5YmxjWFRw?=
 =?utf-8?B?WlZRWUwwUXk2YlB0ZFRhM0VoRGpQY0RjZHRMV3lYN093K2h0bTcrMUJRZElG?=
 =?utf-8?B?QlAyWkdXU2hWdnJQenhibFprK2JBTWpPSFF5QWU0dGtocWkyc2wyRzliRUNJ?=
 =?utf-8?B?OVJzWWh1dE9FNk5Kd3NTV1R1RHN4YzlQa2V2OWNSbUgzMDR4d0VDelB4MklE?=
 =?utf-8?B?bExlWHJDSlJIWmNabWJ4VStXeFg5QkxxV1E2SVBsQjNWQUZUVnNSVUdzNHpG?=
 =?utf-8?B?azdid1JMOWh5SEtpTEhsVlhld3JYSksxZDBJbGNhTWhaV2RZV2VyUkg0MHZq?=
 =?utf-8?B?NWltbTBHZG9rdkgwTGxsRnBYVW1WVnpTcjIycWdqZUVUODMyMlAvWG9BKzlW?=
 =?utf-8?B?MnY4SCtYTk5xZVd6bU9hRnYrWHB5U25NVDkwU1paaGdWRzVyU1VuTk9BUVZK?=
 =?utf-8?B?NzB6bmhJUnVCVWljMTdNTElsSDRDZWI3ZTZRSXJUR0NGSzZtcUJ0S0RDZzVP?=
 =?utf-8?B?R25tVDk2eVJET0ZQV0srS0krS25OUXBEY0MyMjh2bUZrT0JTQlJ4WUhxYUZt?=
 =?utf-8?B?RGpXcXZIQ1pTQlF2YzZod1hjNGZ2Y0JKclhpbVZWV25LQUFsQ3E5QmJnUzFw?=
 =?utf-8?B?L3lwZ29oQ1FuczVnQ1NZSStwVzgzSi9rUk1uakNQT3F3UnpHbmpadWdsSUt2?=
 =?utf-8?B?UUY0dnBKVnZBWFY1YTlVL2IrQlRIVkpkUXJJWGkrSHpGQkd5UjJOZTZDckVU?=
 =?utf-8?B?M2JyYmVaK1RUcGFWdTZjNnQwTHRMcng4akNFeXR1M1ZNRnRUVXhTTW1jQkM3?=
 =?utf-8?B?Z2hDSkp1MEduVzhsOE5UeWJCYUIyMVY5Y3FpQ3g5VVFML1gxeTNNU1JzTnB4?=
 =?utf-8?B?NzZIclhQZDE3MVFxMlByd2R3alNubWUzeE1YekRoUHhOQTJCN3N6a2lYTWtC?=
 =?utf-8?B?azVKOTU4dnphdmJlZkwrNVloN3lBc1g3NDJ4eTB0dFlPOWE3ZlUyZG8yTkNB?=
 =?utf-8?B?ZGF2NkNQZjY2QVpJOVF6L1NURjRiTEdGWlZaWFgrRkwza3ozZVIxeWNPVDlH?=
 =?utf-8?B?Q1JzV0ZYYUZhZ0N2UDBaZkhaUTJ2cUFML2E1cHJpTmNvYUR1VklWUVZuSGxK?=
 =?utf-8?B?ZzUreisrWnNDUnRtSmNtZEY3THdiemZTMTRxM0N2ZkhQR25UenY2MHk3eHlp?=
 =?utf-8?B?UHlzTk1LUWNjaGt2eWExTnAvKzU5L05KTDFKd0xkNmdkN2F6UUplK1I3cDk0?=
 =?utf-8?B?dTZMRE5DUjFQMDV6WTh4SVE1SlFhVXJUeU9xZE1JdDlnZFo0bzJzamI4NmFn?=
 =?utf-8?B?KzJCQ0JoUUZoazN2Z1NSaGVnSmVYWUVEL1R4ZDk2YXpEcEp1dGhsS2t0VCtW?=
 =?utf-8?B?MGhLN2RDalcwTTFwajZFR2YrS2NWVVdnZnF6WUp1RUx2RFRGNGhReGZ1Mi9p?=
 =?utf-8?B?bDZVbkQ1SFJ3SDg0aWJ0VjVZd2lLWU1SenlrZ0ZhT3RuMTJvam9IUFZMY2ts?=
 =?utf-8?B?QjF5Z2VqMUNtdDVNK2hlN212UmFEelJVbXBoK2RuNjZ1WFBmK0lDaTJGQ3l4?=
 =?utf-8?B?M2dOUnlpOUxkR2o0MVBjUDZ4cHEzZ3RscDhqY05XeE1aY1NLaEorM2xmdnUv?=
 =?utf-8?B?SEJpc3ptRUFYckkwUnlQZGs2TkUxclZwdHhRNTBiWm5lZzVLZzRsd0RJZVZO?=
 =?utf-8?B?UE1sMlVBRlgxU2NEd1Z5RW9DQ2Yyemd1M0ZXSnNNU2h6bkptUm5IOExVQU1X?=
 =?utf-8?B?WXdmY0ZEZkNLdWNIeUlFai9QZ2h1ZFFGUW1hQWlzQ1hVenZDeGZYcWdlUWVM?=
 =?utf-8?B?dFh3Y0g5dnY5eXlQOVQxRlJXWEdKSlVGdXo4MFVpL3BweVdYVW1pZnQ4emZw?=
 =?utf-8?B?cC9wdmkrQW9OYmZZN3VxY2lIZG1UY1RkNmd2YVIvOU9KN0syWUdJclZlVThD?=
 =?utf-8?B?ZnEwaGJkL3IwQWFBOC9PeG52QUNtQzJJb0dUREdIYWVUVldVL3lZVVRHS3VM?=
 =?utf-8?B?akN2VThVeG1FQ0s3bnRxNmZkaFQxV2Z2YmVHOTBGaWdwdTMyRlo2Z2Q0RjJx?=
 =?utf-8?B?Sm8vLy9DeVdyOTUxS3Nid3BOKzVzNmNiM0tzc09XaUExbThwNkJYcWJ1dGta?=
 =?utf-8?B?Qk5uWU5HZTV3VForNm9oR0g0MlZGNUtUZEVXOWVVMEtDbFlMZENIVVUraFBl?=
 =?utf-8?B?WmN4RzdLYWdJYkVvdllwS2hjWlBsTEh3OFFvRmEyMEIvTWp5ZWE1cXk3K2k3?=
 =?utf-8?B?bFBaYjJteGpHU004KzRsV0JWOXJaWGpaaG52ZG1RQ1RIamJZSmlEK1VITWlq?=
 =?utf-8?B?YlFoVTZrL2NYVWppaWpvUWQ0SGVnVU81OHJJU2E3UENzSVF2blZFS1pocVdT?=
 =?utf-8?Q?Wy2IXFvtboejCqZw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a8b21-2068-44b9-f953-08de4ea6d3ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:12:39.4324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjjWLT5TnnzDD8DmrauGF6My8OvE7XV4/gWvPNXDYhEZjo1n02qdcuMdSKiZ9/XpY5J17ixyuZMSPckyO1QEIQjzWMoGN5KUyDrewaWqz04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5295
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

Hi Fabio,


On 1/8/2026 4:38 PM, Fabio Estevam wrote:
> Could you please send a revert?

Here is the revert patch for commit aebb523a2381 ("mmc: mmc-uclass: Use 
max-frequency from device tree with default handling"):

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index bf0bea93853..2f4dc5bd887 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -243,13 +243,8 @@ int mmc_of_parse(struct udevice *dev, struct 
mmc_config *cfg)
  		return -EINVAL;
  	}

-	/*
-	 * Maximum frequency is obtained from the optional "max-frequency" 
property.
-	 * If not specified in device tree, defaults to 0 and sdhci_setup_cfg()
-	 * will set the MMC configuration maximum frequency to the host 
controller's
-	 * maximum base clock frequency from capabilities register.
-	 */
-	cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
+	/* f_max is obtained from the optional "max-frequency" property */
+	dev_read_u32(dev, "max-frequency", &cfg->f_max);

  	if (dev_read_bool(dev, "cap-sd-highspeed"))
  		cfg->host_caps |= MMC_CAP(SD_HS);
