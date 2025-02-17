Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028EC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B45B8083C;
	Mon, 17 Feb 2025 16:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YasxSZU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71258808B6; Mon, 17 Feb 2025 16:37:18 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18552807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvaE/FMLIzTFaH+n/lCELsvzUuFVFujfteOU8tve0McDWv4SzECVlWOydUm2MwRynTWTnqTEfI+Wx1S3Q0UDwaUzzzr3nBDUiWmJYwnmFGreeZU3yxOYaCbsMlnPa7eNzQ8xdGTb5FPpd0KQGARprO1Ej+7Y8cTG82SYPKjhjw0Vw2RsrDzvJJmqNjPZhrTjVjxrJCFX4N9tkA0s+H0WAKK3xRH6Z5e73tUuKSnx14cytLHSSmTInvPZYXwtslr8UIWAJCf1xR6GLFz6J56/NbaKy/zrKme/LXiK5jPA99QHw0DSA9Vrv/XDl1wymsX2UqLiKmV5ZscwI+wZlAXD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd1WITnY4s3mt16UEeijmV+cmfy+fSXSdkLbSZ9zZlo=;
 b=q4C/DGn2q2Hdn2+DK/cfZ/bg7UNrGznYzJJWKg3C5tA040Z55uFHnX1HmSnvEFJq4NTybS6iDeeDirY0HI+BZhq3H6WzRzeXQIkykNW+ZbhHBLLQlUE+4qOgUUKtzp6k/y961G6iNyMJ2bq7N+n610vkLImZX6V1Lkpx31HbjSEnDaHFKmD+7c+K+wJxHgg00KP9FkEuFjssOxa0t/6rXMMS64+XZ+3Q1g8W1O6AqRu+xlwfn0/x1f29F27DuSyv/ewVfnUMwKAzWC2EqvFNV6mQmavgZ1F9B78ci0C9Qk6CGEytHev036+OE9m9AZ5PCdKPN5l0Gwlw5PdydTjPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd1WITnY4s3mt16UEeijmV+cmfy+fSXSdkLbSZ9zZlo=;
 b=YasxSZU1DoNMTWO32LfQUF4LQ4sSxuvQypNgRBA1j2CPyukSYcGIT9o1lx5vhJ7gihMYEiKs9+zfuhYOJuJMawvhxIuFsxy6ZumlH0+suEuaxSykH+q2zvgQ/aqXANQwYr4/6EsXeskfEqr9oCbY1HlfblFKgYANTdHqlC6OjmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 15:37:14 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 15:37:13 +0000
