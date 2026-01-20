Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF6D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F8883A8D;
	Tue, 20 Jan 2026 13:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TYU8ZPLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EA583A91; Tue, 20 Jan 2026 13:48:26 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A4C80B98
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 13:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRIbd0gPBjnGQNyT+LwY2b3imm3OIF1sdyBR6lWimp7ChP8u7Ge6icQo2l3OicCVM1htMoETujJAXbpBGH4mqS9FnPuJwNq7TpiQXMJZlx2BPM4EhE8MC8oXOaRPRcMQOE2crHyR6qRYbyw05eBMm20oLJYEYZw3ay7U2OBxgOYvJP4yIX8up3/RczE9IPiqTGUMJ7g5lr9t+LsyXWmWt1r9LZt8mH6i7O55w/12PlwAIPhtP+Wq6ikokw9fG+F8Ug6Q8s4UlotI3wIN+23GpZ8hbFhaXAs6Tr4HNKsgCFpl1+9ONOGQFwBFfkfVYzVDckR8yOE7EwaP3c+hbWLLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAWRC0HOAMYYY8zsRFJC6nwxD6L7lmlj+ncf73QOPvE=;
 b=pF5DHGDvF7sMQYDJzdATUaYMQGFpnU4m0k7y6VRNpp52vibfuSEvJBlqX/5H1vHFJOTqpqN1XlU6ICbs9aV5FTyUuxbcpkSHarP2SHmSbAPA2+0n5eYIqj+SejrqAPxPXEZRPJMdXuWe7jSflZokpemLDvT/viBXi+FrD/UznnfiI7TRaoEt+SkAtVhuxlyno5wnSovBTpFZ4St2wKrUqA+jzAV9sYhS0n6V+oFUFyrP++K4r2jHdSWoL+aM9KS2jF2SvkJjDxqSKDQt6U6b0/vbB+BVyVT1liVseIZN7tZNGSqAUtAcHVY//n5S/fNZq/ry2pWtJTTuqOfLpW2EUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAWRC0HOAMYYY8zsRFJC6nwxD6L7lmlj+ncf73QOPvE=;
 b=TYU8ZPLNB9nRS192cIP0HjTrIbgbh6Z8HZ98chxB6hJyDDcdpOKuMUtw6qbyu33rULgbc1Y3joPram7bafip92sigZATl8dwh/PG9qid/lWggVUZ2k7+MfBe5ev3/Njgd+2MYuJ8pR+Nw8A6H4Bh3+PjS6SNoD+wdvAH0AdF8AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11820.eurprd04.prod.outlook.com (2603:10a6:800:2ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Tue, 20 Jan
 2026 12:48:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 12:48:20 +0000
Message-ID: <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
Date: Tue, 20 Jan 2026 13:47:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: mem: add function for getting ram size for use in
 scripts
To: Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
 <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: f33c8638-871f-45bf-5993-08de58223077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tld4cW5PUlUwVkluQW5URk5RSHdIVXc3SjRpbXNWNFNzeTRBTGJVb0ZuVFZa?=
 =?utf-8?B?U0JtczRGWHkwMHloUzdTT3k1UW4rU2dCbDF4WldURDFUQ2ZnKzVEbE1TQy9l?=
 =?utf-8?B?cG5LaEF6NUF5aWRRWUxSVWE5bmxnL09ER3d4QzRMMW9UWWRhUDlNTlBINmZL?=
 =?utf-8?B?b1JSREgxQ2hZbnNKU0ZjemVhQjkxMVFiSjFFb0VoRFQyT0t0bStFTW5HcFZG?=
 =?utf-8?B?U09tTCszR1RLbUxwSjNibU12NEFVRTZTQm4wdzIrd2FGQkJyamdSZXNvWVJ4?=
 =?utf-8?B?akpBUTE5VzBJRXNTMGh3NW5OUjlSZWZhcUxJNzVkZzZtTmtoMXp6d2tyb0d2?=
 =?utf-8?B?aGFYWWJ6dURFSXR3bXpRUmsrL01SZG9BaVZsS2tzaGRBVDlYd21hTFlNQ0J1?=
 =?utf-8?B?MHd1SU8rNUFzemJUOEhjNERtS1JWNmo0alZQVUx6WDlkNndkR0lQcUhmd0Uy?=
 =?utf-8?B?YkRMbnZVOW9pK0xWSmk1bHB1bVRkNWN4dTRGSVpVOGUyL0V6SnhZZ3M3RGha?=
 =?utf-8?B?cFRJU3U3Qm5CNzRqRVg4b3BHVW4xbGV6S1ZPdkUyaCtnQm5SY3N1aGZaaFRN?=
 =?utf-8?B?SkZZV0RYSTlCVGF0dmY2d3lJU2Q2cWhrT2NUQVlaMEIzZU5iRTk5NE1GNUhk?=
 =?utf-8?B?dTRHcEpMeEdQWmtWWnhQT2REUG9LZC85eHFxMCtHOUszVk5ETkJMYmlBeWlK?=
 =?utf-8?B?bGlITTRKNmw5cFliSGdRUDNqeWs1Rmt3cjJtTUI2QnBQNC95Tnk0RFdiamQ3?=
 =?utf-8?B?eEpybFJySGV5ZVA1aEhtYXB0WjNWTkd1c1BVK2tJLy9KVDRxTm1PbWZ4M3or?=
 =?utf-8?B?YkZWcEgxNTQvNnJvaXNsbGk4R041VElvR01UZGtPR1puUXpLVlk3TXJsaHlt?=
 =?utf-8?B?WEJEV1NiRE1wZFdSVi9adU1kaTgwM3NhNGhXMUdZa3NIYkVtMUtjc0tTOGNV?=
 =?utf-8?B?YTI0K3JyUkNldEl5RnZGTkdrY1VaUkQ3Zlh3dTA2dDB3ZmlPcmN4VlJjS2J1?=
 =?utf-8?B?OGlSN0V1bzU2dmJ1SFk1bkRKeGV4bWFXQmIwQWNGRVN3Z1Jnbm9EWU84ODBE?=
 =?utf-8?B?U2dGYzdUd0piMW9jR29PMmFpMFBESThWYU9TSDBuZWwwK0NYcFg0TXNydTdC?=
 =?utf-8?B?dnBuU1A3RGhsRW43NlQ3bGFkOTlSUWI3bHo1N2wxd08xZ0NKdzBlRi9QMDVm?=
 =?utf-8?B?ek5mY09HazZGT1JWalpFd2xWd2hNUXk2aGtMM2IwNVB3VmNGTWRkUlR2NjBJ?=
 =?utf-8?B?a1ZKQk1sMi9XdWh0KzBNOWFxTHI1NVZiUG1IUDFSRXd6NzNLbFMvQURVVFNa?=
 =?utf-8?B?TlRNbm1taUFMWkNUTUtQWHdIMnFldnZIOUN5V01ZU0ZHd1lTV1BqenNQUGpE?=
 =?utf-8?B?TFJIdGJveUY4MUsxSStvS1VyMmNPSzV3ZjhyYlRwZzRwQW9Obnp5aWMycjZk?=
 =?utf-8?B?UVVhUkJJZWR0OU82WUZOMHRGbkpnMWhrTVUrN2hqaXc1MTRlRWJyRHZqRXpB?=
 =?utf-8?B?ekRTR0NGUjEvQlJrNUZkRVhQS1gra2x2OVduZklKcncxOFIzZ0p2YjJ2Z1Nn?=
 =?utf-8?B?ZnlwWTNLMFplZWJlZCtHRHQ2eGRrS3E5VUtQWi9GVXA5S3NuQ1FBUlYwODM2?=
 =?utf-8?B?YjdPcEVBWnAyMUJoNUxaWmNOa0l6dXpZQmdVcUJ1V1hzZU1PeDlVVmFhdS9D?=
 =?utf-8?B?TnV4YlVwOTk4dlp4cWhvcklxWTJlaG9YeWZSam1tRU01OUFVT1I3aDNETm5u?=
 =?utf-8?B?THcySEpVcHdXNS9UTmMvUHpYYmtIWVoxZk82YWd3a0laNzlYOFJVa1U1Q25G?=
 =?utf-8?B?dk5scnBGeklpa2ZVK3Rxd3BKbWpsVmpuMG5Qak5WSmJwTmRsRlVwc1d6U3lQ?=
 =?utf-8?B?Tkl2dHByaHVYeVk1MUdrdnFkVERBVUlPeTJsZy96YktXd1FUcExpOG5xMklQ?=
 =?utf-8?B?Vk0waVlRVEZLMnNKbGxrZEdzczJpZVBrdDhjQTFETWRmTkZMbE9PZEw0ZVRa?=
 =?utf-8?B?U0Z6Q3RCQjFPNmpCWVhNeWFucXBtTVBBaEt1eUZKd2tPcWxTZXdIeHA5MElJ?=
 =?utf-8?Q?cs8zA8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1xZU8xUUlJU0N5UjhBV0gxSGhPck8wKy83dEFwc1BpRm55cGphQjNRdnRZ?=
 =?utf-8?B?YUp0SnRRR3NSL3V4dHZQMjMweFRmZjJnMm1NK1JKK3d4V08vVGdoRDR4eGk5?=
 =?utf-8?B?VVFSVGxHTTRzZ1pqaHIxdjR4KzRMZFo5U1RiOWJIVkh3MnJZREU5VVRNRGVn?=
 =?utf-8?B?dEdDZWNQRWgrTW5XTjZQRjZIZ2JmMVFNbExDWTl1U3hsN2NVMWJzd3FXZ3JG?=
 =?utf-8?B?RGREbXh6R29naHM4dHFSVkE3NjZ3WkV0cWIycG05LzhWc1FXVlQyd0wzWjZM?=
 =?utf-8?B?aXhMRFRLa0ZmUk9SS1NuRm96VFpMcWF3Q3lkTWQ0aXRxTHIvc20vc1B0UVk0?=
 =?utf-8?B?RGVGYUpLWC84YndOWGN0UXBuS2d5LzJPT01RVWUyRTBIM0JSanFTY0VnS1JE?=
 =?utf-8?B?SFR2Tk5xVjZYbmNjRk1WaDB5aXF1ODZWV2x1cktlbVRiYkJYVUdQQ2I0ZEph?=
 =?utf-8?B?dkNhQVhSTTkwVWhtaFpsUzArRUY4VlpMaWJ5MTkrRkRqSXliUytub3hTcU1Q?=
 =?utf-8?B?aU5od3pZSkxtTk93VW94Q3IyWlRqMmhuV09KV1oxRXZCRlVBQUhoMG12TTVt?=
 =?utf-8?B?YVQ1UHR5WWNTM1JxTHNrR2NvbzQ4S0dqVEJmTGY1SDBOSDBtWFFJM2hJT3hj?=
 =?utf-8?B?cUpPTXdrSWkvMVNtM3RkaE55ZWtoZ3dxKzlkNlc3L3hZaUVpRENPYkNUcTVm?=
 =?utf-8?B?eUk0b2JyM0k4My9xazZtSzVQc1AxbTRiaGVGNkE5SjNUZE5VYTJXdjhhOGU4?=
 =?utf-8?B?d0pxTms2aFplUm9kV1cwcXNiMnh6UE80RHZ1OHZGUXVQK0JrdW1oSGxKSXRm?=
 =?utf-8?B?VkptL0VCL01mTThWNTVjRnNnSmxEeHRwQk96cXREME5SZElMTE9xeU4yL2Rp?=
 =?utf-8?B?aDRXSVN0ZTJHVklQbzVnUllaZGJEMTR3czVoSDZnQkFqZk13U04xUDVtWTdV?=
 =?utf-8?B?SmFRZTVqNE5mdlhLemkydEJLWjgrMGJUa2E5V29Bb0RaaG1FVTliejcvMGk1?=
 =?utf-8?B?QjVEMVNaTzhzaDIrUlZYNDhnZ0ozZGJDbWFVcmp2VkRmRlhuZkI1bTBTTjdo?=
 =?utf-8?B?YW5TUkdKdHk3UG40TXVDYVFRSjdabE9LbkdVbGsxLzVFajVpQmxMQlprTm9S?=
 =?utf-8?B?empsandEL2FZOU1tdTBGSE9HdUpzbUw4aFRqdTVOZUNJd2JjbFhienpuTUhY?=
 =?utf-8?B?K3VydnRia2loWmdua0doSjJiSFJLUWIrRzVYY2dRLzBlOTdxWm1SZmhsaGcr?=
 =?utf-8?B?VDRvMHRTakxUbWd5cmNIcG91blU5b1dZMVkyOElvK2luSVg0SXU3QUh5Y0hW?=
 =?utf-8?B?SVllV1lJekFHU0l1TnM5c3VTZ2pta0p6RHVpRU54MVQ4aDhUUE03VGQ3ZERm?=
 =?utf-8?B?azVtclVaUmxiQjNaTzQ2bnVycmwxUUh6dGZhQU5WeVNoNXo4SjNtdUVHQU53?=
 =?utf-8?B?OWFPVU1sRS9HTzVVdzFQYzA5UUZxc0dmd1g5SXdWZFcxVTJUMWJ4TGVzbXpV?=
 =?utf-8?B?YzdVT0VGeHhhL0NTVkhqbEMrTVlxSzhEd1ZXNmpoVVd3RlY1dGFlVTF4WFVT?=
 =?utf-8?B?QVRsS3hMTTZVbFc3ZlM4N1dneXZPVG1IVHlta3pnTDZYSWVTUkh5VGpTRSsv?=
 =?utf-8?B?TDFVeDNUcm9HQkkyUVhuM2F6ZEd4MzRXd2JSY2psWXY1MVBEZExlTWMwUmRu?=
 =?utf-8?B?SXNxeUFmcXBPNTJaQWdlWDZyemdPdzV0azF4QTBEUHR0cVJ6MzllTmhDUEwx?=
 =?utf-8?B?NXY4cmxNZVMvQnU1ZFdOYUxhZ2lzYzJsSEFjWTBoN0xJeFJDdWk2K0V2NFBY?=
 =?utf-8?B?ZnQzQTdMbzZYb0l0NVB4SU1uQ0h6eWltR091ZndVVlFSR3NsdW9wdWcxazNY?=
 =?utf-8?B?VENZSGV5K1daaGk3VFlQMzVQeW9lRytLeFpud3V6OGdFQW5hRVJ0c0FvQWpy?=
 =?utf-8?B?K0FWOE51TWtQL3pzS2hCbjBYL0NTU3FTSkNqSHVvMm02SW5vQ3dCeUdXVXVW?=
 =?utf-8?B?Q0ZHUTMzVWZvZGZ3VE1xaklMUnlQTUpiTklwT1B3VkhrRUVjYVh2Kzc4T0FL?=
 =?utf-8?B?WmlNdEk5aE1EajFMNlpOUXdBUVI0VExNNUYxUWJmamNlNVBhUVlDMzRDUWR4?=
 =?utf-8?B?OFJVZzBLUnNzOEpEOG92S1k0cERQbEo0dTZPSnd6U2tNNEZRdFUvU2VOZUQx?=
 =?utf-8?B?QTQvejVTMzRHSlZvb1RHTlJzaS9Hd2UwUCtWd2dOM1ZqbHVJRUozT0lqREhH?=
 =?utf-8?B?REZReVN6K1paS1dvSytWaDI2SkEwNmJZSnpYcG9SMHl4R0l1WXVTZHFuQTRv?=
 =?utf-8?B?V29BVkZubzB5SWJqL01EaWdFUEwzMFJaV2hlQzcrT3J2TFh4WkJoTUZwV3B2?=
 =?utf-8?Q?zfwqt3DLXSVsvrW6GkNiIqgDq5t7B7ZPEtTnJ?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f33c8638-871f-45bf-5993-08de58223077
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 12:48:19.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu9nUIK4km0AedIG6KQIij36vN/Vz+7WZmtc01JqFdZ4fz7tk8t0NqlP31oJ8+oyCcCLqMI/JRV9gMHViFvGyIzSEmHiVwQ6b6rHNs82f/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11820
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

Hi Frank,

On 1/20/26 1:09 PM, Frank Wunderlich wrote:
> Hi
> 
> Thank you for your review
> 
> Am 19. Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin.schulz@cherry.de>:
>> Hi Frank,
>>
>> On 1/18/26 11:50 AM, Frank Wunderlich wrote:

[...]

>> Otherwise I see a few issues:
>> - rounding not made explicit, (also it's truncating and not rounding I believe here?). Why not print the actual value here as a float (of course, not using floats)? I vaguely remember some of my Rockchip board printing 1.5GiB when booting up (cannot verify because this happens due to a bug in the SDRAM init and isn't easily reproducible). We do have some boards with 256, 512MiB of RAM so we should be clear whether we are printing 0 or 0.25 since that will influence how to do math operations with the variable containing the value.
> 
> I have dropped my previous round because it leads to wrong values and i wanted to avoid floating point numbers. But yes 2 decimal digits seem to be needed to give correct output. I guess var is then string,not any floating point type.
> 
> So for GB sonething like this:
> 
> u64 ram_gb_x100 = GB_X100(gd->ram_size);
> char buf[16];
> 
> snprintf(buf, sizeof(buf), "%llu.%02llu",
>           ram_gb_x100 / 100,
>           ram_gb_x100 % 100);
> 
> env_set("ram_size_gb", buf);
> 

I believe we should be using GiB and MiB, so multiples of 1024, which 
makes the part after the dot more cumbersome to calculate.

Likely something like

gib_per = (gd->ram_size % SZ_1G) * 1000 / 1024
gib = gd->ram_size / SZ_1G

This should give us

250
1

for 1280MiB for example (1.250GiB). Still.. that would truncate at the 
MiB level (but is there really DRAM chips which aren't multiples of 
1MiB???).

I'm not sure this is worth it, especially since that would make the 
variable a string and I don't think string comparisons are appropriate 
for comparing two numbers :)

