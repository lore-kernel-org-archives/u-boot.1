Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254BE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 04:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A365E8036D;
	Fri, 27 Dec 2024 05:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="giLBgT8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9800D8036E; Fri, 27 Dec 2024 05:48:58 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8083280362
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 05:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRFBWChsraN1IHPwm77ZAebPiXvCn97RyT67X/Ee6vqGyF2kvs/y5S/vaDyia9xl5x4ILFqg79vcsZEHlqCMMMDzxeJmFPZDLaemuLKTNBiNBD9t3lPn/0yFNRwI54hy3lreINj+39Mv0VBY/WmZQ1DLF89Hx67AXeD7GJoSEc/NmpGSzMHbvCnsIOwm9MNyN2ch3G+xG+/iPgMTww/RvPHFxexzhu04skQuDS803kxiB7BQnNQvEl/7H1ojqvpDnstqbJOyelqhDkN5ZoyQhPCxTAlsz7JfUJ08zdMpStwLYDXCbzDY5eOzvQng7imcnkHL23KyxGNUldfZWcx3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3IhJUesYYDBYCSp+qSaiVW+kvEWu1FGEgr07b9dW3A=;
 b=IvXAazakPfj95Z6HuBHCSo/jsNRJAS/BAN4/3zy01nEyCqpHqQpUZaLQo/dFQTBpAIZcE5mkwpxcjt/In7nith60CGuDDsd2gsuiAjp6dK7KCQKqMVfbyxZAuvr3NPgLvlXqioyW7CN5PVagrT3tYJErViPUfWrATKLawoOFvyr835a0+BgcakOPFWz988D83NxNjmWuqTYL/nVmXPBokHOhEFEDV/tj/dbEgtklJ+ItLRFLOQQnIZpicJh6A86XvIh8tMcsiIUYo0/QPjY796Mea5J4+ZLZC9hYhTLxx368TXVxbucYpdBvI8Qz5ZVCYJu7h5zrvOPknD2OxeKYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3IhJUesYYDBYCSp+qSaiVW+kvEWu1FGEgr07b9dW3A=;
 b=giLBgT8T8Re9W5Fxz2fgCcsjWNSRVE/IDsaoxa2Pgo1dOEKkWCdh4VpB5eqF+3xjGcemoM3c1ZVbZO8VFLdsiwLPqeImhY/ACgyjCHBl9UWayz2/Swn7RKYT9ZJI1J6qZAoNV2yU4HtuJ0OryBBOjXyl4dspRWLKkmBzxMTWtvM=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 04:48:47 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 04:48:47 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbVhnA6SaeFPNcj0aePpXMMDKww7L3cIkAgABwcvCAAMVbAIAA4gsA
Date: Fri, 27 Dec 2024 04:48:47 +0000
Message-ID: <SA1PR12MB8697D94CADF2C51AC22EAA4D980E2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
 <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
 <SA1PR12MB86971E0E6A10C482A4F7568D980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241226151726.GY1505244@bill-the-cat>
