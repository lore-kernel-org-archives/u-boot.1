Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E99F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D01A84118;
	Sat, 11 Apr 2026 15:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eMrVty4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE2F84154; Sat, 11 Apr 2026 15:49:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC0183DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775915347; x=1776520147; i=xypron.glpk@gmx.de;
 bh=3qjhu8FWSblztYM6Q/KGrJt8H9HWH+qCjnD+O1mH7+Q=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eMrVty4XFDG7sgQWWMmCWnXsKCZN2JF3RjXv7OR09fcqRqJmGdWVBO73934Bfcc5
 M06FC68mEPDolUHt1jZuovM0LHp84JdbOD4CgATyVJZNvTMYDIl0tuRFa71Bx4c5/
 OaAl0PKNG4AEM60JsKzTAE/Rsec5fL7s0vrwRWP2LjB+sSmORRuaAWF0fQpjY53bK
 h0SoQ4WGtjoT0k22RKAWxy28q8aZRRFAo95a2ihqsmWQyZ2cPpMiCkq60PU0WkyZ9
 J8kWptUrdyJZg7ZwLpQRyHEHBWBk16pXThOM14PbQK8stiZEGz5r6w6Vn01PL/NRI
 2bZnYKgUzJIaYgh8Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1vJkCd1gsO-00yMbC; Sat, 11
 Apr 2026 15:49:07 +0200
Date: Sat, 11 Apr 2026 15:49:00 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_6/6=5D_doc=3A_dtbinding=3A_Update?=
 =?US-ASCII?Q?_documentation_for_Generic_Firmware_loader?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260409133303.31875-7-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-7-ansuelsmth@gmail.com>
Message-ID: <701C0616-EBF4-48D2-9356-953589B0DEA8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9o0HmzEbodp30rRaGBjUN7XgU0FuO8UKMDcmN0znGd9HU8JDZZz
 EXVTJCErvQgLL3spySiEuupkbIcqynHJQ4zq/lMFL3p8ERR51DdgM95SudGwEbjpiyrCHnb
 lq/JEskaidz882djIzFArJXNezgzyy6qLbvM9VJ1yls7Zvv2mwGAsatRgXli2ngJfNr5c6a
 idSB4FRbluzynA/xWi5Xw==
UI-OutboundReport: notjunk:1;M01:P0:NHNWsPnRP4k=;RS3xV5fz2wXMUjR2Px5GGXvyXXV
 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
 LBxC5aWtVCZF1+U9Uar3Ew42TKygT2ONtwlo=
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

Am 9=2E April 2026 15:33:02 MESZ schrieb Christian Marangi <ansuelsmth@gmai=
l=2Ecom>:
>Update documentation for Generic Firmware loader, generalize it from FS
>specific and add new property and example for FIP loader=2E
>
>Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
>property=2E

The sevice-tree documents should be integrated into the generated html doc=
umentation=2E

Shouldn't we use the same yaml schema format as the kernel to enable autom=
ated CI tests?

Best regards

Heinrich


>
>Signed-off-by: Christian Marangi <ansuelsmth@gmail=2Ecom>
>---
> =2E=2E=2E/misc/{fs_loader=2Etxt =3D> fw_loader=2Etxt}     | 29 +++++++++=
++++++++--
> 1 file changed, 26 insertions(+), 3 deletions(-)
> rename doc/device-tree-bindings/misc/{fs_loader=2Etxt =3D> fw_loader=2Et=
xt} (60%)
>
>diff --git a/doc/device-tree-bindings/misc/fs_loader=2Etxt b/doc/device-t=
ree-bindings/misc/fw_loader=2Etxt
>similarity index 60%
>rename from doc/device-tree-bindings/misc/fs_loader=2Etxt
>rename to doc/device-tree-bindings/misc/fw_loader=2Etxt
>index 542be4b25a0a=2E=2E9b00b2c887c0 100644
>--- a/doc/device-tree-bindings/misc/fs_loader=2Etxt
>+++ b/doc/device-tree-bindings/misc/fw_loader=2Etxt
>@@ -1,17 +1,23 @@
>-* File system firmware loader
>+* Generic Firmware loader
>=20
> Required properties:
> --------------------
>=20
>-- compatible: should contain "u-boot,fs-loader"
>+- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
> - phandlepart: which block storage device and partition the image loadin=
g from,
> 	       this property is required for mmc, usb and sata=2E This is unsig=
ned
> 	       32-bit array=2E For example phandlepart=3D<&mmc_0 1>, meaning us=
e
> 	       that MMC0 node pointer, partition 1=2E
>-- mdtpart: which partition of ubi the image loading from, this property =
is
>+- mtdpart: which partition of ubi the image loading from, this property =
is
> 	   required for ubi and mounting=2E
> - ubivol: which volume of ubi the image loading from, this property is r=
equired
> 	  for ubi and mounting=2E
>+- partoffset: valid ONLY for "u-boot,fip-loader"=2E Offset of the partit=
ion to
>+	      parse the FIP partition from=2E
>+
>+Either 'phandlepart' or 'mtdpart' can be used=2E For Block device, 'phan=
dlepart'
>+should be used and for MTD device, 'mtdpart' should be used=2E With UBI =
device,
>+in addition to 'mtdpart' also 'ubivol' is required=2E
>=20
> Example of storage device and partition search set for mmc, usb, sata an=
d
> ubi in device tree source as shown in below:
>@@ -46,3 +52,20 @@ ubi in device tree source as shown in below:
> 		mtdpart =3D "UBI",
> 		ubivol =3D "ubi0";
> 	};
>+
>+	Example for FIP from eMMC:
>+	fs_loader4: fip-loader@4 {
>+		bootph-all;
>+		compatible =3D "u-boot,fip-loader";
>+		phandlepart =3D <&mmc0 0>;
>+		partoffset =3D <0x100>;
>+	};
>+
>+	Example for FIP from ubi:
>+	fs_loader4: fip-loader@4 {
>+		bootph-all;
>+		compatible =3D "u-boot,fip-loader";
>+		mtdpart =3D "ubi",
>+		ubivol =3D "bl31";
>+	};
>+

