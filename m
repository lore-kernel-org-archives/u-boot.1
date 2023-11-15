Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF3C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C515863FD;
	Wed, 15 Nov 2023 11:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="WUhIiMxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B6C8082A; Wed, 15 Nov 2023 11:37:02 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D188863FD
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLqrFWD1193EWIerY8xftoCzXGfxuY4Jnr11UR+1qNqW23MjMW7mzOA7EM76Qo/Biin9WGUPL0YW2P2sL9Rq/51OFEY2pHY0VTR8ZadY60YrmIK0xukmqbvzDMrewem6bpKIhm8wjDWXn66Vl3/bf042H7a+l3I0Sz4uyggMi9WEZ+q2w6OFl5mFIRky2+mI6OrBTdPVY+zjk4bZqoHu9TNG+ltvntTswIv28pmelUC0v+OGtTaZFScuw3ZlJDBm62QrE0aH9iCfv2EDNqgRYAo0UP64q1RHpAQDwhjkFJx5rLnQS5C8YaZxP26EH+xbR4V2zMv7O3mEcOYLurU9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gl3ER2ymD05uVxKhz+TU9pglVFAuFY/ZFNQHWoVR3k=;
 b=BHE/CVYW2V+dPYR3UAsbf4BUiZQCLLAhhMlUvmn9OKSIrbaOyDdUtJbvV5mS42YYtXPo7EInTnk5MIpCJykbJSMibRYgaPx8QcbZk/xdts3sspEiGl8JUs3hNSRPQz06Uhd2HF5PrQzva72ULj95fRsXtgM7bqG/b5REW0NNi7JWBfg1cofb05Jx0zpBZtskT4GE3lstGvzTUd8eZ4AHEJjFISe5nvG6csxU5xw5ITyaY7u33UlPKeMDyav/fE4QlNrfrxeSCSMDob1XvyhDBuDwj3ZWJtZ5hon/X4JQhexUV5jcpOVQBOk2E9ldBnrCxNds73xpQqdm4X3xnfmUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gl3ER2ymD05uVxKhz+TU9pglVFAuFY/ZFNQHWoVR3k=;
 b=WUhIiMxXXHjHHqZ1oxauwyCjQmb9TVPCFQvqoBwBTYhp+C2jOmJQ4oRbL9+F4VClhICdnDbN+gV7FuxjtXeNBbPosofMwJ7KGZ8I21if8sQZogByj1K5C/kEhWA6xyTCOLrnO3ne9unSiN8sYMR8J+TcbG2tb/W6s5oXWdh1aCLHq/UnPBXgKiFkpjmjinKSMq3WpVRzmaNgVzBMu8ZQPAWG1Hh5B/JronqpkFaWlYYDLBsHLMpZyOjux02Vnx7f/HVz8hFf2mECAeMNRzjfhrQ0e3aIcwOdQ50pVv1R/0XpeE0T7TQ1yu/TjN2G4dJuwzegEkswOn7W1GqKh4X8bg==
Received: from AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10b::24)
 by DB9PR10MB6641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 10:36:58 +0000
Received: from AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::959d:55cf:e3de:6e35]) by AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::959d:55cf:e3de:6e35%6]) with mapi id 15.20.6977.028; Wed, 15 Nov 2023
 10:36:57 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: "hs@denx.de" <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: "hs@denx.de" <hs@denx.de>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: RE: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
