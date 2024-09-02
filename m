Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7831ECA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 09:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C50E7889A2;
	Mon,  2 Sep 2024 11:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JweLux3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0FE88A31; Mon,  2 Sep 2024 11:14:21 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72C4886E5
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 11:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-690e9001e01so35292427b3.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725268458; x=1725873258; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfsRPytpKTBnnpvj2bKdLwBaeATnpFxaPwQYlWuJFs0=;
 b=JweLux3JOAU6Lo+uwzhu/5ywsrEz/dU+nm28XRj8T8zvhHtRX2iYJePzeeShnX6Njs
 THY3EKPTwNzbpDFpX1+szaKgJ9lKTcGlaUnn8CgLlNIQBylVIaQhNpGS3wvXpokuJAZe
 m4mad+J7LLYNuNgkON1vk+OTjlOwsgO1ERo2afY95EjwPrU12vhLY6ait6JHbKBqF1pY
 I8+VyZcyeXaqmaAo6+ZzzuHGNUlSCA/vq/R1HrO2mIG57m+ZAWxx1PhFDzb42WJwGgpH
 2RCCZ0MT4t3YoBcoBxsRkkY5g0JsB/qtpGDG7XxvlQ2FHCd7cZElHClYOBohAb1gm03u
 Cl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725268458; x=1725873258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfsRPytpKTBnnpvj2bKdLwBaeATnpFxaPwQYlWuJFs0=;
 b=cYSU15iPZFfSkjBX+j8cFbSVCJ7anzY13Nqd4r7N7ezd7FPfr4TIqAKhjLnKApgxqz
 qzFZHqushCrB+Py7m9topA9rMhD5fNxSp2cJyrkqJLD6z2i9Fq34lHlNrmumhwRcavD3
 NgskYcvkYKvhnYmqN8SBm3Mhi0k5DaW+UhD0cBlSFrPu1xA/VUeqrSSbGvXhSl10tAAH
 ahxuM9FuL7vwUEFT7Njj7TsITY66TVmurAD0mplMxiro1v9XWapBwGEeHuCM5wOff0Bh
 aOnYZId8K/xFmbeQOZICJbuLhEB63kBkMxx/1exiqUR2IwJaS4olV9gRpHubwvdns1aD
 k1Qg==
X-Gm-Message-State: AOJu0Yyq3CiqaGYk9w/4fNCPKcfOp7Y/YaKYwjuqn/fFTm02m/tJhOhU
 zt6fCRYywLZshN5b15o0J+7LkP8Jtk55UlnjtE1UCwcy/UT+tKl89eq8Y0fz7m5aZzFJBO9MkwE
 K7TEtAsB+W4h8lyBKWmk+SXCQt+AR/bH2atDZGktH693mKAAQTas=
X-Google-Smtp-Source: AGHT+IFKQA5kpaUXje7VE+iAQSL++wEPUWw4KgTUI8C5P4//DZzCUqRLSr1edU1RHJkq6BCDZ6LnULxl+FyV9oZTTlY=
X-Received: by 2002:a05:690c:3744:b0:6b8:d8a2:7aa8 with SMTP id
 00721157ae682-6d40f9264f4mr114807427b3.23.1725268458565; Mon, 02 Sep 2024
 02:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-4-patrick.rudolph@9elements.com>
 <CAFLszThVGswtjS5+1T8Ot0G1LYa9p6XaZpLpX3c5vOhDAKHQqw@mail.gmail.com>
In-Reply-To: <CAFLszThVGswtjS5+1T8Ot0G1LYa9p6XaZpLpX3c5vOhDAKHQqw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 2 Sep 2024 11:14:07 +0200
Message-ID: <CALNFmy3zBpeZsofSbUuZmjkM2a5Ek=ySboGQ+ycxv8vjwRXC_Q@mail.gmail.com>
Subject: Re: [PATCH 03/17] acpi: x86: Move MADT to common code
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 29, 2024 at 5:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Write MADT in common code and let the SoC fill out the body by
> > calling acpi_fill_madt() which must be implemented at SoC level.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  arch/sandbox/lib/Makefile         |  9 +++---
> >  arch/sandbox/lib/acpi_table.c     |  7 +++++
> >  arch/x86/cpu/intel_common/acpi.c  | 20 +++++++++-----
> >  arch/x86/cpu/tangier/acpi.c       |  6 +++-
> >  arch/x86/include/asm/acpi_table.h |  3 +-
> >  arch/x86/lib/acpi_table.c         | 46 ++++++-------------------------
> >  include/acpi/acpi_table.h         | 11 ++++++++
> >  lib/acpi/acpi_table.c             | 31 +++++++++++++++++++++
> >  8 files changed, 81 insertions(+), 52 deletions(-)
> >  create mode 100644 arch/sandbox/lib/acpi_table.c
>
> Same comment as previous patch.
While it might be possible to write out GICC and LAPIC or X2APIC using
a CPU driver,
how would the other sub-tables integrate into the acpi_ops?

On x86 you have ioapic and irq_overrides and on arm GICR and ITS sub-tables=
.
Would I need to add "Interrupt controller" drivers for each platform,
fill it with platform specific data
and then fill out the MADT table using acpi_ops?

While that seems nice to have, it would be quite a lot of work, since
none of the interface
or drivers exists at the moment.
It even looks like not all platforms even use a CPU driver and even
less use an interrupt controller
driver...

>
> Regards,
> Simon