We just need to make it explicit that the value is truncated.

>> - what if I want to save the byte size in a variable? With the current implementation, only mebibyte or gibibyte sizes can be stored. I would suggest to argc-- if m or g is passed, and then compare against argc > 1 in which case you'd use this third (in case m or g is passed) or second (if they aren't) argument to store the value.
> 
> Good idea, thinking about how to implement this the correct way :) as varname could be "g" or "b" too.
> 

You could also force the use of the first argument to be able to dump to 
a variable.

memsize
memsize b|m|g [varname]

memsize would be an alias to memsize b.
memsize b var stores the byte size in var.
memsize m var stores the (truncated) mebibyte size in var.
memsize g var stores the (truncated) gibibyte size in var.

You could also decide the prefix your size argument with a dash and if 
no argument with a dash is passed, it means it's a variable name and the 
default is in byte size.

>> - missing documentation on the base for the environment variable. We have some commands setting hex digits in variables, some others in decimal, so this needs to be made explicit so that people know if they need to translate stuff before using it (or how to compare two numbers against each other). Here it's decimal according to the code (maybe we should have it in hex instead? I am not sure what is the expected base for variables :/).
> 
> As i want to use it in scripts to choose correct bl2 file for bananapi r4. Imho decimal is better to read here,but it should be mentioned in doc.
> 

