Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C14CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 22:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104C2848DD;
	Sat, 23 May 2026 00:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LliqnIr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E50848EB; Sat, 23 May 2026 00:45:13 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8445384659
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 00:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e5fe62fc87so1292094a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779489910; x=1780094710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hnqvb4ZluMnm7LUvUNJnIwnafYMpLsoJQmx4/t45qWg=;
 b=LliqnIr15s533T4iEXmy6N1GF7OkAG4lf2ELZojE9FeaLatqSQCzX+imXmTg/JOwGr
 w8DTai+7FaLIl0fof/DnUo5KvTfhh0trm5A1yjZol+EylLd6EO4MKJ0I8UUPPS4De6iz
 teJo6LcFTuwWkDIYI7n1Cbjp2EVkBYQCk4wVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489910; x=1780094710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnqvb4ZluMnm7LUvUNJnIwnafYMpLsoJQmx4/t45qWg=;
 b=dA2Q4Vp/TUllE5YXoycTfrSrE48oUgL9klN0IvKtiJmzc1FF5Wrs64mQGSC3SDEdj+
 LVSe/UF+AU0x+Flom2xEvD+sA5BlWSNPfEI3YvBlT/jRFc/EexZcXHAtA91XFxcLPOQ8
 b79/WZ0cvNnngyhcijmh0DLytazJbV85HDSM6m2gUVe0LAiBLrR8MpM+0aGHI4LVOYya
 XQMcT9NZbpz1jr4mJ/Jej3dw5xZHjgDW0ngupgOz/5x5RNdpKd/aKY79/ksVemQG0JmS
 DYxMBrapXF1NhszByIvZv/W/pjGWRgLQvetKD29BWu2ZK4LkDbcX7WzTF04nUh8tcfoV
 R5eg==
X-Gm-Message-State: AOJu0YzE1J9LdWz9m0LCGkBhoDGmoPvbQ7MzUHGKKwAZ9qncXBJebHni
 3v0LAIB42cVJZLO4n7ILw4pU3ICfxvmKvMWCpxR3A84/d0v7z2MkXZCiD1EDD9FNUvI=
X-Gm-Gg: Acq92OEjRMqpR9KVc3DrdSo2dY/PVVeipQyZ6WwCyEtNDfxPdwSjdwS1Z6G0ISDYcZY
 3AGYnjLEwHqU6m96re8CZyVx8o2NgahNf43BrIKKFveuwGhncNZ0aXZDd+gvXTqN3fJ7AdV4HD5
 vGDz7Fwn4pjFl5S3fr3Ctm1eNHqfOgJkygEOdmzLmabnXfg5Y6fOuFhrwad2zWf/4EWWaeEYDCz
 RDNSC9kPd1W0cod88Tzjq24qDvAehafnN4va49GFCC/oAtcrO4WrCiNj4h34w9huKmVN/9J+UuB
 7k1H8wB3HtTirsKYWSuVwpIDnlzioD22+LhYlclJo5wHYD5vmramGaVXGOC8xQ305jnv/KA2mCD
 +PDae7GvSi4HAROmMYp9YrkRelAZI5ZluY7xp/EuUTtjO+oBVPlWVwcUTPP3aacx5qhQtNz7F/n
 jTx3slfwzLkHRHCGT0jrkAELmPH/mBZpX3N3EYJVUcwOBpZctPOW9y+uQzIuq7Hh2yxRD5iZax0
 CjPnk8f8+ttRY5ClbCtFjRBusKZ39XPNjlKEEFWaAzmNg==
X-Received: by 2002:a05:6820:998:b0:69d:5b47:c005 with SMTP id
 006d021491bc7-69d7ed1f39dmr3464349eaf.54.1779489910279; 
 Fri, 22 May 2026 15:45:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83a4db17sm1544224eaf.9.2026.05.22.15.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:45:09 -0700 (PDT)
Date: Fri, 22 May 2026 16:45:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 6/9] linker_lists.rst: update documentation
Message-ID: <20260522224507.GE1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-7-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QBBmw3OmA1qfhVSK"
Content-Disposition: inline
In-Reply-To: <20260522212756.3169222-7-ravi@prevas.dk>
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


--QBBmw3OmA1qfhVSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:27:53PM +0200, Rasmus Villemoes wrote:

> Remove the initial _2 component in the examples in order to match what
> linker_lists.h now does. This also makes the
>=20
>   Note the two '_2_' constant components in the names
>=20
> easier to grok, as there is now only one such component.
>=20
> Remove the whole "Start and end symbols for the whole of the linker
> lists area can be defined as" paragraph, since that can no longer be
> done like that, and the (never used) macros doing it were removed in
> e2138cf1e60 ("linker_lists.h: drop never used ll_start, ll_end
> macros").
>=20
> Leave the occurrences in the "Alignment issues" subsection alone for
> now. They are verbatim copies from a u-boot.map file, and it would not
> be right to edit that long after the fact, when we cannot easily
> reproduce a u-boot.map exhibiting this phenomenon.
>=20
> Part of the purpose of this series is to get a better handle on
> alignment issues once and for all, so hopefully we can simply remove
> the whole subsection in a not too distant future.

Thank you for digging more at this. I really look forward to unravelling
some of the less clear parts of this implementation and either being
able to remove the align(1)/align(4)s throughout or much better document
why we need them and what their values should be because of this.

--=20
Tom

--QBBmw3OmA1qfhVSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahDccwAKCRAr4qD1Cr/k
CgtzAQDmtYgregvVSB38ZzrY9is/JlGzACTbdoFBSRRnf8NDfQD/S57vVISgNuGH
tTfPsOqqtKNr3M8fBn/w4Lt0pdQhfgg=
=qFjQ
-----END PGP SIGNATURE-----

--QBBmw3OmA1qfhVSK--
