Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF0CF043B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 03:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53227890BF;
	Wed,  9 Oct 2024 05:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHQKfMQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD619890BA; Wed,  9 Oct 2024 04:09:58 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1F58900A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 04:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45f05a65398so7796231cf.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728439795; x=1729044595; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ogoWESSbzMwN+uqAMcDmgauOuuds7HoeAGAKuc7nk6g=;
 b=XHQKfMQVtPqjAHnhhqxJTWcDhvZvISuTrY1gVQoiXeTMJghIaGVIIuvhov/OqnUHZl
 SWS6oRgh2Fb8oM0Wwd8h9Fy04Y9ygsisZWKp7g1EU6mNm17rlIM/oii7nIpGlR/+lo11
 Pm6fx8gtRYQ4nJVhxd1vwjKYo7lzSuXeGjdrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439795; x=1729044595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogoWESSbzMwN+uqAMcDmgauOuuds7HoeAGAKuc7nk6g=;
 b=idXD1kWpZMDRVBnrXaIqy+n73QzbmRxJrTSNnKrZGzqWMT1ZPOZ4AP73OMvkXK8dvU
 pmh9uoUukMoDIRa9Tbep7uKpCeGBH9RRpk3ybLvgU7pMBm15dd6jpW97cFEZqhE0anUj
 xeVy2EqQk7n9m9YlvqxNAzmNgKkGOpMjmBanjRpmZIicDHkyKD7lUx6KATzWakkIE96w
 7ZpUZQpDR/RTfAfhq4IndayTsiaei0SECqnwTaeVTz6XVUoSq3hOj/3FCeI43fzVyG80
 0TZc4JGdon8EDoj+SGlQXtTL2UHXyBiZF0py8x3OypFEnXxlCxu5hx9E27Ke6k3nqCId
 QZBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNuq/WIQhPThlVhvc0eMfyeI4KoNo62/+zU/csJb3pnKOz0xWDjr6Yzs25W7q6z37sqYatSXA=@lists.denx.de
X-Gm-Message-State: AOJu0YzrFj9d2THr1ueiyfBtzqOoJKLJtrZY03JB+gADUZiVW4kZ/mru
 1yfH9Idspst15155RTbGE0NtqXG0FO91cUze5KSErlIyeTC8UVwgGzlcNBHbCq8=
X-Google-Smtp-Source: AGHT+IFYBaMzS6sRAUhltpNXuUsHgKvWnF2CI3c4YVcMH119/96ebk2VgiabOH6Rmeqhk7Ft6py+ug==
X-Received: by 2002:a05:622a:1dcb:b0:458:1a25:acc with SMTP id
 d75a77b69052e-45fa05062b5mr13067311cf.4.1728439795372; 
 Tue, 08 Oct 2024 19:09:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da75ed321sm42201131cf.71.2024.10.08.19.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 19:09:54 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v8 05/27] sha1: Remove sha1 non-watchdog API
Message-ID: <20241009020949.GG14210@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-6-raymond.mao@linaro.org>
 <87msjk5msl.fsf@prevas.dk>
 <CAEfUkUJPGpQtG1aWAVrsSvj1ceeTNkbjzX67xT4nONpZFFVkqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ARi3TM+jifLn2tuj"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJPGpQtG1aWAVrsSvj1ceeTNkbjzX67xT4nONpZFFVkqg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 09 Oct 2024 05:28:26 +0200
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


--ARi3TM+jifLn2tuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 11:24:28AM -0400, Raymond Mao wrote:
> Hi Rasmus,
>=20
> On Fri, 4 Oct 2024 at 03:50, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> wrote:
>=20
> > Raymond Mao <raymond.mao@linaro.org> writes:
> >
> > > We don't need an API specially for non-watchdog since sha1_csum_wd
> > > supports it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
> > > Set 0x10000 as default chunk size for SHA1.
> > >
> >
> > I have to say I believe this is a step in the wrong direction. Having
> > everybody call a function with that _wd suffix is ugly, as is having
> > them all pass some pre-defined constant. Moreover, nowadays what happens
> > every chunksize bytes isn't restricted to watchdog handling.
> >
> > So yes, we don't need an API specially for non-watchdog, but why not
> > just make sha1_csum() be the interface to call, and let the "maybe we
> > need to call schedule() once in a while" be an implementation detail of
> > sha1_csum().
> >
> > The same as with our zlib implementaion; we don't have a separate _wd
> > set of routines, we've just hooked schedule() into the main loop of that
> > inflate algorithm.
> >
> The reason I keep the ` _csum_wd()` one is to align to other hash APIs
> currently we have.
> For MD5, SHA256, SHA512, we only have `_csum_wd()` but no `_csum()` - SHA1
> is a
> special one due to the historical problem I guess.
> The minimum refactoring I did here is to unify the interface and make it
> adaptable to the
> MbedTLS library I introduced with this series.
> Yes, I agree some optimizations or refactoring are needed for the hash AP=
Is,
> but I will prefer to do this in a new series other than increasing the
> scope of this patch set.

I agree this should be the target of near-future follow-up work rather
than gating for the series.

--=20
Tom

--ARi3TM+jifLn2tuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcF5ekACgkQFHw5/5Y0
tyzo7Av+NNakX3SCRXdoGdeNIKN87d9zUm4LWIZ7c7Lzl3N+yXxBoDh+I9t7wW63
XHqZ19ImKvbaeGeQjP9i/uTnXw0FwF/YBzDJN9Dh0jRGOUx7Bauv9YhJIEH+xDMT
95f4ylLK6+KDPHC7mwKPZNjqnWQQXN9S+t1LO/EZ2MJZf6oW25qfQesdXelahm+x
36obZpuFsfqccnn8qyzi09nK7iMR3HDjIiNLey15EuwY7wZa/tYhMQFW8qzD0CQj
mBYKACC8LUedUWljC0JiN+xn5sI+jqY3+fXcusEVxhN+D4OXL9xU58G8gJ6kBRo1
ov6gTkuRZ05AKOq7vwck4BWyAja/eneqgabfFZAkaZQqlF8+v7m4BftspXiV9bEd
pQSgoCS0iW9qV4GixakiVd+y9jt3M36ohv21uuRWS1/AVB7+PZbW/EF8KLFmrxuW
dnExOpqMeDppOZfiozTdo1u8zi37XLYylDTnkmk3H1oWSENVQzKdDhbwVZQaHjAw
vVBtclR/
=I7kR
-----END PGP SIGNATURE-----

--ARi3TM+jifLn2tuj--
