Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD55E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 16:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0026B88E3C;
	Fri,  1 Nov 2024 17:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cT+HH2X+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A782D88DEA; Fri,  1 Nov 2024 17:24:37 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6851F88E3C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 17:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6e3cdbc25a0so23581537b3.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730478273; x=1731083073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=br7KZ05vvM6oERHZBsB/nx0LqUaJC6lVgdNiXH0iqSk=;
 b=cT+HH2X+jUJoedICf42lHY8asaqhFxfL/FY4kS0CA/+xiMi8DH4Z5hxaXtY98TzXB4
 flLjsLT4aiaP/9Uw/cckDywCrkGhjzRUzv4a4yvpT3SV+Aymwzsbx9lt32XWOkgppErH
 QKjfJxROsLq/yuBVF9B+2KxA99k5N4plr7jDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730478273; x=1731083073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=br7KZ05vvM6oERHZBsB/nx0LqUaJC6lVgdNiXH0iqSk=;
 b=trPH6YgisqY8fd+WcBCwGPBjf+tKmfYcot6tf1k2TQMDqMXNZnIAorsfFimn7y8RfU
 IRQwzwfSAmyOD/dn2rwc6MLBSICeUXmiqiQEmPSD7sVc/e2cziuIlZAUdSi4Y3ARc22A
 30h85ZKcLhvXdiAE8Ze0QgY7Mvaw8l+WdJKNeTAkaRu+ccLMv7PYWG5lBpwFxMI/6loz
 ibync1HeqZLZennmCrWBREvhB8+gCgMC5EJiFkBWj+oxvV6UL1zp/SkmgYgBsBPNNHk7
 2Hhvbtk6QyH3mq7HhMPq4MYQBiv1bgbTYt5CVA8pXZeeUD4TpJsREtk6t23luaY7gQ1u
 Dz+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbBFo1Tc2fx+DBp7nVewJioId1xgHA4D3RkJxkYOsk0oyN/7NWf67MqkMH/Ygs31rCqyiNJLA=@lists.denx.de
X-Gm-Message-State: AOJu0YzS/cKUbwzE6CnV8OreKY3/Xg/L+uYTblAHm3ZW/k34aI92yzs2
 2tMHXFCgDO+yd/kQ4CZgTOK+0q0miHSJkb5sPYjfu/8xnEd2zpdg3POkI8HrMIk=
X-Google-Smtp-Source: AGHT+IFklOdSctWwRl1yQ62nbJ3lXSDxT6i8EqXO7FLUV2to5jwHFwRR7OJICU6N8ZOPHvsc4iBqmg==
X-Received: by 2002:a05:690c:730a:b0:6e3:6b73:be66 with SMTP id
 00721157ae682-6ea64b4e273mr49014307b3.27.1730478273206; 
 Fri, 01 Nov 2024 09:24:33 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0cc16esm19986321cf.51.2024.11.01.09.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:24:32 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:24:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
Message-ID: <20241101162428.GO3600562@bill-the-cat>
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
 <82825184-692b-4245-8935-57d87f84692a@linaro.org>
 <CAFLszTijo+=OuCXBKfDKKyL=LajNzZosovfqRLGc92B1AccLkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5G9oB9Qd0MTw+Zsc"
Content-Disposition: inline
In-Reply-To: <CAFLszTijo+=OuCXBKfDKKyL=LajNzZosovfqRLGc92B1AccLkw@mail.gmail.com>
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


--5G9oB9Qd0MTw+Zsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:37:17PM +0100, Simon Glass wrote:
> Hi Caleb, Tom,
>=20
> On Mon, 28 Oct 2024 at 22:54, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
> >
> >
> >
> > On 27/10/2024 15:52, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> > >>
> > >>> Something this breaks, so add a build to keep it working. Since san=
dbox
> > >>> enables a lot of options, it is a good board to use. The new config=
 is
> > >>> created simply by copying the existing sandbox and turning off CMDL=
INE
> > >>>
> > >>> Once we have tests for non-CMDLINE operation, this can be adjusted =
to
> > >>> run those tests.
> > >>>
> > >>> Create a new build which will be picked up by CI. Update the mainta=
iner
> > >>> entry as well.
> > >>>
> > >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>> ---
> > >>>
> > >>> Changes in v2:
> > >>> - Create a new build instead of messing with CI
> > >>>
> > >>>  MAINTAINERS                         |   1 +
> > >>>  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++=
++++
> > >>>  2 files changed, 366 insertions(+)
> > >>>  create mode 100644 configs/sandbox_nocmdline_defconfig
> > >>
> > >> Please use the #include mechanism instead of a full config that will
> > >> also now have to be kept in sync.
> > >
> > > Hmmm we still haven't come up with a way to deal with the #include
> > > mechanism in buildman. I've forgotten where it got to, or even what
> > > the problem was?
> >
> > qcm6490_defconfig needs to re-define CONFIG_ARM=3Dy for buildman to be =
happy.
> >
> > Why is buildman looking at the defconfig anyway? Maybe it could just run
> > the pre-processor first?
>=20
> It could, but I really want buildman to understand things. If we can
> say that '#include' in the file is the only thing it needs to deal
> with, then I believe we can update Kconfiglib to deal with it, or
> perhaps preprocess the file. That uncertainty (as to what the 'spec'
> actually is) is what has held me back from looking at it too
> seriously.

Given https://github.com/llvm/llvm-project/issues/78778 I do not like
preprocessing the files. I want to stress that
scripts/kconfig/merge_config.sh is the canonical way to merge fragments.
So if taking the Kconfiglib approach, implementing the above but in
python would be good (and we can suggest that #include be the normal way
one file says to use other fragments but not let us be blocked on making
this better).

--=20
Tom

--5G9oB9Qd0MTw+Zsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclALwACgkQFHw5/5Y0
tywVHwwAtmPHjOADLYMOEysdcSzuHgSC1X9jG8hjWzIsosIm990JGfPcwYjnEl9+
0vw4Wowi2WKYa4gnjYGlZLOgqAFFW4mw3hbE6tTSB2lUDIvK1ZhqEM09xaYKsz4N
dMEfMeyxxLJNiJPT8MK0tlJdvvkDnhPCw56XDNZs/yCgKeK7Y/lTr6U1Sw0KFiW7
20ggJ8i3FZ1LjFLVJDCQbP51dNXwADgT1kBJ9pmCT943scseSNX7Gj8P64nZXTDV
XOa6r3AYl8qQv36h16ugvuWoECd7qqL0G9yGqDpIe9pJ4bpCwr1+BoAJSZI0Rs1b
fqPa9YJSZ9uA0TrvbjPJseknBkLQlS1gjuPdZ41q4dqZt9KyI9He2qOTUcXGUS1N
lhVQeeQpgDeu7FoqqsFvRH1K/bLXX0gr4k1YQEwRtnz0TQosxgUtgOFRuxQZ0uxb
X4tWC5sOBVN0zA3clfLwK6WY82y5jUANVQryM/i/ZUq/vbgIpV+8qJRaSGnHwXcp
4eECyXI/
=f4Rk
-----END PGP SIGNATURE-----

--5G9oB9Qd0MTw+Zsc--
