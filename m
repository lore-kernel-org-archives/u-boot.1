Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E7CF9C5B
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 05:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D0F587B77;
	Mon, 23 Sep 2024 07:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gcB1PkgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8686E88D03; Mon, 23 Sep 2024 07:49:09 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5952588D08
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 07:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e03caab48a2so3284041276.1
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727070546; x=1727675346; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+GqPi7kvfkTPGuMQMG8mgU5U/TLnK6mH7U//v/3HNA=;
 b=gcB1PkgYxz1OZ6b0ZakC3Z55rKZMAfDY6fIrviMu7kU5NP6LDTykCpmxCELS7lYInG
 9j9/TxNylriitvJa28mXUPoOk3OV2xPoK8hTS7a4UwTLXyR7o8IzYojlbV+JKfygA8af
 Dsyi9n57IodFQlfpW6I4QajquI01zoyMR5gz3bIbM8uLDWXY/edpl1GMyfugDgeh84sL
 fDq7Y3oNsVzabdMzH1vl16KzQ0lx/YjpKFFJwBXhAujj9JGynpp7eAyc05ij0lb0vLkq
 J2AvtUr5K5gyr1eSRn0Op1dZXwjc/PKduV7KaZNfeRQfmSwFz2exy9H8jONIrUAB0v7o
 40dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727070546; x=1727675346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+GqPi7kvfkTPGuMQMG8mgU5U/TLnK6mH7U//v/3HNA=;
 b=bgzDq+0T9hnerqoBqExNDjik4+oOUPyjZq9A06fK9Rou0DsABdhhl4bMlg8p1tSYY7
 OXzcj0eN5VKGotd5ua/C9YG2gPGeOOi0xvwFQ5Frv+0DE2nNpTj8bu5/msLZWcEPpxiv
 MH+2Ds8Xgr1prGGsFbyTPIHojePbwRTe2FTv8rwzORgZjmU2a7l2d1vhZbHbP1oAFO2d
 swq+GsYzuy2CZ0Af43m3ATGsTTTb+I5mI8zPSDbrsPsuVF/iPnLNJUrjfRIAuuDOiBrb
 Toeftjsda+U3H/sh4W1yG9BL1qygl2aVZYEYIrifV08y1xVGj0/mxlIEjBhMqkDNgBfw
 BW9g==
X-Gm-Message-State: AOJu0YyNjg64IqZnRru1pgu+ysk1wOp6yc1EAMnEF0/E0V2teI+bSe3E
 DtgxNVYis5nuS+rKaRfGZATGFQIu0OxwfpicekZ2BZKqU7tBooi/cMX1WLpwIRjBwBroM4ffImD
 nbIJgkDa9GLsRAN5+Jxh4LekGZliDSrHQ5OCXHA==
X-Google-Smtp-Source: AGHT+IGogvUBK71VcziSAeD3QkSZcxwep197RhAXeoE1QftOmUyPSyvBzNM0uigg5+7kkyAXm2G0F1vRdwacY4hiI1I=
X-Received: by 2002:a05:6902:1705:b0:e21:70df:8a7 with SMTP id
 3f1490d57ef6-e2170df2261mr7346912276.23.1727070546152; Sun, 22 Sep 2024
 22:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-24-patrick.rudolph@9elements.com>
 <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
In-Reply-To: <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 23 Sep 2024 07:48:55 +0200
Message-ID: <CALNFmy2vWuHnJHXMozStYouPNGTCXWdkuG7fQkT7y-rgi5M4yw@mail.gmail.com>
Subject: Re: [PATCH v4 23/35] drivers/arm: Implement acpi_fill_madt
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Sep 19, 2024 at 4:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Fill the MADT table in the GICV3 driver and armv8 CPU driver to
> > drop SoC specific code. While the GIC only needs devicetree
> > data, the CPU driver needs additional information stored in
> > the cpu_plat struct.
> >
> > While on it update the only board making use of the existing
> > drivers and writing ACPI MADT in mainboard code.
> >
> > TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
> >       Booted on QEMU raspb4 using GICV2 driver model generated MADT.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > Changelog v4:
> > - Read everything from the DT
> > - Export armv8_cpu_fill_madt() to use it in other CPU drivers
> > - Depend on IRQ
> >
> > ---
> >  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/Kconfig       |  1 +
> >  drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/armv8_cpu.h   | 10 +++++
> >  4 files changed, 178 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> I'm still not sure why you are using u64 instead of ulong?

u64 is the type defined in the ACPI spec for the fields within the
ACPI MADT table.
It's also valid for 32-bit systems, even though this code is supposed
to run on 64-bit only.
