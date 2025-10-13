Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D13CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 12:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A518363D;
	Mon, 13 Oct 2025 14:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Tj15SMNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2752F83768; Mon, 13 Oct 2025 14:45:52 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C269B82B20
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 14:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 305281A1344;
 Mon, 13 Oct 2025 12:45:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EF8BA606C6;
 Mon, 13 Oct 2025 12:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E5A67102F224D; 
 Mon, 13 Oct 2025 14:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760359548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wWLQRvzCCSGPQkj0nVzbt9T6mziXv/6FRh6UmPSp9yE=;
 b=Tj15SMNwG08wpbYH3i9FZAOS75ifsHHksxCOW5hUkf54otdH9gczxbu5CPvpbkl7J/diXV
 LciEQ4YwGMrsO8MC65jJOr+LBkFqZAFifph+Dw1GGlgNPjpi77ZtRiloCIV09xdoKvGOYu
 9EQDxFbp4KHmtGF8LD3+KW+l3XPzbC0ltIJYzSo4j/FciYJqQOPE4CCeJBvorMVAtln802
 ub6up7gYXxcTg/ljDcIUSU9q7oMOB4Sl5Ub8nCNFxCsGryv+NlE+1yvNlK9QLNkr9Wp/+C
 x5hv8vW5Q/Ovd/AL9ks/Ahh8CRg/Q8Msny4pfuD19Ypl2BHf2Ix2U6OKxHuoeQ==
Date: Mon, 13 Oct 2025 14:45:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
Message-ID: <20251013144532.381e4ad5@kmaincent-XPS-13-7390>
In-Reply-To: <CAFLszTjLmq0r9uTYR-irzzSN63G1Lpd0iWiwW9npLSraNB1Y_g@mail.gmail.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
 <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
 <20251010153500.5bec4e20@kmaincent-XPS-13-7390>
 <CAFLszTjLmq0r9uTYR-irzzSN63G1Lpd0iWiwW9npLSraNB1Y_g@mail.gmail.com>
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

On Sat, 11 Oct 2025 08:20:58 +0100
Simon Glass <sjg@chromium.org> wrote:

> Hi Kory,
>=20
> On Fri, 10 Oct 2025 at 14:35, Kory Maincent <kory.maincent@bootlin.com> w=
rote:
> >
> > On Fri, 10 Oct 2025 12:13:11 +0100
> > Simon Glass <sjg@chromium.org> wrote:

...

> > > > +/**
> > > > + * dm_extension_apply - Apply extension board overlay to the devic=
etree
> > > > + * @extension_num: Extension number to be applied
> > > > + * Return: Zero on success, negative on failure.
> > > > + */
> > > > +int dm_extension_apply(int extension_num); =20
> > >
> > > The uclass should have a method like apply(struct uclass *dev, int
> > > extension_num). Is the numbering global across all devices? =20
> >
> > We currently support only one extension driver loaded at a time, theref=
ore
> > we don't currently need this uclass parameter.
> > We will change the API when we will have several scan method possible a=
t the
> > same time but I can't test it for now. I don't think we will have such =
cases
> > soon and maybe the devicetree WIP support will be ok at that time. =20
>=20
> OK, I hadn't picked that up but it makes sense. We can always change
> it later, as you say. But I would like to see an apply() method in
> extension_ops, so that it actually looks like a driver.

Are you sure adding an apply ops method make sense? It is not something dri=
ver
or board specific. Do you want to have an apply driver ops set to the same
generic apply function for all drivers?=20

Ok for the rest.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
