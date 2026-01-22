Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7613DC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9BD8397D;
	Thu, 22 Jan 2026 13:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIJ2a5Mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAC7839DF; Thu, 22 Jan 2026 13:32:53 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46C480077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2N81mZSt0iR90cJcmuY+T7dG1j/zEODlc1Sotj91BEZpwOfuH9wSY9H6gcy4FkNmDG/LfSKlu6YlUN//CC0v4nFJSsmGq1JMdAGYDahtAMd1k166rIerkZyLUuQllqLaV2TLy2DV1WgIWzK+hZN463Pm6TYLEDekx/mCi6qSuPbdX/AzF162uCMXlzNcl86Op3D11BS2GJuIhKvZYgLJamwbK/98Q8CKDhjDGjC+JAJBu3o/NaJw3St4IjUWHr9Y06bpPEMUdYnoZIAASQmS/UszfvhG5d4rdtaJh9lI9JFEgt5gQIo1l0zz69E2w9hNJ/JDdu2fKefA+rut8JDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3V8Q1KZW/u0P2CWygo/pQeI8eLNLam4EbGqDIVmNC8=;
 b=EjF+24BNUM2eKyfL5GhGxvfYJQGNGbEr+R2ZdylEgnUbwi4WLuicRqVD/oaHcsV7u3gcEkkRy053tpsZntIdbk9ZbL6OZnZ21G/ZYbPYLxYKDpfN8Fq3fI5iQ42GfTOV0100VwC4pFoPEfLCVxr4Nr9luuYNxDKW4rJftIQmEIdFkcG3irCTQpLIf9RJRGf7M4bU3sh9H4wc0gYrgY0Xgh1ronobT8zyDtQmb0uM+lM1FWvufnekuOhILl9vhbjO/S6GvF+Jth7iv4+FCGLLYbIWQTB2KgYk2gXXJhYpYxQ4gmbBnzoeuTulvhzzDkm73I3jWXQzBKK5ll6nz8fXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3V8Q1KZW/u0P2CWygo/pQeI8eLNLam4EbGqDIVmNC8=;
 b=RIJ2a5MnrH6HkmP4BlS0JajpANcDnDJbUNytP95en3e/EbO7CC2RBQjUbYOTStheOeJo6BHNC1tthzXBH3sqNqn3gzeIIKnp1VRh8wme7+eZngsYVpNs2VjARyNWmO8mJBeQZ00oI+hz6Xg0qiXytaUfRBza/CPHYrPvBLdSRF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 12:32:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:32:42 +0000
