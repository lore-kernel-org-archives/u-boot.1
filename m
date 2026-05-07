Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6099ECD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2749846B1;
	Thu,  7 May 2026 18:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iw/N5P6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF1784A09; Thu,  7 May 2026 18:31:58 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5288467E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd2GeqBsCV5nYnp48R92aJ9rFbP55iQ2obLkbk2+e9hnUFveJySEKsYY2jvYHZibbyBtp9mCLOh5QRMpxuu0N5h8o3DuyxIKfa163NSzDBYxq5/a7n/lxeFUvGdQb/2O5/H5IuZt3OItoNA7sU0eeWb6HPv0V+Yjm+21Jj3km+oCR+woSoR5WJvLSrI4vWgDp9pUynd5LQHj9QuVVwhhMbWHG4mDSq0avargOHOoL5Amz9IuGYA1dGpveFqH91Eknta8RZ8N6Mu2C2uDQqTpDsZmsBjpcJxPO7HzMtjyE5mBcdVeR+iQAua9NL7M2cPPBInspHiYkRPaz5t8eYPmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWEKvB9FcI4m3E7JczNUjPd0Hc8OKaPtiM3IQ1aEtw4=;
 b=aDmiGqQnJ5b2saEq7QqlW0LMc0aHE0dyj5uosKmituECGHshLWIiR+sw6dbkfleWPvVULimYygPu3CgQg+QVOUo+MygdEYbmV6Bu8uxME9jpAS9Rnf6jtIb/ZYgVK9Ub4dcKAtjZo1wwr5T9MkM1NNnGHWcMo+0yfrNtWzRCQ9ykPH8Q0KsZICdpGi/yq/Ffz7k0njLoDJTGGaCN/YU9xYkPU2n9n5TLcsxKfvZbUQmjTOim+jb1MuodRAj0+Lof+JK3XhvlL44T+YjUg7eVQcM856TD/jQtuHz9DnTEa0rx2ZwQVkIQb6He64qLQtuOU5RfFu/820MXPWcC0WkB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWEKvB9FcI4m3E7JczNUjPd0Hc8OKaPtiM3IQ1aEtw4=;
 b=iw/N5P6cSFIKiz69zfl7Nuh+WSYVWaBG4AEuL0LHdniobYWox24J5wi7wdCVFtdc0lq+nWd336sens04I5bgIY+ftHX8zKo47zSBUlJ8+j1qdcdXbloe/Y1lIUUvjbUzCPjVvVhNW2QjZXBqdLB/922lZ2ZeBBLyg13dyi7m6Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9281.eurprd04.prod.outlook.com (2603:10a6:10:36f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:31:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:31:52 +0000
Message-ID: <4a851b71-2502-4f6c-ba6f-f6def01762fd@cherry.de>
Date: Thu, 7 May 2026 18:31:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bitops: Guard GENMASK and GENMASK_ULL against prior
 defines
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260430113937.1274693-1-sjg@chromium.org>
 <20260430113937.1274693-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430113937.1274693-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0272.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::39) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 93924f86-72f9-4e5b-1f70-08deac56252b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: e+iFFAJTnMQp0ywtynkpkMLYXOaXCT5O8EokA6VX9+lT7+aweiUbQCLfj0QBQ8wLgV4QjOs6RsT4q+5xucQBi02f1mLI6YT/BnBIfGDr4jUz1EvN3JnKqziSS67Y0G+IhlGJ78ktbZ0VWyLQTc9EcByMtXFKgwJ/cjCLhQvq0QFTkCT8Rkj/pxY/bHYk5bvDDl+v0BKUbvPNBD3j78jXd3feZzf3o0wZ1U1/YwO+bMu64iTAaTKxHw0dqPv67yY+FjPmMkD2DSZWWIapwP/ipjynl4nYRBdKjIQJSC/pNKoi2ZrKj4kRBjcp3B9EUI+ExJYsnFlBGz7tr4j45xhG3bmYGWL2sX9nEIFv4ZjgUD5gLy43N/Tz7M07kUOJcAkv7zJwFp/xUKff6bKqlK5f3lnZ7eziotm3BgAsTIMQRWul2r+1EzMoAcvFjpH3lECNPTljVbGsKxgw0HlUsRGPySRRRa0ZzSOLgNRGFkgV/TcJ59vwRPsH9WpgP4U/Um0U43hd3urohV05H0vvCZs3iNRIW+UV5n9QvWz/WC6NEoUinS4Xolm3hVIhhp1/9j7R129gqakEgU/45yni9hAc3AyB0Swl1n/pKGeGpFNDEnjpt8SxaeOEPTs/ACJ5XiCt0vEZvrcl4/uiFlAl6I/B6NefL4zBZ7eRl1n1lnhTPhVGml8ZPOANVfz85c2Up26Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdaU0tQVkZydS9LOVhDSWxuUWl2aEFKc3V6eHRwMnA0S2pmVjREcHREZ0NP?=
 =?utf-8?B?RUVYR0xJVGF3NFlXQkdaVEdrazBjZUo0dUJhRndZN2N1NWtCYmNqcmsrY28y?=
 =?utf-8?B?dFY5OXY4cndBQmlRMCs0cWVCbGd2T0FNUDVqU1E2YlgrVHJDYW1OQ3Y5aUtU?=
 =?utf-8?B?WCtIZkFiUTZrZTRZd3ZYdHJSUE1jU1ZMeHU5SXpGNzdNcGhzR1IzRy9JVGw4?=
 =?utf-8?B?OUJFL0NGYy9BRkhqeFNjTkRCbjdxS2d0ZmdqaTAyMTdwS2oxNzFqaHAzc0JF?=
 =?utf-8?B?azFjMm1FZ2NKWlg5WklrZ0NtUFdSOGl5N2VRNFhLNEQ3emo4OE9yb2Y0cmFD?=
 =?utf-8?B?TGkzQmRUSWQxZURxa3lGTnNhUU5VdzcwUXhtM0lZSGlmTDViYUVmb3paTkN1?=
 =?utf-8?B?VkRPcFA2ZGp2UWtNR0FuVTlLaDY0QytFWDVhSkpzRHRKQ2RqdXlabVhxYkZD?=
 =?utf-8?B?MTRmeDN5emFpRUtFUDVRcWl1UDVCSElvcGVCckJLaTlZR3NzeHRxZHNDdmNq?=
 =?utf-8?B?VEdyR0o1dVRETXFTc0pEOEpyR29uSityWGxrNlJscGlieXI2OFdZcEwwV3Uy?=
 =?utf-8?B?TjNQVXVRKysxSjlZTU04alBTQUdSQTVUdC9sL2pJL1pFL2M0WjIxUDNUVXo3?=
 =?utf-8?B?eTE3Yk4zS3RGNHVDT1FIM2hOM2dNYm92U29FMU5tdHdFbDN3Y1BhQ3ZiNHdP?=
 =?utf-8?B?ZG1saStadWMzQnhsRm9qYmV1K2Q1enRRVWJqU2RzQ1daajZiSzBzL0ZiN1pj?=
 =?utf-8?B?eFdXSFFWNTlXL2FWbkFwS1Zlc1Qrb3VjRjM0aklKcS9qUkk5OVkrdFB3UW1R?=
 =?utf-8?B?Z0U4YnNZNGFneU1DRm1IS3FzamdkQThHazMyY2tEMVRPTjZZa3h6UzRHMDBo?=
 =?utf-8?B?cDRQREtYWHo1NW96YVlwdGpjK1NhSjlXS2ZOSkkxNy9pZ29FZXRGVkRYeVlC?=
 =?utf-8?B?TS9WWk5VL2RPU2diWWdJWEVsV3RkMHVNdU9hc3gyTlRFdVFrTnFLMEZLSkJz?=
 =?utf-8?B?OWR1ODgveTMxRFVDNzNycENVa0x0N0IzRTdRRHZSRFpHcHIxYW83ZEVGalp5?=
 =?utf-8?B?U05pd2tKaFFsOVBvK2FhYit2WXFRcm50N1BQRU1yVTZqTW92MFRlN01wVXEr?=
 =?utf-8?B?c0JwVTVQVzZDMWx3NVZtRGNXc29BY3J4R3ZQSkgwNUJJZUkwWFZRaFNGTVNQ?=
 =?utf-8?B?d3ZqbTh3TVRZdmdPN2t5aE0wdW1DUmVPOUlmZGc3MklOTEVpTHZCQ05UTDM0?=
 =?utf-8?B?bUNwdEVJNldNdDZvVVBNY1Z5bTRUOWRMajZJK29UYWhHS1p2bktvdjFjZzAr?=
 =?utf-8?B?UE8wK2NqazJjVXU2blFMd080bFh3clMwSGkwTTZ0U25zdWZIc1AwNE1vazZw?=
 =?utf-8?B?V3F2U0Q4Q0szVFZtM0NYQktJRG1RRXl1bmxoK2poWkZ6U29pVjZVVW9sbjh2?=
 =?utf-8?B?TTZ1ZjFyUlNvNkZLWDBLUGZ4NWx4Y0pXUXpoREgxVmwzakV0MGxHL2JudWtL?=
 =?utf-8?B?MnZwQnFVTGE3TmNKTEU3ZlEyNW1SZVVSQVNHbVdTa3dVaHk5THpYUGY3RDNq?=
 =?utf-8?B?dVA0N09IT2hmaXN3Ni9DeHprZDBWVVJtb2VORjhxajhNU1NNNnhQLzBYTG1p?=
 =?utf-8?B?czk4THA4L3BMY21hVjg2eDZoZWlIQWl5Y1Zab2RkOW12U0JmTnRpN1U1OC9Y?=
 =?utf-8?B?cDNnSm1ZTi9iLy8rOGlIM05WV1pzbTVvenc1N25Sd01ZZTdTY21Ca1JEWmZU?=
 =?utf-8?B?MERaUmNianZWZ1QraWxtZ2Q0UytHU3NzUC9FRUZpOEpwNCtFeUlVRC81cEVX?=
 =?utf-8?B?cXZrYWFJTmwyT295bWhibUxaQ3FsTlpYT21HVnF1Slh3M3k1RGtpeVFsMkNj?=
 =?utf-8?B?ZEo2UnZQcWVhNEZNaU41VFdyUG5mVm9qc2JESVMrUXhGaEd5NksyM1NtZUpF?=
 =?utf-8?B?S3IvNkJXcU9BTTNuUEpTa3BCMWFvMHVkY24xN3BFbW5SRjNrbWJ0YVpIWXV3?=
 =?utf-8?B?YVg2TkEzWUN0TWdUYk5abEUwZFByRW1xMXc1Wm91c3dQT0diR1dGR09tRkhx?=
 =?utf-8?B?Y0t0VXFEODRmLzVpbm1WN3FVSG9qTTYrK3NmM1dYQ0g0SFYrSGg0aG5kdFk3?=
 =?utf-8?B?dkVxcnZEeUhmd1d5VCtFUDRFSEY5OXFBbGFCanFpVXkxaVNoS3FEclVPaWph?=
 =?utf-8?B?S1dYZHhISFQ5bC9hWGNUNjlBV1U2bjhmNDhQQ1Bsb1E2dHphR041a1ZTWVFJ?=
 =?utf-8?B?UkMrL0pkd1pRdlZYdVNlWjQ5d3JJM01hc25NU3J1OVNvK2FhV1RUY2VxU1ZC?=
 =?utf-8?B?UTRyQU9Bbmp5WmdobGl3YldrN3FPbTRwMndKYmJYN2tJMTZxTWt2QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 93924f86-72f9-4e5b-1f70-08deac56252b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:31:52.5081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5rkhFoGaVeVGWHMIM4YAg85tqRoPeKOnX97LprFEC3/T6lIumkAsaVUB/ocnQb2KfcPVWTCfjXkJzy1CTQ9MAGG2lxqHyMVMmngDw1PZn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9281
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

Hi Simon,

Thanks for doing that! Did you run this in our GitLab CI by any chance?

I'm a bit wary of the sandbox implementation since it isn't actually 
interacting with an EC, but at least *some* test being run in CI would 
be nice :)

On 4/30/26 1:38 PM, Simon Glass wrote:
> Some headers - notably the ec_commands.h synced from upstream
> Chrome OS EC - define GENMASK and GENMASK_ULL themselves before
> linux/bitops.h is pulled in. The unguarded definitions here then trigger
> a 'redefined' warning at the second site, even though both spellings
> produce the same mask.
> 
> Wrap the two macros in '#ifndef' guards so a pre-existing definition
> wins. The U-Boot expressions are unchanged.
> 

Considering how often we may sync cros_ec compared to 
include/linux/bitops.h, I'm tempted to patch cros_ec instead and leave 
include/linux/bitops.h alone.

I'll comment in the next patch what I think may be enough.

Cheers,
Quentin
