Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FD7D3C538
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 12:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF2B83A71;
	Wed, 10 Dec 2025 13:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPfSARES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2790783AEF; Wed, 10 Dec 2025 13:32:20 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BC183A35
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so10120635a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1765369937; x=1765974737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i244BQM+oJH0W2jPB6wCsUhR8g951IP9nODdRLMeHjc=;
 b=ZPfSARESbqfsgih4APMXtIqfyO5E5KFWyj3HSJZxZ0NWyaeYvCAuiya5AHfJLF/ObO
 EpnUzMzR3HCw6xdaRMFTqBMlREElfSeq7JCOOCNOHYm33dMl4+z2IBIbSnbEo5S21YIK
 i+aJ4iXDchVbgxPRp3wqSvdoPE8jwXVX+mVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765369937; x=1765974737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i244BQM+oJH0W2jPB6wCsUhR8g951IP9nODdRLMeHjc=;
 b=ameanov3Hhf412OCj2B4zkfG5XW2iTL0zqwdSIj6brdajPSvMzn3uZQudJ9ymGXujx
 jlvaoNVNgcCpBDHCVxIlICRnvpOIDK0pswjs2xu+lut/F0Q4KITK/1q4NeRPWVtx1/+M
 1KOBZpV3EaL2b474tfWPr8fZA2dscygTabZRp5CiltaQEqU1/F8P91BsQR3/gkh20PGd
 3WSpccVQSdo5pjJL+BGpkkYyJEJxQt+5S3OpIX5L9qPu/jeeRzED5zLNXziaUmPicfRq
 3BL2oB7Eka4eV7FUh4gNLSii6bb6vA8KlUzhbjScPpSE+C8CgN3GW65cdKP6EWMsP28f
 cpzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWhO5IkFgeRivE44qCDW+2/Nut8LEETWfusEirVwt4U044Nw2R6J+hVbTe/MWt/98EhJVdMDE=@lists.denx.de
X-Gm-Message-State: AOJu0YwANgvn+7VljrZCEHXHw0/br6BPNTJbKTrmyEDze4Hh20rwRPaa
 33Qk7kzTCCGTkD0ctGNZq3KtLC0zHeC6dlqw5oSF5GcKYGUQIfZGlXLoaV7w/diRsUoExJS8Rza
 QWxBtggml1O6fImkZaOWW8UJOBeL4FkcuN/i0Q2sX
X-Gm-Gg: AY/fxX43vo6jsI4vFmOGmrJZLx90GIbCqOQiyLAaZ/TptAPupl5o1jYAy3806JQFI+a
 kIHJxw8vil7omfXsQiZaSIJvERPK9rc3+b+zF43Y32VCwkN+ZEWbJ973WN8dHcbuGeY/n8c8f3b
 n16nfE0la4jO/TeR9P+rC5AsueCfiFlB7yxzzY5QKaI8HRkBO5e0bLgrdiW0b+WRYDe10eIhEMx
 LOX2APF+KROHz+44Fj329OBMXsmaj7ZJAOWd9KYKqtNhjaHVuQjoSyT2kLFjADIRsfjLA==
X-Google-Smtp-Source: AGHT+IFriPRu7qtHy77XoXYqOw8UvoSeE01DoUFpdpX6DyKn+pO6yO41ZbWCFZG2VRJOhIPqpayMH1qTBMmfSetb+Dw=
X-Received: by 2002:a05:6402:40d1:b0:649:6b4e:2839 with SMTP id
 4fb4d7f45d1cf-6496db38c11mr2212119a12.23.1765369937218; Wed, 10 Dec 2025
 04:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
 <fea1b8fb-2512-41f9-af23-a716c70cce39@cherry.de>
