Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A7C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43DE82F6F;
	Tue, 15 Jul 2025 12:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="k+msRBVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F48D82F8F; Tue, 15 Jul 2025 12:34:18 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD6382F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFypd/6RVjlhxYWN8dWd0vVnQMYZLB1XwUy35bJSNPR2HFwM5PcybGpm3rgOzYP5VGlzOAokEbp+sHxrgzVYziRNOhJyu5VJgnjgzvSc2GrucuVRW9e5EiG/QAy7m8b3y+KKl9T865+H6jmW8JcBrHT6r27lRO7dw52EQGIRKsolAyyBMUX4ak5OifB1xvzfJPBudqnOi7hykhukjb+v/8sle4fSIl54GNarA1/p0oEXgBwsWZY9pZOqt7PCX35+VQn+AR/15g4WNbPdwiKUf4WmQVUS7Sw44DB8h9ksmm52yWnYE4cud+WRMiWqjNkQ/5sGh2N3x+CuIjjuwtBBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB5SuGqcQ3qG7LpT/HOy/Dc7FOohjwMJEi/dG0G1Cts=;
 b=rmESXyvKao+2a4wzAv6FV1OpbM5fGZDdH0Ih5B7ZrwZdS7k5BtkTcU6nveW6veAMbjMae77KSYySu10rNI+VFea1vJicJduFuPBDlXO8Y3j16WSQ1/Iudtk28Q6PF7Djm6CwcUjNssw4c4IAdwH+cVF+51UVxr7CfKgghyVKUPYMHpSO27skAZDUegyqsuizJdPUSBxIEDemBvkReIv3xREe49dz41uAHhjqZMfZlgmJ76rsWTmpUDUP3CkhTwY8zrqAd+k/+6PcMVxgaw6W0dhnx7jWjjwWwa3Li/7vmdPfc21Cn5CHWJ7yXVvQvz1nTk6J4B+UEDM6sheORXVOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB5SuGqcQ3qG7LpT/HOy/Dc7FOohjwMJEi/dG0G1Cts=;
 b=k+msRBVTNHmxk1OJF5K0HXzeTChKnrguw7mFxRSCajld9WzeCUINdZinnu8HB0yt9Y70VGOR/WrvMOSspsa28coxDvBHit/l+Syfa2rI+kfbe7YcrhkH0OW2pPVcAM3+Cp1MMY1PhGRvmwj3eOev6GQJBhqLBLTAzzQb0te4wXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 10:34:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:34:12 +0000
