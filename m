Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FF7C54FC6
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 05:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABED82B19;
	Mon, 26 May 2025 07:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ma3DzBLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C40D782B2F; Mon, 26 May 2025 07:19:37 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A8382B0F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6045a8a59c5so1968010a12.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 22:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748236775; x=1748841575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3r2itxjQKL0HQbaCND1f551gCkCJOyls+HUKIMbGCnM=;
 b=Ma3DzBLqUbrO/hdm0uO7Cl/rJhGTnFIqi6lZWnUzCv+CutTT9dUrTouQWGfWhjYczb
 EIjDrP2nM6Wwm+8zsa2ZWOoVpcod8KLerG/mADQQHAByTNMahqTEFa4Y83paKcPex+pr
 p2aDjGCzxTbkprSnZ0OM02iHm4DaKUCa0bu9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748236775; x=1748841575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3r2itxjQKL0HQbaCND1f551gCkCJOyls+HUKIMbGCnM=;
 b=qzX84Z8r5zqIQN9nIvJ+uLzxuyjAUUBoICO9+jZB5uvI4896/7yDSIa32dZ///Z3e+
 uEkWKYVqgQhkgDPJk7cPh9Aw1yXbCGm264fa4cbXoZut125J1z2akqPQseep+OM8lruo
 8hqLZ6BzMGrydVYhrOtfPipN9JnQSeEMj+hdNJUdaab3bWkcP0Zn5aAhP+zMMSG7Aeyi
 fkZTfPLxxEH3ZdwVxPvxjTedpMehUh/7xiNVWrdpfMfvVYaaKtuHQXRljfZVpkUGYd11
 0CYDVxkwmmw/xv/SM9wz1u0Q7Gs9K9y4ZvIhep+QZcpAtniZfrLJQwdiizyDxoaTCMuG
 hHOQ==
X-Gm-Message-State: AOJu0YyVia+lzNy74ceq7mDGnOxAZFgLbMZv8T0KZ6FEfwBoFGm6Xbzt
 HzSZqrWLx+0U30cUWxbXeLlk/f6hfkv9SOQDV/3ry0tx/4ADe/Hc5yybvsytx+vrtZp2VL2qjsz
 /MmYUz1nciaTgLEcdZ6vCA04pLeQ6WAWUq/XRt1Rj
X-Gm-Gg: ASbGnctU96YfpFgJqUPFqe7OBDa3xQvo7h7iXJmZGfZ7J+SYG+eRAWkI0skeB6z7HtW
 IxiJSQ+DEEQfGOxMkXhYpWeLKZReWdOB60PeGEQb6r2zWIn+AxUjSVCBXyBupMwY7/z/WnPYiLX
 ExYAw1KLaeD1rwhkU//aHGb6Akbj1z+dy8QyDrgWdNBw==
X-Google-Smtp-Source: AGHT+IFHRUreClrkZxjcR4dAgoq9TLhhBPG8kAtWwAHUy1HjkUtFvXVtSG9X3qrZ5dodTrht8F9lS7BkkcM/JQ2Frms=
X-Received: by 2002:a17:906:1f4c:b0:ad2:1a63:3ba4 with SMTP id
 a640c23a62f3a-ad85b3071b1mr409820066b.37.1748236774929; Sun, 25 May 2025
 22:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250524130642.902486-1-sjg@chromium.org>
 <20250524142307.GE100073@bill-the-cat>
In-Reply-To: <20250524142307.GE100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 06:19:22 +0100
X-Gm-Features: AX0GCFuKyeqszj0A5fiSQ6tOdO84H42PSI7YR6ITAppcplVJudvfiun9Rok9AA4
Message-ID: <CAFLszThmgQobz+r82TJj5Owc1eeQr+Vm9e_sfFkq+YYb=33QeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tpm: Start to tidy up TPM tests
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Ilias,

On Sat, 24 May 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 07:06:33AM -0600, Simon Glass wrote:
>
> > This series is a starting point only. It tries to provide some direction
> > for how the TPM tests should be run on real hardware and on sandbox.
> >
> > For sandbox, things are relatively easy since the TPM is reset before
> > each test. Tests should start up the TPM before doing anything. Tests
> > can be run in parallel, which is fine because tests are independent.
> >
> > For real hardware, tests cannot be made independent, other than by
> > resetting the board, which if the hardware is correct, resets the TPM.
> > So there may be more work to do to figure that out. The approach taken
> > in this series for real hardware is to have a few tests which do init,
> > then have the rest of the tests assume that the init is done. Tests
> > that depend on the TPM already being inited can use 'tpm autostart'
> > which works OK on sandbox and real hardware.
> >
> > Changes in v3:
> > - Use 'check' instead of 'test' when naming test helpers
> > - Add missing tpm_self_test_full() call
> > - Add new patch to skip failing tests on coral
> >
> > Changes in v2:
> > - Keep test_tpm2_continue_self_test()
> >
> > Simon Glass (4):
> >   tpm: sandbox: Support self-test continue in emulator
> >   tpm: Convert sandbox-focussed tests to C
> >   tpm: Drop unwanted special cases for sandbox
> >   test: tpm: Skip failing tests on coral
> >
> >  drivers/tpm/tpm_tis_sandbox.c |  1 +
> >  test/dm/tpm.c                 | 77 ++++++++++++++++++++++++++++++-
> >  test/py/tests/test_tpm2.py    | 86 ++++++-----------------------------
> >  3 files changed, 89 insertions(+), 75 deletions(-)
> >
> > --
> > 2.43.0
> >
> > base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
> > branch: tpm3
>
> This is not based on mainline, please stop posting things like this.

This applies cleanly to Tom's tree.

You've reviewed patches 1 and 3. I updated patch 2 based on your
comments, so let me know if you have any further thoughts.

I'd plan to apply this (or a later version) to my tree as well so that
coral TPM tests pass.

BTW I got the LetsTrust TPM so should be able to add this to my lab in
the next few weeks.

Regards,
Simon
