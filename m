Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E60D6553E
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 18:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FC78967D;
	Tue, 26 Nov 2024 19:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AVJBaif/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63089891AB; Tue, 26 Nov 2024 19:07:20 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E18889CA6
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 19:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPgyVwpNTAUPJaIqT9bh/9YjkKvP9oRBpvsemHwlZvxuYte9Hbqky9HP/9ujFJvT0MQTnRkDDLvkOL9q8teFLeYgXWiTjLYPpVGQ7oqgpAzU02jD2CTMzE7h35QSofGmxfGPPYLbnUrlbEdW6fwhC6PemfOmgjfvAzbgA1YYNUp+fa/gER0+7o9ncArjsKfx3rcpMTg82U/qwbC9SfC/TOhBfaaNpNeNtRvRBz8S99/yx6o6ct5lV1FI3TlxV6WyGfyrufwwJiCp0xTNILTjvABO7S4q1CjsBRvnJ6B55YK6+/o6J6AfVpffL/B5zqX+VJ5HfyaEetCzuNqdJ9+RGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5t2bj0CqruUdi6zDMsDgQXO3VQrDv0RY7pzuAv6Fig=;
 b=hzvJiV8UXRYlDusTslOgVsovBZ6hTY9w0+3yARVrQwojA9vqrZ0E0KiGpV6Qt0mHpxOBlBOMgbcJgF0Y7ZARyKAcq7MrBiX4DW+CyQQ24sT5/9fS2L0MmXi1ikFgJcpLjuFuvBQ7T81a+MS6ecyu+R8EjieC/vdOZ9j7Lsiflrni8k+zR0kEwvIA3R4o45RoOfrO5sda31JRqlyEWo0c9Kn3A1PadRZg8naBv+KlZrS55sUu9VFFEcq1DV5RVkW1DEYeWtAH+S4BHH/IwjQK3Gr0kFZt+SEleeTIA/EFNhbeMaj0QkmELZkx4/zKNW201K1Yaw0RXsHLo1u4/Kc6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5t2bj0CqruUdi6zDMsDgQXO3VQrDv0RY7pzuAv6Fig=;
 b=AVJBaif/Z/mdAKfdfCOJztjYsN5anw3nwGfKx2NEOXJ5LOoeAzpeJ9wnwoLNFRe49S/mm+gPRps4zsFg7dkvGRT8SMcKOvIOMqjqNLIMmqLYt2SFg9t94yydtTFpMSSl2tPpJaoI85r8Rkc9J50+nyxyepzm3OM+Mjxn5+LTFJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9073.eurprd04.prod.outlook.com (2603:10a6:102:225::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 18:07:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 18:07:12 +0000
Message-ID: <993cb2c6-892a-4deb-b476-c522287958d2@cherry.de>
Date: Tue, 26 Nov 2024 19:07:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] arm: rockchip: Add RK3576 arch core support
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-12-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241121142731.1202209-12-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c1acea-58aa-45f0-4afc-08dd0e45269a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUYyUHVNd0xFVVFhS25Kb2dhaFl6VkgvRUdydHRqTk1HbHF6K28yN2d1YmtP?=
 =?utf-8?B?dC85ZXdzSUFjR0xFRVFSOFkyMXpnVERBRHdsb1VaYUVlVDVTNjN2c0VBRmZO?=
 =?utf-8?B?YVBhTWpUc3ByQXMwS0Z3OUdqYVBOd3A3R000aVRianVQV2RLZmVqeGUwRHZq?=
 =?utf-8?B?a2pkczU5NVpLek11YkM0MkVRUDFvNHhNbjVhSjFFR1hDL1BPbjFoNGlYSzVI?=
 =?utf-8?B?K29FRkZVc1hxSkpYT2lwai9RSjFiOWxYd2FkdGdmdGdISkFhazR5K3N3VjBS?=
 =?utf-8?B?bjMwZ1FzMmJCRGJoNUVGQkNMbCtyZTU4UTh6Q1J4Mkw3OEJtNS9iTklYbWVU?=
 =?utf-8?B?NWJ1M1J6cTZVRVBrS3dIRU5aRS9pdmRNZ1hEaENIeUV0YkY0SEhQQzNmaFBt?=
 =?utf-8?B?L0MxaDFSbE9DcWp2SzdBTHJhVk9yYWUwUmRRSUNtOU1iS3JhTjd0QU9GNFNz?=
 =?utf-8?B?QnBKRUFUNmltbENCU0NCa05vd1RScXIwazBFaWowcm5PdWJVMXFuMFA2L09n?=
 =?utf-8?B?dkErdUdLZU1FSUhCU2g1V0J0TVRPcy9wTDRsbkM2dVZEUEFMNlhrR2oyOXl0?=
 =?utf-8?B?dXdVZ3ZXVnZubmxaQkFRTXdNZTdGdlc1VVVtWUp2SUcvTnQwQkVuRHZWbGpY?=
 =?utf-8?B?dCtza3duQnVqeWxTYS9lMG1DREFlOXJGSExJV3ZSL3RYNGdtU09jaGpnbU0y?=
 =?utf-8?B?emtyeFBZL0ljWTVSZUFKcmVHcCt5Snh1V2UrOGlyckRQZExCcUJFMzdNZEVp?=
 =?utf-8?B?c0lHK3FsTXk5enBhbXRVYnFlZGRHYXVSemJ6OVJYRUpmWlhXVllEVHlMYXRQ?=
 =?utf-8?B?SlFCYlNvRUhZaTBsV2lqUzhnTFkxcG1yeHhIQWpvZHFNOFJGUGhQa2JabWtS?=
 =?utf-8?B?QTVNVnN1endTbzlMUjlNbzJaYUIvZzNhVnFqNnFtYlhxSjFQV0U4RXpyNnYv?=
 =?utf-8?B?eWhMOCtUMjIwNVhUMkFKQ2JjMkFsSzZsVEV1MHZ6dHlRNnBKRGZ3ZkVodDh3?=
 =?utf-8?B?Y2ZoaW4xcEhwbjhJc01qODgrc3NLQUpFaGxoS3NvSkRpbTNxZUd6enFaQUdx?=
 =?utf-8?B?MWRnY1c5d0l4enVVQTljai9aaWVteFlkbG11SkxkaHB4ZmFhbEt3QVJjTklL?=
 =?utf-8?B?K2NWYjRlc3JKbFF4bWtDODVhb3BxQmRsTURic2tSaERXWmRMYTFkd2MzZkZM?=
 =?utf-8?B?RTJyVi84akNMNFdUd05lVFJDVHJHUWZ0VUR3a3UvYlFkVEZmS1o1UlpBcDR5?=
 =?utf-8?B?WTQ0RnNQWWRUTkEwQi9seUp2eXdKRnA1NFVyWU81eWJsbmlsZk15TnRBUWp0?=
 =?utf-8?B?VVZtNmdsQ2kxS1lZZlkycUlHS012dW41cXRkQzhoZ21iZ1p4TFcyZ3NaUEps?=
 =?utf-8?B?d3RJdzVEMXhVTHAxM3BPMk9jOFdWT0lUYzA3a2FDV01TL0F2UEhXY1RRTkhE?=
 =?utf-8?B?bjl4eHpTOENJSmFzUVNhZTJFUDFmQysxYW5lbElEc3lmNGFZUS9sdVdFeEc0?=
 =?utf-8?B?eXlxK3ZsSXZUREJuQ29sT3NldEUreDVRUzE0cThtZWZ0SWlCZTVBZVlFNzRp?=
 =?utf-8?B?b1NIOVVnZmx4OVVTQzkzQnhzUVlTckJtNEpUWEViRDZoRHB6TFBkOHhkd2hM?=
 =?utf-8?B?RHBSL2dlQ3FnMzRzSVZPZktPdTdlU3p5L0FhV2hhcWkzU2hhOGhFaEdvS05S?=
 =?utf-8?B?VDcyQXAwZlZ0UlEyNWFzQ3JkMjB1NExxbzlaMTczby9NR3dXOVRQc0VPak9m?=
 =?utf-8?B?dllldkk0S3QvUlF1UGtYL29NMVVwM1A1ODMwZzhUaHVFWTZMaUpFMDh2aG1m?=
 =?utf-8?B?d1d4Z3QvcThkcE8xUnk3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE12bjV5dWg4dGp5djB4WkNzWmQzU0tQNW9YYkVwb1RJbHl5akk4Y3E0R29Z?=
 =?utf-8?B?UTFkR3plTEd4RjZocjhQYkFDckRpdVQ1RWRCZk5jbXdpaEdPMEcrRFAvMTB1?=
 =?utf-8?B?WS85Sm5Wc0dtcGZkTTdwY3AzanJBN1NFOFkvVTE4dDZFNW81WWp3dS8vU3Rp?=
 =?utf-8?B?SEZEZW1vZUMxY1hORXIvU3N6WGs0ODMzc1ZuNzhHUzNTMmpVUFg3cEEzNGZa?=
 =?utf-8?B?Q1FQV3EwZHVrSlBQcXZReWFjSE9jTWY5OHJDeExuUHZlRnI5MHFJaUFwc3VD?=
 =?utf-8?B?b2JYY1BnNHpqbHVlMEY0Mk9oV21GQm0vTFJBdGhCZ1QzR21IbVB4NGxZdlJL?=
 =?utf-8?B?eEFiOVVZbzVTWGNldVhaSUh5YmRUT21IL1lSNWowbDRHNlhwaGtlRFJNcWZ6?=
 =?utf-8?B?TnQrZWcwakw1cStERE4rVjVuUHY1cjU4Vi84R09pNnM4ZzNjZ2JHZUNNT29k?=
 =?utf-8?B?U3ZaVUF6NjFPVUJiZGpBajBBckFtU01jMjZQRnNZMXdhUlpkbVhnSEtVYzVP?=
 =?utf-8?B?T3BxYVhHVmJiZ0JIek9QZjJrdzRtcVMxOXdnVlAveUVTR21jeHVwNXJBUkN3?=
 =?utf-8?B?K1JZRERWZE8xSllIampEaXVMV0VoelljY21iUmZlc3JrZWF4TUZNY2VWclJp?=
 =?utf-8?B?TEpwKzMrT2E2UzBPZTUrczNuWU9CWi9YY09NYUJCWUZpcTNIUXhUakNSQU8x?=
 =?utf-8?B?QWh2UmJSTjNJMkMzbC9HSk8rRUtqYTJzenJJYk1vSk5EVWNleGNHWkVsUmdF?=
 =?utf-8?B?clpHMXA3VjRDcDh2eHdibXFkcTgxdk1BT3F0OXU1LzNkVXJvKzRVNHQ2aXp6?=
 =?utf-8?B?Z0I1ZXZnUWhDMThpWlVpQTBGWTVMZEF0c3Vzd2xLOUNGT2QrUXB2T1Fhb3NL?=
 =?utf-8?B?SjJ5V24xOUk4MllSLzl5TUQ2cTJuNE82am5aaFNvc2ptbU5oMVFDNVExNXVj?=
 =?utf-8?B?R1dXWVNLZTZURUpmNGtETkx5ZGlkczc5YWRMZ1cxWkcyZXdHejYvZHkraHgr?=
 =?utf-8?B?V0ZBbzAvTFkwbGJrdDQ3SlNaV1FjU3lybUFEa3dIV2RlSHhDRHBPckk3U0cw?=
 =?utf-8?B?OXJHQUpGVGhrcDhVeSswc2NJNEc5YU9CL2lDU056cXU1WUtaOGh2QWpnQjNo?=
 =?utf-8?B?ZHQwQ2tQR3NKMHBVSWk2a096MDBpTVlrVmVVYnl1REk1VXhSc1l6Q2tWUzlz?=
 =?utf-8?B?Rmc4U2xPUEtYODFFamNCYy9zeHRyVTNYamg4b1dHVDhqbjNOemE1T1F3WkpY?=
 =?utf-8?B?U0syc1BQaCtoc0pJVXRmSFJrWmgxQ0NyUUxDbERMVDkyQWY3ZS9vd0QzZ3Jh?=
 =?utf-8?B?V0tBcFZ5R2tIOHRLUDJyR3BqL01CUDIyekFNVTdUbkRwR0owSWxER2VNS1dK?=
 =?utf-8?B?bC9Fakl1ZHZKd2RBTzFkbGhHUjNNcldheHlaRHUxTDBnQi85dmphL3F6TTFj?=
 =?utf-8?B?d1QyMXNWa3dPSW5mV3M4cVgydkppaXlDRFV2cTR5N216Y0FmWE9LbjRwUzhO?=
 =?utf-8?B?U3J1b2hkQm1COXdQdGkzeithcWxEYVJzenJIQ1Y1NjNQSVhISTNya21UMEtB?=
 =?utf-8?B?VkRzT1RGcXNQb0tNaitIUVFwWFBGVy9oRGtwcDBoR0xaNktXbDgvNnFGZUw4?=
 =?utf-8?B?UWVBdTM5V3JZL1pkSEZYelVPNC9rTmRncjNFbHRHbGh3UmJCT0FKNVhGNzZY?=
 =?utf-8?B?U3VKUGRDRmF2dENMU285czBTYzlmZUhJeittTHhFQVB6SUJVa0ZQNEhvaWtq?=
 =?utf-8?B?d05RczQwZXl2d2FmTnk3WFdFRnpMNXZvTWJiWGJ0RnBiMkttcHBEdnZBSklG?=
 =?utf-8?B?b1JaTzByMmRZZUNJZjZFT1UzWHRBK0lUNDFPUlZGNFBHajJkbkhLdGRXT0Ex?=
 =?utf-8?B?U2pRWit3cWFBclFZdXpjcXo0aHpCQmc0Z2hyNlZlY1EwM05WTG9lOUVid1dk?=
 =?utf-8?B?THJad1FyZE9YSmNjcjBkYXllbXJkMVUyQU5oS0hPbDExL09DVUwxSk8vajI3?=
 =?utf-8?B?SFBEWlBjZEdydXJOUUVzRGdnZm45SkJEMDRJQ2Jyd3hyRm9NR2lhdGFicndN?=
 =?utf-8?B?VFhBNWNiTzRhM1NML1h2TmU3VlZuZFRPeWhSc1FuaXZ2L2ppdGVib2NWUmow?=
 =?utf-8?B?WmZ3MnA1ZlFHeTRTUGs5OXVybjcrSTFxWGNZOFlYOHVOSTloNkVGOS9zMUds?=
 =?utf-8?Q?1RB+evyS8Hzq4MpXQz9E5uA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1acea-58aa-45f0-4afc-08dd0e45269a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:07:12.6411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdSOI4hHVyTfrcrD4qV7GByZ9/Ejyn/+ch/ZDWiAp73a5x7dMsHbGMW9EJKfmsvH8lHu9jPQC/E6jLmbLkFCsSzCXSL89NmahAAxwhwE/CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9073
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
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
> 
> The Rockchip RK3588 is a ARM-based SoC with quad-core Cortex-A72

