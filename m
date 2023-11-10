Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79FC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE42487632;
	Fri, 10 Nov 2023 12:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jr9hA7sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941AB8777F; Fri, 10 Nov 2023 12:56:23 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A059087585
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso3106312a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617380; x=1700222180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fWWPjOxqHKeAKLWSSfLUJpl1PiswQnaEKXMq+YB1SgI=;
 b=Jr9hA7sjLCGxIxa5aeywkUmDhMGjfSiry1jy9XnRY8HTERNkMcXme8wQoD36vW8c2n
 21oTHUcYnJj/XOm64bqqapA9IxGKZf7Pc6GZsPsxfoPZXkAAcl7Tcf0ZBIR3CmtPGTnT
 6ydLqfawoVds+tnRsUxfldEq7sNsYlf6TxVqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617380; x=1700222180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fWWPjOxqHKeAKLWSSfLUJpl1PiswQnaEKXMq+YB1SgI=;
 b=n6UNt5dA7rABxz5MEQ+meej/7VG1nR3UhiVbPgLp53SEar6vnV5b6s++KjXFmq/BH7
 Wp+dUSPrJ0Jz591wHe8F9akfMWn/Wv8VEYb2u0lcNCNFxPl4mEDX3u7dRcM3KoYjnIDh
 bGBJtAVblF3fxbxfVZwpLl632nL98OJ3psYTsXiVOsnj4PQJjeaFdcI/MmqWsfmQHXyc
 GlewS4Lw+dA1fHrs5JXAJJhILPL1MX0b8CjpI46p3ZPX7qZ3SBgVflwjePX/XXFBl6j4
 EdHNT9TluMh3+Ms+MsAVi/VR4ETT5HJoZZLqSlCv9Q+OMdzOqbBqfwAgJfaNMfeUb+Ht
 /ajA==
X-Gm-Message-State: AOJu0YzEtm+9rfRxpPt/1P1ilRtS6NMarpxUTWBSSXiGAEJkGRdbQsdg
 pOve5i/uc+D9FdNtZ3FJfUr/zJ77qG9c7OnXQrfKlw==
X-Google-Smtp-Source: AGHT+IF9DBJgi6YS6cU6Tr//GNSmCOtYAef66EXqOFVbHYkF5XNjyAwS38Wrhh84DkTw0xqD8Qix+tmbdhjuekzIGxo=
X-Received: by 2002:a17:907:bc5:b0:9e4:121c:b9fd with SMTP id
 ez5-20020a1709070bc500b009e4121cb9fdmr4173579ejc.12.1699617380057; Fri, 10
 Nov 2023 03:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
 <20231109192419.GH6601@bill-the-cat>
 <9525398a-1326-470e-9894-afb160cde2e6@canonical.com>
 <20231109204157.GI6601@bill-the-cat>
In-Reply-To: <20231109204157.GI6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:56:08 -0700
Message-ID: <CAPnjgZ0AQE3SdnpM-oQgwL7E9AeaqF8VFoAeqDyMF1dTof83tw@mail.gmail.com>
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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
