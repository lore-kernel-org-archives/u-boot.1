Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98482C3ABD8
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 02:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE7482AE9;
	Thu, 15 May 2025 04:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EIz1oWpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B610882AF6; Thu, 15 May 2025 04:43:50 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985E28294C
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 04:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKAyZZzcWC1Sm8R8XNyzwdbddgqI1BP1GyLUgmg38lY0KE0eKC/fUftQ7FAYhVn17oRfyEqgMYx0JcbREFqEw+DfDkhUz5jJgMjIz106KVo857q6LqGY+fdeNMIsV6lK7fkZy4/HFbOupuf4snOhi0ZkP1bZ3nmmG+1G5jsmp6Y23vWw6r/xGv6HIY+saNqZGdtHCka9FMXr6zQQKtvlmv7CcZ0EmnoMTtHHqBfXzCo2SWdcJrnD3lb8oR4a/dz+pQSO7RnwmtT+ZYwMoDlNfjNSdavyeFAlMtOpiyEzX1OPKTXcahSAf+jKdrCUi9Fewq+kTf8FWblKwpnyBxXQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neyffvopMyW8le8/NHlKVvu2GQZugn3wKB8S8lIdxZk=;
 b=aTdF9KQpKt3/dWIRqEAnLIqL42JlSXHWMPKC50rhNVP4fcSO2z+9Bl6dklrLeASrQdUk1gUBS8ACqT2ak1ByVAKhi36xUaz1D9rcVrJvoDrYxPRQI7DNdn23BBqnjaERg8OTM0AHBUEpVAPssIlkOLaVYxwDunfEbmfFdeDATOZ6LwgG8u+UoQ/DrTN+dy6SSWM+0M0WlkmWUHCHCUvNG5BptTiOSoi/EvVqYAsAxwZNYVwU+VZKxigDzEnlVNHLrNHwSjNHCQa8wgBL0LvlwYnDowltdMsDij3LsVI1s8GNrLKXjkSWWy6QpO+ZXvpHzQxJbTPsaxNO5Y93/Tmt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neyffvopMyW8le8/NHlKVvu2GQZugn3wKB8S8lIdxZk=;
 b=EIz1oWpH9d55oKtJMfJBVmTayMAlVEguhV6UPjz6/zlRnOFCXuBArnX5wCdVccDjxz0QQimshLGlrXbIN+iOBHwjj7pUWilm3qxN7+plhpiv7Oqm5mTKnQE7L/TL+hnvl5Z+erV4B9qlz2SKLbF52RnB6zmnMy7+DyK8ROmkS9hwjkz+Aauv3kpTRKh2sgdVi2nH4OrrUpjDFTzxH7ud5oWdQUrpnmTIXABFopJQciJiQmwrPXfBvpHSGZ61o6T9a14lZm4Kw6OH8VzQgbQRn3lfV3IJf5u07n4iVFl2dI/pAanR/3ybPJSROE1xKiacX8+GCbg1O/VQQEZrsf8C/g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV3PR03MB7561.namprd03.prod.outlook.com (2603:10b6:408:288::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 02:43:44 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 02:43:44 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/5] drivers: ddr: altera: arria10: Add valid RAM size
 check
Thread-Topic: [PATCH 2/5] drivers: ddr: altera: arria10: Add valid RAM size
 check
Thread-Index: AQHbvpEEWDCuz+ePIkqoNzu8fs4hXbPTAqXw
Date: Thu, 15 May 2025 02:43:44 +0000
Message-ID: <LV8PR03MB8137AA4388EAD43BFCD9DA39A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
 <20250506141246.6672-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506141246.6672-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|LV3PR03MB7561:EE_
