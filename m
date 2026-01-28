Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B55CD3F06D
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF0983F4C;
	Wed, 28 Jan 2026 15:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fRgWtTuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C47CE83F5B; Wed, 28 Jan 2026 15:27:23 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9DD83F2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f194e9a98so54237b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769610440; x=1770215240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2SW08wbzUWdc4KgpLfCBtumXLyJVocBwZtiPVURHg9Y=;
 b=fRgWtTuWT0rdJ2S6xGXCPfa/I+Jvbvol1y4K3NaUuFODvkR9Rg02jiiSYl4DqX4UUZ
 6KUzl3yolD4q64aSm5jETS9ifi0hJXqWaHyNcF/34c2f0tO1zYc8TKM7e91VLclZSkR0
 Z0uWBnQyTwbPiTfV00YpaU6RWtCl1gPnwrjyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610440; x=1770215240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SW08wbzUWdc4KgpLfCBtumXLyJVocBwZtiPVURHg9Y=;
 b=wyb1rDxii0fnOZ3pNLUycWA1+Gj4z+L7p4aF9Nh2/BhugwQ8iimKczwxK36jygyboa
 1Wf9/4xn/I4+F8y6dvF4jqSH3JQKi/2ixJkMWf1tCdriGHcZ+nAU+CIybJ+tfOgNkQ33
 X72AlKyoNnK/JvpX6Bq8+vVvTYjsro7y8qJl5iANdst7xDz/dwHPaCSWSZVK4nyenod5
 HjKfiG2dKUv7LNrIiVSYqbgXnjuml3pw7IDK+URxAeNIbTx7/60w1xAbYwZ8WpqKiVkn
 a634yvFjmBa6epGrVgcjfF1OYGo84njxq2f5L8v9dHdibLfx3ufP/4oJpwdwQ0eao9iH
 zSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMhLSl07eLbS/q6OUi+BCEkd0OZrzsQIC8qqrhDnMO6mtt4XqD/GZKKet9OacG+SAUhQeJhE=@lists.denx.de
X-Gm-Message-State: AOJu0YxzfKs/PZl9ARLyyoxGq4Qg37b4HcUY5AJmwVZMQY3TUCpcrB4J
 CJChMK/MAIRheaz9uWppMVCe6hhOjIW4Hh0jTym8DuxTe79pmGIzT1vFIyk53rMtV7k=
X-Gm-Gg: AZuq6aJbw6nXCf1xNpmOHeRQrDmhsBhE8WnLvrdD7Yinw3whykAW2h4544UQl290cCR
 5r5B88OA7IctwnMufPy2yqlB4PGH2XX7glQX6yinMYb9mNKdFUxXt9y2WmydcpUCH3FqbR152VR
 Oyo/SW5QJd/ZloGZXuoNNvhKVQAmyk3/12CJD7Ij9HxNrWKQa7ddj0fysgVhwFpOrrqpvMALkHa
 vh9QMmPQr3YRoRRcg/mBTXOXRVvovXnV25LScqWkvYD0qKhbd5r793848+kxtLkZfdPARKALjdo
 cAfRX2Yu0pE5Wy8i49tMCbjOEM/tXegaaF5Fx61KRq2vvcK13Jk5wkr77jII1L0hxHciSPjQuHC
 PYLWCf0O4nKjUFqbDTz91eSq8v/AGNRfMcxfk3zPhZc77YCwJA+3+b8D8QdQfBDdvu4sWa8cYla
 lmyiMk4yONXE7WOqXOwr48BqSmFMsObPrUDCrZSkWpSTYm0FpjjkxstlGl3Zj4H82a0+54ndVXO
 vBVaj0hYlT2XlxJ+SC0K2nPW5c8+7U9/BYVOGU=
X-Received: by 2002:a05:6808:d4b:b0:453:50af:c463 with SMTP id
 5614622812f47-45efc6d0dd9mr2760322b6e.41.1769610439657; 
 Wed, 28 Jan 2026 06:27:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb82f5sm1322793b6e.22.2026.01.28.06.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:27:19 -0800 (PST)
