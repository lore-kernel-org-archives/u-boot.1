Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBF0CCF2F2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 12:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738EB83015;
	Mon, 19 Jan 2026 13:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oEST9szv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C29F98389A; Mon, 19 Jan 2026 13:17:54 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B703F800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZr5jDXkNUi+9OxtaTdqeahBATz7fSTwr982G5T2qNo1vSfEf/AmeFgqPHbLVPX/sjfxGWyd3Pomb8hzVMMCd33kuD/0GcQ3vC6MLeiYEt+QpoPZ3GRlslAwBHIrqyIFO6Z7YudcMzfUbmt6EJj6b934wUhW8GWw472fX0adEtgOF4DMV0cW+z7Up1XDaRJgsC0Y/FsSIhKs1LK5NLGfp9Mt0uft7C9+0glX5C4mqxKpLJLD7Ho73NPKAgyHMUgGT7g/dDGj7kICHnJxkvPL1xIYBGTPXQOgPfUV+YuJgNQt6VtYFrOiuFd8vc5ySh6jRWRUNSmBZX5t6EA73FY72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Ng7G928wY7WPiq43C2ydsPHTElo7zkWz4/Aw49SWY=;
 b=Lbz9/ZfUm01Ylo4CEjPf5fqagJ2mzqB58NxeCgqHQozigJSuk/2aA7qpL1wvXIBNwk1bFIeB6/wyR4UnO2ywaQilsAOhhGi1lE4p02CYRG65g2z68vo11vI+QCc3LOs7PTQkVvRzcq6C5LFM/9EGhSHkDeLn66qaP+xJYghIb7a9CAB64ndal66L8RFxacVJa3SVmSrdxX5mOamtJN2F2o27yWRSUKRzp+FkmIfm9ZjNAPTw9DvqL5uGRZnsbEveUTDoOheMIe8bLkZGripXFYTp+XYCaozRCbPablxo+X1y2V6Js6SmJ2+HFraR8ZiKWPOZPcqyA6INXvPxUWE3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Ng7G928wY7WPiq43C2ydsPHTElo7zkWz4/Aw49SWY=;
 b=oEST9szv6BW7+eiuSBiunXSREg6npGnvWuRPKotC5CEWb571IcFoOu2ZvfuK3qlwFhB4m36tl+dk57AzoQbjHmkrB2Qkx2NKv6vqrdC1aWdNEldHFHVr+2/u5QcbFVcxFW3HT+1iTkT69uiir3g8Cw2rTmtL7pq7xB7yObxLduU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 12:17:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:17:51 +0000
