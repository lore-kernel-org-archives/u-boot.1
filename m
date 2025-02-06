Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44285C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9842B80836;
	Thu,  6 Feb 2025 11:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73974807D7; Thu,  6 Feb 2025 07:54:15 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6728C806FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 07:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDYOgUKx1qgD+4/sEyj/wZtjGoNkNsWEBJKDIBJtwjXLuIJ6A++z0fgORC+bZ4V2S3RLpgQ9Yrz2A8/1sdVmQAvbXecisn0NOnVm2Hm191FaTERVzgZNcTfbI6mCRNFUp8k9HTfm0SCrqPRzsUszMzVUdSGE6+evBqMPFYS04al2cv4SRpyimB/FapoAM0W75jvktRJFtPZHLr+qYWasIKsSzgvXXalcE7P3IOaV/CFtCkNWpNFMv83kOFAZH2t98HB4Mbesav5lSu/H6KrXfY0W9DdRjTh3Hl802OCWsCAV/qhdNQeIigYsnoQACVHsujDHeulvuJSDjYdbHsRBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWHfkp/8bBC4CqY7Jp+2WbWlof+bWjnoaZzi/aHgEug=;
 b=H5ZzFncmWL+VKOUY0d0vWoWLyeTid9S5pdex7TYuEWuOrV9af0Bfw5MTkMQyk2GSCRlseolBFe2MmGN5ta7J3Y9GScVsscg6RaXcQyMAnuy2gA48XHeolF85wtiYApPnw91lQn9bv+VAA1V8SGI97ruiA5CKn+GGXCXp4yfj0ZWbBU+BTk2J1Kz6v6js/O418tcyOr4jEzmPW28fKevyc5aUKG3MtWs+2jz1SfN03rglzUkRJwzxIA4oq05DaT7m8UX+2DPV3ARftBSKTyj19j/3qpNte6MsF2rKdssG6zOv0cCfsC3xF5XWsfUA68mNEjxWsnwy05j9pqzoABYIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Thu, 6 Feb
 2025 06:54:02 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Thu, 6 Feb 2025
 06:54:02 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Tom Rini <trini@konsulko.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Topic: [PATCH v2] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Index: AQHbd3nMIxMs8+0Kl0yTieANtzpJ9bM4vRAAgAEVM4A=
Date: Thu, 6 Feb 2025 06:54:02 +0000
Message-ID: <ZQ2PR01MB13072FBB86BA47C84DF80283E6F6A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250205025652.5171-1-hal.feng@starfivetech.com>
 <20250205135818.GQ1233568@bill-the-cat>
