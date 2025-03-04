Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806EBC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 17:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8B9805C3;
	Tue,  4 Mar 2025 18:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G0Z88w9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC76807D9; Tue,  4 Mar 2025 18:08:09 +0100 (CET)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E52D801CF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 18:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw7Io5TrtGQpfnTRFmUY4UVClDh2EzeVe/zrAwp9Pna9gjWM78q6E3w9SyRW09m98YXp10NlhUgDGR+mdABOfCQk2+StCDJt62bB6OWT805sc3OKN3DWrMWXXW16MStxN/2v4BjWb60wjjQoeC+ZoTyDxAn1GtQCvduH55B9zDQPrn6eHkLn2JFsEDStOGS4kcSri9IjNzvAHoEaw2MDagnlWWvvsazDplqR09F3PH6njlnjxZb4amEOi0N34ztLHw6ZJAZOlM3KaGjPEQN1Fs7JOiKeVoj7nRpi3FP0cvA6kiCKwW+GfOawsXoehzKJJ+6DoSUDlnbuvAStJ92qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDPHCtOTCE8N5chl+sLY7zmZf0qU22KE9LX4l49Z46o=;
 b=Y4SK6FPyLNiCqBDNCJxkAAcRC/teTpJW5QIUJS14eDuxErcBrjNTsGx78zTFx1b3bHhrYJaf8JX4mf9/L+A2OD4ZANip0z3tFTIOWC/YtcddIT+pcCIPS7UbD27TUr+EifsddgtTQQReTAhWTznx8N/+gkDZtu3v8+j69Mw6DoRsI0ujPLJLLPYjPg4tc52MTXYO8kvJDtwzESs1eDebjXrvciWpmQaljBwZ+l6d1w6EkHNOHiyQQq5HRoaHX+7SM82RvOPxI9It4sc71lAHQv62Wslpv3PCQ6zuK3NaDikZESlmvaLd0gke8NgrKiy1Uq0qztAVgIBHBdTue3eABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDPHCtOTCE8N5chl+sLY7zmZf0qU22KE9LX4l49Z46o=;
 b=G0Z88w9y06KEk7dtSbWrwwcqgbVaKlkW0E3RZlfxI5+N+rLiSg04+PQFqEa6bJ+JBShHq0U/faTbJ8o5/Y0c726nPWTmzrX3n3NeAC4v+Fam/5nvXHRwofxA7veW1JIh2NFXVOVeu7ciJbjpUCj0sQ9fQE3KQz/OD12iBPt3210=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB11249.jpnprd01.prod.outlook.com (2603:1096:400:3f9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 17:07:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:07:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Paul Barker <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Thread-Topic: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Thread-Index: AQHbjSPUJdziOWZfOkyOEhFojIQZx7NjNLYg
Date: Tue, 4 Mar 2025 17:07:56 +0000
Message-ID: <TY3PR01MB11346554557CE20B11A93AAF086C82@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB11249:EE_
x-ms-office365-filtering-correlation-id: a56c1b09-eabf-4a54-f225-08dd5b3f1bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+v2vfmOXWsNBd2IfOuCpdk4vOjI1l4IqYTN3pLVTiDtUwVShoilMSmegik1p?=
 =?us-ascii?Q?Ru89Rg9eUZXq99Bnwsyx9BU0Qgg73frobLJXZhetO8F3RmZbur1cWW+2TyGf?=
 =?us-ascii?Q?ZyE/tGrvsxItJVDNbV4DNlfnKYKmdI6EYHM5xfiYsdZiwbqdpYkZ85ohwZA4?=
 =?us-ascii?Q?1J9x5jT0fEZIZQztViQkWLbrgZyi4Mrztp3eZOGhEv8OMhwZQEt6aj2iP9An?=
 =?us-ascii?Q?IlqoIQYtrkYgqRdTBPo9TtT6uPOTqk+7YBq5mMPmVFAvm4fuvlH419H4y2jt?=
 =?us-ascii?Q?3XmYmF8x7M2NLNqayUmVJqS2lN0gGgqZAQl6ob+8qqSY4Qu7hbr3X2D5bsss?=
 =?us-ascii?Q?WIut+SIzPYvIpPGiJbE/GZb6sXs/56UVBXmGNkLcuD0w3kwCwG7wPg8BPq06?=
 =?us-ascii?Q?wtj4viFAqZABygXfwRH0ctAO5hp2k/k2ozEiazPIZGl8nMndLEcQ6n/FqhS/?=
 =?us-ascii?Q?d7QUrFO/ZOX5MSMKa9WsjY3cVJNN+RlY34QAy8XkHB69g/JEiMDgOl/RWCKb?=
 =?us-ascii?Q?IbYaYEv1xlEDMHEi5s1OrSRVYuBnpIHaid6yNF6uYY6ZNN6ZvMC0sFkJLuF9?=
 =?us-ascii?Q?IJC4h3USFZXAwe1/mO25uBBXueIn19JkpBHHfWriX5HK+hnLgtMwhk6SfOcN?=
 =?us-ascii?Q?V8sZvHKGAeHvXqMIvYaTQp6XvVj9jfD6Amhn81oNfy+M1bffi45LeEA+BTxA?=
 =?us-ascii?Q?R7Pi28hktZ7cEZoJkpAoGOqeD7kFf9e2P/6lSTigC51BSG2OMDacvnwWiYF4?=
 =?us-ascii?Q?sG5Ba21xHtSRxzPc96bubxdr9zpUKuCVeLhKQdaq/a4VW9laINPnG5S9xQqT?=
 =?us-ascii?Q?ctVO1aTiG19dEqmXdaPJioXe2X+D6NW0UnHQXwpCtF3j5LMN7yPi+VxxsYFB?=
 =?us-ascii?Q?ancsJTKB4eLfwhZogmPit3sa+nRKPDJr/WLWJyBryIiAifpC75/LCZrMB4ry?=
 =?us-ascii?Q?9ubHms9911FwIhuKbZwjSsEXung2J3XjhPr7ARPOLtxSqE/6OSfJH+RuLa+v?=
 =?us-ascii?Q?t6Hp6AgluPRnWv7VXLwkZPvco4aoD5KXvmbM6eo7KNQmCpIp0by1VuTbuL2v?=
 =?us-ascii?Q?TPUJTtIBYh0xmrxDNB6VwAVsQ+mfxuusuU44V4RsIPmAwdbhRh4/2PgNPe24?=
 =?us-ascii?Q?61d/5Ey/UKS+kc51tc7oAbS5TKJefJJq6r6J+IfvasYCfM21dxlk+URCbZDd?=
 =?us-ascii?Q?qxqk2nrbKWMweoK00+QLeKBGBPKmpwLG1j7xv6Eb/1i7xKk8MQ4yLpQFwS3d?=
 =?us-ascii?Q?FW0ArfMAWBD+2EdB8M7jJoMaUdWr3dZemZoOmGmco3xmdjnHI4a/e6k/2Yif?=
 =?us-ascii?Q?2sfQeHw6pFhuJePP2lXmcmYinpnvk1fK3iQRAW7AbMvDLOSc7zX3zHt24Om0?=
 =?us-ascii?Q?RPzBhXfYqOiwH15KX+iTYY48IU+2gFy0pd4y+fKVOgwha8ZkaNbAAnpwAZOP?=
 =?us-ascii?Q?aJ4ioFZjKqzaTZg+PbKk0gxjLfTH4yU4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ewi3CXC492VvY4se9rXPrOrwFJ/VrHwHni3IAzSNQaVxErt3UaPB8x/K23pp?=
 =?us-ascii?Q?B7g1+9BzJ4mtSU0aiujZ/zfzI8ilj2tnHwojZRbMYaZozqJUdkp/VQEMfx9B?=
 =?us-ascii?Q?mYSEcCrsLGAYI3wEQ2s2vJ8idYWWAix3uHl13+tz9SmKMrcSjQ5/QuLkyWKN?=
 =?us-ascii?Q?F4HEViGwTxOvjyjcMarYmyr1dSiSSnUnFP0Q/WE83TOtlUxqi78xm20wJEYS?=
 =?us-ascii?Q?H8yjEdygA/YOwRSYuOBtlLw7WKPlNlYlW7eGbhYYhznr0aoYgQf899cRDzrp?=
 =?us-ascii?Q?wHMrgwJilY73lsFmjysd/cCUIIgRp3zav5JQayksdOM+VDYcUyoHrUMONRnP?=
 =?us-ascii?Q?koNvODzGrimHgiG4lhajCUBN3VJj5uqYns3E0jDdCX3IDSkj+zShQYZOkeE9?=
 =?us-ascii?Q?3qwMzs31Vj8L4vPJi/UWTCLbSSZ1+tOhllwoa8DuPiaAglb3xicEg5fyCplw?=
 =?us-ascii?Q?BQb9PU2IC7gfRIj91q/C6OxKUwPS2HUpIf0t+OQ3tBsUr58yI4LM4dyNN7Fl?=
 =?us-ascii?Q?H6xE9SOE4YW3LllipHWvcf+mWEXZ2haR1oXFT4mob82bu8j0BktUgv7THFnz?=
 =?us-ascii?Q?8IsjgprPerd5pbiSXTNmPO4Sll9Lj09xbrJAoclUNG6RwYOPK8t6OKrdCizh?=
 =?us-ascii?Q?ExnYck+HtFvoFq7GZ0wOh5izMHyS/Vs9z68K3i9/vsUN+N4a++xxa1v/PMdW?=
 =?us-ascii?Q?53APMHiEzxkF+l2sdPwNCcOXEYEn13jWAnIkO8qoF/kDiIVPNLUe/5CHD6tD?=
 =?us-ascii?Q?USDnXhTQdxahZUFTk02yJY1g7rX0alUsD1s4bskaf/bizYOXgR/jQnbulCIJ?=
 =?us-ascii?Q?wddmWfgAhqYoGvSP4joiNcLeUhj3rZpCkbKeS6pEx7a2Ev8OqoiC9NVFKJbs?=
 =?us-ascii?Q?Ay5FN5tC25wOrTGI+b18Ft0B6rAM6r6WOiMv1PYCWN2Zfeht4scKySvOyD7a?=
 =?us-ascii?Q?INvXQtVc8FqEBb8ixtiMNXUvx2368nSAnK+bGYAOpHGtUuzzbD4kzDYbeJvq?=
 =?us-ascii?Q?OAFEbYJM/9Zx8Q1AKB09HYHOnkKXybbM5SkUVPFW5kaRNIrWFLild2VeTfIZ?=
 =?us-ascii?Q?7+jGXbpJF8EMpqFYXY2hiAYK/yAZc1r6Wjeu0Il7QOoObWG/eQsNd5ptNqwG?=
 =?us-ascii?Q?WQG4vSh9Udtq7Kn/kPaOr9Flw8bbwYuvxFecHvqfY8kkF6tVa4essOwWQia8?=
 =?us-ascii?Q?LEAHB7q+bA6wx8Gg4d5kbzsHCj2YyMMH07ihx1HSjyy7osaJwB40gozRg9Oq?=
 =?us-ascii?Q?ttfzArz5Znhn75p3RAp+/FE1ExdGwJri32x0ozL6Ne5Cy89z8cloCynyy56R?=
 =?us-ascii?Q?Jh7Ogr40I5+tmHGgNIyXfrlZDEQqRlEIVzwjAAC+D0QJS2DyP0ZHdBknuDVl?=
 =?us-ascii?Q?qu2grMvAdhMzoX7JHt5ixKlHs902q7IfjfNICetPICmiGURuQfuMYld1I+3p?=
 =?us-ascii?Q?6kuBbgDGC6B1g16p8dZuYAFJXFlg78zFfiLofDpKVbeQNG0E6m9JlpytvEIT?=
 =?us-ascii?Q?FwWY8PLlqapgiHwsjfZx8PpIUbvHkxIXIACqeFAkzy9GlGnTu7buqDqZBepa?=
 =?us-ascii?Q?XI0gCz/koede9+fGRLeyoT2oMTl64/gl8UfAFnYwiTwOKOtDqoAuQY6Klbgn?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c1b09-eabf-4a54-f225-08dd5b3f1bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 17:07:56.4479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuvIikPRy/i1R9jUuT5gsG+q+B7MS4SSw4ocGpEMm51UpETqmnPr78/54pBFy7pA5XovSHg9qcj0JlGCZrgLzjngiraxLFT63wH2TlJCpRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11249
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

Hi Paul,

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Paul Barker
> Subject: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
>=20
> Add a new driver to control the USB 2.0 PHY reset controller on the Renes=
as RZ/G2L and related SoCs.
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/reset/Kconfig                   |   9 ++
>  drivers/reset/Makefile                  |   1 +
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 117 ++++++++++++++++++++++++
>  include/renesas/rzg2l-usbphy.h          |  17 ++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
>  create mode 100644 include/renesas/rzg2l-usbphy.h
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig index fe5c1214=
f57a..80e83a40bdff 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -235,4 +235,13 @@ config RESET_AT91
>  	  This enables the Reset Controller driver support for Microchip/Atmel
>  	  SoCs. Mainly used to expose assert/deassert methods to other drivers
>  	  that require it.
> +
> +config RESET_RZG2L_USBPHY_CTRL
> +	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> +	depends on DM_RESET
> +	help
> +	  Enable support for controlling USB 2.0 PHY resets on the Renesas
> +	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on thi=
s
> +	  SoC.
> +
>  endmenu
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile index d99a78=
c9828b..9d438a755b30 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_RESET_ZYNQMP) +=3D reset-zynqmp.o
>  obj-$(CONFIG_RESET_DRA7) +=3D reset-dra7.o
>  obj-$(CONFIG_RESET_AT91) +=3D reset-at91.o
>  obj-$(CONFIG_$(PHASE_)RESET_JH7110) +=3D reset-jh7110.o
> +obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) +=3D reset-rzg2l-usbphy-ctrl.o
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> new file mode 100644
> index 000000000000..b1492631b97c
> --- /dev/null
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Renesas Electronics Corporation  */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/lists.h>
> +#include <renesas/rzg2l-usbphy.h>
> +#include <reset-uclass.h>
> +#include <reset.h>
> +
> +#define RESET			0x000
> +
> +#define RESET_SEL_PLLRESET	BIT(12)
> +#define RESET_PLLRESET		BIT(8)
> +
> +#define RESET_SEL_P2RESET	BIT(5)
> +#define RESET_SEL_P1RESET	BIT(4)
> +#define RESET_PHYRST_2		BIT(1)
> +#define RESET_PHYRST_1		BIT(0)
> +
> +#define PHY_RESET_PORT2		(RESET_SEL_P2RESET | RESET_PHYRST_2)
> +#define PHY_RESET_PORT1		(RESET_SEL_P1RESET | RESET_PHYRST_1)
> +#define PHY_RESET_MASK          (PHY_RESET_PORT2 | PHY_RESET_PORT1)
> +
> +#define NUM_PORTS		2
> +
> +static int rzg2l_usbphy_ctrl_assert(struct reset_ctl *reset_ctl) {
> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(reset_ctl->dev);
> +	u32 val;
> +
> +	val =3D readl(priv->regs + RESET);
> +	val |=3D reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
> +
> +	/* If both ports are in reset, we can also place the PLL into reset. */
> +	if ((val & PHY_RESET_MASK) =3D=3D PHY_RESET_MASK)
> +		val |=3D RESET_PLLRESET;
> +
> +	writel(val, priv->regs + RESET);
> +	return 0;
> +}
> +
> +static int rzg2l_usbphy_ctrl_deassert(struct reset_ctl *reset_ctl) {
> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(reset_ctl->dev);
> +	u32 val;
> +
> +	val =3D readl(priv->regs + RESET);
> +	val &=3D ~(reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1);
> +
> +	/* If either port is out of reset, the PLL must also be out of reset. *=
/
> +	val |=3D RESET_SEL_PLLRESET;
> +	val &=3D ~RESET_PLLRESET;
> +
> +	writel(val, priv->regs + RESET);
> +	return 0;
> +}
> +
> +static int rzg2l_usbphy_ctrl_of_xlate(struct reset_ctl *reset_ctl,
> +				      struct ofnode_phandle_args *args) {
> +	if (args->args[0] >=3D NUM_PORTS)
> +		return -EINVAL;
> +
> +	reset_ctl->id =3D args->args[0];
> +	return 0;
> +}
> +
> +struct reset_ops rzg2l_usbphy_ctrl_ops =3D {
> +	.rst_assert =3D rzg2l_usbphy_ctrl_assert,
> +	.rst_deassert =3D rzg2l_usbphy_ctrl_deassert,
> +	.of_xlate =3D rzg2l_usbphy_ctrl_of_xlate, };
> +
> +static int rzg2l_usbphy_ctrl_probe(struct udevice *dev) {
> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(dev);
> +	struct reset_ctl rst;
> +	int ret;
> +
> +	priv->regs =3D dev_read_addr(dev);
> +
> +	ret =3D reset_get_by_index(dev, 0, &rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get reset line\n");
> +		return ret;
> +	}
> +
> +	ret =3D reset_deassert(&rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to de-assert reset line\n");
> +		return ret;
> +	}
> +
> +	/* put pll and phy into reset state */
> +	setbits_le32(priv->regs + RESET,
> +		     RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_MASK);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id rzg2l_usbphy_ctrl_ids[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-usbphy-ctrl", },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(rzg2l_usbphy_ctrl) =3D {
> +	.name           =3D "rzg2l_usbphy_ctrl",
> +	.id             =3D UCLASS_RESET,
> +	.of_match       =3D rzg2l_usbphy_ctrl_ids,
> +	.probe          =3D rzg2l_usbphy_ctrl_probe,
> +	.ops            =3D &rzg2l_usbphy_ctrl_ops,
> +	.priv_auto      =3D sizeof(struct rzg2l_usbphy_ctrl_priv),
> +};
> diff --git a/include/renesas/rzg2l-usbphy.h b/include/renesas/rzg2l-usbph=
y.h new file mode 100644
> index 000000000000..1a46b585f170
> --- /dev/null
> +++ b/include/renesas/rzg2l-usbphy.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G2L USB PHY common definitions
> + *
> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
> + */
> +
> +#ifndef RENESAS_RZG2L_USBPHY_H
> +#define RENESAS_RZG2L_USBPHY_H
> +
> +#include <fdtdec.h>
> +
> +struct rzg2l_usbphy_ctrl_priv {
> +	fdt_addr_t regs;

This header file may not be required. As it is a single variable in=20
struct. If you plan to add more variables in this struct, then keep it.

Otherwise, You can directly use driver data as regs in .c file like below??

struct fdt_addr_t *regs =3D dev_get_priv(dev);

Cheers,
Biju

> +};
> +
> +#endif /* RENESAS_RZG2L_USBPHY_H */
> --
> 2.43.0

