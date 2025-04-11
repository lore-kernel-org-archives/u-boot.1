Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C624C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7F483EB3;
	Fri, 11 Apr 2025 12:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m7ZKjpmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F3F83FAA; Fri, 11 Apr 2025 12:30:33 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760DB836E7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnB/YBG3RLqY3WbpHKfSgqu9dv0je/FPlQXj9mcfFTQPlfxAwph7cJmdKcCGIEup3ygXOU2y2d4KP9v4T9jU49tZncC+u4FeyaBVFAJR4VXdnEzMQS94CbwuA0rqf87Bz5Dm75QmvMIgGgUISKtI5mQsL7AnFlmUHh4cV8yV9lo2++jQr4l0eQQMAHoa6ODKOaHG1zWZs/4cXn6Q1BnvVTr1yGo5iaspPg1AwNJg/GkNcMBMNt1mbSf1Kn/DIZ5GFrZnRK/0xJywO3PNJoKt9MMTsPyHLqBCGDi2CTdjt5LPpSX2IUKSAipNT3cR1UsO+cR9QYRqNEShWmcx3vjvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YbKovqeAIRRYoIq5+i12gEJCAyfYp0qGmg2yKl9aVU=;
 b=U0Cqy0Hit9FWFdt2Gyy0X+65x+ZessEOfM6Ez5u23FC6AWC58VYXemkbBRnuUcd4fWHjuVd3htrFDql9p+xB4l4fea7cGYWkJ7sbRztnLJe078R3juxdi52akFpyx8HPU5+ur66cVC4h2VNncqMo7amEukI3DvN09+glKxR3s4W1Bw/jYbONxPnpia0Lg8RR/9vU0zQce+04KrkJFLFJ4Kix9Gg8pc5AQdgHUww+mtJTL826IehChDt0bcLgIpS0N8bIxFx9xjDPPnbRpE5kHgHyk9mrtqVAfrHdWT6oz5PzWOmzqBEQP0spwscXgMr8rGDC4dIYvMDm7yLAMq/cKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YbKovqeAIRRYoIq5+i12gEJCAyfYp0qGmg2yKl9aVU=;
 b=m7ZKjpmYNBmsixbJbEahi7ywGH1XIr9xp+1QHHNtBUlTLu1dhq9+SeYr/oRgHhqm9/7u6PfdDwfEr8zJYxHq1+KPlt5M/1viq64EwPNLiLY/KWJk/M4Kg6BGE096yXPaU7pxL/TETEAfqquZzbFnSHYM+Ac6/EItcP76fiplHYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU4PR04MB10623.eurprd04.prod.outlook.com (2603:10a6:10:580::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Fri, 11 Apr
 2025 10:30:28 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 10:30:28 +0000
Message-ID: <cfe39941-8572-457c-b1d2-46723dcc67cb@cherry.de>
Date: Fri, 11 Apr 2025 12:30:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] rockchip: binman: Correct the OS prop for U-Boot
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250410214506.3575404-1-jonas@kwiboo.se>
 <20250410214506.3575404-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250410214506.3575404-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU4PR04MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4d5767-49f1-4d90-fc65-08dd78e3e0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmdUQnBPRHU3T3dLY2VWU2tpQXA4OEdwVFlnQ1h4cTZ6RE55NzByc2U3WE5u?=
 =?utf-8?B?RFdQZmg1azNEdUdjRHJFQ0p0dk9udjkyeFFuTlkrWHlDTDVCamkxQkFqQUFu?=
 =?utf-8?B?aC9Mbmp1VVdiWFIrTUFoNmhNdVNUS0hUNDZzSWdiOENDVTcwbHkxbFpMMHR1?=
 =?utf-8?B?YmVFUHJKQ00xMzJINWtLRVRNd0pOWlpZeHU0ZktFcGxXN0pyMUQvSUdBQlpX?=
 =?utf-8?B?UGxjUFZ3S1VJNjlvUjgrSGp4c2pjZkxmYW1iK21WK0VkMTBna2JPMHdDR0Nq?=
 =?utf-8?B?cG1taWprVTR5bE1PQXdra1YwOHhTVVd0M1R3ZndINzBsYVhHR1dkclJoUGEx?=
 =?utf-8?B?SDZ1V1JxL01oc0FSNTZENWJNbEYwRjdhbGlEdTVLZ0hvd0praDRxb1BoTUs1?=
 =?utf-8?B?a2p6Q1NRek1VWkt1bG03Q3IxWDRLdldtLzAwbTBRZ0hMNm9Xb3ZSQmVmR1I4?=
 =?utf-8?B?clR2NVIwLzY0YXN6di82eFJIa0ZZbUdsbU5OSldvTnBVbkJQSVYwR3JrR3RB?=
 =?utf-8?B?RWRxV2xnd0tvekd3L3ZOMWpZd3hYMGZyclkyd1hqL3BmMk42NWlFYnRQV1VJ?=
 =?utf-8?B?Q2M2bjdZdDFNOWplN25JTG53TnRXZzRHVy9BVGZDKy9pRFo5am5SSlhEZXd4?=
 =?utf-8?B?U3BBc3J3WjZOdm9TTVhwY0Vsa1lmY1dCSm10UGhjbFNmdzFJenRKWlZDL0lT?=
 =?utf-8?B?d0hvUFpVcERQOVJOVUk2clk1MFBiWFFYMWdyb1VYcmk5aXJuWG5zR0JPOVc2?=
 =?utf-8?B?SnUycXhWYjhMM21QOFRzQllHbWZpVE40V3g5aWkwaFN6dnhMWk41dVNWQkph?=
 =?utf-8?B?b0h3cExpOEZkdWFEY0RBTHJCTHBNc1NWRmJMQXFubHFpb1pWUk5vMXhsRDlu?=
 =?utf-8?B?ejZNbjlyZUxBTUV0Q3lhVGhzWWpFTzAzVU9obDNjZ1hXUFpyYm5xa1pUQUFW?=
 =?utf-8?B?ays5TTAwNnNMSVF2V1Y5WmI4OFNCc3NDQ0lrdGVKOGVzYjl3bGhNNnNXcTVN?=
 =?utf-8?B?TFVlbzhjemt6S09GazNJb3pRZWhqNjVKak93MmNOaUdVdTZ5cGZwR3NGbGcv?=
 =?utf-8?B?RjZDd1lBbnltUzhVZmtEalQvb3didTVBVkhPWkJKWm9rYUdkWkJxZy8zMVhk?=
 =?utf-8?B?YkRrcU4wbG1QZlRVU0VjbnJFWEkrRVVpYUNFWmpYY2Q1QVdqR1RMWWUydytF?=
 =?utf-8?B?L2QvczAxdnBvaCsvOHB1UDhoZTZEYW1VNnBsbHNjWWVPNjFtR1BtRkNlajZU?=
 =?utf-8?B?dStMUGdKc2hkUnFpTWdqNzBMZXhBNnVabDE0SnZ0djBrakwyK2trc1RRME9n?=
 =?utf-8?B?VlBJaHJUN09TajlkOGVVRWs4UmYreTNlbHMremJnbzZ6c0F5aktkWHRJeWFP?=
 =?utf-8?B?Z0R5QXlVWnUxSEduWmd2b2I4eFEwVDJ4NG5kRk03aUVZeS9RUmJwTW1FSy80?=
 =?utf-8?B?SkVrcGY1ck50bFBaOVBFSVBVaDBHOVljMDl0NlZ0UXpxbnEyaEluaEpWeWpK?=
 =?utf-8?B?WUZQTEREOFFkcWVoSVlQWjRYcmNtc2taTDU3MzI2Q2hyQmx2dHAvYWNRWnVC?=
 =?utf-8?B?elU5Y0VudFltL21Ock9TM084UmxVQ0RRbWJjaTNyT1pvWHJGYnF2LzVkZWda?=
 =?utf-8?B?YXpkU25Dell4dy81blZVV003SHlVV0p2N2xCUmFsTTF6VUVhb1o5SXp1ekRv?=
 =?utf-8?B?cFd5dzF6WmYyTUZTYndKZmxxUGFBVWx1d0JUOGZLcW5IZWRhbTE5V0JmZE5G?=
 =?utf-8?B?UzBCWVlZY2gwRW9jY2d4cFlQcGk3dm10eEcxVTFvVTVXZTl4djVxSFJDSzhP?=
 =?utf-8?B?R2NocjlvVVV3bkhuUnlsa21ZdDNySXRyYVd4cTVWaUllSDBCZFBzcWhERHN3?=
 =?utf-8?B?TGNLMmNOalpSc3Y1eTRNR2ltUWNxd1VyQVdHQzVzaWhRZWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDIvb2pYOTA3aUdjTVUranJtQUlYMGhHWnBqaXRBT0FOODNYcmNPanVHSXht?=
 =?utf-8?B?WGc2MW5xaXF4WkQ4K2l2N1VoRlhaL3NTdnBRb09ITDl1VHF5ZGVuclZwcVpG?=
 =?utf-8?B?N0FybTgyWHRMR2d5TkorYXNMdzdEbVpWVWorL20yaDhpTTA0NklPT0pXeDZz?=
 =?utf-8?B?TGtjU0pkbVg4OHgvVWxmaG5kUVFaeXowYkl4Q0x4NFVTazdjQjUwK3Z1MXBp?=
 =?utf-8?B?T2h4QnV4c054eWFUdWlkOHNrNW16Q2dMbHFSK0pleXpJY2hIeEIraU0zc1Jy?=
 =?utf-8?B?bDlNQjNtRWwzQ1RxbUpVNFpSL2l4TkRtYWJyekJQZ1NXL2ZDOTJWSHd0dVI3?=
 =?utf-8?B?cExXMkdVaHhRdGJBb1ZKdXZIQjJhMUhlNlRkWk44Z0tnWDZGMS9EVzNRUGhs?=
 =?utf-8?B?L3oyS0VBMzllUjBmWjkwR0xPcG92c0J5WWFOdGY4ZHFzd1dhMk5TM01FOWlS?=
 =?utf-8?B?T2xHSmlHLzRkL0QyLzZOMG40TGdPZGpGenc3dUtNUHNGemNJdEZLRE16akE4?=
 =?utf-8?B?ajBja1Q5MTVKOS9oU2kvY0lHcFBWMjB1SHV6QmVvbWVIWTZwZ2lOQjBQaU44?=
 =?utf-8?B?REFPZ2Urc0hxSUVPRW5VTkZLZWdnR1EzV0c4Q0xtNStGVU9YeldRcUE5cTda?=
 =?utf-8?B?RnJRT2JQMmJwOUNYaDFUb0l0MG10ZTFRQmJYSURNcTJ4Z1phWi90b1NveGt2?=
 =?utf-8?B?eDQxeEdhN0RnbUpacmNsTHVENm1vTFVkVHovdTN2WURRUlo3bFpOanNGcHE4?=
 =?utf-8?B?eVBSc00rM2FKbXBQWTBacDBPbC9mSkFLWFgzSXVyYW9Ua1FvQlVSd0J0TjJ3?=
 =?utf-8?B?YTFvbmkranFwUlVzVUZHN2hhSi84ZzQreGNvOXdIRXVpSkxwa0U2UHNpVW13?=
 =?utf-8?B?V3dMYi9aS3VYckdBQWlEN05YY0w3NlJuQ3ppRWxVMEtZbU44a1JuVVpmWWZ5?=
 =?utf-8?B?Q3V5NFoxRnFURVNkY1dIS1liOThCaEtUVXV6NFpTOW1jUm5PV1ZDR05QOUpo?=
 =?utf-8?B?enBxOWtTS0d5SWdYU1c2b1VHZjV2bjJ1VjQyRVM5Wi94Y0FKMnZ6NVRacGp1?=
 =?utf-8?B?dEgzcFlOY1BSMEJGNnBJRmRndWxBellXaFE4OXZPeW1Lc2tXZHNjV1BQUXFL?=
 =?utf-8?B?UzJTK29mUkxLbHo2clI2aGdlTjlpVTI5TlI1Z3hRcURuZEFQQ2tpWjdOb1Vz?=
 =?utf-8?B?YlRuQ3dyRDduOVA4eFBUMzdXTUhGWkZaOGlHc3JJdTdKM0thVTVpN2R0bHhh?=
 =?utf-8?B?TVBDU3RMVWROSmtJSW9zUHdLcWhIUlBFNUtraXVocG1SU0huN1J1b1JZSDlU?=
 =?utf-8?B?SGwzckptM3RnL0VCNDFJWkFwbGV0eDJkVCttWTFNTFV2eis4Wm1NUjdmbFBR?=
 =?utf-8?B?VUN5M1kvT2N2em53NXl0cG04MjI3ZFpkdDlMWmlKc1ZTbDc4YVFWa0ZSWTUz?=
 =?utf-8?B?b2hMcEdnS1BYOTR4dnJ4aWx4dFduMVAxNnpPcTJZZWVsTkN5VjNkOU5weUFT?=
 =?utf-8?B?VlViY1dWZTV6NjFCYzNpVElkYUthSzBpelhvczBXRE02alpzOVBvalJxQnFN?=
 =?utf-8?B?NGovZDdSRTgveHFPWmRyR1poWTRhUEswQ2E3UDZpcnBpK1lwUCt0Vjd4MW8y?=
 =?utf-8?B?cFJIUnBCV3J0a08vdXRESjV3czVWdnJaR01yUXVmcFYzYzd3MWY5bDRUUlhs?=
 =?utf-8?B?KzFwaGppT1VNYTZMK0MwbTAySDJZOGZCZFowZkV4aDRVMCs1UmFGb2ZJTHV4?=
 =?utf-8?B?ZmIvOXZkWFc5ZTlsYkNCNSsrb1NwSUJLVUtNRldOM3hJdmQyNDBrNDE0TGRV?=
 =?utf-8?B?Tm1qc1FieTJNbkdsYzZDQVJucXlnV0pHWHA4NWJMYTllZ2t1R1NlZHJYS01Y?=
 =?utf-8?B?NFhhR21vQzRMc3Z0TGtic2VwSlcwSCsvVWJ2aTd5M0J4NFFpUGIveWRmWWd6?=
 =?utf-8?B?WllVY0tQa2FPZ0F2SVV3clE4aGFGVjdlMG5wK1BKM2Z2bWE0eEFjRmJ1azhx?=
 =?utf-8?B?Mk12SlVQZnVkRUdGVUZjVGRoaVlYeGdtUW5hVno1cGVQTGlEZXRLWW9adGlC?=
 =?utf-8?B?cHpPdUxsa0RacHdSMXJudG5nU2Jzb1lhVURIRVlsZ2kyZktJOWZycHBPSHJm?=
 =?utf-8?B?MHJKS01MR0ZXOUIrK0hMUmVRWTdPMnpaSCtuMEtaTTFxNnNBc0ZuV1Y0dEI4?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4d5767-49f1-4d90-fc65-08dd78e3e0be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:30:28.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhojb9qRs9Tg7YM39LRW5mkdWuZiSy7TalKqu3IWvrCrSs7lBQJMQvAXXCor8num098phOr6j6nBEV30Micswc7HsOjqe9H2vd/3nbC6uFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10623
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

Hi Jonas,

On 4/10/25 11:44 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> The U-Boot image is currently being identified as an invalid OS in
> spl_fit_image_get_os() due to case sensitive compare.
> 
> Use the correct lower-case value to fix this.
> 
> Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