OK. Considering test 
(https://docs.u-boot.org/en/latest/usage/cmd/test.html#numbers) compares 
numbers assuming they're decimal if they don't start with 0x, this is 
fine to do (we would need to prefix the number with 0x if we were to 
store it as an hex value).

Can you tell us more about the initial issue and how you plan on fixing 
it here?

That sounds like a board file (board/....) would be potentially more 
appropriate for this? What is this bl2, why does it need to be different 
based on DRAM size, isn't there anyway for U-boot to pass the DRAM size 
to bl2 and only have one bl2 binary for example?

>>> +
>>> +	return 0;
>>> +}
>>> +#endif /* CONFIG_CMD_MEMSIZE */
>>> +
>>>    #ifdef CONFIG_CMD_MEMTEST
>>>    static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
>>>    			  volatile ulong *dummy)
>>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>>    );
>>>    #endif /* CONFIG_LOOPW */
>>>    +#ifdef CONFIG_CMD_MEMSIZE
>>> +U_BOOT_CMD(
>>> +	msize,	3,	1,	do_mem_size,
>>> +	"get detected ram size, optional set env variable with value",
>>> +	"[m, g] [envvar]"
>>
>> Explain m and g so the user knows when typing help msize.
>>
>> We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this new command.
> 
> I see this note in checkpatch,but as i rely on dynamic value and i saw no test for mem yet.
> 

There's one for meminfo, but honestly I'm not sure it's a test that 
makes sense (just checking whether some fixed strings are printed and 
not associated values that are printed afterwards). I haven't written a 
C unit test in U-Boot so far so won't be able to help there. But we 
really do want docs in doc/usage/cmd for any new command.

Cheers,
Quentin
