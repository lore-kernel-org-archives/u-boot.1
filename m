Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9512C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E83787FE7;
	Mon,  4 Mar 2024 17:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JSXb+O+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88D4876A9; Mon,  4 Mar 2024 17:08:25 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2875C87FE7
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7882dd2b1c9so49346285a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709568501; x=1710173301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5pb+Sp6F3A9gJOFQ8XGLK1Fa+weWTr0kUi5nke0Z71k=;
 b=JSXb+O+wzwFVyokqGqXXWJk8TzZvcPHj7ohXbTVbuazszu+TtKyGqGC2rUV4ikcaOD
 bnzZIj5YHG4Ei8eIlJSjqVmv3Zzt0uDghCaXm1KsrpQpdAqHG6vk/IeP9t3pDs69Cgjg
 jN/2coFSiEtAa0nimJQf0lWIJZfAE6G7VJRHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709568501; x=1710173301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pb+Sp6F3A9gJOFQ8XGLK1Fa+weWTr0kUi5nke0Z71k=;
 b=F/N5eUT2456SdmXoG9aHLawb7d/cBNNk/1cQEjrs2XSN8lzqo24+c91lzy4AhAOqHS
 Ihy+4Uf2IGg3/kNzXHjwWlwj10CLve7cCFeWgI+8KldEyTejx5NRUFKhA4TRdL/I1U7z
 F0Gji7FxRoGK47JHl2vI46DuerdGHKKzusULDIipO3jzkqjM5gJ3/yXu8SmPSxUh38zS
 QJb+mVR6xFUhkvqDr9Guxh6jADsA1Qn5BdvdJoW2vPzlsNWrJMNL14oehnQaaxFOFslH
 1Mf56Q5pDvq5mUG84BCEE5kWd7DLdHRNJNAVeneWOObURnnn2ABwfIIUgTX2+MoG664m
 BgYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJi8cB2XM4h7+BsbVnRNFDB4Lxnnz+feTcXjVWI4J5tQ44w8t9X3VHWERPDQZe08hR27K/x6ts4FAioiT2960etzB0Tg==
X-Gm-Message-State: AOJu0YzZ5iuqohz9VE/Az07l6kRgfydLHlZBuaafTkjfpkNe/0gFuMnv
 4b6WWvQNDXnwlogRbitlP82I7/Y86tAuMFOARvJ23/no1Z6zy6HOaJ9l8rN04O8=
X-Google-Smtp-Source: AGHT+IFdXAfWazxv0q4UaXxj2x0LturjXKZkyvSzbkgJZiGRFvHRKoXWFGbNQzQGSQn3Q9k66xGaGg==
X-Received: by 2002:a05:620a:20cd:b0:788:22ab:1cc5 with SMTP id
 f13-20020a05620a20cd00b0078822ab1cc5mr6063979qka.36.1709568500901; 
 Mon, 04 Mar 2024 08:08:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 h24-20020ae9ec18000000b00787d6a14d0bsm4489621qkg.10.2024.03.04.08.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 08:08:20 -0800 (PST)
Date: Mon, 4 Mar 2024 11:08:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 0/5] TEE: minor cleanup
Message-ID: <20240304160817.GO1523872@bill-the-cat>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
 <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
 <CAByghJaHFxtQaZ3ZLSbR=qkeLP3GLfOZpMVcKkrkCUqmuhF94w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jp42/OQCE8MXZx5u"
Content-Disposition: inline
In-Reply-To: <CAByghJaHFxtQaZ3ZLSbR=qkeLP3GLfOZpMVcKkrkCUqmuhF94w@mail.gmail.com>
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


--jp42/OQCE8MXZx5u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:50:48PM +0100, Igor Opaniuk wrote:
> Hi Ilias,
>=20
> On Mon, Mar 4, 2024 at 12:16=E2=80=AFPM Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
>=20
> > Hi Igor,
> >
> > On Sun, 3 Mar 2024 at 00:01, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:
> > >
> > >
> > > - Address some spelling errors and typos
> > > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python te=
sts
> > > - Remove common.h inclusion for drivers/tee
> > >
> > > Changes in v2:
> > > - Fixed chimp_optee.c:37:9: error: implicit declaration of function
> > 'memset'
> > > - Applied R-b and T-b tags
> >
> > https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19808
> > this seems to have a few failures
> >
> > Cheers
> > /Ilias
> > >
> > > Igor Opaniuk (5):
> > >   tee: optee: fix description in Kconfig
> > >   tee: sandbox: fix spelling errors
> > >   cmd: optee_rpmb: build cmd for sandbox
> > >   test: py: add optee_rpmb tests
> > >   tee: remove common.h inclusion
> > >
> > >  cmd/Kconfig                        |  4 +++-
> > >  drivers/tee/broadcom/chimp_optee.c |  3 ++-
> > >  drivers/tee/optee/Kconfig          |  2 +-
> > >  drivers/tee/optee/core.c           |  1 -
> > >  drivers/tee/optee/i2c.c            |  1 -
> > >  drivers/tee/optee/rpmb.c           |  1 -
> > >  drivers/tee/optee/supplicant.c     |  2 +-
> > >  drivers/tee/sandbox.c              | 10 +++++-----
> > >  drivers/tee/tee-uclass.c           |  1 -
> > >  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> > >  10 files changed, 32 insertions(+), 13 deletions(-)
> > >  create mode 100644 test/py/tests/test_optee_rpmb.py
> > >
> > > --
> > > 2.34.1
> > >
> >
>=20
> It looks like it's a side effect, the test I added revealed a bug in
> "cmd/optee_rpmb.c" implementation, which I didn't touch (looks
> like it doesn't close the tee session automatically).
>=20
> I'll address it and add a fix to the patch series.
>=20
> Just a quick question, are Azure pipelines still used (so I can configure
> my own account and run all these before sending patches, as explained
> in [1])
>=20
> [1] https://docs.u-boot.org/en/latest/develop/ci_testing.html

Yes _but_ sadly sometimes the tests fail and need to be re-run due to
being (I believe) on the free class of machines and so they're a little
too slow and we race condition fail perhaps.

--=20
Tom

--jp42/OQCE8MXZx5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl8e4ACgkQFHw5/5Y0
tyxcagv/Y6PH1XsHq/TpRcju4hoIOy9DJ59BRZEYc3ITOFlXz1eyNg1c+1YiiItj
wBcYgRKdClCspmFWfoClO5DcJ3kHIz/fcMPtIOW8rktP2qBK7kOJ+jGa5jZq034D
bmZARLfWdqjEn3G3rKVi+iCccGxVHM0YbEs/C67ftjaFxYrzYwmU8KeEjeBkTJ5S
cJXXszgY7fY0vgUCCRerGEBLfMHAb1S+i8JRWoAerQke4+yf5nX8zFrg5AN/EN5Q
XVcky/TdT97m/Whc4h8n2yTEJ/Jq6s3BjDYJ1p8WMM5of0Rup+FLQ/14mEdq3IrJ
gGkdfuVhg7OE300KH/9w88JFzJMCcUBbbJ90YEPGlohst9oMEs1ECrqPzooMG1e4
jJi2VxIX3Z9lk2aV3QxAhYfzJqQrDHd75sIk5x+kklq4uDOAIbAp/2SYS2ydu2qd
go9j18x87bCpVZLjL2yY9JhWvHevyRnVlcPcehR3uebaQvtyg9A909L8Iw02Weoi
auzx5yki
=WGd2
-----END PGP SIGNATURE-----

--jp42/OQCE8MXZx5u--