Message-ID: <553303fb-216c-4f3a-8153-cf2df6b5f4c8@cherry.de>
Date: Mon, 19 Jan 2026 13:17:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] doc: develop: process: Rework the custodian
 feedback section
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260116182335.4081828-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 35019f6c-662e-4aa6-3571-08de5754c41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmZydUQvbm9LdEdjamRhQXVrQUJQc3lXQW16ZkNhSnRMTkF5YnU5U01RY2JX?=
 =?utf-8?B?RWxCc012dGxuMGZUUE12bE92dTNwa1hsUE9kZTYwZUtISzZvbllLeUtLRkx2?=
 =?utf-8?B?MFhIdEdVcVNSNURqUFdKbXdZRW90MkdkZDdMUUVWcXF1d0poZHNjVTF5RnA3?=
 =?utf-8?B?bkJaaDdDU2g0OXdEc2pwUlFsdFVVaE5LclR0VmptR2JzTStUSzdUbU5ibnFT?=
 =?utf-8?B?cC9JMTh3QXZLOE40bzVqdVZ0T0RBazlxOHp2aEhVbk1zNWlvYlFzNDFqbm5U?=
 =?utf-8?B?WHlPRTFzSDEwb09jaVhvS2VMY2ZJL3dBNFg2eWhiLzRtMEhCMWxHSE5YenQ4?=
 =?utf-8?B?ZjJ6b0E5TkRVaVZwSjhHSWZ3L3JPS2JNZWxIemVFVmNHdE5OVzVoeWJES2FZ?=
 =?utf-8?B?dWVTNGpRcGgwamhPL3pZNllHMGtaS1FRd3FvcUxldzIyU2JuNnhDbk1lYVQ5?=
 =?utf-8?B?RFBmTlBpdU5rS2JQMmFWdWVTbVpCOWRXclMyakdzOUZ3WTdXaE9QM3QxcWo0?=
 =?utf-8?B?cWlyaUMyem9YRURkVXpjUys1SmU3T1B4Tks0SXhCeWdlODBQcnBMSkhwRk1h?=
 =?utf-8?B?RHlEK0JnVktPT0MydUQyZkp3dU04YnM5ejhYdTdDNXduU2FQc2xPZlNzZ1d3?=
 =?utf-8?B?UHA0MHdQem5FSUVOSnBHQkRqTllwZWcxMDduNUNhNmpHS2p4YUJtS1lNMW9h?=
 =?utf-8?B?ejF0QndnRFFQR0Y3UGtYOS9qMlNHRTByY3dqUnZ0Zm12Q3J3MjQ2VVVadVgx?=
 =?utf-8?B?YUc3aHhhcTd6R2l1TFplZDc2MTBBUGI4VnpjRGt4S3ZXeHNscDlrd2o4aW03?=
 =?utf-8?B?UXJweklvQm9mTG1SeXhEek8wRjUwdGgwVHlHWXlTamduRTB6V3NZUUwrTWJL?=
 =?utf-8?B?VzFkVjlPMnZocVVCdFZOUmVUdk9ZeWZSZ1JjT3BmSXdtTnphMGhNVE5mYWdy?=
 =?utf-8?B?bFE1UW5OekhSOHVaKytyREEyLzVqRGo1cVFZZW9MQUhibjFPVmZVa09UVDF0?=
 =?utf-8?B?VkF4MUorSE95ZUhycVZPdEYrdWd6SHlSMlRYOWV6V1p5K3FUT3NsL0swUTNN?=
 =?utf-8?B?MzVJQmhhaEoza0dCeVBUY1I0RFZ0Zlk3K0FhOUdPd3grbDRodGlrV1VkMFhD?=
 =?utf-8?B?V0lkM3ZjYTczSWE1emN1ZFRJcW9OTGlra2RsTjlYdzhzSFpneW02UC9RUzg2?=
 =?utf-8?B?SmhnWDlTVVY3QUZWd0R2U3Q0bFVXaGNHdWV1SmJGbkNlTmFVZXlUQjI2U3Ex?=
 =?utf-8?B?YTJ4S2N1b2oyZzlqd0ppN0pvVVN0ekt1UUdXZ05wVDFYcDJ2YjFjRWorWHBz?=
 =?utf-8?B?bGNrY25tSVdyZ2RObThJRHN3Q0d0MTg3SzhrYlpDcDZBWk9TMXdJWTZjRjc1?=
 =?utf-8?B?Z013K1oySDlSOGtkRDBENDg0dmtLTnA0ZkVyUHVHTHZ6d0NSOTVhNzNFaEVz?=
 =?utf-8?B?c055Mm13enRSVjBwUXNuZERBUWZ3VEQ2WDZFdXo2dTJiMHZjd25XVFIrU2pR?=
 =?utf-8?B?clM0ckNwa25PQ0lrMG9zVkZ2RjUwWEJnbFg5cXVoSi9XQVNOZ3FJTGNKOGw5?=
 =?utf-8?B?NkdxTTI4aFpISXg5STY5SEpLNi82VUxOWnk4dmp1QTJ3ZHJGRnlxS0dCelR2?=
 =?utf-8?B?N3hORUNOSUREYmlsTkhWdWtaM2tUOXVCYlBEZGFKT0pFTk43ZVNOc0k4TzJw?=
 =?utf-8?B?TW1wMng0dzc5Z1J3QUF1NW8wU2hqZGZ4SzMzK0dLOHV3ampmWlVCLzkzZzBN?=
 =?utf-8?B?QytJM3dLY2c1SWRXNTVreExOM0tFTnFyWk9hbStGRkRpU2tDS2hOblY5UWZO?=
 =?utf-8?B?V3BXUk1abDQ0K1lMS0ZIcVpFbGZtckw4V05DcHRoZ0NjNmZxaVF0MjVzVUQx?=
 =?utf-8?B?VmJiaU9mck8veFI3cS9EUWIrNU5aZm1HcjNkRTYvM0ZIQVJNc2ozcHJ3QUtZ?=
 =?utf-8?B?SkxsTkZPNzhIT3UvT2k2MjlhZGFhWThDODRMZEgrdFhockUvci80cHRGYzFS?=
 =?utf-8?B?NklNeEJFYmZVakZ6d3ZEdENXWTNOSStrTDBRSVFmTThHb0IvZ0JFQWtTalls?=
 =?utf-8?B?NmtMWThMWnZNbFNEQXIzV0ZlTDh6dC9oNUdBQmJRV0dMVkY4R2REd00zUG1B?=
 =?utf-8?Q?JKfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NTL1pUeVdDUWJGOWhHYjQrTjN0ZEhUeTh6TG4wTmI1WnNOV240d3Y5WERI?=
 =?utf-8?B?ZmZEazVQd2FreGdoWUNUQW5MbFhnamNMR0h4WmMwb3FTUVRkV0Fob0E1UGZ4?=
 =?utf-8?B?bktkQXBoQWhjN1cwLzZDSGdDbVBRUzJISGJMS0xia2ZKVnZGR0s4Z1NJSmVU?=
 =?utf-8?B?alk3UFZQTXZwZlNQS0xnbVhIWkVmdGhSNzd1R01JQ2JiYlZmTnh6cy9YMWw2?=
 =?utf-8?B?Q0NpNVBWR0VTZ3VNZ1plTTNFY3dQS2JrditsUGpqY08zN0hvL09kdzljdGF3?=
 =?utf-8?B?RUJrZXE4ZE5kNnRWaHg2eWZJSUFsSTljbXdIOWVHeWtSbjNIbnRzOUFXWWx6?=
 =?utf-8?B?WUp1VFArVDhwQVRnd3htMldlNkVJN1BTdTRNSEtubzNnSEM0Q0J2ZHI2VS8w?=
 =?utf-8?B?aC84RS9OWDRJRVhscHdyd3U2clRFQUFLTDdhY01KeFIza0R6WGFLcXNhQWR4?=
 =?utf-8?B?R3ZXa1BhUjFLREZSQXFKUEpSVjUzd3QwNCsvZElFN3N5WFZwT1ZsYWNmaWlj?=
 =?utf-8?B?elZQSHo5blRlMG1GMVlFcTNvdE1sMHVML0dlcmpOYS9taThuRzYyTG55dzdV?=
 =?utf-8?B?NTVjamNQSlFydU1ONkxjcVg3RVlNUjk0bUZtMGRrcnFGRW5zc3JtVmtVWkZr?=
 =?utf-8?B?N0pKOUpleGVsWDAzRnRBaEhpMFA2U1UwME1CQWhOVTAzb3ZwTjBYODJMMTBT?=
 =?utf-8?B?WTFJV0dFc1o1MlJDUlkyZjNwd2ZnVVcrbTMrV2xheTdVRWhHOXZ2NUJmQ3pS?=
 =?utf-8?B?a1NVcGNoZC9FTWpmN28xRXQ3SU5md2lBN20yYUtzcFEwVFQweG9MVWFablph?=
 =?utf-8?B?eDJOQXVEQ2NlTzNnU0p3Tml1bVpSd2phQk9xRXRHZVpqazdTRUNyTWNmVGNt?=
 =?utf-8?B?L0w0eUozeUdzVlVpMzVpaS9iRVY3cUpISlFjZDlWRTg4L0tKaVpRcGhqM0ZC?=
 =?utf-8?B?c1V1NWhNM3ZJaU83OFlMbFh6cm5OS0tqVkVBNjJwVDdVMnZ2WXJQc0FwV2RO?=
 =?utf-8?B?RkFVb3B2dlVxMWxWTklrd3UwZlp2RkZ0VmVzVnk4RENUWC9mV01jRHMyWjNu?=
 =?utf-8?B?cnM3T1VGdnBmcWZjS05kdGZuNGtlQWhUL29UUHNEaEhNSEVrQVhkL0lhQVc3?=
 =?utf-8?B?UE9hYjNTYktvcVhhdVY2WEh6UmI2VzZSSUh5aExIc1BodWVSL1o5SE1JaVJl?=
 =?utf-8?B?cDkxR3dXN0IzZ3pseGFGampudkNBaDN1dmJHZkxWMitPR0RLUnR4RVczWmpw?=
 =?utf-8?B?WWx0TWlrU3VkdU9Ray94MmFMdzJMa1VRemZQSXZxWkhkRnRlTEpSUUxZMXJI?=
 =?utf-8?B?U1BrQ3ZXQUgvcHdBaXp0YzkxWllvY1p5U2ZyMDc5bTdQbm9WazVieFlCTFE2?=
 =?utf-8?B?TmhjS2hVM0JqTXN2c3FKRnFBS1hvYkZnTFVBMWc3Zy9kdnhmVS9qdjVjU1BN?=
 =?utf-8?B?UWVyQ3cwUDFITklsS0llaURvS2F5RnMvZFJ0NmNkM0I5N0V0U0thZlNNZXJU?=
 =?utf-8?B?UGJqdkdzcjhReXc2bnd4b0k1RzZyUXpGdUcvcWJZT2FTbUdDN0k2SDZiWjZh?=
 =?utf-8?B?Y1lCdVF1T2VrZVp6bEdneWRmYk1MdnFFZ25ERFJJNkptSld3cklGVThBam45?=
 =?utf-8?B?SktvUUNNUlZDRjVEZTRxSkhCR1NBUERMNGpXZUFXOS92cEQwZmJudGFzNGhP?=
 =?utf-8?B?RjNaQjdyU2NQTElwN2NXblQxZVR6b1YwYktHV0Yrd0VQMEM2WnRObXpnbjVp?=
 =?utf-8?B?WHYrNjNLVkc4a3VGdS9lQmswNURlLzhSZmNSaGxmekN6WlRsODdoQUpVREJX?=
 =?utf-8?B?NkRUTG1pUUM3a0ZBWDk4ZjRMNmxCd0JwMzRQVE16aXFDYTlDN1Z3YURPSlVC?=
 =?utf-8?B?VkcvN1hTZ0NxS1NoWnVlQXZuT1lvaTd1eFdUT3JKNEF2OVUyN1pwVUV6YzB6?=
 =?utf-8?B?NkcxMkRnTE80bU96Z1dzUHJBb285TzJvMi9JdFBRdzI5Q0V4MmR2Y0xVRUsr?=
 =?utf-8?B?cnlxM3FqY1FHcS8vL25NK1BQSkhmZEc0TDVCdytvR2owSEJ1dW1hditKOGxN?=
 =?utf-8?B?bXlwYjhiRkFwYm5ZS3hwNlRXcE1tSENZVlpmY2xVZFNkOXVXRmdBVHR2YXJF?=
 =?utf-8?B?TnZHa1M5dm1KOHduMEs5VEdvYUpkRVdIMjFBaTJISkl5cnJYY2hDdmw4WDFq?=
 =?utf-8?B?RHc1bVBhL1RZc1hnZWFtckg2Q3Y3YUV5Uld6Y2lFMGZxUStmOFo1YU1oL0Zj?=
 =?utf-8?B?RXdWaWlHbkpEWTdKWVNXT2dydjlUWjZ4MHBwZ29QemRKSUZqUHh5c2t0c0VP?=
 =?utf-8?B?MmRtUG9YVUhGUE1kNHM5MHFmY09zNHZNd2tuL3BYamZHT3crNVhDS0dPSmRw?=
 =?utf-8?Q?i5jMjWT9tVeq4c5pvs/7MONlSl35HXZMCG120?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35019f6c-662e-4aa6-3571-08de5754c41e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:17:51.3233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijP3O7PlgguuA2VH8nN8eEYZM4BPAai9RkWSnT/SnRKKzXQx1gpXSThKYCdNRoN837VuXdSSXhwuoenUIBiKDVb5Q8kJQ8P/LS6MIYL61SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437
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

