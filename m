Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF2ECE59A
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 00:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD96D88B6C;
	Tue, 10 Sep 2024 02:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ab1NRkjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE29888B6C; Tue, 10 Sep 2024 02:43:40 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E3288EA1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMXiSebI/MZlD1SMvD7oSnczhehjhx+e7nDEKuYjGffWzicEbGxDR28BGjRHK4F+Twuza8KlsJieOqR65+pGwchOAeKrbwGCcwsyA5rAohc/yLPfNKWVruuAVvY1mnXhFBEWkqmuWeHfg0lVO30mvWeIDAiiS87p2jXebK+L4Aq/tOe/GXbhZhmbwuLWzFfW4CGhnHT1yZf/wCuSQdB6QtzGnhwisWTkTAvrE1R8GGyqaOV77J5vhhKxT2uwhz+TZxX3wKF+N2c7eL8OnnISbIRNGqwKUyNPlDixJxE+mqMJa0Vyy+O9Ydd1h4Fh1ejD4YO/RmGLgrgC4Y2vV0f5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoyYPCPifuW+g8TKF6pSSHMpI5HEJV0eSwTKl4+bVZ8=;
 b=WI4/GZ3lezj9ww2F47MF1rOhvjpYjojjjcD9Me099Y6CtkBH3xIvcUwkI4qfpLFHjpW8/X1WKBcq2dEwa9j0PBQfPYl+QpaSKdOwTOI0WgtT5nLj4T6IkuFAqm3RyeW3t19sFkuyGc6k3KrN8tkZzpUt3KRMGuSnIljmcPE7wygZhBEXdTUUYFpLNac7Ez8xRl8tsKSQ0FJdkzLRKh1cfQVOzzmcb2mZaCRb+Z8LSeAZ138nxhlkv1EWStHujC6qtNHSatQvpEMgdjvprUGw474+QyektTBcYIBDMDQPtChfIjDUCcfHustIkyHYH3ZOkHMkxbpcfgRo61p6fR8vMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoyYPCPifuW+g8TKF6pSSHMpI5HEJV0eSwTKl4+bVZ8=;
 b=ab1NRkjKBOgZjQU287PDoeqCr1UvzEtx1k6lBQ/3qpQ/9jFKk9u2pZse6xwV2nSIdq0lbq8pypRH7ao4p/k/2mab0OMjiwhnTw3dPVaBDyaCUe6ckCzgI/ax/N9qLg17mlQICqSG5XTiNGt9MwrtmSvVv62BvDFZKKtCFBp3ZJLA0xalbY/bfA0s8viLm2LDlRWj38nyowppHRcVhdeCSLr3NuXo5M0LlJ8uZlDVO+Pp2StkIshXDg5EmYoqKDlzI125dA6YtvI80qlHDJ4C8Rui3Uc8PJEC36RoYM3doYFdf06smp2Hes2B2lQKhifaokRV+kuaTvO1dIZCfoM50w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10207.eurprd04.prod.outlook.com (2603:10a6:102:463::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 00:43:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 00:43:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>
Subject: RE: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
Thread-Topic: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
Thread-Index: AQHbAu64EA9y8RXJwUa8XurSFjVha7JQLvNw
Date: Tue, 10 Sep 2024 00:43:36 +0000
Message-ID: <PAXPR04MB84594DC78FE974701A5775C2889A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240909193003.707732-1-festevam@gmail.com>
In-Reply-To: <20240909193003.707732-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10207:EE_
x-ms-office365-filtering-correlation-id: 159e65bf-89ed-4b78-12ea-08dcd1319b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mLzmBkfRQSVqEsBefzN1jQlEw5qUqroGQWuRGFK9uJ9m8zyq/nQviZvSocAx?=
 =?us-ascii?Q?fP7cLxq4ioH+mfg2e+0RX0qIcaKPJlq/FLZ9uoUuDYIEksYadpelQgcu7K5Z?=
 =?us-ascii?Q?GMgRKB1D8nAJpmZ6mIqfnHd1LWmH9Q1xzbf0w3sPwUj1A1K5wpBFPLKIpV8i?=
 =?us-ascii?Q?ETpG1vWo05tsbH6etcaDQF/Yz/fCn/liQxCmwExkIkAWe1qM835mLFlUSLpk?=
 =?us-ascii?Q?eVg8keQgCOMrIBmpjfo23vJ/BsseVv5GjYZeZJB4DEq3UNFyOLEKWjMex/lY?=
 =?us-ascii?Q?H6y9rP9Pie+EF5GruvqO0B4aawe3LylPfgRGriaIY8DGj2VtMNn6ofTW6T23?=
 =?us-ascii?Q?bMsHChDMjq7xkUxRoZxojlCpXANBCppqO/c+WpFOtZC4pzj3lAeyyNw0aTbA?=
 =?us-ascii?Q?PAZkcCeAyauvqlbzoaeEjwmEppq3Ma08BxHoRd3/ydDom4TW1jAWLogCtBBE?=
 =?us-ascii?Q?7FEiicxQDvoVPdrzL0PJOw82ubTGIdxV/tGAg/7YJDPLy/wLOs14kXFMjNWh?=
 =?us-ascii?Q?7CmytSlNJ1KoqIe3ZfzZkTRIjm2kV09ftbhafhxaRG6DHk/xYszGXiBm4bVR?=
 =?us-ascii?Q?WfW/r9Bx/LHsqEP/ThpXg2Vb3w3P8kSsy+20//p1zHfbCZT7uyVuj5ZjSQu7?=
 =?us-ascii?Q?Tt1f7cKVE+UOlfqUebzlOD53JejmZunXVKN/d3MHivNojx8bzxFElq8w+QVz?=
 =?us-ascii?Q?Sugu4Zb83UIY/Xf1XO1Ct8Eu7sLAilASMOjVn76+dVH4tSauFT0sGZjUeJfI?=
 =?us-ascii?Q?IMNhrtCk9I1QUQ8wYKHopWTBcYyTJ9EKHZduM1A2k/bJFj3tHRnVbFuXLxLX?=
 =?us-ascii?Q?X9xbd/BOqQO6xLCQfrLvwtZIh8QuRbSFr5qSD8K/3hNBsE0AjabxqHcNrKj2?=
 =?us-ascii?Q?sE9PC9JWpfg+vZ7wYmrABfVg/0PISDJubsIqOCj2IBrSH2960i0gISvmpdCo?=
 =?us-ascii?Q?onH2ZKxrALcU4WLAQVgu4W7vAmyoLODJUTeyBSDFctnUcxxXBPKHGatN0Rc+?=
 =?us-ascii?Q?dDL1jlpCr5M3cO61WzlreOdHbO2z/DQtPZbi4ExDWNqHhIqPWJzrDjmZGijo?=
 =?us-ascii?Q?YuZICRE98H0L7b5iPE8t6+8k0lx3q3JGzy6JcUH8QVwo/n0xLOylNWyRFrAi?=
 =?us-ascii?Q?bF6m8vwPCVV8GHcyolvxGiUMk2ZiXghqt6xFIge4HupvhN69OzYgeAYzfZ61?=
 =?us-ascii?Q?IA+s0C8QG8tkxRWL1VAjOqYA8BYFQ98rcYfGyt7VU0lixvl5iLjVG44e9FWT?=
 =?us-ascii?Q?FAeHjEHLbDTxJ7EHv958nx7R6v6pMVj6XtKhTkpamFJniIJ31NeXe3WcyMkW?=
 =?us-ascii?Q?3yKPeZeWEUNHIA0w4lnmEFKr3XAFf/OwPmGZWBmqx0YCNcrrbo+7wP9ioA2y?=
 =?us-ascii?Q?PSCeQ5s9DguOse/43GY7OLUeDz4GCYKYxAhkpZwbLkkhp9AXgQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RAlozjh6oe3QFUtFnhFYyZvi8h7zNWGIDO3VyUVFikPFFzTrfxU7fL+CrudB?=
 =?us-ascii?Q?jL07NgZD0Aon4EHe0xpAkSca6566B2i4bvngabbMfaoTBnsXtRzO2r/5GpSc?=
 =?us-ascii?Q?PiuwAyTSkQRx018vTzxxCwtFKXtIEOqDfMDTVVHU4IzZ2HEkDHpgarUDlcQc?=
 =?us-ascii?Q?iGq9iq9psZBVBxgu68LJsS9iDhg+78B3UZp+ww1Zy+k8KCbrJQaWN67tZOpM?=
 =?us-ascii?Q?C2DC2bXC+DTlGrgktmQKBg5CfMhwAczfGGs7uY1jo7QQNhWhSMrCDZ4McKGC?=
 =?us-ascii?Q?KelMvv6QRa51DG5UCveWCpO0lmlBfse4xkDfjzexACRzedMXZfWclKlSC88b?=
 =?us-ascii?Q?4m4AjZ+ejkkpT/5Djvk3zfdOfhMv5KmRcsWI3L7R02FnawBoX5YGvjs488PY?=
 =?us-ascii?Q?fGuJfrdOkff8jB9yFdSsQ/ukGu4YqctNomxSHTrPWQWvGVS2Pt4yxnSnqFu8?=
 =?us-ascii?Q?JkvoC7ghTnFqFbrTE7PcM3fLdQLcg1/4ZksSBjR+Oyr/UtrJiN6RmUGg+EMC?=
 =?us-ascii?Q?Qf4L/r2md/dZk4+bimc2q+sjG5D/4wZTGMOwhkNf8SEnoQ9d2UivO3XIn7X0?=
 =?us-ascii?Q?Vo+/qkBgHZIDLxjvNo6Qjfu13CGrVVQYYDwNsQqXJ+7cuXQ4NFoXvA75kN5O?=
 =?us-ascii?Q?NZll2/biAvLwVoUqC8D0D/QKOV5qgJqPQT6uSIWxEBuigGXviPyFhzRT2vFT?=
 =?us-ascii?Q?5RUnP5QMMXCczuKSPA4kXcilpFWJIZIe6tqRJyMj4pFhIGbs+QI7Z1kN7e7Q?=
 =?us-ascii?Q?TmffAcaJoOH3k/kHFCdhMyh7TiCufcDZHk2MEpAwSDwula1I9R+xMwFdZpZG?=
 =?us-ascii?Q?Rm1OiUfPxrHQ44Ikplx+iygnIULSp/NtDnHjwt4METixuV/j/2SiU0aqqtXJ?=
 =?us-ascii?Q?FZUthxXtCoNTk1VJOxf6y/3qcNltKmPgXr8JKiwFcVko1V5w/kHfuNBh2GOP?=
 =?us-ascii?Q?bItoRzjnlChI/ldY5KFSpZxjAavQj75Q3cq4RVZGUNTD+SN8lts3QE6y9Gmq?=
 =?us-ascii?Q?zJEmVUPPmuM92q+AhmkinOuNQYpKLxiAPeerx/DzeH7jESRz5dKbc3SSlVz2?=
 =?us-ascii?Q?/3aeu9k53kUlFbZxQfosJ6rQrdqHvi/1qY4yZefNPBxQZVgnsUCBdnGF/sEt?=
 =?us-ascii?Q?bUZVyOOj57RFiLZcyGl22XndggfrPBe8z5R5jOhuNxR02FgIPObsAt+h3XxB?=
 =?us-ascii?Q?1s9DmX3/9GpS4QWIpJul/c0c+qmuUO3Ihd0K8fQPSbVJ7mLvZZa4TyjOzjxu?=
 =?us-ascii?Q?xEq3oBWMlsrMHNMHVrdHJ5Eg6SNcT51k+MXPZHsmyC7f219EABYLt0ur2QzB?=
 =?us-ascii?Q?Rj0rrW2eIJTKkVT1+8odJOnH4EIfJomoOnGaRzaH4Z7mJcJCxU4HKHTcB/Fo?=
 =?us-ascii?Q?ZxSW+cTWDaLDp2SF3RKknDb0RkinKP8HS4rx3SI77Gyc3TcscsqBYoYJeAbR?=
 =?us-ascii?Q?cZwKxDGOw38gsSMCmKjobRKIIbQAM3qDS9/eKKiw4B9sSNLyPiJW5HzTQ+he?=
 =?us-ascii?Q?Pckp/IpvCB2n/zNZ4xV6DvpbgZS6nCkgR9tXV6o07Vnp8ZNSOrk08ZOup7l3?=
 =?us-ascii?Q?12XFWLcMDbTgTYJOLi0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e65bf-89ed-4b78-12ea-08dcd1319b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 00:43:36.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCdiqvi44MqkDcVHP5boir2jMwRGEJ5K3mefIqpOIkPZEhfcNgHp9YWB6RyVyih2vCWgsI0ys7TY4WozSyNaSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10207
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

> Subject: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
>=20
> Since commit 37e50627efac ("ARM: dts: imx: Convert i.MX8M
> flash.bin image generation to binman") the imx8mq-evk fails to boot:
>=20
> U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
> PMIC:  PFUZE100 ID=3D0x10
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from MMC2
>=20
> Fix it by passing the offset property for the FIT image, just like it is =
done
> on i.MX8MM.
>=20
> Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image
> generation to binman")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

