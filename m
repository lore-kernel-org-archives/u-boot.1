Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F221FC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 23:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCE182977;
	Thu, 12 Jun 2025 01:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZJvl+rvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9007782A4B; Thu, 12 Jun 2025 01:41:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A8D81FEE
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 01:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsC9C7KwnQfHorMxZ4t1lMu7W5TY+5zSa3QwuAw0pvsXKE/g79VFB4UyZpoCwmrKtPueQa7N1M0R0p01tcJosH5ELq4mg0j9r1vR8xNZRo+BbvvJZf0kUeUbXU6RMQUrdmKL9mKG0/1YA5swIJ7GuiO6Dn99+b/le63FxgTW/MQce/a/9Rrt+XBUfZTvW1cwobvWyoYW8U+VVcB5fZJBwuvVw+DFzYoHaRlp/WG/RXIF5DueztsFzDpLIbJRivWO5oatB/gsxschpGhH57JXaeNu6MsBmdr0xyrd/oT9Ly1FxnE3Fy5K+H2ZIUBlhe8wNvlb7rG5yQklgFbIYsnreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfp2apQR6gehcjr5vJcCVQsV0OZazGBd6IXhjfP/cRA=;
 b=q1gZl93N6077iZ1Ru5DWpkUZAFk5ua1N+EGWZZoQ54tNMOI8PyjReH+u0lE3vZEBWNBGIAr7mob5BO3Mqu0P51gqz/CLLyr4M2mo1/akX3dBSphxjeqtA4X9WG2RoJWTBbx1f5PsYLNO9SFyB5WwCCwiilGziMFU92SBOYd9u2hfGRH+00JwryzMmhfnRZJ1QWNrFQgS1H3KHXsjX8f1GcHMQoD7he8gV55fyOSqvfIoNFZ7TtILOh0b0xuSgJmqd2ka0o1CEEub2IKMYP3CPd8b1EMOF2BjXUhGb+hWMFRnDFF9Bp9mHhUrcYCnVhXVRyrN69HR90I97rtKjCjNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfp2apQR6gehcjr5vJcCVQsV0OZazGBd6IXhjfP/cRA=;
 b=ZJvl+rvTgwPya/57w/JOlgPhAxRmI3dnO78iU3JMa5XlM28pkNKMQi3yHW4b1Nmgnqf2yrArPMWXFxZhuzI9lNWanqB9wKnwaFPorM6RC/C4r/aLIqVpeBd6YYze7w1nm+sc6GiabpKtHeFah/6j+kJ/ZAwQA+Q9RopkxFhWJRbDBWuz14XBjy0Uyp/J+nMbhLUztdhNlrSGLGtuKmom8P3Vj+mp387Zj5zlihfEcfJqdcu+JP30f4c27psCwe6I5JlyyiYDKGI25R+JOob05zqEz0P+oFcNdMGniUgkfkd6wsbMQxNOKa/7hkxEuSzzNLlgnTOgcNFouUcVtK4zOQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 23:41:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 23:41:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 2/2] imx: imx91_evk: Remove for now
Thread-Topic: [PATCH 2/2] imx: imx91_evk: Remove for now
Thread-Index: AQHb2v7glI70JqKfh06MaVH2CbynxLP+nZ4A
Date: Wed, 11 Jun 2025 23:41:02 +0000
Message-ID: <PAXPR04MB84595F1BCB3A665DB97B50148875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250611183006.4044614-1-trini@konsulko.com>
 <20250611183006.4044614-2-trini@konsulko.com>
