Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4773CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223DB830F6;
	Mon, 11 Aug 2025 18:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jR2DR5wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D76831B4; Mon, 11 Aug 2025 18:59:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B88830B3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puZwRbvzFs2rmQGftXBfk30Z7q4EikoYPhEkzr1XouMz2OmzwqKz36aveFLMRoZbsdEysVs+Ygh3RUYSdwvtj9BLJ0gt835dfJigpvgizGEJtOi2jRfVJICGnPzJOpWA+qJ3HW9RlJjzXYt80WLKjlLToNwrGOFzenPDefJiWvEs4zZQS6BB6wwsWD8Mib2WYlL0S3u9ms003cPhg3+HE2ItLnHsvIP3xex7D4LYJ3j0TdsK368OF82cQwsTKxwJPalaKfhXRWxdUZqcZuzGKThYNjkF7utKWsI6dFvokilNsXnEVkhJfGatenZKogXRgQiWoUPRDA4BDhHVrxpuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTDJJ7btm14rDqYQrXjHBXUXhpqdgkfPeyBWwRGSGZE=;
 b=NNQZHS2NecqEuahiFAQnVd8x5Yn7v562P8yPVm5hDH21lWQQV2sNFyrdcQ6JBH5GYmZoXXyvATBS1FnVrni+G958E8SVsYiS84QS4eInZ5WtWzVipUmVn6cRWM6XFlzifJVQwvZhCA6V/p8cvfBoPtT3bqZiDbqL/tzFsF8ayvRbXOMWh2EPrNbQpIJqUEZfy5O+DFekoXtat9AAiaTAkFRbD25K8qvIulzsye4JO5ee4969ShBSHSbLJoPhOyMT9ceRjB+vlU5T3weh3PY3fc8Q3Q6gJN56MTWLMFPiVmIlRzLCc9PHsGrlNhnm6P4eZ7FvGUDfBUAUnbx4m4A4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTDJJ7btm14rDqYQrXjHBXUXhpqdgkfPeyBWwRGSGZE=;
 b=jR2DR5wrpjd7imoAW3sXUsDOVENJtCY2I+I/+kBno2usl46JXhRJDZCVz++8LerOCJ4AknawuPMRP47aLobZC0EalTWxbdpE98fk1jrRLfQYWehJ2IGSaA0ZCFopwTO9l2r1F8BMcoF1ZivXcg1xq8hxOCZwCid201KNz0CoYTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 16:58:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 16:58:55 +0000
