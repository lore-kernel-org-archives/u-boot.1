Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD335CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B57983734;
	Thu, 16 Oct 2025 17:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dSRXbMXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5C183771; Thu, 16 Oct 2025 17:33:32 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0DE836D1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3c9859913d0so246605fac.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760628809; x=1761233609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4xJ2qtBGYYV+nlJTcKr+YnzYBDudgLoCjXlQgVM0Aw8=;
 b=dSRXbMXqQhR3zeUyV2ElMsD3/XxibSAZ00gV5SHFdx6dtOdl49WWOhlKXv3ITYhY9R
 vJw/cR/pN+DaCmqoJ86Pr2KaOF7rBuqNd8nGRVkTDogXsnEygJA4mAo2/7cysoCc6t72
 fGc49XClg0MggVdIZvCOC227Q9IQ7wE7QwiKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628809; x=1761233609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xJ2qtBGYYV+nlJTcKr+YnzYBDudgLoCjXlQgVM0Aw8=;
 b=dbx6QxwlLr9pGuKRHuRg9RNJrd1Olood38uBZQLkydYL2m779kdtASziKaqR2+BfU8
 akx/ZSSlK7ydlPo7mChnxM79PHrAy1JWYUpPt3w/ZHIsd1kR7B3iI3oodl6sBb3zszv+
 ZdklhK3Ypltnf29x+lhGtSxLrLezyfwxF6M3/qHkN/MWNPeXUPLmth4xORr1ws8HVb1l
 v4LrSiFw9oTkq3hd8a3yE9haepokJ/4vV9l5+6Wm1Z4c0a6CTHfnyp+Ibcq1sKdpYe28
 c7au1neEzjQ0ubbXL4I1uqccfeNhrbFvwlAkJx/lp1kCIv7TxER/VXLsYGRtJCPTPvXj
 cDiQ==
X-Gm-Message-State: AOJu0YwBZ4ncj7higt35nZF0EOe+VeBICtQys3zNsuLjZxVgfTiJeO7n
 B0fhLXo7rcPsrAOLzys9N1FjQgsf2G1lwZvivVPZ1q9rtwxd+9FncqKqPDwesPYu6Ck=
X-Gm-Gg: ASbGncvAsaIsLkS6OGw8xwvYyV03pV7F7IP/jJBgpYruKJetvOkXnH0RuYUwzZk3ROK
 8s+AXNE4GrpuWGX5kLtbvl/WWr5x0haGvFYLD2Baa1qTrtHS0z7GwVm/HwWfcDwTNxUAg5ZOn8P
 1x0emkcpcTWCzqJU1Wevh3eQ5nQQMT+29KBZqfxpMkpSat8aFRS5OWKSTZGMnA/3zLwPFfiOmeP
 Iukeu5rww3gQtOI1NKw94kRbUkuZltYNJwW5xx/lEkLppZs3bo/HC/E+pywnF//JLJMfabAMNEi
 qEp6xnw6SWX8QTjNoxC4zFJYmJjsJtF5/PDjo8IxbRseKJKW/2gHAAA8kw9jaNUnIpYHzc1BnuP
 KXaOU+9No9U2lkLRheojcD7DjMb4reFqOGVWi9DoNBc1A8yxVZy3llsbz1PD1ECH513OPoIWlrN
 5PfL7IdJbV6S+TqZsMZ0Kr6TXKcI6KcQ4E36ulZ34=
X-Google-Smtp-Source: AGHT+IFF+GkPW7VyezOxTydRNNdnsnpfl3Dziua5RBM4Fkpb/oZXuyo+Gw+PMd7Y2GwHyRWY703Gvw==
X-Received: by 2002:a05:6870:469e:b0:340:a15c:111b with SMTP id
 586e51a60fabf-3c98cf8444amr79132fac.14.1760628808751; 
 Thu, 16 Oct 2025 08:33:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8cc646221sm6255367fac.6.2025.10.16.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:33:27 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 01/11] boot: Try all bootmeths on the final partition
Message-ID: <20251016153325.GC6688@bill-the-cat>
References: <20251015154423.908468-1-sjg@chromium.org>
 <20251015154423.908468-2-sjg@chromium.org>
 <20251015190446.GS6113@bill-the-cat>
 <ca4c2345-3eb3-4e5f-b9a5-da29ae6b91b2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L2tnVoq8HLp3j61l"
Content-Disposition: inline
In-Reply-To: <ca4c2345-3eb3-4e5f-b9a5-da29ae6b91b2@gmx.de>
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


--L2tnVoq8HLp3j61l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 02:55:27PM +0200, Heinrich Schuchardt wrote:
> On 10/15/25 21:04, Tom Rini wrote:
> > On Wed, Oct 15, 2025 at 04:44:04PM +0100, Simon Glass wrote:
> >=20
> > > At present, normally when one bootmeth fails on a partition, we move =
on
> > > and try the next bootmeth. However, this was not the case for the fin=
al
> > > partition due to a bug. Rework the logic so that all partitions are
> > > treated the same.
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >=20
> > > Changes in v4:
> > > - Reword the commit message as Tom suggested
> > >=20
> > >   boot/bootflow.c | 34 ++++++++++++++++------------------
> > >   1 file changed, 16 insertions(+), 18 deletions(-)
> >=20
> > I'm glad you reworded this, but it's frustrating you didn't also post
> > this stand alone (and presumably sooner) as was requested as it's a
> > stand alone fix.
> >=20
>=20
> I guess you could still apply it standalone to origin/master.

I'll take the whole series at some point soon'ish. But this would
already have been applied if it was standalone as suggested a while ago
now.

--=20
Tom

--L2tnVoq8HLp3j61l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPEQRQAKCRAr4qD1Cr/k
CmqoAP4/ROlip7dfAekesRpv+zbq4g3+wUNwMfJQ5spIvPzAlgEAxbXh3Lz/9b36
tLVVUrq9EoxOHhXD0faGaELPTKyPog4=
=eSHZ
-----END PGP SIGNATURE-----

--L2tnVoq8HLp3j61l--
