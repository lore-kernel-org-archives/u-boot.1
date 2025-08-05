Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480A1C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB498340C;
	Tue,  5 Aug 2025 09:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tVRJN2Zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D96383420; Tue,  5 Aug 2025 09:34:32 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C48832DA
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzpfYjPdb6ae5VFo8FHOUuSlWk7Z+CzItVz68Xie22j886NUH/2VFuRlr49wtYfQlsl7qDEYXoOfmfiQVOm6sHF5+tsAC3UZa+dovDnr0f270u5UnjgxLxfN89EhUMKuHcNCnuoV9pHDzt/c4thouVdNIV565RZIU9MM3nvRN3zOvOSQMQOcdx7Tj17+ExZSE7JsJqJ479JCWnKdJ9Qf0mdRGn+yjfWdrya/2UdyrDBpUs6jWrODzUrvf7a3L04moBb6RzDXQwX2WZNxGKQ/R0A3L6mZ6PulZ8z8ZbUNmq+elB9g4pRSaekxLMti8rjMB+u8i4jajXSJSK0mgH/0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czjasAeD4rKe/F40qa+ez7jbCJbV/bAvJUcJtndx3O8=;
 b=L7wnmdgfHEiaIS94JJa5ne8ub6TtrZsQMVGvPeWdZkIpUe9+Hh9pdPcCEkVfC77Adlsv17HlNhecWt6vS2Ruo1vyrRkVFX/clL689v4nXOzwVOetl7AmNuewpFokYlp1FVhIL+Tbph/MPruKjapqIek0bPq9GKuh5NR/fzaPZckogS4k5w83pAXaCCScLZsYdxCOuZztYVDZVv9uVeRUK9mG0klBud0WQpa4yy19Yn3vhirpLkF+wl0oc3lBrTM6LtF2rKe0S5zjeBiuFBxH9jUwi8X6qnJ89pEvEfF+zvavLixLVZTaKO35jRohhqGAwOx8aFVs0iAeArjDsvOUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czjasAeD4rKe/F40qa+ez7jbCJbV/bAvJUcJtndx3O8=;
 b=tVRJN2ZbjTUsSHyNU/A59YOdIT8C86uGAyJsHsekVp1on5MEH9y5xe5olOTrttqXyQcz8Xj7CQbOBn0WHs4mFzdGo53e258eKdSofyOCIDX6lOPU6rtZnraISNfbi/Q7ro/JkCIdFV9H89mnbdhj72ulU4+CHlAJmjq6B4/m6ZVwm42cTnUfuBY1Uxv+oNnAtfFv+yGYzqayMdRqVlMbG6R7Hbj+7WJdh/h/0HKW1zxi3zoyfKxVDBaMu3Vloqr19R+YMEOZIfkK/FPLt27qJsP9lxXw5+HCYF4ou6TbGwKxnSVU+5yLF0y9p/qC4C9o9zQvHPn/LOv7yZwtoPXidg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB7020.namprd03.prod.outlook.com (2603:10b6:510:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 07:34:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 07:34:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, Peng Fan
 <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Topic: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Index: AQHcBNld5DNAfhKpBU6aFVejvpteDrRTc1EAgAAgNoCAABgzsA==
Date: Tue, 5 Aug 2025 07:34:26 +0000
Message-ID: <LV8PR03MB8137179BAE53AD6A8DEDE13AA722A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
 <20250805040750.GF29103@nxa18884-linux.ap.freescale.net>
 <PH7PR03MB7063F3EAF4F0BEC770E333D3AD22A@PH7PR03MB7063.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB7063F3EAF4F0BEC770E333D3AD22A@PH7PR03MB7063.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH0PR03MB7020:EE_
x-ms-office365-filtering-correlation-id: ed32757b-8d3c-49e0-d95d-08ddd3f2814f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0FL3d3WjI1YjAiMkFStEmevlV2SVFYJq3G9sa1R28sgOqHJaiUdswSjwVDRF?=
 =?us-ascii?Q?uPO9L5UXNev/V4fLnHnrWwz5h6Mhg6Gyue7IP0UgwCCMKhNGw/l0LwiK+ppX?=
 =?us-ascii?Q?gl8UwSUfFxL4Zl0faO2Iw/z7HmQZ1ErBaf8QvzR6vWoStCtZ7QFMLWAPqrL6?=
 =?us-ascii?Q?kX6xDaPA438d3W7GdpZ4cMj7pX+4xJJUvy/Lt2O0GD14S0oVp4uqbfMWvQ8T?=
 =?us-ascii?Q?gmuTSr+fOzoRixV4zZFMIHybUzYIHGALoTbC0PM1SEz/4vaplWiH7kLb07vx?=
 =?us-ascii?Q?7Y7CHsb8SAMAw7KuTEz6KlygycKeGW0obB3vRJqOzgwCasBk/ad1dmz1dxVU?=
 =?us-ascii?Q?Jyadhz1jlEgxrULEaQ+MW1rPih/s1DFI2hZmPV80KhjC6l09XqHT4wp4fu7m?=
 =?us-ascii?Q?fa8341f1W7IMix4jP+Pd/ziCqXP1v+/NZun/oagy1Aw3f8RYtSMpOEDmZ26B?=
 =?us-ascii?Q?yapZf1cJ2SUvJt/Qey43HAS0hJA5jtAJv90UMAifh+jmgiBTIdkIb11CUZ7U?=
 =?us-ascii?Q?PTi03uJuT0lauNm/qoSC2Uk4qlrI0aJKuy9Pi1fgZa910+2khivFHn0Qb189?=
 =?us-ascii?Q?vXLq1MzUf4cOL1HEszR/IsU5lCVLac6aTlKt0zNRMNGGufSt9sNqG93g1AG8?=
 =?us-ascii?Q?yXOv6KNakedYcQk7mbbkdTFxjEHlleHKZXBJMMdeDP+g7yIXF33PZlAAvHGv?=
 =?us-ascii?Q?7dMUEAiKxgSdExsDM0XSeUm1QoKHntVoQ64BeRpflLvhGrIEJzKnXLMEgT2B?=
 =?us-ascii?Q?cl/R0hKZTpyxugTF0NWk3LdFqI7+pXwMGgswPnvb+HaC+ihm9At972g1sUQS?=
 =?us-ascii?Q?CPE9R4Obwi0WpwmBkReqL5H05XerveY5+KaUDxhrg7Il+9QMgOsuuXBLIuu2?=
 =?us-ascii?Q?i+tpgbPXaRk8MyRlXHrhq9o+I+QGaRPaBKnKA1OuUs5Qy9GpJTR2K3wC5Y6v?=
 =?us-ascii?Q?mWsoB/MolCAeuPMlDBDUP6Ro2LiT+ROZ3miklQRkbKSCPR70zUYmVL1EQ89L?=
 =?us-ascii?Q?FKWHYPxjTqVPoZF4b9FzS99+HyGXJUl3YFY2jq0QE2Q7biUyXBIRJdgpDhOg?=
 =?us-ascii?Q?8Yutu35ChZAeFXied8PSQUQVYgK/I+eG7BA37KYp0BqhcDlr6UaPXdo08TrB?=
 =?us-ascii?Q?DWSwwfneh8WnMZxHBJE9FdWB9/k9MOFpaq6KjtFWmcNfZb2sOG9TcJCiuV4P?=
 =?us-ascii?Q?SHkzxnCy5YqkvrFekNO1utzwx/p1ndid124uXDbmcnbgDNilLRJWkk9dAfte?=
 =?us-ascii?Q?9CqngR+Q3lDrCRv+cOtmuRI2DQWNmk2Dnb4VeXfITg8i8cpUvf/PHAd4uZmZ?=
 =?us-ascii?Q?vxzBX+SBHjQqUDahHyEhsr70SWlL4SlfTqcua25pushgYh7lSa23NlLzgAgt?=
 =?us-ascii?Q?ObNw7MIGvPSyOb8lcHRLYd8amqAWGUpbdheyuU1UMW4ucJWGkVLY9FIs1EhY?=
 =?us-ascii?Q?bNt5mGXR96b2q8zIVjPu68Jt1T8vPagDK0+TIVCUR6Ctv8v94ILWaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUQ00EQC7RgS2I1dRzIeUln/GL8cgBcm8tJNPcv7pBSDctQnLhAeJkAkVF0O?=
 =?us-ascii?Q?twORTw+ZSzCpLTb5TwG+1R+JPoMVBUhGK0W5N/G3mUM9i4DG4xiERPVc0P9S?=
 =?us-ascii?Q?5lINXO2VfkPZfPQxlwSuqYuDI8jHAvEPVoyFft6a07jRzcdoQNMKE5iHpiaP?=
 =?us-ascii?Q?E38/NvkNfW+IehsdgculUSp7PrKpCRh0nxff5SVGAWcJdamkEIe4375LHGBM?=
 =?us-ascii?Q?/eDfwe3vhZra+y3tiib2zFqJknF0jVmRA2sZtlgKkIQNlV4qz5pnAWzeVcW0?=
 =?us-ascii?Q?kw/VdMiwuaL/MGizqEeohBmBvhHnddjd0EyVX6y6vHzuUcRQhSeh1b/0wvuH?=
 =?us-ascii?Q?qekRn2bEM6lduVl9pFSYGXNjPB+Sw+92YHE20liUOgUTSYMAE73jGYY2hAFM?=
 =?us-ascii?Q?nt8SlOLKw1RBq0/qO3LlkjXc4nvEepGzrsqdwAuTCVP115t8TFgbtDq0Yk2F?=
 =?us-ascii?Q?pyqsRbX2m9lVKENWQu01OoxUwkf4ryxI3GPn3Y2RaGPpbag/yW5aFJ6rYthX?=
 =?us-ascii?Q?rMl2Vz4Ab30Xk+0yicwgi5YVW+ugpkK6N4alPNNxHIzASGkM+TS4my99H18S?=
 =?us-ascii?Q?UBJUC6GXmZBMz487TWY7P0ha0y8zK61ruO2zkVwk/AHFJRWWThuQjEuTG8Gl?=
 =?us-ascii?Q?WX3Xe4rWz/MmTy39coYenqkOtz6gAPedT+V7Ztr3NIAAa90cLwOTA/LnGs+A?=
 =?us-ascii?Q?m+ia+fYJnk0XGPCkIxOe852eNpZwm34S+4/AP3P9pqu/RyNtjkaATqw/8kqG?=
 =?us-ascii?Q?izF8DJN95uJd1AV3QgPvh/CLjEWC0L3iWqHnsYEcM+QhKn5aA+t/Rptkz23X?=
 =?us-ascii?Q?g8a3Rm+yVkrczqPW7WTfZfwkyusAXgpBgwkodcrISLSWXRZrzAElekP/pO4N?=
 =?us-ascii?Q?ldl85yCgICYanYrrhhNLoMx9w4UyMlYHB3rD1o89QKINv1SRszEO4p9sGNaJ?=
 =?us-ascii?Q?IoYTGCOLGNfEp+LRXJrPhToH3EtEwopMfm2ZfpasWCpLKr0Y8NWXkcCKmZa5?=
 =?us-ascii?Q?RpyMJTAj3Ova2MugqnKUs/ulCZ4F8Yz1/t0R6RTbSRgSlhrbage5q7UH2Yes?=
 =?us-ascii?Q?59MxUzbhNaNyKMhkEdBc8uIvBYLAuWGq/Snc3Zf2CvXDLk3kCazDTQ6HcJfa?=
 =?us-ascii?Q?K2b88QT1ki7ae6Sj82PRsxJ/xHvUbNtUKeeUISKJWDqTucKcxW3ShpewXpKt?=
 =?us-ascii?Q?7FIccPU97+93anMoPr13gNUi3rL2n4udEnd9tCwWUK6OGOfNRoDQMACPG2c+?=
 =?us-ascii?Q?oeodD14D2467D4vVtf8Vac6D8TMBfMr+ntdHa+vER7VHkJenslu0rhH8sumQ?=
 =?us-ascii?Q?sVQadKipV15NC2Qk/dfqpaRltDI9/TJG9DS/4GANvpJTXW/vUu1/P1PU0Ku9?=
 =?us-ascii?Q?UFkm3ZvhwBd2+65oFUbOuvztf6ENYHEQw8GCMPIvP8LJlgdID/7lQcHVGACB?=
 =?us-ascii?Q?aSOopT5dbXm/8saFePjIL2eIPlz/dtbcD2U+rSB1Yw3HNtERWm2kZCdcytOj?=
 =?us-ascii?Q?WbGFMtp+Mpx6RpzAcjB1wa8GzxNHr8QTkwrDbAiv7sc6WLyXzhbFvIrSPPIS?=
 =?us-ascii?Q?Of7kJbUEiEyVaNmI3Tc7OKrjpFZup5rVJ8Fj7kXY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed32757b-8d3c-49e0-d95d-08ddd3f2814f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 07:34:26.1234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuIxKX/aADEdL0J1dS+1OdVb9Vpu8myPWyiMQot7ZCoQwkOHlySrPuSQyizE2B88886PXqM3VIc2vUG+5QeYhIPd1Au5rxI1JU/Wx+mwiHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7020
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

Hi Alif,

> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, August 5, 2025 2:03 PM
> To: Peng Fan <peng.fan@oss.nxp.com>
> Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Chee, Tien
> Fong <tien.fong.chee@altera.com>; Marek Vasut <marex@denx.de>; Simon
> Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> address via clocks phandle
>=20
> > -----Original Message-----
> > From: Peng Fan <peng.fan@oss.nxp.com>
> > Sent: Tuesday, August 5, 2025 12:08 PM
> > To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> > Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Chee, Tien
> > Fong <tien.fong.chee@altera.com>; Marek Vasut <marex@denx.de>;
> Simon
> > Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > Subject: Re: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> > address via clocks phandle
> >
> > [CAUTION: This email is from outside your organization. Unless you
> > trust the sender, do not click on links or open attachments as it may
> > be a fraudulent email attempting to steal your information and/or
> > compromise your computer.]
> >
> > On Sun, Aug 03, 2025 at 05:47:10PM -0700,
> > alif.zakuan.yuslaimi@altera.com
> > wrote:
> > >From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > >
> > >Improve the current clock manager base address retrieval by probing
> > >the clocks phandle under the mmc node in the device tree instead of
> > >probing the clock manager node name in the device tree.
> > >
> > >This will help to make the driver more scalable for more families as
> > >we no longer need to rely on the exact node name in the device tree
> > >to probe the clock manager driver for its base address.
> > >
> > >Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > >---
> > > drivers/mmc/socfpga_dw_mmc.c | 19 +++++++++++++++----
> > > 1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > >diff --git a/drivers/mmc/socfpga_dw_mmc.c
> > >b/drivers/mmc/socfpga_dw_mmc.c index 3b86bc9b18c..ff1dd0055f8
> 100644
> > >--- a/drivers/mmc/socfpga_dw_mmc.c
> > >+++ b/drivers/mmc/socfpga_dw_mmc.c
> > >@@ -54,17 +54,28 @@ static int socfpga_dwmci_clksel(struct dwmci_host
> > *host)
> > >       u32 sdmmc_mask =3D ((priv->smplsel & 0x7) <<
> > SYSMGR_SDMMC_SMPLSEL_SHIFT) |
> > >                        ((priv->drvsel & 0x7) <<
> > >SYSMGR_SDMMC_DRVSEL_SHIFT);
> > >
> > >-      /* Get clock manager base address */
> > >+      struct udevice *mmc_dev =3D host->mmc->dev;
> > >+      struct ofnode_phandle_args clkmgr_args;
> > >       struct udevice *clkmgr_dev;
> > >-      int ret =3D uclass_get_device_by_name(UCLASS_CLK, "clock-
> > controller@ffd10000", &clkmgr_dev);
> > >+      fdt_addr_t clkmgr_base;
> > >+      int ret;
> > >
> > >+      /*
> > >+       * Get the clkmgr device from the first phandle in the "clocks"
> property.
> > >+       */
> > >+      ret =3D dev_read_phandle_with_args(mmc_dev, "clocks",
> > >+ "#clock-cells", 0, 0, &clkmgr_args);
> > >       if (ret) {
> > >-              printf("Failed to get clkmgr device: %d\n", ret);
> > >+              printf("Failed to parse clocks property: %d\n", ret);
> > >               return ret;
> > >       }
> > >
> > >-      fdt_addr_t clkmgr_base =3D dev_read_addr(clkmgr_dev);
> > >+      ret =3D uclass_get_device_by_ofnode(UCLASS_CLK,
> > >+ clkmgr_args.node,
> > &clkmgr_dev);
> > >+      if (ret) {
> > >+              printf("Failed to get clkmgr device: %d\n", ret);
> > >+              return ret;
> > >+      }
> > >
> > >+      clkmgr_base =3D dev_read_addr(clkmgr_dev);
> >
> > I see this driver use clk api, so why still directly map the clk
> > manager base and configure it. Shouldn't clk api be used or assigned-cl=
ock-
> parents be used?
> >
> > Thanks,
> > Peng
>=20
> Hi Peng,
>=20
> The direct access to the clock manager base and offset in this driver was
> inherited from the legacy implementation before we had full driver model
> clock support. Currently, both Agilex and Agilex5 have their own clock dr=
ivers
> under the driver model, but the `clk_enable()` and `clk_disable()` operat=
ions
> are still not implemented.
>=20
> Because of that, we retained the base + offset logic for disabling a part=
icular
> clock in the SDMMC driver to preserve existing functionality. Once proper
> enable/disable API support is added to the clock drivers, we can clean th=
is up
> to fully rely on the clock API or use `assigned-clock-parents` in device =
tree
> where applicable.
>=20

I think SSBL has no privilege to direct access clk mgr register, so ATF-med=
iated access is required. I agreed with Peng, these issues can be solved in=
 clk disable / enable API by having the right API access at both SPL and SS=
BL boot phases.

Thanks.
TF

[...]

