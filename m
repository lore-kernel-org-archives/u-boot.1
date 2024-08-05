Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E1C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 10:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1246787D10;
	Mon,  5 Aug 2024 12:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F0TKNkWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A3688247; Mon,  5 Aug 2024 12:23:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4848587C38
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 12:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySHK3tEACGsmWrg4e50Cc5di1glRO5TBWnKjCf4Rvike1jWDEjJna8Rq53vOBu+QMGNRtXaMBB7BgF1IMR/0ohgTh/C8m8dMfAOruCsWeeE23RGSAviRN3l/F9+tihiwk0xx+MVYsAzsnAZma7Ja9PS/I+5zqQGGfGq8Drk0lz3e6/EZDXh0tFaYrlAicGw1sg42tpBIVL9nXdfDgISQyYNkZo/EwO7yey7RwIToq4m1jCmhCrX/1WWgILbypdkw7oEF19DWpGs9HDyTvZo3l0CLwZLnMQ/5uDJQryBTK678qxIackHp96CJVDZ1dB07pdyEZhdTGmXAldnJen8oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BuNyFBK+MU8jUjJ4CMMxM2G2uaoygENeegH9gBg88I=;
 b=zHAx6lKOVAnxHLzBNWBnFGsSDbXR653BhAwQj/oFkDFG4RxmGtKnGE4U2rsqyAtCMuu+cMkL491bAnRO5bZWRzdPePbMScyxU80xoix5eN7KqhjrSngSQmTNVwI/Ibt3FTGdLwOzZQg3wU6S4zFj3iHPFo/w58wHSe/gRN6lBHCZyWlqf93EveymHRt/IAqGVSVdIMoqYUk586e9MDA8xi/9WJb8AREH9ZL1I5fpcImiuyPeYfp6WBaxYSZQ7CE6TxYZnlEDwPhUHcRTgOsPAshybfFVQBdn+hhUSCyFB/E86rIqnOScYp7xzUy8J9mISIB//OWJxgjc/9k6fJvM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BuNyFBK+MU8jUjJ4CMMxM2G2uaoygENeegH9gBg88I=;
 b=F0TKNkWKBh+74HBW5kOroT/lG+Jf89V9see3v5ndqtqGSeQJgGxWyXZimW4dtS6s0K99LmLauouifAHuDmpw1UVHUjJn74Wl5sVtxDoz7ZNSpR3FQ8MIYdrrIo040IkHUvMCegF+ZWoxK9GA3TZljJoCr09ejf9qzgFs47FVpJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 5 Aug
 2024 10:23:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.020; Mon, 5 Aug 2024
 10:23:42 +0000
