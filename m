Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960C4C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9CE889A6;
	Thu, 25 Jul 2024 00:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dGZzUTSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8E5889AF; Thu, 25 Jul 2024 00:42:50 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27AA68899C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-260f863108fso141887fac.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721860967; x=1722465767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C/IfTf1AUOPLPIf23ff2ZrcG8YgYo2uMqoUVyknN6Mc=;
 b=dGZzUTSuocRPEcdhiA7FSf8eLxUyzhvCijK9kkG6CgNTvp4fv2ZB18YzGlFZY067Jy
 238dLrUACwyAGATXPDovkVc8jkHgf0qtABEjQMVmj+xUrChLFCrPIQqE+Oxo5ZpfA8qF
 C3/Ut/Y8Up3YAUggnus2b0LeoNbPIqYuhRPyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721860967; x=1722465767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/IfTf1AUOPLPIf23ff2ZrcG8YgYo2uMqoUVyknN6Mc=;
 b=SD9+9C+F0RQeAGSK68MWnmqDGR4hm7HNIlqFxZ6KBOgQDXdmNdOaKzyleOxKNXCE8w
 9r649UpHawiBcyzfz1lgbBs6R72YPm3Pdijmi5wvyPFBD5C0iVGOe++45f8nrK00C+dM
 x4SRZasxdmjE3sB+oOV8Tn5UCbIUNT1i80dwqCN4i3u5lSBYpzcVW34gTjbznCqvpXmp
 kFA8JZmE7Sufd0ObV20AgtJxkwfqH2xS9hJGLHxIo2bHN8dk7t3QDaa8zTcenUTCNXF8
 2FhnUhL3NWWVZysjQ37V+cEwLCIAeo67KoXzA9FE7CWOeJ/lZRKadvQFWt/ZV9uOKSvP
 L28w==
X-Gm-Message-State: AOJu0YzycA3vPELlWGePuvmfBjx2OFzkFAyn8MrmX5CTBheQavpr58G4
 mZisKhYgpB6Tqbrv5KoXhFUk/PZNEoa5LPPQdbIQduFFC3t3vhbc8yHNxvk3qxQ=
X-Google-Smtp-Source: AGHT+IG1TNDyNITP2Hd2ZE11cvbaXJjdNOt4ySNr8MFgE1B6Nm9Ugu87TnbSYvoq7eHXJqAfTAO2uw==
X-Received: by 2002:a05:6871:2001:b0:25e:5ff:758b with SMTP id
 586e51a60fabf-264a0ba5543mr1332821fac.4.1721860966763; 
 Wed, 24 Jul 2024 15:42:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e756092sm60557fac.22.2024.07.24.15.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:42:45 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240724224242.GQ989285@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
 <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UcqB2HZUiV3dM1zB"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
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


