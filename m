Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B75BCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 10:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53E780FA1;
	Wed, 20 Aug 2025 12:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQhG0Lp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA268211F; Wed, 20 Aug 2025 12:09:35 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442D48003E
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 12:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I30aRgNLx5KvSp59vW+whXU8zyZhfcdd301zQ/OjuasHHMr8rB9VyDHsBebA9l9JYct/YRhAeb/RSCmVwCKlPeazG7OijEDcLAGc9oFKNIdLmp56AzvQF8Zsc8VI3j5a+FY6PXIo3VpSHalxtKNMsbU08SoWXYajLDL3yM/4R+EGPXjGeVWIT8R3SDKxgs2EB9tOjTWeG28k8Ukl2snmQHg9AckNYUHsubKuiLVQ3ZaXaNFlB13RIk5anBQ5S3EIBt5yg86kiIZZOD1mIS1O4XEji2F2hdwrleZKeHRNy1b3D+GKjFbK7B2uBbUWIfCaO9WDAAwxcf92P9S8T1PVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xWq7wShBxonLcmEYCZU9lU7MmYLZMKsXZjMT3cz0lk=;
 b=PEV3WZ8E7cc1T15DPH3abJMJnIpUSMRRmdvs2gPJozcwHig+K1CeKaN/kwQv+40xdlcF8MB2C/8nLJQHTwTQxl30OX11T1K8P/X4dFqHWSqoeONqapU2MnJgxJi+Peuep/L+KitVE0GHmiThmLUmEQfD+Cbdp5gTKle75d2mB7UXSUtv+ScEvZONWe6QL6FiJUJstiNut4O/BY7O3yOrNCUdjfuMyFCQg/Swrk2VlPDr0ufCrvetcELCOVo8X4aKAcmhtuaecSqlfmgEIz4pNfNxZZ6pX+E8OU+h92jSz8kjGQJ1y6xoEfwMaELUdXz1qEWNB9i6/6TQGo4Z4L8U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xWq7wShBxonLcmEYCZU9lU7MmYLZMKsXZjMT3cz0lk=;
 b=rQhG0Lp88BqtHnzVRlL8vta5PhP0EeAgu0DDlpe5+XgrzuYsOgPRjHCGOP4cvv26/wiVYMG4ggIKKmehRjUotJLR3AWRwMcuZgH+mo/49LsMMzvMOW9EYQPQnRplW7CteOHC/l0cNSsZIZZqDGuXg/Sp5MjaBURaiypNEi/5XJ2bhVrsVBtMBY+ZzDQYVNR0tXuB0EckrnjYCkYPJreqN5jgvkYftYmIfrw1Z1YRaO03ZCWsnFdgbaoaKLxTO3GFUbtuqVx9hp5iaPTWrvhL3Pk76jmuzfE5VcsYFQLPJbyUNXkuPPbMz4ABLg/y0euWajXOUsE/kwgYWiYGTfiJ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Wed, 20 Aug
 2025 10:09:30 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 10:09:30 +0000
Date: Wed, 20 Aug 2025 12:09:25 +0200
From: Thierry Reding <treding@nvidia.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tom Warren <twarren@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] p3450: fix Jetson Nano SPI flash
Message-ID: <ifxdnkrcovvzzabf6w7nilhogxhu7ojrkdyurpwt6e7zfeuo2o@krp33vulky5r>
X-NVConfidentiality: public
References: <20250819154025.604784-1-pbrobinson@gmail.com>
 <20250819154025.604784-2-pbrobinson@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7qucngtmfadkej52"
