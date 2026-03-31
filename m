Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A103A10F92E6
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 18:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B002984020;
	Tue, 31 Mar 2026 20:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C8Z7LC2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4698C8403D; Tue, 31 Mar 2026 20:15:24 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2AC83E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 20:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d9b21d1461so137241a34.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774980920; x=1775585720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lpWKAmJnvKna0xUop/IarW19Oa6cJUgmdkTd0hriSRY=;
 b=C8Z7LC2er16UhV10jwaBdTKSf4GLBTH2P+eRp359jjGOxqckSwRllUskKn0PceePqx
 3pjXROL7MOR4EJLJdz5jq13tE7MN5Fg+lHMLUezVOvu1xMgzPTDzzuMu0Ec/QHwS9bGZ
 GH+xNMdanqlfxE14Rtfe+sW4qlIRreEOx50P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980920; x=1775585720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpWKAmJnvKna0xUop/IarW19Oa6cJUgmdkTd0hriSRY=;
 b=tZdHdnflKgVjx3NEXzvZnPJZFtop4RWd+a7O983o17u5/dOMHDRUsjNcBGtb8g3jR4
 Qh4xUFG+4IVi1fl9onK37OnayVgr/Vat2QYENBuVnKNF9PzYX1wj9u/fa7gDPDoO65YM
 rKSyP+M0mBzJwrWIWghK2TA71KjMld40Hhdl489cTdaeMjdcOLsE75gQPnrwHVL+gk+V
 XEklg8ni2KKcQkcC8J9Q+blWOK43H1E+RGQpJQO8Wp/U1Cat79coOF2U8klVrwdba7dj
 eF0RKaRAHefy8TremWJhdV4sFn31cD53NRBRMEqd8U7LNO9jWL3r2PZl0NCP92HT40El
 9vmw==
X-Gm-Message-State: AOJu0Yyc6k+rzsNvjTk6RuqVthaAZmp88EA/GPxMJVflDbcNcQBpVjyW
 FozNXoJ1H/FYmRls7KH2TJNbXSjAbCJJdKIF2HJe/qachBEfbBLesdFKhGQXxdKDXc0=
X-Gm-Gg: ATEYQzyF4oTmg6wPNpJBCJDldwYRwKtMlsDn6NlE6qJcOUg59C+jqGTvnuoB1sZHYzV
 NZOFRWBYtPPJKnbhHXvNH+jriezHqbL+OAdFDZ2xbyvUI4T3jNXNKE5TfG82ITMsMeN8LBtW48O
 pJBsmQjLZAwM07eqrp8HafsUMSDpuj5GVHWk6UiCKIAytxc0kRJ1ROgq2oC9MC6UlPvfeNUt3b8
 Z5azgdVMdbyQWrOGA3B45fwepSwRENw6OG7Ebg272zI71kv9QDVF8j2vlF4//fqWTa1w97NC/K9
 kO5nUfYfOaIpSUP68c8gj52uDpF9BonkIirMxNLqnCJakxLNbtfajraBzcsHwt0GY20tAFwA/Vo
 Tes2ovSNRNRsooBw857oDaIwydxP8wduDV9lpcZG0iOLGUW/YO4VaYUPeADTU8fEeypaIsbWxgW
 yhcgtxIvW/lysBbGg3iXgK8QLvETDyOrpLDbfL3n1u+VVhF20bagMRPrDGr6gSHOJg5GY7WthLz
 qzOo3FK59q2WeAWy/m78MbrHe4UFj7p962WO82WY3z1xiNK
X-Received: by 2002:a05:6830:440a:b0:7d7:ddb9:670c with SMTP id
 46e09a7af769-7db9a0bc397mr268239a34.9.1774980920022; 
 Tue, 31 Mar 2026 11:15:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a8501c2sm9270071a34.25.2026.03.31.11.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 11:15:19 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:15:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] s5p4418_nanopi2: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-ID: <20260331181517.GE41863@bill-the-cat>
References: <20260325190031.3428654-1-trini@konsulko.com>
 <37959750-b370-97cc-5f55-e0d6c045a8f0@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hn/my3QCKpDuCkBG"
Content-Disposition: inline
In-Reply-To: <37959750-b370-97cc-5f55-e0d6c045a8f0@posteo.net>
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


--hn/my3QCKpDuCkBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 05:40:01PM +0000, Stefan Bosch wrote:

> Hi Tom,
>=20
> thank you for the patch. You are right, board_early_init_f can be removed.
> But where is CONFIG_BOARD_EARLY_INIT_F enabled, I didn't found it. Have I
> missed something?

This might be another case (since I sent out a dozen similar patches)
where the platform wasn't actually enabling it either and so the commit
message is wrong in that regard. I can fix that when applying if that's
OK with you.

>=20
> Regards
> Stefan
>=20
> On 25.03.26 20:00, Tom Rini wrote:
> > This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
> > do-nothing board_early_init_f function. Change to not enabling the
> > option and so not needing an empty function. >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Stefan Bosch <stefan_b@posteo.net>
> > ---
> >   board/friendlyarm/nanopi2/board.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >=20
> > diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nano=
pi2/board.c
> > index 4dff32e10d6b..ca8ae529ddf4 100644
> > --- a/board/friendlyarm/nanopi2/board.c
> > +++ b/board/friendlyarm/nanopi2/board.c
> > @@ -406,11 +406,6 @@ __exit:
> >    * call from u-boot
> >    */
> > -int board_early_init_f(void)
> > -{
> > -	return 0;
> > -}
> > -
> >   int board_init(void)
> >   {
> >   	bd_hwrev_init();

--=20
Tom

--hn/my3QCKpDuCkBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacwPNQAKCRAr4qD1Cr/k
CgSIAP9ViTqVWbGJgFuvbfK4eoMsslrlC8A8iH3LRE7gQjVZ7gEAx445V9UsqUR+
7W18Vz4UVLXi75HGn7wXK7WhPiOmkAk=
=H9D2
-----END PGP SIGNATURE-----

--hn/my3QCKpDuCkBG--
