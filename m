Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622C1CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB3A848E7;
	Mon, 25 May 2026 17:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h8wYn9CB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C623F848E7; Mon, 25 May 2026 17:46:29 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6639C84859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e61e25199bso720410a34.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779723986; x=1780328786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YfoGTuAAWQI0ejHZfXrp4ylMfm9PPPiqONB1ebWa2+g=;
 b=h8wYn9CBi2Gei3TIkuwIWM4uYZMS65/OQbuKGRtaJZh+WiexeYq9CcCCpWbHEeFgKJ
 neMQo/gxxNgtDgpJ1n5x4x4ORD6ySkl2EuZdeOUk41+6YKXxHy9JlpGF2ovNVnZUJ+Ib
 /MFsj2O/BYcOc/UdiwbAUAdHQuH9ij/d6iWgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723986; x=1780328786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfoGTuAAWQI0ejHZfXrp4ylMfm9PPPiqONB1ebWa2+g=;
 b=KUV6pS4R4nvi9+urz+2HY1dU6qWRWjKBDcGd10aT9Ibci3RnCsM/Yg2RYBw3NVftjn
 y/heI5GCow3r05bncKzUo+wDomES/vHSbKjkWpwKNQQHuTt84WlIOyYBninF153SP0JL
 Cpkrgct748lt8/uPdmh2jLgN5nxKCr66XvZFwrptJ7Xv65qdHvfhL8WQDLpOd6R0Jztd
 VxxKVMf0MskcTTHQFlHOKfFEao3jZHc9dNtCjAVx48iFY7iKv6QHTmAzFH20Y1uJxBEC
 RhF4/GLlQ4IrTsNzrJHKZcNkzZirvHWsnNflrQLt+pNRFH7s5Kw+Rr75h4jsDzH4WY/J
 6XtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jbIeCLqlkI3tafo0gZzRvOMnubLuIYwzFtYKqaSayBZ5gTV1dBfCUzN/4LMuI8c4ALFUelfk=@lists.denx.de
X-Gm-Message-State: AOJu0YyHLDuyX7LWok2WtjtrJomoIFrzQdB7RB+mzvLQY9QBH7ZmP6td
 DP5iNRQW7qVs7JCPx+PcG6F2bw2DsLY4ndojnPTozlae6NQA9d/DXBb85myeTqwmMQB9oSbRmDb
 W6KJAajE=
X-Gm-Gg: Acq92OHJnJX6WRE1mydfJhony5BYzJKgvUtgv/PznhgBGj8W3x0QxGWGLi+sA3Ys68X
 02Kv/AM9obaCpTTWy9C+jieYtDsWMePPWpyZWVE7hcNAI2LcvFm+qdU5wxU4q7ntoNfeSFCzh7g
 WLZAaBFa4PhDd/nIP1GhUGVTE5lgy/Tg1gDMQxS6aEi1vnvMDfP63AaFHROUp6MgRLh016CInGT
 YyRKIEqmNcc+iQiZKXIu56kdf2OAGXwsbYzS0vWGlYBkdLvTGPGWiqEJRW+6Oiq9Oer+uWlNDX+
 wlVAafWF9yD9wj1uOnFa4d7JtBzDAMXa8LsasI/tLaz7mFdU0RzoXclRvgcWAuD1yWvxeTzGoer
 n9kWpRlo4EXz33gEvCsLZQ+hzvbB8oSYicYccMTSbPFu2fzjmAiUVj8oST4quI7ejsYcvYwmcj2
 t+yaegXTfBxmCpLAPh8iC8/+YVpZUE/Fo3i6/v0YVEO2ojHRjXr3NpZYSc3/Me2yhQ1Ql5l5fub
 GJb/egc31nqz+vnH9GsQPmKz9rmW2X1eSq+QYMZXRvqfg==
