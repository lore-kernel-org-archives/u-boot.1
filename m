Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA66FCEBF7E
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678DD88FF1;
	Fri, 27 Sep 2024 09:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KIRtlxgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD36188FFD; Fri, 27 Sep 2024 09:13:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6033088D13
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb/L94pO1Q1Xn8oMH7lSvhE5ywAOkk+QQHWxC+lDW1AqMurFPdxoPMucUM4DMkA6FKQbnC6sYvYxun5dNIHicheChzfgPBAoy8BxzrTC1AbXAX7UrSNH9ItqRKzt4sqFQAnBqVsCe/g8UW76Rn36EYhxSir/Rd0OiZMJ2gb+JDU24Uj9iinVTtoPtukXPJzSDchuxxUDvhvSXb7MZoosCEry2p8Ef+5/aB+3Hw4m9UTL2cwVut4UQkN+RZlTwiImaNQ/v2Qa7fa7vogkEist7jHT4yteXSL+MwTMK2fUbr4weorfVD5wpn/kmPX84892hygJKLVJkFjjuETUSN74yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGbv0yTQy2yqWfFOcp5qITJEzIiH7FDH2Hbu0jhDgEo=;
 b=komRNeG7OfGen9RvdZ+786O/Hc7MeEkoVajWNvSeSdsfsZADVYBm4NF2L2FsMnmjnTb2mLw3XSWYwUh4QBhawvLYmgntsbHyO3C1aEhsBirlhDeaBXOYwTpyEitrsPp/gEuwk0NtRR2cUwt99iez6uoFlsfIEO688W05JzI04RVad7rO99OJYt2XwxzHw9SbS20/jDK0QHvUiNkKJh7UC0bq7qM/h/S0apx23PldGI/ctpGxBXR5MvvE5EO6Hgb888b0TvYia9SYfPk+Tk8Ne83OoyFFiJIePvvWMhBiRzP+YEd9IGXe9VsvO/dt3AMgZbWUr5MoNkayt1tVkn+4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGbv0yTQy2yqWfFOcp5qITJEzIiH7FDH2Hbu0jhDgEo=;
 b=KIRtlxgAPYJOOjYgZu0LJ/gv4VuqdhYDnz97/tNhqOFu/jKwKRwPaHwhKcajtv4yevI14Az6uycMA55+eqSBzs+6mzc7Ndrr/F7gjIOtCEKklChFWiqxILvEogQK5H86OQmzyJJU2W0ez2SFIVZOqjobxgDuLqcQxM+1n2pZDfcr308D2V93SI/uI1ja6AhJlpWbDVsjR//xbhNhJgLsZnng4cQKw7eYbXYAibAvixMBV6Q/4sJFzHGTjy0Ud1hsqLfir884pwS7bhJiZA8cZ40WFRLIXwL9CTnK9ovXS+dZYSF1KyN9KtO+6+4FSPJnk0Gj32YiddXH1L4vGt7epw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10758.eurprd04.prod.outlook.com (2603:10a6:800:25c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 07:13:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 27 Sep 2024
 07:13:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Max Krummenacher <max.oss.09@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Max Krummenacher <max.krummenacher@toradex.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo
 <alice.guo@nxp.com>
