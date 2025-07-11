Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222DBC83F20
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 06:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD788344C;
	Fri, 11 Jul 2025 08:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXfu78lB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE0A8349B; Fri, 11 Jul 2025 08:50:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2683083444
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6wJfHzpTjplrxTUwYSn/ENUOpjq0b1LVYj8x6Ik+mE1gzR2GeWY4DojGfu6upZVEeTzHaznSvpTenXGd756gEeTRy+5eQg4tlEXxY+azbbYKb0aUQb7xHAaBhnaNgiqEJFdJ1FRrHl2leJGaW6S1upHD1F7SPMY83wkr0kKCsmFIlm5vewqfYnkcKJWJDQgwjnC4LDLlpV316UKhmYZi8B57Lg+bF6Sf3l2bkkHoNUEXK3BzMr9EXgPC2TcMuShXuOu46XeKUGSA6o0xpaX71NxtYB21pL7HrukitT9OKPw0ZxqYWu2+Yv4RhWNK8AdXDdyMURsqjJIbbHBPM132A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYeYMnwGNsyyX3PGy1zZEBVGafd5RCVbEON8Hwqq0bc=;
 b=mnZ099u6ZtgKZLqKZbj+ezf0IgxWrLNwiMsSgh3Rz6+shBhILpjNjU5yXElu5Kw3zZ7UGMWz94LrpgTQTheQU+Lgu4h8g97jvGrKkcY6nhtYCw+wdHi84iRo2e3dMblmxa3XI6Upl5i5EcVfwBnSqJDiUkv8UViwQxnGRpx/+f2MMg5V4DJmv0NHglP64UhaOgJHCM2yTyAfxZi3iWipGIVpywataD61mKvRzDcKBynYMI6N2hnzEpPtPeV6D4KjQvWM8dMiqS33oHY8z4pFiVnHslWzUHERb2xeTSgRk8OVm9i2sAnR4l0eITziAv9RSB/LBNzw3LCTcK19wemSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYeYMnwGNsyyX3PGy1zZEBVGafd5RCVbEON8Hwqq0bc=;
 b=mXfu78lBCs9mjTp2pWhwh2bETEUGSBa4HtpUmgf3nKMe9KtolhrANC8M5fuaesXq7+Hp5dYsjLbILBWH7psCSnCoWj+32oKJVCOxegnp9f2AjN38dhm/JEWk7ic0uyf7xmP8S6htaU2ZEpiLsO+07Vdn+ccG+SwKC3wRL2ogzus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 06:50:51 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 06:50:51 +0000