Message-ID: <a0f4e533-9255-43c7-be25-9953d3585425@cherry.de>
Date: Mon, 11 Aug 2025 18:58:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250804181638.3855760-1-jonas@kwiboo.se>
 <20250804181638.3855760-2-jonas@kwiboo.se>
 <334d11b4-20c2-4367-9b3d-9720b2209dcc@cherry.de>
 <8e9607db-2186-4d45-a713-8d215e200208@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8e9607db-2186-4d45-a713-8d215e200208@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: c829d217-d1e4-43e0-b5a1-08ddd8f85b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0NyL0FMV3o0bEV0TU5DVGhWdDVnYVlqQlp0VXdUOUpuOG0wcFNlK3c0TEVS?=
 =?utf-8?B?RWsxbVIxOVZNcjk2Zk5EV1dlYWNlTmVacFlHVlZteVcrRWl0QzNFYlE0a1VU?=
 =?utf-8?B?L2l5WmhiZzdSakJNS2ZuaTRYMng1c2hrZlFjbmFteTJyUzFEcmszQ1R0L21J?=
 =?utf-8?B?SzBzNnZoeHpUNVFGMFRaaHBFQ3FxTXY2RzgwQzdmc3lvb0JWVmk0cWQyR2k1?=
 =?utf-8?B?S0x6a3U2K2FiWGdTUk5wQmdURnN6RXhOM0sya1FWajVZdzFSWEdDS2ZUK04r?=
 =?utf-8?B?ZUR1ZmU0cUdKSm4xcHhCVkt3MnJsL2dxRTB0VXY3YUl5VXR6NzBSM1BjLzFP?=
 =?utf-8?B?MU5XVmd6UUMwUU91NmJGTjQzZlpkdUhoSkdYMHZSZCtMbjRhcHhNcndvUGtP?=
 =?utf-8?B?c29XMWxMc1hYbDB6dnVPbmVxYTgzMVU2Qk95UnFCUklIWG1wVlA3eHJ4dHd0?=
 =?utf-8?B?dXllTE9KQUJQenVrcUlZSHp4Z2p1S2RmcHZDYVVqWGpoa0FpQmdzVElnWUVF?=
 =?utf-8?B?S3NmTlVESUpGVm1qV3BlclhGRGNkc29OdGVTTnpoVFRPZnpvY3lDODJzWDFR?=
 =?utf-8?B?VlpyeVFHRnJ5Z1JPL2w3ZFdSZ2JuOWlsck1lN2FsemQzV0t4Y3NNelFheVNB?=
 =?utf-8?B?SlVKd2MzM2ZwODA5Y1I3K1dzM3pBYzkvb0Z2TEtQY1dMR1huSzJNYkZJMG9X?=
 =?utf-8?B?MXdSMHE5cDRobnBpMDFZaFVsRmJ6S2VWWk5jRlNyRlZuUnd4RFc2aXhYOGxa?=
 =?utf-8?B?N3RscTFRQ0E5MGhIT1Y3VlM4blN4SjcwdUJxQ1lBNWU4U3ZGMnZTVUVYN1VM?=
 =?utf-8?B?bENQajh5SjRSckxsOFo3ZlkwWkk3Q3MrVzFtVDMvNlBaRUFJa3FpM2EvK0lj?=
 =?utf-8?B?bGNEZFFrQ2VpRHhjd1cxc28vejhxMDJOc2FwSXdPcUVjMmt3aHJ2RTM3MkFP?=
 =?utf-8?B?eVhLaDhhMGRudURwazUzbThBakNVb2lNL0M2Sk1Wbmo1K3B3R3ppNGRMNEph?=
 =?utf-8?B?ZFI4RW9NcGRHRUJGUXFPMTArZ3ZzVmpCVThib0h2QlZxRFR6RTF0eU1CVWxH?=
 =?utf-8?B?Umc3OWNjV1NTOFRNOEtPcG9HVTNlSEVTbFhsNkNpdzYxdElXb20yeFJrQlJy?=
 =?utf-8?B?alBiSHFoNVZsUlVETjVScno1K2JFM1BLaHYrTC9OcTg4VGRxbWN0OVl6Qkc2?=
 =?utf-8?B?TVV4N3lqMVQ2MWlobmw3dHVjRUZrU09ib0JYYlBGRFJSRTZWZGxDT3VSTUUy?=
 =?utf-8?B?TlBZbFpTNWs0VUo5QmRLdXpZV2R2YTY3Nm1nSEYyY1M4dm5mWVJsaEVHSzZp?=
 =?utf-8?B?MU9OVHI4NVhHTnRWU1E5MXlMM1ZOOW1oamg0c1JXWklDY1U0UDdkM1UwSitL?=
 =?utf-8?B?QU1MNEh6UGFuSFZPZUU0MUhwTFlwQ3E5YlNTTnJTRkRQVk9SN0lUTk1KNnkx?=
 =?utf-8?B?eDM5dXpHRWlENUcrZXpnMUxxY1hJS1ZacHNRTTc1WDF1bUhoZFpmR0lEU3Rw?=
 =?utf-8?B?cTZjaHFDQ1lPZmt5cmtsRko1RURaMXViN2lTUVFFWjJLNDRyb0tYVmNmUmtR?=
 =?utf-8?B?Nzg4bk15QVRNUDgzU1pWN1VjK0NqTzd1YkFzaWJBaU4zbWZPNUxTZlhKWE9K?=
 =?utf-8?B?UEpMMno1YURJNUtrUEkvUTVhRkVYVzBOLzZKdHhKQjkxMXVLQXhnWmxhRnRv?=
 =?utf-8?B?K3RCV2szWnJzMmk0VjNpcjFDNythUUJhTENFaDkvL04yOXZ5MmVJUzdRelA0?=
 =?utf-8?B?TUJWdkRjcU15NG9VR3BUVWFWdDlPMjhRdXRYMkV5VTRraE05MzhiSThiN000?=
 =?utf-8?Q?ed69ZzZSwU9qeQlP63ihG1un/1r9yvMMfn8Uo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUljbkRuLzVsUGloVE5IellON2FDanpCL2pTTWdiRmJvS1pCZDRPb24vNUdG?=
 =?utf-8?B?aHpEWGRaL3RrWGJnN3FPR1hvV1ExQ0RMUC8yVTZEYTBMdlJZbXNhbFhQK0Nv?=
 =?utf-8?B?YitXZHlvRVViUm42Vkp4OHNTWlI5dVNNb2tqcDF1eDNOUFU2R0hqblRNQXNz?=
 =?utf-8?B?bE9hUC9tUTRGMmpNS2NVL3UvNXlaTk9sdWxKT3dlREdnZm1ReW1qaDFJbzBN?=
 =?utf-8?B?N3RWeGxVbGZXK1EwNm8veUgrZnplUm9WUVB6dlEzcXh0NjB3YWNwcUNycFpZ?=
 =?utf-8?B?VmdHVWlHTWlURTZPVHlSRDc0eEgwaWZONk1VdFgwaXlleDBUTFBPTEprMGNp?=
 =?utf-8?B?MThUZkdWSjREQ2FvcmdJZkg5UXMvbE9XTDJEdC9naU5TaGgzWElsSjBEekJi?=
 =?utf-8?B?cStlVUpwaHNzVU1hUWtBeHYzYytzY1FMSzY1a3Qxd1AyQmYwVXhsaDRkSGhx?=
 =?utf-8?B?a3Q4M2VHeVRYemFoTHNCRXd2bithNmdFOVk2NW16bk9naUtlYlFWTXhSZmJP?=
 =?utf-8?B?UjVWT0JvZGhXQVVjR1VwUGh2em1lbU1zZG0wRFhCempVbVZWWWFPK1VpVEgr?=
 =?utf-8?B?Sk45TWRCOE5EQnA3NDJaSzkzODV4YnF0cis0MklDc1VFdlBDWVJsYUNWaE40?=
 =?utf-8?B?RlB6eXFZQVFHaUlaOU02V2FuaXUvTjh4NUt4L3BaaXkzbDVWVGF4cG5UaURB?=
 =?utf-8?B?NXJqVjhSTGswT1VJeWZnUjlrMU8vdldqd3BTdGJyM0JQdE5DL3kwaTJhZEo0?=
 =?utf-8?B?YnBJV2ZzMWVHYml3d1pleFpHUyt3cCtuVmoxQXN6R1dLTm5IVjg3cVVLeDVt?=
 =?utf-8?B?OXlxT05qZ05GckpHd2xURlEwbWpPL3J0M0NhSkw4MStFb2UyVWY0NVdlbWEr?=
 =?utf-8?B?dyttcUFyaktmOGoxRXB1TWlDbkJwdy9xL2NEcXFpNHA3MFM3UjB0aVU1RWVy?=
 =?utf-8?B?ang4NWEyemE3K0h2WG9wbWY4L3NGdVIxakxhVkU1UklwUE94UjNJMkwwV0d3?=
 =?utf-8?B?ZityRXFTYUZjZzR5eXIxbEVJNnNsc1N0VHpMN245TlYvYW5YTGs5OUtYZDZL?=
 =?utf-8?B?Unl6WHBuVGlPUkhjeXY5TGM0K0NTWEhPdUxmT1Zhei9ubGUzaEhVMXpNcW5G?=
 =?utf-8?B?RFhsMGg1bWl2ZjNwNHVWS3hwNjJrRDdPbkRmUVBxK24zTDlrYi9zL0YvdjRC?=
 =?utf-8?B?NS9WYlZWdjJSYWV4NzUwN2h3MkRuMkJzaFFNS3NaMUFuc0FzaFZncWNPRnp4?=
 =?utf-8?B?a3QzOCtSWk9KeFZHb3IybStKMWp2WDA1ZXMyUk5GMkcvaEVxWWxPOEI0QnIw?=
 =?utf-8?B?dXovdVBZV1dTRWFhcXFGZVRVeW0zNUpvbWpiZXlJanVlWWVNcHpvbDB4dkNp?=
 =?utf-8?B?YXlLTUtudmMzZmNNMGVtdjRPeTd6ZkpSTGZ4dy95cjUycTNDa1VPN2owaHVX?=
 =?utf-8?B?S09Mc3VyYk5ndWhoTlB0MWtuVmNyWFdhaWd5eWdwZWh4NTBPWTB0VGh6THpI?=
 =?utf-8?B?dEJnMzFwQ25BSlViZ0g3VVFVeFhlQ0V1ei9hUElSQ3dTZFNVeXNFdlFOK3dz?=
 =?utf-8?B?aGkzSHNUS0wzWERDMlJKYnRDUGJZeVMrb0s4UlVNM2VhVTdlSGhPc1pYMDJD?=
 =?utf-8?B?Ymw0b1ZIYjd5TVQ0UWorZjhkbEhVU1B1K3plbnozS1lJR2tpNmduQ2VMQTBO?=
 =?utf-8?B?S01aT1M2dERETzFMbThYMGlNQUxZYXRwUGJUdnliei9TeVVGQmdQMkRDVDM5?=
 =?utf-8?B?UnRpLzNCcm1neU1TY25GTnA1UzdhbXQzMEpsaVpFSmxKZ3I5TGRQV3JEOS9Z?=
 =?utf-8?B?aFhwOWlYWlBmbkhmS3BLSWIzNHVjSE1OTk9zZ21SOHlNQk1USkhLMFliUXFH?=
 =?utf-8?B?S1Fwek44ei9EejQyd29TQmhEYlM3MmJqUW9ONDFLSmxndmlZL1IxVUU2SStu?=
 =?utf-8?B?YmliSklrL1dKNXcxcnNuRE1SNjl6UERMUlU5dGFTVllQekM2ejV0MG52RkRP?=
 =?utf-8?B?aGoySlNlc2ZpbUZRUitocE5ZVFVxUjl1bGhWU3Rka3AyQ01nSUc1MEdITStD?=
 =?utf-8?B?TVowaENzRHdiVWV5RWM3Wk9DcXNDbGoyZlJteEZWdGRmTmJJNlQ4RmRmYmRs?=
 =?utf-8?B?WFUxL25WQkZKZytyYU1uYmRLZWE3Y2szK3JEZFpJVkNWVSsvY3Z5UVArWXVj?=
 =?utf-8?B?MnRJK3RLelFLMnNERjE0eHBadkY1VFZvTFc1cFRSWDg0YWhiSGQzYlU2QmxT?=
 =?utf-8?B?NkJNbEtHSHBjQWR2aHZlU3pVSDBRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c829d217-d1e4-43e0-b5a1-08ddd8f85b3c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 16:58:55.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zHN2IGfGIPXoMCDUs07iOb2GJwMxqfxPcWg8T3Npftb61NzBYUvaGe5WGKxBj+79U4vsIdN7JYh3CHENLYtEaEKDt9egiqXlaUErZQxlZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955
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

