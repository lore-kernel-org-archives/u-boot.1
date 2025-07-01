Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C9C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC4882CFA;
	Tue,  1 Jul 2025 20:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y2vJDIid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2631D82E08; Tue,  1 Jul 2025 20:52:42 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF0082B18
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea35edc691so1478781fac.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395959; x=1752000759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=taBmjUrJUvhbA+kkpmz0al5XpBrp6ez0TmT5htZhvhk=;
 b=Y2vJDIidEN1zFyKliR54jTdWm0d1PwxxZtkC1dIQ1+dQ/ymzAaC6iCodqmcLWnd1Wf
 fQenMbgXaLHJpazFYHyw8xOHYEAmvuS3RIRAa0UcN0E8IUL8Jn3QZ1yVM3Rr/yG28FmS
 o7F4Dc2hibImx74PhM0SuZU4fb+bsaSiEtu8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395959; x=1752000759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taBmjUrJUvhbA+kkpmz0al5XpBrp6ez0TmT5htZhvhk=;
 b=kLnozdEqH2pYBTBtk4jIVjh+VSMP2LIB9RNon7l5jba06hBYSkyyv1S7/hRHE/cR54
 0LBbMYPsuWmacb5ou7v8qLQ75EoOs5yEFnQ8Fe678zSM7xOWZ2E5vuZg1q0nm/gw6ir6
 pqvZbmsMl8FXb79G0aIWocuxwwRI2xY9xcfxWe5t3y3OEPcNs+tSBSS8xgKEOD6RdZv4
 JYAmqVGyLL/4P4L1TP6Ke8HcNpYoyDura3fFGDaVrE9aavVdHDPd859bWVMww1jbUfYh
 VK9/iM/+pSNfAehlsUAJFpa/INARXmfFkB/aH3d9pvDvMDs3xo1Tbvd3fq+MvewgZcV8
 9xDQ==
X-Gm-Message-State: AOJu0Yxzi1DCh+v9ojL6rI5+v0bnJOy6TpLDwQgEKcJ99w7e7KxXZyuW
 yNOIpzqLlDRUSU9KqDuEs6B6oLH5+ikg6NIbhMQZo+RmCe8OWls4LQLM/m78w/LogmLTyzlqge/
 Hvih0isY=
X-Gm-Gg: ASbGncvGxK6S3h1j/OnORfKcLnWrIi0sIp8z6WSpb/fLY/hqCQt+uY7lWLKNkFatNse
 bRynfoq20Fa437O5Dm7mjCmzwuzBtXzc9guSMHp6kGbZGTbvu4rNbJxZZue4UBwzRrqQuRzpH9m
 sylPo8f5KWxymwJwf6+Ut0gV0wgW/0Lrbq3/ZVxHTgpeI/8ksbmjCSkKKX+TiSqaj5l4jN6j0JP
 lx/mTo+RebXODhqK/8JDZW5bCfjP99l1hvZrk2cLrsVIB0z8T2uP0zFJQwWFBYPtvCx0ltR8ku5
 5OfXwLWP8M+N+XO/NUKsBkdqRTzT7GQCe4Jc1qoeQygOPoNz11c8cAL0cHKgoFj3RKL1KZ3saGH
 ed83lLB/2oaDNJRvHX3mNM8Q=
X-Google-Smtp-Source: AGHT+IH9ouo2bxPCUN3MrtuR8FeL/hHDtdl51WNZWgdJoI0dlggxPgPGuNQApw+eArv0HSOqvPQgZA==
X-Received: by 2002:a05:6870:d1c4:b0:2e9:6a0:80d1 with SMTP id
 586e51a60fabf-2efed6847e5mr12151584fac.19.1751395958572; 
 Tue, 01 Jul 2025 11:52:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb006a02sm2214712a34.23.2025.07.01.11.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:52:37 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:52:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] power: Correct dependencies on POWER_LEGACY
Message-ID: <20250701185236.GC523899@bill-the-cat>
References: <20250701184252.3191485-1-trini@konsulko.com>
 <20250701184252.3191485-2-trini@konsulko.com>
 <CAOMZO5A56QNX5KF1RC6_L1Ztb4uWYDkAQdkAxAi=mVrpCUQD8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zzXUsdzP9gwvKVLu"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A56QNX5KF1RC6_L1Ztb4uWYDkAQdkAxAi=mVrpCUQD8A@mail.gmail.com>
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


--zzXUsdzP9gwvKVLu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 03:50:56PM -0300, Fabio Estevam wrote:
> On Tue, Jul 1, 2025 at 3:43=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > The POWER_LEGACY option depends on not having SPL_PMIC enabled, so add
> > that here.
>=20
> I think you meant DM_PMIC.
>=20
> The commit log says SPL_PMIC, but the dependency is on !DM_PMIC.

Yes, that's right, oops.

--=20
Tom

--zzXUsdzP9gwvKVLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhkLnAACgkQFHw5/5Y0
tywVxAv/R9OD//Uxyr+tXYBZlRlfyMbKKlA41CLVAyk67Ut01C0AounHqTmZ93vi
mssANqblY1gGcn8v/kbGOhpe8shzNK4q7RAitATBY6SFc9olZ27dc/5b/RM35Sr+
xGOqsALDMnt4TpAVrCVMqVBkTlUpEbYmBqTR4svJtML67PNK/nNY/ZsEZBNlZDn0
L4kOivIiWm2Im0mwKiBOpsT0OhrwncTKfTPqC8EHgi0Wxhri1iSMk2E9T6cAFsvn
YSeKP754ZAVDUqd0x0LqeNLXEgJyfw2g+r7pBaRL+17ctJivEJr9VV6GwTay+Pcr
sE1Ab5Q11YOjry2Kfq/uEsOLVxLIbOEl8BQ2cgW1PC1gz/4XjBFPhZ+eBOjgdQ7U
pi507qs0wKqTL78zfVVQMXnuSBdEgjotYqN7M1BZWV4i/A4/TuE/QOw+p2mXkBQf
W8MML3SsVoKR+eXhZd03gbcCBRARrkNctF8iRUjfaSOVh1VTORvmL9r8SgnWMVDc
TbR3dD9c
=UgHm
-----END PGP SIGNATURE-----

--zzXUsdzP9gwvKVLu--