Message-ID: <0c83fc06-6f7b-45b5-b8eb-2373222f8de4@cherry.de>
Date: Mon, 17 Feb 2025 16:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
 <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgunKAxdNwd9sO5=0bH1zrJkhMLackQ1gOfQqyApm91Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5cb0ba-e961-4bda-4263-08dd4f68f37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVHcFQ0T3hBTW1MUDJwRFB6ZEJvaStpUjB2Y1RKTDBXejBTVHJobEJqRlBu?=
 =?utf-8?B?TkszNldIbkdqNjlRQi9MRDI4MjJiZUhsd2Z3WjcyTjd3T1ZCY2ExSzI2cUpS?=
 =?utf-8?B?YW5LbjRjK2ZkQ3FWREU4akt6UzVGalpXNVpXVjVVclZhR292SjJzcWw2UzRX?=
 =?utf-8?B?Q3JvR3JveXA0V0srWUFueDU0THNJODBjVzZ0SUpneHFaZDdnK0VtUE1TYWpC?=
 =?utf-8?B?NXkrQWpVejBOUzB1Yml6T090RGJheDNTdkV6SE9FSTkxdkk5Mk0zQUdXUC9N?=
 =?utf-8?B?cHdjL0FUWUlYV0o5VG9YRFF0U0JCR0pIN3VjdGdnVFM5blUyTFViUXQrbkFP?=
 =?utf-8?B?YmVEL2RwcUtnK1p0cWttcFNDcGh0UjhjTmtPeUwwZmZDQXAvVjhscUF4RmNU?=
 =?utf-8?B?M2JxY1ptc3dnVGNKUm1pbGdqdEY1a2wxRlVSWjZYcHMrSUQ5WENqUGQweFBM?=
 =?utf-8?B?ZCtubkRSaDlGeVl6VU5mS3J0Wjl3aTFtUmhMMHBSQ1ZWRGhmWkt0eEJISkdB?=
 =?utf-8?B?SDZ0STU3TmFKT1RqSmhkS2o1bVRIZ2JyR2MvaFRCMGtIam9QbDV6cXU4STlY?=
 =?utf-8?B?aVFVanNybzJKNEVQWEp0NnZOSmdXR1diVlVWTVNVblhjbmxzNXZ3QkFWd2JQ?=
 =?utf-8?B?QkxCSDJzT0pjTE8xWkFXQmROUE80YWdiUmpuaDQ5SUJJZmV5amRmOUttWEp6?=
 =?utf-8?B?L05lOWJzWFhCc3oyRlI5YzYvZWFUZW8vWDNrZUVPSlRDeGl5U28xRHN4clVM?=
 =?utf-8?B?aEtqejNqdndoTlJkZ0JPY1F3bzdDTlo3Q1ZsK3g0UWdqdEpYVVJMRGFwVzhu?=
 =?utf-8?B?M3JkQmdqQXhiY1JqUENGNTk2OVJSYlZGYjAvakRDSTB1ZTBzazkxUm5ORnY3?=
 =?utf-8?B?QzdwbHFGL2M1WnFENEltclJlK01DVE9ySkpFellTc2xlYUZxS2poUXIyT0wx?=
 =?utf-8?B?NkRDWkxLUjFqbUVJNFZ4RWFSSndqY1NRRWZUelp3K1dyWnBjOTM5MVlQMWRU?=
 =?utf-8?B?dkJXM1czWHZySDJSa1pVZWFxRTZvMmZ3STQzSVFabnR0cWtacVcwekJvQzdT?=
 =?utf-8?B?ZVRuTDF0QisycEZGMWNVTnlNakNQZDIxTWtWaG1yRmMzVHdDeVoydTU2ZGZU?=
 =?utf-8?B?TmZUNXphV3R3K0xLMjk0YjNIa05DVjk0VE9hbEJUNHFjcGVKY25iaVIxWjlm?=
 =?utf-8?B?NHYyUC9uR09Hc2l0WEQvdklWU1hVODhKTTZqNU5nWm5sNThPQmRJODNGMEpp?=
 =?utf-8?B?aldmUHZrZ3BoUEtnU293Lzl4bmxqVFF3OEQxYXg4cnh0TisyRWhLRmI5ZW9P?=
 =?utf-8?B?NU9zbXRSQkorU0t3b0c0ZjFWVjdERkV0UWR0Y2xxOWQwcWNXTmkvSGVYNkJQ?=
 =?utf-8?B?R3hVdy91QWpQN2lDZWVYbElmNTlpYXE1Y1ZyVEJ6R05QbmtoL2JOak44MndQ?=
 =?utf-8?B?LzVKYzVEMmp0d1VxYWhFWDJtWTQzS2dLZlBGcFUzME9OU21aakpTTm1Yd21V?=
 =?utf-8?B?UmkzV0lVS01CUVRsS1pyOXdTcW9kTkk5dkgvTWxEaEU1Z0JHU0dvK005Q2dY?=
 =?utf-8?B?c0FJbTR4a3huUlFBM0d4MEdoTlJZY2RGL1V5WGNLOXJFOVdhTE9sczhCRUVa?=
 =?utf-8?B?OGhia1BsdkxMVFpRVGNET056QTlEN3lFNEtyVVJoeHpHaWJtVWFSN3FGT0xW?=
 =?utf-8?B?eVRsSXViSGF5clFkQ05pVWVsUVNJZGJZeEJwQmNCUGMxVE5VV295bkREd2hs?=
 =?utf-8?B?NkZndnN0NVZXM05Hc0VaNHFBOGQzRHNQWGo0RVBON2h2eFpCV2pScUZqcW5L?=
 =?utf-8?B?NXNLTk5DWHhHOHlxTnFsUXJMZG5BWmRzWjJ2eGNwWG9Cdm1icm5HQVFQNS9M?=
 =?utf-8?Q?K9wcSjyUlHz2M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnAweGR3SndXTENrekd6SUdiaFV6bDRTWG9rSE1Hbm9TOVlKREtEbjVpeHRL?=
 =?utf-8?B?V3E4NDhiMnc2TjRydHYrcnVEN28yMDlhaXMvM3VFUlp5TU5jREhSakFjeXBk?=
 =?utf-8?B?a0ZDMlJZWWZxOURGZ0x0Q2U0ck9QZzJJbEFaQzNiSjE4MVFRMW1Cd2p3US82?=
 =?utf-8?B?Zk50MlFXanlibzlkemJsMWxZVi9EVWNVSURNd1pCN0l0YkFwTXpnRDVKdVhs?=
 =?utf-8?B?UnZjSlR3QUsyRkRDV1FNTkpHdXVTODRhQnRjOTBRdVpMNlJaWGNqMG9IajZ0?=
 =?utf-8?B?T3cvRFJ1T1Qva3RWWkFXcDNUTUFxQ3lFcGpuU3lpU3BxS0REQllGb2oyT1M1?=
 =?utf-8?B?TEt6MENMTERSNWtmUjJyNURiMjNuTnF3TFg2NnY4MWRFUjFKUFdrdlp4MXNw?=
 =?utf-8?B?MDRKeHlFVkFEa0FCOXJXQkphTldtVFFwQ3pNT05UZk1JaElEU1BsYVhITWlk?=
 =?utf-8?B?MFFPM2c2VVdLQk1udXBOdmZqMUNYL3J5N0hsOTRhOVhFYVRvSVUvbmVoT3Jr?=
 =?utf-8?B?L05rKy9WQ1dVbmtFalFGK2tSTzJnZVdWc0U2ckZROUsvNTlyR04wdTNhcElQ?=
 =?utf-8?B?RDZxVm1COHllT3IzNWpyYWNQc0ZpZXl5dmEzYUNkbGdQRmV3MUY5YTA3OU5s?=
 =?utf-8?B?UEk1WHcyZFkyb05UZGd3RmliaHBleldTR2x6QXZYWGp2VnhaSHZjcSs0M2I5?=
 =?utf-8?B?UUFrYi9GQ1ExZWZ3c09NMlRqNkNrRk5hUU9uNVczeWh4RlFza3lZMnNZb1o2?=
 =?utf-8?B?OHVuY3JxUW8zTjl0MnptNU9Jb3JMUTZ1UGY2WitRTXNLQk40YVJIQW04TXpW?=
 =?utf-8?B?aUFCTzFsbnZWN1hjSk1TbVdEVlhnYThlVWJLY1ZvT3ZGbmRSMzZPSTBkOVQ1?=
 =?utf-8?B?Y0JrMVRUbE1DNWJwNENUTzI2WFh3cm9DeVBUYWJ6dUk1aFgwU0taYVBDY0F2?=
 =?utf-8?B?MUpBSi9QSmNVejEyQnIyUHY2Myt5bDlCZHF6SnYzUXlHUGVOSTQ4bkpOSC9M?=
 =?utf-8?B?RzJBVjRpeDZYdTR0RnpERHdDc0FIR0hYNUNBbDQrMzFOSFIvbXZtWnFwZXVI?=
 =?utf-8?B?S2N5d2RxVnRJbTlTRG5ZK2E0c2NhVURVbnVRb3dxNks3MWtwTFlZSEVmTTBt?=
 =?utf-8?B?ZDRCTjJXQTBlNWVaaWRQMnhFTE9jY2FpV0NINW85b3I5dmtCRUNTNnozMW1X?=
 =?utf-8?B?Q1dWQW9rQVF4bkJqUm1SRTIwQkMwTUlFSDRuOGt2SThNdGFrNk0zazNLVjEv?=
 =?utf-8?B?NStsMkViVGxaa3I3ZmpPUkZOMW91SDZYVy9UQjNTMEZmeTJVb09WSnJ4b2d0?=
 =?utf-8?B?bDZBa094Ym1XVFBaL251UGpPaUlQVHVRWkJVUXUxQVZQN2xLaEZrU0hkTHc5?=
 =?utf-8?B?aXczaXVqaDJxeWRjLzFCWDljRTV3eWdNYjhMUHZPZ1g4cVNlbnZoYXRObjUy?=
 =?utf-8?B?RnErWlpYV21WdTc0bTA2QXY0ZGM5Q0ZuMkNPcklZU21zU1JTaWhDNGhzdFhn?=
 =?utf-8?B?a1J5c2FtVC9pTVR0N2NJa0ZVdjZwUWd6QzVEN1hjSVJ2K1NFK053Nisva1V0?=
 =?utf-8?B?KzhXeVo3Y2xmS2NCZWN3dFZBclpIMy90ZmtVYmtkVWVsc1I2L2kxMTFpbGli?=
 =?utf-8?B?QVZvb3RDZGpqb0grZWtQQmkyUFhWTmFoNTFsTEJJMXJ0ZUozb3VpY1JxTzBw?=
 =?utf-8?B?VGJkT3p3ZTBJM0dZbkQ3NWRDOUkvU2xMeXlqRXFqd2g0dVpSM3d6eWU3bmJP?=
 =?utf-8?B?cTViMkp0TFZXSkd6QmJXMGtiM1AwaDRjRzN4cHpQL2E2MHl2bHQwWVQzVnJU?=
 =?utf-8?B?eGtUa01Jblp5bWxLdmZYNmxFVFU3Y0lXNFhUeVB5NjRic2ZHNjdIViszSis0?=
 =?utf-8?B?QTM4YTFjbzVVNnlKK3lVeWdNWUphY1ZxYUdUMWkyMzJ1Ly9QMWZJL3Z0Q0pN?=
 =?utf-8?B?d1hqTmFtdk9SUnMyN01FdWZaSlNIalhmenBQaWdyMkkybjh2M1hMbnlzSlRq?=
 =?utf-8?B?d2ZXRGRWV0VyRHRkQmtRSHIxUjQ0bDBxWUNpVkdtbSsvU2FPNk1xYW9FYWRp?=
 =?utf-8?B?TnRUUEIxN1NGWUwzZHY5YVM4aWxQUlRNN29TVzkzbnE1a1BGY2NnajQyVXow?=
 =?utf-8?B?RHJqM1JKV2NKdVROYkZ0Q1ZyOWhIKzVMbFJFNDJ1a3FpWGZydDBzNmZXOERu?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5cb0ba-e961-4bda-4263-08dd4f68f37c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:37:13.8403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQT4zHe/enYz50sKZeEqjnFVxIpRpx/po8athLC6B7k8G6x1j6T2mexH5Q44ATau0JDpl5Cnw5sKmpUZTt/FLkGKHYUZTJAZebVWkiUaszc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788
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

