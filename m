Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC2C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 12:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7559787F41;
	Sun, 14 Apr 2024 14:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C8+v1LUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A349387E83; Sun, 14 Apr 2024 14:47:45 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DA688052
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 14:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXn7RT18SQmuLgU2Ypc03VVgKf4LnmrOqRIB+QRWacDweXNYI5RUFuA14BwENWstnPsdM3L/09HCmxn3ZNUdqLFd9wKy/ffxUI7XmRjs3x6nv8LkUiqgBgB/paXTCRpJVf0xGWhjGEVd0vKKQBCziT1E34SAykYLS1+4r8qpr8nKxPAwAUJWA1RgxE+pj8Ve/3XXA7o51uSh6JzMvgA5tCnGMzoVmaD4Th6x7/SXwFMwpJDjH+665asc7aCbdBtFKYizvYxlZ84dDAysXdeFOLJDrdlNxBScTb7GzTlNkKgWHP0DRonQ4RYwYmoXXTwN1h2RXBjG907g4iLJtdeYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOYQ0Qz86oCKK/a42Iypv0tINOAzPMJs9Ki/x9RRQp4=;
 b=AcLPoUqBprtmN1G8HCsZbm7LMEhTrVDJ1/ZDhqfsKIjlEEV5b1+O1yvF64alX4+DkrxSIYZFhcjcvM0/mqV/wfCeqoCZh9FSpnzGxOXTLT3h2HseSgNQ/xUE76iq0Z19fNASesfmVBx3wru2XrKshO1f5Mn/kZxHGRjvhXckAdtgID3AX4IbtmIbA48K8S10S54rdfEDT2i/S3n+KwXEL7OJGNA7MGMc70RJq/5SPWzswm2Q56IC7GCSZ0Tc63XFTf7p0QBatY7Vg8S/CKWRrjVdeDnCPw6EsqkKWh4gQJLwmvBmKlO6WtkapLin4e8ZG5jyzKYdEoeFdIctlu03pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOYQ0Qz86oCKK/a42Iypv0tINOAzPMJs9Ki/x9RRQp4=;
 b=C8+v1LUce7h5LEbCQWPrZK2c1aqEhBhPDbgauCj4WO+0T2d9dJFfUB9tEEH/ZvIqyKr9laYCz4dhWEVkznX1srSObwW+mAYl0ysfheRCxwFWJvQI1DezjoYr5/qiPp0Tru8eMN7hp5rPPouN+GtdPyJSF+WichumGGNAMtW0J1Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Sun, 14 Apr
 2024 12:47:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Sun, 14 Apr 2024
 12:47:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Mathieu Othacehe <othacehe@gnu.org>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
