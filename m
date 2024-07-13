Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB91C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 17:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A3787FC2;
	Sat, 13 Jul 2024 19:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="iaOR8d0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578D788795; Sat, 13 Jul 2024 18:28:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01288853E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 18:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMFeOWLZPoIEd0yzdiE98BHSN+bFCj6c0PWP6FmvW0nDEmurLn4OLHGVwLb4mUX12LqrREI5D1NhK0XyLTMOXLoHRABylz9lnvpbL18HD+Hx95lKPJfHs1jentoZ6bNBOp9wCR5zQ/9tpunSDPAwoxcz4unNv3ti9g5cTSw2WgPcC5orfxL/L6lnj0gK81KRn4knYURTOzKDznKt/voKIX4gsJXWC3wS+gPAROHMoGk+4N1XivCutuPXqP+7OwMiRL5OTDX9cBA/CqFik+ffY52qvZAxP9bwn7gIOX8SMebk4pOMnMVDxD3SQZ8KnOQjwxtnubY8PnM6jJ2iSmVijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRg9M/oaMkzDf8Br4yyO8y8VxduHzHk1KIzwHroBNls=;
 b=fG3chLlvTgTYsVq9JCM1A+n2w0xght0/xmAwPA6Umry7+AGh2EN/NsDA3ddTmlTqSPnFNlyBLYqmxh1HHtWSdIPmw/0yrs17VPa8L0Jnwzn1xRZlgSki2sxIf+LAbUct4468mktcMtWQO5wJpOW69SN6dOQfGJRcAjuiQnxljU6Djn0C6/XZK2SzGKz3sM26pg6N/EPkjDtcJTO1jQtzYCOxAwGmp7F0zOHuwPdtVSpHBWaZsWAE9hq9MGDQTsbk//Zg8itFkntY1sACHvMCjbWYK+jA7HO2eUJaL7RAu17NMZx5LA9yoAS9FEnImRP+9+AeaWvjSvv/2t/4q10h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRg9M/oaMkzDf8Br4yyO8y8VxduHzHk1KIzwHroBNls=;
 b=iaOR8d0iRbBcIhk11W9t8d5Tbo/6VCHB5oGV6ggvBja/rxV72MFgAhvwvlcB9Gy/mWU4E2WH6nSGtBYWJIUGFGRGYtzowwawL0pwzxUukwhmyaUpVRb+3J+kZJaRf68rj7nudpuK2W8YGKkXka/HkQdI3ItLr+7ecJqD5a5kc4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB7388.eurprd08.prod.outlook.com (2603:10a6:102:2a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Sat, 13 Jul
 2024 16:28:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 16:28:37 +0000
Message-ID: <4e016ef2-34b1-4f28-904a-5dee8b42c532@genexis.eu>
Date: Sat, 13 Jul 2024 19:28:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] led: Implement software led blinking
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-2-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTgL2tYURExFDrjHP4GMZn5zn0Ho0uKt_w5P1KPFvTEyzA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTgL2tYURExFDrjHP4GMZn5zn0Ho0uKt_w5P1KPFvTEyzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: ff864806-381a-4657-6da2-08dca358d8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVRyNTdldzY1V255ZjFodHM5K0F6ZC85cXpXTFVEWGE0eWVmc25ZQVFrbm95?=
 =?utf-8?B?ajk1TlFPNXVLZ3M1UTN5UnZtOE5qSTMxb1ZZSmxCN0pYWFNaVlA2blhkTE9Q?=
 =?utf-8?B?dVFGU1dlRmo2aHhrRUNPV01la1V6RW5USzB5YUtTbHQxSS9GakVDUmdSeU8y?=
 =?utf-8?B?KzNsZzllc3ZsSStqQ01OVzZrOGRXYnNlRXY4QXU3ZXBmSnF6cDZla0FEYTNm?=
 =?utf-8?B?UW5TS3hqZUhsaldYWnpsTjZ5S1g4c2pzYmE0dWU3dXAyZ0VhUEV6TFcySTRt?=
 =?utf-8?B?My9lMmhWaFU0TCtqQjU4WmcwRCtGNlp5L2V0YlIrVm15VFdBbjFYYUhCcm56?=
 =?utf-8?B?ZFozTTRDWmxzdDhWOGtTdCtjaWZPWVVReDluM1hzNTQ4a0hkbm5BakZFSU9a?=
 =?utf-8?B?akdFN3o2eXN1cDJJY1hCSjl2eVJtSWFRVmN2ZmJtR2xBTStFYVJZZC9sNk9l?=
 =?utf-8?B?Q0I3alJWWUl3MFgrL0gwRXkxSTZPN09qaXlGa3pPVTlWTEJITTVzVzVRazJj?=
 =?utf-8?B?U1dFUlhXeVlqWnFjSnhYMWZKaHpsWlNxNmxoV2JQNWcyamx2RE42bkJRQmpa?=
 =?utf-8?B?MjdCeXJ3WkN5aW1wc1h6djZLQm4yaVQyejlnMkdZcUJHMVZFSm12cC9nak40?=
 =?utf-8?B?akhmdlk3ZkZGd0UyakJ6QnMybUduRWNWTzZ2akNyU0VLdENMSGFHOVBRMVkz?=
 =?utf-8?B?NGdlbkp3YkhMQXFXOE5yQWZsQkJwc2IwdkV2SThhdUUzK2k3bVhTVTdsV3Bw?=
 =?utf-8?B?VDZ3dHRBMmN2MkdTVmdhV0loVm1KZ21lM1FUalJEVnZXOWYvZGt5NkpiVm9L?=
 =?utf-8?B?YTdjNHMrSndEcVp5MTdQQ1dMUThHK1NYeThMZzJsOW1yc2hLQkN1aVJrRHhT?=
 =?utf-8?B?dlF3K2dDbThvRmdYdDh0Nm0yZVNuKzBWcXRYbElUdHd6bnc2dGhBUWJYdHRx?=
 =?utf-8?B?alZnbm9xOGRiUmdtMWJSYzg1Tk1qUzdTVDUzeFVneHVmT2UwV01JUTdJb0hR?=
 =?utf-8?B?U21kc0pjdk55VFpwS3hMd014dU41VjBtMzRGalZPTTFlUmhkOXJRSzd0Q2pF?=
 =?utf-8?B?aGNlWVhJRHFKY1dzVWZGRERvdUlicVRxUXBtM0xnaW1pMFlDSHRVbTk4S0Vv?=
 =?utf-8?B?SXp3MzdrdWF1YmlXZHdwTzNvTDZYNjlZbStRQW5IWUhqZWEyWjhUczhWUEY3?=
 =?utf-8?B?Tk5PMVczcDVEencrdS9EYnVjNzBsL09uekZvSTljSExsbEhBRTBwRDI0aVoz?=
 =?utf-8?B?akhBcjlqZXVPazREVm1ialIvdXlnZTBGTGlkZW4vTFB3eDNGNFRmckJ6MXp4?=
 =?utf-8?B?NU1JTldnWDUzUjhrNEdoVFYrTHlrK05ySWJRUUVCejZEbmR4cnhCclhIT05m?=
 =?utf-8?B?WDlQaHBMY244bWk4NVBHOEJ3d1FIOEFoVkdnWXplaWpmYTM2b1M0a1dMV1pv?=
 =?utf-8?B?bWdKMmYzOWVhbnVaZ08zMU4xdThKdHRFQUFWNGN5WkoxVTI2ZFZFd2R3L3JX?=
 =?utf-8?B?aUUybG1nVmRUaUM4cXF0MmhKQXo5V2llV29xQXV3cnM2RExaZGdsTUJVTUFQ?=
 =?utf-8?B?RCtrRXg5WklGUmFZaEw5SXFUbXN6VzVxdHFXVTI5bUVjclBUcHhqVWg2ZzQz?=
 =?utf-8?B?eGNqZW9UU3dSVkFPT0F4eWlRcHVGR2twaFZDWCtkbGxoL3lTQTVFWUhtMVZV?=
 =?utf-8?B?WlJyRmtMcmNNcnlUak9IOGd5RnNWclh0MW1aaGpTMTNsUVRHdC9iMHBWUE5i?=
 =?utf-8?B?Mnp0SnFnbTR3MzE0ZmFuMVJpdzlmZkw0eDB1VmVmY0FuVlc4b0FBTU1LWmdE?=
 =?utf-8?B?Nko2VjhrWExndDdMNnZ5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukg1T1JnVWpVQXQ4eHlNTm05Y2ZieVBRVXVpeEZObkNxVXA2TE8xYjE3a1ZS?=
 =?utf-8?B?RGRoNFErYm5ZcmVPK2lGeTFFd25tSXZiY01DNkxMSlNvS0lxc0tYOXpGdkhn?=
 =?utf-8?B?YURpTlFMM2k5R05vRDlNcGo5Zlpvcnh4SGxlRldpUENId3o1WFlNK2NDSnVh?=
 =?utf-8?B?R1dvQ2ozcjVYZ2tFNXdWcVc3OGwweUFuUnppMGh6eEUvd0ZPV2lJTldkOFBK?=
 =?utf-8?B?Z005NjExaXcvZFJGaHRRdFI5RkhNMDhkbW14SitEMFlyZDVkbVYvRW1vaVlI?=
 =?utf-8?B?d21nbFNCK3R1Y2xtbExnTzBiMjN2NXZ3RDdnVHRMS0Z5TDg4eWlUUFlLYVlO?=
 =?utf-8?B?WmtPL0F1ZExKdjg1SjdKM2ZDRy96ZlZnVjluZkxaNGoyKy80bm00eWhDRU94?=
 =?utf-8?B?SkYzNEExOXAyS0JmM3BjUVBSREFJdldJY2NiRDRWR1hJUUdVc0d0dEVuYXZG?=
 =?utf-8?B?N3FtRWIyTjZwQjh2aklzZlgrU2VrNWZOdlVmNFVUYkFiTW9KWDlqMWdmTThI?=
 =?utf-8?B?OHpPdlZ1UkNDWHh6WUpsK244UUZFeWdZYlpNYUxPSlpRQTJVeTNqR1FvS3Qx?=
 =?utf-8?B?OFlrTFlPV2psRitFUmRlWmltY2VPbnVWamwrNy9iL2R2aUs4WkRaSE9vdUNJ?=
 =?utf-8?B?VXcvdURzb2t6cDJqMWhsbVhrMU9CNkhWdHBvSzVtQkNHWUlkdlJwR01ielFl?=
 =?utf-8?B?U1RYOThHRmoySEgwU0pPRWFZVTBBLzFEcXFjS3FIZDdKUGZPa2ttaHNEdkxw?=
 =?utf-8?B?SDVpWGpCb0Mxd3pIT2JZOUtRMGt6c2diKzUvSFpWbXVGMGlmYkZRZFdPRDEx?=
 =?utf-8?B?ZXdZaysrOVZtaHVjbE41NFVCRkJJV1QzL3o2Q01Zem1BRklQeVNSSkx6bXpw?=
 =?utf-8?B?czVuRXZybHg5ZEFJQWNMaDIzQzdOM3BXRlpaRnhZS2lXTDdjZ005VWdLY2I0?=
 =?utf-8?B?TGU4Vi9OM3QyaklmVzRQSkg3SjA3WjA2ZS96RkRZS2IzdW81WEhtYUhIV0lq?=
 =?utf-8?B?bjhwQWlvVitNSnRIeWJIUXkvckZrYzJPb2FSQUdTc1VaSlhSaGM5ZU1PUzA0?=
 =?utf-8?B?YnZzb0dYQ1FIeWltUzBLcThLcjNDbFM0YkpDRGsrWFpFMWlGRnRRS0RMYkph?=
 =?utf-8?B?OFk4OVJkNjMvSnVHbXdVN2R3OHcvUFl1ajZMUzBDQlNEWG9mQVFPc1ZEekh0?=
 =?utf-8?B?WWhteEhTL25LSTFMb0RLY2M0Tk03T1VvUlpFYm1DYVNnd3ZtWE1aZTQvYXdq?=
 =?utf-8?B?bFBYaXI1bjRQUHZXT01ZMjcwRzZVcXJjaFdFL3NaQVVSQkg0V0w3bTNqaUNs?=
 =?utf-8?B?TWUzWkxSbGJSc2NnOE5rS1EvWFVqWi9qNHlUMWpQaWFQd3VoNDBrZTUvM1Jo?=
 =?utf-8?B?OUlSREwzMXMraURZcFJpTGNxWnJqWG9OOU1GTEQyZVcyTjN0K2N6M296UU1o?=
 =?utf-8?B?TVlaODFiUkRZVFJlZTNGaGNvRXdOdmJyQjNBLzd4L1lTYVg4RFBTR0xUUENY?=
 =?utf-8?B?MFVBdzlmYkdpRnVnUHpPdXJzUVBYMG1YSFdCbVliWU9Na0Z6Y2NIc2VqV0Fj?=
 =?utf-8?B?dFFCVkY0UlppY3k1WmFiejlJcFdoeW9rZkp4QUlQQUdvVHNXSGJRSTB5cUNP?=
 =?utf-8?B?Zm50VXV1R2g1RFNPNTF3MGVsVFBKbDlyVHIvdWNOcTZ6dE9CWGhrbDNpUlVK?=
 =?utf-8?B?cWxUdTZqRVROMDB4WmlWaEpwdSswOExjR2JUVVN0aDRra2NseWU1WlFIR3Rl?=
 =?utf-8?B?SVNjYjYzNkdBZUlMWnRzV3g3NVFyTUsvcjhQcm5DTG1JaU0zazl2Q2U3Ymts?=
 =?utf-8?B?MEZkQmcwOXNkUDM3RW92TXVsQ2FFNm54MVN0MXRMbWVQL0dZengyTXFKTGlF?=
 =?utf-8?B?TDU5VEM4T0E2b1FpRGdNUzhoanQ4YjIyYm8vOE5DMjdzYW94ZktmRW95Y3RB?=
 =?utf-8?B?WXpoejdnZnVKelQvQkpNS0h1OTJHeTFQdXArZzl6S1pRdW8wRVlsMUNvbDNi?=
 =?utf-8?B?dHBTMGRGT05IZG1QZy9KL0N3RTZXdTNiNFcrT3dsL1N2ZEZZck1oVXEvY290?=
 =?utf-8?B?bHQ3a0dSaTdCUmtnZE83NjJFUWgrY1NuWkxXMFFpd1VGU0NIdG9IN3ZpR0Zp?=
 =?utf-8?B?VUIySHM2WjlUYWpvS2lGWlVqc2pXL2NDSnlZMXlLeFkrSjBWemc1eTVwTGQ5?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff864806-381a-4657-6da2-08dca358d8ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 16:28:37.3474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKyEezaW2EWN+3uL5gyvJcFoAOUeLxymJ5HK0Yq0Jly6YGa42jSErJGpKO7rHbuQueEhYFJxRRML2LugIIiun/Ou0s4jSSRXQy5Q7qFGjh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7388
