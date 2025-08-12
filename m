Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8830AC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 13:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E371B833E1;
	Tue, 12 Aug 2025 15:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f/r9s5Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24E6833FC; Tue, 12 Aug 2025 15:15:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836E883390
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 15:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7uFA5KtDhnCL/jYH6JSwukfl//XyOSSNORP5zaRnApuDyuhBJy36hhw3RZGns6WmkKMAYoICRNnJhYiFH026A1W01t+giwcJWj03blCMkXL2IE9gAT7SLXGTCuhHa0e6yzl/HwafyzPbp+q4mYTFjzNgWeuW3AA6O/H9mZ1QfSRsKWctYL8BkwYycPVqsx5t4+c1y3isAUSUxvQG6eg+9FnLdvtcLmItzNF3mjsSahJYb3xfp7i7Vw7W5jdlZZXjBxRd31ZeycMz0I8xRYB2n5v4+SLRwLC8+8JdVsuT2g6IMoluwADy5IyI0mO1+S+cl8QmWBsjBKlZo/FbYed4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92VtCjmV/ImF+K1BP2c1FITNVGWpZr7VCo9XfWPPdTg=;
 b=sY4f1AlU63Uy5rAhaOr3svCZKsNF9zi2yl2xIjxojCVHKl2uARrOrlRvdDxr5wkJLmKo7j/ULm89jsstArDxvffdOMjZr+NryCcYNYW7JxHRNUON/C4SMusKRVlBe9GlUugKAe9tEQZtz0P44FDi+hwTe88+9NnU6Xq7LkWRopPfpVglkBtqlllBc+FGlBD9lofQaCtdmjKJZo4El6GJ4QTJ06rg8L3vWSyp/4lkqN0S2lJww8GRFFp7gtYoxciaaqKR7MOkylpeYqUNm41ZjJbD+Fm42ME4clIuZqLu5T6JxGuZv/RaYXm+uuHVVf/8k3Cbi3/vyS25H1gohA4BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92VtCjmV/ImF+K1BP2c1FITNVGWpZr7VCo9XfWPPdTg=;
 b=f/r9s5FjXCVm1JRmSBmiQvKHG4LQ6nsE90E8o3pXpl+l2Y+mtJkOIrP54IZTxwI5jNYuognWRlI6h7TJVwOQQV93zjjTcPXsWAHRtVGGh1oNBqwz9PUxoPZDAEBv9snd+mhSoR7k7iyEootUl/0/Q9DFDOtgfJAfnzzIVwBYcPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8294.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 13:15:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 13:15:03 +0000
