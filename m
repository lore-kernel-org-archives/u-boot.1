Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80350C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66F0803DF;
	Fri,  6 Jun 2025 08:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vAHRn7pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D8E807B1; Fri,  6 Jun 2025 08:34:02 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFBA800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKT3neur1a5QBZ5raLkq545mc+D4mOFOLJ7aWRMVC8/LNmUkVWECoDWTRaYvike8YsE/zOpWmjJOHz8GZtR2sP9BXZoSBmHf5I9FlX7CM3pn362cZ/mhA7h5kVn8m5nvdXtfjQr8x1vFGJx9KaJ1LgTyOycDcn683MK+LUksKoh6oeCh+uKbCOOAuc3kv3BvaxSTra+iUZzXS/hLmOHIaTfyAGztiIwS0dkGlXbJ1qEvFlTKDYA2SvDZyR4Qxxy1PbwZZDoPmuo50duNw+61nJuZ+OzdTFV91mzDDlVtbUrMS5kQiHrDASOkA7Dph1zzYyrBlPvDbW2GLaIODrebig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmTjI17zwZ/jJwZvWriH6nGku/jsPIa5Bw79Im0bzi0=;
 b=utyp2j0W4RWkZAcugYxCPNtIdDlg6mefGmw8bUmuLhyRWTiMmL9imQGfdrQZZyOQvyb1bzbWC5ZKOwxUEtjUGEj5QLIXn07t1IcISRpGwK61eGbiVfL9EcO7XWKZkkipU2Xqb8TSi9kk3v9pciHYaiZYNO/jdE+PdhPqXYK5+s0V6BLfdep3hIsr+qPIHJczE2v0irJQuqpJut+LFEZyjJF7nq8JmufT1FpSjIZi3PAroKDIbpPL9D13T/aar3E5fR+RZVYz8wQgDJqU7JwDmITzWgrMZap7vgZQrjeaPb8/V4mMngK2j62UEoUms3dwCVmXxQC5BUw0ZLIDGsZgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmTjI17zwZ/jJwZvWriH6nGku/jsPIa5Bw79Im0bzi0=;
 b=vAHRn7pzOwmW0KICuDB6ye4K5LFuX/VezHNEqG/+rN3sMM7GbG8SILsSpHzxDZ2Y2feAKYIsf/gNcdRakuobr5LoamE4YLpnW7NCvXiBknULd15BK206A+PBhZ2zbUexgsp6gA7v36lAPwrUoy4HVBbi92OL7vTc1/Z0Q6B34D3I6eoZdjN7HY5u3MbrUMdbcOtQKgZiwPKi6c77M4MDwsEG6HjQmGmsZgD2Y3yAYLrOIgw0v029HVaAPx6HyJJlmxqAqiRX2fdpziUyF0OE4x3F70bbu0OofS0SGeyHPOEFu/CH9YZuYnbdgSE0MHHwuUpDtmqyBR37ddvsEpjYnA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SN7PR03MB7131.namprd03.prod.outlook.com (2603:10b6:806:322::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:33:56 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 06:33:56 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 4/7] drivers: ddr: altera: Clean common code for SoC32
 devices
Thread-Topic: [PATCH v3 4/7] drivers: ddr: altera: Clean common code for SoC32
 devices