Hi Simon,

On 2/15/25 2:17 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Thu, 13 Feb 2025 at 06:54, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Quentin,
>>
>> On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>
>>> This gets rid of u-boot.rom generation as that was used only on Rockchip
>>> Chromebooks and their maintainer (Simon) seems to agree[1] that
>>> u-boot-rockchip-spi.bin should do the job now so we don't need to
>>> generate it anymore. This was agreed for RK3399 Chromebooks, I'm
>>> attempting to do the same for RK3288 Chromebooks as well so we don't
>>> have anything requiring that u-boot.rom anymore.
>>>
>>> Since HAS_ROM is only guarding this u-boot.rom generation, they are
>>> removed too from the individual configs.
>>>
>>> Finally, this also fixes an issue reported by Naoki[2] where binman
>>> would try to find symbols from proper to install in xPL binary only for
>>> it to not find it as we do not generate (on Aarch64) the proper binary
>>> in simple-bin-spi image node, only in simple-bin, so it cannot have
>>> access to the symbol. As to why this triggered only when some seemingly
>>> unrelated symbols are enabled, I do not know.
>>>
>>> The first two commits are cleanups. If they are controversial, they can
>>> be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
>>> {rk3288,rk3399}-u-boot.dtsi binman nodes.
>>>
>>> Note that none of the patches were tested outside of a simple build
>>> test.
>>
>> Are you able to run them through my lab?
>>
>>>
>>> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
>>> [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>> Quentin Schulz (3):
>>>        rockchip: rk3399: do not generate u-boot.rom anymore
>>>        rockchip: rk3288: do not generate u-boot.rom anymore
>>>        rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
>>>
>>>   arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
>>>   arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>>>   arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
>>>   arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
>>>   arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>>>   5 files changed, 10 insertions(+), 66 deletions(-)
>>> ---
>>> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
>>> change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
>>>
>>> Best regards,
>>> --
>>> Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>
> 
> I'm not sure if you have tried this yet.
> 

No I haven't.

> This series produces a SPI file but the size is not the right size
> (4MB). How could we solve that?
> 

Which board(s) do you have an issue with? What is supposed to be the 
right size?

Cheers,
Quentin
