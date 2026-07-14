Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCD1C44501
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 16:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F58A84D23;
	Tue, 14 Jul 2026 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TUnXzMaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FC584D2A; Tue, 14 Jul 2026 18:46:55 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB8980287
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 18:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-495b250b01cso986307b6e.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784047611; x=1784652411; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BUDodNnHtInbFfrCEM2q5DOugitqCFxYKBiALDBNG7o=;
 b=TUnXzMaRWzLP8CKPlUIp/Qtz2y56uaW8zK3L+AqZqKoTcNawF4YtCgem37Mnt3Gtn1
 QHGizu4RWefSGjp+U6z5bRoeby68Wjh1x81kkGCFM6LenW33jbDSS555yaptcRvL03KD
 H3jFF2CJIrWAlcptMTUhvf8nf9ruzOgL1cuMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784047611; x=1784652411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BUDodNnHtInbFfrCEM2q5DOugitqCFxYKBiALDBNG7o=;
 b=BGlC98T/ofmYRgAqWuxP65g/YrGbfA7n//nv991t4ePHpn03jGETWKt0iEDgPbapj3
 9/hY9Z2mllRXn9rcI6fFCMrlTuA1rBFikc7ItIe5PKx/OMQ2R40cus2IG4RQviHhU8yS
 pUjPYDPZlt7bHNXNDXSoTzkMkHZv5DpT9jvxvg25LhTtNPUNaZzQUm7eOZY+rHCTMWIx
 q4qgVKmVsEJWzUFJ5xh0EeB8Tuba3vlqBfIbyaolhkd2z2OSE7XUW7I2/KGJUC1yiyrv
 UmRXJxBfOC1KHb8GUiAEcxtZO6iHVWqXlRBCZtCnX6oZOesYa+dOlGG5vjcsodldWU4f
 CDyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2DpdgangXXznH3lpH2p5u32KE45bYdwa1WJSmO5MJ/d88iJK6hK1uOSv/41qSe6s6vbcBIFk=@lists.denx.de
X-Gm-Message-State: AOJu0YxzCy3SIXhX9WJmMYjrcK9/oR8GM3tvZnPjTFFQh155NCb/1uwu
 pXH56Sl6psr5vcqtsT8Z9EEQOyefw0ehpDycxZNg1lzIi4YGyCCp0JDQ1VilkWBlA4A=
X-Gm-Gg: AfdE7cldnjOYQEzupIVpbAuwaA3KqEekhgHJlEADjuw5AmvYsxtQlNccp/DWJO9+5Y4
 gpP3BeSCTsDsyGrjilNGLgYY4W21fuH7SzWjXvIW3qsRVCj/vjuFOYogPUYOLrGxrPZzX1qKA0d
 x1KJk8MWgaaX+Rbiau9VrnkCZwtcJNhzZbbkQrN0t2cf461XPD6cCfX6SNhVUw0jMSbB+HbkA1n
 hpOvNAxdUV8v9jcMjZj4u3UCRvFGCyotPT7xDoVBnu0U192wFhlAGy3/ApGPLi3Lq1qLFFObP1K
 l0EWJUvt5CD9H1J1pQMsO6dCkqj8eK9LCripFYiePZJ/0ENyD0LxfJm9TFJZRtTo2SVipnuNgKP
 4IzB5kwFrakEZiDfITyib/t7eqB+56K6NT70KeEgTcPFN+N+VEkYB/esnANOS/HFp8WLMn2qyuA
 0fZvbR2cjsXjzpsgwFv/jgq9AVmn+VO/e5KFBE4GVBrHC8vMVir/PbbDjSrB7XLvxyviLOmkd9y
 zGNq6Q5NuqBZY6bUJLuipG4fgA+21+cmGsszQ==
