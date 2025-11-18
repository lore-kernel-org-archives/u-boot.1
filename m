Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405DCCED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4CFB83C5E;
	Tue, 18 Nov 2025 15:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="j9pCJwPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFF583CB1; Tue, 18 Nov 2025 15:15:01 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D92883B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id ECECB4E41762;
 Tue, 18 Nov 2025 14:14:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B340E606FE;
 Tue, 18 Nov 2025 14:14:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B29110371E13; Tue, 18 Nov 2025 15:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763475296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LcGuxy4WeFnye5/l62unRBw3yMtHVGxo383X1Dbc7+0=;
 b=j9pCJwPmnatCSeESh+0qV59ahWFmRgbYYv+sNjJ1FvvVDesyXjVrC3oaV/JZ3xEeeBXhWe
 Jy0pe7zuhjIbrwvhybyXNjoVoVr/rN3EwuGwPjfT7hWOWSrMQSg3ijdyQlsb+RXlebuiuB
 xPF8BY91BuKv4Mu+Ls73AbpuC03ZPU3BSXFCcu1S1r9FB0GlG78v8Om+OVQZwYtoVKKyqD
 HWewPB2mBTjdIcYTvqNcQqoynVjGKAwhp/829gVc2GIwnpi7DdfL+qccjZeVidtIEVBYJz
 T7v68D8gw9q5YozPsu7ZCsDpZ/rbcYkCiD8lDRcniIVmX+K0FCY3gmaJR/8F/A==
Date: Tue, 18 Nov 2025 15:14:44 +0100
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
Subject: Re: [PATCH 02/15] arm: dts: am335x-evm: Add backlight to the panel
Message-ID: <20251118151444.0634411b@kmaincent-XPS-13-7390>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-2-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-2-91ce13c661e2@baylibre.com>
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

On Tue, 18 Nov 2025 11:40:22 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Add backlight phandle reference to panel node. Without this reference,
> the display driver cannot control backlight, leaving the panel dark.

What is the point of modifying this devicetree as it will be replaced by the
Linux upstream devicetree at the last patch of your series?

> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/dts/am335x-evm.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
> index
> 1b5b627006822a9bb4df1c6433ce7eff114dc029..52ca4ff6809ad24fafbdd515fbcde84=
0715cf20f
> 100644 --- a/arch/arm/dts/am335x-evm.dts +++ b/arch/arm/dts/am335x-evm.dts
> @@ -94,7 +94,7 @@
>  		};
>  	};
> =20
> -	backlight {
> +	pwm_backlight: backlight {
>  		compatible =3D "pwm-backlight";
>  		pwms =3D <&ecap0 0 50000 0>;
>  		brightness-levels =3D <0 51 53 56 62 75 101 152 255>;
> @@ -106,6 +106,7 @@
>  		status =3D "okay";
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&lcd_pins_s0>;
> +		backlight =3D <&pwm_backlight>;
>  		panel-info {
>  			ac-bias           =3D <255>;
>  			ac-bias-intrpt    =3D <0>;
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