Hi Tom,

On 1/16/26 7:16 PM, Tom Rini wrote:
> Now that we have two items here, rework this slightly to be using bullet
> points, and so easier to expand on.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - New patch.
> ---
>   doc/develop/process.rst | 43 +++++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 81e1aa7e34db..6f5bdd3db957 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -132,27 +132,28 @@ It is their responsibility to pick up patches from the mailing list
>   that fall into their responsibility, and to process these.
>   
>   A very important responsibility of each custodian is to provide
> -feedback to the submitter of a patch about what is going on: if the
> -patch was accepted, or if it was rejected (which exact list of
> -reasons), if it needs to be reworked (with respective review
> -comments). Even a "I have no time now, will look into it later"
> -message is better than nothing. Also, if there are remarks to a
> -patch, these should leave no doubt if they were just comments and the
> -patch will be accepted anyway, or if the patch should be
> -reworked/resubmitted, or if it was rejected. However, if a submitter
> -feels it has been too long since posting their patch and not received
> -any feedback, it is OK to follow-up and ask.
> -
> -Another form of feedback is about applying the patch itself to the
> -source tree.  The custodian is expected to put in a "best effort" if a
> -patch does not apply cleanly, but can be made to apply still. It is up
> -to the custodian to decide how recent of a commit the patch must be
> -against. It is acceptable to request patches against the last officially
> -released version of U-Boot or newer. Of course a custodian can also
> -accept patches against older code. It can be difficult to find the
> -correct balance between putting too much work on the custodian or too
> -much work on an individual submitting a patch when something does not
> -apply cleanly.
> +feedback to the submitter of a patch about what is going on:
> +
> +  * If the patch was accepted, or if it was rejected (which exact list

For another patch as this isn't added/modified by this patch, but wasn't 
"with" meant here instead of "which"?

> +    of reasons), if it needs to be reworked (with respective review
> +    comments). Even a "I have no time now, will look into it later"
> +    message is better than nothing. Also, if there are remarks to a
> +    patch, these should leave no doubt if they were just comments and
> +    the patch will be accepted anyway, or if the patch should be
> +    reworked/resubmitted, or if it was rejected. However, if a submitter
> +    feels it has been too long since posting their patch and not
> +    received any feedback, it is OK to follow-up and ask.
> +
> +  * If the patch itself can still be applied to the tree. The custodian

Ah, the wording I complained about in patch 1 is gone, so i guess you 
can ignore it. I don't think it makes sense to nitpick about something 
that exists for one commit.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
