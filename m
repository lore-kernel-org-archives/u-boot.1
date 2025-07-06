Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9818C83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 13:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FD5810EB;
	Sun,  6 Jul 2025 15:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="n8kQ8+Zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2E081D6A; Sun,  6 Jul 2025 15:07:50 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A25980FA8
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 15:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdqq4RJSCQnGvhtik2dYOMtc+rZBLrlnKlhlrYmt2cx61FPqnac/pyp8Q7PDkLrSJWi8ih8dawT2sR2GPPXzRipqqD7j0hMCqkCADo8+2d9JmYhZyrzdRDbh4B8T2TvLqJaYzIZgv/ksOO03kQqlfvqKJdCtu8tRuvISYXlNNIq/S2jSXFcQuI5ZN8UdielbAPoH+A+0Zzt/MwiJFKIUjhF+lPiTSLHEXrbBnb78SF7jjLLzjRUQMX6EcreRRbw4Z0mkbLVUaYuG09QaHyxBArKG4Xnq85pWK7GEPKut/CH15MaptZJ8rG0wSPAmT8x/njxNDCnIsakUxVWhcjF/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYP3woHXGqOtbbU0G/QQxExrIxKJJqOmlWuwecL8rwo=;
 b=A0pJglip8k1UG2elG4dmssNtB12zMwnLXY9T+CuZxriViyHxd4/GBCSzzdT0CL+/yDg3D2ABcpJXXsG9AWQctHOfcrPRLMLzhNajUBH8fV+H1rRA46FbYlkJTTCKtRYAnWt8WHmGNKxg/KnsZ2IcQCyMqkNEeUtyKWLtbo9p+95soREIj75LpWCyIGTeRlBZzxwl9ytDrsg5wjsJKlPFpOSuk25CCYMVafw1S8VkRwa7ihtTRmU5dl/aWOh/eDowA+5fkJHYZ0hZBYKy7I6Na+udJ0YW2+A9QtLDBMKeh14f/CkK3uvOCU4aU4KDi7gdsI9PFppV5ucfJCFxAr0/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYP3woHXGqOtbbU0G/QQxExrIxKJJqOmlWuwecL8rwo=;
 b=n8kQ8+ZrVWBL5g4mxAKPs0Qz5imiLiaqybbzYUayjtHCaB/CPL32dMBoE3IFVq3wQqs3HR85Tofx5vrPvE805NO2vPwxHxojJ2g2CZvq1+sccikE56GIlZ0sOTy/KRseYgJxIpeHbKhVlbFSOnTRj7uIrvl5ZXT5Mc8v5907Ot3Z/mxWOlAdG2J9UM0ZCw33XuumRl8lSIxEDBpMEXtkt8YqoiS1jk7oBgQu5THSt6v3FfJBbQH4joxqKfcbCkknQkiRiLWKK+wfK0do2rzXFHoASBhGq51nsC22p5M7S9LKwIGrHGWbCuRmDX4v5KG1NN4/npzQoGPh8OZ0t64Pzg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sun, 6 Jul
 2025 13:07:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 13:07:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH] arm: imx: Remove the rest of i.MX31 support
