Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351A0E6FE2B
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 15:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9986888CC8;
	Fri,  6 Sep 2024 17:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BEqhaD1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F8788CE5; Fri,  6 Sep 2024 17:27:34 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DE188BD6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5df96759e37so1322586eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725636450; x=1726241250; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T+KY9ImbGmCvyACXg7+gQdlc2wPkGJIzwSCJiUG2CIE=;
 b=BEqhaD1aFLNEWkqYyYCFHcqYa0tyJcRwIaARFGNf7IXjZswtSGKV2xXCgGJ3AUWmvm
 zx2wk2FEd17m1c7MIgsEpuN7yULkQIdLXerEJzQn4AE1GdV+GBF28pS7Cgj4sYR1Aiw6
 7/a55sAncmscWiLjqgSMgoUm172wbhZlIoTAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636450; x=1726241250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+KY9ImbGmCvyACXg7+gQdlc2wPkGJIzwSCJiUG2CIE=;
 b=JcSWSI3jVE1VVG9qA5BPyrFkAZMNhnFxNlPFkfTXOh9wNKtusmhxkrNg7WK/+VRcMu
 C7on8MIJtwtL1eEyd6glh6Ry+a6j5Bo/xewcwvDLBKmMTrAfxiUc5LbpLSo9BvljCbHa
 vBmAls+Y+djJ6mOU1wGsCYUmJMvZoA2uWo5MkihGFXaWGr35iRseY4jn2KaN3haNn9UN
 V4cTv1C0+c5dO/wsRkciCOomLpCeyq72e+VxmlFK+KHNGA6aUvuddWugFtDPYwmY0HEW
 gWFqiOu7C/HnKwDyrw8C30bYfMjUgqhfqLXxdtqJdoOIodjykqwdyO0QFpfcj1/4H4G3
 Wt4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZwCHnNQaMBHMEXZm/FbQNv5VPMjyyuff2uv6EKFUhKxcGCf3ixBuoikIPwvieYH92rQV3EqE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy848DSAGkLRCQM8Kkfc6G6ClCHG6FYw6qp2xEbKHSWX/VYYuKD
 5qHuCdTZ7bwuvbAVmrZ/80+WLv1mYB2jM41CV6yRNs2aBf7FjCr9Fdexo9yDbUw=
X-Google-Smtp-Source: AGHT+IF+/dxavEQvLQ9aQL3f+ObAad1zi18NmFbfF/Ugxdt/25WJgQla1dOIGsrCbbJ+0IPa+mxs3Q==
X-Received: by 2002:a05:6871:6ab:b0:27b:583b:bfa8 with SMTP id
 586e51a60fabf-27b583bc699mr9169475fac.17.1725636450166; 
 Fri, 06 Sep 2024 08:27:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a99f3c8212sm28042885a.8.2024.09.06.08.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 08:27:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:27:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240906152724.GB3879073@bill-the-cat>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
 <CAFLszTh56FrvLaHvat6Oz97EVzw9xYmQr+WyDNtYE=c2qmyJ5w@mail.gmail.com>
 <CAEfUkU+iXQVBTmTc3A4HUEFdm2NapoqzQefOamczRkkhPsa0Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5UVBFdY2U8OFfEK+"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+iXQVBTmTc3A4HUEFdm2NapoqzQefOamczRkkhPsa0Bw@mail.gmail.com>
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


--5UVBFdY2U8OFfEK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 10:50:15AM -0400, Raymond Mao wrote:
> Hi Simon,
>=20
> On Thu, 5 Sept 2024 at 20:43, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Raymond,
> >
> > On Tue, 3 Sept 2024 at 08:59, Raymond Mao <raymond.mao@linaro.org> wrot=
e:
> > >
> > > Hi Simon,
> > >
> > > On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> Hi Raymond,
> > >>
> > >> On Fri, 16 Aug 2024 at 15:44, Raymond Mao <raymond.mao@linaro.org>
> > wrote:
> > >> >
> > >> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> > >> >
> > >> > Motivations:
> > >> > ------------
> > >> >
> > >> > 1. MbedTLS is well maintained with LTS versions.
> > >> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > >> > 3. MbedTLS recently switched license back to GPLv2.
> > >> >
> > >> > Prerequisite:
> > >> > -------------
> > >> >
> > >> > This patch series requires mbedtls git repo to be added as a
> > >> > subtree to the main U-Boot repo via:
> > >> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > >> >           https://github.com/Mbed-TLS/mbedtls.git \
> > >> >           v3.6.0 --squash
> > >> > Moreover, due to the Windows-style files from mbedtls git repo,
> > >> > we need to convert the CRLF endings to LF and do a commit manually:
> > >> >     $ git add --renormalize .
> > >> >     $ git commit
> > >> >
> > >> > New Kconfig options:
> > >> > --------------------
> > >> >
> > >> > `MBEDTLS_LIB` is for MbedTLS general switch.
> > >> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto l=
ibs
> > with
> > >> > MbedTLS.
> > >> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode,
> > ASN1,
> > >> > and Pubkey parser with MbedTLS.
> > >> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> > library.
> > >> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > >> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalitie=
s.
> > >> > For each of the algorithm, a pair of `<alg>_LEGACY` and
> > `<alg>_MBEDTLS`
> > >> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options =
are
> > >> > introduced.
> > >> >
> > >> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and
> > MBEDTLS_LIB_X509
> > >> > are by default enabled in qemu_arm64_defconfig and sandbox_defconf=
ig
> > >> > for testing purpose.
> > >> >
> > >> > Patches for external MbedTLS project:
> > >> > -------------------------------------
> > >> >
> > >> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > >> > executables which is not supported by MbedTLS at the moment,
> > >> > addtional patches for MbedTLS are created to adapt with the EFI
> > loader:
> > >> > 1. Decoding of Microsoft Authentication Code.
> > >> > 2. Decoding of PKCS#9 Authenticate Attributes.
> > >> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > certificates.
> > >> > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > >> >
> > >> > All above 4 patches (tagged with `mbedtls/external`) are submitted=
 to
