Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E81E776CB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 23:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E6B86D80;
	Tue,  3 Oct 2023 01:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UjiZe3Fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8861F87166; Tue,  3 Oct 2023 01:40:40 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51BC86D80
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 01:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d81afd5273eso350463276.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696290033; x=1696894833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PN3gOCsgsPnWUP8f1xmPEEvsKPhgUFrwxfiZE/Q/OBw=;
 b=UjiZe3FhdwZPmW8IeLxdMe1gXP8njRE76Q3PztM8nQ8HvJ1JoTPGUn4VDNe/xiWPsT
 jTPM8jraT8BYM/R6CoNy9oahvvoGs1gagSX6PZiMA2vzj9MC8m/VEla0mj8JCqrykI45
 Zoslv9C0ABuhfCAVP5PUkDfkP9aDW58gApUC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696290033; x=1696894833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN3gOCsgsPnWUP8f1xmPEEvsKPhgUFrwxfiZE/Q/OBw=;
 b=Alub2BSLa/Xp7L9ZIMh9KnLp/RQCyTxxDs8KbH0bQ0cxb/FSG3U7ursCffgmaAWSa0
 FHFFXNwiTKNDAoZDLdFshUF4fZAbzFJ7CfrwhQ3Z2LBYmaaIzcajLdYzRkAbUZbUzHT4
 +Ro8dZctGBOGc5e4luyto1HKxkw7g2yWkItO6um4KDrnTUzNcGW6ZGqWAj3YXZVFC631
 jywtdv2ccGU9IscL+HwiGMgdn2LWOiTZV9g96NuhE3uht8xHuSr8L76SVAV1Gy4Xy7Pz
 UmIaM9iTl3BoxKJybNZcuUU/METijnt2k52ekgOcYKoCTl3zrBeLKRL1mFUQNX5cxgvo
 tBrQ==
X-Gm-Message-State: AOJu0YzcPhoyhWJKAkVtey6eF9NFOcfEwOpSwpaoolIf0WKkvYPr2Z5s
 0TAih3e3xJLVXSdQeI430WjHew==
X-Google-Smtp-Source: AGHT+IFBcrGJkJ/JFMqHHHDSLW1tuPVM9Aywwav5sOFRHp/D7SjKY00hYAHqnyUpS+Qs1aPqx/aOfg==
X-Received: by 2002:a05:6902:4e9:b0:d81:69f7:1732 with SMTP id
 w9-20020a05690204e900b00d8169f71732mr10771107ybs.9.1696290033220; 
 Mon, 02 Oct 2023 16:40:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1bd6-f13c-2029-607c.res6.spectrum.com.
 [2603:6081:7b00:6400:1bd6:f13c:2029:607c])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a05690202c700b00d7ba4c5e31fsm27445ybh.39.2023.10.02.16.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 16:40:32 -0700 (PDT)
Date: Mon, 2 Oct 2023 19:40:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@google.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
Message-ID: <20231002234030.GC8465@bill-the-cat>
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
 <20231002224641.GB8465@bill-the-cat>
 <beb3e0aa-a72d-a4dc-4fed-3c2e0453e9f0@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fAjKQuWBOu/WZapJ"
Content-Disposition: inline
In-Reply-To: <beb3e0aa-a72d-a4dc-4fed-3c2e0453e9f0@prevas.dk>
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


--fAjKQuWBOu/WZapJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 01:37:14AM +0200, Rasmus Villemoes wrote:
> On 03/10/2023 00.46, Tom Rini wrote:
> > On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
> >> =20
> >>  	error =3D stdio_register(dev);
> >> -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
> >> -	/* check if this is the standard input device */
> >> -	if (!error && strcmp(env_get("stdin"), dev->name) =3D=3D 0) {
> >> -		/* reassign the console */
> >> -		if (OVERWRITE_CONSOLE ||
> >> -				console_assign(stdin, dev->name))
> >> -			return -1;
> >> +	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
> >> +	    !error) {
> >> +		const char *cstdin;
> >> +
> >> +		/* check if this is the standard input device */
> >> +		cstdin =3D env_get("stdin");
> >> +		if (cstdin && !strcmp(cstdin, dev->name)) {
> >> +			/* reassign the console */
> >> +			if (OVERWRITE_CONSOLE ||
> >> +			    console_assign(stdin, dev->name))
> >> +				return -1;
> >> +		}
> >>  	}
> >> -#else
> >> -	error =3D error;
> >> -#endif
> >> =20
> >>  	return 0;
> >>  }
> >=20
> > This is an example I think of where #if is more readable.
> >=20
>=20
> I kind of agree, but at the same time, this could just be rewritten to
> avoid that extra indentation. Turn the condition around and make it an
> early return, then the rest of the function need not be indented.

Yes, both the indentation and having to use "CONFIG_SPL_BUILD" to start
with (which is a special case!).

> I also think the conversion above is buggy (loses a ! on the SPL part),
> but also, the condition is needlessly convoluted to begin with.
> !defined(CONFIG_SPL_BUILD) implies ENV_SUPPORT, so the condition is
> equivalent to just CONFIG_IS_ENABLED(ENV_SUPPORT). So I'd add a
>=20
>   if (!CONFIG_IS_ENABLED(ENV_SUPPORT)
>     return 0;

Changes like that would make things overall better, agreed.

--=20
Tom

--fAjKQuWBOu/WZapJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUbVOcACgkQFHw5/5Y0
tyznEgv/SMV4W4bynE0FsOsTH2MAeER8rSIUJ9Whz3jJ3pu/d8ZDfuzBaIESgm6a
agV8KVDWozpvD9PNUskC6OQq1fYEQ8WX0PQwplwho53s9PeHa0EM5QE7PlcAK5m1
cWifC0w7wvFo5Rv9lnuJ2NowE7tewtJ56Bv24+mdXOMcqVYmbmy6rfeJDdEa78Li
2ncwbVbNto+fCkHLqrRbgE4Tu1jCi3x5dVisbd716h841k9lrtd7eI1n0gN+rFbz
Qf1Hfk0PmgjrqiftrnQzlWPSafWPjDQVbWwshiUlCF2ZakIQoG3c7dJR4Cq9Fqyv
EyfhJh87KoiHXXwCf62rJww8bTPfdCy41b2KynocEqFp39JwGBuKdW+rJ24Mgncm
oCg0g2uw+3chHWrRuNMOoJLOxMokaOfPDSuMj67zUztZ9MMYU6N9W2xZGI5+B26o
oquMoJE+cdEyLUp31wsCeWOdltMIdIpRbaPBHfIRoaJGTmJbyxExNP9dRu9lLJ53
wH083QW8
=AkwR
-----END PGP SIGNATURE-----

--fAjKQuWBOu/WZapJ--
