Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBADC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 19:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED7887D48;
	Fri,  8 Mar 2024 20:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YWALv1FH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D1A87D48; Fri,  8 Mar 2024 20:35:44 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087D887D47
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 20:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78830bba6a4so126999485a.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709926540; x=1710531340; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yq3deumhvzM7Xd/D6Lep6K7F1m50wAaKem+OdTXoYJ4=;
 b=YWALv1FHnqqm3ADgzod1T3hn4YJ+TbpbdHWN9/9z9qKmKWDUoLREnNd40EuEajV4VZ
 Pho/s4XKUizig5zCjd93mHR13x8TAgX5Vu87EGRRgHWiWfGC+BWgW+rk/xj/s4KaMDGt
 NGXzgPCKHQrVnIiv2dddCmm/FsvY36giABvtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709926540; x=1710531340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq3deumhvzM7Xd/D6Lep6K7F1m50wAaKem+OdTXoYJ4=;
 b=jOVdepWIOgLVUBz4ZiTj5QqY8sNtn/+QC9tGZ6k1lcMS8yXwskXtCJtRYHmwpyIv8X
 HRe2ty8mEpRyMsInP4daMBzpbY06hnlxJ3Eqhzol4qCvieXcu9N8nbVFb7Ru43mEOcC/
 +6XlwHlaezyBhr7z4xZpvW2OdVqv6/gMngoRsvNd18ey1ClCOof/5VHEBGXKEEVmNwj6
 RhU+ATbay0801ovqeamuhvhcvwQujfkawgppryxPhCPpxDHulaC9rmRXbhQFvk2FIwlX
 ia161D7sA1MvAsq5A6jsnhUfeEHfIp6bQGf81zMQffJoge+0LiwdQQ9jasMEgsKCF0ZC
 9y7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuwlJoKMTu/9jJ8rrgBNnnPZRkzjRsTbqFp6/QY7exAgoO3ZAWRgxUcxO7Qwn1M9AGF2R7wrxrFePBUMoGhysXZgX8DQ==
X-Gm-Message-State: AOJu0Yyd4vR1UvW5ccUdymLW7sWsXv716Pmm1boQTzRjegW85mWc7/BN
 SWmjjwVVkxYEy1PWZDGB2PfySRAg79+amM2x/MYGqtIi305TOvMtURHWv+6DKOY=
X-Google-Smtp-Source: AGHT+IEQpT6yBzIKkVYphsf0SzGKDBR5zzGVV3MCR4x7qUblkrAuAdyPntDNk30pld9KcgCiPwgNcQ==
X-Received: by 2002:a05:620a:c11:b0:788:31ba:f1e9 with SMTP id
 l17-20020a05620a0c1100b0078831baf1e9mr34314qki.77.1709926539551; 
 Fri, 08 Mar 2024 11:35:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 q6-20020a05620a0c8600b00787f42e6299sm45064qki.113.2024.03.08.11.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 11:35:38 -0800 (PST)
Date: Fri, 8 Mar 2024 14:35:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, 
 Sumit Garg <sumit.garg@linaro.org>, shawnguo@kernel.org,
 Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Rob Herring <robh@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240308193536.GT1523872@bill-the-cat>
References: <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
 <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
 <20240301-unstuffed-sixtyfold-0a875a031043@wendy>
 <20240301185413.GF3040305@bill-the-cat>
 <20240308-amends-deskbound-c12ed63859e5@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k51oVCdLwtumsb26"
Content-Disposition: inline
In-Reply-To: <20240308-amends-deskbound-c12ed63859e5@wendy>
X-Clacks-Overhead: GNU Terry Pratchett
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


--k51oVCdLwtumsb26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 01:21:15PM +0000, Conor Dooley wrote:
> On Fri, Mar 01, 2024 at 01:54:13PM -0500, Tom Rini wrote:
> > On Fri, Mar 01, 2024 at 01:32:53PM +0000, Conor Dooley wrote:
> > > > > > > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > > I think the commit in question can be
> > > > > > > > > > > summarized as "remove a bunch of explicit HW informat=
ion because there's
> > > > > > > > > > > now a Linux Kernel driver that determines that dynami=
cally". What do we
> > > > > > > > > > > do next? The old information is in a presumably valid=
 binding still, can