Probably rather RK3576 :)

> and quad-core Cortex-A53 including 6TOPS NPU, Mali-G52 MC3, HDMI Out,
> DP, eDP, MIPI DSI, MIPI CSI2, LPDDR4/4X/5, eMMC5.1, SD3.0/MMC4.5, UFS,
> USB OTG 3.0, Type-C, USB 2.0, PCIe 2.1, SATA 3, Ethernet, SDIO3.0, I2C,
> UART, SPI, GPIO and PWM.
> 
> Add arch core support for it.
> 
> Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
> [adapted for mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi               | 119 +++++++++
>   arch/arm/include/asm/arch-rk3576/boot0.h      |  11 +
>   arch/arm/include/asm/arch-rk3576/gpio.h       |  11 +
>   .../include/asm/arch-rockchip/grf_rk3576.h    | 225 ++++++++++++++++
>   .../include/asm/arch-rockchip/ioc_rk3576.h    | 244 ++++++++++++++++++
>   arch/arm/mach-rockchip/Kconfig                |  46 +++-
>   arch/arm/mach-rockchip/Makefile               |   1 +
>   arch/arm/mach-rockchip/rk3576/Kconfig         |  48 ++++
>   arch/arm/mach-rockchip/rk3576/Makefile        |   9 +
>   arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  32 +++
>   arch/arm/mach-rockchip/rk3576/rk3576.c        | 169 ++++++++++++
>   arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |  26 ++
>   arch/arm/mach-rockchip/sdram.c                |   1 +
>   doc/board/rockchip/rockchip.rst               |   9 +
>   include/configs/rk3576_common.h               |  42 +++
>   15 files changed, 992 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
>   create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
>   create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rk3576.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
>   create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
>   create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
>   create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
>   create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
>   create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>   create mode 100644 include/configs/rk3576_common.h
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> new file mode 100644
> index 00000000000..1399faf47df
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.

Not sure this is the appropriate copyright holder here.

> + */
> +
> +#include "rockchip-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +
> +	dmc {
> +		compatible = "rockchip,rk3576-dmc";
> +		bootph-all;
> +	};
> +};
> +
> +&cru {
> +	bootph-all;
> +};
> +
> +&emmc_bus8 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&emmc_strb {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&pcfg_pull_down {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_none {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up_drv_level_2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&php_grf {
> +	bootph-all;
> +};
> +
> +&pinctrl {
> +	bootph-all;
> +};
> +
> +&pmu1_grf {
> +	bootph-all;
> +};
> +
> +&sdhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&sdmmc0_bus4 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_clk {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_cmd {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdmmc0_det {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sys_grf {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0m0_xfer {
> +	bootph-all;
> +};
> +
> +&xin24m {
> +	bootph-all;
> +};
> diff --git a/arch/arm/include/asm/arch-rk3576/boot0.h b/arch/arm/include/asm/arch-rk3576/boot0.h
> new file mode 100644
> index 00000000000..dea2b20252d
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rk3576/boot0.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __ASM_ARCH_BOOT0_H__
> +#define __ASM_ARCH_BOOT0_H__
> +
> +#include <asm/arch-rockchip/boot0.h>
> +
> +#endif
> diff --git a/arch/arm/include/asm/arch-rk3576/gpio.h b/arch/arm/include/asm/arch-rk3576/gpio.h
> new file mode 100644
> index 00000000000..b48c0a5cf84
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rk3576/gpio.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __ASM_ARCH_GPIO_H__
> +#define __ASM_ARCH_GPIO_H__
> +
> +#include <asm/arch-rockchip/gpio.h>
> +
> +#endif
> diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3576.h b/arch/arm/include/asm/arch-rockchip/grf_rk3576.h
> new file mode 100644
> index 00000000000..0db7f5277f5
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rockchip/grf_rk3576.h
> @@ -0,0 +1,225 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
> + */
> +#ifndef _ASM_ARCH_GRF_RK3576_H
> +#define _ASM_ARCH_GRF_RK3576_H
> +
> +/* usb2phy_grf register structure define */
> +struct rk3576_usb2phygrf {
> +	unsigned int con[6];                  /* address offset: 0x0000 */
> +	unsigned int reserved0018[2];         /* address offset: 0x0018 */
> +	unsigned int ls_con;                  /* address offset: 0x0020 */
> +	unsigned int dis_con;                 /* address offset: 0x0024 */
> +	unsigned int bvalid_con;              /* address offset: 0x0028 */
> +	unsigned int id_con;                  /* address offset: 0x002c */
> +	unsigned int vbusvalid_con;           /* address offset: 0x0030 */
> +	unsigned int reserved0034[3];         /* address offset: 0x0034 */
> +	unsigned int dbg_con[1];              /* address offset: 0x0040 */
> +	unsigned int linest_timeout;          /* address offset: 0x0044 */
> +	unsigned int linest_deb;              /* address offset: 0x0048 */
> +	unsigned int rx_timeout;              /* address offset: 0x004c */
> +	unsigned int seq_limt;                /* address offset: 0x0050 */
> +	unsigned int linest_cnt_st;           /* address offset: 0x0054 */
> +	unsigned int dbg_st;                  /* address offset: 0x0058 */
> +	unsigned int rx_cnt_st;               /* address offset: 0x005c */
> +	unsigned int reserved0060[8];         /* address offset: 0x0060 */
> +	unsigned int st[1];                   /* address offset: 0x0080 */
> +	unsigned int reserved0084[15];        /* address offset: 0x0084 */
> +	unsigned int int_en;                  /* address offset: 0x00c0 */
> +	unsigned int int_st;                  /* address offset: 0x00c4 */
> +	unsigned int int_st_clr;              /* address offset: 0x00c8 */
> +	unsigned int reserved00cc;            /* address offset: 0x00cc */
> +	unsigned int detclk_sel;              /* address offset: 0x00d0 */
> +};
> +
> +check_member(rk3576_usb2phygrf, detclk_sel, 0x00d0);
> +
> +/* php_grf register structure define */
> +struct rk3576_phpgrf {
> +	unsigned int mmubp_st;                /* address offset: 0x0000 */
> +	unsigned int mmubp_con[1];            /* address offset: 0x0004 */
> +	unsigned int mmu0_con;                /* address offset: 0x0008 */
> +	unsigned int mmu1_con;                /* address offset: 0x000c */
> +	unsigned int mem_con[3];              /* address offset: 0x0010 */
> +	unsigned int sata0_con;               /* address offset: 0x001c */
> +	unsigned int sata1_con;               /* address offset: 0x0020 */
> +	unsigned int usb3otg1_status_lat[2];  /* address offset: 0x0024 */
> +	unsigned int usb3otg1_status_cb;      /* address offset: 0x002c */
> +	unsigned int usb3otg1_status;         /* address offset: 0x0030 */
> +	unsigned int usb3otg1_con[2];         /* address offset: 0x0034 */
> +	unsigned int reserved003c[3];         /* address offset: 0x003c */
> +	unsigned int pciepipe_con[1];         /* address offset: 0x0048 */
> +	unsigned int reserved004c[2];         /* address offset: 0x004c */
> +	unsigned int pcie_clkreq_st;          /* address offset: 0x0054 */
> +	unsigned int reserved0058;            /* address offset: 0x0058 */
> +	unsigned int mmu0_st[5];              /* address offset: 0x005c */
> +	unsigned int mmu1_st[5];              /* address offset: 0x0070 */
> +};
> +
> +check_member(rk3576_phpgrf, mmu1_st, 0x0070);
> +
> +/* pmu0_grf register structure define */
> +struct rk3576_pmu0grf {
> +	unsigned int soc_con[7];              /* address offset: 0x0000 */
> +	unsigned int reserved001c;            /* address offset: 0x001c */
> +	unsigned int io_ret_con[2];           /* address offset: 0x0020 */
> +	unsigned int reserved0028[2];         /* address offset: 0x0028 */
> +	unsigned int mem_con;                 /* address offset: 0x0030 */
> +	unsigned int reserved0034[3];         /* address offset: 0x0034 */
> +	unsigned int os_reg[8];               /* address offset: 0x0040 */
> +};
> +
> +check_member(rk3576_pmu0grf, os_reg, 0x0040);
> +
> +/* pmu0_sgrf register structure define */
> +struct rk3576_pmu0sgrf {
> +	unsigned int soc_con[3];              /* address offset: 0x0000 */
> +	unsigned int reserved000c[13];        /* address offset: 0x000c */
> +	unsigned int dcie_con[8];             /* address offset: 0x0040 */
> +	unsigned int dcie_wlock;              /* address offset: 0x0060 */
> +};
> +
> +check_member(rk3576_pmu0sgrf, dcie_wlock, 0x0060);
> +
> +/* pmu1_grf register structure define */
> +struct rk3576_pmu1grf {
> +	unsigned int soc_con[8];              /* address offset: 0x0000 */
> +	unsigned int reserved0020[12];        /* address offset: 0x0020 */
> +	unsigned int biu_con;                 /* address offset: 0x0050 */
> +	unsigned int biu_status;              /* address offset: 0x0054 */
> +	unsigned int reserved0058[2];         /* address offset: 0x0058 */
> +	unsigned int soc_status;              /* address offset: 0x0060 */
> +	unsigned int reserved0064[7];         /* address offset: 0x0064 */
> +	unsigned int mem_con[2];              /* address offset: 0x0080 */
> +	unsigned int reserved0088[30];        /* address offset: 0x0088 */
> +	unsigned int func_rst_status;         /* address offset: 0x0100 */
> +	unsigned int func_rst_clr;            /* address offset: 0x0104 */
> +	unsigned int reserved0108[2];         /* address offset: 0x0108 */
> +	unsigned int sd_detect_con;           /* address offset: 0x0110 */
> +	unsigned int sd_detect_sts;           /* address offset: 0x0114 */
> +	unsigned int sd_detect_clr;           /* address offset: 0x0118 */
> +	unsigned int sd_detect_cnt;           /* address offset: 0x011c */
> +	unsigned int reserved0120[56];        /* address offset: 0x0120 */
> +	unsigned int os_reg[16];              /* address offset: 0x0200 */
> +};
> +
> +check_member(rk3576_pmu1grf, os_reg, 0x0200);
> +
> +/* pmu1_sgrf register structure define */
> +struct rk3576_pmu1sgrf {
> +	unsigned int soc_con[18];             /* address offset: 0x0000 */
> +};
> +
> +check_member(rk3576_pmu1sgrf, soc_con, 0x0000);
> +
> +/* sdgmac_grf register structure define */
> +struct rk3576_sdgmacgrf {
> +	unsigned int mem_con[5];              /* address offset: 0x0000 */
> +	unsigned int reserved0014[2];         /* address offset: 0x0014 */
> +	unsigned int gmac_st[1];              /* address offset: 0x001c */
> +	unsigned int gmac0_con;               /* address offset: 0x0020 */
> +	unsigned int gmac1_con;               /* address offset: 0x0024 */
> +	unsigned int gmac0_tp[2];             /* address offset: 0x0028 */
> +	unsigned int gmac1_tp[2];             /* address offset: 0x0030 */
> +	unsigned int gmac0_cmd;               /* address offset: 0x0038 */
> +	unsigned int gmac1_cmd;               /* address offset: 0x003c */
> +	unsigned int reserved0040[2];         /* address offset: 0x0040 */
> +	unsigned int mem_gate_con;            /* address offset: 0x0048 */
> +};
> +
> +check_member(rk3576_sdgmacgrf, mem_gate_con, 0x0048);
> +
> +/* sys_grf register structure define */
> +struct rk3576_sysgrf {
> +	unsigned int soc_con[13];             /* address offset: 0x0000 */
> +	unsigned int reserved0034[3];         /* address offset: 0x0034 */
> +	unsigned int biu_con[6];              /* address offset: 0x0040 */
> +	unsigned int reserved0058[2];         /* address offset: 0x0058 */
> +	unsigned int biu_status[8];           /* address offset: 0x0060 */
> +	unsigned int mem_con[19];             /* address offset: 0x0080 */
> +	unsigned int reserved00cc[29];        /* address offset: 0x00cc */
> +	unsigned int soc_status[2];           /* address offset: 0x0140 */
> +	unsigned int memfault_status[2];      /* address offset: 0x0148 */
> +	unsigned int reserved0150[12];        /* address offset: 0x0150 */
> +	unsigned int soc_code;                /* address offset: 0x0180 */
> +	unsigned int reserved0184[3];         /* address offset: 0x0184 */
> +	unsigned int soc_version;             /* address offset: 0x0190 */
> +	unsigned int reserved0194[3];         /* address offset: 0x0194 */
> +	unsigned int chip_id;                 /* address offset: 0x01a0 */
> +	unsigned int reserved01a4[3];         /* address offset: 0x01a4 */
> +	unsigned int chip_version;            /* address offset: 0x01b0 */
> +};
> +
> +check_member(rk3576_sysgrf, chip_version, 0x01b0);
> +
> +/* sys_sgrf register structure define */
> +struct rk3576_syssgrf {
> +	unsigned int ddr_bank_hash_ctrl;      /* address offset: 0x0000 */
> +	unsigned int ddr_bank_mask[4];        /* address offset: 0x0004 */
> +	unsigned int ddr_rank_mask[1];        /* address offset: 0x0014 */
> +	unsigned int reserved0018[2];         /* address offset: 0x0018 */
> +	unsigned int soc_con[21];             /* address offset: 0x0020 */
> +	unsigned int reserved0074[3];         /* address offset: 0x0074 */
> +	unsigned int dmac0_con[10];           /* address offset: 0x0080 */
> +	unsigned int reserved00a8[22];        /* address offset: 0x00a8 */
> +	unsigned int dmac1_con[10];           /* address offset: 0x0100 */
> +	unsigned int reserved0128[22];        /* address offset: 0x0128 */
> +	unsigned int dmac2_con[10];           /* address offset: 0x0180 */
> +	unsigned int reserved01a8[22];        /* address offset: 0x01a8 */
> +	unsigned int key_con[2];              /* address offset: 0x0200 */
> +	unsigned int key_wlock;               /* address offset: 0x0208 */
> +	unsigned int reserved020c[13];        /* address offset: 0x020c */
> +	unsigned int soc_status;              /* address offset: 0x0240 */
> +	unsigned int reserved0244[47];        /* address offset: 0x0244 */
> +	unsigned int ip_info_con;             /* address offset: 0x0300 */
> +};
> +
> +check_member(rk3576_syssgrf, ip_info_con, 0x0300);
> +
> +/* ufs_grf register structure define */
> +struct rk3576_ufsgrf {
> +	unsigned int clk_ctrl;                /* address offset: 0x0000 */
> +	unsigned int uic_src_sel;             /* address offset: 0x0004 */
> +	unsigned int ufs_state_ie;            /* address offset: 0x0008 */
> +	unsigned int ufs_state_is;            /* address offset: 0x000c */
> +	unsigned int ufs_state;               /* address offset: 0x0010 */
> +	unsigned int reserved0014[13];        /* address offset: 0x0014 */
> +};
> +
> +check_member(rk3576_ufsgrf, reserved0014, 0x0014);
> +
> +/* usbdpphy_grf register structure define */
> +struct rk3576_usbdpphygrf {
> +	unsigned int reserved0000;            /* address offset: 0x0000 */
> +	unsigned int con[3];                  /* address offset: 0x0004 */
> +	unsigned int reserved0010[29];        /* address offset: 0x0010 */
> +	unsigned int status[1];               /* address offset: 0x0084 */
> +	unsigned int reserved0088[14];        /* address offset: 0x0088 */
> +	unsigned int lfps_det_con;            /* address offset: 0x00c0 */
> +	unsigned int int_en;                  /* address offset: 0x00c4 */
> +	unsigned int int_status;              /* address offset: 0x00c8 */
> +};
> +
> +check_member(rk3576_usbdpphygrf, int_status, 0x00c8);
> +
> +/* usb_grf register structure define */
> +struct rk3576_usbgrf {
> +	unsigned int mmubp_st;                /* address offset: 0x0000 */
> +	unsigned int mmubp_con;               /* address offset: 0x0004 */
> +	unsigned int mmu2_con;                /* address offset: 0x0008 */
> +	unsigned int mem_con0;                /* address offset: 0x000c */
> +	unsigned int mem_con1;                /* address offset: 0x0010 */
> +	unsigned int reserved0014[2];         /* address offset: 0x0014 */
> +	unsigned int usb3otg0_status_lat[2];  /* address offset: 0x001c */
> +	unsigned int usb3otg0_status_cb;      /* address offset: 0x0024 */
> +	unsigned int usb3otg0_status;         /* address offset: 0x0028 */
> +	unsigned int usb3otg0_con[2];         /* address offset: 0x002c */
> +	unsigned int reserved0034[4];         /* address offset: 0x0034 */
> +	unsigned int mmu2_st[5];              /* address offset: 0x0044 */
> +	unsigned int mem_con[1];              /* address offset: 0x0058 */
> +};
> +
> +check_member(rk3576_usbgrf, mem_con, 0x0058);
> +
> +#endif /*  _ASM_ARCH_GRF_RK3576_H  */
> diff --git a/arch/arm/include/asm/arch-rockchip/ioc_rk3576.h b/arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
> new file mode 100644
> index 00000000000..9fd24b502bb
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
> @@ -0,0 +1,244 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
> + */
> +#ifndef _ASM_ARCH_IOC_RK3576_H
> +#define _ASM_ARCH_IOC_RK3576_H
> +
> +/* pmu0_ioc register structure define */
> +struct rk3576_pmu0_ioc_reg {
> +	unsigned int gpio0a_iomux_sel_l;  /* address offset: 0x0000 */
> +	unsigned int gpio0a_iomux_sel_h;  /* address offset: 0x0004 */
> +	unsigned int gpio0b_iomux_sel_l;  /* address offset: 0x0008 */
> +	unsigned int reserved000c;        /* address offset: 0x000c */
> +	unsigned int gpio0a_ds_l;         /* address offset: 0x0010 */
> +	unsigned int gpio0a_ds_h;         /* address offset: 0x0014 */
> +	unsigned int gpio0b_ds_l;         /* address offset: 0x0018 */
> +	unsigned int reserved001c;        /* address offset: 0x001c */
> +	unsigned int gpio0a_pull;         /* address offset: 0x0020 */
> +	unsigned int gpio0b_pull_l;       /* address offset: 0x0024 */
> +	unsigned int gpio0a_ie;           /* address offset: 0x0028 */
> +	unsigned int gpio0b_ie_l;         /* address offset: 0x002c */
> +	unsigned int gpio0a_smt;          /* address offset: 0x0030 */
> +	unsigned int gpio0b_smt_l;        /* address offset: 0x0034 */
> +	unsigned int gpio0a_pdis;         /* address offset: 0x0038 */
> +	unsigned int gpio0b_pdis_l;       /* address offset: 0x003c */
> +	unsigned int osc_con;             /* address offset: 0x0040 */
> +};
> +
> +check_member(rk3576_pmu0_ioc_reg, osc_con, 0x0040);
> +
> +/* pmu1_ioc register structure define */
> +struct rk3576_pmu1_ioc_reg {
> +	unsigned int gpio0b_iomux_sel_h;  /* address offset: 0x0000 */
> +	unsigned int gpio0c_iomux_sel_l;  /* address offset: 0x0004 */
> +	unsigned int gpio0c_iomux_sel_h;  /* address offset: 0x0008 */
> +	unsigned int gpio0d_iomux_sel_l;  /* address offset: 0x000c */
> +	unsigned int gpio0d_iomux_sel_h;  /* address offset: 0x0010 */
> +	unsigned int gpio0b_ds_h;         /* address offset: 0x0014 */
> +	unsigned int gpio0c_ds_l;         /* address offset: 0x0018 */
> +	unsigned int gpio0c_ds_h;         /* address offset: 0x001c */
> +	unsigned int gpio0d_ds_l;         /* address offset: 0x0020 */
> +	unsigned int gpio0d_ds_h;         /* address offset: 0x0024 */
> +	unsigned int gpio0b_pull_h;       /* address offset: 0x0028 */
> +	unsigned int gpio0c_pull;         /* address offset: 0x002c */
> +	unsigned int gpio0d_pull;         /* address offset: 0x0030 */
> +	unsigned int gpio0b_ie_h;         /* address offset: 0x0034 */
> +	unsigned int gpio0c_ie;           /* address offset: 0x0038 */
> +	unsigned int gpio0d_ie;           /* address offset: 0x003c */
> +	unsigned int gpio0b_smt_h;        /* address offset: 0x0040 */
> +	unsigned int gpio0c_smt;          /* address offset: 0x0044 */
> +	unsigned int gpio0d_smt;          /* address offset: 0x0048 */
> +	unsigned int gpio0b_pdis_h;       /* address offset: 0x004c */
> +	unsigned int gpio0c_pdis;         /* address offset: 0x0050 */
> +	unsigned int gpio0d_pdis;         /* address offset: 0x0054 */
> +};
> +
> +check_member(rk3576_pmu1_ioc_reg, gpio0d_pdis, 0x0054);
> +
> +/* top_ioc register structure define */
> +struct rk3576_top_ioc_reg {
> +	unsigned int reserved0000[2];     /* address offset: 0x0000 */
> +	unsigned int gpio0b_iomux_sel_l;  /* address offset: 0x0008 */
> +	unsigned int gpio0b_iomux_sel_h;  /* address offset: 0x000c */
> +	unsigned int gpio0c_iomux_sel_l;  /* address offset: 0x0010 */
> +	unsigned int gpio0c_iomux_sel_h;  /* address offset: 0x0014 */
> +	unsigned int gpio0d_iomux_sel_l;  /* address offset: 0x0018 */
> +	unsigned int gpio0d_iomux_sel_h;  /* address offset: 0x001c */
> +	unsigned int gpio1a_iomux_sel_l;  /* address offset: 0x0020 */
> +	unsigned int gpio1a_iomux_sel_h;  /* address offset: 0x0024 */
> +	unsigned int gpio1b_iomux_sel_l;  /* address offset: 0x0028 */
> +	unsigned int gpio1b_iomux_sel_h;  /* address offset: 0x002c */
> +	unsigned int gpio1c_iomux_sel_l;  /* address offset: 0x0030 */
> +	unsigned int gpio1c_iomux_sel_h;  /* address offset: 0x0034 */
> +	unsigned int gpio1d_iomux_sel_l;  /* address offset: 0x0038 */
> +	unsigned int gpio1d_iomux_sel_h;  /* address offset: 0x003c */
> +	unsigned int gpio2a_iomux_sel_l;  /* address offset: 0x0040 */
> +	unsigned int gpio2a_iomux_sel_h;  /* address offset: 0x0044 */
> +	unsigned int gpio2b_iomux_sel_l;  /* address offset: 0x0048 */
> +	unsigned int gpio2b_iomux_sel_h;  /* address offset: 0x004c */
> +	unsigned int gpio2c_iomux_sel_l;  /* address offset: 0x0050 */
> +	unsigned int gpio2c_iomux_sel_h;  /* address offset: 0x0054 */
> +	unsigned int gpio2d_iomux_sel_l;  /* address offset: 0x0058 */
> +	unsigned int gpio2d_iomux_sel_h;  /* address offset: 0x005c */
> +	unsigned int gpio3a_iomux_sel_l;  /* address offset: 0x0060 */
> +	unsigned int gpio3a_iomux_sel_h;  /* address offset: 0x0064 */
> +	unsigned int gpio3b_iomux_sel_l;  /* address offset: 0x0068 */
> +	unsigned int gpio3b_iomux_sel_h;  /* address offset: 0x006c */
> +	unsigned int gpio3c_iomux_sel_l;  /* address offset: 0x0070 */
> +	unsigned int gpio3c_iomux_sel_h;  /* address offset: 0x0074 */
> +	unsigned int gpio3d_iomux_sel_l;  /* address offset: 0x0078 */
> +	unsigned int gpio3d_iomux_sel_h;  /* address offset: 0x007c */
> +	unsigned int gpio4a_iomux_sel_l;  /* address offset: 0x0080 */
> +	unsigned int gpio4a_iomux_sel_h;  /* address offset: 0x0084 */
> +	unsigned int gpio4b_iomux_sel_l;  /* address offset: 0x0088 */
> +	unsigned int gpio4b_iomux_sel_h;  /* address offset: 0x008c */
> +	unsigned int reserved0090[24];    /* address offset: 0x0090 */
> +	unsigned int ioc_misc_con;        /* address offset: 0x00f0 */
> +	unsigned int sdmmc_detn_flt;      /* address offset: 0x00f4 */
> +};
> +
> +check_member(rk3576_top_ioc_reg, sdmmc_detn_flt, 0x00f4);
> +
> +/* vccio_ioc register structure define */
> +struct rk3576_vccio_ioc_reg {
> +	unsigned int reserved0000[8];     /* address offset: 0x0000 */
> +	unsigned int gpio1a_ds_l;         /* address offset: 0x0020 */
> +	unsigned int gpio1a_ds_h;         /* address offset: 0x0024 */
> +	unsigned int gpio1b_ds_l;         /* address offset: 0x0028 */
> +	unsigned int gpio1b_ds_h;         /* address offset: 0x002c */
> +	unsigned int gpio1c_ds_l;         /* address offset: 0x0030 */
> +	unsigned int gpio1c_ds_h;         /* address offset: 0x0034 */
> +	unsigned int gpio1d_ds_l;         /* address offset: 0x0038 */
> +	unsigned int gpio1d_ds_h;         /* address offset: 0x003c */
> +	unsigned int gpio2a_ds_l;         /* address offset: 0x0040 */
> +	unsigned int gpio2a_ds_h;         /* address offset: 0x0044 */
> +	unsigned int gpio2b_ds_l;         /* address offset: 0x0048 */
> +	unsigned int gpio2b_ds_h;         /* address offset: 0x004c */
> +	unsigned int gpio2c_ds_l;         /* address offset: 0x0050 */
> +	unsigned int gpio2c_ds_h;         /* address offset: 0x0054 */
> +	unsigned int gpio2d_ds_l;         /* address offset: 0x0058 */
> +	unsigned int gpio2d_ds_h;         /* address offset: 0x005c */
> +	unsigned int gpio3a_ds_l;         /* address offset: 0x0060 */
> +	unsigned int gpio3a_ds_h;         /* address offset: 0x0064 */
> +	unsigned int gpio3b_ds_l;         /* address offset: 0x0068 */
> +	unsigned int gpio3b_ds_h;         /* address offset: 0x006c */
> +	unsigned int gpio3c_ds_l;         /* address offset: 0x0070 */
> +	unsigned int gpio3c_ds_h;         /* address offset: 0x0074 */
> +	unsigned int gpio3d_ds_l;         /* address offset: 0x0078 */
> +	unsigned int gpio3d_ds_h;         /* address offset: 0x007c */
> +	unsigned int gpio4a_ds_l;         /* address offset: 0x0080 */
> +	unsigned int gpio4a_ds_h;         /* address offset: 0x0084 */
> +	unsigned int gpio4b_ds_l;         /* address offset: 0x0088 */
> +	unsigned int gpio4b_ds_h;         /* address offset: 0x008c */
> +	unsigned int reserved0090[32];    /* address offset: 0x0090 */
> +	unsigned int gpio1a_pull;         /* address offset: 0x0110 */
> +	unsigned int gpio1b_pull;         /* address offset: 0x0114 */
> +	unsigned int gpio1c_pull;         /* address offset: 0x0118 */
> +	unsigned int gpio1d_pull;         /* address offset: 0x011c */
> +	unsigned int gpio2a_pull;         /* address offset: 0x0120 */
> +	unsigned int gpio2b_pull;         /* address offset: 0x0124 */
> +	unsigned int gpio2c_pull;         /* address offset: 0x0128 */
> +	unsigned int gpio2d_pull;         /* address offset: 0x012c */
> +	unsigned int gpio3a_pull;         /* address offset: 0x0130 */
> +	unsigned int gpio3b_pull;         /* address offset: 0x0134 */
> +	unsigned int gpio3c_pull;         /* address offset: 0x0138 */
> +	unsigned int gpio3d_pull;         /* address offset: 0x013c */
> +	unsigned int gpio4a_pull;         /* address offset: 0x0140 */
> +	unsigned int gpio4b_pull;         /* address offset: 0x0144 */
> +	unsigned int reserved0148[14];    /* address offset: 0x0148 */
> +	unsigned int gpio1a_ie;           /* address offset: 0x0180 */
> +	unsigned int gpio1b_ie;           /* address offset: 0x0184 */
> +	unsigned int gpio1c_ie;           /* address offset: 0x0188 */
> +	unsigned int gpio1d_ie;           /* address offset: 0x018c */
> +	unsigned int gpio2a_ie;           /* address offset: 0x0190 */
> +	unsigned int gpio2b_ie;           /* address offset: 0x0194 */
> +	unsigned int gpio2c_ie;           /* address offset: 0x0198 */
> +	unsigned int gpio2d_ie;           /* address offset: 0x019c */
> +	unsigned int gpio3a_ie;           /* address offset: 0x01a0 */
> +	unsigned int gpio3b_ie;           /* address offset: 0x01a4 */
> +	unsigned int gpio3c_ie;           /* address offset: 0x01a8 */
> +	unsigned int gpio3d_ie;           /* address offset: 0x01ac */
> +	unsigned int gpio4a_ie;           /* address offset: 0x01b0 */
> +	unsigned int gpio4b_ie;           /* address offset: 0x01b4 */
> +	unsigned int reserved01b8[22];    /* address offset: 0x01b8 */
> +	unsigned int gpio1a_smt;          /* address offset: 0x0210 */
> +	unsigned int gpio1b_smt;          /* address offset: 0x0214 */
> +	unsigned int gpio1c_smt;          /* address offset: 0x0218 */
> +	unsigned int gpio1d_smt;          /* address offset: 0x021c */
> +	unsigned int gpio2a_smt;          /* address offset: 0x0220 */
> +	unsigned int gpio2b_smt;          /* address offset: 0x0224 */
> +	unsigned int gpio2c_smt;          /* address offset: 0x0228 */
> +	unsigned int gpio2d_smt;          /* address offset: 0x022c */
> +	unsigned int gpio3a_smt;          /* address offset: 0x0230 */
> +	unsigned int gpio3b_smt;          /* address offset: 0x0234 */
> +	unsigned int gpio3c_smt;          /* address offset: 0x0238 */
> +	unsigned int gpio3d_smt;          /* address offset: 0x023c */
> +	unsigned int gpio4a_smt;          /* address offset: 0x0240 */
> +	unsigned int gpio4b_smt;          /* address offset: 0x0244 */
> +	unsigned int reserved0248[14];    /* address offset: 0x0248 */
> +	unsigned int gpio1a_pdis;         /* address offset: 0x0280 */
> +	unsigned int gpio1b_pdis;         /* address offset: 0x0284 */
> +	unsigned int gpio1c_pdis;         /* address offset: 0x0288 */
> +	unsigned int gpio1d_pdis;         /* address offset: 0x028c */
> +	unsigned int gpio2a_pdis;         /* address offset: 0x0290 */
> +	unsigned int gpio2b_pdis;         /* address offset: 0x0294 */
> +	unsigned int gpio2c_pdis;         /* address offset: 0x0298 */
> +	unsigned int gpio2d_pdis;         /* address offset: 0x029c */
> +	unsigned int gpio3a_pdis;         /* address offset: 0x02a0 */
> +	unsigned int gpio3b_pdis;         /* address offset: 0x02a4 */
> +	unsigned int gpio3c_pdis;         /* address offset: 0x02a8 */
> +	unsigned int gpio3d_pdis;         /* address offset: 0x02ac */
> +	unsigned int gpio4a_pdis;         /* address offset: 0x02b0 */
> +	unsigned int gpio4b_pdis;         /* address offset: 0x02b4 */
> +	unsigned int reserved02b8[82];    /* address offset: 0x02b8 */
> +	unsigned int misc_con[9];         /* address offset: 0x0400 */
> +};
> +
> +check_member(rk3576_vccio_ioc_reg, misc_con, 0x0400);
> +
> +/* vccio6_ioc register structure define */
> +struct rk3576_vccio6_ioc_reg {
> +	unsigned int reserved0000[36];    /* address offset: 0x0000 */
> +	unsigned int gpio4c_ds_l;         /* address offset: 0x0090 */
> +	unsigned int gpio4c_ds_h;         /* address offset: 0x0094 */
> +	unsigned int reserved0098[44];    /* address offset: 0x0098 */
> +	unsigned int gpio4c_pull;         /* address offset: 0x0148 */
> +	unsigned int reserved014c[27];    /* address offset: 0x014c */
> +	unsigned int gpio4c_ie;           /* address offset: 0x01b8 */
> +	unsigned int reserved01bc[35];    /* address offset: 0x01bc */
> +	unsigned int gpio4c_smt;          /* address offset: 0x0248 */
> +	unsigned int reserved024c[27];    /* address offset: 0x024c */
> +	unsigned int gpio4c_pdis;         /* address offset: 0x02b8 */
> +	unsigned int reserved02bc[53];    /* address offset: 0x02bc */
> +	unsigned int gpio4c_iomux_sel_l;  /* address offset: 0x0390 */
> +	unsigned int gpio4c_iomux_sel_h;  /* address offset: 0x0394 */
> +	unsigned int reserved0398[26];    /* address offset: 0x0398 */
> +	unsigned int misc_con[2];         /* address offset: 0x0400 */
> +	unsigned int reserved0408[14];    /* address offset: 0x0408 */
> +	unsigned int hdmitx_hpd_status;   /* address offset: 0x0440 */
> +};
> +
> +check_member(rk3576_vccio6_ioc_reg, hdmitx_hpd_status, 0x0440);
> +
> +/* vccio7_ioc register structure define */
> +struct rk3576_vccio7_ioc_reg {
> +	unsigned int reserved0000[38];    /* address offset: 0x0000 */
> +	unsigned int gpio4d_ds_l;         /* address offset: 0x0098 */
> +	unsigned int reserved009c[44];    /* address offset: 0x009c */
> +	unsigned int gpio4d_pull;         /* address offset: 0x014c */
> +	unsigned int reserved0150[27];    /* address offset: 0x0150 */
> +	unsigned int gpio4d_ie;           /* address offset: 0x01bc */
> +	unsigned int reserved01c0[35];    /* address offset: 0x01c0 */
> +	unsigned int gpio4d_smt;          /* address offset: 0x024c */
> +	unsigned int reserved0250[27];    /* address offset: 0x0250 */
> +	unsigned int gpio4d_pdis;         /* address offset: 0x02bc */
> +	unsigned int reserved02c0[54];    /* address offset: 0x02c0 */
> +	unsigned int gpio4d_iomux_sel_l;  /* address offset: 0x0398 */
> +	unsigned int reserved039c[25];    /* address offset: 0x039c */
> +	unsigned int xin_ufs_con;         /* address offset: 0x0400 */
> +};
> +
> +check_member(rk3576_vccio7_ioc_reg, xin_ufs_con, 0x0400);
> +
> +#endif /* _ASM_ARCH_IOC_RK3576_H */
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 269c219a6f8..568ce7389ed 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -341,6 +341,49 @@ config ROCKCHIP_RK3568
>   	  and video codec support. Peripherals include Gigabit Ethernet,
>   	  USB2 host and OTG, SDIO, I2S, UARTs, SPI, I2C and PWMs.
>   
> +config ROCKCHIP_RK3576
> +	bool "Support Rockchip RK3576"
> +	select ARM64
> +	select SUPPORT_SPL
> +	select SPL
> +	select CLK
> +	select PINCTRL
> +	select RAM
> +	select REGMAP
> +	select SYSCON
> +	select BOARD_LATE_INIT
> +	select DM_REGULATOR_FIXED
> +	select DM_RESET
> +	imply BOOTSTD_FULL
> +	imply CLK_SCMI
> +	imply DM_RNG
> +	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply OF_LIBFDT_OVERLAY
> +	imply OF_UPSTREAM
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
> +	imply RNG_ROCKCHIP
> +	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_OTP
> +	imply SCMI_FIRMWARE
> +	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> +	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> +	select HAS_CUSTOM_SYS_INIT_SP_ADDR

Can you move this one with the other "select"?

> +	imply SPL_LIBCOMMON_SUPPORT if SPL
> +	imply SPL_LIBGENERIC_SUPPORT if SPL
> +	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply SPL_SYS_MALLOC_F if SPL
> +	imply SPL_SYS_MALLOC_SIMPLE if SPL
> +	imply TPL_LIBCOMMON_SUPPORT if TPL
> +	imply TPL_LIBGENERIC_SUPPORT if TPL
> +	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
> +	imply TPL_SYS_MALLOC_F if TPL
> +	imply TPL_SYS_MALLOC_SIMPLE if TPL
> +
> +	help
> +	  The Rockchip RK3576 is a ARM-based SoC with a quad-core Cortex-A53
> +	  and a quad-core Cortex-A72.
> +
>   config ROCKCHIP_RK3588
>   	bool "Support Rockchip RK3588"
>   	select ARM64
> @@ -490,7 +533,7 @@ config TPL_ROCKCHIP_COMMON_BOARD
>   
>   config ROCKCHIP_EXTERNAL_TPL
>   	bool "Use external TPL binary"
> -	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
> +	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3576 || ROCKCHIP_RK3588
>   	help
>   	  Some Rockchip SoCs require an external TPL to initialize DRAM.
>   	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
> @@ -627,6 +670,7 @@ source "arch/arm/mach-rockchip/rk3328/Kconfig"
>   source "arch/arm/mach-rockchip/rk3368/Kconfig"
>   source "arch/arm/mach-rockchip/rk3399/Kconfig"
>   source "arch/arm/mach-rockchip/rk3568/Kconfig"
> +source "arch/arm/mach-rockchip/rk3576/Kconfig"
>   source "arch/arm/mach-rockchip/rk3588/Kconfig"
>   source "arch/arm/mach-rockchip/rv1108/Kconfig"
>   source "arch/arm/mach-rockchip/rv1126/Kconfig"
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 5e7edc99cdc..52464b01f4e 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
>   obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
>   obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
>   obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> +obj-$(CONFIG_ROCKCHIP_RK3576) += rk3576/
>   obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
>   obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
>   obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
> new file mode 100644
> index 00000000000..2e46b2b90d2
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/Kconfig
> @@ -0,0 +1,48 @@
> +if ROCKCHIP_RK3576
> +
> +config ROCKCHIP_BOOT_MODE_REG
> +	default 0x26024040
> +
> +config ROCKCHIP_STIMER_BASE
> +	default 0x27400000
> +
> +config SYS_SOC
> +	default "rk3576"
> +
> +config CUSTOM_SYS_INIT_SP_ADDR
> +	default 0x43f00000
> +
> +config SYS_MALLOC_F_LEN
> +	default 0x10000
> +
> +config SPL_SYS_MALLOC_F_LEN
> +	default 0x8000
> +
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x4000
> +
> +config TEXT_BASE
> +	default 0x40200000
> +
> +config SPL_TEXT_BASE
> +	default 0x40000000
> +
> +config SPL_HAS_BSS_LINKER_SECTION
> +	default y if ARM64
> +
> +config SPL_BSS_START_ADDR
> +	default 0x43f80000
> +
> +config SPL_BSS_MAX_SIZE
> +	default 0x8000
> +
> +config SPL_STACK_R
> +	default y
> +
> +config SPL_STACK_R_ADDR
> +	default 0x43e00000
> +
> +config SPL_STACK_R_MALLOC_SIMPLE_LEN
> +	default 0x200000
> +
> +endif
> diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
> new file mode 100644
> index 00000000000..cbc58257deb
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/Makefile
> @@ -0,0 +1,9 @@
> +#
> +# (C) Copyright 2023 Rockchip Electronics Co., Ltd
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y += rk3576.o
> +obj-y += clk_rk3576.o
> +obj-y += syscon_rk3576.o
> diff --git a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
> new file mode 100644
> index 00000000000..cc580b33e9c
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dm.h>
> +#include <syscon.h>
> +#include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/cru_rk3576.h>
> +#include <linux/err.h>
> +
> +int rockchip_get_clk(struct udevice **devp)
> +{
> +	return uclass_get_device_by_driver(UCLASS_CLK,
> +			DM_DRIVER_GET(rockchip_rk3576_cru), devp);
> +}
> +
> +void *rockchip_get_cru(void)
> +{
> +	struct rk3576_clk_priv *priv;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = rockchip_get_clk(&dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	priv = dev_get_priv(dev);
> +
> +	return priv->cru;
> +}
> +
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> new file mode 100644
> index 00000000000..a0fe1803e37
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <spl.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/grf_rk3576.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <asm/arch-rockchip/ioc_rk3576.h>
> +
> +#define SYS_GRF_BASE		0x2600A000
> +#define SYS_GRF_SOC_CON2	0x0008
> +#define SYS_GRF_SOC_CON7	0x001c
> +#define SYS_GRF_SOC_CON11	0x002c
> +#define SYS_GRF_SOC_CON12	0x0030
> +
> +#define GPIO0_IOC_BASE		0x26040000
> +#define GPIO0B_PULL_L		0x0024
> +#define GPIO0B_IE_L		0x002C
> +
> +#define SYS_SGRF_BASE		0x26004000
> +#define SYS_SGRF_SOC_CON14	0x0058
> +#define SYS_SGRF_SOC_CON15	0x005C
> +#define SYS_SGRF_SOC_CON20	0x0070
> +
> +#define FW_SYS_SGRF_BASE	0x26005000
> +#define SGRF_DOMAIN_CON1	0x4
> +#define SGRF_DOMAIN_CON2	0x8
> +#define SGRF_DOMAIN_CON3	0xc
> +#define SGRF_DOMAIN_CON4	0x10
> +#define SGRF_DOMAIN_CON5	0x14
> +
> +const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
> +	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
> +	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
> +};
> +
> +static struct mm_region rk3576_mem_map[] = {
> +	{
> +		/*
> +		 * sdhci_send_command sets the start_addr to 0, while
> +		 * sdhci_transfer_data calls dma_unmap_single on that
> +		 * address when the transfer is done, which in turn calls
> +		 * invalidate_dcache_range on that memory block.
> +		 * Map the Bootrom that sits in that memory area, to just
> +		 * let the invalidate_dcache_range call pass.
> +		 */
> +		.virt = 0x0UL,
> +		.phys = 0x0UL,
> +		.size = 0x00008000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* I/O area */
> +		.virt = 0x20000000UL,
> +		.phys = 0x20000000UL,
> +		.size = 0xb080000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* PMU_SRAM, CBUF, SYSTEM_SRAM */
> +		.virt = 0x3fe70000UL,
> +		.phys = 0x3fe70000UL,
> +		.size = 0x190000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* MSCH_DDR_PORT */
> +		.virt = 0x40000000UL,
> +		.phys = 0x40000000UL,
> +		.size = 0x400000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* PCIe 0+1 */
> +		.virt = 0x900000000UL,
> +		.phys = 0x900000000UL,
> +		.size = 0x100800000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		/* List terminator */
> +		0,
> +	}
> +};
> +
> +struct mm_region *mem_map = rk3576_mem_map;
> +
> +void board_debug_uart_init(void)
> +{
> +}

We need to surround this with #ifdef DEBUG_UART_BOARD_INIT otherwise 
disabling the symbol (it's only implied at vendor level) will have 
duplicate implementation for the function (one is provided if the symbol 
isn't defined).

> +
> +#ifdef CONFIG_XPL_BUILD
> +void rockchip_stimer_init(void)
> +{
> +	u32 reg;
> +
> +	/* If Timer already enabled, don't re-init it */
> +	reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + 0x4);
> +	if (reg & 0x1)
> +		return;
> +
> +	asm volatile("msr CNTFRQ_EL0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x14);
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 0x18);
> +	writel(0x00010001, CONFIG_ROCKCHIP_STIMER_BASE + 0x04);
> +}
> +#endif
> +
> +#ifndef CONFIG_TPL_BUILD
> +int arch_cpu_init(void)
> +{
> +#ifdef CONFIG_XPL_BUILD
> +	u32 val;
> +
> +	/* Set the emmc to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
> +	writel(val | 0x7, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
> +
> +	/* Set the sdmmc0 to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
> +	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON5);
> +
> +	/* Set the UFS to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
> +	writel(val | 0x70000, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON3);
> +
> +	/* Set the fspi0 and fspi1 to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
> +	writel(val | 0x7700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON4);
> +
> +	/* Set the decom to access ddr memory */
> +	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
> +	writel(val | 0x700, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON1);
> +
> +	/*
> +	 * Set the GPIO0B0~B3 pull up and input enable.
> +	 * Keep consistent with other IO.
> +	 */
> +	writel(0x00ff00ff, GPIO0_IOC_BASE + GPIO0B_PULL_L);
> +	writel(0x000f000f, GPIO0_IOC_BASE + GPIO0B_IE_L);
> +

Mmmmm... do we really want that? Shouldn't we rather let the user define 
what they want in the DT and handle that whenever a device requests 
those pins in the gpio function?

> +	/*
> +	 * Set SYS_GRF_SOC_CON2[12](input of pwm2_ch0) as 0,
> +	 * keep consistent with other pwm.
> +	 */
> +	writel(0x10000000, SYS_GRF_BASE + SYS_GRF_SOC_CON2);
> +

This one is odd too, but this wouldn't be using pinmuxing I guess.

> +	/* Enable noc slave response timeout */
> +	writel(0x80008000, SYS_GRF_BASE + SYS_GRF_SOC_CON11);

This is usb0_slv_timeout_ena in the TRM, shouldn't that be handled at 
the USB controller/PHY level?

> +	writel(0xffffffe0, SYS_GRF_BASE + SYS_GRF_SOC_CON12);
> +

Same here? Timeout enabling for some but not all IPs there.

> +	/*
> +	 * Enable cci channels for below module AXI R/W
> +	 * Module: GMAC0/1, MMU0/1(PCIe, SATA, USB3)
> +	 */
> +	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
> +#endif
> +
> +	return 0;
> +}
> +#endif
> +
> diff --git a/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> new file mode 100644
> index 00000000000..7c15df97d28
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2023 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <dm.h>
> +#include <syscon.h>
> +#include <asm/arch-rockchip/clock.h>
> +
> +static const struct udevice_id rk3576_syscon_ids[] = {
> +	{ .compatible = "rockchip,rk3576-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
> +	{ .compatible = "rockchip,rk3576-ioc-grf", .data = ROCKCHIP_SYSCON_IOC },
> +	{ .compatible = "rockchip,rk3576-php-grf", .data = ROCKCHIP_SYSCON_PHP_GRF },
> +	{ .compatible = "rockchip,rk3576-pmu1-grf",  .data = ROCKCHIP_SYSCON_PMUGRF },
> +	{ .compatible = "rockchip,rk3576-sdgmac-grf", .data = ROCKCHIP_SYSCON_SDGMAC },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(syscon_rk3576) = {
> +	.name = "rk3576_syscon",
> +	.id = UCLASS_SYSCON,
> +	.of_match = rk3576_syscon_ids,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind = dm_scan_fdt_dev,
> +#endif
> +};
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 4e2af55d6e1..8d6a1261bfa 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -110,6 +110,7 @@ static int rockchip_dram_init_banksize(void)
>   	u8 i, j;
>   
>   	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
> +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3576) &&
>   	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
>   		return -ENOTSUPP;
>   

Maybe we should add a new symbol for that which we enable on SoC Kconfig 
level instead of having to update this file every time we add a new SoC 
without open DRAM init :) Not necessary for this patch series though.

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d2347..6b544e957b2 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -265,6 +265,15 @@ To build rk3568 boards:
>           make evb-rk3568_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
>   
> +To build rk3576 boards:
> +
> +.. code-block:: bash
> +
> +        export BL31=../rkbin/bin/rk35/rk3576_bl31_v1.04.elf
> +        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.03.bin
> +        make roc-pc-rk3576_defconfig
> +        make CROSS_COMPILE=aarch64-linux-gnu-
> +
>   To build rk3588 boards:
>   
>   .. code-block:: bash
> diff --git a/include/configs/rk3576_common.h b/include/configs/rk3576_common.h
> new file mode 100644
> index 00000000000..d52a0c18da2
> --- /dev/null
> +++ b/include/configs/rk3576_common.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __CONFIG_RK3576_COMMON_H
> +#define __CONFIG_RK3576_COMMON_H
> +
> +#include "rockchip-common.h"
> +
> +#define CFG_IRAM_BASE			0x3ff80000
> +
> +#define CFG_SYS_SDRAM_BASE		0x40000000
> +
> +/*
> + * 16G according to the TRM memory map, but things like efi_memory
> + * handling (efi_loader) choke on a main block going out side the
> + * 4G area.
> + */

I believe you fixed that? Also the variable is set to 16GiB now, so I 
guess this really isn't an issue anymore?

Cheers,
Quentin
