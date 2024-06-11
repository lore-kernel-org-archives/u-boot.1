Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E639C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 00:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A6787F13;
	Tue, 11 Jun 2024 02:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jYNFXA/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD40588261; Tue, 11 Jun 2024 02:42:01 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C4A87F13
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvWqBVZsQDg7evmLAYSxOzTHqiDn/QNviRkDLz7RyAaOTrHHN+2nHvXPUE0OeRFlgEHRikx1jsDDEPm/ALIaPD/7Wc4Lj0jykm0LifD004ebgkojjpHngWVvXqlI0m2OcsGJ45gnU6CfXiKpnT9gILf+7AgZpopX8meAVS0q50MCfsCnagp+U+5+QMjaiHFH/I//fj062re/thsg/fDCoQMmoDO2Ex2MoLl+YrMT9moRrLc6+0NMn+UNqAVc9d2mERSXtGHD0Hf4i+bHBoCMDefdMhfXxk658rE++r4Nl1+u1qXLNRr4IKN+Q/21txRv5vS7MEfBscwyB9vWWMRUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3JD3uuyul8PdwzZsPLURs3WlIalGUuz5cxLLUguStY=;
 b=Ay2w6f4xvF9ZwP/QsQneqmRGaD1ZzQgsFoCin5+dKTnS5CFDH5cLbe2O+2jEGS436+eV2Ern3TkYIDwYHoIHti51PtbDhDXyNeS2coG8WA/XmOhy1YmUeRuxv1fxn2aIsJKUEtqr6U4Cz9v9b/lHDBi3z298VWh/YatlLjXfjtoXioqjhYXVgyiPgu9kZ6xKWIMhAMAQcKuM+yzze//bYfv2FnW1nSskx9gXSx/vOOeyzV8aLiPiZylh/K1k6t4k50WJ4U0P4/fDqw6eMCSUbpkFdMIQ+Y1VON7q2R8dVNnKPn5gz0qdHxpJrrl6A6UMOVE92CJd48kSQAVxypG59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3JD3uuyul8PdwzZsPLURs3WlIalGUuz5cxLLUguStY=;
 b=jYNFXA/tMT6CdOQiIhNZUDaim8EplnHOz7inyE0tATGGXeS8PPOIeXrt17BVH9G3wRP8dd28NVSmQAg+xRqjUMF2YDTUq7xA8b3cBgWiQQ2SZyf56IuFI4+PdndVTeljUd/NIex4WN+ID4zBcOYy08xtEtXk/hGJ+8qkZodVPwM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10734.eurprd04.prod.outlook.com (2603:10a6:800:25e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 00:41:56 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 00:41:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>
Subject: RE: [PATCH] arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
Thread-Topic: [PATCH] arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
Thread-Index: AQHau3xp74aaDBAJ5k6KDS0yrq1TSrHBuS7g
Date: Tue, 11 Jun 2024 00:41:56 +0000
Message-ID: <AM6PR04MB59415C2EAAAFA63E12C6F3A388C72@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240610212209.277486-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240610212209.277486-1-patrick.barsanti@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI0PR04MB10734:EE_
x-ms-office365-filtering-correlation-id: f377b975-f8c1-4d96-d1c0-08dc89af4bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?qlpPgPO9biZi3JxSYapNei7uzKLpLct+9A9IyZczhLBNB6qmiE9zDXQk1t2k?=
 =?us-ascii?Q?9eRXS3xR3x0JU8yVj9Wpazo1pxpOc+0gYwWF6LJkm4aZ4U0vdEf1WC2UMIS4?=
 =?us-ascii?Q?5GoveiX/YtnvEekTX/j+ceW4d4ZxKFdO+ZAAFPZut9w1JGiQHJ4Int8VMOJW?=
 =?us-ascii?Q?pnXAiKDHo2DTZ47FQ5e8p+vv2kHHKKONikfAMD0IjyRkUCWp22Dl0k+ngAe1?=
 =?us-ascii?Q?+qoadBZSC5vNG5UdK5BITVcEGpcO/KmrKRLFKNmQijkZXmQikuTo0bl4g1pW?=
 =?us-ascii?Q?VzxI/cOfAg5YPL2qJjn/wtyiphwnqN/I6Atg1wtjydxm+zD0ZRs5dtsJ5j5T?=
 =?us-ascii?Q?tUwydSZiI7UL2V3tS/rz8qRD53UfYIL7/vswJAoTQZaUfP2YzIdsPNyqjWJk?=
 =?us-ascii?Q?9V8fvUNP8cpbcNimVkm/v5J9R+QHOem2jvQiAHyaOMVMc6QaQMQdjIPMtagd?=
 =?us-ascii?Q?KJffHQORobgZh0ESjRwB5Pdq4H7uipn5Qyqr9nS5jGwJlYp6PsBRYucfr3Mv?=
 =?us-ascii?Q?D6b8xmEQzB8AoDZAntwEY4J9Uxbgmjx3hkKkTXetomwaJ5w7Md2Q3y5sdVDI?=
 =?us-ascii?Q?p+duD8vYRtT3IEjBHgKD0ObF/Bc2jd1/zqcBbpVQ1QsajAYcP28BhPpzk1LM?=
 =?us-ascii?Q?5gCbxuwrARsvWle5so7sRb267nY7thYly/T8rF3aOAIOliiHJ2WNHU2aGw0+?=
 =?us-ascii?Q?YuMwAD0DfQ+IJDhkwEGnQPAkbfmOdI6pdHXDAoypeJk12pGGLW3klq/88lYt?=
 =?us-ascii?Q?8dFPcrd5MXFvzWv7X7d3BsXiF8fL02fAdYsHutvVKpSj6Rms5WDRRLGKq9y1?=
 =?us-ascii?Q?i2+qRYYP2jPcWkAuG+aTgj+4I3UpRYfLck1Aua7Zo6j+kdgiIAwQB+/pXgIs?=
 =?us-ascii?Q?T82u/89eyQY0Cd2PmZHGCGyod9uhs93vIvtSqWarAk5fEVPQa99yqcDBklpj?=
 =?us-ascii?Q?UuohAWJ99IuhZ5OBDbGu+DtG+Gl4cc6CCm08FwrcGT5hcXzdOvkCQJ9l3bg8?=
 =?us-ascii?Q?3Rs+fC3MP7tunbX9OKi7uXk4XUC2TJJErs4O3YqzWZR0ohUqdpmDS0+oCSeY?=
 =?us-ascii?Q?YXT63PDcCepNVbD98Jz/nBFC9Xk3OqVju86o/IAPomYqxClNbwP1F2LjZ2Rq?=
 =?us-ascii?Q?9A3S2yszQJJl+51fzSchlu0DOGt9gS6JcGU1REoPwzALTN+fDewhr+VJsV74?=
 =?us-ascii?Q?DY2UDEJjNdKS6BfU/C07yTPj8/qTOXjZfDqbYUTQpAJ7DdpFYOf5eLv7+wiR?=
 =?us-ascii?Q?hiS5hau6256nbp9usm4VjWm1MLgoJzwqNojkdL5cd/XUdjj6ye+KFJFm3g5k?=
 =?us-ascii?Q?efw86rPe6tAHxkI/x16x5kBD3s4rc2F4Mvxe3FjgMGrB4qlgnwk0b2uYlWw2?=
 =?us-ascii?Q?Dz4091M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5941.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r5Qsw/cadjtXzxBaoEdRfeVFmK+nHT/+WzoU7VjrsGzaDvKRgdGz5BMnP6Ot?=
 =?us-ascii?Q?22Mq9VgQ5N6j3w5chd8WxoTJ9HlGdb34Cb2Z2d+CvGK6CgUjP3ICml9RR+K2?=
 =?us-ascii?Q?mDHIOP3fpYQ5f4wUixWHi6oLw6dY4WpFRGhuOSUHi2ANOXJfScCblL2so09y?=
 =?us-ascii?Q?BY+Pi6RJ1vjw42Bg9AKFlXmQtBke5TKzcr5sIyctgl9heHi3sUZRYRNCIvao?=
 =?us-ascii?Q?FO8gZE6+P6iuDmPAQmCq8ob8i3AXWBmaCkjSnDkaIfVlfSRAu/jk7aaZZWFN?=
 =?us-ascii?Q?v0jI5buTfcDuKsjYbB/Yapft/AXpzmSinvSyD3bgv5NBLX8ALMcGMDCl+gZa?=
 =?us-ascii?Q?khbWS0XN9LKByellDjdUAFCYeUCRamGNTG4Re3/QP9FL79WNcWW2HrbMfW5C?=
 =?us-ascii?Q?h/Pw0j4+XjNQPteUxBUcljnOms4oaatG3XnjKKke4DeXRAa4TVpm080POS7i?=
 =?us-ascii?Q?eLscIcH/K3tyG78ZwKFwZeLv0wqssqP/ssu+nkmOcJfGfAW3IeNh1rwcml/5?=
 =?us-ascii?Q?XdbjDwq0ZAl2wJBRkoRxHRKCaJpBULJBGeHMHCW9AVp+zHRqyWAbx+rh6292?=
 =?us-ascii?Q?lkYw8gsulk8R3fvyXKDW/t5D1BBB7als+ztWZUGcSCH620XGJ2sVwncJ89se?=
 =?us-ascii?Q?t0bDB82QOvn4Od265tAeyY3IAVu9sTeaABheGO3RqkZFL1B/0Y6fphM+c6+D?=
 =?us-ascii?Q?GHFzfehkQwjCHAvMy29EqjVWj3JSwbeqXXpptpqzvN1WNed58VnTTTo9698w?=
 =?us-ascii?Q?gS7Frc90jqSUogzcy6H/X5cNJlsfPGJ/TgjN2hzBKKAG9qVnf5rvmyMWKIrW?=
 =?us-ascii?Q?hwkpEorG8ZNOB2BBwiuLT5k5laaBSU5GxuQGdemGkz0mrTWBbiQtH1YrSwG6?=
 =?us-ascii?Q?6rsNZnd5+TUrlthoM91n0fwgUEV4mUn3l0szZuBWtv0QYBAS5Byp1OygjBSa?=
 =?us-ascii?Q?NQdLi/5G2heeo0j/NZotCvhykGMSmc+bAXxFq5kU+EKkxBn+++7Nh4WOJ9DE?=
 =?us-ascii?Q?01KDjKaBOENcl0E1y/9bCbntRdM4Bb+L7xNTKKPHiAFNBssr6NFKvYc2uXGG?=
 =?us-ascii?Q?dNdXXWQiudIBD1KWF+XLdPAbD9YAc8fLZBo4VtOIN/bR/4IqjI+5oAnKSJ7j?=
 =?us-ascii?Q?fVIIheSSUPdhFMZH47lsz/UHO4mhWzw6GoVaj3HpS+86GMhw5LXQQnNR2PDf?=
 =?us-ascii?Q?PjTGNRIaeDIvdx+QoVbO7ZqclcR/uqF/si6UAca15tAL9b+IG4p5i9HIh0xG?=
 =?us-ascii?Q?LYtHUFpkalP31o0LYJmX0E5XQABYQBXZuZpkWPGlkQUJfzYN/tR0Zjwr+KTr?=
 =?us-ascii?Q?vEx1FtDwpQUeJJjAhitHPqbUBV0+js5WGY9IuHGFesVZ9AZ9HtI95Hf3WjRJ?=
 =?us-ascii?Q?MX1+UOjcALs6naIjFD9aF4LkACE3mJXeokYi+9HGNs0CFH2I4BEKGJ18k1QZ?=
 =?us-ascii?Q?CeGbVDr+GCn1JsMh71vEEJcVAigF55Qb06t+0EUnQ9tvV9Gkn0r+eh3oFPGF?=
 =?us-ascii?Q?4XBBwCgznydre3Pd7/WKTZ75k2rlJMcCpoOytTAH7h8DO9AZaGyOR0NMN+rS?=
 =?us-ascii?Q?YuoGw2ka6ylAvYEqeS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f377b975-f8c1-4d96-d1c0-08dc89af4bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 00:41:56.5908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEXXT65QUZwgVciXpXogsrllA3qxlPVdp6+xJYVPIlQ6mkCgcny0jjxVfFJULocf8/Av8hB0HnQRbE9nEYdHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10734
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

> Subject: [PATCH] arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
>=20
> Migrate imx8mn_bsh_smm_s2 and imx8mn_bsh_smm_s2pro boards to
> OF_UPSTREAM.
>=20
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> Tested-by: Michael Trimarchi <michael@amarulasolutions.com>

LGTM,
Reviewed-by: Peng Fan <peng.fan@nxp.com>
