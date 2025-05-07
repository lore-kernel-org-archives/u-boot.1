Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F2BC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388AE8210D;
	Thu,  8 May 2025 00:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O9dSKKu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFC98212F; Thu,  8 May 2025 00:51:30 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE57D820EB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-400fa6eafa9so300995b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746658287; x=1747263087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=umZv0L+YxMcF5oZTPD/AkBXF2j47VLWApKD0awj6XL8=;
 b=O9dSKKu7OWGtrRA42dSbftBu/YqWB4fHBzV9/8mSRN6uUbrIVICuXUDnp4wUFqNmOY
 ljkRGC3/O+WxbRKRca2F2mCdmGoe/9nLV/usjMShOyJZJQJUOrcRnIRCT/kMekZ2FGNB
 nZkeQ7zKXD4rd2ZtyXCBlNvybolQ371Qyn3Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746658287; x=1747263087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umZv0L+YxMcF5oZTPD/AkBXF2j47VLWApKD0awj6XL8=;
 b=i8rLVhWXuRDwWxDriHKv+weJGE7FQPGAfoqohKOlE2UQYl6NZwlM3iTY20E2wL3cIy
 mpQjPOheOE7guYzZtRoSuYzUIxOoC/ATIdMAH+96zjefcEU5IHvl0PESv3OaNIApekdC
 9Y1SAf81/5IsQhIE4DOpvx9ryL21+F+qYup9Ub31ka5MqVbroxauwTqDonUCdJYDuNFB
 M4C4+O/y1UlEDjfDJoFfD0jqAoO84R5mf5jKZgOhPIVrcIPSBNgINwvtCGvK2ioTEGQ6
 vpqdVWiiQcG4C4CMYxW+fVJrPYS5AbtQGH9RUKs1sO+BXHiXeA4IlY7zqpsVBModGZ9g
 9CiA==
X-Gm-Message-State: AOJu0YyFnSDjeidRSkImvxsL4rRY+NmMVH0P2Cu+Ou1Ac6n65v7p7TDR
 4YD6VhsFelxJe8EHZ9L3TcMVGSQ58BaLf8G6LjuXZNP71WaQLkPWojTaZWDERLAsdJk76SuFqJt
 v
X-Gm-Gg: ASbGncvxb6Lg5uuP/X2+7KOcADRn3L1AnyZ7OPit99CexuUVT4EGxXGDwaAGXQwZEOd
 GRH5iFeXmbmZ3aj/8RHiKW3at1cJDS3qRpQwzpvypHE8mId4CDvzPpJtg2EAyRgZBromfWEpoq5
 BkZ4cvFZdYdj4rBLV87lnihGZk6tgtiwiEPd5ulK/c7Jf+ACGeeW4vY3ZRGQYpFJeJI1ZwkJSNc
 VE7EY5+8SsZ0Kp5taLBMND/pCrs8ge1oTiXCPBsweve5Blw27B/IuH3OHRivV6QODXWC3e/gyKu
 u4tYxRgIz1T5HcxNsKBq8620/sWmOsO6S4lGsxJ/SW9jaIUOlXZdDMcTQcBKb3n9okSYrj0VXzD
 SgA==
X-Google-Smtp-Source: AGHT+IEJEh5ra0c5d33IqcRZBWgC++oD/pZuFeR5OqjHg0PycBRBCFRjeKJNDGD+YouHbpc5q8qfZw==
X-Received: by 2002:a05:6808:2181:b0:3f6:729c:810 with SMTP id
 5614622812f47-4036f06fe9cmr3187471b6e.4.1746658287362; 
 Wed, 07 May 2025 15:51:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f38747csm834129b6e.33.2025.05.07.15.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:51:26 -0700 (PDT)
Date: Wed, 7 May 2025 16:51:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: cpu: armv7m: add required .type name, %function
 directive
Message-ID: <20250507225123.GR5430@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q9FlAbKPjXAS8Bq8"
Content-Disposition: inline
In-Reply-To: <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
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


--q9FlAbKPjXAS8Bq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 07:07:03PM +0000, Johannes Krottmayer wrote:
> Hi Tom!
>=20
> Okay, STT_FUNC is an alternative spelling for %function, didn't
> know that before. So my question is deprecated.
>=20
> Sorry, for wasting your time.
>=20
> BTW, I will add the required macros and also try to add the VFP
> support. But I think it's better in two different patches. First
> patch with the ENTRY/ENDPROC macros and later with the VFP patch.

Ah, thanks. I too didn't know about STT_FUNC until now. So I think that
means all we really need then is to use ENTRY/ENDPROC on that function?

--=20
Tom

--q9FlAbKPjXAS8Bq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgb4+cACgkQFHw5/5Y0
tyzYRwv9G2AWh7UR8kJLNPF6dUlebdyD3XSGCZr5tHy7A4GCUmJOtewhGWz581wV
sxiDh8f+MadAfd9pIBvU6VvIg0lsTnlaw23bDBbcdhXNQC2C1FJBhwNEpeIco2Dm
PNG7d2GnL+P3w5wATAAt0QJUS8jA1FPpDxbHX8XOK2ZNH8al8fETaZg2wc63XHzE
0yLhZp+33Wjknicb5AGtRSV9k/EIwXxmpE17g1YOt7QdvAveHP6pzNlIS512t3Ty
0GqqORVs5CdNzNXDX5rkMuT9BA1dbAAt8a1i6IRBKzTp6adYMJbab4DLcl5vINx1
Pyob399K72YptsDZN6DwyHB0NyK/B0uL77smP3xldYIqt+CSroDps8v5+HbPqpHO
LUAbHWlyNoWGWk4ExPwy7w2UTjLu40obi7EnnvrqqnL7MGVRWjRYADGV4MTREXZC
Qn9NjV5qRxwYhsdZEhUne86iCXuAaa1RcYCh4i/BYYDd1t//TwypZu8s/hnyXQDT
pyoLfhWB
=qYPp
-----END PGP SIGNATURE-----

--q9FlAbKPjXAS8Bq8--
