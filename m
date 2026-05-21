Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4716BCD5BA4
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 12:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D6683FB0;
	Thu, 21 May 2026 14:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aCDelCZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C4A83FF5; Thu, 21 May 2026 14:43:10 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B4B805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 14:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8DFNRDUKNcO5ujxD2QhUXnR0zSxskfTT4BcnJveR/IhP9SkjG5zC2paFNDpfDs9kSUamL7wAdYGi1KvEJaFMr1cqPrQWKsVySh+m4J2Z0P9WUxdM6urWS1t2lYobWxevK1UcRxFundceTpfUXJJd+HWj17VY4mPo3ZGnrl8hnVV2hDOjd/kc8MWHeqNna1UcwzpdYBDvnliX5cOmSvdABkK4HK5wWYiPQGr6kKLW+HWMXXfjm8+3erZke/ZQ9mBdLuBZHK3bs+q3onhB4Dc6mQ2QPPvjg8hvRHZBPVDUPUq/vd1Uq/5hCJYb3knfDLld1KTegMyPP+dTww2VKCnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+HcqeB4RJdnyX6n1eBwmhhCU8EegKofaSpwSR5nXJ0=;
 b=O+fQZbDpTctShNC7PIWigwUwoEHz2OnPDGV7jNfMeFSl0q/aG/YwA1zPXqUAWfpj6Je8LvqTFD5Rzg+wK3p85MYWC7kIIJR+ISxmuhMoAUwtNvzoRrXmw4cNQf+goDTUcFQx/1JMTqT1jQ9LoMrbarrAFWzrEdQsM6MdzcsfP6jSUUBYLMYVs9djPrVNULiBHIbjdHXR67TDD0p435uwpd3LnAl/Gn6FRBAQDZi+K3cwSUd+kVN+O/t52ambyxM6vLAtvmAUzX7H+wMenAbax9OohejssVggAtknXt2f9DhmrCeXWe/3K1IhJTiAS407EoV/aj+5GxaTD4hrTipgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+HcqeB4RJdnyX6n1eBwmhhCU8EegKofaSpwSR5nXJ0=;
 b=aCDelCZKSlLTpjK6HKgZs+uM/yF0Z1blkykRMIBLOkTRUgY8lGVEY8eS2PyWCgptvJqVdqpcTtggMtHZ/OJTLuzRit6IdyHPhueh1V4PG116TzH+HaFZ3gumVUqSiSwvQqRp0jEP2zWifoYk3d3c/X6vlqBG7Rm/RnZ45ivhFoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB12080.eurprd04.prod.outlook.com (2603:10a6:800:315::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 12:43:03 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:43:03 +0000
Message-ID: <f62b090d-d1b4-4ff2-9d9b-b3ef0fb83795@cherry.de>
Date: Thu, 21 May 2026 14:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <f1af4ba2-22d2-497b-9c98-09487ff06cf1@cherry.de>
Content-Language: en-US
In-Reply-To: <f1af4ba2-22d2-497b-9c98-09487ff06cf1@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB12080:EE_
X-MS-Office365-Filtering-Correlation-Id: b71e2535-3959-4ba4-bfac-08deb7367f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|22082099003|18002099003|56012099003|4133799003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: LtfKg58f8uN3VHakrHraNLY89AJgD9fGjvzn7U7EBgVriZ4s0GNtsp8SRn1kdMM5CSKyNfHHBk7f1qK7j71BszTrECtFs4TTd+iXS0QPp0KurDmRcnhPBgVmSxg+XLgo2Jim3jBujoHXnYA81uTUhCllAHYOhFmzuFFsh0Gch9P9Sr6kc7vNwdcx5CFSo89gKeYlrZLUW/OpsdU/Fh/2isnD30CcNe6T4LYAMPNli+9Lss3zu77+koRWv2jtmhUuXeXGWagBaw/hVyaICE5Qvf9puGteOgF3o48jacyDLedAAK2yG9+qgdahj8TlhmJeMH6lSFLZpI0o3K8U6C6xp051MEkchZ0tfq/camJJ8O+WyLcO9PHDOlOCt6CzuLM5GUl/rPAZgAH0SDqZ22TyUwdlviUTo9G/KLr0jPQm9UswrJf1YiRfitExW4utq8A3Wh5z58EEgLHht3D5HcQIZ0B+fn2voXCxsRmmIeILyxlvx1wvtQ4Oi8ClyM22zjpiovfIBoYJVPL10mQDNb4Rfar2wCCKPcEyfbA9em/vCLviN+GeM3OLuZh18xW5AYnx085HgD2QbKgeBDKlo2eGVMJvCgNQ8gaQdK0OuVB+rD04/qWOIG34sGNvMBAvuRP/SRf8Vw6eZJukPLEs8pXpfhFmy7RvVFqNrfR1d3lK+kSGok86Ow9Cn96ZEmTDjSJm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003)(4133799003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09pSGM3Q1puM1doVkQxZFV5YXhEUk9ZdGkxK0NEbFN1NFRwQ2kvamFJUy9l?=
 =?utf-8?B?cko5dEhDM1F3N0VvR3pjOGYwMkVORmFZbXhoc05EakIwU0hFZm5kMms4SXhi?=
 =?utf-8?B?SzRTUjU2dmI0bVk1Z2NjUGdmSk12QUZyc0x6cDBENEJxaDdJN1Q4aUltN3Qw?=
 =?utf-8?B?cWFIeU5PdG0zeXlGTzVIOU82MjIvcGhtVlFXOW5WOHRqVnJnQk1wamFGTVJO?=
 =?utf-8?B?czNSWVNsL2MrOUFIaWpWTmZ1dUlzNmJBTnpXY2hIcDNnNHZ5bFVCZFE4ZDgx?=
 =?utf-8?B?dlBJL1g3MXE4amN3eHZ4YnBmcjhyNXBjNTJmWW45SzRFbFpqSUVVTjRyTC93?=
 =?utf-8?B?NDNXZGhOL0haNmRuK05OeVNvT0F4MnpzNWZtTzE3RzNsNDNla2hsbU5HY25B?=
 =?utf-8?B?clRVTDNRNDN0aGtqNHZiVzcyNjVLQnhzL2xQZHFTVWxKYmVLZFd5UW5PczZV?=
 =?utf-8?B?cG5NSldKTEJ1MXBjUTlVV1NiSVJhMzFSVW9ReWd0SVA2ZE03ZGtmbVAxMWJa?=
 =?utf-8?B?d3JUaEVlS1hHN3RxWTZuaUVrQjVaN0ZRMHBDWkdCbnFrR0wvbWZhb1I2OWtx?=
 =?utf-8?B?SVlxSVU0Zlo5TFkvUFE5RjJCUUt1YkRnM2JTdDBGdGVDV2xnTGpIRE9Wbmds?=
 =?utf-8?B?bWRnSHUwNDN6OVNQQjdvbkl3VGg0M3ZoTzN3eXNVaFZsVmxiSTFnc2NTUnNC?=
 =?utf-8?B?WUQwRVlDaEhxZUZJM0JSVkVNNmxQeGc0aUJRRkZZV2duUmo0V0lqYzBWTWZJ?=
 =?utf-8?B?NEpqc2pQcjBOVm9uTmdPOENLZlNtSldTN3hPNm5uQ0E4K1p2VmhTNEhVV2dR?=
 =?utf-8?B?elcxMXJndmdySzdRM2x6RnJId2tmeDIwSkVuQjkrOGlUSEcwWXlyZ0g1dlFS?=
 =?utf-8?B?Y3R0RkFSWEFySnlYNUV4b1RvMFk2VUw4ZW5HQ3dPeVFwcktBTE0zOXNLaWxz?=
 =?utf-8?B?c3F6S1ZoY08xb2pjQnN1bm1ndHd6T2g4Sm1mNWFqRnRvdzlMYndVYVNJK1FU?=
 =?utf-8?B?Q2l5dlNKNCtHcFgyZU81ZitLL3BNdW14cUtwMm1tQ1hLWXhMelBGcHZ5OCt1?=
 =?utf-8?B?dkdmS2FHbENOa1FMSzVSSGdpV2tJeWFGM0xDVG9ZekgyVmpOWVpsdElLVm5Y?=
 =?utf-8?B?dHBTaXRQSDR1R1lQemhGUDRkTWYvQk9jcDFCSXN2U0szWWlIRGt1WkIwemhJ?=
 =?utf-8?B?NnExYTlrS3owbVVXTkZsZmlxMlhacjU3RFozdERkTVc5eFIxTDZaTjc1a0hx?=
 =?utf-8?B?M0MzbWpKOGQwSVlqcWRYelNsZk9EemNNSm95cjk5S29ETEtPcVZFVXM2MXJG?=
 =?utf-8?B?dEtJaEpMY051SktXWFR1am5uT3RrS21US0xQTldSWUNpUjhRbVliVFJGUVMv?=
 =?utf-8?B?UVBLaUV5Z2JMUXl5MXpHMTNETTMxRklGd282U3ZDTVNhTVdrWVo5NVFBUVVD?=
 =?utf-8?B?S3I0dmlOUWpYekhVWSt2aXdqSmNDNnlsUW1KSExwYWtIK09zNlFneGs1a0NY?=
 =?utf-8?B?SFpYQ1cxVkliY2pHTnBnN2JpUFFtdFNTa1huMTZqY1Z2MHVBNEFLT0hCYmVp?=
 =?utf-8?B?a25uR2pMNFFaS1lyQ2h6NHk5cHRRWVhPV0pWeTdFTm1XRE5hVlUxTGJjcmYv?=
 =?utf-8?B?TWw2RjU1YnQ1MHQ0anhtTzBZOHpsc2sxRDVtUjFCOWtlb0plOFRRWEpqNGtX?=
 =?utf-8?B?dURKcTlLWm1xQ2hhUkR4MVJMbFdFM3BETGxWTDNFSnIySEpxZHVhMjcxeEhs?=
 =?utf-8?B?NFNyamhYSnpEbG43NWNqKy9TU3YxQjkwQzlaaERuQXJsbkdrVlhEME8wcFNy?=
 =?utf-8?B?SVJORW9RcHNocFRkQ3RudElpanYxRisyeWlXZC9XTWJrRFZQcHgrdmZzUHVt?=
 =?utf-8?B?UnBFVE95a3U4eUtyUC9wcWUvamNDa3Y1YkdiMDFGTG5SbW9MVnhVYjF0Mld3?=
 =?utf-8?B?ZWJEaE50dUVFTThhYzA3blhOMFZGL1VzUEJ2cEsrYmxhUDQ1Qkt1U2tGQS9N?=
 =?utf-8?B?YmZFeDVOSWRzSjF4cXhEazBDcHpFMXlzQTJ5OStHQzJRdEVuaE8zbHUxRnlZ?=
 =?utf-8?B?OG5pZjNOWFdBOWczbDV3M3RSUEl1ZUV5TmdsbUVFdUpJeTcvUnV5WUlVTWpL?=
 =?utf-8?B?UmhLd0VtbjJwNDhkZmNyZzMzeEsxa214U1BqUm5YVzRxdVlqMXJGUS9tckhD?=
 =?utf-8?B?VUFvV1pLYXJSV21vUVM3V21xWTBPaFhUb3hNR0FDVjd0b0NTUWdqejNQa3lQ?=
 =?utf-8?B?WjRacmlpaGtxdHdKM3UvYkZLY2w3U1o2MVU3bmQzM0R6Z3pHWDhkeC9PMUZZ?=
 =?utf-8?B?dDNCZVRrdnNqRVF1N0ljbEE1L3JDL2orbXhvZWlMQ29xekQ0ZUs0dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b71e2535-3959-4ba4-bfac-08deb7367f24
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:43:03.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yI+iWUv0YJGObyw/eLQdrcN2d0ohRfXA9G7Zg68p5vjMY0BCdQibCU0gHO+ibWX3Gl5o0nGG8ZNsJMIGF+5wu/+hxRHIEHVH8Ntu5tMCSxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12080
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

Hi Eddie,

On 5/20/26 12:28 PM, Quentin Schulz wrote:
> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
[...]>> +    store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
>> +    ERR(!store, "OSSL_STORE_open");
>> +
>> +    while (!OSSL_STORE_eof(store)) {
>> +        OSSL_STORE_INFO *info = OSSL_STORE_load(store);
>> +
>> +        if (!info) {
>> +            drain_openssl_errors(__LINE__, 0);
>> +            continue;
>> +        }
>> +        if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
>> +            private_key = OSSL_STORE_INFO_get1_PKEY(info);
>> +            ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
>> +        }
> 
> I have been told that calling OSSL_STORE_expect() with the expected type 
> should make it easier to get the object we want directly.
> 
> Something like
> 
> OSSL_STORE_expect(store, OSSL_STORE_INFO_PKEY);
> 
> right after OSSL_STORE_open(). I'm assuming this should allow us to get 
> rid of the OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY check 
> since OSS_STORE_load() would only return objects of expected type.
> 
> c.f. https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fdocs.openssl.org%2F3.0%2Fman3%2FOSSL_STORE_expect%2F%23description&data=05%7C02%7Cquentin.schulz%40cherry.de%7C02bd298ec294469f172a08deb65a8a6d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639148697211162781%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=v8m2m1Mi5UXizJjVHHUE2EPryifJfMTnDgrSgFZx1b8%3D&reserved=0
> 
> I've not tested this myself yet.
> 

This was actually required for my custom provider. When you don't set 
the expected type, your provider store context's OSSL_STORE_PARAM_EXPECT 
param gets initialized to zero which means "return all supported 
OSSL_STORE_INFO_* objects except for OSSL_STORE_INFO_NAME". Our custom 
provider didn't implement that (it does now) and would simply say that 
what's requested is invalid. I'm unsure whether this means our custom 
provider was broken or if we should cater for this corner case and 
simply request a store its private key?

On a more general topic, I cannot build anything including the 
openssl/engine.h header without openssl-devel-engine on Fedora. This 
means tools/binman/test/fit/dummy-rsa-engine.c but also CST 
(https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/unstable/code/back_end-ssl/src/engine.c?ref_type=heads#L11) 
which means we cannot run the binman test suite on Fedora without 
openssl-devel-engine package installed, or anything that requires CST, 
e.g. the nxp-imx8mcst nodes in binman. I'll try to figure out a way to 
handle the dummy-rsa-engine.c and be able to skip engine/provider tests 
if unsupported.

Someone will need to have a look at adding support for providers to CST. 
We download and build code from apertis.org but I'm unsure whether we're 
really supposed to use that or report bugs there. Debian points to 
https://salsa.debian.org/collabora-team/imx-code-signing-tool instead so 
maybe we should report there? They seem to be an import from NXP, so 
adding Peng in Cc, maybe they know who to ask for provider support (or 
at the very least, remove engine support if engine support is disabled 
in OpenSSL so it can compile just fine).

Cheers,
Quentin
