Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA0FC88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 19:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 521CB80980;
	Tue, 15 Sep 2026 19:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmSdw5NC-q6z; Tue, 15 Sep 2026 19:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 93CA780971
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789501840;
	b=TLr/pUnHUPQSjaCrt2FHUTGt8Bns22yq8FzLc4Tt8EifPM4088EcS3fmCZWrJYQnwIEy
	 tvzApg77WTkgYa1aRrsKL54fVKNlBp0qRYO7yQoLITvXn88QaESjIf2EQD85Fa9Mtj40Q
	 oHhDMHPF6541Y1q8u/TxjmfXG9ZPlYAuCkdP1zvl0aUlu+7w4JdxQDW3wg5zHNRrGg5It
	 aBqc923qmcP0CMgYmzS/hp/jC34XLHVpcJWkzmyZunxobUfZOCrg2yx+bx/Nljar/fksl
	 5RzpCIHAajlgW9yINPKDYisqn4ghqVm3ro7KpvBVtq9poLVJXJ34j4VmdGZ3x0rJ92A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789501840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wZik9iy/WloSjzP7ZAD4yGL10+8ZmiNvsUwply5pM1I=;
	b=nreQrLT5mYxs2ba0YIyNxljkJqgRnSXsFLFeLOoFRcTsaZu1yK8G+QbygNzsd61Q9Ggt
	 R5O+sYG2E6ozSGV6ggQ1ebow/xWy97nvGttYoGS16Q4cvxmtOVUTjyvUvfiyFoCbIRZrx
	 KcLGGO1w5dwpytDRni8WJ3vyRrwvkP/N+grCr9eJxTULnnz0nYZ8XI6SHujaNsUWdqqdb
	 1gsRiccxzd/nZA6uYVwrhHWmIMdboxey6bZ7SBYM95+5/GAn4wvM1MnrA0nk1BW6pBwiN
	 DqImnurS049e+Du5aoqzKf4gRocoj0SNcr4FfaJ+iCkQzLpY7izJee6CJeZZAl7Zl6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AMeT7ms2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789501840;
	bh=wZik9iy/WloSjzP7ZAD4yGL10+8ZmiNvsUwply5pM1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ybX9TWHqHIQAlGpHrfIWz+ki31si0vwGou5VsbByaW+mzDdrQZCCulrv6kpSNKoNP
	 kmOOixVZD0QSfeYWZmuL9GjhglpGPTZYBHjErl9B99tYIWCyDp8sxop0qidEVmhnBZ
	 l8uVf81mBHXlZAq1rLVo56x6bY85bPSMir4QpR9gs6nYp+EgQJ/yZHpOskYAEU4Qav
	 hU2yoJ3CiNdc2oFSxJl3Xc21Ns7Szd8lkuOz1n+1gEcwE3boaA6MVYRGKTXYWXR97b
	 lOebeBKE9KOD2CI9XXFmJByM4pR3PX2on/PeQZ3TT8qPPRX3WQARLsr9k3sn782sC5
	 XSop5H4rcoNSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93CA780971;
	Tue, 15 Sep 2026 19:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CE7E352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79E2380971
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSSRkouW9f4F for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 19:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9BA2580970
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789501837;
 b=dsIeYKjDXNZzsewHTAGFUk5DsN1F8Y9SYHu26k5C2qmO68BWe4pgvlwEEgT9K+IsPtgG
 oI/9xxmpwqPeNRBC5badOFvdB4Lc3sfGi2MeJTa4xPAiG3R1YZNH+Bzh+oSBpmSGt2k7H
 Q6gFOJF1g/1Culn+Pg6SVg2fLUg/tXjpL/gGwBOFGVMEFQ4u6BYbwWfQ39jPS8pvIBtfb
 +B7phiWOrHIc1T5t3v72byvKf2WO59a9AkGe19cbVhZtdkoDKbKVW2uxOMpfdf+RjKiks
 Jz4vFfI6C+oChIT/OoMlVdq42Gn5Pj0WFcyq9Picy6SDmMrMjvVv9rYGam/OjrPL8yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789501837;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=wZik9iy/WloSjzP7ZAD4yGL10+8ZmiNvsUwply5pM1I=;
 b=OKKMgqNOzAhsl1KKNIZXYgqfTQEpUHt+BkIyz9dymtACO0/kO+LxWnRPcy3JZ1wRLdS6
 O2Po87J1EIMRZcXsdJougfjANI2rFTrKIRRP38twJRedy/PNichSE04fS3AyeTWsE1+y2
 4yykEj1eYhEUHKMZFofUoP791oKXI4DayuIVfC46WWrdynhat+VovUv1479RYXx4TWjnK
 A0NJi24TG4GjXu9MchqSnxVfvmqAhDwEmLXJM6rZPNz/cYO4ox7SZNFDvXDyYn9ulo7ez
 f6czCybunBtUY0byf1HfmCVQrQLXiNOdLPkFmXYIhcEr3Fc15tEEQNbsfQyk+Bfl4Qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AMeT7ms2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::27; helo=mail-oo2-x27.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AMeT7ms2
