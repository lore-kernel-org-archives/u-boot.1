Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8ECC43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D2B846FD;
	Mon,  6 Jul 2026 17:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2tBhy/7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E618490A; Mon,  6 Jul 2026 17:37:48 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57B1846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6E6DD4E40CBD;
 Mon,  6 Jul 2026 15:37:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3B6BA601A2;
 Mon,  6 Jul 2026 15:37:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 334E311BB823C; 
 Mon,  6 Jul 2026 17:37:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783352264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rNAf2n08UCBLCURxO2CL31A1eeb2hSeJ1NVHxjD1f/Y=;
 b=2tBhy/7KrhYrDOBAid2+66Ce8bGAmmxc4Xlu/dZUarp03zjkqisYvl1ue6DhegbNGTmLWF
 0d7QrXR6EZyJFb3eQq8XSECWx18QVRfHtgqQNxOgpXCvwQJX516be/L+GyDw8hd2oj0iXC
 c04jCaC2CP8v1dHjSqhKiUjkuHFo9Kn1e1xfxZY5nnUhvCZTLT5QwcVDymxteoGO56HHNE
 eWAfktwArWqU99eGsuHKpF+pPlBIOpcEGJdZa50I4u2yBsDORL0M8HqnlGGrdG1XGzOVlQ
 Pw5rJj7GR81RMcuNzDeirsEd7Hc2pzoaKOVmAN1cA/Wcz4Gak4jVrtPpA8vYaA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 17:37:41 +0200
Message-Id: <DJRLM6VVKL2V.3F398IK0CLQRC@bootlin.com>
Subject: Re: [PATCH] imx93_frdm: Add OP-TEE device tree node
Cc: "Peter Robinson" <pbrobinson@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, <u-boot@lists.denx.de>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Peng Fan" <peng.fan@nxp.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-master-v1-1-25bae88d130a@bootlin.com>
 <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
 <DJRKOYKA0DDQ.PI5Q86TGLP22@bootlin.com>
 <20260706145906.GW749385@bill-the-cat>
In-Reply-To: <20260706145906.GW749385@bill-the-cat>
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

On Mon Jul 6, 2026 at 4:59 PM CEST, Tom Rini wrote:
> On Mon, Jul 06, 2026 at 04:54:17PM +0200, Mathieu Dubois-Briand wrote:
>> Hi,
>>=20
>> On Mon Jul 6, 2026 at 4:14 PM CEST, Peter Robinson wrote:
>> > On Mon, 6 Jul 2026 at 13:34, Mathieu Dubois-Briand
>> > <mathieu.dubois-briand@bootlin.com> wrote:
>> >>
>> >> Add missing firmware/optee node, so is can be both used and copied in=
to
>> >> Linux device tree by optee_copy_firmware_node(). This is consistent w=
ith
>> >> other i.MX93 boards.
>> >
>> > Shouldn't this be going to the upstream Linux DT at which point get it
>> > when we resync?
>>=20
>> I don't think it should. Or maybe it should, but then we are doing wrong
>> things for other boards, particularly for the i.MX family.
>>=20
>> We have this node in the -u-boot.dtsi file for various other boards:
>>=20
>> git grep "linaro,optee-tz" -- '*-u-boot.dtsi'
>> arch/arm/dts/imx8mm-u-boot.dtsi:                        compatible =3D "=
linaro,optee-tz";
>> arch/arm/dts/imx8mn-u-boot.dtsi:                        compatible =3D "=
linaro,optee-tz";
>> arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi:                  compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/imx8mp-navqp-u-boot.dtsi:                  compatible =3D "=
linaro,optee-tz";
>> arch/arm/dts/imx8mp-u-boot.dtsi:                        compatible =3D "=
linaro,optee-tz";
>> arch/arm/dts/imx91-11x11-evk-u-boot.dtsi:                       compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi:                      compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi:                =
        compatible =3D "linaro,optee-tz";
>> arch/arm/dts/imx93-11x11-evk-u-boot.dtsi:                       compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi:                      compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi:                 compatible =3D "=
linaro,optee-tz";
>> arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi:                        =
compatible =3D "linaro,optee-tz";
>> arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi:                        =
compatible =3D "linaro,optee-tz";
>> arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi:                       compatib=
le =3D "linaro,optee-tz";
>> arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi:                       compatib=
le =3D "linaro,optee-tz";
>
> Since I assume this would still pass validation in the Linux kernel,
> yes, it looks like a lot of platforms are doing it wrong here and should
> be pushing this upstream. Thanks.

Ok, so I suspect I should instead submit a similar patch against the
Kernel.

Should I try to add something similar for other i.MX boards and stm32
boards at the same time? So they could later be removed from u-boot.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