Message-ID: <4a653cc5-24bd-4103-969b-7c4117597f9c@cherry.de>
Date: Tue, 15 Jul 2025 12:34:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250710162110.3592089-1-jonas@kwiboo.se>
 <f8220dee-4f70-42c7-af38-53e5a649e31c@cherry.de>
 <e8c2de73-48b8-47ce-9039-9bb00c5d2261@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e8c2de73-48b8-47ce-9039-9bb00c5d2261@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d662ee-00c4-41be-2185-08ddc38b2376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlNYazF5NG0wRm81bnJzZDRuNkJHWDBhYUVOTU1oY2ZTVy9NUkx1bFNid0JE?=
 =?utf-8?B?Nm9oUUtEZDE4TlQwdlBVQ0w2dkM1T2lST2lRbUw0aGUvTVZuMlZTY2xPMERC?=
 =?utf-8?B?RHpMR2EveUlCc1JvUnNNZU93K1VUY1E5Sm5jY1ZRbG16Q1FpTWR3TlU2NldG?=
 =?utf-8?B?VHkyc0ZjRjhqOUQ4dXd1YkdYUGFBNWs3Zyt1QmJ3dndON3pNeWZtMzExWG1X?=
 =?utf-8?B?K1h1TTFvSWkxOFY4Z3NQU1V3OWhXUTNlWk5PN2I5U2phMUJwYlB5RXZUZmFE?=
 =?utf-8?B?N05UYTU3djhjOUdIYXgzcUh3ZHpqSVZZNjdCZ2NxaFQ5M2VQVjN1S3dLU2FJ?=
 =?utf-8?B?MlRxK3VCOU5sUXMvL0xMRzlzY21jR3J4djNITWlnNllWNnd2UEdzem5vdXhU?=
 =?utf-8?B?ZW1xNkY4SU53ZEU1RlU2cXZHK2l1YitUeVFQL3k5TU8zMjVkVHBPU3Y2c1Z6?=
 =?utf-8?B?K3lMLzRNSGJ0YXdFb3N4SUc2SVVEZ0grbkN4QWxXVzBrR05lQ3lUMHM1WkJQ?=
 =?utf-8?B?NVhtT2gwWFpMUGZqYXBhR1B4VU5GTFU2SG5WWmdlb1dna1FURGVJNHdkRlpD?=
 =?utf-8?B?QjM3UjBQUWNsaVc2dnZTTjNvb29hcFlzYTJSdlZUVGJWbDYrL1hWcTVwdlZq?=
 =?utf-8?B?QlJaUFI0enBLUUpkckJMVXFGYkxNNmFUTCtLQkd2V3hwWEo4OWhHRHg5anFm?=
 =?utf-8?B?cm9GOFQwQUY4ZURoR3NRdW5wOUlMWnpYaEpHL0t3bXdnbUw0QXhDcW4wYWR1?=
 =?utf-8?B?clV6NmZvdW9rVXl2eWxuaFNpYTdZTWlpYzZ2R1FyWTNkTnRNbnVPWEViQmtY?=
 =?utf-8?B?alRENzZ2cHJOYi84dDNqUVBHS1pGNHZpR2JSK0ozNHpPN0pRNWRnN2hQbEZX?=
 =?utf-8?B?SE0zTGM4eEtVcDFWSEUydjNCdEdwejBVUDV5ZHF5QmxxRnZ3Zm5GWGw2Rk9Q?=
 =?utf-8?B?ZHBWbkNXWnFDelJrOWtRNWxWaE1CbExVYTU3N0Q2MklLR0U0RGsxUmJ0UWxv?=
 =?utf-8?B?TldkVWRvMjF6YzJieDZkOHVnRTFRVUZsbVdMZTNUeE00OCtJLzVPY2VUTXo1?=
 =?utf-8?B?cHF3enBKT1FwYndLbi9ucUdxSmRKbTE0NFJkQ2tFSG0vOTAxU3IxN1E2a282?=
 =?utf-8?B?QUR5U09hbE1aUHRBUlBTWkhiV1oxbVN3RzJwU2hNS0ZVQTV3djB1OUNLbzJl?=
 =?utf-8?B?KzJqak5xa21EL0gyRy9TY0VZZklGUnp4R3pzT3RLTnRsMFByMmlFZmc3Q1gr?=
 =?utf-8?B?MUpERmpKZXBhRXJ5UUF6L1VPdFVEZ1Y5K3M4VFZha2JlY0pJeUhZZzI3ZDk5?=
 =?utf-8?B?N2FBdVlteXFpR2hlcGl6WjhoL1h1M0pnUUhRUmVJWWh1M1lLRUYwR25xbGx4?=
 =?utf-8?B?aFNCcXpEWjZuVFo4Z002NS95TjRWSFF0VVdRYzJMVE9Xc2lKelRwUVNkSjVo?=
 =?utf-8?B?SkliU0Q5b3BBQ0hwOHJWSFU4MzdKNjI4S0hqR0p5bncwVnpuRFZ2VC9jc1hz?=
 =?utf-8?B?SDk2L2wwbDM0YUovZHBuKzNMUUd5QjlsUUI1NGpEVE85Wk1Qd3k1OG5jZk5q?=
 =?utf-8?B?S001TlJyZ0FlQmJsVkZSVWZYVFNidThnZkFGanpIUG5pSFJrWnRDZ0NFM25D?=
 =?utf-8?B?NU9wV2FEbmV0dWthZ1FBb2ZuV1hkdVRHWlIwM09VdkRZeWViUFVobWREekRL?=
 =?utf-8?B?d1AwNTBtL2xyRXZMbzdmTVRyQWZSVTR1L0FaS3BpeEdmY3FsOVB6N0laeWFK?=
 =?utf-8?B?SW51bEIxbDlvZWIwVndINGEvdjRoM1Z1a3Z2SWhOQnNOc1ZXeVNPQjJidFBv?=
 =?utf-8?B?akxNNWk1QUc3eG9YU2NDeXo3andYWE50KzlkZ21UOUxPVXd0dlUrVk4xZW8v?=
 =?utf-8?B?anRqQlRKUE9mblBLelVrWmlSNlYzS2I2R3E4R1A2NWY1cFYrYjYzZmhSQTVk?=
 =?utf-8?Q?Acx1FAMKAW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXMyeFFvQmlHWGE5Q0VIZ3FxcXZLcmlmdG9YTzdISkt1SVhCK3Q1UzlJcGhj?=
 =?utf-8?B?dnlqOUtSdFJlRnhubHRFa29qRzkxZlNrbWNJZ3hCT1pZd2lESWlaWDlheFVF?=
 =?utf-8?B?cGsvSjB5YXU0dW9vKzdiQlVxNWZkZHRmOVh1VktnMHJ2WTFlOVRybHlLTzRm?=
 =?utf-8?B?alBsRXJMZHoxM2FDVU9Rc08vVHVXKzN2bjFRdmxTTEM2OGM3TFJOc29uWHJM?=
 =?utf-8?B?Q0hkK2hpVGt1Q0dZL1RJUmcwck90SFhhanJmYktiQ2cxb3ArOTgvNkR6NVM1?=
 =?utf-8?B?YVNZcFhFS2Exa2hpYnBzNXB3WGIrOFA4K3pRK3VKalFvdnpXUklPbHg4MjJP?=
 =?utf-8?B?UGIvdHZHSlgrZTl3SExodmc5b2w4YlRmUUE4Z3F5OW1VSjN0VHFoRVVJblFH?=
 =?utf-8?B?dUZPZFJwUm9SMElkckpBZGQyZ0lsYU53bGVBcVlJRXdROUZjL3pCS05CZGhF?=
 =?utf-8?B?bDY0S2ZpUDZDMXY0UHptN3NtUDJhbEE0Q1EwTHpGa0VFWSt4Z09wMFpoUWM2?=
 =?utf-8?B?YlZZVVNUN1NnUy9wUzJ1YmgvWUhzVDZxMHdYRTB2L0M5Tzk5WStKUFR3ZWhn?=
 =?utf-8?B?Qk4zSUlaUXIzWS9zVUluR216Yk9RRmM1NzdFVU41bXJyaTRCdWZJQ28rYWlU?=
 =?utf-8?B?YS92TERzQi9PQUxDQXZyTUdzR3RPYzdLRnRkai9TOXVaZ0VzRHRLbnRlWFp1?=
 =?utf-8?B?WnNhQkZGaHUwdjRBc1h0VFZDVU1RdjBGeFBpa1prMzg5SkRmai9oVElVaDlB?=
 =?utf-8?B?QlVMamgxTEV6ak5zcW5KeE92QUZ6VVduVTMwMXRNLzBnVkc2ZkRjOTlGYkVU?=
 =?utf-8?B?TUdGUUVWaytIeXRyajJScTVoNlk0VkxDMmZvMXJwK0tGTlcyTHZvY3FTNWpn?=
 =?utf-8?B?OEk3WlM1T3BuZU8yTndkSDlHZmlKNmgxcnM3UHVsWkIvbVdxcHJYbUNBUkFm?=
 =?utf-8?B?VzgxNmZhVWJFQTFYeUxmN0NKc1ZyUi9xeWlMZ2IvdHhobjlJdUtpRGhsc1VK?=
 =?utf-8?B?aXJySXp2YVJRdElRTFlTdFBUS25KckFHKytGUVI3RmxvYTRNM0g1OFIwM1ZT?=
 =?utf-8?B?eEJubWlNMkFkZncvMUtkVVhFb0Vwejl3M0F4Qmg0dmhpenpueEVINGRrK2Va?=
 =?utf-8?B?NjZEd0RqWnlSNHVlK1RGVXUrN05yNGhLRGJCdERucDFYVjZmdy96MmZHaits?=
 =?utf-8?B?UDc5VEJhM1M3S1MweWRJZDloWS82Y0ZCeFFoeTZybG11VkpBZWp6LzFOU3Zk?=
 =?utf-8?B?dnExanprTjludmtGbXI2Q1M4bCsxOHJEbkF0QWtQSjNVejlyejlnMm5HYzJR?=
 =?utf-8?B?WmkrZmVrVDFaTnJGWUJRQ0ZUVjh1Q2phb25CR1dwWlBDbUh1K2NBeW9aR1FH?=
 =?utf-8?B?M2hsWG9jd2habyt1dythdnZQVnIwVHN4VlZCSVkwRGluK0lnWFhBTnNTUEQ2?=
 =?utf-8?B?dW5obGtDVGJUZjhWZEM0RGtTTnJDR0FwcHY2b0xPSnB0V1FTd2hHS2J2a2hN?=
 =?utf-8?B?N2NUVFhMY3hvMmU5OHlpNFZYbzJkRER3SDdUZ2dydW9TdlJneUticGttNklX?=
 =?utf-8?B?bHZuNkpkSDd6UXU2RGhXZVd5RWNPaUNNR2V2L3pJZ2o4Mjh4WC8yRXBnMHpG?=
 =?utf-8?B?STltWDhxSUZKQmhWOUNzeFhVRTVPeW82TFhKZExIM0phT2EyRUdTdlJXV0Vh?=
 =?utf-8?B?cjFydERkb2kxdDdPNEd1aTVMRTJuZzRKbFBad1gzZ2JLby9iWC9JZXlOOStM?=
 =?utf-8?B?VitIMlFjUkJCWkxEL0FOUUhtNHFSYkVjbnliMmQ0WUFmdFVFS0E2UzF1dWRZ?=
 =?utf-8?B?SEhTNmk0Nkp1NnNyYlNhdElDaGZhQTlQOU00UERxZXRXVURsWmZ0R0dGbU85?=
 =?utf-8?B?VlFWWnpoNXZ0dmNxVXhJeTRzQU55aEhDVVJEWTZ4UTJPMVBiZmxxMTVNVU9r?=
 =?utf-8?B?OXR0eFNlZE1kTUFhSG9jRzZiZ1NzTnlRSmR3WGlWSE5NYThhV1pQZUczRzZq?=
 =?utf-8?B?UXRFQk1kUnBVbkhTYWZFVC9aMnVXbWJQVktCYythWmQwOFdIallwelRodXNF?=
 =?utf-8?B?eFpReFlqcFZQaXZCVzFTc3Z1ZVlYQWxCT3U5cVQ3OHNlaVJaZ2VYZjdSWTh5?=
 =?utf-8?B?VjFvZ3p0NjlNaC9IcjBKSDYxYTZobkNLSHB4eW9XRWREMDVZb1g5RnZsQWN4?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d662ee-00c4-41be-2185-08ddc38b2376
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:34:12.0865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh8LtHvkeKHyIm5xT0022aVuoswJB3U4nPmeHfLEHX3+nPBeiu0nfpe6fDbG9RGwkNeCyoN3oGVwRiZVzuHlZ5LzzKT01//EWq9TEDFLX6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
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

