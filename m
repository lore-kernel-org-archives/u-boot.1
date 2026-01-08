Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F85D0D17B
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD242840F5;
	Thu,  8 Jan 2026 11:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lTgC3H6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8033D840FB; Thu,  8 Jan 2026 11:33:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A2883B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLNEDIyyvdc1EvCq5WfcVnd4Lcom7QbkaiIcCI8D6paaCdXqp7uknIlRRRaiJeTvg9puwfRJPl7ArRj1JQUMduOkPTRspRtPloqxdA3qe7FGbemlplMYcn5SCLJSssM1/c06xVpqgTy5nqXYK9/IY0Ic3wxYzgbz2VGRy7jsaytLxchQC4gm8ts4K44f464U7zKMkrvNFxCG6FV0Ta2FtJnuFcuW48ff8Icrtt7TYMmzmb67FiGbUpxsmtKo+C3fw6+q0sXh12fPF5aE+5s9Bd9jk2BIR5LcesWOJbmVgp5pK1ngVPYik8L9x4uwJfhsz5nXwqoand6B5pirf5KOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSNUz6Dfh/QWBqEc3BwlkKii6jyR+PJk29SO3EYmXFA=;
 b=Bgu7gncCExGf7bFfofNlhisMnqE94f7rhG6qrd2NjZBlxhPA/RMSixmEUOcr2hgkH6HFWkS1aK/bTGjvXHmB8XQlrYUUs3Gte1cLNDMv3I9ct+pjIfByZW4VBpCXb8EQg3pxAdomhtpk9GX/SDubE6qQErnKCMxzKyrZR7glorcaZQjtyZKq1RMgxsPtJa7rmnaRPh8OzJX7QHnK+tGsrJnwVWIO4YEAs3RIUggL/s1aTQNkD1Ppn9m0hvGxfA+lf026RxSNHO5x2boJw5osmbvEIAFGylj/fDl0uVaYsXVopkK7i4km2tmz/9AAmgcObxcS4fg0uTu5h0FEz8EebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSNUz6Dfh/QWBqEc3BwlkKii6jyR+PJk29SO3EYmXFA=;
 b=lTgC3H6UJeA5fyj0Fo9dFBnfNdiDzPuTJnmrgLDfFtT1ZFhKs317cCcbqG+Ahrodb1YFzsJxYkdI+HpYuyXXAEARIjgBUTAlM2aXk0ugFSIG1RKuwLyCJBO3yo4XwjTP51wKIxYCxcZKoCnrafTKMRtq5EsiGZWo2vEkG393l5IlKxat2F41CjBFnHIJz3Ilx9hHKElIigGQOuHbKKWcyr2Fwp5JXRimT+6s8kCUNQFNw5OS4MNootDyfjes8Pyff/25stq69nOJyeIEjyhfwkm4uzofaOX3Ob4+xAAeWYgxaeqFUZ3OmYUjwanprDItreV1Wq5QUMgTNMTl85HlrA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 10:33:21 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 10:33:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 Vitor Soares <ivitro@gmail.com>, Fabio Estevam <festevam@gmail.com>
CC: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares
 <ivitro@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>,
 "balsundar.ponnusamy@altera.com" <balsundar.ponnusamy@altera.com>
Subject: RE: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
Thread-Topic: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
Thread-Index: AQHcgCuWoX4hFiy1iUWjZCIEUDR/MrVH2RaAgAASXoCAAA/KAIAAGHjg
Date: Thu, 8 Jan 2026 10:33:21 +0000
Message-ID: <DB9PR04MB84613047013E58521989D84B8885A@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
 <20260108090428.GA5224@francesco-nb>
