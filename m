Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707AD3DEA4
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE1F88D9C;
	Fri, 18 Oct 2024 19:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSbBm3mC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBB788D9C; Fri, 18 Oct 2024 19:54:49 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC88D88BEF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7181eb9ad46so385211a34.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729274085; x=1729878885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yaXO7MQoeJ9k/eEKE916Hl2r1qnl7kXfCV9f/X0SdlQ=;
 b=YSbBm3mC/QIjyGwAVv5IDZQzrEIlf920mZD5WMq2/kiXBwiz5Nt+Cty4P0AR18A4bQ
 3bR8t5xyr10ry4SsEoxn+r0ECZFUaasKBSN4YJQnRM5a7xrWY7GtDj1nbbiRv2xbgqJe
 qTJ082e4x7blGxkuUi+nvrWbKnTjYd82iRC3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729274085; x=1729878885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaXO7MQoeJ9k/eEKE916Hl2r1qnl7kXfCV9f/X0SdlQ=;
 b=LLWv+1/j8bJCLyXZ2w6Z8+FlkKHBnshu3yib2GTomrXkjlwqF2PNpFAvyHXZs6BZwr
 K+NkbVQr/SiUt3K0pMBXCxXJ+nLetqnz4ANzRVKzGg8YteSC0HBwe7ZbuMBSPC8s8VL3
 aJYpzl8lsqYHjcawOnmNUt1k7RQ+NaNhPBYoM4dfG2mV9uchOPCYBWbxZL9GU2GVjXXp
 Pu6xGOiAw2XJs27ozl+ZjnCpQK67sZXNZ+DjDnJd/gK1ZbCretdfG0apQoLK0YEpr4Nv
 4OwFMgnyWYd9CTfUdJznxzUXktRuomrWKNK55HFNcdYKTNKjRX/KssrAI3L6HdYAm/jf
 4Fvw==
X-Gm-Message-State: AOJu0YzugQRP07pkezJN96qdLqrG0KnIHRyC5ckdYonyPenzUbeoQjbf
 ljlU6z230/YCZ9/PnCgI3/S4PjDlK3Mt+NzgkPWKrHCmPZtfmGzLJ0J3nK7S8mY=
X-Google-Smtp-Source: AGHT+IEYSSkV6f7XEEBPt9gcc1S2Yvq6Y93ZlB5DDigMQZNOM095j7d32Yji5s5jBC4sdvusUOUGYQ==
X-Received: by 2002:a05:6358:6402:b0:1b5:f95a:5a67 with SMTP id
 e5c5f4694b2df-1c39dfe0982mr179534655d.15.1729274085444; 
 Fri, 18 Oct 2024 10:54:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156f98ecbsm89378585a.35.2024.10.18.10.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 10:54:44 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:54:41 -0600
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
Message-ID: <20241018175441.GC4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
 <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
 <20241018151753.GY4959@bill-the-cat>
 <CAFLszTjwNK+4fH_x2ZDkamanDjFJCtgXFD+d9gTruZs7gLvfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k4jZNY15hEsCTszU"
Content-Disposition: inline
In-Reply-To: <CAFLszTjwNK+4fH_x2ZDkamanDjFJCtgXFD+d9gTruZs7gLvfZQ@mail.gmail.com>
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


--k4jZNY15hEsCTszU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:20:45AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 09:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 08:57:02AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
> > > >
> > > > > Add an image type for the extlinux.cfg file, which U-Boot supports
> > > > > reading.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  boot/image.c    | 1 +
> > > > >  include/image.h | 1 +
> > > > >  2 files changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/boot/image.c b/boot/image.c
> > > > > index abac254e026..cf16fb7fbf7 100644
> > > > > --- a/boot/image.c
> > > > > +++ b/boot/image.c
> > > > > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] =3D {
> > > > >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image wit=
h Flat Device Tree ", },
> > > > >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Im=
age" },
> > > > >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image"=
 },
> > > > > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux con=
figuration" },
> > > > >       {       -1,                 "",           "",              =
     },
> > > > >  };
> > > >
> > > > This whole part of the series feels like we're abusing IH_TYPE_ far=
 past
> > > > what it's used for. Especially the command line string one. It seems
> > > > like the main use is to be able to later on print something human
> > > > friendly. Please try and figure out some other way to do that. Than=
ks.
> > >
> > > Yes I had the same thought, particularly with cmdline, as you say.
> > >
> > > The obvious alternative is to just have a string which communicates
> > > the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
> > > string indicating what it really is.
> > >
> > > But one advantage of the approach in this patch is that, for bootmeths
> > > which include a cmdline, it can be identified and added as a file.
> > > That includes zimage and ChromiumOS, but not EFI. It will allow me to
> > > get rid of the cmdline in struct bootflow, perhaps.
> >
> > Yeah, this all sounds like IH_TYPE is the wrong direction to expand.
> > Where you're grabbing these things from is where you might get a hint as
> > to what these things are and that's where to take the store the
> > knowledge for later.
>=20
> They are grabbed from several places:
> - extlinux comes from disk, with the extlinux bootmeth, but can also
> come from 'include' files within that scripts, also pxe
> - EFI apps from from disk with the EFI bootmeth
> - kernel, ramdisk and fdt some from most bootmeths
> - cmdline comes from extlinux (with zImage only) and ChromeOS,
> probably Android but I haven't looked
> - logo comes just from script so far, but I suppose UKI and FIT will
> have it eventually
>=20
> Can you be more specific with your suggestion? I am not seeing an
> alternative right now.

I'm just saying that this is not what IH_TYPE is. As you said maybe you
can store this string information elsewhere? And I'm suggesting that
perhaps when you load a thing you'll then also know what the thing is.

--=20
Tom

--k4jZNY15hEsCTszU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSoOEACgkQFHw5/5Y0
tywUqwv+OucJESRSW968xHCo9RLR4PsjYZAifxmQo1xLPtzpO+DT2XVsTmmSrUqv
gR1iunQcWsv3Bda61l21mis9NpuKLVlYYt4Ww5aLqznmSqcziNocrq7gNrt17fDt
X17NHNqvTTumRi+V95UYtG5RaotPAs6XW2cT+Iib3AHT4NOyQ8B7yPIPMUcsLRIt
vehQcaC/YkD0CXRV7sAFcQIA3KnKZ3Jq1CQsx5D8Gbwvas2MH1iJk+yFGVaEKcm9
C5syLE1kEzyZEYzwpbYCEkBfAUSX6YnyRU9jlnWfNgw3TGvzzmUGxL/mxM8x7jVg
Gltwmmb5s5QVhS2OGv2zofSOm7428nJzRnc60kf3IycapE2MxI+ebLlh4IUFvTpW
tTYxGQn46u3sU+IjF0UuP1CPqXKbS7d03fBzmii5eKKVruJj4cqGQLZDUIkbNNz4
9WN5aqKmUPH4c1dAwY9ZosfuGrxc74G8qHZ581SQflfM3L4QcqfI6Bm24gSyhi8P
pd8Uj3aQ
=3Y3s
-----END PGP SIGNATURE-----

--k4jZNY15hEsCTszU--
