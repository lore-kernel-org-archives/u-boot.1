Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0510CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 12:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A0B81D6A;
	Wed,  1 Oct 2025 14:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JjZb83sP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEBC83335; Wed,  1 Oct 2025 14:00:51 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410EB800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 14:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4kqnspMI43sOBYqvJw6h2mNl2/PAa6Mx96dTxts1v2J40STlEjrRfKmh+ybLxkHUZXSpHmB+GEaECUzt9z5Z2+ceY2LV4i8gIUdiyGJajXUafE/QCTAEJ5f1Vc6iaC+uhJlrhyADFcIleVevP0p/kUayM+4PtuLE5nXjnh+DuUwAi3YoUUXKiQh/ykHt6ZZH3tFTmEbdp1pPiC6AUIuvYlOypuYXHw6kAIHYpuMoAkl6qeyodJ4v92FoqZdI9IsYjfcgMnmTbWppUz+lgjva2mdjQ31aWBhLdzVwn6tkPIi75wqQYNGwKbwBONOTPdV0++Nq5fPQxdnQpH9OAvhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1NLvuTeImfDNMw1C/r0EOhbH1so2c+2v8w7z/i1qj0=;
 b=V47rwhloKusKzsgSqKl6TwTe1glbZXZIBnQ4Mrs8CxAMWsaF8BdrxiVZGiJ3L8a8Z2Ecse8jXDjIHm3XO+9kbloFfjPeaNIbLpzCwtoJ9sJBeQIQeAz8+aJBzcLEfAcmotGifdoDHfjtk7/7Lsr5xq+/pyaRvxpm3OtlxT0SPmq8glghevek8bCQTTywOPlwalxmx1QUYQxWTSIpoSw3t2DOIE+UN8i0RoXuWqjRZ7hESyzfFYBLDirQeCMo1kIhB724iV0uuZBY0hf4ycfsr1PkS3xEj1Le+M78euq1F511tGqk/FHX8vIlhROyRBGmxcqEjNwe8ao4kYa6Pg21Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1NLvuTeImfDNMw1C/r0EOhbH1so2c+2v8w7z/i1qj0=;
 b=JjZb83sPKSeVsI95n57ZfFJHtYbr/W0Ed8nJXKaCiMDzXMxzX6ODzRFL0nDoNfvQgryz13OZapAyUXtQ96vZ7yoravKu5I5VECmPRViYDUnRJywKQezAlWbWlS+KmdajQF329IDqQH7VhfK6zbyiGW2/tPkPlzH+ZqDbLcLYELKFjoxF7hRmq4q9y6uBeHtlGeeNn9GtYCYm9Qbbk3k5u1b+HJCTjiT63dURy4fRajTAuHvcz5p4qkXSesFdRx4jUOGZ4wQoJzGvV05JJS90XMzOr1eqV4JQ5XrOj3dmdlxN4ZlUQ8PPxot0PKkHIwj/vhYH5qrZPgwzJxrjYqza2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 12:00:45 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 12:00:44 +0000
Date: Wed, 1 Oct 2025 14:00:39 +0200
From: Thierry Reding <treding@nvidia.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] video: tegra: Remove unreachable code
Message-ID: <mjno3pht4qmsqdo74cwtgg4nqjqd54beec6zmwevix3o3jltkb@eamutaf7woz2>
X-NVConfidentiality: public
References: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
 <20251001-video_tegra-v1-1-faaf48dad062@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bhgmunmgptrkdb7t"
