Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21094D2E9F0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8917C889D2;
	Mon, 11 Nov 2024 15:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZiNCAdAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5342689318; Mon, 11 Nov 2024 15:13:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E1188599
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso669926066b.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731334393; x=1731939193; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c6EItDNTuilfxqhEGJQQ83mBiw3YwTzI538GogHPYdw=;
 b=ZiNCAdACvblTqULqL0D/FxrkDnbKsACefCtlhPrX3kngDfqEWj0xQSRvlzIchGcpha
 yC9LC93ee2l//6B9HvNiFIrBENZxmwo4qb8zfM3zYSarJDcJWSn7dMD6lKIhFAoEcwii
 ZHyK7iDyxqKovwFtVK1CzsUAmzIYOxFk+vLTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731334393; x=1731939193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6EItDNTuilfxqhEGJQQ83mBiw3YwTzI538GogHPYdw=;
 b=DhVhnMO2qAyXlVHXCS7puZsug1PJvWeo1ALcGJ157EpT4dysT+0RLRIQx0yQBfjCuS
 bNPBkJJzD/EuFz1SmyXnKPTYEm4BE8nLOND4RiKJXpscDrSBAlsa4zHBYl17bgQouRfJ
 45jhv8/WRZkYPlctowKviBQJPV1sFAqxkJXtvf5SUQgfdOMcjio5pzvP4Htneh4alYSV
 /aN+Q/3s9SOn5/oKerhzzMaPhgw3GYIAHrO8WmXdPLeaSHUUWi02D4cBzqy9gTJ94ywZ
 RjvNUfDKfOdrCispOKgbTbG+2we6Fsgz+OZOXy5Z7vDMAFXMC/c9eW2uIrisDrTsxTAo
 zegg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPShv94OauKdES8HOKygaetlTReHfQ00HvRvLS75Hj/fveY7PHZyYEQ7fA08c7r2HYs/hvSwA=@lists.denx.de
X-Gm-Message-State: AOJu0YyQdE1NZX7ErVT2BFrZpxL0ckrg/ySbTT3hCVUgaPy6QIw+wOyu
 Q8fiCSddOLAdc2sLpU9/tdtgAe3jKiyqfUuV3kyme+63KvRg1y+1zeQZSrQRR3A23kCkXkqabtV
 4FKxm4MWaBOMm/qIwAK1y4XVo/Pz6YVzg997V
X-Google-Smtp-Source: AGHT+IGB54P+n3VcK9CdSYZ12pspRNRIJo+HuvPH3hBcwXcxVxG2utq3jVcEJzGCr0JMKznAF3n9XPrt+JXDPaLiD+I=
X-Received: by 2002:a17:907:7f2a:b0:a9e:2e72:f8f4 with SMTP id
 a640c23a62f3a-a9eefebd041mr1145724666b.1.1731334392671; Mon, 11 Nov 2024
 06:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <CAFLszTjxOTvckDzO0-Shda7q+rcKxCLQF7+8Zpmm8eLiXNLKwQ@mail.gmail.com>
 <CAC_iWj+Xn6YCxWs9k8-LUOAU3HLnLPHG-CF8FMxGOmmDzxA88g@mail.gmail.com>
In-Reply-To: <CAC_iWj+Xn6YCxWs9k8-LUOAU3HLnLPHG-CF8FMxGOmmDzxA88g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 07:12:59 -0700
Message-ID: <CAFLszTjkZnK6mFLjEiYRLTCgr9H1F3FhRyuLvgu5_hOhkGAJgw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6]
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Mon, 11 Nov 2024 at 07:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 11 Nov 2024 at 15:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Sun, 10 Nov 2024 at 01:31, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > This is a respin of [1] adding https support to wget. In short
> > >
> > > patch#1 enables the crypto algorithms we need in mbedTLS
> > > patches#2, #3 enable anf fix the lwIP part we need
> > > patch#4 is adding https:// parsing support in our wget
> > > patch#5 is making https:// the default for QEMU lwip defconfig so
> > > people can easily test
> > > and finaly patch#6 updates our documentation
> > >
> > > [1] https://lore.kernel.org/u-boot/20241024112449.1362319-1-ilias.apalodimas@linaro.org/
> > >
> > >
> > > Changes since v2:
> > > - Use a bool variable for https:// support instead of relying on the port number
> > > - changed a memcpy to strlcpy to avoid reading extra bytes from the source buffer
> > > - Removed unrelated whitespace fixes
> > > - CONFIG_IS_ENABLED -> IS_ENABLED on mbedTLS header file
> > > - Add r-b tags by Jerome
> > >
> > > Changes since v1:
> > > - re-arranged the Makefile objects so they only get compiled when TLS ie enabled
> > > - Fix all the applicable remarks Simon had on the wget patches
> > > - Fixed the title of a patch pointer out by Peter
> > > - Rebased on -master
> > > - Collected r-b tags
> > >
> > > Ilias Apalodimas (4):
> > >   mbedtls: Enable TLS 1.2 support
> > >   net: lwip: Enable https:// support for wget
> > >   configs: Enable https for wget on qemu arm64
> > >   doc: uefi: Describe UEFI HTTPs boot
> > >
> > > Javier Tia (2):
> > >   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
> > >   net: lwip: Add Support Server Name Indication support
> > >
> > >  cmd/Kconfig                                   | 19 ++++
> > >  configs/qemu_arm64_lwip_defconfig             |  1 +
> > >  doc/develop/uefi/uefi.rst                     | 45 +++++++++-
> > >  lib/lwip/Makefile                             |  3 +
> > >  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 49 +++++++----
> > >  lib/lwip/lwip/src/core/tcp_out.c              |  8 --
> > >  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
> > >  lib/lwip/u-boot/lwipopts.h                    |  6 ++
> > >  lib/mbedtls/Kconfig                           | 12 +++
> > >  lib/mbedtls/Makefile                          | 31 +++++++
> > >  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++
> > >  net/lwip/Kconfig                              |  2 +-
> > >  net/lwip/wget.c                               | 86 +++++++++++++++++--
> > >  13 files changed, 277 insertions(+), 39 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
> > Can you also please update doc/usage/cmd/wget ?
> >
> > Also test/cmd/wget ?
>
> Sure. Do you mind if I do this on a followup series? I want this to
> land in 2025.01. I can send a followup on this within the week

Yes that's fine with me.

Regards,
SImon
