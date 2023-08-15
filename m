Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4A1C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 01:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FD08662F;
	Tue, 15 Aug 2023 03:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="SKxfr0bB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69B58662F; Tue, 15 Aug 2023 03:34:18 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D5B86970
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 03:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chin-ting_kuo@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVlPRhEhrWxdxJmfov2rZ6/HviepbDjKGrr+Z5ze6I/R5ZOK1DGGbn8hhoonbyWL8I37EIBeTfNRoObUZI/SG3vu2hTg38YvzQH5Rh2CBCoLPi17xjr+UAtj2tLDqUWSvZT5ViW8J2qNQK3PCJr0ToiFId3iOWVi7lrJM2MZ8d690QogL8zf2qVtDXPDlZKAslHUl+cKWp4ynHe6lIeM5CIGBNZ9yrdIXA7VvPQB6MsvAn5thfZsfgeOQdUQXI169LF4t25xS1VuiJeQynlI9CV/m1oQwIY0tSNKzQHvYhqTWBtOVjEeowYF/PGV6mtGiPiXFmcD/1ubQ+po8pj7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGrtHRP4AzqEYNTM8RfNE9ZJB018rI89bO/RckgOZo0=;
 b=WdgBxlNL0YC9qcudO8Co+eAAIS6PtRPhNpcZsYr1Wr+hKuodHcPBFoIfO5IAjkjM3cBlT7xdMtw957/vEocI4OsqP5Wwfxc5EDxKy/TZ9igeJnSZ9dow5A6dpg3TLtXDYzS3z4C/hEkLJoYD4DOOy2x9iJQAE2RbB/Cr4JDhuBLbF5yjTQ9nHLGOSWDve673/zSC0A+mefvikSN3f9o4+IPPvaOUX27aQ2Z8Iz+V4T2s37myGlHxjwa8T5hZMM7Suvr1xUcAkp0M0cQIIeC1pAjdPK9EnIZeLrC/rcTbVf8cm/k2Gd8XOnbuUWGNzy9qwq+zuNBWfz2Zpu5kejHKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGrtHRP4AzqEYNTM8RfNE9ZJB018rI89bO/RckgOZo0=;
 b=SKxfr0bBWV1d1QFpTbjHm9AR9kCc21Xu2AhjmsOdy7lvk40AQGzZtSScY1BAyZDKL5FCNTVG6VS51EBdEYZP9Cu4GBDidGSgfy526zTzpgR10ylEyU0CuSac4P8rm9jK0j1vicJaKw++RHQP5wvmtEMia4kkqmnvypfIFvNMmKCNCzS0VUFXnFEViumI8qtg8MI4sB24BzcPkmyXn3DPlRvKCz1EaMKLw0B3qMLroggVuIHU58L+OJG5D9JQpqJ2iMa5teeNcpizPwEmUjo2cYipvrY6f07KyoZtiae7uuHyBRLnYjW/KNgFnwipEQ20mYoYcOdAiKScKdobsGqiUA==
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9)
 by TYUPR06MB6174.apcprd06.prod.outlook.com (2603:1096:400:350::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 01:34:03 +0000
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::c404:538d:e090:f7b]) by TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::c404:538d:e090:f7b%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 01:34:02 +0000
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: SSunk <ssunkkan@gmail.com>, ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] Add support for XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
Thread-Topic: [PATCH] Add support for XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
Thread-Index: AQHZzFBvNlfC577Na0Wd9x84H5Wdd6/qmIWQ
Date: Tue, 15 Aug 2023 01:34:02 +0000
Message-ID: <TYZPR06MB5203D6FB12C1475C8AA88FC1B214A@TYZPR06MB5203.apcprd06.prod.outlook.com>
References: <20230811082000.4277-1-ssunkkan@gmail.com>
In-Reply-To: <20230811082000.4277-1-ssunkkan@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5203:EE_|TYUPR06MB6174:EE_
x-ms-office365-filtering-correlation-id: 3dd4837a-99d8-4522-0d24-08db9d2fb4eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kvq0UHUkZVVoUIJefLYarjcUdxPdw4McULnjoo70D4TpcEQ3zFK8UZ+hCV6wGFaFD8WkndUDhBUIVhYAMXrpKPegUsA75t5PDOmMNmHN4tZlEYvdCesEAoNfOiSTmUm1BrqIDUZdVLylzw0IgVBj+x2VZkjbBdHRflxcXiVv+g5ZDtHhBMiKHPsK8dIbocgDt24iVnKGlF+gB/7Ylpg9oOO3dNr9kS2uXOA9IKYf/IXxaqZ9zsdUpP6+t/nVhy5l21BZ0TbzRAU/sbxTRctYWPYyseQsQqUrZnVKazabeVmnvnh8CMccz296HootZH7GNv21uXoO2meNHb8H882mdiI9eDs7M1drpIMDSS9Kx4zCC6yBeMDCO1gsQAR4QbQm6j16z/CYOm8lIklmlJiH/bZAi+C6iXR1fFdzUtGySorq5B+5zV0SiokZ3q5/14i+GKfTSxb+YdLrnczE0Gylqf/bPitdnRPEj7bQ5XJUKOxlIQ6YDrtDfLGLB5Xwex+SeFAACQLAE//HwrVeg9BGX8UV8+JYs6fTuBT8BlmPsVdT80P36lM0r/3+ARsUKAUH+xJybEMIDoO+OsQKI5NXVIb7BGWqWnaFUf103BOVQE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB5203.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39850400004)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(33656002)(83380400001)(86362001)(55016003)(41300700001)(478600001)(38070700005)(66946007)(66476007)(76116006)(64756008)(66556008)(122000001)(9686003)(316002)(8676002)(66446008)(52536014)(966005)(110136005)(5660300002)(4326008)(8936002)(38100700002)(26005)(7696005)(2906002)(6506007)(53546011)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SP+rhb8kFcWeEH6ATew9FdIVIHPMOTZTK+hcfvXhyFz4UktuW9E8rHoNjiCE?=
 =?us-ascii?Q?0lKQoP0HlrOUg3kB3NpWhxXzozWXlXm1feXtpuWL3CcWJ5ZwO1xnUJd+xcJO?=
 =?us-ascii?Q?jiOu8WTR7w+qKzhqi/o4r/NmG2Zs/TZVaDKi7QaHagqlXj2XuvtH0zXa8jDi?=
 =?us-ascii?Q?20mfZ8WloH2Hfg2luIs9bH+DMeFADDIAJ/sblk9CmiKwJFZyhzqrDi0YFfOl?=
 =?us-ascii?Q?5RfXXHs/mL0fvHMNqzMyeiUoXWQdW9I+8U7RJFUL5TrpuCbCNz+2ROpLNg8h?=
 =?us-ascii?Q?ZVEsSNzLrxmPTRsPCOoVkHcnF2fKgDEb1UTZCfX8zs2Gv+7hZB1aceVuNmZ9?=
 =?us-ascii?Q?gyfLG4F/do+r1gOxAxYaNJrkM3Vw4yiZljurbDPRBLvM5zi4BR9IQKxn9w+H?=
 =?us-ascii?Q?7kQZJ1BrRK0PQj65zXkH0z//AF+Rgk7afnE8ikF25EhkO40jGUImlXf8alVc?=
 =?us-ascii?Q?Q2UCXMr7Gsnd6nSiFCPHZ00Dej9zlVOL5XSAbvr9mjoFMXX1z7OkUsQkGSp5?=
 =?us-ascii?Q?QVXrofhkZGd1IfSeqdQyPeeW1/cpq6UzvElTDhnoMQHRNHnWpYzUVe3uW12u?=
 =?us-ascii?Q?J6kuAQeDKjsbVdUmXb1DpLxSv0ALFeY8rgY9nZo+jZa9cBXgRmlP47oyqrL2?=
 =?us-ascii?Q?LULetWylYP+rW5/D10fLmwTNZgsc31aS0fqrbKlayC0UZ6jJpTkSmkW+LYA3?=
 =?us-ascii?Q?QshbsdHS5x5PikwduyT97txGeeND+z03xol7DjkAwhVz1ejH7pD712bgctqD?=
 =?us-ascii?Q?DgRz/QEPTYop3eYzmTzT/r91xYAcaukS7nDysfYyBG9hV7ZU7KCtF5jM/kcm?=
 =?us-ascii?Q?EuUu6dRepE/RTYh4Xv5oIKmx4IBhVWl0ka2NIf7mTjkKG4YFv7fB5A1WzyEU?=
 =?us-ascii?Q?RBvNDS6vJgYXd7yMy6HpyMakxAurQ2xlWDbvCO/Z9KIRwIMB9f+jbyXQSpdh?=
 =?us-ascii?Q?WtfFoMimKMsf4TSxFGAzc125s0Xmu0XcUmOlU95f3dUlvzXmaXu1WHKR4u6U?=
 =?us-ascii?Q?inKv1kO1zT1oHngI8nJadM2kcy2RksYfhRHNnit69uSb/DZZVztxYDvOP8rS?=
 =?us-ascii?Q?9ksgF3TgmeapFzSDPUKD3SQZ6AQN6MModTlo1LQxKxBetNowlh4bp3cjIcmt?=
 =?us-ascii?Q?VoQc+Rh4CrTCyqj2A0zQKQaHMI/iiIxCTe4Il7MkVY1FsIGIiNHan7d0ihBJ?=
 =?us-ascii?Q?ijWqIK6cHuw1vd3emfioXbLxdFFUnW+BFo5t4vF4Zyq0tD5m0rHcToSEt6bI?=
 =?us-ascii?Q?apfh6rB1H0ccg3R1CGRQj60vMosBRN0ZAU9Ur60WUD/dPlkq6PkSs08T2vfj?=
 =?us-ascii?Q?WNAT0Sq/d75JIqU8nTfoxPRpqze1FTzL8MKqgl2dNbJWqmLH7/pdgATH5i7q?=
 =?us-ascii?Q?sRK/eEOF4/OF3CRtvPBSGl999wB8CPQesIQ2l5LRy9SIxFlwp2t77wFWMuWe?=
 =?us-ascii?Q?8JDnL91fb5f+FR7ajoT1FdAV9iVkZss5tfjv73GCRSYE0fgDaHUkYyeypOEy?=
 =?us-ascii?Q?Rr371CdkfXpRAK+5kjVFTLTil3QQMYSTB1oEgsVaD89dQOiOF5Sc7FBBcZm/?=
 =?us-ascii?Q?HB5/cYCF7jOLEqFg3ddz6jKKhYGe8uoNpHjdu/UNOqngU+q6S2fW15XYQWix?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5203.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd4837a-99d8-4522-0d24-08db9d2fb4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 01:34:02.6980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQCBfeIJ6fbiCZNZPNC23swpAwx6YZGvwyI4M8342tXcwxmjrAgk/OffS0V/ESboHjjXqFGO0A9D/PEaE7k1T8yipROuNHCI9b2Gq/CdCuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6174
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
> From: SSunk <ssunkkan@gmail.com>
> Sent: Friday, August 11, 2023 4:20 PM
> Subject: [PATCH] Add support for XMC
> XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
>=20
> site: https://www.xmcwh.com/site/product
>=20
> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> ---
>  configs/evb-ast2600_defconfig | 1 +
>  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfi=
g
> index 9244654c82..f06c0e1fe1 100644
> --- a/configs/evb-ast2600_defconfig
> +++ b/configs/evb-ast2600_defconfig
> @@ -100,6 +100,7 @@ CONFIG_SPI_FLASH_SPANSION=3Dy
> CONFIG_SPI_FLASH_STMICRO=3Dy  CONFIG_SPI_FLASH_SST=3Dy
> CONFIG_SPI_FLASH_WINBOND=3Dy
> +CONFIG_SPI_FLASH_XMC=3Dy
>  # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set  CONFIG_PHY_REALTEK=3Dy
> CONFIG_PHY_NCSI=3Dy diff --git a/drivers/mtd/spi/spi-nor-ids.c
> b/drivers/mtd/spi/spi-nor-ids.c index 4587215984..80d7678293 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -531,6 +531,10 @@ const struct flash_info spi_nor_ids[] =3D {
>  	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K |
> +SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_XTX
>  	/* XTX Technology Limited */
> --
> 2.34.1

Reviewed-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>


