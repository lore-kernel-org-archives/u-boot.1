Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B6CC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF2480756;
	Thu,  6 Mar 2025 15:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csoNxRAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD41A80F9E; Thu,  6 Mar 2025 15:08:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F12D80017
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6fbaa0582a6so14355857b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741270095; x=1741874895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uNINuYJYnSn2WqYyTaAVVZREXlkKXFoIcWx/DBIjxVA=;
 b=csoNxRAS9i4GjJByHxMo6zilMhC9cryzGAM1G8IvJcGU2Rwj0C7MoYlR1/7QU4OsaR
 NCUA8AQFPjYOyUQiQ/LmIGI+bapNgXl3kzckGAYB5FasLSslymF67xD8hQkpRpE+dYFY
 xclSuD/rjrvII0Wz5vnuxllLrKzNBgv3OJJ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741270095; x=1741874895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNINuYJYnSn2WqYyTaAVVZREXlkKXFoIcWx/DBIjxVA=;
 b=l5+J0UnG1ztQA2vWxGf0Vk1gVZcZk0v0sFZ09aOTzNNd3fXGxMGLzfPWo/OEC7cmst
 tQq0nJ2DcfuttDKOr6XUhkUmeXdfHl4rCIX+QbTLdDtquLLD9yR0DaIBQPMZDj0uc994
 Hu9dmgU+5At6/gA4nkyvSBW+dzTxtDOEoQYx57yJ8dNKKNVXA86U4dmCFcitNc8Kaa/o
 h/ZB8XFjr6y3kjpN2gXrfcoRRiRBHstD11eUigf5Zdv9u9EAcNFC63oPSOdKjNl6huB0
 RJ8bRtJay2/Yr4CdYI/ogDELI5FuI0350BJ8em0/MFBtaBTEnOiceDGHunowqyHZKQVG
 3hAQ==
X-Gm-Message-State: AOJu0YzVgJWUBT06TlxdtFdEUMH5DhLXoFziO1+hCen3xRAwYqcs/593
 bCJ5TKLGymo+3GeH6XxSgGTpPbbP7iezWZn6FPmJkUeC8XLe0VKu7xNsOd8+1/SuzE0XwxYMZwb
 e
X-Gm-Gg: ASbGnctiLi1O68jCc0aZwoyRxr7y8Uls6iYlAqM8R4c0RmwscRWIzenZYCfQkIhxrjD
 W8f+zstv6lroeUiK3HQUKE6unlPUQk5GA51jM1mBoH4pyCIey2Pej7/qjV3VAZuyziwCSh9MV7U
 /aAHxnz6UIFLZRJcy6BuaIWB6XSD1HUaAUqU/ZbE6PHKXqHN6bBnuTZdlkvHpfmWTkGDpzB/Q/h
 xTRogC+V8Eg9jL8EWNbzi1dPxzv2n+awHCiWh8qR4bbb9PpfvFh17FmsgkNOzrGttga1zh1K4Nk
 yY6yiZ1Jzdq9RJ9Na//30p8dcDNH9AsJTnxvJc5n9IN1ng==
X-Google-Smtp-Source: AGHT+IENn7dVQrkWqCeySNqJz7HgYS8lajeaER/P6feqxOVntadYS+ItPXAAdfGgj2x1Q1Y6znBFxw==
X-Received: by 2002:a05:690c:8d19:b0:6f9:c8d9:50f with SMTP id
 00721157ae682-6feaee273ecmr48269447b3.2.1741270094764; 
 Thu, 06 Mar 2025 06:08:14 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a8b302sm2633017b3.64.2025.03.06.06.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:08:14 -0800 (PST)
Date: Thu, 6 Mar 2025 08:08:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH] Kbuild: Always use $(PHASE_)
Message-ID: <20250306140811.GZ2640854@bill-the-cat>
References: <20250304204116.2834889-1-trini@konsulko.com>
 <CAFLszTgzPq8Sdmk0Fqh19n-TkNBAJ+JwscNfYchRzE1kWQjrXg@mail.gmail.com>
 <20250305154953.GQ2640854@bill-the-cat>
 <CAFLszTj98k8RroqGaBk0RA+tW0HjsU3=nzyd2JR7Y0u7AHvjaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W/voDYnAAnYx3Nq1"
