Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29CEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 08:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C538407E;
	Fri, 10 Jul 2026 10:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dJ1FbnzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AF2843B6; Fri, 10 Jul 2026 10:42:30 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AF683FF5
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 10:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GM8AUqyPOVm28kDp7oKEYK5gtPoWpg6fahHzEGFIs2HIpp0tzydSNF6rhzUW4+tPMTcYTpgkGiRuJg5ZUEcr+J3A1AQIqS+M+Ld23noCt/CzX475NweOMSu6sc/oNPUGGdbGwUCMuoWTKgNpGhrNmv8BVNjG9qXUnQgVe4us4IROoY4GYiQaYrjGQIP0Dt2bONdDkL8ektNFr/AoPe67go7zUQoaNhqG0iJZxEpesqLb/BHLqbpaPvPd0oFXx43X3HcTOQxy2D4L13H5xS8NO7zBRwtPPGoPaAyokWEmkUsdbqPu8bacAZHL9H9tBFFOeICMqWpFR7RmVdstNrWK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/bR09DSdmtIc6tPFpZngBiLRvhs11/DShZFQFWczNA=;
 b=UHTcgt+TXj+RRtpkIdiaT3cw0srt6EOx6UQEtgy5djEzzbnihsCjZwjsq5dHhkd2EaxbSZa63Nht4nSi8QtJTL8CP3wfJNQg0OX4GJnHYhrE67Z/2U9fI8YxbzXqQbC5s9NTN4dWq+k0sP0FwYxISTC74iTMefBuJ0Dd8+IoeLhBklbBIWJqMrsgTCNd2mpRjTAyNeH8DUZPXmvamzWZO0L1H6esojVBQG2gEsdaf/eUxDdMqzpeieain1VG7zokr9e/AQAXZnOS4QETogcaFOrHlK8hLQ15sEGbxWdvc/1417MbZqSIhTYrlicpbsF2MwcBcU3Mt3/+o0lLjsUWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/bR09DSdmtIc6tPFpZngBiLRvhs11/DShZFQFWczNA=;
 b=dJ1FbnzFYL+AuJibw52Pjkuk78bsZiyv+Y5klFSQI+HmebLWopcj6mm42mybEscpXITpUCuvPo9pGrIbMWBWxxLkLiybaMZi0rcmucBMuf48uKeAXNV4b57DwJ2/embKcdEqj6CbnxDEVKFLT7B0kW38PYd9ZoB7k4/V92axUx7wAAtfxDHy6pZ0lBAIv/dhvAGPacDdtZ9DSJngzA1VGIYcdSkYo8cgrcoWz6/icgIWkDm4dbCzgMWysl15782TzuEtOeJJvi3/eY8GZg+93H2PXZw7ZwV0S79q8UKcOkMJG4ufHWPlfoJ7Q9qMqycGvicPtR/el7253D2/pN7Lyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SAWPR03MB989597.namprd03.prod.outlook.com (2603:10b6:806:562::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:42:25 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:42:24 +0000
Message-ID: <23bad10e-29bb-4dc1-841e-a297b1b84f5c@altera.com>
Date: Fri, 10 Jul 2026 16:42:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga_arria10_socdk_sdmmc: migrate to
 OF_UPSTREAM
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Paul Kocialkowski <contact@paulk.fr>, Alice Guo <alice.guo@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <52fd49b46f43dce7be11c6e4e44d912c8c14e13c.1777440221.git.dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <52fd49b46f43dce7be11c6e4e44d912c8c14e13c.1777440221.git.dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SAWPR03MB989597:EE_
X-MS-Office365-Filtering-Correlation-Id: e3504d31-92f3-493d-e865-08dede5f2993
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|13003099007|56012099006|11063799006|3023799007|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Mu3193E48HnwazulJb8tuoWJELeDM1a0KKc3xzpuqAACzURBRsxp+ZEO52iG3sG58Op5xdknM0q4V7X+ez+5vxvqof9T2wLYSgDyhvpX0Y7tsZy29GXj99jOkLgz1VzkrUcbnzo8T7nAtxQToloY034i4zKTmDsSRNeG2iJgxzIhghw4ZB+20TqCG1sJxypfP17X9/7VhJeSp+B4AD/zmVfKrTE00C8efgQPNsqzxfdtddaKiYyhI/MBD4AIbtErSA1lRdj8Vlgsfn9i4VMQIZXa31IkE1PuHT3255+tKnR2IfXzwzQ+Wumt2Dw/Hka4ET0rrvdsOk+eS/FqNX8vxArqY9ZCm5TYO7x14sRXqgUWUkDH2+k5cSNM7uSxu3SNjkaN28Gwa5xWnFAuwcN9dNhz0+C+tYNwEkLM4Zbevq+HTBlgzZC+pj1iV+pTPN0vqFAjLjDp4s4QqIyZbh9kjnVisROOmcJ6bwQZPelh2g+8fHS3Jx5a7TXYs4NWQfqamSOgo4H527rcP0gjIF28gwOjuF6dFgd9TSZcgtWPBl/uXF24ypSMz71rDNleNAyllObReuC5pWQd4gwWW4ntlL7Pn6Mpn0984SENWLR0NIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(13003099007)(56012099006)(11063799006)(3023799007)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZQU2lnemxtZVVHQWtraUUwenlnQmJqTmllNXg3QnptTjZCV0wrRnQ2VHpC?=
 =?utf-8?B?U0hkaXg1RHl1bU8xclVTNzcrNndESFdPMGxFSHdENmhuNHhCQzZtSkJsR09P?=
 =?utf-8?B?Y1lLWWY3NVhKaTZyaXJTQVRyQ1BKbFJkUlcrUzNZUVhIaG5ud3pEV09MYnph?=
 =?utf-8?B?SGlGQ1pIMGJhSWZ6OGN0QjJjdEp5eXY3ZDVjY3lEWnRTOU51OTgzTTlhak9P?=
 =?utf-8?B?bUxsTkVZQ29WcnQxOHJjNUZnV0t5STByU29aSUYzUVFPOHVsalBLOWR1Nitt?=
 =?utf-8?B?RmMwbkREcktXbG5lWDlkaSt0MmtLQTN4Y1RtMkhsNitkcW51NEl5eHZoakRt?=
 =?utf-8?B?N09CaHg5RERJKzIwOENHUUt2QXRyREJFWXVTRUVlUE1GNW9DME11YTU0UGht?=
 =?utf-8?B?eUs2MWtwUU1YdHU2K1dmcXZaRWVvQUoxVHI2VTVHVzZiTktpR2xnVjBVSnUy?=
 =?utf-8?B?VGFQQkNRb2hnd2RPUmg1cHl1L29LWCtwRnFmejBBa3VEVzZ0SHFZTkpNL0Js?=
 =?utf-8?B?UEh6cXlGR3J1OC9nYnk4NS9Nd1JJUnNYV0NCTnJOY0RMTGR4eU4rRm92RlB6?=
 =?utf-8?B?bVRHYkhUc2VRMm9WUGtQZTBiTnRVQVVSNDRXS0pMYzlBcVVZZnJZWkF6K1pG?=
 =?utf-8?B?MkdtaGxCQVd0T0hFSGxldXJCYjNlMVdDWWxUbEh3ekhZTVJHY2hzSzBZN3la?=
 =?utf-8?B?QStya3BYeHB2NDJnd253VVU5TXFzOGxSS2tpRUY2SXdCNWJjbU9CQnNENCtB?=
 =?utf-8?B?a3RMaDJRV3pQQW1YcG1WUUhRRkdNWUVSQm1TKzEyWjNvc2pMWXVJczBTam5I?=
 =?utf-8?B?UTVCZFNLYkhhVFRTUVZtdVA0eHdPVzB1QWVlV2RxeGJlM0luTzJ2Z3IzdDBZ?=
 =?utf-8?B?MmZVS0cxU1RURW96bnNuc2Q5TStKRnAzNkVtRk55WEIrQmlnZU5rNitvYVF2?=
 =?utf-8?B?NTYybVV4ZXpOSkM4TW1PajRPRGNiUUpPOWw2a0pOTmxFZTlWTnJaUTVsVlJG?=
 =?utf-8?B?V0VMK1ZpeUNPeHg2VG82TGh0a2NsQktvSWM2QlVBYTdtRmo4ZUhhc3ppQ3Rh?=
 =?utf-8?B?a1B0ZGtwK1dCV2xqRWIwN3J0b05ONURDeE03Y0xKZ0xMVXpGN1VFOEVZdFJs?=
 =?utf-8?B?YlVic05JZ0NTTnpLOWhNVG5qd3U4Rm5lVHhIdHdtS09tcFhFVG92M1Q0OThD?=
 =?utf-8?B?S0dJWUZ0K3A4OG9QZ2Z6U3hLc29ybVpQOXRkSFlGOTRhdTNXNHdGM1lzQUxH?=
 =?utf-8?B?eGxvRTJZSnRoYzIvS1dNV0ZlZU1rc3U3RmZKOGU4eDE2TklkUVZUNkMyam51?=
 =?utf-8?B?SjJMMzlLQWF6WGNNVVVNWnEyeGc2bnJhM1R0eDlNcGV3Y0tHNmdyZ1R0WUNa?=
 =?utf-8?B?ZlBNYjFzNVRTTWZ4dXZ1WjYwYWQxYjdCdHpaVnY4L0pPcGlhTWZXd3hraWFO?=
 =?utf-8?B?U1JEK2pVZEVUamRmWm16azNrbDJoYWV5a0ZweHJUdEhVL0xhcXFLWXhvZGxV?=
 =?utf-8?B?NzdOdmtzdXNodjVZNGRSdmRqU1lqNlZiMzJwQ3VQM3NZNEtvVG9JdzRrYjVu?=
 =?utf-8?B?Z0gwUWdtU0JsZGNNbmNPM2NENFBhK0RKak5ibVI4VGtycXZJZkt4aWVmanV2?=
 =?utf-8?B?aUxheG1hbXF4NzNRQ3RpMEgvT1VVQmNnRS9EVFNkTG4wOHdNa2hpMlZ1MzA3?=
 =?utf-8?B?UnYvM2trSkZLcjlUUHhENGlVMUFxajUxZzE0eGZITTNWYWhoeGtpT1ZsSE92?=
 =?utf-8?B?bzY3cTdoZUVoVVdZdEJkZVBadXNYMU9reVUzdm1YMWdUeXVZb1UrdjdSUldt?=
 =?utf-8?B?MmVhSzE3K3dhcVdycmdEZlNIcmpWaEVDeWtYaWFHUUgxQWg3Wm1BSnJmQWpl?=
 =?utf-8?B?TDdMOG9rOXdJNWE4WnhwbGVkK1h3ZVFOVFBqOG9waWdMbEdOTGNTWStCYURP?=
 =?utf-8?B?M1pRbTNxbjFhcDhNSGFucDdtelhsZE4xb0dIYXdhbVIxMVR1Q0VmK1ZEQWMy?=
 =?utf-8?B?a1ZLNWhWS0hDd1NOUWc5OURCc1JJNkppK05zblFGNHNaQ1R0WFBTR0JjWFFE?=
 =?utf-8?B?eEZ2eG14UFpBeElOUWg2YzcxSEc4enZocHJER3RISlc4S3VoUzZVYk9kUzlj?=
 =?utf-8?B?L2dYdmhaYjI1SExkWnVrNTlLbmdjWG9LL3hZUUZxZi9TcEphbWtvYTZtTFJo?=
 =?utf-8?B?THFxb2dQcXRiRXkrZXUveGxsZW5iRUtxdVFEdkNQakxuREY4dGp4VTVqRmxH?=
 =?utf-8?B?eGQybitNM2I0RktuT3pkSEpiS0QrVnRmNTFGTkhXVGZrNHoxZW13SFVDMFYy?=
 =?utf-8?B?STlaVEsrUm1BVy9aUEdNT2xDQlkrK3ovbXFNYU9XUlRvc3pqUEc0dy9VQU5u?=
 =?utf-8?Q?hrjZSMT9xqMnSReY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3504d31-92f3-493d-e865-08dede5f2993
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:42:24.6605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/SjsAQRG0pNOkjBeU2qJ02flvzChkDAIZblP0E4vy5mSB9RBoj7ZV/aWli/BNi7JPKe/yaA+tUALPr31Dwq5CxGm5EIXOWm4zYfz/miOKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989597
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

Hi Dinesh,

On 29/4/2026 1:32 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Enable CONFIG_OF_UPSTREAM for the Arria 10 SoCDK SDMMC target so that
> the device tree is taken from the dts/upstream/ subtree (synchronised
> from the Linux kernel) instead of the locally-maintained copy. This
> keeps U-Boot in sync with Linux and avoids drift between the two trees.
>
> Update CONFIG_DEFAULT_DEVICE_TREE to the upstream path
> "intel/socfpga/socfpga_arria10_socdk_sdmmc".
>
> Remove the now-obsolete device tree files:
> - arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
> - arch/arm/dts/socfpga_arria10_socdk.dtsi
> and drop the corresponding entry from arch/arm/dts/Makefile.
>
> The upstream socfpga_arria10.dtsi does not provide a label on the
> "clkmgr@ffd04000" node, so reference it via its full path in
> socfpga_arria10-u-boot.dtsi to keep adding the bootph-all property.
>
> arch/arm/dts/socfpga_arria10.dtsi is intentionally kept since it is
> still consumed by the Chameleon V3 / Mercury AA1 device trees which
> have not yet been migrated to OF_UPSTREAM.
>
> Build tested with socfpga_arria10_defconfig (arm-none-eabi-).
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/dts/Makefile                        |   1 -
>   arch/arm/dts/socfpga_arria10-u-boot.dtsi     |   2 +-
>   arch/arm/dts/socfpga_arria10_socdk.dtsi      | 178 -------------------
>   arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts |  27 ---
>   configs/socfpga_arria10_defconfig            |   3 +-
>   5 files changed, 3 insertions(+), 208 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_arria10_socdk.dtsi
>   delete mode 100644 arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 4085d4c2de1..51c5b802269 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -446,7 +446,6 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_arria10_chameleonv3_270_2.dtb		\
>   	socfpga_arria10_chameleonv3_270_3.dtb		\
>   	socfpga_arria10_chameleonv3_480_2.dtb		\
> -	socfpga_arria10_socdk_sdmmc.dtb			\
>   	socfpga_cyclone5_mcvevk.dtb			\
>   	socfpga_cyclone5_is1.dtb			\
>   	socfpga_cyclone5_socdk.dtb			\
> diff --git a/arch/arm/dts/socfpga_arria10-u-boot.dtsi b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
> index 2ed532ffb54..c0ce337d72e 100644
> --- a/arch/arm/dts/socfpga_arria10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
> @@ -18,7 +18,7 @@
>   	};
>   };
>   
> -&clkmgr {
> +&{/soc/clkmgr@ffd04000} {


Path-reference override for clkmgr is fragile to upstream DT path drift
The better fix is a Linux kernel device-tree change, not a U-Boot-only hack
   Linux: add the label in kernel DT, e.g.
      clkmgr: clkmgr@ffd04000 {
   in socfpga_arria10.dtsi

acceptable; optional please follow-up with Linux owner to add upstream 
label.

>   	bootph-all;
>   
>   	clocks {
> diff --git a/arch/arm/dts/socfpga_arria10_socdk.dtsi b/arch/arm/dts/socfpga_arria10_socdk.dtsi
> deleted file mode 100644
> index 0efbeccc5cd..00000000000
> --- a/arch/arm/dts/socfpga_arria10_socdk.dtsi
> +++ /dev/null
> @@ -1,178 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2015 Altera Corporation <www.altera.com>
> - */
> -#include "socfpga_arria10.dtsi"
>
>
> [...]
>
>
> diff --git a/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
> deleted file mode 100644
> index 64dc0799f3d..00000000000
> --- a/arch/arm/dts/socfpga_arria10_socdk_sdmmc.dts
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2014-2015 Altera Corporation <www.altera.com>
> - */
> -
> -/dts-v1/;
> -#include "socfpga_arria10_socdk.dtsi"
> -
> -&mmc {
> -	status = "okay";
> -	cap-sd-highspeed;
> -	cap-mmc-highspeed;
> -	broken-cd;
> -	bus-width = <4>;
> -};
> -
> -&eccmgr {
> -	sdmmca-ecc@ff8c2c00 {
> -		compatible = "altr,socfpga-sdmmc-ecc";
> -		reg = <0xff8c2c00 0x400>;
> -		altr,ecc-parent = <&mmc>;
> -		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
> -			     <47 IRQ_TYPE_LEVEL_HIGH>,
> -			     <16 IRQ_TYPE_LEVEL_HIGH>,
> -			     <48 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -};
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..17169472462 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -7,7 +7,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xffe2b000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_ENV_OFFSET=0x4400
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_socdk_sdmmc"
> +CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga/socfpga_arria10_socdk_sdmmc"


CONFIG_DEFAULT_DEVICE_TREE changed to 
"intel/socfpga/socfpga_arria10_socdk_sdmmc" while 
CONFIG_DEFAULT_FDT_FILE="socfpga_arria10_socdk_sdmmc.dtb" is unchanged

Can drop this as socfpga_agilex_defconfig OF_UPSTREAM migration omits 
DEFAULT_FDT_FILE entirely.


Best regards,
Tien Fong

