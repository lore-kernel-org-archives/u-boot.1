Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B482ECD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D18879BB;
	Tue,  2 Apr 2024 15:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5pp973hO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4C788173; Tue,  2 Apr 2024 15:11:26 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D461E879A2
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeN5be+AxsYAAZcl9fIEiUvXcCLOCJk1Hy/z/X3ogGGMJaWO96sj+7LbLtWbngZL4Y6JGu2XIMD3dBtinb6KE9ZZ2lLvtrVq6Ak0nziEtD8mKVtVcxHtX/br+RVd4jwD8GeMrpsEvr62OTOjmbnd0hdW8TVA4hrFk8CymU3YmPK/v48HxWGrN/wSpTn23wZ41JW6KTWF4Y02r8mhLmKEpGs0UPP8y12Gigqsydra96DTxnrCGETnEjuABHPU6VniIe9FAq3SRuNQ3J3QrN5BbTrtPVN8n0uBB9S/lZlrGtDjBt/s/Ar0bPATr3uY1JzeD7cZSxO0/7yLwnCRMQm2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvHDkbYrS053iDCkywFqYj35tu2up4op+G7G4S1mu1A=;
 b=hG9yBUH+XTyioMgV5uF+H550byGzGbXa8q+qCQCcptwp8MF3bqNsQY+fcXldFs2GcFhTzQw1FzPZivBVpGXu3l2goZZ40iFmQZNctGAsHKIA2DvFViuCk4jo3oVIdeQYkQ/z64jL76wmqU7UJjDGXlji6hzbTOvREwihBA9vJy0mREc/UHW+chd7drQLLTmj8TwWqF0EIL1Ko1Pr3sn1+VPFEfFSwnw+1ITcLtXpahVSD2RoyJyn4DWXFRAneNDsju1zKh6L7qhk5FTnOcpsJY5joi2RIycEyM1+2GYT7l8UsMw2N9xSv0ZgZAcWeiJ4voE1Bwg5dyb0Zm+CmN4cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvHDkbYrS053iDCkywFqYj35tu2up4op+G7G4S1mu1A=;
 b=5pp973hO6rwV2rKDANcqqs2X5YpKNGZtFOs0aLEdfRDYts7ckZclGFuvg0/bFeTo3SA2h7r1xprn7IVt+bdAS+rk4jvcLZIbs7H53TPIHT0mMc36E2/HRyTiGVgEV8jyTwmemG0xjNuHXtJb5O93tGyk049xPklvUxu/VrMzEso=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:11:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:11:20 +0000
