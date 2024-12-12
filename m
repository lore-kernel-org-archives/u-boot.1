Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35462E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D6F801DA;
	Thu, 12 Dec 2024 16:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ETpik2ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38723801FE; Thu, 12 Dec 2024 16:49:53 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA1080196
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46772a0f8fbso6252231cf.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734018589; x=1734623389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9GK4dXKEjyAgs+fcrfQ/fu6LCqjCw97bgcr6+JMNw4=;
 b=ETpik2axXhmZXaas+F8bfif4vUUjZ0aRdFv3P7Jv2WHWSaGJeFb0unHOPOcImLwLfA
 G0m0cK/gl9ulHMIgh7jnhbLAFEYTC72eC5RB5E4HGoZUpyMRjK4tBQWCR112bjwci7FB
 w5WtOpo7yXzolUe6Z5c3vb8rtD5KmxikAuo7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018589; x=1734623389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9GK4dXKEjyAgs+fcrfQ/fu6LCqjCw97bgcr6+JMNw4=;
 b=CknkT+yYLI4Dh+Jv/0MjKAPzUG9Z3icc75l1EMaigNFJ6Kd880OhxjyYfoQLVz6UrK
 fcDbbjncfHCrGjr8qpE1jAQMS1+Aq+LouGGbbMoz5GiYHJWYrY+8G9vkDrNF5b/EOjwM
 zN7s2e2Rmjfiu0zVuqCzK7mLoCP5eQjN8Qzic/kC9g197uLUAh0MNXdRC/uETSl4mSCJ
 79jDg30pBeNjQi0s6TN1Qyz1FtTd4H5O+6mYHe4VrBhK05ESoFzr2HuV/88rj1pZmMQ6
 vqn20Bu01UnRx8yMDa3GE9tYHbrQqtBshnPi+1zZcKMOGkNfczuAzdMjkzWuKc6kb+Zh
 Btug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/vg95sHc3a5BJoxf1y0NN+z3DywTjxjxKiMWtvUACMlpcIIYFiY8gZElTYK2NsxH7wo9PuME=@lists.denx.de
X-Gm-Message-State: AOJu0YyiBQJMp90zSNpVUKcNnx0tcI124970gW+dhV9uMno9SF8Mxgko
 cjQLkKx9dCgtjRCR+z2PNndXbub2ukzNxyTw6+7C1zTXoz3l+xYO4p9SNWWYZGc=
X-Gm-Gg: ASbGnctsITkukf2H5oN7A9cJco/xf1784+TbvxD/yAxE4qTekT6B6eckrBYgcgAYgvQ
 cFISVDO61M/Qy1hfeE8ODMwz6B9M0mlUX4k/4WAVe+6ySrQaw1mClo9hwGqqzVjgfpWbtGzSJyU
 KV02GSDT53ky+UrZ2eHPF+dQwlPSB+vp/JPJuOMCEaXdDjhqToZrAMJvAsVD4XaEvHTBzKVjE1L
 Wek8ZKNqCUKFNjW3aVG7hF71v6m9au2wWGF+e3gEKGPYsBIQhsaXKDv
X-Google-Smtp-Source: AGHT+IHK68LZgoruzX3a17fzaSkuX+7mvUACKgriBNAApDKgdkX9dUgS+TBxKjg1ZGYNuSzx/JHG9g==
X-Received: by 2002:a05:622a:1c13:b0:467:5375:5804 with SMTP id
 d75a77b69052e-467a16859d8mr15023741cf.38.1734018589370; 
 Thu, 12 Dec 2024 07:49:49 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467a3126d0asm21221cf.40.2024.12.12.07.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:49:48 -0800 (PST)
Date: Thu, 12 Dec 2024 09:49:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241212154945.GD1505244@bill-the-cat>
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
 protocol="application/pgp-signature"; boundary="/ftRvWdGyT+tleDp"
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


