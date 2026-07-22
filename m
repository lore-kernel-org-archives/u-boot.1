Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E646C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B92674053D;
	Wed, 22 Jul 2026 15:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vbra-JmA9xWf; Wed, 22 Jul 2026 15:02:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1980406C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732523;
	bh=M9T/ZAx9WZavaGxo912gJzmaPL/VkI3/MrL+aCmRK7k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qadOyxVevuBpH08AXq6FVlSaCqkPhx3UsHCnoGenYSkUFmY7uONdM0VIF4Uhnta6u
	 4ud/Z7fjpV0y6djkMGF8wSkmp5MOR0jpWj/1SJ4rVwNPqkWzioYmCdaAJd++NORhY8
	 Jk0dE8Bd8gKRYTutxIhryFs8H3pWx2ne1mVkGBVhRCaTatalospy5d+uNja/T/cFIK
	 tBnxTVzXe4GyG0uTfKxRbyXsHnft/PMMk2pPmLVNlsVJmgoYv4QKzvRjF4/z1Q8Unt
	 YeAVsrjhyQDOkelO7Rph5djMW3hFWGbKMLMkY/RuS6eHDGl1z08GzMiReyYNTnijAR
	 +5JDOVnePdJhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1980406C3;
	Wed, 22 Jul 2026 15:02:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A861093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB20940100
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eESGHkiUFWLL for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:02:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BC506400BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC506400BD
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC506400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1UPKWtTjkruZ4onEyyMr7iWSBBtOmgknw36btodn+Oz4Qv6TE9G2uVjZtomTcLv/kQAKYb5lMBMxkxTGk3Sws6ybuXUrfn9X6lWWKYjiprMAgNj/+ONgdPXEhQA0EOZ+nZ1jrvLWqxMy1/PqUO6TaJT5RNbQ5dH24IfA0AI8LJHDXbqQ0koIsD6WGzp6pcuOSFYuaFCMwCpg/GPY0lcV+7EfazOtRuDHKjL0p774/lxAzknvrDXrsWOzVYDdchslXImkDvBeok3jZhanl3YN1hhGoPr1y5KYWczIqaw6o75mZ858avCvWKD1u1VsuWS519GUvCANbuylPPmexfLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9T/ZAx9WZavaGxo912gJzmaPL/VkI3/MrL+aCmRK7k=;
 b=hmrsnjuL2uRSHTt1HwlcUo4ezQu33Mn3MPCYpw2Lg60xoy6ZfRM9DhW827dfebzob9MHtTezfuu7l6SuGDpIHZIt+onmi5YwS0HC0iGI6uXBspwbQ7Mm9zRTs3vV622eGYR7x6DSG6lE2AH5i7p5bbGg0dYBPBri1pHuRgL64ZAttgDIQdZDnwoLAJz0epN6CyZp7CurqUUeCN3lxZy/CVuqvRSQX6wIWxUBEBj3ZWm+ErFNDgqAqZOYf13m5lvz1sXjod+e7VK987db9k2LzQ4jD8tXJ52ma+gN2p7ihcM/qGi8oawZgZAlGrCRBgzuxSH1m0CVkHjYN+EqVqgBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DBBPR04MB7820.eurprd04.prod.outlook.com (2603:10a6:10:1ec::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:01:53 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 15:01:53 +0000
Message-ID: <d8434754-6505-4526-849e-98f8ba0d2255@cherry.de>
Date: Wed, 22 Jul 2026 17:01:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] rockchip: rk3399: Enable UMS on ROC-PC-PLUS
To: Fabio Estevam <festevam@gmail.com>
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
 <20260722013642.1011666-4-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722013642.1011666-4-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::6) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DBBPR04MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa41fdc-e681-4735-0a50-08dee8022a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9+Y86dF+hRFnYk1n4jH0XZSgviK1ateMoPIc/kXUeFWmtOGCIscoOJxYFXPmbvJPft8qsAdMTcjYS805VKjOHyl2MYjzCVJ2qZB8Orb5zCL2T8DOpS0dyqOOOiMKUIMkOC7BNLz+5jb/Adl25W0Sah1enjYFCy3W3K6+XXPT3cpZQXHtK4m+XJ5oN4pkZFW6Zbo3lzLGGRyxpo0WdR3YsiAN+XemUxl20nE1Evbvo1SVf2Wj8hzRvlQMvzGi9WyKO3qVo4qlaqjV/jD/CqdB2rks2Pb6Qo9liiwkZsPa3q1mGDQJTLA4V9CqEyl3oC4/FhyzIPy7vyIuonmtY9zSTrtYRvinzWd+Yr8EK3DeMTVazx16WBkicTlK/wiTXyRay1Kldo2b68tAb3L2S4zNgp6fzV6jqITbbsJd9weBizhXix3wcEittAObk4o4v0hJ/M7/Igsl9XOX4opIZbro7nTHv7XIrTl6v0pyUkb3xWmNFIlHAuZjf3hHifD1ZU2po2uYV1aDeazjl60KZpFIB6v0CF2Oj0xCzLICOGrCq+rVWqx8/DC7a25eKENjQit+7DKygNQt1T0HCkOqmRTmevj8yjs8Q21jldA2O4rcZt5O7SLEF8bCdY0Zo0ox6R3B0k26AfH6ooBrR18XrPAMkVFUVQfpu6LbJH5n8n0SG/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21xdXFqeE5PMzBoN1BTT3RoMERoU29ZcGhoc29IWXErNlFwOEZqOTNKOEJo?=
 =?utf-8?B?TUNJbVlKci9pUkVDMmZCc2kvazhLSmJIYlNZd3VXU2ZPcStYWlFTK2VCWlZI?=
 =?utf-8?B?T2Z6NlpPN2VSUks3OFdPR2ZoeXFtMWNSRGRxMnZPcVdqMGNYZ0xHemJmTWk2?=
 =?utf-8?B?c0tlNlNYdG45dUorSXU1c216SG5JaStlT1ZZNnh6c0s5RUVaR3A0MWlYUHZK?=
 =?utf-8?B?QjFRS0x4UmppR2xMelM3NlZyOTJPNG9BUE9abDlDWGhFUm5LWXNucG5EUnJr?=
 =?utf-8?B?ckpYa2NsQVBQR0ppZndUK2cxMzZNK2ZsZ2N5M2tTYWlNZ2FmYzIrU1VOTnh3?=
 =?utf-8?B?QjN1alR0TXF5RW8vREsvWVNJM2pnMEpLVXl2dmloZzNwTzkvYkJzTWJsNGdL?=
 =?utf-8?B?TWt1ZjFDV1p2WkVnTWlZUTVhZzROYlpROWFCUHFzQm1aOXNhejZsMkNmUzM0?=
 =?utf-8?B?V0VLZ05XWnl1M1JaV2J2Y3RwZzBzN3hKbkNuSjJNZFVwQ09kTUlHdFdaNDFR?=
 =?utf-8?B?THI4eldubHlxTGlpWE1FY1h4dysvbzVyZjBNaitsdmNqV0N2Q0trLzRad1hu?=
 =?utf-8?B?QjcwZWdmVjhBaUxtOEE2RU9OUUJZajB5MDFMVzJyaldNaVY4UFNrMFpUZjAw?=
 =?utf-8?B?MWVUSW5pZEk0NmhHUm5mRHRHQWtRSHl0OHZZYXNCbi9xQUE2Zi9RODlBRTI1?=
 =?utf-8?B?TzM4YndDMFUrNmRENVN5MjhWdkV1ZUpCRFpUSHMrZUF6aEFJVFF6enkxNlpY?=
 =?utf-8?B?SDRReDIxbnJRWlNnYVFUb0JLWDRDclp5YjMwVHZtdmgyUUhHRFpmUmVZZTVX?=
 =?utf-8?B?U0ZFRkNSbWhHZDV3MDNGYWZUVFpvVXRtWTBqa01CaFdLeklqZjM1R0d4WUlw?=
 =?utf-8?B?TzVUWkVhQ3hDVEZyM3V6ZVpoaWFrMjlscjZqNUcrb0o2cDNxUzZ2eWZMTnlC?=
 =?utf-8?B?YWd5cTZocUd6ellYYW1CRG9WNzhHbjJqTWZBeE0vREFqdWJ1dU11MHdaeWw5?=
 =?utf-8?B?WlAvTS9aZHNEa2tKUkhaY3N6VStTUjFQVW5PalZ4OFB0V0p2WUpzdHpVQnVZ?=
 =?utf-8?B?eGE2UVhVUzFjeW4zajlyd1R2bG5vYVRrYkNqb21NQTFBQWRnbFRDc1JUaTIy?=
 =?utf-8?B?U3o2eTF5UmhCSkVzVDdMMlZYTkVsaHVrSG9CZ3pVSnoyOEQ1b0xUSmNxR0tJ?=
 =?utf-8?B?b01sb0g5UDlVK1FRWU1pMUtWSnJVVGVObmJzMW0rQmxRWit2aUpzbWhkZ3hx?=
 =?utf-8?B?czRvWnFISUpyNzV2dlJRL1dDVHhjMVp6ckFCWWh5WCs2YTU2VVdsZkxXSXZu?=
 =?utf-8?B?bVVOZG9UN1Awc1RaWjVGOW1zSHlaYUV1MzdlTzUrRjFTTHZTWE1YTjcyNHpi?=
 =?utf-8?B?Qkl1MVNMdHN1TjYrelhiTUpCRFQ3ODdDRk0yTWZUd3BZMEpEVzlib1JLd05E?=
 =?utf-8?B?ODRGcEg0YUk3QTYyY3lpZjZCYTRqWEcxRkFCUjRnZ3haaDJiU2ZMWXN1bi9L?=
 =?utf-8?B?QXFvV3JDbWhqWUFLcnd4TEdQamtURjIzbTlHcDU3VWxjdmhyUkw4UjF2aVhr?=
 =?utf-8?B?anVrKzdGODhDTWpoZGZHcFlOaW91TS8wZW1xcGZtVy9IaE4rMnl4Q0lvbHdR?=
 =?utf-8?B?dGo3UVBUeThiTXBULzltWkorTGlVWHM4N3dKTW0wR1EzaDQydm9iZWlBQXBk?=
 =?utf-8?B?Tnd2ZHRkN2E2enN1VFd4NUdIMnA5QTgrK2NVaUNLeC9lOEFhZXhMZW9sWGNy?=
 =?utf-8?B?RFVwbGp0ckZFYVFuM2gyQzhLL3k4UDdXaDM0KzZ1V0J6Tk96ZHR6NDByRjI1?=
 =?utf-8?B?VW9yc2F0ZGM3VEJHZHNjTkU2b1pUcUFodDA1UW9PM1Nkak41SHJjWEwreU9G?=
 =?utf-8?B?aFRqbjJNcVh6ekk2RlYvOXkvL1ZOelgzQjAzcXQzUjltbUhZWHhKOFRtalZ0?=
 =?utf-8?B?U0NZaWhQaFhNMDRCK1JBYzdFb1ZlMlN6Q2tKdmpHTUxrbGl5ZTBtcHZramRP?=
 =?utf-8?B?N011b09XMElWRHhQT1lwS25PTnhuZFB6UzRJNW5aTDI1L0pFc0JEV3BTajlO?=
 =?utf-8?B?NW5Pck9CSFZtWW1YaGdOSm9DaHUwanV3S1dVQ2RpeGo0QVhRcFRJanFkMm8v?=
 =?utf-8?B?YjU0Q0IvMnFJU3FQNHhtV0RpcFd2dzVmMmNWT1ZSbE0vV3RxeE1pTXpnNnFB?=
 =?utf-8?B?d0hCR2lzZVZVeHl3Umx0Rm5UbzlOZ0Zuam03OXBlMlVZZWk4R01LclpJOVZh?=
 =?utf-8?B?a1JZcENvaUJMeGhYa05ESW5oTzNJWUlaODdheGR2UVVGcTJRMkQ3UHdpNGpL?=
 =?utf-8?B?VHBsbkNkcElmaW0xNnpod2FxWkJOaDk5WWQvc3dWT0pTSmFEcGhpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa41fdc-e681-4735-0a50-08dee8022a2b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:01:52.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03TsLq5QklKH8g2sQGDOLUoDBCOAAUoA8iCNcpZbRG/kZwd97NZdTPrDZAPiRQyZmvGlNOhNq1Qbdd9rOwkw09daHrQFjdTobhPCY1N1+Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7820
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9T/ZAx9WZavaGxo912gJzmaPL/VkI3/MrL+aCmRK7k=;
 b=QsJguZ3geUh64pHfevs+jYvsH8Uep2KTXo/4bVf+jsUJBvXo3xtHn8jZInUatEYAkqTi6PJgXwp8HFOl4Z1YSi25q4Qg7CxK6QG4NNB69eFBi19jztoY3d3ZhV5Ug3dLAh5iKNJ4XH9kt7bOc4JhlFgiz7MMAfRqb4YYE9UXRxg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QsJguZ3g
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 3:36 AM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Describe the USB3 OTG controller as a USB role switch and make
> peripheral mode the default when no external role provider has selected
> host mode. This retains OTG operation and both PHYs inherited from the
> SoC devicetree.
> 
> Enable the ums command so the onboard eMMC can be exposed as USB mass
> storage to a host.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Add the same OTG description as submitted upstream:
> https://lore.kernel.org/linux-arm-kernel/20260721030043.84691-1-festevam@gmail.com/
> 

Thank you for sending this to the Linux kernel ML!

>   arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 6 ++++++
>   configs/roc-pc-rk3399_defconfig             | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> index c80529a62b97..73027335446e 100644
> --- a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> @@ -1,3 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
>   #include "rk3399-roc-pc-u-boot.dtsi"
> +
> +&usbdrd_dwc3_0 {
> +	dr_mode = "otg";
> +	role-switch-default-mode = "peripheral";
> +	usb-role-switch;
> +};

Since this is not an important bug fix, I would prefer we wait it 
appears in devicetree-rebasing and cherry-pick then.

If there's a v3 (please note this series here is actually v3, you forgot 
to bump the version :) ), please drop it.

Cheers,
Quentin