--UcqB2HZUiV3dM1zB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:34:50AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
> >
> > > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> > >
> > > Motivations:
> > > ------------
> > >
> > > 1. MbedTLS is well maintained with LTS versions.
> > > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > 3. MbedTLS recently switched license back to GPLv2.
> > >
> > > Prerequisite:
> > > -------------
> > >
> > > This patch series requires mbedtls git repo to be added as a
> > > subtree to the main U-Boot repo via:
> > >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > >           https://github.com/Mbed-TLS/mbedtls.git \
> > >           v3.6.0 --squash
> > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > we need to convert the CRLF endings to LF and do a commit manually:
> > >     $ git add --renormalize .
> > >     $ git commit
> > >
> > > New Kconfig options:
> > > --------------------
> > >
> > > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> > with
> > > MbedTLS.
> > > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN=
1,
> > > and Pubkey parser with MbedTLS.
> > > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTL=
S is
> > > ready).
> > > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto libr=
ary.
> > > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTL=
S`
> > > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > > introduced.
> > >
> > > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X5=
09
> > > are by default enabled in qemu_arm64_defconfig for testing purpose.
> > >
> > > Patches for external MbedTLS project:
> > > -------------------------------------
> > >
> > > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > > executables which is not supported by MbedTLS at the moment,
> > > addtional patches for MbedTLS are created to adapt with the EFI loade=
r:
> > > 1. Decoding of Microsoft Authentication Code.
> > > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > certificates.
> > > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > >
> > > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > > MbedTLS project and being reviewed, eventually they should be part of
> > > MbedTLS LTS release.
> > > But before that, please merge them into U-Boot, otherwise the building
> > > will be broken when MBEDTLS_LIB_X509 is enabled.
> > >
> > > See below PR link for the reference:
> > > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > >
> > > Miscellaneous:
> > > --------------
> > >
> > > Optimized MbedTLS library size by tailoring the config file
> > > and disabling all unnecessary features for EFI loader.
> > > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha=
256,
> > > sha512) are completely replaced when MbedTLS is enabled.
> > > From v3, the size-growth is slightly reduced by refactoring Hash
> > functions.
> > >
> > > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > v1: 6.03%
> > > v2: 4.66%
> > > v3 & v4: 4.55%
> > >
> > > Please see the latest output of bloat-o-meter for the reference of the
> > > size-growth on QEMU arm64 target [1].
> > >
> > > Tests done:
> > > -----------
> > >
> > > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> > image
> > > verifying and booting) via U-Boot console.
> > > EFI Secure Boot and Capsule sandbox test passed.
> > >
> > > Known issues:
> > > -------------
> > >
> > > None.
> > >
> > > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU ar=
m64)
> > > ```
> > > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
> >
> > bloat-o-meter is a bit off then, since buildman shows:
> > u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
> >
> > (Please use buildman for the size comparisons in the future).
> >
> > The reason that buildman is showing more growth is because I enable
> "CONFIG_EFI_SECURE_BOOT=3Dy" in my patch, which is off by default
> for qemu_arm64.
> Since the buildman is always comparing one local branch with the
> 'upstream' (I didn't find a way to let it compare two local branches or
> maybe
> I am wrong), I guess I have to first merge one commit with just enabling
> CONFIG_EFI_SECURE_BOOT to solve this. But I get this makes less
> value...
>=20
> I think it is better to use sandbox for comparison from v5,
> and I will add one more platform (e.g. imx8mp) for reference.

Please note that I check the world before/after, not just single
platforms, for size growth. I'll note some examples of issues when I
find them, typically. And with the wrapper I posted, sometimes I will
"--all" a platform to see which commit increases things.

--=20
Tom

--UcqB2HZUiV3dM1zB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahg2IACgkQFHw5/5Y0
tyzvvgv/T8Btsf5TMcElHo0mYc3Vw4EY3pXO+X2MR0lWG+CBKFV1U6o6jdkLku60
NMPN4Zl4xfcQglJELV1vAFRojNBF74rs+oXeqnol+3XWjFVmEmxbVqp0e9BjRakl
u6EtVQQ+ua3YIAnK/NZaI6g8fvOkqaw+6dTTbKrVAChhH8guwMs6Q2Gktt/1L5ah
IBEu870EVVLuN2R/4ALzr2b/MZ9WWpYTlrz9JJbsXPzn6o9HxDgGq52kunJwpp/H
Y6hGcRYfXq8O2okjZ2bnlYWD1wt7eYET6Zw/0DCnuzbIg21TMf2C/JlV8A0/Dj6/
Nh/0DCrbwNIP+jnsig1fD+dArlwQwK0Ee46E4SyNT5YO6TrCfq4V9CiFICPxt/D2
x+j6WWAXb5z+53YDWNWwBuVI2rtkdbCq60KmOADMyAaLiubtI6bNqvFYtxIr0bw7
F8kcoDez3eKxVEpBBYUp18IAukCnaStj/B4FmQemhRtB/EwvOnJG5KOEhuwDXq9R
EdvNw2Oz
=m3vy
-----END PGP SIGNATURE-----

--UcqB2HZUiV3dM1zB--
