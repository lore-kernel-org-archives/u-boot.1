Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E40C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5449B82905;
	Thu,  8 May 2025 17:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rxLKWvsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D2782A56; Thu,  8 May 2025 17:32:03 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F91828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc/5toLGQYFX3/XWKnSZ2l8RHTGrHUglfa7Aeg/CKQ1/eS76WX+ihvecjtqofPJwdXfCBgM1xUDLDCL249B/KzB+KXTzPMtymZDQp/kR7qNZj50X3yUhE9wMFGD1vrzwwAjCjeIXPoZijoClKhk7KEGln/ecS8TcB2Yal+feFkzmutFWu/m32lrCZCuzoEVpQI+o4HCHUoL2WFE5NWGjXUkWR87uhzcleGu9pBB7cXr5BQknZ1ffVUPIQKbFnmmlAABn2GznrAj8s4yatt3z+DDE/TWupl8332dOeYa5yI3dtzoUf0+FC81856IzYGA1BX7MfNEROEzgQXodaJBARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v30iXv5OGU3oc+LkTU5VfTfPJsszv1KES8H09Lgs3oo=;
 b=bzNvMxuBTiiO8NaADYqXPFLDg+FevpP9QbtER7qPslJ+b0CO6KgQGn9Lf9hB5XOeTdX2UYwUyxPfGj0iCA5QK7VOiQdyzPQmyxkzXG8s66qE9c6xqJS4aKJ0ezybI2bV9pdzFCdlNNhEE5ICmtN7Oley4XtZ/JzByPRH2wDu3lvP/6LRxcmmhJmtEp05TtwK0PrVk25LBkzC0p0MaDCM42Un/rVib1mRNEe9K4YC2P1KK/VpBsJBFzGykNEAR5whLr4dyBo6ZizeKg4Y1axqaM0Leg0yjl0DDY8BBTTG134cYiMbBSNewcc5cTDhCSrWIRLunJFZysIJK8FLaTn9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v30iXv5OGU3oc+LkTU5VfTfPJsszv1KES8H09Lgs3oo=;
 b=rxLKWvsKEuFs+QNbFZY8KqwrLEo7lmDRVeA7FcKDvhrmBr9LLPNVRWT9xQNdW3AFQoLAijSiZmSQE1xpl64XzdS9RdIzpH6bq3WDCIPPkRvGJKttOqTGOfkjb+Da5HVJTKhHVKvJ4eYWNXMROLCykeSMShDYaNbNUwrYUnii7myA09RNEArI66bLUYSSl7Wo1I3aYe2+E8lOnibirQnJGeCUU5g7n7L2IV8QWCauMhKtipiwzXtkLyiKeeFoy6Iog4Xlr50NVufKhb+MXjEvylX33SyRnHs4M3a8HWk3sdjZOkAAO337ThdeS8W3H1OtwoAn+yggB71riK5qhiDhzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DU4P195MB2564.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:56a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 15:31:55 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:31:55 +0000
Message-ID: <19faf506-47bf-4c13-837b-5ea286861685@phytec.de>
Date: Thu, 8 May 2025 18:31:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: bootdev: Add Kconfig option for defining script
 parameters
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 joe.hershberger@ni.com, sjg@chromium.org, d.schultz@phytec.de
References: <20250508131641.2561876-1-w.egorov@phytec.de>
 <20250508131641.2561876-3-w.egorov@phytec.de>
 <20250508152710.GA603748@bill-the-cat>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250508152710.GA603748@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::35) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DU4P195MB2564:EE_
