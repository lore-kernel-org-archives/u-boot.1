Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3ECD3ABCA
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 16:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EEE8917A;
	Mon, 11 Nov 2024 17:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFL9QGpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A7189319; Mon, 11 Nov 2024 17:13:08 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD8388EC9
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 17:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b13bf566c0so286571185a.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731341585; x=1731946385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WucBcLEI8x5CGSyIhCsSR55DKAOwjGc/ByNALuGM1xA=;
 b=sFL9QGpw81J16iHLNTtjMFhdLlPstdR/4GOqqZ5iKEwz7nW6UJDd9mmpw5hlXu7HY/
 +MSmAOGeQJtfJxBKfNND7ybQJh+FrGnT2v2WX7+aKjOySekC4rBw/LrC6nz4R8TgnJkG
 STIuct8RtLg+EWuRdy5lJpPuIo+r9W1I3sArE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731341585; x=1731946385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WucBcLEI8x5CGSyIhCsSR55DKAOwjGc/ByNALuGM1xA=;
 b=WOWFFx/2kxrkmSy/XpLj616EwNHma/mMR2Mc9volCKTrC7B2I2MwpdK1dkFKiJVdlP
 YUzTRsLqus25qoerFXDjlOq0TDWYi+8OsWXRdpgqWyyg9i1U5sGLiaGP2QFWkQ+CTeY4
 CBhBE02QIOvwF+ha7438Pq3h5SNxc888oNOYfOB7du92LFffSsIV89IGdWyhhQsUzyco
 ntRvy1RKJvQICT861RGYFwiKurFqydlWK8ttqBSi9aA78zXrmeZMfanyWmmCw7TyACwq
 x/3AQEne8iUbaVX1866a+Li5yq+P9PpWm4Gv3qXi3mSmuxi5K8Mby9TCvLa246p/v4gB
 Ajhg==
X-Gm-Message-State: AOJu0YzfIw1SvRrvIXENQ28ISxfwtpCdswjgf16CIQwuXn0FQ/+HOaH8
 p+8dSpptamT1hPRK67q4zPYqe7qbI7rNjB+RNNr3W8hchwMyqacH5LobMTabaqAr704r75E99Ex
 LZ/M=
X-Google-Smtp-Source: AGHT+IH3B7w0JxvU0eNuy/wDHdAoJ93vO4iY9zsuU8RXJoUfSC0whK8IquAkawIzHYdQmxg6Ln+Gyw==
X-Received: by 2002:a05:620a:1aaa:b0:7ae:310a:84e5 with SMTP id
 af79cd13be357-7b331dcc9c6mr1912407885a.8.1731341584698; 
 Mon, 11 Nov 2024 08:13:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac427cfsm508270285a.30.2024.11.11.08.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 08:13:04 -0800 (PST)
Date: Mon, 11 Nov 2024 10:13:01 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.01-rc2 released
Message-ID: <20241111161301.GW3600562@bill-the-cat>
References: <20241111161223.GV3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oHccKoVNug+Yopoo"
Content-Disposition: inline
In-Reply-To: <20241111161223.GV3600562@bill-the-cat>
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


--oHccKoVNug+Yopoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:12:23AM -0600, Tom Rini wrote:
> Hey all,
>=20
> It's release day and so here's v2025.01-rc2. It's got most of what I'd
> like, but not everything I'd like, so a few things will sneak into -rc3
> rather than going to the next branch. The next branch IS open now, keep
> in mind, for bigger changes.
>=20
> Looking at the -rc1 email, I've just now merged the series that
> addresses the problems with the Apple IOMMU (which wasn't even using the
> old LMB for images, but handling memory streams, if I follow the thread
> correctly). The changes for lwIP using https are almost ready, and
> there's a few lwIP releated things to fix as well so that we don't have
> to worry about correcting behavior later on. We've made some progress
> fixing up all of the SPI related issues but it's not done yet. I remain
> hopeful we don't have to revert the whole thing, but am open to it if
> we can't resolve everything.
>=20
> In terms of a changelog,=20
> git log --merges v2025.01-rc1..v2025.01-rc2
> As always, more details in pull requests (or the tags referenced by
> them) will result in more details here.
>=20
> The next branch is now open and I will be pushing that out shortly. I
> continue to plan to do an rc release every two weeks with the exception
> of I'm also doing -rc6 on Monday, December 30th to have one more tag
> over the end of year holidays, to see if that helps with people finding
> time to test.  We'll how that went in January.

Updated everything, forgot to correct subject.

--=20
Tom

--oHccKoVNug+Yopoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyLQ0ACgkQFHw5/5Y0
tyzMNQwAusbwf8oIPSxw28zEnmoV7INeE0g18lbrDfgygXXFHJZz+vPN9YLdwjPv
OjOpeUJpkc6D9hL5y8cMkJMLCiLIfywRC29lHjFfFxwSfEgNDEK++IM0gMc59bDp
sdoAMY/+ht/OK39Xo9qgdQgTmQXpohCDdgQvLalyvBE1RmbQhtcCGn6h2zhFoWFL
mb6915VU0Zoo5btJfAqf26Tl9u3Xy5eSotwhLsCd+1bcyfd/wuHb44aAM3dUwNig
gupPRMEArWR9yT2GM+JWfgweN/YFbV5O6evl5/UMLCqs5eOFcyQ7A7B/9oYEG2/z
rlDhnQ2lxpbUDE9quH9XJe1x8gSBhpPxvN6DGqxAaoilJzI+/n5fg8mfbXe84Moe
FGL5bZarbVmU8sg73fqVY9bJ09QWfQRhFlz766k3TZOQRyW4l/R7fNOUlaRBScgg
upQbT17sol05I/O8ka2tXochTW85N9orHSakX+lCJqoefxAspuDN1X6CvyiASBn7
vbmtFq5/
=Rdn6
-----END PGP SIGNATURE-----

--oHccKoVNug+Yopoo--
