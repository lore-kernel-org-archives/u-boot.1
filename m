Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF711D358D6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2716E83FFF;
	Thu, 29 Jan 2026 18:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o3NuEV+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3CC84073; Thu, 29 Jan 2026 18:16:22 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F8084064
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-66307e10d1dso547430eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769706979; x=1770311779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8R8Crulf+d2/HCXeSCvp0iTkY0GMMt2noaiOscl9Qm0=;
 b=o3NuEV+z3L8OufXMS/va6Ex22Vh7eAT4wq8C7SydNq/XAUhllvBi+vLZI53/RjkoCh
 +aDObw5CY65qJKDYjlG99so8ujW67/VYMfwZThP/pIvvcHEa5yqzCUYMv91VPV0v63SD
 VX105Qbs9xZLDGqfrbgFIRgrUVvA9+si2Qdt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769706979; x=1770311779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8R8Crulf+d2/HCXeSCvp0iTkY0GMMt2noaiOscl9Qm0=;
 b=n7ggbeJ/6d3Fcnat9bJ8FuF3uC3DgPrKrpNl7oV79Fwq8SEkKV5CZ+uffnJzERmhS7
 Qg5n6gc+nyiTJb6mcs93JbzDp5WemPZ8vjTByFUaSMXsaLiMUzWw6Bfj3dhvbLN/2Tnd
 g8UttC0eCjvsZaSkyopoz6anuARRSYqzzVPtt0yTPXT4mgsHxe7R+RQDDqlFm7kZ7dNp
 enepWmVI75MAQ4QvacNDSNNkf3CbmntyOr2dfWPEX5OwG/KIm1I/utcr9gkKRfig63MZ
 yV0SW1fPJKB+/y/HQs/H/EI7C5nVzyclhJ6+FRKmuSLAAAqMf4+Zpe+vPZW87b5H7LXU
 CwBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQdTy5eSOfPmN4b+Tsg/trd4CQThCtVELLdF+Xg6l1+7ikt7bjrz3DQK8oFmiP/gKiUet5lzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxAuNXvgpD2VN1ZlMybabzzGQWsy+8TsaGVfRPQ/HfMLkxNJS/4
 LQhXfjbNEf8WWH9mBd/5peRuD5v/XgHoLjC2dxKgCUkKZW6rAo806BwZWdhh0y65zhg=
X-Gm-Gg: AZuq6aIevgkcCDFn+h5YcXid6Rr2w9eAIkeaxcDhmI7hZF0V/1mSwZIPanrDkbtChip
 Ypf0vTw1TP/3qzNBKUqT/n1mIuKYe4TpWrbgg/EU5+dyA7fdy2QZlcEGdY/EqwOJAnEPKsHVzvH
 /n7G0FiXW5RWSEuwA4MpEzXw8nCLdf5YO0OgjX1xaysUnjpWXr3IluBWi8Iut5O3BbPtcD5aHo6
 lbC2I+IuvEYwWjZLQ9mYSt+vcFEsoW4GcW5cN5yKxe6tX8sQut137R6aR4a60khSUBbm8QoWsCm
 GqTugJMJo72ZX6y3B7PD3hNaMzIITocY/K5wwM0xwzR5dGA0It5Nl0/9UGWEvTMeRdrTQ9k1P9q
 PBbIJJwBagv9fveiwwn5O8MrbNb6uR/S5+/UL/QHGY1Uj1PXRSZ6uNgoZQnZiM4CXW1guuvSE7J
 5Z79ao2oxiJH8K4K12fTy3UZS+TBpJdIkE4yPfjr6UwH8bAsW9yfaW4m2HbKftOY4UqJskcZQw+
 WzPpx+9KHPeNjEJld8C/D8rT5eVxhc2qsocqZOEZPirIBJkdw==
X-Received: by 2002:a05:6820:4c08:b0:65f:6655:9db3 with SMTP id
 006d021491bc7-6630f031617mr103258eaf.5.1769706979262; 
 Thu, 29 Jan 2026 09:16:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9961dffsm3558543eaf.5.2026.01.29.09.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:16:18 -0800 (PST)
Date: Thu, 29 Jan 2026 11:16:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
Message-ID: <20260129171616.GD2044980@bill-the-cat>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
 <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
 <20260129165341.GC2044980@bill-the-cat>
 <a2760c72-787d-4bb8-a6e4-8a6b118967f1@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lN/jsumKWi7twhBg"
Content-Disposition: inline
In-Reply-To: <a2760c72-787d-4bb8-a6e4-8a6b118967f1@mailbox.org>
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


--lN/jsumKWi7twhBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 05:57:47PM +0100, Marek Vasut wrote:
> On 1/29/26 5:53 PM, Tom Rini wrote:
> > On Thu, Jan 29, 2026 at 05:33:45PM +0100, Marek Vasut wrote:
> > > On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:
> > >=20
> > > Hi,
> > >=20
> > > > +++ b/lib/gunzip.c
> > > > @@ -8,6 +8,7 @@
> > > >    #include <command.h>
> > > >    #include <console.h>
> > > >    #include <div64.h>
> > > > +#include <env.h>
> > > >    #include <gzip.h>
> > > >    #include <image.h>
> > > >    #include <malloc.h>
> > >=20
> > > This is part of
> > >=20
> > > gunzip: Implement chunked decompression
> > >=20
> > > so clearly I should move that part here already.
> > >=20
> > > > Maybe this should be included conditionally depending on the command
> > > > being enabled or not?
> > > Why conditionally ?
> >=20
> > A good general question I had is, what's the overall size impact of
> > these features?
> A more general question is, can we do without this patch. I think yes, bu=
t I
> didn't find a way to make the test pass without inhibiting this odd
> self-rewriting progress line. Is there a way to ignore output until speci=
fic
> line shows up or something along those lines ?

I believe so, but I don't recall off-hand.

--=20
Tom

--lN/jsumKWi7twhBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXuV2AAKCRAr4qD1Cr/k
Cu1iAQCXuKqs58CoUfNKpteudubhq4X9G2i6VOQrvwkNORC/SAEA6HTEjrwQEbi8
Vu5OzAp8njgYT34aiPTi/XhLXSCnhgU=
=QGFw
-----END PGP SIGNATURE-----

--lN/jsumKWi7twhBg--
