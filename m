Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6EDCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 10:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC26808AF;
	Thu, 30 Oct 2025 11:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="khPRmD00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650D18352B; Thu, 30 Oct 2025 11:21:25 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C74800B1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2tCV7cREdfQaiCn43gRwnEBDhW6WcbzwgEkZO+YBRJo2EkdK7yY67uD3R8iJPcmzc/XoHmZod7bhUrAwH0eeD0k1WtlrQuN+EMfovdbQbvxN1yc4F2QmWDgtcwZVrt4e7O+sjA2IIiaVWxCwdocNQQe+gYdtBF+z4UKu6pXb3852ea/yFKyJEqRNzRTUx/Y5IpSKiqCA+zGCavJ9EU6xoLKTDOuyJH3rgi8d/xaHSICK4mojkl7kANWLAMp1tYsz3asVIaDmOMKsytMg7BegHPKMZHueKbsRKuN7d3ARro/ab1DESRDqK85aWIVVZ4QRAImBq2RUkuaLdX8QnIXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HguOK+HbkaPYm2RvyKXOPhqYzg05a9PDU3qm0ZiWoGk=;
 b=g9yTH3uSUowVOVPdMdQh7nHjC9a/llxbal96YumRdB7a1+vtSx5IvqXhv6/lhMMzgdDts1E6Gnc7U7h+DVZ5k6Ol55SnuEyKdo8qOkcE2m7H6ZYKrgxZK4UB/W0w0KLBIAIUEQg/6Ayz5yOm1R9w2rNJcZVusC37PST4wM3HqMxNIU+ecocoAgMrDKeZrpzk1Qt9Csl13G1jgIrWaV9UIfuioOMCH9ydrKVNzH6/j6ZOzBbuugVpC8PNipfrvOIpHJ9vMJW6B8sb3Qn5U125dAFJ7A++4LnM3++HG6u+u8XK86O37oJdwUCSji0Gst+gIGp1MvE9dVSw2nd+fR8Arg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HguOK+HbkaPYm2RvyKXOPhqYzg05a9PDU3qm0ZiWoGk=;
 b=khPRmD00Oa4R6JFdAhn1Lp9bmFeT8kNKJ0ubs+sJunHGvAjDpmjS7nv40bQ1v3WgPJicxNLrI9gT9ev/sElP2NMHFWGAj6cuOl07EpD5q69qnPDUZP4GRGr7vvUCVu6RtyzM/XuSr8D6mn8p3Venm6faYzCbg202hUHJ9qkCMIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 10:21:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 10:21:21 +0000
