Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6472CD128A
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 23:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E40E87F50;
	Mon,  8 Apr 2024 01:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="B1ocrBL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1BA87F84; Mon,  8 Apr 2024 01:52:34 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4187E87F6A
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 01:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI8NBNy/DCqO+uByczKKG3uXqjATrnDaOmm9XPSPF42xEX5rvF1bQVxoqEw8eRkuiT96oiWoZvpZLOc1BGDlVTHb53zBjbPSyBihht5bijLbtt4MByILI+n4GJ8WAnjJ6bZfkEZ1h0Av6BhDam6UXIn/b5Zdfp3Yk4qIkLpaH6CTMnhikvcxJVcpi2Tx9P9mE1NymcdUyo4M+goWAI25+fX+6P1g68Wow4EtPVDwpcjgiLL6tzPnW6nCSFzy3TQ89F36gebc9YsHmXbuLX29+gzKOH+t7P/Im5Ir2Dc0xGq7//oESaFdmu9OTdTTQ8uDlFPjR0CnK1takbIEC6SQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExwqKL59eoZ+K0LJUesa9QiDR9wAvGmw7htioZL5GPQ=;
 b=QEaugnYPdRYD2Eu294YjrFrJvp48sgBZ/8WEFaOfdpJ/66XJRGNa6HINYK69I7Y1B+l8EGgxQepsSQ8NnV+NCxh0YbZZKzyEP8I0jFWkOom4COsWB5vIwBysOc4i7gWQx35JheTUEyELT6irzlQM8gYF42NnXCU+uzJP9J84U8KZ+RJSN+RC1XCAl+p8ktQVqFQux+Ks/h6gBSIZRxtKlncHcY13Vg6Yeqk+1fMvmFRAsUYeWkHTkZcMajVPXXOxhaYgOlsSKRjpNvGeExqvFxKbTbZW1LBVaz7xS2HHEdPsTl9I3Zrm3UztfBS/CZgeuMbpdN1UcjrKixiWOU++Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExwqKL59eoZ+K0LJUesa9QiDR9wAvGmw7htioZL5GPQ=;
 b=B1ocrBL9RPRXyHfk0LTe+681OGaqm5UrvzS7wz7XbwYf+w57ipVnQg1h9V2C/AkB/L/GQNWOC1tffp1SC48y05gYYN+5Ja1xjIFKF7Bk9ni4SgB8MtzaOhCp6sDzWhQaFcls9fNdC7V52dutW5V4C90SYTMDCcz/leowXBhth9w=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 23:52:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 23:52:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dragan Simic <dsimic@manjaro.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHagMVDT80nSMU610ixQHv1ZnD59bFdGVIAgAByR0A=
