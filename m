Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A78C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 20:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C6D801CF;
	Mon, 20 Jan 2025 21:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KQ8iGiGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890FE8032B; Mon, 20 Jan 2025 21:54:06 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678C2800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 21:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so448978785a.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737406443; x=1738011243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnC8ha6NPrImfK1Gi/bEyqUHRqieekOgiGFOOqvZSY0=;
 b=KQ8iGiGlqIAoUEiuVaedldfsdj9gq0eJ1X1rdpdd5CaO3nov29lxlHxzBnEXaUOGt6
 wef5uA+EKPsEV/q6lzzbYZx2ro+qZ4wH0Ii2BkXKcIY7u4QVF5vvM8Q7FmS30LlBPDkE
 BM+7CmTOG2rnaHagJoHMQSLQk8cxn7gpJo7a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406443; x=1738011243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnC8ha6NPrImfK1Gi/bEyqUHRqieekOgiGFOOqvZSY0=;
 b=SIATW8RPtgNpnKEI6lB0sk/E8RfI3kF1Bmz8xmFAKCDA5/eIGjSkbvKe54nkN5OJ+w
 ifNWf1539BIMC5u6fnvTZ8rUYqhfWxWR8MkooUu25xBJifY2XvDulzvQMT3+edCKjIqF
 wYLhDiIk4GYA4i6UkaHa1EC9/q0dVN+KvkBCljvYV/bmAxA1a5uD2z4InkZf6kweD84N
 uWWrH8vvt3f0H848F1k/BNxoPCy4y/vjP5Rn8KwEh+GlP5fo+ActmP3DPJxPW6YQRWBn
 yYhKywqi9xu01d+5aUepo1tc2zuuJvGhRQa6/xikEdAVuhf0hl9eWrGW8O7Az0tmLzVD
 zjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW1QeyAIxjNn654VDANOzjgRomb504nQMXHX5BD0sj3MUE9aEHrK0YsrBEm2+pvZBEVjvbmIU=@lists.denx.de
X-Gm-Message-State: AOJu0YydT7U12Bxx11vFXhnIn5v0h98CSk+n0yVts+CRUCfyL1Exq7FM
 hLkgE2rjLVigYfi6ZcxpH4r7y+Y+ZtlpZDshiuTT2o+fauFXaKAiUgPoNLd0ysA=
X-Gm-Gg: ASbGnct9yPvqqdMdHg4UFd5C1bcCUnE2KZumbETh9D+1iBPM+jh04haHqdULrUIjXbU
 EMHSg+bBzQgoinEo5cyOH5LVjNt1rmfhaozGdQblpTNEi8lvvD6qF4c2nHATIPEgIB2mSJXsMDD
 UOCefVCj/+MOabijItnxs883qb30hJzJsHKZV3yqKNjKI238N6sl0UHp8pHZBK61fDr6/7dmABu
 vR1pf9dahDh7WOhJ4MGXQH2FFV/lOEA/66JE+2BWh4fl4odUaFNrFEoIlR41iTes+w=
X-Google-Smtp-Source: AGHT+IEYBsY7T+ZJn3Asm+UcnqOdECzWrzEgQtLOYw0rhMIunHINJOPpMXTH3MPO4TDZH3MjtZfC0w==
X-Received: by 2002:a05:6214:f26:b0:6d8:8390:15db with SMTP id
 6a1803df08f44-6e1b21700ebmr175235896d6.6.1737406443309; 
 Mon, 20 Jan 2025 12:54:03 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd37f6sm44914696d6.91.2025.01.20.12.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:54:02 -0800 (PST)
Date: Mon, 20 Jan 2025 14:54:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] net: use strnstr() for lwip_strnstr()
Message-ID: <20250120205400.GF3476@bill-the-cat>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <173740634466.2858231.5892096095947475294.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MlXoZhj7N31DSbNF"
Content-Disposition: inline
In-Reply-To: <173740634466.2858231.5892096095947475294.b4-ty@konsulko.com>
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


--MlXoZhj7N31DSbNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 02:52:24PM -0600, Tom Rini wrote:
> On Sat, 04 Jan 2025 00:21:15 +0100, Heinrich Schuchardt wrote:
>=20
> > Using strstr() instead of strnstr() creates a security concern.
> >=20
> > * Implement missing library function strnstr() and add unit tests.
> > * Use it for lwIP.
> >=20
> > Heinrich Schuchardt (3):
> >   lib: implement strnstr()
> >   test: unit tests for strstr() and strnstr()
> >   net: use strnstr() for lwip_strnstr()
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!

This was premature, sorry, I need to re-test this in Azure before
pushing.

--=20
Tom

--MlXoZhj7N31DSbNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeOt+gACgkQFHw5/5Y0
tywr6gwAhgJb6ktDCvNSultBglOJ9ndIJ004Ru71YoHyh3SYeEy00YbLOfl+MaMF
sa3LKJn0oPDUEe86Vtcyv2opk/YX1zHCMNS1W9NTfMs18v3l/HIBFLshMS77m2pm
A11f6AprYf23dE22YniQtoCl5d+HLSa3KYUdib0tK9DbrQAKLeQ5DoPkxrCVojKu
COAD2rwButcfyrs+zys4Hx6JwCMNT8G9J+JBH7p14KPI0fG0KTrWoKNzRoWFo9Vh
gltLUUM3LsE5VonTYWmfrtWXWsQCZmoDGC0qAIuT+R4wceWRZYg677Xszdw0n5/b
EfvT77H1A7oRt+z7NB+JE2P498mIbntUgt422SqCQhfLwx0ZDVxJr80vzH4ho/vP
g3vbpsA9jWtpQz26SEEvn7rSP1HwTisL+MngKhIdHIBJKAQ6OYBdEXT+qcyAuz/x
ioDqRVxqdf6fJUoGKJy3cEPavkazN4sia+zZvLTbjNEpfLAJ2L2gOPE8axkqWKku
SLsf/Mtq
=1D4V
-----END PGP SIGNATURE-----

--MlXoZhj7N31DSbNF--
