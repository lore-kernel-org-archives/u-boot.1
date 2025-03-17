Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90681C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 21:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDC58056A;
	Mon, 17 Mar 2025 22:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MNfrSAJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406E680F4C; Mon, 17 Mar 2025 22:42:58 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E4B800B3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 22:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so3938992276.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742247774; x=1742852574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3wiGw8hzRyyvwMqHlJNgxmNt6NxJ5x4uYcVpqw2Bx4w=;
 b=MNfrSAJs33vNFXeIHlVXs4xgauT0vlc3p4KIlG5R2qWslohp738RM3XAQqxYTebCb6
 McTCtZWPe/u95bRmdXJfll0WKwDNhYEKhnW7pZ+FUjMh1qGnAphArPxF8/X1H6jgOS+m
 PMuZrxPnQTRTrT9eAdrzt0hwZICgVoiNDZm74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742247774; x=1742852574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wiGw8hzRyyvwMqHlJNgxmNt6NxJ5x4uYcVpqw2Bx4w=;
 b=f7+O7L5yBgVbQKXhPbqg6vWlmlzYp/4QRsF4tczwKJx2An+onwBk8XldXT3lo4Vlus
 d1UckZNIvNf6j0gzvVVx6TibyAT71C/1ggIEF3qgEBDle2cqR3eFokBYYqurQPsxjeo/
 WFkXWEIuzPtiHKhU+n5ggzPs32YzJWt8euwYA3ZqWf3q8QqrLrcXdUWhvFaJ/N0/deHS
 5yn+59IvQke0IY4flchdmECs1u/C/DLprRO4GaYAA9wxL2qtga1J5Fh6TdQfX8Yj/TxN
 iwGmC2xsETlz4BQ1mevADlNHLNbOzVK79jhQVO/+Ny+YGIusk8kJGUAzu2wkJ3l/QwPn
 ryLw==
X-Gm-Message-State: AOJu0YwQsnWvZ3dI44uNUM6veA/Qvmp8UBMUd3ZgFps3xaoOQEJAWIuK
 HqfRRirWf8eTH4nAnWJXef2zoUN3aq3dVnHZ6uwqNldkNKu9aneGnpzQ1knh1lU=
X-Gm-Gg: ASbGncuQjC8/I+Jt5sT23KOocifL0bjIb1ycYdHFkGlSsnkKc/KyKuy8MFALZSOvmJc
 CvVV4+/1NPKMXaQvWGQLa5xO9eQsD+qGsj/gCHTSp5bi8Znjhr+pJCWFRHcKkthq4XsYvYi7nmv
 sxUeLsHwfxqDo24MuPuwiDni7o0jXpUAlL9A50MRGMZpdM7TBmv/ZydCh+YwRn8fAxNccJOrsX8
 xk5qL3ziSXqWFDGVOIL9FBttzHVs5VXlMWjfBns2gOdM1IZGP31tT3vg0vSWNYP1/fzdqQxitSh
 hfIoU3IWOdH243avVp/De4F2VsLIR6f2bHtcntrcnAF70A==
X-Google-Smtp-Source: AGHT+IELUUdQtsFN2xUTs9d/dZOmaXyb3vbGrEZktls+dP2oW3FfNY4k3pc8F4Uea7hueUXNoU0QFg==
X-Received: by 2002:a05:690c:6c93:b0:6f9:871e:6903 with SMTP id
 00721157ae682-6ff4601d5d8mr190432667b3.37.1742247773897; 
 Mon, 17 Mar 2025 14:42:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff3288f5e6sm23440797b3.58.2025.03.17.14.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 14:42:53 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:42:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH] Gitlab CI: Clean up more
Message-ID: <20250317214250.GS2640854@bill-the-cat>
References: <20250315141744.452073-1-trini@konsulko.com>
 <CAC_iWj+W2Z8raS5_wuKRNpCwi_N5E-zfNX2r0L9AD23Qf2fi3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wJiz2r09PVewN6Gh"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+W2Z8raS5_wuKRNpCwi_N5E-zfNX2r0L9AD23Qf2fi3A@mail.gmail.com>
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