Subject: RE: i.MX 95 support in master U-Boot
Thread-Topic: i.MX 95 support in master U-Boot
Thread-Index: AQHbEB5x8nHta0Bu9ECWZ5mXPUnKKLJrOOkA
Date: Fri, 27 Sep 2024 07:13:27 +0000
Message-ID: <PAXPR04MB84598D7DFE32529565E9761F886B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <ZvVsUcglRde5nZsD@toolbox>
In-Reply-To: <ZvVsUcglRde5nZsD@toolbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10758:EE_
x-ms-office365-filtering-correlation-id: 59fcaaec-832e-4ad3-57ae-08dcdec3e223
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RpVweUZnLayAWpqAQxhbdE1MXvWzQAV52fAn8oD5mGzKigRPdv1/HhpxMog6?=
 =?us-ascii?Q?O0QGLuASp4vWZYd13Qg4tbf6caq6U0AHw4VPyECbUfOHlyWkr94SnP7slPQ5?=
 =?us-ascii?Q?EDoswsqML3LyqmGYA64n1277ljrqexPlydXIawoR99sWGhiUurX3j+6db1lq?=
 =?us-ascii?Q?EF38POGWeQ0p2bdsz/eQyCNTUFoNl3csyRNbaftpO17qOc+5OOXK0M+v1hHO?=
 =?us-ascii?Q?Q4DulRjmnSIGmkJ2vRwgsDLEW4iWQFrwc+KDOfALQqXd7AGvtRoHdh9bplB0?=
 =?us-ascii?Q?jHj9VPoDqe1ENJLZUCmmp0mKe7W1NS/8fTag1pUWF6awS0z5qMvTy8gA5Zas?=
 =?us-ascii?Q?nlHIXYmdNYd6cW+AuAY3+7Ixmi1vX7khwSPIC6jWr362SzbSBG3wYYc1vCDP?=
 =?us-ascii?Q?utTkB/zDWXDBpUQOeB9PzkvcO4aSn1cFke3UxmxQq6fktgfTRyCN5F4l/bke?=
 =?us-ascii?Q?MZo1LlRz0B4Q6PCS0s8E0/gbpdxhM9MUt4kQ4buWtj5Dcv8Cox7jUZ6Czhf1?=
 =?us-ascii?Q?fywNU/tYuGFbGr3xMkNv9frbtN0VzQPrIKLSf8fUPFTqureutapCCJs9aQxL?=
 =?us-ascii?Q?1Ws5pU+Nh6NBidmetI1WH48OIqAzdrHJOe2B2FAac8quPOAwJSGyirHItNkK?=
 =?us-ascii?Q?/9lOlLL9vTZc5V8fnJG60udE/f9D4Qy0tEGTD9TyDj/RFuGvk3FkR9+GBwIc?=
 =?us-ascii?Q?AZ5vtPE7qEQQXFQJRdy7YX3AjPRKY33Y6TAqogUclV9vcuo/jx/rc62gWqo7?=
 =?us-ascii?Q?xRCocom3+eTt5hNNJYX2fH58quKuM8En3wEh/ngmkZQLjpCKEy2FIh8ey3MB?=
 =?us-ascii?Q?sHJYBVgOsjloJF2HLToIKhmgAeicJZ0o2AAq8zuFAvBoNkD2BRXjk9hu0PPZ?=
 =?us-ascii?Q?pFV6geDfE4l6j1G1jvr/iv8HLOGL1VqIUpOGU2/Lq7+RBVTJX86x2yXMaqYn?=
 =?us-ascii?Q?THvNUU3EGB9MOTEONEA19E59Jkj0y4lsHFlu5R6rresiHl9YC1KDRhSLOi41?=
 =?us-ascii?Q?PZBFowjTD7RNuMAGma0O2l3Ae+LU9H0rdBhOcfju91RgbrE69H75wjWI14La?=
 =?us-ascii?Q?2dL/bYhJaY50lZbHEKZrPzoLHKT6b7z+PvLWE1lZY7Zdvfje/1vWhny1j+hN?=
 =?us-ascii?Q?ETCbWIC657loc3Jn74dM6SqBBOpnvPnnWLLO2a6TN9mAfrqfTmgHnz0zIWYf?=
 =?us-ascii?Q?wTmvlfzWz7Pq0IeRQXbW5IeLhL9srBCGqbvL7khjIoBo1GSepyFvGQzrDWLn?=
 =?us-ascii?Q?x0LiW9qR3srrM5yfkx0oEOoT9ZTscLs2zPRfuRdm4NqVQQP9Lc6Xo5niijom?=
 =?us-ascii?Q?PpmwQZ4YcbMLaxcr7RNIJ6Mwjz823RPVeLgTgrgxX4iO+k9X7/VnFg5pjv36?=
 =?us-ascii?Q?zMS/SfpPdnb67Ur/wRWkm65UNMuiUiX2C/PdqWZkXeVHqZqPNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?it7jhVRIO+z1YWIdeXTa9hCpNqEMaz2Dt8VQfq4Gg0Pqo8KuEE9PDlYqFlaS?=
 =?us-ascii?Q?5VQDJm/psEIWxltIC6eAW9o8IJp6HVdvaxb3aNzz4L4wWOaANzlk8vyL5kRz?=
 =?us-ascii?Q?CjON6vrGiKAHFkjxiSXV+dJCg8o+QaKgphOEhPriqlFlYsdWX/afFEPKSdfM?=
 =?us-ascii?Q?xaTcegxYxsHHWSaHah/0fuSI5sTtZgNgN7XdFck/FKCNYQ7LC4JBCxBSU7oS?=
 =?us-ascii?Q?2rTo9CfqCxASI6RxD/aP+P2NZbsTLjWdYZ4fiRTH4ZzBvAseJe0CHyOT44FC?=
 =?us-ascii?Q?um/TLZmoFUCR++ivinkQuyqyLRuvNFXT5c+qyJwxm4ukI97gNkHwl5JbVMz+?=
 =?us-ascii?Q?qk8DB+W5f5A87YXWEWyTT27xBj30rN2dnGOXQL6E9n5jy1HGqWbCq/HPSu3W?=
 =?us-ascii?Q?mZSYpSMcHeEQ+X1T1GtlMo9tDhw7y8rziqbiHh5whx4NoFk5PpqHgsaTHgv1?=
 =?us-ascii?Q?wTVVj0Rq8AuyWYjfAnMGhbfl2utzWsZ4FdxoOflwDMxs151ySgtigAew11uf?=
 =?us-ascii?Q?jsGpFl1HzhG0Uc6dWf0X33TSVv3E5M9p6tI415XLV5X6Y5uSvJcqf4TVzBGk?=
 =?us-ascii?Q?O4hfqq1nSHPxkOyyQZp3rkWZO5f1RIFA9ttoLYjVrA3CipBvFsLQ1ou/crBd?=
 =?us-ascii?Q?GZdt9mQKAGsX9FlAdkyr6m/8btAoPEYQVcmgeGHWtJl1U0yW4QhYKjtiqX2r?=
 =?us-ascii?Q?mDxM0R8fLxlXF00eV254yAyILFsxNzw/nqzO3clVKph7NNJ2QiGy8OGuUOWH?=
 =?us-ascii?Q?1rTVlY1+ZpvXRQfDe+hEauW3pkF2SV3dcVufEOnb2ViDfpkTHLvjr279giVV?=
 =?us-ascii?Q?e7usrHMVjxPUgmLW9dZkSyVDG6Lwz6ROgUD5lRB8jSgr/HvzdK/8KhZ9i0OW?=
 =?us-ascii?Q?palqUjpCUh+PgC1hnwi7htBHS+ZbkHnPiSwqccRZljyVRAb2wfGqw2/wM6sc?=
 =?us-ascii?Q?5DtLuPaOrXZjKsq4pwlfVvj7dWLvOPBLTJdx2S+JV+Upl9D+WSbKBGkNX8AK?=
 =?us-ascii?Q?ATu3KBRz0gts+nf798n8DlLptXVrmofQrnY1mXU7sdf0wBUxi0XfMT/nz5UO?=
 =?us-ascii?Q?Gs+3TTIOnMzMfsIFSTYLftGeJHilSpwCxZfztHA9Kd8Lz8Z4M36CygwmXxTl?=
 =?us-ascii?Q?ZuW6Ghba/efRm6ItWLFn0GEpiKcEL319FTyhk3C/jfg5FeZTe9GqeooXSv6j?=
 =?us-ascii?Q?KN4e3WiY/kyGiiB+pQbffh1LhiG7ZOZ+KHD19NOBp6LvHa1PtgXE6K62h6eW?=
 =?us-ascii?Q?abYfDbt3Ls4yVWdSsQHfZXgPKeYwUruzkpAMWBlQh8gY/j6fY8OUBLDoVo17?=
 =?us-ascii?Q?mCZyWKKgM5FFnGZ8Q/LLKAXtBR0ZEeFBfu+w7uP/WUZrQGakFkot09lc9CpH?=
 =?us-ascii?Q?Rgh7n4qkLAl9PEfJ3iEsIdGGjSpD5yvvs0X0+R/VVJGTgia2G7IAwxVOnbx7?=
 =?us-ascii?Q?hRxjiQOTSE9oLR1tzoAECgOCih2FzkR1rhSy2NX4pp0uPKa30UeKp2MHDMtq?=
 =?us-ascii?Q?3I+NgNdtGb36GQG0ZlR+jlpqjreK37wogZ+ewtP/oAB99yQ8jKhhWMWavnl1?=
 =?us-ascii?Q?B5jbuN7cPIcWqNLx9Eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fcaaec-832e-4ad3-57ae-08dcdec3e223
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 07:13:27.3166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWHg6uRtPLcTHlTgvTXmGo2IykaiPwnsfHVdRat2YwWqm45LZUK9O6KiMDyKglD8kEo+ETFzo5ChdDQ8SAIkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10758
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

Hi Max,

> Cc: u-boot@lists.denx.de
> Subject: i.MX 95 support in master U-Boot
>=20
> Hello Peng
>=20
> We are working on a i.MX 95 product.
> What are NXP's plan on adding i.MX 95 EVK boards into U-Boot master?

It is under preparing, patches would be soon to public in one or
two weeks.

Regards
Peng.

> Thanks for some feedback.
>=20
> Best regards
> Max