Thread-Topic: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
Thread-Index: AQHaF4ZM7EJIa4qiXU+zfdjBH0iKB7B7MALg
Date: Wed, 15 Nov 2023 10:36:57 +0000
Message-ID: <AM7PR10MB37364EB893AFCEC4765D42DFFFB1A@AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM>
References: <20231115054044.3937543-1-hs@denx.de>
In-Reply-To: <20231115054044.3937543-1-hs@denx.de>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=82b3b45c-b42e-4a4a-9cfd-825958094276;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-15T10:36:02Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3736:EE_|DB9PR10MB6641:EE_
x-ms-office365-filtering-correlation-id: eeef77c2-ff6a-4b55-7c0d-08dbe5c6cb39
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KQVPV2DR0UH3zq1Ry0Mqos0Zv2MUHwMnREbMgCMu8GHVtmipK/2EDgtRN/MCzEkMwg1rGZG+8jYYW17d1vjElFK7AqjKsVNHlukSA0/xyLDs2Vb7ggTy/RF6aQj91Yqtgp7J1lPq2BH7QFeYjvp4Ox09UT/qP6ifGMu+btAYr1qNYfroADrQVio733riserwvadqpsKdIT252nBxDGmTmw5Ddl4qOWFTs/lsuJmHfzj5CAsEyY828Oxy4O8+K9FxW8LYKOGlKO5eyattVsT76OsVTr0sUQu/bQd5Gqx3IgZcrUEzo6SPFD4gyIhtO3p3gTDr9+dIs8KpQrlgnxfLBl0QsUPym+hSCNHGrLy1dRMUHu5MR4tnoQYlw8z8v36GPSPdP5TDkHyOmfEBRuBOOZJ/4Q0umQD4UfCODD36NTeH4hLD2VuIIUrc0npZzj6hM4LjaKG5pAC7SkJAY5hwuuRHgDKru1hd2ZQNxqVQOTYB/eD9yLSWiyFwwzs8jArYU3ryUHxpvXuPlgC54W9d9EhGRFVSWJYgBL1X93MG7yZSTFUYzqkxKc2POwCge5FXVDpSicEqG7uyWCnJqSLkTUQjElsMrTD41Tl1vlhtjo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(110136005)(316002)(66946007)(66556008)(66446008)(76116006)(64756008)(54906003)(66476007)(45080400002)(966005)(478600001)(71200400001)(5660300002)(86362001)(4326008)(33656002)(38070700009)(41300700001)(2906002)(52536014)(8676002)(82960400001)(26005)(38100700002)(122000001)(8936002)(55016003)(55236004)(7696005)(6506007)(53546011)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNRMbaOR5Swne37beYPP+qP80aP2mN7+JAWGylirHJtdVAlQFvbjwwcrBr+z?=
 =?us-ascii?Q?gp1MZJfH3BjZiG8lWgVJ4A0Z3wG7Ie1rRMM4HNXtnwZfrLJz57GpRq8kCfbm?=
 =?us-ascii?Q?ejByNdeFr2LHhfDD6AOM/rEbg9m9pt6/9xj1pxMXIzpr23CI+DtbVDN9Qwbi?=
 =?us-ascii?Q?Sz6KW/7Wbm38qkpJRZJooOlyqlK/1KiVsPTISshLi9w5lQvClCPtRx3ZvqZv?=
 =?us-ascii?Q?Ssf62k184BuGI/8EalF/CHMWUUoAVF+nNAbPms5J/KrVPI82VkD3Ebm6j5yv?=
 =?us-ascii?Q?cnveELy1NZlcPBdaUypq57Ea62vp9N6Wmu7PHfvr6vBc7o1MLTBi/Hxm7W9E?=
 =?us-ascii?Q?lu68MBm0UncbzeCW5i8UdnSUn2x9DCmpuggVQ/FzWwNQ2fyo5s0BIQ2WWGZx?=
 =?us-ascii?Q?NByyV5fUX6cwyZkK3Zeyb0APjmYfQ+O/fi+GWZ7CTpI2W6oe8dzUF9X55vfa?=
 =?us-ascii?Q?x32QPNblhBzTi/c5HtjJwt7jOGX4o5SoOP3pvCQjvyLmZEVUXIZwe7+68SfF?=
 =?us-ascii?Q?g15vXumDE5JoulVHUfoSfc8aQifE16lLDGx15ycOxyINY3Va3k/C5sAL2VlN?=
 =?us-ascii?Q?+t9Hld1w0Gc4Z1fCqVuo5pM7J5ahtiaJvVdagtPPFT3Sey/qtqlNLt51d3b7?=
 =?us-ascii?Q?GGOCjRUN7yREAhXJBQbAUnLwx97RWO4MrPTZWyDM/kd/j8ynvnHwCv0gWlF3?=
 =?us-ascii?Q?yrgianH4eaxm0gXLVgULold6EGh/L5AG7VK8jn32GbZVo4HlwdgnmxCuYzCx?=
 =?us-ascii?Q?IHlc60SbLyZkQcS2YgR4vzjQEBIC0isl0LDOMqjUpPLadOjBmFcar4KLIcNv?=
 =?us-ascii?Q?tojLGTh86eJPpYDJB9dsyWEccP6l66wGd7sIL6gs82Xr+mG0iWSUMtFqOheb?=
 =?us-ascii?Q?2ary20BKPr3Xs7QqN1Bv4oneZu1rV+rIGFF1hMd5g45j+lHGAIWT9jFyse6x?=
 =?us-ascii?Q?0gqCL7n6Z/93qistKTDBOgCka1kxk6P73DQmCC8AvIHbJWdFCUWNdY+ythm3?=
 =?us-ascii?Q?33iD7BUpMRpAWYNs93asvaaYSTuEv24GdXyfsWfikEcrrDv/FLMRoW1KSPj7?=
 =?us-ascii?Q?6k++US6MI9+MxXnLQUNk5v7JvElKBF1PZbyLam5cOiYg1/J8mncXuVr9Yl4l?=
 =?us-ascii?Q?QVXhdfeg5tSh0KeivlKUfIKGGSMn5xjfdJ5rf+5SCn3aUmn6IVyfwwm3vLO7?=
 =?us-ascii?Q?qWzXG2HJoqqfpPMhjl3Fvlvj+BiOydbpt0DH3r+tSaMiV0BulGQMWTSLXFRb?=
 =?us-ascii?Q?TADzYKlWx1PJ5Zft7dgLlXssdHSuZi2K5SnfDncgDphN9jGjSiGf3jsvRRxn?=
 =?us-ascii?Q?8znlnqa+DB2EzJCggvV/Ne24OJvc7k8GDdTiGD9Au/iKP6mVZV+9C/xbl0wU?=
 =?us-ascii?Q?Hl7I4hRc6QDgbgtJrf7764nf8zw4xvPsGcGX1VARII4DiMzL+o02r+0a/02E?=
 =?us-ascii?Q?eg8upmVAMSsE8+49NXwHbCR3XgWTDfxvs1gqbJHR+xiarmIBWiMHhaUaU0Iw?=
 =?us-ascii?Q?JNUDC9uzzTpm54FHSGKi2CSUOt+lP7MGOoM766VIQP4iZQCXS2A5iseHWKWj?=
 =?us-ascii?Q?921dxsdHkri9Bv/Na/lsegyx71dyZLR3k9n7FXvG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef77c2-ff6a-4b55-7c0d-08dbe5c6cb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 10:36:57.8266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TObT9Caj6iN1jRRR11znvz55L/d4VJJvVnO5bcVbX3FXzcESlSlWdZnF7BGMHmN4KjcOplpkfdWhP8Op2xR5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6641
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

