Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F96CD10362
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 22:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78CB84159;
	Tue, 25 Nov 2025 23:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JV2jtwf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F04384154; Tue, 25 Nov 2025 23:15:25 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2061C84154
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso10244472a12.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764108922; x=1764713722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8Qv2P46PUorLTylr5C9+YCygJ7WxxmK+aeG7Fo6iTE=;
 b=JV2jtwf8TVBPE9bPXeaqjcuJd3WDjG+okS97X5xq3jB4jqN0f2EkaoPSL1BTEJNf9/
 dEGbroye2Q18wDkoNedR5CeXUW+Uk7Watj4doC/64ekr7n4lDKXi9OSR8S5/g5FoU0Jc
 4BkE89FsQLQjN2dV4EKsmKlVAI0GofFkakD8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764108922; x=1764713722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8Qv2P46PUorLTylr5C9+YCygJ7WxxmK+aeG7Fo6iTE=;
 b=cDQ/SmOfQ8gdfLk131VSZx4+TfA3jSQRbzmhaNNpBTjUc3JVLLkpZer4BzvLegq0yD
 C34LrDSwXGJOUFvcK6TeCdGEzOdX22SsJPWendFeBoULrkbNG1qVVA4eutF+VVdt1PIB
 Een9uHQsn5jlH/b102eTRmSuyJ9vZkVbWtyW8bOz0atSOvHmwOc6YUP4VurESLIs+Lyf
 1d185vYbU/+iYKq0CKEvjzpUwWeLhd85GbhxrL3dnB4jsujvFlPNrspo2n03sQGqplfZ
 WPk9X8K4Y8MjIK3fvGwneg2XiYWdwpyoizjN+/ySr2QctuaBMSDouba/za63ukwmTcnQ
 B1Gw==
X-Gm-Message-State: AOJu0Yz9D6za+ykLkYZVqKnHzWB3T92SnEJGCPtJJPM6KDz6QBO69BbD
 6LWzwj6XqgWTBtdJR/WEWxYv6HwHBdTxFs0fWxqtLy2o6QjSm967exEmUcL3bXBMxdMk+EZADPL
 R0H2x45K+Hd3HODoee+im8GA3OqxDCc87gF9NX+CZ
X-Gm-Gg: ASbGncsPpMG1PIbq4bgXQ4o3XqCTFSJ2Tvb1Ffk9FjO/h2BXpA+JCpU8kroUu05pYMa
 saygsv8CVIXgzK7YYdSiagRHyeLlF82JSxNhnAneFs7pWLwmKtUXXEpK4glMIgmVlts6PelLXD4
 PzHANUUArn3G/RaXQ5jUZf9cif0S/XW5LYkKRddn8ptY18zr6UjECBA9KowdTRxXitaQAM6ULIv
 vG9z5iw1L78iPuoe6qbIng47K4qs4MvutG2vXW6jNrMLVq4NezwWyUMPw4VGzlH5FtE9g==
X-Google-Smtp-Source: AGHT+IFmOIaHKQhX+1hdpzyPv+DpbJBH+bzUlvA2CR4PAv2wwX4eziiAfSGGxgqag61mYnRCgPYujVYCndtsp6UbIrc=
X-Received: by 2002:a17:907:928e:b0:b73:6931:558a with SMTP id
 a640c23a62f3a-b76715aba52mr2035800966b.18.1764108922563; Tue, 25 Nov 2025
 14:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
In-Reply-To: <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Nov 2025 15:15:02 -0700
X-Gm-Features: AWmQ_blV5ssnZbICSLFZA8dymaaJOLg-0uj6zsrTJzr2QGHBYnvkbvqT-vhFtWI
Message-ID: <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
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
 Yannic Moog <y.moog@phytec.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This adds a test that signs a FIT and verifies the signature with
> fit_check_sign.
>
> OpenSSL engines are typically for signing with external HW so it's not
> that straight-forward to simulate.
>
> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
> 4096 private key is made available. It can be selected by setting the
> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
> the engine is detected by OpenSSL, which works by setting the
> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
> is properly implementing what is expected from an RSA engine, but it
> seems to be enough for testing.
>
> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
> without specific hardware. The keypairs and tokens are generated on the
> fly. The "prod" token is generated with a different PIN (1234 instead of
> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
>
> Binman will not mess with the local SoftHSMv2 setup as it will only use
> tokens from a per-test temporary directory enforced via the temporary
> configuration file set via SOFTHSM2_CONF env variable in the tests. The
> files created in the input dir should NOT be named the same as it is
> shared between all tests in the same process (which is all tests when
> running binman with -P 1 or with -T).
>
> Once signed, it's checked with fit_check_sign with the associated
> certificate.
>
> Finally, a new softhsm2_util bintool is added so that we can initialize
> the token and import keypairs. On Debian, the package also brings
> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
> is not the only package required though, as it also needs p11-kit and
> libengine-pkcs11-openssl (the latter bringing the former). We can detect
> if it's properly installed by running openssl engine dynamic -c pkcs11.
> If that fails, we simply skip the test.
> The package is installed in the CI container by default.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/btool/softhsm2_util.py                |  21 ++
>  tools/binman/ftest.py                              | 223 +++++++++++++++++++++
>  tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
>  tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
>  .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
>  .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
>  .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
>  tools/binman/test/340_openssl.conf                 |  10 +
>  tools/binman/test/340_softhsm2.conf                |  16 ++
>  tools/binman/test/Makefile                         |   6 +-
>  tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
>  11 files changed, 853 insertions(+), 1 deletion(-)

Not sure of the changes from last time, but I assume the test coverage
is finished.

Not important, but I think instead of:

+            self.assertIsNotNone(signature)

we typically do: self.assertTrue(signature)

and for:

+            self.assertIsNotNone(signature.props.get('value'))

self.assertIn('value', signature.props)

Regards,
Simon
