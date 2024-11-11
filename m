Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3167FD2E9FF
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC9E88815;
	Mon, 11 Nov 2024 15:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MraCEvI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BC888C4C; Mon, 11 Nov 2024 15:07:26 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FCC88599
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so3681705a91.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731334042; x=1731938842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMeZ+qqbO/nYOPpNGIjGDmzQ4V0I25Y/RxkXtZXDC1s=;
 b=MraCEvI0QEiPPTQoeToGlFGqznvSenJdxUQ20Y3MrFsSyL8yA77UAdk5HBhNW1srAS
 mfk0Yvl4Rh3TeMgNYvh1YgfQ7SFq5sWAA9MgazsfXrcvam25COpsQacn0ShRm2z55huK
 G5hLPgrEqKwQwtOTeFGYBKkHZ4gbe76HW5oojsVfgI3sqCwwQDxAYKQ9jCnQd33d8e9n
 PleNPerEMKWs09Z1OUTy6bo+DxbZQm5aa6o4C3JDtrWdi8U9QuktuWrWQ4SrVdSDYpS/
 YpGia2rX+NzEBa2KcLwFHOjZSvPDpyFU4CUSjrKlbM5qYbZyNJGS9AGULF/8/F0oR50O
 DWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731334042; x=1731938842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMeZ+qqbO/nYOPpNGIjGDmzQ4V0I25Y/RxkXtZXDC1s=;
 b=weL6x87uHNJmNZLXL0Bb2/r2Emr7GAcle9rCn1orQHRsDp36kb5tYQlQhxHFz/TG+y
 pxMs8YKIJvuymEZly/7RI4HvSTN5/kTuVeRteT1JfDRtImFEVe/qjlvaRlRb/kqJuTKq
 ZXYYlf8WTPS8ufePVaq2P4J34MzYTEZuElezH9yHoIoT0L2SYLSXGQIJQ4sJkkCgMK08
 TWO4m1vet/On9IgHMgb994IMXgoBMm7oeuwTkfGX2ecoqncfjwKuC/Rs+pPzZH4OJr1x
 vQlBUCP9zEPJgDyQ2Qky0IU6i5AQWpvXILcRbsTim2YFMoqa8AJ6okEQ/cO11ClRJvMo
 flJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZMYC1QCSCtS+Mfl+gZDKsiuPsl/58FF5YOzrfiJXue6O+Gt0iio6xVSfer1TzlaLlj5dulGM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4IvZ+ur6dnHIchGf5ilCk+K48x3q3SjscmT4PfIdna/LCKaXR
 kCZAXKiZdqMITWZk05iUhVTzltRalZpfQmG9eRwlNzbQcY8HA4EZ4LaV2u63Ro6od64kQhPY1ni
 QNeU9H8Xl9RsEWf9MWEqW0a11VG816JunwKnJ+Q==
X-Google-Smtp-Source: AGHT+IHRuftmjCWxGh1YDyj3Ej/Pou9jjF/IJOeTF9Bwc0pTRyyc7DQX/aTDwoAPu8rn44QnoWPadACjfox8B+5irlg=
X-Received: by 2002:a17:90b:3809:b0:2e2:b17a:b118 with SMTP id
 98e67ed59e1d1-2e9b178ee78mr16608667a91.32.1731334042452; Mon, 11 Nov 2024
 06:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <CAFLszTjxOTvckDzO0-Shda7q+rcKxCLQF7+8Zpmm8eLiXNLKwQ@mail.gmail.com>
In-Reply-To: <CAFLszTjxOTvckDzO0-Shda7q+rcKxCLQF7+8Zpmm8eLiXNLKwQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 16:06:46 +0200
Message-ID: <CAC_iWj+Xn6YCxWs9k8-LUOAU3HLnLPHG-CF8FMxGOmmDzxA88g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6]
To: Simon Glass <sjg@chromium.org>
Cc: jerome.forissier@linaro.org, Anton.Antonov@arm.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
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

On Mon, 11 Nov 2024 at 15:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Sun, 10 Nov 2024 at 01:31, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > This is a respin of [1] adding https support to wget. In short
> >
> > patch#1 enables the crypto algorithms we need in mbedTLS
> > patches#2, #3 enable anf fix the lwIP part we need
> > patch#4 is adding https:// parsing support in our wget
> > patch#5 is making https:// the default for QEMU lwip defconfig so
> > people can easily test
> > and finaly patch#6 updates our documentation
> >
> > [1] https://lore.kernel.org/u-boot/20241024112449.1362319-1-ilias.apalodimas@linaro.org/
> >
> >
> > Changes since v2:
> > - Use a bool variable for https:// support instead of relying on the port number
> > - changed a memcpy to strlcpy to avoid reading extra bytes from the source buffer
> > - Removed unrelated whitespace fixes
> > - CONFIG_IS_ENABLED -> IS_ENABLED on mbedTLS header file
> > - Add r-b tags by Jerome
> >
> > Changes since v1:
> > - re-arranged the Makefile objects so they only get compiled when TLS ie enabled
> > - Fix all the applicable remarks Simon had on the wget patches
> > - Fixed the title of a patch pointer out by Peter
> > - Rebased on -master
> > - Collected r-b tags
> >
> > Ilias Apalodimas (4):
> >   mbedtls: Enable TLS 1.2 support
> >   net: lwip: Enable https:// support for wget
> >   configs: Enable https for wget on qemu arm64
> >   doc: uefi: Describe UEFI HTTPs boot
> >
> > Javier Tia (2):
> >   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
> >   net: lwip: Add Support Server Name Indication support
> >
> >  cmd/Kconfig                                   | 19 ++++
> >  configs/qemu_arm64_lwip_defconfig             |  1 +
> >  doc/develop/uefi/uefi.rst                     | 45 +++++++++-
> >  lib/lwip/Makefile                             |  3 +
> >  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 49 +++++++----
> >  lib/lwip/lwip/src/core/tcp_out.c              |  8 --
> >  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
> >  lib/lwip/u-boot/lwipopts.h                    |  6 ++
> >  lib/mbedtls/Kconfig                           | 12 +++
> >  lib/mbedtls/Makefile                          | 31 +++++++
> >  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++
> >  net/lwip/Kconfig                              |  2 +-
> >  net/lwip/wget.c                               | 86 +++++++++++++++++--
> >  13 files changed, 277 insertions(+), 39 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Can you also please update doc/usage/cmd/wget ?
>
> Also test/cmd/wget ?

Sure. Do you mind if I do this on a followup series? I want this to
land in 2025.01. I can send a followup on this within the week

Thanks
/Ilias
>
> Regards,
> Simon
