Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1BDFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08FC846A1;
	Mon,  4 May 2026 22:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzZ2fQtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19EC6846DB; Mon,  4 May 2026 22:30:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62A7846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso850013666b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926621; cv=none;
 d=google.com; s=arc-20240605;
 b=CcWEkR4B7fjYEMSP/ee9Ddas12yFY7oMISTHWh0cutjs8V9S9Xy6VSe72advm5ilRV
 ldppVwaWXMdjhKXBeh64FIzcOOBgD/wZ+TXckXTh80D4iwWFRXZPxUeq64FB7Bl1cfxU
 dK6MIm3RzvmY15HgA2ZMahLsj2AL8cjucVUnBeOqQoAudJueCvhjfx90LIB88htVeCZO
 IZiWRFAYzXZN4vHv0J2TPwWJUGz7uFQV8vM8g/eEL1L78IFQvwl/UjvnxQ+N+Pdw1xz7
 HO1yomEh6HN34zW8KLX2aJzzCr/CZST7S/RoHsM7Et553Yg9kamCMjaKpdBjwJRRit8q
 h0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QhvG7127G9OsF2+d8tB3ZZsMdqpPU2a7/4ONLjhSAqU=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=Z9RNuwbnBJ+I9Yt69c/NSftJli+wQszBJPSPFlIjt5ja8WUvgQRQTjFlvaF8w8/p41
 tGLJIcDZUCeAPY4frArMYAR1BPRX4XOMYN5+8dGV6dydnC336jmBOSjj5ha4TOYIqvo7
 GB4RzLq0tymbXoRHu/VTcfgvwlbrEM4taXBXoxJ1+WXENqSn4zaqf0ZPZIso0OGE4S6U
 2pGkEuW6H71cWpK4n6SUqaRaWr3nIv9G08B2qq9ciROXvn79tGA1wG9f11+GVT9/eieW
 SWW1vfDc8hWk1N9mNXYPOucR+UfVKIay6hR4iyH5NzKehnbFc+IIHfIOTXb6QvE0fGDS
 Ny4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926621; x=1778531421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhvG7127G9OsF2+d8tB3ZZsMdqpPU2a7/4ONLjhSAqU=;
 b=kzZ2fQtvNMg9i5iNhvbaWLZERTd4EQ/ENwTCL11ASloSCDzFB5BpjeCcQ7CiwvEiuu
 jBSvr60PRR5j+M2n7TxfFCCf4BsUtVK7wN/LLpgyH0xnSe0tP1E0lRdgH1n+xLnfUEEU
 qUSiwaGSg4zRx2uiR7BI5zhSqpY6GzzUYHmXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926621; x=1778531421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhvG7127G9OsF2+d8tB3ZZsMdqpPU2a7/4ONLjhSAqU=;
 b=e8riUrcB0wVDpo1kCYUkWN4EKpwZQkSo3UpCv3oU2ClyYf7iQJOiBCkS+jvMzzN72J
 kRBOhshXo7P3KvbTqy51YcCquHx6hV4BaldwRLoO5M1Qv/uNrNjOQp29v20q8L6fz/8k
 wKm6mJbUzo+4zZrRBv9O81PgMxoSkCAcN6RYhMAPXJHQ07nQCR9oaDp9T6/VrpGNCv9E
 4Z0P3IEHkllLK/cHASlbWjPtHU8bZST+6+Iz6AfNRIMTDOw9UYbletfJt3ewtDbQepbD
 SeIhBfuGdWOja7mcjxHNx05UJcNohOhUwjjzRF7p9OmQZItcE+CGp75FeM7s4d4hPGUz
 adtA==
X-Gm-Message-State: AOJu0Yx5Y6lsON6ij1jwqeqVacfOXyy/obPvCvqaaRYkVV/porJM/uVk
 px1HnQe6bR8BAwr4y2NixyN368GYkKwLXoPKl79FHtb+wsvCLUqCBS+N1fl0L8dEaCzz8pE2Kup
 EhbDERmBFL+jiXTyWvQzHOM4ivEgTb7b/c7CjitGB
X-Gm-Gg: AeBDievUMin/9xrMl3j92sTqFPj1QJiPEiHasThKDcBh1UGWNc3oJ2KNkAopTKiQq/J
 IxQ9Dpn6S/O5gzcLxgrGutS4vPIv+2WMzY2wRfMaPimb3OM6LpLQh63qShnPNRPBDWJ6JID4T52
 8LVWG+IPA1Q5Vvwe5XrPhiXQGLd3nRrMl0mxHVt9LvLKXCXMjL0Of10mjafpys+khYjJAuVBlGY
 mI96YmKnSYLcCkohz9kYnmrQ75iPJsU7EaemNz81LBFqfBKNfZNQKtKRZQUOyr6nVl534DvwPJ8
 t3uIqzP4XhOrE7Bw
X-Received: by 2002:a17:907:968d:b0:bc1:d3d2:9348 with SMTP id
 a640c23a62f3a-bc3d143a281mr53401866b.20.1777926621176; Mon, 04 May 2026
 13:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-1-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-1-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:08 -0600
X-Gm-Features: AVHnY4Lwp29UdizwyBjVSwD6Vw_AQZZn44RATZ5fn6hS9YqgbgMwUNfLd_eHclw
Message-ID: <CAFLszTi8c+CoR1_kuXEeauwae7f_1huRKt6W9daeCHPz63VzrA@mail.gmail.com>
Subject: Re: [PATCH RFC next 01/18] test/py: add pytest --make-args argument
 for additional Make arguments
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> test/py: add pytest --make-args argument for additional Make arguments
>
> We manually execute make commands within some tests, sometimes from
> 'dirty' build directories.
>
> One example is the test_env_initial_env_file test which calls
> make u-boot-initial-env
> in a build directory that has already been populated possibly before
> pytest is run (which is the case in our GitLab CI/CD).
>
> In "sandbox with clang test.py" and "sandbox64 with clang test.py" we
> build before pytest with clang-20 but pytest will call make without
> setting HOSTCC or CC to clang-20, which results in clang flags being
> used with gcc. Right now, it isn't triggering a build issue because we
> use cc-disable-warning to disable the warning only if it's available, so
> the clang flags aren't added. However, in a few commits we'll bump
> scripts/Makefile.extrawarn to a newer version from the Linux kernel
> (6.1) and it won't be used anymore, thus triggering fails.
>
> Add an option to specify make arguments such that a user can provide
> HOSTCC and CC for when the build directory to reuse has been built with
> clang.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> test/py/conftest.py                 | 6 ++++--
>  test/py/tests/test_cleanup_build.py | 4 ++--
>  test/py/tests/test_env.py           | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
