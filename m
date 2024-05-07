Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A55BC25B5C
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 04:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6978872A;
	Tue,  7 May 2024 06:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0g++7E6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50FD87E62; Tue,  7 May 2024 06:20:42 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC3C886E5
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 06:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpvAeVEM+6Sgehta/2kgnNBls/cNxdktRhIz6epgSkjAyHMbOkFWAL9wjManFwxQMpX2E6EwkE7Qo1IfbABLyZ7KcQvmMvGgan04Pd6NWDWJNnK8Cg7gYKDbWo6szSfAVq8v6U4EWwd/qLjKtEOH5fh61wbFQWAiZa2Pn1BZQwKhIdc2CZYTCrTLwQDOUjwoDEyliOEnA/SoMFjGCH07JAMC3aicKRZW3B3gyqVMQFnstOautDZOzlWcEZU1h95s/rm0HkJy27l0OnRAPNHFiDB5ZREtR53i3VdJ13Vj6gG0D7ZOL6Lbdal2TuM1EaEVEjXUxD0NRrBifA2xhp+eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCRiGHLpSZ/2TT12G0SMeocZySbQUfwVB8QOyTdFzSM=;
 b=NvIeSo9/CA00jyUkp7iqbgQzxnM85thBZOx/CVcM7R/ZyLvaFhVzHkKfAc5+AyioGYFhwLzNITeTi1c2jHwnACEx5dmCyzalSQ2UjcvhZ1QnVfK9gFYOOp1wQFWcCbOqYnEVupb5P37XVMhQPx1iTzMsJhJ6g7hzqFYi2mxu7ODL0dvUu3ZIDsVSL3GEILgnJQxlNIBs0vgnmmtPlzYPbMChwwTsI2GULJDGpjsS/YmnFxDS6qIABhsdh8vfCyeh/HH2/GALLx7GY+nTqC2T4F8B0Zljk6O8nePxivFs//7VyAAUrlpA0EESQCczzDstEbngJf86pRWdw0UmRq498w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCRiGHLpSZ/2TT12G0SMeocZySbQUfwVB8QOyTdFzSM=;
 b=f0g++7E6fIhY3bkSZ+Igb9nk722G5WRSMSbLZJMOpLitw5Ani19Je/rYG2zDJXIxisVy6nh9qXijcIm2xcddjGKkevCAxVDvZzEmglfvgh++zF3CPkjcaxeCEPJRmqXXbifXMKbZdIA6Xc0BBSV/yz3XFyuqvKpS4fFkw0LIWKo=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 04:20:36 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 04:20:36 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Thread-Topic: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Thread-Index: AQHaPXq7zFu0EGJe90y8VhJKPXwiH7GL8L1g
