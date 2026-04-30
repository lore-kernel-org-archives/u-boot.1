Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A1ECD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 18:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A188E803C6;
	Thu, 30 Apr 2026 20:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="jhL4uFUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F3480F0E; Thu, 30 Apr 2026 20:24:22 +0200 (CEST)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E98480086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 20:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12c726ef332so2007962c88.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573456; cv=none;
 d=google.com; s=arc-20240605;
 b=N8cHx2XrD3bvYbn5v9tC5+3h+D5M6oUII/5I0GGt9SEHkJgFBlOw2RNfxjni9jCkAF
 8TLPFV4zplxAgJq15aHGoKNE7DLpdIq+uZK58ls6yTlwedNH5I1uPz8iPhmTEV+6FhIf
 khTJ7fmNs//oluHuzdjRS3VARjCzsVtvI2RfwEKP+DLFjd+wC07ispAPUOKPGdOPYeDF
 nwYOpJdskIdho0ClmzWmAgm7+taVe0nE2lYuk8Ss71gWC1Mbdyxpa4oaxYNxNixnHTkn
 2HK1Bm4y5YSDa/xlkiBPe+L6+mxeDx7BXs3zJl42Y7y49KUqN5f8ixHTEeo/YejHgyFY
 6J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=65UapUwMYGk+Oz/68K+SevcEU+3672raIp3M558VY7s=;
 fh=B7++efQEoSVFQ9ePsS0QvvXoKtroD+13bBMFR3U3XYY=;
 b=h2xGSY4uLXu5MR+DSYZWnxYg+EfRAPRCuGxLp3nT+6MIui3ecbUmk+XHHaXa1UzitN
 fADGh+8Xdp3OQmfyoQUQiVUNfe3LuOJJoMOzSf3nXV9FJVfpquz0l8sK5Uaaor6uHPOP
 XncOnVVZiylAfBG4mMzNWnHmefaSGDIgj3qVsz5LVXOcd0w/TqOhhTW2IFI8IQLyexUh
 pM40a8YGezgM6ZKJINPYAR9kphwEWTmWaH7eaRFC2eyjEuS3pIsqUGKzrlInzMjVIuwm
 EEeGVNAw6yZJqIC9ZxHXaGGOQKLKUu5N4rKaI5gl1tL+eGcxuhdkM6afO7oB4jUVwlPd
 bCqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777573456; x=1778178256;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=65UapUwMYGk+Oz/68K+SevcEU+3672raIp3M558VY7s=;
 b=jhL4uFUOoTgTmU/Q/HOV0be+q345QMppprXGzceXPuswjrB8fwksvmwOgTaA88OKMp
 n9KjQW0V5a12vpSfEUJsnvbAYh9D9xyaokLx5RBciCcY63ib61Dbac4Q8RbAD5EPVMOG
 Mq/ZL3HYQ+95sFoQdH7ktsF72Sa4C2N41lVkSJBUSAIy4Z9CEPWDOcxBd8Hox0ipdBtX
 y1ee7pa1xHin7XsYDsm3yxYz8RW+NRRlBzyuCHvF83fYVaNmRdtNV/75GcE5q077meNX
 eqLGhsErjZNInO7bXVvh6nuYkn/FORNefIqRI859IFj4roSu1xHmQAyaOY5IKWczkXDm
 G2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573456; x=1778178256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65UapUwMYGk+Oz/68K+SevcEU+3672raIp3M558VY7s=;
 b=OCQnQr5JdA1HIGBA0UH0OXtbwpc3Lkwqr00UjJF7Uy8lggnZxUVu0uIRn4yT8QgY/4
 gHvPBKMLFgP+GBMqraBIufpq3r/5Yaw4vYnTidyKl2uvAGsFL1ZF1bpxvrWV7O70Lobj
 vgb4ZuZeSiSV+WqFEomKa+Q34/C+WSrPdoEBJafnFYxYCpsK52f1UvlECeuE+cUekJNc
 4XFvYvn/Zco+YWP+xHk8CCc51q6sTorn3FKwNvmIXi1qiVTK6X9FNGVrEZoEvzi4hsWd
 /DV71660NVv6Bd3bJORjfho+jVzMP5MCdPUr6WavwcIATXlEZJ/+Jnl45PoMn9kv70kF
 6LEQ==
X-Gm-Message-State: AOJu0Ywt8oFDYqDKc3UbVkICEiL7OZYmBb/VCPJUTTCGlhzT3o2C8jbG
 8d884iglabjY0RAoSpnDVPJqGyCeH6Y2D0SLsCdHOmHIJsmqnRf6cN++rA4krnGSIxCUeD7iSKn
 dqyXMOcQ0QizRRh2mGbQvD8jjtxxKkhl7DvR+xkiOYw==
X-Gm-Gg: AeBDievf8Prjw7QOir3fv/yPtmv11hXCyVe8fVcRJMmVputy8G9c8Q6c8w4NMjRP1BV
 m7ltRFdlOvSyoSmKZChTYs4tsf8CkXxz4zyEJZyA8AOEr3kxWKBdLGbokQMoqGCxN6eidDy2BXk
 TuIk58cqVcJ+9WBxGLncp94tIGtJHQj2M+rD5/u1c8gSsDIHT4732yr5PT/AJ0ZNtw4OalkLbIe
 DMFlxd4wm5Szqa/nsSqlBL5ddFPOa6elhqy6gBmM3xl/s2mirEhdQa3ML5hyajoCUM7ydPUbz+P
 QwNT4/rRZzsielcATEHzXP4mzCqoAlwGyGTH5ToqcbIlyRLUiwI=