Date: Sun, 7 Apr 2024 23:52:30 +0000
Message-ID: <DU0PR04MB941724018999C2894B917C5888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <edaddffda19931bf872db692fdbd5b24@manjaro.org>
In-Reply-To: <edaddffda19931bf872db692fdbd5b24@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9693:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuSyp6dG8hUhleVdEW065QDLDcOwuSKsj1SGY1GYci1xAvBApjrcrlS3JgBcE4CC3Wbh5DTl5NY5SKQEuSXaiUbRtd/DaL8Id4theEMMQjbZbXfeZARrC7OKY/Hhc6d1e1DIjb6u97rDqjiBCFZPouX/cJgB/GJkLURDri7kJSBcKMEZEtUmNsYlwl344UpQfY8o8h2geVJi/s5EE/fcC69ZeaN0WUq5dBwDleiTT2TecNgK+dH9z10scbofLBJrGX7lWIu6sSsdS5wz4EHszEkg9RErRb+hLcbsNjQLB+xUINLFcGZ8fvXSBGT9HQbeht7k3BSdbSqKsdIoE8TXC729VVoAd+BS1H+K2RsCT+GZGXIAluToyHaUaOPDZqk/dM5CEMt80NJUBodw9H0e0mdJPsZj5cGw80JX7pa00ofRt3hBTT7iZRZTaqjWwDcmjcufE55VtR97r6rI3+7Vc1smc+IoUrKX2GiftGIOSiF7M7nAQ+NmSU4A8l9gGXgEQmSW7WRcXQIaRMKFae9WE9Gy6QAlrGpafcdc1ODxpY239QXrpC1iz5GzuSLQxjYNKaqtoHunSx6u0NTxRrwJDWn71Fa6feJgfx7LPkz6VfDCDkYDiyyG710Qc3i2uoDGukMiODWQWmxt+hkJdRGhi7UKPDxTaoMaWk2wPRouMu4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vYeibOITAoNp+/1Be7/962EhrL8clsCzmbxbFrjDV6M9EFUOyN4SLso1lk?=
 =?iso-8859-1?Q?U67pKtAzeYb/mQlPTLJMKDG/gdMvXyTBAnA0S1NxqgSXl4IhPcmOsI08bs?=
 =?iso-8859-1?Q?W5vyJv5b3yTmh/EDI1GkbgTAxrKgy8a9TML7q8+Z4qy97WZiCTAAZGbr8Y?=
 =?iso-8859-1?Q?Td9JboQiVbEXItND1FFOYij1LCQfliW+mX4yUKLwxlsYjD+qI+Mf1c6D5v?=
 =?iso-8859-1?Q?THtmPw6buDrSN11qwT4xvoq+102IxJQwO55N2ckfdQDg889UrRNiyN00WO?=
 =?iso-8859-1?Q?ItZrhoS47GMAaxBePvrT5R7nNZAlgQktN+Jeybz0djqesP2l8BNiHLkmX8?=
 =?iso-8859-1?Q?s/lO3eqeCngChM3spF/JFVo7tlKoZFWG1nPRmFDbpELSt+5vjvczh3OYGN?=
 =?iso-8859-1?Q?dIHSnQC8EYQjl4/U3ufpzV2yDPy4XQ/9vz6wl84fzAAWfZWRvoKwbx57Nz?=
 =?iso-8859-1?Q?52IXDPkcTtCjduOpeLFs+nuHIUk7zsjdyIA/lPn/807j57Xx3ck28/emLT?=
 =?iso-8859-1?Q?JeElx7WIhqaaJcbjUacu/A8YIqM+adAF2lJCNIv/E5kUWP5ADI2XfbrnS3?=
 =?iso-8859-1?Q?W1+xVOOsSyb3vfZWRf/o+H5OLoUOh+4ti200MqyVaiIqpKvvmNXg+2++4P?=
 =?iso-8859-1?Q?bD52L+4QSVbhTEyBr3/lu/qhiGHj3Ng+KflV1BJqxX8NRbb4i3HiVCdRLc?=
 =?iso-8859-1?Q?O+upqozqG0bXemXTo6x7O6Q0X+YbIt3wO+FWatzm9+j1IWUS+8K6Zq/g+D?=
 =?iso-8859-1?Q?Pvs7+uuWDJrVxpm7zQMkWlKYo4C5AGHsHoeBGEubAeRzl1GTcLPM0dpwK2?=
 =?iso-8859-1?Q?3m4YezNCnN7uXw9+z+6PddgvLlubUA4q+b8mOTPFxigpYEv1AVejHw9llP?=
 =?iso-8859-1?Q?m5r3mwtj9EZ+CfAwc+5wO5hqZse6IbkLY62Xxay1OyrYt7s+yKGGHLJ0oH?=
 =?iso-8859-1?Q?63W9avleOXFSAgD9wbsrtyDjJ5qKR/SRH+Z6Hw1YL9/8EDYOVJlesd372s?=
 =?iso-8859-1?Q?5ODYTiAD6+lBo5SsxLvwdM5No4+lgH1rSJexjmeBoj7VKBPREogbJUKZFg?=
 =?iso-8859-1?Q?vuzhuBxDwHnIIfAv0JTSW7BaFT9PB79sPR8NIyZ6Df8EeCOG3BBd7Uv7n9?=
 =?iso-8859-1?Q?rzEXxOpEqlhhITrkJzmmX44Qow2pjT9CXgOhootwXOPLVu5471S/XkcHnL?=
 =?iso-8859-1?Q?lIKtVFlGnilB1ULz6qMCk84IwQVyzug9sMZ7VOw2nC8KdBXA2c9PW5cbaX?=
 =?iso-8859-1?Q?DoRmWMwXUwWmntfhTWZ4wVekR0pjyZf6H1tVQvsloKInlfgk5AtmZkC7+Y?=
 =?iso-8859-1?Q?fQmdfYV1LfCrCA/WnrMMxs36yq5AVbRFxSpkYb0KcJHUeZU2yaBQMlfgso?=
 =?iso-8859-1?Q?zNzCeYSb2koeF9bMrV44LA4XfV3aUa9N4as98uTSyzv0hkerQHWphcKX7v?=
 =?iso-8859-1?Q?5vsTBCd/3fL/sAShEi6HH45EtRhIfLPJT39HfiFF12YaVkvgfsiQz9RLGg?=
 =?iso-8859-1?Q?pvWrW/7+D7fMYPoN/wlz+insct5P3BxVlxwtvc6oe4Bh+jIWZO4wAuEK7P?=
 =?iso-8859-1?Q?rRVzHfKEMiaKRTZQ+3s34sFZIUhve5Zdv31nRfPTbSxoM7wkSf+NcnD/Ar?=
 =?iso-8859-1?Q?jx1QcT5Q4KlDQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48845f32-eedb-4b72-0f5f-08dc575dc9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 23:52:30.7817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13ma/CLTLiYRr9K+EAjDa8I96CPtwDdxzOpvH+j9HiHF18/TaQkOIzIMX7aZjx+4ZBSeJlO1brhex34n0ZDFqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693
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

> Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
>=20
> Hello Peng,
>=20
> Some minor nitpicks...  s/Conver to/Convert to/ in the patch subject, and=
 a
> couple more below.
>=20
>=20
> On 2024-03-28 06:05, Peng Fan (OSS) wrote:
> > A few nodes were added to soc and board u-boot.dtsi(lpi2c, usbotg),
> > those nodes
>=20
> s/soc/SoC/
>=20
> > could be dropped after upstream linux supports them.
>=20
> s/linux/Linux/

