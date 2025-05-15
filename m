Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E36C3ABC3
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 04:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E1282B00;
	Thu, 15 May 2025 06:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lKYO2Lh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B581582B07; Thu, 15 May 2025 06:08:10 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C93182AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YagNyKXnemAYBJgtfvhjLy8IDw1JjgsDGTkVSLgSEtFrX/muRb6oAyBLlmge4UV8BaxHEqi+rmRMPRix33xsrVp3MqK7vGyeO8xVTUNklLkg3NJt+3UVGeKpJIXMCqLhogeHO8luTAKRQ8ikZh+As/H5nZOYg5qKuw4WSOMSGAypSvxheP4xY7eRWFuIgm2VY/NTu/clL8pdebggyc2IUo1F/0XwPleySbvT5WkR4HzoRu6OyiSCy5JcJhsGIuDRqnfOslcVsfledKNS/jttFQH6vawCRPGLBgVbQi9Nj9TWTH4VQkdy+Iq1yOjeRD/4GNv8trOJOE0TXXBPN5l6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ufm3AjXLpuy/Rysps0Xy3/14ByWLouXww53kWXHBPM=;
 b=l8s4cCg5mIYDIX4EkMelkV1P647wSnPwwSjpcCluWJetjv79x35jjQcITHpIBL8dwEWY0lDT7BWy6o7chvvRSXiMOJWTM1NFOtewKKpjSNcexKFwoJiXTKL2YLgif/JUHlSGyEYucekzAVWQJ0ebA9kTfW9f0ut2m5no7fKEb7IAweTytf2Pm8WQCWEnuT3DP6g1rBHv8hQiMHOoku1aFBi+XQucVUvgP8R/IccBnsRXcFOzz+WdQujxsz00lL9C+7OoBnL60PHHa8tNLejpoUCY1dCKRLsbvsxIBBJtYd97IVgVEUTE3ruKkUbTZDOXuFUjNZe39P2DwokNEKeVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ufm3AjXLpuy/Rysps0Xy3/14ByWLouXww53kWXHBPM=;
 b=lKYO2Lh03dEPOD6MvLsYgAsYigHPtRG8MN38OWCqljEohfHTpbxzPQ2e95hAM/vd9T+YmToacHtdml+rKIopV8W/jWuOUCJrv/XH7UoO+tJMDSt8S/dkgdOKInBLLu1jpDzRCUjse3z056Y1DlzUN2AcCAYfEOeZ5zHWyp7gmAthOviwra+kEWG+Cqy8NCOMc9I7BT4P4aGzrPYbysARdnFTajW4UnL8x73rjC8vpNpvYT7Nf0tSv32KMjijhoDo0bAvyFhC3Ps5IyCz5Eqv4wa61hDjCUnCT1dB9VwknHsr5ZfGL/yxbJy3uZOZsF1JtCSovpP7WCVcVquc6s3CuQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB4936.namprd03.prod.outlook.com (2603:10b6:a03:1f1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 04:08:04 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 04:08:03 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 4/5] drivers: ddr: altera: arria10: Move common code to
 common file
Thread-Topic: [PATCH 4/5] drivers: ddr: altera: arria10: Move common code to
 common file
Thread-Index: AQHbvpEL4JEtnJT1l0q4UwE59eaDfLPTIDUg
Date: Thu, 15 May 2025 04:08:02 +0000
Message-ID: <LV8PR03MB81372E16503B1808901D9267A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
 <20250506141246.6672-5-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506141246.6672-5-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BY5PR03MB4936:EE_
