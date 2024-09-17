Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878EDCAC587
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 15:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A223688581;
	Tue, 17 Sep 2024 17:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0TzY4jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06FD88581; Tue, 17 Sep 2024 17:58:50 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E1688CAF
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 17:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YY1PJCfQISeIBpeLO7c1veYHVXC+oAhzDS7PDhMbY9MCVy83FMmFwWkoHN0BdFdAEIzAIKQLayApUtFiVTb6Go5oiVOlEPnZlRcPSPAV7s8wcmqcGnunH360/Fiod59BOeHXpLyytGV7CY7psp2FL6hCCp884P4BSIGEiasfDv1+M7uRJVEDe+EL117oGnZheeDlKg6CiHAx/mABPrMMQR5vF/AaSmOgUD8E8l2pPSEI6rZrFOO/NdfPoVsP9HP/lIaHi+M0J2hN4mEuXzcs+fnfkTLH1w2K0sgfCjRc+u2KcREnkVhE/cqokCKmWehV/zwNbrJMLSOgrH7nxpUatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TABjRAtgt+YFVvtZiVy+3V3nF0mby11shBf9miQ8Yg=;
 b=X5gShkYPpR67Ohb1Guvp89NDu70qzSHIjI5RSRjpFQYzYmJm4qnwRDrSTVC7BU6+S15dr6f/NXisHo9MoAAJvQzx5Q8XgxD8isPlVw7Ft81Q7kwDaHNiT6DrduyLzA/uambgXR40cqqB+u5sV7wUWKBZDH/hVdOcLWfmL2AVZMuViE5Pmwm0rZZEq6/JiZ8lAN2I7JRiyr7nXH+fIX4wkdlLErAmmSxry6Kr80j50IwBbodBBJS8mi5ST8VH/taJAtthkVIb4Y7aCJJlDDebwBIctuZoPxQU6xgIhVfB/mPqVrOWpUyy+ZAv1LDogQtY/H1anUVB4sc+EN6moSaiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TABjRAtgt+YFVvtZiVy+3V3nF0mby11shBf9miQ8Yg=;
 b=l0TzY4jbdTvMTLwIpqctRQIxz77fOMNtAIrpamqsCOzhUYhONB21H0YhscJ+gpElUSFk2D4tRt1WPoENa7AGTzMY58TG4+F2zQmUH4u+Wk5M6Cab0q0WvwtK6/ye5AGD/pQl5DU/9TycR6ZJH4THA4mW4dJieUjITRxEC7TyLT4=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Tue, 17 Sep
 2024 15:58:43 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 15:58:43 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Thread-Topic: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Thread-Index: AQHaPXq7zFu0EGJe90y8VhJKPXwiH7GL8L1ggNHIOPA=