In-Reply-To: <20241226151726.GY1505244@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CY8PR12MB7313:EE_
x-ms-office365-filtering-correlation-id: 7fee395d-5364-491b-763a-08dd2631bfe8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sHWzlUMyEaSL+MfVLcEkQC+z+MJwIORIr8erkkVHicuJ4GgxjH3ae1d6RYAS?=
 =?us-ascii?Q?VyUOtYidim1Y0XOyNya2YU7EH8V9ye3Qr+cTix5JRI8vxh6FcnySPJOWqyrH?=
 =?us-ascii?Q?cYLmfO2lRiVECF2YBPmfgAAuZJ5o/TIOyBa3PPwuLl89moZ3ztaaXz372Lw4?=
 =?us-ascii?Q?7836LMHCQQNNw/RdJC+u7VNkNRXMYj93aS44fddCYEVZuOCerIr1AGAUpyHj?=
 =?us-ascii?Q?sgvNKwtHMr5ixuMT+r9lY+EHYAfXKxpLvRUs9bwVT+i+bI8SbXZ8aD7on1Qf?=
 =?us-ascii?Q?AjXOwapAxOP7m0cR28KPhRIB90a4Mjv9ANB/WfuinJDQrvXvCsr6YQ6rzCQE?=
 =?us-ascii?Q?h+3MRfwSwhrWJo9w7FAGqcW+WB+TShrVZajE6l1Cjd9rM95t6rXDBduNT28X?=
 =?us-ascii?Q?cx4xH3AOoBXaoPZ8gV25lu5XAvYoGKJBEtpKKlvlKprLp5tDQBFpern0zGms?=
 =?us-ascii?Q?If59MI05lLscRahdYNFvrYY2E5ojufca3pmyPgMt1ZupGpRFoEUW4C9YTATw?=
 =?us-ascii?Q?bpKEyJhVWJT0uSymxhEeLRu2o9YMIpSE3Bh/x6jN/77pYgTfJwZ+gOKvz+98?=
 =?us-ascii?Q?lvYU8EdH4hLRUr0JqHZrHCGC4dSphpE5wjqol2SVrl+g2LBb+JDINs/SNvbJ?=
 =?us-ascii?Q?jRnsIbF4KdZhzN3wt2X9Q+dKFMoj5szUckqDvsjUVy8h6937VLvgMU+IsKWp?=
 =?us-ascii?Q?1udYVUNJK5Zj0rNEYwVEzoJN0+ub0uYv9JI3S7mBK31Rvc6hkq7VFaoepq60?=
 =?us-ascii?Q?T9LMR5HBc2mRuMut85nq5ysc4HtO9+G0k/rD0qpUCkHgu1bM2V867++yLTgM?=
 =?us-ascii?Q?1rHz91Sqm56hcBtlLrorck2vXaUJmJgms0id5IjXF0yyZPi6fCz4falOZymN?=
 =?us-ascii?Q?jnkgqDLdHx8TaI4N6AI2+jzKR7pDrWSd4xvQDviMDmy6PsoeIk78oKDUhGV/?=
 =?us-ascii?Q?IRor0Ezlo+LVeC4A+nIDhCQV/Xiv+KVFj6ww0FrDfaJ72v6zOSQKiGlWCwcB?=
 =?us-ascii?Q?UjkBdEVTRIq75MUtrusNmiPfvX1NW1zg1IjPKccRwo48yxvU5SRV5T739CVw?=
 =?us-ascii?Q?G/aJHA11g066V8RA2/UR3DfhM9Kcl4LALb/Pk+lRpnHHEvwZq2RsTOIZVBIS?=
 =?us-ascii?Q?W5FgMPMm5Ej6upXJfpvkmt6e/vlpuorbGY5malp50McamPsJE5Xl5vmSzx+T?=
 =?us-ascii?Q?IXqdWhiNOD1OJDhUPKfn7NTlYTaE6lE4wktb1fyEeTqWunsCpiRKeQiQvdUZ?=
 =?us-ascii?Q?R+pD64l5b3cB18oj/iKdy4KW0OCYUOyqTvjs01FRyGaxD7PIzoR9wLkybr6E?=
 =?us-ascii?Q?kRfqJufENz5QGEVN98f0v5wtW8xgtvvhsJ/cu6iwoslDxDIClnd98eTFLdey?=
 =?us-ascii?Q?x6qYuGpGaqf02+0+jfKmQYrHJMwGCbxavENBg8SgAApImgcz65+Mn9U5+Clf?=
 =?us-ascii?Q?8vxIGfUwleLNoHEA7+JmBGlan/wxtaE3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZPcpIpyOI6zpvL7wLPQNeo2IDxbdCJw671B4CTdJE4S1R5b5Gps+bs3srrOh?=
 =?us-ascii?Q?VEBiQCMhqSZ3izI/6pBPbFBr2UPNm6k9+NonOoiKrYt6lDtyBKmk6wPcxsrX?=
 =?us-ascii?Q?9uPMkD3ZtIg+JGNhitSn2wibuQsa/58Nx0dMixmAx6xD+THWVNR1listEIwp?=
 =?us-ascii?Q?muIv4GQ38k1XrrFFcNxlggX8DsEH9b6o5+wjkUcSC0jpwgtPwOYpfxAbZTKm?=
 =?us-ascii?Q?k3/kRa3JrDKteMKKxdqde8RIY52YEQ+nR4nQ+ctJw+MbeHYi/L3wvcZTMSiZ?=
 =?us-ascii?Q?JtrU4Oq7ZfuA120oaNbuTQTac9gvdTLGuiIjlW7T6AhMS0khnIBnFng9IqU6?=
 =?us-ascii?Q?C/HeD5qvrMHrIt+7BL9C/+Y4Wv7btTBxe0yfFqq+jqtskQiXPkyMmXXrl2c4?=
 =?us-ascii?Q?ewov2H9VVfbgUxQ70wsp7nUZvAgssog8rA035pOA6tR3xmcQCDwbKtDaCGfP?=
 =?us-ascii?Q?eK/C5/nxUSEQMZH0kdvGRyd2e/r/eh7MVTyPkZk82TU9EgdizNSRRCWwBtOw?=
 =?us-ascii?Q?sqSTCJzPcKZ+SufAZTZ/4ig7BfBLNR+VKUTAPz6XWnX1FUDRj1OXyva/fpVY?=
 =?us-ascii?Q?SLV/v51PkqDKYkCCjDR5pAeVKaNDhuPUmPc0yaJA4cJNyYLhWNRVWlLHPt6y?=
 =?us-ascii?Q?u8RVqP1oVG/L9NYE+JkLTgYlSsf/XAjuhauIi1qDA6bo+Rwa147GQIGbf3BI?=
 =?us-ascii?Q?qzK+1eB1vB6NISl1zvTG7t4qQqSJR97wTfp8oeO3+/+Hl6GopfL+oB4uuvBF?=
 =?us-ascii?Q?VyI76eMFFSIO2NfCCFT5Ir+71qk6oEUo3ZTFoLv0RKCKix0fB7MYPFXLgfXP?=
 =?us-ascii?Q?jvdwaZRh8d7OkXzXMzDT7SOoWzDxjyIQBQpkR1PpydxrvqHg1/zG+LC5ZgBP?=
 =?us-ascii?Q?2IhnWK/RunOVaLmr3npCqZA08BcXANdb2UqgOizJQM41e6d5MeCLQ/UNi7kz?=
 =?us-ascii?Q?yltWR5zDaBNnzCEQD1YkoFVAYLdqHm1N2WRUqD16FpUAPtIqr9D6yPLNwRtN?=
 =?us-ascii?Q?+bNAqMwoG9Aju8fPlwiSjiPfocw9qOxA7qznYYi1vr7OTzJTm4KoePg8tPLl?=
 =?us-ascii?Q?ccdeIAqmkteGQHA+NgPCiBxSYT5qBiQLS1H+cElqGgcVmXA1kNy2St038IJJ?=
 =?us-ascii?Q?TZ5OEdYal6y8cg7A6EPWJRTMWXlNNOV9RbEeBbuIJkw4pVKmWNGCYYXGcs1D?=
 =?us-ascii?Q?Xv4dC+eWvWNC2PqtGIUN1s/x/y3z7jeY44hoT4LbvyRfDLBd/GGbQgm6UXne?=
 =?us-ascii?Q?/BHF+V5uuioh0pELH+7k+xvKpEaIUM5HZamKH4519dhcPEi67zNxlhqsHiwI?=
 =?us-ascii?Q?7oPr3EnsxCW+69dnR+RxQjwfdm8w+O1Pr34ceeG0PCoKHxVbeJY9AF9GXC8i?=
 =?us-ascii?Q?VXxz1RJ1tlWyAq7CxzqWiYWtasF7em0+dvLkVildnf9HI1GOLyDWg3/hQb1D?=
 =?us-ascii?Q?aBQo9h0iqwsfeutygTqMiQlwumbwD9urcAr6/OYV7dIIc6jRnVfGruZ+IK2s?=
 =?us-ascii?Q?wrZGXNyWKfUIryS9LTI8oDR4j4bJcnKd+FhYScKSIoPU3E19GfkuR1UStSvi?=
 =?us-ascii?Q?v+U4A31fL4WL+I/M/jA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fee395d-5364-491b-763a-08dd2631bfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 04:48:47.1215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDPkmte+dMUxGoZ3Rp6IDkqn/nK8VnAstUL8irOweDDsXM/bTsiyd+HgtrmG9+I9rSt3sxVcflVI5EBVcL8Ovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

