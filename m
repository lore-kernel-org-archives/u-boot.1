Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC060C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F4F87F52;
	Thu, 16 May 2024 11:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Fc6V4sGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5828E88011; Thu, 16 May 2024 11:34:18 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E406787ED1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAC5AFF80F;
 Thu, 16 May 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1715852055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSJzaL7faKWKDdpW60iAXnBRDAbe8cgF+ht2oqBjheY=;
 b=Fc6V4sGYWBgL/xSSzOSdibvQAubnD/AfN3UQ4T94e2bgun5wq/fwX3csZpzpD1B8cHZ4vN
 12r8AruV4uRxfGerXxP+QswLEpu0WMU2s/+/OhNqu/FlhSo9HSf8rKscvsC5SnTbhmfBRz
 Q8PsuoHH8DNxLyAJJxhp1dnGPx42aDcJ+hN+UBxKkHFOHQBOiDLHIjwhNxYuqAznB2apL7
 mF1y9mddbFWUI1upsDQR2Q3fCzwxMyU5s2/r0NQrk6NMenipOrZvZfvaMlO9ovfdYA/tcj
 fx6GgQf6RUTT9C9w/m9csJQlQu/wdzEBLHiSVQBb3EPEric7BDfbRZHtAZM5sQ==
Date: Thu, 16 May 2024 11:34:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
Message-ID: <20240516113414.49fe3b9f@xps-13>
In-Reply-To: <ZkXNN4I/gFgjD3oP@trex>
References: <20240515232138.3065987-1-tharvey@gateworks.com>
 <20240516090950.373d304c@xps-13> <ZkXNN4I/gFgjD3oP@trex>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Jorge,

...

> > >  - board with no reset gpio
> > > u-boot=3D> tpm init && tpm info
> > > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > >  - board with a reset gpio
> > > u-boot=3D> tpm init && tpm info
> > > tpm@1: TPM gpio reset should not be used on secure production devices
> > > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > >=20
> > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient=
TPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > >=20
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com> =20
> >=20
> > Looks way cleaner, thanks.
> >=20
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >=20
> > Miqu=C3=A8l =20
>=20
> nice. if needed
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

You cannot send your SoB like this. SoB means you are carrying some
code which complies with the license, etc.

Either you were part of the original writing and want to be credited
for that (you can be the author and first SoB, or suggest Tim to use
Co-developed-by). Or you reviewed the change (Reviewed-by), you tested
the change (Tested-by), or you are maintainer/responsible for some part
that is touched and you agree with the change (Acked-by).

Thanks,
Miqu=C3=A8l