Date: Tue, 17 Sep 2024 15:58:43 +0000
Message-ID: <SA1PR12MB8697DE73E4C59369A8FEAC7798612@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697105700CEA4082DC339E898E42@SA1PR12MB8697.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8697105700CEA4082DC339E898E42@SA1PR12MB8697.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: e0d9d4ac-d21b-4b00-1380-08dcd7319b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tjy2bMCzkuP0oLcOmB+l4+d+JICu4uo6fY/ZfXgF7EKc6e8ZZkFEdOVmI70O?=
 =?us-ascii?Q?qpa9oBQssRx2hP/ZmTgZZysbEur0ddx+C5pHSYVPn9BuRhb3+ebucx4P+wtb?=
 =?us-ascii?Q?7VixhEA/77B5EMpaH00vSe/msfS+lAATCUIYnxeBX9s6GlO0dcXky7WbiaHO?=
 =?us-ascii?Q?8TGiG8y/OOvdWQHpK6PBuTJM1Gi2DB7lkWl7fxgLWdsq9jY1byOGNGWZ98U2?=
 =?us-ascii?Q?LbijwG5LK/LzS9yup967TI7491pRFscsaXnrrX4/bx2ErGjK2Q2tEYGCzcZB?=
 =?us-ascii?Q?JtZYkmX89dVaRH7n+MH8Fn7lzoDZ84fpNjdOO3GPBwXk9g0QB65pPLB8dws7?=
 =?us-ascii?Q?UgeVUJzm2G6ECeaCkCgtVpP+QP0ExubNqAPSDQSiwOSwXDtrJ1mipQvUMIi2?=
 =?us-ascii?Q?6lvuHH1vQSMMdAWUGMotneAq8BiHC69fT+UtdNf2xtYi2uP95IkszKTIsIyn?=
 =?us-ascii?Q?8HAJNKGqdKrOmt5YxOOaeFLcB63TRGwzaDVZD/gh9iURm4OX2w9gC/d4v71g?=
 =?us-ascii?Q?hvLu72mUQcQMB1s38QG5l66U9LVisFpGEPVEyrbESRQZVR77+YFHcJsIQT4a?=
 =?us-ascii?Q?VpVn+W8sokSjit2kdUQkrlerMZApse1pwk03n+jzne96pkQYFKu3gspqg/eq?=
 =?us-ascii?Q?aWPeOxh4E4v2D22GHh0KQAnjs1gqqjED7ySBfe4ly2PoKwxrzOuHn434976I?=
 =?us-ascii?Q?7jAzjzz0tpK2a4tBcdOjGG6DY4bf+0a9VYAwS7EAgl5M83SWz931CDFaYJTx?=
 =?us-ascii?Q?ustJboamEAPrOb+MX/06XviTvMA26k4yXyTDjup1JDNAIOqJ4XsKsUlcRORv?=
 =?us-ascii?Q?0ObB+JWinDgvf4JPPFICgyfCfiYdrWzU0f7Z5r/RTj0RGIS/GRMAo2KN7Bx0?=
 =?us-ascii?Q?wK/eo9utuqOy5w95FbZopxHL9BNzGrt0XqCFyWFyVL4fKzycJTPMeQUY80DB?=
 =?us-ascii?Q?JxAHHmfhnuHWscq2LkP2Wjwp4/DdFi4Z5IAz4KTIfV8Ad0OaHRyq2I8BO+JY?=
 =?us-ascii?Q?Poav9MAXw5MM8oYcuaxT2BLEBifocVSo6flBhyKYTjGXT/04Bzsq4cmm5D2n?=
 =?us-ascii?Q?blNpZskyE8PvYi8fPiVUxnWT6oXE7E6mSj5xUo6Sb5N57H1u7kgCgOJi2zNE?=
 =?us-ascii?Q?loZT2ZsjiojvwMDOck6OBQIMfhFZ+l8V4V9/k+IlgmOteIs75gjBkcsZwlYZ?=
 =?us-ascii?Q?yMEDzbiKMR12qhJz9RBO+oBkBpcoHLeKuNlwUYh1XwIIiV3L+z0BgmksAzEf?=
 =?us-ascii?Q?mirY8CPoUKJ6C4zPLBsrySTctkvSIMDOojI5wlmCJRLmHGq7QYV4CGq2Jyge?=
 =?us-ascii?Q?1e1kH83kyno2kno7gM67337MAUBFaAcVx14+u8rookx3LH3Mf6lmiL5JP0NZ?=
 =?us-ascii?Q?WvlzUJ6IDzSkDTpXkEp+lfiUGb9FNJwOmyQ3sb2/2ezF3UrRaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/33YHSYMyXkNqDrDrdJz9R1XVbOD5jiULUfDVPGnrIFNKSNcNXHJRDmofAn?=
 =?us-ascii?Q?5xri8U2uFcJNoSRk81c4BZUpmLJQIkTezcpMf1OO9EFvC9O9+kIuidb/6QN2?=
 =?us-ascii?Q?/JZk2jCfci0eAR+/oNKwA8g+UXzG8V6tsyytJ7R+IPqLYQOWwsE/oUTiFOwf?=
 =?us-ascii?Q?IXFQw96TWazB6F5MrsaRhWnedCchMeK6ziAxcoJ6DWvGXdipYnuVfJyvXcMY?=
 =?us-ascii?Q?jkXJEt7Kqu80XoyD0WhXXLeYA/vhB5XlRQl/8Fe5UtDpxWqXujeRA+BTAZA0?=
 =?us-ascii?Q?ajnDpFmI4dHLO94A0gVceTItRyhjadT1jcnxkdiASnlC+w/LSj+N9S3ygVh8?=
 =?us-ascii?Q?iaWIV4sPEoWf4kOy3tojB0KYYt+9+gyZhQr8liBy6CH0p+uToKIUaYM9vj04?=
 =?us-ascii?Q?8ou9lQRkROVIxZA3L6jM6fMEYqwYAK4lE6zlcIFaMaf47lNtJT4edRhGJrTL?=
 =?us-ascii?Q?5js1uTNcNcdoYtGJAqPrnzM5/BweLK+fwZ9lvZB76e5HzPsTUftgOQkvXf4e?=
 =?us-ascii?Q?yeXR1N+kh0KDE+h3jOBUwzP19A+1nAjOgFeuzRJpaZWJBGiUfEQG1apNx3zN?=
 =?us-ascii?Q?RG47+8BrBHqR3u/EaOS5JXo/6c9iqtfJ5jigXTEETPxwgXcArjpAzD5gMYEr?=
 =?us-ascii?Q?HFKdM3326eygYHF2DQ5IKMHFEwSfdVngjp1pP8cH6gybm4Q/QxDj3MxKb9FF?=
 =?us-ascii?Q?cK5mgKeEqoS+tSz1pkmlQtcqCwsk7+biKS/0e5qLs+nOF7vGlA0pAh06tWzO?=
 =?us-ascii?Q?Qu+t/c/JQezsKY+lYSmDMZ0JvAAy/Liq2x4swFEeQqohwRz/GkLbVhEuA1/w?=
 =?us-ascii?Q?coRaIrd+lWxhvYKJsbjMQT/rRZ9ncBxnHTfUH4ojMo7MwTnHibE4MVXscNFc?=
 =?us-ascii?Q?x3BVSTshyg8sUNKH1rnd6Kvbgr8ogExbYUZliZv2yVXY0ppNY0H1WWVI2fUN?=
 =?us-ascii?Q?l+FgH0DNBdDI79Pt1LTlJSBA+19FwzSslukafMJ/M9z0On/rfAP6tGES+Oza?=
 =?us-ascii?Q?3UM/m5apmvREpRSZwa91Rr5L/at4BSClG/sF7UbwdFiBCD1jdtN+ZGU61Qqk?=
 =?us-ascii?Q?ju/dqk9DFv+Bwbqpfj85pLoPyKk2ts7AKGsUsexidydm65GRPbbWdgWNYcvb?=
 =?us-ascii?Q?1yspJ2MOZMq4/xF//nFqNQ2rFGK9XNAJN+TpRDzEFUKU2hMqAMdnXxz9/iaI?=
 =?us-ascii?Q?pdbGe56Kn6LIcmOL12eCvvhoVb01rV5Rtc7OGrlTJiO80/bIuWJ8948lFyku?=
 =?us-ascii?Q?H4O+tfYgdRaqC9+Fj/dHbKXQN5gHo5SHHloFysIUF64/SEaRwCkN5PgI5C5x?=
 =?us-ascii?Q?PchNkssOGdYihDiDPYlJeJzZ534Chdn9N0MQR521tdLhYNWfzb9jWP7VVdoy?=
 =?us-ascii?Q?esBDxcKgTZhcsEDYa2UWc2rlcFfJUxgWnCjii1PJeK2v0M+6lR3iPoCnPuek?=
 =?us-ascii?Q?b9fr/LvI0tsdQ6R8DmyLtw5MtBpMIWoGRK6hGOWn6Wdkoz+jh3NTZYs52LY2?=
 =?us-ascii?Q?KpINl4E+881liR/2PPTJRW5q74Ns5p03zEcuZHRgthQeRPsbyZIrowW+ekGh?=
 =?us-ascii?Q?TpfxGZBf7C4vPklUHqs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9d4ac-d21b-4b00-1380-08dcd7319b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 15:58:43.8113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4WNj4BIO4wj98/a7pSoOLG4js543uomLCpTZuQz+iLAAXExPb2dRWsRs4IOoI9Ar9mca1gIFs/aKzOGPTvvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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