Thread-Topic: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
Thread-Index: AQHajNzRcMdbYHBsqkK26bTMDaGq17FnkYa2gAAnnXA=
Date: Sun, 14 Apr 2024 12:47:41 +0000
Message-ID: <DU0PR04MB9417A38FD214BC4A20AB82C3880A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <20240412-imx93-of-v2-v6-5-c2ad48e46eca@nxp.com> <87il0k2qia.fsf@gnu.org>
In-Reply-To: <87il0k2qia.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: 468fc9fa-770b-4e04-c5d4-08dc5c8112cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6W9nuSYeDaQ0/ZBNGqIKOe7lsR5IrQkH3Dj11r7lGU0+I+9MDkhByFqj7y+3TCmps0k14wgdKQput3wE9ZRIJyTldncHmZNvWAGi3ALeP2h+77D9/FuXgIQYSS546XnCc2MziJfyxOHhLThst4s5ChWgl3M/xaLpRvL47hNnLxvXq20jwdeRv8Rxh7PshuWgostHShS+dUyTjPsOfcuB7jy4BEmxQzlwjzev3v/eaqPuiucqvPSGZkFDbeR2UcquwOT1/0R8qT3pJfWOyljjLnYgD4Ka6mOlo4rz53CrE06iDTAzS0SSy+/uPGNGTe/rSOZ1RnJ8KVqbf7a7JsPppFNMhPmFcakuWsLalW1aFzYItFWLdXzcD6MAFGTDdMZCjVBeE5oF5CdHryXuk4FJk347ldH4kW/UWpjOFAMCeUkqwu5IlOl9lW8LXz9dQZchv2H8ZQuXdcw0lHBoSvF7A1ixF3kch28pHYpMpPpL55EF3nsI2/8eHNoPFcXa0ea2v1DIxx8Nn73gu/sHaIRmY2I85cqm9zcqNfG8NUz7LGj/NonzY1Wp48Ij6uC6UF+rYb4FnHuQla1wYHDIOnEegq0rLO+2Gv3BXZxDR5O3NGmNRKCBlSjRcHPzAnea0WOBX741ojtk2zuY9kQo4ULnjwAcdLEcNs3vf+8i90cikX7Li1RaP0rpb5gDCHIEvEdfl02mQAZpmNPGhn4PA+mDsel4kkFvrZeXEeY+z26vbVE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ir85gJNugVruLcWeotZknQRPtNv6CPJdA/4lGOFA3xi6r6BPdXL/GPguXQtL?=
 =?us-ascii?Q?tbPbZLFr3YuJCp91MtS/fw2Cu9QSLAVLfX05DYZx+tudf++r4wJAvjcvVHJO?=
 =?us-ascii?Q?SuSnafYEp7vYaOc9WQo7FLMeOquZu3gPmQhGZprgwRzL7FWRtDZe62Uvxd5x?=
 =?us-ascii?Q?EuJ9V0rvjw6KW9DzWet9grGWP5AHQ2Ac10/7JiCEKdO+BCPEEGAFYJQyxSIG?=
 =?us-ascii?Q?paybkBUG55xa2JffJfRbrbT5x278ovyKVw4PQ4kjT8ZX5LXKiV8m9Wgj4LNq?=
 =?us-ascii?Q?LP3AuYDu0vp74A6zDFGDS0W3HyORgHuXef2gu5XfuChra9jX7qqE1CVKbRaK?=
 =?us-ascii?Q?pGSJZrDUUHIURogBCIX6/RaGSpNcMNz3vTNqxdY6haZNoHMJMWWn1zJ3Bex1?=
 =?us-ascii?Q?yq4zhPfk6bPe1goXJ8N+P57YD7fWC/XOFvg86cYKg0MppdR9accU822Wp6/7?=
 =?us-ascii?Q?Zi9Sa/wCKQMQUo5iRJ8aLRPJ5KCOKBFRhF0mQn3LABnqfD0+e0kCyYi+GnJm?=
 =?us-ascii?Q?DMk97myZwaIH0+gMWoKKWU8YqTeIdrmUCOR4vr+UKa0+IKxyVa4Y7/5oI3Id?=
 =?us-ascii?Q?bbispO9m+N761ycExRnF2VEMXmWJEp6nCN6BsDpJlkCR52XDeL1frE8+ircY?=
 =?us-ascii?Q?0lD5an/0aLZeh5TkhQ3no2kPdUNRKDXCYyx6YqPHoR96AdfTJcv2e06Xy5U6?=
 =?us-ascii?Q?AIOpwSz/IlPPnp/0GiGb4qr/QJKWOM3tWVhrHU+wf7hgv0znf5q3R7qV5b4r?=
 =?us-ascii?Q?iFKgor7Nf+HLojpAifpKCRDvPVZ60zvS/iyR0uqEyi6/i6SZRl3oOsKwShcX?=
 =?us-ascii?Q?7S5xgUoUupeLOm8CZTIAJjnc94XBFo1pjBaPUlErRjqfVVY9hovrWMUnl2ko?=
 =?us-ascii?Q?4k8leVcCmYtlnw2bCz0FFiqQ/aWte9abVKFWh2RG8dawhAPM/l33SBM/m8Pi?=
 =?us-ascii?Q?mR+eFrU7g7/ZPrxYNT236sCg06zw18i03ZLC5Vs7VS6LbMF+hvfoy3EpInmF?=
 =?us-ascii?Q?rwdehBAI2HA31MNGbcC8x5rFWyFCs8PEdFTZZ5w1xLLoZxcvBVT3eos2hMfl?=
 =?us-ascii?Q?l8JsVRXb32toN5cPV4HQVi6FkuBD14evp2lY6F/JFK4ZQllaV6k7oLva496h?=
 =?us-ascii?Q?FLzdJQd0aI+qtHM3otuowKN7+EMSIwVSnrZAn/g2OLDPD2q3cv+XMubd/Dgk?=
 =?us-ascii?Q?maJsjlGwgVzOxhXh7ddj4UBIlOKCDsAEZGw8MzeHo+jdysXY+6DG97iFK6o9?=
 =?us-ascii?Q?jjipoWEANq5KrZCC6DS1UTw9omoR6Mf67HqYv1tApI8DjISRIWZOmU29dTMv?=
 =?us-ascii?Q?UbbX5hjKbzU0zxu9N0NG+uMb31s6XxCGb6SuFNMXbRiCdXpQmxIFoaVGHgiM?=
 =?us-ascii?Q?eAttdHQaUpo40EIyq7JmHhJTqj95rgbDimyb2mn3OcZQ+S41C6kva/77xjYJ?=
 =?us-ascii?Q?9sFurRtI8xwKJF3WkTawbRV0A1VCZkSg6w23twYuGdLt1LFeI7svkzn0zokG?=
 =?us-ascii?Q?l4fLvHIU3x71y08OiX4yzhhV4Tvz+xgquP0+v/5q+UyrTg+NtH3ggvc6Fgyo?=
 =?us-ascii?Q?IOu0G0lXjPRycuypEd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468fc9fa-770b-4e04-c5d4-08dc5c8112cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 12:47:41.5620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJ628pkLclrGeWkUBAH9pk6nN1UVwso/eK/ETI5hlPONXd1TTcq5s29x2AdDoibGS3ytyrqXEXHXdZyaJ4KuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
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

> Subject: Re: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
>=20
>=20
> Hello,
>=20
> I was able to test this series on the imx93-phyboard-segin. Up to that sp=
ecific
> commit no issue to report.
>=20
> That specific commit however, using an updated dts subtree at 2639a0e2fd,
> fails to boot.
>=20
> There is no more garbage on the UART, but the boot stops after BL31 is
> started:
>=20
> U-Boot SPL 2024.04-rc5-00388-gf81e4e85fd6-dirty (Apr 14 2024 - 12:15:51
> +0200)
> SOC: 0xa0009300
> LC: 0x40040
> M33 prepare ok
> Normal Boot
> WDT:   Started wdog@42490000 with servicing every 1000ms (40s timeout)
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0 Load image from 0x45c=
00
> by ROM_API
> NOTICE:  BL31: v2.8(release):lf-6.1.36-2.1.0-0-g1a3beeab6-dirty
> NOTICE:  BL31: Built : 11:39:38, Aug  7 2023
>=20
> Not sure where that could come from.

Which dts upstream tag are u using?

Do you have time to debug the issue? I not have the board, so not sure what
happens here.

Regards,
Peng.

>=20
> Mathieu
