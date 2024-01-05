Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A4AC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 13:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3D087989;
	Fri,  5 Jan 2024 14:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="kjlWZ1tX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D00878AD; Fri,  5 Jan 2024 08:14:47 +0100 (CET)
Received: from DEU01-BE0-obe.outbound.protection.outlook.com
 (mail-be0deu01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2622::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BDD8765B
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pog@iesy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+QM5OWSRPcrFDaSY/HS9wn01EOOhkKdqsev2cWQ//YrauhT7eh+U1yWvICCTChUmw2ABqTzCdmzm9ZJ4itUvGiNm59cV0gmD/gP4/O7NJW/t48qHy8Dc8l/5yocNxn3WcdHhKBn+jHAlVGoMaQycMMyqGfkRCyBPzBr7RrbpMFIPEd4iWE2ZVBMtnZez/9ijR5/T1xGVMGEawo4CrfU36iEU2iyIs7RimDcjTFTJIckeIm+1o+MV/htQ1JdJtYO6oFlQXDRzDFPsuMfk66l87WBM/eOxrr7uDBtG1NfDtbrzVY/gTIHjj5y9D7Ba8A85qzRv1OQG/3HM1n9Zvq8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD0W64x2mM0Q0uPr3hK4+7JiqJSxHkV/koUKXjxDb5M=;
 b=Y26TY6N1DBXwY80rruR03m+S/klXIlWPUYLQo7xgyUMghP0bmmVQm/bcroTo6Dv0sjgFHTk83+PlI8M1E4G5NAgDb/fAuJMuw/14wFwzKkRgLOQH1pOX/bCHGbf5YCI16ZAKGXxFKrohv1rO/Fzqkobi3L68I+pPT0RcdeZ7OLqhh60S545lMwCvsbEYgJtwB3eT7yuyJs1K8jUWT7J9YQb9PNgtnt20/AGGvl58HV02rA8Wxn/b62eW06v1fA8SYo1MbYpPYmy/gwRHmd9XPzwQacC8KQv0qbl7ytulmRExM9KweqPPw5AW4m2ZvyxI38J6N+xYEe010ZDToJvtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD0W64x2mM0Q0uPr3hK4+7JiqJSxHkV/koUKXjxDb5M=;
 b=kjlWZ1tXVy3dvrBmPCXN6KGziyHA3XDiN2EOOa2fov0B2vctyR/R/rAchtGuYoM6JVJKTRKT6WvPeO+0KJwNFRvOXjMZKT1FHTkvU9TynuIPH5XV4z9o1QLh4N4HxbC//B3y/bR5I+XgACTTqMaVxnbPUnNjjKteUFdKWjj4Lfs=
Received: from FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d8::13)
 by FR0P281MB1595.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:83::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 07:14:40 +0000
Received: from FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1f22:f4fd:3219:c4a3]) by FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1f22:f4fd:3219:c4a3%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 07:14:40 +0000
From: Dominik Poggel <pog@iesy.com>
To: Kever Yang <kever.yang@rock-chips.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, "philipp.tomsich@vrull.eu"
 <philipp.tomsich@vrull.eu>
Subject: AW: [PATCH] rockchip: px30: add support for iesy PX30 SoM OSM-S
Thread-Topic: [PATCH] rockchip: px30: add support for iesy PX30 SoM OSM-S
Thread-Index: AQHaPybBIjMnFCI9D0CDT0wDACCRCbDKXkWAgABu3jk=
Date: Fri, 5 Jan 2024 07:14:39 +0000
Message-ID: <FR4P281MB3698ACEC5FF379620824815ECB662@FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM>
References: <24ff7347-650e-4b80-ac35-a8c535c76648.51c8ab6f-2707-4fec-b864-8eb3a5aaab63.7a830c6e-7d44-4432-91a3-b946b5cc41bf@emailsignatures365.codetwo.com>
 <24ff7347-650e-4b80-ac35-a8c535c76648.370f0e5d-ced9-4d8d-88a7-90f9b6de22dd.47e95517-6707-42c7-9fe7-6620d853fcf3@emailsignatures365.codetwo.com>
 <20240104155706.3021339-1-pog@iesy.com>
 <d970d042-0084-411a-8ead-3738f3e95471@rock-chips.com>