--/ftRvWdGyT+tleDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 07:04:54AM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Sat, 7 Dec 2024 at 01:18, Ilias Apalodimas
[snip]
> > Another example is the fdt sutff here
> > https://lore.kernel.org/u-boot/20241201144240.1664398-5-sjg@chromium.or=
g/
> > Tom, Raymond and I spent a lot of our time explaining why we need this
> > feature like this and what's the technical reason behind the decision.
> > Your commit message basically says "I know better and you should all
> > listen to my almighty ideas and btw this breaks 3 special ancient
> > platforms, so I am reverting this".
>=20
> This is a deflection at best. WIth OF_BLOBLIST, you can just enable
> that option and get what you want. You can even make it the default in
> U-Boot. The issue is that you don't want to have the option. But
> without the ability to turn the option off, my special, ancient
> platforms, that no one cares about except me, break.
>=20
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

Having just this morning figured out the problem with those chromebooks
(because they're available in CI, so thank you for that work), I think
this is also a good example of one of the problems. My recollection of
the threads from last year does not include you mentioning that on these
three platforms the issue is that you put the fixed bloblist address in
DRAM *and* that SPL initializes DRAM here (not TPL, not TF-A) that's the
concern. My recollection of the threads is you had very different
technical reasons for wanting what you proposed and those technical
reasons had technical objections. I've posted
https://patchwork.ozlabs.org/project/uboot/list/?series=3D436459&state=3D*
now and that fixes those three platforms. And we could have done that a
year ago if you had explained the problem on those platforms. I would
have asked why not putting the bloblist in IRAM instead, at that point,
and you may have had an answer, but that would have still left coral to
sort out.

And how is this part of the problem? You cannot suggest architectural
designs without explaining the technical details of what and why you
want something. We all spent countless hours arguing about some feature
of bloblist design which zero platforms actually need.

> > The way I read this commit message is that you show zero respect for
> > the effort all of the other people put into code explaining and
> > documenting the feature, your 'justification' has no technical
> > background whatsoever and then you come back complaining that people
> > don't appreciate your efforts.
>=20
> Obviously you are entitled to your opinions, but I don't agree, sorry.
> I doubt anyone is particularly interested in my thoughts on this, so
> I'll refrain from commenting further.
>=20
> Just to confirm, nothing in your email appears to address any of my
> concerns. If it was intended to, please point out what I missed.

No, this is another example of the problems. You've been given feedback
here, which is that your communication skills are a problem, and your
response is to say you don't agree.

--=20
Tom

--/ftRvWdGyT+tleDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbBhYACgkQFHw5/5Y0
tyznUAv/UZ5z6MAm4fMIUkduUFcnaR1k75UVFO59YFweRxXpL8vXP7Jf/dZGFNq7
auqd/B+XpAS0wEMM6BjUPBiLltgsVJxm8yyUR7mqIvYA/3Btc123PnTLn9A9buVl
BIQ5aGzykvRzpPpEcJkC2v7dhM05jFhPJ/U/CBThlhko8Foan0phsM8sixC6oA84
E4e1dCYdB7BkOSAaucrMUumUdiyZFvGdmWLaaRlxmVCDtiTQRLYo2vGcUTeWa3P5
CrmUL7YtAjg289BFFBmbp4TNhRieLV/xee4E6Mq1qSZFGV0KoPPy4msAHFHRT/1r
riovZf0MItZ7p9q5qer7MmHClBbusT8HEC8Ki0JOifBNWFIvrhHRiFLv8f/zAfH5
WXLXzdR1RmGsKyGW0iWKkBUx334JhWImSz4dPAdlxCOUXfMZUP/dFHQceK4bGbDH
Ve8U7liLg/afyh6JNN40JNbuyrMM8gzmxYB/Hpyo6+RY3fVV7MtT9fwyHwbRdTup
fXzBeI6E
=ZxzG
-----END PGP SIGNATURE-----

--/ftRvWdGyT+tleDp--