Hi,

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, December 26, 2024 8:47 PM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Cc: Marek Vasut <marex@denx.de>; u-boot@lists.denx.de;
> tudor.ambarus@linaro.org; j-humphreys@ti.com; Simek, Michal
> <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com; u-
> kumar1@ti.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com; p-mantena@ti.com;=
 git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
> SPI_STACKED_PARALLEL is enabled
>=20
> On Thu, Dec 26, 2024 at 03:34:33AM +0000, Abbarapu, Venkatesh wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Marek Vasut <marex@denx.de>
> > > Sent: Thursday, December 26, 2024 2:19 AM
> > > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>;
> > > u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com
> > > Cc: Simek, Michal <michal.simek@amd.com>;
> > > jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> > > trini@konsulko.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> > > sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> > > quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com;
> > > p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when
> > > config SPI_STACKED_PARALLEL is enabled
> > >
> > > On 12/24/24 4:37 PM, Venkatesh Yadav Abbarapu wrote:
> > >
> > > [...]
> > >
> > > > @@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info
> > > > *mtd, loff_t
> > > from, size_t len,
> > > >   	}
> > > >
> > > >   	while (len) {
> > > > -		bank =3D (u32)from / SZ_16M;
> > > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > -			bank /=3D 2;
> > > > +		read_len =3D len;
> > > > +		offset =3D from;
> > > >
> > > > -		rem_bank_len =3D SZ_16M * (bank + 1);
> > > > -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > -			rem_bank_len *=3D 2;
> > > > -		rem_bank_len -=3D from;
> > > > +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
> > > > +			bank =3D (u32)from / SZ_16M;
> > > > +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> > > > +				bank /=3D 2;
> > > Is this code which operates on (nor->flags & SNOR_F_HAS_PARALLEL)
> > > really supposed to be enabled if (CONFIG_IS_ENABLED(SPI_FLASH_BAR))
> > > is SET or instead if STACKED_PARALLEL symbol is SET ?
> >
> > The FLASH_BAR and STACKED_PARALLEL configs are independent. They
> won't depend on each other.
>=20
> At this point in the release cycle, I'd really rather see things as:
> if (CONFIG_SPI_STACKED_PARALLEL) {
>   ... anything needed for the new support mode ..
> } else {
>   ... the way it used to be ...
> }
>=20
> And for v2025.04 we can move the codebase forward. But I'm worried at thi=
s point
> I'm going to have to revert all of the stacked stuff, which could get mes=
sy, in order to
> avoid regressions elsewhere.

I am updating the parallel/stacked code based on the config SPI_STACKED_PAR=
ALLEL and not touching the default code.

Thanks
Venkatesh
=20
> --
> Tom
