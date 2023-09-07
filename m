Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6BBEC8758
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 19:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1CB869CA;
	Thu,  7 Sep 2023 21:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A1pyYdvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF86869B5; Thu,  7 Sep 2023 21:40:55 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22686869D7
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 21:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ab244ef065so918500b6e.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694115650; x=1694720450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=79geGhybYkXImjNe8XGgWA/JcdYEgIeJ62xyQWE86sg=;
 b=A1pyYdvJRck/p1hjj8Sc83BRmbEnhZ7l00piQSGZGy3f6S2VJsezSs1yvfIOfSYEgZ
 BYXtIFRZ5O3M6rZOVzwswwSqXyWOACuPsGcqRg3mpvENQ6I+u0lKBpyOfuPfYcXSel2Q
 RVWz1Qln9fciuGRRV7E9TFPN7AMdzU2s6XJDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694115650; x=1694720450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79geGhybYkXImjNe8XGgWA/JcdYEgIeJ62xyQWE86sg=;
 b=YTIDDpVn8x2YWw5VPjn1TT+N/yaBIVSunNUJq6bR18QXH0xarVICaKBz1gjFT75jFC
 X2rP59YaK5RYRzi3tjuWt1oD9KXy7J5LU4NOaixhMPSmpSwS2vIj3nPPRKFl5qi16+7/
 kWpEXwutzKg5Iv52lItiu0ckGCmOnjp3wEk8c11T0AbguK/rFQbxEdea4msAZXvRYZ0Y
 jOcCJHmt1/SCaCeSu1YZcaPXERxEbvjtoNFH0UTlsWqiaoWdBKag3qlIZPJ5uitXz5ti
 IopkL91Sc5VQg/O5DtGuPYqXtCA91iUDx9znBrPZVa3G/azEfdjUcbhoH77PHHdU7fyq
 hySA==
X-Gm-Message-State: AOJu0Ywg0ye4gDWzP0Ehgy9PjaxYzYd1uF2CqXlRA36wy+LGPZz/F2nV
 2PIo82iWAkun5b6HihCvaETt3Q==
X-Google-Smtp-Source: AGHT+IGWZF5x3W8Yz327AZIxeUH3KXsPXUDdS3VatGequhpUBbsf1KIjom5oo3cX1A3fH7IO3GFHqA==
X-Received: by 2002:a05:6808:abc:b0:3a7:2693:3293 with SMTP id
 r28-20020a0568080abc00b003a726933293mr557843oij.16.1694115650638; 
 Thu, 07 Sep 2023 12:40:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 r83-20020a815d56000000b0056d51c39c1fsm38789ywb.23.2023.09.07.12.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 12:40:49 -0700 (PDT)
Date: Thu, 7 Sep 2023 15:40:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Message-ID: <20230907194047.GZ305624@bill-the-cat>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
 <20230903192522.GZ3101304@bill-the-cat>
 <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
 <20230906175755.GI305624@bill-the-cat>
 <CAPnjgZ3LAtZ4V7hwwnBzHBu8=HBroQzTb1XuHV-7aBrkrxS6yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iEk6AOxxe71No9wg"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3LAtZ4V7hwwnBzHBu8=HBroQzTb1XuHV-7aBrkrxS6yg@mail.gmail.com>
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


