Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB9BC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 17:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4604080AE1;
	Fri, 28 Feb 2025 18:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SEJ+Ssr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A31780FF2; Fri, 28 Feb 2025 18:55:12 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E443E809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 18:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-221206dbd7eso53828675ad.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740765292; x=1741370092; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L9kDISGlxwXyi8IM2fYWT6Den3GZR5U10zUDi5VnC88=;
 b=SEJ+Ssr0uO/V1cYPCMPWkL7uepidmDIBFS2QAa1kpMwGSKhjVW8ILt5kjv3diMOM5R
 NBh608XX909uefe7xnseFNxd7o4lnk3B5gWPpQJdaXIdJihTI6X1KaA0fTeNk3izBTO6
 GQQtvxaP1PlzU5p8hPNAO/5+s2+WeDRCm9PT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740765292; x=1741370092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9kDISGlxwXyi8IM2fYWT6Den3GZR5U10zUDi5VnC88=;
 b=g52xvFFBjB6/6VMyhbOGcmgu8x+l2+dEh++6faB9NRTzocyHiIf0+2gAUf1QOHRYzh
 8MajTmvCVcph37Fj9tkBYxycc6xF253/NNl8Z0DtyHM2vDPGOswOEFHoA97RU1E7mB/H
 x364/G1FlBnztgLISrYpbMpbjvlxbcF739dwwkGC3lu60nCjNX8Bm1cYy9nH0l0X5k9/
 Gh0YhIod+LyK+G2pNX27r4vnba5/ny4wrs38Y2l4j/VuYLoc7fukHCFDHoiIFXo91xsM
 4CjO/M9w+cFPR0u/XXz84KW6rWqLGsCrOXzsXCSK59a03/Ca6G3E409lxZQC+FL894iB
 RlOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYBfGnfZ83w1Tdmat0KY/9+6QsIjDokdrlrLiRq9SeBuvac1LEOKQ8oF7TDIc6bQXFSrITVKA=@lists.denx.de
X-Gm-Message-State: AOJu0YzAA834HLm73SmtwVoELTyljsWCHxtf4MOKbNf19dcdt2YV5LUL
 OZUm5wtTxVb8TG6UhoWXr049VSFRalHzTdYGb7qCzIUDIVW/lyKZA24EG9b3SWs=
X-Gm-Gg: ASbGncuHw37F4fscJc0BgXwhLzASkziUE9rpmvpAOCmvuubd6rbhlE89+yiVySX7bEV
 zAkkxqXQza0Ex4NS1tOiGJrmDjUqRV93kc3KEQxhjX891xS7L7yL7lVjaPq/bm9mf0XoZzjMV1P
 8B93ZwD5I31LfV4IzYU4dyr8/PZymRojCwRkvoEgxCs10coXLf7H6FSaMKyDewbBDC1MkoDcjmK
 Axvh4t2I7drrI9RGmdm9fA7QNWCOEqStSNh9+ANcFrQSR5iRoqyogCoSEdXbbIZN/xUqqR8+iBp
 HO2VvTmDkuNYMMCZMf1rDpa6080RLUgYtItmWEuWHeg=
X-Google-Smtp-Source: AGHT+IEGCR2m7RJ1A0t0r0aiMhgovTFWTaPAIyU86VBUA4tP5KC1bIHFybojcXqtKaO8SZbuBeDS9w==
X-Received: by 2002:a05:6a00:2ea9:b0:732:24ad:8e08 with SMTP id
 d2e1a72fcca58-734ac360e71mr6959149b3a.1.1740765291772; 
 Fri, 28 Feb 2025 09:54:51 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003eb65sm4173684b3a.149.2025.02.28.09.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:54:51 -0800 (PST)
Date: Fri, 28 Feb 2025 11:54:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 02/14] arm: add initjmp()
Message-ID: <20250228175448.GN2640854@bill-the-cat>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
 <2a3e72c0-30d3-4f52-84c2-81d34b2a4286@gmx.de>
 <911a467a-3dbb-4a12-aa49-2aaef2094011@linaro.org>
 <0cd2dd22-e653-481d-b9b7-fafa91059e47@gmx.de>
 <c7961116-77b7-4db1-91ea-6e47f11d183c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="spe4umijqi1Y0P2J"
Content-Disposition: inline
In-Reply-To: <c7961116-77b7-4db1-91ea-6e47f11d183c@linaro.org>
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