On 8/11/25 6:36 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/11/2025 2:11 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/25 8:16 PM, Jonas Karlman wrote:
[...]
>>> +		/* policy: always fail one rkvdec core on rk3583 */
>>> +		if (!(ip_state[1] & (FAIL_RKVDEC0 | FAIL_RKVDEC1)))
>>
>> You could want to only check FAIL_RKVDEC0 as FAIL_RKVDEC1 is a bit (and
>> not a bitfield so we don't need to set the whole bitfield in the event
>> it's only partially set like for CPU clusters). No strong opinion.
> 
> Main reason for this is to keep all policy logic more consistent.
> 

Fair enough.

>>
>>> +			ip_state[1] |= FAIL_RKVDEC1;
>>> +	}
>>> +
>>> +	/* policy: always fail one rkvenc core on rk3582/rk3583 */
>>> +	if (!(ip_state[2] & (FAIL_RKVENC0 | FAIL_RKVENC1)))
>>> +		ip_state[2] |= FAIL_RKVENC1;
>>> +
>>> +	log_debug("ip-state: %02x %02x %02x (policy)\n",
>>> +		  ip_state[0], ip_state[1], ip_state[2]);
>>> +
>>> +	/* cpu cluster1: ip_state[0]: bit4~5 */
>>> +	if ((ip_state[0] & FAIL_CPU_CLUSTER1) == FAIL_CPU_CLUSTER1) {
>>
>> No need for the == FAIL_CPU_CLUSTER1 check as you'll have set the whole
>> bitfield earlier even if only one is set in the original ip_state from
>> the register. No strong opinion.
> 
> Main reason for keeping this is that if you comment out the policy part
> above, you could end up with a single core removed, so this extra check

No you cannot at this point in the code :)

