Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DEBC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 12:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5369B800B3;
	Tue, 11 Feb 2025 13:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="l0bId/9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A05CB809D0; Tue, 11 Feb 2025 13:20:12 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A11D80104
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhF4cF/GKyh+ox5YjP8raWvL+XCc6cnnafS88y55GySMmTpypJ4x2JMprkkijbBj4NjrzKx4wwBl+Lz10Cz45gm5sTvbpvidBesnpVASKrPpD2P7mpT5PSRj1johjJSuwdIph7M03vlFAvpPDBoOLT+y8yW/E2zUNq7LL049Z6eLfbX7RyJV8FYjVjSUe6D+26nszOHQTsQ7DbqOp8R2aFCOAQK1jTyD6fxAJQRlyVOL/Xq1XU8FNuza6ANK8FRXKd6j1otWPHz/RjDRYoa14QVDuriwMdfInhO2mm+X9nJyfs/taYcPUwGuShpUBxRI9C+mMi/coQOq+dZD5Wkm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOlWRUHT2ke80hsmC3jwba1jyB3XDi4FsSLkGe0Dlr4=;
 b=OQARGehVf6hGpo2Ij6G2LPLjT6ibYXSnoamp0XYGi8jCUJAGvic7UqzqhTXk21Gb77S0bRI/r41Dr5pU52I/e6evg0b3A96BvSHjtfFR3NBlPjNUK4OV8TP/cNXIofo55imMXkP3zfnkwcz/U9fJEFITYvGjDqlvlyyTODhAAbAQOTYYQWIHcwSPUBirZYDnG0uirHlsqz7/YHD+W7zYlC7ZoFZuSoXsLenZCG7ZYHLxkypGjT/HTevDL9wIsxBgERd+APymbkOpWhcO2M8Z4qsXAlhG/ix6VCfiGh+lV0fwY124hTucCNaSxPrSSkRrujjW+mRzlBNqG4m/VfUHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOlWRUHT2ke80hsmC3jwba1jyB3XDi4FsSLkGe0Dlr4=;
 b=l0bId/9z5sHWK+U7cvGNqmzjzG5ovGhA3bLDKyAIL9bo9MrXRYJNxJlu4arLFMwI41lu3T+mctS1uE5mw0GYP8OvFZmK1nWT/q3fE4XFPVsv4tB5CXjznIg+fi6O0I2KR3IH2Tga14wzlStMqkAq0vcq8IeMKda515tS29jRbG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 11 Feb
 2025 12:20:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 12:20:08 +0000
Message-ID: <0eb7b5d1-692f-4fc8-a3b5-6eeb5c56f90e@cherry.de>
Date: Tue, 11 Feb 2025 13:20:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay
 for RK356x
