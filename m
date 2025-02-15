Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE6C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E010080C6F;
	Sat, 15 Feb 2025 15:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGSx4KP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F103380C77; Sat, 15 Feb 2025 15:38:06 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B1680756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22101839807so21578665ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739630283; x=1740235083; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ewl7ybm0yxAWipBRmNjkAr4+rT8G8Nf3bWNrT4O+52U=;
 b=rGSx4KP1hqfPVRODxuSzR5anDA2/Kv6muqTpTdlRR8rwoqk6ntEHj2ryQbJ7MUAnX3
 O24IU1BPHdklABkKU55tUGz5YxDYI3wdjS7eVM5WcDK4M2DaZO8JbOkkEu23U1Xb5JvE
 1HjjkQJAai2llOHqR9rraeDjH+One/GG46ljU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739630283; x=1740235083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ewl7ybm0yxAWipBRmNjkAr4+rT8G8Nf3bWNrT4O+52U=;
 b=iiaqnNxTiM4PGip7OD9u1fP+qFANPtcajdSOLUyg/s9koUAvKUhC/MArfrzcvUpHSW
 0t2UYhWgb2tSPNyOlK+MQvzLZXKUXbjMq4Sath9f4PZ35yx6CCxXPPZqmeaeQ6AahIoV
 AKpsxvWBXa7LjrIJenw4G/76X5kCjyQg473H5roYLCWdgtTYZSyvVwWTxGj7t4mccPZK
 9+c8L4gnjPkd35ktNrUtjkXLIDSLgzVV4lSLEFTNcZYptiRGZmJYXSAcsjVka+X14LOi
 tQIT+qYBOm9gMQvkCA3uOSqRH4bn7WsoxgKFAY4jVQ21k7hj8c+T2u+s9+hsVige8Aj/
 iMIg==
X-Gm-Message-State: AOJu0YymQikkEtvlvgmtS7K1FyyO3rPuZffwPqtcaXSKFJoifp3QFgLX
 mJOHbHhlxtwIMmSKBrjGvPTM2iRlVy7T0LLbGvH7wJpPO9TcYsR185JXvOgO3GQ=
X-Gm-Gg: ASbGncs5Hw1LxMcOoOIFkOoJIpDiKYyMKR0AvrzCzB+m33WQBRFfE9iw0j6ZuE7vbwj
 4sitMmknjLEkF4qafGgYueV5mdwQ+rDRILknjjDUoP+VnYePsqlaqWrFfeiKhCFQ1peUrkG4fPx
 X6jVjKRlC6ZLChIH4t11OXpagJjM92Mjq3q6d2fDaj6e12wFB1FBYQV8D7ohNIVhVu64bZrM690
 HtL38eoIV3aiDsQwxj7lyV8yofyafYM8orU47/n47kQGx4FEgVjfuUe+g113U220sKhNjKJIpWA
 g8GLEaNV86IXCg==
X-Google-Smtp-Source: AGHT+IFwVlN5xohW+mK8O47m3J+e+q+MX5RN3wwyl1WFaSwsCKUGI4Nwpa3ecJEy3Gcl9V6CpoyKtQ==
X-Received: by 2002:a05:6a00:124b:b0:732:1bad:e245 with SMTP id
 d2e1a72fcca58-7326179e7d8mr4760516b3a.7.1739630282940; 
 Sat, 15 Feb 2025 06:38:02 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73260f9e6e2sm1664893b3a.79.2025.02.15.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:38:02 -0800 (PST)
Date: Sat, 15 Feb 2025 08:37:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
Message-ID: <20250215143759.GL1233568@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
 <20250125225042.GH60249@bill-the-cat>
 <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
 <20250125230058.GL60249@bill-the-cat>
 <CAFLszThcg5imJQUiOccPYuJkVuQ2OmZd6K0BoLMkWj6-DPVGJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J9FkXHFuqT2OBXcz"
Content-Disposition: inline
In-Reply-To: <CAFLszThcg5imJQUiOccPYuJkVuQ2OmZd6K0BoLMkWj6-DPVGJg@mail.gmail.com>
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


