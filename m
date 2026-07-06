Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5718C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 14:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC9A846FD;
	Mon,  6 Jul 2026 16:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CyfTaW0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D2C848D2; Mon,  6 Jul 2026 16:54:22 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5F0846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 56035C8EC79;
 Mon,  6 Jul 2026 14:54:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 33522601A2;
 Mon,  6 Jul 2026 14:54:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3C0B11BBA648; 
 Mon,  6 Jul 2026 16:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783349659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bhbm8tcAHrtEq3miY1teVQJvWTqX3NJCuVtBqehgfhs=;
 b=CyfTaW0morDuuU6LXRmWIH8rYM8Odvdb0Q2fSnzP4F83EM4Znwn6cQuaetmLy7I4IRs7Tm
 VSZOT97yQ6vNzJzH889TwG0QiBKAH4VXGXoAm3V+5oKXE1u6ETQjIcqXFKZHYvxvkzWtiq
 PuzrzBblDlAI2y6MHAaLdKVdIJzBj+dgDI523S06/jZkse+YSMfgQCpugDioNk7zlCuvUD
 0891c9+vyjAwQZpd1yNomdUan8TrFQW2BsMUp/Vik3BC75VR/NhQ8gMn7stVhn//tuyttS
 ccn8FCnbkhzetLH+FLZ7/95AupSx002ih3bjk2G9MRaMYqis40tGonZIHUpFrw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 16:54:17 +0200
Message-Id: <DJRKOYKA0DDQ.PI5Q86TGLP22@bootlin.com>
Subject: Re: [PATCH] imx93_frdm: Add OP-TEE device tree node
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, <u-boot@lists.denx.de>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Stefano Babic"
 <sbabic@nabladev.com>, "Fabio Estevam" <festevam@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Peng Fan" <peng.fan@nxp.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Peter Robinson" <pbrobinson@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-master-v1-1-25bae88d130a@bootlin.com>
 <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
In-Reply-To: <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
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

Hi,

On Mon Jul 6, 2026 at 4:14 PM CEST, Peter Robinson wrote:
> On Mon, 6 Jul 2026 at 13:34, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>>
>> Add missing firmware/optee node, so is can be both used and copied into
>> Linux device tree by optee_copy_firmware_node(). This is consistent with
>> other i.MX93 boards.
>
> Shouldn't this be going to the upstream Linux DT at which point get it
> when we resync?

I don't think it should. Or maybe it should, but then we are doing wrong
things for other boards, particularly for the i.MX family.

We have this node in the -u-boot.dtsi file for various other boards:

git grep "linaro,optee-tz" -- '*-u-boot.dtsi'
arch/arm/dts/imx8mm-u-boot.dtsi:                        compatible =3D "lin=
aro,optee-tz";
arch/arm/dts/imx8mn-u-boot.dtsi:                        compatible =3D "lin=
aro,optee-tz";
arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi:                  compatible =
=3D "linaro,optee-tz";
arch/arm/dts/imx8mp-navqp-u-boot.dtsi:                  compatible =3D "lin=
aro,optee-tz";
arch/arm/dts/imx8mp-u-boot.dtsi:                        compatible =3D "lin=
aro,optee-tz";
arch/arm/dts/imx91-11x11-evk-u-boot.dtsi:                       compatible =
=3D "linaro,optee-tz";
arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi:                      compatible =
=3D "linaro,optee-tz";
arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi:                   =
     compatible =3D "linaro,optee-tz";
arch/arm/dts/imx93-11x11-evk-u-boot.dtsi:                       compatible =
=3D "linaro,optee-tz";
arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi:                      compatible =
=3D "linaro,optee-tz";
arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi:                 compatible =3D "lin=
aro,optee-tz";
arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi:                        com=
patible =3D "linaro,optee-tz";
arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi:                        com=
patible =3D "linaro,optee-tz";
arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi:                       compatible =
=3D "linaro,optee-tz";
arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi:                       compatible =
=3D "linaro,optee-tz";

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