In-Reply-To: <d970d042-0084-411a-8ead-3738f3e95471@rock-chips.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iesy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR4P281MB3698:EE_|FR0P281MB1595:EE_
x-ms-office365-filtering-correlation-id: 3406f2e0-e156-4198-4064-08dc0dbdfb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kStDH7haCcza7nKoL6RSkiSdZfgK+8TxOvxDXH3NagRKq7deTkP6F5FUFGRpFUUkTY+iAwRdw7JJg6Y3JsP+4/dSCw6yxKKvTqY3CxVXYiAXqPMx6u85s7Of36Yzk3BoGmgDAyOdA4Xvq5Rm25HxDNvGcJHH8oaasN/F1ZvYFEI2e+Vhkeb81yp8sDikeZJaLVgmgnSCBd0b0maL6z4htlqDqAGUKKa4G4BR+6nJ1BtvcJw3i16wEF63pkond4eXYZiZVC0vuh1yUnHFFVQO2zAl3L8gJGFIh6SjxR9bUe+jp4fVsw7Rbkzl28I/j7NvlaEk/YmsdZqxrA9ZjnVjUsDGX0SIjuRIz8oEKKCIsf3Luebnu9uMu4s5wELqgvGp7nXMrAkmo6RW8jtuoYqdqSm0t8ng0aYjNdviCoV41GIwAol1NMGeuCv+sd/IBsZRD9G36+mkRYN6hO9eUqBpWHN8KA8N2bxxm3Nyg0QQmTk6jlQmlrNqLL4f9g/Xaphi3kkVWvlVAhrVdk5mC1/GwurM6D3JBfFs5ruJep5zHouRUMQl5fY7lYd+RZxsWg7jsOfoVadLCmlI8iD50nhFW0BeU+GregnE6bMKRQZaUB4nl6nAUvciMtroEQit6EvPEHvBfz26xP17myGg0lUo2mMi968qUdfPfr1qqcqJhY3fDJijobctjAcz6yn9QOfH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39840400004)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66574015)(6506007)(9686003)(83380400001)(53546011)(26005)(19627405001)(71200400001)(38100700002)(966005)(122000001)(7696005)(478600001)(55016003)(33656002)(66556008)(316002)(91956017)(66476007)(66946007)(66446008)(64756008)(8936002)(8676002)(110136005)(54906003)(76116006)(86362001)(41300700001)(38070700009)(5660300002)(30864003)(2906002)(4326008)(52536014)(166002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bh7CFJDRQbHfDjFzuw2CWsiS9qojKrO6cCxihcloHuA5B3Hpgmdj5W46Y+?=
 =?iso-8859-1?Q?AhibCQOFplZyWoVs/nrjbnNg+qux+MvzDzhYpvSaHWafnWto/KOKzXDSWL?=
 =?iso-8859-1?Q?AjDtnnl2vImY1AKI+c7kc7/sP41MbGcjVKxUjNzKDy9YG/rUAnqvbrPEkc?=
 =?iso-8859-1?Q?oJs1Sc8Y6I6XgcCfXpLkZWqjfR/tm339Mp4DONb729/8Md/HUa4fw4rUcw?=
 =?iso-8859-1?Q?7DK511ow7ExRd7gYJQjLrA0N3Ebvg+eVSw+xOkgMO9EMpgSElVU/juY/zL?=
 =?iso-8859-1?Q?hHsDjjDSsJqB1404RaO41KMXIsFTE1w3YYDGxIZLZZvWmjPtIDKvp+Gq66?=
 =?iso-8859-1?Q?5EBiZ0d2VMiI/5ltMrwdCvam0K59fIVUhSVJCXW2+E9GF3lEekbNAuTJJL?=
 =?iso-8859-1?Q?OzMDw02iV72vXnRjRhQMD3KHwzt0QVteIYRS3ZDwImkTSSFOGm9IJaKouf?=
 =?iso-8859-1?Q?ri9UhJ449E1ezmm4r0yHIH1T2ut+SttrOp8H7uEQdpyUrWwFQmsvRXpJRW?=
 =?iso-8859-1?Q?79y+QwojDnD8FAZXV5/YY2NeelK9CCyq4OS+WHWSpxmfdu7gOLEIuCTV3p?=
 =?iso-8859-1?Q?LSyTc2iAvDnLzuMX2GdoBWJJ+bxmPTRt2ZEhoRmQ5uQ+AxbAMK4cWhgP60?=
 =?iso-8859-1?Q?aMAUjE8slp0NTUn/BSzxUnuO/2Dy6rVng5N5vPXatx/C5+1ITvwkGWPhxZ?=
 =?iso-8859-1?Q?WC5zUAk7nUjiVC9RfiA6Vdg1n7uuUyhJ9W7ip279YLmDs+91lsLXdBZ1rD?=
 =?iso-8859-1?Q?UX11HRMbitSP+/DeyVqre5EjPd0z4gE+4wxdFysdZqCoJLVfAPu6Oi5kfm?=
 =?iso-8859-1?Q?9I1rVhG7uKRjNgsW5ROwbzYn04v99L91+pL8RL2HTTlhJTEr9oqbACtvLg?=
 =?iso-8859-1?Q?WA8iFBA3q1Uoia4M+x8r5J7JIPAZXlgiNuK1ZmmmA43qfa5a2aY708HtkL?=
 =?iso-8859-1?Q?98/w4NZuE++12GdNp3xkpfpecKiVd64UaXXQGwyX19oxXKRW7+xBrdmvaV?=
 =?iso-8859-1?Q?k3GU5CGKPmZE3Sn3eehaIEZef817mSslJCA/+QbCMSgfG2uuQc//OdR4ha?=
 =?iso-8859-1?Q?Ku1qla8MqEo4mt7me4iS8eQB2G6nomMqEd9wMMZXUj6N5FZcFIaR/nooBG?=
 =?iso-8859-1?Q?5LYi3jjoz3XXBjXji/RPjP+HkqzG0CJ0d8XSvJf45unAeT+0s1V4Q0BmRs?=
 =?iso-8859-1?Q?tkY2uil4YOHACC6oa7kQ8B8VD7MSaUwk8WPIJFNT7zWnOOyN9w/v31wxu5?=
 =?iso-8859-1?Q?p5wJLGsiuW0gOfTaapYNqYAjbFXtS8bWlO4QtaNkWoyttWFQvmW+LKAOAg?=
 =?iso-8859-1?Q?Gv6DI6pkk9RkMbxYok0D+O+M0NZfFwnDuxvnkwdxVXGGXaNlAjTdUvkZYI?=
 =?iso-8859-1?Q?NX6LzI7fDBciwXg6t0ASNvy7eCJv4Z4yQhsbNGJU0fDPZxBm/rvmVZNZ8Q?=
 =?iso-8859-1?Q?Vz06TfxUYEymh53TydFAvFB/YXNRl/S3nXrz3vbLkL27lkVH7Wk5O1ClHk?=
 =?iso-8859-1?Q?vZi/fdyABjFemaXOKCwCh6C+ShN102/pEuNK38NPMaIoJ9X5Ysvx1CHd86?=
 =?iso-8859-1?Q?Isp1fgQumRyU1ojvqH4uw1G1eQa2+107A9UIit7FsDUCbvpLCw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3698.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3406f2e0-e156-4198-4064-08dc0dbdfb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 07:14:39.9059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz6ZNUe5j/iiycAkrIinqpHbKIj6mH/LMJiYkwHGSrsfsYAQ5sG2H1Ay7wM3tmKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1595
X-Mailman-Approved-At: Fri, 05 Jan 2024 14:16:22 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Kever,

The dts is not yet part of the mainline kernel.

The evalboard iesy-rpx30-eva-mi.dts is the mainboard needed.

Greetings,
Dominik
________________________________
Von: Kever Yang <kever.yang@rock-chips.com>
Gesendet: Freitag, 5. Januar 2024 01:29
An: Dominik Poggel <pog@iesy.com>; u-boot@lists.denx.de <u-boot@lists.denx.=
de>
Cc: sjg@chromium.org <sjg@chromium.org>; philipp.tomsich@vrull.eu <philipp.=
tomsich@vrull.eu>
Betreff: Re: [PATCH] rockchip: px30: add support for iesy PX30 SoM OSM-S


Achtung! Diese Mail kommt von extern. Bitte besonders vorsichtig mit den In=
halten und den Anh=E4ngen umgehen.

Hi Dominik,

The main dts should come from kernel, does this board available in mainline=
 kernel?
If yes, pls add the info in commit message for which tag from kernel.

This is a SoM, then is there a mainboard needed to make it work?

Thanks,
- Kever
On 2024/1/4 23:57, Dominik Poggel wrote:
This adds support for the iesy SoM iesy-rpx30-osm-sf and the matching
evalboard iesy-rpx30-eva-mi.

The SoM complies to the Open Standard Module OSM 1.1 spec, size S-F

Signed-off-by: Dominik Poggel <pog@iesy.com><mailto:pog@iesy.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi    |  16 +
 arch/arm/dts/iesy-rpx30-eva-mi.dts            |  38 ++
 arch/arm/dts/iesy-rpx30-osm-sf.dtsi           | 369 ++++++++++++++++++
 arch/arm/mach-rockchip/px30/Kconfig           |   4 +
 board/iesy/iesy_rpx30_eva_mi/Kconfig          |  16 +
 board/iesy/iesy_rpx30_eva_mi/MAINTAINERS      |   6 +
 board/iesy/iesy_rpx30_eva_mi/Makefile         |   7 +
 .../iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c     |  93 +++++
 configs/iesy_rpx30_eva_mi_defconfig           | 126 ++++++
 include/configs/iesy_rpx30_eva_mi.h           |  42 ++
 11 files changed, 718 insertions(+)
 create mode 100644 arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi
 create mode 100644 arch/arm/dts/iesy-rpx30-eva-mi.dts
 create mode 100644 arch/arm/dts/iesy-rpx30-osm-sf.dtsi
 create mode 100644 board/iesy/iesy_rpx30_eva_mi/Kconfig
 create mode 100644 board/iesy/iesy_rpx30_eva_mi/MAINTAINERS
 create mode 100644 board/iesy/iesy_rpx30_eva_mi/Makefile
 create mode 100644 board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
 create mode 100644 configs/iesy_rpx30_eva_mi_defconfig
 create mode 100644 include/configs/iesy_rpx30_eva_mi.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 9d28a485be..8cf74855ff 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_MACH_S700) +=3D \
         s700-cubieboard7.dtb

 dtb-$(CONFIG_ROCKCHIP_PX30) +=3D \
