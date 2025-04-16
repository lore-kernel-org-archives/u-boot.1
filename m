Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C8C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EB982C4C;
	Wed, 16 Apr 2025 08:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jXcQFrdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D9182CA0; Wed, 16 Apr 2025 08:53:34 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5568982BA4
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl2T1SN0NRGdVzf71bvuVbmZeA/lHVOiMRInoUVA7ATIu0d2IWcNODwxQ9fHXOy5hKHanpL2f8ms9SS9qQ2tbG7IXDrCtuQV9+//khVZG0VjfkawHkfUkaKHH6hyR/oczK6ud3BhbojbfMK4ZoKxMf0VSBUwIpZPSWa9IsQqG1UvaJ1lL6QkAK2ZY8W08Xbmov+4zxa6fE9YzKe2Ol11K8Hz19mXth32EW6aw4ajiJglmb35I240UFd/xLa3gksL7sfJyGUcW5198ZxTpU4r1rvDzj1bplZEnrU8O7wiiuNSizEA6l0Ve+pHIN1bkOaLutbok1wlS0bOlYVhoKq2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVZ80Wu4YCQk5gJivFxxWpo8erZAttAm40trduHIr0I=;
 b=rQRez4aPxbhstcmkfPzA5LPQTFmR42NhhYZnv1OrJ4DKcJpBERETDKNX2g5L+o5M+fpnHlLWWLmj8mw+bpa4wFqVKKKLeMenc78aRfmdKG6onx9I/hMTb4MnyP8YmmF2A8iYcUSw1kU7mNU4s5glvw9Fv0J/EQM0iE1X+I/VH7PDnOVlzHxb8Dv6qh7Tx8eQx/D/ysYwVXGmdUNLnrjm+Fvn4ymTGZIGhgMINwnRE/RqAfnhwgfgM3JWmZHD3SB5T52tHR39rEaJ3ZzxZk9v4q2o5s/eljF2xYMj6s+XCpiHIHLuDggcaPKkP2ZGFpe9VBHlpRe5t6veg4ks9iPNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVZ80Wu4YCQk5gJivFxxWpo8erZAttAm40trduHIr0I=;
 b=jXcQFrdETTSYp7v0M4l8yiKOwHFyzlR4vwyf69NZcGvxv5pLQINYk3U8VjYzV+5zIunE3BrUQJETgMBZ5n/oPPzqF7RoAo24QG2ugNbFQxRQwxRCodCzRUzoNmqzd3QlXsci/V+w6FmPLq1FKvqHhlZZh8F8DVP/+nCDzQGEkICBcIjND3oWOG1hk3xc0Ysa9SZdPwb575z49IS1x93dpPt+nLpcmeg6HsFoGs9eL1/4pafHNZG8nuI/pNITw7Di2SwCccchbOPc9khVBJ2p+uFM4FC0/0Ruwn1ouh5Bz6yAcK2++ibEDbbLquRSpmyyke20/vEJUP/jH6Y1rXPfzQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV3PR03MB7524.namprd03.prod.outlook.com (2603:10b6:408:19a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 06:53:28 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 06:53:28 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1] configs: agilex5: Restore fixed bloblist
