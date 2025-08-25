Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51902CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D297982E37;
	Mon, 25 Aug 2025 10:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ej/82nqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9153883071; Mon, 25 Aug 2025 10:38:29 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5F781E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws4KVP+fr71Q5YGsA3apYAbue7Vq0/souPrQ0KWQRQgPLTPLGUFFyFPN1wNUil2CeIeegqw3xsuhEevo6X6mOLtA9Dj9c8HER2KiCUQ6ohbOcitgn5PBlSEvm5o7LMH4DunM3F/bS3fk+eydQ7cHStZ3IQLObQsKsmhflMZG2STqYsORD8sBoL69EIZKlhD6wKW62Iua8/V+sNaW/Pe0Ep41qT5ednqoQOeWzi49bPbxTCR21ejRtrs5vNZ14JMLExZlXNROdZcqsj1azVPKJ+A+Ol6hBKuorHtc3pEHTGUZrvSb2teXt5rVLHHWeIz5lO4lTsswh8qVQVP5Va9G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KsyXMVcDzmS6tlnugWWczc5cnMWf0vZaUpN6bh0J9g=;
 b=pSk4N8Y6aI4XR/TfKwEKvS2NC1tRUFMk6c9q+qeAfY54iuE9p8/YlWoo8AROQ5L5h8PUMszoI9ovJRIF+Y3Osuf0mrOwb8EZ6edhzY4WnqxXxhf5xP+X4Jl12Mr2AEprjlzEhlBvjIIRSMD0j21dHXL+/KJtUmVKsxbWClD8ZLBnBMaYkwBXXdauUbD+nU9tqaGSjyMJ6CvHpgI14byoAgiX2q4PtnDcNiHVNTv4fo6c6EgLXgkBQEI+lkDyg5rHqxZLWXgGRqNZ4TH/xHjHozc8lldcf64OPIBAXM5Tfog5dy0ytOko5Tf+e8Wc34o/8udzbouquyqJx+pYrTyrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KsyXMVcDzmS6tlnugWWczc5cnMWf0vZaUpN6bh0J9g=;
 b=ej/82nqAvS1bErLvq+fk3VMVpKWCfYskaoUhSfnPm+APts5SI1ZxpgnQY5blWxAqMS2e0lZVpVdQ4yvdAuPjZMSv8LeFPmxxzndiyY54RQ8+SZGlf5nyUybl2sfXG/nLS7t3uzrofXv3kAJ9PWKr+dngKe9/JbLWk1rm/c2VFnJrSpmOfPyvnztTS90n/GbILfP5vLmjq2khKFATmyW9zyYgHKya2OgQBmFg+vA67wDwjZWTAlxjPPTADECNxcL2C1h9XEtSyJqse9FdfFekP8lMWv2xuU1chSydzXoT3YSEfIHOjCzeDtd0x49bIjEKi+JGeoVJWFZQsPr7QDi4zw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6998.namprd03.prod.outlook.com (2603:10b6:8:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 08:38:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:38:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Thread-Topic: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Thread-Index: AQHcCEvTOtQcdbw2VU+UhXPmgY8WFLRzJpkw
Date: Mon, 25 Aug 2025 08:38:24 +0000
Message-ID: <LV8PR03MB813783EF9DE993DF58385F31A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
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
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DM4PR03MB6998:EE_
x-ms-office365-filtering-correlation-id: 3b8bd081-5915-4f8b-4b0a-08dde3b2c193
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Sx36olrazgnJsq5lNEUJqipYTMKQ9N26LrrKo5nFA7/1CvJwsv3Pau2t99yO?=
 =?us-ascii?Q?k7lMiD3uwrT7zJaa90S9o3Lk37Zr2bpc5cLrGNAm9aPP0QdhBFgCOgSlgGwq?=
 =?us-ascii?Q?a4gOmYqDd+E6okdBPbYZLJ9cZQvEq3vZmkSzlwAGn+FmQmpxtrTDyl7Ow4sp?=
 =?us-ascii?Q?dMLVkw2xjA1A5uOZc6omkZlPGVKqQUGAkCQWV+VppkUzKP2+3gM1UJyoIKtn?=
 =?us-ascii?Q?7z1SqeD4fxEHVMCmXgM/MUu4qJd3nkzlhffA2t6h/y8ldGg72Mhun4pxnjeQ?=
 =?us-ascii?Q?JSA+m+x00K7jLMxvYEhX9ehdtgTFQqV0Qxv+SgA/V2iV8MKSBFuI0CUyaZJm?=
 =?us-ascii?Q?S5MecPq/MA3j7Grix+SNPvbbEvxri2iJ9XZtao6ndOk2/UM0o8xFeC7SkihQ?=
 =?us-ascii?Q?oxhmiWEYKoVUKgRHn5qC9DEjJibUlUXy8yYI4jYyw2P15ZP5Gqb3/mGwpQIT?=
 =?us-ascii?Q?OlexKFkJx3pdM0vhDw227xyywYaUUUBcHNAA/cRlr0aVjZBruBWIwiEX5K02?=
 =?us-ascii?Q?fKJVEjSa/fl3ih1HSGh5N73QxIgZzVqe9EbvD2AgG9MSXuNR+IFRUmOAvQiN?=
 =?us-ascii?Q?NgwyZTddYoUiyu8+8q3olC0s/mVweJkwCEZiyd1As5GJ8oLWOixVsCnnYyne?=
 =?us-ascii?Q?ah/JjgJn9S3rMRa7LYHzWX7/IQsDMBcxVE6DTWHnkWIK7eldNPPvsG+WPfW0?=
 =?us-ascii?Q?V29FQyojvfDHehF544t3kowX8mvxrd42my5afqbvp1U6BEaibVzxRafehwf3?=
 =?us-ascii?Q?kkRo5wn3O14MTdxFpb40vugPXjhSrlgNIwbhCm1dIdPeUeWDv+yHRDh79nrG?=
 =?us-ascii?Q?IPPyqpUkiEYlfEY9hdQ2w8G4tOppTv8lfx+RR4W6PStK/7uWPO5gfwPX2q1W?=
 =?us-ascii?Q?Gh7qgayVZbXQTBwNtmafpJH1Gk3fLX5xjL/jcJMXLKaUNFAm8IizTTgZsKpL?=
 =?us-ascii?Q?pjl2CrJvlznnqeSpwKHwk6MGPe9op6hU+fwNv4SDMVZHeExCKNObSOfNiCKq?=
 =?us-ascii?Q?ZKWwkxoAg3KZhlefJFW+1JgQQPTYCdm/lCjOSI0xWK8A5GsKTCUxD+8NFfxS?=
 =?us-ascii?Q?d7z3JfDQP8GkGgaD7aCDTmqc5XTlqIDhkux6aJnnF/UUB/5JGoAXqw7j9N7e?=
 =?us-ascii?Q?nzfrZtRGKu8rGUs5+VgU6daT5l4GPMnjGneds+u7steUbQmIHpibKRQwJbxU?=
 =?us-ascii?Q?RUtv8IbI4aTeinrXJ67aeOGEYbs5cKueEGQnI5VXHcmvKdrZRQvHGRqIDGI1?=
 =?us-ascii?Q?E636Jdp1CuR3eyEl4efn3TQndqxqHPnBIeI6uHQYXzL7/fw//jtTjIxeizWn?=
 =?us-ascii?Q?xRD7+I/TiBlbNwukZBZa05B+iFWzdmz9sinkNK+llR/WbkcE0WZ48RYsVB8W?=
 =?us-ascii?Q?yXnBvciH8pSLkPffysl8bpq6PBhjbbPmMDljkZToOiYwlauQYtbhFUIxikiI?=
 =?us-ascii?Q?1X/OzzHpR7aHCEWiDIZeEV97TMiilywdymUD36/B9g3LFrWov1Ac2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8uvRVub3m2nEs285KXa0QaLPhRtLWViq/sT7CsvCqOhHYyAyvk7oOOPx5X42?=
 =?us-ascii?Q?FOMQ9sau6szItMGuHDb0MYfM3UxEkfZOV5IVzJ8eJsaINMKpZAvFnu5NAUS6?=
 =?us-ascii?Q?jaF6E9jA32SM40Pn94ityf4fGyHWkh3npNZ956ROty6RNC7a2QODbJCFYp1F?=
 =?us-ascii?Q?MvMbwedaFO2mWqpdS5b7Dr1Z8bZwUMTuCSp84zQJS54Ce9beRSLNwd27WKir?=
 =?us-ascii?Q?Xb7EErv9yWfAou/32Pi3cQJZajiQsS21xXHsZXE1JBEv0w8T2DLMX0yMfkan?=
 =?us-ascii?Q?BtaopM+s+6ybP7VJcvOJJplswzrOFVPA7bz/KqDiMZpPIu6bIgNPvfIJPqZ1?=
 =?us-ascii?Q?Z/rjZ9owhi3gEJ2OBoIaOpU8FhGBPANMb9jsx+yNrMVqiG/FbGiHl2GTug9z?=
 =?us-ascii?Q?cjRU8rhdfLF1pMUaZkXhtVdl+W5dnZcpu9cl3K0uvIGWJPN/6upwy0rKlR3S?=
 =?us-ascii?Q?EBRuGK7nEOioV4Kqqvz77AG9bT6W1z1FIXAQ9+dYYeTxcYoqC5+rnz9TkEQe?=
 =?us-ascii?Q?yUYK5e2aYzY8PtPTVV0h/loxj2lfq1ozgDDNiK573ZV2O/Dw4Zx3e1XSHx5T?=
 =?us-ascii?Q?9QSxbP5jGbYz/2C1YA0Yclv8XDWToHHKqnUhGPR4MpCcWTbe2tGwQ/SQblru?=
 =?us-ascii?Q?GjgIsjOT80SLCpcnf6lVsDVuxqa0G7KEMk4RWA6icgzLYz94rtQVljHNXUpa?=
 =?us-ascii?Q?AQiQf6ZmM3naWXELizraxc34l0chCqzKPDsFYa4xeFeg9Z/Ev3HlKKHw/3zu?=
 =?us-ascii?Q?A0hq7kGRQjbaOU95kpYNrLCymxHvPkeMFyzkA8Nx3KviQs79uTbeMmZWWaNe?=
 =?us-ascii?Q?em+3sk6Y7pVYsiPDNr/V6TnyQMVyZ6ad7e89xLb3klzzGTN/VZJE4U3CwZpB?=
 =?us-ascii?Q?i2tseu6UyJFTF8v0tzy8O9q67QhnAQkVEHlz8uUtKTX8eNl/lhvnIOk+iLso?=
 =?us-ascii?Q?OfcZTm96cOvVu3loREyaNxQyV1Eho8vpAAwAa4wEbFc4hU/QNsX8VOIpGaiN?=
 =?us-ascii?Q?42t+i0pQyNJzC0o3Ca8m/hLiCDQR+BAp2pZ4ZGFNe0T2sx1u1N1BKrYWhQy6?=
 =?us-ascii?Q?rnJzN6MBITfwt/bYuHdRVQ88kf2q1jIqsMgdLBhRDRP4WkRUBLBkGQedkiuG?=
 =?us-ascii?Q?YtW/4ABj+4G6c5tRdtugVny6n5g93qqYQxMBpLJq+17NbxNNwtKqiXAB197/?=
 =?us-ascii?Q?aXkUnCdIWkmeuyg2k3QfQPZIJFUF/H3W+ikecWxP9sbkaIzxpalHnTTyC3M+?=
 =?us-ascii?Q?QUw5hrcy2P6SyefaomXg8HgnCGuDZDjFUH0rEGciJBQu923k2qf26E9l1sTr?=
 =?us-ascii?Q?OyI1OBn0NmIhLMc/P4Zp4AT0KTQiulmaNMOTyH2m5nKd21Nt/0dRDjpvPgR/?=
 =?us-ascii?Q?UFitpa0fkE/2ihq4KzjcqXI/yfBFAUp5d1+cIG5E/XHNpODZNzXiMDs91DPg?=
 =?us-ascii?Q?EUZMUk/CltN6Yswn8sp2lJMWvAXTERiZYAtGForHASTh+z3ESiWu5AantAgP?=
 =?us-ascii?Q?jJ9nqhg4i0nFFPpgQzN3olEVHAHQyAo2KTHnfKtqKo+JOvwrs5QuUzOhuMy+?=
 =?us-ascii?Q?PkMPvg73Ijtc4tft4o/GL48G55Ey77mN1+o7F5Cz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8bd081-5915-4f8b-4b0a-08dde3b2c193
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:38:24.7511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHJRnmhqz2xiC3g6CJ5NNQ6uYXciD/liDDgv9SQN5eFkE9PjolC/2soaAdElXE75zLRTDlZC8mop0Ry8YUVbciMFGf3n6mK9RF0/3NSmL0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6998
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

