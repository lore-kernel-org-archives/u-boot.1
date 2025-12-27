Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3554E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4552F83B9D;
	Sat, 27 Dec 2025 15:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cT4P9+Ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA5283BE1; Sat, 27 Dec 2025 15:48:08 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB8E83B82
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c95936e43cso2826399a34.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766846884; x=1767451684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rjP6gWUUd5EulREiE+aU3b9+NBF4xDs2EIjV3hkJce0=;
 b=cT4P9+Ew+BMx/tINh6E2p5phlGYZusT1f4eTgL0OKKBmABCSw/f5IQBKmBEe8CGp9T
 K4fFhOKszPgp2M8Qsi/hFVkdJQL5bhjOjUJEd4/ljKLElH+zHtWf5UUlQpAsjXEoYeHz
 jPkX9/+FUnwY9oh3YBnINf+DpHx5QgCPCXVzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766846884; x=1767451684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjP6gWUUd5EulREiE+aU3b9+NBF4xDs2EIjV3hkJce0=;
 b=xNIfOWl9Ml3xol8ELqtCMwK/WoDrGOrjNk/gFez9Pe3E+N5Ss3SMugnXxR0JWUhTEu
 HL3IQ4HDnXlltLh2twhHGmJQELMhIIoXnvrEJfiD6GzL9vhjRsaMF4JTLLS06z81jz7e
 Y2lnPc0riNmxJWiCoVXbIz+eXhQHaPdoAMg+zhVk2OHSRujAGsWjiWWg7pVH37BozdYK
 b0qtY2MWfn198DDyta2EvLOMBp0+EbsV99AfaTQr5W4/mgsMrP5QFmyQUhbzZzeKozyt
 CLjJ0ENVvp+jaJk9SL//EIYMrZhOHIx174ptlijg0lhvQPqWYev6rqxmURbWlQTNSjSO
 BJMA==
X-Gm-Message-State: AOJu0YzPtNlf4vyjYJz2Mttq2HCieCjmQNf0qshWUHckfUic4s2hTEhV
 w0ToP8Ea+pZSuPdkPaUw8ow+DtdeVK07EOg60fxCtkeFut5K0HVo+VVOR6oRHZh07+I=
X-Gm-Gg: AY/fxX4TjpJ6FzkdMpNpUDZqsfVR9pzGdp8tG60QxdYaMHwPWfYzS2HI1xLLGoYUok5
 6BUZLRIVYZ4APhIZ0q/mBE/LEwb2NuOKaxX8c5caii/t5Hm3LRqqifnjiCkp+XnjD6ijfgIkY3l
 xy9fCTXCqDhFtUO+DOua32GCgStAI+fPd5E5r6UD9h4OovZxSLQX1fHCKGcA3/ZULm99Cy2q6qA
 ul909cBiKkiXMf+qxVQv8XPhJ9yR66HtMNCvDExV9YBJgm4ckYbQW17Y+LIi7u2KuXn6+JbbyPJ
 OSurWVG77om5LCHH5rQxngM1V784Z+63/8/KwzIn6TDLTXjwIVIaW92mAck6VueLvafYGIfB55+
 UTAhl0zXlNuCEIWhgj+7+6/6o6KikHmLSge6y4XxPZtHaekbtUP2niqu7cwuYGkgFS9dkTC1Qsk
 rkQUgNJOIm9o/CgRwAz25EGgDTZ3GKkp6WP21TCgHezyCDW7LLQG1WgDrF1ZdD
X-Google-Smtp-Source: AGHT+IHHEJQ3pqFxOmkz6OsOk+5jFQDusoec7RFh8o/VtxTKI3G70NPpZQ/XLa5uwtmU1AcvCs/MrQ==
X-Received: by 2002:a05:6830:448b:b0:7c9:5e2e:2984 with SMTP id
 46e09a7af769-7cc6689c9dbmr15174287a34.7.1766846883747; 
 Sat, 27 Dec 2025 06:48:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d3585sm16029042fac.2.2025.12.27.06.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 06:48:03 -0800 (PST)
Date: Sat, 27 Dec 2025 08:48:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Claude <noreply@anthropic.com>, Anurag Dutta <a-dutta@ti.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
Message-ID: <20251227144800.GJ710860@bill-the-cat>
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LBjCC8VmCGKfejsz"
Content-Disposition: inline
In-Reply-To: <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
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


--LBjCC8VmCGKfejsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org> wrote:
> >
> > When there is no device tree there is not point in trying to find nodes,
> > etc. since they will all be null.
> >
> > Add static inlines to skip the code in that case.
> >
> > Unfortunately this makes the file a little convoluted and there are
> > two inlines for ofnode_is_enabled() and ofnode_first/next_subnode(). But
> > it seems better than the alternative.
> >
> > We could also consider splitting up the header file.
> >
> > Also add a rule in drivers/Makefile to compile ofnode.o when OF_REAL is
> > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > ofnode_for_each_compatible_node/prop() macros outside the OF_REAL
> > condition, since they only use functions that have stubs.
> >
> > Co-developed-by: Claude <noreply@anthropic.com>
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >  drivers/Makefile      |   4 +
> >  drivers/core/Makefile |   3 +-
> >  include/dm/ofnode.h   | 714 +++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 641 insertions(+), 80 deletions(-)
>=20
> Any thoughts on this patch, please?

I'm not sure what you're expecting for AI-developed patches after we
talked on the community call about not doing that.

That absolute briefest review I can give is that it didn't solve the
problem either, and so you didn't test it correctly.

I was just planning to ignore this, rather than get in to another long
thread with you that I suspect few people would read.

--=20
Tom

--LBjCC8VmCGKfejsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU/xnAAKCRAr4qD1Cr/k
Cki/AQDRG14Kd2QbZcUFuqqYXNnK6SjT9C/x46CalxwLX2mYZwEApdWX/ahLQI8F
eEo80NbKTBpab9TEYrx90fNr18RNcAc=
=cAXJ
-----END PGP SIGNATURE-----

--LBjCC8VmCGKfejsz--
