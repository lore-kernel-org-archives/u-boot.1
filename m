Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE968CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E752D82FC7;
	Mon, 25 Aug 2025 10:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZQWHPsQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226A783020; Mon, 25 Aug 2025 10:37:42 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F8981E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONZhHvHzTE8U8vep2DUM15+QpsoamLx2dSBGXs4HnQjCXpjUElhQU9t9pHQehrtk0lMgxfMwrl1k2zKsTqV3LBeMaTO7gDsx510QKbrUL6sLgA+t4U0lJnZi3/L/Ow2ikoHufQNVg2VVrBnmePUh9xc6Dc83g3+XoPCcg//2MPiSUzFm3RHKpsnK5BDHeusu5eayrEh3GQwDCpv5MPpiqH+luDinfv9qixG8fMj4IXxsXy79kItEmnb1nEGzgQIBU0rd/obTZFyUOcmsUNxgVq7ob2r7fHevlpZyw2Bgx5WeMFDLTbWjZ/q27P7M0yv6IId6eNq9xP50t9HM+D4juA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WySCbfaGqc8Yv67Ee29L3ah8RzITzLAteM8A8cmfmoE=;
 b=j09y8ODpSzLPQcS+7we/M+bqz9hpQdfeL+hTf8m5fwpqSyResYGbjPQ8ZrxHNFNMt/zGzG8d0dTHXNrk3H9zwQ34K0UIq7Y/9bZlOxDFBlg4uHpNlsgh7MfZ4HcO/GwSiqaoyW8Fr3r5FiZCAQ4jWFQtU4zwsmageEj7VspVJFASGBog2FwH+EcdV2e4k8S+weZuiGB6i2teo3Xhi5lYBarrwxK8WG8NuqSBcAR/BYqeFAuFBGV4BuotjRlIkcOxEVs2LDDfGa63OGQUC8ehVJRHVbXiR/PJadrVhT5f+J16Kk9/arqnV0F2mFB3QrbJIgbd+djJbyxp4p7GKdNKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WySCbfaGqc8Yv67Ee29L3ah8RzITzLAteM8A8cmfmoE=;
 b=ZQWHPsQAqEwHPCqbdlXLZBvaA6WNogh0wNDb8qgXM062gbPDvX2oZKAKw8lGwAwSsmobEAzNGjvAog8kDTDE6xnnEh3tBqHvxsh3vZ6YDBvKsqtUW+tfisTJDAL7uBpeHUF7sc0LPclFD3cQpS1qVUstcRxGKBeAlZ+CyKfZ5d8NdDM7g7WciDS3X+L7sJWLy1FPpi63LFFFVvT9QEzX1pkHcFhdEsJtfqq6HoEje5+NTF0QV3jfn6vEgJR1umKFeMaHL1Ooa3o/t60NRgK1fx9gT59NE9uUYy5RuYo+4szsqww15fxME3fDYj3IR7H7fHWKM6oVaxo4H6RJbd0o8g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6998.namprd03.prod.outlook.com (2603:10b6:8:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 08:37:36 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:37:36 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Topic: [PATCH 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Index: AQHcCEvSXiV/Ah2pQkuiy+3ffilQa7RzJl4g
Date: Mon, 25 Aug 2025 08:37:36 +0000
Message-ID: <LV8PR03MB81375887BB1DB30ACA699F31A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808100412.9320-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DM4PR03MB6998:EE_
x-ms-office365-filtering-correlation-id: 516a63f6-5b43-4e1d-842d-08dde3b2a4ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P3bbjC2yv6lixbqHcDszY65ycZjba6wd8S/jV+o99RnWl7QchUNNiIGP8Aeo?=
 =?us-ascii?Q?KVRFgM7o1GMiNyEl4F/tlmOBw6PGAk6I0+YgeNjU6MA/g2bCdSFhD/Muo+qW?=
 =?us-ascii?Q?IIvpONwWy56UJ32PzE1dJ0sZpyXPDI9zE68XSAXS/P6N8R03JBk+h1CMtHg/?=
 =?us-ascii?Q?f4ZiblflsOY7olRCmTjE5UORla3S3xj+yiDYn4iOfIM0Dqnv5gSn+62Vy10s?=
 =?us-ascii?Q?+HaMIdptnbgIknKeN7eSRj+qOZPDsH5HNig3CsbHfR+qCN2mf5DEJezmbK6k?=
 =?us-ascii?Q?n21/Cr9IxRIcYfpImyP9yjVR/uvOIBHi/T55JJ7d7NtYIReIqyx8PIcMIOCP?=
 =?us-ascii?Q?dTpQE2iV2FAn9OiX+M1EX/OIh1vqR4v53ZLTkZrkOi0fUbiZsaCCVornrS6p?=
 =?us-ascii?Q?PH/m8OhwNkFu70dPR72zYyPwHmea0lIu/PIVFrGT7P8tk0i2To7hQuqwfsSZ?=
 =?us-ascii?Q?dJKl0pEqGky/CufSxefj+g9CgNOAw3bZa82Dt6z9h00QcRmCqjzh49znOn5U?=
 =?us-ascii?Q?RPxoenV3z3O07X/zZYYNW+WemCSzz9r31VJ6ny13swPyJrnFNN+U8w0T9HWo?=
 =?us-ascii?Q?tR9qDNCkoSVyEQ37osGj4RSIiX7y36HrkBXpfRbiMSZMwTAw7rnrOT3Xusly?=
 =?us-ascii?Q?AOyxwTbFVfbwfuRz2GNmcsMiYeUpoHX8Ukyd7jm6olnOQRCbxsmf4E/cgSjY?=
 =?us-ascii?Q?iuAsvNGkZAhpMWAXwrBSYX/h0Xq1VA3NE8pOS+P7NyeQ8Md36uwmyFFLNGb/?=
 =?us-ascii?Q?2+pPUEhe6iOBW/5zFovs23BapNrHB5eO66gAnZCBWnrqnzwOc7E8Ss+pw7Ql?=
 =?us-ascii?Q?UWr7cG8nkvGPuJJlkKoEZ5BUt8PDkBGrT4xhzrRc+tLNsZhayL57hsa1iU7i?=
 =?us-ascii?Q?d3MdcHGryxxTTwsLykm5GqRLXL+6/P030ta0oLEj/uurrysgnjwXKpDNm6Ao?=
 =?us-ascii?Q?CUCTckCxCx/TvX/mez6NZBlMFElMeNYgxuOh8BSwZeVNM5dpJh2Xiz9dzLzt?=
 =?us-ascii?Q?ykOF8At2BjUmc2rhycwuQDAWgcNAhxKfuFpFaI0wgfj0baPewpCjUdbUt/cF?=
 =?us-ascii?Q?gvIDITKkW0UpDAt8qpY/4891S1IsuIorLsY/WoO8szPSLrWML8QyXtp7Oive?=
 =?us-ascii?Q?cassQM+K1x6rERZb2SSE4zs/1fFPVurqZFTtC4ntXV0IU1gjjIsThfMHTSFn?=
 =?us-ascii?Q?IrCeuB1IKHpCR14KftiYGvH21B3/cqCbU5gcoiAOJYc+9UBXTP53vAdCRv1e?=
 =?us-ascii?Q?Z27IFsLbt7X07DJIYM2f2/9d0Z3XgzVTxNQ2czMMQNyJELnTh0AULW518je+?=
 =?us-ascii?Q?+Ku0CQsY1+63r6RscZCIFFEeVbL9UDK3XXc0y2Con0K1u/v08xAtwl9+Yocs?=
 =?us-ascii?Q?5yhX/m4XEXGMWoVG52hYbCTiCJUqdP2N/52JZLnFDlOr5af52klb32Sv2OBy?=
 =?us-ascii?Q?MkcAs9jBkH4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hfxQ72/rAf8yP1d5GknlM0q63UiQf3kOhwLjo0neoHG93Ma+fdSSKfONBaN+?=
 =?us-ascii?Q?3syL3VQDbCbKcf9wI0ITGMOVtY3KxTeAVmXDavldVnnWrcvMZbTNcjZKKXrR?=
 =?us-ascii?Q?PG4pu/yLAI+G3XYxOVLsjiFGB+nAz230hysStdqfzpM7vaSvBcIyykzy3tes?=
 =?us-ascii?Q?qsoSrS6OKfIZ+l8m9sGo95IC0LUdMxOhgggtPHl9Oae67h8/doXdz5+5fWwW?=
 =?us-ascii?Q?B7iNV9gj/uqGd8ufVQ4NEF1uPtp1b1tzgHkckSaWK6DeyqPYUhQDZRwaicnP?=
 =?us-ascii?Q?HJPcn3lbmxKt6BvT2gZSVq15tEMI4kyP9X6mqJqphncCvGpYAnrd08gUDdL/?=
 =?us-ascii?Q?Ec/ineiPquKAf7U9FFu3PR9Y4p0ZkYBxW2NfFk6Q2Z1c1ErXHCFttKIx3xxU?=
 =?us-ascii?Q?rvdTkwlBKuLkIrUGv7Jjw18IxVNPHuaEaDe0ikiC7GWHM8n15DIeeH/Bmd9R?=
 =?us-ascii?Q?Abzt9rPX0rtKU/3RBkcLMNTpt3OLu3BpyYQR9fry4VXq9lKjaxzf6+FlQm5j?=
 =?us-ascii?Q?2qdxin09MFZRPjcRzJf1G4wmdevgQMhWaW1gO4PHrtHcLXL3oZ80VY6hZU9f?=
 =?us-ascii?Q?r3kNXduRD7m/mJOwTdjvX/T4MkNm4LAk8QLKU4jI7afZjd/+OrzEI41Oxbxd?=
 =?us-ascii?Q?qJzJ8WP54GbSAOKM6ueYilf4YlHnEjrUDyqVwmbD4FM639wZ3ydCzVuXbTEW?=
 =?us-ascii?Q?baM//Q1vaSAJc4IdmGKxeEFN4WFx86fSra9Qg/P2Ej2gcwbqhOXbcKLDlTR9?=
 =?us-ascii?Q?dDLHpPPySyDpXxih9+/+yRFKv8S0Wets2m7QSqnILs/9OZrp7deXJAkfsjHf?=
 =?us-ascii?Q?5i3ZXYFZUDEsQvi5jpWEGjvlnUw50hKe7FmNGHQZSrSuE4PoJAixhQ65MPq+?=
 =?us-ascii?Q?P/mywLA7kRK32oypk1LfQ5EHsmT+eUVCNHQRiek7SLqCP/jeLC2LthyGQeUp?=
 =?us-ascii?Q?Ls5n43uPAaXOO2Ohy4MUkeZd6JxpAhJTlTa0yADMm/D/4aOeEijAUu1iQvIc?=
 =?us-ascii?Q?TEvr6xPyzjwcX+jwxjqS3CuBvG1LPMvl6EO5GaaG4QdAbNZNpWVMwF6nXLpv?=
 =?us-ascii?Q?QYWKv8b/KQN6kHnIoiCFADZaMr2fCJrVkVXiJAJLaIABxxX07z4BDZXTf/Bw?=
 =?us-ascii?Q?Q1UadnsNoTwPwcXfNH6qfvQGfj/NTMC984qS3EJAm6vXUl3CKn0IaElZV4Tt?=
 =?us-ascii?Q?a/d4Pkzfi1ioz45L/Np8pxYbuKIsjvXbc7UmNT817OBL0tU23agCoC1W2WY0?=
 =?us-ascii?Q?NZDZ/bnnsUun1uK2MfezekOyEqOW22ABmBT0fXHoNty0SH+vDGQedHegFkwS?=
 =?us-ascii?Q?l2SCuVDakpdi1gdqztn4mQh1haAFBNC5LRzi8NW5bDgpgN7+1MGcZHaANHhG?=
 =?us-ascii?Q?ghCJ9bgNl9vcQhv6twgVRAE0iHwoj4geE3dy4Gb8A5AokmMEdhnbImgGvlEn?=
 =?us-ascii?Q?ppDMBbqnDVzIxQjhWUi8aUrwdPvde4UWbQ8bp85wnEnFnf005DSMQws+o/VX?=
 =?us-ascii?Q?/N/Jh9vrSmb9D5wkrVJ1w7drEybxa7VCTW+NjbDygnQaaFydBVx0HKF6Kjyo?=
 =?us-ascii?Q?MmT4LrNkEMTmm7rTmN0GB46JtDUv64CzGSJfEbdh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516a63f6-5b43-4e1d-842d-08dde3b2a4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:37:36.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUj7U9Ire4zxmCg6DFlAmmUdNchQX4z6mrjXmMCaK7J9uR/oKV9blKblucMeE6Mw+gE61mQPF4RYRa1C4uyVrtRVSsOHw64BRtr4RuaD91Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6998
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
> Sent: Friday, August 8, 2025 6:04 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
>=20
> USB 3.1 node is enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> index 2ab143e38f8..86e6d374948 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier:     GPL-2.0
>  /*
>   * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>  #include "socfpga_agilex5.dtsi"
>=20
> @@ -87,6 +88,10 @@
>  	disable-over-current;
>  };
>=20
> +&usb31 {
> +	status =3D "okay";
> +};
> +
>  &watchdog0 {
>  	status =3D "okay";
>  };
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

