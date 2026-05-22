Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFBDCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 18:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B059848AA;
	Fri, 22 May 2026 20:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WaxY9A6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926CC848B0; Fri, 22 May 2026 20:00:17 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7BB848A9
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 20:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e612d0693eso401539a34.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779472814; x=1780077614; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bOKH4gDTqdl7U1rYuz/igIM/LT+qypAwP6urZfOpCt4=;
 b=WaxY9A6aFIR0zeM+nbnmJZEWMXYffXRJqrpEG6JgNTM1dvG9UGk3jzPt1d6oj198c+
 bUel4UzVCTQWy9ABP2wcz3fjZzsTUi2hI2r9GQcvYLnRaSBUA1/z0BLivaN/02MazpN6
 wu/vI7ARYTs6f1VZAyioPHiny9UuOqZWViOvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472814; x=1780077614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOKH4gDTqdl7U1rYuz/igIM/LT+qypAwP6urZfOpCt4=;
 b=lpPiGlf9LtmzqhnMLh8uebYGZx6NGt+Vzj7mUoUIPAFvHeYTPdeKencfbfjU3QdPps
 HvRzTPT8W87UkoVcz5phVfnnkt4NNRoDSJhK5WZk3M3uwKp/+nln+HZ+cddR70jxHU03
 +1HrTiDXHbnaEleXYVB3uOmIiDP7jzA5Pi2Hs8QFij/qqldYt1e5cfnEiRuUlwlGMrNJ
 1CVhrQIYtDTL9kp7nfGSdlGGmOLOWTgky18sQBlep5m6qhuSg1wlTJDlcpcLmvcJKWbS
 35ZPyv1SrHH7MWAw3+ORwRdIRJPqklcm64uKpaHE4EKepLJD3K5NFGCo6bChWm/Yu5dE
 y3wg==
X-Gm-Message-State: AOJu0Yymnv8cCQYckDx87am02uGmDaym0EP/uA01cwlK7lQqOby2E+Ko
 8DMXwg9VMF0Pq4BfNqFgWgcjnKOP4zDL37Uk0kcz+DaeSAKBmHdZDe0HL8EexEqnQDk=
X-Gm-Gg: Acq92OHa2mtsHRbB66QACl+Bjd5p9w8RVNGSD3DHCdd//SEZCCMbbMFdyP2aMUC0yVr
 8L3Gku2hZ1MB0V1aNE2yIH/Ve6SSbpZBI0vqSxqlN2xTbQfWRNGBY8ywIHP0L7V+XKknxkFrUvx
 doVS5RgZh+Ovc0R4cLj2nr3gEZHTJvKbAG5aAmLPFH8GLO9/RmU3UbzvjaV6ckX88PlwcuDgeGM
 1NfQBRzMpN5/lKgLdw8vJ1Cp88W0HzhbVsp53Gb8bsTfYHyvfu1+mTlleIXGXDfSUcCbsfITtFo
 S+DUgpJDOtaugV9v5de1ZD8rPYP9QpV9Fk98f4h3aa1flJN1gJ2uLT8xrcLxbNbtSC5RyenIROv
 VyVNc9c3shD6TGmT4d5al2JhoKlK48u7wFXDQpDPzZl0zePS3fGJqQZUu8XFO3YdVfOeDkfRVXc
 FFIhfvkSzeyzGaQ9/VNiZ1n2nqdAAOyctZ9ML4Oc6A1LZd0Q9v1JPfIOcKOPXgnIckZD2rYJ70W
 8uSMPCSYmPUoGlzOaOuPAnv4HEuhqWoouIwSeGb3+XcAoR2TyFRr0nP
X-Received: by 2002:a05:6830:349f:b0:7dc:d679:3eb1 with SMTP id
 46e09a7af769-7e5fef00377mr2873475a34.25.1779472813940; 
 Fri, 22 May 2026 11:00:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60664699csm1473350a34.22.2026.05.22.11.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:00:13 -0700 (PDT)
