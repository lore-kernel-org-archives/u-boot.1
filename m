Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58396CA0EE6
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 03:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAF781FEE;
	Thu, 21 Aug 2025 05:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PL1Z0b2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353FB82E67; Thu, 21 Aug 2025 05:30:31 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1B981E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 05:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrvKVd67iJ3VZE4nBvGDXQUCtGDwj0CT8rbCyViNpDrArRj32sNhBe5UCx9x/BHfPoEG9wS64ItI3bzolYv+0gBxSjqZMJnC4qX9aD4JhEZuH8mJvyXEIby8BNYG0ASCgSCZC02cL7PtiOu08zjelM1CwCsdwlaE2NS2u4fdeXlw0K4QL5VyNT+FpDKbaLFQ1m1aabDqpuvDienaTPpQcmngAkaoXBvnQVaSZSZQlFEMYDU66J4volhZtw5iihRG5/D7Wd6RP2owzH2is99sADgBavvRzjNiGJxhzMEcPs5Yc9Jonb9lbON0tnvltxEs0eHcsz2tctnWgG4XuJ9Fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUj+NxlwaGbUxGUhv0/NITnxSAcopT4pC/WoBpS5GpA=;
 b=v1exHZTZ3an331z7+ZvImWubjFtmim3kRTEER31uJRW5S1iHoouIcWK7sW63F1+bpAdB9hqtTKn39gpFL1xdcm6Xud8TKZOKfDooGHWMz0bwMBavyyNcjlauBdwudLgyX5CC1gDsUybcgymvjnKsZIFoMd3uUccVYzGMae6FbKrnxR1uXVzLUWyaPlzq0LzseMWIaPsjBpQVdF/Dbc7ELmG2cU+jmVEiGIyvl/LMnhSrpysJJMyew3P/t8MSkqqc2Te1nAKxIs/2lr9a0PtUdlxp/hyA5HUOFo1PFkDmrERGbdfD/u4UxlfaG9+2HnVPfHb4Ww8JmHlKZQinLT12rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUj+NxlwaGbUxGUhv0/NITnxSAcopT4pC/WoBpS5GpA=;
 b=PL1Z0b2bD5JSCrEXhCEULU9u2fuFyLk9iFAAlVA8lflt9B9bNhcHy6MLm0GY2chGxqsjilmcg/hMIl+5PfqF2DtPLmhInBgP4w8W3Sge4d07Aq/Po4tBKcDwWmY8QAsTZUsJTJSYdQLacfJCBbOr86FKZJ408NGclkjCU7k5CYdp8r9H6rf9NrnNcBS6auQEGRUts6RFGeq3v8I1+V81rMIPV95ZDgas8VVq+9DG9H6NzwYjTT2m8M1IVZOIHtQCphUBOv7YbI/QLHMSRafjBXN2iOlt8flgM66ADDvHsOJhlbpoG78B/WckT8NZarpkTEhzovEgdplNyPXL0LvH1Q==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5165.namprd03.prod.outlook.com (2603:10b6:208:1e4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 03:30:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:30:25 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v2 3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF
Thread-Topic: [PATCH v2 3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OFF
Thread-Index: AQHcDMoUT1+0wQCYy0eraAEsjZhw3LRsfj2A
Date: Thu, 21 Aug 2025 03:30:25 +0000
Message-ID: <LV8PR03MB8137A0A118E99822E2C62BACA732A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250814031741.4887-1-boon.khai.ng@altera.com>
 <20250814031741.4887-4-boon.khai.ng@altera.com>
In-Reply-To: <20250814031741.4887-4-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|MN2PR03MB5165:EE_
x-ms-office365-filtering-correlation-id: 0aa604ae-56f9-4cd1-f050-08dde06311a6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JeW9mwEkfQ3FRPFKL9JGHxihDFrkKgPXXwrB/4txdXiiN5Z55670dwc+yVkc?=
 =?us-ascii?Q?nLCxDl+Nf3Gha7frU4yXXDE7naQ2l+4l0IPmy4B8BcoQ+HG9FfiUy+QppK0s?=
 =?us-ascii?Q?ML3FBx2f2rABDv6dBIILcYEmIvB2OwjgIsQecC6AMwkCFr+QYyS4WAguboqN?=
 =?us-ascii?Q?PJPHTBqyhuc2ycKYQUuboTggoBj7JNFC5KnmPD2lDSbsPEIIBpdYUy0UZY/9?=
 =?us-ascii?Q?KX1CbGzlkAc4ffqCf9rSCaY5lPCt1d70YVdOAhKE3gRz2ExeRT/T9Fr/h+Kv?=
 =?us-ascii?Q?xxLRjT79632M6Dn+e8dgWmPNXR6xrI6y+OMhKnvL7pm8tAydttiH7Vx7RGzn?=
 =?us-ascii?Q?CiIuJA1T3BGMU9VFdv7woU6WOCkA7G2xds4ASDVxYBXWj06AofbngNAnzMZ1?=
 =?us-ascii?Q?OFXoCyo7YRMbKodL2mysorDvogRN6qOQzTPU80UVm45efn/lkDDQ5di01Jzo?=
 =?us-ascii?Q?yNduDEcnnNYkr5iwF0MTgPE8PUa6t5IV2LxVYQ+Q9bepi79KrO5PSbUa1Bxe?=
 =?us-ascii?Q?G+5UbGRmvWzm1OPnBkNvuCrA/rRGbSCUeVyYxBIWXxKfNitkRfiIvxFWiIHX?=
 =?us-ascii?Q?l+qRXv4yDWmyvtFEb+bw2SiBMzSE8ozYzYGZUBxH0kpYOFig4XJduUF3XOc/?=
 =?us-ascii?Q?z4shlnlsCwypA1xI/YNL9FYU5jn23mcW1jE8kuMgtcBRzPaE4L703Eb6yRAp?=
 =?us-ascii?Q?S0bZKSHwecoGE7jZyKzmzbcty4QpjEjzjZdfO3iXkNNOxae4cytpCz47QKd6?=
 =?us-ascii?Q?CUF9enWjvExRngyJO1/P8Mn6GdkkFgB8wamAAe0szPczQvYljmyRZt3WwKdc?=
 =?us-ascii?Q?os4hXS34vDBvnQGF54pNi+sORS9Hi48/8JIoSaixTRnCydX0GCGv2CBBKVjG?=
 =?us-ascii?Q?PZmT4F8g9B78PEGGD5OytyIRLbcXgkU/+4bFCDt6pxnrs/dDJQ3OJj+4T3gi?=
 =?us-ascii?Q?/SU7AlbVlYhAoxGnn3ERa6LAifEAH0UR2wF3wCCDCZk1o+oC9OKiEehWmpkM?=
 =?us-ascii?Q?sAEyokSLOTCyuEud+Ul4C9EWuvjahx0OtNUiOhgQY6hov6Hj5ntCU07kMOgp?=
 =?us-ascii?Q?e7zPPb+lujGPAs7miwuqu+vZMDOsjr+O+fj/CrXLirJ06mYQaRAafDOE/xt0?=
 =?us-ascii?Q?l/hPsfxv8TwYBgG36CXqLf1ooTWnAk08ScsiMLGQ0WVawRP9MgbxbVGFn1nN?=
 =?us-ascii?Q?BQ6KTSptWj+0RA0ENA11NL4PmIgGuiYk1VBlhl72SJaxZPeZeA/wY2XJ9fVn?=
 =?us-ascii?Q?g2cEljHRcj03dpnixuRpwNi2SEVGoU1wlh0xDa9eKy7LGTNBGA6HpAzfJW4v?=
 =?us-ascii?Q?VBcz0QcyqAn/VDSLB6NKVMDdH+aGHP+9D7XYUxd+jJ80E5h3BT6VrUvjT1R8?=
 =?us-ascii?Q?a93vR7aW0HdeQQ0hmVqhwS8zySjz6aoSGHF12zlvKAPDJukkXge0dASkOhUI?=
 =?us-ascii?Q?k5+bjhOg/ex/kTzGz7I+G3b6hI3Xj8aeJ+/J+m/mDtLPcRAyE3YEP2R9hXL1?=
 =?us-ascii?Q?AjXyaQaJKTViqEE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71UsDFdPuAKzsIkqHLuh5HabwkgGeUC3haymLwUsXBi7fiBT+Vf55XvBfyyy?=
 =?us-ascii?Q?p1eYCxVbkJRXqVGTYDBmIeKLz1a8meRtTgvGcBhsttI2JAoUMxtsuJcbRQ9e?=
 =?us-ascii?Q?a0pkus1gtz4aatdN/ESpNJrqUqjAJ7CkxLVg1fXYsbLv/XWSpVtLdsNTG9P8?=
 =?us-ascii?Q?Q0h34qK5BBCN5IGoxjnAT0ZUI70ibAt6NeqfxOg8wpa44kvon96KBvgeS696?=
 =?us-ascii?Q?Qv8H4qA9OvJarnRsOsLGwJXHe20AixZEeUyoSzhI407x5sIu8BoNTVD+RvtB?=
 =?us-ascii?Q?gLBGX4R+FrYOdIUVRO5qztKBf01YaBEdoHGHTm3MeoCHwKbMoGq3kOGc3iKk?=
 =?us-ascii?Q?FthWMMNn6OtfCMs+BZu9PzPwwnFa+JGeBBsvlGLL59cKaz7YOvZvX+DRmGLY?=
 =?us-ascii?Q?YfSHdxmE0FfOoxeyJsace+IDRRCze1g6OdgBvoIA5zNpKiRSjbUhsXMld2dZ?=
 =?us-ascii?Q?pUmtlZbxs4J+6CH1znSyUg5p4IAWwbGztGdAYpyPWI/AzYdFEqavo0YWo8OF?=
 =?us-ascii?Q?e4BP+CTVW6MhkYga0f2lyZiGjwRC0Ixf2o4J8HBD63j2z8DfOkdYfNZCbfaw?=
 =?us-ascii?Q?txGCfoQeI4BZCjL7c6dAYbMIUfoXIDbmN7Rid08IHRsT5xPsnb+XLr0ga9CU?=
 =?us-ascii?Q?7IV3Fjl+LmtmVTQZoocPKr/ZBCHnzQVAQgxfO5vwIfbUX9PqX+79nFUZ13+Z?=
 =?us-ascii?Q?Nw0VF6OXI0jaq6NqrrSU3cd3kb5/L8s0hhF5RgXoCT7cUc0vAqZopUisDC76?=
 =?us-ascii?Q?PHFvfDWO96CdFqsUlm3XXYIIfWzKpmWTEqcsmG4qru0FFUqtr5NfaO38m9Eo?=
 =?us-ascii?Q?43NpVG6ra6G/W2nBVwIQMmJ/84HN86m1VOEnwQVp7DN6H8c9GvqQaOdUFmT8?=
 =?us-ascii?Q?X3F/GgbMoPwOR0SuhE670YxrqbV6n4lDNsi1kMP12SXbpTisy0BfWyRWMC4k?=
 =?us-ascii?Q?zK9Ns7Z/pO9NjtRnM0FLOKPSXf1HvlNFgUTnVUKoaeA+3+k3358Uesk/YCO3?=
 =?us-ascii?Q?dZ70d9rQ80HObQe0/8h4p8AQW459vXyiELatfoN6p0D1VmxVeSdABqSQ6jEf?=
 =?us-ascii?Q?JcKO2SAZ8SNshYU2Wnvscza55z2hQeJUme4aPn+A6mdvoY73mptZO9+lM9Zw?=
 =?us-ascii?Q?HrwW/wcvnDy+6xse92wbofbwUwMlfjQ9djNh0oPWeB+xT0Ywz1OGx7SrUz77?=
 =?us-ascii?Q?RJUSJiTXxix08cBA/98g9LInJlyMSRsNpB4muJLlvcEbG0lSZsnOc1aUWgoA?=
 =?us-ascii?Q?yu7u7UhJg5zlle8rPiO0bM5w1Z8LlERa38HpdMXrsQmnIzMwploRDI4t0JHW?=
 =?us-ascii?Q?OwNZ04GUTyRsYirQk6QwexQtDEAYMqKogE4cNmhK0OmiKMoubxn8zW2W/LEk?=
 =?us-ascii?Q?lvQQaf2GINnnoMuJQ9L+Zoh2Hp3hv3gwgv3iL9PwYmoYmJNqylo1z2Ru9Nzz?=
 =?us-ascii?Q?MdcTEzr8s6C4Wi2iwXzxI5rf4CeWO+8A9DAqW+f9ngK0SzBZjVUUnHvP9XMJ?=
 =?us-ascii?Q?IYskeLgT3ew2DtT9qk4kjSdM+M0+I24p+V6y1Y/McRiTIpaLTrnNBdsW/nbO?=
 =?us-ascii?Q?60oPeCzZR1TiSnXW0YueQZ1Can+2DDy+Sowt6QPU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa604ae-56f9-4cd1-f050-08dde06311a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:30:25.8889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KopRb8Hwdw+qls3+7AmklqbBYSeDJjTOFZaaTK7yZ0F2/joJZNUZ1gBKGbMdi4xOIt/S+ZCILtoAHgXbyQ1pFUia9YabmAED9yR0gmzu0wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5165
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
> From: Ng, Boon Khai <boon.khai.ng@altera.com>
> Sent: Thursday, August 14, 2025 11:18 AM
> To: U-boot Openlist <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Simon Glass <sjg@chromium.org>;
> Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Ng, Boon Khai <boon.khai.ng@altera.com>; Kathpalia, Tanmay
> <tanmay.kathpalia@altera.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Jerome Forissier
> <jerome.forissier@linaro.org>; Rao, Mahesh <mahesh.rao@altera.com>
> Subject: [PATCH v2 3/3] configs: agilex5: Enable config SPL_SYS_DCACHE_OF=
F
>=20
> Add SPL_SYS_DCACHE_OFF to Agilex5 defconfig to disable data cache for SPL
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 33a6221979a..8c31dcfea11 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -45,6 +45,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0xbfa00000
>  CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
>  CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_SYS_DCACHE_OFF=3Dy
>  CONFIG_SPL_MTD=3Dy
>  CONFIG_SPL_SPI_FLASH_MTD=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

