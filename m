Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9545DED7B97
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 02:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868D283936;
	Wed, 15 Apr 2026 04:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="voow820V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A84839D5; Wed, 15 Apr 2026 04:43:03 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1F580086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKXso/AdBYxA5VCN4x8MtM3uVtok0A2Ag1LzhhNdYNAIqsbv/na2UZ5ghGt9dQfjiLGVZtyewBPx0RUqIOKHMBNJxo1tI4jNCGtsaGjZrVun28jAErTXBRwAENytEUh4lVBniVVp//FoA8+91QWJRrJnh/mt7r3X2VdaBmIzrtIlgcvp6CYPnPvfMkPyc7vchR3QqY3kPLlDnYiWXwx7dbZFjbBqbYLilc6ivQteWEWF6PURczcHq5ARbAmj1kEAzHAyL/Q/CAA+aYG+faPHDkEjS1NqFruEFMJ78QgvyaryQ7ON6/uUlm+EBQO/KsR2fukrUSFqE/P4d+iFPA4ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpXBBcoUGOYIhYIdRz3jiCOowb1e6Nb+EXIVMXI9C0c=;
 b=m0HK2kdSh2m+O1wrHO4qwyIXuAlbPqzKuyXxWGIYzGiHx+igo0ECKhkQ+9ka/wV2GlWB6vTlrJo91s4aE+iJfWwoAcjoTqLbfrD9SekTm9sI7FnEpmdylSe6qlliy0rvtJGToDSmHu+6vH0+PE2yxo37FTx6KBgKPuuAfUISuscphllcCFtfGvUQy5QcljCghF4SKvwn3n2436BUQtQkDSz7l/6I2cwtqDnZlud70dyDrXzuLRlOsCGfQdOyTzwM5WGeeenhGi4+gg6QTNr/Uep16oExYutOJxWyKVw/FBYb1k+IIz6JdFgtsnQ3y9/26NwllnKy4I0Ip8dDWLemuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpXBBcoUGOYIhYIdRz3jiCOowb1e6Nb+EXIVMXI9C0c=;
 b=voow820VfMQGZXz1Ud4hvpT/q6QKs8tMtPTsUAgpzKpcutQ7bBTjZlxFnGlDJgexeNBUu/WnNEyO5jIDQhdNlaYqmWyj+xTtPBepGXla5UdVomLKjZlJrrozAMlYUcYV4t/L3Rav7fBwJhanNrQJWCNpluTgDq9XwOeGDfpMDJ/khsaNiiDPAFxRzfIp339MsqaRhS0WHgkVn9jK6td2WBJrKP2F2/lsdjxv812a6mbWC653DRFC0/1/YdsxW1kFbyNCpZMu9a2WVSIp8o9YwUnZ0/ZQOXBuWvUsKqkOqb4hY511bwYBmiygJoi3p8raNARffqhUQtIRfK2M1u3NXA==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CH2PR03MB8086.namprd03.prod.outlook.com (2603:10b6:610:27c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:42:56 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:42:56 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Chin-Liang See
 <clsee@altera.com>, Dinh Nguyen <dinguyen@kernel.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Tom
 Rini <trini@konsulko.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: Enable CONFIG_WDT configurations for cyclone5
Thread-Topic: [PATCH v1] configs: Enable CONFIG_WDT configurations for cyclone5
Thread-Index: AQHcpj3mszrgyrCvfEKip2moS7oR4bXftnvt
Date: Wed, 15 Apr 2026 02:42:56 +0000
Message-ID: <CY1PR03MB8121BC3368572D5873011F91A7222@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260225100218.9072-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225100218.9072-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|CH2PR03MB8086:EE_
x-ms-office365-filtering-correlation-id: bfffa450-5305-4f7e-4c8c-08de9a98b328
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|55112099003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9NJ/cJR5sEART2itVPTGTLEm3Xzg/Bi3kpXY8Mb6Wq+bXUzBr0UzkgVj4YWmhp5+O5aaJ4Y1KSXOLccJE30zgk5CM2wZChfpCiCHNJNvDdnePnxMCcMUqGIJNifdlVVMLA7DSbW55FmLAv9jYmufILWl0WbzW9s24L/G6wI0rh0RFT5KMXoQo6yJQYQ8V2/yVckiIvqH5Oe2M3ZY6UOT0adJbQOWXrRxhQmOgs94qBbY0kRfzQPRYwun4z52EyhdH5pkc+S/Tu0xVqoyI2knTJd0UnTdT0rKxvaP+NaFunfjlpLsRKkc2khaIMbDhi6fiheo+wtCgp1/LCLjzyvLx+Sz/aHU3bAeJ8ntTv41LVwHruYM7kClu3+BATs7K04ueBj30AxTED1EI3sHI0XatDH7Tdo9F+I/MTGHeQGyCjJLdlC/BZpqkZ0aWnP96duwuMiMPth64LTtMv3DMHu80uawyaIL9gMo6nYyNkFgJLVc2x5nn44KWa2ZTU8YL1Rd43GkyzGxBl8giLZxmaVvCAdcjGxO+LU80wASBjnzkxZflxZyV9nrziAuM0xYxuqGT5WrB2pSgSqinlyOCtTIFyWydu+HBV7jKk5qymwHQ76/hXcuqqivKEJi2snfIUkJbc7WNA31TuVkA2y1fylTOTNJljPkIWxSr56+rL+erao8YhRtUyepM8cp7oApwD0438m9yK4VLpARobG2p6Sfgkq5vfHpu0yKZZ4Q+urmC0q+vD2dF3iAidpudlQdTestPeg1Fa1SbAUMhqKjVNKPU8dieAXqeiBi0QfWbpDwlf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OAo2XeWfK43VX7sNNTYO4Nlfq+abHuLjdSkGWKTLt6ty41efKbWQ/nmr/Q?=
 =?iso-8859-1?Q?S4CRvHaIN1anqBjwwR4JUWAjo9v2yhS/9iIlEwDmSst4mWnwlXWQpoiaf8?=
 =?iso-8859-1?Q?cn9gQ7N79HocLSbw8yH51XPRBcEWdnRRZ5GBfB+LMXJN/iKjyTomT5tIrL?=
 =?iso-8859-1?Q?4TWQCzwB179mI3SbLMtKluJaQ6ALnTFGqJpqpnndnmNFcAeFWNadReC0C2?=
 =?iso-8859-1?Q?5EmhUYT5t/wpXQCfGBpCICpn6jqcxBEING7QkajyN/a4QVRJIq0A0mqFpr?=
 =?iso-8859-1?Q?rnTWGlrTYHFpW2RNdB0t4nIz1bLp7NO4PcT5PvuzS3MQC2fZoUkQnmr5s7?=
 =?iso-8859-1?Q?x92iyOcIoGpPzT1ek9Cy0eYtYr18KSvXF7it6Bi4mvcxpZpZ7STOwFzWK7?=
 =?iso-8859-1?Q?YKrpHOH50wl6E2z6B8UhZed6oZr2KIlMFY64L/AretL/UUojZWI1aSkkyo?=
 =?iso-8859-1?Q?fTDH84NNA58FMbwDf8BmPPqWOeRsPLCDZ8IeD4P5nt/1klvfRyWvpX9ukv?=
 =?iso-8859-1?Q?xv3TXGmisXZk2H55DXhO+ivAp64wp66wzcJwPIyawTYI33Yyv5BqhGuu3N?=
 =?iso-8859-1?Q?F4FvxWM85gv/K6vPm+u6atNKpfmN5gew8oamkOkiemNztrIx5mVLrNBnOn?=
 =?iso-8859-1?Q?grakK9zjiyN5OE8oXlyUE1XPqyRjqXbZthWKEcltzRQQ78Fo88KjpugOtM?=
 =?iso-8859-1?Q?cpda+ETM6zGrNCBBMXqGhmh7Of1/ByX/H/fYU0bQeI396eQkRTyIV3wYxm?=
 =?iso-8859-1?Q?G9KzEG6cWPatfj9gld+Dny8pkY3bWzkVvdtrEoQZLPCJUEiiofAu1HUs9W?=
 =?iso-8859-1?Q?g3/wmLoOiC9IkJi43T5FTKvu8als9RwIqYDGjX9A5sOcScDHUbHFiixc9M?=
 =?iso-8859-1?Q?h4DDCTRW3hQlYq4E/gNddcjQKaY8r8iCIWmo5N3KAFhfj6WvMVjrs32swM?=
 =?iso-8859-1?Q?RGgkDlJWSGVGyLNaOa6ZpCmaJ3yCVYTMvGykisx3QDZR2R/Yi795O0HN8/?=
 =?iso-8859-1?Q?/IGVFoqru0eL3aqDtr/XtLV/N2Fiv6DpswaccKvVBUMRrBl3pDUpSPIgsB?=
 =?iso-8859-1?Q?b5wwVid1LXJ/Zh3aP1lq2I3rRl6JoJg3CSGb3RgMh/UnUk/iy1AFcZF2Td?=
 =?iso-8859-1?Q?pcfw2LaPsGzA/vaMXaEgoBuWQXZc9VKmHrOvZNlJaoH8wggb9HKdsJdenH?=
 =?iso-8859-1?Q?+y8wMUVUazYHYR6yU3H8B1Il2oNdW4AtOt2ZGkqhMQ1nO+aXzJ58smdu59?=
 =?iso-8859-1?Q?5CsgzHweGEw1ktdziei+hO4op6mIwOUWQIJ+mp2cinvzMd6y1abNJBxTXY?=
 =?iso-8859-1?Q?QVmQHDFk+UllxBxWa9h+qWx/rlZiYUYlJi7lpnZZW8j79QzjHfEb0HvFkR?=
 =?iso-8859-1?Q?mBmr6ev3ipII2HBWEhcgHpJd0kunrec/yu/sOjNhofI3PuHXOY7zOMEy27?=
 =?iso-8859-1?Q?bo9BVStR3ueiVp5O7nisxIDz8I2TJMW4YrI8kNG+YUUuqK/ccYS2VSUlDr?=
 =?iso-8859-1?Q?rss+I1/JZoGz9e0E1PZFH+U41lpnIlSS4ElFyD/Uho36H2/S5HhvyXEgNB?=
 =?iso-8859-1?Q?GgR9TmCSi2GMfuDNh5sRUbiqHJ40bQ569pwwGYkzo+xO0ESiUmIpldy5fN?=
 =?iso-8859-1?Q?cnsRa1sEqJjKbyhODQqYLB2v/Et4INcJsDaikX+mvaw+ss4I4lrqDKOido?=
 =?iso-8859-1?Q?D2CgjvV48mY3FHeeQHYQ+cMF3X5lJXdzgS/TbtM3XIr7bEUfwXPh4DgTsM?=
 =?iso-8859-1?Q?UwErmEi5c8WF5ck7cJd3o4kMwVd54fTkRGOJq8Kwl5p366p2ueidUb8Yf5?=
 =?iso-8859-1?Q?IHXlT0C0TA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfffa450-5305-4f7e-4c8c-08de9a98b328
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 02:42:56.4083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN8kOP5CUorzRdlhNsc5/oDppIVRUiRBel1Ri+qY0NZkxLztvR1MuCHQ0DioHe6Fe03xRUPNsBYwxRrxzZKpGnPNQZFYMwfDg3lQWTY4iaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8086
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 6:02 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Chin-Liang See <clsee@altera.com>; Dinh Nguyen=
=0A=
> <dinguyen@kernel.org>; Jan Kiszka <jan.kiszka@siemens.com>; Marek Vasut=
=0A=
> <marex@denx.de>; Simon Glass <sjg@chromium.org>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Maniyam, Dine=
sh=0A=
> <dinesh.maniyam@altera.com>; Lok, Chen Huei <chen.huei.lok@altera.com>; H=
ea,=0A=
> Kok Kiang <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] configs: Enable CONFIG_WDT configurations for cyclo=
ne5=0A=
> Enable the CONFIG_WDT configuration to fix the compilation=0A=
> warning "unmet dependencies". CONFIG_DESIGNWARE_WATCHDOG=0A=
> requires the CONFIG_WDT to be enabled in order for the=0A=
> Watchdog to work.=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0configs/socfpga_cyclone5_defconfig | 1 +=0A=
> =A01 file changed, 1 insertion(+)=0A=
> diff --git a/configs/socfpga_cyclone5_defconfig=0A=
> b/configs/socfpga_cyclone5_defconfig=0A=
> index 1ce0b63aee1..80886199645 100644=0A=
> --- a/configs/socfpga_cyclone5_defconfig=0A=
> +++ b/configs/socfpga_cyclone5_defconfig=0A=
> @@ -79,4 +79,5 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy=0A=
> =A0CONFIG_USB_GADGET_DOWNLOAD=3Dy=0A=
> =A0# CONFIG_SPL_WDT is not set=0A=
> =A0CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy=0A=
> +CONFIG_WDT=3Dy=0A=
> =A0# CONFIG_TOOLS_MKEFICAPSULE is not set=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