Content-Disposition: inline
In-Reply-To: <20251001-video_tegra-v1-1-faaf48dad062@linaro.org>
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 811d0f57-f707-4ba2-1413-08de00e226cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NOaGh9RzdQ8QSeJmadcGGQi2pM527O7JqPETUze2aBZaedw1EkApkCP/PL1F?=
 =?us-ascii?Q?T0lrHQQGqFCGl7MjtPb4XkSILACavRYiex4KWrCJ+e9nKBCnXl101dt6FFA6?=
 =?us-ascii?Q?l/5S3HRQveOJt4qvi6+ADsLhkk5R9QYhLchOtM+0fjVRy5Ol3DE/C/cs8rtu?=
 =?us-ascii?Q?ncn0iEKLC72gI9CrimJqYnPJoXpoXnCjS1Qb1AIP0Bsf+YlFeOM6eLs1j5hO?=
 =?us-ascii?Q?42BMdFjPwiYYQKTZbQTKGMLbmVGWAjdlnidV55arJkVnvwVNqOn+MM31HW/7?=
 =?us-ascii?Q?WSuM7uTHwJM1dsrmkZGvBVIFJsRcIgNcsbH15n1rs1C58snWUF7dPLp7ARQy?=
 =?us-ascii?Q?Tl4N5Coh5YUozXoFOH4EFB3N4Dk/pB480BXXjtj+P4C0oW82iPGPz44+bt6O?=
 =?us-ascii?Q?VCVFNY51ETjoiksQ/iX8o8O9LQ+04hCK/+4ozKkaalL3iH9xIN/t7fnlHM1c?=
 =?us-ascii?Q?TwbzBgSHFDIXpueJLQ2dAPRz+W7lWhsMMS2VDYKux6EaLp3g3ii0zsPPioYs?=
 =?us-ascii?Q?RfGbVOA/yoja3SHORhPgr+/9jS54z9k1mWSBemIb0f/XoxskUmUTY03/wRtQ?=
 =?us-ascii?Q?SKfeBCWQfHv71YCjgnTotlmsRBcexfKPDhdNwppSHqNKyadtfLwx13fZG3rG?=
 =?us-ascii?Q?jwhZ3dDBP5ZDyoZQluUZk5tubRiQ1bLcJXoIAIRB+Hxsp2u3TEMhGwtTVs3t?=
 =?us-ascii?Q?hOlQIsECwfuNcezubN5l4UlfEtflCfajBy9nQYj2DG+STY6aCwGER9IXOJOz?=
 =?us-ascii?Q?WXyWXmOd8R8ZxcdCslS6+jA2iyxMXVaqV71grpQb/GHwBUk1s7meNFS9FSFR?=
 =?us-ascii?Q?UT3cOAYnHGnKgpiV0kznXSncPbNDacF9/wSgWcWQby7NHFKLgZkyP8Zv0Bh3?=
 =?us-ascii?Q?HMCcP2ad3rd2KolzUsOlgvetoTr1l3bk+H4TUWCNB1LexaIkv0uzcFB6nglP?=
 =?us-ascii?Q?AQwQXrbeuB/Cg/Og127gcxlLeovFTdiljApHx0j63qKT9QHnW/I/MDtChPQr?=
 =?us-ascii?Q?5Wus8FhICNvdTlUaLzLByNElC6zNEth5mf3R77XsfJIHLxqi7USHveIGfj0+?=
 =?us-ascii?Q?YTS72OTUsJvb5bQ2xCZE8i3o2yJunny4B0YHqrX6KjCZPwLAgQ56K1fk6P0r?=
 =?us-ascii?Q?hJWNWMQmwJlzEATmzOLrQeHnmYwSI8ZQb2c5kZ50U5Jx/HSWYmdixLQe1P8i?=
 =?us-ascii?Q?3L/P3iVwvWHbhm2Hq42oVk5KYZrYxiGiXn6mbkf6zLCIa2JnV44Bin65wiet?=
 =?us-ascii?Q?DhvR/qOAspvsJv3QLebp9mtpPfH3qOh4giG610mDsiXU0hevdG3kk6HaNkA4?=
 =?us-ascii?Q?TntDAC86AEVc7EBiLvzCGCu83MgxbPvha0ZBWOKpbu0aZhajFeZAM4LmUCkw?=
 =?us-ascii?Q?rkTv47wp/rICohiMs2ldDrqWUNlPIwbUiV3U/SbgK99o/sSL4e/0gXB7oIrI?=
 =?us-ascii?Q?pe94wk3k97VaHLlGlpjUS1tGtChVFZzt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ac9tKM0LdGVlz/Qp/aqirGSb70JQGvzRM4zlU4ZaqZB/K7hJVZBKgEX6EO/o?=
 =?us-ascii?Q?+EcUeynBkV2Hwejhf0cWPQsGFBrEYub9/jMzxCzKe0UiqpGJDoXvGd2g5y8Q?=
 =?us-ascii?Q?A+S0tLSJs0Ps3kb0Gbr5gQZ51ie2VEVhCL5WHrfYSmXMzDBBY4A/DkeHX9cM?=
 =?us-ascii?Q?xk2Y7DBOlsZWZJuQsCd004chFugY11t7bcsB23czp8fF12yEi52s5CfqW7bE?=
 =?us-ascii?Q?MkHWXdB5fzv+GgFKoKjx/IwzpSIorrmHgsPgOtix8fouf7A5OhhvgwHpkhng?=
 =?us-ascii?Q?CW4d2jmLrW9x3dLUQc81aIdFqDd4eJhRMtwmChOKpkyKtGZZ9/q7JSISaQSb?=
 =?us-ascii?Q?k2VtG5C85+1NeuKQdDXfI4jhJxkVlKp26AI2PLL3kz/Vt6/4a1g3YpLn8Ew6?=
 =?us-ascii?Q?11TjXA5F1PNg87+jIleTu5jzrHWzSUWe3Ip17a/bNT+XTBnOUCbJctoQw1Ag?=
 =?us-ascii?Q?AfL6H8ILXrJQz+VX3/TUch5SLJ0QmRMfqlszOT2vA8UzJTfd9Xye0iOdbw05?=
 =?us-ascii?Q?+848hd4y4PC+/0dJNOR0y6YjgQqiHQFCI/kePtapoPTMZsGovgQTwGrqNmiq?=
 =?us-ascii?Q?InaPuUWMMfBJOFySjKK/FKFOtpryb/TxuijJkWjiic3yNHMHRvKGCkKpKxT8?=
 =?us-ascii?Q?eBuS+OguXwFNUC8KnqdflUn9OYrt9cG/hkEIrZ9hs14pVQwdJAsl456GMogH?=
 =?us-ascii?Q?GADpTmNoTjWj+tMiu8jNexWBg75uLfMkqQfjIhhXDWKigr3Z1uQNS7M2qNrF?=
 =?us-ascii?Q?10sq0AFZ/x4SnC8nIWyER7XtqD7S6e3+U9hc8Khe5ecrI7JzkIwIchEAcfNp?=
 =?us-ascii?Q?bC/aiG/91Qhrgaq0clDH+qKqpgDpZQ1+aVgI3aitdpLneV5Hm98IiP/dCHxb?=
 =?us-ascii?Q?oK5r9QjSKu5Yw1puB6v+rl53jMmuoDaWNtDlPE8Y+VSgZmS1JNcYQjvtws1g?=
 =?us-ascii?Q?+yLpHAgELLqpiW2VIVuLDv7APvnmcaR9lOoM9ApDwEMRKXRABkCVzOMvcy6y?=
 =?us-ascii?Q?gz8STCUOb3KYjouGCdOabDAF7XSbtEujQzii4GafPnGfHVZHs4/GNUXhoErM?=
 =?us-ascii?Q?hNA2XH9LBI4NaMwQ5CPzfR1vFlu9bSK4yhRYJ7HlPSHj/fI9sXz52D0pe7uD?=
 =?us-ascii?Q?HxaZQ84VaTvT1nXEzdus6lbJLQy69CWQTdq9O1zTFGW6mDIk2Un0Aj2D/fgB?=
 =?us-ascii?Q?Nic+qnLWCB/N/ZfvpmiAqX41Afh70CuOzKnneyuhPnbBsAQHNQpSta14Nyqj?=
 =?us-ascii?Q?TmkRFtS+XfmkqTCDmHQBRKRNwMiIj2EUoGU+Uut8RdM7tAUJcBHLoBojn4v7?=
 =?us-ascii?Q?Q+vlSHrK3J/bDAXRli59f8jP2UzIO+n8LyD9aCQhYZhIzwWiE9Oz69VwVSxC?=
 =?us-ascii?Q?bdN8FhS7lfVV3Ya+ua2XMu/Xy3tX6VG2BYAzDtRP+czdRowfB0ubZQ9Zz89G?=
 =?us-ascii?Q?hhfL1mHVrGbUVKzwyJA+O8BxXJFfurCUeb2+cAeLW4FtdbI50qyCc2XIrBTl?=
 =?us-ascii?Q?En9zuq6WiJVPEaGQ4HyUkM4c9MxfbKU4d3SO/1Vrg/iZQdLS6eBwmYh/oOvz?=
 =?us-ascii?Q?bQyRINdaM8wQ8BsbM4UEidQ1S1gwWSfpvuvjRtL3DMLc8eQbBJOqmiQ8vdkp?=
 =?us-ascii?Q?I8o/Fk3NMBO45OtFZBIbSAFCOXBp9yUh1JdF+PTSpcpj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d0f57-f707-4ba2-1413-08de00e226cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:00:44.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdW9bDX36hllgJuGcwXeoMGJx3earNarxfBkRqq5OX9kw6mr1wokDHSD35jCCG1RDE/Rewxauknl6qBUppng4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

