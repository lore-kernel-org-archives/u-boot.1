Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48F0D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 10:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48EC0844DA;
	Fri, 28 Nov 2025 11:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ouFwqYiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A293844DC; Fri, 28 Nov 2025 11:17:07 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D50844D8
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL0zwaWhByu0XS1MyXv06AGc6rCA5qdaOlM/3QlnGTzM/HttRWpghh5R+m8MqI7ClRYJWysYfER//MUpOu3JcUH+NE2YrhJJlTVZGUFQq4729ULqgMY3+rKD/NLE/hUYWBUU0eWuZkhaxKhWFafodUzIvm6RA06AaYPDFo7/gJKPXvjSmF4AsWYfTqgO7i/8jwXiT5oMv71MbBj0E6RgB+ZKqd9yYy3tKJ1NMagHeLRJ0oP49n8T8YoBdjjfFYsOPiRHDpaY+iNNTz+utxjM95gC6jRsgoNO082e1YMsb8pDN2T/MjJT30VEthoS9jK57eO4dQVX0zcpAx/ojpA/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/JXj+gjD1uTZOUDa7EcTHt/876a+jkYpz+CfSf8OTI=;
 b=AflMI0MnoA3R9GwrYgAAy1FVGzbnOJDeg9U6OJ1cxtwozZcZC2853oOmBwpqShq1yaaLdiu3mVoR+O2+NVNyuuf49+zQRoC3JPzT204nQe/tyzGe7a79zlDiW1cCrRGzVgOBWvBJp61lfcTQwtjbov9/xLXXkUiLh/F1I5c8ONlsa4EocqYTIowjm1PJBYEnpDiwhf4OvvqW8qwZmzl7NZmC/x3ETC38SVRwRGJ5xCChIYUBcxFSQriu2OpVZDuJh5Aqu+VCnjqGGVCT3SVDrETGXRl8v6lcPAZFaLZBJ+kDgdViY2B3f0LfsCxxcl2Jv2yTF90t2Ts+/Yz3dzqFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/JXj+gjD1uTZOUDa7EcTHt/876a+jkYpz+CfSf8OTI=;
 b=ouFwqYiXBjc0VGwq1QMwMsMBWUrzbU/jBkRYv67WRYdYGGAeDl4upbetdmPoJp3/nCvnWJ16v0QZUmqzO4LyuP4CMkh4fpVAYpG+sjkZTHFy3d7oLtwZgfeNUvFdn8glH3faazkufKXMnyzxuSmE+0SzA2gGT2UPMTYDZ01IqQhyx8VDDU1i8ktTqTnUsduY9EooOmjRSWLYQ2lTfLMqUXdM1QSq+AYEB3n1HAecabZiP2gvpFN0/lt0WSmahCI4+6QjzdtTc1S0ciy+jrUj958uaJpqiR3NtWVuDzrtJG7WZoRV0EiqvaMPi7R9uY4Bb7NsdxL2txmMF4rnlGk9Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6400.namprd03.prod.outlook.com (2603:10b6:510:b6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Fri, 28 Nov
 2025 10:16:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 10:16:57 +0000
Message-ID: <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
Date: Fri, 28 Nov 2025 18:16:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e591ea9-3f1c-4f14-df24-08de2e6742d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnIzRHBRSHdseG9TbVdidHZyaEZBWHJwdFlWYkR2K0gyaVh2SnA4bHV3SGdk?=
 =?utf-8?B?LytaaVNEeS9aVXdFQ3J0TEMrdHhrZjRhN1lmWVIvcW5yUk9xQnBmZHNpd1R0?=
 =?utf-8?B?cXByN2NxSGJGYmhtbU1WZTRabFZBN1FDMC82WkVBcFBYNVB1WWE3cVhXZVFt?=
 =?utf-8?B?R3E2Y0I2QkVMNW1xcW8zSFNUUjd1UVU2OGI4ZjE1c1N2NEhoZVF1WFZQc205?=
 =?utf-8?B?NmYzc3A5S29ZM2tpMEVyMmxIUktrRjlUUDlkVGJkQldJQlYrWkMycG5MT3Fx?=
 =?utf-8?B?NXBoQWp0S3QrQStoTm5LYWQrekoxZURmZnpHZFhaanJEZnUyUkczRWlIUW9D?=
 =?utf-8?B?R2xkeGgwUmZubkZZOW40TGpuK3Q4bnFudGFMVHZwODZNUHB0eGpTSktGS1J2?=
 =?utf-8?B?L05rMkw1YVJkNWhNdkEybHpyNm8ra29XazVhQlRBSWgrZzNsNUpPVkdtdk1V?=
 =?utf-8?B?YXZCNlJSWHBWd09JbUkvYzJEenZtdW0xRHpQQ3dZaXJOMnhZeG1vQ0w0cGlF?=
 =?utf-8?B?ZFAweGpLYkhDTUc2T0ZCcDZQUnZnVmhlZFgvUzJiS0dHSGg3TmJRQXFueHJw?=
 =?utf-8?B?TC9CUHpaMnlyVXpwenZWZVcyYVRLYU1vdVRFR1N1QmFBZ2sxdFMwZUIvY1or?=
 =?utf-8?B?djBmdVVDTFZYUmg5RVhwNG10WmVUU0RmUlRscmRzVmxqU0ZWZXJKMVk5cVJT?=
 =?utf-8?B?YjMxM1RHa2FMMEJUeW0wZk95VWliaEJtcnJBK0ZLZ29pQUZkdHVZaE80Rkk4?=
 =?utf-8?B?WDdEdkJieU9vWDhnMFJldHpqTHhqZjJzRGx4TEM3TGVRZjN2UnhUR3orSG5u?=
 =?utf-8?B?VndzWVI5djhSQkJkVUpWY0hZc2ZBbklDc3Z2cDFJUFFwYjI4cE5LR1pNYTQr?=
 =?utf-8?B?NzR1YTVMYlRQc09OS2xmWXY3bnJtbzZicjdKa1orTEdjRmlaYU5sSFBDbUxC?=
 =?utf-8?B?QXo3UlRXcXpIdHBwQTlOb3JyeVl5bnBQNXVPZEdLVU5qUVRTWGFEbHNpWE5z?=
 =?utf-8?B?c0VrRm9CNGF1VTlPK3lJZCtXVHVKdk9XSTJ2ak16N3lrd3ViaXVXcEdtcUV2?=
 =?utf-8?B?U1EvR21sL3V2WjhoZ21FMXVtOHVBVzZNYVpGa1luSE5Yc2hwZFh0WnFjK1A4?=
 =?utf-8?B?bHNxN1NsSHhHUXE4RTQzajVvQTc0M2dzcWxlWFdrSkNQUm5zYm41aHI4NHQ5?=
 =?utf-8?B?YmJmL1M3THQrWGlZUjVaR2c2VUZLRGRWSWZqdUI0dDZwa3dKc2JJSGlhcTBr?=
 =?utf-8?B?U0tFNkhhSVRTenc1RnZmbzlGWlBlVVVxTVo2RGRPdXNCZk1FYi9aQktTdHQ1?=
 =?utf-8?B?VW8rblhsaEZZYUJnYiswRzJGNnpqUUM4R3FUczlIK084dWtWUVl5Nks2RkZK?=
 =?utf-8?B?YlpLaUNjQmpFZWtkMEM4Q2lmM0hGSmthSVNLa0hhVGdJVElPRStMTWpTVkMx?=
 =?utf-8?B?THNlWEtiSGdqTFlYZlFWVHd1TU5LV1FtMWZHMGVDbDhFbFV0eGRvYmQvM3Ew?=
 =?utf-8?B?WDhvdktCTjQvdkdGZVljTTR4VWpNSnhtSHBUa3JwY2tKdkZLRTh4Wml5VTFY?=
 =?utf-8?B?U0dnTlJwOUZIaWR0WVFqUys1VGwvRG9Yem5tNXZpU0xxeUZYQ2huaUNzMkRB?=
 =?utf-8?B?WUtvc2NPMm5HSmpxREZ1MHQ3THBiUCttcm5zWG1zVEhwZUpVVVRpS21TVUNS?=
 =?utf-8?B?MStzU2RjVGp6Q2EvYWRONk55R3cycHFxSEgvMkEybDBrSzBGejg5aEJmVkxH?=
 =?utf-8?B?VkNJV1kvNWxDWEJPTmNwNWxxdDBjYjM4Ym56R00rR0RrY0NEcHRHci9xM2cy?=
 =?utf-8?B?cGhBZGt3RmlGTXdVWUhramZWblhrcVMzOXJxSmpPTjhlNnJZd3NNbVRpUlhQ?=
 =?utf-8?B?ckxRR01ldjZpWkZLb2NydEhpQU1wemIrNVc0UjcxQ2FaUHd3clhGd2ZtU3Zh?=
 =?utf-8?B?bXBXQUVIczlOQlo2Q0xKUmh5akJsaDNEcmx4QWR5dWdQZmRoK3FMbzdHQjYr?=
 =?utf-8?B?ZmZDM2VkQVBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUc2YTFtOGNmRERMaXBxS3NLUm9XbVVYbWhvZTE2MDZCQnJ4Z3k4MThkZ1l4?=
 =?utf-8?B?azBtdUlFZWNOOGdzQ0VTOEpTWjAxWnNxS2IzamtWSDlXWlF6TFRBSW0vNnJM?=
 =?utf-8?B?STRwNENJT0NzWjVLNlM1T3dIVzZLTmluenpzeE01VmYxUnR1Q0VSNTVLOGE0?=
 =?utf-8?B?SXFWVG9ZQ1FRejkvNXVlVExGUXFad1FLbjZBTm5KWENZa0I2THg4SmJtSXdT?=
 =?utf-8?B?MWxPMTJNeDFNZ00yemlXcHVtdGpCd294dk4xVitmem44cVlpTWVMck5HMFNa?=
 =?utf-8?B?UENSeWZaWFdwaTJ5UnRHb1VCTkRCU3l3aTVrcXNiRU9kbjNCQVpqd2o0L29W?=
 =?utf-8?B?eVNGei9VVFNFaGNyZHdQZlkzN084RkdaTk83NjJRcCszbEJxNGZ2NGNlcHRH?=
 =?utf-8?B?cXlQbTgrYmpwYVZWeGlOdUI4Skp2cGtlenlUUThKMklnWDlaNUVaUXdKcWd0?=
 =?utf-8?B?QmVMRDc0L01PdE1ONDBCdkNxb3ZVSGVvTllob2xzcE1ka3dJU3ZnQ2ZCZGJn?=
 =?utf-8?B?RGJMWXlGc0FaemQ3ZkZLRFJZaUZHSTUvVHlpc2k0Z2QrUGxXV1dJbmtNVFlp?=
 =?utf-8?B?MnF5MFlFOVl0NEtmcHJsN3VNeVB0cGo5MkpsdFdSYnhwVjE2dVZvNTAxRUs3?=
 =?utf-8?B?VFVzZXdlTXVaSWZ1M2N1QWRESW5rYmVYcmpyZ0htYmZBcnpGa21KV2x1RVk5?=
 =?utf-8?B?WTJHaWlvVTVPMFpSemdmbUwrbUMyTkQzOGRpRWU0YW5Ga0xkQy82aHMrYnJm?=
 =?utf-8?B?Qk9JdEpPbmhnOGMrTDE5L0gzYis5V2VmakxoSzZwRkJxbVh0NUlwNU1BYWox?=
 =?utf-8?B?Y0JGTlowa1NNNS81R0kvbWQ5akZhWm1Pd3kvTnBvOUdwYnFpRjZ5TWF6ams3?=
 =?utf-8?B?dS80QU95Y1hQODFhVFo1K1pHVklHTzBRQnprOUMrV1haYmlPL0IrdWlmM2NF?=
 =?utf-8?B?Q2g2OU9xa0ZlL3BFajV1UTFFUXNReVk5RUpWeGlvWm9ldkZTbmlNVzZWRVQ5?=
 =?utf-8?B?TVA1SW9SNEc2UVVuQkxqU3ZIcjltem1KZDA4YnpzY3FqWWI2bE81ZHBkRFdM?=
 =?utf-8?B?VWxLVXFmSWMvZ3hDelhPTGlJK3BzVUMrVXRCQWc2Q21LQXJET0djQTQzZHdN?=
 =?utf-8?B?ZnB6aUVVRER1NnNBWmRydkZTN0hvOTVlaVZMOVloQkVSYVpCWWIwMzdHQ3o0?=
 =?utf-8?B?TFBkblViTE1jMC9JR1lwdHRjRnZjcDRiU281MFlhM2hsZVdYMVlTNUhGZGN0?=
 =?utf-8?B?R0xKZDJJa0x2SkNPai96Rmw0N21ySHpvZjgvRk9vWWtwbTBIc29pTU85eTA3?=
 =?utf-8?B?eSswdFpsY2tUM0ZRQkhaZFByMTlNeko1cHh0Q3h6OEs3MUViMXlNRkZxS3pt?=
 =?utf-8?B?RzIyNkpEcS9VNXp3MEhOWUtDbEJwNzVJdmsxeHpEQ3Q3eW1uQkdlS01DQTVP?=
 =?utf-8?B?b2FYUGQvbnI1SVl6bnZNRnRZaEQvbjNhMElkenFTc0VtV2JuR1BZenY0Z2ln?=
 =?utf-8?B?NnJ3bUE3b2hDZlVzc1pxY3dOZG9BZWZUTkt2TnU1eGMyUjVKT2R5c1hiRTQ4?=
 =?utf-8?B?QjBsRlpoU1BIeGlNUWN3eFRwODdmVlAxVzIwUG8wUHRhY2J2MG1HVkh6ZDNQ?=
 =?utf-8?B?U1FCdzVObXdaREdyY3R1VHVXYXNNb3JGTVVxNW13U2tRL3VpNnlRZ1BwbEFE?=
 =?utf-8?B?Qjk4aDRHWGtrdEhoUDR4dVhmT0NNaXJDN1JHRXpOUVJHK3J2eDJNWXdkeUNz?=
 =?utf-8?B?K25Pbk5Bc2tkeWdBeXNpTm5XRUhPN0JZN1pyczA2Q1JSYzV0QlZBSUJpb2VG?=
 =?utf-8?B?UUlpRTVUWmM5Q1lRODJDMWxEbXJXYlpFTW14cmZ2N253NlE4MCtsN2xGY1RD?=
 =?utf-8?B?Ukp2Vk5OZ1RIOTJjWHplTmFyY0dUNEZwTFp4K2NXL0JPWkVPT1cwcDluN284?=
 =?utf-8?B?Mm1Ea1lucDJBK0F6QXYybm5BRDc2N3JiaEJIekRUSDJuOEZzcjliUmhoUTIz?=
 =?utf-8?B?MExvTnY1S2VZTDZZV0dJMGZ2U0hkTEwrUUV0Z1NSWkVHTUdwM1AzZzcvcThl?=
 =?utf-8?B?aFVRaE80WENFcFVqVjdVdDFKaTJzUmFRcDZtNTY1U2ZCcWlFVnZUL0hrQ1Zi?=
 =?utf-8?B?SitydkRzSXJjUUg3NTdhaWNhdkg5MzVaTTdXbCtxT3VUdFp2cFVYSU85dnU0?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e591ea9-3f1c-4f14-df24-08de2e6742d3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:16:57.5155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+ymU5jIFZcy1AkUaivMcsl7ESuxWHui8HpHrV5GhGQO3z6/nU+Q2oZkr5SUqAsXO9JHePTw2ZhIBdm/gU/p+sFiljQG4KV68x9IMnkiQNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6400
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

Hi Brian,

On 28/11/2025 6:04 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi all
>
>>> CMD_CYCLIC is enabled by default ("default y") if its dependencies are
>>> met (that is "CYCLIC" as specified by "depends on CYCLIC" in
>>> cmd/Kconfig). So when you enable CONFIG_CYCLIC via menuconfig, it
>>> enables (by default) CMD_CYCLIC as well. But you can disable it if you
>>> don't need it for example. If you add a "select OPTION" in an option in
>>> Kconfig, you cannot disable OPTION anymore.
>>>
>>> CMD_CYCLIC is not required, so you shouldn't "depends on" or "select" it.
>> Yes this patch had removed it by cross-check via real board on the fail
>> calibration issue. But CYCLIC and CYCLIC_SPL still a must to fix the issue.
>>
>> Brian
> Would Altera also confirm this issue a bit?
> I can repeat this issue by a fresh pull build.

Thanks for sharing your findings. However, based on the behavior you 
described, I’m not fully convinced that enabling cyclic/watchdog is 
actually fixing the SDRAM calibration issue itself. From the SPL side, 
there is no clear timeout or calibration control path that would 
logically be corrected by turning on the cyclic framework, so the 
improvement may simply be due to timing shifts rather than a real fix.

Before we go deeper into upstream work, could you try testing against 
the official Altera downstream tree?

Altera official U-Boot (SoCFPGA):
https://github.com/altera-fpga/u-boot-socfpga - branch socfpga_v2025.07

This branch includes several Gen5 DDR related fixes that are not 
upstreamed yet. If calibration becomes stable with the downstream tree, 
then it is very likely that the real fix already exists there, and we 
can identify which patch addresses the root cause instead of spending 
time reverse engineering a solution that may already be solved.

If the calibration still fails even on the official release, then at 
least we can rule out downstream fixes and focus efforts on the correct 
upstream location.

Let me know the results, it will help us pinpoint whether the issue is 
timing-related or missing a specific patch.

Thanks.

Tien Fong



