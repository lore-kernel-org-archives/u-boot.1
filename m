Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC93CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 20:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54531846B0;
	Wed, 17 Jun 2026 22:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="DH1SyJZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F85C84874; Wed, 17 Jun 2026 17:19:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD63F8460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 17:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utxYwQAGUGjxnJN2hMFptgGGoG+xIPj7Ir69gO7cA+/A71P7W9nh0ANzz85Bh1AODWsj3j2nCv7EYiU7DxQRbVj61woJ0jv3Ny4JJyg8dp2102uhJ61OrHnHaI+cN1HY31p6nFXQtpGJJ0w4T6LgkizqfGVY0AHfaje1HYw9sthUwyCi7WyRoaj0DFMFWdsstrfCTewBEOADqyMoCR64wpofcU594a3mjwxG4JoECDT9iXN1zMHbw79iHZQM4Vx2lw/pdDkV6I3MnDJHVhbV3iBdXsZgcIu88Q4Ge9ikEVxl3NmnaGx/GgshX8zdyioVLJKmvhk+gGfPsFDdQ3yjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FL6PIqDc2MMZnrwQziE+3Hg6RcM9N1J0uyieruxiI8=;
 b=tUzwHtiswZXc1P/+ZP5T7s8fpWDV70HIDBULwVOvrdIdJmPnRzHDDHtk5Uz7cXB6s0BJhdXE0c0yrumB1lYuAMHQmFkTJ5lVgPpgtDPeOqQspCb1VooArIpyYl/KfgTX227Xpw13ttQyDmeS7VvHIaMMe03KwHFgDQk5T8RBZcd7d34n/UmKsTupcfLA6/PrnFsBvRadSuOFL9pMwphqcK/7qEzG4+TXeTv9IeOTeGQZAm9Qq6wbUzJaomi1wOqbncRNmJUFv2or+IWwTACbJyhoeMrEYPWhAHQi1HOqWXP4DnIW3OsItiw3zC0yhg8yG+Qbyh7UqphCVaxtzH5NEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FL6PIqDc2MMZnrwQziE+3Hg6RcM9N1J0uyieruxiI8=;
 b=DH1SyJZwmuQ42AvISVCAaXocAOyOPooiTf/rDq6YCiRB9ZnxJbh133J0jrME29C2DCxeyHfj43lImFSj8sv+elXpaJkCMBLM3G7pTdAPUtG9zWUTHXwK9YyM0YOfeSn4E1z1DjhWK0H4lu6bPsWveKaGK7k+2eJ28tkCb+s6SdVHxvSchuiRZRSWiIUAJQTssbzd7drFm6dyq/oaScfq2YWwWMG1s6gT3Iiu4dptiwrsGM2xyAUKlAI+STlLHb3S0Z+dkTZW7sA5PE4do6JnTkqY6g9YgmmSk8/5c7pb9YAHn3A7/3Za56KKQlkYhVk0GK28RedTp+38AoustIR9RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by DB9PR07MB8703.eurprd07.prod.outlook.com (2603:10a6:10:30e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 15:19:17 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 15:18:55 +0000
Message-ID: <dfa39230-ac45-44bd-a2f3-4baf840d34fe@nokia.com>
Date: Wed, 17 Jun 2026 17:18:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] test: net: add IP defragmentation
 duplicate-fragment regression test
To: Simon Glass <sjg@chromium.org>
Cc: Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>,
 Mikko Heinonen <mikko.heinonen@nokia.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alessandro Rubini <rubini@gnudd.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
 <20260610-ip_defrag-v2-2-060f6eeaeaa1@nokia.com>
 <CAFLszTiiBtrthYHEAeppEqUoksW3fv7j9UNmztPOVd0MVCV8Mw@mail.gmail.com>
