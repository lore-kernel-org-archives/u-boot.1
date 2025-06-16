Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A21AC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 04:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0809C801BE;
	Mon, 16 Jun 2025 06:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="w+jAc6to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B613806D8; Mon, 16 Jun 2025 06:33:00 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271B58007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoEq2m/UhTRjsBCyXBrq2dMwVzC2mDKKUCH1WuI8HMdEA0QNj1Z30qPK1iNYpUSemExVQhLmFB4ReVwCopTWX354ZGueoTmBLS40H7HlKK0CHfmD0eGGNHQQGuGiXXMIqoNYnKHOXm9g08I/WYwFES8nFmeA/de+Eqj1jQZmxeYW/6V2n4l9EaDcT915ArQhDvM3egU0aasyIacYqSGvePhMX0dsOO30S4ckVIZM/ZXX5Us7Zl+q7aHek90g9QayfXUXSxXTTPjfJqwn/Hl4oWdNNhufYPYVLCBzD+5vWjm5zVpF9XXN4gOb55v5vDAKZKke7owLhZX6mAXaj7LKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2GpEbJySx1Ubm9vOzlyooxVm2IXdPWMBa6T0++snZk=;
 b=yA5YLilBYyuKvw6cAcg8sNx64In4bfxHVWZpC/Pf9zksc/njEcPRQl8j0vEUSYQbrsZiEVb8Gx12AIk/RhwfBH5KQMWoX1urafKPdFXIclLqxw7DbF6+/C0D2HD8pj0ox78szzjKMkB66fHdtI//fg3n2R0KO4kDXKTY5rH1vx2dUPWXhY7ibEMmGTKXrM4DGFxmNFVgFoNCvmLL8PK8pAeQ2vE4d7+Q/jkS+Z0ZSJRsvhzcVGHEAxGmK3m3mzoDLpp5v8Qem8PxqEQYlUJoZaGUJubG6A9wX2pqzlqxoSjigEJDm0AYeqJnRnVhe9X5NC1asyRqZtF7SGpT87C1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2GpEbJySx1Ubm9vOzlyooxVm2IXdPWMBa6T0++snZk=;
 b=w+jAc6toB7CU7J/ocCLsmuobArPWTOiL55A6ewfDbYPjkIbWQQClHRg51KZxt++hJFAa0mM6zLfcsD09V3AJtY382xF0ULmfNHJd9WUAE5m2pOct5iMAl6Atu2TObzJwsG+hmfVINpP14xpZIwvtI7M/8Gb7V0nLR2ofjIMJOaeJzFQkBlRBf5pLln+5o33p94adKMPXLjbL9hzgx72Gixvx1sCn71MqqHnL2a8wFazVPDTn7X7vTirYoOIX21UBqv9fJrQEy8H6xrC8kh6tXNOQf0nQbtoR8nLK8wp766iknZVgeFpWepSukeTgjBtBJDz0SJ6zi3qDgD98g0oZgg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB5830.namprd03.prod.outlook.com (2603:10b6:510:38::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 04:32:52 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 04:32:52 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1] arch: arm: agilex5: Enable power manager for Agilex5
