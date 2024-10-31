Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9C4D767F6
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0E68929D;
	Thu, 31 Oct 2024 19:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jo9Jw9iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0AF89293; Thu, 31 Oct 2024 19:28:36 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6903688B9F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e29687f4cc6so1028846276.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730399313; x=1731004113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/JmUdDQmk5CDA54pXl93jqilnu8Ub61Gg6dezgD2MtE=;
 b=jo9Jw9iyUx8i7v3YR4aTpbkZnW3oH0eGFFJmz8dh3tLC5E2Xul0+S6m/pKKYeljj6t
 9Arw3FsdjrHb+1goF2h33i6GduLwi6UTL4Lt4Mz2d4PrUOP73vQa8U61pgi6naTFNlLG
 Y3VhSup7lhgmZ9Ps/bS9bzhTdoRV21U3u5kb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730399313; x=1731004113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JmUdDQmk5CDA54pXl93jqilnu8Ub61Gg6dezgD2MtE=;
 b=DZxcbycOOARq/w2Un/p/UfgxvLHQruaBYBvN01S6BuAQcFBHNMG5V6xpfYDomj5HVG
 OXI1bhl5++gu7wZBiIZ6RC7AnmhVpXXeyMmkyPdLz7g3OqVU4gOf75TW2jMwf+lIWukS
 qP3kTc/xiTGz134Xoop26tVb16w2RWJuL80luTAVf1+d03KJ7EjQBIzLv8HwhqMEgonj
 8tCkGnpKGJdk9PlS0cP7EM/QHha5nXUE9qBNqATVGaBDGnFEXG/cQ0/b/BTnmaAOVxNS
 tabTT//dnvlDEYFCU/fw5JGoiNxtd0HJI/myLD6+s+eLAHTf2u0J7+N6TYAJW8Imn+7k
 9s4g==
X-Gm-Message-State: AOJu0Yxwv3qPcEnSsvBDXFZp9FHduHv7GvwvVRigAASkC0aUP8LVy0Z7
 Te1IOwTS1ifCqVvg4HJSRqAK/GA+PHZFWlhul07JPu+/IQcdRcHbgU7hwbo4IhY=
X-Google-Smtp-Source: AGHT+IHi0/0kysWb72+rg3+R5zWmoPUaDai7bbEJjTCDQF3+0MQy7YlXM2I5qZnimmBnMZx97GzRDw==
X-Received: by 2002:a05:6902:2b0a:b0:e29:6571:b107 with SMTP id
 3f1490d57ef6-e33025b5d7emr892822276.32.1730399313135; 
 Thu, 31 Oct 2024 11:28:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f7ec5sm94729885a.37.2024.10.31.11.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:28:32 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:28:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 01/11] test: Allow signaling that U-Boot is ready
Message-ID: <20241031182829.GB3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-2-sjg@chromium.org>
 <20241029235257.GB2558755@bill-the-cat>
 <CAFLszTjBbODQh+Vv=3cckGUyRt2MwXnLQKFcpyMVSgFzB67gWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MrAlUpyMt/PALtZJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjBbODQh+Vv=3cckGUyRt2MwXnLQKFcpyMVSgFzB67gWA@mail.gmail.com>
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


--MrAlUpyMt/PALtZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:00:10PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:51:35PM -0600, Simon Glass wrote:
> >
> > > When Labgrid is used, it can get U-Boot ready for running tests. It
> > > prints a message when it has done so.
> > >
> > > Add logic to detect this message and accept it.
> > >
> > > Note that this does not change pytest, which still (also) looks for t=
he
> > > U-Boot banner. This change merely makes it possible for pytest to
> > > believe Labgrid when it says that the board is ready for use.
> > >
> > > In several cases, the board starts up and Labgrid receives some initi=
al
> > > output, then pytest starts and misses some of that output, because it
> > > came in while Labgrid had the console open. Then pytest fails because
> > > it doesn't see the expected banners.
> > >
> > > With this change, Labgrid handles getting U-Boot to a prompt, in a
> > > fully reliable manner. Then pytest starts up and can simply start
> > > running its tests.
> > >
> > > But, again, this does not prevent pytest from handling a banner if one
> > > is provided (e.g. if not using the Labgrid integration).
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I _may_ see this myself sometimes, but I'm not sure.
>=20
> OK, but it isn't really necessary for you to see it yourself. I've
> described above the repeatable problems I have with this approach.

Well, with what I just now said in reply to v6 of this series:

Reviewed-by: Tom Rini <trini@konsulko.com>

So long as v8 also includes a much longer commit message.

> > But I'm not sure
> > where the bug would be between us and labgrid. Looking at
> > test/py/u_boot_console_exec_attach.py we grab the console and then reset
> > the target. If the spawn hasn't completed, especially before the power
> > cycle has completed (which in labgrid defaults to 2 seconds) we perhaps
> > need our own delay. But as I'll point out further on, NOT counting the
> > banners means we aren't able to verify other functionality. Even if they
> > are tests that I think you don't like because they verify the
> > functionality of resetting the device.
>=20
> Yes, that's a use case that needs special support. If a board is
> booted from USB, then resets, it will run whatever it can find,
> perhaps just hang. Labgrid doesn't know the board is resetting and
> cannot therefore ensure that it sends the firmware over USB a second
> time (or sets the recovery line on the board). Resetting a board works
> OK using SDwire and some other cases, but will fail on quite a few of
> my boards.

It is indeed tricky matching up and catching everything given the number
of platforms where it's technically possible to do CI on the firmware
but practically a large complicated pain.

--=20
Tom

--MrAlUpyMt/PALtZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjzE0ACgkQFHw5/5Y0
tyxqnwv+P6HMNbUjWFR/TVvFmcf7gQar2HPdcz4LflJt4W5umN89fzCu26+cC0gQ
VMkyClKZrmMjwpEq5lXNlmdCsQN8X0G0tUw962rSWu7a3WHMtI8M7SrdBoEwZ/3v
sjV3CEhrOyfNprUk3H172VNVi0vlkviweZy1lGoXfn6X1yLGd34REFQ2efdWXR9f
8uvRjovQlalBk6mfRhDdQXyWX5cTvnMUI9KeVXHZm0hHh8mfwqvhTD9tlKkzvlYo
325Jcy4y5ZEBlOl0s6dwU8A8iDDbuEnEmzym4dWOEocIF4X5mmbRsLwUAttFyZGf
Azg0Zy10Er/99ILknoKtVsCezkTwnz0qSf2GEGcJOwCNzcL9eH4QXyLgzxjSaxhN
fv0gn3r9e7JpCj8lwd4JWRlYKnlzthi+k0ipCt7pTaUr/+phVn1tG6CIQYbq37bD
SXOfkxqHoNIv3OuEkqzi7lSSMD7xpNZSSIk4yTk9Om/vnb+24SAo4RVuKVJZFOrK
ouRwOB/N
=n7Yk
-----END PGP SIGNATURE-----

--MrAlUpyMt/PALtZJ--
