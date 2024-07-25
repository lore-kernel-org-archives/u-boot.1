Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07F6C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551B886E35;
	Thu, 25 Jul 2024 15:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gU7wo4tE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCB48692C; Thu, 25 Jul 2024 15:17:02 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F1986E35
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK1WYy1C1yyKbneBdxWWAPNXhUFfgDHgJvUWZ0VhybOuKG7xzlNVXltsrPsMBW7+H2Xq686rCnnwwlU/zR9SgpWQjtlGtUxjNK+/Emuk854xnuYToAZDk28RfbywfzszZwqkvkaKv1GrkVPGox5qXlOVGpgXxfs7AB4OKwEanp8YYHAyTMoyZaIguZMrKZIf6xBL5f8QU+d9MmvyUpPNOm3ZgB7ubO3OAR9Ng/dLCL8JE/z2Bo5kAv61xwVkEIOlD8x+xiO//bX6uXeE0H/K2pVQkG5eCkPkkKOLdEAW4imLTXN6AqInA5NnE/KscM32+shLLTr8sj4jQ5C+5GMhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HJ90KjsUOOi5Mt7JpdofWgWOCpwGLSluIr1GUcvyZw=;
 b=r8oPFkPUWjfRm2ByqX6onL0NlxEIuT58bUaqaXJT08Wc0pbx281Xecpu+Wy2gBQjbyLt9JnwyzXR7gn+bLMggZjb01T6reIq6X7qFYgNkLAbCGhUah3bWawljWIiGCd+xVxcRWSEgQ4Ec7AxglGdzJSRicAMdzuCmwWij86mpm0alSR16LT43R96AVvXQrFds/PkQzBSO6OVyywbgivRpZe9zLphkTFHqUUdLhSSywn6uYld/Ub5wDGrpaZ1Wfgdmk90Bd7RA1M1wn71dI80lvekAaANlNP6pn8s2NS9/JfZ3q6zyQTe6c6pmkGdgrmyh7n3tXpCfofPhoZz96Ozag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HJ90KjsUOOi5Mt7JpdofWgWOCpwGLSluIr1GUcvyZw=;
 b=gU7wo4tEYS69I+7bBBrfxvkoNgnFpfKoZmhWCamtZ+cbFZhAKRCPTLSLqHmer1VQwWPUHcnduwXXyIOiHHPepkS2Afdha18ZzRIo8l2GTfp238FxIaFeTX4cHsmRChNYCRVucIzeFOPOuWjhybxW6GfA9dERuSqjz1k6mRZ8JVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 13:16:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 13:16:54 +0000