In-Reply-To: <20250205135818.GQ1233568@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
x-ms-office365-filtering-correlation-id: 59922cfc-a5c9-4614-6220-08dd467b0a73
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|38070700018; 
x-microsoft-antispam-message-info: nX0v9jX8Ib9x/zJayRu6i6vPvl2QD+3vqlAC3VjtBNEFPNVDgu+eBfkGeMqbt7QmozRFE2P6FYCfwFIVtff+eiAccSxZFr3480IMjio4NlXrXGscQ4c+k2qub9T48Aay728ngPvvB3LcJQPN88vU0WwhvQsW4uSDvjLq44juV0vLdx5W5214Figvwt5+eUg1rWcZ5R4n5dmWkXT/ljiBwT1zrnbteZ/MbY8cHkslKjw+DWlm/pD91pwfcItNSCQTFRmZ5ig1eeOUdXUNzTIMy51ZXCCiqidUjj6b1G+G8Pc3vmBzisjXV61GCPyUZBhOwP01XdCIwEKTTYNZ8YZb20ZFADW9jXq2aHoC05j4Wgghm9TlH6poQSvampjfFHEKuMMHuJHVnJ60Dq2EJgggzw+stLRmwIL4nk7DInmW4GNqJy2BNPBSDzmsekBEtg2+1wpPJrVQj7Uxf8ypupmqGUoSCbdZicuhxyPdj7W6OMPwHPYiZKSMLUJuLuS+zxZUyUEn9IO9CiG5Ghxh13E4s7ISDdhIMcZhPID8nwFBZoQHFvWdku826YNzzbBAi7S6cn7nLlV1BuXSbOFepVr5nDSNdyqBVL26vBSEibTZt3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mTrBMnSUfZm9lvAq3OI7aBkl9Cj+r58Ty7NM9eCL58CxRyqqx1K0lFThG7UO?=
 =?us-ascii?Q?hiBRFOh1kRRzFzOfG7WYBGtgLlqR6BlG7OzWYs7bxY7JcBXB0AgHKq1cyiZ4?=
 =?us-ascii?Q?ogtyWbV4zMeyW+qdgoxCIrS4eFC7bk15xTO1MRX6OpHIrAXJVS+Q/s7tywz9?=
 =?us-ascii?Q?VkUmQKvz+9Ok+8TSBDwYN/2O6qOcE6qn998CJpAWN5iKZ+LNov6XMT+diVjs?=
 =?us-ascii?Q?/hMjAU19sjVigKW8xsh/HXMHZszon+B3YLt122zJ1Mpi0G4JkkGfMkF4xZAN?=
 =?us-ascii?Q?P+Hrco8ohD8fb4LKkGPugYgr8vhs4clooNO58X1t8xeeub7jdoYfhiu3ezVY?=
 =?us-ascii?Q?Jd6yEF6RwqkdtRqYzwe5cteAU3RcA9D8tiBNvQ+HydBq67vP7XPbA7/2qKnH?=
 =?us-ascii?Q?WNyQbSVLe8Q810W7eG/w/5PEmj6cTpKoLJQveyHDspwFmVPe3983TQDa/TBo?=
 =?us-ascii?Q?VSphtvPoFQKamNFRQpPGxdex3mxhZR7EfkuNwwLhOD6o8GX0NhjxusozKI7T?=
 =?us-ascii?Q?teFSzbtFYw6vI+BKrWftJytQxBOvt5Ij0g52mBztFo2RwM1cXwVUNoKC45Y/?=
 =?us-ascii?Q?pbwRHImPKBINXTqsPfEzV6M6+qelKtNn/O4un4H3efd5E9F0MtqbPvnOgTah?=
 =?us-ascii?Q?0duWX+UbTWWP32xbOb4sxyMkntUOSXYkJVWgXr0QEmK6za/gsnRJVKmPasNA?=
 =?us-ascii?Q?TTFLJHTPSqTdyefXzFtbNfQlK/Ti6pxaOof0UlFYI5Tve+kAEiLXS8dVYll+?=
 =?us-ascii?Q?PnHwMi6UzDqH/svGj866HsA0eXrvWOGo7BY26mr5W9DE4FcCMswCXxa5sOl0?=
 =?us-ascii?Q?VSwtaa04HsNWc80njQAqw2Q7L0wmyTz3Lh9pajdc9XffS3W8JPOZVWO/mtuj?=
 =?us-ascii?Q?ypKTC4zoxud7p/xKRZ+hTtqbVqoGQW2pcEvxwNv/ob6ioFvF3SDVZASPXtnu?=
 =?us-ascii?Q?wiakCYNJNmG/9VIAr6K7zl0As675RcO209TkIAr88QBWjjVYVk5fL/WcTN06?=
 =?us-ascii?Q?81not+PfmcBBY9HJ9JCM7VDQhyn9mkxqGCbov/Gd2GtjSeU3d/b8ElKotzkR?=
 =?us-ascii?Q?hI0y+TG2IoId60VC4C5C5o9pygX0LgEQPKsG36GB5Y6FKpPl9ZCE6+SkpjFw?=
 =?us-ascii?Q?ZUXgrofHf6KXMPovDW11LCDSVMKW8Rjmwysm9fzeRs37+LdgB0NTX4zwKLMB?=
 =?us-ascii?Q?YYJgW+q8vkEcYgqQjEjZYGEGcxWhQBTnZwA/3SAivixBA0WW+Ny7BjZtjlLy?=
 =?us-ascii?Q?IcTNlTjSFQw81rfionDAWRIc+cJbYwSnO0ZVyZJKBWeWjQT0iHnzAUmjDTpZ?=
 =?us-ascii?Q?pENVmEFrysnoBKNpDQhZGxNU5H75IlS0Ez8noZrjXBaO/KLVmrOKN1v3qtxs?=
 =?us-ascii?Q?33Mc3+IPZCK5xuU2kv6VcnUGHmLfzsPDxvyqKaynmcTTjeper1gmBMcPPlBT?=
 =?us-ascii?Q?QBkTrJVdXyTLHsGZ4wBKzBFCjSFG9nL6QWgflE9P7DtylcxlpB7rGsYruk2d?=
 =?us-ascii?Q?6CDqx7ttEveCSZYZJwKRwfIoREbZ9vFfqHwITjLhlthCJQeQGY4sEd9r8dA6?=
 =?us-ascii?Q?iIBb9g7DrV2dYpCjNxYwwOoe8Ea5SSMgOBeMX+IL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 59922cfc-a5c9-4614-6220-08dd467b0a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 06:54:02.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEihMMFZ/NqJb9wELX9rmEfV2mToPPgOnM3C2wAoZpv/u1MQPvTOzGMruioK63NMk2EgcOtLyLD6/wR/dm1m+wIcTuAnPIahLsP23Dr2QO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Thu, 06 Feb 2025 11:41:33 +0100
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

> On 05.02.25 21:58, Tom Rini wrote:
> On Wed, Feb 05, 2025 at 10:56:52AM +0800, Hal Feng wrote:
>=20
> > Update the maintainer file and mark jh7110 related files with N: patter=
n.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >
> > Changes since v1:
> > - Mark jh7110 related files with N: pattern.
> >
> > History:
> > v1:
> > https://lore.kernel.org/all/20250127083814.67839-1-hal.feng@starfivete
> > ch.com/
> >
> > ---
> >  board/starfive/visionfive2/MAINTAINERS | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/starfive/visionfive2/MAINTAINERS
> > b/board/starfive/visionfive2/MAINTAINERS
> > index d7f638f9b41..87589553150 100644
> > --- a/board/starfive/visionfive2/MAINTAINERS
> > +++ b/board/starfive/visionfive2/MAINTAINERS
> > @@ -1,8 +1,10 @@
> >  STARFIVE JH7110 VISIONFIVE2 BOARD
> >  M:	Minda Chen <minda.chen@starfivetech.com>
> > +M:	Hal Feng <hal.feng@starfivetech.com>
> >  S:	Maintained
> > -F:	arch/riscv/include/asm/arch-jh7110/
> >  F:	board/starfive/visionfive2/
> > +F:	doc/board/starfive/visionfive2.rst
> >  F:	include/configs/starfive-visionfive2.h
> >  F:	configs/starfive_visionfive2_defconfig
> > -F:	drivers/pci/pcie_starfive_jh7110.c
> > +F:	drivers/ram/starfive/
> > +N:	jh7110
>=20
> Might as well use N for visionfive2 as well (and maybe add an entry for
> general starfive files and N that too). Thanks!

OK, will use N: for visionfive2. But I think it's not appropriate to use N:
for starfive, because the other SOCs or boards of StarFive will be
maintained by other appointed people.

Best regards,
Hal
