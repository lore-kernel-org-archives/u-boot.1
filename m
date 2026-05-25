Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD6CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 10:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFA18405A;
	Mon, 25 May 2026 12:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="fUJyyXs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916BC844CF; Mon, 25 May 2026 12:27:33 +0200 (CEST)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFC083EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 12:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-304545f5206so3732335eec.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779704849; cv=none;
 d=google.com; s=arc-20240605;
 b=fZj5jWJzctOXxj0od+8AzrXLp630NdFwRRUsevWjD9+5zFevcSrw00z2iZlXOkb5OQ
 itxQ2a/XBuje4jDihjq6k+rcKc68kNFsdhkHFdakYQ+UwRXKbBxRcDgIg7hpXmEPJVPq
 VrhT117SKhFZT/cbvtB9cc3RYGq0vfQVG2ZDYEqKJ7yetW/qAzx/hk5+44PRiAzAnAcN
 UY55gn+3LsvrXMiCWp8LafQalWcvWxfznnwFKq4RV4bYQYmpPYy48xGl1IJIVOI9d9/D
 5SeuNFZOqjGx5dXbSpsGqzJAtrEhLXXsAWy2OujM7WY0KwM/J/yS5nSzBa158k5M+onk
 JlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MvhZDcHGPgZLtYdmFEGJ8+oxNRYWm2u+Eti7YhSf+z0=;
 fh=XW75Vhft371F+di1QXPs6MccQxNY9hvRp/1HTm2IjA4=;
 b=RtK3yRJaHM9tSOCpW/LojeCT6gPn+zBbJyBXxkhBpQYv4nNwNWi8WoZw5dv8vM2odt
 CPt5C1gWTJ3zuBgHFL6oSHBGXanNGsfqnt8cOG06A6zDDDvh5A5ozsAxLrTX939Xgxr2
 DBZw+rbEx4SPf0jx6w8jG3WCo/KWb75PdXLlaPXgMRREO5hDu/4ENZrORrZt589AToD2
 SINMYHic1FJCda+qwa9C6HsEcYh6AGpjOIQnWXAOx82+e4ik3ey+dkkSdM3xvPWSt2GN
 TIjHgLAs61DrG9zD79iNc19iYt91Lli7raEIDCNHZZ6Sbty0pPo9QkyVLvnVhb0jX4TN
 0MtQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1779704849; x=1780309649;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MvhZDcHGPgZLtYdmFEGJ8+oxNRYWm2u+Eti7YhSf+z0=;
 b=fUJyyXs0gFKRhqmaC0THrt+Ppi96r8nnJ0TGSjeabybYw7EPzITYbpUi+QeR6mP7k4
 1GdbQKJSgIxsm4l4PYoYWIs6eVwiOdNMeii4pDoc2+I5llo64L+Kvf+2Af4xcmNOtcmx
 3y4BSP3TbGXIuFqzEaFJvjRWwyO1mN5ZDyBVWh2XHyQlbpOhbwBHRq5aQqXH1R+HEz1Z
 1MDnk9Jns/27pSgeUQaj59hOKZvt4ACXI/ZRHvDTGrzh5O6VmI/TQ5s0dxSlBNPu1X7a
 1TFwlrpNzUr8hPEGFnJXWoqlFkxYUSN9+Xb5WN9BE4HjHTdx5ulTjJ0uitlRJkpni3tz
 bwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779704849; x=1780309649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvhZDcHGPgZLtYdmFEGJ8+oxNRYWm2u+Eti7YhSf+z0=;
 b=bp30+u1jd8toi1aXKVrDJ59D9+pkhg2F+PHlzg8p52tWFLzgn3aquj+tiN5UHsCQrt
 GM8Ck0fLiR2QoFhrCvFjxb23DGkEGZUDN2oIpiYXKhSrNhdm8OvcCUmpzQ0w8Cw8tsqV
 mwzWPcwpZbsLIrGnK0tBjeeaWMws5caYWxghKJhEPF7TEqldkni7sQZhcffIpEFQ4PkQ
 7FGlpis3eMkv8JHLeDfA523D4jryFV/zTxBdMYFSYoLbY7xpsRFnWe12KBmIDGq6iMTt
 OxPmwck/D0Bb+8BKpp7wCkr6RshjbQgPt4GhCXCd+NnRxS5kTd8u6Iuum5aOZUCQVC4o
 Mqfg==