Message-ID: <6db16821-fefe-4e5a-8cc4-58a48707002e@amd.com>
Date: Tue, 2 Apr 2024 15:11:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: zynq(mp): Rename spl_board_init() to
 spl_soc_init()
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
 <20240327121153.2455126-3-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240327121153.2455126-3-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0270.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwTqhkl3UlfecJ+bDxgUynACJCLeYEwhdLPUiLFznbn6C5nXUYt8wDtcXTy8nl3Qza8goyc8DVm3JLu0i73rMf2SLrVOwkQ/9Gx3lEcr71AsUFOB/AE/8JlVF+IDrXMwfxdwDqAxSXCbJgcd5XGjH7Bih+RgGvvZSthCN7UmIwylS9ldiKbjn6ExSzkoTwU/5o0UpnKDlwmAHa+GscUOFQKlvAKhD4uopoLmIQVoMXoqEK01ZNjpyEsOoFyt1E3mOh7gYCQTbEwLTQrJl/gTn9u8VGAqY8X8WtnAuUwyH/ZyB+slrNyK0wl8w3bvk3Ub5bdevWTe8RdxhN/xOSsCNQtOixfr9cfyNCzMk74NqcKKUfuchW4+34omH+RKzaFFpJfGE3i9udSqr8Snb8zp8K6dUGZIu1OGc/mOz7IT3NzRSRd9PF3kbQJbTzUlnf2Y0QWPboJNCaSaRWXekFVjZFO+2rX19dXgzxuuh9Fkhpy1mhB8EY52pmZNszWUKH2bAk127dlI9HCqwuiaCPg62J3Z35vfBv/4bWSV2N5ukTUJWJGUhgZOcbsYTR9AEwxQ8wu0s52DNLFvLVdoZnA7CgpFj2whmABwYJbQ3lhu1xaufDu3Py36G/+/bJyewBZ7lhpaeL9MYiPaQcv1a6Cqig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXI4bmd1U0o0OUJlVjlzOXppbEtrZGFKR0d1d0J2bC9qUk1uWUxHOGRDMkR4?=
 =?utf-8?B?c1dWWUJaVG9DOCtSeDRIejJZZGRyZFhoNUtRaG1taFVSenNNbW40NWgxNUQ2?=
 =?utf-8?B?Z2xJTUFLZWU0Mjg2Y1ZEdUk2ZTErTURGOWFNMnpadkJzT2Z6djVvZHp0Wmhy?=
 =?utf-8?B?bXJ4NWFyd1ljS0FtdXcyWkhrRzBVc2NGR3hUdXVpWkdXOEhZRFV2K1VxTXB0?=
 =?utf-8?B?b0xHRHI0TzJ2WVVadGdJYjZBRWEyZDJ5OENqeGg5NCtITC9CNzYxVWhCd0RT?=
 =?utf-8?B?VTNBSmVEYWVvL0dXeUZQSmFsM1JKbldyOWgrY2RNTlJBZFJMYlY3cFI2blZp?=
 =?utf-8?B?c0dERFFRSWlRMUNtNCt4NGRGU3dBUUxCeFNPbktSTnEwYWw4V2lKZUpnWGJk?=
 =?utf-8?B?ZzFjQ2hLSHY3eWk0YVJCYlFRYUFpYmJBQzFpL3RwdHRtQk1ndHAxNmNuZ1VW?=
 =?utf-8?B?QmVmdCtzZWtnTXdCRWdoQkVmR2RzOVRIdTVqSTgxNkJXcElCVE9qdnBPK0ZQ?=
 =?utf-8?B?TDk3KzVFMW9DbXQ3Z1I1NjhwVGF0WUlBQ0hmdjJ3aC84WjFFTUNqVVlVZ24z?=
 =?utf-8?B?MVo0OVdSKys5YllySEdVRUVBU3lNRHh1ajhWMEQrRXQxcVNRbk8zejFQckNG?=
 =?utf-8?B?elgzRkVKODUyVkQ3OEFWbEE0RFFEa05PRjQwWjUxRFltcTE5ME42TEtLRjdB?=
 =?utf-8?B?a0Y0WmVqREdnUDBhRkFGMFFVMnlaRTVvbE8rdUhGT3I2NTJBWXE4MUhZR1Q1?=
 =?utf-8?B?STJqWGIrY1VxT2dQcnprRndoNkhUT3hQT2NoN3ZkNVJ3eEVCOTVaUS9xc0pS?=
 =?utf-8?B?YnlFTUY5Vm1yT1llVzFrNzJMUDRJcUg5aFNZcExHSmo2dkFXajQ2a2tNSTBM?=
 =?utf-8?B?eGlhbnlJNWdIVVF0b0gxay9HNXhyeENrcG44dG5zSm0zZ0F0anZybkw5S1h4?=
 =?utf-8?B?QkNvSDRQNHlISklpaGFOR0NJdWdaWGlXZjY5MktVM29DVjhJWDFMWUQ3N0hL?=
 =?utf-8?B?cTdqYlNHWVIzb1g0UDk2dTVzR1VaWDJRZ2dvN1YxTkN4Rk1QMk5WUmVGWUhI?=
 =?utf-8?B?SHFVcloxWC83b1hINXR2UlpzMFB6K0tNMWViN2lXOEFmb3l1cW1GTVd3TUdt?=
 =?utf-8?B?emhYYWtZOEdnalpHeU5ycFBWUWxkVzdGVGdmZTgyblJuZjhJQzF5eFRoZXpU?=
 =?utf-8?B?ZFVoSUVhZTNualBta28vc04vOGxKdStMS054b1BxaE5pWWg1dmVpaEpPRk80?=
 =?utf-8?B?SFYrTW5KaTFUVHBEV2RxMXhyT3p3Mk1nY1piaklLZWRKd1RoSG1hNi9aZWpy?=
 =?utf-8?B?ME9BUEtKRnduZm52ay9ML3Jxc3JzRHM2ZUFDRFVjd2QzNlUzb0svd1Y3SXZm?=
 =?utf-8?B?WElhQVZhUHA1RjBjam11UjA4eEdzT0JUdnJJenZ2NjNTN3hPcVdDWTMzUFkx?=
 =?utf-8?B?b0lTY0FiKzhudUFRVzBYNCtmSUV6dXpJZ2Q1enpGazZ4MHdRZHM0VXU1V2Rr?=
 =?utf-8?B?cFEvSnVsRklLdkVvQzFqVTVzS1laajhGQzhlL3NWTkR5Q3U2bFlGZnpFVUxw?=
 =?utf-8?B?dUEwbUFoTlIzT1FxTm9nQWVyZS84aXFmdjF2ZUFIM0Q4M0pueG5DeEw1MkxE?=
 =?utf-8?B?OHVPRk9MU096ZWZlZm80WEFVMjN1R1p0ekNHM3ZRNEN4NWp3Qy9GUUtJcHR3?=
 =?utf-8?B?Y08wY2s4bWNaV3l4Q0JtR252NHFKMEF3L3pUc1RIazNwdDl3YlpvZEtkSlNE?=
 =?utf-8?B?eDF2cmpTMVlscnhlKzd5OWdDSEcrb1F6YmZ1NTdyWVY4OXBKc3pyTTR5ZUVG?=
 =?utf-8?B?aXJTMGdVZ3dQYlRYTktoYnAyM0pYS3NVTlRHQitQUnowL05jVzdhaForazBC?=
 =?utf-8?B?cjVqckppNWp6azhpL09MRXFFWFJzSmlyY2VINE5VWWhZQ2NUb20zZlI2VHhy?=
 =?utf-8?B?TDZmYlRTcUxOSzQ1cGZqZzUwbjEyTm50MSs5MkI3bVVRbUhiSUtrcDNXUFNM?=
 =?utf-8?B?VHVTRGlkb3ZzRTI5NGVpZHRpSFNGTXU2NWdUS05iaUkrRWU1K0IraHcyd2hG?=
 =?utf-8?B?VHlUVVZLa1IzWnBiOWdWTjFveVc5dTMwUm56NjRYcWJjT0Nkc3VmTjZ2b1E0?=
 =?utf-8?Q?UElh7503yBzHLQGU1tAUGt17+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52be04af-42f8-42f5-40c9-08dc5316634f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:11:20.2893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOjgI+a+ioO8v3TBKDL3bIBV1as11l25nN23bHbmbDW9kDrrCa3dIlLsCun5QXQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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



