Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED32AC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61EEB832BC;
	Tue, 22 Jul 2025 10:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RcO9dtxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7459D832DA; Tue, 22 Jul 2025 10:28:13 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E35B8329B
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zif2uFNhfdjldmJQYfRtN27BI1VLuryXinzXoBQg/JZT6h5aKgVoIIj/w+FZiST8JDy/dr2ezCan5+HpUPMvn7diaEuSxk9cvbSWv7qUE/Ah7I7UYgQGU62CLdAckeFl9yRJVMT6UmYwq3h9uxgVH/TcZY3OyAW3Gw1a1Tu9RsYNFxfACL0arFX7uKrwHQr1lmpUggkmgwFMI0/IfYUzBahSoeaGT5oGAVpGjc++w/45DFAVTjqSypTaLSMZqetT5XhPlzqmtEx8CG3rbX2PWfH1IMWNAv6wM65VeSVnCheab251glHca9CsQGXA+fYfVA9reUPznvs/wMmsr6cuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQu2pQEQjkrnwpLcfz8wZmejbpf64bjsr4Ujgb8YWPg=;
 b=DyYfSXa0TwL7PcK3e2bheFJGkEPmkqW0GgwwXeYYUMfAVNDFwCfwnQ+iLJwRsSsx5PFyN1RgcvLcbRCH5RUZwkHsD88UoKYX+5WFH+/2tyb7Ff9FZOuT5/qDIKt77jjpsC7cdhftfQdDZP+0hR1nXI3nsBTe3u9sDrM6CC5n45hEPyrrHdMQqWREn6eYJmcTvo/6O9jM6YecVCznvFsugONMY94C/TvBc2T/B/KsYcGyB0ssEItsqnkMyBxfJiP5xdYL1OZVaO/Q3RWpI9c4TmDo8mEDqvjE03hIJjpPvNWUMYimKSeWIywh5KM9rLlhWh765qc0p2Z85UgBmPXsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQu2pQEQjkrnwpLcfz8wZmejbpf64bjsr4Ujgb8YWPg=;
 b=RcO9dtxntXro3gVp4c9fqLEYaOkh5cHtZlSIc2KpPAw7aqrOakReLaZtxYXaJ1ah969mJl1Q13L92KqevhY/+sjqV7Bi9xkRTsaYSodOVyVmA1e2Mm6ZU6WUK5RcokRX6seSjR6bW4tdeMh7kFqphXaas9ofz1ber3bf5im1JZJGf/KhB50muhZjQW+iMrgu/XFQaoQbov7QJ6HyjX19TJcjIZOHYcs9f6e+xOKPjTw0KHEJofXhF/Maz1Z2mlJoWLVLT21fB5+bsG5/bkWYdm3Si4NbJDG3lzrXLADISCjBTGGhwKBfCAfxErq2YbauigvkwJ/PsOgbFWHbRZTscA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7445.namprd03.prod.outlook.com (2603:10b6:408:191::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Tue, 22 Jul
 2025 08:28:08 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:28:07 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH] dts: agilex5: Enabled nand boot in SPL
