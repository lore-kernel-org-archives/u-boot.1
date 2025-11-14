Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719CFCE7AAE
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C7883F54;
	Fri, 14 Nov 2025 11:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PJlb5Fjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A844C84014; Fri, 14 Nov 2025 11:57:11 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F3183F4F
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqy5eGPytKWa495g5QlV5clTngVuvKdzjYvDbnoGSwne+PCo/Z4Dpsn1yBp8WWcWcHFZL0gq7zaQEmCK1Hw1suS91vFLiSjAeUD8uOKUPLOp1KNICUWexXm6oY/d286H+o3hav6lVb84s1Mvx6FrXjc2l1Cs+cgi9AYHAQRQq7CqXsiKLMBgQ5Eo6oismct0CeC8otBQ6R6v0w6j5sFLCAuyHTayH5ip7nI21nC75UGvvk7YmsNB3OrloJ31j/qBc/4X3TJ/XrTxyddArC4WzRADELT3wfUsLbew1ip+UZp9myigqzGKwY8Kccwt1p2fUU4EO1r2/9Pu2PV5kV5ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzpKkm3EVyn9Qs4Lbyk7mX/pcSf6PUc0cb0NY5urWgU=;
 b=eJ4BiY12T2Een6395k67hDkKbLo4WQeRZyxRPo6z06G/1a1nwVCZDcmKaUpc4cbkzccpVl839tESAPwmHw7iCKoKLJmGuVBAZiwR7kBtafueALASa2RajQpN1ys7ECLzxQZ8PD5IrUZGyHO8sok9K54CjqDZRpM1dEFRzchv+VdD9kHYTvVBq31AYi7q9JNgMqxlEaASv5Vp5UqFbv/cHqfHAl/Kcyn/A1T1U6z8VDMhJd7KEt6Lt0DAHlPvUwiUESYcZRo/UnBRVHKAz9uzJlpLjPVGJMUZQIxLeaUAU9+yrLhjhh5PlDnyQ6rNfR+7HRChYELdWK8BibSFYtOAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzpKkm3EVyn9Qs4Lbyk7mX/pcSf6PUc0cb0NY5urWgU=;
 b=PJlb5Fjm1IVnLF8o52KnqySeLDcLdPBrlXznWFm41mdJIt2mvGbzXR4519zzOzj+qyyVjeEz1+I/En/VbjyHZpan+OhOu1gvr563Yy7MBg/8xhWbkmzP4AyCfGnM+lYjUqJNXWOJeBTf+olNeSUCA497ymAQa7+3uAMq3GZga9jsD54XHNnE86FoacPGkPQ0mPF2vk9iMBA5qKvULH3N/Hnr1qVbbhZCiiQzbPNQvnn24odmMNyNlrxR3w9lPUqgMM3AOqV2aHI78tZUkEkb1dFvRkv+fE/GgU+1Ik3Y43rCtnBx0CopuLVxR+PadpKpThacZXgkQGhxqL4v5bra+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN9PR03MB6202.namprd03.prod.outlook.com (2603:10b6:408:11f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:57:06 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:57:05 +0000
Message-ID: <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
Date: Fri, 14 Nov 2025 18:56:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Brian Sune <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251020133455.1870-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251020133455.1870-1-briansune@gmail.com>
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BN9PR03MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bc8b77-b0a5-493a-a78b-08de236c8c76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnJlb3Rqb0pQMW51Z2diVk8zaVBRNkVzZDc3SjRRc2E1T2dNQ2Z0c2htQm9H?=
 =?utf-8?B?WXh3TkRTYVdCam5zUGkwbXhyaU0zZ2lmZUt6Lzh2bjVFV1dhQVBIaGhsTWJk?=
 =?utf-8?B?RXNSUzNabHRzSkdLNDAwNUhJaVpNY29udEpSdW1iTXI5bnFSUzRBSnF6alJU?=
 =?utf-8?B?YTJQdVhWT3hrbFVlQXd6bmoxRjY3czZHRnEybC9kWUNqMWdFNFFGcE5KeFhL?=
 =?utf-8?B?WStFdDVobkZWRnQ2d1EwQXViMDQyVkNzdCt5ZWErRUlxbVNwTFdybDgxZ1do?=
 =?utf-8?B?TFZlQ1BweHpmYWJ5QXlZR1FmRnVmUlc0TlFQS1Q5VGpoRGtjMzE4WDh3TC9o?=
 =?utf-8?B?YWtpaGxsSExDRHBZYkRYUXJhZHdLbXNlMkJHOVBvaHFIN3ZGcE51bURKQXMx?=
 =?utf-8?B?YW5WNUZUL1owZnU5YVJFbVBvRlJNZ1FtTFpuZDZ3d2NXK1ROKzVXaGs0M1Jm?=
 =?utf-8?B?Tyt1RHljNHVBVkhOZE1wNjFoNEFKakpiVkhXWUhpRWZLNGlJbjNrcXh6YVVX?=
 =?utf-8?B?RHFoZXczWWhVYmZpeWplWE5MRlhLMS9JUVFoUFNlNGN1SVljY3hQUTJUbExZ?=
 =?utf-8?B?MTBiNldsY3ZPM0pmWDc0dmNVVWJpOFh2dUFpeDF5M0w3ajlvWmtnditnaG9O?=
 =?utf-8?B?Tk5ZVzFTbFVhVjlYQTZmREJBNnNGZEhiODUwZG1lQTY0clpUSjBrMmZySG9m?=
 =?utf-8?B?eE9heFdQbStxVFJWK3pnTEZKaTY5cXRzU0xtMUlHc1hXeW5RN05wN3EzSzRk?=
 =?utf-8?B?aS9WejFtd1JoYWR0VHczemJ1UDFrZ0Y1Wms0MnJlRm5rcjFUejVmUTRiNFJ6?=
 =?utf-8?B?aEEvZXk4NHBNUVJCbkRRZ2QydkhNdkJ3b2prczRJNk1oKzNyQ2w3VkZFR3FC?=
 =?utf-8?B?emhPNnM5cithYU96SVc3aE8vaGtTRjFLM1hMRUxTVk9GT2RmUG1NZTNYTEcr?=
 =?utf-8?B?YnpQMkc0WjhCZFJNUkJDSDJ2VlpaeUFObDhWV3FzYjlaOStDZ29XVDFrZDRZ?=
 =?utf-8?B?ZFJqVk90RkJOY2RYSnNFZVN2QXJzelJVcW9WcU42aDhDVmk1b0laNVE3OXhy?=
 =?utf-8?B?V004b2JHbVJ4UHcvUjBNYXlGSHBUaDMrUDh0VHlEL1hIelhPR0JMaHhYZURQ?=
 =?utf-8?B?ajNvajMxVWVKU3UzRkVTRFg1eWxDRHJid2I1aSt1b0luNVkzdjNJTERORGRF?=
 =?utf-8?B?QThHc3RqbUExaWFucVBqOTNSVllMcys2MGhzb1VvMTdJak1tUFpZYkJDTkVI?=
 =?utf-8?B?cUpaSzA0K2tqYUNTNEZxSEhnQ1MzUWMvYzdmU1hldTN5emo3R2c5YWhaTTNB?=
 =?utf-8?B?ZndQNGc2Z2pJMkVSWHdTaVFXUWhjQmdOWVk5NFB5b291VS8yWTRpYzArVUlh?=
 =?utf-8?B?V2dLcGN2dWlIbzQ4emFPSkxjVGFEekRhb0luaDg5WktxSGQ0UVB1eDRCRGU1?=
 =?utf-8?B?OStpcGV0QS9oWXpxN21NbWhaV2NkQW92ZEkwbHZVQTVpZXNRUjYxSWpzbFFG?=
 =?utf-8?B?aFhNR3lJZjBMdXlLR2J6a0NqcGgwdHZsRmdEb1BmZmJvdWNBeVZmVi9QakZB?=
 =?utf-8?B?T05XUEtqZ0drcG5pWXVURjY3emk0VloyMDU4b05Md2MvYzg3bnhkSExPSjlk?=
 =?utf-8?B?cXZMNGJPVHcvaitRRFN2bk5IdThnQXdNS0s0M2N1bFppT3oreTZ1MkNRMHZN?=
 =?utf-8?B?U3dYc1MzZ2dzZ2d5T0xNZ1V6c1AyRHhpOEY3RTNtTVYvRzVrWEVYaE5FSVU3?=
 =?utf-8?B?NHZVYTU2UjVXR0VHSUlpYkE5WHZrd0RkZGVRSkVFNEszVUlPckM3MUF4UldE?=
 =?utf-8?B?c20wbkxXVXRac3FHUFdXM1huV2Q4MEhsOVUwTjlZQjdUeTRVRjJyQ3FhMTZj?=
 =?utf-8?B?UVZLaTYzTUdlcGRQNzFXVUFXb2dpRzVleGxLcHY5RG9GYk9Ib05rVEhYdDYx?=
 =?utf-8?Q?5S0phkCXmNGSXpt2xnNQRjJLgM51Mvaz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFY0Y29NUktmQXFrdWxhQmtXbDhiNGMrS3IzSVlhTmxLRTljY0pJQ25pS045?=
 =?utf-8?B?SGVLemR5bkNPamtlODh5NjFlNmhlb0IvTDN6VlNQWnFnVURtMDBhV29PVlV6?=
 =?utf-8?B?MEJiMGN6K3FRZTgrMm8wMStOeUk5bW14V2YweXpaNHVycTJ3c1ZnQnpmWG5j?=
 =?utf-8?B?QU5WWWdwNVR6U2o2SnBtbHhFKzNWVFduandMZUpEbDltc3owV1NKUlhNWC9h?=
 =?utf-8?B?OFFxT3V6WDRPVzliV080ZmpCdkFYMlE1N0ltTjlISHZINTlJVmpwTld2SUh6?=
 =?utf-8?B?ektqWFRFYmcwNVg2a2tLczBlQkcvUjhTNUNRWXE4V2h5alRzOVlGVVZacHgr?=
 =?utf-8?B?QkRSS3dJVnZrOVJwYmZNcmtjZE5CYVA5ak4rNkVqQzhyMDg5bzFncDJuVmpu?=
 =?utf-8?B?anJzTUNqS2NtU3MrSng1TDFYM09tdzFHQmxCRmNxOS9uaitUd0NiYS9VMjlS?=
 =?utf-8?B?c0JFNFAxNFVmS0ZMU21JRFJneVBBRGMrQlRGOUV3N2syVlc4cEZqNjNPMWdz?=
 =?utf-8?B?c3MzMmZGRmdDR01NWUhJcjB0K01YWjVCc0lHNUdXTDV4em9SdVFwTTE5Wk9y?=
 =?utf-8?B?YmlCQ3JoUFAzS2JoSzZCdlVEZXBTU1Q0Z1pNenFwV1dwZ0tZVXd0TzFSN3BK?=
 =?utf-8?B?QU5Sb3VSSkFLaW5xQnBSTnNoeE5CNTgySzdzcE9MOVJrV25VSUlyZ2w2N3Rv?=
 =?utf-8?B?MHlWaE5FM240VnRhYUNVcnVjNjBYUXorZVV2czAyOGtIeWZtUERESXJBd3VI?=
 =?utf-8?B?eEpPR0o1UVFBV09NcjI1UVV5K1VjaGRubm5sUlVta25vNnJ5UDROSWlPT1dE?=
 =?utf-8?B?Z1RrL1dEcmV1NDduV2c5OE8wMXRiVE5lVEVNUWNPNXRDRjFBU2M5WE5oWld3?=
 =?utf-8?B?VkpCNitFNWFsMERQbi9rVmtFQ2JJNnVoRTUwdjc5bk9tNTNVSVM1eTFzT3FN?=
 =?utf-8?B?ZUhwOEovaC9URW9iRHk1bXFtTXBMbktjd2JwOTYrYWZNaWt0S3RpLzhxdTdx?=
 =?utf-8?B?TlFTWFdUL21WdDIwNE91RFduMFdtWU5rWHlGRml6czBGVVR6dmNvK0Fmanln?=
 =?utf-8?B?TVFOZzcxVENSYjNEMkhjaWxTaFhOV0pyektodXRyTVdMdjdsK2R0SG9EU2dT?=
 =?utf-8?B?K096WWpILzZWTUc2Q0YzZjF4ZWR0eWV1SEVGenY3bWNXTXNaQWd3U3RuaXBS?=
 =?utf-8?B?VXhENEl2T2dSU3c2ZFdUUmdjZ2pTQlVkTTNaRHBPb1lneVhHSFFoZWNWbDlx?=
 =?utf-8?B?bkt4VTFqQm9XTjdnUjVPOU9aRzRXaUNVSk4yRHpYVEN2Zm1MVjdjMXdrNzlZ?=
 =?utf-8?B?N3ZhaXRmclQ4U2RRYUlNMFFla0hSVGVMMnBJRm5hK0loVFJuOE9HNEZjOUtJ?=
 =?utf-8?B?ZGs4UzV3N1daQTNyWFNYbnJzUVBGaHJlZkpqRm5RSGJZb01SNVQ2aTZ4bDVV?=
 =?utf-8?B?TDk5bk9wdFBISElNa2FQMEQ0aHU0cjNsU2diaFA0TUJyU2FyU1FvM0EyclRm?=
 =?utf-8?B?NytkVk12d0t4VXZScW45QmlkN2lkUUV1b0FiaXM4QXpSQXdoVG0xMHFPU2Nq?=
 =?utf-8?B?SERoNmt6Vjl6N3hQNEQxazQ0Mi9EQUlNYXZXWE9KZUcvS3N0OHluUktGK2gz?=
 =?utf-8?B?ajluUWFzTTZUMng3bFA4Y1UzQzJ3RlRDblVqcTl1SGM1b3pSR3QrVWNoTVdh?=
 =?utf-8?B?UGgwVDRaUVNqcGpmcEV6a2FFN0V3VEd1ZVdBZXhwTk1Zc01SUUhRUjJwZnNT?=
 =?utf-8?B?N0dMMVZxdW9sN3Q0b1k5aEM3NVQ0UkFrVjhxdEgzYjdnNTgvOTlhUnpYa1kw?=
 =?utf-8?B?S0lKaHhNT1hHdEZDb3IwYUNSZDNtWURGampyOTZ5L1pQZVk5SkNvM2ZETm8r?=
 =?utf-8?B?c3pSdDFEdldsdjB1cUhDUkdBL3lMVDdjRUVpZTZ3TG5GRzVuRkhrK0VBaklW?=
 =?utf-8?B?L0k4aEczdjZhekcrSTNOMWlxN3dhRFhoM2pVQk9nd2pKWTN4T3pVUVd6SUNq?=
 =?utf-8?B?NlR2SGhHNHVqSG5VWEtVeC9WNVhnejkvQXFxOWQyM1llS1cxTW1kSS9nakxF?=
 =?utf-8?B?RmdhbnVWaGw5c0tqUjZ6K2dhZjlCN3JsalhmNTR4MU5lcElUSXFQeU9KNEh6?=
 =?utf-8?B?Rk1vaDM2c3JaZ2R4bGxsWGxwZW1Eb28vSHFGMWduOEFjaWZ4NlNtVGcwOHE3?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bc8b77-b0a5-493a-a78b-08de236c8c76
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:57:05.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrscVTHTkNpkYywoIlrSAEsLIbpzJ46dQH9ea6h0Eo+6+Ui7NwHsTGnWgrqMd4QDcReKO1vMiyzrpvHUbGx3w3kgUJDJoY+FRtBjI8uBOvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 20/10/2025 9:34 pm, Brian Sune wrote:
> Since U-Boot 2025.07 pure SD Card
> boot no longer works. Now Altera released 2025.07
> shows the different on the u-boot files.
> After testing, the major root case is
> get_managers_addr. And this patch fix the
> SD boot stall via pulling from offical.
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/misc.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 76747c2196a..c54f5e32454 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -178,7 +178,10 @@ int arch_cpu_init(void)
>   	 * timeout value is still active which might too short for Linux
>   	 * booting.
>   	 */
> +#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_SIMICS) || \
> +	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU))
>   	hw_watchdog_init();
> +#endif


