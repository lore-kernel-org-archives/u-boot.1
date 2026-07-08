Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D20C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DA7838D7;
	Wed,  8 Jul 2026 06:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gXo66Ew4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480BE84118; Wed,  8 Jul 2026 06:35:04 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CACC80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldYlvjFVxm1G0gEyBCgW5KKGLXqfkxjIeNpnfPo0fzPnZaxGm6BVOH8CfIcfW9s1DUEQk1NpardQqs3dh9vUw7WPTu01lLr6VsNIglw/8JsIL4SRCVGldJbZp1Q/GZ7ljjpJmQNP9XTI9R8THWALgfuiRBCwFC5IjjjNXGmlZ6S2FoFZ14CwGNnhc/ndvRE0v4Ugb5VsrSaXly7UoyQZM9X2TSJqBVmTnpfa3neY2OBZmk/tqmzA2lQ61J0FkGOmQjB4vQo2MoE1T++EKDjaZNn3PAUvLoY1+yn1jLzgENLL2bh5SGZ0QOpjDpzhQ2ADb6XnftEHFL0qwJyFfpTUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lKjmbK2Q+6hHrbMWDjQq09kqH7bu4Ab0XqGg8J7cFg=;
 b=uiKZlYjPTTupbi6wW4sojmD4C+i2wCEvCddg7npiaY6oZI5cTu2pxOA1+hENmstbgkUuRo9xvx1gFcJ6Lx4W2tGnr+Rx8PLbFAZUEAjc7KXuRxr5sig0M8+JHufLvGjq4rhv8ZHp6iUQ/fkZCELN9/glLzRvzCSEw2L5W5futjKYIoW7gGH8xVbFfZXt/l96+Fja1/uCdkh5owIblib9HlE9CNMmfeV4ABdHYy321p475wVlppBhgsoAlGw48G8tVx9mVjb8UP+GYvWnfesEjKpllIonwiuWSOhhpGrPRmgPEzRl7rTtpl6Ye2MyF1wgE/JlqOMxnpnhCn51pOGA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lKjmbK2Q+6hHrbMWDjQq09kqH7bu4Ab0XqGg8J7cFg=;
 b=gXo66Ew4y0qS2+SUZkCdHsMWyIZth6pRFtddbUK5bvm3taXRiC55a7zXsbi+g6MizmkwzrUmr8WXoJkgjxDakRQPbUdZOuvrsCciZ/b3CXvMaFXKRgig9JO748y3+OPE7mQixoyCcyWZ5W3Iwne20XR/q//FTiLDiucg3eVWJ9U1KBykkKo1r7EDZ9l/A6t44TPOP6kalu9k7d4yMipL60MnDjjarscoPzzs9FnqVzeznneun221cdgM4pnlJifM/42TiOB9iYxndetbLELfqRkpM8Ii3k2+GN6NdpQrC3lcPqDoqO/4SW72r2GeKScsIuppdHM3y0nChVr5jZkM6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:34:57 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:34:56 +0000