Date: Tue, 7 May 2024 04:20:36 +0000
Message-ID: <SA1PR12MB8697105700CEA4082DC339E898E42@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA1PR12MB6258:EE_
x-ms-office365-filtering-correlation-id: c7e8f99c-9386-457a-caea-08dc6e4d0b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZlEklArzArwVHJpAF9axCs4WFtFeOF9GUaHy8+zoL69gl45a6iiicNDne1oD?=
 =?us-ascii?Q?+DzMOUGkgxgGgN+1SCm97dSTsZpiyw+AE4pWj51N7HQyocf2auRJG7jVA47Z?=
 =?us-ascii?Q?ecleRq2eW6uX+SNGc+N3TG52B1WT91J8LB66YpDs1fvhoemjcIgUmUxR/Sl4?=
 =?us-ascii?Q?i90Cypz98N04wamFm7yTUJ/O/IJMllJHQBgYx5IFxemICq0P+Gdhn1ourATx?=
 =?us-ascii?Q?EKkIxEb4qQKxk3/wcvnyoZbM4Mpf5psJ9i2iJuHyKviEGrjqIlJK1x7z1CPW?=
 =?us-ascii?Q?3ugMdvEvAVe5pbOSZhcoObAgJYz1J0srLpLGMoRyeqO/+vVO+IWKzKPDMHcX?=
 =?us-ascii?Q?UQR3yssv0SPqxEZBz9vOpkBSP7jeA2jwieppWFXB64qYSn4pA06M8FTTg212?=
 =?us-ascii?Q?brc9YWjcvAgIQyafjfRLbHUxUc1HlmQBV5B5YePTyjuNucMOypOpbGgMBOCO?=
 =?us-ascii?Q?OcOqYr5/c1DKZ6HDYTjUXx7aSS4IQNYFJ//YMj+wWeHO1nDd/hRZqxQm2V23?=
 =?us-ascii?Q?Yyh70vj9vn63H9I8Vgbs6N/UsltLL1bElmDFxtlDKUDoAg9ndgiQgC0Oj78o?=
 =?us-ascii?Q?GecRASHRtMhj7cqij1QOL92mK36f5kcKKZsunEXkSQJ6Mxx/T6GgFZNVVAwk?=
 =?us-ascii?Q?AyMhq+sLPaZgB2uraHcVJMrwNAIbjbTtkMU/O7DbjawbQuXJByZL0I7agM0a?=
 =?us-ascii?Q?wsqkrBYeW+hvbUdFzgTwb81DvgFU6Ug/jLI33hMFaAaRCowSZ6klhWj5nTym?=
 =?us-ascii?Q?bjV1htV2Icbkex0RTsLiLBGwbLr0sjvOu/Wj41te5THmxyITrrwPQzFc+6fG?=
 =?us-ascii?Q?FNdfN/F5YD2RzJoycvn92I5ohxQpeXeDgTk0x3YlMfrn50EcM7Jt8PL3Z5s+?=
 =?us-ascii?Q?UcyS+mTk9G3K6v4Jg1JpRhlQ3uSEHw03D40VRi6tI5sVOTNBPonFXI9i4FEO?=
 =?us-ascii?Q?gazxDDd3gJU92eJL5sEXlZlkrdskjTiorueh9lU+qi33FsaBHoJSxVo3A6Kx?=
 =?us-ascii?Q?x6ceVPEBxL4aJB/ORHX56GwfPvdvNhB/KXuAN2J5924WKeQ2qNMauU5Wg3B7?=
 =?us-ascii?Q?UAoqVQ0MCsyv6iAq1IDTeT0NbdM59ZfXqKdr6jR4p43AIEDyJTCdAea4n0hX?=
 =?us-ascii?Q?rVsWlxz8wCYOm7kRA68uYR2M6CqgoqPRzln400W0J2itD1zCsCiBQzUaiPaL?=
 =?us-ascii?Q?607QVptN4/du8bPJeVISrW+TvA9IwpBs8ps5oaFLeKYhfRQuGStf/WG0e/b0?=
 =?us-ascii?Q?/aJWyO9/KX3li3mqJdO7VVRlbFRzdvqfNT8ezti+Pqr2YNK+LZFdHtq2vHSc?=
 =?us-ascii?Q?YhyQ4vqg+9gXD1XfvVTWtwX+QD7lVe9ejPpNq5hJaTQM/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rplc8knAAXhzFeHx0PAGNVJsvBrXUk09SfTRAELDHyVVE9LjpzrpxoGgItv0?=
 =?us-ascii?Q?pCpfM1c4Unck03J20sQ+VJUDFbEUrvu0b1CHcgXGgjb5GlXyulBWHJS2Wjzf?=
 =?us-ascii?Q?zMBVK0q7gorZemBC44pTRLnOyJ9Sp4K1rbK0shifq4OU/rtn2RVaS8aW/E51?=
 =?us-ascii?Q?/SzWowHdur9Jo4T6REdyj7J/E7166ru/JzscqSZsMbvlU/ii9Fbbyl3tcP4P?=
 =?us-ascii?Q?wJqYAeQUsdiISXzgKGKISuRqbv5bYhydB9quGr5ap8+vseck5hUczHj8Tizx?=
 =?us-ascii?Q?F7Qxj8IB60v0VgnRoMyhSZW9MtUxuqj2avjTV+/0G9El9WqVvs4DhwWgM/5f?=
 =?us-ascii?Q?QJx1c7Um9taAtmQT8Fw0zpzxwqABG26RVYT8f/nmjCZGaWcxXa3yIiMQNV2f?=
 =?us-ascii?Q?AHbFoP3Qjsh3INqkyDorHZo1CGKnReli3qNMGLQeIj1IcaGbsUsPGIey9e1H?=
 =?us-ascii?Q?f/3ZRKrXD9D/T4rd/Tm7PSlwgiTULjvE+r55wQnV407WaaNLj2ZyNALkBn6g?=
 =?us-ascii?Q?UhdsFlQBz/xOFlPmTvy8JBRpsjlsFVklaTFy4q5218IHecHQXJ0Q/KiLE87+?=
 =?us-ascii?Q?+tTRpO4mf7uIwJTcGMZge1wMkorRTaxWGp0N9dC1qgiyR9OSz/1sZdkGlykw?=
 =?us-ascii?Q?r2ffVymi2BQxnIfDqpg5KS9p/6dHx3rfWlyDShiktSr3F06ljZVULTlOq5hH?=
 =?us-ascii?Q?okIIbfWEMBOmM43TKPIZfhysWUDfJ5c5iEDL1I8XC0MCiVG3Oz8nb+N/8jjA?=
 =?us-ascii?Q?N/s2e7w5D/vkeDMB7jrPegnmqAL3YaNtNXStLW7/8YoGdfJxR8F2+RRv190n?=
 =?us-ascii?Q?mPlIP/BGzmhHnoxyBPeSX1M8SMEaFGM01BPwkw4Mx4ic64EbO39Xm9uM2wkJ?=
 =?us-ascii?Q?JHP6haOFevfdM5bgyEGKeyNBnzl86zU1ZNHiQ9dxPl54vXcT10AFbpBTJ/HP?=
 =?us-ascii?Q?au+V0dV1j5n5LJsoq3D4XC3XQxHXOpXrYQG+23Mq7u2ZMoAiBcnum3VGSs6C?=
 =?us-ascii?Q?O9W3H6JlXjMm8CrRhsaDoSZfN5D8uJF8pdJB47aU6kJEqaXra4StBHWtG1NM?=
 =?us-ascii?Q?vL3Bc/Bk4+DXvzX8UI17UmzhjsePN+uURLl1bmkWRAGs2kmMIlEvyVkHckQN?=
 =?us-ascii?Q?xEJX8F6FGvHJjQrKvrJrBt7CbcMgbD3RtnLOM20TPGDuZMnlboSzNEbO4tyl?=
 =?us-ascii?Q?uEEkZO4gXlBsEjzS702Jfn0sHhrNv1A6Trku3rvhCQqOh9z/9IHYDy45+cp1?=
 =?us-ascii?Q?FgxxwhiOiUYq+QZN0u+ZqWa01gtRXsokNDCv3zMmIHuClFDb/qwNh+jvj1JX?=
 =?us-ascii?Q?Ldr4lK9fwngcydLZKiTDqf+vi+praj0J3t+24kKiBDBXfVqnplD5MSstacXc?=
 =?us-ascii?Q?TzugX/bwZc3yTMSc8CQ5uqPCR2RiwqUeih/1kW3hpXwR6yDqt6cPRxTeodbJ?=
 =?us-ascii?Q?TdpKGnJtns+jd87IK96TiH5j/fxjYerZGb1Cu0CG9Ld3M7eLO64KsGkJwpZ6?=
 =?us-ascii?Q?tIl0gGhKcHGKRyjGCbbJ+rkJwsyOKifLA8kaKk0ff14SkttxzScJ9azExd2C?=
 =?us-ascii?Q?sh0PoPypqWdZenGMkrg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e8f99c-9386-457a-caea-08dc6e4d0b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 04:20:36.3761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFqkFkEYneWEomRooYYXUCZllfGOUQgGqOhaJRsMW4pYnm2eR3YEmuQHDPzwXGJT3pgUbV1GbuyTovgwOb2S+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

