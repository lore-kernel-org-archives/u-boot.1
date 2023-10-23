Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B50AC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACB3878A5;
	Mon, 23 Oct 2023 09:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cb+4h6Bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403B8874C0; Mon, 23 Oct 2023 09:05:44 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A0B87794
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso430315766b.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044741; x=1698649541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DHSAk6swL/KhTyxHXTJ95lEtzcVb3p0L1Pg/PcUxVK8=;
 b=Cb+4h6Blvj6AfEYZJc7HaD4ONVqesCeM4LdUP1l3iKFJ7X4ikFos2ZbpeM2msUI8nY
 p+msg0H4/RaKaHN35Gt6AkX4ToWv+FE3kF9dtUulKSKcXBO4FgTrxjdue8a6QeHJNItV
 drS0xFErzW1ndP+12tCTYw2Ysn+zf6nKl6Los=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044741; x=1698649541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHSAk6swL/KhTyxHXTJ95lEtzcVb3p0L1Pg/PcUxVK8=;
 b=A+NK7e+v5RFRjLkex4n0bNHf4qDlhDPxH4kBRl2Q/Dqy+vs2HPDmyN9xvmuePU4G4Y
 Cf0pSaH1Fm50P2W8Zng5JWXYyrNgAy2nYgAnc4n39Ey/d4E85ys4w4afwdiuchsOupBv
 GyBNq5OwPdt/jc2HXV/Bk0yo75pXs3wroUZ7pnBHE1xjUenm5LZYTIfMEz7gH6GuIACl
 DB6624+ZWF7gI/vXA6L1UTVTJ5lVqmqqPnXbTQs6pNbvtuLghjTxcEabmMo0PsL3Y4Ao
 Hdrv9U2YRN05Y9OGL5Ql3IECvvxukafPbo4dOfZy4Yyx4HBrnYVWdnZ3fRP2HFI9hyEW
 hiDQ==
X-Gm-Message-State: AOJu0YwtMfyA6jPdVddGEk0wM8r3a7n4H6oZEEBYwPpSNhiCdG5De+xA
 X7xv5sdsP8rJpGPi+vJ9Is6E5Oy3ifuK1IXVRFFrjndaXoKlJq3P2/jyMU/f
X-Google-Smtp-Source: AGHT+IF03ze1djgzj0b+CKadcd30lSgNfWXbXIpjzckI15c4vBlNoTEFEyFGNmrrGf3tTH/FFlT8oYC6/GPpSHzlZJs=
X-Received: by 2002:a17:907:9623:b0:9ae:6da8:1819 with SMTP id
 gb35-20020a170907962300b009ae6da81819mr5840396ejc.48.1698044740739; Mon, 23
 Oct 2023 00:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat> <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
 <20231022234507.GE496310@bill-the-cat>
In-Reply-To: <20231022234507.GE496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 00:05:28 -0700
Message-ID: <CAPnjgZ14he2OtnvfEXsbN1FxGz34twDwAMROM=61kcOJpGvDXw@mail.gmail.com>
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

Hi Tom,

