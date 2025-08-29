Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5918DC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D702383443;
	Fri, 29 Aug 2025 06:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dmUSGJiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42800834E1; Fri, 29 Aug 2025 06:53:25 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D628341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JURT1Zy3XrpShPsqnoxzgw45S0DAgXVC3jDGZ58KvJbFdtydjMHlC88XbqjT4/gGZIQf0nDrn3XuSz/JKT9CqQ5HUMlEiMFwwznqDTzfqQwoAS4Pz1nlHVV4BldfuB6iJb+F1RQjcgqEF6Qoq2yYuyj5FsHNxUyOEe4ir91CDQyXMoyYj+AaffWQS8kabfIepbPzxOVajXEkisO/6l9yuxRsWa/tIE/1o6qLO81VWVaWlWBW8+PffTcAYV/gMuUc4jvq1d8i8HRE9JmmSZzjrT0kBBiuTn1Xcy79oAf3jQQhdtQzpzBH8R+LMVrGiJluDEB3c99jhZOwzpbqBvZdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KsyXMVcDzmS6tlnugWWczc5cnMWf0vZaUpN6bh0J9g=;
 b=Efwilc75kPOFvZnhC1M5/frXvsu1AhLTDzircqtMnzVaN7HvEwKlvvTcCIy5+nBkk50T3KqvSChT29hJGR3Wkbf5ccNAsd1lDT1cdgOm1itvVQejlLiVG6wt1cTNXpiyL5jE+u34+UnS+IDOLGp5W+cShqWwxjYtzhoeK+JBSY/rw1yHyqL7CAvyYG/mvBsy5N8TPRUYyRuFoNbf5SXdtXYODWSibK81KTeZmNAB+GvjKmOUlPSNta/QezKGwlQxeZfqMuJArFbGDupuNEaoZM3n1W2MXksWn83HG3AwGZ124XNs6iLYvGj3RRftwBM7/MfbzobK0Lajo0+WpaBzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KsyXMVcDzmS6tlnugWWczc5cnMWf0vZaUpN6bh0J9g=;
 b=dmUSGJiVfmLe3xWEKbBTho0Tg57B76v+5UhpzxjkYZiIBxcMfFJMpuPGBe16fyyShQxrvdvaCEt3hvz6Hc+vKm+Gmyapc7U3aCDpX6G/G7cf/M+b8bKWnVkHi72FZyVF0QvSg3EAaDvUZheCIj1HZVNA/1oFUIU5MhFvnTWUq7wemYdwGps/pKPyM8+yPL9fgtrBOBPUSgnOAMBmwn54P5h8Pzn2RimwZGoS5/0zBFU3uodLooAt0jucmSQ7Fx26ZQWlWelor5VwHoLTNPPnyW57teQ2ABtjhvkmxD1fSECBAF/W7BUwiMtmsMzf5HyEF1bg/K0giJyRGmZY1b9rhA==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 04:53:21 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 04:53:21 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Thread-Topic: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Thread-Index: AQHcCEvTOtQcdbw2VU+UhXPmgY8WFLR5MQwA