This is intended for internal use and should be removed.


>   #else
>   	/*
>   	 * If the HW watchdog is NOT enabled, make sure it is not running,
> @@ -223,8 +226,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
>   
>   U_BOOT_CMD(bridge, 3, 1, do_bridge,
>   	   "SoCFPGA HPS FPGA bridge control",
> -	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
> -	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
> +	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
> +	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
> +	   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
> +	   "For example:\n"
> +	   "1) To enable and disable all bridges (command without mask):\n"
> +	   "	a) bridge enable\n"
> +	   "	b) bridge disable\n"
> +	   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (command with mask):\n"
> +	   "	a) bridge enable 0x3\n"
> +	   "	b) bridge disable 0x3\n"
>   	   ""
>   );
>   
> @@ -261,6 +272,17 @@ void socfpga_get_managers_addr(void)
>   	if (ret)
>   		hang();
>   
> +	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {

if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
         !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
         !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {


The condition for non-Agilex5 platforms should be rewritten because 
|sys-mgr| has already moved to the driver model for these platforms.


> +		ret = socfpga_get_base_addr("altr,sys-mgr",
> +					    &socfpga_sysmgr_base);
> +		if (ret)
> +			hang();
> +	}
> +
> +	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
> +	    IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
> +		ret = socfpga_get_base_addr("intel,agilex-clkmgr",
> +					    &socfpga_clkmgr_base);


Similarly, the section for Agilex and Agilex7M using |clkmgr| can be 
removed, as both now use the driver model.


>   	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))


The N5X section should be updated as:  "if 
(IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))"

The remaining part of the function can remain intact.


>   		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
>   					    &socfpga_clkmgr_base);


We’ve already tested the above changes and they work as expected.


Thanks.

Tien Fong
