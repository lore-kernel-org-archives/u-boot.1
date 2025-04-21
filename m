Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B398C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 06:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD72E81F69;
	Mon, 21 Apr 2025 08:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s7EFs//J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C51481F6B; Mon, 21 Apr 2025 08:34:30 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9D88129F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3GPXQZh3yloTZMYQC2LwBP9OZBMKmO5203HL36dtLZRFYDn6V1z6W3+3zcuYR1gBGBeNzCmthbom/JWCM0pheVkvdkgIsWsVFRp1lUQKKI5983Gohs2BKTGM4xzIp/5D48kXuBH07qOdchJkMLpuPCoDPAVFvcA/uvzz2ODUh2NlYAFeIAL2eCHddl46RAQB5ChFhRyb18ziobT4vzXiTyAZbNkCcPRSVdnXxEaE68zjUzDdNPTFYcs9ats0MIeRRhCLXfMroKgIrgeHvS0Rz1GNQI8AM4klWOosqFwbLc2Lk0TWDFr2qOKrNENp/YR2NB29+VdArQRxpnW58PEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqBZVFGpK53cgpAPLl8K3moJDhPuCoWS0ZQPIrk8pbA=;
 b=UcIhnnmOHMf30LzcYcUtm0+uktxwLWsH0feSC+c/PInfmlg43KXR/cZmFnmVL4wqhJFxtjkFoETUtta2yILCn8Vf8bAz9pSeZAKEAkvBE6Bdm1JCTQXiRlcN/FhHcVDhNmbdrOc48fKAFNCdmKoSSz6m7/cJc84j5d8d8+YQ3UvnpHJ4/y71axKMAz9ZDYxlUtKhHjxD742+txBr5I4DvpYScs1KBq8VhRRExCoRMUzp2+StDNnxpo5dajuTqHtI0pW1mJ1CN0dU40bFqiYzEEH/Ru+pdjukD+1IHr6mdbJAYRHN1XOrc9HfItR1m7ZEqaNM5L/a87HMIDFTBDkfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqBZVFGpK53cgpAPLl8K3moJDhPuCoWS0ZQPIrk8pbA=;
 b=s7EFs//J8NM2VQrHga79no/L20ismSMyZ2YAAZj+tA2xtIZ/L/oo7gllYWVlTdEAc7pbpqtdqYZVDR18cAzeUHJOfPWHnDYrDXkhrOHv7wMOhA7Q65NEgh88sXH9mFz2QEJBCJircb2LV0SIs/5qpwBpg3kIjEKBGDRu27SIjakFX7iiEwP3Fz2efXLXdsBp2HJy7AJ1u5XQqGa9rXjZUR5dqx/6Jgo6CZehZEsenK770L0rwruGqx5rI496j4WkKanCh/UgZCO5aozNRPg2YSX6F0gF5NjPZFJZZXjz6CUqyAYsA8pvNRcCimn7YIUTx/0ToEj2GVLokOOhVz7RRg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5500.namprd03.prod.outlook.com (2603:10b6:806:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 06:34:25 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 06:34:25 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 2/5] arm: socfpga: socfpga_soc64: Enable
 LMB_ARCH_MEM_MAP
Thread-Topic: [PATCH v1 2/5] arm: socfpga: socfpga_soc64: Enable
 LMB_ARCH_MEM_MAP
