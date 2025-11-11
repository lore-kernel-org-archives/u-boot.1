Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF4CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684D383B5E;
	Tue, 11 Nov 2025 11:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="gSR88b/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB66D83F66; Tue, 11 Nov 2025 11:12:04 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63D183B55
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoxW+9W6hxlr925lgi4jMunIxsCItiV+MyTulpdEsjOCcarLxWpckfkmaxZgvu0TZL/ymqogoLAW7oGlVGDkkgM4NTHs8XxjAkWszIaPqDSsnZV+oaG03tjLSfhoimARts8mRaZKpe3FKITnzAwAAZD3ITFO1hpyH7bY4sCWprY1PotmjKdo5ZF9u/lzRvLZPCNp0Eicv7iQjY+wXS8dANJYX5Ho2wI5IBY8ZejUjhqMhoawhQEXe57NErEsGdqDQ1B6NWK4eg5mR3hhDVp1/wTe7YhSLQPnaEhhkhdgyhERus/GhXRBOllkgDHGYwuUiEj34rbcjzrbwAwfoZ+GbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wy8tAAphpMTZAoGfuVydJU6CBNt2aW+2ya5twhJqpw=;
 b=Z4L/aDkuBhX3ANfHLlVvfBf14zVQT4UGsjcEdlvElPHl3QBP+SaTZMotx7fAda8XDylznk/AR362+QxjVdfYueqou1sifDr38itykOnB7tTSaks57dQfRa8Lc7XSgyq3McGTty14hqupMlQlQqTCBYNOtdKVQ5fM0ALB9DjPBADHTY4Kkdx//VBbfkYPLa0wUqD2k8q2PY/IPCdMdsDbeussyK7mlCX5KhEEhwY9KL1kPtzp8Pa8DGUJMg2L1088GR+X7yFsWVlmPBIp1Fj31i4lxMvoABjhwHYXiNFytYDorchLaJOa7iNeYklUBDn2IQHa3klCPN+BM/eqWf4SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wy8tAAphpMTZAoGfuVydJU6CBNt2aW+2ya5twhJqpw=;
 b=gSR88b/DHcNjZZm0twLNr92GS/O6PXfbaes+04MJIIwkKtkzVrA//ZtYsoy9+eBttwqnQgBVLfuREMcLoOhuLUpfQhvfiI+RqA9g3PQcAkD0w0ljHptDrHNEF92Nl5uAXpFkbjHJwALGmTYz2GnGO/he4CuxmKTBgGLFYWs8TzAlJOIiijde8U3D9CzkKW+tIHB3KEtA4YH13fddxaJ+x1iJTOg7O5N//Jwv+kEgmJHBjFea2GxYU8fAgtRGSdNE78kfD/JzvNDOoDMW3cCuOqL/Me3wbHoboNRdWQADappKuESSwMvnPVIcwGUG83BbKbJ/KdVWzz5/IlAvuq21pw==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by PA1PR06MB10090.eurprd06.prod.outlook.com (2603:10a6:102:4f7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:12:01 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:12:01 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
