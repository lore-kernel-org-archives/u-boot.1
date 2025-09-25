Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F9CAC5AE
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 02:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF27836A4;
	Thu, 25 Sep 2025 04:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g5oF2OnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDA7836A6; Thu, 25 Sep 2025 04:39:05 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E6180819
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 04:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqq8xPVeOoHjccXONaDEYVK3yJogIey9S9NOOr2Tq7c1+VK9XhY70hXd/7ZEWwQ2nn+SIiULILPTg5Glakp6bVf7FT0OFBPZI51cishz5jV8cJIQxIe9xx7VrM/v6lTVLyhy8ZDKRRi+hEeyIHD2gIj6nyIjrrKU6Xv8nXxPGKw+Pyu5SiyJ1xmY27ECaipjFZhmTN8j4jFA98vt2yr4CVOAvdAoNAoz7KMh1DElaU7M19n96yEm2BzTKnsSlAorqtacGJsRmHVm/bvLpPmbDC0S4AQHhkIkNYp5aaUFa4b6AiY0nRoCI1D/JGOaVwrAgtg2Ez6ayt0w9LotAfeVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHfugqrwmBGq5kN4uA+O8PiN2Ov50YpiTcL8WXZvdsI=;
 b=adcvDsZz22VMej52a0kHP8UFQsnlw66PhoP+i5aWSiTN2glONscfr+AH1Kj1EzyUsdOmmSeEsoY8rwMHtZTxVa24vdoxLUWtcN5S8iLVC7j3nWsNzX64Gq+4a1hgvf96/x90vO+PGG2Ty2POfhp70pDv06RZwjzNhx/vEJeq7Oz6hv+YpQHu5pd87eJAE3snKoGl28Gq4YRGucVBNjM08pQl6DZvqtUD1W5O+K1hD3PEQiO937dHGZA38n4wymzwP7uwy80lhxyGrz4qKCvyan/IRWIZ6bSH+/MviN/dg0goXHiRxwF9V331Gaqlt5c/AqBcX6xOILIVAscgtwjPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHfugqrwmBGq5kN4uA+O8PiN2Ov50YpiTcL8WXZvdsI=;
 b=g5oF2OnUWj+iIEKvfWPHCjyBWR/yF2N8KvsADeRS66QsHypKsTeQ9GsatwNZHUENDvhhBt0QLD9g06eKCYpwHp0aI4nhRhXaJKzxocc0BZKvgKWuh3tCDpEyCtIiFdP8m42sOpI7L+OIKMJbzXFx7tMGktpUpuTgg7FLthsewg+9RrchCJ9/QTG/yqrNvOr1/lc9UOcv1Cs0fWX9sLmXPvS67SmnXQdHYOw0lqBe+T4qK8UNKs4PFjTDqvHcUSNo6g5zljPSCqO8v2EA97X/sXVAEYmflh0N6M4XgkD/9rlJgrFDIYCZR3kx7f+IXbtrXJYblwT9oCCwX4tS2xnwbQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ2PR03MB7497.namprd03.prod.outlook.com (2603:10b6:a03:566::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:38:58 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 02:38:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v4 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Topic: [PATCH v4 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Index: AQHcLSfZOaZGZAsBEU6iVOyFtOUli7SjMLvQ
Date: Thu, 25 Sep 2025 02:38:58 +0000
Message-ID: <LV8PR03MB81371ED29715C6A766C1EFF9A71FA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
 <20250924074911.15538-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250924074911.15538-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ2PR03MB7497:EE_
x-ms-office365-filtering-correlation-id: 9c8a165a-3049-4e92-c205-08ddfbdcae06
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vd7drYWcMhwbDV79mZPTl0aQVaA/IoV8c458RFxXoF00Wo1AJw0cYpeV28/h?=
 =?us-ascii?Q?plCvYBQWZhTxGdZstxARyAh2E6VZGiWlHve1mcvB7lYPfLCE5Pgqo2UpP4ya?=
 =?us-ascii?Q?0giCrOBYyRsvclPsbA8LSxkjTbEqLfhFi6slPtQrM26i6P+NS0r28CdSfcmw?=
 =?us-ascii?Q?+vhxZinUabuHMw6zdPZyRXMTitkUQDjxBkXVVlRxg0hD3gFv+091SiGYuMMg?=
 =?us-ascii?Q?wxBUkXRXcCz6Gj6KubD99GbRJjN/GyzzyYq9wyRxHZhAB4FPoZ194WgXJyLR?=
 =?us-ascii?Q?4hl7h6HSrgaiVt3D4WorElglnHUv6V24AEy2A1Lq2vIRGniBXqAutH+EWn0B?=
 =?us-ascii?Q?Eikdq+TbntWBzzsMRymUx7vDS44/1xVG19Y+DM3kwVcRNBgjm1+UBCfBHmBY?=
 =?us-ascii?Q?2cODcjhXz3l+BLxld3R30VFdGsPZvyGQnDZPLwnOO03sy+vIyvOoNRQ14D/2?=
 =?us-ascii?Q?LW0ro11aQIRNycdOQv+fKhR5WBvmnvHDovTO493NT+wbKTlRuKHKWPb/cgw1?=
 =?us-ascii?Q?9y9aOsN6OB0QyC439+fQR57w7zNHRCjqpPt+H8NRG15LOFw7z+LY4qdZFYhd?=
 =?us-ascii?Q?PIPfko4vvxwsTB9AHAh7Bq6oYuWReOFL7tj6fIpzGcmtYbq+rtBJDQl5M11U?=
 =?us-ascii?Q?6qDO0Js3JdRyVoYajnxIixBfigd7DBwR1qcHHbEjF6Y1prSOWKy09xINs/8h?=
 =?us-ascii?Q?aywN6REc/HYdSR4oE7rYL0fDme7MCxiuts0DYsZSppyH5LGrOL00TyC+dLdx?=
 =?us-ascii?Q?jRLGsAsgUbncEulFywUELJD/hGVaY5XQgZpMs5uq2xNCNmSVy1tEwmqyjNrm?=
 =?us-ascii?Q?9OvldcKxK88SiZrmDz595EW7+43G16ZY6eyF5ayKM6AFGBACkV83ULYL9wWg?=
 =?us-ascii?Q?dsYq5WQMdnhX5Jmr8GvJqHXK+Tj1+bLgaFlVsBI5ZqixXwaE7Pf1vIrzbetM?=
 =?us-ascii?Q?AWAVWfmCupM604/HqmdVhKoDqBLQQCj55bCt4SbYKLw73qLiZ2MbQI/r3Atj?=
 =?us-ascii?Q?LPyloYE9AZ/NcGRtIO3LCjLsNVVCOb91cdXNcNJHwKrgm67GWk03gM+Ttel+?=
 =?us-ascii?Q?HHJu17GlrIuWzu3p/n6cSha+EBCI5yWiN66GpWuxyhxE/JRjt51q7hCkxc0V?=
 =?us-ascii?Q?Tb0sRGsvZROYF1jHYwDvfYZ6t1Yg0ksqQqzRM2bGnQtbYYLju1fwN+xm1ty2?=
 =?us-ascii?Q?zOjOW6N1nyy66OOShpKKCvy3mPfX2e0y4ufX4qIbZNIf4p0BVW8v97G70UEX?=
 =?us-ascii?Q?8Bwq7AoGWNd+yVFd6Sg7MrXCDwa6k4vsEfuBif+OmW05X/OOdPgd9dUvpBqg?=
 =?us-ascii?Q?Uso0ShSRs71lSTBbKplJMC+eHfe55TD87Vup0E+W0tly8GYHgApPNnKRK8XX?=
 =?us-ascii?Q?UHE2SLZBzTjmXtbMNl2VKZynzZDJQ9qLPm9/FSappTLXJUPxV6y0CncbAxdo?=
 =?us-ascii?Q?8uqc7QmVgxZi1w0uRLmgEwlVc1VPn4oL5iBcmfFMVRj0ssk95jUQGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jad61Qbx74apMJ/deQV+nADvCTqu5AP/16bASd5mdA/fn2fL/UcIU6UI5jcj?=
 =?us-ascii?Q?f+c4IYfIOUDcxAUKYioQ7VT19s6NwrLBxI5z173sK36F8FffkBrI02MbC4LE?=
 =?us-ascii?Q?82e1PK/7sw9Vfe6MpQuBh8qR+zXqNek2JkDnwVi3PYx0eRMZ7H/ZoYhVKYqo?=
 =?us-ascii?Q?THQqEihvIW8M4DOjUMXeXHAcmLi8Jx29apwThC1+0rdmobWHfI8HXttrQUZu?=
 =?us-ascii?Q?UxojnnKQKMqEnw6MQSPDkoVM3eyyei2qjtyZLiCB/wx6WHPhvbgIKdOcjyJq?=
 =?us-ascii?Q?Q31h47tmQiQuWjVEN+WQwGlYQdg8bu7HzODpI+KYngxCFe7WgPBlG1/YT6lv?=
 =?us-ascii?Q?4dM7OiQPVe7dcYvsqiml4JHyjGCS87Su5QmNJJCvynDngO04tYBniIul1vbt?=
 =?us-ascii?Q?bNF2X9yMtZe4GIdjNkWU0hxrf4HXW6k+oakDk+LBpfQ/nzLYSQ2ZjEAUzxJX?=
 =?us-ascii?Q?/I9yfQFYeF9rPr8S3xp5Dj2jRIyowEPBU1fTaGM6qGr8Kkmv8ewlDTrOsYDI?=
 =?us-ascii?Q?nNXVbet/24M8QmfA3x2a2FcMzbbo38+24Fi7RdBkrWlj/iexMvBNS/Z4xC0q?=
 =?us-ascii?Q?5kb7kAdLCrgrtzIzu1yctV66aBx1xGhEsNXtnZeE+hXuySTlIeCfCRdVXXpq?=
 =?us-ascii?Q?VNIyTRFFuvQQMDgzPFheZmjRKKIKGLL/2IWW/mfG4VjyidZGvYuNMiPglVFl?=
 =?us-ascii?Q?tw+ZLhQRVnVeUnkhXu7D79nAFX09VldqTtqykuvpVk8KkQ2JvaF7LatLppbz?=
 =?us-ascii?Q?24WgCKMugsMgshL17k6dLMefmEnBk+CT3d1DCr9iiTY1Lg76u8/gVV7zVqh/?=
 =?us-ascii?Q?dIkqWS6ikcgIwt9bDeUs4vcF7BVtPBxR/7tl9xeZwcTZyCnch+UbCSjpqVNj?=
 =?us-ascii?Q?D1DDIRjHr/MoyJSyQeXAtTLN6UUm4A2u2y1OFnZj3+VrrxpgdmghgnUY+5lB?=
 =?us-ascii?Q?wbT+EkJb0pSE1oWRwEWQaGQ9IYipeF9n5ODESwUiY7J2pH2qi2unLDQ5SGVp?=
 =?us-ascii?Q?ztaNCLFC7R31+4q8OIT54/ZfDEXjmHMOq6Iyl349nNNNSQFKl81QSclTRVFT?=
 =?us-ascii?Q?A0QLG6IVgMag8UITwDOachuseVvs/Kxza0HtRX/aV+m56v74DXwVBw35JUSX?=
 =?us-ascii?Q?g4CfahON3Q9yeTjLsdNUZTM1aU8l+wFj5jDmPwW0TIozBBhx7sP7EhujePnO?=
 =?us-ascii?Q?0g9gJS5CNGNkmWQckKucKUcPBKWi3fnM78iuB0Ai4bnSpOxgKJEoCLG5eaNZ?=
 =?us-ascii?Q?zyhgMq2vEzZHpykN4zSeB3Pmgq/3nIEmKVFFdDjt+CoAGAHPUV4IjT6cA0sa?=
 =?us-ascii?Q?h00KrSJzT0BmXlSLced6JZsKtHAW6HidhKNXl/5+IJ7gd/IVJBBboDqfOps1?=
 =?us-ascii?Q?80ieLedbM9+MVnXyljlj8uOv1cBkQHz+3qZn5qbmjrnP+Ww/zjVWkrIxLl8t?=
 =?us-ascii?Q?615wRqdfLlJZLJST2uiM+AcvDhOejqKxK2qN9S6N4vMHvPj29ikBuBL7OEiT?=
 =?us-ascii?Q?saik2l55VjFMhINXrwx9SFrpuoaPYC5OrMG5tpuShokkNLi0DuFHOy4c2gJo?=
 =?us-ascii?Q?MMuUFJ5/1/yFUc+oBR7GB5DGTRrY61xwEtHL/G5Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8a165a-3049-4e92-c205-08ddfbdcae06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:38:58.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTR+A5SGoGpLXoTV2uwQ3D9MUwRR144igsFeI3frl055FaBC9lz99ZTL4v7kqe1+2bl1WwMJQMFte+ck/XzmDtAfC+vySloSQn99nYzSHRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7497
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
> Sent: Wednesday, 24 September, 2025 3:49 PM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@altera.com>; Marek Vasut
> <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v4 2/4] configs: Enable USB DWC3 host drivers for Agilex5
>=20
> Required USB DWC3 host driver configurations are enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  configs/socfpga_agilex5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index b373201dbaa..7cd2fcbf4ac 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -101,7 +101,9 @@ CONFIG_TIMER=3Dy
>  CONFIG_DESIGNWARE_APB_TIMER=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
>  CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_DWC3=3Dy
>  CONFIG_DESIGNWARE_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  # CONFIG_SPL_USE_TINY_PRINTF is not set
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

