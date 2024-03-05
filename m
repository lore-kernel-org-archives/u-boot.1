Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39CFC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52481880A1;
	Tue,  5 Mar 2024 17:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="ffcd4OiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEC68809F; Tue,  5 Mar 2024 17:55:54 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B58D8809A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id B3B652AA;
 Tue,  5 Mar 2024 17:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709657749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jA2jP3Oo6Q1L6DcA2QeKqvfhPQHjIxHN2waFoHgcpjk=;
 b=ffcd4OiHxfxWMhd1SBHsCpXo1SNCs3tK7jTraKhEoVhGeRbHlnoCpySFVGRZm/GSdrLAxZ
 ECfIVYqXI2rqJe6+jQ6JEO8DNSDZdua36vqpzdJawDjCNN5wb+TtV/wuVciOEtrbIbICsv
 HiJgeOP92STQKSqwybQfHOK/4+RWTag5spxwwMtzHlGRxpqVZiWDNdccgRexO+GfurTBc9
 yQlygFl7IW2Q9jJTyXdqgwC/oK1qcBp2sLaCYT5UgDh+wNMdbC6a4mb9XfRsDWtGk0lr6f
 374P23pYnbezgV1RXYvt6Hsfbt3M/UQxUhyezM55C01g/sVOBDN0X1y1jBQQsA==
Content-Type: multipart/signed;
 boundary=db61018f7449a7468756283d270e8d2b7764ff63fe06538b995d99244671;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 05 Mar 2024 17:55:44 +0100
Message-Id: <CZLZ391C9O5F.38A18T9S51BNT@walle.cc>
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
 <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
 <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
In-Reply-To: <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
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

--db61018f7449a7468756283d270e8d2b7764ff63fe06538b995d99244671
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Mar 5, 2024 at 5:28 PM CET, Marek Vasut wrote:
> On 3/5/24 4:53 PM, Michael Walle wrote:
> > On Tue Mar 5, 2024 at 4:37 PM CET, Marek Vasut wrote:
> >> On 3/5/24 1:50 PM, Michael Walle wrote:
> >>> On Tue Mar 5, 2024 at 1:31 PM CET, Marek Vasut wrote:
> >>>> On 3/5/24 9:55 AM, Michael Walle wrote:
> >>>>> On Mon Mar 4, 2024 at 5:16 PM CET, Marek Vasut wrote:
> >>>>>> Some Winbond SPI NORs have special SR3 register which is
> >>>>>> used among other things to control whether non-standard
> >>>>>> "Individual Block/Sector Write Protection" (WPS bit)
> >>>>>> locking scheme is activated. This non-standard locking
> >>>>>> scheme is not supported by either U-Boot or Linux SPI
> >>>>>> NOR stack so make sure it is disabled, otherwise the
> >>>>>> SPI NOR may appear locked for no obvious reason.
> >>>>>
> >>>>> I don't think it is a good idea to just disable the WPS bit.
> >>>>> Usually, that bit is non-volatile and the default is not set.
> >>>>
> >>>> Yes, that's right, the bit is non-volatile and should not be set unl=
ess
> >>>> the MTD stack can handle it correctly. Currently, neither U-Boot nor
> >>>> Linux does handle the bit at all, instead both attempt to use the
> >>>> standard SPI NOR locking scheme which is also implemented by this SP=
I
> >>>> NOR model and they both fail to unlock the SPI NOR that way.
> >>>>
> >>>> Note that the SR3 WPS bit only switches between two different lockin=
g
> >>>> schemes (unset =3D standard SPI NOR locking scheme, set =3D custom w=
inbond
> >>>> locking scheme), setting SR3 WPS does not immediately imply the SPI =
NOR
> >>>> is locked, rather the opposite. Out of manufacturing, the SPI NOR is
> >>>> unlocked in either locking scheme. Depending on the SR3 WPS bit stat=
e,
> >>>> different commands are used to lock and unlock the SPI NOR.
> >>>>
> >>>> I recently ran across a device which had the SR3 WPS bit incorrectly=
 set