Message-ID: <6087d33f-b344-4be2-8894-c3f2e26b3bb8@altera.com>
Date: Wed, 8 Jul 2026 12:34:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] configs: socfpga: n5x: consolidate ATF defconfig
 and simplify VAB
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-2-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-2-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:295::16) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d2e94f-bcd5-47b2-fc58-08dedcaa4320
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: QjO5+aqDT3eLvOxGhpnposYA2MrBUYDUbQWdTFyPpzQS6SAE/s5emBM9wSCUZSMn4aX6BDyPIPFrUTYk1f7sBsF9YD3pE3AkA2Ev7T4EfkLnPOIlFE+Wp7HFMLmJWyGR0d0Zno7YXUJtx6o70NmfnnO0dZvdZNeIFzjErROHEiSJVQ2k/t4TKYoJf1sjiEl5KOuKkrhF6jkoC1hjXmZRHnk62p/U9tON7pQxpbjhilc4cSHRyu8b/fXP0rO5Fl44uzPPPTGkYWfZtCArG8Yp3YWkeztDHZG50g15X1XRXWGHW8PY05DtdiiTyFvsCTO9828UZsXJNMx2F9uEIwX4FzcedklBSWHKDuQ6uUNwlcR6MsLGiaHahidXaq9NQteT4dfDwaeWO+MFMCtsmMWY1befacorkKobaUwwkzkQ5DpqL1DnwxY5ADhCwj9WA2iuOzu2ObINoqDSdWe289BfA7e0nLH/+AS7nwnOEPWVYcvXdloCJL7iJbA3H6Kwa+EZ96+V/H6YMNEo7ZxtgFCNCV8DQZijHnMtrwGs8ba+QBOJ6XtMnDkrxn2K24M83bIyDrDzudGsXEKAvHi7uU7Xv7GxNEE/VAA6ohSmFe1ia5VzsM4oprGKv46eyKEK0DV/DAJS7pVv/XqUEgRcK0bdd8aFcvEAkKVowTFzbleTtR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJPVE5pQzJoSm8xS1k0TTRiQlkvT0h4a3VrSFhHYVBETXpSZmNHaG8zSjJ0?=
 =?utf-8?B?cTNzcE9PS241djUxVkl3T05LcmlKWG1lTWlSbXdkQ1NaUG40SENKbW9iSkI5?=
 =?utf-8?B?bnZxWWErcWp2NVFEOSt0QlN6bGYxemhWMENwT09EcTI4eUxpVzhmaUZYZUVY?=
 =?utf-8?B?K25Fb0VGZ3ltQVNkQlV6aGNyeDhOZXJwOGh1VmJTL21hcUJtU2tCZlVtWFRi?=
 =?utf-8?B?WnVuZFo0c0cvNmdZMkRGZDEvZEhUQUxISCsxTTRCY1p1OERsRnBPS1A0a1BH?=
 =?utf-8?B?SlFtOVhJNm1iTmp5QXBGMTF3bVVGcUJRc2xrNVFvVi9PRWprN3pVaWtnTHZZ?=
 =?utf-8?B?ODhXT0RHTlhFUFpMTlpqNGJZUnVqU2lPNjhLT05haUNGSGtyQjk4cnZxT0Ro?=
 =?utf-8?B?UTVzMW1DRDkvcFp1ZFp0dS9icjVmWHFKbmNtbm1sODFna1FVMDRueEk0R2s5?=
 =?utf-8?B?bXpzOGloLzVKdzBIUjVFSmJZdzhQT29reUE0M1lQK0M0clYxMGRDQWs5dkVU?=
 =?utf-8?B?ejFlVjRQeVg1emtsNTdFclcxQVUrd25GTDFsMmw1VUJJeGFuNWpBcHk0Mmto?=
 =?utf-8?B?QXJQbmJRUmlmMGF5WkVucHlmSUIrK0kzVEdVUUR1N1JZRElpU2o2eG1GeHlv?=
 =?utf-8?B?VkNFQy8veWxBOU5PYkRzYWIxb1NHN0JMdWRyNVBrMWlra2NaOHZ4dkl5bmM4?=
 =?utf-8?B?WEpsVnlkL3FZMGhJWm9uTTYxTWVVWmxPd3UvbHJOQ3M5eVo3QTZKMXROVFpM?=
 =?utf-8?B?M2lUcTZBVyttOG5iNDd5UzVOWS9MRUFRWWRZWEV6Y3JuOHZYNWx5SHcyMktQ?=
 =?utf-8?B?NnhXL1pDdTV6ck5FVE9OcnZ5Uk1QY2lFN25zeko1SmpsU1RTNXVHaWgwdnlL?=
 =?utf-8?B?bjIzUzZrb1NXRmE0R1d3VmxYZDBkWHdNVmpndG8rcmlLQ0Q4eDNGRjkzUkxC?=
 =?utf-8?B?ekZmaTJaZVJ2ZGk2ekluQ1BmUXdhamZzLzlXUC9BNmhRSUJLREpkbm5xbXgr?=
 =?utf-8?B?Sm5pS1lVYWd1V1lHa1VDUHIxUEhZK3NWQ0w2c2JRSnVzOXZaT0xia0FzdWs1?=
 =?utf-8?B?T3VjaFZUbGZ2RXFFQ0dwNlNOcVJEN2FVblZkcVc1azdMVXYyR21yZmU4eUNY?=
 =?utf-8?B?WWYzb0hUQnkxSDdwandZbnRuWktJTWpER1B1d296cFA3Tzd1M2YwMm9YQzJU?=
 =?utf-8?B?U1FPR3doYmxEQWZyZ1pwMG13SlZmZWNEYmU3YmJiZ3Y1UVdFNlBsc290eHcr?=
 =?utf-8?B?VkdCMTczeUtGZ3dSS0VTcVEyZWE3Qmd3Yk9Vd0JuN0RDUXVJU2lUSnRUU0Yz?=
 =?utf-8?B?bENCQ1JmNUR3MHhSVWNlWVltZFJnVjZwUmN4OHhnaG1YTnJxcjMweHd0ejFY?=
 =?utf-8?B?cE1LSnFNQldReW9iOGNCbjNpZUpDaU54L1ErR3NaZStMQ21aaThDWmFpdGtT?=
 =?utf-8?B?bjg5aUVyZ2w5Z2NhbEgvK0xQaURMTk84SVdIbkR1bWRMQVFsK1ROQTFSaGJO?=
 =?utf-8?B?WDd4TDBJN3F1NDlvNVM4NmQ0T0o0WEN2NEFWNjN4Vlc1Z3pXTlN4dEdrNDlC?=
 =?utf-8?B?MVhjL0t0L2tQaWZPaUxuekNQVmU5M0RCVzNrU1g4VU93cTRJZVFSVGk0ay9L?=
 =?utf-8?B?NkFQbDRmSlpDbjVtT2E0bEdIOERMOSt5blhlaGZ3MFlVMGl6ZWlNQ2lVTElI?=
 =?utf-8?B?RVdVU040bGZST29GTWYyOWhDNEZFUnFnb0ZuRkRMTnlIMWNGTklMT2JVSitY?=
 =?utf-8?B?QW1GN3BEOE5xc2xDcnJCSGlPTFNUSSsrNEdRdkYvL0F4YWRyYzFiU284dGVC?=
 =?utf-8?B?VmRlcXJIVWdCVFVTQWJERTMxbXFYZUo1amF4QWw1V0wrdjEveit6a2Y3bGpx?=
 =?utf-8?B?N2FDT2N3eDB3QWNSSTlDd29TaEd4eGdsWHFtRFNGS29zbTY2bk1YdVRQekF0?=
 =?utf-8?B?WTRJM2o4cy9NNUNxbS9zc2pjN1VwaGJJWmdCRm1YZjRzdlVnL2U4QTVEajJm?=
 =?utf-8?B?OWxHRUhQL2ZDRkp1S2RPTlFncjdNN05JWjFVejhoSnVscy9BbnBpMEF6K3F6?=
 =?utf-8?B?bUFOd2JvdWQ3NURUVmQ3R2FUdlJPMmFOU01UZ2JXVXl5Q1o5K2E0VE9pZjFq?=
 =?utf-8?B?dzQ1T2R4Rzgxb29jKzJNbGEvSk0yalliZ3pEWEVaWmVjRmJTenZwVHEvNlNW?=
 =?utf-8?B?MExINzFoSG4rWmtjOUZjWmxOcHNIRGE1MDlYQWlVejFiZXhHQkRrMFZsY1Rj?=
 =?utf-8?B?ZGRaUlQ3NmVYNStiTlRlbVNqQWE2dDVDU0orV29IRG96R1JsNk9BM1F2Z09z?=
 =?utf-8?B?bmJHSEtOY25IaGt2dDg3WFNIZ1RVNnJBSnRRSDRYYzlZa3RZdElBSGphRGdh?=
 =?utf-8?Q?a5e/iVU6rCuN5izc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d2e94f-bcd5-47b2-fc58-08dedcaa4320
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:34:56.6885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/vcw0LkwYX+wPdulkJY11nRaItMqPWQVR0k/kQW1T+isUrlHXhOz0l0rcKvgHhU0Z9Tquai+laefbctdWxOMzRwSQcHN3aFfCkgs9cwbJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Replace socfpga_n5x_defconfig with the configuration from
> socfpga_n5x_atf_defconfig and remove the latter, making the
> ATF-based configuration the default for N5X.
>
> Add # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set to disable raw image
> support in SPL.
>
> Add # CONFIG_TOOLS_MKEFICAPSULE is not set to disable building the
> mkeficapsule tool and prevent build errors on hosts without GnuTLS.
>
> Also update socfpga_n5x_vab_defconfig to align with the new ATF-based
> socfpga_n5x_defconfig baseline. CONFIG_SOCFPGA_SECURE_VAB_AUTH is the
> only VAB-variant-specific addition; all other settings are shared with
> socfpga_n5x_defconfig.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   configs/socfpga_n5x_atf_defconfig | 89 ------------------------------
>   configs/socfpga_n5x_defconfig     | 20 ++++---
>   configs/socfpga_n5x_vab_defconfig | 90 +------------------------------
>   3 files changed, 14 insertions(+), 185 deletions(-)
>   delete mode 100644 configs/socfpga_n5x_atf_defconfig
>
> diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
> deleted file mode 100644
> index 674ba744614..00000000000
> --- a/configs/socfpga_n5x_atf_defconfig
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=400000000
> -CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x200000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> -CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> -CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> -CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
> -CONFIG_DM_RESET=y
> -CONFIG_SPL_STACK=0xffe3f000
> -CONFIG_SPL_TEXT_BASE=0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
> -CONFIG_SYS_BOOTM_LEN=0x2000000
> -CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
> -CONFIG_IDENT_STRING="socfpga_n5x"
> -CONFIG_SPL_FS_FAT=y
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
> -CONFIG_SYS_PBSIZE=2079
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> -CONFIG_SPL_CACHE=y
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
> -CONFIG_SPL_ATF=y
> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
> -CONFIG_CMD_MEMTEST=y
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_I2C=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_SPI=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_WDT=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_DWAPB_GPIO=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_DW=y
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> -CONFIG_MMC_DW=y
> -CONFIG_SPI_FLASH_SPANSION=y
> -CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_MII=y
> -CONFIG_PHY_MICREL=y
> -CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_SYS_NS16550_MEM32=y
> -CONFIG_SPI=y
> -CONFIG_CADENCE_QSPI=y
> -CONFIG_DESIGNWARE_SPI=y
> -CONFIG_USB=y
> -CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_DESIGNWARE_WATCHDOG=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_USE_TINY_PRINTF is not set
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_CRC32=y
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index 3b3916e676d..97c90656e7d 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -1,11 +1,11 @@
>   CONFIG_ARM=y
>   CONFIG_COUNTER_FREQUENCY=400000000
>   CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x1000
> +CONFIG_TEXT_BASE=0x200000
>   CONFIG_SYS_MALLOC_LEN=0x500000
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x200
> @@ -21,15 +21,19 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
>   CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
>   CONFIG_IDENT_STRING="socfpga_n5x"
>   CONFIG_SPL_FS_FAT=y
> -# CONFIG_PSCI_RESET is not set
>   CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
>   CONFIG_BOOTDELAY=5
>   CONFIG_USE_BOOTARGS=y
>   CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
>   CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
> +CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
>   CONFIG_SYS_PBSIZE=2079
>   CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
>   CONFIG_SPL_SYS_MALLOC=y
> @@ -38,7 +42,9 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
>   CONFIG_SPL_CACHE=y
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
>   CONFIG_HUSH_PARSER=y
>   CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
> @@ -56,10 +62,7 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_FAT=y
>   CONFIG_CMD_FS_GENERIC=y
> -# CONFIG_CMD_MTDPARTS is not set
>   CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_USE_BOOTFILE=y
> -CONFIG_BOOTFILE="Image"
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DWAPB_GPIO=y
> @@ -85,3 +88,4 @@ CONFIG_WDT=y
>   # CONFIG_SPL_USE_TINY_PRINTF is not set
>   CONFIG_PANIC_HANG=y
>   CONFIG_SPL_CRC32=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set
> diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
> index 817a01bbf51..3fe74846d01 100644
> --- a/configs/socfpga_n5x_vab_defconfig
> +++ b/configs/socfpga_n5x_vab_defconfig
> @@ -1,89 +1,3 @@
> -CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=400000000
> -CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x200000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> -CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> -CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> -CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
> -CONFIG_DM_RESET=y
> -CONFIG_SPL_STACK=0xffe3f000
> -CONFIG_SPL_TEXT_BASE=0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
> +#include <configs/socfpga_n5x_defconfig>
> +
>   CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
> -CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
> -CONFIG_IDENT_STRING="socfpga_n5x"
> -CONFIG_SPL_FS_FAT=y
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
> -CONFIG_SYS_PBSIZE=2079
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> -CONFIG_SPL_CACHE=y
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
> -CONFIG_SPL_ATF=y
> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
> -CONFIG_CMD_MEMTEST=y
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_I2C=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_SPI=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_WDT=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_DWAPB_GPIO=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_DW=y
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> -CONFIG_MMC_DW=y
> -CONFIG_SPI_FLASH_SPANSION=y
> -CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_MII=y
> -CONFIG_PHY_MICREL=y
> -CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_SYS_NS16550_MEM32=y
> -CONFIG_SPI=y
> -CONFIG_CADENCE_QSPI=y
> -CONFIG_DESIGNWARE_SPI=y
> -CONFIG_USB=y
> -CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_DESIGNWARE_WATCHDOG=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_USE_TINY_PRINTF is not set
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_CRC32=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

