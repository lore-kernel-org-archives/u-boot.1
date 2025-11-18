Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E91CED60F
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 11:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585E583CD2;
	Tue, 18 Nov 2025 12:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="efv1ywCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD1F83D07; Tue, 18 Nov 2025 12:04:12 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB43283CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 170ADC12670;
 Tue, 18 Nov 2025 11:03:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2A77E606FE;
 Tue, 18 Nov 2025 11:04:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B86410371D7F; Tue, 18 Nov 2025 12:03:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763463848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SW0+20rDekGvO2eSdt29pCdLqobRiqO84QeADaCC7nc=;
 b=efv1ywCrU+lgBBsBtfL1BwkG8wIxnXyssrpK54sg9wwYW5pnybDZkb0jFt1MMoQhK8OxAt
 2QalnrbMZWQcVGpeh+Z1OQ8QttuA7E1KdeDxUCtpgPjSCQSTVKTJ810c5HUNKhnjOO30yg
 eaa95RQ/oTazYoCcexWy7V0BwjKQW6T7dBb3GTS1hBL162sq5+iE3Pt0SaktBEIW2SseQY
 bDrHuc8fqzb+Rfn7QfDvz4ITpgIcmJuC5EyLDQtiYf0x1VFpi5a7PUIMAnjfpTrPhYUBMY
 axohjQDo0HCI3cCCpaiZ704dOhjcj5Ri8vpb03+wkE8wjnHONsLVAhFF70ZL2A==
Date: Tue, 18 Nov 2025 12:03:56 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Rayagonda
 Kokatanur <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Casey Connolly
 <casey.connolly@linaro.org>, Tingting Meng <tingting.meng@altera.com>, Peng
 Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Liya Huang <1425075683@qq.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 15/15] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
Message-ID: <20251118120356.15234bba@kmaincent-XPS-13-7390>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-15-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-15-91ce13c661e2@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 18 Nov 2025 11:40:35 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
> power domain driver is requierd as well now.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  configs/am335x_evm_defconfig | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index
> bd188c252780fb541afbbe61a243bddaab79be93..994be4307b81d25a4a8ade4d25feb44=
651cd43ee
> 100644 --- a/configs/am335x_evm_defconfig +++ b/configs/am335x_evm_defcon=
fig
> @@ -3,7 +3,11 @@ CONFIG_ARCH_CPU_INIT=3Dy
>  CONFIG_ARCH_OMAP2PLUS=3Dy
>  CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
>  CONFIG_SF_DEFAULT_SPEED=3D24000000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"am335x-evm"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am335x-evm"
> +CONFIG_OF_UPSTREAM=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_TI_OMAP_PRM_POWER_DOMAIN=3Dy
> +CONFIG_SIMPLE_PM_BUS=3Dy
>  CONFIG_AM33XX=3Dy
>  CONFIG_CLOCK_SYNTHESIZER=3Dy
>  CONFIG_AM335X_USB0=3Dy
> @@ -50,7 +54,6 @@ CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dnand.0"
>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dnand.0:128k(NAND.SPL),128k(NAND.SP=
L.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-s=
pl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),=
8m(NAND.kernel),-(NAND.file-system)"
>  # CONFIG_SPL_EFI_PARTITION is not set
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"am335x-evm am335x-bone am335x-sancloud-bbe
> am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-bonebla=
ck
> am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle
> am335x-bonegreen-eco" CONFIG_ENV_OVERWRITE=3Dy CONFIG_ENV_RELOC_GD_ENV_AD=
DR=3Dy

Why did you remove the OF_LIST? Without it the am335x_evm_defconfig won't w=
ork
anymore for these boards causing a regression.
I don't know if OF_LIST works with OF_UPSTREAM, maybe you will have to use
OF_UPSTREAM_BUILD_VENDOR instead.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
