Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436FCC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46B888450;
	Wed, 17 Apr 2024 11:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="G5q5f+zC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7CC88450; Wed, 17 Apr 2024 11:09:12 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7C888456
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBYtig20VCrORAfzmNIAQKtp46/XhpKE+ycWicFFqDgekrF7UatosSAIoil3Itv2Cl/JaJqQtAsJ2bZ9JvWJJBfiBsiGhaPA3CZScXRGtyMPSXhU8eYv5nUtzYJ04oUHv7lyHiDQIqaz3GnATRFeBvShdfgXwurplDVpZsOj7prVOfITZ7g+adIOqltHpKHOAsC6/UR6TfzzKULvNSXnQroT3EtG0XMEIfuWRZKw+zoAGCRNnb2yXjeBrKImrviyY7OG7htDcFfInKNTHJQ6ORnqCwYeeCgZxeLoMn91ljRfsX98iGkPecCAkRoiEAJZsVh78Pn5+QBp35c+WLdGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqyNL8kNxPqexFYuZ44u/S2XWdLiKn7VGy3EPbEvc3s=;
 b=RPn5NTPBO7qS0o1ypQIk2GfUpo+qoDn5Xzi+utQABz3GvcCFMqLV3CfRhj3nl49MywZy3s5nBC4/bIZhqlpydlSacIHqyyOtr1gRJqsVId97stDfVe90TQm8x5mw7FuLI8hvgaBxUekjBgrCtaRtCIc8mVU4achikBqNKtTNNHYVtnDnxYYWdvbFyxsghSPn/245e50BHaqkTcIYvpVKWvuJ4Qrfmd4ohE45NYuXiZmRBftUuvgnsGMcp4NBhLswlU+L1bgsCh4hdKfmW7d8tE9vUQrzxZ3E1v4wHpA8ptxcfVhMXBW89l+EwREsq2OwhfKY+4hYH1+GN2Jb5/2x9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqyNL8kNxPqexFYuZ44u/S2XWdLiKn7VGy3EPbEvc3s=;
 b=G5q5f+zCSWW0rr/a5j+9opkoWp4IjVw+D5Bi93rFo3hJ1cX3Svt3XDIfSNqXvZmeRF5uMjU9ISSoEI1CuPV7nGMBSseiX0msWybRSTXN61Z/J8COZuWatSWmWui3M+3oV7pbbfu/of8EoX0yZVRZQ9dCI/+q32KjOYMWmcFBVXc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:09:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:09:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "andrejs.cainikovs@toradex.com"
 <andrejs.cainikovs@toradex.com>, "stefan.eichenberger@toradex.com"
 <stefan.eichenberger@toradex.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for sleep
 moci
Thread-Topic: [PATCH v1] arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for
 sleep moci