Thread-Topic: [PATCH] dts: agilex5: Enabled nand boot in SPL
Thread-Index: AQHb30CIzd2kFDpM+0mhWdDm4w5lGrQ+BkOQ
Date: Tue, 22 Jul 2025 08:28:07 +0000
Message-ID: <LV8PR03MB8137907BE49273EA568DE1E1A75CA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250617042910.91099-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250617042910.91099-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV8PR03MB7445:EE_
x-ms-office365-filtering-correlation-id: 55d9c452-9156-455f-3222-08ddc8f9afd4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EYTCROVUson1x7XSui8Na9FEYFqaoSa2ZM77zTNUKTGlJl5K1IqEaNyUGCmR?=
 =?us-ascii?Q?wtJTS7201S8nGtIrISViFCRXeMd8ghqTi1mt3rguO4sPu6GINGC93AYBvERE?=
 =?us-ascii?Q?29xz8wBkjeFj7kMiP0EqlSN0Eer5Y53fxY6XXh/X0SiSS8OILn6dF6Go5Y9I?=
 =?us-ascii?Q?xmEoNnKX5pTjus1tbLKUalIhO2AMBTZAOesgJzT87jkzLnbpRh0YVr7HJ9ss?=
 =?us-ascii?Q?aHrietFj4YmlYqBx5ehSH7FlnaeBut5lvVbUzKRr9eyMxM511g4wXoNxTEtm?=
 =?us-ascii?Q?0F0gNuu0/DgXz5+eKUdtzzsNpkxPN5mTRKKzsLJ+NzHZqD4gmMVpttmUvTbV?=
 =?us-ascii?Q?z0HEUM/mEJ8eC3sp+A0RcmeucNlyJH356BwC5X/xRasXZUpiTF2e+rOGzt6Z?=
 =?us-ascii?Q?iPJgYFK115QTSCZJIUISJSdkhTrPrq43XtRHg8/DD33prL5bCG7jz6Hw0BNx?=
 =?us-ascii?Q?o+/qWQaov/QkhhWTWIbJlbhgP8X68wRnG4v3s5fuZeEpYLzhbdL7zKh3OCvP?=
 =?us-ascii?Q?78TmMEK+AH9g2igMf1He60bfzyYLIH+kXSN0Xi9WegOXYRryoPjXsr/pI3Ka?=
 =?us-ascii?Q?FQVqs9VdJ56OMMKJZ8+Jmb4kES9vFaJqKAKx1ymxiSEoLTcydg7UFYpSinKD?=
 =?us-ascii?Q?JryzKdUvE5LzPAsvlHgwM+6qI5j74BwCc4C4QYYPHIx6vEIyIcZfIej6Cgga?=
 =?us-ascii?Q?Mg9HH/U7rBjzkrt4zts+15bdpSo5pD9hXox3DxtEGPSbzhvULc06FJk0Gop6?=
 =?us-ascii?Q?Ea1b5S56dgIJXN48cBqHcWI82kmKm3Y/5o0Jhwq17NLIEJJhsvvfyU2HiNjq?=
 =?us-ascii?Q?j637lw7QT5xy6pSnSFHNA93OrL9xzgDi4ixiGZ2uDI1kBQBMHhYRZ9GFMQ7w?=
 =?us-ascii?Q?JUnQ96GQ9WlZdjF4PtQRm4igJNaOzYSchoFEuJkj5HqV46r5pYkYJ6IIoYAs?=
 =?us-ascii?Q?NCPFmCyzOKQj0nNfnB55H6zNmNkAKpif6Gdy/1ppww91ciFy5eH5jUnnTv5W?=
 =?us-ascii?Q?GPVJiGI/5vxKFVtr82va3NbxZ0gs/+5YZziy7XFGvhkB4oKv+yMi6hL7ocLZ?=
 =?us-ascii?Q?Avq+Sjj3520OCEOigJGdfNdg1XWxq1Q8A6HbY0N0oYs/o1ckj44v+0NaHZW3?=
 =?us-ascii?Q?mAhmbuhvp2X3bey3U9btF5iUG6MKd+2kR28dxguwQZlc4aKpmpLBjbn9BssP?=
 =?us-ascii?Q?/JQ5DTEG68S7byTvPbzOz92evuIqfJgxCIiRbK0CNW/mVfdtt4rPg3/fIxH5?=
 =?us-ascii?Q?3PaOb2fXW9xmTgrPyG0LSPKT2arfTmLkhOmc1bsrALX4nx4bYCHYAS1NURCg?=
 =?us-ascii?Q?18b93CeUIWU1/44PXS3Ee3XUUyy4d9SOwUtMqNbEZknUaSixo6w7wk0e2FP3?=
 =?us-ascii?Q?dDF6Yu8kv5jhf+YcdgcDeqN4PqhtdxES8snSYp6E9hvsNg4qEeT5I1z5ZaV6?=
 =?us-ascii?Q?0BONw1A6r2wSiVfoCA7+UtIRHpXXw7waW5OU5JBUdJ8ahVjD5Fd53A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Bl2vY0H428imKI/XovLoSH7XQtxvjPdDrUbhFq5aq+1LXU8L4Tjij5vFlXr?=
 =?us-ascii?Q?pggKPYjDymtA27tdMm6g4ofB2seQUESkb8As7bS2TYwDoxf9rNqZU1UmBYBG?=
 =?us-ascii?Q?E2tgidYN/yRczt+xKf8mc29IcCLAEF2c6bAuas0TgcGkFYqTcMneRyPipcHH?=
 =?us-ascii?Q?1cNB5Jv90oUxx7uUEdcndAjRTxKBCa2m4OOhcQqZtErY8AFOB0+6t7AoQJ9v?=
 =?us-ascii?Q?T8Asvh42wxayo7y68XYcqB6LrQ7AUnoVRTU1eYiVtbOqSHaenZAYBcU3dmeg?=
 =?us-ascii?Q?CWPZJTjIJTasBmKZ1YTaazP7nlHFDXlDmByeJnVU7J/iGqfizcJWFrJ+J+ZG?=
 =?us-ascii?Q?eRV/5NpmmwnQJd6214AvQmv0DQcjvgea0Kjc5PSuHXpqtVpA+ygOaA6zUNnt?=
 =?us-ascii?Q?et6gqnxN03TLlT29DiOHPR7cjxwTUR3yjichSY4WRUXSEqviLx11rirMi6mH?=
 =?us-ascii?Q?oZGnkE2J7FpR4629E3GSiA5PtJyuga7w97qWffDAjjk9K6kjdEYoncHvQ3Dy?=
 =?us-ascii?Q?aN0zAL/s7Gh2TEgPuakBbXcLDPjIaazvqk3+Qn9MvZFdMX+m4WxyDMxmQCQR?=
 =?us-ascii?Q?mYILhHYip1WElkFcnKuCkvm4hGzRwZOSRqYJ7vaD9RDm/bsEcXCP7BB7RdRW?=
 =?us-ascii?Q?ZTT8+fNtijKqvsBx+fzPafdfkoPhsVdFvuehxpvdpHplK9d13Mk4GZAUAFp2?=
 =?us-ascii?Q?+cCw+gWtDXFEzvpeHgKTI44HYcylg9IoNZpYnd/01nRBy+NQGAC7DXJp+AOk?=
 =?us-ascii?Q?UOZt2TMWpVrZjMjHO5UVz2GHhmtyAXUAcNGPOnvfTj97o3r4kKqGGVh3hoFP?=
 =?us-ascii?Q?8kmIR/fn2RkGyLSzCOGzB+PYMozH0m+zfkuDkC0BURj0Ag8FITmHcS+FNylW?=
 =?us-ascii?Q?iv31c5nXC131LeTm5IIs432ERzV/c9RUqOUuCdIwwFcPXjEVqAwnsMaQV0AM?=
 =?us-ascii?Q?RlGDvCh5tFbrGoDjA7rb3W3vMCPa46VdD5P5C3/qPJ4cDWVnlx3OGqbCzsF5?=
 =?us-ascii?Q?iLZB/lP0x4bhBnMSFUEUcoLUGtTgjvqyBKGhsqz51nqCDZgX95hX5lAaFD27?=
 =?us-ascii?Q?MrWd7I0EnSIXj0/mJ6tWnChtT+O10PRw9a8UaU2BAZpPqpZHFCV7YfcWlH61?=
 =?us-ascii?Q?rvVXEbeP/L7Dc1Yy8+4vrFnyrKM8gQou1/P1g7gr734hqQzFJwhmQ7crTxWu?=
 =?us-ascii?Q?PmsWnEFQzgvaWQHKI4trcHVoCTL9iKOHrIjTwoXyHsrdNs3UTMkFVQOJej/H?=
 =?us-ascii?Q?AP187fBiqR1fH6NDTRAG7PugridQTTIlB1ftiDlxzjS2Ap23ngJln1Z+upgp?=
 =?us-ascii?Q?TcQU+PXaPNwzFE5Fsilj/RVtuvTq+sMR1vf9TEo8YueyhUEWROK19FT2IkAV?=
 =?us-ascii?Q?0mE7hyr1cW+1n3xj6EZONv6v617a//3uvdhz+BPO5HTW+BL27IdY20OoPWIe?=
 =?us-ascii?Q?93oEIJuZZx+X7naygqFXmer6rlnBCPdesxDSIxsiFeXKXChBPz7VOYHn19mm?=
 =?us-ascii?Q?fQLQRMMTbVCq2DG7kUBM49ukoVkXaHgRXhTr/kn+SZzZDm3MF3uYhCJ26wwv?=
 =?us-ascii?Q?uWwy27RRU9ZniJIrFjW1bIGAVWozMQ8gnF0Iwo8Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d9c452-9156-455f-3222-08ddc8f9afd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 08:28:07.8665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylcbqNCLyfOrfXR1dET1VGsqXRuWP/ag2B772bLyvdHIo/R9bhwkwtytCuCctPy1uZ4P+c5Ydgke6Ztdu4IcArJhviyrAZ+P5rUkqSLI4LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7445
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
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Tuesday, June 17, 2025 12:29 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Chee,
> Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH] dts: agilex5: Enabled nand boot in SPL
>=20
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Enable nand as one of the bootable media in SPL.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 8d7dc0945ab..938ddb04c04 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -67,7 +67,7 @@
>=20
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
> -		u-boot,spl-boot-order =3D &mmc,&flash0,"/memory";
> +		u-boot,spl-boot-order =3D &mmc,&flash0,&nand,"/memory";
>  	};
>  };
>=20
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