Date: Wed, 28 Jan 2026 08:27:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] gunzip: Fix len parameter in function signature
Message-ID: <20260128142716.GH3416603@bill-the-cat>
References: <20260127235156.1503207-1-marek.vasut+renesas@mailbox.org>
 <0F151B61-19A0-4F8E-925B-1EDFD7054E1B@gmx.de>
 <1846ef8d-44c4-4c3b-b810-6ad906405e18@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vvc9+45uGzNOlMtx"
Content-Disposition: inline
In-Reply-To: <1846ef8d-44c4-4c3b-b810-6ad906405e18@mailbox.org>
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


--vvc9+45uGzNOlMtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 01:01:09PM +0100, Marek Vasut wrote:
> On 1/28/26 5:32 AM, Heinrich Schuchardt wrote:
>=20
> Hello Heinrich,
>=20
> > > diff --git a/include/gzip.h b/include/gzip.h
> > > index 304002ffc42..5396e3ffec7 100644
> > > --- a/include/gzip.h
> > > +++ b/include/gzip.h
> > > @@ -77,8 +77,8 @@ void gzwrite_progress_finish(int retcode, ulong tot=
alwritten, ulong totalsize,
> > >   *		for files under 4GiB
> > >   * Return: 0 if OK, -1 on error
> > > p */
> > > -int gzwrite(unsigned char *src, int len, struct blk_desc *dev, ulong=
 szwritebuf,
> > > -	    ulong startoffs, ulong szexpected);
> > > +int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *=
dev,
> > > +	    ulong szwritebuf, ulong startoffs, ulong szexpected);
> >=20
> > Ulong and unsigned long are essentially the same but using both in one =
function signature looks weird.
> >=20
> > I would prefer size_t for the size of objects in memory and off_t for f=
ile sizes and positions in files.
> >=20
> > Please, consider adjusting startoffs and szexpected, too.
>=20
> OK
>=20
> > > /**
> > >   * gzip()- Compress data into a buffer using the gzip algorithm
> > > diff --git a/lib/gunzip.c b/lib/gunzip.c
> > > index a05dcde9a75..040450c0e79 100644
> > > --- a/lib/gunzip.c
> > > +++ b/lib/gunzip.c
> > > @@ -116,11 +116,8 @@ void gzwrite_progress_finish(int returnval,
> > > 	}
> > > }
> > >=20
> > > -int gzwrite(unsigned char *src, int len,
> > > -	    struct blk_desc *dev,
> > > -	    unsigned long szwritebuf,
> > > -	    ulong startoffs,
> > > -	    ulong szexpected)
> > > +int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *=
dev,
> > > +	    ulong szwritebuf, ulong startoffs, ulong szexpected)
> >=20
> > ditto
> >=20
> > > {
> > > 	int i, flags;
> > > 	z_stream s;
> > > @@ -133,6 +130,12 @@ int gzwrite(unsigned char *src, int len,
> > > 	u32 payload_size;
> > > 	int iteration =3D 0;
> > >=20
> > > +	if (len > 0xffffffff) {
> > > +		printf("%s: input size over 4 GiB in size not supported\n",
> > > +		       __func__);
> >=20
> > Please, use log_err() for error output.
> I believe log_*() primitives are frowned upon ? Tom ?

My initial answer is that log_*() is better than just plain printf. I
think my high level complaint is that we have too many logging macros
that do the same thing and that should be looked at, at some point.

--=20
Tom

--vvc9+45uGzNOlMtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXocwAAKCRAr4qD1Cr/k
CqkLAQDmWY/904EUKVuYOnpYdtfyL2JRVDsyFE5x59eTb5qjqAEAwieIsQ24y18P
NXZ2P1mOV6w1ahA6frfvPLBcbOW/3Qw=
=01JZ
-----END PGP SIGNATURE-----

--vvc9+45uGzNOlMtx--
