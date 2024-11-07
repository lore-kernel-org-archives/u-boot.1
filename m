Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48611D5AE5A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 04:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB08289045;
	Thu,  7 Nov 2024 05:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNm1YPV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08802881FD; Thu,  7 Nov 2024 05:20:28 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3245E88BB2
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 05:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY6lJi/S74eaNebUay7nz5PogboRINC3zrHjQsXeirx/g0CfJw+r1ophKIHzHS3LJpMkayYaAPWLOz+QKbRj5VohN/+HPKU9UVzD8ettbEJ4FCgkc3P8YBvO+iJ7pL+bDvYJoTFL47EK9MnMIFq1XohWFMKClPoN4N5QspGb0vN37AsUD1gzCN1AqVge+rwcURDXezEY4Afit3yYvcvOhYBXrkTU35eP2apEBhcdjyxsU0f2uwmC5cggxsgTxoxoKMVxAlXBdU+lCgWlYtFPj6VBGM7fhvL6GzITh1zZzwYgV7+gJ+TI/j0HRH3vynyPhk66tgF0TANd381MDiLsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV/CEJkwdG4QJ/hUypVqLji8K5xB19mwCemosZzRlnI=;
 b=YSXmN17qsSlzznY5bdAFOWAH7Na0FF2kVLZh5Erp0x+gX8A28UsDPCokTk1PGtVyddg7+JJ6VWzXK/Kr5DtfLIOIeNw/F6B+Vmo5TqxFh1PpRKYWMoBJME8OsNd+TM2s2e5QS282rgqTQEFaCmhziiGbbZfl+874dsNg3Zn2REuLbBy/jTyW6+R0XFdEp7YWL9OiEcqArEufhu5Z/fJzsEmZWViMCMCrdhPjOcpL2u4pp8Yve5EK9f2DWIrHbCqflyNiVYjTm/BjIKZmRg2E0kTqgl5tcm7Cs4e1PzPi1DD+2w2NVcKkm/KGUIrSXZV7ZXN29CfdViTGksEhsZ4mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV/CEJkwdG4QJ/hUypVqLji8K5xB19mwCemosZzRlnI=;
 b=iNm1YPV8b8mli2/5IwKht5Zw/e2QZ79McuxXqVUzgtzzCW/IX48P9kbDWG5DWjrbFEH2BTAbEnH7sb8lPGjW3Z/8Jdqjs/7cGpo37MgAN2WSIu0gu/rcFlKg3duesXUa7+mxnhLx4acLwtQo58E2nqoD3085MaoFeLDZpK0fkR8=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 04:20:20 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 04:20:20 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@xilinx.com" <git@xilinx.com>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Conor Dooley
 <conor.dooley@microchip.com>, Kongyang Liu <seashell11234455@gmail.com>, Leo
 <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH] riscv: Introduce configuration for 64bit version
 Microblaze V
Thread-Topic: [PATCH] riscv: Introduce configuration for 64bit version
 Microblaze V