Earlier you do:

+	/* policy: fail entire big core cluster when one or more core is bad */
+	if (ip_state[0] & FAIL_CPU_CLUSTER1)
+		ip_state[0] |= FAIL_CPU_CLUSTER1;

This means that all bits in FAIL_CPU_CLUSTER1 bitfield are set if one is 
set.

This means that if you check

+ if (ip_state[0] & FAIL_CPU_CLUSTER1)

later on in the code, necessarily if it matches it means all CPUs are 
disabled in the cluster.

The only benefit is if you are anticipating removing this policy in the 
future where then the cpu-map shouldn't be removed if not all cores 
aren't failed. As it is today, it is not a necessary check (but I guess 
it doesn't hurt, so keep it if you feel more comfortable with it, this 
is really just me nitpicking).

[...]
>>> +	parent = fdt_path_offset(blob, "/cpus");
>>> +	if (parent < 0) {
>>> +		log_err("Could not find /cpus, parent=%d\n", parent);
>>> +		return parent;
>>> +	}
>>> +
>>> +	/* cpu: ip_state[0]: bit0~7 */
>>> +	for (i = 0; i < 8; i++) {
>>> +		/* fail any bad cpu core */
>>> +		if (!(ip_state[0] & BIT(i)))
>>> +			continue;
>>> +
>>> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
>>> +		if (node >= 0) {
>>> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
>>> +			fdt_status_fail(blob, node);
>>> +		} else {
>>> +			log_err("Could not find %s, node=%d\n",
>>> +				cpu_node_names[i], node);
>>> +			return node;
>>> +		}
>>> +	}
>>
>> I would move this closer to the renaming/removing of cpu-map. No strong
>> opinion though.
> 
> Sounds good, I think this is just leftover from thinking we should
> continue to load Linux in case of an error, and just trying to fail as
> much as possible before there is a chance of an early return.
> 
>>
>> I'm wondering why you aren't using a direct path like for other
>> controllers, e.g. fdt_status_fail_by_pathf(blob, cpu_node_names[i]) by
>> simply prefixing each node_name with /cpus/ ?
> 
> Good question, I think it may initially have been that I updated the
> ppi-partitions affinity using phandles to the cpu nodes. However, that
> part was removed before sending this out, will rework this for a v4.
> 