Message-ID: <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
Date: Mon, 5 Aug 2024 12:23:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de
References: <20240805084350.3895788-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240805084350.3895788-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf71cc9-6abb-4a72-4cb5-08dcb538ae4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUJyUWRoUXBXRkFnSnl2bDJ2VVE4QlliMEo1QU1adS9aMTU1cTY1UWJEY2RB?=
 =?utf-8?B?RXM3S0hXMmN5TXZ4amR6OGU0d0ZBNFBFbklTVENZc3dxcWtEUFdqK0o3YWhE?=
 =?utf-8?B?eGJIZmVGQ2FTY0p6OGxlTXpFeGZkWVpObmdHbGZ4QWE2c05EdE9xbFJTNk9O?=
 =?utf-8?B?czZGYWwxdE9VNjBod1h2bW9zMmpPc3RxVmJaOHgyb3c4aHlEekFGRzZvMWxG?=
 =?utf-8?B?cVNKRVZTaWgzMktOQmlUcG9yRFprZFZNa2lPdUF6K1l6Mmp2MDRLbEt3blBp?=
 =?utf-8?B?MXdyQStMU3lFTi9JTGhZWDVDQVRKNHMxYlhNOTk4WDRxUGFQcjZxQUJIcDY3?=
 =?utf-8?B?NE1ma1NSeFRVQlNUdVcya3lEYlpxYmJzWDhVWmhBRENsWjFoTUx5bGJTd2hp?=
 =?utf-8?B?amkvYzZCZzVuMW83Slg2bXN4d1pyYk5FYWx4c29RWWxpMHRHVWZPWndHMGdF?=
 =?utf-8?B?Z2R2bXJ2SmNSQXNDL1ZQK3c1VjhyRkg5bHh6L1lmM20veVJLd2VMaDlFSTR0?=
 =?utf-8?B?dW0ydHVhVE5yN0R0WkswRXJxUjBnZmg5ZEV4MDZKclkvQ2F5dDVDU3hVaDg5?=
 =?utf-8?B?QkN0Wm5CZTJUWE85Wkhib1llYTdtczRveVF6Vml6SGdidlM5T3Y2WnMxaFJJ?=
 =?utf-8?B?WlBmbXMzLzhWdFNWZXlJVXBRMEdkdlFFU1ZPZHh0c1BZOTV0MlZBdnRTcUN2?=
 =?utf-8?B?azlrY3FxYWlLcXZWYnVrNHlvbllNQlpJYjk0ZnIwVmE4TGlqV2RTWEUwQVhh?=
 =?utf-8?B?Rkliank1OHQ4QmhpMC9yTVlFaTlrYnArZWdPYWFsODdWdlpYQVZyRHNGLzY0?=
 =?utf-8?B?d2hZdDM5ckpLWERuZ0xiek5lRHVOaG5KcHo0UW5qdXRHa24rNFlkcWxrUWUy?=
 =?utf-8?B?ditHb09ZbnpFSGxlN3k2RC9xZUNzMTJKYmwyMXJBbVp3SEFXZGszamlXcU81?=
 =?utf-8?B?VFQ3MHVsUlkwZnJQQzIwaDA5VWNrdzRzcTlkRWJjL3RDWnBEeUtURVZJZy9S?=
 =?utf-8?B?Ym9zemZjeVRieWVKdTY5QjZ4VXRBV2hUdml0NStRdi9ab1Jna1RUN1hTL1F4?=
 =?utf-8?B?QXpTZk1CSjVycVpOdjRwWHRRWnVFQnNXQloxcWw2M2taQ0h6WjVUbloxWE16?=
 =?utf-8?B?MmRmaEhaYktodFpTaEkzcjVUN0k5NFMydUROeGJKTmkyRlcvUk8xb294NU16?=
 =?utf-8?B?ZFZFQVNjTmUyellkSWVJL1dWeGdHd0d4TnNDM3ZLUEhNZ2k0MW9jVmFIRmc2?=
 =?utf-8?B?WGJ0MjlkcDFhOGswNHFEYmpjL0JYU2t4U1RrK3hHdjVQWExXOWhGNVR0WE1F?=
 =?utf-8?B?SS8xcWNUN3JyeHpldm16Ymc5UC9LeU9vVGNhTURXOWttM3I5K0x6UE1BZ0RH?=
 =?utf-8?B?eGoydFlRWFdQK1p6L0ZaSkhpQVdtWDhvaURBTTRtK0NzZkVPRlVDazBaa0Zn?=
 =?utf-8?B?L29wOFpya29FUmF6eFFwYVRhc0FlaEtTT1ZmUDAvSWN6QnI0dFQxMmxNazlC?=
 =?utf-8?B?RFduVGxyMDlMU3RBRWxkTU9XZzgrVHBOSlZoS1Mvblc5TDR1RWxDVWlieEsz?=
 =?utf-8?B?NzJKUHV0M3dVSHkwSVVQZGUyQnlRQkZxVFVzdHdQZTJ1MUkxdFdnd0ZsZmxn?=
 =?utf-8?B?Rnh2d1A3Y204NVJkcXBFWkdsM05EcGUvMk5ucEoyZGpwMlQxTnlqWEIxbFpW?=
 =?utf-8?B?VVBOWDAzQk9XbDFXRmcwV0JKVVJtRXhGekhPZ25VcU5FTUZtUHBveStkR0RC?=
 =?utf-8?B?VXhqTmhwcWdGaHp4S3VaUHB2SktsZXlCYm4xeEE0RnhQckNwRmhDOTJaOEgx?=
 =?utf-8?B?bDR4U21PNWxpM1NiNGtLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smo5OHdueWhOSXhLeHRrV1VnaDhWTmg3K0dMTDQrQjFmODFKTlZLVm43QTU4?=
 =?utf-8?B?ZzVSWVgxUDkrUlBuejNEaEt6UXZiV1lITzZEUVhLb21Fd01NalVCbkl0ZmF4?=
 =?utf-8?B?dEUvOWRreDE1R0x5cVFQdWg2ZXNSd04vV1FtV2ErblNDNTNoSi9qa0FTRjht?=
 =?utf-8?B?YVY1TGtmVEZmY0xISjVIOE9BS2hJbCtic0twdU5XSVR6alpvNzR6aUYzMklJ?=
 =?utf-8?B?TkhZQjlYTHROOUJCeGppZlFMbVgrNE44Z3pRRjNBWmluZUFDZzlqQjBqT0RI?=
 =?utf-8?B?bC9ncWE0R3lqOTFCWFJsWjZhL1JwV01pRS9vOS9nMmUrUFYrY2RwZmVoSURX?=
 =?utf-8?B?b2ZrM0FMNTlCUFI4bUdaelpEdHpsdEhENjNBTmRPeFhnVGZkM2s1RWlySkNp?=
 =?utf-8?B?MWdlcC9JMlRlUFhaZm1GWFl6b3RTK3ZkOTRFZ0RQQ2hjNTc3cXdKWnpTSkxx?=
 =?utf-8?B?Nk9DYitHMG9lVGp2YnRaTkxEaUxZdGkzcFE1SUErRWVDSENGY3FsU2J3U2cy?=
 =?utf-8?B?WkNzQjEzMFJMb3M0cFBNRTlxUWhGQUVYZ1ZWUnJlbnZoTlEzZGdlR3VBZzFC?=
 =?utf-8?B?SVJrQldld3NvVWJmVGR2bVJhZ2JHeWIyMGJ6OVVQZlpJZWtDUlBsTkVDZk9h?=
 =?utf-8?B?YjVzQ1VHK2k4OW4yTWw2R09qSklvaDMwdG12ZnEwZlN6OW9BS3BkVUlyYlNh?=
 =?utf-8?B?aVR0Q0NZaWlQd3BUYTlsQlJsVklMWHduVTlZYUQzbGhGT2RvSTJyMHpjdGRv?=
 =?utf-8?B?TVBRbG1McWtLbWdNdFp6aWpiR3drSmVMdllrdW44VU9pdkhTbmduaEl6M3U4?=
 =?utf-8?B?d0hvdGhCM25mZzhTdW96OXI4ZldJRDZsOW91S1lzcGhFN0twZkczdk1nWUtJ?=
 =?utf-8?B?L0lwTjFwU2JxR2Z2ampFeW1xNzZ3UEg0MDROY3IvTEdta2hqR3BsRFZzM3BF?=
 =?utf-8?B?YmZsUUJ0alpacGxtUVJndHFLOTlOSWF3bVZNQlpmWnBLTlVkd3dXSHkvSXc5?=
 =?utf-8?B?TEtSR2VXdjB4T29PMVQ2Nkg0c3RzaVVHUTlKSnlhVGRXa3IxTzhVK21EdkV4?=
 =?utf-8?B?M3dMbzl0VGZMZ2dsZHNGYlZqY2RTRGxJS05waEdFamUwWVV5bmpNMTJ1Nm54?=
 =?utf-8?B?WkdLOVh5RnM0RVRmTjdTZzRIdVFwT0xzeEkxNU12emRMSkZpbUZkd0J1cFNM?=
 =?utf-8?B?NTgzdEFaUm5iZ1M4SGlzTWVRbzJoYnh1bDh2eFdZSEJhbDdhVXJRT3BYUWNQ?=
 =?utf-8?B?c3p5cml0M05XaERiNTFwVVR5MTdDM1FhTTQ3b0pKMXFnT0J6ZVlWSjRvQWgw?=
 =?utf-8?B?NzJnOXE0eFhtN1FyQ2N6WnREZWVnYVFQbkxxRnpKU3dCZ3ovb1VNaGx2YzV1?=
 =?utf-8?B?MEpqNjg5blFKSDRlaHpwdXZ6RVJSeUsxbC9DbUNpS2k0TTROVUJuU0lYdDlD?=
 =?utf-8?B?aWFmQ2x5YjUvZ09POWYrYW5UZEIrL0xuVnUrUzJqa2I5ako1alY3dTJzd2hG?=
 =?utf-8?B?MkltL3N4dmZKSW5uNVRvYVhtcXhFc3QyWFpNTmRqczMxS1ZaeUZKa3lKdGMw?=
 =?utf-8?B?WkYyWXVxSzNUbjFLaVR6ZHZMY1BQay8zSVExcUFDS1dmMHJlV05nK1YyUnN1?=
 =?utf-8?B?cVpwaUtsZXJ0Mys3eERZdkdDMG9WMkZUT0RFL1d5dHJ0a0Z6MVorNGRPQXB0?=
 =?utf-8?B?QSsvZUpjVTNEZjZtL2dVZFFYMzAzelpYNTRLZlNqVktaa3J2QnVzWS9BV1Az?=
 =?utf-8?B?N0RlbytOdjZuNS8yQWlJMmdVcGpDS25xRS8xTDFMV2RXUDVWQU1HYkpnNHlO?=
 =?utf-8?B?OVd0NllaQ052blBVNmZxd1hvMXdjc2lUdlhHNnZDazVtQlBsdTZtL1hMVkt1?=
 =?utf-8?B?a1RIeTdubzdxVHlhcjJWQjI5Ykc4TzNuNjA0bE02bEpxc1dGNWs4U0h5WDdi?=
 =?utf-8?B?UWRDZmJzMnB3SDVhWGIvdTVCMkxnclFpTUIvMnZrd3BIMkhQbUtSSG1XbUxW?=
 =?utf-8?B?cTNOY0tNaWp6Z2ZBd2RFRnFFRnRNV3htQjhlY3VJRUZ0cEFNN2lCQ3RNUS9M?=
 =?utf-8?B?NzNGRURNVjNRV0ozNnJ4Vkk3VkluY2xRUmx0a1R2dmNNRGJrU2N5ekMzZFJQ?=
 =?utf-8?B?TWovMjFiVXZqYUJiYnF1cWJ4RnVWRVhMNm40bEFGdURSQ09MZ3lNN0xxOGYr?=
 =?utf-8?Q?okOk19of5tkwYxMYIIu2W38=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf71cc9-6abb-4a72-4cb5-08dcb538ae4c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 10:23:42.7651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hugQKJlCob/Hby0nI2pINvd3+gKHb9rvLLsY00xi8BKWY9QQ9cjmWiXx1SanJJ1RztBaCV/z2rJ6IeT2ixoxpVXvaYICN3HnABjP/B/O2p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
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