Message-ID: <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
Date: Thu, 22 Jan 2026 13:32:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0041.eurprd03.prod.outlook.com
 (2603:10a6:803:118::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe9e46-8593-466a-263b-08de59b25673
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVBuNTR6YzJOR2xPVUQ2TjIzTVdlcGZsZWZQaEpOTnJpR25udGhCSDVEdHJo?=
 =?utf-8?B?MWhuZ0pZOHlacExTOUg0T2FoRjJsTkwzZWNlK3V6RkxCS3NSTG1GakJJL2Zy?=
 =?utf-8?B?TVNjRkVKL0tzLzdVRUpacGJDenYvU2FqNG5UbUwzS1VUUEkrOVNlelhVWCt0?=
 =?utf-8?B?MWtNdVpSTkJOZU5CYmYvRVNCYVk4aE45cnhndXJVNDFSajJRWjlHTlRIY3hi?=
 =?utf-8?B?YU9DTDBWcU1KYit5eHZ5aURTajNzQnBBczFkbGJkd05ZM2ZUV3BEdElOQjVs?=
 =?utf-8?B?OHFxM2ZJMHhLN1VGRWRJRXBTNnpVMHZYUnFObnlNVTZ3QVJXUzNpdGFJUXV2?=
 =?utf-8?B?bElEeFRKYVpWV3pLSXpNcDM0YlpmcTBUS29mWUhDZTdDcUhEVDN6TXpwZGlX?=
 =?utf-8?B?WUZ1bldlRm8yWkJ0RGVpRk8xbE9udlVya3lUMktZT21zbCtDTk9pbUZQeFNR?=
 =?utf-8?B?enlOYVNHcUVKdndob2Y5bENxcjFFSHZqOG9nTnMzcFpNcFRWNjdFZVh2MUdC?=
 =?utf-8?B?cUZmK2p5UkFYN2YzYjdzNURqakU1b3cySkdGTWdIb1crMFVDWTRBU25oSkpX?=
 =?utf-8?B?Y3Z4bWk1SVd4eVBYRjc3bFVWTStxdG9rN2dZZjdFNFlFQ0FXQnpOVFFlRHlj?=
 =?utf-8?B?RGpxdUFpN05JZ1AwQjVPWmxLaDZlVkNvbENSR0pFd1l3M2ZseHpBN09ZLzRU?=
 =?utf-8?B?dTg5OXJqald1c3EzZ2tSR0R2cGk3Rm5yUFpkSFFHdmt6TEFpSHJwVjdYdE1Q?=
 =?utf-8?B?M0RUYUErc1M0UDB2QTNZUHJaSXJuZHgybmtLZFJkYjFvMmF4UVp4ODNYRzlT?=
 =?utf-8?B?STY2NG5PZXZ2bEVzOURwcm9kWVhBTEVFRWdaWGNSNDRzUlJxNmh0ZVpkdjBT?=
 =?utf-8?B?T3hHbXFpNjZ3R2VrUGU0c3FuUUp1TEJ3bzEreldnYXE5T1M3ZTRvcHBvN1J2?=
 =?utf-8?B?dHZtdXR2UVNnK2R4bVZidGJlNDE5QlV5cGpIVFkvczlXbVhrc1VXNXR5SUpR?=
 =?utf-8?B?ZllVTkErYVlSczBKN1F1a2creFhKWkMxWlVLUU1LMytnMzAyOWViazZVZi9W?=
 =?utf-8?B?Y3lPdzBiOUtRWXJ0SUdDNXFRaGErcUdQWHpPUzA2Zkduc2twVnNDODZsQzNy?=
 =?utf-8?B?Y0M1RGNkdmxvVXFRS0I3TWh5cGhYeVBnZVljMDFlTnpwMEZSRXQwK2UrQWpM?=
 =?utf-8?B?eHBIaW52cWdUbDZFWGhrSWE1Yks5ZW91dlRhT2dKOXF0d3lPS25XUDJTV2JV?=
 =?utf-8?B?N2lyeENnZER3aVROVjNZMkFRcGNhOW83VFpJR1k0OXo5SDdsOEc0L3QxUm9m?=
 =?utf-8?B?Q1RnNDRzUDRuN04yWStTSTlxMmZXMlhHcWJnUUdIdFpSZWNKRzhnUDBIY05p?=
 =?utf-8?B?ZnhCNGtMN3RVL3YzdFY0ZGtvb3dPa0Fka0htRjdXVVFlNW91Y05EU04xVXRY?=
 =?utf-8?B?cFZCSlFKMWtwd082NmJNQmx3OC9mU2lYenprZ0t6TzRHSFJEYlcxOVNsTDJC?=
 =?utf-8?B?em5JemVOdGJBYm5OUExFM3FMRXlwN3ZQZU45MjRjMHpjTldyRS9jQkl0aTdI?=
 =?utf-8?B?cDdSTjZWUXZ4RldLMWFSSVkxdHNzWDl4YzZ1cjhJaUl3cG5JYXdvQ3lUWVgr?=
 =?utf-8?B?U2NsRjg5RExFOWVDUWFxaUlqcUNPOHN5K0tTbEErTStCL09tTjRZWDcrZWh6?=
 =?utf-8?B?VkxtTlJNZ1BlQ1JvS3NmZTRtalN3TTM4ZmVRMjBDZFQ4RXBsMmMxdlJYSStB?=
 =?utf-8?B?czRSRXRieENKeklJN0lnaFU2ZFUzVDVueGVIRXhmRzBaaVhKT2tlRlh4S0Fk?=
 =?utf-8?B?ZWpYTE9ocThRWnhNRGl2Unp0ZUEvSS9DdFprZkZ1WDVmM1FJU1kyWk1Tem56?=
 =?utf-8?B?Zzl4ZkpVUlRCT2ZUV0tFZ2tmbCtKT2pDQVkySFFXS0F2UGpxSHkvUklySllQ?=
 =?utf-8?B?WjROWXMyNTYvZWZqT2o0RzJoSXRDcy9BSkFTUzlOQXpaWFB0MGFpU0phNCtp?=
 =?utf-8?B?THlmTDB1UFllU1VTM25uaUhRQU00bnBWR3ZzMjZPRHluWHBBRzFzVEJUT05r?=
 =?utf-8?B?dVpYWEVKRUZVUFd5WERXZjlxTU5EbW01WjRKSTE0YUpKR3dxMndtR0Z2V2hv?=
 =?utf-8?Q?brAM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJnVnhoaFQ5WFUvcXB6R0wrenRSVURndmhodU5Qei9MdEhQSWc2V0Qya0kw?=
 =?utf-8?B?WVBMcjRnVDBsMmU0dmRyaS9USk9lUW1lUFlnYjRTSlFxdUhDcjAxTzF6NmJV?=
 =?utf-8?B?UHEzTUNkWHdZa0piekhpbHl0emVoVVJJUWx3U0RnTnVqMk12RHdub2FxL2Z2?=
 =?utf-8?B?UUx0bmlleThzMnpyZ3dUUGhIelIwVUxDYjRrN0Q0L1VCejRDcHEzWHAxNjdo?=
 =?utf-8?B?NnNYS1RvQkRPOUlqNzJySTlNaXpzMkRJZnFwTStHSG81VkgzNXI1U2xxT24v?=
 =?utf-8?B?WjNob1BFNnFuaWpUQ1RkM2gvbHVHSVYzRGhVcFpGZ0ZsTnJodWtoNisxM2Ew?=
 =?utf-8?B?NUNxSncwZkp0SEpueWh3OHFuNTVzUDlpYkJVYUMxYmFmTTRNbFdGNjhjY3dR?=
 =?utf-8?B?eTFUZkxYL2xhanN5UzMvWEo4TU05WldLV0xRUzBNSXBVcGo5SVlpelVkdG9y?=
 =?utf-8?B?N2lwNGt0SWFXZlVlV1pMdGVGL2hhQTN0ZHJpcnZFRmd6eEdEMFh4VWRrV2la?=
 =?utf-8?B?Z3BKVWMyVVVRWGdzdkFoazdKYnlmR00xR0lnNWhaVUdrbml0Y25ZbEM3SmtY?=
 =?utf-8?B?c0lpYWJiQXlMQVJBZk9xUG5tNkRFK29rWUpIZk1DWmVISUg0WHZZTmtXY1VO?=
 =?utf-8?B?YTBZQ1hFOTlRSHlVTzN3VjNQTy9za29wdUJvWUk0RDNVVWVIWDJ1T3NCSmNz?=
 =?utf-8?B?YmtaMU5nZU52aERvYXNWcTAxaDFmVVgyQ2lPa0FoOWZGTXJsSjM0dTV0ekZs?=
 =?utf-8?B?TU9tWUtqRmRNc3lnQ2xQM20zRWl5VUZKNXRVWmNobU5xUHZvOGFpWkNZWHgv?=
 =?utf-8?B?Q3QzZldQNWphWi81M1NVMVptNDJudERKalJRSE9pV1JQbFBLUm10ZG5XaHpr?=
 =?utf-8?B?TGR3WGYzd2J3OHRZL1hQUmNVamZScGw0YmdlZkR0T01EZlNNeU5LYk13Ylcv?=
 =?utf-8?B?bVFnd2lWeWpMTVg3aVNuTXV2NVlZQkFqak1aUi9yOGlrZk5sZFNPWHUyUjB1?=
 =?utf-8?B?VjVxd2JrTURURzdNQ1RPL0pjeWNob2dVMDhEYzQwTlBoaCszWVRrWTBiQmMv?=
 =?utf-8?B?SmlCSDFEOFpsTm1rSjQrbU4zbHFwN2U5YXR0bmdKcVd0QmFoczJYUHFUK2Y2?=
 =?utf-8?B?UE93QXJrd0lYdi9VaUVkZmwxM1B2dWkwOVNBMXBKcG5EbDRFUzh5UWhGQmlX?=
 =?utf-8?B?a3drbTJkcHJoNm50RnN6MFo0d1k5eURjeDBKU05XUEgwR2VUelZhQjlseGRt?=
 =?utf-8?B?TFp3T25wTVJSKzBBWkxiaUV5bjRvSXFEK2gyQXVGVXpuNFEvN2dtQ1E3VCtz?=
 =?utf-8?B?QVNwT1J0V0JaaXM5VGFjTEZDMTA2d0JuUjVVakpjKzZ3TmQ2cjRaREFtb3Rr?=
 =?utf-8?B?dlZkdDlQdjhFb3BmZXVnaEhuU3ArNWtOSFF6QmZOVWhhR0dYSTgxTTBhUmk0?=
 =?utf-8?B?L0kvQXBURnc5VFppaFk1eUplM1lqMGJXS3ZBYXlGL3FYRlZYZ3B5V3d1V0kx?=
 =?utf-8?B?Z1NBYUFuc2ErSWNGNFJJYkRzTTZOYitvTFNyLzVwSEFDcGJQSkFXZ3NYN0hs?=
 =?utf-8?B?WU1EMDFwM1VKekc0a3dUdDdGaXJib2xyUStQSlhUZERIVDJSb25hYmIrM25z?=
 =?utf-8?B?QnkxZVRnN2xqUVRveFM1dS9PenBiUTR3bC94VSs0VU5maFQwRm8yVFdxSWxJ?=
 =?utf-8?B?MTJpcjNXTS9Kc0RCZ0REckJwVTdVR3NBWUNMY21PYWRrMXRSODN4VEtRMzcx?=
 =?utf-8?B?a0lRUmFEcENUOHFRSjhHY1BvZzNhT3M4NW8wdmJ1aUZ1U1FzWUNHdHVuTjVT?=
 =?utf-8?B?U0NMbG83Mjk0S0Q5TzRFQnRZS0hpU0pEL1BFRlZ3ZWtacG0rbGNNNE5qWEY3?=
 =?utf-8?B?cE1xYVg3OXZyOUV0bUc4dWtRVXduMXBtSDA0TXVQMlovdDlhKzZxc0ZUZnR5?=
 =?utf-8?B?bVYyZk9xV2NId1A0TlJzWmZoRlJ2T0J0cXQwSk5iWTM3a1ptMEQ3UWpFNFk2?=
 =?utf-8?B?TDJOQUk3Q2FkeUQyUzVLNVhHMGtZeUNlTFk2VGd2QnBEdVpMYWtwb0p2emha?=
 =?utf-8?B?NVkxd1B3UWxOYnJXZ2YzWHhLSlFJQnZBajhIY0xLR3ZWMEd4L2ZKNEFSa1I5?=
 =?utf-8?B?eWJXZUtPVHY3UXZ6bWc5Qm1BcHhYRlB0ZmFUMkJqR1N0WWdqL3RVaHNDcDhT?=
 =?utf-8?B?UzkrR1JwWmdwUU8zcGhibEV1ZVZsbGIyS2JQcjdiRnJoU2F4Y3lZUlFkaGlm?=
 =?utf-8?B?bnhmVk51bE5lVXNyZEZWMWpzV0xsQ1JUU3N6eEZoejBSYVFZZUR6Q3dNbDZH?=
 =?utf-8?B?OWhEWTh0Q2x4aHBWZWdpdjY4NVhadGpaZnMwWEtRdGNqQVN0bzUvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe9e46-8593-466a-263b-08de59b25673
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:32:42.4873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9G1MS2tGIjy4eE4esAJCVgNpCHLoFCqhQZWcAX5Brdwf2vZlaxb/5oTTfkQFiAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694
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

Hi,

On 1/22/26 13:18, Ilias Apalodimas wrote:
> Hi Michal,
> 
> [...]
> 
>>
>>   config EFI_RT_VOLATILE_STORE
>>          bool "Allow variable runtime services in volatile storage (e.g RAM)"
>> -       depends on EFI_VARIABLE_FILE_STORE
>> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> 
> Will this work on nands as well? They got a  much shrter lifetime that
> spi flashes.

I don't think this is valid argument here. Users have options to decide where to 
put them. The same argument can be used for u-boot variables saved in NAND.
Obviously I can update Kconfig option with saying that you should be careful 
about it but it is user choice.

> 
>>          help
>>            When EFI variables are stored on file we don't allow SetVariableRT,
>>            since the OS doesn't know how to write that file. At the same time
> 
> I am not sure we need to allow this for now. At least not until we've
> talked to the efitool maintainers and make sure they will accept
> another 'special' case.

Not a problem for me to disable it for now.

> 
> The problem with allowing this is that if people enable it, boot a
> linux and do a setvariable, it will return a success. But none of the
> variables will be preserved after a reboot unless someone manually
> updates the serial flash contents. In theory, we can preserve the
> driver  model and the spi drivers in EFI runtime services and allow
> 'proper' setvariable at runtime.

Wasn't this the same case for file based one? I mean u-boot had it but efi

Yours efivar patch was merged Jun 23, 2025
But this symbol was introduce in U-Boot April 18, 2024.


> However, I think this is not very useful. Having an unprotected to
> store authenticated EFI variables, is dangerous. Someone can erase the
> SPI flash and efectively disable secure boot. Due to that, I prefer
> the current file based approach for EFI variables -- which doesn't
> store/restore authenticated EFI variables (and which this patch
> implements). The obvious downside is that enable setvariable at
> runtime is tricky once again....

Isn't the same happening with file store too?

 From implementation perspective it should be the same as file based. Obviously 
efivar part is missing.

> 
> [...]
> 
>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
>> index be670a8e7c25..feab212b245b 100644
>> --- a/lib/efi_loader/efi_variable.c
>> +++ b/lib/efi_loader/efi_variable.c
>> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>>                  ret = EFI_SUCCESS;
>>
>>          /*
>> -        * Write non-volatile EFI variables to file
>> +        * Write non-volatile EFI variables to file or SPI Flash
>>           * TODO: check if a value change has occured to avoid superfluous writes
>>           */
>>          if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> 
> Do we need the ifdefery here? efi_variable.o is basically compiled
> whenever we have the variables managed by the non-secure world and
> this function will exist either with a file back storage or a SPI
> flash

It can be reverted and return EFI_NOT_READY for EFI_VARIABLE_NO_STORE.

Thanks,
Michal