--iEk6AOxxe71No9wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:23:06AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 6 Sept 2023 at 11:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 12:16:56PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 3 Sept 2023 at 13:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > When lmb runs out of space in its internal tables, it giv=
es
> > > errors on
> > > > > > > > > every fs load operation. This is horribly confusing, as t=
he
> > > poor user
> > > > > > > > > tries different memory regions one at a time.
> > > > > > > > >
> > > > > > > > > Use the updated API to check the error code and print a h=
elpful
> > > message.
> > > > > > > > > Also, allow the operation to proceed.
> > > > > > > > >
> > > > > > > > > Update the tests accordingly.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > [snip]
> > > > > > > > > +     if (ret =3D=3D -E2BIG) {
> > > > > > > > > +             log_warning("Reservation tables exhausted: =
see
> > > CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > > > > > > +             return 0;
> > > > > > > > > +     }
> > > > > > > >
> > > > > > > > This isn't the right option.  Everyone has
> > > CONFIG_LMB_USE_MAX_REGIONS
> > > > > > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > > > > > >
> > > > > > > > But it sounds like what you've found and fixed is an underl=
ying
> > > problem
> > > > > > > > as to why 16 regions isn't enough in some common cases now?=
  So
> > > we could
> > > > > > >
> > > > > > > I don't think I have fixed anything. But I'll send v2 and per=
haps it
> > > > > > > will be clearer what is going on here.
> > > > > > >
> > > > > > > > possibly avoid the string size growth here and have a comme=
nt
> > > that also
> > > > > > > > matches up with the help under LMB_MAX_REGIONS?
> > > > > > >
> > > > > > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbo=
x is
> > > > > > > about 400 bytes. There seems to be a lot of code to save not =
much
> > > > > > > memory.
> > > > > >
> > > > > > What do you mean here?  The alternative is not unlimited ranges=
 but
> > > > > > instead to define the limit of memory regions and limit of rese=
rved
> > > > > > ranges.
> > > > >
> > > > > A better alternative would be not to limit the number of regions,=
 IMO,
> > > > > i.e. have an array of regions that can grow as needed.
> > > >
> > > > That's not something that we have in the code today, however.
> > >
> > > No, I do have an arraylist thing that I plan to upstream, which could
> > > handle that.
> > >
> > > But for this series, what do you think of the memregion idea? I am st=
ill
> > > unsure of the saming we should use - see Heinrich's comments too.
> >
> > My biggest worry here is that we're papering over a real issue, and
> > should either dig at that and see what's going on (should something be
> > coalescing adjacent allocations? Were many platforms just right at the
> > previous limit?) or just bump the default from 16 to "64 if EFI_LOADER"
> > and then see if anything else really needs tweaking / cleaning up in the
> > code itself.  I know Heinrich has previously said the LMB system could
> > be better (or something to that effect, I'm going from memory, sorry if
> > I'm mis-stating things) and I don't object to replacing what we have
> > with something more robust/smarter/etc.
>=20
> I am not sure...my series was designed to rename the code to reduce
> confusion, and print a useful message when we run out of regions. It
> does not paper over the problem, but actually makes it more visible.

Well, "papering over" maybe wasn't the best choice of words on my part.
But since the series of events was something like:
- We nee to use LMB to cover my U-Boot regions to address a handful of
  CVEs over arbitrarily overwriting U-Boot at run-time.
  - AFAICT no platforms suddenly ran out of LMB reservation space, but
    maybe I'm wrong?
- Someone noted that the EFI subsystem was exposing the same kind of
  issue.
- Heinrich adds logic for EFI_LOADER (iirc) to also add allocations
  there to LMB
- Assorted platforms start changing the max allocation to 64 to fix the
  problems that get reported sometimes by booting.
- Heinrich notes that our memory reservation system (LMB) could be
  better designed than it is today.
  - And, iirc, EFI_LOADER or similar has something maybe we can
    leverage?

Which brings me to what I was trying to say.  I'm not sure it's worth
cleaning up the code a little, or refactoring/renaming things within it
without both:
- Understanding why EFI_LOADER being enabled causes us to run out of
  allocations and so if the answer is "increase the default" OR "fix
  some underlying issue such as coalescing being too strict or broken".
- Understanding if there's a better memory reservation system we can use
  instead.

--=20
Tom

--iEk6AOxxe71No9wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT6JzwACgkQFHw5/5Y0
tyywrgv9FN15FeQy7zBfTW2HJOumWnC/GlFvPhbxftdhM9muxQ4Y3K5X2jbvTYgj
33zMGCAZr9Em83+RO2cHN9XWQmfQHqzoMkmBptU+8ceEyCWQ9PY8bL1Eu+LTV+6J
te/QtsOIpbrWas+fyZcYweVCcgVz6PdZ8Xl78+lywilUQF/gUxWQEu8xA9jxEJCl
bBNZ2AyVhvfyhoGAc8BEQ2/VQP4ldVIbPpx/g4a84XqiT/o27TfFhWW/g6Q9seiS
IKEFgJAdQDmgDssu9uhG9zJq9/5TLx609a8PAtMOKjppq4ZVfo1odfDo30MjtRnO
sUzNt4uRIamxD2dZ1blDo/7OauReH/2pM32ZKSB1+Rj0lkjeNkWt/BNHMtewLy5w
BbRT75ClZIfBB5OqqK7hc2LIaos1XwnG6ieyeLvfshq1VXdtcvekRYrEfkG+r7Kj
YpYtd3QLeczZ9nOn4Ho4dksW5RRs46TsSHY0aHSdvMk6QI4b+IoOrAcLsLhZM/PW
p09+56YX
=7yjE
-----END PGP SIGNATURE-----

--iEk6AOxxe71No9wg--
