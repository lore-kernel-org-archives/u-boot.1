Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052CBC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3271C803DF;
	Fri,  6 Jun 2025 08:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gsNmB7Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C54C807B1; Fri,  6 Jun 2025 08:28:34 +0200 (CEST)
Received: from SJ2PR03CU002.outbound.protection.outlook.com
 (mail-westusazlp170130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C440800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHQNHbMV8nczDLsnI7dlivMcflRs6fzbXNKXdbR3JCMy9F59VER0Lk4SqZpMj+Jf5rudkx/M7GteiZ8WBPBAhDytL2HkC/SJw9WVQHpJBkYTr3pX+ahu0tcbtiIDYbtrmrmwfQQIMvID0dpZ3XxZLJ6oU608PQvqBjE5KLLKEfkET6aY6TrNyQKfuv4MJgn52K35Xpqj4nbyyu+OMCXJbibAWJd5ZbT0qqM+y8SUFePf8T+U3fohdQhaVzPqRKygqxdWhVs3pedMojKMN1rraI75zIQeqYZZjZwNU4CubSoss1F1SXA+E4JJTL7nqJ2m7JMTDcsSIQKFSa6F0A1kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1hI9s0PXi3Wb+ofwlIX/4ya+nMuqvJ1jUyOg4qbYDc=;
 b=GYSTwY94UCEzbbXYk8Q/LUlIJIde8QSpBTkbsr20nPtvZVg0NCeqDX8IcToC3dFl6M12+kfPpGZE1rFOrAdAJ1H5PgrlAGjvKC/Q4PXRR8ABJL8s1A54Gt/5HOKhETeeNsDaPUn3Rai447JsE2cVhAHM9eJ1QFWBjg9IsNW/kc1B7jTIS+F+HyGBFdpjfAycMfSRk/m3bHPg0PYFYot15Nebo0KC/cFGw0E23wce/+qrfNAx8of7D0dJ/dWLXmu/IMQOSFx+VIO8lUxeS3ERam1gaDSClbAumBlcJEkN4g87zC+5iM/JNaLtHKImGy1cTjmODFDzkDUK6TBlcWldnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1hI9s0PXi3Wb+ofwlIX/4ya+nMuqvJ1jUyOg4qbYDc=;
 b=gsNmB7HnTNfOWl/7I2xONHaGfghJS6Fwt8KwdZEFXi5Bw/6/XvpE/KaF9XRDEu4G9n/UZM/ERrjx5STOSE+2jE+1Lla6AjiURDrDCSS97QF5DYR4wreCwtt0/X7CMAhBPF7tATTftc8czxP/WwImv9JCQfsDm/RDPu7Mjol72AK/k+dwiQdsb0BxoA0A/wKpWwPQBMuxEIol8ZjdFymgijrzpyWyR+snZ21MJVfL1AuoBHeIfqx13vfJmgfEDrL258OOcEQEDAdkQ8DXKaZa53oS7S9zC/J7QwTRoAgsIwBEAJTnGsY5r0SKOfD6Aw34sutZqFFFbaxnXYUdK4Wggg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BLAPR03MB5588.namprd03.prod.outlook.com (2603:10b6:208:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 06:28:27 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8792.038; Fri, 6 Jun 2025
 06:28:27 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check for
 arria10
Thread-Topic: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check
 for arria10
Thread-Index: AQHb1H5V8d4M0PGcL0WkoSNgSy/pWbP1rw4w
Date: Fri, 6 Jun 2025 06:28:27 +0000
Message-ID: <LV8PR03MB8137377105E0819B9F6C6466A76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250603115442.19971-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BLAPR03MB5588:EE_
x-ms-office365-filtering-correlation-id: b2d4e625-a487-49d1-5d8d-08dda4c358e7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3XZMmr5EILnlb7vWpR214HufcDuHmGBAHKvu3arxtKlDJnquDHCGsbfaPs/z?=
 =?us-ascii?Q?WufBF1L3ReRAIGHy2FClaUn6Oj4ei6ww/+n2ApV/Kqv9Ec3y/NOaWcEdzeqY?=
 =?us-ascii?Q?EgqwyPkUh4E3PGMLQMTayPS0tjVvZvICiJUDKDY9IR9VQakMIYEml3gzy8eZ?=
 =?us-ascii?Q?hcLYhXMAeSZnX07hy5fUEjWnlOPV7PSvwcAI2TSEDRfQcdsRViN0cKxUDgMn?=
 =?us-ascii?Q?9P8GawQB2bw3ilHDsulSLQywAwPfqNhmfl+X8g/J+VET/zmSXVcB0act5Mai?=
 =?us-ascii?Q?gEdiksNpwt4y/Wushw7ma/dkOreM6Aoxv2gob2CFz1f5rCLAo99Ff/sLVmeQ?=
 =?us-ascii?Q?n6Evml+6TYlDA3/ogBtPDHFErcqSV8zfL31Y7ItOgFWY+8QeRLMVIByVBSk1?=
 =?us-ascii?Q?YKmhkTUWt/YWLyhMmssvv7QeRj0bA9R6Ilzp3FsrTZsZ1AUkGKPJyd/Xku4X?=
 =?us-ascii?Q?vq0njhwlhdBjqQ/rYNFtI6MQQF4CvOxywD4x/E/APQKoudvmFlOO+uVcm3yP?=
 =?us-ascii?Q?OAJuE7Fs77Cyj/T5RLqRjPApxqJgqw52LL/LbIjjSFbHJ2bztAgrw9RLxuU+?=
 =?us-ascii?Q?ZjgSEKBULwHPxJHRDHsKQmYNTo7ajXC5Pia6mQxdiTiZLDizTLepF+XE0c+9?=
 =?us-ascii?Q?AsYRu774II86JnJ0KGycztLoMb+FJeUZyGt2ho0udvN1xlqX/pbXs2CTPRqK?=
 =?us-ascii?Q?yv4CKXZlbGQiPMh7xc8h35HvUbjKNSxbB/6oIKfZZHfPuZMSy1DXLH3xLqPz?=
 =?us-ascii?Q?zsZBl4RXgErsehdN/ChyOyJY2srmoYNDb/8VcHhAYIBLupujITWYi3CD9Soz?=
 =?us-ascii?Q?LWROQBG+g1vlPHBcIQVZqvGGTqCjM1yMatbF4KtACYT0pD5da6JNg9Mkbg8z?=
 =?us-ascii?Q?DmX3zAAlZHFT/v5+TgipZ5Wiz39Osmx6ylWwc2YAy+TzKTJERY+EDrlM6mmN?=
 =?us-ascii?Q?6yV59gqc8tFFxAigdRo1s0uULRgzcEhrabpnK8Nu4g9VfgIMcecX3Boo6gaP?=
 =?us-ascii?Q?PhEz7NbOIAK7zcHaVVRrNNpreOcY/Rhr/pe0NIBk/nbyEmu9YXKbQlgh5iy4?=
 =?us-ascii?Q?p6pBDapDFfeMAF0ET4WQhWCCRlL2Fj1fKtg7o4RTWbPkJSqT8+d4DesnnIt2?=
 =?us-ascii?Q?42P37lIaQw6FpST61Y3zdYgDpLFOQ4vOa2UJ029keOBatnKOCWM3TrNc3+KS?=
 =?us-ascii?Q?FCp35BuhR/oBEXOqGYYIDMor6x5MmXj/uZ9fQC8fgvTVomWakNgmEbE3ZKfd?=
 =?us-ascii?Q?YhLzDVHsvtIrAxlahs9h0XDrZ07FgfwGmDZZoKILoOxJtg8TnjxKL8pf4aKL?=
 =?us-ascii?Q?yujk+VrNDlH7UiDXzIMtkjNwUnN6HTVuIlGlWm0dGTwrKRS4XAeL8rJ3R1ze?=
 =?us-ascii?Q?siS6pT6jTTk1uhMGY2dhJknFXeHNa5p07vqwDP4C9Q72K9UIMMJm5v2/r9p/?=
 =?us-ascii?Q?PRjhy4hjw6pIRsJWIv+q9KcmzDKucfmPel4CpBhztko5lrNuSUaxUBxciAh7?=
 =?us-ascii?Q?6By3GGI1uIFc/HM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9Z3wXxo38MsRabKwXBiXfdTuW4TTpm0/3KU70FJXS/AmmG+bzcTO50+zpWL?=
 =?us-ascii?Q?zzzRLCNVcFMQHSDxUHH8gH+yCzQv6q2ct+2KuQFL88lEpM+D+338JEnqxEFu?=
 =?us-ascii?Q?YSSbHWDON5M0q69xbMJ4OPU3rDNrxCLTvVmQLBqDuFkgT2rsc64pR+y2/B0J?=
 =?us-ascii?Q?UVtfBBeSA7HWzLWDCTSrYgr3KEM35RoIrjRvnss/uDxhuTJ2OQPWJGLGDMVi?=
 =?us-ascii?Q?CwCHOFD1lWCy9XJUaZpEOtRQc1oHDtOlAApo9OnT8+EHotAX7O7oLINXGBiV?=
 =?us-ascii?Q?gIV8dpKVuKzGCnuEkZX/YU+f5PSIP5i8ZLIHGu8s7ESvEXM5BJjjgO6jS3MB?=
 =?us-ascii?Q?kfR1XLsnVv05dqQ4bT5jbvoKRdhk3dDg+Jd5EfCrN4bHTcqumSUaMDRNxx4x?=
 =?us-ascii?Q?AmOk3gmXeLMPcnW8Kq1ysF48SxexyDRBeTMDiU76oxkoTgFTteucrKbvKpHB?=
 =?us-ascii?Q?ZjTba5DVbZ2uSpIvK2xD6xyvKC1J9DMTnI5wiGWPCt5rt/ZgrfmbPtK0cBAY?=
 =?us-ascii?Q?jOX2jtqXglNOfTs5mV36E7sI0bRC8q+UJ+ASkDZrBrGSV2VgZmxIJrbFpoDE?=
 =?us-ascii?Q?9m63/P2RStjEIgHA2EKbAK9vSvF3HD18JykzyibAoqNnZzigItEGgaEuiIbG?=
 =?us-ascii?Q?pfUqvXimvROmv1Ntl8RFWQ1MFAI2POVb29n/vDFKieKV0Qma4Oup157d1Qyr?=
 =?us-ascii?Q?wH6cekGJRe//D0qrg4eTYgu/lad7cvR2taRn9TQSEzIqKKdhvxWIpryoDJJX?=
 =?us-ascii?Q?2jAJz8Byvi5HhGrlVQtbqAQA2fLwXi/6LXBBzCFG59tGBgxaNE4jqZhUw/iR?=
 =?us-ascii?Q?i78UF5n9g69xZIKu5TJ0XJeslPv0eYVoVcCJml6aTe3UgxfZNi1ajcfjLAD0?=
 =?us-ascii?Q?Fiah9oJN/y51AmVUXZ+qrljojyuBa+HOqhj5pyrnPKQ7fF4INbYpfW7wVr6j?=
 =?us-ascii?Q?mVFjpw5ofLtvFH9ifYgcgh3aI8QWcz+144L2aicAcK0jOVGTjrDoRKXGxOFg?=
 =?us-ascii?Q?YjYlsB7fCZLNWiGrK9SqRhm22Yq+Accxn4hZPPqbbgz59ZhhtFhDNtRbveKe?=
 =?us-ascii?Q?rvLiC/DkxNQWed9dAMdVI92dHu9FdN5ieIhDc+TKQJXwKIy30ap4ELwGqeu/?=
 =?us-ascii?Q?BG7cmuxCPIUTqIhueI0fvjH4d9aAui13NahXzjAUhKEWLjgQwHNj95WRX8F5?=
 =?us-ascii?Q?46U4PBQXPSweZ4sPnJcHeGkriFg7elkjsirjtcnwGgCrYAYVAv2xnNMzLPoq?=
 =?us-ascii?Q?e5F5jzWDOeAL7HHeJ1An4AlLjVyXUXmuIRln7r4a+tbZWc/Of2B8KJVpt92J?=
 =?us-ascii?Q?308boa8AELp1DncXXKf9ouRQRQpoepkUiFjF/zLo/2a74fEKEBILMB/DrbWZ?=
 =?us-ascii?Q?YQL8b8a9ohj1TuzSpWI2hzgc6Y05DEgzP/EUMh4+FTMUm1/FC+yzL9gFN7L4?=
 =?us-ascii?Q?NVYWqgfWl0YhD6RtqaPItyU06BAoIK3A3v/VTyvWJ4oZuGrT29VrylubQeQn?=
 =?us-ascii?Q?PqFz86ET1jbWG9yHpdXTbZrIP9MMJQ1oXkZN+JP3E8Xw3QH5Rzm3FYXMEX19?=
 =?us-ascii?Q?81SVjMGw9ETno9ZqHbgW239B80YRWpx+rUpCO9IX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4e625-a487-49d1-5d8d-08dda4c358e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:28:27.3507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Za6Ab+Rq8lJVuINVhaaEZWtxkOesjeuiLSCJUqjkleHgSdtet6cAChz/2uF6/RxAhmTgiB8xjDlvofKPl2zXiwGdK/228WEB+/1qkubQ9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5588
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
> Subject: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check fo=
r
> arria10
>=20
> Add call to get_ram_size() function to check memory range for valid RAM.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index 088dc1cb33f..7d7bea153c8 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -22,6 +22,7 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> +#include <hang.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> @@ -668,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
>  	return 0;
>  }
>=20
> +static void sdram_size_check(void)
> +{
> +	phys_size_t ram_check =3D 0;
> +
> +	debug("DDR: Running SDRAM size sanity check\n");
> +
> +	ram_check =3D get_ram_size((long *)gd->bd->bi_dram[0].start,
> +				 gd->bd->bi_dram[0].size);
> +	if (ram_check !=3D gd->bd->bi_dram[0].size) {
> +		puts("DDR: SDRAM size check failed!\n");
> +		hang();
> +	}
> +
> +	debug("DDR: SDRAM size check passed!\n"); }

"}" should be located at new line below

> +
>  int ddr_calibration_sequence(void)
>  {
>  	schedule();
> @@ -722,5 +739,7 @@ int ddr_calibration_sequence(void)
>  	if (sdram_is_ecc_enabled())
>  		sdram_init_ecc_bits(gd->ram_size);
>=20
> +	sdram_size_check();
> +
>  	return 0;
>  }
> --
> 2.35.3

BR,
Tien Fong
