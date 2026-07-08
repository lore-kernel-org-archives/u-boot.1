Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45970C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 19:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD9C84A27;
	Wed,  8 Jul 2026 21:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nmffw+q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2D284A12; Wed,  8 Jul 2026 21:09:27 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22C784A0A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 21:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a30bcadd96so80447eaf.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783537763; x=1784142563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkVF0T26SB2Oi7MlpdUZOaKA17Z5prPcXIESqCPMsGM=;
 b=nmffw+q6X+r5+VVmTfUwc5NvlUpuJ35lTiHyzRrSra020ZwCl/yxghlnnVw05BYY0g
 ulKWsfL6lLFCR964XEHJIqhqOvqEmRrN2e+hmQDvoTF5RSxCrBc4dhGTCnWccOKf2p4K
 GQyBdy93RGmnK5v6tGmaF9A58Y9ttyenePV/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783537763; x=1784142563;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkVF0T26SB2Oi7MlpdUZOaKA17Z5prPcXIESqCPMsGM=;
 b=HNxjTI2YEdOKoj/mdIwENNa2zYP/SnnPKXrekIDAmoSlOlG6aXJfbFgUobmvfdfGiW
 HE+wdMYMpdcmmmszm4925Fyeopz0iEcD2UeL8UAf+PVNKHW/2TixsOR3L+MPcWB1qJxg
 9ahtMMZ4dOwefhnPIT67zZp2X5oTlgP68bhZba0Qqd/H3ANJA3SK3W2Y7wIGri+5+wYB
 uD8hm7DmLKCKfZLyklND43VQi1IJQWztcIoA4CabUQ+0oaRkmXCuEHdfdtvB5qA7oH9s
 fiQkczEQSW/nh9iqcOsQFh8nUuQyGbNaehDSbuhkJCTFlR5HCkKFe531+FWvdQmVbeun
 pfew==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WmQW0bxKs08LsWXOdIoRyzkPki+CuC85/1vaoA6JmB37HMQCvnkRbxofYQoKztsVHwgKHbIs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7OXiywsPyyDisxWcmHHzMe+siOF6D1sP20YMlFzIIQkhCQ2ln
 wxgZ9cwEypGWjmTeS9AmGjJ6rzNFvqGxSxge7ukyI0pY6yYz2Dew7qRiTanQF7MCSkH6MyrN+o1
 AuB8gDMA=
X-Gm-Gg: AfdE7cmaf9DPjdmkhfsGgiV+P2X0JIQ5hKs4DOAfINy03fJzf5azSfDoug6oWJ8tYgR
 NHd/5uzm7ZIhUYkAm7GN0Re6aU4/u5gCqOifJtauK1wajWbNQorzfQL3Wmt8otb3TXk2kOGx6gK
 jXeHLvlykC0rBB3VF1MjqTKFAzXEvnuqLdUeso/vw9ir65P5j4joWkTjotJeZ6IahCRrjQkK1zP
 oI4IWNIGRR277F9mS74w5dKeAhtV5ksMEDOa9YWu7V6LUVh8vAU3BXnNXMhOAkWvooZvDS4xDcw
 8JnVJ9H2zp7lb4rlnWm2Km3W5qYydJfb3bH499nXcOldMkriTo4xqo8Qd5sJDIae10uU82s7iJK
 /DY8iu2qFZ7GmIppN/hPQl75LQdBIotpxOP+XlmqsSVaiFO6dJT1QWt4aKXJtCUX5I1MvR9w6yw
 uNqDVHhPWK0oiJa8Y64LlL8BJv/bmFgf8RjMOacw74WWWR17E8bGV9x0k0gi6IXRhcMQkpbEV83
 YoU40YxGats7ynxs1C0/ZpD+2M91l3AzzGpQQ==
X-Received: by 2002:a05:6820:308a:b0:6a3:691d:66df with SMTP id
 006d021491bc7-6a36d98959bmr2355409eaf.28.1783537763489; 
 Wed, 08 Jul 2026 12:09:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1c8092sm17171985fac.6.2026.07.08.12.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 12:09:22 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:09:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 6/8] string: add strcasestr()
Message-ID: <20260708190920.GH749385@bill-the-cat>
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-7-rv@rasmusvillemoes.dk>
 <-L2J8wyvBfsoNZ_oj3Z9kf9VHJFXGSNTsIaWTbFhAyLP_MEWPFZBwC5BJtJLV-ucgg_88lw_CVudQN9BYQaJVQ==@protonmail.internalid>
 <CAFLszTi58-YBJU=Z-Ab00xSTaaFGkibyogd4dP_whYv70MqOpQ@mail.gmail.com>
 <878q7luxxg.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GH2IfBJ6wDZiE1rU"
Content-Disposition: inline
In-Reply-To: <878q7luxxg.fsf@rasmusvillemoes.dk>
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


--GH2IfBJ6wDZiE1rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 08:40:59PM +0200, Rasmus Villemoes wrote:
> On Thu, Jul 02 2026, "Simon Glass" <sjg@chromium.org> wrote:
>=20
> > Hi Rasmus,
> >
> > On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> >> string: add strcasestr()
> >>
> >> While this is not likely needed by any 'real' driver code, a later
> >> convenience addition to the 'config' command will need this. As usual,
> >> the linker will throw it away if nothing actually uses it, so it
> >> should have no size impact when not used.
> >>
> >> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> >>
> >> include/linux/string.h |  1 +
> >>  lib/string.c           | 27 +++++++++++++++++++++++++++
> >>  2 files changed, 28 insertions(+)
> >
> >> diff --git a/include/linux/string.h b/include/linux/string.h
> >> @@ -77,6 +77,7 @@ extern __kernel_size_t strlen(const char *);
> >>  #ifndef __HAVE_ARCH_STRNLEN
> >>  extern __kernel_size_t strnlen(const char *,__kernel_size_t);
> >>  #endif
> >> +char *strcasestr(const char *, const char *);
> >
> > I've been trying to add proper function docs to newly added ones, so
> > we can clearly see the behaviour. Despite these being well-known
> > function, they sometimes differ in how they handle edge-conditions.
> >
> > Also you could group this with the strstr()/strnstr() declarations a
> > few lines above, so it sits alongside its siblings.
>=20
> Sure, I can move the declaration up. As for function docs, they exist,
> but in string.c, which is also where the docs for str[n]str is (an
> earlier patch had fixups for those). I see some kernel docs in
> string.h, and I dunno which is preferred, but most, including the
> sibling str[n]str ones, are in the .c file. So I'll leave it there.

The most consistent place for kernel-doc comments has been in the header
files, and not C files. So it would be another part of this series of
cleanups, or a follow-up, to make that all consistent and make something
for doc/api/

--=20
Tom

--GH2IfBJ6wDZiE1rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6gVAAKCRAr4qD1Cr/k
Cl54APsHXe+Tv3+N3BkePv5MY+yxMAeYhVTtNn/Qeu5oqtwsTgD9H79nTSqBboPD
CrDYGeSCvajMSU+Qlgx3316Doy4whgs=
=zJkV
-----END PGP SIGNATURE-----

--GH2IfBJ6wDZiE1rU--