On Sun, 22 Oct 2023 at 16:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 22, 2023 at 02:55:32PM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v2)
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > > > > > > > > >
> > > > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > > > > > > > > > >       depends on BLK
> > > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > > > >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > > > > > > > > > > >       select CHARSET
> > > > > > > > > > >
> > > > > > > > > > > Does this work for you Heinrich, or do you want to clarify the
> > > > > > > > > > > dependencies (and re-organize the code as needed) around networking?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > We should be able to boot via EFI on devices without U-Boot network support.
> > > > > > > > > >
> > > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=y selects
> > > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > > >
> > > > > > > > > > Why is this not sufficient?
> > > > > > > > > > Is there a configuration that does not build?
> > > > > > > > >
> > > > > > > > > The point of this series is to disable CMDLINE and fix up what breaks.
> > > > > > > > >
> > > > > > > > > In this case we have some sort of breakage...perhaps Tom has already
> > > > > > > > > found it, but otherwise could you take a look?
> > > > > > > > >
> > > > > > > > > We should be able to disable NET and LTO in sandbox and still build.
> > > > > > > > > But this fails at present[1]. You can try it on -master
> > > > > > > >
> > > > > > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > > >
> > > > > > > Strange that it only happens on the non-LTO board, though?
> > > > > >
> > > > > > There's two issues. The first of which is that I think you need to
> > > > > > re-check your error exactly? With my series, and LTO also disabled the
> > > > > > problem is a call to efi_get_image_parameters() as that's defined in
> > > > > > cmd/bootefi.c, but also only used with cmdline invocations. So we can
> > > > > > fix that CMDLINE=n && LTO=n case with a IS_ENABLED(CONFIG_CMDLINE)
> > > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > > >
> > > > > > The second issue is that with LTO we more completely find the cases
> > > > > > where if x() calls y() and y() is undefined but nothing calls x() we can
> > > > > > just discard x() and not care that y() is undefined.
> > > > > >
> > > > >
> > > > > I will send a patch for function efi_dp_from_eth().
> > > >
> > > > There's no problem with efi_dp_from_eth as far as I can tell.
> > > >
> > > > > @Simon
> > > > >
> > > > > One thing that I don't understand is why we don't let the linker
> > > > > eliminate the unused functions on the sandbox.
> > > > >
> > > > > On other architectures we put each function into a separate text section
> > > > > and let the linker eliminate the unused text sections:
> > > > >
> > > > > arch/riscv/config.mk:29:
> > > > > PLATFORM_RELFLAGS       += -fno-common -ffunction-sections -fdata-sections
> > > > > LDFLAGS_u-boot          += --gc-sections -static -pie
> > > > >
> > > > > Shouldn't we keep the sandbox close to what other architectures do?
> > > >
> > > > Oh my, I didn't realize that sandbox was missing the garbage collection
> > > > stuff.  Yes, that needs to be fixed first, then we can see what's next
> > > > to change, as there are some issues (my series first fixed CMDLINE=n on
> > > > qemu_arm64).
> > >
> > > My super quick pass at enabling
> > > function-sections/data-sections/gc-sections shows there's nothing
> > > further needed for CMDLINE=n and LTO=n on sandbox, not even the part I
> > > was looking at before.
> >
> > I am not sure about the original reason, but sandbox probably
> > pre-dates wholesale enabling of gc-sections (I haven't looked). There
> > is also the issue of whether the host toolchain supports it. Sandbox
> > is supposed to run on a variety of OS types.
>
> It doesn't predate gc-sections, we've just never moved it to the
> top-level Makefiles (and disabled on LTO) like we should have a long
> time ago.  It's supported by all the compilers we support, and it's a
> required feature (or, LTO) for U-Boot.

Remember that the sandbox linker script is special in that it adds to
the existing default one provided by the toolchain

>
> > I am also not sure of the point ot it...since it is normally pretty
> > easy to use Kconfig to control features.
>
> That's not the point of the feature.  The point is that we can discard
> unused code without having to rely on #ifdef and __maybe_unused.

That doesn't match with my understanding. An unused static will still
produce a warning if it is unused.

Re #ifdef, you will still see code discarded with sandbox if  'if
IS_ENABLED()' is used. It's just that the link-time

Sandbox doesn't really have a need to discard unused code. It doesn't
make much difference to the binary size, from what I can see, partly
because we enable as much as we can.

No LTO:
before: 3652159 220840 126576 3999575 3d0757 /tmp/b/sandbox/u-boot
after: 3515872 204016 124528 3844416 3aa940 /tmp/b/sandbox/u-boot
Saving 3.7%

With LTO:
before: 3391148 212224 124704 3728076 38e2cc /tmp/b/sandbox/u-boot
after: 3356324 200664 124704 3681692 382d9c /tmp/b/sandbox/u-boot
Saving 1%

That reflects the fact that LTO is quite a bit more powerful than linker hacks.

The other thing I have noticed over the years is that linker
discarding can change behaviour when unrelated changes are made. For
example, if I refactor a function the linker decides that a function
it calls is now needed, whereas before it was not. That sort of thing
is annoying with sandbox.

>
> > At least for me 'u-boot -D' doesn't work with Heinrich's patch. Do we
> > really need to make this change? It will rapidly devolve to the point
> > that coming back would be extremely painful.
>
> Do we absolutely need which, gc-sections or LTO? Yes, we do.  And I
> don't see immediately how that changes --default_fdt ?

I hope that with all the clang effort we might be closer to having
sandbox behave well with this change. But I still don't see the point.

Regards,
SImon
