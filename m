Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F06D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 05:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F70D80077;
	Mon, 15 Dec 2025 06:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="E+0tRo6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D98800D0; Mon, 15 Dec 2025 06:04:24 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B2880050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 06:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf6NleuiFLlvH7rwRQATEzicMX/Nho8nsKVaF6o4bp1B66lhmnFNKLFWnAxgsezbcxvPoD6vCtwdyVfUpRGXjhmdQjCd4Uj73SUIRe/f8Try4vpjKaWUissbI3h07l1r3yqKFg6ztea7ls88yKR4B2BQwLDp/tPnC6XKflIMnUvPSmHHhJKUQKiTA24u5vuoaKOEO/XcHPAuDJ8AE4tU8I0Mi7wybp4c8aQqbYnkTzFriArgE4qxtEnrF80gQ15JRdgJsfiWvOYFnuLN3oaARW4CG/4Jh4ScoUi/Dak41qvyyOOt7TeDAKB0E3IeuSxBowSIkKzJkbrXQSWrowP6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16GINtvjYJbukyFbcX2KftqWPwZzgfnJpgedcNNVfwk=;
 b=hPbwIXP9fZOuwZMD7/uNErITKFof/yTWQct2B/Aw+P/WNx75yI4+g9+1qNqY+EP4g72NXdS2ZPItYz8cKK5U1nx2en+EZyUI/j638A3AUgMRFR4zKhRTTn6D4N4KIvBb+mA8U0sI8Z3ONgB3TFWYcej9BGEwo3lfNMR1Ghgbu8S68c9DCYCu7OGskyTf2NKx9xVCu8y34BtylxP4uJ16JwNBn4xtbC6mIf7zNZefnC9vh3VX/1XLmsL7sbqbj+mm0hQxzjaWavN2Y/jgvwgYL3/nqqc48gHM71AaB95YhbQ1KXt7kiKqu6Fpan4VkgWBk94tC7yTiwILmllXu6dATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16GINtvjYJbukyFbcX2KftqWPwZzgfnJpgedcNNVfwk=;
 b=E+0tRo6IsK+5vRWaIHTGqZLZimS14fgb7MVw81q4P2o8czbgCjlp50UTtjHDOBfpBVzX5tYBf4ttV4CuO6QFxL93QJadH5B2G0/WiBMzFa3GpJnY9hv0q5Xy229qugQKpGAbgpcP2V7d0sDAqZqpnoWgUvyctxj2DOK/OiPdieHfYwfW8fmvi4LRhpty3npMzyCeuD8QkSsCBqysa5kr9fcQlvBdMbVqJDn+srsLm4oThCZ0r2aQ8qcIcgG4+P7/uo+duAfv3FjiqY007kR+WpSXQdQzYtPvEKDfIGQwr6bg+6rIgDnHB1gejLfwMTQ+/Cr8TUcWs1GUJ+ikOhZBeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DS7PR03MB5445.namprd03.prod.outlook.com (2603:10b6:5:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 05:04:20 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 05:04:20 +0000
Message-ID: <fc64f49e-0d76-4b1c-94ba-ae72be426272@altera.com>
Date: Mon, 15 Dec 2025 13:04:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arch: arm: mach-socfpga: Adjust a raw sectors for
 MMC loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
 <c9a6e6f8ec5e854057459e91db20a46c9420b392.1765470899.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <c9a6e6f8ec5e854057459e91db20a46c9420b392.1765470899.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DS7PR03MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2006d901-0eca-4e8c-cb15-08de3b97678d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZElVQ1pjR0RvTmdWb1dlZHJYQ3gxMVpVUHByeVhIZlNlZjlaejBPanEvQkZn?=
 =?utf-8?B?UktMVUVDZ0hubWFYc0I0UzRxSmQ2MWJ3SG00alFuanNMM0Y5NDE0NEFpWnY2?=
 =?utf-8?B?YkQzSjNlTE1xZjhCd3B3NHBoek1kNGpKc1hoWlhxMXZzNG5RS3lJTnl3TFNY?=
 =?utf-8?B?VktFaXFEWmxlVUxDQmhFU0VKNExsT3ZvSENLRncrakVSc2NJQy9oNmlXY29x?=
 =?utf-8?B?S0RoT2N5ZUk3QXNTVGxxVVBZUUlMMjdiM0hxaHhIUmdlKzJQRWxEL2pDZm1m?=
 =?utf-8?B?ZFhyY3Jyek9zR1J2Q3Y2d3BkNkFlSXgydVl3aWVKWDRvbVRvMmU3d3R6MjNq?=
 =?utf-8?B?ZmlOYkZPWGdyaUlkYVBqZmpjVEV2WU0vRGpmOWJkajJEOW5PVXhvdTNBcGtX?=
 =?utf-8?B?aEFZWlFrQkp3bngxbUtxdUxTcHV3WUQ5TXhFb2diaWg0UlJqM0hySCtFcktJ?=
 =?utf-8?B?amZVSm9xbWhHNlo2NUZHQ3hCSisvNSthdWZhQ2tEM09rZU0zQi9zM1YyVkZF?=
 =?utf-8?B?QVVEcWhVT2lhYjJKSzhseDNOckNlLzIzWldHRUZhUGhPakxPNldHWmxVTXVh?=
 =?utf-8?B?ZjU2V1Y0WkNoNWE2UWxnbWR0VThmVDlaeHRudTc0aExuVXVSSWZwMHV2QU1r?=
 =?utf-8?B?ZytrdlFyaHZQZ3ZwTjlxZHNzVHlDZjFFdEY3MS8ybkNLTGQ4dm4xdHhxLzV3?=
 =?utf-8?B?NGpoRThuRGFRY3pGREROakhWSkFvdERCd1NmcnltQmpxUG54NWd6ZEpjQlhp?=
 =?utf-8?B?aE5OdysxZkRQU0VtR3RFSkVpbWVybFErVmpZMGFsZ0sweGhrUXkrdXcybjNK?=
 =?utf-8?B?c1pHcFpyWmc4clRCVzFmMk5ZMzZkcUc0L09qdW9MWUFSalRCemI0OXM3Nnlq?=
 =?utf-8?B?TUdqeko1dDR6Q2djaTA0c2JVT0tFWSt4WW56aCtDckxOcU9PbDBJYWJMdS9z?=
 =?utf-8?B?NnF2RTJEUFhNb25iZmp0a0FBYXd2MWJvdStMSStuWVEwV0YwblFKa0IxUUdq?=
 =?utf-8?B?SzRxK1RWSEhocnBmMUhyTW4zSGlXemtlVnpDcitjZkVLbzl4ZERWbFhWZXIy?=
 =?utf-8?B?OCs5dU5TY1RWcGlIbm13amZyeXIwNTBzSDMwdG8raUhGVHlDOUpWekM1ZlRl?=
 =?utf-8?B?ME1RcUxDRmtKNjJreHIrcVNIaTlzWDZsOHhxdHZGOFJreGJKWE9GdlhnNnk1?=
 =?utf-8?B?K2I2UEpJZjhBKzVycGxqaE9FSEhYU3FlQU16Yjk2alBRYzhNcGxSVmJxc283?=
 =?utf-8?B?N2F0TG1HdTE1STY1SE1ld2lYQjZRdFlya2Y2Z1I1WStrT1lyM0lOWW1tOWV2?=
 =?utf-8?B?eDU0L2RnU0NLemJTZDNaQ0VpLzBrOFMzbkxHeW0zam14cktuby9OSmFUY1Ju?=
 =?utf-8?B?ZFpQV0FMQ1JSUGZDa2lkUjVlVVUxOVlqaEhqRTV0TUN3Y0Q2ZllCSndnK2VO?=
 =?utf-8?B?UExHbDNwQ3hkY2FmVnhGMHBXSkNIVGdTZHZia1ZITWI0V1JjU2JUMEVIYklN?=
 =?utf-8?B?N2Y2VVE0MGRlYStQZ1pyQUJ4ME14K2Q4RTdGMU9DWkZxTmVTa2FwWnY3Qm1B?=
 =?utf-8?B?NHNwR2ZpYjM0NUhLaEFvN1FyT3RCamJRUVdxb3lxQ3MvN3lyWXB4d2V4UWZv?=
 =?utf-8?B?OFFaZGtwYXEyM2VkNnJ2aHB4OU52QllQTTRWZzNwTDZNRlh6TEJZY3B6YzRF?=
 =?utf-8?B?U1gxWCtQdTJLeTdqZ1dpa00wNHdWbjlLS0FESWMyL2hEMVlVLzhzZDNGUHNN?=
 =?utf-8?B?NEl3QkY2QmVmUXRsSGI0UHBONUJIWUFSRU1sK0xrVlBMc1BUd0xveW1XNVpa?=
 =?utf-8?B?RU93ZUpnczRnWVRsMWkxY3hYc3UwbFBxdHVqUEN4V1MrbjJKa0kwNGdSczZU?=
 =?utf-8?B?dDk4OWkxdThDSkJNT3NFQjhxUzJuQUdYb1d1ZXRWVDMzVFB6blE1M3I3U2JI?=
 =?utf-8?Q?Fjz+xC3/zKZ93M8g5dxmOrwFGm+9YoMP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkpRdmhyVTdGUUFNUkFxZlFDYUxTUWtLWnBvMG9WUWQ5UEYxT2FaUC96Rnor?=
 =?utf-8?B?T3N2Q2tZbjh0dENBc1l3dFdTM1E1QnpBWUlMRFdCNzE1UGRPbUN2K0p5eHVE?=
 =?utf-8?B?V0VOWEJLSThZMHAwK3k2WlBwcDZ2ZEZYLy9DV3hqT1ZTLzR2VXRhTTZxcFpa?=
 =?utf-8?B?bXRlMFhDNEgreHhuTlkvOTNra0J6NjBOTzdGbWNWR1dqVlZ4WHdCU0VRNmhN?=
 =?utf-8?B?K3NHVXFQejVWWlZqM1EvZ0wxdlNVM0J0MkpPOWp2SndiUzh3M0dDd2JRWjBj?=
 =?utf-8?B?bWRCNjg5WDVETVhMZTAvVFRIdFcwSzFxaVdWeVp5dGxGcStweWY4OEhIMU45?=
 =?utf-8?B?OHlvN0RVaXlveVNoT3Q2SFV3SGJxRUpDaCsvbThQUTFRbU1QZ1BRR1BmRzZQ?=
 =?utf-8?B?bHJ1MEtleEE1ejhZWVJUcDM2N2RnQmJLSzcwMW02ZHlHeTBNUU15ZDRGdnNa?=
 =?utf-8?B?QngzNDBWVjJ2TmF4MUEvTWdvV3hZUmJvVWNlMHovY25FNXpZWWFWamNCcUhT?=
 =?utf-8?B?SWdSQ1B2SmNWdTFpeHZuM2RLOGVuTVVmL3F2R0I1MFg1bTI4VXhlaGVFZjhw?=
 =?utf-8?B?ZWN4Wmk3RjlWdVdjZ2lzT0ZMTXFoM2RlQTZvVUFsak8yMTRvazcxdjcxK2pT?=
 =?utf-8?B?ZjlPUUVQMlBQZ29XSnBheGhvRG5JY2NsV2VqTWpIQmhmNTU1VmYrR29vQ09U?=
 =?utf-8?B?aEcxb1d3NzNZTFRMTHhEOWRUZ25VMGN5aGIzYlJwVHNDUllXOW1EbDBkZmVp?=
 =?utf-8?B?eXJuQ21abE5TNFJYd3pVOGdzYUE5YklXY2pRT2Y3c3lMeElJbVM5WnVvb05r?=
 =?utf-8?B?blE4R1lxOWxwUGd0RGUrNVBQUlJlN2pMR3lUWFZhRFlEWEtyWC9RRVowVlZU?=
 =?utf-8?B?bHJHeks5d1crL3poR0NmRk4waFRZZDUvVFhhNGp1aEJnMHBVL0VjWTl0ODJK?=
 =?utf-8?B?U00wYloxeUg0R0JTaytqUUdGaVhkVUNKQTBlclhtZ2NwTnNVNnN0RDUxM2dY?=
 =?utf-8?B?d2IwOUdNbnRSbWxoUVFPK1hPYXFzaVlhNUxtVlNXbVoxM28vMGRFQ3hlT3cw?=
 =?utf-8?B?K2srWEdpUVRlSm12YXA0ZTVha2dKVXJSVGJYcXJxTnpRaXc3TERqQWNJZHRv?=
 =?utf-8?B?TjRHTjQwdDM3ZlpyMU9ZOEpVb1RXb1JVeW9taEw0RnlhT2ZadUtCMHBuazQz?=
 =?utf-8?B?cEk0M2RoNzduWFY1ZFBzWEhXOVREemlrWENiUWVkcE5qSG5Lc0l1RW85WG00?=
 =?utf-8?B?SWQ1UGRCcU9qNHBEbklhb3hqWXRFWmd0TzNsZDd3eDM5QjZHbDRqOUpCMzF5?=
 =?utf-8?B?UWMzdmI5VUVybVJzeXpobXI0Y3hEWHdiZ2lUOG1XUlg2c1NibE1LdGN1NDFq?=
 =?utf-8?B?Q0VZUjFQN0xkSHFlbW1YdUtFMkpHZVVRcWI3eXNBdXpjcXc3c3RiczRCTU9G?=
 =?utf-8?B?Y2lDUkFSc1g4UVdiejZFWWtPRnprb0VpMHRNT1Y5Z0VJY00wRDk5eXlwZTZy?=
 =?utf-8?B?THE5dW1xWGFmZHI0WGJid1ZRcGoxRzhOZjNtWk1kN2hnQ3dCbkhZb0dBSGxa?=
 =?utf-8?B?T2lCeFB4RUdOeDZ2b1plMEVteUpYbk0yZGI2eFozd0N3blVZMkdsZmMzQ2Q0?=
 =?utf-8?B?UW14SFRYeTgvS1l4RGlBZ3owTGY2dVFTK3dhZCtBZjNNMUJyYXYxTjNrNzRs?=
 =?utf-8?B?OXZ4bXMyUnVjMERRbjhHNWhVUXFBWklNWHNraVAyOE0vcGxHLzYxL0M5dnFX?=
 =?utf-8?B?d0wzbmFXaDFhL2xsTUpGNEMzUktnTDRVVnkwTFhTZ0dWNVBYWlpzSDVKKy9L?=
 =?utf-8?B?ZFdzVVczWHBaZkpNU2xFYzUrOGs0cTcxTjhhVTI0RkhyNStHbmVjV1dDQTRh?=
 =?utf-8?B?cm9kRytQTTF0NWx0WVZaWktyckhVTGVTTEgrWmVzaHczVGJOQkxCUGhFNHcr?=
 =?utf-8?B?dy80R213TmxCS0FwZTNvN1ZnRG54STFXQ1VTbUxrblo3UkI0UERPUEF6c2dE?=
 =?utf-8?B?ZGU5OGZSdExETWxMNW1qdmc1ZXVPdWJTWWpobVdjQ2YzNmFKSCtDMmxHN21I?=
 =?utf-8?B?V0ZYSnpYUENFM1R2bkUrYmxVTC85eHBaVnlqV2N6Q0NvcVlJTTdYamoyUlky?=
 =?utf-8?B?L0tTcWF3NnB6LzhhRDRYVVVWVzBEbW9OeVQ1QStwa2ZORWtkbU1hUVlWQ2lD?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2006d901-0eca-4e8c-cb15-08de3b97678d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 05:04:20.0039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYCTU9OKjpzHxqq5j4wYh/cwGD8XVB22l8noRdSaTzlY8cYerH+B7J8I/9u3oCP/OlCFCdhWUCtAiASRTXVc43S1Veh1tx/BdAlT6j3yG4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5445
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


On 12/12/2025 12:34 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
> More precisely, SPL is stored 4 times. Take this and its padding into
> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
> This allows loading from a partition, without the need to hard-code the
> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   arch/arm/mach-socfpga/board.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
> index 28554b7a109..7f65aed4540 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -14,6 +14,7 @@
>   #include <hang.h>
>   #include <handoff.h>
>   #include <image.h>
> +#include <spl.h>
>   #include <usb.h>
>   #include <usb/dwc2_udc.h>
>   #include <asm/global_data.h>
> @@ -209,3 +210,13 @@ void lmb_arch_add_memory(void)
>          }
>   }
>   #endif
> +
> +#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
> +     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> +                                                unsigned long raw_sect)
> +{
> +       /* offset of u-boot proper inside u-boot-with-spl.sfp image */
> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
> +}
> +#endif
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