On 3/27/24 13:11, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Rename spl_board_init() to spl_soc_init(). SoC specific
> implementation should be separated from board specific implementation
> in order to be extended by board developers.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> Changes in v3:
>   - Rephrase Kconfig description and correct minor typo
> 
> Changes in v2:
>   - Change spl_arch_init() to spl_soc_init()
> 
>   arch/arm/Kconfig           | 4 ++--
>   arch/arm/mach-zynq/spl.c   | 4 ++--
>   arch/arm/mach-zynqmp/spl.c | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 01d6556c42..db56db9414 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1275,7 +1275,7 @@ config ARCH_ZYNQ
>   	select OF_CONTROL
>   	select MTD
>   	select SPI
> -	select SPL_BOARD_INIT if SPL
> +	select SPL_SOC_INIT if SPL
>   	select SPL_CLK if SPL
>   	select SPL_DM if SPL
>   	select SPL_DM_SPI if SPL
> @@ -1318,7 +1318,7 @@ config ARCH_ZYNQMP
>   	imply FIRMWARE
>   	select GICV2
>   	select OF_CONTROL
> -	select SPL_BOARD_INIT if SPL
> +	select SPL_SOC_INIT if SPL
>   	select SPL_CLK if SPL
>   	select SPL_DM if SPL
>   	select SPL_DM_SPI if SPI && SPL_DM
> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
> index fea1c9b12a..112b44e2e1 100644
> --- a/arch/arm/mach-zynq/spl.c
> +++ b/arch/arm/mach-zynq/spl.c
> @@ -32,8 +32,8 @@ void board_init_f(ulong dummy)
>   	arch_cpu_init();
>   }
>   
> -#ifdef CONFIG_SPL_BOARD_INIT
> -void spl_board_init(void)
> +#ifdef CONFIG_SPL_SOC_INIT
> +void spl_soc_init(void)
>   {
>   	preloader_console_init();
>   #if defined(CONFIG_ARCH_EARLY_INIT_R) && defined(CONFIG_SPL_FPGA)
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index a0f35f36fa..71f9932525 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -56,8 +56,8 @@ static void ps_mode_reset(ulong mode)
>   # define MODE_RESET	PS_MODE1
>   #endif
>   
> -#ifdef CONFIG_SPL_BOARD_INIT
> -void spl_board_init(void)
> +#ifdef CONFIG_SPL_SOC_INIT
> +void spl_soc_init(void)
>   {
>   	preloader_console_init();
>   	ps_mode_reset(MODE_RESET);

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
