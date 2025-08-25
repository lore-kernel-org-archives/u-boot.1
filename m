Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF19CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFED828A2;
	Mon, 25 Aug 2025 10:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QSEOATd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9E782DA1; Mon, 25 Aug 2025 10:52:10 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AF481E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/xpAkeMC2QToEf036YvDYSvfovSnaHUQiZpKVoetFgiPnS3UHzSnRck/otuiYDnh7K6vaIW+BYYqnDe+eR0VTZDWWhazoeuT6CVKbSWOUuOD7FcdUoUDv/EHCKNKT3gYnF+NHkT6naNbJOkef+atz0pP9fsqXbK74cS2rYpCbypG4Q8/zhDW4CCCELhvxQWcBK7U49Jzw3R6wug+ziWynv+IifjUP6vsXoywtVXpIhFtdtWWOw7i81d8ZiVFUuE1onAjEroxrjmpfTPSGxYKjUW4ZG0IwiYXdPX0Og3SGkfkac985DHdc3ToUCgnq4URgYIaHKskC2rudPFzhiSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD7kApC+SXcVRrqERaqa0/xtQdc4yxkVLkSJQAC+P+0=;
 b=LEk4OWWCVfTjbcKbYeCT/GtdRxkHdNwzbtTgrtRmKt3o0/O0h3YgzlJze4Q8kB7TpoWbu9iREBFZ+X9XDjrA3kfmyIvgZhnrCDyE+yjYciltz8NMaN0icW7G1WoPBXS63s2tp9qy7SSFL8JPr2CdlVibRuutg8//TULRz6yejwT3f0RzRD/8EK8tPOuaJsrZXtkVRv9P6PUYz0DefrQNgH7s7jPBnWOXjo4CwleGOwsCOwcTOnnCq0fqIPGQdphBjP1NetJ6YHts+J0UKDP7DdKwogZM6DnesjycZPCzlr1ZaU86dyKhTUtshrf37Pz034UuFmr1rXsLSjyx2Y2RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD7kApC+SXcVRrqERaqa0/xtQdc4yxkVLkSJQAC+P+0=;
 b=QSEOATd0Kp4ZH8U/JSZpOwR+lT2bZciJvZTnoYsVEjDLLQxqtl73qD/fm2oXiQHX8XVzJCK+PW8hOvSI5vX6pioINbCblXBirlcQHXuA3Yun5ScmGGu5WRDd3n1m3lOp+hHpWWw5tIMVF5RnVNQY0pN2kSKuAaOKNKmHJ1TTq1CU6rz1LJFZRgsaqEyIlS5FasyXUKGDj+HYTa3ySnK4pe1/NNjQqMk5yXiK+bW/1RnxbheXlW77QyBM+etqA+G6yRVqpqGfLTTOesx8yn2VHptjDwJrVaBEFjKW9BFIJNRbgUluvtzna68nrGI6ueDi7xOxrBfU0IhGnHSt4800dw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BL1PR03MB6168.namprd03.prod.outlook.com (2603:10b6:208:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 25 Aug
 2025 08:52:04 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:52:03 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arm: dts: socfpga: Enable driver model for watchdog timer
Thread-Topic: [PATCH] arm: dts: socfpga: Enable driver model for watchdog timer
Thread-Index: AQHcEL/+jTGYC/+HsUuaGqYG0V8KUbRzGX1Q
Date: Mon, 25 Aug 2025 08:52:03 +0000
Message-ID: <LV8PR03MB8137B2B02B6141C1FC36B16DA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819041604.22221-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819041604.22221-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BL1PR03MB6168:EE_
x-ms-office365-filtering-correlation-id: ddf75b40-64a7-4c09-7d6e-08dde3b4a9a9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8YkOWGL/Nj2ee7BhGW1iMpOsEsJIJK5N/+g2j3aGBIQy1fDND2m0ogtOuuQE?=
 =?us-ascii?Q?zKsgmKQtd6WoU14OEa41sGSg5Z90oF+GAZOiBycLH3jSnpQ6f1ESBZIBctv8?=
 =?us-ascii?Q?PKxLzAE9BXOfQhh0K+PT8rFte6dc2ZCEDi0EU1wI+kPNq/VRIYzqkvrpDWdv?=
 =?us-ascii?Q?i+9ySRf8VeegmygCeh4UEaZkfZlTjshXKIl87h9WyGFTgdKZBGnSYYxH5u5w?=
 =?us-ascii?Q?Pg8XHOxVwcyUzvOQFeQmA6QsyUCo+jxIWEutAE8Z6AyPyOfKeOGWXRSX+1/b?=
 =?us-ascii?Q?5QDX9gh2Weq3eujmhfuTs6/ApR1dfZB8BdQdE6J4FSwSgp9+dYnrYij+jWUk?=
 =?us-ascii?Q?3ktJo06cQsA3ZGm5Yy9nGJe6WejEn5ZUUbIE7ukJACvxNIjzk2vsrSY0u5/s?=
 =?us-ascii?Q?XOk3hnNO6y1mu2kWibxPcmk9SU8DFig9NRiR+5J91tuympjoDbAqyiuauo6x?=
 =?us-ascii?Q?EpXMAbDH6sqgLfMkyHwa/lnlUqNMve5+MWGPFliOs1pw9UILP2xVUlFH2Vsx?=
 =?us-ascii?Q?fz/y2EAuyS669ss+jFZuqKOsL1QCzkN4Qeto4rmk909XvN05P6NDKCBqmZSO?=
 =?us-ascii?Q?5WfJ9fTpvYTteq2WqLwS7IVXg+qKK3LVCFaK3M14b0lEhbejVHzO1++ULsP8?=
 =?us-ascii?Q?oisvY0bGqP+XVKHZTEeoWh063vJpdD+qHfbXTq1Tpqpp3YtJOTg1/pAweDkN?=
 =?us-ascii?Q?Rm0FsxrUQ6TY3KDYO8wVPbgahuj4J4nF3WtOLn6d3ruVFYc7xqGrOoCjA9P3?=
 =?us-ascii?Q?pyj9QrxOXzxrRIvGovTG+GJr1ARmgeoMoeSwOjZl7+Lylfq/x1ev8wpyuJLh?=
 =?us-ascii?Q?rg4CYhuPGNGQFuqt9dgVcpwVCxzQ1jXS2geJV+AK4EDOvLR7Nz2x79AWPHEk?=
 =?us-ascii?Q?3/Dz6uGzwfDttpNkvE0b0nPVLCpADp/jWKIYbFWtrtKsQumsARyKM2MYoX7a?=
 =?us-ascii?Q?YCMpHiBfm10TyN6jJy5B6O1YqTFeqMJn9E9r4BaN+YV38aE3LFZZ6xOg0dXB?=
 =?us-ascii?Q?CreWv4gNBjKZp+qV3HJAE3s2M9gBmfFlsbbEqEzAb4AgsbHLP4sQco4I+GuY?=
 =?us-ascii?Q?n5R8Jxo5y/z/7/zQJ18IYv6mSzaFYz0Afsoa9yw7eFBuJJph4/fpC9yQBOBM?=
 =?us-ascii?Q?VXrrC3zEKAcr2klcpqtVyRU1Ivvm6nc45MBxEbz5joYnnKvEGihWJmiB+D8y?=
 =?us-ascii?Q?b6ChPdsQD2p1pLzddyfenckH+46tVNGd5W++160n6UAfCyT8jRxoczWCyME0?=
 =?us-ascii?Q?YrlpWfPRXzk/GmuxbLqF/Hay5nsiTAsrA9fSJceakGkVZPKgUxMisETFU3wr?=
 =?us-ascii?Q?sbstKzNltieydi2rSL1hze5FqoRqgCuQFSDZgDMle4XU5NV5I+KZEpjTDut/?=
 =?us-ascii?Q?xFX1/tgUT64S41MjhfZx80/5HwmHtSIAZa4CvZJnKHIWwL7du7UT8MNAPIu9?=
 =?us-ascii?Q?5U2V9zyIWGysdoY+afLiDCeRlUhHFlJoiujY2EUHGj+QCxtQv9UrQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ePxSTPiX1NipH/lJHoIsnuT4iEM/D98PDPmQJfRm5N0/Iq2vHgCeLkfCmngW?=
 =?us-ascii?Q?xncikyLhddB9pNh/c9J0cac4S1AGfJaeeFBCkAmrRr0Jm+KpW51uE3Nn6Yy/?=
 =?us-ascii?Q?EyP7wBtWpMBbE8hTO1dsfOdcWS+8ijU+tjoLBC6VrW+7iBcWBp9bOhtXI3x6?=
 =?us-ascii?Q?KM7//t06dx3q+roaqu0rulzvZm9RCBWA3LHwi8518E90Svt3CwfZJExnRtsI?=
 =?us-ascii?Q?OnVGVEiq53s4tvtfcaXNu3/R86bCtUoRmNuRK8xAYaDdolzDCADkEbNyJKyp?=
 =?us-ascii?Q?BHadjvwR2sDNGEClpTD9QQNimT02BslTJdznanTJQclqN6M3dVQIvVrVo/wI?=
 =?us-ascii?Q?+99W+g1i549rJK6p4J2O5NwvYDrV+AvR09TVov3p+7zl/c97wRqEqtixGch9?=
 =?us-ascii?Q?QMFwS6WQlLrnqbBj3hUbqOoDb1DRejYQZrljgZMSNIvROP9NIzQVtBtIIfTT?=
 =?us-ascii?Q?KLPktQxpD0PSkazxrv/MOGCR0AHOlacw2JXjpDEHFrgA92dEfkyVmgrV888A?=
 =?us-ascii?Q?zPF0SzjEQuxZJBOhzaa1ukihQ+Af2gaNmUeZU1g7acWzgLaWJhTygIvUMHym?=
 =?us-ascii?Q?WVtCxi2UPMQEb9CoxkAdnwwtqqPfT3P2Z62fhu67fW7kEvnVEtOkqsgO6YVV?=
 =?us-ascii?Q?40HYAcSHY7Ng7R70Ed3gEmbYN8VzvVc54CKGD6U4+CU3AAvn5b5UobJ17eyC?=
 =?us-ascii?Q?RAb/Cudknr/N5u213KLy3C0RMHMl5wentAUw4wsIBOMPlINmeC+a64PbLCEK?=
 =?us-ascii?Q?+D0xfn3HsOKJnpMx+/Q1ul6vNS/LUJx4lJ7MgvZB1xIh2VVmaFzAdcTYTKan?=
 =?us-ascii?Q?P76WSYs8UwOlfPhkjzVgMGOsxWusyCH/AlGxC4hgJxEBgtCcbA/jBGvYmZ6d?=
 =?us-ascii?Q?GiDNXGntzwT3ga3Qj4u3Smwu0Xq7qfOgcgGvXblHLxcoWQ/FYcn2dDYTHOM+?=
 =?us-ascii?Q?ZcEGdMT7k/fzrgGH+x+Hu2f4Zbbp3rc2bkmnW2wuYMQ25gEYapif/aklicwo?=
 =?us-ascii?Q?9i+VW4LSOyLsOrlG89h/ckFaJi0Ykw+wZtc17si1PpJjoWQ1XTLB6QZ0yuEi?=
 =?us-ascii?Q?qsVpQ/VCWzFFd/1ESU/yKzRDjmTFjmRJ9khKxAFm3jeXeHw57gg/T7r9KsJ4?=
 =?us-ascii?Q?vwER2EAaH2uBGP5/MoRRqj5uWmGZV6mYaJCgNDDZxZc9LJIsOjLBqAIfdKl7?=
 =?us-ascii?Q?+clI6DEfPYcBCoNqT1RMy38DHSyluNqMGzNbTj02xy9PCE56OCZKT+K3JqIQ?=
 =?us-ascii?Q?tm9G4H2pVgeDANeOznU2guUjPv9/7kIg76vCZwRw4axVcm4+n6sqpOGr1ByU?=
 =?us-ascii?Q?RBfjAG8Shlxn8bdtLe6IBURtX6Gw4qk6VJU+fIxK8zS20eYIlG/Fls+wFC9k?=
 =?us-ascii?Q?Q3ewYt5J0jkINUF2zlAJsG6WxuZmLy24skTxfYKeQf+fj30mgC0Oz1sAfCI4?=
 =?us-ascii?Q?0DXIGtC3M8K4Q8E0Zmi86AXPOIaOZSt5HnYGXw56NWj0pKprAEayz4gY870Q?=
 =?us-ascii?Q?2GcC2qLRSQfIILvTQ9zB/PZOIzHpT0cHMpwzWNXGb/0A/DyI57ugbaOjwpdL?=
 =?us-ascii?Q?d+urZ7GIQ2esBwI1XYGwEQZBdY5jUhlJ/q0lMEIm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf75b40-64a7-4c09-7d6e-08dde3b4a9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:52:03.5930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TivlU/SDJAU0Obtr10MzxusfVSgn+YkA9XtqtfjwnLqwWoMfFQMeu42HYCamfTEwQxMMXlti8E6WTDiVFmJ31NM2g8NIS9F0P7iZHDVlQy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6168
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
> Sent: Tuesday, August 19, 2025 12:16 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arm: dts: socfpga: Enable driver model for watchdog time=
r
>=20
> All SoCFPGA platforms are switching to CONFIG_WDT (driver model for
> watchdog timer drivers) from CONFIG_HW_WATCHDOG. Status of watchdog
> is enabled to assist with this switching.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_stratix10_socdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_stratix10_socdk.dts
> b/arch/arm/dts/socfpga_stratix10_socdk.dts
> index e6d8fe6a907..864f4093ef8 100644
> --- a/arch/arm/dts/socfpga_stratix10_socdk.dts
> +++ b/arch/arm/dts/socfpga_stratix10_socdk.dts
> @@ -137,3 +137,7 @@
>  &usb0 {
>  	status =3D "okay";
>  };
> +
> +&watchdog0 {
> +	status =3D "okay";
> +};
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

