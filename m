Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16DFC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4349688AF9;
	Thu,  1 Aug 2024 12:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lBEUbrP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBC888B09; Thu,  1 Aug 2024 12:27:56 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C5F88AE4
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wreu4+CqLKsM929pJe9UO27dGDawmTlVuzbSt0SURnmPzzhyNDxXOwS2BYSzN+dqOaBqd5V1+0x+8u+cstcuCA95cxnYakEUfBzNPQEYP+aPOToC0P42NRSIvN3E9P4+ZWtG7LGCQNSFZGfwXpPeQ9+OZm0AMvLOWgOYjiwfSd4KHikwp3cDcx9s5uYRtmP/wnn4ldXPKv/sFscB35H3ps0EKkhHJaiUDinn8coVEJdy6Ocxa+dtwNYPoMrn3oiRBde58Ge2QQKg5+epJLGhRNKmhgR+hl7DIF2Gv+mBB4QrArrj0AkY589bBsHogkkDxhMW491OlhoFQGazl76/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3yCrKHAP/okw7tGO2oA15bddO93rfNPplDqVjdg2/w=;
 b=rDTsewgJqPG4EuhQdUXqgYLTtTybK7d7ieWfF0R/votwmR7Xcblkzn1H+/K6ptNi0K7Jewf+qZLAn4OWQ6T/keZbM8RLPfBoe4MJfmV0h1xGrzZFuV4Qa/FAbew3dcEsRcJVBr8vxxrjpNNYAGUw2P/7qPhmQGCD0t/Y6HaWMynhrKZLMzZRkNkKtvE2FlPXeARK6NsjxR0SRayTn+76D+RZjNds1UFKXtXSM3sqjyMOOF9aFJ7YP9iDE2Mqkf8OxIh2UumoHg7x3GARYf3kymTFZy5lr4RLP8Znu9NcWg9bZwm1C+v1nQJYXQVm2Uq+3PZ9s4bBu3tOyRMbfHF+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3yCrKHAP/okw7tGO2oA15bddO93rfNPplDqVjdg2/w=;
 b=lBEUbrP50EWdDdWglt+qmLyNba4HflWQP6YY4N1L9NB8rhmXtwtz+qQZPlBnIqLktk4JLFnG4Xdul9/TkLn2y6XJEpLWaYB93BCgCo+XKrFnVHFuRhEKqa0NsxGk48Q1E8aeZdaVHtJL3M+HgEYCyx8qH0EDK3ThScdhH3obuB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 10:27:49 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 10:27:49 +0000
Message-ID: <5c5f170a-90d5-40db-b1b5-da004f3e3d9f@cherry.de>
Date: Thu, 1 Aug 2024 12:27:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: clk: add UART0 clock getter/setter
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com
References: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
 <d1f9b069-1c07-44d6-8dbc-fc6cd07b576c@cherry.de>
