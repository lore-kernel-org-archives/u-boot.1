Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7639AC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 04:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB11D8059D;
	Fri,  2 May 2025 06:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wPcxB5qI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CD88070C; Fri,  2 May 2025 06:42:41 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B63803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 06:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGQNiCgpP25i9g6rB9hHtt/DnqjztWd2Bze86e6mVDFRAva0Kqf/ACXnyX8yyYB3cwd4oVidh3zf6vMnnO3T6VclKtO3LcqIU98gHn2Ie4eaJK8B9z24CPFJWh9LosoFQJRE6/o1XwJFfXSFzjEylsUP6Pw/YuvzoHTLROXTvBvFdwnzBQ+3Ik7IKluQC6XEaN17J/oVqtIdWUrZHZWeE8lu/MGNCP7wkahBjAo7nYouQRfJtckPrTlwnjGwxzCzNY/XBKhzxBf2I+5kMgv1pmBUfAngLz3kQTZJVdWG3+T4mdFkT+OejrYjyU5rXDkXmXPo5vl84tqv1Dwnsn/Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GTNiRe/CGdtovEnpVUsLnhD9U8FYHsJuPbzdaz82KE=;
 b=UfVNDO7BarwnTL3CKbfZgZmIO40j6AYRSyH4XQdo7YK2+faINAryAqby6nH1z25kBqjaJCxG2TQmw6j3BblRsUGtDtv5PQpzDQdCeYow8N56ma+X+NiJuKx7oMZfWIxxVVc3tocR+9XQskADiX8v/+mEbbws+W6Yj6sCKZq++oUuxmiA/3oCSSDNKsvd4Ye/l/pWk1FL2m2Q2IZL0pMfxtPyyryRdm7tB+UgpjfWN5dB/43cnQJ1rHSiKAsiirXs35fDzqlkJzLbfvfPgzTnUYJbM/509c28/Dru6M0pnMdPNdsrAaB1ghkQnkM7g8A1gG8CwSrrU2mc+Fez4tvSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GTNiRe/CGdtovEnpVUsLnhD9U8FYHsJuPbzdaz82KE=;
 b=wPcxB5qIgbNOlKpz2GFSxHizd1cep5p8W5lm3W5ZZgb2me7zilBseXoHxism8OzW71DX8piYBbtAdFb63kglhtp3p7RaGboA33VGcKdPOXO2c8whCaNUP4pJa304bTudsj6AnokeW9nz/hopIVXfOj3ybnoBBw32l5HkB+9JA+TVoccDK3dInK2DG4tYv/RFjEBjN0LGbKoZCn7JXLa10ysG78WRyjTxUqMRsxImuKFzRxzyH8aHA5CDcoTVXvY4A60bI3YYrFVYLODQrmlCU9CIYgdW57ufxf23L6mwr0A4LnJ9KOwKB1l6treFZI9m0xVsImSSTMJbnZWP4XgslA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV3PR03MB7562.namprd03.prod.outlook.com (2603:10b6:408:28f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 04:42:36 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 04:42:35 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 1/1] arm: socfpga: agilex5: Coverity issue cleanup in
 jtag_usercode check
Thread-Topic: [PATCH v1 1/1] arm: socfpga: agilex5: Coverity issue cleanup in
 jtag_usercode check
