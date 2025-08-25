Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC012CA0EED
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461BB81E13;
	Mon, 25 Aug 2025 10:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cldc6mKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DED1828A2; Mon, 25 Aug 2025 10:00:07 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97695808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwyQa5Q6iRT+yD7eYUCZ74cv8xgRDs2EAFAsxFbfzjZCCA5ULUhqUE/U5f23MtdikomRUfYavS9f7B9GB6ZUL/C6tzampFE9l4XLaPbtIC6BND4nc9BPeysR2cG0zcv5HiWaQ5v7s0AjVsyU9+rKIxlC9H0zG7wTuvFSFcSqaGSYYZAmfqwGXbheeInJUjWLgYoU7dhhxXhsGyq7KnF63paf9Zdz/WufByuC499g7Bb62RADN4kIMzhmCy74IAhHFKQ0lsh/iJusUi3hJZr5boSsUB2EJKmY+Yh2WxUa3tJ2/EHD8GdjtlsdhE8W1wNYp9dH6jaVNaZd8AqekraDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMnvzNOiRTXxqxyI1//RvF7a6O+kWHN2aYhXhZjsCd4=;
 b=PatJkFi9zRfUQZbJRim1BV1VM0EQdTkmplgBIbqW9Ahgco5ZqmPOYJatZ2D5GyNREP0C9OKUjVTFQCyEM3DzTb9c9QpcK8q3cFHqCFfNSLvoP/xMKdtg8UMUX8V6gb9xorn9WRKqGKGVngNh3ScO3KFdsEnR3OQ631by7fpGjRHETEDl2Wr2TRUorJkdCJBp8L6miZgswh+KnwLj7z8VOuut6Sb1r3vHWM0msWuP5w0ehpBKib7V9sqgRZZHkJ9wBD4yK+MRiNGSo1OsmjVqQOzZD97O5T86UjOLGcfx2I08z2DaDOwwyJfoYhD8oloIYGBvwV/qceAjyvOzJJisNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMnvzNOiRTXxqxyI1//RvF7a6O+kWHN2aYhXhZjsCd4=;
 b=cldc6mKVbCKR0xvHkilBmotZ/D6HYQxeroWRZiLoctTgnjCxhebRYYFyO8zrdoF8Ky6PEKTZUYBtaWmv6TqvTCIWKJe3GWnl5Sq61Z+8KplQCW+cUFD9iTLV/Soa1hU5zBvIN0VeTjUeXVuv0xi7/+oBFMIhcHTixb/HeJLYQG605se8+TY9gHe/VNmLQFKr7URX6z4VsYoVLamm4AWQzPSb6CJxOvkVTc5kryACIjd+J65rtGgxcqUiLfeao8Jv6cqvftb1ZiV8HhQCkaQwM8tCiE92HM5tc2cnmC2ye3XD/AeGHjpEYXr9sHyZo8S/C58wG7kv15CH65lo55SnWw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5810.namprd03.prod.outlook.com (2603:10b6:303:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 08:00:01 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:00:01 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] configs: socfpga: Add CRC32 support
