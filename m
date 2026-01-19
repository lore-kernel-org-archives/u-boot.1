Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E687D29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2588397D;
	Mon, 19 Jan 2026 17:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XTmB8Zfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906918003E; Mon, 19 Jan 2026 17:47:24 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED6C8397D
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45c92df37fdso1710387b6e.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768841241; x=1769446041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rOR7nTocswSU2ATaivt7+PShV7j9c/h9PH2w0R2Pn/E=;
 b=XTmB8ZfuoBpAd3OA3k8zakCV6yEiqw1iVEy+F+S4fsqtuoRYpnRJnlckp4meV6T+Kd
 wUvLp6NBv3IfCgo/SnZ0hlB197frLP9CZHHjYnzyE5gel6yzooXbNgXPz8QQY8tV0SSv
 cj+NfbAX2dMQv/AkQsyyfDZqcsHtQFfBWUhhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841241; x=1769446041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOR7nTocswSU2ATaivt7+PShV7j9c/h9PH2w0R2Pn/E=;
 b=IjmmK19l2FWC2JZoQEJqKvwc0/wAooSD5Sgwvtt/wQ2Y5xTDAnGHJGDy3AifFpkxRr
 ADfdy3/goTRWN+hBtMRa8jn+a73fvgDABVmCUiRZlJdYy9p96rJMaVMePSTJJFU62Nz4
 GNlF5V6sDhDOqOrYuJBAq51mVJpIbaVqV/J93vsKHkEvXi9zuX/sO6Mu25t2T7aJX41T
 etPZi5WgUq5bj2NZvzx0ZQu23WmH5z1EYMwSKhv0npWwos6qcU8oE+CNl515HxAjmS2U
 yb6MRD60ViiFBBpTjdMbk61pwAE/+HOYW2S+FKdyjDwTZbInida0umMYAatDCBaumCsR
 1vPQ==
X-Gm-Message-State: AOJu0YwRJ+ixz/uHHLMwdOXAs4QPyub+1tW+1Ups7B/DY401J9DYShfD
 jg8Xw7wWp1pezyuQQFGhQREsJMMH/G/i0LzBmPpVN+yNmGZpfi3hjn2Y7959QOuiYZTnA6b9zeo
 rPgvuX1c=
X-Gm-Gg: AY/fxX51MV/IpPI2kd7hLu7IqR0k/SxxNAjcGsbFuHPHfE4Rlw7DTJ7FHJar22yJGd4
 X5IZVqEd/7z/9SCADe+dqrTgvHZlfQZgSgC9RpYzF3Rh2nd3NSrVg5GKFKbKgbFNG5ek6L8GloF
 9pENogb0z+Jowz0H5I+rmTG4vhIMcCvGIPqxQpYzlmjhDjwUWyknc4UX2fnqga/LL6vvkj2MCNk
 TG6ApHWUTHo2KGa3NDMgETGCB3PzeA5NJqFp1p+wLUcWnkK7FnZCW7VdrtrNp5CzmyfySptCUNw
 aiq/zZV4T1KYU4dXcmp6tFiXNXKes7uXD0hQUHY+H6bKwzRFybAUUnQGijgFLllA8jpl8KAqupa
 /K+RZLbIBn4b4OpdQy5Yyl1wrLIPdGEjetrA9URM606/8TaEqafo4QYY4rBimkXqfAI4icd04Na
 wHk78t1F4pBnybT4T8ePubvXPB55Bp37u6cZ9/ZQdf0Li/CteDZTTrGw3qDMfjLr6QPtjEbPi4L
 e2WAA5TpYcSrSmE8IsN6eysLRK8fl6Es5RuFQk=
X-Received: by 2002:a05:6808:1b8f:b0:450:c0ef:8075 with SMTP id
 5614622812f47-45c9bed4a7cmr5443960b6e.8.1768841240857; 
 Mon, 19 Jan 2026 08:47:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8a8sm5707833b6e.6.2026.01.19.08.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:47:20 -0800 (PST)
