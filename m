Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D86C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7588E87BC4;
	Fri, 15 Dec 2023 21:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhaCvJgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F40F87BDC; Fri, 15 Dec 2023 21:13:30 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD98E87B8A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67ee17ab697so7791486d6.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702671201; x=1703276001; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dJkzhxgekcjQzDIOSQ6E0R2cNIVYi8wDyo1ypmcJpUo=;
 b=BhaCvJglM6HO7Bv+IJZqHUkYCL+qixOjSf91b1yhJPZqFR9AIvb5ROf2SsidhHc2YW
 nGRxYmT0U2mtDPojrmA3qM3I4RFEh/sB7qbebeApL0tEtfTR3YMSa2I+Ta6RNaH7D/eC
 KGEWardYnTKbyCeWn9ORbUpjaSa+k9CA5bQu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702671201; x=1703276001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJkzhxgekcjQzDIOSQ6E0R2cNIVYi8wDyo1ypmcJpUo=;
 b=nGKmq537KRn5uGytp14/ht6Ej2aAqQ/DGEVONWeDtTjGTQpA8FFEPeTw96GvFj8yEE
 fJu8CP7g2EHe8BNmr60NHnDK+QGTK3QKLYytwb8/Dg6beweHkOuLlFEvuXCzXRFNMveb
 cp48MAjifLL4ex7lQNeIsOvmeThN7eqXMZU4Q7IrxtD+qb78YB0fzl3uomFN/neDZhBS
 toPak0LqwJWDZJNt5hnancgI7wBhSVfoF+dNkMC2b1rDU5sUOOQp0UfCflClcXj4lNtI
 T6qx6G3SXwZMYP46ociypO6YxMekICb2LWgIQYeIPkHVXWQj8fQL0fE+C7kcYcA+nUeg
 Wyqw==
X-Gm-Message-State: AOJu0YwDnYz2jmiAH5tR0Q4gkKi3qNgcIwaCstxokPwYFHag+N8Rlh0y
 7zNPGd6G4FTT+y68VnyjlfvXzA==
X-Google-Smtp-Source: AGHT+IHPhYXCZJvQpaAecTxVto/BhRym7D0GBeuJFWXA/Nalek/+tizsq9ORRw8BmHwQ2eiS1T/K4Q==
X-Received: by 2002:a05:6214:769:b0:67f:12f9:cd01 with SMTP id
 f9-20020a056214076900b0067f12f9cd01mr3584585qvz.44.1702671201589; 
 Fri, 15 Dec 2023 12:13:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 rb3-20020a05620a8d0300b00774350813ccsm6329669qkn.118.2023.12.15.12.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 12:13:20 -0800 (PST)
Date: Fri, 15 Dec 2023 15:13:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2024.04 =
 u-boot-stm32-20231215
Message-ID: <20231215201319.GB2513409@bill-the-cat>
References: <3fc77153-d293-485b-aad3-32757be6ee73@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2CIHR65vvL3BUBzp"
Content-Disposition: inline
In-Reply-To: <3fc77153-d293-485b-aad3-32757be6ee73@foss.st.com>
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


--2CIHR65vvL3BUBzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 05:30:42PM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/next, v2024.04: u-boot-s=
tm32-20231215
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/18947
>=20
> The following changes since commit fa3f19aa56c519d6345cc774187b7a8fdc053d=
71:
>=20
>   Merge tag 'xilinx-for-v2024.04-rc1' of https://source.denx.de/u-boot/cu=
stodians/u-boot-microblaze into next (2023-12-14 13:27:11 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20231215
>=20
> for you to fetch changes up to 395507e50d7137e0bcfce74e1b4122e49d9984cb:
>=20
>   configs: stm32: Apply savedefconfig (2023-12-15 15:41:23 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--2CIHR65vvL3BUBzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8s1gACgkQFHw5/5Y0
tyyI/wv/QaSwdqTafAP/XNKqlvwvWhmrIvAwzSHFwW3PydVKpTHN2tduazfpU7pO
qRr8fSQK4byfCyHzvPw+boGLSiYeDNUgfK7PYazIDXDKoPZxXk08g2mrijQEJQJI
P0+yRAw0HxbFpF7kZ5KmtFPyzQOESgGBDQqava6VHFieL9UITT59UcIxqjGH9JqC
go9WdouWWYMioehtcQx96Sl3Qx8FF/WvzXmeSBxnNmskQHxjF+t1oR1N91IMSy/3
amfwIjUS7NidMd+tAqmOT8azGIG7e8kl5LWEWn3p6AxYFyxb92Mvj2jbIUv3r2ny
IAuz/7p33JURrHBWqhxXpIJfNnudJxKCmVOcy7pkMowcKF7Xvnr9AeAqiUB5fNeA
y4/pqhxima6tFjMlYtdhXLFa2ACQwXMOpGYlHStsZhS8hviZKATUtJ4DFAjIGokW
xXuihboqaBru5+kLZ99B+i25d7OnNJdgQcxnLrcg14nic+nbHKBln+Swu1JnKn0I
CrD39KSV
=xsV0
-----END PGP SIGNATURE-----

--2CIHR65vvL3BUBzp--
