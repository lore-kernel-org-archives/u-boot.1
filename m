Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34FDD0D16A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 19:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168F840AA;
	Wed,  7 Jan 2026 20:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kAaR5n59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773B3840AA; Wed,  7 Jan 2026 20:02:58 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72780840A2
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 20:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so461210966b.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767812576; x=1768417376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vn6fTRiFz+iOhpc+CQXqQt9wOdhmHjiGsUAKVbE3lTI=;
 b=kAaR5n59skMCOzg5PInT1z2dhH8F6NPaJLa9sw9og2bcHG9tHvaKdUcghkzlslZdl0
 0heb0FDKuli0J7/Zm79kkUZS86Ajz+YiLSpU69ELaX1l8TXjIKBT6lVM0wtX4u3seP0I
 czGHXGvLmmVG49VFNHVbQedMxeN0xTL96mcpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767812576; x=1768417376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn6fTRiFz+iOhpc+CQXqQt9wOdhmHjiGsUAKVbE3lTI=;
 b=nEuLZi2zan9+PxlAO7HS6YveP8cUDquWvew3iK2VPl8TwriwpPgtKrZdmpp/f0+bUh
 s+/ISLSlprEJQIsh5qe8NM3Szmmmgcj1blH+qY5zgamELzhAVwsnhoIuKRXhUD71HV7D
 P2E4WcD/r5vq72B27VpcU2FfhIPUl85DOsnb/SDDmXqLwjmg7YUxT3EDdoDivzNg6Lde
 BUz7uJycC4HGA5E4oj8BpqENdSMNxsWPPVwX+em8zNjjwpZ3FubUhzBAyibkDA0Bl49K
 12vfTyOeEExzKu08XTehI7UqB+oCne81WfcQ4oRq8KrZNQC0x/3hEjvb7rUJmcm8q6Ov
 KCkQ==
X-Gm-Message-State: AOJu0YyODCtrKGMH9zMtkE0EVgPgs9nUXarn5K/HJQrb6AGsXk9iu4/n
 r/2YE4A+hNU1A5SFwSCudRW+McQYFEmekTNgtaV2F/6URVqEK0UgeaIGNjGN9EgIoep5JPhG8DB
 e2mSiyErXWZhRE80adXfrz2TgdQr5TrEgMDWAI+zO
X-Gm-Gg: AY/fxX6r5062VTjb8I77erSDLS24G1xkJiqWvV5+Wx02phZmQf5FfR3uEc6nitd57Ib
 WzBEULWsagNgDAXUVkuvRzrcwg0K75wnNqYXFNmzgOGqrEc+C24jjgEaDMCI1o2XUygnHECn1tD
 HgfVi6ozp1/9FfE8Ao0yKotDkYEu2lyG4GoD4jo0/uL6/1TNen7VHZoJ0y76F3VS/IijYahd7sp
 i8CUvGS1rS4trOQsJEiS9Iva22oSHK15zb+omqKskdqNEqIOm/t2x9BzAFhlb3cuJqYHA==
X-Google-Smtp-Source: AGHT+IFjQ01vt4VwUGkwN0KsUakhwcS9u3/uwnKMCl1g8zq437n9WllwA6YtjZZg1tPfkiTIGfBOULtREtIR4+iHesY=
X-Received: by 2002:a17:907:25c4:b0:b73:78f3:15c1 with SMTP id
 a640c23a62f3a-b8445414ff6mr325098066b.52.1767812575710; Wed, 07 Jan 2026
 11:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
In-Reply-To: <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Jan 2026 12:02:27 -0700
X-Gm-Features: AQt7F2qciGvMmZDrkO-B4o6_j1KMUga6W4tl_2qimkjzQUkh5ooHYze8J6bl7lI
Message-ID: <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Tue, 6 Jan 2026 at 19:42, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > This work-around dates from 2019 and grub 2.04 which is quite old. New
> > builds of grub don't have the problem and old boards presumably use an
> > older U-Boot, so don't need this.
> >
> > Drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >  configs/mt7623n_bpir2_defconfig |  1 -
> >  lib/efi_loader/Kconfig          | 10 ----------
> >  lib/efi_loader/efi_boottime.c   | 26 --------------------------
> >  3 files changed, 37 deletions(-)
> >
> > diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
> > index 404380558f2..d75168a72ed 100644
> > --- a/configs/mt7623n_bpir2_defconfig
> > +++ b/configs/mt7623n_bpir2_defconfig
> > @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
> >  CONFIG_TARGET_MT7623=y
> >  CONFIG_SYS_BOOTM_LEN=0x4000000
> >  CONFIG_SYS_LOAD_ADDR=0x84000000
> > -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> >  CONFIG_FIT=y
> >  CONFIG_FIT_VERBOSE=y
> >  CONFIG_DISTRO_DEFAULTS=y
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 13e44be1d06..5585c841c27 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
> >           hardware we can create a bounce buffer so that payloads don't have to
> >           worry about platform details.
> >
> > -config EFI_GRUB_ARM32_WORKAROUND
> > -       bool "Workaround for GRUB on 32bit ARM"
> > -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > -       default y
> > -       depends on ARM && !ARM64
> > -       help
> > -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
> > -         workaround currently is also needed on systems with caches that
> > -         cannot be managed via CP15.
>
> This also states that it's needed for systems that can't be managed by
> CP15, what systems are they, how are those platforms addressed?

I'm guessing that some systems have level2 caches with their own
software interface. I certainly have seen this with Tegra2/3, for
example.


>
> >  config EFI_ESRT
> >         bool "Enable the UEFI ESRT generation"
> >         depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 0bc66ee61a8..c31ee53cde6 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -2139,29 +2139,6 @@ error:
> >         return EFI_EXIT(ret);
> >  }
> >
> > -/**
> > - * efi_exit_caches() - fix up caches for EFI payloads if necessary
> > - */
> > -static void efi_exit_caches(void)
> > -{
> > -#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
> > -       /*
> > -        * Boooting Linux via GRUB prior to version 2.04 fails on 32bit ARM if
> > -        * caches are enabled.
> > -        *
> > -        * TODO:
> > -        * According to the UEFI spec caches that can be managed via CP15
> > -        * operations should be enabled. Caches requiring platform information
> > -        * to manage should be disabled. This should not happen in
> > -        * ExitBootServices() but before invoking any UEFI binary is invoked.
> > -        *
> > -        * We want to keep the current workaround while GRUB prior to version
> > -        * 2.04 is still in use.
> > -        */
> > -       cleanup_before_linux();
> > -#endif
> > -}
> > -
> >  /**
> >   * efi_exit_boot_services() - stop all boot services
> >   * @image_handle: handle of the loaded image
> > @@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> >         /* Patch out unsupported runtime function */
> >         efi_runtime_detach();
> >
> > -       /* Fix up caches for EFI payloads if necessary */
> > -       efi_exit_caches();
> > -
> >         /* Disable boot time services */
> >         systab.con_in_handle = NULL;
> >         systab.con_in = NULL;
> > --
> > 2.43.0
> >
