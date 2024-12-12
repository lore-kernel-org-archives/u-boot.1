Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74194E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5459780192;
	Thu, 12 Dec 2024 16:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VxeTUFn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7276801BE; Thu, 12 Dec 2024 16:39:00 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6638018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46788c32a69so7967611cf.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734017937; x=1734622737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gtzFIzjIHQf0sR4cpSD+pN28eDpiHzSCc9QQNMWE6P0=;
 b=VxeTUFn7BgVxrrcweLQWyXUuHnJmFE2mE7+x6sKOLI/uQBnnBIA0dNb2Qi+TLBjfDd
 ugZ7LZzDlvIn7cSCSZ0OmEHPpHlmACZgIjdohcv8CRxDVFj9aEudrsc97zlQwDhboXVA
 OwKk7jBXGHUxW7aB63GS79Se0Zop0lOO51pH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017937; x=1734622737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtzFIzjIHQf0sR4cpSD+pN28eDpiHzSCc9QQNMWE6P0=;
 b=JskmUiurb3Lok/r8MNKumh8ejZ0sPTrVZpxaHrRFZID9Je23d8t7XtzTA117ArYriP
 yUW6ipg4eF9pthPwrrUyfN3c4qa5hfETuycVW41u1NDK4afdTqmXYBkjIiHG0x04Bl7Q
 VLWEhyDGCzcL/PMANY3gbl8ScvA6pMDUTQszbZHXjkV1F0KdqIchapE6V9PC6RohA/h6
 H31yitGTPF0h15iECJOTe+ofHGZolmFlR91fjgV6qJ5Clj+8ixsYAdakkptMWT/7mcem
 GFRDmezXREg08N7vzz+m8nlDt8VszU9kCApXwlzchmubctiaa1D90cwiaEgId9ra/hZM
 PFrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgR03kpkNuZSCgiqRzUQnCf4qWkOwe30Q5NRMfdk6BaBUSNQWMfZ8PaG/n6taYA0xP7GXYkRY=@lists.denx.de
X-Gm-Message-State: AOJu0YxIKQODvY/WkkBWj95OH5LQe5J3lMumB9WIx8vK4L5CGxH1jX+V
 4LimbeBkoI8yyvxvH8fVY5bHJirpL6TmYCqxTI/TZQZzAbxUtcegGznP5GtqEhk=
X-Gm-Gg: ASbGncupcwobSgq4E2BiCIG58zQGlDaQV+DcDHibIIeddocT/XHvQL4eI3VE0zHLY4K
 hTrOCXgAENH9soLP7L+Je0tpDXig0UZDSEkjfUDaDb6vJYto9dLPMVUD1krD3y2fbztY75hoSWa
 u+Q0z6FMBqIJqZDB7eR4Lt71MvvDexfFxrR0VBItAR2ts0WPWIwSRj4uOUmeGLgRTlQhV+FgNFo
 l46ZQG7b2Vd35rBTkszMYlFp8D816z3QN057jbY4lg2F2pWfYrhtV4Z
X-Google-Smtp-Source: AGHT+IFvhujabJiFqkcagtjISTJTP5AaK9qiIJr9Q/uK4WtCs6qym7oB54Ia7+BMvG+CwvESG4jxgA==
X-Received: by 2002:a05:622a:216:b0:467:864b:dd79 with SMTP id
 d75a77b69052e-467a16e1cbcmr13793441cf.49.1734017937021; 
 Thu, 12 Dec 2024 07:38:57 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f5334e50sm56007785a.103.2024.12.12.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:38:56 -0800 (PST)
Date: Thu, 12 Dec 2024 09:38:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241212153853.GC1505244@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <CAC_iWjL1f3T2YSNS4OV76EyvaU757XSt4xrG2kZFjMOwL-Y0Pg@mail.gmail.com>
 <CAFLszTgnzrBfS=TeCsKQRHKfufAs9x+M=VbOmF22T-guXx3R_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iV7YyhQJIZm1Q3FU"
Content-Disposition: inline
In-Reply-To: <CAFLszTgnzrBfS=TeCsKQRHKfufAs9x+M=VbOmF22T-guXx3R_A@mail.gmail.com>
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


--iV7YyhQJIZm1Q3FU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Picking just a few points..

