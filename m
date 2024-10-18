Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC2CD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3110C8924B;
	Fri, 18 Oct 2024 17:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gvnOyJk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CD88924B; Fri, 18 Oct 2024 17:03:18 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AF5891E7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so1212254a91.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263787; x=1729868587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3MlJL72/8wsXGMKNtKoNzlezVEE3W/jxY8mkUNPiaA=;
 b=gvnOyJk9nqzWYd78XMiaLaQWvRA1+CCgeDBWzE7vZJZnVk7FZOw+djTJwe67IF0QJ8
 8jv3HyvjdYO8TUS3cgx8iMgqV4VFZSzAb0ApqFytz8xg3+AFJMExPBY6MH3NQZRgBL2q
 pR8/Dvmsf9osVZHKr0pZXRX7fo3k/iGhziIEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263787; x=1729868587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3MlJL72/8wsXGMKNtKoNzlezVEE3W/jxY8mkUNPiaA=;
 b=h6hfqZK12/T8M8tHXv2COr9xiOzmLK52MarrMtG93edzcqRnJKq/u2n3zp2LYI94PG
 EXzohh+aicWcJ4vUV0iSAlw+7OOpHpY+N3qdDyiHti/mvIetvQ6vhmHi9y7isBm20cAn
 w2FHUzmoA/jaE3fFNtoBs0mfSA8FOjJYdDVYH7Q2PiVZqiNC9ccFfYRJIVqm1AajArVD
 YgUbkxurfieJAOGJv74zDTuGc8nya38hf3B/ZOea1/PyWm7FwNKm6Xs/Sc/ATyIw18zC
 OrTpemrqgp4hPCCVIOzYNoJJieeg0zmqGMDmPc+gcBCkPRzXNwxGfAhvRHIsBZY09TSZ
 3pfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEPzqR+ZGIopFMMVDIM5AkZW8bpmX4AAIjehw5+D/AcrcQadLewlxoBAZQ6uH+KCH6NNXfLIk=@lists.denx.de
X-Gm-Message-State: AOJu0YyRDVdGyn/NeK0BOFVnM/F5AQb3C2qTBMCh2VVoioevYAMhobUD
 Ii0TIW4ExHpfE0Ltkfgj2oZkfjzQ2EP18vAQwYJesDHWhCbrMb9YCSEtelcArQMsjxnKeugpE6e
 jAGj56tMIPy+WoDW1P66KkmCwyg8gK4coN0oe
X-Google-Smtp-Source: AGHT+IF8kW2hCbP9PhmqicBSQAcISWPlivQ2YFyfKlZk2+9Vzvx4ua7oaTVq5f5iyfayxsNGVd37eGlX9GPtj0S5c+A=
X-Received: by 2002:a17:90a:f692:b0:2e2:a661:596a with SMTP id
 98e67ed59e1d1-2e561612e13mr3133506a91.13.1729263787483; Fri, 18 Oct 2024
 08:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:02:54 -0600
Message-ID: <CAFLszTjL0VfVJZsu34ik2uX8D_qpdiuW=OXoiromA1gOJ2vxLg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Enable https for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 08:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since lwIP and mbedTLS have been merged turning on https:// support is
> relatively easy. We need to enable the missing algorithms and modes of
> operation in mbedTLS and enable TLS in lwIP. Someof the lwIP patches
> are in their github as PRS, but since they haven't been merged yet, we
> need to carry them for a while
>
> patch#1 enables the crypto algorithms we need in mbedTLS
> patches#2, #3 enable anf fix the lwIP part we need
> patch#4 is adding https:// parsing support in our wget
> patch#5 is making https:// the default for QEMU lwip defconfig so
> people can easily test
> and finaly patch#6 updates our documentation
>
> Ilias Apalodimas (4):
>   mbedtls: Enable TLS 1.2 support
>   net: lwip: Enable https:// support for wget
>   configs: Enable htts for wget on qemu arm64
>   doc: uefi: Describe UEFI HTTPs boot
>
> Javier Tia (2):
>   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
>   net: lwip: Add Support Server Name Indication support
>
>  cmd/Kconfig                                   | 19 +++++
>  configs/qemu_arm64_lwip_defconfig             |  1 +
>  doc/develop/uefi/uefi.rst                     | 45 ++++++++++-
>  lib/lwip/Makefile                             |  3 +
>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 50 +++++++-----
>  lib/lwip/lwip/src/core/tcp_out.c              | 10 +--
>  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
>  lib/lwip/u-boot/lwipopts.h                    |  6 ++
>  lib/mbedtls/Kconfig                           | 12 +++
>  lib/mbedtls/Makefile                          | 33 +++++++-
>  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++++
>  net/lwip/Kconfig                              |  2 +-
>  net/lwip/wget.c                               | 78 +++++++++++++++++--
>  13 files changed, 273 insertions(+), 40 deletions(-)
>
> --
> 2.45.2
>

Can we create a sandbox build with lwip as well? I'd really like to
get that testing moving, so we can test simple networking cases, as we
do without lwip.

Regards,
Simon
