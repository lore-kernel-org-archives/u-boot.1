Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A14D462A7
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AB789001;
	Wed, 13 Nov 2024 15:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HLwAt4XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A291389001; Wed, 13 Nov 2024 15:12:40 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7403F891B0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b152a23e9aso473742885a.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731507157; x=1732111957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e5lX7vYDCt+YSxJC8MBUYOllt1TJcYLwSsSV2A/1NrY=;
 b=HLwAt4XWFX/oMA6Q+fGS4C8OlI8JsANxqr4wLy9Vq5SevCOJ1TFDZZbkn28cu7wE3r
 b5iVXVRd0IAK4O5vDKC+mnm3agWPCbc1aHOaBvruULKC206wf/1GbddXuZf9BgI29Krj
 rYLIzuLAdmdp5uiaG6sfX4EwNHH/SCQwmLBho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507157; x=1732111957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5lX7vYDCt+YSxJC8MBUYOllt1TJcYLwSsSV2A/1NrY=;
 b=MI2H9qimQhY/OFZoTbA3n4MJ+S1oKcRVVvuowDQ+p2sCK66KyrrlFEyLMWHzA4XnOP
 Q4j6YzUH+EeMa3ovSt1xY9uXq8G4ynRXcWZXcjoVHMc+0NFyVsocTwQZS/ntJmVe2x1x
 sc98mJ8G5CfOzdA4W/37xF23rjvFxNIpYQ13C0/bec+fa/bfn8kXK44Tt/iHY2whR57T
 obZSM2nb+SkWWyPwODXNGco49TjPrGrk6hsbzS1hzqZxrB5GkzKh4c03281xlA9/ZYkU
 D8c6X4BQxW1Xx06jZKy8Pym8V4DjqtsEMYG/ypOkczwJZrifJvKzwSYAW4pfCIIiZwip
 7/hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhOal1CND9d/omGouPE3jGdE5mEmnZ/xFWo7ouRzFBHNy0NzHcqq4iAexvEGdmE2WEsKuCu50=@lists.denx.de
X-Gm-Message-State: AOJu0YzjeCZNc2ETtxzCildNevloLM6G715yDTfq6ANs56pCha4v7GQD
 oIjqJC3DEwjjtX7efKAUal6iQIA9jDQ/YuUKE1QxIbHF4sgCR6zjRbMgOF5WTLU=
X-Google-Smtp-Source: AGHT+IGU23PzxY8pAiQ5F6BA5DYVHAM23fX9dKeKaChclVb9UWfYA53Ghf7cihtWD2wYNcg8oBzEag==
X-Received: by 2002:a05:620a:24c3:b0:7ac:dfed:65ee with SMTP id
 af79cd13be357-7b331e87a15mr2743708685a.3.1731507157353; 
 Wed, 13 Nov 2024 06:12:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acea072sm694972385a.114.2024.11.13.06.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 06:12:36 -0800 (PST)
Date: Wed, 13 Nov 2024 08:12:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
Message-ID: <20241113141233.GK3600562@bill-the-cat>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
 <CAFLszTjhzw8i-28V+V8M+v41x5Y46vqeDOW+DyCP0JOKdszf7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y2BdSf8EGI7DuE2t"
Content-Disposition: inline
In-Reply-To: <CAFLszTjhzw8i-28V+V8M+v41x5Y46vqeDOW+DyCP0JOKdszf7Q@mail.gmail.com>
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


--y2BdSf8EGI7DuE2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 06:39:43AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sun, 3 Nov 2024 at 15:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > We often convert hexadecimal strings to hextoull(). Provide a wrapper
> > function to simple_strtoull() that does not require specifying the radi=
x.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         no change
> > ---
> >  include/vsprintf.h | 13 +++++++++++++
> >  lib/strto.c        |  5 +++++
> >  2 files changed, 18 insertions(+)
>=20
> Could you add a test?

We have tests already for this. But they weren't being run, which is
covered by 4/4.

--=20
Tom

--y2BdSf8EGI7DuE2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0s8kACgkQFHw5/5Y0
tyyedQv+PinZORK8SaHl4YkdQlhc9QXK3xl2G5nVFnCVB6WQKfzwVg0MIInVVUYk
H8+0RNDFlTuD9GHkoHIvZH6PROq3tT4NeqBdtJynxRUK5kFtRWCBF8k28vqTOYdU
5CkmFO+ghkD5MSCVrS9BXfQDPeP7DnljWbtoVs+UdCSjFUBGCeZF8D4CmoeyCL2C
nf3javbCZOIe9AcK+myffLGO3Fe5X77D1Bupq32jU8HhzpdSoN+D3rAKn2CQG2H7
QelyCjw3KQ9cQOul/1G4Qyd+UfSP5UK1Oh+DxU4tnFgDg24+TN68GWdNdJeueyru
4tiML9tS3vyUGxDqVymB47irBU+hMVkj1UvJCfyJSdJ0viBJPvwnOYi/e4t330Ny
xClGd6xZ3A4j5/8qASH7TtNPPASBmeUkvmHG8rGwRhMcP9SScqbZiTAvViJk1F1/
CEs4acDUKxOXhQQ/mGuAo8MhixyyrqFepsEGOQcZI54y1VEsifvCMjV+zS6cIwcY
9S0BBFor
=vdDk
-----END PGP SIGNATURE-----

--y2BdSf8EGI7DuE2t--
