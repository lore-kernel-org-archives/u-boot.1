Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333FED16816
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C812C84166;
	Fri,  9 Jan 2026 12:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQHq3yq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC67A84166; Fri,  9 Jan 2026 12:34:58 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72BF83F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c9edf63a7so3416409a91.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958493; x=1768563293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6734qONbgDDyA4ddYgF5maT50A6Dp8oXHLB7a0stEn0=;
 b=IQHq3yq2ikSypbkULwBc704pdxrOrxvruza8PNF7D8+q7wli+dMmnafKbPr+CYF4l1
 fmO6UmyVCNyHEC2TIC9EOcCj+rIlvFqE+TbzEy94T/84w5Q3mDyO6ma2OgskMLM5mBGm
 E2psuOpyX6VuB5H5xX+fuwuaRM9nzIp3mpioI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958493; x=1768563293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6734qONbgDDyA4ddYgF5maT50A6Dp8oXHLB7a0stEn0=;
 b=B0+sP0JJ5RntXnLbDeR72x1r363226CUtHCs6q1U/171FrlKnETMpLDcV9nL56MNVF
 PnwnLeNpj8AeqJnH1E/t6/2JBP14YGngbJLUmX9H2EUNcmV1j5Bzox3J/1fBaGd3K9XK
 tgoGkfYe0F5fBWcabZBiDszy4if4gPOg7EGxTC+TtfkVl2c0Lx5qyp7hSw1QacpKb9fO
 zqHz7iptfCTvKfozLMYt3D9cg26HLronzrRXoA4gjuyiL7sJ+6US1G9e9zRKpcXyrV9X
 Dyih8/yYvDbfQqKySHW2BPYEtlc6m9Dsf0oAv7ITZbtQQL+8pS8ucYLjVASokN6YG4S3
 050w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRuA5M1AQJLmKioFfK64exkLlKLY3q8vYqJWp1+amhUiqnvHa9+1PVuMuCKQdAOd5sWMFcam0=@lists.denx.de
X-Gm-Message-State: AOJu0YyXb0dvmuj2bQFLByo63j5t3V9h2TVKc0t6ls685+QT2ruZ+Pyg
 dyKfpeA8iG8rEidZeQpMMs/VrqOTTf+XUHUnSdbC4JZg8Ssgydp8XtRx617l+ckp6E7xL/aOZal
 RpLMROanZ78MIt5UQVqVc/ylzgnUZXXGNB8XGyh94
X-Gm-Gg: AY/fxX4qCWOjq6U1visJKQuPgJYD2QWxnMREIEqBWR4GwDhzZgDOQgUSjjgKWwxGkFA
 klnnhJeDfCldXCHadwX/SVqJDQLl3gYz3ip7hUn/LrHaqF0ffsTkO4IShDR7WxopVZFu1zMIUvD
 N6yB7WWClQ+82mAVwngxx4ujy2YpE/qmyRhIRk6MAjL6CJmmYv0xETAhqu9XGw8sghe0fYoz2SP
 jsO8mqe7AKxnl95YkQk6JjMEsqsxagkRdtK6sK3L8eia+Uu7ty6d48SUv17epLIfGyQNA==
X-Google-Smtp-Source: AGHT+IGEPQj/0x35L73N7loEownPT7LPow4IEeTKdl00pZH5uWmUE8wngxocLJj4E2Xt7ZNJv922qD78Q+v8NeZCqqk=
X-Received: by 2002:a17:90b:4f44:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-34f68d0bc39mr10093526a91.17.1767958493412; Fri, 09 Jan 2026
 03:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
 <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
 <87jyxt9ps4.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87jyxt9ps4.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:34:38 -0700
X-Gm-Features: AQt7F2orF1IR8IS08NhKfmATX97rV0m1phwhVz3qRIy5fUNdCXW1r83i4NwHK9c
Message-ID: <CAFLszTgUw=TdheWVUzKLO+2+YECQv=19cJk3tdkFfsUhtRfyAQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com, 
 simon.glass@canonical.com, adrianox@gmail.com, xypron.glpk@gmx.de, 
 jan.kiszka@siemens.com, jerome.forissier@linaro.org, 
 marek.vasut+renesas@mailbox.org, mkorpershoek@kernel.org, 
 michal.simek@amd.com, ravi@prevas.dk, raymondmaoca@gmail.com, 
 ryder.lee@mediatek.com, weijie.gao@mediatek.com, me@ziyao.cc, 
 paul.liu@linaro.org
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

Hi Mark,

