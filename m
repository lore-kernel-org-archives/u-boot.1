Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EBACD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 16:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BCE83FEC;
	Fri, 12 Jun 2026 18:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ddurZr+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C1F8467A; Fri, 12 Jun 2026 18:38:51 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36C9839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 18:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43d3031a750so813786fac.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781282327; x=1781887127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zSWvxMMuMDwHcN/1UFulKD6IZnSMoFcSdg99jgA71tA=;
 b=ddurZr+qvtz6DXuFBXHPM8sFc+X82XvIYwU4vP7EsZxiPaHpUMY8ifFxYm5i91iE9D
 x/unk186W1dguezok/fEtH0lr72hVL0XjIe1o5dQwyuEwFFsLZGLmn71zwigffMXWh9x
 rlX1aPQVLkzdosBC7s4UenSSJVT/AVHEvwlSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282327; x=1781887127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSWvxMMuMDwHcN/1UFulKD6IZnSMoFcSdg99jgA71tA=;
 b=qe1QAuO1rkNwXf9mjNi/y309zZUV7crf3HFuPJRiJbcGyy0kYT84dpvYByBvLjM+FX
 JzyOQk7QoyEYbS25d7n+XMny45yOyWRFPpfqh2wRZXutjlHSgTorlo73Q5Wszs37ihE4
 Wvt91nRyk+ifbuhJSTklMav6B1jJZmCtIMltgK8yvu224fi9nHj46gIoaL7TyXIkqd1F
 FMRYBPiGJBam6HA5IpYrPyLEraypHyXgh1kb2UmTTgnABTOuqSqe2XHkaSkkkW4ac2cx
 8lUoJWrefNpZ5oaCVLLlNWBc4sLLJAk6TA/bK2NjuVk4EMlDfYAjVBcrMg29pISoll6K
 xi5w==
X-Gm-Message-State: AOJu0YyO5KobBGNoJ0YUgXBSwI1asexr/c+1pDe+CtDk/9/XcWGe+22A
 QeSAWgJlwyePO5vuxJPuKHinYOXcdHYH6g9yJKnOUi3n0hvS2lKej9oZLJGfWKoIfNFP8mOem//
 JW99yEPA=
X-Gm-Gg: Acq92OHSoAb4PtGZNA0KXhmg3rMFwo9cgujMk1Ebg9NV+WUPbUQL7K/DOjcJ3Pq6Gsc
 RWhFjlfulmtmU7gui/zIkIlZwG/6A2Umq4IDFwWqophaAdF+1Hb60RVQ6fCgDO/J8oGTreaipHg
 GCfdQl6q5QczdkadyJLVErPpPhF4v0AJj8TQ1mYSc5WOQGxKTHkf5yo0/pPmv0xj0fDI6Yz+kqi
 4Z2UeNlO8HI/pBBHAUIeb5LxWMC8E8Gf5lxW/zaHytfubkLpmf8jw9xky+s+lqtN91zNmPJl/Bg
 bcXsGrfB+pmfWhlE+2QPidU8WuLvN4uc9/OFrGJSWiGQxgDejFdHw97K1Qw6hLuVWQmOwnTTy3d
 hwTfyZqdAyFdGy06j0H5ecJW7jbzaa2xGa5i/UNKsGw1FtJuUXSm99WS5/8utTadBHvUHcWRpgd
 lVoN8x3eCt5yZxRe13xbviJ3J37TRA3bc0C/dUDyvcc2Apij3fICM84gSTqlxwCS2TfLsNFBiGo
 yED1w7dd/+cwRKpZ51jdNB8WZAM5I8jlhyIHgm+mUj9Ds4q
X-Received: by 2002:a05:6870:d114:b0:435:9a81:f35f with SMTP id
 586e51a60fabf-4428c6045admr22385fac.21.1781282327524; 
 Fri, 12 Jun 2026 09:38:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b30eea5sm2121996fac.14.2026.06.12.09.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:38:47 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:38:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Joita Mitra <joita.m@delopt.co.in>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Which booti operations are essential when booting Linux directly
 from TF-A?
Message-ID: <20260612163845.GP382693@bill-the-cat>
References: <TYZPR01MB4258328775AA7859F7738379CD1B2@TYZPR01MB4258.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uobg9qcvzb+RboZc"
Content-Disposition: inline
In-Reply-To: <TYZPR01MB4258328775AA7859F7738379CD1B2@TYZPR01MB4258.apcprd01.prod.exchangelabs.com>
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


--Uobg9qcvzb+RboZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 07:29:47AM +0000, Joita Mitra wrote:

> Hi,
> I am investigating a direct Linux boot flow where ARM Trusted Firmware (T=
F-A) transfers control directly to Linux instead of booting U-Boot first.
> Current flow:
>=20
> BL2 -> BL31 -> U-Boot -> Linux
>=20
> Target flow:
>=20
> BL2 -> BL31 -> Linux
>=20
> While studying the ARM64 boot flow in U-Boot, I examined:
>=20
> cmd/booti.c
> boot/bootm.c
> boot/bootm_os.c
>=20
> and observed that U-Boot performs significantly more work than simply jum=
ping to the kernel entry point.
> To replicate the required functionality inside TF-A, I am trying to ident=
ify which steps are essential.
> Could you please clarify:
>=20
>   1.  Which parts of the booti flow are mandatory before entering an ARM6=
4 Linux kernel?
>   2.
> If Linux is already loaded at its final execution address, which parts of=
 booti can safely be skipped?
>   3.  Are there any minimal examples showing the required state that Linu=
x expects when entered from firmware instead of U-Boot?
>=20
> My goal is to reproduce only the minimum required Linux preparation steps=
 inside TF-A.
> At this stage, the most important unanswered question is not how to jump =
to Linux, but what exact environment U-Boot creates that Linux depends on.
> Any pointers to the relevant source files or functions would be greatly a=
ppreciated.
> Thank you.

What's required to boot the Linux kernel is documented by the linux
kernel. See
https://www.kernel.org/doc/html/latest/arch/arm64/booting.html for arm64
for example.

--=20
Tom

--Uobg9qcvzb+RboZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiw2FQAKCRAr4qD1Cr/k
CmltAQD87xd3n58q0VPpePeC+CY+uacGySvOsgrzXfUlhYCGKwD+PzSIwvsX4wjo
JzpPzIv1eG4kbamN1wQ74Wf92BIjkA8=
=txGS
-----END PGP SIGNATURE-----

--Uobg9qcvzb+RboZc--