> >>>> out of manufacturing of that device (i.e. before it was populated on=
 a
> >>>> board at board manufacturer) and the device was locked using the cus=
tom
> >>>> locking scheme. I was not able to unlock or use that device because =
both
> >>>> U-Boot and Linux tried to use the standard scheme for that purpose.
> >>>
> >>> Still, I don't think it makes any sense, to disable that bit for all
> >>> winbond flashes just because there was one vendor which set it the
> >>> wrong way - or the board manufacturer didn't test it and programmed
> >>> the flash correctly.
> >>
> >> OK
> >>
> >>>> Clearing this SR3 WPS bit fixes that problem, both in U-Boot and in
> >>>> Linux, since Linux that is booted afterward then gets a device that =
has
> >>>> locking scheme configured in a way that Linux expects and can operat=
e.
> >>>>
> >>>> Better yet, if some old LTS version of the Linux kernel is in use, i=
t
> >>>> will also work correctly, because this patch will configure the SPI =
NOR
> >>>> locking scheme to what Linux expects it to be, before the SPI NOR is
> >>>> handed over to that old kernel.
> >>>
> >>> Agreed, but it should *not* be done automatically and nor
> >>> unconditionally. Please don't just overwrite any locking bits just
> >>> because there is one flash which have it set.
> >>
> >> The unlock code is not triggered unconditionally, it is protected by
> >>
> >> if (IS_ENABLED(CONFIG_SPI_FLASH_UNLOCK_ALL)...
> >>
> >> Kconfig option, so this can be turned on/off in board config already.
> >=20
> > Ahh, OK then :)
> >=20
> > But keep in mind that enabling this option is foobar and I've gone
> > lengths to eliminate it in linux. And actually made that option in
> > u-boot.
> >=20
> > See linux commit 31ad3eff093c ("mtd: spi-nor: keep lock bits if they
> > are non-volatile").
>
> So, how shall we proceed here?

Regarding this patch, I think it's fine. It will unlock the whole
flash as advertised.

But u-boot should really consider making that a "default n" option.
And most likely adding =3Dy to every existing defconfig out there so
that at least new boards will benefit from it.

> The way I see this, if Linux ever implements this scheme, Linux can set=
=20
> the SR3 WPS bit as needed, it does not matter which way bootloader sets=
=20
> the bit as the protection bits are not cleared when the bit is cleared,=
=20
> they seem to be stored elsewhere.

On each reboot you'd wear out that cell with two erases/writes.
That's another reason why that whole unlocking thing is foobar for
non-volatile bits. For me, non-volatile bits are for provisioning,
so during a normal boot they should not be touched at all. Just
during board manufacturing or because the user actively want to
protect something.

If you clear this bit during the unlock all command, all the locking
bits are cleared anyway. Or do you mean, the individual bits are
still retained?

> But, if Linux starts to use SR3 WPS, then U-Boot should be updated to=20
> match, i.e. both projects should agree on the locking scheme, so that=20
> there won't be a situation where on the same device, one project uses=20
> one scheme, the other project uses another scheme. I think this would=20
> technically work, but it would be horrible from the user perspective.=20
> And if that happens, both projects should then be updated in lockstep=20
> and this UNLOCK_ALL should be disabled for such a setup then.

If you don't touch it, I don't think you have a problem here. u-boot
and linux can support different schemes, as long as the user is
aware of that. I.e. if they want to lock a region and the flash is
configured in a mode which isn't supported in u-boot (or linux) it
should be rejected. There might of course be a command to switch the
scheme if someone want to do so.

-michael

--db61018f7449a7468756283d270e8d2b7764ff63fe06538b995d99244671
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZedOkBEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+7FZAP97I1tNSYsTGIfACjE8WlUnEoBUzYNn4Jso
wrRMoq2TfQEAif/z7V33uQMH21BDPEl5xZvUd1q/JPIOsy/8bC9KTwo=
=DnUH
-----END PGP SIGNATURE-----

--db61018f7449a7468756283d270e8d2b7764ff63fe06538b995d99244671--