X-MS-Office365-Filtering-Correlation-Id: 09418760-4802-4317-1102-08dd8e4576a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2ZZbDcySytRV0YvM2tuNHBldGdYVXdHVTgrZ2REY21iSzFRM3VsS0dmc1F3?=
 =?utf-8?B?Y1NiekZYQzZpbDVOUXZrbytJR2R2VFNXSlQ3alZDaWJuZGlmdkcyVWdEV0Uz?=
 =?utf-8?B?Z0x5NHNLeUtqT1lmSU96aCtLKzJQQi9hUU1ndFNib1MyVUx1WXBlVnlmSkVj?=
 =?utf-8?B?d1phT1JwTWpmRGdGQk5rRWJWQXJlamJKV0MzdHFLK1FaY0dCNWtqajRQeFk3?=
 =?utf-8?B?SWFFR1JRbnRHdkdZQzgrUi85U3BTOXFJaGFDaXlFcjlzdStRY2FIbW8vakx3?=
 =?utf-8?B?MnVZditiMXkySHl4ejJQWlpYZkltRjBQMUtmWjBEK1RVYlJaYmFVb0hoQ3Ey?=
 =?utf-8?B?c1ZTaUVPVjZSanM2bWkxeUI5bTlvVVVueUFzaWw2Qlh4UmIwTWlGMFdYako3?=
 =?utf-8?B?SW9DWjQxTFk1UHAyemxHeCtqU3F3aXdGRHVJeHpudmZSbE1UeGc3WDFSeWFT?=
 =?utf-8?B?Zm14Z2lSTXUxQmRjM0ZjdmhjekNNSUx3RkpHVUlZb1BKd3pxd2VCaVpYUjFs?=
 =?utf-8?B?Z1R5NmxDSjlMSXgwZ0JRZDB6bkVsYW0rSzZOaEMwS2R2eHlYWWxzcGdRNzBz?=
 =?utf-8?B?ck1nSEJ6dmhyZEJ1UDJiWkk5ci9OeDRUQVpQRVdUWWZCZWQwblBoVUJWVnh5?=
 =?utf-8?B?bGRPKzFVVDloYXY5SjFJL3QrRUdjakFtLzVrU091aWw1RUcyb1pBVmRGT0M1?=
 =?utf-8?B?UVg2TnNHRVVaeWoveDc4aWpXVHpjWHZSWkluVnFCbUJyTDNhQW9UN1psTzZY?=
 =?utf-8?B?d3JMRFh6WDhZa1Fod0kzaXR6V1ZiVlZsL254K1Nzc1A3aGRqZGcvSEFaSHZE?=
 =?utf-8?B?Z1FpeVRkamIwc0gvK3Y2WlRCMTRCcW9lTmxvZ0ZoMk5BRFV6Z0ZjZmZSQnNp?=
 =?utf-8?B?Z3V1NmdaS29lYXlCaHFYd1JqUmV5Vk1DWnVQSVB6SU9CS25zbWZ1RGJRbDBj?=
 =?utf-8?B?dVI4dmQxL2ZaNzdNdVVFdXZJWmhWR1M0bDlBaFgrTklObG5FTGszYVZDV1kx?=
 =?utf-8?B?YWl2dHZkM2t6cW5hVEgxdC9uUVk4UDRoMGtzTE9GdFJNelBHV3AxVE1Jb3h2?=
 =?utf-8?B?ZWRacVNPaTJYcGlNQVF4TUFwa1hhcDdkbERhR0kxZUF3T3o5bVgyaEsrWDFU?=
 =?utf-8?B?THg0OTRLMFRRYllnK1E3dmtNTDgzOWJlTFhtVWtVKysyS1hpbzd2SnVlSUtW?=
 =?utf-8?B?NmRuYWc4UFlxZ05lTjVaeGVRcjIvQzZMRUlveWNDem9FT3A1NGk5V2pYZENq?=
 =?utf-8?B?UmZaQnM5TW1KaVRBNmJxc0J6M01GYkpuNnRPS25EQnhTSXNJQVFVK0k3b2R6?=
 =?utf-8?B?QWtGWU1FUFowU1R2V0tuUnQzd1lwcnU4VEI1NEdWS2hCQnFaUmJrM2ZSbnVR?=
 =?utf-8?B?VWpiZjNYZ1RpV2ZPWVpvQm4xZjEveVF6dnBWNkJTZmZ3b2s0VUl4N25HL1RD?=
 =?utf-8?B?VXZaSGQ5RkpwUnJCVllMeUpudHR5K2dKbCs5VmpPaXZNM1JuaVY0VmdiWk41?=
 =?utf-8?B?NU9WNTYzM0Q2TTJSdkM4M3hXVE94amQxNGVVQlhnS1ArbGszZXhUZUZ5c0lS?=
 =?utf-8?B?OUFydU9uZ1JQeEdIUllaaHlFa1BhK21wdVAxODRtSStuMmNIWEhySU5zWFF2?=
 =?utf-8?B?aHhVRTJHR2RPdVZ2YWRWcFdqTTY3US9iUEhtSndsK0xHcFNlVUxpTnIrOFpY?=
 =?utf-8?B?RmN0eCtSa2phdzVHVk81T2ZNazhPdmNsc050OC9GU0w0RXdsQ2tHYW1KTW5p?=
 =?utf-8?B?L2Y5eHNXd1pjdHRqUDhFT0swTGxTRkdVSnE2eEsxd3lBUXEwODJJRkM2L0hM?=
 =?utf-8?B?RE9IR2Q5dE5uY1dIN3grSlZYWjNCT1M0Yi9tbkFQNDVVY2taY2pzQjgxOWs3?=
 =?utf-8?B?TTRSSHF5c2dXUGxCcDJEM1VPaGUxZ2VNNVFjZGgrWDdaVVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhBZzMrdVZpa3orMko2ckZ2dG4zNTlUV2VUTnVDWm5rU0J3TEpiYVh5cGdZ?=
 =?utf-8?B?anNjNm5mYWV5ajV4M3Nlb2V2NjJaTjZxMDhEcjNScEtLK0VBZnRZWk5rekZS?=
 =?utf-8?B?K25haG1tZnNYOUJ0bElwckJVMVdWYWxHK0xiazNzWXFmNEpzcmRxWnVoRzZz?=
 =?utf-8?B?RFdiU3JmamlBT1lLMEIzcVQ3Tng2TUU2b052bXdSWXY0SDZlMXkySm1kZ1Yy?=
 =?utf-8?B?Q3VnaFdCbm8zMzczU1FiU3ltUC8rQlZPUzNqQkNxSnNGY3FLY1F1RERhN2tl?=
 =?utf-8?B?QnpwOE01SVgxMHd6cTVtbythaXdLVTduVjBzVDQ3V2dhbVVyRjNlbGtqS0lM?=
 =?utf-8?B?T0UyK2Mxa0JvV2lRZzNyUmFDVVVnTmpmWWhvdkIzcEl0VWdRWkw5MUc2bWkw?=
 =?utf-8?B?bnVxaUVGSmFnTkszcUEzdDVUckhIa092T2pPM3pSVzJmZVBLTnd3VTQrclkv?=
 =?utf-8?B?dnZ4NFJEVi9zVnJkNnJVMWZKRSs2S08rUTJJS1Rsc2xoaFpKaTJlTkJVNmcr?=
 =?utf-8?B?QWpOdjlhVjBEM1VRa2VCWG80emtJNVZUWDNUNjJiTVJzUFVreHVuYWswMnF0?=
 =?utf-8?B?R1J3cktOTFBvN1FlVnF0UmhIRWFSbk45WWJxNUY1NlNhR3Mra0hybnh1TW1k?=
 =?utf-8?B?dDl6L2xSSVJ5dFVidW82MDF4bWFPQjBnaS8vbDF0QWVtRUhTT3lCMHp0bnF5?=
 =?utf-8?B?bjlVcDlVeVNQSWhkUzZFenUvVWNIRStwUmwxSy9hYkhhMk1ob1RXcEhadFQ2?=
 =?utf-8?B?VEhiZUtDMVpZQ3Voai9sYXRLc2prc0VFQ3VsdUQ3RkxlRkN3UkxFOHNZbEtY?=
 =?utf-8?B?MDFLNzl3WGJZWDNkQ1ZFWTJ3cXBBcmlOTk0zQmxxUmNNY2czVmRieGw2clpa?=
 =?utf-8?B?MUZIZDJ6VHNwZ0FjZ096OXJxMlVMOXFsZXNNeEtOekJUdElXVUdKVnFCclZY?=
 =?utf-8?B?RGxUSzBUUWN5OXpJODFQQk5hbE1YNkk1UHdVR0hJZC9Gb3V3Wm44SzYxSlZT?=
 =?utf-8?B?bFFQR1BzcnZ2c2haZnZzTXh1K3hFVkwwbVdkT1U0bjR2Y3lWb0NmYVdwTmdl?=
 =?utf-8?B?UUw4eE9BbTFCVVJZc1luZnJYWUd1RW4zZ2tGeVM2dk1UMitrRU5DM2Zaem83?=
 =?utf-8?B?S2FJZU83L1FPTldUUCt1dzlxWm1xYW5MQTlzdktLVEU4YUJnQW5XRFZweitX?=
 =?utf-8?B?OUM3UzkvSlFRTi9ic3pMMVMrOUJ2VmNhWk1yelJ1LzBFZUo1eGlZNGI1UFlj?=
 =?utf-8?B?aHBLem5iSDVHcG1OaUF6Wmp3Vjh1RXR1ZVFqZkRXTzFGK2lSbmdaWStET1pz?=
 =?utf-8?B?RFMvb0xidG9mL3lhYVJGMGNvVVZpNGpSZWFPa2ZFKzJLaVdWYWtnelhOeDF4?=
 =?utf-8?B?TDVyV295OVpmMUwyRGpITFFrWExHNmJmU2czUDQxUStLZ2xmczZ0U3p0SU5O?=
 =?utf-8?B?S1FXNnlLL0R2Yklicmxrd25walAwcklFV2NFejhDUDloWjNLamdSMC9sRkVS?=
 =?utf-8?B?bllqUHNOK0Z4MHpaMzVIZ1BML3ZUcGZWbGU2TU9EcXZvRWNFcnlhTFBnK1N0?=
 =?utf-8?B?eVA3MVNRM3BhWEV3RTFuKytCT0xIRk5tamp6WGxtN0ZLZEtrN1UxOWRpbHpT?=
 =?utf-8?B?MzVGQ0FqRGJQbUgyTjNaNVVZdlBoOWxqRkdLMVVDQnk3UmkzSWxhellaR2JM?=
 =?utf-8?B?WHp6cEFuRjJGOFNiNVJHMnN3TExzYmdIc3R0eTR4VS9Sb1hZMEppeWhVZjNV?=
 =?utf-8?B?bUpqbGo4c3JUemk3TnpWMGc1bHFpSG5HNmNhSGhkRXhRU2xJRHJWVm9XbHVI?=
 =?utf-8?B?TjlxaG0vNVJiWWNGU1Z6aUdLL2RtbnVLYWRIdEt4WWtOSFFqVjhmUXArSFhk?=
 =?utf-8?B?VllSc3hPT1gvYUZvM3o2azlIdytJanNXdVAwT3RoMHkzTHZKdVJ6d1llMjBo?=
 =?utf-8?B?bVkrblNpamhaUFJicUMrZGg4cFRlZVNTN3k1SVoxWE4zUTBrV3B6cWZyRC9S?=
 =?utf-8?B?UVZDa09SS1pXT3ZNb041VXk2dTVBcjhNSW5JNVFvS3pwcHV6Qno4SWREelNa?=
 =?utf-8?B?WC9PZndKMEFXam15amczcE5Za3BFQ3RnR3JzaFlSWlJZNCttQ2hpQllJOEZj?=
 =?utf-8?Q?m1X3QXNrkmZfW2jBldEaBLaZK?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09418760-4802-4317-1102-08dd8e4576a1
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:31:55.2035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx1gbBDoua4wj+O9Bl4uE51EHvJEh1HITYU2VP6/m0QLqlSdqqlDCu2hmoRvgTmjwqxHqyhI3wE/yJG3X1aBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2564
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

