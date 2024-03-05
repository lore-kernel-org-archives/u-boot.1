Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2F0C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 15:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5668808A;
	Tue,  5 Mar 2024 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="ZhYBK0XR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC52988095; Tue,  5 Mar 2024 16:53:41 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47058807D
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 16:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 1B4CA2AA;
 Tue,  5 Mar 2024 16:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709654018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=kE1OAZ7S5sp9E2uz/0ARGXC95ho2umsTqTR/Kfxvj08=;
 b=ZhYBK0XRwXcNl/gsfLcEpEn4Ir++CjhLmH4wFwCSq46VdDgPXKofj//vjzqAEUTh1MMDJd
 FIrHJkkL8z1LXE2j0DKpb0w+nDHUCZKDT/ZUEWdd5fS2AIVaSyI3QAF8pghoczdi0cxe/3
 1Jo+KSirkFDS4FKgUB5FFxETlAkTSZFFy/+Rtc0pH0rxuQELkeBS0Wu6EDQiQ2hgo+gv5q
 SPTlFwi+X7uwGWJHgaWaW0ugImPl65ls6luzExX3OlRc56hzV4Ke4QdFvVlECIMLj58D4K
 sML7bsSQgFNV/tEfnQOvf7AGT4S+TZOHT1ukQbYpEaLC3GVG92B0uTwi1XErVg==
Content-Type: multipart/signed;
 boundary=92849c70834d81c6ada31bb22897d67a7ef7cbdec22cf22a6d951c1a3db8;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 05 Mar 2024 16:53:29 +0100
Message-Id: <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Cc: "Hai Pham" <hai.pham.ud@renesas.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Jagan Teki" <jagan@amarulasolutions.com>, "Johann
 Neuhauser" <jneuhauser@dh-electronics.com>, "Simon Glass"
 <sjg@chromium.org>, "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, "Vignesh R"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <michael@walle.cc>
To: "Marek Vasut" <marex@denx.de>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20240304161607.82759-1-marex@denx.de>
 <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
 <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
 <CZLTVKVR3AG1.BZIQQU2PYSU6@walle.cc>
 <a28b0543-67ee-4e33-91c1-86ae36eb44d5@denx.de>
In-Reply-To: <a28b0543-67ee-4e33-91c1-86ae36eb44d5@denx.de>
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