+       iesy-rpx30-eva-mi.dtb \
         px30-evb.dtb \
         px30-firefly.dtb \
         px30-engicam-px30-core-ctouch2.dtb \
diff --git a/arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi b/arch/arm/dts/iesy=
-rpx30-eva-mi-u-boot.dtsi
new file mode 100644
index 0000000000..f7e8be72d1
--- /dev/null
+++ b/arch/arm/dts/iesy-rpx30-eva-mi-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * (C) Copyright 2024 iesy GmbH
+ */
+
+#include "px30-u-boot.dtsi"
+
+/ {
+       chosen {
+               u-boot,spl-boot-order =3D "same-as-spl";
+       };
+};
+
+&rng {
+       status =3D "okay";
+};
diff --git a/arch/arm/dts/iesy-rpx30-eva-mi.dts b/arch/arm/dts/iesy-rpx30-e=
va-mi.dts
new file mode 100644
index 0000000000..edd75c8b75
--- /dev/null
+++ b/arch/arm/dts/iesy-rpx30-eva-mi.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 iesy GmbH
+ */
+
+/dts-v1/;
+
+#include "iesy-rpx30-osm-sf.dtsi"
+
+/ {
+       model =3D "iesy RPX30 EVA-MI V2";
+       compatible =3D "rockchip,px30-evb", "rockchip,px30";
+
+       aliases {
+               mmc0 =3D &emmc;
+               mmc1 =3D &sdmmc;
+       };
+
+       chosen {
+               stdout-path =3D "serial2:115200n8";
+       };
+
+       emmc_pwrseq: emmc-pwrseq {
+               compatible =3D "mmc-pwrseq-emmc";
+               pinctrl-0 =3D <&emmc_reset>;
+               pinctrl-names =3D "default";
+               reset-gpios =3D <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+       };
+
+       vcc5v0_sys: vccsys {
+               compatible =3D "regulator-fixed";
+               regulator-name =3D "vcc5v0_sys";
+               regulator-always-on;
+               regulator-boot-on;
+               regulator-min-microvolt =3D <5000000>;
+               regulator-max-microvolt =3D <5000000>;
+       };
+};
diff --git a/arch/arm/dts/iesy-rpx30-osm-sf.dtsi b/arch/arm/dts/iesy-rpx30-=
osm-sf.dtsi
new file mode 100644
index 0000000000..65a7c77e9e
--- /dev/null
+++ b/arch/arm/dts/iesy-rpx30-osm-sf.dtsi
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 iesy GmbH
+ */
+
+#include "px30.dtsi"
+
+/{
+       aliases {
+               mmc0 =3D &emmc;
+               mmc1 =3D &sdcard;
+       };
+};
+
+&cpu0 {
+       cpu-supply =3D <&vdd_arm>;
+};
+
+&cpu1 {
+       cpu-supply =3D <&vdd_arm>;
+};
+
+&cpu2 {
+       cpu-supply =3D <&vdd_arm>;
+};
+
+&cpu3 {
+       cpu-supply =3D <&vdd_arm>;
+};
+
+&emmc {
+       cap-mmc-highspeed;
+       mmc-hs200-1_8v;
+       non-removable;
+       mmc-pwrseq =3D <&emmc_pwrseq>;
+       vmmc-supply =3D <&vcc_3v0>;
+       vqmmc-supply =3D <&vccio_flash>;
+       status =3D "okay";
+};
+
+&i2c0 {
+       status =3D "okay";
+
+       rk809: pmic@20 {
+               compatible =3D "rockchip,rk809";
+               reg =3D <0x20>;
+               interrupt-parent =3D <&gpio0>;
+               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
+               pinctrl-names =3D "default";
+               pinctrl-0 =3D <&pmic_int>;
+               rockchip,system-power-controller;
+               wakeup-source;
+               #clock-cells =3D <0>;
+               clock-output-names =3D "xin32k";
+               pmic-reset-func =3D <1>;
+
+               vcc1-supply =3D <&vcc5v0_sys>;
+               vcc2-supply =3D <&vcc5v0_sys>;
+               vcc3-supply =3D <&vcc5v0_sys>;
+               vcc4-supply =3D <&vcc5v0_sys>;
+               vcc5-supply =3D <&vcc3v3_sys>;
+               vcc6-supply =3D <&vcc3v3_sys>;
+               vcc7-supply =3D <&vcc3v3_sys>;
+               vcc8-supply =3D <&vcc3v3_sys>;
+               vcc9-supply =3D <&vcc5v0_sys>;
+
+               regulators {
+                       vdd_log: DCDC_REG1 {
+                               regulator-name =3D "vdd_log";
+                               regulator-min-microvolt =3D <950000>;
+                               regulator-max-microvolt =3D <1350000>;
+                               regulator-ramp-delay =3D <6001>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <95=
0000>;
+                               };
+                       };
+
+                       vdd_arm: DCDC_REG2 {
+                               regulator-name =3D "vdd_arm";
+                               regulator-min-microvolt =3D <950000>;
+                               regulator-max-microvolt =3D <1350000>;
+                               regulator-ramp-delay =3D <6001>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-off-in-suspend;
+                                       regulator-suspend-microvolt =3D <95=
0000>;
+                               };
+                       };
+
+                       vcc_ddr: DCDC_REG3 {
+                               regulator-name =3D "vcc_ddr";
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                               };
+                       };
+
+                       vcc_3v0: vcc_rmii: DCDC_REG4 {
+                               regulator-name =3D "vcc_3v0";
+                               regulator-min-microvolt =3D <3000000>;
+                               regulator-max-microvolt =3D <3000000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <30=
00000>;
+                               };
+                       };
+
+                       vcc3v3_sys: DCDC_REG5 {
+                               regulator-name =3D "vcc3v3_sys";
+                               regulator-min-microvolt =3D <3300000>;
+                               regulator-max-microvolt =3D <3300000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <33=
00000>;
+                               };
+                       };
+
+                       vcc_1v0: LDO_REG1 {
+                               regulator-name =3D "vcc_1v0";
+                               regulator-min-microvolt =3D <1000000>;
+                               regulator-max-microvolt =3D <1000000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <10=
00000>;
+                               };
+                       };
+
+                       vcc_1v8: vccio_flash: vccio_sdio: LDO_REG2 {
+                               regulator-name =3D "vcc_1v8";
+                               regulator-min-microvolt =3D <1800000>;
+                               regulator-max-microvolt =3D <1800000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <18=
00000>;
+                               };
+                       };
+
+                       vdd_1v0: LDO_REG3 {
+                               regulator-name =3D "vdd_1v0";
+                               regulator-min-microvolt =3D <1000000>;
+                               regulator-max-microvolt =3D <1000000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <10=
00000>;
+                               };
+                       };
+
+                       vcc3v0_pmu: LDO_REG4 {
+                               regulator-name =3D "vcc3v0_pmu";
+                               regulator-min-microvolt =3D <3000000>;
+                               regulator-max-microvolt =3D <3000000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <30=
00000>;
+                               };
+                       };
+
+                       vccio_sd: LDO_REG5 {
+                               regulator-name =3D "vccio_sd";
+                               regulator-min-microvolt =3D <1800000>;
+                               regulator-max-microvolt =3D <3300000>;
+                               regulator-always-on;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <33=
00000>;
+                               };
+                       };
+
+                       vcc_sd: LDO_REG6 {
+                               regulator-name =3D "vcc_sd";
+                               regulator-min-microvolt =3D <3300000>;
+                               regulator-max-microvolt =3D <3300000>;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <33=
00000>;
+                               };
+                       };
+
+                       vcc2v8_dvp: LDO_REG7 {
+                               regulator-name =3D "vcc2v8_dvp";
+                               regulator-min-microvolt =3D <2800000>;
+                               regulator-max-microvolt =3D <2800000>;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-off-in-suspend;
+                                       regulator-suspend-microvolt =3D <28=
00000>;
+                               };
+                       };
+
+                       vcc1v8_dvp: LDO_REG8 {
+                               regulator-name =3D "vcc1v8_dvp";
+                               regulator-min-microvolt =3D <1800000>;
+                               regulator-max-microvolt =3D <1800000>;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-on-in-suspend;
+                                       regulator-suspend-microvolt =3D <18=
00000>;
+                               };
+                       };
+
+                       vcc1v5_dvp: LDO_REG9 {
+                               regulator-name =3D "vcc1v5_dvp";
+                               regulator-min-microvolt =3D <1500000>;
+                               regulator-max-microvolt =3D <1500000>;
+                               regulator-boot-on;
+
+                               regulator-state-mem {
+                                       regulator-off-in-suspend;
+                                       regulator-suspend-microvolt =3D <15=
00000>;
+                               };
+                       };
+
+                       vcc3v3_lcd: SWITCH_REG1 {
+                               regulator-name =3D "vcc3v3_lcd";
+                               regulator-boot-on;
+                       };
+
+                       vcc5v0_host: SWITCH_REG2 {
+                               regulator-name =3D "vcc5v0_host";
+                               regulator-always-on;
+                               regulator-boot-on;
+                       };
+               };
+       };
+};
+
+&io_domains {
+       status =3D "okay";
+
+       vccio1-supply =3D <&vccio_sdio>;
+       vccio2-supply =3D <&vccio_sd>;
+       vccio3-supply =3D <&vcc_3v0>;
+       vccio4-supply =3D <&vcc3v0_pmu>;
+       vccio5-supply =3D <&vcc_3v0>;
+       vccio6-supply =3D <&vccio_flash>;
+};
+
+&pinctrl {
+       emmc {
+               emmc_reset: emmc-reset {
+                       rockchip,pins =3D <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull=
_none>;
+               };
+       };
+
+       pmic {
+               pmic_int: pmic_int {
+                       rockchip,pins =3D
+                               <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+               };
+
+               soc_slppin_gpio: soc_slppin_gpio {
+                       rockchip,pins =3D
+                               <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
+               };
+
+               soc_slppin_slp: soc_slppin_slp {
+                       rockchip,pins =3D
+                               <0 RK_PA4 1 &pcfg_pull_none>;
+               };
+
+               soc_slppin_rst: soc_slppin_rst {
+                       rockchip,pins =3D
+                               <0 RK_PA4 2 &pcfg_pull_none>;
+               };
+       };
+};
+
+&pmu_io_domains {
+       status =3D "okay";
+
+       pmuio1-supply =3D <&vcc3v0_pmu>;
+       pmuio2-supply =3D <&vcc3v0_pmu>;
+};
+
+&saradc {
+       vref-supply =3D <&vcc_1v8>;
+       status =3D "okay";
+};
+
+&sdmmc {
+       cap-mmc-highspeed;
+       cap-sd-highspeed;
+       card-detect-delay =3D <800>;
+       sd-uhs-sdr12;
+       sd-uhs-sdr25;
+       sd-uhs-sdr50;
+       sd-uhs-sdr104;
+       vmmc-supply =3D <&vcc_sd>;
+       vqmmc-supply =3D <&vccio_sd>;
+       status =3D "okay";
+};
+
+&tsadc {
+       rockchip,hw-tshut-mode =3D <1>;
+       rockchip,hw-tshut-polarity =3D <1>;
+       status =3D "okay";
+};
+
+&u2phy {
+       status =3D "okay";
+
+       u2phy_host: host-port {
+               status =3D "okay";
+       };
+
+       u2phy_otg: otg-port {
+               status =3D "okay";
+       };
+};
+
+&uart1 {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&uart1_xfer &uart1_cts>;
+       status =3D "okay";
+};
+
+&uart2 {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&uart2m1_xfer>;
+       status =3D "okay";
+};
+
+&uart5 {
+       status =3D "okay";
+};
+
+&usb20_otg {
+       status =3D "okay";
+};
+
+&usb_host0_ehci {
+       status =3D "okay";
+};
+
+&usb_host0_ohci {
+       status =3D "okay";
+};
diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/p=
x30/Kconfig
index 41893920cb..6958d6374f 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -59,6 +59,9 @@ config TARGET_RINGNECK_PX30
             * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
             * on-module NXP SE05x Secure Element

