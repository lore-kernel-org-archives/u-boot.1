Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675CD1266B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AA783EF2;
	Tue,  2 Dec 2025 21:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XfDUquyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF2683F1F; Tue,  2 Dec 2025 21:06:18 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2FB83EE4
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b73b24f1784so40972966b.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764705975; x=1765310775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PZkt0IqrF/AJ7DvoY9BKTrzcQSD4iSdHZOxapfS6HVM=;
 b=XfDUquyLdxPSByR/xaPF5mRXg4yB9T6LyHAcrWsaLVuP0Jm+SxXIE6FWHfpWKrRoKG
 SK+8+EOvDX60kVhpNCUx+zpWNEEtsQf2kKMW59v+J81iKOeZV/TPq5KDzXG6eCLLBLrb
 b0jLFzy38ZjgrKqvTo796xtvyd8Fd0HOr6q4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705975; x=1765310775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZkt0IqrF/AJ7DvoY9BKTrzcQSD4iSdHZOxapfS6HVM=;
 b=v0v4b9vfGZKXwkWvHuK9l+9+/vUZJcs3DOFkQ8gSslASL25/wWhTX0CWi1WmY7ogce
 GfoCdbsAGRul+AcmfR3cXEEFSR0zaB+5iqO23HZcIvyjrW25pK/U5f4o5HHhY+igs9V5
 VSR/H9K2ng/y3dnN3OfAhWN1Lxq2MnzB5qs2S5RGEdTTnLyvRpPGqfoj5UQUcdAk8wGB
 PdFOUA/dTD0qJLfB6UlwJqu1zI/BZfx3LdMG1wS+MzEVOfS3sHgBp6o20M1Wl6/mFDma
 EEINlUBoLaKN9iA8twRM+ke2FOYu9/K/8vVpiMPaAB/6YOKXfqFD1V/oaeAsyPaQdk9O
 YX4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGe7sNGcQO6qFBiV8nF09n20ZfIYrt2VnLt9e7gHGmixsMp69pAPnbwluba+M7s/ugW+Ws0A0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9t7sdG0v5cfaiW0cktUFNSICxEP5cM5ZYO6waTS5feVvGu0uC
 rSKY4dlfSLD2OZ8h5xcGQwjPHudyhHczJea5DaDX53f2jPWHAy/Mp3uSrYY5WBGURMLmF4EtdX3
 lXkoGJii5ydThyOdJm3A+pMJ6uMLl1bH/+z9Z/tov
X-Gm-Gg: ASbGnctFmK4vIospNJV+Nw5m7Z5vgGGOLoJm1pKdlYu7wfKDMahAB+DYTESLCTX8oJv
 GrWv2wUPLW+SJVAKUJ0zQxYbGuav/Ccp0ur+0LSf/K4f9VWIkuB9LW77RL/3dwhsm7jweEJVC6f
 0bUzyJ7bh4I2KSL6E8yGi08HvSMAxvASPxHcIz7W03X8D371OO7W0zDU1l2Ae7i/KA6RPFm/KQ7
 owLhmievcxf+w9eIpSaxdEzh/Zy+CF7Wi30vFXINwDwsGIT2XqorjhOuqspouelDeqBNfKo1Yay
 ULG9jVD+
X-Google-Smtp-Source: AGHT+IF3oi22bg7bwo7wRG9tMkjxs1F+bWWoPaWJIGzjckpTLbNjFNB0IVLjpnhe33yj21dqh3dz3B/yLND8WrBhS0U=
X-Received: by 2002:a17:907:1c13:b0:b70:4f7d:24f8 with SMTP id
 a640c23a62f3a-b79c22e3201mr439034766b.22.1764705974807; Tue, 02 Dec 2025
 12:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
In-Reply-To: <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Dec 2025 20:06:02 +0000
X-Gm-Features: AWmQ_bkWnyH-DB5dRMpCpJMEHAt_9uVtDQVu00fnuXMxTJ41BzkfEdeoygeKuuc
Message-ID: <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
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