Message-ID: <8f60f137-0e58-4dd0-9c7b-dd8bce55617d@cherry.de>
Date: Tue, 12 Aug 2025 15:15:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
 <20250730172438.GU1807455@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250730172438.GU1807455@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb293b1-eebd-4500-6b2e-08ddd9a23e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG9qeEJCNHJMUHZRbXpiSHhvWit4bmduNm1WQnROb1Uzc1lwWmRLMlh2eEts?=
 =?utf-8?B?VFVrUWhKV3M4WnFBZjNTTzFGMDdYby9VRVhWQlRuS0dRTmFNR0xUWE1RTmgr?=
 =?utf-8?B?NDFCOXUzdGRob1ZmSmVmZ0ppSitzKzJ0cnNuOG5DbG1sOVY2eGpBRkd4Vk5a?=
 =?utf-8?B?cmU0TXNFT0FXdEdvbS9xbmF2VUZkOUdudVFaN0ZKbGYvTkMybzhFYWc1SmFL?=
 =?utf-8?B?QzF0WTUwWHhLcVVUSDI0OUMxb3FXTU9qRUwrSE1pN1A1RnZ0Q0czMzZkUlN0?=
 =?utf-8?B?UVJBWU1TWGUwS0NTakFaMERWM1Fob1JDTlpwUno5VEpxSzkyUVBrcmVFcytm?=
 =?utf-8?B?ZWVZWUtPVnl0OVlXMkRFTVFBeDN0Lzd2TU1WVmNiTVFNZ2E2QzArY1BiT3JW?=
 =?utf-8?B?OEdqdzl0ajNBeVVwcHRCU1M0clRvSVVrd3B2ZlU2ZkhSRlNyR05yZUxPTWR6?=
 =?utf-8?B?OEEyQ1l1L1F3NzhKenlsZklLUlV5cTEvdFR4ZWd0SG51RFNjYXhtN1dkNjRC?=
 =?utf-8?B?V3ZvaHlJWFlpYzdSUG4yUm5mMVRVanU3U21uM0UvRTFKYU1hTitkTnljRWc1?=
 =?utf-8?B?UXRXc3NjUGlFNUlTdGpWVmZ6TnJVY0xtMzI5V1hhVFZiUXptVnY5dFFJcXZO?=
 =?utf-8?B?cW5YNDdYYXRNbVNwZTNCZ1pVcG1JZUR6TGMwY0hzbmZoQnVNbWlkb25pSmxK?=
 =?utf-8?B?VFJXaUcvUTNHYUhaTDF5ZHhFOHBDREUzTWg5MHlNRk9sVXVIaE5UOVZ6RTQr?=
 =?utf-8?B?b2hFR1pabmFjNG5SV3o3TFl0UlcwbXJUTXhYdG1qNHUyQWpiR1NxUDZ1bHhR?=
 =?utf-8?B?TnlLcTliY3l1QUdoamphNm00aEFaMFJteStCWElhNW5BV2t1cUdaYTFudVVy?=
 =?utf-8?B?djQzcWhqdVRjNS9aT0M4c3FoMzdYUEovbnRmVUxLazdUR0RndzBKR1phdzNW?=
 =?utf-8?B?OWw5d2IybXgyaGtOMkQvYTl2UU5GcWZVbSthdm9FN3ZtTXpzVkhlN25Ga21t?=
 =?utf-8?B?emR0NTVqSnNuazZWVDRMWkR4OWdyUll4OWx5ZUZ3SlZjelprWnc2SWlYVDQ2?=
 =?utf-8?B?dHVzSmJ3RVVqM1czYkk1MXV6RTFHVFBwWndINTlpbEpoUTZGdi8rU01rc3Mv?=
 =?utf-8?B?bHlsZjFyNXBMbm9CWHFPRGlWWXhIVTd2SnQ0K0QrZkFNM0dCWVpQc2RvRk9F?=
 =?utf-8?B?V09Dc2toR1daMWx0NWJHWVdiTnJENlBrZUM4T2Jsbmtjd2Z5ZUEzY1ErVnZP?=
 =?utf-8?B?TjNGRHRLLzVXZ0k2Nm1YVlJURS9ZNFRFajREZmIxMWxTdDNXS3JuMU5zcXhQ?=
 =?utf-8?B?ZHU5WUhYMStpclpwR0Y0VW9ickZvbENnYVRkVjE1ajc5d2NGS29FRytOWXFG?=
 =?utf-8?B?alBUalVWcTRDRkw1cXFQWDFwV0FLNjJ6SVZvcnZwaURNNUcxMG12dG5aTkgz?=
 =?utf-8?B?anlWUUl5d092RldTUDJnSitQU1V5VGFHYTNUOGFwbW8rYWs2UmRRYURUbUJV?=
 =?utf-8?B?dGY5NEQ0NlJ6S0l3dGJXWG43cTMwUDhPM0VlVERBeWpiaUZCZUF5djdZVGZn?=
 =?utf-8?B?NDNZWDRyZGgrdEhPYzdmenJGb3lza3kyOHFTTW52N3BJbEd4M1poSEMzTHNp?=
 =?utf-8?B?dm83M2YyTExzM2dRMjc0ZW1tU0I0YVhWNGdNSFJ0RENNcEFQSm5RY29UWWlY?=
 =?utf-8?B?V2RUaXhEazY0bHRWanRqeWtzbzdaT0hpSHhkR3FMMURHWlBydzFtK21rL0Fs?=
 =?utf-8?B?S0h0UTdRenJ5amhpeUI0UnlVMS83SGdBcnlHcVE2TzMrUXNCUlNlempSS01L?=
 =?utf-8?B?cGNCOStTK1d5NjB6UWo4RzlZQ25jWFFxdFR1MFdlTTlvTzJUeXJUdS9CVnJM?=
 =?utf-8?B?dzVTd2NXR2pQQjVwTkRsTFptOWxXcVZIcGRJU3dZWVp2eGtwVHNHVFdEbUxL?=
 =?utf-8?Q?87E6Vw0o+s4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpoS3lNdDUwc1R4U2c3Ym5VQXcvcDNSdFFiWTFENk9tK1dWQVNoQmpFdW0v?=
 =?utf-8?B?Rm0wV3JBVWZiTVNpanl5ck1HaEMzOW1yU3A3MFI3OXRKU0RrZ2pKRHpNNGtM?=
 =?utf-8?B?Q094N1FkK0tUNGhvVDNDRUVOMU5UczlzRTUvOEtSa01FQkZ4TlhxUTE4QWsv?=
 =?utf-8?B?aUQ5NWNCNC81UXJJZ3Z6dXY0VUhXUGFBcVZTOXp3RXdtdE9OT3JZR3lpeCtO?=
 =?utf-8?B?cU1qcFVOUlZFbXBpZEF3aTFOUENlRUMzRkFid3hFTkRvOFVXdkNNTzg1VlBP?=
 =?utf-8?B?TndKR2cxOEpjMHB4OTUzU0pONEZhYTk0Snp1WEFZN1o3YWVHTUpXUnJia29K?=
 =?utf-8?B?eGdhaVI5YkoyQUcvVnRoYTIraHUzMFNGb25lMTRVL3g4ZFRxMnBPUldIMWpH?=
 =?utf-8?B?dHJqOXJRVzl4ZW5GNVJsanRpbGVWR0NaNzcrQmVlSEtLTXMxTUdZMzdqRk91?=
 =?utf-8?B?LzdiS2xJV0JwNUN6cGw2VjZPWnJscDJ4bGUzaXE5SVRzQmJlOWgvenpOdmNF?=
 =?utf-8?B?aml1eXpuZHBKdmNKWGZGYVlCNmdNV29aV1VCcDc5T3FteHdCU2NJWXh5RWpk?=
 =?utf-8?B?NmRtRHBTTkI4R2NLSXAvcXEwZ3FML3NZdVprQi9EbVBYRXFpYnh1TVZIeTIy?=
 =?utf-8?B?MnM1WW9RYlpWMUdmY0NXQUZBUGhRKzI1dUtPVE9Hd2p4U01OZWVoU1ZjYjla?=
 =?utf-8?B?N0NrUE1PMXFLNUljN1NJTkRaVU9RMHdkUTFEaFVnSkQ0bEpQd2dRRVN2cG1p?=
 =?utf-8?B?emNNVHBYaGRyb01mT0h4bUk0djhJU1VoOVRnYzhWekVBNG1WMFQyekJkWkMw?=
 =?utf-8?B?aThSYXBwYXZvY3hHVUxOWkxoNXVoS2RtaUlMYXBvWktSbEVSZHRLajRvMXJu?=
 =?utf-8?B?dEkwUnMyTC80SHg3b3JrK2Z1cC9KaSt2eFFIL0JIR0U0TTBKUFArRzhQTENx?=
 =?utf-8?B?NERkeDBFV0tvbHQzaS9nMTVCNGM4WjNiRkxoYWJPdjJrR3dna1p1bFRNMjJj?=
 =?utf-8?B?QnNJWkQ1RWo2b0hjN2VXcnl4UGNSSkJJUmE3ZXRiMnBVRGhrRkVMZXZPaThH?=
 =?utf-8?B?dGQvMjlJemNNRUpmaFhNbk1YUktDSURkRGREQnBEV0dKOTc0ZDVSck9DS0RG?=
 =?utf-8?B?NTlNUENWUlhkZW9DazdiK3A1Y0J6VnBWN1ByYkk4OWJ0YjdvbnM1Zkk5RXhD?=
 =?utf-8?B?aFJnaTVYN2FraHdRNnQ2M2w1WWVudyt5SVBXakRpQVBMdDd5R3dCMXVSVEVz?=
 =?utf-8?B?cldPZWpySWcyU0RLMm43QUxjam1qMldtMktEdVFHb3BTRzNpalc3djRTYmE3?=
 =?utf-8?B?WFRZRldOSnRqcmJ0bnQ4WSszeURIZzNTWEczZXdFNzJSSitBRWt1SUxWLzRD?=
 =?utf-8?B?cDA1WGZ3endMUTB5aVNKMkpkNFE0NS9rU21sRUIxQ0o4dGFqWXcrNnlHR2lT?=
 =?utf-8?B?VFRjWmI4ejQ3NUlnaEtvQ21ZRGlyQlNrMGN4cW9HdnlJWXM1K2c0Z2xtdFov?=
 =?utf-8?B?WTk2Nkk0UTFUUXZHL0I5R1NTOG96cXZtbGorczZrR29objBjVU1hR1V3NGY1?=
 =?utf-8?B?Y3FITzlOMTBpUEFNZC9aSEhzS1pNcld0UzVDV1dXWDhacHdKdnBnZ0hCNDMv?=
 =?utf-8?B?b2pZb2hzQ20xbVNzMnA2U2tKNSs1R2JoTG5LYldIL3ZMZ1B6Y0JJYTZkWUh2?=
 =?utf-8?B?V0huYnlsTi96aDBmR0NZWlFzNUltdEUxWXM3Qi9SRmduZERoMDJQQ1NMTmlu?=
 =?utf-8?B?bGQzSnltSHJ2ZktwbnIvRUpKandXWEN5d3JETXlybmM4ajA3SlRJMERReFpy?=
 =?utf-8?B?ZEFNZlBHRGZWamlYQmRRUkswM2ZrRHBBS1V0amhRK1hhVDVLaTk5OEw5WnZp?=
 =?utf-8?B?UFB0UHJidW5hdXNVbHZ6cXBzb0YyVUI0emYwajlQTGdvbURXb2QwS0FxbFgr?=
 =?utf-8?B?VEFDZHJqb2lBRFR5Y2hyb25TRGxVZ0JQWjZiczdSZXJMSVVpMDJURUhIc0RK?=
 =?utf-8?B?QXc3NXFkZFFFN2gvdFB2Y0lNZTU2b09JU3NJNUtTb29YM1NMWkZXbC9PRlZz?=
 =?utf-8?B?bEJNWjE0SktHS0k0Y3Z3ZkQyM3QzY3RBWGYzZXVEb3BrYWFyWW1tUmJMclhP?=
 =?utf-8?B?ZnlLeHplYk5XSElLT1hkZnhqYXgwVHppU2tNeXYra2JpRGhNY09SK0Z6ejV2?=
 =?utf-8?B?eDB5NTI3WkJTQWhXdHZmenJtMmR3QU82REx3TjgxRWNaSHF5c1JUaGxuQ2sx?=
 =?utf-8?B?M1MyZStsWGo2cGF5YnZwQ0wrMUJRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb293b1-eebd-4500-6b2e-08ddd9a23e9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:15:03.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M5WNLCeyT2okph055WwYrLC6D9MJU7L2B9ox9HRY7MO5wY6hZeDO4B7rZ9+XAaGtUORJ5yIT2YwVGaSaV9zfh3yWI6grkOEkmH53SXqzW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8294
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