Am 08.05.25 um 18:27 schrieb Tom Rini:
> On Thu, May 08, 2025 at 03:16:41PM +0200, Wadim Egorov wrote:
>> Introduce USE_SPI_FLASH_SCRIPT Kconfig option to enable setting default
>> environment values for loading boot scripts from SPI flash. When enabled,
>> SPI_FLASH_SCRIPT_OFFSET and SPI_FLASH_SCRIPT_SIZE define the default
>> script_offset_f and script_size_f variables.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
>>   include/env_default.h   |  4 ++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
>> index ca60a425ba3..fc154ec89d7 100644
>> --- a/drivers/mtd/spi/Kconfig
>> +++ b/drivers/mtd/spi/Kconfig
>> @@ -89,6 +89,32 @@ config BOOTDEV_SPI_FLASH
>>   
>>   	  If unsure, say N
>>   
>> +config USE_SPI_FLASH_SCRIPT
>> +	bool "Enable default SPI flash script parameters"
>> +	depends on BOOTDEV_SPI_FLASH
>> +	help
>> +	  Enable this option to provide default values for SPI flash script loading.
>> +	  These values will be assigned to the 'script_offset_f' and 'script_size_f'
>> +	  environment variables at boot time if not already defined in the environment.
>> +
>> +	  If unsure, say N.
>> +
>> +config SPI_FLASH_SCRIPT_OFFSET
>> +	hex "Offset for SPI flash script (script_offset_f)"
>> +	depends on USE_SPI_FLASH_SCRIPT
>> +	help
>> +	  This option sets the default value for the 'script_offset_f' environment
>> +	  variable. It specifies the offset (in bytes) in SPI flash from which
>> +	  the boot script should be loaded.
>> +
>> +config SPI_FLASH_SCRIPT_SIZE
>> +	hex "Size of SPI flash script (script_size_f)"
>> +	depends on USE_SPI_FLASH_SCRIPT
>> +	help
>> +	  This option sets the default value for the 'script_size_f' environment
>> +	  variable. It specifies the number of bytes to read from SPI flash to
>> +	  load the boot script.
>> +
>>   config SPI_FLASH_SFDP_SUPPORT
>>   	bool "SFDP table parsing support for SPI NOR flashes"
>>   	depends on !SPI_FLASH_BAR
>> diff --git a/include/env_default.h b/include/env_default.h
>> index c72cf123004..9f2f222519d 100644
>> --- a/include/env_default.h
>> +++ b/include/env_default.h
>> @@ -127,6 +127,10 @@ const char default_environment[] = {
>>   #ifdef CONFIG_BOOTSCRIPT_DHCP
>>   	"boot_script_dhcp="	CONFIG_BOOTSCRIPT_DHCP	"\0"
>>   #endif
>> +#ifdef USE_SPI_FLASH_SCRIPT
>> +	"script_offset_f="	__stringify(CONFIG_SPI_FLASH_SCRIPT_OFFSET)"\0"
>> +	"script_size_f="	__stringify(CONFIG_SPI_FLASH_SCRIPT_SIZE)"\0"
>> +#endif
> 
> This should be CONFIG_... yes? Did that just get missed in uplifting
> this from, I assume, an internal tree?
> 

I will double check, test and resend a v2.

But is the general idea for defaulting standard boot environment 
variables in env_default.h okay?

Regards,
Wadim