x-ms-office365-filtering-correlation-id: 72c7338c-e73c-4453-3e7d-08dd93661682
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Qd7iDgjsDIQnhLH2E8mYH7Mdxawl/0+882M9gWE/z+xRKRAHx6sadAtCRDlo?=
 =?us-ascii?Q?XfVvv2GOzTYgEnMYCu1wBc9h2G5v1d0O5CD50+5S5bnZ5xMehAeGFaOd4MBa?=
 =?us-ascii?Q?GBrsqeceNkocZxN9hlzYKchOCaSRJlTi1RCGov9BvIySS+xERYoWWCWyMamX?=
 =?us-ascii?Q?eZWGMb3G96riE9BZhQHU2sw6+5qC5tSrCe/UKHoQpEavaciFB6ifVo69yQwA?=
 =?us-ascii?Q?bzsEYwsbfW3O50Ysw5xkme71pVPCt2Q84eBQUGluXs3VAcUUSm/PDzB3/22V?=
 =?us-ascii?Q?8AGVpTBJ/YglLG8Pv4lbm+FnbH8iKCHX1rPjBvc6IirwwdhCheAKFNohZewA?=
 =?us-ascii?Q?N1HC+d0Zm5udJXMBAj96GxvsJp0jnJ5ByRXePt4aP2tBvKeWRz4V6Jjf8FoG?=
 =?us-ascii?Q?apcJiVQx4qbXe+rqpkNzepLF01LcX62oVlehR2m1BD198sHd4CzmUsSwjM4G?=
 =?us-ascii?Q?QKrjzFMEnLQzZMOJP38aQZaDdb1Vaw1Uispuw9qbtuVSB4AtppwLy7dRD4BT?=
 =?us-ascii?Q?WMd/10y7Xdk0/a37Oi9DGaX8HGbRGxPUYPilFB2uC+Ylr7dSLI9YcWbRLDPk?=
 =?us-ascii?Q?ak1z8c79Mw2r6l3vCQkwvFLAg0raYNweYEvzqEaF25gmgr/5Q82ts5+GhDcQ?=
 =?us-ascii?Q?tgItobUn+YWIxoOPePIV4Fd73j7+GCfPDk5HikSeIOmLkb8qhgX0lSE3MGGt?=
 =?us-ascii?Q?VcsIujTBWgK3nBQgb6WA9D8/Tm/ZauZe8meKxi8NJND7FhbrybbvkMPjayIR?=
 =?us-ascii?Q?Heqw/WM2K4Tzh1QIkogKCOUNVxhJxPyAjV3H8dS5HF0kfvL+pzRtMFUFUz6V?=
 =?us-ascii?Q?aqDSN6mVAUIcgYA1r7FlF/1T5aX4Rw3//dAbq+mKDM4UQ/OjIQSgR2/nxmmr?=
 =?us-ascii?Q?qBgboYYs8YEWmBPXIxJjkCu7l+9Rhz4XKG3Li+IA/q9sn3JpGBVC/phyOokZ?=
 =?us-ascii?Q?tMAXh363BX3WpBZwmYaeuG3M0q9uwZ3PgjE7NOUu8ORFtLEF1yrYs7Hg6YCT?=
 =?us-ascii?Q?L1n5bVKp/73tlqrjgTFg0Sx5LtLJLd0n0WnKz6b9GEMEh0+S9trfu+N74BH3?=
 =?us-ascii?Q?8+h+671Va8+F889dHiyBJLrmYHQAA5LvGxIW4jqYsUKLx5i6NrDErZfgjWij?=
 =?us-ascii?Q?Z4iUe35sDFgZRzfIfOinJsiPOFg19hIUnAgOzMhXFzvUg89xCt1oET5kyrpx?=
 =?us-ascii?Q?78foIeG0hZQj853t6Zv5HbPRYSt+Z+lj1dP97WBntOWd7Fn6xpc8ZjtCpDfG?=
 =?us-ascii?Q?vtQ1sYhc+28PAT65DCUdIK7OBU0AS+rpmBaCYMhPw6mh2dCWVMtKBgFVQeOO?=
 =?us-ascii?Q?49mhS1WqMrFMY+6+Co7L7X3mHQmlZwNOyOSP6a7LhtYSOaSKChKk2XTz3DCe?=
 =?us-ascii?Q?1Jbl9Knx4hWOkBeUOQW86um4kTpMiLtrUaskw50VQM2vq0q87mClQIPxgPIF?=
 =?us-ascii?Q?cJ6i6oAwN58=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRTcrRtBbH6KkWzWRXtQzj8Vf0cFINZd/zDN5CQPOKfKO3Nf9g9cEqhWOr0v?=
 =?us-ascii?Q?A1pySLMNB5Q2jojcTFJ02Xc/gJEEYI9TuPvKd5K6bk+tceFXHiMxo7YFH86X?=
 =?us-ascii?Q?YAzNHaKW3g3TFJK3/wFq/SI0HbndIiF93ww2t5Q44oYrhadUX7S9RWiDPPxi?=
 =?us-ascii?Q?xeCBCWDe/BwYGrjHBWn09lVb+yyf3KBuTSt9GBQSjij9aHyvEf2EGWFHsnN2?=
 =?us-ascii?Q?eQ9i3OgZrZXK7IDCQC0B8eysGadjmJqM4dIrWSUbOQT4Z3mdImIo0dpvn5Ez?=
 =?us-ascii?Q?r8cLnCu45wLqtIkxPVx/L5/qu1TGav6RzBnNX1XkfK4kx+J9GG/tULkuiuNS?=
 =?us-ascii?Q?6QCzDgPGtsxeJXx8uMs6OR1Af7JOD0/TmGk3PJTM2+vTKlhtJ/Jiw8ZHLrkt?=
 =?us-ascii?Q?8R9/BTbzlYHepOJXeAAk+O/uKxuTagNiZStAABefmDoAlT9lEoTpGT+Ngxso?=
 =?us-ascii?Q?7y5HCmDwvRrCWKubrJaPgUYsPn+b3OCFicKpHgETRWPGlattwfU1zqH6y1wy?=
 =?us-ascii?Q?emyzwBJgwwgDYeitFD4wqJLlwv7xNM6n16+O7+gdQK77ZB6BkMfubPklIUXD?=
 =?us-ascii?Q?Nh6FQ6ezaz57lY7+kzwLjnhJGwZZFvEgeIlL2rkoMnapgDlFYSAIa3vopc7j?=
 =?us-ascii?Q?Tqtycml3TcgqsV3kuki6mAW8de6VDR91XRqngZLDqQvHDR5FIAuepptHAvvG?=
 =?us-ascii?Q?FJHH+Air5PDr38O/oaJH23l6fPOytiX90Dh05JfsuUIEd01FLKgz+nhKcLRl?=
 =?us-ascii?Q?bl4pPUUQjnte+/aUEQfgmyV2PPmMY+LMfz+rY1qiFpwzV0q/XLRmDiFnflXS?=
 =?us-ascii?Q?O9K4oSd42bFLI7W+6eZM5BAPFlu6F3cm2NhGmLfG8t3cjKDDGZoGLRCNmBmh?=
 =?us-ascii?Q?hiKJ7JHb0y8AeDjDtnm4pyzL/xwWbZ/t3Sbh1dO4MB3O7qDONkJaH6SYvsmG?=
 =?us-ascii?Q?Ne38Nlroipkha5eMHmQ5IMnpEGw5j8IMunvQ1ULy+7EiXudwMHdmL5gBze36?=
 =?us-ascii?Q?3yMOsP8tgpVcpQKS2dkUJ8LjZfXVZbuAWnqyvqQLXCMBsOg5UQtPELE0Duhj?=
 =?us-ascii?Q?4EIpoJVY799eIPLb44hdh072cI6gF2aPqh7lRBsaKqyLYBWK04sCGRGqoIHE?=
 =?us-ascii?Q?feLYAMH+RT6U01wdvFMPaJWXdweiQvogQYLetVTvME5UKA5CG1TdUKCxNlsX?=
 =?us-ascii?Q?RrfP5eUc2WZBDkEHCgADYHVkm0NBm0JtIHRsMFsaunTdVfJhaPspzZAFKmSa?=
 =?us-ascii?Q?+iifCUTh5jr6ry03BuWVYZT0VO1YebtLpiI+lernjyZaPWRhXH5fRe7KKYC5?=
 =?us-ascii?Q?gtQXTs7YSdEt8VWHDfDgFAiBN/XxHWLm3YnCrtqVYtejZUMyAakdH5bRuvnY?=
 =?us-ascii?Q?omkUlak4Sc6OBm/Xq6M2j6YArhWGQrSZpIRqy3R9wFw6nXW3otIm0mODMcg9?=
 =?us-ascii?Q?2llqU/1MEaDcj0qda3FQ37VTFMnusgqQUQGf5qkZMNHp9AcGDVm1chV7QFIT?=
 =?us-ascii?Q?mcFSY/8JSUiTUOW1wWi3nCxUE7grezx/6h8whKbyqEyiy1uBFiHFrxi3xY98?=
 =?us-ascii?Q?BfiDZb73qvJEW+xA/S0sFG7h6hjFIMKMC6KfKaNM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c7338c-e73c-4453-3e7d-08dd93661682
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 04:08:02.9641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhBCCT8ODlLmpbK3HrMnOCdIgpMDns0a3ZWxlXogrlTn5u5hm6Q1vqm50NKCT0zCQalYZeOS9SwRY27BTYPviKetQ6yOfVntfn9S4M4+Nog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4936
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
> Sent: Tuesday, May 6, 2025 10:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 4/5] drivers: ddr: altera: arria10: Move common code to
> common file
>=20
> Move common code sdram_init_ecc_bits() to new common file.
> Preparation for next gen devices which uses the same ECC scrubbing
> function.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/Makefile        |  2 +-
>  drivers/ddr/altera/sdram_arria10.c | 20 ++-----------------
>  drivers/ddr/altera/sdram_soc32.c   | 31
> ++++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h   | 11 +++++++++++
>  4 files changed, 45 insertions(+), 19 deletions(-)  create mode 100644
> drivers/ddr/altera/sdram_soc32.c  create mode 100644
> drivers/ddr/altera/sdram_soc32.h
>=20
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile in=
dex
> c627f16711e..78b0afc38e7 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -8,7 +8,7 @@
>=20
>  ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>  obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_gen5.o sequencer.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_arria10.o
> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_soc32.o
> sdram_arria10.o
>  obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) +=3D sdram_soc64.o
> sdram_s10.o
>  obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) +=3D sdram_soc64.o
> sdram_agilex.o
>  obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D sdram_soc64.o sdram_n5x.o
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index d8ad94f31cd..133d4604738 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -24,6 +24,8 @@
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>=20
Remove line space

