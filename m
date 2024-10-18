Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A0CD3DEA9
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0400888B23;
	Fri, 18 Oct 2024 20:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jomMrbEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD13588BEF; Fri, 18 Oct 2024 20:31:18 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8241C889EB
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7181a8af549so525016a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276275; x=1729881075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lSeY9BvQZAaVc/k10mU71HaPJgzRfsBHkDCV8grVQg8=;
 b=jomMrbEW7GDH3X2PJnaTWtZotTu6yFceAWe3YXZTy1H3zvqNnyI5zBT6sQcnkzJmw9
 AvKC/i9khMkLdK0eg2iN5P4OdgAwxQTX4Q8Rq2g9XvuPwCMaB76FMVaLHMguGYl3imDu
 qlPyJDpdkwo/5WsppRpLw7h+o3zhQxCmIdERY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276275; x=1729881075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSeY9BvQZAaVc/k10mU71HaPJgzRfsBHkDCV8grVQg8=;
 b=VeGgS4sX4oBcOf2cecPEIeAfvJ5MX3u2ttmCNs/29NnW3ipW87c7B9L1eTQbmkfz9l
 QUtEHyQS2bojsnOjNLacflBe1KdOM+siEyAosKspVtAwLXDnZWM5IQGcNe+KXt7sy4Kc
 lPDjxcqY/zP1InUlIY845/60OROk1bplr3MWxtgmgtcwjWtwvA+mjUYLnBzN2AVP96LD
 FgC2RsTLyyxmr2znxfOKT6ALbYoHH72Ew87u3IJIOcCTQ0VzUc/qwIzvMug/Hxn6cfAJ
 NGAgUPMpwNJgMTfIgjzb64IYG2wqn7Wxjz92QVC6HXomyZQ+590HqX76pZjExcFsDqYq
 n6VA==
X-Gm-Message-State: AOJu0YxKvu54Njua5bm2IycpwraSnhDym02Bgq+wAKRdtseU+ydhmG1z
 rmwFmliCikDaZoaOQlfxzFnqSpFlvwM3FId2Q9gzTGHSGu/U5MF5pN3T+C/b/ls=
X-Google-Smtp-Source: AGHT+IEbe4rbMFZqKUAle+viCir/oeh14zQKamgNsLqbMf3+bEDgEmw++WcToyWkYVwJYTls3IYFcw==
X-Received: by 2002:a05:6359:5f8f:b0:1c3:38a:212e with SMTP id
 e5c5f4694b2df-1c39dcfadb6mr176449855d.0.1729276275215; 
 Fri, 18 Oct 2024 11:31:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460aea48569sm9459511cf.66.2024.10.18.11.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:31:14 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:31:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/34] image: Add a new type for extlinux
Message-ID: <20241018183111.GF4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
 <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
 <20241018151753.GY4959@bill-the-cat>
 <CAFLszTjwNK+4fH_x2ZDkamanDjFJCtgXFD+d9gTruZs7gLvfZQ@mail.gmail.com>
 <20241018175441.GC4959@bill-the-cat>
 <CAFLszTjDLNyh5QZpmdgNhxJW=zq=L72fiq_rER5K-PuVtXxXgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XiFkTTEnScqSaBfA"
Content-Disposition: inline
In-Reply-To: <CAFLszTjDLNyh5QZpmdgNhxJW=zq=L72fiq_rER5K-PuVtXxXgQ@mail.gmail.com>
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


--XiFkTTEnScqSaBfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:19:26PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 11:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 11:20:45AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Oct 2024 at 09:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 08:57:02AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > Add an image type for the extlinux.cfg file, which U-Boot sup=
ports
> > > > > > > reading.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  boot/image.c    | 1 +
> > > > > > >  include/image.h | 1 +
> > > > > > >  2 files changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/boot/image.c b/boot/image.c
> > > > > > > index abac254e026..cf16fb7fbf7 100644
> > > > > > > --- a/boot/image.c
> > > > > > > +++ b/boot/image.c
> > > > > > > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] =
=3D {
> > > > > > >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image=
 with Flat Device Tree ", },
> > > > > > >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPK=
G Image" },
> > > > > > >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Im=
age" },
> > > > > > > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux=
 configuration" },
> > > > > > >       {       -1,                 "",           "",          =
         },
> > > > > > >  };
> > > > > >
> > > > > > This whole part of the series feels like we're abusing IH_TYPE_=
 far past
