Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9827B8141D;
	Tue, 11 Mar 2025 14:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s1DMhf9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9908807D7; Tue, 11 Mar 2025 04:57:41 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B670D801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 04:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVthHYp0X9+PT6tWThBn+wrHq2VjP7Uu30JDQZZLxObl1ecetxcL+bu435hHY8yulP8+3rYR4oENI4RNtXUy4CsJkxRMyQ+CqpQ+q+VgT1kFy+v2QvlFrvYBJSOOt6YqsAdlYZwPrF5Qp4Pu2PsgwhZBlUE3jVLtoKYlXwHBodxLaM+fBlFVL292fEHpsAMLJEwkOGTLIhfXzphH1mXYZ21Kut9Pnu0+C9sQrQIB+OaDqicnJw88ND5ITY0rT/E+b7PTtOB41qbeUa6nJV6j6IOJrmRZBXwrUyqTaaG47rdeufUl/JRY4yqjNPIClpgipj0Vg0KHByaqV59HNMJgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgOHsM4Lf7J7gmpb22zsvqDsspFUaUZ3dRAOORQjtHE=;
 b=YEw02HYKpYLQHNDABJ7u2MN6/zuEQPhn+LAc49suTGE/SjO26mKfXHce4UoidW8zUx+pM477/LEIuwbaP6kvKeFQAawDVwOAU/2kcj38ZP5UN5/8L382LlEMtbxG9eBNrUPt9W7PqhZ4D58gKIgyTDXc5K+9igbtowaDcUFISqL9/Fj9UbLl45roddGwWVKELhV83awDnOHcEfk7JY2ci5SIvyQDJ+gBUzRUI8G1qSM8LGDslGywRvJEU4kPO5teWPzmSRS/uz+NpVpc2QCBZOzIRgh4DC3rA5pM3iBcqGPlsxAWtG8/sCf3ZGXsrCIj528Ta0QDsmsmvftMT+JYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgOHsM4Lf7J7gmpb22zsvqDsspFUaUZ3dRAOORQjtHE=;
 b=s1DMhf9A0DeotoZF2PlbRCgK7NQzWnX7FMANPD7FrMNRZ4RFK8CWMuFq7YnH9qREnI8BV7NN1LIpvOPkEZspYD3VuBcaCv2C3WbQxF1NOaSLAWg2aYW0gw48VzxI8AzFF7clnI+CEA0U1B09j+oAL4Zliib9G6bs/WIaAFRO8f77JtI1ZAIgrYoJpLwQU3c0S4PWwnOKurBF7INaWXFHKByfzddxvL1kvmJahx6TjygGT2fWRIYs2Axz8KVJaMHpYW20kqIPZfRY55V7T316tNcTfifkJ6Df4x7SFhozPLJdVlqvjwcvqHGJtrqqtTtZin2wRazzUyvjLcUMoI0/2A==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6607.namprd03.prod.outlook.com (2603:10b6:510:b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:57:37 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:57:37 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] drivers: ddr: altera: Fix integer overflow during size
 calculation
Thread-Topic: [PATCH] drivers: ddr: altera: Fix integer overflow during size
 calculation