Message-ID: <320655db-d362-43ba-83ab-d79eb6e58559@cherry.de>
Date: Thu, 30 Oct 2025 11:21:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rsa: always build pss padding
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@csgraf.de>,
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>
References: <20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de>
 <20251029222032.GP6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251029222032.GP6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c5018-d048-45c0-041c-08de179e1220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2lBS1hoUzdLNDlFZ010amN4RDVVZkE5S2trNWRVUWd1cTBtUmhpczQzQjVJ?=
 =?utf-8?B?UDBBWGJkTG5aMkJxekZ3NkRWSkNoK1NPcEhvSTZySGhnWXZNSHNMdVduaGZy?=
 =?utf-8?B?R2Jvc0FYUGhrbHVzZTJ5dGtPUml5YktsV2V2aWZJRkZrbTRxKzJMcGEzaFg3?=
 =?utf-8?B?bDkyVlVyWXk1RFhGbms3WTNib0s0OXRwSEQ0NGhPSmdpR1JoQ1Znb0pSRFVQ?=
 =?utf-8?B?c0JHam5hKytVWFlOZkVRdlIwVi9uQmNPSDhXWVVKSFRKYnV4bXZpend2cEkz?=
 =?utf-8?B?VXIvK0ovUmtlYnFtTU9rYUV4YzVoWTNVbmc1UE40WG14MnRaL1pwb0RVTERZ?=
 =?utf-8?B?RXFVbEVEeFJhc1ZUVmdvaVZrdjl4M2lFa2wvMEpZUkxuUlRLL1J5NUZaR0RU?=
 =?utf-8?B?RnRvU05Jc1FYd0hSbU16YnRZRThPQ05Neks1c3ZmU0QrYVJDeUdBc2QxTmZP?=
 =?utf-8?B?MkdmN0ZlRjVOV1RHZnhKS1BQclpRR2FsTk9laFBuNjVSUWROREkyVGx6STFr?=
 =?utf-8?B?Q29hVEFsSjdrb3NwYzFBcW4xY3R1QytxdzdJanVJdXFvRnRLNW9XVVA2YVlz?=
 =?utf-8?B?WkRCcTUvdHV6V2tPWXFoRGdSQXdpQnJKSFROSGVhdFdMNWMvWkM4cEV3U0tz?=
 =?utf-8?B?NmRsdnhnN0lWc0k0YjM0ejdqM2VuUVJmOTJ4NllqUVFWWWRYSUt3bVVqdnY4?=
 =?utf-8?B?RlJyUlBDV095Szlmai8xQnpTQ0JBSU82SG5NT29GbEJuUlVQR2w1TFhnN1Rp?=
 =?utf-8?B?ZTVHZW9sb1BiQXB5eEVKcVBVZVlOQWpzU1l4YVJnTlpHS3lidURLRXJVZVUz?=
 =?utf-8?B?R3BTMFVhMTRUZG5wUm1qOGc0eUtncFppTGcwZ05rR3Y3bU0rcWJaYUhYNUdV?=
 =?utf-8?B?MmVRSkxweUZKdXU5Si82M25wUkhMYVBpbFY5TFdWZEhZRHZ3NEJSamU3NFFN?=
 =?utf-8?B?RkpYTURRblJDQVdVM3R1RGpiK2xZRXF5aFJnS2FXaHUvVThReVNsM1JlSndp?=
 =?utf-8?B?eGYrd1dkSXB6ZWVybS9ZbHkvRTJocURLMytjV1hHa3N6ZEY1NU9qK29tTEl4?=
 =?utf-8?B?Q1ZaSVpBeGNsNlJqS3pZMC9CbGRNU2tnRGdHbWFqMStuTDlSSFQ1OTQxTEFi?=
 =?utf-8?B?cm9vVTlUODhvdWFnSEZ4U0ZaTWZMOVoxRm11WWN1RmVpSE4vRnVFdnlJZks1?=
 =?utf-8?B?eXRQTVd1TUZrSGE4VG5IZ2hKL01rSG8wWkxWRk80bk5EMndtVytjaGthTnox?=
 =?utf-8?B?YTFtdk1iaDFQNjZGb1o1eWFDbDY2SFUyeWxYN2xmUjQ4cnI4T2I4N25lZFFm?=
 =?utf-8?B?eWJEQVRKNUtyWlpvdnM2OVByc1hXaUVaOUxqaVY0U1A0VmxiWWR6aTZhdFdL?=
 =?utf-8?B?MXIydWRiVkRqUGg4c1lUbExoOHFkdmJqVWxwV2kzU0FuSld2TXBXSmRocitX?=
 =?utf-8?B?OHc5QVdQS0JqckZNL3NVZWI3Yys0UVNJaHZQY0xPekVOTjNQU0lKTjBZcVFS?=
 =?utf-8?B?dUcvKzAwQzQ0QkxENXpyT0N0L1lNYUlFS09EeFpSV0RjVHhjamFiblpFTHFT?=
 =?utf-8?B?aGFickhYSXJXV1FFbWdvNHMvemMzWStmODZSYnN6d0pJT0tOaktwSmkzcEFU?=
 =?utf-8?B?VEx6d1o4RmZnTlJDc2xYamovUzlOcTYvQk9wdzkrbFdrSTREQ1JQM1NxZ3pu?=
 =?utf-8?B?OE9PZmhKMS9ZMmRLVzZzcXN1NmpUbTJQYklqOUVqZVZQb0ZPVzVDdUVOdjJi?=
 =?utf-8?B?RTJmSGxaZklpZk5WQm95UVFSTkZ5Vk1ocmVhUWp6bzhaWEs5a1F6ejl6RnF6?=
 =?utf-8?B?QlFxT3RtRkNRU0Rvbml1T3hKYTFXUXVSMDhjYjB3MGkwOU1FN29rOTJvdndl?=
 =?utf-8?B?TkdwZkxkbHVDWEdEbytxRU41WDh5WnFlY1R0L0FLa3hZeVJpRlQ2VWRiVWJF?=
 =?utf-8?Q?JRSbF1GajA49WKExsJjkTCCXXUiAVPQr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2MxL2hUdzRxckN1OVN1MjROb3lXVHBHWTFETDdEWHhjeUVpOU13c1E5RzZk?=
 =?utf-8?B?ZWVxUXZMUXBuNU9nNERjeXkwTnhuQk1pMjkraXU0UjlQYUxoeC84ektWclAy?=
 =?utf-8?B?SE5jMUZrbzNQSDB5UFFiVlFaL2pTRWRyZnMwZ2R1elFUNkViamRDMittOWt5?=
 =?utf-8?B?ejNaci9sUlRZQU4xd0JYV1ZtWkhLb3ppUjAxY3NkVEVRVTBVTVRGbC8ydGJL?=
 =?utf-8?B?NldZQ3V4cVlFdFpxNmRZL043aHlHalRjWVZoVHozZjAxZVgvY1hTaTNGTDBn?=
 =?utf-8?B?dHhvcnc0TE9hSDBaQ2E2RWQrV0pIL242eHFuYTBiZWx6OUNRenBjNlJ1N2hG?=
 =?utf-8?B?akFMY1ZMZEg3TjFlL3IxeXBkQlBFbVBVSmc2bVpxdTdsYlVhQWdCdnh2L0N2?=
 =?utf-8?B?NlJkajJIOE40b1FFYU9WWjBvTW1oc1pGNXRKTmdlQ20zcTltcVRWc0l3MlRQ?=
 =?utf-8?B?ZHpUczMwYU5ZeVg3bmRyM0Q2Tk5tM2lkM1pHTTdQbjhaaFBuUkhpb2oxa3lN?=
 =?utf-8?B?VWVZZ2htQlFKcU82WDkrc1VLbjg1SzlNN2ZVU2ZlODZTUTBlMkhXd1RibUsr?=
 =?utf-8?B?ZkVhazFTVjc3cTVTblBLeXowcFU1R2VyQjJ1OTJENFpyeEFXYUZpclJoV3k2?=
 =?utf-8?B?Mng3YTBYOFUyMVAyT0FoYThWdVlSalpSQ1FFWU4zOWFiejlLTVV1M1ZxYWpN?=
 =?utf-8?B?bGtqWkJYR2lTMUNPbkwzUWpWamlhNXlnTlFVSFA3TkZELzF1emdWS2lTdnph?=
 =?utf-8?B?eE9CQ1lDVkN5SnhJaDJ0c0wwR3krK0JNNGJLZDFnU3JjWWNqalByL1JaYS9G?=
 =?utf-8?B?QTZuZWErOG0ycURFYU55UEJPM1RjZ2VwQTNNVitmUXMvRU53T3ZyTHV2L1U4?=
 =?utf-8?B?bUFqa0ZoaVUxcUVlUDFyNEdrOXhBTkxqZ2lYdGlRSWQyTHFMQ0plVlZHcWZN?=
 =?utf-8?B?UysrY1hHU1NzV3RGTitPZlRsWWVBeEtOK25FVEZOSnFrd3dpZmRtdGEzcm5s?=
 =?utf-8?B?Q1pNU1lUaVVsYXRXNnZURGI0Rm16dThZN2xMNVVmTWg0MHIwZ1RlNS9lZWJS?=
 =?utf-8?B?VkdWQ2hFRTZ4T3lpam5wWFVIRWVwNFJIQ1dLMkNvM3Y5SG9iWnlLRktqNTFO?=
 =?utf-8?B?UnNyOGlMRXVEUHpUaGEzNDZhVmwrWUJxRTJuQ2xleDVwZGt6dW5KRWhIVmp5?=
 =?utf-8?B?KzBmM3BqTmN5Q2NmYnBqYTczZU1nZlJSamZrVG9ydGRlT1J5UkZFdnBjbDNo?=
 =?utf-8?B?N0Z5ZHNQd1lzeUFidVcvdTA2amIyWHhxb2FBQ2lVdU93RlNoYTJVN0phSTdY?=
 =?utf-8?B?TGtXZEVCVTVWVFo3L29XejdYQ0Nod1Vrd2ljU0xBcy83cE5mQTEwSjlWRGdP?=
 =?utf-8?B?SmczMnNmNUtqOXA2V05VU3ZFK1N1a3huYndMZHVFRjMzQlhJczhORVBXN3JY?=
 =?utf-8?B?K1A0V1N2dElldWlzc0tEalgrL2dCRW5Qb3MrRUdNbFFsNUEyR0VaMUswdVFp?=
 =?utf-8?B?WVliV3FONW90WkNETGhNcEtKdVdQOEU0dENBVWNJeE5QSGlUeWdKdnNzaGFM?=
 =?utf-8?B?MUZJU3NQR1NuM2llTnRuRS9HYlV6b2d3cWh1aFUyWE5nQVpjc21PWkdDdFRt?=
 =?utf-8?B?a2N1a3MxQXI1eFlGaXgvQTBnQ2tibVRtWUNCbDU0djU0eHBUSnNvTXpBRjBU?=
 =?utf-8?B?N1F3N1ZheFBKYk5BKzRIbzI0V05HVy9jRkFPbzNZOU8xUHBacXN5NDFkMUp4?=
 =?utf-8?B?eHE0bzd4ZWlycTJsSkRWei85dVRFc0xyWDBvNGh4eWJKdG5mbDNneWRYdy85?=
 =?utf-8?B?SWdiK3U0d00xUWRkd3JIQWxaclA1UTF3TGVCeFFVK0RncmRpMzVVaVp3bmxw?=
 =?utf-8?B?bkZMRVBTTnB4dFhtMWs3TlYwRTN2Qm9TZU52TEwxNkxOR29XMC83cTNZTzVy?=
 =?utf-8?B?NUpQNWRxR3lkeU9IbGYzUGgwYmJ2aFdiQ2pnM0d3OFFKWUxjOXRUMEF0OG5s?=
 =?utf-8?B?aEtuRkRXUW1KR1VWeVNON3cwV29JcWpxVkxTRHB2eWVDaVBRNGF0R0dNUmNU?=
 =?utf-8?B?WFJ2Q01Tc3QvNHBta0toV09JWTlVd0dKZkE2UVRROUJiNnBldm9GUldUQS9C?=
 =?utf-8?B?Y0p4YjkzUHgzcFNDWHFYbEZVSWRuVHdlbGtoK1pUNG5KK2sxRU9pWW12ZHUv?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c5018-d048-45c0-041c-08de179e1220
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:21:21.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs6FOPqQHH9rRairbRyHpexV+ZCqPmnp+BIV3G10JrNIDeKN6LYhZbuFjdkEunaD3wCQRd5NR+gd5JEEJG0jCEEHENb4+ugBd4cVNRgUFaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8789
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

