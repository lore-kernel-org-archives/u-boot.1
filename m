Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC90C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A664886AB;
	Tue, 11 Jun 2024 16:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QVh14QsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4B0886AB; Tue, 11 Jun 2024 16:05:13 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C367D84374
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f95be3d4c4so603004a34.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718114709; x=1718719509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wsYdwGisrY+ISQyhIm3LBOEMWa83qe+Tb6CtWnP6Cps=;
 b=QVh14QsP+fOnngTVPvcz/Uk1Bms90wtJdaAJ0Zg1r25JEXo4ngi5xPdH0f6RLd+ZB1
 EEbDj8S1Beie/+T603bCwMLBPUdu7Y0Jce5IdnAsT4NMzxgrsabbGLCxVmXWw7wYPLsb
 eAPc2/nkeZKMiszwlbYqiJZtJ6QMwLyiNcfW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718114709; x=1718719509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsYdwGisrY+ISQyhIm3LBOEMWa83qe+Tb6CtWnP6Cps=;
 b=UVh+f41JDKXLCpIeGJ8e9gWF4PHmltF1QtfDo5zKBNXUT/K4qo6moIGgtG1KCALYb3
 nekiD61dO9y67gIhOd8rn8twWmO+f/YqVRi8lWHhU0GrHKa/m8knoZ/nHqbIRp1jjLpt
 3/8R0vGLoocWOKRlh1ljoVygtTDzlj3Bc4GZreGTCM48/WbUYfO2d4PKKjVtOWn8MFQq
 kH6zjJ5L4mOps2HSuTjGDCEx84JwPg98O9aJBCnbxi9uEq21XlpkVw3keK/QYlYh4Bny
 YwTb18oDhmDz5HtrJ2TUz7tkBLeouWERSv5b84JcMHLBWcCA8ob1tsfCEbBU2uf2t3JL
 rs5A==
X-Gm-Message-State: AOJu0YzEhOOOIFbTMsypcVijRAS7aMLLPrJqf+7TWvHJsYriNeB6CC0Z
 udrAg1tyKmzT/4FcfKYnVaE+z0OEAGa6wkhV2+JE6uudnOU12SaaY1FPwomyZU4=
X-Google-Smtp-Source: AGHT+IHzUgMla19QFZ8v6UfcBnhuW5RDRvcveoGKBLLpAeRfSgVzLdbMFfiPnFTXQu1hwnQYm2ZMwg==
X-Received: by 2002:a9d:4d89:0:b0:6f9:b348:ddf5 with SMTP id
 46e09a7af769-6f9b348e025mr6474424a34.11.1718114709314; 
 Tue, 11 Jun 2024 07:05:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f992dd9d9bsm1105865a34.13.2024.06.11.07.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:05:08 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:05:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
Message-ID: <20240611135918.GD68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
 <20240610174450.GX68077@bill-the-cat>
 <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9gtw8BIfC4vYzoMF"
Content-Disposition: inline
In-Reply-To: <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
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


--9gtw8BIfC4vYzoMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:25:05PM +0530, Sughosh Ganu wrote:
> On Mon, 10 Jun 2024 at 23:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:
> >
> > > The LMB memory map is now persistent and global. Running the tests for
> > > the LMB module will result in the memory map getting reset, and this
> > > will have side-effects on the rest of the working of the platform. Run
> > > the LMB tests only on the sandbox platform, which is meant for running
> > > such kinds of tests.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > I'm not sure about this. We can reset real hardware as often as we need,
> > too. Did you run in to problems with this test on non-sandbox?
>=20
> But do we want to reset the state of the LMB memory map on real
> hardware? This was working up until now because of the local nature of
> the LMB variables. But if the LMB memory map is to be persistent,
> should we allow it to be changed for running some test? That would
> have side effects? I think running these tests on sandbox should
> suffice. I mean there isn't any aspect of the LMB module that is not
> getting tested on sandbox, right?

When running our test/ test code on hardware side effects are fine, this
isn't a POST type test that gets used in production. Do changes, reset
platform as needed just like sandbox, etc. And yes, a user running tests
that have side effects manually and then not dealing with them is user
error.

--=20
Tom

--9gtw8BIfC4vYzoMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoWZIACgkQFHw5/5Y0
tyxhJgv9GePKdXhOGTB/NRbIkb8XreKooPRA/CI26WcWSKXQPrKQQw/ewry+9oXs
rPufRCWGsTHaAHKtVzZRgwYQHaUuOpNmnnJvjidWTZDDvOXMpbbuUTL7eiL8NHbv
vaGGvIXu81es5MNSmfJcKd/xQ5YbRUFuU76yS9mf3PEugXErA3gsYMl4oalFcfkq
JG2zAJY5f5UozZxVcAVwxFPXykc/EXM3/gbs+fh9DTgQr0Vg4W9zu3f2L+r9Owlm
IhsI9gKztNYeSWM1YFxcAjbKoBmqBPkn0Rkt5OADo+yehVsqzePjTlcC3lpeRm0b
1LWvRguzWoH9DnLjTkf/HSayLUYXAfoQXTyab4FfaUIR2Glvevdyuu1ADdbSJJuF
Dxf5j28JCSCs4SyZ4inMGbyvC7GTotnIkDNSCyeT+KRVf3TQsYjmMxceu50JeFWE
kQvbHahmeJ7po41t9c6eSOFqEAKNR6wKfF6rLXgegF1K90ykD8inygKWe6BpN0sH
xNDbcDW6
=dbjM
-----END PGP SIGNATURE-----

--9gtw8BIfC4vYzoMF--