Thread-Index: AQHb1H5Vi2i+DcBDaEur58IxV9sV7bP1sL3g
Date: Fri, 6 Jun 2025 06:33:56 +0000
Message-ID: <LV8PR03MB8137A81C74AC05466CE3E46BA76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-5-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250603115442.19971-5-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SN7PR03MB7131:EE_
x-ms-office365-filtering-correlation-id: 51fa243f-fba7-4561-d75e-08dda4c41d0d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qMfHv1A0S04a5JtNxFbwj2MUp3xZlCf2CbAzyilefCOdzcXUDwaJazE1M3Jy?=
 =?us-ascii?Q?dFZwOM2KKSI1NvWJbzaxmV07KvFmuI6mb8+6znGBCgcAia96brK5ErIDcKr3?=
 =?us-ascii?Q?64HEiI7U1JCSiqi2+TfGyv/NuFQ3GcDkhDvHtuDD5nCkkPXbta4TAkhYoyCL?=
 =?us-ascii?Q?lbYMUnxaQAdL9TmEByLP+HDXbwJXHRisns3AH7Je/0jCJ/cwBXKoCpOrZvts?=
 =?us-ascii?Q?kEyssXCwrjD2iAPpcR6mWzz3xdmkieNEvHjV2WBzcvUOqe+6UFEp4amcTUb1?=
 =?us-ascii?Q?B+7nddJyF8yVW5K48cgHxvpoG2exc/mDcKdL2ENbdyLbLzV+bwzC7n2heDBK?=
 =?us-ascii?Q?3qN8zmC+Zo19wS8rvMgSSCdIB/N6g8LoBz4YBXUonTbLMmgZJ0oPZvZsAdtG?=
 =?us-ascii?Q?Tp5LcTRi3wc78H6hNt7IAHPgOSWZmSE73O4PNiZU7AF+c4WuQuyjzWAG8OiE?=
 =?us-ascii?Q?5wnfk93RhzDvxC5FyyXbcFx975qtLYHxYwLeANaekdI1o3GKYMPyUvrc1/fL?=
 =?us-ascii?Q?fu4tqxIbDDDh9W9Z9bnjTCYrJtqfQLV5nvjaxp7GxG7N6BrdyHlrsB8hIvcP?=
 =?us-ascii?Q?ICU4A4SjnfQf961Jtsv89CGsX+TQ+ea/pMDvKv/IcrpvGdvSeJ3iP/gonFyX?=
 =?us-ascii?Q?D80mhJHy0W7VywuGfHgs6plJ+6AHkq4f4KQQvPgw8lrh1+lCdHS7znWMoEi3?=
 =?us-ascii?Q?LcOMsnrQKNHzIR/cevhAMml1GHdyoNN3UyJsrtgFHAQ4+c55pgiRfq7zgaMA?=
 =?us-ascii?Q?ruBrijYyvHGg2IiJFmglPubbhJYZWSKzYu/ilEU+Ns1JGwkrzmOLjQ2u837T?=
 =?us-ascii?Q?gp/QiJ6TBi7h4iE3vBeoQ1ptlPIENUsz4J1gwsQXTAJ9DYzgxhXc5sr4MDE3?=
 =?us-ascii?Q?db8gOw1b8rgDLaBpPfDBFYpDgpzZoFGhFGjX2A22iDPsFhPzFsyUrO3IV986?=
 =?us-ascii?Q?N1mvrkb0Xq1NXLkk3bqIg3VjxmUI8WU/AZBtd+ROZOFG3GHr4K06v0z+zyXd?=
 =?us-ascii?Q?ObaGUNoq2v7oXfxXgBgpbc1NRRC89XJy54OBi4GFpsPUhAbeT1zbj3sWEgUi?=
 =?us-ascii?Q?SNOw0vcwFlWWm8ol2bLoVNUlzmS8PpHlsiw/os23IhWicgX2bwCfgnwlpbXv?=
 =?us-ascii?Q?+TofuaGR1YQtBVH2oSGrNqGrgJnaXL+z62h0UMJjXwocaxg1Nb0d4hIuPX/Z?=
 =?us-ascii?Q?SxHYR5cd2VKKcYEMgyZgmF10fMafj090ecNWN4cHeit9zW46F8T8NKBQRrC5?=
 =?us-ascii?Q?2lq78CLjen7pmVCdjKUrgbRPe9fMnycFXlsuseclnuwbU+UsPuSx7q5iWzUo?=
 =?us-ascii?Q?fcYLqLY6+iVbK3jM56sUBLuAxQxe6loMu6j93ZOECHw43nTQRUE2uZuOzKdX?=
 =?us-ascii?Q?TKRkCOqWFqjx9DE52ShEDPfX5ZPdq9GQ3buc2vmoTBVRPhYpJTI5NvSLQ3By?=
 =?us-ascii?Q?T0h0pdZ4UUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4aDlB9SkqfBgoxepc6mmPjN6nfx+u2W/r4u2YX1IT+CS1OGsbZr/pOdhNhfD?=
 =?us-ascii?Q?vn6cPNkhIZN+ucp/e5C2DEzH7/zHLcTDCt24w96aMuws7oALjMI0wtAGwmFf?=
 =?us-ascii?Q?MUsl/XSFP48xA7JKsMXjr9wpwBCgz2c2kMOZYzTS7w+tzDxRqtK+jH19wtY8?=
 =?us-ascii?Q?FkEMUTE792PsiLraStpNkI7csjBgoqzsp4a9ubhmJ7WPyBBMECqJF9BvM3D/?=
 =?us-ascii?Q?CX70iir55FR1YoN6QzCepoKEDPLxc3+MndgPL0SrPKnHTZAG3op98fs03/SW?=
 =?us-ascii?Q?D9d13SGIrJELTXqu7wQpw51yR5w6v+r0FFbeYU8MqRhW5DJ74xTDNZdCer+Y?=
 =?us-ascii?Q?VFaxO9tECILLknUBuMhbJwujPVHh5GPPsyGDS9WG1sMly0h+Kj1mHxKE9IVi?=
 =?us-ascii?Q?rguOOlXbQGAPV5w8iJdaE9S+zvaLlwRd1Rtc1iiVoJOCuIfh8CVbzcQBuCRE?=
 =?us-ascii?Q?D26k34qh94kJW1HO8nrBobU9o+pfa9PDfPJTL5XcyAGkEn3CXLyU90lVT/OI?=
 =?us-ascii?Q?jqMPKZ4LBM+RCJ8fB2JfGEiUyq3kZ7ZfyZSgE+1feXybm7LqpOUoBB4C5W+Y?=
 =?us-ascii?Q?2nXc8Cj41RkEBQ5V7QTI2xKFxqYRxvT/BVDG6YcPMPy0DkATaglTofz/4RKE?=
 =?us-ascii?Q?Ti4TXtMiufyEZHwlFRepQiQmA3RwDkh1wL66zARwwjILMXKO3AUXeoBqmf+R?=
 =?us-ascii?Q?LHgLj22dl/WcgEMgCuseN/Oh43vsEf5GimyIoUjYVxXgOpyW2lhQeF4EA4g8?=
 =?us-ascii?Q?N5SQEXKvNmjUdy0dlH9/g7HZjfligHwSTCpksqWIRM/SxTxzsiUb+pSqxgVK?=
 =?us-ascii?Q?V98uIhhXgM5ClbYefdMXxjLYBZoToERcyWoQwpNtlU3BVfZFzpMMfQLNyZc1?=
 =?us-ascii?Q?JdbvHFY1OkTt1Lvp7/4iaonZPB86fQaHgbKP/E2VNEQ0zP/XgA6T2gAPmXM0?=
 =?us-ascii?Q?idFpfU7QakjaTtVq3RBd96RRfwHVX5LNMYQcydUbH+3VpeJoOFRvtfQztisF?=
 =?us-ascii?Q?P8wqFXHmLgL4iw89mDi3ZUnhzNrBOaSwkLDBdlM6UoWmP/3XLBIKelZ9Pw3M?=
 =?us-ascii?Q?U2hsTKWfYbjrBwkAAjnoYfCqPP/BmUY2AnNVtb5UwVKwyDoSjrwHt++eEusV?=
 =?us-ascii?Q?nlwcn1flgW8TgvEm5kzfJAcCBO33AaGaojNYo/u93fEDS5fRa0dDJAY5+rrg?=
 =?us-ascii?Q?MACUw6k3ISwwO/W/7WcprZ5kmepNZOG1UlCctXzzhU6g+xqHPI8OHmGPh9fd?=
 =?us-ascii?Q?mYtNqTwG4o+SxyFmLX3dFE8pVs9c3mbDIN0iyKI76/bB9Wq/335ZF/NIyuxx?=
 =?us-ascii?Q?np5aU5b3qfTbIACKL7Q8jqGRVAxUz6GeQWEIHiKZT7bxuo48VMhDi6IFJYHC?=
 =?us-ascii?Q?2gCte+lc3NGe+9uCbyMO1oiDuxcQS+iog8F0Xfd35MEdzLcVmjMCNrgCnSXf?=
 =?us-ascii?Q?Zty07H2H6FGBhxih3q8D1JlZvf7mzLfO7XKBWmoCD0Xwsm31mgZNhI4AV13y?=
 =?us-ascii?Q?Lav7InrdjBmjHhCHlOJauBk8bPV9kLPWGzOUhDl5Oyoehrq+iSNERGlY9VmZ?=
 =?us-ascii?Q?4D1nX9pp0tW6sklsnTD2aKUyQWxXi+rrAJU5YUGk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fa243f-fba7-4561-d75e-08dda4c41d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:33:56.4045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuRsFWy8Kyc2sUii1OaQ1uAgGAddzY/vMezVnqxkqqpL9AFQu7dZ6aAKdmwPgduR908b5Ncc28TS2yO2zfkgw37C7poqLrqHFkjmMzDltSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7131
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

Hi,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, June 3, 2025 7:55 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v3 4/7] drivers: ddr: altera: Clean common code for SoC32
> devices
>=20
> Move common code sdram_init_ecc_bits() to new common SoC32 file.
> Preparation for next gen devices which uses the same ECC init function.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/Makefile        |  2 +-
>  drivers/ddr/altera/sdram_arria10.c | 19 +-----------------
>  drivers/ddr/altera/sdram_soc32.c   | 31
> ++++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h   | 11 +++++++++++
>  4 files changed, 44 insertions(+), 19 deletions(-)  create mode 100644
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
> index ba6f0f4160f..4c48b1bab6d 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <hang.h>
> +#include "sdram_soc32.h"
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> @@ -194,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
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
> index 00000000000..0b928a2352f
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */

Move to new line below

> +
> + #include <cpu_func.h>
> +#include <asm/system.h>
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

Move to new line below

> +
> +#ifndef	_SDRAM_SOC32_H_
> +#define	_SDRAM_SOC32_H_
> +
> +void sdram_init_ecc_bits(u32 size);
> +
> +#endif /* _SDRAM_SOC32_H_ */
> --
> 2.35.3

BR,
Tien Fong
