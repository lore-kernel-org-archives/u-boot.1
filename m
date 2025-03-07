Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C83FC282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58832808A2;
	Fri,  7 Mar 2025 15:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Py2sPPEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1BF808A2; Fri,  7 Mar 2025 15:22:46 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1404A803CC
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so1316314276.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741357363; x=1741962163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ztjOw129T7uHQ3Y+kcZEBbkBYpO/d6CVihhx0dQAfl8=;
 b=Py2sPPEcPe7l8C1H7uMVfYkiGRjhBgSD2Ln6I40JrIgvkXTvQgRhp4XCQb8QlMZk/T
 dNEy7/NjBdqmvJRmbeTP0J46WfIZwNg5B6BKVJy3x+MAOjySDryKpCpXU7lPUsagsoI4
 kYXyrwzO1PNuHhybphXBXuE3UDqQVK161I7/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741357363; x=1741962163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztjOw129T7uHQ3Y+kcZEBbkBYpO/d6CVihhx0dQAfl8=;
 b=hLz7EKe37JlgEr3m0+1M8Pad9b9bDQGh8b8lR+shYs8sVLkI3N42OVOC1Xcft5BgJj
 gL9RFqORsIu5TUdUNoCKM+/OYL94szABi56/ojJ0p1iSPkNm/jVqqa9Mb0HZ7uVEesth
 ye9mja4H2ugRafsZePY937HgyWcjEtj2wufXV/GdiuygNESTNdeUlZ33F3w2SVrSivKl
 tZQuP3AnFXPIImMY9+TOnCA2rl+c4LqzZwgpP+oM6btiRDUIYXpaGJhj4nWjxJYD88rT
 hftM+3yOzWWYgkd6VC9NmyfErxrcqz3qwkOfgw5trmAFd2Na2wzwe/TyrhXyXUF5+p7L
 dIQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7rWK8fkjWYrAm02oPilLr5nHNZRHltG1lXPC1tPkl05/Y8n+mHAjB1mIcK82fsM1M3I4KI0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4L57gGxEfbnmZ/zj1dSqhmHa6ZyZOUmH4WAopqb19S135TlEU
 UCCuE+aOir3LL7VgU07O9fAXalWHsUZ8iQLPwy12u5bwU2fBDmYsVJjR3RPgAjg=
X-Gm-Gg: ASbGncutixOkiUNEVMLHmF3H0W2UJN3QR8dUS/7Z9HYDB4PJJatjYxT536oVw8y+liW
 oZol5x7mCJsilJTYuRIdsrB5zpV/cDmBdH4FbtaN9B2gJ1a5TC0s8yvTRBQU2cVoaG8SK0EOKvb
 2rsge5JCe93WAPUlxQSi9YJLAMwk0BMSDlnP4NHP09K3o3/fsKCXAbUMS+3Q5PVOa2xONSd+CSQ
 4FO3F21R8uAEEkiNJONCLU3uY1k0cPTYK6DBg7OYjXpOiqP05ihyXo6UgueiU9FRKVckHivoFmF
 lzX8hF7/XSSj6RddXrBrWkqPTUtqWC7WLvhR6LLOwoDqZw==
X-Google-Smtp-Source: AGHT+IFW1RCryPNv4F0PN7QSfU1bCefJ1InMv25SehtGIspgPXBzfVo0uoW2bcO1gzN4BU3yiUo9kw==
X-Received: by 2002:a05:6902:2803:b0:e5d:bdbd:acc9 with SMTP id
 3f1490d57ef6-e635c0f927amr4798364276.6.1741357362907; 
 Fri, 07 Mar 2025 06:22:42 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e6366b6bfcesm186396276.32.2025.03.07.06.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:22:42 -0800 (PST)
Date: Fri, 7 Mar 2025 08:22:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] doc: Include pytests directly in documentation
Message-ID: <20250307142239.GJ2640854@bill-the-cat>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <a83e7acd-7345-4a51-9720-568226a2767b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fc1WiYu0FeiUWqPg"
Content-Disposition: inline
In-Reply-To: <a83e7acd-7345-4a51-9720-568226a2767b@gmx.de>
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


--Fc1WiYu0FeiUWqPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 05:03:02PM +0100, Heinrich Schuchardt wrote:
> On 25.02.25 21:50, Tom Rini wrote:
> > As there is support within the Sphinx framework to take Python
> > docstrings and generate documentation from it, we can make use of that
> > to more clearly and consistently document our pytests and how to
> > configure them. To do this we:
> > - Add PYTHONPATH to DOC_TARGETS so that modules will be found, have CI
> >    install pytest module as well.
> > - Add the autodoc extension for Python and then redirects so we can move
> >    py_testing.html (which is heavily referenced in archives, etc).
> > - Create a doc/develop/pytest directory and move the existing py_testing
> >    file there, update references.
> > - Update the test_000_version.py test to have a docstring
> > - Move the imports in test_net_boot.py so the docstring is in the
> >    correct place.
> > - Use code-block for all of the code blocks in test_net_boot.py so they
> >    are rendered correctly in documentation.
> >    - Adding these code-block lines makes the diff larger when read but a
> >      "git show -w" for example makes it clearer that the textual changes
> >      are removing '#' from lines so the output reads nicer.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Some of the test functions seem to lack documentation:
>=20
> test_net_boot.setup_networking()
> test_net_boot.setup_tftpboot_boot()

Yes. Most of the tests need more documentation and only have a minimal
header comment.

> Would you know what 000 in the following filename corresponds to?
>=20
> test/py/tests/test_000_version.py
>=20
> Maybe we should rename to test_version.py it before adding this patch.

Yes, it's an ordering trick to ensure that we run this trivial test
first (and so can also fail out quickly). It should be documented.

> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks. I'll take that to mean you're conceptually fine with this so
I'll start on a real series that split the changes up and includes a
follow-up "now document this test better".

--=20
Tom

--Fc1WiYu0FeiUWqPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLAS8ACgkQFHw5/5Y0
tywtVgv9F+cUL6tPVecyGuHv061eu9vNMQpnKbRTndNcSVt65m4Q9pVXqaWBqRx4
PQgHf8muuORpSln9zdJ4sDBGxNNRZv010K3i0Q7QkvQq8yXQFA7V81YfvWo8tm3b
4q80TcpbH6TR53R+MvaWf0mCThkUOPfejiJ05Jq+qCHqSuqHTth4TNooTicTXomR
+RFUIAUvK1myYRhlYUzK6J2bqj5PvX0ePPGcaQ/+/gbkDEt85Loi3xBDKFPfh2Bc
J7JewfAbPVAqEJmG+tA7peCM+zoBSlXzdfVriTKAsDelAM0vKdP4ydHlsGtjx+yh
abCXQNGXg+1/5OCsadnobhwB2ONYnqzgR//odlGzVqdwoECPSwPe3IxeSuijiipp
E4BUh1LnmAfBVPIIXss+8p+rwEil6tnUvcz+3WsHMcza95CglrbnMJsqkNikNizZ
1XHWUXRWtqfyLnhzatIaI/byC5DuBBe5PMKTNhbrYcengGdl8mnxnaSiUT2L/4v6
39+ew/KI
=LfSd
-----END PGP SIGNATURE-----

--Fc1WiYu0FeiUWqPg--