Thread-Topic: [PATCH v1] configs: agilex5: Restore fixed bloblist
Thread-Index: AQHbrpZ+S2T5YebUdEqbal6P2JSBFLOl20Xg
Date: Wed, 16 Apr 2025 06:53:28 +0000
Message-ID: <LV8PR03MB813770DD37E4E0B1A9052245A7BD2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250416061205.5168-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250416061205.5168-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV3PR03MB7524:EE_
x-ms-office365-filtering-correlation-id: 0d6ff5ea-e884-44c4-a676-08dd7cb364bb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vecKUNi0cL0Wt+iccAskFQm+GmqbFNvOvdM/Uock9FLBd+p4HMUhZs6HtRVn?=
 =?us-ascii?Q?OIqmNjN38N2+6670j0HA6DjuU5uXp/YHwOW+fgFh4h5Ih8iygHAe4P6lXFli?=
 =?us-ascii?Q?diZ5a1wb8m9nXyDB/BZqMEC86qo1VADOjq+8bUIXpazNsPscuCQf5TfUyB0d?=
 =?us-ascii?Q?lvq2IJ3+m5X6oJogt2XNgC8UfbEOJVD5jr/DXl7C2Rcncq+glhpfpYNYzK9L?=
 =?us-ascii?Q?gdeJeBKh/cHqj2+DNmRJwf+sAzv2zsBETr4JfM/2fLEXm8nFUABkTmIo663I?=
 =?us-ascii?Q?G5BSCKnAupTV/ze/yxZKH4PYoQ8vPjS67gHYCq5FjAEykWacYcDp+Ab94ubc?=
 =?us-ascii?Q?bgFhFms3/uiicg58NP/raOFvazEbH82XsDebeIh3PrlFcy1cYyXrNldJmJLf?=
 =?us-ascii?Q?oU2DqUPaLlYNbLTbDUpzDgPgyvP7l2HBnU8yIo6JP71/81KpxUFB7A5pQ5e7?=
 =?us-ascii?Q?FUcEkfxq30DKdqABdiz5t9dVBqHk5WVU0wZwJo9Ygzb926JWxW91U6TdYYvH?=
 =?us-ascii?Q?w8vBpAzW+hKO1nURqJ7rUxr1djW5VrKsRkfBCo7+Zc6my2StbMXz05++jYog?=
 =?us-ascii?Q?/jVYVpnbabtPyY5kn9Cez2JywVftVlx2+WdDvnXlfJ99TwkyqCSsLogre1jE?=
 =?us-ascii?Q?veoqjdIjBIiI9IyDJNwtaScG+lxSIIVuM22Rb/RijPbtivQcijihIxIz3qu0?=
 =?us-ascii?Q?eilLKURHtK2sYPoLH/jYuopY5x0zZBKnrLqzM9hKsvFjwfLeEhiLn6WzG1QF?=
 =?us-ascii?Q?sGCcAgMrA2sxdzWY9mmqP6t5vIl/RR2y1P9q/CLCv6YMEWSeacr3GBMV8cM0?=
 =?us-ascii?Q?9Bc2H5E/4S6SSebrE4Ogx7NkRMfpPQ00ebA9lig1+CntUG/QS1BWJDx9ma9D?=
 =?us-ascii?Q?ndcfZF3VeHdHjpbRzI6+ouVoJPKz/2haXm5S0UEomAxniE/QmWQJeujjv0WK?=
 =?us-ascii?Q?Ex567TWMwbQuXBEuN81WdxmB6oseQLNrsEOdHkbJfMBcDLQVFwOiDwv30HVf?=
 =?us-ascii?Q?imbOeIYnsQPJ7tybfCO/xihTWehvGAtq88ARFP/QUEnb4YSPvruP9d/Xm/ss?=
 =?us-ascii?Q?kXNitvp04A4LEhiJYIpJbTo/Gxb+aeRNzlb2Jw2bpJdzGxDpaM6m7JSy4o1F?=
 =?us-ascii?Q?wccmm4oiQ3EcIowYlF7n6Ic77ThFa8fXPzK7/IUby6oU1U02SkbjQSCew7kH?=
 =?us-ascii?Q?YLiJIF48hFBAJFQ7w6fZv8+QZrx4Gr2cPmSoxcqPlYy1X2nPvwJslNT86zXT?=
 =?us-ascii?Q?jcU0agkKPecuPuMZkINr5eLtmfEF9nAqhXYE87gHa3QxBvuM8QY6uFUuTHwm?=
 =?us-ascii?Q?OhHuV7u5fxriVXh5aC4W9AeYflR5/t8BAiq8g1kbdXz27GPlcn+okavpPQHO?=
 =?us-ascii?Q?cEsETPifcLPeQWFW4da0q5EXKCzz/Ej8jQTi2fZea01OqZsgvP6mxcKuWOcX?=
 =?us-ascii?Q?KxLC58RfCNLUzAGrRJZp0okwiNJxRW5VZBN5h4Hyhg9yA6/e/8xV9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GiEIAVxv8D1KU3GEILIhX5DZ6mB9yTQSapccXTZDl6jMyMOFnSt3cUP7Vr/?=
 =?us-ascii?Q?mK04jubZE2WrGwRhjBJSFZmMK3y3mg9sXfDTPEVgUXl9i+baOqhypwjShRu6?=
 =?us-ascii?Q?xOpsy6JjZeMZ1NnRAkF6JHVmkK9yG0In+UPum8MzF3SJ2H9HeOavi0iRsB2l?=
 =?us-ascii?Q?2Va92Bq40YVnsq/3Rp1d+fPIzxWs+sPavlNn1h5Vwskn45A7qOrzJOieni8/?=
 =?us-ascii?Q?OKWpacSk7COAbRYoySC/+fokP2vkBRoqnLQY9bH2cKHEDC6KAhA1fk5ODSmi?=
 =?us-ascii?Q?TCe0hUukDWRBxol/ZlJNyVdykav6Mu7BiUHHJs2iQ14IGOlOq3nG+gHuSWB+?=
 =?us-ascii?Q?Gpqf+Vo+jUN5GDCbevlJHno3U0pnFi70TX1hcxQaEtgllZMDR79aVHCl0RdO?=
 =?us-ascii?Q?ghNeJZnhlSV6fEWK99zr6BzTubsp4HxtvLJpqxddxqbP14DLLkTcNQZ6wDnJ?=
 =?us-ascii?Q?eszJ5wvSY8OPOwHjoAquuXrAowBXZ2r0dtpm7sreeoyZoYnjkl1qDRyXKOr/?=
 =?us-ascii?Q?ciCos5BE0hbttjPOJdmuyOJGNfhexY7nmmh8/M7mHqywKDVIyH1C+9YM98LR?=
 =?us-ascii?Q?4iHsakwao1NWMKMxy5MfMphkneSEo6XcJyy8PwjU83uUi/f8nvbMAalLP8bU?=
 =?us-ascii?Q?VSnHeK+1FXIs57WtLE5HG5lgCjEbtQrkpV9LFIQu6YWxJ3ooPAj0HW+ng6ru?=
 =?us-ascii?Q?rv4Hc9qd6boZxd0U/y3mKZsI0++TBJjDITpuwmgnX3yKugHGr6aKhVH55lOl?=
 =?us-ascii?Q?WH8C1BeDdUR+1p50U+o9mRDPH/583TNp+ppyYjcNqo7O3W7H++WiyUQXo+IR?=
 =?us-ascii?Q?rDkmDvgt6tAPp95pjdoXwdS9Qj90gAu6PKVl54xrsyOC/Yq2ZWJy3Sovd6kn?=
 =?us-ascii?Q?g8/sLPzZEIwss0GnygmhwRIYrvOTtVWdwkhYq1QcxBCAzKsdGRZMh4ZYilg/?=
 =?us-ascii?Q?LLsGspdRhDldJURkvzhYU61cXfCJm1KNlnB0GlkgFBx5Twt5NYJhbg9UbzdE?=
 =?us-ascii?Q?B69UYQMekDsCzjg0yv5JqcyLldvcpvkVE3juqYniPf9giImE4Kt77nR5OoiM?=
 =?us-ascii?Q?Wz7LQKZnIbG8vQFMS4r2Uepj8b3K1BNemhkYSqg3q69P5s2/GE3xGwhLwJKp?=
 =?us-ascii?Q?v4utaHUKTPBB8tzF+w7HYPMCEYsJvUBzi79yzBEzVxylKvaWQy+dekMZvlMN?=
 =?us-ascii?Q?PSlTmAv0+6roEXKy5/Xxzgfsog5+zuQKK5sLUoCqgQiKo5IN4ORErxpAlcMw?=
 =?us-ascii?Q?XUh14M+zR8kyU99MdoVWV3YYYnx9W1HOIJzDYmGhgcERVfImt1DC+rc134DP?=
 =?us-ascii?Q?CHZQ324fvty4HKbSIA9lObILcujy86qOlgWxx6efNoxbf26WyXjNfGMLHL/c?=
 =?us-ascii?Q?HxDbR3J2lS3WjMDiOo6fm8CzZCRKhXuEfU1+V+TdWVim7tRw3md57N5G3MNm?=
 =?us-ascii?Q?InrIY+6h5ULKEqiPB90AyjCpQ7gjx5qsPTTZCmoU+BjRf5x6EahDfXnNTpCx?=
 =?us-ascii?Q?2evnjFzoAdiUPzHKqty1DnkAM3+2AYT7xLfaCpev9ZOJKTq0HI0D+k0tgCGf?=
 =?us-ascii?Q?4ehUCp4cqswrtLH9mDUJqua0jux9B4IO8kGnD1vy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6ff5ea-e884-44c4-a676-08dd7cb364bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 06:53:28.7084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2LC6zC1zvvp3GnPcMuduoc3qXzVCsYX2iZPK7qju8eCIkNliAGWAtaXHVnwqhRiRDL2PMzJW5XedsI8tdLYYZPxhCPJrDzlfLWWuhvObF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7524
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
> Sent: Wednesday, April 16, 2025 2:12 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>
> Subject: [PATCH v1] configs: agilex5: Restore fixed bloblist
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> CONFIG_BLOBLIST_FIXED and CONFIG_BLOBLIST_ADDR options were
> unintentionally removed during recent external updates to the defconfig.
> This patch restores the missing entries to ensure proper board functional=
ity.
> No new features are introduced.
>=20
> Fixes: d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 77112664e8a..ad0625a59fa 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -157,6 +157,8 @@ CONFIG_WDT=3Dy
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_FIXED=3Dy
> +CONFIG_BLOBLIST_ADDR=3D0x7e000
>  CONFIG_BLOBLIST_SIZE=3D0x1000
>  CONFIG_BLOBLIST_ADDR=3D0x72000
>  CONFIG_HANDOFF=3Dy
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