--wJiz2r09PVewN6Gh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 09:12:14PM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Sat, 15 Mar 2025 at 16:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > A problem we hit on our CI runners themselves, from time to time, is a
> > lack of disk space on the host. This is because Gitlab has no automation
> > itself around the removal of items it put in a "cache". While part of
> > the way to alleviate this is for the runners to run various docker
> > cleanup commands on their own, periodically, another thing to
> > potentially help would be to further clean-up in the job itself.
> >
> > This patch adds "git clean -dfx" in jobs that leave some files in the
> > source tree (these files may lead to a cache miss, more investigation
> > would be required) and deleting the board build directory. This part is
> > both a minimal size reclamation and minimal time increase (a few
> > seconds).
> >
> > The other part this adds is making the world build use "/tmp/world" as
> > the output directory not "/tmp" so that we can then delete "/tmp/world"
> > afterwards. This adds between 1m30 and 3m to the build.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  .gitlab-ci.yml | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 2dbe6325f334..ce7a391bbd00 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -63,8 +63,9 @@ stages:
> >          -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requi=
rements.txt
> >
> >    after_script:
> > +    - git clean -dfx
> >      - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
> > -    - rm -rf /tmp/uboot-test-hooks /tmp/venv
> > +    - rm -rf /tmp/uboot-test-hooks /tmp/venv /tmp/${TEST_PY_BD}
>=20
> This deletes less?

No? Note that we're adding the "git clean -dfx" and that must be before
we copy the files grabbed as artifacts in.

> >    script:
> >      # If we've been asked to use clang only do one configuration.
> >      - export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/${TEST_PY_BD}
> > @@ -130,11 +131,13 @@ build all platforms in a single job:
> >          -r tools/buildman/requirements.txt
> >      - ret=3D0;
> >        git config --global --add safe.directory "${CI_PROJECT_DIR}";
> > -      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=3D$?;
> > +      ./tools/buildman/buildman -o /tmp/world -PEWM -x xtensa || ret=
=3D$?;
>=20
> Since you are making the tmp-> /tmp/world it might make more sense to
> define a variable for the output directory.

OK.

> >        if [[ $ret -ne 0 ]]; then
> > -        ./tools/buildman/buildman -o /tmp -seP;
> > +        ./tools/buildman/buildman -o /tmp/world -seP;
> >          exit $ret;
> >        fi;
> [...]
>=20
> Other than that I think it looks sane. The added 1 - 3 min build time
> is small enough to ignore

I'm ambivalent about it, and since Simon is most concerned with overall
pipeline time I'd like his input here too.

--=20
Tom

--wJiz2r09PVewN6Gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYl1cACgkQFHw5/5Y0
tyxLxgwAkHjlyML6yybqVhb0ugBKuycs1y2tpklpZHFujQO9Vl7xFL3m1+EchtV9
bQk1vwxzvlJUu5GobqxGwB4fFB56cvkhWqkvvtTlNKsHO/08uxuTEpVRzZAI4vWa
mvBbNoZ4XDvR3E7zMUWvH6euPbZmzMgqbX2qwd5/bXnhi4JXYCmwVU+LZ0FVyNHM
S2xipqm0AfHBmc309X/OstbMj4VHERs5VuyCrBw1KakBjKNysxv7qofVPSqMI0ZS
vw8m/7prFxMyAU5NE5sX+ILpkHWwRepEoLqpEITrP+M0s907LK6nbWrborRFYMkj
4Um7z+ubP0Iwmxp0y43bZ7VkBxWWHlvNa76ACc92M3gIqsz+NjtM/m1tBGcQwwdO
kNSviVywJJWPWMoF7c0V5WprDk25kcKj21sCHQ5kVkQg6XV1eOYy7Tb3Q1aVkbFL
L7YlAufw1C/tGvSnNN//rp02dncZyAxgJjZ9ugjhkbwuixVgrMcHtcFJP12e8xFa
8KjLcu25
=seOy
-----END PGP SIGNATURE-----

--wJiz2r09PVewN6Gh--