> > > > > > what it's used for. Especially the command line string one. It =
seems
> > > > > > like the main use is to be able to later on print something hum=
an
> > > > > > friendly. Please try and figure out some other way to do that. =
Thanks.
> > > > >
> > > > > Yes I had the same thought, particularly with cmdline, as you say.
> > > > >
> > > > > The obvious alternative is to just have a string which communicat=
es
> > > > > the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
> > > > > string indicating what it really is.
> > > > >
> > > > > But one advantage of the approach in this patch is that, for boot=
meths
> > > > > which include a cmdline, it can be identified and added as a file.
> > > > > That includes zimage and ChromiumOS, but not EFI. It will allow m=
e to
> > > > > get rid of the cmdline in struct bootflow, perhaps.
> > > >
> > > > Yeah, this all sounds like IH_TYPE is the wrong direction to expand.
> > > > Where you're grabbing these things from is where you might get a hi=
nt as
> > > > to what these things are and that's where to take the store the
> > > > knowledge for later.
> > >
> > > They are grabbed from several places:
> > > - extlinux comes from disk, with the extlinux bootmeth, but can also
> > > come from 'include' files within that scripts, also pxe
> > > - EFI apps from from disk with the EFI bootmeth
> > > - kernel, ramdisk and fdt some from most bootmeths
> > > - cmdline comes from extlinux (with zImage only) and ChromeOS,
> > > probably Android but I haven't looked
> > > - logo comes just from script so far, but I suppose UKI and FIT will
> > > have it eventually
> > >
> > > Can you be more specific with your suggestion? I am not seeing an
> > > alternative right now.
> >
> > I'm just saying that this is not what IH_TYPE is. As you said maybe you
> > can store this string information elsewhere? And I'm suggesting that
> > perhaps when you load a thing you'll then also know what the thing is.
>=20
> Yes, I agree. 'Type' is really about the actual file that you are
> reading, not the data types of the bits within it, for example. That's
> the problem with my approach.
>=20
> The other idea I had was to add a new thing to image.h (IH_DATA_xxx).
> But I wasn't sure it was worth it. Also, if you look at
> fit_image_load() it reads an image of a certain type out of an
> existing (containing) FIT. So we already have images within images.
>=20
> How about I just put a data type in bootflow.h ? Then it will be
> separate from image.h and I'm not blurring the line any further
> between an image and its component parts? We can always change it
> later if we find a better way.

Certainly somewhere else, and then lets move this to the part of the
conversion on patch 23 where I suggest another way to handle these
issues.

--=20
Tom

--XiFkTTEnScqSaBfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSqW8ACgkQFHw5/5Y0
tyyEoAwAmINV9OQyKQysCuoABD8mXUCkN1S6k5HS2IFeiJ2JLnTQd1IArQTACdfX
04K8pYEQOUXlK2eRuyd1YDyTQJIKAYNNyVp+iqtDLMPKfQJg58J5mLDLQWijcX7w
7JGYxlNvALJfwJP0IRxx7yUkvPFbCJpbEeDlw+NsgXdeHwOs9quHuSp4JqV5gQ/S
KxBBeYrjxxQaEydFxVW4sI1SBGjFlCGRNXG9z0THV84DTIBnA+7XdVjU9QQ21hN+
OQfzpCOWgpQn7jpvJUC+GDc/ME3apiZmQUZHd0d0m/QfdksYBeyRYHqxfVc1OanN
wnjFqBrGQcMKvAQNuAaZSQsQBbrnWBlUvuAEskgnLZfuAv5Csc68exVK+rEyj6XE
ogyyDWczekVebG3TXOq7abKC81laX+rbXwCQrS6/yeWkyJy44H4eSN7P0+9ulk2V
e7FftHwkMjHGI5AeRheHlxcxZY1Bae3oITZbZW2Os59lj0FJlHmaFUlQFskCjQgY
k5vlVuSZ
=9dqG
-----END PGP SIGNATURE-----

--XiFkTTEnScqSaBfA--
