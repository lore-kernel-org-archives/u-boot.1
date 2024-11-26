Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B585D6554E
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 18:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9751589CB5;
	Tue, 26 Nov 2024 19:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b2OHJ2av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E43189CB1; Tue, 26 Nov 2024 19:37:08 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF3D89CB6
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 19:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUTRuAEEEl04gj0jJWizLgz63eRbz0J2QoHkuubc4VriNjtAVW9a1wOoaIWMhcFwGx9L/yIehjuLo8QKD/EsW5bDK6N0u53BeZUpCVk/+V/gBfut24Q/GcwQ/Z+/EQEI3FmWg/es7rsA77jy34WPbm78M5niSVdfOmPAphg1HohdXGLdWOoW01QrHajJjzbz8tAK1S8ul6qTuRri6Z1goZzneP/8ggGONSbwndhYAQ29iDlkkv2+NUMSsufrppNq4XDc+DLUbo2jph0hkvCN7snTmvePZDjleKY8Gf8bPHKTsjEksHto8/oLP4/tKCv8ymKp1uGNCnUjmyaQ7k1VKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxImrOIgNg5XFBJQyM7EFrgU2mRoVpMWbl7czRwrfjY=;
 b=AHVLBRgS2qnivT0QHRxM9Q24H3odY9jXRZPJBFi225yX0BXPFOO6ve6zTAt2xN4SACCdUL0J2etoGcORxft+0fqyWabugJdQe2D8PLTwLO4s/H81a6Yvz+f5qJIWjJY5+ND01yvS/iUN/64hfxx7wvvW4hIlia0e86gi+JsaJ8VHu0HkkWd8kX/xauniFtowzHCk6qlnr+Y4HF1OfNh2Uxi9t6QCtkjoWw2CtyPcyo/g7Dsen9bVh24B0OzFQEqB3J7THLDzo1+RCwO0UFYdY/U7PDS5v849HWUMR0cQgEapoQF5lcvhK7Ryc+ZeOvIKK9t9OU1ssx92/AkUjHPWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxImrOIgNg5XFBJQyM7EFrgU2mRoVpMWbl7czRwrfjY=;
 b=b2OHJ2avZp4taCM1LEos6iz4A72y0OcWjbt0HT0lKaWLI+6csvi8XZt4HK+xx+Y0SuVe+JkI6qcgqOv0VJ8zcbMsOXYcIfm7qLngqGB5mWUvPAvFlWeOfmrl1zAOyhvzZi0dntEFtiVxeQ5//MrIrXunEsMyVx0BpFqzCTfD8WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 18:37:04 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 18:37:04 +0000