Date: Fri, 22 May 2026 12:00:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
Message-ID: <20260522180011.GY1858239@bill-the-cat>
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
 <CAFLszThnDQzMDNZsarpio-RM4KZpyNo93SjUwCij=wXSPPJjdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sQPy1a74wGeMY9Ev"
Content-Disposition: inline
In-Reply-To: <CAFLszThnDQzMDNZsarpio-RM4KZpyNo93SjUwCij=wXSPPJjdA@mail.gmail.com>
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


--sQPy1a74wGeMY9Ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 07:38:17PM -0500, Simon Glass wrote:
> Hi,
>=20
> On Mon, 4 May 2026 at 07:16, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > As you know, I maintain several tools which are part of the U-Boot tree.
> >
> > Tom has previously suggested that it would be better to move patman
> > out of the U-Boot tree, e.g. to its own Github project. It is a
> > general tool which can be used with Linux and other
> > mailing-list/patchwork-based projects. I have never been keen on
> > taking on the extra effort required, but I've recently added more
> > features and am wondering whether now might be a good time to do this.
> >
> > Buildman is quite obviously designed specifically for U-Boot. I have
> > made some improvements recently (a large code refactor and distributed
> > builds). I would like to push those changes to mainline. Do people
> > think it should be in a separate tree somewhere?
> >
> > Binman was written with U-Boot in mind but supports other projects
> > (such as Zephyr). It is generic enough that it could be separated. The
> > impact would be harder code review.
> >
> > We also have smaller things like qconfig (which I have substantially
> > rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
> >
> > What do people think? Of all of these, patman would be the easiest to
> > move, with the least impact on existing workflows.
>=20
> Thank you to those who have commented on this thread.
>=20
> Quentin, I think there is a mailing-list patch for the pygit2 problem. For
> qconfig, your feature should be easy enough to implement. If you suggest a
> syntax I could take a look.
>=20
> I am considering moving all the major tools I wrote out of U-Boot, each
> into its own project. As Neha points out, Binman is useful as a general
> tool. Patman clearly is too. This leaves Buildman which is U-Boot-specific
> in many ways, but it hardly seems sensible to keep just that one in-tree,
> plus I have a substantial code-refactor and new feature to figure out how
> to upstream. With some adjustments it could be used in other projects. The
> qconfig tool is in a similar boat, particularly now that it can rebuild t=
he
> database in two seconds instead of a minute.
>=20
> I also have some other tools I have written recently, both of which might
> have generic application:
> - pickman, an AI-powered cherry picker which could be applied to other
> projects such as Linux (but it currently is tied to gitlab)
> - codman, a simple source-code analyser which tells you what files and co=
de
> lines are actually built for a board
>=20
> If I do take this path, I will need to figure out a way to make it easy to
> install the tools for use with U-Boot. This could involve using 'pip
> install, cloning a repo, or some other mechanism. I could use a PR workfl=
ow
> rather than the mailing list, if that is easier.
>=20
> Please do continue to send your thoughts on this. I cannot attend the call
> next week but hope to join the next one.

You should plan to take care of patman outside of the project as we have
been working towards just using b4. The rest of the tooling that's
currently in tree will continue to be managed by the community at large,
and some of the suggestions I've made before will be looked at harder
again, but not likely until after we've migrated our Gitlab server to
OSU OSL hosting.

--=20
Tom

--sQPy1a74wGeMY9Ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCZqwAKCRAr4qD1Cr/k
CoL5AP9uQsCmbXRq1DAUHgubYbuW9P7ZwEQ4aMo8WbXRbImSKAEA0/JunMgq6ueE
JycOHUud66BQqomzOIZA7ZzNUqWinQ4=
=v/VR
-----END PGP SIGNATURE-----

--sQPy1a74wGeMY9Ev--
