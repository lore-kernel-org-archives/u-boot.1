Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6BC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 15:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3F080F9C;
	Thu, 13 Mar 2025 16:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lyHktRo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E30810F4; Thu, 13 Mar 2025 04:48:46 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBF680548
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMCuhXbBrH9YDKeL9AwCL5JC01kgrAFFcnN+2PhMSqsU1D785vm+uKDXd0et4N6sZgKwsq0Zyb2gxMan0R3Oh/VFZLjEAwXDA4k0PGU5Tgq4EDuuVC8uAqIMgztYAILF9y6m+kSob7PMSbVGac16xfqRk5XBtfAhpFxpdrIHTz6iOavumo+PiCCw6T1XOuwqqRIREEqwreeCm1+7rKzZ6t25qxkMcXpqb/F8uvbFeqAaJdNbAWaYBUfCBNsggrgCKvv8ZyZIaANvmFFGjIE+diQMNBVooX42nrJmrHfClok2zje5exa7LHmqb5BCUZlXuSX4bx2SKXTJwWuXyQmUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFVASZoNqvb8Xp4sdQIm1DWbaP/V01h2iDzBbcqbgqo=;
 b=lXzrD1fMBO489RQn6eUtrnmu7WKitiaLDO39ud/Ntgil1UNNAxmLw9AxhY8lyJJHKb47eFhhsl4AIbBsijhAKFc0FP9bJ2zQ0ZISTePKupD4nLyZenmNNIvgBunTJcYsbDY22i+H0uNukA+7MG5px2lnvoIGeAzqHHwHg5OWsBEIQzaUT0qUukyGxxrttxx7LKTpZse9uSQATH+sGhe2FUoiYcK6GX9tCa6UgTot4X0ea9/YLBbQClqpyDDNPKXo8G9bULaL6zd5ClEXuOFE1V/K0xKZGwpOiZw1qNjzCs3+N4XvpvPdgBn+XBqMxf/ht5qw4Zc2iuyTVRgAB0WD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFVASZoNqvb8Xp4sdQIm1DWbaP/V01h2iDzBbcqbgqo=;
 b=lyHktRo6d3MzQc5/gGT/ZzfW3NYnXlWtWGwqUcMxf12655m7BiPROIU37Yo2LC6ogX9TwmdxnQO10f/p289S5/35kaAEktYU5pZOkRHZHi4xiO21ueUlOja3ehwDa2nMH4vPIDHGyRRsE/PNiOyOVE9p6KFTqtDlOW0+pfzRBGr86z6Tp0egOFT5rIZ++49CjSVXWHwrcvhFACMv3t1HtSUFs4kCeLtdDBb/t2DJxfJ2+xq9+EN5zoMYbF4rVJlCaBwh+3zuvHpZQZS4Inth8xVyv7pXIe2HtHvQchAFbhAIXzJOBbTZFdzRk7UdTm0h1yQN45hFXNXNGlr4d5LrcA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by BY5PR03MB4933.namprd03.prod.outlook.com (2603:10b6:a03:1ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 03:48:39 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 03:48:39 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Meng,
 Tingting" <tingting.meng@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v1 1/2] arm: socfpga: mailbox: Notify SDM on HPS code
 execution stages
Thread-Topic: [PATCH v1 1/2] arm: socfpga: mailbox: Notify SDM on HPS code
 execution stages
Thread-Index: AQHbklBO4tgGukvQ90ukxsm9+gKYgbNwcPLw
Date: Thu, 13 Mar 2025 03:48:39 +0000
Message-ID: <SN6PR03MB35834680F356A8CE0D33D96AA7D32@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
 <20250311063852.9059-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250311063852.9059-2-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|BY5PR03MB4933:EE_
x-ms-office365-filtering-correlation-id: 0056aa6b-c924-4f6c-bde7-08dd61e1f0d5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?y1dhVthBYLdHdB0hCyKBzllSBcZWN/MNgMTevwwJkY4V3c/gYYuy4IBwc8u1?=
 =?us-ascii?Q?RRbeyUtcy60UoSImffLIJCDZcB7wmFPV9nD0SEllMLazgDSlKbD+cWDW/iW7?=
 =?us-ascii?Q?SDH9tq39C73+tCio/MIFusrJv80vp46RBoPJuY+3hVE9pqJ4C0X+SqkYBIoz?=
 =?us-ascii?Q?CWl/TAO63t8TeqNAFU9qV+ZpX+nPDbs13/wTOJzvCvcZ7EnCiwoAAB84uJT4?=
 =?us-ascii?Q?maLEit7z+L8/oLB3QBmWlNEosbwREAbKEna2QBPmKQqeWVDKs0ddU6jfD55I?=
 =?us-ascii?Q?QFLYvf+4QLeHeDLzteowJeDiuox6KQWM2M8kvfOArjYo6gemAED8v9aQg9PR?=
 =?us-ascii?Q?yISwJjzESA8BwPbNsX44QdW8+hdQJZBwNwNjkUKV/2ZYP2CEnDdsf84k2O0F?=
 =?us-ascii?Q?yhBH8vqKUhExzx3E3bDeQLrrydgO0Y6A871a8Ic2AaeEltEulT9EpEUZ7Cid?=
 =?us-ascii?Q?QEdImaG5XBZYlgF3zVsMVDxQHNu+j85yBBrhkJuXWR+a7FFUX+1kHkoXf791?=
 =?us-ascii?Q?6RdE+6tmNwkfu62tGSzgcVUz67hbOQGeAZgA0FabnWMqkOaV8aBjuiV4/kZH?=
 =?us-ascii?Q?CTJCPQ8ynZ5ngMnre0PC0UtAqWmMyWsCXq9tBsTUk0nxrn2f9zngTNtsVmyT?=
 =?us-ascii?Q?i+F8xm+66tR/CmPaTTOyOlIT+ABg/xO1Tz1CURIpuLld4pa9NQqLR+/7Wi48?=
 =?us-ascii?Q?PVAr+XMlQVwBNqoVAlzJD54TE1IIo8wLtoJovBBVBC8WW3ZEEk98cP4akNPH?=
 =?us-ascii?Q?KzbWl5Z0UoaLk6MmK+acQKk7FoIN1VRMM2nAvs91EVkpZpp6uDInxcaDHnKw?=
 =?us-ascii?Q?T/Hktg40Eoq6p/6Ears0YibtDmDgfcOzGxjHH4L5z4hgidjUhrmGXR3JpaYM?=
 =?us-ascii?Q?seuGR6IKwD5hHYT1teUp1Rtu7rqwSOHmhrXJzZ01VQgMxy4Z1kLzD3qrgCoW?=
 =?us-ascii?Q?yOUlBDkHyQZBx5sCA30HnYUxyG5ocU4TvWRIUlsWMOYwqdjiSNrh96ssufR8?=
 =?us-ascii?Q?YcEpteHJJMeg5M4du/VKbFHa7cs0ERpuACelT5n4UiVGbpVkY88uD+KGfXyr?=
 =?us-ascii?Q?y+96IWQSx/GiMU1Vr/y2I2POZKMwQdeSF1T/jNhlBSQEupNrH7BNMSRfdsKu?=
 =?us-ascii?Q?tTVXA/kb7R8SyBWOd/aAaei5WQE6cXLt+5JOCFff56vqmLgSykoK891TIvU4?=
 =?us-ascii?Q?qgKhrpQ/rpqZ7iRybYYFHbR6x9WON3tjiYHI9+ibhicsTmXh2rMCVrIApmFi?=
 =?us-ascii?Q?SxpzzHCALynua+vB0ffsv2vXEJYJ5BbEMbchLLUOT29pVopSWey/94m0gVk7?=
 =?us-ascii?Q?EWYAbw1gpoAX/6+IuZUHr3TjJcSByRk5DBSAOv+gBQxeBGZOq/MWo74h5u+5?=
 =?us-ascii?Q?sVfZMYpmY8cgvp+aTZtrILNQwm4bqQBcRvtytZH1CCey37PemBCb7Ci/S6Rv?=
 =?us-ascii?Q?4sqLJa0bEAnL1PmQt/5oraNJBGtgbR2b?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+NkJC9lyycxIY89ueBc6b1UWCxL5oJ4dmoGdT9NYXGndqrL3Ka4LP6EJO+D?=
 =?us-ascii?Q?KuPreIebRHoWolI+xi75+UpTey43zgDf6OQv6f3u8RnJL3q8HY/qxWXlslwF?=
 =?us-ascii?Q?FMONE3B/TuRhxuimYX7McrWDL+dsfs3c0E8e4WUYLOfwucPlpR6Sm29XlKio?=
 =?us-ascii?Q?9X/y5KosA8qxpAXZtNSrRLv6MDZmdJqdolluU7bk80jCk7KdbvLCmYhfOOVW?=
 =?us-ascii?Q?U8o2dcdgrnPif3dSHBhizEBi0i78dS74vpIxYWZeg/0XxVQCZpq1PG8FYdxq?=
 =?us-ascii?Q?48Z3iW4l9EJMatiAH7hO5X1mx2D/l4uKmVPoTMNTBQHWHP4DILgP953dG0+z?=
 =?us-ascii?Q?EXLxNfGceITlT9bVpajyCZbXbAOsgEjcwVcA4jjrGPBytPqSziSgpJZhxjzr?=
 =?us-ascii?Q?01lQ7cRWJXKUr/b1tp+vND+H7P149gJwYHuoDdsVndAB7ixFT58CUmMvKoRl?=
 =?us-ascii?Q?PupHssrYBzeFLqxdugtz8yoxwtD4dsBt5tZdI0IoH99WoVN3P2Pt+1BOjJVr?=
 =?us-ascii?Q?HrJJQ2r4EOD8ODPNCpGoFUuXkdO3+agXimPgtZZzyf/7Tzhbxc4ILHyKDBBf?=
 =?us-ascii?Q?i56OR1F9ZGWGZaozsTfoR6mwcX9ozgIN/evcrhM3p0s7YplbUPoXUXJhc8Bs?=
 =?us-ascii?Q?0T+ZHmMtodDv16YmEg8akXOURloG6/rWVseEHQ9VTiX94tPTxtgRQ0s38LsS?=
 =?us-ascii?Q?ZVoCGtKm+dg1End0vfflvc3O5lzRBjfZuunzuDhJtaHgJTP+IeWGLPODV5El?=
 =?us-ascii?Q?8pkVmRh7uDXu51I/yrYNyquf1X24jXXyTUYZ5iZwH1F0KbjzvD4kdbCoZg0B?=
 =?us-ascii?Q?i+fgJQHofr+u5hV1cBLcufsWT4a71DjuKNkEv0tm5+dhs2OKRCcx4hvhMYnz?=
 =?us-ascii?Q?IRP1HTmYfJGi6C6rFvEoABq2rqXysi9VySWZRLwvmhyEuLbAJ+z1ZGTkk+2I?=
 =?us-ascii?Q?IPz/lEUmbAJ6wC47+o9WxAJUZv0+5A5x7boYdx1S5GEpmjWrKOE4Hehlmkqp?=
 =?us-ascii?Q?LIlmJEZvgVNoMP+W25pMDtD+wbIpU60rawrL7DisrOIk1s7uF0lIzPMiw2Mw?=
 =?us-ascii?Q?nT19cI4HvZcDapHgm7Urv6lY+kyGMiV1fD6PGonKp2d0l2dxpHeIV/pMVYuc?=
 =?us-ascii?Q?r1K+vyMd6inngwEGqfjVIMcy2y0oGn8hvqgH9ajHQNWC3eK+3mwhYG5mzu9R?=
 =?us-ascii?Q?GyM1CRBZkvPq1OgiRDgZD7b1jrf7h70ckZmG0tAjyuhsmQwvqwJbVMkh4+cq?=
 =?us-ascii?Q?Df+d3krD7rV9Xp0La9pD0hyy51r1u8l9yZumsDe6uE45PX/QWEU3K1Gc3EU5?=
 =?us-ascii?Q?yVU+pERyZ0mGur1cp1zPJf892kXVnYGJ3vlUY0cFM83ZU3/tQpcb6S9bu5+G?=
 =?us-ascii?Q?ki4fYCDvaYlGjq+wenygYz0vzWrPXNVJBY21Pl7/NnoFzX5TjPFvItaA1UOZ?=
 =?us-ascii?Q?M473KDspzJIuq6ffBXWJAtkc0T+JY0f4o+YKM6efZyg5WlrHOk7zJjkigCcA?=
 =?us-ascii?Q?TvHA2oyh2lG/jD9S3xdzzKplrk+/1qvNBJJFfz+FEvCUnYOwL+X1GCqukcuW?=
 =?us-ascii?Q?5JWjT2FGbk0rvnMCTtlDAAyWeZR0dGjrYhMCT5MF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0056aa6b-c924-4f6c-bde7-08dd61e1f0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 03:48:39.1965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJNe4AOqsxvEgNTLT9Bx8Q3Ayw2Gdv61U7CzsD5EoeVi8MlnMmExtaA+WS6xFu0zR0KFWbs6/Ipsr0Go1N+YN1U9pJ0KoU9pd+6aZGM6O/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4933
X-Mailman-Approved-At: Thu, 13 Mar 2025 16:39:20 +0100
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, March 11, 2025 2:39 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Meng,
> Tingting <tingting.meng@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Rao, Mahesh <mahesh.rao@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1 1/2] arm: socfpga: mailbox: Notify SDM on HPS code
> execution stages
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Introducing a new mailbox command "HPS_STAGE_NOTIFY" to notify Secure
> Device Manager (SDM) on the stage of HPS code execution.
>=20
> Generally, there are three main code execution stages: First Stage Boot
> Loader (FSBL) which is U-Boot SPL, Second Stage Boot Loader (SSBL) which =
is
> U-Boot, and the Operating System (OS) which is Linux.
>=20
> This enables the user to query the SDM for HPS error details.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/mailbox_s10.h |  4 ++++
>  arch/arm/mach-socfpga/mailbox_s10.c              | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> index 45cc9912f94..2099c51b682 100644
> --- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> @@ -128,6 +128,7 @@ enum ALT_SDM_MBOX_RESP_CODE {
>  #define MBOX_QSPI_CLOSE		51
>  #define MBOX_QSPI_DIRECT	59
>  #define MBOX_REBOOT_HPS		71
> +#define MBOX_HPS_STAGE_NOTIFY		93
>=20
>  /* Mailbox registers */
>  #define MBOX_CIN			0	/* command valid offset */
> @@ -385,6 +386,8 @@ enum MBOX_CFGSTAT_MINOR_ERR_CODE {
>  #define RCF_SOFTFUNC_STATUS_SEU_ERROR			BIT(3)
>  #define RCF_PIN_STATUS_NSTATUS				BIT(31)
>=20
> +#define HPS_EXECUTION_STATE_FSBL	0
> +
>  int mbox_send_cmd(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg, u8
> urgent,
>  		  u32 *resp_buf_len, u32 *resp_buf);
>  int mbox_send_cmd_psci(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg=
,
> @@ -401,6 +404,7 @@ int mbox_qspi_open(void);  #endif
>=20
>  int mbox_reset_cold(void);
> +int mbox_hps_stage_notify(u32 execution_stage);
>  int mbox_get_fpga_config_status(u32 cmd);  int
> mbox_get_fpga_config_status_psci(u32 cmd);  #endif /* _MAILBOX_S10_H_
> */ diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-
> socfpga/mailbox_s10.c
> index b69bd3e47ec..f9c34e85711 100644
> --- a/arch/arm/mach-socfpga/mailbox_s10.c
> +++ b/arch/arm/mach-socfpga/mailbox_s10.c
> @@ -6,6 +6,7 @@
>=20
>  #include <asm/arch/clock_manager.h>
>  #include <asm/arch/mailbox_s10.h>
> +#include <asm/arch/smc_api.h>
>  #include <asm/arch/system_manager.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> @@ -474,6 +475,17 @@ int __secure mbox_send_cmd_psci(u8 id, u32 cmd,
> u8 is_indirect, u32 len,
>  					  urgent, resp_buf_len, resp_buf);  }
>=20
> +int mbox_hps_stage_notify(u32 execution_stage) { #if
> +!defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
> +	return smc_send_mailbox(MBOX_HPS_STAGE_NOTIFY, 1,
> &execution_stage,
> +				0, 0, NULL);
> +#else
> +	return mbox_send_cmd(MBOX_ID_UBOOT,
> MBOX_HPS_STAGE_NOTIFY,
> +			     MBOX_CMD_DIRECT, 1, &execution_stage, 0, 0,
> NULL); #endif }
> +
>  int mbox_send_cmd_only(u8 id, u32 cmd, u8 is_indirect, u32 len, u32 *arg=
)  {
>  	return mbox_send_cmd_only_common(id, cmd, is_indirect, len, arg);
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