Date: Mon, 19 Jan 2026 10:47:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/3] doc: develop: process: Rework the custodian
 feedback section
Message-ID: <20260119164718.GB3416603@bill-the-cat>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-3-trini@konsulko.com>
 <553303fb-216c-4f3a-8153-cf2df6b5f4c8@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QOqPC28SnXZ7snqf"
Content-Disposition: inline
In-Reply-To: <553303fb-216c-4f3a-8153-cf2df6b5f4c8@cherry.de>
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


--QOqPC28SnXZ7snqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 01:17:46PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/16/26 7:16 PM, Tom Rini wrote:
> > Now that we have two items here, rework this slightly to be using bullet
> > points, and so easier to expand on.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >   doc/develop/process.rst | 43 +++++++++++++++++++++--------------------
> >   1 file changed, 22 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 81e1aa7e34db..6f5bdd3db957 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -132,27 +132,28 @@ It is their responsibility to pick up patches fro=
m the mailing list
> >   that fall into their responsibility, and to process these.
> >   A very important responsibility of each custodian is to provide
> > -feedback to the submitter of a patch about what is going on: if the
> > -patch was accepted, or if it was rejected (which exact list of
> > -reasons), if it needs to be reworked (with respective review
> > -comments). Even a "I have no time now, will look into it later"
> > -message is better than nothing. Also, if there are remarks to a
> > -patch, these should leave no doubt if they were just comments and the
> > -patch will be accepted anyway, or if the patch should be
> > -reworked/resubmitted, or if it was rejected. However, if a submitter
> > -feels it has been too long since posting their patch and not received
> > -any feedback, it is OK to follow-up and ask.
> > -
> > -Another form of feedback is about applying the patch itself to the
> > -source tree.  The custodian is expected to put in a "best effort" if a
> > -patch does not apply cleanly, but can be made to apply still. It is up
> > -to the custodian to decide how recent of a commit the patch must be
> > -against. It is acceptable to request patches against the last official=
ly
> > -released version of U-Boot or newer. Of course a custodian can also
> > -accept patches against older code. It can be difficult to find the
> > -correct balance between putting too much work on the custodian or too
> > -much work on an individual submitting a patch when something does not
> > -apply cleanly.
> > +feedback to the submitter of a patch about what is going on:
> > +
> > +  * If the patch was accepted, or if it was rejected (which exact list
>=20
> For another patch as this isn't added/modified by this patch, but wasn't
> "with" meant here instead of "which"?

Yes, and it was wrong in the old text but also it's a small enough
change I'll just fold that in with v3.

> > +    of reasons), if it needs to be reworked (with respective review
> > +    comments). Even a "I have no time now, will look into it later"
> > +    message is better than nothing. Also, if there are remarks to a
> > +    patch, these should leave no doubt if they were just comments and
> > +    the patch will be accepted anyway, or if the patch should be
> > +    reworked/resubmitted, or if it was rejected. However, if a submitt=
er
> > +    feels it has been too long since posting their patch and not
> > +    received any feedback, it is OK to follow-up and ask.
> > +
> > +  * If the patch itself can still be applied to the tree. The custodian
>=20
> Ah, the wording I complained about in patch 1 is gone, so i guess you can
> ignore it. I don't think it makes sense to nitpick about something that
> exists for one commit.
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks.

--=20
Tom

--QOqPC28SnXZ7snqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5gFgAKCRAr4qD1Cr/k
Cko5AQDAAAQxWWNKM/uM+kgOz2X5UG19Uk6hH0st7VclbSulnAEA1DKBqNme0wCJ
Y0kBYMRVMk1PT5WDDkUlOj4Lw7V+mAA=
=a3pL
-----END PGP SIGNATURE-----

--QOqPC28SnXZ7snqf--