In-Reply-To: <fea1b8fb-2512-41f9-af23-a716c70cce39@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 10 Dec 2025 05:32:04 -0700
X-Gm-Features: AQt7F2rhKmYiX7wmpcOid6NoCZ2qC6zgj9ftW4AaCe4wkt6ZXcOjP2D6Z3xi_mg
Message-ID: <CAFLszTieo4xZzo6VkvrP28duwgksgpx+4HP3tQ8WVEdssYzGOA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Yannic Moog <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 4 Dec 2025 at 04:50, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon
>
> On 12/2/25 9:06 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 11/25/25 11:15 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>>>
> >>>> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>>>
> >>>> This adds a test that signs a FIT and verifies the signature with
> >>>> fit_check_sign.
> >>>>
> >>>> OpenSSL engines are typically for signing with external HW so it's not
> >>>> that straight-forward to simulate.
> >>>>
> >>>> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
> >>>> 4096 private key is made available. It can be selected by setting the
> >>>> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
> >>>> the engine is detected by OpenSSL, which works by setting the
> >>>> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
> >>>> is properly implementing what is expected from an RSA engine, but it
> >>>> seems to be enough for testing.
> >>>>
> >>>> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
> >>>> without specific hardware. The keypairs and tokens are generated on the
> >>>> fly. The "prod" token is generated with a different PIN (1234 instead of
> >>>> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
> >>>>
> >>>> Binman will not mess with the local SoftHSMv2 setup as it will only use
> >>>> tokens from a per-test temporary directory enforced via the temporary
> >>>> configuration file set via SOFTHSM2_CONF env variable in the tests. The
> >>>> files created in the input dir should NOT be named the same as it is
> >>>> shared between all tests in the same process (which is all tests when
> >>>> running binman with -P 1 or with -T).
> >>>>
> >>>> Once signed, it's checked with fit_check_sign with the associated
> >>>> certificate.
> >>>>
> >>>> Finally, a new softhsm2_util bintool is added so that we can initialize
> >>>> the token and import keypairs. On Debian, the package also brings
> >>>> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
> >>>> is not the only package required though, as it also needs p11-kit and
> >>>> libengine-pkcs11-openssl (the latter bringing the former). We can detect
> >>>> if it's properly installed by running openssl engine dynamic -c pkcs11.
> >>>> If that fails, we simply skip the test.
> >>>> The package is installed in the CI container by default.
> >>>>
> >>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>>> ---
> >>>>    tools/binman/btool/softhsm2_util.py                |  21 ++
> >>>>    tools/binman/ftest.py                              | 223 +++++++++++++++++++++
> >>>>    tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> >>>>    tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
> >>>>    .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
> >>>>    .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
> >>>>    .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
> >>>>    tools/binman/test/340_openssl.conf                 |  10 +
> >>>>    tools/binman/test/340_softhsm2.conf                |  16 ++
> >>>>    tools/binman/test/Makefile                         |   6 +-
> >>>>    tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
> >>>>    11 files changed, 853 insertions(+), 1 deletion(-)
> >>>
> >>> Not sure of the changes from last time, but I assume the test coverage
> >>> is finished.
> >>>
> >>
> >> They are listed in the cover letter in the Changes section.
> >>
> >> $ b4 diff -v 2 3 --
> >> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T//#t
> >>
> >> will show you the git-range-diff between both versions for a given commit.
> >
> > I normally review just in email (often on a Chromebook) so I don't
> > have that. It is also an extra step and I don't know where your log
> > argument comes from. It would be better to put the change log in the
>
> What do you mean by "your log argument"?

Basically this is an email review flow. It is true that sometimes we
apply patches to look into them in detail, but as I said I am often on
a machine where I cannot.

>
> > patch as well.
> >
>
> We already had that discussion 7 months ago. See
> https://lore.kernel.org/u-boot/CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com/
> and the exchange afterwards. b4 expects you to put the changes made in
> the series in the cover letter. It doesn't forbid you from adding some
> to individual commits underneath "---" but I also don't think it syncs
> them with the cover letter (which is a feature Tom told you you could
> bring up to the b4 maintainer).

OK I see. Well in this case I just assume that the next version solves
anything I might have mentioned last time.

Regards,
Simon
