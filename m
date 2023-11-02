Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B176C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0155487656;
	Thu,  2 Nov 2023 08:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="m7yAoShw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D477887656; Thu,  2 Nov 2023 08:54:51 +0100 (CET)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:201a::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7908767C
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz4IdJaL7gnXWcsqeSNbkTSpuwQKtgWOaqHCmBLd5i9WIfyfFeJ/VCo2+2YgQdOqDz8djwGbnB6iHJDUeq6mehypBj+AxJE1US4/L2J8PjBOzSP9lQsUBbsIOMnXojhBDOJXW/0kXJp0oMX3oSf/QGswhTe5/0VpiXzj4QZ9SPp1pgC+uwn69BZCbjrxhWm/rB8k68PQzp75C3g2N30JjbOXEMhUA8eggHzSHXdpat8cFEx//23KpHoOFIuIsdYoDljDrCHNEoX2pOA1stGgPvZk7zpxRbDbO/VAoDhw0iWJJHA/3VH8Nrz5wsHH9cxcmkYTTUxVdD6wjdfhfinGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWaFe1uyZt+6uvmEFUzVcxoOEqRBpR/YubXwUfui3Ac=;
 b=OXHEWf3aQoskAAjqliT6+TIg3+UJKoQOvHS5fGUgKL3xjgI6ESuUo5nLz5MKNKMQsRcMy+EPWW2ITwJ9YzCBP+FBceh9mfrsl+3sCv/BP1NRXCK5IChXmVtRILnfpeueRQ9p26Z6i1PWvsvK87fRjGPjj/qobTnw0sSQplCY6JBXS/aRQuawpcLI8uQdM9dQWbNw00gftl1A85gKyzF8iTL3Jme4FyCX+LQNmO3eBPu7cYl9IBApd9+mmj53P0oEJR44xOp1pZjywL1iPyZOt6BpaFrdRi5r+YsOPNhFwwnpTRIqVFqRBaFOWH50lL2+iBzPoeXGKEIJE06PBty0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWaFe1uyZt+6uvmEFUzVcxoOEqRBpR/YubXwUfui3Ac=;
 b=m7yAoShwcqxEK6ulEVchqHpm29i57yeHVMJi/39JkjKWDo/SgL7jP+2a6+6f96QKapMPf6FWZDX7LGign2lTaB42fGp2BZLrld4ZSvNLJGnIxolgG2diOwPglKZmZPQdsvYQeXdybAW+rGehz5CoaxdaMRgj9pc3K9vTNkbknqI=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB8522.jpnprd01.prod.outlook.com
 (2603:1096:604:199::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 07:54:39 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6cb:4ed9:b0be:36c0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6cb:4ed9:b0be:36c0%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 07:54:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
CC: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
Thread-Topic: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
Thread-Index: AQHaDP7+z2/K3g2YBkSSfN4GE4shq7Bmp/zw
Date: Thu, 2 Nov 2023 07:54:37 +0000
Message-ID: <TYCPR01MB11269318ABD0588D031AF46BF86A6A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
 <20231101200600.119507-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20231101200600.119507-2-paul.barker.ct@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB8522:EE_
x-ms-office365-filtering-correlation-id: b8a7c1a5-cad2-4c7f-fb31-08dbdb78f643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdbnF2vNcGH+iIQ1jAeHqfHcIKoaTRmp6wk4YdfB4TGQysG+cRDX5ENlcC85FAwFTwAmnctce07+rLs6PiAH45gwAxiQjlN1E02Lz8U0evNQUjvwWqIg674nF68qNIJkzJ+llmJRd4bI14klzhS/PHZAVCMf6GpHBIPXXqihWo9YMedahlg9IwhNIqVy2yVDd7YojKCEl4hrNbDShB8Vememcf8XlXfZ3K3LqbxrcR8ihHy7ZwHFckXAksI/FYGJ2Th2jEYXcI7rj1SN3U4b3tEiCInhaUtrzn7ROSLMQFJMNXS3E7Vd8Zhs97IkB134wYju3KBhQV7L0eLc6Qtea8Cyu7Flvt7F35bKmDFPFr1rdfK8dxrD/gmY5QNrbrloaqEQJteCbohK0UVLtwnbV+ZLxtE2KqT7qF+eIMUXB1f1Ktf1Jifk/3W0C3Q0GKxFpIcQTZ/LDCP+7EyPuWMAzHsL4aUuLbLgoU3ZnuMNv8PiXVI/4QU0Trt41LAbXL0/G54hVgAjsqW/aiRK+2Gr1II160otW2dAmgH1cNHJkrr1F3S2lLlhzCONs7AlAKSZi3JhJeSd22RQNnbWPRu3FwEMjXDNAZUQPDEcQVrvwSv0WnBuvdU7nAFM9W23dpk6NV3qLc+08eytxIIom/C5ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11269.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(76116006)(38100700002)(110136005)(122000001)(66946007)(52536014)(66556008)(64756008)(66446008)(2906002)(9686003)(66476007)(41300700001)(316002)(83380400001)(8676002)(8936002)(4326008)(55016003)(26005)(86362001)(107886003)(5660300002)(33656002)(6506007)(7696005)(71200400001)(478600001)(38070700009)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Rex7NlV6ypTI+EjVEWvnSkjYDVZawa5E/l5x8/sKXLWCUWh/Xg0gLC4adFA?=
 =?us-ascii?Q?Hjib2FLs2Kz38YoC/EGBUKGoCxAD6h60Qd1sapCG8cbb34pqQILv0bh4fEob?=
 =?us-ascii?Q?b/qT+8wEaI7FdeqR4enTdsEg/ueZpC5hWiWifRhxO+ec6/6ssiYnzQlK2Nie?=
 =?us-ascii?Q?5wDAb6l6etsiXz4K154lWX56OhVKzesu4XCeKPJBIYEiOgzpYE0t00mnZTrm?=
 =?us-ascii?Q?E09s2mGB2YeNhwTtQ6sHTTxSI+kBOtObtATNCpmpoNaLJy8Yg77bSvP7ZMTQ?=
 =?us-ascii?Q?cxaPg4Eul8eTZJMb9CMs3q2XXMblLkbZAgar/HCwYb3hgLhbrZJra8JXvdIX?=
 =?us-ascii?Q?lJRuXfWsAczvhEvkZKN+hUMGjSmYPAxoRsq7V9/GQ0aBZ/Sx771wOBmjR/Nh?=
 =?us-ascii?Q?Kqolgt1sWji8owxc8F7Il5BdsQ2OsuIEjc5or+OuDYa1o656DGY1UQr7rUp4?=
 =?us-ascii?Q?vCGYazpqd7g+XK8e/rDxGvPiggFoQYAtrKXi+s1hN+TiN7hIxZcQYa5cPwRL?=
 =?us-ascii?Q?n/43KxBOB0WipxtMsCFWKfVRM2OxGttucCJWUM87T/KjAqr5Lcd6/yuFha6g?=
 =?us-ascii?Q?jxmeR1Db2aOrEXbpB9G4WixtDJs+bRxqKW3Ta3YSRegdi1Tml06WeBFWm1xs?=
 =?us-ascii?Q?KC7dC26AYUkZ5Vr4ENoZZuANVh6NRiUlPsMCJbTbyJFeTU0cGjkyTr6YY37m?=
 =?us-ascii?Q?c4mJAifBMp0jpn0dzfo0q0KirgFBB9k5vm3grYVmp8c/zfEja8GhiS48KSXZ?=
 =?us-ascii?Q?B6mHG3kitz52M/mpn4yOaMCGwHqz8QTpCt1u+g0gubbrcNjyBGdd+vdObKPF?=
 =?us-ascii?Q?YTNTlFfapevHJZRy+PfpofWpLuRgeLH6iQNk+vKVWIX2Xx5mzFKcUDGHetAE?=
 =?us-ascii?Q?cZjaJ8ovhlRIMNInwyopTvt3dx4Arxl/KY3cyLGMTKaPCL5Rr0G8Uw9heyXx?=
 =?us-ascii?Q?NpxeUr1UmbW+zEawsy50OymQpV5WIPgQtEJe9dYGKWQPj31ZBst1IWUsHBBC?=
 =?us-ascii?Q?x3H8ZKj8X4DvlHDXouythwSFTttIDBeVS8DXhYMGD7Q+327MS3sX5xS+UB0j?=
 =?us-ascii?Q?zd4KU9qlD8d7aqhXq7GKG7hIzr7k4lsPFkya5H884WOJQ8N0iXw/qDnzbJ4U?=
 =?us-ascii?Q?Hn06AHdBoim2Q55OYjBil3yHQ1oSY4rSwMLw8+kk55GakGfW90HMYraY5oTE?=
 =?us-ascii?Q?N1VCjeUaenTe8lruNgHN44jIym09VAFppaFIEK5dYU660tmx9iaHxKi6NOEb?=
 =?us-ascii?Q?AUAGrzE7G3zpnc+y8ykWNsH7sIQvE/fvVj/05+wVhEz33y2VfCvJW5C01fH6?=
 =?us-ascii?Q?MpNf+SAQsGLuTBMuXdY4cEbP3LzyH5aw3YEHfztMqdHEvafflk9R1sduoki7?=
 =?us-ascii?Q?F+jpZVXA4svJls5SQV1XeSsacQXhAWPYUjjLg7VCleqOgunlOTxRY7xerbnX?=
 =?us-ascii?Q?/DcPIElUrD1fMYDB8YMW4T6OHVqRv1k+msaL8jOGoEGhy6FUsrwEY84+yXor?=
 =?us-ascii?Q?cQgxyei2S7Km8gIQb/rE3H85LjsL5/mtLoptsq/70N7xFvw1+BFaiUuDX7xb?=
 =?us-ascii?Q?axkIxpT05pJh5/Jk/Ao23raNO0lZf6vV+g4Qz5O3TxQostkaT2gdAW8e3D1Z?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a7c1a5-cad2-4c7f-fb31-08dbdb78f643
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 07:54:37.6780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dU+Wo1CzCeJSZUFX0E9qOLPusuufG8QdQRTOTFXZ9riO5ncutBpgh5VJUJJkXWdVvxLm6I3bQWFLW33Y61FVnCbtZvUPd+an0ur1Cn4znc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8522
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

Thanks for the patch.

> Subject: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
>=20
> For most source files we can just drop <common.h>. We need to add an
> include for <asm/u-boot.h> in a couple of places. Also sort the include
> list in memmap-gen3.c while we're here.

Why only sorting memmap-gen3.c? why not sorting all the files touching here=
?

Cheers,
Biju

>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  arch/arm/mach-rmobile/board.c            | 2 +-
>  arch/arm/mach-rmobile/cpu_info-r8a7740.c | 2 +-
>  arch/arm/mach-rmobile/cpu_info-rcar.c    | 2 +-
>  arch/arm/mach-rmobile/cpu_info-rzg.c     | 2 +-
>  arch/arm/mach-rmobile/cpu_info-rzg2l.c   | 1 -
>  arch/arm/mach-rmobile/cpu_info.c         | 2 +-
>  arch/arm/mach-rmobile/emac.c             | 1 -
>  arch/arm/mach-rmobile/memmap-gen3.c      | 4 ++--
>  arch/arm/mach-rmobile/memmap-rzg2l.c     | 2 +-
>  arch/arm/mach-rmobile/pfc-r8a7740.c      | 2 +-
>  arch/arm/mach-rmobile/psci-r8a779a0.c    | 1 -
>  11 files changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/mach-rmobile/board.c b/arch/arm/mach-rmobile/board.=
c
> index a10371f74e0c..79c7e02671f2 100644
> --- a/arch/arm/mach-rmobile/board.c
> +++ b/arch/arm/mach-rmobile/board.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.co=
m>
>   * (C) Copyright 2012 Renesas Solutions Corp.
>   */
> -#include <common.h>
> +
>  #include <init.h>
>  #include <asm/io.h>
>=20
> diff --git a/arch/arm/mach-rmobile/cpu_info-r8a7740.c b/arch/arm/mach-
> rmobile/cpu_info-r8a7740.c
> index dcbe25f37ab9..5a94235c4b9e 100644
> --- a/arch/arm/mach-rmobile/cpu_info-r8a7740.c
> +++ b/arch/arm/mach-rmobile/cpu_info-r8a7740.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.co=
m>
>   * (C) Copyright 2012 Renesas Solutions Corp.
>   */
> -#include <common.h>
> +
>  #include <asm/io.h>
>=20
>  u32 rmobile_get_cpu_type(void)
> diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-
> rmobile/cpu_info-rcar.c
> index 8fc4cd7f9de8..b9d8b5e57b5a 100644
> --- a/arch/arm/mach-rmobile/cpu_info-rcar.c
> +++ b/arch/arm/mach-rmobile/cpu_info-rcar.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (C) 2013,2014 Renesas Electronics Corporation
>   */
> -#include <common.h>
> +
>  #include <asm/io.h>
>=20
>  #define PRR_MASK		0x7fff
> diff --git a/arch/arm/mach-rmobile/cpu_info-rzg.c b/arch/arm/mach-
> rmobile/cpu_info-rzg.c
> index 1c18fd06f0b6..4ade4bc02198 100644
> --- a/arch/arm/mach-rmobile/cpu_info-rzg.c
> +++ b/arch/arm/mach-rmobile/cpu_info-rzg.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2021 Renesas Electronics Corporation
>   *
>   */
> -#include <common.h>
> +
>  #include <linux/libfdt.h>
>=20
>  /* If the firmware passed a device tree, use it for soc identification. =
*/
> diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-
> rmobile/cpu_info-rzg2l.c
> index de4892ee901e..f69649dc7eaf 100644
> --- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
> +++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <asm/io.h>
>  #include <linux/libfdt.h>
>=20
> diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-
> rmobile/cpu_info.c
> index 6804b1da2cda..895c0f5336b6 100644
> --- a/arch/arm/mach-rmobile/cpu_info.c
> +++ b/arch/arm/mach-rmobile/cpu_info.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.co=
m>
>   * (C) Copyright 2012-2021 Renesas Solutions Corp.
>   */
> -#include <common.h>
> +
>  #include <cpu_func.h>
>  #include <asm/cache.h>
>  #include <init.h>
> diff --git a/arch/arm/mach-rmobile/emac.c b/arch/arm/mach-rmobile/emac.c
> index cb9bce0cf23b..95651626da4a 100644
> --- a/arch/arm/mach-rmobile/emac.c
> +++ b/arch/arm/mach-rmobile/emac.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2012  Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com>
>   */
>=20
> -#include <common.h>
>  #include <net.h>
>  #include <linux/errno.h>
>  #include <netdev.h>
> diff --git a/arch/arm/mach-rmobile/memmap-gen3.c b/arch/arm/mach-
> rmobile/memmap-gen3.c
> index a68eb806b353..4dff9e07629d 100644
> --- a/arch/arm/mach-rmobile/memmap-gen3.c
> +++ b/arch/arm/mach-rmobile/memmap-gen3.c
> @@ -5,10 +5,10 @@
>   * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
>   */
>=20
> -#include <common.h>
> -#include <cpu_func.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/global_data.h>
> +#include <asm/u-boot.h>
> +#include <cpu_func.h>
>=20
>  #define GEN3_NR_REGIONS 16
>=20
> diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-
> rmobile/memmap-rzg2l.c
> index a08d0ea08fc0..9934a775220b 100644
> --- a/arch/arm/mach-rmobile/memmap-rzg2l.c
> +++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
> @@ -6,9 +6,9 @@
>   * Copyright (C) 2023 Renesas Electronics Corp.
>   */
>=20
> -#include <common.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/global_data.h>
> +#include <asm/u-boot.h>
>  #include <cpu_func.h>
>=20
>  #define RZG2L_NR_REGIONS 16
> diff --git a/arch/arm/mach-rmobile/pfc-r8a7740.c b/arch/arm/mach-
> rmobile/pfc-r8a7740.c
> index 5d42a68266b1..4f4847699b07 100644
> --- a/arch/arm/mach-rmobile/pfc-r8a7740.c
> +++ b/arch/arm/mach-rmobile/pfc-r8a7740.c
> @@ -18,7 +18,7 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
> USA
>   */
> -#include <common.h>
> +
>  #include <sh_pfc.h>
>  #include <asm/gpio.h>
>  #include <asm/arch/irqs.h>
> diff --git a/arch/arm/mach-rmobile/psci-r8a779a0.c b/arch/arm/mach-
> rmobile/psci-r8a779a0.c
> index 6a85eb22cac2..b6c49e731f9d 100644
> --- a/arch/arm/mach-rmobile/psci-r8a779a0.c
> +++ b/arch/arm/mach-rmobile/psci-r8a779a0.c
> @@ -6,7 +6,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/psci.h>
>  #include <asm/secure.h>
> --
> 2.39.2

