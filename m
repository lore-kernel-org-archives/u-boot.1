Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891FEC54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 19:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8AB879E8;
	Thu, 29 Feb 2024 20:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oYA9MryJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6211287BAF; Thu, 29 Feb 2024 20:38:51 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487948744F
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-608c40666e0so14162957b3.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709235528; x=1709840328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ft9622BvABs2meTodQLU6H7Cfl81tYYYY14sAxcKPlE=;
 b=oYA9MryJk2dSakofBaLTYsZnFG2p2UqfcfWW/GtqnsFX8y5ouFW32fNR78ehe4WRWN
 Oni5G3tW2iurmAYujba490+6oPoJeXJupJaUKg7P7W8miqSZCb0Fih/iRgYz4hSxjAqF
 0eilG7iFpCooX1Mev61N5EsFJ8u5SMLZfdVZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709235528; x=1709840328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ft9622BvABs2meTodQLU6H7Cfl81tYYYY14sAxcKPlE=;
 b=Z0BAo1t19Ss/o77C6DcqlJVfFVF3NMY90jBdt/zICKmRbKOuM6GThC6e5fwFLTRWpL
 b58anENVPojib0b3JkVnvMh8HJbLVwFT9yMihBhzGw17XSz/wNe98A2IjbXnEaXoilx6
 Kx3GPd4vozyNtK1z/qAQFdo0ZKLO+LqnYrSYjCJWM7IWxcz0HfzuzevD9Eho7pMAgnXa
 flveKzBpFbCT8Ti1pFprL15Ih+o12OhfaGdrHu5KhuSjVWo7sRE5j4x+LOzEwdpPW8Al
 e2bO3L8nwyop35EeQFCHodUp42VqpZFTh3KmTRHesTDNQYIeIfacjxqBK2frE8QqfQ31
 ispw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1/o4ipS3fxD1YgpSfFYk24ZYDxqhYEh9VFCqRZvL8j5GpyHgqyISaBWr+DW3hG8It59x8WIMN2VH6Z0i3/FzHM+x/lg==
X-Gm-Message-State: AOJu0YxA0B67zqOrrk3pC/HNUyMmGdXmy02Vr0BGUD6bTxczAmlvACnO
 xt4EzLfEGlydOCNXIodPshVfDrH5BLmBmKokaPvzawDI6q2PmempxrBfi5Q7npM=
X-Google-Smtp-Source: AGHT+IHaDE7KMHP0c/hyVQAxV/yoy2KGeFqWd/LduX8Mp31CFQB72P2TLJ7Bp/Cp9hc4qgQo8V99SA==
X-Received: by 2002:a81:a042:0:b0:609:2c2a:1115 with SMTP id
 x63-20020a81a042000000b006092c2a1115mr32428ywg.30.1709235527881; 
 Thu, 29 Feb 2024 11:38:47 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r8-20020a817608000000b00608d5aa7cddsm569108ywc.23.2024.02.29.11.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 11:38:47 -0800 (PST)
Date: Thu, 29 Feb 2024 14:38:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
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
Subject: Re: [PATCH v1 0/5] TEE: minor cleanup
Message-ID: <20240229193844.GX3040305@bill-the-cat>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
 <CALeDE9NND+LY8MsqPEMXvDDsZwDsyC5Gu+7imPZ6H+XjO1ndyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nVX8bz33C2toWgkA"
Content-Disposition: inline
In-Reply-To: <CALeDE9NND+LY8MsqPEMXvDDsZwDsyC5Gu+7imPZ6H+XjO1ndyQ@mail.gmail.com>
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


--nVX8bz33C2toWgkA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 07:25:10PM +0000, Peter Robinson wrote:
> On Thu, 29 Feb 2024 at 19:11, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, Feb 14, 2024 at 7:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foun=
dries.io>
> > wrote:
> >
> > > - Address some spelling errors and typos
> > > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python te=
sts
> > > - Remove common.h inclusion for drivers/tee
> > >
> > > Igor Opaniuk (5):
> > >   tee: optee: fix description in Kconfig
> > >   tee: sandbox: fix spelling errors
> > >   cmd: optee_rpmb: build cmd for sandbox
> > >   test: py: add optee_rpmb tests
> > >   tee: remove common.h inclusion
> > >
> > >  cmd/Kconfig                        |  4 +++-
> > >  drivers/tee/broadcom/chimp_optee.c |  2 +-
> > >  drivers/tee/optee/Kconfig          |  2 +-
> > >  drivers/tee/optee/core.c           |  1 -
> > >  drivers/tee/optee/i2c.c            |  1 -
> > >  drivers/tee/optee/rpmb.c           |  1 -
> > >  drivers/tee/optee/supplicant.c     |  2 +-
> > >  drivers/tee/sandbox.c              | 10 +++++-----
> > >  drivers/tee/tee-uclass.c           |  1 -
> > >  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> > >  10 files changed, 31 insertions(+), 13 deletions(-)
> > >  create mode 100644 test/py/tests/test_optee_rpmb.py
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > Are there currently any comments/objections that can prevent these cosm=
etic
> > changes from being applied? If there are - just let me know, thanks
>=20
> Probably awaiting the next dev cycle, we're post RC3 now so it's
> mostly fixes landing ATM.

The -next branch is open too now tho, and I am picking up things out of
my queue. And other custodians can as well, time permitting :)

--=20
Tom

--nVX8bz33C2toWgkA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXg3ToACgkQFHw5/5Y0
tyyU7Av9GAzk72YPi0OcpmfE3Yz+hN9vzc0XXUfeFC8WbZiaVsNV5gK9n8NFpwlA
2TkW7VxKvZ9HWVRr2um6Xg28eCaB9UEMmKjbaTQAiPr8SdUK6IdWrk7JZh3PYgec
LaH/hfYVjFeGzB7lRmDIqDocF5hNe3G6NS0FHgr5aV2lfeJ/2HFJ/oaJ3QZJAQQL
v28IqZWPSouvfG0Ure0Mkxq5VaakhVq+OxDsPeAHIe7JmId+nfsQ6nh3ip3PuJ0y
Zl7mma2MWoeXOtm2SLqkiIMUKTScuki0fmG2npdc8DKQMZhwRLbwRyIGpkH6polU
G2r2ZWRjnzY5Q5V7BGZytH9egU5oynTsqvPA1/C8nXZpsi0RZ7GMolr8WkmxrWWF
JaL2Djw/2f6I2B6URxftYmKZ/5Us7awgARrVrRE42nz1hg0vT09VGDd3Z58+jJf8
t4/saZN3phrYCzIXKEOcUYS40MlquWY+35NAdIDfFZ/jwosu+h+ZDBK0vD1SWCQw
xN0XQvH2
=zgUX
-----END PGP SIGNATURE-----

--nVX8bz33C2toWgkA--