In-Reply-To: <20260108090428.GA5224@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM9PR04MB8384:EE_
x-ms-office365-filtering-correlation-id: 07cd5538-6e71-4ab5-19df-08de4ea1587b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jvo4BKMEBqNRnPpYHGnDgs97wR5SKy198Fvg3gleM3qt69kZfdTRlTPDGscU?=
 =?us-ascii?Q?GoGZjxc1c7c/SGPqf5pKnTvabfByT45xfryJ0ywmpTWNjABezurSIJgRIZlt?=
 =?us-ascii?Q?C3L+sRFYfiaHTeB1h+MY/5hxgruW9G3F0xNS51Exkxvon4fh5SV2qVjnA2Wo?=
 =?us-ascii?Q?RLk6ARAd870c3kmY9ahwHbNLi42sOP6atXI+1WKQnUCurxdxbohi5K/wsBxE?=
 =?us-ascii?Q?WjhiaTki7Xpvhycu7F/g5u2GnAI3QF454NlKssnd8Sv6aKr2TlidF3SeF4H2?=
 =?us-ascii?Q?vEvGDM7u6a9k2wGi+m1NkOEVVT66hw4gNwhtTtck5XGEulX/HnTDS3MKNRrA?=
 =?us-ascii?Q?v44bssco7h98RPbqHxja/26ZaUioBFyrmHxceIxmYcZDnywBhIxvv8dYUqGw?=
 =?us-ascii?Q?OI0CRUr37hPVd9NQD55d1iLmleJ8cJYuXnMucINk4O8PwCQpduZcGkiIENsI?=
 =?us-ascii?Q?rW89964iiLPJ8HKPIzzWLwIx1V6YAKAVcnN+Az81xUlQg36k7Wvq0ePR7pja?=
 =?us-ascii?Q?HH/qRLWMasKy0qI2Oex/KAYnOVhiBJnusiq4FXF7Q9oo7J/unRjeqwRDwsTZ?=
 =?us-ascii?Q?zt5N2P5pgQTXuvREcKhR5nTeuVkt3cs8qw7m9VXfdAA6zfWt8pF1euR5nCeU?=
 =?us-ascii?Q?R0D/NG+kFRWxhedf343Zo+GGcanDjNc+OkjY9LR4iIsacBG5rYCkM2GG9C+5?=
 =?us-ascii?Q?M3v60TZFxtDMQfaacE8L+C5AoC0cS+YsfixLntrvxfmAsTiwi31g04r1d8fi?=
 =?us-ascii?Q?S/mAXMiyiIZd6mdAYHbRJTOhyEaegx72jgVDI134yhBlLsPKJln+Tx7+PMuo?=
 =?us-ascii?Q?ulq7+hrV2Bp3acn/mZK3SxusUotkVcoobZNPIDIlf9EK4Zc/ciuwV6fVGodS?=
 =?us-ascii?Q?onx63HNVzBlQo0DZ7Qm/Dfqsh4KzA2p6gn6V/RISdoRWqedsCFTxI25qUjd4?=
 =?us-ascii?Q?/ru8yLa9A4MUrGBgfEdfKIwr514E9YdRM1/4JrYCetimUMroKekdrVh5R6mc?=
 =?us-ascii?Q?luuMA5QxBDLnrnu1cHlk1EfOKHfy0CBbf65DX6s3d1xpq5biOnduHiAPiv/o?=
 =?us-ascii?Q?p63s8jpfojDQHpQC/Zotwfvzbwl9kkXSTE2fFwznRMhvSaBSJUth5pLIZEJQ?=
 =?us-ascii?Q?VeDIJ3001VsZ1NTVj9jGKCWv3DxYeKMZ5MehE5Z7GND26xhzzBz70Ve1RSis?=
 =?us-ascii?Q?MAJkXRUBcqtaJuch7cLpfSq90fV0E2gJQGpOYLAKHpsOuTZPy9sN/sJSGYxH?=
 =?us-ascii?Q?fh638UaIZFFDz/AMIoQsuH0hxWJeyTqSRWE/2fI32qZoRP44V5ceOTiyluoQ?=
 =?us-ascii?Q?fyBxRXobytJC6ASXFZEzKAJvFjy06kE3qSsV3UnWlgW5S9Q1bvOrJAVzlePL?=
 =?us-ascii?Q?HUv5d2xNeVK5q5VBgATJjKgLSZqs2CMBiBLtLJ2/t9BI6oiTy/w/tlAo3Vzr?=
 =?us-ascii?Q?8HPl7K1ikW/V75Ik8HJkMKAqjPm16XNOcPMJxdNlOTZQ/le6CsR59ZeasCrm?=
 =?us-ascii?Q?ERELthnv/JC1/F9sql+phd6uF7B08oPV0SGA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pv1jMVEDfEW0COTOSQUczrGE2nC5sp8I4OjQp4P0P5k+prZK8rN+Ye38Vgtf?=
 =?us-ascii?Q?LHj1mzqNlyF8IRs2UioBHfjIzG7JvAsbnx+i31z9tJzyyc/jQQM7DXN+9FzB?=
 =?us-ascii?Q?5Y8/KLIt80lfXDm9F5nF94agZTTugDYp8O5UxGmoBgonJEFNlKdHPRw67Cl/?=
 =?us-ascii?Q?8jsdtrS3kKAxCupo3XBRxbqGdtUstr631AXc0k99OD/WkF2Epcb+4h22GfcF?=
 =?us-ascii?Q?q4+UoD5SQucvaa7X6PE8rrEfMtF35QULzJMUACrosIQj4T0+Avw85JW0iDX9?=
 =?us-ascii?Q?WJjjgmgHEcDWvXu3GuTtN+PNyVM54DO8mLVlTRrhoKsJMlPz5RPtRIc4gqtR?=
 =?us-ascii?Q?7vn4NwC+br66nOj+CLj3ORoPfc9nsTgI8ck2mNo9lo+C7BHJHFgCgrc4BrjX?=
 =?us-ascii?Q?9qM1vhy67ms+GWzPnH5ODHjID8qCLb13OGKOcFGWOKCUalfWVhrvULJsQDBg?=
 =?us-ascii?Q?4IqZh95FYjLejEXK1HeL4FXquqers7gwlMgmRWDumTheAbGLuC7OXUr4LDk7?=
 =?us-ascii?Q?beXNj4ZGWyqD+JnbeZbWpGPXZhPv1sgQht1AJ00Kxkdnwrcp3lii8i2gmRyS?=
 =?us-ascii?Q?v1qXouGzY7sb/PngzWzATnZe2a34du99kOG/eKjLX892I//Zk9GLqXgKylPL?=
 =?us-ascii?Q?5K7zCMNxjqldCc7s6A91SazJv31skQt9lEP5QFtwjFDIlnrFnlYGhIuCsyr9?=
 =?us-ascii?Q?8sUKOOz+PoNU+sWOO91ks+MJnX+fbC/XdPkN1fpDqYxzN7pFxYX0AcSYjgO8?=
 =?us-ascii?Q?EY/0sDK9tcaDEsHQs9aEp19R4k1WYV0IarLS4rCFiEtjoJst3UFfSoTRUK57?=
 =?us-ascii?Q?7lgchjEzED6mbZZxoxfG0ux/0fr54N/XTgGSUQ8jG6Pql03keGjHXu7qRARi?=
 =?us-ascii?Q?Hf/GfJpoJELusKamrAwvn5YPKoNo1L9kOCP+DjKixNVIKOKfoD6sIQ4M6SxX?=
 =?us-ascii?Q?3QWnRLbOgJqbZAi+j8dOMltfFOUxmiIy/lX8ICP9X1bBP9qeGaVbnByVZDMu?=
 =?us-ascii?Q?+AweUOAu8sYnsuLW44P3Br7Ku9Mml81NotnJNC/kQbTpO35psh7U4Cg4eFjd?=
 =?us-ascii?Q?SpuoPf0BQhM7fqk5iLvl3CfA7ut9sEqhIFFqJU5nuEOANgBBIWSG5zHIkiDp?=
 =?us-ascii?Q?eceIIyT8PHly+rIJQzYazHSsO/MpEgDgIdSyGdA/CMkbVPMGu5oGD/aGxRPI?=
 =?us-ascii?Q?zC229f5t/abaPGe0t/qchOXcXLJMSEOGQQzU5XjTq0sHashW2B2GLhuVc6OU?=
 =?us-ascii?Q?rMjvYQZvcA1PFrWulQWy4Fxc+sqQHPE3hcE7e6mapOoW8F+wOKGBj7hXddvW?=
 =?us-ascii?Q?d6LLG290v5lf8nZm5XvnijRrftwJVdpZ3rHo9Ag98iJDX2NFFSuygr7aHtda?=
 =?us-ascii?Q?C7Ct1g7wYgD3fDg5hPrgBiIJSFvES0Ilu9h60LM/kjK3n7buSgqjD9phcgtn?=
 =?us-ascii?Q?q1Q3YWo1vgmx3dXG9assuCfKSdz4Qr8goa2x5FUYwIrjs2ZW/4BXv5tEIOUB?=
 =?us-ascii?Q?4d+0h4gjnsMtPVTPp6ByDyW8K8zjL5V4QLC38lBujM1nLw4eN5jG2tryhtrM?=
 =?us-ascii?Q?CO6WX5nBtnIztT+sDUvSSu0E31lQmLbaPlRKUjHVa+fFcQJB1B1rZdLzPHv+?=
 =?us-ascii?Q?gRVBdCrby/Zt+14Ybyic3ltkhRO1NvG9q/BuVPVAGvlOBOLEEYumYMg2NNwq?=
 =?us-ascii?Q?nnqwITBOlV4JOjDIpaZNk5IU6R3c6gnTxewrslFg8QUBGxTQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd5538-6e71-4ab5-19df-08de4ea1587b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 10:33:21.4091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNbXLSAyZRYT+FqUR6+u4SewOgd/tzID2Y3GbuPwZiV+M1wg3MXEQEnItkflvJPONagkASNQmqtdp87EvwST9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384
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