Message-ID: <0cf32946-12f7-4ce5-b4a9-3831573ceb5c@amd.com>
Date: Fri, 11 Jul 2025 08:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250710150154.GC6424@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc36d7b-5836-41c6-543a-08ddc0474621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0NRdkNBTWc1ekRSN0xja3VRWGp2OGxraEh1T2VEQkRMU3o1MTJCdkdJdmZN?=
 =?utf-8?B?RjRwTFo4WWl5ZU1EUGN4eWMvRTNuWDdWQUw5RHpBM0VaMDZNT1ROM2RaSTNz?=
 =?utf-8?B?Y2hKd1J6R0ovWmNXdEJNWURPT2Vzby9jTG5UcXoxWENXVUk0UUY3MlNLby9T?=
 =?utf-8?B?ZXQ0TDFBM255eDU5b284VVFpTGxQRVhyQUduYWY5eGMwbjJYWjUyQlBnZXA3?=
 =?utf-8?B?ZER3ZkRXQXhIbGJ3NVRwbUpIdDF2OFZLRU13dlFvMmQxalVJd0VKaG9XajJS?=
 =?utf-8?B?RC9BZmNOTnJKTndDV2dzKzU0RDgvdUEwNnMvRCtTdkcyK3NENWNPL3N3SjNQ?=
 =?utf-8?B?bkcvc29FZE9nMGx3M1BZK3NUQjJ3eUR0UVZ2VDUxMXVjb2ZjM2pDb2NiUUxS?=
 =?utf-8?B?cFRWUEluYmRObWJHcnZkeXd2Vy9TYXJ4TFR4QXJxNmNzV3dGTjBOZzdBWW91?=
 =?utf-8?B?a0tHbHVmYlJYTytHWkQwZXRocHU1b1MxcWlqTmpiVnM0YkIrWlQzRWVGVXEv?=
 =?utf-8?B?VFN3M0NBSE1WcFAvR01JekV2dTVZSFNwTmRvalV0dVROUTRWNU9kNUFFazQz?=
 =?utf-8?B?K1orNUxRWDFnd1lSbjBWTDE2cTluMS80QUw4ZVRmTXJZQkhEeUJ2SXdGa3ZH?=
 =?utf-8?B?cFdEV3pzYUt3VnIrYkFHSkZxVVJhUncrSXhOVFNwdDUxMHpaTUJPN0pFb00z?=
 =?utf-8?B?RkdWSU9nRVoyd0h4Vlo2U2hsMWtYMUZpWk9LME55ZjlOY2tJRWtzeWVCbmtE?=
 =?utf-8?B?SFlhTi9kSDFkT1BzRitUaTlWOTY5eUw4UEZ5TVZ6bHBYT0FLNWE4RjFJS2ll?=
 =?utf-8?B?QW50eXlBWVdrMWNWUkJ0OVIzU1Fpall1T2RWOEVCeE44MEdFeWRMQXI4ZWln?=
 =?utf-8?B?ZjgvVzFuZ3VZYlZJMzBsOFJQS1dJY3FIYVErdENsclU0QnRvY2JEMmlDdWZu?=
 =?utf-8?B?dEloVjY3ZVhLNmlRMmd0Vk0wVnVWS0UzYUIvNnZvVlh5M1VHQ3lMdmxiamUy?=
 =?utf-8?B?cmhtMldzRklBcGZSVlpSWDhKL1p3SkRyODM5RXdMZ28yS2ZwRFhQdDBlc0s3?=
 =?utf-8?B?dnBwU3FvT05EeWpLUXNwQnFJMWpkbkNyU3lYVGx3SisvckVpYXFNZGpxSDQ0?=
 =?utf-8?B?TUpmZEFtT1gvd1BQS2ZWeVl5ZjdNd0RyTmlJUkhGZmRWMkx2eFBhYWg5UUI3?=
 =?utf-8?B?c1Vmbzl0SXZsQmlzNXRCTHhVaHprb1cvclZYOVR1UHZlbkpIV3cvZlMvTHo3?=
 =?utf-8?B?RXdvc1ZlVm9SbmRoWEtPbE05RDZCbWd3NS84a2xvTWk0NXg4c1JuM2IvWTFp?=
 =?utf-8?B?SnU5S1RFSGxhZG1XVnpnbEs0L01nT0R5MVljME5RVHFXU21VODdFelFHbkJM?=
 =?utf-8?B?TW16ZjIwTG03TnlLaXJ1bmFVTGZITHBnVTMzMkxnTGlJTXVnVVNDY2ltZnNC?=
 =?utf-8?B?c05wN2tnUWNrMzhwZ1pMNmtqajFuMzhSNzlvd090TjF6VHZiUHcwcjIxbWNU?=
 =?utf-8?B?NW8yTyt1RnZHTWw4MG1EWkVybExzdnpLSUFXaTlIa3dSM2hLUVQxRWg4cW1R?=
 =?utf-8?B?cTRBWXlRZDJaM3JsU080QkgwenZXK3o3R0ltdU8rZkhtcUV2R3I1TjlPRzQr?=
 =?utf-8?B?dTI5ZnhMbFd0L2FJenJjYzVUVFo4YjB0YU55NTBCU09rRnNSRTZ6VUhHQTZF?=
 =?utf-8?B?T1FKeWs0enJOdEoyeXY1aU53SUZiclJYbkRRMTRWcmtMUEsybWxsK3kxcEM0?=
 =?utf-8?B?RDRaL2liV3ZoUUVrSEhMekRyb01sanl5azlSZmhLSVZTeWF4Q25YV0JCOVJN?=
 =?utf-8?B?c0s2MFg5SmF2TUxxcWNMalpzZVdtYWJCZEVDVmdXS29PNzFDdmZwVjV3WW4v?=
 =?utf-8?B?c2pOQTFKZ2RZb0RBRXFXd0pVdmEwVFZoeWNxMlZSZ2tCbHhqc0pGRGVkaVQv?=
 =?utf-8?Q?SdsqOgSGWXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThhK1V1OEtRQk9JT0Z2T1RmcjczdzdnMm0rbXRDYm5aNytSZGpFSUxIVi8r?=
 =?utf-8?B?eDZzclFFeUZqcnNPSUUrVFNQT2V6TzhOSzBrc3pwVEFLMkFLelZ0R1N4ejNO?=
 =?utf-8?B?MStwQ25oQkRsMGNlOFpjNzNudS9Bd3RZMDlwVGRwc25VNmJ0N3RsOXVGbjlV?=
 =?utf-8?B?Y0xRbUZFeE44VEVyTUc5NjUrSTRjL2VhcnJWRGJBQ3hYSVRGY1k2cFdnWVNh?=
 =?utf-8?B?RnJORkUxNzVZa0lMc2tRWGUvWTg2dHBkYmNtZmYvMVYrVm5yN3hjS1JBNjlu?=
 =?utf-8?B?cmhucW9pVkthN0p3SVlIQ0lYKzJRanJNUndzVDRVQ0wzR0dGUWVqL2VCREJx?=
 =?utf-8?B?WkdTdENDdHN1dnhsdGNCRHRma2RiSnNCYlNiUm5iZlFpV1ZpclkrZGpTSFhy?=
 =?utf-8?B?UmtFT2JiQ0J3QVBkL3dBZVZ3bFU3TE1ybnU5NytRUXdqSUxMOU4rN0d5SThZ?=
 =?utf-8?B?bnovU1BaVWIxazhGTjBhS05rVmpTNWtYNlJCb1BrRHlPRTVCS2lha2pOekd6?=
 =?utf-8?B?SlJzMDUxSzNMM05lTENWekZodGNpN3BmUnk0RDJIREw4SGhmZTNkR0VrVzRX?=
 =?utf-8?B?bS9VandtNldJZmJEcXhnTmE4SWVTVGZqY2c0Z0tNZThxa0locHY4Y3NER0pV?=
 =?utf-8?B?dlkwTWR0OVNoSVRUZ0NrTUJwWHdPbVF2VDR3cGwxRWNYbk0rZVd3Z1EwdTE3?=
 =?utf-8?B?eGNMSXN1b29aR2R1SmVmMGFtWGNwRG1FSy9BZGg5WkErT05lK1p6NVo5Qkcy?=
 =?utf-8?B?Y2JtYXo0ZjlQVnNQODQ1TW50TVdEcnQwMFRwK1hLNzlsSzBDdmMvK0VUeGVz?=
 =?utf-8?B?RXJKRE1JaG4xelVlbjBGQjJHS1ZqRGN3Z0VOMDNDZ1FsclJTa0srNjA4WWpp?=
 =?utf-8?B?S3JBdWcvTjVQRjZORXN4NytYcnJaT0VpT0grOXRib290TFhhY2QxWUFwRDdh?=
 =?utf-8?B?cllNQzUxVklidHJkbDdGV243ZXduK0NGckdKTm1mVVN1UmlBd3oxLytWZWZC?=
 =?utf-8?B?VTB0QklqY3c4UTVWcW9iMC8rVDQ3Z0NaZmpLNFVGMjAxZy9IZVYrMzF6ZXRw?=
 =?utf-8?B?RklaNU5wL09WbGN3NmVWZ1dyY1JZRjErbHRkZUpmUFRYRFJmYU9pd1FrQ2R2?=
 =?utf-8?B?REIrWG9qYnpsK2N1eTJHcjhXZlBDZllKc1c4dWxpeHdXSEhka3ZRdEl4TFVn?=
 =?utf-8?B?QVlhOVVmd2drMnpVOFBpejdaVHFuVzJIWTdyRXc3ZUt4R0s0K0FGK3U1VVVY?=
 =?utf-8?B?TXUzZ2MycjBSejNOWStyYmRlLzB4K1gxWUcvZTh0WE9DOVpVOXk3VmtoRnFz?=
 =?utf-8?B?SkN6c3R5VFA4cjE4cFB6dUJEa2pyT3QvZU85cDB5bWFaNng0aTNaczhVdkF6?=
 =?utf-8?B?RUJITTRvZ0NCOExDYmhOc3JMTHZsVUlvUzZiQlBqM0RQemYzMUVSS0FIWHpZ?=
 =?utf-8?B?WTNKQWx6eUM5bk9TeXk0a2lja1NnaittSVVPWHVhZjlvWGhUQ2s3SHU0Kzls?=
 =?utf-8?B?UGovKzZjRUxBSEpZVkhoSlp3bzAzbDJsUUNwcUNNNXAwcDZCTmY1K1NXT2I2?=
 =?utf-8?B?b3h2Q2YvcVBRdlEvM2VQRFdTNk02OFdpWXZxK1A2V3RyWEJYSU81S25jNVdo?=
 =?utf-8?B?V01BcklaTkFsUjdkY1IyL1AxWWgyU1ZXcUlkRXBxMTJSdWkzWUpWdnZtTC9I?=
 =?utf-8?B?ZlVOQmtxQ04rT3doQVNLOGMxVkFBZUlpR1RCKzNMNHM3TTVkaGFVVklkOFVj?=
 =?utf-8?B?bHNzR3Z4TTF1LzEwamkvaFNQNlMrYW0wTHF2eXZmcU4xR09wemJYaStOZlhL?=
 =?utf-8?B?MnlhcW1aQnJqcEdZYWcwOFFkZ21FN0ZrRHdWckNZdzlYeW96VUs4TXd4MG9O?=
 =?utf-8?B?bCs3cEJiVE5YY0hNSWNLazB3Q21tVjgvQjRWb1NpSEd6Yk5JNmpzM0x0dk5K?=
 =?utf-8?B?VW5xekZEeEtid1I1ZzdDUjk3R2F3VGU5a3FtZEpHRnZlRW14ZkVWVHc3SVlz?=
 =?utf-8?B?QTJ6ZVlzOUpIWVZWc1p1eHBhd2xMMUVYUllyZlRSTHVUc1Mwc2tLRzUvbmJ2?=
 =?utf-8?B?M05ubFpPai84KzdjYkI1ekJxcUVFYS8vWVRGbVRuQUx0ZDJtMnVWQ2ZpWXZp?=
 =?utf-8?Q?GeB8bCdk1msG+6E0iG10qubhx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc36d7b-5836-41c6-543a-08ddc0474621
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 06:50:50.9934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJprg/165m1j9a9uxUiFGuYi+xAodM38Aw/X9UDNSVXNYgWREE3LsdarFKp2EcjC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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



On 7/10/25 17:01, Tom Rini wrote:
> On Thu, Jul 10, 2025 at 04:58:00PM +0200, Michal Simek wrote:
>> Hi,
>>
>> On 7/10/25 16:34, Fabio Estevam wrote:
>>> Hi Ilias,
>>>
>>> On Thu, Jul 10, 2025 at 11:28 AM Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>>> Thanks I'll try to reproduce it later today and let you know. Do you
>>>> know if we build this defonconfig in the CI?
>>>
>>> Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.
>>
>> I have seen this with other targets too. Toolchain from binman has no issue
>> with it that's why I expect it has something to with different toolchains
>> builds.
> 
> What host OS are you using, and are you using separate object
> directories? This feels like a "make" issue at first glance.
> 

I am on Ubuntu 24.04.2.

Thanks,
Michal