In-Reply-To: <20250611183006.4044614-2-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA3PR04MB11153:EE_
x-ms-office365-filtering-correlation-id: 429e7e16-276a-4efb-31ba-08dda9416d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+Xaf1Yk0Ulz1dh3C9uHiVABK99HMJXGo4K/E0cn0Uj21NyslpG4DmcYVz72n?=
 =?us-ascii?Q?PGqbA+1zN6B0CI7tKoEwZLW6TdPtNkTaO6VpuDo2/vrAOTUVcJp7VsWyCsN5?=
 =?us-ascii?Q?/6LyTRcH1ehbqh7ysuI2UsIjn+ING0whTOQ6XA0/aAE95REd3Li5eOm7Po9r?=
 =?us-ascii?Q?iOWfAGgCD6MYeHhH/4ISBpBPpPdJO6AzAHtIq29bQ4im4EUtBkoqwcdzFyOQ?=
 =?us-ascii?Q?ovkrPLlPB0rl7R7lnVoSDUe86sGX8ubTYh7vVypRU3N9oEnBj7Cy+PUtwseO?=
 =?us-ascii?Q?7Eb9g6BqgwiMcji6ZcmerORcZ+PgKSTsZXBRiiyefJWpmw9UA0vwML+k+Rp9?=
 =?us-ascii?Q?FSXP0eXWH5RynFqJkCSnZM4WTUgSOK9GUn6iVA7Pse+DwWFm5P4YOz5DGF/D?=
 =?us-ascii?Q?vWf8gsPvSY89Lk0B4tWlyirWa7MZeEXlKaddnLbVS4vDSfCpilm85rurhlJM?=
 =?us-ascii?Q?T/WLbkTeUjkke49HFaEv2W4RBkGAGPkEby33TcmTMxp/oDRj0IvylS1xUN6T?=
 =?us-ascii?Q?SUzpVy7/FfQpVrfbsizUwcZ3w8f6mio57XKRQL7gtdIP2e9cOHglx+Ve6ALY?=
 =?us-ascii?Q?W3V1X+pZ7K61g21/pYq48SVdQxwEDzRKJXdxOLYiW2rNOkveFzNUpEQgBP+F?=
 =?us-ascii?Q?3CgohR5cSwIP/QB4lPl6SeL+5YHoFWyJPY5AQsH0p/UNvwTbIrVVyFu9quEy?=
 =?us-ascii?Q?Umi8Y3frP6pkt3sekKLLsAw/CXjIlho5c34LnOaZ3cXaAYWd0wredmppcTul?=
 =?us-ascii?Q?JAcAAfyGjxx4sCM3a4GH1hHWGBjbUoeBxrAGi0wk7ziSWMKpk81vfnIpSXvb?=
 =?us-ascii?Q?R80eGEyWWjojcJO/1IX4UQNFjscTDWY8qgskCugyzCnCFdYG29osn4JQ5GQJ?=
 =?us-ascii?Q?6r6bInPAckl+/eL1xecdA3iJBGzpApRPxUQRgcYJUJKa/uVI4JsANau7O5cl?=
 =?us-ascii?Q?DQmhKcakF/nR5oC0ztpRvI1SekAP0/sAlnxCa3WZ6a5DvqofdUsdtlLTfAl/?=
 =?us-ascii?Q?6vwwDDJrlsWXvembmNEQWx9iF+qHJSV0O2JoEEke/iz/pxXr9x1cPionNuz5?=
 =?us-ascii?Q?2JRZqY1zhzvTKuiMtPpHjbSyeG7cQhlhG/Rb2V5waszsorXLOyxzeU/NC7G0?=
 =?us-ascii?Q?wSQSvuiKYDyZ/whl9orcfoe7ZBLcgp8ZRjNx5maeiB7xArfx80cMqTh8jvYb?=
 =?us-ascii?Q?y6vw+iq6EN7ARDoERynffUbH459Q/G80pvHCjT28WiTkow7fgSV9XBnGHHBe?=
 =?us-ascii?Q?DgkHxu4CdyAv/5R10QQMnbSv3BexwsB1sLXw9ZbZuuwFBuRWZZCHNUv8fzQE?=
 =?us-ascii?Q?4zVw7qV/84jqIbxj/xUxocizcpY69Yj9FgJz9miHrkbHJPjx3gThyNxN4MO5?=
 =?us-ascii?Q?TrS26F4eaccDMW2HoAkxKxivRBUAa995cUQxDRbcujz0y1UsRJ97OPcCOuDo?=
 =?us-ascii?Q?T22ZLchGugT5eHKWIvv7lO5Gbz0LjOssFeL6AulX+L/PMXD6DU8PpQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+8Ef/NpXx4cCF+tn+lQXThhWdPr7ZMbm/oc4+IO7AUUDIcPhiThQfxGpri2?=
 =?us-ascii?Q?cVOHXqvm9OHsiYRah80yZk61oPWHg+0CJqCNTez5XN1kWaQPmMTEM7KjntOK?=
 =?us-ascii?Q?kH2Cbxfl/V80dC26tLETci1JvWHXLKOTwDKxDzgTisATkie82Gd2FQ36cMV7?=
 =?us-ascii?Q?epCYPcZwEJypEfXNIO3Ii1K46owVvvGB0hHYNOpSLLm0epR39SRFKnMvVaSg?=
 =?us-ascii?Q?avLUTaMfbd2MjtNLM8+191SoVpwQI9n4FjjuE+2m+ELnV+dyZBYqilKm+LAC?=
 =?us-ascii?Q?+AHaHa2sASVIQifyRU+3Sd0J2GQWcDj37jQMNy/tB9qMUTRTJj+LSxdQGO+7?=
 =?us-ascii?Q?lgddwc+7vu/EGMrRod2WRgGu4HllC3C4E/BArmPyeDbQ3KA4lkBC+at+YqgG?=
 =?us-ascii?Q?1mtaxqOkuxq0tmnHrEBLcOI8/8JovL0KHjN4BoI6/3yaC7Wpa2OsjoYP/kTu?=
 =?us-ascii?Q?ppXqr8RufT/jdnBOAupr/OUNmdX4bJqz2dMQgw7YFn3hNhOphYglZEuU9kRj?=
 =?us-ascii?Q?Cf07GT0jeSROH6185pB8rhdxAgH3Dd5DEB05vmlW+DHRhVLbK94Q2XsaPEdu?=
 =?us-ascii?Q?T2TGXvA1payR0+rGwvJoldfs4T1hL/0Pc2tlO+MRk26f+9cOIupcoxD1u/cJ?=
 =?us-ascii?Q?ocRsvHgBses8iZb+reBN4Sgp1THp8+9sewFWoUsq9gwvxVJDOpCzo3G1pNPi?=
 =?us-ascii?Q?kf/oYp+zFpY9oAsJ9O3X8cx428fTuSIK7nB8tLASllysKThWVsY804DmlN5u?=
 =?us-ascii?Q?Kx37flTGTWVdkOpFd0hjBDQKDhHwkDjg2f81nPWULiRxKL3Ha3EtIgZPbqk+?=
 =?us-ascii?Q?jKOvjW7ZhMePSHycOt9UinwJoKePRrfKeloAaqJSoRDmCxb89dqK3G/atkgp?=
 =?us-ascii?Q?NgwOa9VNgqi5+rdtcH9pQGNbxe4xyruxrffxoAiSZqi/pahSArTnST+F80vh?=
 =?us-ascii?Q?rTWMvzjb67IfWd4vvmmNByoV1YOviToNwlt8HDQjJakp0rVtHEj6aVOkQIeW?=
 =?us-ascii?Q?VHeHQUFeMxYnQejVoApi2l/gzP3bn6QMC9GM38E5BHO2sIpamgLnmOz4ZO1Q?=
 =?us-ascii?Q?RYhoEO03voEBcHTwgS1UPtKdWdp8QxuStr5NU9Iu0RnFpS4I2jnx4drtPERn?=
 =?us-ascii?Q?sUeGl0qkvy2G7KjS4nJiINJYXtlRFX21TePPtWRPMbT7G9WhOwFLEP/QP18X?=
 =?us-ascii?Q?o4FgqSR+AULqAiDWZsjIZNpbazb/iWl8YRlJNS88KI1afAGydFB5eZlc+ybZ?=
 =?us-ascii?Q?gwd0UblVHJdFXxPcigEm8L+7OcdXqAjh+KLU1/ODc//SCxD/yY6q5nm6kHWA?=
 =?us-ascii?Q?cSKkymaaRYhkNKOuWy0gn5E18eoeehZCGZJHUZzi9qQKm9iA+Xxn1lKaxgI2?=
 =?us-ascii?Q?KMNiR8o0344i1W04dUiuCqPzXzgPJzpyZORyMCvTlabfsV4hdhlGZnYou4lB?=
 =?us-ascii?Q?4frij8UOSaluk1t+dD7trSHYiTwNIX67tsMc4fmhoTv37opSSRrsZk3MKy6e?=
 =?us-ascii?Q?9RBw5qlaFZG+g69X+QY+Lp6MSkOqQ+8doOPK7qJHe3SasPhWgsxsnAoyaowL?=
 =?us-ascii?Q?fcn6St0YbaZLspONYdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429e7e16-276a-4efb-31ba-08dda9416d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:41:02.8156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTdssRKQglYbnM7upP8Fr53CedNqbV9Lpi3cz3XXn8H7VWTNKeNj6A8JJjBP1gPIBIceDs3Ca92Lj/o9HFO2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11153
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

Hi Tom,

> Subject: [PATCH 2/2] imx: imx91_evk: Remove for now

When I did this patchset, the i.MX91 DTS is under reviewing in linux
community without major concern, so I thought it would be
merged soon. But things went the other way.

Since i.MX91 dts still not landed in linux kernel, should I
move the dts to arch/arm/dts, not leaving it in dts/upstream?

Then after linux upstream done, we could move back
to OF_UPSTREAM. Does this sound good to you?

Thanks,
Peng.

