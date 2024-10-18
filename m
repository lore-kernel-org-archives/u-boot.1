Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC12D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B69D88C4D;
	Fri, 18 Oct 2024 17:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q4f+OO+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CD888C60; Fri, 18 Oct 2024 17:06:37 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971EC88C3E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so1573733a91.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729263994; x=1729868794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5bkOIagifkM8amYtTSN8T2m3DGlvL0NjNHIlC8oLL/U=;
 b=q4f+OO+k8LYAb/IcLZaG4oYGBJMtrpjcDKOC76GaIHTDK8arKGYAErnQnxwgcZvrNx
 O1qRpWvcEEOkVkdSanS7HajIvLMiJBNCvehU/oqFzJJjBmrtOy0brZlSHs7Di03+AqvS
 2a/mZx/WN2Pacx1jCMk4U9KJn/7eg2GPpy4mzIXo2oaBxuYQR3YwuACjgMb9ntm+FxGj
 kqsq3lrUzYmyz3Cns/3oYv/fZMqVv6G/dj9klIZq1kJI5VC9WmSkHz+JBS2IRD8LtygD
 Sb84xm7dSdE4l0XVvVLSKj7MCP6omvkfQowBnZTw1K2Dy2puGqi9Kt+v4kaVc8T558iB
 HBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263994; x=1729868794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bkOIagifkM8amYtTSN8T2m3DGlvL0NjNHIlC8oLL/U=;
 b=eXA2UxoDFfgE1okPdj3jdyJ7ahvFDLQzOl7At08hCRKxY8omhTyi9hOKI43AFK4Cdq
 CeL+jabO9/j2JkSDPA5y47GyMqxxWFIED20LWCY5MKuy8TgDgkXaYzcrbHdJ2qmNaTEK
 dGkhBrdhx/LyvCE4rCle13uUpeJA0PZzk2imc3gCS+p1iSTJVjwleSCbQpJVmucZ6dJC
 utiPZcZoUjgVD8/JBKIF9pMygopNXh8IINUJcKvdciM7tk0TT8cZ5WgOoMvbqz95ZlYJ
 hwvxUfeMvDvdb2S2EJOGmoDSA93n+OPTSZQEooovm/Et/lSMG65lch0GTklj20qijB3v
 OEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqLNbBduTLxSz8W8Cv2n2VE9kbytiKfewxd8YJ88p3u/KL9+3jxA5pa9iTq11taGcFAKYsAMA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf46mI5VFEuXv97LuTi5gftoIcBWbf/JS0D2VoSQnKyXFZvLro
 3Dv9ygaUOdZlisvEDzW+ehiibZo7KNDxQpmzdaWw38AGRwROEueJhLpNEypUQVxAX1nvXM+Ncao
 UEoqO9jTlUQhaeymvIw+OCSo9lyqaGaPzHH5Vjg==
X-Google-Smtp-Source: AGHT+IEXoREiRNNgMtYyMGpgvB4Txcy3CMRY2Ayk7yClr3p9JbdYHVNB2SGMKLM1uHITAns2WbEfr8bU2/ivqJu7mO8=
X-Received: by 2002:a17:90b:33cd:b0:2e1:8a41:aaba with SMTP id
 98e67ed59e1d1-2e3dc5d69f2mr10609336a91.19.1729263994040; Fri, 18 Oct 2024
 08:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <CAFLszTjL0VfVJZsu34ik2uX8D_qpdiuW=OXoiromA1gOJ2vxLg@mail.gmail.com>
In-Reply-To: <CAFLszTjL0VfVJZsu34ik2uX8D_qpdiuW=OXoiromA1gOJ2vxLg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Oct 2024 18:05:56 +0300
Message-ID: <CAC_iWjKMo7=RE3=1=y3MpgC95itO170ruJYk6omh-4NuAJ8SRA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Enable https for wget
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, 18 Oct 2024 at 18:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 18 Oct 2024 at 08:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Since lwIP and mbedTLS have been merged turning on https:// support is
> > relatively easy. We need to enable the missing algorithms and modes of
> > operation in mbedTLS and enable TLS in lwIP. Someof the lwIP patches
> > are in their github as PRS, but since they haven't been merged yet, we
> > need to carry them for a while
> >
> > patch#1 enables the crypto algorithms we need in mbedTLS
> > patches#2, #3 enable anf fix the lwIP part we need
> > patch#4 is adding https:// parsing support in our wget
> > patch#5 is making https:// the default for QEMU lwip defconfig so
> > people can easily test
> > and finaly patch#6 updates our documentation
> >
> > Ilias Apalodimas (4):
> >   mbedtls: Enable TLS 1.2 support
> >   net: lwip: Enable https:// support for wget
> >   configs: Enable htts for wget on qemu arm64
> >   doc: uefi: Describe UEFI HTTPs boot
> >
> > Javier Tia (2):
> >   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
> >   net: lwip: Add Support Server Name Indication support
> >
> >  cmd/Kconfig                                   | 19 +++++
> >  configs/qemu_arm64_lwip_defconfig             |  1 +
> >  doc/develop/uefi/uefi.rst                     | 45 ++++++++++-
> >  lib/lwip/Makefile                             |  3 +
> >  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 50 +++++++-----
> >  lib/lwip/lwip/src/core/tcp_out.c              | 10 +--
> >  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
> >  lib/lwip/u-boot/lwipopts.h                    |  6 ++
> >  lib/mbedtls/Kconfig                           | 12 +++
> >  lib/mbedtls/Makefile                          | 33 +++++++-
> >  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++++
> >  net/lwip/Kconfig                              |  2 +-
> >  net/lwip/wget.c                               | 78 +++++++++++++++++--
> >  13 files changed, 273 insertions(+), 40 deletions(-)
> >
> > --
> > 2.45.2
> >
>
> Can we create a sandbox build with lwip as well? I'd really like to
> get that testing moving, so we can test simple networking cases, as we
> do without lwip.
>

Someone is already on it. But it's going to take some time as the
current sandbox stack makes too many assumption for the backing TCP
stack

Thanks
/Ilias
> Regards,
> Simon
