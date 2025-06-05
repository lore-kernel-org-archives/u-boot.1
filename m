Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB5BC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 11:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10CC8091A;
	Thu,  5 Jun 2025 13:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aHdVluip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854B281E25; Thu,  5 Jun 2025 13:46:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A21A80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 13:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6v0/T50jQ/effJq2aBVCf3ptKiVmUZtsFRlo1fpSTcN94Gxb9YtjjcvNZQk9uRLPs5zzFiO54htoYsefCGfR8W3maofmLXwsGwwpIDo+KHehtGJbB0uWzJxBKQHZDkXVPRXntsUxmnO7SPaZ3aWR8+Kg5nNIYllAKcmldbg0kSNRGL097EDCLqSdRaC+c9HkjrFU3k6823lSnD8sbxssa1ab7gyy0yO/p/aBOSJkLT9+PiJFdHX2At99n/DEKSH1Qch5M2s2qfyENXv4wZevq1uRefoLpmBBbe/UghRxWuy0rvDK2FbkGeDrxQR2Gr4GPE9rYAnUbIopse8Z6SNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16d9kzwVSSIvo5NneS6GZhGbPZyf8/3qcNityFRFXFA=;
 b=fp4XCNaHAbDKBq57gvKNm5yudz52dgoYFK1gbQrHMvWQWjHrAwqZFNwaMpofvmzQeR0FBvoDGerEt2hMRwlo1MgTVVQwYiq1xdLYagBzNl3/muEnMvyoGhkigC/Ep+tovUl20/s4RQehAoG9X+mAcmZCAI09OaE3hpsf5bqqeJBhKM80r/dcyZ1aNLgsCwSWsaNE4Vn66VbBY7omsOLyYxA93TYLOQ6A+8vSldmwbawimE7F3EnvzPQVzv5WwGcg4FT7Ott8fgiDwGjNcMdrgA6s9tpmNrGUD1ccVF+j3YFCdd3FrKpBFeCUnVkHCrf3c+gq4lpjJMDObBMRmRNYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16d9kzwVSSIvo5NneS6GZhGbPZyf8/3qcNityFRFXFA=;
 b=aHdVluip8Ezi63rdQB/LsJW1avzQOZfeePFRrTLBlzgWAT7CerJk7XwM1M9KCXEBvsPzZz210psbFdkaHTbvy5S9sFZspem5V7fc+f5Dz3Dgm5eFE90oVWt52F6gV5maijmBs1kzTjiSMpXAD0lWpMJXVMZFeP5YXp1Kmr58lqNPIoZztQiKq/GAd9Eh3eycEFkwlRksEubA1DGmZQcD4ex2VnbDA7Il1wUzwjh3XypiNAjDtyClk2JPY3Jl/aDbQQ2YQhKTE5wZW09wYGip9NGv6FR1yCYqtdJR3Ff9XiiafU4/mX3BLyUK7b+bsgaWxT7FIIebj/l/b8YcFqySPQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 11:46:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 11:46:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "Baehring, Olaf"
 <olaf.baehring@draeger.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] Revert "caam: Fix CAAM error on startup"
