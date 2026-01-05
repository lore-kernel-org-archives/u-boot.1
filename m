Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF237C2A075
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 04:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0834383A9F;
	Mon,  5 Jan 2026 05:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Fn8ivadA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A80B83AB7; Mon,  5 Jan 2026 05:30:29 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7733D839F1
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 05:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulXIznga2OxjHyDMN6Oy8fdt9KpXgteaVo2lR75LEaFCQkZrSA43uur/rYiPN7FMls056VuD/0JCO8qflDoxE1GHGaZ2FWuI0eHiH1Nhaz/wW8814di7izV8sExat4O6kHfoc+L4G4si+POEhhHh5RcpNMqflv/IKRM3vGwA1dQlymiYoeWl2AK4BPlxhNiWPESt9PflqYBTiHjvpjKHGq9V3N0IGXiQrRAre2loVZM5oNkCHg537v1D36d8nK+v1IkbDJRAJnztmmqjGP5v5kzmhRMisXa61P9nxh8sDeznjbMH+/6B8EvrtCLGBj4gdtoZZjCSdJdUoVrvai0KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVrUtwTmts/O5DVs2qchkZ1bxhUl7dB+gCYKl6/57Ys=;
 b=M2pH2V5t5h6hrlIZ92WUiQ75f8MsdpXem7m6gCnQx7kATxvb9cKYfl+kGHAmbHjEhgWXtORHumDYI3GmwygJ/Nw1HBaWxuMMXUhv+BtoURdUxIqB6cfl1ly54vUQNlm+yVlZsiTeoTwDzLWenkaQWH9Bdj2qbx+7Bykc3NeHmGSPeS3xbLB9o7rNzvVkOZn53G1CnGwUaKdLtnKfWhxxXCBzeRZP74/ACAD6IWjCl1FRrkyGB6X0I71yNqT3JxHicJEUPUPT2qc9xsMIoYNQMIMnqrEvOAJJ++VVR54fSKKYRfS174FzRipcIenHdMobIi/svyoCc106ERD5fKyz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVrUtwTmts/O5DVs2qchkZ1bxhUl7dB+gCYKl6/57Ys=;
 b=Fn8ivadAdDHZ5OhycBIe/TjWM3Xzd3J4tps4Q5+3DT0MbaWvUmP/5Sz/HJix7VAXi3i/j/R7P7H2Wy1/dcU1Ij0V0jxHdMMtu2M6FBhvOIhWRHIy5oG3lbGCnEvPLHqxl3fOZCGBHQOwFXBgDKOGYR1XzDSFQbcLzaKw8uXVqtrkR+bntwCWhLyhjStXmpFH7U9INmTHyJF3g3WmPAnSuKqvJ7J+1p4IOBKQSLd+p8kphIqOwHLDvEVwKCeeE7XNcI2gZ320X3opljkOIybD2VrVuNTkApqcw3BRhGwB20epj/WNlMh/s9zfi2LSa8IWfp0QVIChaF+VM57ZTc6eDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM4P195MB2989.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 04:30:23 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 04:30:23 +0000
Message-ID: <30ebbb5c-0237-4da0-be97-b802ea7c0fdc@phytec.de>
Date: Mon, 5 Jan 2026 11:29:28 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 2/3] board: phytec: Add PHYTEC
 phyCORE-AM68x/TDA4x SoM
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
References: <20251231014255.87648-1-d.haller@phytec.de>
 <20251231014255.87648-2-d.haller@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20251231014255.87648-2-d.haller@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::21) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM4P195MB2989:EE_