Will fix all the typos in V5.

Thanks,
Peng.

>=20
> > To support OF_UPSTREAM, a few driver changes are included.
> > For TMU, still use U-Boot node, I will prepare a kernel update, then
> > back to U-Boot support.
> >
> >  Mathieu: please help test the boards you maintain when you have time.
> >
> > Thanks,
> > Peng.
> >
> > To: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>
> > To: Stefano Babic <sbabic@denx.de>
> > To: Fabio Estevam <festevam@gmail.com>
> > To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > To: Mathieu Othacehe <m.othacehe@gmail.com>
> > Cc: u-boot@lists.denx.de
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Changes in v4:
> >  - Convert all i.MX93 boards
> >  - Link to v3:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240328-imx93-of-v3-0-
> 4e7f341ed7ea%40nxp.com&data=3D0
> >
> 5%7C02%7Cpeng.fan%40nxp.com%7Cfb4cf5cd6eb048f7004508dc5724921f
> %7C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638481061784727166%7CU
> nknown%7CT
> >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI
> >
> 6Mn0%3D%7C0%7C%7C%7C&sdata=3Dm3eUSDFipFRBJlujTzNovsgusVTRp8lekD
> guNKKGlq8
> > %3D&reserved=3D0
> >
> > Changes in v3:
> >  - Update patch 5, to drop the imx8mp-evk changes which are wrongly
> >    included
> >  - Link to v2:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240328-imx93-of-v2-0-
> 909f5d37da87%40nxp.com&data=3D0
> >
> 5%7C02%7Cpeng.fan%40nxp.com%7Cfb4cf5cd6eb048f7004508dc5724921f
> %7C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638481061784740481%7CU
> nknown%7CT
> >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI
> >
> 6Mn0%3D%7C0%7C%7C%7C&sdata=3DdOltsehRiqbWFgRABoeC1nUqbU5CTz2
> OOt6Yq7u9sj0
> > %3D&reserved=3D0
> >
> > Changes in v2:
> >  - Add a new patch to sync clock header to avoid breaking
> >  - Drop the Makefile change which change including order
> >  - Link to v1:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20240327-imx93-of-v1-0-
> afab6b31422a%40nxp.com&data=3D0
> >
> 5%7C02%7Cpeng.fan%40nxp.com%7Cfb4cf5cd6eb048f7004508dc5724921f
> %7C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638481061784750001%7CU
> nknown%7CT
> >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI
> >
> 6Mn0%3D%7C0%7C%7C%7C&sdata=3Dx4s291DNECLAyKaOdMRse2CLfFwaSx8Z
> %2BCdLZZrYV
> > mY%3D&reserved=3D0
> >
> > ---
> > Peng Fan (5):
> >       gpio: imx_rgpio2p: support one address
> >       serial: lpuart: use ipg clk for i.MX7ULP
> >       cpu: drop imx9_cpu
> >       clk: imx93: fix anatop base
> >       imx93: convert to OF_UPSTREAM
> >
> >  arch/arm/dts/Makefile                           |   5 -
> >  arch/arm/dts/imx93-11x11-evk-u-boot.dtsi        | 119 ++++
> >  arch/arm/dts/imx93-11x11-evk.dts                | 322 ---------
> >  arch/arm/dts/imx93-phyboard-segin.dts           | 117 ---
> >  arch/arm/dts/imx93-phycore-som.dtsi             | 126 ----
> >  arch/arm/dts/imx93-pinfunc.h                    | 623 ----------------
> >  arch/arm/dts/imx93-u-boot.dtsi                  |  80 +++
> >  arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi |  22 +
> >  arch/arm/dts/imx93-var-som-symphony.dts         | 323 ---------
> >  arch/arm/dts/imx93-var-som.dtsi                 | 111 ---
> >  arch/arm/dts/imx93.dtsi                         | 906
> > ------------------------
> >  arch/arm/mach-imx/imx9/Kconfig                  |   1 +
> >  configs/imx93-phyboard-segin_defconfig          |   2 +-
> >  configs/imx93_11x11_evk_defconfig               |   2 +-
> >  configs/imx93_11x11_evk_ld_defconfig            |   2 +-
> >  configs/imx93_var_som_defconfig                 |   2 +-
> >  drivers/clk/imx/clk-imx93.c                     |   2 +-
> >  drivers/cpu/imx9_cpu.c                          | 224 ------
> >  drivers/gpio/imx_rgpio2p.c                      |  42 +-
> >  drivers/serial/serial_lpuart.c                  |   9 +-
> >  include/dt-bindings/clock/imx93-clock.h         | 208 ------
> >  include/dt-bindings/power/fsl,imx93-power.h     |  15 -
> >  22 files changed, 273 insertions(+), 2990 deletions(-)
> > ---
> > base-commit: 280f34ba7d68bb50c0b8eaa040322c1f3b37d46e
> > change-id: 20240328-imx93-of-v2-f879efef737d
> >
> > Best regards,