Thread-Index: AQHbLEOObycJI01pOk+Uh/DUN4rOfLKrP9Ig
Date: Thu, 7 Nov 2024 04:20:20 +0000
Message-ID: <CH0PR12MB5266421A5E1005E7B1C2C33DEC5C2@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <5b042f4ef4927b7f87e1f8623dabeab5a8642916.1730454641.git.michal.simek@amd.com>
In-Reply-To: <5b042f4ef4927b7f87e1f8623dabeab5a8642916.1730454641.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB6424:EE_
x-ms-office365-filtering-correlation-id: 0880129c-0908-4528-a708-08dcfee37e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5WiUUT2Pe3TUpVWvrMtZ3AkOcvBzcAq/TpmiAuQa1NLM7kZdDDVEX2Z4lJgu?=
 =?us-ascii?Q?jgus2eB+RdO7y0hMxgGynN6UFerIA1h/tjpy1bnlLMLIBQbhsBT7QgKP30QO?=
 =?us-ascii?Q?Ni7onRZFQsoKXvGzLGJp9QgxGSRWRu54p4qtftW+nmCa2oK7u+/eulam5igA?=
 =?us-ascii?Q?PVE/Gp5RYwAIBXUhOrtM9pXC0uXh5U0mehOsacdy/Omy4uiA5W3lllNYBqMy?=
 =?us-ascii?Q?WuHDqgbvnlYIL+rKl8CWHZmfYfwBLEQ8PfPA+w/mc4VfcE8Q4p1paAqkDnuy?=
 =?us-ascii?Q?zV0u6KI8MT0etUqYMVA33+GzQsesEJ/Ok1XFL3y0Z3VQPeVptjtpLZFMcjNX?=
 =?us-ascii?Q?C00j9IfImkdL/Y/vO3OKjKDxMmiyxuVTDL7q/D1rj9D2DHLa8hLuRF/yQvcO?=
 =?us-ascii?Q?teAz+vmz+tbsFckhUApN3koxo7HoNdt8xqfSpMTvA0lxribrwGflPOaSwQEK?=
 =?us-ascii?Q?s5E9qPvimICRxHnP7FCIEp10ayqJSYScX+g/x1anWuiJb9M5AwAd/Z9jr5/y?=
 =?us-ascii?Q?kvQaV8SyndANuZwnpmXX8tddNuI9IrfIbGAhW/JhOAXAKbshe4nDKVA+d3pe?=
 =?us-ascii?Q?jsiQyi3GK+B7YC8x12QtIsRppjG8HUk6CDqlvFHYlwSV0qOrdc4+ONLRfLqx?=
 =?us-ascii?Q?/fGzzh6DnvmtQ44rJXlOSMGPiD5HsL2XpR8wjQTSkfXkEOLJaQd/eyM3ud2r?=
 =?us-ascii?Q?W7Lq10dML8nK5ipXkq9zo3EKN74yyoXOWNFqXjyEF4NyVBNg775akwY/+11F?=
 =?us-ascii?Q?X7mtohRZhdRzWJY/x87iGz06hidNLd6fXCoFRzl5VcaLU2Puo+liOkB31OT3?=
 =?us-ascii?Q?ZiimBnU3sr6r/+cY+y4bIQSzeG1RB3c1+AzjLYagdbk0LmCbZAOShX++BwNo?=
 =?us-ascii?Q?a7S2Ve98wE1TC0s/CygBBPLm9v8UnZDpkEOjI/DEjMbctO6kcew+WiSut7p+?=
 =?us-ascii?Q?WtEBgisVE9nR+XL+OugYbyFvwUfNGtS9JYyvu5w4ykS5kSnBJGdGdhUfhZa0?=
 =?us-ascii?Q?7vIweZ30Nf8zHd9uo8p/zYEa0vxASrt8CqMtp5dTuF8biX2lEM6vtiiZr4nO?=
 =?us-ascii?Q?kQARpgEZJKFW236AwD/usEHsTLtFMBHzPFL5OF6Fb2REwSQK5CWMGO5wpsMP?=
 =?us-ascii?Q?2Bha+xol0scOTukfA3kuvpp5HYCA3FmpDLTx5ud1E8Nrfg32+Mru7Grl2q3Z?=
 =?us-ascii?Q?NGC5opFwEtV0OvZomMlE6CpwWEeLu0D7Egz8f4wBMsUIXkoOYvn1McbXJKkD?=
 =?us-ascii?Q?NuUGw1rNw3MVC+Y/NY/W6PMMjLVLGA7Q6baIy7ev4P+p1lj4s6IgyAQYirJ/?=
 =?us-ascii?Q?zCCD2+omR5OZ5YINj41jBmWhC5f9Tp4msURYy5Go7xji1VOnoDNwSVY050LF?=
 =?us-ascii?Q?at6xiqs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6yQycnmjl2HJEvatkV9GlpamN7LxxbqvLA1GYgElTFD4jb1KJNK8k3pmLcR?=
 =?us-ascii?Q?FjOYRJ230ElV/3EgkiG7n05VomdAN/dXiHtqttTMzU5UVo2yrFsCJiWILFcm?=
 =?us-ascii?Q?SMBI3Ny9WTZDHEFcNO7aHw4uNiZVJXb/Arc73maC244FevB0WO4ovOypv0/h?=
 =?us-ascii?Q?4ROmFsZi4IbZWsiRrY0CROwqqdtkEuBt6hy0wQ/egQXA7ogDLNgs58/OiyeD?=
 =?us-ascii?Q?AcXPKtT3RNppIb94RJFDbaOSgwlQsqKYmQneLyI4o8sP2IVmMi1QtRsKwSft?=
 =?us-ascii?Q?EfdiwIZGATIurZRdpX4vShF8HABGI/8Vj7RUBeQ7KEn2vKODvwGimiaRlya0?=
 =?us-ascii?Q?OUGRiyXzhiyR63udZSwCv1SRD8hgMddeu+Ks3vY2mYSgSp5bBdc8nx6S1Col?=
 =?us-ascii?Q?BRMhchZ8kUi+0cOluj3QxHW0YTSUIMJTPvuGfFppY407rDgAPkWqGepZXAbr?=
 =?us-ascii?Q?JJJQcmre9xBC1EllJxbJvkUD0QWmubAZYzSfzr9/TgbHoSaBFDXhqnPPQPhd?=
 =?us-ascii?Q?oUd+r6gQOVeFBTyOLUaNVsFa5toQg4Sorncrl4yt0kZ1deYcHKaEDXRBoCJI?=
 =?us-ascii?Q?t5oQB/rEjjEGeRoY8+/OhA9PycrbJW8r6Q25Q1gX2zynlJhWxFE7JDxgSodz?=
 =?us-ascii?Q?9mEufB38bHMLJ9i9WWPprEm6trEonvF/0FJzPvb5mgbBPIag+oi4zs6MCqIZ?=
 =?us-ascii?Q?ZLnIXIBwWOUj34rBbpQxu+i7JJtnbUYJER1aLR2GULRUZA5CNQHTyqcevIwy?=
 =?us-ascii?Q?JUWw9PMQ22X8rKGCKdmyVVhbpOGgR0m0shzI4bY6HMJ9todQ6LOrzllxtAxe?=
 =?us-ascii?Q?dECsqU8jZxwQ24qLgLpPK+t/SDmNKxTPNJKMyjkMWTRSTAkt/+yF8vg8uSfX?=
 =?us-ascii?Q?lBB/LrFeGU38v3ZhGWC6SVxAtsLTqgvwFVPvWTBGUCdII26hQNBQQGirYeOK?=
 =?us-ascii?Q?ErpvDPSSi/iXBs/542b1O+pzzMRNQV385idmZ2Y1iK0akJngD4oRGzi60wc2?=
 =?us-ascii?Q?EIkt1FmtugnTs6HCKI9bRK1lIdDyj2L9kvP6wFV3LtXjcqnQCkwsQTqCJRFa?=
 =?us-ascii?Q?h3fI+dEpXOjtdSLugsvx//+0vvdNq7G5yWoPKmIcwudKwejcJeVl/2fVIAp9?=
 =?us-ascii?Q?TkKRYpOburX4jBao7+hFGlrxntm4/IObwUXOjLql9uszNWPj5ZwJji9s3unB?=
 =?us-ascii?Q?IIXKgSA5vp/pialvb/6IGhzsEPvi3Sq93U4XvS2E5L8g9SQ8f/Z8vnUMIrLD?=
 =?us-ascii?Q?0WhzQ9jXFbUH+s4lq3mfr1wHEaZ+/1maySfq0vU+VZ4T0XxrRg7z64eg7ZS/?=
 =?us-ascii?Q?QfkZKAYNqkJ9ZcFbWiYOien5zTMm45SP9jQ98ImSOj8EVKmQhzwNMX50XFoE?=
 =?us-ascii?Q?k2Bef+HRJtuFrXia7tMwbsLehpeeHFuAEmtUCOpur5q/HItH7/32bj/FdPt/?=
 =?us-ascii?Q?hS1VR3WCfRZGYHwaWQ6iwB3UU0uvSLW4LbjqeJRh/NDGyE/ICCIK52w92G8V?=
 =?us-ascii?Q?U8PvHw4mar5LuHOpnl4Y4b9taaAlelOkaRrLWAZFWiJ5QQmh79SKKnhvoDpN?=
 =?us-ascii?Q?7cheBCA1ZKpcfNeVHMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0880129c-0908-4528-a708-08dcfee37e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 04:20:20.6921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdCIQFNEAPtqqXlbAFdxEhl8KZAbdvWQWY5zyepq65vv02VrOFVkf/edkUzLEaQQZJkp09kSil07krpXShKcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