+Tom

Any update on this?

Thanks
Venkatesh

> -----Original Message-----
> From: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Sent: Tuesday, May 7, 2024 9:51 AM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.d=
e
> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> git@xilinx.com
> Subject: RE: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
>=20
> Do you have any update on this change?
>=20
> Thanks
> Venkatesh
>=20
> > -----Original Message-----
> > From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > Sent: Tuesday, January 2, 2024 6:23 PM
> > To: u-boot@lists.denx.de
> > Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> > git@xilinx.com
> > Subject: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
> >
> > This patch fixes timeout issues seen on large NOR flash.
> > For full-chip erase, where we use the SPINOR_OP_CHIP_ERASE (0xc7) opcod=
e.
> > Use a different timeout for full-chip erase than for other commands.
> >
> >  [Ported from Linux kernel commit
> >                 09b6a377687b ("mtd: spi-nor: scale up timeout for
> >                                full-chip erase") ]
> >
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> >  drivers/mtd/spi/spi-nor-core.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > b/drivers/mtd/spi/spi-nor-core.c index 9a1801ba93..171c68787c 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -45,6 +45,12 @@
> >
> >  #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
> >
> > +/*
> > + * For full-chip erase, calibrated to a 2MB flash (M25P16); should be
> > +scaled up
> > + * for larger flash
> > + */
> > +#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES      (40UL * HZ)
> > +
> >  #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
> >
> >  struct sfdp_parameter_header {
> > @@ -832,6 +838,20 @@ static int spi_nor_wait_till_ready(struct spi_nor
> > *nor)
> >
> > DEFAULT_READY_WAIT_JIFFIES);
> >  }
> >
> > +static int spi_nor_erase_chip_wait_till_ready(struct spi_nor *nor,
> > +unsigned long size) {
> > +	/*
> > +	 * Scale the timeout linearly with the size of the flash, with
> > +	 * a minimum calibrated to an old 2MB flash. We could try to
> > +	 * pull these from CFI/SFDP, but these values should be good
> > +	 * enough for now.
> > +	 */
> > +	unsigned long timeout =3D
> > max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
> > +				    CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
> > +				    (unsigned long)(size / SZ_2M));
> > +	return spi_nor_wait_till_ready_with_timeout(nor, timeout); }
> > +
> >  #ifdef CONFIG_SPI_FLASH_BAR
> >  /*
> >   * This "clean_bar" is necessary in a situation when one was
> > accessing @@ -
> > 966,7 +986,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct
> > erase_info *instr)  {
> >  	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> >  	bool addr_known =3D false;
> > -	u32 addr, len, rem;
> > +	u32 addr, len, rem, max_size;
> >  	int ret, err;
> >
> >  	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
> > @@
> > -980,6 +1000,7 @@ static int spi_nor_erase(struct mtd_info *mtd,
> > struct erase_info *instr)
> >
> >  	addr =3D instr->addr;
> >  	len =3D instr->len;
> > +	max_size =3D instr->len;
> >
> >  	instr->state =3D MTD_ERASING;
> >  	addr_known =3D true;
> > @@ -1012,7 +1033,13 @@ static int spi_nor_erase(struct mtd_info *mtd,
> > struct erase_info *instr)
> >  		addr +=3D ret;
> >  		len -=3D ret;
> >
> > -		ret =3D spi_nor_wait_till_ready(nor);
> > +		if (max_size =3D=3D mtd->size &&
> > +		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
> > +			ret =3D spi_nor_erase_chip_wait_till_ready(nor, mtd-
> > >size);
> > +		} else {
> > +			ret =3D spi_nor_wait_till_ready(nor);
> > +		}
> > +
> >  		if (ret)
> >  			goto erase_err;
> >  	}
> > --
> > 2.25.1

