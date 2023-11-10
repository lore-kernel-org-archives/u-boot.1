Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D45C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 00:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A306087522;
	Fri, 10 Nov 2023 01:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.b="A/eHNPrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07FF87522; Fri, 10 Nov 2023 01:51:36 +0100 (CET)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB6B87259
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 01:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/poF75Ml1n35KvbCGebmiHUQmSnBkjs/9sSVaZH8lWYA1luSy/LegbqmGNSN6lGL2Dvp/mqJlx0Ks8O05akcByZ9dzhLnriH2sJZbeL6veXSKa0u/kgeSNj8ZVEyrfiJIpo+N7YOT0NMcNX8UyPCaT1kQEJ8wMq/o2hk2UDJRnapyvi+AAJ1Pgtr/pDn/QeepvaQdgtFit9ll5BZtI6FHI0E6gW+gdJfHIYfip9y98ve+pQ4zINX5B5YBLWdIZL/wuhH/zodZ5xN7wG/O5Imkg+njOQCrCgeanBpd2kVi7HoseuvA0m4o2xOkI03nTDovuxvlSdlIpU5dO0dNPmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm4MW7zFzIa6iWRLFV9y+b9k1qL3pRQrDj8sVsKG5ho=;
 b=K34ImhO2hp1rBwWNG/jE9mJWZ3vaURNyvi8eGqz0mfn1ezqi5Xu1MuzCa5xNm0iEl1TwnxPyUA0PXLS/p9RAvahr4+pAgSoElvvTeFmw4JmC6j5Fy3YVB6z1gQmLjuPmC3p3RnjNfM5WBRCl7ptG4YZIKwi/eETBqaaPnKISB8mng8trGZ84auIQzlszwxoTtKP5EQlNig0cP3Oz4JUY2OAjTkgs0iQYkO+H/PDTVflY9D3AhPvfiQZb2LFZ4dNyzR91Mb7xlpXDslL4tKp6sDNSdi/F8zlxT0tjkJbDL9QVJcoOuPEjvefOzC0Ua78DnmUtZ0trHfwO6LbV8iY6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm4MW7zFzIa6iWRLFV9y+b9k1qL3pRQrDj8sVsKG5ho=;
 b=A/eHNPrn1S2Ge9nhuktBoTQRNVnQn7i1qt6e8Mp35hRudM9dkfaRQjoqMoON973ckIN1GIIlhFD6kyiKubXMzgYNO6jwajDiyrWGJ0xoxPPvUlrrtv1RSz4OVoBuU452am8AMpdM447np5+mAWFf52HQOl4iSpx9r0E+l5S6dWg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6256.jpnprd01.prod.outlook.com
 (2603:1096:400:7b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 00:51:14 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%6]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 00:51:14 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan
 <peng.fan@nxp.com>, Nguyen Hong Thuan <thuan.nguyen-hong@banvien.com.vn>
Subject: RE: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when
 possible
Thread-Topic: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when
 possible
