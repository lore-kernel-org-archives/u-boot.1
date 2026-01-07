Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D0D0D16C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B320083A91;
	Wed,  7 Jan 2026 20:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="B4a0SW2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44D78405F; Wed,  7 Jan 2026 20:38:39 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F0D83A2B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 755f9eac-ec00-11f0-89d8-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 755f9eac-ec00-11f0-89d8-00505699b430;
 Wed, 07 Jan 2026 20:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=6DvZjyWWOIF3MTNlv6Ff8VSV6E3aNM9+cYciYxK3Tfw=;
 b=B4a0SW2MbmSO2lcRoy/7qH0KKFBQNQJ5YTIG8Rqqlh3Ghld7S6QDgKR864GkF4c260+Xzj+WFIMVA
 ICYqdCX6r8Nx0WSjYG266jDVNBqiJ3s5h287XLD7m15xzOlJMzCSUq0f0RwRG3mJxcd1xGLKMxa2Mk
 4ijzHQSoQOieE+lJX7Fxmxy6aJqrTQ2lvakzZlYpJwdBoRYC1s7N8u5ZQUDvI1cJgTn8oDZPygt2Qx
 O6RwgY3w3YcyRs4/3BFHgy906Hp2S9VfK/vOaXlM3l5QwXGuGxvDjCR3IKardwpt/vijzPNk1yuafU
 AgnIZZGY3AwJbyF0RcYAxZucpM8ZKPw==
X-KPN-MID: 33|4JAdcpM4IYnJSafkfgKf+wAi0BlZ4TUBMdQFZENC1wVFnXuasyCaHyxZLNC4nI4
 64zcm7GTEEAXyV45Afm0gJg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|47AmPqBm490eHaFAKsuvvQrmEf6THzQz4C8DmfazzCfHA0r/pmRfpxGXz/NEwzb
 IO9KVDOF722L/6O7O+Wa9+Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 74e363b5-ec00-11f0-86cc-005056998788;
 Wed, 07 Jan 2026 20:38:36 +0100 (CET)
Date: Wed, 07 Jan 2026 20:38:35 +0100
Message-Id: <87jyxt9ps4.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 simon.glass@canonical.com, adrianox@gmail.com,
 xypron.glpk@gmx.de, jan.kiszka@siemens.com,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 mkorpershoek@kernel.org, michal.simek@amd.com, ravi@prevas.dk,
 raymondmaoca@gmail.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, me@ziyao.cc, paul.liu@linaro.org
In-Reply-To: <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
 (message from Simon Glass on Wed, 7 Jan 2026 12:02:27 -0700)
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
 <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Wed, 7 Jan 2026 12:02:27 -0700
> 
> On Tue, 6 Jan 2026 at 19:42, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > This work-around dates from 2019 and grub 2.04 which is quite old. New
> > > builds of grub don't have the problem and old boards presumably use an
> > > older U-Boot, so don't need this.
> > >
> > > Drop it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > ---
> > >
> > >  configs/mt7623n_bpir2_defconfig |  1 -
> > >  lib/efi_loader/Kconfig          | 10 ----------
> > >  lib/efi_loader/efi_boottime.c   | 26 --------------------------
> > >  3 files changed, 37 deletions(-)
> > >
> > > diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
> > > index 404380558f2..d75168a72ed 100644
> > > --- a/configs/mt7623n_bpir2_defconfig
> > > +++ b/configs/mt7623n_bpir2_defconfig
> > > @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
> > >  CONFIG_TARGET_MT7623=y
> > >  CONFIG_SYS_BOOTM_LEN=0x4000000
> > >  CONFIG_SYS_LOAD_ADDR=0x84000000
> > > -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> > >  CONFIG_FIT=y
> > >  CONFIG_FIT_VERBOSE=y
> > >  CONFIG_DISTRO_DEFAULTS=y
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 13e44be1d06..5585c841c27 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
> > >           hardware we can create a bounce buffer so that payloads don't have to
> > >           worry about platform details.
> > >
> > > -config EFI_GRUB_ARM32_WORKAROUND
> > > -       bool "Workaround for GRUB on 32bit ARM"
> > > -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > > -       default y
> > > -       depends on ARM && !ARM64
> > > -       help
> > > -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > > -         workaround currently is also needed on systems with caches that
> > > -         cannot be managed via CP15.
> >
> > This also states that it's needed for systems that can't be managed by
> > CP15, what systems are they, how are those platforms addressed?
> 
> I'm guessing that some systems have level2 caches with their own
> software interface. I certainly have seen this with Tegra2/3, for
> example.

This is already being discussed in another thread on the mailing list
started by Jan Kiszka:

  https://lists.denx.de/pipermail/u-boot/2026-January/606817.html

My suggestion would be to drop this patch from your set and let that
thread run its course.

> >
> > >  config EFI_ESRT
> > >         bool "Enable the UEFI ESRT generation"
> > >         depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
> > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > index 0bc66ee61a8..c31ee53cde6 100644
> > > --- a/lib/efi_loader/efi_boottime.c
> > > +++ b/lib/efi_loader/efi_boottime.c
> > > @@ -2139,29 +2139,6 @@ error:
> > >         return EFI_EXIT(ret);
> > >  }
> > >
> > > -/**
> > > - * efi_exit_caches() - fix up caches for EFI payloads if necessary
> > > - */
> > > -static void efi_exit_caches(void)
> > > -{
> > > -#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
> > > -       /*
> > > -        * Boooting Linux via GRUB prior to version 2.04 fails on 32bit ARM if
> > > -        * caches are enabled.
> > > -        *
> > > -        * TODO:
> > > -        * According to the UEFI spec caches that can be managed via CP15
> > > -        * operations should be enabled. Caches requiring platform information
> > > -        * to manage should be disabled. This should not happen in
> > > -        * ExitBootServices() but before invoking any UEFI binary is invoked.
> > > -        *
> > > -        * We want to keep the current workaround while GRUB prior to version
> > > -        * 2.04 is still in use.
> > > -        */
> > > -       cleanup_before_linux();
> > > -#endif
> > > -}
> > > -
> > >  /**
> > >   * efi_exit_boot_services() - stop all boot services
> > >   * @image_handle: handle of the loaded image
> > > @@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> > >         /* Patch out unsupported runtime function */
> > >         efi_runtime_detach();
> > >
> > > -       /* Fix up caches for EFI payloads if necessary */
> > > -       efi_exit_caches();
> > > -
> > >         /* Disable boot time services */
> > >         systab.con_in_handle = NULL;
> > >         systab.con_in = NULL;
> > > --
> > > 2.43.0
> > >
> 