--J9FkXHFuqT2OBXcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 06:02:39AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 03:56:02PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 25 Jan 2025 at 15:50, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > > > > > This fails on samus_tpl as there is no 'net' command.
> > > > > > >
> > > > > > >    =3D> net list
> > > > > > >    Unknown command 'net' - try 'help' !
> > > > > > >
> > > > > > > Fix it by adding a condition for the test.
> > > > > >
> > > > > > For this part,
> > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > > Add a blank line to keep pylint happy.
> > > > > >
> > > > > > Can we silence that pylint? I don't look forward to the churn o=
f adding
> > > > > > more blanks everywhere especially since imo it doesn't improve
> > > > > > readability either.
> > > > >
> > > > > Yes, but we would want to do it globally. But it isn't really a g=
ood
> > > > > idea IMO. We are trying to use PEP8 which loads of tools expect..=
=2Ee.g.
> > > > > my IDE shows warnings in this case. It might be better to just fi=
x the
> > > > > problems.
> > > > >
> > > > > As to readability, I'm on the fence...in practice it doesn't matt=
er
> > > > > much as few non-trivial programs have a lot of top-level function=
s. I
> > > > > would rather keep the tool happy and use the Python style that pe=
ople
> > > > > expect when coming into the project.
> > > >
> > > > Yes, we should do it globally. Can we not globally also tell tools =
the
> > > > deviations from PEP8? I remember back when people would argue about=
 if
> > > > we should tell file editors what to expect for whitespace, etc :)
> > >
> > > I'm sure we can do anything. But why deviate? Is it just that you want
> > > to avoid churn, or do you actually not like this part of PEP8?
> >
> > I think it looks bad (personal preference) and we have that in almost
> > none of our tests I suspect so adding blank lines to make PEP8 happy
> > rather than adding hopefully a line to a common file normal tooling
> > reads seems the wrong direction. But I don't care enough to not apply it
> > if someone else does it. I'll add missing blank lines when needed
> > assuming the pylint CI job complains once it's done.
>=20
> OK. I'm a bit confused about the double-line warning since pylint
> doesn't actually show it! For now I've changed my IDE to use pylint
> and disable pycodestyle so now I don't see these.
>=20
> The current Python files show up with lots of (other) warnings for me
> and I would like to fix them. But it is quite time-consuming.

Note that I posted a series this past week that, with one RFC'd
exception, fixes everything "make pylint_err" complains about with
current pylint.

--=20
Tom

--J9FkXHFuqT2OBXcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewpsMACgkQFHw5/5Y0
tyyciQwAm3YXr9Q1od7UaHPuzhI5CLklVRlwNpQxf3rz0MaQm6XpgUAdevPVpJSf
vK74+HCKqB6LuRSVvD0QGCSc5MmQqUlvbeUbf/KYu7bgpNYuHLSJPXQFGvuix+lZ
sZ9eYzYRgN2Cp0dyFcvn1+BZgvcSCchbIeSTrjD43QTSqvTyLog0wvDvG0eHI0qS
zpBZ39ZvdkWt4XWTHUF1DJj+0dNnBqSeAawb6t9+b6D4quT5/mrlsjq0Oj6ZBwdE
FUnUBbWZt2C9DQz1LVFfeD7smK/79kHRh5Ce4a0es8CuWz2IACGmtFZImiHJ0DeU
Pqq/5+hXsx/CoSFKsWvInZ8WzfTwEfRnGXch6VHreKIOPqcDnJmDnEf1oEhTTIye
TbuqZBYB592R53KCduEsYYow/XsF3EkN3hJaNfkCR5+8YMOH//aZEycsXLz6TQ5B
aVs55kqfhY9QOw1FvX5LveN2Z6AI1lvp6k25a5OXyXnF7h3wQSHxFexE5k5y8ULV
6ku4L1Y7
=tX0U
-----END PGP SIGNATURE-----

--J9FkXHFuqT2OBXcz--