On 7/14/25 6:36 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 7/14/2025 5:38 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/10/25 6:21 PM, Jonas Karlman wrote:
>>> eMMC erase and write support on RK3528 is somewhat unreliable, sometime
>>> e.g. mmc erase and write commands will fail with an error.
>>>
>>> Use the delay line lock value for half card clock cycle, DLL_LOCK_VALUE,
>>> to set a manual xx_TAP_VALUE to fix the unreliable eMMC support.
>>>
>>> This is only enabled for RK3528, remaining SoCs still use the automatic
>>> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure manually
>>> for RK3528.
>>>

Ah, I read that too quickly!

We are just trying to make the RK3528 follow the exact same formula as 
used on other SoCs but for some reason the default isn't good enough for 
RK3528 (buggy silicon?).

>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/mmc/rockchip_sdhci.c | 28 +++++++++++++++++++++++-----
>>>    1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
>>> index 761e3619329c..f15ea7c9c6b7 100644
>>> --- a/drivers/mmc/rockchip_sdhci.c
>>> +++ b/drivers/mmc/rockchip_sdhci.c
>>> @@ -86,13 +86,19 @@
>>>    #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
>>>    #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
>>>    #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
>>> +#define DLL_TAP_VALUE_SEL		BIT(25)
>>
>> Maybe match the name for the other tap bitfields?
> 
> I went with a single define because TXCLK, RXCLK, STRBIN and CMDOUT all
> share similar fields, the xx_TAP_VALUE_SEL field is at bit 25 in all of
> the EMMC_DLL_xx regs.
> 
> Not really sure why we have multiple defines for the other fields when
> these regs mostly share similar fields.
> 
>>
>> We have DLL_TXCLK_TAPNUM_FROM_SW for example, so something like
>>
>> DLL_TAPVALUE_FROM_SW
>>
>> ?
> 
> I was switching between the field name and the function name during
> testing, and you are correct it should be the function name not the
> field name. Will change in a v2.
> 
>>
>>> +#define DLL_TAP_VALUE_OFFSET		8
>>> +#define DLL_LOCK_VALUE_MASK		0xFF
>>>    
>>> +#define DLL_LOCK_VALUE(x) \
>>> +	((((x) & DLL_LOCK_VALUE_MASK) * 2) & DLL_LOCK_VALUE_MASK)
>>
>> This seems very odd, why do we need to binary AND before and after
>> multiplying by 2? Trying to avoid an overflow somehow?
>> Also, where did you get you need to multiply by 2? The RK3588 TRM
>> doesn't seem to be hinting at that being required?
> 
>  From the field definition for the different fields:
> 
> """
> xx_TAP_VALUE_SEL[25]
> Tap value selection for receive clock/transmit clock/strobe input/command output.
> 1'b0: Tap value equals to (DLL_LOCK_VALUE*2)%256
> 1'b1: Tap value comes from software (xx_TAP_VALUE)
> 
> xx_TAP_VALUE[15:8]
> Tap value for receive clock/transmit clock/strobe input/command output.
> It denotes delay element number for receive clock/transmit clock/strobe input/command output.
> 
> DLL_LOCK[8]
> Delay line lock indication.
> 1'b0: Delay line is not locked
> 1'b1: Delay line is locked
> 
> DLL_LOCK_VALUE[7:0]
> Delay line lock value for half card clock cycle.
> It denotes the delay element number needed for delay line locked. It is valid when DLL_LOCK is high.
> """
> 
> And from 4.6.1 Clock Adjustment of RK3588 TRM:
> 
> """
> After phase detection, the clock’s precision is shown in EMMC_DLL_STATUS0[7:0] (DLL_LOCK_VALUE) based on delay element.
> We can calculate the delay element numbers requirement for transmit clock (TXCLK), receive clock (RXCLK), data strobe input (STRBIN), command output (CMDOUT), denoted as “XX” as follows:
> (1) Get tap value: if XX_TAP_VALUE_SEL=0, tap value equals to (DLL_LOCK_VALUE*2)%256; else tap value is set by software, XX_TAP_VALUE;
> (2) Get tap number: if XX_TAP_NUM_SEL=0, tap number comes from Host Controller; else tap number is set by software, XX_TAP_NUM;
> (3) Get required delay element numbers: if XX_DELAY_NUM_SEL=0, delay element number equals to tap value* tap number; else delay element number is set by software, XX_DELAY_NUM.
> """
> 
> The DLL_LOCK_VALUE at EMMC_DLL_STATUS0[7:0] is the delay line lock value
> for half card clock cycle, to get a value that can be set in
> xx_TAP_VALUE we must double it for full clock cycle.
> 