Received: from mail-oo2-x27.google.com (mail-oo2-x27.google.com
 [IPv6:2607:f8b0:4864:31::27])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BA2580970
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:50:37 +0000 (UTC)
Received: by mail-oo2-x27.google.com with SMTP id
 006d021491bc7-6b1ae736c64so165202eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789501836; x=1790106636;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZik9iy/WloSjzP7ZAD4yGL10+8ZmiNvsUwply5pM1I=;
 b=AMeT7ms21zVNk52QxninIBlpAjv4QWVUpcO3m0Z1kcmZLqHbaIg2Ck+MmFzfJ387nA
 sk4+QakXWBFvk+k2Ves2K83F8qC4b8QmrZDK09gW8IzyLplYsOXU5jm0x3fl1J5uvEva
 quWDbWDan7rnYSn0EHOh3C6YxPOO86izo4kDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789501836; x=1790106636;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZik9iy/WloSjzP7ZAD4yGL10+8ZmiNvsUwply5pM1I=;
 b=J9I/Js/boCrYNCXMGEff2BREoBgKasUtSrQDuJgkYZIayCfICxwzl27qhtpO/NyyEh
 j9fLxo3gSo4RoeaJ6wFdFXQa54+sg5Et9oaWqBX8d6WAdnVVcWmFF+y5R5VMG4rjhUef
 9nfp2h0GSgip15w+OCK99fhb1IBAzcUSu8sZlee7yfT8rjMNplcoZVdnMuAlBLhOkcG9
 PZMtWUyZ307AJoFCQtA/7ukY920LymidyDDpSpbTJCCckdBJeKrCOKwDuLAzPJjS5M8G
 IXkzvHIJy7oYFrvNMpJcBCUlqE1QhsyvOwhqQxMaVNHkeIgUPgRBK2B1gUwC8xADpbhW
 hvtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzehKDzii2IkfoqSfgjQrVyfdsl1xyx2vcAu+kMLJXd9m0TOoc2Q8Dcii4Pf/kAir6ftjG/6Wk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nqOhQHMFhjxPhpmwiT9BzGDKIcQgsPAWaviDKGo8Kgq1rcsDLi
 a0wRrQjV4osfa+Ob9vJksvDN+yx+dp56RAvSS+KsI0w/kkxA0dl/TZbF5mwj3/4iy3xpjtTFb+N
 u0f8lN8cUnZtS