X-Received: by 2002:a05:7300:5781:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-2ed3eb67c41mr2349213eec.29.1777573455387; Thu, 30 Apr 2026
 11:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
 <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
In-Reply-To: <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 30 Apr 2026 15:23:58 -0300
X-Gm-Features: AVHnY4K4njr71MRNEYTQvWImC8kyn9SntETRrBMsp3tpmmrmlJhSohyyxAF2q9o
Message-ID: <CANu7NGs0=o5H7o=qwoQj5EYMxDtB7_NTus_-18Q1UZBnk3DiuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin,

On 4/28/26 X:XX PM, Quentin Schulz wrote:

> +BINMAN_PKCS11_MODULE
> +    Path to the PKCS#11 shared library (.so) for HSM signing. When set,
it is
> +    passed as ``-a pkcs11-module=3D<path>`` to binman. Only needed when =
the
> +    module is not already configured via ``openssl.cnf`` or the
> +    ``PKCS11_MODULE_PATH`` environment variable. Typically used together
with
> +    ``BINMAN_PKCS11_URI``::
>
> OK, but why do we want to have this variable for storing the path to the
> module lib instead of using an openssl.cnf?

Agreed. I=E2=80=99ll drop BINMAN_PKCS11_MODULE and rely on external OpenSSL
configuration (openssl.cnf) instead.

> Also, this is stating it's for signing boot artifacts with an HSM, but
> that isn't true. It won't work with FIT images, which use DT properties
> instead (see fit,engine, fit,engine-keydir/key-name-hint.).
>
> I'm assuming it's possible we want different keys for different boot
> artifacts, so this is also a bit too generic of a name?

Good point. I=E2=80=99ll scope this more precisely to X.509 usage. Would
BINMAN_X509_PKCS11_URI be appropriate, or do you have a preferred naming
convention here?

> +# Serializes concurrent PKCS#11 signing operations. SoftHSM2 and many
real
> +# HSMs do not support simultaneous logins from multiple threads, so
binman's
> +# ThreadPoolExecutor would otherwise cause intermittent login failures.
> +_pkcs11_lock =3D threading.Lock()
>
> Is there really no external mechanism to make sure this cannot happen?
> or maybe some sort of session concept?
>
> binman tests will run on multiple processes (see ConcurrentTestSuite)
> when not instructed to run on one thread (via -T 0, used for test
> coverage). My worry is whether this is multiprocess safe (hunch is no).

OK. I=E2=80=99ll investigate whether this can be handled externally (e.g. v=
ia
token/session configuration) or if a more robust approach is needed.

> +    def _pkcs11_use_provider(self):
> +        """Return True if the provider API should be used for PKCS#11
signing.
> +        ...
> +        """
> +        if self._use_provider is None:
> +            out =3D self.run_cmd('list', '-providers') or ''
> +            self._use_provider =3D 'pkcs11' in out
> +        return self._use_provider
>
> Why force the user to use providers if one is available? Can't they use
> an engine even if a pkcs11 provider is available (e.g. you have both
> pkcs11 provider support via softhsm2, but only engine support for your
> HSM). Isn't this something the user can specify via openssl.cnf?

From my testing with SoftHSM2:

- Provider-based flow: configuring openssl.cnf is sufficient. OpenSSL
dispatches "pkcs11:" URIs via the STORE API without additional CLI
arguments.
- Engine-based flow: configuring the engine in openssl.cnf alone is not
sufficient; "-engine pkcs11 -keyform engine" must still be passed
explicitly.

I would be fine with supporting provider-based flows only, as it simplifies
the implementation and covers my use case (OpenEmbedded integration).
However, I=E2=80=99m concerned about compatibility with older distributions=
 where
PKCS#11 provider support may not be available by default. What would you
recommend in this case?

> +    def testOpenSslBuildKeyArgsPem(self):
> +        """Test _build_key_args with a regular PEM key file"""
> +        openssl =3D bintool.Bintool.create('openssl')
>
> Please always check the bintool is present with
self._CheckBintool(bintool)
> such that we can skip tests if it isn't present instead of failing hard
later.

Will do.

> +        PKCS11_MODULE =3D '/usr/lib/pkcs11/libsofthsm2.so'
>
> FYI, the path isn't stable across all distros. Hence why we went for
> checking the path with p11-kit print-config to identify where it's
located.

Understood. I=E2=80=99ll switch to using p11-kit for discovery.

> +        def fake_openssl(self_tool, *args, binary=3DFalse, extra_env=3DN=
one):
> +            if self_tool.name !=3D 'openssl':
> +                return original(self_tool, *args, binary=3Dbinary)
> +            ...
>
> We need to check with a real openssl too, otherwise we just check the
> interface with openssl and not that it is actually doing what's expected.
>
> Why going to such length to avoid actually using openssl?
> Generate/import a certificate in softhsm2 and check that the bintool
> actually returns what's expected?

Agreed. I=E2=80=99ll replace the mocked tests with a real SoftHSM2-based
integration test.

Thanks for the detailed feedback.

Cheers,

Sergio Prado


