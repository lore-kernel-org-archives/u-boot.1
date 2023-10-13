Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18295CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 17:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FFF86E22;
	Fri, 13 Oct 2023 19:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oAcIscKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700C986E7C; Fri, 13 Oct 2023 19:48:58 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16EE86E0E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 19:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7740aa4b545so151965785a.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697219332; x=1697824132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oZpIAyfqXOktSRawczAUNLmMCkDa5UWfYkkaTaMN6kY=;
 b=oAcIscKjOhsgyPz8FJQWYMYPNXdo6AzAwyiJx+1x7Q4z3PEPotF+S+TSsuabuuWOeQ
 xkLCxmtrBetCilz/CPmC5L/GnNLsnwqInfLibETozP9Tkgo5rajWMZf+7BuClfsPyFzr
 Q0FOnQ+PIbBtTFSgKrnQtXaKGiFxTA8vJfgnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697219332; x=1697824132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZpIAyfqXOktSRawczAUNLmMCkDa5UWfYkkaTaMN6kY=;
 b=Pu9xjx75lEVwPUggimGJQMBketSvWYTVazbXXl9IZnGRQ07W1ZhLMhUSvV8vKvs/bF
 MbxOJk3SFr2fKAzjCD6CL6IuTVDw6q3u6rwerNLofzq1GJsEIHnm9/8Zy6mcSETYvj4p
 MMtNeMI5K9II1d1+kU4EqBinzBdjqg9Sq+gXj78ZFpqfzlCf8vBiTnC3EEKSflRqAL6o
 rZrjHpp3worsPuOov2EKQV+lKIGw46rJajwvwEDfjPzFNV+jl9++GkxTEiYYEqYpfe99
 S/RX1UbuTZ7elFT/ntnoMm1b8O3hz+XJJVQczZUa+L0T4J/x4v5FgQKD9UKBG+t0hZSd
 WBnw==
X-Gm-Message-State: AOJu0YzLs4MW5InqXkkV4lY+2HMHeZUhclOXwVy2/A9h2PhyTS8lM02w
 6qv+8vVorDd6wH3YU0irhDv7Rw==
X-Google-Smtp-Source: AGHT+IFtdhnnrvIogckQz084Lxul1NxEtsdUgI/4XfL6+5KaYv9F1WyMBJ/i/oICsahz8wqoxZEZ2g==
X-Received: by 2002:a05:620a:2802:b0:776:f8b5:c4c with SMTP id
 f2-20020a05620a280200b00776f8b50c4cmr27945334qkp.20.1697219332585; 
 Fri, 13 Oct 2023 10:48:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 vv3-20020a05620a562300b007758b25ac3bsm811186qkn.82.2023.10.13.10.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:48:51 -0700 (PDT)
Date: Fri, 13 Oct 2023 13:48:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
Message-ID: <20231013174850.GT3119521@bill-the-cat>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
 <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="knPl3o89f5A6Atx6"
Content-Disposition: inline
In-Reply-To: <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
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


--knPl3o89f5A6Atx6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 05:22:03PM +0100, Peter Robinson wrote:
> On Fri, Oct 13, 2023 at 5:09=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Tue, Oct 10, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@arm.=
com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Robinson <pbrobinson@gmail.com>
> > > > > Sent: Tuesday, October 10, 2023 12:22 PM
> > > > > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > > > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simon =
Glass
> > > > > <sjg@chromium.org>; u-boot@lists.denx.de
> > > > > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> > > > >
> > > > > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > > > > <Guillaume.Gardet@arm.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > > > > This has been found on openSUSE Tumbleweed. The only diff we ne=
ed is:
> > > > > >   -CONFIG_OF_EMBED=3Dy
> > > > > >   +CONFIG_OF_BOARD=3Dy
> > > > > > To use firmware provided Device Tree. But that should not affec=
t the mmc
> > > > > behavior too much, I think.
> > > > >
> > > > > I've been booting Fedora fine on a RPi4 BUT there's issues with t=
he display
> > > > > turning off [1] when the accelerated display modules load
> > > > > (vc4) as a result of this patch set. Can you confirm if that's th=
e same problem
> > > > > you're seeing?
> > > >
> > > > No, that's not my problem. My issue is grub was not loaded by u-boo=
t from uSD.
> > > > It seems more like Simon's problem: https://lists.denx.de/pipermail=
/u-boot/2023-October/533162.html
> > > >
> > > > @Simon, can you check if the patch below fixes your boot problem on=
 RPi4, please?
> > >
> > > This has been reported at least twice before. There is a fix [2] whic=
h is in my queue to apply.
> >
> > Looking at that patch it scans the first 3 devices, how does it handle
> > non storage devices like SDIO WiFi modules? It shouldn't be trying to
> > scan those.
>=20
> And in the case of the RPi the other enabled SDHCI interface is the
> WiFi, why would we even be trying to boot off a non storage interface,
> something here just feels broken/wrong in general.
>=20
> The patch does make it work with pure upstream, and I'm not sure why
> the Fedora build boots it fine out of the box, but the patch just
> feels like it's hacking around some other underlying problem with
> bootstd, we didn't have this problem with the previous method and
> trying to boot off non storage interfaces feels like it could cause
> other problems.

I think the answer here is that we're doing the best we can given that
we just don't know until run time what we have. In the case where sdhci
is something other than storage, we get as far as asking "are you a
block device?" which then fails when sdhci is a WiFi an not an eMMC.
This does mean the user could notice "Card did not respond to voltage
select! : -110" being printed, and I don't know if we should do
anything about that (it's a handy message when your uSD isn't fully
inserted, etc).  But since we (can) support everything on a single
build, we just have to figure it out at run time.

--=20
Tom

--knPl3o89f5A6Atx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpgv4ACgkQFHw5/5Y0
tyzfEgwAnj8ODUAUU1PIrZ4cFMQ8Zp1QrAtfMI5zJoPwjqjWSa4zpjescBWdei2n
nMxEBZ8zgn4Cu0K75JwnETSzoA0HeNdV5szn8M3U0bjb5vQnf32Vvi2Y4rcepj8P
9Ff7/8cG2+phjBVDBiT5LeemyOeCYCCXG7oY/I8LjLzFHIuet3wpZDJjY1TDmdRh
Yg0tKpKRrKE67IU/FErcA3Aw5GArVrcrZxOWvYUgNqJt1aS6D0K8Kw15OfpDYOrA
qfElybRC/cNgwgZqo4ioOL+eX3sv2Dz6uB5RqNQ0Gf/QEd9iHg9uw086pGr+yyrZ
hlB3ep5gs4+1McganY0Gu14ZUEokX+UpjWm7J7Zf28UiTCxDaXSYtKuLoyUybm4r
QOwkFStHiOF2xJJ9wjdVQQfb1xLx30jctD/3uCOK+WQ0B5V6yNjo/TYXMhR7pY5l
0pNoPityiOs47hxSdqBHjfsYvs0Kh4Y8UxXcSC19eNPbAjn4MsUkWo3TrPLqlVK3
jDYe5KVg
=YkBY
-----END PGP SIGNATURE-----

--knPl3o89f5A6Atx6--
