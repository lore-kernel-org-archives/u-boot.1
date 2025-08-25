Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DA0CA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A154828A2;
	Mon, 25 Aug 2025 10:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KxZKJXXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E188D83043; Mon, 25 Aug 2025 10:52:39 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29BC81E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waBQcRuIR+oUUEoyxrhtrS6dDkbb7xQSFxXPUDl+fS5bwb4hmAsMaO6TH0OFq9acq49mok6qW2Oq5DdX+pWMEfYG7tBqc2gpdSXBrhL0KPNKSiDaAj/x8RI0moykL+7xcU4+lY9kJXYbOO2qYO7Net5er58YMrISVNrwv1rHQDzgVMWfokk5Gs5OyyQJlzRVLMLr3K3U5EfIzLmKVfnsDplHoSQugQ3TCu1iPS+00IA030IqgKSe39tBi4OC8z53t5ddMK9llVB9UGEaaZtZUQJdVIOXZDPN+CwKdGeD4/kZRhLGUQGpcHWtLdR7LPywu+00jyuM7leYo7LH34HEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI4WQTlkQXkLg2oDJSEAJ2QnfkZ9bGwADk2xFH1YB6w=;
 b=j8r2zP8WtFvQaWvBJEeZ/zAyZMGMYVSNv+BWdmQFKiUVD4qpCgr7SrmciwKm7OYdIEYm4FsAd1eBq6qAArZDNjTByO24El4PDzc/SHDCbLPBXPV7H1u/PafW/xHn4nJtLgF01KXxJIInQ3DWZ4bMpwhRMvOQWn/jWic6/IiE4l9vUVArcq4lVehuXq8WLMaylqgVqGA14GkA1cX00t6nHSB25EErubgfPRhqPLBezOULd+ZBSXN8RazfraHI/U6yQ15i89bAp2WgYLJJwVtKmukQVTWb/b/dK5aURiu3mWRt9FYWlRxkl3zqbxww7L2flqh16MxakVhyZPQKGKHG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI4WQTlkQXkLg2oDJSEAJ2QnfkZ9bGwADk2xFH1YB6w=;
 b=KxZKJXXcIEAqGEKjNBmGh64F9SkDNUzZcDxvBHB8hxA6McRjQbeYkPVzCRcPrE6cb3Twqhxx6NhzWjZUsQZurXt/5bMRUND5CEy05OwICz2wkZqXSHk/e6kxvisINXYsgl+MvldUW7McnBEu9/mHD+xmUWI+NmXAPd/KLi8op0B1XxZqK5fqezLwtKtooDoCtMflKGPCQYz8y18WLDVGRi6CxTi5DqoXIfiu/R+mjzMTnugwnBujBcPpe9I0BhVaJIaXJsagi9T84z/0QY1cFoHqoWMPP/BTi+dl3u4JlXBh6Z/FmhRGnCgfaLaLgz2MDuKCsSsvvgW6xm/6J+uRIQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BL1PR03MB6168.namprd03.prod.outlook.com (2603:10b6:208:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 25 Aug
 2025 08:52:35 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:52:35 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arch: arm: dts: stratix10: Add NAND IP to base dtsi
Thread-Topic: [PATCH] arch: arm: dts: stratix10: Add NAND IP to base dtsi
Thread-Index: AQHcEMA8OIX0PPnpoku5YQCWjcWlbLRzGaKw
Date: Mon, 25 Aug 2025 08:52:35 +0000
Message-ID: <LV8PR03MB81378005608B4EA6EE0D601EA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819041744.23537-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819041744.23537-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BL1PR03MB6168:EE_
x-ms-office365-filtering-correlation-id: 0388af68-048d-40a5-fb40-08dde3b4bc7b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WMELJWc6ubBebhLkYHZW9aC+FHdIF1shsrk5ihN4P96X1cBUaSQD6PBYIccm?=
 =?us-ascii?Q?4/I/MN5cKKVQx3umfI0yGZl3FZMfSD1tPLk9W/OVJXoFGPg0CYMUPh6ytzQs?=
 =?us-ascii?Q?g0BlRwuDYBI10LgVtMnNOs6Ag3/onExuXGq5vW0PwMx0KDCvD5GOR7T4x987?=
 =?us-ascii?Q?+PXGX0oew6j7BxvxBrlcrAulxXXFFmqOA2jd7C+GrfUfSLSPt+EygeDNH2/M?=
 =?us-ascii?Q?mQo1wOPiLAda/HdMpw4675JiaZc4J53r5903UJSCnQCBTvHRqJmL+ZJZUYie?=
 =?us-ascii?Q?ijCjoS8nfZeaWKsv7g9C42hmhnSoYd6OsgYzS2iy2JzUY8SNTD8vm5zjGgzN?=
 =?us-ascii?Q?qdFKXbxawb0YdoL2UsYhWSnJY6McxR6doJLXLSCmp4diGPLgDa79pfnBnt3E?=
 =?us-ascii?Q?5KHfR+KoBx6Du8Bj6CwFjGEldJniYEkd1VhiiXDm8hgBz+QDFV2zPtSNAUM5?=
 =?us-ascii?Q?wSL7kajMbHnvR64+vrlodgEnr+N7mU8sE9gZ4gwGN4aRqfaIJmRjNxyAbLmk?=
 =?us-ascii?Q?hmuR6gksnWgmfG0AzYeo0VGNOm1/KNLKGLrcoCfMFMjpxcRhfyozjX6X92zo?=
 =?us-ascii?Q?VAIN5E5HDSwEKRIYj5GJNuuE4GBmu3lhVohvRF75z8OSyRaMApbmGDWbDq/M?=
 =?us-ascii?Q?H5LSq3ABn06DM/tYnklWtfL4XvxgmN2ABUhe2jw6Y1x2cP5yJS5ANkd3UE45?=
 =?us-ascii?Q?Ylh4KhdkkVx2ftpL+M6iTpK88dwKwwTdho8u99YgszbRcAQSSoDAKnnT+J59?=
 =?us-ascii?Q?HsTI0WDr8MLndbXVuwpZkX9wLOkJez0nh9IiZu6K4rvRcK3+CbQHf9GlDbmC?=
 =?us-ascii?Q?uQ4zUW/jEq+5845r7RNLsbVIFhQCXxFvGdzy4wPhcOXbSBQoanktPBUYBRvY?=
 =?us-ascii?Q?Ao/nAp1YrjVe9m0TUQPZoVCuu3sO5B0LqHeEYCsM2uF+Q2UWYRkDZRj34OZi?=
 =?us-ascii?Q?yfCGCBk8UOWTDxB4vJuqT6WXWvt0DZZ2tTo1gZ9QwCZJit9lS5lF8+86W2Be?=
 =?us-ascii?Q?VGAxFPmhTUZ7QqjmC2V73MDHi+6pIibFoAebmI+wzPzH5V3An91cYsimaFNs?=
 =?us-ascii?Q?ylbolVjIUaxPIG1mMl5lxdGxXo4bnTTZNyUCtXk0Dqdjc0MyE++MPq/es0Mw?=
 =?us-ascii?Q?Y28W0kqhHU8oMysHyiBT+CC05lf2A8y4I/uh6S+TqIfuE5DChDYLl7h780mz?=
 =?us-ascii?Q?URLhFQeTnC6439QTLyjVKfpwTYL8fOO1MErDtSWNQZKOXJXs3M6ssSdFXfON?=
 =?us-ascii?Q?GKKGj0LciUXvqFVELdSI6OetWU1SzXur1t79wynrl/KJZjOg3PhYmjC5Uuu6?=
 =?us-ascii?Q?ZBGNNBnqwmXwlRUMyW+2bAniW3bD0NKHc9fW//qhDIoZQv4FYCS/vZ4tY4DT?=
 =?us-ascii?Q?cbKVPfIJmvbT1HicM3omyPfr9t3ohShi3cdH97rCD/8i+HYvahed4IP1uREa?=
 =?us-ascii?Q?WBjCxW+WEnU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5I17ZjUPc42hLSmjKJcf0lUMJarDZVYvmurm6Ao0qaTlRJrHfBXhO92nADYh?=
 =?us-ascii?Q?rYakratcvuT9JP7gLnd3mMAYatj4+c014CP7Avb3JTYLlwd4pFAkz/l7/JRe?=
 =?us-ascii?Q?Nd8+HqNE/memFDbh43OeO2FLezfXvejpenikPbAnq0YKy/k0Evm+hRsiCw9Y?=
 =?us-ascii?Q?q1eYQTxZDYWdaDp9wljuN7NIy+E8pVi7uS6xeY6g7HOMY2aBbZC2Re8nvUGM?=
 =?us-ascii?Q?TIoa6B5K7EiIOJykYL9SrjKTipPVMQyWU0bB1pZJVzG0nA1PwgdF2BPMy4U7?=
 =?us-ascii?Q?qmyeNgzTzNjL5fpQlpMLcqzpkRC4Z9VVO6ihe8T5ttbx8oDWrwsHxZvGiN+B?=
 =?us-ascii?Q?NujtrQcraaZ+wqhoOdiEcLsavF6CMw/v2iJqOJPikg5RADiZ0MbDzE6imxca?=
 =?us-ascii?Q?fmuit7GKn9YdyYk+7zvLm9GX81Pj9hJTmQQNNA1FI3AL2MNOYsgI5Al0x9cv?=
 =?us-ascii?Q?5M0G+UJTdfKkHHhhIIwN8Tp7w/HtGqkdq3uWWvXfPl5Yqpq3Xp541X74k4Dt?=
 =?us-ascii?Q?NLU+oCj7rkuPI7upMfnI8JGdBSUYth9W/D4agKvUxXRVSiZ/8pu0tY8Kjkbs?=
 =?us-ascii?Q?ayqeTFUwBabWa8mZIn+fLOmAZHA9bajEXrRQf5qpTJbCsYTa1RIFHiYLAoFo?=
 =?us-ascii?Q?ZlNCZOWGrU9rlt+W8n9OfwukqD4X+VGlfaIKhU6TONiYWLblK44WjQgAmdpM?=
 =?us-ascii?Q?zmfq63PwIf5dC+cW3QxPR/dQ6hLuNnvkreLYPj88v6G/r2F4bvE7eiyeekoZ?=
 =?us-ascii?Q?g6NOkwiz4dyNARcrsvox/cL2EHtizRlI5gmg2ehDBZNKOTH+JNl0SGynh6gu?=
 =?us-ascii?Q?zocZvfhQ5ZJi9CGfQ+vSkdHdW4e2cPuCUfIzpyXOyullW09XllM9cotJu6Uj?=
 =?us-ascii?Q?hl17U4AZiCSZ1yXtsUrj/suuqV1aY2W8zBRpwi0Jf7u3zrGd4cLCrNBpRJDk?=
 =?us-ascii?Q?ZtDnf9TQS2Y4Pg6Etth1aeFuNVh+Lz7Y4q61wqlHTLnZMFFewJcjLWE92/iK?=
 =?us-ascii?Q?m9UUUx1r6C6Gj8aQGz4yI/LoLe1fK6KWn10CiDb9uFOoevMI8QyUw18S9wkf?=
 =?us-ascii?Q?ly+RnpjRq83J5gkcBLMvUCf9BskZ6wWaMRCVP74PgOeg7LiO4rQkAkegcAsT?=
 =?us-ascii?Q?GkNkx3hNFl579xgvo6n0Dav8btLRzgOzfipkj1GDz3wCgNLRZs0CTrV0kAEF?=
 =?us-ascii?Q?xFzFY5uPfc/16RAIdAvx6ofL3fQLffCzXacdVxQOOhlqk26SEf6NraQ5XaX0?=
 =?us-ascii?Q?H0Qt2KjuwfD1fZaccFTHNldBaCDo9daGlDtASrEwYbGEhW2wmBsyoQwC07B5?=
 =?us-ascii?Q?S9kYYConmaRQjIZfR/qMtWUn/ZsgYIdLUNLlX3zGlj/phD7lbTG5hgWmpgEN?=
 =?us-ascii?Q?FYmwDVGkO1t1h9CkdtkimIuB/4j5YYrppC4S8rX/afrnvkFMCLwC8i5nM/Kb?=
 =?us-ascii?Q?h/vI9KuwxvInlbwR3WOxcxtuxAJyfp+enso19J0PQOo+ILS7vW+tQFZUysFJ?=
 =?us-ascii?Q?TbW7YXzTzUWAFTJqRl89uhlvsVzigcDkfUyoSVUWnqcJDfqTomqHDOOCLcJC?=
 =?us-ascii?Q?0fulI8eeprVCYhCXq5LMT2mqJHCh72rAFHR9Bc7U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0388af68-048d-40a5-fb40-08dde3b4bc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:52:35.2219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cei8IjP34Yn1Cwu45iZDBqZFNw1ndaEShCHaBVSUFmokwNl23nbcRIZO0q/x1BXd3mgweQjj4/EgEzZYp1pp3Rxinz5cCXARONn/j5TJVMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6168
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, August 19, 2025 12:18 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arch: arm: dts: stratix10: Add NAND IP to base dtsi
>=20
> Add NAND node to the base stratix10 dtsi file.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_stratix10.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/dts/socfpga_stratix10.dtsi
> b/arch/arm/dts/socfpga_stratix10.dtsi
> index eb82d663204..750b43d30c0 100644
> --- a/arch/arm/dts/socfpga_stratix10.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10.dtsi
> @@ -1,6 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2018 Intel Corporation
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  /dts-v1/;
> @@ -232,6 +233,18 @@
>  			status =3D "disabled";
>  		};
>=20
> +		nand: nand@ffb90000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "altr,socfpga-denali-nand";
> +			reg =3D <0xffb90000 0x10000>,
> +			      <0xffb80000 0x1000>;
> +			reg-names =3D "nand_data", "denali_reg";
> +			interrupts =3D <0 97 4>;
> +			resets =3D <&rst NAND_RESET>, <&rst
> NAND_OCP_RESET>;
> +			status =3D "disabled";
> +		};
> +
>  		ocram: sram@ffe00000 {
>  			compatible =3D "mmio-sram";
>  			reg =3D <0xffe00000 0x100000>;
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

