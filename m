Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D3C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 15:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6981C80ADF;
	Tue, 18 Feb 2025 16:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W1RnyciS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9C980C72; Tue, 18 Feb 2025 16:12:32 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330DE80646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220bff984a0so100562795ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739891548; x=1740496348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=98f167mK0uMENYszMhF17lOS6kuNPNh5StCxxmlhmlU=;
 b=W1RnyciSSIJAeRtGXR5jVfv3Cwp9mhZVxpCh0ucavmCLmVJZwq+d+tnx8fIEq7shIL
 roixrDFJj1e2brskEdFx72WlkmJiOcolONHEIgT8B6W0/xqZFbo4lFFtfS8Wk7sT0hwW
 blTJhdVWFYH5CHGexntf/59o/62SHNkesK73Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739891548; x=1740496348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98f167mK0uMENYszMhF17lOS6kuNPNh5StCxxmlhmlU=;
 b=sFwwXfCsM4UQQWiShAzKLVAKbnwf1F651iJxgkx6ADWZ/43DwCsgOF7SZmwxeIONVG
 4p8nKp1vHJO5Cyu00Xr4TQ3/ec50s9hnb8nufhLtdrb2PdOBUMa/caNUZbaufKgvzx6A
 9s8dkdvP6n6cn+VeC9VgOUTbYCMTdYCBt4+Uvn84cigHBYHBImXSDy2BtTTlZPsez+OL
 rbUCUmP1z5ItyHf+Z4IErDmP+0fuWGg6y6YOyvjYYlotno51Du+GQmiGezpeaR4HFM/A
 IFGAxJwXXcyb6I5oZD7WA+/n7pe7f9TcvROuohHWasGTxu8aYKVpV9Qxjq7fCnuxwCU9
 xWag==
X-Gm-Message-State: AOJu0YwazKrah+BeqNJycX3zqLX8eqmsHBNB6hA27402WBfytDsPhz8z
 yRfdginmwWaFG9RFHG9IAKkBi4r/UWrZHLEcLWPVPo7nrEz9c4L3AYC0pZerU+UY3VtiptowTsV
 Q
X-Gm-Gg: ASbGnctxmrVOz1PjrdY5lUXKS4oseieKrWdrBayp1KFN7lEEdFc7WwB+memxDGUKG8P
 9hmX3ZCnm8osPzsTlWJMJVqIyYkqpdmkujLrNiWHZ277D4kGssH9Z+wJqRyFbFWPxnRbaPMJpgZ
 MBip4fyRagioHHIS1R9O746gzei7utFxu3GsgaSPsaiZ6qXtRov9LCkJ26jkArG4lqAZ1S8rBEG
 G4khJUmWcGhgwnKCqp4k2WxC66ToxBmFHkCCxWJ7TX+1t8ZHHljF2aYFL6dguVwdCDu/l0RMlgm
 n34qXOC0VqCEOg==
X-Google-Smtp-Source: AGHT+IG2sMC5coUZMtSVDLpuAHhOxMN9cIFEno0c0+YYYYnWnxQ2xdhB9Pzd4i7LI1Ur1UVbLheAeA==
X-Received: by 2002:a05:6a00:cd4:b0:725:9d70:6ace with SMTP id
 d2e1a72fcca58-73261798a0amr23147485b3a.6.1739891547592; 
 Tue, 18 Feb 2025 07:12:27 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326ea62b03sm5539800b3a.70.2025.02.18.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 07:12:27 -0800 (PST)
Date: Tue, 18 Feb 2025 09:12:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
Message-ID: <20250218151224.GE1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2io4zBXoINWAPsBR"
Content-Disposition: inline
In-Reply-To: <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
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


--2io4zBXoINWAPsBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> >
> > > Some test can only be run by a particular board in a lab, e.g. because
> > > they are loaded with an OS image used by the test. Add a way to speci=
fy
> > > this in tests.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Add new patch to allow tests to be filtered by role
> > >
> > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > >  test/py/pytest.ini  |  1 +
> > >  2 files changed, 23 insertions(+)
> >
> > This seems duplicative of the existing functionality we have, all
> > hardware tests can only be run on platforms which configure what the
> > test requires, in the boardenv file.
>=20
> I was afraid you would say that, and yes you are right, it is duplicative.
>=20
> With my lab I am trying to use Labgrid's configuration and not need
> anything else. For example, the params on how to launch QEMU and where
> to find the OS file are there, rather than in u-boot-test-hooks. It
> allows me to run a session interactively just as easily (and with the
> same flow) as I run the pytests and gitlab.
>=20
> In my lab, I actually don't have any Python things, apart from what I
> added for that tftp test.
>=20
> I wonder if I could create a way to pass the env__ stuff in from Labgrid?

Well, I was also afraid that was going to be part of your answer. A
challenge I see with the way you're using labgrid is that details are
kept there, instead. Is there some way to publish your configs so
they're also available for reference? I indeed have been lax in doing so
for the way I use it and so posted:
https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356583-1-tr=
ini@konsulko.com/
yesterday.

But then also yes, I think you need to figure out how to have boardenv
files so that you can have pytest tests that read from the config that
they expect.

--=20
Tom

--2io4zBXoINWAPsBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme0o1gACgkQFHw5/5Y0
tyzwpwv/S4DeW2wyn4UsEALyRgi8hF/e1iB4aTL1KcXkvaCiyj5AHjnQcKnpkF4R
YoYkQeNdXG20FYMOuyNqimKDYSo4BPco3JK+EQQq1Brmjf6lLiljKhSrA/0DYC1m
pGsVZ/DOv/ljOZJzkDKdLc4brlnqRDNKh+PPSYk/iYY69OMflTUYKA3ZMqvgYIa/
wF7KKn4HnwVk/zNWWh9iRzWK2Jirp0N4aPxQrWJY5JL+7TnNWSvOTp3VebWaGPWS
znbuaYgV1UOdoxnX9CmLqPXdpy3m97lH6w/aOiNr6H1Xw+4MnDJqaDS9oWHL/5us
seORhd+n4JZVm10RQLIjJDBK3IRvmme075jj+BYGJX0hpxrbigIlC6qLRDfwAh4R
zuMxXutQt68KIq9Fr8N/1Y2g8CSuPIoqMwhQj0Or41t+gHJ2cSwuw7KYzYbBzW7z
IvN7/SZkuMXPtnz8io+NaHq0HZHNJ/zHqv7OJ01FZ6fJRuWjIV/bAqSow+pNr0WP
/NsIiNib
=8Z13
-----END PGP SIGNATURE-----

--2io4zBXoINWAPsBR--