Patch is working by me.

> -----Original Message-----
> From: Heiko Schocher <hs@denx.de>
> Sent: Wednesday, November 15, 2023 6:41 AM
> To: U-Boot Mailing List <u-boot@lists.denx.de>; Leto, Enrico (SI BP R&D Z=
G FW
> CCP) <enrico.leto@siemens.com>
> Cc: Schocher, Heiko (EXT) (DENX Software Engineering GmbH) <hs@denx.de>;
> Dario Binacchi <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>
> Subject: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
>
> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based
> correction")
>
> broke AM335x based boards booting from NAND with ECC BCH8 code.
>
> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch() in SPL
> restores correct SPL nand_read_page functionality.
>
> Tested on draco thuban board.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
>
> ---
> fix NAND boot for BCH8 based TI AM335x boards
>
> Fix is based on series from Enrico:
>
> https://lists.d/
> enx.de%2Fpipermail%2Fu-boot%2F2023-
> November%2F536793.html&data=3D05%7C01%7Cenrico.leto%40siemens.com
> %7Cbd939f15167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab4
> 2e1495d55a%7C1%7C0%7C638356236545245361%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DIUqjryYUtp%2Fdm9GgCALPTl8f%
> 2BlcrO0ErXjkvoDwz7v4%3D&reserved=3D0
>
> and fixes NAND boot for the draco thuban board. But this patch apply also
> without the patches from above patchseries, see azure build:
>
> https://dev.a/
> zure.com%2Fhs0298%2Fhs%2F_build%2Fresults%3FbuildId%3D111%26vie
> w%3Dresults&data=3D05%7C01%7Cenrico.leto%40siemens.com%7Cbd939f15
> 167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab42e1495d55a%
> 7C1%7C0%7C638356236545245361%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3DS2itRHsR49lD9TlBexYw9J5waXiuFcS%2BhUp
> %2B7Yi60MA%3D&reserved=3D0
>
> which is clean.
>
> Above commit seems to change only U-Boot code and did not adapt
> am335x_spl_bch.c, which breaks nand_read_page in SPL code for AM335x
> based boards. So use in SPL "old" hw setup and reading page from NAND in
> SPL works again.
>
>
>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c
> b/drivers/mtd/nand/raw/omap_gpmc.c
> index 1a5ed0de31..c9b66dadbd 100644
> --- a/drivers/mtd/nand/raw/omap_gpmc.c
> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct
> nand_chip *nand,
>               nand->ecc.strength      =3D 8;
>               nand->ecc.size          =3D SECTOR_BYTES;
>               nand->ecc.bytes         =3D 14;
> +#if defined(CONFIG_SPL_BUILD)
> +             nand->ecc.hwctl         =3D omap_enable_hwecc;
> +#else
>               nand->ecc.hwctl         =3D omap_enable_hwecc_bch;
> +#endif
>               nand->ecc.correct       =3D omap_correct_data_bch;
>               nand->ecc.calculate     =3D omap_calculate_ecc_bch;
>               nand->ecc.read_page     =3D omap_read_page_bch;
> --
> 2.37.3

