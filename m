Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6D6C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 12:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4C487D1E;
	Tue,  5 Mar 2024 13:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="sSTnYFCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBD48803A; Tue,  5 Mar 2024 13:50:51 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCEB87D1E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 13:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 408964C9;
 Tue,  5 Mar 2024 13:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709643048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=K7Zi9j4RUFIpw8pclYN0KUfDu7fehM7riOPQ2v/X+oY=;
 b=sSTnYFCCLYdsfQooZbT+TR5kcnI6kbqFWYC1BI8EVji4xpxew8unnNC1WI4as7b0G3rv1Z
 6+nxDMqq6b08MK5wqLB3zNLuxoO2qmFRs5zoiQJaU6L76WchTYOSJmavsua63o9JcMSE8p
 TaHdvREtPRMRPZ+6JSLu78R/R8IQ4ok3ZNrTFQSUlzbblmL2pBOp8+xmGsUd6F4TkhwZJB
 DFkSp35usQkp2dXlMM8Ad+A32gkJczMOE5yubbWMmt3aDLKsiFxSiBUIZVV1khfN7SFpaA
 iKskew3l+8boLHOVr6oWsxfOefQja+mKHfVxQMNA9jzM7PYmOtJBoKXt160RQg==
Content-Type: multipart/signed;
 boundary=73fabe8cb51ff1a0b96c93fc6d9929403e76050b7cb11c5f4ab41b4cb237;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 05 Mar 2024 13:50:37 +0100
Message-Id: <CZLTVKVR3AG1.BZIQQU2PYSU6@walle.cc>
Cc: "Hai Pham" <hai.pham.ud@renesas.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Jagan Teki" <jagan@amarulasolutions.com>, "Johann
 Neuhauser" <jneuhauser@dh-electronics.com>, "Simon Glass"
 <sjg@chromium.org>, "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, "Vignesh R"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <michael@walle.cc>
To: "Marek Vasut" <marex@denx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
X-Mailer: aerc 0.16.0
References: <20240304161607.82759-1-marex@denx.de>
 <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
 <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
In-Reply-To: <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
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

--73fabe8cb51ff1a0b96c93fc6d9929403e76050b7cb11c5f4ab41b4cb237
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Tue Mar 5, 2024 at 1:31 PM CET, Marek Vasut wrote:
> On 3/5/24 9:55 AM, Michael Walle wrote:
> > On Mon Mar 4, 2024 at 5:16 PM CET, Marek Vasut wrote:
> >> Some Winbond SPI NORs have special SR3 register which is
> >> used among other things to control whether non-standard
> >> "Individual Block/Sector Write Protection" (WPS bit)
> >> locking scheme is activated. This non-standard locking
> >> scheme is not supported by either U-Boot or Linux SPI
> >> NOR stack so make sure it is disabled, otherwise the
> >> SPI NOR may appear locked for no obvious reason.
> >=20
> > I don't think it is a good idea to just disable the WPS bit.
> > Usually, that bit is non-volatile and the default is not set.
>
> Yes, that's right, the bit is non-volatile and should not be set unless=
=20
> the MTD stack can handle it correctly. Currently, neither U-Boot nor=20
> Linux does handle the bit at all, instead both attempt to use the=20
> standard SPI NOR locking scheme which is also implemented by this SPI=20
> NOR model and they both fail to unlock the SPI NOR that way.
>
> Note that the SR3 WPS bit only switches between two different locking=20
> schemes (unset =3D standard SPI NOR locking scheme, set =3D custom winbon=
d=20
> locking scheme), setting SR3 WPS does not immediately imply the SPI NOR=
=20
> is locked, rather the opposite. Out of manufacturing, the SPI NOR is=20
> unlocked in either locking scheme. Depending on the SR3 WPS bit state,=20
> different commands are used to lock and unlock the SPI NOR.
>
> I recently ran across a device which had the SR3 WPS bit incorrectly set=
=20
> out of manufacturing of that device (i.e. before it was populated on a=20
> board at board manufacturer) and the device was locked using the custom=
=20
> locking scheme. I was not able to unlock or use that device because both=
=20
> U-Boot and Linux tried to use the standard scheme for that purpose.

Still, I don't think it makes any sense, to disable that bit for all
winbond flashes just because there was one vendor which set it the
wrong way - or the board manufacturer didn't test it and programmed
the flash correctly.

> Clearing this SR3 WPS bit fixes that problem, both in U-Boot and in=20
> Linux, since Linux that is booted afterward then gets a device that has=
=20
> locking scheme configured in a way that Linux expects and can operate.
>
> Better yet, if some old LTS version of the Linux kernel is in use, it=20
> will also work correctly, because this patch will configure the SPI NOR=
=20
> locking scheme to what Linux expects it to be, before the SPI NOR is=20
> handed over to that old kernel.

Agreed, but it should *not* be done automatically and nor
unconditionally. Please don't just overwrite any locking bits just
because there is one flash which have it set.

This should be either be a board level option or maybe expose some
command line interface to let the user change the settings.

> > Thus,
> > there is likely someone, probably the manufacturer of the board,
> > who intentionally set this bit. Now, with this patch it will get
> > disabled *unconditionally*, forever.
>
> In my case, it is exactly the opposite, the SR3 WPS shouldn't have been=
=20
> set and the device should not have been locked, but it was and that=20
> confused both U-Boot and Linux.
>
> I would argue that if the board manufacturer intention was to lock the=20
> SPI NOR, they would have had multiple better options at their disposal,=
=20
> and those options should have been aligned with the software support:
> - nWP pin of the SPI NOR could be tied low to enable WRITE PROTECT
> - OTP bits could have been programmed to enable permanent WRITE PROTECT
> - standard SPI NOR locking scheme could have been used too
>
> If they did set SR3 WPS and hoped that U-Boot or Linux would fail to=20
> unlock the SPI NOR using standard locking scheme commands, that is I=20
> think broken design.

There might be software/OS which could handle that correctly. Also,
if linux will ever learn to use the new locking scheme
unconditionally, u-boot will always mess it up then.

-michael

--73fabe8cb51ff1a0b96c93fc6d9929403e76050b7cb11c5f4ab41b4cb237
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZecVHREcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+1iYAP0Ru2+p2V5fPaF/1iWKebKQR3FrQhOkeTAN
ry9Z+n7ztAD8DwUnAEsIqbv5+tOP3Em4/OEpu0AjZmapOnbsiQDYbA8=
=4D+N
-----END PGP SIGNATURE-----

--73fabe8cb51ff1a0b96c93fc6d9929403e76050b7cb11c5f4ab41b4cb237--