X-MS-Office365-Filtering-Correlation-Id: e24dd844-a560-425f-724c-08de4c132422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkZFTWJDVkEvaktkVkdrdFZxaEgvcVk4eWkrS2p0dnFia1laZGgrWmxPWWdj?=
 =?utf-8?B?bWhtWERyMjlNOFczd3JhaXBrQlBKVkxJaVFIaVc0cVFPbGQ4ZUNqMHBSZGd5?=
 =?utf-8?B?dHNHR05PR2FKaVRxS3kzR3VIT1liZ3lyMnhxTmVqWURveW5WZmU1NlBUdC8v?=
 =?utf-8?B?RzBKdW9zK2Q0V05VYndYa3FYSm8yRXFVcVYrdVRlbTlIcFF5VmhJWlVrbHN6?=
 =?utf-8?B?MUVzeGorWjdjb0FhN2ZPSFowc1JqODBIMis2cjNYcTluRWE2RDNIaVlPTGcx?=
 =?utf-8?B?Q0I2bEIzQXdrdCtzUFFXV20xVjkrMWJvaTI2QmFLdEdVZ1N0OXMrU1BTekVB?=
 =?utf-8?B?b2JqYzltT3lBZ24wbURnNy9CZDJFa1g5a1F1S2VCTXJMT2t4RXZKNDRrQmlJ?=
 =?utf-8?B?V2hGdE9hQ1hyWlRVbHhTTWpZck80bjFxZmE2R2tkYkI2cVQ5YzVUTjdCdkpM?=
 =?utf-8?B?ZXBvWUJlQi8wbUhCK0g3UzE3Wnc0enBmM3UxU25CeHd6OWxkSndKUjlYN1RN?=
 =?utf-8?B?T0VmbHR6M09qY2FhS0xFZEJYY0xmWVE0bHNnSzhHcWo4eFpHeUhhTUxaR2FC?=
 =?utf-8?B?SmRQSjVEblNyWVNEVjNXRm9DSVVuMlV6aUIwUUxqS2VxMlZmZ1NTdS9SdThJ?=
 =?utf-8?B?WmJVU1JNeFVyU2hxS2hjMElSY0FwZnNKM3dhYTRXaWN0N0QwemNpajM3WEV6?=
 =?utf-8?B?anE2ekxhTnYrajRzSC96NitEVHpLanJFSEtYUWlscVpCQk9XcFB5Nm0xbWpx?=
 =?utf-8?B?ek1mWHozZzlHYTRjTXdYZ2lkUHBVM1F1OHlUNndnc29IT3k3Z093aEo5ZXFI?=
 =?utf-8?B?Z0ZrcVdpcTNDSG9aS2lYTDRNQ05TeUhUcFFXOWQ1Q1BBYllTQzNURUtOOWRw?=
 =?utf-8?B?VjlEOW1jQldRcU5yT3dMSXpHUnY0K0gwMXhja2oyQUMxVC9IMnQwMkRjMDF0?=
 =?utf-8?B?eDVvNjM0VmY4OU1aV2syQUZlWHdJOEtzeGVwRGNBUUp3TUNITERzU1ZoQ20w?=
 =?utf-8?B?N3VxN0JrT2tGL3NmOG9CWmlnNUc3dnIxVjViMmFWeitQcW0xLzRzZXZsOEJh?=
 =?utf-8?B?Tkt6L1JpWkJJTC9CdGVmMWNBeldvT0tPblpydWNoMlFqZjh1dXE2S25NcjNo?=
 =?utf-8?B?TzczZVZiVzU5OXBicmx4eW13THdyV1ltOHlaVzE1bmxQclQxeHZhaUZXclIw?=
 =?utf-8?B?MzFjNG43Q2R3YzdUdUI2Z1JNOTZxR2tqYVlvdWlLN0gyemlOUmRHc2ZBdTgy?=
 =?utf-8?B?QnFrZ1RSM2JEWjZqN3A5ZExrUy82K2VyTUxiMk9nSDdNY0c4MG5takQrWDRX?=
 =?utf-8?B?R0pFUnV2cW9xUjlaWWdCK0JyZHArc29HcEtRWUU4dkxlU0pGTm9vOGp0dVNL?=
 =?utf-8?B?cUw5eGg5WXBmMDQ1UXRRYXBLMWZES3hjQ2hxSllDeWRKR2lvYXFOc3o4ZGdh?=
 =?utf-8?B?NzE0V0Y4VFBRWlJhTTBnYkM4ME9ac0ZmdUI5RXA0MU40c3lFTWxnclZiQkRr?=
 =?utf-8?B?eDBLcmxVSTUvRlRNY1lmM1RNRXIzOVlBR1FFQmZQc3lwSEhDcGRxOXUrYWZK?=
 =?utf-8?B?TXRieWZBL0ovVmt4Vzhsc1hLTWNpTi93SEtUNHBTYlE2MW9QUm9mc2pzdHZi?=
 =?utf-8?B?MnVXY1FIVFdqWUxqQUR2OUtlakV4TjB1ZWl6RVZYZWIyY1Bqbzl1Nm9PZzlC?=
 =?utf-8?B?MDc4eVJPVnJzb3NCb3BXcTJudDVlNzdzME4rODFNUFNpVmxwcUVRcDNtQWJU?=
 =?utf-8?B?OXhpaTY3R1hxM1VLZXZkY005MEZZcGNCL1FoQjdNdW5Wc1p3RGdnRzY1OGFC?=
 =?utf-8?B?VVpZd2JPeHBsOGszVm9TdFBYS2F1NEgvamhlNjZteHlqRFNJMUhPdGlDYm5E?=
 =?utf-8?B?d0EwSzY1SGJwNW9UNkVZS1ZzT1Z1YXd1ZnBjMXpCaU5CY0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JGblV4RzB6cGRSNWhtNlh1Y2lTMlZlVXBwN2JPVXBYZFFpNVB1VHlNeTBG?=
 =?utf-8?B?K1VPdjg1YTg5cjFwYXV6N2dBWHFyMjJjRmpoSmF3MjBRaWREWVBzNU0zU0FD?=
 =?utf-8?B?RkNEWUs0TzIyaFhXSW5zWmpobjloTi9BNVFRdksvSUlzSjQxc0lPOHVaeWJp?=
 =?utf-8?B?VUZnSU83SnBydVcyZ1d6RHhXNlhNN2MxZmk0QmlqdU1jVkVHcytycG9mWGV6?=
 =?utf-8?B?RWFpNjZRSkdXQkpxdFM4VnVNc3BrK1FiUHBDa1ZsOUh3Zmk0Q3Y4NU5rV2FE?=
 =?utf-8?B?dlF3SFlBNm1KUHNZa2Fia2lkUG1RRHhUZ1R4Q2EraEg1cjRUb1FIeEgvNUFH?=
 =?utf-8?B?RGxpM2pVVnV4b3JrSU55ekp5NXc3RnNLSUNKVWdmMkxCd2JzZm0zQ1ZxUVBS?=
 =?utf-8?B?ZGN3cENLQkgxS3U0YTBPRWgwYVc1QkFvK1V3TWkxcVh2UWRVVnlOK04yZ0da?=
 =?utf-8?B?TnpXQ0IvbzB0dStvZVJKRXk5Mnh0cmtIM0lYMGJOVkY3Q3c5Z1BIWmN1eFg2?=
 =?utf-8?B?b1ZCWmplWEdWdHpzTmsxajFNclFKUUg1NXdCemF5U2xGVk9GVnpNaTZSdlZv?=
 =?utf-8?B?NVZ6UDcydWhZYkJlZTdSbVdqUHVQZlRiUkVUVEJ2RjdYWlYzQ2p2dnhOVktI?=
 =?utf-8?B?RmxqelVIb1daRVhkcHJ0VDBpNmdCOHgrdFQwMnNYKzVPYzJmYk1nYVB5Nzh2?=
 =?utf-8?B?MXd4Zm1haWdVdlkxSzNqUy9ua3E1bmsrLytrL1dHRE5oQmRpdndHUm90M1dn?=
 =?utf-8?B?KzJhQnF0RURHSUtseHhFL0c5cVkvZytqMDV0QzZ6bHZMRW1VOUlON1pXa2l6?=
 =?utf-8?B?amYvWnhsVVgyZDdaWlh0Qi9VZlVNb2RVS0hkdTNKWlFaejI2VnljSXFqN2o0?=
 =?utf-8?B?TlRzZVZ0aGpKU1lzRFZ4TEdMMnVEZHAyYjFJQjg0dzlYeWNZYmQ0TW5GMGxR?=
 =?utf-8?B?NFk4VmEzVkNQZzhCdzEwMSswQkVXRzVnUXBpMjlaOVNHaWdsWXpYK1ZNNjJH?=
 =?utf-8?B?ZjFUWnVDQTd5UFE5YmdrZXV4YkI0Q0l4R011NDh3RXNCL2d6RzRhTHR5SjNo?=
 =?utf-8?B?eGZ2WXJsczNTVnJpTlJ3K3RQSlVNZk1CU29BOWovV0p4L3d3R1BPcExvUzN0?=
 =?utf-8?B?emo4MVdVYzBEV3BVemJ5bk5tQldKV3l3OHhoSkJJTXNTdEhBTHZtby82NWxS?=
 =?utf-8?B?MHMwRkw5MzNUd1o3SWNmNHRkR0k0aVBJUFpVMWxGWDVnQ3VVR25vbGUwSHo5?=
 =?utf-8?B?ekROUEozSXpMVjQwcUZxcTRsWHY5ZlRjZ1RhSUNNS1VUa0xhd25MeFJDWVdL?=
 =?utf-8?B?NWpZcWpha1lYRWxGTGhJWC96UU42a2Y1dmZtTmcyOXhMSWdCMGpldGFtZkR2?=
 =?utf-8?B?TXd4SmFQOTlxZmk4VkNCb3IwQldjcUxhRU5nNU1EVFpHU2I5QkU0c3R4c0Zp?=
 =?utf-8?B?bCszRi9kNG9vbEl3RCtiQzJCM3YrUC9MV1Y4b01CaTlFRWlVUHh1M0RPSHRF?=
 =?utf-8?B?KzVSYm9wZnR4V1lVSytjS1dvWXZxb2RHdTFoRkVSRWR6a1RYSzRJODhXaEtN?=
 =?utf-8?B?MDN3V2I5UHBJYWdpbTNyTUllMlJuWUMrcFVmakpsMVlRU2dtS05XNVZxTzBP?=
 =?utf-8?B?OVNwcDU1OWRMTEdxTng4OGlZWXdIOWQ0dGRsODhSWlFoU041bWFNVXNzcTlE?=
 =?utf-8?B?eDBFZGEzMXlLaXltNFdUdzBMeUFpN3VuYkhFUDB6OHJMOEw5cU8xZHoveFNF?=
 =?utf-8?B?Q3ppeUdka1IwRGJFSWxxVFIwOWZ5OE13VmhuRlZEZVlzTWNyNGV1ekhPQ1ZE?=
 =?utf-8?B?RHE3ZlVrdXVZS1I4dXI4cjdWZzdNczZvaXFsSHFoa2lhbFRNbDNSdE1QZUJZ?=
 =?utf-8?B?ZnA4SVI0bmdUR0J5ZUlRQkRBcmVZRWFlcnp3UFlGMktuWDRaVksyekxhaUNp?=
 =?utf-8?B?VGkwR3JDc1hqQm45NDBHUkR5dTFtVDRxbkkwR2tTSUVGbkl1ZFFqYkFJQTMz?=
 =?utf-8?B?NEZkeitRelE1a0NmSGEvS1NGRVBZTWRFWlpvQnpMSFdGZWI5RUlXMm0vTjgw?=
 =?utf-8?B?emhHUkh6OUlMQWdmK0VKdXJBdUZkVDhlYW10cUpZQmJZTUFWTk00Wm1kZ0lC?=
 =?utf-8?B?YnBXZjFmdTFVUEwwQi9JTU1wY3VTak8yOXRIN3VRcldJZjdWanRXRWZqQ3ky?=
 =?utf-8?B?a3hub3BtdWVFUE1VeVNteGp1bjdHY0ZPZ0tGY1Y3U2hWSGdSUDZ6SU95Vi81?=
 =?utf-8?B?WEJIdEwyK0tZWnZlVVkycndNS2RWNjZERUIxc2x4N0I4N3NZelRuQ2FvUStI?=
 =?utf-8?B?ZEd3bmpCQWpTTkNuVW9BdjJZSS9TMFBLMDMrYTdyVHFRVGdBTC82UT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e24dd844-a560-425f-724c-08de4c132422
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 04:30:23.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glMul336hPe+eAf3LmNRRoArIHTsUotfIgmJwgld8Tpc8AfaZkdtr7UPG2Ogi/OtTEVY9pVM/LV8fFcsGOk0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P195MB2989
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