Content-Disposition: inline
In-Reply-To: <20250819154025.604784-2-pbrobinson@gmail.com>
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 9501474a-3851-4bbc-cfa3-08dddfd1a706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6xv6h0/7VXVyE3DrDnIOkvKgk9mcUjUbkEYMUR+f2/SaLgevX1KdcC3I/lD?=
 =?us-ascii?Q?D1MNHD3HwdRe1HVl5HWde43wYuKpLANxaGFXlkEDAFPBu9e8WSa4c/S9rAKR?=
 =?us-ascii?Q?UQv++mZBR/8+5rxAPAfvjdBQIHh15YDr9ywzLtYK2DWJ0dJqLDj7637zqxuu?=
 =?us-ascii?Q?oW6OSIv212D4R8/5/2nv5HcDY+t4c4C2dW3I1FdakqH+y4uC82bNIz3hPo3i?=
 =?us-ascii?Q?cxYvnA8eh+MFuS2wAYVQelweFCZu3nIojqBJLVgb3d3e66Af1KqlJhovlfT6?=
 =?us-ascii?Q?csaQB49oXFnfjLHdkAt7zeu5sfVE5777B2b4yB1rEnCDq1uPWWgR3mvRKxcK?=
 =?us-ascii?Q?ZqGR1FvdwnEy+whyLPzyWCJ/loWKh3QR9aIq5fzcOuMg2s2SokafZxW5J8IZ?=
 =?us-ascii?Q?xN4T6i4INa3aXc76vCS141JV02NiXeBWJ92Ei/C3YRsf1+FcF+9vmHYW0Y1k?=
 =?us-ascii?Q?jN7u8M4ygRWKOkkcCf28hvp+WTBfabEvgODxH0Mjfdplsa61M8P+VVV2dkR0?=
 =?us-ascii?Q?ErVhJzdHik4B3OfyjI44x6w5YbGrO4VgbWll17pzr60xFYRrJEkNYS21zQaX?=
 =?us-ascii?Q?10TjMtL514lpdj8aCv855BncIn2+KiJCuTI6eJAMUOHP3gMWbZP3CAACEBD6?=
 =?us-ascii?Q?TSfTsLqo/wn1JMx0UC8HwWAAsi8DIw+fAahfoE9KoKn+pz2uVE+3hsX61eQE?=
 =?us-ascii?Q?tMcxQ67UpPaTCZQkNfmPt7IaL8K22lcUKL6d/YkR5U6fLUDD/tl0pBOPUtmu?=
 =?us-ascii?Q?1hMOt80reGPt9YWfQQJ5YRSW49rrO4MkMAVtxbyCVJRyg5mSTSCBRmv4fkLj?=
 =?us-ascii?Q?HhNZtOsgfQKu55usmauSsUlFHWDEdKd/ucxDXo82CDoveir8W/5XIuynlbCI?=
 =?us-ascii?Q?R01+Y6n+iY/El/qsV9S2u5tH+g4Fhl/aEvbUHsX3zf+MkRonLCgqragZo0Ie?=
 =?us-ascii?Q?Tn2EINyPuWPspYD4NshNjGx1o2y+OTbCPVMxLqGWjVWII4iyhKqSwwqoh+HC?=
 =?us-ascii?Q?dZfgCrBKso+ho7VW3JUOrrWKQuzHvzu/tUTy8+BXBCJRHyBAL7fZxU47WU9+?=
 =?us-ascii?Q?gx70gy9mD/VbjOJ9O5ZlfTbim4yOvrSMEFrhCDNC1jYsAkGfgpEPkl96Qi8Q?=
 =?us-ascii?Q?jmUdsI2eoJOJn2iGDAQClj4QywuIQvhKic9I69bBQTEmpiQx+fFVNghLl8SY?=
 =?us-ascii?Q?bjYUf8n8EsAq3aCv6xr4q6iHpMC/vUOtLLFwx7sx8dMZvLvmhUpjtTanhkNf?=
 =?us-ascii?Q?AauIihFV8bzi3BHPwm/b5e7wwOUY/J+PExnmqszT0fin1uzOr7VJsL2c4Cv6?=
 =?us-ascii?Q?XvDTzaWa82B5kk192557ZPAj0zTeP4YUQ/HxN8r+VYziVrOf80xazv/oQJFX?=
 =?us-ascii?Q?7aOlVv21lWFCdBZZtZqBXaRCaK11ATuuSBa53l2vNe3I3gKqJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09PQ3WzyL9klkJzmOXB3zEb+ZF4deu2jNxZG34DZtjQyYjmfBeitrZtlL2J4?=
 =?us-ascii?Q?38d5mWDfSZQ1NOj/OvrbukQHZ81pYHcq/38xnQdC92+8jTd9FFPb7bG2Xu47?=
 =?us-ascii?Q?K+PXbIhaTr/YIew+ZkLA+9HoWte7/i9B4f8P2WAbN/qL5iTaAG3ZkEqbLM8i?=
 =?us-ascii?Q?R2mQ/6ojgec6NorFC1ikfGUS1vbjCtwnthW0hAFAg4IWLh6QgWGTprH59Zfq?=
 =?us-ascii?Q?KjCvbZL0mvckUJhkbz27tiJaW0WI7U+tpIiOUP8cAGXSyvuX4vxWRc4hl1KN?=
 =?us-ascii?Q?TABgbstZGY6pHa1fgJwSgLSHTc02nahFV8Vjkw7A16/nwmy8BCfbxDH83OAx?=
 =?us-ascii?Q?eXzM49+sGC95ereq82NpVXqrQe6dkl2Awq3aLP8HlsVhX3/ynftP6Q8V5+EG?=
 =?us-ascii?Q?evWGvMMzHxLifgKfw4CjMC+37ANM9Y0rqkzaMr3W1c8Mqc/DDTBZU3Sgdojj?=
 =?us-ascii?Q?rVLaPx6CkoXP4HtJpDdRIplDwPiqKmGZo/syNA5OsBhtNJqxfLTWdjMXWGFf?=
 =?us-ascii?Q?H4F1PkOxm+8HOrj3q3PkmbBaKn4Q0aeQGJJnXNRC6L5WEXxkE+21VA7NbhtT?=
 =?us-ascii?Q?EJGR8Zg+3uXZJo4k7XWr9kItnMZtL0MWtXGNKz7ayG9aQthKBnl3TJUY9jAI?=
 =?us-ascii?Q?aiVl/Vtw75IxhZc+EbNdy0gPTWmfV/Fk9TaobK3KVpr5FBfYYSzMY4itqA3J?=
 =?us-ascii?Q?fyUoaME/NJgBcQLm970s3aK2CmtEFVCZJVcPAUu2pOy/hKIYDPdJcEojakZk?=
 =?us-ascii?Q?tNLEfntl84UxG5mw9h866afIBWG/c5L3pxKWCQxQq+bQzAPw4P8pujLPcGlE?=
 =?us-ascii?Q?MWsyyXW7j/4CMWY8nrR0tO/QtLJ+hrLohUdpawm3G+XK8dWAOmSOihAXAhTJ?=
 =?us-ascii?Q?jnUTwH0PLhBuhYi8ZdclKv1cUlQhT/lXgkuyCyquiYieX4ObH4xRvgMKFP+r?=
 =?us-ascii?Q?sqfKOrRc/lDkMX35SeEkd+LBenJsS+oXaMdy99Hr6TjeOjjUzy1wJNHKvifv?=
 =?us-ascii?Q?W3XO1wMmgvzydkhl2iPpHxtIuYSVcRgcF8om83OAGZkiNK2JiGYyO9uP7kLX?=
 =?us-ascii?Q?HJOMO/JWcMcssLFp+p/NG60A1dWaMAEWMglWPIjbkAbTCTNnNgv99N0hs/Ou?=
 =?us-ascii?Q?/4vB9H7r7X6XNtaZDjsUTFSpDthSYcT8ugJOz8hoffjFubKTuBVmA1a57G9A?=
 =?us-ascii?Q?aWGshOEfvJpTHP0nIsLOMrW5r/B57mkcgMCc/tW0dgnTfCwqfqdykZZnvZ9z?=
 =?us-ascii?Q?Ck10/Nb25v6CODtdWHCxEPlVmiyQaCpvdmPIe5dLMR4RZZTlbzsgQIm4ZmrV?=
 =?us-ascii?Q?nPzXjh5LrtOXIr2XJQsugCSZULEGKugz3ILfqBkKCQgKAorGJP6Ji2ZfVIR2?=
 =?us-ascii?Q?5ebQ6yT7qCshj6d+wNFHoPdJbrxdqTCko12FBgTFrSOZWWbAC32ZcnqyBPs9?=
 =?us-ascii?Q?0ROr158LcUxLmetu0i/XwlexSvhNfLnPVY4RMVxML/T8Z40dr8LYzNW5T8BK?=
 =?us-ascii?Q?CY7BnPT5k74lNmtWKD0e/vV5cU8S4UPGhiV5eLy/oT72pcHswDsBykMNKj0F?=
 =?us-ascii?Q?ZQBRPv7qnkWeIUUBBMThPoRxim/8hcK63L8vjjoc/FwInxsPpo1UhjIdXxxD?=
 =?us-ascii?Q?HoqTzR/JUMuZKbGxD6q16pY5fPp2cDOgzdjyAYkjEstX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9501474a-3851-4bbc-cfa3-08dddfd1a706
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:09:30.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxgEk77qDbYZObVYSkpd13f5JLRvmaWEHRMy1TxHvVUV7ozNqdmUpZYMUg70rsDl74pGjVoAf4dgYZ+X5fHdrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