> > >> > MbedTLS project and being reviewed, eventually they should be part=
 of
> > >> > MbedTLS LTS release.
> > >> > But before that, please merge them into U-Boot, otherwise the buil=
ding
> > >> > will be broken when MBEDTLS_LIB_X509 is enabled.
> > >> >
> > >> > See below PR link for the reference:
> > >> > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > >> >
> > >> > Miscellaneous:
> > >> > --------------
> > >> >
> > >> > Optimized MbedTLS library size by tailoring the config file
> > >> > and disabling all unnecessary features for EFI loader.
> > >> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> > sha256,
> > >> > sha512) are completely replaced when MbedTLS is enabled.
> > >> > From v3, the size-growth is slightly reduced by refactoring Hash
> > functions.
> > >> > From v6, smaller implementations for SHA256 and SHA512 are enabled=
 and
> > >> > target size reduce significantly.
> > >> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > >> > v1: 6.03%
> > >> > v2: 4.66%
> > >> > v3 - v5: 4.55%
> > >> > v6: 2.90%
> > >> >
> > >> > Please see the latest output from buildman for size-growth on QEMU
> > arm64,
> > >> > Sandbox and Nanopi A64. [1]
> > >> >
> > >> > Tests done:
> > >> > -----------
> > >> >
> > >> > EFI Secure Boot test (EFI variables loading and verifying, EFI sig=
ned
> > image
> > >> > verifying and booting) via U-Boot console.
> > >> > EFI Secure Boot and Capsule sandbox test passed.
> > >> >
> > >> > Known issues:
> > >> > -------------
> > >> >
> > >> > None.
> > >>
> > >> I wonder if we could leave out the SHA stuff? The algorithms are
> > >> stable and this would seem to avoid much of the size growth, and all
> > >> the pain of trying to integrate another yet another hashing layer (we
> > >> already have normal, progressive and h/w acceleration, plus
> > >> UCLASS_HASH which h/w acceleration should use but that migration nev=
er
> > >> happened). I struggle to see any benefit in replacing U-Boot's very
> > >> solid hashing infra with something else, particularly as this series
> > >> adds yet another. Better to invest the time to refactor it. I asked
> > >> about this before and was told that it would happen 'later'. Let's
> > >> just not change it at all, then it is more likely someone will sort =
it
> > >> out.
> > >>
> > > Unfortunately, MbedTLS depends on its own digest layer. Unless we pat=
ch
> > MbedTLS
> > > to allow an external digest library from U-Boot ...
> >
> > Yes that sounds best. It looks like only a few call sites, so it
> > should be a matter of leaving out the MbedTLS code and adding some
> > static inlines.
> >
> Inspired by Ilias's reply to patch #7, though we can use the MbedTLS hash
> alternative options,
> we still need to convert all U-Boot hash APIs to adapt to the MbedTLS sty=
le.
> This will impact all callers in U-Boot and I don't think it worth to do, =
at
> least now.
> As the first patch set to introduce MbedTLS to U-Boot with turning on all
> necessary features,
> I think this patch set is in the best way with an overall consideration.

To this point, you could just create wrappers? And perhaps mark those as
inline, if they're small enough?

--=20
Tom

--5UVBFdY2U8OFfEK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbH1wACgkQFHw5/5Y0
tyxjKQv/aAGci4E5oJnITNccDig0rO3kO2ba+Yr1O1CUTUbMuXXHh/e3wrAW195E
bwQjL/FkSV+YK8PNkt/iGJSHYY2B+GbU8ZEfAAofuY31uez/6uR5vSTBIWEnGRCT
3X+izutygYE8rX6GAR9WowunHIrhylYJzk3qyBOpvy3PKVrKznd30VYRBKULCzNq
6f4stZr39A+ljOVdmGQ+eNuoKRELcxXH59tVJgQJjKox0k1eZXha3wYRM+OeBrcX
quF6cwSfJE2F3Eav1KcSY4WP8LYUxTk07OfLBFYyRiu7QrqeMkT+1CZFwBScDbps
YczLDjxu0v+LFwclzP2CEVyto4ZdNxj1/8WHCZ3vN6eOtY4oVspDGzeX3dkTp8E4
lcFodfkBdOvJE1rwAGV7BVxqHDw0N5zioCT06dFl9BFuQGp55rxd9D7Zf2uH9Irw
D9rMMJ7thPZ4IE5oK5dDTLJ7YMb2j9KhpwUAzpLjApDhx6fNx1w8yiEv6U91gc2y
/4Z8cUc0
=nmhM
-----END PGP SIGNATURE-----

--5UVBFdY2U8OFfEK+--
