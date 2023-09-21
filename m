Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB79E71090
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FC88645F;
	Thu, 21 Sep 2023 17:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xv4NWN1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F60886482; Thu, 21 Sep 2023 17:39:55 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8612B8642C
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d7b79a4899bso1298000276.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695310792; x=1695915592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7eTQmPc1ARuBR2CT5ptHgiZJ6AsMIWUUtiNcFLXdpeA=;
 b=Xv4NWN1/1pheUBBqm5EYausyDKCPeKLdXRe34+iCNgYXWIPkFS7ygPSMYu7gK6MbQb
 Pm5h8EwctvA2RQlgfdpfq3IuTNLi6gt0DAOfmc7PSqnM+bXkvnab6y55C5FIlp51uHQe
 prNTfVqrpnuE/HKBFDHU04tR3yTS+pFIuZ9sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310792; x=1695915592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eTQmPc1ARuBR2CT5ptHgiZJ6AsMIWUUtiNcFLXdpeA=;
 b=PRn5B7k0iGpsIrNlF+7qfFuEN9aHOrE6YIAbzLryazFWRD+YcmHRiq9FAk95Dy44pO
 3P+Zl3HZmtdFh99Bx0eTXBf4uFxinAFE+lmhnx7OltxXnZ1nr+5A+L7yGzIcVbF4C5wL
 yLJIlkwtMBEdKuiGaKGzszcVlb9kEz9eYvNUAizSGo8geiqw3fmFteYmZBQu4SRKfvKG
 jYgA1g3ZZmkYHQVWZ/hILfAeYUnhsB1vbEv2woBET1cJyhpsdsCYFtleW/3S70pvpoUC
 Qu9Ggldd8URqJY6LS4ogjwEd9V61rQ1zLeTcZko58dG3kavbiy5HHQU4nQLeZ6zOkqMb
 P+SA==
X-Gm-Message-State: AOJu0YyBcL/hW/lNRErydTceQlP8Ew7dqnnTzYE3RAAv3PQXysVovK5h
 5v2e3X8nLR8eXpR6fTg6ZAMeBQ==
X-Google-Smtp-Source: AGHT+IHHAUZq8BDP9+8FBzSIO7egxtjiefUi4v0XMN02WJrh0jpz7BBaDUv7/NQBAnaO5O1zxIzFgQ==
X-Received: by 2002:a25:3789:0:b0:d81:b42a:1c58 with SMTP id
 e131-20020a253789000000b00d81b42a1c58mr5517140yba.41.1695310792250; 
 Thu, 21 Sep 2023 08:39:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a25f811000000b00d20d4ffbbdbsm400207ybd.0.2023.09.21.08.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:39:51 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:39:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv9 01/15] submodule: add lwIP as git submodule
Message-ID: <20230921153949.GS305624@bill-the-cat>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
 <20230914161828.3662-2-maxim.uvarov@linaro.org>
 <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yzIsVf7bnCrGEaK0"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
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


--yzIsVf7bnCrGEaK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 07:03:07PM -0600, Simon Glass wrote:
> Hi Maxim,
>=20
> On Thu, 14 Sept 2023 at 10:20, Maxim Uvarov <maxim.uvarov@linaro.org> wro=
te:
> >
> > add external lwIP library as a git submodule.
>=20
> Oh dear...what is the motivation for using a submodule?

That we don't have a better alternative.  Using "git subtree" has it's
own problems and won't make things overall better.

> Our current stack is nicely integrated into U-Boot. This would make
> moving between development branches much more painful.

It really shouldn't matter in that case.  Unless you're trying out a new
lwip upstream commit, nothing changes in there.  It _may_ mean that if
we want to update lwip it's not something that can be staged first in
the -next branch but instead something to pull in just after release,
but I'd need to see how smart or not git is today about things like
that.

> I would much prefer that we bring in the necessary code, and that you
> send a patch every 3 months or so to deal with updates, making sure
> there are no code-size regressions.

And I much prefer something that will make sure that we don't start
making changes in upstream code and diverging.  I don't think there's a
mechanic short of submodule that will do that for us.

--=20
Tom

--yzIsVf7bnCrGEaK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMY8UACgkQFHw5/5Y0
tyzaxAwArUDOKkRVFCGCHqnCVVA+wdq5r8dP2ZlLASakKPQZ4rW/cYowRfiu9v4i
1LJlaANzjaa58d5cLzTcdcEjL6nSuM1FtK4gAfdR9hOBivvtW+ix8WyPTDp2B+84
rZjezYYKQfwTtzhxfYIr54wJ8s1+ZYFJQ1ayihZZAfKRH5STlPP4qCN7iTXZc48/
PXNaCKRUwzuOWr3BdbhUFh1JcKwdcyIPS0/fQgc0Jgp+mLWhaSbw8KUf4a1k9IuO
m6pWZ3V6FL8aG2kYUgEoOkEk8SK3J+DgaBeJrg37dm37Egv65QP2Lh6JmPLC99pV
1ZBLnc/dlMFmFo3xQcRjIAOUW98JlV40w+y8dQbzf+uG+b6E3cL4UmihZRWkdppG
hwRYkNwgo0flx6Pzqx3EpN732wJTkKZhnUKzl65jGSdY/7BeuKEwRhoHZbx8kI/I
4GeflOVHcsqaAxUh0vPunwR0bseoKeoJKeS01knnomDsh2L/KRieum8QVzlYKMhg
kkqiVcTU
=6dDd
-----END PGP SIGNATURE-----

--yzIsVf7bnCrGEaK0--