+config TARGET_IESY_RPX30_EVA_MI
+       bool "iesy RPX30 EVA MI"
+
 config ROCKCHIP_BOOT_MODE_REG
         default 0xff010200

@@ -94,6 +97,7 @@ config DEBUG_UART_CHANNEL

 source "board/engicam/px30_core/Kconfig"
 source "board/hardkernel/odroid_go2/Kconfig"
+source "board/iesy/iesy_rpx30_eva_mi/Kconfig"
 source "board/rockchip/evb_px30/Kconfig"
 source "board/theobroma-systems/ringneck_px30/Kconfig"

diff --git a/board/iesy/iesy_rpx30_eva_mi/Kconfig b/board/iesy/iesy_rpx30_e=
va_mi/Kconfig
new file mode 100644
index 0000000000..d1c157d6c8
--- /dev/null
+++ b/board/iesy/iesy_rpx30_eva_mi/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_IESY_RPX30_EVA_MI
+
+config SYS_BOARD
+       default "iesy_rpx30_eva_mi"
+
+config SYS_VENDOR
+       default "iesy"
+
+config SYS_CONFIG_NAME
+       default "iesy_rpx30_eva_mi"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+       def_bool y
+       select RAM_ROCKCHIP_LPDDR3
+
+endif
diff --git a/board/iesy/iesy_rpx30_eva_mi/MAINTAINERS b/board/iesy/iesy_rpx=
30_eva_mi/MAINTAINERS
new file mode 100644
index 0000000000..273668c898
--- /dev/null
+++ b/board/iesy/iesy_rpx30_eva_mi/MAINTAINERS
@@ -0,0 +1,6 @@
+iesy RPX30 EVA MI
+M:      Dominik Poggel <pog@iesy.com><mailto:pog@iesy.com>
+S:      Maintained
+F:      board/iesy/iesy_rpx30_eva_mi
+F:      include/configs/iesy_rpx30_eva_mi.h
+F:      configs/iesy_rpx30_eva_mi_defconfig
diff --git a/board/iesy/iesy_rpx30_eva_mi/Makefile b/board/iesy/iesy_rpx30_=
eva_mi/Makefile
new file mode 100644
index 0000000000..9ad1ba6307
--- /dev/null
+++ b/board/iesy/iesy_rpx30_eva_mi/Makefile
@@ -0,0 +1,7 @@
+#
+# (C) Copyright 2024 iesy GmbH
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y  +=3D iesy_rpx30_eva_mi.o
diff --git a/board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c b/board/iesy/=
iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
new file mode 100644
index 0000000000..d70a73d7d5
--- /dev/null
+++ b/board/iesy/iesy_rpx30_eva_mi/iesy_rpx30_eva_mi.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 iesy GmbH
+ */
+
+#include <command.h>
+#include <env.h>
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/boot_mode.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <dm/ofnode.h>
+#include <adc.h>
+
+#define KEY_DOWN_MIN_VAL       0
+#define KEY_DOWN_MAX_VAL       30
+
+int rockchip_dnl_key_pressed(void)
+{
+       unsigned int val;
+       struct udevice *dev;
+       struct uclass *uc;
+       int ret;
+
+       ret =3D uclass_get(UCLASS_ADC, &uc);
+       if (ret)
+               return false;
+
+       ret =3D -ENODEV;
+       uclass_foreach_dev(dev, uc) {
+               if (!strncmp(dev->name, "saradc", 6)) {
+                       ret =3D adc_channel_single_shot(dev->name, 2, &val)=
;
+                       break;
+               }
+       }
+
+       if (ret =3D=3D -ENODEV) {
+               pr_warn("%s: no saradc device found\n", __func__);
+               return false;
+       } else if (ret) {
+               pr_err("%s: adc_channel_single_shot fail!\n", __func__);
+               return false;
+       }
+
+       /*
+        * As the rockusb download mode doesn't work on the PX30,
+        * and the maskrom isn't working correctly when triggered
+        * by the download key, we use the fastboot mode instead.
+        * To prevent the rockchip code from setting the download
+        * mode, reset the board immediately.
+        *
+        * When the key is still pressed after the reset, the
+        * board will enter a loop of resetting and rebooting.
+        * Prevent this by checking the boot mode.
+        */
+
+       int boot_reg =3D readl(CONFIG_ROCKCHIP_BOOT_MODE_REG);
+
+       if (boot_reg =3D=3D BOOT_FASTBOOT) {
+               printf("fastboot mode already set, skipping download key ch=
eck...\n");
+               return false;
+       }
+
+       if (val >=3D KEY_DOWN_MIN_VAL && val <=3D KEY_DOWN_MAX_VAL) {
+               printf("download key pressed, entering fastboot mode...\n")=
;
+               writel(BOOT_FASTBOOT, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+               do_reset(NULL, 0, 0, NULL);
+       }
+
+       return false;
+}
+
+int misc_init_r(void)
+{
+       const char *boot_device =3D
+               ofnode_read_chosen_string("u-boot,spl-boot-device");
+       if (!boot_device) {
+               printf("boot device not set\n");
+               return 0;
+       }
+
+       if (!strcmp(boot_device, "/mmc@ff370000")) {
+               env_set("mmcdev", "0");
+               env_set("rootfs", "/dev/mmcblk0p2");
+       } else {
+               env_set("mmcdev", "1");
+               env_set("rootfs", "/dev/mmcblk1p2");
+       }
+
+       return 0;
+}
diff --git a/configs/iesy_rpx30_eva_mi_defconfig b/configs/iesy_rpx30_eva_m=
i_defconfig
new file mode 100644
index 0000000000..b380c64b12
--- /dev/null
+++ b/configs/iesy_rpx30_eva_mi_defconfig
@@ -0,0 +1,126 @@
+CONFIG_ARM=3Dy
+CONFIG_SKIP_LOWLEVEL_INIT=3Dy
+CONFIG_COUNTER_FREQUENCY=3D24000000
+CONFIG_ARCH_ROCKCHIP=3Dy
+CONFIG_TEXT_BASE=3D0x00200000
+CONFIG_SYS_MALLOC_F_LEN=3D0x2000
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x400000
+CONFIG_DEFAULT_DEVICE_TREE=3D"iesy-rpx30-eva-mi"
+CONFIG_SPL_TEXT_BASE=3D0x00000000
+CONFIG_DM_RESET=3Dy
+CONFIG_ROCKCHIP_PX30=3Dy
+CONFIG_TARGET_IESY_RPX30_EVA_MI=3Dy
+CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
+CONFIG_SPL_STACK_R_ADDR=3D0x600000
+CONFIG_SPL_STACK=3D0x400000
+CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x600
+CONFIG_DEBUG_UART_BASE=3D0xFF160000
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_DEBUG_UART_CHANNEL=3D1
+CONFIG_SYS_LOAD_ADDR=3D0x800800
+CONFIG_DEBUG_UART=3Dy
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=3Dy
+CONFIG_FIT_VERBOSE=3Dy
+CONFIG_SPL_LOAD_FIT=3Dy
+CONFIG_DEFAULT_FDT_FILE=3D"iesy-rpx30-eva-mi-v2.dtb"
+# CONFIG_CONSOLE_MUX is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
+CONFIG_MISC_INIT_R=3Dy
+CONFIG_BOARD_LATE_INIT=3Dy
+CONFIG_USE_PREBOOT=3Dy
+CONFIG_SPL_MAX_SIZE=3D0x20000
+CONFIG_SPL_PAD_TO=3D0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
+CONFIG_SPL_BSS_START_ADDR=3D0x4000000
+CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
+CONFIG_SPL_BOOTROM_SUPPORT=3Dy
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=3Dy
+CONFIG_SPL_ATF=3Dy
+# CONFIG_TPL_FRAMEWORK is not set
+# CONFIG_TPL_BANNER_PRINT is not set
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPT=3Dy
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_SLEEP is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_ISO_PARTITION is not set
+CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=3D64
+CONFIG_SPL_OF_CONTROL=3Dy
+CONFIG_OF_LIVE=3Dy
+CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names interrupt-parent ass=
igned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_REGMAP=3Dy
+CONFIG_SPL_REGMAP=3Dy
+CONFIG_SYSCON=3Dy
+CONFIG_SPL_SYSCON=3Dy
+CONFIG_CLK=3Dy
+CONFIG_SPL_CLK=3Dy
+CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
+CONFIG_FASTBOOT_BUF_SIZE=3D0x04000000
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=3Dy
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=3Dy
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
+CONFIG_ROCKCHIP_GPIO=3Dy
+CONFIG_SYS_I2C_ROCKCHIP=3Dy
+CONFIG_MISC=3Dy
+CONFIG_ROCKCHIP_OTP=3Dy
+CONFIG_SUPPORT_EMMC_RPMB=3Dy
+CONFIG_MMC_DW=3Dy
+CONFIG_MMC_DW_ROCKCHIP=3Dy
+CONFIG_PHY_REALTEK=3Dy
+CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
+CONFIG_ETH_DESIGNWARE=3Dy
+CONFIG_GMAC_ROCKCHIP=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_DM_PMIC=3Dy
+CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_REGULATOR_PWM=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_PWM_ROCKCHIP=3Dy
+CONFIG_RAM=3Dy
+CONFIG_SPL_RAM=3Dy
+CONFIG_TPL_RAM=3Dy
+CONFIG_ROCKCHIP_SDRAM_COMMON=3Dy
+CONFIG_DM_RNG=3Dy
+CONFIG_RNG_ROCKCHIP=3Dy
+# CONFIG_SPECIFY_CONSOLE_INDEX is not set
+CONFIG_DEBUG_UART_SHIFT=3D2
+CONFIG_SYS_NS16550_MEM32=3Dy
+CONFIG_SOUND=3Dy
+CONFIG_SYSRESET=3Dy
+CONFIG_DM_THERMAL=3Dy
+CONFIG_USB=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_GENERIC=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_DWC2_OTG=3Dy
+CONFIG_VIDEO=3Dy
+CONFIG_DISPLAY=3Dy
+CONFIG_SPL_TINY_MEMSET=3Dy
+CONFIG_TPL_TINY_MEMSET=3Dy
+CONFIG_LZO=3Dy
+CONFIG_ERRNO_STR=3Dy
+# CONFIG_EFI_LOADER is not set
diff --git a/include/configs/iesy_rpx30_eva_mi.h b/include/configs/iesy_rpx=
30_eva_mi.h
new file mode 100644
index 0000000000..084edc509f
--- /dev/null
+++ b/include/configs/iesy_rpx30_eva_mi.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2017 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __IESY_RPX30_EVA_MI_H
+#define __IESY_RPX30_EVA_MI_H
+
+#include "rockchip-common.h"
+
+#define CFG_IRAM_BASE          0xff0e0000
+
+#define GICD_BASE                      0xff131000
+#define GICC_BASE                      0xff132000
+
+#define CFG_SYS_SDRAM_BASE             0
+#define SDRAM_MAX_SIZE                 0xff000000
+
+#define ENV_MEM_LAYOUT_SETTINGS \
+       "scriptaddr=3D0x00500000\0" \
+       "pxefile_addr_r=3D0x00600000\0" \
+       "fdt_addr_r=3D0x08300000\0" \
+       "kernel_addr_r=3D0x00280000\0" \
+       "ramdisk_addr_r=3D0x0a200000\0" \
+       "kernel_comp_addr_r=3D0x03e80000\0" \
+       "kernel_comp_size=3D0x2000000\0"
+
+#define CFG_EXTRA_ENV_SETTINGS \
+       ENV_MEM_LAYOUT_SETTINGS \
+       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
+       "partitions=3D" PARTS_DEFAULT \
+       "mmcdev=3D1\0" \
+       "bootcmd=3Dfatload mmc ${mmcdev} ${kernel_addr_r} Image; " \
+               "fatload mmc ${mmcdev} ${fdt_addr_r} ${fdtfile}; " \
+               "run setbootargs; " \
+               "booti ${kernel_addr_r} - ${fdt_addr_r}\0" \
+       "earlycon=3Duart8250,mmio32,0xff160000\0" \
+       "console=3DttyFIQ0\0" \
+       "setbootargs=3Dsetenv bootargs ${console} ${optargs} " \
+               "root=3D${rootfs} rootwait rw earlycon=3D${earlycon}\0"
+
+#endif
--
2.30.2


---------------------------------------------------------------------------=
------------------------------------------

Immer gut informiert sein mit dem Product Development Blog (PDB)

Bleiben Sie stets gut informiert =FCber unsere Computermodule der OSM Baure=
ihe und erhalten Sie aktuelle Informationen aus unserer Entwicklungsabteilu=
ng.
F=FCr weitere Informationen, als auch der M=F6glichkeit zu Registrierung, n=
utzen Sie den nachfolgenden Link:
https://news.iesy.com/registrierung-product-development-blog-pdb-iesy-gmbh

Always be well informed with the Product Development Blog (PDB)
Stay well informed about our computer modules of the OSM series and get the=
 latest information from our development department.
For more information, as well as the possibility to register, please use th=
e following link:
https://news.iesy.com/en/registration-product-development-blog-pdb-iesy-gmb=
h

---------------------------------------------------------------------------=
------------------------------------------

Die in dieser E-Mail enthaltenen Informationen sind vertraulich und ledigli=
ch f=FCr den Empf=E4nger bestimmt.
Sollten Sie nicht der eigentliche Empf=E4nger sein, informieren Sie uns bit=
te umgehend und l=F6schen diese E-Mail.

The information contained in this message is confidential and is intended f=
or the addressee only.
If you are not the intended recipient, please inform us immediately and del=
ete this email.
