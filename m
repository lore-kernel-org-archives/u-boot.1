Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51859E64AB4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29C188FB5;
	Tue,  3 Dec 2024 15:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MDMYYt5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E13089048; Tue,  3 Dec 2024 15:10:00 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC54688F55
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4668cec51afso46113201cf.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 06:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733234997; x=1733839797; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gjxWd6XMqhrqfgCsCkVVL7h8jvbXc/hY/ah4VRWcA/w=;
 b=MDMYYt5oPR08trWH+bp6WbaU6nGUn0HesHRK+wrAq7cPPbvGB/ZE4x6pngwNXcoNkZ
 +4gFRtZa3IBXrcYFwou6NFC3GMCd1r9WlZE5BOTeUOqW54AWHtLQejQMHQ385iJ1URxM
 gZ8eLmDgp9zq85blnxy2itz9rhjtHOo7BdNYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234997; x=1733839797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjxWd6XMqhrqfgCsCkVVL7h8jvbXc/hY/ah4VRWcA/w=;
 b=fntmqCKQ7NzHRUkzSx1+kkBKZnFyVSpIn3ZQqWQIbhslpEXvAx5RHcGRezbPfeMzQ9
 cq3cVdkJsBO5DBIEaVlgxeYYUfFpUoDaY0d4+22JvBCPfoXhdy4P8goE542StFm5fEiy
 XfxaIlEhNsZ9Ij2QQwbvYfN3iK+OYk6a9Wzb5iExi20eHwjZzYfYlegtrnZTd4nx03L6
 bCunEuAn3JfaG8f9+OU1nlW0Tc7u8r/PvDq/e8//TnOvJSGLPLgFWBun/ne32HqfBJK3
 09I+G2foIjV90wiWwu1uwgDDno3LyRcLX4SaZnR2bXPNoApo5Fw6A4hejdm05gfJ9FZB
 KQSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz0epECbcvoSbaXNCX+j3f1yeiOjxkCgCdSBLNbOB3wmolx13cgPn6+/8nK0lLWKD7fRQgAaA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi6hpFB5tMKjo/JTZEgxf7nk19Y/zGVpotAWQJBUenOOZ3LyAE
 pW2C8+2zPM1vMgXsGmyUX1ZD/0pnNsnky69qhbRswWgMmecf+LEhsv5hqBp3bzg=
X-Gm-Gg: ASbGncummP8WT9JLvnFyvg8aDfZj4oRpQED5PZGCz/LWzzI5jAI9EvallbR6eYAZJZC
 kGLEaJTwqDjjwvuEQ+OKQR7f+yR1OciohRTOqhM+QnM4i7Qd1uwv96LZXUPC3fYiARkUr7gDNjA
 4BLqapHRvd4xxOqNQSGFcL6FDkFEqyNu7sNCeOjh9WY0+o54eQ2v1UQ4IVaJ7EI1JN5QEvjR4Qh
 Yhqg7yHrNLb9MjVukGjvFpvn1WQ+22bRkH6xMUK4VrBHyaUPg==
X-Google-Smtp-Source: AGHT+IHOPF72Wd+LbVfoAaxi+pJZgPVL5XRERwHNJtOYlHcY/krhbWI9+YMn0OcTzhZNJLMSTAd5Jw==
X-Received: by 2002:a05:622a:10d:b0:464:b9d2:b51b with SMTP id
 d75a77b69052e-4670c0a604bmr37895151cf.27.1733234996661; 
 Tue, 03 Dec 2024 06:09:56 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421ef6esm61840781cf.57.2024.12.03.06.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:09:55 -0800 (PST)
Date: Tue, 3 Dec 2024 08:09:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
Message-ID: <20241203140952.GV2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
 <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
 <CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com>
 <CAFLszTiMi89uydJUmDg740opTJXm0YJ8WUQ5aJPwxPnb+9EGMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uI4q456aWrvNdvsp"
Content-Disposition: inline
In-Reply-To: <CAFLszTiMi89uydJUmDg740opTJXm0YJ8WUQ5aJPwxPnb+9EGMw@mail.gmail.com>
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