--7qucngtmfadkej52
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] p3450: fix Jetson Nano SPI flash
MIME-Version: 1.0

On Tue, Aug 19, 2025 at 04:40:14PM +0100, Peter Robinson wrote:
> The Nano's SPI flash stopped working in U-Boot, as the
> prior stage loaded U-Boot, the only thing it was used
> for was save/loading env vars so update the DT so it
> can now initialise it. It also drops enabling the old
> TEGRA114_SPI driver, as the flash hangs off the faster
> TEGRA210_QSPI interface, nothing on the Nano uses the
> old interface by default so it's surplus.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/dts/tegra210-p3450-0000.dts | 9 ++++++++-
>  arch/arm/dts/tegra210.dtsi           | 6 +++---
>  configs/p3450-0000_defconfig         | 1 -
>  3 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/dts/tegra210-p3450-0000.dts b/arch/arm/dts/tegra210=
-p3450-0000.dts
> index 9ef744ac8b0..ddeeb232de2 100644
> --- a/arch/arm/dts/tegra210-p3450-0000.dts
> +++ b/arch/arm/dts/tegra210-p3450-0000.dts
> @@ -124,7 +124,14 @@
> =20
>  	spi@70410000 {
>  		status =3D "okay";
> -		spi-max-frequency =3D <80000000>;
> +
> +		flash@0 {
> +			compatible =3D "jedec,spi-nor";
> +			reg =3D <0>;
> +			spi-max-frequency =3D <104000000>;
> +			spi-tx-bus-width =3D <2>;
> +			spi-rx-bus-width =3D <2>;
> +		};
>  	};
> =20
>  	usb@7d000000 {
> diff --git a/arch/arm/dts/tegra210.dtsi b/arch/arm/dts/tegra210.dtsi
> index 28ecd2b467a..6dd8fe26c38 100644
> --- a/arch/arm/dts/tegra210.dtsi
> +++ b/arch/arm/dts/tegra210.dtsi
> @@ -762,10 +762,10 @@
>  		interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -		clocks =3D <&tegra_car TEGRA210_CLK_QSPI>;
> -		clock-names =3D "qspi";
> +		clocks =3D <&tegra_car TEGRA210_CLK_QSPI>,
> +			<&tegra_car TEGRA210_CLK_QSPI_PM>;

Nit: We usually indent so that subsequent lines align with the first, so
an extra space would be required here. I don't feel strongly about it,
though, so no need to resend just for this.

Acked-by: Thierry Reding <treding@nvidia.com>

--7qucngtmfadkej52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmilntUACgkQ3SOs138+
s6G1Og//ZWxFvkZIwi6w/ks+0g5twtBylsshjCVaRheBszKtyi3XXEwL/gJrLXi9
YBRQIGEgBfqG5MkTTuFgRKV+WzhBUFMCbdCKmF4dy3mSFbB8whrjetJ1AB3P7XYR
DxDhpQoM8BDtY+p17L0kCCN6pDTNF39HR4q7ZTF1/YpsjNOH7sekDuw60QB3zD7d
WpxRmh5CQmuwJICGkJPxAAIh7eXJU7Gul+FWMuUFpEw/pacCT2zNMMBTiUBwRqqP
dhM9rislCS/FWbiALOzVAukyW8lPw6tPEpN5JoDGmzFviOUWt+0Znitc7mCqlh8m
9mFz2Vi7SoenHpDhrKKoHQ6iyoc3EhwaywkTU/leSEdfNFgd2H0ZHmGb8D8okaxv
3hzPJATclyhCR1PsVVnpFrM7eRuWjILIaE7NKTYH36j5UKsi7LnzbICLDERvZi3N
j4segQDh9xakv60EEpVrenrDpAjmBamQDbQ7Y195h/ZWqFccHzK3leAilYkjGU69
/g/aXbfWRJoINYKaLfQeZ7zrIEpuBLjWOut3DlsW8IVUkt+QESJigHrm0ncuamr0
N5qBvIm1DB7ig4PQlf5amhbBNn2xJUKWgkWnIkBwFwEBgdwwcogrDMgDFeIUJpbr
vqnG4jbbJShRFhj7iY8cr8sFCImx397F2uWFg6sKZk9sRRCH3CU=
=ryGh
-----END PGP SIGNATURE-----

--7qucngtmfadkej52--