I misread the commit log and expoected that the default 
(DLL_LOCK_VALUE*2)%256) wasn't appropriate for RK3528 but it's rather 
that RK3528 doesn't use the default (DLL_LOCK_VALUE*2)%256 so we're just 
trying to replicate it so it works as for other SoCs?

I assume this only needs to be done during the configuration of the card 
and cannot vary after it? My worry being that using xx_TAP_VALUE_SEL=0 
is likely changing the tap value directly on the silicon level so if 
DLL_LOCK_VALUE changes, the actual tap value does as well, without human 
intervention. If we go for manual, then if this DLL_LOCK_VALUE changes, 
we need to update the manual xx_TAP_VALUE bitfield whenever it does. But 
I assume this is stable once the MMC speed mode and whatnot is selected 
and the clocks are stable?

Looks reasonable to me otherwise!

> Something like this is also what vendor kernel and u-boot does for all
> SoCs, at least for linux-6.1-stan-rkr5.
> 

I don't see patches for upstream Linux though, did I miss them or should 
we have some as well there?

>>
>> I believe you could also simply use
>>
>> #define DLL_LOCK_VALUE(x) FIELD_PREP((x) * 2, 0xff00)
>>
>> and avoid having to carry the mask or the offset of the bitfield in the
>> code (not tested though).
> 
> Something like following could possible work:
> 
> #define DLL_TAPVALUE_FROM_SW	BIT(25)
> #define DLL_LOCK_VALUE_FIELD	GENMASK(7, 0)
> #define DLL_LOCK_VALUE(x)	FIELD_GET(DLL_LOCK_VALUE_FIELD, (x))
> #define DLL_TAP_VALUE_FIELD	GENMASK(15, 8)
> #define DLL_TAP_VALUE(x)	FIELD_PREP(DLL_TAP_VALUE_FIELD, DLL_LOCK_VALUE((x)) * 2)
> 
> dll_tap_value = DLL_TAPVALUE_FROM_SW | DLL_TAP_VALUE(val);
> 
> If that makes it any more clear what is happening?
> 

I would actually not hide the * 2 in there, also because it could be 
actually configurable if we wanted to.

Something like

#define DLL_TAPVALUE_FROM_SW	BIT(25)
#define DLL_LOCK_VALUE_FIELD	GENMASK(7, 0)
#define DLL_LOCK_VALUE(x)	FIELD_GET(DLL_LOCK_VALUE_FIELD, (x))
#define DLL_TAP_VALUE_FIELD	GENMASK(15, 8)
#define DLL_TAP_VALUE(x)	FIELD_PREP(DLL_TAP_VALUE_FIELD, (x))

dll_tap_value = DLL_TAPVALUE_FROM_SW | DLL_TAP_VALUE(DLL_LOCK_VALUE(val) 
* 2);

instead maybe? With a comment just above stating we're replicating 4.6.1 
Clock Adjustment as if it was automatic but manually due to some bug for 
RK3528.

What do you think?

Cheers,
Quentin
