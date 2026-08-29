Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026EC61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 16:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25D7A60617;
	Sat, 29 Aug 2026 16:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMBOds2GrdIP; Sat, 29 Aug 2026 16:12:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788019948;
	bh=W6eFNHrfiYxt6Xyoj6nCDXS0cfrwxSwDWIvpyO/Wy0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RAfXk8TQefa5WI/U+S7TNhUBIxm3eKH0atA/flT934Gp6N5L7t+RWH896SFkMYDNZ
	 Q3Q9UMInuYUExVB9UmTO7MCBnEDaxLO499eQu0tYQkQ/fagHMiLaUqYsYlh37GJuNB
	 xN2l2MKodvPN1ARYpFfkXkULAlvB+t7EACb76T5w/ZdF/9ax7H09iHjof49+a5rtws
	 LO3lDRN59Yd/D/ToEkrXzHzeudgiW2P8+nTwmTGKkOGjN96W5pWKCa5CpAsWlHgNHJ
	 aUwYzaldukVvwHWkkHa/3SU1ag4drYFyc4UgHg/OsVFxSwy0eFnx3c245wLHYk7VaL
	 udIex/01LdN3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AADB8605FA;
	Sat, 29 Aug 2026 16:12:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C747D23E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADB8C8084A
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Vh5y50EbEUN for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 16:12:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RpcRblSH
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1B0680859
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:12:26 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b383347fa6so2319274b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788019945; x=1788624745;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6eFNHrfiYxt6Xyoj6nCDXS0cfrwxSwDWIvpyO/Wy0A=;
 b=RpcRblSHIF4dSKL/8aFLmkfv27bYS+dTjLNRANRbUZYLGJbdKhIpvivMaBwmVb9FBW
 Fn5QrcN90Z/it2Ma1Nnm+NxV5/2R17w5KMUxaAErDvG+c5gz7siOm52ki7hpMJupOP+D
 2q1Q5KrkaZhsOpdWLEl2npTDKUnJ1ePgwZf14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788019945; x=1788624745;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6eFNHrfiYxt6Xyoj6nCDXS0cfrwxSwDWIvpyO/Wy0A=;
 b=JH2Tm4GwymNz2+kw661el+N/v90qbB4e+D0IuxuPzeyVxQkwtTvMrBe+8a6JoudRRb
 pJlhHIHep/Fe8JSz+jKD8PnOqhudrIQHx2xXIQ1GNv5BtJF+w13MzyRr368bX96FH68M
 REFavgknWalLwCELRwujeXISWKVGn+SQ62wfOlU3gxg5J6nJOcbEhYUFnkxJw83ai8Bu
 y64uHen2sDyoW8xEexI+bRuuM7URKxJbw7b7xsy6P0FmyFru3+8ESqVZ/CtsvqQqOtVr
 4VnpqTlxC90N+AK4OGrwA7z9mb4cvTWK2BUcv7reImLAss7ukT4+BoF3WiKiOsECF3Cg
 7fcA==
X-Gm-Message-State: AFuF++nHIAT+MRoTZQlU8iwvg3WSOxm+cmLnkyfzo/0f9wQU1+bWwNt3
 GbKA/NC0kF88o4Y4sYEC1eiFNtc+uHzybMqxWA7Vae8FEQQgs7noLskZgg/sDxkAjGE=