Em seg., 27 de abr. de 2026 =C3=A0s 07:20, Quentin Schulz <
quentin.schulz@cherry.de> escreveu:
>
> Hi Sergio,
>
> On 4/23/26 5:45 PM, Sergio Prado wrote:
> > Allow X509 certificates used for TI K3 secure boot to be signed via an
> > HSM using the PKCS#11 standard, so that the private key never leaves
> > the hardware token.
> >
> > Two new make variables are introduced:
> >
> >    BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key, e.g.
> >                         pkcs11:token=3Dmytoken;object=3Dmykey;type=3Dpr=
ivate
> >    BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so), e.g.
> >                         /usr/lib/softhsm/libsofthsm2.so
> >
> > When BINMAN_PKCS11_URI is set, it is forwarded to binman as the
> > pkcs11-uri entry argument, overriding the keyfile property at signing
> > time. BINMAN_PKCS11_MODULE is optional and only needed when the PKCS#11
> > library is not already configured via openssl.cnf or the
> > PKCS11_MODULE_PATH environment variable.
> >
> > The openssl bintool gains three helper methods:
> >
> >    _pkcs11_use_provider() auto-detects whether the OpenSSL pkcs11
> >      provider (OpenSSL >=3D 3.1, pkcs11-provider) or the legacy pkcs11
> >      engine (libp11) is available, by inspecting 'openssl list
> >      -providers'.
> >
> >    _build_key_args() builds the -key/-provider/-engine arguments for th=
e
> >      openssl command line. When PKCS11_PIN is set in the environment,
> >      its value is appended as ?pin-value=3D<pin> to the URI so that
> >      non-interactive signing works with both the provider and engine
> >      paths.
> >
> >    _run_cmd_pkcs11() sets PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODULE
> >      before invoking openssl when a module path is given, and serialise=
s
> >      concurrent signing calls with a module-level lock. The lock is
> >      required because binman's ThreadPoolExecutor may invoke multiple
> >      signing operations simultaneously, and HSMs (including SoftHSM2) d=
o
> >      not support concurrent logins from different threads.
> >
> > Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
> > BINMAN_PKCS11_MODULE is set.
> >
> > Tested with SoftHSM2 and a YubiKey using the verdin-am62_a53_defconfig
> > configuration and both engine and provider OpenSSL APIs.
> >
> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > ---
> >   Makefile                        |   2 +
> >   tools/binman/binman.rst         |  18 +++++
> >   tools/binman/btool/openssl.py   | 117 +++++++++++++++++++++++++++----=
-
> >   tools/binman/etype/x509_cert.py |  47 +++++++++++--
> >   tools/binman/ftest.py           | 110 ++++++++++++++++++++++++++++++
> >   5 files changed, 274 insertions(+), 20 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index dfc95d314ddd..8d6c584b2731 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1701,6 +1701,8 @@ cmd_binman =3D $(srctree)/tools/binman/binman $(i=
f
$(BINMAN_DEBUG),-D) \
> >               -a vpl-dtb=3D$(CONFIG_VPL_OF_REAL) \
> >               -a pre-load-key-path=3D${PRE_LOAD_KEY_PATH} \
> >               -a of-spl-remove-props=3D$(CONFIG_OF_SPL_REMOVE_PROPS) \
> > +             $(if $(BINMAN_PKCS11_URI),-a
pkcs11-uri=3D"$(BINMAN_PKCS11_URI)") \
> > +             $(if $(BINMAN_PKCS11_MODULE),-a
pkcs11-module=3D"$(BINMAN_PKCS11_MODULE)") \
> >               $(BINMAN_$(@F))
> >
> >   OBJCOPYFLAGS_u-boot.ldr.hex :=3D -I binary -O ihex
> > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > index 366491089ad9..e60eb7f572eb 100644
> > --- a/tools/binman/binman.rst
> > +++ b/tools/binman/binman.rst
> > @@ -2161,6 +2161,24 @@ BINMAN_INDIRS
> >       Sets the search path for input files used by binman by adding one
or more
> >       `-I` arguments. See :ref:`External blobs`.
> >
> > +BINMAN_PKCS11_URI
> > +    PKCS#11 URI used to sign boot artifacts via an HSM instead of a
PEM key
> > +    file on disk. When set, it is passed as ``-a pkcs11-uri=3D<uri>`` =
to
binman,
> > +    which overrides the ``keyfile`` entry argument for all signing
operations.
> > +    Example::
> > +
> > +        make
BINMAN_PKCS11_URI=3D"pkcs11:token=3Dmytoken;object=3Dmykey;type=3Dprivate"
> > +
> > +BINMAN_PKCS11_MODULE
> > +    Path to the PKCS#11 shared library (.so) for HSM signing. When
set, it is
> > +    passed as ``-a pkcs11-module=3D<path>`` to binman. Only needed whe=
n
the
> > +    module is not already configured via ``openssl.cnf`` or the
> > +    ``PKCS11_MODULE_PATH`` environment variable. Typically used
together with
> > +    ``BINMAN_PKCS11_URI``::
> > +
> > +        make
BINMAN_PKCS11_URI=3D"pkcs11:token=3Dmytoken;object=3Dmykey;type=3Dprivate" =
\
> > +             BINMAN_PKCS11_MODULE=3D"/usr/lib/pkcs11/libsofthsm2.so"
> > +
>
> OK, but why do we want to have this variable for storing the path to the
> module lib instead of using an openssl.cnf?
>
> Also, this is stating it's for signing boot artifacts with an HSM, but
> that isn't true. It won't work with FIT images, which use DT properties
> instead (see fit,engine, fit,engine-keydir/key-name-hint.).
>
> I'm assuming it's possible we want different keys for different boot
> artifacts, so this is also a bit too generic of a name?
>
> >   BINMAN_TOOLPATHS
> >       Sets the search path for external tool used by binman by adding
one or more
> >       `--toolpath` arguments. See :ref:`External tools`.
> > diff --git a/tools/binman/btool/openssl.py
b/tools/binman/btool/openssl.py
> > index b26f087c4470..ec477a46a3d7 100644
> > --- a/tools/binman/btool/openssl.py
> > +++ b/tools/binman/btool/openssl.py
> > @@ -11,10 +11,16 @@ Source code is at https://www.openssl.org/
> >   """
> >
> >   import hashlib
> > +import os
> > +import threading
> >
> >   from binman import bintool
> >   from u_boot_pylib import tools
> >
> > +# Serializes concurrent PKCS#11 signing operations. SoftHSM2 and many
real
> > +# HSMs do not support simultaneous logins from multiple threads, so
binman's
> > +# ThreadPoolExecutor would otherwise cause intermittent login failures=
.
> > +_pkcs11_lock =3D threading.Lock()
> >
>
> Is there really no external mechanism to make sure this cannot happen?
> or maybe some sort of session concept?
>
> binman tests will run on multiple processes (see ConcurrentTestSuite)
> when not instructed to run on one thread (via -T 0, used for test
> coverage). My worry is whether this is multiprocess safe (hunch is no).
> Look at what we did for the FIT signing tests, we use different softhsm
> and openssl config files per file and I hope this is enough for openssl
> and softhsm to not get confused. Considering there's a
> multiprocessing.Lock(), there must be a reason for it no?
>
> >   VALID_SHAS =3D [256, 384, 512, 224]
> >   SHA_OIDS =3D {256:'2.16.840.1.101.3.4.2.1',
> > @@ -35,18 +41,89 @@ class Bintoolopenssl(bintool.Bintool):
> >           super().__init__(
> >               name, 'openssl cryptography toolkit',
> >               version_regex=3Dr'OpenSSL (.*) \(', version_args=3D'versi=
on')
> > +        self._use_provider =3D None
> > +
> > +    def _pkcs11_use_provider(self):
> > +        """Return True if the provider API should be used for PKCS#11
signing.
> > +
> > +        Checks whether the pkcs11 provider is available by running
> > +        'openssl list -providers'. The result is cached after the
first call
> > +        to avoid spawning a subprocess on every signing operation.
> > +
> > +        Returns:
> > +            bool: True if provider should be used, False if engine
should be used
> > +        """
> > +        if self._use_provider is None:
> > +            out =3D self.run_cmd('list', '-providers') or ''
> > +            self._use_provider =3D 'pkcs11' in out
> > +        return self._use_provider
> > +
>
> Why force the user to use providers if one is available? Can't they use
> an engine even if a pkcs11 provider is available (e.g. you have both
> pkcs11 provider support via softhsm2, but only engine support for your
> HSM). Isn't this something the user can specify via openssl.cnf?
>
> > +    def _build_key_args(self, key_fname):
> > +        """Build openssl CLI arguments for the signing key.
> > +
> > +        Always add '-key key_fname', and for a PKCS#11 URI
(pkcs11:...),
> > +        prepends either '-provider default -provider pkcs11' (if
provider API
> > +        is available) or '-engine pkcs11 -keyform engine' (legacy
fallback).
> > +        If the PKCS11_PIN environment variable is set, appends
pin-value=3D<pin>
> > +        to the URI.
> > +
> > +        Args:
> > +            key_fname (str): Filename of .pem file or PKCS#11 URI
> > +
> > +        Returns:
> > +            list: openssl arguments for the key selection
> > +        """
> > +        if key_fname.startswith('pkcs11:'):
> > +            pin =3D os.environ.get('PKCS11_PIN')
> > +            if pin:
> > +                sep =3D '&' if '?' in key_fname else '?'
> > +                key_fname =3D f'{key_fname}{sep}pin-value=3D{pin}'
> > +            if self._pkcs11_use_provider():
> > +                args =3D ['-provider', 'default', '-provider', 'pkcs11=
',
'-key', key_fname]
> > +            else:
> > +                args =3D ['-engine', 'pkcs11', '-keyform', 'engine',
'-key', key_fname]
> > +        else:
> > +            args =3D ['-key', key_fname]
> > +        return args
> > +
> > +    def _run_cmd_pkcs11(self, pkcs11_module, *args):
> > +        """Run an openssl command, optionally passing PKCS#11 module
env vars.
> > +
> > +        When pkcs11_module is set, PKCS11_MODULE_PATH (engine) and
> > +        PKCS11_PROVIDER_MODULE (provider) are passed as extra
environment
> > +        variables.
> > +        If already configured via openssl.cnf or the calling
environment,
> > +        pkcs11_module can be None.
> > +
> > +        Args:
> > +            pkcs11_module (str or None): Path to the PKCS#11 shared
library
> > +            *args: Arguments forwarded to run_cmd
> > +
> > +        Returns:
> > +            str: openssl output
> > +        """
> > +        if pkcs11_module:
> > +            extra_env =3D {
> > +                'PKCS11_MODULE_PATH': pkcs11_module,
> > +                'PKCS11_PROVIDER_MODULE': pkcs11_module,
> > +            }
> > +            with _pkcs11_lock:
> > +                return self.run_cmd(*args, extra_env=3Dextra_env)
> > +        return self.run_cmd(*args)
> >
> >       def x509_cert(self, cert_fname, input_fname, key_fname, cn,
revision,
> > -                  config_fname):
> > +                  config_fname, pkcs11_module=3DNone):
> >           """Create a certificate
> >
> >           Args:
> >               cert_fname (str): Filename of certificate to create
> >               input_fname (str): Filename containing data to sign
> > -            key_fname (str): Filename of .pem file
> > +            key_fname (str): Filename of .pem file or PKCS#11 URI
> >               cn (str): Common name
> >               revision (int): Revision number
> >               config_fname (str): Filename to write fconfig into
> > +            pkcs11_module (str or None): Path to PKCS#11 shared
library, or
> > +                None if already configured via openssl.cnf or the
environment
> >
> >           Returns:
> >               str: Tool output
> > @@ -76,19 +153,20 @@ shaType                =3D OID:2.16.840.1.101.3.4.=
2.3
> >   shaValue               =3D FORMAT:HEX,OCT:{hashval}
> >   imageSize              =3D INTEGER:{len(indata)}
> >   ''', file=3Doutf)
> > -        args =3D ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> > +        args =3D ['req', '-new', '-x509',
*self._build_key_args(key_fname), '-nodes',
> >                   '-outform', 'DER', '-out', cert_fname, '-config',
config_fname,
> >                   '-sha512']
> > -        return self.run_cmd(*args)
> > +        return self._run_cmd_pkcs11(pkcs11_module, *args)
> >
> >       def x509_cert_sysfw(self, cert_fname, input_fname, key_fname,
sw_rev,
> > -                  config_fname, req_dist_name_dict,
firewall_cert_data):
> > +                  config_fname, req_dist_name_dict, firewall_cert_data=
,
> > +                  pkcs11_module=3DNone):
> >           """Create a certificate to be booted by system firmware
> >
> >           Args:
> >               cert_fname (str): Filename of certificate to create
> >               input_fname (str): Filename containing data to sign
> > -            key_fname (str): Filename of .pem file
> > +            key_fname (str): Filename of .pem file or PKCS#11 URI
> >               sw_rev (int): Software revision
> >               config_fname (str): Filename to write fconfig into
> >               req_dist_name_dict (dict): Dictionary containing
key-value pairs of
> > @@ -101,6 +179,8 @@ imageSize              =3D INTEGER:{len(indata)}
> >                   extended certificate
> >                 - certificate (str): Extended firewall certificate with
> >                   the information for the firewall configurations.
> > +            pkcs11_module (str or None): Path to PKCS#11 shared
library, or
> > +                None if already configured via openssl.cnf or the
environment
> >
> >           Returns:
> >               str: Tool output
> > @@ -146,20 +226,20 @@ authInPlace =3D
INTEGER:{hex(firewall_cert_data['auth_in_place'])}
> >   numFirewallRegions =3D INTEGER:{firewall_cert_data['num_firewalls']}
> >   {firewall_cert_data['certificate']}
> >   ''', file=3Doutf)
> > -        args =3D ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> > +        args =3D ['req', '-new', '-x509',
*self._build_key_args(key_fname), '-nodes',
> >                   '-outform', 'DER', '-out', cert_fname, '-config',
config_fname,
> >                   '-sha512']
> > -        return self.run_cmd(*args)
> > +        return self._run_cmd_pkcs11(pkcs11_module, *args)
> >
> >       def x509_cert_rom(self, cert_fname, input_fname, key_fname,
sw_rev,
> >                     config_fname, req_dist_name_dict, cert_type,
bootcore,
> > -                  bootcore_opts, load_addr, sha, debug):
> > +                  bootcore_opts, load_addr, sha, debug,
pkcs11_module=3DNone):
> >           """Create a certificate
> >
> >           Args:
> >               cert_fname (str): Filename of certificate to create
> >               input_fname (str): Filename containing data to sign
> > -            key_fname (str): Filename of .pem file
> > +            key_fname (str): Filename of .pem file or PKCS#11 URI
> >               sw_rev (int): Software revision
> >               config_fname (str): Filename to write fconfig into
> >               req_dist_name_dict (dict): Dictionary containing
key-value pairs of
> > @@ -170,6 +250,8 @@ numFirewallRegions =3D
INTEGER:{firewall_cert_data['num_firewalls']}
> >               bootcore_opts(int): Booting core option, lockstep (0) or
split (2) mode
> >               load_addr (int): Load address of image
> >               sha (int): Hash function
> > +            pkcs11_module (str or None): Path to PKCS#11 shared
library, or
> > +                None if already configured via openssl.cnf or the
environment
> >
> >           Returns:
> >               str: Tool output
> > @@ -231,10 +313,10 @@ emailAddress           =3D
{req_dist_name_dict['emailAddress']}
> >    coreDbgEn =3D INTEGER:0
> >    coreDbgSecEn =3D INTEGER:0
> >   ''', file=3Doutf)
> > -        args =3D ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> > +        args =3D ['req', '-new', '-x509',
*self._build_key_args(key_fname), '-nodes',
> >                   '-outform', 'DER', '-out', cert_fname, '-config',
config_fname,
> >                   '-sha512']
> > -        return self.run_cmd(*args)
> > +        return self._run_cmd_pkcs11(pkcs11_module, *args)
> >
> >       def x509_cert_rom_combined(self, cert_fname, input_fname,
key_fname, sw_rev,
> >                     config_fname, req_dist_name_dict, load_addr, sha,
total_size, num_comps,
> > @@ -242,13 +324,14 @@ emailAddress           =3D
{req_dist_name_dict['emailAddress']}
> >                     imagesize_sbl, hashval_sbl, load_addr_sysfw,
imagesize_sysfw,
> >                     hashval_sysfw, load_addr_sysfw_data,
imagesize_sysfw_data,
> >                     hashval_sysfw_data, sysfw_inner_cert_ext_boot_block=
,
> > -                  dm_data_ext_boot_block, bootcore_opts, debug):
> > +                  dm_data_ext_boot_block, bootcore_opts, debug,
> > +                  pkcs11_module=3DNone):
> >           """Create a certificate
> >
> >           Args:
> >               cert_fname (str): Filename of certificate to create
> >               input_fname (str): Filename containing data to sign
> > -            key_fname (str): Filename of .pem file
> > +            key_fname (str): Filename of .pem file or PKCS#11 URI
> >               sw_rev (int): Software revision
> >               config_fname (str): Filename to write fconfig into
> >               req_dist_name_dict (dict): Dictionary containing
key-value pairs of
> > @@ -259,6 +342,8 @@ emailAddress           =3D
{req_dist_name_dict['emailAddress']}
> >               load_addr (int): Load address of image
> >               sha (int): Hash function
> >               bootcore_opts (int): Booting core option, lockstep (0) or
split (2) mode
> > +            pkcs11_module (str or None): Path to PKCS#11 shared
library, or
> > +                None if already configured via openssl.cnf or the
environment
> >
> >           Returns:
> >               str: Tool output
> > @@ -342,10 +427,10 @@ coreDbgSecEn =3D INTEGER:0
> >
> >   {dm_data_ext_boot_block}
> >           ''', file=3Doutf)
> > -        args =3D ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> > +        args =3D ['req', '-new', '-x509',
*self._build_key_args(key_fname), '-nodes',
> >                   '-outform', 'DER', '-out', cert_fname, '-config',
config_fname,
> >                   '-sha512']
> > -        return self.run_cmd(*args)
> > +        return self._run_cmd_pkcs11(pkcs11_module, *args)
> >
> >       def fetch(self, method):
> >           """Fetch handler for openssl
> > diff --git a/tools/binman/etype/x509_cert.py
b/tools/binman/etype/x509_cert.py
> > index b6e8b0b4fb09..cdeff1a227a1 100644
> > --- a/tools/binman/etype/x509_cert.py
> > +++ b/tools/binman/etype/x509_cert.py
> > @@ -19,6 +19,18 @@ class Entry_x509_cert(Entry_collection):
> >
> >       Properties / Entry arguments:
> >           - content: List of phandles to entries to sign
> > +        - keyfile: Filename of the PEM key file used to sign the binar=
y
> > +        - pkcs11-uri: PKCS#11 URI for signing via an HSM, e.g.
> > +            ``pkcs11:token=3Dmytoken;object=3Dmykey;type=3Dprivate``. =
When
provided
> > +            via ``-a pkcs11-uri=3D...`` on the binman command line (or
via the
> > +            ``BINMAN_PKCS11_URI`` make variable), it overrides
``keyfile`` for
> > +            the signing operation.
> > +        - pkcs11-module: Path to the PKCS#11 shared library (.so), e.g=
.
> > +            ``/usr/lib/pkcs11/libsofthsm2.so``. Only needed when
signing via
> > +            HSM and the module is not already configured via
``openssl.cnf`` or
> > +            the ``PKCS11_MODULE_PATH`` environment variable. Provided
via
> > +            ``-a pkcs11-module=3D...`` or the ``BINMAN_PKCS11_MODULE``
make
> > +            variable.
> >
> >       Output files:
> >           - input.<unique_name> - input file passed to openssl
> > @@ -27,6 +39,16 @@ class Entry_x509_cert(Entry_collection):
> >
> >       openssl signs the provided data, writing the signature in this
entry. This
> >       allows verification that the data is genuine
> > +
> > +    To sign with an HSM, pass the PKCS#11 URI and optionally the
module path
> > +    at build time::
> > +
> > +        make
BINMAN_PKCS11_URI=3D"pkcs11:token=3Dmytoken;object=3Dmykey;type=3Dprivate" =
\\
> > +             BINMAN_PKCS11_MODULE=3D"/usr/lib/pkcs11/libsofthsm2.so" \=
\
> > +             PKCS11_PIN=3D"1234"
> > +
> > +    The ``PKCS11_PIN`` environment variable is used by the openssl
bintool to
> > +    append ``?pin-value=3D<pin>`` to the URI when required.
> >       """
> >       def __init__(self, section, etype, node):
> >           super().__init__(section, etype, node)
> > @@ -53,6 +75,8 @@ class Entry_x509_cert(Entry_collection):
> >           self.dm_data_ext_boot_block =3D None
> >           self.firewall_cert_data =3D None
> >           self.debug =3D False
> > +        self.pkcs11_uri =3D None
> > +        self.pkcs11_module =3D None
> >
> >       def ReadNode(self):
> >           super().ReadNode()
> > @@ -61,6 +85,10 @@ class Entry_x509_cert(Entry_collection):
> >           self.key_fname =3D self.GetEntryArgsOrProps([
> >               EntryArg('keyfile', str)], required=3DTrue)[0]
> >           self.sw_rev =3D fdt_util.GetInt(self._node, 'sw-rev', 1)
> > +        self.pkcs11_uri =3D self.GetEntryArgsOrProps([
> > +            EntryArg('pkcs11-uri', str)], required=3DFalse)[0]
> > +        self.pkcs11_module =3D self.GetEntryArgsOrProps([
> > +            EntryArg('pkcs11-module', str)], required=3DFalse)[0]
> >
> >       def GetCertificate(self, required, type=3D'generic'):
> >           """Get the contents of this entry
> > @@ -80,6 +108,13 @@ class Entry_x509_cert(Entry_collection):
> >           if input_data is None:
> >               return None
> >
> > +        # Override keyfile with the PKCS#11 URI if provided. This must
be
> > +        # done here rather than in ReadNode(), because subclasses (e.g=
.
> > +        # ti_secure_rom, ti_secure) call super().ReadNode() and then
> > +        # overwrite self.key_fname with the DTS 'keyfile' property.
> > +        if self.pkcs11_uri:
> > +            self.key_fname =3D self.pkcs11_uri
> > +
> >           uniq =3D self.GetUniqueName()
> >           output_fname =3D tools.get_output_filename('cert.%s' % uniq)
> >           input_fname =3D tools.get_output_filename('input.%s' % uniq)
> > @@ -93,7 +128,8 @@ class Entry_x509_cert(Entry_collection):
> >                   key_fname=3Dself.key_fname,
> >                   cn=3Dself._cert_ca,
> >                   revision=3Dself._cert_rev,
> > -                config_fname=3Dconfig_fname)
> > +                config_fname=3Dconfig_fname,
> > +                pkcs11_module=3Dself.pkcs11_module)
> >           elif type =3D=3D 'sysfw':
> >               stdout =3D self.openssl.x509_cert_sysfw(
> >                   cert_fname=3Doutput_fname,
> > @@ -102,7 +138,8 @@ class Entry_x509_cert(Entry_collection):
> >                   config_fname=3Dconfig_fname,
> >                   sw_rev=3Dself.sw_rev,
> >                   req_dist_name_dict=3Dself.req_dist_name,
> > -                firewall_cert_data=3Dself.firewall_cert_data)
> > +                firewall_cert_data=3Dself.firewall_cert_data,
> > +                pkcs11_module=3Dself.pkcs11_module)
> >           elif type =3D=3D 'rom':
> >               stdout =3D self.openssl.x509_cert_rom(
> >                   cert_fname=3Doutput_fname,
> > @@ -116,7 +153,8 @@ class Entry_x509_cert(Entry_collection):
> >                   bootcore_opts=3Dself.bootcore_opts,
> >                   load_addr=3Dself.load_addr,
> >                   sha=3Dself.sha,
> > -                debug=3Dself.debug
> > +                debug=3Dself.debug,
> > +                pkcs11_module=3Dself.pkcs11_module
> >               )
> >           elif type =3D=3D 'rom-combined':
> >               stdout =3D self.openssl.x509_cert_rom_combined(
> > @@ -143,7 +181,8 @@ class Entry_x509_cert(Entry_collection):
> >
sysfw_inner_cert_ext_boot_block=3Dself.sysfw_inner_cert_ext_boot_block,
> >                   dm_data_ext_boot_block=3Dself.dm_data_ext_boot_block,
> >                   bootcore_opts=3Dself.bootcore_opts,
> > -                debug=3Dself.debug
> > +                debug=3Dself.debug,
> > +                pkcs11_module=3Dself.pkcs11_module
> >               )
> >           if stdout is not None:
> >               data =3D tools.read_file(output_fname)
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index ca5149ee654a..a23719c767c8 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -6884,6 +6884,116 @@ fdt         fdtmap                Extract the
devicetree blob from the fdtmap
> >           err =3D stderr.getvalue()
> >           self.assertRegex(err, "Image 'image'.*missing bintools.*:
openssl")
> >
> > +    def testOpenSslBuildKeyArgsPem(self):
> > +        """Test _build_key_args with a regular PEM key file"""
> > +        openssl =3D bintool.Bintool.create('openssl')
>
> Please always check the bintool is present with
>
> self._CheckBintool(bintool)
>
> such that we can skip tests if it isn't present instead of failing hard
> later.
>
> > +        args =3D openssl._build_key_args('/path/to/key.pem')
> > +        self.assertEqual(['-key', '/path/to/key.pem'], args)
> > +
> > +    def testOpenSslBuildKeyArgsPkcs11Provider(self):
> > +        """Test _build_key_args with a PKCS#11 URI when provider API
is available"""
> > +        uri =3D 'pkcs11:token=3Dmytoken;object=3Dmykey'
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                        return_value=3D'pkcs11
provider'):
> > +            args =3D openssl._build_key_args(uri)
> > +        self.assertEqual(['-provider', 'default', '-provider',
'pkcs11',
> > +                          '-key', uri], args)
> > +
> > +    def testOpenSslBuildKeyArgsPkcs11Engine(self):
> > +        """Test _build_key_args with a PKCS#11 URI when only engine
API is available"""
> > +        uri =3D 'pkcs11:token=3Dmytoken;object=3Dmykey'
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.object(openssl, 'run_cmd',
return_value=3D''):
> > +            args =3D openssl._build_key_args(uri)
> > +        self.assertEqual(['-engine', 'pkcs11', '-keyform', 'engine',
> > +                          '-key', uri], args)
> > +
> > +    def testOpenSslBuildKeyArgsPkcs11Pin(self):
> > +        """Test _build_key_args appends pin-value to URI when
PKCS11_PIN is set"""
> > +        uri =3D 'pkcs11:token=3Dmytoken;object=3Dmykey'
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN':
'1234'}):
> > +            with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                            return_value=3D'pkcs11'):
> > +                args =3D openssl._build_key_args(uri)
> > +        self.assertIn(f'{uri}?pin-value=3D1234', args)
> > +
> > +    def testOpenSslBuildKeyArgsPkcs11PinExistingQuery(self):
> > +        """Test _build_key_args uses '&' separator when URI already
has query params"""
> > +        uri =3D
'pkcs11:token=3Dmytoken;object=3Dmykey?module-path=3D/path/to/lib'
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN':
'1234'}):
> > +            with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                            return_value=3D'pkcs11'):
> > +                args =3D openssl._build_key_args(uri)
> > +        self.assertIn(f'{uri}&pin-value=3D1234', args)
> > +
> > +    def testOpenSslPkcs11UseProviderCached(self):
> > +        """Test that _pkcs11_use_provider caches its result after the
first call"""
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                        return_value=3D'pkcs11') as
mock_cmd:
> > +            result1 =3D openssl._pkcs11_use_provider()
> > +            result2 =3D openssl._pkcs11_use_provider()
> > +        self.assertTrue(result1)
> > +        self.assertTrue(result2)
> > +        mock_cmd.assert_called_once_with('list', '-providers')
> > +
> > +    def testOpenSslRunCmdPkcs11NoModule(self):
> > +        """Test _run_cmd_pkcs11 without a module just forwards to
run_cmd"""
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                        return_value=3D'output') as
mock_cmd:
> > +            result =3D openssl._run_cmd_pkcs11(None, 'version')
> > +        mock_cmd.assert_called_once_with('version')
> > +        self.assertEqual('output', result)
> > +
> > +    def testOpenSslRunCmdPkcs11WithModule(self):
> > +        """Test _run_cmd_pkcs11 passes module paths to run_cmd via
extra_env"""
> > +        module =3D '/usr/lib/pkcs11/libsofthsm2.so'
> > +        openssl =3D bintool.Bintool.create('openssl')
> > +        with unittest.mock.patch.object(openssl, 'run_cmd',
> > +                                        return_value=3D'output') as
mock_cmd:
> > +            openssl._run_cmd_pkcs11(module, 'version')
> > +        mock_cmd.assert_called_once_with('version', extra_env=3D{
> > +            'PKCS11_MODULE_PATH': module,
> > +            'PKCS11_PROVIDER_MODULE': module,
> > +        })
> > +
> > +    def testX509CertPkcs11(self):
> > +        """Test X509 certificate creation using a PKCS#11 URI instead
of a key file"""
> > +        PKCS11_URI =3D 'pkcs11:token=3Dtest;object=3Dmykey;type=3Dpriv=
ate'
> > +        PKCS11_MODULE =3D '/usr/lib/pkcs11/libsofthsm2.so'
>
> FYI, the path isn't stable across all distros. Hence why we went for
> checking the path with p11-kit print-config to identify where it's
located.
>
> > +        original =3D bintool.Bintool.run_cmd
> > +        signing_args =3D []
> > +
> > +        def fake_openssl(self_tool, *args, binary=3DFalse,
extra_env=3DNone):
> > +            if self_tool.name !=3D 'openssl':
> > +                return original(self_tool, *args, binary=3Dbinary)
> > +            arg_list =3D list(args)
> > +            if arg_list =3D=3D ['list', '-providers']:
> > +                return 'pkcs11 provider'
> > +            if '-out' in arg_list:
> > +                signing_args.extend(arg_list)
> > +                tools.write_file(arg_list[arg_list.index('-out') + 1],
> > +                                 b'\x00' * 32)
> > +            return ''
> > +
>
> We need to check with a real openssl too, otherwise we just check the
> interface with openssl and not that it is actually doing what's expected
> (and may change, e.g. with a newer version of openssl).
>
> > +        entry_args =3D {
> > +            'keyfile': self.TestFile('security/key.key'),
> > +            'pkcs11-uri': PKCS11_URI,
> > +            'pkcs11-module': PKCS11_MODULE,
> > +        }
> > +        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
> > +                                        new=3Dfake_openssl):
> > +            data =3D self._DoReadFileDtb('security/x509_cert.dts',
> > +                                       entry_args=3Dentry_args)[0]
> > +        self.assertGreater(len(data), len(U_BOOT_DATA))
> > +        self.assertEqual(U_BOOT_DATA, data[-4:])
> > +        self.assertIn('-provider pkcs11', ' '.join(signing_args))
> > +        self.assertIn(PKCS11_URI, signing_args)
> > +
>
> Why going to such length to avoid actually using openssl?
> Generate/import a certificate in softhsm2 and check that the bintool
> actually returns what's expected? We do this for signing FIT images so
> I'm assuming this is something you could do here as well?
>
> Cheers,
> Quentin
