Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE8CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72652848EB;
	Tue, 16 Jun 2026 17:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LTQTtgaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67CB848EB; Tue, 16 Jun 2026 17:01:02 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C514848D1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e74a827212so2158760a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781622059; x=1782226859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N6DGRQQRM1VEuenUup6iLvZHvbC8J85TOXGUTq9Xk7w=;
 b=LTQTtgaqTqaldbazd+LNXSXmGkh8jM7e/sadoGkJ5JNAkjWiWPVlb67N0KVcUJISrU
 NveSK3uSTCL3VLlECaKKHYZSqTeDL4qeyZDqXjPtmhtcYV4mhQFVwHumpQnFvv5AVJXp
 8F/zHbb2uSB3uxL9bxzEAgWUdCr2a+WF4Uu6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781622059; x=1782226859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6DGRQQRM1VEuenUup6iLvZHvbC8J85TOXGUTq9Xk7w=;
 b=Vkk54aUyB2wPZdI7+R0fah2ZrG/i+HPqDAD/N1IkqACZ+VSMaKcpHphLJPRRwajJPn
 WucEmY5veRt0Epg/NhKlfvg1bkJpRi0omuKdm1sV9MkFG2megmCpKu807qwmTCFApad6
 biVxhII/4+nmcSfxjxVcHZhWCeG4cKSQF6e6+mE8z5VNe0mGyp3DQM/bs7L9Ag04DW0b
 80tiorhd70h73cAfMezjK/ytQUaykQKHSkgVWiMbYMhSMSUBMY0YISYXS5A5tBe+OZaA
 YVuVP57knHMH9a0RkWJB2NBRXl0vTOajw9Yqg/jrwUgt8XOkdRKIhGcc7vspfqohdoOf
 Rm9A==
X-Gm-Message-State: AOJu0YxPykh0+9ZFkRHPt/N3eBocp5JgyYlnwGuqrSNc+Ml2nJS7F7fA
 M4HYFHl0c/By9t7b5e+J+70QQ5HwlcdahHpEyGw0fsLHU0bYbHeouPhhEKVG+AuedJs=
X-Gm-Gg: Acq92OEwQBcmhm1UMPRb7U2jqRqPaPByOW8zurrrZM/Kg11Los84BFjdjEBLjKeIPEi
 dLDQyPtEayK/K/URwk641OiFW/fDFseOmf8FFpU9pR0+EtqiZ3yZHxpBqZZ6ie9CBp+MBU2PxVu
 xCgcOrvW12iIT+tw8B+xOiPlg4YROE/Isd0q924Y+sb0m40/4IA8MMmwT89XTdus3xyHB99xnYD
 U510+DVlQBxlb8EsdTMo9K9bKvD/WYfHvefUY1gqjFNq5tGwkCViJfmeWIb1XJdho2bCUaMU5CZ
 zfSFX+5avO+m/zD2jLPYF8/otE9V8IBTqeeShalrQUNhdasyqTUAoVHKLZkbyUPW11L4hhEo3EK
 EVoz/Q+kqV9ShMvfvuXjVnbCGv0hbQQja8B/zMMJ6SJorkZy2UTEQXomCsgF8kRNRXUQOpEulHj
 5gzHBcbX3VNfbMoinGuTSUm1deLklGCzdMVqCnX0XtGWyCFD1zMl5z/Jqdq5JNbk5CHNeqUUfSK
 cMT1kmrHl+nf4HalXkQ1Yss9c5ly+3ZrIIK9bqjpH/zODZoIg4=
X-Received: by 2002:a05:6830:700b:b0:7e6:f083:1312 with SMTP id
 46e09a7af769-7e90b39ab8amr17138a34.4.1781622059093; 
 Tue, 16 Jun 2026 08:00:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e906270ca6sm922492a34.18.2026.06.16.08.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 08:00:58 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:00:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 5/9] patman: Replace the documentation with a stub
Message-ID: <20260616150055.GL382693@bill-the-cat>
References: <20260616142859.54136-1-sjg@chromium.org>
 <20260616142859.54136-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uEsPCZ4iJlv/uvrH"
Content-Disposition: inline
In-Reply-To: <20260616142859.54136-6-sjg@chromium.org>
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


--uEsPCZ4iJlv/uvrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:28:45AM -0600, Simon Glass wrote:

> The full patman manual now lives with the standalone patch-manager
> package, making the 1000-line copy in the tree redundant. Its published
> page is a long-standing URL, though, so removing it outright would break
> existing links.
>=20
> Replace the in-tree manual with a short stub that points readers at the
> patch-manager package, and keep the toctree entry so the page still
> builds. Drop the README and the tool's own rst, and point the
> patch-sending docs at the standalone package too.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  doc/develop/driver-model/spi-howto.rst |    5 +-
>  doc/develop/patman.rst                 |   15 +-
>  doc/develop/sending_patches.rst        |    4 +-
>  tools/patman/README.rst                |    1 -
>  tools/patman/patman.rst                | 1023 ------------------------
>  5 files changed, 20 insertions(+), 1028 deletions(-)
>  mode change 120000 =3D> 100644 doc/develop/patman.rst
>  delete mode 120000 tools/patman/README.rst
>  delete mode 100644 tools/patman/patman.rst

We shouldn't keep a stub here, and instead just have a short blurb about
patman that follows after the b4 blurb in doc/develop/codingstyle.rst.
And that's indeed an odd location, so if you want to first move b4 to
sending_patches.rst and then have a patman blub, that would be good too.

--=20
Tom

--uEsPCZ4iJlv/uvrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajFlJwAKCRAr4qD1Cr/k
Cr8yAP9yiZVdOp0/pvzUZ9/fMtzEzIT0l/sSrhAs19DXhM4kWwD+Pf0UMtrYkZK3
zUjc2i3NwgSa5YFaGOmuLR63ySF4WQU=
=1wqM
-----END PGP SIGNATURE-----

--uEsPCZ4iJlv/uvrH--