Thread-Index: AQHbj0u74Ne3wOeEh0a7Lkhtakj7MrNtVMGg
Date: Tue, 11 Mar 2025 03:57:36 +0000
Message-ID: <SN6PR03MB35839AEF3129580EB5AC4A28A7D12@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250307102851.12964-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250307102851.12964-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6607:EE_
x-ms-office365-filtering-correlation-id: 5018a84f-0a0d-428d-e862-08dd6050dc8c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UrWKl0DPPZLi07PNGKe7rZ8XNEEjO3vMOw37qgzP9ZuoyDbCdroaaqsYs+85?=
 =?us-ascii?Q?nrcEauOyCUcI1rFiq9Yaxgz0qTqAL+wYY3+ZO1ioIBRkmff4YpIiBi/aw5Bp?=
 =?us-ascii?Q?T9tYuPUEPGhJlyBUOxqaWvU93GDvBcIDII9Q893QFdfS2PZfT/xx99AOtvY6?=
 =?us-ascii?Q?+5x9a99vIr0yHwxdbOC/bQCCH9+ZirP1eGdMcoEe34IfETxIQNxzvpntSZKd?=
 =?us-ascii?Q?PyQOaGnJ8/DQO+d1onNAs6yiSV6isJF7gfRx3iQji0GrX1OA7GTKYqnhxbXX?=
 =?us-ascii?Q?oOIwqnPnl/jErgDiHaIWmiR1zLaWqg+kXzzHSiIvSKjuHN5wRHDsdMKn3viB?=
 =?us-ascii?Q?3uyEZHuwWsnO2M3FHkxv0JJKbwdOST9teVEYSergtQekxw00WEL/R7nF183P?=
 =?us-ascii?Q?UF3P1HAU/+5d5UVQSLo9s36/mbpbM8aqOIffrWgpQlxQHJAJPositXhX5a95?=
 =?us-ascii?Q?h2rbtql7MOQmQAubooAIt63U++XK02ShxfBJ4srHYz3J+fDIbWbg6JZ+nM3i?=
 =?us-ascii?Q?SkBhdt+U9RIzgTVsQU0xKSsPwKtZx+TPOkpbHYJYE0Z7dlGwCPAToceQrNm0?=
 =?us-ascii?Q?lBOe4YpRL8DaCZQXL75iWhUXVk6+HaWie7h00oyKcUyAIBkgD+tvzLg5Hvam?=
 =?us-ascii?Q?6Hdqu1thRfESjjW5/vaTFqWPR68kBwqGz/bRwtYdLs3TuQihIhO4JpghNGv6?=
 =?us-ascii?Q?uIN1Pv2GDujg0dUHj71yhL2L2jJtgrY33/gH/4VFVwP7RKreQLMkNsr/SyKn?=
 =?us-ascii?Q?L20OPSZ4CYtlWXrzjryOc6H/D1uimmLlP6FfsxS930eMa1EX2qiY+3rFnlPg?=
 =?us-ascii?Q?RQfm61CrJqDlNasFQY1IeRMu8E9N5vPKEAL/dHaQNMkEqWKn1rl4FHINyzat?=
 =?us-ascii?Q?yAfuYDZ38gnkX0i5jmYHxdznhyYpwALsyAebvylGCp14AAw6Unz3GuCETBbs?=
 =?us-ascii?Q?WdBphNaNrAqNpW0nVEAd7SlTxCCdhWMYOTAsrT9Zkaa6yuf2h1fTlNO8FTnp?=
 =?us-ascii?Q?KA3vDvCfiKImwsMkLhGx3KR7P/dvNFKe7ChtdFU3EgB7bsUV2JyfyrLt12Nm?=
 =?us-ascii?Q?0HzNcCrsx4d485k8hBwHfETkrkAO3oXqktsbZfwYnu6sb/9sdX+4ce8omWEC?=
 =?us-ascii?Q?PWK6HvBZv2CM+hPUKYwSZg7kxUHI74lay6IdFVaruM9gb5CxL4jQ6ZckeZRG?=
 =?us-ascii?Q?JLr5VUNU90nNbbcsUSTihrIjDuCSkwcDSsGidEuyEJ3ex/K4YjQr0NPoJ0da?=
 =?us-ascii?Q?WFfPGt8vMeI2vSdQTU6VdxDEVRup2Me8u4b4TmG11G6CwAqtNoV4zbdh5FH/?=
 =?us-ascii?Q?1YFs6DzQK6nXFdYUQs8M1adK/TxIhizwT5flg39fC+YMTWdALWrvdggoTL0m?=
 =?us-ascii?Q?NCU3c7K8Dg7OJ6V57a0RB9xguIvh4tb//KM0wDTRNBL9+fDmEi2UpG7kKIYs?=
 =?us-ascii?Q?jMC0DHQap6ZVumvE80sityWTbid4RmCY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rcpdGmiKRx2wwwAA6tjlrSJXcz/ixeW1XI9qI/EJVVfp6NOxlYFy1kd8wFeo?=
 =?us-ascii?Q?sGRSce1eUh+treTg44urpDum/du9QFOY1/LRLbCbskH8pGd2aWwc0f1rBnTS?=
 =?us-ascii?Q?Jl4ew39jXCV96Q7+BhPITz8dUIg6qcz+J+bDMBwg8mEEevXHGubE/KdzC88c?=
 =?us-ascii?Q?tM4+jiEgHyIaRvfHb8Vh08z1zxAbGKVHDTpeSYMs/PWRwNU8pG5/ztpuHwB9?=
 =?us-ascii?Q?F1N9W+aKMrdSyxPvCqCQZQYXhWNr2BQ7ybEqXNuhOh1o+sSRSnRGaLGcebZ6?=
 =?us-ascii?Q?APHEskVqltpq5RZzUv8gFzTuOKBp/JyJ9jbTEYoqlDS1E1X993Q9VBRMZocX?=
 =?us-ascii?Q?BDKDL/r7PwJrs25q15Nen9HiNiLD9KLab0SPRwnlxEJLgAxtp1kfnZqcO9V+?=
 =?us-ascii?Q?6+jSd/UB54T230MlZCilHpbJjPLv/h+o6HCK7zmlpA7fVcpER0ef8mIsT61h?=
 =?us-ascii?Q?0G1U+Q0CNJZjv2Z4jwGPCeObtnmXyUWa+MuPRLh2Hhx0K15kEwe7RxZF+6CR?=
 =?us-ascii?Q?axPEMxJFA4bYChjklPlkOjLTg4af3i2oWl9V0j910AVgpLJIksINGc8t0ysk?=
 =?us-ascii?Q?yU9DpTymoDrVCPaHSr6oYIUFQkWCOPqUFXuzezfjCPnoCVvGOin4w3Qb8KTo?=
 =?us-ascii?Q?FcMBjkzrwk+rBn1QdEhQwjS966I9m9Ar9ImKEUHcvmg5hvpB51qdYv+SqMFl?=
 =?us-ascii?Q?iC4ds5oJD/9Pm2J7FvtbTwUVR9hY+DxvsNY6NLulhAS4YRwQ3OQfxNtSJmHS?=
 =?us-ascii?Q?hC8i15oOB3nZXeX2vyFWztFHHkeHk6DNVyFgx8opSWcMSPNi0H9NjTJEBsyk?=
 =?us-ascii?Q?9rj6QpnzL30BzROaFJM3EuXqkPWZGDRiOBrGESoRD5kM9pT61RlZN1nhSOmq?=
 =?us-ascii?Q?PBJVE6M42QwWRUaZXDjac45C6oyu/Gq2yh+d7m+Wtqc8sYSJvDBgyxtc752E?=
 =?us-ascii?Q?apJROb4dSXMoND7tUshEhq8snyYs3IGlOuXRZG9/UDVck0SUmge6Jzt8iE6v?=
 =?us-ascii?Q?VvTjkkRx91o0UXOWTfsN5pjkD62FYyn3C/RM6IaQIiL6ZGjjcH23cFgKLS9f?=
 =?us-ascii?Q?sqR+5/v+388YvaWTxtNtlrDAu3bFSvsxnNINXqdwKSFOaskBWqwQGB3LGPkc?=
 =?us-ascii?Q?yHJG43SnGuol/3ynen8O0VCBjxpyrkselg0xNqRg2fyB7DSm0MiLlykundoW?=
 =?us-ascii?Q?3dK0mNN63AnEhIllxf4ON0hlKvkleYOAjcbbDlC48o2nUrGryMwDCoYQhAU4?=
 =?us-ascii?Q?VkUlpeOObuqLpInDA7G+spKnU1MXzDn7O7hMl+FMTOxx8C7Tqe/YVwjFE+41?=
 =?us-ascii?Q?0YRzbzNBdHcqilVmwRlxwyjhyK6xCL2aTJIh6zYHBBG9AFuJXM6B9vgGnpOu?=
 =?us-ascii?Q?YKueOfPO5TO7jTsI91zKEMBI40XX5rYe240i4YNo7bEYmFlyPIpnp6hL7XxX?=
 =?us-ascii?Q?tSUJ6nPhA2ixQLKFf6n58rv//vbYifnhu71fzlt0JP5RzNyXAp5sLQoHU+zH?=
 =?us-ascii?Q?WPzTU6/V2YVuPPzaLTN/8/WC6KOHEhpFiY55M/HS5DR6iacJfqIoVvXX535O?=
 =?us-ascii?Q?zgsuJ8z+K8TeuP6QHaiRfmGwXhWBbhL8DBdQitri?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5018a84f-0a0d-428d-e862-08dd6050dc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 03:57:36.9870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/QhvtVg8G/BPl3y+RcqS1UCaWvSi0pCSHEfutdmGpw//aHYlraK3k+5O19u4BKPV2ZsKfEYWGcpfaLeInMCZhEtiwBLwiT9bV0llcTfHkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6607
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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
> Sent: Friday, March 7, 2025 6:29 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] drivers: ddr: altera: Fix integer overflow during size
> calculation
>=20
> Data structure, dramaddrw, is defined as u32. Compiler performs 32-bit
> arithmetic and logic operations on this data structure. Fix is provided t=
o avoid
> integer overflow while performing shifting operations greater than 32-bit=
.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_soc64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_soc64.c
> b/drivers/ddr/altera/sdram_soc64.c
> index c8c9211adc..75c6de1e4e 100644
> --- a/drivers/ddr/altera/sdram_soc64.c
> +++ b/drivers/ddr/altera/sdram_soc64.c
> @@ -249,7 +249,7 @@ phys_size_t sdram_calculate_size(struct
> altera_sdram_plat *plat)
>=20
> DRAMADDRW_CFG_ROW_ADDR_WIDTH(dramaddrw) +
>=20
> DRAMADDRW_CFG_COL_ADDR_WIDTH(dramaddrw));
>=20
> -	size *=3D (2 << (hmc_ecc_readl(plat, DDRIOCTRL) &
> +	size *=3D ((phys_size_t)2 << (hmc_ecc_readl(plat, DDRIOCTRL) &
>  			DDR_HMC_DDRIOCTRL_IOSIZE_MSK));
>=20
>  	return size;
> --
> 2.35.3


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
