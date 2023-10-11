Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC1ACDB481
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD1F86E96;
	Wed, 11 Oct 2023 21:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e4RLvGxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D493A86D4C; Wed, 11 Oct 2023 20:41:27 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8540D86D62
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso1867157b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049444; x=1697654244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pl6Mi9vXzDSsAJ8iiQf/IirKpNyaXfcTEbq9Tuyiq5Y=;
 b=e4RLvGxvi2JVu599eAzHdoZFTmKXKLyMDpaQcajYup1wECvc7ZpZvaT7YI5a+7KVMq
 cPf2lejTIGb5TpsylWCodbpdoKcsk4IPTCs1sWKKBr6rzsbltBWVHhpfNYAqneAnS1m+
 Su1m5Svh9yeG9J77gsr6waqm+PhNKLkjIOSkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049444; x=1697654244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl6Mi9vXzDSsAJ8iiQf/IirKpNyaXfcTEbq9Tuyiq5Y=;
 b=wER2bAgi0rqz5qFgCAg1wO9D8wO7XQd74S797MOp+Ucwx2/bLUotu/fg9uAk+zuAH+
 Wfbk7nHZ50iHxZNXNiZKgV5jNyCCYlKdEmLEc28LPjQX6TT3cKFrP+tpEMU/KRmqvl55
 zTKG6wuJ+q+jAKOevtDTjDqPmqp1zT+N5iVsdcL4yVdCJ9vGhLB91UxFcsVAMh6crh25
 2yrGiZTgDaeUyz//hwY14VJbGEJA0vsUloYFuaKU9UFImvag6np2+6jAwxS79fApNWnv
 gYP5qPJ7wY8Kkh7GZEvMnEvfrH0fp5q6e4egJCMWE/zT15tq1UaSndRv5hvbKKNFYskq
 PYhQ==
X-Gm-Message-State: AOJu0YxI9J4owsDfaUd1QMZXx/tjFqdGf4gIQgLj3Y3JCLwpQvx4BIYB
 MfYfl2zSPc31rexBO7htIJFOvg==
X-Google-Smtp-Source: AGHT+IFZ2a9LQSyGtHQqheGjXrjlx9o5g26J89clRa0kU7qH8zk1VagCTd91WBEQVOFJ//QXIWhbHw==
X-Received: by 2002:a81:92c8:0:b0:5a7:bf01:a183 with SMTP id
 j191-20020a8192c8000000b005a7bf01a183mr6418077ywg.22.1697049444736; 
 Wed, 11 Oct 2023 11:37:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 b64-20020a0dd943000000b005a7bc2fb2f4sm1512671ywe.77.2023.10.11.11.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:24 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Message-ID: <20231011183722.GT3119521@bill-the-cat>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E0WghBzlBfCkb5UX"
Content-Disposition: inline
In-Reply-To: <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
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


--E0WghBzlBfCkb5UX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:

> The man page correctly said that -B was ignored without -E, while the
> `mkimage -h` output suggested otherwise. Now that -B can actually be
> used by itself, update the man page.
>=20
> While at it, also amend the `mkimage -h` line to mention the
> connection with -E.
>=20
> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
> modified, while its alignment is a property of the address in RAM one
> loads the FIT to, so not something mkimage can affect in any way. (In
> the file itself, the header is of course at offset 0, which has all
> possible alignments already.)
>=20
> Reported-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--E0WghBzlBfCkb5UX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm62IACgkQFHw5/5Y0
tywWggv+L0bogu0rEX+/mhLY57Osh00YWTfCgWUT4S1VRw3qF8FSFLr0LDoMul6q
THqM13hIOHytR2OpcO1WOjpbW/2yLTxYBACEPPjuC0SpNNWwPiM0ZTszWNjupwpV
Oqu5iGiERgNs43KU7jkf10Sb0Yt/fOxBZdSeY4ntGG8wnov1TX6oCYpTPfy1M+73
PSEHrgFd2Lg09GkTzg2guzdELFXud0A+1/jDRSlkdRuvlvzE6TjQ+ZXD8wa5Jd93
cref0A0I9QdyJxpbIkGv/n7htDpMK0UJKVTY2za5d+0m7yH7t3lCaaiGyhfV6p+X
GtesmsUkJM5gJfQFLI6KtDtRE+mKobjCdu3TbIDHf42lRZnkhi6oA4CsTRce/C9j
K8kE9iUZ/TSo8lGP67zcHTN2cCGVr/Fdezekqnyr+ihTSzlImY79UyVCPJ4mDoA1
MbHO3UTr7SEsh+Eu+sK1H877L/gfmeolM+Vo4HBcFI6lroBkvaSrMIFfJ6b54Mo7
FZU4LEIR
=adbM
-----END PGP SIGNATURE-----

--E0WghBzlBfCkb5UX--