X-Gm-Message-State: AOJu0YzAaigLVImD43u0WtBpxEY5XBruihC9PHALuN5FlAXXSFKRWGA+
 mxgPt2zRjzY4y+UiEDcLqLRb/VXeoNWEpxZc6UBni3jS6M14LNZ0LnlcclatTDwOfxwE0xtx30M
 FyoK2XzIzxXknkFD62G4GFOJYfhatO86ji48Ak5v5uA==
X-Gm-Gg: Acq92OGq/4XH2Cu+NHhXC9lYfUAQzt89DdYSum5mFgIjvNd2XqtXM8AKA734SgTtumP
 /G0cS4aQpVk0ZQJ/NchvfFg2LIZX8ZzE0qCusD3FJCx076ZLGzKATdRwYP4m9XyrbIbV8psVscZ
 RCrdUtogp1qQBj/Iy2YZhbAolvVSVvp3X6AaUiqYV7vEymwdeTTVZmc60lOx4UAZCobIgEUD6/t
 bu3d/Yg0RlcZE8Azzvzq6tLT3eQscbV/rUEFFZZ/P/r67lKek+uLPAyjS5dlfLkv95usXGnnQRb
 cXvzA5Dng8eWfBacR1aUo6QAJyj/uPsuKDwRhzpm
X-Received: by 2002:a05:7300:8607:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-30448fd63d5mr6415139eec.2.1779704849157; Mon, 25 May 2026
 03:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
 <19397895-224b-453b-8bef-b2daad30fc75@cherry.de>
In-Reply-To: <19397895-224b-453b-8bef-b2daad30fc75@cherry.de>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Mon, 25 May 2026 07:27:12 -0300
X-Gm-Features: AVHnY4L69e-zttxUxQ7TwPLpyzhSJRe8Y2RNa4oJ4TWs2frizbhpb08J-3HxoT4
Message-ID: <CANu7NGtcxrEq4qGeuROq2m6DHqe8vpiaCCJsfv+XstzeMW9+Vw@mail.gmail.com>
Subject: Re: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, xypron.glpk@gmx.de, y.moog@phytec.de, 
 afd@ti.com, Wojciech.Dubowik@mt.com
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

On 5/20/26 08:20 PM, Quentin Schulz wrote:
> > To run signing non-interactively, the PKCS11_PIN environment variable
> > can be set; its value is appended to the URI as ?pin-value=3D<pin> (or
> > &pin-value=3D<pin> when the URI already contains '?'), so the PIN does
> > not have to be embedded in BINMAN_X509_KEY_URI.
>
> It'd be nice to specify in the commit log the recommended way is to pass
> the pin via pkcs11-module-token-pin in OPENSS_CONF file.

Will add that to the commit message and call it out as the recommended
path, with PKCS11_PIN as the fallback.

> > +BINMAN_X509_KEY_URI
> > +    URI of a key used to sign x509 certificate entries via an HSM
instead of a
> > +    PEM key file on disk. When set, it is passed as ``-a
x509-key-uri=3D<uri>``
> > +    to binman, which overrides the ``keyfile`` entry argument for all
x509
> > +    certificate signing operations.
> > +
>
> Can't we reuse keyfile directly? keyfile can then point either at a file
> on disk or be an OpenSSL provider URI? This would limit the required
> changes in logic. It's piggy-backing on keyfile variable whose name
> doesn't indicate it should support provider URI and maybe I'm trying to
> fit something where it shouldn't.

Hmmm, I don't have a strong opinion on this, and indeed reusing the keyfile
argument would simplify even more the implementation. Will move on with
this change.

> > +    This only applies to x509 certificate entries (e.g. TI K3 secure
boot). It
> > +    does not affect FIT image signing, which uses device tree
properties such as
> > +    ``fit,engine`` and ``key-name-hint`` instead.
> > +
> > +    The URI is currently a PKCS#11 URI (RFC 7512). PKCS#11 signing
requires
>
> Rephrase maybe to something like
>
> """
> URIs that are currently supported are:
> - PKCS#11 URI (RFC 7512)
>
> PKCS#11 signing requires...
> """
>
> The wording is a bit odd currently but maybe you have something better
> to suggest?

Right. Will think about a better way to rephrase this.

