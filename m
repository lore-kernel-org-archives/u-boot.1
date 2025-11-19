Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0DCF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651CE83F4F;
	Wed, 19 Nov 2025 14:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RsHAqreD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183C183F60; Wed, 19 Nov 2025 14:16:53 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2172B83F4E
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b73161849e1so1242250566b.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558210; x=1764163010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3n7EdeGxZ7Cu8QLbXBfSGgtTE9EMYa0pIqncNuFpUYo=;
 b=RsHAqreDX4n3WEWV/m+o5ys2xXTplxrIEtnsvPW8A18zdHnbg0vZqC9CMGoxfjuc3M
 mXiZRIbL0Mz6MXEUMWhGk1Hu41csOTcBSWoKA1FHoHV4AqCXEI0fVBJoEhAS9RUUCVIF
 nIRt8YeSHmTUQqWL4vBoehplVXCZcNZ5e1Cq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558210; x=1764163010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n7EdeGxZ7Cu8QLbXBfSGgtTE9EMYa0pIqncNuFpUYo=;
 b=N7SF7aPlR6x8z/CyJEz14Bo5Xz9LjCDapbyF0DgU6jv/nlMPqB6aa4/4oIX3t0m+ea
 rxMtIxDL70op5fMTuluNL+xU33BsieF4IrxyTz2WsuJG0ClobFvXhYx4Un7jx2yBhIta
 VM9v6b8H/5/YtDi4kUOvM3yxXTMDCU8xmuyudKzMD9UOQhAT1iJ6KXQYfSYIucr9Lqt9
 8J2UOesoCK/D8mlQo5JqbFgPDbfmwc/LpzN1d95G1nGCFFOhFOfxnxLC3Rxr1xdXbdII
 aU3GXtGW3klHsvMjQWo1GsotLjsXYiPA6b2m7Cm2EtYf3xzLeoY7/PXOYoBmAKxXr5B3
 xhFQ==
X-Gm-Message-State: AOJu0YyaPhT00JT2h1pnL7dPCoeBMFoVIXV5nCQmMzDRYCxxAUOgvMs5
 naN0Vp40d2zqpJgUQ8TjMxvPFlXXIdkN4FseAk2WORtllEYo0egg73oJ8ta/r5YzGVrhSf142i6
 8lvKH6P8e1zLwQtI8sW20zobCtEGF4pGYsoDfGwf5
X-Gm-Gg: ASbGnctXJNX3SCBYEAQuM7oFki0YgLHaBESIsNMiAbrJ3MZKRwYNa4nq23LxAXd31qT
 TGPwEWpmnT2FYqH+e4xER27vdD5F0EhfgR0w95neK8te5i/23TH867kkUph4ORNqiVGpZz9pkdI
 XsasHT+Meg51OvGBXuKU7wwHuVxrZjsv92QryhmLNVtJGsC0HgmiV/3Gqgk/1azCuD8V+hmVx2Q
 4ttHl+jZduKDztlCDoxmTSbpUqtPa7Mq72v+yQqjur7jNyKdGXCfZMf7kQwiOTLoCb7VGKlqk9U
 hfF9
X-Google-Smtp-Source: AGHT+IH5mQur3CXj1YQolRm6sRYvzLYWBvu2TtqYjek9n4LwuqVw76zIGGwn4JCgclZKp8+Pq0vZOTzhvWAzSzcbLJ0=
X-Received: by 2002:a17:907:3f99:b0:b73:3f7d:3df with SMTP id
 a640c23a62f3a-b76379a1cf0mr240248466b.41.1763558210450; Wed, 19 Nov 2025
 05:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-4-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-4-e053f683c0b8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:22 -0700
X-Gm-Features: AWmQ_bmTwXIFrYwOFT5A3YRkwfmbJwGyV3iskAQK5hVCADH8-4CwelVl2r5rPtg
Message-ID: <CAFLszThA-qZt-mR6q=sDFkmcum4f5_=qjpFdMVvo1d8cUe+D+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tools: binman: fit: add tests for signing with an
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

On Mon, 17 Nov 2025 at 12:43, Quentin Schulz <foss+uboot@0leil.net> wrote:
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
> 1111) than the configured value in OpenSSL to force the use of
> fit,engine-keypair.
>
> Binman will not mess with the local SoftHSMv2 setup as it will only use
> tokens from a temporary directory enforced via the temporary
> configuration file set via SOFTHSM2_CONF env variable in the tests.
>
> Once signed, it's checked with fit_check_sign with the associated
> certificate.
>
> Finally, a new softhsm2_util bintool is added so that we can initialize
> the token and import keypairs. On Debian, the package also brings
> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
> is not the only package required though, as it also needs p11-kit and
> libengine-pkcs11-openssl (the latter bringing the former, only the
> latter is explicitly installed), which we can detect with openssl engine
> dynamic -c pkcs11. If that fails, we manually install the aforementioned
> library packages within tests.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/btool/softhsm2_util.py                |  21 +++
>  tools/binman/ftest.py                              | 193 +++++++++++++++++++++
>  tools/binman/test/340_dummy-rsa4096.crt            |  31 ++++
>  tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++++
>  .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++++
>  .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++++
>  tools/binman/test/340_openssl.conf                 |  10 ++
>  tools/binman/test/340_softhsm2.conf                |  16 ++
>  tools/binman/test/Makefile                         |   6 +-
>  tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++++
>  10 files changed, 723 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Looks like a solid test.
