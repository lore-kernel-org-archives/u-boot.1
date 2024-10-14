Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D4CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7777888B2;
	Mon, 14 Oct 2024 08:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HcpLmOg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7200488C85; Mon, 14 Oct 2024 08:29:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C648855C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjbw/QU0ffJIJ0JEgGYnj/oqYBhX7gpuNRxFbFZvy4FfGKteLSys7X1ZJt5rcAudHM6UujQMxwoc8EfP0ZmvClrIIPwKKT5R86A+MnvN81jU6wFOwlD+trOQ0B2yNAfaK49nLUHGZ1wEuZclh96ThRmZnmFvP61Wd/S2OiRsSBUBtoFiBRiafw1Y0db7gjvhpP7PUwt9xfKmHkxmBvOoRrbg7vtWMnSDLQQrLR5PtrQXj+mtz3dFgHE829IwaYLT9XaNZpfP+qJucaOPDTURVnBoGTziFUt0gWLv2zUH0nIy9J/yFZhSPGV+9vK8e7TKJJHZDwMue2FefYiO4PW6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbjas2dlhOdgNyWW9vqK9iajisprStXONEcDwulru5I=;
 b=k893fXOLcVp19k8fjEAeX7LIAHdikPQuUcY3Ux4/yq/2hjZkmlSZrfi25sdzKGXXmpjDlq/LE27t8hOyeOTcvPnF4oRYj/2jaoKDJp5tBq6d1GqVn/8bzn1aLJRt/hyb6mFEfmQ4+vlJv71Ogh5EwVHGEgWPxEOViNjlvU+Icj+N/iB+Jp1VkmbwEyUU6yr795jXbZUcerCb2I5qPZ7CdDwGU1hMd+dVbe8BHTSoZpPRYpboGHqW11w7c1KDJpuGL10AFuWsW5cNwiPKsBGVD+uqdKG6t/up39nrnyKDxaYdCl9Hhrmy5c6WqhMEMhAWStuneQ0W3vi4kAxccJRYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbjas2dlhOdgNyWW9vqK9iajisprStXONEcDwulru5I=;
 b=HcpLmOg+9jsADLzKHgg5ysc9kMAWXx0wSDcbYrmEm7rB7MTfmX0sggApn/uZuE+DS5SnTIEmjLZqVQtQugY3Y5Iccy6TorsVBg7OdjK3vcpnwE/lC6W1WEOMJr1AmJ2sfYVrejex2llNqnLW/C9nyfzIEvMqgVvCWTsa54TfvXlVzQI/1yanCaufWfOTd+0IVSMqVyort2gXeE60Lf32yXzUGqk5Nsf7jT3xwurQzD/6qI79+sHJ5WCowISotp4KPF2Jq9S6MnPMrLJeYb6zu+6NPMvyoCP1tRZQ3lbwKmMFfRU/bYPx2nB2wNFNl0I3jLSlCMHSt58Tc2fAK8fZJg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:29:05 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:29:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Thread-Topic: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Thread-Index: AQHbGu5qHApW/IG7IUG8V2IKfs12eLKFzl4Q
