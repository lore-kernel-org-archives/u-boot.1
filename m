Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D6AC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 11:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A6182C4C;
	Tue, 24 Jun 2025 13:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PBgJ0M2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CAC82C84; Tue, 24 Jun 2025 13:03:45 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F30282C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 13:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+TCJqZvrwvaQ4pI+tIoxk0eYEG0iOZ4C9Qf0UK1eajwVi/UIuE/+sGOZS9Rn0+x0JGlrB8LqaNTlGcSsKGUu+oTPROieFWLQurYyr4rN3NUuByE5ZvNJAoCbEDWZr5kcTL3H1CGRgQVWadGdkb3zfnsfSG2UePYU0SA8f2sZaNiv/0lTu06NySWnCpkpAAZPWEXnGJvI6C37xGRjk2EH3sSiCVGlr+ebvgs9AQeP+FY8sCHuTlF5noqlfhEimFaNU4bOcFiaKxl9lQf7KwHvU3dkg1YlZFqN2l0x5Q523AjQvfHWNnKhxdNWLbjeS7PVLWRqEy+QP+kTmkY2NcipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caUNswtMMz7AAoFkBKnPHB+6/ywKb7nwRKjb8eANTgI=;
 b=NblJg2EzPgPJIHXzVC1zqCXj1lbDlF9yLgVUFEzzSjQBBfY29VLoZZ2u0SPTD/Gc/sxhn9HsuvP25iQNo8h1eLfILCnS3Xdks4Kz2qY5iqZI46whpdGKytiAxhCssxhPeMBzhBe3U5bgPEgLkr0QflmC1/hnsmv87ZQj9/OJIM8PSLk234doelgIjoFbscflzpooRwBvLpZccAvZXC34dNQVUtGYQDsl2qlyfhruPNS4FoK0c09e+7X1dsxdB9sIpNVz43C9mfB1wULN4+qi6EMVMKfrthOUzaRhgdQbANhExj0bZ/KboqjQ1PcfdZk06iM2+310rYfeo021U4lLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caUNswtMMz7AAoFkBKnPHB+6/ywKb7nwRKjb8eANTgI=;
 b=PBgJ0M2V7o6+tR/3bmjsgM1k3FQDNOL2ivUKrkJORLOt0g5bXMtUlFhZO3HEi5quOmpITW59aiD+5VIYH1gFf5RmRiADdhPTwpsbobU0ffIhgzSBaJWPm3yVQMHq6IpCxOlyj1h+vDOnDa2yoLmRYA3spKKPUwvW5M7oU8t3WVJEwI7tAi5hppfudEskpLiejpimRg/oNxheqsTXnnCojhEuoJH7l3en0noAXOyUpAbY4NdwHqa1teaFrOQQFIA5PmM76n1W1ltHdoOCmkylm0z9YpJEfIUH1Q16ofFfC6N1OYg2MNeSxTehyVgPLiJuK4fWcxWx0RFWDcaE54R+9g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 11:03:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 11:03:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "festevam@denx.de" <festevam@denx.de>, "hs@denx.de"
 <hs@denx.de>, Alice Guo <alice.guo@nxp.com>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "eballetb@redhat.com" <eballetb@redhat.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip of
 build_container()
Thread-Topic: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip of
 build_container()
