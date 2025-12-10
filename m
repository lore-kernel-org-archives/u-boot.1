Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1D7D3C537
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 12:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B3883759;
	Wed, 10 Dec 2025 13:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CR5sefzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9208389A; Wed, 10 Dec 2025 13:32:15 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81E08367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64198771a9bso12276476a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1765369932; x=1765974732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KO6t4qEpKBAnBtv1GAxomHQ6GgiT+ftANr+5VFydgYE=;
 b=CR5sefziYhDUu+kifiAD8oSPWPyMnQS1GMr4joo1D4GJSEH4A2syzE4I1+bcVEVsZb
 sq3eOrvQnaIhmddmTlOpuvP6j/IN92Cr9BVV5OXkoFlR1H7C+4K2nzHMKa8KBgBdf+9Q
 qgLVHTxBNfShw6YS9RBRJygDKW6w8ab7zW1LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765369932; x=1765974732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO6t4qEpKBAnBtv1GAxomHQ6GgiT+ftANr+5VFydgYE=;
 b=JfAW/Zn1VkxMF/eCkt9HfxQJEak4KIK1GvE/txzWlBAlF4WkTWL+12W4wHJoLvE7Gg
 idwCtIYQbS+yDoBMKq1b3UEj+bNjhaW559p/1yC/b8aeIw/6m0n8+fUHxNtbYlZxwKHZ
 G67hlL+x4/7VIYImodTUpodFj2NBZQ2+D8B0n0GuRYYAgRELSx82FvJHSHfJNeTqi3QT
 qPSs8rQoX9LO5Q8V94fnlrf57Wvd1UQxz5LvmSbQmik7CHwiTf4blezTNzH19dFXXP61
 JPMxH57RyZjziW1cstg2m7yaeLZ2LbgiLgM0uhw3QrynlTO195vU+CdOlrpg4Qse28WU
 Ryaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyPVTJNt/+SXlqCvi9+VL1+9+4/cEyGGp/vt8bxFUTjjKMedyv80UtRQdrNf3rrYW9R7Gdq7I=@lists.denx.de
X-Gm-Message-State: AOJu0YyZqVtKpdQnMl3LBZzi9L8ihyCLQ/llGbrRGumSp8EoHdtPMxLM
 zb6/PTqdX3K3wrON9bFkS+gvjXvUMfT+lEHzu9nasXBrYodwIB8CPWV6z02UHtuy+Ctsrdz7AOn
 8TIeNDTh/hOV9B3L+YlSOIghtxGvp+hPAS8GnHVSt
X-Gm-Gg: AY/fxX5pnpegl9mkiq2cYCGjgsQJqISRDRWoWvFw0L1RN/fZucDsUG87n620MWqJy5S
 F8sn4WZ7Os3dfcS1gz6+ba15QexvCPP3nfIhVFcNApUaH+9rgul2sBszIvDbXPscrPQ2K9mWA6C
 4UfMeK0fA63C642eAFl5WdD7O0et2xL8pHAIVP93lck9HulMjxfRetPOD2AZchrUwVGp2MKa57J
 b8us+eJlzzhR0l1Pw+QRaAN22muPtzeJ/qaj06fEimQkEZVeYlMSolxOCHS47yHceLcdA==
X-Google-Smtp-Source: AGHT+IHgoNeMUezVVbOnyCqqmYP4ymV+gVF4w7Gufxo8b77psgtpNImU3Sm1UaZCUSgO9nBH7R5WB5J4G36Uu4VWprE=
X-Received: by 2002:a05:6402:1941:b0:647:9a0c:eb97 with SMTP id
 4fb4d7f45d1cf-6496d5db74dmr1857941a12.29.1765369932268; Wed, 10 Dec 2025
 04:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
 <20251202201451.GL303283@bill-the-cat>