Thread-Topic: [PATCH] Revert "caam: Fix CAAM error on startup"
Thread-Index: AQHb1gf+ARg2kwiyCE6BEpdmfPfTn7P0cqog
Date: Thu, 5 Jun 2025 11:46:15 +0000
Message-ID: <PAXPR04MB84593EC8734240CAD40D1A81886FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250605105244.619858-1-festevam@gmail.com>
In-Reply-To: <20250605105244.619858-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8840:EE_
x-ms-office365-filtering-correlation-id: 7b4ec174-15e6-4cc5-af78-08dda42693ca
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uHitzuiMzIypsyHe2rFIdFUjI87UNr/biSyEEyRGkTmTy9GAweZpaFSBya/g?=
 =?us-ascii?Q?DXgpbB9xhJYIHUaLmGpUSxv1KpwHmfvYpfjDkqkff2FqdOG/s1YEbDMivwD/?=
 =?us-ascii?Q?JHi8vu2Sk5q0Xvh4UMJHL6avjQeuzf9u/pyvwiKhLXYgJgmF1n7a1Lqf8+Jk?=
 =?us-ascii?Q?HcQjFiUDXzFtBkdUAny1JKtGuZPO3jdroviogQbB6LlN7GU6c7+aAn66RRvl?=
 =?us-ascii?Q?jdpGbPmGMWzV32XyVKKafL0PyUQAieOkvY43CfXIAl+QfzuC8B3n3PpL+ckg?=
 =?us-ascii?Q?v7ufBcuxrkvt6LWbkjls5sYMjCEqL52njwptz14M9C1OagDMtdnoE499Am78?=
 =?us-ascii?Q?E/2AARTfvIfP2w0Zgea1g/1Jm2n9jyBUOz9hQd582Gi4O+RJpa4ee/ARWeqR?=
 =?us-ascii?Q?OFxA1b1TMVqns7hLpgD4vO6I/+ghx1VDbAECGUInGOMNAtbWbrDIBxFwpTtu?=
 =?us-ascii?Q?REQ89VN3N45nQ7MVBezxf6eR6kkpN9UPyQ+FwgVlYUUSVTvFvC/oR4/wYVx7?=
 =?us-ascii?Q?nIzco16IN/oXrzutiYTeqlLVn0a/kE8ex0v1Ji2hUedcyUxsJ30pYzVFyaRp?=
 =?us-ascii?Q?tOltq8FrQF+PfwkUes2epHoYjqMokwdvQ44qfzCraYBYob702VVMrVZpSJU/?=
 =?us-ascii?Q?PG4qulOaqv44PHhOxCdGvtwyhIRxvShkb+JBa7axFd53GmXQ2AI1FLyiBDA0?=
 =?us-ascii?Q?5g88vxaxZIpDgWma0tSPGsDCKjmhgPg3wVSNmv2tvCNhfQyg70qpJOEYjR+f?=
 =?us-ascii?Q?t6bQSy6A3JlTOeE1KH6dF9ewR4TF7TevTUNPUGYPPfI2XajMtwoGL65ounI0?=
 =?us-ascii?Q?c2tmTzYimW7AeZclsoAXMJGJcZY4cL8jZtQmFVy4CsILLqCj9UF/K/5eVZAr?=
 =?us-ascii?Q?VTr3diWBU5DjR13TBbB5aIHSNMqd6w6Lya9bFGOY0n1wxyIqhCV8115APOf4?=
 =?us-ascii?Q?p2WhOAHASmq4QEDI/XlzUq7YpylAtaxopPQABD7J31hiLsGdi+iNt7d3vmym?=
 =?us-ascii?Q?0ITu35NcUlPxQ0g4UtQF3YnzR00Xa8JJOWXUWY0t8v0jqkLBPd4PCtXL7jKi?=
 =?us-ascii?Q?XF1Lc6ZyUoSysNnPx9TBaKhNfMWSLlVGJ97a3oc2u+K/BGEyMMvud72n78j+?=
 =?us-ascii?Q?ChX8S/IhGqwf+rUXGlZM4NDODLRcyDWDls4QI9PsNKaCHYjkppd5I0rzALGx?=
 =?us-ascii?Q?4ftoMUFhPR+4GZFpUTumAnWPKQVaXvlU/xcFUJ1/yhKdkTgWaIe5XBrDIbSy?=
 =?us-ascii?Q?3eluluNTJn+X4s7rOQVfAxStIKkXXz3A1XcN1nCYPgqcQe73GGnvFCFx4lPf?=
 =?us-ascii?Q?n4kKVcI2bmS2lmckRsaPJd7LxmymeG39UfB6ptJVcBVIQ8kB7COL+MDvsfJl?=
 =?us-ascii?Q?40h6rFTTDiOYV2Rbt0bBQEpWZ3dFXdpfMemdt8QluNG6EfcGRoTmLzRzqW80?=
 =?us-ascii?Q?3h2L8NhEDTVjxxEEkuSMDPC14/AY+RO8BUJNI1CnA1C8w5dGCJWGRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZ1T2mRMnfYhwOVhuMsc/jenzmwXVqCYcDF5f+j0NCoRJGUkW4c+gfrTz7KH?=
 =?us-ascii?Q?rHftg6K6Trn8K14qPrS2QNJC97FzKnBirw94KqVYCy9YgBmHrHm+0/GcvZB4?=
 =?us-ascii?Q?776l8RnkvvYLkNf7gw5GkRRq8SkrW0D4+YXYpcIuKr0IV0El4mjXYwQ5tji4?=
 =?us-ascii?Q?vrDudE7IXjiquTuUjxrBheGkB+oNrXTywbYEzgf15hXlX+AanfJdG4pf0jJP?=
 =?us-ascii?Q?nk81MiVpxTO3Kvxu8xjKX2jQWj2bSCwLGqBl3mRMR/qPiHf5b36WvJt32fpX?=
 =?us-ascii?Q?go4ymI9n+kzdQf46FN1mJkiz5Qr/5akjReAbOZL8lCFlfFS56TBjcP24cv7b?=
 =?us-ascii?Q?CmUv1nPwuAWt4yklnuUcybBDCTTS6wVgcOZS2aozcvmlaLee6J1yLOsSyoSi?=
 =?us-ascii?Q?xO9rxMXsLiUBJNDTVtiJRtTob5BG+FzIXbVImjOYGoLUYJJFldqU0iIQQaXo?=
 =?us-ascii?Q?jfRsHcJ2sHOAyolvWOTN4GMC9hmhbQugG+jG/qBCGniCpxKky7H44PS+xYyG?=
 =?us-ascii?Q?VR8JQu1343WbcRTCD2+6JnjIFqoFNHslgn6c7G6j19ggJaDAq0N5Poq6JxMv?=
 =?us-ascii?Q?AsQhZxfZz2f6IzyHQyTXSietJBEDg8YAJP/WF8uaDiwT/UodlTcqo1Swg+4A?=
 =?us-ascii?Q?SruKi6D7EwqzW3hTaSh0Dh2m6+T++2wENcTzab6BuZWpKJTz4z8/+vKwA11n?=
 =?us-ascii?Q?fBTELapyYuWfBZbGD8XG0nGDwGc68ZRSykw2Ee2MDrmMOeFfZKY1yMNPX88I?=
 =?us-ascii?Q?GTzmCKSKQWvlN4WtE9FGStZxW9evXySNmcKC8R24EICcpXY9X3yE5KvLfUiA?=
 =?us-ascii?Q?WMQBn11I7Acgug1Tm48VKpPdWqxam8hZlkXzLPDIj3H+KnJo5lP0lhvY7F/D?=
 =?us-ascii?Q?Oz3dehXA+nyeFe9+uPGoHMwjn+SdQofZfvMcnAjknQQxZixXmq4R40Ia1EQm?=
 =?us-ascii?Q?IB7JAAtynVj5q4YuRv+kicu4P7jNEftd9I5UEj+/j36fsD6j2kQEUJiLOVje?=
 =?us-ascii?Q?9ja/7ESb64WzNuKgikluH+hdbYEA23VpnpJtMTnoDyfXRWqjG66mQfP22VJX?=
 =?us-ascii?Q?2p8EsksxkW9qxDTeXWIZuikxDGLGiJ/s0Z9v9AkoW7HvFKCgM1eqMBLSeE/F?=
 =?us-ascii?Q?IWEWJQsuG8lEE03NlwCmeehcPtJlQm0xhNuEhxmfQBnlMxayixphEWhf55rL?=
 =?us-ascii?Q?fFMGQV3akqoXyy2wnAsiSucUPjiJVzCxPMsZrMcwTMsrXv1i0jm62yZZERBo?=
 =?us-ascii?Q?3SnIeYYauf1M8Gwwa/vwV0kL7kUb7nVD3JruebwXsC1K+Ny+CV7USPfUzzam?=
 =?us-ascii?Q?xVmy6WqGkOrdWTguKyGq9YjRSqgmkygvZUnYOTzDei532A+oRgYRNSh5niS3?=
 =?us-ascii?Q?u+j/v58eCx1eF7oqAP+Aq32qcfh78oyzkgrk6K7Kwt3zJOxwrMCGxo+bkJCD?=
 =?us-ascii?Q?1CKIZ3/8OFpdI9yW9V2PC6fBqnXMDRzfqeM4WxEZmdr2wmmYQ9+WDStzCv1m?=
 =?us-ascii?Q?YE//rJxFJ2GjoanZ2URFKW7AB0/+EXCwAWEjJ3wEOjR1jx6SFGZdQ/6SjUcw?=
 =?us-ascii?Q?mxdRcB5rR5VyoKRIg2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4ec174-15e6-4cc5-af78-08dda42693ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 11:46:15.1160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G2GROF+u2vbTIrO3PuMbM0ovyH3eapSCfzJ73/Zfpa6qor2m2JcJcPKsTe5/xG9kYIITcZ1vDM+/GktHzfmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8840
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