Hi All,

> Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on
> i.MX8M/AM62 platforms
>=20
> On Thu, Jan 08, 2026 at 01:37:57PM +0530, Tanmay Kathpalia wrote:
> > On 1/8/2026 12:32 PM, Max Merchel wrote:
> > > Am 08.01.26 um 00:15 schrieb Vitor Soares:
> > > > U-Boot 2026.01 fails to initialize MMC devices on multiple
> > > > platforms with "unable to select a mode: -5" during
> mmc_select_mode().
> > > >
> > > > Affected platforms:
> > > > - Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
> > > > - Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot
> > > > boot)
> > > > - SMARC iMX8M Plus (MMC init fails in U-Boot proper)
> > > > - Verdin AM62 (boot failure, no output)
> > > >
> > > > All platforms use eMMC and worked correctly prior to this
> regression.
> > > >
> > > > Bisect results:
> > > > - Last known good commit: 228810d0bac3
> > > > - Known bad commit: 36aeeb591b0d
> > > >
> > > > Between these commits, several MMC-related changes were
> merged.
> > > > These seem particularly relevant:
> > > > commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency
> from
> > > > device tree with default handling") commit 1e40e419aeb2 ("mmc:
> > > > sdhci-cadence: Use max-frequency property from device
> > > > tree")
> > > > commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and
> PHY
> > > > speed modes for SD and eMMC cards")
>=20
> ...
>=20
> > Thanks for the detailed report and bisect results. I've looked into
> > the issue, and it appears the regression is introduced by commit
> > aebb523a2381
> > ("mmc: mmc-uclass: Use max-frequency from device tree with
> default
> > handling").
> > The problem stems from the probe function in the FSL eSDHC driver
> > (fsl_esdhc_probe). Here's a breakdown:
> >
> > First, fsl_esdhc_init is called, which sets cfg->f_max to the minimum
> > of the controller's sdhc_clk and a hardcoded 200 MHz limit:
> > cfg->f_max =3D min(priv->sdhc_clk, (u32)200000000);
> > Subsequently, mmc_of_parse is invoked, where in the commit if the
> > "max-frequency" property is not specified in the device tree node for
> > the MMC controller, this function overrides cfg->f_max to 0.
> >
> > This results in f_max being set to 0, which prevents proper mode
> > selection during MMC initialization and leads to the "unable to select
> a mode: -5"
> > error you're seeing across those platforms.
> >
> > A potential fix could involve either:
> >
> > Adding the "max-frequency" property to the relevant device tree
> nodes
> > (e.g., setting it to 200000000 or the appropriate value based on the
> hardware).
>=20
> In general solving a regression in code, adjusting the DT is not ok in
> Linux, not sure if the same reasoning would apply in the U-Boot use
> case (considering that both U-Boot and DT are firmware).

Please see whether below changes could work on your platforms or not.
It works on i.MX93.

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index bf0bea93853..a32cd25ba85 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -249,7 +249,8 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config=
 *cfg)
         * will set the MMC configuration maximum frequency to the host con=
troller's
         * maximum base clock frequency from capabilities register.
         */
-       cfg->f_max =3D dev_read_u32_default(dev, "max-frequency", 0);
+       if (!cfg->f_max)
+               cfg->f_max =3D dev_read_u32_default(dev, "max-frequency", 0=
);
=20
        if (dev_read_bool(dev, "cap-sd-highspeed"))
                cfg->host_caps |=3D MMC_CAP(SD_HS);

>=20
> Francesco