Thread-Index: AQHbsnwf68Zfst/J/UWKYW1CW4agVbOtqdkA
Date: Mon, 21 Apr 2025 06:34:25 +0000
Message-ID: <LV8PR03MB8137996EC3ECFC5000C0DCF4A7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250421051245.21385-1-tingting.meng@altera.com>
In-Reply-To: <20250421051245.21385-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA0PR03MB5500:EE_
x-ms-office365-filtering-correlation-id: 96637149-74be-47f0-2ba4-08dd809e8f89
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nW71aBIJYPgFEwm73hh/JqJlZEN3PPEQ3QFMeF7Dd8M17s6ONCkchnumgvn2?=
 =?us-ascii?Q?8EV+H2tNLZ9HfgunNA6Ai/tLUlT6QtpjhV7YJO3GxgKeoWQMHjf1+MzmwWLQ?=
 =?us-ascii?Q?ILfQ+huKi9xJz5G7w3O0ydQRdJnPa9P/qIvLRdREFMomrOEy2W6eYvKB3Jau?=
 =?us-ascii?Q?+wHQ33c3URHB+jqGY6htxOAMigTSw3GCkmMc8JXN1pHv+tsVf/5kJstnoYKs?=
 =?us-ascii?Q?JUH3npG4Ob4WHUN0+i4VC6/5Q8bt01k7a2JSvEjWCCF6cSPh2xJQdYyGqVYJ?=
 =?us-ascii?Q?89A6EghZsrmykYEddf28oMK4xv+XhSDyRBn6Cyba0wN1c1eBiPhcMBzPWRY8?=
 =?us-ascii?Q?oM6KAtikD8WYACsMVk/DxD2T4fso5CsNrkjA0dCInNTzP+Yc9fnorAduNDd5?=
 =?us-ascii?Q?PU6pRd+YT9ue5+5Aho3O1HwlRp1gvlVqeeqWdOzgWpFVT1nLMUTWPvC9wxc8?=
 =?us-ascii?Q?Tgx4f+4xh4J5D3zWQgDhso4gbpLHCOBSP6uBPiTKUzvE/llI+diGu6Bs4Out?=
 =?us-ascii?Q?lBCJNduJ39NUFRcNZe73weqCjg5YMhBr0RDZO4/lw/VL8/+9/2lbWDEKpjhm?=
 =?us-ascii?Q?7mmZrUf+ldvO1gghk+xkKd6cQGtWFkuWj0QdV7n05bo6HiF8I/TMX+yNhDyv?=
 =?us-ascii?Q?TjNT5+lUtVEmpzkmp90uCxFo825UZlQpaGa0Zy6MEc9KA2Xl/hp3Svh/dPfM?=
 =?us-ascii?Q?kCQV2Iun1/N9DArWnwWmgo3iqQQXV36unWvNKJunrO5441QwPgyrn3oaHvX+?=
 =?us-ascii?Q?fg13pgmUg6nQral3SNmfgY005LO7SQgIZ4p5Eon2/eStq+ZUk92wk8b99ifY?=
 =?us-ascii?Q?xk2r0OYaltAdHNzZvF9MhrQUhsPaTjXdbI0qclDrm+16zd5DdZLU+YicHNjU?=
 =?us-ascii?Q?oemZ3WmA7Og6xKTrSsqTzzvMfOYB1cx8O+FfGVmBqPX70zGM56NCTAv3tMRA?=
 =?us-ascii?Q?oMQTsK9yMkXMCuhtFqSl5h6UO6hKV5OsFPOclXeUk+BLxBUU9L6+dfOXDSIh?=
 =?us-ascii?Q?F6d6/Y5bvYWNHyyFJ4y0LBkKb2uTluf3YEXD2uJDvVM73kcLCV8d3pjcsHT0?=
 =?us-ascii?Q?3Zgu+I0jSdS1sBzB8S5delsSUXm3JaLEV+L2jUEGXJ+BK0JEseTYrU/oxPuK?=
 =?us-ascii?Q?eG+xJd8J+CdtJTqsCocZvl8Zd7ALdHsJZLDChGZ3E+3WSQVIYxj/mQqYmmg+?=
 =?us-ascii?Q?BzcIsF+/zCuNa+zVCk/HT4hSxFRn617iZrVrbVIP/UGG/dgwYT8dfMC1389k?=
 =?us-ascii?Q?4rDyFax2B9fX4l91Sw33NDLk46Q/ZIfODZGZYSZArVbTYQ0DWRWgn24mvYTs?=
 =?us-ascii?Q?/6AZdcVP+x3xabgKhViFP0uJmNODdc8tuBuIb9irsSeeWWT70qQPFL1DB38n?=
 =?us-ascii?Q?7lMyhC4qj1vbJbc2fatpeZxPMGP+OQGPo9jhUcS1j/J2590GIs0sBIwTSU4u?=
 =?us-ascii?Q?28dd1J9sANXzeRrtByFpxlcQge0tGoXuu9Dc2Voh/6/z/VNNUIlhXTpI3PM9?=
 =?us-ascii?Q?DpO05isRh2OBvGE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KOShe61IQqStkTeSTW83mmqgpeP4stSVAq6Fg3mTiNTV/4gO9kxkVJqmRMTD?=
 =?us-ascii?Q?kjIX/CcXGPVuzmJHvJKtOdfjm7iWCsap495o/F37KlQHt0WPrjLj4rEWRs68?=
 =?us-ascii?Q?SD95sj1UITjQHLmNrng6ansy3hxkTFVk6XLcApb3voNBoDroG28OevRnr3Gd?=
 =?us-ascii?Q?T9xTyFxETJUQa7l1m7TAhcu8MxUaDXx8/8Y4DnIG+BmLGMhln6hVuobEIhNy?=
 =?us-ascii?Q?YB1lgacZXWWYrhpf53iEcQdTuRxeoidcMYYV+L1uF7O+fh1TjOL2QgYObJ5M?=
 =?us-ascii?Q?DuyRNR3rRQEY8yvxZsxshtF4jsLEwJB76QHzZC055lauJBboqsReJ7zoNApF?=
 =?us-ascii?Q?0BGWvZlQdhWnhEty7+uGYao+DAaQ6cdWJmqQdRLh3Hvzf3BmYkLR6P8+mEtU?=
 =?us-ascii?Q?V+9+cCu6lPQBdx5NFPstKaLZC7hJ5cGVRUhFaYtlgOXcPKdgOaPScFkt68dj?=
 =?us-ascii?Q?L8s0AXwz72UtETGU3qKbjdgPLKzs5tRWWP29M4EL347/Af6XKhOE8Q0qoQGV?=
 =?us-ascii?Q?tMU9pxZCs8FzhvcVHfve/anciIGG4NWp9qEXRefduG3eYYVuB/l9kdL84nqO?=
 =?us-ascii?Q?WVUHrGbvpY0jw0tLNLgUn4qpK+UETMrBdQvTdismvGefghPwFOqXiZad+TCA?=
 =?us-ascii?Q?hGtHW9vfFAEBUL4+59kYJteg6PtD6VvuLc0gyc6p5hj4qPRZPIuixyCFJHGD?=
 =?us-ascii?Q?v97TNipUg3a7xmV+p2SMZR+AZmCZCqMjtfOkRj2U/MvymxE65jNq3Pi9IgC4?=
 =?us-ascii?Q?oLRuK+8e/rwxejkY/wuSaoihlXygLyAVwUdIkJw8Zf6i1jE/5d+7htrdwVlq?=
 =?us-ascii?Q?DuIE7dlnXb1DI1nkAE/GPCGzBm0N633EGNYPRPbEIkokmG88pxLCR3jIENrN?=
 =?us-ascii?Q?vcV61mEtI81DRIzpVZdh6NBeH9UjkC72n/XeI8inzOC3MlHP1ykv1Ibnpvyp?=
 =?us-ascii?Q?5RNwBdWxxm9gi8CYHp0mcj8X7sOStHo24glEtvA9AZi/ZkCdGgi1JbU0NdSW?=
 =?us-ascii?Q?9+Bkgp5gumTzoxbljD8fCqY/h/3naq06FzmCjlyQvdFOWBw/x9mDc0j+HE+K?=
 =?us-ascii?Q?oJwyXJjb6Zxye38AdaErEf76eOA0VmGwwHrinsU6G398KU+Buf1X6UuX3xl8?=
 =?us-ascii?Q?gcGOhtzAg5k/7zTxZOY1+KSgpoYHoZFQO6B3al3U7GGaR1Ne1YJh+oIvsjMf?=
 =?us-ascii?Q?UNizSGGwRzxadEgWYIzIlorsqBEe1WWU09dSoJYwWkN/8uvsoWNeeJS474J0?=
 =?us-ascii?Q?Hyj5jX/zxKbcLocZiBBB111ehEVC7PWDNde+z/r0/JWT4jbhIk8p5dhgjFf9?=
 =?us-ascii?Q?Uc+e8ojkl3oT3yHgZL/cv5sMwWW9qTfIT1966H0aRzs0r62s6S5KCk+6aA54?=
 =?us-ascii?Q?0D1a/g/x1Utj1s6BT4zuF80HRPzqXpUsQwkf/jUUVS6rE/6z1ezVVWZfDbWa?=
 =?us-ascii?Q?tgAzE6/f2U0fRRXFOXH8HJHHzWP5LKKgFi4ZuqphYrwJBdEa66YVMmvR6OXR?=
 =?us-ascii?Q?8Vx4nH5pn67RGe55NSyPz0wF1Yny5XVy1JAQbCxdWWaRFTgLZmwKNwqwZ5oo?=
 =?us-ascii?Q?L6Py5DfFiza5YLAvFHe/l61XqL16+WD5gI72VuJf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96637149-74be-47f0-2ba4-08dd809e8f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:34:25.7552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEp+2+vbS13jyrBg6Mf92i2YSGKYqFXFnDCdmqGYejCrguZiAqaWDsOY3lSzpLbiDU5LUoabCWNpBTIK9fH1eYpfMbC1DANh+RKAkFyEYYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5500
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