Date: Fri, 29 Aug 2025 04:53:20 +0000
Message-ID: <CY1PR03MB81217107F3792B7D947FC26BA73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|DM6PR03MB5081:EE_
x-ms-office365-filtering-correlation-id: 49f6e825-180a-4b78-39b9-08dde6b7fa55
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0PVzkFsjzxpj2LHMKlxfaeIomZfyLpc10yid+s5AYF2MdNS+MLAyvDGl9GUS?=
 =?us-ascii?Q?teH/b5DbwVqrgIuwKxgd5Io4/H7B6s6KNazzAPcJh3YI+oGpaGlsaeWUgwNj?=
 =?us-ascii?Q?zyS+7Cuaw1JeKrJSeY0SOe2XHGfrMttYi70FPWN6Gp6OZ8lyTZMhmlNDlc9T?=
 =?us-ascii?Q?qCGS6RCDzyGEFJOSu946Dzcf5G9CHaW0lJJBvCoEZcpQswmJ1KN5F5t/Z4r7?=
 =?us-ascii?Q?DH6XF4DDApIqVmKriev3RRgompnqILBRGi8uUyoYa+2oT5Jd0MV7zECYvA0Y?=
 =?us-ascii?Q?8Ld7mmkerqwPgmEjjHhWJi0dBdOSLBqWfB1JeYn7RrwOc+ChxwKDCdL7CqC/?=
 =?us-ascii?Q?d+SmZ/P054gu5YwZMk+drClQSNM4FS1vwJiE6WgOBD5X11OWGchU0ZX+DQo0?=
 =?us-ascii?Q?e87JVsztXaMrkAKGam+6BXSfx6x0yPWbK7TmeMavgM2IeaJ5n132LoF+E5FT?=
 =?us-ascii?Q?Eeo6z932F8liL5yCoDdBc3vHBzDYbyLhQe2WwbfRqmmYIFQdGeOnAF2UClqy?=
 =?us-ascii?Q?666LOm8ZZq3OXp7EJQGNnPPBebihdfEepcMhrrXWSNEngeGYZ1h0bNZZgqXl?=
 =?us-ascii?Q?3OgAa6w5GgvVoM9+TzWK9VvzloFeSRYpPc+Jb3nKpLXHbpkKtSNgfk005otX?=
 =?us-ascii?Q?4Iw+Clk48VUsAcuBTV118aZ96CMFIn7Is0BSJ6RzK5fqxcmoOgIZEHxfwCT2?=
 =?us-ascii?Q?hh90H5YfahyUygKP/4dyi+9tfEGZQBVBvzzwRydMiuMdK5uHMjUHIZ5288R5?=
 =?us-ascii?Q?3XVylJxLOnbl1mkMsrgzgWA3QOGGvtyqdObVyutSP6ZB7xAVOojF6IiobYnZ?=
 =?us-ascii?Q?KEuiZ0vfrXcSKk2y9n+OZeSols+aqwm/2K/sgC0o9LQ9XEjrezas9JPLQFxc?=
 =?us-ascii?Q?q+CBOTWWl4V87WCL1hvUIHAVpax/qetTHnlyEGkaRaXG+3s+rW8+cGLL2vaU?=
 =?us-ascii?Q?s+9qqb3I67v6Mu0us8tweY/WUMGWyGdhQSNBS9k8AkU9OxPguuapLqLcgAQk?=
 =?us-ascii?Q?PAI+M6cWFw2+vWt6waxib/yXz1dEuVAPYl4GHAK2aB6+SKP1EjVHSlrhK/jp?=
 =?us-ascii?Q?LRE5pmVFWhFLYjLIjQqfkhGdlRCXlZJQ7mKFw8JgPZhA8GK3dSQNNG3cE3Uv?=
 =?us-ascii?Q?AiDvHSwCDVPR5ASvN6hRtWmnPC+BVZLfCoft59GmtMyOyHcFrKdK2HR52n5n?=
 =?us-ascii?Q?emUd8ahtyWQf/qWaQff5JcSaNGpeDz1e1zB1sQj6gJgcNAHJM1wMqp67m7Jd?=
 =?us-ascii?Q?wvTKwX8kstgCTfdAr5a6h6TTUQYLQOxppJql0ULI4JcswOIAeW9GTMw8oghm?=
 =?us-ascii?Q?Sy4qH/3bdE6LWoCtPhogGezjmKZQObzNCfpKxjbxX9xVb6iFhrJ1xI4jvLqp?=
 =?us-ascii?Q?JuhocdXSH8ItUOmYjeoSEWZE4EerYWCvRubogb1w+8He2rRwWxVROKPUlJsY?=
 =?us-ascii?Q?23qbMX9liE0/6PaM/BbuY8qRSrNPYo8NpMqtPZoFz653VgCMFDS0OQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HLWbRFzTNgA8EtxCJ2I9CJhQfH3H2M5DsRl9Jpjvl1Lv4ZOnkJ3CrPRvypVO?=
 =?us-ascii?Q?OLr6yTaeQSENTbmWN2ZIbdST+tiBcOp2Rcc8thRW1hHWw9SH1woQug53485K?=
 =?us-ascii?Q?+gpxqlSSJj6q65RR2vK0k+43qHLRMFS7yBPyQADIgDhWTk50J0OpSx6jzI12?=
 =?us-ascii?Q?tLpZ5ORje+z04p+meeLFjGoXCpknSlUQQ/F5Qv+uN+PgS9AOxKCBIIPs63Kq?=
 =?us-ascii?Q?CqJZc6qkJyL9AHJaMYHpLwvETjdHHVa091G30QdGui9WpkOhDylJljv/mZ3p?=
 =?us-ascii?Q?s/GnLkGMj6lLtoBQXlZxk/ZsKV4zBfc7T98KS4FPkzTQDA+EczzqH/DMPVtO?=
 =?us-ascii?Q?Pgy1wUjk2j5T6KZ+orgXCzWYExF3fSR5lPHOddSf+zGLNDFTV+mkenRhEdYZ?=
 =?us-ascii?Q?+IUwAQ7EO3TqHVDu+Ch9YRk1v0q+pWq1HfVF2axBbiXox2dLQzDnGR2F1EYF?=
 =?us-ascii?Q?frz4cJ0aFdZNJy/QaJhaR3i10cs2r9e9W4Kq8sX4YV7FDMAAe/mRF56DEU5J?=
 =?us-ascii?Q?XuiGB1JlykxpDPf6FAgI4oa8yEz7rDfaSxPdSh6ozExTKUhQKD9Qh6ue7AsV?=
 =?us-ascii?Q?iwAc0CyfG/bE7BQMtT1wcvYUuFub8Csbq6WsYryH2hpZaDEZoaQhOLf42Qcn?=
 =?us-ascii?Q?9B+TScxSo+hSBmpZFLI6N5alhOKUnuqATmBdyixhOvXnvJZRV1hh/1VqkhDW?=
 =?us-ascii?Q?6AxfpWmcf5e8apMLkXMWYW6Nb7UF2xDI6Sx+t0pnrJt+UeTZnscxuEmFyVOU?=
 =?us-ascii?Q?6jk7sUnChyxvekpEC5nyR6ISmGBx0xPhGXnZZCiKblr+eJqo2fONdnuhazbI?=
 =?us-ascii?Q?Nl4smcQDm/7ISBL+1+/nW/5d9k6m+/il2Jku4w1ixwZ7VhDCk3MApPENxFQ9?=
 =?us-ascii?Q?tl2BWq1M6kaZ55zQNU+70LAPEJIu+wupWYHKvjZOB3us6TwwFLSkkCZ9x6CQ?=
 =?us-ascii?Q?6m+jFpm3UM0dUb+qBnTiADyA5pdwVp7klsOPTrYTwJTIfNf9DqWjyBUX0qwK?=
 =?us-ascii?Q?y/wvl+1GdyXU2PPqKJwXFbJCiTRgUhc6/ab8ceIu+kk7XbPnsLjRBzmXOQ2C?=
 =?us-ascii?Q?dZdGxaKbqWPtKssQXM9ACm7Qd0eq+pKHXYot+zZ7agC92v/tUJ42ES2VQj4G?=
 =?us-ascii?Q?2l7bN2N8BcYFScjTvpqSQ7lvq10W8YkVT04Z8n0vTISzpTUbz3+GMRHp6MDx?=
 =?us-ascii?Q?FAsZU0S9zhXIvfp3DnXSiG+IY/3cyWMOZjfxigXvia3/Tr4cuUR6icdm7Bz0?=
 =?us-ascii?Q?xOH4gtxK/4wEtcN3Uri+1OambCFyn8HeGjNzTnPsDT+Nxgxd8HzOZfwTZiKI?=
 =?us-ascii?Q?iFih1IY/GWaZpXNxSAYCpQS/hstn/K30xmYGWiIoL7a8ALhzquEET3UmcQav?=
 =?us-ascii?Q?ff3f5zHcJi4N0/d0Odi777s7cFMH89/DeiGNYu0vIBxUgZLvdEUUu8DbmC3M?=
 =?us-ascii?Q?NFns49jqGJQ84KX2rC2BS9uDE7/uTP5olYaOX9VrHueZHrZt7Y4rGhdOzV7e?=
 =?us-ascii?Q?fSCAsnMLWnwhurynIsXv/T1XBws9M/JK95p3ngZxwYvoiT9p39iMjlHdUAsD?=
 =?us-ascii?Q?fobYzin6fi7obEm7kpbZDAgC32FdatV0NNo8OKRf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f6e825-180a-4b78-39b9-08dde6b7fa55
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:53:20.9409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZfpwMOkR5hFk2K0t6hIYFdMbARGRSz2tAAgzY/Sbg2OG8HZHOok/wv66KDabPZEZzZh0XXOkIxIJYPtMc6qFsZlf8bbLGMJYR+zjN44814=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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
> Sent: Friday, August 8, 2025 6:04 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex=
5
>=20
> Some USB devices need more time to be initialized. Hence, increasing the
> default USB Hub debounce timeout value for devices to be discovered,
> connected to Agilex5 boards.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 859750f02e7..6f7a2cb11a5 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -101,6 +101,7 @@ CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_DWC3=3Dy  CONFIG_USB_DWC2=3Dy
> CONFIG_USB_DWC3=3Dy
> +CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3D3000
>  CONFIG_DESIGNWARE_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  # CONFIG_SPL_USE_TINY_PRINTF is not set
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