X-Received: by 2002:a05:6808:4701:b0:48b:17c4:3572 with SMTP id
 5614622812f47-4a42affd81bmr10879016b6e.29.1784047611160; 
 Tue, 14 Jul 2026 09:46:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm14854906b6e.1.2026.07.14.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:46:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:46:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] test: fit: verify dm-verity roothash is covered by
 the config signature
Message-ID: <20260714164647.GA749385@bill-the-cat>
References: <cover.1783816074.git.daniel@makrotopia.org>
 <4adbf45f0d33802ebd2afd627f639e47c6609e17.1783816074.git.daniel@makrotopia.org>
 <20260713220842.GY749385@bill-the-cat>
 <CAFLszTjfcmPuUnmVg60pVzsnzSm0kPn3zLL7GMkCTpUyHCQUZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6tcIRrFuMKSrlbXK"
Content-Disposition: inline
In-Reply-To: <CAFLszTjfcmPuUnmVg60pVzsnzSm0kPn3zLL7GMkCTpUyHCQUZw@mail.gmail.com>
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


--6tcIRrFuMKSrlbXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 06:17:11AM -0600, Simon Glass wrote:
> Hi Daniel,
>=20
> On 2026-07-12T00:33:05, Daniel Golle <daniel@makrotopia.org> wrote:
> > test: fit: verify dm-verity roothash is covered by the config signature
> >
> > A dm-verity protected filesystem image is not hashed by U-Boot; its
> > integrity is delegated to the kernel, which trusts the roothash taken
> > from the FIT dm-verity subnode. For that chain of trust to hold, the
> > roothash (and salt) must be part of the region covered by the
> > configuration signature, otherwise an attacker can replace both the
> > filesystem and the roothash while keeping the signature valid.
> >
> > Add two independent checks of this property:
> >
> >  - test/py/tests/test_fit_verity_sign.py signs a configuration that
> >    references a filesystem image carrying a dm-verity subnode, then
> >    confirms that tampering the roothash or the salt is rejected by
> >    fit_check_sign. A control that tampers a byte known to be signed
> >    proves the check can fail.
> >
> >  - test/boot/fit_verity.c gains a runtime unit test that builds the
> >    exact node list the configuration signature is computed over,
> >    turns it into hashed regions and checks both that the roothash
> > [...]
> >
> > boot/image-fit-sig.c                  |  25 +++--
> >  include/image.h                       |  25 +++++
> >  test/boot/fit_verity.c                | 194 ++++++++++++++++++++++++++=
++++++++
> >  test/py/tests/test_fit_verity_sign.py | 162 ++++++++++++++++++++++++++=
++
> >  4 files changed, 399 insertions(+), 7 deletions(-)
>=20
> Somehow I didn't get this email, but I'll try to reply here.
>=20
> > diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> > @@ -340,8 +340,19 @@ static int fit_config_add_hash(const void *fit, in=
t image_noffset,
> > +#if CONFIG_IS_ENABLED(UNIT_TEST)
> > +#define VISIBLE_IF_UT
> > +#else
> > +#define VISIBLE_IF_UT static
> > +#endif
>=20
> Tom commented on this, but I'll just add this. Linux has
> VISIBLE_IF_KUNIT but in U-Boot so far we just stop the static when the
> function is needed elsewhere. LTO can be used to avoid the code-size
> increase, for platforms that want it.

As part of why this should be its own discussion, a quick look at
VISIBLE_IF_KUNIT in the kernel leads me to think it's not quite the same
set of needs, or if so there's a lot more architectural enforcement
around what is/isn't exposed just for testing, which we lack today.
Talking about LTO isn't relevant here.

--=20
Tom

--6tcIRrFuMKSrlbXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalZn8QAKCRAr4qD1Cr/k
CmB9AP9AuQivI7nTntuxBwb/2C9YjuaeBjX9g1pdBSHaWWrQOwEA0Q/bnsFwfJ7F
PilbWQOte98BIQk9I9esLYjJffq9BAU=
=+Nyt
-----END PGP SIGNATURE-----

--6tcIRrFuMKSrlbXK--
