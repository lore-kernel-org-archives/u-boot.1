Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B40AC61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427F887545;
	Tue, 21 Nov 2023 14:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N+HvYgdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9028087545; Tue, 21 Nov 2023 14:40:23 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D89587253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77ba6d5123fso547722285a.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700574020; x=1701178820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uwh7OHYJVKY8ksWb+fGGYbOk10LaRabxcGYurq1cD9A=;
 b=N+HvYgdZN27AmhSRe3VpPhhDcG3PHy9/Pd7VjcLwhdYc6D87ldA0bn5gpgXu3f0z/M
 kry2b9stR2yXNptfiqJsHL/7UfrETPw75gp3ufjcqXKJocmMufw2ZP2pb2uRvHGR9CBd
 XAy8t4/X2dH7UA8mjita+Q07G6zt+46RQYl80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700574020; x=1701178820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwh7OHYJVKY8ksWb+fGGYbOk10LaRabxcGYurq1cD9A=;
 b=UYJh4yJIqhMw/G1AT7n6QzGYmuk6YSQRVYWe7i59cBOxDKZUodMgRY1/tLKyxcI/Dt
 0HitVGkQPw9Lp6nR1TEYdYNhKArgNf4YWQ9tEU3q9nxLEsrEVy0uv8g1iEKhpZBmLV5b
 KnC+MDmGTVOjtC2eo9K9nBW13M2gHhRx2FluB5VpzrMbFDql5yAJYPFae+zvqk5c077u
 OXkqJxX1OItgKeGTtD2XW2B8pbCJ9n6LFWHP1U2K9WFBQMbh/UdQM5dq5xypkzLaoyOm
 YaiAP0mBhTYvIpWVDe0eiPvyfFT//KdVUYiQwP2LE7GDKJt5pBPuhCt1qukN5FiMk+pu
 uAQg==
X-Gm-Message-State: AOJu0YynEmvOfKWL1nGjZLfrjBhuHmWnBO3K0/aHzKmyOubf+LJBCrqq
 JhluxsClc3VZ/tBhFDoJhc+/QQ==
X-Google-Smtp-Source: AGHT+IGzNUnEkdpzpBhDDQlThG4gvCTGzNi2fmdbTE7tQHGYYiQ7EdXZvxJF3bM7elNDWUNWUFFQmQ==
X-Received: by 2002:a05:620a:2486:b0:775:c2a1:1821 with SMTP id
 i6-20020a05620a248600b00775c2a11821mr3938369qkn.26.1700574019981; 
 Tue, 21 Nov 2023 05:40:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 dm4-20020ad44e24000000b00675497e5bf3sm3975404qvb.30.2023.11.21.05.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:40:19 -0800 (PST)
Date: Tue, 21 Nov 2023 08:40:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 9/9] doc: clang: Update and correct support notes
Message-ID: <20231121134017.GS2513409@bill-the-cat>
References: <20230405234859.1446811-1-trini@konsulko.com>
 <20230405234859.1446811-10-trini@konsulko.com>
 <0b74d785-62e6-48c9-82eb-739242ab1ab5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oIIcyX/ayVuv8WtA"
Content-Disposition: inline
In-Reply-To: <0b74d785-62e6-48c9-82eb-739242ab1ab5@gmx.de>
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


--oIIcyX/ayVuv8WtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:26:14PM +0100, Heinrich Schuchardt wrote:
> On 4/6/23 01:48, Tom Rini wrote:
> > At this point, clang can be used on both 32bit and 64bit targets without
> > issue.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >   doc/build/clang.rst | 16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> > index 1d35616eb5ef..222487032ce0 100644
> > --- a/doc/build/clang.rst
> > +++ b/doc/build/clang.rst
> > @@ -11,14 +11,6 @@ The ARM backend can be instructed not to use the r9 =
and x18 registers using
> >   supported inline assembly is needed to get and set the r9 or x18 valu=
e. This
> >   leads to larger code then strictly necessary, but at least works.
> >=20
> > -**NOTE:** target compilation only work for _some_ ARM boards at the mo=
ment.
> > -Also AArch64 is not supported currently due to a lack of private libgcc
> > -support. Boards which reassign gd in c will also fail to compile, but =
there is
> > -in no strict reason to do so in the ARM world, since crt0.S takes care=
 of this.
> > -These assignments can be avoided by changing the init calls but this i=
s not in
> > -mainline yet.
> > -
> > -
> >   Debian based
> >   ------------
> >=20
> > @@ -28,14 +20,14 @@ Required packages can be installed via apt, e.g.
> >=20
> >       sudo apt-get install clang
> >=20
> > -Note that we still use binutils for some tools so we must continue to =
set
> > -CROSS_COMPILE. To compile U-Boot with Clang on Linux without IAS use e=
=2Eg.
> > +Note that we make use of the CROSS_COMPILE variable to determine what =
to tell
> > +clang to use as the build target.
> > +To compile U-Boot with Clang on Linux without IAS use e.g.
>=20
> I had a hard time understanding this text block.

Note that the logic in question (from the top-level Makefile) is:
ifeq ($(cc-name),clang)
ifneq ($(CROSS_COMPILE),)
CLANG_TARGET    :=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
=2E..

So yes, "make CROSS_COMPILE=3Darm-linux-gnueabi- CC=3Dclang" should in turn
invoke "clang --target=3Darm-linux-gnueabi".

> Do you mean:
>=20
> "We use of the CROSS_COMPILE variable to derive the build target which
> is passed as -target parameter to clang.
>=20
> The CROSS_COMPILE variable further determines the paths to other build
> tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)as'
> instead of the LLVM integrated assembler (IAS).
>=20
> Here is an example demonstrating building U-Boot for the Raspberry Pi 2
> using clang:"

That is clearer, yes, thanks. And then I see my example needs fixing
again too. I'll v2 this patch at some point soon, thanks.

--=20
Tom

--oIIcyX/ayVuv8WtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcs0EACgkQFHw5/5Y0
tywouwv+Lea7LBBiZmsi+3yGi7vt3SSP1Hr9Ubt3tZpky5dy5Zu4Mco12nopckYu
8HGV1w49Z0N+Q0g1aXMD8rcZoxTHg/LRiaNbMDjoqbpmMhLsqel1aK/BRcP3hliA
Tt5PJfavQewloCnB9YMFgubXRrZxrdVRxO6yCw4IlQw3Xa2dV/JfZmFsqztNZJ0U
IDE1CyCiMvEpaqHzeDRJAUNEwcKlJSOo5aVxutIsTq+6MFe7aFeiG8ws6HAwDovH
Lfk7N6d+h71jvos28x7+bB76RnxIKQyXFuE6X1RPHDEX7NQtuZVTmuAqC+k01W9O
3LiN16tanZh4fLNqQUI58WNwWb+M7nRbxo4AFu2+zPnEBoyIpnOJFWw0BALvmjbr
GWu9vZDIYPCCZFYir+MkqHcFsIw5+/S7JiVnTmbrukpzY5LhR5ADv51gkd+0OOU7
Uym9O4opDPEfFcU+C3HXvL9eMHA32+iGuifpqe0JyM0hqS8RBdwBdeS6x8AUmtnH
zo3SX9qJ
=JJLh
-----END PGP SIGNATURE-----

--oIIcyX/ayVuv8WtA--