> +#include "sdram_soc32.h"
> +
>  DECLARE_GLOBAL_DATA_PTR;
>=20
>  static void sdram_mmr_init(void);
> @@ -194,24 +196,6 @@ static int sdram_is_ecc_enabled(void)
>  		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>  }
>=20
> -/* Initialize SDRAM ECC bits to avoid false DBE */ -static void
> sdram_init_ecc_bits(u32 size) -{
> -	icache_enable();
> -
> -	memset(0, 0, 0x8000);
> -	gd->arch.tlb_addr =3D 0x4000;
> -	gd->arch.tlb_size =3D PGTABLE_SIZE;
> -
> -	dcache_enable();
> -
> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -	memset((void *)0x8000, 0, size - 0x8000);
> -	flush_dcache_all();
> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> -	dcache_disable();
> -}
> -
>  /* Function to startup the SDRAM*/
>  static int sdram_startup(void)
>  {
> diff --git a/drivers/ddr/altera/sdram_soc32.c
> b/drivers/ddr/altera/sdram_soc32.c
> new file mode 100644
> index 00000000000..ccb4266473c
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +#include <asm/system.h>
> +#include <cpu_func.h>

cpu_func at first before asm/system.h

> +#include <linux/sizes.h>
> +#include "sdram_soc32.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define PGTABLE_OFF	0x4000
> +
> +/* Initialize SDRAM ECC bits to avoid false DBE */ void
> +sdram_init_ecc_bits(u32 size) {
> +	icache_enable();
> +
> +	memset(0, 0, 0x8000);
> +	gd->arch.tlb_addr =3D 0x4000;
> +	gd->arch.tlb_size =3D PGTABLE_SIZE;
> +
> +	dcache_enable();
> +
> +	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> +	memset((void *)0x8000, 0, size - 0x8000);
> +	flush_dcache_all();
> +	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> +	dcache_disable();
> +}
> diff --git a/drivers/ddr/altera/sdram_soc32.h
> b/drivers/ddr/altera/sdram_soc32.h
> new file mode 100644
> index 00000000000..4c6137e728d
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +#ifndef	_SDRAM_SOC32_H_
> +#define	_SDRAM_SOC32_H_
> +
> +void sdram_init_ecc_bits(u32 size);
> +
> +#endif /* _SDRAM_SOC32_H_ */
> --
> 2.35.3

Best regards,
Tien Fong