--bhgmunmgptrkdb7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] video: tegra: Remove unreachable code
MIME-Version: 1.0

On Wed, Oct 01, 2025 at 12:55:36PM +0100, Andrew Goodbody wrote:
> [You don't often get email from andrew.goodbody@linaro.org. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> The goto immediately after a return is unreachable. Remove it and its
> target label as redundant.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/video/tegra/tegra124/dp.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--bhgmunmgptrkdb7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjdF+cACgkQ3SOs138+
s6Gyvw//fGYs+48zuzLt9ZafiaoQlNawS+LfkSlzjafA7haRiAe8uxJM13lpuxEO
D790rI+QfN9rm0tnNrffdRrghEjTSk7cZVwcwKAhf5tV5vyNUqsnbwLhUCPsmA3Y
gF8ORriOfaLAhcYWZMymfP4Om14fZ428K0hrG4+kh7gyNygUyXv8OuFV7aPK3ABc
fWOdfQ2FqGaLYtjeA6/yxMo5Wlz65ncGCbSRpL09ZeRzcx9aZQx4Y85SKEU5ybN3
FZzi82ejWqgd9WEjvISXG8Sa5cgt6Ifnbg0iJJXlye3DHdTiwnoW8K6WtearfPPW
eoRFdpfW88zUJYMjuM6H6K5mpkz6yuKNA4clS5gPZdD5ixipR/cGoBgVBExTcsEC
vBwoKHDsCvVr7aGFbRKEN7u1nrSlW50xc6lmHu848vLEG+FpHMa5Lwj6scUizI8I
u5NQ+Ey9fMV48JzW7h5LJ6Z/Izh3G4GHSYbIwuv64ineNJUpm61mhhGe9uQ929Qy
k27PX7DvTe18I6vDLOqiepw3sNfQKvi1RXh9xgMWQeFyJUiV59EMBDcy+mlxqV0w
SmrdA3KxcZ+jZfGAE1NO20vrxTzt+x4gHccPhEa6S926aj6GH0ZEYfX2s9MkLn4K
y7rReQCroYRFvgGfdpIraLlBnTBaE+xCvAZ54BFzJePqj/SpYPY=
=f7zB
-----END PGP SIGNATURE-----

--bhgmunmgptrkdb7t--
