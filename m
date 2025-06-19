Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AB3C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A0A82CBB;
	Thu, 19 Jun 2025 18:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EnbIUJbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCF682CD5; Thu, 19 Jun 2025 18:40:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7324882C65
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTRJlVv1gGp2Bk0wRc5lznFi2AleXpAWJBmPD78S0C0OsSe6sK6/ip8c3giwPn2eqgywD+BgiRkboaVO+DW4YxCB1oMyfFxibhzbRDhQruPLGu+0DBGy05nPDBAoJVejyywDiTBHQqGLzsZbJt/IaU2WcZBs5zmjgtx2RVWKDqY4jvBepPFdbzIOGXOc6uloKDi3BDP5RiLRfwT35ObA2frsgG+YXfba3OCDHKFluP7OZY3S8EAIT3NXoWu+229UnPJn/8/3MgGsjdxtcnOhWujRtL2y8FxlUOA3/hrVuCwzTKnggm6ewJJktrzgszsoTzp0jPb9n2wiaBPQH7uQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncxJA8Pe+q/3bDKfoX27AipUMy4Oqo5d5KEXH21R5NM=;
 b=tHx27kFukGREcIqMlrlUs5j+SiTEOUS6x/rE2FJuuW4Rl8YXjQjHHjd1EDicJbDLvHeb87NY0UBI3z01qPLL/fa38T/Ke75OsA2YadXKcqGHUrBQ5GLO2y1ky9BoxZakJqeNQB9aiUW1RQcyMyFHInSJSUvZ2ftccqFEPVXCoMsW4EONQjfz/QKYZzLKVzzr5TTIyCyO+ZdKsUBpvmKi7dTz7ccajoKTGLc4cc1F4UL3KT5+KKmNzvsozP7khudtaraP4E8xBEFk/7uyxHukV3tQuF4yQrRHeFICerGQMtnoEqXQyTmPpEJlDZnv4YUexS287L8hahCHLsS5lxUJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncxJA8Pe+q/3bDKfoX27AipUMy4Oqo5d5KEXH21R5NM=;
 b=EnbIUJbGg1LPtWpUprbhNSv6rLCK6hTOFzJr2XrLLIROG0rkwdPMU8SXEl8y6ZWtJMj3uaa7zLc+WfcBYkDko787KmxR7/VG29l4Vv0G+84/ytUKwu2AWP5pbHLVm/vIW/aGk9S1S8x1GSykWHANyv0fIi5TKbKgxZU08dW8i8MJT3tg6bsYo0tx8JK62+xyrAzk2Ypd42wgYsfYATdDCSuKsNxEV0KHYfssvlnJSzb5ga2snLDCaHSYO9kwObuxig30x7L2G4UjyQVFchBCzoDZiyeejIbnnbbTL5RQIMQCHbATSBz8MF+k4+XruYrxpflvceZ93XFhAac97kBJ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 16:40:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 16:40:34 +0000