X-Mailman-Approved-At: Sat, 13 Jul 2024 19:13:06 +0200
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


On 13.07.2024 18:13, Simon Glass wrote:
> Hi Mikhail,
>
> On Fri, 12 Jul 2024 at 06:25, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>
>> If hardware (or driver) doesn't support leds blinking, it's
>> now possible to use software implementation of blinking instead.
>> This relies on cyclic functions.
>>
>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/led/Kconfig        |  14 +++++
>>  drivers/led/Makefile       |   1 +
>>  drivers/led/led-uclass.c   |  19 +++++--
>>  drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
>>  include/led.h              |  17 ++++++
>>  5 files changed, 154 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/led/led_sw_blink.c
>>
>> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
>> index 9837960198d..dc9d4c8a757 100644
>> --- a/drivers/led/Kconfig
>> +++ b/drivers/led/Kconfig
>> @@ -73,6 +73,20 @@ config LED_BLINK
>>           This option enables support for this which adds slightly to the
>>           code size.
>>
>> +config LED_SW_BLINK
>> +       bool "Support software LED blinking"
>> +       depends on LED_BLINK
>> +       select CYCLIC
>> +       help
>> +         Turns on led blinking implemented in the software, useful when
>> +         the hardware doesn't support led blinking. Half of the period
>> +         led will be ON and the rest time it will be OFF. Standard
>> +         led commands can be used to configure blinking. Does nothing
>> +         if driver supports blinking.
>> +         WARNING: Blinking may be inaccurate during execution of time
>> +         consuming commands (ex. flash reading). Also it completely
>> +         stops during OS booting.
>> +
>>  config SPL_LED
>>         bool "Enable LED support in SPL"
>>         depends on SPL_DM
>> diff --git a/drivers/led/Makefile b/drivers/led/Makefile
>> index 2bcb8589087..e27aa488482 100644
>> --- a/drivers/led/Makefile
>> +++ b/drivers/led/Makefile
>> @@ -4,6 +4,7 @@
>>  # Written by Simon Glass <sjg@chromium.org>
>>
>>  obj-y += led-uclass.o
>> +obj-$(CONFIG_LED_SW_BLINK) += led_sw_blink.o
>>  obj-$(CONFIG_LED_BCM6328) += led_bcm6328.o
>>  obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
>>  obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index f37bf6a1550..4f5dd66765e 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -58,6 +58,10 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
>>         if (!ops->set_state)
>>                 return -ENOSYS;
>>
>> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
>> +           led_sw_on_state_change(dev, state))
>> +               return 0;
>> +
>>         return ops->set_state(dev, state);
>>  }
>>
>> @@ -68,6 +72,12 @@ enum led_state_t led_get_state(struct udevice *dev)
>>         if (!ops->get_state)
>>                 return -ENOSYS;
>>
>> +#ifdef CONFIG_LED_BLINK
> It looks like you can use if (IS_ENABLED...) for that ^
No, LEDST_BLINK depends on CONFIG_LED_BLINK. I can define LEDST_BLINK
unconditionally, but this will produce an issue in the other place
>
>> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
>> +           led_sw_is_blinking(dev))
>> +               return LEDST_BLINK;
>> +#endif
>> +
>>         return ops->get_state(dev);
>>  }
>>
>> @@ -76,10 +86,13 @@ int led_set_period(struct udevice *dev, int period_ms)
>>  {
>>         struct led_ops *ops = led_get_ops(dev);
>>
>> -       if (!ops->set_period)
>> -               return -ENOSYS;
>> +       if (ops->set_period)
>> +               return ops->set_period(dev, period_ms);
>> +
>> +       if (IS_ENABLED(CONFIG_LED_SW_BLINK))
>> +               return led_sw_set_period(dev, period_ms);
>>
>> -       return ops->set_period(dev, period_ms);
>> +       return -ENOSYS;
>>  }
>>  #endif
>>
>> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
>> new file mode 100644
>> index 00000000000..ab56111a60b
>> --- /dev/null
>> +++ b/drivers/led/led_sw_blink.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Software blinking helpers
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +
>> +#include <dm.h>
>> +#include <led.h>
>> +#include <time.h>
>> +#include <stdlib.h>
>> +
>> +static void led_sw_blink(struct cyclic_info *c)
>> +{
>> +       struct led_uc_plat *uc_plat;
>> +       struct udevice *dev;
>> +       struct led_ops *ops;
>> +
>> +       uc_plat = container_of(c, struct led_uc_plat, cyclic);
>> +       dev = uc_plat->dev;
>> +       ops = led_get_ops(dev);
>> +
>> +       switch (uc_plat->sw_blink_state) {
>> +       case LED_SW_BLINK_ST_OFF:
>> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_ON;
>> +               ops->set_state(dev, LEDST_ON);
>> +               break;
>> +       case LED_SW_BLINK_ST_ON:
>> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
>> +               ops->set_state(dev, LEDST_OFF);
>> +               break;
>> +       case LED_SW_BLINK_ST_NOT_READY:
>> +               /*
>> +                * led_set_period has been called, but
>> +                * led_set_state(LDST_BLINK) has not yet,
>> +                * so doing nothing
>> +                */
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +}
>> +
>> +int led_sw_set_period(struct udevice *dev, int period_ms)
>> +{
>> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +       struct cyclic_info *cyclic = &uc_plat->cyclic;
>> +       struct led_ops *ops = led_get_ops(dev);
>> +       int half_period_us;
>> +       char *name;
>> +       int len;
>> +
>> +       half_period_us = period_ms * 1000 / 2;
>> +
>> +       name = (char *)cyclic->name;
>> +       if (name == NULL) {
> if (!name)
>
>> +               len = snprintf(NULL, 0, "led_sw_blink_%s", uc_plat->label);
>> +               if (len <= 0)
>> +                       return -ENOMEM;
>> +
>> +               name = malloc(len + 1);
>> +               if (!name)
>> +                       return -ENOMEM;
>> +
>> +               snprintf(name, len + 1, "led_sw_blink_%s", uc_plat->label);
> I think it would be OK to have a fixed-length name (say 20-30 chars)
> and use snprintf()...would reduce the code size.
ok, will fix
>
>> +       }
>> +
>> +       if (uc_plat->sw_blink_state == LED_SW_BLINK_ST_DISABLED) {
>> +               uc_plat->dev = dev;
>> +               cyclic_register(cyclic, led_sw_blink, half_period_us, name);
>> +       } else {
>> +               cyclic->delay_us = half_period_us;
>> +               cyclic->start_time_us = timer_get_us();
>> +       }
>> +
>> +       uc_plat->sw_blink_state = LED_SW_BLINK_ST_NOT_READY;
>> +       ops->set_state(dev, LEDST_OFF);
>> +
>> +       return 0;
>> +}
>> +
>> +bool led_sw_is_blinking(struct udevice *dev)
>> +{
>> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +
>> +       return (uc_plat->sw_blink_state > LED_SW_BLINK_ST_NOT_READY);
> drop ()
will fix
>
>> +}
>> +
>> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
>> +{
>> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +
>> +       if (uc_plat->sw_blink_state != LED_SW_BLINK_ST_DISABLED) {
>> +               if (state == LEDST_BLINK) {
>> +                       /* start blinking on next led_sw_blink() call */
>> +                       uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
>> +                       return true;
>> +               }
>> +
>> +               /* stop blinking */
>> +               cyclic_unregister(&uc_plat->cyclic);
>> +               uc_plat->sw_blink_state = LED_SW_BLINK_ST_DISABLED;
>> +       }
>> +
>> +       return false;
>> +}
>> diff --git a/include/led.h b/include/led.h
>> index a6353166289..26955269d3e 100644
>> --- a/include/led.h
>> +++ b/include/led.h
>> @@ -20,6 +20,13 @@ enum led_state_t {
>>         LEDST_COUNT,
>>  };
>>
>> +enum led_sw_blink_state_t {
>> +       LED_SW_BLINK_ST_DISABLED,
>> +       LED_SW_BLINK_ST_NOT_READY,
>> +       LED_SW_BLINK_ST_OFF,
>> +       LED_SW_BLINK_ST_ON,
>> +};
>> +
>>  /**
>>   * struct led_uc_plat - Platform data the uclass stores about each device
>>   *
>> @@ -29,6 +36,11 @@ enum led_state_t {
>>  struct led_uc_plat {
>>         const char *label;
>>         enum led_state_t default_state;
>> +#ifdef CONFIG_LED_SW_BLINK
>> +       struct udevice *dev;
>> +       struct cyclic_info cyclic;
>> +       enum led_sw_blink_state_t sw_blink_state;
>> +#endif
>>  };
>>
>>  /**
>> @@ -118,4 +130,9 @@ int led_set_period(struct udevice *dev, int period_ms);
>>   */
>>  int led_bind_generic(struct udevice *parent, const char *driver_name);
>>
>> +/* Internal functions for software blinking. Do not use them in your code */
>> +int led_sw_set_period(struct udevice *dev, int period_ms);
>> +bool led_sw_is_blinking(struct udevice *dev);
>> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
>> +
>>  #endif
>> --
>> 2.39.2
>>
> Regards,
> Simon