On Wed, 7 Jan 2026 at 12:38, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Wed, 7 Jan 2026 12:02:27 -0700
> >
> > On Tue, 6 Jan 2026 at 19:42, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > >
> > > > This work-around dates from 2019 and grub 2.04 which is quite old. New
> > > > builds of grub don't have the problem and old boards presumably use an
> > > > older U-Boot, so don't need this.
> > > >
> > > > Drop it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > ---
> > > >
> > > >  configs/mt7623n_bpir2_defconfig |  1 -
> > > >  lib/efi_loader/Kconfig          | 10 ----------
> > > >  lib/efi_loader/efi_boottime.c   | 26 --------------------------
> > > >  3 files changed, 37 deletions(-)
> > > >
> > > > diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
> > > > index 404380558f2..d75168a72ed 100644
> > > > --- a/configs/mt7623n_bpir2_defconfig
> > > > +++ b/configs/mt7623n_bpir2_defconfig
> > > > @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
> > > >  CONFIG_TARGET_MT7623=y
> > > >  CONFIG_SYS_BOOTM_LEN=0x4000000
> > > >  CONFIG_SYS_LOAD_ADDR=0x84000000
> > > > -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> > > >  CONFIG_FIT=y
> > > >  CONFIG_FIT_VERBOSE=y
> > > >  CONFIG_DISTRO_DEFAULTS=y
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 13e44be1d06..5585c841c27 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
> > > >           hardware we can create a bounce buffer so that payloads don't have to
> > > >           worry about platform details.
> > > >
> > > > -config EFI_GRUB_ARM32_WORKAROUND
> > > > -       bool "Workaround for GRUB on 32bit ARM"
> > > > -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > > > -       default y
> > > > -       depends on ARM && !ARM64
> > > > -       help
> > > > -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > > > -         workaround currently is also needed on systems with caches that
> > > > -         cannot be managed via CP15.
> > >
> > > This also states that it's needed for systems that can't be managed by
> > > CP15, what systems are they, how are those platforms addressed?
> >
> > I'm guessing that some systems have level2 caches with their own
> > software interface. I certainly have seen this with Tegra2/3, for
> > example.
>
> This is already being discussed in another thread on the mailing list
> started by Jan Kiszka:
>
>   https://lists.denx.de/pipermail/u-boot/2026-January/606817.html
>
> My suggestion would be to drop this patch from your set and let that
> thread run its course.

Yes I did see that and I was pleased to see that someone else was
interested in this topic.

Still, that thread does not actually include a patch. So let's see how
it pans out.

>
> > >
> > > >  config EFI_ESRT
> > > >         bool "Enable the UEFI ESRT generation"
> > > >         depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
> > > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > > index 0bc66ee61a8..c31ee53cde6 100644
> > > > --- a/lib/efi_loader/efi_boottime.c
> > > > +++ b/lib/efi_loader/efi_boottime.c
> > > > @@ -2139,29 +2139,6 @@ error:
> > > >         return EFI_EXIT(ret);
> > > >  }
> > > >
> > > > -/**
> > > > - * efi_exit_caches() - fix up caches for EFI payloads if necessary
> > > > - */
> > > > -static void efi_exit_caches(void)
> > > > -{
> > > > -#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
> > > > -       /*
> > > > -        * Boooting Linux via GRUB prior to version 2.04 fails on 32bit ARM if
> > > > -        * caches are enabled.
> > > > -        *
> > > > -        * TODO:
> > > > -        * According to the UEFI spec caches that can be managed via CP15
> > > > -        * operations should be enabled. Caches requiring platform information
> > > > -        * to manage should be disabled. This should not happen in
> > > > -        * ExitBootServices() but before invoking any UEFI binary is invoked.
> > > > -        *
> > > > -        * We want to keep the current workaround while GRUB prior to version
> > > > -        * 2.04 is still in use.
> > > > -        */
> > > > -       cleanup_before_linux();
> > > > -#endif
> > > > -}
> > > > -
> > > >  /**
> > > >   * efi_exit_boot_services() - stop all boot services
> > > >   * @image_handle: handle of the loaded image
> > > > @@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> > > >         /* Patch out unsupported runtime function */
> > > >         efi_runtime_detach();
> > > >
> > > > -       /* Fix up caches for EFI payloads if necessary */
> > > > -       efi_exit_caches();
> > > > -
> > > >         /* Disable boot time services */
> > > >         systab.con_in_handle = NULL;
> > > >         systab.con_in = NULL;
> > > > --
> > > > 2.43.0
> > > >
> >

Regards,
Simon