Hi Dominik,

one nit below

On 12/31/25 8:42 AM, Dominik Haller wrote:
> Add support for the PHYTEC phyCORE-AM68x/TDA4x (J721S2 family) SoM.
> 
> Supported features:
> - 4GB LPDDR4 RAM
> - eMMC
> - SD-Card
> - Ethernet
> - OSPI
> - AVS
> - debug UART
> 
> Signed-off-by: Dominik Haller <d.haller@phytec.de>
> ---

<snip>

> --- /dev/null
> +++ b/board/phytec/phycore_am68x/phycore-am68x.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + * Author: Dominik Haller <d.haller@phytec.de>
> + *
> + * https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x-tda4x/
> + */
> +
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <generic-phy.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <net.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <spl.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/root.h>
> +#include <asm/arch/k3-ddr.h>
> +
> +#include "../common/am6_som_detection.h"

You are not making use of any detection code. Drop this include.

Rest looks good to me.

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Limit RAM used by U-Boot to the DDR low region */
> +	if (gd->ram_top > 0x100000000)
> +		return 0x100000000;
> +#endif
> +
> +	return gd->ram_top;
> +}
> +
> +int dram_init(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_mem_size_base_lowest();
> +	if (ret)
> +		printf("Error setting up mem size and base. %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	s32 ret;
> +
> +	ret = fdtdec_setup_memory_banksize();
> +	if (ret)
> +		printf("Error setting up memory banksize. %d\n", ret);
> +
> +	return ret;
> +}
> +
> +#if defined(CONFIG_XPL_BUILD)
> +void spl_perform_board_fixups(struct spl_image_info *spl_image)
> +{
> +	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
> +		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +			fixup_ddr_driver_for_ecc(spl_image);
> +	} else {
> +		fixup_memory_node(spl_image);
> +	}
> +}
> +#endif
> +
> +void spl_board_init(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_ESM_K3)) {
> +		const char * const esms[] = {"esm@700000", "esm@40800000", "esm@42080000"};
> +
> +		for (int i = 0; i < ARRAY_SIZE(esms); ++i) {
> +			ret = uclass_get_device_by_name(UCLASS_MISC, esms[i],
> +							&dev);
> +			if (ret) {
> +				printf("MISC init for %s failed: %d\n", esms[i], ret);
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(pmic_esm),
> +						  &dev);
> +		if (ret)
> +			printf("ESM PMIC init failed: %d\n", ret);
> +	}
> +}
> diff --git a/board/phytec/phycore_am68x/phycore_am68x.env b/board/phytec/phycore_am68x/phycore_am68x.env
> new file mode 100644
> index 000000000000..4908055b5425
> --- /dev/null
> +++ b/board/phytec/phycore_am68x/phycore_am68x.env
> @@ -0,0 +1,22 @@
> +fdtaddr=0x88000000
> +loadaddr=0x82000000
> +scriptaddr=0x89100000
> +fdt_addr_r=0x88000000
> +kernel_addr_r=0x82000000
> +ramdisk_addr_r=0x88080000
> +fdtoverlay_addr_r=0x89000000
> +fit_addr_r=0x90000000
> +
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +mmcdev=1
> +mmcroot=2
> +mmcpart=1
> +console=ttyS2,115200n8
> +earlycon=ns16550a,mmio32,0x02880000
> +
> +spi_fdt_addr=0x700000
> +spi_image_addr=0x800000
> +spi_ramdisk_addr=0x2200000
> +
> +bootmeths=script efi extlinux pxe
> +boot_targets=mmc1 mmc0 spi_flash dhcp
> diff --git a/board/phytec/phycore_am68x/pm-cfg.yaml b/board/phytec/phycore_am68x/pm-cfg.yaml
> new file mode 100644
> index 000000000000..e6496512b6b7
> --- /dev/null
> +++ b/board/phytec/phycore_am68x/pm-cfg.yaml
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Power management configuration for J721S2
> +#
> +
> +---
> +
> +pm-cfg:
> +    rev:
> +        boardcfg_abi_maj: 0x0
> +        boardcfg_abi_min: 0x1
> diff --git a/board/phytec/phycore_am68x/rm-cfg.yaml b/board/phytec/phycore_am68x/rm-cfg.yaml
> new file mode 100644
> index 000000000000..8796463129d2
> --- /dev/null
> +++ b/board/phytec/phycore_am68x/rm-cfg.yaml
> @@ -0,0 +1,2523 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Resource management configuration for J721S2
> +#
> +
> +---
> +
> +rm-cfg:
> +    rm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> +        host_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 356
> +            host_cfg_entries:
> +                -  # 1
> +                    host_id: 3
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 2
> +                    host_id: 5
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 3
> +                    host_id: 12
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 4
> +                    host_id: 13
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 5
> +                    host_id: 21
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 6
> +                    host_id: 23
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 7
> +                    host_id: 35
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 8
> +                    host_id: 37
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 9
> +                    host_id: 40
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 10
> +                    host_id: 42
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 11
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 12
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 13
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 14
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 15
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 16
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 17
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 18
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 19
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 20
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 21
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 22
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 23
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 24
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 25
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 26
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 27
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 28
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 29
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 30
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 31
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 32
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +        resasg:
> +            subhdr:
> +                magic: 0x7B25
> +                size: 8
> +            resasg_entries_size: 3032
> +            reserved: 0
> +    resasg_entries:
> +        -
> +            start_resource: 0
> +            num_resource: 32
> +            type: 7744
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 24
> +            type: 7744
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 24
> +            type: 7808
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 16
> +            type: 7808
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 48
> +            type: 7936
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 8
> +            type: 8000
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 8
> +            type: 8000
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 6
> +            type: 8000
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 6
> +            type: 8000
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 28
> +            num_resource: 2
> +            type: 8000
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 30
> +            num_resource: 2
> +            type: 8000
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 4
> +            type: 9472
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 4
> +            type: 9472
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 4
> +            type: 9472
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 4
> +            type: 9472
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 8
> +            type: 9472
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 8
> +            type: 9472
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 12
> +            type: 9472
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 12
> +            type: 9472
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 16
> +            type: 9600
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 50176
> +            num_resource: 96
> +            type: 14402
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 14403
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 16
> +            type: 14414
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 16
> +            type: 14414
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 8
> +            type: 14415
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 8
> +            type: 14415
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 16
> +            type: 14433
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 16
> +            type: 14433
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 8
> +            type: 14434
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 8
> +            type: 14434
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 100
> +            type: 14528
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 110
> +            num_resource: 32
> +            type: 14528
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 142
> +            num_resource: 21
> +            type: 14528
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 163
> +            num_resource: 21
> +            type: 14528
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 196
> +            num_resource: 28
> +            type: 14528
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 228
> +            num_resource: 28
> +            type: 14528
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 260
> +            num_resource: 28
> +            type: 14528
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 292
> +            num_resource: 28
> +            type: 14528
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 400
> +            num_resource: 4
> +            type: 14528
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 404
> +            num_resource: 4
> +            type: 14528
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 64
> +            type: 16266
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 20480
> +            num_resource: 1024
> +            type: 16269
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 64
> +            type: 16330
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 22528
> +            num_resource: 1024
> +            type: 16333
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 4
> +            type: 16384
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 4
> +            type: 16384
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 4
> +            type: 16384
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 4
> +            type: 16384
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 12
> +            type: 16384
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 28
> +            num_resource: 4
> +            type: 16384
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 4
> +            type: 16384
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 36
> +            num_resource: 4
> +            type: 16384
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 40
> +            num_resource: 4
> +            type: 16384
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 4
> +            type: 16384
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 48
> +            num_resource: 16
> +            type: 16384
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16576
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 423
> +            num_resource: 32
> +            type: 16577
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 455
> +            num_resource: 32
> +            type: 16577
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 487
> +            num_resource: 182
> +            type: 16577
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 669
> +            num_resource: 40
> +            type: 16577
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 709
> +            num_resource: 10
> +            type: 16577
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 719
> +            num_resource: 10
> +            type: 16577
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 729
> +            num_resource: 6
> +            type: 16577
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 735
> +            num_resource: 6
> +            type: 16577
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 878
> +            num_resource: 128
> +            type: 16577
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 1006
> +            num_resource: 10
> +            type: 16577
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 345
> +            num_resource: 6
> +            type: 16578
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 351
> +            num_resource: 0
> +            type: 16578
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 351
> +            num_resource: 2
> +            type: 16578
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 353
> +            num_resource: 2
> +            type: 16578
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 355
> +            num_resource: 6
> +            type: 16578
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 361
> +            num_resource: 1
> +            type: 16578
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 362
> +            num_resource: 1
> +            type: 16578
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 363
> +            num_resource: 1
> +            type: 16578
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 364
> +            num_resource: 2
> +            type: 16578
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 366
> +            num_resource: 2
> +            type: 16578
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 368
> +            num_resource: 22
> +            type: 16578
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 390
> +            num_resource: 6
> +            type: 16578
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 396
> +            num_resource: 4
> +            type: 16578
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 400
> +            num_resource: 4
> +            type: 16578
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 404
> +            num_resource: 12
> +            type: 16578
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 416
> +            num_resource: 1
> +            type: 16578
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 417
> +            num_resource: 2
> +            type: 16578
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 419
> +            num_resource: 2
> +            type: 16578
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 421
> +            num_resource: 2
> +            type: 16578
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 6
> +            type: 16579
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 0
> +            type: 16579
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 2
> +            type: 16579
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 16579
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 6
> +            type: 16579
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 1
> +            type: 16579
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 21
> +            num_resource: 1
> +            type: 16579
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 1
> +            type: 16579
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 2
> +            type: 16579
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 25
> +            num_resource: 2
> +            type: 16579
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 22
> +            type: 16579
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 49
> +            num_resource: 6
> +            type: 16579
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 55
> +            num_resource: 4
> +            type: 16579
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 59
> +            num_resource: 4
> +            type: 16579
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 63
> +            num_resource: 12
> +            type: 16579
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 75
> +            num_resource: 4
> +            type: 16579
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 79
> +            num_resource: 2
> +            type: 16579
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 81
> +            num_resource: 2
> +            type: 16579
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 83
> +            num_resource: 2
> +            type: 16579
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 85
> +            num_resource: 16
> +            type: 16580
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 101
> +            num_resource: 12
> +            type: 16580
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 113
> +            num_resource: 2
> +            type: 16580
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 115
> +            num_resource: 2
> +            type: 16580
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 117
> +            num_resource: 96
> +            type: 16580
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 309
> +            num_resource: 32
> +            type: 16580
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 343
> +            num_resource: 1
> +            type: 16581
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 344
> +            num_resource: 1
> +            type: 16581
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 341
> +            num_resource: 1
> +            type: 16582
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 342
> +            num_resource: 1
> +            type: 16582
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 1
> +            type: 16583
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3
> +            num_resource: 1
> +            type: 16583
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16584
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 1
> +            num_resource: 1
> +            type: 16584
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 5
> +            type: 16586
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 7
> +            num_resource: 1
> +            type: 16586
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 3
> +            type: 16587
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3
> +            num_resource: 2
> +            type: 16587
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 5
> +            num_resource: 3
> +            type: 16587
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 3
> +            type: 16587
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 11
> +            num_resource: 6
> +            type: 16587
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 17
> +            num_resource: 3
> +            type: 16587
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 3
> +            type: 16587
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 3
> +            type: 16587
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 1
> +            type: 16587
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 1
> +            type: 16587
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 28
> +            num_resource: 4
> +            type: 16587
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 82
> +            num_resource: 16
> +            type: 16832
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 98
> +            num_resource: 16
> +            type: 16832
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 114
> +            num_resource: 110
> +            type: 16832
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16833
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 49152
> +            num_resource: 1024
> +            type: 16834
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16835
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 6
> +            type: 16842
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 0
> +            type: 16842
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 2
> +            type: 16842
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 16842
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 6
> +            type: 16842
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 1
> +            type: 16842
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 21
> +            num_resource: 1
> +            type: 16842
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 1
> +            type: 16842
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 2
> +            type: 16842
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 25
> +            num_resource: 2
> +            type: 16842
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 22
> +            type: 16842
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 49
> +            num_resource: 6
> +            type: 16842
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 55
> +            num_resource: 4
> +            type: 16842
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 59
> +            num_resource: 4
> +            type: 16842
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 63
> +            num_resource: 12
> +            type: 16842
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 75
> +            num_resource: 1
> +            type: 16842
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 76
> +            num_resource: 2
> +            type: 16842
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 78
> +            num_resource: 2
> +            type: 16842
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 80
> +            num_resource: 2
> +            type: 16842
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 1
> +            type: 16843
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3
> +            num_resource: 1
> +            type: 16843
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16844
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 1
> +            num_resource: 1
> +            type: 16844
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 6
> +            type: 16845
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 0
> +            type: 16845
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 2
> +            type: 16845
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 16845
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 6
> +            type: 16845
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 1
> +            type: 16845
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 21
> +            num_resource: 1
> +            type: 16845
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 1
> +            type: 16845
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 2
> +            type: 16845
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 25
> +            num_resource: 2
> +            type: 16845
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 22
> +            type: 16845
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 49
> +            num_resource: 6
> +            type: 16845
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 55
> +            num_resource: 4
> +            type: 16845
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 59
> +            num_resource: 4
> +            type: 16845
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 63
> +            num_resource: 12
> +            type: 16845
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 75
> +            num_resource: 4
> +            type: 16845
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 79
> +            num_resource: 2
> +            type: 16845
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 81
> +            num_resource: 2
> +            type: 16845
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 83
> +            num_resource: 2
> +            type: 16845
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 85
> +            num_resource: 16
> +            type: 16846
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 101
> +            num_resource: 12
> +            type: 16846
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 113
> +            num_resource: 2
> +            type: 16846
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 115
> +            num_resource: 2
> +            type: 16846
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 117
> +            num_resource: 96
> +            type: 16846
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 309
> +            num_resource: 32
> +            type: 16846
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 1
> +            type: 16847
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3
> +            num_resource: 1
> +            type: 16847
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 16848
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 1
> +            num_resource: 1
> +            type: 16848
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 86
> +            type: 16970
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 120
> +            num_resource: 32
> +            type: 16970
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 152
> +            num_resource: 12
> +            type: 16970
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 164
> +            num_resource: 12
> +            type: 16970
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 176
> +            num_resource: 28
> +            type: 16970
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 204
> +            num_resource: 8
> +            type: 16970
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 212
> +            num_resource: 12
> +            type: 16970
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 224
> +            num_resource: 12
> +            type: 16970
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 236
> +            num_resource: 20
> +            type: 16970
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 1024
> +            type: 16973
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 1058
> +            num_resource: 512
> +            type: 16973
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 1570
> +            num_resource: 256
> +            type: 16973
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 1826
> +            num_resource: 256
> +            type: 16973
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 2082
> +            num_resource: 512
> +            type: 16973
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 2594
> +            num_resource: 256
> +            type: 16973
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 2850
> +            num_resource: 256
> +            type: 16973
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 3106
> +            num_resource: 256
> +            type: 16973
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 3362
> +            num_resource: 32
> +            type: 16973
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 3394
> +            num_resource: 32
> +            type: 16973
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 3426
> +            num_resource: 1182
> +            type: 16973
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 1536
> +            num_resource: 16
> +            type: 16975
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2048
> +            num_resource: 16
> +            type: 16976
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2560
> +            num_resource: 16
> +            type: 16977
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 3072
> +            num_resource: 32
> +            type: 16978
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 3584
> +            num_resource: 32
> +            type: 16979
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4096
> +            num_resource: 32
> +            type: 16980
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 12
> +            type: 17152
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 36
> +            num_resource: 20
> +            type: 17152
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 1
> +            num_resource: 4
> +            type: 17344
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 5
> +            num_resource: 4
> +            type: 17344
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 9
> +            num_resource: 4
> +            type: 17344
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 4
> +            type: 17344
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 17
> +            num_resource: 16
> +            type: 17344
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 33
> +            num_resource: 4
> +            type: 17344
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 37
> +            num_resource: 4
> +            type: 17344
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 41
> +            num_resource: 4
> +            type: 17344
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 45
> +            num_resource: 4
> +            type: 17344
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 49
> +            num_resource: 4
> +            type: 17344
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 53
> +            num_resource: 11
> +            type: 17344
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 17408
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 96
> +            num_resource: 20
> +            type: 17409
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 116
> +            num_resource: 8
> +            type: 17409
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 124
> +            num_resource: 8
> +            type: 17409
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 132
> +            num_resource: 8
> +            type: 17409
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 140
> +            num_resource: 16
> +            type: 17409
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 156
> +            num_resource: 8
> +            type: 17409
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 164
> +            num_resource: 8
> +            type: 17409
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 172
> +            num_resource: 8
> +            type: 17409
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 180
> +            num_resource: 32
> +            type: 17409
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 212
> +            num_resource: 12
> +            type: 17409
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 224
> +            num_resource: 28
> +            type: 17409
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 50
> +            num_resource: 4
> +            type: 17410
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 54
> +            num_resource: 0
> +            type: 17410
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 54
> +            num_resource: 1
> +            type: 17410
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 55
> +            num_resource: 1
> +            type: 17410
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 56
> +            num_resource: 1
> +            type: 17410
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 57
> +            num_resource: 1
> +            type: 17410
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 58
> +            num_resource: 1
> +            type: 17410
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 59
> +            num_resource: 1
> +            type: 17410
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 60
> +            num_resource: 2
> +            type: 17410
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 62
> +            num_resource: 0
> +            type: 17410
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 62
> +            num_resource: 9
> +            type: 17410
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 71
> +            num_resource: 6
> +            type: 17410
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 77
> +            num_resource: 1
> +            type: 17410
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 78
> +            num_resource: 1
> +            type: 17410
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 79
> +            num_resource: 2
> +            type: 17410
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 81
> +            num_resource: 1
> +            type: 17410
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 82
> +            num_resource: 1
> +            type: 17410
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 83
> +            num_resource: 1
> +            type: 17410
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 84
> +            num_resource: 3
> +            type: 17410
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 87
> +            num_resource: 2
> +            type: 17410
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 89
> +            num_resource: 4
> +            type: 17410
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 4
> +            type: 17411
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 0
> +            type: 17411
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 1
> +            type: 17411
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 7
> +            num_resource: 1
> +            type: 17411
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 1
> +            type: 17411
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 9
> +            num_resource: 1
> +            type: 17411
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 1
> +            type: 17411
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 11
> +            num_resource: 1
> +            type: 17411
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 17411
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 0
> +            type: 17411
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 9
> +            type: 17411
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 6
> +            type: 17411
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 29
> +            num_resource: 1
> +            type: 17411
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 30
> +            num_resource: 1
> +            type: 17411
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 31
> +            num_resource: 2
> +            type: 17411
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 33
> +            num_resource: 1
> +            type: 17411
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 1
> +            type: 17411
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 1
> +            type: 17411
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 36
> +            num_resource: 3
> +            type: 17411
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 39
> +            num_resource: 2
> +            type: 17411
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 41
> +            num_resource: 5
> +            type: 17411
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 48
> +            num_resource: 0
> +            type: 17413
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 48
> +            num_resource: 2
> +            type: 17413
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 0
> +            type: 17415
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 2
> +            type: 17415
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 5
> +            type: 17418
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 7
> +            num_resource: 1
> +            type: 17418
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 3
> +            type: 17419
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3
> +            num_resource: 2
> +            type: 17419
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 5
> +            num_resource: 3
> +            type: 17419
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 3
> +            type: 17419
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 11
> +            num_resource: 3
> +            type: 17419
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 3
> +            type: 17419
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 17
> +            num_resource: 3
> +            type: 17419
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 3
> +            type: 17419
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 3
> +            type: 17419
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 3
> +            type: 17419
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 29
> +            num_resource: 3
> +            type: 17419
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 48
> +            num_resource: 8
> +            type: 17472
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 56
> +            num_resource: 4
> +            type: 17472
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 60
> +            num_resource: 8
> +            type: 17472
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 68
> +            num_resource: 4
> +            type: 17472
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 72
> +            num_resource: 4
> +            type: 17472
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 76
> +            num_resource: 4
> +            type: 17472
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 80
> +            num_resource: 8
> +            type: 17472
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 88
> +            num_resource: 4
> +            type: 17472
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 92
> +            num_resource: 4
> +            type: 17472
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 17473
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 56320
> +            num_resource: 256
> +            type: 17474
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 17475
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 4
> +            type: 17482
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 0
> +            type: 17482
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 1
> +            type: 17482
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 7
> +            num_resource: 1
> +            type: 17482
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 1
> +            type: 17482
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 9
> +            num_resource: 1
> +            type: 17482
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 1
> +            type: 17482
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 11
> +            num_resource: 1
> +            type: 17482
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 17482
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 0
> +            type: 17482
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 9
> +            type: 17482
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 6
> +            type: 17482
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 29
> +            num_resource: 1
> +            type: 17482
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 30
> +            num_resource: 1
> +            type: 17482
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 31
> +            num_resource: 2
> +            type: 17482
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 33
> +            num_resource: 1
> +            type: 17482
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 1
> +            type: 17482
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 1
> +            type: 17482
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 36
> +            num_resource: 3
> +            type: 17482
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 39
> +            num_resource: 2
> +            type: 17482
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 41
> +            num_resource: 4
> +            type: 17482
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 0
> +            type: 17483
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 2
> +            type: 17483
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 4
> +            type: 17485
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 0
> +            type: 17485
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 1
> +            type: 17485
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 7
> +            num_resource: 1
> +            type: 17485
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 8
> +            num_resource: 1
> +            type: 17485
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 9
> +            num_resource: 1
> +            type: 17485
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 1
> +            type: 17485
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 11
> +            num_resource: 1
> +            type: 17485
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 2
> +            type: 17485
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 0
> +            type: 17485
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 9
> +            type: 17485
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 6
> +            type: 17485
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 29
> +            num_resource: 1
> +            type: 17485
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 30
> +            num_resource: 1
> +            type: 17485
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 31
> +            num_resource: 2
> +            type: 17485
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 33
> +            num_resource: 1
> +            type: 17485
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 1
> +            type: 17485
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 1
> +            type: 17485
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 36
> +            num_resource: 3
> +            type: 17485
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 39
> +            num_resource: 2
> +            type: 17485
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 41
> +            num_resource: 5
> +            type: 17485
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 0
> +            type: 17487
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 2
> +            type: 17487
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 32
> +            type: 17610
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 54
> +            num_resource: 16
> +            type: 17610
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 70
> +            num_resource: 8
> +            type: 17610
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 78
> +            num_resource: 8
> +            type: 17610
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 86
> +            num_resource: 24
> +            type: 17610
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 110
> +            num_resource: 8
> +            type: 17610
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 118
> +            num_resource: 16
> +            type: 17610
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 134
> +            num_resource: 16
> +            type: 17610
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 150
> +            num_resource: 64
> +            type: 17610
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 214
> +            num_resource: 4
> +            type: 17610
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 218
> +            num_resource: 38
> +            type: 17610
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 16406
> +            num_resource: 128
> +            type: 17613
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 16534
> +            num_resource: 128
> +            type: 17613
> +            host_id: 13
> +            reserved: 0
> +        -
> +            start_resource: 16662
> +            num_resource: 64
> +            type: 17613
> +            host_id: 21
> +            reserved: 0
> +        -
> +            start_resource: 16726
> +            num_resource: 64
> +            type: 17613
> +            host_id: 23
> +            reserved: 0
> +        -
> +            start_resource: 16790
> +            num_resource: 128
> +            type: 17613
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 16918
> +            num_resource: 128
> +            type: 17613
> +            host_id: 37
> +            reserved: 0
> +        -
> +            start_resource: 17046
> +            num_resource: 128
> +            type: 17613
> +            host_id: 40
> +            reserved: 0
> +        -
> +            start_resource: 17174
> +            num_resource: 128
> +            type: 17613
> +            host_id: 42
> +            reserved: 0
> +        -
> +            start_resource: 17302
> +            num_resource: 256
> +            type: 17613
> +            host_id: 3
> +            reserved: 0
> +        -
> +            start_resource: 17558
> +            num_resource: 64
> +            type: 17613
> +            host_id: 5
> +            reserved: 0
> +        -
> +            start_resource: 17622
> +            num_resource: 298
> +            type: 17613
> +            host_id: 128
> +            reserved: 0
> diff --git a/board/phytec/phycore_am68x/sec-cfg.yaml b/board/phytec/phycore_am68x/sec-cfg.yaml
> new file mode 100644
> index 000000000000..020299186131
> --- /dev/null
> +++ b/board/phytec/phycore_am68x/sec-cfg.yaml
> @@ -0,0 +1,379 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Security management configuration for J721S2
> +#
> +
> +---
> +
> +sec-cfg:
> +    rev:
> +        boardcfg_abi_maj: 0x0
> +        boardcfg_abi_min: 0x1
> +    processor_acl_list:
> +        subhdr:
> +            magic: 0xF1EA
> +            size: 164
> +        proc_acl_entries:
> +            -  # 1
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 2
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 3
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 4
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 5
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 6
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 7
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 8
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 9
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 10
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 11
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 12
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 13
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 14
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 15
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 16
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 17
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 18
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 19
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 20
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 21
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 22
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 23
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 24
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 25
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 26
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 27
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 28
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 29
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 30
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 31
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 32
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +    host_hierarchy:
> +        subhdr:
> +            magic: 0x8D27
> +            size: 68
> +        host_hierarchy_entries:
> +            -  # 1
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 2
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 3
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 4
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 5
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 6
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 7
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 8
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 9
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 10
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 11
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 12
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 13
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 14
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 15
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 16
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 17
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 18
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 19
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 20
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 21
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 22
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 23
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 24
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 25
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 26
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 27
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 28
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 29
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 30
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 31
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 32
> +                host_id: 0
> +                supervisor_host_id: 0
> +    otp_config:
> +        subhdr:
> +            magic: 0x4081
> +            size: 69
> +        otp_entry:
> +            -  # 1
> +                host_id: 0
> +                host_perms: 0
> +            -  # 2
> +                host_id: 0
> +                host_perms: 0
> +            -  # 3
> +                host_id: 0
> +                host_perms: 0
> +            -  # 4
> +                host_id: 0
> +                host_perms: 0
> +            -  # 5
> +                host_id: 0
> +                host_perms: 0
> +            -  # 6
> +                host_id: 0
> +                host_perms: 0
> +            -  # 7
> +                host_id: 0
> +                host_perms: 0
> +            -  # 8
> +                host_id: 0
> +                host_perms: 0
> +            -  # 9
> +                host_id: 0
> +                host_perms: 0
> +            -  # 10
> +                host_id: 0
> +                host_perms: 0
> +            -  # 11
> +                host_id: 0
> +                host_perms: 0
> +            -  # 12
> +                host_id: 0
> +                host_perms: 0
> +            -  # 13
> +                host_id: 0
> +                host_perms: 0
> +            -  # 14
> +                host_id: 0
> +                host_perms: 0
> +            -  # 15
> +                host_id: 0
> +                host_perms: 0
> +            -  # 16
> +                host_id: 0
> +                host_perms: 0
> +            -  # 17
> +                host_id: 0
> +                host_perms: 0
> +            -  # 18
> +                host_id: 0
> +                host_perms: 0
> +            -  # 19
> +                host_id: 0
> +                host_perms: 0
> +            -  # 20
> +                host_id: 0
> +                host_perms: 0
> +            -  # 21
> +                host_id: 0
> +                host_perms: 0
> +            -  # 22
> +                host_id: 0
> +                host_perms: 0
> +            -  # 23
> +                host_id: 0
> +                host_perms: 0
> +            -  # 24
> +                host_id: 0
> +                host_perms: 0
> +            -  # 25
> +                host_id: 0
> +                host_perms: 0
> +            -  # 26
> +                host_id: 0
> +                host_perms: 0
> +            -  # 27
> +                host_id: 0
> +                host_perms: 0
> +            -  # 28
> +                host_id: 0
> +                host_perms: 0
> +            -  # 29
> +                host_id: 0
> +                host_perms: 0
> +            -  # 30
> +                host_id: 0
> +                host_perms: 0
> +            -  # 31
> +                host_id: 0
> +                host_perms: 0
> +            -  # 32
> +                host_id: 0
> +                host_perms: 0
> +        write_host_id: 0
> +    dkek_config:
> +        subhdr:
> +            magic: 0x5170
> +            size: 12
> +        allowed_hosts: [128, 0, 0, 0]
> +        allow_dkek_export_tisci: 0x5A
> +        rsvd: [0, 0, 0]
> +    sa2ul_cfg:
> +        subhdr:
> +            magic: 0x23BE
> +            size: 0
> +        auth_resource_owner: 0
> +        enable_saul_psil_global_config_writes: 0
> +        rsvd: [0, 0]
> +    sec_dbg_config:
> +        subhdr:
> +            magic: 0x42AF
> +            size: 16
> +        allow_jtag_unlock: 0x0
> +        allow_wildcard_unlock: 0x0
> +        allowed_debug_level_rsvd: 0
> +        rsvd: 0
> +        min_cert_rev: 0x0
> +        jtag_unlock_hosts: [0, 0, 0, 0]
> +    sec_handover_cfg:
> +        subhdr:
> +            magic: 0x608F
> +            size: 10
> +        handover_msg_sender: 0
> +        handover_to_host_id: 0
> +        rsvd: [0, 0, 0, 0]
> diff --git a/configs/phycore_am68x_a72_defconfig b/configs/phycore_am68x_a72_defconfig
> new file mode 100644
> index 000000000000..22ad5c3d6eec
> --- /dev/null
> +++ b/configs/phycore_am68x_a72_defconfig
> @@ -0,0 +1,204 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SOC_K3_J721S2=y
> +CONFIG_PHYTEC_SOM_DETECTION=y
> +CONFIG_PHYTEC_SOM_DETECTION_BLOCKS=y
> +CONFIG_TARGET_PHYCORE_AM68X_A72=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_ENV_OFFSET=0x680000
> +CONFIG_ENV_SECT_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_SPL_DM_SPI=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am68-phyboard-izar"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x80a00000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_ENV_OFFSET_REDUND=0x6c0000
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +# CONFIG_PSCI_RESET is not set
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
> +CONFIG_DEFAULT_FDT_FILE="oftree"
> +CONFIG_LOGLEVEL=7
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_SPL_MAX_SIZE=0xc0000
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_MTD=y
> +CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_NOR_SUPPORT=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_DEVICE=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_CMD_BOOTEFI_SELFTEST=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_DFU=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_SMC=y
> +CONFIG_CMD_UBI=y
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_REDUNDANT=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_MMC_DEVICE_INDEX=1
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_DEVICE_REMOVE=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_CLK_CCF=y
> +CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_DM_I2C_GPIO=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_FLASH_SHOW_PROGRESS=0
> +CONFIG_CFI_FLASH=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> +CONFIG_FLASH_CFI_MTD=y
> +CONFIG_SYS_FLASH_CFI=y
> +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_MULTIPLEXER=y
> +CONFIG_MUX_MMIO=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_PHY=y
> +CONFIG_SPL_PHY=y
> +CONFIG_PHY_CADENCE_TORRENT=y
> +CONFIG_PHY_J721E_WIZ=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_SCI_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_CADENCE_QSPI=y
> +CONFIG_HAS_CQSPI_REF_CLK=y
> +CONFIG_CQSPI_REF_CLK=133333333
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_CDNS3=y
> +CONFIG_USB_CDNS3_GADGET=y
> +CONFIG_USB_CDNS3_HOST=y
> +CONFIG_SPL_USB_CDNS3_GADGET=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
> +CONFIG_SPL_DFU=y
> diff --git a/configs/phycore_am68x_r5_defconfig b/configs/phycore_am68x_r5_defconfig
> new file mode 100644
> index 000000000000..e941c340488b
> --- /dev/null
> +++ b/configs/phycore_am68x_r5_defconfig
> @@ -0,0 +1,184 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_F_LEN=0x10000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SOC_K3_J721S2=y
> +CONFIG_K3_EARLY_CONS=y
> +CONFIG_K3_QOS=y
> +CONFIG_TARGET_PHYCORE_AM68X_R5=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c76000
> +CONFIG_SF_DEFAULT_SPEED=25000000
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_DM_GPIO=y
> +CONFIG_SPL_DM_SPI=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am68-r5-phycore-som-4gb"
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_TEXT_BASE=0x41c00000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x41c76000
> +CONFIG_SPL_BSS_MAX_SIZE=0xa000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SIZE_LIMIT=0x80000
> +CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
> +CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
> +CONFIG_USE_BOOTCOMMAND=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
> +CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
> +CONFIG_SPL_MAX_SIZE=0xc0000
> +CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
> +CONFIG_SPL_EARLY_BSS=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
> +CONFIG_SPL_DMA=y
> +CONFIG_CMD_ASKENV=y
> +CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_FS_EXT4=y
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_DM_MAILBOX=y
> +CONFIG_SPL_MTD=y
> +CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_NOR_SUPPORT=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_DEVICE=y
> +# CONFIG_SPL_SPI_FLASH_TINY is not set
> +CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
> +CONFIG_SPL_THERMAL=y
> +CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_DFU=y
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_FAT=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_MULTI_DTB_FIT=y
> +CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_DEVICE_REMOVE=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_CLK_CCF=y
> +CONFIG_SPL_CLK_K3_PLL=y
> +CONFIG_SPL_CLK_K3=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_PCA953X=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> +CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_DM_MAILBOX=y
> +CONFIG_K3_SEC_PROXY=y
> +CONFIG_FS_LOADER=y
> +CONFIG_SPL_FS_LOADER=y
> +CONFIG_K3_AVS0=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_AM654=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_MTD_NOR_FLASH=y
> +CONFIG_FLASH_SHOW_PROGRESS=0
> +CONFIG_CFI_FLASH=y
> +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> +CONFIG_FLASH_CFI_MTD=y
> +CONFIG_SYS_FLASH_CFI=y
> +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_SPL_PINCTRL=y
> +# CONFIG_SPL_PINCTRL_GENERIC is not set
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_TPS65941=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_TPS65941=y
> +CONFIG_K3_SYSTEM_CONTROLLER=y
> +CONFIG_RESET_TI_SCI=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SOC_DEVICE=y
> +CONFIG_SOC_DEVICE_TI_K3=y
> +CONFIG_SOC_TI=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_CADENCE_QSPI=y
> +CONFIG_HAS_CQSPI_REF_CLK=y
> +CONFIG_CQSPI_REF_CLK=133333333
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_TIMER=y
> +CONFIG_SPL_TIMER=y
> +CONFIG_OMAP_TIMER=y
> +CONFIG_USB=y
> +CONFIG_PHYTEC_SOM_DETECTION=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_CDNS3=y
> +CONFIG_USB_CDNS3_GADGET=y
> +CONFIG_SPL_USB_CDNS3_GADGET=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
> +CONFIG_FS_EXT4=y
> +CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_PANIC_HANG=y
> +CONFIG_LIB_RATIONAL=y
> +CONFIG_SPL_LIB_RATIONAL=y
> diff --git a/include/configs/phycore_am68x.h b/include/configs/phycore_am68x.h
> new file mode 100644
> index 000000000000..341c3ff4a315
> --- /dev/null
> +++ b/include/configs/phycore_am68x.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
> +/*
> + * Configuration header file for PHYTEC phyCORE-AM68x
> + *
> + */
> +
> +#ifndef __PHYCORE_AM68X_H
> +#define __PHYCORE_AM68X_H
> +
> +/* DDR Configuration */
> +#define CFG_SYS_SDRAM_BASE		0x80000000
> +
> +/* SPL Loader Configuration */
> +#if defined(CONFIG_TARGET_PHYCORE_AM68X_A72)
> +#define CFG_SYS_UBOOT_BASE              0x50280000
> +/* Image load address in RAM for DFU boot*/
> +#else
> +#define CFG_SYS_UBOOT_BASE              0x50080000
> +#endif
> +
> +#define PHYCORE_AM6XX_FW_NAME_TIBOOT3	u"PHYCORE_AM68X_TIBOOT3"
> +#define PHYCORE_AM6XX_FW_NAME_SPL	u"PHYCORE_AM68X_SPL"
> +#define PHYCORE_AM6XX_FW_NAME_UBOOT	u"PHYCORE_AM68X_UBOOT"
> +
> +#endif /* __PHYCORE_AM62AX_H */

