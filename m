Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6DFC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64EE487899;
	Wed, 13 Dec 2023 21:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kC7TNqie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773C2878AD; Wed, 13 Dec 2023 21:39:32 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361AE878AD
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1f5cb80a91so841439766b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499969; x=1703104769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ra8SfaJqszg+Qp/1hQkUZcxBpTXPH9kMBl6ASfNlr5w=;
 b=kC7TNqiexD+QhlAEu5g/V5CD4f3UrhFRceKon2B84/qxwUkOcvWiyHWcvotGLEj0so
 dGxrsZ8yfYn32Ml6tRgwgz0hpelHUpOXbEbC3dnNjNIuk64NZSrPlhGzt90nErs+s7gO
 MMGzlEoTVKUB52f5ZW5SW4NPaD8ps+KNuGdA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499969; x=1703104769;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ra8SfaJqszg+Qp/1hQkUZcxBpTXPH9kMBl6ASfNlr5w=;
 b=HTnpM5lURoSXJrKZSTwEheRdbHu0T7QCH8ny6fn5WFSiWGl4lreYUawhS/0ZFCjjWi
 qwF4uNvHHLkwQqqOCmC7ZVuD6fGnzwzNnd37KTavqsBsPvwjP3y/ZTfDLojo8tDeylHo
 +IVeOwqZtgbDkTjx5QH/c0UIOqtqjwPYz7mVt0ZrEj7gmlml7zfhrv3Mc2e8/0Iw1uaF
 LoPCe99EHER4O5yHqONqSvT/JLlXZaCAKeu1/jhevMyUBLxv5xRidiJcvVGtcEZsIeAS
 pbyFNMF57f0BUT3j8JVBBth6sb2d4w+xoTLtMGgAZdXmiP9yWDeSaCY6zVNk0fEaix+O
 FR3w==
X-Gm-Message-State: AOJu0YwMhQ+sSxiU8i45c0G0FXNEPmigwIsJPtAIfottzLDsRfdLye2X
 lMIw6TlEKZlX0A0w+WeNN88hwFrD91sGSxcBhi0UVQ==
X-Google-Smtp-Source: AGHT+IFHBsZlhSJdejN3MebEbl4nRLmcQUPZ0qxtdeHeP2ZaMFJ6Lh+Hy+0d6FXN8OJi43poyqH8dshB6xrn4ZSwYZI=
X-Received: by 2002:a17:906:6d4d:b0:a19:a19b:4244 with SMTP id
 a13-20020a1709066d4d00b00a19a19b4244mr2716366ejt.175.1702499969545; Wed, 13
 Dec 2023 12:39:29 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:28 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0AQE3SdnpM-oQgwL7E9AeaqF8VFoAeqDyMF1dTof83tw@mail.gmail.com>
References: <CAPnjgZ0AQE3SdnpM-oQgwL7E9AeaqF8VFoAeqDyMF1dTof83tw@mail.gmail.com>
 <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
 <20231109192419.GH6601@bill-the-cat>
 <9525398a-1326-470e-9894-afb160cde2e6@canonical.com>
 <20231109204157.GI6601@bill-the-cat>
Date: Wed, 13 Dec 2023 12:39:28 -0800
X-Google-Sender-Auth: IA9mTn3rgPswZk1LW2bHvp_ZsRM
Message-ID: <CAPnjgZ2ZQwu5fN80vS7GnoHRWL8+dnsNoZv=rFULwPxwcTEPZw@mail.gmail.com>
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
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

Hi Tom, Heinrich,

On Thu, 9 Nov 2023 at 13:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 09, 2023 at 12:28:26PM -0800, Heinrich Schuchardt wrote:
> > On 11/9/23 11:24, Tom Rini wrote:
> > > On Thu, Nov 09, 2023 at 09:23:02AM -0800, Heinrich Schuchardt wrote:
> > >
> > > > Function acpi_get_rsdp_addr() is needed on all architectures which
> > > > write ACPI tables. Move the definition from the x86 include to an
> > > > architecture independent one.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > ---
> > > >   arch/x86/include/asm/acpi_table.h | 9 ---------
> > > >   drivers/misc/qfw.c                | 1 +
> > > >   include/acpi/acpi_table.h         | 9 +++++++++
> > > >   3 files changed, 10 insertions(+), 9 deletions(-)
> > >
> > > My question here is, does this work right on non-x86? I know you can
> > > have ACPI without UEFI on x86, but elsewhere doesn't the location have
> > > to be provided in some manner by UEFI? I know I'm thinking that's the
> > > case with SMBIOS (with a few exception).
> > >
> > > I'm assuming you're doing something here with qemu and its qfw interface
> > > and risc-v.
> > >
> >
> > Hello Tom,
> >
> > yes, I want to enable ACPI passthrough on QEMU RISC-V. There will be more
> > patches needed. But the current change seemed obvious looking at the code so
> > I did not want to pile up more patches first.
> >
> > Do you know what the status of ACPI passthrough is on ARM?
>
> On U-Boot? No. I know a while back I asked Simon to, and he did some
> hacking such that on a Raspberry Pi you could do UEFI boot and pass
> through some ACPI tables and it was somewhat functional (which was I
> think an issue with the ACPI tables as much as anything else). And I

Yes it worked OK, at least to a point. See [1]

> mentioned to some Linaro/EBBR people that it was because in part I don't
> object to U-Boot being able to do SystemReady ES level support either
> (and to be clear, I don't mean instead of, or preferred over IR, just
> that ES mandates ACPI and if we can pass it through .... and yes,
> there's more to it than that, I know).

This is what U-Boot does now when booted from coreboot. So it should
be fairly easy to arrange.

There is a blockage in Linux re booting with ACPI but without EFI,
though. I suppose it doesn't affect U-Boot right now since it can boot
with EFI, but it is causing problems with other projects.

>
> And yeah, I see now I had mis-interpreted the "rsdp" portion of the
> function name.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=274675&state=*

Applied to u-boot-dm/next, thanks!
