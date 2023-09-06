Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA6EEE14B9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C1D868BC;
	Wed,  6 Sep 2023 19:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IhY4cAem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18860869CD; Wed,  6 Sep 2023 19:58:05 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE85B866EC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58fa51a0d97so892857b3.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694023077; x=1694627877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=odvI9JPf4gyYyxcVm/c4smdrD5yMNxg69j+iUSJnpes=;
 b=IhY4cAemjtiVRmiT4+rBpFH2MfWmEs8QRybSOqHagn1CXEf45XZp/IpWsbo3mQUp5Y
 KtTjD1Ax1qqdXCNYbhUtVL8fN8mgDxYndv705kI+N15jui18Xir9Nb0K7rh4vSnL3vcV
 0wTlpViMMC3xwti1GT+HgKyfmF4httMI5iQhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694023077; x=1694627877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odvI9JPf4gyYyxcVm/c4smdrD5yMNxg69j+iUSJnpes=;
 b=iuIZ3TlXKG+WZRsPk5ORmFo03iFcyj3DsvhmOMmoLGrjoPa67v7bxhQUF6xFmLMVyy
 GndcCjMkBbhaVilf+dlmC32WpvK443mQVUdLihXhCJSEd3px0ADaoG43XX2VjO7ySCzv
 /gQaCvHjGsu/I83VnULus11pISrJGo+jcJFmXgxD2mPeCIc4gRtIo0Gd0Qsp+LFtCxs3
 nFBh7w4rDPpJPh+Rb2y5UyaIHi/nuUgyc9dF45JU8kWLtJOHAchd+gAxxpD8jQighVJh
 f7HFJq1Z2dplMWzVACy1T/P82bVD1xtAihDWn/2Bvn+ge7ClXeOiAgl0nQ5iBch9Yafa
 88wg==
X-Gm-Message-State: AOJu0YzHbU6wq8AUu4UV9YFrSNTpHfU8vKdA2yCUtGjE4/guRbYVZs9L
 uGEF50q03AvOWApGHqcXI+MNYjylYYhd+g1XjJ5VLg==
X-Google-Smtp-Source: AGHT+IEyg+gTe9YtDd2knQKvGZBzYfRVWW9QWN++fd5OMXeS28a48aRb6FzZQ+wrFrgriVbE5LEbdw==
X-Received: by 2002:a81:8841:0:b0:592:2bf2:6578 with SMTP id
 y62-20020a818841000000b005922bf26578mr15947873ywf.46.1694023077671; 
 Wed, 06 Sep 2023 10:57:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm171759ywa.89.2023.09.06.10.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 10:57:57 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:57:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Message-ID: <20230906175755.GI305624@bill-the-cat>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
 <20230903192522.GZ3101304@bill-the-cat>
 <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/fuTeuYYFf6Kq+4f"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
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


--/fuTeuYYFf6Kq+4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 12:16:56PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 3 Sept 2023 at 13:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > When lmb runs out of space in its internal tables, it gives
> errors on
> > > > > > > every fs load operation. This is horribly confusing, as the
> poor user
> > > > > > > tries different memory regions one at a time.
> > > > > > >
> > > > > > > Use the updated API to check the error code and print a helpf=
ul
> message.
> > > > > > > Also, allow the operation to proceed.
> > > > > > >
> > > > > > > Update the tests accordingly.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > [snip]
> > > > > > > +     if (ret =3D=3D -E2BIG) {
> > > > > > > +             log_warning("Reservation tables exhausted: see
> CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > > > > +             return 0;
> > > > > > > +     }
> > > > > >
> > > > > > This isn't the right option.  Everyone has
> CONFIG_LMB_USE_MAX_REGIONS
> > > > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > > > >
> > > > > > But it sounds like what you've found and fixed is an underlying
> problem
> > > > > > as to why 16 regions isn't enough in some common cases now?  So
> we could
> > > > >
> > > > > I don't think I have fixed anything. But I'll send v2 and perhaps=
 it
> > > > > will be clearer what is going on here.
> > > > >
> > > > > > possibly avoid the string size growth here and have a comment
> that also
> > > > > > matches up with the help under LMB_MAX_REGIONS?
> > > > >
> > > > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > > > > about 400 bytes. There seems to be a lot of code to save not much
> > > > > memory.
> > > >
> > > > What do you mean here?  The alternative is not unlimited ranges but
> > > > instead to define the limit of memory regions and limit of reserved
> > > > ranges.
> > >
> > > A better alternative would be not to limit the number of regions, IMO,
> > > i.e. have an array of regions that can grow as needed.
> >
> > That's not something that we have in the code today, however.
>=20
> No, I do have an arraylist thing that I plan to upstream, which could
> handle that.
>=20
> But for this series, what do you think of the memregion idea? I am still
> unsure of the saming we should use - see Heinrich's comments too.

My biggest worry here is that we're papering over a real issue, and
should either dig at that and see what's going on (should something be
coalescing adjacent allocations? Were many platforms just right at the
previous limit?) or just bump the default from 16 to "64 if EFI_LOADER"
and then see if anything else really needs tweaking / cleaning up in the
code itself.  I know Heinrich has previously said the LMB system could
be better (or something to that effect, I'm going from memory, sorry if
I'm mis-stating things) and I don't object to replacing what we have
with something more robust/smarter/etc.

--=20
Tom

--/fuTeuYYFf6Kq+4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT4vaMACgkQFHw5/5Y0
tyxi3gv+JdN6m/KV+C4k8P0H0Ws1x5ZOSjDwLJVQUsGMGZiA2+fVoqEgKNmA8A+r
ns87TTyMmA+TaG+UOaHsuzH6Qxz52i7j6fC8uyzKMP9aPfFUYJtrIeYqSdWaYr2T
knL0wFWT5vzWbeiCyzrAF4PLqCwPRKF46mzNyW120t9tdpaBiuSrmCIa1PvnWcI7
iuBdBsbS9RNGh3PuJ2zamfhdKFON0rwyhmM4miNocbKsyz/xtOe+4Gu4bnhaY7rA
gGdL6Gt0Hip1XVmuzHZ6W7YulHVgIgHYlroVWsWyZOoEYAYg5kgiGV+h+2dCUzl6
6N2Xy38VY1Oz2YSRLnQ9dk5x2CTBLokLiyao6lbe6KlsWrO4/R8RRD0NeZ9VTR71
YRMO95fpnODaqy04YCqQTiD0pCS03OCIpt/2uzFyTfWVX1dmzSGeJO31ChJzCX9I
8+rWggOwW7aj9dYkGWSStEdurdwG2FoVN9V6c/x9oGgmf6NpDrCafN/L5/OkYIWb
FRiYqb7i
=8m8P
-----END PGP SIGNATURE-----

--/fuTeuYYFf6Kq+4f--