Message-ID: <a26bb42e-e1c4-4a17-b5a3-fcc217102b59@iopsys.eu>
Date: Thu, 19 Jun 2025 19:40:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drivers/net/airoha_eth: fixes
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9758e9c8-5f4d-4084-76f3-08ddaf500312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0JCNW5oTjdUT0ZDN3JzV3dRb0sxQnNvSE1Kd0FnZy9IZHVXYnlYejBFMmZy?=
 =?utf-8?B?bWlLS1BBb3NYYUtMRlI3MWRtcEl2ZDJxU1AxMW02ZnFhKzAzSDFIT2dxVk9h?=
 =?utf-8?B?Y0NGdThWMHhkdldwc0pVNXJwYSsxRC9FVEtNYjRmL1VoTi9TQ2g0Rk5BV1Yz?=
 =?utf-8?B?S2xEcmdGRFlFNGtad09qQ3hnQjhDOUZMbkhNWnlFczgxNGJ0emowNjl5dHJq?=
 =?utf-8?B?UzNTUnE0dUJremp5eUdQcWx0dEZTTGh5bTNyS3JCYU9LOXFBZm12T1pCZDFL?=
 =?utf-8?B?WmNWOWhDQUk3NUk2cVFoSTZaaXZRL3FpRE9DejkrWVYweEhRWmdITkxVcTJl?=
 =?utf-8?B?eHlEQ21UZEJhQ2VlbjlRK3RSRVdOWFdDa1k3NVZRdmVBQk1DeHhZNEFwWDFD?=
 =?utf-8?B?NUQrRUtyYlA4dlVRVGNFNWUrcklvRzk5N1l3SHhIZEY1eHRGcGtkR3ZESU9O?=
 =?utf-8?B?ci96RDRELzd4NHhrbm9CS1hVQlozclBabStpYVg2eXZaTEYwYmxPdHFGWTBS?=
 =?utf-8?B?ZkZDL1p0VzRhT2hvVVVQck11L3hKVVN5QkNLSVE4d2ZrekZuNW1HMGw4ajlo?=
 =?utf-8?B?SmJHN3VQU3ZIU3dYeFdQcVdxbm9JS2tNYnQwdHk3QmJMUy9WYjBHbGsrdWl1?=
 =?utf-8?B?V3ZYcit5MFh3ci91bWR1WjN0YlFFR2hOWUpFbWhneGFmL3JOU3pINWRJb3hJ?=
 =?utf-8?B?Nmk1RG13OGtNOXVMRTB1VGp1RGtRUGJzbDRqcDRhM1FueU5KcGczckNlcWtE?=
 =?utf-8?B?ZUhTaGlzUkMvMG1lUnQyWHJ0cCtPN1h2bkF5alNIU2Q3M1pJSXlxbnBXdkEw?=
 =?utf-8?B?ejZ0Z2VBQ2lIdGduVjdzN29SNU94c2x1VFRabWpFZjR6NlJWRnU0K3ZWa09P?=
 =?utf-8?B?L21HVHU5aWtSa1VlQ0xIMVV0TXlZN3J5WDZQbGhDOHNTakwzUUFZV0xYOXhz?=
 =?utf-8?B?Q0tJWlkzNDFlMUZtMExTNm53T3pOMkpjdk5XdWtieFdXK0xzMkxCL2w4Y2pl?=
 =?utf-8?B?RUwydTNxL1VPenBxNHhCeVh5OGE5TmR4aEFYczNqWWhFSm1xMjFIblkvWENo?=
 =?utf-8?B?cUpybWVQZlVJajZrVGp0T3YxV09aS3k0M2xJcVU3MFNsWFNKVkN5d1lndnZt?=
 =?utf-8?B?S3lyTXZlUUdTc3R2dXA0N1g0RVh0T2cyay8yOHIzTUR1K0dML2d4YTNORGVP?=
 =?utf-8?B?bUVTRmZiYms0T0pib3BmTlViS1c3ZXhvSE9zN3JjSkRvS1k5UHJLVmc2Tmhr?=
 =?utf-8?B?L1ZXelNxTCtLT0k5ci9IVlZWdVA2U2RzZXZWSjl4NC8vbHBHSk56SVZZWk1h?=
 =?utf-8?B?eWxFb0F1RXR2eXZqVXR2OHVYV253QUFNQ1BFWWJHb1FhYURMMCsva05DZlBT?=
 =?utf-8?B?dVVXV3Vpc3ZJQnJ2RDB6R3VKUHJ4VFpnQ215eGppZ0YrKzQxaGxmc3l4UkQr?=
 =?utf-8?B?MTRxQjFtOW15REZ2SEpzdHh4clBCNms0QVQ2c25kUm5CcDR6SVVVS2dSSDI0?=
 =?utf-8?B?SkhKMStucE5uYWw0bzdNbDVaeDlaZjg2Nzd3T1ZuZmJ1RkxpQWF1c2xFQWhD?=
 =?utf-8?B?blM5djBLVHprNmw5TFZURHFsMHE1eWIyT25RK3JLVTZWWlE1QjdSSEhQQUo4?=
 =?utf-8?B?UzdiUytPNjN6bnZ6NDhnckoxRW93OVAwRU9BZ2Z1Q2drdHplWVRkYTd0NEV6?=
 =?utf-8?B?UnU1VUVIdmtFaFpXT3M4K2VuSTFwUTdWZ1U3OU5UNFhFZU4rQ1BDTUQzR2hp?=
 =?utf-8?B?MHZLRmFKQk05eGZBT0dKcWIxOTB2VGxvMU1WWDE4ajUvaW4wQm9RazE4VTFG?=
 =?utf-8?B?Yk41Z0luc1hNODlPWjI3d0REakl6WndROVVkMWptbFVHQlcvWnBWQnA0WTV0?=
 =?utf-8?B?VkVhc2kxK3dqMmN0UWxQa0FST2kxekdmclZvdHNtUjJRRkpDZ2xZaUYzd1pQ?=
 =?utf-8?Q?i5jzwSU/Aic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRZTmYwcWVyRXZxNmlZU3U2MHAzcDkwK0J3VFFpdG1zWTV6amhPbGNqOTBC?=
 =?utf-8?B?SDNSRWxhUElmdWJYSjI2MFRuMWVOUUhOeWl1WUVzdWIrT3Y3M0EydENGM25w?=
 =?utf-8?B?MmlLT0pwVE81RmZtN0tlelIxK1A2UmNJTDd0S3AxZFUvRUhJckxjSFhXckNt?=
 =?utf-8?B?bG5VaE5wWGVPL2dsOFlDRXpITWFZaldLTFdSVS8vNmlMeEZsd2pNalgxdU1q?=
 =?utf-8?B?aXlCWFg0dGViS0tsY1NuSENVSnVqV3phc1BoNXhZb2Y3a0hObGJTYmErSTQr?=
 =?utf-8?B?b05NSXJUVm8vWWIvcTlSaStqTEs5STBvaXE4bVE3Uy9jWC9LWmJQeHBLSlVG?=
 =?utf-8?B?aWtiV3BDVXhOL1FodUhjVmxJSFZJWEh5WnZoazVFKzBnclVmYVNPWXQzS0JO?=
 =?utf-8?B?a2Y3SWpFRCsvbkdTZ25kN2JZV21YTitJZ0IwalJyNTJ0Q1ZHZzk2Z3R2MTJX?=
 =?utf-8?B?Ui9PSHhhcHJVRmM2QnRuY2p2YnlwNHcvL3d5b2pFaFhwTlZpd2E2eUdBUi8z?=
 =?utf-8?B?V0pQYlJHR0VxS1NmWDl5MEdsN1gvNlk1YXQ4YTlJc1FzZVF5dlN5M1ZTRksx?=
 =?utf-8?B?Z0pDcmN5R3ZyaWpnQzkreG5TSGptSW4xbzdEb0l4OFRLUGx6Y2lnQW9CSlRz?=
 =?utf-8?B?TEZlOUhMUDMwUGxjbG14WElGZmdqanNkTXlvTTYxcVRFQ216TXFSRVZUcUpS?=
 =?utf-8?B?MlRaWVUwMndxdnI0T2FZVkNxYmlrZEkzeEd4dnJqNVhMSmxad3RjdXdTdFVD?=
 =?utf-8?B?L1VHZjR0UWgrVXVKbmxuOGV4K0ZjNzJtZ0wvK1diakMzelQ2b0xuREF1UDZq?=
 =?utf-8?B?RmR3Z2ErejllZW1qeDVqZHgydFVCank1bi9LOHUwa3hxRWkrL3VBb2VBbGVp?=
 =?utf-8?B?RlBBOEtyK1h0aHhrWldOWEJWMHpKZG1KeFNrL3JENUlLd2pERWprSWlTM0Nm?=
 =?utf-8?B?MldMV0U0MklYTWxOaUU4TUNiVDlaV2FIb215bzVMZU9lMjNEUHVocGlwUWxp?=
 =?utf-8?B?aHVMZkZIQjZ5WC9TMnByVHRjNEE5MDVXalZpdXFqcXNmaURpU0JZYTJ3R2FO?=
 =?utf-8?B?bHJRdm85Q0lNYytLb1A1QkhGZnNBUnFBcmY0Uk85bkN0L3JXQWVsZkhqaEkw?=
 =?utf-8?B?ZEc1dWRYVXBoanV5dDkvQytKNDJSTWFDVDV2VG04VS9jT3BEdmdYQVdwM1Ew?=
 =?utf-8?B?bm1FWE5iN2gxSVFWMDBEQlByTCtvMmFmZW5NVzZabnE5a3VtTHNiMFp5dWZI?=
 =?utf-8?B?YmtFK0tIckx3VkpZNTJqZ041TUphUktqbWR3a1lPenZHYTgxaXAyU1hNODdS?=
 =?utf-8?B?eFFBam9hMFlpTjc3SGwvUVRYVkwwU0xYVXZFMHBxUHZ1cGpjWlRNVVUzVXVo?=
 =?utf-8?B?Skw3NEpPODNhYmRkMWticktzem1NTjcwdUpJRkl4L3JLaEtHSGtLRzcvd21j?=
 =?utf-8?B?RzRqVGJOTDF4YStXZGpna2x2eFZQSkNmeFFGbElSMU5yaW0yWkpEanJOeTJN?=
 =?utf-8?B?UEJsbit5R3F6TkIxRWVrOHhwV01Ub3hvY1k0UG4yN2lWcjcrNzJQVTVoUkFR?=
 =?utf-8?B?V1lNdjI2VjFqczJkRlk2bm45dWtkZktndlVydXM4ell3SmE1OVFyYkliWmY5?=
 =?utf-8?B?aGJyS1Bxa3J6V2tha3V4U01UbnNkU3dSNFdrQURxOE4yUjhtSmwwVFlzM1Bp?=
 =?utf-8?B?OEtDQzBySG5xTEplWURTbzdsN1N5UHVWdktsOHVPZTc2TzB6UVpNcStJSnVj?=
 =?utf-8?B?ZG9jM2M2NDNNRTNlbUl5a3I3OG1YTDdkeEFXM2EwWlNPZ2tzWG1GYUIwNHFu?=
 =?utf-8?B?bFRnZngxdE54VHQ0M3N4RmVpMEZ2SDJEbXQ2UnRzOUtWc0w4WDd0alVhL1Bl?=
 =?utf-8?B?L2ZKdzdmWlpsRHJGem1kdGRoOEJDa1FETnc2TjNHemNWYlc3TnduWnlIajJT?=
 =?utf-8?B?eUFNbm41WTZhMFhpcG5uSW1IYmlsV2xEQWN2Z2o3cTFWK1VCajRPdDRZbGU4?=
 =?utf-8?B?ejkwaEYzcUZreFRqbC9TeEUxZWRuUnhBb2Q2NE1vZXE2Z3lpSHFxUk1rSjF6?=
 =?utf-8?B?NlVRZUdUaC9MMTVIZ1dGcXg5OTYvOER0M0FsbThPaFlrQWo0a3hQYThZckhn?=
 =?utf-8?B?cnEwMFFEcVBNc3ZabDl2cGpwb2lKU0M0amZWT0NObUU3b1I3RGxPVTdKbjFw?=
 =?utf-8?Q?TU6fe4LBzNIvbPDSDHPZltk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9758e9c8-5f4d-4084-76f3-08ddaf500312
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:40:34.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THvgEea3gqqH4/eI78W27NC7GPlL1oL1ha0qBM3l2zXco57NvsmLDedBcnFM7LT91GaEOSU3jUTCWLO4r7Th25DGzuKhpAIAqPpmou/kn1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
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

Christian, is there any news?

On 10.06.2025 10:29, Mikhail Kshevetskiy wrote:
> several fixes for airoha ethernet driver
>
> Changes v2:
>  * update patches description
>  * improve formatting a bit
>
> Changes v3:
>  * national letters were replaced with the corresponding english letters
>  * code was tested on 32-bit and 64-bit airoha boards both
>
> Mikhail Kshevetskiy (3):
>   drivers/net/airoha_eth: add missing terminator for compatible devices
>     list
>   drivers/net/airoha_eth: fix packet transmission errors
>   drivers/net/airoha_eth: fix stalling in package receiving
>
>  drivers/net/airoha_eth.c | 69 +++++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 15 deletions(-)
>
