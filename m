Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3674ECD343F
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 03:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74450846B0;
	Tue, 19 May 2026 05:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BL8c0NM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84B8846BD; Tue, 19 May 2026 05:01:58 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D4F846A7
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 05:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ/r00qIlJzQM3Q5JFdUl0QFKEFKIUdCidDTI6AQcVbebqIc3uNc2ZO4dDAe2yQBOhHidVamQ6mWYdsGdQqNEzvaJ/ys26RuUDvnOj/l0Ol4nLtXpLTwN7rh9Ybgdle37taNBct809yELweenXvztq1DepvguvggWH6OXQg+A7p/n5k0HMZSvG+HzIIu/aDHzH5WzV+zXQxI+iPCZpQYCMmlzR3dCYNRw8yZqNxCl9JztAPLQt3gTKBY9cRd2Vn2L7Wug/ekxU3XseRQ64SrbfFccweUAVtqM0ts6AQjhdhAjsO02d15COQxLwfiI7g1LGXnBrv2I1CsycbzgvteGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZzs8uSxgnbR+5yuv9VZRqyF0CUJ0bL1gKooKl5EvEc=;
 b=imZoJWuXnQ3w40ogX7RMOnitjDdK+r3dpuDgOg0l7WfRDCWuKJWVMwQ8f7Kw38jHLbSef5CZ+x0QJtF2vSpCHdBQ2ENSdvV5TKAruFZAYFndTfny39h9MLrqmNG6hdnfLOzgfgWMm5P/NyIaYZup/c/3YGvnFSANVtnTZcMNebLdlXKNjJxJXvNR21b2xPjpEfYkW+F0xnYDZ6IReOj3pfUU8wMPbI9+6o0uRKllCOdUWrxsaeoa0XIbXmTSex9BGtgoGwVt6IDLCHL767YQpQpOYIZUqDsPCs5mKFLQTDcmWfW/MKPJjxYkT78z+VyfX/iFQC9OlM0Re9iNkvf6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZzs8uSxgnbR+5yuv9VZRqyF0CUJ0bL1gKooKl5EvEc=;
 b=BL8c0NM81NIWzLWSIZ5WWSLn2WCpvssa/i3vRn2EbDFpd9xxxH1R315f/YUT+NrlRD6e6hnbhi/hKd9aQb/5Fpnkg53kcMs/IM1xlkZmgIzz9ICrMNkj87Fln3OC4pRQfpkIwWR++PpUryXg8gYeSR/C36W+Bm4LhS1gKUUlfjlD7G9SqFWt1Ak+Fvh3As6OJtKoHz7RCXlnn4aRB2vaogE9vInNdDce7fhZy+QbO1fmLvEWeVz6mp365TPZIO1hjpDUOnmuaDvUqcDNxuPrM96wDCbgvbcpxCzWUleE2w8bAMFDUxE2TwkS/JIW3jc8PjzC9ZqbV+XVp1LHNun69A==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:01:53 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 03:01:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, Fabio Estevam
 <festevam@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Ye Li
 <ye.li@nxp.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: RE: [PATCH v2] clk: imx: don't build i.MX/RTxxxx code for all users
 of CCF
Thread-Topic: [PATCH v2] clk: imx: don't build i.MX/RTxxxx code for all users
 of CCF
