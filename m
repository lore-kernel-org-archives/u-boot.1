Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEE5C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BDE83189;
	Thu, 22 May 2025 18:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xgi6kgbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAAF383164; Thu, 22 May 2025 18:57:03 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D8083055
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bc3987a05so50411a34.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747933020; x=1748537820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dhw8dti74vy39y7NFec6phy7VZrvNeCQtoodg7PKGhg=;
 b=Xgi6kgbqdaIh6NWAemnkG2imEI/9wWkggfDvmTLxm7UdfduVenlHVXnTBt7GbOVK5c
 F1AAThJzOMLkgIvXw89e/A2tOnIdNrlyeFHXq6ucYIL7Thu/BbyVFdKMR8RG9Kv0nYrk
 tijdqVAh31t4WkG6ey6umdK8URiqVdoul97Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747933020; x=1748537820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhw8dti74vy39y7NFec6phy7VZrvNeCQtoodg7PKGhg=;
 b=t2ejD6T6GVEhSNKeEuJZHq6oxDHleNIw8Ue3NMxnMhwnyFCeTxbN2hpSRW+QR4domJ
 Glw+WwTzhM3OCOXcd4ujk3zxVFx/Z38HMEzvssIXOq68Md2H9n3q1vi0dIHWCkItUAiP
 GyKmzKFCaUDQgjZOEKX1y+Ybfx0bxaWjNPflglHAjdU5vlcfKfTF0GXnYPY7JrXcXNzW
 /iMOk41H5WnU7wiS2EhSLYxkpjUUvMze3YHq8pxzbjBx0kC2wOZ11dXPRw+eOLxpfGY2
 rIDsJWf7Y60hyS7/oSLF6qlpc1FrGySesPrQn7Zj7lI4h8cfjhMm+caQSGNqdlhTxQqn
 l8ww==
X-Gm-Message-State: AOJu0YwQsmo1FMRLItFyQH8arUIHYEJMKYZbWQss8/g84rA5qqNu3cTm
 skUW0vzcjIikEdri9X4Kk0ixwReAlwibw6jxy3VymIDv5ULOQAC98UcmUR1ItfCSz0I5nBOT2Nl
 TPvF0H6w=
X-Gm-Gg: ASbGnct/Pg9U7vmW2q9VqluFOLPQZGO+D5Bk8wrLRuQTZwbBkceIXq9lR65v2KLfFtH
 m8jLOakgIKclZsNtIfRwCb8ifba0Dnoym29jptRMOA+KIbR5GPfV9VcuwdQvNZ3nbqxJ2eBlIar
 /q3yi++RBbBiwSqQ8s4YSHCuQGmipOq6o2BZib4xCCTIjcTRFLTsT9VE+O+JO9q9VWuX2fIcln7
 ox75o/GVqpKv9jxABS+sySVNZsoJ2oppKkD96SXEih1qhjLfnBb6oUjNK3IY+2O/v5Oj1g92UoA
 LU7wRFjWNzWgwTCd4fDAh7n/0sMSvn6CFEZ2wLVSfD/3b4P5MspAoGpRoxOgK5421s/AdPdp8BL
 uiSTciKRd3jgV
X-Google-Smtp-Source: AGHT+IHTyW6C9t6oRsvthd9FwZQAOyjDGyAex9lw2LgIkW9ls/bwWP72kSC0tCHFztzxJ4Arkc3DMw==
X-Received: by 2002:a05:6830:391c:b0:72b:9422:aec with SMTP id
 46e09a7af769-7354c9bfd16mr249902a34.8.1747933019845; 
 Thu, 22 May 2025 09:56:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3dce8sm2546103a34.53.2025.05.22.09.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 09:56:58 -0700 (PDT)
Date: Thu, 22 May 2025 10:56:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-ID: <20250522165656.GB2179216@bill-the-cat>
References: <20250507121246.518691-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UYB+QbN4nqX0/654"
Content-Disposition: inline
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
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


--UYB+QbN4nqX0/654
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:

> While looking through list.h, I saw that the regular list_* helpers
> (and one of the hlist_* ones) still contain the prefetch() that was
> removed in linux 14 years ago. It doesn't do anything, but makes the
> macros harder to read, so get rid of it, and the fallback, no-op
> definition that they relied on. That requires removing a few uses
> outside list.h as well.
>=20
> checkpatch warns about some whitespace issues in list.h, but as I've
> copied whole kerneldoc+#define blocks directly from the linux kernel,
> I think it's better to just accept that so that we don't introduce
> needless diffs. The "macro argument reuse" arguments should also be
> ignored, as e.g. the "member" arguments are obviously always just bare
> identifiers, and the "pos" arguments must be assigned to multiple
> times.
>=20
> Rasmus Villemoes (4):
>   linux/list.h: drop use of prefetch()
>   treewide: drop no-op prefetch() calls
>   mips: drop unused prefetch code and logic
>   linux/list.h: drop fallback definition of prefetch()
>=20
>  arch/mips/include/asm/processor.h |  16 -----
>  drivers/net/mvpp2.c               |   1 -
>  drivers/net/octeontx/nicvf_main.c |   2 -
>  drivers/usb/gadget/at91_udc.c     |   1 -
>  drivers/usb/musb-new/musb_core.c  |   2 -
>  include/linux/list.h              | 104 +++++++++++++++++-------------
>  6 files changed, 59 insertions(+), 67 deletions(-)

Unfortunately this leads to build problems on lots of platforms:
https://source.denx.de/u-boot/u-boot/-/jobs/1141951

--=20
Tom

--UYB+QbN4nqX0/654
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvV1gACgkQFHw5/5Y0
tyz4fgwApEFNrkTY4jzBNhAlet1NlVnhX9f8SjynImXhDScy25Ui7WCYK9Qm6Om1
hHe9vBSHnNYzAQrh20HlBA+lj9ZODAkXuv2B4RpQgAkXWwgsrorhkzJ7XEC3colW
BR3LENQODaFER6pMbcxTAdgc8uFBAu8NLjrtjp9H/kcXdu+0sEeNRjEC9aX4j7g2
GHF+AqRhJ4MmphM/R8obnXvu0cTDXRDLAGPpMpf6V3QF6Ifw+Y0mm3Rx8fbTKR6a
naFPY1Kl1TValakP/0LBr+1ySiHgsYk4PSBXYOicMUwOuE3+Hl5TATRg98qQZmPe
0jsjU2fH+RYFnsnm3O80nVqB33ZoTsBC3r1ciSHifXwxvC1CLyJdLD3PafP2Xbnu
oKCkTXK/P6XmykDcsQMoSbVTCNLEFXurVQ5HaXK4mYvv0i90kTvam2qEVL5jxZZs
Q31ouCJEROKaWrPfXPJ8wmYZwkGQhLcoiIqsCpjHv3nT670jGw49G5vP2PI4Ah2G
9zxlFi+q
=p9jh
-----END PGP SIGNATURE-----

--UYB+QbN4nqX0/654--
