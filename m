Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72736C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 12:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E6A88047;
	Fri,  7 Jun 2024 14:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KFQqIwx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AAA87FA1; Fri,  7 Jun 2024 12:16:16 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A2187ABC
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYWyzSRW1bsZyZKEJTQlWvJbmAR0iOCEhqKzh01MZ4QObDDgXUYPA4+Eah+r46bkHWO/tLPWmDHLuSqI2tkIQHbb/QSTFUDzGyEHROOmfq5eL88UxJtw6xwN1z3RLMzpX0robJ94Nj8+yfWrIr1dwfow5hrCr4x3ELB+3ET+orscakUdJZZfJz1n5I96lJ8FOMfXpavr2hynH6BXOum6Ec5aDr1R4Jz3DNrqKJJB6tExzTXY4HvGbBuwGf/8CUoJY3swaTNAyIJ7KUoJZvLCKVFFtn8zLuuwfmhKHhf6gLhYKmeGcVAMGRkkE+/3yQFsIMMJ6z3GrATMCvJ/tHNoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vMaclabqjmR1/twUHQkc0benez2g4pd82stVpSh1Hw=;
 b=R+dEvuQd7VGxvMdybuT0YVmEwJqnXm158iiKcyVLqyxXIK5lMgrPq+eSDZ9ZfJVwbAY2gIcuqG1yMRqw1YKVw/a85F87baepa7r+pX0fPQiq9QgrjbUgbgOljRRpqMGCLM/YApqr0vrJz1/VZTkc0aoMkQ9h0sAVBALkNyy0lGdGDgoIBZqIIN4bITM0ZkWnZjLMTiZqTcDyLrWOuxqFmFnjEpC8VdH62x8JEA8dh3YvqulfW99uv/7x5GX0Pgb8TUqUfR4saajiqFEra6AgPtHhQanC5xvhWQAu6cHRjBTxrXutXPJEPSl491610ZnUUtLbHm7jrTCuF8+ua7nkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vMaclabqjmR1/twUHQkc0benez2g4pd82stVpSh1Hw=;
 b=KFQqIwx5dfYL09+4+9uX2+v0xnO4DiV8Nhbnh0HUGiqfFPnI8vXXf+kuD1HNMdQ4oIyPh6gureK3uE21RIxvzWzsjkH2h3YQVu3bksslpGzaTNnzF9O55DMlkG5ZrOW9roH/V1CeCaEf3jXiAvprfB7LXhFDHg0KoHH82djrYuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI1PR04MB6832.eurprd04.prod.outlook.com (2603:10a6:803:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Fri, 7 Jun
 2024 10:16:10 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 10:16:10 +0000
Message-ID: <176e0277-0cdb-4dde-b959-b3141c5c5b91@cherry.de>
Date: Fri, 7 Jun 2024 12:16:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, Elon Zhang
 <zhangzj@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Massimo Pegorer
 <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Niklas Cassel <cassel@kernel.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI1PR04MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b19b5cc-3f3d-45ef-1f06-08dc86dada31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0lHWHB0QWJGMDhmMEJFMENYbHg2OExTMS92bVdvMHBtWHg1L3E2Q2c1Rm9h?=
 =?utf-8?B?SUduNlVYTG5vdUxqMmV0ajhPbklwdEdqa0gyNFBDdVVSTUpBeGFGK2lKaFZD?=
 =?utf-8?B?UzRjNFE3cm1yUFlKZVNSL05seUIvdkhaVXp1cGdnSldEYVYwdGhiQURMNTJC?=
 =?utf-8?B?eVdYdktLNDcyWm9vRG5iU1dwb3VhSXd0QVFNTXJoK0xYRm5IU2dZa1JUd2ZS?=
 =?utf-8?B?K0xFREFNZVN4WVlBdEtqV2FaS1VBM29oM0NWSmlOcWtBTlBNOWxSVGRRQWhG?=
 =?utf-8?B?K1JPMElTUkI0YW5DTVhxeW83TWFkbWhtQ3FWZS9vUHNyNDhVbzJsOFpJenNW?=
 =?utf-8?B?NGc3cVkxdzRWUFZydlR1Tk9LcVkrcGlPL1JhSjFoVGxvUkhFNXNTU29ud2Jp?=
 =?utf-8?B?bUIrUzdjVnBQcTVFSnpvdU9idXlmOElORUxxd3NxMUl6WFJDTFN1UENaaExH?=
 =?utf-8?B?MWZLakNjcWFTNGtZZ0dERkJFelRVSUJFdWZYWDNaSDRrZ2dsRTJzU3BTK1VS?=
 =?utf-8?B?VkwzbnRiOVRQTGFkZ0YxM21tdVRiNWdtWXRaZ1dDUzhKT2UrQnpYQVlaeFZ6?=
 =?utf-8?B?K0x2S05WUFhVK3VXSEhFOWxwSzVYNmo2OFpaOEJ5S0hkVWdQbEhocVp2QnZQ?=
 =?utf-8?B?d0t0YzJMU2IwcEswOStPWlFzWjRyUEdtS0xxRDFZdkFBS3JPZ2xEV3hwVTIz?=
 =?utf-8?B?dllWQVdUMDg5aFhNZVYwcVdEQjZkUk1TSGhHTUxiUnlrOTMzRllTTXdCVFQ3?=
 =?utf-8?B?VEYvRHpMR0JycGgwdFR6NUFZU0xjbHgwQWJ2cjR1TFAyUGZleHk4OS94aEow?=
 =?utf-8?B?eWxJRE54ZVlUQVFKNnZEcGdRQ1h1UDU4RGx6Y29FUGk4RDhZb2xNTHZGKzBY?=
 =?utf-8?B?M0tUV2pHNXZKaEM2OUdjd0d0ejZJRG9ZUzliVlkvZDhiS090NnFiU3VzWHNq?=
 =?utf-8?B?YWk4aDR1c1pJVlBOaU45L21rVlQrcEFaeGIxcHk4cnhjSm5pSk0zbys4aDhP?=
 =?utf-8?B?R2Z6eDRLYjZObWZHbnFEU1dXaWxWYjhBQ2t6TjdNSU9za3Fja2FpS1V2WmJm?=
 =?utf-8?B?VHgrbm45U3RwdjkwcXB5L3BudWdRTzRMcFFIYzR1SmdQbVFqcmQrOVRIT0c4?=
 =?utf-8?B?ZzVDR3BGQWtXQkl4RlZXTEx1L1kxVG1pci9OVzZnWnpMMjBpaEdxK0lqYkhY?=
 =?utf-8?B?enYwSnVwUkNpTEU5b3pRYzNNc0QvWXFteitJT0w4aGdaclNKVlVXV2xXMXJ5?=
 =?utf-8?B?M3VNVmVHek5xdFJoOURHcjlDQUVYYXRwK2gwdEdVZXNlTGlvNzR3amlTS1VF?=
 =?utf-8?B?aFRSdmt2S0RHUDdFdVkwcU0vOEJ5UlphbThkZ0EvUlpjeTh6VU5IZS9zTHh6?=
 =?utf-8?B?a1lKQitySjIwYTZqT3RTVXJESFlzSUF0T1hsMHVEZ3lMczE5Z05ickhoMjlh?=
 =?utf-8?B?aDZXbkM1UG9mTlpjdFhZdDdGcnp3b2pFT0FjS3E0UDhlOWNvSEZjaUFXUnlP?=
 =?utf-8?B?aS9rb01tMlJjM25BRldqbDVrSHpRV0s2ajAwcGJsRTJjV2tLVUhMUjB1clBE?=
 =?utf-8?B?NGZnT1dNZXRRV0w3ZDcvMHlQYVZCQmQ2VnZkQmRLMWIrS0JyWnNMZC84YWQw?=
 =?utf-8?B?R2ZjcUZrWStKa29BaG0zNGRPYlZJQlJhNVd0UXIrRmpZZFNyYzhGWWJGMUJi?=
 =?utf-8?B?UWVHZ05MOUJMVk94WkxWRTFLdEdqUVBsY2QxM1hRcExaUExGak9GKzVueEtN?=
 =?utf-8?Q?A8WKLMWdFD35qKcNfU0NSQrKapwTyHd+6GF2rtg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pPbWptNVFhcDlzUW1uQjltbDBVaDBKTmZONDdPRXFlS01qaXBQcmo0eGIy?=
 =?utf-8?B?UU5IOUZwVWMwdHZIQ1VlWkJyWDFSemtjME5oL1ZWRWRtWGdhNlRqRytkMW9U?=
 =?utf-8?B?TnQ1OHkvR0M0WVhKNC9YMmZ2QzM4WWV4UkRBVkViQ2VsejFhMG04NTRpand5?=
 =?utf-8?B?Z0ZteVJSc1ozamRGSmczTkFMZi9CSWJIbDNSZW9hc3B0aFhueXFIMm90UUVa?=
 =?utf-8?B?RGdMU2lvemlFcFd2VXBhbSt1aWZiRnE5VmtsRzQ4Q2dENFRGRnlvTXh1WmhB?=
 =?utf-8?B?ckpxRVphRXI3YTlBVTY2ZStBbHg4TFk4S1AySU1WbUdrcDlKSVAzUlc2U2w2?=
 =?utf-8?B?RXhaQ2RjTkZDbW5LU0E1UmwraVZUaE9JQXRnWHNkbUtzaUtuYjFNUUNvZjlX?=
 =?utf-8?B?TDdaWndlVE80M3dicXFsN0FWTk5DY0VZOS9lczdsTkttdnRLWEx3ZHJkTlZS?=
 =?utf-8?B?WVk3ZHcxQzVhazFQOXo5U1RFR1pSeGQ3eGI1OXlIVG5tV3pxc29JN0d6WGpx?=
 =?utf-8?B?WFM1bFFxdXNrUzYrVXdtaE9Uekd4Z04zajhLNkdLT3ppTVdHM1g3ODdOaXpL?=
 =?utf-8?B?dDZodmpXbDdpWStiL1FVaVRSZW9hQmdTREVqN3Z2dW1ON29ncGt1SnRwajlN?=
 =?utf-8?B?TVlJUFdoQlFqY3lTNlgxTTlLVGdyQXc4RjJ4MDBGN212VHFoTS9HSnROMEx3?=
 =?utf-8?B?SmYySm9vZG1NYzJBK1V5WUdpZDExVHNGWHl1RW9SeHZqaXJhY1F0dm5qbXdL?=
 =?utf-8?B?UElEUUJWWWZ0TnhDZGhaY0oybUgwYlJrVjUwUzE4VzRpUjY4NWRkVkNYd3NV?=
 =?utf-8?B?RWJKTVdNOXp1TnpXWU1VZGxvei9RMzJoM05ITDNTZHhucTR1czMxYjJyeHZZ?=
 =?utf-8?B?eXVBSmtmdWhLcHA1dFZnMktRcUVrQzBXT24yV0lNSzNwSitIZkZ5NXgwNWFN?=
 =?utf-8?B?MXJ5aWtGVVFMQ0xZSkNicjJ5SmVHN1U3S0ZxK1g4RkZkZ0ZCQWs5ZS9LOTFu?=
 =?utf-8?B?WkdOUVVGN21NaDVPb2VyKzRBTmMwZE5GeEU3WUtYREFzekxjTThVOGZDVllj?=
 =?utf-8?B?NVQ0K0k4UjJMRzNkMHZWVWNSd3d4bjlac1pXN2l3SlAwRjVKLzF4WGxQdlJV?=
 =?utf-8?B?SEV2ellQZG91MUhaQnFEYkhDNEdSQ0tjdGQ5eU85OFhIUFVQVllNSFIrNFpF?=
 =?utf-8?B?dUk3WlhHZTZvQ0U0by9lYndRc2c0bmZPc1g3QzFWT3o1VEFSd0FESGdTWTZo?=
 =?utf-8?B?RkNMenFxOW1Dd2w3RmJhdWRPTEpWRGJDTUcwdmVkVk1udjJKeURacG9HR2lL?=
 =?utf-8?B?QkdCRWRQWnBDUDdRbGpKM3VLdUhBa2JScmd0empJc3NUMDVtSC9XZFZsTGxa?=
 =?utf-8?B?WFV1UlRwaHE3V0VkQ3JvUEMraTBFeDBmaTgzTjdiSGtIU2VSaDhGekFYWHEx?=
 =?utf-8?B?cll6ZlF3UnhGR1oyeUhMRFhFb3crU2dXZmc5U1k1SDlLZjlDUG9ENGJ5c1U0?=
 =?utf-8?B?YTRidlVsR3Q4UHBXZzVSOUN4NFZuZXYxUklpY3JQekJNUWx3TldFOHFQWTRK?=
 =?utf-8?B?SGg1ZFBMc1R4bm1rUXppL1RJOHZ1c1pWbDFPMW91MVRiZDA3TGpEa3JIeU1J?=
 =?utf-8?B?TnJuTmxCZEVDRXdyUmsrNXY2eEdJMThreXorT0JBdzloRndhU2VZVHN5WkJo?=
 =?utf-8?B?UWdmTzBvNDNTY2lSblRZTFBqTXd5RU41UEJ1RVpwYnlOYmJtSU9wenBnTk9T?=
 =?utf-8?B?Q0R6UHFNMFFGbWJQcW5QOE9Dd3VQWTFReUw3YXhoVmR2a0NSZUdCMGpMUXNZ?=
 =?utf-8?B?VFNaL29oRDE5VW5XZ1ZydllSZDJzT2pFcUJXQytPK29oZzQwWlZjVHhnWVNk?=
 =?utf-8?B?ZnVBWmtWWnRHYzBlcFB4N0s1dU5lSFFjeC9FNmgrSXdsZGh3NCtZL3V6eXVK?=
 =?utf-8?B?N1hoV2NMWDk0MTNyekpOWmhuZW5RZTVEMDlXL3lhaFpUUkxzV2tiMlEreWFH?=
 =?utf-8?B?bUFMM1lVT3NhL2t5V1N2TXBGcENZaXVjZmlZOG91QkV6Tm04UGRLcllvRDcx?=
 =?utf-8?B?Z2cyOFZzajFYZmY3Wk9PWXpLR3R2YkJCTzFzUE1EczZNS1lNMi9SSFpJcTE1?=
 =?utf-8?B?N0pvcnRhY0dVb1JSUG1ER1BXMHNqNDZMa1R1T1orYnFQK3dpV3BvcGlmTDZL?=
 =?utf-8?Q?PcjqoGpgNpvLP8HiazcLlh0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b19b5cc-3f3d-45ef-1f06-08dc86dada31
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:16:10.3048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+RT0AhM7arvqSol0TuKH2I3j5C+s5ROmFmsnoi6jcqyzPqFWD2woLV8PJhpiFr4NSbkwY+pKfAOMCcrbn/WjpYhLIWriQqX6CbiuO9aEOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6832
X-Mailman-Approved-At: Fri, 07 Jun 2024 14:54:18 +0200
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

Hi Jianfeng,

For the whole series:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

On 5/28/24 7:03 PM, Jianfeng Liu wrote:
> This series also introduces dts commits of rk3588s.dtsi and rk3588.dtsi
> from v6.10-rc1-dts.
> Then dts of ArmSoM Sige7 is picked from upstream.
> I also remove obsolete usb3 nodes of rk3588-u-boot.dtsi and
> rk3588-u-boot.dtsi.
> 
> Changes in v4:
> - Pick all commits of rk3588s.dtsi and rk3588.dtsi from v6.10-rc1-dts
> - Remove obsolete USB3 DRD nodes in u-boot.dtsi of rk3588s/rk3588
> - Remove sdhci and usb nodes from rk3588-armsom-sige7-u-boot.dtsi
> 
> Changes in v3:
> - Use update-dts-subtree.sh to pick upstream dts
> 
> Changes in v2:
> - Fix alphabetical order of MAINTAINERS
> - Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
> - Remove spi flash related config
> - Move kernel dts to dts/upstream/src/arm64/rockchip/
> 
> Boris Brezillon (1):
>    arm64: dts: rockchip: Add rk3588 GPU node
> 
> Diederik de Haas (1):
>    arm64: dts: rockchip: Fix ordering of nodes on rk3588s
> 
> Jianfeng Liu (3):
>    arm64: dts: rockchip: Add ArmSom Sige7 board
>    rockchip: rk3588: Remove USB3 DRD nodes in u-boot.dtsi
>    board: rockchip: add ArmSoM Sige7 Rk3588 board
> 
> Niklas Cassel (1):
>    arm64: dts: rockchip: add rk3588 pcie and php IOMMUs
> 
> Sebastian Reichel (4):
>    arm64: dts: rockchip: fix usb2phy nodename for rk3588
>    arm64: dts: rockchip: reorder usb2phy properties for rk3588
>    arm64: dts: rockchip: add USBDP phys on rk3588
>    arm64: dts: rockchip: add USB3 DRD controllers on rk3588
> 
>   MAINTAINERS                                   |   1 +
>   arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi  |   6 +
>   arch/arm/dts/rk3588-u-boot.dtsi               |  74 --
>   arch/arm/dts/rk3588s-u-boot.dtsi              |  85 ---
>   arch/arm/mach-rockchip/rk3588/Kconfig         |  26 +
>   board/armsom/sige7-rk3588/Kconfig             |  12 +
>   board/armsom/sige7-rk3588/MAINTAINERS         |   7 +
>   configs/sige7-rk3588_defconfig                |  93 +++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   .../arm64/rockchip/rk3588-armsom-sige7.dts    | 721 ++++++++++++++++++
>   dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  72 ++
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 377 ++++++---
>   include/configs/sige7-rk3588.h                |  15 +
>   13 files changed, 1225 insertions(+), 265 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>   create mode 100644 board/armsom/sige7-rk3588/Kconfig
>   create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
>   create mode 100644 configs/sige7-rk3588_defconfig
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
>   create mode 100644 include/configs/sige7-rk3588.h
> 