Content-Disposition: inline
In-Reply-To: <CAFLszTj98k8RroqGaBk0RA+tW0HjsU3=nzyd2JR7Y0u7AHvjaA@mail.gmail.com>
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


--W/voDYnAAnYx3Nq1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 06:57:11AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 5 Mar 2025 at 08:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 07:15:50AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 4 Mar 2025 at 13:41, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in o=
ur
> > > > Makefiles as part of the macros to determine when to do something i=
n our
> > > > Makefiles based on what phase of the build we are in. For consisten=
cy,
> > > > bring this down to a single macro and use "$(PHASE_)" only.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > >
> > > > This leads a little bit of dead code in scripts/Makefile.xpl that I
> > > > didn't remove as this is an RFC. This also omits expanding on our b=
uild
> > > > documentation slightly.
> > > >
> > > > With the following patches applied (which are correct regardless of=
 this
> > > > RFC and so separate):
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250304203235.283=
4031-1-trini@konsulko.com/
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250304202436.278=
3784-1-trini@konsulko.com/
> > > >
> > > > There's no change in the resulting build before/after this patch.
> > > >
> > > > We could do the other direction and drop $(PHASE_) in favour of $(X=
PL_)
> > > > but that would require updating the logic of how XPL_ is defined.
> > >
> > > These are not the same thing at present:
> > >
> > > XPL_ refers to any xPL phase
> > > PHASE_ refers to a particular xPL phase
> > >
> > > Since it doesn't change the build, it must be fine. It's just surpris=
ing, to me.
> >
> > Erm, this is what we have in scripts/Makefile.xpl today:
> >
> > ifdef CONFIG_XPL_BUILD
> > XPL_ :=3D SPL_
> > ifeq ($(CONFIG_VPL_BUILD),y)
> > PHASE_ :=3D VPL_
> > else
> > ifeq ($(CONFIG_TPL_BUILD),y)
> > PHASE_ :=3D TPL_
> > else
> > PHASE_ :=3D SPL_
> > endif
> > endif
> > else
> > XPL_ :=3D
> > PHASE_ :=3D
> > endif
> >
> > Which is why I sent the two fixes first, for places that relied on
> > CONFIG_SPL_FOO=3Dy in a TPL (PowerPC and their spl->tpl->U-Boot chain) =
or
> > VPL (sandbox didn't set TPL_DM_I2C but did set SPL_DM_I2C) phase of the
> > build.
>=20
> OK. I believe this means that we won't be able to say 'build this for
> any xPL' without adding a separate Kconfig for each phase where we
> want it enabled. Is that right?
>=20
> If so, that's fine with me and I would prefer it.

Yes, there's never been an intentional "build this for any xPL".

--=20
Tom

--W/voDYnAAnYx3Nq1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJrEsACgkQFHw5/5Y0
tywcGQv/fj+M0KaHOIqQRd4qCuTJhUphLF6B+EQJpOvJ1I7XfS0wdPhCWIviLRYg
mKcLQohJdLD5KqzSQZTRs/6CpfAdfpD6WZue3Af80ifEZd0T5EeXg+ybLOw66vOE
bKyK5XpEByex8uWFWiXKIO9eEhH+4KLZN8fiK5XRUjZ+iX5hws6riKLgNHSp1UF1
87A/tuGmQU2zL2x1TvhZ6KERF5LBZZJRn8Jko79wFPfxEH/YlkliQfZm6KbrCSee
VPXuXrcH7n0aQmj3+sQvX9e+RvDq/5e4rScBuQ5mDEr+vOzny1cTmLv9+68RNGOr
Kkjqf0BqkENt070PCchUc0LnpZqQc4/MFJZKrjKML3egOVhDcxH0zEZeRfFkEQq+
6jmZ68v+8T2+ZVXLGEUMLFzfXQm87LBh2M5yQiHtdr0tUJO7FiMRLzpQ8QjX5qEq
pWrVdRqC0dr4iBm/BZiXRhDm8OjVio810x8DXjH5l9F2v9u3KsDYuc6zBFZ3396N
U+dqEzTr
=gaFQ
-----END PGP SIGNATURE-----

--W/voDYnAAnYx3Nq1--