Thread-Topic: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
Thread-Index: AQHcSnpWtbOTkZTLRUmDzdHZnSoPTLTtUHxJ
Date: Tue, 11 Nov 2025 10:12:01 +0000
Message-ID: <DB9PR06MB8512CB13F3863D35D335EAB5CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T10:12:00.542Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|PA1PR06MB10090:EE_
x-ms-office365-filtering-correlation-id: adecd315-1f98-4ff9-7b0c-08de210ac17c
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OKYXSW0/voV3H4R/Y2T4rOEU6DSq3V1OM2OQux1TOWd6kmif/NMG5d/NDS?=
 =?iso-8859-1?Q?rZNVkwYE78KVyAttV2nKw6vkILeItnbb5QeoNyq6lFu1+wj3EuA92Jj2iD?=
 =?iso-8859-1?Q?CwqolYDA9OwMA+gsBtsQgUxY+zBodLkaXXgxZTlgAt+PFTVmbgWwvXYVx7?=
 =?iso-8859-1?Q?u8U23Qv8l+2An/mp6FRoVx+r27S5Pl89uJimlR8uStkkOR1waUOKLCxtgl?=
 =?iso-8859-1?Q?tL+YCa5v6eClNzklrARuHkCE58aggMCdak2hjNikobqc2boggOXvRUq0Ff?=
 =?iso-8859-1?Q?YPDFg2o9/mJ1Z/Tx2R79g3wrw9dVmuZbECfG9hvyQukQbLymeJub80noDX?=
 =?iso-8859-1?Q?Qv8I6aZgXVQyO5EewDsF5n0h6w7HXFL/2K5se+sVS7FLqtPKSnci1KV5oN?=
 =?iso-8859-1?Q?8uuSzUAa31sE3ZrfygQx4317PJeQpOvgwarxZA1+QLuxoaouTr36GJT6bu?=
 =?iso-8859-1?Q?v3awFqd4lepvc3pB+MFkn6zqPSzVPeeoWRhbi4+1Qb2b6GIF/G4boSCHWL?=
 =?iso-8859-1?Q?y6k3ymsIowch+wMzKvTyEwIeIS9P+0r7WuPUdPiNBq5HeEZkrGG34Cp3r0?=
 =?iso-8859-1?Q?4LWmXcfbet82G5CknFLho6ego93uFZcmmY2sIZfsRJtkcdTmQvXetBwD2K?=
 =?iso-8859-1?Q?1sV11XLSByc2+C1dXiB+crzG5i2oeaV9NB3T6c9DwQlgRKGml9jmcwKJwC?=
 =?iso-8859-1?Q?bj01CIqgbqMqt9SRY6epDH5zB+LxF2FtVz1/4wjvMxQi9Cu3dR+hQrzXCp?=
 =?iso-8859-1?Q?x0/7zsPbRegpDBCwqoC+k6lSQ7JFfpFCt8g8aml38wtwKE+DJRW/oR09Eo?=
 =?iso-8859-1?Q?X4c7MvrmWIApEMaG0wkFCKYMAjQV2n7NoxrJduSy50PkFuiuwDl+G4gcQe?=
 =?iso-8859-1?Q?hBl0Jgr6mB8quKj2mjUGBK3H9j0tqI9YYEykcbGSWfnMlIpO3L+Q/yAnaD?=
 =?iso-8859-1?Q?qQDcBAJ/GfWU95pFNRf6P9KunXBnHiCN+p9EuJT9CCbGkMsqclDeU2fau8?=
 =?iso-8859-1?Q?W0CxpXBDxXjXvxw/BzkNGPdnIQUMum12xL11440Be72HVhagkPBdfunu9j?=
 =?iso-8859-1?Q?XSxIccyzoNe1/7v5daICdGTYcD549kdfGo2yqPhOMTMDHRHE+zHnMfgyaY?=
 =?iso-8859-1?Q?9FasNL3Sbm6uXbjsYG0OR1aXTbalFiS4FDDZQVUd8Ijjnne+zVOxYp9Ktc?=
 =?iso-8859-1?Q?8PzYDv3rK8lZUaOpgrfpQadYC44O9t0sIa5hG8iA4b6MGVV8nhRjo8N+om?=
 =?iso-8859-1?Q?x1aSc/kQ2j418QzEWkN7hl6K+vqlC7QzIuipSv06Uv6EtoiRLlFvTbrjTI?=
 =?iso-8859-1?Q?f9P4amHqatgNEctlGv8SMTElZ+I1PTpwaZ/W3Ro8CKZRmloilboXLBKp7s?=
 =?iso-8859-1?Q?W3nMm46Z0+jzTtk+uk7/M+czKGGAbRdTnm7dP6bFoOHwQLl8e1iXNu1vMi?=
 =?iso-8859-1?Q?jd33tJFpfQ0+3qFYMjoEQQHv7M5qqPmsnDiTBr0mhby1VDRyVwpCWz7a8p?=
 =?iso-8859-1?Q?uSKJ5sz+z0QRtTGglxbQmXZ/YzkTS+9x6pXFs5xPsuDE4fsudAz+b7kALY?=
 =?iso-8859-1?Q?aUUQ5LquxAZqxhlHJ4am0wMip+fQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sT1m9AudVUpX0SQpaILhZI+Xy2Wj0F0JUv0x4oNe0e3WDmkgHwhHRBQmG6?=
 =?iso-8859-1?Q?Wkj9EKA39IJ0K15QyrTsfUEm+ZCebigfDdtDE2D7xiLh5XryGntLWZm8mY?=
 =?iso-8859-1?Q?ZVsfYADHrbFKT71VJD0qv5JWhix8Uue2a5Ed0io1tkWGUQnZtwA1E20wFT?=
 =?iso-8859-1?Q?AL3wKg8c3faqZ/ZfS29YBu4a82B5k0CarWnZ1fZXqOZmxHseWCLbPS7R/+?=
 =?iso-8859-1?Q?Tl1bH0K8DZu6cOVcL1c1DEiK2BnW63EPGTCpNzLmHJHzMx8VZOL6s4u7sr?=
 =?iso-8859-1?Q?NfN5HW7ZytphAvuChEANmeXbmWHcJME0V/elFwiPMPkbcNC/mPD+G+Wr28?=
 =?iso-8859-1?Q?+z3tET0jB+NjqBTXDrFSkUt2TEtvEm87R2mYnds6t8v30h4JQzdoR/QfYk?=
 =?iso-8859-1?Q?Pd4sDft6nBrbztbbW0+1nQnvgZI3g3fkRwFjuq4aHaJy5NE7TitPZuWU7l?=
 =?iso-8859-1?Q?8e/wtxcqpm/cKclVXoTNsAm7CK5fTFs2EBIGxuE0dwGn530ldUexudhMyG?=
 =?iso-8859-1?Q?7n9dAjyAus9bIzRjYeACYdQ3rKA8kCl38IDdk/rpJpHxkElN2BIp9RxYKY?=
 =?iso-8859-1?Q?4ss75n8W8ZSwDC2hu92drjJ76MpUbG61zFcSKkKk1SxeNhgcRwplZRe46k?=
 =?iso-8859-1?Q?HNEsOTeXg/z3sP5256u4xwQBTZQnmLIGqcgp8Nc8Brih2N3XKlDxJP2kvh?=
 =?iso-8859-1?Q?09RknRWrybRJlf2vvhz2Ur26lR9/rShbuyjt5a/reuFyQhE7xzbN74o1uK?=
 =?iso-8859-1?Q?8yha5cjVhDWsfJ6YNFkBhQMaoMCb9GJr8RE2PRQmWDi/1OCBsmpyBQ0rHM?=
 =?iso-8859-1?Q?OOzlsCqYsxOOzKTIA61DKFAZZnQTemxEwJn4E0c3zqSAu5JxMwl3cOxz9N?=
 =?iso-8859-1?Q?aCQux2nfQsazpRohRCTrZJEzpCfoww+41NcuB3LcJVOLmxMpITD4AVTn1J?=
 =?iso-8859-1?Q?Jl6lkrDuIOYq0JsQy38+YtvVIeMuu7I/rCBbVCwIuDnV4aV/mG9dBphoot?=
 =?iso-8859-1?Q?1rkaHe2l/124gW0O15lRqp2OkIR6gPQAMNpDPIPc5kQwIYI0aBy9Flet1R?=
 =?iso-8859-1?Q?tRkfCkrdwCCQTC3mqO9jYDFWXBvIFevWLFINxLV/L7egIpxtoAYnvMagT6?=
 =?iso-8859-1?Q?2xVr4bS5Ah3yetLOX5a8Ftt6DzX0p2oqzW+adB7XCBAtwp2OsbklkBu7Da?=
 =?iso-8859-1?Q?ER8Pjo+f0ewP5Ik/7uwFAYaqHkOS06bs1fu4wpaU+pKuXKbW0sp4Pv15lK?=
 =?iso-8859-1?Q?LSxffwecL2P9ruL2jzq0VcZl9DY1ucMGawzcpwtmoJv2NppxVciWPbaa6q?=
 =?iso-8859-1?Q?qUqCfPyDo9sL2s8tOrTiYw5dM6nnW2T2HgPUKMefFDmuLkPsAChGo0GT5y?=
 =?iso-8859-1?Q?nGVjtQUmZ+KOx+PQw+NHOWo/JXPvDCnlaHP7dlnSke08GFBU9ABzjPMBNj?=
 =?iso-8859-1?Q?VdP7+M69Wuwp6DBXJLKvGf/3paV2dJyUVrcxchHmZckB1UCaZVIl+YR1+2?=
 =?iso-8859-1?Q?RkzX8p/dtfzbmYd0JEGIFQSey3bJT7I655uXDhTABCuWS9EQniWY7sL4XH?=
 =?iso-8859-1?Q?y3jjC90TOwuM4bOkLSINDikZr3joWotfzAREJszIeqr6RTlrw0fkbTSkRy?=
 =?iso-8859-1?Q?6KO94Yc8/mtcgCrcuaUkNPT/HM3rJEkZXtUdV4vF+yLNqjr80eOfjpeA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adecd315-1f98-4ff9-7b0c-08de210ac17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:12:01.2421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0gs53/ElrCiIRqfYp3GD1Di+I7Cg0vQBlQeIueudYzy5f+g6YYVePss0OSloV5I5KyTR5ngelovIaxtZKGRrTSYIcAfRE0iJTm/Nqm9YpR4LKKSP417IukIb+PLIHrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB10090
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

