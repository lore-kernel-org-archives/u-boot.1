Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E10C3ABA2
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 18:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E4388E04;
	Sun, 15 Sep 2024 20:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uXlfW4U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AB888E32; Sun, 15 Sep 2024 20:23:11 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E535888DFB
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 20:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c355155f8eso20946196d6.0
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726424588; x=1727029388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DzAS5p0f4c49/SMa8rUXyR0YouJBI7RPvP0MltMwQ9U=;
 b=uXlfW4U1muhSko6M53po56o0Q7UZvtJVUBZomA69KDOR6uaX5dT40nENIfFcHhv0+f
 sVNTnK5e7ffUafzjZU8Udma18cbUoa0/oPQ2DEeb0h8Z0mJ/nHxOA2NueLIMlhOm/nIi
 0aVcIUAYTye8fJuUZPfcZT/1AN8E4L0GRG7NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726424588; x=1727029388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzAS5p0f4c49/SMa8rUXyR0YouJBI7RPvP0MltMwQ9U=;
 b=UVo/gEcvXq1Nv3XdadjEzttruivzssi0J4yMoEVPQHxCO7yKKo7vU8YHibST6QSygB
 oIeOsbseLWC70l5Nxv7f2vkSCDE21ewN9Ggcfj+rC+R8WDPzX6OiIDCQmj2Uj4oq10dP
 bdQohMVQwRZTSURQTzMfzK0vfobayt8MN168TGnJ3q2sxtJ8S9h1oOmrqH/cXUL/Nesg
 /i6l1WPIPLcEfsiZLP+qysj6QSBTI/v4mPcqzEDthp4LfcVvFBEEl/OvxN8BXdOLrtRk
 SLcf5WoXi0739ZE2R0j2kwt8vjD+C5xzFMIRNFHSVK3iRFzlOFPgif3fB6c4KihSgqo4
 RKRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdpRTgCOZeqYT8jQn5B8VHilUMvchUPqj8O60bSdQxENL3XQamY7nGVwSt0YdGwYHtpDslmYM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6jjEKYWJ7CwmaS8y7LbH/xXXzDm8K7gFIStAY+LtzpfeGT0/S
 UC8HJkK4alHr+vt435S47pQU393DuYE2zhhDQEHJgkeGZ9obrMvna5eROZt/sro=
X-Google-Smtp-Source: AGHT+IGu5YIZRaugjM33x6VSbeVC+zid4IIZS8IKqQQ+k8xuKqMUCdOubejTeUJ9Bs9eNzEB2dGHTg==
X-Received: by 2002:a05:6214:3285:b0:6c3:6215:9520 with SMTP id
 6a1803df08f44-6c57df96651mr175793206d6.14.1726424587535; 
 Sun, 15 Sep 2024 11:23:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c633305sm17440306d6.34.2024.09.15.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 11:23:06 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:23:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
Message-ID: <20240915182304.GB4252@bill-the-cat>
References: <20240826163917.2786791-1-trini@konsulko.com>
 <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
 <20240915181929.GA4252@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rXhdFH8YyL+amFSq"
Content-Disposition: inline
In-Reply-To: <20240915181929.GA4252@bill-the-cat>
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


--rXhdFH8YyL+amFSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 12:19:29PM -0600, Tom Rini wrote:
> On Sun, Sep 15, 2024 at 07:00:08PM +0200, Heinrich Schuchardt wrote:
> > On 8/26/24 18:39, Tom Rini wrote:
> > > The previous wording on the paragraph about what branch to use when
> > > submitting patches did not reflect how / when the next branch is
> > > currently used. Reword this to note that master should be used for bug
> > > and regression fixes, always, and that next should be used once it
> > > opens, with -rc2.
> > >=20
> > > Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> >=20
> > Hello Tom,
> >=20
> > I missed that patch in my recent documentation pull-request.
> >=20
> > Maybe you just want to add it to master with whatever comes next.
> >=20
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20
> Will do, thanks.

You got it already:
commit 85deb7f69ca4467cf5cf75545b253f9414908222
Author:     Tom Rini <trini@konsulko.com>
AuthorDate: Mon Aug 26 10:39:17 2024 -0600
Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
CommitDate: Thu Sep 12 18:13:52 2024 +0200

    doc/develop/sending_patches.rst: Clarify when to use which branch

--=20
Tom

--rXhdFH8YyL+amFSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbnJggACgkQFHw5/5Y0
tyxZgAv8COkYam2jHzk2a1GlSmsGD7KqdOlcV/kQ5slSHapapmem9NotRMl48qkF
si+F4fr8BUejeJ+xJ9ledhYh5ifKh24XOSWE+VUW44KyFz/VrQLNw6eokDWAaPLp
266ImZkRJ3hQZ8ASjwHy91bOOW7HjnU4iKweDLKki/tGRiPGLg+T3auLkMgtfceP
azVo/j503WhEWeuJ4PuDgRdmZxbqns04XgbvLpkFancDn32O8k+k1oZckCzRL/n6
HdlmABIJwQHxMosu97Qo9l6nw5HQHSl6JkkxXqi8xH8+gwA9fea5mVGiUmaBxp0T
hwu3VyeHYYaqUiSIcCgPUEnQnMGxuI1Uh2pIq0VKfYumtPllC1xjtsuNF7LyowQ0
2/cdtOTdmcO9Mpk+hhG2YNasgaK5VRSby8AScvdOkpfoXT3pWgEUw9I1/DDF1zJT
hNj6Y21sdLlRFAdhpBBt/tJp3GzKrpNGT3Ik3UXAflShxSUbxn6S/XiRqPBd1WwD
AtUeAIaA
=pCNo
-----END PGP SIGNATURE-----

--rXhdFH8YyL+amFSq--
