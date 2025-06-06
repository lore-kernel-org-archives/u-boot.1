Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32433C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C263A8291D;
	Fri,  6 Jun 2025 08:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bFkoMNed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986C182998; Fri,  6 Jun 2025 08:45:07 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37406828F8
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyNVV0R4UHxH+UMS5VveO6ynYKL8W+wSWUiU9faIHvofYFli83Uo/6vhRC0AKa4JdWD+Hqif0OjagqYXU9QR0ERlW6eHxc13KYknqPZ9MiMPoR8GuBetCerHTjOLjX6B+HhAimi0b8rH55yh+ZCsNWfIlyP7L/20ly/gyZxguFPaz6HtVFLeDZpx/nxKBb7l4VEcpjJgmMdgabMMeKsP86li3xIStUArvERRciFaR45dVUb1cci+LLKUXHD1L+WzPiPmRAOVF6fsKPpY5Zx0q50k+N9eXWr6mQNfy6s9a+kYio+AUg4tFwE5URy3lUNjzv7lwKg9wh1jDwZTyOa6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f6+yxqvCthGJPngVFpliRv+ZwPeZGPfzzS3EJmQ9/g=;
 b=V9pE36T5mggpxUPgZcWvRxlqNX7TE0UMZ8zxTKjk5TEGMjywtEJHLBQFPIgO3uJNO38bidW8fNmK9QaErB5RqJbOVNbeFpGGk2ALU2o4phrfL10bXpEHL2hf65GJepJ2d1Mfl7hu0PKKoJFe+UmmyNC6xo3ZP0oF2wI1Cgm8kUSwQLQ82Yr7331+rHGMplQx1Qt4RT19ttQVQfaPtIRvnUkEjc1jHPgGHhIq/5UKElDHrMVnjq/KJSuZ5Qz4XpHq3l04QRs401kceXLdfVtct9wDBHFWDOABbHg4P9KPCPM5AGZ/oSTH8IetRrcgVuWODgjHgs6/j+dD3eUgJNhB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f6+yxqvCthGJPngVFpliRv+ZwPeZGPfzzS3EJmQ9/g=;
 b=bFkoMNedRSan2Zjrb4YXLJczdVXi+uoxyS3S0HE2RRcSNPC86Dhhbx3qEQKlYpWk5+9DoweLtI4AAJvE0FE0oY+e4ULurRs2BtYW2ihKJayrBvljpwhYPpJ6V+6NYCQS8S+NzsWR0qAiQLDdMSmGhO/ZD2KbPS8CleRKmSbbfciNP13xFR13RWw+CAzSd4SilC3NHzdnbnTT9+yn2uyaBYqepLCDipQoGw3HVgSvgFfHIDzBVPIYwP3gER1GjK/7QsJcbkl7oQ16HF5aQz19iSrDGdt1AKh5BehC56p4LRZiKedoixO6MYuK0rw/CduYvs8/teYbNuc9hsTsYArvbQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SN7PR03MB7131.namprd03.prod.outlook.com (2603:10b6:806:322::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:45:00 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 06:45:00 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with Dcache
Thread-Topic: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with
 Dcache
Thread-Index: AQHb1H5WG89FykA+aUWRWhTbgceWtbP1s62A
Date: Fri, 6 Jun 2025 06:45:00 +0000
Message-ID: <LV8PR03MB8137A464CF2A9747F13D5DBDA76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-7-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250603115442.19971-7-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SN7PR03MB7131:EE_
x-ms-office365-filtering-correlation-id: cb1a54de-cde4-4474-c447-08dda4c5a8e5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?inxcuf2yPDwoX8n9sGuYB3MopFUFcOMLLzWqfDvocZsAvLvl+Y0EP/Dj3dEm?=
 =?us-ascii?Q?mmQrGCGjZhc/jit671/XiLbsQWip9S/vc94auYj8f3qkTB3Qf/jK46K27/qx?=
 =?us-ascii?Q?ZQRvDseU9Y9SeZqwdLGLaTTvXM8tRbRC6B5aiiB+1b4QjVhketMqgolMSBpn?=
 =?us-ascii?Q?JzdPKYZ1Y30q+D31zByfg0N3/LTolfaqMJZBuXWRlLihQ/WMJ+hn4s35Sj9C?=
 =?us-ascii?Q?dM7f06oPhNrqq2idVfi+1TRLGIpOtIHYRpj7iZmVSWU0GTWfbFQI07W/p8mO?=
 =?us-ascii?Q?+/k1cSo4+0EJgKeRVywJwfSbBnS0yuz44pJsT7110dV7qD+Mf3aj6qJBhdPz?=
 =?us-ascii?Q?4WYDAoVrYN/jH2gXv6DzydFs5x1M6Tqt1plSGFtNgbup2ErEtxaz5Rle4GSg?=
 =?us-ascii?Q?N/PypOWPxL21Y8FQ9Ju8L78k2a8kih2rXlbdDjzuCrifaMJqICuuTB/MOFlq?=
 =?us-ascii?Q?yB3NnvCs/3C5yhGbvQ5GjfUnhKW8mndZVAJwBzmsVdnzlVQkCYIh2nj1YPWU?=
 =?us-ascii?Q?bBPYndnaMJcvzZOARlX+56Gd5K2Iku4h24A8tm4lQX9UfTXkHWdNQUQpxb8W?=
 =?us-ascii?Q?B38pJpbdq8aM9lt9CcoeO47mSbpRV5i4VqtFNsIS08OGqn1G/SDyP1gugJ/p?=
 =?us-ascii?Q?qyW9Qdghm27j8dSzkjeAC/mTu3fPjgFUrnxQ3W9Hur6jh++52MY/U0D8Mi2O?=
 =?us-ascii?Q?FHnTvLj0xBDITZQPkAZ1Bl1E5erSFSxybsfrotlJr1ea31Tllw1OoDrolpAQ?=
 =?us-ascii?Q?bLIPZsyvDdd3Mucr6KjgOIRI49+wFfySso6+malI7hFIZa0JBmvbU+QlM3K1?=
 =?us-ascii?Q?qGnZvexXqXqay2eWKe3CP8nQGmlOedNi6vdAwzQyIz/2Y0s2KAmkqI8ySkGM?=
 =?us-ascii?Q?9zFwVnQ5pDoLrdLm5kqZICzl2uGdFHWPBoY/zZJh82x2qvkYdQl9a3e3BcSq?=
 =?us-ascii?Q?i4Vhqiq+BWMWpl9oUWt3/SzV0CZyDFhcPDKHOIsy3s6lH/OgZbq5PkLshpWR?=
 =?us-ascii?Q?tFj0sZzFCWV2WUF8JjLzxg3/1FsOoYS2QlaXwn3wn7j7pDO5ENYLjRoRMuCX?=
 =?us-ascii?Q?hCtuHu0dywccq3nlE+8ElAabr+TEe9g1MBx3zNq7luFRnumtqVCp2ZXxW/eZ?=
 =?us-ascii?Q?kqsruebQvoZGpawmqBAJhlwiGO10svLg9FQ33rMGGh6iuXR5MF6YE/6/AEQI?=
 =?us-ascii?Q?dR2D35AwMg2zSwpcPsDqMnHX4AKCO4a0r44kINN54VT01tUKnxkipHsvrYSx?=
 =?us-ascii?Q?JFkzrGE3VmcJ0G4hORMjzwED0UErcTKIrB8P/oyLZ3fGXtwuOh2020JZv99/?=
 =?us-ascii?Q?3ucR1hdB8LcC+OUuXlRH39z9zbfrLkrnKO0iCblUpjbuCPteV/AHWovR/k0s?=
 =?us-ascii?Q?H4+IKH9L1q5P6QwHGQROTWDnw67nwQ0SnywOb9a8RPfwt+Fzd6j3k8mhk0F6?=
 =?us-ascii?Q?Zvt0n/tijcc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQRjiRjJONfR0oerMLP40JIvE8pVs0nwDZNxdxpGPwA3bYnWwnPuqmcAqQMN?=
 =?us-ascii?Q?8KRFmGAc5iPUHpa7bbcgf7KnWCanhxNqLeItW4K01g1hn6VdNiStoFYHWtZy?=
 =?us-ascii?Q?WU9IYCSq8BWUcdIHu2eEFyMYo7LyMaEoXf+iHyEeeqHMxYBLJTDqEdNMcjnp?=
 =?us-ascii?Q?dv8OGigUC/1xUwXwzy1OyCrF2naXmtP0umPE+ximy2B6Zm0o9uqSkdv9G9pK?=
 =?us-ascii?Q?FGrPUGlbtqXADP8BzySKqKJq8lVRtU2QafeblopIXVYjbReiI7675VuQNllu?=
 =?us-ascii?Q?shxrFGVfgEhys7BE5A5qZAocI9qqAQJzbfXLdYLUWnfqNVNXjBnrxk8WLFE/?=
 =?us-ascii?Q?xBfHyz+BM1J4eP0eW7griz8/TiUG7/mYB1zESH+xxISfyKbJHefVqH3LBowZ?=
 =?us-ascii?Q?+HpQWTKMLKSZNRiLnNRQKnR5ReeILb41/c37mWB52a4B+bEpDNu29LCOa3z/?=
 =?us-ascii?Q?O8tspaKxbu0n88PjGqw4AOz1Bx28E+AdX82IpGnnRT2Ehm1B6JFV4lMX/W1w?=
 =?us-ascii?Q?6mkGncl44hixDSFV34RtNJPTQDKG761gDlR540z+Ubzp4sKzeMm1zo5bUcss?=
 =?us-ascii?Q?I+nXfHZvbrXQmfTfLVaNHOQdmitN/tUE7ytZ7/wqy1gWZiYA1naNmnseCBu1?=
 =?us-ascii?Q?bSBX2XPq3+YnGdCW8AeBOcCMOAsyp0bnVNsB3tklpWtPntLdpI8J6UgMly2B?=
 =?us-ascii?Q?M1ihZU5nqbP4913eGOo9+Ny9HQODl2QIGYCf9RHAPu2UkIzs+guRdL9FIQ32?=
 =?us-ascii?Q?5ntOYaf7DN0i5FngnLfkNgukFMKdsrdkmTNq1WWoSUF+/E7Rssr79ObV3+zY?=
 =?us-ascii?Q?nAww6sS0P/Zrc0tKCtj6aaSJYR3aE1N4YNwJ71eJamqy3o8hr0XCRamJO44o?=
 =?us-ascii?Q?HZ5dJ8qkjj/ONo9g3nt5ZBg2SWBoV40UBCI6q7Ir84XdCEaKcpdb9dhHE6uy?=
 =?us-ascii?Q?c9rOEZiUJ6ukU1UNqbMOilbIsgQ8Z7bUiZBQHoCEW3oMwMjUEi/pg7Krn+48?=
 =?us-ascii?Q?rbzKxZFq89SZBSaBmmwG238BRKtaFEAr1/s2WitAJVnt8H2lHCAFnUlK2yaK?=
 =?us-ascii?Q?mF+sAyVFHpYbOy44RGWBKfXBgFpgy1ThWaNUm0nVBumjmEAZOn/NBCCoJqwn?=
 =?us-ascii?Q?5UqEx42zPbMRAC13azsKr1G0YgoVTOQh5LZlXSKksPBxVc0/A02AOt0V4pRf?=
 =?us-ascii?Q?otC0NNRyhTgozzaroj31s3BFVlybucbEacyDiG6Bh7LinTbhhYPSIv44e46D?=
 =?us-ascii?Q?JW3RXtDHTPdYI6hcQYjwHuYMZ/mqDlg76FsRZDh6dUjJQDbO0VswqcAwPoL8?=
 =?us-ascii?Q?GDdlHl9PDDZZMAm67LVWJ8SAI+zR/GMp8EP49OrFOJjHq/+K4gNeQd/1EYS5?=
 =?us-ascii?Q?x6O8YRUiEXq57ek07WJl8CeSz2eCO6of+WhpoDJaB/xSWbTjiL5IkPYTxtjN?=
 =?us-ascii?Q?7ZK9GG+nHBE1mpwzgg97NrkgPupeKpkQbvM8rL8mWrVduZ+KwF1CcQ0QJA+H?=
 =?us-ascii?Q?UmLb7jbpcIP4S4SkmfuuP1ZnG0RksYnWeRgXAj+rl4dtfHEEMcQmQlcfEvpB?=
 =?us-ascii?Q?yIBL8qyk7DUTYBWuI9YVnUje1a7uCNxU9wUyF/G+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a54de-cde4-4474-c447-08dda4c5a8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:45:00.5444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81Xf13KInftKZUILiznotZIkr/zyHB+3024W9sv2WVN1uOQgZDVXzniJTi+ir+QBr1P8FBVZKyK4IgKZ0ZpG1HS+IFDPIPj2nHigMuanJ2U=
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
> Subject: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with Dcac=
he
>=20
> Initialize DRAM memory fully to bring it into a known state. The process =
is
> improved by enabling the Dcache. Also, if hardware watchdog is configured=
,
> it is reconfigured to avoid timeout.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c |  3 +-
>  drivers/ddr/altera/sdram_soc32.c   | 52 ++++++++++++++++++++++++------
>  drivers/ddr/altera/sdram_soc32.h   |  2 +-
>  3 files changed, 45 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index a1288d5fb50..6cb5002208b 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
> -#include <cpu_func.h>
>  #include <errno.h>
>  #include <fdtdec.h>
>  #include <init.h>
> @@ -719,7 +718,7 @@ int ddr_calibration_sequence(void)
>  		puts("FW: Error Configuring Firewall\n");
>=20
>  	if (sdram_is_ecc_enabled())
> -		sdram_init_ecc_bits(gd->ram_size);
> +		sdram_init_ecc_bits();
>=20
>  	sdram_size_check();
>=20
> diff --git a/drivers/ddr/altera/sdram_soc32.c
> b/drivers/ddr/altera/sdram_soc32.c
> index 0b928a2352f..5cdf48d2d01 100644
> --- a/drivers/ddr/altera/sdram_soc32.c
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -7,25 +7,59 @@
>  #include <asm/system.h>
>  #include <linux/sizes.h>
>  #include "sdram_soc32.h"
> +#include <watchdog.h>

Moving the watchdog.h as first header
https://docs.u-boot.org/en/latest/develop/codingstyle.html
Please refer Include Header section

>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
>  #define PGTABLE_OFF	0x4000
>=20
>  /* Initialize SDRAM ECC bits to avoid false DBE */ -void
> sdram_init_ecc_bits(u32 size)
> +void sdram_init_ecc_bits(void)
>  {
> -	icache_enable();
> +	u32 start;
> +	phys_addr_t start_addr, saved_start;
> +	phys_size_t size, size_init, saved_size;
> +	enum dcache_option option =3D DCACHE_WRITEBACK;
>=20
> -	memset(0, 0, 0x8000);
> -	gd->arch.tlb_addr =3D 0x4000;
> -	gd->arch.tlb_size =3D PGTABLE_SIZE;
> +	if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITETHROUGH))
> +		option =3D DCACHE_WRITETHROUGH;
> +	else if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITEALLOC))
> +		option =3D DCACHE_WRITEALLOC;
> +
> +	start =3D get_timer(0);
> +
> +	start_addr =3D gd->bd->bi_dram[0].start;
> +	size =3D gd->bd->bi_dram[0].size;
>=20
> +	printf("DDRCAL: Initialize ECC RAM (%ld MiB).\n", size >> 20);
> +
> +	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
> +	gd->arch.tlb_addr =3D start_addr + PGTABLE_OFF;
> +	gd->arch.tlb_size =3D PGTABLE_SIZE;
> +	start_addr +=3D PGTABLE_SIZE + PGTABLE_OFF;
> +	size -=3D (PGTABLE_OFF + PGTABLE_SIZE);
>  	dcache_enable();
>=20
> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -	memset((void *)0x8000, 0, size - 0x8000);
> -	flush_dcache_all();
> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> +	saved_start =3D start_addr;
> +	saved_size =3D size;
> +	/* Set SDRAM region to writethrough to avoid false double-bit error.
> */
> +	mmu_set_region_dcache_behaviour(saved_start, saved_size,
> +					DCACHE_WRITETHROUGH);
> +
> +	while (size > 0) {
> +		size_init =3D min((phys_addr_t)SZ_1G, (phys_addr_t)size);
> +		memset((void *)start_addr, 0, size_init);
> +		size -=3D size_init;
> +		start_addr +=3D size_init;
> +		schedule();
> +	}
> +
>  	dcache_disable();
> +
> +	/* Restore back to original dcache behaviour. */
> +	mmu_set_region_dcache_behaviour(saved_start, saved_size,
> +					option);
> +
> +	printf("DDRCAL: SDRAM-ECC successfully initialized within %d ms\n",
> +	       (u32)get_timer(start));
>  }
> diff --git a/drivers/ddr/altera/sdram_soc32.h
> b/drivers/ddr/altera/sdram_soc32.h
> index 4c6137e728d..85a951a5a74 100644
> --- a/drivers/ddr/altera/sdram_soc32.h
> +++ b/drivers/ddr/altera/sdram_soc32.h
> @@ -6,6 +6,6 @@
>  #ifndef	_SDRAM_SOC32_H_
>  #define	_SDRAM_SOC32_H_
>=20
> -void sdram_init_ecc_bits(u32 size);
> +void sdram_init_ecc_bits(void);
>=20
>  #endif /* _SDRAM_SOC32_H_ */
> --
> 2.35.3

BR,
Tien Fong