Hi Quentin,=0A=
=0A=
From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> This adds support for using an OpenSSL engine for signing a FIT image.=0A=
> To use it, one should set the fit,sign-engine property at the FIT node=0A=
> level with the engine to use. This will in turn call mkimage with the -N=
=0A=
> option.=0A=
> =0A=
> The key-name-hint property in the signature node will be used verbatim=0A=
> as key_id in OpenSSL engine API.=0A=
> =0A=
> We could somehow still decide to pass some keys_dir to mkimage when=0A=
> signing with an engine is enabled (mkimage does support that!),=0A=
> unfortunately binman resolves key paths absolutely. I don't believe an=0A=
> OpenSSL engine will happen to have the exact same key_id than the path=0A=
> to the encryption key, so fit,encrypt and fit,sign-engine cannot=0A=
> cohabit.=0A=
> =0A=
> The public key (with .crt extension) is still required if it needs to be=
=0A=
> embedded in the SPL DTB for example.=0A=
> =0A=
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> ---=0A=
>  tools/binman/entries.rst  | 22 +++++++++++++++++++---=0A=
>  tools/binman/etype/fit.py | 41 +++++++++++++++++++++++++++++++++++++----=
=0A=
>  2 files changed, 56 insertions(+), 7 deletions(-)=0A=
=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
Tested-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
=0A=
Test case: Signed FIT image with U-Boot Proper booted from SPL=0A=
           sha256,rsa2048, openSSL with a PKCS11 library using the engine A=
PI=0A=
           fit,sign-engine =3D "pkcs11";=0A=
           key-name-hint =3D "pkcs11:<pkcs11-id>=0A=
=0A=
Regards, Wolfgang=