Thread-Topic: [PATCH v1] arch: arm: agilex5: Enable power manager for Agilex5
Thread-Index: AQHb23ElaHF9NZsV4Eqhq93VFBm7BrQFOHrw
Date: Mon, 16 Jun 2025 04:32:52 +0000
Message-ID: <LV8PR03MB8137E7EEAAE8B9E1C9AF08CAA770A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250612080800.19712-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250612080800.19712-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH0PR03MB5830:EE_
x-ms-office365-filtering-correlation-id: 6b4ce9f4-3cc3-4d88-b836-08ddac8edb95
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VjIom9VIJ892m3ApMLHpTyQthxSmeJWPm+sInJEu9qlYSm9ZhmIHwhz1r4Iw?=
 =?us-ascii?Q?fy7jvgBFq+pxZ5DUJCGsu69ZrgE34owQfDMSyiPPuBqeF44MwEfCi28zAT7O?=
 =?us-ascii?Q?EmDQ9Hu5l9ljEFhpTWyOaFY5s9+TctSR+uZwZZee69IARRTzmFYBSQ+wBU+n?=
 =?us-ascii?Q?/44xLspIp5eh3T5Ux1SKaIqJ4hnGvEXZl2ZaDSyoOwww+vRtH0QRCQvV8htC?=
 =?us-ascii?Q?5qUlrqfsKaub70X1/3M50x6y1mZuUOKyMc1h1kw0hEMVUN1YZVaTD9baCv0S?=
 =?us-ascii?Q?b0q5s1tXlB1eDGzXikBQE8c4rWQ7lWra7QOMmKOe3XE0pFKexZweVlSRG9B7?=
 =?us-ascii?Q?cXl2/w/sLYS94LSbG7gNVisxvpaRgpqEie/msnttdjgbtqaTVCBzq+0kQyRL?=
 =?us-ascii?Q?0S9NFRf0sodCFPO1NyYM9MMwrA6+Zibu/2vEpkdvcOKxvG2dGoA0clBsscbb?=
 =?us-ascii?Q?gX78UerWvgCn+DH4wAHm+hVc2IJLmy4Ve6nCHkIwR+QsTAOAqsF4X6pbnRm9?=
 =?us-ascii?Q?x3pq61KGkihlN8VItqnYGFEEyVtrItEUzGsKh63Yn69lcfiLa0nov3VcrC2+?=
 =?us-ascii?Q?OZym9FYZMUsBIpWJ6Alo+NOWGrUoxUjSCk4K+Dkya52hV05LwY89I/AKbltz?=
 =?us-ascii?Q?Hk6TGgDN+ri9QfdXVAym/seQQxwTZ/j27mCNcQL/ty62TFzv/isSoPXU9+LX?=
 =?us-ascii?Q?TpbMpfiCl5B3FW7UK5bx1K7CDJxhe3+c/W1bUBlQnZdW+q8oEY+1mFFYqre3?=
 =?us-ascii?Q?bFW6Rc+ZarrGddSIx2m/K1xxh2kv2th0a03qV816lPo/9rFcgZ1VrhnHiIGc?=
 =?us-ascii?Q?ELUHpvLbDKc9QjuTnMypvSMDo/PqSnl87fCESbM+17+Hz3LOvsM6araW+O7X?=
 =?us-ascii?Q?XCS/pk5dxNrIJq/a9oLka3GujGxhBALj/q6kLtxxuMfeE4isf8pfiVN5t65q?=
 =?us-ascii?Q?fQIZEjaY3oK8NrDArl5wEnS6/Dj1Ju+dAYoilANs6SGdVzhL3gSeyx5U59Rv?=
 =?us-ascii?Q?Z9jv+KOqQ/GkbG0K9tuVDst4Pd9b5eFdgMhVyVpigXhyGZ5nEmqDITqPIy24?=
 =?us-ascii?Q?TKMA0K3P+nivmDg/ozHej7Mm7yvsb4flnJjmVzwTdOam0VzQGYiaORk7FyqO?=
 =?us-ascii?Q?qEKZvdwuIKPpSYg9hBeae1qU3OmvFlDIHk4oAIVQVvsJVU2lFA9lhvn8UrFh?=
 =?us-ascii?Q?JHXIfehTssqP2ugcPqJ4tPJoWb2FWl2w6sUbineByL8HYvD3njc9+THQnCcW?=
 =?us-ascii?Q?+QsAbAnG2vIdQRm+IPtvLBYmVJtLZYEM3yvYeSWqLnr+kMz5ZlBdjs3e+cMz?=
 =?us-ascii?Q?PF686dAcEoCP/jfV4O/aQeymDYOTkQuEJpjJEt0v9DxRwago7kaHQiVF9nBS?=
 =?us-ascii?Q?6BD9Yfi5yfWlrMz5aeHqS82RSyq4XB5M8ieTRCVRUzZfzkqqTC3TWkZyW0e5?=
 =?us-ascii?Q?aMQLKu6Woc0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3538yp/5GSWxLkYAjeRJiCW1Y+7fWZMCbt8f368y0T6mCWKUFn+E4xd7agaF?=
 =?us-ascii?Q?TZJDJzmk79Btm0Hi230KbTwHFZhARbaNGZwQ2Un8TxM/7y5izIOE1BPX9YSi?=
 =?us-ascii?Q?Ky/vlGD9zZtoNCfL3Djv370ixt4QnNnhmrasgatmcjegnIt7DzZwYLw3FiET?=
 =?us-ascii?Q?PlkCShkYIbutl6XzUIFbaKp6d6UN2DR7/Ag7eNmIh8mD6gZcp9QDj+Yvq3KV?=
 =?us-ascii?Q?CVhhUBYhdpf2Fs1ze4g7aD17akBC6GPCErGMBUfPAnoD/noNRNSSmkN1uvT/?=
 =?us-ascii?Q?uBP7Gt4MBQPE/DXlpuTSwLyek8PQQqsIALmhOedWMN3zBQPZO0xQr86JwCKC?=
 =?us-ascii?Q?Ckcga1zi9DjqAtGPgVjAy1C5rxFhJSZnqmPuPQUFqXbYy4qn2bWxc2TKu07F?=
 =?us-ascii?Q?+qbSR/w2ef6xX4WNJ00iZ2PJXBMCk/TsTrBEa3PKSYhI7SwUEO/MQl2TdCBF?=
 =?us-ascii?Q?lxvzkCWt/+F19+l5/9USJ6/+8pFmHkm+xpocTuON5a/zmWzFJRojSSB6Iysp?=
 =?us-ascii?Q?uc05oO4gckDgvxIE1eppwWzcN5vHvkdj+qo+MI2SdwoAYshNRoF1pDu/Xjzy?=
 =?us-ascii?Q?dOWE1oj4ByQan27x64wmUCI61OQRB30GpzKqDyFhKujMmf/2XQk0pruZ4FWt?=
 =?us-ascii?Q?09xdLQMoKlL+xYulJtESTVXB0H9/aWuMQtPHig+dCXlvvfkrORJOLedmllaU?=
 =?us-ascii?Q?yEfLEOQ6VIMPY5BnsjB6UsTKPm7NG5NwljdCxHJFBcDdJTf/m/J5tXFMyKHW?=
 =?us-ascii?Q?DrzrWPyyQq1o8lqUK7bJxjzzYlNdS74twaTRsUHua0QV+OFEWjqdlbfyph2C?=
 =?us-ascii?Q?u3tTR+ZZwBBidBxBftMqEEmiXOtr8JngDryxyVxErKVoiQ19SPadKt0w3Goq?=
 =?us-ascii?Q?96aNr8+uE//i9yFwZsuLNsm0bs6rGNynF1QEbbOxV8IWtHxWL8xWNuBCYjPD?=
 =?us-ascii?Q?7eqfM8v3VS48rezbuOOGRV7MrpcS7ogJuAeMcIccrfVFQyGzH9ifkh3qgSrG?=
 =?us-ascii?Q?hXf2o4L7FfvMSScr5shJE4sIYKoZf7H7KZYrIgIL4lDAkVyaWeKycRhWCwen?=
 =?us-ascii?Q?FLE3T2MLJGGkkobQSAadgOSzlQeCAO++BmeYeNysrCtSz28wSQ43dMefHXxM?=
 =?us-ascii?Q?3FLQP3c8jsbi3nqU09AbVByQ7dR65f3EGggILfERmllXO4oSIGZfs3YAAGC6?=
 =?us-ascii?Q?z9JaOhQLvOk2ilR3lV8LGjhavdXaEwzVt7XBwd3Qmm0wZYd9zOMQdCsXo0lu?=
 =?us-ascii?Q?1ni80bOWBAzMSAvlLF+Q/vGyvMZfQxqa5MevYbGxG+oNhUUbjPGD405271Xr?=
 =?us-ascii?Q?Jn7stMqZzcIs6ilQPFQ7QQ6a+KvH8ri0KCVZK4pTV32oLgNL4VU319616Kqy?=
 =?us-ascii?Q?yc1adMLTh0hV0GDLs4mS7+QszUxQMIbuGZu7bUXsCwJOk5Bsr2luDzKry051?=
 =?us-ascii?Q?GQz0qBGMEDLle/lBXKhJtfmc7rxIla82p36GQ9R2mt8Dx/QrGbS8Jet90FxG?=
 =?us-ascii?Q?MztVkLzAbrcDhGIMv48YnBs/+MMTFo2g6zju42pgd/YnyNYlBMrIErqsfzLe?=
 =?us-ascii?Q?UN3c2HBH/hJka3wc5YU3G8k/wPY6Uo8TziRUMT3g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4ce9f4-3cc3-4d88-b836-08ddac8edb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 04:32:52.5497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lixcpDz1Vl/0NtQ9MkbAY4C9BaTv9BGim/v1RgAUdnxFGk+AHMYIOUrup5LbtsNUiUO6YeQ1mdODfne566VBZd2t/kbtkg9p+vt94mYhce0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5830
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
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Thursday, June 12, 2025 4:08 PM
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>; Marek Vasut <marex@denx.de>; Simon
> Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Lim, Jit Loon <jit.loon.lim@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] arch: arm: agilex5: Enable power manager for Agilex5
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Agilex5 FSBL is required to disable the power of unused peripheral SRAM
> blocks to reduce power consumption.
>=20
> Introducing a new power manager driver for Agilex5 which will be called a=
s
> part of Agilex5 SPL initialization process.
>=20
> This driver will read the peripheral handoff data obtained from the bitst=
ream
> and will power off the specified peripheral's SRAM from the handoff data
> values.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  MAINTAINERS                                   |   1 +
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |   6 +
>  .../mach-socfpga/include/mach/handoff_soc64.h |   1 +
>  arch/arm/mach-socfpga/spl_agilex5.c           |   6 +
>  configs/socfpga_agilex5_defconfig             |   2 +
>  .../power/altr,pmgr-agilex5.yaml              |  39 ++++++
>  drivers/power/domain/Kconfig                  |   8 ++
>  drivers/power/domain/Makefile                 |   1 +
>  drivers/power/domain/altr-pmgr-agilex5.c      | 112 ++++++++++++++++++
>  9 files changed, 176 insertions(+)
>  create mode 100644 doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
>  create mode 100644 drivers/power/domain/altr-pmgr-agilex5.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d62dd35a385..100a1c7b3cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -156,6 +156,7 @@ M:	Tingting Meng <tingting.meng@altera.com>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>  F:	drivers/ddr/altera/
> +F:	drivers/power/domain/altr-pmgr-agilex5.c
>  F:	arch/arm/mach-socfpga/
>  F:	configs/socfpga_agilex5_vab_defconfig
>  F:	drivers/sysreset/sysreset_socfpga*
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index 874e71b5ca4..402f0bec173 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -668,6 +668,12 @@
>  				bootph-all;
>  			};
>  		};
> +
> +		pwrmgr: pwrmgr@10d14000 {
> +			compatible =3D "altr,pmgr-agilex5";
> +			reg =3D <0x10d14000 0x100>;
> +			bootph-all;
> +		};
>  	};
>  };
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index 763b077d8c1..04203cceb8a 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -68,6 +68,7 @@
>  #define SOC64_HANDOFF_CLOCK		(SOC64_HANDOFF_BASE +
> 0x580)
>  #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
>  #define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
> +#define SOC64_HANDOFF_PERI_LEN		1
>  #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE +
> 0x634)
>  #define SOC64_HANDOFF_SDRAM_LEN		5
>  #endif
> diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-
> socfpga/spl_agilex5.c
> index a9aad5350d2..2a13301802d 100644
> --- a/arch/arm/mach-socfpga/spl_agilex5.c
> +++ b/arch/arm/mach-socfpga/spl_agilex5.c
> @@ -96,6 +96,12 @@ void board_init_f(ulong dummy)
>  		hang();
>  	}
>=20
> +	ret =3D uclass_get_device(UCLASS_POWER_DOMAIN, 0, &dev);
> +	if (ret) {
> +		debug("PSS SRAM power-off failed: %d\n", ret);
> +		hang();
> +	}
> +
>  	if (IS_ENABLED(CONFIG_SPL_ALTERA_SDRAM)) {
>  		ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
>  		if (ret) {
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 4ac0a5d9b99..5e8f2b85fc1 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -103,3 +103,5 @@ CONFIG_DESIGNWARE_WATCHDOG=3Dy
> CONFIG_WDT=3Dy  # CONFIG_SPL_USE_TINY_PRINTF is not set
> CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_POWER_DOMAIN=3Dy
> +CONFIG_AGILEX5_PMGR_POWER_DOMAIN=3Dy
> diff --git a/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
> b/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
> new file mode 100644
> index 00000000000..af7aeaa922c
> --- /dev/null
> +++ b/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/altr,pmgr-agilex5.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Altera Agilex5 Power Manager
> +
> +maintainers:
> +  - name: Alif Zakuan Yuslaimi
> +    email: alif.zakuan.yuslaimi@altera.com
> +
> +description: |
> +  This controller will read the peripheral handoff data obtained from
> +the
> +  bitstream and will power gate the specified peripheral's SRAM from
> +the
> +  handoff data values to reduce power consumption.
> +
> +properties:
> +  compatible:
> +    const: "altr,pmgr-agilex5"
> +
> +  reg:
> +    maxItems: 1
> +
> +  bootph-all: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwrmgr: pwrmgr@10d14000 {
> +      compatible =3D "altr,pmgr-agilex5";
> +      reg =3D <0x10d14000 0x100>;
> +      bootph-all;
> +    };
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 5f5218bd8b5..ebf5d828cb0 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -18,6 +18,14 @@ config APPLE_PMGR_POWER_DOMAIN
>  	  This driver is needed to power on parts of the SoC that have
>  	  not been powered on by previous boot stages.
>=20
> +config AGILEX5_PMGR_POWER_DOMAIN
> +	bool "Enable the Agilex5 PMGR power domain driver"
> +	depends on SPL_POWER_DOMAIN
> +	help
> +	  Enable support for power gating peripherals' SRAM specified in
> +	  the handoff data values obtained from the bitstream to reduce
> +	  power consumption.
> +
>  config BCM6328_POWER_DOMAIN
>  	bool "Enable the BCM6328 power domain driver"
>  	depends on POWER_DOMAIN && ARCH_BMIPS
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefil=
e
> index 4d20c97d26c..8e03f620437 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -5,6 +5,7 @@
>=20
>  obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) +=3D power-domain-uclass.o
>  obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) +=3D apple-pmgr.o
> +obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) +=3D altr-pmgr-agilex5.o
>  obj-$(CONFIG_BCM6328_POWER_DOMAIN) +=3D bcm6328-power-domain.o
>  obj-$(CONFIG_IMX8_POWER_DOMAIN) +=3D imx8-power-domain-legacy.o
> imx8-power-domain.o
>  obj-$(CONFIG_IMX8M_POWER_DOMAIN) +=3D imx8m-power-domain.o diff --
> git a/drivers/power/domain/altr-pmgr-agilex5.c b/drivers/power/domain/alt=
r-
> pmgr-agilex5.c
> new file mode 100644
> index 00000000000..257e8b234fd
> --- /dev/null
> +++ b/drivers/power/domain/altr-pmgr-agilex5.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +#include <dm.h>
> +#include <power-domain-uclass.h>
> +#include <asm/io.h>
> +#include <asm/arch/handoff_soc64.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <time.h>
> +
> +#define PSS_FWENCTL					0x44
> +#define PSS_PGENCTL					0x48
> +#define PSS_PGSTAT					0x4c
> +
> +#define DATA_MASK					GENMASK(7, 0)
> +#define TIMEOUT_MS					1000
> +
> +static int wait_verify_fsm(u16 timeout_ms, uintptr_t base_addr, u32
> +peripheral_handoff) {
> +	u32 data =3D 0;
> +	u32 pgstat =3D 0;
> +	ulong start =3D get_timer(0);
> +
> +	/* Wait FSM ready */
> +	do {
> +		data =3D FIELD_GET(DATA_MASK, readl(base_addr +
> PSS_PGSTAT));
> +		if (data !=3D 0)
> +			break;
> +	} while (get_timer(start) < timeout_ms);
> +
> +	if (get_timer(start) >=3D timeout_ms)
> +		return -ETIMEDOUT;
> +
> +	/* Verify PSS SRAM power gated */
> +	pgstat =3D FIELD_GET(DATA_MASK, readl(base_addr + PSS_PGSTAT));
> +	if (pgstat !=3D FIELD_GET(DATA_MASK, peripheral_handoff))
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int pss_sram_power_off(uintptr_t base_addr, u32 *handoff_table)
> +{
> +	u32 peripheral_handoff;
> +
> +	/* Get PSS SRAM handoff data */
> +	peripheral_handoff =3D handoff_table[0];
> +
> +	/* Enable firewall for PSS SRAM */
> +	setbits_le32(base_addr + PSS_FWENCTL, peripheral_handoff);
> +
> +	/* Wait */
> +	udelay(1);
> +
> +	/* Power gating PSS SRAM */
> +	setbits_le32(base_addr + PSS_PGENCTL, peripheral_handoff);
> +
> +	return wait_verify_fsm(TIMEOUT_MS, base_addr,
> peripheral_handoff); }
> +
> +static int altera_pmgr_off(struct power_domain *power_domain) {
> +	fdt_addr_t base_addr =3D dev_read_addr(power_domain->dev);
> +	u32 handoff_table[SOC64_HANDOFF_PERI_LEN];
> +	int ret;
> +
> +	/* Read handoff data for peripherals configuration */
> +	ret =3D socfpga_handoff_read((void *)SOC64_HANDOFF_PERI,
> handoff_table,
> +				   SOC64_HANDOFF_PERI_LEN);
> +	if (ret) {
> +		debug("%s: handoff data read failed. ret: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	pss_sram_power_off(base_addr, handoff_table);
> +
> +	return 0;
> +}
> +
> +static int altera_pmgr_probe(struct udevice *dev) {
> +	struct power_domain *power_domain =3D dev_get_priv(dev);
> +
> +	if (!power_domain)
> +		return -EINVAL;
> +
> +	power_domain->dev =3D dev;
> +
> +	return altera_pmgr_off(power_domain);
> +}
> +
> +static const struct udevice_id altera_pmgr_ids[] =3D {
> +	{ .compatible =3D "altr,pmgr-agilex5" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct power_domain_ops altera_pmgr_ops =3D {
> +	.off =3D altera_pmgr_off,
> +};
> +
> +U_BOOT_DRIVER(altr_pmgr) =3D {
> +	.name =3D "altr_pmgr",
> +	.id =3D UCLASS_POWER_DOMAIN,
> +	.of_match =3D altera_pmgr_ids,
> +	.ops =3D &altera_pmgr_ops,
> +	.probe =3D altera_pmgr_probe,
> +	.priv_auto =3D sizeof(struct power_domain), };
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

