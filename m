Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C01DE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 14:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017A98021D;
	Thu, 19 Dec 2024 15:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G6Qs39z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE7B8022B; Thu, 19 Dec 2024 15:12:15 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EDC801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 15:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso51026785a.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734617532; x=1735222332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yUAxmlySJin7mLYC3ZxwLM3X6W+1hjTNHiYQmZtA6r0=;
 b=G6Qs39z7W3yrHocBhPFeYw7ytekJRUS4vIP+hM4PDlUeNsuBrxOPI/WY80BLTygv1F
 yIol/qw2vJhyzFSuwFGZWa40m6Us+btWnMJY2TJsTPEuBBbiXV52UYGhoNmfP+6i0NTL
 lwMN8e5x9O0HiQZT+NRbU0zDRgDd8LCx5A/wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734617532; x=1735222332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUAxmlySJin7mLYC3ZxwLM3X6W+1hjTNHiYQmZtA6r0=;
 b=BtJM3E7OofoFUhDYBlaoLvniEA6pc6F+nxkN49oFu87Xc6UX3brDHVQTgvpzq9ZXmy
 LwbFmcB0Bb47895arvNopJxPJ8ccHWStTtZU+mtA4u0OU6BFpDIt4MrIz5L1Aup5zJ9H
 VGiYmLPhOEUPcTVMiz88QHzUlwCWATsZsG87Ax3MWqV923RueDlC9+Y5xZbXxlf2h6o8
 31MBMAHjAL2QgGdiQJHwUFe3u0zY8b1e+qFK4uTPG9li/i00wUHyH+tOR9KlNrrO9ptn
 t1T6MlbBLKwL+kypOPcSTpDn47GeXaZEpzYTazXNVkDKY2ZuXmK+YNUQyrXGqqOqHpWs
 C/PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD/WUs5b/A9F15aK49T6mzq3lCLoE94d0UAlTcKngPnD8IXyi/PXqwfqiPnWdLbJseMvY58fQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf1ae4+cLqPei7cYuZYTxrTWiyNxFHLdrCPJfWv23E8MXWNhIo
 Bm85M5dGbP7dCjaHMrtmwAuIKQ+ydg7KNP+Ci8PQAqnuOB6feIv3CNFmlTcYtEw=
X-Gm-Gg: ASbGncsC4S3r20hlVdn/pVozpDRPRycbQ4rcjl2FSyJ+J8IhxM8FFNUbNDM+eA9A2fr
 5b/SWQgfQ/ZNJiLSepwE+H99wYsR0h0cNR8CLZ2HPB2yX15BP5kLoIF1uGoGb2ZZuYKfbYAKcRU
 SX/r0IyX/Oh6Vi4EhRGnyITTTCoeOafIrory/HlB36C0jiuaNFgVjoIDJBEqcvqwV3cjEscSu1i
 SH3xvwizMi5fQXwY0GG6TfVGf41JUqCrG1bkLD+EKhS1LJXZQnJV8tu
X-Google-Smtp-Source: AGHT+IHv7Zyy1vBc3DDMxOwXpVML8+ZOCSdzrtCXHhhXWntIVgNqIMeZFqHt5Bq02g9e+HqqRWxL5A==
X-Received: by 2002:a05:620a:2415:b0:7b6:d1f6:3dc with SMTP id
 af79cd13be357-7b863720470mr818984385a.18.1734617531858; 
 Thu, 19 Dec 2024 06:12:11 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2dfe3bsm50798985a.36.2024.12.19.06.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 06:12:10 -0800 (PST)
Date: Thu, 19 Dec 2024 08:12:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Message-ID: <20241219141206.GT1505244@bill-the-cat>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
 <20241217202900.GT1505244@bill-the-cat>
 <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
 <CALeDE9PU4emhs0VNLSyhen9KF80UD9R_AoChRAtGs+GzAmbezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lVsVIi8CYA5PBcH1"
Content-Disposition: inline
In-Reply-To: <CALeDE9PU4emhs0VNLSyhen9KF80UD9R_AoChRAtGs+GzAmbezw@mail.gmail.com>
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


--lVsVIi8CYA5PBcH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:52:29AM +0000, Peter Robinson wrote:
> On Tue, 17 Dec 2024 at 23:44, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Tom,
> >
> > [snip]
> >
> > I'm very happy with your leadership. The project is extremely lucky to
> > have you doing what you do and we all know it.
> >
> > In my own way I will be able to contribute to the project more
> > effectively than I have done for the last year or two. So let's focus
> > on working together within the constraints that we each have. I'm
> > pretty sure that in a year you will be happy with the result.
> >
> > No, I have not been paid for U-Boot work for more than 10 years and I
> > doubt that will change anytime soon. A little empathy on your part
> > could go a long way.
> >
>=20
> Simon, I have never been paid by my employers to work on U-Boot or a lot =
of
> other open source projects I contribute to. I do it in my own time for my
> own enjoyment. There are many contributors to this project, some are paid
> to do it, some are volunteers, all people have the same standing as
> contributors, just like I don't care if someone likes to wear plain
> t-shirts or Hawaiian shirts they have the same standings.
>=20
> The expectation that you get special treatment in this or any other
> community because of the reasons you contribute is not the way Open Source
> works, or in fact just about any community I am aware of. you are judged =
on
> your patches, your non code contributions and your behavior.

Thanks Peter.

Simon, this is why again, I am asking you in public to explain what
exactly you hope to accomplish with your "sjg" branches and to either
work with the community, including the feedback you disagree with and
move away from touching those subsystems, or to just properly fork the
project and go experiment on your own. You are and have long been a
valued member of the community, but a community cannot hold when someone
says they're going to ignore a number of other people.

--=20
Tom

--lVsVIi8CYA5PBcH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkKa4ACgkQFHw5/5Y0
tyzvSQv/UzzTDeQx+290ALpxJqpdmWWrwo8FlcohSzDII7jm7SBlqD/3tdATuNLU
nszJBWa9sFqmmAz5Wt9Hy8J30xt7c4sTvsDH9U1/0EuMTAjRuioX5pU5CvGTJxr/
BCa8iJufK9OehEolZZlRA3CXHp3Xw73clyNYkQqxVMy0m5k2rgpy7imPfTCqX0OL
+qif02Lv+52IOPcU/Gz7SUzKWN2dz39qVl9meX4vfe9o792YI3GnTtxtZa3C6Z3I
E1Cpnn0rml1pqxOoY9g5J+j7+wF6yTqTpOCMeRcFRmD8ohINAIopLWmxuEhuv0yx
yUGLXFi3EnSCZT7FpLMSX+UUvrBHSzJrxkAcToJghUa7H5DZB6JV6mb66a586qYh
t6JYJ7h9ZrZTEjDlxCseWjWm/WxwuzRjVl2Eqy5OYztHoaRLPGLe6zi/aq9Q6ucg
pfCe7yi9QbKe3W59VHeLwcEMuXm8Caq5729fEaPGRfzMuTIPcJnbameKzg3/RQZR
HNyaShrx
=g87W
-----END PGP SIGNATURE-----

--lVsVIi8CYA5PBcH1--
