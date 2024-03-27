Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D5C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 09:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA7B87F65;
	Wed, 27 Mar 2024 10:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="TKVtfdRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB22187FDA; Wed, 27 Mar 2024 10:45:19 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D21A87F4F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 10:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWXca5gcOMW4cc+eAA4A1RpunM588oTSYNsrI18R9nrOiiFqLJbbT4z+WeAOBTlBPPtfQO90q1uWmNC2YaHEVHMCar1Ahx1/WSO9Yjgqh4+hHYrabJG8a45maJVPUWi7esg9HXslK1Cy/f15LSK5jZiD0ORiJyq74jyIu9TsKwBN5cpz3a6aEx3t8GIMtEjA4M10/6jSBe2Npz33gidh4mKy5p5ufqbvejVmAnxXwXOwe6MxzH17R7fQGEzXdor3q4RFTm2px146D99RY7v5JoMpOQwdirJJMHsY8X59OfaxAxbu+5N0jFTvgoCtQmMuye22oRioyUCZ7V0cihkDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vYj/de8Vm6fHZk0Z7KYJn1kQv3djxLQBQIdyq+ttN4=;
 b=BMNDXtKXwssukQidKQZ1eeove8kShV36lejUplY5Luv35OlproJIYNKI+BfLnUck0Yawu8g3BzXG2MaOnu50JHVHQX+kjigWynzwvbwlnlnFxG3MsFpTH41W8QiYLb+mv99kBJFjqLF4k8b29c9UJ2pOi5ltpH6OXIr6ReAgDVfr92aRifk4HRxyVElq2ohEtcrSEU96AWdDenwYSZKtQzQTMxzBtMHahwJkB0d35ll0suZKPu3zVVncxvxIW+hTdDz3954u4ZeUA/Yq7MF75+nmRY+Vh1tMPN/HKWFDP6oJwZG5AMrMPjC9WPHuxKqYuCv/nDu5au1p0N+A9BDeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vYj/de8Vm6fHZk0Z7KYJn1kQv3djxLQBQIdyq+ttN4=;
 b=TKVtfdRxJQC2Lz97Pw5TOOZYMPbj/wHQaUQMbY7jp1xOYCQPH/24y1HCqDQpQCiiX8nvzp/wFBL0EBu/+xZONXSdNN63CJs5SXBNcpptyQVnvmU+dg6noOJQ3GspQQSoIKJpnzUTcEKq6rMViP6ui0ffLx/x5LhEzYss3gZLW+0WjejLi8gIG2Dgu2Qr7KWjIhbCPKv4o8tqt/4OGAkNeDDJCfzHWUjtmoWcRVVPoaML/tIIcsN4ctNoICBh7gnDpciyWpcaQ1RTuuoIMuUtx1xzKZR/pDqmzW/1z72BDJKnOQeyDX5yoB9biM8o+bZPfedd1L+QZHKBGb14OHXq0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAWPR04MB10053.eurprd04.prod.outlook.com (2603:10a6:102:387::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 09:45:15 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:45:15 +0000
Message-ID: <235e3d9a-17af-4cdb-a0bf-2bffe3c7ec0f@theobroma-systems.com>
Date: Wed, 27 Mar 2024 10:45:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, cym@rock-chips.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240326204944.1572667-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAWPR04MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c5d16e-9c8b-47bb-ffc2-08dc4e429aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYB3vcQWKnSzSoCgm5enqQ80eY9zplA+bqw+XCCG0t7hmvfWoEHliCNILCs32JL381UtBLJsZOYhw05R1bpzemgBl9OtypPsa6SRDH1hbtuQJvXacx1yMQLCcJXZe9KsfLHpMC9udrGNrnVrfNFR1/ZIJP0fmlgh3Dp4An35nIDSXCUrqrfCBvJa4QnRnwcyz4li/YytwT+YuUIHU5J2iTd+Wb76QRVoNinwXPMYXn8fPG+pkM47n1W/ZVDStxxrnG9g52FmJpLPw5WC7B639mbMBM3ZXj5iLbRJCZDrxldDV+TLA+PQCWE9MqERAnEQp+N+E7LXhc8fPvJ0ZZ+ifJn/Pd0IdR3OyEsQuWbnq71pVYxqj+p7lTYAJfah7PuhXpYz7EoLANOjUbpVON36YLNeIBzI85q3sQKwHG3I1saf8IKmhAYH5Ye7WnaSU2e6cztIwnfR6N7vUMYXKGFNkBKiMQb6f7LHJag1dQQLZC+oxHKpzQu7OEJ1MJAzpMJcmxCd8XItc7d6ZE2vOo98ErxiavLgmvmjIKG3OnMGadr6mk5IQZjnolWGN5CYMXdfLb5Ww39qc/8fgLi0yrlfse89o94sMSZ/3FfHSfBSNIs6Fxl2yqmz7b4ymdOauCKC/0aBUJBjHjnUSs6T//XwHIMwmwUBk8FNHzVlN1lpp1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktvR003UmhzNWJEUWwxZUhkYU9GRzdaVDJ2dElGTEg0amZhSklxNStpWmNR?=
 =?utf-8?B?KzJpT1B6cFVreUJkK2VJa01Kd1JPVkxvVk9FTUlKaEJITSt6ejV2V1cyZGVu?=
 =?utf-8?B?b3ljR093ZzFUL2VxYTRKeU9Gd2hmV3FFSXA4dXBTQ285eSs4WjN5UkE4cFJh?=
 =?utf-8?B?ekI1VGV2d1hwWEdGTDRxRTFKbTNoMGE2djEyMDhQaVJCL0RkUXFIOTlvNUpl?=
 =?utf-8?B?QmhRWTlnZ0pod0gvTW4zbkRxdmpHUFZsK1dyeWxHRHlScEpvVWdnL0lRK3Mw?=
 =?utf-8?B?ODgvM2pvd3htY01GMy90YS93a2ZBL1dtdnlMbW9zTVZIYW5zdEREUkxRa0I2?=
 =?utf-8?B?YkxSeFAxbzMrZUdzeU5nSFBwaUJwNlE2Z1ZmSGUwUFBrNUpncXBKUDZrcHho?=
 =?utf-8?B?VTlhQW5HSHdIaWFGc1Q4RVc2dzVlYzEzUkkyNmRxSUxsMm5rOG8xSkVyNGZL?=
 =?utf-8?B?SmR0dkkzL2ZMZllGVnhBT2Nhcm1xQVNLb1gxUFhOblk2T2pOTnJQdnFnTUtr?=
 =?utf-8?B?dGVPdktPZGJTKzI1MForQ2luUlJzRm9BbDBYbUd6b2NVaGJDemxQdnhNd2hj?=
 =?utf-8?B?aDd4WWxMb1RZb00rdm1QVmtYbzhYTERXb1NVaVVRckVUR3R2RjFjUEpKeHN2?=
 =?utf-8?B?OGJXNlFQcEFEUldVNXRsMXZocUJuOGROblZVSXU1Qmp2Ry9lRGJRalNFeWIv?=
 =?utf-8?B?cE9JVi80KzlBZ1lkbS9XK1I2QTU2MEN0UEhEY0NlRG01a2FEeWtjWmFmTWVt?=
 =?utf-8?B?clNPc3FxVFAxTmI1dTdZcC9BNVF1SVMvcDNvYytKRWRCS2dnSWpsRDBXM1h2?=
 =?utf-8?B?dEtOT215L2JCTUdMT0E4VnpleVlIZytqaUdWOVhVblUwYnM4VG9NRFpsVnNu?=
 =?utf-8?B?bHB2Tk9TbTNDUzBMS3UwRHMybUtIQTJoYk5FS0o2SVZTYzZ3VzBkNmJFZm1v?=
 =?utf-8?B?Y2RGRExFaHNPQWhkb0w3MVd5UXJHdWpkdzFidk10a2VtTEZpYzgxUzZ4ZmpI?=
 =?utf-8?B?N0k3TWI4YTF2VldVL1NHdVlGbXZ1RG5rWFN3WFZmRGpqd1N5SlYxNW0yV3hQ?=
 =?utf-8?B?cTlYd013eFl2cldUbjhFSE5vcitOVEhJeGxGYWZEMThIU2todGlmTHVXOWpw?=
 =?utf-8?B?N1dGZzA4cm0xOTEyRDYxK2ovYkxEWjdlZXNBb1A0M3FTMnFPSERCSGJnRWVk?=
 =?utf-8?B?ck82b003RFBiN2xLSWxpNytVZVpEVm9TcXhYa0p6UTVzQTBpNlBJUmlLN2Ry?=
 =?utf-8?B?YzFWeVhMZkFSQzlFVTZkS3NhdGhrMTVTcHhaMVZuK3NSNGZaaGdJd2x4QXd2?=
 =?utf-8?B?SnNwT0dTME5jbjdUTnNkc1ZVMnNaejF5NDV5eTkycUVXRHBkU0NWK2h5Yk1o?=
 =?utf-8?B?MmFKVWF5OTBtVU5HNWJnN2F4V3FQa3phUjhhMjE4WTdKREx3ZTVkenUrc1NF?=
 =?utf-8?B?UWRVelNyeXczdjJTM25KalgrUWNnVFN1RmsxMGV4d1lxWmQvSGtpTSs4LzMz?=
 =?utf-8?B?dmZSVjE3MzQxbGFISVhMMzkxOWtLbGdVQk82d0MxcW9qQXFRTHdTQUtUWmFy?=
 =?utf-8?B?dVdTU3M0ajRWZkJlb05LN3ZOd0NReDVIdWdtS2gra08wa3pGRURLa2dQRHJU?=
 =?utf-8?B?Y3RTeU9BcnBobm9Pd2pGdElSSUpFMzlXWTV3elo5WW0yWUVBUFVFVkphRWlo?=
 =?utf-8?B?bm9YU1o4ZHJLaEZVWktxaGdzMU5FcllSVlFKa2hUN3ZnWEl2MjUxR1lKMjJH?=
 =?utf-8?B?NHVzcHNJZDZ5QjJSMTcyeEFKSk1vdFQralEyazg0NG8xbUxzRG84VGk0Ymgx?=
 =?utf-8?B?UzVZNVk5U05ab0UwZWVvS0x1bzJjRlQrTnVjQTJZQ3FSVXJoYTMyNE41dTAr?=
 =?utf-8?B?dXVmVEE5OS9MNnpOa0w2N09DL3Vac3piTFJyYng2MkhPMDZzd1J3bHlnclUy?=
 =?utf-8?B?ZjVnQkFXZVRUK1JFbVRHTWFKTHdHakVYM1dBLzl4MXBhTGFubWVFSkVsbC9O?=
 =?utf-8?B?T0xlaEdyb0NPMjlJS21hbkVOMWE1aC9idnVRRXNrc1gyZklhMkJ2U3FsSXRR?=
 =?utf-8?B?VlFVQ2c2R1h3YkYxSzZ5dkVwRURSTURqYmtpOEY4eEVKRGZXTnBVMDBuL1BR?=
 =?utf-8?B?K0s1QkRsdEpvOWt5UEZrb2FUakdyZFFiQ3ptSnVML2NBWnNDZUZ5dGdIQkdQ?=
 =?utf-8?B?RVJDK3Q3OEdnQmk0SktjaTZSNUVvN2N0Z1lnSG5KdkFaNzBneXB1Z1pJTG1G?=
 =?utf-8?B?aUlkVWgyWGxBODVlb0UwWGJyYk13PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c5d16e-9c8b-47bb-ffc2-08dc4e429aa8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 09:45:15.0684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1Apm2BPSCbWvtkm9UlvSZOl9ZHozjb7cTZ3C0/k/G9b7MxfPPsjad+WXSXcuLLqcAucdMGBzDyxzLt7zRI3TfDuNKasEiXTczHdmxlcKu8gLocd8IYYGBrEcK3UBjso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10053
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

Hi Chris,

On 3/26/24 21:49, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for parsing the ATAGs created by the Rockchip binary
> RAM init. This ATAG parsing code was taken from the Rockchip BSP
> U-Boot source and tested only on parsing the RAM specific ATAGs
> for the RK3588.
> 

Can you tell us from which commit (and maybe branch/tag in the event 
they rename/rebase/delete branches) exactly so we can check if they fix 
stuff downstream every now and then?

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/include/asm/arch-rockchip/atags.h | 222 +++++++++++++++++++++
>   arch/arm/mach-rockchip/Makefile            |   1 +
>   arch/arm/mach-rockchip/atags.c             |  99 +++++++++
>   3 files changed, 322 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-rockchip/atags.h
>   create mode 100644 arch/arm/mach-rockchip/atags.c
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/atags.h b/arch/arm/include/asm/arch-rockchip/atags.h
> new file mode 100644
> index 0000000000..9bae66d7f8
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rockchip/atags.h
> @@ -0,0 +1,222 @@
> +/* SPDX-License-Identifier:     GPL-2.0+ */
> +/*
> + * (C) Copyright 2018 Rockchip Electronics Co., Ltd
> + *
> + */
> +
> +#ifndef __RK_ATAGS_H_
> +#define __RK_ATAGS_H_
> +
> +/* Tag magic */
> +#define ATAG_CORE		0x54410001
> +#define ATAG_NONE		0x00000000
> +
> +#define ATAG_SERIAL		0x54410050
> +#define ATAG_BOOTDEV		0x54410051
> +#define ATAG_DDR_MEM		0x54410052
> +#define ATAG_TOS_MEM		0x54410053
> +#define ATAG_RAM_PARTITION	0x54410054
> +#define ATAG_ATF_MEM		0x54410055
> +#define ATAG_PUB_KEY		0x54410056
> +#define ATAG_SOC_INFO		0x54410057
> +#define ATAG_BOOT1_PARAM	0x54410058
> +#define ATAG_PSTORE		0x54410059
> +#define ATAG_FWVER		0x5441005a
> +#define ATAG_MAX		0x544100ff
> +
> +/* Tag size and offset */
> +#define ATAGS_SIZE		(0x2000)	/* 8K */
> +#define ATAGS_OFFSET		(0x200000 - ATAGS_SIZE)/* [2M-8K, 2M] */
> +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
> +
> +/* tag_fwver.ver[fwid][] */
> +#define FWVER_LEN		36
> +
> +enum fwid {
> +	FW_DDR,
> +	FW_SPL,
> +	FW_ATF,
> +	FW_TEE,
> +	FW_MAX,
> +};
> +
> +struct tag_serial {
> +	u32 version;
> +	u32 enable;
> +	u64 addr;
> +	u32 baudrate;
> +	u32 m_mode;
> +	u32 id;
> +	u32 reserved[2];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_bootdev {
> +	u32 version;
> +	u32 devtype;
> +	u32 devnum;
> +	u32 mode;
> +	u32 sdupdate;
> +	u32 reserved[6];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_ddr_mem {
> +	u32 count;
> +	u32 version;
> +	u64 bank[20];
> +	u32 flags;
> +	u32 data[2];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_tos_mem {
> +	u32 version;
> +	struct {
> +		char name[8];
> +		u64 phy_addr;
> +		u32 size;
> +		u32 flags;
> +	} tee_mem;
> +
> +	struct {
> +		char name[8];
> +		u64 phy_addr;
> +		u32 size;
> +		u32 flags;
> +	} drm_mem;
> +
> +	u64 reserved[7];
> +	u32 reserved1;
> +	u32 hash;
> +} __packed;
> +
> +struct tag_atf_mem {
> +	u32 version;
> +	u64 phy_addr;
> +	u32 size;
> +	u32 flags;
> +	u32 reserved[2];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_pub_key {
> +	u32 version;
> +	u32 len;
> +	u8  data[768];	/* u32 rsa_n[64], rsa_e[64], rsa_c[64] */
> +	u32 flag;
> +	u32 reserved[5];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_ram_partition {
> +	u32 version;
> +	u32 count;
> +	u32 reserved[4];
> +
> +	struct {
> +		char name[16];
> +		u64 start;
> +		u64 size;
> +	} part[6];
> +
> +	u32 reserved1[3];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_soc_info {
> +	u32 version;
> +	u32 name;	/* Hex: 0x3288, 0x3399... */
> +	u32 flags;
> +	u32 reserved[6];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_boot1p {
> +	u32 version;
> +	u32 param[8];
> +	u32 reserved[4];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_pstore {
> +	u32 version;
> +	struct {
> +		u32 addr;
> +		u32 size;
> +	} buf[16];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_fwver {
> +	u32 version;
> +	char ver[8][FWVER_LEN];
> +	u32 hash;
> +} __packed;
> +
> +struct tag_core {
> +	u32 flags;
> +	u32 pagesize;
> +	u32 rootdev;
> +} __packed;
> +
> +struct tag_header {
> +	u32 size;	/* bytes = size * 4 */
> +	u32 magic;
> +} __packed;
> +
> +/* Must be 4 bytes align */
> +struct tag {
> +	struct tag_header hdr;
> +	union {
> +		struct tag_core		core;
> +		struct tag_serial	serial;
> +		struct tag_bootdev	bootdev;
> +		struct tag_ddr_mem	ddr_mem;
> +		struct tag_tos_mem	tos_mem;
> +		struct tag_ram_partition ram_part;
> +		struct tag_atf_mem	atf_mem;
> +		struct tag_pub_key	pub_key;
> +		struct tag_soc_info	soc;
> +		struct tag_boot1p	boot1p;
> +		struct tag_pstore	pstore;
> +		struct tag_fwver	fwver;
> +	} u;
> +} __aligned(4);
> +
> +#define tag_next(t)	((struct tag *)((u32 *)(t) + (t)->hdr.size))
> +#define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
> +#define for_each_tag(t, base)		\
> +	for (t = base; t->hdr.size; t = tag_next(t))
> +
> +/*
> + * atags_get_tag - get tag by tag magic
> + *
> + * @magic: tag magic, i.e. ATAG_SERIAL, ATAG_BOOTDEV, ...
> + *
> + * return: NULL on failed, otherwise return the tag that we want.
> + */
> +struct tag *atags_get_tag(u32 magic);
> +
> +/*
> + * atags_is_available - check if atags is available, used for second or
> + *			later pre-loaders.
> + *
> + * return: 0 is not available, otherwise available.
> + */
> +int atags_is_available(void);
> +
> +/*
> + * atags_overflow - check if atags is overflow
> + *

This is not really useful to the user to know what this is doing.

I could suggest this rewording:

"""
check if the tag t is a valid atag: entirely contained in the ATAGS 
physical address space [ATAGS_PHYS_BASE; ATAGS_PHYS_BASE + ATAGS_SIZE]
"""

> + * return: 0 if not overflow, otherwise overflow.
> + */
> +int atags_overflow(struct tag *t);
> +
> +/*
> + * atags_bad_magic - check if atags magic is invalid.
> + *
> + * return: 1 if invalid, otherwise valid.
> + */
> +int atags_bad_magic(u32 magic);
> +#endif
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 1dc92066bb..4165cbe99f 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -28,6 +28,7 @@ endif
>   
>   ifeq ($(CONFIG_TPL_BUILD),)
>   obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> +obj-$(CONFIG_ROCKCHIP_RK3588) += atags.o

Please define a new symbol instead, you can "imply" it for RK35xx boards 
in a follow-up patch then.

Now to come to think of it... Maybe we should make ROCKCHIP_EXTERNAL_TPL 
imply ROCKCHIP_ATAGS? That would be the most sensible thing to do I believe?

I think we should also probably make different symbols for SPL and 
U-Boot proper (if we want to support the later). SPL would be "required" 
for any platform with a blob from Rockchip as TPL but U-Boot proper 
support only makes sense for debugging (e.g. if there's an atags command 
in U-Boot to dump them).

>   endif
>   
>   obj-$(CONFIG_$(SPL_TPL_)RAM) += sdram.o
> diff --git a/arch/arm/mach-rockchip/atags.c b/arch/arm/mach-rockchip/atags.c
> new file mode 100644
> index 0000000000..9daa2f2fc0
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/atags.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier:     GPL-2.0+
> +/*
> + * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +#include <config.h>

If I remember correctly, Tom has been hunting those config.h includes 
down, so better remove it if everything works as well :)

> +#include <asm/io.h>
> +#include <asm/arch-rockchip/atags.h>
> +
> +#define HASH_LEN	sizeof(u32)
> +
> +static u32 js_hash(void *buf, u32 len)
> +{
> +	u32 i, hash = 0x47C6A7E6;
> +	char *data = buf;
> +
> +	if (!buf || !len)
> +		return hash;
> +
> +	for (i = 0; i < len; i++)
> +		hash ^= ((hash << 5) + data[i] + (hash >> 2));
> +
> +	return hash;
> +}
> +
> +int atags_bad_magic(u32 magic)
> +{
> +	bool bad;
> +
> +	bad = ((magic != ATAG_CORE) &&
> +	       (magic != ATAG_NONE) &&
> +	       (magic < ATAG_SERIAL || magic > ATAG_MAX));
> +	if (bad)
> +		printf("Magic(%x) is not support\n", magic);
> +

"""
switch (magic) {
case ATAG_NONE:
case ATAG_CORE:
case ATAG_SERIAL ... ATAG_MAX:
     return false;
default:
     printf("Magic(%x) is not supported\n", magic);
     return true;
}
"""

may be a tiny bit more readable but that's a matter of taste, so up to you.

Otherwise:
- The error message has a typo: should be "not supported".
- I would recommend to use 0x%x so that it highlights it is a 
hexadecimal value.
- Use pr_err() or debug() instead of printf(), this applies to all 
printf in this patch. I **think**, debug() may be more warranted.

> +	return bad;
> +}
> +
> +static int atags_size_overflow(struct tag *t, u32 tag_size)
> +{
> +	return (unsigned long)t + (tag_size << 2) - ATAGS_PHYS_BASE > ATAGS_SIZE;

"""
tag_size << 2
"""

may overflow itself, should we cast this into a u64 before the shift?

Similarly, unsigned long being 32b,

"""
(unsigned long)t + (tag_size << 2)
"""

32b + 32b may overflow a 32b container.

Actually, maybe... we should be using phys_addr_t for this? It's an 
unsigned long long so 64b container for 64b archs and it represents what 
this is... a physical address?

Also, this can technically underflow as well, if (unsigned long)t + 
(tag_size << 2) is smaller than ATAGS_PHYS_BASE.

> +}
> +
> +int atags_overflow(struct tag *t)
> +{
> +	bool overflow;
> +
> +	overflow = atags_size_overflow(t, 0) ||
> +		   atags_size_overflow(t, t->hdr.size);

I don't really understand why we need to check for size 0? Do you have 
an idea what Rockchip wanted to do here?

> +	if (overflow)
> +		printf("Tag is overflow\n");
> + > +	return overflow;
> +}
> +
> +int atags_is_available(void)
> +{
> +	struct tag *t = (struct tag *)ATAGS_PHYS_BASE;
> +
> +	return (t->hdr.magic == ATAG_CORE);
> +}
> +
> +struct tag *atags_get_tag(u32 magic)
> +{
> +	u32 *hash, calc_hash, size;
> +	struct tag *t;
> +
> +	if (!atags_is_available())
> +		return NULL;
> +
> +	for_each_tag(t, (struct tag *)ATAGS_PHYS_BASE) {
> +		if (atags_overflow(t))
> +			return NULL;
> +
> +		if (atags_bad_magic(t->hdr.magic))
> +			return NULL;
> +
> +		if (t->hdr.magic != magic)
> +			continue;
> +
> +		size = t->hdr.size;
> +		hash = (u32 *)((ulong)t + (size << 2) - HASH_LEN);

Same issue of possible overflows as in atags_size_overflow().

> +		if (!*hash) {

I assume this is "safe" because we check this is a "valid" physical 
address within the expected boundaries of ATAGS address space with 
`atags_overflow()`.

> +			debug("No hash, magic(%x)\n", magic);
> +			return t;
> +		}
> +		calc_hash = js_hash(t, (size << 2) - HASH_LEN);

Ditto.

Cheers,
Quentin
