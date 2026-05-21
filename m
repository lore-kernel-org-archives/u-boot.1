Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862EACD5BA4
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 09:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0211E8341A;
	Thu, 21 May 2026 11:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BkSX8wUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301B7843B6; Thu, 21 May 2026 11:12:41 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C369805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSQkg254MJFmxSkTcEBfn9Pzi6jjbVGOR2jqR3OWSZXzWPzgnnmaWrTvyf3vyy4YWFJxU5TBlwe233Puz8p0QG3NXjILkOGOUDppd24CoT4bEZwU/GOSOyA08YLdseRoFZDjOhgDalawJ6WbtCzmV2TnwYzeJ9AM/3M6pqeFrEpjwocNCEi201mE/2AizI5fp3Q/hvZs4eiocEMvcGBvOOPu59E1gFUDXRBfODBnRi84SrLxLTp9Rd7TJE6l9EHcXBGgU/B8Jwjmxedpb5NagKNJzy1RdbSdeWrmaCEzQNKvQMYWcLjiYT+zjw2h1HxESzgTIcwOkcH5OyP04Zek6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv7bSlyGAGMeA8HtihtvJE5mft2+1PY7akfiyKbWYi8=;
 b=frPOiMrSdhk+1GcYj7F7CU9LnDmLmUMQAENKm20d3nWZWoQlwqu/NL/QjxgBoXtIRNpnpfOskQ7DuqwfeVj7qZxogQNyFn62zEK48g3CKG6HeFu7786ZJ4Fhcy6alHvwMBWkxx8IIcKxF2mSGqxnUB1WIK/IQ+2iTzQJDcbr2R4uQ+/X4gwabwN9fAINbOS/GsyGzXhCnr33BwXm6MuHmXpsMHKxoXvgSLMgIPx8yPbIusXiDOmEG+ts6GbNIOGwB7aH44wfuR7xsMf+AXempZUtGiim5YxlZGQj92kZWGy4qesMjs57yEUAY/YGszebMpqEOMtSvmNdtYvV6Wwniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv7bSlyGAGMeA8HtihtvJE5mft2+1PY7akfiyKbWYi8=;
 b=BkSX8wUzF/6Sm2A3ylV3vNFr8SPvU0eWWFVD0qk6ibOGpksoIzrmglD4/tdGnuHDw6x3TiKnIFUhbv2J6SqsYN2VMNDTHOFpxtkKgzXGRVXRWM8qC0WWNGSKcCljuT6Jg+phBNsu0LIPvT0ELuXMgvwtalyWDSvAsdIVf63PetY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11388.eurprd04.prod.outlook.com (2603:10a6:10:5ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 09:12:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:12:37 +0000
Message-ID: <6e64c6df-e66f-45e2-9214-baa02df9bc1c@cherry.de>
Date: Thu, 21 May 2026 11:12:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260521023503.29315-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::21) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11388:EE_
X-MS-Office365-Filtering-Correlation-Id: 39df39bb-edd5-4c98-e8bf-08deb7191a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 3kvSGVWQ6qrl57Mu/y4LpLPHna+K7RIoBZOTbG7UsXJtOSjzqqQ+L//FheAyWzXjG2CIakuTtwUD2MTKtxeAFGnV2vVouZun00nmPCzCjGm9AsTlt7YQHM/WeE2cyFNoYr7QSluID7OeuLuBuDWLg1rNkISjU5EW1vbw9I3KnvQR/NPSnCu1wDwgK88Nj7EC/r1NWSMwpqZJNlnYq2Ph0jAY/w9KytUrR8FxQHchFgs3bOP+bpzJ7B3zIyGHGQP8aKCLwu4lOAliczUK2hMvKi1aP3NVwLblvaOQlT+eEDP8HKm4FLXxp4gVjKwtoLRbkciCf+MzMDC5tceCan8BZrC7XHdZykRL6jgkwgFyVUYyA/P8QBIBG15qNtY8MIZWyCLtYYSFDgrC10uU5U//pgGsVMVZ1G2JE7njAr6EyedZ4qxrfB6ncHw7KnlA+7Yo36FK6rhf0ft7rpKKiBN7oMcuzojl65YIOqeABepE/6D49gTWO9ENJIr5qGQe3BAE8B8MxYCBXllyQOf1bjHrhH0npKvjNLoQd6kLPQfYbbCGY23I7uTM6k9o/o0ZPVVxzY7AY/Xh6kc06BfbiGtkr5qqsudYLkBjeLYUH37tWUXEmuRXac2PNInUXmgT+RNi2usFziB3EExfvVTU0VwYygEFGnDn82hoJVboQJ+5HyNYbrcx35C4Vzl/hy/5ht9I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JFeDZieXdFZWVBNnloVmN5Zkh3eFhUcEZqbVJaLzhka2RGZnVKaHg2UUJM?=
 =?utf-8?B?TzRuYnRnZEpDQXpyOFQ5R0RvbVJaOXpyK0tMejFDRW0xOS9TeFlOZDdnYm5D?=
 =?utf-8?B?OTVMRzcrZWlLMitlbXB5a1NJOG9KRjYyckJ5N2F4VzF2UnNnZGplZ0hmTXJi?=
 =?utf-8?B?cVArM2NZZVZxWGoySXUvektGVlExYmJTTkZmano1SWJQSm84VGRuNlRhNHNw?=
 =?utf-8?B?QkM2YXJTV1phTUFFSEtuaVlwUEZDcU1reVVtM0VDV2FVeFBRZGtXeTFUQW4x?=
 =?utf-8?B?UmIyVFNjZDFSaU4yUm9lcStBcnFUek9ETWhVK1dFTVN3Z2NURUFyV0dBWnV4?=
 =?utf-8?B?TFU0dUpYaEUvTk9xeTN0dmNFYnBXOGtGQzZJMEdpQ214WTFMM3VmdWhzWjJW?=
 =?utf-8?B?aVFmRUVKcVhZd2hFR0RRbHc4TWhxT0QyZnJCUGUxU2lNaUgrY2JYL3VIUzVZ?=
 =?utf-8?B?eld5cUxWTlJQNVNZZ3RrQ3k4S3lTUnRFekt3eHFrb3RxelJMRXZoc3lxRUNM?=
 =?utf-8?B?aFpaQlhKMVlGWWUyaW1qRElsMHhDeDlRVVZIWVdJbEpPN0J4S2d1eGg1WUhv?=
 =?utf-8?B?ZndjM09Rd0lRNXBuSkQ5YncrQ0pMU05tTEtTeHpCWE5YOVZ0c2YwMmkzMDl4?=
 =?utf-8?B?eDlwSmFmakJqQmNtMzhHNmJOR0tZZjBnUENqNncvU2VlelpFYnNvcGZlcW1z?=
 =?utf-8?B?R0hpeUs3THlxVFpXc241ZWR3Nm1Wd0hJV3FzVmhRM3hQeXFWQ0U3Z09hSnU2?=
 =?utf-8?B?UUNiUUF6VHFTaTRpQ3FOV1NqajJFWnY4ODdXZldERDdwa3pRRTM0U3RTMzVI?=
 =?utf-8?B?ei8zVFE2ZGF4dmpWV0hMZDFqN3ZTdExVVGs3MFlCVEJkSnh5Vkk2WVJXSTY2?=
 =?utf-8?B?QlZDT0l2TkhQam95ODE1dzIrQWRRb3E4bDBRQzJvbTl2Z3RQeHBmeSthaXVI?=
 =?utf-8?B?eHZDdzRsK0tDTjk5bzNVSjR2dm0vQ3FZcnA3Uzg2VkEyR3lyWGs4K0xzeEZh?=
 =?utf-8?B?bCtJSlZMek5ickw2TWY1UXlMd05RdUthU0dEM1ZGdWRROGl5MFROTHhKU01W?=
 =?utf-8?B?L3FpU2FKek1MeXZtdlFpbUJPNnFQYkR2V21LbnBSMHNLeHJRYmsrUG1oK0ZB?=
 =?utf-8?B?N1NLWlcyeDBVa09Db2pvMlpGRS9wZzRRc3Yzb3orWVlTUG9pSmk5czhLMExj?=
 =?utf-8?B?M2FJK3RDV0IzdmhUaHB2OXEyUXoxZi9zZ0RGQ0R6ckZSRWM3aHNaN2dCU0pl?=
 =?utf-8?B?RElmaVdTVW9zTldlMmhFZDVRZW43d1ZYUVFKYWRlRGlmM2hnU0dPa0V5bm0y?=
 =?utf-8?B?V3BoNWxEUk9qREFBU0J1LzRScVF6WXhEaWdqUlYzSWRscU1DdWJobDJXd3lh?=
 =?utf-8?B?bTR3bWp4T0psejNEUmFEcGpuQlhQRWViTFFVZnZ1Sm5SZXM1ZE5POG1Td05t?=
 =?utf-8?B?KzRsOGFmbEM1eCt1dzhweDhOL0RSZ3VlUDE5aitlTlJlZElXZFRidG9tWHVs?=
 =?utf-8?B?SHgwNUVHcVhFVnh1ZmtDcFg4OUtDTWo2S3BaZkgydjBscUZhaTFwZW9NcXhO?=
 =?utf-8?B?c2lnV0ZFdEh2ODM1djlCREREQlllY1RCK2t0ZmpEakZOQ0hBSzc2SHpPUTlu?=
 =?utf-8?B?ZUR1SmY1UHRvc1Q4WnREN1c5dnlSTTBhVTB1YXU2c1VCYXZPdkV1U0ZaSWww?=
 =?utf-8?B?L21hUXl3UDROdDRDblkyeTVDRG1BajRYd2NiV0h3VWxrR0FSbGFxQUE5bnR4?=
 =?utf-8?B?TlFxZ0RjM3d2TGxaeWMySkxVM0QrZ2VuWWRlNmlmb3ZrT2JiQnYzeEFoQWZE?=
 =?utf-8?B?UnpoTjBJS0gwb0JydVJtSldqOUc2K0t4cWlsMlY2Q1pLRjZtbE1laHZQMkdm?=
 =?utf-8?B?REZrVEVYeXY2WHRhRTcvVGQvNjZFWTdiSTN3VWN1T29Pa3YySGJtK2s5WGhj?=
 =?utf-8?B?dFdETE9CM09jejNnWU1yZ2lhR3QwZjR5SEhPTVJidklVQWdad2s1VHhPd3Nx?=
 =?utf-8?B?VmZHSXpvbEFOZzNIQVMrY1M4MGtHMWIzYnJMdk1KYlB2dmNhMXFuamZRRVc4?=
 =?utf-8?B?Uk8yZEVyclh6N0szbGN4L3dEMW1nVnpwQTF5dmRKbHdIdGZ0Q0Rtc1FiMTc1?=
 =?utf-8?B?NU5ndHoxMjA1MEJsaHFDaVd0SXhXeHNiNkpMRDJKYTI0QkxNQjY2Zy9pb0Rk?=
 =?utf-8?B?MUlvcWxvdzBKbmV2SjRBZWVNR1k4OEJVb2ZNOUlmS1lEWDd3Z1JFRklwcW9h?=
 =?utf-8?B?WnM2NCt1VTFGYXZ0dXhObDN0WXF5Vnl4azZjTVQ4bTVSOWhPdTlia3JWdzVX?=
 =?utf-8?B?NHV1UkZra0ZwZHhkM2hCOW1ob2tzdmR1WXJhWm16bDVmcXZqSTR1QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39df39bb-edd5-4c98-e8bf-08deb7191a35
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:12:37.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGOomeHI2TguIZkjJl1OQtwZD/jTrTJGkzJptbcZjAPZY3KLg7NQOMYz5mfBqxvdQoB3XQ86/5dITfjJd5QFH0FnSWQijZIPZgnWpbC1Tw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11388
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

Hi Aristo,

On 5/21/26 4:34 AM, Aristo Chen wrote:
> The get_basename() helper in tools/fit_image.c searches the entire input
> path for the last '/' and the last '.' independently. When the last '.'
> falls at an offset earlier than the last '/' (for example "./mydt",
> "a.b/c", or "sub.d/leaf"), 'end' points before 'start' and the computed
> length is negative. The subsequent size check uses signed comparison so
> the negative value passes through unchanged, and memcpy() is then called
> with that length implicitly cast to size_t, which segfaults.
> 
> Restrict the dot search to the substring that follows the last slash so
> that only an extension in the filename component can become the end of
> the basename. This matches the function's stated intent of stripping an
> extension from the leaf, and keeps the existing behaviour for typical
> inputs such as "arch/arm/dts/foo.dtb".
> 
> Reproducer that previously segfaulted and now produces a valid image:
> 
>    echo dummy > kernel.bin
>    echo dummy > ./mydt
>    ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
>                    -a 0x80000000 -e 0x80000000 -n test \
>                    -d kernel.bin -b ./mydt out.itb
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
