Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0768AE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DDB896FE;
	Mon,  9 Dec 2024 16:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lbGYRhkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E039C89700; Mon,  9 Dec 2024 16:53:44 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81B8896F9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-466879f84ccso35162341cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733759621; x=1734364421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ54UMw+ppPf2caIAudhVlIdIHv9jffoGgKG8yM6hRI=;
 b=lbGYRhkV+jPUSc5eQOL3YucX9pXyKfdS6zPH18UnrSo//6mAlziMDm028qD030iTDY
 bQxe7yPhYaJQHCmI/4NCYqoIsMHaGVV8KAlc4hALbwDUTtsojhRdSoD2Qa9N4RcirTsT
 DdQvchd+rROav0xyD+DSQxt1WOzQJzhtp53kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733759621; x=1734364421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZ54UMw+ppPf2caIAudhVlIdIHv9jffoGgKG8yM6hRI=;
 b=P+gx3XWVQrdCrJi9RsklFosZwFwP1xl8AmzQ3hbYdJPPcDYzHQtNju87IzjhyGImWS
 2hk05cE9BqVoA0xNoVDEEtbt7e/1hQ/1mDoIDEC5WS3lssCmOTiv4YvXpOisze8nQwcz
 S/SniBHAg+RPlzGiQfP9TcoPxalXjzeTc0zhr5pWvCT/YgwZSyHPMuh4plts5TIrOw4F
 IxiTMBoy5j6E24ueL3jnOiKDfyk/q/jeUIwSc+2thoSFl9NbqqqR7VePyAoVfKX60m/I
 5NTq9i2aiTaNsrZuOgZ0deIdNYRXleND6PsKIsm41GFw1TfL7oT2FnfVndFYSAcX1gPD
 o7jQ==
X-Gm-Message-State: AOJu0YzWcOOUBXL0Xy44UJf/AOG4YZSqT1TvrUajRigKgwQpkHRd4KIX
 byiynDLs9ZvIA8Z5p7uT2jtjlj/ckKbW85vFCDcPtah/Bl0LiMUFEshqmmf7Q94=
X-Gm-Gg: ASbGnctnB9uEhty4DgGVKvM7Vnis8KLTjcYLr8KNVYe27nS2hcdl1SnLkvozoznYvOU
 PCvW97ZGanmR1eYJA6t6dhZyPYa8FOskJiThbMIjt9YQMnKAVAbkHei8JCt/Qsemn9kyTkg8IO6
 G4eXrvzSaK9pgjll+e7GJ7XaNvxXa3OCRzgujQ1HL2k/+AIheeRQrZhkCNQ4aNdXGTczk0MsQQ6
 FoBIolVa5yGxk6rGq90j1M31QPA58PARz26RKQq7xxcQ43/M+8=
X-Google-Smtp-Source: AGHT+IErDB0mJEKqFYC9fvZh42RZAtGECa/fXbohGoJQ1nAABae7Iq7YmQJxXxRSVt/Yrz5Ciby0aQ==
X-Received: by 2002:ac8:5fd3:0:b0:467:66e5:71ae with SMTP id
 d75a77b69052e-46766e5741cmr48913771cf.16.1733759621482; 
 Mon, 09 Dec 2024 07:53:41 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4675fc8fea3sm15382381cf.85.2024.12.09.07.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:53:40 -0800 (PST)
Date: Mon, 9 Dec 2024 09:53:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/9] Enable arm64 host support in Gitlab
Message-ID: <20241209155338.GL2457179@bill-the-cat>
References: <20241208190741.4192601-1-trini@konsulko.com>
 <CAFLszTi4wvZBVVXtx_Gj2mSFy827DUxKtcEOxocT558=XGmQBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XLF5KSytR63Drtoj"
Content-Disposition: inline
In-Reply-To: <CAFLszTi4wvZBVVXtx_Gj2mSFy827DUxKtcEOxocT558=XGmQBQ@mail.gmail.com>
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


--XLF5KSytR63Drtoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 08:00:33AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 8 Dec 2024 at 12:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > First, thanks to Simon Glass and also Linaro, we now have access to a
> > few fast arm64 host machines in our Gitlab instance, to use as CI
> > runners. This series finishes the work that I pushed earlier and Simon
> > had started that enables arm64 hosts to be used for most things now.
> >
> > The first notable change, especially if you use this on your own Gitlab
> > instance is that "DEFAULT_TAG" is now unused and we instead have:
> > - DEFAULT_ALL_TAG:
> > - DEFAULT_ARM64_TAG:
> > - DEFAULT_AMD64_TAG:
> > - DEFAULT_FAST_AMD64_TAG:
> >
> > This lets us say that some jobs can be run on all runners, because they
> > are small enough that anything we'd connect to CI is fast enough and it
> > also does not depend on the underlying host architecture. Next we have
> > tags for any arm64 host, or any amd64 host. Finally, we have a tag for
> > fast amd64 hosts. What these last three are for is that we have a few
> > jobs that need to run on amd64 hosts and so we have to restrict them
> > there, but we also have now reworked the world build jobs to build
> > (almost) everything in a single job and on the fast amd64 machines this
> > is still as quick as the old way was, in practice.
> >
> > To reach this point, we say that the Xtensa jobs can only run on amd64
> > hosts. Our targets only work with the binary-only toolchain and so this
> > is a reasonable limit and we exclude them from the world build jobs. We
> > also need to deal with ensuring the right toolchain is used regardless
> > what the host architecture is and that we don't use the host toolchain
> > by accident. Finally, because some of these changes needed to be worked
> > out in the linter, fix some of the general warnings that notes as well.
>=20
> I haven't tried out this series. Does this handle running multiple
> test.py runs at once? For me that ends up providing a large
> improvement in CI times (down to about 35 mins with just two fast
> runners).

That's a per-runner configuration option and so orthogonal to this
series. Given the breakdown between "all" jobs and "fast" jobs, throwing
a bunch of the small and short "all" jobs on a runner also doing a
world build should just be a few minutes slow down all around and
overall noise.

--=20
Tom

--XLF5KSytR63Drtoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXEoIACgkQFHw5/5Y0
tyxWIwwAjkJyzRfmQfW9HmYI9lr7y4PvQ8Tp2krq3LfofWnA8wbOTJm7rANOtwxV
Oub9KXVFMmM5zfyhDPOn1v96dYVITbvoF6B4vbND3XusqCJa+oQcSh66E6hQ+w/6
1DcPcr7UiKio57Y91uhVhc5NIsraerS6ewwnn1epiNf9IJ/5sT85TrMPOfNWKArA
pb3ti74+Xg7w/kgPKWLvk7S6G1la5V2YimjWtfDlzmhma6h/y0wDHQuG1NQqFYS7
/FDWmUZ729J0KYvSabQaUmT9EaPCAduPAGd9ZuFIr28iAs0tqcPgWqUqRceK2uzw
t7kCG8K/eU19AGtLKlUKP3IoimY2rimUqm+Z3qEg6F72n5yRNI5gQwxXFG3Pif1M
ckEUFvthiPLIU6Y4TGefzA/1kLaxR9+uVoMCHa8HDgtvbjv2gfx8Hc+2TnULEzA9
HWGbyqYAxl1vOQYerpApQAPS2qw8diZSEdFp5Wd2QEeNDiNTFO6BZArOod4QwRA4
DZVpbf+w
=kLKQ
-----END PGP SIGNATURE-----

--XLF5KSytR63Drtoj--