Hi Tom.

On 10/29/25 11:20 PM, Tom Rini wrote:
> On Wed, Oct 29, 2025 at 12:28:53PM +0100, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> One could very well want to verify signed files which aren't a FIT
>> image (e.g. via rsa_verify_hash() when $(PHASE_)RSA_VERIFY_WITH_PKEY=y)
>> but that is currently only possible if the FIT_SIGNATURE symbol is
>> enabled for the stage this signed file needs to be verified.
>>
>> While we could remove the dependency on FIT_SIGNATURE and find a better
>> name for the symbol, let's simply always build support for PSS padding
>> when RSA is enabled, like we currently do for pkcs-1.5 padding.
>>
>> When $(PHASE_)RSA_VERIFY is enabled on PX30 Ringneck, the difference is
>> an additional 904B for the SPL (spl/u-boot-spl.bin) and 1000B for U-Boot
>> proper (u-boot-nodtb.bin).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Another option is to remove the FIT_SIGNATURE dependency. For context, I
>> have a system where U-Boot proper verifies the signature of a few
>> binaries thanks to rsa_verify_hash() (see CONFIG_RSA_VERIFY_WITH_PKEY)
>> with an embedded public key. We do not use FIT images in proper and I
>> would like to avoid building code we don't use to limit the attack
>> surface, so I was looking at ways to remove the FIT support in proper
>> and this dependency makes it impossible as we use PSS padding.
>>
>> The cost of always building all RSA paddings may be too high though, I
>> don't know where we should draw the line.
> 
> I think the cost of ~900 bytes in SPL for 120 platforms is on the high
> side. How about a different symbol? Or would you want this enabled by

Yeah that was my assumption as well.

I think will go with renaming the symbol to RSASSA_PSS (and 
SPL_RSASSA_PSS) and only make it depend on RSA (and SPL_RSA), then move 
the symbol to lib/rsa/Kconfig.

How does that sound?

I'm not sure to understand why we made PSS padding an option for the 
tools though... I'm thinking about removing the TOOLS_RSASSA_PSS symbol 
and simply always build its support (that is remove the ifdef in 
lib/rsa/rsa-sign.c which is only built for the tools AFAICT). Or maybe 
the intention was to not allow padding with PSS when signing if the 
authentication part cannot validate it (i.e. padding = PSS, tools uses 
the padding, but FIT_RSASSA_PSS=n so cannot authenticate it)?

> default on rockhip and so changing those 120 platforms anyways?

Nothing Rockchip-specific here so not something I'm looking to do :)

Cheers,
Quentin