> Subject: [PATCH] Revert "caam: Fix CAAM error on startup"
>=20
> This reverts commit 159b6f0e119962ce5da645f548cefe9196c8778e.
>=20
> Since commit 159b6f0e1199 ("caam: Fix CAAM error on startup") the
> following regression was reported by Tim Harvey:
>=20
> "I've found that this patch causes a regression on an imx8mm board
> (imx8mm_venice_defconfig) where the first call to caam_rng_read fails
> here in jr_dequeue but if you call it again it works. With some
> debugging added:
> SEC0:  RNG instantiated
> ...
> Hit any key to stop autoboot:  0
> u-boot=3D> rng list
> RNG #0 - caam-rng
> u-boot=3D> rng 0 10
> caam_rng_read caam-rng len=3D16
> run_descriptor_jr_idx idx=3D0
> Error in SEC deq: -1
> caam_rng_read_one run_descriptor_jr failed: -1 caam_rng_read caam-
> rng caam_rng_read_one failed: -5 Reading RNG failed u-boot=3D> rng 0
> 10 caam_rng_read caam-rng len=3D16 run_descriptor_jr_idx idx=3D0
> 00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f...=
..
>=20
> If I revert your patch caam_rng_read works initially and on subsequent
> calls."
>=20
> " I ran into this when I was testing
> lwIP HTTPS as it causes anything that uses dm_rng to fail the first time
> (such as HTTPS)."
>=20
> Revert it for now to avoid the regression.
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
