Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C96FD3C921
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 16:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F7988DD1;
	Sat, 19 Oct 2024 18:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oiB2cfpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811B888DF8; Sat, 19 Oct 2024 18:30:33 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFC188D9F
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 18:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b147a2ff04so256513285a.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729355430; x=1729960230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3vlYShuUeQ+xu85xux3qEQwGkKwQ90xX0vaClJUFE6o=;
 b=oiB2cfpFH3DuHGl4B3tKJByPHAz6LhyKRTxGiqArYZCYFi3/aNfBxgHb6/LvtDKDRc
 8+Qz8xhFaD4V14pODmQvfdbsrdJzJ0PG5HQTLbmt52hIOyYZUBYI9BAUYzdhTHbBawxs
 +6yctecoIUb6XngVBKKLCTaGjtjtsK+URIUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729355430; x=1729960230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vlYShuUeQ+xu85xux3qEQwGkKwQ90xX0vaClJUFE6o=;
 b=ZSnWKZAEj8Sw22ls6TJCsmL++sMrlVubNi+TKnL4O4g2vwmaNzLnHIoVOTjPKyE9u0
 /6f4D6of3eJUSuTLefpTQtTxX+xag5HAPUP/y6UTw5n3Vs+UkU9QGuNEXd2mg37N8uDx
 1GqV8VKxB8eEbDIQGcXBoMfPyy409utx3LQPEj/OvAqhIZhtRtTsQC/Dqa/V1ojTopak
 2Q/7W8hiAAnzvWSRvcAIS+B4QlOUY2Z/1kuMhRXLx13G9kLMVW0h6QT0wRabWFZ3m0tn
 jsY0oh/zbnzhWozUTpsLZQgAtRdU5+Z5L0c7OsJ0Y43n8hg5u2F8bGRfZz82jgJGwDFZ
 lAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRse9aBlYARScZ141QqbOWFBolbRIXFFQ8Hrnap8YpDvxkNavxeciVW0QzVz+Oeb9d8i8H/Ms=@lists.denx.de
X-Gm-Message-State: AOJu0Yxmw3B+xS+P+yhrm8NPW76NkFB8h2PpSj4zLpLZnn6seRmrd5Dn
 e76jb5QvFQi0ZunR6R7U4/BVQVe8mjyZcurwkNtoLGQRbuJvIz/xccpP1MGcFDg=
X-Google-Smtp-Source: AGHT+IGjiodeBbUUjm4CGBUMYllWJheyInaQUUui/tgsXLIIor/MR7olyWA5PNILSzAquRoLx+FIyw==
X-Received: by 2002:a05:6214:5505:b0:6cb:ce4c:1cc2 with SMTP id
 6a1803df08f44-6cde155b9b5mr88613346d6.29.1729355429819; 
 Sat, 19 Oct 2024 09:30:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1390aadsm20070926d6.144.2024.10.19.09.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 09:30:28 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:30:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
Message-ID: <20241019163025.GU4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
 <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
 <20241018213022.GL4959@bill-the-cat>
 <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7J6xmmLwKSgtzHrL"
Content-Disposition: inline
In-Reply-To: <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
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


--7J6xmmLwKSgtzHrL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 05:49:40AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@=
chromium.org>:
> > > > > > > > >We want to keep track of images which are loaded, or those=
 which could
> > > > > > > > >perhaps be loaded. This will make it easier to manage memo=
ry allocation,
> > > > > > > > >as well as permit removal of the EFI set_efi_bootdev() hac=
k.
> > > > > > >
> > > > > > > I'll change this 'hack' to 'feature'.
> > > > > > >
> > > > > > > >
> > > > > > > > Please, keep in mind that files can be loaded manually, e.g=
=2E via the dhcp, the wget, and the loady commands. These are outside bootf=
lows.
> > > > > > >
> > > > > > > Yes, this series is only going to help if bootstd is used. Fo=
r ad-hoc
> > > > > > > use, EFI will need to rely on the above feature, at least unt=
il
> > > > > > > someone can think of another solution.
> > > > > >
> > > > > > Perhaps I need to try and be clearer here than I might have bee=
n in the
> > > > > > past. The consensus among off the shelf free software operating=
 systems
> > > > > > is "just give me an EFI interface". This simplifies things on t=
heir end
> > > > > > if regardless of architecture it's the same interface. This mea=
ns that
> > > > > > in U-Boot we need to treat EFI as one of the primary interfaces=
=2E Not a
> > > > > > novelty. Not a "some people might use". It is a frequent and co=
mmonly
> > > > > > used feature.
> > > > >
> > > > > Yes, EFI is everywhere and growing. All the more reason to tidy up
> > > > > this piece. I would like to see bootmgr use this new API, for exa=
mple.
> > > > >
> > > > > But how does this comment affect this patch?
> > > >
> > > > Because at the very high level, I wonder if I made a mistake a few =
years
> > > > back. As I understand it, the nominal case is "bootefi bootmgr". I =
was
> > > > saying at the time that perhaps bootstd can just fire that off, and=
 move
> > > > on. Now it seems like we're going along the path of re-inventing th=
at,
> > > > and not integrating well with it either.
> > >
> > > In what way are we re-inventing that? bootstd supports lots of
> > > different ways of booting, not just EFI.
> >
> > At the high level, bootflow scan is re-implementing "bootefi bootmgr".
> > but handling non-EFI payloads.
>=20
> bootstd is about replacing the distro scripts, not bootmgr.

And the distro scripts are functionally replaced by "bootefi bootmgr",
outside of bootstd.