Message-ID: <5ddc17a7-4c80-4b45-b1e6-4ec8e0f62e08@amd.com>
Date: Thu, 25 Jul 2024 15:16:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Thomas Chou <thomas@wytron.com.tw>,
 Rick Chen <rick@andestech.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0161.eurprd09.prod.outlook.com
 (2603:10a6:800:120::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: bae5ff6a-8d10-4d81-9534-08dcacac0da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1ZncE9NV2JMNkVsTSsxSGc2RFlFUmQ2WmlERC9qclJ2T0lxUFk5VkJudENZ?=
 =?utf-8?B?Z3pIK1pGenhPWDdROFZpVmN2cEQrOUpzOWhSTmhLekRzV2dtSGJWWkgwdWhG?=
 =?utf-8?B?VmpWd09Md3BZU1JMczV6cnFLaHhSVnMzeC9GMy8zcWI3TmlxZGk4Y2Z0MnVz?=
 =?utf-8?B?a0RGaytUR1plOXZlZ2VCUmo3Zkhsa2hKd0NYNU5EWmFWS3lzWDFvbWVvS2o1?=
 =?utf-8?B?bnhiYmFnUmJ3a0dCV3I5NXY0SHhCc2NaQ2UvY0IvcW5Yd3A5MmMxSkhObGlX?=
 =?utf-8?B?T05YMENSVDNab3hJMHVucWhFWnVJQVVrU3BTdVdITFAzd3BmQnl1K1ZxRVUr?=
 =?utf-8?B?TUpyMWxCMjU2b0xYT25kODFVZjdkbEgyRFZnZzQrY1pEZ2Z5ZllrN2F2WDRJ?=
 =?utf-8?B?RXpGcjM5RGVPQS9rbkRNbHp3NkZVb09lSzgrZFBTYWVlOFZLZWFPZVFWRmRL?=
 =?utf-8?B?dlF3RVl2SW1IeGpkbmJKMzFoNlh6bVFySVEwSVFzMmw5dFBXU3ZoUU43UG1N?=
 =?utf-8?B?VGJXcUJTTE1hdmZDeWRYZWhhRStQbDJ2YmpSNFpTTENlaE90M3U1RHNaRUZW?=
 =?utf-8?B?MlhvL3MzRHBKd09pQnVXYWVXcmxoamRPQ0hFTDhQUTFsaVFDc1ZsOHNxeU5J?=
 =?utf-8?B?UG1UOHhNSGpMKzNHTHZUbGNzQ1hSMFNWQUxqTHFoQk9ncE9VektyYVd1cHNM?=
 =?utf-8?B?WHI1SUV0OFhMK2FmSklrL2MwaU1haFNaeWQxU24ySUp5bUpjTWJqK3RtOXZp?=
 =?utf-8?B?TXZyQVFtZVlSS1RzVWVDSGVuRndIbHkxUXRQMlhlOXYrVnNrMElOMGdHamNL?=
 =?utf-8?B?a084ZFhWSlhKN09yTkxMMnIrVWh3cUFkTHc3TTBpWG52RlFpQlJwRWlncCtQ?=
 =?utf-8?B?WWQrMGFwdWxOSE5CYmZkdzFockF2cnViUG9VQnNYd1R5MTVURkFSeWE4b1ZM?=
 =?utf-8?B?WGpHNWk4NXhJY0ZQZmh2bXhtOVErZVdMOWJwSzczRHlkaW1ZdFpuVGl1U2V0?=
 =?utf-8?B?ZnRlWks4Y2EwY1pEVFdldUxQOUVZL0VrR3BFcDZlNER0YklmUlcyT1pySFBr?=
 =?utf-8?B?aDByZk5QRlB0Uk43eVhiLzFaY3d5R2V4TVp1UmVHMDVsSUtKZThHUldXTlor?=
 =?utf-8?B?SUNGMkE5MXgwcHphTDRTSFJ3WEc4Vm1vOFhremQ3NzdKcXJYT09MM3c5UTNH?=
 =?utf-8?B?T3JNaHZqRTB6cHNaeHZRYUlCZWpyMStCQksrS3BGeFRxbFJKMHVqNjJpSC9I?=
 =?utf-8?B?NTdVa0ZDNytvZDNnc2NueFJEL25DanZuWjJwQmpnRENFem12K1grVG9ieklh?=
 =?utf-8?B?NjVyUy80amVoVVlEaVJEU0FQMWtkT25EVUU3UzI3Uis5by9pMVpvdEtmbzVE?=
 =?utf-8?B?NWVxWTJPWW42WFpCM1ozRDVuQ1h4TGRWL1ViQUl4UDNDUmNwdkM0bFZzZ0R1?=
 =?utf-8?B?dWJuOUlkbE95VVQ4bnloc2c3b0hmWHNvUXU2ak1pLzlDNmk4Wms4TitVVlda?=
 =?utf-8?B?WkRsdjBaTDFqR1dnVTBEZklaVUYrWFRaTEM4WTRuRC9MYVBJZ3FrUHBpR2xu?=
 =?utf-8?B?dEorN2U2OXc4SmwzQlJvZTRtSExhZFV0OS84OG95RjlGbTZwWU56MFlBMEVE?=
 =?utf-8?B?UXY4WGtyMjBDVWc4Kzg3YWdtc2JEalRqRDVyeXFsTVpPRlpxRWVmWkpucWdw?=
 =?utf-8?B?RHRoWnlheGxHMy93M3hlVlh2d1p2S0RiZmo3ZSs2Vnk0cks4a0svVmg1aVY2?=
 =?utf-8?B?QWUwRWxmeUNqdVIrU2JJU0ZOa2szQUlxL3o3WmVpalM5TUVlT2ZRMUNDRXh2?=
 =?utf-8?B?eVN0amlKWW45aWkzNFByQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1TMnlrUlYzczhPVThhQVE5TUJUMGJFS1dxOGh5QUsyZEV5SmZUS0JwMG9D?=
 =?utf-8?B?Q0dya2xYTFBNU3pmQWdaVTVxNFV0N0VzRFlvZFJUODVuMThnUHp6S3FoYU91?=
 =?utf-8?B?V1NqdWs4bWlCaWNrZ1AwbUswQTN4MXRQUDVXWjVFUFFVMHd1eXU5c0dwc0ZF?=
 =?utf-8?B?T0hZcENSRHZ0R01vc3VuWDlFWjV2S3VTSjlmTGMwMmVPQkpla0JFT1pDbVQw?=
 =?utf-8?B?cFBGb1NTL1djRG5neVg3Vno5a0pCSEJMUmVZdEY1NVpVU3M4Y0ZUY3ZLTmNy?=
 =?utf-8?B?eXVIZTVENmRJSHlXNzNkZkJqV3Z4czZzRVB2UDVrN0EvQ1FhMFNqbXZiZzY4?=
 =?utf-8?B?bkVxeEFDcUgzcThoMm1oUk9ERUU1VGVOUUtRNHFjbHRJcEtpWC8yOEltTnBM?=
 =?utf-8?B?aFkxZ1h1bzVnU1lHTHl3d2Y3a2N4VXhEaElhZEVZRlVESTFSL1Q1ejZ3U21P?=
 =?utf-8?B?SS9kNHNwQi85cFc4bnBteU5kUHdzaklIb3JDVE10S0ticDZtZWttZDZSWjhN?=
 =?utf-8?B?UU14Rmhsc29mdnM0T0ZuRDNyd3FDZ2pZcExLMnYxKzBzR2NhdEVlUW5tSXdv?=
 =?utf-8?B?SUpUSHkzdW1wQ1crN0xmYkdNRnovUDVlV0J0WW90dmNTMWFuNlZ4SjQ4NitV?=
 =?utf-8?B?dTFCNWx2L05NOXpUc1pPZlJDbnZhdk0rRGk2cFBENlhHUFh3aW9lME5wbXli?=
 =?utf-8?B?Sk9KKzcyTkd3VDRITVo3SmJDYjBlQ0MzRG9sRGhtc2pCOHJxZmpCWExDTEo5?=
 =?utf-8?B?WHNDK3ZNb29xOXViamgyUG9BRWpPTzdQUVRkNm9Rd285REZaM2xCcXpRdUtK?=
 =?utf-8?B?QU1ZQlo1OW9pUmpEenB4ajVqekZvMHo4clVUSjg1Tnl3dGttbmkxM3kvZlNW?=
 =?utf-8?B?OGZhSlV0cUxxWlVhS2ZEbEZOMndtQTAwZFo3WVpaamNBYytBSVIvekR6cFdw?=
 =?utf-8?B?UDRya21aL1hEODc3Z2JsdmNJNEM0RkFnay94OTQ1V1FkQXFSQ3Z1VDUvMEI0?=
 =?utf-8?B?eDFlUThndHZWY3laZFRaUFE1OFlteWxIME1JU3ljL0p2NlJHZVRYNTZKRWZ4?=
 =?utf-8?B?N0JDVjZ5bUEyT1haT0FTbitVdnU4SXdyNERLVzNWckVEckE2dndiRnowU2tB?=
 =?utf-8?B?UjNYNFV2V3dpeXhrUzI4dXJzSUJoTmptZ2JlRzBZL01SVGp0clg3MTdyOVUz?=
 =?utf-8?B?dGFUOSs4bUljTElndW1nbW9Vcy9ORnZuTDQ3b0lyUlAreHZTUDlLSXFOUGRG?=
 =?utf-8?B?a1pLUmFiSXlMQmZMd2I5OUdBUjFSeVdpMVpXdXMvRE4yLzg2Mm1pNjcwRHRP?=
 =?utf-8?B?NjN0a2VNZk1pT1BkeWVuR0k5SDNqdmYzK05NRVh1ZnBpWDQvSVo1dmNzdkpR?=
 =?utf-8?B?Q1BWZk9ibjRWVTgwVys3eEpacXZuc2E3SUVyaVgxWEx5V1lXNTlMUzdaQ2Uy?=
 =?utf-8?B?eXp4MGhlTVh0cEVqSmM4WFZyVGFBTTFZcTZLUC8vRmxDOS9PWmE3WVF4UUlF?=
 =?utf-8?B?cHVSWFlHNERwTmkrVDFVVWJNbjNUNlJ5Z1VURW1ROTBidGIvdTlNblhNcjhU?=
 =?utf-8?B?bnpldldhODBPOVBPRFJac0U5dHJxMEc5Z01WNHo0cHNnVjZCWHh0ck10eS92?=
 =?utf-8?B?aGE3bVY5Zk1ERWlXdWdFNHBrZWNiTFFjMkNkenUzWFRFc0FUZXdPM0xpbHZG?=
 =?utf-8?B?RUQyN1RsVmgzdjdEQWdEUlMyZlRWcXZpY2JEQStZN2g2RS9pNlNoQUNqdDN5?=
 =?utf-8?B?Nk9vQ0FRNStxUUd4RzFxOTU5MFIzU3pRcVNLZ2ZKK29jQkZHcGt0dW9IRk1v?=
 =?utf-8?B?QnpKQmpjY0FHVGF3R2E5TkZzRzRJY1RGUDNLOVAyZ0xsLzh3aXBVbHg0UVdM?=
 =?utf-8?B?c0gwSjBBOHg4T3kzdUw3a2JVV0JyOFZHdjc0MmRxMFJ1QTY5MlYxRGRZNUth?=
 =?utf-8?B?Y0VNVkZ0TkptQUVLWXBFb0NaQVJMWCtETFp0SXFGaUMrOGJ3OWhoV2IxNmRw?=
 =?utf-8?B?TlpXRlhaM2FHanpidSszRGI5dXZldURrU1VWb2t3N2F4K3hEa0tQcVVadmd3?=
 =?utf-8?B?U2FSMmVvWnVGWlpNWWh3UXBuZ2szb2RDUG5kbUZKTUZIRXJhNHJ3ZUFWNkl2?=
 =?utf-8?Q?PhVhsS+nicRlKrMCIq03kQBJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae5ff6a-8d10-4d81-9534-08dcacac0da6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 13:16:54.5558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pZ/x3cldAlHpCSgO7ub9VNGoaSDHtSsMq5kQ53H8FVe1zTJd9REseT/pQkEzkRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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



On 7/25/24 14:54, Sughosh Ganu wrote:
> On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
>>
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> Use this new data structure in the utility function.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>   lib/strto.c | 35 +++++++++++++++++++----------------
>>>   1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> This is rather big growth when we didn't already have realloc:
>> 05: lib: Convert str_to_list() to use alist
>>     aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
>>              xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
>>                 u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
>>                   function                                   old     new   delta
>>                   realloc                                      -    1120   +1120
>>                   alist_ensure_ptr                             -     140    +140
>>                   alist_expand_to                              -     136    +136
>>                   alist_init                                   -     108    +108
>>                   alist_uninit_move_ptr                        -      76     +76
>>                   alist_add_ptr                                -      72     +72
>>                   alist_uninit                                 -      48     +48
>>                   str_to_list                                204     232     +28
>>
> 
> I am working on an implementation of lmb maps using lists. The list
> nodes are then allocated with calloc, which I believe is included in
> most of the board images. We can then compare the size impact with the
> two implementations (alist vs list). Thanks.

Inside LMB code it should be fine for us because as I wrote we are disabling LMB 
in these mini configurations.

Thanks,
Michal
