Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828F1C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E678867CF;
	Tue, 15 Aug 2023 16:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I5Q2TlaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E36867E2; Tue, 15 Aug 2023 16:46:51 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53F2863E9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-589e590af61so35354657b3.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110807; x=1692715607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KXgmEbzaDWAxbAjbxl4G4gwX4D/dz/iGnvR9l4SnDjk=;
 b=I5Q2TlaG6z6uhmy+Jjeh0UTigA9L0JT33FMnr9xIN7kilLtxPY6KkKkiRN8ayyyoim
 p3NJ3cvwEnJhGaoY2/8An+EOzQ3WnCTi5NqQn4qhse+oUs/rSFG7kaF3UhiADmJqkiW+
 +BSAQsbJFUC/K6qrfX2HqGJl+TXrtzJd9sPWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110807; x=1692715607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXgmEbzaDWAxbAjbxl4G4gwX4D/dz/iGnvR9l4SnDjk=;
 b=ho4m8sZHaVxWodPG+/2FAfNEKVwtuzb6t56rrq86fApYCHbAXVsJrR4jBWBTLRdSf+
 B9bEESdev1WdaGPEdNbnP+l+MeoZL2CxQFU94Z3CSI8uT6p3bHgsbkglbc3WYawgY4xH
 eyiGcLp4Vs9Q+LSm+GIbezZVt5Jjw4XmD1iKgANHhdlWyPRmXH7Xxf5jGVX27t+UgYgJ
 85xw0eyKr4ky9Jya6UO2hr/H12ni58RguvYWXdRf7slUy2FmI4cRXIgH6d+8ZMl3Hm/m
 LxtJXZpUNp9Gxi69Cn4VQxRtu4bIlxSXk++OymhzSEoWGuqI9hOxgTK4T8L1KHcao7a7
 gU4w==
X-Gm-Message-State: AOJu0Ywc9IYwlcpCIgpOQcInNH+LY/eE+tktYYsPXH452Tq9unyqTAYV
 eyQR2vZ7CN9WElY7WII1vwWJjQ==
X-Google-Smtp-Source: AGHT+IGpyknHhN5uGbWXYRunFRUtFjUbNIXbzVar0KV1bgmTj/HZKWOEQyzvDn+5nMdkHK9hqdNzDQ==
X-Received: by 2002:a81:4914:0:b0:586:b847:5ef0 with SMTP id
 w20-20020a814914000000b00586b8475ef0mr2315590ywa.4.1692110807574; 
 Tue, 15 Aug 2023 07:46:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 f184-20020a0ddcc1000000b0057a44e20fb8sm3444447ywe.73.2023.08.15.07.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:46:47 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:46:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v8 4/9] sandbox: Build the mkeficapsule tool for the
 sandbox variants
Message-ID: <20230815144645.GX3630934@bill-the-cat>
References: <20230812142223.GI3630934@bill-the-cat>
 <CAPnjgZ380FF64cHtBjMTztJpj1bqF3-u2Vpt0YdRo7EzqSiVcw@mail.gmail.com>
 <20230812142824.GJ3630934@bill-the-cat>
 <CAPnjgZ3zC_F4OvuUqfU1=V_aAp74kyNNcEqgNky2VhyWhcpFOA@mail.gmail.com>
 <20230812223758.GK3630934@bill-the-cat>
 <CAPnjgZ0sfYRBGxB=_5Loi-9K=RgfSqLHA2FLafYgBs9vQaC59Q@mail.gmail.com>
 <20230813124045.GL3630934@bill-the-cat>
 <CAPnjgZ2moLG0HKVyQ5nZk91080dpNbC9EYD+u1H1Dw6sYkJ9sg@mail.gmail.com>
 <20230813144352.GM3630934@bill-the-cat>
 <CAPnjgZ0DpYY3X9w66N6G0tgAwoN_3-SToTT+2yMmk0Gibse8fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n/BIpPtqPmlzWdSG"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0DpYY3X9w66N6G0tgAwoN_3-SToTT+2yMmk0Gibse8fg@mail.gmail.com>
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


--n/BIpPtqPmlzWdSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 08:44:18AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 13 Aug 2023 at 08:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Aug 13, 2023 at 07:36:45AM -0600, Simon Glass wrote:
[snip]
> > > I see what you are saying, but from my side I am trying to enumerate
> > > the boards, since generally I (like) build things without explicitly
> > > specifying each board defconfig.
> >
> > Yes, but that's not possible in this case I think.  And I'm really just
> > trying to figure out how we can make CI a little easier.  But maybe we
> > can't / don't bother in this case and keep fixing up the sandbox
> > defconfig files as needed.
>=20
> Maybe...it sounds like you are really just wanting a way for buildman
> to manually build a single board with some config added, rather than
> having it detect and build everything that is in-tree?

What I'm trying to do really, is since you didn't seem to see the value
in config fragments before, showcase how it would be beneficial to
sandbox (and CI) if we used them there.

--=20
Tom

--n/BIpPtqPmlzWdSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbj9UACgkQFHw5/5Y0
tyyVrAv/Wn32z2FDt3CI6+WsAGLoje4h8VQRiwM1/608nqb7H/kWWz5bD7PDesg5
HrgNtJpItaVCUYJhgQ4rgsMbVmG0ANRwYbewtwhp2h8EjP1arwR5fr516fmkRBGY
0Th712vIaTrP2rFknAaRnM5SJBYXHtkvmI2bl5klfD9dwvUvusM2K0yCkhc3nhdr
G+jok97zg1QpkyNU/Jh+9JRbGC1B32wa0A+zBQaqEXjT2qX6auEYmnEr6/42bgGh
Ew1HvmbghVe6VKJRvKPOjZQictMqYlils1xgKrogohHmXtppVS0nSn7DFqxJfMTN
55UiIF2QDGx0GQISeXMECYSpmU+wfkfrDFrH0zPDICBPc+gFAgSBR77+vqsWrbz/
vSONNnMzGDPqd+k8nSFcJnVoifZH96eWhLKRMpxIzP88AdVjblWhu1SFKmSisfWd
kPInd9wcui1EdIcW/MCsI8AyuMfPugO8+9k17D/q6/bsDqysFyZm+91a2HNAb/wj
sumyBqf2
=nOYV
-----END PGP SIGNATURE-----

--n/BIpPtqPmlzWdSG--
