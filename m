Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A8C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB5487973;
	Tue, 24 Oct 2023 20:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F+WFH5Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39488726A; Tue, 24 Oct 2023 20:02:37 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8656487983
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so7396702a12.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170554; x=1698775354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zHyV6DsznvcaBjMxO9ng1CFsmVn5mM9VO+zo/PwmVoQ=;
 b=F+WFH5SfyG/l5oe4SXzIr2yP9IQP/nyWypSw3+kmgmPDwvbcqdl8S9hdjEHcQN5qWj
 pypxhg0ji1riPdB80QrYeB+7ZE1hcAxYGZNTu/guDYahi2kF3U7o5JHctiWKaPF98pUB
 jHHiG4rI95ZEFF4qaKEVPJIbef74a5XbCEuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170554; x=1698775354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHyV6DsznvcaBjMxO9ng1CFsmVn5mM9VO+zo/PwmVoQ=;
 b=bUgPpXYF+Q4z2a+OubrKMnLRgjCl39RzQwdAb2Vn63KTFuKzTl40THhyPcaPTb/b8D
 siVeGQmtlWIcwaldyRFVafqXstanKLJH7C9DYfeFhbSmvDBrKlhh+4OIMJ/qjsVEMU7w
 WXmdhvAWX4ErQurWqOOwILt9fJePKgAvwP0NA5K75xuVMvKYn9OIQXMMHkOYFkN5YO/8
 /4uHCLprccLIRO6lz0SA5K5Q1ZJT1WoOnTJHwumQ9QiSoOGo+l3VooGJgL1O1rdwGv6W
 +nV9uC4FDNnilsMBq8/9Pb63RaN4Yktn2ZDXV6CQUeoCz3rStLJrTwE5U2csFY8xfYWF
 QVqA==
X-Gm-Message-State: AOJu0YxtVRL8khacOL0ablDp7dDb1nRlirBpOgHAVHjgehgj9lW3JDrN
 HYXj61GzuvObSLHKuYjzqjVh6aYXWiI9bpXwjEj7r/UR15yzrw8gIGDjT4z7
X-Google-Smtp-Source: AGHT+IGoKfniIBaJahBEwSjadUdcqxyKBJPd1B4w+SaVkSd4jGL5/3FRHc7PR/SgqQiYFw9p5hoO9zZ9yrE++2VFXMU=
X-Received: by 2002:a05:6402:3512:b0:53e:775e:9761 with SMTP id
 b18-20020a056402351200b0053e775e9761mr10925011edd.36.1698170553726; Tue, 24
 Oct 2023 11:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat> <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
 <20231022234507.GE496310@bill-the-cat>
 <CAPnjgZ14he2OtnvfEXsbN1FxGz34twDwAMROM=61kcOJpGvDXw@mail.gmail.com>
 <20231023131623.GG496310@bill-the-cat>
 <CAPnjgZ1x7PyTe=nr5jguRjLbCeKqEBsV8EpQ-yC=sAx_bwt0SA@mail.gmail.com>
 <20231023174527.GW496310@bill-the-cat>
In-Reply-To: <20231023174527.GW496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:02:21 -0700
Message-ID: <CAPnjgZ1U=+TJjNJ--13LUTrz1T8C1yOsb0ReAK_dY-ZNjgwO_Q@mail.gmail.com>
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