Thread-Index: AQHakKQj+drh5oRBtUmPqItNrN/OSbFsLGNw
Date: Wed, 17 Apr 2024 09:09:04 +0000
Message-ID: <DU0PR04MB9417FDB400F6C5762F1F89F6880F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240417084902.13904-1-eichest@gmail.com>
In-Reply-To: <20240417084902.13904-1-eichest@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9115:EE_
x-ms-office365-filtering-correlation-id: db90d431-f5ef-4e15-f754-08dc5ebe0788
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b63soOn4gXoBPrHNHjKe74/1ZFbUG1DF9gQcLrVMPH6WD3OBUbL88tI2J6XkQ0JrJWPfics13rE9WcV9rnGbvd04qnJ3NnDoqx72p/lN+T2yTs2s6X4WC7XTo69FmSnwli1nErdjQs0fxiFRh6XNT8oQJj0YyPKC0lMA75EP4GumS+9oYRzMK2oxqLDbFxR/2gRUk6cWxJoi0wu+NHqEaNBzb/9H/UHX/DGqh9vvU9ZNrbFFw5d6cpEzeUQwX59XNy/xEDo/3/Clvi0EZT/nYmz428USO8TnVlNLoXfzrCHHDuOojfgaXN3Kq5PJtD6kSIir6HWoL0w5u9YMFFYP8esR5XmExiLwU1xj7P+VFL87aD943hy5vj+oLh/4aHY+0zg5DBiygfUl11aHrDSbkX+uBQFz5d6exXHdEXu1EwsEyrHfAchGNf+mt2bUT82v6XefTYHZw+7J3NwfqB0t6NYf/GCIl83NidB+5+gtNMUuyx0e+6DtwV0+BrIFqrjEsSN+7foKCmvFUQYkJePgQvf8HvxfxM/1CZESCjBRCX+knBQ6J3wd9ezIJlbqzCDEUb0xIvw72/Y3et6eyk12tAnYFsRnPHxeenTjsLoFOvbVXv6nMlH/YBW8Gl2bkGcprvoPtkUXvLvANd305mSiv85RBr8iUSnlLD14Z2Jc7s90PRTTeyWR0dxXJck7uLWf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wDuB+G2hqucq8coywLcv0aY9BwjKDXuMa98A9niqFVgpQVL+FijzR/HWGLJS?=
 =?us-ascii?Q?c0larK+0MFu105JxWtPIa6dbMQTZzqQnte9rnvUx1ClVUlejXPl+OxmiYzMO?=
 =?us-ascii?Q?R7zkG6LEJxzi092cZLPl77b0sgSjxPGd6aTxXv1x4kXBWFcLnDN/HzrkmTZ8?=
 =?us-ascii?Q?gdMLvazRRZ3Ov/gyxOm7nzgdSC3TeaMB/UjYMzBulvCIBnvimr2g1zi20eIp?=
 =?us-ascii?Q?+NGSOLciKU+WZe4g/PtHuP3hWXncMRwx09ayppwdzXF5t99V6KcdUbB6j8cp?=
 =?us-ascii?Q?uOItBotYx/q0YoGTyZsH6c0gJGuxQB/ey2P+mNWJAyPylPD42SmnjndOeYzQ?=
 =?us-ascii?Q?OLcveKzAhEtQ9bPAL+TbNdmISWk3jOIwmbIY6ieNPQpSA+VzaKemcqYmf0s2?=
 =?us-ascii?Q?507j3COHMYs0kPbWUCgY6/xKHyOEMmZDvrGh1Fh/ZDIv4Kyg+eOoLeY6pU65?=
 =?us-ascii?Q?sFtEMmXSZSKnIt4rfAcvPfRQH09Yw4jlDqqrOwGoGKNg/YSGTeYK69TPDqqi?=
 =?us-ascii?Q?RzV2NjAPDsDVyGQPhimDUnCTW1qHRB3dCPM3Q1RJMZBBADRcF+icze5umRaH?=
 =?us-ascii?Q?e6VYMpaG2InTaERCLgKS+Wv5xR+68id/xhW2WBtk65dlqnV92uQf3ZC4YFNC?=
 =?us-ascii?Q?gsZCdSNsBeonkvlx1zUkIAbqqNHudOz7u2R+wWofAToU5GDxUiaU7geNRnzU?=
 =?us-ascii?Q?dSgbf6rfhb4ysMfS+jt9Ry1SrB10vHoT0PkqFvn6nUakJPsY8j5yriZbI9rC?=
 =?us-ascii?Q?bOa0Mgh50u2CBtFcgzzTs8h+NMfK8fI2ZqyMnsuUt9fVVsqOE7yNqyxPPEZ4?=
 =?us-ascii?Q?d6jZQgECPy+/RQ6LD06iLllYsSM5C7+GkthVT1jZUfUchWtKVtXVC7oqk0EA?=
 =?us-ascii?Q?g+Vwx3HXU3Igow5A1adZQOmFnHtjNyNXdwvv/qs/VFntj9Sk3Ki5ylhRStJh?=
 =?us-ascii?Q?zFzsP1m8Jq6IJoehvQ4JN3zFjF9Itnsvi11BU9pU9+TeqUIQSqaEJ4bkLfNt?=
 =?us-ascii?Q?tGn/31OeEvPgtdU0jHdWunVhNWD77e5B0bCfn/2/rDtr2dk1Df6QJWismbPU?=
 =?us-ascii?Q?CurxGjx/x1WAmgPLZt/2hX+Rx74mTN5mzHUWF+tlNO5NF+qpg3IyPVGr2Hae?=
 =?us-ascii?Q?p0J1sk5r50wvU1/xOENfP7MAO+R9AUKuFXdlrJo+y8zeT3/2c8dSrB0poNUI?=
 =?us-ascii?Q?iTHfvhK++Ws20WVJ1wvQdS+R7AVRp8WgA+r0mtBZBoXKEsZtt2/ATWG04/5q?=
 =?us-ascii?Q?ndblZ72ORiZY4HZ+fjifNLA2vJnc/JUTrvKC7XIXwcP3G3H+CTkKmzqj9ngy?=
 =?us-ascii?Q?u+0NCeUOzAgs1VHDGHSRpTeeNoh8bxvytvPLh+L4Z8FmZu3/gT1dOlbY3LFw?=
 =?us-ascii?Q?o9wIpLVNzw4+gttIlaWXSmeRN/vSgeEANfTbOtaEZxQ94oluNLG8OdX0LO5f?=
 =?us-ascii?Q?eaJXx97+Bttgx04C9tJirpkJ1wRhT/oZbrMMs4/DD11JxFPYtx0UP/xOMoWs?=
 =?us-ascii?Q?OBp1Uu8xpoD5qP0zwiFCo1tgmYIVNz8SyK1YaPM235AIcYt9HLUNxhXFryk9?=
 =?us-ascii?Q?wTaILTrZsXrps+VoI3I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db90d431-f5ef-4e15-f754-08dc5ebe0788
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:09:04.2560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUR47pju2PnUblSK+UclNyVYtMr5oblbMUHVCnC7enTX7ezzXcUqRFwJqlZV8IyoR3VM05wmjr0Z45p/r0P2hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115
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