Do you have any update on this change?

Thanks
Venkatesh

> -----Original Message-----
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Sent: Tuesday, January 2, 2024 6:23 PM
> To: u-boot@lists.denx.de
> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> git@xilinx.com
> Subject: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
>=20
> This patch fixes timeout issues seen on large NOR flash.
> For full-chip erase, where we use the SPINOR_OP_CHIP_ERASE (0xc7) opcode.
> Use a different timeout for full-chip erase than for other commands.
>=20
>  [Ported from Linux kernel commit
>                 09b6a377687b ("mtd: spi-nor: scale up timeout for
>                                full-chip erase") ]
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index 9a1801ba93..171c68787c 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -45,6 +45,12 @@
>=20
>  #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
>=20
> +/*
> + * For full-chip erase, calibrated to a 2MB flash (M25P16); should be
> +scaled up
> + * for larger flash
> + */
> +#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES      (40UL * HZ)
> +
>  #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
>=20
>  struct sfdp_parameter_header {
> @@ -832,6 +838,20 @@ static int spi_nor_wait_till_ready(struct spi_nor
> *nor)
>=20
> DEFAULT_READY_WAIT_JIFFIES);
>  }
>=20
> +static int spi_nor_erase_chip_wait_till_ready(struct spi_nor *nor,
> +unsigned long size) {
> +	/*
> +	 * Scale the timeout linearly with the size of the flash, with
> +	 * a minimum calibrated to an old 2MB flash. We could try to
> +	 * pull these from CFI/SFDP, but these values should be good
> +	 * enough for now.
> +	 */
> +	unsigned long timeout =3D
> max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
> +				    CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
> +				    (unsigned long)(size / SZ_2M));
> +	return spi_nor_wait_till_ready_with_timeout(nor, timeout); }
> +
>  #ifdef CONFIG_SPI_FLASH_BAR
>  /*
>   * This "clean_bar" is necessary in a situation when one was accessing @=
@ -
> 966,7 +986,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct
> erase_info *instr)  {
>  	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
>  	bool addr_known =3D false;
> -	u32 addr, len, rem;
> +	u32 addr, len, rem, max_size;
>  	int ret, err;
>=20
>  	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr, @@
> -980,6 +1000,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct
> erase_info *instr)
>=20
>  	addr =3D instr->addr;
>  	len =3D instr->len;
> +	max_size =3D instr->len;
>=20
>  	instr->state =3D MTD_ERASING;
>  	addr_known =3D true;
> @@ -1012,7 +1033,13 @@ static int spi_nor_erase(struct mtd_info *mtd,
> struct erase_info *instr)
>  		addr +=3D ret;
>  		len -=3D ret;
>=20
> -		ret =3D spi_nor_wait_till_ready(nor);
> +		if (max_size =3D=3D mtd->size &&
> +		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
> +			ret =3D spi_nor_erase_chip_wait_till_ready(nor, mtd-
> >size);
> +		} else {
> +			ret =3D spi_nor_wait_till_ready(nor);
> +		}
> +
>  		if (ret)
>  			goto erase_err;
>  	}
> --
> 2.25.1