> > > Also I hope that one day EFI
> > > will be implemented more as part of U-Boot than as a bolt-on, so will
> > > make use of bootflows, etc.
> >
> > And stuff like that is why I said what I said in here first. To me it
> > sounds like you keep implying it's a hack that's not well integrated.
> > When it's honestly at this point gotten more traction than FIT images
> > have I think (as much as I wish FIT images had "won", it's like VHS vs
> > Betamax, to bring in another technology metaphor).
>=20
> The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADER as a w=
hole!

I wasn't clear enough, sorry. I didn't mean just in this series where
you referred to storing the needed property as a hack but rather
"bolt-on" in what I quoted and "tidy up this" and "tidy up that". I'm
just saying what impression your words leave with me, and quite possibly
others.

> > > > So, to try and bring things back together. If U-Boot decides to load
> > > > $FOO from device $BAR, at that common point is where we need to:
> > > > - Is there an lmb for the location this is supposed to go to (for t=
he if
> > > >   we know it, entire size)?
> > > > - Note down everything else we know, now.
> > >
> > > Yes.
> > >
> > > >
> > > > This means that we can note down enough stuff so that EFI can const=
ruct
> > > > the path it needs. And if we're being told a filesystem, that filen=
ame
> > > > is good enough for the IH_TYPE thing you're wanting, or at least a =
good
> > > > chunk of it I hope.
> > >
> > > You want me to ignore the type that I know (kernel, ramdisk, logo,
> > > etc.) and infer the type from a filename? Why?
> >
> > No, I want you to save and display the filename. That's probably much
> > more useful when debugging than "kernel". If you actually know some
> > other type information (ie extlinux.conf says ...) then yes, it too can
> > be stored as that's useful too.
>=20
> The filename is already saved in bootflow->filename, and now it is in
> struct bootflow_img.

OK. But that's not generic enough.

> > > For EFI there is only an EFI application. It will always just be a PE
> > > file. We don't really know what it is, as someone pointed out earlier.
> > > Maybe one day we will check to see if it is a UKI and pull things out
> > > of it. But then, it would be component parts (kernel, ramdisk, etc.)
> > > so I would want to add them as images.
> >
> > I don't see why yet, honestly.
>=20
> For the cmdline, 'bootflow cmdline' allows editing it, for example.
> For a logo we can display it in the menu. The filename doesn't tell us
> what it is.

There may, or may not, be further context clues about what a blob is,
yes, and we should make use of them. But we may not have them. Frankly
for a logo we probably need to have dealt with that upon initializing
the display, so earlier in the process. But this is all getting away
=66rom the point I'm trying to make.

> > > > It also means that since it's at the most common point, it doesn't
> > > > matter if we were in an EFI application, a boot script, a bootmeth =
or
> > > > someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_addr=
_r".
> > >
> > > For that case (at the cmdline), bootstd is not currently running. Are
> > > you suggesting that bootstd could pick up these things and record
> > > them? If so, then yes, definitely, I want to do that. This series is
> > > the starting point for that. If you are suggesting something else,
> > > then I think I have lost you at this point.
> >
> > Yes, I think I lost you somewhere, but I'm not sure how. What I am
> > saying is that since everything at some point calls down to say
> > fs_read() to read a file, that is the common point to note what
> > we're doing. Not the load command, not the bootmeth, not the EFI_LOADER
> > call.
>=20
> Perhaps what you are missing is that bootstd is a proper boot
> implementation for U-Boot, where U-Boot knows what is going on.
> Ignoring that information and just hooking into fs_read() is like
> throwing away the plan and trying to recreate it from photographs.
>=20
> That said, yes I can hook into fs_read() and store that info, as it is
> better than nothing, if bootstd is not being used, or there is a
> script.

Maybe we need to throw out the plan and start over then? Since you seem
to not be accounting for the rest of the common paths and assuming
that your design can just be used as-is for them despite not taking them
in to account in the design in the first place.  Hooking in at around
fs_read() or thereabouts is likely where we need to be at least starting
some of this so that we do know information that we want to preserve.
Similarly, there's the common path for "grab a file via HTTP(s)" and
that is where we should be recording information for network loads. We
can then augment that if it was a pxelinux.cfg file we grabbed or
something else, but that's the common place to start gathering
information.

--=20
Tom

--7J6xmmLwKSgtzHrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT3poACgkQFHw5/5Y0
tyzTlQv/aO6n2rT578Q517TRaAX1AYwNe3GwcIXrajuF2Cu7hjs1xeEWUEL7G5eA
Umrqtr6tZsbaUewomzbR7a5rzYuddU/3xuJeiBytG4SGpCNm/3ZeMXgMPM9hMMu4
T8S6p1KPdIVsHsEH9LQOWBN0H2k0pQTiPF30A/r3jUYZtOgpjOfn4ssVK8MDODSw
bfOm+f9JCTDm1MUkK4Nf09AJHKHmBiFzxiKh5W17xbl8Ulm5y6pjkOrEllGNRFOY
tL+IjNEXAlstN+wCHwS84AD5CMJzrPlneC8HwAiDsqlOzcjny4MJVXXK0ijVqtH/
vVZSybUfiZiXAGqNt+BJzzeY0cfLia5DfhdSIc0mYq78SIOmSa+uK54TEwArG3gS
FgxUBJXW+pMA5aBkyyIXX/fYlYNcQ/wFDVxUuxR4KcQ9Tqo4+ouvG/rQU7kvpwD/
M5peVqxXliRgfJfbQBbPBKhqQvXDoPLGSR5zwZnIZMhBEw5xD4qzJx5eCw9hDL8L
wmzdIP/o
=uddu
-----END PGP SIGNATURE-----

--7J6xmmLwKSgtzHrL--