On Mon, 23 Oct 2023 at 10:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 10:13:54AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 23 Oct 2023 at 06:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 12:05:28AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 22 Oct 2023 at 16:45, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Oct 22, 2023 at 02:55:32PM -0700, Simon Glass wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > > > > > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > > > > > > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > > > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > > > > > > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > (no changes since v2)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > > > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > > > > > > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > > > > > > > > > > > > > >       depends on BLK
> > > > > > > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > > > > > > > >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > > > > > > > > > > > > > > >       select CHARSET
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Does this work for you Heinrich, or do you want to clarify the
> > > > > > > > > > > > > > > dependencies (and re-organize the code as needed) around networking?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We should be able to boot via EFI on devices without U-Boot network support.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > > > > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=y selects
> > > > > > > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Why is this not sufficient?
> > > > > > > > > > > > > > Is there a configuration that does not build?
> > > > > > > > > > > > >
> > > > > > > > > > > > > The point of this series is to disable CMDLINE and fix up what breaks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > In this case we have some sort of breakage...perhaps Tom has already
> > > > > > > > > > > > > found it, but otherwise could you take a look?
> > > > > > > > > > > > >
> > > > > > > > > > > > > We should be able to disable NET and LTO in sandbox and still build.
> > > > > > > > > > > > > But this fails at present[1]. You can try it on -master
> > > > > > > > > > > >
> > > > > > > > > > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > > > > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > > > > > > >
> > > > > > > > > > > Strange that it only happens on the non-LTO board, though?
> > > > > > > > > >
> > > > > > > > > > There's two issues. The first of which is that I think you need to
> > > > > > > > > > re-check your error exactly? With my series, and LTO also disabled the
> > > > > > > > > > problem is a call to efi_get_image_parameters() as that's defined in
> > > > > > > > > > cmd/bootefi.c, but also only used with cmdline invocations. So we can
> > > > > > > > > > fix that CMDLINE=n && LTO=n case with a IS_ENABLED(CONFIG_CMDLINE)
> > > > > > > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > > > > > > >
> > > > > > > > > > The second issue is that with LTO we more completely find the cases
> > > > > > > > > > where if x() calls y() and y() is undefined but nothing calls x() we can
> > > > > > > > > > just discard x() and not care that y() is undefined.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I will send a patch for function efi_dp_from_eth().
> > > > > > > >
> > > > > > > > There's no problem with efi_dp_from_eth as far as I can tell.
> > > > > > > >
> > > > > > > > > @Simon
> > > > > > > > >
> > > > > > > > > One thing that I don't understand is why we don't let the linker
> > > > > > > > > eliminate the unused functions on the sandbox.
> > > > > > > > >
> > > > > > > > > On other architectures we put each function into a separate text section
> > > > > > > > > and let the linker eliminate the unused text sections:
> > > > > > > > >
> > > > > > > > > arch/riscv/config.mk:29:
> > > > > > > > > PLATFORM_RELFLAGS       += -fno-common -ffunction-sections -fdata-sections
> > > > > > > > > LDFLAGS_u-boot          += --gc-sections -static -pie
> > > > > > > > >
> > > > > > > > > Shouldn't we keep the sandbox close to what other architectures do?
> > > > > > > >
> > > > > > > > Oh my, I didn't realize that sandbox was missing the garbage collection
> > > > > > > > stuff.  Yes, that needs to be fixed first, then we can see what's next
> > > > > > > > to change, as there are some issues (my series first fixed CMDLINE=n on
> > > > > > > > qemu_arm64).
> > > > > > >
> > > > > > > My super quick pass at enabling
> > > > > > > function-sections/data-sections/gc-sections shows there's nothing
> > > > > > > further needed for CMDLINE=n and LTO=n on sandbox, not even the part I
> > > > > > > was looking at before.
> > > > > >
> > > > > > I am not sure about the original reason, but sandbox probably
> > > > > > pre-dates wholesale enabling of gc-sections (I haven't looked). There
> > > > > > is also the issue of whether the host toolchain supports it. Sandbox
> > > > > > is supposed to run on a variety of OS types.
> > > > >
> > > > > It doesn't predate gc-sections, we've just never moved it to the
> > > > > top-level Makefiles (and disabled on LTO) like we should have a long
> > > > > time ago.  It's supported by all the compilers we support, and it's a
> > > > > required feature (or, LTO) for U-Boot.
> > > >
> > > > Remember that the sandbox linker script is special in that it adds to
> > > > the existing default one provided by the toolchain
> > >
> > > Yes, and we've also been using gc-sections since 2008, from a quick look
> > > at the logs.
> >
> > Right, I just mean that sandbox does not use a standalone linker
> > script.
>
> Yes it does, arch/sandbox/cpu/u-boot.lds.
>
> > It is not common to garbage-collect sections in executables,
> > so far as I know.
>
> I'm not sure how that's relevant here, honestly. And we didn't ask the
> toolchain community to invent this for us, it's a standard feature that
> we've found helpful for a number of reasons.
>
> > > > > > I am also not sure of the point ot it...since it is normally pretty
> > > > > > easy to use Kconfig to control features.
> > > > >
> > > > > That's not the point of the feature.  The point is that we can discard
> > > > > unused code without having to rely on #ifdef and __maybe_unused.
> > > >
> > > > That doesn't match with my understanding. An unused static will still
> > > > produce a warning if it is unused.
> > >
> > > Yes, you're misunderstanding how this feature works and why it's
> > > required.  With v4 of my series, on sandbox and CMDLINE=n and LTO=n:
> > > /usr/bin/ld: boot/scene_textline.o: in function `scene_textline_send_key':
> > > /home/trini/work/u-boot/u-boot/boot/scene_textline.c:157: undefined reference to `cread_line_process_ch'
> > > /usr/bin/ld: boot/scene_textline.o: in function `scene_textline_open':
> > > /home/trini/work/u-boot/u-boot/boot/scene_textline.c:222: undefined reference to `cli_cread_init'
> > > /usr/bin/ld: common/bootstage.o: in function `bootstage_fdt_add_report':
> > > /home/trini/work/u-boot/u-boot/common/bootstage.c:323: undefined reference to `working_fdt'
> > > /usr/bin/ld: common/cli.o: in function `run_commandf':
> > > /home/trini/work/u-boot/u-boot/common/cli.c:154: undefined reference to `run_command'
> > > /usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
> > > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefined reference to `run_command'
> > > /usr/bin/ld: drivers/fastboot/fb_command.o: in function `fastboot_acmd_complete':
> > > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_command.c:350: undefined reference to `run_command'
> > > /usr/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_name':
> > > /home/trini/work/u-boot/u-boot/lib/efi_loader/efi_device_path.c:1095: undefined reference to `efi_get_image_parameters'
> > > /usr/bin/ld: net/net.o: in function `net_auto_load':
> > > /home/trini/work/u-boot/u-boot/net/net.c:349: undefined reference to `tftp_start'
> > > collect2: error: ld returned 1 exit status
> > >
> > > And with re-enabling gc-sections:
> > > /usr/bin/ld: drivers/fastboot/fb_common.o: in function `fastboot_boot':
> > > /home/trini/work/u-boot/u-boot/drivers/fastboot/fb_common.c:137: undefined reference to `run_command'
> > > collect2: error: ld returned 1 exit status
> > >
> > > Because all of those other link failures are in unreachable code and the
> > > rest of the code base is already setup to know that x() can call y() and
> > > y() can just be undefined at link time if x() is never called and ends
> > > up discarded.
> >
> > All of those problems were corrected by my series. Perhaps that
> > accounts for the difference between them?
>
> All of these are not real problems at this point in time is my point.
>
> > Just to take one example, working_fdt, while it might seem convenient
> > to leave it in cmd/fdt.c it doesn't actually make sense, since the var
> > is set when booting. Without that var DT fixups can't happen. So why
> > not pick up my patch that moves it to boot/fdt_support.c where it
> > belongs?
>
> And the issue is that when the command line is disabled NOTHING uses
> "working_fdt". We don't need it. It would be discarded by real
> platforms, if we moved it.
>
> To rephrase things another way, skimming the code, that
> bootm_find_images() does:
>         if (IS_ENABLED(CONFIG_CMD_FDT))
>                 set_working_fdt_addr(map_to_sysmem(images.ft_addr));
>
> And so we never set "working_fdt" when CMDLINE is off (since CMD_FDT is
> off) IS the bug, and that needs to be fixed. That's when you should
> figure out where "working_fdt" should be (and also maybe re-name it or
> the local variable named "working_fdt" that the pxe_utils.c code uses)
> and not before then.
>
> > Looking at the list of errors, we should just fix them. They all
> > indicate real problems with the structure of the code.
>
> No, they do not. The codebase assume that we discard unreachable
> functions. This allows us to NOT have to use #ifdefs and also not have
> to make otherwise unreasonable code splits.
>
> > Another example
> > is fastboot which needs a condition for CMDLINE.
>
> This is an example where yes, the functionality requires CMDLINE.
> Because reading the code shows that fastboot will literally run
> "bootcmd", and so requires that to be available.
>
> > > I honestly didn't realize sandbox hadn't had this critical feature
> > > enabled and I hope we haven't been doing too many odd shuffles of the
> > > codebase because of it.
> >
> > I'm a bit unsure where you are heading with this. Ultimate we don't
> > want to disable all the functionality when CMDLINE is disabled. I
> > think with the addition of 5-6 patches in your series you can fix it.
>
> Where I'm heading with this is to say that sandbox must work like a real
> platform does and discard unreachable code. You don't know what code
> is or is not really needed for functionality X and needs to be moved for
> it to not rely on what's in the command file vs elsewhere until you act
> like other platforms do.

It is remarkable that this sandbox 'feature' remained undiscovered for so long.

I'm going to let this thread die. I think I have said everything worth
saying at this point.

Regards,
Simon