Thread-Index: AQHc5rfC8qdFTCC+20Ss8963prKOPbYUqgWg
Date: Tue, 19 May 2026 03:01:52 +0000
Message-ID: <MRWPR04MB12330A34A1C91C61509D5D3A388002@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260518111601.202277-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260518111601.202277-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|VI1PR04MB9738:EE_
x-ms-office365-filtering-correlation-id: 067a0b9a-ab45-49e1-ac25-08deb552fa93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|22082099003|56012099003|38070700021|13003099007|11063799003;
x-microsoft-antispam-message-info: /WeqZ1woHlkX7rjsQebEwTz8ozryVnkN6f+t+acaSmPk+IXj97qRWAAMZMN5DWDjiE2iK7j5rgTu9MFTdl6gRhwpwkpYCafIy5xweDzsh1Ogq7yfWe6ASBhRBxjrIAqZi4NfqgNzEp0F9NdE4mqJYy9sz21KShTS2mhWlwR3QX8Fd5DFEKMdaTNCYkxYYI83ZazDvuR34ZaSN5MDlxWn+Iu6ySY2UOl4Z32FIB5XBTBCT9+wOtYLD16lGbV6Y6Lo5zNZiRW3EchBM3EMHGDT8LBulEiW9QSki9OYpSE9UhdoMF0cii/NG8LvixNsKETi4eFJOy3CLBiv3FrLkR3klAJvWYc8JQO2HOTNrevMRsrxXHB6vyvJFtVqIf6w5wFMluapshkA/temQkoKZOL7RrLnFc3vGmuxj7RYmRsLCaikl1MGlDQuX3I5jeowPdRtobHO+DSAYhPgFzPslOcssPu9Ix0fgFiXRKBbPR6cGIhZbIc5aiq+FcIntV+8009wQHRq7AQPX8pmlbnmlwLW9b72DcNUYXrkpcETxnxo9Vc6Fo5WuCyHnPWjghnkaBYRLv+zW0yN7rqLfgDtCUDMr7jjs5sxpLC3aNUiOg/DKWiGNKnzDhPoDng26Fwi6kMHQzB1IRgl2YS/wloPLc2hwYTpTafez8M4lJXsTPFEGQX+g6zdrZhr7n2q/JQz8D4ti6rajMDfhAMZoeTWHEpNiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(13003099007)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S9RxpZhRM9beqgzEOv/G55PZVVwMt2E9O4NE41i0bXECeBf45BwVHjMibCOs?=
 =?us-ascii?Q?FE3s8Xyrl5cuy9RofWFJU1dzF0LiKOkXMIKXPffbqG/5UT0qQYvyTlXFqL/A?=
 =?us-ascii?Q?znzmRD9laBZEKolzhqAmQSuGKFf293E9gcoZb2AVPGwO46FTKwYifS4ZUmGK?=
 =?us-ascii?Q?ftmJWDb279a4qyE/fEoRVTBJhf6DxcIT3eZiCDuPa5fBEuljWQoh+wcXDuEv?=
 =?us-ascii?Q?mlsP8DFKiZHcXXp82pRKJPB0fOZdpaeoXmNDUUMOTAaAv0q7H+JLNhktGKeX?=
 =?us-ascii?Q?eCtoGKt64oIFTCdYNbeL5htfpBrZezTOvttDSwRQwOXVXr+At9OyYGgzstNb?=
 =?us-ascii?Q?sgdJeofzkbWyMCAkY8+qmPSk/lTaSz9DzofRfl5gaIqChWr9CXJgtfC0IMuI?=
 =?us-ascii?Q?xQRUNM2t37CNG5+TwDjPa47bHf39Dz38ngGevquSPqThJvLd5in7BbYtBBfq?=
 =?us-ascii?Q?6ZpEKR72C+CMa32EGeP6I48bOOeDQiwrpFFlYnm1c1vWuEfjv6qfU1oh40Yx?=
 =?us-ascii?Q?9mzq4Z++fyd7sjSbpLmFGbZggSCPvlLuZZWR7ox7fNRDBGZtk0kV1See4LBU?=
 =?us-ascii?Q?GKgqu5sWnSii5+lUoKFVVsk29SlF9Lh729Pd093q1gjx1w47nsAhtkBhxU5f?=
 =?us-ascii?Q?rTH9lbGBA4PhBWMef+MoDnMsX0CIV/Jsw7OwecgI0/jMpIDycSjVmAe+j7j/?=
 =?us-ascii?Q?X9mJsezbmH/m3dlAl121Rf2RDucH229RNwiwBfyLzA00yBcImwkr1XivZIqO?=
 =?us-ascii?Q?rXNa5LHjn6saIAeOVPtxUTowlTGOfxDrKlnZL3nUMFiofli3pXwVTlL+9W9R?=
 =?us-ascii?Q?Sa0e5iq02hBui8xJoPnCZd55WsvSP6VC7vT/oKY92yVyIGwO6QceffVBGFd5?=
 =?us-ascii?Q?XyVmMHgv4/OaFLKy9S6JGZB1p51xtWO9cUbfKSl22Z1Hpa38ZHdzwDTniWid?=
 =?us-ascii?Q?PzGb/8IxrgZ5rsO7tVcLRaANa8IxyenN2ednA7Cku8Q2B7NvGXf5lYdZrz46?=
 =?us-ascii?Q?zL4Fwjli6dpTnIfGO99dx63TY2ZjJYfGNI1RWYnhzvFDUNWWog7odhFew3R6?=
 =?us-ascii?Q?2f/d73zOepX3ymPL/yxp8ZMjYTPpqPZ4VPFWJNyxddkuRbsrIYBria2qeQ9j?=
 =?us-ascii?Q?ogmZoscUxjJKmaH0rDIJ3SOu2dT3a4Yb2Ryac0PV6aKTThbunx9GUVGY5a7O?=
 =?us-ascii?Q?QqwXdAAiLUEoBKesYQ3tXp2oiJozWUZxsAXhMFTqBb9L6cF0rRjo4kDwWHeK?=
 =?us-ascii?Q?eQvg43YeJKTfTcU6y4juyQywrwMK7+9WnrI6cDNDG5sUC0vYq2o5d+X0JnTg?=
 =?us-ascii?Q?nJV/WV7lXYQXgMIGD738/aevwkGZBQ/n/58TXydPXPnc0mjTCjEp3hxjdk4I?=
 =?us-ascii?Q?89P/NejJP2Nb8rzUt0/7EuLM760Z4yl3qM8i6Dfz3RbWYTB0+i+gkb2v/nXl?=
 =?us-ascii?Q?AT3oXviqSdXDWvDueT9gjXx1XF799MiYF15j6ZR6rLR91ssBfnkpN5hYLz3Q?=
 =?us-ascii?Q?tcd4z5Svf+VvYFAEjPuyKgX/P4a+ZUmOAHZQd9A0QZW/R+87ppZJzt1ZS9Z/?=
 =?us-ascii?Q?QHgFq3Rai8vqgcGKWiHYehLPDIrPrrCAgyfhl40N7SGMtz0g1xno5uMlQLYN?=
 =?us-ascii?Q?Zsj6BnU3TIGrwLEgVfa8HDeuhQCt08ISPkHkArE+FZuy61QWMjjGWsUlPQrK?=
 =?us-ascii?Q?S7UZZU7FUlLWiiV5U8/Nn4pabRS22fJ0wjYqycynX8xDDuau?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a0b9a-ab45-49e1-ac25-08deb552fa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:01:52.8838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEFLyDTMUuAWV7eEpF76nCJk12G2EcGTw1VYPrvTaxMwWVi93EJ7VtSgQV4Ipn8SJLKulyuFodHwfxugSt3new==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738
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

> Subject: [PATCH v2] clk: imx: don't build i.MX/RTxxxx code for all users
> of CCF
>=20
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> When commit 1d7993d1d0ef
> ("clk: Port Linux common clock framework [CCF] for imx6q to U-boot
> (tag: v5.1.12)") introduced the parts of Linux Common Clock
> Framework, it was done for i.MX6 only and even had "depends on
> SPL_CLK_IMX6Q" conditions. Since commit
> ccab06689aa2 ("clk: imx: expose CCF entry for all") the framework can
> be re-used with SoCs of other vendors (say, TI), but NXP SoC-specific
> code is still being build. Is is especially problematic for size-constrai=
ned

Typo: Is->It

> SPL images on TI AM62x.
>=20
> Make the build of the i.MX/RTxxxx code not only dependent on
> CONFIG_$(PHASE_)CLK_CCF, but also on CONFIG_MACH_IMX options
> which shall cover the i.MX platform users.
>=20
> This saves 2264 bytes on 32-bit ARM platforms [using CCF].
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>