X-Gm-Gg: AYBFou32636oz82y6kygJ+UPNKBO94LI83QmOke2tchE3jneF1+fqNvW1Kd5zJVMafb
 zHXPQGK4CMV/3bGt6LPEk9t63W0MoRc++xnBTO/BnVx8iTbaQ9cUnWRd6MrM1NsFQGqB4tMK97k
 yaI4K47kl3PsuucZ752lgNfuVygKMGTrKxBldfaX8cbWjiPaCwjpkShPZZcLb1erKbLPJYZqDUP
 xn0c+Ay/J4xPea+MRKsd6fwNAtihl3jcfWplCvjaE09bHYYjF2fPz4Wmm6COBE+Jh+gXub2X3L1
 FquwH/aUlhoEYOBlFbQe0iDywcmzZjwDdVwCBFIw1BQfEvZQGjSvZRB3SFIk+DbpF9dA3c9vav8
 uFzI5fTyr9V2MeUCeKluKl472UwS8atvwrvwj9WWmV76F6Pxhxh+cAtI7KHgtN9jcTc75G9+A9b
 xRPz64jZtuFYlO5PorlZjA1w3XgcgS1nZqPGEP/Ko7zSWi55GkXiwCSWom0k93jbl4fZB2pAL8P
 5WhSYe+MaLihe1USGCCqbOrGK/pCuo3aOt3OwGFvqMU1DTKPoYn08I+DQPfoKKn0zHiteOpdb+i
 Q3Af5yBFXjVmJD3X7xqG
X-Received: by 2002:a05:6820:198e:b0:6ba:a5cd:aac4 with SMTP id
 006d021491bc7-6c7d32fc9bbmr839eaf.50.1789501836314; 
 Tue, 15 Sep 2026 12:50:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48429a9213fsm767093fac.3.2026.09.15.12.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:50:35 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:50:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Eva Crystal <0xiviel@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
Message-ID: <20260915195033.GC858934@bill-the-cat>
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
 <20260915154140.GA858934@bill-the-cat>
 <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R9PE1c5PtapJU+Kj"
Content-Disposition: inline
In-Reply-To: <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
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


--R9PE1c5PtapJU+Kj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 07:18:15PM +0200, Ludwig Nussel wrote:
> On 9/15/26 17:41, Tom Rini wrote:
> > On Tue, Sep 15, 2026 at 08:45:23PM +1200, Eva Crystal wrote:
> > > Thanks Ludwig - I hadn't referenced your series in my cover letter,
> > > and I should have.
> > >=20
> > > v8 4/8 does close the configuration side: fit_config_verify_required_=
keys()
> > > gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
> > > required=3D'conf' are present.
> > >=20
> > > The case I reported is the other gate. fit_image_verify_required_sigs=
()
> > > looks up the /signature node in the control DTB and, when it is missi=
ng,
> > > sets *no_sigsp =3D 1 and returns 0 with only a debug() message. Every=
 caller
> > > then treats the image as not requiring signatures, so nothing downstr=
eam
> > > can fail. As far as I can see from your v8 hunks that path is unchang=
ed.
> > >=20
> > > Two things follow:
> > >=20
> > > - I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which colli=
des
> > >    with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the S=
PL
> > >    variant), default off, since the two gates have different blast ra=
dius.
> > >=20
> > > - Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image inte=
grity
> > >    only, not signed configurations. An image-side required-signature =
gate
> > >    hits that setup directly, which is the other reason to keep it a s=
eparate
> > >    symbol that is off by default.
> > >=20
> > > I'll rebase on top of your series and resend once v8 lands, rather th=
an
> > > adding a patch to a series that already carries review tags.
> > >=20
> > > Tom, shout if you'd rather see it folded in instead.
> >=20
> > Since Ludwig is already working in this area, I'd like his thoughts on
> > the issue / solution, and if it would make more sense to fold this in to
> > his series or not. Thanks.
>=20
> I didn't touch the image path at all indeed. So perfect if Eva takes care=
 of
> that. My series already contains too many things and had too many
> iterations. I fear that expanding the scope would delay acceptance furthe=
r.

OK, thanks. Eva, go ahead and just make yours based on top of Ludwig's
v9 (the changes for v10 shouldn't matter).

--=20
Tom

--R9PE1c5PtapJU+Kj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqmhhgAKCRAr4qD1Cr/k
CrsyAP4qHsmCRQ6vCLsqoKP5m0TIjfWexlWQuQ8E/M3hm+mqHAEAjglCr6bs4Znb
NQ+/wMHvw/ue4FZCxwCKUxaCu2XMcA8=
=n+Cw
-----END PGP SIGNATURE-----

--R9PE1c5PtapJU+Kj--