Date: Mon, 14 Oct 2024 06:29:05 +0000
Message-ID: <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241010082831.19983-1-hs@denx.de>
In-Reply-To: <20241010082831.19983-1-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DB8PR04MB7116:EE_
x-ms-office365-filtering-correlation-id: 50ea87f8-3825-4ba3-833c-08dcec198064
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lerZz6AZwFD2GNPZUxAMFQDop4Nj/DcZNQkWNalzhu9MtdPBbONQZNv8h0uv?=
 =?us-ascii?Q?53ZrJ8buI8nig5P74duyLJcmD+t/ZJxEPkVDlOXPDFymTS5s8sefxFcbTJ9T?=
 =?us-ascii?Q?Y5vfDVF58Va18ATHo/Cdhx1vaWSaxzrjVpH19kXqJffDxjlbneq5xLHuQhn/?=
 =?us-ascii?Q?ZcBh2A++yuddqEsyPcyWNzzV/49ZQwoBPiJi3AtTgtnWjN0RleYaBTVKtRyk?=
 =?us-ascii?Q?YjVkXR1X9KmWh4GzsjGt/o+298d96zum1Dq2xrmNtNvqI07YZiIuMOGvjucS?=
 =?us-ascii?Q?t2S2FxP/53ZC6bhSIPCHt5eAtd4gMmstOHsBA7210q8uELg94byfzh1P52NZ?=
 =?us-ascii?Q?zT7IE1TOxw8ayZmimoWZKSmaC9adT+NnNAr85gEMASvAAjba2WUQnnwdBQcS?=
 =?us-ascii?Q?XexefmK4KGRsRviooSUL5fANI1VgTJmcGrxHHBOtRSOINSfLLXUBsxaH4Z7z?=
 =?us-ascii?Q?Gex/FGEHMnaQjbQ23qJv3oEdbTX+bnmFITpVNQIzOdkLlyyubRGQLXGS+EHH?=
 =?us-ascii?Q?aSujqlIvI5Uu6YqK0j0S60pBs7SuarUsw2gD+8ZFIl1wzSZ8VPqlKPkL2kok?=
 =?us-ascii?Q?sPKXdtzz2WrNC7+GSi3YxzQVIdVkUKtvkY+yAJ9YLhnS/SN5/8F9kAxTN/Jo?=
 =?us-ascii?Q?98RnKoZB1WcclR046qgdUYZ6YzQ0SgfvxPSgbz+7zGB1KwL6nzn/LmVK4YMJ?=
 =?us-ascii?Q?l4nU9rhT+QgeLGybcYaTrNQs563Mokr4oK8GA4/QA1pdiQ3k+ulpoJbDVYQu?=
 =?us-ascii?Q?xp+j8/U9LcYBBsfdSxeoXu0pg6mBuRJ/avMm3NJ9zNBUe8x1Eu+5QC0DAo05?=
 =?us-ascii?Q?kwhs3u6ujOM8IMSZO7xT+vthyn3bnBvhRizsRNRCTMDU2o9W3YPJuCuMywWn?=
 =?us-ascii?Q?0oXY73ijm0mQ/uPXBJQUMOiksPwbuft/KQ+JRvSQUE3JEZQfRoTtHda7wg/l?=
 =?us-ascii?Q?hl95US0IbSXMqqIhEsMynOax6VN3jo/lLd55yOPdNTo9DhRvleNT7zNMrWAu?=
 =?us-ascii?Q?GiQb/5EGkF3iZpmKclFGF7jG+B8Bc8cQouJ2ufmV71jy0rL02WUuU1jqQqkS?=
 =?us-ascii?Q?fAqZ+efZ1UOVrNTexJpXpW63KfYWGn/zpYuNRFdNMkhn8gX8Ww/15dyhjkuW?=
 =?us-ascii?Q?Bpc5rUW9s1oA/hmgPa4URuSheYf8MUhKFn1qcB+D/m7Ur0/+4i/vebehyyHu?=
 =?us-ascii?Q?TqgLBUacl5YaZYa3n2k7yozM5Nr68BI6R/p4tvZv2trQqmFLW8GE018/Necc?=
 =?us-ascii?Q?327o0Ket61lQXXLdU8H/UecIDe8tpTy2UfTwtMUK6nhL4KG0zAaqRI5J6xGg?=
 =?us-ascii?Q?xhn7fqs41uv47l0lYRtgLQSmw1U+m8KULmbYWMzMvdfa3Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1kta8LmD0oINqwiCRZrVuXQUd9FkINzcdLehKGEDgol6FXH+p0+t2KtXVjv?=
 =?us-ascii?Q?+FSb8tkQue+iL7i4MVpA3nOovENpE6nat2xU0BcB/jg2BubJlwlD4KjORe0e?=
 =?us-ascii?Q?HJc6+oSqwxXsRSJDBR3azty3cIAKBw9cL+il47Ul6SyAOrc+coR9tVF4EcLS?=
 =?us-ascii?Q?Y6sR95SkcYnT/cBAsyiIEcqzLjVqj/BoQI6NztAv9HO0u49YM9KBYRJlebMk?=
 =?us-ascii?Q?qJywMyXBYNIapGJEYxiIM0cxwFzKk+p1oC7zjg00FCtJv94rlEJNNJqJrr6O?=
 =?us-ascii?Q?J07ezta+HBtqkHXReE+8jMa3nPZmyGO5xnpwrl832vB4hx46//1er14VwQZ4?=
 =?us-ascii?Q?F02gSWHTTjvmDA6rvv/fDmaVpaFcqNw9kyqNJRlN8KOOvkEHi99Mle+J8qkK?=
 =?us-ascii?Q?w+00WBSdvCs2n3HmokTO3SvWkZp+n8YLG67U3qvtuor1m42hj31bfYNnx1iK?=
 =?us-ascii?Q?3C8H65Yx1h1W5UHohB8xeq/eCM6CsNgatoePldWHiG1/Tg+xAxtr0sDu530A?=
 =?us-ascii?Q?numpwZH9cyZnj30kIuryMwnBF+2LqT/dGgJ/dPE1FhhMU7x/tT6GXJgnQqq5?=
 =?us-ascii?Q?IJbHiCm12zBOVvGMzN3raF48LPGJq6+BpxLM2Gam45C8QwpwQy2uq/kr0QsK?=
 =?us-ascii?Q?8n0v8Su1tqZOqTc3r2bBykQvEbIl6agEHPqvb9l29SNXcgxcru90O9LwkOmJ?=
 =?us-ascii?Q?yhBrI+ZEwbimn2peeL485kE99COh12uAM+U56SiXllRqsuOKvtOnO4QiXiXF?=
 =?us-ascii?Q?Q4ZFIBbQViHrjsp1iblDpeks2DivDy5xbEipNjhbx6sQeiCebUyN8KkkybZJ?=
 =?us-ascii?Q?LVmhN25yvixRqtWJIvzAdJH2Zg6e9W+pq4hCNSwal1XovTSwWStQdswG6Jsq?=
 =?us-ascii?Q?wEpIqIUYEXbee2sf1he7bWcFmiCRVvpYr7lgkbVvhHrf2DOhnKsuxQFrzmeV?=
 =?us-ascii?Q?7/PQQZjaiOKOzaoykBCmZW0vdhNFuv/Y7Arhjd9VgpMObhivhBGtxCh4Mdbu?=
 =?us-ascii?Q?UhNVAeCBVPCxCsLWS2IS9I6JTURXIzKepluyIR5c7IrzHkD9v3Esagu8nzkN?=
 =?us-ascii?Q?rTZqHl73x0ORd5Dl+JgqDPfcug11gNJHZlG5KZmDmw/6PTzw+rdooaBEusZ+?=
 =?us-ascii?Q?qjuKxT1SVnzvH4yPJhflSew3NYevD7D45HG94z6a/0aMqF6meGpYZx84HtQ7?=
 =?us-ascii?Q?WwbgINxTzDV5mExTj7IFSeGV3L8QpiEKgCCzY4ekyjMiWFEuqBXXn8T2Btmx?=
 =?us-ascii?Q?XnsK59LvxuDT2XgpuSKjiDyvDkkabkZdMrk/nmypDNAHOKngeqL5kXThiAaY?=
 =?us-ascii?Q?HVw7gIYRW1uwa6UyH8WCMheE+Y7iu1zYdWcYwJPw57t3ALJg4RmYNO/RxBx+?=
 =?us-ascii?Q?bcIBF37MyD7Dh6whahUJRwvQq2qaTih/AatRM3T0sqiTtaN8NMthAuvCpRoG?=
 =?us-ascii?Q?CpQXtJnq78BqcPTXDO+8li8ZKfF9B9WA9sbN7JqYik1B7cNx/JMMyzaT/01r?=
 =?us-ascii?Q?mML5GGFBpielY/lslZy8tLL4eEOh+Sa+U3aJ0/JjD4dvwvMj+B+je5j/iYFz?=
 =?us-ascii?Q?6d1/lcNH44JH/+TOssg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ea87f8-3825-4ba3-833c-08dcec198064
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:29:05.2067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viIqNqKRq+IAZnGRula/PtyWPF5aSCG5Nd7q+09EQ4ez2HWVKBgwAVt/2p+WncIcO+VPFVLc2MvLS+8Iv4uhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

Hi Heiko,

With the two applied, with latest U-Boot, uuu works
well on i.MX8MP-EVK
https://lore.kernel.org/all/20241012093410.9069-1-peng.fan@oss.nxp.com/
https://lore.kernel.org/all/20241011105827.7729-1-peng.fan@oss.nxp.com/

Would you share your commit hash and boot log?

Regards,
Peng.

> Subject: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
>=20
> trying to load current flash.bin with uuu tool leads in not booting U-
> Boot as missing some bytes.
>=20
> Align flash.bin in this case to 0x800 bytes, to make uuu and ROM api
> happy.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> I am unsure about the value of 0x800 which is twice the value the code
> in spl_romapi_load_image_stream(), requests from romapi which in my
> case on imx8mp is 0x400...
>=20
> May I oversee something?
>=20
>  arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-
> u-boot.dtsi index 56749ccacd..3c0bf8c4d6 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -85,6 +85,7 @@
>  	filename =3D "flash.bin";
>  	section {
>  		pad-byte =3D <0x00>;
> +		align-size =3D <0x800>;
>=20
>  #ifdef CONFIG_IMX_HAB
>  		nxp-imx8mcst@0 {
> --
> 2.20.1