Thread-Topic: [PATCH] arm: imx: Remove the rest of i.MX31 support
Thread-Index: AQHb7S0OeiJOeSkUaUeHnlRjCJPdD7QlE3ig
Date: Sun, 6 Jul 2025 13:07:45 +0000
Message-ID: <PAXPR04MB8459A57464A61BC8946F4EB8884CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250704214600.3418869-1-trini@konsulko.com>
In-Reply-To: <20250704214600.3418869-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8096:EE_
x-ms-office365-filtering-correlation-id: 13cd642d-0e28-4110-d96c-08ddbc8e19cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Aw7jMHEvTa5rah+PY1Of3/l75WGjsA62Ebk8esWstQxQzvXOPoKSfFyCg9l7?=
 =?us-ascii?Q?gcUohYkwqCe4p0OvKvA8yOToyHcry/15e5kLCLuKYZlhSieSRHyp2WyW1Xga?=
 =?us-ascii?Q?eryvCp5qQuBkp78Ni3Crmf6ob3lFmVPRQcjPkBAYZgGHQMwCkJJYvyC2i4+C?=
 =?us-ascii?Q?WVzR9j1ZJKn5Pr50Ga9EdKFBgv3kVLy9CIgyHvHaF+dZVnlS20XE4utjFBQ+?=
 =?us-ascii?Q?Eobm3CXcE04hFrVACMZG270tCJn474xbSVTuPIPh9uSnkb3LB6YOQ3VYcGUd?=
 =?us-ascii?Q?ixFqeNe3+U9kva433VdCNMKbAClCZkGYWdvrBnQnV7jCitU6k0ivKwpH1pH/?=
 =?us-ascii?Q?IrIvKZuU5CuvyC6y5tZ/7AnnBVB5RQefOyahM7wsfSZtaDmWZ9z+NwLSy+Hp?=
 =?us-ascii?Q?DfC14dCphdIVrXPSfIBea+Vez4Aa1A1hgvRn3N4/rvcveFeePL/bgYHrqal/?=
 =?us-ascii?Q?/Rjck3CyJp2mj5DciOYGp93d+BR/W2CBcYl9EnKlBowhaW75Et+xmTAi2PEl?=
 =?us-ascii?Q?FjWw/7CYKEpxfdBMz6/SINNc8JWtjdoQDzGOiqVophTKryH1OAKn2kDUHbFc?=
 =?us-ascii?Q?p/WbitGlOcDooJptJZSa24G1tHrQzX3ybbIocWulT1hM6Jf6TV7qL7VMvwhZ?=
 =?us-ascii?Q?Df7EHTevdU6vrUe1SmWk335Cvr5xv6vjcIVbN18Wtztjvfd9ry87h8DMn1MC?=
 =?us-ascii?Q?KNAddy5h6szAj09bVL0wty1dVDcabIlK8nsWqGcYwELAV/xLPCTIeTgUwgfa?=
 =?us-ascii?Q?roIQnGjR0nBBSWoyFNh/hz8nrgZZquLLWX5GPFDnaUJs+CleHoY2PiAnjkdc?=
 =?us-ascii?Q?CJZ7XH3QhQxi4qDRcsoQlku5wOTJ0k2loxAI113Hx5shSw7636RCdFoJfKkc?=
 =?us-ascii?Q?VFl6dYbu6w/o1DrE/WljDhtCAxZlttpUVqnxEuKQa6MPZxJ154ypmg14dxAS?=
 =?us-ascii?Q?eg3IUTvttPjIKwz2tP7snFW/hB4S2mqt5SEdYxS7XKVXS1VFNgXNxsxUeyvV?=
 =?us-ascii?Q?Hd3jSgXTwmnDeQYJCOM1NahRCaXD9EDClxlL2Qm7BYjskkS418HKPVXuUoXq?=
 =?us-ascii?Q?B3NTGcrpvyg8MnP1/06eZAefoj50LvQSvbEhm7tgMnUL1erm9dbpe7nQ5evB?=
 =?us-ascii?Q?yRe/2KtVsVdZOIMEzbQ8DSqB1QD7dDLlc86uoB9mJblp0TA4Wn0N+e8HuJ2k?=
 =?us-ascii?Q?qoCJFcr2/AsEA9F7//2XJ6VgnCJYrbjtq+CI8gCzi9HSMtDpt96g/kDKUH02?=
 =?us-ascii?Q?id7QIPHh/n8lO1nKhcYZIUa1ZZQirYyL4EE8tpjjkdiV5iCQ+ex4rT1wtEXj?=
 =?us-ascii?Q?Fvqyc2/ApR+MZOU49k3tM/fF0bCzMNzGbwS+LCgcaAgVP/2gqon3ApdNT0V2?=
 =?us-ascii?Q?Q6BCv1gvP4nMtkbZf4lOalsQhEgO2Yw9EOX6S10NORNpbgUaetDeeKV8/K1Y?=
 =?us-ascii?Q?o8T00YAxNevyE+PTvsAN7V8tZEGJ05UgbhrF1nt+nZzB6KC3mzK1Vg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S+V3nw4mcBqwgdNlYhR1hKhppjNx5wP+pBI5VJ7kRD2dnqzbLwQAfRz1y/qU?=
 =?us-ascii?Q?8d33A3rZceugezdU6P7kbHuOBk45ilCD51MzNugKnVaduUrJm8olXJO7uXjQ?=
 =?us-ascii?Q?KoPpFGRbEdz4gojvAoZi6KNz5Ku84v56tZJPpZlGXPrmj6nPkkFdddHG92wq?=
 =?us-ascii?Q?SdaQGHNrUVNLNq+JOarDLHdvJ8B7/dyNu6gAMf/vRkb+mYMurLz7I50JopYG?=
 =?us-ascii?Q?H5dNAI7bJER3/40J+OvkJuAxmC5oLPy5GFqOojn6i7wEb1wlaGX8pSlYKssr?=
 =?us-ascii?Q?8pwXL2OWQmeNucaWPEU4R7bFEPBvmLnM4/z6tD9vYzBSStNWyCamtqpb/cfI?=
 =?us-ascii?Q?L6Vc6LEnWQIE3H1asioADqtf5KQevjTbPmIWBbeF1sdP2CvrWIbMrd2LeVf0?=
 =?us-ascii?Q?Xc/3DQSfNgcwxu253i/Zo9m3qRIWIkN+xTsrE+s5iq83LEPoRIJxUH8AehHC?=
 =?us-ascii?Q?W41N4lxLmtHJEBBBU6SuQ2QKCK8k8EeBDY07rXMRsoU6qJ3s4Z1DIP8bz56F?=
 =?us-ascii?Q?ftTchhc6+cZg/mh/SHljcKKnVW9mgoxK1EE9wGLCDHy7ATkio5hYjwkM8Y8E?=
 =?us-ascii?Q?dWg2YnsAlK36RUKyMCrZLUV405o3J61LKdwD2BrXwjf6rXn2xKcs3Ag3sAaP?=
 =?us-ascii?Q?r36mWPNtjPnOfUGjrU/qjVgi6u1e8EBOQ5OpJwAmWLIQWCbUNnm/WwnDgnYK?=
 =?us-ascii?Q?1gtT9E01aQPeZ89yjtiZgnV2FSbZVIWkLkxnhvpcXMnXdtVkSi/em332KqGO?=
 =?us-ascii?Q?/DlgDu5bhX0/Ndky1HNO6Txxo91kCWOXENQ+zuHVD8IHxhBN4U/aKuRUxczY?=
 =?us-ascii?Q?J5nQ7Yuv8lK6PA+uufWo/Y8IA2f5OEmGZh8mJlBCannKvMOGkpE+PBR0TPeF?=
 =?us-ascii?Q?PtDMplgZsIQ8hU5dchFox1uhF+qq9Xpo+xzpRkt98FBBQzL6HAh2iY/5SOsF?=
 =?us-ascii?Q?CYjFu9PXOFuFDsxsLJ2LPwuura1pTlFjRnU50qbgozrqmmqIm3qK8pZ51QYe?=
 =?us-ascii?Q?8uW5WiQChSTKXFDcgbGizHQ6NH5WrObTnNcSnXqlbMODvd3CNKe5sn++Y5uC?=
 =?us-ascii?Q?Qf071qGfHa/qiIWsaw6QF1o9K8Ai56MBPK4rhdtvU+QjFWrDp8fNCgkiKZSz?=
 =?us-ascii?Q?iBq0q5hvA71hyzMV46Hd6Mw11PPjNNv3J3p/tUR5ZOtHvVK5cDfBNIU5+eJZ?=
 =?us-ascii?Q?cTKBjlnWB2sIOywQZbPP55sLYPQl7NPfuioMJO5sAcIwU3D7A7EklFGzKrzV?=
 =?us-ascii?Q?elDOucVY0neAXlT8/I/s7EDmIQyLT40qhjwVD6Ppp1ugvs7Ingz9g/IrJmtf?=
 =?us-ascii?Q?eVaRffXStRXAKKB517Nj28Xmyz2AKSrKLmL+QMtQ42OYiDjc3swhAh+NLanJ?=
 =?us-ascii?Q?bM9VpY+cvit3AkNauLC8vIYWAMjMY6h70Gr2d8UJi61OeGDBD+yucV3eRIc6?=
 =?us-ascii?Q?5f9yDTbGB4rqc6noOWO/DzqC+sJ2Lu8s6bToIuIReDXDss/Fvc/VBIgRAbUI?=
 =?us-ascii?Q?KrVSIcNMH08FsAUKAGSjfDop9nZrBwrzXBIKFpevLOT/4drB8n2OdN87pdxl?=
 =?us-ascii?Q?+t9X29kayV2VJ47SjKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cd642d-0e28-4110-d96c-08ddbc8e19cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 13:07:46.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNYeU63GioFMPBuNoplkzsVVPyJYvrUmQMlxGlkCIcis63vCqRIyJIMFsIrw7I8kJl6tY+0wkrOq4uhvU9laPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096
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

> Subject: [PATCH] arm: imx: Remove the rest of i.MX31 support
>=20
> With the removal of the last i.MX31 platform we can remove the rest
> of the underlying architecture code as well.
>=20
> Fixes: f247354708ec ("arm: Remove mx31pdk board")
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