Thread-Index: AQHbuOzldF+8Ny8E7kaJld6+olj/0rO+x1xA
Date: Fri, 2 May 2025 04:42:35 +0000
Message-ID: <LV8PR03MB813733540201F25428F9CAB9A78D2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250429095542.10925-1-tingting.meng@altera.com>
In-Reply-To: <20250429095542.10925-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV3PR03MB7562:EE_
x-ms-office365-filtering-correlation-id: f79bb75e-f9de-4f70-509b-08dd8933c2a6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TRUMPVlW5a9yjOCVcLW09b9XLnF+y1MAbWb8YkfLTWZD8oQ7q6PqWTa8naxm?=
 =?us-ascii?Q?n100aBkCa3fc7EcyROIDJv80MWymf5o50MH+KJgAajJdVJSKUHot3kjYkNPR?=
 =?us-ascii?Q?h+nrxotv75k75D+C2pQ5qg5x56i4FX8LrB6QnfVK3GYfuMNuy0l3BhAfSJk2?=
 =?us-ascii?Q?b4LyVwoWndp7iTFxCXj6e5gR3lTAmv1zAApXorHBfP97AVDoCzRWnnBMK6ED?=
 =?us-ascii?Q?GtBOGkMZSsN11MtE60BxrwaE5LsS+y65c2y+bPy+bpyLy24nJVkYLa8tc3as?=
 =?us-ascii?Q?s1dALPOCRHfTyNq0OHHQC5ylPTTXxnl34zIruzQufac27a0pDeTC2V2UiCqE?=
 =?us-ascii?Q?O9S1+gQCO26eWLYw8a6O7po0JTtwp7rsIRtJ4gSfI6KqkfQeNR8qzDGGPTQA?=
 =?us-ascii?Q?9RFPccpOOv77zvGLlXSJyLYiErO+1OvTUe7HQUimR6oq72YqfpGaZDWUTFZB?=
 =?us-ascii?Q?Xp04hX0pW8Ypm9fTa5qIDp3J+pYiR5gAlK913PSGldXhhMs0GI3qVTtxRxkL?=
 =?us-ascii?Q?Sq+ZZC6h5vvjN68OD9OxITBHnBsQO8SZrcoQ7wm9VH0N7dK8GEi8uDHF8/bL?=
 =?us-ascii?Q?9SC2N5zLZjoS4JeFd2APwl14dj3bHhsWoEPoFgKcQtjYq6X9/2p+MbNLcfQi?=
 =?us-ascii?Q?+2mxVmKr/LuDd6DAtqsWaRznPw5YTOsEYpectBg6B8DlL8E+yJTmJufoDNJA?=
 =?us-ascii?Q?ioD4t2IyF2e2IwsDKOAk0CYSWljeJNVhjtEXaiV6vj4euLxbs1t0/XFcZyL2?=
 =?us-ascii?Q?f5o0HhitksLsOl+lV2n8rm8a58x7mEm3lQ1CwHOp4ONqDPCi1uKDlzyz1uFm?=
 =?us-ascii?Q?d2XMuecgG9cOe6vhi7+rSmEc0Pl4rqB3OXfj8ujp+HKywU5xK9Hcu49trwGS?=
 =?us-ascii?Q?rl2XqxcVc0v6iucaFXBy8AK8fHdnDOwmCRtd7lQYlj0SOSs4UbUFYJp59Ce6?=
 =?us-ascii?Q?WJJNctu7GrVFlGfuaFbpMjkqXdk/jw1EJDIMHZXEHdp1M0fqTqOI7PUL1ZH/?=
 =?us-ascii?Q?sgVSqiELmA3sKHwUZMTTJuSmI9z4P8DF0xDJoR0nXGGKu/KZWO/9/ye8ebkM?=
 =?us-ascii?Q?GCUoCHLi7WGdhMyUkshY39c+br7hrFTATzYg9iAohRpSTt5BA3C9zwHuhShp?=
 =?us-ascii?Q?/CELCHQ/EuWQxxycU4mPxxK2KXRLeLDDDxM3OSso3MZ9W+wxhANbP/+gsNPb?=
 =?us-ascii?Q?mb5YEo/+QQ8lFdgFyrQqRJ3ayctlWHj3//v+46yZ2fUEwNkdzc76/ZVNzOsA?=
 =?us-ascii?Q?ASDXFIiCRfoShDVOQCVhA4CM7XhqP+EZlfUzwbXumvQpCbqDf3lvGf7bEOOA?=
 =?us-ascii?Q?QNwV5jYlJXvrChg/sI9vnr2PzDE9HOTJdBmTXK+O0VLxJuSH7c7EnX37q3rV?=
 =?us-ascii?Q?0IZoc43jKGRQO9CriW6uYJRbl+HZ9DemhwI3DgQkkWsAxzwHf0zQ9UEq6nCA?=
 =?us-ascii?Q?Pyz2nuRr2WjxXSWnyYR/fzxhE9wL5h6Ei480BmUdvvarDb5nvyVO4IbPgOXr?=
 =?us-ascii?Q?4ReV7RLBmZfdR/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZXguRU6F9DeFPsD3CHfLFbf8uqbYcGEPbNCBYwGfwBbBERVXPZqTdqlLFipo?=
 =?us-ascii?Q?lzD0IJjT/aOoSdD9qAg3lPrOlqnJ54V3qOMkGaT7qaowd5fCMGX091Pr+55w?=
 =?us-ascii?Q?N6Nd1zUj9YgZ6G8h0qhAnB5BucwS/ggmgdvMvb/HxO5Ynyv6VxQVUFJiQo3K?=
 =?us-ascii?Q?0SCQj65kdyl44qmVxIjWcHRtXFY0NqcJVlek2bwYkntzOUnAIa2hvN2dUm5K?=
 =?us-ascii?Q?52YI0FizpAIqBJGP2HkHgAUmMwX0yYRl3+mGrcwsAG3mpOZjoZPy00gDxBzp?=
 =?us-ascii?Q?U5BtCIB/UMH5doc8HnWUXjBhS2FBzPG/fLgxE04bDceibO0rW0lP6ufJ/7E+?=
 =?us-ascii?Q?wUHfQ30/wlj27M1dzgBnVnE+RPViPjsqXsNAhvOng8OIVLyki+yPkpaHyT84?=
 =?us-ascii?Q?VS4jN+xTzdjPTKvZD/VJy2tUg2CC4s/1XwgH9VqLdtKJ52F5PbdhIxY8s3VY?=
 =?us-ascii?Q?dGx/HvPfL9dlHCjOMnhjBk9Y4RIZzwQD1pDSfnY/poKXHihWVwtABX7kvTaP?=
 =?us-ascii?Q?RKZG0wTL4o9oCgu4awIqqYNiEfdg58SNu7/AW7f4doLHa1fgdDKDfXP1XoN8?=
 =?us-ascii?Q?2JWwGF6K/7B238rjaI+pmX/BgW9/MGj241mFlk/cCqSe3fJS0ZmW5yte9OYG?=
 =?us-ascii?Q?brBbWyabTWYoWG5/bkFWMwgg343UuddeVVkj/GJq3f77uloS0HTt3QEE1G9K?=
 =?us-ascii?Q?ZuNQ/ZKb/0M0MotJFfz7CWMww9QjutHzJyt4+cUfbHb/d/0oLYU2WQR0qnRw?=
 =?us-ascii?Q?gBOfWAYGX+lMIMi6qnvqM09xW8M5Si3Y8DXcIrFIi3MkE2dHcFns+wu+SBCp?=
 =?us-ascii?Q?FI6ZvGHW7h9gbREUh/HL0OmJCO9wh2zk3dvSb170db8KIZlB+G9/sDrcyhtN?=
 =?us-ascii?Q?kkVKriyIiFxIL/PARwannRJusvPBrq+qlZKTS3vO8Z+QAWNCRxqu0cbBPN8h?=
 =?us-ascii?Q?TciBI+Qp2pYbv5cEQxEgKi0Cy+wo2969fe2B/U/lG0Qu4EZqXJWaXAXqUrzm?=
 =?us-ascii?Q?RDPDnuws+xThR8KkKDlZb8x9PUmfau9YVFkbs9Q77w58TFZQNk95ycAbi2hy?=
 =?us-ascii?Q?VLvzMbkc4YVH591NfvnHOqeqeGLaj6tsIikE7T63gRvBMwAZwilkYccdd9rD?=
 =?us-ascii?Q?hx1dgU/JNJKQ1fvWcs6Hpwi7XoLJ6xvcSUnv24LwY0kgAoDvG6BaJq6UC+OT?=
 =?us-ascii?Q?2D8Hwf/1uYWRPC7wYhx8NbirszMnL0cg08TW0B/YJhpxBHU+6eDV60iDBbDI?=
 =?us-ascii?Q?mYs9ESk9v0/0IwTyyrwpkblCE7/U4SWUqxXsexNsJlMrrG/YEW2zan52RRh3?=
 =?us-ascii?Q?I/ASKxXZ+pudfkwTOAURW1dh4fssLnU8ham+OL6uRBJvgg5Wskce+Mmw2ZFw?=
 =?us-ascii?Q?NrPp/YOPPtQzVbPS0CA/kTomkJlzgLtc3mjFJMdMCXU9Y1UEmOopY0bPCbSo?=
 =?us-ascii?Q?kJk63nMNABCegLhmoIU1SNkQMuESOLgga31vnuvhK89kaNV+IaVwbkt9+kQm?=
 =?us-ascii?Q?/gF57YDFUl5wdfUIYDDpcRy8UbdWC2CRtYe5xemTmdyOeEO6SzrPIK9wGIQ2?=
 =?us-ascii?Q?C8VHMOMhZnF6U9u7PPmhnHYYmxHIKUNuRMwxEM5t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79bb75e-f9de-4f70-509b-08dd8933c2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 04:42:35.8299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rR5f4eip/sv/8Q6NZFUERP5Iv3Z4H7TnZkdJY+mIQzH+ihtHUVK3at9J3uGvKIzS1ysubZLQbwknBY8chwv59vsj7R462qXJOYh8xGVHytA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7562
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
> From: Meng, Tingting <tingting.meng@altera.com>
> Sent: Tuesday, April 29, 2025 5:56 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 1/1] arm: socfpga: agilex5: Coverity issue cleanup in
> jtag_usercode check
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> A redundant comparison (jtag_usercode >=3D 0) was removed from the
> condition checking jtag_usercode. Since jtag_usercode is an unsigned inte=
ger,
> the check for non-negativity was always true. The code was simplified to
> resolve the Coverity warning.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  arch/arm/mach-socfpga/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-
> socfpga/board.c index 8506d510413..8bec7c6dccd 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -133,7 +133,7 @@ u8 socfpga_get_board_id(void)
>=20
>  	if (jtag_usercode =3D=3D DEFAULT_JTAG_USERCODE) {
>  		debug("JTAG Usercode is not set. Default Board ID to 0\n");
> -	} else if (jtag_usercode >=3D 0 && jtag_usercode <=3D 255) {
> +	} else if (jtag_usercode <=3D 255) {
>  		board_id =3D jtag_usercode;
>  		debug("Valid JTAG Usercode. Set Board ID to %u\n",
> board_id);
>  	} else {
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

