Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9836C0032E
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 21:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB61877C3;
	Sun, 22 Oct 2023 23:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C9fATU1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0B5877D1; Sun, 22 Oct 2023 23:55:53 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22CF9875AF
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 23:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso3994747a12.3
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698011750; x=1698616550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFfoo0vQe+y8zTTlhJ0yu6vFZ2LUnDu6FGUJD2L08Vg=;
 b=C9fATU1Ca7zKSaRHm+VpAuaBKV1+yLGneUljxWgmbxVmgQF/HS53526fGgqr8xNrbp
 0VW0dlHrS6aSA/ZpKvq66Bi0jWy6Bv0zqa5Ilt2vu+M3dsITiHLlxnB8HIgiXu7XR90j
 vijgnmxwV63vJNntINxCzPGwUOEuIH8kkvR9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698011750; x=1698616550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFfoo0vQe+y8zTTlhJ0yu6vFZ2LUnDu6FGUJD2L08Vg=;
 b=r3O4oG1fD8gUq9UOm/UP5TEtemviZLCsczyOh5UcKdmXiGhOt6v0/73er60o5xikNz
 V05Pi/CfrJTuJSpWTi75SZbEs79QSiNhgZPq/JxPMz+f9wJIMERCgt414HYmrDGioy+G
 2/4sJI4ETDyq19ufX1dQgyCh/q2cmKBs9aAJqJ6NHOMBXccihwP6x6Yxr/k9xr97hiYr
 C6IvdthSLnpSkxaypzdknlepo/QmZmAujnTP3bdHf0TGs5lL1GAJTRMt7pQBrTzgTvDY
 m/tkTX329IEav6y9afdepKedrt/TU2dirB543TzOdqLt0IZxtQXhikvl19yoytAewUng
 Xwtg==
X-Gm-Message-State: AOJu0Yy6BLyxAsOXYXVne/9aDs2sDnu7LZh0RMzF+ORT7PbPbJ8douQ0
 XqdCf85cJXU0STOrYoaX8hOQgVsNx9cL03DfdRyf7Q==
X-Google-Smtp-Source: AGHT+IG9D8w7fNiKtcnW619zzmiXa3TgJZoG2otuXqwz4xAAr2rKT0KCxpZJ0OyYME2n2DLSvjMvELQ6ydTqYpYLemc=
X-Received: by 2002:a17:906:4784:b0:9be:315d:e607 with SMTP id
 cw4-20020a170906478400b009be315de607mr6292144ejc.28.1698011750280; Sun, 22
 Oct 2023 14:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat> <20231022145857.GB496310@bill-the-cat>
In-Reply-To: <20231022145857.GB496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 22 Oct 2023 14:55:32 -0700
Message-ID: <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > > On 10/21/23 20:26, Tom Rini wrote:
> > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v2)
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > > > > > > >
> > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > > > > > > > >       depends on BLK
> > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > > > > > > > > >       select CHARSET
> > > > > > > > >
> > > > > > > > > Does this work for you Heinrich, or do you want to clarify the
> > > > > > > > > dependencies (and re-organize the code as needed) around networking?
> > > > > > > > >
> > > > > > > >
> > > > > > > > We should be able to boot via EFI on devices without U-Boot network support.
> > > > > > > >
> > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=y selects
> > > > > > > > CONFIG_DM_ETH.
> > > > > > > >
> > > > > > > > Why is this not sufficient?
> > > > > > > > Is there a configuration that does not build?
> > > > > > >
> > > > > > > The point of this series is to disable CMDLINE and fix up what breaks.
> > > > > > >
> > > > > > > In this case we have some sort of breakage...perhaps Tom has already
> > > > > > > found it, but otherwise could you take a look?
> > > > > > >
> > > > > > > We should be able to disable NET and LTO in sandbox and still build.
> > > > > > > But this fails at present[1]. You can try it on -master
> > > > > >
> > > > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > Then, we could drop "depends on DM_ETH".
> > > > >
> > > > > Strange that it only happens on the non-LTO board, though?
> > > >
> > > > There's two issues. The first of which is that I think you need to
> > > > re-check your error exactly? With my series, and LTO also disabled the
> > > > problem is a call to efi_get_image_parameters() as that's defined in
> > > > cmd/bootefi.c, but also only used with cmdline invocations. So we can
> > > > fix that CMDLINE=n && LTO=n case with a IS_ENABLED(CONFIG_CMDLINE)
> > > > around that, and then discard efi_dp_from_name() entirely.
> > > >
> > > > The second issue is that with LTO we more completely find the cases
> > > > where if x() calls y() and y() is undefined but nothing calls x() we can
> > > > just discard x() and not care that y() is undefined.
> > > >
> > >
> > > I will send a patch for function efi_dp_from_eth().
> >
> > There's no problem with efi_dp_from_eth as far as I can tell.
> >
> > > @Simon
> > >
> > > One thing that I don't understand is why we don't let the linker
> > > eliminate the unused functions on the sandbox.
> > >
> > > On other architectures we put each function into a separate text section
> > > and let the linker eliminate the unused text sections:
> > >
> > > arch/riscv/config.mk:29:
> > > PLATFORM_RELFLAGS       += -fno-common -ffunction-sections -fdata-sections
> > > LDFLAGS_u-boot          += --gc-sections -static -pie
> > >
> > > Shouldn't we keep the sandbox close to what other architectures do?
> >
> > Oh my, I didn't realize that sandbox was missing the garbage collection
> > stuff.  Yes, that needs to be fixed first, then we can see what's next
> > to change, as there are some issues (my series first fixed CMDLINE=n on
> > qemu_arm64).
>
> My super quick pass at enabling
> function-sections/data-sections/gc-sections shows there's nothing
> further needed for CMDLINE=n and LTO=n on sandbox, not even the part I
> was looking at before.

I am not sure about the original reason, but sandbox probably
pre-dates wholesale enabling of gc-sections (I haven't looked). There
is also the issue of whether the host toolchain supports it. Sandbox
is supposed to run on a variety of OS types.

I am also not sure of the point ot it...since it is normally pretty
easy to use Kconfig to control features.

At least for me 'u-boot -D' doesn't work with Heinrich's patch. Do we
really need to make this change? It will rapidly devolve to the point
that coming back would be extremely painful.

Regards,
Simon