> > > > > > > > > > > we just put it back and comment that consumers outsid=
e of Linux use this
> > > > > > > > > > > still so it's not removed again later? Or am I just m=
issing where we can
> > > > > > > > > > > instead get this information from the DT still and no=
t need to come up
> > > > > > > > > > > with a new driver and subsystems?
> > >=20
> > > I don't think this is an accurate summary. The "explict hw informatio=
n"
> > > was never allowed for an imx6ul, only for some older devices, so "the
> > > old information is in a presumably valid binding" is not accurate.
> > > See 7b920aae917d ("dt-bindings: mxsfb: Add new bindings for the MXSFB
> > > driver") for when doing things that way was deprecated. The imx6ul was
> > > only documented several years after it was introduced (so likely seve=
ral
> > > years after it started incorrectly using that binding).
> > >=20
> > > Seeing that, I am not sure that I would even question the kernel patch
> > > cited above, the change was done for binding compliance and I would n=
ot
> > > be inclined to think twice, given the bindings are the ABI.
>=20
> Reading this back today, it took me second to recall what I meant by
> "question". What I meant was that during a review I would would see a
> patch changing this to comply with the bindings and think nothing of it,
> not that removing it was a unquestionably correct thing to do.
>=20
> > So part of the problem I see here is that legacy platforms (which to me
> > is a large chunk of 32bit ARM) are trickier. I'm not asking for anything
> > more to be done in this example to be clear (I think the new panel-dpi
> > binding is what U-Boot needs to implement and solve the issue here).
> >=20
> > But I don't think the fact that the old binding was handled
> > suboptimally means that its usage should be ignored.
>=20
> What often happens is that Linux retains support for the old way of
> doing things but the dts is updated to the documented way. I'm not
> really sure how to deal with this kind of thing, other than being extra
> diligent about reviewing cleanup work that may impact other users of the
> dts sources and letting the linux platform maintainers know if something
> gets broken in U-Boot.

I think that's perhaps the crux of the issue. Since the kernel is the
definitive source of the dtb files too, cleanups of the sources can
impact other projects (U-Boot, OpenBSD, etc) who might not have been
aware the binding was deprecated/etc.

> > They were added in
> > 2017 which is after they were deprecated and not caught then. I consider
> > that to mean it was still valid.
>=20
> I don't agree that that makes it valid, but I can see how it would be
> assumed to be valid by other users of the dts file.

Yes, fair.

> > And I also assume that today we have
> > the tooling to catch that and not let it in, in the first place.
>=20
> Unfortunately, not really. The tooling is capable of spotting these
> things, but it totally depends on the effort people have put in to
> that platform as to whether or not the single to noise ratio actually
> allows a maintainer to spot when these things are introduced.
> The RISC-V platforms, Samsung and some others have really good
> compliance, but other platforms like aspeed or at91 have so many
> warnings etc that it is very very difficult for the platform maintainers
> to actually spot things like these being added.

OK.

> > Time will tell now how bumpy a ride things end up being as I do agree
> > that getting all the DTS files following the ABI correctly is an
> > important goal.
>=20
> Fixing up a platform is utterly mind-numbing work that requires
> understanding datasheets and bindings for really varied hardware, so
> it's best done by either the platform maintainers or piecemeal by people
> that want to improve one particular board. It's gonna take a long time
> to get "all" files following the ABI, particularly away from the ones
> the linux dt-maintainers take more of an interest in.
> Next time we get a new grad starting I might subject them to some
> cleanup activities, they'll have to learn about dt at some point anyway
> ;)

It's all tricky and complex, yup :(

> Sorta unrelated to the above, but related to the OF_UPSTREAM stuff is
> that I do notice a bit of an attitude of "U-Boot bundles the dtb with
> the binary, so it's okay to break U-Boot because they have a copy of
> the old dts and we can update both code and dts at the same time in
> the 'future'". I can't cite anything off the top of my head, but I've
> not been reviewing binding patches for all that long and it has been
> said multiple times.
> I'm not entirely sure how to handle that sort of situation, "force" the
> submitter to send patches to U-Boot before I ack the binding?
>=20
> I do skim all the patch subjects that get sent to the U-Boot ML, so I'll
> at least try to keep an eye out for any fallout caused by the
> OF_UPSTREAM stuff.

I think the first steps will just be trying to be more aware of the
other users and communicate earlier rather than later about changes. And
thanks for keeping an eye out for things.

--=20
Tom

--k51oVCdLwtumsb26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXraIQACgkQFHw5/5Y0
tyzKwAv9FBeqw8BRWFqQPn+tak6tXzTzPNaYxyVFO34URjlOgRwlItWUyu83+tda
N6OCYz7A+K96dsWzI3N2E/3DPoSY/tBeR0w5Y6VhMPaAkEoSS79VL1+s3z/QAUpm
x8HweqbFm4j0K3r9+YexKWyeEUXhUnZzUMgQSHE7FB8VoPJChv+OcKsERNRltbKJ
DvQr8KCIqLqLrqD9b1kXuCrmKM50phJ2NZ+EIopOGw4F+5jTMRTkbM8LH7MJ1rc0
y1yP6jggqPlsof87N5wwqjjPa7Pl3L9VGeIeEvgXrtxugQ4rydEuLS7sxg0TY2y7
SACrSEKh20/48XyiQWXvAXgTs9Xo1AX8hSP1srKAoYHCIr1GtrorW2IKNvXIcEIA
YqsH9W2Mpv9ZrVXjFjPteT0LwtKpKf4Sm2lbg+5WflfkCtSWvUthqhPEDuq0MSKh
FVmKvBgEFmeKTko2/rcaUca094kMvEHWkuHKG0Niqe0p1pL1yHoFJwwSzGgSf2l2
gLFiZbbS
=88Pe
-----END PGP SIGNATURE-----

--k51oVCdLwtumsb26--