Thread-Index: AQHaEDmGGWduYuUqcUa7n2w+i8AfcLByvlWA
Date: Fri, 10 Nov 2023 00:51:14 +0000
Message-ID: <TYBPR01MB5341C03B4A780105315A9E4BD8AEA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB6256:EE_
x-ms-office365-filtering-correlation-id: 518adb4e-049c-46a5-fbb2-08dbe18723d9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkKznyNBjbGPXwvG8aJ82F/jEgCIP6boSGVCEAcc4J+yl8DknAZO0HJ05w0SvTAQcI/nxfAKOAFk9tnOQ7Q/yBIBOykdYWpApYFlJotsdKlTidGLXpWx0Qz3hJpzmhriPUHWdxyJ6G2nLOqHD01Owe3kzoHEVbtchQRFgeDZAcnHVNOdGbP9xeOIg7kL7tU80dAL6i2mZFecXS8+vi/fR3Llvt7gzslS+wDMRqPfEcLR9gI8ia5dZ4tQjqV6y5CZ8fg1AVMNXRD3Vtwap1E/G8cV71ws8Oo+VgV9UW6FfSLSGVAb85blVUo6MBFaSJBc+Rd7PQqD7b0TNI4V2VGjDPRHFkm5a0bilk3Q+uDjgsjnSiLJx8Z1vTY5oKeBPPaUF39mo12WWxyLliCfPBRcklkb+yw3IjCgqo6H2uHcuXwHSVggLw1C/vvIX9zLtDAc0roZrVvoSWq8UdJ3kNjiMLgRX/KJZuU+01ji0HxeroeKc5PX187AppRNfPUKyHVj2A8QyTlEsZ/A8By9zrmrV5B76qhmQZmBcebLrjFVrFjPCEbaZiKJbOxRsMmsDPC6OVMXsVYmtzCwIxaYeq9v+dRRFV7li56kornDrH2SKetcNO6dtjDATaCSNCe0QdNv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(316002)(66946007)(110136005)(76116006)(66446008)(66476007)(8676002)(52536014)(4326008)(54906003)(64756008)(8936002)(66556008)(71200400001)(478600001)(33656002)(41300700001)(5660300002)(86362001)(2906002)(38100700002)(7696005)(122000001)(9686003)(83380400001)(6506007)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZFiIq10Es3edYF6xUy7qSZom2YZe+Zh3QI7Bhj7k4iDxqldLKsGgQ7aMCjT4?=
 =?us-ascii?Q?Wu2ze+tgpoOHIieRVYJORrsptPNa8jvF2l0yDllIPZeBSMXNofmqWQLTmOnx?=
 =?us-ascii?Q?8waM2Npl6Uk01IBJsQcF1RWV11B8LI3ALPzhKDSQr4/OlkfE3Z7BNGDYimPS?=
 =?us-ascii?Q?7jh4CHMcog/8pO7GgweCRWkzH6D3W1UmV0M6YqR3f3BgqaZO2fbMBAJognte?=
 =?us-ascii?Q?JXQaYRX9POc2gHTroMGFfTDSXVk8GNJLbab6iPbLE1HoBOI99whnNDDc9J56?=
 =?us-ascii?Q?Z6qhXbB/1Jjv1TlPKsdIp8iWykQ9dSGCfVqJ3e9HzUvQRFV/IbnO0GqzqURh?=
 =?us-ascii?Q?ri7R+MWQpeRMIoLoBIPWLLuKVvHYGfJWAH+GSDV3MaY+Hni4E2d9fTlXoLrf?=
 =?us-ascii?Q?Pgge0CfB03btK//YmSNXKv4dVyEndHClOw6QjC5Ahe7dkaJRDfXmUU/6hOcb?=
 =?us-ascii?Q?olyim4ph3Zt4uBcYOR4NrUnzYtf6hyBKEF5XzDVU+Vj5jmGIY3OfrTSG9BbC?=
 =?us-ascii?Q?ODT0NFdRpb2zvi498eXRiDxsjAsVh7rvSYV8VW/4SK7Rjn0dDIba6f8RQ0dU?=
 =?us-ascii?Q?wRvocaSxIFsbVUCzWFt1dD68CuLH6it1Pjo1yp3KZO7+Djq+45Brz+FarT0n?=
 =?us-ascii?Q?9IN+t2/ce9/c9SyiLof3YG7oNclkNMWMPn3L5sYz5esxuu/ZKSc2BS/lCuJJ?=
 =?us-ascii?Q?Vkmq0HeGg5UX4/NApVeUH9sNwG11odfuq1MTDx64SVR7uvABnIwSDZQ1GkvC?=
 =?us-ascii?Q?kIcrUmdEtNTi7XTP5Bi6+8qSRUERSSwSbMLwCAfzs29wQ3lsAfbs+JIlPzVJ?=
 =?us-ascii?Q?ANJIaZ/xx4o+YuJtoxIYcS5Gef88MekIUxSwTcDR8HOrQ0ZWmpnUWG5xPxR0?=
 =?us-ascii?Q?Xw+tDd1yq82lpGsr66/ZbJEsFP5ExzYgHSNbbpf/aDpul/cPBhj+bhigqM3p?=
 =?us-ascii?Q?5BKftDdhKsDej6vHKTiePAWXGiMpln9AESgtzi7pLy+zm6P0Zb2BqvipLzeO?=
 =?us-ascii?Q?13Qs3JWRquJnF/35kJEx+asO+O93Zd4P9HdFVX85eILL/3EDTlWn9Hi7/AWq?=
 =?us-ascii?Q?+AePeufa2W076qBKvSPY1ZrtCMQ8tTmypoSjW0cWQdBcDU4qkg3/EhNCVT/4?=
 =?us-ascii?Q?W13MShK24PvDjDHvT4bYddqxfGsiNAYvKfpjLp2IX4xxf/HMe0moNAucseuo?=
 =?us-ascii?Q?timP+AAoLEy8ppngpOBbszQOWrGRvAVMkCcg9Q2zrf3UoEoteb248qxv0Exl?=
 =?us-ascii?Q?3FfnIvTy5MlhFKAp1ZiEMjmuY96iUKWuU+mSsYMfgV6OTYF0N1uHn8SPHQHa?=
 =?us-ascii?Q?QQA3KXAdNN4PZSposxiXuc+GgIR6pR2sTeVZvbdQNN+FK5nTguZFO0Ixl7+4?=
 =?us-ascii?Q?VqYizgSGTU5Jpdj2RuAWpNlF7MEPQUYlOl9Iwk3oTVEk48/JmHPGaQz7FSMG?=
 =?us-ascii?Q?6R3/yYvDwlpnEeDs1luNAeTMPiqlzWjtXqV+Wnhz9Op4agz97mG4KPWhjHY4?=
 =?us-ascii?Q?iBlqi8YAV/JqmtPnoIsnISyGlEg9cyaQinYdu/4yeNx2u5T1tLqqQoUP+ibw?=
 =?us-ascii?Q?46CjZt/tTo1HhXcU2pCCDXKNInTJVdiE9XURYim7w8JkQpvfCHisFpqjkcIE?=
 =?us-ascii?Q?815pYAgxx7S9GHfV7agveRfQSuGPh9YmRwmEzYziAU/uXiHRCvFU8JN93Jdm?=
 =?us-ascii?Q?8nivdA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518adb4e-049c-46a5-fbb2-08dbe18723d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:51:14.0766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wADOSPyKicu8WGUDppPWiPHQ3Z3/9VOTIe8qP/Iyan9RXJcuZYJFfiMmvO5qKIMF7ir9oaS7+Hbsq1YSv65xYd8UMsK2PvvaTswvpYGD4LDmM14NlL+YUH9vDu2JTHRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6256
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