--uI4q456aWrvNdvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 06:45:58AM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Tue, 3 Dec 2024 at 01:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 3 Dec 2024 at 02:22, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
> > > >
> > > > > Some functions are passing addresses instead of pointers to the
> > > > > efi_add_memory_map() function. This confusion is understandable s=
ince
> > > > > the function arguments indicate an address.
> > > > >
> > > > > Make a note of the 8 places where there are problems, which would=
 break
> > > > > usage in sandbox tests.
> > > > >
> > > > > Future work will resolve these problems.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Please just resolve these rather than introducing a patch to then f=
ix
> > > > them later. This is something that should have been fixup'd before
> > > > posting. Thanks.
> > >
> > > That was deliberate, as I wanted people to see the problems. It will
> > > save discussion on later patches where the problems are fixed, if we
> > > can agree that these are actual problems. If people are happy to add
> > > review tags to the later patches then I'm happy to redo it.
> >
> > I am pretty sure Heinrich has repeated this in the past. Why do we
> > have to sprinkle around map_sysmem/unmap sysmem for sandbox?
> > Polluting the entire u-boot to support a special platform is less than
> > ideal. Why can't sandbox limit this internally and do whatever
> > mappings it needs when it receives an address?
>=20
> Tom, I suppose I have made my point.
>=20
> Ilias, this is documented at [1] and has been the same for 10 years.
>=20
> See for example the 'md' command, do_mem_md(), which shows how 'md 0'
> is implemented in sandbox.
>=20
> As I have mentioned before, the nice thing is that you can easily make
> code work with sandbox just by converting casts from
> address-to-pointer into map_sysmem().
>=20
> Back to this series, if you look at efi_allocate_pages() you'll
> currently see three calls (two map_to_sysmem() one map_sysmem(), but
> now, with this series, there is none. It also makes it a lot easier to
> understand what is going on, IMO.
>=20
> Regards,
> Simon
>=20
> [1] https://docs.u-boot.org/en/latest/arch/sandbox/sandbox.html#memory-em=
ulation

This is something I was wondering about yesterday in fact. Especially
these days when "everyone" is developing on machines with 8GB or more of
memory, why does sandbox not just malloc 512MB/1GB/2GB/4GB (make it a
switch?) and pretend that area is memory starting at some address.
Especially if it's less than 4GB and starts at 0x80000000 more "memory
starts at 0" bugs would be found and fixed. I swear we did something
like that in my OS class 20+ years ago. I'm not sure what your link is
meant for, as it doesn't say why sandbox works the way it does, merely
that it works this way. Not that it can't work some other way.

--=20
Tom

--uI4q456aWrvNdvsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPETAACgkQFHw5/5Y0
tyzNtgv/b+VsdT9GqTGdYdvMWLsD99TXzDTnHuwwU+QZtCXk3G2U78LdaVsVX5f4
TNSqH4wA4Mddf7v8lg8BXBlDYPO7w0UcP7YU66xwymhm4PMqqDb9ivcRL7Wht1l8
kYei2e6et7cJqkajIqE6nK29eNmiX89pfzry8WAI3DbLa2CuVgeWewfJ/i+4d55+
vdIVeXwmrOpHw/mLwM2Cu2RuVMgA6tHc9LKfbYsndEjO6KeVwKah6Cm/UUEwrnom
24IghYObr6X2JZHRSxzPQOerR4PWfaPUgcYeDCstsqAtdGnxZw1yn3LwJYLbzbVD
talBCColXT4Suc7wMp2um/Nd5cCC3I4GcCyGnR/MrMwLvusg++NJAbXytygSk8W4
6J+5dTuuSWbF81KnJr1ROg7Tl5fg2yIjjww/pKaxFXor4Ortswd6tZqew0IwNrm7
RW5koEmhCgKYwwI613xNT5exIV6FrCA3hFV1Sq7qssjjAY6iWdJhP7qM5MjP6pIZ
b88I4d7G
=aETo
-----END PGP SIGNATURE-----

--uI4q456aWrvNdvsp--