--spe4umijqi1Y0P2J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 03:16:37PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 2/28/25 14:28, Heinrich Schuchardt wrote:
> > On 28.02.25 14:21, Jerome Forissier wrote:
> >>
> >>
> >> On 2/28/25 14:05, Heinrich Schuchardt wrote:
> >>> On 25.02.25 17:34, Jerome Forissier wrote:
> >>>> Implement initjmp() for Arm.
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> ---
> >>>> =A0=A0 arch/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 1 +
> >>>> =A0=A0 arch/arm/include/asm/setjmp.h |=A0 1 +
> >>>> =A0=A0 arch/arm/lib/setjmp.S=A0=A0=A0=A0=A0=A0=A0=A0 | 11 +++++++++++
> >>>> =A0=A0 arch/arm/lib/setjmp_aarch64.S |=A0 9 +++++++++
> >>>> =A0=A0 4 files changed, 22 insertions(+)
> >>>>
> >>>> diff --git a/arch/Kconfig b/arch/Kconfig
> >>>> index 8d5b54031b3..57695fada8d 100644
> >>>> --- a/arch/Kconfig
> >>>> +++ b/arch/Kconfig
> >>>> @@ -94,6 +94,7 @@ config ARC
> >>>> =A0=A0 config ARM
> >>>> =A0=A0=A0=A0=A0=A0 bool "ARM architecture"
> >>>> =A0=A0=A0=A0=A0=A0 select HAVE_SETJMP
> >>>> +=A0=A0=A0 select HAVE_INITJMP
> >>>> =A0=A0=A0=A0=A0=A0 select ARCH_SUPPORTS_LTO
> >>>> =A0=A0=A0=A0=A0=A0 select CREATE_ARCH_SYMLINK
> >>>> =A0=A0=A0=A0=A0=A0 select HAVE_PRIVATE_LIBGCC if !ARM64
> >>>> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/se=
tjmp.h
> >>>> index 662bec86321..1ad5b500f2a 100644
> >>>> --- a/arch/arm/include/asm/setjmp.h
> >>>> +++ b/arch/arm/include/asm/setjmp.h
> >>>> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
> >>>>
> >>>> =A0=A0 int setjmp(jmp_buf jmp);
> >>>> =A0=A0 void longjmp(jmp_buf jmp, int ret);
> >>>> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack=
_top);
> >>>
> >>> As this is not a standard function we cannot expect developers to know
> >>> what it does and how to use it.
> >>>
> >>> Please, provide Sphinx style documentation with the necessary informa=
tion.
> >>
> >> I agree on principle, but if I add documentation here then I should ad=
d the
> >> same for all architectures. That being said the prototypes are already
> >> duplicated so maybe consolidation is a question for another time.=A0 I=
 will
> >> add Shpinx style doc to all 3 commits "{arm,riscv,sandbox}: add initjm=
p()".
> >=20
> > Yes, this was not designed correctly:
> >=20
> > We should move setjmp.h to include/asm-generic and include an
> > architecture specific setjmp_bits.h from there.
> >=20
> > setjmp_bits.h would provide the struct jmp_buf_data definition.
>=20
> Makes sense. I'll rework in v3.
>=20
> >=20
> >>
> >> As for usage, I think the best documentation is test/lib/initjmp.c add=
ed
> >> by "test: lib: add initjmp() test".
> >=20
> > Example code is valuable but does not replace documentation.
>=20
> Should I provide a stripped-down example in the Sphinx doc? Or do you have
> another location in mind? (doc/develop/initjmp.rst?).

We should have doc/api/initjmp.rst and if test/lib/initjmp.c is
commented correctly / well enough it can be referenced in the rST via
'.. kernel-doc::test/lib/initjmp.c' I think.

--=20
Tom

--spe4umijqi1Y0P2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfB+F0ACgkQFHw5/5Y0
tyzrzwv+I+gdFwLs9P1ZLuYdVPxr+xeb1WaiYt+JVQasIlREkz6JbtLwNcWZZA7L
hnyUGjiKvJ6l/aY0PqcM8xhtSw7D4w4jktFyDA17AEDf6q9VjwMv84AemHucpDrh
+2UHfMAZK4hT5m6+wBCPAwazM9Jb/9MBVl/6/1yye8D7op6AsgKeErMyAeCHMT/k
6GJFvU1SzaEP6JKy2rKbjwD82QL4v9k7Lxa8hpWC1xEkCtmvBdsB/dbhDV65vGIi
u9EkrpN3bxYx8DjUpoH2Xt0d2/frks8SJWwVqFhekBUMQ2kwo+mt3BaolG8hUsrc
GDA/t2ahXqKenFvuFLjd/cuvrZX3Sfq//BB7wz00Jabq7TpSZ6NUWVoC40PDHeIL
ZCx8h5ieOmOde3tA4vXgYkdgVYCuaWkFU8/Eq/IXtBCT5gdh2lHBDufNwr4o19v6
OpGVwhOX/sCyEnStPTlNv977dXfXx7LsG6I+MTcupCXL2Amb+6kdIYCcaiwQpHki
yeQLI6A5
=kIld
-----END PGP SIGNATURE-----

--spe4umijqi1Y0P2J--