x-ms-office365-filtering-correlation-id: 0d86911a-fc1f-4f2e-fdf5-08dd935a4f68
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mP4yA5rgtkh7T9RcIBCEzJZ8A6tw3Ev5SzexjKtNC+0zdgFK8imuOcvEeLp7?=
 =?us-ascii?Q?xMdf5KznMjT1Z15wtZEPljmLMsRrBdQMLbUT7FWRvK8a15JbsnyvpM7yy6y2?=
 =?us-ascii?Q?V0EU/+1FJiKYrh2Cnjq6u93txnwi3eDZMbFoujpEX8Bses8hx+F0EQ121o3c?=
 =?us-ascii?Q?TkWxPAAOPBMtdjsxUGtKBE9wJ5LUaSplkF8mWoiy3tbm77ryZeB6jOVakEeb?=
 =?us-ascii?Q?NQEdITD0iWRtRV/pYDAh9f1WUyeu36JJdxtGNXvnr3h30eSz6GTLL88n92bP?=
 =?us-ascii?Q?CgXPzR7e4EVp1EXenn0jsX/4qOhki9UYxTSez9NR6KS8+rkURoxUD3HJML1d?=
 =?us-ascii?Q?ibNBrteoeKV1hZsNHpoK9M2ONRmYVPmTmI4TPYDvTFuC00xavubuTXjTItZB?=
 =?us-ascii?Q?P0fmKZetTsciA98/NGrkXoqT/DKOG37kr7xksMWVhHrf6kDtNjTx9CnrDEvX?=
 =?us-ascii?Q?QCs1qgHJ05kgG/PmcDnVenx/ORBarlbhpNwbZaM2giAcdpkMKrKFMPKkcMc/?=
 =?us-ascii?Q?RUhrtIYhzR6yqSqApnsZvxTeNBQpKrI/Gw2NxVEmJIYFUncTehkFafOUmxfd?=
 =?us-ascii?Q?10dYavCuhV8RAnGb5s8gL72JFsPLQMxkEYL5Ii2jT3G4QntHJppS1fxT/rVp?=
 =?us-ascii?Q?2KdflUGOfpkew1c3Kb6CqzMS+v8Bjbb4XvbaIKchKHkHyoNT7gKp+6/NMXZP?=
 =?us-ascii?Q?YwyQrqY14wQLbpAtOrpKoHdFuBzVdwB3HWAbwG7A45+OnsDkE+66ptmWqGn2?=
 =?us-ascii?Q?AMEEtgbHERsaCRqMaYGRfNn/jv4BzfDwK5sdmpmmt4SmKXcADIem8UVPkFgI?=
 =?us-ascii?Q?oD45IjYnjJXTzZSoh9cWijduyvq6l9uVYwKZW0T0pd21Qu6M2YUMQGdGoB9g?=
 =?us-ascii?Q?Ps4+JM2cCTur+UDAzaSH4KAroglsWweX40VWrj2F9H8trMxwYGmz/+XG7rJX?=
 =?us-ascii?Q?8/LibI7C7zY8a09AX+HkQ7uig7sIlrY3Dej6wcsDEsjiaYt0i2kr4s/Dtwui?=
 =?us-ascii?Q?uU+Yqj2dEqzLZcK7D9Kx+EWj3MYFeyj7RWo2ZUybAUPjDhDcRQb2+EKxifOT?=
 =?us-ascii?Q?eJIXgP+BR6LJFZoQUeZU8iNo6GEUzHODzUJ99zw9Kv5nCdgDtphI9XEnVQZ1?=
 =?us-ascii?Q?yQaplCUshIZB6peKRVK+8s/QRXZy8SCR9Ng/fNtHukrHHAIPjigBW8+7kw86?=
 =?us-ascii?Q?xE2N5K42LS3JkV9WdUY9TEp5D8YLTIBGjWUUPjAB3Ua2jM9xjNO275mr2YY4?=
 =?us-ascii?Q?Jq8JVUCz8GzPOjNT5WzCqaP/x47/2Rb058aRJ5S6aYIQVdEfhuWWgLUfjRfX?=
 =?us-ascii?Q?YXWTEd5zWuh7L9qrQjMrlRyNf5nWwCTVVXPEUKyCe2fCC+uUqqNYUbWQmAKo?=
 =?us-ascii?Q?hA4/iSUuDpjuZlNISZ9ZmXVzhQpq7yETGKsA8vF/VPNMDUZMowINHVDa+RX0?=
 =?us-ascii?Q?FiU1frRO+5tUC8Sa+xeb0iL8I8JWW5X5oKTVI5aIvDQ6tYaB9LwRrw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uhiqyzeMRouxT5PsCkcnIR+5zfXBh8vtQTDA+jBJoIVPG9+71jHaumebUDUf?=
 =?us-ascii?Q?87VbHeKGvAfBzTVtxHEtTDFnjwJULK25lN1F4rM/lAtQsKZLH/Sfgw6YVoSI?=
 =?us-ascii?Q?ltZr5YDTH1WBC5PN4XW8hZp9pTx3fZmuviDc3+Y9ASFDxzWOXHUyBxkCByA2?=
 =?us-ascii?Q?U4TOR4TFg0+Qtaogf+3bjCb2h9wccUMD5Ly3NSxPqiUQy5j2EEV+WUqIh2Ay?=
 =?us-ascii?Q?T55BaRZ6FN6uzGb9xmJomH2Cucjyhwq9stKi7tQtBNlAA3/v4DGrxcQbQPuU?=
 =?us-ascii?Q?3rZhyj1XA2uKOoTebtI5sJkBwVlP2fwaUsVrBh1gJ9jOWF1p38yjUqtY/Zzy?=
 =?us-ascii?Q?LlvAEeTiL4+uVz6gHIya8OFdLuwPHwKAgh39C7rOYLgNNZkpS1FHKcfPMCxY?=
 =?us-ascii?Q?pK5qu4/VihvnkML7GK4CMhCwMni4yPos7Muhu9XWICVxzy8E0TWpxyGOR9OS?=
 =?us-ascii?Q?nnzVrIaTDHLUWYwK7qv/mmOJpCtEPwbmJ/ceeQImWk53jeBi0+nXzD2dwsNG?=
 =?us-ascii?Q?W4Y9VZI2sU2rDSqKEktdVp+0b/IgRmNtJEZSWCGUgql8Nu1Sc1M7IramjEh8?=
 =?us-ascii?Q?mAEbKsQrQDVcrjr5ByMPu6VgSUxCcolpOdNvzgDDmRv0WUOrW0DY4yc2jDXx?=
 =?us-ascii?Q?tj3ZAqFF4tcI19roW0U2m/fAU8mzURlt2vdsd7D1eeBPa2ktCZIeGme793H2?=
 =?us-ascii?Q?o9p7+6PpskSpAZmHXbj6h+KmTp11Ojs8Av/EDN5RnhqJKCy/WChO6znAE7hp?=
 =?us-ascii?Q?cusfhxp5wF0WjHFe+Cm3Zu+HsUqiPvEHwUgwQ/02xNLtyII2OK7nW4V0XSGv?=
 =?us-ascii?Q?KY6WlIeF/PgN5qvowNHk6MgKlLaWnmon6Zur9i/qieia4cVJ3/Unbj5tlvw1?=
 =?us-ascii?Q?17Uwv0l0u3myXNWypCTdAaYtzXuO/FpRWUH9AaYazSTth7/6JvS9FhCvZJ+M?=
 =?us-ascii?Q?XtI9R5CqOczMDaDOpH0GvYqji9LYQkXjG/UqK71WipKC2dt+3JxYgQP39zLu?=
 =?us-ascii?Q?Akm8MV3smBwqquYC4kPDLNcljURZqPPnNrpJsQbn6Zb97aBCApRuRm3445xB?=
 =?us-ascii?Q?EqBHKZW5l3mRorAzrF0NTTsEX4bGaI4ldN7RZ7SSHcLmCn4icPmIBCr6FcSL?=
 =?us-ascii?Q?Wd4yxVmjaKr6ug/0KGwxA9to6CzI3Gnw16Il1cknyO03RWPD+zmDGD1YZX1r?=
 =?us-ascii?Q?hhMB1o3XLAQhkeN9iHTC0JaIWL/LBcRXMU+ZZKl3zZNlRBXaelYMm+YygeWA?=
 =?us-ascii?Q?MPkcA9XpyzUH1a+nS8M74Ea6E73cuUsa+u38E+1yoTBmrxBp8sYiLbxVuPk/?=
 =?us-ascii?Q?4ZxOsTpxy5UIgOAGGQG7RPp9bx2mZiBNALeeOFJW76K6Uz1qaUGF2+nu9OTJ?=
 =?us-ascii?Q?nx5TujJkTgwuihAVO1uVBWu15fEvbPN1uZeNV70AvlfiwSPewEreR8B9bsA9?=
 =?us-ascii?Q?ZCN1+u3H7AX9dC86dxRcbhBUiMSD4nTHnNyx/0lkxNaPjwyyHZh65RZjcU/f?=
 =?us-ascii?Q?Zx2heWH9kuoMIlUhkMGCTJHzG9MViYXFKVHO6zSdBOooZaR0Vr65An+Pr24G?=
 =?us-ascii?Q?lZeSi5Bt5vylcXQGYKBygqNMrYIDUXrdngoteA1H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d86911a-fc1f-4f2e-fdf5-08dd935a4f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 02:43:44.4890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWRSEyBMhLyCZVUQ4AmPbCy5gdEO5mK9phxSuU9I5z9avHFpv0wxVju0jrO24F5hgCkVjmI/3/ovIbYHNTV0bhUwPUX5MVu+RcGQ+kg7RmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7561
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
> Sent: Tuesday, May 6, 2025 10:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 2/5] drivers: ddr: altera: arria10: Add valid RAM size ch=
eck
>=20
> Add call to get_ram_size() function to check memory range for valid RAM.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index d75203a1d2a..4a82af0b711 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -669,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
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

Alignment issue on closing curly bracket "}"

> +
>  int ddr_calibration_sequence(void)
>  {
>  	schedule();
> @@ -722,5 +738,7 @@ int ddr_calibration_sequence(void)
>  	if (sdram_is_ecc_enabled())
>  		sdram_init_ecc_bits(gd->ram_size);
>=20
> +	sdram_size_check();
> +
>  	return 0;
>  }
> --
> 2.35.3

Best regards
Tien Fong