Content-Language: en-US
From: "Mateusz Furdyna (Nokia)" <mateusz.furdyna@nokia.com>
In-Reply-To: <CAFLszTiiBtrthYHEAeppEqUoksW3fv7j9UNmztPOVd0MVCV8Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|DB9PR07MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd41d01-4ee5-4bef-3aae-08decc83bf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|366016|11063799006|56012099006|5023799004|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gQZAbBaYekIqENvScGVYgF/tn1dk/5dioPHG+Myr8CCKV0JT6n4mBFzXjVSR7bd2KRPvn7X8Mqc17sp+Gqb30FgTQUgJc5heNiv6wGxG301oFMPVvdO1TSndUus1GOFiuG5ebpoDKA/c2ozYie26e1JId1Aem6vcqxrc08dygv0uWbgOo2Mfz9Sojr6R7HapZ7xWY/SPkCL8HjNFWVpxvCALJaHwwEqvG0apQPLm1qBcrXwszC26BsOgys2TjDwaAHqdgg58lQCLVZCq7kxTVTv5GHzritNes/JdKOpAq0AJ/iEFgf6NGFm0Qt/qffuoE2WgNkHi9DWN7x2jG0OpWsMrj690gK3B1/J6l7B1v8LwfnCgkFhlqaR20kI7HcJiHJEK1j8264ebyA5GZLWuuYN1JvhBtdCwrnbeWEzWihVsidJdcVb/jtV7v6mnzVJZ97lEgB/E6sKHKlIM29iRBlIyrCxjP0yYthyzebTO2pK26PMYp4Mc+P+lGRpeYfusDHfK8u8PGWs4s9oi+3YNQcMepPiji5FC5aERhR1ftvXzgYqf+/byX3fD0Nv8PkzZtDBjYwJ8g3U3UR09V+CjQqenl4g1yqcvgyVvU2wyUrP2nQJArmznDGS7ZI4JPidMUE+7S7GUr6suwKW5WpXuUIVAzOaMNgeiXsdAmNh3PrrsmHrQON8n+U3nqxbK5/eO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(5023799004)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9wenpwSFA2ek42NEZhK1dFbjZsdFg1bjZ5bk9TY1hybHBPWW9vN2FxUDhO?=
 =?utf-8?B?UHl1YWUyVHBseVpmOWxQVFF0RTNicUVyNFlORStqUEM3aUVNQjVac1pLd1g2?=
 =?utf-8?B?clVRb0VHdllCbnBiWXlqNGpQeGZRNmtCYWZkWmo5ajNrTWVRWmRUcVNzOGgy?=
 =?utf-8?B?amhpY1l5YUlDZTMxaUpuNlVzS2pwQnpDUjNZNUZpaDF1dFRVWFdmMzlMRGho?=
 =?utf-8?B?ME1tMG5KbS9QU053Nk5RSnNSejg1QUk3Wi91S1V2TVBsWnNoMmExNGVpZDYy?=
 =?utf-8?B?djBodDFEQWExcUoydzFaekJDeVV4MnhRTzAzQWhVWmcyRUl1ZDJDcFpiV1Za?=
 =?utf-8?B?a0tZTm5zRFBHTHR2ZGpabzQzSTVxdnpLWmlob0RIL1BkdXNZWDR6MUc0ZG03?=
 =?utf-8?B?UzhFaTBZQmt1eUZYcHIraEtwZVc0c2luUzN4elVxODVnUVp6OXArdVMvcXlu?=
 =?utf-8?B?TXgzRExKT1NYQXJCejhjSG1sNzByZ2pRakJWcnR0MlFCb3RXemxqdkhDbGo2?=
 =?utf-8?B?VjNCUUQ4cXBGcDdhLyt0ZkdVdjJqSjA0eWx6aWhvbEpLSU00N1hiY1pNUUQr?=
 =?utf-8?B?NTlVbmNRNWIvc3ZtTU55LzN5RUpmYTdNVkRybENvNTgrYjJzb1c0SEtUVWRw?=
 =?utf-8?B?VUNsN2l4S2R5THZRZ0FYWXhaQ0FmUGJ5ZGhUc2V1ZkwwWXNwMFFCT0IwQmRC?=
 =?utf-8?B?NWQ5UTRWNm1aN3VqNzdPSGN6aWpUNnUrS3lycEhJM2VyUmJQTk5LMVMvTVVO?=
 =?utf-8?B?Qm5PZFNNSDEzOS96aC90a3hPQ0EvY0JHMC9XbUhPYjR1OHVHSWcyVmNUR2FM?=
 =?utf-8?B?ZFIwUnZiVEdROGxPWEVoWTdZZ3I0dnp5WnM0alJTSEZsdkE3WjhGMlVrV01h?=
 =?utf-8?B?TnJEMysrZEllS2pTQUMwOGxwOWhxV3Rob29qQlppY2h6U3RKM3RQYkJTamhY?=
 =?utf-8?B?THBRS2tObnByczRReVkrd3ovVWdiLzBKdnhQZVRzQ1dMdWREUitsZWdiRlBw?=
 =?utf-8?B?VFNQdndSbTVsNTlMTUZKYmF3WDQ3M0ZadStCQUgwSk0vUlpjcmxFRHJXMXla?=
 =?utf-8?B?bFFhdm9BRHVkek43SE9QbnVqTkVDRjcrOWJqQnpxc2trRm0rNW9QT1dTTnNw?=
 =?utf-8?B?Z2pZRklzQU15dXhlNStzQlZqYWYxc3A2enhqdm5sTVZFbUtXV1dFMXNwanZH?=
 =?utf-8?B?UHpwV09BODFYQWNxM1B0WnVLaEdWN0Z4QW9pRWlmVVhPemtKYjg2cXB2L2VN?=
 =?utf-8?B?c0tpVHFyYkIvanhrOVlWd1gxWEdGdXBwQ2ptR3RjYkl5V1F4U0tsNUw3dFIx?=
 =?utf-8?B?ZU5NODRhUUZ6endqU05Hdy9wVk9qL0RVYVJvNWxrV1pXdUpqNmwyRng0Nmhl?=
 =?utf-8?B?REJ2RkpyTTRkbFJZNXBsdlBEUWdQTlN5bzF1TnRVMXA3bDJkMlJXd0tFUWhj?=
 =?utf-8?B?U2NDYTROV1F0VlJ1S0FySmY0TVJ2dm0yMDRzWDJIWTMrYWNlakcxQTZuWVZk?=
 =?utf-8?B?RkZzNklhK2NjbVZtU3dVcXA0aUJhLy9MZEtuV0pERzhyTStLNENMZEV0KzZH?=
 =?utf-8?B?a3NRZmJZTXp3cmR5bGJsbE5oMkZ2MlROQzcrUWt6THJNaFZJSVVEUzdCc01X?=
 =?utf-8?B?d1NLYnVVaEVqSE9hV3Y1ODZBL3dUanFEbnZER3BTdWg1Rm9hUDNwbWp0SmRO?=
 =?utf-8?B?Tno1WjNyYnJBVloyN3A5NWZjVFRzMHYySHhTNmZZZnM4Ti9oNlF0Z2lvMVpl?=
 =?utf-8?B?N1k3aGw3N2JrQS9xbXFaeElMd3JiS2V5c3pONUZVZTY4aEVJR3dadDZRQVpl?=
 =?utf-8?B?dGJYc3BkT3ZXK2Znam9QN1owcGd3d0dQV0tHMEQvc042eFBsc0hTNmc3bEpN?=
 =?utf-8?B?YWVUNTdUc21lN3VIOTdiNEtjN1pRRmQ0enZETFhpV1NKWi92cnJYMGlKUXp5?=
 =?utf-8?B?L0lRQjJzT3hXeVdOWW05OHRxT3ZpKzRiNjFwYTVvLzUwMnIxZk1kK3J5TUY3?=
 =?utf-8?B?c0RZbzQvRTR4eHMyVXMrZWUxMUh1UFVORGhzZFh3UjVWNHBLT0F5WHk0UEVk?=
 =?utf-8?B?US9HdEUxT0lmUlNUSER3cHBxcEhmY0w5RjRmV0QxZTcvVXFsS3lGMC9FTWd0?=
 =?utf-8?B?STJoNkVSTTdLUzIyRk1EWDRTaEFYZzJqQ2JyeDlmMytRWm1WNHJkUEJxdG13?=
 =?utf-8?B?TkpHbjFyOU15SW5SbTgwQmVjSzVzV3VDcEpobUZTT0N4OC94NVUvelVMWkx1?=
 =?utf-8?B?Y1VKUDArY3dLK0VIK0RZUGtnaHJHcHhYS1ZBb3JvNHZqMVZTR09UTGF6dFQ0?=
 =?utf-8?B?NnlQT2Z2WDBUVlRYU3R3US9hRGZmN2xnNXI4Qk8wQzFhWEdHQ2hrYWxQeG1Z?=
 =?utf-8?Q?EvSwfr4XYAWnz8+c=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd41d01-4ee5-4bef-3aae-08decc83bf66
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 15:18:55.8812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Psum4vPSLZcSEosbphunClKqRnUR8vxQs5eEpAC29sGUK4rfoEmZoc/IgyePEgWjkwCu1ipwNiB+6aeNivgtT/XBXiEKDZOfSnv/4FBes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8703
X-Mailman-Approved-At: Wed, 17 Jun 2026 22:33:43 +0200
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