> -----Original Message-----
> From: Meng, Tingting <tingting.meng@altera.com>
> Sent: Monday, April 21, 2025 1:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 2/5] arm: socfpga: socfpga_soc64: Enable
> LMB_ARCH_MEM_MAP
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> LMB_ARCH_MEM_MAP is enabled, and lmb_arch_add_memory() is
> introduced to correctly handle memory reservations for the second and thi=
rd
> DDR memory banks.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  arch/arm/Kconfig              |  1 +
>  arch/arm/mach-socfpga/board.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> 83f6cb6edcc..df373d38a55 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1138,6 +1138,7 @@ config ARCH_SOCFPGA
>  	select DM_SERIAL
>  	select GPIO_EXTRA_HEADER
>  	select ENABLE_ARM_SOC_BOOT0_HOOK if
> TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> +	select LMB_ARCH_MEM_MAP if TARGET_SOCFPGA_SOC64
>  	select OF_CONTROL
>  	select SPL_DM_RESET if DM_RESET
>  	select SPL_DM_SERIAL
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-
> socfpga/board.c index 27072e53135..8506d510413 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -195,3 +195,16 @@ void board_prep_linux(struct bootm_headers
> *images)
>  	}
>  }
>  #endif
> +
> +#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
> +void lmb_arch_add_memory(void)
> +{
> +	int i;
> +	struct bd_info *bd =3D gd->bd;
> +
> +	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		if (bd->bi_dram[i].size)
> +			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
> +	}
> +}
> +#endif
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

