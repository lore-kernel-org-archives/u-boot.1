Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20073FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 06:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7335584687;
	Tue,  5 May 2026 08:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Jw7Wlh2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8D7846A1; Tue,  5 May 2026 08:54:35 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8C384683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UILXj/kQfmnpz+wNv9xfwPR517oN5VGl3036kC5dY7tmwj4PwFo7qqTPZrtPoXjqx2bSvSPlZqeEjK2LQncVlcoo6CzhRz9q2aa5WX5ZYOZsP8WTWddUBU3LhtTeKmfOl+OAbHZCfNSzGYOw3S7aReWKPyIuFpnSKQV3Ji8VowdLJnp2unYKY7tpD7U1u7crDV1q3BlCzBKW5RTkyIdHB5uDiT8TAFXlTNW3hhT6W9OG9opegPL+hpKW7uRPIL0kTtYE6073yC8QY6fGYDyDEZHi3r6RJxL4NfPHlknV0ShKrX0Ak8li3Zj0LyjOegcHveGDgAarFSU3GLcgyFXS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaFLhBN9bnUVnxs5BTjMaXVr+DG7CdwbkamUEi57Scw=;
 b=mNUGjA4weBIQ9d++jRM1Z30u4+6g5aJPmpr9YSrM0O3YkSn2W0OeP72a/Y1FkHYcFuXDYRqNtS+nc8suWPzDMMb/OUSw6qH973c+w4V16wDWGCV0szs5TG7i9ZkFoTJquQYgtuBz26L7YFDfxEE26/rQ6Z8n0kSblml1PzhDntbr3IIJWW0YOYtYo4S0gWc9QujkV7rJ+AO3BTYwObp4TfZpg62mihFmQfHWgQaA7r/r90W84208arX9wXGDWjjh7GG83IhCjuBzv/AlFhDUO8os0cY+0XZTSFtMttJN65+Vlaq7OkbQBAKNmkGXUJDuRmPxrEUnST3/mrA3iLY4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaFLhBN9bnUVnxs5BTjMaXVr+DG7CdwbkamUEi57Scw=;
 b=Jw7Wlh2V2gyl+07HnScKBkKnB0fT+22Hs+GfjacB2m+2iZEuBEKOn+VV3c1AUvJDgQ0PL8RLkPb2nEzAG7Jxv/udnGMpJ/5UouLvOYyMxfNgFiw8J0AEVxfVkHhgTM4CvPq74m2AB90aSF0SUtM2SnxO8qI1fpcdZjMTm52lo/immoukw1PFVds6aI7iy7io0fOvE+aWTC/gneuW/Psnd5LL2J1MWLAIuDkwB8tNoXoQ/sK7As9hukeRyliOuKpTEJD9kU6+mRtwSDSmHOs1ycV6pJc59NqbJ3ZSlswS7FkIdWOoUt5bPvgrn33bmgSKXHNqQgpFKxjD1PGQFJtQZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB4984.namprd03.prod.outlook.com (2603:10b6:a03:1ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:54:29 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:54:28 +0000
Message-ID: <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
Date: Tue, 5 May 2026 14:54:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 0feb8e37-e0b7-430e-74aa-08deaa732629
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xzhFZZfU+jJLAyRjiPEeLGCGyQikYx3faUkBlz0KpizQrL2wIhrhD2DGblW4/A57g7QRaNPwHl1GyQvpndUM7773uswZFsThCauk1kaNzYEXm12tLqjx/k8XLS4syd1ekNcRb0bzSfyEPItoJzPg0sVwliJZnKw+l5031zqN3mipUXcNxVFOfdgEO17SBxSG7cnWCoS/BME0ur3U1WKK97WsP2tUxyZD+kDpQJf8b5rYLruLDXCKuZyZrl/Byb7I//GLIYx8yhRsIUUAfxkLwahHhx4YsoYiJ6aKAq227Fts0JDBry3CMX1g3aCf2+BVwet6yVtP0XpZ73dLgpC3T9q2f/Rx/4FK87ZGUE2TJsQRDuFUGlgNDKUrD+9NWF7vBbJLF36QUcUWp5wAhlbgMuFkx1boid9lMGl5kfkp9asLGrn4yL6/951o1MJwSy2me91gLZ9J39g5koqm3rfMbNI1VRSRg7egBuq1Izc96gN9sl3LeKwxtkcMjybkcOMG9J5tF5xdJ7nn+iMidTj4/FEVL9ACA9DxviAeqe3qx1yaHmRnKXZEi5/5QBjPMpyLmKjjj6tBSJk+y5DNL51XudGJqPD/kqqd/g5WWZnJhjtbQr0DI/N62o+QtMZBTQQWSmTia8YjcTqG6vsJNbyEFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZ6bjVjS3lTSGVHZzZJcHAzSU1KdjhZQy9JeXpFQzhETGt5cjFLbHEvbTkz?=
 =?utf-8?B?L01LS0pHdExPd2hvSEZSNXpTMGFOOFBacHZQRTQ2YzdYbEY0d09wWGpXTWpM?=
 =?utf-8?B?dkxjUzVhdExqRkxxWDdBN0NsOTJMdzRlNEVuZXJTU3VSRGdwaERDL3JrNDAv?=
 =?utf-8?B?aE5PeGVkeXVGYVJGeXRRYmdhTVgrNVpEL1gwWllKNDlUcmI3cXJsRGNPK3V2?=
 =?utf-8?B?Rk9TRi9QWVp3UUZTRjdiNi9hT3c4RTU0NGxZbG5FYm03cHdpR1lmdFF3bEJv?=
 =?utf-8?B?aUxuTHJpMzhpalllWG4yWkNxU3BPNCtNdzhZU1QrWjI2M2hIL2JHc3FkWE5h?=
 =?utf-8?B?ODcrdWNtbU1HUnQxdEhEVWRZRlg5eExkNlF2TXJDK0lWWlBXdHcyTWV1dzNw?=
 =?utf-8?B?QVovVllZeWpjYS9tWHlEMzBmNVpDZW9hVVRwKzRITTJSVEF3eDF1UXRXRlNq?=
 =?utf-8?B?bGR6NkZFZGh3dXg0eENBV3RJaHVrSUR5NGhqYnNKTkpTTklabHgxZTFKYWlL?=
 =?utf-8?B?dGZRR3RMS0QxUTBlWUhEd2QzLzNhVVVQY3YvekhhZ001Q2FDWXc0VDlRVmJN?=
 =?utf-8?B?ZjVvVmhTMm4xV2xFQ2xQbDRhZG01Q1JhZHZ0RDQxd2pHRTA1NmNHaG5BS0d3?=
 =?utf-8?B?dXhnZzgvR0x0YnZEL0JsSm83Q2tLVUVpbnFlRTdLbmd0aFZLakhVZGRieE5x?=
 =?utf-8?B?dlpub2sxUHNFRmZyYm1wbS83VHF0b0FiUjVPM20rOWNHSDJ5aUhwak1rQmZn?=
 =?utf-8?B?bXBuNEllemxJR3dwQ3ZSVDRhMUExeWhFdTh1amk4ZFp0aGpJekxkTTFZUEVq?=
 =?utf-8?B?Sjk2TVcvUUttb1kvcGQwWXpUMFg0c09Pa1hPOXhucVVBTHJrTFoxTE5GeUxU?=
 =?utf-8?B?bHdIVjYycDc5eHRqb0ZEZGlaV3BIVHJMRkZVVng3MHQvckVxdGxjRjZBaHYx?=
 =?utf-8?B?bFQwV3p5WmpxUGZITG0zSi9lQ0wvdGhGK0FRNXpxbmxUYVNzOUhWampIVHhD?=
 =?utf-8?B?K1ZuSFJKRFpOWHdFdCtrMmlhVFZhTVNZQkM4MndXN0Z6K0VRa2hxbnhzOUFL?=
 =?utf-8?B?K2tFdkNaYWdvSkFXeXFOdUFGVEM3YjhGZVc1Ty9CckJHYzNRUmlCZ3h1L2lk?=
 =?utf-8?B?ZEVxaHJYL09WbWxtMmNPRmNxQ3lWNG9CRnRRMnpRMzBTUHpOMXJueE0ySkhI?=
 =?utf-8?B?bE44QW0xL3YwR2d2WmdpUGJ3YnAxRTYwc05kTDN0NnJ2ZWJzSEVVQUVWV0lq?=
 =?utf-8?B?Q1Z2bVEybXdwbmFBdkVnOW12QTY4aEtxUmNENDAwRkFkMWl5WG9sZGxLZ1pl?=
 =?utf-8?B?K0hIcnAwbzZNaTV5UkwzcnhXS0lCVzgyRFdkQVZqa1Vyek1ML2pvV3BwT2Mx?=
 =?utf-8?B?dXNaYWtBK0swMVN3TGFSZTdKanh1ZmJSQUFrL2pTOWk3eHZPZG12RWRDKzVo?=
 =?utf-8?B?WkFGTDRVWnZCekFOVUFLQXZXV0lkRHVjb3B3bFBVQy9UNDBWbHVPdEc0d1Nw?=
 =?utf-8?B?OU1lZENrekJ5VUY2b0piMGp2ek1lRVRicCtoenMyNnZMSDJ6RHdEbzFjdjdv?=
 =?utf-8?B?L0xuY1FJNll2T0tqbEpsMmRnV1BKNmxHcEhKYWMwVHQwVWxKaXByTDBoTk1N?=
 =?utf-8?B?b1VXSDdTdkxsNXdJeVhIWjMvRXA2R1RYVEYwVWVPYjV0cHdzNUd3SnFIaG5j?=
 =?utf-8?B?THR5N25xV1cvYlNGRjVlTUpTejU3OXRvRWlTWEt3SEpIRGtXR0VJcWVQZHVG?=
 =?utf-8?B?ZWJXc0dta1ZXN1VoeXJtZzBsU1hkWnV4L0x0eDZHN3IyUnNOVjFmMmlZTzdC?=
 =?utf-8?B?VnF3QjBTUkRSOGx4dUZ4K0VUWllDYkRoU3RNV1BmMCtIMkdNYUo5Z3BETTlN?=
 =?utf-8?B?Vm16MFpyaTZKSCtsQUdwSEIwd0JDOGlDS2lvVWNZS0pmM1FlT25adzZCVmtp?=
 =?utf-8?B?cVBFbWlUT1JJcDh0RWJCbXFUdG1VZlVjY290VXMvdi9yR3FsaHlYR1MyZzJQ?=
 =?utf-8?B?KzVCRmJOMENTcFJyaDFFUEU1OExQYXJ2eUNTU0NnRHl5bzlyNUNqTE1xSmZa?=
 =?utf-8?B?UXphUEkyL2dqN0srYXYyUURhZFY0Zy9UdmgzY3dyQUpSekloV3RzUzBSYThh?=
 =?utf-8?B?b2JyKzA4SndTQ3cvUWFjRFpSbnhCSHBEamRkWjA5eStCUWtZYW5jME5RbjFL?=
 =?utf-8?B?cmtzMjJ1ZjAvTTR0eHRYaHBZOHhNUjk2QTRneGdrSmxYVEU1VFlRZ2owYjRW?=
 =?utf-8?B?MjlZZFY1Qkpyd0VxUjJaR0JlNHFaUzRtQjltYjJ4ZHEvaTBvNHF4WWJYcHk1?=
 =?utf-8?B?Z1RMRjZUeDV3M3NVZkloQzdqbWZPSGRCdTJsMlQyUWpocUYwU1BlelUzVkNw?=
 =?utf-8?Q?7nrUVZ5S248Af6aI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feb8e37-e0b7-430e-74aa-08deaa732629
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:54:27.9162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHYsSuzFo2cvBX+PjB3xSAhdsEakvZp2GF+P294GQCpsEdZiCWe7srhpXDrqanJ2gmlgqBrDe0JtgMWzWAR59fmEH48TlKVivOcpVKBnohA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4984
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

Hi Alif,


On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
> case.
>
> This implementation turns the caches on temporarily, then overwrites the
> whole RAM with zeroes, flushes the caches and turns them off again.
> This provides satisfactory performance.
>
> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
> Preparation for Gen5 uses the same memory initialization function as
> Arria10.
>
> New Kconfig is introduced to enable this implementation only on the default
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig      | 13 ++++-
>   arch/arm/mach-socfpga/spl_a10.c    |  4 ++
>   arch/arm/mach-socfpga/spl_gen5.c   | 17 ++++++
>   drivers/ddr/altera/Makefile        |  4 +-
>   drivers/ddr/altera/sdram_arria10.c | 34 +++++-------
>   drivers/ddr/altera/sdram_gen5.c    | 41 ++++++++++++--
>   drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>   8 files changed, 187 insertions(+), 26 deletions(-)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index 830585a72cc..dd71691b724 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
>   config NR_DRAM_BANKS
>   	default 1
>   
> +config SOCFPGA_ECC_SUPPORT
> +	bool "Enable ECC support for DRAM"
> +	help
> +	 Adds CPU-based ECC support for DRAM at boot. This will initialize
> +	 all DRAM ECC metadata to zero, preventing false ECC errors and
> +	 improving reliability.
> +
>   config SOCFPGA_DRAM_SIZE_CHECK
>   	bool "Enable DRAM size checking for safety"
>   	help
> @@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
>   	select ETH_DESIGNWARE_SOCFPGA
>   	imply FPGA_SOCFPGA
>   	imply SPL_USE_TINY_PRINTF
> +	select SOCFPGA_ECC_SUPPORT
>   
>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   	bool "Always reprogram Arria 10 FPGA"
> @@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   config ARCH_SOCFPGA_CYCLONE5
>   	bool
>   	select ARCH_SOCFPGA_GEN5
> +	select SOCFPGA_ECC_SUPPORT if \
> +	  !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
> +	  && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>   	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
>   	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
>   	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
> @@ -124,7 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>   config ARCH_SOCFPGA_GEN5
>   	bool
>   	select SPL_ALTERA_SDRAM
> -	select SPL_CACHE if SPL
> +	select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>   	imply FPGA_SOCFPGA
>   	imply SPL_SIZE_LIMIT_SUBTRACT_GD
>   	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c20376f7f8e..4d0696bbaf6 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -25,6 +25,7 @@
>   #include <asm/sections.h>
>   #include <fdtdec.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   #include <asm/arch/pinmux.h>
>   #include <asm/arch/fpga_manager.h>
>   #include <mmc.h>
> @@ -265,6 +266,9 @@ void board_init_f(ulong dummy)
>   	/* Configure the clock based on handoff */
>   	cm_basic_init(gd->fdt_blob);
>   
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   #ifdef CONFIG_HW_WATCHDOG
>   	/* release osc1 watchdog timer 0 from reset */
>   	socfpga_reset_deassert_osc1wd0();


Why not remove this?


> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index 08b756db2ca..530863b1564 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -6,6 +6,7 @@
>   #include <hang.h>
>   #include <init.h>
>   #include <log.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/utils.h>
>   #include <image.h>
> @@ -21,9 +22,17 @@
>   #include <debug_uart.h>
>   #include <fdtdec.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   #include <linux/bitops.h>
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +static struct bd_info bdata __attribute__ ((section(".data")));
> +#endif
> +
>   u32 spl_boot_device(void)
>   {
>   	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
> @@ -106,6 +115,9 @@ void board_init_f(ulong dummy)
>   	if (cm_basic_init(cm_default_cfg))
>   		hang();
>   
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   	/* Enable bootrom to configure IOs. */
>   	sysmgr_config_warmrstcfgio(1);
>   
> @@ -143,6 +155,11 @@ void board_init_f(ulong dummy)
>   	/* enable console uart printing */
>   	preloader_console_init();
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +	gd->bd = &bdata;
> +#endif
> +
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret) {
>   		debug("DRAM init failed: %d\n", ret);
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> index 8259ab04a7e..ece6a131897 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -7,8 +7,8 @@
>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>   
>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> -obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
> -obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>   obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
> index c281f711fdf..09d3526603e 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -22,9 +22,13 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include "sdram_soc32.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +#define PGTABLE_OFF	0x4000


Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it


> +
>   static void sdram_mmr_init(void);
>   static u64 sdram_size_calc(void);
>   
> @@ -193,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>   		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>   }
>   
> -/* Initialize SDRAM ECC bits to avoid false DBE */
> -static void sdram_init_ecc_bits(u32 size)
> -{
> -	icache_enable();
> -
> -	memset(0, 0, 0x8000);
> -	gd->arch.tlb_addr = 0x4000;
> -	gd->arch.tlb_size = PGTABLE_SIZE;
> -
> -	dcache_enable();
> -
> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -	memset((void *)0x8000, 0, size - 0x8000);
> -	flush_dcache_all();
> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> -	dcache_disable();
> -}
> -
>   /* Function to startup the SDRAM*/
>   static int sdram_startup(void)
>   {
> @@ -735,8 +721,16 @@ int ddr_calibration_sequence(void)
>   	if (of_sdram_firewall_setup(gd->fdt_blob))
>   		puts("FW: Error Configuring Firewall\n");
>   
> -	if (sdram_is_ecc_enabled())
> -		sdram_init_ecc_bits(gd->ram_size);
> +	if (sdram_is_ecc_enabled()) {
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +		sdram_init_ecc_bits();
> +	}
> +#else
> +		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
> +		puts("ECC is enabled.\n");
> +		hang();
> +	}
> +#endif


  confusing pattern, moves the } outside the preprocessor block entirely 