Content-Language: en-US
In-Reply-To: <d1f9b069-1c07-44d6-8dbc-fc6cd07b576c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::14) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI2PR04MB10979:EE_
X-MS-Office365-Filtering-Correlation-Id: 29137a3f-3722-4b1d-69fe-08dcb2149774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVM1ZnZBam1EZ0pYc1lZaXV2VWVGVUYybzBoem5QK3hjVFo5bStjNWJaOWkw?=
 =?utf-8?B?dTRDUUJKM3dnVUdTaEx2NTZTR040blB1SU5oUDVBRHNEc3crdGtKR3hBOFBV?=
 =?utf-8?B?YW0xSXBKdUdIUXliSDRhOFpiT29rYVNocGp4Q1EvWnRlYjhheERnYTNDTnph?=
 =?utf-8?B?WmVFOVRzVys5dDNRL0JaQ0YvU09aUFlTdEFGWjQ3SzdDVU5XS1Z4eGNHWHBy?=
 =?utf-8?B?S3p2UXpLcEFaQXdhdktiU05Fdm9hMFpqSklkK2g2cE9lRHBneE1qSjhTQWxj?=
 =?utf-8?B?WU5vaXd5VTl3ZGJQZmZBaGxTRW1TOFpPWjZNQVpmNWpVcWh1TUFlVzc5bG5Y?=
 =?utf-8?B?THl3dE9idFd4SUxTeXIzYlV4SXBlTHN0ZndTSUtkZDhFTmRhNzUzSi92bUQ2?=
 =?utf-8?B?YWcwZlBaR3kvd3RwdGVzOEdFb3E1WDE0OGg3dUhUUTlFbTZFQUcvd1E5Zldl?=
 =?utf-8?B?cGl3VUhxVWsvK1pxT1lrZ2gxdGkySWZIMy8wemp5eG8yZU9KWEtQTkFMOE44?=
 =?utf-8?B?dngyM2ZxTVRzQzhrTXR4MWp1emhmWXR1bnc5MkVtM1F4b2ZQdUJUZVhWK1Fk?=
 =?utf-8?B?b3NxdmVPZ3RZZjBBdDZWUUFtYUJLdFBYM3pkNmxyQmRzWWE4WWtYM3RhME5C?=
 =?utf-8?B?MWFLS2d3bnNrdlRkV0xORVVSM3U0dmwvUWVDQ0VGcHl4WVhmdXJ6andOT09F?=
 =?utf-8?B?NVRBRkZjdFZVcEtCQVAyL1B2UDdyVU92K3NEZFFIRnJHV21USmMydDY2SmdM?=
 =?utf-8?B?QjFPQkJtV1JON0xtdCs1WXQzbUlOZ2xkTDI4eVV6SlB5b3Jnckp6cUpsM1l3?=
 =?utf-8?B?Z1M5TjBhbGh3U1dKY1JobFdDS0ZRMFFqdE84SEQxeFNlbUJOZ0gwTTVWOE9w?=
 =?utf-8?B?L3cyYmRXTWpLMSszeVZ5NzgxNFlkUEhBNktxaDZRRk85RnRvQ21RMVU3L2tp?=
 =?utf-8?B?dXNmeml0VC9DdUNzVGg2RGcrWFRjaTk2V0k2OEkzM1dpZHRaSkZCWmYvOXpT?=
 =?utf-8?B?bmZ5R3hiaFJZMVJGYUxtRFJkaEdQZHhWZHl6eGp5bVh2Y0MvZitOUnRhUHMw?=
 =?utf-8?B?cll4YlhTd2pvSy9Qb09LbFFvSXhNTUFvSmZ5Qmx4d1ZOcW45K1BUVkw3STZw?=
 =?utf-8?B?YS85L0RIUFJpYzI2Rm14RjlBUnlYOTZFM0puL0VpN3NQa1BLeTk3M1hzSnJP?=
 =?utf-8?B?eFpROU1KNkFJWkNGWXViVDVCazhYUzVSaVBEajMxeGtyYkdUOUZaWEtIemVJ?=
 =?utf-8?B?alQ5MXlrZ2x5UVp5TU5iY1RNb0dPMmVMdFI2Z0Q1OFZMb1J0eVdCRjFlaGMr?=
 =?utf-8?B?QXI0Y2JXOVlxbm05RVc5ZnJHazVRazI0U0ZyWFliUXZWTHJDWDNLTDgwbTdC?=
 =?utf-8?B?eUlSa1dlOXd5T2xySzdiY1lQNDgrUUYrYTB0ZTFsTitlb1dYNEVkMGx6bmNH?=
 =?utf-8?B?N0oyb0MvZjhoT0g1K211aXZYQXlsSTdtUVBuOCtWaDFiOXk4ek5MS3R4SE1o?=
 =?utf-8?B?NVJPdFpjQTRuTDdzQStRUXc1Nlg2OFpZaWlRSmZERTlRYTB5YUxBVmNaNS9Q?=
 =?utf-8?B?QlcyTnI0TVJXOE1NWm90c0pWVlR5ZURxcVpyc2xpYmRFakxQS0ZUeC9GQ2hh?=
 =?utf-8?B?UGxETTEySXVCNVBjTXRNZG44N3F4VVh6ZDBrOExmR2E5MzNqWndINWRKR2Q4?=
 =?utf-8?B?STNaRjJMNUlhbnhKbXlENCtTaUN4ZDI1dzdReExSbGR3UzNqc3JxUkU4Mjdo?=
 =?utf-8?Q?1Vu92peGYQTp/tHG6Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UThZdjlMQXJXUTJPWWtSdE9WUWViYzNUYlpVMlh4WmhEOTVZU0IzRmtXSmVK?=
 =?utf-8?B?MWR3Z0VOdFdTdFA2bTFSeHN4YnZDYVpEOGRpOE5oUDF5VGFRK3QxZXVyTitp?=
 =?utf-8?B?bDJMcytqdVNHM215dGJUV1pheEVOTDNvcm05eWczYmNuZno1QklMTkgrOExQ?=
 =?utf-8?B?Q0RtcFN2U1hES1dTTUhVckVTOWI5cG1jYm1tUUZnMk54TFJSdnllQkJ4UXpm?=
 =?utf-8?B?ZUtGSDd1ZHVJTzFOZkNoVU5IOHJTb2tZNHJDVDZwb2hhUE91bXJuRVVpUHFl?=
 =?utf-8?B?Mld1S0FDYXZBMXdUaTFJNEt6cWxUcmd2UTVBWWp6MnZiMWFPWFl3TzFmaGFa?=
 =?utf-8?B?OWQxZTQ1d3lSdE80MWR4dEhQVlhub2JBaC9xc3NvYjJqT0hxUGN3ek04bmx5?=
 =?utf-8?B?cGJUb2IzMjBidXdocnJ5d1IyY2V5WWtYU2pidisxeTF5R01pZWVOSmQwTkRM?=
 =?utf-8?B?YVcwRzY3cTV5dTE1V0FUWnJaQ3l4WlFzeGJQdjlWY0xMeEFRVFJCSWlSZDJp?=
 =?utf-8?B?LzA0eGVWdllrbWs4NmtlTXhRQkhkUytwOFJ6Z21YcThvczBabGhpY3ZLc09U?=
 =?utf-8?B?ZmlHYVFIdk0yVkVrSkV2eitDRk5yWkpGQTVLRTE4OE0rUFdSUFBBNFZMNVdS?=
 =?utf-8?B?NS8rT2l3YXduQzJtRXpzVHNaTUNZVE1heG15cmtHTFkzRjVrOEg5QjdtYU1S?=
 =?utf-8?B?UDJtM0wwRVAxM3FCTzBrRXBwMVJobHN0alFabGZSdVlzZDVJb2w0b2JDeWFu?=
 =?utf-8?B?YVZqbmN0ZGF0bHA4UTFQOHF1bC8veDYxTk9nZ3RCaHhMS3psUjd2aWtPb2dU?=
 =?utf-8?B?K3BBSkNib3JONSt1T0ZiWXliT0l1STNoYk5ZVlRIcHg2M2dwNVBPM01qRVNL?=
 =?utf-8?B?SXZtdDVhaHhqeVMrd3lCd3ZrRGIvZmo5bnlZUXRzbEVXdmdOdVRvcEtHdjZx?=
 =?utf-8?B?cFN2U2JNYmpWUW9kYUhpUlhod2pmcDRXUFZqc0xVbVVickFCYXN1a2I3U2Z5?=
 =?utf-8?B?M0FyRmZtdGVoTEhMZDFtbU5GeENZTzEzSUlQNit4Q2x6S2hvTm5HYnlZMWJU?=
 =?utf-8?B?M0V5bVNCUVFmMFVJUkRQTVdid0FEcm1lYWg4eW5UbmtIZjdSSzNMaGcxU2Zq?=
 =?utf-8?B?cklXbEpmb3lCOUpENzlXTXVvbmVkc2xIdHQ0di9FdlkrRmpVYUxBRnovVisw?=
 =?utf-8?B?cGxldjdPU0tIcDNkcGlrbzJNQ3Y0eHdzQ25wTzM5aklrdkhjM2svckcwUnps?=
 =?utf-8?B?M0pieHJtN0NVZGRBemVKK3YzaHRWTEN5M0NKeTBEQ2dPRnRNR2JHUEhNTFpa?=
 =?utf-8?B?Q1FKb3l4T0NRemVPUzFSLzdwdlBiSWhrUndCcVIwOHNKVitDRFF4eFh3Tkw4?=
 =?utf-8?B?N2JtaG1QaGJUcVVmMHV5cHFGVUYzd0JDQ3BnSDlldENOUzhCNFd1djJjUE92?=
 =?utf-8?B?WjBjMWV0QmhwQW5lZE9qNW9sYXRhald5V202SjJHaW5melpWU05rTEx3cW03?=
 =?utf-8?B?ZDIyeVhlbzZCSXhUaDBoOWlJS0ZFZHo4RXp6T2FMejdIdDRUK3I5K1N5NFNn?=
 =?utf-8?B?U3F6TWlIUHhVcFNNUXFOVGZ4VjVTRDRnU3M2UzA4bjlRaHpiaHFBYUgzblZu?=
 =?utf-8?B?RDB1VjZDZEtJdFZwRWZBaHBZUEJyK1pseG5OS0kydmVjaHhiS1F5WndWN1Nr?=
 =?utf-8?B?VTgzWTAwdkdJeERWdUJzZndzMlUya2hKQWp6TDVGOGxvMmN0Rlg0cW5aUjRa?=
 =?utf-8?B?c0xBM3hYU3FPTklUT1VBbjVQYmJ0eTVwQXlwK2Focjc1NzVTK0tlWU1VTFk4?=
 =?utf-8?B?enBvWFBUQ2RCWmprWnB5eFlNSWtHTldxZXJia04yNTlTc3U5SkdwdFU4cnkw?=
 =?utf-8?B?WVNncGUzVEVYckgyYjlYS2NmNmtZcVpCR2JqTE5lbFJPdW1JZ3ZaTlpGbmQ1?=
 =?utf-8?B?MzdqNTZoZitRMWs2bmxIRDYxUjFXWUFqS2ZjZldNZFVaQks2MXI5QzY5VkNt?=
 =?utf-8?B?K1ExekFoNDE5aG9ESWJRZWVPeE1wYzRkeWFHbDhTZUNiRHg1UHpZK2U4VEpa?=
 =?utf-8?B?SVk5WE5vZ0lZT0hQQ2NmYzFIYVVRY29sbmZ5bXRLZi9KN29rMTdCRmk0UTA0?=
 =?utf-8?B?L2I0ajRJUlBSWXROR1FVUkZyaTZsRlFjdVdIV0c4bDl1MmkrRWhxc1FQQStZ?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29137a3f-3722-4b1d-69fe-08dcb2149774
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:27:49.0682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HH2QOM6PoNv/nEFSDhZlaKZc+b1wQ/QrLwjAEauR+wkVHiAc/voBdmXs2eNjrupJ+Jle+374dPYyyaXN5LLLRnBhPUvBv+c/+Og+nrCvRvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979
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