On 14/06/2026 14:16, Simon Glass wrote:
> Hi Mateusz,
> 
> On 2026-06-10T14:25:33, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
>> test: net: add IP defragmentation duplicate-fragment regression test
>>
>> Add a unit test for the IP datagram reassembler (CONFIG_IP_DEFRAG) that
>> covers the duplicate-last-fragment scenario.
>>
>> Without the fix the last fragment will re-trigger datagram delivery,
>> increasing udp_rx_count to 2 and effectively failing the test; with it
>> applied the test passes with udp_rx_count == 1.
>>
>> Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
>>
>> test/dm/Makefile     |  1 +
>>   test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 83 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
>> @@ -0,0 +1,82 @@
>> +DM_TEST(dm_test_net_ip_defrag_dup_last, 0);
> 
> Just to check, does this test actually use driver model?
No, it doesn't. It drives net_process_received_packet() directly, 
nothing is actually using DM in the test path.

I'd followed the existing precedent in test/dm/eth.c 
(dm_test_string_to_ip6(), which similarly doesn't exercise DM), which is 
what prompted my earlier question about whether "ut dm" was the right 
home for this (and stopped me for looking further, my bad).

I'm happy to move it to the lib suite, for instance. Since Jerome has 
already queued this v2 for net/master: should I create v3, a follow-up 
on top of what's queued or just leave it as-is in DM?
> 
> Regards,
> Simon

Best Regards,
Mateusz