Then you would be matching the same workflow as other removals earlier 
in the code and won't have to mind about the return-early scenario you 
were concerned about just above.

>>
>>> +
>>> +	node = fdt_path_offset(blob, "/");
>>> +	if (node < 0) {
>>> +		log_err("Could not find /, node=%d\n", node);
>>> +		return node;
>>> +	}
>>> +
>>> +	snprintf(soc_comp, sizeof(soc_comp), "rockchip,rk35%x", cpu_code[1]);
>>> +
>>> +	for (i = 0, comp_len = 0;
>>> +	     (comp = fdt_stringlist_get(blob, node, "compatible", i, &len));
>>> +	     i++) {
>>> +		/* stop at soc compatible */
>>> +		if (!strcmp(comp, soc_comp) ||
>>> +		    !strcmp(comp, "rockchip,rk3588s") ||
>>> +		    !strcmp(comp, "rockchip,rk3588"))
>>> +			break;
>>> +
>>> +		log_debug("compatible[%d]: %s\n", i, comp);
>>> +		comp_len += len + 1;
>>> +	}
>>> +
>>
>> If it happens that none of the expected strings are found in the
>> compatible property, we should probably return early.
> 
> If none of them is found this logic will just try to append the two
> compatibles at the end of any existing compatible. Should be safe?
> 

