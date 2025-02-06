Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9678DC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD9C80C5A;
	Thu,  6 Feb 2025 18:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qASyiP0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0887780BAD; Thu,  6 Feb 2025 18:08:04 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77BB80A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21ddab8800bso17428725ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738861680; x=1739466480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kMAK2Ks2WFKVKaNOpIITTtYFKCOezF7ZPTNS1jeEqsQ=;
 b=qASyiP0aZtifO140lnhA7kO5gqmWvBVeOThhVPO2SqY58IuZPaI45cYi9hoJ9a8Rpi
 6fc8a4ndGVUAINtYCJwwVBRdIyClSMlQPdsnX5Nc04y4EXUaVi/mFF7dDSP8Tr4FtlwT
 tjjWMb/VvxssIgn9s1Oso+xxtVpYMcnMZ9+/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861680; x=1739466480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMAK2Ks2WFKVKaNOpIITTtYFKCOezF7ZPTNS1jeEqsQ=;
 b=JW+EluEKmaxb1gfWsO2fKTKLH9/v6Cb6nsI2CyoyDbLmMkS9ZrVQhYreRQDS9SSHmV
 lSLNslLrsmRmT14i6Ohbkxm++U2L9Qbg8tXOuY+Ci/TZftH+yMjVr1RucoCvbKMrmQW2
 uJdJNeyeh/gOZS5SzBKZljRzBx4lIwMG4NNzysQkekZg1pI2AgK6sFmDW7NX5YU/4izR
 olEXzATwWhsM5i5suoFBrACb/6K9Vnjdsp2O5mpmKK50/YHM+xWvo6LsReT+Jc+0uCVn
 mXdLkEHe1uNdAep+loTntykmrKoetFkfFzsSuKkgLdzXqvbu/Z1JAkvpfLxKdOB/Eql1
 tq4Q==
X-Gm-Message-State: AOJu0YwgUtZmjglS8LF7dHgR8BWjCps05h1bkfVJMHLVpbuY041u/nNJ
 FI2e08irxg3Ii/jo0SAJ8BnMO+bu38RT0FfhHKD2KUxWsr1VCnqv1leKC00ioDQ=
X-Gm-Gg: ASbGncuWseuNw5/I50HUOOwOBF52dQ6cXcNIeKBdIuHqE2kze3z5RfGMmoAkJTdh264
 jRK1KvKNVA7OrAlmY6gpmws0MljTL6+yk/etKbWPpm17rcKZosOEw1jZ5PBYI8CZSH3tWAXt2da
 Qy83SjfC4eFVeIrHs05SRHh4daKq6JjXGxgT39w12H7DogRqxpzPzefk4InH2TLBXIxWBbgmyZm
 laGwv6k7CKaw6pGtB+xU+P8Xoojm8lEpOzuhVFVU3bz4r2ZgRuhzIdaR8lxIFIJ70cKkRPQyvIA
 VzNlFBWQhZMWHmk=
X-Google-Smtp-Source: AGHT+IEqO82ERzhlWyNkOjUPUyZNDnEsZHi9yDR3hLz0bXhk+WSwgtRDnJGiGo6tv47RjbT2m6kuww==
X-Received: by 2002:a05:6a20:12d1:b0:1e1:ccfb:240 with SMTP id
 adf61e73a8af0-1ee03b70873mr232617637.41.1738861668689; 
 Thu, 06 Feb 2025 09:07:48 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048a9d56csm1543397b3a.7.2025.02.06.09.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:07:48 -0800 (PST)
Date: Thu, 6 Feb 2025 11:07:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
Message-ID: <20250206170745.GG1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
 <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yH5FIfLHs/gJd4eS"
Content-Disposition: inline
In-Reply-To: <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
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


--yH5FIfLHs/gJd4eS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:33:06AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > > >
> > > > > This code cannot be used since EFI is in charge of managing excep=
tions.
> > > > > Drop it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Why is SPL on in this case?
> > >
> > > SPL is enabled by a specific Kconfig option, which seems to have
> > > exceptions but not exception levels. That seemed to match what the EFI
> > > app wants, for now.
> >
> > OK, so why aren't you turning off SPL? You're not using SPL at all,
> > right?
>=20
> Not using SPL, but using the same code as SPL happens to use.

But is CONFIG_SPL enabled, or not? It shouldn't be if I follow you.

--=20
Tom

--yH5FIfLHs/gJd4eS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek7GEACgkQFHw5/5Y0
tywDTQwAnPGui6mWvp049UI6lgvJRecZy2Ct44JMUuLWJ7Y3Btrz2bcOVzjSIvrE
ZS0IrDpxX2YP9ZacFYyNHosHQSGrIpfsHLybCihaFBEiWGPBAYh2tMNhh67EPYYQ
fvvpZL/Xcdk/4r+oOt2kvKjh4GMOQ9IpHwAr4styHygTfb28IXUtAO7JPiUkIybH
yjAEfkMVxbxL6JYbzBfV3L3cBgASLT+nJ57Jp9SNWOAn2lpLGHeEyuyYmAUjJKE+
+3VdDnTel42N6Jcl7Tpqwvza2tr1MaMDAug1AXxmATQ2y4Ccbp/uRbOzWDlza5NE
31JZpTQgWvTFB18LaSVu7oX09TrOboYWJ4Yjf+2DNOzXY2k54FMNIF2+nYG/2qm/
D9H/U2hOeGpTW7FoFi3lKDb6IRzvNA2SLOtBcetARC+H7/IZaIDzOJmHKnyFSRae
xlkj7UB9vjuYjDWq0uN4NFS9+xua4mTQ1KONlrqBpOtyExJbHh0AfaD9AVRHpWvL
1wjrhX9J
=HrnW
-----END PGP SIGNATURE-----

--yH5FIfLHs/gJd4eS--