> Subject: [PATCH v1] arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for
> sleep moci
>
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> In Linux, we allow sleep moci to be turned off when the carrier board
> supports it and the system is in suspend. In U-Boot, however, we want the
> sleep moci to be always on. So we use a gpio hog and disable the regulato=
r.
> This change is necessary because we switched to upstream device tree file=
s
> with commit 23fe2def1edf
> ("verdin-imx8mm/verdin-imx8mp: move imx verdins to OF_UPSTREAM"). A
> recent upstream patch removes the gpio hog from the Linux device tree, so
> we need to add it to the u-boot dtsi. The following patch will remove the=
 gpio
> hog from the Linux device tree:
> https://lore.ke/
> rnel.org%2Flinux-devicetree%2F20240405160720.5977-1-
> eichest%40gmail.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C0ec7
> 6e3870ef48ab53fd08dc5ebb433c%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C638489405607145323%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C0%7C%7C%7C&sdata=3DjSxtB3eu0uvBO0UPV8TY16yrEgCdTqgj6fwrwmG%2F
> v7s%3D&reserved=3D0
> The U-Boot patch can be applied without it and will not break the build.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi | 5 +++++
> arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> index 38db56059d..8b397f535c 100644
> --- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> @@ -60,6 +60,11 @@
>
>       ctrl-sleep-moci-hog {
>               bootph-pre-ram;
> +             gpio-hog;
> +             output-high;
> +             gpios =3D <1 GPIO_ACTIVE_HIGH>;
> +             line-name =3D "CTRL_SLEEP_MOCI#";
> +
>       };
>  };
>
> diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> index 03f211d5f7..7b45a87450 100644
> --- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
> @@ -58,6 +58,10 @@
>
>       ctrl-sleep-moci-hog {
>               bootph-pre-ram;
> +             gpio-hog;
> +             output-high;
> +             gpios =3D <29 GPIO_ACTIVE_HIGH>;
> +             line-name =3D "CTRL_SLEEP_MOCI#";
>       };
>  };
>
> --
> 2.40.1