In-Reply-To: <20251202201451.GL303283@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 10 Dec 2025 05:32:00 -0700
X-Gm-Features: AQt7F2omD22o_m8FHnRDxXN362XypiB7U0KZkHgexlF2FmsENVbOzr-N49Ip9Xk
Message-ID: <CAFLszTgJRS3pVo2NATAvec8tcWGXpZ24B99ohFN81krJXOZAUg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
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

Hi Tom,

On Tue, 2 Dec 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 02, 2025 at 08:06:02PM +0000, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 11/25/25 11:15 PM, Simon Glass wrote:
> > > > Hi Quentin,
> > > >
> > > > On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
> > > >>
> > > >> From: Quentin Schulz <quentin.schulz@cherry.de>
> > > >>
> > > >> This adds a test that signs a FIT and verifies the signature with
> > > >> fit_check_sign.
> > > >>
> > > >> OpenSSL engines are typically for signing with external HW so it's not
> > > >> that straight-forward to simulate.
> > > >>
> > > >> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
> > > >> 4096 private key is made available. It can be selected by setting the
> > > >> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
> > > >> the engine is detected by OpenSSL, which works by setting the
> > > >> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
> > > >> is properly implementing what is expected from an RSA engine, but it
> > > >> seems to be enough for testing.
> > > >>
> > > >> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
> > > >> without specific hardware. The keypairs and tokens are generated on the
> > > >> fly. The "prod" token is generated with a different PIN (1234 instead of
> > > >> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
> > > >>
> > > >> Binman will not mess with the local SoftHSMv2 setup as it will only use
> > > >> tokens from a per-test temporary directory enforced via the temporary
> > > >> configuration file set via SOFTHSM2_CONF env variable in the tests. The
> > > >> files created in the input dir should NOT be named the same as it is
> > > >> shared between all tests in the same process (which is all tests when
> > > >> running binman with -P 1 or with -T).
> > > >>
> > > >> Once signed, it's checked with fit_check_sign with the associated
> > > >> certificate.
> > > >>
> > > >> Finally, a new softhsm2_util bintool is added so that we can initialize
> > > >> the token and import keypairs. On Debian, the package also brings
> > > >> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
> > > >> is not the only package required though, as it also needs p11-kit and
> > > >> libengine-pkcs11-openssl (the latter bringing the former). We can detect
> > > >> if it's properly installed by running openssl engine dynamic -c pkcs11.
> > > >> If that fails, we simply skip the test.
> > > >> The package is installed in the CI container by default.
> > > >>
> > > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > >> ---
> > > >>   tools/binman/btool/softhsm2_util.py                |  21 ++
> > > >>   tools/binman/ftest.py                              | 223 +++++++++++++++++++++
> > > >>   tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> > > >>   tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
> > > >>   .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
> > > >>   .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
> > > >>   .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
> > > >>   tools/binman/test/340_openssl.conf                 |  10 +
> > > >>   tools/binman/test/340_softhsm2.conf                |  16 ++
> > > >>   tools/binman/test/Makefile                         |   6 +-
> > > >>   tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
> > > >>   11 files changed, 853 insertions(+), 1 deletion(-)
> > > >
> > > > Not sure of the changes from last time, but I assume the test coverage
> > > > is finished.
> > > >
> > >
> > > They are listed in the cover letter in the Changes section.
> > >
> > > $ b4 diff -v 2 3 --
> > > https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t
> > >
> > > will show you the git-range-diff between both versions for a given commit.
> >
> > I normally review just in email (often on a Chromebook) so I don't
> > have that. It is also an extra step and I don't know where your log
> > argument comes from. It would be better to put the change log in the
> > patch as well.
>
> The cover letter is just an email. Perhaps a handy tips bit of
> documentation (and external ref to the general b4 docs) would be
> helpful, especially since b4 is a common and widely used tool these
> days.

Well in that case, just put the change log in each patch as well as
the cover letter. It should not be difficult to support that in b4...I
think patman has supported it for 10 years now. We are the humans and
the tools should work for us!

Regards,
Simon