Hello Marek-san,

> From: U-Boot On Behalf Of Marek Vasut, Sent: Monday, November 6, 2023 7:4=
3 AM
>=20
> Currently the renesas_sdhi_reset_tuning() unconditionally leaves SDHI
> clock enabled after the tuning reset. This is not always necessary.
>=20
> After the driver performed tuning reset at the end of probe function,
> or in the unlikely case that tuning failed during regular operation,
> the SDHI clock can be disabled after the tuning reset. The following
> set_ios call would reconfigure the clock as needed.
>=20
> In case of regular set_ios call which requires a tuning reset, keep
> the clock enabled or disabled according to the mmc->clk_disable state.
>=20
> With this in place, the controllers which have not been accessed via
> block subsystem after boot are left in quiescent state. However, if an
> MMC device is used e.g. for environment storage, that controller would
> be accessed during the environment load and left active, including its
> clock which would still be generated. This is due to the design of the
> MMC subsystem, which does not deinit a controller after it was started
> once, the controller is only deinited in case of mmc rescan, or before
> OS boot.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Note: To address the part where MMC device has been inited once and
>       is never deinited until rescan or OS boot, it would likely be
>       necessary to implement something like runtime PM, possibly
>       based on the cyclic framework. Basically, keep track of when
>       the MMC was accessed last, and if certain time elapsed, deinit
>       the MMC. This could also be used to handle card detect polling
>       at the same time.
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>

Thank you for the patch! This patch looks good to me. So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Also, our outsourcing member tested this patch on R-Car H3 Salvator-XS
And it works without any regression. So,

Tested-by: Thuan Nguyen Hong <thuan.nguyen-hong@banvien.com.vn>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/mmc/renesas-sdhi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 8cd501c5f7c..97aaf1e4ec3 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -318,7 +318,7 @@ static unsigned int renesas_sdhi_init_tuning(struct t=
mio_sd_priv *priv)
>  		RENESAS_SDHI_SCC_DTCNTL_TAPNUM_MASK;
>  }
>=20
> -static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
> +static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv, bool cl=
k_disable)
>  {
>  	u32 reg;
>=20
> @@ -350,6 +350,12 @@ static void renesas_sdhi_reset_tuning(struct tmio_sd=
_priv *priv)
>  	reg =3D tmio_sd_readl(priv, RENESAS_SDHI_SCC_RVSCNTL);
>  	reg &=3D ~RENESAS_SDHI_SCC_RVSCNTL_RVSEN;
>  	tmio_sd_writel(priv, reg, RENESAS_SDHI_SCC_RVSCNTL);
> +
> +	if (clk_disable) {
> +		reg =3D tmio_sd_readl(priv, TMIO_SD_CLKCTL);
> +		reg &=3D ~TMIO_SD_CLKCTL_SCLKEN;
> +		tmio_sd_writel(priv, reg, TMIO_SD_CLKCTL);
> +	}
>  }
>=20
>  static int renesas_sdhi_hs400(struct udevice *dev)
> @@ -629,7 +635,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, =
uint opcode)
>  out:
>  	if (ret < 0) {
>  		dev_warn(dev, "Tuning procedure failed\n");
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  	}
>=20
>  	return ret;
> @@ -668,7 +674,7 @@ static int renesas_sdhi_set_ios(struct udevice *dev)
>  	    (mmc->selected_mode !=3D UHS_SDR104) &&
>  	    (mmc->selected_mode !=3D MMC_HS_200) &&
>  	    (mmc->selected_mode !=3D MMC_HS_400)) {
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, mmc->clk_disable);
>  	}
>  #endif
>=20
> @@ -1095,7 +1101,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
>      CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  	if (priv->caps & TMIO_SD_CAP_RCAR_UHS)
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  #endif
>  	return 0;
>=20
> --
> 2.42.0

