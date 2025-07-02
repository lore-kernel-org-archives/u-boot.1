Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBD4C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 14:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4B380E9A;
	Wed,  2 Jul 2025 16:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="k+xXwovR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D6081FEE; Wed,  2 Jul 2025 16:47:59 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FDC2800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 16:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHggLmSP5RptLHpOIRON3JNvpgjP1rXvYJB4FdeZefcsDvfNN/eYKAF+d++2V0Hs0sAdUB6NHGsDUu8YfcBshfT2G2QWuMKY0BKLl9mZEQRIHbhKMB2LXQiuDt0QWx9+nVPV5rYHguA98nhBfM60IdTu8/wA97OGzYI0kOdSfnFBeJJ7eRRQXMhElE4snoGBJJAcOISpThoQwd7x52pjVLkn9k7VHfWGMvx+/OTuTJ5PM0GgCf5OOdSB7yfrRJ0W/OJCfUoQ9hFLe3zfSb74is3/zt4TmS9tj1Q8FHs+yr6zPYYcf4AWwUwHWNtclGH4owNeYZ//KhA/GEbcWiXxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIRLTEA+FnT/v+Nwewvn9PzMYsBA9Fx2anuCF4mKsyw=;
 b=mBk7pqt23xaA0p5drm/RHGyVkkAp1bpQ+k2YawjbgCphtCf+m9qpjvmDMy7/Df6rFGG/95At7gjTkI49/f8VkxajwWGsRATab2kQWw5PRpm4ueh16YSKBBdupKP18K159f5HBTlEzJS9Y5tyjwQJWSnbmoS1L+XjjSSLnYPu7Cq+UQoPCMMY1gEikHU07QVmD5PStmmhZzFhF4USS01w5WHzL6q5jsr/jlfNjatI0/OZrtaKwpfr4VLwXSwlJ9ALTaoP0Btd2VfZieD/4I5lRXdi4iO3B1Wf/GYD6VN7X/a34AqJBldwBZZvROm1eFsPqZ4axhPez3LrUj321FAFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIRLTEA+FnT/v+Nwewvn9PzMYsBA9Fx2anuCF4mKsyw=;
 b=k+xXwovRANqcgkpccspROvf6excOZTefg5YX9W0D573Jp4DoyuM/zcrqeZk/orq+vihcLb+avaDwZkD4ZDOZmbw9crig0NKI8x7kaWj7omIynX8ov+We/Xoyzipta9kn9omeDY6rskX2UKB4ABywullwizW0NwH4Av3y68tnJ7LNoF/T0o6yZN1VbLNjkZgbhn6DnbE5vHnLCpj0Ote39Aj4HmKHKZ6wJeabTJMd45ZqR5Ew+hsvEkJzYe5lL+yYhZxjKeuY/RITKuNGApqEhq1f3bqe76AGNbQYVzz9JLu471H38j1hvrrXSPabbs/6MNCxJj3mhrobQnzmhc8cVQ==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by SI2PR02MB5489.apcprd02.prod.outlook.com (2603:1096:4:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 14:47:52 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 14:47:51 +0000
Message-ID: <SEYPR02MB5557A4D1B6B8249763D646439640A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Wed, 2 Jul 2025 22:47:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <dc4a7b0c-b4d6-48ad-bf2f-6df7e156a626@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|SI2PR02MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 286ea6ab-5623-47cc-925a-08ddb9776aeb
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicDXqI5EYWVMcktdevbVaYD2hWi4hlMqiiZn8irFvVSZzr8ogbmWB7m82N7FBi9RKjlfyh71dLjcVolUPPhUR3WtZROYIvVpoIJQRG/iiEOXIINtJLo5YejFbeAhzWFFSiWe2uhPTOeyJeBDbuL4Pw5RFHOvP5frITAdfdZEnNIsDOZ/LsImkJU3ryUXy0/4GLWN9O8xUBkl2o/qHqQN50qSIXyzm362wsIo6ZvLu/4tlkH6lSk0CvfBy8FCBb8Z827bmA7wb+/0fnhnI7F7kGbGuoHX8nofAggcZ5xUgULBkOQ0Wejyfx+Ys6o0OTHbJRgc3h7qEts/ma0I+1tVyat1Lxj1sPh0RPbvGlpxiI/lGWXsNei+BVymZOfX4z5dnfhJR2F7Vp7+dlZWeRF3HN0qSy02zQq/bfiI90TDeZuwLH2lHkhCnovvatKItHqz8AOVzqdGRBDHOYcune1Hl7893N/EbzrLp+ZJT/OchOtjccR+CB6aZcCbhQmCwAfoW1va/SnUkdqo/gQZhVnukCCBo9LFSb6wCrqdt7OMetYuJlK72DUnJ66YTOZVYbDTIvaBiPCR/A0XpwxHkVBQ1L7Fsts2zMceruPlx25FWhLM8Y5TgS9Ix2C/UL6wBxOCHA47BOm2sRzVVc6/y+4eQ2hC+wNOysBaYGjwb3MdBhC/h4o1sJu28K6Voobr0+MNrFF4h40TrsfdeLfM+t6X7ZJ9t3Cap5otYBxF3dLtV13EoQ==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|8060799009|19110799006|15080799009|461199028|5072599009|440099028|3412199025|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnZPamNad2ROcVA5c3RrTGVrNWVnWGFGaVBBME5mSmw3RmpGU0pPMEJwQXhM?=
 =?utf-8?B?ZTNvTVJGN0NOcnlWZkc0VHZKRnhXd0NJcldNcm1MVkNkeWZrTFlINU90OFRL?=
 =?utf-8?B?QmUzTnlTd1RVR3hFM0xJNjl4TCswYTRwRmVxQmFIL0QrZURUdTFRMlNTaHE5?=
 =?utf-8?B?aXJEdE1TUWZjM3RuSlpNTmpSc1h5YjM5V1ZRdTBrTVJIdlJ0ditsZ1dyVlZZ?=
 =?utf-8?B?cG14YmFRVHdYTFZyN2hPdW5vQ0cvb0VMcWhKSCsxUjZvd3RJeTMxU2VhR3dk?=
 =?utf-8?B?RktJOWQxMFgrdFo5NFVrQXVhZkNqZTFHSDBaQlk0VkZvcUFqV0JXY254bkZq?=
 =?utf-8?B?UG5CbjNvY0g5UXZJRWFVQXFLTVQxcCtHUzk4UlUrUytFd1hlYk5hZ2JrYWFa?=
 =?utf-8?B?aERwRkI1TUNwRmxBU0ZHVml3c3hneG1vMmdUL3pDNzh0aWVrOXlUY0huamVp?=
 =?utf-8?B?OEZyRHM3R3B3SVJ5NnlTeTVxaDRucGxqR1lhZ1QvSmdSWXQyZU5Cakhod1Iy?=
 =?utf-8?B?VUQ5b1Q4bXllNFRaNUdYdkhqQUI2d2FxWVMzcTBTZ2FOajJqVGtGclVESGQz?=
 =?utf-8?B?VXYrRDdMaWVxM01OaExKdW90WHJwVzhCT28rVmR2UWN4NXlWeEJIYjZ5c1l0?=
 =?utf-8?B?QWNUVDFveW50Q0FudXBpK3V6ek03WTFnSzRTbHNoNXllRDNMUmVsN3JwbWc3?=
 =?utf-8?B?eHp4YjNhRTBxTkcxdWlVVDhBRStMby9lVmJCU1hIejFMbk1WejE1YUs5TEtm?=
 =?utf-8?B?MjI5czJzSlMrWU9SaTUxWGV6bDR5bkd2K3UwUVdUcHZGMDRFMnBXR241SWJS?=
 =?utf-8?B?OWE4aXl1ZTNpSUM2ekpvMEVQN0l5RnlzaTc2Z29GS3FCSmVEdWQ3VTBieFBp?=
 =?utf-8?B?SFd5dW1uZ1QrcVBKa2xOZjZHZHoyMDFuTjlkdGdOODlSZlZ2TmthNzYrWUpU?=
 =?utf-8?B?L05LTElodVltS01pcEtYNXc5ZEhNRjNBc09wMEJEcEJHL3UxNi8yL1pPaHZ6?=
 =?utf-8?B?aEpTMDNJd3MwRUxiYmhweEpJZWNpMG93TUU5Q2N1OWpWM014N0k5dS9HTnJj?=
 =?utf-8?B?OUN5aTNWY1pDamhsd3dTcU5HcVZPRzNDVzlHSjRNWThzMmFxL2FSdk4wV3li?=
 =?utf-8?B?djhVakZ3L1lqNnFzeno0NUhwWGdpYy90c01FL1dNbytweWNhR2UxcEZUa0ZG?=
 =?utf-8?B?UkcwY2cwdEI2N1ljRXR1MlpJaUFiTzR1UXFGcVZ0VDRXQjRJRTNyakdzU3Az?=
 =?utf-8?B?QlVzNWxuMXcrbGVNWmxpN1daTEw2QjkyejVrZWVQMkw0ZHUzZWhUTGNTc0NH?=
 =?utf-8?B?bUNxaFU3WDUrNmk0QW9MZVptM2NKZjhwdmsvV1FoM29nSDQwSVRrSkpKdE5j?=
 =?utf-8?B?dHkvbmlxTUhJQ3NPdDlVbmtSTk1KcVVwUFdjSVNpWVhtWDcySnpRWVhjeXBR?=
 =?utf-8?B?REZxbWFBOWc1anlRVEVaNDhpR2FPM3VzaU9tVVN1SDBSa09YQy8xRzQ2QjBM?=
 =?utf-8?B?dXlUenBqN2dqUU4yKzZVWXhBWTJsNnAyTkttYmVMb2ZCb1Nwc1JUTExCZWtW?=
 =?utf-8?Q?NSxkECOWp/o+9lbaJ0TPcRm7U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVPeUJjRkpYQlo3T0diWFM2YzJkdXQ5OHFtR0NyOHNWVzhsQUM0cjFXL3Vx?=
 =?utf-8?B?UXhmRzNUZmR1SHlicnozcS9JYWxLSTYyNnNncHpsTzFiVUJ1LzZJN3BQUWdE?=
 =?utf-8?B?NDU2Y215K2grMUJSTHlZbVlzWXFyQWVyZGxJVU5SQWpOQmNFNTJWeGUybDNX?=
 =?utf-8?B?c0pnZEVJTW1PdVg3UDR3QmNHdFNMNWVCMU1pY1B0R29HZjR6K3RvRkJ4TUJo?=
 =?utf-8?B?WTBXOGRkN1hJYVdDU3lsUzczbDc2VjlsUjNKNyt2aElaaE5EQzlMMElub3Bo?=
 =?utf-8?B?a1cxcEJ4R09HbmRocE90Qk4rbitCVnkxbjZiVWd2Sis5SDVSRWthNVFZSjBJ?=
 =?utf-8?B?M0MxK0hkd3FhR0k1M0R4TElUMEFuNnUrZG55ZnVLK0I3SDBHQTdGb21TeGgy?=
 =?utf-8?B?SExhR0gyYkdvaUVuQXM3QWJZMUtlZTBWNFZQTmhPWGZOODh5MUJLb2Fsb2lp?=
 =?utf-8?B?NTJQdmZJTnMrMDFYZ2hCeTVIMzJTSDVuUHlscU81bFlkSWZ5bzFMQTVtTGJl?=
 =?utf-8?B?NXhmOWdKaG4wd2ZVem1IZGcxSis4S2J6aDJCN3hIY2YvREJ2L2dVTGZ5WXY1?=
 =?utf-8?B?c2JscXRYV0pBR2ZCU25BRlFhZldCV25KZjJYaUI2cWZncTF4eHJ5RGoybkpU?=
 =?utf-8?B?T3RDdFhIU0REblRWdCtxNXpUMlhuLzdaRUJSWkFWMFFoYVZ5ZTljNGFkdmZV?=
 =?utf-8?B?S0ZqZWltM1pETXI4b1g2RXlQTWxzQWtKNVYxSWlOYnJzeXV2cnlLSURPNDZC?=
 =?utf-8?B?K1ZBdzdFaU5aNjh0QWV4R3BTNmk0OGRQUGZLaGZHbHUycUJXdEVHMGdYVnN5?=
 =?utf-8?B?S043czVWSnFRaDd3ajJpdnY1QmZmWUNOUElqTkZ2NFBBRWdtTHFlZVA2bVJV?=
 =?utf-8?B?VnRVVmpzcEFtQ0cyVGJEZmtCdThNWndydmlHWDgyOGdZNVYzYWIvclVkUUhD?=
 =?utf-8?B?YStHUU9Sa2FyOHBJbTVwOVd4TC9OeEpDdDlSOTBiUkJDUXprd0xHM05uN2NG?=
 =?utf-8?B?MlFHV0RlQ2JGZkdweDU0aUNiQm5nNll1d1pJeXlSRjliWUJudHdsSzN5ekNC?=
 =?utf-8?B?enh2NU96YllkdHhITkRFWXVSVDRCTlNjQnlMRkIwSDNGL0NGZW9mWHE3TmZK?=
 =?utf-8?B?d0p2MjBUYjNKeHV1dnFZb2x6OHRMWk1Yb29aSGZPL0hITUV6dUZHQVVNMW4v?=
 =?utf-8?B?UmZBY0NwZS9MV2NJVlZhN2pJUTgxMlRWZHR2ZEluL05DNnR1NnB0SGU2Tllh?=
 =?utf-8?B?TDZaYWcwL084cmtOV2VZNjRnRXFjaDlTZEZSaUNJTW90MW5DZHdZYnlTVDdx?=
 =?utf-8?B?UXAzN2o5WVZjVmhITWJVeWFWU05HQ2JYM0RVRW43cVE3dytwQVl4WnZ5Q0cx?=
 =?utf-8?B?b1NlZlROb1FxdUhVT3pEVlkvOXFOQWtOdGNYQlQ0T3BaWk9pemg5b2FHYStL?=
 =?utf-8?B?MHlVOElxZy9Pc3NrNEdVaVlQd3BjNXYzNTI2Y044NnlPMXdwZVVNNlArYitL?=
 =?utf-8?B?TjhkNmdkbEV6cUhLU1lVM3o0dlp3R3JWb3hXUzdFVzJsSWlUNnE1aVB1ZC9k?=
 =?utf-8?B?VU1wL3pnVEJWS2g5U3N5WDZDT2ZtWU5QbzVVUk1lRGxET3ZQNjZGYTlSei9s?=
 =?utf-8?B?cTVlKzl3UGJId1kxNmVheGdRTzZMcVM3SW83bjJkeWRBeUVUcUtRUXJNRkJq?=
 =?utf-8?B?RkZyMjJ2ZUtIcllpVVhwSGtnWmRIaFd4MDR5N21TRjExS3NwbXo4Q0RTSmRI?=
 =?utf-8?Q?el17m2yj+zMXuc+M8hT+/YIfIq4sev1LoKHSGx6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286ea6ab-5623-47cc-925a-08ddb9776aeb
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:47:51.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5489
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

On 6/21/2025 6:54 PM, Yang Xiwen via B4 Relay wrote:
> Currently U-Boot clk framework mandates the sequence of registering clks
> to begin from root, and then its children. This is an addtional
> requirement that doesn't exist in Linux kernel, which makes clk driver
> porting more difficult.
>
> Let's handle this entirely in clk framework and give driver the freedom
> to register clocks in any order.
>
> This is done by assigning the parent "lazily". It will cache the parent
> name in the core clk struct and try to refresh it when clk consumers
> call clk_get_parent(). It's transparent to clk consumers as long as they
> only use APIs provided by clk framework.
>
> I've ran `ut dm clk*` and verified these commits does not break any
> existing testcases. Though no new testcase is added because I think
> existing testcases already test the logic very well.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Yang Xiwen (3):
>        drivers: core: device: set new parent when old parent is NULL
>        clk: allow assigning parent lazily
>        clk: sandbox: reverse the order to register clk i2c_root and i2c
>
>   drivers/clk/clk-uclass.c      | 47 +++++++++++++++++++++++++++++++------------
>   drivers/clk/clk.c             | 14 +++++++++++--
>   drivers/clk/clk_sandbox_ccf.c |  6 +++---
>   drivers/core/device.c         |  5 +++++
>   include/clk.h                 |  2 ++
>   5 files changed, 56 insertions(+), 18 deletions(-)
> ---
> base-commit: 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7
> change-id: 20250621-clk-reparent-89d75f6a8e09
>
> Best regards,

Ping for review. This will be used by upcoming Amlogic meson8b clk 
driver and is tested.

-- 
Regards,
Yang Xiwen