Mmmmmm, you're right, it should be fine I think, but maybe we don't want 
to add rockchip,rk3588s if the DT only has e.g. myvendor,rk3582-myboard?

> The four main scenarios I try to anticipate is:
> - rk3582 boards: <board>, rockchip,rk3582, rockchip,rk3588s (do nothing)

This you aren't doing at the moment, maybe we should return early if 
soc_comp is found in the compatible list?

> - rk3588s boards: <board>, rockchip,rk3588s (inject)
> - rk3588-generic: rockchip,rk3588 (replace)
> - other: <board>, <wrong soc> (append)
> 
>>
>>> +	/* truncate to only include board compatible */
>>> +	fdt_setprop_placeholder(blob, node, "compatible", comp_len, &data);
>>> +
>>> +	/* append soc compatible */
>>> +	fdt_appendprop_string(blob, node, "compatible", soc_comp);
>>> +	fdt_appendprop_string(blob, node, "compatible", "rockchip,rk3588s");
>>
>> I would rather insert rk3582/rk3583 before the rk3588/rk3588s and keep
>> the rest untouched instead of truncating to rockchip,rk3588/rk3588s and
>> then adding rockchip,rk3588s back only.
> 
> That is what this is trying to do without having to add too complex code.
> 
> We can only replace the full nil separated string array, and adding
> logic to re-construct a single working string became too complex. We
> already had helper functions that could be used even if they are a
> little bit inefficient by causing three fdt prop value replace.
> 
> The truncating changes the string length to where first (or none) soc
> compatible is found to then insert correct soc compatible.
> 

Yes, but if downstream decides to do

rockchip,rk3582, rockchip,rk3588s, <board>

We are screwed :) as we'll return only the first two. Does the user not 
following the spec deserve to have their DT broken? Maybe /me shrugs

>> I wouldn't want my device tree
>> to be modified too much and we don't know what we'll get from downstream
>> )I'm not necessarily talking about Rockchip's vendor kernel here) DTBs
>> for example, so truncating doesn't seem to be the best plan? What do you
>> think?
> 
> We could possible make this very simple by just appending soc compatible
> when it is missing and not care about the compatible order.
> 
> My intention was to ensure that we always end up with:
> 
>    <board>, [<...>, *] rockchip,rk3582, rockchip,rk3588s
> 
> With a simplified append it may instead end up as:
> 
>    <board>, [<...>, *] rockchip,rk3588s, rockchip,rk3582
> 
> Does the order matter or should I just drop all this and replace with
> something simple like:
> 
>    ret = fdt_stringlist_search(blob, node, "compatible", soc_comp);
>    if (ret == -FDT_ERR_NOTFOUND)
>    	fdt_appendprop_string(blob, node, "compatible", soc_comp);
> 


Nope, this doesn't follow the DT spec then:

"""
  The property
value consists of a concatenated list of null terminated strings, from 
most specific to most general.
"""

though this is said for the "compatible" property of a device node. For 
the root node the following is said:

"""
Specifies a list of platform architectures with
which this platform is compatible. This prop-
erty can be used by operating systems in select-
ing platform specific code. The recommended
form of the property value is:
"manufacturer,model"
"""

c.f. 
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf

Cheers,
Quentin
