Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB17BCD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 04:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E772840ED;
	Fri,  5 Jun 2026 06:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TEeodwqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADED84715; Fri,  5 Jun 2026 06:56:36 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B6F83EF9
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 06:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgsi6b43duF/l4Em3lJYx9Fnnzl1gvIdgf3qakQYPiFDAjJNm0l+9IZBtlOH6JFou1Plld7C598bgc4PxwzmRKCSdMcbU0qGTVLC5G+XnJXMaSg6bvH+AM9p+wuD/xQxtk0mA0e/JfwzLS6ZbBOaTkb2DPbdQoA5zAy0fyQclOPEN6LXEoaNqxBXGwE5JfcHfAUlitdkMxEfqB+Geq4b9j1Qf3WQTYzr0AdDHMh5Q63l/2zrReroBZCmnda55yN5JR9gOfBLNQciEvDXTfSxB0N0zWlC8q8G69wf1xkUwFYC7WjBfjLOa49sBP7Si+5keYH0h0L0yO34cjv0ARvQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31+/M1EFVcEsNu+RglorGJ/4uiI2TksKvRo+kQ94bUQ=;
 b=rMZau+z0AqrImX2hFIzlJCZWLPX0puKSa3m6WsNpThOk2z443aFt9JwXu5WXztoljmITPhQuh+9Jnn2+cYBdGZ8CZ4CjWjI4Wfu+6OXCbiqlWmonudzJg+wxmj1wlPo2n0FKFiBN1uZKvDi3LRaT4O8ydrM5Y7XBaWk6gaupVYByR9aW7z8vjzzuQFK0HPGmnMpFqTFlgJO+QeUMQKQ/wYD1vL1zh9KOT4FzEiDsgtSMt8BXqQcvhWeeA0erVxmQZZzRjv20GThajFwjnJlDVHnRuiwr3/RKLvrQauBjzm0ZY5CPr83cXG29gp3omV/lXQ+ldax/vD5qbTSvXme3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31+/M1EFVcEsNu+RglorGJ/4uiI2TksKvRo+kQ94bUQ=;
 b=TEeodwqq81/4rOnsWLxZJyatB8sce1Zw2cT5bnZRlMwqwvs322OY8Yvf+YQ2a3+aUaVpFQ01BsousjrUHayrukOh9A8bYxCkRRMJWjaspNrNRZf+/vRt6sjAKZoaNGodUs90vkaKWmOG6R/tTm1gLD0KM0q0h01haX4nxAJ6AQ7JCrwAF3HzgRdWKCPpsUW0WCreph0MM8frFk/jypHlaOQkeMk5CFB2C4TLasonbT9lLfOgEKiPNJAgPnK4pewcQUce6Gw5xPyQVeCGP95xwBR3TN/Rfzw/k69Mps3ohjyjwstdWD2VL7Zjc9MiozGG9Ol6T/HHVKifjSFTqSmXLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8SPRMB0073.namprd03.prod.outlook.com (2603:10b6:408:242::19)
 by PH0PR03MB6543.namprd03.prod.outlook.com (2603:10b6:510:b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 04:56:29 +0000
Received: from LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a]) by LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 04:56:28 +0000
Message-ID: <47e3b753-e0c8-4218-a427-020d0ec06c15@altera.com>
Date: Fri, 5 Jun 2026 12:56:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support
 for both Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To LV8SPRMB0073.namprd03.prod.outlook.com
 (2603:10b6:408:242::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0073:EE_|PH0PR03MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 05479136-2994-4582-42d0-08dec2becdc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|13003099007|55112099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: dWnFw9ELWMXyx1yBhFCueLbg6VQfmIO1EmGQLlooahiRCqC4iKc4OIbqeQCle3mnwmvkU/YYzpdYMVVRCUA3nTrXWFlncm+0X/C1juPD5Awgz7M8W7FxNcZypm5Lp4S1JYqGgutraoLqDoS/VfOq/MgPlC5h+8o7GK2lPQNRsfHcS/6hWTYUs7D2vOekNjBLDyEI4mY6S3+TbN6BJdRHmY2DHaEiLeB0FEZ5LZtmzB7x9xRio10HjqctnV5ZPX3/BXfYtprOuR5rrOJej434JzD0yrUmQ3W3IgYAB6TUpHYfbcRv+nejbNeY5FuqLseAcnW8tSsQXXsHwz/JtRDjyaK5w6a2rnFOOgGq0ChoDzIi4GswK6j7XGW+/g7OaIh8pBj/8YYSjTWuwTrQ93HD5ygGBbXAG5w6qs0hfklDyXn0AhyGmU5T9A/dUjYjTWMXvFKOmX41Y5STf9KPRQuYdyAsJtw/eSwgy9/LlFiAvuoDR+HBIPE034u9h+gNudnJw3rPoSr5/bAQ7EhW2WA13EylaMDDGuP3i0+T0b288QuG+jNnW6+6xTjvOyxjzaGElKSH84a1HUQl92H5uNa56oZ/Xxz6Efzn5jjFkz4jeksEUU2gSHp7/E5mR2wl+6aZYfjpZb50T0gmum4ues53WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(13003099007)(55112099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1lRN0Y4Nm1CVW9kV3RkcDRFc083TUlrSGU5RUVEQnVpQ2pJZ0ZSR0pyVWpp?=
 =?utf-8?B?RXJTZzRXV1hDKzNBTG0rOGE5czdIcy9ZbU9FRUU2cE1BVjk2S00xVVU1czBK?=
 =?utf-8?B?RUVORENhUTZMeWsvTW51Uy9odHFVWGV3WlNzMXZTMXMwS2E3OEZ6UXliK0hX?=
 =?utf-8?B?amM5NmFpbENBWWsvZ0pEUDlTVVZFbXl6YnhDbDBsSWdKTEVDWGJLS09QSFZ5?=
 =?utf-8?B?cVovWkVENktMZURHSkVGZHpmVVFrYTA3TkpNczRyK1dscHJOSGQvOGZYQzZC?=
 =?utf-8?B?eXUvYU40TUZ5cTFsUlM3QnZYR3JhVEdoT080eVVQTUFLYUJFaU9HbzlvS1hp?=
 =?utf-8?B?cnd4TTNYTHBwRnA1eW41M0ppT2tlQy9PY0tPM3liWGhqYjJ5S0NKc0FvSFdO?=
 =?utf-8?B?d2hpTjhmelcvZzNXMWRVenovMXg5UmE0V2hIa3ZxRXVGZnJjNW5JZkZvZU5l?=
 =?utf-8?B?cjEzZ05uV29GaFJCN28wRFZid1IzNWNIQk5RbjdWcEFhYkFmUEFqOW9QckxT?=
 =?utf-8?B?MTQzMlZ1c2JWMEpGL1JLaFgzLzNyV2NGTXBWa25oVzBXNDlnNStycy9WRlJJ?=
 =?utf-8?B?YWJOcE5PNzFiUHNVeU1jQm5NSmdodFFod2h0WVdGUkxnMHJaZy9XanRDRWZI?=
 =?utf-8?B?bjRCd0NGcFordnpqbmRZazk0NFh4WkwzOSs0bVA2OHZiYWZhNnNMY0FOOEZF?=
 =?utf-8?B?QU1SZFFVeER3dVVPbGYzV2NoNHlkQVZyM00vaFdBN2RsQi9nSDF5d2d0N1dM?=
 =?utf-8?B?a3Yrd01PWjd2WlZvQkYxNHROM1l5T0EyT3EvcTZKNVR0eXo4aUxRQWxOSFcv?=
 =?utf-8?B?a09wK3pKdlRjZzM1azAyVFZkUFRVbVNHTU84WnN3TlYxVU5lVFJYL3VwdXFB?=
 =?utf-8?B?VGNlWnQyb3ZTZFhzL1pCaXNMQm1tQ2g0WkhuNGZNNWk1b21aZEM4bzBuY2tJ?=
 =?utf-8?B?aU1KN3BYTVMyZ2NTTU1hSGE1U3VqUzZNb201bGJOakp3VU1xREVNVGhPNENh?=
 =?utf-8?B?SFkvMEgyRGlla0htaUNuaW5DT0ordTZjeS9naXVRZnJYK0IzSHh1M3M0VXUx?=
 =?utf-8?B?dnQ1NDVycnpvWlJzWW9BQ0tnanpuNkRQc3h6bzZua0JYdVYyMzgyV1NVelJs?=
 =?utf-8?B?MDBoTCt2QUFvNzdBOWltbkJUME5jM01paVJ3K1RGbXEyWlBHdFlVeW5ZV3h0?=
 =?utf-8?B?enE3T3UrTjhrY01GUXgvSW52b3ljN3AvbFhmTmZjcjhGaktnSHZSVDNnbWZW?=
 =?utf-8?B?dmdQYVplRk5FSWpDZXF2ZDNXWGhnTDdiQU5ETWovejlvcndPeGtmekdUK25Q?=
 =?utf-8?B?S2dzYUtFb0hURVJnZzRvR1c4eDFzTytYTGV6ZnpGc0JXeFVNbUk0Wno5SzNi?=
 =?utf-8?B?NDR1U2JmbXd0WCsyY3JlMXNPaDhsU2JuWVZGZXIxUkl1YlloWDVpNkU5bHJs?=
 =?utf-8?B?RkRuY3pEaFVXdDZXWXRoZWdFVXJYbkQ4MzBqZ0o3ekw0UXgvc0JOQmdkOU8w?=
 =?utf-8?B?OXloOHlrU0JJdTBsWXpDRDN4NHRtL093aHpMRkwreW9zdkRyT2tCbXh0eFVr?=
 =?utf-8?B?QkNlbEE5Z2cyZEFUMiszS1RBbGFwWmVVNy9MUS80RWNBVWNrSE85alJ3QXVW?=
 =?utf-8?B?SXg2aWhsWng3VEZrQjQ4Y0V0RXpEbm1xQVVxaHMyWEZBTWU1ekZYVjBSQ1Fs?=
 =?utf-8?B?d29wZEdndUVHRzE2R2FFbE9NandmQ2gzMERaMkFzcXBWcFhYMXFLU01SQi9M?=
 =?utf-8?B?aFNVQWFOSXhKeTRTWDBpSDBzbVd1eUFYdXJ5WkEyZUhqVzNzaHZiVUY4T0pM?=
 =?utf-8?B?UnRKcUpEaXIwWDRWeFJUZ2xmajY1Z09YQkpIUXN1YmJ1TUgyN01TbExSUktS?=
 =?utf-8?B?a1pnRWNRakFJcmhwaEd2Tjh5S2Mreld3U2xkSitaQStWcEhoUlVNSmVyZjJk?=
 =?utf-8?B?VFBWQitMNERwUGpRbjNHc203cCt2RXYzdmdRS3RHditDdmxjRTZxTXc2dW5W?=
 =?utf-8?B?a3FVSkw1T2ZwajZpTVhjUnVxUTVMWDArTVhmNXVrUTN1TnhUd1U4OUZXZ2Y5?=
 =?utf-8?B?QlNUR0RFSW1lMlRWQ0NaaXlWb0hkTXplOUFnYnhpMGlFYTFTY2dwa2dNSHhI?=
 =?utf-8?B?T201SjNLV0NFZmRUVTNRSHRsbmJmODg3SUlyV2tPajFJTjM2cWNnZ1FRMExO?=
 =?utf-8?B?SDY5V1hPQXNXNFZQY0lnWWNjV1UrMDRwRTV4Q1Z2RFBaTmxwMnF5Y05XY3cr?=
 =?utf-8?B?S0pQd1lSQVBnRmpQTWlqSSs2SjM5Y0VncEJiSkw1N3owT3RhcVhRRFBVUlZ1?=
 =?utf-8?B?SUd5UGErWUkzZm0wOVlubXJScFo0cUEyTHY3eU5nMWtyN1VQaU9nT29MazZ6?=
 =?utf-8?Q?pV+6mMoOezIv2lhg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05479136-2994-4582-42d0-08dec2becdc3
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:56:28.8399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acu3EX/DHlRp8v6URC0aL9R+xcXxBwYH6nNoZrLdiVWauk6s5hdHyAhob/ReFFaWfcLdSjhoqfZ3VuW8PDf9Sza657HAyPWslgYwjO5LVRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6543
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


On 12/5/2026 2:49 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable ECC scrubbing support for Gen5 by moving sdram_init_ecc_bits() from
> sdram_arria10.c to a new common file, sdram_soc32.c which is shared by both
> Arria10 and Gen5 devices. This makes ECC scrubbing support no longer
> exclusive only to Arria10.
>
> New Kconfig is introduced to enable this implementation only on the default
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Updated commit message
> - Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Arria10
> - Dead code cleanups, indentation fixes
>
> Changes in v2:
> - ECC scrubbing is set as optional via Kconfig and defaulted on only for
>    the reference Arria10/CycloneV boards to avoid SPL overflows on
>    size-limited Gen5 defconfigs.
>
>   arch/arm/mach-socfpga/Kconfig      | 12 +++++
>   arch/arm/mach-socfpga/spl_a10.c    | 11 ++--
>   arch/arm/mach-socfpga/spl_gen5.c   | 10 +++-
>   drivers/ddr/altera/Makefile        |  4 +-
>   drivers/ddr/altera/sdram_arria10.c | 31 ++++-------
>   drivers/ddr/altera/sdram_gen5.c    | 39 ++++++++++++--
>   drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>   8 files changed, 172 insertions(+), 35 deletions(-)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index b814e034ecd..dd71691b724 100644
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
> @@ -124,6 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>   config ARCH_SOCFPGA_GEN5
>   	bool
>   	select SPL_ALTERA_SDRAM
> +	select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>   	imply FPGA_SOCFPGA
>   	imply SPL_SIZE_LIMIT_SUBTRACT_GD
>   	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c20376f7f8e..0d0412d3507 100644
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
> @@ -265,14 +266,8 @@ void board_init_f(ulong dummy)
>   	/* Configure the clock based on handoff */
>   	cm_basic_init(gd->fdt_blob);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* release osc1 watchdog timer 0 from reset */
> -	socfpga_reset_deassert_osc1wd0();
> -
> -	/* reconfigure and enable the watchdog */
> -	hw_watchdog_init();
> -	schedule();
> -#endif /* CONFIG_HW_WATCHDOG */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
>   
>   	config_dedicated_pins(gd->fdt_blob);
>   	schedule();
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index a9825173189..530863b1564 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -22,12 +22,14 @@
>   #include <debug_uart.h>
>   #include <fdtdec.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   #include <linux/bitops.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   static struct bd_info bdata __attribute__ ((section(".data")));
>   #endif
>   
> @@ -113,6 +115,9 @@ void board_init_f(ulong dummy)
>   	if (cm_basic_init(cm_default_cfg))
>   		hang();
>   
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   	/* Enable bootrom to configure IOs. */
>   	sysmgr_config_warmrstcfgio(1);
>   
> @@ -150,7 +155,8 @@ void board_init_f(ulong dummy)
>   	/* enable console uart printing */
>   	preloader_console_init();
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   	gd->bd = &bdata;
>   #endif
>   
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
> index c281f711fdf..ac5d3f03f05 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -22,6 +22,8 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include "sdram_soc32.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -193,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
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
> @@ -735,8 +719,15 @@ int ddr_calibration_sequence(void)
>   	if (of_sdram_firewall_setup(gd->fdt_blob))
>   		puts("FW: Error Configuring Firewall\n");
>   
> -	if (sdram_is_ecc_enabled())
> -		sdram_init_ecc_bits(gd->ram_size);
> +	if (sdram_is_ecc_enabled()) {
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +		sdram_init_ecc_bits();
> +#else
> +		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
> +		puts("ECC is enabled.\n");
> +		hang();
> +#endif
> +	}
>   
>   	sdram_size_check();
>   
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 1c3c70ea8ae..9c58e4355ae 100644
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
> @@ -19,8 +20,9 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
> -
> +#include <linux/sizes.h>
>   #include "sequencer.h"
> +#include "sdram_soc32.h"
>   
>   #ifdef CONFIG_XPL_BUILD
>   
> @@ -566,6 +568,19 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
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
> +	return 0;
> +}
> +#endif
> +
>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>   {
>   	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
> @@ -608,10 +623,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	/* setup the dram info within bd */
>   	dram_init_banksize();
> +#endif
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   	if (sdram_size != gd->bd->bi_dram[0].size) {
>   		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
>   		       (ulong)(gd->bd->bi_dram[0].size >> 20));
> @@ -626,8 +644,23 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
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
> +	}
> +
>   	/* Sanity check ensure correct SDRAM size specified */
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>   	    gd->bd->bi_dram[0].size) {
>   #else
> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
> new file mode 100644
> index 00000000000..2fc06fddd4c
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include "sdram_soc32.h"
> +#include <string.h>
> +#include <hang.h>
> +#include <linux/sizes.h>
> +#include <cpu_func.h>
> +#include <watchdog.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
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
> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)


note in commit that legacy HW_WATCHDOG path was removed in v3


> +	/*
> +	 * No watchdog driver is active in U-Boot. The bootrom or a
> +	 * previous boot stage may have left L4WD0 running. Assert and
> +	 * deassert its reset to stop it before the long ECC scrub,
> +	 * preventing a spurious watchdog reset during DDR init.
> +	*/


checkpatch BLOCK_COMMENT_STYLE on */


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
> +		/* Service DM watchdog cyclic callbacks */
> +		schedule();
> +	}
> +
> +	dcache_disable();
> +
> +	printf("DDRCAL: SDRAM-ECC initialized success with %u ms\n",


  “initialized success” → “initialized successfully”

Best regards,

Tien Fong