> From: Simek, Michal <michal.simek@amd.com>
> Sent: Friday, November 1, 2024 3:21 PM
> To: u-boot@lists.denx.de; git@xilinx.com
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>; Conor Dooley
> <conor.dooley@microchip.com>; Kongyang Liu <seashell11234455@gmail.com>;
> Leo <ycliang@andestech.com>; Marek Vasut <marex@denx.de>; Begari,
> Padmarao <Padmarao.Begari@amd.com>; Rick Chen <rick@andestech.com>;
> Sumit Garg <sumit.garg@linaro.org>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] riscv: Introduce configuration for 64bit version Microbl=
aze V
>=20
> The commit 7576ab2facae ("riscv: Add support for AMD/Xilinx MicroBlaze V"=
)
> added support for 32bit version. 64bit version is also available that's w=
hy wire it up
> too.
> DT is providing description for generic QEMU target.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Padmarao Begari <padmarao.begari@amd.com>

> ---
>=20
>  arch/riscv/dts/Makefile              |  1 +
>  arch/riscv/dts/xilinx-mbv64.dts      | 99 ++++++++++++++++++++++++++++
>  configs/xilinx_mbv64_defconfig       | 44 +++++++++++++
>  configs/xilinx_mbv64_smode_defconfig | 48 ++++++++++++++
>  4 files changed, 192 insertions(+)
>  create mode 100644 arch/riscv/dts/xilinx-mbv64.dts  create mode 100644
> configs/xilinx_mbv64_defconfig  create mode 100644
> configs/xilinx_mbv64_smode_defconfig
>=20
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile index
> bf32ead01b03..de356584bf1e 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_TARGET_SIPEED_MAIX) +=3D k210-maix-
> bit.dtb
>  dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) +=3D jh7110-starfive-
> visionfive-2.dtb
>  dtb-$(CONFIG_TARGET_TH1520_LPI4A) +=3D th1520-lichee-pi-4a.dtb
>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
> +dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
>  dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) +=3D ast2700-ibex.dtb
>=20
>  include $(srctree)/scripts/Makefile.dts diff --git a/arch/riscv/dts/xili=
nx-mbv64.dts
> b/arch/riscv/dts/xilinx-mbv64.dts new file mode 100644 index
> 000000000000..4d65d338ecb6
> --- /dev/null
> +++ b/arch/riscv/dts/xilinx-mbv64.dts
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for AMD MicroBlaze V
> + *
> + * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "binman.dtsi"
> +
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "AMD MicroBlaze V 64bit";
> +	compatible =3D "qemu,mbv", "amd,mbv";
> +
> +	cpus: cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <100000000>;
> +		cpu_0: cpu@0 {
> +			compatible =3D "amd,mbv64", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			riscv,isa =3D "rv64imafdc";
> +			i-cache-size =3D <32768>;
> +			d-cache-size =3D <32768>;
> +			clock-frequency =3D <100000000>;
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		bootargs =3D "earlycon";
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0 0x80000000 0 0x40000000>;
> +	};
> +
> +	clk100: clock {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <100000000>;
> +	};
> +
> +	axi: axi {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		compatible =3D "simple-bus";
> +		ranges;
> +		bootph-all;
> +
> +		axi_intc: interrupt-controller@41200000 {
> +			compatible =3D "xlnx,xps-intc-1.00.a";
> +			reg =3D <0 0x41200000 0 0x1000>;
> +			interrupt-controller;
> +			interrupt-parent =3D <&cpu0_intc>;
> +			#interrupt-cells =3D <2>;
> +			kind-of-intr =3D <0>;
> +		};
> +
> +		xlnx_timer0: timer@41c00000 {
> +			compatible =3D "xlnx,xps-timer-1.00.a";
> +			reg =3D <0 0x41c00000 0 0x1000>;
> +			interrupt-parent =3D <&axi_intc>;
> +			interrupts =3D <0 2>;
> +			bootph-all;
> +			xlnx,one-timer-only =3D <0>;
> +			clock-names =3D "s_axi_aclk";
> +			clocks =3D <&clk100>;
> +		};
> +
> +		uart0: serial@40600000 {
> +			compatible =3D "xlnx,xps-uartlite-1.00.a";
> +			reg =3D <0 0x40600000 0 0x1000>;
> +			interrupt-parent =3D <&axi_intc>;
> +			interrupts =3D <1 2>;
> +			bootph-all;
> +			clocks =3D <&clk100>;
> +			current-speed =3D <115200>;
> +			xlnx,data-bits =3D <8>;
> +			xlnx,use-parity =3D <0>;
> +		};
> +	};
> +};
> diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defcon=
fig new file
> mode 100644 index 000000000000..aad9c3f140b2
> --- /dev/null
> +++ b/configs/xilinx_mbv64_defconfig
> @@ -0,0 +1,44 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0xe00000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x81200000
> +CONFIG_ENV_SIZE=3D0x20000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"xilinx-mbv64"
> +CONFIG_SPL_STACK=3D0x80200000
> +CONFIG_SPL_BSS_START_ADDR=3D0x84000000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +CONFIG_SYS_LOAD_ADDR=3D0x80200000
> +CONFIG_SPL_SIZE_LIMIT=3D0x40000
> +CONFIG_SPL=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0x40600000
> +CONFIG_DEBUG_UART_CLOCK=3D100000000
> +CONFIG_SYS_CLK_FREQ=3D100000000
> +CONFIG_BOOT_SCRIPT_OFFSET=3D0x0
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_TARGET_XILINX_MBV=3Dy
> +CONFIG_ARCH_RV64I=3Dy
> +# CONFIG_SPL_SMP is not set
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x80200000
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_DISPLAY_CPUINFO=3Dy
> +CONFIG_DISPLAY_BOARDINFO=3Dy
> +# CONFIG_BOARD_LATE_INIT is not set
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x800000
> +# CONFIG_CMD_MII is not set
> +CONFIG_CMD_TIMER=3Dy
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_XILINX_UARTLITE=3Dy
> +CONFIG_XILINX_TIMER=3Dy
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_GZIP=3Dy
> diff --git a/configs/xilinx_mbv64_smode_defconfig
> b/configs/xilinx_mbv64_smode_defconfig
> new file mode 100644
> index 000000000000..628e0ed5be2c
> --- /dev/null
> +++ b/configs/xilinx_mbv64_smode_defconfig
> @@ -0,0 +1,48 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0xe00000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x81200000
> +CONFIG_ENV_SIZE=3D0x20000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"xilinx-mbv64"
> +CONFIG_SPL_STACK=3D0x80200000
> +CONFIG_SPL_BSS_START_ADDR=3D0x84000000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +CONFIG_SYS_LOAD_ADDR=3D0x80200000
> +CONFIG_SPL_SIZE_LIMIT=3D0x40000
> +CONFIG_SPL=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0x40600000
> +CONFIG_DEBUG_UART_CLOCK=3D1000000
> +CONFIG_SYS_CLK_FREQ=3D100000000
> +CONFIG_BOOT_SCRIPT_OFFSET=3D0x0
> +CONFIG_TARGET_XILINX_MBV=3Dy
> +CONFIG_SPL_OPENSBI_LOAD_ADDR=3D0x80100000
> +CONFIG_ARCH_RV64I=3Dy
> +CONFIG_RISCV_SMODE=3Dy
> +# CONFIG_SPL_SMP is not set
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x80200000
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_DISPLAY_CPUINFO=3Dy
> +CONFIG_DISPLAY_BOARDINFO=3Dy
> +# CONFIG_BOARD_LATE_INIT is not set
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x800000
> +CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=3D0x2
> +# CONFIG_CMD_MII is not set
> +CONFIG_CMD_TIMER=3Dy
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_DEBUG_UART_UARTLITE=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_XILINX_UARTLITE=3Dy
> +# CONFIG_RISCV_TIMER is not set
> +CONFIG_XILINX_TIMER=3Dy
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_GZIP=3Dy
> --
> 2.43.0