to here


>   
>   	sdram_size_check();
>   
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 1c3c70ea8ae..76effb264e2 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright Altera Corporation (C) 2014-2015
>    */
> +#include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> @@ -19,8 +20,11 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
> -
> +#include <linux/sizes.h>
>   #include "sequencer.h"
> +#include "sdram_soc32.h"
> +
> +#define PGTABLE_OFF	0x4000


Dead code, remove PGTABLE_OFF, only sdram_soc32.c uses it


>   
>   #ifdef CONFIG_XPL_BUILD
>   
> @@ -566,6 +570,19 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>   	return temp;
>   }
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +	return !!(readl(&sdr_ctrl->ctrl_cfg) &
> +		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
> +}
> +#else
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +    return 0;


4 spaces (WRONG, should be \t)

ERROR: code indent should use tabs where possible from checkpatch


> +}
> +#endif
> +
>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>   {
>   	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
> @@ -608,10 +625,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	/* setup the dram info within bd */
>   	dram_init_banksize();
> +#endif
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   	if (sdram_size != gd->bd->bi_dram[0].size) {
>   		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
>   		       (ulong)(gd->bd->bi_dram[0].size >> 20));
> @@ -626,8 +646,23 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	}
>   #endif
>   
> +	if (sdram_is_ecc_enabled(sdr_ctrl)) {
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +		/* Must set USEECCASDATA to 0 if ECC is enabled */
> +		clrbits_le32(&sdr_ctrl->static_cfg,
> +			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
> +		sdram_init_ecc_bits();
> +#else
> +		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
> +		puts("ECC is enabled.\n");
> +		puts("DDR: Without scrub, false ECC errors may occur.\n");
> +		hang();
> +#endif
> +}


WRONG, should be \t


> +
>   	/* Sanity check ensure correct SDRAM size specified */
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>   	    gd->bd->bi_dram[0].size) {
>   #else
> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
> new file mode 100644
> index 00000000000..7556d4933f4
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#include "sdram_soc32.h"
> +#include <string.h>
> +#include <hang.h>
> +#include <linux/sizes.h>
> +#include <cpu_func.h>
> +#include <watchdog.h>
> +#include <wait_bit.h>


Unused header


> +#include <asm/global_data.h>
> +#include <asm/system.h>


Unused header, please check!


> +#if !defined(CONFIG_HW_WATCHDOG)


#if !IS_ENABLED(CONFIG_WATCHDOG)


> +#include <asm/arch/reset_manager.h>
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define PGTABLE_OFF	0x4000
> +#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
> +
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +static void socfpga_prepare_watchdog_for_long_op(void)
> +{
> +#if !IS_ENABLED(CONFIG_WATCHDOG)


#if IS_ENABLED(CONFIG_WATCHDOG) || IS_ENABLED(CONFIG_WDT)


> +	/*
> +	 * No DM watchdog support enabled. Previous boot stage may have left
> +	 * L4WD0 running, so stop it once before long DDR scrub operation.
> +	 */
> +	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +#endif
> +}
> +
> +/* Initialize SDRAM ECC bits to avoid false DBE */
> +void sdram_init_ecc_bits(void)
> +{
> +	u32 start;
> +	phys_addr_t start_addr;
> +	phys_size_t size, size_init;
> +
> +	start = get_timer(0);
> +
> +	start_addr = gd->bd->bi_dram[0].start;
> +	size = gd->bd->bi_dram[0].size;
> +
> +	printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
> +	       (ulong)(size >> 20));
> +
> +	if (size <= PGTABLE_RESERVE) {
> +		printf("DDRCAL: Error: DRAM size %#llx smaller than scrub reserve %#x\n",
> +		       (unsigned long long)size, PGTABLE_RESERVE);
> +		hang();
> +	}
> +
> +	memset((void *)start_addr, 0, PGTABLE_RESERVE);
> +	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	start_addr += PGTABLE_RESERVE;
> +	size -= PGTABLE_RESERVE;
> +
> +	dcache_enable();
> +
> +	socfpga_prepare_watchdog_for_long_op();
> +
> +	while (size > 0) {
> +		size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
> +		memset((void *)start_addr, 0, size_init);
> +		size -= size_init;
> +		start_addr += size_init;
> +
> +#if IS_ENABLED(CONFIG_WATCHDOG)


Can remove the guard,  just call schedule() unconditionally, it is a 
no-op when nothing is pending


Best regards,

Tien Fong