On 8/5/24 10:43 AM, Jonas Karlman wrote:
> UART pinctrl for serial is typically applied multiple times:
> - in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
> - in SPL for DEBUG_UART in board_debug_uart_init()
> - in SPL using pinctrl from DT
> - in pre-reloc phase using pinctrl from DT
> - after relocation using pinctrl from DT
> 
> This series change bootph props for the UART pinctrl to not include them
> in pre-reloc phase to save some boot time:
> 

NACK. I feel like this is a hack for vendor trees only.

1) The Device Tree represents the hardware. We need the mux at all times.
2) This breaks users who want to have no serial in TPL/SPL but in proper 
(where you want it as soon as possible I assume, thus pre-reloc).
3) This likely also means if BL31 is configured to output on a different 
UART mux of the same controller for some reason (I've seen weird stuff), 
now U-Boot proper pre-reloc will not output anything as well.

Adding Lukasz in Cc who's trying to fix U-Boot so that this is possible 
on PX30 (therefore, not just a theoretical use case I'm bringing up ;) ).

> - Radxa ROCK Pi S (RK3308): ~80 ms
> - Radxa ZERO 3W (RK3566): ~120 ms
> - Radxa ROCK 5B (RK3588): ~150 ms
> 
> Similar change has already been applied for RK3328 and RK3399 boards.
> 

Then I believe this was a mistake.

> The change for PX30 has not been runtime tested, and only include change
> for uart2, not uart0 and uart5 used on two of the supported px30 boards.
> 

This means we have uart2 pinctrl at all stages even though we make no 
use of it?

I'm starting to wonder if this optimization isn't orthogonal to having 
as much support as possible via an <soc>-u-boot.dtsi which was done to 
make bring-up and maintenance easier. If you're really after 
optimization AND we keep the pinctrl for the debug uart (thus, not 
breaking 2) above), then what we want is cleaning up the default 
px30-u-boot.dtsi and move bootph properties to the board DTS instead?

I was a bit against this "turn-key" solution wrt u-boot DT for 
rk3568/rk3588 but we went ahead, are we changing our mind now? Just to 
know what exactly is the direction we are planning to take.

Cheers,
Quentin