X-Gm-Gg: AR+sD13A0j0q5coYvnakaFglAIlN32JoSOk7iTtobzxRHTcdYcgUK7J3ykdN3uH0rZx
 pHXIfjOSeBUeQkaAVwmQsPrLHfwDsX6JQLQ5aPS7gN+nK3pC3iX/Hke+VUefBc/ACbSwSsoblb/
 RSov3z1JE0DLi4XSeH5ZemPEyX861QKcZowZzADGHkMJzQ5apAg+7sm0lU79a4yT3LC+SgoMg6g
 /gR5UvTBHR93/9XbUJn2YYRXwKph689LzWfWtDIONp13Ouu5MpFAL/Fk8UKf9xhFbRZycY4N5zJ
 LyxD1+ZGbFOJZw1e1EqQ8r7WWpx0fjfCHpl2aAvCCLkOKcl9CU+OpDkhVsLePF51Xkf5uuygSPH
 +sglJMkQVUacrRyFRKz8u6WhDbtoUESMMELVEz8Jnreovc+HQ7jZtg8hNAV4gFpQ/1+BsusJ3UF
 /9vxMw9AuVhaYsl4YzJM0B7u5LNau7vpPqwuxB+xOfjWupXZf/2Mu8raQLBnxc48qRYfxdP7zp1
 r3KuWySXIl/b13BoJ19wQE9tru1uOwKjgGai4VOzpl+/CZIRxv3++CQrpklIW7cs6RlPzEjycsQ
 nBbA/pl38Q==
X-Received: by 2002:a05:6808:508d:b0:4af:9364:b5a9 with SMTP id
 5614622812f47-4b37c82dc53mr19305219b6e.6.1788019945241; 
 Sat, 29 Aug 2026 09:12:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1625641sm4031974b6e.4.2026.08.29.09.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 09:12:24 -0700 (PDT)
Date: Sat, 29 Aug 2026 10:12:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: tegra: Update and correct entries
Message-ID: <20260829161222.GP3959812@bill-the-cat>
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-3-trini@konsulko.com>
 <CAPVz0n2EQAiqCGeDGosfrytB6908iPfvAt4JwNHtua6QE_ETOw@mail.gmail.com>
 <20260829155433.GO3959812@bill-the-cat>
 <CAPVz0n0dGEhiK-LO7kSQGvJnU1gC5E=m0U70cO9GAHjhwwKdiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QC3UY8vlQmTPvhdS"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0dGEhiK-LO7kSQGvJnU1gC5E=m0U70cO9GAHjhwwKdiQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--QC3UY8vlQmTPvhdS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 07:05:28PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 18=
:54 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sat, Aug 29, 2026 at 06:13:27PM +0300, Svyatoslav Ryhel wrote:
> > > Hello Tom!
> > >
> > > =D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=
=BE 04:50 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Update the main MAINTAINERS entry for Tegra to make use of the "N:"
> > > > syntax to catch everything with tegra in the filename. This lets us
> > > > remove the incorrect board config header entries for a large number=
 of
> > > > platforms while still having the used header files have a maintaine=
r be
> > > > found. Furthermore, correct some platform MAINTAINERS files that ot=
her
> > > > obvious issues (such as .dtb rather than .dts in listings).
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > >
> > > > This is slightly different than Michal's version because it adds th=
e "N"
> > > > entry for Tegra overall and so catches include/configs/tegra.h whic=
h all
> > > > of the boards which had their include/configs/ line removed actually
> > > > use.
> > >
> > > That is smart. You don't need to replace device specific header with
> > > tegra.h in some files, you can just drop them. Thank you!
> >
> > My thought process on keeping them was that if a change is made to the
> > header then all of the board maintainers should get cc'd in case the
> > change impacts them. I can drop them if you still prefer in v3 however.
> >
>=20
> I am pretty sure that include/configs/tegra.h is unlikely to be
> changed since it contains generic properties for all SoC generations.
> Even if it is changed, only SoC specific stuff is allowed there and
> device specific adjustment will require creation of device header.
> There are a few devices with non-generic header, mot.h and
> apalis-tk1.h come to my mind as an example.

OK thanks, I'll drop those parts in v3.

--=20
Tom

--QC3UY8vlQmTPvhdS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapME4gAKCRAr4qD1Cr/k
CvC1AQCG/cMd+BddM5kYgfoVBwmFqhtL2qvapVxi+WAcIXVwQwEAlx/vnMze4KWp
7HAeny2SB80kq0W4BB9uE4yaxdD8NQM=
=OpS8
-----END PGP SIGNATURE-----

--QC3UY8vlQmTPvhdS--
