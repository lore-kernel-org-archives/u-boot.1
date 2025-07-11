Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEEAC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7DC82CFA;
	Fri, 11 Jul 2025 22:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VAcFsDC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AF1800D7; Fri, 11 Jul 2025 22:07:44 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3968277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40af40aee93so1558827b6e.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264460; x=1752869260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nDYlZQpyrWXTpFx0zH7JWwbxhFmFtrnBnbxT5XOZXeE=;
 b=VAcFsDC4hYacELF1M4RYe+TKiH7XK69jPD+DRjdFuvSAwxwEFcKYILCuROckjDXh0K
 hWhXVpMoaGLSVNljKRtXZku4in2IDTMaCgfKX2k4WSIRrL+71Qw3ilvprO+Cd79elCTt
 ru+e51WSIOcermagc7qTpiM4HoMu4XoJIag3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264460; x=1752869260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDYlZQpyrWXTpFx0zH7JWwbxhFmFtrnBnbxT5XOZXeE=;
 b=jIEHjQxfLaLS6sqajdZVuk2i0jC9znry1LR1ZJDiCwEfXhNvFo8twaaX14+sv8Dec6
 HOziIyq3Llm3BzW2tTU7SrtlB8w6AUotmjjsbmqHAeVD8ltlL9ZQQGaYdmGs4oWcOJsj
 nA2lkzP9pGDVILhY+WOMwyIH4OGKFzfI9djWK2IqH4O6pO959Wo5zB8d9z3YZClbMaTC
 lte0uwPPUpqyE7crTWvXkltmpXOfS2gNfdeDMaGrte9wnTFPZx0Cbl3qvsJFYOAFCWOs
 +jHckiA8IEuclAUUt0MzkTWBRaHI7Od1yDlmZwqE1O7FVYwwuVKway+smdi6ISk5Nmi9
 oozg==
X-Gm-Message-State: AOJu0YzqiOPZkZY5NdoQbNrgEGvGjBj1xIL9VMNZIDuRWfePT1um8Vjn
 K/cTqQZC41auofTWb+bUqatLfkqzbbnvoH51RxGYHv6ybB2RdA5P7+D4h8cdpsc2UVprdShMOkI
 7Dh40RVs=
X-Gm-Gg: ASbGncuDM5/JuSFhJYP8/qUnltL+Mwli3/3vGCAijnN15mn50sXmuB8DZJOcGX6iMBG
 hZumLcHyKWLiThXvB/E5Z3Wl0xgntL9G7QvQEnW45iGempYHm7Qit9nvW2LKoCNeZymxFvgfbfm
 8icKsol9S4SFfku5XUfbWYBQbKoS11/9/WQYL8HQz/p1CvO9tQVdYTPy+K5bZRHYfC3VWrznwZ4
 yh+QwjujrF8L4wVri2NV7lOa0BqqZGTRc1ltkX77W349ue4XDJmQbPbv3UbrFgHEkTzJjHTbnhT
 k/IdZXqjSg2lJphFi5xteHT3ARvx0e6DIWxNO+nhyeJVqk9DoxCZSpRmP+KPte0jbJMCgnBlsVi
 BuW74Dk0mYGrgIFUe5OXt3FrxyERYpimVGwlokG8viLJX7W9GYUAODX9U
X-Google-Smtp-Source: AGHT+IF7W9jiWNdh6IljZszv8ZigNgfzZv1Rj/5rCKnCKPJKx/yKhzK1Fxo+taa1V81Ipc3krak9qw==
X-Received: by 2002:a05:6808:3448:b0:40a:5287:feb7 with SMTP id
 5614622812f47-41565f9c67fmr2463967b6e.15.1752264460293; 
 Fri, 11 Jul 2025 13:07:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c1ac53asm659346b6e.39.2025.07.11.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:07:39 -0700 (PDT)
Date: Fri, 11 Jul 2025 14:07:37 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07 released
Message-ID: <20250711200737.GL6424@bill-the-cat>
References: <20250707195913.GR6424@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EnS2E4d8y05HbsiR"
Content-Disposition: inline
In-Reply-To: <20250707195913.GR6424@bill-the-cat>
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


--EnS2E4d8y05HbsiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 01:59:13PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and so here is v2025.07. I will be merging the next
> branch back to master shortly and pushing that out as well.
>=20
> As this is a full release, and not just a release candidate I'm hoping
> for a few more people to read this and then read what I'm linking to as
> well. For the overall health of the project, and the community, I'm
> hoping to find a few people within the community that can help with
> overall organization and management. I would like to long term be able
> to move us to being under the Software Freedom Conservancy umbrella and
> that in turn means having a organizational structure that's not just a
> single person. I've put more details in the email here:
> https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/
>=20
> Next up, I want to remind everyone that we'll have our regularly
> scheduled community meeting tomorrow.  The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> July 8th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

Sorry for the late summary of the call.

- I gave the overall status from the last release, and noted that LWN
  will again be listing our full releases (and that I'm doing a real
  changelog on releases now).
- We talked a bit about the CI framework, and TI hopes to figure out the
  hurdles required to get some of their boards available. This is likely
  more corporate IT issues than technical issues.
- Michal Simek brought up that OF_PLATDATA is broken in full U-Boot and
  described the use case they have for needing it (all of the *_mini_*
  defconfigs) and I confirmed it should work so yes it needs to be
  fixed.
- I've finished looking for extraneous include directives and moved on
  to looking again at 'allyesconfig'. I've made some progress there and
  posted patches. It's generally a matter of adding dependencies or
  fixing lbaint_t / size_t warnings.
- I reiterated my request for more help from the community for overall
  project management.
- Next meeting will be in two weeks from the past one, during the merge
  window, with the following meeting after that being after -rc1 is out.

--=20
Tom

--EnS2E4d8y05HbsiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxbwUACgkQFHw5/5Y0
tywj0wv/d0yOtfPLeoPN9D/B/1p92Bbwz1+EebqjbwFeV/5gKuvvc50lmv8vCiUu
uYjBY4q611DxNHHlt4tBq865b/CwNFaX/mGUr1uJBpQInsNRx9Wnr8U4GzuM4D0w
9qT8cebMF3sBDWuWHNpIuyCg+rkXW2ZLI+Dp7D9VtImUhKMCGEclfebVbgp7BnXz
HIT7IE0J92s48WIR4ytGDf+/7sG+nRKS/0nHJr4uDL+wrA9a/NVrsZSHLhgNBSeW
XBoGk/pbvzCv1hymz8jkVtT3ufqoi4vCIsDGok9iuBDGO7BjLzjFGrGNvEfUOTwl
gtiIRh0pUu0fztlQev0zscwEICeA2InGME8YRazxGTltZohiTnGPaEOsuk6fCcF9
XZTF9PVLsxBKsd3epsBC9smwsQ1N4r8jAbg/DG+b6LysSh40G4IPxCGx+kBDtzfV
AyZrTbwtHdrgp35HivH+e6ZvkBkOb/sPlUoFvZsU1T0fG4gwSRNJyeFt1sy9rk/w
toFtqRoh
=oRH0
-----END PGP SIGNATURE-----

--EnS2E4d8y05HbsiR--