On 7/30/25 7:24 PM, Tom Rini wrote:
> On Wed, Jul 30, 2025 at 02:03:18PM +0200, Quentin Schulz wrote:
> 
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> U-Boot typically can be loaded from different storage media, such as
>> eMMC, SD card, SPI flash, but also from non-persistent media such as USB
>> (via proprietary protocols loading directly into SRAM, or fastboot, DFU,
>>   etc..), JTAG, ...
>>
>> This information is usually reported by the BootROM via some proprietary
>> mechanism (some specific address in registers/DRAM for example). For
>> Rockchip, that information is stored in a register
>> (BROM_BOOTSOURCE_ID_ADDR).
>>
>> While we already have the information about which medium was used to
>> load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device), this
>> new property represents the medium used to load U-Boot first phase
>> (depending on configuration, can be VPL/TPL/SPL) which absolutely may
>> differ from the one used to load U-Boot proper!
>>
>> It would be useful to know which medium was used to load the first phase
>> of U-Boot, for example to check fallback mechanisms (proper loaded from
>> a different medium than first phase) are actually working.
>>
>> For now, this only applies to Rockchip's U-Boot proper DT but could be
>> applied to the kernel's as well and possibly for other architectures or
>> vendors.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> I have a board (RK3399 Puma) running U-Boot which currently has 9 boot
>> scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR for the
>> next phases; not counting USB loading yet, which would make it a few
>> more). I cannot force the BootROM of this board to select a specific
>> device aside from erasing the other media.
>>
>> The only way to identify which device was used for the first phase is to
>> parse U-Boot first phase console output or add some custom logic for my
>> board. To validate that a new version of the bootloader works, including
>> the fallback mechanisms, I need to make sure the BootROM loads the first
>> phase from the expected device otherwise I may have false positives.
>> This would be useful for automated testing.
>>
>> Patches pending in the devicetree-spec[1] and dt-schema[2], hence the
>> RFC here.
>>
>> [1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v2-1-5a315d9bff26@cherry.de/
>> [2] https://github.com/devicetree-org/dt-schema/pull/169
> 
> I am conceptually fine with the changes, but this needs to have the
> schema side approved first, just for the record.
> 

Now merged in the dt-schema (still no news on the spec side though aside 
from a R-b from Simon 2 months ago). Is that good enough or do we need 
to wait on the spec part too?

Cheers,
Quentin