To: Jonas Karlman <jonas@kwiboo.se>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250209232801.3185681-1-jonas@kwiboo.se>
 <20250209232801.3185681-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250209232801.3185681-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:802:1::34) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caf848b-6b3f-4af7-aa5d-08dd4a966c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEd6T3VNZG93UmFNR25JbXFSU2ZnQzVkaXVzZ2xYRUpmZVFWcWhDNzg0dUM4?=
 =?utf-8?B?emFlRUNhQ1JVYUlzeDBxUFBVekcwQ1o0S2Rod1Vxd0dVTm8wNXpjSXo1elgv?=
 =?utf-8?B?ZWN2TlpjV0pZR2NqdUJoK2xQREVMMnBRaE9uZnZYazI0WDVrNVlIYVd2K2VN?=
 =?utf-8?B?aVZXRVVXQjk3bmlsYW80QllzK0t2Vi81dVlNQ0tNMTRwdFNGVDNiOTNtbVlX?=
 =?utf-8?B?NmdjUnY4VTV6cURObzVNTE5QQ1NXUUJRZ2MxTUNlKzF1aW5pTzN6Sk1BeVdD?=
 =?utf-8?B?c0VjN1pKL2RzRDd0ZmhRZTlwMTFySTZCdW56bnc3OEsxZFM2MWkxSFpvbFF3?=
 =?utf-8?B?NytaWWluOGt5K1o5WUgwT2NKOXNkQ0lDNmpKTllDd1A1YTBjaWhDSU1pQURI?=
 =?utf-8?B?anR3blV0WFVaMnFDaHhqdnQ1WitPUVVZc2pNUDRrbHluc1F5OFhnZG04SWhm?=
 =?utf-8?B?T1IySDl3bVYwdmphWk9ueGFYMEZQY2RUSHBpcWVGU2YzOFVyemtaMlg5NFV0?=
 =?utf-8?B?blJ2MjlLNjZyZ0d1KzkyRXA4QzBCa09QdkZwdnNRZExHWEcxV1hZQ2dqM3Mz?=
 =?utf-8?B?cHdNZnEvNytqOTBCOW9xc3NBaGNnd0RoWUM2OXJmeWFRY2MwMUdkUkJMU3hB?=
 =?utf-8?B?SjFOUTQ4S1dPNFZSYXBrZnp4SzZXQ3Q4SG0rYXFuOVZadHRQUmZqUDVpNDN2?=
 =?utf-8?B?TWNIb0VFNm9EY1dXMFFsSUIraXVuV2U1VUxZUExGUXJHWUlNdWwwVFBBbzNn?=
 =?utf-8?B?M3RzbzdVdi9CS1JWR2JoZnNBQlMvS2JJMEh6QnNlWTlkblhvcy9valJNeC9v?=
 =?utf-8?B?V0k5UjJFYzlpNGlJY2pqblJQbGRiQVgzZVh4ZHIyNHk0azlVVXh3cExTVFFk?=
 =?utf-8?B?U21kSzFONkV6ek9weHVFMEdQamg4cWcrdi9UbVRNQUhSUEtJQ1V5UW1uNUNM?=
 =?utf-8?B?THN0azJpYnZqOXpyOXduaHlSeUtHa0hycU44bXVyYmJqS2l3ZjhlTXo2Sk1J?=
 =?utf-8?B?MXh1N2w2bVhiRnhqNlA1Y3lCSTJNMG1QZHZObWlISWxoR3ZtYXZRYlRTOUJv?=
 =?utf-8?B?Y2kzTXlKU1BpQW81NVkySi9zZjF5aUJmNEd3SEI4U1QxRmhxM3dGbmczNmg4?=
 =?utf-8?B?Wjhxekl3QUp5VXNEeDhjSEN6MXNXdDc3UE5hN1d6RElHWWlaYUI3WjZ6M1NK?=
 =?utf-8?B?ZWpyeHVUYmt6TVZOTEQ1QWd1SVAxNE1ZRXRqeVpSbjA2MmN0S3ljaUxVNWFC?=
 =?utf-8?B?ZUxScXR1QUEyMnhoUnZHTW1SSmxtS2pjeDNocENHWnVNWWVxRU1heWtMMzU3?=
 =?utf-8?B?WW1BZWhXdzlMdDFLNCszTUU5RE5VR2k3OTBXQmZPa0Zkd0VnMXc5ZDFPQ2xV?=
 =?utf-8?B?U2lnMHY4T3pBWUc0R0ZQazBNb0ZHL2ZqWlNsV2d3K0J2V2JubFdMdTJBMkF2?=
 =?utf-8?B?bXM2bHA4Y3ExK2dRR1ZGaHIzSE81ckZzaE5rZWtRLzhEUSsvSWs5ZkN0NUg4?=
 =?utf-8?B?NDVKbUJtdkgzU0ZmM1dBS1VLb0k2Mk95bEcvSEh6aVY1elM5WG94Q2x4SnlO?=
 =?utf-8?B?SVdYV0I1VW8rNEZQV1RJQnJ5NkdBR3J1OW9GbmlGTWFNTHF2bjFQU01nQWw0?=
 =?utf-8?B?WDY1ZGlQYTErUFJXelVFUWYvbUx2RU5PVWgzd2ZNaGgycW5qb1hlOThoV0xx?=
 =?utf-8?B?R0FTTEZOQkM1ZFlzZlYrQ1Zqc2RkeW4yVU5Dd0ZSamowQ3JjMER1N1NwQzlI?=
 =?utf-8?B?OTZtRDZLWEd6bzBaR1dtN2k3dU5tREE5SnNpb0tIenYyVjBMMzBCcEhuWlAr?=
 =?utf-8?B?NGZvcWVLODl1eGtrSHhETk1Ia2ZTamtlOHUyQlREc2diZDExa0JTaWRpSnRC?=
 =?utf-8?Q?u/SjN14/jtCMC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBjUDlsSXZMYktFQkM4WTN2bkxLdTBPV0NsblZJYVU0U0FnU3g5N2NRRGlY?=
 =?utf-8?B?b0dpcitCOXNSTUpZL1FsNnpweEthZHp4c202UFd3U080eFh2alV0VGV5R05P?=
 =?utf-8?B?WDNiVjF1QVVuWk9vTkxYT0c2ZWttSnRsRTBqU1BVOXBaNFNqVDluazZvTDlO?=
 =?utf-8?B?NHFrbytJbjFFWTlzb1ZhZGlzelY5YnFiVkNkZjc5bXppRGpmaDNDUWRkT2cw?=
 =?utf-8?B?bTlzNkZzTHQycTNRcTkva3hDSkhFcFJVTkJ2YWRXQ0VjMkptQnZMMUdTZUhO?=
 =?utf-8?B?K0lQSkVTT2ROUFZJeCt5Y3pyb05OaTBPUjV0elROUHYwek9kQ2NnMEthaWs1?=
 =?utf-8?B?Mk1wcWIxZVZ1ZzhKMjN1T25WOTFySG5hNjlGTE1PMENwSVU1VVkvbHlaRWJp?=
 =?utf-8?B?MXM4Z1FGRnJhai9MRmVEVWQ2Yk5OWXpiNWJSV0d4RHMrT1RLd3FrODNtV1Vu?=
 =?utf-8?B?eWpaaDhvMVpQL0R0QXNBNHZwenhPdzVhMFF6Z2NBZXhDZGlGczhFbFFvZDBX?=
 =?utf-8?B?MHZYMGUrTjU4NzlWYW8vdzBSUjFKY2lFZ1JhUmpJY1lSZnBDSUx5YlFpMmZo?=
 =?utf-8?B?Q2I3WjNTS1lqbXhhNVhQOXdOTDVkZ0tvdjZ2cFpCcnpUUzRjR2tJRkpqdmRR?=
 =?utf-8?B?LzQxaEZHQXNoU0pHaXhVTyt4TFNWbkZJckVYR3VjK1pzNjdVWTJTQTJTWEtp?=
 =?utf-8?B?V0ljM2dPYjlmanZ2Y0huZGVYaUdOSktQU1M1SVd6S0hCN2hCRWhpZEZlU09D?=
 =?utf-8?B?ajg5QjF4c3RkcGxrL0RORkd1YzJ1VjZ2ZVRkVG80MWo4eXJVang0eEQ0cENo?=
 =?utf-8?B?bzdXaTVEdTVwUENLc01vS2hwRnRsdnF1U2VMVGg3T1NydFBzZkdTcnphRkFm?=
 =?utf-8?B?di9RTzU0cWNUY0s1cU9IcnRTYkhiQ2Y0ejgzS21kZ2ZmS3hqQWYzQUdtVU5Z?=
 =?utf-8?B?c2EwRGJsaXBMb3FKblp5MzlERTIvNDdibmRQVlRURWhuSUFQWkZEU2QwQk82?=
 =?utf-8?B?QlNEQkJsclE3K1dndDVhdFMxUXErVlVLV0pUUkU2ajVkTnVMV1FiSkNXWTNM?=
 =?utf-8?B?SFp3N1FkdGp4WmtCVzZVakJBWGJWRWo1RWJvdyt2aWd5NXZjZzcvMUYwcnlr?=
 =?utf-8?B?NGlzckhTWXl5Y3ZIMU1hMUZsUWhGVmViV2NaczhBYXBRTDBOYWRvNjB5VnJC?=
 =?utf-8?B?cm12eUpqbFFrOVhTNmV0NktLemdCU0tBQ0RxcjBhdld4Vm4xekNqSUNVMFg3?=
 =?utf-8?B?R1VKczRpdTBPbll3YlA1eDc0WGx6VHBVL2xYclVhK0Y4QldUWFd4R2VDb0VH?=
 =?utf-8?B?SnZ6WFh4UXpuVFh4S1hSTnp6V1hKWlIvVERGV01lYVpXa0U2YTFRREZGVHVS?=
 =?utf-8?B?dmQ3VlFtdDRrWXgreHVQbkZxMGRac2RwczhMckhGVDFzLzVWQWdVYVl4dzJX?=
 =?utf-8?B?VkxKRTc0R1J2MkswTkd5ZVNSSEJtYWpLd3BqZVhWc0xiYnZKWVhMTGgxQnVz?=
 =?utf-8?B?cE9KbW9YTU8rbFVZSmJqSmU1STV5OWxtbXUyY2pCTkVucEcybzc4Yi84TFc5?=
 =?utf-8?B?R09lMm10SzhudXhSc1VCUVh2blVpaDhhR0cxWkZWWDA4cTUzMEh4WkVYWi9o?=
 =?utf-8?B?QWp5eFk0T0ZMUXh4c0F1OG5kSEc0bmlJZWZNQVdMM1JiL3F5a1hITG10aGti?=
 =?utf-8?B?QkpuZGp3OWhTTHVhUWtZTnFEeUUwdFQxMzZMWEdCSnhUMDNmc3ByUlBsWGRW?=
 =?utf-8?B?VHA5QWY4a25wK2tDdUhzdFFJc2Y2VkpBS3M2L3VlQmpjNHEzNU11QkJqTWRw?=
 =?utf-8?B?ZjBhYjdrcVgvTUpKSzlLRUZYaklRK3pxQVNxY01pRE9pbzY4WGFLcy9zMU80?=
 =?utf-8?B?bUF2RVhXdG1Selg2dmZ4K1I5TklWanY1THBqUlRnbFJOQk51bXdhZFhUVTg4?=
 =?utf-8?B?NXhNVnR6dDErY3k3bmdVZis4cklZeEJRempFblVWN1F1bGdKQUVCTnJja0o3?=
 =?utf-8?B?S1ZXNlZwZFdlcUVBSHJyaUx6YnFjQjdRanBCZjBKeGdJTCsrc3czVHlhRGw4?=
 =?utf-8?B?Y0NaelRlbUxvdktKdzJBU2x3eUVRS2Q5VE0rSVYyRlJzd0pGVEVSbVk5U1dx?=
 =?utf-8?B?SmZBc20yTVZSSW0vZWxkck4ramhTakJYMW1NRTgwS2VOUURsVlpUNFA2Nnhj?=
 =?utf-8?Q?Q0+bilGmEhKaRveAZZ2eKuE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caf848b-6b3f-4af7-aa5d-08dd4a966c99
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 12:20:08.5700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5TDdmAmjtMM3ibhXJEaJY13TPppoe2Zk4KnSnZQ0awv9kFP66E+faPcnJVoNpi2t3AXDSiFi3V9Y1OJPKPYm3iADdJ70SBq+vJdQ2kYCtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799
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