X-Received: by 2002:a05:6830:82e8:b0:7d7:fcac:6374 with SMTP id
 46e09a7af769-7e5fecedad3mr8293245a34.8.1779723986094; 
 Mon, 25 May 2026 08:46:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm7410464a34.23.2026.05.25.08.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:46:25 -0700 (PDT)
Date: Mon, 25 May 2026 09:46:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: ravi@prevas.dk, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
Message-ID: <20260525154623.GN1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-3-ravi@prevas.dk>
 <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
 <20260525152254.GM1858239@bill-the-cat>
 <CAFLszTg5QevFu2C9GvMazd4ioi9msvjiFy_rK4on_YfXHki2zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="thFhweD1QA0Ok7l5"
Content-Disposition: inline
In-Reply-To: <CAFLszTg5QevFu2C9GvMazd4ioi9msvjiFy_rK4on_YfXHki2zw@mail.gmail.com>
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


--thFhweD1QA0Ok7l5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 09:33:24AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 25 May 2026 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, May 25, 2026 at 09:02:02AM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> > > > linker_lists: Do not set 'unused' attribute
> > > >
> > > > Whenever we declare something to be in a linker list, we want it to=
 be
> > > > included. This is why all of our linker scripts have a line similar=
 to:
> > > >         KEEP(*(SORT(__u_boot_list*)));
> > > > to ensure that any linker list found in any of the archives we are
> > > > linking together makes it to the final object. Remove the places wh=
ere
> > > > we set an attribute saying that it is unused, or maybe_unused.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > > >
> > > > include/linker_lists.h | 9 +++------
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >
> > > > diff --git a/include/linker_lists.h b/include/linker_lists.h
> > > > @@ -69,7 +69,6 @@
> > > >  */
> > > >  #define ll_entry_declare(_type, _name, _list)                     =
           \
> > > >       _type _u_boot_list_2_##_list##_2_##_name __aligned(4)        =
   \
> > > > -                     __attribute__((unused))                      =
   \
> > > >                       __section('__u_boot_list_2_'#_list'_2_'#_name)
> > >
> > > The commit message conflates two unrelated things:
> > > __attribute__((unused)) and __maybe_unused are purely warning
> > > suppressions; they do not affect whether the symbol is emitted, kept
> > > by the linker, or seen by LTO. The thing that prevents removal is
> > > __used (and at the linker stage, KEEP()).
> > >
> > > The real reason removal is safe is that none of these declarations
> > > would have warned anyway - ll_entry_declare()/ll_entry_declare_list()
> > > produce non-static externals (no -Wunused-variable for those),
> > > ll_entry_start()/ll_entry_end() take the address of start[]/end[]
> > > inside the same statement expression, and the symbols from
> > > ll_start_decl()/ll_end_decl() are referenced by the caller (cmd_ut.c
> > > is currently the only one). Please reword the commit message along
> > > those lines; the KEEP() stuff belongs more naturally with patch 3.
> >
> > I don't think your analysis is correct. They are not unrelated things,
> > they're very much related and were really incorrect at introduction a
> > decade+ ago (and pre LTO) but I don't think it was worth adding a Fixes
> > tag.
>=20
> I mean that the compiler will warn if you declare a static symbol but
> then don't use it in the same TU (hence the need for 'unused').
> warning !=3D inclusion/removal. I haven't quite figured out whether
> those warnings have gone away, or something else has changed. It will
> be easier to see when I can build this branch.

It has always been incorrect to have these, and there's no real value in
having more commits removing incorrect code.

--=20
Tom

--thFhweD1QA0Ok7l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRuywAKCRAr4qD1Cr/k
Cj3JAQDWcCi2flfU9nVNTXOXe7T479sC9Ulgl31BZLhSBDzRWwEAvuRYLwYqp07Y
CsZJ5bmxTjMU0HnCyJoaDcN4JRmaeQw=
=dH/k
-----END PGP SIGNATURE-----

--thFhweD1QA0Ok7l5--