Message-ID: <7c1cd0e5-d119-4c61-b469-22e4012d86c8@cherry.de>
Date: Tue, 26 Nov 2024 19:37:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] rockchip: otp: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-17-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241121142731.1202209-17-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:803:118::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: e859d1c2-8aa0-4132-bd29-08dd0e4952ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJtb3RYZDJGendTQnpmRVRuR3QvU2Y5YnAvTDNlcVVGeUtDZklpZ1dManpW?=
 =?utf-8?B?cjQ1SitDam0zdWlBNTY0YS9pZTkrZ2pKakxYWXZmeW55WGl5YktaOWxVOGtE?=
 =?utf-8?B?NnNORU8rOXpaTVEreCtBdVNPNjlidjU2c1h4NFJzdjhuYUQrRDBwMEE4bUN6?=
 =?utf-8?B?S1JmKzFaWmxWbVBGMmlvZ3ByVWFJU01EL1BidDJJMHVLeWo0UXFjdVlXMFRq?=
 =?utf-8?B?UDJLVlhXN0p4ZTNMVVVLdVlIbmdXTnRxTEN5dmFhaHRvamxobHRoVTFGWjlt?=
 =?utf-8?B?TlM3NzhXcVc0aGpyNXlpQ2lFU2s5ZmVKN3U0SzAwdXROSnF3OVE0Z0crUEVv?=
 =?utf-8?B?a01NeXlQTVFzZEI2VnZLQUx1NEpubFJsU1d6bXpac1NFV0dPZnlQcytvTUUx?=
 =?utf-8?B?UXZyOFozQkZROGFIbm9EdHVQOENPYWRhQlhwY0NVWldweFMzQmxsVXNyNWRI?=
 =?utf-8?B?YXR4SWpoV1JNRGJsS2t3ZUVqa3NPMHV5aUJLdGVxZGlnSC9USzc4a29WOTd4?=
 =?utf-8?B?WmVnMy9YelI2ZHVUUXpiWUgzaDBpaGpSS05zNytJN2YwYTh3aVVCVngybThL?=
 =?utf-8?B?NFF4MDgzYWpDOHFIWitBMFNNK2IySHM2c0F2U1QzbUR0R1dIQkpwQWhoeXA2?=
 =?utf-8?B?SkhJdEpYSkZHRjYvc2l2bGtmUjdSeHpBdG1jQUR4QmRiNDY2eExaZVpKQ1N1?=
 =?utf-8?B?S09pKy9udGh3Rm1TVm91Y1M3UGd1ajhQeVRZTUhmdzJKa1JjV0xROTlhQzkx?=
 =?utf-8?B?Z2FwTlcxMU9jcmZtdGNHTlNSNC9QRXU0dm1JdG80bGpNNlB2akpPdlhlNmQw?=
 =?utf-8?B?OGV3aXFwd2dOVmczNVdhQThRcFRQVFZlSmUvMVNnK21OZFp5RHArREJYbFds?=
 =?utf-8?B?blZZc0dFOHJHMitIckpmSVZVRU1KNDJ5Z3liN1NPY0dWS1ZqZE11Y3YyNEVx?=
 =?utf-8?B?TGQ2aVh5a1lXMXozRGR2VXNqdW9mbGRjcDhDKzdCVi9LSHorNk9oeTI0L1Fn?=
 =?utf-8?B?bnB1OGhYdmVReU5OSUxURzdGREZnU2E2MzBNY1dzcHZ2cTdwRHRCcmZDVUZD?=
 =?utf-8?B?REdXa0xscHNZZkd5QzFhU1B3SUdQaEc1S014bHNiWnZrNnlSYnpMWU1kNWtV?=
 =?utf-8?B?SnZYTmQ3NHA0WTRsTEg3bEZYVVJoZXNDY01DRFRSVFJEMXpUR0lyTXI0ZzhN?=
 =?utf-8?B?NzdqQ21HRDJlUy9uQmczZVRabHMvVUFuVm9ZNG5iUzJacGZTKy81U3dJSW1B?=
 =?utf-8?B?MUdyL09mL21DL1lqY1ltQVQ3bXVvZnpjUVNJUjY5T29SZk1BcjZUL01tTE9w?=
 =?utf-8?B?TitML2xHNEtyQ0ZldnYyb05XVGtUNUdRK2tUWTNWeHVvSWYwUXhCTDQ0aWVF?=
 =?utf-8?B?UFAzd2xmNVNlOERhRGtoMVIrK0JBaVlkN1JBczZVZVQ4VHFxYllTV09jZXNr?=
 =?utf-8?B?STVUMnQ5b1JIeE53SUpHSiswa1pMS0oxbkZQTmphbFdUTDZjL3hIVExzdVJW?=
 =?utf-8?B?K3N5SytEa1BVTlUrTnRzSzhoWWVvZVg3bkkxWkdBaHRyRlc3cFQvdElyYXRN?=
 =?utf-8?B?T0U3MXVkcEdsbS80K3IweDJyWDhaMnBVS0hjdlVDeDgxeUNKcUwyeTBUYy9W?=
 =?utf-8?B?QS81eVpCdnBBbnpOOXY2amlZLzAzbWtrKzlOUmxKb1VKaDZYZVQyeTR3M1Yv?=
 =?utf-8?B?dXBwZGtCRXViV3p6NjUwOVhyU0JvbUN4T0Y4NU4xOW1wajdEd3BtUnJyMXVz?=
 =?utf-8?B?bVZ4ZDI0V1hpOXNQNlhndWdKenNOQXN4ajFrOWNUc09Oc044ZG5RZ2lkRUhj?=
 =?utf-8?B?dmVGMWJlTDhhdXB3N203QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBUTko0dnZuUGc4amVwS1FvaGFhN0VQSUtyWFRSU3l0QndKY0g1UkdSOTNE?=
 =?utf-8?B?SXpTYk4wYUowMDZWU0U1ZVBLMi93OEZqb3JJV2gwZEl3UjNLUENnTnFOWXEy?=
 =?utf-8?B?VHVyb0xvZmUzc25PeVVaVDdudmY5Z0RuaGI4aWp4MWVydFptd2RQT2NhZlFN?=
 =?utf-8?B?Wk5QOE1XM1dZVEhUeVZFcHd4aVNHcmhxZkU4ZFpDckFDMTBRWGZrdFpXa2g2?=
 =?utf-8?B?T3BiTEVxV2lTNGhkNTEvOE1HS0h3bHlBVGYvdkpTRTQ4ZHh5eWMrU2JkaE1V?=
 =?utf-8?B?c3F6UUxaSDYwWjJvWEFrZFZTdnhTUVoyblk3cWJ4K2R4M2NtSC9mUDhMdEN5?=
 =?utf-8?B?TTZWV3N5SnJRSnFuaU5HTkZMZWFUQ3hTOGdlWSs1WHptbUZ0M0padVZYOXVi?=
 =?utf-8?B?azJOMEN5WHNYM3pHcDZYWFRDT1RnRWxFMDhNTFBEdTErSGNDd09pVXZtVU1v?=
 =?utf-8?B?R0FidmtGMllYT1ZJczdXYTdwWks4VVpCb1AzZXg5K1RNcEMxK3N0Ym1FTFZJ?=
 =?utf-8?B?dy9DZmRrSlliVGRRY0RQSVhwZ0RLWG1sVStEQUFlRk1Pcis5R1k1WmVwMTZB?=
 =?utf-8?B?amd6aGxiUXNzUDdDTXVBUmxzSVcwb3hQWTUrOGhDN2pFT1AwVEhDZDNqWFNo?=
 =?utf-8?B?M2V3a25ZdUF6SjJ2ODR0U2Y0TGdlSW9GSnJieTR6S1pVQTQ4RzRqRHh6Ynll?=
 =?utf-8?B?a2lhbzYwUm92Nlc1bzByM3FDS2hYS040cTJ5REw0MkU3SHJ4dVVXTHJCamlE?=
 =?utf-8?B?dWJ4bVF0ZHlBTmV4OU0waWcvcW1sb2NkVnZGMkExUXZrRHlxSEtrTlJsbWxN?=
 =?utf-8?B?dWNQa3BiTEJKVklVdnpHeUZTSkZFL3c3OUNtRFFnTWREa2k0RFNHazkxK3di?=
 =?utf-8?B?RklUNTlJV2ZMeThVdWxPK2hCRVZLNHZ0eVR0Y0RUOW1nV1I0em9tZXdreVVj?=
 =?utf-8?B?d3kwN05kOEVxblBWS1o1Wk5jMzBESmV1NXZnMkxQYmt3elhpTmNBL1RBS3Rk?=
 =?utf-8?B?aERwUUxIMnJTYUxnaVJlRDE3Vk1HKzZVanM2MExjQ0FJNVdGVlhYK3dPYWpL?=
 =?utf-8?B?TXR2QkpidUhTWXl5SzdPdlpzMTlBNVVQd05lZm4xRHRnM0FsU0dSdmdNdnJu?=
 =?utf-8?B?TlZnZ1QvLzJKR2RpbCs0QSt6ZlhOY3VPbitIM1lkTjBFdGw0ZkI2eEJtUEhV?=
 =?utf-8?B?dDF5SmhHOVhUYVArWG9rSnFMeUVLZUdoNW8rZzRtd0hlN29IUnZJWW1keTlj?=
 =?utf-8?B?WjgxQUx4Nk5Fd3g5MjVud3N6VVVINEtDQjU2Q2x3ZitGNHFnWXRsbEN2Uzg5?=
 =?utf-8?B?clhMZGpvUTNoRmZRTVFJT0t0eklCU3RsRTJFdEVxc0J0RGlybEhzUGk5cEdx?=
 =?utf-8?B?RFlRK3Q0WnUwTGEyNGJTVEhkSjFzMlZxQmwrd1hsVFl0YnRkdS9XLzVnbjhJ?=
 =?utf-8?B?R2M5R1VOR1FrRDUzMENhaWVEd1ZaOVU2VXU0anNpbENzSUdnNTdFTVhNM2NM?=
 =?utf-8?B?U2tVOUk2NHh4ZjRtSlhvcmJXNkFFRjZiTjBSUTZOZWdLUFI0bmg3c1J3OEI4?=
 =?utf-8?B?dGhCZzVrcWkzUS9ubW42aFhlZjFNZ2dYaXlwYU5vYjJIV1JPa0QzSUd5endv?=
 =?utf-8?B?ZWZlOGt1UDY4cWRqRzdNclVXN0J1RGFVZjlwWUhZRzBLRDJKZHlWWEM0U3pV?=
 =?utf-8?B?SEE0UmdaM3RYdUNhT01vUXF5eStjd2p2cFErR0w0ZC9KRnZwMWQxbm1FMDhU?=
 =?utf-8?B?ak1SRkcvdmdDZTI5K2pYQTc2cFZhTTA4eVdVRUN5am5nTVhyZm1IRkxMMFQ0?=
 =?utf-8?B?dU9pU1pFUEptd1VzQVVVb3ZXMk9kcVE3VEV4UEJtald2ZlpFUkZ6SzEyRmJv?=
 =?utf-8?B?S0VmQ0R3VHJOQytpaGZiNUIxWVlOeldsVUIzLzJzY1lVa2ROT2hjaGNBWHBJ?=
 =?utf-8?B?V3RIS2l0UEVBS2w5Q1dENEduMDJiU29RU05rMnRGU042bTEyQi9IZlROc05F?=
 =?utf-8?B?MENoaDRiRWkweStlTVNobHFrV2k2S0Nqd2lFZ2laQ2JVaEc0cWp2YU9qbVU1?=
 =?utf-8?B?aXBkeTlUWjN3OU9vRmZHYXV6OFlac3JFUTlncUVQaFhwdmZ6RjJ1MjdzK3BF?=
 =?utf-8?B?REhjQlp6UTczZmlrQkVvWXRmQXMveVBSUUhodjZSU3V6OGdGd1lKV2JYSit4?=
 =?utf-8?Q?w1BG8QsmyerjJoVPyvap+sM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e859d1c2-8aa0-4132-bd29-08dd0e4952ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:37:04.1657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd0Cpi58sJyat8/28A+SsSaJiLaeV3CKh2HXkB0RR8kCOsBipfzCUEIzG52Z0W9bKPX6ZbJ0EBrBCE1H3mEc/onzQQS46uB3GQEcKOVEtT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860
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

Hi Heiko,

On 11/21/24 3:27 PM, Heiko Stuebner wrote:
> Add support for RK3588 compatible.

RK3576?

Cheers,
Quentin