Thread-Index: AQHb5PA3trX4yWObbUe1CHYkPMqGZLQSJU1A
Date: Tue, 24 Jun 2025 11:03:40 +0000
Message-ID: <PAXPR04MB84598671001825DFA9DB4E6A8878A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU0PR04MB9371:EE_
x-ms-office365-filtering-correlation-id: 859e3008-4d4d-47de-72e4-08ddb30ec6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AEHE/dpK3QV7w0wR3GS2I1a4xZlxnkQJgL5uVYShbViKlKOfxTfFoGYlpjM8?=
 =?us-ascii?Q?hpwo8Vo8f+Cd1yud/KG1FW/TfCmIkW2xXGdSbIrSSBVHlDVfayeHKfJDaYrT?=
 =?us-ascii?Q?GPNM/TuGY0XBZMS2o2tx0T8CMUyv+qC6bKVXfRkCemlkHqQNgZoCXNNq/LlN?=
 =?us-ascii?Q?ijLKQcBbJwEU84Yg7XDwjEGByHbKSYajc4PKUQc5NUnB/3R1mC7bB6yAHSUq?=
 =?us-ascii?Q?5Q+1lbaJflDSmuqtDDborkxsy49nGF9wLCxgSy/o9ug16aYd4yKFP+3oBFgu?=
 =?us-ascii?Q?R1TEKjtdLrP0DtB5BLCs1h2M6SjwlDKO4yGdN18yQoSGtptQ86tJ51QPxOHH?=
 =?us-ascii?Q?NWf0f5+M5K1uemmvsSDT+cTcNUm1PiNGb6bEug9wZeYUEkQ8UwZIUfi6MFQT?=
 =?us-ascii?Q?F1gR0uxJmYMNFOqUYN58l+0GgN+m5tt4jA8uk0UG7VqIm0aMVq/UCtd2+Bg5?=
 =?us-ascii?Q?08iIKp3gYnS99s81hNERmHuXhkRw4ryeQZjZ3A+jt4MIBOAfdgSiSJxsHe4/?=
 =?us-ascii?Q?PmmVL5uTrWEGuYjTvSxe7Q7yMy6QdYi918sulUBDPfBieu9A3rkEDqXfDt5e?=
 =?us-ascii?Q?hnBBGF1jenEdeYVmIPTwNSnXy9Z1fZisYmHhe/96uU/ewywmYLa8li+nIH61?=
 =?us-ascii?Q?IXLMakaQflDjj2rcNz9ywMoZHvGpGt1Ji4LugAOxnT/jc5DpCAtGf3PCRBh/?=
 =?us-ascii?Q?4jA1vGPqpKQKdIQo3dkEL4OTrDnn2BltVEZGiPrePjHBVHnrB2nkMppIpcd5?=
 =?us-ascii?Q?OLxrqX6asKg+umNdzaXe8q2O0m4hax0IOilHGLmgd7uof8Bftqi4fU3ujRf+?=
 =?us-ascii?Q?bIOxJ5+mvV0VVP+6rC68W7WzmcRCETq21FRjw85AsvGDa1HjqIXnT/S509xU?=
 =?us-ascii?Q?Nn2LpfwsFVI+pBcuTkWx+zsxTsjmRoBXvrMcjF/HDe18SbdOJbR0wne/yAmT?=
 =?us-ascii?Q?kfdtodx3y1cZMtkqJYChKMOPQOvKcSSzIMbuWP7dZuTprje9aQsZfxiGVjQY?=
 =?us-ascii?Q?YTolu3H4c3uGGcq2UGGPswEG9jxPzOf5fIlqfwh7RwrzMfQNwTFUziY7jlkO?=
 =?us-ascii?Q?x87LatqcOJtSgozSZ+LoC6rO3Z/bAn0/EQnOP8pr6sKr5bk9s/TAWQoH3d3c?=
 =?us-ascii?Q?/FAsJ98H4hGSQm1cPk7rrgflHyrKwACaEw6zHtRmQTqcyV/kcw3LD4TZoOuB?=
 =?us-ascii?Q?MTy4bZXsn7AT/oAMivkOe+dODziH+OpWLseiX/gBmExtzLuVzD7TZAseGl1S?=
 =?us-ascii?Q?YTQLEUuZuAubQJ3NjM/6QxF8rD+XPaUFdHgH5JcoiLpLkyUSEWn/JYLXYr33?=
 =?us-ascii?Q?g+vfKe1eY6NdEWs1aBGwSayPBB5iTwbHK2ZMmS15nyAP2lUqYQfJcUO7FgnM?=
 =?us-ascii?Q?ndzkWShLrBtld9TwKoPXxlv9JFEl+gnOAHBUirrsUVK6zq6O2kFRgqTXo/6d?=
 =?us-ascii?Q?fXl2J26UnegZ/Oh2EN+q8OKpMCpV6eZNaW0IVTgkFMLcf7albxbfNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZYtGKpLbW1v+DQ0aaUaMqDvXN74Kz0pGY2p4SdMaymocpIKgQRArZumWcGo?=
 =?us-ascii?Q?ICe8qJgz+0GgyJIXHlsQQHWNp0eEJdFfkmZVyM75Qe/5p5/ToSeVlJ+s0il8?=
 =?us-ascii?Q?2cA1iSgyFDjJ3HZKL/pmqqUpdpw5L3FxeKIwynGe0cUlSkY2UUu+xjw2z6Ys?=
 =?us-ascii?Q?uFDnsCa5FR2dwfQ7ozWGXSA7wkOaaEPSKltfWRn0tK7TugP1RaCzW1VyOkTH?=
 =?us-ascii?Q?DrKmhP/HRfqsYv19kWeyHR2WMTca/HMTJb2fKCIgsyFL16khJSTufJFtegQ/?=
 =?us-ascii?Q?oaNcSAI++K+jhWjOqQe3Dem3rypj9h0gJg5CrVhWpvxASfZNyVK22fbIuNfr?=
 =?us-ascii?Q?A2aTyL+PKd0hI/FTbiHzCLLZPLbzu6gKfOTho6bCH4S24lpEZ8sx7mPsqjoK?=
 =?us-ascii?Q?YxuilQXUOVxQyNB3XII30WXOWxRP0dvPOCQsicC/3Fk7mCCPVbE1ZS3NRDuc?=
 =?us-ascii?Q?uJBurXxz1Lwu8D1A1qw0AwjT5VMcx70VFR34mpRG1fcPsq5iqkrC4OqSUX6I?=
 =?us-ascii?Q?1aaUu3cueIOShsvQdAGufY78e70/B6QHhQs6/8Yn0Zy8qwbugTea5NIOWZm4?=
 =?us-ascii?Q?rKqclFQEPApJeMJkMzl1Irkulpl+76t0929Rm3dREFycirmVUrfY8+cardyy?=
 =?us-ascii?Q?qspNl/Uv43lqcXyDjwx5SPo+aj7XU6URVXvyE+6Kw1w/+8CS+QNr6IAEtFTs?=
 =?us-ascii?Q?RW2mx9hRRjUVlAqAMpw1L0K5ijyGNYh9k2iQ9cMJVPTxRi+KKenMgEQGOe1B?=
 =?us-ascii?Q?R1TrXvC6RnZP7NIboKaX+kaWhlR35tAiXou5LhYR3DhPwd3eSbKTSDf/rEqk?=
 =?us-ascii?Q?KDA/mJjIaLqRiRpZrAe42CzUMxeACM4tOV2Dt2Fu4JyfMWRxQ5Gjhfbxf3yf?=
 =?us-ascii?Q?QkgnAr4PZLPX2OHd5U24HkYg0KIMxzWHg886gGQlg/bHg3pP5RzQZp79XnS2?=
 =?us-ascii?Q?RorV+MiNkMO1QyjHxccRAuu3dwDsJTC1JbXtBxw64zSPtyl3t3sR2UqQZcZx?=
 =?us-ascii?Q?a5P8hWal0tJ5L4uynrZ9hiV7cPEaCFBQhVfsYSCpLvzbabxOt6mnGHaU3AKt?=
 =?us-ascii?Q?NHPL2AUps9diQK3XcTDRTWC1gul1EoZKQF8wZxzAqyO7KNb+FTFFmwIvJ+/g?=
 =?us-ascii?Q?OeDbishcXZt6EFmzpE63y/pwQYJXMTXDL0No4d5BYGCW2qiXib84n9DMsiRL?=
 =?us-ascii?Q?T39WatBQuWcSf+Wyl4A7IpdW16nzvFT5A8O1JT9MnSwkYYsffxHVU9maNeOs?=
 =?us-ascii?Q?Cury9KFJL7HOXyqrQ7byeLnWhiOEIYEFjv309Nq4yfROn18FTucZNRp7cT8l?=
 =?us-ascii?Q?DYuTSltN7rjHaAfUpWf0PPcUNsHa5bffseV4uTRTx7+we8cJFHEZSrf9c9yI?=
 =?us-ascii?Q?dOHnVojYPbaG4LuWtLfxfkTb/GZuv9pyLE1ySWHkCfdHYrTzQJIjVfDVSBXJ?=
 =?us-ascii?Q?YHJfO78KrgFu2s0YL2pPHCLTh25YqfUSH6wZJYVJrnbxD7mhvTeqtibwMEQF?=
 =?us-ascii?Q?o/JRzyl7FGI/rXiZ3utISuX537wCWI6eJAWXvmKawcYY5aIyMncohZujiCc4?=
 =?us-ascii?Q?885SrWWTbexqQtlW6Jk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859e3008-4d4d-47de-72e4-08ddb30ec6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 11:03:40.4861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzmuxuxJRKhhSzAYNWxObTBqwJc+8GbuscCiS9OhUMKJxcM86KmZ3/pub/tgMdSi5IhjxOrJbpIw3O7L0/8JMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371
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

> Subject: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip
> of build_container()
>=20
> From: Alice Guo <alice.guo@nxp.com>
>=20
> The value passed to dcd_skip of build_container() should be obtained
> by parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
> data needs to be skipped, in which case dcd_skip should be true.
>=20
> Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")
>=20

Reviewed-by: Peng Fan <peng.fan@nxp.com>