> > +    OpenSSL 3.x. The provider or engine and the PKCS#11 module must be
> > +    configured externally via an ``openssl.cnf`` file. Either rely on
the
> > +    system default (``/etc/ssl/openssl.cnf``) or point to a custom
file via
> > +    ``OPENSSL_CONF``.
> > +
> > +    Two URI forms are supported on OpenSSL 3.x:
> > +
> > +    1. Provider path (recommended) =E2=80=94 requires the pkcs11 provi=
der, e.g.
> > +       ``pkcs11-provider``::
>
> The syntax is confusing here, is pkcs11-provider the provider path, or
> the required pkcs11 provider.
>
> It's the latter, so I can suggest:
>
> """
> e.g. via the ``pkcs11-provider`` package::
> """
>
> What do you think?

Makes sense. Will update.

> > +    To run signing non-interactively, set the ``PKCS11_PIN``
environment
> > +    variable. Its value is appended to the URI as ``?pin-value=3D<pin>=
``
so the
> > +    PIN does not have to be embedded in ``BINMAN_X509_KEY_URI``::
> > +
> > +        PKCS11_PIN=3D1234 make BINMAN_X509_KEY_URI=3D"pkcs11:..." \
> > +                             OPENSSL_CONF=3D/path/to/openssl.cnf
> > +
> > +    Note: ``PKCS11_PIN`` keeps the PIN out of the ``make`` command
line and
> > +    shell history, but the PIN is still passed to ``openssl`` as part
of the
>
> Not sure to understand how PKCS11_PIN is kept out of shell history?

You are right. I had a different context in mind, such as building inside a
controlled build system, but even in that case the variable could still end
up in log files. I will rephrase that.

> >       def ReadNode(self):
> >           super().ReadNode()
> > @@ -61,6 +80,8 @@ class Entry_x509_cert(Entry_collection):
> >           self.key_fname =3D self.GetEntryArgsOrProps([
> >               EntryArg('keyfile', str)], required=3DTrue)[0]
>
> Well... we'll override this with x509-key-uri if present, so why should
> this be required?

Moot once we unify under keyfile - keyfile stays required, and the URI form
is just a different value for it.

> > +        if pkcs11_provider is None:
> > +            self.skipTest('OpenSSL pkcs11 provider module not found')
> > +
>
> Can you explain why you're trying to find the module path? I don't think
> we need to know it?
>
> If you want to check whether it's present,
>
> openssl list -providers -provider pkcs11
>
> will fail if not present, otherwise succeeds.

Yeah, that makes sense. Will do it.

> > +[pkcs11_sect]
> > +module =3D {pkcs11_provider}
> > +pkcs11-module-path =3D {softhsm2_lib}4
>
> Why do you need those two lines? It doesn't seem to be required for me
> with my local work on supporting signing FIT images in binman with
> PKCS11 provider. I have the following:
>
> """
> openssl_conf =3D openssl_init
>
> [openssl_init]
> providers =3D providers_section
>
> [providers_section]
> default =3D default_provider
> pkcs11 =3D pkcs11_provider
>
> [default_provider]
> activate=3D1
>
> [pkcs11_provider]
> activate =3D 1
> """
>
> This would also allow you to simply have this config file in-tree
> instead of generating it like for
> tools/binman/test/fit/openssl_provider.conf, this is not a requirement
> though, it's just what I've done for signing FIT images with engines
> (and what I'll do for providers).

Indeed, I tested locally and it works without them. Will remove.

> > +            # softhsm2-util cannot generate keys (only --import), so
use
> > +            # pkcs11-tool to generate the RSA keypair directly in the
token.
> > +            tools.run('pkcs11-tool', '--module', softhsm2_lib,
> > +                      '--token-label', 'x509-test', '--login',
'--pin', pin,
> > +                      '--keypairgen', '--key-type', 'rsa:2048',
> > +                      '--label', 'testkey', '--id', '01')
> > +
>
> Please use a file so we can run this test as fast as possible. We don't
> care if the key is truly private for tests. Can you use
> tools/binman/test/fit/rsa2048.key for example?

Will do.

>
> > +        entry_args =3D {
> > +            'keyfile': self.TestFile('security/key.key'),
>
> Please add a small comment that this is added to make sure we override
> the argument with x509-key-uri and that it has no other purpose than that=
.

Will add - the wording shifts slightly under the unified keyfile, since
there's no separate "override" to demonstrate; the test will confirm
keyfile accepts a pkcs11: URI. I'll keep an explicit comment along those
lines.

Thanks for reviewing!

Regards,

Sergio Prado