On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 11/25/25 11:15 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> This adds a test that signs a FIT and verifies the signature with
> >> fit_check_sign.
> >>
> >> OpenSSL engines are typically for signing with external HW so it's not
> >> that straight-forward to simulate.
> >>
> >> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
> >> 4096 private key is made available. It can be selected by setting the
> >> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
> >> the engine is detected by OpenSSL, which works by setting the
> >> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
> >> is properly implementing what is expected from an RSA engine, but it
> >> seems to be enough for testing.
> >>
> >> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
> >> without specific hardware. The keypairs and tokens are generated on the
> >> fly. The "prod" token is generated with a different PIN (1234 instead of
> >> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
> >>
> >> Binman will not mess with the local SoftHSMv2 setup as it will only use
> >> tokens from a per-test temporary directory enforced via the temporary
> >> configuration file set via SOFTHSM2_CONF env variable in the tests. The
> >> files created in the input dir should NOT be named the same as it is
> >> shared between all tests in the same process (which is all tests when
> >> running binman with -P 1 or with -T).
> >>
> >> Once signed, it's checked with fit_check_sign with the associated
> >> certificate.
> >>
> >> Finally, a new softhsm2_util bintool is added so that we can initialize
> >> the token and import keypairs. On Debian, the package also brings
> >> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
> >> is not the only package required though, as it also needs p11-kit and
> >> libengine-pkcs11-openssl (the latter bringing the former). We can detect
> >> if it's properly installed by running openssl engine dynamic -c pkcs11.
> >> If that fails, we simply skip the test.
> >> The package is installed in the CI container by default.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >>   tools/binman/btool/softhsm2_util.py                |  21 ++
> >>   tools/binman/ftest.py                              | 223 +++++++++++++++++++++
> >>   tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> >>   tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
> >>   .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
> >>   .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
> >>   .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
> >>   tools/binman/test/340_openssl.conf                 |  10 +
> >>   tools/binman/test/340_softhsm2.conf                |  16 ++
> >>   tools/binman/test/Makefile                         |   6 +-
> >>   tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
> >>   11 files changed, 853 insertions(+), 1 deletion(-)
> >
> > Not sure of the changes from last time, but I assume the test coverage
> > is finished.
> >
>
> They are listed in the cover letter in the Changes section.
>
> $ b4 diff -v 2 3 --
> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t
>
> will show you the git-range-diff between both versions for a given commit.

I normally review just in email (often on a Chromebook) so I don't
have that. It is also an extra step and I don't know where your log
argument comes from. It would be better to put the change log in the
patch as well.

>
> Yes, both the tests (parallel by default) and test coverage (single
> thread/process) pass now. You can verify this for yourself by fetching
> the code with
>

OK great!

> $ b4 shazam
> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t
>
> and follow the instructions from the .gitlab-ci.yml file in the job
> named "Run binman, buildman, dtoc, Kconfig and patman testsuites" up
> till "./tools/binman/binman ${TOOLPATH} test -T" from within the CI
> container. e.g.
>
> podman run -it --rm --userns=keep-id -w $PWD -v $PWD:$PWD --pull always
> docker.io/trini/u-boot-gitlab-ci-runner:noble-20251001-14Nov2025
>
> > Not important, but I think instead of:
> >
> > +            self.assertIsNotNone(signature)
> >
> > we typically do: self.assertTrue(signature)
> >
> > and for:
> >
> > +            self.assertIsNotNone(signature.props.get('value'))
> >
> > self.assertIn('value', signature.props)
> >
>
> Both copied from testFitSignSimple() which uses self.assertIsNotNone().
> I like having the "shared" code implemented the same way so that if
> there's an issue in one test we can hopefully easily spot the same error
> in others and fix them in one go. It's also seldom used on nodes in
> tools/binman/ftest.py, 3 out of the 29 times it appears in the file.
> self.assertIsNotNone() is used on nodes 17 out of the 26 times it
> appears in the file.

That's fine.

Regards,
Simon
