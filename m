Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33EED10F2B
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 19:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2124E893A1;
	Sun, 17 Nov 2024 20:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hWBRI6jG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252E5893A6; Sun, 17 Nov 2024 20:52:43 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA88891CF
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 20:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b14f3927ddso250647985a.3
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731873159; x=1732477959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZE5P0XfzqSw0TBq4a2nEPRbAt29BpSB6HON5eub60k=;
 b=hWBRI6jGtACqf63ovFpX6Ww2TJa+kB5zoVg2/OG7UjohsApeF+o6IFC6Kt86YScJBR
 xZRsXmWKC90hqn4jKnTvvWq/eKqAo2iGDFyph9T4Nil+A5S3ENqx9l3kz1pAHbI7+DnC
 vz0famqCjl2CGepg0ES8QOq91v+NQKi2GEyRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731873159; x=1732477959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZE5P0XfzqSw0TBq4a2nEPRbAt29BpSB6HON5eub60k=;
 b=vvpND6kAvv0kYSfURqUNEnkRsct6k5J9B9EwVUNPTY6fDRX34jVkXAn97iCop/D+BJ
 YIL4XRlAIkQWv5AqZiL0sKMPncOrSGOFo7/WGarUsP1KcdQ7D4QrqFowe2ZSXA2QG+x2
 durlYjy9T3+cRWD3D5nh6p/zzG1noItqPbBwW8dJU12bM366yUOhOhCUsUu4FL0GaeHh
 Ps3Nvz9dsr/nDZlyQRovrJoqL582pOhPSJAaeoJ61q/YPYfcP15J30pxS+vU1qcF9yj7
 u4Ll2fifZaNfSq+73mxJlherNorZIiP4CzLYb4P3FebFg0GqgQTJNYT93L/B7Fh4MzYa
 3AQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC12pR5umAet6DQtMvkbrKhIGRjTuuCmPbvGUXfi7qFlZe1ij091GSMLqEJ728eKSa4AkZAl0=@lists.denx.de
X-Gm-Message-State: AOJu0YzTHkeU63AeKFBk02OHAIVYOPDwWFgvzFtK47ssx0vegzyK2C1D
 BAqygtZZaTMUD06TX0v9NzUgEA4O4t8QKhV7htaxTDcG3kvgrnYJzyQLFhsT8Ck=
X-Google-Smtp-Source: AGHT+IH8QN9E7miVxKgRtcd2mF//r0wLbdvno5d1K2vc26eIUbjQEEn4w1SpTctYYC78bhyBL4n4ow==
X-Received: by 2002:a05:620a:bc5:b0:7a9:ab71:f820 with SMTP id
 af79cd13be357-7b36229f24fmr1443083185a.4.1731873159391; 
 Sun, 17 Nov 2024 11:52:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca30ea8sm389026785a.90.2024.11.17.11.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 11:52:38 -0800 (PST)
Date: Sun, 17 Nov 2024 13:52:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
Message-ID: <20241117195234.GL3600562@bill-the-cat>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
 <20241116003153.GC3600562@bill-the-cat>
 <9da1c8c2-efec-4c46-a159-f1efcfa6827a@iopsys.eu>
 <20241116162929.GD3600562@bill-the-cat>
 <CAFLszTh+nm8scykJfRfpiXeeZDWtVBGf60KoFxX2_eRdoXQfcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pwj2lBg+51/qy0fX"
Content-Disposition: inline
In-Reply-To: <CAFLszTh+nm8scykJfRfpiXeeZDWtVBGf60KoFxX2_eRdoXQfcQ@mail.gmail.com>
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


--pwj2lBg+51/qy0fX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 12:45:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 16 Nov 2024 at 09:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Nov 16, 2024 at 05:49:06PM +0300, Mikhail Kshevetskiy wrote:
> > >
> > > On 16.11.2024 03:31, Tom Rini wrote:
> > > > On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:
> > > >
> > > >> Legacy TCP stack is bad. Here are some of the known issues:
> > > >>  * tcp packet from other connection can break a current one
> > > >>  * tcp send sequence always starts from zero
> > > >>  * bad tcp options processing
> > > >>  * strange assumptions on packet size for selective acknowledge
> > > >>  * tcp interface assumes one of the two scenarios:
> > > >>      - data downloading from remote host to a board
> > > >>      - request-response exchange with a small packets
> > > >>    so it's not possible to upload large amount of data from the
> > > >>    board to remote host.
> > > >>  * wget test generate bad tcp stream, test should fail but it pass=
es instead
> > > >>
> > > >> This series of patches fixes all of the above issues.
> > > > Can you please work with CI to get everything there to pass? Thanks=
=2E See
> > > > https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed=
 for
> > > > help on starting that.
> > > >
> > > Hello Tom,
> > > Could you look to https://github.com/u-boot/u-boot/pull/692 ?
> > > It fails 2 times on ut_lib_test_udelay, but this seems unrelated to my
> > > changes.
> >
> > Yes, unfortunately Simon's recent moving of the tests caused that one to
> > fail more frequently now. I've hit re-run, if that's not something
> > available to you, just now.
>=20
> Perhaps we should skip that test (return -EAGAIN) for sandbox?

It would be good to understand why:
-       if (abs(error) > 100)
-               return -EINVAL;
+       ut_assert(abs(error) <=3D 100);

is not actually functionally equivalent, seemingly.

--=20
Tom

--pwj2lBg+51/qy0fX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc6SXsACgkQFHw5/5Y0
tyyi5AwAufqejO4T4ztwATRqF3neKKnWd8eRFPBmnubNPWAiPvM5g2NTidt/RvaB
O8GHJTqJwovonagoc+YrraV/RC3RUjeUT9NZhB4uW3J4jbf3nDcrR2yn7by6E8ia
nCJ01sVCpgHWiPHpxrjkQ34/mnldFm7qpduBKjExJmLsc4F0IG0uYOT4HSme7OJN
utZaxftSVs7QMaCuBE7VPRQ80pSD6WPU6FaxORtLhzBB9wzQq2MrshOtGNqPfq1N
bXII4YBbOgyIxvoLOsQpJBulVkpnq4kndS7q6B6Jnb4rBEVYxAQguOlKAIGHAZLm
KdwYX/0f81vFkpmfXsHY5MtK/8jwwwH1mFJvQYR2qU82js6Nl5kwTGqv8ajqzC4r
MDYdbSpofv+PzNsfboVptCOOcUtrc/Uak08fdrMnZgyzznroWetk56v+0rszmhlV
bx9ChYyN00Ox7SmlaoNNKjlpEK1lmvFlHoLb5Y53D5KFHAQkfCXA6+ye0B0nKcHN
Kdg1niJe
=AfLQ
-----END PGP SIGNATURE-----

--pwj2lBg+51/qy0fX--