Hi Lukasz,

Maybe also make it explicit in the commit title that this is for px30 
only :)

On 8/1/24 12:26 PM, Quentin Schulz wrote:
> Hi Lukasz,
> 
> On 7/31/24 11:43 AM, Lukasz Czechowski wrote:
>> Add dedicated getter and setter for SCLK_UART0_PMU.
>> This allows the driver to correctly handle UART0 clocks, and thus
>> it fixes the issues with UART0 not working in case DEBUG_UART is
>> disabled.
>> Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
>> clock source for UART is GPLL, instead of external oscillator.
>> If the DEBUG_UART is enabled, the clock source is changed in
>> board_debug_uart_init function to 24Mhz oscillator, which also
>> matches the fallback value obtained from DT node.
>> In case the DEBUG_UART is disabled, the UART clock source remains
>> default, and the DM serial driver wrongly configures the baud rate,
>> resulting in broken communication.
>> By implementing the UART clock getter/setter, the serial driver
>> can probe the actual configuration and corectly configure itself.
>> The DEBUG_UART settings now should not affect it.
>>
>> The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
>> sources, that are managed by CRU, are not yet handled, as likely
>> they won't be used in real scenarios.
>>
>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>> ---
>>   arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
>>   drivers/clk/rockchip/clk_px30.c               | 107 ++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h 
>> b/arch/arm/include/asm/arch-rockchip/cru_px30.h
>> index b66277fc7f3..504459bd93d 100644
>> --- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
>> +++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
>> @@ -464,5 +464,12 @@ enum {
>>       UART0_CLK_SEL_UART0_FRAC,
>>       UART0_DIVNP5_SHIFT        = 0,
>>       UART0_DIVNP5_MASK        = 0x1f << UART0_DIVNP5_SHIFT,
>> +
>> +    /* CRU_PMU_CLKSEL5_CON */
>> +    CLK_UART_FRAC_NUMERATOR_SHIFT    = 16,
>> +    CLK_UART_FRAC_NUMERATOR_MASK    = 0xffff << 
>> CLK_UART_FRAC_NUMERATOR_SHIFT,
>> +    CLK_UART_FRAC_DENOMINATOR_SHIFT    = 0,
>> +    CLK_UART_FRAC_DENOMINATOR_MASK =
>> +        0xffff << CLK_UART_FRAC_DENOMINATOR_SHIFT,
>>   };
>>   #endif
>> diff --git a/drivers/clk/rockchip/clk_px30.c 
>> b/drivers/clk/rockchip/clk_px30.c
>> index 2875c152b20..64f1a335cb0 100644
>> --- a/drivers/clk/rockchip/clk_px30.c
>> +++ b/drivers/clk/rockchip/clk_px30.c
>> @@ -1589,6 +1589,107 @@ static ulong px30_pmuclk_set_gpll_rate(struct 
>> px30_pmuclk_priv *priv, ulong hz)
>>       return priv->gpll_hz;
>>   }
>> +static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
>> +{
>> +    struct px30_pmucru *pmucru = priv->pmucru;
>> +    u32 clk_uart0_div_con;
>> +    u32 clk_uart0_pll_sel;
>> +    u32 clk_uart0_sel;
>> +    u32 con;
>> +    ulong pll_rate;
>> +    ulong clk_uart0;
>> +
> 
> You could group all declarations of the same type on the same line and 
> also respect reverse xmas tree ordering 
> (https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs) (though I don't think we are that strict in U-Boot).
> 
>> +    con = readl(&pmucru->pmu_clksel_con[3]);
>> +    clk_uart0_div_con = bitfield_extract_by_mask(con, 
>> UART0_DIV_CON_MASK);
>> +    clk_uart0_pll_sel = bitfield_extract_by_mask(con, 
>> UART0_PLL_SEL_MASK);
>> +
>> +    switch (clk_uart0_pll_sel) {
>> +    case UART0_PLL_SEL_GPLL:
>> +        pll_rate = px30_pmuclk_get_gpll_rate(priv);
>> +        break;
>> +    case UART0_PLL_SEL_24M:
>> +        pll_rate = OSC_HZ;
>> +        break;
>> +    case UART0_PLL_SEL_480M:
>> +    case UART0_PLL_SEL_NPLL:
>> +        /* usbphy480M and NPLL clocks, generated by CRU, are not 
>> supported yet */
>> +    default:
>> +        return -ENOENT;
>> +    }
>> +
>> +    clk_uart0 = DIV_TO_RATE(pll_rate, clk_uart0_div_con);
>> +    con = readl(&pmucru->pmu_clksel_con[4]);
>> +    clk_uart0_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
>> +
>> +    switch (clk_uart0_sel) {
>> +    case UART0_CLK_SEL_UART0:
>> +        return clk_uart0;
>> +    case UART0_CLK_SEL_UART0_NP5:{
>> +            u32 clk_uart0_divnp5_div_con;
>> +
>> +            clk_uart0_divnp5_div_con =
>> +                bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
>> +            return DIV_TO_RATE((2 * clk_uart0),
>> +                       (2 * clk_uart0_divnp5_div_con + 3));
> 
> Are you sure about this DIV_TO_RATE here?
> 
> The TRM states:
> 
> clk_uart0_divnp5_div_con
> clk_uart0_np5=2*clk_uart0/(2*div_con+3)
> 
> but this would make it
> clk_uart0_np5=2*clk_uart0/((2*div_con+3) + 1)
> 
> I believe?
> 
> The kernel seems to be handling it like the TRM says (but I wouldn't be 
> 100% certain here as the clock subsystem and Rockchip drivers have many 
> indirections and I may have gotten lost at some point :) ).
> 
> I think we're fine also regarding u32 overflows as we would hit this if 
> the rates were abore 2.1GHz and I think GPLL and NPLL aren't that fast.
> 
>> +        } > +    case UART0_CLK_SEL_UART0_FRAC:{
>> +            u32 fracdiv, n, m;
>> +
>> +            fracdiv = readl(&pmucru->pmu_clksel_con[5]);
>> +            n = bitfield_extract_by_mask(fracdiv,
>> +                             CLK_UART_FRAC_NUMERATOR_MASK);
>> +            m = bitfield_extract_by_mask(fracdiv,
>> +                             CLK_UART_FRAC_DENOMINATOR_MASK);
>> +            return (u64) clk_uart0 * n / m;
>> +        }
>> +    default:
>> +        return -ENOENT;
>> +    }
>> +}
>> +
>> +static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv, 
>> ulong rate)
>> +{
>> +    struct px30_pmucru *pmucru = priv->pmucru;
>> +    ulong gpll_rate;
>> +    u32 clk_uart0_div_con;
>> +    u32 clk_uart0_pll_sel;
>> +    u32 clk_uart0_sel;
>> +    ulong m = 0, n = 0;
>> +
>> +    gpll_rate = px30_pmuclk_get_gpll_rate(priv);
>> +    if (gpll_rate % rate == 0) {
>> +        clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
>> +        clk_uart0_sel = UART0_CLK_SEL_UART0;
>> +        clk_uart0_div_con = DIV_ROUND_UP(priv->gpll_hz, rate);
>> +    } else if (rate == OSC_HZ) {
>> +        clk_uart0_pll_sel = UART0_PLL_SEL_24M;
>> +        clk_uart0_sel = UART0_CLK_SEL_UART0;
>> +        clk_uart0_div_con = 1;
>> +    } else {
>> +        clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
>> +        clk_uart0_sel = UART0_CLK_SEL_UART0_FRAC;
>> +        clk_uart0_div_con = 1;
>> +        rational_best_approximation(rate, priv->gpll_hz,
>> +                        GENMASK(16 - 1, 0),
>> +                        GENMASK(16 - 1, 0), &m, &n);
> 
> I guess we could try to find whether OSC_HZ could produce a closer 
> approximation than GPLL but I'm not sure it's worth it right now.
> 
> Otherwise looking good,
> Cheers,
> Quentin