Hi Jonas,

On 2/10/25 12:27 AM, Jonas Karlman wrote:
> When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
> and/or TX delay. Currently RX/TX delay is configured as enabled using
> zero as delay value for the rgmii-rxid/txid/id modes.
> 
> Change to disable RX and/or TX delay and using zero as delay value.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/net/dwc_eth_qos_rockchip.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
> index 9fc8c686b889..3e10e07403c1 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -46,6 +46,10 @@ struct rockchip_platform_data {
>   #define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
>   #define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
>   
> +#define DELAY_ENABLE(soc, tx, rx) \
> +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
> +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
> +

Considering this won't be used for RK3588 in the next patch and that I 
found it obfuscating the constants that are used, can't we simply do...

>   #define RK3568_GRF_GMAC0_CON0		0x0380
>   #define RK3568_GRF_GMAC0_CON1		0x0384
>   #define RK3568_GRF_GMAC1_CON0		0x0388
> @@ -85,8 +89,7 @@ static int rk3568_set_to_rgmii(struct udevice *dev,
>   
>   	regmap_write(data->grf, con1,
>   		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
> -		     RK3568_GMAC_RXCLK_DLY_ENABLE |
> -		     RK3568_GMAC_TXCLK_DLY_ENABLE);
> +		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));

(tx_delay ? RK3568_GMAC_TXCLK_DLY_ENABLE : RK3568_GMAC_TXCLK_DLY_DISABLE) |
(rx_delay ? RK3568_GMAC_RXCLK_DLY_ENABLE : RK3568_GMAC_RXCLK_DLY_DISABLE));

instead?

Also, if tx_delay or rx_delay is 0, does it actually make sense to write 
the delay config in there? (so the regmap_write before this one).

Note that the config is set before the enable on rk3568, but the 
opposite on rk3588 which I find quite odd, you usually want to configure 
something before it's enabled?

The change itself looks fine though!

Cheers,
Quentin