--92849c70834d81c6ada31bb22897d67a7ef7cbdec22cf22a6d951c1a3db8
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Mar 5, 2024 at 4:37 PM CET, Marek Vasut wrote:
> On 3/5/24 1:50 PM, Michael Walle wrote:
> > Hi Marek,
>
> Hi,
>
> > On Tue Mar 5, 2024 at 1:31 PM CET, Marek Vasut wrote:
> >> On 3/5/24 9:55 AM, Michael Walle wrote:
> >>> On Mon Mar 4, 2024 at 5:16 PM CET, Marek Vasut wrote:
> >>>> Some Winbond SPI NORs have special SR3 register which is
> >>>> used among other things to control whether non-standard
> >>>> "Individual Block/Sector Write Protection" (WPS bit)
> >>>> locking scheme is activated. This non-standard locking
> >>>> scheme is not supported by either U-Boot or Linux SPI
> >>>> NOR stack so make sure it is disabled, otherwise the
> >>>> SPI NOR may appear locked for no obvious reason.
> >>>
> >>> I don't think it is a good idea to just disable the WPS bit.
> >>> Usually, that bit is non-volatile and the default is not set.
> >>
> >> Yes, that's right, the bit is non-volatile and should not be set unles=
s
> >> the MTD stack can handle it correctly. Currently, neither U-Boot nor
> >> Linux does handle the bit at all, instead both attempt to use the
> >> standard SPI NOR locking scheme which is also implemented by this SPI
> >> NOR model and they both fail to unlock the SPI NOR that way.
> >>
> >> Note that the SR3 WPS bit only switches between two different locking
> >> schemes (unset =3D standard SPI NOR locking scheme, set =3D custom win=
bond
> >> locking scheme), setting SR3 WPS does not immediately imply the SPI NO=
R
> >> is locked, rather the opposite. Out of manufacturing, the SPI NOR is
> >> unlocked in either locking scheme. Depending on the SR3 WPS bit state,
> >> different commands are used to lock and unlock the SPI NOR.
> >>
> >> I recently ran across a device which had the SR3 WPS bit incorrectly s=
et
> >> out of manufacturing of that device (i.e. before it was populated on a
> >> board at board manufacturer) and the device was locked using the custo=
m
> >> locking scheme. I was not able to unlock or use that device because bo=
th
> >> U-Boot and Linux tried to use the standard scheme for that purpose.
> >=20
> > Still, I don't think it makes any sense, to disable that bit for all
> > winbond flashes just because there was one vendor which set it the
> > wrong way - or the board manufacturer didn't test it and programmed
> > the flash correctly.
>
> OK
>
> >> Clearing this SR3 WPS bit fixes that problem, both in U-Boot and in
> >> Linux, since Linux that is booted afterward then gets a device that ha=
s
> >> locking scheme configured in a way that Linux expects and can operate.
> >>
> >> Better yet, if some old LTS version of the Linux kernel is in use, it
> >> will also work correctly, because this patch will configure the SPI NO=
R
> >> locking scheme to what Linux expects it to be, before the SPI NOR is
> >> handed over to that old kernel.
> >=20
> > Agreed, but it should *not* be done automatically and nor
> > unconditionally. Please don't just overwrite any locking bits just
> > because there is one flash which have it set.
>
> The unlock code is not triggered unconditionally, it is protected by
>
> if (IS_ENABLED(CONFIG_SPI_FLASH_UNLOCK_ALL)...
>
> Kconfig option, so this can be turned on/off in board config already.

Ahh, OK then :)

But keep in mind that enabling this option is foobar and I've gone
lengths to eliminate it in linux. And actually made that option in
u-boot.

See linux commit 31ad3eff093c ("mtd: spi-nor: keep lock bits if they
are non-volatile").

-michael

> > This should be either be a board level option or maybe expose some
> > command line interface to let the user change the settings.
> >=20
> >>> Thus,
> >>> there is likely someone, probably the manufacturer of the board,
> >>> who intentionally set this bit. Now, with this patch it will get
> >>> disabled *unconditionally*, forever.
> >>
> >> In my case, it is exactly the opposite, the SR3 WPS shouldn't have bee=
n
> >> set and the device should not have been locked, but it was and that
> >> confused both U-Boot and Linux.
> >>
> >> I would argue that if the board manufacturer intention was to lock the
> >> SPI NOR, they would have had multiple better options at their disposal=
,
> >> and those options should have been aligned with the software support:
> >> - nWP pin of the SPI NOR could be tied low to enable WRITE PROTECT
> >> - OTP bits could have been programmed to enable permanent WRITE PROTEC=
T
> >> - standard SPI NOR locking scheme could have been used too
> >>
> >> If they did set SR3 WPS and hoped that U-Boot or Linux would fail to
> >> unlock the SPI NOR using standard locking scheme commands, that is I
> >> think broken design.
> >=20
> > There might be software/OS which could handle that correctly. Also,
> > if linux will ever learn to use the new locking scheme
> > unconditionally, u-boot will always mess it up then.
>
> See CONFIG_SPI_FLASH_UNLOCK_ALL above.


--92849c70834d81c6ada31bb22897d67a7ef7cbdec22cf22a6d951c1a3db8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZec/+REcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+/lmAQDchfRvK9wzdaIeOYGNnfZtA2NDQlIuWQd8
g3iMfpEf5QD/VkQg6KWkE83HglZUdkKi3ovQoQtiZzkfsILuX3B4xwk=
=sQUK
-----END PGP SIGNATURE-----

--92849c70834d81c6ada31bb22897d67a7ef7cbdec22cf22a6d951c1a3db8--