On Thu, Dec 12, 2024 at 07:04:54AM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Sat, 7 Dec 2024 at 01:18, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
[snip]
> > I haven't had time to look into that series, but I will. The problem
> > with reverts like that is
> > - I get the feeling you need some special code for some special
> > ancient chromebooks that no one cares or uses apart from you. That's
> > problematic overall. We can't just make a project look weird because
> > some hardware is special. It's the hardware that has to adapt, not the
> > other way around
> > - Reverts need to have a *very solid* explanation.
> >
> > For example, this is your x86 revert patches
> > https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> > and this is what actually got merged
> > https://lore.kernel.org/u-boot/20241129170814.768438-1-ilias.apalodimas=
@linaro.org/
> > Which one would you rather read a year from now debugging a similar iss=
ue?
>=20
> Reverts are done to fix regressions. We don't need to justify a revert
> that breaks something. It is just a revert. You can see how this
> should be done at [1]. Tom applied it within a day, without any fuss,
> as he should. No, this is not a core issue either.

You most certainly do need to justify a revert. More often than not,
reverting a change to fix one platform breaks another platform. See for
example the whole discussion around SPI-NOR changes that may or may not
remain in v2025.01 at this point because they enable some platforms and
broke others, and only just about now *may* have fixed the others. The
revert you note in [1] is another good example of how and who needs to
justify a revert. You wrote 2e9313179a84 ("global_data: Drop
spl_handoff") and so it's a lot easier for me to accept a revert from
you. I assume that you tested all of the cases and applied it. I'm
likely to apply
https://patchwork.ozlabs.org/project/uboot/patch/20241209161434.6563-2-clam=
or95@gmail.com/
as soon as Svyatoslav says it's ready or asks because that's also their
code. And if you want to get picky about it, I do wish your revert in
[1] was more detailed about what was broken afterall, assuming a rework
of the intended change is coming, so it's clear what was wrong, not just
that it was wrong. A revert (and git bisect) are great for finding a
problem, but only sometimes the *fix* for a problem.

[snip]
> > Now I don't know who Kevin and BoB
> > are and I wish them luck, but that's hardly a readable commit message
> > or will mean anything in a year from now.
>=20
> chromebook_kevin and chromebook_bob are a rk3399-based Chromebooks
>=20
> Again, the commit message is not a core issue. If you found yourself
> in a reflective mood, you might want to consider how I feel about 5-6
> platforms which I care about a lot, being permanently broken in Tom's
> tree.

Commit message are a core issue, because they need to be clear (and not
strictly concise) about what a change is for and what a platform
requires. We're a community and the written word, including commit
messages is how we tell everyone else things. Including ourselves a year
down the line so we can see why we did what we did.

--=20
Tom

--iV7YyhQJIZm1Q3FU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbA4oACgkQFHw5/5Y0
tyxOFgv/X3gxFwRvaXqlT4FiEPDq1vNMpJby8pveh43Fbl9aLq/uGV38uVbKrZ5g
neintbbIu8n0DXkkGUb65ScGqxlrUaZcu6/CrP/cC5MLR4Uc53AksglUxKLtkdYo
mz3+JWGhJCneBlNylgIY5HkFGZPTZ1/lnyibGnH4jWClFFylQzglIuypnqshoD0V
LZ773mhtyQ/gyu2MxV17ok+wdZz93l8c0o7LWB2AWaBRMAnOMLfaQl8Y8YOUDl0q
CS4diwkxBqMf/GysTSkjcv9nHuBk8zIPrbQJ4IplbZNQJE4zaTeAuIzjwvIHY5Gi
oaXFMijM7X58Yjqu7ecJEItVhs9jkfxUpr9ra64/spt4N5judwTBZYsuLiS1a+ou
nDC+3/r8wvfnk8VfZzWs5RZntguQk8vvUYi3Jj8/fAc2uYRXMWr+Qa/xmNPrBMZi
lgaUHiLeb6817Us4U/1XNs50oNXRgbR3c0XAl/cdXkJAQ267zvfkPT+coAmFVl+d
46Fj2rKe
=XvNr
-----END PGP SIGNATURE-----

--iV7YyhQJIZm1Q3FU--