Thread-Topic: [PATCH] configs: socfpga: Add CRC32 support
Thread-Index: AQHcEMEce1eDJIagXU66jfVQy3BahbRzCvGw
Date: Mon, 25 Aug 2025 08:00:01 +0000
Message-ID: <LV8PR03MB813755941653A8DD3702511AA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819042404.26990-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819042404.26990-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CO1PR03MB5810:EE_
x-ms-office365-filtering-correlation-id: 49fcb3d3-9e38-4129-0a7f-08dde3ad6499
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5d7bSRgC/LSZ9CyxpiGTg1NcMfyX/U3cifCUQ9UZpRZbWsNPnR7oHdhY6uRo?=
 =?us-ascii?Q?w7GvHwCRQEuSd8jwXDZvm05bGldaruz1L8OSLNTOHxOpiEtVLODgRMdmS9PF?=
 =?us-ascii?Q?e54DF/K+mfM5PfsXQu4iGmWY1W+SX5g3zoqYY/+yy+wt+ge3MArhDbkHj2a6?=
 =?us-ascii?Q?QLFe2+Ncd1vsZzUuar2pQf0zCewDUtWgKpDnwcE8CNYeIZJcfjDmlpDv+FWe?=
 =?us-ascii?Q?wMaPcKLka97ziqfHWAPOA37t0GRqQKWw0IMaRiPOC0Z3zgBII7gF6Y4cF3wk?=
 =?us-ascii?Q?4NMRYkbCXsNk3jWXHrj+pco1riBKPEWtBdmku223SgeKKcl/W8sVPso+gNaT?=
 =?us-ascii?Q?GgmRYOgti65fIrom4Ix3xnVxkY0JSU2ARlBduQYqhwugcljJxf/uSY0TFbBU?=
 =?us-ascii?Q?Vgk3/r6NuOI/dyIKeLxabQ3HKa+Ss2zU9SDTL1GnhpnBYr7D1KptmbITULM5?=
 =?us-ascii?Q?1pDnoZ5TFmQjLMvSUSCWhwHk5XaJyW5RSNauYhC6y3+t802KgjdrBaGPOBu/?=
 =?us-ascii?Q?0SzH8nAJWRF8+JtZJOYUQbyYRQXGEiUFy1+qwQdWd09z8S0JI14XJzrOFvh5?=
 =?us-ascii?Q?W6bOjsIpUqJv6BaMnb4Gs0gba1DZluUOAnDNoo3pmFTl2t28dB4bA2SHR8HG?=
 =?us-ascii?Q?YM1xcPMLvixrYHNIc7rnKGPcaTGtwcL0Gu3olmD2/YG3RLyvJE2v5iwQ7p86?=
 =?us-ascii?Q?bOiMh4VuvCjmPO8qnJyyveED9k534nuyRsrBuAplU8h3Hn9ehN6/W34QnNH2?=
 =?us-ascii?Q?54bPbuDt1X7YeL5BPkK/3qq2LttLW2V0Sg+hOXmcYC7WBDkj9/uVON+wv9wA?=
 =?us-ascii?Q?yR3kDw6ybASG5CxKOKpH7E24Xz0PScBxvNhfGRW+dHKFy3eo0mdb8dHHiy9U?=
 =?us-ascii?Q?G5DZBeQmQTH1dSzVZ+b9DnaCqfgRzmhRU/XIOBAlg+4+9EUwjxqn5tS2Ri9N?=
 =?us-ascii?Q?/v7pHIHRwxOmGdSIAoe4VhfBaw9f2I03UnuaH50lApI12ZzIibSEdNpOqxys?=
 =?us-ascii?Q?+aIKXaX7T+2YIWk7yv0jH/eO6CSRqwoZ5nZ8/hAnIskOThj8KGADIvgdHS4u?=
 =?us-ascii?Q?1vqRX219jt2lxJcXhS9dcy4LJm6VV2SjL0ccgfJ/pTbFRxo3jtK8Izhs2l8k?=
 =?us-ascii?Q?pIhkKEgfFgByNG9axt5BrVIsqdu4U+8YfItX0+nsGS4HWAP5ajoGSNHqC9CR?=
 =?us-ascii?Q?XbJ8g6FHCscPosqtdxY6u44Mw8eH6auB/o7lyqUhD/vEgy9IvbtqssfT+ID/?=
 =?us-ascii?Q?VuUFkHovr7EsUBBPWWVO+gu75w4FPsQzAAfy6dvHJINsWg1rZSm+Pa1E6udw?=
 =?us-ascii?Q?ZebvGxMRSULu5+LkFUlb4/6XtLSMyYw7ZqeAWnqVAgBPBJ63qLzKxCdghEMk?=
 =?us-ascii?Q?oTMA9iopLSXFnycp41CVrvBElMpjTKeM1IdKRQh0N9uD/00hOg0anppvWIBG?=
 =?us-ascii?Q?S/vowBrvuMBZl7/h4z2OUAfxs1aiSA3JYbIEn8vxi1I/wVPnl5M5/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kFS1oKZEm8OEkCtkWKvI2VS4PoODLYSRwigBMOfoeGa7jkQgUagB3COlhx0+?=
 =?us-ascii?Q?ysVz00So9DGrNNZwkC8UTxx3D+oNrg7EwuSlwaWcmypO3lBpkWrlxJ1Hrkqn?=
 =?us-ascii?Q?B6/ttAFNL/VaGHPwaHfyagizQrD6OGLQY9irwnyPka+Pr4zD+ZjJ2c6BUY6i?=
 =?us-ascii?Q?xy2ZSTTB9mhum1Z7v9/zST9OddSXYHLrzwxYOuPBGOhciXMW+UBahDbWK9a6?=
 =?us-ascii?Q?+iWhiBgXRDwLkWjir0yfkIWqxxlax6wITXJrJukZckxWKiM98VNF0ZXeADp9?=
 =?us-ascii?Q?Mwc8ZuhbpKkSJ+YUye8/vne/vDmDzmvbrN8rtmW0Rzg3stF5T3sq4U/N0E1b?=
 =?us-ascii?Q?hngCDEyT1VyDzcjeZ1CqKZClvu0pCldQ5qydAWmkR8zZ+Eb8aEGlIG8y7v4Y?=
 =?us-ascii?Q?hKmgovFkLIrihv29IjLTjH0Bqp9CWn91rX3F77WjEIv5tpYLZb5td/D8R3tb?=
 =?us-ascii?Q?sDqRyQwQ4wDE8h5sLxWXsiaQtNyIpNXMZe01WNQB62n4yi8hYOeJXaTbUi2J?=
 =?us-ascii?Q?UP990yAXGTEcBFZOf8PUC8xqkO5ZpWijNA7bxJ3ANbfRQTw+FiXfFdnnkgBy?=
 =?us-ascii?Q?E5ihD3S8HcmtgAx5ZIcbmID6ZxYcHxbhULr+YRkSHbSO8o0Opk0Jghmvt59V?=
 =?us-ascii?Q?Tb7XUcdcEkjGNsmT8MjilNtdlDI3a2jZlhQC3ric5Utloxf7AIxuFFPTA9kM?=
 =?us-ascii?Q?cVxf03qtgJz2h7zaOl8QY6RwJht5ylkEeNU4uRltz8Qac0b6deyG4+sL0aET?=
 =?us-ascii?Q?LpLA785dpDHlop4ECadOcr4EKuuPoQWhvS/Z3VOH48M/MZRDzz9tPMUxf8P/?=
 =?us-ascii?Q?otMyRVOOPGIKrJg1euorsa74hAItSpCOrCStwb7dK5MFxr61cjiSeM24sdCp?=
 =?us-ascii?Q?2iwC0j2MdDR0PbSzvO2JDj6Q4v9p3Cn8SnaLCIKsuuNTezMHla8ipZ8tSkOj?=
 =?us-ascii?Q?VP5nT5idvEt1cUxnSOySjF9wkK5A/4WbMNaMK7rYVrQkGC8vBy+YCrgcL/jn?=
 =?us-ascii?Q?uAJL+RuaDKnbEAmYX8ggh0+1JuVrw+vnP5BRQSzFnfrQfvlGY1uaxA5x1aPN?=
 =?us-ascii?Q?w/z6QCcpVdNtaeJgpM9JuhZOzySy5B8yA48l13+6nSYKwUUDVHMuigsCHCsw?=
 =?us-ascii?Q?RH+ixr6ufui4Ub65rPdFrP+Pt2f+WQwXycIcmOecezZhzvpnfOKRsEiohxm4?=
 =?us-ascii?Q?68eNzIkiMunbsI4VK0SaD0PnKy0EK2X4Yt3nhRBc3GY5Mrik0blyR5pTXnsM?=
 =?us-ascii?Q?P2tdmJlOD5EcUdFJW/eoY+0Q1kfxARRSHJqtmgO/GheCJIX/Skmb9nw0hIjm?=
 =?us-ascii?Q?qAyy3IoThKLZCnf7KF0Fvgm3REhJMTSPfKvLcN8wCKFZw2MXYV+JlS4pa8HW?=
 =?us-ascii?Q?7J2UKkmTP2z36+5N7d8Oz8RL/mNnQPF6hzCP9fvsYIn579QHm4/PJrSRSYuR?=
 =?us-ascii?Q?YX0FBUeUiU7vDGqxwZywjdAk7Ah/TjE2Rt6UYRcmBYak10Er/Vmat9FBSlN4?=
 =?us-ascii?Q?iEe2rGJ1RBV2p/N6oMTCJbFekUFXWFU/k9tZjfIJcjQiT1sNGfT6zStAUbq7?=
 =?us-ascii?Q?uhxMpMSlRKXdpeHSmAPAXQULKanrnwXneq0b/Ek2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fcb3d3-9e38-4129-0a7f-08dde3ad6499
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:00:01.2858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blbu/qSIbWj0HcKpFcA9ZX5C2D5tvUyoCgHe3330uKgm/oOXEpjXScknSu6OUzkTGNZNJ/PJi7DhXZ901m2NzPe7IPNtRlLHETIfx54ei4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5810
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, August 19, 2025 12:24 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] configs: socfpga: Add CRC32 support
>=20
> CRC32 support for SoC64 devices is added.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_agilex_defconfig    | 1 +
>  configs/socfpga_n5x_defconfig       | 1 +
>  configs/socfpga_stratix10_defconfig | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/configs/socfpga_agilex_defconfig
> b/configs/socfpga_agilex_defconfig
> index 0b6194c1f27..638f8773397 100644
> --- a/configs/socfpga_agilex_defconfig
> +++ b/configs/socfpga_agilex_defconfig
> @@ -39,6 +39,7 @@ CONFIG_SPL_SYS_MALLOC=3Dy
> CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x3fa00000
>  CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
> +CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3c00000
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfi=
g
> index 879556614f6..d501fcddf3d 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -37,6 +37,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x3fa00000
>  CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
>  CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3c00000
>  CONFIG_SPL_TARGET=3D"spl/u-boot-spl-dtb.hex"
> diff --git a/configs/socfpga_stratix10_defconfig
> b/configs/socfpga_stratix10_defconfig
> index 90134d8f3f3..fe191d09714 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC=3Dy
> CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x3fa00000
>  CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
> +CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3C00000
>  CONFIG_SPL_TARGET=3D"spl/u-boot-spl-dtb.hex"
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

